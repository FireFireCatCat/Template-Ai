import { defineClass } from '../schema/class.ts';

/**
 * acmart, as the class probe measured it (acmart-manuscript.A: loads, preloads,
 * names it already defines, refused packages, layout), with what its
 * requirement document says it defines and forbids.
 */
export default defineClass({
  id: 'class.acmart',
  name: "acmart",
  zerotex: "yes",
  preloads: [{"pkg": "fontspec"}, {"pkg": "amsmath"}, {"pkg": "amssymb"}, {"pkg": "setspace"}, {"pkg": "amsthm"}, {"pkg": "hyperref"}, {"pkg": "xcolor"}, {"pkg": "graphicx"}, {"pkg": "caption"}, {"pkg": "float"}, {"pkg": "booktabs"}],
  defines: ["counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:theorem", "env:conjecture", "env:proposition", "env:lemma", "env:corollary", "env:example", "env:definition", "env:abstract", "env:acks", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {"acmthm=false": {"removes": ["env:theorem", "env:conjecture", "env:proposition", "env:lemma", "env:corollary", "env:example", "env:definition"], "description": "the class defines none of its theorem environments"}},
  forbids: {
    technical: [{ pkg: "titlesec", reason: "its load test stops: Class acmart Error: An attempt to redefine \\section detected. Please do not do this for ACM submissions!.", evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/acmart-manuscript.A.json' }] }],
    policy: [],
  },
  layout: { columns: 1, textwidth: "430.00462pt", fontsize: "9pt" },
  vocabulary: {"\\affiliation": "an author's affiliation", "\\ccsdesc": "CCS concepts", "\\keywords": "keywords"},
  evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/acmart-manuscript.A.json' }, { kind: 'requirement', file: 'Template/template-requirement/ACM.md', line: '85' }, { kind: 'requirement', file: 'Template/template-requirement/ACM.md', line: '199' }],
});
