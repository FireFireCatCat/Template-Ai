# easybook

A pure academic book class for Chinese theses or books, built on
`ctexbook` — `\frontmatter`/`\mainmatter` with custom TOC/title-page
handling, and a `scheme=chinese`/`font=auto` option pair chosen for
sensible defaults out of the box.

## Class

`easybook` is **not bundled** — it ships with TeX Live
(`texmf-dist/tex/latex/easybook/`). Class documentation: `texdoc
easybook`.

## CJK fonts

Uses the class's own `font=auto`/`cjkfont` resolution against TeX
Live's bundled fonts (Fandol, via kpathsea) — verified rendering real
Chinese glyphs in the preview, not tofu boxes.

## Licence

LPPL-1.3c, (c) 2021-2025 Qu Yi, verified in the upstream CTAN package's
own `README.md` and the class file's own header comment.

## Build

```
xelatex main && xelatex main
```
