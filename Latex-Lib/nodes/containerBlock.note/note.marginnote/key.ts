import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'note.marginnote',
    node: 'containerBlock/note',
    description:
      'marginnote: \\marginnote{…}[voffset] beside the line it is written on, a margin note that is not a float, so it also works where \\marginpar does not (floats, footnotes). The adjust options, \\marginfont, \\raggedleftmarginnote and \\raggedrightmarginnote, \\marginnotevadjust, \\reversemarginpar. 21 templates.',
    ctan: ['marginnote'],
    features: ['margin-note', 'sans-serif', 'small-type', 'colored', 'italic-body'],
    params: {
      font: { type: 'tex', default: '\\footnotesize', description: "\\marginfont, the notes' font" },
      color: { type: 'color', default: '', description: "an xcolor colour for the notes, or ''" },
      align: { type: 'enum', values: ['package', 'justified', 'center'], default: 'package', description: 'package: ragged towards the text; justified or centred (\\raggedleftmarginnote, \\raggedrightmarginnote)' },
      adjust: { type: 'enum', values: ['package', 'fulladjust', 'heightadjust', 'depthadjust', 'noadjust'], default: 'package', compat: true, description: "how the note is aligned with its line's height and depth (the package option)" },
      vadjust: { type: 'dimen', default: '', description: "\\marginnotevadjust, a vertical shift of every note; ''" },
      offset: { type: 'dimen', default: '', description: "the note's own vertical offset, \\marginnote{…}[offset]; ''" },
      side: { type: 'enum', values: ['outer', 'reverse'], default: 'outer', description: 'the margin (\\reversemarginpar for the other one)' },
      width: { type: 'dimen', default: '', description: "\\marginparwidth; ''" },
      title: { type: 'boolean', default: true, description: "the note's title in bold above its text (or as the box's title)" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'marginnote' },
      { pkg: 'marginnote', options: ['fulladjust'], when: { adjust: 'fulladjust' } },
      { pkg: 'marginnote', options: ['heightadjust'], when: { adjust: 'heightadjust' } },
      { pkg: 'marginnote', options: ['depthadjust'], when: { adjust: 'depthadjust' } },
      { pkg: 'marginnote', options: ['noadjust'], when: { adjust: 'noadjust' } },
      { pkg: 'xcolor' },
    ],
    defines: [
      'cmd:\\marginnote',
    ],
    zerotex: 'yes',
  }),
);
