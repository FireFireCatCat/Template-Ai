import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * extsizes' report: the standard report at 8pt to 20pt; chapters and an abstract.
 * Read from the research's Solution files and CTAN, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.extreport',
  name: "extreport",
  zerotex: 'untested',
  preloads: [],
  defines: ["counter:chapter", "counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [ctan('extsizes'), { kind: 'solution', file: 'Solution/0064-korogodin-nslreport.md', lines: 'class' }],
});
