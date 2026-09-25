import './ts-loader.mjs';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {createRequire} from 'node:module';
import {readFileSync,existsSync,mkdirSync} from 'node:fs';
import {resolve} from 'node:path';
const {default:worker}=await import('../src/final-entry.ts');
import {legacyDatabase,migrate,binding} from './database.mjs';
const require=createRequire(import.meta.url);
const {chromium}=process.env.CODEX_PRIMARY_RUNTIME_NODE_MODULES ? require(process.env.CODEX_PRIMARY_RUNTIME_NODE_MODULES+'/playwright') : require('playwright');
const db=legacyDatabase();migrate(db);
// Add 130 samples so every widget must request additional pages.
const product=db.prepare("SELECT id FROM products WHERE category='brush-pin' ORDER BY id LIMIT 1").get().id;
const insert=db.prepare("INSERT INTO reviews(product_id,dog_breed,dog_size,coat_type,needs,summary,source_url)VALUES(?,'トイプードル','small','curly','scared',?,'https://example.test/review')");
for(let i=0;i<130;i++)insert.run(product,'TEST SUMMARY '+i);
const ASSETS={async fetch(req){let p=new URL(req.url).pathname;if(p==='/')p='/index.html';if(!p.split('/').at(-1).includes('.'))p+='.html';const file=resolve('public','.'+p);if(!file.startsWith(resolve('public')+'/')||!existsSync(file))return new Response('',{status:404});return new Response(readFileSync(file),{headers:{'content-type':p.endsWith('.html')?'text/html':p.endsWith('.js')?'application/javascript':p.endsWith('.css')?'text/css':'text/plain'}});}};

await test('crawler-facing discovery routes contain useful data before client JavaScript',async()=>{
  for(const [path,marker] of [
    ['/review-search','data-static-review-fallback'],
    ['/review-insights','data-static-review-summary'],
    ['/dog-size','data-static-size-fallback'],
    ['/breed-toy-poodle','data-static-breed-fallback'],
  ]){
    const res=await worker.fetch(new Request('https://inu.test'+path),{DB:binding(db),ASSETS});
    assert.equal(res.status,200,path);
    const html=await res.text();
    assert(html.includes(marker),path+' missing '+marker);
    assert(!html.includes('データを取得できませんでした'),path);
  }
  const guide=await worker.fetch(new Request('https://inu.test/dog-brushing-dislike'),{DB:binding(db),ASSETS});
  const guideHtml=await guide.text();
  assert.equal(guide.status,200);
  assert(!guideHtml.includes('750件'));
  assert(guideHtml.includes('880件'));
});

