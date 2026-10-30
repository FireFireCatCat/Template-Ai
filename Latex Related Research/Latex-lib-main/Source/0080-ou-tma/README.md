# OU TMA

A Tutor-Marked-Assessment layout for Open University courses: a title
block built from your name, personal identifier, module code and TMA
number, plus `question`/`qpart`/`qsubpart` environments that auto-number
in the University's own conventions (`1(ii)(c)` with the `roman` option,
or `1(b)(iii)` by default), and a small set of maths-notation helpers.

## Files

- `main.tex` — the assessment. Start here.
- `ou-tma.sty` — the vendored package (not on a default TeX Live
  install).

## Building

    pdflatex main

## Options

- `roman` — numbers sub-parts `(i)`, `(ii)`, `(iii)`, ...
- `alph` (default) — numbers sub-parts `(a)`, `(b)`, `(c)`, ...
- `pdfbookmark` — adds a PDF bookmark for each question.
- `cleveref` — integrates with the `cleveref` package for `\cref`
  references.

Pass an optional numeric argument to `\question` or `\qpart` to skip
ahead in the numbering (e.g. `\question[3]` jumps straight to question 3,
useful when only answering a subset of a paper's questions).

## Licence

LPPL-1.3c or later, © 2025 G. I. Riley.
Source: https://github.com/GeoffRiley/tma
