yes

# 0037-hilbert: hilbert (book class, three-story fiction starter)

- Unverified: read from the source, not compiled.
- Source: Source/0037-hilbert/ (origin: https://latextemplates.com/downloads/rashid-talha-hilbert-book.zip; licence: MIT)
- Kind: book
- Lib: v1
- Engine: pdfLaTeX-compatible (fonts come from TeX Live packages `sourcesanspro`, `libertine`, `newtxmath`, `inconsolata`, none shipped in the zip; needs LaTeX 2020-10 or later because `\DeclareDocumentCommand` is used without `xparse`, hilbert.cls:95)
- Look carried by: zip-local (hilbert.cls defines the whole look; the sample preamble only stores title, author, edition, date as macros, additional/metadata.tex:4-13)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
`yes`, with one reduction that is the least certain point. `hilbert` is a zip-local class (README.md says "Not on CTAN"; ctan.org/pkg/hilbert returned 404; it is a single-author class with no documentation besides its comments, so not an official release). Every line of hilbert.cls is `\LoadClass{book}` plus published packages with parameters, plus thin wrappers (`\halftitlepage`, `\frontmatter` etc., `quote`, scene-break rules) that reduce to kernel commands and lib ways. There is no TikZ, no external tool, and no irreducible output routine. The least certain reduction is the mid-document switch of the book class's `\if@openright` (hilbert.cls:198-219): it is written below as the `openany` class option plus explicit `\cleardoublepage`, a reduction read from the source, not tested.

## Blockers
none

## Class setting
- Class: `class.book` (reached through zip-local `hilbert`, which does `\LoadClass{book}` at hilbert.cls:21) options: `11pt` (main.tex:10); the class also forwards `10pt`/`12pt`/`draft`/`final` to book (hilbert.cls:7-11), and `indent`/`noindent` to the `parskip` option list (hilbert.cls:14-16, 70); the sample uses the default, so `parskip` gets an empty option list. Any other option is a `\ClassError` (hilbert.cls:18). Reduced setting: `\documentclass[11pt,openany]{book}` (see "chapter opening side" row).
- Class-native vocabulary used (of the zip-local class, reduced below, not of `book`): `\halftitlepage` (main.tex:17), page style name `hf-front` (main.tex:22), `\title[short]{long}` and `\author` as data stores (additional/metadata.tex:4-5), `\utitle` `\uauthor` `\udate` `\uedition` (additional/copyright.tex:7-9, additional/fulltitle.tex:7,10); book-native: `\frontmatter` `\mainmatter` `\backmatter` `\chapter` `\tableofcontents` `\emph` `quote` (main.tex:16,21,26,31).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | hilbert.cls:21, main.tex:10 | `class.book` | 11pt; openany (see chapter opening side) |
| page geometry | hilbert.cls:34-46 | `page.geometry` | papersize={129mm,198mm}, includehead, includefoot, nomarginpar, top=14mm, bottom=16mm, left=18mm, right=18mm, headheight=6mm, headsep=4mm, footskip=10mm |
| blank pages truly empty | hilbert.cls:49-56 | `pg.emptypage` | load-only; replaces the `\cleardoublepage` redefinition (`\clearpage`, odd page check, else `\null\thispagestyle{empty}\newpage`) |
| chapter opening side per matter | hilbert.cls:198-219 | `class.book` option + `pg.break` | front matter and back matter: open on any page; main matter: open right. Reduction: option `openany` plus kernel `\cleardoublepage` before each main-matter `\chapter` after the first and before `\backmatter` (`\mainmatter` already calls it) |
| page numbering | hilbert.cls:198-219 (book's `\frontmatter`/`\mainmatter` called inside) | `pgnum.pagenumbering` | roman in front matter, arabic from `\mainmatter`, unchanged book behaviour |
| page style per matter | hilbert.cls:199-221, main.tex:22 | `hf.pagestyle-kernel` | `\pagestyle{empty}` at `\frontmatter`; `hf-front` after the contents (main.tex:22); `hf-main` at `\mainmatter`; `hf-back` at `\backmatter` |
| running heads and feet | hilbert.cls:109-138 | `hf.fancyhdr` | `\fancypagestyle` hf-front: `\fancyhf{}`, foot C `-- \thepage\ --`, headrulewidth 0pt. hf-main and hf-back: head CO `{\small\scshape\leftmark}`, head CE `{\small\scshape <short title>}`, foot C `-- \thepage\ --`, headrulewidth 0pt. `plain` (chapter pages) redefined: foot C only. `\chaptermark` -> `\markboth{#1}{}`, `\sectionmark` -> `\markright{\thesection\ #1}` (hilbert.cls:110-111) |
| input and font encoding | hilbert.cls:61-62 | `font.fontenc-t1` | inputenc utf8; fontenc T1 |
| sans text face | hilbert.cls:64, 68 | `font.helvet` | `sourcesanspro` options semibold, scale=.9; `\sfdefault` set to SourceSansPro-LF |
| serif text face | hilbert.cls:65 | `font.libertine` | `libertine` option osf |
| maths face | hilbert.cls:66 | `font.newtx` | `newtxmath` option libertine (maths used only for `$\bullet$`, `$\ast$`, `$\diamond$`) |
| mono face | hilbert.cls:67 | `font.mono` | `inconsolata` |
| default family override | hilbert.cls:68 | `font.family-default` | `\renewcommand{\sfdefault}{SourceSansPro-LF}` |
| paragraph spacing | hilbert.cls:70 | `sp.parskip-pkg` | option list empty by default (class option `indent` forwards `indent`; not exercised) |
| line spacing | hilbert.cls:71, 75 | `sp.setspace` | `\setstretch{1.1}` |
| microtypography | hilbert.cls:72 | `sp.microtype` | defaults |
| language | hilbert.cls:73 | `lang.babel` | british |
| colours | hilbert.cls:80-90 | `color.xcolor` | `\definecolor` RGB: alertred 204,37,41; linkblue 0,86,179; citegreen 34,139,34; teal 0,128,128; crimson 153,0,0; softazure 52,152,219; burntorange 230,126,34; amethyst 155,89,182; slategray 127,140,141; boxgray 233,233,233. Only `crimson` is used (hilbert.cls:265) |
| hyperlinks | hilbert.cls:261-266 | `meta.hyperref` | colorlinks=true, linktoc=all, allcolors=crimson |
| title and author data | hilbert.cls:95-104, additional/metadata.tex:4-5 | `front.maketitle` | `\title[The Silent Type]{The Silent Type}`, `\author{Nadia Farouk}` as values only; `\maketitle` is never called. The class copies them into `\utitle`, `\ushorttitle`, `\uauthor` |
| half-title page | hilbert.cls:178-184, main.tex:17 | `front.titlepage-env` | hand-laid: `\clearpage`, `\thispagestyle{empty}`, `\vspace*{0.3\textheight}`, `{\centering\scshape\Large <title>\par}`, `\clearpage`; with `sp.manual-space`, `pg.break`, `hf.pagestyle-kernel`, `sp.ragged`, `font.size-commands`, `mark.kernel` for the pieces |
| full title page | additional/fulltitle.tex:2-13 | `front.titlepage-env` | `\clearpage`; group with `\centering`; `\vspace*{25mm}`; `{\fontsize{29pt}{31pt}\scshape <title>\par}` (`font.size-commands`); `\vspace*{8mm}`; `{\Large\itshape <author>\par}`; `\clearpage` |
| copyright page | additional/copyright.tex:2-13 | `front.dedication` | `\clearpage`; group with `\null\vfill\small`; lines title, `Edition 1`, `Copyright \textcopyright\ 2026 by <author>.`, `All rights reserved.`; `\clearpage` (`pg.break`, `sp.manual-space`) |
| dedication page | additional/dedication.tex:2-12 | `front.dedication` | `\clearpage`; group with `\null\vspace*{0.3\textheight}`, `\Large\itshape`, `center` environment; `\clearpage` |
| contents | main.tex:21, hilbert.cls:145-149 | `toc.kernel` | `\tableofcontents` |
| contents entries | hilbert.cls:143-149 | `toc.titletoc` | `\titlecontents{chapter}[3mm]{\large\itshape\vspace{3mm}}{\thecontentslabel\quad}{}{\titlerule*[2mm]{.}\contentspage\hspace*{3mm}}` |
| chapter heading | hilbert.cls:154-161 | `head.titlesec` | `\titleformat{\chapter}[display]{\vspace*{-15mm}}{\centering\LARGE\thechapter}{3mm}{\centering\Huge\scshape}[\vspace*{-2mm}]` |
| section and subsection headings | hilbert.cls:163-173 | `head.titlesec` | section `{\normalfont\Large\itshape}{\thesection}{1em}{}`; subsection `{\normalfont\large\itshape}{}{1em}{}` (defined, unused by the sample) |
| chapters (stories) | chapters/*.tex:2 | `head.kernel` | kernel `\chapter{...}` in `class.book` main-matter mode |
| foreword, preface, about the author | additional/foreword.tex:2, preface.tex:2, aboutauthor.tex:2 | `head.kernel` | unnumbered `\chapter` through book's `\frontmatter`/`\backmatter` |
| acknowledgements | additional/acknowledgements.tex:2 | `front.dedication` | unnumbered `\chapter{Acknowledgements}` in back matter |
| block quote | hilbert.cls:226, chapters/thelastcall.tex:4-8 | `quote.kernel` | `quote` environment redefined as `adjustwidth`; with `\itshape` set in the body |
| quote indent | hilbert.cls:28, 226 | `page.adjustwidth` | `changepage` option strict; `\begin{adjustwidth}{12mm}{0mm}` |
| scene-break ornaments | hilbert.cls:228-230 | `sp.rule` | `\rulethin`: `\par\nopagebreak\vspace{1ex}\centerline{\rule{0.3\textwidth}{0.4pt}}\vspace{1ex}\par`. `\rulestars`: `\vspace{2.5ex}`, `\large\textasteriskcentered` three times separated by `\quad`, `\vspace{0.75ex}`. `\rulediamonds`: same with `$\diamond$`. Pieces: `sp.manual-space`, `pg.break` (`\nopagebreak`), `sp.ragged` (`\centerline`), `math.kernel`, `font.size-commands` (unused by the sample) |
| blank page | hilbert.cls:186-192 | `front.titlepage-env` | `\clearpage`, `\thispagestyle{empty}`, `\vspace*{0.3\textheight}`, `{\centering\itshape <text>\par}`, `\clearpage` (default text "This page left blank intentionally"; unused by the sample) |
| lists | hilbert.cls:235-239 | `list.enumitem` | `\setlist[itemize,1]{label=$\bullet$}`; `[itemize,2]{leftmargin=6mm}`; `[itemize,3]{leftmargin=6mm, label=$\ast$}` (unused by the sample) |
| tables | hilbert.cls:244-254 | `tbl.booktabs` | `booktabs` loaded (unused by the sample) |
| tabularx columns | hilbert.cls:244-252 | `tbl.tabularx` | `\newcolumntype` C, R, L (X-based, `\centering`/`\raggedleft`/`\raggedright` with `\arraybackslash`) and D, U, V (p-width based); in `tbl.tabular` terms the `array` `\newcolumntype` |
| table row stretch | hilbert.cls:254 | `tbl.tabular` | `\ra{#1}` is an alias of `\renewcommand{\arraystretch}{#1}` |
| captions | hilbert.cls:259 | `cap.caption` | font=small, labelfont=bf, labelsep=endash (no float is used in the sample; `graphicx` is not loaded) |
| emphasis | chapters/postcardsfromnowhere.tex:7,15,28 | `mark.kernel` | `\emph` |

Not in the sample or the class: theorems, equations, code listings, bibliography, index, figures, footnotes, appendix.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class `hilbert` as a whole | hilbert.cls:1-266 | yes | `\documentclass[11pt,openany]{book}` plus the packages and settings in the map; nothing else in the file produces output |
| option plumbing `\@@docindent`, `\DeclareOption` | hilbert.cls:7-20 | yes | options forwarded to `book` and to the `parskip` option list; the emitter writes the final package line |
| `\cleardoublepage` redefinition | hilbert.cls:49-56 | yes | `emptypage` package (`pg.emptypage`); this class is always two-sided (no `oneside` option is declared), so the kernel's twoside test is not lost |
| `\frontmatter` `\mainmatter` `\backmatter` wrappers using `\@openrightfalse`/`\@openrighttrue` and `\pagestyle` | hilbert.cls:198-221 | yes | kernel `\frontmatter`/`\mainmatter`/`\backmatter` + `\pagestyle{...}` (`hf.pagestyle-kernel`) + `openany` class option with explicit `\cleardoublepage` before main-matter chapters and before `\backmatter`; alternative: `\makeatletter\@openrightfalse\makeatother` at the three points. Not tested; this is the one spot that relies on reading the book class's behaviour |
| `\title` and `\author` redefinitions storing `\utitle`, `\ushorttitle`, `\uauthor`, `\@title`, `\@author` | hilbert.cls:95-104 | yes | data macros; the emitter writes the literal title, short title and author into the head, half-title, full-title and copyright code. `\IfValueTF` only chooses between short and long title. `\@title` is set to the short title and never printed because `\maketitle` is not called |
| metadata macros `\uaffiliation \upublisher \uisbn \uedition \urevision \uvolume \udate` | additional/metadata.tex:7-13 | yes | `\newcommand` constants; only `\uedition` (1) and `\udate` (2026) are printed (additional/copyright.tex:8-9); the others are empty and unused |
| `\halftitlepage`, `\blankpage` | hilbert.cls:178-192 | yes | hand-laid pages from kernel spacing and font commands, optional argument overrides the text |
| `quote` redefinition | hilbert.cls:226 | yes | `adjustwidth{12mm}{0mm}` as the body wrapper |
| `\rulethin` `\rulestars` `\rulediamonds` | hilbert.cls:228-230 | yes | sequences of `\vspace`, `\rule`, `\centerline`, `\nopagebreak`, text symbols; no counters or conditionals |
| `\newcolumntype` C R L D U V | hilbert.cls:246-252 | yes | `array` column types with `\centering`/`\raggedleft`/`\raggedright` |
| `\ra` | hilbert.cls:254 | yes | alias of `\renewcommand{\arraystretch}` |
| `\chaptermark`, `\sectionmark` redefinitions | hilbert.cls:110-111 | yes | standard fancyhdr mark settings (`\markboth`, `\markright`) |
| packages `etoolbox`, `calc` | hilbert.cls:27, 29 | yes | loaded, but no command of either is used in the class, the sample or the chapters (grep for `\ifdef`, `\patchcmd`, `\widthof` and similar found none); no look effect, so the emitter need not write them |

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
