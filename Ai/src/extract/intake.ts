/**
 * Intake (ARCHITECTURE.md section 2, step 1): a template's folder as its
 * files, each hashed and sorted by kind; the main file; and the classes and
 * styles it ships itself. This is what the model is handed; no code reads the
 * template's meaning. Nothing in the folder is run, only read.
 *
 * The main file is the `.tex` (or `.dtx`) that starts a document: it holds an
 * uncommented `\documentclass` and, when any does, `\begin{document}`. When
 * several do, a `.tex` sample wins over a `.dtx` (whose driver typesets the
 * class's manual), then the one with a usual main name (main, template,
 * sample…), then the one nearest the top of the folder, then the first by
 * name, so the choice never depends on the order the disk lists files in.
 */
import { createHash } from 'node:crypto';
import { readdirSync, readFileSync, statSync } from 'node:fs';
import { basename, extname, join, relative } from 'node:path';

import type { SourceFile } from '../model.ts';

export type FileKind = 'tex' | 'dtx' | 'cls' | 'sty' | 'bst' | 'bib' | 'image' | 'other';

export type TemplateFile = SourceFile & { readonly kind: FileKind; readonly size: number };

export type TemplateSource = {
  readonly id: string;
  readonly root: string;
  readonly files: readonly TemplateFile[];
  /** The file that starts the document, or nothing when no file does. */
  readonly main: string | undefined;
  /** Classes and styles the template ships, by their name (`acmart` for `acmart.cls`). */
  readonly classes: readonly { readonly name: string; readonly path: string }[];
  readonly styles: readonly { readonly name: string; readonly path: string }[];
};

const KINDS: { readonly [ext: string]: FileKind } = {
  '.tex': 'tex',
  '.ltx': 'tex',
  '.dtx': 'dtx',
  '.cls': 'cls',
  '.sty': 'sty',
  '.bst': 'bst',
  '.bib': 'bib',
  '.png': 'image',
  '.jpg': 'image',
  '.jpeg': 'image',
  '.pdf': 'image',
  '.eps': 'image',
  '.svg': 'image',
};

const MAIN_NAMES = ['main', 'template', 'sample', 'paper', 'article', 'thesis', 'report', 'document', 'manuscript', 'cv', 'resume', 'poster', 'presentation', 'slides', 'book'];

/** Text with every comment blanked to the end of its line, so line numbers stay true. */
export const uncommented = (text: string): string => text.replace(/(?<!\\)%.*$/gmu, '');

const walk = (root: string, dir: string, out: string[]): void => {
  for (const name of readdirSync(dir).sort()) {
    if (name.startsWith('.') || name === '__MACOSX' || name === 'node_modules') continue;
    const path = join(dir, name);
    if (statSync(path).isDirectory()) walk(root, path, out);
    else out.push(relative(root, path));
  }
};

export const readSource = (root: string): TemplateSource => {
  const paths: string[] = [];
  walk(root, root, paths);
  const files = paths.map((path): TemplateFile => {
    const bytes = readFileSync(join(root, path));
    return { path, sha256: createHash('sha256').update(bytes).digest('hex'), kind: KINDS[extname(path).toLowerCase()] ?? 'other', size: bytes.length };
  });
  const starts = files
    .filter((f) => f.kind === 'tex' || f.kind === 'dtx')
    .map((f) => {
      const text = uncommented(readFileSync(join(root, f.path), 'utf8'));
      return { path: f.path, documentclass: /\\documentclass\s*(\[|\{)/u.test(text), begins: /\\begin\s*\{document\}/u.test(text), driver: f.kind === 'dtx' };
    })
    .filter((f) => f.documentclass);
  const rank = (f: { path: string; begins: boolean; driver: boolean }): [number, number, number, number, string] => {
    const stem = basename(f.path, extname(f.path)).toLowerCase();
    const named = MAIN_NAMES.findIndex((n) => stem === n || stem.startsWith(`${n}-`) || stem.startsWith(`${n}_`) || stem.endsWith(`-${n}`));
    return [f.begins ? 0 : 1, f.driver ? 1 : 0, named < 0 ? MAIN_NAMES.length : named, f.path.split('/').length, f.path];
  };
  const main = [...starts].sort((a, b) => {
    const [x, y] = [rank(a), rank(b)];
    for (let i = 0; i < x.length; i++) if (x[i] !== y[i]) return x[i]! < y[i]! ? -1 : 1;
    return 0;
  })[0]?.path;
  const named = (kind: FileKind) => files.filter((f) => f.kind === kind).map((f) => ({ name: basename(f.path, extname(f.path)), path: f.path }));
  return { id: basename(root), root, files, main, classes: named('cls'), styles: named('sty') };
};
