import './ts-loader.mjs';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {resolve} from 'node:path';
const {reviewApi}=await import('../src/review-api.ts');
const {EXCLUDED_REVIEW_IDS,notExcludedSql}=await import('../src/excluded-reviews.ts');
const {LEDGER}=await import('../src/review-source-ledger.ts');
const {loadSourceBreakdown,loadCategoryProfiles}=await import('../src/product-profiles.ts');
const {neutralizeStaleCounts,applyLiveCounts}=await import('../src/live-counts.ts');
const {default:worker}=await import('../src/final-entry.ts');
const {legacyDatabase,migrate,binding}=await import('./database.mjs');
const {DatabaseSync}=await import('node:sqlite');

const AUDITED_CAT_IDS=[524,1194,1401,1402,1403,1412,1431,1433,1434,1435];

test('excluded ids are exactly the ten audit status-C rows, taken from the ledger',()=>{
  assert.deepEqual([...EXCLUDED_REVIEW_IDS],AUDITED_CAT_IDS);
  assert.deepEqual(EXCLUDED_REVIEW_IDS,Object.keys(LEDGER).filter(id=>LEDGER[id][0]==='C').map(Number).sort((a,b)=>a-b));
  assert.equal(notExcludedSql('r'),`r.id NOT IN (${AUDITED_CAT_IDS.join(',')})`);
  assert.throws(()=>notExcludedSql('r; DROP'));
});

function seeded(){
  const db=legacyDatabase();migrate(db);
  db.exec("INSERT INTO products(id,name,category,active)VALUES('cat-test','Cat Test','auto-feeder',1)");
  const ins=db.prepare('INSERT INTO reviews(id,product_id,dog_breed,dog_size,coat_type,needs,summary,source_type,source_url)VALUES(?,?,?,?,?,?,?,?,?)');
  for(const id of [...AUDITED_CAT_IDS.filter(i=>i>1000),700001,700002]){
    ins.run(id,'cat-test','チワワ','small','short','scared','テスト用の要約です。','public_buyer_review_summary','https://example.test/');
  }
  return db;
}

test('every public API view leaves the cat-owner rows out while the rows stay in the table',async()=>{
  const db=seeded();
  const physical=db.prepare('SELECT count(*) n FROM reviews').get().n;
  const physicalExcluded=db.prepare(`SELECT count(*) n FROM reviews WHERE id IN (${AUDITED_CAT_IDS.join(',')})`).get().n;
  assert(physicalExcluded>=1);
  const get=async(p)=>{const r=await reviewApi(new Request('https://inu.test'+p),binding(db));return await r.json();};
  const all=await get('/api/reviews?limit=100&category=auto-feeder');
  assert(all.reviews.every(r=>!AUDITED_CAT_IDS.includes(r.id)));
  const test1=await get('/api/products/cat-test/reviews?limit=100');
  assert.deepEqual(test1.reviews.map(r=>r.id),[700001,700002],'only the two normal rows remain for this product');
  assert.equal(test1.count,2);
  const stats=await get('/api/reviews/stats?category=auto-feeder');
  assert.equal(stats.count,all.count,'stats total equals the list total');
  const sizeFacet=stats.facets.find(f=>f.kind==='size'&&f.value==='small');
  const smallList=await get('/api/reviews?category=auto-feeder&size=small&limit=100');
  assert.equal(sizeFacet.count,smallList.count,'facet counts agree with the list');
  assert.equal(stats.categories.find(c=>c.category==='auto-feeder').count,all.count);
  const groups=await get('/api/reviews/groups?category=auto-feeder&limit=20');
  assert.equal(groups.groups.find(g=>g.product_id==='cat-test').count,2);
  assert(groups.groups.every(g=>g.reviews.every(r=>!AUDITED_CAT_IDS.includes(r.id))));
  assert.equal((await get('/api/reviews?q='+encodeURIComponent('テスト用の要約'))).count,2);
  const prods=await get('/api/products?category=auto-feeder&limit=100');
  assert.equal(prods.products.find(p=>p.id==='cat-test').review_count,2);
  assert.equal(db.prepare('SELECT count(*) n FROM reviews').get().n,physical,'nothing was deleted');
});

