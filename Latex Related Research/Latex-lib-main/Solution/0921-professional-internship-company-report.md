yes

# 0921-professional-internship-company-report: Professional Internship & Company Report

- Unverified: read from the source, not compiled.
- Source: Source/0921-professional-internship-company-report/ (origin: https://latextemplates.com/downloads/professional-internship-company-report.zip; licence: MIT)
- Kind: report
- Lib: v6 (the snapshot read)
- Engine: pdfLaTeX-compatible (no fontenc or inputenc is loaded; the curly apostrophes U+2019 at main.tex:6 and main.tex:10 rely on the UTF-8 default of LaTeX 2018 or later)
- Look carried by: preamble (the zip is one 10-line `main.tex`; the kernel `report` class supplies the default chapter, section, contents and appendix look unchanged, and the sample's preamble and body wrappers set page margins, running head, colour, list and table looks)
- Class origin: tex-distribution-unbundled (kernel `report`, LaTeX base; not in the zip, source not read)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip holds one file, `main.tex`, with no zip-local `.cls`, `.sty` or macro definition. Every construct is a kernel command or a published package (`geometry`, `fancyhdr`, `xcolor`, `enumitem`, `booktabs`, `tabularx`) loaded with plain options, and the hand-laid title page is a kernel `titlepage` environment with spacing, size and colour switches and one `tabular`. An emitter could write this preamble and these body wrappers from lib ways alone. There is no artwork, no external tool and no content that a lib way cannot hold.

## Blockers
none

## Class setting
- Class: `class.report` options: `11pt`, `a4paper` (main.tex:1)
- Class-native vocabulary used: `\chapter` (main.tex:5, 6, 7, 8, 9, 10), `\section` (main.tex:6, 8), `titlepage` environment (main.tex:4), `\tableofcontents` (main.tex:5), `\appendix` followed by `\chapter` (main.tex:10). No `\maketitle`, no `abstract` environment, no `\bibliography`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.report` | options `11pt,a4paper` |
| paper and base size | main.tex:1 | `page.class-options` | `a4paper`, `11pt` |
| page geometry | main.tex:2 | `page.geometry` | `\usepackage[margin=2.4cm]{geometry}`, one margin for all four sides |
| running head | main.tex:2, main.tex:3 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}` (clears all fields, so the footer is empty), `\lhead{Orchard Analytics \| Project report}`, `\rhead{\thepage}`, `\renewcommand{\headrulewidth}{.4pt}` |
| colour definition | main.tex:2, main.tex:3 | `color.xcolor` | `\usepackage[table]{xcolor}`, `\definecolor{blue}{HTML}{244A73}` (redefines the name `blue`) |
| coloured title text | main.tex:4 | `color.xcolor` | `{\color{blue}\Huge\bfseries ORCHARD ANALYTICS\par}` |
| table colour option | main.tex:2 | `tbl.colortbl` | `table` option of `xcolor` only; no `\rowcolor`, `\cellcolor`, `\columncolor` or `\arrayrulecolor` is called anywhere in main.tex |
| title page | main.tex:4 | `front.titlepage-env` | `\begin{titlepage}...\end{titlepage}`, hand-laid: no `\title` or `\maketitle` |
| title page centring | main.tex:4 | `sp.ragged` | `\centering` as first command in `titlepage` |
| title page vertical spacing | main.tex:4 | `sp.manual-space` | `\vspace*{2cm}`, `\vspace{.5cm}`, `\vspace{2cm}`, two `\vfill` |
| title page type sizes | main.tex:4 | `font.size-commands` | `\Huge` (company name), `\Large` (subtitle), `\huge` (project title), `\small` (closing note); each in a group closed by `\par` |
| title page bold | main.tex:4 | `mark.kernel` | `\bfseries` inside the colour group |
| title page author block | main.tex:4 | `tbl.tabular` | `\begin{tabular}{rl}` with four rows (Author, Placement, Supervisor, Date) and `\\` row ends |
| table of contents | main.tex:5 | `toc.kernel` | `\tableofcontents`, class defaults, no depth set |
| chapter headings | main.tex:5, 6, 7, 8, 9, 10 | `head.kernel` | `\chapter{...}` with report's default "Chapter N" look; no `\titleformat`, no `\renewcommand` of heading format |
| section headings | main.tex:6, 8 | `head.kernel` | `\section{...}` default look |
| appendix | main.tex:10 | `num.appendix` | `\appendix` before `\chapter{Handover checklist}` |
| bulleted lists | main.tex:6, main.tex:10 | `list.kernel` | `itemize` |
| numbered list | main.tex:8 | `list.kernel` | `enumerate` |
| list spacing and margins | main.tex:2, main.tex:6, 8, 10 | `list.enumitem` | `\usepackage{enumitem}`; `[leftmargin=*]` on every `itemize` (main.tex:6, 10) and `enumerate` (main.tex:8) |
| main table packages | main.tex:2 | `tbl.booktabs` | `\usepackage{booktabs}` |
| main table | main.tex:7 | `tbl.tabularx` | `\begin{tabularx}{\textwidth}{p{.18\textwidth}p{.3\textwidth}X}`; two fixed-width `p` columns and one `X` column; no float, no `\caption` |
| main table fixed-width columns | main.tex:7 | `tbl.tabular` | `p{.18\textwidth}`, `p{.3\textwidth}` column types of `array`, rows ended by `\\` |
| main table rules | main.tex:7 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` (default rule widths) |
| inline emphasis | main.tex:9 | `mark.kernel` | `\textbf{Keep:}`, `\textbf{Improve:}` |
| fonts | none | none | no font package, no `\renewcommand\familydefault`; the default Computer Modern of `report` |
| cross-references, bibliography, index, footnotes, floats, captions, math | none | none | none used or defined in main.tex |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand{\headrulewidth}{.4pt}` | main.tex:3 | yes | the documented `fancyhdr` rule-width parameter: `hf.fancyhdr` with value `.4pt` |
| `\definecolor{blue}{HTML}{244A73}` | main.tex:3 | yes | an `xcolor` declaration: `color.xcolor`, model `HTML`, value `244A73` |

Checked by search: main.tex has no `\newcommand`, `\def`, `\let`, `\newenvironment`, `\newcounter`, `\newif`, `\input`, `\include` or `\newtheorem`. The only `newcommand` match is the `\renewcommand` above.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
