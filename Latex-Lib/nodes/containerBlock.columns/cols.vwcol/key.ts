import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'cols.vwcol',
    node: 'containerBlock/columns',
    description:
      'vwcol: columns of chosen widths that paragraph text flows through, \\begin{vwcol}[widths={0.5,0.5}, sep=1.5em] … \\end{vwcol}; equal, wide-first or wide-last widths. 2 templates.',
    ctan: ['vwcol'],
    features: ['balanced-columns', 'unequal-widths'],
    params: {
      widths: { type: 'enum', values: ['equal', 'wide-first', 'wide-last'], default: 'equal', description: "the columns' widths: equal, the first wide, or the last wide" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'vwcol' },
    ],
    gives: { columns: true },
    zerotex: 'untested',
  }),
);
