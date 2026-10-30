import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'note.marginpar',
    node: 'containerBlock/note',
    description:
      "The kernel's \\marginpar{…}: a note in the margin, itself a float, so not inside another float, a box or a footnote. \\reversemarginpar for the other margin, \\marginparwidth and \\marginparsep for the column. 56 templates.",
    ctan: ['latex-base'],
    features: ['margin-note', 'small-type'],
    params: {
      side: { type: 'enum', values: ['outer', 'reverse'], default: 'outer', description: "the margin: the class's (outer), or the other one (\\reversemarginpar, for the whole document)" },
      font: { type: 'tex', default: '\\footnotesize', description: "the note's font and size" },
      align: { type: 'enum', values: ['ragged', 'justified', 'center'], default: 'ragged', description: "the note's alignment (\\raggedright, justified, \\centering)" },
      title: { type: 'boolean', default: true, description: "the note's title in bold above its text (or as the box's title)" },
      width: { type: 'dimen', default: '', description: "\\marginparwidth; '' keeps the class's" },
      sep: { type: 'dimen', default: '', description: "\\marginparsep, between text and note; '' keeps the class's" },
    },
    presets: PRESETS,
    needs: { floats: true, argument: false },
    zerotex: 'untested',
  }),
);
