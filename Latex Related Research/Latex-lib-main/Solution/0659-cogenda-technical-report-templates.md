yes

# 0659-cogenda-technical-report-templates: Cogenda Technical Report Templates (cgdrep)

- Unverified: read from the source, not compiled.
- Source: Source/0659-cogenda-technical-report-templates/ (origin: https://latextemplates.com/downloads/cgdrep-technical-report.zip; licence: LPPL-1.3-or-later (LaTeX code); CC-BY-SA-4.0 (documentation/examples))
- Kind: report
- Lib: v5
- Engine: needs XeLaTeX (`fontspec` and `unicode-math` are loaded unconditionally, cgd-common.def:9-10; OpenType fonts selected by name, cgd-font-en.def:8-20)
- Look carried by: zip-local
- Class origin: zip-local
- Main file: main.tex (other samples: none; chap1.tex is `\input` at main.tex:27; copyright.tex is read only by the sibling manual class, not by this sample)
- Read: main yes, zip-local classes and styles all

## Verdict
The sample loads only `cgdrepen`, a zip-local class (ctan.org/pkg/cgdrepen is a 404; the zip is a catalogue copy, see cgd-font-en.def:5-7) that is `\LoadClass{report}` plus eight `.def` files (cgdrepen.cls:12-23). Every `.def` is a composition of published packages (geometry, fancyhdr, fontspec, unicode-math, enumitem, caption, listings, tcolorbox, tabularx, tabu, hyperref, xcolor) and kernel commands, and every zip-local macro that is called or defined reduces to lib ways by inline expansion or a published alias (see Bespoke code), so the answer is yes. No TikZ or PGF drawing sits in the files the sample loads (the only `\tikz` there is the unused helper `\circled`, cgd-math.def:12-13). Scope note: the sibling class `cgdmanen`, which main.tex does not load, carries template-defining TikZ artwork (a random-colour hexagon cover, cgd-fancy-cover.def:75-112) that would be `ART/class` if the whole zip were counted; per the rubric's scope (what the sample loads) it is recorded but not scored.

## Blockers
none

## Class setting
- Class: `class.report` options: `11pt`, `a4paper` fixed inside the class (cgdrepen.cls:12); the sample passes none (main.tex:1). `twoside` is the only declared option and it is passed to a package named `report`, not to the class (cgdrepen.cls:7-9); `nofonts` and `utf8` on the same line are ctex-class options that report ignores (compare cgdrepcn.cls:12).
- Class-native vocabulary used: report `\chapter` `\section` `\appendix` `\tableofcontents` `\bibliography` `\bibliographystyle` (main.tex:23-31, chap1.tex:1-8). Zip-local vocabulary that reduces: `\subtitle`, `\docattr{docid,email,classification,type,status}`, `\maketitle`, `abstract`, `revisions`, `\frontmatter` `\mainmatter` `\backmatter` (main.tex:4-32); `\addrHex` `\addrBin` `\addrMem` `\circMod` `\circPin` `\circNet` `\circReg`, `\diff`, `\pDeriv`, `\unit` (chap1.tex:60-112).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | cgdrepen.cls:12 | `class.report` | 11pt, a4paper |
| paper and size | cgdrepen.cls:12 | `page.class-options` | a4paper, 11pt |
| page geometry | cgd-common.def:11 | `page.geometry` | top=3cm, bottom=3cm, left=3cm, right=2.2cm, headheight=20pt |
| text faces | cgd-font-en.def:8,12 | `font.fontspec` | `\setmainfont{DejaVu Serif}`, `\setsansfont{DejaVu Sans}` |
| mono face | cgd-font-en.def:13-20 | `font.fontspec` | `\setmonofont[ItalicFont,ItalicFeatures={FakeSlant=0.2},BoldFont,BoldItalicFont,BoldItalicFeatures={FakeSlant=0.2}]{DejaVu Sans Mono}`; `\newfontface\LightMono{DejaVu Sans Mono}` |
| math face | cgd-font-en.def:9-11; cgd-common.def:10 | `font.unicode-math` | `\setmathfont{latinmodern-math.otf}`; `range=\mathup/{num,latin,Latin,greek,Greek}`; `range=\int` |
| size and shape switches | cgd-front-en.def:13-14,18,27; cgd-style.def:62-65 | `font.size-commands` | `\Huge` `\huge` `\Large` `\small` `\scriptsize` `\footnotesize` |
| font-switch aliases | cgd-front-en.def:13,27; cgd-style.def:62-65 | `mark.kernel` | `\sf` `\bf` `\ttfamily` `\sl` `\itshape` in `\newcommand` wrappers |
| symbol-glyph package | cgd-common.def:7 | `font.icons` | `wasysym` with `nointegrals` (load-only, avoids integral clash) |
| math packages | cgd-common.def:4; chap1.tex:59-62,114-118 | `math.amsmath` | `amstext`, `amsmath`; `equation`, `cases` |
| extra integral symbols | main.tex:2; chap1.tex:61,80 | `math.amssymb` | `esint` (`\oiint`); a math-symbol package is the parameter, as `amssymb` |
| differential and derivative macros | cgd-math.def:35-50; chap1.tex:60,61,69,80,107 | `math.physics` | `\diff` as the `physics` differential `\dd` (alias), `\deriv` and `\pDeriv` as `\frac` over `\dd`/`\partial` with optional order |
| math aliases | cgd-math.def:5,8-9,18,20,22-32 | `math.kernel` | `\ensuremath{_\mathrm{#1}}`, `\ensuremath{\mathrm{e}}`, `\DeclareMathAccent`, `\mathop` wrappers (`\newoperator` is `\DeclareMathOperator` of `math.amsmath`) |
| colours | cgd-common.def:34 | `color.xcolor` | `svgnames` (DarkBlue, DarkRed, Blue, OldLace, DarkGreen, DarkSlateGray, DarkCyan, LightGray, Gray used at cgd-common.def:42, cgd-style.def:32-56,73) |
| links and PDF metadata | cgd-common.def:12-15,42 | `meta.hyperref` | `unicode=true,pdfusetitle,bookmarks=true,bookmarksnumbered=false,bookmarksopen=false,breaklinks=false,pdfborder={0 0 1},backref=false,colorlinks=false`; then `\hypersetup{colorlinks,linkcolor=DarkBlue,citecolor=DarkRed,urlcolor=Blue}`; `\url` at chap1.tex:10 |
| paragraph spacing | cgd-style.def:9 | `sp.lengths` | `\parskip=0.3\baselineskip` |
| manual spacing | cgd-front-en.def:10,15,19,60 | `sp.manual-space` | `\vspace{5.0cm}`, `\vfill`, `\vspace{2cm}`, `\null\hfill` |
| centring and flush | cgd-front-en.def:12,31,84 | `sp.ragged` | `center`, `flushright` |
| thick table rule | cgd-style.def:12-15 | `sp.rule` | `\hrule height 1pt` after `\noalign` |
| title page | cgd-front-en.def:6-21 | `front.titlepage-env` | page: `\cleardoublepage\pagestyle{empty}\pagenumbering{roman}`; top-left small docid, `\fbox{\bf classification}`, `\vspace{5.0cm}`, centred `\sf\Huge` title, `\huge` subtitle, `\vfill`, `\includegraphics[scale=0.6]{logo1.png}`, `\sf\Large Cogenda Pte Ltd`, `\small` date |
| back cover | cgd-front-en.def:82-95 | `front.titlepage-env` | `\cleartoleftpage\pagestyle{empty}\pagenumbering{roman}\setcounter{page}{0}`; flushright docid, `\fbox` classification, `\large` full title; `\vfill`; centred logo and company |
| report-info and abstract page | cgd-front-en.def:29-61 | `tbl.tabularx` | `{\textwidth}{\|X\|X\|}`, rows of `\fdh{...}` labels and values, abstract text in `\parbox[t]{34em}{\small\hspace{2em}...}` inside `\multicolumn{2}{\|c\|}`; `\thickhline` top and bottom, `\hline` between; `\null\hfill\copyright~Cogenda Pte Ltd` after |
| abstract text holder | cgd-front-en.def:55 | `box.minipage` | `\parbox[t]{34em}` |
| revision history | cgd-front-en.def:63-80 | `tbl.tabular` | `center`, `\small`, `{lllp{5cm}}`, header `\bf Ver.` `Date` `Author` `Comments`, `\thickhline` and `\hline`; second branch (`customHdr`) is the bare body |
| framed classification box | cgd-front-en.def:9,86 | `box.fancybox` | `\fbox{\bf ...}` |
| front, main, back matter | cgd-struct.def:4-10,12-24,26-30 | `pgnum.pagenumbering` | roman in front matter, arabic in main matter, `\setcounter{page}{1}` |
| page styles | cgd-struct.def:8,13 | `hf.pagestyle-kernel` | `\pagestyle{plain}`, `\pagestyle{fancy}` |
| counters | cgd-struct.def:5-7,27-28 | `num.counters` | `\setcounter{page}{1}` |
| numbering depth | cgd-struct.def:6-7,27-28 | `num.secnumdepth` | secnumdepth=3, tocdepth=3 (front matter); -2 and -2 (back matter) |
| running head and foot | cgd-struct.def:14-23 | `hf.fancyhdr` | `\fancyhf{}`; `\fancyhead[CE]{\nouppercase{\small\bfseries\leftmark}}`; `\fancyhead[CO]` same with `\rightmark`; `\fancyfoot[RO,LE]{\small\ttfamily $\cdot$~\thepage~$\cdot$}`; `\fancypagestyle{plain}` foot only, `\headrulewidth=0pt` |
| page flow | cgd-struct.def:5,13; cgd-style.def:78-88 | `pg.break` | `\cleardoublepage`; `\cleartoleftpage` is the kernel `\cleardoublepage` body copied |
| headings | chap1.tex:1,8,32,52,76 | `head.kernel` | report's own `\chapter` `\section` look; cgdrepen sets no titlesec (the heading restyling is only in cgdman-style.def:31-86, not loaded) |
| contents list | main.tex:23 | `toc.kernel` | `\tableofcontents` |
| appendix | main.tex:29; chap1.tex:102 | `num.appendix` | `\appendix`, then `\chapter` |
| lists | cgd-style.def:5-8 | `list.enumitem` | `\setlist[itemize\|enumerate\|description]{nosep}`; `paraitem` = `itemize[itemsep=0.3\baselineskip]`; sample has no list |
| lists base | cgd-style.def:5-8 | `list.kernel` | `itemize` `enumerate` `description` |
| figure | chap1.tex:41-46 | `fig.graphicx` | `figure[htbp]`, `\centering`, `\includegraphics[width=0.5\textwidth]{Divergence_theorem.png}` |
| figure subfloats | cgd-common.def:37 | `fig.subcaption` | `subfig` loaded, not called by the sample |
| caption | chap1.tex:44-45 | `cap.kernel` | `\caption{\label{fig:div_theorem}...}` |
| caption style | cgd-common.def:16; cgd-style.def:23-28 | `cap.caption` | `font=small,labelfont=bf`; `\captionsetup[table\|figure\|lstlisting]{aboveskip=0pt,belowskip=0pt}` |
| cross-reference | chap1.tex:44; cgd-style.def:19 | `xref.kernel` | `\label` inside caption |
| table float with tabu | cgd-style.def:17-20 | `tbl.nicematrix` | `ctable{label}{caption}{spec}`: `table[htbp]`, `\centering\small`, `\caption{\label{#1}#2}`, `tabu{#3}`, `\thickhline`, `\rowfont{\bfseries}`; not called by the sample; `tabu` is the parameter |
| long tables | cgd-common.def:9 | `tbl.longtable` | `longtable` loaded, not called by the sample |
| multirow | cgd-common.def:9 | `tbl.multirow` | `multirow` loaded; sample uses kernel `\multicolumn` only |
| code listings | cgd-style.def:31-58 | `code.listings` | `\lstset{backgroundcolor=\color{OldLace}, basicstyle=\footnotesize\ttfamily, breaklines=true, captionpos=b, commentstyle=\color{DarkGreen}, keywordstyle=\color{blue}, numbers=left, numbersep=5pt, numberstyle=\scriptsize\color{DarkSlateGray}, stringstyle=\color{DarkCyan}, tabsize=4, columns=flexible, keepspaces=true, escapeinside={\%*}{*)}, title=\lstname,...}`; no listing in the sample |
| inline tag boxes | cgd-style.def:72-74,91-105; chap1.tex:91-100 | `box.tcolorbox` | `\newtcbox{..}{nobeforeafter,colframe=LightGray,colback=LightGray!10!white (black!5!white for addresses),boxrule=0.5pt,arc=3pt (1pt),boxsep=0pt,left=2pt,right=2pt,top=2pt,bottom=2pt,tcbox raise base}` for `\addrHex` `\addrBin` `\addrMem` `\circMod` `\circReg` and the GUI menu items |
| units | chap1.tex:110,112; cgd-common.def:9,36 | `mark.siunitx` | the `units` package, `\unit[value]{unit}`; the number-and-unit package is the parameter |
| bibliography | main.tex:30; chap1.tex:6,13 | `bib.bibtex-bst` | `\bibliographystyle{ieeetr}`, `\bibliography{main}`, `\cite` |
| index | main.tex:2,31; chap1.tex:32; cgd-common.def:39 | `idx.makeidx` | `\makeindex`, `\index{intuition}`, `\printindex{}`; run with `makeindex` |
| inline circled character (helper) | cgd-math.def:12-13 | `art.tikz` | `\tikz[baseline=(char.base)]{\node[shape=circle,draw,inner sep=2pt](char){#1};}`; defined, never called by the sample, not page artwork |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `cgdrepen` | cgdrepen.cls:1-27 | yes | `class.report` (11pt, a4paper) plus the eight `.def` files below, in order; `\IfFileExists{./local.def}` (cgdrepen.cls:25) is an optional hook with no `local.def` in the zip, so it adds nothing |
| `\OverwriteEnviron` (clears environ's internal `env@..` macros, then `\NewEnviron`) | cgd-common.def:24-31 | yes | its only job is to let `abstract` be redefined with `\BODY`; the emitter writes the abstract node as the `tbl.tabularx` wrapper of the report-info row above, with the abstract text in `\parbox`, so `environ` is not needed |
| `\title` (optional mark argument), `\subtitle`, `\author`, `\date`, `\docattr` keys via `\define@key`/`\setkeys` | cgd-docattr.def:5-50; cgd-front-en.def:4 | yes | the keys only store strings; the emitter writes each string where it is printed (title, subtitle, date, author, docid, email, classification, client fields), with the class defaults of cgd-docattr.def:20-50 and cgdrepen.cls:18 for unset keys; `\CGD@value@titlemark` (cgd-docattr.def:7) is never read (grep over main.tex, chap1.tex and all `.def` files finds only this definition) |
| `\maketitle` redefinition | cgd-front-en.def:6-21 | yes | hand-laid page, `front.titlepage-env` row |
| `\CGD@value@fulltitle` with `\ifdefvoid` | cgd-front-en.def:23-25 | yes | the branch is known when the emitter runs: subtitle set gives "Title : Subtitle", otherwise title alone |
| `abstract` via `\NewEnviron` | cgd-front-en.def:29-61 | yes | `tbl.tabularx`, `tbl.tabular` `\multicolumn`, `sp.rule`, `box.minipage`, `font.size-commands` (rows above) |
| `revisions` with `\ifx\argtmp\CGD@opt@customHdr` | cgd-front-en.def:63-80 | yes | the two-way switch is chosen at emit time; default branch is the `lllp{5cm}` tabular, the other branch is the bare body |
| `\backcover` | cgd-front-en.def:82-95 | yes | hand-laid page, `front.titlepage-env` row |
| `\frontmatter` `\mainmatter` `\backmatter` | cgd-struct.def:4-30 | yes | `pg.break`, `num.counters`, `num.secnumdepth`, `hf.pagestyle-kernel`, `pgnum.pagenumbering`, `hf.fancyhdr` calls, as the rows above; `\mainmatter` redefining `plain` is one `\fancypagestyle` call |
| `\thickhline` (copy of `\hline` using `\noalign`, `\@xhline`, height 1pt) | cgd-style.def:12-15 | yes | `\noalign{\hrule height 1pt}` (`sp.rule`); the `\@xhline` look-ahead only spaces two stacked `\hline`s, and the sample never stacks them (cgd-front-en.def:34,57,74,77) |
| `ctable` environment | cgd-style.def:17-20 | yes | one `table` float with `\caption` and a `tabu`, inlined per use (`tbl.nicematrix`, `cap.kernel`) |
| `paraitem` | cgd-style.def:8 | yes | `itemize[itemsep=0.3\baselineskip]` (`list.enumitem`) |
| `\cleartoleftpage` | cgd-style.def:78-88 | yes | same text as the kernel `\cleardoublepage` (`\clearpage`, blank page when twoside and page odd), so `pg.break` |
| `\guimenu`, `\guimenuitem`, `\guimenuitema` (`\SplitList`, `\ProcessList`, self-`\let`) | cgd-style.def:68-76 | yes | not called by the sample; for `A>B>C` the emitter writes `\tcbox[..]{A}`, then `\raisebox{1pt}{\color{Gray}▸}\tcbox[..]{B}`, and so on (`box.tcolorbox`, `sp.manual-space`, `color.xcolor`), or `mark.menukeys` with `\renewmenumacro`; the list is static text, so the "first item has no arrow" state is resolved by the emitter |
| `\addrMem` `\addrHex` `\addrBin` `\circMod` `\circPin` `\circNet` `\circReg`, `\filename` `\command` `\parameter` `\userinput` | cgd-style.def:62-65,91-105 | yes | `\newtcbox` with fixed keys and font switches (`box.tcolorbox`, `mark.kernel`, `font.size-commands`); `\LightMono` is a `\newfontface` (`font.fontspec`) |
| `\diff`, `\DIfF`, `\gobblespace`, `\opspace` (look-ahead for `(`, `[`, `\{`) | cgd-math.def:35-48 | yes, with a caveat | same code shape as the differential `\dd` of the published `physics` package (my recollection; the `physics` source was not read here), so `\let\diff\dd` under `math.physics`; independent of that, the expansion is the kernel math `\mathop{\mathrm{\mathstrut d}}\nolimits^{n}` plus `\!` unless the next token opens a bracket, and the sample's uses (chap1.tex:60,61,69,80) are all followed by a letter or `\mathbf` |
| `\deriv`, `\pDeriv` | cgd-math.def:49-50 | yes | `\newcommand` aliases over `\frac` (kernel math) and `\diff`/`\partial`; `\pDeriv[2]{V}{x}` is `\frac{\partial^{2}V}{\partial x^{2}}` (chap1.tex:107) |
| `\ped` `\ap` `\eu` `\iu` `\angs` `\ohm` `\degree` `\ring` `\newoperator` `\renewoperator` `\boldsymbol` fallback | cgd-math.def:5-32 | yes | `\providecommand`/`\newcommand` aliases of `\mathrm`, `\ensuremath`, `\DeclareMathAccent`, `\mathop` (`math.kernel`, `math.amsmath`); none is called by the sample |
| `\circled` | cgd-math.def:12-13 | yes (content-level helper) | an inline `\tikz` node with fixed options (`art.tikz`); a text marker, not template identity, not called by the sample |
| out of scope, not loaded by main.tex: `cgdmanen.cls` and `cgdman-style.def`, `cgd-fancy-cover.def`, `cgd-syn-genius.def` | cgdmanen.cls:1-29; cgd-fancy-cover.def:75-112,119-147; cgdman-style.def:103-107,132 | not scored | `\hex` is a TikZ overlay of random-colour hexagons (`\pgfmathparse{\rndr*rnd+\fixr}`) put on cover pages by `\AddToShipoutPicture*` (`bg.eso-pic`): `ART/class` if counted; `\gradientbox` is a TikZ gradient node in the running head; headings use `titlesec`+`mdframed` (reducible) |
| out of scope, not loaded: `cgdrepcn.cls`, `cgdartcn.cls`, `cgdarten.cls`, `cgd-front-cn.def`, `cgd-font-cn.def` | cgdrepcn.cls:12,18; cgdartcn.cls:7; cgdarten.cls:7 | not scored | `ctexrep`/`ctexart` with `\ctexset`/`\CTEXsetup`, `\renewcommand\bfseries{\CJKfamily{hei}}`, Chinese front-matter text; `cgdarten` is the report loader on `article` |

## Content-opaque
- Included image Divergence_theorem.png in the figure (chap1.tex:43) and logo1.png on the title and back pages (cgd-front-en.def:16,91): image artwork, shipped in the zip.
- `\circled` (cgd-math.def:12-13) is TikZ but defined and never called by main.tex or chap1.tex.
- Missing assets: none; the DejaVu faces and `latinmodern-math.otf` are named from TeX Live (cgd-font-en.def:5-7), not shipped.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
