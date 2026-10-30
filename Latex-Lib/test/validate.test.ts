/**
 * The validator: a sound library passes; each broken id, vocabulary word,
 * preset value and bare rule is named.
 */
import assert from 'node:assert/strict';
import { test } from 'node:test';

import { validateLibrary, type Library } from '../schema/validate.ts';
import { AMSTHM, BOXED, CELL, CLASSES, FOOTNOTE, key, NESTING, PACKAGES } from './fixtures.ts';

const sound: Library = { keys: [AMSTHM, BOXED, FOOTNOTE, CELL], classes: CLASSES, packages: PACKAGES };
const problemsWith = (change: Partial<Library>): string[] => validateLibrary({ ...sound, ...change }, NESTING);

test('a sound library has no problem', () => {
  assert.deepEqual(validateLibrary(sound, NESTING), []);
});

test('ids must have their shape, be unique, and name a node of the nesting list', () => {
  const problems = problemsWith({ keys: [...sound.keys, key('Bad_Id', 'containerBlock/nowhere'), key('thm.amsthm', 'containerBlock/mathElement')] });
  assert.ok(problems.includes('way thm.amsthm: two keys of containerBlock/mathElement have this id'));
  assert.ok(problems.includes('way Bad_Id: the id is not <component>.<way>'));
  assert.ok(problems.includes("way Bad_Id: node containerBlock/nowhere is not in Flouest's nesting list"));
});

test('features, claims and preset values come from their vocabularies and schemas', () => {
  const bad = key('thm.bad', 'containerBlock/mathElement', {
    features: ['sparkly' as never],
    claims: ['everything' as never],
    params: { style: { type: 'enum', values: ['plain'], description: 'a style' } },
    presets: { odd: { description: 'odd', features: [], params: { style: 'fancy', size: 3 }, evidence: [] } },
  });
  const problems = problemsWith({ keys: [...sound.keys, bad] });
  assert.ok(problems.includes('way thm.bad: feature sparkly is not in the vocabulary'));
  assert.ok(problems.includes('way thm.bad: claim everything is not in the vocabulary'));
  assert.ok(problems.includes('way thm.bad preset odd: style = "fancy" is not one of plain'));
  assert.ok(problems.includes('way thm.bad preset odd: parameter size is not in the schema'));
});

test('every package, option, library and placeholder a key names must resolve', () => {
  const bad = key('thm.bad', 'containerBlock/mathElement', {
    loads: [{ pkg: 'mdframed' }, { pkg: 'ntheorem', options: ['amsthm', 'fancy'] }, { pkg: 'tcolorbox', libraries: ['magic'] }],
    defines: ['env:{elementName}'],
  });
  const problems = problemsWith({ keys: [...sound.keys, bad] });
  assert.ok(problems.includes('way thm.bad load 1: package mdframed has no facts in packages/'));
  assert.ok(problems.includes('way thm.bad load 2: ntheorem has no option fancy in its facts'));
  assert.ok(problems.includes('way thm.bad load 3: tcolorbox has no library magic in its facts'));
  assert.ok(problems.includes('way thm.bad: env:{elementName} names parameter elementName, which is not in the schema'));
});

test('a class, a conflicting way, a parent and a fallback must resolve, and the parent must be legal', () => {
  const bad = key('thm.bad', 'containerBlock/mathElement', {
    classes: { deny: [{ class: 'class.nowhere', reason: 'r', evidence: [] }] },
    packages: { conflicts: [{ way: 'thm.ghost', reason: 'r', evidence: [] }] },
    parents: {
      table: { scope: 'direct', deny: [{ way: '*', reason: 'not here', evidence: [] }] },
      table_cell: { scope: 'direct', deny: [{ way: 'fn.kernel', reason: 'r', evidence: [] }, { way: 'cell.kernel', when: { width: 'x' }, reason: 'r', evidence: [] }] },
    },
    fallback: { way: 'fn.kernel' },
  });
  const problems = problemsWith({ keys: [...sound.keys, bad] });
  assert.ok(problems.includes('way thm.bad: denies class class.nowhere, which has no profile in classes/'));
  assert.ok(problems.includes('way thm.bad: conflicts with way thm.ghost, which has no key'));
  assert.ok(problems.includes("way thm.bad under table: table is not a legal parent of containerBlock/mathElement in Flouest's nesting list"));
  assert.ok(problems.includes('way thm.bad under table_cell: names way fn.kernel, which is a way of containerBlock/footnote'));
  assert.ok(problems.includes('way thm.bad under table_cell cell.kernel: names parameter width, which is not in the schema'));
  assert.ok(problems.includes('way thm.bad: falls back to fn.kernel, a way of containerBlock/footnote, not of containerBlock/mathElement'));
});

test('a verified key needs evidence for itself and for every rule', () => {
  const bare = key('thm.bare', 'containerBlock/mathElement', {
    status: 'verified',
    evidence: [],
    classes: { deny: [{ class: 'class.llncs', reason: 'llncs defines theorem', evidence: [] }] },
  });
  const problems = problemsWith({ keys: [...sound.keys, bare] });
  assert.ok(problems.includes('way thm.bare: verified with no evidence'));
  assert.ok(problems.includes('way thm.bare: verified, but its rule on class class.llncs has no evidence'));
  assert.deepEqual(problemsWith({ keys: [...sound.keys, { ...bare, status: 'draft' }] }), [], 'a draft may have bare rules');
});
