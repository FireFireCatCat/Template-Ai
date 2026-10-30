/**
 * head.sectsty: \allsectionsfont{…} for a look every level shares, or
 * \<level>font{…} per level when the sizes are set; alignment through
 * \raggedright, \centering (with \nohang) or \raggedleft, never on the run-in
 * paragraph levels; \underline last when underlined.
 * CTAN: https://ctan.org/pkg/sectsty (sections 2, 3 and 5)
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { colorOf, headingCommand, levelOf, numberingLines, sizeOf, type Level } from '../node.ts';
import key from './key.ts';

const ALIGN: { readonly [align: string]: string } = { class: '', left: '\\raggedright', center: '\\nohang\\centering', right: '\\raggedleft' };

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const scale = param(p, 'scale', 'class');
  const look = (level: Level | undefined): string => {
    const runIn = level === 'paragraph' || level === 'subparagraph';
    return `${param(p, 'font')}${level === undefined ? '' : sizeOf(scale, level)}${colorOf(p)}${runIn ? '' : ALIGN[param(p, 'align', 'class')] ?? ''}${p['underline'] === true ? '\\underline' : ''}`;
  };
  const packages = ['\\usepackage{sectsty}', ...(colorOf(p) === '' ? [] : ['\\usepackage{xcolor}'])];
  return {
    preamble: (_params, _parentType, node) => {
      if (node === undefined) return { packages };
      const level = levelOf(node);
      const font = scale === 'class' ? `\\allsectionsfont{${look(undefined)}}` : `\\${level}font{${look(level)}}`;
      return { packages, declarations: [...numberingLines(p, level), font] };
    },
    emit: (node, content) => headingCommand(node, content),
  };
};

export default realize;
