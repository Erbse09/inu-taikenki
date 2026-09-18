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
