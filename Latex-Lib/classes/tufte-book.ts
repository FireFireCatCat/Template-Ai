import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * Tufte-LaTeX's book: book with Tufte's margin notes and figures, chapters, no abstract.
 * Read from the research's Solution files and CTAN, not yet measured by the class probe.
 * The research's two templates use xtufte-book, a variant; its preloads are the Tufte-LaTeX packages it is known to load.
 */
export default defineClass({
  id: 'class.tufte-book',
  name: "tufte-book",
  base: 'class.book',
  zerotex: 'untested',
  preloads: [{"pkg": "geometry"}, {"pkg": "titlesec"}, {"pkg": "fancyhdr"}, {"pkg": "natbib"}, {"pkg": "bibentry"}, {"pkg": "hyperref"}],
  defines: ["counter:chapter", "counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "cmd:\\sidenote", "cmd:\\marginnote", "env:marginfigure", "env:margintable", "env:fullwidth", "cmd:\\newthought", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [{ kind: 'solution', file: 'Solution/0087-xtufte.md', lines: 'class' }, ctan('tufte-latex')],
});
