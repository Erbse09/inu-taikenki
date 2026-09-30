// Preview-only capability wrapper. Never pass the real D1 binding to the app.
// This is application enforcement, NOT a Cloudflare read-only database role.
type Value = string | number | null;
interface Statement {
  bind(...values: Value[]): Statement;
  all<T>(): Promise<{results?: T[]}>;
  first<T>(): Promise<T | null>;
}
interface Database { prepare(query: string): Statement }
const forbidden = /\b(?:INSERT|UPDATE|DELETE|REPLACE|CREATE|DROP|ALTER|PRAGMA|ATTACH|DETACH|VACUUM|REINDEX|ANALYZE|BEGIN|COMMIT|ROLLBACK|SAVEPOINT|RELEASE|WITH|EXPLAIN|LOAD_EXTENSION)\b/i;
const functions = new Set('COUNT SUM NULLIF TRIM INSTR COALESCE LOWER UPPER MIN MAX AVG ROUND LENGTH ABS CAST'.split(' '));
const groups = new Set('IN EXISTS FROM WHERE AND OR NOT ON SELECT AS BY WHEN THEN ELSE HAVING'.split(' '));
export function assertReadQuery(sql: string): void {
  if (typeof sql !== 'string') throw new Error('Preview SQL rejected');
  // Remove string literals without letting quoted function names or comments escape validation.
  let tokens = '';
  for (let i = 0; i < sql.length; i++) {
    const ch = sql[i];
    if (ch === "'") {
      let closed = false;
      for (++i; i < sql.length; i++) {
        if (sql[i] === "'") {
          if (sql[i + 1] === "'") { i++; continue; }
          closed = true; break;
        }
      }
      if (!closed || /^\s*\(/.test(sql.slice(i + 1))) throw new Error('Preview SQL rejected');
      tokens += ' ? ';
    } else {
      if (/['"`;\[\]\u0000]/.test(ch) || sql.slice(i,i+2) === '--' || sql.slice(i,i+2) === '/*') throw new Error('Preview SQL rejected');
      tokens += ch;
    }
  }
  if (!/^\s*SELECT\b/i.test(tokens) || forbidden.test(tokens)) throw new Error('Preview SQL must be SELECT only');
  for (const match of tokens.matchAll(/([A-Za-z_][A-Za-z0-9_]*)\s*\(/g)) {
    const word = match[1].toUpperCase();
    if (!functions.has(word) && !groups.has(word)) throw new Error('Preview SQL function rejected');
  }
}
const deny = (): never => { throw new Error('Preview database is read-only'); };
function frozen<T extends object>(methods: T): T {
  return Object.freeze(Object.assign(Object.create(null), methods));
}
export function readOnlyDatabase(database: Database): Database {
  const wrap = (statement: Statement, sql: string): Statement => frozen({
    bind: (...values: Value[]) => wrap(statement.bind(...values), sql),
    all: <T>() => { assertReadQuery(sql); return statement.all<T>(); },
    first: <T>() => { assertReadQuery(sql); return statement.first<T>(); },
    run: deny, raw: deny,
  });
  return frozen({
    prepare: (sql: string) => { assertReadQuery(sql); return wrap(database.prepare(sql), sql); },
    exec: deny, batch: deny, dump: deny, withSession: deny,
  });
}
