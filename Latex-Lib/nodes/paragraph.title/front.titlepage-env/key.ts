import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'front.titlepage-env',
    node: 'paragraph/title',
    description:
      "A title page laid out by hand in the kernel's titlepage environment: the title in its font, the authors and the date under it, centred or flush left; rules round the title, space above it, \\vfill to push the authors and date to the foot. 143 templates.",
    ctan: ['latex-base'],
    features: ['title-page', 'centered', 'ruled', 'sans-serif', 'bold-head'],
    params: {
      align: { type: 'enum', values: ['center', 'left'], default: 'center', description: 'the page centred or flush left' },
      titleFont: { type: 'tex', default: '\\Huge\\bfseries', description: "the title's font" },
      authorFont: { type: 'tex', default: '\\Large', description: "the authors' font" },
      dateFont: { type: 'tex', default: '\\large', description: "the date's font" },
      rules: { type: 'boolean', default: false, description: 'a rule the width of the line above and below the title' },
      topSpace: { type: 'string', default: '', description: "space above the title (\\vspace*{0.3\\textheight}); ''" },
      spread: { type: 'boolean', default: false, description: 'the authors and date pushed to the foot of the page (\\vfill)' },
    },
    presets: PRESETS,
    zerotex: 'untested',
  }),
);
