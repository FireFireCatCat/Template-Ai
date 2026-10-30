yes

# 0878-jbhv12-resume: jbhv12/resume (ATS-oriented one-file resume, a variant of the "Jake's resume" layout)

- Unverified: read from the source, not compiled.
- Source: Source/0878-jbhv12-resume/ (origin: https://codeload.github.com/jbhv12/resume/zip/refs/heads/main; licence: MIT, LICENSE:1 and README.md:55)
- Kind: cv
- Lib: v6
- Engine: pdfLaTeX-compatible (the author's own build runs `pdflatex main.tex`, .github/workflows/compile.yml:24; `\input{glyphtounicode}` and `\pdfgentounicode=1` are pdfTeX features, main.tex:17, main.tex:58)
- Look carried by: preamble (the zip holds one TeX file, `main.tex`; the look is kernel `article` plus the preamble at main.tex:3-120: margins, `titlesec` section rule, `enumitem` lists, `\newcommand` entry wrappers)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes (all 294 lines), zip-local classes and styles none present (the zip has no `.cls`, `.sty`, `.def` or other TeX support file; its other files are LICENSE, README.md and a CI workflow)

## Verdict
Yes. The class is the kernel `article` with two options, and every preamble line loads a published package or sets a kernel or package parameter. The macros defined in the zip (`\resumeItem`, `\resumeSubheading`, `\resumeProjectHeading`, three unused heading wrappers, `\resumeSubItem`, four list start/end macros and the `\labelitemii` bullet) are plain `\newcommand` or `\renewcommand` wrappers over `itemize`, `tabular*`, font switches and `\vspace`. They hold no counters, conditionals, `\def`s or output-routine code and reduce by inline expansion. There is no TikZ or other artwork and no external tool (the GitHub Actions file only runs `pdflatex`, compile.yml:24, and is not part of the document). Nothing here was compiled.

## Blockers
none

## Class setting
- Class: `class.article` options: `letterpaper`, `11pt` (main.tex:1)
- Class-native vocabulary used: none. The sample never calls `\title`, `\author`, `\maketitle`, `abstract` or `thebibliography`; its heading block is hand-laid in a `center` environment (main.tex:130-145). Only `\section` (main.tex:149, 165, 224, 263, 282) and `itemize` are used.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | `letterpaper,11pt` |
| paper and point size | main.tex:1 | `page.class-options` | `letterpaper`, `11pt` |
| base page margins | main.tex:4 | `page.vmargin` | `\usepackage[empty]{fullpage}` (its page-style option `empty`; the later `\pagestyle{fancy}` at main.tex:33 overrides it). The fullpage source was not read, so its base margin values are not recorded |
| margin adjustment | main.tex:40-44 | `page.setlength` | `\addtolength`: `\oddsidemargin` -0.5in, `\evensidemargin` -0.5in, `\textwidth` +1in, `\topmargin` -.5in, `\textheight` +1.0in; emitted after the fullpage line because they add to its values |
| header and footer | main.tex:11, main.tex:33-37 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\fancyfoot{}`, `\headrulewidth` 0pt, `\footrulewidth` 0pt (no header, no footer, no page number, no rules) |
| page-bottom flow | main.tex:48 | `pg.flush` | `\raggedbottom` |
| paragraph shape | main.tex:49 | `sp.ragged` | `\raggedright` globally |
| table column padding | main.tex:50 | `sp.lengths` | `\setlength{\tabcolsep}{0in}` (a raw kernel length parameter, as `\itemsep`) |
| section headings | main.tex:5, main.tex:53-55 | `head.titlesec` | `\titleformat{\section}` format `\vspace{-4pt}\scshape\raggedright\large`, label `{}`, sep `0em`, before-code `{}`, after-code `[\color{black}\titlerule \vspace{-5pt}]`; no `\titlespacing` |
| section commands | main.tex:149, 165, 224, 263, 282 | `head.kernel` | five `\section{..}`; the label field of `\titleformat` is empty, so no number prints |
| heading format pieces | main.tex:54-55 | `mark.kernel`, `font.size-commands`, `sp.manual-space`, `sp.ragged`, `color.color` | `\scshape`; `\large`; `\vspace{-4pt}`, `\vspace{-5pt}`; `\raggedright`; `\color{black}` |
| space after headings | main.tex:150, 166, 225, 264, 283 | `sp.manual-space` | `\vspace{2pt}` (150, 264) and `\vspace{3pt}` (166, 225, 283) right after each `\section` |
| colour package | main.tex:7 | `color.color` | `\usepackage[usenames,dvipsnames]{color}`; colours used are `black` (main.tex:55) and `blue` for linked names via `\textcolor{blue}` (main.tex:169, 196, 210, 229, 231, 236, 246, 256, 269, 271, 273, 274) |
| lists | main.tex:9, main.tex:117, main.tex:152, main.tex:266 | `list.enumitem` | `\begin{itemize}[leftmargin=0.15in, label={}]` (entry list, main.tex:117, used at main.tex:151, 167, 226, 265, 284); bullet lists use a plain `itemize` (main.tex:119) |
| skills and awards blocks | main.tex:152-160, main.tex:266-276 | `list.kernel`, `font.size-commands`, `mark.kernel`, `sp.manual-space` | `\small{\item{...}}` wrapper; skills rows are `\textbf{Label:}{ text} \\ \vspace{3pt}`; the awards block nests the bullet list (main.tex:267-275) in the same `\item` |
| bullet label, level 2 | main.tex:115 | `list.kernel` | `\renewcommand\labelitemii{$\vcenter{\hbox{\tiny$\bullet$}}$}`; used by the plain `itemize` nested inside the entry list (main.tex:172-180 inside main.tex:167-220) |
| entry rows | main.tex:70-76, main.tex:97-102 | `tbl.tabular` | `tabular*` (kernel) width `0.97\textwidth`, column spec `l@{\extracolsep{\fill}}r`, position `[t]` for the subheading (main.tex:72) and none for the project heading (main.tex:99); rows `\textbf{#1} & #2 \\` and `\textit{\small#3} & \textit{\small #4} \\` (main.tex:73-74) |
| entry row text | main.tex:73-74, main.tex:100 | `mark.kernel`, `font.size-commands` | `\textbf`, `\textit`, `\small`; project heading cell is `\small#1 & #2 \\` |
| entry spacing | main.tex:71, 75, 64-65, 98, 101, 120, 182 | `sp.manual-space` | `\vspace{-2pt}` before each entry item (71, 98) and after item text (65), `\vspace{-7pt}` after the tabular (75, 101), `\vspace{-5pt}` after the bullet list (120), body `\vspace{-10pt}` (182) and `\vspace{1pt}` (171, 186, 198, 213) |
| bullet item | main.tex:63-67 | `list.kernel`, `font.size-commands` | `\item` then `\small{...}` |
| heading block (name, tagline, contacts) | main.tex:130-145 | `sp.ragged`, `mark.kernel`, `font.size-commands`, `sp.manual-space` | kernel `center` environment (same kernel alignment family as `\centering`); `\textbf{\Huge \scshape ...}` (131), `\normalsize` (132), `\small` (133), `\\ \vspace{3pt}`, `\hspace{.5pt}` (134-144); separators are the literal `$|$` (text content); not `front.maketitle` (no `\maketitle`) |
| contact icons | main.tex:15, main.tex:134-144 | `font.icons` | `\usepackage{fontawesome}`; `\faMobile`, `\faAt`, `\faLinkedinSquare`, `\faGithub`, `\faGlobe`, `\faMapMarker` |
| links | main.tex:134-144, 169, 196, 210, 229-256, 269-274 | `xref.hyperref` | `\href{tel:..}`, `\href{mailto:..}`, `\href{https://..}{...}` (hyperref's own link command; the target and text are content) |
| hyperref options | main.tex:10 | `meta.hyperref` | `hidelinks` |
| URL style | main.tex:46 | `meta.url` | `\urlstyle{same}` |
| language | main.tex:12 | `lang.babel` | `english` |
| ATS-parsable PDF text | main.tex:17, main.tex:58 | `meta.glyphtounicode` | `\input{glyphtounicode}`, `\pdfgentounicode=1` (pdfTeX primitive and file) |
| inline maths in text | main.tex:269, 274 | `math.kernel` | `$49^{th}$`, `$147^{th}$` (rank superscripts; text content, kernel inline maths) |
| text encoding package | main.tex:16 | `font.fontenc-t1` | `\usepackage{textcomp}`; no textcomp-only symbol is called (`\textbar`, main.tex:132, is kernel) |
| hyphenation package, loaded never used | main.tex:14 | `sp.hyphenat` | `\usepackage{hyphenat}`; no `\hyp`, `\nohyphens` or `\hyphenation` appears |
| loaded, never used | main.tex:3 | `math.amssymb` | `\usepackage{latexsym}` (LaTeX base extra math symbols; no symbol is called) |
| loaded, never used | main.tex:6 | `font.icons` | `\usepackage{marvosym}`; no marvosym glyph command appears in the body |
| loaded, never used | main.tex:8 | `code.verbatim` | `\usepackage{verbatim}`; no `verbatim`, `\verb` or `comment` appears |
| loaded, never used | main.tex:13 | `tbl.tabularx` | `\usepackage{tabularx}`; the body uses the kernel `tabular*`, not `tabularx` |

Not defined or used: fonts (the sans and serif package lines at main.tex:20-30 are all commented out, so the text keeps the class default), floats, captions, tables of contents, theorems, display equations, code, bibliography, index, footnotes, appendices.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\resumeItem{#1}` | main.tex:63-67 | yes | inline: `\item` + `\small` + text + `\vspace{-2pt}` (`list.kernel`, `font.size-commands`, `sp.manual-space`) |
| `\resumeSubheading{#1}{#2}{#3}{#4}` | main.tex:70-76 | yes | inline: `\vspace{-2pt}\item` + `tabular*` as in the table (`tbl.tabular`, `mark.kernel`, `font.size-commands`, `sp.manual-space`); used at main.tex:168, 183, 195, 209, 285, 288 |
| `\resumeProjectHeading{#1}{#2}` | main.tex:97-102 | yes | inline: `\vspace{-2pt}\item` + one-row `tabular*` + `\vspace{-7pt}`; used at main.tex:228, 235, 245, 255 |
| `\resumeSubSubheading`, `\resumeEducationHeading`, `\resumeOrganizationHeading` | main.tex:79-84, 87-94, 105-111 | yes, and unused in the body | each is `\vspace{-2pt}\item` + a `tabular*` of one to three rows of `\textbf`/`\textit{\small ..}` cells + a `\vspace`; same ways as `\resumeSubheading` |
| `\resumeSubItem{#1}` | main.tex:113 | yes, and unused in the body | `\resumeItem` expansion + `\vspace{-4pt}` |
| `\resumeSubHeadingListStart` and `End` | main.tex:117-118 | yes | `\begin{itemize}[leftmargin=0.15in, label={}]` and `\end{itemize}` (`list.enumitem`); balanced at every use (main.tex:151/161, 167/220, 226/258, 265/277, 284/291) |
| `\resumeItemListStart` and `End` | main.tex:119-120 | yes | `\begin{itemize}` and `\end{itemize}\vspace{-5pt}` (`list.kernel`, `sp.manual-space`) |
| `\renewcommand\labelitemii` | main.tex:115 | yes | a kernel label macro whose value is one small bullet glyph centred on the math axis (`\vcenter{\hbox{\tiny$\bullet$}}`); a fixed string, with no counter, conditional or loop. Written as the label parameter of `list.kernel` |
| `\titleformat` call | main.tex:53-55 | yes | a declarative `head.titlesec` call; its format and after-code arguments hold only kernel font switches, `\vspace`, `\color` and `\titlerule` |
| stray `\emph` before the closing brace of the first argument of `\resumeProjectHeading` | main.tex:229, 236, 246, 256 | not a template construct | `\emph` has no argument of its own there (the next token is `&` or `}` after substitution); treated as a body typo with no template meaning and not emitted; the author's CI compiles the file (compile.yml:24), but that was not run here |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Mapping choices for a reviewer (same choices as the sibling zip 0916-jake-s-resume): `\href` filed under `xref.hyperref` (hyperref's link command, same package as `meta.hyperref`); `latexsym` under `math.amssymb` (an extra-math-symbol package; loaded and never called, so the verdict does not rest on it); `\tabcolsep` under `sp.lengths` (a raw kernel length parameter); the kernel `center` environment under `sp.ragged` (kernel alignment family). `fontawesome` is filed under `font.icons`, which names `fontawesome5`/`fontawesome`; it was not read (published CTAN package, not in the zip).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
