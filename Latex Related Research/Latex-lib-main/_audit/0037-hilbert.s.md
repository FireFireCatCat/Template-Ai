# Skeptic audit: 0037-hilbert (analyst said yes)

Result: not refuted. Read-only; nothing compiled. Rubric, lib (v2), Solution/0037-hilbert.md and every file of Source/0037-hilbert/ (14 files, one .cls) read in full.

## What I searched for

- Artwork: grep for tikz, pgf, picture, pstricks, eso-pic across the zip: no hit. No `ART`.
- External tools: grep for write18, shell-escape, minted, `\immediate`, `\directlua`, `\ExplSyntax`: no hit. No Makefile, script or font file in the zip (`find` lists 14 files, all .tex/.cls/.md). No `EXTERNAL`.
- Kernel and package internals: grep for `\@startsection`, `\@maketitle`, `\@makecaption`, `\@seccntformat`, `\patchcmd`, `\xpatch`, `\newcounter`, `\newif`: no hit. The only `\def` are the option plumbing at hilbert.cls:14-16. The only conditional the class writes is `\ifodd\c@page` (hilbert.cls:51), inside the `\cleardoublepage` redefinition.
- Packages loaded vs component map: etoolbox, changepage, calc, geometry, inputenc, fontenc, sourcesanspro, libertine, newtxmath, inconsolata, parskip, setspace, microtype, babel, xcolor, fancyhdr, titletoc, titlesec, enumitem, booktabs, tabularx, caption, hyperref (hilbert.cls:27-29, 34-46, 61-73, 80, 109, 143, 154, 235, 244, 259, 261). All are mapped, or (etoolbox, calc) listed under Bespoke code as unused. Nothing missing. `array` comes in through tabularx.
- Ways: every way id the file uses exists in `_Lib.md` (including `pg.emptypage`, `page.adjustwidth`, `sp.rule`, `sp.manual-space`, `front.titlepage-env`, `toc.titletoc`). The file says Lib v1; the lib is now v2, and none of the ways used changed. `emptypage` is on CTAN (ctan.org/pkg/emptypage, version 1.2, read once).
- Text addressed to an AI: none in README.md, main.tex or the class comments.

## The weakest point (not a blocker)

hilbert.cls:198-219 redefines `\frontmatter`, `\mainmatter`, `\backmatter` to flip book's `\@openrightfalse` / `\@openrighttrue` mid-document. That is class-internal conditional state, so it is the one place the rubric's "conditionals that drive what is printed" could bite. I traced it against book's own definitions:

- `\frontmatter`: `\oldfrontmatter` does `\cleardoublepage`, then open-any starts. With `openany` plus the book `\frontmatter` the result is the same.
- `\mainmatter`: book's version ends with `\cleardoublepage`, so the first main-matter chapter is on a right page either way. The later chapters (thelastcall, theinterpreter, postcardsfromnowhere, `main.tex:27-29`) need an explicit `\cleardoublepage` under `openany`.
- `\backmatter`: the old command runs while the flag is still true, so it does a `\cleardoublepage`. Under `openany` that needs an explicit `\cleardoublepage` before `\backmatter`. Acknowledgements then opens with `\clearpage` and About the Author on the next page, as in the original.

The flag changes only at three fixed structural points, so the emitter can write plain `\cleardoublepage` (`pg.break`) at known positions. The analyst's reduction holds, and the file already flags it as the least certain spot. A stricter reading of "kernel-internal redefinition" would push it toward `BESPOKE/class`; I do not read the rubric that way, since the effect is a composition of `class.book` option and `pg.break`.

The `\cleardoublepage` redefinition (hilbert.cls:49-56) matches what `emptypage` does, plus the `\if@twoside` test. The class is always twoside (no `oneside` option is declared, hilbert.cls:7-20), so nothing is lost.

## Small looseness in the file (no verdict effect)

- `front.maketitle` row: `\maketitle` is never called, and the class's `\title[short]{long}` is not the kernel signature (hilbert.cls:95-99). The row is really "data macros". The Bespoke table says so, which is enough.
- `front.titlepage-env` for the half-title, full-title, copyright and dedication pages: no `titlepage` environment is used; they are `\clearpage` ... `\clearpage` hand-laid pages. The lib's own wording ("hand-laid") covers it.
- Licence MIT rests on main.tex:9 and README.md:35-38 only; there is no LICENSE file in the zip.
- I did not re-read ctan.org/pkg/hilbert (my reads went to emptypage). The README says "Not on CTAN" (README.md:33, main.tex:6). If it were on CTAN the verdict would not change.

## Citations

Compared 40 file:line citations against the source; 0 wrong. They include: hilbert.cls:21, 34-46, 49-56, 61-68, 70-75, 80-90, 95-104, 109-138, 143-149, 154-173, 178-192, 198-221, 226, 228-230, 235-239, 244-254, 259, 261-266, 7-20, 27-29; main.tex:10, 16-22, 26, 31; additional/metadata.tex:4-13; copyright.tex:7-9; fulltitle.tex:7,10; dedication.tex; thelastcall.tex:4-8; postcardsfromnowhere.tex:7,15,28; chapter/foreword/preface/about/acknowledgements line 2. Every quoted parameter (geometry values, colours, fancyhdr fields, titlesec and titletoc arguments, caption options, hyperref options) matched.

## Missed blockers

none
