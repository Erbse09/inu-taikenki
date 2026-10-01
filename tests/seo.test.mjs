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
