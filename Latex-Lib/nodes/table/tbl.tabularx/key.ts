import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'tbl.tabularx',
    node: 'table',
    description:
      'tabularx: a table of a set width, \\begin{tabularx}{\\linewidth}{|X|X|}, its X columns sharing the room; X ragged or centred (>{\\centering\\arraybackslash}X), a natural-width first column, | and \\hline where asked; in a table float. 126 templates.',
    ctan: ['tabularx'],
    features: ['floating', 'captioned', 'full-width', 'vertical-rules', 'horizontal-rules'],
    params: {
      width: { type: 'string', default: '\\linewidth', description: "the table's width" },
      align: { type: 'enum', values: ['justify', 'left', 'center', 'right'], default: 'justify', description: "the X columns' alignment" },
      firstColumn: { type: 'enum', values: ['X', 'l', 'c', 'r'], default: 'X', description: 'the first column: an X column, or a natural-width one' },
      vrules: { type: 'boolean', default: true, description: 'vertical rules between columns and at the edges (|)' },
      rules: { type: 'enum', values: ['all', 'header', 'outer', 'none'], default: 'all', description: '\\hline above, between and below every row; above, under the header and below; above and below; or none' },
      fontSize: { type: 'tex', default: '', description: "the table's size inside its float (\\small); ''" },
      stretch: { type: 'number', default: 1, description: 'row height factor (\\renewcommand{\\arraystretch}{…}); 1 leaves it' },
      colsep: { type: 'dimen', default: '', description: "space either side of a column (\\tabcolsep); ''" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'tabularx' },
    ],
    requires: [
      'env:table',
    ],
    zerotex: 'yes',
  }),
);
