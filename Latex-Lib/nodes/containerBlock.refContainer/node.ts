/**
 * A reference list: its entries are BibTeX source (the reference paragraphs),
 * written to `\jobname.bib` before the document begins, as General's
 * `containerBlockShape/refContainer.ts` does. `bibitems` reads the entries
 * well enough for a hand-written `thebibliography`.
 */
import { field } from '../protocol.ts';
import type { Subject } from '../../schema/realization.ts';

export const bibFile = (content: string | undefined): string[] =>
  content === undefined || content.trim() === '' ? [] : [`\\begin{filecontents*}[overwrite]{\\jobname.bib}\n${content.trim()}\n\\end{filecontents*}`];

/** The biblatex style the node asks for (`data.referenceStyling`), else numeric. */
export const styleOf = (node: Subject | undefined): string => field(node, 'referenceStyling', 'numeric').replace(/[^\w-]/gu, '') || 'numeric';

const value = (entry: string, name: string): string => {
  const m = new RegExp(`\\b${name}\\s*=\\s*[{"]([^}"]*)[}"]`, 'iu').exec(entry);
  return m?.[1]?.trim() ?? '';
};

/** Each entry as `\bibitem{key} Author. Title. Year.` */
export const bibitems = (content: string): string[] =>
  [...content.matchAll(/@\w+\s*\{\s*([^,\s]+)\s*,([\s\S]*?)(?=\n@|$)/gu)].map((m) => {
    const body = m[2] ?? '';
    const parts = [value(body, 'author'), value(body, 'title') === '' ? '' : `\\emph{${value(body, 'title')}}`, value(body, 'year')].filter(Boolean);
    return `\\bibitem{${m[1]}} ${parts.join('. ')}.`;
  });

/** `\renewcommand{\refname}{…}` (articles) and `\bibname` (books) for a heading, or nothing. */
export const headingLines = (heading: string): string[] => (heading === '' ? [] : [`\\renewcommand{\\refname}{${heading}}`, `\\providecommand{\\bibname}{}\\renewcommand{\\bibname}{${heading}}`]);
