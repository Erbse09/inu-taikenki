// D1 read-reduction cache (src/d1-cache.ts): same output as an uncached read, fresh after data changes,
// bounded age, and graceful behaviour when D1 or the Cache API fails. Local in-memory SQLite only.
import './ts-loader.mjs';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {DatabaseSync} from 'node:sqlite';
import {readFileSync,readdirSync} from 'node:fs';
import {resolve} from 'node:path';
const {default:worker}=await import('../src/final-entry.ts');
const {__resetD1CacheForTests,DATA_VERSION_SQL,VERSION_CHECK_MS,HARD_MAX_MS,STALE_IF_ERROR_MS}=await import('../src/d1-cache.ts');
const {assertReadQuery,readOnlyDatabase}=await import('../src/readonly-db.ts');
const {reviewApi}=await import('../src/review-api.ts');
const {legacyDatabase,migrate}=await import('./database.mjs');

function fullDatabase(){
  // Same data the production D1 was built from: legacy seed + every additive migration.
  const db=legacyDatabase();migrate(db);
  for(const name of readdirSync('migrations').sort()){
    if(!/^\d{4}_/.test(name)||Number(name.slice(0,4))<=18)continue;
    db.exec(readFileSync('migrations/'+name,'utf8'));
  }
  return db;
}
const shared=fullDatabase();

function counting(db){
  const log=[];let down=false;
  const DB={prepare(sql){if(down)throw new Error('db down');let values=[];const st={bind(...v){values=v;return st;},
    async all(){if(down)throw new Error('db down');log.push(sql);return {results:db.prepare(sql).all(...values)};},
    async first(){if(down)throw new Error('db down');log.push(sql);return db.prepare(sql).get(...values)??null;}};return st;}};
  return {DB,log,setDown(v){down=v;}};
}
// One Cache API per data center: a plain map of serialized responses.
function fakeCache(){
  const store=new Map();let broken=false;
  return {store,setBroken(v){broken=v;},cache:{
    async match(req){if(broken)throw new Error('cache down');const hit=store.get(new Request(req).url);return hit?new Response(hit.body,{headers:hit.headers}):undefined;},
    async put(req,res){if(broken)throw new Error('cache down');store.set(new Request(req).url,{body:await res.text(),headers:[...res.headers]});},
  }};
}
const ASSETS={async fetch(req){let p=new URL(req.url).pathname;if(p==='/')p='/index.html';if(!p.split('/').at(-1).includes('.'))p+='.html';try{return new Response(readFileSync(resolve('public','.'+p)),{headers:{'content-type':'text/html; charset=utf-8'}});}catch{return new Response('nf',{status:404});}}};
const META={CF_VERSION_METADATA:{id:'test-version-1'}};
let now=1_800_000_000_000;
function setup(extra={}){
  now+=10*STALE_IF_ERROR_MS;__resetD1CacheForTests(()=>now);
  const colo=fakeCache();globalThis.caches={default:colo.cache};
  return {colo};
}
const page=async(path,env)=>{const r=await worker.fetch(new Request('https://inu-taikenki.com'+path),env);return {status:r.status,headers:r.headers,text:await r.text()};};
const heavy=(log)=>log.filter((sql)=>sql!==DATA_VERSION_SQL);
const PAGES=['/','/about','/editorial-policy','/review-search','/review-insights','/dog-size','/breed-toy-poodle','/brush-pin','/pet-dryer','/dog-harness',
  '/api/reviews/stats','/api/reviews?limit=20','/api/reviews?q=%E6%80%96%E3%81%8C%E3%82%8A','/api/reviews/groups?size=small','/api/products','/api/products/karikari-machine-v2c-plus/reviews'];

test('cached pages and API bodies are byte-identical to an uncached read of the same data',async()=>{
  // Reference: no cache at all (no Cache API, and a fresh DB object per request so isolate memory never hits).
  delete globalThis.caches;__resetD1CacheForTests(()=>now);
  const reference={};
  for(const p of PAGES){const r=await page(p,{DB:counting(shared).DB,ASSETS});reference[p]=r;}
  const {DB,log}=counting(shared);setup();
  for(let round=0;round<2;round++)for(const p of PAGES){
    const r=await page(p,{DB,ASSETS,...META});
    assert.equal(r.status,reference[p].status,p);assert.equal(r.text,reference[p].text,p+' round '+round);
    for(const h of ['content-type','cache-control','x-robots-tag'])assert.equal(r.headers.get(h),reference[p].headers.get(h),p+' '+h);
  }
  assert(reference['/'].text.includes('件'));
  assert(!/\b(undefined|NaN)\b/.test(reference['/review-insights'].text));
});