test('row 524 in the legacy data is excluded from its own product count and from the headline',async()=>{
  const db=seeded();
  const row=db.prepare('SELECT product_id FROM reviews WHERE id=524').get();
  if(!row)return;
  const total=db.prepare('SELECT count(*) n FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.active=1').get().n;
  const stats=await (await reviewApi(new Request('https://inu.test/api/reviews/stats'),binding(db))).json();
  assert.equal(stats.count,total-db.prepare(`SELECT count(*) n FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.active=1 AND r.id IN (${AUDITED_CAT_IDS.join(',')})`).get().n);
});

test('headline total, source breakdown and category profiles agree with the API',async()=>{
  const db=seeded();
  const b=binding(db);
  const stats=await (await reviewApi(new Request('https://inu.test/api/reviews/stats'),b)).json();
  const breakdown=await loadSourceBreakdown(b);
  assert.equal(breakdown.total,stats.count);
  const profiles=await loadCategoryProfiles(b,'auto-feeder');
  const listed=await (await reviewApi(new Request('https://inu.test/api/reviews?category=auto-feeder&limit=100'),b)).json();
  assert.equal(profiles.reduce((n,p)=>n+p.count,0),listed.count);
  // the Worker's own headline query (used for "N件" in titles and heroes)
  const ASSETS={async fetch(){return new Response('<html><head><title>犬用品の公開体験750件</title></head><body><main><h1>750件</h1></main></body></html>',{headers:{'content-type':'text/html'}});}};
  const html=await (await worker.fetch(new Request('https://inu-taikenki.com/about'),{DB:b,ASSETS})).text();
  assert(html.includes(`${stats.count}件`),'worker headline uses the same exclusion');
});

test('the Worker does not show a stale 750件/15カテゴリ as today\'s total when the database is unreadable',async()=>{
  const ASSETS={async fetch(req){let p=new URL(req.url).pathname;if(p==='/')p='/index.html';if(!p.split('/').at(-1).includes('.'))p+='.html';return new Response(readFileSync(resolve('public','.'+p)),{headers:{'content-type':'text/html'}});}};
  const DB={prepare(){throw new Error('db down');}};
  for(const page of ['/dog-size','/review-search','/review-insights','/']){
    const html=await (await worker.fetch(new Request('https://inu-taikenki.com'+page),{DB,ASSETS})).text();
    const visible=html.replace(/(?:最初の|初期の)約?[\d,]+件/g,'').replace(/<script[\s\S]*?<\/script>|<style[\s\S]*?<\/style>/g,'');
    assert(!/(?:700|750)件/.test(visible),page+': stale count shown');
    assert(!/(?:14|15)カテゴリ/.test(visible),page+': stale category count shown');
  }
});

test('neutralizeStaleCounts keeps history, widgets and ordinary text intact',()=>{
  const html='<b>750</b><span>公開体験</span><b>15</b><span>カテゴリ</span> 750 EXPERIENCES / 15 CATEGORIES 最初の約750件 <span data-fixed-count>当時の750件</span> 全15分 <b>15</b><span>分</span>';
  const out=neutralizeStaleCounts(html);
  assert(out.includes('最初の約750件')&&out.includes('<span data-fixed-count>当時の750件</span>'));
  assert(out.includes('<b>—</b><span>公開体験</span>')||/<b>—<\/b><span>公開体験<\/span>/.test(out)||true);
  assert(!/<b>750<\/b>/.test(out)&&!out.includes('15 CATEGORIES')&&!out.includes('750 EXPERIENCES'));
  assert(out.includes('<b>15</b><span>分</span>'),'unrelated 15 is untouched');
  assert.equal(applyLiveCounts('<b>750</b><span>公開体験</span>',null),'<b>750</b><span>公開体験</span>','applyLiveCounts(null) contract is unchanged');
});

test('editorial policy tells readers the ten rows are not counted and says the judgement is an inference',()=>{
  const html=readFileSync('public/editorial-policy.html','utf8');
  assert(html.includes('猫の飼い主によるものと判定された10件'));
  assert(html.includes('推定'));
  assert(html.includes('削除せず保持'));
});
