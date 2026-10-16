import './ts-loader.mjs';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {resolve} from 'node:path';
import {legacyDatabase,migrate,binding} from './database.mjs';
const {default:worker}=await import('../src/final-entry.ts');
const {buildProfiles,sourceKind,renderProfilesHtml}=await import('../src/product-profiles.ts');
const {assertReadQuery}=await import('../src/readonly-db.ts');

const db=legacyDatabase();migrate(db);
const ASSETS={async fetch(req){let p=new URL(req.url).pathname;if(p==='/')p='/index.html';if(!p.split('/').at(-1).includes('.'))p+='.html';const file=resolve('public','.'+p);if(!file.startsWith(resolve('public')))return new Response('no',{status:404});try{return new Response(readFileSync(file),{headers:{'content-type':p.endsWith('.html')?'text/html; charset=utf-8':'application/octet-stream'}});}catch{return new Response('not found',{status:404});}}};
const get=(url,log)=>worker.fetch(new Request(url,{redirect:'manual'}),{DB:binding(db,log),ASSETS});
const text=(html)=>html.replace(/<(script|style)[\s\S]*?<\/\1>/g,'').replace(/<[^>]+>/g,'').replace(/\s+/g,' ');

test('category articles render the product overview without JavaScript, from stored rows only',async()=>{
  const res=await get('https://inu-taikenki.com/dog-clipper');
  assert.equal(res.status,200);
  const html=await res.text();
  assert(html.includes('data-inu-profiles'),'missing server-rendered overview');
  const products=db.prepare("SELECT p.id,p.name,count(r.id) n FROM products p JOIN reviews r ON r.product_id=p.id WHERE p.active=1 AND p.category='dog-clipper' GROUP BY p.id").all();
  assert(products.length>0);
  for(const p of products){
    assert(html.includes(`data-inu-profile="${p.id}"`),p.id);
    assert(html.includes(`整理した体験 ${p.n}件`),`${p.id}: count ${p.n} must match stored rows`);
  }
  // The interactive list is kept, and the overview comes after it.
  assert(html.indexOf('data-db-review-browser')<html.indexOf('data-inu-profiles'));
  assert(text(html).includes('体験の件数が多い＝おすすめ順位ではありません'));
});

test('overview quotes existing summaries only and never invents text',async()=>{
  const html=await (await get('https://inu-taikenki.com/brush-pin')).text();
  const section=html.slice(html.indexOf('data-inu-profiles'));
  const quoted=[...section.matchAll(/<li>([^<]+)<\/li>/g)].map(m=>m[1].replaceAll('&amp;','&').replaceAll('&lt;','<').replaceAll('&gt;','>').replaceAll('&quot;','"').replaceAll('&#039;',"'"));
  assert(quoted.length>0);
  const summaries=db.prepare("SELECT dog_breed,summary FROM reviews").all().map(r=>r.summary);
  for(const line of quoted){
    const summary=line.includes('｜')?line.slice(line.indexOf('｜')+1):line;
    assert(summaries.includes(summary),'quoted text is not a stored summary: '+line);
  }
});

test('every category page with a product list gets the overview exactly once; other pages do not',async()=>{
  const pages={'/pet-dryer':'pet-dryer','/auto-feeder':'auto-feeder','/dog-clipper':'dog-clipper','/brush-slicker':'brush-slicker','/brush-pin':'brush-pin','/brush-undercoat':'brush-undercoat','/brush-comb':'brush-comb','/dog-nail-grinder':'nail-grinder','/dog-nail-clipper':'nail-clipper','/dog-shampoo':'dog-shampoo','/dog-conditioner':'dog-conditioner'};
  for(const [page,category] of Object.entries(pages)){
    const html=await (await get('https://inu-taikenki.com'+page)).text();
    assert.equal((html.match(/data-inu-profiles(?=[ >])/g)||[]).length,1,page);
    const n=db.prepare("SELECT count(*) n FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.active=1 AND p.category=?").get(category).n;
    const shown=[...html.matchAll(/整理した体験 (\d+)件/g)].reduce((sum,m)=>sum+Number(m[1]),0);
    assert.equal(shown,n,`${page}: overview total must equal stored reviews`);
  }
  for(const page of ['/','/about','/privacy','/affiliate','/dog-size']){
    const html=await (await get('https://inu-taikenki.com'+page)).text();
    assert(!html.includes('data-inu-profiles'),page);
  }
});

test('overview queries are SELECT-only and pass the Preview read-only SQL guard',async()=>{
  const log=[];
  await get('https://inu-taikenki.com/dog-shampoo',log);
  await get('https://inu-taikenki.com/about',log);
  assert(log.length>=3);
  for(const {sql} of log)assert.doesNotThrow(()=>assertReadQuery(sql),sql);
});

