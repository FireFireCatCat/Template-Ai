no

# 0861-tu-delft-light-assignment: TU Delft Light Assignment (tudelft-light/tud-report)

- Unverified: read from the source, not compiled.
- Source: Source/0861-tu-delft-light-assignment/ (origin: https://latextemplates.com/downloads/tudelft-assignment.zip, which README.md:109-111 traces to the GitHub repo skilkis/tudelft-light, vendored and modified; licence: MPL-2.0)
- Kind: assignment
- Lib: v6
- Engine: needs XeLaTeX (`\RequireXeTeX` in tudelft-light/tud-report.cls:46, `fontspec` families loaded by file path in tudelft-light/tud-style.sty:50-70)
- Look carried by: zip-local (the look is in tudelft-light/tud-report.cls and the tud-*.sty files; main.tex adds only metadata fields and the `\makecover` call)
- Class origin: zip-local
- Main file: main.tex (other samples: examples/latex_elements.tex, examples/listing.tex, examples/abstract.tex, all pulled in by main.tex:8,22,26)
- Read: main yes, zip-local classes and styles all

## Verdict
no. The class is zip-local, not published: ctan.org/pkg/tudelft-light and ctan.org/pkg/tudelft-report are both 404, and README.md:13-14 says the vendored copy is modified. Most of its code reduces to lib ways (fancyhdr, titlesec, geometry, enumitem, cleveref, nomencl, listings), but two things do not. The `\makecover` outer cover page is a TikZ page of three pgf layers, a translucent header band fitted around the text nodes, a page-size background image and a logo, so it is template-defining artwork (`ART`). The `\cleardoublepage` redefinition prints "This page intentionally left blank." under hand-written conditionals, which no lib way expresses (`BESPOKE`).

## Blockers
- `ART/class` outer cover page `\makecover`: tikzpicture with layers `background`, `assets`, `main`, nodes title/subtitle/date, a `fit` node `header_fill` with `fill opacity`, a full-page image node and a logo node (tudelft-light/tud-cover.sty:171-266, styles at :76-130; called at main.tex:11)
- `BESPOKE/class` `\cleardoublepage` redefined to print "This page intentionally left blank." on skipped even pages, with `\ifodd\c@page`, `\if@twoside`, `\if@titlepage`, `\if@twocolumn` branches choosing page style and content (tudelft-light/tud-report.cls:212-247; `\@titlepagetrue/false` are set in tud-cover.sty:173,265 and tud-title.sty:90,141)

## Class setting
- Class: `class.report` (loaded by the zip-local wrapper at tudelft-light/tud-report.cls:62) options: 11pt, a4paper, twoside, openright, reqno (main.tex:1; unknown keys are forwarded to report by `\DeclareDefaultOption` at tud-report.cls:60); the wrapper's own boolean option `fancyheader` (tud-report.cls:57)
- Class-native vocabulary used: `\chapter` `\section` (main.tex via examples/latex_elements.tex:1,8), `\tableofcontents` `\listoffigures` `\listoftables` (main.tex:16-18), `\bibliography` (main.tex:24). The zip-local vocabulary (`\makecover`, `\subtitle`, `\course`, `\supervisor`, `\abstract{}`, `\frontmatter`, `\mainmatter`, `questions`) is bespoke, not class-native of a published class.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1; tudelft-light/tud-report.cls:62 | `class.report` | 11pt, a4paper, twoside, openright, reqno |
| paper and size options | main.tex:1 | `page.class-options` | a4paper, 11pt, twoside |
| page geometry | tudelft-light/tud-report.cls:118-128 | `page.geometry` | margin=6pc; twoside branch: inner=6pc+1pc, outer=6pc-1pc; headheight=14pt (`\if@twoside` is resolved at emit, twoside is given) |
| paragraph indent | tudelft-light/tud-report.cls:139, :69 | `sp.lengths` | `\parindent`=0cm; `calc` loaded (load-only) |
| running header | tudelft-light/tud-report.cls:91-92, 253-260 | `hf.fancyhdr` | `\fancypagestyle{fancytruncated}`: `\fancyhead[R]{\itshape\small\truncate{0.47\textwidth}\leftmark}`, `\fancyhead[L]{...\rightmark}`; selected when `fancyheader` (main.tex:1) |
| header field truncation | tudelft-light/tud-report.cls:92, 254-255 | `sp.truncate` | `[fit,breakall]`, `\truncate{0.47\textwidth}` |
| page styles per part | tudelft-light/tud-report.cls:152-159, 171; tud-cover.sty:181; tud-title.sty:94 | `hf.pagestyle-kernel` | `plain` in frontmatter, `fancytruncated` or `plain` in mainmatter, `\thispagestyle{empty}` on cover and title page |
| page numbering | tudelft-light/tud-report.cls:170, 183; examples/latex_elements.tex:2 | `pgnum.pagenumbering` | roman in frontmatter, arabic in mainmatter |
| PDF page labels | tudelft-light/tud-cover.sty:180; tud-title.sty:93; tud-report.cls:97 | `num.counters` | `\renewcommand{\thepage}{Cover \Roman{page}}`, `{Title \Roman{page}}`, restored afterwards; `pdfpagelabels=true` |
| front/main matter switch | tudelft-light/tud-report.cls:147-210; main.tex:15,21 | `class.book` | reduction target: native `\frontmatter` `\mainmatter` (see Bespoke code) |
| chapter heading | tudelft-light/tud-report.cls:131-137 | `head.titlesec` | `\titlespacing*{\chapter}{0pt}{-25pt}{10pt}`; `\titleformat{\chapter}[hang]{\Huge\bfseries}{\thechapter\hsp\textcolor{gray75}\hsp}{10pt}{\Huge\bfseries}` |
| section headings | examples/latex_elements.tex:8,48,82,131 | `head.kernel` | report defaults (no titlesec rule for sections) |
| contents title | tudelft-light/tud-report.cls:144 | `toc.kernel` | `\contentsname` = Table of Contents |
| toc entries for lists | tudelft-light/tud-report.cls:68 | `toc.etoc` | `tocbibind[nottoc]` |
| contents and lists | main.tex:16-18 | `toc.kernel` | `\tableofcontents` `\listoffigures` `\listoftables` |
| appendix | tudelft-light/tud-report.cls:96; main.tex:25-27 | `num.appendix` | `appendix[titletoc]`, `appendices` environment |
| footnotes | tudelft-light/tud-report.cls:93, 263 | `fn.footmisc` | `[symbol]`, then `\renewcommand{\thefootnote}{\roman{footnote}}` (`num.counters`) |
| footnotes in tables | tudelft-light/tud-report.cls:100 | `fn.bigfoot` | `tablefootnote`, load-only, `\tablefootnote` is never called; considered: tablefootnote as its own way, not proposed (same effect type as `footnotehyper`; its CTAN page was not read) |
| colours | tudelft-light/tud-style.sty:22-36; tud-report.cls:132 | `color.xcolor` | 15 `\definecolor{tudelft-*}{cmyk}{...}`, `gray75` as `{gray}{0}` |
| cover/subtitle/date fonts | tudelft-light/tud-style.sty:50-70; tud-cover.sty:107,119,190 | `font.fontspec` | `\newfontfamily` x3 by file `Path=` (Carlito, Gelasio, TeX Gyre Heros); only `\tudtitlefamily` and `\tudsffamily` are used, in the cover; `\tudrmfamily` is defined and used nowhere |
| body font | whole zip (no `\setmainfont` or `\familydefault`; Grep) | `font.lmodern` | implicit default only, nothing is set; not read from a source line |
| font sizes | tudelft-light/tud-cover.sty:107,119,190-192; tud-title.sty:98,111 | `font.size-commands` | `\fontsize{14}{16.8}`, `{12}{14.4}`, title 72pt/0.9, `\LARGE` `\huge` |
| links and PDF meta | tudelft-light/tud-report.cls:97; tud-setup.sty:31-48 | `meta.hyperref` | `hidelinks,unicode,pdfpagelabels=true`; `colorlinks=true`, linkcolor=tudelft-black, citecolor=tudelft-cyan, filecolor, urlcolor; pdftitle/pdfauthor/pdfsubject set from the title fields (tud-setup.sty:68,93,130-132) |
| urls | tudelft-light/tud-report.cls:88 | `meta.url` | `[hyphens]` |
| hyphenation | tudelft-light/tud-report.cls:89; tud-cover.sty:195-197 | `sp.hyphenat` | `hyphenat`, `\nohyphens{...}` around the cover title |
| date format | tudelft-light/tud-report.cls:102; tud-cover.sty:61,133-135,211; tud-title.sty:135 | `front.datetime` | `datetime[us]`, `\newdateformat{@cover@usordate}{\monthname[\THEMONTH] \ordinaldate{\THEDAY}, \THEYEAR}` |
| outer cover page | main.tex:11; tudelft-light/tud-cover.sty:171-266 | none: ART (`art.tikz` is restricted) | `\makecover[theme=light, fill opacity=0.1]`; keys theme, fill opacity, image scale/angle/xshift/yshift/file, title fontsize (tud-cover.sty:138-169) |
| inner title page | main.tex:12; tudelft-light/tud-title.sty:89-142 | `front.titlepage-env` | `titlepage` env, `center`; `\textsc{\LARGE Delft University of Technology}`; course `\textsc{\normalsize}`; seal `\includegraphics[width=0.25\textwidth]`; title `\huge\bfseries`; two `minipage[t]{0.4\textwidth}` with `flushleft`/`flushright`; abstract `minipage[t]{0.8\textwidth}`; `\vfill`; `\small\today` |
| title-page boxes and gaps | tudelft-light/tud-title.sty:106-125 | `box.minipage` and `sp.manual-space` | widths 0.4 and 0.8 of `\textwidth`; `\\[0.25cm]` `\\[1.5cm]` `\\[1.0cm]` `\\[2.0cm]` |
| title-page image | tudelft-light/tud-title.sty:106-108 | `fig.graphicx` | `tudelft-light/images/delft_seal.pdf`, width=0.25\textwidth |
| title-page abstract | main.tex:8; tud-setup.sty:184-193; examples/abstract.tex:1-10 | `front.titlepage-env` | `\abstract{...}` stores text, printed under `\textsc{Abstract}` on the title page; the `abstract` environment is not used |
| research-question list | tudelft-light/tud-environments.sty:23-31; examples/latex_elements.tex:17-30 | `list.enumitem` | `\newlist{questions}{enumerate}{2}`; level 1 `label=\bf{RQ-\arabic*.}`, `ref=\arabic*`, `leftmargin=*`; level 2 `label*=\indent\bf{\arabic*.}`, `ref=\thequestionsi.\arabic*` |
| cross references | tudelft-light/tud-report.cls:108, 324; tud-environments.sty:35-43; examples/latex_elements.tex:11,20,27,62,83-84 | `xref.cleveref` | `[capitalise,noabbrev,nameinlink]`; `\creflabelformat{equation}{#2\textup{#1}#3}`; `\crefname{questionsi}{Research Question}{Research Question}`, `{questionsii}{Research Sub-Question}{Research Sub-Questions}` (capitalise branch) |
| tables | examples/latex_elements.tex:32-46, 65-80; tudelft-light/tud-report.cls:81,83,90 | `tbl.tabularx` | `tabularx{\textwidth}{L C C}`, columns `L` `C` `R` `P{w}` by `\newcolumntype` (tud-report.cls:312-315) |
| table rules and spacing | tudelft-light/tud-report.cls:311, 318-320; latex_elements.tex:37-44 | `tbl.booktabs` | `\toprule \midrule \bottomrule`; `\arraystretch`=1.2 (`tbl.tabular`) |
| dashed table rule | tudelft-light/tud-report.cls:99, 318-320; latex_elements.tex:42 | `tbl.arydshln` | `\dashlinedash`=0.2pt, `\dashlinegap`=1.5pt, `\arrayrulewidth`=0.3pt, `\hdashline` |
| float placement | examples/latex_elements.tex:32,65,88,104; tud-report.cls:82 | `fig.float` | `[H]` for tables and figures |
| figures, side by side | examples/latex_elements.tex:88-129; tud-report.cls:77,85,87 | `fig.graphicx` | `figure`, `\caption`, `\label`; `subfigure[t]{0.48\textwidth}` + `\hfill` (`fig.subcaption`) |
| captions | examples/latex_elements.tex:34,100,127; tud-report.cls:85 | `cap.caption` | `caption` loaded with no options and no `\captionsetup`; `\caption` is `cap.kernel` |
| listing float | tudelft-light/tud-report.cls:353-360; examples/listing.tex:6-10 | `fig.float` | `\newfloat{listing}{h}{lol}[chapter]`, `\floatname{listing}{Listing}`, `\listof{listing}{...}` and `\addcontentsline` (`toc.kernel`) |
| code listings | tudelft-light/tud-report.cls:94, 361-369; examples/listing.tex:7 | `code.listings` | `\lstset{basicstyle=\ttfamily\small, breaklines=true, columns=fullflexible, frame=single, numbers=left, numberstyle=\tiny, showstringspaces=false}`; `\lstinputlisting[language=Python]{examples/code/fatigue.py}` |
| equations | examples/latex_elements.tex:51-59; tud-report.cls:72-75 | `math.amsmath` | `equation` + `\label`; `amsfonts` `amssymb` `mathtools` loaded (`math.amssymb`, `math.mathtools`); reqno at main.tex:1 (`math.eqnumber`) |
| units and numbers | tudelft-light/tud-report.cls:95; examples/latex_elements.tex:9,41,73-77 | `mark.siunitx` | `\SI` `\num` `\unit`, default options |
| ordinals | tudelft-light/tud-report.cls:76 | `mark.nth` | `[super]`, load-only (the sample never calls `\nth`) |
| quoting package | tudelft-light/tud-report.cls:105 | `quote.quoting` | `[indentfirst=false,font={itshape}]`, load-only (no `quoting` environment in the sample) |
| bibliography | tudelft-light/tud-report.cls:109, 328; main.tex:24; examples/latex_elements.tex:63 | `bib.natbib` | `[numbers,sort&compress]`, `\citet` |
| bibliography style | tudelft-light/tud-report.cls:328; main.tex:24; references.bib:1-6 | `bib.bibtex-bst` | `\bibliographystyle{unsrtnat}`, `\bibliography{references}` |
| bibliography heading | tudelft-light/tud-report.cls:329-334 | `head.kernel` | `\bibsection` = `\chapter*{References}` + `\addcontentsline{toc}{chapter}` + `\markboth{\MakeUppercase{..}}{}` (`mark.case`) |
| nomenclature | tudelft-light/tud-report.cls:101, 266-305; examples/latex_elements.tex:132-137 | `idx.glossaries` | `nomencl[intoc]`, `\makenomenclature`, `\nomname`=List of Symbols, `\nomgroup` mapping G B S T A to heading strings, `\nomunit`; `\printnomenclature` is never called (README.md:95) |
| file inclusion | main.tex:8,22,26; tudelft-light/tud-report.cls:70 | `struct.input` | `\input`, `\include`; `import` loaded, never called |
| dummy text | tudelft-light/tud-report.cls:98 | `draft.todo` | `blindtext`, load-only |
| plotting package | tudelft-light/tud-report.cls:78, 80, 308 | `art.tikz` | `tikz`, `pgfplots` with `\pgfplotsset{compat=1.16}`; no plot in the sample; the figures' pictures are content |
| inline markup | examples/latex_elements.tex:139-140 | `mark.kernel` | `\texttt` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\makecover` and its keyval setup (theme choice, opacity, image keys) | tudelft-light/tud-cover.sty:138-266 | No | ART: layered pgf page with a fitted translucent band (see Blockers) |
| `\cleardoublepage` with "intentionally left blank" text | tudelft-light/tud-report.cls:212-247 | No | hand-written conditionals decide what is printed; `pg.emptypage` blanks pages and `pg.break` only flushes, neither prints text |
| `\frontmatter` `\mainmatter` `\@chapter` copy of book.cls, `\if@mainmatter` | tudelft-light/tud-report.cls:147-210 | Yes (borderline: it redefines `\@chapter`) | the effect is the native book vocabulary: `class.book` with `\frontmatter` (roman, no chapter numbers, `plain`) and `\mainmatter` (arabic, `fancytruncated` or `plain` by `fancyheader`) |
| `\maketitle` `\title[..]` `\subtitle` `\author` `\course` `\supervisor` `\abstract`, with `listofitems` parsing, plural test and student-number split | tudelft-light/tud-title.sty:38-142; tud-setup.sty:51-193 | Yes | static expansion by the emitter into one `titlepage` environment of kernel commands and `minipage`s; "Author(s)" decided at emit time; pdf metadata as fixed `\hypersetup` strings |
| `fancyheader` option, `\mainmatter@pagestyle`, `\iftud@fancyheader` | tudelft-light/tud-report.cls:52-61, 152-159, 258-260 | Yes | the emitter writes the chosen `hf.fancyhdr` style or `plain` |
| `\if@twoside` inside the geometry options | tudelft-light/tud-report.cls:118-128 | Yes | one `page.geometry` option list (twoside is set in main.tex:1) |
| `\nomgroup` heading map, `\nomunit` | tudelft-light/tud-report.cls:268-305 | Yes | fixed strings for five group letters; `\nomentryend` with `\hspace*{\fill}\SI` (`sp.manual-space`, `mark.siunitx`); unseen in the sample because nothing prints the list |
| etoolbox `\pretocmd`/`\apptocmd` that drop `\cite` in lists | tudelft-light/tud-report.cls:339-347 | Yes (borderline) | optional short caption `\caption[short]{long}` carries no citation; the sample has no citation in a caption; the `\listoflistings` patch (346-347) comes before its definition (356), so as written it patches nothing |
| `listing` float and `\listoflistings` | tudelft-light/tud-report.cls:353-360 | Yes | `fig.float` declaration plus `\listof` and `\addcontentsline` |
| `\bibsection` redefinition, `\BibliographyName` | tudelft-light/tud-report.cls:329-334 | Yes | natbib's documented hook; `head.kernel` and `mark.case` |
| `\hsp`, `\zero`, `\newcolumntype` C L R P | tudelft-light/tud-report.cls:133, 312-315; tud-macros.sty:8 | Yes | aliases of `\hspace{3pt}`, `{#1}^{(0)}`, and tabularx/array column types; `\zero` is unused |
| `\if@cref@capitalise` branch | tudelft-light/tud-environments.sty:35-41 | Yes | `capitalise` is set at tud-report.cls:108, so the emitter writes the capitalised `\crefname` lines |
| class infrastructure: `kvoptions`, `xkeyval`, `etoolbox`, `iftex`, `listofitems` | tudelft-light/tud-report.cls:45,49,67,103-104 | Yes | they only support the macros above; no printed effect of their own |
| font files by absolute path `/opt/texlive/2025/texmf-dist/...` | tudelft-light/tud-style.sty:51,57,65 | Yes | `font.fontspec` by font name or file; the path is the compiler image's, an environment fact (fonts ship with TeX Live, not in the zip) |

## Content-opaque
- TikZ pictures inside figures: examples/latex_elements.tex:90-99, 108-113, 119-123 (they use the colour `tudelft-cyan`).
- Python code text examples/code/fatigue.py (included at examples/listing.tex:7; not read, it is listing content).
- Equation, table cell and bibliography entry content (examples/latex_elements.tex:51-59, 36-45, references.bib:1-6).
- Images tudelft-light/images/*.pdf (seal, logos, backgrounds) are shipped assets, not recoded.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
