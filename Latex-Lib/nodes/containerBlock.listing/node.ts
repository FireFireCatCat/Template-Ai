/**
 * A list as every way prints it: the item lines Flouest's list paragraphs
 * write (`\<level>[label] text`, `protocol.ts`) turned into nested
 * environments, one level per indent (General's `emitNativeList`).
 */
import { field } from '../protocol.ts';
import type { Subject } from '../../schema/realization.ts';

export type ListStyle = 'itemize' | 'enumerate' | 'description';

export const styleOf = (node: Subject): ListStyle => {
  const style = field(node, 'latexStyle', 'itemize');
  return style === 'enumerate' || style === 'description' ? style : 'itemize';
};

/** The items in nested environments: `open(level)` and `close(level)` write each level's lines. */
export const nested = (content: string, open: (level: number) => string, close: (level: number) => string): string => {
  const out: string[] = [];
  let depth = 0;
  for (const line of content.trim().split('\n')) {
    const m = /^\s*\\([1-4])(\[\{.*\}\]|\[[^\]]*\])?(?:\s+(.*))?$/u.exec(line);
    if (m === null) {
      out.push(line);
      continue;
    }
    const level = Math.min(Number(m[1]), depth + 1);
    while (depth < level) out.push(open(++depth));
    while (depth > level) out.push(close(depth--));
    out.push(`\\item${m[2] ?? ''} ${m[3] || '\\strut'}`);
  }
  while (depth > 0) out.push(close(depth--));
  return `${out.join('\n')}\n\n`;
};

/** The kernel's enumerate labels by name, for a level's counter (`enumi`, `enumii`). */
export const NUMBERINGS: { readonly [name: string]: (counter: string) => string } = {
  'arabic-dot': (c) => `\\arabic{${c}}.`,
  'arabic-paren': (c) => `\\arabic{${c}})`,
  'paren-arabic': (c) => `(\\arabic{${c}})`,
  'alph-paren': (c) => `\\alph{${c}})`,
  'paren-alph': (c) => `(\\alph{${c}})`,
  'roman-dot': (c) => `\\roman{${c}}.`,
  'Roman-dot': (c) => `\\Roman{${c}}.`,
  'Alph-dot': (c) => `\\Alph{${c}}.`,
};

/** The kernel's label redefinitions for the bullet and numbering parameters (\labelitemi, \labelenumi …). */
export const labelLines = (p: { readonly [name: string]: unknown }): string[] => {
  const text = (name: string): string => (typeof p[name] === 'string' ? (p[name] as string) : '');
  const numbering = (name: string, counter: string, command: string): string[] => {
    const make = NUMBERINGS[text(name)];
    return make === undefined ? [] : [`\\renewcommand{\\${command}}{${make(counter)}}`];
  };
  return [
    ...(text('bullet') === '' ? [] : [`\\renewcommand{\\labelitemi}{${text('bullet')}}`]),
    ...(text('bullet2') === '' ? [] : [`\\renewcommand{\\labelitemii}{${text('bullet2')}}`]),
    ...numbering('numbering', 'enumi', 'labelenumi'),
    ...numbering('numbering2', 'enumii', 'labelenumii'),
  ];
};
