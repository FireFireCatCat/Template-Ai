import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { NUMBERING } from '../node.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'head.sectsty',
    node: 'paragraph/heading',
    description:
      'sectsty: heading fonts without touching their layout, \\allsectionsfont{font} for every level or \\sectionfont, \\subsectionfont … per level when the sizes are set; \\raggedright, \\nohang\\centering or \\raggedleft for alignment (never on the run-in paragraph levels), \\underline last for underlined titles. 13 templates.',
    ctan: ['sectsty'],
    features: ['sans-serif', 'bold-head', 'smallcaps-head', 'upright-body', 'colored', 'centered'],
    params: {
      font: { type: 'tex', default: '\\sffamily', description: "family, series and shape over the class's bold heading font" },
      scale: { type: 'enum', values: ['class', 'kernel', 'larger', 'smaller', 'text'], default: 'class', description: "each level's size: kernel the standard classes', larger or smaller one step, text the text size (chapters and parts stay large); class leaves the class's sizes" },
      color: { type: 'color', default: '', description: "an xcolor colour for the heading, or '' for none" },
      align: { type: 'enum', values: ['class', 'left', 'center', 'right'], default: 'class', description: 'alignment of the titles above the paragraph level' },
      underline: { type: 'boolean', default: false, description: 'titles underlined (\\underline last; long titles do not break)' },
      ...NUMBERING,
    },
    presets: PRESETS,
    loads: [
      { pkg: 'sectsty' },
      { pkg: 'xcolor' },
    ],
    requires: [
      'counter:{kind}',
    ],
    deny: [
      { class: 'class.acmart', reason: 'acmart stops any redefinition of \\section ("Please do not do this for ACM submissions!"), which sectsty makes as titlesec does', evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/acmart-manuscript.A.json' }] },
      { class: 'class.beamer', reason: 'beamer replaces the sectioning commands sectsty restyles', evidence: [{ kind: 'requirement', file: 'Template/template-requirement/Beamer.md', line: '54' }] },
    ],
    zerotex: 'untested',
  }),
);
