import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * LaTeX's standard report class: chapters, one-sided, an abstract on its own page.
 * Read from its requirement document and its source, not yet measured by the
 * class probe (its preloads, names and refused packages are the documents').
 */
export default defineClass({
  id: 'class.report',
  name: "report",
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
  evidence: [ctan('latex-base')],
});
