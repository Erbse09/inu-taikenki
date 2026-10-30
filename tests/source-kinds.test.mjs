// PR-A: rows 921-926 summarise outside articles (a personal blog and the brand's own sites) but carry
// source_type 'existing_article_summary'. They must not be shown as "サイト内記事の再整理" or as buyer reviews.
// Everything below reads or derives; no row is changed, and the public count stays the same.
import './ts-loader.mjs';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync,existsSync} from 'node:fs';
import {resolve} from 'node:path';
import {legacyDatabase,migrate,binding} from './database.mjs';
const {default:worker}=await import('../src/final-entry.ts');
const {sourceKindOf,isArticleKind,isExternalArticleKind}=await import('../src/source-kinds.ts');
const {loadSourceBreakdown,renderSourceBreakdownHtml,buildProfiles,sourceKind}=await import('../src/product-profiles.ts');
const {assertReadQuery}=await import('../src/readonly-db.ts');

const ASSETS={async fetch(req){let p=new URL(req.url).pathname;if(p==='/')p='/index.html';if(!p.split('/').at(-1).includes('.'))p+='.html';const file=resolve('public','.'+p);if(!file.startsWith(resolve('public')+'/')||!existsSync(file))return new Response('',{status:404});return new Response(readFileSync(file),{headers:{'content-type':p.endsWith('.html')?'text/html':'text/plain'}});}};
const text=(html)=>html.replace(/<(script|style)[\s\S]*?<\/\1>/g,'').replace(/<[^>]+>/g,'').replace(/\s+/g,' ');

// The six production rows (ids 921-926), as read from D1 on 2026-10-29: type, URL and product only.
const EXTERNAL=[
  [950921,'supreme-test','https://ameblo.jp/lanlanleaf/entry-12388261501.html'],
  [950922,'pp-regular-test','https://plushpuppyamerica.com/english-springer-spaniel/'],
  [950923,'pp-regular-test','https://plushpuppy.co.nz/blogs/grooming-articles/belgian-shepherd'],
  [950924,'pp-regular-test','https://plushpuppy.co.nz/blogs/grooming-articles/bearded-collie'],
  [950925,'pp-regular-test','https://plushpuppyamerica.com/irish-wolfhound/'],
  [950926,'pp-long-test','https://plushpuppyamerica.com/afghan-hound/'],
];
function fixture(){
  const d=legacyDatabase();migrate(d);
  for(const [id,name] of [['supreme-test','サプリーム テスト'],['pp-regular-test','Plush Puppy テストレギュラー'],['pp-long-test','Plush Puppy テストロング'],['third-test','購入者レビューテスト商品']])
    d.prepare("INSERT INTO products(id,name,category,active)VALUES(?,?,'brush-pin',1)").run(id,name);
  const ins=d.prepare("INSERT INTO reviews(id,product_id,dog_breed,dog_size,needs,summary,source_type,source_url)VALUES(?,?,?,?,?,?,?,?)");
  EXTERNAL.forEach(([id,product,url],i)=>ins.run(id,product,'テスト犬種'+i,'medium','brushing','外部記事の手順を要約した文章その'+(i+1)+'です。道具の使い方が書かれています。','existing_article_summary',url));
  ins.run(950931,'third-test','柴犬','medium','brushing','換毛期に使って毛が取れたという購入者レビューの要約その一です。','public_buyer_review_summary','https://review.rakuten.co.jp/item/1/1_1/1.1/');
  ins.run(950932,'third-test','トイプードル','small','brushing','毛玉がほぐれやすかったという購入者レビューの要約その二です。','public_buyer_review_summary','https://shopping.yahoo.co.jp/review/item/list?x=1');
  ins.run(950933,'third-test','マルチーズ','small','brushing','サイト内の記事を整理した体験その三です。','existing_article_summary','/brush-pin.html');
  return d;
}
const fetchPage=(d,path,log=[])=>worker.fetch(new Request('https://inu-taikenki.com'+path,{redirect:'manual'}),{DB:binding(d,log),ASSETS});
const rowHash=(d)=>JSON.stringify(d.prepare('SELECT * FROM reviews ORDER BY id').all());

