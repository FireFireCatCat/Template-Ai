# CurrVita

A minimal, typographically careful CV built on the `currvita` CTAN package:
a `cv` environment holding a series of labelled `cvlist` blocks (Personal
Details, Education, Experience, ...), each entry optionally dated in the
left margin. One of the oldest CV packages still on CTAN (1999) and still
current.

By Axel Reichert.

## Files

- `main.tex` — the CV. Start here.

No custom class file is bundled: `currvita.sty` ships with TeX Live.

## The example was rewritten in English

CTAN's own example document (`cvtest.tex`, generated from the package's
`.dtx`) is the package author's real CV, written entirely in German with
`\usepackage[german]{babel}`. Neither is appropriate to redistribute as
starter content: it is someone else's real biographical data, and German
section headings would surprise anyone compiling this expecting English.
The package itself carries no hardcoded language strings — every section
heading is a plain argument to `\begin{cvlist}{...}` — so this starter is
a fictional English CV using the same macros, with `[english]{babel}`.

## Building

    pdflatex main

One pass is enough — no bibliography, no cross-references (the package's
optional `openbib`/`ManyBibs` class options support a publications list via
plain `thebibliography` if you need one).

## Licence

**GPL-2.0-or-later**, © 1999 Axel Reichert — verified in the package's own
README (no separate `COPYING` file ships in the CTAN archive; `LICENSE`
here is the standard GPL-2.0 text the README points to). Because this is a
copyleft licence, the full licence text travels with this download in
`LICENSE`.

This starter document is a fictional example written for
latextemplates.com and carries no additional restrictions.
