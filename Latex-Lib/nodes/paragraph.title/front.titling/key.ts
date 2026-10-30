import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'front.titling',
    node: 'paragraph/title',
    description:
      'titling: \\maketitle restyled by its hooks, \\pretitle and \\posttitle around the title, \\preauthor and \\postauthor around the authors, \\predate and \\postdate around the date; \\droptitle to move the block; alone on its page in titlingpage, centred by \\maketitlehooka and \\maketitlehookd. 29 templates.',
    ctan: ['titling'],
    features: ['centered', 'flush-right', 'sans-serif', 'bold-head', 'title-page'],
    params: {
      align: { type: 'enum', values: ['center', 'left', 'right'], default: 'center', description: 'the title and authors centred, flush left or flush right' },
      titleFont: { type: 'tex', default: '\\LARGE', description: "the title's font (in \\pretitle)" },
      authorFont: { type: 'tex', default: '\\large', description: "the authors' font (in \\preauthor)" },
      dateFont: { type: 'tex', default: '\\large', description: "the date's font (in \\predate)" },
      dateAlign: { type: 'enum', values: ['same', 'center', 'left', 'right'], default: 'same', description: 'the date aligned as the title, or its own way' },
      gap: { type: 'dimen', default: '0.5em', description: 'space under the title (in \\posttitle)' },
      drop: { type: 'dimen', default: '', description: "the block moved down, or up when negative (\\droptitle); ''" },
      page: { type: 'boolean', default: false, description: 'the title block alone on its page, centred vertically (titlingpage, \\maketitlehooka, \\maketitlehookd)' },
      date: { type: 'enum', values: ['given', 'today', 'none'], default: 'given', description: "the date line: the node's date (the kernel prints today's when there is none), \\today explicitly, or none (\\date{})" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'titling' },
    ],
    requires: [
      'cmd:\\maketitle',
    ],
    zerotex: 'untested',
  }),
);
