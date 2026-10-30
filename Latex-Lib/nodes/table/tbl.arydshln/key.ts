import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'tbl.arydshln',
    node: 'table',
    description:
      'arydshln: dashed rules, \\hdashline between rows and ;{2pt/3pt} between columns, \\dashlinedash and \\dashlinegap for the dashes, solid \\hline at the edges when asked; in a tabular in a table float. 5 templates.',
    ctan: ['arydshln'],
    features: ['floating', 'captioned', 'dashed-rules', 'horizontal-rules'],
    params: {
      vertical: { type: 'boolean', default: true, description: 'dashed rules between columns too' },
      outer: { type: 'enum', values: ['dashed', 'solid'], default: 'dashed', description: 'the top and bottom rules dashed, or solid \\hline' },
      dash: { type: 'dimen', default: '', description: "a dash's length (\\dashlinedash); ''" },
      gap: { type: 'dimen', default: '', description: "a gap's length (\\dashlinegap); ''" },
      colspec: { type: 'enum', values: ['equal', 'l', 'c', 'r', 'first-left'], default: 'l', description: "the columns: equal p-columns sharing the line (General's), l, c or r for every column, or an l then c" },
      fontSize: { type: 'tex', default: '', description: "the table's size inside its float (\\small); ''" },
      stretch: { type: 'number', default: 1, description: 'row height factor (\\renewcommand{\\arraystretch}{…}); 1 leaves it' },
      colsep: { type: 'dimen', default: '', description: "space either side of a column (\\tabcolsep); ''" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'arydshln' },
    ],
    requires: [
      'env:table',
    ],
    zerotex: 'untested',
  }),
);
