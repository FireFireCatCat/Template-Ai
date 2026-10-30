import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * ctex's report: the standard report with Chinese typesetting.
 * Read from its requirement document and source, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.ctexrep',
  name: "ctexrep",
  base: 'class.report',
  zerotex: 'untested',
  preloads: [{"pkg": "ctex"}],
  defines: ["counter:chapter", "counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [ctan('ctex')],
});