test('sourceKindOf separates site articles, outside blog / brand articles, other outside articles and buyer reviews',()=>{
  assert.equal(sourceKindOf({source_type:'existing_article_summary',source_url:'/brush-pin.html'}).kind,'site_article');
  assert.equal(sourceKindOf({source_type:'existing_article_summary',source_url:EXTERNAL[0][2]}).kind,'external_blog');
  for(const [,,url] of EXTERNAL.slice(1))assert.equal(sourceKindOf({source_type:'existing_article_summary',source_url:url}).kind,'external_brand',url);
  assert.equal(sourceKindOf({source_type:'existing_article_summary',source_url:'https://example.com/grooming'}).kind,'external_article','unknown outside host is still not a site article');
  assert.equal(sourceKindOf({source_type:'existing_article_summary',source_url:'https://[bad'}).kind,'external_article','malformed URL does not throw');
  assert.equal(sourceKindOf({source_type:'existing_article_summary',source_url:''}).kind,'site_article','legacy rows without a URL keep the old label');
  for(const type of ['public_buyer_review_summary','public_purchase_review_summary'])assert.equal(sourceKindOf({source_type:type,source_url:'/x'}).kind,'third_party');
  // Look-alike hosts must not be classified as the brand's site.
  assert.equal(sourceKindOf({source_type:'existing_article_summary',source_url:'https://plushpuppy.co.nz.evil.example/x'}).kind,'external_article');
  assert.equal(sourceKindOf({source_type:'existing_article_summary',source_url:'https://notameblo.jp/x'}).kind,'external_article');
  for(const kind of ['external_blog','external_brand','external_article']){assert(isArticleKind(kind));assert(isExternalArticleKind(kind));}
  assert(isArticleKind('site_article')&&!isExternalArticleKind('site_article'));
  assert(!isArticleKind('third_party'));
});

test('labels never call an outside article a site article or a buyer review',()=>{
  for(const [,,url] of EXTERNAL){
    const k=sourceKindOf({source_type:'existing_article_summary',source_url:url});
    for(const field of [k.label,k.short,k.linkLabel])assert(!/サイト内記事/.test(field),url+': '+field);
    assert(/購入(者)?レビューではありません/.test(k.label),k.label);
    assert(k.linkLabel.startsWith('元の記事を見る'));
  }
  assert(sourceKindOf({source_type:'existing_article_summary',source_url:EXTERNAL[0][2]}).label.includes('個人ブログ'));
  assert(sourceKindOf({source_type:'existing_article_summary',source_url:EXTERNAL[1][2]}).label.includes('ブランド・販売元'));
  const site=sourceKindOf({source_type:'existing_article_summary',source_url:'/x.html'});
  assert.equal(site.label,'サイト内記事の再整理（他サイトの体験ではありません）','the site-article wording is unchanged');
});

test('API rows carry source_kind for article rows; rows and counts are not changed',async()=>{
  const d=fixture();const before=rowHash(d);
  const totalBefore=d.prepare('SELECT count(*) n FROM reviews').get().n;
  const body=await (await fetchPage(d,'/api/reviews?category=brush-pin&limit=100')).json();
  const byId=Object.fromEntries(body.reviews.map(r=>[r.id,r]));
  assert.equal(byId[950921].source_kind,'external_blog');
  assert(byId[950921].source_kind_label.includes('個人ブログ'));
  for(const id of [950922,950923,950924,950925,950926])assert.equal(byId[id].source_kind,'external_brand',String(id));
  assert.equal(byId[950931].source_kind,'third_party');assert.equal(byId[950931].source_kind_label,'');
  assert.equal(byId[950933].source_kind,'site_article');
  assert.equal(byId[950921].source_type,'existing_article_summary','stored source_type is unchanged and still reported');
  assert.equal(byId[950921].source_url,EXTERNAL[0][2],'stored URL is unchanged');
  const stats=await (await fetchPage(d,'/api/reviews/stats')).json();
  assert.equal(stats.count,totalBefore-d.prepare("SELECT count(*) n FROM reviews WHERE id IN (524,1194,1401,1402,1403,1412,1431,1433,1434,1435)").get().n,'the public count still includes all six rows');
  assert.equal(rowHash(d),before,'no row is read-modified');
});

