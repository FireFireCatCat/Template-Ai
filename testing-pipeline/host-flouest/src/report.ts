/**
 * What the commands print: the plan beside Flouest's own split, a matrix run
 * per class setting and setup, the failures grouped by what they say and the
 * leaf they fell on, where they come from, and what the explainer found.
 */
import { splitTree, type SplitNode } from '@flouest/Template/test/dynamic-testing/splitting.ts';
import {
  attribute,
  pairName,
  variantKey,
  type BranchId,
  type BranchSpec,
  type Candidate,
  type Decision,
  type Group,
  type Origin,
  type Rule,
  type Variant,
  type Verdict,
} from 'compat-core';

import { generalWayId } from './ways.ts';
import type { MatrixRun } from './matrix.ts';
import type { SoloRun } from './solo.ts';
import type { Subject } from './subject.ts';
import { REFERENCE, underName } from './workspace.ts';

export const seconds = (ms: number): string => `${(ms / 1000).toFixed(1)} s`;
export const n = (x: number): string => x.toLocaleString('en-US');
const label = (text: string): string => text.padEnd(12);

/** A General way's variant key, from Flouest's variant of a kind. */
const keyOf = (node: string, v: { readonly packages: readonly string[]; readonly flags: unknown }): string =>
  variantKey({ way: generalWayId(node, v.packages), compat: {}, flags: v.flags as never });

/**
 * The plan beside Flouest's split of the same variants: every branch of its
 * tree must be one of the plan's, node by node and variant by variant, and
 * every member of each variant's cover must be shown.
 */
export const printPlan = ({ general, plan }: Subject): void => {
  const split = splitTree(general.variants.nesting.tree, general.variants.kinds);
  const theirs = new Set<string>();
  const walk = (node: SplitNode, above: string[]): void => {
    const here = [...above, `${node.label}#${node.variant ?? '?'}`];
    if (node.children.length === 0) theirs.add(here.join('>'));
    for (const child of node.children) walk(child, here);
  };
  for (const root of split.tree.slice(0, split.tree.length - split.toppedUp.length)) walk(root, []);
  const index = new Map<string, number>();
  for (const kind of general.variants.kinds) kind.variants.forEach((v, i) => index.set(`${kind.identity.label} ${keyOf(kind.identity.label, v)}`, i));
  const name = (b: BranchSpec): string => b.path.map((s) => `${s.node}#${index.get(`${s.node} ${variantKey(s.variant)}`) ?? '?'}`).join('>');
  const topped = new Set(plan.toppedUp);
  const ours = new Set(plan.branches.filter((b) => !topped.has(b.id)).map(name));
  const missing = [...theirs].filter((s) => !ours.has(s));
  // A branch holding a way Flouest's variants do not know (a library way) is new, not a difference.
  const added = [...ours].filter((s) => !theirs.has(s) && s.includes('#?'));
  const extra = [...ours].filter((s) => !theirs.has(s) && !s.includes('#?'));
  let variants = 0;
  const short: string[] = [];
  for (const kind of general.variants.kinds) {
    for (const v of kind.variants) {
      variants++;
      const shown = new Set(plan.uses.find((u) => u.node === kind.identity.label && u.variant === keyOf(kind.identity.label, v))?.shown ?? []);
      if (!Array.from({ length: Math.min(v.cover, v.members.length) }, (_, i) => i).every((i) => shown.has(i))) short.push(`${kind.identity.label} [${v.packages.join('+')}]`);
    }
  }
  console.log(`${label('plan')} ${n(plan.branches.length)} branches: ${n(ours.size)} of the split, ${n(plan.toppedUp.length)} topped up; ${plan.stranded.length} stranded, ${plan.bare.length} bare`);
  console.log(`${label('Flouest')} ${n(split.branches)} branches: ${n(theirs.size)} of its split, ${split.toppedUp.length} topped up, ${split.stranded.length} stranded`);
  console.log(`${label('same tree')} ${missing.length === 0 && extra.length === 0 ? 'yes' : 'NO'}: every branch of Flouest's split is one of ours, node by node and variant by variant (${missing.length} missing, ${extra.length} extra)${added.length === 0 ? '' : `; ${n(added.length)} more hold a way of the library`}`);
  for (const s of missing.slice(0, 5)) console.log(`  missing ${s}`);
  for (const s of extra.slice(0, 5)) console.log(`  extra   ${s}`);
  console.log(`${label('covers')} ${variants - short.length} of ${variants} variants show every member of their cover${short.length > 0 ? `; short: ${short.join(', ')}` : ''}`);
};

const failing = (verdicts: ReadonlyMap<BranchId, Verdict>): Verdict[] => [...verdicts.values()].filter((v) => !v.pass);

