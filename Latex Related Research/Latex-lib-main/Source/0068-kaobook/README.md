# kaobook starter

A wide-margin book/notes class: a mini table of contents in the margin at the
start of each chapter, sidenotes, and flexible chapter-heading styles.

## Files

- `main.tex` — the document. Start here.
- `kaobook.cls`, `kao.sty`, `kaorefs.sty`, `kaotheorems.sty` — the vendored
  class and its support packages.

## The class IS bundled (and why)

Unlike a CTAN class, `kaobook` is not on TeX Live — it ships only from its
GitHub repository, so this download vendors the files needed to compile
straight away. `kaobiblio.sty` (bibliography support via `biblatex`+`biber`)
is deliberately **not** included: this starter has no bibliography, so it
avoids a `biber` step entirely. Add `\usepackage{kaobiblio}` yourself if you
need one — see the upstream docs.

## Building

    pdflatex main
    pdflatex main
    makeindex main
    pdflatex main

Two passes to resolve the table of contents and cross-references, then
`makeindex` to build the index, then a final pass to place it.

## Licence

`kaobook` is licensed **LPPL-1.3c**, © Francesco Marotta. The vendored files
are unmodified copies of the upstream class; see
https://github.com/fmarotta/kaobook for the source and full documentation
(the `examples/` directory there has several complete sample books).

This starter document is a minimal example written for latextemplates.com and
carries no additional restrictions.
