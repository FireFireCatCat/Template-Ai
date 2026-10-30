import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'note.notecolumn',
    node: 'containerBlock/note',
    description:
      "KOMA's scrlayer-notecolumn: \\makenote[column]{…} into a note column beside the text, synchronised with it across pages; the marginpar column, or one of its own declared with \\DeclareNewNoteColumn[font=…,width=…]{name}. 1 template.",
    ctan: ['koma-script'],
    features: ['margin-note', 'note-column', 'colored', 'small-type'],
    params: {
      column: { type: 'string', default: 'marginpar', description: "the column's name; marginpar is the predefined margin column, any other name declares a new one" },
      font: { type: 'tex', default: '', description: "the column's font (font=); ''" },
      width: { type: 'dimen', default: '', description: "the column's width (width=); ''" },
      side: { type: 'enum', values: ['normal', 'reverse'], default: 'normal', description: 'the margin (reversemarginpar)' },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'scrlayer-notecolumn' },
    ],
    zerotex: 'untested',
  }),
);
