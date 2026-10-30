yes

# 0720-dev-aditya-course-notes-core: course-notes `notes` class with boxed theorems (sample: MTH102 Real Analysis)

- Unverified: read from the source, not compiled.
- Source: Source/0720-dev-aditya-course-notes-core/ (origin: https://codeload.github.com/dev-aditya/course-notes-core/zip/refs/heads/master; licence: CC-BY-4.0 per manifest)
- Kind: book (lecture notes; the manifest hint is `book`/notes)
- Lib: v5
- Engine: pdfLaTeX-compatible (no `fontspec`, no Lua; `mdframed` TikZ method and `todonotes` run under pdfTeX)
- Look carried by: zip-local (the zip-local `notes.cls` sets paper, margins, link colours and the section sign; the zip-local `color-env.sty` sets every boxed theorem; the sample preamble only adds packages and its body hand-lays the title page)
- Class origin: zip-local (`notes.cls` is a 24-line personal wrapper, `\ProvidesClass{notes}[2020/11/01 Notes Class]`, notes.cls:2; it `\LoadClass`es the kernel `book`; no CTAN read made)
- Main file: MTH102_ Real-analysis/MTH102_-_Real_analysis.tex (other samples: MTH201_ Differential-Geometry/MTH201_-_Differential_Geometry.tex, PHY102_ Electromagnetism/PHY102_-_Electromagnetism.tex, PHY202_ Statistical-Mechanics and Thermodynamics/PHY202_-_Statistical Mechanics.tex, Misc/Periodic-table/periodic_table.tex, Misc/Pi_3.14/pi.tex; none of them read in full)
- Read: main yes (1768 lines), zip-local classes and styles all (`notes.cls`, `color-env.sty`, and also `color-tufte.sty`, which the main sample does not load)

Citation key: `notes.cls` and `color-env.sty` mean the copies in `MTH102_ Real-analysis/`. The copies in `MTH201_ Differential-Geometry/` are byte-identical (equal SHA-256). The manifest writes the folder as `MTH102: Real-analysis`; on disk it is `MTH102_ Real-analysis`. Main-file citations are written `MTH102_-_Real_analysis.tex:N` (unique name).

## Verdict
Yes, for the main sample. The look is two small zip-local files, and every piece of them is a composition of published packages with declarative parameters: `notes.cls` is `book[a4paper,oneside]` plus `geometry`, `hyperref` colours and a section-number prefix; `color-env.sty` is five numbered, coloured, titled theorem boxes plus a shaded `Problem` box, which reduce to `mdframed`/`tcolorbox` theorem boxes with `\newcounter` printing. The main body defines no macros of its own and draws no TikZ picture; its figures are `png` files inside floats. The weakest points are the TikZ title tab inside `frametitle` (reduced to a `tcolorbox` boxed title, so not `ART`) and the `\@seccntformat` hook (reduced to a `\titleformat` label); a stricter reading of either would turn this to `no`. Other samples in the zip are not covered by this verdict: the MTH201 cover is a TikZ page border of `pgfornament` pieces (MTH201_-_Differential_Geometry.tex:29-54, `ART` for that sample) and `periodic_table.tex` is a XeLaTeX/TikZ/`chemfig` drawing.

## Blockers
none

## Class setting
- Class: `class.book` options: `a4paper`, `oneside` (set inside the zip-local `notes` class, notes.cls:4; the sample calls `\documentclass{notes}`, MTH102_-_Real_analysis.tex:1). Reduction: write `\documentclass[a4paper,oneside]{book}` and move the other class lines to the preamble.
- Class-native vocabulary used: `\chapter` (83), `\section` (85), `\subsection` (545), `\paragraph` (341, also empty `\paragraph{}` as a spacer), `titlepage` environment (21-80), `\tableofcontents` (81), `\appendix` (1716), `\bibliographystyle`/`\bibliography` (1764-1765), all in MTH102_-_Real_analysis.tex.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | MTH102_-_Real_analysis.tex:1; notes.cls:4 | `class.book` | `\LoadClass[a4paper,oneside]{book}` wrapped by zip-local `notes` |
| paper and sides | notes.cls:4 | `page.class-options` | `a4paper`, `oneside` |
| page geometry | notes.cls:6 | `page.geometry` | `total={5in, 9in}` |
| link colours | notes.cls:5, 7-12 | `meta.hyperref` | `colorlinks=true`, `linkcolor=blue`, `filecolor=magenta`, `urlcolor=cyan` |
| external links | MTH102_-_Real_analysis.tex:695, 701, 1740, 1758-1759 | `meta.hyperref` | `\href{url}{text}`, once inside `\textsuperscript` (695) |
| running heads | no `\pagestyle`, `fancyhdr` or `titleps` in the main file, `notes.cls` or `color-env.sty` | `hf.class-native` | book default heads, nothing set by the zip |
| fonts | main preamble lines 6-15 load no font package | none needed | Computer Modern default |
| title page | MTH102_-_Real_analysis.tex:21-80 | `front.titlepage-env` | `titlepage` env: centred, small caps, title `\huge`, subtitle `\LARGE`, credit `\large`, `\vfill` between blocks |
| title-page rules | MTH102_-_Real_analysis.tex:33-34, 42-43 | `sp.rule` | `\rule{\textwidth}{1.6pt}` over `\rule{\textwidth}{0.4pt}` (and the reverse under the title) |
| title-page spacing | MTH102_-_Real_analysis.tex:27, 33, 36, 40, 42, 45, 53, 60, 64, 68, 75 | `sp.manual-space` | `\vspace*{\baselineskip}`, `\vspace*{-\baselineskip}`, `\vspace{0.75\baselineskip}`, `\vspace{3.2pt}`, `\vspace*{3\baselineskip}`, `\vfill` |
| title-page alignment | MTH102_-_Real_analysis.tex:23 | `sp.ragged` | `\centering` |
| title-page case and sizes | MTH102_-_Real_analysis.tex:25, 38, 51, 78 | `mark.kernel`, `font.size-commands` | `\scshape`; `\huge`, `\LARGE`, `\large` |
| contents | MTH102_-_Real_analysis.tex:81 | `toc.kernel` | `\tableofcontents`; no `\listoffigures` |
| sectioning | MTH102_-_Real_analysis.tex:83, 85, 545, 341 | `head.kernel` | `\chapter`, `\section`, `\subsection`, `\paragraph` at class defaults; headings carry no `\titleformat` |
| section-number prefix | notes.cls:15-20 | `head.kernel` | `\@seccntformat` hook prints `\S\thesection\quad`, `\S\thesubsection\quad`, `\S\thesubsubsection\quad`; other levels print `\the<level>\quad`; reducible, see Bespoke code |
| appendix | MTH102_-_Real_analysis.tex:15, 1716-1718 | `num.appendix` | `appendix` package options `toc,page`; `\appendix`, `\addappheadtotoc`, then `\chapter` |
| plain lists | MTH102_-_Real_analysis.tex:166-171, 649-653, 1720-1760 | `list.kernel` | `enumerate`, `itemize`, `description` with `\item [..]` |
| list labels | MTH102_-_Real_analysis.tex:11, 278, 421, 640, 664, 687, 1472 | `list.enumerate-pkg` | `[\bf a.]`, `[(i)]`, `[\bf (i)]`, `[a.]`, `[(i.)]` |
| display maths | MTH102_-_Real_analysis.tex:8, 130-132, 690-694, 840, 1084-1089, 1418-1420, 1725-1754 | `math.amsmath`, `math.amssymb` | `equation`, `equation*`, `gather*`, `align`, `aligned`, `cases`, `\underbrace`, `\overbrace`, `\substack`; `\mathbb`, `\mathcal`, `\blacksquare` |
| absolute-value macro | MTH102_-_Real_analysis.tex:8, 246, 323 (34 lines use `\abs`) | `math.physics` | `commath`, only `\abs` is used; considered as its own way, kept under the notation-helper line (see Lib changes) |
| theorem-like boxes (theorem, lemma, definition, corollary, proposition) | color-env.sty:24-144 | `thm.mdframed` | as written: `\usepackage[framemethod=TikZ]{mdframed}` (8); per kind `\mdfsetup{innertopmargin=10pt, linecolor=<c>, linewidth=2pt, topline=true, frametitleaboveskip=\dimexpr-\ht\strutbox\relax, frametitle=<TikZ node>}` then `\begin{mdframed}`; colours theorem `blue!20` (32, 41), lemma title `orange!20` with line `green!20` (56, 65), definition `red!25` (81, 90), corollary `yellow!20` (105, 114), proposition `green!25` (130, 139) |
| title tab of those boxes | color-env.sty:31-33, 37-39 (and the same node in each kind) | `thm.tcolorbox` | reduction of the node `\tikz ... \node[anchor=east,rectangle,fill=<c>]{\strut Theorem~\thetheo[:~name]}`: a filled title tab, i.e. `enhanced`, `attach boxed title to top left`, `colbacktitle=<c>`, `colframe=<c>`, `boxrule=2pt` |
| theorem numbering | color-env.sty:24-25, 48-49, 73-74, 97-98, 122-123 | `num.counters` | `\newcounter{theo}[section]`, `lem`, `cor`, `prop` the same; `def` resets at `subsection` (73); each printed `\arabic{chapter}.\arabic{section}.\arabic{<counter>}` |
| optional theorem name | color-env.sty:28-40 | `thm.tcolorbox` | `\ifstrempty{#1}` only chooses "Theorem N" or "Theorem N: name"; the optional box title does this natively |
| problem box | color-env.sty:16-20 | `box.mdframed`, `thm.amsthm`, `color.xcolor` | `framed` `shaded` with `\colorlet{shadecolor}{orange!12}` around `\newtheorem{prob}{Problem}` (plain style, global counter) |
| proof | color-env.sty:147-151; MTH102_-_Real_analysis.tex:16 | `thm.amsthm` | `proof` wrapped to give its heading `\bf \scshape \large`; `\renewcommand\qedsymbol{$\blacksquare$}` |
| thmtools | MTH102_-_Real_analysis.tex:9 | `thm.thmtools` | loaded, no `\declaretheorem` or `\listoftheorems` appears in the main file |
| colours | color-env.sty:6, 16 | `color.xcolor` | `\colorlet`, mixes `orange!12`, `blue!20`, `red!25` |
| figures | MTH102_-_Real_analysis.tex:17, 408-411, 438-446, 535-540, 831-836, 903-908 | `fig.graphicx` | `figure[h!]`/`[!h]`/`[hbt!]`, `\includegraphics[height=2in,width=3in]`, `[width=3in]`, `[width=\textwidth]`, `\graphicspath{{img/}}` |
| figure alignment | MTH102_-_Real_analysis.tex:409, 536, 832, 904, 1005 | `sp.manual-space`, `sp.ragged` | `\hfill ... \hspace*{\fill}`; `center` environment; `\centering` |
| side-by-side figures | MTH102_-_Real_analysis.tex:13, 440-445, 1006-1011 | `fig.subcaption` | `subfig` `\subfloat[sub-caption]{\includegraphics[width=2.5in]{..}}` with `\qquad` |
| captions | MTH102_-_Real_analysis.tex:410, 445, 538, 834, 906, 1011 | `cap.kernel` | `\caption`, no `caption` package |
| margin remarks | MTH102_-_Real_analysis.tex:14, 334, 473, 805 | `note.todonotes` | `todonotes[colorinlistoftodos,prependcaption]`; `\todo[color=white]{..}`, `\todo[color = white,shadow]{..}`; no `\listoftodos` |
| footnote | MTH102_-_Real_analysis.tex:1115 | `fn.kernel` | `\footnote[1]{..}` |
| cross references | MTH102_-_Real_analysis.tex:211, 216, 389, 476, 758, 1273 | `xref.kernel` | `\label`, `\ref`; theorem labels come from the `{label}` argument of the zip-local environments |
| bibliography | MTH102_-_Real_analysis.tex:51, 429, 529, 1595, 1764-1765 | `bib.bibtex-bst` | `\bibliographystyle{unsrt}`, `\bibliography{ref}`, `\cite`, `\nocite`; `ref.bib` is data, not read |
| language | MTH102_-_Real_analysis.tex:7 | `lang.babel` | `[english]` |
| framed formula | MTH102_-_Real_analysis.tex:103 | `box.fancybox` | `\framebox{..}` in maths |
| hanging paragraph | MTH102_-_Real_analysis.tex:150, 156, 161 | `sp.lengths` | `\hangindent=1.5cm` |
| text marks | MTH102_-_Real_analysis.tex:429, 513, 695, 861, 1119 | `mark.kernel` | `\bf`, `\textbf`, `\textit`, `\textsuperscript`, `\textsubscript` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `notes` | notes.cls:1-21 | yes | `\documentclass[a4paper,oneside]{book}`, `geometry[total={5in,9in}]`, `hyperref` with `\hypersetup{colorlinks=true,linkcolor=blue,filecolor=magenta,urlcolor=cyan}`, and the section format below |
| `\@seccntformat` redefinition with `\section@cntformat`, `\subsection@cntformat`, `\subsubsection@cntformat` | notes.cls:15-20 | yes | its whole effect is a fixed label table (a section sign before the number for three levels): `head.titlesec` `\titleformat{\section}{\normalfont\Large\bfseries}{\S\thesection}{1em}{}` and likewise for the two lower levels (or the same `head.kernel` hook in one `\makeatletter` block); the `\@ifundefined` test only selects between that table and the default |
| zip-local style `color-env` | color-env.sty:1-151 | yes | `xcolor`, `graphicx`, `mdframed`, `framed`, `amsthm` loads plus the rows below |
| counters `theo`, `lem`, `def`, `cor`, `prop` with `\renewcommand\the<counter>` | color-env.sty:24-25, 48-49, 73-74, 97-98, 122-123 | yes | `num.counters`: `\newcounter{c}[section]` (`[subsection]` for `def`) and `\renewcommand{\thec}{\arabic{chapter}.\arabic{section}.\arabic{c}}`; or `\newtcbtheorem[number within=section]` |
| environments `theorem`, `lemma`, `definition`, `corollary`, `proposition` with signature `[2][]` | color-env.sty:26-46, 50-70, 75-95, 99-119, 124-144 | yes | one boxed theorem per kind from `thm.tcolorbox` (or `thm.mdframed` `\newmdtheoremenv` with `linecolor`, `linewidth`, `topline`, `innertopmargin`); the emitter writes the name as the box title and `\label{key}` as the first item of the body instead of the mandatory second argument |
| `\ifstrempty{#1}` choosing the frame title | color-env.sty:28-40 | yes | only selects "Theorem N" against "Theorem N: name"; an optional box title is the declarative form of that choice |
| `\tikz ... \node[anchor=east,rectangle,fill=blue!20]{..}` in `frametitle` | color-env.sty:31-33, 37-39, 55-57, 61-63, 80-82, 86-88, 104-106, 110-112, 129-131, 135-137 | yes | a filled rectangle behind the title text is a coloured title tab, `tcolorbox` `attach boxed title to top left` with `colbacktitle`; there is no free drawing, so not `ART` |
| `problem` environment | color-env.sty:16-20 | yes | `\colorlet{shadecolor}{orange!12}`, `\newtheorem{prob}{Problem}`, body wrapped in `shaded` |
| `proof` redefinition using `\oldproof`/`\oldendproof` | color-env.sty:147-151 | yes | the wrapper only puts `\bf \scshape \large` in amsthm's optional heading argument; the emitter writes that argument per use. Whether `\oldproof` is bound to amsthm's `\proof` cannot be checked here: `\csname\string\proof\endcsname` (147) spells a name that contains a backslash |
| commented duplicate of the `proof` code | color-env.sty:156-160 | yes | dead code, nothing to print |
| body: `lemma` used without its label argument | MTH102_-_Real_analysis.tex:1691 | n/a | content slip: the mandatory `#2` of the zip-local `lemma` would take the next token; a plain emitter writes no such argument |
| body macros | MTH102_-_Real_analysis.tex (no `\newcommand`, `\def`, `\newenvironment` in the 1768 lines) | n/a | none |

## Content-opaque
- `png` images inside figure floats (MTH102_-_Real_analysis.tex:409, 441, 444, 537, 833, 905, 1007, 1010)
- `array` with `\left\{ ... \right\}` used as a displayed case list (MTH102_-_Real_analysis.tex:1031-1036), maths content
- no TikZ, `pgfplots` or `picture` environment in the main file

## Lib changes
- New ways proposed: none
- considered: `commath` (CTAN) as its own way; kept under `math.physics`, the lib's line for math notation helpers (`physics`, `braket`, `cancel`, `nccmath`, `empheq`), because only `\abs` is used and it is one load-only line.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
