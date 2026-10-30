import { defineClass } from '../schema/class.ts';

/**
 * revtex4-2, as the class probe measured it (revtex4-2-aps.A: loads, preloads,
 * names it already defines, refused packages, layout), with what its
 * requirement document says it defines and forbids.
 */
export default defineClass({
  id: 'class.revtex4-2',
  name: "revtex4-2",
  zerotex: "yes",
  preloads: [],
  defines: ["counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [{ pkg: "multicol", reason: "its load test stops: Class revtex4-2 Error: The multicol package cannot be used with revtex4-2.", evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/revtex4-2-aps.A.json' }] }],
    policy: [{ pkg: "amsthm", reason: "APS: new theorems with \\newtheorem are permitted, but amsthm markup may not be used", evidence: [{ kind: 'requirement', file: 'Template/template-requirement/REVTeX_APS.md', line: '67' }] }],
  },
  layout: { columns: 2, textwidth: "510.0pt", fontsize: "10pt" },
  vocabulary: {},
  evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/revtex4-2-aps.A.json' }, { kind: 'requirement', file: 'Template/template-requirement/REVTeX_APS.md', line: '47' }, { kind: 'requirement', file: 'Template/template-requirement/REVTeX_APS.md', line: '67' }],
});
