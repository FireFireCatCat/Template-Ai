/**
 * The title block's declarations: `\title{…}` from the emitted title, with
 * `\author{…}` and `\date{…}` from the node's data when it has them (General's
 * `paragraphShape/title.ts`).
 */
import { dataOf } from '../protocol.ts';
import type { Subject } from '../../schema/realization.ts';

const strings = (v: unknown): string[] => (typeof v === 'string' ? [v] : Array.isArray(v) ? v.filter((x): x is string => typeof x === 'string') : []).map((s) => s.trim()).filter(Boolean);

export const titleLines = (node: Subject, content: string): string[] => {
  const data = dataOf(node);
  const authors = strings(data['author']);
  const date = typeof data['dateText'] === 'string' ? data['dateText'].trim() : '';
  return [`\\title{${content.trim()}}`, ...(authors.length > 0 ? [`\\author{${authors.join(' \\and ')}}`] : []), ...(date !== '' ? [`\\date{${date}}`] : [])];
};

/** The node's authors and date (`data.author`, `data.dateText`), for ways that set them in the body. */
export const peopleOf = (node: Subject): { readonly authors: readonly string[]; readonly date: string } => {
  const data = dataOf(node);
  return { authors: strings(data['author']), date: typeof data['dateText'] === 'string' ? data['dateText'].trim() : '' };
};

/** The title lines with the date as the `date` parameter asks: the node's (`given`), `\today` when it has none, or none at all. */
export const titleLinesWith = (node: Subject, content: string, date: string): string[] => {
  const lines = titleLines(node, content).filter((l) => !l.startsWith('\\date{'));
  const given = peopleOf(node).date;
  return [...lines, ...(date === 'none' ? ['\\date{}'] : given !== '' ? [`\\date{${given}}`] : date === 'today' ? ['\\date{\\today}'] : [])];
};
