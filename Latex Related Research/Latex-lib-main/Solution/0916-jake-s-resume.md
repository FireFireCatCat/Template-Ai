yes

# 0916-jake-s-resume: Jake's Resume

- Unverified: read from the source, not compiled.
- Source: Source/0916-jake-s-resume/ (origin: https://latextemplates.com/downloads/jakes-resume.zip; licence: MIT, stated at main.tex:2)
- Kind: cv
- Lib: v6
- Engine: pdfLaTeX-compatible (`\pdfgentounicode` and `\input{glyphtounicode}` are pdfTeX features, main.tex:19, main.tex:46)
- Look carried by: preamble (the zip holds one file, `main.tex`; the look is `article` plus the preamble at main.tex:8-78: margins, `titlesec` section rule, `enumitem` lists, `\newcommand` entry wrappers)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes (all 162 lines), zip-local classes and styles none present (the zip has no `.cls`, `.sty` or other TeX support file)

## Verdict
Yes. The class is the kernel `article` with two options, and every preamble line loads a published package or sets a kernel or package parameter. The eight zip-local macros (`\resumeItem`, `\resumeSubheading`, `\resumeProjectHeading`, `\resumeSubItem`, the two list-start macros and the two list-end macros) are plain `\newcommand` wrappers over `itemize`, `tabular*`, font switches and `\vspace`. They have no counters, conditionals, `\def`s or output-routine code and reduce by inline expansion. There is no TikZ or other artwork and no external tool.

## Blockers
none

## Class setting
- Class: `class.article` options: `letterpaper`, `11pt` (main.tex:6)
- Class-native vocabulary used: none. The sample never calls `\title`, `\author`, `\maketitle`, `abstract` or `thebibliography`; its heading block is hand-laid (main.tex:86-91). Only `\section` (main.tex:94, main.tex:102, main.tex:133, main.tex:151) and `itemize` are used.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:6 | `class.article` | `letterpaper,11pt` |
| paper and point size | main.tex:6 | `page.class-options` | `letterpaper`, `11pt` |
| base page margins | main.tex:9 | `page.vmargin` | `\usepackage[empty]{fullpage}` (its page-style option `empty`; the later `\pagestyle{fancy}` at main.tex:21 overrides it). The fullpage source was not read, so its base margin values are not recorded |
| margin adjustment | main.tex:28-32 | `page.setlength` | `\addtolength`: `\oddsidemargin` -0.5in, `\evensidemargin` -0.5in, `\textwidth` +1in, `\topmargin` -.5in, `\textheight` +1.0in; emitted after the fullpage line because they add to its values |
| header and footer | main.tex:16, main.tex:21-25 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\fancyfoot{}`, `\headrulewidth` 0pt, `\footrulewidth` 0pt (no header, no footer, no page number, no rules) |
| page-bottom flow | main.tex:36 | `pg.flush` | `\raggedbottom` |
| paragraph shape | main.tex:37 | `sp.ragged` | `\raggedright` globally |
| table column padding | main.tex:38 | `sp.lengths` | `\setlength{\tabcolsep}{0in}` (a raw kernel length parameter, as `\itemsep`) |
| section headings | main.tex:10, main.tex:41-43, main.tex:94 | `head.titlesec` | `\titleformat{\section}` format `\vspace{-4pt}\scshape\raggedright\large`, label `{}`, sep `0em`, before-code `{}`, after-code `[\color{black}\titlerule \vspace{-5pt}]`; no `\titlespacing` |
| section commands | main.tex:94, main.tex:102, main.tex:133, main.tex:151 | `head.kernel` | four unnumbered-looking `\section{..}` (the label field is empty, so no number prints) |
| heading format pieces | main.tex:42-43 | `mark.kernel`, `font.size-commands`, `sp.manual-space`, `color.color` | `\scshape`; `\large`; `\vspace{-4pt}`, `\vspace{-5pt}`; `\color{black}` |
| colour package | main.tex:12 | `color.color` | `\usepackage[usenames,dvipsnames]{color}`; the only colour used is `black` (main.tex:43) |
| lists | main.tex:14, main.tex:75, main.tex:152 | `list.enumitem` | `\begin{itemize}[leftmargin=0.15in, label={}]` (entry list, main.tex:75; skills list, main.tex:152); bullet lists use a plain `itemize` (main.tex:77) |
| bullet label, level 2 | main.tex:73 | `list.kernel` | `\renewcommand\labelitemii{$\vcenter{\hbox{\tiny$\bullet$}}$}`; used by the plain `itemize` nested inside the entry list (main.tex:108 inside main.tex:103-130) |
| entry rows | main.tex:56-62, main.tex:64-69 | `tbl.tabular` | `tabular*` (kernel) width `0.97\textwidth`, column spec `l@{\extracolsep{\fill}}r`, position `[t]` for the subheading (main.tex:58) and none for the project heading (main.tex:66); rows: `\textbf{#1} & #2 \\` and `\textit{\small#3} & \textit{\small #4} \\` (main.tex:59-60) |
| entry row text | main.tex:59-60, main.tex:67 | `mark.kernel`, `font.size-commands` | `\textbf`, `\textit`, `\small` |
| entry spacing | main.tex:57, main.tex:61, main.tex:68, main.tex:52, main.tex:78 | `sp.manual-space` | `\vspace{-2pt}` before the subheading item, `\vspace{-7pt}` after the tabular, `\vspace{-2pt}` after item text, `\vspace{-5pt}` after the bullet list |
| bullet item | main.tex:50-54 | `list.kernel`, `font.size-commands` | `\item` then `\small{...}` |
| heading block (name and contacts) | main.tex:86-91 | `sp.ragged`, `mark.kernel`, `font.size-commands`, `sp.manual-space` | `center` environment; `\textbf{\Huge \scshape ...}`, `\\ \vspace{1pt}`, `\small`; separators are the literal `$|$` (text content); not `front.maketitle` (no `\maketitle`) |
| contact links | main.tex:88-90 | `xref.hyperref` | `\href{mailto:...}{...}` and `\href{https://...}{...}` (hyperref's own link command; the target and text are content) |
| link text underline | main.tex:88-90 | `mark.ulem` | kernel `\underline{...}` around the link text (the same type as ulem's underline) |
| hyperref options | main.tex:15 | `meta.hyperref` | `hidelinks` |
| URL style | main.tex:34 | `meta.url` | `\urlstyle{same}` |
| language | main.tex:17 | `lang.babel` | `english` |
| ATS-parsable PDF text | main.tex:19, main.tex:46 | `meta.glyphtounicode` | `\input{glyphtounicode}`, `\pdfgentounicode=1` |
| skills block | main.tex:151-159 | `list.enumitem`, `mark.kernel`, `font.size-commands`, `sp.manual-space` | `itemize[leftmargin=0.15in, label={}]`, `\small{\item{...}}`, `\textbf{Languages}`, `\\` line breaks |
| loaded, never used | main.tex:8 | `math.amssymb` | `\usepackage{latexsym}` (LaTeX base extra math symbols; no symbol is called) |
| loaded, never used | main.tex:11 | `font.icons` | `\usepackage{marvosym}`; no glyph command appears in the body |
| loaded, never used | main.tex:13 | `code.verbatim` | `\usepackage{verbatim}`; no `verbatim`, `\verb` or `comment` appears |
| loaded, never used | main.tex:18 | `tbl.tabularx` | `\usepackage{tabularx}`; the body uses the kernel `tabular*`, not `tabularx` |

Not defined or used: fonts (no font package and no `\familydefault`, so the text keeps the class default), floats, captions, tables of contents, theorems, equations, code, bibliography, index, footnotes, appendices.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\resumeItem{#1}` | main.tex:50-54 | yes | inline: `\item` + `\small` + text + `\vspace{-2pt}` (`list.kernel`, `font.size-commands`, `sp.manual-space`) |
| `\resumeSubheading{#1}{#2}{#3}{#4}` | main.tex:56-62 | yes | inline: `\vspace{-2pt}\item` + `tabular*` as in the table (`tbl.tabular`, `mark.kernel`, `font.size-commands`, `sp.manual-space`) |
| `\resumeProjectHeading{#1}{#2}` | main.tex:64-69 | yes | inline: `\item` + one-row `tabular*` + `\vspace{-7pt}` |
| `\resumeSubItem{#1}` | main.tex:71 | yes, and unused in the body | `\resumeItem` expansion + `\vspace{-4pt}` |
| `\resumeSubHeadingListStart` and `End` | main.tex:75-76 | yes | `\begin{itemize}[leftmargin=0.15in, label={}]` and `\end{itemize}` (`list.enumitem`); the pair is balanced at every use (main.tex:95-99, main.tex:103-130, main.tex:134-148) |
| `\resumeItemListStart` and `End` | main.tex:77-78 | yes | `\begin{itemize}` and `\end{itemize}\vspace{-5pt}` (`list.kernel`, `sp.manual-space`) |
| `\renewcommand\labelitemii` | main.tex:73 | yes | a kernel label macro whose value is one small bullet glyph centred on the math axis (`\vcenter{\hbox{\tiny$\bullet$}}`); a fixed string, with no counter, conditional or loop. Written as the label parameter of `list.kernel` |
| `\titleformat` call | main.tex:41-43 | yes | a declarative `head.titlesec` call; its format and after-code arguments hold only kernel font switches, `\vspace`, `\color` and `\titlerule` |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Mapping choices for a reviewer: `\href` filed under `xref.hyperref` (hyperref's link command, same package as `meta.hyperref`); kernel `\underline` filed under `mark.ulem` (same type as ulem underline; the lib has no kernel-underline line); `latexsym` under `math.amssymb` (an extra-math-symbol package; it is loaded and never called, so the verdict does not rest on it); `\tabcolsep` under `sp.lengths` (a raw kernel length parameter).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
