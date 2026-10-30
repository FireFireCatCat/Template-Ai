# schooldocs

A page-layout package for school documents with several named title/page
styles (`classic`, `elegant`, `modern`, `soft`, `collection`, and a
dedicated `exam` style used here), each with its own header, footer and
title formatting. A `\correct` toggle switches the same source file into
an instructor answer-key layout.

## Files

- `main.tex` — the test. Start here.
- `schooldocs.sty` — the vendored package (not on a default TeX Live
  install).

## Building

    pdflatex main

## Page styles

Set `\pagestyle{exam}` (used here), `classic`, `elegant`, `modern`,
`soft`, or `collection` for a different header/footer/title look. The
`exam` style adds a `\subtitle{}` line under the date, used here for the
exam duration.

## Answer key

Uncomment `\correct` in the preamble to switch the title block into a
correction/answer-key presentation, from the same source file.

## Licence

LPPL-1.3 or later, © 2020-2025 Antoine Missier.
Source: https://ctan.org/pkg/schooldocs
