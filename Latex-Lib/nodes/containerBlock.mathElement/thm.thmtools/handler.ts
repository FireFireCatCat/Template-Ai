/**
 * thm.thmtools: one `\declaretheoremstyle` (and an upright twin), then
 * `\declaretheorem` per kind, numbered within a counter or as a sibling.
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { amsStyleOf, declarations, displayName, elementOf, environmentOf, numberingOf, statementIn, text, type Element } from '../statement.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const params = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const numbering = numberingOf(params);
  const upright = params['uprightKinds'] !== false;
  const qed = text(params, 'qed', '');
  const style = (name: string, bodyFont: string): string =>
    `\\declaretheoremstyle[${[
      `spaceabove=${text(params, 'spaceAbove', '\\topsep')}`,
      `spacebelow=${text(params, 'spaceBelow', '\\topsep')}`,
      `headfont=${text(params, 'headFont', '\\bfseries')}`,
      `bodyfont=${bodyFont}`,
      `headpunct={${text(params, 'headPunct', '.')}}`,
      `postheadspace=${text(params, 'postHeadSpace', '.5em')}`,
      ...(qed === '' ? [] : [`qed={${qed}}`]),
    ].join(', ')}]{${name}}`;
  const styleOf = (element: Element): string => (upright && amsStyleOf(element) !== 'plain' ? 'libthmupright' : 'libthm');
  return {
    preamble: (_p, _parent, node) => {
      const packages = ['\\usepackage{amsthm}', '\\usepackage{thmtools}'];
      if (node === undefined) return { packages };
      return {
        packages,
        declarations: [
          style('libthm', text(params, 'bodyFont', '\\itshape')),
          ...(upright ? [style('libthmupright', '\\normalfont')] : []),
          ...declarations(elementOf(node), numbering, (env, element, counter) => {
            const numbered = 'shared' in counter ? [`sibling=${counter.shared}`] : counter.within === 'none' ? [] : [`numberwithin=${counter.within}`];
            return `\\declaretheorem[${[`style=${styleOf(element)}`, `name=${displayName(element)}`, ...numbered].join(', ')}]{${env}}`;
          }),
        ],
      };
    },
    emit: (node, content, note) => statementIn(environmentOf(elementOf(node), numbering.rename === 'yes'), node, content, note),
  };
};

export default realize;