test('source breakdown separates site-internal article rows from third-party review summaries',async()=>{
  const total=db.prepare("SELECT count(*) n FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.active=1").get().n;
  const internal=db.prepare("SELECT count(*) n FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.active=1 AND r.source_type='existing_article_summary'").get().n;
  for(const page of ['/about','/editorial-policy','/review-search']){
    const html=await (await get('https://inu-taikenki.com'+page)).text();
    assert(html.includes('data-inu-source-breakdown'),page);
    const plain=text(html);
    assert(plain.includes(`合計${total}件`),`${page} total`);
    assert(plain.includes(`他サイトに公開されたレビュー等を要約したものが${total-internal}件`),`${page} external`);
    assert(plain.includes(`再整理したものが${internal}件`),`${page} internal`);
  }
});

test('JSON API responses are crawlable but marked noindex; HTML pages are not',async()=>{
  for(const path of ['/api/health','/api/reviews/stats','/api/reviews?limit=1','/api/products?limit=1','/api/unknown']){
    const res=await get('https://inu-taikenki.com'+path);
    assert.equal(res.headers.get('x-robots-tag'),'noindex',path);
  }
  const page=await get('https://inu-taikenki.com/brush-pin');
  assert.equal(page.headers.get('x-robots-tag'),null);
  assert(!/noindex/i.test(readFileSync('public/robots.txt','utf8')));
  assert(!/Disallow:\s*\/api/i.test(readFileSync('public/robots.txt','utf8')),'robots.txt must not block /api: pages render their lists from it');
});

test('buildProfiles groups by product, ignores unknown sizes and keeps source kinds apart',()=>{
  const profiles=buildProfiles([{id:'a',name:'A'},{id:'b',name:'B'},{id:'c',name:'C'}],[
    {product_id:'a',dog_breed:'トイプードル・2歳',dog_size:'small',coat_type:'curly',needs:'scared daily',summary:'小型犬に使い、怖がらずに使えた一方、音が少し気になった体験。',source_type:'public_buyer_review_summary',source_url:'https://review.rakuten.co.jp/x'},
    {product_id:'a',dog_breed:null,dog_size:null,coat_type:null,needs:null,summary:'サイズ不明だが日常のケアに使えたという体験の要約。',source_type:'existing_article_summary',source_url:'/dog-clipper.html'},
    {product_id:'b',dog_breed:'犬種不明',dog_size:'large',coat_type:'double',needs:'shedding',summary:'大型犬の換毛期に使い、抜け毛がよく取れたという体験。',source_type:'public_buyer_review_summary',source_url:'https://shopping.yahoo.co.jp/y'},
  ]);
  assert.deepEqual(profiles.map(p=>p.id),['a','b']);
  assert.equal(profiles[0].count,2);assert.equal(profiles[0].sizes.small,1);assert.equal(profiles[0].sizeUnknown,1);
  assert.deepEqual(profiles[0].breeds,['トイプードル']);
  assert.deepEqual(profiles[1].breeds,[]);
  assert.equal(profiles[0].reservations.length,1);
  assert.deepEqual(profiles[0].sources.map(([k])=>k).sort(),['サイト内記事の再整理','楽天市場']);
  assert.equal(sourceKind({source_type:'x',source_url:'https://www.chewy.com/p'}),'海外小売サイト');
  assert.equal(renderProfilesHtml('x',[]),'');
});

test('overview escapes stored text',()=>{
  const profiles=buildProfiles([{id:'a',name:'<b>A</b>'}],[{product_id:'a',dog_breed:'<img src=x>',dog_size:'small',coat_type:null,needs:null,summary:'<script>alert(1)</script>という文字を含む二十文字以上の要約文です。',source_type:null,source_url:null}]);
  const html=renderProfilesHtml('カテゴリ',profiles);
  assert(!html.includes('<script>alert')&&!html.includes('<img src=x>')&&!html.includes('<b>A</b>'));
});

test('Preview entry renders the overview through the read-only wrapper and never writes',async()=>{
  const {default:preview}=await import('../src/preview-entry.ts');
  const log=[];
  const before=JSON.stringify(['products','reviews'].map(t=>db.prepare(`SELECT count(*) n FROM ${t}`).get().n));
  const env={APP_ENV:'preview',DB:binding(db,log),ASSETS};
  for(const page of ['/dog-clipper','/pet-dryer','/about']){
    const res=await preview.fetch(new Request('https://develop.inu-taikenki.com'+page),env);
    assert.equal(res.status,200,page);
    assert.match(res.headers.get('x-robots-tag')||'',/noindex/);
    const html=await res.text();
    assert(page==='/about'?html.includes('data-inu-source-breakdown'):html.includes('data-inu-profiles'),page);
  }
  assert(log.length>0);
  for(const {sql} of log)assert(/^\s*SELECT\b/i.test(sql),sql);
  assert.equal(JSON.stringify(['products','reviews'].map(t=>db.prepare(`SELECT count(*) n FROM ${t}`).get().n)),before);
  const post=await preview.fetch(new Request('https://develop.inu-taikenki.com/dog-clipper',{method:'POST',body:'x'}),env);
  assert.equal(post.status,405);
});
