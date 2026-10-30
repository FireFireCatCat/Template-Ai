yes

# 0377-generic-homework-template: Generic Homework Template

- Unverified: read from the source, not compiled.
- Source: Source/0377-generic-homework-template/ (origin: https://latextemplates.com/downloads/generic-homework-template.zip; licence: MIT)
- Kind: assignment
- Lib: v4
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (stock `article` at 11pt; everything that gives the look is in the sample's own preamble, main.tex:2-68; the zip has no .cls or .sty)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; the zip is one 160-line file)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is a single `article` file. Its preamble loads published packages (`amsmath`, `amsthm`, `enumitem`, `fancyhdr`, `framed`, `mathtools`, `hyperref`) and defines a few `\newcommand` strings and `\newenvironment` wrappers. Every wrapper is kernel commands only (`\stepcounter`, `\vspace`, `\bf`, `\arabic`, `\hrule`, `\begin{enumerate}[...]`, `framed`), with no conditionals, loops, output routine or kernel-internal redefinition, so each reduces to lib ways with parameters. No artwork, no external tool, no unmapped component, so `yes`. This is stock-class-plus-preamble evidence; the class (`article`) was not read because it ships with TeX.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (main.tex:1). Source not read: ships with the TeX distribution.
- Class-native vocabulary used: none of the class's own (no `\maketitle`, no `abstract`, no `\section`). The sample prints its heading by hand with `center` (main.tex:72-76) and uses no sectioning command.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | `11pt` |
| paper and size | main.tex:1 | `page.class-options` | `11pt` only; no `a4paper`/`letterpaper` and no geometry: class defaults |
| encoding | main.tex:18 | `font.fontenc-t1` | `\usepackage[T1]{fontenc}`; no `inputenc`, no font package (Computer Modern default) |
| paragraph shape | main.tex:26-27 | `sp.lengths` | `\parindent`=0pt, `\parskip`=5pt plus 1pt |
| `\noindent` before the question label | main.tex:37, 45 | `sp.lengths` | a no-op under `\parindent`=0pt (main.tex:26); drops out in the reduction |
| header and footer | main.tex:17, 62-68 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\fancyhead[L]` `[C]` `[R]` with `\textbf{...}` of the macros, `\headrulewidth`=0.4pt, `\fancyfoot[C]{\thepage}` |
| first page style | main.tex:71 | `hf.pagestyle-kernel` | `\thispagestyle{plain}` |
| bold in header and labels | main.tex:37, 45, 50, 54, 64-66 | `mark.kernel` | `\textbf`, `\bf`; `\texttt` in body text at main.tex:113, 131 |
| hand-laid heading | main.tex:72-76 | `sp.ragged` | `center` environment |
| hand-laid heading size | main.tex:73 | `font.size-commands` | `\Large` on the first line |
| hand-laid heading breaks | main.tex:73-74 | `sp.manual-space` | `\\` line breaks |
| hand-laid heading date | main.tex:75 | `sp.manual-space` | kernel `\today` prints the date as text (content, no way of its own); the line sits after a `\\` break; `\maketitle` is not used |
| numbered question heading | main.tex:42-47, 78, 90, 112, 130, 153 | `num.counters` | `\newcounter{questionCounter}` (main.tex:29), `\stepcounter`, `\arabic{questionCounter}`, label string `\questiontype` = "Question" (main.tex:11) |
| question heading spacing | main.tex:36, 38, 44, 46 | `sp.manual-space` | `\vspace{.2in}`, `\vspace{0.3em}`, `\vspace{.1in}` |
| rule under question heading | main.tex:38, 46 | `sp.rule` | bare `\hrule` (default 0.4pt, full width) |
| named question heading | main.tex:33-39, 102-110 | `num.counters` | `\addtocounter{questionCounter}{1}` (it consumes a number); heading is the bold argument `#1`; same spacing and `\hrule` as above |
| forced question number | main.tex:150-152 | `num.counters` | `\setcounter{questionCounter}{7}` before the next question |
| lettered sub-parts | main.tex:49-51, 131-136 | `list.enumitem` | `enumerate[label=\textbf{(\alph*)}]` |
| numbered sub-parts | main.tex:53-55, 113-127 | `list.enumitem` | `enumerate[label=\textbf{\arabic{questionCounter}.\arabic*})]` |
| lists loaded | main.tex:14 | `list.enumitem` | `\usepackage{enumitem}`, no options |
| definition-style list | main.tex:139-146 | `list.kernel` | `description` with `\item[label:]` |
| answer boxes | main.tex:19, 81-87, 94-99, 105-109, 120-127, 138-147 | `box.mdframed` | `framed` environment (`framed` package), default `\FrameRule` and `\FrameSep`; wraps the solution text, nested lists and display maths |
| empty answer box | main.tex:57-60, 157 | `box.mdframed` | `\answerbox{2cm}` = `framed` containing only `\vspace{#1}` |
| empty answer box height | main.tex:59, 157 | `sp.manual-space` | `\vspace{2cm}` |
| display maths | main.tex:83-85, 142-144 | `math.amsmath` | `\[ ... \]`; `amsmath` loaded (main.tex:13) |
| math symbols | main.tex:13 | `math.amssymb` | `amsfonts`, `amssymb` loaded; `\Theta`, `\cup`, `\cap`, `\in` in content |
| paired delimiters | main.tex:21-24, 91-92, 116, 122 | `math.mathtools` | `\DeclarePairedDelimiter{\ceil}{\lceil}{\rceil}`, `{\floor}{\lfloor}{\rfloor}`, `{\card}{\vert}{\vert}` |
| theorem package, load only | main.tex:13 | `thm.amsthm` | `amsthm` loaded; no `\newtheorem` or `\theoremstyle` anywhere in the file |
| graphics package, load only | main.tex:15 | `fig.graphicx` | `graphicx` loaded; no `\includegraphics`, no figure |
| PDF links and metadata | main.tex:16 | `meta.hyperref` | `\usepackage{hyperref}`, default options, no `\hypersetup` |

Not present in the sample: sectioning, abstract, table of contents, floats, tables, captions, footnotes, code, bibliography, index, cross-references (no `\label` or `\ref`).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\myname` `\myemail` `\myhwtype` `\myhwnum` `\myclass` `\mylecture` `\mysection` | main.tex:2-8 | yes | `\newcommand` string aliases; inline expansion into the header fields (main.tex:64-66) and the hand-laid heading (main.tex:73-74). The values are content. |
| `\questiontype` | main.tex:11 | yes | String alias "Question"; inline expansion into the numbered heading. |
| `questionCounter` | main.tex:29 | yes | A plain kernel counter, stepped and printed with `\stepcounter` and `\arabic`, set once by `\setcounter` (main.tex:152): `num.counters`. No conditionals or arithmetic drive the printed output. |
| `partCounter` | main.tex:30, 35 | yes | Declared as a sub-counter and reset in `namedquestion`, never printed or used elsewhere; dead code that drops out. |
| `numedquestion` | main.tex:42-47 | yes | `\stepcounter{questionCounter}`, `\vspace{.2in}`, `{\bf Question \arabic{questionCounter}.}`, `\vspace{0.3em}`, `\hrule`, `\vspace{.1in}`: `num.counters` + `sp.manual-space` + `mark.kernel` + `sp.rule`. All kernel; no body-end code. Alternative: the same spacing and bold head through `thm.amsthm` `\newtheoremstyle` plus `\newtheorem`, with the rule from `sp.rule`. |
| `namedquestion` | main.tex:33-39 | yes | One string argument; same composition, with `\addtocounter{questionCounter}{1}` in place of `\stepcounter` and the bold argument in place of the numbered label. |
| `alphaparts` | main.tex:49-51 | yes | Wrapper around `enumerate[label=\textbf{(\alph*)}]`; expands inline to one `list.enumitem` environment. |
| `arabicparts` | main.tex:53-55 | yes | Wrapper around `enumerate[label=\textbf{\arabic{questionCounter}.\arabic*})]`; the label refers to the kernel counter, a string parameter of `list.enumitem`. |
| `\answerbox{h}` | main.tex:57-60 | yes | `framed` containing `\vspace{h}`: `box.mdframed` + `sp.manual-space`. |
| `\ceil` `\floor` `\card` | main.tex:22-24 | yes | `mathtools` `\DeclarePairedDelimiter`: `math.mathtools`. |

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
