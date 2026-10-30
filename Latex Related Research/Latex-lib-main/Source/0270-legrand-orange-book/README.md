# Legrand Orange Book

**This is a substitute, not the original.** The template historically served
at this URL was Mathias Legrand's "The Legrand Orange Book"
(LaTeXTemplates.com), licensed CC-BY-NC-SA — non-commercial, so it cannot be
redistributed here. This download is a different, permissively-licensed book
template of the same kind: `Pseudomanifold/latex-mimosis` (MIT), restructured
here as a general multi-part book rather than a thesis.

Two other slugs on this site (`masters-doctoral-thesis`, `maggi-memoir-thesis`)
are also based on mimosis but are structured differently — see their own
READMEs.

## Files

- `main.tex` — the book. Start here.
- `mimosis.cls` — the document class (bundled; not on CTAN).
- `Sources/Title.tex` — a plain book title page (no thesis submission
  wording).
- `Sources/Preface.tex` — an unnumbered preface.
- `Sources/PartOne.tex`, `Sources/PartTwo.tex` — two parts, each opening
  with a chapter epigraph.
- `references.bib` — bibliography, cited from `Sources/PartOne.tex`.

## Building

    pdflatex main
    bibtex   main
    pdflatex main
    pdflatex main

Upstream's own thesis document uses `biblatex` + `biber`. This starter uses
plain `natbib` + `bibtex` instead: the compiler behind this site runs a fixed
`pdflatex → bibtex → pdflatex → pdflatex` cycle with no `biber` pass, so a
biblatex bibliography would never actually resolve here. `mimosis.cls` itself
is unmodified.

## Structure

What differentiates this from the thesis starter on this site: `\part`
divisions instead of a flat chapter sequence, a conversational unnumbered
preface instead of a submission-style abstract, chapter epigraphs (via the
`epigraph` package, not used by the thesis starter), and a burnt-orange
accent colour instead of royal blue.

## Fonts

Compiles under pdflatex, so it uses the class's pdflatex-compatible font
setup: EB Garamond (`ebgaramond` package) for text, Source Code Pro
(`sourcecodepro` package) for monospace — both resolved from TeX Live by
package, not by system font name.

## Licence

`latex-mimosis` is licensed **MIT**, © Bastian Rieck. Source:
https://github.com/Pseudomanifold/latex-mimosis

This starter document is a minimal example written for latextemplates.com and
carries no additional restrictions.