test('repeat views read nothing heavy from D1; the summary is computed once for counts, breakdown and count note',async()=>{
  const {DB,log}=counting(shared);setup();
  await page('/review-search',{DB,ASSETS,...META});
  const first=log.length;
  // The headline COUNT is no longer a separate query, and the breakdown runs once although two fragments use it.
  assert.equal(log.filter((s)=>s.startsWith('SELECT r.source_type, r.source_url FROM reviews')).length,1);
  assert.equal(log.filter((s)=>s.includes('AS total_reviews')).length,0);
  for(const p of ['/review-search','/','/about','/review-search'])await page(p,{DB,ASSETS,...META});
  assert.equal(log.length,first,'no D1 statement at all within the version-check window');
  // Another isolate in the same data center: memory is empty, the Cache API still answers.
  const before=log.length;__resetD1CacheForTests(()=>now);
  await page('/review-search',{DB,ASSETS,...META});
  assert.equal(log.length,before,'served from the Cache API');
});

test('after the version-check window only the 144-row fingerprint is read when nothing changed',async()=>{
  const {DB,log}=counting(shared);setup();
  await page('/',{DB,ASSETS,...META});
  now+=VERSION_CHECK_MS+1;log.length=0;
  await page('/',{DB,ASSETS,...META});
  assert.deepEqual(log,[DATA_VERSION_SQL]);
});

test('a newly added review shows up after the version-check window, in counts and in the API',async()=>{
  const db=fullDatabase();const {DB,log}=counting(db);setup();
  const total=async()=>Number((await page('/api/reviews/stats',{DB,ASSETS,...META})).text.match(/"count":(\d+)/)[1]);
  const html=async()=>(await page('/about',{DB,ASSETS,...META})).text;
  const before=await total();assert((await html()).includes(`合計${before}件`));
  db.exec("INSERT INTO reviews(product_id,summary,dog_size,source_type,source_url) VALUES('karikari-machine-v2c-plus','追加された体験の要約（テスト）','small','public_experience_summary','https://example.com/')");
  assert.equal(await total(),before,'within the window the stored value is kept');
  now+=VERSION_CHECK_MS+1;
  assert.equal(await total(),before+1);
  assert((await html()).includes(`合計${before+1}件`));
});

test('product changes (deactivation) invalidate cached product lists and product pages',async()=>{
  const db=fullDatabase();const {DB}=counting(db);setup();
  const id='karikari-machine-v2c-plus';
  assert.equal((await page(`/api/products/${id}/reviews`,{DB,ASSETS,...META})).status,200);
  db.prepare('UPDATE products SET active=0 WHERE id=?').run(id);
  now+=VERSION_CHECK_MS+1;
  assert.equal((await page(`/api/products/${id}/reviews`,{DB,ASSETS,...META})).status,404,'no stored 200 is served for a product that is gone');
});

test('an edit the fingerprint cannot see is still picked up within the hard maximum age',async()=>{
  const db=fullDatabase();const {DB}=counting(db);setup();
  const url='/api/reviews?product=karikari-machine-v2c-plus&limit=1';
  const first=JSON.parse((await page(url,{DB,ASSETS,...META})).text).reviews[0];
  db.prepare('UPDATE reviews SET summary=? WHERE id=?').run('要約を修正（テスト）',first.id);
  now+=VERSION_CHECK_MS+1;
  assert.equal(JSON.parse((await page(url,{DB,ASSETS,...META})).text).reviews[0].summary,first.summary);
  now+=HARD_MAX_MS;
  assert.equal(JSON.parse((await page(url,{DB,ASSETS,...META})).text).reviews[0].summary,'要約を修正（テスト）');
});

test('without the version-metadata binding entries live no longer than the former 10-minute cache',async()=>{
  const db=fullDatabase();const {DB}=counting(db);setup();
  const url='/api/reviews?product=karikari-machine-v2c-plus&limit=1';
  const first=JSON.parse((await page(url,{DB,ASSETS})).text).reviews[0];
  db.prepare('UPDATE reviews SET summary=? WHERE id=?').run('要約を修正（テスト2）',first.id);
  now+=VERSION_CHECK_MS+1;
  assert.equal(JSON.parse((await page(url,{DB,ASSETS})).text).reviews[0].summary,'要約を修正（テスト2）');
});

