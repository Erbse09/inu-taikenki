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
const NAME = /^[A-Za-z0-9_]+$/;
const pagesFor = (count) => Math.max(1, Math.ceil((count ?? 0) / PAGE));

// 複数のSELECTを1回の問い合わせ(1回のwrangler起動)でまとめて実行する。query.batch が無ければ1文ずつ。
async function batch(query, sqls) {
  if (!sqls.length) return [];
  if (typeof query.batch === 'function') return await query.batch(sqls);
  const out = [];
  for (const q of sqls) out.push(await query(q));
  return out;
}

// 各表の「実行前に存在した行」(rowid<=max)を rowid 順にページ分割してハッシュ化する。
async function tableDigests(query, tablesInfo) {
  const jobs = [];
  for (const [t, info] of Object.entries(tablesInfo)) {
    if (info.maxRowid === null) continue;
    for (let k = 0; k < pagesFor(info.count); k++) jobs.push({t, sql: `SELECT rowid AS __rowid, * FROM ${t} WHERE rowid <= ${info.maxRowid} ORDER BY rowid LIMIT ${PAGE} OFFSET ${k * PAGE}`});
  }
  const res = await batch(query, jobs.map(j => j.sql));
  const byTable = {};
  jobs.forEach((j, i) => { (byTable[j.t] ||= []).push(res[i]); });
  const out = {};
  for (const t of Object.keys(tablesInfo)) out[t] = sha256((byTable[t] || []).filter(rows => rows.length).map(rows => sha256(JSON.stringify(rows))).join(','));
  return out;
}

export async function takeSnapshot(query, entry, sql) {
  const cat = entry.category;
  if (!/^[a-z-]+$/.test(cat)) throw new Error('category 不正');
  const tables = (await query(`SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name NOT LIKE '\\_cf\\_%' ESCAPE '\\' ORDER BY name`)).map(r => r.name);
  for (const t of tables) if (!NAME.test(t)) throw new Error(`想定外のテーブル名: ${t}`);
  const has = (t) => tables.includes(t);
  const ids = productIds(sql).map(x => `'${x}'`).join(',');
  const own = `product_id IN (SELECT id FROM products WHERE category='${cat}')`;
  // 1回目のまとめ問い合わせ: 各表の件数と最大rowid、対象カテゴリ以外の件数、対象カテゴリの件数
  const stats = [];
  const add = (key, sqlText) => stats.push({key, sql: sqlText});
  for (const t of tables) add('t:' + t, `SELECT COUNT(*) AS c, MAX(rowid) AS m FROM ${t}`);
  if (has('reviews')) add('o:reviews', `SELECT COUNT(*) AS c FROM reviews WHERE NOT (${own})`);
  if (has('products')) add('o:products', `SELECT COUNT(*) AS c FROM products WHERE category<>'${cat}'`);
  for (const t of ['review_sources', 'review_attributes']) if (has(t)) add('o:' + t, `SELECT COUNT(*) AS c FROM ${t} WHERE review_id NOT IN (SELECT id FROM reviews WHERE ${own})`);
  add('cat', `SELECT
    (SELECT COUNT(*) FROM products WHERE category='${cat}') AS cat_products,
    (SELECT COUNT(*) FROM reviews WHERE ${own}) AS cat_reviews,
    (SELECT COUNT(*) FROM review_sources WHERE review_id IN (SELECT id FROM reviews WHERE ${own})) AS cat_sources,
    (SELECT COUNT(*) FROM products WHERE id IN (${ids}) AND category<>'${cat}') AS id_conflicts`);
  let res;
  try { res = await batch(query, stats.map(x => x.sql)); }
  catch (e) {
    // WITHOUT ROWID の表があると MAX(rowid) が失敗する。表ごとに分けて、失敗した表は全体比較に落とす。
    res = [];
    for (const x of stats) {
      try { res.push((await batch(query, [x.sql]))[0]); } catch { res.push(x.key.startsWith('t:') ? [{c: null, m: null}] : (() => { throw e; })()); }
    }
  }
  const got = Object.fromEntries(stats.map((x, i) => [x.key, res[i]]));
  const out = {tables: {}};
  for (const t of tables) out.tables[t] = {count: got['t:' + t][0].c, maxRowid: got['t:' + t][0].m ?? null};
  // WITHOUT ROWID (max=null) の表は件数のみ追跡する。
  const digests = await tableDigests(query, out.tables);
  for (const t of tables) out.tables[t].digest = digests[t];
  out.outside = {};
  for (const k of ['reviews', 'products', 'review_sources', 'review_attributes']) if (got['o:' + k]) out.outside[k] = got['o:' + k][0].c;
  Object.assign(out, got.cat[0]);
  // 追加分の「中身」がSQLどおりか（件数だけでなく値のハッシュで照合）。件数は上で分かっているのでページ数も決まる。
  const content = {};
  const jobs = [];
  if (has('reviews')) for (let k = 0; k < pagesFor(out.cat_reviews); k++) jobs.push({kind: 'r', sql: `SELECT r.product_id,r.dog_breed,r.dog_size,r.coat_type,r.needs,r.summary,r.source_type,r.source_url FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='${cat}' ORDER BY r.product_id,r.summary LIMIT ${PAGE} OFFSET ${k * PAGE}`});
  const wantSources = has('review_sources') && entry.expected_review_sources !== undefined;
  if (wantSources) for (let k = 0; k < pagesFor(out.cat_sources); k++) jobs.push({kind: 's', sql: `SELECT r.product_id,r.summary,s.source_type,s.source_url,s.source_platform,s.source_review_id FROM review_sources s JOIN reviews r ON r.id=s.review_id JOIN products p ON p.id=r.product_id WHERE p.category='${cat}' ORDER BY s.source_platform,s.source_review_id LIMIT ${PAGE} OFFSET ${k * PAGE}`});
  const pages = await batch(query, jobs.map(j => j.sql));
  const rowsOf = (kind) => jobs.flatMap((j, i) => j.kind === kind ? pages[i] : []);
  if (has('reviews')) {
    content.cat_reviews_digest = digestRows(rowsOf('r').map(o => [o.product_id, o.dog_breed, o.dog_size, o.coat_type, o.needs, o.summary, o.source_type, o.source_url]));
    content.expected_reviews_digest = digestRows(parseValueRows(sql, 'new_reviews'));
  }
  if (wantSources) {
    content.cat_sources_digest = digestRows(rowsOf('s').map(o => [o.product_id, o.summary, o.source_type, o.source_url, o.source_platform, o.source_review_id]));
    content.expected_sources_digest = digestRows(parseValueRows(sql, 'new_sources'));
  }
  return {...out, ...content};
}

// 実行後のスナップショットが、実行前の行(rowid<=maxRowid)を1文字も変えていないかを、
// 実行前と同じ範囲で再計算したハッシュで比べる。
export async function digestUpTo(query, pre) {
  return await tableDigests(query, pre.tables);
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
