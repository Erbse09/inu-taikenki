// Read-only remote smoke audit. Does not replace browser/Safari or editorial review.
import assert from 'node:assert/strict';
const base = new URL(process.argv[2] || 'https://invalid.invalid');
assert(base.protocol === 'https:' && (base.hostname === 'develop.inu-taikenki.com' || base.hostname.endsWith('.workers.dev')), 'Pass the Preview URL (https://develop.inu-taikenki.com/), never production');
assert(base.username === '' && base.password === '' && base.pathname === '/' && !base.search && !base.hash,'Pass only the Preview origin');
const failures=[], pages=new Set(['/','/brush-pin','/pet-dryer','/review-search','/review-insights','/dog-size','/about','/privacy','/affiliate','/editorial-policy']);
const links=new Set();
function check(ok,label){if(!ok)failures.push(label);}
async function get(path){
 let url=new URL(path,base);
 for(let n=0;n<6;n++){
  assert.equal(url.origin,base.origin,'Unexpected cross-origin redirect');
  const r=await fetch(url,{redirect:'manual',signal:AbortSignal.timeout(20000)});
  check(/noindex/i.test(r.headers.get('x-robots-tag')||''),`${path}: noindex header missing`);
  if([301,302,303,307,308].includes(r.status)){assert(r.headers.get('location'),'Missing redirect location');url=new URL(r.headers.get('location'),url);continue;}
  return {response:r,url};
 }
 throw Error('Redirect loop: '+path);
}
async function json(path){const {response:r}=await get(path);assert(r.ok,`${path}: HTTP ${r.status}`);return r.json();}
for(const path of pages){
 try{
  const {response:r,url}=await get(path);check(r.ok,`${path}: HTTP ${r.status}`);
  const html=await r.text();
  check(/text\/html/i.test(r.headers.get('content-type')||''),`${path}: not HTML`);
  check(/<meta\b[^>]*name=["']viewport/i.test(html),`${path}: viewport missing`);
  check(/<title>[^<]+<\/title>/i.test(html),`${path}: title missing`);
  check(/rel=["']canonical["']/i.test(html),`${path}: canonical missing`);
  check(!/<script\b[^>]*>[\s\S]*?(?:adsbygoogle|googletagmanager|\bgtag\s*\()[\s\S]*?<\/script>/i.test(html),`${path}: advertising/analytics present`);
  const visible=html.replace(/<(script|style)\b[^>]*>[\s\S]*?<\/\1>/gi,'').replace(/<[^>]+>/g,' ');
  check(!/\b(?:undefined|null|NaN)\b/.test(visible),`${path}: abnormal visible text`);
  for(const m of html.matchAll(/\b(?:href|src)=["']([^"']+)["']/gi)){
   const u=new URL(m[1].replaceAll('&amp;','&'),url);
   if(u.origin===base.origin){u.hash='';links.add(u.pathname+u.search);}
  }
 }catch(e){failures.push(`${path}: ${e.message}`);}
}
// Bound the crawl and explicitly fail if incomplete rather than silently passing.
check(links.size<=200,`More than 200 internal links (${links.size}); extend the audit before release`);
for(const path of [...links].slice(0,200)){
 try{const {response:r}=await get(path);check(r.ok,`${path}: broken internal link HTTP ${r.status}`);await r.body?.cancel();}catch(e){failures.push(`${path}: ${e.message}`);}
}
try{
 const products=await json('/api/products?category=brush-pin&limit=100');
 const reviews=await json('/api/reviews?category=brush-pin&limit=20');
 check(Array.isArray(products.products)&&products.products.length>0,'No brush-pin products');
 check(Array.isArray(reviews.reviews)&&reviews.reviews.length>0,'No brush-pin reviews');
 check(Number.isInteger(reviews.count)&&reviews.count>=reviews.reviews.length,'Invalid review count');
 if(products.products?.[0]){const detail=await json('/api/products/'+encodeURIComponent(products.products[0].id)+'/reviews?limit=20');check(Array.isArray(detail.reviews),'Product reviews unavailable');}
 const filtered=await json('/api/reviews?category=brush-pin&size=small&limit=20');
 check(filtered.count<=reviews.count,'Filtered count exceeds category total');
 console.log(JSON.stringify({category:'brush-pin',products:products.products?.length,reviews:reviews.count,small:filtered.count}));
}catch(e){failures.push(e.message);}
console.log(JSON.stringify({origin:base.origin,checkedPages:pages.size,internalLinks:links.size,failures,manualRequired:['iPhone Safari layout and navigation','rendered dynamic counts vs DB audit','filter controls, product selection and pagination','wording consistency, accuracy and source evidence','external links and affiliate destinations','production SEO/AdSense config diff']},null,2));
process.exitCode=failures.length?1:0;
