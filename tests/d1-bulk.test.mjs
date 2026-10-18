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
test('real migration (when present) passes local verification', { skip: !existsSync(manifest.entries['dog-harness-689'].file) }, () => {
  const e = manifest.entries['dog-harness-689'];
  assert.deepEqual(verify(e, readFileSync(e.file, 'utf8')).filter(r => !r.ok), []);
});
