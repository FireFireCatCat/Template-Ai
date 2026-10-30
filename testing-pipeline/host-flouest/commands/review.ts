/**
 * `compat review` (ARCHITECTURE.md section 8): the review queue that
 * `compat explain` fills.
 *
 *   npm run compat -- review [--all]                  the latest explanation's candidates still waiting (every one with --all)
 *   npm run compat -- review --show <id>              one candidate: its rule, each failure it explains, its first reproducer as out/review/<id>.tex
 *   npm run compat -- review --accept <id> [--why …]  accept it: the next `compat explain` writes it into its ways' compat tables
 *   npm run compat -- review --reject <id> [--why …]
 *
 * A decision is a line in the `review` log; it never changes the candidate,
 * and a later decision on the same candidate replaces it.
 */
import { mkdirSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';

import { decide, documentCells, documentOf, pairName, reviewAt, reviewQueue, type Candidate } from 'compat-core';

import { n, printCandidates, ruleText } from '../src/report.ts';
import { loadSubject } from '../src/subject.ts';
import { flag, numberOption, openWorkspace, option } from '../src/workspace.ts';

const ws = openWorkspace();
try {
  const show = option('show');
  const accept = option('accept');
  const reject = option('reject');
  if (accept !== undefined || reject !== undefined) {
    const candidate = (accept ?? reject) as string;
    const why = option('why');
    decide(ws.store, { candidate, decision: accept !== undefined ? 'accept' : 'reject', ...(why === undefined ? {} : { why }), at: new Date().toISOString() });
    console.log(`${candidate}: ${accept !== undefined ? 'accepted' : 'rejected'}`);
  } else if (show !== undefined) {
    const candidate = ws.store.get(reviewAt(show)) as unknown as Candidate | undefined;
    if (candidate === undefined) throw new Error(`review: no candidate ${show}`);
    const decision = reviewQueue(ws.store).candidates.find((c) => c.id === show)?.decision;
    console.log(`${candidate.id}  ${ruleText(candidate.rule)}`);
    console.log(`  explains ${n(candidate.count)} branch verdicts; ${decision === undefined ? 'waiting for review' : `${decision.decision}ed ${decision.at}${decision.why === undefined ? '' : `: ${decision.why}`}`}`);
    console.log(JSON.stringify(candidate.rule, null, 2).replace(/^/gm, '  '));
    for (const seen of candidate.seen.slice(0, 12)) {
      console.log(`  ${n(seen.count).padStart(6)}  ${pairName(seen.pair)}  ${seen.symptom.check}: ${seen.evidence.slice(0, 100)}`);
      for (const b of seen.reproducer) console.log(`          ${b.path.map((s) => `${s.node}[${s.variant.way}]`).join(' > ')}`);
    }
    const first = candidate.seen[0];
    if (first !== undefined) {
      const subject = loadSubject(ws.flouest, numberOption('depth', 2)).withWays();
      const classSetting = ws.classSettings.find((c) => c.id === first.pair.classSetting);
      const setup = ws.setups.find((s) => s.id === first.pair.setup);
      if (classSetting !== undefined && setup !== undefined) {
        const [cell] = documentCells(subject.host, documentOf(first.reproducer, subject.host.documentRules()), [classSetting], [setup], ws.classFiles);
        if (cell !== undefined) {
          const folder = join(ws.config.out, 'review');
          mkdirSync(folder, { recursive: true });
          const file = join(folder, `${candidate.id}.tex`);
          writeFileSync(file, cell.job.latex);
          console.log(`  reproducer under ${pairName(first.pair)}: ${file}`);
        }
      }
    }
  } else {
    const queue = reviewQueue(ws.store);
    const waiting = queue.candidates.filter((c) => c.decision === undefined);
    console.log(`review       ${n(queue.candidates.length)} candidates from the explanation of ${queue.at ?? 'nothing yet'}; ${n(waiting.length)} waiting`);
    printCandidates(flag('all') ? queue.candidates : waiting, flag('all') ? Infinity : 40);
  }
} finally {
  await ws.close();
}
