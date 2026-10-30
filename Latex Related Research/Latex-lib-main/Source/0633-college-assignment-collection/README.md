# College Assignment Collection (compact report layout)

A starter adapted from Bimalka Piyaruwan's "2 Pages Compact" assignment
layout — a two-column engineering-report style with settings split
across `settings/packages.tex`, `settings/page.tex` and
`settings/macros.tex`.

## Files

- `main.tex` — the report. Start here.
- `reference.bib` — bibliography, cited from `main.tex`.
- `settings/packages.tex`, `settings/page.tex`, `settings/macros.tex` —
  package loads, page geometry, and a few custom math macros
  (`\bbR`, `\bbN`, ... for blackboard-bold letters), kept as separate
  files matching the upstream layout.

## No custom document class

This template does not define its own `.cls` — it is a plain `article`
with a `\input{settings/...}` split, so there is no filename-collision
risk and nothing needs to be bundled beyond the settings files
themselves.

## The figure is drawn with TikZ, not a raster image

The upstream template's example figures are `.png`/`.jpg` files
referenced via `\includegraphics`. Shipping those specific images here
would tie the starter to unrelated example content, so this download's
one figure (the RC filter circuit) is drawn directly in TikZ instead —
the download has no external asset dependencies at all.

## Building

    pdflatex main
    bibtex   main
    pdflatex main
    pdflatex main

## Usage

- Two-column `article` layout (`twocolumn` class option) — good for
  short, information-dense reports; drop the option for a single-column
  layout.
- `natbib` with `authoryear` citations (`\citep{}`) and the bundled
  `abbrvnat` bibliography style.
- `\bbR`, `\bbN`, `\bbZ`, ... — blackboard-bold letters for common
  number sets, defined in `settings/macros.tex`.

## Licence

MIT, © 2021 Bimalka Piyaruwan — see
https://github.com/bimalka98/LaTeX-Templates.

This starter's content (an RC filter design report) was written for
latextemplates.com and carries no additional restrictions.