const browser=await chromium.launch({headless:true,executablePath:process.env.CHROMIUM_EXECUTABLE_PATH||undefined,args:['--no-sandbox','--disable-dev-shm-usage']});
try{
  await test('mobile routes, filtered pages, no whole-review downloads, pagination, race and failure handling',async()=>{
    for(const width of [375,390,430,768]){
      const page=await browser.newPage({viewport:{width,height:900}});const errors=[],requests=[];let fail=false,delay=false;
      page.on('pageerror',e=>errors.push(e.message));
      await page.route('**/*',async route=>{
        const url=new URL(route.request().url());
        if(url.hostname!=='inu.test')return route.fulfill({status:204,body:''});
        if(process.env.JAPANESE_FONT_DIR && url.pathname.startsWith('/test-fonts/'))return route.fulfill({status:200,contentType:'font/woff2',body:readFileSync(resolve(process.env.JAPANESE_FONT_DIR,url.pathname.slice('/test-fonts/'.length)))});
        if(url.pathname.startsWith('/api/')){
          requests.push(url.pathname+url.search);
          if(fail&&url.pathname==='/api/reviews')return route.fulfill({status:503,contentType:'application/json',body:'{"error":"mock"}'});
          if(delay&&url.searchParams.get('size')==='small')await new Promise(r=>setTimeout(r,200));
        }
        const response=await worker.fetch(new Request(url,{method:route.request().method()}),{DB:binding(db),ASSETS});
        await route.fulfill({status:response.status,headers:Object.fromEntries(response.headers),body:await response.text()});
      });
      for(const path of ['/brush-guide','/brush-pin','/review-search','/dog-size','/breed-toy-poodle','/review-insights','/pet-dryer']){
        await page.goto('https://inu.test'+path);await page.waitForTimeout(300);await page.waitForLoadState('networkidle');
        if(process.env.JAPANESE_FONT_DIR){const css=readFileSync(resolve(process.env.JAPANESE_FONT_DIR,'400.css'),'utf8').replaceAll('./files/','/test-fonts/files/');await page.addStyleTag({content:css+"body{font-family:'Noto Sans JP',sans-serif!important}"});await page.evaluate(()=>document.fonts.ready);}
        assert.equal(await page.locator('h1').count(),1,path);
        assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1),`overflow ${path} ${width}`);
        if(width===390){mkdirSync('.test-artifacts',{recursive:true});await page.screenshot({path:'.test-artifacts/'+path.slice(1)+'.png',fullPage:true});}
        if(path==='/brush-pin'){
          await page.locator('[data-db-product-select]').selectOption(product);await page.waitForTimeout(300);await page.waitForLoadState('networkidle');
          assert.equal(await page.locator('.db-review-card').count(),6,JSON.stringify({errors,requests,status:await page.locator('[data-db-status]').textContent(),html:await page.locator('[data-db-review-list]').innerHTML()}));
          await page.locator('[data-db-more]').click();await page.waitForTimeout(300);await page.waitForLoadState('networkidle');assert.equal(await page.locator('.db-review-card').count(),14);
          await page.locator('[data-db-size-filter]').selectOption('large');await page.waitForTimeout(300);await page.waitForLoadState('networkidle');assert((await page.locator('[data-db-status]').textContent()).includes('件'));
        }
        if(path==='/review-search'){
          assert.equal(await page.locator('#list .card').count(),12);assert.equal(await page.locator('.dist-row').count(),8);
          await page.locator('#more').click();await page.waitForTimeout(300);await page.waitForLoadState('networkidle');assert.equal(await page.locator('#list .card').count(),24);
          await page.locator('#category').selectOption('brush-pin');await page.waitForTimeout(300);await page.waitForLoadState('networkidle');assert((await page.locator('#status').textContent()).includes('180件'));
          delay=true;await page.locator('#size').selectOption('small');await page.locator('#size').selectOption('large');await page.waitForTimeout(300);await page.waitForLoadState('networkidle');delay=false;
          assert((await page.locator('#status').textContent()).includes('件'));
          assert(!await page.locator('#list').textContent().then(t=>t.includes('TEST SUMMARY')));
          await page.locator('#reset').click();await page.waitForTimeout(300);await page.waitForLoadState('networkidle');
          fail=true;await page.locator('#size').selectOption('small');await page.waitForTimeout(300);await page.waitForLoadState('networkidle');assert((await page.locator('#status').textContent()).includes('表示中の体験を残しています'));assert((await page.locator('#list .card').count())>0);fail=false;
          await page.locator('#reset').click();await page.waitForTimeout(300);await page.waitForLoadState('networkidle');assert((await page.locator('#status').textContent()).includes('180件'));
          await page.locator('#query').fill('存在しない検索語');await page.waitForTimeout(350);await page.waitForTimeout(300);await page.waitForLoadState('networkidle');assert((await page.locator('#status').textContent()).includes('0件'));
        }
        if(path==='/dog-size'){assert((await page.locator('#cards .card').count())>0);if(await page.locator('#more').isVisible()){const count=await page.locator('#cards .card').count();await page.locator('#more').click();await page.waitForTimeout(300);await page.waitForLoadState('networkidle');assert((await page.locator('#cards .card').count())>count);}}
        if(path==='/breed-toy-poodle'){assert((await page.locator('#results .product').count())>0);if(await page.locator('#breedMore').isVisible()){const count=await page.locator('#results .product').count();await page.locator('#breedMore').click();await page.waitForTimeout(300);await page.waitForLoadState('networkidle');assert((await page.locator('#results .product').count())>count);}}
      }
      assert.deepEqual(errors,[],`browser errors at ${width}`);
      assert(requests.filter(p=>p.startsWith('/api/reviews?')).every(p=>p.includes('limit=')));
      assert(!requests.includes('/api/reviews'));
      console.log(`verified ${width}px: 7 routes; ${requests.length} API requests across actions`);
      await page.close();
    }
  });
}finally{await browser.close();}
