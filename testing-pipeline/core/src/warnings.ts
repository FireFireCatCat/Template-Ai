/**
 * The warnings that count as failure (ARCHITECTURE.md 4.6, the oracle's second
 * check). Every other warning is recorded in the ledger but fails nothing: a
 * substituted font shape, a slightly loose line.
 *
 * Each finding carries the source line the log names, when it names one, so
 * the oracle can tie it to a branch.
 */
import type { LogReading } from './log.ts';

export type Damage = { readonly name: string; readonly text: string; readonly line?: number };

export type DamageOptions = {
  /** An overfull hbox fails when it is more than this many pt too wide. */
  readonly hboxTolerancePt: number;
};

/** Warnings that fail on their own wording. */
const WORDED: readonly { readonly name: string; readonly test: RegExp }[] = [
  { name: 'undefined-reference', test: /^LaTeX Warning: (Reference|Citation) `[^']*' on page \d+ undefined/ },
  { name: 'labels-changed', test: /^LaTeX Warning: Label\(s\) may have changed/ },
  { name: 'float-too-large', test: /^LaTeX Warning: Float too large for page/ },
];

const inputLine = (text: string): number | undefined => {
  const m = /on input line (\d+)/.exec(text);
  return m ? Number(m[1]) : undefined;
};

export const damagingWarnings = (reading: LogReading, { hboxTolerancePt }: DamageOptions): Damage[] => {
  const found: Damage[] = [];
  for (const text of reading.warnings) {
    const rule = WORDED.find((r) => r.test.test(text));
    if (rule === undefined) continue;
    const line = inputLine(text);
    found.push(line === undefined ? { name: rule.name, text } : { name: rule.name, text, line });
  }
  for (const box of reading.boxes) {
    if (box.kind !== 'overfull') continue;
    const where = box.lines ? ` at lines ${box.lines[0]}--${box.lines[1]}` : '';
    if (box.box === 'v' && box.output) {
      found.push({ name: 'page-overflow', text: `Overfull \\vbox (${box.amount}pt too high) while a page was made: content ran off the page` });
    } else if (box.box === 'h' && box.amount > hboxTolerancePt) {
      const text = `Overfull \\hbox (${box.amount}pt too wide)${where}`;
      found.push(box.lines ? { name: 'overfull-hbox', text, line: box.lines[0] } : { name: 'overfull-hbox', text });
    }
  }
  for (const missing of reading.missing) found.push({ name: 'missing-character', text: `Missing character: ${missing}` });
  return found;
};
