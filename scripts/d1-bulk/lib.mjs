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
