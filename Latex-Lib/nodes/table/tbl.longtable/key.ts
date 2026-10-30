import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'tbl.longtable',
    node: 'table',
    description:
      'longtable: a table that breaks across pages, \\begin{longtable}{…} with its \\caption as the first row, the header row repeated (\\endfirsthead, \\endhead), a "continued" line at each break (\\endfoot); \\hline or booktabs rules; not a float, so not in columns or boxes. 107 templates.',
    ctan: ['longtable'],
    features: ['page-breaking', 'captioned', 'vertical-rules', 'horizontal-rules', 'booktabs-rules'],
    params: {
      colspec: { type: 'enum', values: ['equal', 'l', 'c', 'r', 'first-left'], default: 'equal', description: "the columns: equal p-columns sharing the line (General's), l, c or r for every column, or an l then c" },
      vrules: { type: 'boolean', default: true, description: 'vertical rules between columns and at the edges (|)' },
      rules: { type: 'enum', values: ['hline', 'booktabs', 'none'], default: 'hline', description: '\\hline above, between and below, booktabs rules (loads booktabs), or none' },
      repeatHeader: { type: 'boolean', default: true, description: 'the header row repeated at the top of every page' },
      continued: { type: 'boolean', default: false, description: '"continued" lines at the foot and head of broken pages' },
      fontSize: { type: 'tex', default: '', description: "the table's size inside its float (\\small); ''" },
      stretch: { type: 'number', default: 1, description: 'row height factor (\\renewcommand{\\arraystretch}{…}); 1 leaves it' },
      colsep: { type: 'dimen', default: '', description: "space either side of a column (\\tabcolsep); ''" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'longtable' },
      { pkg: 'booktabs', when: { rules: 'booktabs' } },
    ],
    requires: [
      'env:table',
    ],
    deny: [
      { class: 'class.beamer', reason: 'a frame does not break across slides: a table that does not fit must be split by hand or the frame given allowframebreaks', evidence: [{ kind: 'requirement', file: 'Template/template-requirement/Beamer.md', line: '42' }] },
    ],
    needs: { breakable: true, columns: false, maxBoxDepth: 0 },
    zerotex: 'untested',
  }),
);
