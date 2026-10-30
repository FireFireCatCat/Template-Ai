import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'list.kernel',
    node: 'containerBlock/listing',
    description:
      "The kernel's lists: itemize, enumerate, description (data.latexStyle), nested by the items' indent, \\item[label] per item; the bullets (\\labelitemi, \\labelitemii) and numbers (\\labelenumi, \\labelenumii) redefined when asked. 520 templates.",
    ctan: ['latex-base'],
    features: ['numbered', 'custom-labels', 'lettered'],
    params: {
      bullet: { type: 'tex', default: '', description: "the first-level bullet (\\labelitemi); ''" },
      bullet2: { type: 'tex', default: '', description: "the second-level bullet (\\labelitemii); ''" },
      numbering: { type: 'enum', values: ['class', 'arabic-dot', 'arabic-paren', 'paren-arabic', 'alph-paren', 'paren-alph', 'roman-dot', 'Roman-dot', 'Alph-dot'], default: 'class', description: 'the first-level number (\\labelenumi): 1. 1) (1) a) (a) i. I. A.' },
      numbering2: { type: 'enum', values: ['class', 'arabic-dot', 'arabic-paren', 'paren-arabic', 'alph-paren', 'paren-alph', 'roman-dot', 'Roman-dot', 'Alph-dot'], default: 'class', description: 'the second-level number (\\labelenumii)' },
    },
    presets: PRESETS,
    zerotex: 'untested',
  }),
);
