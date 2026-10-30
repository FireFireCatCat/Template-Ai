yes

# 0143-canada-study-permit-cover-letter: Canada Study Permit Cover Letter

- Unverified: read from the source, not compiled.
- Source: Source/0143-canada-study-permit-cover-letter/ (origin: https://latextemplates.com/downloads/canada-study-permit-cover-letter.zip; licence: Apache-2.0)
- Kind: letter
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:8 says compile with PDFLaTeX; only kernel and pdfTeX-era packages are loaded, main.tex:1-6)
- Look carried by: preamble (a plain `article` with six published packages; the whole look is the preamble at main.tex:1-10 plus a hand-set letterhead at main.tex:12-14)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip is one 52-line `main.tex` on kernel `article`, with no zip-local class or style. Every component is a published package or kernel command: `geometry`, `fontenc`/`inputenc`, `lmodern`, `xcolor`, `tabularx`, `enumitem`, `hyperref`, plus kernel spacing, rules, font switches and `\section*`. The only bespoke item, `\newcommand{\field}`, is a `\textbf` plus `\par` alias and reduces fully. No artwork: the "banner" is a coloured `\rule`. Content is placeholder text in brackets.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (main.tex:1). Its source was not read (it ships with the TeX distribution, not in the zip).
- Class-native vocabulary used: `\section*` (unnumbered sectioning, main.tex:29, main.tex:34), `itemize`, kernel font switches; none of `\maketitle`, `abstract`, `\title`, `\author` is used. The class default `plain` page style is left unchanged (no `\pagestyle` anywhere).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | `11pt` |
| type size via class option | main.tex:1 | `page.class-options` | `11pt` (paper size comes from `geometry`, next row) |
| page geometry | main.tex:2 | `page.geometry` | `a4paper`, `margin=25mm` |
| encoding | main.tex:3-4 | `font.fontenc-t1` | `fontenc` option `T1`; `inputenc` option `utf8` |
| text and math face | main.tex:5 | `font.lmodern` | `lmodern`, no options |
| colour definition | main.tex:6-7 | `color.xcolor` | `\usepackage{xcolor}` no options; `\definecolor{maple}{HTML}{B3261E}` |
| link colouring | main.tex:6, main.tex:8 | `meta.hyperref` | `\usepackage{hyperref}` (loaded last in the list); `\hypersetup{colorlinks=true,urlcolor=maple}` |
| paragraph spacing | main.tex:9 | `sp.lengths` | `\parindent=0pt`, `\parskip=7pt` |
| letterhead title line | main.tex:12 | `font.size-commands`; `mark.kernel`; `color.xcolor` | `\LARGE`; `\bfseries`; `\color{maple}` in a group, then `\par`; text "Study Permit Application" is content |
| letterhead rule | main.tex:13 | `sp.rule`; `color.xcolor` | `\rule{\linewidth}{1.2pt}` in `{\color{maple}...}` |
| manual vertical gaps | main.tex:14, main.tex:19, main.tex:48 | `sp.manual-space` | `\vspace{6pt}`, `\vspace{10pt}`, `\vspace{12pt}` |
| reference and date line | main.tex:15-18 | `tbl.tabularx` | `\begin{tabularx}{\linewidth}{@{}Xr@{}}`: one `X` column (left) and one `r` column (right), `@{}` on both outer edges, rows ended with `\\`, no rules; `\today` in a cell (main.tex:16) is the kernel date, treated as cell content |
| recipient field | main.tex:10, main.tex:20 | `mark.kernel` | `\field{To}{...}` expands to `\textbf{To:} ...\par` (see Bespoke code) |
| subject line | main.tex:21 | `mark.kernel` | `\textbf{Re: ...}` |
| letter structure (letterhead, recipient, salutation, closing, signature block) | main.tex:12-23, main.tex:48-51 | `ltr.opening` | kernel-only, hand-set: no `\opening`, `\closing` or letter class; the salutation and sign-off are typed text, the signature block uses `\\` line breaks (main.tex:49-51). The visible look is fully covered by the rows above and below, so this row adds no extra parameter |
| unnumbered sections | main.tex:29, main.tex:34 | `head.kernel` | `\section*{Study plan}`, `\section*{Funds and supporting documents}`; no `titlesec`, kernel look |
| inline emphasis | main.tex:37 | `mark.kernel` | `\textbf{...}` |
| bullet list | main.tex:6, main.tex:39-43 | `list.enumitem` | `itemize` with `[leftmargin=*,itemsep=2pt]` |
| signature spacing and line breaks | main.tex:48-51 | `sp.manual-space` | `\par\vspace{12pt}`; `\\`; `\quad` between e-mail and phone (main.tex:51) |
| e-mail link | main.tex:51 | `xref.hyperref` | `\href{mailto:applicant@example.org}{applicant@example.org}`; coloured by `urlcolor=maple` (main.tex:8) |

Not used (checked, nothing to map): headers and footers, page numbering, floats and captions, theorems, math, code, bibliography, index, footnotes, backgrounds, language packages.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\field}[2]{\textbf{#1:} #2\par}` | main.tex:10 (used at main.tex:20) | yes | alias of `mark.kernel` `\textbf` plus a paragraph end; an emitter writes `\textbf{To:} Visa Officer, ...\par` inline |
| colour `maple` | main.tex:7 | yes | `color.xcolor` `\definecolor{maple}{HTML}{B3261E}`, a declaration with a value |
| `\setlength` pair | main.tex:9 | yes | `sp.lengths`, two raw length assignments |
| hand-set letterhead (title line, rule, tabularx block) | main.tex:12-18 | yes | composition of `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.rule`, `sp.manual-space`, `tbl.tabularx`, as in the Component map; no `tikz`, no `picture`, no counters or conditionals |

## Content-opaque
none (the bracketed placeholders such as `[program name]` at main.tex:25 are text content; no figure, table float or drawing exists)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
