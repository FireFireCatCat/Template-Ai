import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'tbl.nicematrix',
    node: 'table',
    description:
      "A key-value table: tabularray's \\begin{tblr}{colspec={XX}, hlines, vlines} (hline{1,Z}={1pt}, row{1}={font=\\bfseries}, row{even}={bg=…}; spans by \\SetCell[c=2]{c}), or nicematrix's \\begin{NiceTabular}{ll}[hvlines] (\\rowcolors in the \\CodeBefore; spans by \\Block); in a table float. 33 templates.",
    ctan: ['tabularray', 'nicematrix'],
    features: ['floating', 'captioned', 'full-width', 'vertical-rules', 'horizontal-rules', 'booktabs-rules', 'zebra-rows', 'background', 'cell-spans'],
    params: {
      package: { type: 'enum', values: ['tabularray', 'nicematrix'], default: 'tabularray', compat: true, description: 'which package builds the table' },
      colspec: { type: 'enum', values: ['X', 'l', 'c', 'r'], default: 'X', description: 'the columns: X sharing the line (nicematrix with width=\\linewidth), or l, c, r' },
      lines: { type: 'enum', values: ['all', 'horizontal', 'outer', 'three', 'inner', 'none'], default: 'all', description: 'the rules: all; horizontal only; above and below; three booktabs-like rules (tabularray); inner only; none' },
      headerBold: { type: 'boolean', default: false, description: 'tabularray: the first row bold (row{1}={font=\\bfseries})' },
      zebra: { type: 'color', default: '', description: "even rows shaded in this colour; ''" },
      fontSize: { type: 'tex', default: '', description: "the table's size inside its float (\\small); ''" },
      stretch: { type: 'number', default: 1, description: 'row height factor (\\renewcommand{\\arraystretch}{…}); 1 leaves it' },
      colsep: { type: 'dimen', default: '', description: "space either side of a column (\\tabcolsep); ''" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'tabularray', when: { package: 'tabularray' } },
      { pkg: 'nicematrix', when: { package: 'nicematrix' } },
      { pkg: 'xcolor' },
    ],
    requires: [
      'env:table',
    ],
    zerotex: 'untested',
  }),
);
