import { readFileSync, existsSync, realpathSync } from 'node:fs';
import { execFileSync } from 'node:child_process';
import { resolve, relative } from 'node:path';
import { fileURLToPath } from 'node:url';
import { createRequire } from 'node:module';
import assert from 'node:assert/strict';
const root = fileURLToPath(new URL('../', import.meta.url));
process.chdir(root);
export function validateConfig(p, migration, prod) {
  const db = p.previews?.d1_databases;
  assert.equal(p.name, prod.name);
  assert.equal(p.main, 'src/preview-entry.ts');
  assert.equal(p.previews.vars.APP_ENV, 'preview');
  assert.equal(p.assets.run_worker_first, true);
  assert.equal(p.assets.directory, './public');
  assert.equal(db?.length, 1);
  assert.equal(db[0].binding, 'DB');
  assert.match(db[0].database_id, /^[a-f0-9]{8}(?:-[a-f0-9]{4}){3}-[a-f0-9]{12}$/i, 'Preview D1 is not configured');
  for (const live of prod.d1_databases) {
    assert.notEqual(db[0].database_id.toLowerCase(), live.database_id.toLowerCase(), 'Production D1 is forbidden');
    assert.notEqual(db[0].database_name, live.database_name);
  }
  assert.equal(db[0].database_name, 'inu-taikenki-preview');
  assert.equal(migration.d1_databases.length, 1);
  assert.equal(migration.d1_databases[0].database_id, db[0].database_id);
  assert.equal(migration.d1_databases[0].database_name, db[0].database_name);
  assert.equal(migration.d1_databases[0].binding, 'PREVIEW_DB');
  assert.equal(migration.d1_databases[0].migrations_dir, 'release-data');
  // No production routes, bindings, scheduled work or secret inheritance.
  assert.deepEqual(Object.keys(p).sort(), ['$schema','assets','compatibility_date','main','name','previews'].sort());
  assert.deepEqual(Object.keys(p.previews).sort(), ['d1_databases','vars']);
}
function run() {
  const command = process.argv[2] ?? 'check';
  assert(['check','publish','apply'].includes(command), 'Use check, publish, or apply');
  const p = JSON.parse(readFileSync('wrangler.preview.json'));
  const m = JSON.parse(readFileSync('wrangler.preview-migrations.json'));
  const prod = JSON.parse(readFileSync('wrangler.jsonc'));
  validateConfig(p,m,prod);
  assert.equal(execFileSync('git',['branch','--show-current'],{encoding:'utf8'}).trim(),'develop','Use develop');
  if (command === 'check') { console.log('Preview DB/config guard: PASS'); return; }
  assert.equal(process.env.INU_PREVIEW_SETUP_VERIFIED,'1','First verify Cloudflare build settings, account and both D1 IDs; see DEVELOPMENT.md');
  const require = createRequire(import.meta.url);
  const pkgPath = require.resolve('wrangler/package.json');
  const pkg = JSON.parse(readFileSync(pkgPath));
  const [major,minor] = pkg.version.split('.').map(Number);
  assert(major === 4 && minor >= 135,'Install tested Wrangler 4.135.0 or later in major 4');
  const bin = resolve(pkgPath,'..',typeof pkg.bin === 'string' ? pkg.bin : pkg.bin.wrangler);
  if (command === 'publish') {
    assert.equal(execFileSync('git',['status','--porcelain'],{encoding:'utf8'}).trim(),'','Commit the reviewed snapshot first');
    execFileSync(process.execPath,[bin,'preview','--name','develop','--config','wrangler.preview.json'],{stdio:'inherit'});
  } else {
    const path = process.argv[3];
    assert(path && existsSync(path),'Specify one reviewed release-data/*.sql file');
    const rel = relative(resolve('release-data'),realpathSync(path));
    assert(/^[A-Za-z0-9_-]+\.sql$/.test(rel),'Only a direct release-data SQL file is allowed');
    // An explicitly selected migration, never the historical migrations batch or seed.
    execFileSync(process.execPath,[bin,'d1','execute','PREVIEW_DB','--remote','--config','wrangler.preview-migrations.json','--file',realpathSync(path)],{stdio:'inherit'});
  }
}
if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  try {run();} catch(e) {console.error(e.message);process.exitCode=1;}
}
