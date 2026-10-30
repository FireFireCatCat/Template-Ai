# vienna-cs-thesis

**This is a substitute for the custom class, not the whole original.**
A University of Vienna Faculty of Computer Science-style thesis:
title page, acknowledgements, English abstract, German
"Kurzfassung", table of contents, an acronym list, chapters covering
tables/listings/algorithms, and an appendix.

## Files

- `main.tex` — the thesis. Start here.

## Building

    pdflatex main
    pdflatex main
    pdflatex main

Three passes resolve the table of contents and cross-references.

## What differs from the original template

The upstream template loads a custom `UniVieCS_Thesis` document class
(with separate BSc/PhD title-page variants and the `glossaries`
package wired up for acronym/glossary generation). That class file
could not be obtained for this starter, so it is built on plain
`report` instead, with the same front-matter/chapter/back-matter shape
reproduced by hand. The acronym list is a plain table rather than the
`glossaries` package, because `glossaries`' entry lists require an
external `makeglossaries` build pass this pipeline does not run — using
the real package here would silently render an empty list.

## Licence

Based on the Overleaf gallery template "Thesis Template — Faculty of
Computer Science, University of Vienna":
https://www.overleaf.com/latex/templates/thesis-template-faculty-of-computer-science-university-of-vienna/whyzmtqggxzz

The uploader is the Faculty itself (contact
helpdesk@cs.univie.ac.at) rather than a third party — the licence
holder here is the University of Vienna Faculty of Computer Science.
No separate hosting location for this template was found outside
Overleaf; the gallery page above is the only known distribution point.

**CC-BY-4.0.**
