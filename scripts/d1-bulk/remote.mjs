// GitHub Actions 専用。サブコマンド:
//   guard                          接続先が固定のD1(inu-taikenki)か確認（読み取りのみ）
//   gate <entry-id> <mode>         実行可否の判定（ブランチ・承認フラグ・SQL検査）
//   snapshot <entry-id> <out.json> 実行前/後の件数と全行の内容ハッシュ（読み取りのみ・本文は出力しない）
//   compare <entry-id> <pre> <post> mode  実行前後の照合
//   summary <entry-id> <mode> <pre> [post] iPhoneで読める結果の要約をジョブ画面に出す
// 認証情報は環境変数(CLOUDFLARE_API_TOKEN等)から wrangler が読む。このスクリプトは値を表示しない。
import {execFileSync} from 'node:child_process';
import {readFileSync, writeFileSync} from 'node:fs';
import {loadManifest, getEntry, sha256, lintAdditiveSql, checkSchema, renderSummary} from './lib.mjs';
import {takeSnapshot, digestUpTo, compareDryRun, compareApply} from './snapshot.mjs';

const manifest = loadManifest();
const {database_name: DB, database_id: DB_ID} = manifest.target;
const wrangler = (args) => execFileSync('npx', ['wrangler', ...args], {encoding: 'utf8', stdio: ['ignore', 'pipe', 'pipe'], maxBuffer: 64 * 1024 * 1024});
// D1_REHEARSAL_LOCAL=1 は手元のリハーサル専用（ローカルD1を使う）。ワークフローでは設定しない（テストで禁止）。
const LOCAL = process.env.D1_REHEARSAL_LOCAL === '1';
const target = LOCAL ? ['--local', ...(process.env.D1_PERSIST_TO ? ['--persist-to', process.env.D1_PERSIST_TO] : [])] : ['--remote'];
const runSql = (sql) => JSON.parse(wrangler(["d1", "execute", DB, ...target, "--json", "--command", sql]));
const query = (sql) => runSql(sql)[0].results;
// 複数のSELECTを1回のwrangler起動でまとめて実行する（起動が遅いので回数を減らす）。結果は文ごとの行配列。
query.batch = (sqls) => {
  const out = [];
  for (let i = 0; i < sqls.length; i += 40) {
    const part = runSql(sqls.slice(i, i + 40).join(';\n'));
    if (part.length !== Math.min(40, sqls.length - i)) throw new Error('まとめ問い合わせの結果の数が合いません');
    out.push(...part.map(r => r.results));
  }
  return out;
};
const fail = (m) => { console.error('停止: ' + m); process.exit(1); };
const [cmd, ...a] = process.argv.slice(2);

if (cmd === 'guard') {
  const cfg = JSON.parse(readFileSync('wrangler.jsonc', 'utf8').replace(/^\s*\/\/.*$/gm, ''));
  const bindings = cfg.d1_databases || [];
  if (bindings.length !== 1 || bindings[0].database_name !== DB || bindings[0].database_id !== DB_ID) fail('wrangler.jsonc のD1設定が固定値と一致しません');
  if (LOCAL) console.log('接続先: ローカルD1（リハーサル。Cloudflareには接続しません）');
  else {
    const list = JSON.parse(wrangler(['d1', 'list', '--json']));
    const hit = list.find(d => d.uuid === DB_ID);
    if (!hit || hit.name !== DB) fail('このCloudflareアカウントに、固定のD1(名前+ID)が見つかりません。別アカウントの認証情報の可能性があります');
    console.log(`接続先OK: ${DB} (ID末尾 ${DB_ID.slice(-6)})`);
  }
  const schema = checkSchema(query("SELECT name, sql FROM sqlite_master WHERE type='table' AND name IN ('products','reviews','review_sources','review_attributes')"));
  if (schema.length) fail('本番D1の表の構造が想定と違います: ' + schema.join(' / '));
  console.log('表の構造OK: products / reviews / review_sources / review_attributes');
} else if (cmd === 'gate') {
  const [id, mode] = a;
  const entry = getEntry(manifest, id);
  if (!['dry-run', 'apply'].includes(mode)) fail('mode は dry-run か apply');
  const sql = readFileSync(entry.file, 'utf8');
  if (sha256(sql) !== entry.sha256) fail('SQLの内容がmanifestのsha256と一致しません（PRで変更された場合はmanifestも更新して再レビュー）');
  const problems = lintAdditiveSql(sql, entry.allowed_tables);
  if (problems.length) fail('SQL検査に失敗: ' + problems.slice(0, 5).join(' / '));
  if (mode === 'apply') {
    if (process.env.GITHUB_REF !== 'refs/heads/main') fail('apply は main ブランチからだけ実行できます（Run workflow の Use workflow from を main にしてください）');
    if (entry.approved_for_apply !== true) fail('このデータは運営者の承認前です（manifestの approved_for_apply が false）: ' + (entry.not_approved_reason || ''));
    if (process.env.CONFIRM_TEXT !== 'ADD inu-taikenki') fail('確認文字が一致しません');
  }
  console.log(`gate OK (${mode})`);
} else if (cmd === 'snapshot') {
  const [id, out] = a;
  const entry = getEntry(manifest, id);
  const snap = await takeSnapshot(query, entry, readFileSync(entry.file, 'utf8'));
  writeFileSync(out, JSON.stringify(snap, null, 2));
  console.log(JSON.stringify({tables: Object.fromEntries(Object.entries(snap.tables).map(([t, v]) => [t, v.count])), cat_products: snap.cat_products, cat_reviews: snap.cat_reviews, id_conflicts: snap.id_conflicts}));
} else if (cmd === 'compare') {
  const [id, preF, postF, mode] = a;
  const entry = getEntry(manifest, id);
  const pre = JSON.parse(readFileSync(preF, 'utf8'));
  let errs;
  if (mode === 'dry-run') {
    errs = compareDryRun(entry, pre);
    console.log(`実行すると: 商品 +${entry.expected_products - pre.cat_products}件 / 口コミ +${entry.expected_reviews - pre.cat_reviews}件 の見込み`);
  } else {
    const post = JSON.parse(readFileSync(postF, 'utf8'));
    errs = compareApply(entry, pre, post, await digestUpTo(query, pre));
  }
  if (errs.length) fail(errs.join('\n'));
  console.log(`照合OK (${mode})`);
} else if (cmd === 'summary') {
  const [id, mode, preF, postF] = a;
  const entry = getEntry(manifest, id);
  const pre = JSON.parse(readFileSync(preF, 'utf8'));
  const post = postF && mode === 'apply' ? JSON.parse(readFileSync(postF, 'utf8')) : null;
  const text = renderSummary({entryId: id, entry, mode, pre, post});
  console.log(text);
  if (process.env.GITHUB_STEP_SUMMARY) writeFileSync(process.env.GITHUB_STEP_SUMMARY, text + '\n', {flag: 'a'});
} else fail('不明なコマンド');
