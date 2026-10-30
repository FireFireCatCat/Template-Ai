# Ars Classica Article

A short article/paper styled with the **arsclassica** appearance of the
`classicthesis` package: small-caps headings, a Palatino-metric body face,
and restrained, ruled typography inspired by Bringhurst's *The Elements of
Typographic Style*.

## Files

- `main.tex` — the article. Start here.
- `classicthesis.sty`, `classicthesis-arsclassica.sty` — vendored from CTAN's
  `classicthesis` package (v4.8, 2025). The modern classicthesis already
  bundles the arsclassica re-styling (originally a separate `arsclassica`
  package by Lorenzo Pantieri) as a `\usepackage[style=arsclassica]` option,
  so only these two files are needed — not a separate `arsclassica.sty`.
- `references.bib` — bibliography, resolved via classic `bibtex`.
- `LICENCE` — classicthesis's own `COPYING` (GNU GPL v2-or-later).

## Building

    pdflatex main
    bibtex   main
    pdflatex main
    pdflatex main

## Licence

**GPL-2.0-or-later.** `arsclassica` itself is LPPL, but it hard-requires
`classicthesis` (`\RequirePackage{classicthesis}`), which is GPL-2.0-or-later
— so the combined pair is GPL. See `LICENCE` for the full text. Original
authors: André Miede and Ivo Pletikosić (classicthesis), integrating Lorenzo
Pantieri's arsclassica styling with permission.

Source: https://ctan.org/pkg/classicthesis (classicthesis v4.8, includes the
arsclassica style) and https://ctan.org/pkg/arsclassica (original standalone
package, for reference).

This starter document is a minimal example written for latextemplates.com
and carries no additional restrictions beyond the GPL terms above.
