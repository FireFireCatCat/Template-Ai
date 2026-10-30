# Audit of batch b01 (zips 0001 to 0100), run 2026-10-23

Sample: 25 zips, chosen with a fixed seed and stratified (`_tools/results/b01-audit-sample.json`):
10 blind second analyses (6 on a first-analyst `yes`, 4 on a `no`), and 15 skeptics who tried to
refute a `yes` (7 where the look is not carried by a published class, 8 where it is).
Blind analysts never saw the first analyst's file. A disagreement or a refutation that named a
missed blocker went to an adjudicator, who checks the source and edits the Solution file only if
the first analysis was wrong. Raw output: `_tools/results/b01-audit.json`.

| Check | Result |
|---|---|
| Blind second opinion, same verdict as the first analyst | 9 of 10 (the one difference, 0046, went to an adjudicator and the first `yes` stood) |
| Skeptic found a missed blocker | 1 of 15 (0083; the adjudicator ruled it a watermark, not artwork, so the `yes` stood) |
| Verdicts changed after adjudication | 0 of 25 |
| Wrong citations found by skeptics | 0 to 3 per file out of 18 to 90 checked (about 0 to 10%); none changed a verdict |
| Wording "overclaims" listed by skeptics | 4 to 9 per file in 14 of the 15 skeptic files, none changing a verdict |

What this does and does not show. Two independent readers reach the same yes/no on 9 of 10 zips, and
a determined skeptic rarely finds a blocker the first analyst missed. It does **not** show that the
reductions would compile: the skeptics' overclaims are mostly lib lines stretched to a command
they do not name (a penalty parameter under `sp.penalties`, a font switch under `mark.kernel`),
reductions asserted in a sentence and not worked out, and line numbers off by one to three. The
rubric now says a lib line names examples of its type, and analysts must re-check their citations.
A sample of 25 cannot bound the error of the other 900 verdicts.
