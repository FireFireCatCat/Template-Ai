yes

# 0352-prace-research-infrastructure-white-pape: Research Infrastructure White Paper

- Unverified: read from the source, not compiled.
- Source: Source/0352-prace-research-infrastructure-white-pape/ (origin: https://latextemplates.com/downloads/prace-whitepaper.zip; licence: not established (manifest says UNKNOWN; README.md:8 says upstream licence was not established))
- Kind: report (a consortium white-paper starter)
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:10 says "Compile with pdfLaTeX"; the sample loads only pdfTeX-safe packages, main.tex:2-3)
- Look carried by: preamble (kernel `article` loaded unchanged; the look is the sample's own 5 preamble lines plus a hand-laid cover, main.tex:1-10)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip holds two files, `main.tex` (33 lines) and `README.md`; there is no `.cls`, `.sty` or other zip-local code. Every construct is a kernel command or a published package (`article`, `geometry`, `fancyhdr`, `enumitem`, `xcolor`, `booktabs`, `tabularx`, `hyperref`, `lmodern`), with no `\newcommand`, `\def`, counter or environment definition. The cover page is a kernel `titlepage` with two `\rule`s, `\vspace`/`\vfill` and size switches in one colour; no TikZ or picture drawing is used, so there is no `ART` blocker.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (main.tex:1)
- Class-native vocabulary used: `\title` `\author` `\date` are declared (main.tex:6) but `\maketitle` is never called; `\section` and `\section*` (main.tex:11,14,17,22,26,30); kernel `titlepage` (main.tex:7-10). No `abstract` environment, no bibliography.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 11pt, a4paper |
| paper size and base font size | main.tex:1 | `page.class-options` | a4paper, 11pt |
| page geometry | main.tex:2 | `page.geometry` | margin=2.35cm |
| font encoding | main.tex:2 | `font.fontenc-t1` | `\usepackage[T1]{fontenc}` |
| text font | main.tex:2 | `font.lmodern` | `\usepackage{lmodern}` (no other family set) |
| colour definition and use | main.tex:3,4,7,10 | `color.xcolor` | `\definecolor{prace}{HTML}{0F766E}`; `\color{prace}` opens the cover (7) and is repeated before the closing rule (10) |
| link style | main.tex:3 | `meta.hyperref` | option `hidelinks`; no `\hypersetup` |
| running header | main.tex:4,5 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}` (all fields cleared), `\lhead{Research Infrastructure White Paper}`, `\rhead{\thepage}`, `\renewcommand{\headrulewidth}{.4pt}`; foot left empty |
| title metadata declared | main.tex:6 | `front.maketitle` | `\title{Research Infrastructure White Paper}`, `\author{Consortium or project name}`, `\date{\today}`; nothing prints them because `\maketitle` is absent |
| cover page | main.tex:7-10 | `front.titlepage-env` | `titlepage` environment, whole cover in colour `prace`; title lines and a metadata table inside |
| cover top and bottom rules | main.tex:7,10 | `sp.rule` | `\rule{\textwidth}{2pt}` twice, coloured by the surrounding `\color{prace}` |
| cover vertical spacing | main.tex:7,8,10 | `sp.manual-space` | `\vspace{1.3cm}` (twice), `\vfill` |
| cover title sizes | main.tex:8 | `font.size-commands` | `\Huge` (title), `\Large` (subtitle) |
| cover title weight | main.tex:8 | `mark.kernel` | `\bfseries` |
| cover metadata table | main.tex:9 | `tbl.tabular` | `tabular` with `{@{}ll@{}}`, three rows (Document, Lead, Version) |
| headings | main.tex:11,14,17,22,26,30 | `head.kernel` | stock `\section` and `\section*`, no `\renewcommand` of format, no `titlesec` |
| section numbering | main.tex:11,14 | `head.kernel` | default numbering; the starred first section is unnumbered |
| enumerated list | main.tex:23-25 | `list.kernel` | `enumerate` with three `\item` |
| list spacing | main.tex:5 | `list.enumitem` | `\setlist{itemsep=2pt,topsep=3pt}` (global, all list types) |
| service table | main.tex:18-21 | `tbl.tabularx` | `tabularx{\textwidth}{@{}lXll@{}}`, 4 columns, one `X` column; not in a float, no caption |
| table rules | main.tex:18,21 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |

Not present in the sample: abstract, table of contents, footnotes, math, theorems, figures, captions, code, boxes, bibliography, index, cross-references. Page numbers use the class default (arabic), shown only through `\rhead{\thepage}`.

## Bespoke code
none. A grep-level read of `main.tex` finds no `\newcommand`, `\renewcommand` of a macro body (the one `\renewcommand` at main.tex:5 sets the `fancyhdr` length `\headrulewidth`), `\def`, `\newenvironment`, `\newcounter` or conditional.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
