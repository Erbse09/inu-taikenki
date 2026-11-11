// Read-side cache for D1 results (headline totals, source breakdown, product overviews, review API JSON).
//
// Why: the free D1 plan allows 5,000,000 rows read per day. Before this cache every page view re-counted
// all reviews (4,954 rows), and the 10-minute fragment cache lived in a single data center only, so the
// same aggregates were rebuilt again and again (2026-11-10: 4.54M rows from about 1,100 SQL statements).
//
// How an entry stays correct:
// 1. Every entry carries the "data version" it was built from. The data version is a 144-row fingerprint
//    (newest review id, newest review_sources / review_attributes rowid, and a checksum over products).
//    Any added review, source record, attribute or product change gives a new fingerprint.
//    The fingerprint is re-read from D1 at most every VERSION_CHECK_MS per data center (and per isolate).
// 2. An entry is never used for more than HARD_MAX_MS (24 h) even if the fingerprint did not change, so edits the
//    fingerprint cannot see (an UPDATE of an existing summary/source_url, which release-data/README.md does not
//    allow anyway: existing rows are never updated) are picked up within that bound, or at once by any deploy (3.).
// 3. Keys include the deployed Worker version (CF_VERSION_METADATA), so a deploy never serves output that
//    an older code version rendered. Without that binding (tests, Preview) entries live only VERSION_CHECK_MS,
//    which is the same freshness as the former 10-minute fragment cache.
// 4. If D1 fails, an entry up to STALE_IF_ERROR_MS old is served instead of an error; if the cache fails,
//    D1 is read directly (every cache operation is optional and wrapped in try/catch).
//
// Only SELECT statements are issued, so this also passes the Preview read-only wrapper.

interface Statement {
  bind(...values: (string | number | null)[]): Statement;
  all<T>(): Promise<{ results?: T[] }>;
}
export interface CacheDB { prepare(sql: string): Statement; }

export const VERSION_CHECK_MS = 10 * 60 * 1000;
export const HARD_MAX_MS = 24 * 60 * 60 * 1000;
export const STALE_IF_ERROR_MS = 24 * 60 * 60 * 1000;
const MEMORY_MAX_ENTRIES = 400;
const MEMORY_MAX_CHARS = 16 * 1024 * 1024;

// One scan of products (141 rows in Nov 2026) plus three index-end lookups: 144 rows read in total.
export const DATA_VERSION_SQL = "SELECT (SELECT MAX(id) FROM reviews) AS r, (SELECT MAX(rowid) FROM review_sources) AS s, (SELECT MAX(rowid) FROM review_attributes) AS a, x.n, x.act, x.cat, x.nm, x.aff, x.asin FROM (SELECT COUNT(*) AS n, SUM(active) AS act, SUM(LENGTH(category) * active) AS cat, SUM(LENGTH(name)) AS nm, SUM(LENGTH(COALESCE(affiliate_url, ''))) AS aff, SUM(LENGTH(COALESCE(asin, ''))) AS asin FROM products) x";

type Entry = { v: string; t: number; d: unknown };
type VersionEntry = { v: string; t: number };

// Isolate memory is kept per database binding object, so results of one database are never served for another.
type Store = { entries: Map<string, { entry: Entry; size: number }>; chars: number; versions: Map<string, VersionEntry> };
let clock = () => Date.now();
let stores = new WeakMap<object, Store>();

/** Test hooks only. */
export function __resetD1CacheForTests(now?: () => number) {
  stores = new WeakMap();
  clock = now ?? (() => Date.now());
}

function storeOf(ctx: CacheContext): Store {
  let store = stores.get(ctx.db);
  if (!store) {
    store = { entries: new Map(), chars: 0, versions: new Map() };
    stores.set(ctx.db, store);
  }
  return store;
}

export type CacheContext = {
  db: CacheDB;
  origin: string;
  namespace: string;
  hardMaxMs: number;
  version?: Promise<string | null>;
  local: Map<string, Promise<unknown>>;
};

export function createCacheContext(request: Request, env: { DB: CacheDB; CF_VERSION_METADATA?: { id?: string } }): CacheContext {
  const workerVersion = env.CF_VERSION_METADATA?.id;
  const safeVersion = typeof workerVersion === "string" && /^[A-Za-z0-9-]{1,64}$/.test(workerVersion) ? workerVersion : "";
  return {
    db: env.DB,
    origin: new URL(request.url).origin,
    namespace: safeVersion ? `w-${safeVersion}` : "w-unversioned",
    hardMaxMs: safeVersion ? HARD_MAX_MS : VERSION_CHECK_MS,
    local: new Map(),
  };
}

function defaultCache(): Cache | undefined {
  try {
    return (globalThis as { caches?: { default?: Cache } }).caches?.default;
  } catch {
    return undefined;
  }
}

function cacheRequest(ctx: CacheContext, key: string) {
  return new Request(`${ctx.origin}/__d1cache/v1/${ctx.namespace}/${encodeURIComponent(key)}`);
}

async function cacheRead<T>(ctx: CacheContext, key: string): Promise<T | null> {
  try {
    const hit = await defaultCache()?.match(cacheRequest(ctx, key));
    if (!hit) return null;
    return await hit.json() as T;
  } catch {
    return null;
  }
}

