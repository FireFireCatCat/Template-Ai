/**
 * note.notecolumn's presets, from the template that uses it (`node seed.ts note --rows`).
 */
import type { Preset } from '../../../schema/params.ts';
import { solution } from '../../evidence.ts';

export const PRESETS = {
  margin: {
    description: "KOMA's note column in the margin, \\makenote{…}: notes set beside the text and kept in step with it across pages.",
    features: ['margin-note', 'note-column'],
    params: {},
    evidence: [solution('0020-koma-script', '72')],
  },
  'colored-column': {
    description: 'A note column of its own, ragged footnote-size blue text (\\DeclareNewNoteColumn[font=\\raggedright\\footnotesize\\color{blue}]{notes}).',
    features: ['margin-note', 'note-column', 'colored', 'small-type'],
    params: { column: 'notes', font: '\\raggedright\\footnotesize\\color{blue}' },
    evidence: [solution('0020-koma-script', '84')],
  },
} as const satisfies { readonly [name: string]: Preset };
