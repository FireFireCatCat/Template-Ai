// The pipeline's command line, against the Flouest checkout that
// compat.config.json names (`host.root`):
//
//   npm run compat -- <command> [args…]         (from the workspace folder)
//   node host-flouest/compat.mjs <command> [args…]
//
// A command is a file in `commands/` (run, stability, probe, oracle). A
// path to a `.ts` file instead runs that file, for one-off scripts.
//
// Flouest's sources import `./x.js` for `./x.ts`, resolve prosemirror and
// tiptap from the app's node_modules, and use Vite's `import.meta.glob`. Node
// alone can do none of that. So the entry is bundled the way Flouest's dynamic
// tests bundle theirs (their run.mjs): with Flouest's own esbuild, under
// Flouest's Template tsconfig, with Flouest's `import.meta.glob` expansion,
// into a temporary file that is then run.
//
// Two names resolve here: `compat-core` to core's sources, and
// `@flouest/<path>` to that file of the checkout. The entry runs in the
// workspace folder, so `out/` is the workspace's.
import { createHash } from 'node:crypto';
import { existsSync, mkdtempSync, readdirSync, readFileSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';

const here = dirname(fileURLToPath(import.meta.url));
const workspace = resolve(here, '..');
const commands = join(here, 'commands');
const [command, ...args] = process.argv.slice(2);
const known = existsSync(commands) ? readdirSync(commands).filter((f) => f.endsWith('.ts')).map((f) => f.slice(0, -3)) : [];
if (!command || (!command.endsWith('.ts') && !known.includes(command))) {
  console.error(`Usage: npm run compat -- <command> [args…]\nCommands: ${known.join(', ')}`);
  process.exit(1);
}
const entry = command.endsWith('.ts') ? resolve(process.cwd(), command) : join(commands, `${command}.ts`);

const config = JSON.parse(readFileSync(join(workspace, 'compat.config.json'), 'utf8'));
if (config.host?.kind !== 'flouest' || typeof config.host.root !== 'string') {
  console.error('compat.config.json: host must be { "kind": "flouest", "root": "<the Flouest checkout>" }');
  process.exit(1);
}
const flouest = resolve(workspace, config.host.root);

const { build } = await import(pathToFileURL(join(flouest, 'app/node_modules/esbuild/lib/main.js')).href);
const { importMetaGlob } = await import(pathToFileURL(join(flouest, 'Template/test/dynamic-testing/importMetaGlob.mjs')).href);

const names = {
  name: 'compat-names',
  setup(b) {
    b.onResolve({ filter: /^compat-core$/ }, () => ({ path: join(workspace, 'core/src/index.ts') }));
    b.onResolve({ filter: /^@flouest\// }, (a) => ({ path: join(flouest, a.path.slice('@flouest/'.length)) }));
  },
};

const dir = mkdtempSync(join(tmpdir(), 'compat-host-flouest-'));
const outfile = join(dir, 'entry.mjs');
await build({
  entryPoints: [entry],
  outfile,
  bundle: true,
  platform: 'node',
  format: 'esm',
  // ES modules first, as Flouest's tsconfig maps ProseMirror to its ESM entry
  // files (Flouest ADR-346), so one prosemirror-model is loaded, not two.
  mainFields: ['module', 'main'],
  logLevel: 'warning',
  tsconfig: join(flouest, 'Template/tsconfig.json'),
  nodePaths: [join(flouest, 'app/node_modules')],
  banner: { js: "import { createRequire } from 'module'; const require = createRequire(import.meta.url);" },
  plugins: [names, importMetaGlob],
});
// The host's fingerprint: everything the entry runs, Flouest's code included.
process.env.COMPAT_BUNDLE = createHash('sha256').update(readFileSync(outfile)).digest('hex');
process.chdir(workspace);
process.argv = [process.argv[0], outfile, ...args];
try {
  await import(pathToFileURL(outfile).href);
} finally {
  rmSync(dir, { recursive: true, force: true });
}
