import './ts-loader.mjs';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {DatabaseSync} from 'node:sqlite';
import {readFileSync,readdirSync} from 'node:fs';
import {execFileSync} from 'node:child_process';
import {readOnlyDatabase,assertReadQuery} from '../src/readonly-db.ts';
import preview from '../src/preview-entry.ts';
import {reviewApi} from '../src/review-api.ts';
import {binding} from './database.mjs';

test('write SQL is rejected before D1 prepare, including all/first misuse and disguised operations',()=>{
 let calls=0;
 const safe=readOnlyDatabase({prepare(){calls++;throw Error('D1 must not be touched');}});
 for(const sql of [
  'INSERT INTO reviews(summary) VALUES(1)','UPDATE reviews SET summary=1 WHERE 0',
  'DELETE FROM reviews WHERE 0','CREATE TABLE x(a)','DROP TABLE reviews','ALTER TABLE reviews ADD x',
  'REPLACE INTO reviews VALUES(1)','PRAGMA user_version=1','ATTACH DATABASE \'x\' AS x',
  'VACUUM','REINDEX','ANALYZE','BEGIN','COMMIT','ROLLBACK','SAVEPOINT a','RELEASE a',
  'WITH x AS (SELECT 1) DELETE FROM reviews','EXPLAIN DELETE FROM reviews',
  'SELECT 1; DELETE FROM reviews','SELECT 1 -- comment','SELECT /* comment */ 1',
  'SELECT load_extension(\'x\')','SELECT writefile(\'x\',1)','SELECT eval(\'DELETE FROM reviews\')',
  'SELECT "writefile"(\'x\',1)','SELECT [writefile](\'x\',1)',"SELECT 'writefile'('x',1)",
  'SELECT `writefile`(\'x\',1)','SELECT 1\u0000; DELETE FROM reviews',"SELECT 'unterminated",
 ]) assert.throws(()=>safe.prepare(sql),/Preview/,sql);
 assert.equal(calls,0);
});
test('binding and statements expose no write capabilities or raw binding',async()=>{
 let calls=0;const statement={bind(){return this;},async all(){calls++;return {results:[{n:1}]};},async first(){calls++;return {n:1};}};
 const safe=readOnlyDatabase({prepare(){return statement;}});
 for(const method of ['exec','batch','dump','withSession']) assert.throws(()=>safe[method]('SELECT 1'),/read-only/);
 const s=safe.prepare('SELECT 1 AS n');
 for(const method of ['run','raw'])assert.throws(()=>s[method](),/read-only/);
 assert.equal(Object.getPrototypeOf(safe),null);assert(Object.isFrozen(safe));assert(Object.isFrozen(s));
 assert.deepEqual(await s.bind("'; DELETE FROM reviews; --").all(),{results:[{n:1}]});
 assert.deepEqual(await s.first(),{n:1});assert.equal(calls,2);
 assert.doesNotThrow(()=>assertReadQuery("SELECT 'don''t DELETE; --' AS literal"));
});
test('every API query remains compatible with read-only enforcement; local fixture only, no seed',async()=>{
 const db=new DatabaseSync(':memory:');
 db.exec(readFileSync('migrations/0001_init.sql','utf8'));
 db.exec(readFileSync('migrations/0018_scalable_review_foundation.sql','utf8'));
 db.exec("INSERT INTO products(id,name,category)VALUES('preview-test','Fixture product','brush-pin'); INSERT INTO reviews(product_id,summary,dog_size,coat_type,needs,dog_breed)VALUES('preview-test','Fixture summary','small','curly','scared','テスト犬');");
 const before=db.serialize();const log=[];
 const raw=binding(db,log),safe=readOnlyDatabase(raw);
 const paths=['/api/products','/api/products/preview-test/reviews','/api/reviews','/api/reviews/stats','/api/reviews/groups'];
 for(const path of paths)for(const query of ['','?category=brush-pin&size=small&coat=curly&trait=scared&breed=テスト犬&q=Fixture','?q=missing']){
  const req=new Request('https://preview.test'+path+query);
  const a=await reviewApi(req,raw),b=await reviewApi(req,safe);
  assert.equal(b.status,200,path+query);assert.deepEqual(await b.json(),await a.json());
 }
 const env={APP_ENV:'preview',DB:raw,ASSETS:{async fetch(){return new Response('<html><head><title>Fixture</title></head><body>Fixture</body></html>',{headers:{'content-type':'text/html'}});}}};
 for(const path of ['/','/brush-pin','/pet-dryer','/review-search','/review-insights','/dog-size','/about','/api/health']){
  const r=await preview.fetch(new Request('https://preview.test'+path),env);
  assert.equal(r.status,200,path);assert.match(r.headers.get('x-robots-tag'),/noindex/);
  assert(!/\b(undefined|NaN)\b/.test(await r.text()));
 }
 const count=log.length;
 for(const method of ['POST','PUT','PATCH','DELETE','OPTIONS'])for(const path of ['/api/reviews','/api/admin','/api/products','/']){
  const r=await preview.fetch(new Request('https://preview.test'+path,{method}),env);
  assert.equal(r.status,405);assert.match(r.headers.get('x-robots-tag'),/noindex/);
 }
 assert.equal(log.length,count);assert.deepEqual(db.serialize(),before);db.close();
});
test('application cannot bypass wrapped env through cloudflare global imports',()=>{
 for(const file of readdirSync('src').filter(x=>x.endsWith('.ts'))){
  assert(!/cloudflare:workers|process\.env|import\s*\(/.test(readFileSync('src/'+file,'utf8')),file);
 }
});
test('legacy upload/deploy uses main-only build guard; develop fails closed',()=>{
 for(const branch of ['develop','feature/test','']){
  assert.throws(()=>execFileSync(process.execPath,['scripts/production-build-guard.mjs'],{env:{...process.env,WORKERS_CI_BRANCH:branch},stdio:'pipe'}));
 }
 assert.match(execFileSync(process.execPath,['scripts/production-build-guard.mjs'],{env:{...process.env,WORKERS_CI_BRANCH:'main'},encoding:'utf8'}),/main/);
});
