# 2026-10-18 の出典監査で使った作業用スクリプト(Claude)。ネットワーク取得したページを前提にした調査用で、CIでは実行しない。
# 入出力のパス(/tmp/claude-0/...)は作業環境のもの。原文のページ本文はリポジトリに保存していない。
import re,json,math,collections
P=json.load(open('posts.json'))
s=open('/home/user/inu-taikenki/migrations/0042_dog_harness.sql').read()
pat=re.compile(r"^\('([^']+)',(NULL|'[^']*'),(NULL|'[^']*'),(NULL|'[^']*'),(NULL|'[^']*'),'((?:[^']|'')*)','([^']+)','([^']+)'\)",re.M)
rows=[]
for m in pat.finditer(s):
    g=lambda x:None if x=='NULL' else x.strip("'")
    rows.append(dict(i=len(rows)+1,product=m[1],breed=g(m[2]),size=g(m[3]),coat=g(m[4]),needs=g(m[5]),summary=m[6].replace("''","'"),stype=m[7],url=m[8]))
def item(u):
    m=re.search(r'item/1/([\d_]+)/',u);return m[1] if m else u
def norm(t):
    t=t.replace('キロ','kg').replace('ｋｇ','kg').replace('Kg','kg').replace('KG','kg').replace('センチ','cm').replace('ヶ月','か月').replace('カ月','か月').replace('ケ月','か月')
    t=t.translate(str.maketrans('０１２３４５６７８９．','0123456789.'))
    return t
def grams(t):
    t=norm(t);g=set()
    for m in re.finditer(r'\d+(?:\.\d+)?\s*(?:kg|cm|歳|か月|g|ｍ|m|回|日|年|週間)',t):g.add('N:'+m[0].replace(' ',''))
    for run in re.findall(r'[一-龥ァ-ヴーぁ-んA-Za-z]+',t):
        for k in range(len(run)-2):g.add(run[k:k+3])
    return g
ORIG={r['url'] for r in rows}
EXT={217,225,292,371,405}
allposts=[]
for u,v in P.items():
    for p in v['posts']:
        allposts.append(dict(url=u,item=item(u),orig=(u in ORIG),**p,g=grams(p['text'])))
df=collections.Counter()
for p in allposts:
    for x in p['g']:df[x]+=1
N=len(allposts)
idf=lambda x:math.log((N+1)/(df[x]+1))+0.5
byitem=collections.defaultdict(list)
for p in allposts:byitem[p['item']].append(p)
out=[]
for r in rows:
    sg=grams(r['summary']);tot=sum(idf(x) for x in sg) or 1
    cands=[]
    pool=byitem.get(item(r['url']),[]) if 'rakuten' in r['url'] else [q for q in allposts if q['url']==r['url']]
    if r['i'] not in EXT:pool=[q for q in pool if q['orig']]
    for p in pool:
        sc=sum(idf(x) for x in sg&p['g'])/tot
        cands.append((sc,p))
    cands.sort(key=lambda x:-x[0])
    b=cands[0] if cands else (0,None);s2=cands[1][0] if len(cands)>1 else 0
    r['score']=round(b[0],3);r['score2']=round(s2,3)
    if b[1]:
        p=b[1];r['post']=dict(url=p['url'],date=p['date'],nick=p['nick'],rating=p['rating'],text=p['text'][:420],id=p.get('id'))
    out.append(r)
json.dump(out,open('rows.json','w'),ensure_ascii=False)
import statistics
sc=[r['score'] for r in out]
print(len(out),statistics.median(sc));
for t in(0.2,0.3,0.4,0.5):print(t,sum(1 for x in sc if x>=t))
print(sum(1 for r in out if 'post' not in r))
