# ASCE-style engineering manuscript starter (ascelike)

A starter for civil and structural engineering manuscripts in the American
Society of Civil Engineers format, using the `ascelike` document class.

## Files

- `main.tex` — the manuscript. Start here.
- `references.bib` — bibliography, cited from `main.tex`.

## The class is deliberately NOT included

`ascelike.cls` ships with every modern TeX distribution, so this download does
not bundle a copy. Shipping one would pin you to whatever version we packaged
rather than the version your own system already has.

If your distribution does not have it: https://ctan.org/pkg/ascelike

## `ascelike` is unofficial

The class approximates ASCE's manuscript requirements and says so itself — it
is not published by ASCE. Check the society's current author guidelines before
submitting; they are the authority on what the journal will accept.

## Building

    pdflatex main
    bibtex   main
    pdflatex main
    pdflatex main

Three LaTeX passes: one to collect labels and citations, `bibtex` to build the
bibliography, then two more to resolve every reference. Fewer passes leave `??`
in the output.

## Review and camera-ready modes

The class option at the top of `main.tex` switches layout:

- `Review` — double spaced with numbered lines, which is what ASCE asks for at
  submission.
- `NewProof` — the single-spaced camera-ready form.

## Authors

The class uses `authblk`: declare `\author[n]{...}` and `\affil[n]{...}`
separately. Do not use `\thanks` or `\and` for affiliations — `authblk`
collects the lists itself and those break `\maketitle`.

## Licence

`ascelike` is licensed **LPPL-1.3**, © Matthew R. Kuhn. The class is not
redistributed here; see https://ctan.org/pkg/ascelike.

This starter document is a minimal example written for latextemplates.com and
carries no additional restrictions.
