no

# 0470-anton-petrunin-birkhoff: Euclidean plane and its relatives (a minimalist introduction), A. Petrunin

- Unverified: read from the source, not compiled.
- Source: Source/0470-anton-petrunin-birkhoff/ (origin: https://codeload.github.com/anton-petrunin/birkhoff/zip/refs/heads/master; licence: manifest says NOASSERTION, but LICENSE.md:1 and README.md:8 state Creative Commons Attribution-ShareAlike 4.0)
- Kind: book
- Lib: v4
- Engine: pdfLaTeX-compatible (main build, README.md:23); the secondary sample cover/cover.tex needs LuaLaTeX (`fontspec`, cover/cover.tex:1,13)
- Look carried by: mixed (kernel `book` for structure, the zip-local `lectures.sty` for theorems, lists, numbering, contents, emphasis and math macros, the main preamble for geometry)
- Class origin: tex-distribution-unbundled
- Main file: all-lectures.tex (other samples: cover/cover.tex, a separate LuaLaTeX print cover; AA.tex is a stray body fragment, see Notes)
- Read: main partly (all-lectures.tex, title.tex, intro.tex, lectures.sty, cover/cover.tex in full; the 22 chapter files by grep over every environment, definition and command, plus reads of metric.tex 1-260, axioms.tex 1-140, sphere.tex 1-60, hints.tex head and tail and spot checks), zip-local classes and styles all (lectures.sty is the only one)

## Verdict
Every typesetting component of the main sample maps to a lib way, and every zip-local macro in `lectures.sty` and the preamble reduces to lib ways (reductions below), so there is no `UNMAPPED`, no `ART` and no irreducible `BESPOKE`. The answer is still `no` because the document does not build from TeX and the shipped files alone: the two EPS images need the epstopdf/Ghostscript conversion (lib ruling for `fig.epstopdf`), and the 215 MetaPost figures are products of `mpost` runs that the zip does not ship (README.md:17-22). The EPS blocker decides the verdict by itself; the MetaPost blocker is a second, more arguable one (figure artwork is content, see Notes).

## Blockers
- `EXTERNAL/package` EPS images under pdfLaTeX: `\includegraphics[scale=0.5]{pics/by-sa}` (title.tex:12) and `\includegraphics[scale=0.25]{pics/H2checkers_334}` (poincare.tex:6); only `.eps` files are shipped (pics/by-sa.eps, pics/H2checkers_334.eps), README.md:34-36 documents the manual `epstopdf`, and list-of-files.txt names the generated `*-eps-converted-to.pdf`. Lib line `fig.epstopdf`: EXTERNAL when an EPS file is included.
- `EXTERNAL/body` MetaPost figures: 215 `\includegraphics{mppics/pic-N}` calls (for example metric.tex:219, hints.tex:550-560) point at `.mps` files made by `mpost pic.mp` and `mpost pic-hints.mp` (README.md:20-21); the zip ships only the four `.mp` sources (mppics/pic.mp 188 `beginfig`, mppics/pic-hints.mp 37), and the figure labels are typeset by a LaTeX run started inside mpost, which loads `lectures` (mppics/pic.mp:6-12).

## Class setting
- Class: `class.book` options: `twoside` (all-lectures.tex:1); `openany` is set by hand as `\csname @openrightfalse\endcsname` (lectures.sty:81). Kernel class, not in the zip, source not read.
- Class-native vocabulary used: `\chapter`, `\chapter*` (intro.tex:1), `\section`, `\subsection*` (metric.tex:86), `\backmatter` (hints.tex:1), `\maketitle` (title.tex:5), `\tableofcontents` (title.tex:40), `quotation` (absolute.tex:441), `description` (absolute.tex:398), the `theindex` layout reached through `\input{all-lectures.ind}` (all-lectures.tex:65), `\bibname` (all-lectures.tex:67).
- Secondary sample cover/cover.tex: `class.bookcover` (CTAN and TeX Live, Tibor Tomacs, LPPL 1.2, read once at ctan.org/pkg/bookcover; source not in the zip, not read). Options `coverheight=9in, coverwidth=6in, spinewidth=0.53in, bleedwidth=.125in, marklength=0in, markcolor=black` (cover.tex:2-8). Vocabulary: `\newbookcoverpart{name}{\setpartposx \setpartposy \setpartheight \setpartwidth \settrimmedpart}` (cover.tex:15-28), environment `bookcover` (cover.tex:32), `\bookcovercomponent{color|center|normal}{bg whole|spine|pfront|pback}{content}` (cover.tex:35,40,50,74,90).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | all-lectures.tex:1 | `class.book` | twoside; chapters may open on any page (lectures.sty:81) |
| chapter opening side | lectures.sty:81 | `head.class-native` | `openany` equivalent via `\@openrightfalse` |
| page geometry | all-lectures.tex:2,16 | `page.geometry` | paperwidth=6in, paperheight=9in, top=0.9in, bottom=0.9in, inner=0.9in, outer=0.7in |
| geometry change for the hints | all-lectures.tex:55 | `page.geometry` | `\newgeometry{top=0.9in, bottom=0.9in, inner=0.55in, outer=0.45in}`, no restore |
| running heads | none set; default book `headings` style | `hf.class-native` | class default |
| blank copyright page | title.tex:33 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| hyphenation, sloppy | lectures.sty:170-177; title.tex:39; car.tex:187; all-lectures.tex:73 | `sp.hyphenat` | `\hyphenation` list of 7 words (geo-de-sic, Loba-chev-skian...), `\sloppy` groups, `\fussy` |
| manual spacing | lectures.sty:104-106; title.tex:12-15 | `sp.manual-space` | `\smallskip`, `\medskip`, `\bigskip` rebuilt as `\vskip\...amount`; `\null\vfill`, `\vspace*{1mm}`, `\vskip-6mm` style trims (hints.tex, metric.tex) |
| paragraph and list lengths | lectures.sty:181-191 | `sp.lengths` | see list row |
| alignment | metric.tex:218, intro.tex:52 | `sp.ragged` | `\centering` in figures |
| encodings | lectures.sty:24-27 | `font.fontenc-t1` | `utf8`; `T1,T2A`; `\DeclareUnicodeCharacter{2010}{-}`; no text-face package (default Computer Modern) |
| size and face switches | all-lectures.tex:57,64; lectures.sty:85; title.tex:1-3 | `font.size-commands`, `mark.kernel` | `\footnotesize` for hints, `\scriptsize` for the index, `\small` toc entries; `\tt` on title, subtitle, author |
| colour | lectures.sty:5,9-15 | `color.color` | package `color`; every link colour set to black |
| languages | lectures.sty:26,42 | `lang.babel`, `lang.csquotes` | `russian,german,english` (english main); `csquotes` loaded, quotes typed as ``...'' |
| PDF metadata and links | lectures.sty:8-18; all-lectures.tex:4-7; complex.tex:355 | `meta.hyperref` | pdfauthor, colorlinks, black link colours, `unicode`, `linktocpage`, `breaklinks=true`, pdftitle; `\href`, `\phantomsection` |
| bookmarks | lectures.sty:19; title.tex:38 | `meta.bookmark` | `\pdfbookmark[0]{\contentsname}{bm:toc}` |
| accessible text for emphasis | lectures.sty:91,96-98 | `meta.accsupp` | `\BeginAccSupp{method=escape,ActualText={\detokenize{#1}}}` |
| title block | title.tex:1-5 | `front.maketitle` | `\title{\tt ...}`, `\author{\tt ...}`, `\date{}` |
| subtitle | lectures.sty:70-76 | `front.titling` | `\posttitle{\par\end{center}\begin{center}\large#1\end{center}\vskip0.5em}` |
| copyright and licence page | title.tex:12-19,33-34 | `front.dedication`, `fig.graphicx`, `box.minipage` | hand-written CC BY-SA text in `\parbox{.7\textwidth}`, badge `\includegraphics[scale=0.5]` (EPS) |
| preface | intro.tex:1-2 | `head.kernel`, `toc.kernel` | `\chapter*{Preface}` plus `\addcontentsline{toc}{chapter}{Preface}` |
| contents | title.tex:35-41; lectures.sty:79 | `toc.kernel`, `toc.etoc` | `\tableofcontents`; `tocbibind[nottoc]` |
| run-in section entries in the contents | lectures.sty:83-89 | `toc.titletoc` | `\titlecontents*{section}[.5em]{\small}{\thecontentslabel.~{}}{}{ \textbf{\thecontentspage}}[; ][.]` |
| part lines in the contents | affine.tex:2; absolute.tex:2; axioms.tex:2 | `toc.kernel` | `\addtocontents{toc}{\protect\contentsline{part}{\protect\numberline{}Additional topics}{}{}}`; the `\part*` itself is commented out (line 1) |
| headings | metric.tex:1,4,86; hints.tex:9 | `head.kernel` | `\chapter`, `\section`, `\subsection*`; hints title `\chapter[Hints]{\vspace*{-20mm}Hints\vspace*{-10mm}}` |
| section numbering | lectures.sty:211-212 | `num.counters` | `\renewcommand{\thesection}{\Alph{section}}`, `\renewcommand{\p@section}{\thechapter}` |
| theorem-like statements | lectures.sty:123-135 | `thm.amsthm` | one chapter-reset counter `thm` shared by 40+ names (Exercise 231 uses, Theorem, Proposition, Lemma, Claim, Corollary, Definition, ...); head bold `chapter.n. Name<punct>`, body italic, `\par\medskip` around; punct `.` default, `!` or `\abs` (period plus superscript check mark) per use (metric.tex:185); `thm*` prints no number (area.tex:740) |
| proof, run-in labels | lectures.sty:118-121 | `sp.manual-space`, `mark.kernel`, `thm.amsthm` | `\parit`, `\parbf` (`\medskip\noindent` + italic or bold), `\qeds` = `\qed\par\medskip`, `\qedsf` adds `\vskip-6mm` |
| display maths | axioms.tex:87; metric.tex:38 | `math.amsmath`, `math.kernel` | `align*`, `aligned`, `cases`, `smallmatrix`, `\[ \]`, `$$ $$` |
| math helpers | lectures.sty:1-4 | `math.amsmath`, `math.mathtools`, `math.amssymb`, `math.bm` | `\shortintertext`, `\measuredangle`, `\geqslant`, `\varnothing` |
| math operator and symbol renames | lectures.sty:109-115,142-158 | `math.amsmath`, `math.amssymb` | Russian `ch sh th tg`, `\varlimsup`, `\varepsilon`, `\varphi`, `\geqslant`, `\leqslant`, `\operatorname`-style `\defect \area \circum \Re \Im`, `\df`=`:=` |
| symbols | lectures.sty:6,139-140,160-161 | `font.icons`, `math.amssymb` | pifont `\ding{115}` (`\solidtriangle`), `\checkmark`, `\blacksquare` |
| equation numbers (circled digits, left) | lectures.sty:199-208; absolute.tex:120 | `num.counters`, `math.eqnumber`, `font.icons`, `xref.kernel` | counter `eqtn` reset per chapter, `\eqlbl{x}` = `\refstepcounter{eqtn}\leqno\text{\numform{eqtn}\label{x}}`, glyphs `\ding{202}`..`\ding{211}` (10 values); reset by hand in hints (hints.tex:11) |
| math break points | lectures.sty:163-168 | `sp.hyphenat`, `sp.lengths`, `box.minipage` | `\z#1` = `#1\nobreak\discretionary{}{\hbox{$\mathsurround=0pt #1$}}{}`; `\cdot` redefined to `{\hskip0.5pt\z\oldcdot\hskip0.5pt}` |
| emphasis | lectures.sty:92-101 | `mark.ulem` | soul `\sodef\an{}{.1em}{.5em plus.1em}{.5em plus.1em minus.1em}` (letterspacing), `\def\emph{\ann}`; back to `\textit` in the bibliography (all-lectures.tex:70) |
| lists | lectures.sty:181-195 | `list.enumitem`, `list.kernel` | first-level defaults: leftmargin=25pt, rightmargin=0pt, labelsep=5pt, labelwidth=20pt, itemindent=0pt, listparindent=0pt, topsep=0pt plus 1pt, partopsep=parsep=itemsep=\topsep; `\labelitemi`=$\diamond$, `\labelitemii`=$\circ$; `description` (absolute.tex:398) |
| enumerate labels | metric.tex:22,68; axioms.tex:53 | `list.enumerate-pkg` | `[(i)]`, `[(a)]`, `[I.]`, `[p-I.]`, `[1.]`; `\addtocounter{enumi}` (parallel.tex:509) is `num.counters` |
| quotations | absolute.tex:441,470 | `quote.kernel` | `quotation` with `{\it ...}` |
| epigraph, paracol, bm | lectures.sty:57,22,4 | `quote.epigraph`, `cols.paracol`, `math.bm` | loaded, never used in the body (grep) |
| footnotes | car.tex:294; axioms.tex:121 | `fn.kernel` | `\footnote`; mark-free `\let\thefootnote\relax\footnotetext{...}` |
| figures | metric.tex:217-220; proj.tex:347-352 | `fig.graphicx`, `cap.caption` | `figure[!ht]`, `\includegraphics`, `\caption*` (4 uses); `caption` loaded without options (lectures.sty:21) |
| wrapped figures | affine.tex:61,164; axioms.tex:311 | `fig.wrapfig` | 170 `wrapfigure`, placements `r`, `o`, optional line count `[4]`, widths 19mm to 60mm |
| figure container | lectures.sty:66-68 | `box.minipage`, `sp.manual-space` | `Figure` = `\par\medskip\noindent\minipage{\linewidth}` ... `\endminipage\par\medskip` (14 uses) |
| side-by-side figures | hints.tex:551-560; complex.tex:328-335 | `cols.minipage` | two `minipage{.49\textwidth}` or `{.47\textwidth}` with `\hfill` |
| EPS images | title.tex:12; poincare.tex:6 | `fig.epstopdf` | graphicx under pdfLaTeX, EXTERNAL (Blockers) |
| framed axiom lists | axioms.tex:52 | `box.mdframed` | `framed` around `enumerate` (2 uses) |
| columns | affine.tex:283-295; area.tex:407-451; hints.tex:7,2616 | `cols.multicol` | `multicols{2}`, `\raggedcolumns`, `\multicolsep=.5mm`, `\columnseprule` 1pt then 0pt, `\columnbreak`; hints chapter in two columns through `\spell{\begin{multicols}{2}}{}` |
| page and column breaks | metric.tex:84; hints.tex:2618; title.tex:34-36; all-lectures.tex:62 | `pg.break` | `\pagebreak`, `\newpage`, `\cleardoublepage` |
| file structure | all-lectures.tex:27-59 | `struct.input` | 24 `\input` calls |
| bibliography | lectures.sty:31-52; all-lectures.tex:67,72 | `bib.biblatex-biber` | `backend=biber, style=numeric-comp, sorting=debug, maxnames=10, autolang=other, doi=false, isbn=false, bibencoding=auto`; `\bibfont`=`\scriptsize`; `\DeclareFieldFormat{postnote}{#1}` (also `multipostnote`, `pages`); `\AtEveryBibitem{\clearlist{language}}`, `{\clearlist{note}}`; `\renewbibmacro{in:}{}`; `\printbibliography[heading=bibintoc]`; `\bibname`=Used resources; 25 entries in library.bib |
| index | all-lectures.tex:19,64-66 | `idx.makeidx` | `\makeindex`, 351 `\index` with sort keys (metric.tex:107), `makeindex` run (README.md:24,27), `{\scriptsize\input{all-lectures.ind}}` |
| cross-references | metric.tex:23 etc. | `xref.kernel` | `\label`, `\ref` (1295 uses) |
| counters | hints.tex:10-11 | `num.counters` | `\refstepcounter{chapter}` and `\setcounter{eqtn}{0}` repeated per hint block (20 resets) |
| build variants | all-lectures.tex:9-13,22 | none (chosen branch) | `\arxiv` and `\spell` pick the first argument; the second branch (`\RenewEnviron{figure}`, `\pagestyle{empty}`, `\renewcommand{\frac}`...) is the spelling-check build |
| in-text figure artwork | intro.tex:51-102 | `art.tikz` | content inside a figure float |
| cover: class and parts | cover/cover.tex:2-35 | `class.bookcover` | see Class setting |
| cover: fonts | cover/cover.tex:13,38,59,72,88 | `font.fontspec` | `\setmainfont{P22-Underground-Reg}`, `{P22UndergroundCYBookSC}` (both .ttf shipped in cover/) |
| cover: colour | cover/cover.tex:10,34 | `color.xcolor` | `\definecolor{mycolor}{HTML}{41758A}` |
| cover: type and rotation | cover/cover.tex:41-47,52-66 | `font.size-commands`, `fig.rotating`, `sp.manual-space`, `sp.lengths` | `\fontsize{42}{48}`, `\fontdimen2\font=1ex`, `\rotatebox[origin=c]{-90}`, `\\[120mm]`, `\hskip30mm` |
| cover: loaded, unused | cover/cover.tex:11-12 | `bg.background`, `draft.todo` | `background`, `blindtext` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `thm`, `thm*`, `\claim`, `\nonumclaim`, `\endclaim`, counter `thm`, `\thethm` | lectures.sty:123-135 | yes | `thm.amsthm`: one `\newtheoremstyle` with bold head `#2. #3` (number, then the note slot holding the name and its terminator), italic body, `\medskip` spaces; counter `\newtheorem{thm}{}` within chapter; the unnumbered form is a style whose head omits `#2` while the counter still steps. The `\hbox` that keeps the head on one line is the only part amsthm does not give directly |
| `\parit`, `\parbf`, `\qeds`, `\qedsf` | lectures.sty:118-121 | yes | inline: `\medskip\noindent` + `\itshape`/`\bfseries`; `\qed` is amsthm's |
| `eqtn`, `\theeqtn`, `\numform`, `\@numform`, `\eqlbl`, `\@eqnnum` | lectures.sty:199-208 | yes, with a judgement call | `\newcounter{eqtn}[chapter]`; `\theeqtn` is a closed table from 1..10 to `\ding{202}..\ding{211}` (an `\ifcase` that errors past 10), writable as a fixed mapping or an offset on the counter value; `\eqlbl{x}` inline is `\refstepcounter{eqtn}\leqno\text{\theeqtn\label{x}}`; `\@eqnnum` changes only `equation`/`eqnarray`, which the body never uses |
| `\z`, redefined `\cdot` | lectures.sty:163-168 | yes, with a judgement call | inline expansion into kernel line-break commands: `\nobreak\discretionary{}{\hbox{$\mathsurround=0pt =$}}{}` after a relation, `\hskip0.5pt` each side of `\cdot`; filed under the `sp.hyphenat` family (explicit break points, `\-` is the same primitive) |
| `\emph` -> `\ann`, `\an` | lectures.sty:91-101 | yes | `mark.ulem` (`\sodef` letterspacing) wrapped by `meta.accsupp` ActualText carrying the same text |
| `\subtitle` | lectures.sty:70-76 | yes | `\posttitle{...}` with the subtitle text inlined |
| `Figure` environment | lectures.sty:66-68 | yes | `minipage` plus `\medskip` and `\par` |
| `\smallskip`, `\medskip`, `\bigskip` | lectures.sty:104-106 | yes | `\vskip\...amount`, `sp.manual-space` |
| `\emptyset`, `\cosh`, `\sinh`, `\tanh`, `\tan`, `\limsup`, `\liminf`, `\epsilon`, `\phi`, `\ge`, `\le`, `\defect`, `\area`, `\circum`, `\Re`, `\Im`, `\df`, `\:` | lectures.sty:109-115,142-158 | yes | `\DeclareMathOperator`/`\renewcommand` aliases over amsmath and amssymb symbols |
| `\a`, `\abs`, `\solidtriangle`, `\solidsquare` | lectures.sty:137-140,160-161 | yes | `\checkmark`, `.$\!{}^{\checkmark}$`, `\ding{115}`, `\blacksquare` |
| `\renewcommand{\@listI}`, `\labelitemi`, `\labelitemii` | lectures.sty:181-195 | yes | `\setlist[1]{...}` with the lengths in the map; `\@listI` serves normalsize text only, so the hints in `\footnotesize` would need the same lengths set deliberately |
| `\p@section`, `\thesection` | lectures.sty:211-212 | yes | `\renewcommand` of two counter printers |
| `\csname @openrightfalse\endcsname` | lectures.sty:81 | yes | class option `openany` |
| `\spell`, `\arxiv` | all-lectures.tex:9-13 | yes | choose the first argument; the second is dead code in this build |
| `\addtocontents{toc}{\protect\contentsline{part}...}` | affine.tex:2; absolute.tex:2; axioms.tex:2 | yes | same kernel calls, strings only |
| `\let\thefootnote\relax\footnotetext` | axioms.tex:121 | yes | kernel idiom for a mark-free footnote |
| biblatex hooks (`\AtEveryBibitem`, `\renewbibmacro{in:}{}`, `\DeclareFieldFormat`) | lectures.sty:43-51 | yes | biblatex's own customisation commands with empty or `#1` bodies |
| MetaPost library (`macros.mp`, `fiziko.mp`, `pic.mp`, `pic-hints.mp`) | mppics/ | not template code | figure artwork source; Blockers (`EXTERNAL/body`) |

## Content-opaque
- 215 MetaPost figures `\includegraphics{mppics/pic-N}` in 22 chapter files (counts per file: hints.tex 34, inscribed-angle.tex 19, area.tex 15, parallel.tex 14...), `.mps` not shipped; sources mppics/pic.mp and mppics/pic-hints.mp (about 11,000 lines in four .mp files; heads only were read).
- TikZ chapter-dependency graph in a figure (intro.tex:51-102).
- The two EPS images, as image content (title.tex:12, poincare.tex:6); the conversion is the blocker, not the image.
- Equation text, theorem and hint text, 25 bibliography entries (library.bib), `\index` entries and their sort keys (metric.tex:107).

## Lib changes
- New ways proposed: none. Considered and not proposed: kernel `\discretionary` and `\nobreak` as a way of their own, filed under `sp.hyphenat` as explicit break-point control; `\noindent` filed under `sp.lengths` (paragraph indent).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- AA.tex (5070 lines) has no `\documentclass`, is not input by all-lectures.tex and is not in list-of-files.txt; it is an older body fragment. It uses an `lpic` environment (27 uses) that `lectures.sty` never loads, so it is not part of the build analysed here. Only its first 60 lines were read and its definitions and environments grepped.
- The per-chapter `\refstepcounter{chapter}` plus `\setcounter{eqtn}{0}` pairs in hints.tex (for example hints.tex:10-11) restart the theorem and equation numbering without a heading.
- Judgement calls that a stricter reading could turn into `BESPOKE/preamble`: the `eqtn`/`\numform`/`\eqlbl` equation numbering (a hand-stepped counter with an `\ifcase` table) and `\z` (a macro over `\discretionary`). The verdict does not depend on them, since `no` already stands on the EXTERNAL items.
- If a reviewer treats the `.mps` files as shippable assets (the rubric's "Missing assets"), the `EXTERNAL/body` MetaPost blocker drops; the EPS blocker remains by the lib's own `fig.epstopdf` ruling.
- `idx.makeidx` and `bib.biblatex-biber` are lib ways whose tools (`makeindex`, `biber`) run in the normal LaTeX cycle (README.md:23-28), so they are not blockers.
- Nothing in the zip addressed an AI reader; no embedded instructions were found.
