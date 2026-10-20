// 手元のリハーサル: 本物の wrangler と ローカルD1(使い捨て) で、gate → guard → snapshot → dry-run → apply → 事後照合 → 再実行 まで通す。
// Cloudflare には接続しない。使い方: node scripts/d1-bulk/rehearse-local.mjs <entry-id>
import {execFileSync} from 'node:child_process';
import {mkdtempSync, readdirSync, readFileSync, writeFileSync, rmSync} from 'node:fs';
import {tmpdir} from 'node:os';
import {join} from 'node:path';
import {loadManifest, getEntry} from './lib.mjs';

const id = process.argv[2];
const entry = getEntry(loadManifest(), id);
const dir = mkdtempSync(join(tmpdir(), 'd1-rehearsal-'));
const env = {...process.env, D1_REHEARSAL_LOCAL: '1', D1_PERSIST_TO: join(dir, 'state'), GITHUB_REF: 'refs/heads/main', CONFIRM_TEXT: 'ADD inu-taikenki'};
const run = (args, e = env) => execFileSync('npx', args, {env: e, encoding: 'utf8', stdio: ['ignore', 'pipe', 'pipe'], maxBuffer: 64 * 1024 * 1024});
const node = (...a) => { console.log('$ node scripts/d1-bulk/remote.mjs ' + a.join(' ')); const out = run(['node', 'scripts/d1-bulk/remote.mjs', ...a]); console.log(out.trim().split('\n').map(l => '  ' + l).join('\n')); };
try {
  // 使い捨てのローカルD1に、0042より前の全migration(+seed)を流して「今の本番に近い状態」を作る
  const parts = [readFileSync('migrations/0001_init.sql', 'utf8'), readFileSync('seed.sql', 'utf8')];
  for (const n of readdirSync('migrations').filter(n => /^\d{4}_.*\.sql$/.test(n)).sort()) if (!n.startsWith('0001_') && n !== entry.file.split('/').pop()) parts.push(readFileSync('migrations/' + n, 'utf8'));
  writeFileSync(join(dir, 'base.sql'), parts.join('\n'));
  run(['wrangler', 'd1', 'execute', 'inu-taikenki', '--local', '--persist-to', env.D1_PERSIST_TO, '--file', join(dir, 'base.sql')]);
  const apply = () => run(['wrangler', 'd1', 'execute', 'inu-taikenki', '--local', '--persist-to', env.D1_PERSIST_TO, '--yes', '--file', entry.file]);
  node('gate', id, 'dry-run');
  node('guard');
  node('snapshot', id, join(dir, 'pre.json'));
  node('compare', id, join(dir, 'pre.json'), join(dir, 'pre.json'), 'dry-run');
  node('summary', id, 'dry-run', join(dir, 'pre.json'));
  if (entry.approved_for_apply !== true) { console.log('approved_for_apply が false のため、applyのゲートで止まることを確認:'); try { node('gate', id, 'apply'); console.log('NG: 止まらなかった'); process.exitCode = 1; } catch (e) { console.log('  OK: 停止した（承認前）'); } }
  console.log('$ wrangler d1 execute --local --file ' + entry.file); apply();
  node('snapshot', id, join(dir, 'post.json'));
  node('compare', id, join(dir, 'pre.json'), join(dir, 'post.json'), 'apply');
  node('summary', id, 'apply', join(dir, 'pre.json'), join(dir, 'post.json'));
  console.log('--- 同じSQLをもう一度適用（再実行安全の確認）');
  apply();
  node('snapshot', id, join(dir, 'post2.json'));
  const a = JSON.parse(readFileSync(join(dir, 'post.json'), 'utf8')), b = JSON.parse(readFileSync(join(dir, 'post2.json'), 'utf8'));
  const same = Object.keys(a.tables).every(t => a.tables[t].count === b.tables[t].count && a.tables[t].digest === b.tables[t].digest);
  console.log(same ? 'OK: 2回目の適用で全テーブルの件数・内容ハッシュが変わらない' : 'NG: 2回目で変化あり');
  if (!same) process.exitCode = 1;
} finally { rmSync(dir, {recursive: true, force: true}); }
