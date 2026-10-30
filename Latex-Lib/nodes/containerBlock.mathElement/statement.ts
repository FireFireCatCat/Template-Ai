/**
 * What every theorem way reads from Flouest's statement node
 * (`containerBlock/mathElement`): its kind (`elementName`), its label, and the
 * header note the compiler has already emitted. Which kinds there are, their
 * printed names and the AMS style each takes are General's
 * (`Profile_General/containerBlockShape/mathElement.ts`), so every way prints
 * the same statements under the same names.
 *
 * A handler's own look and numbering come from its parameters (its preset),
 * never from the node: the node is content.
 */
import type { Subject } from '../../schema/realization.ts';

export const ELEMENTS = ['definition', 'theorem', 'lemma', 'remark', 'corollary', 'proposition', 'example', 'property'] as const;
export type Element = (typeof ELEMENTS)[number];

/** The counter every statement's number restarts with: none, the section, or the chapter. */
export type Within = 'none' | 'section' | 'chapter';
export const WITHIN = ['none', 'section', 'chapter'] as const;

const dataOf = (node: Subject): { readonly [name: string]: unknown } => {
  const data = node.attrs?.['data'];
  return data !== null && typeof data === 'object' && !Array.isArray(data) ? (data as { readonly [name: string]: unknown }) : {};
};

export const elementOf = (node: Subject): Element => {
  const name = dataOf(node)['elementName'];
  return typeof name === 'string' && (ELEMENTS as readonly string[]).includes(name) ? (name as Element) : 'theorem';
};

export const displayName = (element: Element): string => `${element.charAt(0).toUpperCase()}${element.slice(1)}`;

/** General's AMS style for a kind: definitions and examples upright, remarks in the remark style, the rest plain. */
export const amsStyleOf = (element: Element): 'plain' | 'definition' | 'remark' =>
  element === 'definition' || element === 'example' ? 'definition' : element === 'remark' ? 'remark' : 'plain';

/** The environment a kind prints in; `rename` prefixes it, for a class that already defines the plain name. */
export const environmentOf = (element: Element, rename: boolean): string => (rename ? `lib${element}` : element);

/** The numbering parameters, read from a handler's parameters. */
export const numberingOf = (params: { readonly [name: string]: unknown }): Numbering => ({
  numberWithin: (WITHIN as readonly unknown[]).includes(params['numberWithin']) ? (params['numberWithin'] as Within) : 'section',
  sharedCounter: params['sharedCounter'] !== false,
  rename: params['rename'] === 'yes' ? 'yes' : 'no',
});

/** `[section]` after `\newtheorem`'s name, or nothing. */
export const withinArgument = (within: Within): string => (within === 'none' ? '' : `[${within}]`);

/** The `\label` line, when the node has a label. */
export const labelLine = (node: Subject): string => {
  const label = dataOf(node)['label'];
  return typeof label === 'string' && label.trim() !== '' ? `\\label{${label.trim()}}\n` : '';
};

/** The header note as an optional argument, braced so a nested `]` cannot end it early. */
export const noteArgument = (note: string | undefined): string => (note !== undefined && note.trim() !== '' ? `[{${note}}]` : '');

/**
 * The body, ready for a list-based environment. amsthm, ntheorem and the
 * kernel print a statement as a trivlist: a body that opens with another
 * vertical container (a table, a box) needs `\leavevmode` first, or TeX
 * reports "perhaps a missing \item" (General's `environmentFor`).
 */
export const bodyOf = (content: string): string => {
  const body = content.trim();
  return /^(\{\n\\centering\n)?\\begin\{(tabularx|tabular|tcolorbox|mdframed|center|figure|table)\}/.test(body) ? `\\leavevmode\n${body}` : body;
};

/** The statement in its environment, as every list-based way prints it. */
export const statementIn = (environment: string, node: Subject, content: string, note: string | undefined): string =>
  `\\begin{${environment}}${noteArgument(note)}\n${labelLine(node)}${bodyOf(content)}\n\\end{${environment}}\n\n`;

/** A string parameter, or its default. */
export const text = (params: { readonly [name: string]: unknown }, name: string, fallback: string): string => {
  const v = params[name];
  return typeof v === 'string' ? v : fallback;
};

/** The parameters every theorem way numbers its statements by. */
export const NUMBERING = {
  numberWithin: { type: 'enum', values: WITHIN, default: 'section', description: 'the counter each number restarts with (Theorem 2.1): none, the section or the chapter' },
  sharedCounter: { type: 'boolean', default: true, description: "every kind counts on the theorem's counter (Theorem 2.1, Lemma 2.2), else each kind on its own" },
  rename: {
    type: 'enum',
    values: ['no', 'yes'],
    default: 'no',
    compat: true,
    description: 'prefix the environments (libtheorem), for a class that already defines the plain names',
  },
} as const;

export type Numbering = { readonly numberWithin: Within; readonly sharedCounter: boolean; readonly rename: 'no' | 'yes' };

/**
 * A statement's declaration, after the theorem's when the kind shares the
 * theorem's counter: one preamble entry each, so the theorem's, asked for by
 * every kind, prints once. `declare` writes one environment in the way's own
 * syntax, numbered within a counter or on another environment's counter.
 */
export const declarations = (
  element: Element,
  numbering: Numbering,
  declare: (environment: string, element: Element, counter: { readonly within: Within } | { readonly shared: string }) => string,
): string[] => {
  const rename = numbering.rename === 'yes';
  const master = environmentOf('theorem', rename);
  const own = environmentOf(element, rename);
  if (!numbering.sharedCounter || element === 'theorem') return [declare(own, element, { within: numbering.numberWithin })];
  return [declare(master, 'theorem', { within: numbering.numberWithin }), declare(own, element, { shared: master })];
};

/** The environment every kind and every rename gives, as conditional definitions for a key. */
export const STATEMENT_DEFINES = [
  { name: 'env:{kind}', when: { rename: 'no' } },
  { name: 'env:lib{kind}', when: { rename: 'yes' } },
] as const;
