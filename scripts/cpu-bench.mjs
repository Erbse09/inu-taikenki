// LOCAL ONLY: CPU time of the real Worker per route, in four isolate states. Never touches a remote database:
// the data is an in-process SQLite replica built from this repository's own SQL (seed + migrations).
//
//   node --import ./tests/ts-loader.mjs scripts/cpu-bench.mjs [path/to/final-entry.ts]
//
// Each "cold" sample runs in a new Node process, because a new Workers isolate also starts with cold JIT.
// Node's own web-platform internals (undici Request/Response, URL, crypto.subtle) are warmed first, since workerd
// implements those natively; what remains is the app's own first-execution cost. SQLite time is subtracted: in
// production D1 runs outside the isolate (I/O wait, not CPU time). These are local Node measurements, not Cloudflare's.
//
//   cold     new isolate, empty Cache API           (first request in a data center after a deploy or a data change)
//   coldhit  new isolate, Cache API already filled  (a new isolate in a data center that already served the page)
//   warm     same isolate, repeated request
//   recheck  same isolate, 10 minutes later         (data-version check, incl. the SHA-256 of products)
import { spawnSync } from "node:child_process";
import { existsSync, mkdirSync, readdirSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { resolve } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

const SELF = fileURLToPath(import.meta.url);
const ROOT = resolve(SELF, "../..");
const STATE = resolve(ROOT, ".wrangler/cpu-bench");
const REPLICA = resolve(STATE, "replica.db");
const ROUTES = ["/", "/about", "/editorial-policy", "/review-search", "/review-insights", "/dog-size", "/breed-toy-poodle", "/brush-pin",
  "/pet-dryer", "/dog-harness", "/auto-feeder", "/dog-brushing-dislike", "/privacy", "/api/reviews/stats", "/api/reviews?limit=12",
  "/api/products?limit=100&category=brush-pin&offset=0", "/brush-pin.html", "/no-such-page"];
const COLD_RUNS = 7, WARM_RUNS = 40, RECHECK_RUNS = 20;

async function sample(workerPath, scenario, path, cacheFile) {
  // Warm Node's platform internals without touching application code.
  { const r = new Request("https://x.test/a.html?b=1", { headers: { accept: "text/html" } }); new URL(r.url).searchParams.get("b");
    const res = new Response("<html>x</html>", { headers: { "content-type": "text/html" } }); await res.text(); await new Response('{"a":1}').json();
    Response.redirect("https://x.test/", 301); new Headers(res.headers).forEach(() => {});
    await crypto.subtle.digest("SHA-256", new TextEncoder().encode("x")); "aXb".replace(/X/g, "y"); new URLSearchParams("a=1").toString(); }
  const { default: worker } = await import(pathToFileURL(resolve(workerPath)).href);
  const { DatabaseSync } = await import("node:sqlite");
  const db = new DatabaseSync(REPLICA, { readOnly: true });
  let dbCpu = 0;
  const timed = (fn) => { const s = process.cpuUsage(); try { return fn(); } finally { const d = process.cpuUsage(s); dbCpu += d.user + d.system; } };
  const mkDB = () => ({ prepare(sql) { let v = []; const st = { bind(...x) { v = x; return st; },
    async all() { return { results: timed(() => db.prepare(sql).all(...v)) }; }, async first() { return timed(() => db.prepare(sql).get(...v)) ?? null; } }; return st; } });
  const files = new Map();
  const ASSETS = { async fetch(req) { let p = new URL(req.url).pathname; if (p === "/") p = "/index.html"; if (!p.split("/").at(-1).includes(".")) p += ".html";
    const f = resolve(ROOT, "public", "." + p); if (!files.has(f)) files.set(f, existsSync(f) ? readFileSync(f) : null);
    const b = files.get(f); return b ? new Response(b, { headers: { "content-type": p.endsWith(".html") ? "text/html; charset=utf-8" : "text/plain" } }) : new Response("nf", { status: 404 }); } };
  let now = Date.parse("2026-11-14T00:00:00Z"); Date.now = () => now;
  const store = new Map(scenario === "coldhit" && existsSync(cacheFile) ? JSON.parse(readFileSync(cacheFile, "utf8")) : []);
  globalThis.caches = { default: {
    async match(r) { const h = store.get(new Request(r).url); return h ? new Response(h.b, { headers: h.h }) : undefined; },
    async put(r, res) { store.set(new Request(r).url, { b: await res.text(), h: [...res.headers] }); } } };
  const env = (d) => ({ DB: d, ASSETS, CF_VERSION_METADATA: { id: "cpu-bench" } });
  const run = async (e) => { dbCpu = 0; const s = process.cpuUsage(); const r = await worker.fetch(new Request("https://inu-taikenki.com" + path), e);
    await r.text(); const d = process.cpuUsage(s); return { ms: (d.user + d.system - dbCpu) / 1000, status: r.status }; };
  if (scenario === "fill") { await run(env(mkDB())); writeFileSync(cacheFile, JSON.stringify([...store])); return []; }
  if (scenario === "cold" || scenario === "coldhit") return [await run(env(mkDB()))];
  const d = mkDB(); for (let i = 0; i < 5; i++) await run(env(d));
  const out = []; const n = scenario === "warm" ? WARM_RUNS : RECHECK_RUNS;
  for (let i = 0; i < n; i++) { if (scenario === "recheck") now += 10 * 60 * 1000 + 1; out.push(await run(env(d))); }
  return out;
}

async function buildReplica() {
  if (existsSync(REPLICA)) return;
  mkdirSync(STATE, { recursive: true });
  const { legacyDatabase, migrate } = await import(pathToFileURL(resolve(ROOT, "tests/database.mjs")).href);
  const cwd = process.cwd(); process.chdir(ROOT);
  const db = legacyDatabase(); migrate(db);
  for (const name of readdirSync("migrations").sort()) if (/^\d{4}_/.test(name) && Number(name.slice(0, 4)) > 18) db.exec(readFileSync("migrations/" + name, "utf8"));
  db.exec(`VACUUM INTO '${REPLICA.replaceAll("'", "''")}'`);
  process.chdir(cwd);
}

const q = (a, p) => { const s = [...a].sort((x, y) => x - y); return s[Math.min(s.length - 1, Math.floor(p * (s.length - 1) + 0.5))]; };
const stat = (a) => a.length ? { mean: a.reduce((x, y) => x + y, 0) / a.length, median: q(a, 0.5), p95: q(a, 0.95), max: Math.max(...a) } : null;

if (process.argv[2] === "--sample") {
  const [, , , workerPath, scenario, path, cacheFile] = process.argv;
  console.log(JSON.stringify((await sample(workerPath, scenario, path, cacheFile)).map((r) => [r.ms, r.status])));
} else {
  const workerPath = resolve(process.argv[2] ?? resolve(ROOT, "src/final-entry.ts"));
  await buildReplica();
  const child = (...args) => {
    const r = spawnSync(process.execPath, ["--import", resolve(ROOT, "tests/ts-loader.mjs"), "--no-warnings", SELF, "--sample", workerPath, ...args], { encoding: "utf8", cwd: ROOT });
    const line = r.stdout.trim().split("\n").at(-1); if (r.status !== 0 || !line?.startsWith("[")) throw new Error(r.stderr || "sample failed"); return JSON.parse(line);
  };
  const results = [];
  for (const path of ROUTES) {
    const cacheFile = resolve(STATE, "fill.json"); child("fill", path, cacheFile);
    const row = { path, status: 0, cold: [], coldhit: [], warm: [], recheck: [] };
    for (let i = 0; i < COLD_RUNS; i++) { row.cold.push(...child("cold", path, cacheFile).map(([ms]) => ms)); row.coldhit.push(...child("coldhit", path, cacheFile).map(([ms]) => ms)); }
    for (const sc of ["warm", "recheck"]) { const r = child(sc, path, cacheFile); row.status = r[0][1]; row[sc].push(...r.map(([ms]) => ms)); }
    rmSync(cacheFile, { force: true });
    results.push(row);
  }
  const f = (a) => `${q(a, 0.5).toFixed(1)}/${q(a, 0.95).toFixed(1)}/${Math.max(...a).toFixed(1)}`.padStart(16);
  console.log(`worker: ${workerPath}\nCPU ms per request (median/p95/max), SQLite time excluded\n`);
  console.log("path".padEnd(52) + "st " + ["cold", "coldhit", "warm", "recheck"].map((s) => s.padStart(16)).join(""));
  for (const r of results) console.log(r.path.padEnd(52) + String(r.status).padEnd(3) + f(r.cold) + f(r.coldhit) + f(r.warm) + f(r.recheck));
  const html = results.filter((r) => r.status === 200 && !r.path.startsWith("/api/"));
  console.log("\nall HTML pages (200), per state:");
  for (const sc of ["cold", "coldhit", "warm", "recheck"]) {
    const s = stat(html.flatMap((r) => r[sc]));
    console.log(`  ${sc.padEnd(8)} mean ${s.mean.toFixed(2)}  median ${s.median.toFixed(2)}  p95 ${s.p95.toFixed(2)}  max ${s.max.toFixed(2)}  over 10 ms: ${(100 * html.flatMap((r) => r[sc]).filter((x) => x > 10).length / html.flatMap((r) => r[sc]).length).toFixed(0)}%`);
  }
}
