import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'tbl.tabular',
    node: 'table',
    description:
      "The kernel's tabular in a table float: \\begin{tabular}{|p{…}|p{…}|} with \\hline between rows, \\caption and \\label above (General's grid); or l, c, r columns, rules only where asked, \\arraystretch, \\tabcolsep and a size inside the float. 549 templates.",
    ctan: ['latex-base'],
    features: ['floating', 'captioned', 'vertical-rules', 'horizontal-rules'],
    params: {
      colspec: { type: 'enum', values: ['equal', 'l', 'c', 'r', 'first-left'], default: 'equal', description: "the columns: equal p-columns sharing the line (General's), l, c or r for every column, or an l then c" },
      vrules: { type: 'boolean', default: true, description: 'vertical rules between columns and at the edges (|)' },
      rules: { type: 'enum', values: ['all', 'header', 'outer', 'none'], default: 'all', description: '\\hline above, between and below every row; above, under the header and below; above and below; or none' },
      fontSize: { type: 'tex', default: '', description: "the table's size inside its float (\\small); ''" },
      stretch: { type: 'number', default: 1, description: 'row height factor (\\renewcommand{\\arraystretch}{…}); 1 leaves it' },
      colsep: { type: 'dimen', default: '', description: "space either side of a column (\\tabcolsep); ''" },
    },
    presets: PRESETS,
    requires: [
      'env:table',
    ],
    zerotex: 'untested',
  }),
);
