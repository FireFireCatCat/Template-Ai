# simple-article

A general-purpose research article with theorem environments, a
resolved bibliography, a table, and a figure — natbib plus standard
AMS math packages, no custom class.

## Files

- `main.tex` — the article. Start here.
- `references.bib` — the bibliography database.

## Building

    pdflatex main
    bibtex main
    pdflatex main
    pdflatex main

## Licence

Based on the Overleaf gallery template "A simple article template" by
Duc A. Hoang:
https://www.overleaf.com/latex/templates/a-simple-article-template/gdsdkccmjnxg

The gallery lists this template as CC-BY-4.0, but the template's OWN
source carries a footer notice — reproduced on every page of this
starter — stating **CC BY-SA 4.0**. That embedded notice is more
restrictive than the gallery tag and is the one that governs here: any
copy or derivative of this document must itself be shared under
CC BY-SA 4.0 and must credit Duc A. Hoang. Do not remove the footer
notice without checking your own right to relicense the result.

No separate repository for this template was found; the Overleaf
gallery page above is the only known distribution point.
