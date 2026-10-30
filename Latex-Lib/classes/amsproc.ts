import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * The AMS proceedings class: amsart's family (amsmath and amsfonts loaded, amsthm built in), no chapter, the abstract before \maketitle.
 * Read from the research's Solution files and CTAN, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.amsproc',
  name: "amsproc",
  zerotex: 'untested',
  preloads: [{"pkg": "amsmath"}, {"pkg": "amsfonts"}, {"pkg": "amsthm"}],
  defines: ["counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:proof", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [{ kind: 'solution', file: 'Solution/0260-amsproc.md', lines: '30' }, { kind: 'solution', file: 'Solution/0260-amsproc.md', lines: '49-51' }, ctan('amscls')],
});
