// 使い方: node scripts/d1-bulk/verify-local.mjs <entry-id> [--file <path>]
// ローカルの使い捨てSQLite(メモリ)だけを使う。Cloudflareには接続しない。
import {DatabaseSync} from 'node:sqlite';
import {readFileSync, readdirSync} from 'node:fs';
import {loadManifest, getEntry, sha256, lintAdditiveSql, productIds} from './lib.mjs';

export function buildBaselineDb(skipNumber) {
  const db = new DatabaseSync(':memory:');
  db.exec(readFileSync('migrations/0001_init.sql', 'utf8'));
  db.exec(readFileSync('seed.sql', 'utf8')); // 使い捨てメモリDBでのみ実行
  for (const name of readdirSync('migrations').filter(n => /^\d{4}_.*\.sql$/.test(n)).sort()) {
    if (name.startsWith('0001_') || (skipNumber && name.startsWith(skipNumber))) continue;
    db.exec(readFileSync('migrations/' + name, 'utf8'));
  }
  return db;
}

const snapshot = (db, category) => ({
  otherReviews: db.prepare(`SELECT id,product_id,summary,source_url,created_at FROM reviews WHERE product_id NOT IN (SELECT id FROM products WHERE category=?) ORDER BY id`).all(category),
  otherProducts: db.prepare(`SELECT * FROM products WHERE category<>? ORDER BY id`).all(category),
  otherSources: db.prepare(`SELECT * FROM review_sources WHERE review_id NOT IN (SELECT r.id FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category=?) ORDER BY review_id`).all(category),
});
const count = (db, sql, ...a) => db.prepare(sql).get(...a).c;

export function verify(entry, sql) {
  const out = [];
  const check = (ok, msg) => { out.push({ok, msg}); };
  const problems = lintAdditiveSql(sql, entry.allowed_tables);
  check(problems.length === 0, 'SQLは追加専用(DELETE/UPDATE/DROP等なし・NOT EXISTSあり)' + (problems.length ? ': ' + problems.slice(0, 5).join(' / ') : ''));
  const ids = productIds(sql);
  check(ids.length === entry.expected_products && new Set(ids).size === ids.length, `商品ID ${ids.length}件(想定${entry.expected_products}・重複なし)`);

  const db = buildBaselineDb(entry.file.split('/').pop().slice(0, 4));
  const cat = entry.category;
  // 既存行の保全を試すため、同一商品IDに「別の既存口コミ」と「同一要約の既存口コミ」を事前に置く
  db.exec(`INSERT INTO products(id,name,category,active) VALUES ('${ids[0]}','事前存在の商品','${cat}',1)`);
  db.exec(`INSERT INTO reviews(product_id,summary,source_type) VALUES ('${ids[0]}','事前存在の口コミ(消えてはいけない)','test')`);
  const baseReviews = count(db, 'SELECT COUNT(*) c FROM reviews');
  const baseProducts = count(db, 'SELECT COUNT(*) c FROM products');
  const before = snapshot(db, cat);
  const pre = db.prepare('SELECT * FROM reviews WHERE summary LIKE ?').get('事前存在%');
  const preProduct = db.prepare('SELECT * FROM products WHERE id=?').get(ids[0]);

  db.exec(sql);
  const catReviews = () => count(db, `SELECT COUNT(*) c FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category=?`, cat);
  const afterReviews = count(db, 'SELECT COUNT(*) c FROM reviews');
  check(count(db, 'SELECT COUNT(*) c FROM products WHERE category=?', cat) === entry.expected_products, `適用後の対象商品=${entry.expected_products}`);
  check(catReviews() === entry.expected_reviews + 1, `適用後の対象口コミ=${entry.expected_reviews}件+事前存在1件`);
  check(afterReviews - baseReviews === entry.expected_reviews, `全体の口コミ増加=${afterReviews - baseReviews}(想定${entry.expected_reviews})`);
  check(count(db, 'SELECT COUNT(*) c FROM products') - baseProducts === entry.expected_products - 1, '商品増加=想定-事前存在1');
  check(JSON.stringify(snapshot(db, cat)) === JSON.stringify(before), '他カテゴリの既存口コミ・商品が1行も変化していない');
  check(JSON.stringify(db.prepare('SELECT * FROM reviews WHERE id=?').get(pre.id)) === JSON.stringify(pre), '事前存在の口コミが削除・上書きされていない');
  check(JSON.stringify(db.prepare('SELECT * FROM products WHERE id=?').get(ids[0])) === JSON.stringify(preProduct), '事前存在の商品が上書きされていない(INSERT OR IGNORE)');
  check(count(db, 'SELECT COUNT(*) c FROM reviews WHERE product_id NOT IN (SELECT id FROM products)') === 0, '孤立した口コミなし');
  if (entry.expected_review_sources !== undefined) {
    const srcCount = () => count(db, `SELECT COUNT(*) c FROM review_sources s JOIN reviews r ON r.id=s.review_id JOIN products p ON p.id=r.product_id WHERE p.category=?`, cat);
    check(srcCount() === entry.expected_review_sources, `review_sources が想定どおり${entry.expected_review_sources}件`);
    check(count(db, `SELECT COUNT(*) c FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category=? AND r.id NOT IN (SELECT review_id FROM review_sources)`, cat) === 1, '追加した口コミは全件 review_sources と対応(事前存在の1件のみ対応なし)');
    check(count(db, `SELECT COUNT(*) c FROM review_sources WHERE source_url NOT GLOB 'https://*' OR length(trim(source_review_id))=0`) === 0, 'review_sources の URL/識別子が妥当');
  }

  const dump = () => JSON.stringify([db.prepare('SELECT * FROM reviews ORDER BY id').all(), db.prepare('SELECT * FROM review_sources ORDER BY review_id').all(), db.prepare('SELECT * FROM products ORDER BY id').all()]);
  const afterOnce = dump();
  db.exec(sql);
  check(dump() === afterOnce, '2回目の実行で口コミ・出典・商品が1件も増減・変更しない(再実行安全)');
  db.exec(sql);
  check(count(db, 'SELECT COUNT(*) c FROM reviews') === afterReviews, '3回目も件数不変');

  // 途中失敗→再実行の復旧: 先頭付近の一部だけ入った状態を作って再実行すると不足分だけ補われる
  const db2 = buildBaselineDb(entry.file.split('/').pop().slice(0, 4));
  const first = sql.split(/\n(?=INSERT INTO reviews)|\n(?=WITH new_reviews)/)[0];
  db2.exec(first);
  const partial = count(db2, 'SELECT COUNT(*) c FROM reviews');
  db2.exec(sql);
  check(count(db2, 'SELECT COUNT(*) c FROM reviews') - partial >= 0 && count(db2, `SELECT COUNT(*) c FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category=?`, cat) === entry.expected_reviews, '商品だけ入った中途状態から再実行しても最終的に想定件数に揃う');
  return out;
}

if (import.meta.url === `file://${process.argv[1]}`) {
  const id = process.argv[2];
  const fi = process.argv.indexOf('--file');
  const entry = getEntry(loadManifest(), id);
  const sql = readFileSync(fi > 0 ? process.argv[fi + 1] : entry.file, 'utf8');
  const results = [];
  results.push({ok: sha256(sql) === entry.sha256, msg: 'SQLのsha256がmanifestと一致'});
  results.push(...verify(entry, sql));
  for (const r of results) console.log(`${r.ok ? 'OK ' : 'NG '} ${r.msg}`);
  if (results.some(r => !r.ok)) process.exit(1);
  console.log('ローカル検証: すべて合格');
}
