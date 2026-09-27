import './ts-loader.mjs';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
import preview,{previewHtml} from '../src/preview-entry.ts';
import {validateConfig} from '../scripts/preview.mjs';
const req = (path='/',method='GET')=>new Request('https://preview.test'+path,{method});
test('preview references only the verified existing DB',()=>{
 const p=JSON.parse(readFileSync('wrangler.preview.json')),prod=JSON.parse(readFileSync('wrangler.jsonc'));
 validateConfig(p,prod);
 p.previews.d1_databases[0].database_id='11111111-1111-4111-8111-111111111111';
 assert.throws(()=>validateConfig(p,prod));
});
test('no runtime query on missing environment, production host, missing DB or write request',async()=>{
 const env={APP_ENV:'preview',DB:{prepare(){throw Error('must not query')}},ASSETS:{fetch(){throw Error('must not fetch')}}};
 for(const [r,e,status] of [[req(),{},503],[new Request('https://inu-taikenki.com/'),env,503],[req('/api/reviews','POST'),env,405],[req(),{APP_ENV:'preview'},503]]){
  const res=await preview.fetch(r,e);assert.equal(res.status,status);assert.match(res.headers.get('x-robots-tag'),/noindex/);
 }
});
test('robots can see noindex; sitemap and ads.txt are withheld',async()=>{
 for(const p of ['/robots.txt','/sitemap.xml','/ads.txt']){
  const r=await preview.fetch(req(p),{APP_ENV:'preview'});
  assert.equal(r.status,p==='/robots.txt'?200:404);assert.match(r.headers.get('x-robots-tag'),/noindex/);
 }
});
test('strips ad and analytics scripts while preserving site scripts, canonical and JSON-LD',()=>{
 const html='<head><meta name="robots" content="index"><link rel="canonical" href="https://inu-taikenki.com/"><script src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script><script>gtag("config","G-TEST")</script><script src="/db-review-browser.js"></script><script type="application/ld+json">{"@type":"WebSite"}</script></head>';
 const out=previewHtml(html);assert(!/adsbygoogle|gtag\(/.test(out));assert(out.includes('/db-review-browser.js'));assert(out.includes('application/ld+json'));assert(out.includes('canonical'));assert(out.includes('content="noindex, nofollow, noarchive"'));
});
test('static responses, 404, exceptions and HEAD receive protection',async()=>{
 for(const [status,throws] of [[200,false],[404,false],[503,true]]){
  const env={APP_ENV:'preview',DB:{},ASSETS:{async fetch(){if(throws)throw Error('private error');return new Response('asset',{status,headers:{'content-type':'text/plain'}})}}};
  for(const method of ['GET','HEAD']){
   const res=await preview.fetch(req('/test.txt',method),env);assert.equal(res.status,status);assert.match(res.headers.get('x-robots-tag'),/noindex/);assert.equal(res.headers.get('cache-control'),'no-store');assert.match(res.headers.get('content-security-policy'),/connect-src 'self'/);if(method==='HEAD')assert.equal(await res.text(),'');
  }
 }
});
