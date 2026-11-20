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

test('nail-clipper E1 experiment: each spec row pairs its own model, JAN, dimensions and sources; Z01 source conflict is stated',async()=>{
  const res=await get('https://inu-taikenki.com/dog-nail-clipper');
  assert.equal(res.status,200);
  const html=await res.text();
  assert.match(html, /id="verified-product-specs"/);
  assert.match(html, /メーカー資料・販売店表示で比べた犬用爪切り4商品/);
  const rows=Object.fromEntries([...html.matchAll(/<tr data-e1-spec-row data-model="([^"]+)">([\s\S]*?)<\/tr>/g)].map(m=>[m[1],m[2]]));
  assert.deepEqual(Object.keys(rows),['Z02','Z06','Z01','W27413'],'four spec rows in the expected order');
  const N1='https://www.techplaza.city.higashiosaka.osaka.jp/storage/832/20170404_164940_240.pdf';
  const expect={
    Z02:{has:['Z02 / JAN 4562144610027','ギロチン式','小型〜中型犬用','全長125mm、刃部全幅6.8mm',N1,'https://www.higashiosakabrand.jp/products/627/','https://axel.as-1.co.jp/asone/d/63-1233-04/'],
         not:['4562144610065','4562144610010','63-1233-05','63-1233-07','10.75mm']},
    Z06:{has:['Z06 / JAN 4562144610065','ギロチン式','大型犬用','全長125mm、刃部全幅10.75mm',N1,'https://www.higashiosakabrand.jp/products/627/','https://axel.as-1.co.jp/asone/d/63-1233-05/'],
         not:['4562144610027','4562144610010','63-1233-04','63-1233-07','6.8mm']},
    Z01:{has:['Z01 / JAN 4562144610010','ニッパー式','全長120mm、刃部全幅11.5mm','対象犬の範囲とバネの交換可否は資料により異なります','「小型犬〜大型犬」「バネ交換可能」','「小型犬〜中型犬」「バネ交換不可」','購入する製品の表示を確認してください',N1,'https://www.higashiosakabrand.jp/products/633/','https://axel.as-1.co.jp/asone/d/63-1233-07/','https://item.rakuten.co.jp/petech/001142/'],
         not:['4562144610027','4562144610065','63-1233-04','63-1233-05']},
    W27413:{has:['W27413 / JAN 4903588274138','ハサミ式','全犬種用（メーカー表示）','幅5.9×奥行1×高さ12cm','約21g','https://www.petio.com/item/4903588274138/','https://www.petio.com/c/dog/dog-care/dog-nail/4903588274138'],
         not:['4562144610','axel.as-1.co.jp','未確認']},
  };
  for(const [model,{has,not}] of Object.entries(expect)){
    for(const v of has)assert(rows[model].includes(v),`${model} row is missing: ${v}`);
    for(const v of not)assert(!rows[model].includes(v),`${model} row must not contain another product's value: ${v}`);
  }
  // Z01 must not present only one side of the conflicting sources as the fact.
  assert.doesNotMatch(rows.Z01.replace(/「[^」]*」/g,''), /<td>小型〜中型犬用/);
  // The weight of the package listed by AS ONE is not the product weight.
  assert.match(html, /「荷姿」の重量は梱包を含む値のため、本体重量として載せていません/);
  assert.match(html, /仕様確認日：2026年11月21日/);
  // The Petio card states that the published experiences are mostly small dogs, not that the tool is unsuitable for large dogs.
  assert.match(html, /メーカーの表示は全犬種用。ただし、ここに掲載した体験は小型犬が中心/);
  assert(!html.includes('本体が小さめなので'),'old Petio wording that implied a size limit must be gone');
  const meta=html.match(/<meta name="description" content="([^"]+)">/i);
  assert(meta,'rendered meta description missing');
  assert.match(meta[1], /メーカー・販売元の公表仕様/);
  assert.doesNotMatch(meta[1], /Amazon/,'SEO description must not imply Amazon customer reviews are a source');
  const control=await (await get('https://inu-taikenki.com/dog-nail-grinder')).text();
  assert.doesNotMatch(control, /id="verified-product-specs"/, 'E1 changes must not leak into control article');
});
