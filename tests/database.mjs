import { DatabaseSync } from 'node:sqlite';
import { readFileSync, readdirSync } from 'node:fs';
export function legacyDatabase() {
  const db=new DatabaseSync(':memory:');
  db.exec(readFileSync('migrations/0001_init.sql','utf8'));
  // Destructive historical seed is ONLY run in this disposable in-memory DB.
  db.exec(readFileSync('seed.sql','utf8'));
  for(const name of readdirSync('migrations').sort()) {
    if(!/^\d/.test(name)||name.startsWith('0001_')||Number(name.slice(0,4))>=18)continue;
    db.exec(readFileSync('migrations/'+name,'utf8'));
  }
  return db;
}
export function migrate(db){db.exec(readFileSync('migrations/0018_scalable_review_foundation.sql','utf8'));}
export function binding(db, log=[]) {
  return {prepare(sql){return {values:[],bind(...v){this.values=v;return this;},async all(){log.push({sql,values:this.values});return {results:db.prepare(sql).all(...this.values)};},async first(){log.push({sql,values:this.values});return db.prepare(sql).get(...this.values)||null;}};}};
}
