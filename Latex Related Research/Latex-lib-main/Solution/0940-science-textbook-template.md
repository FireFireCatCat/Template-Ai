yes

# 0940-science-textbook-template: Science Textbook Template

- Unverified: read from the source, not compiled.
- Source: Source/0940-science-textbook-template/ (origin: https://latextemplates.com/downloads/science-textbook-template.zip; licence: CC0-1.0)
- Kind: book
- Lib: v6
- Engine: pdfLaTeX-compatible (README.md:5-6 says compile with pdfLaTeX; the preamble loads only 8-bit font and encoding packages, main.tex:2-4)
- Look carried by: preamble (an unchanged default `book` class; the look is the sample's own preamble, main.tex:1-16, and a hand-laid title page in the body, main.tex:18-27; no zip-local class or style)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; the zip holds only main.tex and README.md)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip is two files: a 71-line `main.tex` on the kernel `book` class with no zip-local `.cls`, `.sty` or `.def`, and a README. Every component the sample uses maps to a lib way: kernel `book` headings, kernel `\newtheorem`, `amsmath`, `booktabs`, `xcolor`, `makeidx`, and a title page of kernel spacing, size and rule commands. The two `\newcommand` macros (`\booksubtitle`, `\keyterm`) are an alias for a string and a composition of three lib ways, so both reduce by inline expansion. `tikz` is loaded but never called, so there is no `ART` blocker.

## Blockers
none

## Class setting
- Class: `class.book` options: `11pt`, `oneside` (main.tex:1); the class is the LaTeX base `book`, not bundled in the zip and not read
- Class-native vocabulary used: `\chapter` and `\chapter*` (main.tex:28, 33, 51, 61, 68), `\section` (main.tex:34, 45, 52), `titlepage` environment (main.tex:18-27), `\tableofcontents` (main.tex:31), `\mainmatter` (main.tex:32), `\backmatter` (main.tex:67). `\frontmatter` is not used.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.book` | 11pt, oneside |
| paper and type size | main.tex:1 | `page.class-options` | `11pt`, `oneside`; no paper-size option, so the class default |
| page geometry | main.tex:5 | `page.geometry` | margin=1in |
| encodings and text symbols | main.tex:2-3, 26 | `font.fontenc-t1` | `\usepackage[T1]{fontenc}`, `\usepackage[utf8]{inputenc}`; `\textbullet` (a kernel text symbol) between "First edition" and the year |
| text font | main.tex:4 | `font.lmodern` | no options |
| maths packages | main.tex:6 | `math.amsmath`, `math.amssymb` | no options |
| display equations | main.tex:42-44, 48-50 | `math.amsmath` | `equation` (numbered) and `equation*`; `\frac`, `\tfrac` (amsmath); numbering is the `book` default |
| inline maths with units | main.tex:46-47 | `math.amsmath` | `\mathrm{m}`, `\,` thin space in `$..$`; the numbers and units are content |
| colour | main.tex:9, 13 | `color.xcolor` | `\usepackage{xcolor}`; `\definecolor{scienceblue}{HTML}{2C5F85}` |
| link style | main.tex:11 | `meta.hyperref` | `hidelinks` |
| index | main.tex:10, 12, 70 | `idx.makeidx` | `\usepackage{makeidx}`, `\makeindex`, `\printindex` in the back matter; needs a `makeindex` pass, the way's own tool, as BibTeX is for `bib.bibtex-bst` (the document compiles without it, with an empty index) |
| key-term marker | main.tex:15, 35 | `mark.kernel`, `color.xcolor`, `idx.makeidx` | `\textbf{\color{scienceblue}term}` then `\index{term}`; the zip-local macro `\keyterm` wraps these three (see Bespoke code) |
| title page | main.tex:18-27 | `front.titlepage-env` | `titlepage` environment laid by hand; no `\title`, `\author` or `\maketitle` anywhere in the file |
| title page: alignment | main.tex:19 | `sp.ragged` | `\centering` |
| title page: spacing and breaks | main.tex:20, 21, 22, 23, 24, 25, 26 | `sp.manual-space` | `\vspace*{1.0in}`, `\\` in "Science\\Textbook", `\vspace{14pt}`, `\vspace{18pt}`, `\vfill`, `\vspace{6pt}`, `\vspace{0.4in}` |
| title page: type sizes | main.tex:21, 23, 25, 26 | `font.size-commands` | `\fontsize{34}{40}\selectfont` for the title; `\Large` (subtitle, author), `\large` (department), `\small` (edition line) |
| title page: weight | main.tex:21 | `mark.kernel` | `\bfseries` on the title |
| title page: rule | main.tex:22 | `sp.rule` | `\rule{0.75\textwidth}{3pt}` |
| title page: year | main.tex:26 | content | `\the\year` prints the current year; a date value (a TeX register, as `\today` is), not template logic |
| unnumbered preface and closing chapter | main.tex:28, 68 | `head.kernel` | `\chapter*{Preface}`, `\chapter*{Further reading}`, default `book` look |
| chapter and section headings | main.tex:33-34, 45, 51-52, 61 | `head.kernel` | `\chapter`, `\section`; nothing redefined, no `titlesec` |
| contents | main.tex:31 | `toc.kernel` | `\tableofcontents`, default depth |
| matter divisions | main.tex:32, 67 | `front.class-native` | `\mainmatter` after the contents, `\backmatter` before the closing chapter |
| running heads and page numbers | main.tex:1 | `hf.class-native` | nothing set in the file; the default `book` page styles apply (no `\pagestyle` or `\thispagestyle`, Grep) |
| theorem-like statement | main.tex:16, 38-40 | `thm.kernel` | `\newtheorem{principle}{Principle}[chapter]`, numbered within chapter; no `\theoremstyle` (amsthm is not loaded), so the kernel look |
| table wrapper | main.tex:54, 60 | `sp.ragged` | `center` environment around the tabular |
| table | main.tex:55-59 | `tbl.tabular`, `tbl.booktabs` | `tabular{lrr}`; `\toprule`, `\midrule`, `\bottomrule` (main.tex:7); not a float, no caption |
| list | main.tex:62-66 | `list.kernel` | `enumerate`, three items, default labels |
| `tikz` package | main.tex:8 | `art.tikz` | load-only: no `tikzpicture`, `\tikz`, `\draw` or `\node` in the file (Grep); nothing is drawn, so it is not template artwork and not a blocker |
| bibliography, floats, captions, cross-references, footnotes, notes, code, boxes | none | none | the sample has no `\cite`, `\label`, `\ref`, `\caption`, `figure`, `table` or `\footnote` (Grep); main.tex:69 is plain text ("Add citations, links, and instructor notes here") |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\booksubtitle` | main.tex:14 (used at main.tex:23) | yes | a string alias; write "A practical science textbook starter" inline inside `{\Large ...\par}` |
| `\keyterm` | main.tex:15 (used at main.tex:35) | yes | `\newcommand{\keyterm}[1]{\textbf{\color{scienceblue}#1}\index{#1}}` is `mark.kernel` + `color.xcolor` + `idx.makeidx`, no conditional, counter or computed layout; the emitter writes `\textbf{\color{scienceblue}term}\index{term}` around the term at each use |

`\newtheorem{principle}...` (main.tex:16) and `\definecolor` (main.tex:13) are kernel and `xcolor` declarations, not bespoke code. The file defines no counter, conditional, `\def`, `\renewcommand` or environment of its own (Grep).

## Content-opaque
none (the equation, the table cells and the exercise text are content; no figure or picture is present)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
