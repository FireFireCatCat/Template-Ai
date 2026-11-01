/**
 * The check: a target document holds to the library's vocabulary, and each
 * problem is one sentence naming where it is.
 */
import assert from 'node:assert/strict';
import { join } from 'node:path';
import { test } from 'node:test';

import { flouestRoot } from '../../Latex-Lib/flouest.ts';
import { loadLibrary } from '../../Latex-Lib/library.ts';
import { readNesting } from '../../Latex-Lib/nesting.ts';
import type { Feature } from '../../Latex-Lib/schema/features.ts';

import { checkTarget } from '../src/extract/check.ts';
import type { TargetDocument, TargetKey } from '../src/model.ts';

const lib = join(import.meta.dirname, '..', '..', 'Latex-Lib');
const { library } = await loadLibrary(lib);
const nesting = readNesting(flouestRoot(lib));

const evidence = [{ kind: 'solution' as const, file: 'Solution/0999-demo.md', lines: '12' }];
const THEOREM: TargetKey = { node: 'containerBlock/mathElement', features: ['bold-head' as Feature], params: { style: 'plain' }, packages: [{ pkg: 'amsthm' }], description: 'bold run-in heads, italic body', evidence, confidence: 'high' };
const doc = (nodes: TargetKey[], document: TargetKey[] = [], name = 'article'): TargetDocument => ({ source: { id: 'demo', files: [] }, class: { name, options: [], description: '', evidence }, nodes, document });

test('a key in the library\'s words passes: a real node, features, a parameter some handler of the node has, a package, evidence', () => {
  assert.deepEqual(checkTarget(doc([THEOREM]), library, nesting), []);
});

test('a node, feature, parameter or value outside the library is named, one sentence each', () => {
  const problems = checkTarget(
    doc([
      { ...THEOREM, node: 'containerBlock/nope' },
      { ...THEOREM, features: ['sparkly' as Feature] },
      { ...THEOREM, params: { colour: 'red' } },
      { ...THEOREM, params: { style: 'wavy' } },
      { ...THEOREM, packages: [{ pkg: 'not a package' }] },
      { ...THEOREM, evidence: [] },
    ]),
    library,
    nesting,
  );
  assert.equal(problems.length, 7);
  assert.match(problems[0] ?? '', /^demo node 1 \(containerBlock\/nope\): node containerBlock\/nope is not in Flouest's nesting list$/u);
  assert.match(problems[1] ?? '', /^demo node 1 .*: no handler of containerBlock\/nope has a parameter style$/u);
  assert.match(problems[2] ?? '', /^demo node 2 .*: feature sparkly is not in the vocabulary$/u);
  assert.match(problems[3] ?? '', /^demo node 3 .*: no handler of containerBlock\/mathElement has a parameter colour$/u);
  assert.match(problems[4] ?? '', /^demo node 4 .*: style = "wavy" /u);
  assert.match(problems[5] ?? '', /^demo node 5 .*: package not a package is not a package name$/u);
  assert.match(problems[6] ?? '', /^demo node 6 .*: no evidence$/u);
});

test('a document-level key sits at doc, and has no parameters while no handler is there', () => {
  const problems = checkTarget(doc([], [{ ...THEOREM, node: 'containerBlock/mathElement', params: {} }, { ...THEOREM, node: 'doc' }]), library, nesting);
  assert.deepEqual(problems, ["demo document 1: a document-level key's node is containerBlock/mathElement, not doc", 'demo document 2: no handler of doc has a parameter style']);
});

test('the class key needs a name and evidence', () => {
  const nameless = doc([], [], ' ');
  assert.deepEqual(checkTarget({ ...nameless, class: { ...nameless.class, evidence: [] } }, library, nesting), ['demo class: no name', 'demo class: no evidence']);
});
