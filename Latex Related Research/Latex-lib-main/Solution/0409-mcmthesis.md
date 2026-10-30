yes

# 0409-mcmthesis: The mcmthesis class (MCM/ICM contest paper template, v6.3.3)

- Unverified: read from the source, not compiled.
- Source: Source/0409-mcmthesis/ (origin: https://mirrors.ctan.org/macros/latex/contrib/mcmthesis.zip; licence: LPPL 1.3c, LICENSE:1-2 and mcmthesis.dtx:8-14; ctan.org/pkg/mcmthesis read once: package exists, v6.3.3 of 2024-01-22, LPPL 1.3c)
- Kind: report (a contest solution paper with summary sheet, contents, appendices; the manifest hint says thesis, the demo is an MCM/ICM paper)
- Lib: v4
- Engine: pdfLaTeX-compatible (the class branches on `\ifpdf`, `\ifxetex` or dvipdfmx at mcmthesis.dtx:743-753 and :758-766; the demo header reads `pdflatex|xelatex` at :1153; only the manual driver needs XeLaTeX, ctexcap at :106)
- Look carried by: class (the whole look is in `mcmthesis.cls`, which is module `class` of mcmthesis.dtx:648-1148; the demo adds option values, `txfonts`, `indentfirst`, `lipsum` at :1157-1169)
- Class origin: ctan
- Main file: none as a `.tex` file. The sample is the docstrip module `demo` inside mcmthesis.dtx:1152-1439 (the generated `mcmthesis-demo.tex` is not in the zip). Class code: mcmthesis.dtx:648-1148. Other sample: the manual driver mcmthesis.dtx:99-141 (documents the class, is not the template).
- Read: main yes, zip-local classes and styles all (no `.cls` or `.sty` ships; the whole `mcmthesis.dtx`, 1506 lines, was read; `README.md`, `LICENSE`, both `code/` files were read; the two PDFs are binary and were not opened)

All citations below are `mcmthesis.dtx:LINE` unless another file is named.

## Verdict
yes. The look is carried by one published CTAN class, `mcmthesis` 6.3.3 (W1), chosen by key-value options (W2: `tcn`, `problem`, `tstyle`, `sheet`, `titleinsheet`, `keywordsinsheet`, `titlepage`, `abstract`, `CTeX`), generic for any MCM/ICM paper (W3), and printed as `\documentclass[...]{mcmthesis}` or `\mcmsetup{...}` (W4). The demo sets options and uses the class vocabulary; no TikZ or other drawing exists (the summary sheet is three minipages and a rule), no tool outside TeX is needed, and every other construct maps to a lib way. This is evidence about the class dimension: the class source also holds hand-rolled code (`\AIcite`, `ReportAiUse`), which is published and therefore not bespoke here (see Bespoke code).

## Blockers
none

## Class setting
- Class: `class.mcmthesis` options: `tcn` (string, default 0000), `problem` (string), `tstyle` (font and colour switch, default `\color{red}\bfseries`), booleans `sheet` `titleinsheet` `keywordsinsheet` `titlepage` `abstract` `CTeX` (mcmthesis.dtx:665-675, :696); the demo sets `tstyle=\color{red}\bfseries, tcn=0000, problem=A, sheet=true, titleinsheet=true, keywordsinsheet=true, titlepage=false, abstract=true` through `\mcmsetup` (:1157-1160). Documentation says the default problem is A (:539), the code sets B (:675).
- Class-native vocabulary used: `\mcmsetup`, redefined `abstract` environment (:871), `keywords` environment (:901), redefined `\maketitle` (:840) which prints the summary sheet, `\MCMversion` (:653, used at :1170), `Theorem` and `Lemma` environments (:1037-1038, used :1236-1241), `appendices` environment, `letter` environment (:879, used :1349), `ReportAiUse` environment (:1125, used :1377), `\AIcite` (:1105, used :1331), `\AImatter` (:1145, used :1375); defined but only in comments or docs: `memo` with `\memoto` `\memofrom` `\memosubject` `\memodate` `\memologo` (:1002, :1197-1204), `\headset` (:912), `\problem` (:918).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | mcmthesis.dtx:707, :1155 | `class.mcmthesis`, `class.article` | the class loads `\LoadClass[letterpaper, 12pt]{article}`; options above |
| paper and size | mcmthesis.dtx:707, :771 | `page.class-options`, `page.geometry` | `letterpaper`, `12pt`; `\geometry{letterpaper, margin = 1in}` |
| running head | mcmthesis.dtx:776-787, :781, :848 | `hf.fancyhdr` | style `main`: `\fancyhf{}`, `\lhead{\small\sffamily \team}` (`\team` = "Team \# tcn", :712), `\rhead{\small\sffamily Page \thepage\ of \pageref{LastPage}}`; style `aimain`: rhead "Page \thepage" only; `\pagestyle{fancy}` inside `\maketitle` |
| page X of Y | mcmthesis.dtx:779, :1145, :1373 | `xref.kernel` | `\pageref{LastPage}` with a hand-placed `\label{LastPage}` (the `lastpage` package is commented out, :718); `\AImatter` places the label |
| page counter | mcmthesis.dtx:847 | `pgnum.pagenumbering` | `\setcounter{page}{1}` after the summary sheet |
| paragraph shape | mcmthesis.dtx:792, :1168 | `sp.lengths`, `sp.indentfirst` | `\parskip = .5\baselineskip`; `indentfirst` in the demo |
| manual space, rules | mcmthesis.dtx:922, :928-942, :1027, :1354 | `sp.manual-space`, `sp.rule`, `sp.ragged` | `\vspace*{-5pc}`, `\\[0.7pc]`, `\\[2.8pc]`, `\vskip 5pt`, `\rule{\linewidth}{1.5pt}`, memo rule `\rule[0.5ex]{\linewidth}{0.1pt}`, `\vspace{\parskip}`; `\centering` (:1260), `\centerline` (:1222) |
| encoding, sans face | mcmthesis.dtx:731-732 | `font.fontenc-t1`, `font.helvet` | `[T1]{fontenc}`; `[scaled]{berasans}` (the sans package is the parameter) |
| text and math face | mcmthesis.dtx:1166 | `font.mathptmx` | `\usepackage{txfonts}`; `times`, `newtxtext`, `palatino` are commented alternatives (:1163-1165) |
| size and shape switches | mcmthesis.dtx:778, :929, :944, :1017, :1050-1062 | `font.size-commands`, `mark.kernel` | `\small\sffamily`, `\Large`, `\LARGE`, `\large`, `\bfseries\scshape`, `\rmfamily`, `\textbf` |
| listing face | mcmthesis.dtx:1078 | `font.nfss` | `\def\lstbasicfont{\fontfamily{pcr}\selectfont\footnotesize}` |
| symbol glyphs | mcmthesis.dtx:728 | `font.icons` | `pifont` loaded, never called |
| colour | mcmthesis.dtx:754, :1075-1077, :675, :1363 | `color.xcolor` | `[svgnames]{xcolor}`; `grey` (0.8,0.8,0.8), `darkgreen` (0,0.3,0), `darkblue` (0,0,0.3); `tstyle` default `\color{red}\bfseries`; demo `\textcolor[rgb]{0.98,0.00,0.00}` |
| links | mcmthesis.dtx:733, :759-764, :1171, :1217 | `meta.hyperref`, `meta.url` | `\hypersetup{hidelinks}` (pdf and xetex), `{dvipdfm, hidelinks}` otherwise; `\href` in the author field, `\url` in the text |
| title block | mcmthesis.dtx:957-979, :1170-1173 | `front.maketitle`, `front.class-native`, `front.thanks`, `tbl.tabular` | `\title`, `\author{\small \href{..}{\includegraphics[width=7cm]{mcmthesis-logo}}}`, `\date{\today}`; class prints centred `\LARGE` title, `\vskip 1.5em`, author in `tabular[t]{c}` at `\large`, date; `\let\footnote\thanks`; not printed in the demo (`titlepage = false`, :1160) |
| summary sheet | mcmthesis.dtx:919-952, :840-853 | `front.class-native`, `box.minipage`, `sp.rule` | `\thispagestyle{empty}`; three `minipage[t]` of `0.33\linewidth` ("Problem Chosen" + `\Large` problem in `tstyle`; `\headset` = year, "MCM/ICM", "Summary Sheet"; "Team Control Number" + tcn); 1.5pt rule; optional `\LARGE` title and keywords; then the abstract |
| abstract | mcmthesis.dtx:858, :871-877, :1175-1190 | `abs.class-native` | `abstract` records its body (`\RenewEnviron`), printed by `\make@abstract`: centred bold `\abstractname` = "Summary"; the `CTeX=true` branch uses a box (:859-869) |
| keywords | mcmthesis.dtx:891, :901-905, :1187-1189 | `abs.keywords` | `keywords` records its body (`\NewEnviron`), printed as `\par\noindent\textbf{Keywords}: ...`; the demo nests it inside `abstract` |
| contents | mcmthesis.dtx:796-802, :1193 | `toc.kernel` | `\tableofcontents` redefined: `\centerline{\normalfont\Large\bfseries\sffamily\contentsname}`, `\vskip 5ex`, `\@starttoc{toc}` |
| appendix | mcmthesis.dtx:720, :1342-1371 | `num.appendix` | `\RequirePackage[toc, page, title, titletoc, header]{appendix}`; `appendices` environment with `\section` |
| headings | mcmthesis.dtx:1047-1062 | `head.kernel` | `\@startsection` for four levels: fonts `\rmfamily\Large\bfseries`, `\rmfamily\large\bfseries`, `\rmfamily\normalsize\bfseries`, `\rmfamily\normalsize`; before-skip `-1sp plus -.2ex minus -.2ex` (sections), `-.5ex plus -1ex minus -.2ex` (subsubsection), `1ex plus1ex minus.2ex` (paragraph); after-skip `1pt plus .2ex`, `.25ex plus .2ex`, `-1em` |
| float parameters | mcmthesis.dtx:812-822, :727 | `fig.placement` | `totalnumber 4`, `topnumber 2`, `bottomnumber 2`, `\textfraction .15`, `\topfraction .85`, `\bottomfraction .65`, `\floatpagefraction .60`; `flafter` loaded |
| figure | mcmthesis.dtx:833-834, :744-745, :1258-1263 | `fig.graphicx`, `fig.epstopdf` | `figure[h]`, `\small\centering`, `\includegraphics[width=8cm]{example-image-a}`; `\graphicspath` of eleven folders (`./figures/` among them); `epstopdf` loaded under pdfTeX, the demo includes only PDF and JPG files, so no converter runs |
| caption | mcmthesis.dtx:827-828, :1262 | `cap.kernel`, `xref.kernel` | `\figurename` = Figure, `\tablename` = Table; plain `\caption`, `\label`; no `caption` package |
| theorems | mcmthesis.dtx:722, :1037-1042, :1236-1244 | `thm.amsthm` | `\newtheorem{Theorem}{Theorem}[section]`; Lemma, Corollary, Proposition, Definition, Example share the Theorem counter; all in the default `plain` style; `proof` environment |
| math | mcmthesis.dtx:723-725, :1067-1069, :1265-1293 | `math.amsmath`, `math.bm`, `math.amssymb` | `amsmath`, `bm`, `mathrsfs`, `amssymb`, `amsfonts`, `latexsym`; `\providecommand` for `\dif` `\me` `\mi`; the sample has `equation` with `\eqref`, `pmatrix`, `cases`, `\eqno` |
| lists | mcmthesis.dtx:721, :1020, :1228-1232, :1316-1326 | `list.kernel`, `list.paralist` | `itemize`; `description` inside `memo`; `paralist` loaded, never called |
| tables | mcmthesis.dtx:726, :729 | `tbl.longtable`, `tbl.multirow`, `tbl.tabularx`, `tbl.booktabs`, `tbl.colortbl` | loaded and never called by the class or the demo body (the demo has no table) |
| boxes | mcmthesis.dtx:716 | `box.fancybox` | `fancybox` loaded, never called |
| letter and memo | mcmthesis.dtx:879-885, :1002-1032, :1349-1360 | `front.class-native`, `box.minipage` | `letter{addressee}`: `\parindent0pt`, 5cm `minipage` with `\flushleft`, then `\smallskip`; `memo[title]`: optional logo block, centred `\LARGE\bfseries\scshape` title, `description` of To, From, Subject, Date, rule, `\bigskip`, `\clearpage` at the end |
| bibliography | mcmthesis.dtx:1329, :1333-1340 | `bib.thebibliography` | `thebibliography{99}`, `\bibitem`, `\cite{1,2,3}`; the class adds nothing |
| report on use of AI | mcmthesis.dtx:1103-1145, :1331, :1375-1436 | `class.mcmthesis`, `sp.penalties` | class-native `ReportAiUse{9}`: heading `\centerline{\underline{\large\sffamily\bfseries "Report on Use of AI"}}`, numbered `\bibitem` list, `\clubpenalty4000`, `\widowpenalty4000`; `\AIcite{AI1,AI2,AI3}` prints `[AI: 1, 2, 3]`; `\AImatter` = `\label{LastPage}\clearpage\pagestyle{aimain}` |
| code | mcmthesis.dtx:1079-1097, :1364, :1369, :1383 | `code.listings` | `\lstset{showstringspaces=false, showspaces=false, tabsize=4, frame=lines, basicstyle={\footnotesize\lstbasicfont}, keywordstyle=\color{darkblue}\bfseries, commentstyle=\color{darkgreen}, stringstyle=\color{black}, breaklines=true, postbreak=\mbox{\textcolor{red}{$\hookrightarrow$}\space}}`; `\lstloadlanguages{C,C++,Java,Matlab,python,Mathematica}`; `\lstinputlisting[language=Matlab]`, `[language=C++]`, `lstlisting[language=python]`; the listing text is content |
| filler text | mcmthesis.dtx:1169 | `draft.todo` | `lipsum` |
| manual driver (not the template) | mcmthesis.dtx:102-140 | `class.ltxdoc`, `dtx.doc`, `lang.cjk` | `\documentclass{ltxdoc}`, `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput{\jobname.dtx}`; `\usepackage[UTF8, fontset=fandol,fntef]{ctexcap}` (XeLaTeX); `hologo` (`font.icons`), `\lstset` with `language=[LaTeX]TeX` (`code.listings`), `\AtBeginDocument{\hypersetup{colorlinks=true}}` (`meta.hyperref`) |

Load-only helpers with no printed effect (`xkeyval`, `etoolbox`, `ifthen`, `calc`, `ifpdf`, `ifxetex`, `environ`; mcmthesis.dtx:659-660, :717, :728, :734-738) are macro infrastructure, not components (the lib's v4 log rejected the same type as `sys.compat-load`).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `mcmthesis.cls` as a whole (module `class`) | mcmthesis.dtx:648-1148 | not bespoke: published on CTAN, so W1 holds | `class.mcmthesis` plus options |
| option plumbing: `\define@boolkey`, `\define@key`, `\setkeys`, `\ProcessOptionsX` | mcmthesis.dtx:659-702 | yes (it is the class option interface) | emit `\documentclass[tcn=..,problem=..,sheet=..]{mcmthesis}` or `\mcmsetup{..}` |
| `\maketitle`, `\makesheet`, `\MCM@maketitle` driven by four booleans | mcmthesis.dtx:840-853, :919-979 | yes | the sheet and title rows above (`box.minipage`, `sp.rule`, `sp.manual-space`); the emitter resolves the booleans |
| `abstract` and `keywords` as stored-body environments | mcmthesis.dtx:871-877, :901-905 | yes | the emitter holds both nodes and prints them where `\make@abstract` and `\make@keywords` do |
| `memo`, `letter`, `\ifthenelse{\equal{..}{\relax}}` field tests | mcmthesis.dtx:879-885, :986-1032 | yes | `description` of the set fields (`list.kernel`), `minipage`, 0.1pt rule; the empty-field tests resolve by inlining |
| `\renewcommand\section` ... `\@startsection` (four levels) | mcmthesis.dtx:1047-1062 | yes | the values in the headings row, as `head.titlesec` `\titleformat` and `\titlespacing*` |
| `\tableofcontents` redefinition | mcmthesis.dtx:796-802 | yes | the title font, centred, 5ex gap in the contents row, as `toc.tocloft` title parameters |
| `\AIcite`, `ReportAiUse`, `\AImatter` (copies of the kernel `\@citex` with a `\@for` loop and a `\write` to the aux file, and of `thebibliography`) | mcmthesis.dtx:1103-1145 | published class code, not a blocker; rebuilt without the class it would be irreducible, `BESPOKE/class` | kept as class vocabulary under `class.mcmthesis` |
| `\providecommand{\dif}` `{\me}` `{\mi}`, `\team`, `\headset`, `\def\lstbasicfont`, `\def\MCMversion` | mcmthesis.dtx:1067-1069, :712, :912, :1078, :653 | yes | inline expansion |
| manual aliases `\pkg` `\env` `\cntr` `\XeLaTeX` `\mem` `\file` `\path` `\mopt` | mcmthesis.dtx:129-136 | yes | `\textsf`, `\hologo{XeLaTeX}`, `\textcolor{blue}{\kaishu ..}` |

## Content-opaque
none (assets shipped: `figures/example-image-a.pdf`, `figures/mcmthesis-logo.pdf`, `figures/qrcodewechat.jpg`; listing sources `code/mcmthesis-matlab1.m`, `code/mcmthesis-sudoku.cpp`)

## Lib changes
- New ways proposed: none. Considered and not proposed: `hhline` (loaded at mcmthesis.dtx:726, never called; same tools-bundle family as `array`, so `tbl.tabular`), `latexsym` (a math symbol font, filed under `math.amssymb`), `berasans` (a sans package, filed under `font.helvet`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