test('server-rendered search cards label outside articles correctly and link to the original article',async()=>{
  const d=fixture();
  const html=await (await fetchPage(d,'/review-search?category=brush-pin&q=%E5%A4%96%E9%83%A8%E8%A8%98%E4%BA%8B')).text();
  assert(html.includes('<div class="kind">外部の個人ブログ記事の要約（購入者レビューではありません）</div>'));
  assert(html.includes('<div class="kind">ブランド・販売元サイトの記事の要約（飼い主の購入レビューではありません）</div>'));
  assert(!html.includes('<div class="kind">サイト内記事の再整理'),'outside articles are not shown as site articles');
  const link=html.match(/<a href="https:\/\/ameblo\.jp\/[^"]*"[^>]*>([^<]*)<\/a>/);
  assert(link&&link[1]==='元の記事を見る ↗');
  assert(/<a href="https:\/\/ameblo\.jp\/[^"]*" target="_blank" rel="noopener noreferrer nofollow">/.test(html),'outside links open safely and are not endorsed');
  const site=await (await fetchPage(d,'/review-search?category=brush-pin&q=%E3%82%B5%E3%82%A4%E3%83%88%E5%86%85%E3%81%AE%E8%A8%98%E4%BA%8B')).text();
  assert(site.includes('<div class="kind">サイト内記事の再整理（他サイトの体験ではありません）</div>'),'real site-article rows keep their label');
  assert(site.includes('元にしたサイト内記事を見る →'));
});

test('source breakdown counts site articles, outside articles and third-party summaries apart; the total is unchanged',async()=>{
  const d=fixture();
  const data=await loadSourceBreakdown(binding(d,[]));
  const plain=legacyDatabase();migrate(plain);
  const base=await loadSourceBreakdown(binding(plain,[]));
  assert.equal(data.externalArticle,6);
  assert.equal(data.article,base.article+1,'only the one real site-article fixture row is added to the site-article count');
  assert.equal(data.external,base.external+2);
  assert.equal(data.external+data.article+data.externalArticle,data.total,'the three groups add up to the total');
  assert.equal(data.total,base.total+9);
  const html=renderSourceBreakdownHtml(data);
  assert(html.includes(`外部の記事（個人ブログ・ブランドや販売元のサイト）を要約したものが<strong>6件</strong>`));
  assert(html.includes('いずれも購入者レビューとは別に数えています'));
  assert(html.includes('外部記事の要約（購入者レビューではありません）：6件'));
  assert(!html.includes('サイト内記事の再整理：6件'));
  assert.equal(base.externalArticle,0);
  assert(!renderSourceBreakdownHtml(base).includes('外部の記事'),'with no outside rows the text is the previous text');
});

