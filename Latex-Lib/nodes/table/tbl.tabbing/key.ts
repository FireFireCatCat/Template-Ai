import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'tbl.tabbing',
    node: 'table',
    description:
      "The kernel's tabbing: columns at tab stops set by a first line ended with \\kill, cells separated by \\>, no rules, no float, no caption. 3 templates.",
    ctan: ['latex-base'],
    features: ['tab-stops'],
    params: {
      firstStop: { type: 'dimen', default: '', description: "a fixed width for the first column (\\hspace*{5cm}\\=); '' shares the line" },
    },
    presets: PRESETS,
    zerotex: 'untested',
  }),
);
