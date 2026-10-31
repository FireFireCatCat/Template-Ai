/**
 * Synthetic templates for the tests: a folder written from a map of paths to
 * text, removed after the run. No test reads `Source/`.
 */
import { mkdirSync, mkdtempSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join } from 'node:path';
import { after } from 'node:test';

const folders: string[] = [];
after(() => {
  for (const f of folders) rmSync(f, { recursive: true, force: true });
});

/** A folder holding these files; its name is the template's id. */
export const folder = (files: { readonly [path: string]: string }, id = 'template'): string => {
  const root = join(mkdtempSync(join(tmpdir(), 'ai-test-')), id);
  folders.push(dirname(root));
  for (const [path, text] of Object.entries(files)) {
    mkdirSync(dirname(join(root, path)), { recursive: true });
    writeFileSync(join(root, path), text);
  }
  return root;
};
