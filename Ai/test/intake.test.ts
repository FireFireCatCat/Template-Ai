/**
 * Intake: the files, hashed and sorted by kind; the main file, chosen the same
 * way whatever order the disk lists files in; what the template ships.
 */
import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { test } from 'node:test';

import { readSource, uncommented } from '../src/extract/intake.ts';
import { folder } from './fixtures.ts';

const DOC = '\\documentclass{article}\n\\begin{document}\nx\n\\end{document}\n';

test('every file is hashed and sorted by kind; dotfiles and __MACOSX are left out', () => {
  const source = readSource(folder({ 'main.tex': DOC, 'logo.png': 'png', 'refs.bib': '@book{a}', '.DS_Store': '', '__MACOSX/main.tex': DOC }, 'demo'));
  assert.equal(source.id, 'demo');
  assert.deepEqual(source.files.map((f) => [f.path, f.kind]), [['logo.png', 'image'], ['main.tex', 'tex'], ['refs.bib', 'bib']]);
  assert.equal(source.files.find((f) => f.path === 'main.tex')?.sha256, createHash('sha256').update(DOC).digest('hex'));
});

test('a comment is blanked to the end of its line and lines keep their numbers; an escaped percent stays', () => {
  assert.equal(uncommented('a % b\n50\\% c % d\ne'), 'a \n50\\% c \ne');
});

test('the main file starts a document: a commented-out class line does not count', () => {
  const source = readSource(folder({ 'aaa.tex': '% \\documentclass{article}\n\\begin{document}\\end{document}', 'zzz.tex': DOC }));
  assert.equal(source.main, 'zzz.tex');
});

test('of several, one with \\begin{document} wins, then a .tex over a .dtx, then a usual name, then the shallower, then by name', () => {
  assert.equal(readSource(folder({ 'a.tex': '\\documentclass{article}\n', 'b.tex': DOC })).main, 'b.tex');
  assert.equal(readSource(folder({ 'aaa.dtx': DOC, 'zzz.tex': DOC })).main, 'zzz.tex');
  assert.equal(readSource(folder({ 'aaa.tex': DOC, 'main.tex': DOC, 'template.tex': DOC })).main, 'main.tex');
  assert.equal(readSource(folder({ 'sub/main.tex': DOC, 'main.tex': DOC })).main, 'main.tex');
  assert.equal(readSource(folder({ 'b.tex': DOC, 'a.tex': DOC })).main, 'a.tex');
  assert.equal(readSource(folder({ 'README.md': 'no LaTeX' })).main, undefined);
});

test('the classes and styles the template ships are found by name', () => {
  const source = readSource(folder({ 'main.tex': DOC, 'cls/thesis.cls': '\\ProvidesClass{thesis}\n', 'notes.sty': '\\ProvidesPackage{notes}\n' }));
  assert.deepEqual(source.classes, [{ name: 'thesis', path: 'cls/thesis.cls' }]);
  assert.deepEqual(source.styles, [{ name: 'notes', path: 'notes.sty' }]);
});
