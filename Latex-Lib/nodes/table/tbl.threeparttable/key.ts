import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'tbl.threeparttable',
    node: 'table',
    description:
      "threeparttable: caption, tabular and notes held to the table's own width, \\begin{threeparttable}\\caption{…} … \\end{threeparttable} in a table float; flushleft or para for the notes, \\hline or booktabs rules. 13 templates.",
    ctan: ['threeparttable'],
    features: ['floating', 'captioned', 'horizontal-rules', 'booktabs-rules', 'table-notes'],
    params: {
      rules: { type: 'enum', values: ['hline', 'booktabs'], default: 'hline', description: 'rules above, under the header and below: \\hline or booktabs (loads booktabs)' },
      notes: { type: 'enum', values: ['normal', 'flushleft', 'para'], default: 'normal', description: 'the table notes: hanging, flush left, or run into a paragraph (the package option)' },
      colspec: { type: 'enum', values: ['equal', 'l', 'c', 'r', 'first-left'], default: 'l', description: "the columns: equal p-columns sharing the line (General's), l, c or r for every column, or an l then c" },
      fontSize: { type: 'tex', default: '', description: "the table's size inside its float (\\small); ''" },
      stretch: { type: 'number', default: 1, description: 'row height factor (\\renewcommand{\\arraystretch}{…}); 1 leaves it' },
      colsep: { type: 'dimen', default: '', description: "space either side of a column (\\tabcolsep); ''" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'threeparttable', when: { notes: 'normal' } },
      { pkg: 'threeparttable', options: ['flushleft'], when: { notes: 'flushleft' } },
      { pkg: 'threeparttable', options: ['para'], when: { notes: 'para' } },
      { pkg: 'booktabs', when: { rules: 'booktabs' } },
    ],
    requires: [
      'env:table',
    ],
    zerotex: 'untested',
  }),
);