async function cacheWrite(ctx: CacheContext, key: string, value: unknown) {
  try {
    const cache = defaultCache();
    if (!cache) return;
    await cache.put(cacheRequest(ctx, key), new Response(JSON.stringify(value), {
      headers: {
        "content-type": "application/json; charset=utf-8",
        // Kept long enough for stale-if-error; whether an entry is still usable is decided by its version and age.
        "cache-control": `public, max-age=${Math.floor(STALE_IF_ERROR_MS / 1000)}`,
      },
    }));
  } catch { /* cache is optional */ }
}

function memoryGet(store: Store, fullKey: string): Entry | null {
  const hit = store.entries.get(fullKey);
  if (!hit) return null;
  store.entries.delete(fullKey);
  store.entries.set(fullKey, hit);
  return hit.entry;
}

function memorySet(store: Store, fullKey: string, entry: Entry) {
  let size = 64;
  try { size += JSON.stringify(entry.d)?.length ?? 0; } catch { return; }
  if (size > MEMORY_MAX_CHARS / 4) return;
  const old = store.entries.get(fullKey);
  if (old) { store.chars -= old.size; store.entries.delete(fullKey); }
  store.entries.set(fullKey, { entry, size });
  store.chars += size;
  while (store.entries.size > MEMORY_MAX_ENTRIES || store.chars > MEMORY_MAX_CHARS) {
    const oldest = store.entries.keys().next().value as string | undefined;
    if (oldest === undefined) break;
    store.chars -= store.entries.get(oldest)!.size;
    store.entries.delete(oldest);
  }
}

async function loadDataVersion(ctx: CacheContext): Promise<string | null> {
  const fullKey = `${ctx.origin}|${ctx.namespace}|data-version`;
  const now = clock();
  const versions = storeOf(ctx).versions;
  const mem = versions.get(fullKey);
  if (mem && now - mem.t >= 0 && now - mem.t < VERSION_CHECK_MS) return mem.v;
  const shared = await cacheRead<VersionEntry>(ctx, "data-version");
  if (shared && typeof shared.v === "string" && now - shared.t >= 0 && now - shared.t < VERSION_CHECK_MS) {
    versions.set(fullKey, shared);
    return shared.v;
  }
  try {
    const row = (await ctx.db.prepare(DATA_VERSION_SQL).all<Record<string, unknown>>()).results?.[0];
    if (!row) return null;
    const entry = { v: JSON.stringify(row), t: now };
    versions.set(fullKey, entry);
    await cacheWrite(ctx, "data-version", entry);
    return entry.v;
  } catch {
    return null;
  }
}

/** The data version for this request (read once per request). null when D1 cannot be read. */
export function dataVersion(ctx: CacheContext): Promise<string | null> {
  ctx.version ??= loadDataVersion(ctx);
  return ctx.version;
}

export type VersionedOptions<T> = {
  /** Return false for a value that must not be stored (e.g. a partial result after a failed sub-query). */
  cacheable?: (value: T) => boolean;
  /** Return true when a recent stored entry (up to STALE_IF_ERROR_MS old) should be shown instead of this fresh value. */
  preferStale?: (value: T) => boolean;
};

/**
 * Returns the value for `key`, computing it from D1 only when no entry matches the current data version
 * (or the entry is older than the hard maximum). Within one request the same key is computed once.
 */
export function versioned<T>(ctx: CacheContext, key: string, compute: () => Promise<T>, options: VersionedOptions<T> = {}): Promise<T> {
  const existing = ctx.local.get(key) as Promise<T> | undefined;
  if (existing) return existing;
  const pending = resolveVersioned(ctx, key, compute, options);
  ctx.local.set(key, pending);
  return pending;
}

async function resolveVersioned<T>(ctx: CacheContext, key: string, compute: () => Promise<T>, options: VersionedOptions<T>): Promise<T> {
  const fullKey = `${ctx.origin}|${ctx.namespace}|${key}`;
  const version = await dataVersion(ctx);
  const now = clock();
  const usable = (entry: Entry | null, maxAge: number) => !!entry && typeof entry.v === "string" && now - entry.t >= 0 && now - entry.t < maxAge;
  const store = storeOf(ctx);
  let entry = memoryGet(store, fullKey);
  if (!(version !== null && entry?.v === version && usable(entry, ctx.hardMaxMs))) {
    const shared = await cacheRead<Entry>(ctx, key);
    if (shared && (!entry || shared.t > entry.t)) entry = shared;
  }
  if (version !== null && entry && entry.v === version && usable(entry, ctx.hardMaxMs)) {
    memorySet(store, fullKey, entry);
    return entry.d as T;
  }
  // D1 could not even return the fingerprint: prefer a recent entry over an error.
  if (version === null && usable(entry, STALE_IF_ERROR_MS)) return entry!.d as T;
  let value: T;
  try {
    value = await compute();
  } catch (error) {
    if (usable(entry, STALE_IF_ERROR_MS)) return entry!.d as T;
    throw error;
  }
  if (version !== null && (options.cacheable?.(value) ?? true)) {
    const fresh: Entry = { v: version, t: now, d: value };
    memorySet(store, fullKey, fresh);
    await cacheWrite(ctx, key, fresh);
  } else if (options.preferStale?.(value) && usable(entry, STALE_IF_ERROR_MS)) {
    // The fresh computation failed part-way; a recent complete entry is better than a partial one.
    return entry!.d as T;
  }
  return value;
}
