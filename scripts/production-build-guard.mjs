import {execFileSync} from 'node:child_process';
const branch = process.env.WORKERS_CI_BRANCH || execFileSync('git',['branch','--show-current'],{encoding:'utf8'}).trim();
if (branch !== 'main') {
  console.error('Production configuration is main-only. Use npm run preview:publish on develop.');
  process.exit(1);
}
console.log('Production branch guard: main');
