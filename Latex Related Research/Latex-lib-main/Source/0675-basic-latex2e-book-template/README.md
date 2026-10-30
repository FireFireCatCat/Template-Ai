# Basic LaTeX2e Book Template

A plain `book`-class starter carrying the package/macro scaffolding most
authors reach for anyway: `ntheorem`-based numbered examples, `algorithm` +
`algpseudocode` pseudocode blocks, `booktabs`/`dcolumn` tables, `natbib`
citations, and `microtype`.

Adapted from [albertopessia/latex-book-template](https://github.com/albertopessia/latex-book-template)
(public domain, Unlicense). The upstream repo is itself a bare skeleton
(lorem-ipsum chapters, a placeholder bibliography entry, and three
debug-only packages — `lipsum`, `refcheck`, `lineno` — meant to be removed
before shipping). This starter keeps the real scaffolding and drops the
placeholder content and debug packages, replacing them with a short worked
example (modular exponentiation, Fermat witnesses) so every macro in the
package set is actually exercised.

## Licence

Public domain (Unlicense). No attribution required, though the upstream
author (Alberto Pessia) is credited above as a courtesy.

## Build

```
pdflatex main && bibtex main && pdflatex main && pdflatex main
```
