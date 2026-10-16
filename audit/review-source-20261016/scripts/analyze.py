import json,re,sys,collections,html as H
S=sys.argv[1]
sample=json.load(open(S+'/sample.json'));res=json.load(open(S+'/fetch_results.json'))
def text(p):
    try:h=open(p,encoding='utf-8',errors='ignore').read()
    except: return ''
    h=re.sub(r'<(script|style|noscript)[\s\S]*?</\1>','',h)
    t=re.sub(r'<[^>]+>',' ',h);t=H.unescape(t);return re.sub(r'\s+',' ',t)
def ngr(s,n=3):
    s=re.sub(r'\s+','',s);return {s[i:i+n] for i in range(len(s)-n+1)}
out=[]
for s in sample:
    r=res[s['source_url']];code=r['meta'].split()[0] if r['meta'] else '000'
    t=text(r['file']) if code=='200' else ''
    # distinctive tokens from summary: digits+units, katakana words>=3, kanji words>=2 excluding generic
    toks=set(re.findall(r'\d+(?:\.\d+)?(?:kg|g|ml|mm|分|秒|歳|頭|回|日|時間|か月|ヶ月|万|円)?',s['summary']))
    toks|=set(re.findall(r'[ァ-ヶー]{3,}',s['summary']))
    toks|={w for w in re.findall(r'[一-龥]{2,}',s['summary']) if w not in {'体験','使用','感じ','犬用','自宅','今回','以前','日常','最初','購入'}}
    hits=[w for w in toks if w in t]
    # best window overlap of 3-grams
    sg=ngr(s['summary'])
    best=0
    if t and sg:
        step=60
        for i in range(0,max(1,len(t)-200),step):
            w=ngr(t[i:i+260]);best=max(best,len(sg&w)/len(sg))
    out.append({'id':s['id'],'stratum':s['stratum'],'url':s['source_url'],'http':code,'textlen':len(t),'tok':len(toks),'hit':len(hits),'best3gram':round(best,2),'summary':s['summary'],'breed':s['dog_breed'],'product':s['product_name']})
json.dump(out,open(S+'/analysis.json','w'),ensure_ascii=False)
c=collections.Counter()
for o in out:
    if o['http']!='200': c[(o['stratum'],'unreachable')]+=1
    elif o['textlen']<1500: c[(o['stratum'],'200-but-empty/JS')]+=1
    else: c[(o['stratum'],'200-text')]+=1
for k,v in sorted(c.items()):print(k,v)
