yes

# 0843-peylix-bdic-report-template-latex: BDIC report template (Beijing-Dublin International College)

- Unverified: read from the source, not compiled.
- Source: Source/0843-peylix-bdic-report-template-latex/ (origin: https://codeload.github.com/peylix/bdic-report-template-latex/zip/refs/heads/main; licence: GPL-3.0 per manifest; README.md:6 says the institutional logos stay the property of their universities)
- Kind: report
- Lib: v6
- Engine: pdfLaTeX-compatible (release.yml:61 says compile with PDFLaTeX; no fontspec or unicode-math; biblatex uses the biber backend, cls:51)
- Look carried by: zip-local (report.cls is a wrapper over `article` that loads packages and sets every look; main.tex only defines data macros and picks which title/abstract variant to call)
- Class origin: zip-local
- Main file: main.tex (other samples: none; body text lives in src/abstract.tex, intro.tex, methodology.tex, code_impl.tex, conclusion.tex, all pulled in by `\input`)
- Read: main yes (main.tex and all five src files in full), zip-local classes and styles all (report.cls, 382 lines, in full)

## Verdict
The look comes from one zip-local `report.cls` that does `\LoadClassWithOptions{article}` (report.cls:3), `\RequirePackage`s published packages, and sets them by options and keys: geometry, fancyhdr, caption, enumitem, listings, tcolorbox, thmtools, biblatex. Every item it defines reduces to lib ways: the `\newtcolorbox` boxes and the abstract, the `\declaretheorem` + `\tcolorboxenvironment` theorems, and the `\lstdefinestyle`. The title-page macros (`\makenewtitlepage`, `\makecompacttitle`) use `\foreach`, two counters and `\ifthenelse`/`\ifdefined`, but they only choose "Author" or "Authors", print each name from a list, and skip optional fields. All of that depends on document data, so an emitter resolves it by inline expansion and writes a hand-laid `titlepage` with kernel commands. No output routine, box algorithm or layout computation is involved, and no tool outside TeX is needed beyond biber, which is the lib's `bib.biblatex-biber`. The only drawing in the sample is a demo TikZ tree in the body (content, not template identity); the logos are `\includegraphics` of shipped PDFs. The edge: if a reviewer counts data-driven `\foreach`/counter logic as irreducible, the answer would flip to `no` with a `BESPOKE/class` blocker at report.cls:261-382; I judge it reducible because the rubric's irreducible list is about layout behaviour and the lib's own precedent accepts inline expansion of macro tails.

## Blockers
none

## Class setting
- Class: `class.article` options: none passed. `\documentclass{report}` (main.tex:1) has no options and `\LoadClassWithOptions{article}` (report.cls:3) forwards them, so the defaults apply: 10pt, letterpaper, oneside. The zip's `report.cls` (report.cls:2 `\ProvidesClass{report}`) is a zip-local file that shadows the kernel `report` class by name; it is NOT `class.report` (no `\chapter`, the base is `article`). An emitter writes `\documentclass{article}` plus the preamble ways below.
- Class-native vocabulary used: none from a published class beyond `article` (`\section`, `\subsection`, `\tableofcontents`, `figure`, `titlepage`). Zip-local vocabulary the sample uses, all reduced below: `\makenewtitlepage` (main.tex:42), `monochromeabstract` (main.tex:73), `greenbox`/`bluebox`/`yellowbox` (methodology.tex:17-27), `theorem`/`proposition`/`principle` (methodology.tex:3-13).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | report.cls:3; main.tex:1 | `class.article` | no options; defaults 10pt, letterpaper |
| page geometry | report.cls:94-101 | `page.geometry` | textheight=9in, textwidth=6.5in, top=1in, headheight=12pt, headsep=25pt, footskip=30pt |
| header/footer | report.cls:105-115 | `hf.fancyhdr` | `\pagestyle{fancy}`; `\fancyhead[L]{\authorname}` ("Group 0", main.tex:16), `[C]{\coursecode}` ("COMP0000J", main.tex:26), `[R]` = `\paperdate` (`\today`, main.tex:27) wrapped in `\ifdefined`, which the emitter resolves; no `\fancyhf{}`, so the footer is fancy's default (unverified) |
| header width | report.cls:106-108 | `sp.lengths` | `\newlength\FHoffset`=0.1cm, `\addtolength\headwidth{2\FHoffset}` |
| plain page on compact title | report.cls:350 | `hf.pagestyle-kernel` | `\thispagestyle{plain}` (only in `\makecompacttitle`, not called by the sample); `\markboth{#1}{#1}` in the bib heading (report.cls:66) |
| line spacing | report.cls:102; main.tex:45-47 | `sp.setspace` | `\setstretch{1.2}` for the document; `spacing` environment {1.0} around the contents; `\setstretch{1.0}` in the title page (report.cls:292) |
| paragraph shape | report.cls:118-119 | `sp.lengths` | `\parskip`=1em, `\parindent`=0pt (title page group: `\parskip`=1pt, report.cls:281; compact title: 0pt, report.cls:348) |
| title page | report.cls:279-343; main.tex:42 | `front.titlepage-env` | `titlepage` + `\centering`; order: logos, college name `\Large\textsc`, rule, course code and report title `\huge\textbf{\uppercase}`, rule, project title `\LARGE\textit`, optional subsubtitle block, `Author(s)` heading and names, optional supervisors, date, `\vfill`; hand-laid, loops unrolled by the emitter |
| title page spacing | main.tex:5-11; report.cls:284,287,289,291,294,296,305,313,320,334,340 | `sp.manual-space` | `\vspace*{0.8cm}`, `\vspace{0.8cm}`, `{1.5cm}`, `{0.5cm}`, `{0cm}`, `{1.0cm}`, subsubtitle `{2cm}`/`{-2cm}` (report.cls:300,303), `{7cm}`, `{0.1cm}`, `{0.8cm}`, `\vfill`; the `\vspaceone`..`\vspaceseven` macros are length aliases |
| title page rules | main.tex:29; report.cls:290,295 | `sp.rule` | `\HRule{0.2pt}` = `\rule{\linewidth}{0.2pt}` |
| title page logos | report.cls:285-286 | `fig.graphicx` | `\includegraphics[width=0.1\textwidth]{images/UCD_Logo.pdf}`, `\hspace{0.5cm}`, `[width=0.15\textwidth]{images/BJUT_Logo.pdf}`; PDFs ship in images/ |
| title page type | report.cls:283,288,293,297,302,308 | `font.size-commands`, `mark.kernel`, `mark.case`, `sp.ragged` | `\Large` `\huge` `\LARGE` `\large`; `\textsc` `\textbf` `\textit`; `\uppercase`; `\centering` |
| compact title (class macro, unused by sample) | report.cls:346-382 | `sp.ragged`, `sp.manual-space`, `mark.kernel`, `font.size-commands` | `flushleft`, `\normalsize\textsc`, `\Large\textbf{\uppercase}`, `\large\textit`, vspaces 0.3/0.2/0.2/0.25/0.1cm, "Authors:" list joined by ", " |
| fonts: text | report.cls:8 | `font.lmodern` | `lmodern`, no options |
| input encoding | report.cls:6 | `font.fontenc-t1` | `inputenc` option `utf8`; no `fontenc` loaded |
| fonts: mono package | report.cls:9 | `font.mono` | `DejaVuSansMono` (CTAN package `dejavu`, LPPL 1.3; its page does not name the `.sty`, not in the zip) |
| fonts: tt default | report.cls:78 | `font.family-default` | `\renewcommand{\ttdefault}{lmtt}` |
| fonts: listing family | report.cls:254 | `font.nfss` | `\fontfamily{txtt}\selectfont\footnotesize`; this second `basicstyle` follows the first (report.cls:237), so the later value should win (unverified) |
| language | report.cls:7 | `lang.babel` | `english` |
| quotes | report.cls:10 | `lang.csquotes` | load-only |
| colour | report.cls:32, 129-138 | `color.xcolor` | `dvipsnames`; UCDGreen (0.5,0.71,0.31), UCDBlue (0,0.55,0.77), UCDYellow (0.95,0.76,0.18), backcolour, codegreen, codegray, codepurple, keywordcolor, bordercolor, linenumberbg (the last is unused) |
| hyperlinks | report.cls:29 | `meta.hyperref` | no options, no `\hypersetup` |
| bookmarks | report.cls:43 | `meta.bookmark` | load-only |
| abstract | main.tex:61,73-75; report.cls:161-177 | `box.tcolorbox`, `abs.kernel` | `\abstractname` set to "Abstract" (main.tex:61); `monochromeabstract` = `\newtcolorbox[auto counter, number within=section]`, `title={\bfseries \abstractname}`, `enhanced`, `coltitle=black`, `top=0.2in`, `bottom=0.15in`, `attach boxed title to top left={xshift=1.5em, yshift=-\tcboxedtitleheight/2}`, `boxed title style={size=small, colback=white, boxrule=0.2mm}`, `colback=white`, `colframe=black`, `boxrule=0.2mm`, `width=\textwidth`, `arc=4mm`, `auto outer arc`, `sharp corners=all`. The `colorfulabstract` variant (report.cls:143-159; commented at main.tex:69-71) adds `drop shadow={black!50!white}`, `colframe=black!50`, boxed title `colback=white!40!UCDGreen`; plain `abstract` is commented (main.tex:65-67) |
| contents | main.tex:45-47 | `toc.kernel` | `\tableofcontents`, default depth |
| page break | main.tex:49 | `pg.break` | `\newpage` |
| file inclusion | main.tex:74,78,81,84,87 | `struct.input` | `\input{src/...}` |
| section headings | report.cls:123; main.tex:77-87 | `head.kernel` | `\renewcommand{\section}{\@startsection{section}{1}{0pt}{10pt}{5pt}{\normalfont\Large\bfseries}}`: a call of the kernel's documented sectioning constructor with indent, beforeskip, afterskip and style, not a redefinition of its internals; titlesec's `\titleformat`/`\titlespacing*` is the printable alternative |
| subsection headings | report.cls:124; methodology.tex:1,15 | `head.kernel` | `\@startsection{subsection}{2}{0pt}{8pt}{3pt}{\normalfont\large\bfseries}`; deeper levels stay `article` |
| lists | report.cls:74-75 | `list.enumitem` | `\setlist[enumerate]` and `[itemize]`: `topsep=-0.5em, itemsep=0em` (the sample has no list) |
| theorem declarations | report.cls:14,217-227; methodology.tex:3-13 | `thm.thmtools`, `thm.amsthm` | `\declaretheoremstyle[name=Theorem]{thmsty}` and siblings `prosty`, `prcpsty` (`name=` is not a style key I know of in thmtools; effect unverified, the declared styles are otherwise default); `\declaretheorem[style=thmsty,numberwithin=section]{theorem}`; `proposition` and `principle` with `numberlike=theorem`; amsthm loaded at report.cls:13 |
| theorem boxes | report.cls:219,223,227 | `thm.tcolorbox` | `\tcolorboxenvironment{theorem}{colframe=UCDGreen}`, proposition `colframe=UCDBlue`, principle `colframe=UCDYellow` |
| note boxes | report.cls:180-214; methodology.tex:17-27 | `box.tcolorbox` | `\tcbset{base/.style={arc=0mm, bottomtitle=0.5mm, boxrule=0mm, colbacktitle=black!10!white, coltitle=black, fonttitle=\bfseries, left=2.5mm, leftrule=1mm, right=3.5mm, title={#1}, toptitle=0.75mm}}`; `greenbox`/`bluebox`/`yellowbox` set `colframe=UCDGreen/UCDBlue/UCDYellow` and take the title as argument 1; `subbox` (`colframe=black!30!white`) is unused; `tcolorbox` loaded with `most` (report.cls:34) |
| math packages | report.cls:13 | `math.amsmath`, `math.amssymb` | `amsmath, amssymb, amsfonts`; no equation in the sample |
| code listing | report.cls:231-257; code_impl.tex:3-14; intro.tex:1 | `code.listings` | style `elegantstyle`: `backgroundcolor=\color{backcolour}`, `commentstyle=\color{codegreen}\textit`, `keywordstyle=\color{keywordcolor}\bfseries`, `numberstyle=\tiny\color{codegray}`, `stringstyle=\color{codepurple}`, `breaklines=true`, `captionpos=b`, `keepspaces=true`, `numbers=left`, `numbersep=10pt`, `tabsize=4`, `frame=shadowbox`, `framerule=1pt`, `rulecolor=\color{bordercolor}`, `frameround=tttt`, `xleftmargin=10pt`, `xrightmargin=10pt`, `show*=false`; `\lstset{style=elegantstyle}`; body `lstlisting[language=Python, caption=Time Machine Demo]` and `\lstinline{SIDRAT}`; Python is built into listings, no pygments |
| figure | intro.tex:3-7 | `fig.graphicx`, `xref.kernel` | `figure[ht!]`, `\includegraphics[width=0.6\textwidth]{figures/placeholder.jpg}`, no `\centering`, `\label{fig:placeholder}` |
| captions | report.cls:82-90; intro.tex:5 | `cap.caption` | `justification=raggedright, singlelinecheck=false, font={small,sf}, labelfont=bf, labelsep=period, skip=10pt, format=plain` |
| bibliography | report.cls:50-70; main.tex:36,90; conclusion.tex:1 | `bib.biblatex-biber` | `backend=biber, style=numeric, sorting=nty, maxbibnames=99, maxcitenames=2, giveninits=true, doi=true, isbn=true, url=true, eprint=false`; `\defbibheading{bibliography}[\refname]{\section*{#1}\markboth{#1}{#1}}`; `\bibitemsep`=0.5\baselineskip; `\addbibresource{bibliography/references.bib}`; `\cite{Smith_2012}`; `\printbibliography` is commented out in the sample (main.tex:90) |
| inline marks | abstract.tex:1; conclusion.tex:1 | `mark.kernel` | `\textit`, `\textbf` |
| loaded, unused by the sample: floats | report.cls:18,22 | `fig.float`, `fig.subcaption` | `float`; `subfig` with `caption=false,font=footnotesize` |
| loaded, unused: tables | report.cls:19-21,38 | `tbl.tabularx`, `tbl.longtable`, `tbl.multirow`, `tbl.tabular` | `tabularx`, `longtable`, `multirow`, `array`; no table in the sample |
| loaded, unused: algorithm | report.cls:37 | `alg.algorithmicx` | `algorithmic` |
| loaded, unused: framed boxes | report.cls:33 | `box.mdframed` | `framed` |
| loaded, unused: filler text | report.cls:40 | `draft.todo` | `lipsum` |
| loaded: tikz | report.cls:23 | `art.tikz` | `tikz`; used only for content (see Content-opaque) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `report.cls` wrapper (shadows kernel `report`) | report.cls:1-3 | yes | `\documentclass{article}` and the preamble ways in the table; the name clash disappears |
| `\makenewtitlepage` | report.cls:279-343 | yes | inline expansion with the document's data: the `titlepage` of the table row, "Authors" or "Author" fixed by the emitter from the list length, one `name \par \vspace{0.1cm}` per name; supervisors and date blocks printed or dropped by the emitter; kernel and lib commands only |
| `\countnames`, `\countsupervisors`, counters `totalnames`, `totalsupervisors` | report.cls:261-276 | yes | the count is known at emit time; the plural label is static text |
| `\makecompacttitle` | report.cls:346-382 | yes | static `flushleft` block; `\newcounter{namecount}` inside the macro (report.cls:370) is a loop helper and disappears when the names are joined by ", " at emit time; unused by the sample |
| user data macros and spacing aliases | main.tex:5-11,16-32 | yes | aliases for lengths and strings, expanded inline; `\HRule` (main.tex:29) = `\rule{\linewidth}{#1}` |
| header conditional | report.cls:111-115 | yes | `\ifdefined\paperdate` is decided at emit time; header cell R = the date or empty |
| `\@startsection` section and subsection | report.cls:122-125 | yes | `head.kernel` as written, or titlesec `\titleformat`/`\titlespacing*` with the same numbers |
| `\newtcolorbox` abstracts and note boxes, `\tcbset{base/.style}` | report.cls:143-214 | yes | one `box.tcolorbox` declaration per environment with the keys listed, `base` expanded inline |
| theorem declarations and `\tcolorboxenvironment` | report.cls:217-227 | yes | `thm.thmtools` declarations plus `thm.tcolorbox` keys |
| `\lstdefinestyle{elegantstyle}`, `\lstset` | report.cls:231-257 | yes | `code.listings` keys as listed |
| `suffix`, `ifthen`, `pgffor` | report.cls:41,42,46 | yes | considered: `suffix` (CTAN macro helper, never called anywhere in the zip, no printed effect, so no component); `ifthen` and `pgffor` serve only the title-page macros above and disappear with them |

## Content-opaque
- TikZ binary tree with an arrow between two nodes: code_impl.tex:17-33 (a demo in the body, outside any float, `art.tikz`; it is example content, not the template's identity).
- Figure image figures/placeholder.jpg (intro.tex:4) and the logo PDFs (report.cls:285-286) are shipped assets, not drawings.

## Lib changes
- New ways proposed: none. Considered and not proposed: `suffix` (no printed effect, never called).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