/** One line for the run, then one per class setting and setup: its branches passing and failing, and its commonest checks. */
export const printRun = (title: string, run: MatrixRun): void => {
  console.log(
    `${label(title)} ${run.documents} documents (${run.filed} newly filed, ${run.withBibliography} with a bibliography) × ${run.runs.length} class setting and setup pair(s), emitted in ${seconds(run.emitMs)}; ${n(run.compiled)} compiled, ${n(run.cached)} from the store; ${seconds(run.ms)}`,
  );
  for (const { under, verdicts } of run.runs) {
    const fails = failing(verdicts);
    const checks = new Map<string, number>();
    for (const v of fails) for (const c of new Set(v.failures.map((f) => f.check))) checks.set(c, (checks.get(c) ?? 0) + 1);
    const top = [...checks].sort((a, b) => b[1] - a[1]).slice(0, 4).map(([c, k]) => `${c} ${k}`).join(', ');
    console.log(`  ${underName(under).padEnd(26)} ${n(verdicts.size - fails.length).padStart(6)} pass ${n(fails.length).padStart(6)} fail   ${top}`);
  }
};

/** The commonest failures across the run, by what the log says and the leaf it fell on. */
export const printFailures = (run: MatrixRun, branches: ReadonlyMap<BranchId, BranchSpec>, top = 16): void => {
  const groups = new Map<string, number>();
  for (const { verdicts } of run.runs) {
    for (const v of failing(verdicts)) {
      const own = v.failures.find((f) => !f.check.endsWith(':document')) ?? v.failures[0];
      const leaf = branches.get(v.branch)?.path.at(-1)?.node ?? '?';
      const key = `${(own?.evidence ?? '').replace(/\(l\.\d+\)/, '').replace(/\d+/g, '#').slice(0, 70).padEnd(70)}  ←  ${leaf}`;
      groups.set(key, (groups.get(key) ?? 0) + 1);
    }
  }
  console.log(`${label('failures')} the commonest, counted per branch and class setting:`);
  for (const [key, k] of [...groups].sort((a, b) => b[1] - a[1]).slice(0, top)) console.log(`  ${n(k).padStart(6)}  ${key}`);
};

/**
 * Per class setting and setup, where each failing branch's failures come from
 * (`attribute`): its ways alone (their solo branches fail the same), the class
 * or setup (the branch passes that check under the reference), the document
 * (the log could not tie it to the branch), or the nesting. Then the
 * commonest failures the class and the nesting bring.
 */
export const printOrigins = (run: MatrixRun, solo: SoloRun, branches: ReadonlyMap<BranchId, BranchSpec>, top = 10): void => {
  const reference = run.runs.find((r) => pairName(r.pair) === pairName(REFERENCE));
  console.log(`${label('solo')} ${n(solo.branches)} solo branches × ${run.runs.length} pair(s); ${n(solo.compiled)} compiled, ${n(solo.cached)} from the store; ${seconds(solo.ms)}`);
  console.log(`${label('origins')} each failing branch by its worst failure: from its ways alone · new under the class or setup (vs ${pairName(REFERENCE)}) · not tied to one branch · from the nesting`);
  const groups = new Map<Origin, Map<string, number>>([['class', new Map()], ['nesting', new Map()]]);
  for (const r of run.runs) {
    const name = underName(r.under);
    const counts: Record<Origin, number> = { way: 0, class: 0, document: 0, nesting: 0 };
    for (const v of failing(r.verdicts)) {
      const branch = branches.get(v.branch);
      if (branch === undefined) continue;
      const a = attribute(branch, v, solo.failures.get(name) ?? new Map(), r === reference ? undefined : reference?.verdicts.get(v.branch));
      counts[a.origin]++;
      for (const c of a.checks) {
        const tally = groups.get(c.origin);
        if (tally === undefined) continue;
        const evidence = v.failures.find((f) => f.check.replace(/:document$/, '') === c.check)?.evidence ?? '';
        const where = c.origin === 'class' ? ` [${name}${c.node === undefined ? '' : `, ${c.node} alone too`}]` : '';
        const key = `${c.check.padEnd(26)} ${evidence.replace(/\(l\.\d+\)/, '').replace(/\d+/g, '#').slice(0, 56).padEnd(56)} ← ${branch.path.at(-1)?.node ?? '?'}${where}`;
        tally.set(key, (tally.get(key) ?? 0) + 1);
      }
    }
    console.log(
      `  ${name.padEnd(26)} ${n(counts.way).padStart(6)} ways alone · ${n(counts.class).padStart(6)} class · ${n(counts.document).padStart(6)} document · ${n(counts.nesting).padStart(6)} nesting   (${solo.failing.get(name) ?? 0} of ${n(solo.branches)} solo branches fail)`,
    );
  }
  for (const [origin, tally] of groups) {
    if (tally.size === 0) continue;
    console.log(`${label(origin === 'class' ? 'from class' : 'from nesting')} the commonest checks, counted per branch and class setting:`);
    for (const [key, k] of [...tally].sort((a, b) => b[1] - a[1]).slice(0, top)) console.log(`  ${n(k).padStart(6)}  ${key}`);
  }
};

