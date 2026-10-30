/**
 * What every contents way shares: its depth (\setcounter{tocdepth}), the
 * lists of figures and tables after it, its title (\contentsname), and the
 * break after it.
 */
import type { ParamSchema } from '../../schema/params.ts';
import { param } from '../protocol.ts';

export const CONTENTS = {
  depth: { type: 'number', default: 0, description: 'the deepest level listed (\\setcounter{tocdepth}{n}: 1 sections, 2 subsections …); 0 leaves the class\'s' },
  lists: { type: 'enum', values: ['none', 'figures', 'tables', 'both'], default: 'none', description: 'the lists of figures and tables printed after the contents' },
  title: { type: 'string', default: '', description: "the contents' heading (\\renewcommand{\\contentsname}{…}); ''" },
  after: { type: 'enum', values: ['none', 'newpage', 'clearpage', 'cleardoublepage'], default: 'none', description: 'a break after the contents and after each list' },
} as const satisfies ParamSchema;

/** The preamble lines for depth and title. */
export const contentsDeclarations = (p: { readonly [name: string]: unknown }): string[] => [
  ...(typeof p['depth'] === 'number' && p['depth'] > 0 ? [`\\setcounter{tocdepth}{${p['depth']}}`] : []),
  ...(param(p, 'title') === '' ? [] : [`\\renewcommand{\\contentsname}{${param(p, 'title')}}`]),
];

/** The contents command, then the lists, each followed by the break. */
export const contentsBody = (p: { readonly [name: string]: unknown }, command = '\\tableofcontents'): string => {
  const brk = param(p, 'after', 'none') === 'none' ? [] : [`\\${param(p, 'after')}`];
  const lists = param(p, 'lists', 'none');
  return `${[command, ...brk, ...(lists === 'figures' || lists === 'both' ? ['\\listoffigures', ...brk] : []), ...(lists === 'tables' || lists === 'both' ? ['\\listoftables', ...brk] : [])].join('\n')}\n\n`;
};
