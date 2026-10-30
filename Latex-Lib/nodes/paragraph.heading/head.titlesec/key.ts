import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { NUMBERING } from '../node.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'head.titlesec',
    node: 'paragraph/heading',
    description:
      "titlesec: the heading level's format with \\titleformat{\\section}[shape]{format}{label}{sep}{before-code}[after-code] and its spacing with \\titlespacing*{\\section}{left}{before}{after}, then the kernel command. Shapes hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame; \\filcenter or \\filleft to align; \\titlerule for rules; \\MakeUppercase as the last before-code command for upper-cased titles; *n spacing. Not with memoir or KOMA (the manual says so). 155 templates.",
    ctan: ['titlesec'],
    features: ['hang-head', 'block-head', 'display-head', 'run-in-head', 'sans-serif', 'bold-head', 'italic-head', 'smallcaps-head', 'colored', 'uppercase', 'centered', 'ruled', 'compact-spacing', 'page-break-before', 'numbered', 'unnumbered'],
    params: {
      shape: { type: 'enum', values: ['hang', 'block', 'display', 'runin', 'leftmargin', 'rightmargin', 'drop', 'wrap', 'frame'], default: 'hang', description: 'the shape of section to subsubsection titles (titlesec 3.1)' },
      chapterShape: { type: 'enum', values: ['display', 'hang', 'block', 'frame'], default: 'display', description: 'the shape of chapter and part titles; display puts "Chapter N" on a line of its own' },
      runIn: { type: 'enum', values: ['paragraph', 'subsubsection', 'subsection', 'none'], default: 'paragraph', description: 'this level and the ones below it run into their paragraph (runin shape); none for no run-in level' },
      font: { type: 'tex', default: '\\normalfont\\bfseries', description: 'the family, series and shape of every level' },
      scale: { type: 'enum', values: ['kernel', 'larger', 'smaller', 'text'], default: 'kernel', description: "each level's size: kernel the standard classes', larger or smaller one step, text the text size (chapters and parts stay large)" },
      color: { type: 'color', default: '', description: "an xcolor colour for the heading, or '' for none" },
      align: { type: 'enum', values: ['left', 'center', 'right'], default: 'left', description: 'alignment of the title (\\filcenter, \\filleft); never on run-in levels' },
      uppercase: { type: 'boolean', default: false, description: 'the title upper-cased (\\MakeUppercase as the last before-code command)' },
      label: { type: 'enum', values: ['number', 'number-dot', 'none'], default: 'number', description: "the label: the level's number, the number and a dot, or nothing (the number then still reaches the contents)" },
      sep: { type: 'dimen', default: '1em', description: 'space between label and title (display shapes use the kernel 20pt)' },
      rule: { type: 'enum', values: ['none', 'below', 'above-below'], default: 'none', description: 'a \\titlerule under the title, or one above and one under' },
      ruleWidth: { type: 'dimen', default: '.4pt', description: "the rules' thickness" },
      spacing: { type: 'enum', values: ['class', 'compact', 'airy', 'custom'], default: 'class', description: "class: the spacing titlesec takes from the class; compact (*2/*1) or airy (*5/*3); custom: before and after below, for the section levels (chapters keep titlesec's 50pt and 40pt)" },
      left: { type: 'dimen', default: '0pt', description: 'custom spacing: the left indent of the title' },
      before: { type: 'string', default: '3.5ex plus 1ex minus .2ex', description: 'custom spacing: space above (a skip, or *n)' },
      after: { type: 'string', default: '2.3ex plus .2ex', description: 'custom spacing: space below (a skip, or *n)' },
      indentAfter: { type: 'boolean', default: false, description: 'the paragraph after the title is indented (\\titlespacing without the star)' },
      sectionBreak: { type: 'enum', values: ['none', 'clearpage', 'cleardoublepage'], default: 'none', description: 'each section starts a new page (\\newcommand{\\sectionbreak}{\\clearpage})' },
      ...NUMBERING,
    },
    presets: PRESETS,
    loads: [
      { pkg: 'titlesec' },
      { pkg: 'xcolor' },
    ],
    requires: [
      'counter:{kind}',
    ],
    deny: [
      { class: 'class.scrartcl', reason: 'KOMA-Script objects to titlesec (it warns when loaded) and styles headings itself (head.koma-fonts)', evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/scrartcl.A.json' }] },
      { class: 'class.scrbook', reason: 'KOMA-Script objects to titlesec (it warns when loaded) and styles headings itself (head.koma-fonts)', evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/scrartcl.A.json' }] },
      { class: 'class.scrreprt', reason: 'KOMA-Script objects to titlesec (it warns when loaded) and styles headings itself (head.koma-fonts)', evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/scrartcl.A.json' }] },
      { class: 'class.memoir', reason: 'memoir objects to titlesec and styles headings itself (head.memoir-style)', evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/memoir.A.json' }] },
      { class: 'class.beamer', reason: 'beamer replaces the sectioning commands: they print nothing on a slide, only navigation and contents entries', evidence: [{ kind: 'requirement', file: 'Template/template-requirement/Beamer.md', line: '54' }] },
    ],
    zerotex: 'yes',
  }),
);
