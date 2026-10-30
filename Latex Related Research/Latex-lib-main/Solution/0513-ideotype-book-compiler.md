yes

# 0513-ideotype-book-compiler: IdeoType Book Compiler

- Unverified: read from the source, not compiled.
- Source: Source/0513-ideotype-book-compiler/ (origin: https://latextemplates.com/downloads/ideotype.zip; licence: MIT)
- Kind: book
- Lib: v5
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (the stock `book` class defaults plus the sample's own preamble packages; the zip has no class, style or other zip-local file)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; README.md is prose only)
- Read: main yes, zip-local classes and styles none present (the `book` class source was not read: it ships with LaTeX and is not in the zip)

## Verdict
Yes. The zip is two files: a 45-line `main.tex` and a README. The sample loads the published kernel class `book` and seven published packages, with no `\newcommand`, `\def`, environment, counter or conditional of its own (grep over main.tex finds none). Every component maps to a lib way with named parameters, nothing is bespoke, there is no artwork, and nothing needs a tool outside TeX. The only third-party tool mentioned, the upstream IdeoType XHTML-to-PDF compiler, is outside the zip and the sample does not call it (README.md:5).

## Blockers
none

## Class setting
- Class: `class.book` options: `11pt`, `oneside` (main.tex:1)
- Class-native vocabulary used: `\frontmatter` (main.tex:17), `\mainmatter` (main.tex:22), `\backmatter` (main.tex:42), `\chapter` and `\chapter*` (main.tex:19, 23, 33, 43), `\maketitle` (main.tex:18), `\tableofcontents` (main.tex:21)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.book` | 11pt, oneside |
| base size and sides | main.tex:1 | `page.class-options` | 11pt, oneside (the paper size is set by geometry, next row) |
| page geometry | main.tex:2 | `page.geometry` | paperwidth=6in, paperheight=9in, margin=0.8in, headheight=14pt |
| font encoding | main.tex:3 | `font.fontenc-t1` | fontenc option T1 (no `inputenc` loaded) |
| text and maths font | main.tex:4 | `font.lmodern` | no options |
| typography | main.tex:5 | `sp.microtype` | default options |
| colours | main.tex:6, 9, 10 | `color.xcolor` | `\definecolor{violet}{HTML}{5B3A8E}`, `\definecolor{codebg}{HTML}{F3F0F7}` |
| link colours and PDF links | main.tex:8, 11 | `meta.hyperref` | colorlinks=true, linkcolor=violet, citecolor=violet, urlcolor=violet |
| listing style | main.tex:7, 12 | `code.listings` | basicstyle=\ttfamily\small, backgroundcolor=\color{codebg}, frame=single, framerule=0pt, breaklines=true |
| listing font switches (inside `basicstyle`) | main.tex:12 | `mark.kernel`, `font.size-commands` | `\ttfamily`; `\small` |
| code block | main.tex:27-32 | `code.listings` | `lstlisting` environment, no options; the XML-like lines are code text (content) |
| title block | main.tex:13, 14, 15, 18 | `front.maketitle` | `\title{...}`, `\author{Your Name}`, `\date{}` (empty), `\maketitle` |
| title subtitle line | main.tex:13 | `sp.manual-space`, `font.size-commands` | `\\[0.4em]` line break with a length; `\large` for the subtitle |
| front/main/back matter switching | main.tex:17, 22, 42 | `class.book` | `\frontmatter`, `\mainmatter`, `\backmatter` (the roman and arabic page numbers come from the class; there is no `\pagenumbering` call) |
| unnumbered chapters | main.tex:19, 43 | `head.kernel` | `\chapter*{Production brief}`, `\chapter*{Build notes}` |
| contents list | main.tex:21 | `toc.kernel` | `\tableofcontents`, no `tocdepth` change |
| chapter and section headings | main.tex:23, 25, 33, 35 | `head.kernel` | `\chapter`, `\section`; stock `book` look, no `titlesec` or counter changes |
| ordered list | main.tex:36-41 | `list.kernel` | `enumerate`, four `\item`, no `enumitem` |
| running heads and page numbers | no call in main.tex (class default) | `hf.pagestyle-kernel` | the `book` default (`headings`, `plain` on chapter openings); no `\pagestyle` or `\thispagestyle` is written; `headheight` is set in geometry (main.tex:2) |

Components the sample does not define or use: abstract, language setup, footnotes, cross-references, math, theorems, floats, tables, captions, bibliography, index, notes.

## Bespoke code
none. `\definecolor`, `\hypersetup` and `\lstset` (main.tex:9-12) are calls into published packages (`xcolor`, `hyperref`, `listings`). There is no `\newcommand`, `\def`, `\newenvironment`, counter or conditional in main.tex, and no zip-local `.cls`, `.sty`, `.def`, `.cfg` or `.clo`.

## Content-opaque
none (the `lstlisting` text at main.tex:27-32 is code content, held by `code.listings`)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- README.md:3-5 states that the catalogue entry is an original starter and does not bundle the upstream IdeoType compiler, manuscript content or assets. It is plain prose with no text addressed to an AI.
- Every package is a published CTAN or LaTeX-base package used with declarative options; `listings` runs inside TeX (no shell escape, no pygments).
- No fonts or images are needed beyond `lmodern`, which ships with TeX distributions.
