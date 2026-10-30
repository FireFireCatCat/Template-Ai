/**
 * note.sidenotes: \sidenote[number][offset]{text}, numbered like a footnote,
 * set in the margin; without an offset the note floats, with one it is fixed
 * there. The oneside package option for one-sided layouts.
 * CTAN: https://ctan.org/pkg/sidenotes (section 1)
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { titled } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const offset = param(p, 'offset');
  return {
    preamble: () => ({ packages: [p['oneside'] === true ? '\\usepackage[oneside]{sidenotes}' : '\\usepackage{sidenotes}'] }),
    emit: (node, content) => `\\sidenote${offset === '' ? '' : `[][${offset}]`}{${titled(node, content)}}`,
  };
};

export default realize;
