import { test } from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { reviewApi } from '../src/review-api.ts';
import { legacyDatabase, migrate, binding } from './database.mjs';
const db=legacyDatabase();
const snapshot=()=>JSON.stringify(['products','reviews'].map(t=>db.prepare(`SELECT * FROM ${t} ORDER BY id`).all()));
const before=snapshot();migrate(db);
const request=async(path, database=db)=>{
  const res=await reviewApi(new Request('https://inu.test'+path),binding(database));
  return {status:res.status,...await res.json()};
};
test('additive migration preserves all 750 rows, product IDs, source fields, and repeat application',()=>{
  assert.equal(db.prepare('SELECT count(*) n FROM reviews').get().n,750);
  assert.equal(snapshot(),before);migrate(db);assert.equal(snapshot(),before);
  assert.deepEqual(db.prepare('PRAGMA foreign_key_check').all(),[]);
});
test('all legacy token facts indexed exactly without inventing values',()=>{
  for(const r of db.prepare('SELECT * FROM reviews').all())for(const [kind,col] of [['size','dog_size'],['coat','coat_type'],['trait','needs']]){
    const expected=[...new Set(String(r[col]||'').toLowerCase().split(/\s+/).filter(x=>x&&x!=='null'))].sort();
    assert.deepEqual(db.prepare('SELECT value FROM review_attributes WHERE review_id=? AND kind=? ORDER BY value').all(r.id,kind).map(x=>x.value),expected);
  }
});
test('every legacy category count, filtered counts and source data match SQL and original client rules',async()=>{
  const legacy=db.prepare('SELECT r.*,p.name product_name,p.category FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.active=1').all();
  for(const category of new Set(legacy.map(r=>r.category)))for(const size of ['','small','large'])for(const coat of ['','curly']){
    const expected=legacy.filter(r=>r.category===category&&(!size||String(r.dog_size).split(/\s+/).includes(size))&&(!coat||String(r.coat_type).split(/\s+/).includes(coat)));
    const j=await request('/api/reviews?'+new URLSearchParams({category,size,coat,limit:'100'}));assert.equal(j.status,200);assert.equal(j.count,expected.length);assert.deepEqual(j.reviews.map(r=>r.id),expected.map(r=>r.id).sort((a,b)=>a-b));
    for(const r of j.reviews){const old=legacy.find(x=>x.id===r.id);assert.equal(r.summary,old.summary);assert.equal(r.source_url,old.source_url);assert.equal(r.source_type,old.source_type);}
  }
});
test('pagination default/cursor/offset returns each row once and bounds payload',async()=>{
  const first=await request('/api/reviews');assert.equal(first.count,750);assert.equal(first.reviews.length,20);
  const seen=[];let cursor=0;do{const j=await request('/api/reviews?limit=37&cursor='+cursor);assert(j.reviews.length<=37);seen.push(...j.reviews.map(r=>r.id));cursor=j.next_cursor;}while(cursor);
  assert.equal(seen.length,750);assert.equal(new Set(seen).size,750);assert.deepEqual(seen,[...seen].sort((a,b)=>a-b));
  const page=await request('/api/reviews?limit=20&offset=20');assert.equal(page.reviews[0].id,seen[20]);
});
test('product, breed, trait, aliases, empty, inactive and not found',async()=>{
  const product=db.prepare("SELECT id FROM products WHERE category='brush-pin' LIMIT 1").get().id;
  const j=await request('/api/products/'+product+'/reviews?trait=scared&limit=100');assert(j.reviews.every(r=>r.product_id===product&&r.needs.split(/\s+/).includes('scared')));
  const breed=await request('/api/reviews?breed='+encodeURIComponent('トイプードル')+'&limit=100');assert(breed.count>0);assert(breed.reviews.every(r=>r.dog_breed.includes('トイプードル')));
  const exact=await request('/api/reviews?breed='+encodeURIComponent('トイプードル')+'&breed_mode=exact&limit=100');assert(exact.reviews.every(r=>r.dog_breed==='トイプードル'));
  assert((await request('/api/reviews?q='+encodeURIComponent('怖がり'))).count>0);
  assert.equal((await request('/api/reviews?category=missing')).count,0);
  assert.equal((await request('/api/products/missing/reviews')).status,404);
  db.exec("INSERT INTO products(id,name,category,active)VALUES('inactive','Hidden','brush-pin',0); INSERT INTO reviews(product_id,summary)VALUES('inactive','hidden');");
  assert.equal((await request('/api/reviews')).count,750);assert.equal((await request('/api/products/inactive/reviews')).status,404);
});
test('invalid inputs and injection are handled without SQL interpolation',async()=>{
  for(const query of ['limit=0','limit=101','limit=-1','limit=1.1','limit=no','offset=-2','cursor=-1','cursor=9007199254740992','cursor=2&offset=1','category=x%27','product=foo%2Fbar','size=a%27','breed_mode=oops','q='+'x'.repeat(201)])assert.equal((await request('/api/reviews?'+query)).status,400,query);
  assert.equal((await request('/api/reviews?q='+encodeURIComponent("' OR 1=1 --"))).count,0);
  assert.equal((await request('/api/products/%ZZ/reviews')).status,400);
  assert.equal((await request('/api/reviews/groups?limit=21')).status,400);
});
test('aggregates and grouped samples count the entire filtered set',async()=>{
  const all=await request('/api/reviews?size=small&limit=100');const stats=await request('/api/reviews/stats?size=small');assert.equal(stats.count,all.count);assert.equal(stats.facets.find(x=>x.kind==='size'&&x.value==='small').count,all.count);
  let offset=0,count=0,ids=new Set();do{const j=await request('/api/reviews/groups?size=small&limit=7&offset='+offset);for(const g of j.groups){assert(g.reviews.length<=2);assert(g.reviews.every(r=>r.product_id===g.product_id));assert(!ids.has(g.product_id));ids.add(g.product_id);count+=g.count;}offset=j.next_offset;}while(offset!==null);assert.equal(count,all.count);
  const products=await request('/api/products?category=brush-pin&limit=2');assert.equal(products.products.length,2);assert(products.has_more);
});
test('indexes support selective lookups and keyset review queries',()=>{
  for(const [sql,index] of [["SELECT review_id FROM review_attributes WHERE kind='size' AND value='small'",'idx_review_attributes_lookup'],["SELECT id FROM reviews WHERE product_id='x' AND id>5 ORDER BY id LIMIT 20",'idx_reviews_product'],["SELECT id FROM products WHERE category='brush-pin' AND active=1",'idx_products_category_active']]){
    const plan=db.prepare('EXPLAIN QUERY PLAN '+sql).all().map(x=>x.detail).join(' ');assert(plan.includes(index),plan);
  }
});
test('token triggers track insert/update/delete, preserve unknowns and escape arbitrary strings',()=>{
  const id=db.prepare("INSERT INTO reviews(product_id,summary,dog_size,coat_type,needs) VALUES('inactive','test',?, ?, ?) RETURNING id").get(' small\tmedium\nnull ','curly double','scared "quoted" back\\slash').id;
  assert.equal(db.prepare("SELECT count(*) n FROM review_attributes WHERE review_id=? AND kind='size'").get(id).n,2);
  db.prepare("UPDATE reviews SET dog_size=NULL,needs='quiet' WHERE id=?").run(id);
  assert.equal(db.prepare("SELECT count(*) n FROM review_attributes WHERE review_id=? AND kind='size'").get(id).n,0);
  db.prepare('DELETE FROM reviews WHERE id=?').run(id);assert.equal(db.prepare('SELECT count(*) n FROM review_attributes WHERE review_id=?').get(id).n,0);
});
test('three marketplace listings resolve to one canonical product; identity collisions reject',()=>{
  const ids=db.prepare('SELECT id FROM products WHERE active=1 LIMIT 2').all().map(x=>x.id);
  db.prepare('INSERT INTO product_identifiers VALUES(?,?,?,?)').run('gtin','verified-test',ids[0],'https://example.test/evidence');
  for(const platform of ['amazon','rakuten','yahoo'])db.prepare('INSERT INTO product_listings VALUES(?,?,?,?)').run(platform,'test-listing',ids[0],'https://example.test/listing');
  assert.equal(db.prepare("SELECT count(DISTINCT product_id) n FROM product_listings WHERE external_id='test-listing'").get().n,1);
  assert.throws(()=>db.prepare('INSERT INTO product_identifiers VALUES(?,?,?,?)').run('gtin','verified-test',ids[1],'https://example.test/evidence'));
  assert.throws(()=>db.prepare('INSERT INTO product_listings VALUES(?,?,?,?)').run('amazon','test-listing',ids[1],'https://example.test/listing'));
  const rid=db.prepare('SELECT id FROM reviews LIMIT 1').get().id;
  db.prepare('INSERT INTO review_sources VALUES(?,?,?,?,?)').run(rid,'public_buyer_review_summary','https://example.test/review','rakuten','review-test');
  assert.throws(()=>db.prepare('INSERT INTO review_sources VALUES(?,?,?,?,?)').run(rid+1,'public_buyer_review_summary','https://example.test/review','rakuten','review-test'));
});
test('DB failure is a controlled 503 (no unbounded fallback)',async()=>{
  const r=await reviewApi(new Request('https://inu.test/api/reviews'),{prepare(){throw Error('mock unavailable');}});assert.equal(r.status,503);assert.equal((await r.json()).error,'reviews_unavailable');
});
test('large fixture: 30 products / 15000 additional summaries; bounded results and complete counts',async()=>{
  const large=legacyDatabase();migrate(large);large.exec('BEGIN');
  const p=large.prepare("INSERT INTO products(id,name,category)VALUES(?,?,'brush-pin')");
  const r=large.prepare("INSERT INTO reviews(product_id,dog_size,coat_type,needs,dog_breed,summary,source_url)VALUES(?,'small','curly double','scared gentle','テスト犬種',?,'https://example.test/review')");
  for(let i=0;i<30;i++){p.run('mock-'+i,'MOCK '+i);for(let j=0;j<500;j++)r.run('mock-'+i,`Synthetic ${i}/${j}`);}large.exec('COMMIT');
  const log=[];const started=performance.now();const res=await reviewApi(new Request('https://inu.test/api/reviews?category=brush-pin&size=small&coat=curly&trait=scared&limit=12'),binding(large,log));const data=await res.json();assert.equal(res.status,200);assert.equal(data.reviews.length,12);assert(data.count>=15000);assert.equal(log.length,2);assert(data.has_more);
  const grouped=await request('/api/reviews/groups?category=brush-pin&limit=10',large);assert.equal(grouped.groups.length,10);assert(grouped.groups.every(g=>g.reviews.length===2));assert(performance.now()-started < 2000, 'selective queries must not regress to quadratic IN plans');console.log(`large fixture query ${Math.round(performance.now()-started)}ms; ${data.count} matches / 12 returned`);
});


