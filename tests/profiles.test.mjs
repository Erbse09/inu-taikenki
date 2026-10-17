import './ts-loader.mjs';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import {resolve} from 'node:path';
import {legacyDatabase,migrate,binding} from './database.mjs';
const {default:worker}=await import('../src/final-entry.ts');
const {buildProfiles,buildConditionRows,sourceKind,renderProfilesHtml}=await import('../src/product-profiles.ts');
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
    assert(html.includes(`<strong>${p.name}</strong>｜体験${p.n}件</summary>`),`${p.id}: count ${p.n} must match stored rows`);
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
    const summary=line.replace(/^［[^］]*］/,'');const body=summary.includes('｜')?summary.slice(summary.indexOf('｜')+1):summary;
    assert(summaries.includes(body),'quoted text is not a stored summary: '+line);
  }
});

test('every category page with a product list gets the overview exactly once; other pages do not',async()=>{
  const pages={'/pet-dryer':'pet-dryer','/auto-feeder':'auto-feeder','/dog-clipper':'dog-clipper','/brush-slicker':'brush-slicker','/brush-pin':'brush-pin','/brush-undercoat':'brush-undercoat','/brush-comb':'brush-comb','/dog-nail-grinder':'nail-grinder','/dog-nail-clipper':'nail-clipper','/dog-shampoo':'dog-shampoo','/dog-conditioner':'dog-conditioner'};
  for(const [page,category] of Object.entries(pages)){
    const html=await (await get('https://inu-taikenki.com'+page)).text();
    assert.equal((html.match(/data-inu-profiles(?=[ >])/g)||[]).length,1,page);
    const n=db.prepare("SELECT count(*) n FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.active=1 AND p.category=?").get(category).n;
    const shown=[...html.matchAll(/｜体験(\d+)件<\/summary>/g)].reduce((sum,m)=>sum+Number(m[1]),0);
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

test('buildProfiles groups by product, skips rows the interactive list already shows, keeps article rows apart',()=>{
  const row=(id,product,extra={})=>({id,product_id:product,dog_breed:null,dog_size:null,coat_type:null,needs:null,summary:`商品${product}の${id}番目の体験について書かれた二十文字以上の要約文です。`,source_type:'public_buyer_review_summary',source_url:'https://review.rakuten.co.jp/x',...extra});
  const rows=[
    ...Array.from({length:8},(_,i)=>row(i+1,'a',{dog_size:i<3?'small':null,needs:'scared daily',dog_breed:i===0?'トイプードル・2歳':null})),
    row(9,'b',{dog_size:'large',coat_type:'double',needs:'shedding',summary:'大型犬の換毛期に使い、抜け毛はよく取れた一方、音が少し気になった体験の要約。',source_url:'https://shopping.yahoo.co.jp/y'}),
    row(10,'b',{source_type:'existing_article_summary',source_url:'/dog-clipper.html'}),
  ];
  const profiles=buildProfiles([{id:'a',name:'A'},{id:'b',name:'B'},{id:'c',name:'C'}],rows);
  assert.deepEqual(profiles.map(p=>p.id),['a','b']);
  const [a,b]=profiles;
  assert.equal(a.count,8);assert.equal(a.sizes.small,3);assert.equal(a.sizeUnknown,5);
  assert.deepEqual(a.breeds,['トイプードル']);
  // Product "a" is the one the interactive list opens on; its first six rows must not be quoted again.
  for(const line of [...a.examples,...a.reservations])for(let id=1;id<=6;id++)assert(!line.includes(`${id}番目`),`row ${id} is already shown by the interactive list`);
  assert.equal(a.examples.length,2);
  assert.equal(b.reservations.length,1);assert(b.reservations[0].includes('一方'));
  assert.equal(b.articleRows,1);
  assert(b.examples.some(line=>line.startsWith('［サイト内記事の再整理］')),'article rows are labelled when quoted');
  assert(!a.examples.some(line=>line.includes('サイト内記事の再整理')));
  assert.deepEqual(b.sources.map(([k])=>k).sort(),['Yahoo!ショッピング','サイト内記事の再整理']);
  assert.equal(sourceKind({source_type:'x',source_url:'https://www.chewy.com/p'}),'海外小売サイト');
  assert.equal(renderProfilesHtml('x',[]),'');
});

test('condition table counts reviews per condition and links only to searchable conditions',()=>{
  const rows=[
    {id:1,product_id:'a',dog_breed:null,dog_size:'small',coat_type:'curly',needs:'scared',summary:'小型の巻毛の犬が怖がりで、少しずつ慣らして使えた体験の要約です。',source_type:'x',source_url:null},
    {id:2,product_id:'a',dog_breed:null,dog_size:'small',coat_type:null,needs:'scared beginner',summary:'小型犬で怖がりだったが、初心者でも扱いやすかったという体験の要約。',source_type:'x',source_url:null},
    {id:3,product_id:'b',dog_breed:null,dog_size:'large',coat_type:null,needs:'beginner',summary:'大型犬に使い、初心者でも扱いやすいと感じたという体験についての要約。',source_type:'x',source_url:null},
  ];
  const profiles=buildProfiles([{id:'a',name:'A'},{id:'b',name:'B'}],rows);
  const conditions=buildConditionRows('dog-clipper',profiles);
  const get=label=>conditions.find(c=>c.label===label);
  assert.equal(get('小型犬の体験').total,2);assert.deepEqual(get('小型犬の体験').products,[['A',2]]);
  assert.equal(get('大型犬の体験').total,1);
  assert(!get('中型犬の体験'),'conditions with no experience are not listed');
  assert.equal(get('「怖がり」が書かれた体験').total,2);
  assert.match(get('「怖がり」が書かれた体験').href,/q=%E6%80%96%E3%81%8C%E3%82%8A/);
  assert.equal(get('「初心者」が書かれた体験').href,null,'no link when the search page cannot filter by it');
  assert.match(get('小型犬の体験').href,/^\/review-search\?category=dog-clipper&size=small$/);
  const html=renderProfilesHtml('犬用バリカン',profiles,'dog-clipper');
  assert(html.includes('体験が少ないため参考程度'));
  assert(html.includes('犬の条件から見る：どの商品に体験が多いか'));
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

test('headline pages explain the count breakdown and article rows are marked in every renderer',async()=>{
  const total=db.prepare("SELECT count(*) n FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.active=1").get().n;
  const internal=db.prepare("SELECT count(*) n FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.active=1 AND r.source_type='existing_article_summary'").get().n;
  assert(internal>0&&internal<total);
  for(const page of ['/','/review-search','/dog-size','/review-insights']){
    const html=await (await get('https://inu-taikenki.com'+page)).text();
    assert.equal((html.match(/data-inu-count-note/g)||[]).length,1,page);
    const note=text(html.slice(html.indexOf('data-inu-count-note')));
    assert(note.includes(`サイト内の記事を再整理したものが${internal}件（合計${total}件）`),page);
    assert(html.indexOf('data-inu-count-note')<html.indexOf('</main>')||!html.includes('</main>'));
  }
  // Server-rendered search cards and every client-side renderer carry the same marker.
  const ssr=await (await get('https://inu-taikenki.com/review-search?category=pet-dryer')).text();
  assert(ssr.includes('<div class="kind">サイト内記事の再整理（他サイトの体験ではありません）</div>'));
  for(const file of ['db-review-browser.js','pet-dryer.html','review-search.html'])assert(readFileSync('public/'+file,'utf8').includes('サイト内記事の再整理（他サイトの体験ではありません）'),file);
  for(const file of ['dog-size.html','breed-toy-poodle.html'])assert(readFileSync('public/'+file,'utf8').includes('［サイト内記事の再整理］'),file);
});

test('site description of how summaries were made is truthful: AI-assisted, not individually verified',()=>{
  for(const file of ['about.html','editorial-policy.html']){
    const html=readFileSync('public/'+file,'utf8');
    assert(html.includes('生成AI'),file);
    assert(html.includes('ChatGPT')&&html.includes('Claude'),file+' must distinguish the two assistants');
    assert(html.includes('未確認'),file+' must say the first ~750 rows are unverified');
    assert(!/生成AI（Claude）/.test(html),file+' must not read as if only Claude was used');
    assert(html.includes('原文と1件ずつ照合したわけではありません'),file);
    assert(!/運営者が(?:読んで)?要約/.test(html),file+' must not claim the operator wrote each summary');
  }
  assert(!/運営者が要約/.test(readFileSync('src/product-profiles.ts','utf8')));
});
