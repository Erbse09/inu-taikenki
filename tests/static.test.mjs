import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync,readdirSync} from 'node:fs';
import vm from 'node:vm';
test('all public inline and external scripts parse',()=>{
  for(const file of readdirSync('public')){
    if(file.endsWith('.js'))new vm.Script(readFileSync('public/'+file,'utf8'),{filename:file});
    if(file.endsWith('.html'))for(const match of readFileSync('public/'+file,'utf8').matchAll(/<script\b([^>]*)>([\s\S]*?)<\/script>/gi)){
      if(/application\/ld\+json/.test(match[1])){JSON.parse(match[2]);continue;}
      new vm.Script(match[2],{filename:file});
    }
  }
});
test('required URLs and review sections preserved',()=>{
  for(const page of ['brush-guide','brush-pin','review-search','dog-size','breed-toy-poodle']){
    const html=readFileSync('public/'+page+'.html','utf8');assert(html.includes('<h1'));assert(html.includes('https://inu-taikenki.com/'+page));
  }
  const pin=readFileSync('public/brush-pin.html','utf8');assert(pin.includes('data-db-review-browser'));assert(pin.includes('/db-review-browser.js'));
});
test('no public client downloads unpaginated full review collections',()=>{
  for(const file of readdirSync('public').filter(x=>/\.(html|js)$/.test(x))){
    const code=readFileSync('public/'+file,'utf8');assert(!/fetch\(['"]\/api\/reviews['"]\)/.test(code),file);
  }
});


test('runtime review totals are sourced from D1 instead of a fixed 750 rewrite',()=>{
  const entry=readFileSync('src/final-entry.ts','utf8');
  assert(entry.includes('readLiveCounts'));
  assert(entry.includes('COUNT(*)'));
  assert(entry.includes('COUNT(DISTINCT category)'));
  assert(entry.includes('applyLiveCounts'));
  assert(!entry.includes('.replaceAll("700件", "750件")'));
});


test('AdSense-facing discovery pages keep useful server-rendered fallbacks',()=>{
  const entry=readFileSync('src/final-entry.ts','utf8');
  const search=readFileSync('public/review-search.html','utf8');
  const insights=readFileSync('public/review-insights.html','utf8');
  const distribution=readFileSync('public/review-product-distribution.js','utf8');
  const about=readFileSync('public/about.html','utf8');
  assert(entry.includes('integrateReviewSearchFallback'));
  assert(entry.includes('integrateReviewInsightsFallback'));
  assert(entry.includes('750 DOG PRODUCT EXPERIENCES'));
  assert(search.includes('各50件以上'));
  assert(!search.includes('読み込みに失敗しました'));
  assert(!search.includes('データを取得できませんでした'));
  assert(!insights.includes('データを取得できませんでした'));
  assert(!distribution.includes('体験分布を読み込めませんでした'));
  assert(!about.includes('11カテゴリ'));
  assert(!about.includes('合計550件'));
});


test('final AdSense audit fixes stay present',()=>{
  const privacy=readFileSync('public/privacy.html','utf8');
  const entry=readFileSync('src/final-entry.ts','utf8');
  const api=readFileSync('src/review-api.ts','utf8');
  const insights=readFileSync('public/review-insights.html','utf8');
  const browser=readFileSync('public/db-review-browser.js','utf8');
  const dryer=readFileSync('public/pet-dryer.html','utf8');
  const wrangler=readFileSync('wrangler.jsonc','utf8');
  const editorial=readFileSync('public/editorial-policy.html','utf8');

  assert(privacy.includes('Google AdSense'));
  assert(privacy.includes('https://adssettings.google.com/'));
  assert(privacy.includes('第三者配信事業者'));
  assert(api.includes("traitGroups"));
  assert(api.includes("COUNT(DISTINCT a.review_id)"));
  assert(api.includes("instr(r.dog_breed,'犬種不明')=0"));
  assert(insights.includes('<option value="multi">多頭</option>'));
  assert(insights.includes('<option value="skin">皮膚配慮</option>'));
  assert(!insights.includes('<option value="multi-dog">多頭</option>'));
  assert(!insights.includes('<option value="skin-sensitive">皮膚配慮</option>'));
  assert(entry.includes('integrateDogSizeFallback'));
  assert(entry.includes('integrateBreedFallback'));
  assert(entry.includes('data-static-insight-facets'));
  assert(!entry.includes('html = integrateReviewSourcePolicy(html);'));
  assert(wrangler.includes('"/breed-toy-poodle"'));
  assert(wrangler.includes('"/dog-brushing-dislike"'));
  assert(!browser.includes('読み込みに失敗しました'));
  assert(!browser.includes('データを取得できませんでした'));
  assert(!browser.includes('公開体験を準備中'));
  assert(!dryer.includes('データを取得できませんでした'));
  assert(editorial.includes('記事の分析件数と現在の検索件数'));

  const entryLayer=readFileSync('src/entry.ts','utf8');
  const search=readFileSync('public/review-search.html','utf8');
  assert(!entryLayer.includes('条件検索で表示する公開体験は50件です'));
  assert(!entryLayer.includes('このページ下部から犬のサイズ・毛質・条件で50件の体験を絞り込めます'));
  assert(!entryLayer.includes('各ブラシ種類ごとに50件の公開体験を整理しています'));
  assert(!entryLayer.includes('このブラシ種類では50件の公開体験を整理しています'));
  assert(entryLayer.includes('記事作成時の分析：50件'));
  assert(entryLayer.includes('その後追加された分を含む現在の収録体験'));
  assert(insights.includes("skin:'皮膚配慮'"));
  assert(insights.includes('犬種そのものの判明率ではありません'));
  assert(insights.includes('犬種欄に記載あり*'));
  assert(browser.includes("sourceUrl.startsWith('/') ? '元にしたサイト内記事を見る →'"));
  assert(search.includes("sourceUrl.startsWith('/')?'元にしたサイト内記事を見る →'"));
  assert(entry.includes('row.source_type === "existing_article_summary" && url.startsWith("/")'));

  for(const file of readdirSync('public').filter(x=>x.endsWith('.html'))){
    const html=readFileSync('public/'+file,'utf8');
    assert(!html.includes('犬の大きさから50件の体験を見る'),file);
    assert(!html.includes('このカテゴリの50件を検索'),file);
  }
});

test('mobile readability, image weight, ad disclosure and count labels',()=>{
  const wrangler=readFileSync('wrangler.jsonc','utf8');
  for(const file of readdirSync('public').filter(x=>x.endsWith('.html'))){
    const html=readFileSync('public/'+file,'utf8');
    const route='/'+file.slice(0,-5);
    if(file!=='index.html'&&!route.startsWith('/pet-dryer'))assert(wrangler.includes(`"${route}"`),'run_worker_first missing '+route);
    if(/amazon\.co\.jp|db-review-browser\.js/.test(html))assert(html.includes('data-pr-disclosure'),'PR disclosure missing '+file);
    assert(!/\.(PNG|png)["']/.test(html.replace(/favicon[^"']*/g,'')),'heavy PNG referenced '+file);
  }
  for(const dir of ['public','src'])for(const file of readdirSync(dir).filter(x=>/\.(html|css|js|ts)$/.test(x))){
    const code=readFileSync(dir+'/'+file,'utf8');
    assert(!/font-size: ?([0-9]|10)(\.\d+)?px/.test(code),'font-size under 11px in '+dir+'/'+file);
  }
  const home=readFileSync('public/index.html','utf8');
  assert(!home.includes('公開体験50件で比較'));
  assert(home.includes('data-count-note'));
  assert(home.includes('href="dog-ear-cleaner"'));
  for(const page of ['dog-toothbrush','dog-toothpaste','dog-dental-chew','dog-ear-cleaner','dog-conditioner']){
    assert(readFileSync('public/'+page+'.html','utf8').includes('data-article-coverage'),page);
  }
  const finalEntry=readFileSync('src/final-entry.ts','utf8');
  assert(!/6商品・50件の体験/.test(finalEntry));
  assert(!readFileSync('src/index.ts','utf8').includes('商品別に50件の体験を見る'));
});

test('fixed "50件" only appears as an explicit article-analysis count',()=>{
  // Phrases that clearly refer to the article's own analysis, or to a true minimum per category.
  const allowed=['50件から見えた','50件をどう読んだか','この記事で分析した50件','各50件以上','各カテゴリ50件以上','「50件」などの件数'];
  const isExplicit=(text,index)=>/記事作成時/.test(text.slice(Math.max(0,index-30),index))
    || allowed.some(phrase=>{const at=text.indexOf(phrase,Math.max(0,index-15));return at!==-1&&at<=index&&index<at+phrase.length;});
  const files=[...readdirSync('public').filter(x=>x.endsWith('.html')).map(x=>'public/'+x),...readdirSync('src').filter(x=>x.endsWith('.ts')).map(x=>'src/'+x)];
  for(const file of files){
    const text=readFileSync(file,'utf8');
    for(const m of text.matchAll(/(?<![\d,])50件/g)){
      assert(isExplicit(text,m.index),`${file}: ambiguous fixed count "${text.slice(Math.max(0,m.index-30),m.index+10).replace(/\s+/g,' ')}"`);
    }
    if(!file.endsWith('.html'))continue;
    const zones=[
      ...[...text.matchAll(/<title>([\s\S]*?)<\/title>/gi)].map(x=>['title',x[1]]),
      ...[...text.matchAll(/<meta\b(?=[^>]*\bname=["']description["'])[^>]*content=["']([^"']*)["']/gi)].map(x=>['description',x[1]]),
      ...[...text.matchAll(/<h1\b[^>]*>([\s\S]*?)<\/h1>/gi)].map(x=>['h1',x[1]]),
      ...[...text.matchAll(/<a\b[^>]*>([\s\S]*?)<\/a>/gi)].map(x=>['link',x[1]]),
    ];
    for(const [kind,value] of zones)assert(!/(?<![\d,])50件/.test(value),`${file}: fixed 50件 in ${kind}: ${value.replace(/<[^>]+>/g,'').slice(0,60)}`);
    for(const m of text.matchAll(/<b>50<\/b><span>([^<]*)<\/span>/g)){
      assert(['記事作成時の分析','各カテゴリ最低件数'].includes(m[1]),`${file}: unclear 50 stat label "${m[1]}"`);
    }
  }
});

test('DEVELOPMENT.md reflects the live develop Preview',()=>{
  const doc=readFileSync('DEVELOPMENT.md','utf8');
  assert(doc.includes('https://develop.inu-taikenki.com'));
  assert(!doc.includes('未発行'));
  assert(!doc.includes('初回：Cloudflare'));
  assert(!/ChatGPT[^\n]*確認済み/.test(doc));
  const audit=readFileSync('scripts/audit-preview.mjs','utf8');
  assert(audit.includes("'develop.inu-taikenki.com'"));
});
