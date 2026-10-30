# K. N. Toosi Thesis Template (Persian)

A thesis/dissertation template for K. N. Toosi University of Technology
(Tehran), for BSc/MSc/PhD documents written in Persian with `xepersian`. This
is the only Persian-language thesis template in this catalogue, and Persian
typesetting — including a Persian-collated glossary and bibliography — is the
whole point of it, not an optional extra.

## Files

- `main.tex` — the thesis. Choose `bsc`/`msc`/`phd` as a `\documentclass`
  option; `irfonts` (on by default) selects the vendored IR-series fonts
  under `font/` over the alternative XB Niloofar/Junicode pair.
- `kntu-thesis.cls` — the document class.
- `tex/` — preamble, per-chapter content, title pages (Persian + English),
  glossary/acronym definitions, and `MyReferences.bib`.
- `font/` — vendored fonts (IR Lotus, IR Titr, XB Niloofar, Liberation,
  Junicode, Iran Nastaliq), loaded by explicit `Path={./font/}`. Nothing here
  depends on the compiler image resolving a font by family name.
- `img/` — university logo and figures used by the sample chapters.
- `code/MatlabExample.m` — sample source listed via the `listings` package.
- `xindy/` — a copy of the standard `xindy` driver script, as shipped
  upstream. The pinned compiler resolves `xindy` from `PATH`; this directory
  is vendored source-tree clutter carried forward unmodified rather than
  something this build depends on.
- `build.sh` — the upstream author's own reference build script. Read this
  first if `latexmk`/`build.sh` behaves differently from what is below.

## Building — this needs MORE than one bibtex/xindy pass

This class produces a bibliography, a Persian glossary, an English glossary,
and an acronym list, each through a Persian- or English-collated `xindy` run.
The full sequence (from upstream `build.sh` / `latexmkrc`), in order:

```sh
xelatex main
bibtex8 -W -c cp1256fa main
xindy -L persian-variant3 -C utf8 -I xindy -M main.xdy -t main.glg -o main.gls main.glo
xindy -L persian-variant3 -C utf8 -I xindy -M main.xdy -t main.blg -o main.bls main.blo
xindy -L english          -C utf8 -I xindy -M main.xdy -t main.alg -o main.acr main.acn
makeindex main
xelatex main
xelatex main
```

`bibtex8` (not plain `bibtex`) is required for the `cp1256fa` Persian
codepage; plain bibtex mis-sorts or garbles Persian bibliography entries.
`xindy` (not `makeindex`) is required for the two glossaries because their
sort order is language-aware (Persian collation for the Persian glossary,
English for the acronym list) — `makeindex` alone cannot do that. The plain
`\printindex` still uses `makeindex`, run once at the end.

The easiest way to run all of this locally is `latexmk` with the bundled
`latexmkrc` (already wired to the sequence above):

```sh
latexmk -bibtex -pdf main.tex
```

Building via `build.sh` directly also works and is closer to what upstream
documents. Either way, run enough passes — a single `xelatex` pass alone
will leave the glossaries and acronym list empty and citations unresolved.

## Why this needed image changes to ship here

`xindy` and `bibtex8` are standard TeX Live `scheme-full` components; they
were simply not confirmed to be available in this catalogue's pinned
compiler image, so this template was skipped from an earlier packaging
batch rather than shipped with its Persian indexing/bibliography silently
broken. Both are present in the current pinned image. The zip you are
reading this from is the same source tree upstream ships — build it with
the sequence above, exactly as any user cloning the GitHub repo would.

## Licence

GPL-3.0. Full text in the accompanying `LICENSE` file (from the upstream
repository, https://github.com/msinamsina/kntu-thesis, © Mohammad Sina
Allahkaram). GPL-3.0 permits redistribution and modification under the same
terms; it does not require attribution beyond preserving the licence.
