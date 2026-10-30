# Pandoc DIN 5008 Letter

A DIN 5008-oriented KOMA letter starter based on the reusable `scrlttr2`
template shipped by the `pandoc-letter-din5008-unb` project. It demonstrates
reference numbers, customer metadata, a subject, address block, enclosure and
copy lines.

This catalogue version is a directly compilable `main.tex`, so it does not
require Pandoc. For a Markdown-first workflow, the upstream project's
`letter.latex` can be installed as a Pandoc template and its YAML variables
can populate the same KOMA fields. See:
https://github.com/p3palazzo/pandoc-letter-din5008-unb

The upstream licence is Creative Commons Attribution-ShareAlike 4.0. Keep the
generated `ATTRIBUTION.txt` with redistributed copies. The sample text and
contact details here are original and fictional.

## Build

    pdflatex main
