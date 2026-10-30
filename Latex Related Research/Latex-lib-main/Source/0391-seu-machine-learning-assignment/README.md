# SEU Machine Learning Assignment (seu-ml-assign)

A starter for Southeast University (SEU) machine learning coursework,
using the official `seu-ml-assign` document class by Teddy van Jerry
(Wuqiong Zhao).

## Files

- `main.tex` — the assignment. Start here.

## The class is deliberately NOT included

`seu-ml-assign.cls` ships with every modern TeX distribution, so this
download does not bundle a copy.

If your distribution does not have it: https://ctan.org/pkg/seu-ml-assign

## Building

    pdflatex main
    pdflatex main

## This starter is in English — the class's `lang=cn` option is broken

The class's own header states it compiles under
latex/pdflatex/xelatex/lualatex, and its default mode (no `lang=`
option, used here) is genuine, working English.

Its **Chinese mode is not**. `lang=cn` is meant to
`\RequirePackage{ctex}` and localise the default course name to
Chinese, but the check that decides this —
`\ifx\@@lang\@@lang@cn` — never evaluates true when `\@@lang` was set
through the class's own `xkeyval`-based option machinery, even though
an equivalent plain `\def`/`\ifx` comparison outside that machinery
does work (confirmed with an isolated minimal test). The practical
effect: `\documentclass[lang=cn]{seu-ml-assign}` **compiles with zero
errors or warnings**, but `ctex` never loads, no CJK font is active,
and **every Chinese character in the document silently renders as
nothing** — not tofu boxes, just missing text, with the header falling
back to the English default "Machine Learning" title. This is exactly
the "clean compile, wrong render" failure mode: only visible by
actually looking at the rendered PDF.

Because of this, the starter here uses the class's default (working)
English mode rather than shipping a Chinese assignment that would
silently lose its own content. If you need Chinese and are willing to
work around the bug yourself, the fix used to reproduce and diagnose
this was to bypass the class's own option and load `ctex` directly:

    \documentclass[oneside,solution]{seu-ml-assign}
    \RequirePackage{ctex} % load AFTER \documentclass, since the class's
                            % own conditional load never fires

and set `\def\@course@default{...}` yourself if you want the
localised default course name — engine must then be xelatex or
lualatex.

## Usage

- `\studentID{}`, `\instructor{}`, `\duedate{}`, `\assignno{}`,
  `\semester{}`, `\mainproblem{}` — header metadata.
- `\problem{Title}` / `\subproblem{}` / `\subsubproblem{}` — numbered
  problem headers (section/subsection/subsubsection under the hood).
- Standard `amsthm` `proof` environment for worked solutions, with a
  QED tombstone.
- Class options: `solution` (used here, shows worked solutions) vs.
  `problem` (hides them, for a student-facing blank copy); `oneside`/
  `twoside`.

## Licence

`seu-ml-assign` is licensed **MIT**, © Teddy van Jerry (Wuqiong Zhao).
The class is not redistributed here; see
https://ctan.org/pkg/seu-ml-assign.

This starter document is a minimal example written for latextemplates.com
and carries no additional restrictions.
