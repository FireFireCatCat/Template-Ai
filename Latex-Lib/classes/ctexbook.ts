import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * ctex's book: the standard book with Chinese typesetting; no abstract.
 * Read from its requirement document and source, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.ctexbook',
  name: "ctexbook",
  base: 'class.book',
  zerotex: 'untested',
  preloads: [{"pkg": "ctex"}],
  defines: ["counter:chapter", "counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [ctan('ctex')],
});