test('product overview marks outside article rows and does not prefer them over buyer reviews',async()=>{
  const d=fixture();
  const html=await (await fetchPage(d,'/brush-pin')).text();
  const card=id=>html.slice(html.indexOf(`data-inu-profile="${id}"`),html.indexOf('</details>',html.indexOf(`data-inu-profile="${id}"`)));
  const pp=card('pp-regular-test');
  assert(pp.includes('［ブランド・販売元の記事の要約］'));
  assert(!pp.includes('［サイト内記事の再整理］'));
  assert(pp.includes('外部記事の要約（購入者レビューではありません）4件'),'its source breakdown says outside article');
  const blog=card('supreme-test');
  assert(blog.includes('［個人ブログ記事の要約］'));
  // Category note lists the two kinds separately.
  assert(text(html).includes('件は外部の記事（個人ブログ・ブランドや販売元のサイト）の要約で、飼い主の購入レビューではありません'));
  // A product that has buyer reviews quotes those, and only quotes articles when it has nothing else.
  // A product with two buyer reviews and one site article: the buyer reviews are quoted, the article is only counted.
  const third=card('third-test');
  assert(!third.includes('［サイト内記事の再整理］'),'with enough buyer reviews, article rows are not quoted');
  assert(third.includes('サイト内記事の再整理1件'),'but the source breakdown still counts the site article');
  assert(!third.includes('個人ブログ')&&!third.includes('ブランド・販売元'));
  const profiles=buildProfiles([{id:'a',name:'A'}],[
    {id:1,product_id:'a',dog_breed:'柴犬',dog_size:'medium',coat_type:null,needs:null,summary:'購入者の体験の要約で二十文字を超える長さの文章その一です。',source_type:'public_buyer_review_summary',source_url:'https://review.rakuten.co.jp/x'},
    {id:2,product_id:'a',dog_breed:'柴犬',dog_size:'medium',coat_type:null,needs:null,summary:'購入者の体験の要約で二十文字を超える長さの文章その二です。',source_type:'public_buyer_review_summary',source_url:'https://review.rakuten.co.jp/y'},
    {id:3,product_id:'a',dog_breed:'ビション',dog_size:'small',coat_type:null,needs:null,summary:'外部ブログの手順を要約した二十文字を超える長さの文章です。',source_type:'existing_article_summary',source_url:EXTERNAL[0][2]},
  ]);
  assert(profiles[0].examples.every(line=>!line.includes('個人ブログ')),'buyer reviews are quoted first');
  assert.equal(profiles[0].articleRows,1);assert.equal(profiles[0].externalArticleRows,1);
  assert.equal(sourceKind({source_type:'existing_article_summary',source_url:EXTERNAL[0][2]}),'外部記事の要約（購入者レビューではありません）');
  assert.equal(sourceKind({source_type:'existing_article_summary',source_url:'/brush-pin.html'}),'サイト内記事の再整理');
});

test('headline count note names outside article rows and is silent only when there are none',async()=>{
  const d=fixture();
  const html=await (await fetchPage(d,'/')).text();
  const note=text(html.slice(html.indexOf('data-inu-count-note')));
  assert(note.includes('外部の記事（個人ブログ・ブランドや販売元のサイト）の要約が6件'),note.slice(0,300));
  assert(note.includes('外部の記事は飼い主の購入レビューではなく'));
  const total=Number(note.match(/合計(\d+)件/)[1]);
  assert.equal(total,d.prepare("SELECT count(*) n FROM reviews r JOIN products p ON p.id=r.product_id WHERE p.active=1 AND r.id NOT IN (524,1194,1401,1402,1403,1412,1431,1433,1434,1435)").get().n);
});

test('everything PR-A reads is SELECT-only and the Worker never writes',async()=>{
  const d=fixture();const log=[];
  for(const p of ['/brush-pin','/review-search?category=brush-pin','/about','/','/api/reviews?category=brush-pin','/api/reviews/groups?category=brush-pin'])await fetchPage(d,p,log);
  assert(log.length>0);
  for(const q of log)assert.doesNotThrow(()=>assertReadQuery(q.sql),q.sql);
});

test('fragment cache key is versioned so labels from before the deploy are not served',()=>{
  const entry=readFileSync('src/final-entry.ts','utf8');
  assert(entry.includes('/__fragment/v2/'));assert(!entry.includes('/__fragment/v1/'));
});

test('client renderers use the shared kind and keep the old text only as a fallback',()=>{
  for(const file of ['db-review-browser.js','pet-dryer.html','review-search.html','dog-size.html','breed-toy-poodle.html']){
    const src=readFileSync('public/'+file,'utf8');
    assert(src.includes("const kindText=(r,part)=>"),file);
    assert(!/source_type\s*===\s*'existing_article_summary'\s*\?\s*'<div[^']*サイト内記事の再整理/.test(src),file+' no longer labels by source_type alone');
    assert(!/r\.source_type==='existing_article_summary'\?'［サイト内記事の再整理］'/.test(src),file);
  }
});
