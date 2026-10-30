no

# 0622-xelatex-guide-book: The XeLaTeX Guide (Wander's xelatex-guide-book starter)

- Unverified: read from the source, not compiled.
- Source: Source/0622-xelatex-guide-book/ (origin: https://latextemplates.com/downloads/xelatex-guide-book.zip, packaged from https://github.com/a358003542/xelatex-guide-book per ATTRIBUTION.txt:4; licence: CC-BY-4.0)
- Kind: book
- Lib: v5
- Engine: needs XeLaTeX (`fontspec` mybook.sty:89, `xeCJKfntef` mybook.sty:161, `\xeCJKsetup` mybookcover.sty:24)
- Look carried by: zip-local (the whole look is in `mybook.sty` and `mybookcover.sty` over the kernel `book` class; main.tex only loads them and `natbib`)
- Class origin: tex-distribution-unbundled (kernel `book`, not in the zip; its source was not read). The two `.sty` files are zip-local: `mybook` and `mybookcover` are not CTAN or TeX Live packages (no ctan.org read made; they are the author's own config files, `\ProvidesPackage` at mybook.sty:3 and mybookcover.sty:3).
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (main.tex 73 lines, mybook.sty 276 lines, mybookcover.sty 89 lines, references.bib 7 lines, ATTRIBUTION.txt)

## Verdict
No. Most of the look reduces to published ways (`book`, `geometry`, `fontspec`, `fancyhdr`, `titlesec`, `tocloft`, `hyperref`, `mdframed`, `fancyvrb`, `natbib`), but `mybook.sty` carries three constructs no lib way can express: footnote markers drawn as TikZ circled numbers, a rewritten kernel `\@makefntext`, and a `\numberline` rebuilt from `tocloft` internals (the last is printed in the sample's contents page). The `minted` and `scripts` options are not selected by the sample, so they are noted but are not blockers.

## Blockers
- `ART/class` footnote number drawn as a TikZ circled node and used as `\thefootnote`: `\circled` `\node[shape=circle,draw,inner sep=0.4pt,minimum size=4pt]` (mybook.sty:217-219), `\circledarabic` (mybook.sty:221), `\renewcommand*{\thefootnote}` (mybook.sty:223); the sample has no `\footnote`, but the style the sample loads defines it.
- `BESPOKE/class` kernel footnote-text hook rewritten: `\renewcommand\@makefntext[1]{\vspace{5pt}\noindent\makebox[20pt][c]{\fontsize{10pt}{12pt}\@thefnmark}\fontsize{10pt}{12pt}\selectfont #1}` (mybook.sty:225-227); `fn.footmisc` (`hang`, `\footnotemargin`) does not carry the 5pt skip, the centred mark box and the 10/12pt face.
- `BESPOKE/class` `\renewcommand{\numberline}[1]{\@cftbsnum #1\@cftasnum~\@cftasnumb}` (mybook.sty:152): rebuilds the contents-entry number from `tocloft` hook macros and a tie, the comment says "dynamic adjust"; no `toc.tocloft` parameter gives a natural-width number (`\cft..numwidth` are fixed lengths); active in the sample (`\tableofcontents`, main.tex:23). `tocloft` source was not read.
- `BESPOKE/class` `\renewcommand{\uwave}{\bgroup \markoverwith{\lower4.5\p@\hbox{\sixly \char58}}\ULon}` (mybook.sty:168-169): patches `ulem`'s wave with its internal font `\sixly` and a changed depth; no `mark.ulem` parameter for it; not called by the sample.

## Class setting
- Class: `class.book` options: `12pt,oneside` (main.tex:1)
- Class-native vocabulary used: `\frontmatter` (main.tex:16), `\mainmatter` (main.tex:25), `\chapter` and `\chapter*` (main.tex:18, 27), `\section` (main.tex:29), `\tableofcontents` (main.tex:23), the `titlepage` environment (inside zip-local macros, mybookcover.sty:23, 46, 79), and the chapter-level `\bibliography` heading of `book` (main.tex:71).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.book` | 12pt, oneside |
| paper and size options | main.tex:1 | `page.class-options` | `12pt`, `oneside` (paper `a4paper` comes from geometry) |
| page geometry | mybook.sty:67-78 | `page.geometry` | a4paper, bindingoffset=0mm, top=35mm, bottom=30mm, inner=30mm, outer=30mm, headheight=10mm, headsep=15mm, footskip=15mm, marginparsep=0pt, marginparwidth=0em, includemp=false |
| temporary geometry for covers | mybookcover.sty:25, 41, 48, 75, 80-81, 85 | `page.geometry` | `\newgeometry{left=1cm,right=1cm,top=1cm,bottom=1cm}`, `\newgeometry{left=6cm}`, zero margins; `\restoregeometry` |
| line spacing | mybook.sty:38 | `sp.linespread` | `\linespread{1.5}` |
| line-break slack | mybook.sty:41 | `sp.lengths` | `\emergencystretch=3em` |
| paragraph skip and indent | mybook.sty:61-62 | `sp.lengths` | `\parskip=1.6ex plus 0.2ex minus 0.2ex`; `\parindent=\textpt * \real{2}` with `\textpt`=12pt (mybook.sty:32-33), so 24pt (`calc` loaded at mybook.sty:36 is only the arithmetic) |
| indent first paragraph | mybook.sty:63 | `sp.indentfirst` | package, no options |
| extra size switches | mybook.sty:36 | `font.size-commands` | `moresize` (`\HUGE`, `\ssmall`), same type as `\small`..`\Huge`; the sample uses none |
| text, sans, mono families | mybook.sty:89, 91-93 | `font.fontspec` | `\setmainfont[Mapping=tex-text]{DejaVu Serif}`, `\setsansfont[...]{DejaVu Sans}`, `\setmonofont[...]{DejaVu Sans Mono}`; CJK font calls were removed (mybook.sty:96-101) |
| maths packages | mybook.sty:85-86 | `math.amsmath`, `math.amssymb` | `amssymb`, `amsmath`; `stmaryrd` (a maths-symbol package, same type as `amssymb`; no symbol from it is used) |
| inline maths in display style | mybook.sty:87 | `math.everymath` | `\everymath{\displaystyle}` |
| colour | mybook.sty:8, 81 | `color.xcolor` | options `svgnames,table` passed, then `\RequirePackage{xcolor}` |
| table colour option | mybook.sty:8 | `tbl.colortbl` | `table` option of xcolor (no coloured row or cell in the sample) |
| running head and foot | mybook.sty:105-106, 124-129, 132 | `hf.fancyhdr` | `\fancypagestyle{plain}`: `\fancyhf{}`, `\headrulewidth=0pt`, `\footrulewidth=0pt`, `\fancyhf[HR]{\ttfamily \footnotesize \rightmark}`, `\fancyhf[FR]{\thepage}`, then `\pagestyle{plain}` (the earlier `\pagestyle{fancy}` is overridden) |
| header marks | mybook.sty:111-114 | `hf.fancyhdr` | `\sectionmark` and `\chaptermark` redefined to `\markright{Section~\arabic{section}~~#1}` and `\markboth{Chapter~\arabic{chapter}~~#1}{}` |
| header option branch (unselected) | mybook.sty:116-122 | `hf.fancyhdr` | `headchapter` option would use `\leftmark`; the sample selects none, so mybook.sty:124-129 applies |
| headings | mybook.sty:136, 138-146 | `head.titlesec` | `\titleformat` with empty label and 0em sep: part `\huge\sffamily`, chapter `\LARGE\sffamily`, section `\Large\sffamily`, subsection `\large\sffamily`, subsubsection `\normalsize\sffamily` |
| contents list | main.tex:23; mybook.sty:151 | `toc.kernel`, `toc.tocloft` | `\tableofcontents`; `tocloft` loaded without options |
| contents number box | mybook.sty:152 | none (blocker) | see Blockers |
| unnumbered chapter in contents | mybook.sty:50-53; main.tex:17-18 | `toc.kernel`, `pg.break` | `\addchtoc{Preface}` = `\cleardoublepage \phantomsection \addcontentsline{toc}{chapter}{#1}`, then `\chapter*{Preface}` |
| hyperlinks | mybook.sty:7, 156, 158 | `meta.hyperref` | options `unicode, colorlinks=true, linkcolor=blue, citecolor=blue`; `\phantomsection` |
| emphasis | mybook.sty:163-164 | `mark.kernel`, `color.xcolor` | `\emph` redefined to `\textcolor{blue}{\textbf{#1}}` |
| underline and CJK emphasis | mybook.sty:161, 166 | `lang.cjk`, `mark.ulem` | `xeCJKfntef` (loads `xeCJK`); `ulem` with `normalem` |
| CJK glue in title pages | mybookcover.sty:24, 47 | `lang.cjk` | `\xeCJKsetup{CJKecglue={\hskip 0pt plus 0.08\baselineskip}}` |
| date format | mybookcover.sty:16, 18 | `front.datetime` | `\today` redefined as `\number\year{}年\number\month{}月\number\day{}日`; the sample sets no `\date`, so `\@date`=`\today` is printed |
| title block fields | main.tex:7-10; mybookcover.sty:11-15, 18-20 | `front.maketitle` | `\title`, `\author`, `\date` redefined as plain `\def`; new fields `\subtitle`, `\version`; defaults warn when missing |
| title page (used) | main.tex:14; mybookcover.sty:22-42 | `front.titlepage-env`, `sp.manual-space`, `font.size-commands`, `mark.kernel` | `titlepage` + `center`; `\vspace*{120pt}`, title `\fontsize{80pt}{40pt}\sffamily`, `\vspace{40pt}`, subtitle 40/20pt sans, `\vspace{200pt}`, author 40/20pt sans, `\vspace{150pt}`, date and version 30/20pt `\ttfamily` |
| title page A (unused) | mybookcover.sty:45-76 | `front.titlepage-env`, `sp.rule`, `color.xcolor`, `sp.setspace`, `fig.adjustbox` | `\newgeometry{left=6cm}`, `\color[HTML]{5F5F5F}`, `\rule{1.3\textwidth}{4pt}` in colour 435488 inside `\makebox[0pt][l]`, `\setstretch{1.4}`, `\vfill`, `\resizebox{0.95\textwidth}{!}{...}` |
| full-page cover image (unused) | mybookcover.sty:78-86 | `bg.background` | zero-margin `\newgeometry`, one image at `current page.center` scaled to `\paperwidth` by `\paperheight`; the image is content, so no ART; literal form is an `art.tikz` overlay node |
| flyleaf page (unused) | mybook.sty:43-47 | `front.titlepage-env`, `sp.manual-space`, `font.size-commands` | `\flypage[80pt][40pt]{text}`: `titlepage`, `center`, `\vspace*{\stretch{1}}` twice, `\fontsize{#1}{#2}\sffamily` |
| title page spacing package | mybookcover.sty:5 | `sp.setspace` | `\RequirePackage{setspace}` |
| front and main matter | main.tex:16, 25 | `class.book` | `\frontmatter`, `\mainmatter` |
| sectioning in the sample | main.tex:27, 29, 51, 57, 59, 65 | `head.titlesec` | `\chapter`, `\section` (look from mybook.sty:138-146) |
| figure numbering | mybook.sty:177 | `num.counters` | `\thefigure` = `\arabic{chapter}-\arabic{figure}` |
| figure float | mybook.sty:172-175, 179 | `fig.graphicx`, `fig.wrapfig`, `fig.float` | `graphicx`, `wrapfig`, `float`; `\graphicspath{{figures/}}`; `\floatplacement{figure}{H}` |
| figure environments (unused) | mybook.sty:181-191 | `fig.float`, `fig.graphicx`, `sp.ragged` | `fig[scale]{file}`: `figure[H]`, `\centering`, `\includegraphics[scale=#1,keepaspectratio]`; `linefig`: `width=#1\linewidth,totalheight=0.95\textheight,keepaspectratio` |
| table | main.tex:36-49; mybook.sty:195 | `tbl.tabular`, `tbl.booktabs`, `fig.float` | `table[h]`, `\centering`, `tabular{ll}`, `\toprule \midrule \bottomrule` |
| table numbering, spacing, placement | mybook.sty:197, 199, 201 | `num.counters`, `tbl.tabular`, `fig.float` | `\thetable` = `\arabic{chapter}-\arabic{table}`; `\arraystretch=1.5`; `\floatplacement{table}{H}` |
| caption and label | main.tex:47-48 | `cap.kernel`, `xref.kernel` | `\caption` below the tabular, `\label{tab:families}`; `\ref` at main.tex:33 |
| framed quotation box (unused) | mybook.sty:205-211 | `box.mdframed` | `framed`, `mdframed`; `\mdfsetup{frametitlealignment=\center}`; `\newmdenv[frametitlebackgroundcolor=gray!20, linewidth=1pt, frametitlerulewidth=1pt, frametitlerule=true]{bookref}` |
| footnote mark (blocker) | mybook.sty:215-223 | `art.tikz` (ART), `num.counters` | `\tikz` circled node as `\thefootnote`; `num.counters` for the `\renewcommand*{\thefootnote}` |
| footnote text (blocker) | mybook.sty:225-227 | none (blocker) | see Blockers |
| footnote separation | mybook.sty:230 | `sp.lengths` | `\skip\footins=20pt plus 10pt` |
| verbatim and code | mybook.sty:233-234; main.tex:42-44, 61 | `code.verbatim` | `fancyvrb`, `\fvset{frame=lines,tabsize=4,baselinestretch=1.8,fontsize=\footnotesize}`; `\verb` |
| minted option (unselected) | mybook.sty:237-241 | `code.minted` | `\RequirePackage{minted}`, `\setminted{frame=lines, tabsize=4, framesep=10pt, fontsize=\footnotesize}`; **EXTERNAL** only when option `minted` is given |
| code file helpers (unselected) | mybook.sty:243-263 | `code.minted`, `code.verbatim` | `\showCode` (`\inputminted`), `\showCodeOut` (`\VerbatimInput`), `\showCodeAndOut`; only under option `scripts` |
| verse environments (unused) | mybook.sty:267-275 | `quote.kernel`, `sp.ragged`, `font.size-commands`, `sp.manual-space` | `shici`: `verse` + `\centering\large\hspace{12pt}`; `lshici`: `verse` + `\raggedright\large\hspace{12pt}` |
| horizontal rule command (unused) | mybook.sty:277 | `sp.rule` | `\makehline` = `\par\noindent\hrule` |
| bibliography | main.tex:5, 33, 63, 70-71; references.bib:1-7 | `bib.natbib`, `bib.bibtex-bst` | `natbib` with no options, `\citep`, `\bibliographystyle{plainnat}`, `\bibliography{references}` |
| inline code font | main.tex:20, 32, 47, 53, 68 | `mark.kernel` | `\texttt` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option switches `\newif\if@minted`, `\if@scripts`, `\if@headchapter`, `\DeclareOption` x3, `\DeclareOption*`, `\ProcessOptions` | mybook.sty:10-28 | yes | the sample passes no option (main.tex:3), so all three are false and an emitter prints only the resolved branch (mybook.sty:124-129); the `minted` branch would be `code.minted` (EXTERNAL) if selected |
| `\textpt` length | mybook.sty:32-33, 62 | yes | inline `\parindent=24pt` (`sp.lengths`) |
| `\flypage` | mybook.sty:43-47 | yes | see Component map (`front.titlepage-env`, `sp.manual-space`, `font.size-commands`) |
| `\addchtoc`, `\addsectoc`, `\hlabel` | mybook.sty:50-58, 158 | yes | `\cleardoublepage`, `\phantomsection`, `\addcontentsline`, `\label` as kernel and `hyperref` commands |
| `\sectionmark`, `\chaptermark`, plain page style | mybook.sty:111-130 | yes | `hf.fancyhdr` with `\markboth` and `\markright` |
| `\numberline` | mybook.sty:152 | no | uses `tocloft` internals `\@cftbsnum \@cftasnum \@cftasnumb`; BESPOKE/class |
| `\emph` | mybook.sty:163-164 | yes | alias of `\textcolor{blue}{\textbf{..}}` |
| `\uwave` | mybook.sty:168-169 | no | `ulem` internals `\markoverwith`, `\ULon`, `\sixly`, `\char58`, `\p@`; BESPOKE/class |
| `fig`, `linefig` | mybook.sty:181-191 | yes | environment aliases over `figure[H]`, `\centering`, `\includegraphics` |
| `bookref` | mybook.sty:210-211 | yes | `\newmdenv` with `mdframed` keys |
| `\circled`, `\circledarabic`, `\thefootnote` | mybook.sty:217-223 | no | TikZ node as footnote mark; ART/class |
| `\@makefntext` | mybook.sty:225-227 | no | kernel internal rewritten; BESPOKE/class |
| `\showCode`, `\showCodeOut`, `\showCodeAndOut` | mybook.sty:244-262 | yes (unselected) | `\inputminted`, `\VerbatimInput` over `\IfFileExists`; needs `minted` (EXTERNAL) when selected |
| `shici`, `lshici`, `\makehline` | mybook.sty:267-277 | yes | environment and macro aliases over `verse`, `\centering`, `\hrule` |
| `\title \author \date \subtitle \version \today` and defaults | mybookcover.sty:11-20 | yes | plain field macros; `\today` as a Chinese date format (`front.datetime`); the "No \subtitle given" defaults only warn |
| `\makemytitle`, `\makemytitleA`, `\bookcover` | mybookcover.sty:22-86 | yes | see Component map; fields inlined as content |

## Content-opaque
none (the sample has no figure artwork; its only float is a plain table, main.tex:36-49)

## Lib changes
- New ways proposed: `math.everymath` TeX primitive `\everymath` set to a math-style switch (`\displaystyle`, `\textstyle`, `\scriptstyle`, `\scriptscriptstyle`), engine pdf. W1: a TeX primitive with a kernel style switch, documented in The TeXbook; W2: the value is one switch from that closed list (any other token list would be bespoke); W3: serves any document that wants inline maths in display style, not one document; W4: one preamble line `\everymath{\displaystyle}` (mybook.sty:87). Grep of the lib for `everymath` and `displaystyle` found no home; `math.kernel` is display environments and numbering, `sp.lengths` raw lengths.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Considered, not proposed: `moresize` into `font.size-commands`, `stmaryrd` into `math.amssymb`, `calc` inlined into `sp.lengths`, `xeCJKfntef` into `lang.cjk`.

## Notes
- No text addressed to an AI was found in the zip.
- Compile risks, recorded only (nothing was compiled): `\today` prints the CJK characters 年 月 日 while no CJK font is set (mybook.sty:96-101 says the `\setCJKmainfont` calls were dropped); the `figures/` directory is not shipped (no `\includegraphics` in the sample); the DejaVu fonts are assumed installed (main.tex:54-55).
