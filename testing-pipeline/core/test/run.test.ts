import assert from 'node:assert/strict';
import { test } from 'node:test';

import { looseDocumentId } from '../src/ids.ts';
import type { Cell, ClassSetting, Job, RawResult } from '../src/model.ts';
import type { Engine } from '../src/ports.ts';
import { resultAt, runCells } from '../src/run.ts';
import { MemoryStore } from '../src/memoryStore.ts';
import { FakeEngine } from './fakeEngine.ts';
import { FakeHost } from './fakeHost.ts';
import { FakeLibrary } from './fakeLibrary.ts';
import { AMSART, ARTICLE, cellsOf, MANUSCRIPT, packed, planOf, SETUP_A } from './fakeRun.ts';

const host = new FakeHost();
const branches = planOf(host, new FakeLibrary(), 1).branches.slice(0, 4);
const documents = packed(host, branches, 4);

test('a cell compiles once, then comes from the store', async () => {
  const store = new MemoryStore();
  const engine = new FakeEngine();
  const jobs = cellsOf(host, documents, [ARTICLE], [SETUP_A]);
  const first = await runCells(store, engine, jobs);
  const second = await runCells(store, engine, jobs);
  assert.deepEqual(first.map((o) => o.cached), [false]);
  assert.deepEqual(second.map((o) => o.cached), [true]);
  assert.equal(engine.compiles, 1);
  assert.deepEqual(second[0]?.result, first[0]?.result);
  assert.ok(store.get(resultAt(first[0]?.key ?? '')) !== undefined);
});

test('cells with the same LaTeX share one compile', async () => {
  const store = new MemoryStore();
  const engine = new FakeEngine();
  const job: Job = { id: 'x', latex: '\\documentclass{article}\n', files: [] };
  const cell = (id: string): Cell => ({ id, document: looseDocumentId(id), classSetting: 'article', setup: 'A' });
  const outcomes = await runCells(store, engine, [
    { cell: cell('c1'), job: { ...job, id: 'c1' } },
    { cell: cell('c2'), job: { ...job, id: 'c2' } },
  ]);
  assert.equal(engine.compiles, 1);
  assert.equal(outcomes[0]?.key, outcomes[1]?.key);
});

test('changing one class setting compiles only that cell again', async () => {
  const store = new MemoryStore();
  const engine = new FakeEngine();
  const settings: ClassSetting[] = [ARTICLE, AMSART, MANUSCRIPT];
  await runCells(store, engine, cellsOf(host, documents, settings, [SETUP_A]));
  assert.equal(engine.compiles, 3);
  const changed = settings.map((s) => (s.id === 'amsart' ? { ...s, options: ['reqno'] } : s));
  const outcomes = await runCells(store, engine, cellsOf(host, documents, changed, [SETUP_A]));
  assert.equal(engine.compiles, 4);
  assert.deepEqual(
    outcomes.map((o) => [o.cell.classSetting, o.cached]),
    [['article', true], ['amsart', false], ['acmart-manuscript', true]],
  );
});

/** An engine that fails on its first `failures` compiles: by throwing, or by reporting that it gave no result. */
class FlakyEngine implements Engine {
  calls = 0;
  readonly failures: number;
  readonly how: 'throw' | 'report';
  constructor(failures: number, how: 'throw' | 'report') {
    this.failures = failures;
    this.how = how;
  }
  fingerprint(): string {
    return 'flaky-1';
  }
  async compile(): Promise<RawResult> {
    this.calls += 1;
    if (this.calls <= this.failures) {
      if (this.how === 'throw') throw new Error('Chrome went away');
      return { log: '', pages: null, ms: 0, threw: 'package could not be fetched' };
    }
    return { log: 'Output written on main.xdv (1 page, 10 bytes).\n', pages: 1, ms: 5 };
  }
  async close(): Promise<void> {}
}

for (const how of ['throw', 'report'] as const) {
  test(`a result the engine could not give (${how}) is not saved, so the next run tries again`, async () => {
    const store = new MemoryStore();
    const engine = new FlakyEngine(1, how);
    const jobs = cellsOf(host, documents, [ARTICLE], [SETUP_A]);
    const first = await runCells(store, engine, jobs);
    assert.ok(first[0]?.result.threw);
    assert.equal(store.count('results/'), 0);
    const second = await runCells(store, engine, jobs);
    assert.equal(second[0]?.cached, false);
    assert.equal(second[0]?.result.threw, undefined);
    assert.equal(store.count('results/'), 1);
    assert.equal(engine.calls, 2);
  });
}
