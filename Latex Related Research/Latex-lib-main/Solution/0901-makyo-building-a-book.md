yes

# 0901-makyo-building-a-book: makyo "Building a Book" (memoir starter)

- Unverified: read from the source, not compiled.
- Source: Source/0901-makyo-building-a-book/ (origin: https://latextemplates.com/downloads/makyo-building-a-book.zip; licence: not established (manifest: UNKNOWN, no licence statement located))
- Kind: book
- Lib: v6
- Engine: pdfLaTeX-compatible (`T1` + `inputenc utf8`, main.tex:2-3; README.md:5 says compile with pdfLaTeX)
- Look carried by: mixed (published class `memoir` supplies the defaults; main.tex:1-18 sets memoir's own page, chapter-style and section-depth commands plus published packages; the zip holds no `.cls` or `.sty`)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is two files, `main.tex` (71 lines) and a 6-line `README.md`. The sample is a published `memoir` document with a preamble of published packages and memoir's own layout commands; it defines no macro, environment, counter or conditional of its own, and draws nothing. Every component maps to an existing lib way, and the one `\renewcommand` (of memoir's `\chaptitlefont` hook) is a parameter of `head.memoir-style`. `memoir` is not in the zip: it ships with the TeX distribution, so its source was not read and the way's behaviour is taken from its public manual.

## Blockers
none

## Class setting
- Class: `class.memoir` options: `11pt`, `twoside`, `openright` (main.tex:1)
- Class-native vocabulary used: `\setstocksize` `\settrimmedsize` `\setlrmarginsandblock` `\setulmarginsandblock` `\checkandfixthelayout` (main.tex:10-14); `\chapterstyle{madsen}` and the font hook `\chaptitlefont` (main.tex:16-17); `\setsecnumdepth` (main.tex:18); `\frontmatter` `\mainmatter` `\backmatter` (main.tex:20, 36, 66); `titlingpage` environment (main.tex:21-29); `\cleartorecto` (main.tex:30); `\chapter` and `\chapter*` (main.tex:31, 37, 49, 67)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.memoir` | options 11pt, twoside, openright |
| page size and sides | main.tex:1 | `page.class-options` | 11pt, twoside (class options); openright sets chapter opening on recto pages |
| page geometry (stock, trim, margins) | main.tex:10-14 | `page.memoir-layout` | `\setstocksize{9in}{6in}`; `\settrimmedsize{9in}{6in}{*}`; `\setlrmarginsandblock{0.82in}{0.68in}{*}`; `\setulmarginsandblock{0.82in}{0.75in}{*}`; `\checkandfixthelayout` |
| font encoding | main.tex:2-3 | `font.fontenc-t1` | `fontenc` option T1; `inputenc` option utf8 |
| text and maths face | main.tex:4 | `font.lmodern` | `lmodern`, no options |
| microtypography | main.tex:5 | `sp.microtype` | `microtype`, no options |
| colour | main.tex:7, 15 | `color.xcolor` | `xcolor` no options; `\definecolor{chapterblue}{HTML}{24527A}` |
| links and PDF | main.tex:9 | `meta.hyperref` | `hyperref` option `hidelinks`; no `\hypersetup`, no PDF metadata set |
| graphics package | main.tex:6 | `fig.graphicx` | `graphicx` loaded, no options; no `figure`, `\includegraphics` or `\caption` in main.tex |
| header and footer | none set in main.tex (no `\pagestyle`, `\makepagestyle`, `\thispagestyle`) | `hf.class-native` | memoir's default running heads, chosen by class and `twoside`; nothing written by the sample (memoir source not read) |
| front, main and back matter | main.tex:20, 36, 66 | `front.class-native` | `\frontmatter`, `\mainmatter`, `\backmatter` (the class switches chapter numbering and page-number style) |
| title page | main.tex:21-29 | `front.class-native` | memoir `titlingpage` environment (kernel analogue `front.titlepage-env` also exists in the lib); no `\title` `\author` `\maketitle` used |
| title page alignment | main.tex:22 | `sp.ragged` | `\centering` |
| title page spacing | main.tex:23, 25, 26, 27 | `sp.manual-space` | `\vspace*{1.1in}`, `\vspace{14pt}`, `\vfill`, `\vspace{8pt}` |
| title page type sizes | main.tex:24, 25, 27, 28 | `font.size-commands` | `\Huge`, `\Large`, `\Large`, `\small`, each in a group ended by `\par` |
| title page bold | main.tex:24 | `mark.kernel` | `\bfseries` |
| page break to recto | main.tex:30 | `pg.break` | memoir `\cleartorecto` (the page-flow type of `\cleardoublepage`) |
| chapter heading look | main.tex:16-17 | `head.memoir-style` | `\chapterstyle{madsen}`; `\renewcommand{\chaptitlefont}{\normalfont\Huge\bfseries\color{chapterblue}}` (font hook: `\normalfont` + `\Huge` + `\bfseries` + `\color`) |
| chapters and sections | main.tex:31, 37, 38, 46, 49, 50, 56, 67 | `head.kernel` | `\chapter`, `\chapter*`, `\section`; no `\subsection` used |
| section numbering depth | main.tex:18 | `num.secnumdepth` | `\setsecnumdepth{subsection}` (memoir's command for the `secnumdepth` counter) |
| table of contents | main.tex:35 | `toc.kernel` | `\tableofcontents`, memoir default entries, no `\cft...` settings |
| block quote | main.tex:42-45 | `quote.kernel` | `quote` environment |
| enumerated list | main.tex:51-55 | `list.kernel` | `enumerate`, three `\item`, no options |
| table body alignment | main.tex:57, 65 | `sp.ragged` | `center` environment around the tabular (not a float, no caption) |
| table | main.tex:58-64 | `tbl.tabular` | `tabular` column spec `{llr}`, header row and three data rows |
| table rules | main.tex:8, 59, 63 | `tbl.booktabs` | `booktabs` loaded main.tex:8; `\toprule` `\midrule` `\bottomrule` (main.tex:59, 63) |

Components the sample does not use and the template does not define: abstract, keywords, theorem-like statements, mathematics, footnotes, floats with captions, code, boxes, bibliography, index, cross-references, language setup, background or watermark, paragraph and spacing settings.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand{\chaptitlefont}{\normalfont\Huge\bfseries\color{chapterblue}}` | main.tex:17 | yes | memoir's documented chapter-title font hook, redefined with kernel font switches and an `xcolor` colour: one parameter of `head.memoir-style` (value = `font.size-commands` `\Huge` + `mark.kernel` `\bfseries` + `color.xcolor` `\color{chapterblue}`). Whether `madsen` reads this hook was not checked, since memoir's source is not in the zip. |

No other `\newcommand`, `\renewcommand`, `\def`, environment, counter or conditional exists in `main.tex`, and there is no zip-local `.cls`, `.sty`, `.def`, `.cfg` or `.clo`. The file has no text addressed to an AI.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
