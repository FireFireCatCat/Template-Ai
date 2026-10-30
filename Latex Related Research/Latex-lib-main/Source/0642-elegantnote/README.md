# ElegantNote

A lightweight lecture/reading-notes class from the ElegantLaTeX family
— `article`-based (sections, not book chapters), with a themed title
page, theorem/definition/example/remark/note environments, and
`biblatex` bibliography support.

Not really book-structured in the way the rest of this category is:
it is a *notes* companion to ElegantBook, included here because that
is where the upstream research placed it. If you need chapters and
front/main/back matter, see `kaobook`, `elegantbook`, or `amsbook`
instead.

## Class

Not bundled — ships with TeX Live. Class documentation: `texdoc
elegantnote`.

## Bibliography backend

Passed the class's own `bibtex` option explicitly
(`\documentclass[...,bibtex]{elegantnote}`): the class defaults to
`backend=biber`, which this site's compile pipeline does not run.

## Licence

LPPL-1.3c or later, verified in the upstream repo's own `License` file
and `README.md`. Authors: Dongsheng Deng, Ran Wang.

## Build

```
pdflatex main && bibtex main && pdflatex main && pdflatex main
```
