import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { NUMBERING } from '../node.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'head.koma-fonts',
    node: 'paragraph/heading',
    description:
      'KOMA-Script\'s own heading interface: \\setkomafont{disposition}{font} (or \\addtokomafont to add to KOMA\'s sans-serif bold) for every heading, the sizes and closing dots through \\KOMAoptions{headings=small|normal|big, numbers=enddot|noenddot}, chapterprefix for a "Chapter N" line; then the kernel command. KOMA classes only. 38 templates.',
    ctan: ['koma-script'],
    features: ['sans-serif', 'bold-head', 'smallcaps-head', 'colored', 'compact-spacing'],
    params: {
      font: { type: 'tex', default: '\\normalfont\\bfseries', description: 'the disposition font (every heading)' },
      mode: { type: 'enum', values: ['set', 'add'], default: 'set', description: "set replaces KOMA's font (\\setkomafont), add adds to it (\\addtokomafont)" },
      color: { type: 'color', default: '', description: "an xcolor colour for the heading, or '' for none" },
      headings: { type: 'enum', values: ['class', 'small', 'normal', 'big'], default: 'class', description: "KOMA's heading sizes (headings= option)" },
      numbers: { type: 'enum', values: ['class', 'enddot', 'noenddot'], default: 'class', description: 'a dot after the heading numbers or not (numbers= option)' },
      chapterPrefix: { type: 'boolean', default: false, description: 'a "Chapter N" line above chapter titles (chapterprefix=true; scrbook and scrreprt)' },
      ...NUMBERING,
    },
    presets: PRESETS,
    loads: [
      { pkg: 'xcolor' },
    ],
    requires: [
      'counter:{kind}',
    ],
    only: ['class.scrartcl', 'class.scrbook', 'class.scrreprt'],
    zerotex: 'untested',
  }),
);
