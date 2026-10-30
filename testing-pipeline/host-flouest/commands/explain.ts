/**
 * `compat explain` (ARCHITECTURE.md section 8): each failure the matrix shows,
 * explained down to a candidate rule with a minimal reproducer, into the
 * review queue; then each way's compat table.
 *
 *   npm run compat -- explain [--classes id,id] [--setups A,B] [--depth 2] [--size 64] [--library] [--limit 1000] [--groups]
 *
 * The matrix and the solo branches run first, through the store, so after
 * `compat run` they compile nothing. Failures are grouped (`groupFailures`)
 * and the biggest `--limit` groups explained, several at a time; `--groups`
 * only lists them. A failure the way shows alone needs no trial: its solo
 * branch is the reproducer. Every candidate goes to the review queue
 * (`compat review`), and every way's compat table to `out/compat/`, with the
 * rules a person has accepted. An explanation is saved, so explaining again
 * with the same host and engine runs no trial.
 */
import { join, resolve } from 'node:path';

import {
  candidateId,
  candidatesOf,
  canonical,
  compatTables,
  countOf,
  explainer,
  groupFailures,
  hashJson,
  hostTrials,
  ORACLE_VERSION,
  pairName,
  queueCandidates,
  reviewQueue,
  soloExplanations,
  type Explanation,
} from 'compat-core';

import { latexLibWays } from '../src/latexLib.ts';
import { branchIndex, runMatrix } from '../src/matrix.ts';
import { n, printCandidates, printGroups, printRun, seconds } from '../src/report.ts';
import { runSolo } from '../src/solo.ts';
import { loadSubject } from '../src/subject.ts';
import { flag, numberOption, openWorkspace, REFERENCE, underName } from '../src/workspace.ts';

const depth = numberOption('depth', 2);
const size = numberOption('size', 64);
const limit = numberOption('limit', 1000);
/** Cases explained at once: each runs its trials one after another, so several keep the engines busy. */
const AT_ONCE = 12;

const ws = openWorkspace();
if (!ws.under.some((u) => underName(u) === pairName(REFERENCE))) {
  console.error(`compat explain: ${pairName(REFERENCE)}, which every other is compared with, must be among --classes and --setups`);
  process.exit(1);
}
const compat = join(ws.config.out, 'compat');
const libraryRoot = flag('library') ? resolve(ws.config.root, String(ws.config.host['library'] ?? '../Latex-Lib')) : undefined;
const subject = loadSubject(ws.flouest, depth, compat, libraryRoot).withWays(flag('library') ? await latexLibWays(ws) : []);
try {
  const run = await runMatrix(ws, subject, { size });
  printRun('matrix', run);
  const solo = await runSolo(ws, subject);
  console.log(`${'solo'.padEnd(12)} ${n(solo.branches)} solo branches × ${run.runs.length} pair(s); ${n(solo.compiled)} compiled, ${n(solo.cached)} from the store; ${seconds(solo.ms)}`);
  const { groups, fromWays } = groupFailures({
    runs: run.runs,
    branches: branchIndex(subject),
    documentOf: (id) => run.byBranch.get(id),
    solo: (pair) => solo.failures.get(pairName(pair)) ?? new Map(),
    reference: REFERENCE,
  });
  const fromSolos = soloExplanations(solo.verdicts, REFERENCE);
  printGroups(groups, fromSolos.length);

  if (!flag('groups')) {
    const started = performance.now();
    const engine = await ws.engine();
    const { host, library } = subject;
    const trials = hostTrials({ host, store: ws.store, engine, rules: host.documentRules(), classSettings: ws.classSettings, setups: ws.setups, classFiles: ws.classFiles });
    const { explain } = explainer({
      trial: trials.trial,
      nesting: host.nesting(depth),
      variantsOf: (node) => host.variants(node, library.ways(node)),
      reference: REFERENCE,
      saved: { store: ws.store, fingerprint: canonical({ host: host.fingerprint(), engine: engine.fingerprint() }) },
    });

    const picked = groups.slice(0, limit);
    const explained: { explanation: Explanation; count: number }[] = [];
    let next = 0;
    let saved = 0;
    let tried = 0;
    const work = async (): Promise<void> => {
      for (let i = next++; i < picked.length; i = next++) {
        const group = picked[i];
        if (group === undefined) continue;
        const { saved: wasSaved, ...explanation } = await explain(group.case);
        explained[i] = { explanation, count: group.count };
        if (wasSaved) saved++;
        else tried += explanation.trials;
        const done = explained.filter(Boolean).length;
        if (done % 25 === 0 || done === picked.length) console.log(`  explained ${n(done)} of ${n(picked.length)}: ${n(saved)} saved before, ${n(tried)} trials, ${n(trials.compiled())} compiled`);
      }
    };
    await Promise.all(Array.from({ length: AT_ONCE }, work));

    // A rule from the solo branches counts its branch verdicts once, however many solo failures show it.
    const counted = new Set<string>();
    const solos = fromSolos.map((explanation) => {
      const id = candidateId(explanation.rule);
      const count = counted.has(id) ? 0 : countOf(fromWays, explanation.rule);
      counted.add(id);
      return { explanation, count };
    });
    queueCandidates(ws.store, candidatesOf([...explained.filter(Boolean), ...solos]), new Date().toISOString());
    const queue = reviewQueue(ws.store);
    console.log(`${'explain'.padEnd(12)} ${n(picked.length)} of ${n(groups.length)} groups in ${seconds(performance.now() - started)}: ${n(saved)} saved before, ${n(tried)} trials, ${n(trials.compiled())} compiled`);
    printCandidates(queue.candidates);

    const tables = compatTables({
      ways: library.all.map((w) => w.id),
      branches: subject.plan.branches,
      runs: run.runs,
      candidates: queue.candidates,
      from: { plan: hashJson(subject.plan.branches.map((b) => b.id)), host: host.fingerprint(), engine: engine.fingerprint(), oracle: String(ORACLE_VERSION) },
    });
    for (const table of tables) if (table.entries.length > 0) library.writeCompat(table);
    console.log(`${'compat'.padEnd(12)} ${n(library.written.length)} tables written to ${compat}`);
  }
} finally {
  await ws.close();
}
