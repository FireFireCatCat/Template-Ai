import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { NUMBERING } from '../node.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'head.fncychap',
    node: 'paragraph/heading',
    description:
      'fncychap: a ready-made chapter opening, \\usepackage[Sonny]{fncychap} (Lenny, Glenn, Conny, Rejne, Bjarne, Bjornstrup, PetersLenny), adjusted with \\ChNameVar, \\ChNumVar, \\ChTitleVar, \\ChRuleWidth and the case commands; only chapters change, every heading prints with the kernel command. 3 templates.',
    ctan: ['fncychap'],
    features: ['chapter-opening', 'ruled', 'sans-serif', 'bold-head', 'smallcaps-head', 'uppercase', 'centered', 'flush-right', 'background', 'numbered'],
    params: {
      style: { type: 'enum', values: ['Sonny', 'Lenny', 'Glenn', 'Conny', 'Rejne', 'Bjarne', 'Bjornstrup', 'PetersLenny'], default: 'Sonny', description: 'the chapter style (the package option)' },
      nameFont: { type: 'tex', default: '', description: 'the "Chapter" word\'s font (\\ChNameVar); \'\' keeps the style\'s' },
      numberFont: { type: 'tex', default: '', description: "the number's font (\\ChNumVar); '' keeps the style's" },
      titleFont: { type: 'tex', default: '', description: "the title's font (\\ChTitleVar); '' keeps the style's" },
      ruleWidth: { type: 'dimen', default: '', description: "the style's rule width (\\ChRuleWidth); '' keeps the style's" },
      nameCase: { type: 'enum', values: ['style', 'upper', 'lower', 'asis'], default: 'style', description: "the chapter name's case (\\ChNameUpperCase, \\ChNameLowerCase, \\ChNameAsIs)" },
      titleCase: { type: 'enum', values: ['style', 'upper', 'lower', 'asis'], default: 'style', description: "the title's case (\\ChTitleUpperCase, \\ChTitleLowerCase, \\ChTitleAsIs)" },
      ...NUMBERING,
    },
    presets: PRESETS,
    loads: [
      { pkg: 'fncychap', options: ['Sonny'], when: { style: 'Sonny' } },
      { pkg: 'fncychap', options: ['Lenny'], when: { style: 'Lenny' } },
      { pkg: 'fncychap', options: ['Glenn'], when: { style: 'Glenn' } },
      { pkg: 'fncychap', options: ['Conny'], when: { style: 'Conny' } },
      { pkg: 'fncychap', options: ['Rejne'], when: { style: 'Rejne' } },
      { pkg: 'fncychap', options: ['Bjarne'], when: { style: 'Bjarne' } },
      { pkg: 'fncychap', options: ['Bjornstrup'], when: { style: 'Bjornstrup' } },
      { pkg: 'fncychap', options: ['PetersLenny'], when: { style: 'PetersLenny' } },
    ],
    requires: [
      'counter:{kind}',
      'counter:chapter',
    ],
    zerotex: 'untested',
  }),
);
