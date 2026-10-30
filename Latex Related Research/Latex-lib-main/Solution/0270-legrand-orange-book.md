yes

# 0270-legrand-orange-book: Legrand Orange Book

- Unverified: read from the source, not compiled.
- Source: Source/0270-legrand-orange-book/ (origin: https://latextemplates.com/downloads/legrand-orange-book.zip; licence: MIT)
- Kind: book
- Lib: v3
- Engine: pdfLaTeX-compatible (main.tex:48-57 and mimosis.cls:27-32 also keep an optional XeLaTeX/LuaLaTeX branch: `fontspec`, `unicode-math`; the README says it is built with pdflatex, README.md:48)
- Look carried by: mixed (zip-local `mimosis.cls` sets page, headings, header, spacing, packages; `main.tex` preamble sets colour, fonts, epigraph and bibliography)
- Class origin: zip-local
- Main file: main.tex (other samples: none; it `\include`s Sources/Title.tex, Sources/Preface.tex, Sources/PartOne.tex, Sources/PartTwo.tex)
- Read: main yes (main.tex, all four Sources files, references.bib), zip-local classes and styles all (mimosis.cls, 220 lines, in full)

Note on the name: the README says this is a substitute, not the original Legrand Orange Book; the zip is `Pseudomanifold/latex-mimosis` (MIT) restructured as a multi-part book (README.md:3-8). The analysis is of what is in the zip.

## Verdict
Every component the sample and the class define lands on a lib way. `mimosis.cls` is zip-local (ctan.org/pkg/mimosis is a 404; README.md:17 says "not on CTAN"), but it is only `\LoadClass{scrbook}` with options plus `\RequirePackage` of published packages, KOMA font and format hooks, `\newcommand` aliases and two glossaries style declarations (mimosis.cls:9-16, 206-220), so it reduces to `class.scrbook` plus the ways below. One redefinition (`\left`/`\right`, mimosis.cls:172-175) reduces to the published `mleftright` package, proposed as `math.mleftright`. There is no artwork and no external tool. The closest call is the glossaries style code (mimosis.cls:96-131); it is documented glossaries API and never prints anything in the sample, so it is judged reducible.

## Blockers
none

## Class setting
- Class: `class.scrbook` options: `a4paper,twoside,11pt,cleardoublepage=empty,numbers=noenddot,titlepage,toc=bibliography,toc=index` (loaded inside the zip-local wrapper, mimosis.cls:9-16; main.tex:1 is `\documentclass{mimosis}`); `typearea` receives `DIV=10, BCOR=10mm` (mimosis.cls:4-7)
- Class-native vocabulary used: `\frontmatter` `\mainmatter` `\backmatter` (main.tex:69,75,80), `\part` (Sources/PartOne.tex:1), `\chapter`, `\chapter*` (Sources/Preface.tex:1), `\section`, KOMA `\subtitle` (main.tex:64), `\setkomafont` (mimosis.cls:209-215), `\partformat` `\raggedpart` `\chapterformat` `\autodot` (mimosis.cls:206-207, 218-220)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | mimosis.cls:9-16 | `class.scrbook` | the options listed above; the wrapper class itself is reduced in "Bespoke code" |
| paper, size, sides | mimosis.cls:9-11 | `page.class-options` | `a4paper`, `11pt`, `twoside` |
| page geometry | mimosis.cls:4-7 | `page.typearea` | `DIV=10`, `BCOR=10mm` |
| blank pages before chapters | mimosis.cls:12 | `hf.class-native` | `cleardoublepage=empty` (KOMA option; not the `emptypage` package) |
| running heads | mimosis.cls:199-200 | `hf.scrlayer-scrpage` | `\pagestyle{scrheadings}`, no `\ihead`/`\ofoot` settings, package defaults |
| spacing | mimosis.cls:146-147; main.tex:56 | `sp.setspace` | `\onehalfspacing` in the class; main.tex:56 then calls `\singlespacing` on the pdfLaTeX branch, so the pdfLaTeX document is single-spaced and the XeLaTeX/LuaLaTeX one one-and-a-half |
| widow and club penalties | mimosis.cls:191-193 | `sp.penalties` | `\clubpenalty=10000`, `\widowpenalty=10000`, `\displaywidowpenalty=10000` |
| encodings (pdf branch) | mimosis.cls:30-31 | `font.fontenc-t1` | `fontenc` T1, `inputenc` utf8 |
| text font (pdf branch) | main.tex:54 | `font.serif-pkg` | `ebgaramond`, option `lf` |
| mono font (pdf branch) | main.tex:55 | `font.mono` | `sourcecodepro`, options `oldstyle`, `scale=0.7` |
| fonts (XeLaTeX/LuaLaTeX branch) | mimosis.cls:27-28; main.tex:49-52 | `font.fontspec`, `font.unicode-math` | `\setmainfont{EB Garamond}`, `\setmathfont{Garamond Math}`, `\setmonofont[Scale=MatchLowercase]{Source Code Pro}`; Garamond Math is a system font the zip does not ship |
| colour | mimosis.cls:54 | `color.xcolor` | option `dvipsnames` (gives `BurntOrange`) |
| hyperlinks | main.tex:10-16 | `meta.hyperref` | `colorlinks=true`, `citecolor=linkcolor=urlcolor=BurntOrange`, `unicode` |
| bookmarks | main.tex:18 | `meta.bookmark` | load only |
| languages | mimosis.cls:38 | `lang.babel` | `ngerman,french,english` (english last = main language) |
| quotation marks | mimosis.cls:40 | `lang.csquotes` | `autostyle=true` |
| title block | main.tex:63-65 | `front.maketitle`, `front.koma-title` | `\title`, `\author`, KOMA `\subtitle`; the printed page is hand laid, next row |
| title page | Sources/Title.tex:1-19 | `front.titlepage-env` | `titlepage` env, `center`; title in `Huge`, subtitle in `Large`, author plain |
| title page spacing and sizes | Sources/Title.tex:2,5,7,10,15 | `sp.manual-space`, `font.size-commands` | `\vspace*{5cm}`, `\\[0.1cm]`, `\vspace{1cm}`; `\begin{Huge}`, `\begin{Large}` |
| blank verso after title | Sources/Title.tex:21-24 | `pg.break`, `hf.pagestyle-kernel` | `\newpage\null`, `\thispagestyle{empty}`, `\newpage` |
| file inclusion | main.tex:70-71, 77-78 | `pg.break` | `\include` (implies `\clearpage` before and after); the emitter may inline the four files instead |
| preface | Sources/Preface.tex:1-2 | `head.kernel`, `toc.kernel` | `\chapter*{Preface}`, `\addcontentsline{toc}{chapter}{Preface}` |
| table of contents | main.tex:73; mimosis.cls:15-16 | `toc.kernel`, `toc.koma` | `\tableofcontents`; class options `toc=bibliography`, `toc=index` |
| part heading | mimosis.cls:206-207, 209 | `head.class-native`, `head.koma-fonts` | `\partformat` = `\huge\partname~\thepart\autodot`; `\raggedpart` = `\flushleft`; `\setkomafont{part}{\normalfont\huge\scshape}` |
| chapter heading | mimosis.cls:218-220 | `head.class-native`, `font.size-commands` | `\chapterformat` = `\fontsize{50}{55}\selectfont\thechapter\autodot\enskip` |
| section font | mimosis.cls:211 | `head.koma-fonts`, `mark.kernel` | `\setkomafont{sectioning}{\normalfont\scshape}` |
| heading numbering dot | mimosis.cls:13 | `head.class-native` | `numbers=noenddot` |
| headings in body | Sources/PartOne.tex:1,3,12,16,19; Sources/PartTwo.tex:1,3 | `head.kernel` | `\part`, `\chapter`, `\section` |
| labels | Sources/PartOne.tex:4,20; Sources/PartTwo.tex:4 | `xref.kernel` | `\label{chapter:...}` |
| chapter epigraph | main.tex:27-28; Sources/PartOne.tex:6; Sources/PartTwo.tex:6 | `quote.epigraph` | `\setlength{\epigraphwidth}{0.7\textwidth}`; body `\epigraph{text}{author}` |
| description label font | mimosis.cls:212 | `head.koma-fonts`, `mark.kernel` | `\setkomafont{descriptionlabel}{\normalfont\bfseries}` (same command family; no description list in the sample) |
| lists | mimosis.cls:137-140 | `list.paralist` | options `olditem`, `oldenum` (load only; the sample has no list) |
| caption fonts | mimosis.cls:214-215 | `cap.koma` | `\setkomafont{caption}{\small}`, `captionlabel` = `\usekomafont{caption}` |
| sub-figures and caption options | mimosis.cls:75, 79 | `fig.subcaption`, `cap.caption` | `subcaption`; `\captionsetup{subrefformat=parens}` |
| graphics | mimosis.cls:60-64 | `fig.graphicx` | `\graphicspath{{Figures/}{./}}` |
| tables | mimosis.cls:153-154 | `tbl.booktabs`, `tbl.multirow` | load only (the sample has no table) |
| units | mimosis.cls:160 | `mark.siunitx` | load only |
| maths packages | mimosis.cls:166-168 | `math.amsmath`, `thm.amsthm`, `math.bm` | `amsmath`, `amsthm` (no `\newtheorem` in the sample or class), `dsfont` |
| maths operators and aliases | mimosis.cls:177-185 | `math.amsmath`, `math.bm` | `\DeclareMathOperator*{\argmin}{arg\,min}`, `{\dist}{dist}`, `{\im}{im}`; `\domain`, `\real` = `\ensuremath{\mathds{D/R}}`; `\diff` = `\operatorname{d}\!{#1}` |
| maths delimiter spacing | mimosis.cls:172-175 | `math.mleftright` | `\left`/`\right` become `\mleft`/`\mright` |
| index | mimosis.cls:41 | `idx.makeidx` | load only; no `\makeindex` or `\printindex` anywhere |
| glossaries and acronyms | mimosis.cls:85-91, 96-131 | `idx.glossaries` | options `acronym,nogroupskip,nopostdot,nonumberlist,toc`; `\newacronymstyle{long-short-mimosis}`, `\newglossarystyle{long-mimosis}`, `\setlength{\glsdescwidth}{10cm}`, `\setacronymstyle`, `\setglossarystyle`; no entry or `\printglossary` in the sample |
| citations | main.tex:39; Sources/PartOne.tex:13-14 | `bib.natbib` | `\usepackage[numbers]{natbib}`, `\cite{example-book}`, `\cite{example-article}` |
| bibliography | main.tex:82-83; references.bib | `bib.bibtex-bst` | `\bibliographystyle{plainnat}`, `\bibliography{references}` (a bibtex pass, the lib's toolchain) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `mimosis` | mimosis.cls:2-220 | yes | `\documentclass[a4paper,twoside,11pt,cleardoublepage=empty,numbers=noenddot,titlepage,toc=bibliography,toc=index]{scrbook}` plus `typearea` `DIV=10,BCOR=10mm` plus the packages and hooks in the component map; nothing in it is a custom output routine |
| engine switch `\ifxetexorluatex` | mimosis.cls:18-25; main.tex:48-57 | yes | `iftex` detection only; the emitter picks one engine and prints that branch (pdfLaTeX: `font.fontenc-t1`, `font.serif-pkg`, `font.mono`, `\singlespacing`) |
| `\comment` no-op macro | mimosis.cls:48 | yes | `\newcommand{\comment}[1]{}` swallows its argument; not used in the sample, so the emitter drops it |
| page-group warning switch | mimosis.cls:69-73 | yes | sets `\pdfsuppresswarningpagegroup=1` when the primitive exists; it changes the log only, not the page, so the emitter drops it |
| `\left`/`\right` redefinition | mimosis.cls:172-175 | yes | the same effect as `mleftright`'s `\mleft`/`\mright` (CTAN, LPPL 1.3): `math.mleftright`; the sample uses neither command |
| acronym style `long-short-mimosis` | mimosis.cls:96-114 | yes, closest call | `idx.glossaries` declared style: `\newacronymstyle` built from glossaries' own `\GlsUseAcrEntryDispStyle`, `\GlsUseAcrStyleDefs` and four `\renewcommand*` of the documented full-form hooks (`\genacrfullformat`, `\Genacrfullformat`, `\genplacrfullformat`, `\Genplacrfullformat`) as `long~\textup{(short)}` with a tie; it uses no zip-local logic and prints nothing in the sample |
| glossary style `long-mimosis` | mimosis.cls:118-125 | yes, closest call | `idx.glossaries`: `\newglossarystyle` on `\setglossarystyle{long}` with `\glossentry` redefined to `\glsentryitem\glstarget{\glossentryname} & \glossentrydesc\glspostdescription\space #2\tabularnewline`, all glossaries commands; `\glsdescwidth=10cm` |
| `\newcommand{\domain}`, `\real`, `\diff` | mimosis.cls:181-185 | yes | aliases of `\mathds` (`dsfont`) and `\operatorname` (`amsmath`) |
| `\DeclareMathOperator` x3 | mimosis.cls:177-179 | yes | amsmath declarations |
| `\renewcommand` of `\partformat`, `\raggedpart`, `\chapterformat` | mimosis.cls:206-207, 218-220 | yes | documented KOMA format hooks set to font and counter commands, one printed preamble line each; `\raggedpart` = `\flushleft` is the class's own literal value (whether it equals `\raggedright` was not examined) |
| hand-laid title page | Sources/Title.tex:1-24 | yes | the emitter writes the model's title, subtitle and author into a `titlepage` env; `\@title` `\@subtitle` `\@author` are only data reads, and the `\ifdefempty{\@subtitle}` test (line 9) is the data question "does the model have a subtitle"; `\ifdefempty` comes from etoolbox, which glossaries loads (assumed, not read) |
| `xspace` | mimosis.cls:42 | yes | load-only helper for macro authors; no macro that uses `\xspace` exists in the class or sample, so it has no printed effect and needs no way (considered: `xspace`, not proposed) |

## Content-opaque
none

## Lib changes
- New ways proposed: `math.mleftright` `mleftright` (CTAN, LPPL 1.3; engine pdf): `\mleft` and `\mright`, variants of `\left` and `\right` whose delimiters act as `\mathopen` and `\mathclose` atoms, so no extra space appears inside; the CTAN page lists no options, and a global `\mleftright` switch is not confirmed from that page, so the emitter writes `\mleft`/`\mright` where the model has delimited groups. W1: on CTAN. W2: no code to edit, one load line and per-delimiter commands. W3: any maths-bearing document. W4: one `\usepackage` line and a body replacement of `\left`/`\right`. No lib line covers it (`math.mathtools` has `\DeclarePairedDelimiter`, not this spacing fix; checked by grep for `mleft` in `_Lib.md`: no hit).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
