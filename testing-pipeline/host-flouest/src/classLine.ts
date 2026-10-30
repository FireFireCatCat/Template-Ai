/**
 * General's LaTeX for a document, and that LaTeX under a class setting and a
 * setup: the class line swapped for the class setting's, with the setup's
 * options, and the preamble lines after it (`Host.emit`).
 */
import { docJsonToLatex } from '@flouest/app/src/lib/latex.ts';
import type { ClassSetting, Setup } from 'compat-core';

/** The document's LaTeX under General, from the app's own compiler. */
export const generalLatex = (doc: Record<string, unknown>): string => {
  const result = docJsonToLatex(doc, null, {});
  if (!result.ok) throw new Error(`Flouest's compiler refused the document: ${result.errors}`);
  return result.latex;
};

const CLASS_LINE = /^\\documentclass(\[[^\]]*\])?\{[^}]*\}[^\n]*$/m;

/**
 * `latex` with its class line replaced by the class setting's, with the
 * setup's options applied. After it come the class setting's preamble lines,
 * the setup's, then `preamble` (core's sentinel macro, `EmitUnder.preamble`).
 */
export const withClass = (latex: string, classSetting: ClassSetting, setup: Setup, preamble: readonly string[] = []): string => {
  if (!CLASS_LINE.test(latex)) throw new Error('withClass: the LaTeX has no \\documentclass line');
  const options = [...classSetting.options.filter((o) => !setup.removeOptions.includes(o)), ...setup.addOptions];
  const line = `\\documentclass${options.length > 0 ? `[${options.join(',')}]` : ''}{${classSetting.class}}`;
  return latex.replace(CLASS_LINE, () => [line, ...classSetting.preamble, ...setup.preamble, ...preamble].join('\n'));
};
