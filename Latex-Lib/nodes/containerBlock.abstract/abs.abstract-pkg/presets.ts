/**
 * abs.abstract-pkg's presets, each from the templates that use it (`node seed.ts abs --rows`)
 * and the manual.
 */
import type { Preset } from '../../../schema/params.ts';
import { manual, solution } from '../../evidence.ts';

export const PRESETS = {
  'sans-small': {
    description: 'The abstract text in small sans-serif without an indent, the heading bold (\\abstracttextfont{\\sffamily\\small}).',
    features: ['small-type', 'sans-serif', 'indented', 'centered'],
    params: { textFont: '\\normalfont\\sffamily\\small' },
    evidence: [solution('0188-elegantpaper', '51')],
  },
  'run-in': {
    description: 'The heading run into the first line of the abstract (the runin option).',
    features: ['small-type', 'run-in-head', 'indented'],
    params: { runIn: true },
    evidence: [manual('abstract', 'package options: runin')],
  },
  'in-contents': {
    description: 'The abstract listed in the table of contents (addtotoc), set at the full width (\\absleftindent and \\absrightindent 0pt).',
    features: ['small-type', 'in-contents', 'centered'],
    params: { inContents: true, indent: '0pt' },
    evidence: [manual('abstract', 'package options: addtotoc; \\absleftindent, \\absrightindent')],
  },
} as const satisfies { readonly [name: string]: Preset };
