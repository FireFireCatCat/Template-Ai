/**
 * The check (ARCHITECTURE.md section 2, step 3): a target document against the
 * library's vocabulary, before the search reads it. Every node is one of
 * Flouest's, every feature is in the vocabulary, every parameter is one some
 * handler of the node has and its value fits that parameter, every package is
 * a package name, every key carries evidence. Each problem is one sentence
 * naming where it is; the model gets them back with its answer.
 */
import { EVIDENCE_KINDS } from '../../../Latex-Lib/schema/evidence.ts';
import { FEATURES } from '../../../Latex-Lib/schema/features.ts';
import { DOC_NODE, PACKAGE_ID } from '../../../Latex-Lib/schema/ids.ts';
import { paramProblem } from '../../../Latex-Lib/schema/params.ts';
import type { Library } from '../../../Latex-Lib/schema/validate.ts';
import type { Nesting } from '../../../Latex-Lib/nesting.ts';

import { CONFIDENCE, TIERS, type TargetDocument, type TargetKey } from '../model.ts';

export const checkTarget = (doc: TargetDocument, library: Library, nesting: Nesting): string[] => {
  const problems: string[] = [];
  const at = doc.source.id;

  const cls = doc.class;
  if (cls.name.trim() === '') problems.push(`${at} class: no name`);
  if (cls.local?.loads != null && cls.local.loads.trim() === '') problems.push(`${at} class: loads a class with no name`);
  if (cls.evidence.length === 0) problems.push(`${at} class: no evidence`);

  const key = (k: TargetKey, where: string, documentLevel: boolean): void => {
    if (documentLevel ? k.node !== DOC_NODE : nesting.nodes[k.node] === undefined) {
      problems.push(`${where}: ${documentLevel ? `a document-level key's node is ${k.node}, not ${DOC_NODE}` : `node ${k.node} is not in Flouest's nesting list`}`);
    }
    for (const f of k.features) if (!(FEATURES as readonly string[]).includes(f)) problems.push(`${where}: feature ${f} is not in the vocabulary`);
    const handlers = library.keys.filter((h) => h.node === k.node);
    for (const [name, value] of Object.entries(k.params)) {
      const specs = handlers.flatMap((h) => h.params[name] ?? []);
      if (specs.length === 0) problems.push(`${where}: no handler of ${k.node} has a parameter ${name}`);
      else if (specs.every((spec) => paramProblem(spec, value) !== undefined)) problems.push(`${where}: ${name} = ${JSON.stringify(value)} ${paramProblem(specs[0]!, value)}`);
    }
    for (const p of k.packages) if (!PACKAGE_ID.test(p.pkg)) problems.push(`${where}: package ${p.pkg} is not a package name`);
    if (k.evidence.length === 0) problems.push(`${where}: no evidence`);
    for (const e of k.evidence) if (!(EVIDENCE_KINDS as readonly string[]).includes(e.kind)) problems.push(`${where}: evidence of unknown kind ${e.kind}`);
    if (!CONFIDENCE.includes(k.confidence)) problems.push(`${where}: confidence ${k.confidence} is not high, medium or low`);
    if (k.tier !== undefined && !TIERS.includes(k.tier)) problems.push(`${where}: tier ${k.tier} is not one of ${TIERS.join(', ')}`);
  };
  doc.nodes.forEach((k, i) => key(k, `${at} node ${i + 1} (${k.node})`, false));
  doc.document.forEach((k, i) => key(k, `${at} document ${i + 1}`, true));
  return problems;
};
