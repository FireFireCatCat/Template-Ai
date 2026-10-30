/**
 * What TeX's log says, read for what a test cares about: the pages written,
 * each error with the line TeX stopped on, the warnings, the box counts and
 * the missing characters.
 *
 * Ported from Flouest's dynamic tests (`texlog.ts`: `readLog`, `shapeOf`),
 * which read the same ZeroTeX logs. Which branch an error belongs to is no
 * longer worked out here: the host hands each branch's lines over in
 * `Emitted.spans`.
 */
import type { CellStatus, RawResult } from './model.ts';

export type TexError = {
  readonly message: string;
  readonly line?: number;
  /** The LaTeX source line TeX names, when the LaTeX was given. */
  readonly source?: string;
};

/**
 * An overfull or underfull box. `amount` is how far over in pt (overfull) or
 * the badness (underfull). `lines` is the source lines TeX names (`at lines
 * 5--6`, `detected at line 7`). `output`: it happened while a page was being
 * made (`has occurred while \output is active`), which for an overfull vbox
 * means content ran off the page.
 */
export type BoxReport = {
  readonly kind: 'overfull' | 'underfull';
  readonly box: 'h' | 'v';
  readonly amount: number;
  readonly lines?: readonly [number, number];
  readonly output: boolean;
};

export type LogReading = {
  readonly pages: number | null;
  readonly errors: readonly TexError[];
  /** TeX's run ended at a fatal error (`==> Fatal error occurred`), so nothing after it ran. XeTeX carries on past any other error. */
  readonly fatal: boolean;
  /** Each warning as the log words it, with its `(package)` continuation lines joined on. */
  readonly warnings: readonly string[];
  readonly overfull: number;
  readonly underfull: number;
  readonly boxes: readonly BoxReport[];
  readonly missing: readonly string[];
};

const BOX = /^(Overfull|Underfull) \\([hv])box \((?:badness (\d+)|([\d.]+)pt too (?:wide|high))\)(.*)$/;

const boxReport = (line: string): BoxReport | undefined => {
  const m = BOX.exec(line);
  if (!m) return undefined;
  const rest = m[5] ?? '';
  const range = /at lines? (\d+)(?:--(\d+))?/.exec(rest);
  const from = range ? Number(range[1]) : undefined;
  return {
    kind: m[1] === 'Overfull' ? 'overfull' : 'underfull',
    box: m[2] === 'h' ? 'h' : 'v',
    amount: Number(m[3] ?? m[4]),
    ...(from === undefined ? {} : { lines: [from, Number(range?.[2] ?? from)] as const }),
    output: rest.includes('\\output is active'),
  };
};

/** TeX breaks every log line at this many characters; a longer line carries on in the next. */
export const LOG_WIDTH = 79;

/** Where an error's message ends: a blank line, its context (`l.<n>`, `<inserted text>`), LaTeX's `See the…` and `Type  H…`, or another `!` line. */
const ERROR_CONTEXT = /^(\s*$|l\.\d+|<[^>]*>|See |Type |\? |!)/;

/** A line that starts an entry of its own, so it never carries on a warning before it. */
const NEW_ENTRY = /^(! |LaTeX |Package |Class |pdfTeX |Missing character|Overfull|Underfull|File: |\(|\)|\[|<|\\|COMPAT-)/;

/** TeX's log, read for what a test cares about. `latex` gives each error its source line. */
export const readLog = (log: string, latex?: string): LogReading => {
  const raw = log.split('\n');
  const source = latex?.split('\n');
  const errors: TexError[] = [];
  const warnings: string[] = [];
  const missing: string[] = [];
  const boxes: BoxReport[] = [];
  let fatal = false;
  let overfull = 0;
  let underfull = 0;
  const written = /Output written on .*?\((\d+) pages?/.exec(log);
  const pages = written ? Number(written[1]) : log.includes('No pages of output.') ? 0 : null;
  for (let i = 0; i < raw.length; i++) {
    const at = i;
    let line = raw[i] ?? '';
    // A message carries on in the lines below it while each is cut at the
    // width. An error's context is two lines of exactly that width by design,
    // so it is never joined: only an error's or a warning's own line is.
    if (/^(! |LaTeX |Package |Class |pdfTeX |Missing character: )/.test(line)) {
      while ((raw[i] ?? '').length === LOG_WIDTH && i + 1 < raw.length) line += raw[++i] ?? '';
    }
    if (/^!\s+==> Fatal error occurred/.test(line)) fatal = true;
    else if (line.startsWith('! ')) {
      // ZeroTeX's log also cuts an error's message short of the width, at
      // whatever column its log stream thinks it is in (69, 41, 36 characters
      // seen). So the message takes every line below it until the error's
      // context begins. A line that starts with spaces is a `\MessageBreak`
      // and joins with a space; any other carries on mid-word.
      while (i + 1 < raw.length && !ERROR_CONTEXT.test(raw[i + 1] ?? '')) {
        const next = raw[++i] ?? '';
        line += /^\s/.test(next) ? ` ${next.trim()}` : next;
      }
      let error: TexError = { message: line.slice(2).trim() };
      // Its line is the first `l.<n>` below it, before the next error begins.
      for (const next of raw.slice(i + 1, at + 20)) {
        if (next.startsWith('! ')) break;
        const where = /^l\.(\d+)/.exec(next);
        if (!where) continue;
        const number = Number(where[1]);
        const text = source?.[number - 1]?.trim().slice(0, 240);
        error = { ...error, line: number, ...(text === undefined ? {} : { source: text }) };
        break;
      }
      errors.push(error);
    } else if (/^(LaTeX( Font)?|Package \S+|Class \S+|pdfTeX) [Ww]arning/.test(line)) {
      // A package breaks a long warning with `\MessageBreak`, and each line it
      // carries on in starts with the package's name in parentheses. A warning
      // the log cut short (it does not yet end in a full stop) carries on in
      // the next line, unless that line starts something else.
      for (;;) {
        const next = raw[i + 1] ?? '';
        if (/^\([^()\s]+\)\s/.test(next)) line += ` ${(raw[++i] ?? '').replace(/^\([^()\s]+\)\s+/, '')}`;
        else if (!/\.\s*$/.test(line) && next.trim() !== '' && !NEW_ENTRY.test(next)) line += raw[++i] ?? '';
        else break;
      }
      warnings.push(line.trim());
    } else if (/^(Overfull|Underfull) \\[hv]box/.test(line)) {
      if (line.startsWith('Overfull')) overfull++;
      else underfull++;
      const report = boxReport(line);
      if (report) boxes.push(report);
    } else if (line.startsWith('Missing character: ')) {
      // The message ends at its `!`; a page's `[n` can follow on the same line.
      missing.push(line.slice('Missing character: '.length).replace(/!.*$/, '!').trim());
    }
  }
  return { pages, errors, fatal, warnings, overfull, underfull, boxes, missing };
};

/** How a compile came out (`CellStatus`), with the reading of its log. */
export const statusOf = (result: RawResult): { readonly status: CellStatus; readonly reading: LogReading } => {
  const reading = readLog(result.log);
  const pages = reading.pages ?? result.pages;
  const status: CellStatus =
    result.threw !== undefined ? 'threw' : reading.errors.length > 0 ? 'errors' : (pages ?? 0) > 0 ? 'ok' : 'no-output';
  return { status, reading: pages === reading.pages ? reading : { ...reading, pages } };
};

/** A message with its numbers and quoted names taken out, so the same message groups. */
export const shapeOf = (message: string): string =>
  message.replace(/`[^']*'/g, "`…'").replace(/\d+/g, '#').replace(/\s+/g, ' ').trim();
