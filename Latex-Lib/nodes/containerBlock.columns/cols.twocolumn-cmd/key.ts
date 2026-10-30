import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'cols.twocolumn-cmd',
    node: 'containerBlock/columns',
    description:
      "The kernel's \\twocolumn and \\onecolumn: the block starts a page in two columns and the next page returns to one; \\columnsep from the node and \\columnseprule for a rule. 44 templates.",
    ctan: ['latex-base'],
    features: ['page-columns', 'page-break-before', 'column-rule'],
    params: {
      rule: { type: 'dimen', default: '', description: "a rule between the columns (\\columnseprule); ''" },
      returnToOne: { type: 'boolean', default: true, description: 'back to one column after the block (\\onecolumn, a new page)' },
    },
    presets: PRESETS,
    gives: { columns: true },
    zerotex: 'untested',
  }),
);
