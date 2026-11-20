import './ts-loader.mjs';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync,existsSync} from 'node:fs';
import {resolve} from 'node:path';
import {legacyDatabase,migrate,binding} from './database.mjs';
const {default:worker}=await import('../src/final-entry.ts');

const db=legacyDatabase();migrate(db);
const ASSETS={async fetch(req){let p=new URL(req.url).pathname;if(p==='/')p='/index.html';if(!p.split('/').at(-1).includes('.'))p+='.html';const file=resolve('public','.'+p);if(!file.startsWith(resolve('public')+'/')||!existsSync(file))return new Response('',{status:404});return new Response(readFileSync(file),{headers:{'content-type':p.endsWith('.html')?'text/html':p.endsWith('.xml')?'application/xml':'text/plain'}});}};
const get=(url)=>worker.fetch(new Request(url,{redirect:'manual'}),{DB:binding(db),ASSETS});

test('duplicate URL variants permanently redirect to one https non-www extensionless URL',async()=>{
  for(const [from,to] of [
    ['http://inu-taikenki.com/auto-feeder','https://inu-taikenki.com/auto-feeder'],
    ['https://www.inu-taikenki.com/auto-feeder','https://inu-taikenki.com/auto-feeder'],
    ['https://inu-taikenki.com/auto-feeder.html','https://inu-taikenki.com/auto-feeder'],
    ['https://inu-taikenki.com/dog-nail-clipper.html','https://inu-taikenki.com/dog-nail-clipper'],
    ['https://inu-taikenki.com/review-search.html','https://inu-taikenki.com/review-search'],
    ['https://inu-taikenki.com/index.html','https://inu-taikenki.com/'],
    ['https://inu-taikenki.com/index','https://inu-taikenki.com/'],
    ['http://www.inu-taikenki.com/','https://inu-taikenki.com/'],
  ]){
    const res=await get(from);
    assert.equal(res.status,301,from);
    assert.equal(res.headers.get('location'),to,from);
  }
});

