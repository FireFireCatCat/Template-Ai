yes

# 0005-cococo2000-ict-beamer: ICT Beamer Theme (Institute of Computing Technology, CAS; UCAS defence slides)

- Unverified: read from the source, not compiled.
- Source: Source/0005-cococo2000-ict-beamer/ (origin: https://codeload.github.com/cococo2000/ICT-Beamer/zip/refs/heads/main; licence: MIT, LICENSE:1-3)
- Kind: presentation
- Lib: v1
- Engine: needs XeLaTeX (`ctex` main.tex:3 and `\kaishu` main.tex:55; README.md:17 recommends xelatex; pdfLaTeX would need CJK fonts set up by hand)
- Look carried by: zip-local (ICT-theme.sty sets every colour, the footline and the section hooks on top of beamer's own smoothbars and circles themes; main.tex adds only package loads, colours, `\lstset` and two unused helper macros)
- Class origin: tex-distribution-unbundled (beamer, not in the zip; the style `ICT-theme.sty` is zip-local, it is not a class)
- Main file: main.tex (other samples: none; it `\input`s chapters/Chap1_Intro.tex, Chap2_Related.tex, Chap6_Sum.tex, Appendix.tex; ICT_Beamer_Sample.pdf and Img/Sample.png are prebuilt outputs, not read as source)
- Read: main yes, zip-local classes and styles all (ICT-theme.sty, 88 lines; no .cls/.def/.cfg/.clo in the zip)

## Verdict
Yes. The class is the published `beamer`; the only zip-local code is `ICT-theme.sty`, which is a list of beamer theme, template, colour and font calls plus one footline template built from beamer's own `beamercolorbox` and `\insert...` commands, so it reduces to `slide.beamer-theme`, `slide.beamer-template`, `slide.beamer-section-hook`, `slide.beamer-mode` and `color.xcolor` with parameters. There is no artwork (no TikZ, PGF or picture code anywhere, grep-checked), no external tool in the TeX run beyond BibTeX, and no irreducible macro. Judgement calls, for a stricter re-reading: (1) the footline body at ICT-theme.sty:15-33 is accepted as declarative beamer vocabulary (no conditionals, counters or loops); (2) `stackengine` is loaded but unused and gets a proposed way; (3) the EPS logo (7.6 MB) is image content whose conversion by the engine's toolchain is an asset concern, not template code.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `aspectratio=169` (main.tex:1; 4:3 variant commented at main.tex:2). Source of beamer was not read (ships with the TeX distribution).
- Class-native vocabulary used: `frame` and `frame[allowframebreaks]` (main.tex:56,101; Chap1_Intro.tex:3,19), `\frametitle`, `\titlepage` (main.tex:57), `\subtitle` (main.tex:23), short-form `\author[short]{long}` (main.tex:14), `\tableofcontents[sectionstyle=...,subsectionstyle=...,subsubsectionstyle=...]` (main.tex:74), `columns[T]` and `column{<width>}` (Chap1_Intro.tex:5-15; Chap6_Sum.tex:5-22), `\section` and `\section*` (frames follow each), `\nocite{*}` and bibliography inside a frame (main.tex:101-112), `\mode<presentation>` / `\mode<all>` and `\ProcessOptionsBeamer` (ICT-theme.sty:1,7,87-88).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.beamer` | aspectratio=169 |
| page size | main.tex:1 | `page.class-options` | aspectratio=169 (16:9) |
| CJK support and font | main.tex:3, 55 | `lang.cjk` | `ctex` loaded with defaults; `\kaishu` (KaiTi family) switched on once before the first frame; KaiTi font not shipped (missing asset, note) |
| hyperlinks | main.tex:3 | `meta.hyperref` | no options (beamer already loads hyperref) |
| encoding | main.tex:4 | `font.fontenc-t1` | T1 |
| math packages | main.tex:7 | `math.amsmath`, `math.amssymb` | amsmath; `latexsym` (symbol set, load-only, mapped to the symbol-set way, no new way) |
| colour engine | main.tex:7; ICT-theme.sty:41; main.tex:37-40 | `color.xcolor` | `\xdefinecolor{ucasblue}{RGB}{23, 73, 148}`; deepblue rgb 0,0,0.5; deepred rgb 0.6,0,0; deepgreen rgb 0,0.5,0; halfgray gray 0.55; `\color{red}`, `red!20!green!20!blue!20` |
| decorative script face | main.tex:7, 118 | `font.display` | `calligra`, `\calligra` on "Thanks!" |
| load-only packages | main.tex:7 | `cols.multicol`, `tbl.booktabs` | no `multicols` env and no booktabs rule is used in the sample (table uses `\hline`, Chap1_Intro.tex:25-30) |
| figures | main.tex:8, 62, 67; Chap1_Intro.tex:8, 13 | `fig.graphicx` | `\includegraphics[width=0.7\linewidth]` / `[width=\linewidth]`; PDF logos, one EPS (logos/UCAS_onlylogo.eps) |
| PSTricks (load-only) | main.tex:8 | `art.pstricks` | `pstricks` loaded, no `pspicture` or `\ps...` command anywhere; not drawn, so not an ART blocker |
| listing setup (no listing in body) | main.tex:8, 42-51 | `code.listings` | `\lstset`: basicstyle=\ttfamily\small, keywordstyle=\bfseries\color{deepblue}, emphstyle=\ttfamily\color{deepred}, stringstyle=\color{deepgreen}, numbers=left, numberstyle=\small\color{halfgray}, rulesepcolor=\color{red!20!green!20!blue!20}, frame=shadowbox |
| stacking (load-only) | main.tex:8 | `box.stackengine` | `stackengine` loaded with defaults, no `\stackon` etc. used |
| citations | main.tex:9 | `bib.natbib` | options `super`, `square` |
| icon font (load-only) | main.tex:10 | `font.icons` | `fontawesome5`; no `\fa...` command used (grep) |
| table helpers (load-only) | main.tex:11 | `tbl.multirow` | `multirow`, `makecell`, `diagbox`; none used in the sample body (grep) |
| front matter | main.tex:14, 22, 23, 26, 57 | `front.class-native` | `\author[short]{tabular}`, `\title{中文标题\\English Title}`, `\subtitle`, `\date`, `\titlepage` in a frame; `\institute` commented out (main.tex:24) |
| author block table | main.tex:15-20 | `tbl.tabular` | colspec `@{}r@{：}c@{}`, three rows; `\hspace{0.5em}` / `\hspace{0.8em}` via `sp.manual-space` |
| title-page logos | main.tex:58-69 | `box.minipage`, `sp.ragged`, `sp.manual-space`, `fig.graphicx` | two `minipage{0.45\linewidth}` (`\raggedleft` and `\centering`) inside `center`; `\vspace{-7em}`, `\hspace{0em}` |
| frames, columns | Chap1_Intro.tex:3-16; Chap6_Sum.tex:5-22 | `class.beamer` (native) | `columns[T]`, `column{0.3\textwidth}` x2 with `\hfill` between (`sp.manual-space`); `column{0.5\textwidth}` x2 |
| lists | Chap6_Sum.tex:8-12, 16-20 | `list.kernel`, `mark.kernel` | `itemize`, `\textbf` items |
| table and caption | Chap1_Intro.tex:21-31 | `tbl.tabular`, `cap.kernel`, `mark.kernel` | `table[ht]`, `\centering`, `tabular{cc}`, `\hline`, `\textbf` header; caption look is the beamer `caption` template below |
| contents frame | main.tex:73-75 | `toc.kernel` | `sectionstyle=show`, `subsectionstyle=show/shaded/hide`, `subsubsectionstyle=show/shaded/hide` |
| sectioning | main.tex:81,86,91,115; Chap1_Intro.tex:1; Chap2_Related.tex:1; Chap6_Sum.tex:1; Appendix.tex:1 | `head.kernel` | `\section{...}`; `\section*{致谢}`, `\section*{附录}`; no `\appendix` |
| per-section frame | ICT-theme.sty:76-85 | `slide.beamer-section-hook` | `\AtBeginSection[]` and `\AtBeginSubsection[]`, each a frame holding `\tableofcontents[sectionstyle=show/shaded,subsectionstyle=show/shaded/hide,subsubsectionstyle=show/shaded/hide]` |
| outer theme | ICT-theme.sty:9 | `slide.beamer-theme` | `\useoutertheme[footline=authorinstitutetitle,subsection=false]{smoothbars}` (miniframes variant commented, line 10) |
| inner theme | ICT-theme.sty:36 | `slide.beamer-theme` | `\useinnertheme{circles}`; `\usetheme` not called (main.tex:30-32 commented) |
| mode | ICT-theme.sty:1, 87-88 | `slide.beamer-mode` | `\mode<presentation>` ... `\mode<all>` |
| footer | ICT-theme.sty:15-33 | `hf.class-native`, `slide.beamer-template` | `\setbeamertemplate{footline}`: four stacked `beamercolorbox` (`upper separation line foot` colsep=1.5pt; `author in head/foot` ht=2.5ex dp=1.125ex leftskip=.3cm rightskip=.3cm plus1fil with `\insertshortauthor` and `\insertshortinstitute`; `title in head/foot` same lengths with `\insertshorttitle` and `\insertframenumber~/~\inserttotalframenumber`; `lower separation line foot` colsep=1.5pt), all `wd=\paperwidth` |
| beamer colours | ICT-theme.sty:43-45, 51-54, 56, 59-75 | `slide.beamer-template` | `footline` bg=ucasblue; `frametitle` bg=ucasblue fg=white; `title` bg=ucasblue; four `palette` colours from `structure.fg` (plain, !75!black, !50!black, !50!black); `titlelike` parent=palette primary; `block title` bg=ucasblue fg=white; `block title example` (starred) bg=white fg=ucasblue; `structure` fg=ucasblue; `item projected` fg=white; sidebar-family colours (lines 63-75; no sidebar theme is loaded, so likely inert) |
| beamer font | ICT-theme.sty:46 | `slide.beamer-template` | `\setbeamerfont{frametitle}{size=\large}` |
| beamer templates | ICT-theme.sty:48-49 | `slide.beamer-template` | `bibliography item`=text; `caption`=numbered; `navigation symbols` left at default (the removal at line 47 is commented out) |
| bibliography | main.tex:101-112; ref.bib | `bib.bibtex-bst`, `font.size-commands` | `\bibliographystyle{ieeetr}`, `\bibliography{ref}`, `\nocite{*}` inside `frame[allowframebreaks]`, `\scriptsize`; other styles commented (lines 105-109) |
| closing frame | main.tex:115-120 | `head.kernel`, `font.size-commands`, `font.display`, `sp.ragged` | `\section*{致谢}`, `center`, `{\Huge\calligra Thanks!}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `ICT-theme.sty` as a whole | ICT-theme.sty:1-88 | yes | a beamer style loaded with `\usepackage` (main.tex:27): `slide.beamer-mode`, `slide.beamer-theme` x2, `slide.beamer-template` (footline, colours, font, caption, bibliography item), `slide.beamer-section-hook` x2, `color.xcolor`; no logic of its own |
| `\newif\ifbeamer@secheader`, `\beamer@secheaderfalse` | ICT-theme.sty:3-4 | yes | dead: the flag is never tested and its `\DeclareOptionBeamer` is commented (line 6, grep-checked); drop. `\ProcessOptionsBeamer` (line 7) has no option to process |
| `\frameofframes`, `\setframeofframes` | ICT-theme.sty:13-14 | yes | `\frameofframes` is the literal "/" separator in the footline (line 29); `\setframeofframes` rewrites it and is never called. Emit "/" |
| footline template body | ICT-theme.sty:15-33 | yes (judgement) | `slide.beamer-template` `footline` with the four `beamercolorbox` nodes and `\insert...` commands listed in the map; only published beamer commands, `\hfill`, `\leavevmode`, `\usebeamerfont`, `\usebeamercolor[fg]` |
| `\cmd#1` | main.tex:35 | yes | alias for `\texttt{\color{red}\footnotesize $\backslash$#1}` (`mark.kernel`, `color.xcolor`, `font.size-commands`); never used in the sample |
| `\env#1` | main.tex:36 | yes | alias for `\texttt{\color{blue}\footnotesize #1}`; never used in the sample |

## Content-opaque
none (the logo images at main.tex:62, 67 and Chap1_Intro.tex:8, 13 are held by `fig.graphicx`; the EPS needs the engine's EPS conversion, an asset note, not template code)

## Lib changes
- New ways proposed: `box.stackengine` (`stackengine`, pdf; stacks or overlays one object on another with gap and alignment, `\stackon` `\stackunder` `\stackinset`, `\setstackgap`). W1: on CTAN with public documentation. W2: gaps, alignment and stack mode are lengths and keys. W3: serves any two-object stack. W4: a `\usepackage` line plus a body wrapper around two arguments. Load-only in this zip (never called), proposed because the preamble loads it and no existing way holds it.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
