import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'tbl.colortbl',
    node: 'table',
    description:
      'xcolor with its table option (colortbl): alternate rows shaded, \\rowcolors{2}{gray!12}{white}; a header band (\\rowcolor, white text), \\arrayrulecolor, \\hline where asked; in a tabular in a table float. 81 templates.',
    ctan: ['colortbl', 'xcolor'],
    features: ['floating', 'captioned', 'zebra-rows', 'background', 'colored', 'horizontal-rules'],
    params: {
      odd: { type: 'color', default: 'gray!12', description: "the first striped row's colour and every second after (\\rowcolors); '' with even '' for no stripes" },
      even: { type: 'color', default: 'white', description: "the other rows' colour" },
      start: { type: 'number', default: 2, description: 'the row the stripes start at' },
      headerColor: { type: 'color', default: '', description: "the header row's band (\\rowcolor); ''" },
      headerText: { type: 'color', default: '', description: "the header text's colour; ''" },
      ruleColor: { type: 'color', default: '', description: "the rules' colour (\\arrayrulecolor); ''" },
      colspec: { type: 'enum', values: ['equal', 'l', 'c', 'r', 'first-left'], default: 'equal', description: "the columns: equal p-columns sharing the line (General's), l, c or r for every column, or an l then c" },
      vrules: { type: 'boolean', default: false, description: 'vertical rules between columns and at the edges (|)' },
      rules: { type: 'enum', values: ['all', 'header', 'outer', 'none'], default: 'none', description: '\\hline above, between and below every row; above, under the header and below; above and below; or none' },
      fontSize: { type: 'tex', default: '', description: "the table's size inside its float (\\small); ''" },
      stretch: { type: 'number', default: 1, description: 'row height factor (\\renewcommand{\\arraystretch}{…}); 1 leaves it' },
      colsep: { type: 'dimen', default: '', description: "space either side of a column (\\tabcolsep); ''" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'xcolor', options: ['table'] },
    ],
    requires: [
      'env:table',
    ],
    deny: [
      { class: 'class.beamer', reason: 'beamer loads xcolor itself, so \\usepackage[table]{xcolor} clashes; the class option xcolor=table is the way there', evidence: [{ kind: 'requirement', file: 'Template/template-requirement/Beamer.md', line: '92' }, { kind: 'requirement', file: 'Template/template-requirement/Beamer.md', line: '33' }] },
    ],
    zerotex: 'yes',
  }),
);
