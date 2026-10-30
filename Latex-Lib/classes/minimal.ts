import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * The kernel's minimal class: a page size and \normalsize, nothing else; no sectioning, no title, no floats, no lists of contents, no bibliography.
 * Read from the research's Solution files and CTAN, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.minimal',
  name: "minimal",
  zerotex: 'untested',
  preloads: [],
  defines: [],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [ctan('latex-base')],
});
