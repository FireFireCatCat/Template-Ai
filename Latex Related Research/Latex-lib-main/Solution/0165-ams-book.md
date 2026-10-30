yes

# 0165-ams-book: AMS Book (amsbook starter)

- Unverified: read from the source, not compiled.
- Source: Source/0165-ams-book/ (origin: https://latextemplates.com/downloads/amsbook.zip; licence: LPPL-1.3c)
- Kind: book
- Lib: v3
- Engine: pdfLaTeX-compatible (no `fontspec`, no Lua; the README's own build line is `pdflatex main && bibtex main && pdflatex main && pdflatex main`, README.md:24-26)
- Look carried by: class (the zip is one `main.tex` of `\documentclass{amsbook}` with no options, six `\newtheorem` declarations in the class's stock theorem styles, and content; page, headings, title page, contents, running heads and bibliography come from `amsbook`)
- Class origin: tex-distribution-unbundled (`amsbook` is in the `amscls` bundle; the zip does not ship it: main.tex:3-8, README.md:13-15, 19-20)
- Main file: main.tex (other samples: none; other files: README.md, references.bib)
- Read: main yes, zip-local classes and styles none present (the zip has no .cls, .sty, .def, .cfg or .bst). The class source is not in the zip. For the native defaults below I read an installed copy of `amsbook.cls` (amscls, 1875 lines, in a local TinyTeX tree, outside the zip) in outline and in the parts cited; it is cited as `[cls]` and is not a zip citation.

## Verdict
yes. The whole look is the published class `amsbook`, one way `class.amsbook`, loaded with no options (main.tex:16). The preamble adds only `amsmath,amssymb,amsthm` and six `\newtheorem` calls (main.tex:18-29), which are `thm.amsthm` with different names, counters and the stock `definition` and `remark` styles. There is no zip-local macro, environment, counter or conditional, no artwork and no tool outside TeX (`amsplain.bst` is shipped with `amscls`). Evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.amsbook` options: none (main.tex:16). Defaults come from the class: `leqno,centertags,letterpaper,portrait,10pt,twoside,onecolumn,final` ([cls] amsbook.cls:329-330); it loads `amsmath` unless the option `nomath` is given ([cls] :333-339).
- Class-native vocabulary used: preamble `\title` `\author` `\address{}` `\email{}` `\date{\today}` (main.tex:31-36); body `\frontmatter` `\mainmatter` `\backmatter` (main.tex:40, 51, 105), `\maketitle` (:42), `\chapter` `\chapter*` (:44, 53, 84), `\tableofcontents` (:49), theorem styles `plain` (default), `definition`, `remark` through `\theoremstyle` (:25, 28), `proof` (:71, 93), `\bibliographystyle{amsplain}` and `\bibliography` (:107-108). Available in the class but not used: `\curraddr` `\dedicatory` `\keywords` `\subjclass` `\part` `\listoffigures` `\listoftables`, options `a4paper` `oneside` `psamsfonts` `reqno` `nomath`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:16 | `class.amsbook` | `\documentclass{amsbook}`, no options; published in `amscls` (https://ctan.org/pkg/amscls, named at main.tex:8) |
| paper, size, sides | main.tex:16; [cls] amsbook.cls:329-330 | `page.class-options` | none passed; class defaults `letterpaper`, `10pt`, `twoside`, `onecolumn`. No `geometry`, no length is set anywhere |
| running heads, page style | [cls] amsbook.cls:277, 1860-1865 | `hf.class-native` | the class's `headings` style, which the class selects by default unless a file `amsbook.cfg` exists (:1860-1865); the sample sets no `\pagestyle`, no `fancyhdr` |
| front, main, back matter | main.tex:40, 51, 105; [cls] amsbook.cls:944-949 | `front.class-native` | `\frontmatter` = `\cleardoublepage\pagenumbering{roman}`, `\mainmatter` = `\cleardoublepage\pagenumbering{arabic}`, `\backmatter` ends the chapter numbering; the sample sets no counter (the kernel `\pagenumbering` call sits inside the class) |
| title block | main.tex:31, 32, 36, 42 | `front.maketitle` | `\title{Foundations of Analytic Structures}`, `\author{Ada Lovelace}`, `\date{\today}`, `\maketitle` inside `\frontmatter`; the class's own `\maketitle` ([cls] :1334) and `\@maketitle` ([cls] :1347-1376: a page of its own, `\thispagestyle{empty}`) set the page |
| author address and email | main.tex:33-34; [cls] amsbook.cls:458, 460, 473-490, 1359 | `front.class-native` | `\address[opt]{...}` and `\email[opt]{...}`, strings, stored by the class (:458, :460) and printed by `\@setaddresses` (address in small caps, "Email address:" label) from the class's `\@maketitle` |
| preface | main.tex:44-47; [cls] amsbook.cls:983-991, 1006-1011 | `head.class-native` | `\chapter*{Preface}` unnumbered chapter in the front matter, set by the class's `\@schapter` and `\@makeschapterhead` (centred bold title, no number); the text is content |
| chapter headings | main.tex:53, 84; [cls] amsbook.cls:968-982, 994-1005 | `head.class-native` | `\chapter{...}` numbered; `\@makechapterhead` prints the upper-case `\chaptername` and number above a centred bold title; look fixed by the class, the sample sets no heading option; no section level is used |
| contents | main.tex:49; [cls] amsbook.cls:1044-1046 | `toc.kernel` | `\tableofcontents` placed after the preface, before `\mainmatter`; name "Contents" from the class |
| theorem-like statements | main.tex:18, 20-29, 58-63, 65-69, 77-79, 87-91, 100-103 | `thm.amsthm` | `\usepackage{amsthm}` (the class already carries amsthm's code and marks the package as loaded, [cls] amsbook.cls:41-42, 1388, 1566); `\newtheorem{theorem}{Theorem}[chapter]` (numbered within the chapter); `lemma`, `corollary`, `proposition` as `[theorem]` (shared counter) in the default `plain` style; `\theoremstyle{definition}` then `definition` `[theorem]`; `\theoremstyle{remark}` then `remark` `[theorem]`; optional title argument `[Analytic structure]` (main.tex:58) |
| proofs | main.tex:71-75, 93-98 | `thm.amsthm` | `proof` environment, default name "Proof" and end-of-proof mark of the class ([cls] amsbook.cls:1764-1775) |
| math symbols | main.tex:18, 60-61, 89-90 | `math.amssymb` | `\usepackage{amssymb}`; `\mathbb{C}`, `\mathcal{A}`; inline maths only |
| math package | main.tex:18; [cls] amsbook.cls:338 | `math.amsmath` | `\usepackage{amsmath}` (the class loads it too); no display equation, no `align` in the sample |
| emphasis | main.tex:60 | `mark.kernel` | `\emph{analytic structure}` |
| cross-references | main.tex:54, 59, 66, 78, 88, 95, 101 | `xref.kernel` | `\label{ch:...}` `\label{def:...}` `\label{thm:...}` `\label{prop:...}` and `Theorem~\ref{...}` with a tie; no `hyperref`, no `cleveref` |
| citations | main.tex:81-82 | `bib.bibtex-bst` | kernel `\cite{rudin1976principles}`, `\cite{ahlfors1979complex}`; no `natbib` |
| bibliography | main.tex:107-108; references.bib:1-15 | `bib.bibtex-bst` | `\bibliographystyle{amsplain}` (the AMS style, shipped in `amscls`, found as `amsplain.bst` in the installed bundle), `\bibliography{references}` under `\backmatter`; heading "Bibliography" and the list look come from the class's `thebibliography` ([cls] amsbook.cls:1120, 1141-1160); two `@book` entries are content |

Not defined or used, so no row: fonts (class default Computer Modern, main.tex:16), colour, language (no `babel`), `hyperref`, footnotes, lists, floats, tables, captions, code, boxes, index, appendix, display equations, headings below chapter, abstract, keywords, `\subjclass`.

## Bespoke code
none. The sample defines no macro, environment, counter or conditional of its own. The six `\newtheorem` lines (main.tex:20-23, 26, 29) and the two `\theoremstyle` lines (:25, 28) are calls of a published command, reduced to `thm.amsthm` above. There is no `.cls`, `.sty` or `.bst` in the zip.

## Content-opaque
none (no figure, table or picture; `references.bib` holds two `@book` entries, references.bib:1-15, which are content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
