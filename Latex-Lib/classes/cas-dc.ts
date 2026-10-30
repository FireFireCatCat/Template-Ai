import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * Elsevier's CAS double-column class: as cas-sc, set in two columns.
 * Read from its requirement document and source, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.cas-dc',
  name: "cas-dc",
  base: 'class.article',
  zerotex: 'untested',
  preloads: [{"pkg": "amsmath"}, {"pkg": "amsfonts"}, {"pkg": "amssymb"}, {"pkg": "booktabs"}, {"pkg": "makecell"}, {"pkg": "multirow"}],
  defines: ["counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [{ kind: 'requirement', file: 'Template/template-requirement/Elsevier_CAS_DC.md', line: '64' }, { kind: 'requirement', file: 'Template/template-requirement/Elsevier_CAS_DC.md', line: '81' }, { kind: 'requirement', file: 'Template/template-requirement/Elsevier_CAS_DC.md', line: '86' }],
});
