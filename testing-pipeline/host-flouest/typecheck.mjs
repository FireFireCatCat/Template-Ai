// Type-checks host-flouest against the Flouest checkout that compat.config.json
// names, with Flouest's own TypeScript and compiler settings:
//
//   npm run check -w compat-host-flouest
//
// The binding imports Flouest's sources, so it can only be checked under
// Flouest's tsconfig. That tsconfig lives in the checkout, wherever it is, so
// a tsconfig is written for each check, in a temporary folder: Flouest's
// Template tsconfig, plus Flouest's path aliases with `compat-core` and
// `@flouest/*` added. TypeScript does not merge `paths` across `extends`, so
// the app's own aliases are copied in.
import { spawnSync } from 'node:child_process';
import { mkdtempSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { createRequire } from 'node:module';
import { tmpdir } from 'node:os';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const here = dirname(fileURLToPath(import.meta.url));
const workspace = resolve(here, '..');
const config = JSON.parse(readFileSync(join(workspace, 'compat.config.json'), 'utf8'));
const flouest = resolve(workspace, config.host.root);
const ts = createRequire(join(flouest, 'app/package.json'))('typescript');

const app = ts.readConfigFile(join(flouest, 'app/tsconfig.json'), ts.sys.readFile).config;
const tsconfig = {
  extends: join(flouest, 'Template/tsconfig.json'),
  compilerOptions: {
    noEmit: true,
    allowImportingTsExtensions: true,
    skipLibCheck: true,
    typeRoots: [join(flouest, 'app/node_modules/@types')],
    types: ['node'],
    baseUrl: join(flouest, 'app'),
    paths: {
      ...app.compilerOptions.paths,
      'compat-core': [join(workspace, 'core/src/index.ts')],
      '@flouest/*': [join(flouest, '*')],
    },
  },
  include: [
    join(here, 'src/**/*.ts'),
    join(here, 'commands/**/*.ts'),
    join(flouest, 'app/src/**/*.d.ts'),
    join(flouest, 'mvp-editor-version-3/src/**/*.d.ts'),
  ],
};

const dir = mkdtempSync(join(tmpdir(), 'compat-host-flouest-check-'));
try {
  const file = join(dir, 'tsconfig.json');
  writeFileSync(file, JSON.stringify(tsconfig, null, 2));
  const tsc = join(dirname(createRequire(join(flouest, 'app/package.json')).resolve('typescript')), '../bin/tsc');
  const { status } = spawnSync(process.execPath, [tsc, '-p', file], { stdio: 'inherit', cwd: join(flouest, 'app') });
  process.exitCode = status ?? 1;
} finally {
  rmSync(dir, { recursive: true, force: true });
}
