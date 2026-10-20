import {readFileSync} from 'node:fs';
import {createHash} from 'node:crypto';

export const MAX_STATEMENT_BYTES = 100000;
export const manifestPath = 'release-data/bulk-manifest.json';

export function loadManifest(path = manifestPath) {
  return JSON.parse(readFileSync(path, 'utf8'));
}

export function getEntry(manifest, id) {
  if (!/^[a-z0-9-]{1,60}$/.test(id || '')) throw new Error('entry id の形式が不正です');
  const entry = manifest.entries[id];
  if (!entry) throw new Error(`manifest に ${id} がありません`);
  return entry;
}

export function sha256(text) {
  return createHash('sha256').update(text).digest('hex');
}

// 文字列リテラルとコメントを空欄化し、; で文を分割する（文字列中の ; や DELETE を誤検出しない）。
export function splitStatements(sql) {
  const raw = [];
  const stripped = [];
  let cur = '';
  let curStripped = '';
  for (let i = 0; i < sql.length; i++) {
    const c = sql[i];
    if (c === "'") {
      let j = i + 1;
      while (j < sql.length) {
        if (sql[j] === "'" && sql[j + 1] === "'") j += 2;
        else if (sql[j] === "'") break;
        else j++;
      }
      if (j >= sql.length) throw new Error('閉じていない文字列があります');
      cur += sql.slice(i, j + 1);
      curStripped += "''";
      i = j;
    } else if (c === '-' && sql[i + 1] === '-') {
      while (i < sql.length && sql[i] !== '\n') i++;
      cur += '\n';
      curStripped += '\n';
    } else if (c === '/' && sql[i + 1] === '*') {
      throw new Error('ブロックコメントは使えません');
    } else if (c === '"' || c === '`' || c === '[') {
      throw new Error('引用識別子は使えません');
    } else if (c === ';') {
      if (curStripped.trim()) { raw.push(cur.trim()); stripped.push(curStripped.trim()); }
      cur = ''; curStripped = '';
    } else {
      cur += c; curStripped += c;
    }
  }
  if (curStripped.trim()) throw new Error('末尾の ; がありません');
  return raw.map((text, i) => ({text, stripped: stripped[i]}));
}

const FORBIDDEN = /\b(DELETE|DROP|UPDATE|ALTER|REPLACE|CREATE|ATTACH|DETACH|VACUUM|TRUNCATE|REINDEX|BEGIN|COMMIT|ROLLBACK|SAVEPOINT|RELEASE|DO)\b/i;

// 追加専用SQLの検査。問題点の配列を返す（空なら合格）。
export function lintAdditiveSql(sql, allowedTables) {
  const problems = [];
  let statements;
  try { statements = splitStatements(sql); } catch (e) { return [e.message]; }
  const targets = new RegExp(`^(?:${allowedTables.join('|')})$`);
  statements.forEach((s, i) => {
    const n = i + 1;
    const st = s.stripped.replace(/\s+/g, ' ');
    if (Buffer.byteLength(s.text) > MAX_STATEMENT_BYTES) problems.push(`文${n}: ${MAX_STATEMENT_BYTES}バイトを超えています`);
    if (FORBIDDEN.test(st)) problems.push(`文${n}: 禁止キーワード ${st.match(FORBIDDEN)[1]}`);
    if (/^PRAGMA /i.test(st)) {
      if (!/^PRAGMA foreign_keys = ON$/i.test(st)) problems.push(`文${n}: 許可されないPRAGMA`);
      return;
    }
    if (/^SELECT /i.test(st)) return;
    if (!/^(INSERT|WITH) /i.test(st)) { problems.push(`文${n}: 許可されない文の種類`); return; }
    const inserts = [...st.matchAll(/\bINSERT (?:OR IGNORE )?INTO ([a-z_]+)/gi)];
    if (!inserts.length) problems.push(`文${n}: INSERTがありません`);
    for (const m of inserts) {
      if (!targets.test(m[1])) problems.push(`文${n}: 対象外テーブル ${m[1]}`);
      const plain = /\bINSERT INTO /i.test(m[0]);
      if (plain && !/\bWHERE NOT EXISTS\b/i.test(st)) problems.push(`文${n}: ${m[1]} への INSERT に重複防止(NOT EXISTS)がありません`);
    }
  });
  return problems;
}

export function productIds(sql) {
  return [...sql.matchAll(/INSERT OR IGNORE INTO products \([^)]*\) VALUES \('([^']+)'/g)].map(m => m[1]);
}

export function reviewValueCount(sql) {
  // new_reviews CTE の VALUES 行数（種別で始まる行）
  return (sql.match(/^\s*\('[^']+',/gm) || []).length;
}

// 本番D1に必要な表と列があるか（読み取りで得た sqlite_master の行を渡す）。問題点の配列を返す（空なら合格）。
export const REQUIRED_SCHEMA = {
  products: ['id', 'name', 'category', 'affiliate_url', 'active'],
  reviews: ['id', 'product_id', 'dog_breed', 'dog_size', 'coat_type', 'needs', 'summary', 'source_type', 'source_url'],
  review_sources: ['review_id', 'source_type', 'source_url', 'source_platform', 'source_review_id'],
  review_attributes: ['review_id', 'kind', 'value'],
};
export function checkSchema(rows) {
  const problems = [];
  const byName = Object.fromEntries(rows.map(r => [r.name, String(r.sql || '')]));
  for (const [table, cols] of Object.entries(REQUIRED_SCHEMA)) {
    if (!(table in byName)) { problems.push(`テーブル ${table} がありません`); continue; }
    for (const c of cols) if (!new RegExp(`\\b${c}\\b`).test(byName[table])) problems.push(`${table} に列 ${c} がありません`);
  }
  return problems;
}

// iPhoneで読める結果の要約（GitHub のジョブ画面に出す）。pre/post は snapshot の結果。
export function renderSummary({entryId, entry, mode, pre, post, ok = true}) {
  const t = (s, k) => s?.tables?.[k]?.count ?? '—';
  const lines = [];
  lines.push(`## D1一括追加 ${mode === 'apply' ? '（本番に追加）' : '（dry-run：確認だけ・書き込みなし）'}`);
  lines.push(`- 対象データ: \`${entryId}\`（${entry.category}）／接続先: D1 \`inu-taikenki\``);
  lines.push('');
  lines.push('| 項目 | 実行前 | ' + (post ? '実行後 | 増加 |' : '追加される見込み |'));
  lines.push(post ? '|---|--:|--:|--:|' : '|---|--:|--:|');
  const rowsDef = [['口コミ合計', 'reviews', entry.expected_reviews - pre.cat_reviews], ['商品合計', 'products', entry.expected_products - pre.cat_products]];
  if (entry.expected_review_sources !== undefined) rowsDef.push(['出典(review_sources)', 'review_sources', entry.expected_review_sources - pre.cat_sources]);
  for (const [label, key, expectedDelta] of rowsDef) {
    if (post) lines.push(`| ${label} | ${t(pre, key)} | ${t(post, key)} | +${post.tables[key].count - pre.tables[key].count} |`);
    else lines.push(`| ${label} | ${t(pre, key)} | +${expectedDelta} |`);
  }
  lines.push('');
  lines.push(`- 既存データの内容ハッシュ照合: ${post ? (ok ? '一致（1件も変わっていません）' : '**不一致 → 要確認**') : '実行前の記録を保存しました'}`);
  lines.push(mode === 'apply' ? '- 本番D1に追加しました。' : '- **本番D1には何も書き込んでいません。**');
  return lines.join('\n');
}
