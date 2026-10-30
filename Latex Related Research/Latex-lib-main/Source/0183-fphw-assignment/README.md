# FPHW assignment (fphw)

A compact homework/problem-set class: titled header block (course,
professor, institute, due date), boxed `problem` environments, and a
fancy running header/footer. Originally by Felipe Portales-Oliva.

## Files

- `main.tex` — the assignment. Start here.
- `fphw.cls` — the document class, vendored (see below).

## The class is vendored

`fphw` was on CTAN but has since been delisted, so it will not resolve via
`kpsewhich` on a stock TeX Live install. This download bundles the class
directly, sourced from `clbx/Cosmic` (github.com/clbx/Cosmic,
`doc/fphw.cls`), which carries the same file and licence header as the
original CTAN release.

## Building

    pdflatex main

One pass is enough (no bibliography, no cross-references).

## Usage

- `\class{...}`, `\professor{...}`, `\institute{...}` are all optional —
  each line only appears in the title block if set.
- Wrap each question in a `problem` environment to get the boxed style
  used in this starter.
- Pass `spanish` as a class option (`\documentclass[spanish]{fphw}`) to
  localise "Course"/"Professor"/"Due date"/"Student name" to Spanish.
- `twocolumn` and `twoside` are deliberately disabled by the class itself.

## Licence

`fphw.cls` is public domain under **The Unlicense** — see the header
comment in `fphw.cls` for the exact text and https://unlicense.org for the
full licence. No attribution is required, though credit to Felipe
Portales-Oliva is appreciated.

This starter document is a minimal example written for latextemplates.com
and carries no additional restrictions.
