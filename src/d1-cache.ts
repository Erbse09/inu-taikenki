// Read-side cache for D1 results (headline totals, source breakdown, product overviews, review API JSON).
//
// Why: the free D1 plan allows 5,000,000 rows read per day. Before this cache every page view re-counted
// all reviews (4,954 rows), and the 10-minute fragment cache lived in a single data center only, so the
// same aggregates were rebuilt again and again (2026-11-10: 4.54M rows from about 1,100 SQL statements).
//
// How an entry stays correct:
// 1. Every entry carries the "data version" it was built from. The data version is read with 144 rows:
//    - the newest reviews.id and the newest review_sources / review_attributes rowid (3 rows), which grow whenever a
//      review or a source record is added (reviews.id is AUTOINCREMENT; a new rowid is always above the current maximum);
//    - every column of every product row (141 rows), hashed with SHA-256 after sorting by id. Any change to any
//      product value (name, category, asin, affiliate_url, active, ...), however small and even when lengths or
//      totals stay the same, gives a different version. Reading the whole small table costs the same rows as an aggregate.
//    The data version is re-read from D1 at most every VERSION_CHECK_MS per data center (and per isolate).
// 2. Changes the data version is NOT guaranteed to see: an UPDATE or DELETE of existing reviews / review_sources rows
//    that leaves the newest ids unchanged (summary, dog_breed, dog_size, coat_type, needs, source_type, source_url,
//    product_id; release-data/README.md does not allow this: existing rows are never updated). An update of dog_size /
//    coat_type / needs usually moves the newest review_attributes rowid (the 0018 trigger re-inserts the attributes),
//    but not when the edited review already owned the highest rowids, so it is not relied on.
//    An entry is never used for more than HARD_MAX_MS (24 h), so such changes appear within 24 h at the latest,
//    or at once after any deploy (3.).
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

// Three index-end lookups (3 rows read) and one scan of products (141 rows in Nov 2026): 144 rows read in total.
export const DATA_VERSION_SQL = "SELECT (SELECT MAX(id) FROM reviews) AS r, (SELECT MAX(rowid) FROM review_sources) AS s, (SELECT MAX(rowid) FROM review_attributes) AS a";
// Every column, so a product column added later is covered without touching this file.
export const PRODUCTS_VERSION_SQL = "SELECT * FROM products";

// Deterministic text for a value: object keys sorted, so column order never changes the result.
function canonical(value: unknown): string {
  if (value === null || typeof value !== "object") return JSON.stringify(value ?? null);
  if (Array.isArray(value)) return `[${value.map(canonical).join(",")}]`;
  const object = value as Record<string, unknown>;
  return `{${Object.keys(object).sort().map((key) => `${JSON.stringify(key)}:${canonical(object[key])}`).join(",")}}`;
}

async function sha256Hex(text: string): Promise<string> {
  const digest = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(text));
  return [...new Uint8Array(digest)].map((byte) => byte.toString(16).padStart(2, "0")).join("");
}

