import './ts-loader.mjs';
import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFileSync} from 'node:fs';
const {LEDGER,LEDGER_URLS,LEDGER_DATE}=await import('../src/review-source-ledger.ts');
const {sourceCheck,ledgerTotals,CHECK_STATUSES}=await import('../src/review-source-check.ts');
const {buildProfiles,renderSourceBreakdownHtml}=await import('../src/product-profiles.ts');

const csv=readFileSync('audit/review-source-20261017/ledger.csv','utf8').trim().split('\n').slice(1).map(line=>{
  // fields never contain commas or quotes (ids, slugs, URLs, tokens)
  const [id,product,category,status,method,pageUrl,sourceUrl,token]=line.split(',');
  return {id:Number(id),product,category,status,method,pageUrl,sourceUrl,token};
});

test('ledger file and the audit CSV describe exactly the same rows',()=>{
  assert.equal(csv.length,Object.keys(LEDGER).length);
  for(const r of csv){
    const entry=LEDGER[r.id];
    assert(entry,`row ${r.id} missing from the ledger`);
    assert.equal(entry[0],r.status,`row ${r.id}`);
    if(r.status==='V')assert.equal(LEDGER_URLS[entry[1]],r.pageUrl,`row ${r.id} page`);
  }
});

test('only rows whose matching post was found are "verified" and linked',()=>{
  let verified=0;
  for(const id of Object.keys(LEDGER)){
    const c=sourceCheck(id);
    assert(CHECK_STATUSES.includes(c.status));
    assert.equal(c.short==='出典確認済み',c.status==='V',`row ${id}: verified label must follow status V only`);
    if(c.status==='V'){verified++;assert.match(c.url,/^https:\/\//,`row ${id} needs a concrete link`);}
    else assert.equal(c.url,null,`row ${id}: no link for an unverified row`);
    assert(!c.label.includes('確認できました')||c.status==='V');
  }
  assert(verified>0);
  assert.equal(sourceCheck(999999),null,'an unlisted row is "not checked", never verified');
  assert.equal(sourceCheck(null),null);
});

test('status labels never claim more than the audit found',()=>{
  for(const s of ['P','N','U','C']){
    const t=sourceCheck(Object.keys(LEDGER).find(id=>LEDGER[id][0]===s));
    assert(!/確認済み|確認できました/.test(t.label+t.short),s);
  }
  assert.match(sourceCheck(Object.keys(LEDGER).find(id=>LEDGER[id][0]==='N')).label,/見つけられて(い)?ません/);
  assert.match(sourceCheck(Object.keys(LEDGER).find(id=>LEDGER[id][0]==='C')).label,/猫/);
});

test('Moizze PET001 row 550 is a dog experience found on page 10 of the Rakuten list',()=>{
  const c=sourceCheck(550);
  assert.equal(c.status,'V');
  assert.equal(c.url,'https://review.rakuten.co.jp/item/1/416008_10000986/10.1/');
});

test('totals add up and are shown on the pages that explain the data',()=>{
  const t=ledgerTotals();
  assert.equal(t.V+t.P+t.N+t.U+t.C,t.all);
  assert.equal(t.all,Object.keys(LEDGER).length);
  assert.equal(t.date,LEDGER_DATE);
  const html=renderSourceBreakdownHtml({external:t.all,article:100,total:t.all+100,byKind:[['x',1]]});
  for(const n of [t.V,t.P,t.N,t.U,t.C])assert(html.includes(`${n}件`),`totals must be visible: ${n}`);
  assert(html.includes('ラベルのない体験は確認を実施していません'));
  assert(html.includes('作り話だと判明したという意味ではありません'));
});

test('overview never quotes a row whose matching post was written by a cat owner',()=>{
  const catIds=Object.keys(LEDGER).filter(id=>LEDGER[id][0]==='C').map(Number);
  assert(catIds.length>0);
  const rows=[
    ...Array.from({length:7},(_,i)=>({id:100000+i,product_id:'p',dog_breed:null,dog_size:null,coat_type:null,needs:null,summary:`通常の体験${i}についての二十文字を超える要約テキストです。`,source_type:'public_buyer_review_summary',source_url:'https://example.com/x'})),
    ...catIds.slice(0,3).map(id=>({id,product_id:'p',dog_breed:'チワワ',dog_size:'small',coat_type:null,needs:null,summary:`猫由来の疑い${id}についての二十文字を超える要約テキストです。`,source_type:'public_buyer_review_summary',source_url:'https://example.com/x'})),
  ];
  const [p]=buildProfiles([{id:'p',name:'P'}],rows);
  for(const line of [...p.examples,...p.reservations])assert(!line.includes('猫由来の疑い'),line);
  assert.equal(p.checks.C,3);
});
