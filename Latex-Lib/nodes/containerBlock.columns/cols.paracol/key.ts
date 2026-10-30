import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'cols.paracol',
    node: 'containerBlock/columns',
    description:
      'paracol: parallel columns side by side, \\begin{paracol}{2} … \\switchcolumn … \\end{paracol}, the blocks shared out across the columns in order; \\columnratio for unequal widths, \\columnseprule and \\colseprulecolor for a rule, all set in the preamble. 14 templates.',
    ctan: ['paracol'],
    features: ['parallel-columns', 'unequal-widths', 'column-rule'],
    params: {
      ratio: { type: 'string', default: '', description: "the first column's share of the width, or several (\\columnratio{0.65}); ''" },
      rule: { type: 'dimen', default: '', description: "a rule between the columns (\\columnseprule); ''" },
      ruleColor: { type: 'color', default: '', description: "the rule's colour (\\colseprulecolor); ''" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'paracol' },
      { pkg: 'xcolor' },
    ],
    gives: { columns: true },
    zerotex: 'untested',
  }),
);
