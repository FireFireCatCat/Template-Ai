no

# 0396-dzwaneveld-tudelft-report-thesis-templat: TU Delft Report/Thesis template (unofficial rewrite, `tudelft-report` class v1.7.1)

- Unverified: read from the source, not compiled.
- Source: Source/0396-dzwaneveld-tudelft-report-thesis-templat/ (origin: https://codeload.github.com/dzwaneveld/tudelft-report-thesis-template/zip/refs/heads/master; licence: not established in the manifest; the files themselves state CC BY-NC 4.0, tudelft-report.cls:5-6, README.md:27)
- Kind: report (the sample inputs the report title page; `frontmatter/title-thesis.tex` is an alternate MSc thesis title page, README.md:19)
- Lib: v4
- Engine: pdfLaTeX-compatible (the class branches on `\ifPDFTeX`, tudelft-report.cls:67-74); the TU Delft house style (Arial, Roboto Slab through `fontspec`) needs XeLaTeX or LuaLaTeX (tudelft-report.cls:75-86, README.md:9); `biblatex` with biber (README.md:9)
- Look carried by: zip-local (the whole look is in the zip-local class `tudelft-report.cls`, a `book` class plus published packages and a TikZ cover; the sample preamble adds `biblatex`, `parskip` and one `\setlist`)
- Class origin: zip-local (the file says it is a rewrite by Daan Zwaneveld of the TU Delft template, tudelft-report.cls:1-3, README.md:27 "Unofficial"; ctan.org/pkg/tudelft-report returned HTTP 404, so it is not on CTAN; not an official release)
- Main file: report.tex (other samples: none; `frontmatter/title-thesis.tex` is an unused alternate title page)
- Read: main yes, zip-local classes and styles all (one class file, 211 lines, read in full; every `.tex` file in `frontmatter/`, `mainmatter/`, `appendix/` and `report.bib` read in full)

## Verdict
No. Almost everything reduces: the class is `\LoadClass{book}` plus published packages with declarative settings (`geometry`, `titlesec`, `titletoc`, `fancyhdr`, `caption`, `listings`, `fontspec` or `newpx` fonts), and the body uses ordinary lists, tables, listings and `biblatex`. The block is the cover: `\makecover` is a TikZ `remember picture, overlay` composition (full-page image, rotated side text, logo, translucent title banner), which is template-defining artwork (`ART`), and the title page repeats the same mechanism for the logo. A partial reduction through `bg.eso-pic`, `box.tcolorbox` and `fig.rotating` was considered and not accepted (see Bespoke code); a wrong yes costs more.

## Blockers
- `ART/class` cover page `\makecover`: four TikZ nodes anchored at `current page` (image at `south`, text rotated 90 degrees at `west`, logo at `south west`, banner at `north` with `fill=black!85,opacity=0.6,text opacity=1`) (tudelft-report.cls:156-193)
- `ART/body` TU Delft logo placed by a TikZ `remember picture, overlay` node at `current page.south` on the title page (frontmatter/title-report.tex:61-65; same in frontmatter/title-thesis.tex:71-75)

No `EXTERNAL` blocker: `listings` (not `minted`) is used (tudelft-report.cls:199), and biber is the standard `biblatex` backend (README.md:9), which the lib holds as `bib.biblatex-biber`.

## Class setting
- Class: `class.book` options: `10pt,oneside` fixed by the zip-local class (tudelft-report.cls:19); every other option the document gives is passed to `book` (tudelft-report.cls:17-18); the sample gives none (report.tex:1). The sample's own class is the zip-local `tudelft-report`, which reduces to this.
- Class-native vocabulary used: `\frontmatter` (report.tex:18), `\mainmatter` (report.tex:46), `\appendix` (report.tex:68), `\chapter` and `\chapter*`, `titlepage` environment (frontmatter/title-report.tex:1), `\tableofcontents` (report.tex:36). Zip-local additions: `\subtitle`, `\subject`, `\affiliation`, `\coverimage`, `\covertable`, `\makecover` (tudelft-report.cls:54-58, 156).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | tudelft-report.cls:19 | `class.book` | 10pt, oneside |
| front/main/back matter, appendix letters | report.tex:18, 46, 68 | `class.book` | `\frontmatter` (roman), `\mainmatter` (arabic), `\appendix` |
| appendix | report.tex:68 | `num.appendix` | `\appendix` before the two appendix chapters |
| page geometry | tudelft-report.cls:61 | `page.geometry` | a4paper, hscale=0.75, vscale=0.8 |
| file inclusion | report.tex:32-34, 40, 48-54, 70-71 | `struct.input` | `\input{path}` per front, main and appendix file |
| font encoding (pdfLaTeX branch) | tudelft-report.cls:69 | `font.fontenc-t1` | T1 |
| main and math font (pdfLaTeX branch) | tudelft-report.cls:70-71 | `font.palatino` | `newpxtext` + `newpxmath` (the Palatino pair of the newtx bundle; `font.newtx` considered, it is the Times-like line) |
| title fonts (pdfLaTeX branch) | tudelft-report.cls:73-74 | `font.nfss` | `\fontfamily{RobotoSlab-TLF}`, `\fontseries{light}` (title style) and `{thin}` (large title style); no package loads the family |
| main and title fonts (XeLaTeX or LuaLaTeX branch) | tudelft-report.cls:77-85 | `font.fontspec` | `no-math`, `\setmainfont{Arial}`, `\setmathsf{Arial}`, `\setmathtt{Arial}`, `\newfontfamily` Roboto Slab Light and Roboto Slab Thin (fonts not shipped) |
| engine switch | tudelft-report.cls:50, 67-86 | `font.fontspec`, `font.nfss` | `iftex` `\ifPDFTeX`; the emitter writes the branch for its engine |
| font sizes | tudelft-report.cls:95-97, 102, 110, 180, 183, 187; frontmatter/title-report.tex:7, 12, 25 | `font.size-commands` | `\fontsize{96}{96}`, `\Huge`, `\Large`, `\large`, `\fontsize{50}{50}`, `\fontsize{45}{45}`, `\fontsize{20}{20}`... |
| microtypography | tudelft-report.cls:42 | `sp.microtype` | defaults |
| paragraph style | report.tex:8 | `sp.parskip-pkg` | defaults |
| colour | tudelft-report.cls:39; report.tex:28; tudelft-report.cls:203-206 | `color.xcolor` | `\definecolor{title}{HTML}{4884d6}`; `black!85`, `gray!10`, `red!75!black`, `green!40!black`, `blue!30!black` |
| chapter headings | tudelft-report.cls:93-98 | `head.titlesec` | `\titleformat{\chapter}[display]`, format `\flushright`, label `\fontsize{96}{96}\selectfont\largetitlestyle\thechapter`, sep 0pt, title `\Huge\titlestyle`; `\titlespacing*` `0pt,0pt,2\baselineskip` |
| section, subsection, subsubsection headings | tudelft-report.cls:101-122 | `head.titlesec` | `\titleformat` hang shape: format `\Large` / `\large` / none + `\titlestyle\bfseries`, label `\thesection.` (and `\thesubsection.`, `\thesubsubsection.`), sep 5pt; `\titlespacing*` `0pt`, before `\baselineskip` (`\bigskipamount` for subsubsection), after `0pt` |
| unnumbered chapters (Preface, Summary, Nomenclature) | frontmatter/preface.tex:1; frontmatter/summary.tex:1; frontmatter/nomenclature.tex:1 | `head.kernel` | `\chapter*{...}` |
| starred sections | frontmatter/nomenclature.tex:6, 17; mainmatter/chapter-2.tex:14, 24 | `head.kernel` | `\section*{...}` |
| table of contents entries for starred chapters | frontmatter/preface.tex:2; frontmatter/summary.tex:2; frontmatter/nomenclature.tex:2 | `toc.kernel` | `\addcontentsline{toc}{chapter}{...}` |
| table of contents | report.tex:36; tudelft-report.cls:125 | `toc.kernel`, `toc.titletoc` | `\tableofcontents`; `\dottedcontents{chapter}[1.5em]{\vspace{0.5\baselineskip}\bfseries}{1.5em}{0pt}` |
| list of figures, list of tables | report.tex:37-38 | `toc.kernel` | commented out, available |
| running head and foot | tudelft-report.cls:138-150 | `hf.fancyhdr` | oneside branch: `\fancyhf{}`, `\fancyhead[R]{\titlestyle\thepage}`, `\fancyhead[L]{\titlestyle\nouppercase{\rightmark}}`; `\pagestyle{fancy}` |
| plain pages (chapter openers) | tudelft-report.cls:132-135 | `hf.fancyhdr` | `\fancypagestyle{plain}`: empty fields, `\headrulewidth` 0pt, `\fancyfoot[C]{\titlestyle\thepage}` |
| twoside branch (not used by the sample) | tudelft-report.cls:138-143 | `hf.fancyhdr`, `pg.emptypage` | `\fancyhead[LE,RO]`, `[RE]` leftmark, `[LO]` rightmark; `emptypage` loaded |
| page style switches | tudelft-report.cls:159 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` on the cover |
| page break | tudelft-report.cls:192 | `pg.break` | `\newpage` after the cover |
| cover page | tudelft-report.cls:156-193; report.tex:21-30 | `art.tikz` (**ART**) | see Blockers; metadata `\subtitle` `\subject` `\affiliation` `\coverimage` (report.tex:22, 25-27) |
| cover metadata stores | tudelft-report.cls:54-58; report.tex:21-27 | `front.class-native`, `front.maketitle` | `\title`, `\author` kernel; `\subtitle`, `\subject`, `\affiliation`, `\coverimage` class setters |
| title page | frontmatter/title-report.tex:1-67 | `front.titlepage-env` | `titlepage`, `center`, `\bigskip`, `\vfill`, three `tabular` blocks, title at `\fontsize{45}{45}`, author at `\fontsize{25}{25}` (logo overlay is the second Blocker) |
| spacing on title page | frontmatter/title-report.tex:15-16, 20-21, 28-29, 38, 48-49 | `sp.manual-space` | `\bigskip`, `\vfill` |
| centred and right-aligned blocks | tudelft-report.cls:94, 180; frontmatter/preface.tex:6-11 | `sp.ragged` | `\flushright`, `\raggedright`, `center`, `flushright` |
| preface sign-off date | frontmatter/preface.tex:9 | `front.datetime` | `datetime` loaded without a format (tudelft-report.cls:51), `\monthname{}` and `\the\year` |
| tables (title page, appendix) | frontmatter/title-report.tex:33, 41, 52; appendix/appendix-b.tex:11-26 | `tbl.tabular` | `\setlength\extrarowheight{2pt}` (title page), `{4pt}` (appendix-b.tex:7), `\multicolumn` (frontmatter/title-thesis.tex:44), `p{15mm}p{10cm}` |
| fixed-width table | appendix/appendix-b.tex:11 | `tbl.tabularx` | `\begin{tabularx}{\textwidth}{lXX}` |
| table rules | frontmatter/title-report.tex:34; frontmatter/nomenclature.tex:9-14, 22-28; appendix/appendix-b.tex:12-25 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| long tables | frontmatter/nomenclature.tex:8-15, 19-29 | `tbl.longtable` | `p{2.5cm}p{8cm}`, `p{2.5cm}p{8cm}p{2.5cm}`, `\endhead` |
| multirow loaded | tudelft-report.cls:29 | `tbl.multirow` | loaded, `\multirow` not called by the sample |
| captions | tudelft-report.cls:33; appendix/appendix-b.tex:9 | `cap.caption`, `cap.kernel` | `labelfont=bf`, `justification=centering`, `footnotesize`; `\caption` |
| float | appendix/appendix-b.tex:6, 8 | `fig.float` | `table[htb]`, `\centering`; `float` loaded (tudelft-report.cls:32) |
| images | tudelft-report.cls:31, 166, 174; frontmatter/title-report.tex:63 | `fig.graphicx` | `\includegraphics[width=...]` (placed by the ART nodes) |
| sub-figures, PDF inclusion | tudelft-report.cls:34-35 | `fig.subcaption`, `pg.include-pdf` | loaded, not called by the sample |
| lists | mainmatter/chapter-2.tex:6-10 | `list.kernel` | `itemize` |
| list spacing | report.tex:9; tudelft-report.cls:48 | `list.enumitem` | `\setlist{itemsep=-2pt}` |
| text marks | mainmatter/chapter-2.tex:7-9; frontmatter/preface.tex:4, 7 | `mark.kernel` | `\textbf`, `\emph`, `\texttt`, `\itshape` |
| SI units | tudelft-report.cls:24; report.tex:10 | `mark.siunitx` | `\si{\degree}` inside the `\deg` alias |
| maths | tudelft-report.cls:22-23 | `math.mathtools`, `math.amssymb` | loaded; the sample has only inline `$V$`, `$\rho$`, `$^3$` (frontmatter/nomenclature.tex:23, 26) |
| code | tudelft-report.cls:199-211; appendix/appendix-a.tex:6-31 | `code.listings` | `basicstyle=\ttfamily\footnotesize`, `backgroundcolor=\color{gray!10}`, `keywordstyle=\color{red!75!black}`, `stringstyle=\color{green!40!black}`, `commentstyle=\color{blue!30!black}`, `numbers=left`, `numbersep=5pt`, `numberstyle=\tiny`, `breaklines=true`; `lstlisting[language=Python]` |
| bibliography | report.tex:4-5, 62; mainmatter/introduction.tex:4 | `bib.biblatex-biber` | `\usepackage{biblatex}`, `\addbibresource{report.bib}`, `\printbibliography[heading=bibintoc,title=References]`, `\cite` |
| bibliography URL breaks | report.tex:57-59 | `num.counters` | `\setcounter{biburlnumpenalty}{7000}`, `biburllcpenalty`, `biburlucpenalty` |
| hyperlinks and PDF metadata | tudelft-report.cls:37 | `meta.hyperref` | `pdfusetitle`, `hidelinks` |
| URLs | mainmatter/chapter-2.tex:12; frontmatter/title-thesis.tex:66 | `meta.url` | `\url{...}` (through `hyperref`) |
| cross-references | tudelft-report.cls:38; mainmatter/introduction.tex:2; appendix/appendix-b.tex:10 | `xref.cleveref`, `xref.kernel` | `noabbrev`; `\label`; the sample prints no `\ref` or `\cref` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `tudelft-report` | tudelft-report.cls:1-211 | yes, except the cover | `class.book` `10pt,oneside` plus the packages and settings in the map above |
| `\subtitle` `\subject` `\affiliation` `\coverimage` `\covertable` | tudelft-report.cls:54-58 | yes | stores of strings; the emitter writes each value where it is printed |
| `\titlestyle`, `\largetitlestyle` | tudelft-report.cls:73-74, 84-85 | yes | aliases of a font switch: `font.nfss` (`\fontfamily`, `\fontseries`) or `font.fontspec` (`\newfontfamily`), expanded inline |
| `\ifPDFTeX ... \else ... \fi` | tudelft-report.cls:67-86 | yes | compile-time engine choice; emit the branch for the target engine (both branches are lib ways) |
| `\if@twoside` branch | tudelft-report.cls:138-148 | yes | follows the class option; the sample is oneside, so only the `\fancyhead[R]`/`[L]` lines are emitted |
| `\ifdefvoid{\@subtitle}{}{...}` etc. | tudelft-report.cls:170, 184-185, 188; frontmatter/title-report.tex:12 | yes | decided when emitting, since the field is known; the ones in `\makecover` stay inside the ART block |
| `\makeatletter ... \@title \@author \@subtitle` | frontmatter/title-report.tex:6-26; frontmatter/preface.tex:7-10 | yes | read the stored title, author, subtitle; the emitter substitutes the text |
| `\renewcommand{\deg}{\si{\degree}\xspace}` | report.tex:10 | yes | alias; expand inline (`mark.siunitx`); `xspace` is a macro-body helper, rejected as a way in the v4 change log, and reduces by inline expansion |
| `\lstset{...}`, `\geometry{...}`, `\titleformat`, `\titlespacing*`, `\fancypagestyle`, `\dottedcontents` | tudelft-report.cls:201-211, 61, 93-122, 132-150, 125 | yes | declarative calls of published packages (`code.listings`, `page.geometry`, `head.titlesec`, `hf.fancyhdr`, `toc.titletoc`) |
| `\makecover` | tudelft-report.cls:156-193 | **no (ART/class)** | considered: `bg.eso-pic` `\put` for the full-page image and the logo, `box.tcolorbox` with `colback=black!85,opacityback=0.6` for the banner, `fig.rotating` for the side text, `\raisebox{-\height}` for the unknown banner height. Not accepted: it re-lays the cover by hand from TikZ page anchors (`above right`, `below right=40mm and 3mm`, rotation about an anchor, `opacity` and `text opacity`), the lib marks positioned overlays that draw the template's identity as ART (`bg.tikzpagenodes`), and the equivalence cannot be shown without compiling |
| title-page logo overlay | frontmatter/title-report.tex:61-65 | no (ART/body) | one image centred 10mm above the page foot; the nearest lib ways are `pg.textpos` (`textblock*` with a reference point) and `bg.eso-pic`; not claimed, for the reason above |

## Content-opaque
none (the Python listing in appendix/appendix-a.tex:6-31 is `code.listings` content; the images `figures/cover.jpg`, `figures/logo-white.pdf`, `figures/logo-black.pdf` are shipped assets, and the Arial and Roboto Slab fonts of the XeLaTeX branch are not shipped, so a build would have to supply them)

## Lib changes
- New ways proposed: none. Considered and not proposed: `xspace` (rejected in the v4 log), `pg.textpos` and `bg.eso-pic` (already in the lib, used only as the candidate reduction of the title-page logo).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
