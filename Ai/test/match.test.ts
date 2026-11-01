/**
 * The class search and the node filter: a class key to a profile by tier,
 * and the resolver's sentences that refuse a choice under that class.
 */
import assert from 'node:assert/strict';
import { join } from 'node:path';
import { test } from 'node:test';

import { loadLibrary } from '../../Latex-Lib/library.ts';

import { matchClass, refusing } from '../src/search/classes.ts';
import { allowedHandlers } from '../src/search/nodes.ts';
import type { TargetClass } from '../src/model.ts';

const { library } = await loadLibrary(join(import.meta.dirname, '..', '..', 'Latex-Lib'));
const cls = (name: string, over: Partial<TargetClass> = {}): TargetClass => ({ name, options: [], description: '', evidence: [], ...over });

test('a class key finds its profile by name, by what a shipped class loads, or by the nearest name; else none', () => {
  const tier = (k: TargetClass) => { const m = matchClass(k, library); return [m.tier, m.profile, m.resolveAs]; };
  assert.deepEqual(tier(cls('IEEEtran')), ['exact', 'class.ieeetran', 'class.ieeetran']);
  assert.deepEqual(tier(cls('olplainarticle', { local: { file: 'olplainarticle.cls', loads: 'article' } })), ['base', 'class.article', 'class.article']);
  assert.deepEqual(tier(cls('mythesis', { local: { file: null, loads: 'abntex2' } })), ['ship-class', null, 'class.mythesis']);
  assert.deepEqual(tier(cls('myletter')), ['nearest', 'class.letter', 'class.letter']);
  assert.deepEqual(tier(cls('scartcl')), ['nearest', 'class.scrartcl', 'class.scrartcl']);
  assert.deepEqual(tier(cls('zzqq')), ['none', null, 'class.zzqq']);
});

test('a class with no profile is found by its description when its name is near none', () => {
  const m = matchClass(cls('zzqq', { description: 'an IEEE conference paper' }), library, (_, [entry]) => (entry === 'class:class.ieeetran' ? 0.7 : 0.1));
  assert.deepEqual([m.tier, m.profile], ['nearest', 'class.ieeetran']);
});

test('a profile that does not run in ZeroTeX-NG stops the run', () => {
  assert.equal(matchClass(cls('jlreq'), library).refused, 'class.jlreq does not run in ZeroTeX-NG');
});

test('a name the class lacks refuses with a profile and not without; a package or claim waits while the set is being made', () => {
  const lacks = 'x: needs env:table, which nothing defines (class.letter lacks it)';
  const unknown = 'x: needs cmd:\\maketitle, which nothing defines';
  const pkg = 'x: needs package natbib';
  const profiled = matchClass(cls('letter'), library);
  const none = matchClass(cls('zzqq'), library);
  assert.deepEqual(refusing([lacks, pkg], profiled, true), [lacks]);
  assert.deepEqual(refusing([lacks, pkg], profiled, false), [lacks, pkg]);
  assert.deepEqual(refusing([unknown, pkg], none, false), [pkg]);
});

test('the filter keeps a handler another node can complete, and drops one the class refuses, with its reason', () => {
  const cite = allowedHandlers('cite/cite', matchClass(cls('article'), library), library);
  assert.ok(cite.variants.some((v) => v.key.id === 'bib.natbib'));
  const tables = allowedHandlers('table', matchClass(cls('letter'), library), library);
  assert.ok(tables.filtered.some((f) => /class\.letter lacks it/u.test(f.reason)));
});
