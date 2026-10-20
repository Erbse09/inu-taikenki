# 2026-10-18 の出典監査で使った作業用スクリプト(Claude)。ネットワーク取得したページを前提にした調査用で、CIでは実行しない。
# 入出力のパス(/tmp/claude-0/...)は作業環境のもの。原文のページ本文はリポジトリに保存していない。
import re,json,hashlib,html,glob,sys
from datetime import datetime,timezone,timedelta
JST=timezone(timedelta(hours=9))
urls=open('/tmp/claude-0/urls.txt').read().split('\n')
posts={}
def fn(u):return '/tmp/claude-0/pages/'+hashlib.sha1(u.encode()).hexdigest()[:12]+'.html'
def parse_rakuten(h):
    out=[]
    i=h.find('レビュー一覧'); 
    for li in re.findall(r'<li>(.*?)</li>(?=<li>|</ul>)',h[i:],re.S):
        if 'star-rating' not in li: continue
        t=re.sub(r'<script.*?</script>|<style.*?</style>','',li,flags=re.S)
        t=re.sub(r'<br\s*/?>','\n',t)
        t=re.sub(r'<[^>]+>','\n',t); t=html.unescape(t)
        L=[x.strip() for x in t.split('\n') if x.strip()]
        if not L or not L[0].isdigit(): continue
        rating=int(L[0]); 
        di=next((k for k,x in enumerate(L) if re.fullmatch(r'\d{4}/\d\d/\d\d',x)),None)
        if di is None: continue
        date=L[di]; nick=L[di+1] if di+1<len(L) else ''
        rest=L[di+2:]
        # drop demographic/variant/footer lines but keep for context
        stop=next((k for k,x in enumerate(rest) if x in('さらに表示',) or x.startswith('注文日')),len(rest))
        body='\n'.join(rest[:stop])
        out.append(dict(rating=rating,date=date,nick=nick,text=body))
    return out
def parse_yahoo(h):
    m=re.search(r'<script id="__NEXT_DATA__"[^>]*>(.*?)</script>',h,re.S)
    d=json.loads(m.group(1));pp=d['props']['pageProps']
    out=[];seen=set()
    srcs=[]
    for key in('pickUpItemReviewEntity','reviewEntity'):
        e=pp.get(key) or {}
        srcs.append((e.get('itemReview') or e.get('catalogReview') or {}))
        if e.get('catalogReview'):srcs.append(e['catalogReview'])
    for ir in srcs:
        for r in (ir.get('reviews') or []):
            if r['id'] in seen:continue
            seen.add(r['id'])
            opts=' '.join(f"{o['name']}:{o['value']}" for o in r.get('subCodeOptions',[]))
            out.append(dict(id=r['id'],rating=r['rating'],date=datetime.fromtimestamp(r['postedTime']/1000,JST).strftime('%Y/%m/%d'),nick=r.get('maskYid',''),text=(r.get('title','')+'\n'+r.get('body','')),variant=opts))
    return out
summary={}
for u in urls:
    try:h=open(fn(u),encoding='utf-8',errors='replace').read()
    except:summary[u]='nofile';continue
    try:
        title=re.search(r'<title>(.*?)</title>',h,re.S).group(1)
        if 'review.rakuten' in u:p=parse_rakuten(h)
        elif 'shopping.yahoo' in u:p=parse_yahoo(h)
        else:p=[]
    except Exception as e:
        summary[u]='err '+str(e)[:50];continue
    posts[u]=dict(title=html.unescape(title)[:150],posts=p)
    summary[u]=len(p)
json.dump(posts,open('posts.json','w'),ensure_ascii=False)
import collections
print(collections.Counter(type(v).__name__+(':'+v[:10] if isinstance(v,str) else '') for v in summary.values()))
print({u[-40:]:v for u,v in list(summary.items())[:8]})
print(sum(v for v in summary.values() if isinstance(v,int)))