test('equivalent trait tags share one filter meaning and canonical stats bucket',async()=>{
  const local=legacyDatabase();migrate(local);
  const product=local.prepare("SELECT id FROM products WHERE active=1 LIMIT 1").get().id;
  local.prepare("INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary) VALUES(?,?,?,?,?,?)").run(product,'テスト犬','small','short','multi-dog skin-sensitive','alias-a');
  local.prepare("INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary) VALUES(?,?,?,?,?,?)").run(product,'テスト犬','small','short','multi skin','alias-b');
  const multi=await request('/api/reviews?trait=multi&limit=100',local);
  const multiDog=await request('/api/reviews?trait=multi-dog&limit=100',local);
  assert.deepEqual(multi.reviews.map(r=>r.id),multiDog.reviews.map(r=>r.id));
  assert.equal(multi.count,multiDog.count);
  const skin=await request('/api/reviews?trait=skin&limit=100',local);
  const skinSensitive=await request('/api/reviews?trait=skin-sensitive&limit=100',local);
  assert.deepEqual(skin.reviews.map(r=>r.id),skinSensitive.reviews.map(r=>r.id));
  const stats=await request('/api/reviews/stats',local);
  assert(!stats.facets.some(f=>f.kind==='trait'&&['multi-dog','skin-sensitive'].includes(f.value)));
  assert(stats.facets.some(f=>f.kind==='trait'&&f.value==='multi'));
  assert(stats.facets.some(f=>f.kind==='trait'&&f.value==='skin'));
});

test('breed coverage excludes rows explicitly marked 犬種不明',async()=>{
  const local=legacyDatabase();migrate(local);
  const product=local.prepare("SELECT id FROM products WHERE active=1 LIMIT 1").get().id;
  local.prepare("INSERT INTO reviews(product_id,dog_breed,summary) VALUES(?,?,?)").run(product,'犬種不明・子犬','unknown-breed');
  const stats=await request('/api/reviews/stats',local);
  const actualKnown=local.prepare("SELECT count(*) n FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.active=1 AND nullif(trim(r.dog_breed),'') IS NOT NULL AND instr(r.dog_breed,'犬種不明')=0").get().n;
  assert.equal(stats.coverage.breed,actualKnown);
});
