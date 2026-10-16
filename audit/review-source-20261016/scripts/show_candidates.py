import json,re,sys,html as H,random
S=sys.argv[1];start=int(sys.argv[2]);n=int(sys.argv[3])
A=json.load(open(S+'/analysis.json'));res=json.load(open(S+'/fetch_results.json'))
rows=[a for a in A if a['http']=='200' and a['textlen']>=1500]
random.seed(7);random.shuffle(rows)
STOP={'体験','使用','感じ','犬用','自宅','今回','以前','日常','最初','購入','使い','評価','継続','商品','製品','場合','状態','様子','以上','気持','気に入'}
def text(p):
    h=open(p,encoding='utf-8',errors='ignore').read()
    h=re.sub(r'<(script|style|noscript)[\s\S]*?</\1>','',h);t=re.sub(r'<[^>]+>',' ',h);t=H.unescape(t);return re.sub(r'\s+',' ',t)
for k,a in enumerate(rows[start:start+n],start):
    t=text(res[a['url']]['file'])
    toks=set(re.findall(r'\d+(?:\.\d+)?[a-zA-Zぁ-んァ-ヶ一-龥]{0,2}',a['summary']))|set(re.findall(r'[ァ-ヶー]{3,}',a['summary']))|{w for w in re.findall(r'[一-龥]{2,}',a['summary']) if w not in STOP}
    toks={w for w in toks if len(w)>=2 or w.isdigit()}
    best=[]
    for i in range(0,max(1,len(t)-300),25):
        w=t[i:i+260];sc=sum(1 for x in toks if x in w)
        best.append((sc,i))
    best.sort(reverse=True);picked=[]
    for sc,i in best:
        if all(abs(i-j)>400 for _,j in picked):picked.append((sc,i))
        if len(picked)==1:break
    print(f"[{k}] #{a['id']} {a['stratum']} | {a['product'][:20]} | {a['breed']} | toks={len(toks)}\n  SUM: {a['summary']}")
    for sc,i in picked:print(f"  W({sc}): {t[i:i+260]}")
    print()
