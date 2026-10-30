yes

# 0301-overleaf-physics-book-template: Physics Book Template (Overleaf, Charles Averill; packaged by latextemplates.com)

- Unverified: read from the source, not compiled.
- Source: Source/0301-overleaf-physics-book-template/ (origin: https://latextemplates.com/downloads/overleaf-physics-book-template.zip; licence: CC-BY-4.0)
- Kind: book
- Lib: v4
- Engine: pdfLaTeX-compatible (T1 + inputenc utf8 + lmodern, main.tex:2-4; README.md:5-6 says compile with pdfLaTeX)
- Look carried by: preamble (kernel `book` plus a 20-line preamble in main.tex:1-20 and a hand-laid title page in main.tex:22-31; the zip holds no .cls, .sty, .def, .cfg or .clo)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Every line of the preamble is a published package load (`geometry`, `fancyhdr`, `titlesec`, `xcolor`, `hyperref`, ...) or a kernel command, and the title page is built from kernel spacing, font-size and `\rule` commands. The zip defines no macro, environment, counter or conditional (a grep for `\newcommand`, `\def`, `\newenvironment`, `\newcounter`, `\newif` and `\makeatletter` finds none; main.tex:13 and :18 are a `\definecolor` and a `\renewcommand` that sets the fancyhdr parameter `\headrulewidth`). `tikz` and `wrapfig` are loaded but nothing is drawn or wrapped, so there is no `ART` blocker. An emitter could write this zip from lib ways alone, so `yes`; the look is carried by the preamble over a kernel class, and the zip holds no zip-local class or style code (README.md and ATTRIBUTION.txt hold no code and no text addressed to an AI).

## Blockers
none

## Class setting
- Class: `class.book` options: `11pt`, `twoside` (main.tex:1). Kernel class from the LaTeX base, not bundled in the zip; its source was not read.
- Class-native vocabulary used: `\frontmatter` (main.tex:32), `\mainmatter` (main.tex:38), `\backmatter` (main.tex:70); `\chapter` (main.tex:39, 53, 64) and `\chapter*` (main.tex:33, 71); `\section` (main.tex:40, 46, 54); `titlepage` environment (main.tex:22-31); `\tableofcontents` (main.tex:37); the marks `\leftmark` and `\rightmark` (main.tex:16-17); `\chaptername` reached through titlesec's `\chaptertitlename` (main.tex:20). Per-chapter equation numbering and roman/arabic page numbers in front/main matter are the book class's defaults (no `\numberwithin` or `\pagenumbering` call in the sample). No `abstract`, `\maketitle`, `\appendix` or bibliography is used.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.book` | 11pt, twoside |
| paper and size, sides | main.tex:1 | `page.class-options` | 11pt, twoside (no paper-size option, class default) |
| page geometry | main.tex:5 | `page.geometry` | margin=1in, bottom=1.15in |
| font encoding and input | main.tex:2-3 | `font.fontenc-t1` | fontenc `T1`; inputenc `utf8` |
| text font | main.tex:4 | `font.lmodern` | no options |
| colour definition | main.tex:9, 13 | `color.xcolor` | `\definecolor{physicsred}{HTML}{8C2F39}` |
| running head and foot | main.tex:7, 14-18 | `hf.fancyhdr` | `\pagestyle{fancy}`; `\fancyhf{}` (all fields cleared, no foot); `\fancyhead[LE]{\thepage\quad\small\nouppercase{\leftmark}}`; `\fancyhead[RO]{\small\nouppercase{\rightmark}\quad\thepage}`; `\renewcommand{\headrulewidth}{0pt}` (no head rule) |
| running head: size | main.tex:16-17 | `font.size-commands` | `\small` |
| running head: gap | main.tex:16-17 | `sp.manual-space` | `\quad` |
| chapter heading | main.tex:8, 19-20 | `head.titlesec` | `\titleformat{\chapter}[display]`; format `{\normalfont\bfseries\Huge\color{physicsred}}`; label `{\filleft\MakeUppercase{\chaptertitlename}~\thechapter}`; sep `{12pt}`; before-code `{\filright}`; no `\titlespacing` |
| chapter heading: font switches | main.tex:19 | `mark.kernel` | `\normalfont\bfseries` |
| chapter heading: size | main.tex:19 | `font.size-commands` | `\Huge` |
| chapter heading: colour | main.tex:19 | `color.xcolor` | `\color{physicsred}` |
| chapter heading: label case | main.tex:20 | `mark.case` | `\MakeUppercase{\chaptertitlename}` |
| section headings | main.tex:40, 46, 54 | `head.kernel` | class defaults (no `\titleformat` for sections, no `secnumdepth` change) |
| unnumbered chapters | main.tex:33, 71 | `head.kernel` | `\chapter*` (formatted by the same `\titleformat` above) |
| front, main and back matter | main.tex:32, 38, 70 | `class.book` | `\frontmatter` `\mainmatter` `\backmatter` (class vocabulary) |
| title page block | main.tex:22-31 | `front.titlepage-env` | `titlepage` environment hand-laid from the rows below; no `\maketitle`, no `\title` |
| title page: centring | main.tex:23 | `sp.ragged` | `\centering` |
| title page: spacing | main.tex:24, 26, 27, 28, 29, 30 | `sp.manual-space` | `\vspace*{0.8in}`, `\vspace{18pt}`, `\vspace{20pt}`, `\vfill`, `\vspace{6pt}`, `\vspace{0.5in}`, and `\\` inside the title (main.tex:25) |
| title page: type | main.tex:25, 27, 29, 30 | `font.size-commands` | `\fontsize{38}{44}\selectfont`, `\Large`, `\Large`, `\large`, `\small` |
| title page: title weight | main.tex:25 | `mark.kernel` | `\bfseries` |
| title page: coloured rule | main.tex:26 | `sp.rule` | `\rule{0.65\textwidth}{2pt}`, coloured by `\textcolor` |
| title page: rule colour | main.tex:26 | `color.xcolor` | `\textcolor{physicsred}{...}` |
| title page: date line | main.tex:30 | `front.titlepage-env` | text "First edition", kernel `\textbullet`, and `\the\year` (a TeX primitive register that prints the compile year; not defined in the zip; the emitter may write it verbatim as the date text). Content, not a macro |
| contents list | main.tex:37 | `toc.kernel` | `\tableofcontents`, no `tocloft` |
| display equations | main.tex:43-45, 49-52 | `math.amsmath` | `equation` environment, numbering as the class default |
| aligned derivation | main.tex:56-59 | `math.amsmath` | `align` environment |
| math symbols | main.tex:6 | `math.amssymb` | loaded, no options |
| mathtools | main.tex:6 | `math.mathtools` | loaded, no options; no mathtools-only command in the body (load-only) |
| quotation block | main.tex:60-63 | `quote.kernel` | `quote` environment holding `\textbf{Observation.}` |
| bold run-in label | main.tex:61 | `mark.kernel` | `\textbf` |
| problem list | main.tex:65-69 | `list.kernel` | `enumerate`, defaults, no `enumitem` |
| hyperlinks | main.tex:12 | `meta.hyperref` | `hidelinks` |
| wrapped figures | main.tex:10 | `fig.wrapfig` | loaded, no `wrapfigure` in the body (load-only) |
| TikZ | main.tex:11 | `art.tikz` | loaded, no `tikzpicture` or `\tikz` in the body; nothing drawn, so no `ART` |

Not present in the sample: abstract, `\maketitle`, theorems, figures, tables, captions, code, boxes, notes and footnotes, cross-references, bibliography, index, language packages, multi-column text, backgrounds.

## Bespoke code
none. Two lines look like definitions but are not bespoke: `\definecolor{physicsred}{HTML}{8C2F39}` (main.tex:13) is an `xcolor` declaration, and `\renewcommand{\headrulewidth}{0pt}` (main.tex:18) sets a documented `fancyhdr` parameter (`hf.fancyhdr`). `\the\year` (main.tex:30) is a TeX primitive, not zip code.

## Content-opaque
none (no figure, table, tikz picture or included image in main.tex; `wrapfig` and `tikz` are loaded and unused, main.tex:10-11). The equations (main.tex:43-59) are ordinary maths content.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
