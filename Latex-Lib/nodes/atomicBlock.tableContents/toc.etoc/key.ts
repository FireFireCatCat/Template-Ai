import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { CONTENTS } from '../node.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'toc.etoc',
    node: 'atomicBlock/tableContents',
    description:
      "etoc: \\tableofcontents, or \\localtableofcontents for the current division's own entries; \\etocsetnexttocdepth for the next list's depth. 35 templates.",
    ctan: ['etoc'],
    features: ['local-contents', 'flat-contents', 'lists-of-floats'],
    params: {
      scope: { type: 'enum', values: ['document', 'local'], default: 'document', description: "the whole document's contents, or the current division's (\\localtableofcontents)" },
      nextDepth: { type: 'enum', values: ['none', 'part', 'chapter', 'section', 'subsection', 'subsubsection'], default: 'none', description: 'the next contents listed down to this level (\\etocsetnexttocdepth)' },
      ...CONTENTS,
    },
    presets: PRESETS,
    loads: [
      { pkg: 'etoc' },
    ],
    requires: [
      'cmd:\\tableofcontents',
    ],
    deny: [
      { class: 'class.beamer', reason: "beamer's \\tableofcontents only reads the .toc file inside a frame", evidence: [{ kind: 'requirement', file: 'Template/template-requirement/Beamer.md', line: '61' }] },
    ],
    zerotex: 'untested',
  }),
);
