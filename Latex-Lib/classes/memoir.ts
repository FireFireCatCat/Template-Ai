import { defineClass } from '../schema/class.ts';

/**
 * memoir, as the class probe measured it (memoir.A: loads, preloads,
 * names it already defines, refused packages, layout), with what its
 * requirement document says it defines and forbids.
 */
export default defineClass({
  id: 'class.memoir',
  name: "memoir",
  zerotex: "yes",
  preloads: [{"pkg": "setspace"}, {"pkg": "tocloft"}, {"pkg": "tabularx"}, {"pkg": "booktabs"}],
  defines: ["counter:chapter", "counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: { columns: 1, textwidth: "341.0pt", fontsize: "10pt" },
  vocabulary: {},
  evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/memoir.A.json' }],
});
