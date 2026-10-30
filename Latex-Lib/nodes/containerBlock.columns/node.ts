/**
 * Columns: how many (`data.count`, 1 to 3, else 2) and the gap between them
 * (`data.gap` in em, else 1.5), as General's `containerBlockShape/columns.ts`.
 */
import { dataOf } from '../protocol.ts';
import type { Subject } from '../../schema/realization.ts';

export const countOf = (node: Subject): number => {
  const n = Number(dataOf(node)['count']);
  return Number.isInteger(n) && n >= 1 && n <= 3 ? n : 2;
};

export const gapOf = (node: Subject): string => {
  const g = Number(dataOf(node)['gap'] ?? 1.5);
  return `${Number.isFinite(g) && g >= 0 && g <= 6 ? g : 1.5}em`;
};
