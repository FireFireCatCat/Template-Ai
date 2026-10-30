yes

# 0845-sullivan-business-report: Sullivan Business Report

- Unverified: read from the source, not compiled.
- Source: Source/0845-sullivan-business-report/ (origin: https://latextemplates.com/downloads/sullivan-business-report.zip; licence: "N/A — original starter, no upstream package" per the manifest, so not established)
- Kind: report
- Lib: v6
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (kernel `article` with default look; colour, headings, running head, margins and list indents are set by published packages in main.tex:1-19)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is one 113-line `main.tex` on the unmodified kernel `article` class; it holds no zip-local `.cls`, `.sty` or other style file. The look comes from published packages (`geometry`, `titlesec`, `xcolor`, `fancyhdr`, `enumitem`, `booktabs`) set by declarative options, and every component maps to an existing lib way. There is no `\newcommand`, `\def`, environment, counter, conditional or drawing, so there is no bespoke code, no `ART` and no `EXTERNAL`. No text or font package is loaded, so the text face is the class default (Computer Modern).

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (main.tex:1). The class is the LaTeX base class, not bundled in the zip; its source was not read.
- Class-native vocabulary used: `titlepage` environment (main.tex:23-38), `\tableofcontents` (main.tex:40), `\section` and `\subsection` (main.tex:43, 72), `table`, `tabular`, `\caption` (main.tex:54-68), `itemize` and `enumerate` (main.tex:90, 104). No `\maketitle` and no `abstract` environment.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 11pt, a4paper |
| paper and base size | main.tex:1 | `page.class-options` | a4paper, 11pt |
| page geometry | main.tex:3 | `page.geometry` | margin=2.5cm |
| colour definition | main.tex:7, 11 | `color.xcolor` | `\definecolor{reportblue}{RGB}{25,55,95}`; used by `\color{reportblue}` at main.tex:12, 13, 26 |
| section heading | main.tex:6, 12 | `head.titlesec` | `\titleformat{\section}{\Large\bfseries\color{reportblue}}{\thesection}{1em}{}` (shape omitted, numbering label `\thesection`, label separation 1em, no before-code); no `\titlespacing` in the file |
| subsection heading | main.tex:13 | `head.titlesec` | `\titleformat{\subsection}{\large\bfseries\color{reportblue}}{\thesubsection}{1em}{}`; no `\titlespacing` |
| heading font sizes | main.tex:12, 13 | `font.size-commands` | `\Large` (section), `\large` (subsection) |
| heading font switch | main.tex:12, 13 | `mark.kernel` | `\bfseries` |
| running head, page style | main.tex:8, 15-19 | `hf.fancyhdr` | `\pagestyle{fancy}`; `\fancyhf{}` clears head and foot; `\lhead{\small Quarterly Operations Review --- Confidential}`; `\rhead{\small\thepage}`; `\renewcommand{\headrulewidth}{0.4pt}`; foot left empty |
| running head font size | main.tex:17, 18 | `font.size-commands` | `\small` |
| title page | main.tex:23-38 | `front.titlepage-env` | `titlepage` environment laid by hand: centred stack of title, division, report title, two names, `\vfill`, date and a confidentiality line |
| title page alignment | main.tex:24 | `sp.ragged` | `\centering` |
| title page spacing | main.tex:25, 27, 29, 31, 33, 35 | `sp.manual-space` | `\vspace*{2cm}`, `\vspace{0.3cm}`, `\vspace{2.5cm}`, `\vspace{2cm}`, `\vfill` |
| title page sizes | main.tex:26, 28, 30, 32, 34, 36, 37 | `font.size-commands` | `\Large`, `\large`, `\huge`, `\large`, `\large`, `\large`, `\small` |
| title page font switch and colour | main.tex:26, 30 | `mark.kernel`, `color.xcolor` | `\bfseries`; `\color{reportblue}` on the first line (main.tex:26 only); `\today` at main.tex:36 is the kernel date (content) |
| contents list | main.tex:40 | `toc.kernel` | `\tableofcontents`; no `tocloft` or `titletoc`, no `hyperref` |
| page break | main.tex:41 | `pg.break` | `\newpage` after the contents |
| table float | main.tex:54-55, 57-68 | `tbl.tabular` | `table[h]`, `\centering`, `tabular{lrrr}` (column spec, a value) |
| table rules | main.tex:4, 58, 60, 66 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule`, no options |
| table caption | main.tex:56 | `cap.kernel` | `\caption` above the tabular, no `caption` package |
| graphics package | main.tex:5 | `fig.graphicx` | `\usepackage{graphicx}` only; no `\includegraphics` or `figure` in the sample |
| bullet list | main.tex:9, 90-100 | `list.kernel`, `list.enumitem` | `itemize[leftmargin=1.4em]`, two items |
| numbered list | main.tex:104-111 | `list.kernel`, `list.enumitem` | `enumerate[leftmargin=1.4em]`, two items |
| run-in bold lead words | main.tex:91, 96 | `mark.kernel` | `\textbf{...}` |
| inline maths | main.tex:61-65, 84 | `math.kernel` | `$-6.2\%$`, `$+0.2$pp`, `$\times$`: plain kernel inline maths, content-level |

## Bespoke code
none. The only redefinition is `\renewcommand{\headrulewidth}{0.4pt}` (main.tex:19), the documented length parameter of `fancyhdr`, so reducible to `hf.fancyhdr`. A grep for `\newcommand`, `\def`, `\newenvironment`, `\newcounter` and `\if` finds nothing else in the zip.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Zip contents: one file, `main.tex` (manifest: files=1, main=main.tex, docclass=article, local_class empty, has_sample=True).
- Nothing in the zip is addressed to an AI.
- No CTAN page was read: every package is a standard one and none is zip-local, so W1 holds without a check.
