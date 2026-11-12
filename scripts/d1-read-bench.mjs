// LOCAL ONLY: measures D1 "rows read" of the real Worker against a local Miniflare D1 replica.
// Never touches the production database: the replica is built from this repository's own SQL files with
// `wrangler d1 execute --local --persist-to <dir>`, and the platform proxy is started with remoteBindings:false.
//
//   node --import ./tests/ts-loader.mjs scripts/d1-read-bench.mjs pages [worker.ts]
//   node --import ./tests/ts-loader.mjs scripts/d1-read-bench.mjs day [worker.ts] [colos]
//
// "pages": rows read per page view (first view, then a repeat view).
// "day":   one simulated day of traffic (page views plus the API calls their scripts make), spread over N data centers
//          with a separate Cache API each and isolates that are dropped after 5 idle minutes. Uses a fixed random seed.
import { getPlatformProxy } from 'wrangler';
import { execFileSync } from 'node:child_process';
import { existsSync, mkdirSync, readFileSync, readdirSync, writeFileSync } from 'node:fs';
import { createRequire } from 'node:module';
import { resolve } from 'node:path';
import { pathToFileURL } from 'node:url';

const [mode = 'pages', workerPath = 'src/final-entry.ts', colosArg = '5'] = process.argv.slice(2);
const STATE = resolve('.wrangler/d1-read-bench');

function buildReplica() {
  if (existsSync(resolve(STATE, 'v3'))) return;
  mkdirSync(STATE, { recursive: true });
  const parts = [readFileSync('migrations/0001_init.sql', 'utf8'), readFileSync('seed.sql', 'utf8')];
  for (const name of readdirSync('migrations').sort()) if (/^\d{4}_/.test(name) && !name.startsWith('0001_')) parts.push(readFileSync('migrations/' + name, 'utf8'));
  const file = resolve(STATE, 'replica.sql');
  writeFileSync(file, parts.join('\n;\n').replace(/^PRAGMA foreign_keys = ON;$/gm, ''));
  const pkg = createRequire(import.meta.url).resolve('wrangler/package.json');
  const bin = resolve(pkg, '..', JSON.parse(readFileSync(pkg, 'utf8')).bin.wrangler);
  execFileSync(process.execPath, [bin, 'd1', 'execute', 'inu-taikenki', '--local', '--persist-to', STATE, '--file', file], { stdio: 'ignore' });
}
buildReplica();

const { default: worker } = await import(pathToFileURL(resolve(workerPath)).href);
const { env, dispose } = await getPlatformProxy({ configPath: 'wrangler.jsonc', persist: { path: resolve(STATE, 'v3') }, remoteBindings: false });

let rowsRead = 0, statements = 0;
// A new wrapper object stands for a new isolate (the cache keeps isolate memory per binding object).
const isolateDb = () => ({ prepare(sql) { let values = []; const st = { bind(...v) { values = v; return st; },
  async all() { const r = await env.DB.prepare(sql).bind(...values).all(); rowsRead += r.meta.rows_read; statements++; return r; },
  async first() { const r = await env.DB.prepare(sql).bind(...values).all(); rowsRead += r.meta.rows_read; statements++; return r.results[0] ?? null; } }; return st; } });

let now = Date.parse('2026-11-10T00:00:00Z');
Date.now = () => now;
function colocache() {
  const store = new Map();
  return { async match(req) { const hit = store.get(new Request(req).url); if (!hit || hit.expires <= now) return undefined; return new Response(hit.body, { headers: hit.headers }); },
    async put(req, res) { const age = Number((res.headers.get('cache-control') || '').match(/max-age=(\d+)/)?.[1] || 0); store.set(new Request(req).url, { body: await res.text(), headers: [...res.headers], expires: now + age * 1000 }); } };
}
const ASSETS = { async fetch(req) { let p = new URL(req.url).pathname; if (p === '/') p = '/index.html'; if (!p.split('/').at(-1).includes('.')) p += '.html'; try { return new Response(readFileSync(resolve('public', '.' + p)), { headers: { 'content-type': 'text/html; charset=utf-8' } }); } catch { return new Response('nf', { status: 404 }); } } };
const META = { CF_VERSION_METADATA: { id: 'bench-version' } };
async function get(path, db) { const r = await worker.fetch(new Request('https://inu-taikenki.com' + path), { DB: db, ASSETS, ...META }); await r.text(); return r.status; }