test('every canonical page renders a self-referencing https non-www canonical',async()=>{
  const sitemap=readFileSync('public/sitemap.xml','utf8');
  for(const [,loc] of sitemap.matchAll(/<loc>([^<]+)<\/loc>/g)){
    const res=await get(loc);
    assert.equal(res.status,200,loc);
    const html=await res.text();
    const canonicals=[...html.matchAll(/<link rel="canonical" href="([^"]+)">/g)].map(m=>m[1]);
    assert.deepEqual(canonicals,[loc],loc);
    assert(!/<meta[^>]+name=["']robots["'][^>]+noindex/i.test(html),loc+' must stay indexable');
  }
});

test('sitemap lists every public page once, with canonical URLs only',async()=>{
  const {readdirSync}=await import('node:fs');
  const locs=[...readFileSync('public/sitemap.xml','utf8').matchAll(/<loc>([^<]+)<\/loc>/g)].map(m=>m[1]);
  assert.equal(new Set(locs).size,locs.length,'duplicate <loc>');
  for(const loc of locs){
    assert.match(loc,/^https:\/\/inu-taikenki\.com\/[a-z0-9-]*$/,loc+' must be https, non-www, extensionless, without query');
  }
  const pages=readdirSync('public').filter(f=>f.endsWith('.html')).map(f=>f==='index.html'?'https://inu-taikenki.com/':'https://inu-taikenki.com/'+f.slice(0,-5));
  assert.deepEqual([...locs].sort(),[...pages].sort(),'sitemap and public pages differ');
});

test('problem guides and the breed page are linked from many related pages, never from themselves',async()=>{
  const {readdirSync}=await import('node:fs');
  const pages=readdirSync('public').filter(f=>f.endsWith('.html')).map(f=>f==='index.html'?'/':'/'+f.slice(0,-5));
  const rendered={};
  for(const p of pages)rendered[p]=await (await get('https://inu-taikenki.com'+p)).text();
  for(const guide of ['/dog-brushing-dislike','/dog-nail-care-dislike','/dog-toothbrushing-dislike','/dog-home-shampoo-guide','/breed-toy-poodle']){
    const from=pages.filter(p=>p!==guide&&new RegExp(`href=["']https?://inu-taikenki\\.com${guide}["']|href=["']${guide}["']|href=["']${guide.slice(1)}["']`).test(rendered[p]));
    assert(from.length>=10,`${guide} linked from only ${from.length} pages`);
    const related=rendered[guide].match(/<section data-inu-related-guides[\s\S]*?<\/section>/)?.[0]||'';
    assert(!related.includes(`href="${guide}"`),guide+' links to itself');
    assert.equal((rendered[guide].match(/data-inu-related-guides/g)||[]).length,1,guide+' related section count');
  }
});

test('brush explainers answer とは/違い/選び方 and FAQ schema mirrors the visible FAQ only',async()=>{
  for(const [page,word] of [['brush-pin','ピンブラシ'],['brush-slicker','スリッカー'],['brush-undercoat','アンダーコート'],['brush-comb','コーム']]){
    const html=await (await get('https://inu-taikenki.com/'+page)).text();
    const explainer=html.match(/<section class="tool-explainer">[\s\S]*?<\/section>/)[0];
    assert(explainer.includes('とは？'),page);
    assert(explainer.includes('違い'),page);
    assert(explainer.includes('<strong>選び方：</strong>'),page);
    const visible=[...html.matchAll(/<details class="faq-item"><summary>([\s\S]*?)<\/summary>/g)].map(m=>m[1].replace(/<[^>]+>/g,'').trim());
    assert(visible.some(q=>q.includes('選び方')),page+' FAQ lacks 選び方');
    assert(visible.some(q=>q.includes(word)&&q.includes('違い'))||visible.some(q=>q.includes('違い')),page+' FAQ lacks 違い');
    const schemas=[...html.matchAll(/<script type="application\/ld\+json" data-inu-faq-schema>([\s\S]*?)<\/script>/g)];
    assert.equal(schemas.length,1,page);
    const faq=JSON.parse(schemas[0][1]);
    assert.equal(faq['@type'],'FAQPage');
    assert.deepEqual(faq.mainEntity.map(q=>q.name),visible,page+' schema must equal visible questions');
  }
});

test('titles keep the search phrases that earned impressions (とは / 選び方 / 違い)',async()=>{
  for(const [page,phrases] of [
    ['brush-pin',['ピンブラシとは','違い']],
    ['brush-slicker',['スリッカーブラシとは','違い']],
    ['brush-undercoat',['アンダーコートブラシとは','違い']],
    ['brush-comb',['コームとは','違い']],
    ['dog-nail-grinder',['電動爪やすりとは','違い']],
    ['auto-feeder',['自動給餌器の選び方']],
    ['pet-dryer',['ペットドライヤーの選び方','違い']],
    ['dog-nail-clipper',['ギロチン・ニッパーの違い']],
  ]){
    const html=await (await get('https://inu-taikenki.com/'+page)).text();
    const titles=[...html.matchAll(/<title>([\s\S]*?)<\/title>/g)].map(m=>m[1]);
    assert.equal(titles.length,1,page);
    for(const phrase of phrases)assert(titles[0].includes(phrase),`${page}: "${titles[0]}" lacks ${phrase}`);
    const desc=html.match(/<meta name="description" content="([^"]+)">/)?.[1]||'';
    assert(desc.length>=70,page+' description too short');
  }
});

test('GA4 affiliate click event carries product and article info, and the injected script parses',async()=>{
  const vm=await import('node:vm');
  const html=await (await get('https://inu-taikenki.com/brush-pin')).text();
  const script=[...html.matchAll(/<script>([\s\S]*?)<\/script>/g)].map(m=>m[1]).find(s=>s.includes("'product_click'"));
  assert(script,'GA4 click script missing');
  new vm.Script(script);
  for(const key of ['affiliate_network','is_affiliate','product_name','article_path'])assert(script.includes(key),key);
});

test('internal links never point at redirecting .html URLs (server HTML and inline/page scripts)',async()=>{
  const locs=[...readFileSync('public/sitemap.xml','utf8').matchAll(/<loc>([^<]+)<\/loc>/g)].map(m=>m[1]);
  const pattern=/["'`]\/[a-z0-9-]+\.html(?=[?#"'`])/gi;
  for(const loc of locs){
    const html=await (await get(loc)).text();
    assert.deepEqual(html.match(pattern)||[],[],loc);
  }
  for(const file of ['public/db-review-browser.js']){
    assert.deepEqual(readFileSync(file,'utf8').match(pattern)||[],[],file);
  }
  // Rows whose source is a site-internal article are stored as "/pet-dryer.html"; the rendered link must be extensionless.
  const search=await (await get('https://inu-taikenki.com/review-search?category=pet-dryer')).text();
  assert(!search.includes('href="/pet-dryer.html"'),'review-search SSR must not link to /pet-dryer.html');
});

test('comb E2 experiment: each row pairs its own sizes, model numbers, EAN/JAN and sources; cards and finder name the same models',async()=>{
  const res=await get('https://inu-taikenki.com/brush-comb');
  assert.equal(res.status,200);
  const html=await res.text();
  assert.match(html, /id="comb-choosing-matrix"/);
  const rows=Object.fromEntries([...html.matchAll(/<tr data-e2-comb-row data-model="([^"]+)">([\s\S]*?)<\/tr>/g)].map(m=>[m[1],m[2]]));
  assert.deepEqual(Object.keys(rows),['okano-ryome','showtech-2','showtech-1']);
  const expect={
    'okano-ryome':{has:['呼番 小・中・大','小 4907733140019','中 4907733140026','大 4907733140033','小29×154、中32×167、大35×194','カーボンスチール','クロームメッキ','29／32／35mmを歯の長さとは扱わない','「大」の体験は調べていない','https://www.petokano.com/life/comb_01.html','https://universcorporation.com/product.php?id=3907'],
                   not:['5420031924','26STE','TR26SE']},
    'showtech-2':{has:['#2（帯電防止モデル','品番 26STE007','TR26SE007','EAN 5420031924666','全長190mm','コーム面183×32mm','静電気防止コーティング','海外販売店の表示','https://freebird-wholesale.com/view/item/000000000213','https://item.rakuten.co.jp/petsdms/10010159/','https://groomershop.pl/'],
                  not:['26STE006','TR26SE006','5420031924659','tr26se006','4907733']},
    'showtech-1':{has:['#1（標準モデル','品番 26STE006','TR26SE006','EAN 5420031924659','全長190mm','コーム面183×32mm','材質は資料で異なる','「真鍮」','「ステンレス」','#1の帯電性能は未確認','https://item.rakuten.co.jp/freebird/tr26se006/','https://cart.pljapan.com/products/detail.php?product_id=112223250','https://www.petsdms.com/view/item/000000002172','https://groomershop.eu/'],
                  not:['26STE007','TR26SE007','5420031924666','000000000213','4907733']},
  };
  for(const [model,{has,not}] of Object.entries(expect)){
    for(const v of has)assert(rows[model].includes(v),`${model} row is missing: ${v}`);
    for(const v of not)assert(!rows[model].includes(v),`${model} row must not contain another product's value: ${v}`);
  }
  // Disputed or unverified values are not stated as fact.
  assert.doesNotMatch(rows['showtech-1'], /<td><strong>販売店表示<\/strong>[^<]*(真鍮|ステンレス)/, '#1 material must not be asserted in the confirmed column');
  assert.match(html, /どちらも「19cm」＝<strong>全長190mm<\/strong>/);
  // Product cards show the same two models; the Amazon search keys used for click analytics stay as before.
  assert.match(html, /<h3>SHOW TECH グレイハウンド ブラックコーム 19cm #2（帯電防止・ASコーム）<\/h3>/);
  assert.match(html, /<h3>SHOW TECH グレイハウンド コーム 19cm #1（標準）<\/h3>/);
  assert(html.includes('data-amazon-search="SHOWTECH グレイハウンド ASコーム"')&&html.includes('data-amazon-search="SHOWTECH NEW GREYHOUND 19cm"'),'existing search keys kept');
  // The JavaScript finder names the same models, and #1 is recommended only from its own reviews and length.
  const products=JSON.parse(html.match(/const itemProducts=(\[[\s\S]*?\]);/)[1]);
  const names=products.map(p=>p.name);
  assert.deepEqual(names,['岡野製作所 高級両目金櫛','SHOW TECH グレイハウンド ブラックコーム 19cm #2（帯電防止）','SHOW TECH グレイハウンド コーム 19cm #1（標準）']);
  const one=products[2];
  assert.doesNotMatch(one.reason, /19cmの長さを活かして/);
  assert.match(one.reason, /#1の商品ページの体験/);
  assert.match(one.evidence, /#1の商品ページのレビュー/);
  assert(!one.tags.includes('大型犬')&&!one.tags.includes('中型犬'),'#1 tags must follow its own reviews (toy poodle, Yorkie)');
  const experiences=JSON.parse(html.match(/const itemExperiences=(\[[\s\S]*?\]);/)[1]);
  assert(experiences.every(e=>!/#1/.test(e.product)),'#2 experiences must not be moved to #1');
  assert(!html.includes('SHOWTECH AS<'),'old ambiguous case label is gone');
  const control=await (await get('https://inu-taikenki.com/brush-pin')).text();
  assert.doesNotMatch(control, /id="comb-choosing-matrix"/, 'E2 section must not leak into brush-pin control');
});
