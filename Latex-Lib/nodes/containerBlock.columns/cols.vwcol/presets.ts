/**
 * cols.vwcol's presets, each from the templates that use it (`node seed.ts cols --rows`).
 */
import type { Preset } from '../../../schema/params.ts';
import { solution } from '../../evidence.ts';

export const PRESETS = {
  equal: {
    description: 'Columns of equal width that the text flows through, \\begin{vwcol}[widths={0.5,0.5}, sep=…].',
    features: ['balanced-columns'],
    params: {},
    evidence: [solution('0091-hcbundle', '63')],
  },
  'wide-first': {
    description: 'A wide first column and narrower ones after it (two columns: 0.6 and 0.4; three: 0.5, 0.25, 0.25).',
    features: ['balanced-columns', 'unequal-widths'],
    params: { widths: 'wide-first' },
    evidence: [solution('0091-hcbundle', '63')],
  },
} as const satisfies { readonly [name: string]: Preset };
