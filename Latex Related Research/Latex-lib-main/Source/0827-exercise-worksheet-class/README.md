# Exercise Worksheet Class

A weekly problem-set layout with matched `exercise`/`solution`
environments: each exercise can hold nested `questions`, each solution can
hold matching nested `answers`, both auto-numbered and cross-linked
(`2.1`, `2.2`, ...). Solutions typeset in a distinct colour and can be
switched off entirely (for a clean student handout) via a class option.

## Files

- `main.tex` — the worksheet. Start here.
- `worksheet.cls` — the vendored document class (not on CTAN; distinct
  from the CTAN `worksheet` package shipped elsewhere on this site under
  the plain `worksheet` slug — same filename, different package).
- `LICENSE` — upstream GPL-3.0 licence.

## Building

    pdflatex main

## Solutions on/off

`\documentclass[solutions]{worksheet}` (used here) typesets every
`solution` block. Drop the option (or use `nosolutions`) to produce a
clean exercise sheet with no answers, from the same source file.

## Licence

GPL-3.0. Source: https://github.com/kryzar/worksheet
