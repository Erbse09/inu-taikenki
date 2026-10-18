import json,subprocess,hashlib,sys,concurrent.futures as cf,os
S=sys.argv[1]
sample=json.load(open(S+'/sample.json'))
urls=sorted({s['source_url'] for s in sample})
def get(u):
    h=hashlib.sha1(u.encode()).hexdigest()[:16]
    p=f'{S}/fetched/{h}.html'
    r=subprocess.run(['curl','-sS','-L','-m','25','--max-filesize','4000000','-A','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36','-H','Accept-Language: ja','-o',p,'-w','%{http_code} %{size_download} %{url_effective}',u],capture_output=True,text=True)
    return u,{'file':p,'meta':r.stdout.strip(),'err':r.stderr.strip()[:120]}
with cf.ThreadPoolExecutor(4) as ex:
    res=dict(ex.map(get,urls))
json.dump(res,open(S+'/fetch_results.json','w'),ensure_ascii=False)
import collections
print(len(urls),collections.Counter(v['meta'].split()[0] if v['meta'] else 'ERR' for v in res.values()))
