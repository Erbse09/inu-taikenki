// D1 read-reduction cache (src/d1-cache.ts): same output as an uncached read, fresh after data changes,
// bounded age, and graceful behaviour when D1 or the Cache API fails. Local in-memory SQLite only.
import './ts-loader.mjs';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {DatabaseSync} from 'node:sqlite';
import {readFileSync,readdirSync} from 'node:fs';
import {resolve} from 'node:path';
const {default:worker}=await import('../src/final-entry.ts');
const {__resetD1CacheForTests,DATA_VERSION_SQL,PRODUCTS_VERSION_SQL,productsFingerprint,VERSION_CHECK_MS,HARD_MAX_MS,STALE_IF_ERROR_MS}=await import('../src/d1-cache.ts');
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
const heavy=(log)=>log.filter((sql)=>sql!==DATA_VERSION_SQL&&sql!==PRODUCTS_VERSION_SQL);
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

test('after the version-check window only the data version (3 + one row per product) is read when nothing changed',async()=>{
  const {DB,log}=counting(shared);setup();
  await page('/',{DB,ASSETS,...META});
  now+=VERSION_CHECK_MS+1;log.length=0;
  await page('/',{DB,ASSETS,...META});
  assert.deepEqual(log,[DATA_VERSION_SQL,PRODUCTS_VERSION_SQL]);
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

test('the data-version queries are SELECT-only and pass the Preview read-only guard',async()=>{
  assert.doesNotThrow(()=>assertReadQuery(DATA_VERSION_SQL));
  assert.doesNotThrow(()=>assertReadQuery(PRODUCTS_VERSION_SQL));
  const {DB}=counting(shared);
  const safe=readOnlyDatabase(DB);
  const row=await safe.prepare(DATA_VERSION_SQL).first();
  for(const key of ['r','s','a'])assert(Number.isFinite(row[key]),key);
  const products=(await safe.prepare(PRODUCTS_VERSION_SQL).all()).results;
  assert.equal(products.length,shared.prepare('SELECT COUNT(*) n FROM products').get().n);
});

// ---- Product changes that keep every length, count and total the same (the former length-sum checksum missed these) ----
// The former checksum, kept here only to prove that each case below is one it could not see.
const OLD_LENGTH_CHECKSUM="SELECT COUNT(*) AS n, SUM(active) AS act, SUM(LENGTH(category) * active) AS cat, SUM(LENGTH(name)) AS nm, SUM(LENGTH(COALESCE(affiliate_url, ''))) AS aff, SUM(LENGTH(COALESCE(asin, ''))) AS asin FROM products";
const oldChecksum=(db)=>JSON.stringify(db.prepare(OLD_LENGTH_CHECKSUM).get());
const sameLength=(before,after)=>{assert.notEqual(after,before);assert.equal([...after].length,[...before].length);assert.equal(after.length,before.length);};
const api=async(path,env)=>{const r=await page(path,env);return {status:r.status,json:r.status===200?JSON.parse(r.text):null};};

async function productChangeIsSeen(change,check){
  const db=fullDatabase();const {DB,log}=counting(db);setup();const env={DB,ASSETS,...META};
  await check(env,'before');
  const old=oldChecksum(db);
  change(db);
  assert.equal(oldChecksum(db),old,'the case must be one the former length checksum could not see');
  // Within the window the stored value is kept (same as for review additions) ...
  await check(env,'still-before');
  now+=VERSION_CHECK_MS+1;log.length=0;
  // ... and after it the new content is served, although no review was added and HARD_MAX_MS has not passed.
  await check(env,'after');
  assert(heavy(log).length>0,'recomputed from D1');
}

test('a product name changed to another name of the same length is shown within the version-check window',async()=>{
  const id='pateker-p6';let before,after;
  await productChangeIsSeen((db)=>{
    before=db.prepare('SELECT name FROM products WHERE id=?').get(id).name;
    after=before.slice(0,-1)+(before.at(-1)==='X'?'Y':'X');sameLength(before,after);
    db.prepare('UPDATE products SET name=? WHERE id=?').run(after,id);
  },async(env,phase)=>{
    const name=phase==='after'?after:(before??shared.prepare('SELECT name FROM products WHERE id=?').get(id).name);
    const product=(await api(`/api/products/${id}/reviews?limit=1`,env)).json.product;
    assert.equal(product.name,name,phase);
    assert((await api('/api/products?limit=100&category=dog-clipper&offset=0',env)).json.products.some((p)=>p.id===id&&p.name===name),phase);
    assert((await page('/dog-clipper',env)).text.includes(`data-inu-profile="${id}"`));
    const html=(await page('/dog-clipper',env)).text;
    const card=html.slice(html.indexOf(`data-inu-profile="${id}"`));
    assert(card.slice(0,400).includes(name.replaceAll('&','&amp;')),phase+': server-rendered product overview');
  });
});

test('a product category changed to another category of the same length is shown within the version-check window',async()=>{
  const id='pateker-p6';
  sameLength('dog-clipper','dog-shampoo');
  await productChangeIsSeen((db)=>{
    assert.equal(db.prepare('SELECT category FROM products WHERE id=?').get(id).category,'dog-clipper');
    db.prepare("UPDATE products SET category='dog-shampoo' WHERE id=?").run(id);
  },async(env,phase)=>{
    const moved=phase==='after';
    assert.equal((await api(`/api/products/${id}/reviews?limit=1`,env)).json.product.category,moved?'dog-shampoo':'dog-clipper',phase);
    const inClipper=(await api('/api/products?limit=100&category=dog-clipper&offset=0',env)).json.products.some((p)=>p.id===id);
    const inShampoo=(await api('/api/products?limit=100&category=dog-shampoo&offset=0',env)).json.products.some((p)=>p.id===id);
    assert.deepEqual([inClipper,inShampoo],moved?[false,true]:[true,false],phase);
    assert.equal((await page('/dog-clipper',env)).text.includes(`data-inu-profile="${id}"`),!moved,phase+': /dog-clipper overview');
  });
});

test('an affiliate URL and an ASIN changed to other values of the same length are shown within the version-check window',async()=>{
  const id='pateker-p6';let url,asin;
  await productChangeIsSeen((db)=>{
    const row=db.prepare('SELECT asin,affiliate_url FROM products WHERE id=?').get(id);
    asin=row.asin.slice(0,-1)+(row.asin.at(-1)==='Z'?'Y':'Z');sameLength(row.asin,asin);
    url=row.affiliate_url.replace('tag=100things-22','tag=100things-23');sameLength(row.affiliate_url,url);
    db.prepare('UPDATE products SET asin=?,affiliate_url=? WHERE id=?').run(asin,url,id);
  },async(env,phase)=>{
    const original=shared.prepare('SELECT asin,affiliate_url FROM products WHERE id=?').get(id);
    const expected=phase==='after'?{asin,affiliate_url:url}:original;
    const product=(await api(`/api/products/${id}/reviews?limit=1`,env)).json.product;
    assert.deepEqual({asin:product.asin,affiliate_url:product.affiliate_url},{asin:expected.asin,affiliate_url:expected.affiliate_url},phase);
    const listed=(await api('/api/products?limit=100&category=dog-clipper&offset=0',env)).json.products.find((p)=>p.id===id);
    assert.equal(listed.affiliate_url,expected.affiliate_url,phase);
  });
});

test('swapping the active state of two products (same number of active products) is shown within the version-check window',async()=>{
  const [a,b]=['moizze-pet001','wtw-ipet2971'];
  const db=fullDatabase();
  db.prepare('UPDATE products SET active=0 WHERE id=?').run(b);
  const {DB,log}=counting(db);setup();const env={DB,ASSETS,...META};
  const state=async()=>{
    const ids=(await api('/api/products?limit=100&category=auto-feeder&offset=0',env)).json.products.map((p)=>p.id);
    const html=(await page('/auto-feeder',env)).text;
    return {a:ids.includes(a),b:ids.includes(b),aPage:(await page(`/api/products/${a}/reviews?limit=1`,env)).status,bPage:(await page(`/api/products/${b}/reviews?limit=1`,env)).status,
      aCard:html.includes(`data-inu-profile="${a}"`),bCard:html.includes(`data-inu-profile="${b}"`),count:JSON.parse((await page('/api/reviews/stats?category=auto-feeder',env)).text).count};
  };
  const before=await state();
  assert.deepEqual({...before,count:0},{a:true,b:false,aPage:200,bPage:404,aCard:true,bCard:false,count:0});
  const old=oldChecksum(db);
  db.exec(`UPDATE products SET active=CASE id WHEN '${a}' THEN 0 WHEN '${b}' THEN 1 END WHERE id IN ('${a}','${b}')`);
  assert.equal(oldChecksum(db),old,'same category and same active count: the former checksum was blind to the swap');
  // Within the window stored 200 responses are kept; a 404 is never stored, so the re-activated product answers at once.
  assert.deepEqual(await state(),{...before,bPage:200},'within the window the stored values are kept');
  now+=VERSION_CHECK_MS+1;log.length=0;
  const after=await state();
  assert.deepEqual({...after,count:0},{a:false,b:true,aPage:404,bPage:200,aCard:false,bCard:true,count:0});
  const reviews=(id)=>db.prepare('SELECT COUNT(*) n FROM reviews WHERE product_id=?').get(id).n;
  assert.equal(after.count,before.count-reviews(a)+reviews(b),'category totals follow the swap');
  assert(heavy(log).length>0);
});

test('the products fingerprint is deterministic, ignores row and column order, and changes with any single value',async()=>{
  const rows=shared.prepare('SELECT * FROM products').all().map((r)=>({...r}));
  const base=await productsFingerprint(rows);
  assert.match(base,/^[0-9a-f]{64}$/);
  assert.equal(await productsFingerprint(rows),base);
  assert.equal(await productsFingerprint([...rows].reverse()),base,'row order');
  assert.equal(await productsFingerprint(rows.map((r)=>Object.fromEntries(Object.entries(r).reverse()))),base,'column order');
  const seen=new Set([base]);
  for(const [i,key,value] of [[0,'name',rows[0].name+'!'],[0,'name',rows[0].name.slice(0,-1)+'#'],[1,'category',rows[1].category.replace(/.$/,'#')],[2,'active',rows[2].active?0:1],[3,'asin','B000000000'],[3,'affiliate_url','https://example.com/changed-for-test'],[4,'id',rows[4].id+'x']]){
    const changed=rows.map((r,j)=>j===i?{...r,[key]:value}:r);
    const print=await productsFingerprint(changed);
    assert(!seen.has(print),`${key} change must give a new fingerprint`);seen.add(print);
  }
  // swapping two values between rows keeps every total the same and still changes the fingerprint
  const swapped=rows.map((r)=>({...r}));[swapped[0].name,swapped[1].name]=[swapped[1].name,swapped[0].name];
  assert.notEqual(await productsFingerprint(swapped),base);
  assert.notEqual(await productsFingerprint(rows.slice(1)),base,'a removed product');
});

test('changes the data version does not cover (UPDATE of an existing review) appear within 24 hours, not 10 minutes',async()=>{
  const db=fullDatabase();const {DB}=counting(db);setup();const env={DB,ASSETS,...META};
  const id=db.prepare("SELECT MIN(r.id) id FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.category='dog-clipper'").get().id;
  const url=`/api/reviews?category=dog-clipper&limit=1`;
  const summary=async()=>(await api(url,env)).json.reviews[0].summary;
  const original=await summary();
  for(const [column,value] of [['summary','要約を修正（テスト3）'],['source_url','https://example.com/changed']])db.prepare(`UPDATE reviews SET ${column}=? WHERE id=?`).run(value,id);
  now+=VERSION_CHECK_MS+1;
  assert.equal(await summary(),original,'not detected by the data version: kept after 10 minutes');
  now+=HARD_MAX_MS-VERSION_CHECK_MS-2;
  assert.equal(await summary(),original,'still kept just before 24 hours');
  now+=2;
  assert.equal(await summary(),'要約を修正（テスト3）','recomputed at 24 hours');
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

// ---- Finished-page cache (readPage / writePage): CPU on a newly started isolate, never at the cost of correctness ----
function countedAssets(){
  const calls=[];
  return {calls,ASSETS:{async fetch(req){calls.push(new URL(req.url).pathname);return ASSETS.fetch(req);}}};
}
const uncached=async(path)=>{delete globalThis.caches;__resetD1CacheForTests(()=>now);return page(path,{DB:counting(shared).DB,ASSETS});};

test('a repeated page view is served from the stored page: no D1 statement and no HTML rewrite pipeline',async()=>{
  for(const path of ['/','/about','/review-search?category=brush-pin&size=small','/dog-harness','/dog-size?size=large']){
    const reference=await uncached(path);
    const {DB,log}=counting(shared);setup();const a=countedAssets();const env={DB,ASSETS:a.ASSETS,...META};
    const first=await page(path,env);
    assert.equal(first.text,reference.text,path);assert.equal(a.calls.length,1);
    log.length=0;
    const again=await page(path,env);
    assert.equal(again.text,reference.text,path+' warm');assert.equal(again.status,200);
    for(const h of ['content-type','cache-control'])assert.equal(again.headers.get(h),reference.headers.get(h),path+' '+h);
    assert.equal(a.calls.length,1,path+': the pipeline did not run again');assert.deepEqual(log,[],path+': no D1 statement');
    // a newly started isolate in the same data center: isolate memory empty, the Cache API answers
    __resetD1CacheForTests(()=>now);
    const fresh=await page(path,env);
    assert.equal(fresh.text,reference.text,path+' new isolate');assert.equal(a.calls.length,1);assert.deepEqual(log,[],path+': still no D1 statement');
  }
});

test('a page built while D1 cannot be read is never stored: real totals return as soon as D1 recovers',async()=>{
  const {DB,setDown}=counting(shared);setup();const env={DB,ASSETS,...META};
  setDown(true);
  const down=(await page('/about',env)).text;
  assert(!/合計\d+件/.test(down),'without D1 the page claims no total');
  setDown(false);
  const up=(await page('/about',env)).text;
  assert.match(up,/合計2262件/,'no time passed, yet the real total is shown: the degraded page was not kept');
});

test('a page built from a stale fragment (a query failed, the data version could still be read) is not stored',async()=>{
  // The case where writePage could otherwise stamp the new data version on old numbers.
  const db=fullDatabase();let failBreakdown=false;
  const base=counting(db).DB;
  const DB={prepare(sql){if(failBreakdown&&sql.startsWith('SELECT r.source_type, r.source_url FROM reviews'))throw new Error('breakdown down');return base.prepare(sql);}};
  setup();const env={DB,ASSETS,...META};
  const total=(html)=>Number(html.match(/合計(\d+)件/)[1]);
  const before=total((await page('/about',env)).text);
  db.exec("INSERT INTO reviews(product_id,summary,dog_size,source_type,source_url) VALUES('karikari-machine-v2c-plus','追加された体験の要約（劣化ページのテスト）','small','public_experience_summary','https://example.com/')");
  failBreakdown=true;now+=VERSION_CHECK_MS+1;
  assert.equal(total((await page('/about',env)).text),before,'old numbers shown while the query fails (unchanged stale-if-error behaviour)');
  failBreakdown=false;
  assert.equal(total((await page('/about',env)).text),before+1,'no time passed: the page with old numbers was not stored under the new data version');
});

test('a page built from a stale API body (the API query threw, the data version could still be read) is not stored',async()=>{
  const db=fullDatabase();let failGroups=false;
  const base=counting(db).DB;
  const DB={prepare(sql){if(failGroups&&sql.includes('GROUP BY p.id ORDER BY count DESC,p.id LIMIT ? OFFSET ?'))throw new Error('groups down');return base.prepare(sql);}};
  setup();const env={DB,ASSETS,...META};
  const smallCount=(html)=>Number(html.match(/該当体験 (\d+)件/)[1]);
  const before=smallCount((await page('/dog-size',env)).text);
  db.exec("INSERT INTO reviews(product_id,summary,dog_size,source_type,source_url) VALUES('karikari-machine-v2c-plus','追加された小型犬の体験（劣化ページのテスト）','small','public_experience_summary','https://example.com/')");
  failGroups=true;now+=VERSION_CHECK_MS+1;
  assert.equal(smallCount((await page('/dog-size',env)).text),before,'the stored API body from before is shown while the query fails');
  failGroups=false;
  assert.equal(smallCount((await page('/dog-size',env)).text),before+1,'no time passed: the page with the stale API body was not stored');
});

test('a page that reads no data needs no D1 even after the version-check window, and still ends with the hard maximum',async()=>{
  const reference=await uncached('/privacy');
  const {DB,log}=counting(shared);setup();const a=countedAssets();const env={DB,ASSETS:a.ASSETS,...META};
  assert.equal((await page('/privacy',env)).text,reference.text);
  assert.deepEqual(log,[],'/privacy reads no data');
  now+=VERSION_CHECK_MS+1;
  assert.equal((await page('/privacy',env)).text,reference.text);
  assert.deepEqual(log,[],'no data-version check for a page without data');
  assert.equal(a.calls.length,1);
  now+=HARD_MAX_MS;
  await page('/privacy',env);
  assert.equal(a.calls.length,2,'rebuilt after the hard maximum');
  await page('/privacy',{...env,CF_VERSION_METADATA:{id:'test-version-2'}});
  assert.equal(a.calls.length,3,'a new deploy (new static assets and code) rebuilds it');
});

test('redirects, 404s and HEAD requests are never stored and cause no D1 read',async()=>{
  const {DB,log}=counting(shared);const {colo}=setup();const env={DB,ASSETS,...META};
  for(let i=0;i<2;i++){
    assert.equal((await page('/brush-pin.html',env)).status,301);
    assert.equal((await page('/no-such-page',env)).status,404);
    const head=await worker.fetch(new Request('https://inu-taikenki.com/about',{method:'HEAD'}),env);assert.equal(head.status,200);
  }
  assert.deepEqual(log,[]);
  assert(![...colo.store.keys()].some((k)=>/page%3A%2F(brush-pin\.html|no-such-page)/.test(k)),'no stored page for a redirect or a 404');
});

test('query strings are separate pages and each matches the uncached output',async()=>{
  const paths=['/review-search?category=brush-pin','/review-search?category=dog-harness','/review-search','/dog-size?size=medium','/dog-size'];
  const reference={};for(const p of paths)reference[p]=(await uncached(p)).text;
  const {DB}=counting(shared);setup();const env={DB,ASSETS,...META};
  for(let round=0;round<2;round++)for(const p of paths)assert.equal((await page(p,env)).text,reference[p],p+' round '+round);
  assert.notEqual(reference[paths[0]],reference[paths[1]]);
});

test('a page whose server-rendered fallback failed is not stored, so the fallback returns when the API recovers',async()=>{
  let failGroups=true;
  const base=counting(shared).DB;
  const DB={prepare(sql){if(failGroups&&sql.includes('COUNT(*) AS count FROM reviews r JOIN products p ON p.id=r.product_id')&&sql.includes('GROUP BY p.id ORDER BY count DESC,p.id LIMIT ? OFFSET ?'))throw new Error('groups down');return base.prepare(sql);}};
  setup();const env={DB,ASSETS,...META};
  const broken=(await page('/dog-size',env)).text;
  // data-static-size-card exists only in the server-rendered fallback (the static HTML has no such element)
  assert(!readFileSync('public/dog-size.html','utf8').includes('data-static-size-card'));
  assert(!broken.includes('data-static-size-card'),'fallback missing while the API fails');
  failGroups=false;
  const ok=(await page('/dog-size',env)).text;
  assert(ok.includes('data-static-size-card'),'the page without its fallback was not stored');
  assert.equal(ok,(await uncached('/dog-size')).text);
});

test('a new review reaches stored pages within the version-check window',async()=>{
  const db=fullDatabase();const {DB}=counting(db);setup();const env={DB,ASSETS,...META};
  const total=(html)=>Number(html.match(/合計(\d+)件/)[1]);
  const before=total((await page('/about',env)).text);
  db.exec("INSERT INTO reviews(product_id,summary,dog_size,source_type,source_url) VALUES('karikari-machine-v2c-plus','追加された体験の要約（ページ保存のテスト）','small','public_experience_summary','https://example.com/')");
  assert.equal(total((await page('/about',env)).text),before);
  now+=VERSION_CHECK_MS+1;
  assert.equal(total((await page('/about',env)).text),before+1);
});
