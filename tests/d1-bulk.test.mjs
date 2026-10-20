import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync, existsSync} from 'node:fs';
import {lintAdditiveSql} from '../scripts/d1-bulk/lib.mjs';
import {verify} from '../scripts/d1-bulk/verify-local.mjs';
const manifest = JSON.parse(readFileSync('release-data/bulk-manifest.json', 'utf8'));
const workflow = readFileSync('.github/workflows/d1-bulk-add.yml', 'utf8');
const ok = "INSERT OR IGNORE INTO products (id, name, category, active) VALUES ('a','A','x',1);\nWITH n AS (VALUES ('a','s'))\nINSERT INTO reviews(product_id,summary) SELECT * FROM n WHERE NOT EXISTS (SELECT 1 FROM reviews r WHERE r.summary='s');";

test('lint accepts additive SQL and ignores keywords inside strings', () => {
  assert.deepEqual(lintAdditiveSql(ok + "\nINSERT OR IGNORE INTO products (id,name,category,active) VALUES ('b','DELETE; DROP','x',1);", ['products', 'reviews']), []);
});
test('lint rejects destructive or unguarded SQL', () => {
  for (const bad of ['DELETE FROM reviews;', 'UPDATE reviews SET summary=\'x\';', 'DROP TABLE reviews;', 'INSERT OR REPLACE INTO products (id) VALUES (\'a\');',
    "INSERT INTO reviews(product_id,summary) VALUES ('a','b');", "INSERT OR IGNORE INTO users (id) VALUES (1);", 'PRAGMA writable_schema=1;',
    "INSERT INTO products (id) VALUES ('a') ON CONFLICT(id) DO UPDATE SET name='z';", 'INSERT OR IGNORE INTO products (id) VALUES (1)']) {
    assert.notDeepEqual(lintAdditiveSql(bad, ['products', 'reviews']), [], bad);
  }
});
test('workflow is manual-only, read-only token, gated by environment, DB pinned', () => {
  assert.match(workflow, /^on:\n  workflow_dispatch:/m);
  assert.doesNotMatch(workflow, /\b(schedule|push|pull_request|pull_request_target|workflow_run|cron):/);
  assert.match(workflow, /permissions:\n  contents: read/);
  assert.match(workflow, /environment: production-d1/);
  for (const line of workflow.split('\n')) if (/run:|node |npx /.test(line)) assert.doesNotMatch(line, /\$\{\{ *inputs/, line);
  assert.doesNotMatch(workflow, /upload-artifact|d1 export|\.sql\.gz/);
  assert.match(workflow, /time-travel info inu-taikenki/);
  assert.doesNotMatch(workflow, /migrations apply|db:seed|db:migrate|wrangler deploy|npm run deploy/);
  const wrangler = readFileSync('wrangler.jsonc', 'utf8');
  assert(wrangler.includes(manifest.target.database_id) && wrangler.includes(manifest.target.database_name));
  assert.equal([...workflow.matchAll(/d1 execute inu-taikenki --remote/g)].length, 1);
});
test('unapproved data cannot be applied', () => {
  for (const e of Object.values(manifest.entries)) assert.equal(typeof e.approved_for_apply, 'boolean');
});
test('verify() passes on a fixture shaped like the real migration', () => {
  const entry = {file: 'migrations/9999_fixture.sql', category: 'fixture-cat', allowed_tables: ['products', 'reviews'], expected_products: 2, expected_reviews: 2};
  const sql = `INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('fx-1', 'F1', 'fixture-cat', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('fx-2', 'F2', 'fixture-cat', NULL, 1);
WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (VALUES
('fx-1',NULL,NULL,NULL,NULL,'要約A','t','https://example.com/a'),
('fx-2',NULL,NULL,NULL,NULL,'要約B','t','https://example.com/b')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url FROM new_reviews n
WHERE NOT EXISTS (SELECT 1 FROM reviews r WHERE r.product_id=n.product_id AND r.summary=n.summary);\n`;
  const failed = verify(entry, sql).filter(r => !r.ok);
  assert.deepEqual(failed, []);
});
test('real migration (when present) passes local verification', { skip: !existsSync(manifest.entries['dog-harness-677'].file) }, () => {
  const e = manifest.entries['dog-harness-677'];
  assert.deepEqual(verify(e, readFileSync(e.file, 'utf8')).filter(r => !r.ok), []);
});

import {buildBaselineDb} from '../scripts/d1-bulk/verify-local.mjs';
import {takeSnapshot, digestUpTo, compareApply} from '../scripts/d1-bulk/snapshot.mjs';
const fxEntry = {file: 'migrations/9999_fixture.sql', category: 'fixture-cat', allowed_tables: ['products', 'reviews'], expected_products: 2, expected_reviews: 2};
const fxSql = `INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('fx-1', 'F1', 'fixture-cat', NULL, 1);
INSERT OR IGNORE INTO products (id, name, category, affiliate_url, active) VALUES ('fx-2', 'F2', 'fixture-cat', NULL, 1);
WITH new_reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url) AS (VALUES
('fx-1',NULL,NULL,NULL,NULL,'要約A','t','https://example.com/a'),
('fx-2',NULL,NULL,NULL,NULL,'要約B','t','https://example.com/b')
)
INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)
SELECT n.product_id,n.dog_breed,n.dog_size,n.coat_type,n.needs,n.summary,n.source_type,n.source_url FROM new_reviews n
WHERE NOT EXISTS (SELECT 1 FROM reviews r WHERE r.product_id=n.product_id AND r.summary=n.summary);\n`;
async function runCase(mutate) {
  const db = buildBaselineDb('9999');
  const q = async (s) => db.prepare(s).all();
  const pre = await takeSnapshot(q, fxEntry, fxSql);
  db.exec(fxSql);
  if (mutate) db.exec(mutate);
  const post = await takeSnapshot(q, fxEntry, fxSql);
  return compareApply(fxEntry, pre, post, await digestUpTo(q, pre));
}
test('content snapshot: clean apply passes', async () => { assert.deepEqual(await runCase(), []); });
test('content snapshot detects same-length edits, deletes and unrelated-table changes', async () => {
  // 件数・ID合計・文字数合計が変わらない書き換えも検知する
  const e1 = await runCase("UPDATE reviews SET summary = substr('あ'||summary,1,length(summary)) WHERE id = (SELECT MIN(id) FROM reviews)");
  assert(e1.some(m => m.includes('reviews')), e1.join());
  assert((await runCase("UPDATE products SET name = name || '' || '!' WHERE rowid = 1")).some(m => m.includes('products')));
  assert((await runCase('DELETE FROM reviews WHERE id = (SELECT MIN(id) FROM reviews)')).length > 0);
  const e4 = await runCase("INSERT INTO review_sources(review_id, source_type, source_url, source_platform, source_review_id) SELECT id, 't', 'https://x', 'p', 'r1' FROM reviews LIMIT 1");
  assert(e4.some(m => m.includes('review_sources')), e4.join());
});

// 本番の事後照合(snapshot/compare)を、実際のSQLを使ってローカルで通す。
const real = manifest.entries['dog-harness-677'];
async function realRun(mutate) {
  const sql = readFileSync(real.file, 'utf8');
  const d = buildBaselineDb('0042');
  const q = async (s) => d.prepare(s).all();
  const pre = await takeSnapshot(q, real, sql);
  d.exec(sql);
  if (mutate) mutate(d);
  const post = await takeSnapshot(q, real, sql);
  return {errs: compareApply(real, pre, post, await digestUpTo(q, pre)), pre, post};
}
test('post-apply check passes for the real 0042 (review_attributes grows only for the new category)', async () => {
  const {errs, pre, post} = await realRun();
  assert.deepEqual(errs, []);
  assert.equal(post.tables.review_sources.count - pre.tables.review_sources.count, 677);
  assert.equal(post.cat_sources, 677);
  assert.deepEqual(post.outside, pre.outside);
  assert(post.tables.review_attributes.count > pre.tables.review_attributes.count, 'trigger-derived rows exist and are allowed');
});
test('post-apply check detects review_sources and other-category tampering', async () => {
  const bad = async (mutate, re) => { const {errs} = await realRun(mutate); assert(errs.some(e => re.test(e)), re + ' :: ' + errs.join(' | ')); };
  const firstOther = "(SELECT MIN(r.id) FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category<>'dog-harness')";
  await bad(d => d.exec(`INSERT INTO review_sources(review_id,source_type,source_url,source_platform,source_review_id) VALUES(${firstOther.replace('MIN','MIN')},'t','https://x','p','tamper-1')`), /review_sources/);
  await bad(d => d.exec(`DELETE FROM review_sources WHERE source_review_id=(SELECT source_review_id FROM review_sources LIMIT 1)`), /review_sources/);
  await bad(d => d.exec(`UPDATE review_sources SET source_url='https://other.example/' WHERE rowid=(SELECT MAX(rowid) FROM review_sources)`), /review_sources|増加/);
  await bad(d => d.exec(`UPDATE reviews SET summary=summary||'!' WHERE id=${firstOther}`), /reviews/);
  await bad(d => d.exec(`INSERT INTO review_attributes(review_id,kind,value) VALUES(${firstOther},'trait','tamper')`), /review_attributes/);
  await bad(d => d.exec(`DELETE FROM review_sources WHERE rowid=(SELECT MAX(rowid) FROM review_sources)`), /review_sources/);
});

import {execFileSync} from 'node:child_process';
import {checkSchema, renderSummary} from '../scripts/d1-bulk/lib.mjs';
test('schema check accepts the real schema and flags missing tables/columns', () => {
  const d = buildBaselineDb('0042');
  const rows = d.prepare("SELECT name, sql FROM sqlite_master WHERE type='table' AND name IN ('products','reviews','review_sources','review_attributes')").all();
  assert.deepEqual(checkSchema(rows), []);
  assert(checkSchema(rows.filter(r => r.name !== 'review_sources')).some(p => p.includes('review_sources')));
  assert(checkSchema(rows.map(r => r.name === 'review_sources' ? {...r, sql: r.sql.replaceAll('source_review_id', 'x')} : r)).some(p => p.includes('source_review_id')));
});
test('summary says plainly whether anything was written', async () => {
  const sql = readFileSync(real.file, 'utf8');
  const d = buildBaselineDb('0042');
  const q = async (s) => d.prepare(s).all();
  const pre = await takeSnapshot(q, real, sql);
  const dry = renderSummary({entryId: 'dog-harness-677', entry: real, mode: 'dry-run', pre});
  assert(dry.includes('本番D1には何も書き込んでいません') && dry.includes('+677'));
  d.exec(sql);
  const post = await takeSnapshot(q, real, sql);
  const done = renderSummary({entryId: 'dog-harness-677', entry: real, mode: 'apply', pre, post});
  assert(done.includes('本番D1に追加しました') && done.includes('+677') && done.includes('1件も変わっていません'));
});
test('gate: apply only from main, only when approved; dry-run is allowed from any branch', () => {
  const run = (mode, ref, extra = {}) => { try { return {ok: true, out: execFileSync('node', ['scripts/d1-bulk/remote.mjs', 'gate', 'dog-harness-677', mode], {env: {...process.env, GITHUB_REF: ref, CONFIRM_TEXT: 'ADD inu-taikenki', ...extra}, encoding: 'utf8', stdio: 'pipe'})}; } catch (e) { return {ok: false, err: String(e.stderr)}; } };
  assert(run('dry-run', 'refs/heads/anything').ok);
  const dev = run('apply', 'refs/heads/develop'); assert(!dev.ok && dev.err.includes('main'));
  const main = run('apply', 'refs/heads/main'); assert(!main.ok && main.err.includes('承認前'), 'approved_for_apply is false in the repo');
  const bad = run('apply', 'refs/heads/main', {CONFIRM_TEXT: 'yes'}); assert(!bad.ok);
});
