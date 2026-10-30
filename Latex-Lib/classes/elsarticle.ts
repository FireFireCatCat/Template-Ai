import { defineClass } from '../schema/class.ts';

/**
 * elsarticle, as the class probe measured it (elsarticle-preprint.A: loads, preloads,
 * names it already defines, refused packages, layout), with what its
 * requirement document says it defines and forbids.
 */
export default defineClass({
  id: 'class.elsarticle',
  name: "elsarticle",
  zerotex: "yes",
  preloads: [{"pkg": "graphicx"}, {"pkg": "natbib"}],
  defines: ["counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: { columns: 1, textwidth: "345.0pt", fontsize: "10pt" },
  vocabulary: {},
  evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/elsarticle-preprint.A.json' }, { kind: 'requirement', file: 'Template/template-requirement/Elsarticle.md', line: '113' }, { kind: 'requirement', file: 'Template/template-requirement/Elsarticle.md', line: '237' }],
});
