import './ts-loader.mjs';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync,readdirSync} from 'node:fs';
import {resolve} from 'node:path';
const {applyLiveCounts,needsLiveCounts}=await import('../src/live-counts.ts');
const {default:worker}=await import('../src/final-entry.ts');
const {DatabaseSync}=await import('node:sqlite');

const counts={total_reviews:1595,total_categories:15};

test('current totals follow the database, historical counts do not',()=>{
  const html='<p>合計750件・15カテゴリ。最初の約750件の整理にはChatGPTが関わっています。</p>';
  const out=applyLiveCounts(html,counts);
  assert(out.includes('合計1595件・15カテゴリ'));
  assert(out.includes('最初の約750件の整理にはChatGPT'));
  assert(!out.includes('最初の約1595件'));
});

test('fixed-count marker and phrase patterns are protected, including repeats',()=>{
  const html='<span data-fixed-count>当時の750件</span> 750件 初期の約700件 最初の750件 <span class="x" data-fixed-count="1">700件</span> 700 EXPERIENCES';
  const out=applyLiveCounts(html,counts);
  assert.equal(out,'<span data-fixed-count>当時の750件</span> 1595件 初期の約700件 最初の750件 <span class="x" data-fixed-count="1">700件</span> 1595 EXPERIENCES');
});

test('without live counts nothing is rewritten, and headline widgets still update',()=>{
  const html='<b>750</b><span>公開体験</span> 最初の約750件';
  assert.equal(applyLiveCounts(html,null),html);
  assert.equal(applyLiveCounts(html,counts),'<b>1595</b><span>公開体験</span> 最初の約750件');
  assert(needsLiveCounts('最初の約750件'));
});

test('source pages keep every historical count behind a protected form',()=>{
  // Any "…最初の約N件" wording in the sources must survive applyLiveCounts byte for byte.
  for(const file of readdirSync('public').filter(f=>f.endsWith('.html'))){
    const html=readFileSync('public/'+file,'utf8');
    const hist=html.match(/(?:最初の|初期の)約?[\d,]+件/g)||[];
    const out=applyLiveCounts(html,counts);
    for(const h of hist)assert(out.includes(h),file+': '+h+' was rewritten');
    // a history-style sentence is never left unprotected
    for(const m of html.matchAll(/(?:当初|はじめ|最初|初期)[^。<]{0,8}?(\d{3,4})件/g)){
      assert(/(?:最初の|初期の)約?[\d,]+件/.test(m[0])||html.includes('data-fixed-count'),file+': unprotected historical count '+m[0]);
    }
  }
});

test('/about and /editorial-policy keep "最初の約750件" through the real Worker with a 1,595-row database',async()=>{
  const db=new DatabaseSync(':memory:');
  db.exec('CREATE TABLE products(id INTEGER PRIMARY KEY,category TEXT,active INTEGER);CREATE TABLE reviews(id INTEGER PRIMARY KEY,product_id INTEGER);');
  db.exec("INSERT INTO products VALUES(1,'a',1)");
  const ins=db.prepare('INSERT INTO reviews(product_id) VALUES(1)');
  for(let i=0;i<1595;i++)ins.run();
  const DB={prepare(sql){const st=db.prepare(sql);return {bind(){return this},async first(){return st.get()??null},async all(){return {results:st.all()}},async run(){return {}}}}};
  const ASSETS={async fetch(req){let p=new URL(req.url).pathname;if(p==='/')p='/index.html';if(!p.split('/').at(-1).includes('.'))p+='.html';try{return new Response(readFileSync(resolve('public','.'+p)),{headers:{'content-type':'text/html; charset=utf-8'}});}catch{return new Response('nf',{status:404});}}};
  for(const page of ['/about','/editorial-policy']){
    const html=await (await worker.fetch(new Request('https://inu-taikenki.com'+page),{DB,ASSETS})).text();
    assert((html.match(/最初の約750件/g)||[]).length>=2,page+': historical 750 must stay');
    assert(!/最初の約(?:1595|1,595)件/.test(html),page+': historical count was overwritten');
  }
  const about=await (await worker.fetch(new Request('https://inu-taikenki.com/about'),{DB,ASSETS})).text();
  assert(about.includes('合計1595件'),'current total on /about still follows the database');
});
