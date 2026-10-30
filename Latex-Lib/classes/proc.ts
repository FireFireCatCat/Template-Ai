import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * The kernel's proceedings class: article in two columns.
 * Read from the research's Solution files and CTAN, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.proc',
  name: "proc",
  base: 'class.article',
  zerotex: 'untested',
  preloads: [],
  defines: ["counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [ctan('latex-base')],
});
