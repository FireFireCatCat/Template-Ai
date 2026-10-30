/**
 * tbl.tabbing's presets, each from the templates that use it (`node seed.ts tbl --rows`).
 */
import type { Preset } from '../../../schema/params.ts';
import { solution } from '../../evidence.ts';

export const PRESETS = {
  'equal-stops': {
    description: 'Columns at evenly spaced tab stops set by a \\kill line, cells separated by \\>, no rules and no float.',
    features: ['tab-stops'],
    params: {},
    evidence: [solution('0544-china2e', '46'), solution('0648-estamos-ntua-ece-thesis-template', '102')],
  },
  'label-value': {
    description: 'A fixed first stop for labels (\\hspace*{5cm}\\=) and the values after it, as a title page\'s author block.',
    features: ['tab-stops'],
    params: { firstStop: '5cm' },
    evidence: [solution('0669-worksheet', '48')],
  },
} as const satisfies { readonly [name: string]: Preset };
