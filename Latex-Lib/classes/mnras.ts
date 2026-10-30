import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * The Monthly Notices' class: geometry and hyperref loaded, four heading levels (\part, \chapter and \subparagraph are not to be used), an abstract environment with a fixed heading.
 * Read from its requirement document and source, not yet measured by the class probe.
 * usenatbib loads natbib (line 40); \part and \subparagraph exist but the guide says they should not be used (line 53), so the profile does not offer them.
 */
export default defineClass({
  id: 'class.mnras',
  name: "mnras",
  zerotex: 'untested',
  preloads: [{"pkg": "geometry"}, {"pkg": "hyperref"}],
  defines: ["counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "env:abstract", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [{ kind: 'requirement', file: 'Template/template-requirement/MNRAS.md', line: '40' }, { kind: 'requirement', file: 'Template/template-requirement/MNRAS.md', line: '53' }, { kind: 'requirement', file: 'Template/template-requirement/MNRAS.md', line: '54' }, { kind: 'requirement', file: 'Template/template-requirement/MNRAS.md', line: '64' }],
});
