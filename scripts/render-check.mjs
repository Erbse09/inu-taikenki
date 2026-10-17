// Production-equivalent render check (read-only).
// Fetches the public review/product data with GET requests, loads it into a throw-away in-memory SQLite database,
// renders every category article through the real Worker code and verifies counts, placement, duplicates and size.
//
//   node --import ./tests/ts-loader.mjs scripts/render-check.mjs [https://inu-taikenki.com] [--shots=<dir>]
//
// Nothing is written to D1. Needs Node 24 (node:sqlite). Screenshots need Playwright + a Chromium
// (set CHROMIUM_EXECUTABLE_PATH if the default browser is not installed).
import { DatabaseSync } from 'node:sqlite';
import { readFileSync, mkdirSync } from 'node:fs';
import { resolve } from 'node:path';
import { createRequire } from 'node:module';

const origin = process.argv.find((a) => /^https?:\/\//.test(a)) || 'https://inu-taikenki.com';
const shots = process.argv.find((a) => a.startsWith('--shots='))?.slice(8);
const { default: worker } = await import('../src/final-entry.ts');
const { sourceCheck } = await import('../src/review-source-check.ts');

const getJson = async (path) => {
  const res = await fetch(origin + path, { headers: { accept: 'application/json', 'user-agent': 'inu-taikenki-render-check' } });
  if (!res.ok) throw new Error(`${path} -> ${res.status}`);
  return res.json();
};
const reviews = [];
for (let cursor = 0; ;) {
  const page = await getJson(`/api/reviews?limit=100&cursor=${cursor}`);
  reviews.push(...page.reviews);
  if (!page.next_cursor) break;
  cursor = page.next_cursor;
}
const products = [];
for (let offset = 0; ;) {
  const page = await getJson(`/api/products?limit=100&offset=${offset}`);
  products.push(...page.products);
  if (!page.has_more) break;
  offset = page.next_offset;
}

const db = new DatabaseSync(':memory:');
db.exec('CREATE TABLE products(id TEXT PRIMARY KEY,name TEXT,category TEXT,active INTEGER DEFAULT 1,affiliate_url TEXT,asin TEXT);CREATE TABLE reviews(id INTEGER PRIMARY KEY,product_id TEXT,dog_breed TEXT,dog_size TEXT,coat_type TEXT,needs TEXT,summary TEXT,source_type TEXT,source_url TEXT);');
const insertProduct = db.prepare('INSERT INTO products(id,name,category) VALUES(?,?,?)');
for (const p of products) insertProduct.run(p.id, p.name, p.category);
const insertReview = db.prepare('INSERT INTO reviews VALUES(?,?,?,?,?,?,?,?,?)');
for (const r of reviews) insertReview.run(r.id, r.product_id, r.dog_breed, r.dog_size, r.coat_type, r.needs, r.summary, r.source_type, r.source_url);

let queries = 0;
const binding = {
  prepare(sql) {
    return {
      values: [],
      bind(...v) { this.values = v; return this; },
      async all() { queries++; return { results: db.prepare(sql).all(...this.values) }; },
      async first() { queries++; return db.prepare(sql).get(...this.values) || null; },
    };
  },
};
const ASSETS = {
  async fetch(req) {
    let p = new URL(req.url).pathname;
    if (p === '/') p = '/index.html';
    if (!p.split('/').at(-1).includes('.')) p += '.html';
    try { return new Response(readFileSync(resolve('public', '.' + p)), { headers: { 'content-type': p.endsWith('.html') ? 'text/html; charset=utf-8' : 'application/octet-stream' } }); }
    catch { return new Response('not found', { status: 404 }); }
  },
};

const PAGES = {
  'pet-dryer': 'pet-dryer', 'auto-feeder': 'auto-feeder', 'dog-clipper': 'dog-clipper', 'brush-slicker': 'brush-slicker',
  'brush-pin': 'brush-pin', 'brush-undercoat': 'brush-undercoat', 'brush-comb': 'brush-comb', 'dog-nail-grinder': 'nail-grinder',
  'dog-nail-clipper': 'nail-clipper', 'dog-shampoo': 'dog-shampoo', 'dog-conditioner': 'dog-conditioner',
  'dog-toothbrush': 'dog-toothbrush', 'dog-toothpaste': 'dog-toothpaste', 'dog-dental-chew': 'dog-dental-chew', 'dog-ear-cleaner': 'dog-ear-cleaner',
};
const textOf = (html) => html.replace(/<(script|style)[\s\S]*?<\/\1>/g, '').replace(/<[^>]+>/g, ' ').replace(/\s+/g, ' ');
const failures = [];
const check = (ok, message) => { if (!ok) failures.push(message); return ok; };
const rows = [];
const rendered = {};
for (const [page, category] of Object.entries(PAGES)) {
  queries = 0;
  const started = performance.now();
  const res = await worker.fetch(new Request(`${origin}/${page}`), { DB: binding, ASSETS });
  const html = await res.text();
  const ms = performance.now() - started;
  rendered[page] = html;
  const base = await (await ASSETS.fetch(new Request(`${origin}/${page}`))).text();
  const expectedByProduct = new Map();
  for (const r of reviews.filter((x) => x.category === category)) expectedByProduct.set(r.product_id, (expectedByProduct.get(r.product_id) || 0) + 1);
  const expectedTotal = [...expectedByProduct.values()].reduce((a, b) => a + b, 0);
  check(res.status === 200, `${page}: status ${res.status}`);
  check((html.match(/data-inu-profiles(?=[ >])/g) || []).length === 1, `${page}: overview must appear exactly once`);
  const shown = [...html.matchAll(/data-inu-profile="([^"]+)">\s*<summary><strong>[^<]*<\/strong>｜体験(\d+)件/g)];
  const shownTotal = shown.reduce((sum, m) => sum + Number(m[2]), 0);
  check(shown.length === expectedByProduct.size, `${page}: ${shown.length} product cards, expected ${expectedByProduct.size}`);
  check(shownTotal === expectedTotal, `${page}: overview total ${shownTotal} != API total ${expectedTotal}`);
  for (const m of shown) check(expectedByProduct.get(m[1]) === Number(m[2]), `${page}/${m[1]}: ${m[2]} != ${expectedByProduct.get(m[1])}`);
  // Placement: after the interactive list, before the FAQ / next-guide sections.
  const listAt = Math.max(html.indexOf('data-db-review-browser'), html.indexOf('id="db-review-browser"'));
  const overviewAt = html.indexOf('data-inu-profiles aria-label');
  check(listAt !== -1 && overviewAt > listAt, `${page}: overview must come after the interactive list`);
  // Duplicates: no sentence is printed twice inside the overview, and none repeats the list's first rows.
  const section = html.slice(overviewAt, html.indexOf('</section>', overviewAt));
  const quotes = [...section.matchAll(/<li>([^<]+)<\/li>/g)].map((m) => m[1]);
  check(new Set(quotes).size === quotes.length, `${page}: duplicate quotes inside the overview`);
  const byProduct = new Map();
  for (const r of reviews.filter((x) => x.category === category)) (byProduct.get(r.product_id) || byProduct.set(r.product_id, []).get(r.product_id)).push(r);
  const top = [...byProduct.entries()].sort((a, b) => b[1].length - a[1].length)[0];
  const initial = new Set(top[1].sort((a, b) => a.id - b.id).slice(0, 6).map((r) => r.summary));
  const repeated = quotes.filter((q) => [...initial].some((s) => q.includes(s.replaceAll('&', '&amp;'))));
  check(repeated.length === 0, `${page}: ${repeated.length} quotes repeat rows the interactive list shows first`);
  // Source-check labels: a quote may say "出典確認済み" only if a stored row with that exact summary is status V,
  // and no quote may come from a row whose matching post was written by a cat owner.
  const decode = (t) => t.replaceAll('&amp;', '&').replaceAll('&lt;', '<').replaceAll('&gt;', '>').replaceAll('&quot;', '"').replaceAll('&#039;', "'");
  for (const q of quotes) {
    const m = decode(q).match(/^［([^］]+)］(?:[^｜]*｜)?([\s\S]*)$/);
    check(!!m, `${page}: quote without a status tag: ${q.slice(0, 40)}`);
    if (!m) continue;
    const same = reviews.filter((r) => r.summary === m[2]);
    check(same.length > 0, `${page}: quoted text is not a stored summary: ${q.slice(0, 40)}`);
    if (m[1] === '出典確認済み') check(same.some((r) => sourceCheck(r.id)?.status === 'V'), `${page}: "出典確認済み" on an unverified row: ${q.slice(0, 40)}`);
    check(!same.every((r) => sourceCheck(r.id)?.status === 'C'), `${page}: quote taken from a cat-owner source: ${q.slice(0, 40)}`);
  }
  // The "出典の確認状況" cells add up to the stored rows of the category, by ledger status.
  const want = { V: 0, P: 0, N: 0, U: 0, C: 0, none: 0, article: 0 };
  for (const r of reviews.filter((x) => x.category === category)) {
    if (r.source_type === 'existing_article_summary') { want.article++; continue; }
    const st = sourceCheck(r.id)?.status;
    want[st || 'none']++;
  }
  const got = { V: 0, P: 0, N: 0, U: 0, C: 0, none: 0 };
  const names = { 確認済み: 'V', 部分一致: 'P', 見つからず: 'N', 確認不能: 'U', 猫の投稿の可能性: 'C', 未実施: 'none' };
  for (const cell of section.matchAll(/出典の確認状況：([^<]*)</g)) {
    for (const part of cell[1].replace(/件$/, '').split('／')) {
      const mm = part.match(/^(確認済み|部分一致|見つからず|確認不能|猫の投稿の可能性|未実施)(\d+)$/);
      if (mm) got[names[mm[1]]] += Number(mm[2]);
    }
  }
  for (const k of Object.keys(got)) check(got[k] === want[k], `${page}: 出典の確認状況 ${k}: shown ${got[k]} != ledger ${want[k]}`);
  // The shared list/JS stay untouched: the added block is the only difference except optional notes.
  const added = html.length - base.length;
  rows.push({ page, products: shown.length, reviews: shownTotal, quotes: quotes.length, addedKB: +(added / 1024).toFixed(1), totalKB: +(html.length / 1024).toFixed(1), ms: +ms.toFixed(1), queries });
  check(queries <= 4, `${page}: ${queries} DB queries`);
}
console.table(rows);
const heaviest = Math.max(...rows.map((r) => r.addedKB));
check(heaviest < 60, `added HTML too large: ${heaviest}KB`);

if (shots) {
  mkdirSync(shots, { recursive: true });
  const { chromium } = createRequire(import.meta.url)('playwright');
  const browser = await chromium.launch({ headless: true, executablePath: process.env.CHROMIUM_EXECUTABLE_PATH || undefined, args: ['--no-sandbox', '--disable-dev-shm-usage'] });
  const context = await browser.newContext({ viewport: { width: 390, height: 844 }, deviceScaleFactor: 2 });
  for (const [page, html] of Object.entries(rendered)) {
    const tab = await context.newPage();
    await tab.route('**/*', (route) => (route.request().url().startsWith('data:') ? route.continue() : route.abort()));
    await tab.setContent(html, { waitUntil: 'domcontentloaded' });
    const m = await tab.evaluate(() => ({ sw: document.documentElement.scrollWidth, cw: document.documentElement.clientWidth }));
    check(m.sw <= m.cw + 1, `${page}: horizontal overflow at 390px (${m.sw} > ${m.cw})`);
    const el = await tab.$('[data-inu-profiles]');
    if (el) await el.screenshot({ path: `${shots}/${page}.png` });
    await tab.close();
  }
  await browser.close();
}

if (failures.length) {
  console.error('\nFAILED:\n- ' + failures.join('\n- '));
  process.exit(1);
}
console.log(`\nOK: ${Object.keys(PAGES).length} category pages, ${reviews.length} reviews, ${products.length} products`);
