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

test('shampoo E3 experiment: each row pairs its own volumes, codes, JAN, usage and sources; rinse and medicine wording follow the sources',async()=>{
  const res=await get('https://inu-taikenki.com/dog-shampoo');
  assert.equal(res.status,200);
  const html=await res.text();
  assert.match(html, /id="shampoo-source-matrix"/);
  const rows=Object.fromEntries([...html.matchAll(/<tr data-e3-shampoo-row data-product="([^"]+)">([\s\S]*?)<\/tr>/g)].map(m=>[m[1],m[2]]));
  assert.deepEqual(Object.keys(rows),['apdc-teatree','zoic-n-short','zoic-n-long','shizenryu-all']);
  const ZPDF='https://www.zoic.jp/cms/wp-content/uploads/2024/05/';
  const expect={
    'apdc-teatree':{has:['250mL：13A2024SP／JAN 4528636808020','500mL：13A2024SPL／JAN 4528636808037','業務用5L：13A2024SPXL／JAN 4528636808044','原液または2〜5倍に薄めて','https://www.apdc.jp/product/dog.html','https://takakura.co.jp/products/1448/','https://takakura.co.jp/products/1449/','https://takakura.co.jp/products/1470/'],
                    not:['49897933','4963974','4562233','3〜15倍','30277','30282']},
    'zoic-n-short':{has:['300mL：商品コード30277','JAN 4989793350799','4L：JAN 4989793350805','中・短毛','ダックスフンド、プードル、ポメラニアン','軽くさらっとした仕上がり','希釈の要否・倍率は未確認',ZPDF,'https://www.zoic.jp/ec/products/detail/464','https://shopping.yahoo.co.jp/products/2f01e5177c'],
                    not:['30282','4989793350843','4989793350850','detail/466','ヨークシャテリア','2〜5倍','3〜15倍']},
    'zoic-n-long':{has:['300mL：商品コード30282','JAN 4989793350843','4L：JAN 4989793350850','長毛','ヨークシャテリア、マルチーズ、シーズー、ロングコートチワワ','しっとりまとまる仕上がり','希釈の要否・倍率は未確認','<strong>4Lの購入者</strong>',ZPDF,'https://www.zoic.jp/ec/products/detail/466','https://item.rakuten.co.jp/nishimura-ejoy/p000029560/'],
                   not:['30277','4989793350799','4989793350805','detail/464','ダックスフンド','2〜5倍','3〜15倍']},
    'shizenryu-all':{has:['自然流トリートメントシャンプー 全犬種用','60mL：JAN 4963974005227','300mL：JAN 4963974005326','2L：JAN 4562233455126','通常3〜15倍','約5倍','「泡が切れて、少しぬめりが残る程度」','他の3商品には当てはめない','（5〜20倍）とは希釈倍率が違う','300mLの購入者1人の感想','https://redheart.co.jp/products/shizenryu/','https://redheart.co.jp/customer/faq/faq-shizenryu/','https://kishipet-online.com/product.php?id=1317'],
                     not:['4989793','4528636','2〜5倍に薄めて']},
  };
  for(const [product,{has,not}] of Object.entries(expect)){
    for(const v of has)assert(rows[product].includes(v),`${product} row is missing: ${v}`);
    for(const v of not)assert(!rows[product].includes(v),`${product} row must not contain another product's value: ${v}`);
  }
  // No blanket claim that shampoo is not a medicine; product-level labels decide.
  assert(!html.includes('シャンプーは医薬品ではなく'),'blanket "shampoo is not a medicine" wording must be gone');
  assert.match(html, /この記事では、4商品の洗い方・被毛の仕上がりと購入者の体験を比較します。赤みや強いかゆみが続く場合は獣医師に相談してください。/);
  assert.match(html, /「薬用」などの表示や効能<\/strong>は、それぞれの製品の容器・メーカーの表示で確認してください/);
  // The rinse FAQ names 自然流 and no longer tells every product to rinse until no slipperiness remains.
  const rinse=html.match(/<summary>すすぎはどのくらい必要？<\/summary><div class="faq-answer">([\s\S]*?)<\/div>/)[1];
  assert.match(rinse, /使う製品の表示を確認してください/);
  assert.match(rinse, /例えば自然流は、公式FAQで「泡が切れて、少しぬめりが残る程度」を目安/);
  assert.match(rinse, /ほかの製品には当てはめず/);
  assert.doesNotMatch(html, /泡やぬめりが残らないよう/);
  // Volume-specific cards and cases: 4L experience stays 4L, 300 mL codes stay with 300 mL.
  assert.match(html, /300mLは商品コード30282／JAN 4989793350843、4LはJAN 4989793350850（卸の表示）。掲載したゴールデン2頭の体験は4Lの購入者です。/);
  assert.match(html, /300mLは商品コード30277／JAN 4989793350799、4LはJAN 4989793350805（卸の表示）/);
  assert.match(html, /<div class="meta">ZOIC N ロング 4L<\/div><b>ゴールデンレトリバー2頭/);
  assert.match(html, /<div class="meta">自然流 全犬種用 300mL<\/div><b>約30kgの犬[\s\S]*?300mLを購入した1人の感想で、製品の効果を示すものではありません。/);
  assert.match(html, />Yahoo!：ZOIC N ロング 4L レビュー</);
  const control=await (await get('https://inu-taikenki.com/dog-clipper')).text();
  assert.doesNotMatch(control,/id="shampoo-source-matrix"/,'E3 section must not leak into dog-clipper control');
});
