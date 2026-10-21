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

const {PROFILE_CATEGORIES,loadSourceBreakdown,renderSourceBreakdownHtml}=await import('../src/product-profiles.ts');
test('dog-harness is a profile category; the 15 existing categories are unchanged',()=>{
  const existing=['pet-dryer','auto-feeder','dog-clipper','brush-slicker','brush-pin','brush-undercoat','brush-comb','nail-grinder','nail-clipper','dog-shampoo','dog-conditioner','dog-toothbrush','dog-toothpaste','dog-dental-chew','dog-ear-cleaner'];
  assert.deepEqual([...PROFILE_CATEGORIES].filter(c=>c!=='dog-harness').sort(),[...existing].sort());
  assert(PROFILE_CATEGORIES.has('dog-harness'));
});

function harnessDb(){
  const d=legacyDatabase();migrate(d);
  d.prepare("INSERT INTO products(id,name,category,active)VALUES('h-1','テストハーネスA','dog-harness',1)").run();
  d.prepare("INSERT INTO products(id,name,category,active)VALUES('h-2','テストハーネスB','dog-harness',1)").run();
  const ins=d.prepare("INSERT INTO reviews(id,product_id,dog_breed,dog_size,needs,summary,source_type,source_url)VALUES(?,?,?,?,?,?,'public_buyer_review_summary','https://review.rakuten.co.jp/item/1/1_1/1.1/')");
  // ids beyond the static ledger, which describes production row ids
  ins.run(950001,'h-1','柴犬','medium','pull','柴犬10kgで引っ張りが減り、着脱も簡単だったという体験その一。');
  ins.run(950002,'h-1','トイプードル','small','escape','トイプードル3kgで後ずさりしても抜けなかったが少し大きかったという体験その二。');
  ins.run(950003,'h-2','ゴールデン','large','pull','ゴールデン30kgでベルトが長く余ったが引っ張りは減ったという体験その三。');
  d.prepare('INSERT INTO review_sources VALUES(?,?,?,?,?)').run(950001,'public_buyer_review_summary','https://review.rakuten.co.jp/item/1/1_1/2.1/','rakuten','t-1');
  d.prepare('INSERT INTO review_sources VALUES(?,?,?,?,?)').run(950003,'public_buyer_review_summary','https://review.rakuten.co.jp/item/1/1_2/1.1/','rakuten','t-3');
  return d;
}
test('/dog-harness gets the server-rendered product overview, with D1-registered source checks and no false "verified"',async()=>{
  const d=harnessDb();
  const res=await worker.fetch(new Request('https://inu-taikenki.com/dog-harness',{redirect:'manual'}),{DB:binding(d,[]),ASSETS});
  assert.equal(res.status,200);
  const html=await res.text();
  assert.equal((html.match(/data-inu-profiles(?=[ >])/g)||[]).length,1);
  assert(html.includes('data-inu-profile="h-1"')&&html.includes('data-inu-profile="h-2"'));
  assert(html.includes('<strong>テストハーネスA</strong>｜体験2件</summary>'));
  assert(html.indexOf('data-db-review-browser')<html.indexOf('data-inu-profiles'));
  const card=id=>html.slice(html.indexOf(`data-inu-profile="${id}"`),html.indexOf('</details>',html.indexOf(`data-inu-profile="${id}"`)));
  const a=card('h-1');
  assert(a.includes('確認済み1／未実施1件'),'one registered row is verified, the unregistered one stays "not checked"');
  assert(card('h-2').includes('確認済み1件'));
  assert(!/部分一致|見つからず|確認不能|猫の投稿/.test(a),'registry rows never claim other statuses');
});
test('adding dog-harness data does not change any existing category page',async()=>{
  const d=harnessDb();
  for(const page of ['/dog-clipper','/brush-pin','/pet-dryer','/dog-ear-cleaner']){
    const a=await (await get('https://inu-taikenki.com'+page)).text();
    const b=await (await worker.fetch(new Request('https://inu-taikenki.com'+page,{redirect:'manual'}),{DB:binding(d,[]),ASSETS})).text();
    assert.equal(b,a,page+' must be byte-identical');
  }
});
test('dog-harness profile queries are SELECT-only and pass the read-only guard',async()=>{
  const d=harnessDb();const log=[];
  await worker.fetch(new Request('https://inu-taikenki.com/dog-harness',{redirect:'manual'}),{DB:binding(d,log),ASSETS});
  assert(log.length>0);
  for(const q of log)assertReadQuery(q.sql);
});
test('source breakdown reports how many rows were added with a registered post',async()=>{
  const d=harnessDb();
  const data=await loadSourceBreakdown(binding(d,[]));
  assert.equal(data.registered,2);
  assert(renderSourceBreakdownHtml(data).includes('2件は、確認できた投稿の識別情報を登録'));
  const none=await loadSourceBreakdown(binding(db,[]));
  assert.equal(none.registered,0);
  assert(!renderSourceBreakdownHtml(none).includes('識別情報を登録'));
});
test('internal links to /dog-harness exist where categories are listed; existing links stay',async()=>{
  const read=f=>readFileSync(resolve('public',f),'utf8');
  assert(read('index.html').includes('href="dog-harness"'));
  for(const f of ['review-search.html','review-insights.html','dog-size.html','breed-toy-poodle.html'])assert(read(f).includes("dog-harness"),f);
  assert(read('review-search.html').includes('<a href="/dog-harness">犬用ハーネス</a>'));
  for(const f of ['review-search.html','review-insights.html','dog-size.html'])for(const keep of ['dog-ear-cleaner','dog-toothbrush','pet-dryer'])assert(read(f).includes(keep),f+' lost '+keep);
  const home=await (await get('https://inu-taikenki.com/')).text();
  assert.equal((home.match(/href="dog-harness"/g)||[]).length,1);
  assert(home.includes('href="dog-ear-cleaner"'),'the Worker-injected ear-cleaner card is kept');
});

test('quoted lines carry the registry check tag; unregistered rows say "not checked"',()=>{
  const rows=[];
  for(let i=0;i<14;i++)rows.push({id:960000+i,product_id:'q-1',dog_breed:'柴犬',dog_size:i%2?'small':'large',coat_type:null,needs:'pull',summary:`柴犬の体験として十分な長さのある要約文その${i}です。`,source_type:'public_buyer_review_summary',source_url:'https://review.rakuten.co.jp/item/1/1_1/1.1/',registered_source_url:i<7?'https://review.rakuten.co.jp/item/1/1_1/2.1/':null});
  const [p]=buildProfiles([{id:'q-1',name:'Q'}],rows);
  assert.equal(p.checks.V,7);assert.equal(p.checks.none,7);
  const lines=[...p.examples,...p.reservations];
  assert(lines.length>0);
  for(const l of lines)assert(/^［(出典確認済み|出典の確認は未実施)］/.test(l),l);
  assert(lines.some(l=>l.startsWith('［出典確認済み］')),'verified rows are preferred for quoting');
  // legacy shape (no registered_source_url) behaves exactly as before: not checked
  const [legacy]=buildProfiles([{id:'q-1',name:'Q'}],rows.map(({registered_source_url,...r})=>r));
  assert.equal(legacy.checks.V,0);assert.equal(legacy.checks.none,14);
});
