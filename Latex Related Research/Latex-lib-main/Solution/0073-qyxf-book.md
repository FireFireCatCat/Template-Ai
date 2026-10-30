yes

# 0073-qyxf-book: qyxf-book (ctexbook-based Chinese course-material starter)

- Unverified: read from the source, not compiled.
- Source: Source/0073-qyxf-book/ (origin: https://latextemplates.com/downloads/qyxf-book.zip; licence: MIT)
- Kind: book
- Lib: v1
- Engine: needs XeLaTeX (`% !TEX program = xelatex` main.tex:1; build line README.md:36; the class's default `xits=true` loads XITS through fontspec, main.tex:18-21; the class is "designed only for Chinese typesetting" per its CTAN page)
- Look carried by: class (the zip holds only a sample; every look is set by the published class `qyxf-book` through its options; the preamble adds `amssymb` only)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is three files: `main.tex` (91 lines), `references.bib` (1 entry) and a README. The class is not bundled (README.md:24, main.tex:5-6). One read of https://ctan.org/pkg/qyxf-book shows it is a published CTAN and TeX Live class (version 3.1.0, MIT, Jiarui You / Qian Yuan Xue Fu), so it is a single W1 to W4 way, `class.qyxf-book`, set by six options. The sample defines no macro, environment, counter or drawing of its own, and its body uses only class-native commands, kernel sectioning and maths, `tcolorbox` and BibTeX with natbib. Hence `yes`. The class source was NOT read (it is not in the zip and no local TeX copy exists), so what the class does internally (header/footer, heading looks, `tcolorbox` colours, which packages it loads) is inferred from the sample, its comments and the README, not seen. The verdict is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.qyxf-book` options: `10pt`, `twoside`, `openany`, `b5paper`, `colorscheme = basic`, `xits = false` (main.tex:28-35). Built on `ctexbook` (README.md:3; main.tex:2), so it is a book-type class with `\chapter`.
- Class-native vocabulary used: `\subtitle{}` (main.tex:40), `\org{}` (main.tex:43), `\footorg{}` (main.tex:44), `\license{}` (main.tex:45); options `colorscheme` (palette choice, README.md:24-25) and `xits` (XITS main and math font on/off, main.tex:18-23). `\cover{}` exists upstream but is dropped from the sample and defaults to empty (main.tex:7). `\org` and `\license` have non-empty defaults (the club's college name; a CC BY-NC-ND 4.0 notice on the title page, main.tex:8-16), which is why the sample clears them. Standard class-provided commands used: `\maketitle`, `\tableofcontents`, `\chapter`, `\section`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:28-35 | `class.qyxf-book` | 10pt, twoside, openany, b5paper, colorscheme=basic, xits=false |
| paper, size, sides, chapter opening | main.tex:29-32 | `page.class-options` | `b5paper`, `10pt`, `twoside`, `openany`; no `geometry` call, so margins are the class's own (unread) |
| colour palette | main.tex:33; README.md:24-25 | `class.qyxf-book` | option `colorscheme=basic`; the palette feeds the class's boxes and headings (inferred, class unread); no `\definecolor` in the sample |
| fonts | main.tex:34; comment main.tex:18-23 | `class.qyxf-book` | `xits=false` skips the class's `\setmainfont{XITS}` / `\setmathfont{XITS Math}`; the face is then the ctex default (not read) |
| Chinese language support | README.md:3; main.tex:2; Chinese text main.tex:39-86 | `lang.cjk` | via the `ctexbook` base of the class (ctex; XeLaTeX); no `\usepackage` of it in the sample, so class-carried |
| header/footer | main.tex:44 (`\footorg{}` cleared) | `hf.class-native` | none set by the sample; the existence of a footer text command implies the class sets a footer (inferred; layout unread) |
| title block | main.tex:39-42, 49 | `front.maketitle` | `\title{线性代数复习讲义}`, `\author{陈静}`, `\date{\today}`, `\maketitle` |
| title block extras | main.tex:40, 43-45 | `front.class-native` | `\subtitle{A Review of Linear Algebra}`; `\org{}`, `\footorg{}`, `\license{}` all set to empty to remove the club branding and licence notice |
| contents | main.tex:51 | `toc.kernel` | `\tableofcontents`; look is the class's (unread) |
| headings | main.tex:53-55, 63, 71, 73, 84 | `head.class-native` | `\chapter`, `\section`; look is the class's "clean chapter/section styling" (README.md:5), set by `colorscheme`; no `titlesec` in the sample |
| inline marks | main.tex:57, 65, 69, 75, 86 | `mark.kernel` | `\textbf`, `\emph` |
| inline and display maths | main.tex:57-86 (`$..$` and `\[ \]` at 66-68, 79-81) | `math.kernel` | `$...$`, `\[ ... \]` |
| maths symbols | main.tex:37; `\mathbb` main.tex:78 | `math.amssymb` | `\usepackage{amssymb}` |
| maths environments and operators | `pmatrix` main.tex:80; `\implies` main.tex:67 | `math.amsmath` | `amsmath` is not loaded by the sample, so the class must load it (inferred, class unread) |
| boxed statements | main.tex:59-61, 77-82 | `box.tcolorbox` | `\begin{tcolorbox}[title=定理 1.1]`, `[title=例 2.1]`; only `title=` is given; `tcolorbox` is loaded by the class ("coloured theorem boxes", README.md:4); numbers in the titles are typed text, so there is no theorem counter and no `thm.*` way |
| citations | main.tex:86 | `bib.natbib` | `\citet{strang2016linear}`; natbib is not loaded by the sample, so the class must load it (inferred, class unread) |
| bibliography | main.tex:88-89; references.bib:1-7 | `bib.bibtex-bst` | `\bibliographystyle{plainnat}`, `\bibliography{references}`; run bibtex (README.md:36) |

## Bespoke code
none. The sample has no `\newcommand`, `\def`, environment, counter, conditional, `.cls` or `.sty`. `\org`, `\footorg`, `\license`, `\subtitle` are commands of the published class, not zip-local.

## Content-opaque
none

## Lib changes
- New ways proposed: none. `class.qyxf-book` is written plainly under the class rule (CTAN / TeX Live class, MIT).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Not read: the source of `qyxf-book.cls` (not in the zip; no TeX installation on this machine). Everything marked "inferred" above rests on that. If the class source shows irreducible code (it is a `ctexbook` wrapper with `tcolorbox` styling per README.md:3-5), that would be a class-internal matter and the single `class.qyxf-book` way would still hold under the rubric's published-class rule.
- Engine: XeLaTeX only; Flouest's engine is pdfTeX, so this zip needs an engine switch, which the rubric records but does not count as a blocker.
- Nothing in the zip was addressed to an AI; no instructions inside the zip were followed. The README build line (README.md:36) was read as data and not run.
