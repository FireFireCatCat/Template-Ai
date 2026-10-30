/**
 * A note: its title (`data.title`, "Note" when absent) and its tone
 * (`data.tone`: info, warning, tip), as General's `containerBlockShape/note.ts`
 * reads them.
 */
import { dataOf, field } from '../protocol.ts';
import type { Subject } from '../../schema/realization.ts';

export const titleOf = (node: Subject): string => (typeof dataOf(node)['title'] === 'string' ? field(node, 'title') : 'Note');

/** The tone's colour, General's: warning amber, tip green, otherwise blue. */
export const toneOf = (node: Subject): string => {
  const tone = field(node, 'tone');
  return tone === 'warning' ? '9A6100' : tone === 'tip' ? '247050' : '285DAF';
};

/** The note's text: its title in bold on a line of its own, then the body. */
export const titled = (node: Subject, content: string): string => {
  const title = titleOf(node);
  return `${title === '' ? '' : `{\\bfseries ${title}\\par}\n`}${content.trim() || '\\mbox{}'}`;
};

/** The tone's name (info, warning, tip), for ways that pick an environment or an icon by it. */
export const toneName = (node: Subject): 'info' | 'warning' | 'tip' => {
  const tone = field(node, 'tone');
  return tone === 'warning' || tone === 'tip' ? tone : 'info';
};

/** A colour parameter's value with `tone` standing for the tone's own colour (`tone!10!white` → `noteinfo!10!white`, defined by `toneDefinition`). */
export const colorFor = (value: string, node: Subject): string => value.replace(/\btone\b/gu, `note${toneName(node)}`);

/** `\definecolor{note<tone>}{HTML}{…}` when a colour parameter names the tone's colour (xcolor). */
export const toneDefinition = (values: readonly string[], node: Subject | undefined): string[] =>
  node !== undefined && values.some((v) => /\btone\b/u.test(v)) ? [`\\definecolor{note${toneName(node)}}{HTML}{${toneOf(node)}}`] : [];
