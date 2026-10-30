# stylish-article

**This is a substitute, not the original.** The template historically
served at this URL was "Stylish Article" (Vel's `SelfArx.cls`). That
original is licensed **CC-BY-NC-SA (non-commercial)**, and this site
cannot redistribute non-commercial content. This download is a
different colourful article class — the upstream `lebhart` class (part
of the `colorist` series, LPPL-1.3c) — not a recreation of the
original's design.

## Files

- `main.tex` — the article. Start here.

## Engine: XeLaTeX or LuaLaTeX, not pdflatex

`lebhart` loads `fontspec` and ships its own OpenType fonts (TeX Gyre
Pagella and TeX Gyre Heros, resolved through fontspec's own
`.fontspec` configuration files rather than a bare font-family name),
so it requires XeLaTeX or LuaLaTeX. Compile with:

    xelatex main

(or `lualatex main`). Two passes are enough for cross-references.

## Known upstream defect: `\keywordname`

The TeX Live 2025 build of `colorist-fancy.sty`'s `keyword` environment
references `\keywordname`, but its own language package
(`projlib-author`) only ever defines the plural `\keywordsname` — a
genuine mismatch in the upstream package, not something introduced
here. `main.tex` works around it with one line,
`\providecommand{\keywordname}{Keywords}`, before `\begin{keyword}`.

## The class is deliberately NOT included

`lebhart.cls` and its dependency, `ProjLib`, ship with TeX Live, so this
download does not bundle a copy. If your distribution does not have it:
https://ctan.org/pkg/lebhart

## Licence

`lebhart` is licensed **LPPL-1.3c**, © Jinwen XU. The class is not
redistributed here; see https://ctan.org/pkg/lebhart.

This starter document is a minimal example written for latextemplates.com
and carries no additional restrictions.
