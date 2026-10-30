/**
 * The Flouest checkout the library is built against (ARCHITECTURE.md section
 * 2, M0). The checkout is not a git repository, so there is no commit to pin.
 * The library pins the files it reads instead: `flouest.lock.json` names the
 * checkout and holds each file's hash, and `checkPin` says which changed, so
 * a change in Flouest is seen before it is built on.
 */
import { existsSync, readdirSync, readFileSync, writeFileSync } from 'node:fs';
import { join, resolve } from 'node:path';

import { sha256 } from './hash.ts';
import { NESTING_FILE } from './nesting.ts';

export const LOCK = 'flouest.lock.json';

/** The files the library reads or builds on. */
export const PINNED = [
  NESTING_FILE,
  'JSON->Latex Compiler/src/Profile/Profile_General/types.ts',
  'JSON->Latex Compiler/src/Plugins/plugins.ts',
  'JSON->Latex Compiler/src/Profile/Profile_General/containerBlockShape/mathElement.ts',
] as const;
/** Every printer in this folder is pinned too: handlers call them. */
export const PRINTERS = 'JSON->Latex Compiler/src/Packages';

export type Lock = { readonly root: string; readonly files: { readonly [path: string]: string } };

/** The checkout `flouest.lock.json` names, resolved against the library's folder. */
export const flouestRoot = (lib: string): string => resolve(lib, readLock(lib).root);

export const readLock = (lib: string): Lock => JSON.parse(readFileSync(join(lib, LOCK), 'utf8')) as Lock;

const pinnedFiles = (flouest: string): string[] => [
  ...PINNED,
  ...readdirSync(join(flouest, PRINTERS))
    .filter((f) => f.endsWith('.ts'))
    .sort()
    .map((f) => `${PRINTERS}/${f}`),
];

const hashes = (flouest: string): { [path: string]: string } =>
  Object.fromEntries(pinnedFiles(flouest).map((path) => [path, sha256(readFileSync(join(flouest, path)))]));

/** Writes the lock for the checkout at `root` (relative to the library's folder). */
export const pinFlouest = (lib: string, root: string): Lock => {
  const lock: Lock = { root, files: hashes(resolve(lib, root)) };
  writeFileSync(join(lib, LOCK), `${JSON.stringify(lock, null, 2)}\n`);
  return lock;
};

/** Each pinned file that is missing, changed or new since the lock was written. */
export const checkPin = (lib: string): string[] => {
  const lock = readLock(lib);
  const flouest = resolve(lib, lock.root);
  if (!existsSync(flouest)) return [`flouest: no checkout at ${flouest}`];
  const now = hashes(flouest);
  const problems: string[] = [];
  for (const [path, hash] of Object.entries(lock.files)) {
    if (now[path] === undefined) problems.push(`flouest: ${path} is gone since the pin`);
    else if (now[path] !== hash) problems.push(`flouest: ${path} changed since the pin (node cli.ts pin, once read)`);
  }
  for (const path of Object.keys(now)) if (lock.files[path] === undefined) problems.push(`flouest: ${path} is new since the pin`);
  return problems;
};
