/**
 * The theorem handlers (ARCHITECTURE.md 9.1): each preset's LaTeX fixed by
 * snapshot, and what each way must do whatever its preset (shared counters,
 * renaming, breaking where the box opens, the class's own environments).
 *
 * The snapshot is written when missing; `UPDATE_SNAPSHOTS=1 npm test` writes
 * it again after a deliberate change.
 */
import assert from 'node:assert/strict';
import { existsSync, mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import { test } from 'node:test';

import { adapted } from '../engine/adapt.ts';
import type { Nesting } from '../nesting.ts';
import { HANDLERS } from '../nodes/containerBlock.mathElement/index.ts';
import amsthmKey from '../nodes/containerBlock.mathElement/thm.amsthm/key.ts';
import classNativeKey from '../nodes/containerBlock.mathElement/thm.class-native/key.ts';
import kernelKey from '../nodes/containerBlock.mathElement/thm.kernel/key.ts';
import mdframedKey from '../nodes/containerBlock.mathElement/thm.mdframed/key.ts';
import ntheoremKey from '../nodes/containerBlock.mathElement/thm.ntheorem/key.ts';
import tcolorboxKey from '../nodes/containerBlock.mathElement/thm.tcolorbox/key.ts';
import thmtoolsKey from '../nodes/containerBlock.mathElement/thm.thmtools/key.ts';
import type { HandlerKey } from '../schema/key.ts';
import type { Realization, Subject } from '../schema/realization.ts';

const KEYS: readonly HandlerKey[] = [amsthmKey, classNativeKey, kernelKey, mdframedKey, ntheoremKey, tcolorboxKey, thmtoolsKey];
const statement = (elementName: string, label = ''): Subject => ({ type: 'mathElement', attrs: { data: { elementName, label } } });
const handler = (way: string) => {
  const h = HANDLERS[way];
  assert.ok(h, way);
  return h;
};
const printed = (r: Realization, node: Subject, parentType = 'doc') => {
  const pre = r.preamble({}, parentType, node);
  return { packages: pre.packages ?? [], declarations: pre.declarations ?? [], body: r.emit(node, 'A body.', 'Note', parentType) };
};

test('every preset of every way prints what its snapshot holds', () => {
  const snapshots: Record<string, unknown> = {};
  for (const key of KEYS) {
    for (const [name, preset] of Object.entries(key.presets)) {
      const r = handler(key.id)(preset.params);
      snapshots[`${key.id} ${name}`] = ['theorem', 'lemma', 'definition'].map((e) => printed(r, statement(e, `${e}:one`)));
    }
  }
  const dir = join(import.meta.dirname, 'snapshots');
  const file = join(dir, 'handlers.json');
  const text = `${JSON.stringify(snapshots, null, 2)}\n`;
  if (!existsSync(file) || process.env['UPDATE_SNAPSHOTS'] === '1') {
    mkdirSync(dir, { recursive: true });
    writeFileSync(file, text);
  }
  assert.equal(text, readFileSync(file, 'utf8'), 'a handler prints something new: check it, then UPDATE_SNAPSHOTS=1 npm test');
});

test("a kind on the theorem's counter declares the theorem first, and each declaration is one entry", () => {
  const ams = printed(handler('thm.amsthm')(amsthmKey.presets['ams-section'].params), statement('lemma'));
  assert.deepEqual(ams.declarations, ['\\theoremstyle{plain}\n\\newtheorem{theorem}{Theorem}[section]', '\\theoremstyle{plain}\n\\newtheorem{lemma}[theorem]{Lemma}']);
  const global = printed(handler('thm.amsthm')(amsthmKey.presets.global.params), statement('definition'));
  assert.deepEqual(global.declarations, ['\\theoremstyle{plain}\n\\newtheorem{definition}{Definition}']);
  assert.deepEqual(printed(handler('thm.thmtools')({}), statement('lemma')).declarations.slice(-1), ['\\declaretheorem[style=libthm, name=Lemma, sibling=theorem]{lemma}']);
  assert.deepEqual(printed(handler('thm.mdframed')({ sharedCounter: false, numberWithin: 'chapter' }), statement('remark')).declarations, [
    '\\newmdtheoremenv[linecolor=black,backgroundcolor=white,linewidth=0.4pt]{remark}{Remark}[chapter]',
  ]);
});

test('renaming prefixes every environment, the shared counter included', () => {
  const r = printed(handler('thm.kernel')({ rename: 'yes' }), statement('lemma', 'l:1'));
  assert.deepEqual(r.declarations, ['\\newtheorem{libtheorem}{Theorem}[section]', '\\newtheorem{liblemma}[libtheorem]{Lemma}']);
  assert.equal(r.body, '\\begin{liblemma}[{Note}]\n\\label{l:1}\nA body.\n\\end{liblemma}\n\n');
});

test('a body that opens with a box or a table gets \\leavevmode first, as General does', () => {
  const r = handler('thm.amsthm')({});
  assert.match(r.emit(statement('theorem'), '\\begin{tcolorbox}x\\end{tcolorbox}'), /\\begin\{theorem\}\n\\leavevmode\n\\begin\{tcolorbox\}/);
});

const NESTING: Nesting = {
  nodes: {
    'containerBlock/mathElement': { family: 'container', parents: ['containerBlock/footnote', 'table_cell'] },
    'containerBlock/footnote': { family: 'container', parents: [] },
    table_cell: { family: 'container', parents: [] },
  },
};

test('a tcolorbox statement breaks across pages in the body and not in a footnote, with one declaration for both', () => {
  const r = adapted({
    key: tcolorboxKey,
    params: tcolorboxKey.presets.boxed.params,
    handlerOf: (way) => HANDLERS[way],
    keyOf: (way) => KEYS.find((k) => k.id === way),
    nesting: NESTING,
  });
  const inBody = printed(r, statement('theorem'), 'doc');
  const inNote = printed(r, statement('theorem'), 'footnote');
  assert.match(inBody.body, /^\\begin\{theorem\}\[breakable\]\{Note\}\{\}/);
  assert.match(inNote.body, /^\\begin\{theorem\}\{Note\}\{\}/);
  assert.equal(inBody.declarations.at(-1), inNote.declarations.at(-1), 'the environment is declared the same way in both');
  assert.deepEqual([inBody.declarations[0], inNote.declarations[0]], ['\\tcbuselibrary{theorems,skins,breakable}', '\\tcbuselibrary{theorems,skins}']);
});

test('a denied parent emits the fallback', () => {
  const denying: HandlerKey = { ...tcolorboxKey, parents: { table_cell: { scope: 'direct', deny: [{ way: '*', reason: 'test', evidence: [] }] } } };
  const r = adapted({ key: denying, params: {}, handlerOf: (way) => HANDLERS[way], keyOf: (way) => KEYS.find((k) => k.id === way), nesting: NESTING });
  assert.match(printed(r, statement('lemma'), 'table_cell').body, /^\\begin\{lemma\}\[\{Note\}\]/, 'thm.amsthm, its fallback');
});

test("the class's own environments are used by name, and a kind the class lacks is declared only if undefined", () => {
  const r = printed(handler('thm.class-native')(), statement('remark'));
  assert.deepEqual(r.declarations, ['\\makeatletter\n\\@ifundefined{remark}{\\newtheorem{remark}{Remark}}{}\n\\makeatother']);
  assert.equal(r.packages.length, 0);
  assert.match(r.body, /^\\begin\{remark\}\[\{Note\}\]/);
});
