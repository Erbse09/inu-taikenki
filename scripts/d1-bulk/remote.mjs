// GitHub Actions 専用。サブコマンド:
//   guard                          接続先が固定のD1(inu-taikenki)か確認（読み取りのみ）
//   gate <entry-id> <mode>         実行可否の判定（ブランチ・承認フラグ・SQL検査）
//   snapshot <entry-id> <out.json> 実行前/後の件数と既存行の指紋（読み取りのみ）
//   compare <entry-id> <pre> <post> mode  実行前後の照合
// 認証情報は環境変数(CLOUDFLARE_API_TOKEN等)から wrangler が読む。このスクリプトは値を表示しない。
import {execFileSync} from 'node:child_process';
import {readFileSync, writeFileSync} from 'node:fs';
import {loadManifest, getEntry, sha256, lintAdditiveSql, productIds} from './lib.mjs';

const manifest = loadManifest();
const {database_name: DB, database_id: DB_ID} = manifest.target;
const wrangler = (args) => execFileSync('npx', ['wrangler', ...args], {encoding: 'utf8', stdio: ['ignore', 'pipe', 'pipe'], maxBuffer: 64 * 1024 * 1024});
const query = (sql) => JSON.parse(wrangler(['d1', 'execute', DB, '--remote', '--json', '--command', sql]))[0].results;
const fail = (m) => { console.error('停止: ' + m); process.exit(1); };
const [cmd, ...a] = process.argv.slice(2);

if (cmd === 'guard') {
  const cfg = JSON.parse(readFileSync('wrangler.jsonc', 'utf8').replace(/^\s*\/\/.*$/gm, ''));
  const bindings = cfg.d1_databases || [];
  if (bindings.length !== 1 || bindings[0].database_name !== DB || bindings[0].database_id !== DB_ID) fail('wrangler.jsonc のD1設定が固定値と一致しません');
  const list = JSON.parse(wrangler(['d1', 'list', '--json']));
  const hit = list.find(d => d.uuid === DB_ID);
  if (!hit || hit.name !== DB) fail('このCloudflareアカウントに、固定のD1(名前+ID)が見つかりません。別アカウントの認証情報の可能性があります');
  console.log(`接続先OK: ${DB} (ID末尾 ${DB_ID.slice(-6)})`);
} else if (cmd === 'gate') {
  const [id, mode] = a;
  const entry = getEntry(manifest, id);
  if (!['dry-run', 'apply'].includes(mode)) fail('mode は dry-run か apply');
  const sql = readFileSync(entry.file, 'utf8');
  if (sha256(sql) !== entry.sha256) fail('SQLの内容がmanifestのsha256と一致しません（PRで変更された場合はmanifestも更新して再レビュー）');
  const problems = lintAdditiveSql(sql, entry.allowed_tables);
  if (problems.length) fail('SQL検査に失敗: ' + problems.slice(0, 5).join(' / '));
  if (mode === 'apply') {
    if (!/^refs\/heads\/(develop|main)$/.test(process.env.GITHUB_REF || '')) fail('apply は develop か main から実行してください');
    if (entry.approved_for_apply !== true) fail('このデータは運営者の承認前です（manifestの approved_for_apply が false）: ' + (entry.not_approved_reason || ''));
    if (process.env.CONFIRM_TEXT !== 'ADD inu-taikenki') fail('確認文字が一致しません');
  }
  console.log(`gate OK (${mode})`);
} else if (cmd === 'snapshot') {
  const [id, out] = a;
  const entry = getEntry(manifest, id);
  const cat = entry.category;
  if (!/^[a-z-]+$/.test(cat)) fail('category 不正');
  const sql = readFileSync(entry.file, 'utf8');
  const ids = productIds(sql).map(x => `'${x}'`).join(',');
  const other = `product_id NOT IN (SELECT id FROM products WHERE category='${cat}')`;
  const [r] = query(`SELECT
    (SELECT COUNT(*) FROM products) AS products,
    (SELECT COUNT(*) FROM reviews) AS reviews,
    (SELECT COUNT(*) FROM products WHERE category='${cat}') AS cat_products,
    (SELECT COUNT(*) FROM reviews WHERE NOT (${other})) AS cat_reviews,
    (SELECT COUNT(*) FROM products WHERE id IN (${ids}) AND category<>'${cat}') AS id_conflicts,
    (SELECT COUNT(*) FROM reviews WHERE ${other}) AS other_reviews,
    (SELECT COALESCE(SUM(id),0) FROM reviews WHERE ${other}) AS other_id_sum,
    (SELECT COALESCE(SUM(LENGTH(summary)+LENGTH(COALESCE(source_url,''))),0) FROM reviews WHERE ${other}) AS other_text_sum,
    (SELECT COUNT(*) FROM products WHERE category<>'${cat}') AS other_products`);
  writeFileSync(out, JSON.stringify(r, null, 2));
  console.log(JSON.stringify(r));
} else if (cmd === 'compare') {
  const [id, preF, postF, mode] = a;
  const entry = getEntry(manifest, id);
  const pre = JSON.parse(readFileSync(preF, 'utf8'));
  const post = JSON.parse(readFileSync(postF, 'utf8'));
  const errs = [];
  if (mode === 'dry-run') {
    if (pre.id_conflicts) errs.push(`同じIDで別カテゴリの商品が${pre.id_conflicts}件あります（INSERT OR IGNOREで無視される）`);
    if (pre.cat_reviews > entry.expected_reviews || pre.cat_products > entry.expected_products) errs.push('対象カテゴリに想定以上の行が既にあります');
    console.log(`実行すると: 商品 +${entry.expected_products - pre.cat_products}件 / 口コミ +${entry.expected_reviews - pre.cat_reviews}件 の見込み`);
  } else {
    if (post.cat_products !== entry.expected_products) errs.push(`対象商品 ${post.cat_products} ≠ ${entry.expected_products}`);
    if (post.cat_reviews !== entry.expected_reviews) errs.push(`対象口コミ ${post.cat_reviews} ≠ ${entry.expected_reviews}`);
    if (post.reviews - pre.reviews !== entry.expected_reviews - pre.cat_reviews) errs.push('口コミの全体増加数が想定と違います');
    for (const k of ['other_reviews', 'other_id_sum', 'other_text_sum', 'other_products']) if (post[k] !== pre[k]) errs.push(`既存データが変化: ${k} ${pre[k]} → ${post[k]}`);
  }
  if (pre.id_conflicts && mode === 'apply') errs.push('事前にID衝突あり');
  if (errs.length) fail(errs.join('\n'));
  console.log(`照合OK (${mode})`);
} else fail('不明なコマンド');
