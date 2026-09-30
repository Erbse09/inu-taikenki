import {readFileSync} from 'node:fs';
import {execFileSync} from 'node:child_process';
import {resolve} from 'node:path';
import {fileURLToPath} from 'node:url';
import {createRequire} from 'node:module';
import assert from 'node:assert/strict';
const root = fileURLToPath(new URL('../', import.meta.url));
process.chdir(root);
export function validateConfig(p, prod) {
  assert.equal(p.name, prod.name);
  assert.equal(p.main, 'src/preview-entry.ts');
  assert.deepEqual(p.previews.vars, {APP_ENV:'preview'});
  assert.equal(p.assets.run_worker_first, true);
  assert.equal(p.assets.directory, './public');
  assert.deepEqual(p.previews.d1_databases, prod.d1_databases, 'Preview must reference the existing production DB through the read-only wrapper');
  assert.equal(prod.d1_databases.length, 1);
  assert.equal(prod.d1_databases[0].binding, 'DB');
  assert.equal(prod.d1_databases[0].database_name, 'inu-taikenki');
  assert.equal(prod.d1_databases[0].database_id, 'a7339570-f395-48fd-8757-b5259a505560');
  assert.deepEqual(Object.keys(p).sort(), ['$schema','assets','compatibility_date','main','name','previews'].sort());
  assert.deepEqual(Object.keys(p.previews).sort(), ['d1_databases','vars']);
}
function run() {
  const command = process.argv[2] ?? 'check';
  assert(['check','publish'].includes(command), 'Use check or publish; Preview has no data-write command');
  validateConfig(JSON.parse(readFileSync('wrangler.preview.json')), JSON.parse(readFileSync('wrangler.jsonc')));
  const branch = process.env.WORKERS_CI_BRANCH || execFileSync('git',['branch','--show-current'],{encoding:'utf8'}).trim();
  assert.equal(branch, 'develop', 'Use develop');
  if (command === 'check') {console.log('Read-only Preview config: PASS'); return;}
  assert.equal(execFileSync('git',['status','--porcelain','--untracked-files=no'],{encoding:'utf8'}).trim(), '', 'Commit reviewed changes first');
  execFileSync('npm',['run','check'],{stdio:'inherit'});
  execFileSync('npm',['run','test:preview'],{stdio:'inherit'});
  const require = createRequire(import.meta.url);
  const pkgPath = require.resolve('wrangler/package.json');
  const pkg = JSON.parse(readFileSync(pkgPath));
  assert.equal(pkg.version, '4.135.0', 'Use the pinned, tested Wrangler');
  const bin = resolve(pkgPath,'..',typeof pkg.bin === 'string' ? pkg.bin : pkg.bin.wrangler);
  execFileSync(process.execPath,[bin,'preview','--name','develop','--config','wrangler.preview.json','--ignore-base-config'],{stdio:'inherit'});
}
if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  try {run();} catch(e) {console.error(e.message);process.exitCode=1;}
}
