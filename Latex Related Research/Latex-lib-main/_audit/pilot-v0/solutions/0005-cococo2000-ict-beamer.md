yes

# 0005-cococo2000-ict-beamer: ICT Beamer Theme (Institute of Computing Technology, CAS, thesis-defence slides)

- Unverified: read from the source, not compiled.
- Source: Source/0005-cococo2000-ict-beamer/ (origin: https://codeload.github.com/cococo2000/ICT-Beamer/zip/refs/heads/main; licence: MIT, LICENSE:1 and :3 "Copyright (c) 2025 Patrick Ge")
- Kind: presentation
- Lib: v0
- Engine: needs XeLaTeX (ctex/CJK: the lib tags `lang.cjk` xe/lua, and README.md:17-18,25 says to use `xelatex`; everything else in the sample is pdfLaTeX-compatible)
- Main file: main.tex (other samples: none; chapters/*.tex are `\input` fragments, ICT_Beamer_Sample.pdf and Img/Sample.png are the author's rendered output, not read as evidence)
- Read: main yes (125 lines, plus all four chapters/*.tex and ref.bib), zip-local classes and styles all (ICT-theme.sty, 88 lines; no .cls, .def, .cfg, .clo, .bbx or .cbx present)

## Verdict
Yes. The class is the published `beamer`; ICT-theme.sty contains no typesetting logic of its own, only published beamer calls (`\useoutertheme`, `\useinnertheme`, `\setbeamercolor`, `\setbeamerfont`, `\setbeamertemplate`, `\AtBeginSection`) plus one footline body made of `beamercolorbox` rows and `\insert...` fields. The few zip-local macros are a one-character alias (`\frameofframes`), two unused `\def` aliases and an inert `\newif`, all reducible. There is no TikZ/PGF/picture drawing: the identity artwork is two included logo files (assets). Two items needed new ways (`NEW:slide.beamer-section-hook`, `NEW:font.display-pkg`); a few loaded packages are never used by any file, so they are dead loads, not components (judgement stated under Component map).

## Blockers
none

## Class setting
- Class: `class.beamer` options: `aspectratio=169` (main.tex:1; the 4:3 alternative is commented at main.tex:2). No `\usetheme` is active (main.tex:30-32 are commented), so the base is beamer's default theme with the outer/inner/colour/font overrides below.
- Class-native vocabulary used: `frame` with `[allowframebreaks]` (main.tex:101, Chap1_Intro.tex:3,19), `\frametitle`, `\titlepage` (main.tex:57), `\tableofcontents[sectionstyle=..., subsectionstyle=..., subsubsectionstyle=...]` (main.tex:74, ICT-theme.sty:78,83), `columns[T]` / `column{<w>\textwidth}` (Chap1_Intro.tex:5-15, Chap6_Sum.tex:5-22), `\section` / `\section*` as navigation entries, `\author[short]{...}` `\title` `\subtitle` `\date` (main.tex:14-26), `\nocite{*}` inside a frame (main.tex:103), insert fields `\insertshortauthor` `\insertshortinstitute` `\insertshorttitle` `\insertframenumber` `\inserttotalframenumber` (ICT-theme.sty:21-29).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.beamer` | aspectratio=169 |
| page size / aspect | main.tex:1 | `page.class-options` | aspectratio=169 (beamer class option sets the page size) |
| CJK support and font switch | main.tex:3, main.tex:55 | `lang.cjk` | `ctex` loaded with no options; `\kaishu` (KaiTi) issued before the first frame, so every frame is in the kai family |
| hyperlinks | main.tex:3 | `meta.hyperref` | `hyperref` loaded with no options (beamer also loads it itself) |
| font encoding | main.tex:4 | `font.fontenc-t1` | fontenc=T1 |
| symbol package | main.tex:7 | `math.amssymb` | package `latexsym`; family-level fit (same symbol family, not amssymb itself); no math appears in the sample |
| maths | main.tex:7 | `math.amsmath` | `amsmath` loaded, no maths in the sample |
| colour package | main.tex:7 | `color.xcolor` | `xcolor`, no options |
| multicolumn (dead load) | main.tex:7 | `cols.multicol` | `multicol` loaded; no `multicols` anywhere (grep) |
| rules in tables (dead load) | main.tex:7 | `tbl.booktabs` | `booktabs` loaded; the one table uses `\hline` (Chap1_Intro.tex:25-29) |
| decorative script font | main.tex:7, main.tex:118 | `NEW:font.display-pkg` | package `calligra`; switch `\calligra` on "Thanks!" with `\Huge` |
| images | main.tex:8, main.tex:62,67, Chap1_Intro.tex:8,13 | `fig.graphicx` | `\includegraphics` widths 0.7\linewidth, \linewidth; files logos/*.pdf and logos/UCAS_onlylogo.eps |
| PSTricks (dead load) | main.tex:8 | `art.pstricks` | `pstricks` loaded, no `pspicture` or `\ps...` command in any file, so no artwork |
| code listings setup | main.tex:8, main.tex:42-51 | `code.listings` | `\lstset`: basicstyle=\ttfamily\small, keywordstyle=\bfseries\color{deepblue}, emphstyle=\ttfamily\color{deepred}, stringstyle=\color{deepgreen}, numbers=left, numberstyle=\small\color{halfgray}, rulesepcolor=\color{red!20!green!20!blue!20}, frame=shadowbox. No `lstlisting` in the sample (setup only) |
| stackengine (dead load) | main.tex:8 | none: dead load | `stackengine` loaded; no `\stack...` command in any file. No lib way and none proposed, see Verdict and Content-opaque |
| citations | main.tex:9 | `bib.natbib` | options super, square |
| icons (dead load) | main.tex:10 | `font.icons` | `fontawesome5` loaded; no `\fa...` command in any file |
| table helpers (dead load) | main.tex:11 | `tbl.multirow` | `multirow`, `makecell`, `diagbox` loaded; none used |
| title, subtitle, date | main.tex:22-26 | `front.class-native` | `\title{中文标题\\English Title}`, `\subtitle{硕士/博士学位论文答辩}`, `\date{xxxx年xx月xx日}`; `\institute` is commented out (main.tex:24), so the footline institute slot prints empty |
| author block | main.tex:14-21 | `front.class-native` + `tbl.tabular` | `\author[short text]{tabular}` with column spec `@{}r@{：}c@{}`, three rows; `\hspace{0.5em}` / `\hspace{0.8em}` in cells |
| title frame | main.tex:56-70 | `class.beamer` + `cols.minipage` + `sp.ragged` + `sp.lengths` + `fig.graphicx` | `\titlepage`, `\vspace{-7em}`, `center`, two `minipage` of width 0.45\linewidth (first `\raggedleft` with logo at 0.7\linewidth, second `\centering` with logo at \linewidth), `\hspace{0em}` between |
| contents frame | main.tex:73-75 | `toc.kernel` | `\tableofcontents[sectionstyle=show, subsectionstyle=show/shaded/hide, subsubsectionstyle=show/shaded/hide]` |
| contents frame before every (sub)section | ICT-theme.sty:76-85 | `NEW:slide.beamer-section-hook` + `toc.kernel` | `\AtBeginSection[]` and `\AtBeginSubsection[]`, body = frame with `\tableofcontents[sectionstyle=show/shaded, subsectionstyle=show/shaded/hide, subsubsectionstyle=show/shaded/hide]`; the empty `[]` leaves the starred sections (致谢, 附录) without it |
| sectioning | Chap1_Intro.tex:1, Chap2_Related.tex:1, Chap6_Sum.tex:1, main.tex:81,86,91,115, Appendix.tex:1 | `head.class-native` | `\section{...}` feeds navigation and contents (no printed heading in beamer); `\section*{致谢}`, `\section*{附录}` unnumbered. No `\appendix` is issued |
| content split over files | main.tex:78,79,97,123 | none needed (kernel `\input`) | `\input` of four fragments; an emitter flattens them, no look involved |
| beamer columns | Chap1_Intro.tex:5-15, Chap6_Sum.tex:5-22 | `class.beamer` | `columns[T]`; `column{0.3\textwidth}` x2 with `\hfill` between (Chap1_Intro.tex:10), `column{0.5\textwidth}` x2 |
| lists | Chap6_Sum.tex:8-12, 16-20 | `list.kernel` + `mark.kernel` | `itemize` with `\item \textbf{...}`; bullets drawn by the inner theme `circles` |
| table in frame | Chap1_Intro.tex:21-31 | `tbl.tabular` + `cap.kernel` + `sp.ragged` | `table[ht]` (beamer makes it non-floating), `\centering`, `\caption`, `tabular{cc}`, `\hline`, `\textbf` header cells |
| caption look | ICT-theme.sty:49 | `slide.beamer-template` | `\setbeamertemplate{caption}[numbered]` |
| bibliography frame | main.tex:101-112 | `bib.bibtex-bst` + `bib.natbib` + `font.size-commands` | `frame[allowframebreaks]`, `\nocite{*}`, `\scriptsize`, `\bibliographystyle{ieeetr}` (alpha, apalike, plain, unsrt, siam commented at :105-109), `\bibliography{ref}`; run is xelatex, bibtex, xelatex, xelatex (README.md:34-37) |
| bibliography item look | ICT-theme.sty:48 | `slide.beamer-template` | `\setbeamertemplate{bibliography item}[text]` |
| closing frame | main.tex:115-120 | `sp.ragged` + `font.size-commands` + `NEW:font.display-pkg` | `center`, `\Huge\calligra Thanks!` |
| appendix frame | Appendix.tex:1-7 | `head.class-native` + `class.beamer` | `\section*{附录}`, frame with `\frametitle{附录A}`, empty body |
| colours defined | main.tex:37-40, ICT-theme.sty:41 | `color.xcolor` | deepblue rgb 0,0,0.5; deepred rgb 0.6,0,0; deepgreen rgb 0,0.5,0; halfgray gray 0.55; `\xdefinecolor{ucasblue}{RGB}{23, 73, 148}` |
| outer theme (headline nav bar) | ICT-theme.sty:9 | `slide.beamer-theme` | `\useoutertheme[footline=authorinstitutetitle,subsection=false]{smoothbars}`; the footline key is superseded by the footline template at :15 (the miniframes variant at :10 is commented) |
| inner theme | ICT-theme.sty:36 | `slide.beamer-theme` | `\useinnertheme{circles}` (the rounded variant at :39 is commented) |
| footline | ICT-theme.sty:15-33 | `slide.beamer-template` + `hf.class-native` | `\setbeamertemplate{footline}` with four `beamercolorbox` rows, see Bespoke code |
| frame-title and block colours | ICT-theme.sty:43-60 | `slide.beamer-template` | `\setbeamercolor`: footline bg=ucasblue; frametitle bg=ucasblue fg=white; title bg=ucasblue; block title bg=ucasblue fg=white; `block title example` (star form) use={normal text,example text} bg=white fg=ucasblue; fine separation line empty |
| palette colours | ICT-theme.sty:51-56 | `slide.beamer-template` | palette primary fg=white bg=structure.fg; secondary bg=structure.fg!75!black; tertiary bg=structure.fg!50!black; quaternary fg=white bg=structure.fg!50!black; titlelike parent=palette primary |
| structure colour | ICT-theme.sty:73 | `slide.beamer-template` | structure fg=ucasblue |
| sidebar colours (inert) | ICT-theme.sty:62-72, 74-75 | `slide.beamer-template` | item projected fg=white; palette sidebar primary/secondary/tertiary/quaternary; section/subsection in sidebar fg=brown, shaded fg=grey; separation line empty; sidebar bg=ucasblue then parent=palette primary. No sidebar theme is loaded, so these keys have no visible user in this zip |
| frametitle font | ICT-theme.sty:46 | `slide.beamer-template` | `\setbeamerfont{frametitle}{size=\large}` |
| navigation symbols | ICT-theme.sty:47 | `slide.beamer-template` | the removal line is commented, so beamer's default navigation symbols stay |
| theme mode wrappers | ICT-theme.sty:1, 87-88 | none needed | `\mode<presentation>` ... `\mode<all>`; scoping only, nothing printed |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| ICT-theme.sty as a whole | ICT-theme.sty:1-88 | yes | A flat run of published beamer calls: 2 theme loads, ~25 `\setbeamercolor`, 1 `\setbeamerfont`, 3 `\setbeamertemplate`, 2 section hooks; the emitter prints these lines as preamble (`slide.beamer-theme`, `slide.beamer-template`, `NEW:slide.beamer-section-hook`) |
| `\newif\ifbeamer@secheader`, `\beamer@secheaderfalse` | ICT-theme.sty:3-4 | yes | Inert in this zip: no file tests the flag (grep `secheader` hits only :3, :4, and the commented :6). I could not read beamer's own theme sources (no TeX tree here), so I cannot rule out that a beamer outer theme reads a flag of this name; if so it is a published theme switch set to false, not zip logic. Drop it |
| `\ProcessOptionsBeamer` with no declared options | ICT-theme.sty:7 | yes | No-op (the only `\DeclareOptionBeamer` is commented, :6); drop |
| `\frameofframes`, `\setframeofframes` | ICT-theme.sty:13-14 | yes | Alias for the separator "/"; `\setframeofframes` is never called (grep). Inline "/" into the footline |
| footline template body | ICT-theme.sty:15-33 | yes | Only published beamer constructs. Rows, top to bottom: (1) `beamercolorbox[wd=\paperwidth,colsep=1.5pt]{upper separation line foot}` empty; (2) `[wd=\paperwidth,ht=2.5ex,dp=1.125ex,leftskip=.3cm,rightskip=.3cm plus1fil]{author in head/foot}` with `\insertshortauthor` left, `\hfill`, `\insertshortinstitute` right (font and fg from `institute in head/foot`); (3) same box geometry in colour `title in head/foot` with `\insertshorttitle` left, `\hfill`, `\insertframenumber~/~\inserttotalframenumber` right (font and fg `frame number`); (4) `beamercolorbox[wd=\paperwidth,colsep=1.5pt]{lower separation line foot}` empty. Declarative as a list of (colour, wd, ht, dp, colsep, leftskip, rightskip, left slot, right slot) |
| `\def\cmd#1`, `\def\env#1` | main.tex:35-36 | yes | `\texttt{\color{red}\footnotesize $\backslash$#1}` and `\texttt{\color{blue}\footnotesize #1}`: aliases of `mark.kernel`, `color.xcolor`, `font.size-commands`; never used in any file (grep), drop |
| `\makeatletter` / `\makeatother` in a .sty | ICT-theme.sty:12,34 | yes | Redundant category-code switch inside a package file; drop |

## Content-opaque
- Included logo images (assets to ship): logos/UCAS_logo.pdf (main.tex:62), logos/ICT_logo.pdf (main.tex:67), logos/UCAS_onlylogo.eps (Chap1_Intro.tex:8, 7.6 MB, the only EPS), logos/ICT_onlylogo.pdf (Chap1_Intro.tex:13). Images, not drawings, so not `ART`. Note: README.md:71 lists `ucas_logo.pdf` while the file on disk is `UCAS_logo.pdf`.
- `stackengine` loaded at main.tex:8 and never used; no lib way holds it and none is proposed because it is a content-construct package with no template effect here. It is the one item that rests on the "dead load" judgement; the sample would print the same without the line (not checked by compiling).
- Chinese placeholder text, the single bibliography entry (ref.bib:7-12) and the table cell text are content.

## Lib changes
- New ways proposed:
  - `NEW:slide.beamer-section-hook`: beamer `\AtBeginSection[<text for starred>]{<body>}` and `\AtBeginSubsection[...]{<body>}`, pdf. Grep of `_Lib.md` for AtBegin, hook, frame finds only `class.beamer` (frames, `\usetheme`, overlays), `slide.beamer-template` (`\setbeamertemplate`/colour/font) and `slide.beamer-mode` (handout, notes, overlays); none covers per-section inserted frames. W1: documented in the beamer user guide. W2: chosen by the optional starred-text argument and the body, which in practice is one frame holding `\tableofcontents[...]` options (`toc.kernel`) or a section-page; weakest of the four, because the body is a beamer fragment rather than a plain value. W3: any beamer deck with an outline-per-section. W4: one preamble line wrapping a frame.
  - `NEW:font.display-pkg`: a published font package whose command switches the family for a span, here `calligra` and `\calligra`, pdf (T1). Grep of `_Lib.md` for calligra, display, script finds nothing; `font.helvet`, `font.mono`, `font.libertine` etc. are text-face families, and `font.family-default` is about `\rmdefault`-style defaults, not a span switch. W1: `calligra` is on CTAN. W2: chosen by which package is loaded and where the switch wraps text, as with `font.helvet` (package is the parameter). W3: yfonts, calligra, pbsi and similar display faces. W4: `\usepackage{calligra}` plus `{\calligra ...}` wrapper.
- Fit note, not a new way: `latexsym` is filed under `math.amssymb` at family level; the row text lists only `amssymb`/`amsfonts`, so the consolidator may want to widen it. No new id proposed.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