/** A variant as a person reads it: the way, and its true/false settings when it has any. */
const variantText = (v: Variant): string => {
  const flags = Object.entries(v.flags).map(([k, x]) => `${k}=${JSON.stringify(x)}`);
  return flags.length === 0 ? v.way : `${v.way}{${flags.join(',')}}`;
};

const whenText = (when: Readonly<Record<string, readonly unknown[]>> | undefined): string =>
  when === undefined ? '' : ` when ${Object.entries(when).map(([k, xs]) => `${k} ∈ ${JSON.stringify(xs)}`).join(', ')}`;

/** A candidate rule on one line. */
export const ruleText = (rule: Rule): string => {
  switch (rule.kind) {
    case 'base':
      return `base       a document holding no branch fails: the host's own preamble${rule.pair === undefined ? '' : ` under ${rule.pair}`}`;
    case 'defect':
      return `defect     ${rule.way} fails alone, under the reference too`;
    case 'class':
      return `class      ${rule.way} fails alone under ${rule.pair}`;
    case 'parent': {
      const above = rule.ancestors.map((a) => `${a.node}[${a.variants.map(variantText).join(' | ')}]${whenText(a.when)}`).join(' > ');
      const child = `${rule.child.node}[${rule.child.variants.map(variantText).join(' | ')}]${whenText(rule.child.when)}`;
      const then = rule.verdict === 'fallback' && rule.fallback !== undefined ? `fall back to ${variantText(rule.fallback)}` : 'deny';
      return `parent     ${child} under ${above} (${rule.scope}): ${then}${rule.pair === undefined ? '' : ` [${rule.pair}]`}`;
    }
    case 'combo':
      return `combo      ${rule.ways.map((ways) => `[${ways.join(' > ')}]`).join(' + ')}${rule.pair === undefined ? '' : ` [${rule.pair}]`}`;
    case 'limit':
      return `limit      ${rule.branches} branches together (${rule.nodes.join(', ')})${rule.pair === undefined ? '' : ` [${rule.pair}]`}`;
    case 'unexplained':
      return `unexplained ${rule.check} "${rule.shape}": ${rule.why}`;
  }
};

/** How many failures the explainer has to explain, by where they come from, and the biggest groups. */
export const printGroups = (groups: readonly Group[], solos: number, top = 12): void => {
  const by = new Map<Origin, { groups: number; branches: number }>();
  for (const g of groups) {
    const o = by.get(g.origin) ?? { groups: 0, branches: 0 };
    o.groups++;
    o.branches += g.count;
    by.set(g.origin, o);
  }
  const parts = [...by].map(([origin, o]) => `${origin} ${n(o.groups)} (${n(o.branches)} branch verdicts)`).join(' · ');
  console.log(`${label('to explain')} ${n(groups.length)} groups: ${parts}; and ${n(solos)} failures of solo branches, which are their own reproducers`);
  const all = groups.reduce((k, g) => k + g.count, 0);
  const covered = (first: number): string => `${n(first)} → ${((100 * groups.slice(0, first).reduce((k, g) => k + g.count, 0)) / Math.max(all, 1)).toFixed(1)}%`;
  console.log(`${label('coverage')} the biggest groups, and the share of branch verdicts they stand for: ${[10, 100, 300, 1000, 3000].filter((k) => k < groups.length).map(covered).join(', ')}`);
  for (const g of groups.slice(0, top)) {
    const where = g.case.symptom.tied ? g.case.branch.path.map((s) => s.node).join(' > ') : 'the document';
    console.log(`  ${n(g.count).padStart(6)}  ${pairName(g.case.pair).padEnd(24)} ${g.case.symptom.check.padEnd(24)} ${g.case.symptom.shape.slice(0, 56).padEnd(56)} ← ${where}`);
  }
};

/** The candidates, the most explained first, each with where it was seen first. */
export const printCandidates = (candidates: readonly (Candidate & { readonly decision?: Decision })[], top = 30): void => {
  const by = new Map<string, { candidates: number; branches: number }>();
  for (const c of candidates) {
    const k = by.get(c.rule.kind) ?? { candidates: 0, branches: 0 };
    k.candidates++;
    k.branches += c.count;
    by.set(c.rule.kind, k);
  }
  console.log(`${label('candidates')} ${n(candidates.length)}: ${[...by].map(([kind, k]) => `${kind} ${n(k.candidates)} (${n(k.branches)})`).join(' · ')}`);
  for (const c of candidates.slice(0, top)) {
    const first = c.seen[0];
    const status = c.decision === undefined ? '' : ` [${c.decision.decision}ed]`;
    console.log(`  ${n(c.count).padStart(6)}  ${c.id}  ${ruleText(c.rule)}${status}`);
    if (first !== undefined) console.log(`  ${''.padStart(6)}  ${''.padEnd(c.id.length)}    ${first.symptom.check}: ${first.evidence.slice(0, 90)} (${pairName(first.pair)})`);
  }
};
