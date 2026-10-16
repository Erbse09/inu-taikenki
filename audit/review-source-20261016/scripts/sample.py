import json,random,collections,re,sys
live=sys.argv[1];out=sys.argv[2]
R=json.load(open(live+'/reviews.json'))
ext=[r for r in R if r['source_type']!='existing_article_summary']
def stratum(u):
    if 'review.rakuten.co.jp' in u: return 'rakuten-review-list'
    if 'rakuten.co.jp' in u: return 'rakuten-item/product'
    if 'shopping.yahoo.co.jp/review' in u: return 'yahoo-review-list'
    if 'yahoo.co.jp' in u: return 'yahoo-item/store'
    if 'chewy.com' in u or 'lowes.com' in u: return 'overseas-retail'
    return 'other'
by=collections.defaultdict(list)
for r in ext: by[stratum(r['source_url'])].append(r)
N=len(ext);print('external rows',N,{k:len(v) for k,v in by.items()})
random.seed(20261016)
total=150;sample=[]
for k,v in by.items():
    n=max(8,round(total*len(v)/N));n=min(n,len(v))
    for r in random.sample(v,n):
        sample.append({**r,'stratum':k,'stratum_size':len(v)})
print('sample size',len(sample),collections.Counter(s['stratum'] for s in sample))
json.dump(sample,open(out,'w'),ensure_ascii=False)
