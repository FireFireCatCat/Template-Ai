/**
 * fig.wrapfig's presets, each from the templates that use it (`node seed.ts fig --rows`).
 */
import type { Preset } from '../../../schema/params.ts';
import { solution } from '../../evidence.ts';

export const PRESETS = {
  right: {
    description: 'The text wraps round an image at the right, a quarter of the text wide, \\begin{wrapfigure}{r}{0.25\\textwidth}.',
    features: ['wrapped', 'captioned', 'scaled'],
    params: { side: 'r', width: '0.25\\textwidth' },
    evidence: [solution('0169-open-source-uc-latex-templates', '72'), solution('0166-retosmatematicos', '63')],
  },
  left: {
    description: 'The image at the left, 0.45 of the text wide, the text wrapping on its right (\\begin{wrapfigure}{l}{.45\\textwidth}).',
    features: ['wrapped', 'captioned', 'scaled'],
    params: { side: 'l', width: '0.45\\textwidth' },
    evidence: [solution('0021-elife', '53')],
  },
  'outer-raised': {
    description: 'The image at the outer edge of two-sided pages (o), pulled up 4.5mm against the paragraph above.',
    features: ['wrapped', 'captioned', 'scaled'],
    params: { side: 'o', width: '40mm', raise: '4.5mm' },
    evidence: [solution('0166-retosmatematicos', '63')],
  },
} as const satisfies { readonly [name: string]: Preset };
