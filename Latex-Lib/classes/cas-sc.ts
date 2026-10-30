import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * Elsevier's CAS single-column class: article underneath, numbered heads ending in a full stop, an abstract written to a file and printed by \maketitle; no theorem environments, \newdefinition and \newproof beside \newtheorem.
 * Read from its requirement document and source, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.cas-sc',
  name: "cas-sc",
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
  evidence: [{ kind: 'requirement', file: 'Template/template-requirement/Elsevier_CAS_SC.md', line: '43' }, { kind: 'requirement', file: 'Template/template-requirement/Elsevier_CAS_SC.md', line: '61' }, { kind: 'requirement', file: 'Template/template-requirement/Elsevier_CAS_SC.md', line: '67' }, { kind: 'requirement', file: 'Template/template-requirement/Elsevier_CAS_SC.md', line: '84' }, { kind: 'requirement', file: 'Template/template-requirement/Elsevier_CAS_SC.md', line: '88' }, { kind: 'requirement', file: 'Template/template-requirement/Elsevier_CAS_SC.md', line: '100' }, { kind: 'requirement', file: 'Template/template-requirement/Elsevier_CAS_SC.md', line: '115' }],
});
