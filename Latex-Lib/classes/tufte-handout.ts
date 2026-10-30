import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * Tufte-LaTeX's handout: article with a wide margin for \sidenote, \marginnote and margin figures, unnumbered sections, natbib and titlesec loaded.
 * Read from the research's Solution files and CTAN, not yet measured by the class probe.
 * Its preloads are the Tufte-LaTeX packages it is known to load; the class source was not read.
 */
export default defineClass({
  id: 'class.tufte-handout',
  name: "tufte-handout",
  base: 'class.article',
  zerotex: 'untested',
  preloads: [{"pkg": "geometry"}, {"pkg": "titlesec"}, {"pkg": "fancyhdr"}, {"pkg": "natbib"}, {"pkg": "bibentry"}, {"pkg": "hyperref"}],
  defines: ["counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "cmd:\\sidenote", "cmd:\\marginnote", "env:marginfigure", "env:margintable", "env:fullwidth", "cmd:\\newthought", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [{ kind: 'solution', file: 'Solution/0825-tufte-essay.md', lines: 'class' }, ctan('tufte-latex')],
});
