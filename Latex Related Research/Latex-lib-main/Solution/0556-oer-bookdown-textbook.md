yes

# 0556-oer-bookdown-textbook: OER bookdown Textbook

- Unverified: read from the source, not compiled.
- Source: Source/0556-oer-bookdown-textbook/ (origin: https://latextemplates.com/downloads/oer-bookdown.zip, repackaged from https://github.com/CrumpLab/OER_bookdown, ATTRIBUTION.txt:3-4; licence: CC-BY-SA-4.0)
- Kind: book
- Lib: v4
- Engine: pdfLaTeX-compatible
- Look carried by: mixed (no zip-local file; the kernel `book` class supplies chapter and matter structure and the preamble at main.tex:2-10 sets page geometry, fonts and link colour)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is one 48-line `main.tex` on the unmodified kernel `book` class, with seven published packages and no macro, environment, counter or class of its own. Every component maps to an existing lib way, there is no artwork, and nothing needs a tool outside TeX. The README says the upstream project uses R/bookdown, but this entry is plain LaTeX and loads nothing that calls it (README.md:5; main.tex:1-48). The `book` class source was not read, because it ships with the TeX distribution.

## Blockers
none

## Class setting
- Class: `class.book` options: `11pt`, `oneside` (main.tex:1)
- Class-native vocabulary used: `\frontmatter` (main.tex:15), `\mainmatter` (main.tex:20), `\backmatter` (main.tex:45), `\chapter` (main.tex:21, 39, 43), starred `\chapter*` (main.tex:17, 46), `\tableofcontents` (main.tex:19), `\section` (main.tex:23, 41)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.book` | 11pt, oneside |
| page size and margins | main.tex:2 | `page.geometry` | paperwidth=6.5in, paperheight=9.25in, top=0.82in, bottom=0.8in, inner=0.9in, outer=0.72in, headheight=14pt |
| font encoding | main.tex:3 | `font.fontenc-t1` | fontenc option T1 (no inputenc line) |
| text and maths face | main.tex:4 | `font.lmodern` | load only, no options |
| microtypography | main.tex:5 | `sp.microtype` | load only, defaults |
| colour definition | main.tex:6, 9 | `color.xcolor` | `\definecolor{openblue}{HTML}{1E5A85}` |
| link colours and PDF links | main.tex:8, 10 | `meta.hyperref` | colorlinks=true, linkcolor=openblue, citecolor=openblue, urlcolor=openblue |
| title block | main.tex:11-13, 16 | `front.maketitle` | `\title`, `\author{Your Name}`, `\date{\today}`, `\maketitle`; default book title page |
| title line break and size | main.tex:11 | `sp.manual-space` | `\\[0.4em]` between title and subtitle |
| subtitle size | main.tex:11 | `font.size-commands` | `\large` |
| front, main and back matter | main.tex:15, 20, 45 | `front.class-native` | `\frontmatter`, `\mainmatter`, `\backmatter` (class switches roman and arabic page numbers and chapter numbering; the sample calls no `\pagenumbering`) |
| unnumbered front and back chapters | main.tex:17, 46 | `head.kernel` | `\chapter*{...}`, no `\addcontentsline` |
| chapters and sections | main.tex:21, 23, 39, 41, 43 | `head.kernel` | `\chapter`, `\section` with class default look; no `\titleformat`, no counter changes |
| contents list | main.tex:19 | `toc.kernel` | `\tableofcontents`, class default depth |
| running heads and folios | none set; `headheight=14pt` at main.tex:2 | `hf.pagestyle-kernel` | class default `headings` page style, not called by the sample |
| table float | main.tex:25-38 | `tbl.tabular` | kernel `table` float with placement `[ht]` and `tabular` with column spec `lll` |
| table centring | main.tex:26 | `sp.ragged` | `\centering` |
| table rules | main.tex:7, 29, 31, 36 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule`, load only |
| table caption | main.tex:27 | `cap.kernel` | `\caption` above the table, no `caption` package |
| bibliography | main.tex:46-47 | none | placeholder text only; no `thebibliography`, no `\cite` |

Not used by the sample: lists, quotes, notes, footnotes, maths, theorems, code, boxes, figures, index, language packages, cross-references (grep for `\label`, `\ref`, `\cite`, `\footnote`, `itemize`, `equation`, `figure` over main.tex found none).

## Bespoke code
none. No `\newcommand`, `\renewcommand`, `\def`, `\makeatletter`, `\newtheorem`, counter or conditional appears in main.tex (checked by grep), and the zip has no `.cls`, `.sty` or other local class file (the zip holds only ATTRIBUTION.txt, README.md and main.tex).

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