test('a new deploy (other Worker version) never reuses entries rendered by the previous version',async()=>{
  const {DB,log}=counting(shared);setup();
  await page('/brush-pin',{DB,ASSETS,...META});
  const before=log.length;
  await page('/brush-pin',{DB,ASSETS,CF_VERSION_METADATA:{id:'test-version-2'}});
  assert(heavy(log.slice(before)).length>0,'the new version computes its own fragment');
});

test('when D1 fails, a recent entry is shown; after a day the stale-count guard applies again',async()=>{
  const {DB,setDown}=counting(shared);setup();
  const ok=await page('/',{DB,ASSETS,...META});
  const live=ok.text.match(/合計(\d+)件|(\d{4})件/);assert(live);
  setDown(true);
  now+=VERSION_CHECK_MS+1;
  assert.equal((await page('/',{DB,ASSETS,...META})).text,ok.text,'recent numbers instead of an error or a dash');
  const stats=await page('/api/reviews/stats',{DB,ASSETS,...META});
  assert.equal(stats.status,503,'nothing stored for this URL yet: the API error passes through');
  now+=STALE_IF_ERROR_MS;
  const later=(await page('/',{DB,ASSETS,...META})).text.replace(/(?:最初の|初期の)約?[\d,]+件/g,'').replace(/<script[\s\S]*?<\/script>|<style[\s\S]*?<\/style>/g,'');
  assert(!/(?:700|750)件/.test(later));
});

test('when the Cache API fails every page is still built correctly from D1',async()=>{
  delete globalThis.caches;__resetD1CacheForTests(()=>now);
  const reference=await page('/review-search',{DB:counting(shared).DB,ASSETS});
  const {DB}=counting(shared);const {colo}=setup();colo.setBroken(true);
  for(let i=0;i<2;i++){
    __resetD1CacheForTests(()=>now);
    const r=await page('/review-search',{DB,ASSETS,...META});
    assert.equal(r.status,200);assert.equal(r.text,reference.text);
  }
});

test('invalid API input is never stored and still answers 400',async()=>{
  const {DB}=counting(shared);const {colo}=setup();
  for(let i=0;i<2;i++)assert.equal((await page('/api/reviews?limit=abc',{DB,ASSETS,...META})).status,400);
  assert(![...colo.store.keys()].some((k)=>k.includes('limit%3Dabc')||k.includes('limit=abc')));
});

test('the fingerprint query is SELECT-only and passes the Preview read-only guard',async()=>{
  assert.doesNotThrow(()=>assertReadQuery(DATA_VERSION_SQL));
  const {DB}=counting(shared);
  const row=await readOnlyDatabase(DB).prepare(DATA_VERSION_SQL).first();
  for(const key of ['r','s','a','n','act'])assert(Number.isFinite(row[key]),key);
});

test('facet counts keep exactly the former three-table join result for every filter',async()=>{
  // The former SQL, rebuilt from the new statement, runs side by side on the same data.
  const pairs=[];
  const DB={prepare(sql){let values=[];const st={bind(...v){values=v;return st;},
    async all(){
      const rows=shared.prepare(sql).all(...values);
      const m=sql.match(/^(SELECT a\.kind,[\s\S]*? AS count) FROM review_attributes a WHERE a\.review_id IN \(SELECT r\.id FROM reviews r JOIN products p ON p\.id=r\.product_id WHERE ([\s\S]*)\) (GROUP BY a\.kind,[\s\S]*)$/);
      if(m)pairs.push([rows,shared.prepare(`${m[1]} FROM review_attributes a JOIN reviews r ON r.id=a.review_id JOIN products p ON p.id=r.product_id WHERE ${m[2]} ${m[3]}`).all(...values)]);
      return {results:rows};},
    async first(){return shared.prepare(sql).get(...values)??null;}};return st;}};
  const queries=['','?category=brush-pin','?size=small','?coat=curly','?trait=multi','?trait=skin','?size=large&coat=double','?breed=%E3%83%88%E3%82%A4%E3%83%97%E3%83%BC%E3%83%89%E3%83%AB','?q=%E6%80%96%E3%81%8C%E3%82%8A','?category=dog-harness&size=medium&trait=puppy','?product=karikari-machine-v2c-plus','?q=nothing-matches'];
  for(const q of queries)assert.equal((await reviewApi(new Request('https://inu.test/api/reviews/stats'+q),DB)).status,200,q);
  assert.equal(pairs.length,queries.length);
  for(const [now_,old] of pairs)assert.deepEqual(now_,old);
  assert(pairs[0][0].length>10);
});
