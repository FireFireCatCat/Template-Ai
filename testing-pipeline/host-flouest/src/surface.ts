/**
 * What General's LaTeX asks of a class: every package line it writes, every
 * name it defines and every name it redefines. All three are read from the
 * LaTeX of the empty document and of every combination of settings and looks
 * that Flouest's own dynamic tests build (`buildVariants`, compiler only, no
 * TeX).
 *
 * The class probe asks every class for exactly this (`compat probe`), until
 * the library's own keys (`Way.loads`, `Way.defines`) say it.
 */
import { dirname, join } from 'node:path';

import { docJsonToLatex } from '@flouest/app/src/lib/latex.ts';
import { buildVariants } from '@flouest/Template/test/dynamic-testing/variants.ts';
import type { PackageLoad } from 'compat-core';

import { quietly } from './quiet.ts';

export type GeneralSurface = {
  /** Each distinct package line, by name and options, in first-seen order. */
  readonly packages: readonly PackageLoad[];
  /** Names General's LaTeX defines (`env:theorem`, `cmd:email`, `counter:x`): a class that already has one clashes. */
  readonly defines: readonly string[];
  /** Names it redefines: a class that lacks one breaks it. */
  readonly redefines: readonly string[];
  /** How many LaTeX documents they were read from. */
  readonly documents: number;
};

const USE = /\\(?:usepackage|RequirePackage)(?:\[([^\]]*)\])?\{([^}]*)\}/g;

const DEFINES: readonly (readonly [RegExp, string])[] = [
  [/\\(?:newcommand|DeclareRobustCommand|DeclareMathOperator|newlength)\*?\{?\\([A-Za-z@]+)/g, 'cmd'],
  [/\\(?:newenvironment|newtheorem|newtcolorbox|newtcbtheorem)\*?\{([A-Za-z@]+)\}/g, 'env'],
  [/\\newcounter\{([A-Za-z@]+)\}/g, 'counter'],
];

const REDEFINES: readonly (readonly [RegExp, string])[] = [
  [/\\renewcommand\*?\{?\\([A-Za-z@]+)/g, 'cmd'],
  [/\\renewenvironment\*?\{([A-Za-z@]+)\}/g, 'env'],
];

const preambleOf = (latex: string): string => latex.split('\\begin{document}')[0] ?? latex;


export const generalSurface = (flouest: string): GeneralSurface => {
  const tests = join(flouest, 'Template/test/dynamic-testing');
  const variants = quietly(() => buildVariants({ template: 'general', maxDepth: 2, samples: [dirname(tests)], skip: tests }));
  const empty = quietly(() => docJsonToLatex({ type: 'doc', content: [{ type: 'paragraph', attrs: { kind: 'paragraph' }, content: [] }] }, null, {}));
  const documents = [
    ...(empty.ok ? [empty.latex] : []),
    ...variants.kinds.flatMap((kind) => kind.combinations.flatMap((c) => (c.outcome.status === 'compiled' ? [c.outcome.latex] : []))),
  ];

  const packages = new Map<string, PackageLoad>();
  const defines = new Set<string>();
  const redefines = new Set<string>();
  for (const latex of documents) {
    const preamble = preambleOf(latex);
    for (const m of preamble.matchAll(USE)) {
      const options = (m[1] ?? '').split(',').map((o) => o.trim()).filter((o) => o !== '');
      for (const name of (m[2] ?? '').split(',').map((n) => n.trim()).filter((n) => n !== '')) {
        const spelling = options.length > 0 ? `${name}[${options.join(',')}]` : name;
        if (!packages.has(spelling)) packages.set(spelling, { name, options });
      }
    }
    for (const [pattern, kind] of DEFINES) for (const m of latex.matchAll(pattern)) defines.add(`${kind}:${m[1]}`);
    for (const [pattern, kind] of REDEFINES) for (const m of latex.matchAll(pattern)) redefines.add(`${kind}:${m[1]}`);
  }
  return { packages: [...packages.values()], defines: [...defines].sort(), redefines: [...redefines].sort(), documents: documents.length };
};
