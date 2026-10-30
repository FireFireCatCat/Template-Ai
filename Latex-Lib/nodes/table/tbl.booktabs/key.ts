import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'tbl.booktabs',
    node: 'table',
    description:
      "booktabs: \\toprule, \\midrule under a header row, \\bottomrule, no vertical rules, in a tabular in a table float; \\heavyrulewidth and \\lightrulewidth for the rules' weights, \\addlinespace between body rows. 283 templates.",
    ctan: ['booktabs'],
    features: ['floating', 'captioned', 'booktabs-rules'],
    params: {
      colspec: { type: 'enum', values: ['equal', 'l', 'c', 'r', 'first-left'], default: 'equal', description: "the columns: equal p-columns sharing the line (General's), l, c or r for every column, or an l then c" },
      rowSpace: { type: 'boolean', default: false, description: 'space between body rows (\\addlinespace)' },
      heavyRule: { type: 'dimen', default: '', description: "top and bottom rules' width (\\heavyrulewidth); ''" },
      lightRule: { type: 'dimen', default: '', description: "the mid rule's width (\\lightrulewidth); ''" },
      fontSize: { type: 'tex', default: '', description: "the table's size inside its float (\\small); ''" },
      stretch: { type: 'number', default: 1, description: 'row height factor (\\renewcommand{\\arraystretch}{…}); 1 leaves it' },
      colsep: { type: 'dimen', default: '', description: "space either side of a column (\\tabcolsep); ''" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'booktabs' },
    ],
    requires: [
      'env:table',
    ],
    zerotex: 'yes',
  }),
);
