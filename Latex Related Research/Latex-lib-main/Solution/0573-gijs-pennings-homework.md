yes

# 0573-gijs-pennings-homework: Gijs Pennings Homework

- Unverified: read from the source, not compiled.
- Source: Source/0573-gijs-pennings-homework/ (origin: https://latextemplates.com/downloads/gijs-homework.zip; licence: ISC, from the manifest; README.md:10-12 says the upstream class is ISC and that this starter is an original document with no upstream class code bundled)
- Kind: assignment
- Lib: v4
- Engine: pdfLaTeX-compatible (README.md:14 says compile with `pdflatex`; no `fontspec`, `polyglossia`, Lua or expl3 in main.tex)
- Look carried by: preamble (kernel `article` at 11pt carries nothing; main.tex:3-50 sets the geometry, fonts, colours, `fancyhdr` header, and the `problem`, `solution` and `claim` blocks; the zip ships no .cls, .sty, .def, .cfg or .bst)
- Class origin: tex-distribution-unbundled (kernel `article`, not bundled in the zip; its source was not read)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
`yes`, on one judgment call. The page, fonts, colours, header and title block are published packages and kernel commands with option values. The only code that is not a plain call is the zip-local `problem` environment (main.tex:34-37): a `\newcounter` plus `\refstepcounter` and one `\if\relax\detokenize{#1}\relax` test for the optional title. It is a numbered, titled statement, so it reduces to `thm.amsthm` with a `\newtheoremstyle` (or to literal text with the number computed by the emitter). The coloured header rule (main.tex:32) is a `\leaders\hrule` rule under `fancyhdr`, so it is `sp.rule` and not `ART`. No `ART`, `EXTERNAL` or `UNMAPPED` item and no new way is needed.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (main.tex:1)
- Class-native vocabulary used: `\title`, `\author` (with `\\` inside), `\date`, `\maketitle` (main.tex:43-49). No `abstract`, `\section`, `\tableofcontents`, `\appendix` or `thebibliography`. The sample's page set is the plain `article` page style switched to `fancy`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | option `11pt` |
| type size | main.tex:1 | `page.class-options` | `11pt` (paper size is not a class option here) |
| page geometry | main.tex:3 | `page.geometry` | `a4paper`, `margin=1in` |
| encodings | main.tex:4-5 | `font.fontenc-t1` | `fontenc` option `T1`; `inputenc` option `utf8` |
| text and math font | main.tex:6 | `font.lmodern` | `lmodern`, no options |
| micro-typography | main.tex:7 | `sp.microtype` | `microtype`, defaults |
| colours | main.tex:8, 14-15 | `color.xcolor` | `\definecolor{ink}{HTML}{243447}`, `\definecolor{accent}{HTML}{0B7285}` |
| maths packages | main.tex:9 | `math.amsmath`, `math.amssymb` | loaded with no options; the one display `\[ ... \]` at main.tex:81-84 is content |
| list setup | main.tex:10, 16 | `list.enumitem` | `\setlist{itemsep=2pt,topsep=4pt}`; the body has no list, so this is look only |
| paragraph shape | main.tex:17-18 | `sp.lengths` | `\parindent`=0pt, `\parskip`=5pt |
| hyperlinks | main.tex:12 | `meta.hyperref` | `hidelinks` |
| running head and foot | main.tex:11, 25-30 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\lhead{\textsc{\coursename}}`, `\chead{Assignment \assignmentnumber}`, `\rhead{\studentname}`, `\cfoot{\thepage}` |
| small caps in head field | main.tex:27 | `mark.kernel` | `\textsc` |
| head rule | main.tex:31-32 | `hf.fancyhdr`, `sp.rule` | `\headrulewidth`=0.4pt; `\headrule` set to `\hbox to\headwidth{\color{accent}\leaders\hrule height \headrulewidth\hfill}` (a leaders rule of the accent colour) |
| page style of page 1 | main.tex:50 | `hf.pagestyle-kernel` | `\thispagestyle{fancy}` right after `\maketitle` |
| title block | main.tex:43-46, 49 | `front.maketitle` | `\title{...\\ \large A practical study of graph algorithms}`, `\author{\studentname\\\coursename\ --- \termname}`, `\date{Due 18 March 2026}`, `\maketitle` |
| title adjustments | main.tex:43-44 | `sp.manual-space`, `color.xcolor`, `font.size-commands` | `\vspace{-2em}`, `\textcolor{ink}{...}`, `\large` |
| body label paragraph | main.tex:52-54 | `mark.kernel` | run-in `\textbf{Submission checklist.}` then plain text |
| problem counter | main.tex:34-35, 36 | `num.counters` | `\newcounter{problem}`, `\refstepcounter{problem}`, `\theproblem` (original form; in the reduced form `\newtheorem` makes the same counter) |
| problem statement | main.tex:35-37, 56, 74, 91 | `thm.amsthm` | numbered "Problem n", optional title after ` --- `; reduction below |
| problem head look | main.tex:36 | `mark.kernel`, `font.size-commands`, `color.xcolor`, `sp.manual-space` | `\textcolor{accent}{\large\bfseries ...}`; `\vspace{8pt}` before, `\smallskip` after head, `\medskip` after the block (main.tex:37) |
| solution block | main.tex:38-40, 62-71, 79-88 | `color.xcolor`, `mark.kernel`, `sp.manual-space` | group `\begingroup\color{ink}` ... `\endgroup\par`; run-in `\textbf{Solution.}\quad` |
| claim statement | main.tex:41, 97-100 | `thm.amsthm` | `\newtheorem*{claim}{Claim}` (unnumbered, no `\theoremstyle` before it, so amsthm's default style) |
| citation | main.tex:99 | `bib.bibtex-bst` | `\cite{cormen2009}` (kernel `\cite`, no `natbib`) |
| bibliography | main.tex:102-103 | `bib.bibtex-bst` | `\bibliographystyle{plain}`, `\bibliography{references}`; references.bib:1-7 holds one `@book` entry (content) |

Not used by the sample, so no way is needed: sectioning commands, lists in the body, tables, figures, captions, abstract, contents lists, code, footnotes, index, appendix, language packages.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\studentname}`, `\coursename`, `\termname`, `\assignmentnumber` | main.tex:20-23 | yes | Plain text aliases. Expand inline (main.tex:27-29, 43, 45) or keep as aliases; the strings are content. |
| `\newcounter{problem}` | main.tex:34 | yes | Made by `\newtheorem{problem}{Problem}` in `thm.amsthm`. Its value depends only on the order of problems, so the emitter may also write the number as literal text. |
| `problem` environment with optional argument `[#1]` and the test `\if\relax\detokenize{#1}\relax` | main.tex:35-37 | yes | `thm.amsthm`: `\newtheoremstyle{problem}{8pt}{\medskipamount}{\normalfont}{0pt}{\large\bfseries\color{accent}}{}{\newline}{\thmname{#1}\thmnumber{ #2}\thmnote{ --- #3}}`, then `\theoremstyle{problem}\newtheorem{problem}{Problem}`; amsthm prints the note only when one is given, which is all the `\if` does. Differences in the gap after the head and in the note's font are parameter-level and are not claimed identical here. Alternative with no macro logic: for problem k with a title, write `\par\vspace{8pt}\textcolor{accent}{\large\bfseries Problem k}\ --- Title\par\smallskip` at the start and `\par\medskip` at the end. `\theoremstyle{plain}` is restored before `claim`. |
| `solution` environment | main.tex:38-40 | yes | Straight-line wrapper with no conditional: `\begingroup\color{ink}\textbf{Solution.}\quad` ... `\endgroup\par` (`color.xcolor`, `mark.kernel`, `sp.manual-space`). Also expressible as `\newtheorem*{solution}{Solution}` in an amsthm style with body font `\color{ink}`. |
| `\renewcommand{\headrule}` | main.tex:32 | yes | `fancyhdr`'s `\headrule` hook set to a `\leaders\hrule` rule of a colour: `sp.rule` with `color.xcolor`, using the lengths `\headwidth` and `\headrulewidth`. It draws one straight rule, not a picture, so it is not `ART`. |
| `\renewcommand{\headrulewidth}` | main.tex:31 | yes | A `fancyhdr` length, `hf.fancyhdr` parameter. |

Grep of main.tex for `\def`, `\let`, `\newif`, `\halign`, `\expandafter`, `\makeatletter`, `\@`, expl3, Lua and `\write18` found none. The only conditional is the one at main.tex:36. BibTeX with the `plain` style is the standard TeX toolchain and is the lib's `bib.bibtex-bst`, so it is not `EXTERNAL`.

## Content-opaque
none (the display equation at main.tex:81-84 is maths content that `amsmath` holds; no figure, table or picture in the sample)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
