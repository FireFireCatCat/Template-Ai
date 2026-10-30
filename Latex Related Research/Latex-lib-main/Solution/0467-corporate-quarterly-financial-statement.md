yes

# 0467-corporate-quarterly-financial-statement: Corporate Quarterly Financial Statement

- Unverified: read from the source, not compiled.
- Source: Source/0467-corporate-quarterly-financial-statement/ (origin: https://latextemplates.com/downloads/corporate-quarterly-financial-statement.zip; licence: MIT per the manifest; README.md:6-9 names the upstream candidate as MIT and says the starter is original content)
- Kind: report
- Lib: v4
- Engine: pdfLaTeX-compatible (README.md:11 says to compile with PDFLaTeX; no `fontspec`, no `unicode-math`)
- Look carried by: preamble (the kernel `report` class is loaded with default heading looks; margins, header, colours and table styling are set in main.tex:2-11, the title page and tables are hand-laid in the body, main.tex:13-38)
- Class origin: tex-distribution-unbundled (kernel `report`; not in the zip, its source was not read)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The zip is a single 39-line `main.tex` plus a README: no `.cls`, `.sty` or other local file. The kernel `report` class is loaded with `11pt,a4paper`, and everything else is published packages (`geometry`, `booktabs`, `tabularx`, `longtable`, `xcolor[table]`, `enumitem`, `fancyhdr`, `hyperref`) and kernel commands. The only zip-defined macro is one `\newcolumntype`, which reduces by inline expansion. There is no TikZ, PGF or other artwork, no figure, no external tool.

## Blockers
none

## Class setting
- Class: `class.report` options: `11pt`, `a4paper` (main.tex:1)
- Class-native vocabulary used: `\chapter` and `\section` (main.tex:16,18,21,22,25,27,30,32), `titlepage` environment (main.tex:13-15). No `abstract`, no `\maketitle`, no `\tableofcontents`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.report` | `11pt`, `a4paper` |
| paper and size | main.tex:1 | `page.class-options` | `a4paper`, `11pt` |
| page geometry | main.tex:2 | `page.geometry` | `margin=2.2cm` |
| colours | main.tex:4,7 | `color.xcolor` | package option `table`; `\definecolor{ink}{HTML}{1E3348}`, `\definecolor{green}{HTML}{247A67}` (redefines xcolor's built-in `green`), `\definecolor{pale}{HTML}{EEF6F3}` |
| hyperlinks | main.tex:5,8 | `meta.hyperref` | `colorlinks=true`, `linkcolor=green`, `urlcolor=green` (the body holds no link or `\ref`, so the options matter only for links the emitter adds) |
| running header and footer | main.tex:5,9,10,11 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\lhead{Northstar Foods \| Quarterly statement}`, `\rhead{\thepage}`, `\headrulewidth=0.4pt`, `\headheight=14pt` (fancyhdr's required length; `page.setlength` would also hold it); footer empty |
| title page | main.tex:13-15 | `front.titlepage-env` | kernel `titlepage` with `\centering`, `\vspace*{2cm}`, `\vspace{0.5cm}`, `\vspace{1.7cm}`, `\vspace{1cm}`, two `\vfill`, a two-column `rl` tabular of labels (main.tex:14), a `\small` disclaimer (main.tex:15); all text is content |
| title-page type sizes and colour | main.tex:13,15 | `font.size-commands` | `\Huge\bfseries`, `\Large`, `\fontsize{32}{38}\selectfont`, `\large`, `\small` |
| title-page colour wrappers | main.tex:13 | `color.xcolor` | `{\color{ink}...}`, `{\color{green}...}` |
| bold weight | main.tex:13,29 | `mark.kernel` | `\bfseries` (title), `\textbf{Closing cash}` and `\textbf{2.4}` |
| title-page spacing and line breaks | main.tex:13,14 | `sp.manual-space` | `\vspace*`, `\vspace`, `\vfill`, `\\` |
| centring | main.tex:13,19,23,26,28 | `sp.ragged` | `\centering` on the title page; `center` environment around each tabular |
| headings | main.tex:16,18,21,22,25,27,30,32 | `head.kernel` | default `\chapter` and `\section` of `report`, no restyling, no `\titleformat` |
| body paragraphs | main.tex:17,33 | none | plain text in the class's default text face (Computer Modern; no font package loaded, no `fontenc`) |
| data tables | main.tex:20,24,26,29 | `tbl.tabular` | `tabular` with `lrrr`, `lrrr`, `lrr`, `lr` column specs; the `array` package is not loaded by name (tabularx and longtable load it as a dependency, source not read here) |
| table rules | main.tex:3,20,24,26,29,34,38 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` (also inside the longtable) |
| table row colours | main.tex:4,19,23,28 | `tbl.colortbl` | `xcolor[table]`, `\rowcolors{2}{pale}{}` before three of the four tabulars (not the balance sheet, main.tex:26) |
| long table | main.tex:3,34-38 | `tbl.longtable` | `longtable` with `@{}P{0.29\textwidth}P{0.31\textwidth}P{0.27\textwidth}@{}`; no `\caption`, no `\endhead` |
| custom column type | main.tex:6,34 | `tbl.tabular` | `\newcolumntype{P}[1]{>{\raggedright\arraybackslash}p{#1}}`, an `array` declaration; see Bespoke code |
| ragged-right cells | main.tex:6 | `sp.ragged` | `\raggedright` inside the column spec (with `\arraybackslash`) |
| `tabularx` | main.tex:3 | `tbl.tabularx` | loaded, no `tabularx` environment in the body (loaded and unused) |
| numbered list | main.tex:5,31 | `list.enumitem` | `enumerate[leftmargin=*]`, three `\item` |

No component for: front-matter `\maketitle`, abstract, contents, floats and captions (no `table`/`figure` environment, no `\caption`), maths, theorems, code, boxes, footnotes, bibliography, index, cross-references, language, fonts, backgrounds. The sample uses none of them.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcolumntype{P}[1]{>{\raggedright\arraybackslash}p{#1}}` | main.tex:6 (used main.tex:34) | yes | A column-spec alias of the `array` package. Inline it: each `P{w}` becomes `>{\raggedright\arraybackslash}p{w}` in the `tbl.longtable` column spec, with `\raggedright` held by `sp.ragged`. No logic. |
| `\definecolor` x3 (`ink`, `green`, `pale`) | main.tex:7 | yes (declarations) | `color.xcolor` named colours, HTML model |
| `\renewcommand{\headrulewidth}{0.4pt}`, `\setlength{\headheight}{14pt}` | main.tex:10,11 | yes (parameters) | `hf.fancyhdr` documented length and rule width |
| hand-laid `titlepage` | main.tex:13-15 | yes | Kernel environment filled with `sp.manual-space`, `font.size-commands`, `color.xcolor`, `mark.kernel`, `sp.ragged` and one `tbl.tabular`; no macro defined |

No `\newcommand`, `\def`, `\newenvironment`, `\newcounter`, conditional or `\input` exists in the zip (grep over main.tex: only lines 6, 7, 10, 11 are definitions).

## Content-opaque
none (the zip has no figure, no included image and no TikZ; table cell numbers and the title-page text are content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes: README.md:11 ("Compile `main.tex` with PDFLaTeX") is an instruction to a human reader, not addressed to an AI; nothing in the zip tried to instruct an agent.
