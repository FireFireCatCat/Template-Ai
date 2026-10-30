/**
 * The library on disk, and the Flouest pin: a key is loaded from the folder
 * its id names, and a changed Flouest file is found.
 */
import assert from 'node:assert/strict';
import { mkdirSync, mkdtempSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { after, test } from 'node:test';

import { checkPin, pinFlouest, PRINTERS } from '../flouest.ts';
import { loadLibrary } from '../library.ts';
import { NESTING_FILE } from '../nesting.ts';
import { AMSTHM } from './fixtures.ts';

const folders: string[] = [];
const fresh = (): string => {
  const f = mkdtempSync(join(tmpdir(), 'latex-lib-'));
  folders.push(f);
  return f;
};
after(() => {
  for (const f of folders) rmSync(f, { recursive: true, force: true });
});

const writeKey = (root: string, folder: string, way: string, key: object): void => {
  mkdirSync(join(root, 'nodes', folder, way), { recursive: true });
  writeFileSync(join(root, 'nodes', folder, way, 'key.ts'), `export default ${JSON.stringify(key)};\n`);
};

test('keys, classes and packages are read from their folders; a key in the wrong folder is named', async () => {
  const root = fresh();
  writeKey(root, 'containerBlock.mathElement', 'thm.amsthm', AMSTHM);
  writeKey(root, 'containerBlock.mathElement', 'thm.elsewhere', { ...AMSTHM, id: 'thm.kernel' });
  mkdirSync(join(root, 'classes'));
  writeFileSync(join(root, 'classes', 'article.ts'), `export default ${JSON.stringify({ id: 'class.article' })};\n`);
  mkdirSync(join(root, 'packages'));
  writeFileSync(join(root, 'packages', 'amsthm.ts'), `export default ${JSON.stringify({ id: 'amsthm' })};\n`);
  const { library, misplaced } = await loadLibrary(root);
  assert.deepEqual(library.keys.map((k) => k.id), ['thm.amsthm', 'thm.kernel']);
  assert.deepEqual(library.classes.map((c) => c.id), ['class.article']);
  assert.deepEqual(library.packages.map((p) => p.id), ['amsthm']);
  assert.deepEqual(misplaced, ['way thm.kernel (node containerBlock/mathElement) is in nodes/containerBlock.mathElement/thm.elsewhere/']);
});

test('the pin holds the hash of every file the library reads, and names one that changed, went or came', () => {
  const flouest = fresh();
  const lib = fresh();
  const write = (path: string, text: string): void => {
    mkdirSync(join(flouest, path, '..'), { recursive: true });
    writeFileSync(join(flouest, path), text);
  };
  write(NESTING_FILE, '{"nodes":{}}');
  write('JSON->Latex Compiler/src/Profile/Profile_General/types.ts', 'export {};');
  write('JSON->Latex Compiler/src/Plugins/plugins.ts', 'export {};');
  write('JSON->Latex Compiler/src/Profile/Profile_General/containerBlockShape/mathElement.ts', 'export {};');
  write(`${PRINTERS}/amsthm.ts`, 'export {};');
  pinFlouest(lib, flouest);
  assert.deepEqual(checkPin(lib), []);
  write(`${PRINTERS}/amsthm.ts`, 'export const changed = 1;');
  write(`${PRINTERS}/mdframed.ts`, 'export {};');
  assert.deepEqual(checkPin(lib), [
    `flouest: ${PRINTERS}/amsthm.ts changed since the pin (node cli.ts pin, once read)`,
    `flouest: ${PRINTERS}/mdframed.ts is new since the pin`,
  ]);
});
