// 実行前後の「内容」照合。行の中身はハッシュにして保持し、スナップショットには件数とハッシュ値だけを入れる（口コミ本文は保存・出力しない）。
// query(sql) は行の配列を返す関数（本番ではwrangler経由の読み取り、テストではメモリSQLite）。
import {sha256, productIds} from './lib.mjs';

const PAGE = 500;

// SQL の VALUES 行（1行1レコード）を値の配列として読む。文字列は '' エスケープ、NULL は null。
export function parseValueRows(sql, cte) {
  const rows = [];
  let from = 0;
  for (;;) {
    const start = sql.indexOf(`WITH ${cte}(`, from);
    if (start < 0) break;
    const end = sql.indexOf('\n)\n', start);
    for (const line of sql.slice(start, end).split('\n')) {
      if (!line.startsWith('(')) continue;
      const vals = [];
      let i = 1;
      while (i < line.length) {
        if (line[i] === "'") {
          let j = i + 1, v = '';
          while (j < line.length) {
            if (line[j] === "'" && line[j + 1] === "'") { v += "'"; j += 2; }
            else if (line[j] === "'") break;
            else v += line[j++];
          }
          vals.push(v); i = j + 1;
        } else if (line.startsWith('NULL', i)) { vals.push(null); i += 4; }
        else i++;
      }
      rows.push(vals);
    }
    from = end + 1;
  }
  return rows;
}
const digestRows = (rows) => sha256(JSON.stringify(rows.map(r => r.map(v => v ?? null)).map(r => JSON.stringify(r)).sort()));
async function pagedRows(query, sqlBase) {
  const all = [];
  for (let off = 0; ; off += PAGE) {
    const rows = await query(`${sqlBase} LIMIT ${PAGE} OFFSET ${off}`);
    all.push(...rows);
    if (rows.length < PAGE) break;
  }
  return all;
}
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
  // 対象カテゴリ「以外」の行数（追加対象テーブルと、トリガーで連動して増える派生テーブル）。実行前後で1件も変わってはいけない。
  const outside = {};
  const has = (t) => tables.includes(t);
  if (has('reviews')) outside.reviews = (await query(`SELECT COUNT(*) AS c FROM reviews WHERE NOT (${own})`))[0].c;
  if (has('products')) outside.products = (await query(`SELECT COUNT(*) AS c FROM products WHERE category<>'${cat}'`))[0].c;
  for (const t of ['review_sources', 'review_attributes']) {
    if (has(t)) outside[t] = (await query(`SELECT COUNT(*) AS c FROM ${t} WHERE review_id NOT IN (SELECT id FROM reviews WHERE ${own})`))[0].c;
  }
  out.outside = outside;
  const [r] = await query(`SELECT
    (SELECT COUNT(*) FROM products WHERE category='${cat}') AS cat_products,
    (SELECT COUNT(*) FROM reviews WHERE ${own}) AS cat_reviews,
    (SELECT COUNT(*) FROM review_sources WHERE review_id IN (SELECT id FROM reviews WHERE ${own})) AS cat_sources,
    (SELECT COUNT(*) FROM products WHERE id IN (${ids}) AND category<>'${cat}') AS id_conflicts`);
  // 追加分の「中身」がSQLどおりか（件数だけでなく値のハッシュで照合）。
  const content = {};
  if (has('reviews')) {
    const rows = await pagedRows(query, `SELECT r.product_id,r.dog_breed,r.dog_size,r.coat_type,r.needs,r.summary,r.source_type,r.source_url FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='${cat}' ORDER BY r.product_id,r.summary`);
    content.cat_reviews_digest = digestRows(rows.map(o => [o.product_id, o.dog_breed, o.dog_size, o.coat_type, o.needs, o.summary, o.source_type, o.source_url]));
    content.expected_reviews_digest = digestRows(parseValueRows(sql, 'new_reviews'));
  }
  if (has('review_sources') && entry.expected_review_sources !== undefined) {
    const rows = await pagedRows(query, `SELECT r.product_id,r.summary,s.source_type,s.source_url,s.source_platform,s.source_review_id FROM review_sources s JOIN reviews r ON r.id=s.review_id JOIN products p ON p.id=r.product_id WHERE p.category='${cat}' ORDER BY s.source_platform,s.source_review_id`);
    content.cat_sources_digest = digestRows(rows.map(o => [o.product_id, o.summary, o.source_type, o.source_url, o.source_platform, o.source_review_id]));
    content.expected_sources_digest = digestRows(parseValueRows(sql, 'new_sources'));
  }
  return {...out, ...r, ...content};
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
  if (post.cat_reviews_digest !== undefined && post.cat_reviews_digest !== post.expected_reviews_digest) errs.push('追加した口コミの中身がSQLと一致しません（値のハッシュ不一致）');
  if (post.cat_sources_digest !== undefined && post.cat_sources_digest !== post.expected_sources_digest) errs.push('追加した出典(review_sources)の中身がSQLと一致しません（値のハッシュ不一致）');
  if (entry.expected_review_sources !== undefined && post.cat_sources !== entry.expected_review_sources) errs.push(`対象の出典(review_sources) ${post.cat_sources} ≠ ${entry.expected_review_sources}`);
  const allowed = new Set(entry.allowed_tables);
  // トリガーで連動して行が増える派生テーブル（例: review_attributes）。増えてよいのは対象カテゴリの口コミ分だけ。
  const derived = new Set(entry.derived_tables || []);
  for (const [t, a] of Object.entries(pre.tables)) {
    const b = post.tables[t];
    if (!b) { errs.push(`テーブル ${t} が消えています`); continue; }
    if (preRangeDigestAfter[t] !== a.digest) errs.push(`既存行の内容が変化: ${t}（実行前の行のハッシュが不一致）`);
    if (allowed.has(t) || derived.has(t)) {
      if (b.count < a.count) errs.push(`テーブル ${t} の行が減っています`);
    } else if (b.count !== a.count || b.maxRowid !== a.maxRowid) errs.push(`対象外テーブル ${t} が変化: ${a.count}→${b.count}`);
  }
  for (const [t, n] of Object.entries(pre.outside || {})) {
    if ((post.outside || {})[t] !== n) errs.push(`対象カテゴリ以外の ${t} が変化: ${n}→${(post.outside || {})[t]}`);
  }
  if (entry.expected_review_sources !== undefined && pre.tables.review_sources) {
    const d = post.tables.review_sources.count - pre.tables.review_sources.count;
    if (d !== entry.expected_review_sources - pre.cat_sources) errs.push(`review_sources の増加 ${d} が想定 ${entry.expected_review_sources - pre.cat_sources} と違います`);
  }
  for (const t of Object.keys(post.tables)) if (!pre.tables[t]) errs.push(`想定外の新テーブル ${t}`);
  const dReviews = post.tables.reviews.count - pre.tables.reviews.count;
  if (dReviews !== entry.expected_reviews - pre.cat_reviews) errs.push(`口コミ増加 ${dReviews} が想定 ${entry.expected_reviews - pre.cat_reviews} と違います`);
  const dProducts = post.tables.products.count - pre.tables.products.count;
  if (dProducts !== entry.expected_products - pre.cat_products) errs.push(`商品増加 ${dProducts} が想定と違います`);
  if (pre.id_conflicts) errs.push('事前にID衝突あり');
  return errs;
}
