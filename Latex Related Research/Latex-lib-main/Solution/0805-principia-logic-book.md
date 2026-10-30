yes

# 0805-principia-logic-book: Principia Logic Book

- Unverified: read from the source, not compiled.
- Source: Source/0805-principia-logic-book/ (origin: https://latextemplates.com/downloads/principia.zip; licence: LPPL-1.3c)
- Kind: book
- Lib: v6
- Engine: pdfLaTeX-compatible (README.md:13 says compile with pdfLaTeX; no fontspec, no Lua)
- Look carried by: mixed (kernel `book` defaults give page, chapter headings, title page and contents; the preamble, main.tex:2-6, adds T1/Latin Modern, microtype and hyperref; `principia.sty` adds only maths-notation macros and no layout)
- Class origin: tex-distribution-unbundled (kernel `book`; the zip ships no `.cls`)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (principia.sty read in full, lines 1-695)

## Verdict
The page, headings, title page and contents are the unmodified kernel `book` class with three published packages loaded by `main.tex` and no macro, length or counter of its own (main.tex:1-10). The only zip file that holds code is `principia.sty`, which is not zip-local: it is the author's own copy of the CTAN package `principia` (Landon D. C. Elkind, LPPL 1.3c, TeX Live and MiKTeX; ctan.org/pkg/principia read once, its page gives v3.4 of 2025-03-19, the zip has v3.2 of 2025/01/30 at principia.sty:3). It is used unchanged and only called in maths, so it is one existing way with the package as the parameter. No ART, no external tool, so `yes`. Caveat: the later CTAN versions (3.3, 3.4) were not read, so the rendering of the macros could differ from the zip copy.

## Blockers
none

## Class setting
- Class: `class.book` options: `11pt`, `oneside` (main.tex:1)
- Class-native vocabulary used: `\frontmatter` (main.tex:13), `\mainmatter` (main.tex:23), `\backmatter` (main.tex:58), `\chapter` (main.tex:17), `\chapter*` (main.tex:59), `\maketitle` as the book class title page (main.tex:14)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.book` | 11pt, oneside |
| type size and sides | main.tex:1 | `page.class-options` | 11pt, oneside; no paper-size option, no geometry call (class default paper) |
| font encoding | main.tex:2 | `font.fontenc-t1` | `fontenc` option T1 |
| text face | main.tex:3 | `font.lmodern` | `lmodern`, no options |
| microtypography | main.tex:5 | `sp.microtype` | no options |
| PDF links | main.tex:6 | `meta.hyperref` | `hyperref` option `hidelinks`; no `\hypersetup` |
| title block | main.tex:8-10, 14 | `front.maketitle` | `\title`, `\author`, `\date{\today}`, `\maketitle` (book class title page) |
| front, main and back matter | main.tex:13, 23, 58 | `front.class-native` | `\frontmatter`, `\mainmatter`, `\backmatter` (the roman and arabic page-number switch is done by the class, no `\pagenumbering` call) |
| running heads | none set in main.tex | `hf.class-native` | book default page style, no `\pagestyle`, no fancyhdr |
| contents | main.tex:15 | `toc.kernel` | `\tableofcontents`, no tocloft |
| chapters and sections | main.tex:17, 24, 25, 39, 49, 59 | `head.kernel` | `\chapter`, `\section`, `\chapter*{Colophon}`; no titlesec, no `\renewcommand` |
| list | main.tex:50-56 | `list.kernel` | `itemize`, three `\item`, no enumitem |
| inline marks | main.tex:18, 21, 46, 60 | `mark.kernel` | `\texttt`, `\emph` |
| maths notation package | main.tex:4; used at main.tex:27-28, 30-32, 37, 43-44 | `math.physics` | package `principia`, no options (none declared in the file); macros used `\pmimp` `\pmiff` `\pmnot` `\pmor` `\pmandd` `\pmanddd` `\pmsn` `\pmdf` `\pmsub` `\pmsubbb` |
| display maths | main.tex:29-33, 36-38, 42-45 | `math.kernel` | unnumbered `\[ ... \]`, `\qquad`, `\;` (the equations are content) |
| maths packages loaded by principia | principia.sty:16-17 | `math.amssymb`, `math.amsmath` | `\RequirePackage{amssymb}` and `{amsmath}`, no options; `\text`, `\boldsymbol`, `array` use in the macros |
| graphics package loaded by principia | principia.sty:18, 70, 145 | `fig.graphicx` | `\RequirePackage{graphicx}`; `\resizebox`, `\scalebox`, `\rotatebox` inside symbol macros (rotation is the `fig.rotating` type of command) |
| symbol-glyph package loaded by principia | principia.sty:19, 70 | `font.icons` | `\RequirePackage{pifont}`; `\ding{107}` is the proposition star in `\pmast` (used by `\pmsn`, main.tex:37) |
| NFSS glyph call for Female and Male signs | principia.sty:199, 644 | `font.nfss` | `\usefont{U}{mvs}{m}{n}\symbol{126}` and `\symbol{124}`; only in `\pmop`, `\pmopc`, `\pmopsc`, `\pmrenr`; the sample does not call them (needs marvosym fonts installed when called) |

No page geometry, colour, headers, footnotes, floats, tables, code, bibliography, index, language or theorem component is set or used.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| sample preamble definitions | main.tex:1-10 | n/a | none: no `\newcommand`, `\def`, length, counter or environment of its own |
| `principia.sty` (591 `\newcommand` lines, 4 `\RequirePackage`) | principia.sty:3, 16-19, 26-695 | not bespoke | published CTAN package (W1 met), one way `math.physics` with `principia` as the parameter; the emitter writes `\usepackage{principia}` and the macro calls as maths content; the file has no `\DeclareOption`, `\def`, `\renewcommand`, counter, conditional or environment (grep) |
| glyph construction inside the package: `\ooalign` overstrikes (principia.sty:88-90, 98), `picture` `\put` and `\oval` (principia.sty:141-142, `\pmccap` `\pmccup`) | principia.sty | not bespoke | internal to the published package; not template artwork (they print maths signs); `\pmccap` and `\pmccup` are not called by the sample, the `\ooalign` ones are (`\pmimp` `\pmiff` `\pmor` `\pmnot`) |

## Content-opaque
none

## Lib changes
- New ways proposed: none (considered: a separate maths way for `principia`; not proposed, because `math.physics` already admits another math-notation package as the parameter, as `tensind` was merged into it in v6)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
