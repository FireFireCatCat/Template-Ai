# Edinburgh Maths thesis starter (edmaths)

A starter for a University of Edinburgh School of Mathematics thesis or
report, using the official `edmaths` style: the School's title page, the
standard declaration, abstract, lay summary, acknowledgements, numbered
chapters and an appendix.

Despite the name under which it was originally catalogued, `edmaths` is **not
a Beamer theme** — it is a thesis/report style, and this starter is filed
accordingly.

## Files

- `main.tex` — the thesis. Start here.

## The style is deliberately NOT included

`edmaths.sty` ships with TeX Live, so this download does not bundle a copy.
Shipping one would pin you to whatever version we packaged rather than the
version your own system already has.

If your distribution does not have it: https://ctan.org/pkg/edmaths

## Building

    pdflatex main
    pdflatex main
    pdflatex main

Three passes so the table of contents and every cross-reference resolve.
Fewer passes leave `??` in the output.

## It is a style over `report`, not a class

`\usepackage{edmaths}` is loaded on top of `\documentclass{report}`. The base
class is not interchangeable: the package defines its `abstract`,
`laysummary`, `acknowledgements` and `declaration` environments in terms of
`\chapter*`, so loading it over `article` fails on the first undefined
`\chapter`.

## Three traps worth knowing

**`\title` and `\author` must come *before* `\usepackage{edmaths}`.** This
reverses the usual habit and is not optional when the `hyperref` option is
used: the package bakes `\@title` and `\@author` into `pdftitle`/`pdfauthor`
at load time, and if they are still unset it embeds LaTeX's own
"No \title given" warning text instead — whose stray braces end the run with
`! Too many }'s` and no PDF at all.

**The degree option is required.** It fills the title page's degree line via
`\degreetext`. With no degree option the cover prints the literal text
`Specify a degree option!`, which compiles perfectly cleanly. The choices are
`phd`, `masterph`, `mastersc`, `mmath`, `y4project`, and `firstyear` /
`secondyear` / `thirdyear` for Maxwell Institute annual reports.

**`edmaths` declares no theorem environments.** It loads `amsthm` but leaves
the `\newtheorem` declarations to you, so `theorem` is undefined until you
write them — this starter declares theorem/lemma/corollary/definition in the
preamble. `proof` comes from `amsthm` and works without any declaration.

`amsmath`, `amssymb`, `amscd`, `amsthm`, `geometry`, `ifthen` and `setspace`
are all loaded by the package; none of them needs a `\usepackage` of its own.

## No University crest

The upstream repository carries two University of Edinburgh logo SVGs which
are not redistributable, and TeX Live does not install them. This starter
bundles no logo and does not reference one; the title page above is the
package's own, which is text-only.

## Before you submit

Replace the placeholder title, author and date, choose the right degree
option, and check the School of Mathematics' current submission requirements —
margins and required front matter are set by the School and change between
years.

## Licence

`edmaths.sty` is licensed **LPPL-1.3-or-later**, © 2025 Josh Fogg, originally
written by Thomas Koeppe in 2007. The style is not redistributed here; see
https://ctan.org/pkg/edmaths.

This starter document is a minimal example written for latextemplates.com and
carries no additional restrictions.
