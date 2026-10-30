/**
 * A heading as every way prints it: `\<level>[short]{title}` and its label
 * (General's `paragraphShape/heading.ts`), the level from `data.sectionLevel`,
 * starred when `data.numbered` is false. And what the ways share: each
 * level's size under a scale, and the numbering parameters.
 */
import type { ParamSchema } from '../../schema/params.ts';
import { field, labelLine, param } from '../protocol.ts';
import type { Subject } from '../../schema/realization.ts';

export const LEVELS = ['part', 'chapter', 'section', 'subsection', 'subsubsection', 'paragraph', 'subparagraph'] as const;
export type Level = (typeof LEVELS)[number];

export const levelOf = (node: Subject | undefined): Level => {
  const level = field(node, 'sectionLevel', 'section');
  return (LEVELS as readonly string[]).includes(level) ? (level as Level) : 'section';
};

export const headingCommand = (node: Subject, content: string): string => {
  const numbered = (node.attrs?.['data'] as { numbered?: unknown } | undefined)?.numbered !== false;
  const short = field(node, 'shortTitle');
  return `\\${levelOf(node)}${numbered ? '' : '*'}${numbered && short !== '' ? `[${short}]` : ''}{${content.trim()}}${labelLine(field(node, 'label'))}\n\n`;
};

/** The font sizes in order, so a scale can step one up. */
const STEPS = ['\\normalsize', '\\large', '\\Large', '\\LARGE', '\\huge', '\\Huge'] as const;

/**
 * Each level's size: `kernel` the standard classes' (article, report, book;
 * a chapter's or part's label, its title a step up),
 * `larger` and `smaller` one step either way, `text` every level but chapter
 * and part at the text size (titlesec's `tiny`).
 */
export const SCALES = {
  kernel: { part: 4, chapter: 4, section: 2, subsection: 1, subsubsection: 0, paragraph: 0, subparagraph: 0 },
  larger: { part: 5, chapter: 5, section: 3, subsection: 2, subsubsection: 1, paragraph: 0, subparagraph: 0 },
  smaller: { part: 3, chapter: 3, section: 1, subsection: 0, subsubsection: 0, paragraph: 0, subparagraph: 0 },
  text: { part: 2, chapter: 2, section: 0, subsection: 0, subsubsection: 0, paragraph: 0, subparagraph: 0 },
} as const satisfies { readonly [scale: string]: { readonly [level in Level]: number } };

export const SCALE_NAMES = Object.keys(SCALES) as (keyof typeof SCALES)[];

/** A level's size under a scale, or nothing for `class` (the class's own sizes). */
export const sizeOf = (scale: string, level: Level): string => {
  const sizes = (SCALES as { readonly [scale: string]: { readonly [level in Level]: number } })[scale];
  return sizes === undefined ? '' : STEPS[sizes[level]] ?? '';
};

/** The size one step above (a display chapter's title over its label). */
export const stepUp = (size: string): string => STEPS[Math.min(STEPS.indexOf(size as (typeof STEPS)[number]) + 1, STEPS.length - 1)] ?? size;

/** `\secnumdepth`'s value for each level. */
export const DEPTHS: { readonly [level: string]: number } = { none: -2, part: -1, chapter: 0, section: 1, subsection: 2, subsubsection: 3, paragraph: 4, subparagraph: 5 };

/** The numbering parameters every restyling way takes. */
export const NUMBERING = {
  numberDepth: {
    type: 'enum',
    values: ['class', 'none', 'part', 'chapter', 'section', 'subsection', 'subsubsection', 'paragraph'],
    default: 'class',
    description: "the deepest level numbered (\\setcounter{secnumdepth}); 'class' leaves the class's, 'none' numbers nothing",
  },
  numberStyle: {
    type: 'enum',
    values: ['arabic', 'Roman', 'roman', 'Alph', 'alph'],
    default: 'arabic',
    description: "a chapter's or section's number alone in this style (\\renewcommand{\\thechapter}{\\Roman{chapter}}); 'arabic' leaves the class's",
  },
} as const satisfies ParamSchema;

/** The declarations the numbering parameters make for a heading at `level`. */
export const numberingLines = (p: { readonly [name: string]: unknown }, level: Level): string[] => {
  const depth = param(p, 'numberDepth', 'class');
  const style = param(p, 'numberStyle', 'arabic');
  return [
    ...(depth === 'class' ? [] : [`\\setcounter{secnumdepth}{${DEPTHS[depth] ?? 3}}`]),
    ...(style !== 'arabic' && (level === 'chapter' || level === 'section') ? [`\\renewcommand{\\the${level}}{\\${style}{${level}}}`] : []),
  ];
};

/** `\color{…}` for a colour, or nothing. */
export const colorOf = (p: { readonly [name: string]: unknown }, name = 'color'): string => {
  const c = param(p, name);
  return c === '' || c === 'none' ? '' : `\\color{${c}}`;
};