/** Fingerprint of the full content of the products table (order-independent: rows are sorted by id first). */
export async function productsFingerprint(rows: Array<Record<string, unknown>>): Promise<string> {
  const sorted = rows.map(canonical).map((text, i) => [String(rows[i].id ?? ""), text] as const)
    .sort((a, b) => (a[0] < b[0] ? -1 : a[0] > b[0] ? 1 : a[1] < b[1] ? -1 : a[1] > b[1] ? 1 : 0));
  return sha256Hex(`${sorted.length}\n${sorted.map(([, text]) => text).join("\n")}`);
}

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
  /**
   * Set when anything served in this request is not a fresh, complete result for the current data version
   * (D1 or the fingerprint unreadable, a stale entry shown after an error, a partial or uncacheable result).
   * A page built in such a request is never stored by writePage.
   */
  degraded: boolean;
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
    degraded: false,
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
  try { size += typeof entry.d === "string" ? entry.d.length : JSON.stringify(entry.d)?.length ?? 0; } catch { return; }
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
    const products = (await ctx.db.prepare(PRODUCTS_VERSION_SQL).all<Record<string, unknown>>()).results;
    if (!row || !Array.isArray(products)) return null;
    const entry = { v: `${canonical(row)}|${await productsFingerprint(products)}`, t: now };
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
  let fromMemory = !!entry;
  if (!(version !== null && entry?.v === version && usable(entry, ctx.hardMaxMs))) {
    const shared = await cacheRead<Entry>(ctx, key);
    if (shared && (!entry || shared.t > entry.t)) { entry = shared; fromMemory = false; }
  }
  if (version !== null && entry && entry.v === version && usable(entry, ctx.hardMaxMs)) {
    // memoryGet already moved a memory hit to the newest LRU position; only a Cache API hit needs storing.
    if (!fromMemory) memorySet(store, fullKey, entry);
    return entry.d as T;
  }
  // D1 could not even return the fingerprint: prefer a recent entry over an error.
  if (version === null && usable(entry, STALE_IF_ERROR_MS)) { ctx.degraded = true; return entry!.d as T; }
  let value: T;
  try {
    value = await compute();
  } catch (error) {
    ctx.degraded = true;
    if (usable(entry, STALE_IF_ERROR_MS)) return entry!.d as T;
    throw error;
  }
  if (version !== null && (options.cacheable?.(value) ?? true)) {
    const fresh: Entry = { v: version, t: now, d: value };
    memorySet(store, fullKey, fresh);
    await cacheWrite(ctx, key, fresh);
  } else {
    ctx.degraded = true;
    // The fresh computation failed part-way; a recent complete entry is better than a partial one.
    if (options.preferStale?.(value) && usable(entry, STALE_IF_ERROR_MS)) return entry!.d as T;
  }
  return value;
}

// ---- Finished HTML pages ----
// A page is fully determined by its path + query, the deployed Worker version (code and static assets are uploaded
// together, and the version id is part of every key) and the data it read. Storing the finished page lets a newly
// started isolate skip the whole HTML rewrite pipeline, which is most of its CPU time on a first request.
// Rules are the same as for every other entry: the data version is checked at most every VERSION_CHECK_MS,
// no entry lives longer than ctx.hardMaxMs, and nothing built in a degraded request is ever stored.

export type StoredPage = { status: number; statusText?: string; headers: Array<[string, string]>; body: string };
/** Version stamp for a page that read no data at all: it depends only on the deployed version and the URL. */
const NO_DATA = "no-data";

/**
 * A stored page for `key`, or null. A page that read no data is served without touching D1; a data page is served
 * only while its data version is current. Never returns a stale page: on any doubt the caller builds the page again,
 * with the same fallbacks (and stale-if-error per fragment) as without this cache.
 */
export async function readPage(ctx: CacheContext, key: string): Promise<StoredPage | null> {
  const fullKey = `${ctx.origin}|${ctx.namespace}|${key}`;
  const store = storeOf(ctx);
  const now = clock();
  const fresh = (entry: Entry | null) => !!entry && typeof entry.v === "string" && now - entry.t >= 0 && now - entry.t < ctx.hardMaxMs;
  let entry = memoryGet(store, fullKey);
  const fromMemory = fresh(entry);
  if (!fromMemory) entry = await cacheRead<Entry>(ctx, key);
  if (!fresh(entry)) return null;
  if (entry!.v !== NO_DATA) {
    const version = await dataVersion(ctx);
    if (version === null || entry!.v !== version) return null;
  }
  if (!fromMemory) memorySet(store, fullKey, entry!);
  return entry!.d as StoredPage;
}

/** Stores a page built in this request, unless anything in the request was degraded. */
export async function writePage(ctx: CacheContext, key: string, page: StoredPage): Promise<void> {
  if (ctx.degraded) return;
  let stamp = NO_DATA;
  if (ctx.version) {
    const version = await ctx.version;
    if (version === null || ctx.degraded) return;
    stamp = version;
  }
  const entry: Entry = { v: stamp, t: clock(), d: page };
  memorySet(storeOf(ctx), `${ctx.origin}|${ctx.namespace}|${key}`, entry);
  await cacheWrite(ctx, key, entry);
}
