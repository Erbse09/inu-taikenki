// Read-only, bounded API. Migration 0018 must precede Worker deployment.
interface Statement {
  bind(...values: (string | number | null)[]): Statement;
  all<T>(): Promise<{ results?: T[] }>;
  first<T>(): Promise<T | null>;
}
interface DB { prepare(sql: string): Statement; }
type Value = string | number | null;
type Row = Record<string, any>;
const aliases: Record<string,string> = {怖がり:'scared',子犬:'puppy',シニア:'senior',時短:'speed',抜け毛:'shedding',毛玉:'mat',もつれ:'tangle',多頭:'multi',静音:'quiet',皮膚:'skin',カメラ:'camera',旅行:'travel',いたずら:'mischief',ハンズフリー:'handsfree'};
const traitGroups: Record<string,string[]> = {multi:['multi','multi-dog'],'multi-dog':['multi','multi-dog'],skin:['skin','skin-sensitive'],'skin-sensitive':['skin','skin-sensitive']};
const json = (data: unknown, status=200) => new Response(JSON.stringify(data), {status, headers:{'content-type':'application/json; charset=utf-8','cache-control':'no-store'}});
class InputError extends Error {}
function integer(p: URLSearchParams, key: string, fallback: number, max: number, min=0) {
  const raw=p.get(key); if(raw===null) return fallback;
  if(!/^\d+$/.test(raw)) throw new InputError(`invalid_${key}`);
  const n=Number(raw); if(!Number.isSafeInteger(n)||n<min||n>max) throw new InputError(`invalid_${key}`);
  return n;
}
function filters(p: URLSearchParams) {
  const clauses=['p.active = 1']; const values: Value[]=[];
  const add=(sql:string,value:Value)=>{clauses.push(sql);values.push(value);};
  for(const [key,column] of [['category','p.category'],['product','p.id']]) {
    const value=p.get(key); if(!value)continue;
    if(!/^[a-z0-9][a-z0-9._-]{0,63}$/i.test(value)) throw new InputError(`invalid_${key}`);
    add(`${column} = ?`,value);
  }
  for(const [key,alias,kind] of [['size','dog_size','size'],['coat','coat_type','coat'],['trait','needs','trait']]) {
    const value=p.get(key)||p.get(alias); if(!value)continue;
    if(kind==='trait' ? !/^[^\s\u0000-\u001f]{1,64}$/.test(value) : !/^[a-z0-9][a-z0-9_-]{0,63}$/i.test(value))throw new InputError(`invalid_${key}`);
    const normalized=value.toLowerCase();
    if(kind==='trait' && traitGroups[normalized]){
      const group=traitGroups[normalized];
      clauses.push(`EXISTS (SELECT 1 FROM review_attributes a WHERE a.review_id = r.id AND a.kind = 'trait' AND a.value IN (${group.map(()=>'?').join(',')}))`);
      values.push(...group);
    } else add(`EXISTS (SELECT 1 FROM review_attributes a WHERE a.review_id = r.id AND a.kind = '${kind}' AND a.value = ?)`,normalized);
  }
  const breed=p.get('breed');
  if(breed) {
    if(breed.length>100)throw new InputError('invalid_breed');
    // Legacy breed values include explicit ages/weights/multiple dogs; keep them.
    if(p.get('breed_mode')==='exact')add('r.dog_breed = ?',breed);
    else add('instr(lower(coalesce(r.dog_breed,\'\')), ?) > 0',breed.toLowerCase());
  }
  if(p.has('breed_mode')&&!['exact','contains'].includes(p.get('breed_mode')!))throw new InputError('invalid_breed_mode');
  const q=p.get('q')?.trim().toLowerCase();
  if(q){
    if(q.length>200)throw new InputError('invalid_q');
    const hay="lower(coalesce(p.name,'')||' '||coalesce(r.dog_breed,'')||' '||coalesce(r.dog_size,'')||' '||coalesce(r.coat_type,'')||' '||coalesce(r.needs,'')||' '||r.summary)";
    clauses.push(`(instr(${hay}, ?) > 0 OR instr(${hay}, ?) > 0)`);values.push(q,aliases[q]||q);
  }
  return {where:clauses.join(' AND '),values};
}
const from='FROM reviews r JOIN products p ON p.id=r.product_id';
const fields='r.id,r.product_id,p.name AS product_name,p.category,r.dog_breed,r.dog_size,r.coat_type,r.needs,r.summary,r.source_type,r.source_url';
async function rows(db:DB,sql:string,values:Value[]=[]) {return (await db.prepare(sql).bind(...values).all<Row>()).results||[];}
async function totals(db:DB,where:string,values:Value[]) {
  return await db.prepare(`SELECT COUNT(*) AS count,COUNT(DISTINCT p.id) AS product_count,COUNT(DISTINCT p.category) AS category_count ${from} WHERE ${where}`).bind(...values).first<Row>() || {count:0,product_count:0,category_count:0};
}
export async function reviewApi(request: Request, db: DB): Promise<Response | null> {
  const url=new URL(request.url), path=url.pathname;
  const productMatch=path.match(/^\/api\/products\/([^/]+)\/reviews\/?$/);
  if(!['/api/reviews','/api/reviews/stats','/api/reviews/groups','/api/products'].includes(path)&&!productMatch)return null;
  if(request.method!=='GET')return json({error:'method_not_allowed'},405);
  try {
    const params=new URLSearchParams(url.search);
    let product:Row|null=null;
    if(productMatch){
      let id;try{id=decodeURIComponent(productMatch[1]);}catch{throw new InputError('invalid_product');}
      if(params.get('product')&&params.get('product')!==id)throw new InputError('conflicting_product');
      params.set('product',id);
      filters(params);
      product=await db.prepare('SELECT id,name,category,asin,affiliate_url FROM products WHERE id=? AND active=1').bind(id).first<Row>();
      if(!product)return json({error:'product_not_found'},404);
    }
    const {where,values}=filters(params);
    const limit=integer(params,'limit',path==='/api/products'?100:20,path==='/api/reviews/groups'?20:100,1);
    const offset=integer(params,'offset',0,1000000);
    const cursor=integer(params,'cursor',0,Number.MAX_SAFE_INTEGER);
    if(cursor&&offset)throw new InputError('cursor_and_offset');
    if(path==='/api/products'){
      const cat=params.get('category');
      const pred=cat?'p.active=1 AND p.category=?':'p.active=1', bindings=cat?[cat]:[];
      const counts=await db.prepare(`SELECT COUNT(*) AS total FROM products p WHERE ${pred}`).bind(...bindings).first<Row>();
      const products=await rows(db,`SELECT p.id,p.name,p.category,p.asin,p.affiliate_url,(SELECT COUNT(*) FROM reviews r WHERE r.product_id=p.id) AS review_count FROM products p WHERE ${pred} ORDER BY p.category,review_count DESC,p.name,p.id LIMIT ? OFFSET ?`,[...bindings,limit,offset]);
      return json({category:cat,products,total:counts!.total,limit,offset,has_more:offset+products.length<counts!.total,next_offset:offset+products.length<counts!.total?offset+products.length:null});
    }
    const total=await totals(db,where,values);
    if(path==='/api/reviews/stats'){
      const canonicalTrait=`CASE WHEN a.kind='trait' AND a.value IN ('multi','multi-dog') THEN 'multi' WHEN a.kind='trait' AND a.value IN ('skin','skin-sensitive') THEN 'skin' ELSE a.value END`;
      const facets=await rows(db,`SELECT a.kind,${canonicalTrait} AS value,COUNT(DISTINCT a.review_id) AS count FROM review_attributes a JOIN reviews r ON r.id=a.review_id JOIN products p ON p.id=r.product_id WHERE ${where} GROUP BY a.kind,${canonicalTrait} ORDER BY a.kind,count DESC,value LIMIT 100`,values);
      const coverage=await db.prepare(`SELECT SUM(CASE WHEN nullif(trim(r.dog_breed),'') IS NOT NULL AND instr(r.dog_breed,'犬種不明')=0 THEN 1 ELSE 0 END) AS breed,SUM(CASE WHEN nullif(trim(r.dog_size),'') IS NOT NULL THEN 1 ELSE 0 END) AS size,SUM(CASE WHEN nullif(trim(r.coat_type),'') IS NOT NULL THEN 1 ELSE 0 END) AS coat ${from} WHERE ${where}`).bind(...values).first<Row>();
      const top=await rows(db,`SELECT p.id AS product_id,p.name AS product_name,COUNT(*) AS count ${from} WHERE ${where} GROUP BY p.id ORDER BY count DESC,p.id LIMIT 8`,values);
      const categories=await rows(db,`SELECT p.category,COUNT(*) AS count ${from} WHERE ${where} GROUP BY p.category ORDER BY p.category LIMIT 100`,values);
      return json({...total,facets,coverage,products:top,categories});
    }
    if(path==='/api/reviews/groups'){
      const groups=await rows(db,`SELECT p.id AS product_id,p.name AS product_name,p.category,p.affiliate_url,COUNT(*) AS count ${from} WHERE ${where} GROUP BY p.id ORDER BY count DESC,p.id LIMIT ? OFFSET ?`,[...values,limit,offset]);
      // Two indexed samples per displayed product; never materialize its full reviews.
      for(const group of groups)group.reviews=await rows(db,`SELECT ${fields} ${from} WHERE ${where} AND p.id=? ORDER BY r.id LIMIT 2`,[...values,group.product_id]);
      return json({...total,groups,limit,offset,has_more:offset+groups.length<total.product_count,next_offset:offset+groups.length<total.product_count?offset+groups.length:null});
    }
    const result=await rows(db,`SELECT ${fields} ${from} WHERE ${where} AND r.id > ? ORDER BY r.id LIMIT ? OFFSET ?`,[...values,cursor,limit+1,offset]);
    const has_more=result.length>limit, reviews=result.slice(0,limit);
    return json({category:params.get('category'),...(product?{product}:{}),...total,reviews,limit,offset,has_more,next_cursor:has_more?reviews.at(-1)!.id:null,next_offset:has_more&&!cursor?offset+reviews.length:null});
  } catch(error){
    if(error instanceof InputError)return json({error:error.message},400);
    console.error('review_api_failed',error instanceof Error?error.message:'unknown');
    return json({error:'reviews_unavailable'},503);
  }
}
