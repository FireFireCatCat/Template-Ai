# UCAS Homework (homework.sty)

A starter for University of Chinese Academy of Sciences coursework,
adapted from Josh Davis's well-known `homework.sty` template (the
vendored file's own header credits Josh Davis, 2014) with CJK support
added for UCAS.

## Files

- `main.tex` — the assignment. Start here.
- `homework.sty` — the style file, vendored (see below).

## The style file is vendored

`homework.sty` is not on CTAN, so it is bundled here rather than left
to a system install.

## Engine: xelatex — required

The style loads `fontspec` and `ctex` (`\usepackage[UTF8]{ctex}`) for
Chinese support; both need XeTeX or LuaTeX.

## Building

    xelatex main
    xelatex main

## The font trap — patched

The original upstream `homework.sty` called `\setmonofont{Consolas}`
for code listings. Consolas is a Windows-only commercial font, absent
from this (and most Linux) TeX installations by both fontconfig and
kpathsea — confirmed via `fc-list` and `kpsewhich` in the pinned
compile image, where fontspec would hard-error "cannot be found."
Patched in `homework.sty` to `DejaVu Sans Mono`, which resolves both
ways and ships with every modern TeX distribution. See the `PATCH`
comment in `homework.sty` for the exact change.

## This starter has no external assets

The upstream repository's example title page includes a raster UCAS
logo image, and its example body is split across `\include{chapters/
ch01}`. Neither is part of this starter — the title uses plain text,
and the sample content (asymptotic notation, a recursion-tree
derivation, and a Master Theorem check) is written directly into
`main.tex`, so the download has zero external file dependencies.

## Usage

- `\hmwkClass`, `\hmwkTitle`, `\hmwkSubTitle`, `\hmwkCompleteTime`,
  `\hmwkClassInstructor`, `\hmwkAuthorName`, `\hmwkAuthorStuID` —
  `\renewcommand` each before `\begin{document}` to set the title page
  and running header.
- `\begin{homeworkProblem}...\end{homeworkProblem}` — auto-numbered
  problem sections with a "Problem N continued on next page..."
  running header via `extramarks`.
- `\solution` — a bold "Solution" header (not an environment).
- `\part{}` is redefined to a lettered `Part A`, `Part B`, ... heading.

## Licence

MIT — the vendored `homework.sty`'s own header credits Josh Davis
(2014) as the original template author; the UCAS adaptation is by
Zhenyang Huang, also MIT. See
https://github.com/HuangZhenyang/Latex-Template-for-UCAS-Homework.

This starter's content (an algorithms problem set) was written for
latextemplates.com and carries no additional restrictions.
