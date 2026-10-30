import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'note.sidenotes',
    node: 'containerBlock/note',
    description:
      "sidenotes: \\sidenote[number][offset]{…}, a numbered note in the margin as Tufte's books print them; with no offset it floats so notes do not overlap, with one it is fixed beside its line. Loads marginnote and caption. 4 templates.",
    ctan: ['sidenotes'],
    features: ['margin-note', 'numbered', 'superscript'],
    params: {
      offset: { type: 'dimen', default: '', description: "a fixed vertical offset; '' lets the note float" },
      oneside: { type: 'boolean', default: false, description: 'notes always in the right margin (the oneside option)' },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'sidenotes' },
      { pkg: 'sidenotes', options: ['oneside'], when: { oneside: true } },
    ],
    defines: [
      'cmd:\\sidenote',
    ],
    zerotex: 'untested',
  }),
);
