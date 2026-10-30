/**
 * The dummy way (ARCHITECTURE.md section 6, the acceptance test): a theorem
 * way General does not have, brought as a plug-in. It prints a statement as a
 * `quote` with a bold lead-in, and loads nothing. What it prints does not
 * matter. What the check needs is a new way whose branches are new, while
 * every old document's LaTeX stays as it was.
 */
import type { FlouestWay } from './ways.ts';

export const DUMMY_WAY: FlouestWay = {
  id: 'thm.compat-dummy',
  node: 'containerBlock/mathElement',
  presets: [{ id: 'default', params: {} }],
  compat: [],
  loads: [],
  defines: [],
  plugin: {
    family: 'containerBlock',
    kind: 'mathElement',
    style: 'compatDummy',
    realization: {
      preamble: () => ({}),
      emit: (_subject, content) => `\\begin{quote}\\textbf{Statement.} ${content.trim()}\n\\end{quote}`,
    },
  },
};