const CATEGORY_PAGES = { '/pet-dryer': 'pet-dryer', '/auto-feeder': 'auto-feeder', '/dog-clipper': 'dog-clipper', '/brush-slicker': 'brush-slicker', '/brush-pin': 'brush-pin', '/brush-undercoat': 'brush-undercoat', '/brush-comb': 'brush-comb', '/dog-nail-grinder': 'nail-grinder', '/dog-nail-clipper': 'nail-clipper', '/dog-shampoo': 'dog-shampoo', '/dog-conditioner': 'dog-conditioner', '/dog-toothbrush': 'dog-toothbrush', '/dog-toothpaste': 'dog-toothpaste', '/dog-dental-chew': 'dog-dental-chew', '/dog-ear-cleaner': 'dog-ear-cleaner', '/dog-harness': 'dog-harness' };

if (mode === 'pages') {
  globalThis.caches = { default: colocache() };
  const db = isolateDb();
  const pages = ['/', '/about', '/editorial-policy', '/review-search', '/review-insights', '/dog-size', '/breed-toy-poodle', '/brush-pin', '/dog-harness', '/api/reviews/stats', '/api/reviews?limit=12', '/api/reviews/groups?size=small&limit=10&offset=0', '/api/products?limit=100&category=brush-pin&offset=0'];
  console.log('page'.padEnd(52), 'first view', 'repeat view');
  for (const page of pages) {
    const out = [];
    for (let i = 0; i < 2; i++) { rowsRead = 0; await get(page, db); out.push(rowsRead); }
    console.log(page.padEnd(52), String(out[0]).padStart(10), String(out[1]).padStart(11));
  }
} else {
  // Mix calibrated to the 2026-11-10 production log: ~412 views/day that show live totals, plus the scripts' API calls.
  let seed = 20261110; const rand = () => ((seed = (seed * 1103515245 + 12345) % 2147483648) / 2147483648);
  const pick = (list) => list[Math.floor(rand() * list.length)];
  const views = [];
  const sizes = ['small', 'medium', 'large'], categories = Object.values(CATEGORY_PAGES);
  for (let i = 0; i < 520; i++) {
    const r = rand(); let calls;
    if (r < 0.30) calls = ['/'];
    else if (r < 0.42) {
      const filtered = rand() < 0.5;
      const params = filtered ? new URLSearchParams({ category: pick(categories), size: pick(sizes), coat: '', q: '', limit: '12' }) : new URLSearchParams({ category: '', size: '', coat: '', q: '', limit: '12' });
      calls = ['/review-search', '/api/reviews?' + params];
    } else if (r < 0.46) calls = ['/review-insights', '/api/reviews/stats?'];
    else if (r < 0.52) { const size = pick(sizes); calls = ['/dog-size' + (size === 'small' ? '' : '?size=' + size), `/api/reviews/groups?size=${size}&category=&limit=10&offset=0`]; }
    else if (r < 0.55) calls = ['/breed-toy-poodle', '/api/reviews/groups?breed=' + encodeURIComponent('トイプードル') + '&limit=6&offset=0'];
    else if (r < 0.60) calls = [pick(['/about', '/editorial-policy'])];
    else { const [page, category] = pick(Object.entries(CATEGORY_PAGES)); calls = [page, `/api/products?limit=100&category=${category}&offset=0`]; }
    views.push({ at: Math.floor(rand() * 86400000), calls });
  }
  views.sort((a, b) => a.at - b.at);
  const colos = Math.max(1, Number(colosArg));
  // Traffic share per data center falls off like 1/rank (a couple of large Japanese PoPs, then crawler regions).
  const weights = Array.from({ length: colos }, (_, i) => 1 / (i + 1)); const sum = weights.reduce((a, b) => a + b, 0);
  const state = weights.map(() => ({ cache: colocache(), db: isolateDb(), last: -Infinity }));
  const start = now;
  for (const view of views) {
    let x = rand() * sum, c = 0; while (x > weights[c] && c < colos - 1) x -= weights[c++];
    const s = state[c]; now = start + view.at;
    if (now - s.last > 5 * 60000) s.db = isolateDb();
    s.last = now; globalThis.caches = { default: s.cache };
    for (const call of view.calls) await get(call, s.db);
  }
  console.log(JSON.stringify({ worker: workerPath, colos, page_views: views.length, requests: views.reduce((n, v) => n + v.calls.length, 0), statements, rows_read: rowsRead }));
}
await dispose();
