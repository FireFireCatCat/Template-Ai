import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * ctex's beamer: beamer with Chinese typesetting; beamer's rules hold.
 * Read from its requirement document and source, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.ctexbeamer',
  name: "ctexbeamer",
  base: 'class.beamer',
  zerotex: 'untested',
  preloads: [{"pkg": "ctex"}, {"pkg": "amsmath"}, {"pkg": "amsthm"}, {"pkg": "amssymb"}, {"pkg": "xcolor"}, {"pkg": "enumerate"}],
  defines: ["counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "env:theorem", "env:corollary", "env:fact", "env:lemma", "env:problem", "env:solution", "env:definition", "env:example", "env:abstract", "cmd:\\note", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [ctan('ctex'), ctan('beamer')],
});
