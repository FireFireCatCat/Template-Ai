yes

# 0190-markdown-to-book: Markdown to Book

- Unverified: read from the source, not compiled.
- Source: Source/0190-markdown-to-book/ (origin: https://latextemplates.com/downloads/markdown-to-book.zip; licence: MIT)
- Kind: book
- Lib: v3
- Engine: needs XeLaTeX (`fontspec` and `\setmainfont` at main.tex:5-6; LuaLaTeX also serves fontspec, pdfLaTeX does not)
- Look carried by: preamble (published kernel `book` class plus geometry, fontspec, fancyhdr and hyperref settings in the preamble, main.tex:1-17; the zip has no class or style file)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes (49 lines, all), zip-local classes and styles none present (the zip holds only main.tex and README.md)

## Verdict
yes. The whole template is one 49-line `main.tex` on the kernel `book` class: a 6x9 in geometry, a fontspec main font, microtype, one named colour, a fancyhdr running head, and default `\chapter`/`\section`/`\tableofcontents`/`quote`/`itemize` constructs. Every component maps to an existing lib way with parameters, there is no `\newcommand`, `\def`, environment, counter or class file defined in the zip, and no artwork. The README mentions a Pandoc/XeLaTeX workflow from an upstream project, but states the zip does not bundle upstream scripts and the sample is a directly compilable LaTeX file (README.md:3), so nothing outside TeX is needed to produce it.

## Blockers
none

## Class setting
- Class: `class.book` options: `11pt`, `oneside` (main.tex:1)
- Class-native vocabulary used: `\frontmatter` (main.tex:22), `\mainmatter` (main.tex:28), `\backmatter` (main.tex:46), `\chapter` and starred `\chapter*` (main.tex:25, 29, 36, 47), `\maketitle` as a title page (main.tex:23)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.book` | 11pt, oneside |
| paper size, point size, sides | main.tex:1 | `page.class-options` | 11pt, oneside (the paper size itself is set by geometry, next row) |
| page geometry | main.tex:4 | `page.geometry` | paperwidth=6in, paperheight=9in, top=.82in, bottom=.78in, inner=.9in, outer=.68in, headheight=14pt |
| main text font | main.tex:5-6 | `font.fontspec` | `\setmainfont{Latin Modern Roman}` |
| microtypography | main.tex:7 | `sp.microtype` | package loaded with default options |
| colour | main.tex:8, 11 | `color.xcolor` | `\definecolor{accent}{HTML}{315A72}` |
| link colours and metadata options | main.tex:10, 12 | `meta.hyperref` | colorlinks=true, linkcolor=accent, urlcolor=accent |
| running head | main.tex:9, 13 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}` clears all fields |
| running head fields | main.tex:14-16 | `hf.fancyhdr` | `\fancyhead[LE,RO]{\small\thepage}`, `\fancyhead[LO]{\small\itshape Build Notes}`, `\fancyhead[RE]{\small\itshape Your Name}` (no footer fields) |
| head rule | main.tex:17 | `hf.fancyhdr` | `\renewcommand{\headrulewidth}{0pt}` (fancyhdr's own rule-width parameter, not a new macro) |
| head font size and shape | main.tex:14-16 | `font.size-commands`, `mark.kernel` | `\small` size switch; `\itshape` kernel font-shape switch |
| title, subtitle, author, date | main.tex:18-20 | `front.maketitle` | `\title{Build Notes\\[.4em]\large ...}`, `\author`, `\date{}` (empty date) |
| subtitle line break and size | main.tex:18 | `sp.manual-space`, `font.size-commands` | `\\[.4em]` line break with extra space; `\large` |
| title page | main.tex:23 | `front.maketitle`, `hf.pagestyle-kernel` | `\maketitle` in `\frontmatter`, then `\thispagestyle{empty}` |
| front, main, back matter | main.tex:22, 28, 46 | `front.class-native` | `\frontmatter`, `\mainmatter`, `\backmatter` (the book class switches page-number style and chapter numbering) |
| page flow | main.tex:24 | `pg.break` | `\cleardoublepage` after the title page |
| chapter and section headings | main.tex:25, 29, 31, 36, 38, 47 | `head.kernel` | `\chapter*`, `\chapter`, `\section`; book defaults, no `\renewcommand`, no `titlesec` |
| contents | main.tex:27 | `toc.kernel` | `\tableofcontents`, default depth, placed after an unnumbered front chapter |
| block quotation | main.tex:33-35 | `quote.kernel`, `sp.ragged` | `quote` environment; `\raggedright` inside it |
| bulleted list | main.tex:39-45 | `list.kernel` | `itemize`, five `\item` entries |

Not used by the sample: bibliography, index, floats, tables, captions, math, theorems, code, footnotes, abstract, appendix, cross-references. No heading, list or caption restyling.

## Bespoke code
none. The only definitions are `\definecolor` (main.tex:11, `color.xcolor`) and `\renewcommand{\headrulewidth}{0pt}` (main.tex:17, a fancyhdr parameter, `hf.fancyhdr`). A grep of main.tex finds no `\newcommand`, `\def`, `\newenvironment`, `\newcounter`, `\newif`, `\RequirePackage`, `\input` or shell escape.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- README.md:3 says the starter is based on an upstream Pandoc/XeLaTeX workflow (`vpuna/markdown-to-book`, MIT). None of that is in the zip, and main.tex does not call Pandoc, a Makefile or a script; the prose at main.tex:26 and 30 only describes the workflow and is content.
- No text addressed to an AI was found in either file.
- Missing assets: none (Latin Modern Roman ships with TeX distributions; no images included).
