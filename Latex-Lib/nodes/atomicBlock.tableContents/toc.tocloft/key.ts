import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { CONTENTS } from '../node.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'toc.tocloft',
    node: 'atomicBlock/tableContents',
    description:
      'tocloft: the contents restyled by its hooks, \\cftsecleader as \\cftdotfill{\\cftdotsep} for dot leaders, \\cftsecfont, \\cftsecpagefont, \\cftsecaftersnumb, \\cfttoctitlefont and \\cftaftertoctitle for the title; then \\tableofcontents. 55 templates.',
    ctan: ['tocloft'],
    features: ['dot-leaders', 'centered', 'bold-head', 'lists-of-floats'],
    params: {
      leaders: { type: 'enum', values: ['sections', 'all', 'none'], default: 'sections', description: 'dot leaders for sections, for sections and subsections, or none added' },
      sectionFont: { type: 'tex', default: '', description: "section entries' font (\\cftsecfont); ''" },
      pageFont: { type: 'tex', default: '', description: "their page numbers' font (\\cftsecpagefont); ''" },
      afterNumber: { type: 'tex', default: '', description: "after each section number (\\cftsecaftersnumb); ''" },
      titleFont: { type: 'tex', default: '', description: "the title's font (\\cfttoctitlefont, \\hfill to centre); ''" },
      titleAfter: { type: 'tex', default: '', description: "after the title (\\cftaftertoctitle); ''" },
      ...CONTENTS,
    },
    presets: PRESETS,
    loads: [
      { pkg: 'tocloft' },
    ],
    requires: [
      'cmd:\\tableofcontents',
    ],
    deny: [
      { class: 'class.scrartcl', reason: 'KOMA-Script objects to tocloft (it warns when loaded) and styles its contents itself (toc.koma)', evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/scrartcl.A.json' }] },
      { class: 'class.scrbook', reason: 'KOMA-Script objects to tocloft (it warns when loaded) and styles its contents itself (toc.koma)', evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/scrartcl.A.json' }] },
      { class: 'class.scrreprt', reason: 'KOMA-Script objects to tocloft (it warns when loaded) and styles its contents itself (toc.koma)', evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/scrartcl.A.json' }] },
      { class: 'class.beamer', reason: "beamer's \\tableofcontents only reads the .toc file inside a frame and prints no heading", evidence: [{ kind: 'requirement', file: 'Template/template-requirement/Beamer.md', line: '61' }] },
    ],
    zerotex: 'yes',
  }),
);
