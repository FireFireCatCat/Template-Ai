# Xovee LaTeX CV

An academic CV template built as a menu of alternatives: each section (e.g.
Education) is shown in three or four different layouts back to back, so you
pick the one you like and delete the rest, rather than hunting through
commented-out code. Sections cover the full academic path — education,
academic employment, distinctions, service (editor/chair/committee/
membership), publications, invited talks, teaching, industrial experience,
languages and references.

By [Xovee Xu](https://www.xoveexu.com).

## Files

- `main.tex` — the CV. Start here, delete the "(Another Style)" blocks you
  don't want.
- `article.tex` — the publications section, `\input` separately so a long
  list doesn't crowd out the rest of `main.tex`.

Both are rewritten with a fictional CV (Jordan Blake, Cascadia State
University) — the original repository's `cv.tex` and `article.tex` carry
the actual author's own name, contact details, and real publication list,
which is not appropriate to redistribute as example content.

## Font

Uses `ebgaramond`, a real CTAN font-support package loaded by name (not a
bare `fontspec` family), so it resolves under plain pdfLaTeX with no
substitution needed. Upstream's README also mentions the non-free
`garamondx` as an alternative — not used here, since it requires a separate
installer outside this pipeline.

## Building

    pdflatex main

Two passes if you change section headers (for the `\markright` running
header), otherwise one pass is enough — no bibliography package is used,
publications are typed by hand in `article.tex`.

## Licence

**MIT**, © 2021 Xovee. Full licence text:
https://github.com/Xovee/latex-cv/blob/main/LICENSE

This starter document is a fictional example written for
latextemplates.com and carries no additional restrictions.
