/**
 * cols.twocolumn-cmd: the kernel's \twocolumn and \onecolumn, each starting
 * a new page; \columnsep for the gap and \columnseprule for a rule, set
 * before the switch.
 * CTAN: https://ctan.org/pkg/latex-base (usrguide, \twocolumn)
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { gapOf } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  return {
    preamble: () => ({}),
    emit: (node, content) => {
      const setup = [`\\setlength{\\columnsep}{${gapOf(node)}}`, ...(param(p, 'rule') === '' ? [] : [`\\setlength{\\columnseprule}{${param(p, 'rule')}}`])];
      return `\n${setup.join('\n')}\n\\twocolumn\n${content.trim()}\n${p['returnToOne'] === false ? '' : '\\onecolumn\n'}`;
    },
  };
};

export default realize;
