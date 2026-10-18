// 実行前後の「内容」照合。行の中身はハッシュにして保持し、スナップショットには件数とハッシュ値だけを入れる（口コミ本文は保存・出力しない）。
// query(sql) は行の配列を返す関数（本番ではwrangler経由の読み取り、テストではメモリSQLite）。
import {sha256, productIds} from './lib.mjs';

const PAGE = 500;
const NAME = /^[A-Za-z0-9_]+$/;

export async function takeSnapshot(query, entry, sql) {
  const cat = entry.category;
  if (!/^[a-z-]+$/.test(cat)) throw new Error('category 不正');
  const tables = (await query(`SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE '\\_cf\\_%' ESCAPE '\\' ORDER BY name`)).map(r => r.name);
  const out = {tables: {}};
  for (const t of tables) {
    if (!NAME.test(t)) throw new Error(`想定外のテーブル名: ${t}`);
    const [{c}] = await query(`SELECT COUNT(*) AS c FROM ${t}`);
    let max = null;
    try { [{m: max}] = await query(`SELECT MAX(rowid) AS m FROM ${t}`); } catch { max = null; } // WITHOUT ROWID は全体比較に落とす
    const h = [];
    if (max !== null) {
      for (let from = 0; from < (max ?? 0); from += 0) {
        const rows = await query(`SELECT rowid AS __rowid, * FROM ${t} WHERE rowid > ${from} AND rowid <= ${max} ORDER BY rowid LIMIT ${PAGE}`);
        if (!rows.length) break;
        h.push(sha256(JSON.stringify(rows)));
        from = rows[rows.length - 1].__rowid;
      }
    }
    out.tables[t] = {count: c, maxRowid: max, digest: sha256(h.join(','))};
  }
  const ids = productIds(sql).map(x => `'${x}'`).join(',');
  const own = `product_id IN (SELECT id FROM products WHERE category='${cat}')`;
  const [r] = await query(`SELECT
    (SELECT COUNT(*) FROM products WHERE category='${cat}') AS cat_products,
    (SELECT COUNT(*) FROM reviews WHERE ${own}) AS cat_reviews,
    (SELECT COUNT(*) FROM review_sources WHERE review_id IN (SELECT id FROM reviews WHERE ${own})) AS cat_sources,
    (SELECT COUNT(*) FROM products WHERE id IN (${ids}) AND category<>'${cat}') AS id_conflicts`);
  return {...out, ...r};
}

// 実行後のスナップショットが、実行前の行(rowid<=maxRowid)を1文字も変えていないかを、
// 実行前と同じ範囲で再計算したハッシュで比べる。
export async function digestUpTo(query, pre) {
  const res = {};
  for (const [t, info] of Object.entries(pre.tables)) {
    const h = [];
    if (info.maxRowid !== null) {
      for (let from = 0; from < info.maxRowid; from += 0) {
        const rows = await query(`SELECT rowid AS __rowid, * FROM ${t} WHERE rowid > ${from} AND rowid <= ${info.maxRowid} ORDER BY rowid LIMIT ${PAGE}`);
        if (!rows.length) break;
        h.push(sha256(JSON.stringify(rows)));
        from = rows[rows.length - 1].__rowid;
      }
    }
    res[t] = sha256(h.join(','));
  }
  return res;
}

export function compareDryRun(entry, pre) {
  const errs = [];
  if (pre.id_conflicts) errs.push(`同じIDで別カテゴリの商品が${pre.id_conflicts}件あります（INSERT OR IGNOREで無視される）`);
  if (pre.cat_reviews > entry.expected_reviews || pre.cat_products > entry.expected_products) errs.push('対象カテゴリに想定以上の行が既にあります');
  return errs;
}

export function compareApply(entry, pre, post, preRangeDigestAfter) {
  const errs = [];
  if (post.cat_products !== entry.expected_products) errs.push(`対象商品 ${post.cat_products} ≠ ${entry.expected_products}`);
  if (post.cat_reviews !== entry.expected_reviews) errs.push(`対象口コミ ${post.cat_reviews} ≠ ${entry.expected_reviews}`);
  if (entry.expected_review_sources !== undefined && post.cat_sources !== entry.expected_review_sources) errs.push(`対象の出典(review_sources) ${post.cat_sources} ≠ ${entry.expected_review_sources}`);
  const allowed = new Set(entry.allowed_tables);
  for (const [t, a] of Object.entries(pre.tables)) {
    const b = post.tables[t];
    if (!b) { errs.push(`テーブル ${t} が消えています`); continue; }
    if (preRangeDigestAfter[t] !== a.digest) errs.push(`既存行の内容が変化: ${t}（実行前の行のハッシュが不一致）`);
    if (!allowed.has(t)) {
      if (b.count !== a.count || b.maxRowid !== a.maxRowid) errs.push(`対象外テーブル ${t} が変化: ${a.count}→${b.count}`);
    } else if (b.count < a.count) errs.push(`テーブル ${t} の行が減っています`);
  }
  for (const t of Object.keys(post.tables)) if (!pre.tables[t]) errs.push(`想定外の新テーブル ${t}`);
  const dReviews = post.tables.reviews.count - pre.tables.reviews.count;
  if (dReviews !== entry.expected_reviews - pre.cat_reviews) errs.push(`口コミ増加 ${dReviews} が想定 ${entry.expected_reviews - pre.cat_reviews} と違います`);
  const dProducts = post.tables.products.count - pre.tables.products.count;
  if (dProducts !== entry.expected_products - pre.cat_products) errs.push(`商品増加 ${dProducts} が想定と違います`);
  if (pre.id_conflicts) errs.push('事前にID衝突あり');
  return errs;
}
