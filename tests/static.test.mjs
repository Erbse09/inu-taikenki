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
