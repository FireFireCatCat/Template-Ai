/**
 * An image: its file (`data.imagePath`), width (`data.width`, a fraction of
 * the line, else 0.8), label and placement (`data.positioning`: fixed for
 * `[H]`), as General's `atomicBlockShape/Figures_Image.ts` reads them.
 */
import { dataOf, field } from '../protocol.ts';
import type { Subject } from '../../schema/realization.ts';

export const pathOf = (node: Subject): string => field(node, 'imagePath');
export const widthOf = (node: Subject, unit = 'linewidth'): string => {
  const w = Number(dataOf(node)['width']);
  return `${Number.isFinite(w) && w > 0 && w <= 1 ? w : 0.8}\\${unit}`;
};
export const placementOf = (node: Subject, fixed = 'H', floating = 'htbp'): string => (field(node, 'positioning') === 'fixed' ? fixed : floating);

/** The caption and label lines, when there is a caption; above the image when `above`. */
export const captionLines = (node: Subject, caption: string | undefined): string => {
  const label = field(node, 'label');
  return caption !== undefined && caption.trim() !== '' ? `\n\\caption{${caption.trim()}}${label === '' ? '' : `\n\\label{${label}}`}` : label === '' ? '' : `\n\\label{${label}}`;
};

/** A float around an image body, the caption below it or above it. */
export const inFloat = (env: string, placement: string, center: boolean, body: string, node: Subject, caption: string | undefined, above = false): string =>
  `\\begin{${env}}${placement === '' ? '' : `[${placement}]`}${center ? '\n\\centering' : ''}${above ? captionLines(node, caption) : ''}\n${body}${above ? '' : captionLines(node, caption)}\n\\end{${env}}\n\n`;

/** `\graphicspath{{dir/}}` for a search folder, or nothing. */
export const pathLines = (dir: string): string[] => (dir === '' ? [] : [`\\graphicspath{{${dir.endsWith('/') ? dir : `${dir}/`}}}`]);
