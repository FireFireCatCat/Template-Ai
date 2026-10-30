import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * extsizes' article: the standard article at 8pt to 20pt (option 8pt, 9pt, 14pt, 17pt, 20pt).
 * Read from its requirement document and its source, not yet measured by the
 * class probe (its preloads, names and refused packages are the documents').
 */
export default defineClass({
  id: 'class.extarticle',
  name: "extarticle",
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
  evidence: [ctan('extsizes')],
});
