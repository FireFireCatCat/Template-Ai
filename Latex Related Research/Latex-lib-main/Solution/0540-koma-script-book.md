yes

# 0540-koma-script-book: KOMA-Script Book

- Unverified: read from the source, not compiled.
- Source: Source/0540-koma-script-book/ (origin: https://latextemplates.com/downloads/scrbook.zip; licence: LPPL-1.3c)
- Kind: book
- Lib: v4
- Engine: pdfLaTeX-compatible (`inputenc` utf8 and `fontenc` T1 with `lmodern`, main.tex:3-5; no fontspec, no Lua)
- Look carried by: class (the published `scrbook` defaults set page, headings, title page, running heads and captions; the preamble only loads `lmodern`, `booktabs` and `natbib` with no settings, main.tex:5-7)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip holds two files, `main.tex` (71 lines, read in full) and `references.bib` (one `@book` entry). There is no zip-local class, style, `\newcommand`, `\def`, counter or drawing. The look is the unchanged default of the published KOMA-Script class `scrbook`, plus three load-only published packages and a BibTeX run with `plainnat`. Every component maps to a lib way, nothing is bespoke, and no `ART` is present. The class source is not in the zip and was not read; `scrbook` is part of the `koma-script` bundle (ctan.org/pkg/koma-script: LPPL 1.3c, in TeX Live and MiKTeX).

## Blockers
none

## Class setting
- Class: `class.scrbook` options: `11pt`, `twoside` (main.tex:1). No `\KOMAoptions`, `DIV`, `BCOR`, `headings=`, `captions=` or `\setkomafont` anywhere (grep of main.tex confirms none), so every KOMA default applies.
- Class-native vocabulary used: `\frontmatter` (main.tex:15), `\mainmatter` (main.tex:25), `\addchap` (main.tex:18, KOMA unnumbered chapter with a contents entry), `\chapter` `\section` (main.tex:27, 29, 36, 56, 58, 63), `\maketitle` as the class's own title page (main.tex:16). The typearea computation is the class default (the sample's own text names it, main.tex:31-34).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:1 | `class.scrbook` | 11pt, twoside |
| paper and size | main.tex:1 | `page.class-options` | `11pt`, `twoside`; no paper-size option, so the class default paper |
| page geometry | main.tex:1, 31-34 | `page.typearea` | scrbook default type area (typearea loaded by the class); no `DIV` or `BCOR` set |
| input and font encoding | main.tex:3-4 | `font.fontenc-t1` | `inputenc` option utf8; `fontenc` option T1 |
| text font | main.tex:5 | `font.lmodern` | `\usepackage{lmodern}`, no options |
| running heads and page numbers | not set in the sample | `hf.class-native` | scrbook default page style; `twoside` at main.tex:1 makes it two-sided (class source not read) |
| front-matter and main-matter switches | main.tex:15, 25 | `front.class-native` | `\frontmatter`, `\mainmatter`; no `\backmatter` (the bibliography at main.tex:68-69 follows the last chapter) |
| title block | main.tex:9-11, 16 | `front.maketitle` | `\title{Configuring a Book from First Principles}`, `\author{Noor Fatima}`, `\date{\today}`, `\maketitle`; the printed layout is the class default (no `\subject`, `\publishers`, `\extratitle`) |
| preface | main.tex:18 | `head.class-native` | `\addchap{Preface}`: KOMA unnumbered chapter with contents entry; text at main.tex:19-21 |
| contents | main.tex:23 | `toc.kernel` | `\tableofcontents` after the preface; no `toc=` option (so not `toc.koma`) |
| chapters and sections | main.tex:27, 29, 36, 56, 58, 63 | `head.kernel`, `head.class-native` | `\chapter` (2), `\section` (4), no renewed counters or formats; the heading look is the scrbook default, no `\setkomafont` or `headings=` |
| section numbering | not set in the sample | `num.secnumdepth` | class default depth (no `\setcounter`) |
| inline code font | main.tex:19, 38, 60, 66 | `mark.kernel` | `\texttt{...}` |
| inline verbatim | main.tex:47-49 | `code.verbatim` | `\verb|\part|`, `\verb|\chapter|`, `\verb|\section|` in table cells |
| table float | main.tex:41-54 | `tbl.tabular`, `fig.placement`, `sp.ragged` | `table` environment, placement `[h]`; `\centering` (main.tex:42) |
| table body | main.tex:43-51 | `tbl.tabular` | `tabular` with column spec `{ll}` |
| table rules | main.tex:6, 44, 46, 50 | `tbl.booktabs` | `\usepackage{booktabs}`; `\toprule`, `\midrule`, `\bottomrule` |
| table caption | main.tex:52 | `cap.kernel` | `\caption{...}` placed after the tabular; KOMA default caption look, no `captions=` option (so not `cap.koma`) |
| cross-references | main.tex:38, 53 | `xref.kernel` | `\label{tab:levels}`, `Table~\ref{tab:levels}` |
| citations | main.tex:7, 32, 66 | `bib.natbib` | `\usepackage{natbib}`, no options; `\citep{knuth1984texbook}` |
| bibliography | main.tex:68-69; references.bib:1-7 | `bib.bibtex-bst` | `\bibliographystyle{plainnat}`, `\bibliography{references}`; one `@book` entry (content) |

Not present in the sample, so not mapped: abstract, lists, quotes, notes and footnotes, theorems, math, figures with images, code listings, boxes, index, appendix, language package, `hyperref`, colour.

## Bespoke code
none. The zip defines no macro, environment, counter, class or style of its own; main.tex has only `\documentclass`, five `\usepackage` lines and `\title`/`\author`/`\date`.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes: `class.scrbook` is already in the lib (class table), and the sample uses only its default vocabulary. The BibTeX run (`bibtex` over `references.bib`) belongs to the standard TeX toolchain and is the lib's `bib.bibtex-bst`, not an `EXTERNAL` blocker. No text addressed to an AI was found in either file.
