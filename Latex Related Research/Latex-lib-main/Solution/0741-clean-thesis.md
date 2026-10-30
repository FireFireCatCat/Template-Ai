yes

# 0741-clean-thesis: Clean Thesis (the `cleanthesis` style over `scrreprt`)

- Unverified: read from the source, not compiled.
- Source: Source/0741-clean-thesis/ (origin: https://latextemplates.com/downloads/cleanthesis.zip; licence: LPPL-1.3)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (`inputenc` with utf8 at main.tex:17-18; no `fontspec`, `polyglossia` or `luacode` in the sample; the `cleanthesis` source was not read, and its CTAN page names no engine requirement)
- Look carried by: mixed (the class `scrreprt` options at main.tex:1-15 and the published style `cleanthesis` options at main.tex:41-57 carry headings, running heads, colours, links, listings and bibliography; the title page is hand-laid from kernel commands in the sample body at main.tex:64-79; nothing is zip-local)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; references.bib is the one-entry database)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip holds only `main.tex` (109 lines) and `references.bib` (7 lines): no `.cls`, `.sty` or any other zip-local code. The class `scrreprt` (KOMA-Script) and the style `cleanthesis` (ctan.org/pkg/cleanthesis: v0.4.0, R. Langner, LPPL 1.3, "included in TeX Live and MiKTeX") are both published and both outside the zip, so each is one way whose source was not read. The sample adds option values, sixteen `\newcommand` string aliases that inline-expand, and a title page made of kernel commands, so an emitter can print every line from published packages and kernel commands. The weak point of this `yes`: what `cleanthesis` does inside (which packages it loads, how it builds the heads and colours) is taken from the option names the sample passes and from the CTAN page, not from its source.

## Blockers
none

## Class setting
- Class: `class.scrreprt` options: paper=A4, twoside=false, openright, parskip=half, 11pt, headings=normal, bibliography=totoc, listof=totoc, titlepage=on, captions=tableabove, chapterprefix=false, appendixprefix=false, draft=false (main.tex:2-14; `\documentclass` closes at main.tex:15)
- Class-native vocabulary used: `\chapter` and `\chapter*` (main.tex:82, 93, 103), `\section` (main.tex:94, 100), the page style name `scrheadings` (main.tex:91). `titlepage`, `\tableofcontents`, `\pagestyle` and `\pagenumbering` are kernel.
- Thesis style on top: `class.cleanthesis` (`\PassOptionsToPackage{...}{cleanthesis}` at main.tex:41-56, then `\usepackage{cleanthesis}` at main.tex:57). It is a style package, written as a class way because the lib's v3 log files a thesis style as class-like (`thesis.unamthesis` into `class.unamthesis`). Options: figuresep=colon, hangfigurecaption=false, hangsection=true, hangsubsection=true, sansserif=false, configurelistings=true, colorize=full, colortheme=bluemagenta, configurebiblatex=true, bibsys=bibtex, bibfile=references, urlcolor=true, linkcolor=true, citecolor=true (main.tex:42-55). Vocabulary used after it: biblatex `\textcite` (main.tex:98, 105) and `\printbibliography` (main.tex:107).
- Source not read for either class way: neither `scrreprt` nor `cleanthesis` is in the zip.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1-15 | `class.scrreprt` | the 13 options listed under "Class setting" |
| thesis style | main.tex:41-57 | `class.cleanthesis` | 14 keys at main.tex:42-55, passed by `\PassOptionsToPackage` before the load |
| paper, type size, sides | main.tex:2, 3, 4, 6 | `page.class-options` | paper=A4, 11pt, twoside=false, openright |
| paragraph spacing | main.tex:5 | `class.scrreprt` | option parskip=half (a KOMA class option, so a parameter, not `sp.parskip-pkg`) |
| title-page and draft switches | main.tex:10, 14 | `class.scrreprt` | titlepage=on, draft=false (the sample's title page does not use `\maketitle`) |
| text block margins | none in the sample | `class.scrreprt` | no `geometry` or `typearea` call; class default; whether `cleanthesis` changes it was not read |
| heading look | main.tex:7, 12, 13, 44, 45 | `head.class-native` | KOMA headings=normal, chapterprefix=false, appendixprefix=false; cleanthesis hangsection=true, hangsubsection=true |
| heading commands | main.tex:82, 93, 94, 100, 103 | `head.kernel` | `\chapter*{Abstract}`, `\chapter`, `\section` |
| text face | main.tex:46 | `class.cleanthesis` | sansserif=false (font packages the style loads were not read) |
| input encoding | main.tex:17, 18 | `font.fontenc-t1` | `inputenc` with option utf8 |
| language | main.tex:40 | `lang.babel` | english |
| colour scheme | main.tex:48, 49 | `class.cleanthesis` | colorize=full, colortheme=bluemagenta (colour definitions are inside the style) |
| link colours | main.tex:53, 54, 55 | `class.cleanthesis` | urlcolor=true, linkcolor=true, citecolor=true (presumably forwarded to `meta.hyperref`; not read) |
| caption position | main.tex:11 | `cap.koma` | captions=tableabove (the sample has no float) |
| caption label look | main.tex:42, 43 | `class.cleanthesis` | figuresep=colon, hangfigurecaption=false (no float in the sample) |
| code listings set-up | main.tex:47 | `class.cleanthesis` | configurelistings=true (no listing in the sample; presumably `code.listings`, not read) |
| contents entries | main.tex:8, 9 | `toc.koma` | bibliography=totoc, listof=totoc |
| contents list | main.tex:87 | `toc.kernel` | `\tableofcontents` |
| page numbering | main.tex:61, 89, 90 | `pgnum.pagenumbering` | roman for the front matter, arabic with `\setcounter{page}{1}` from the first chapter |
| page styles | main.tex:62, 81, 91 | `hf.pagestyle-kernel` | empty (title page), plain (abstract and contents), `scrheadings` (chapters) |
| running heads | main.tex:91 | `hf.class-native` | the content of `scrheadings` is defined by the style and the KOMA head packages; which package it loads (`scrlayer-scrpage` or `scrpage2`) was not read |
| title page | main.tex:64-79 | `front.titlepage-env` | `titlepage` environment, hand-laid; `\thesisDate` is `\today` (main.tex:23, 78) |
| title page alignment | main.tex:65 | `sp.ragged` | `\centering` |
| title page spacing | main.tex:66, 68, 70, 74, 77; line breaks 72, 75 | `sp.manual-space` | `\vspace*{2cm}`, `\vspace{2cm}`, `\vspace{1cm}` (three times), `\\` |
| title page type sizes | main.tex:67, 69 | `font.size-commands` | `\huge` (title), `\Large` (author) |
| abstract | main.tex:82-85 | `head.kernel` | unnumbered `\chapter*{Abstract}` plus one paragraph; no `abstract` environment, so no `abs.*` way |
| chapters and sections | main.tex:93, 94, 100, 103 | `head.kernel` | `\chapter`, `\section`; the look is in the heading-look row |
| inline code face | main.tex:97 | `mark.kernel` | `\texttt{scrreprt}` |
| citations | main.tex:98, 105 | `bib.biblatex-bibtex` | `\textcite{knuth1984texbook}`; configurebiblatex=true, bibsys=bibtex (main.tex:50, 51) |
| bibliography | main.tex:107, 52 | `bib.biblatex-bibtex` | `\printbibliography`, bibfile=references; the biblatex style is chosen inside `cleanthesis` (not read) |
| bibliography database | references.bib:1-7 | `bib.biblatex-bibtex` | one `@book` entry (content) |

No columns, floats, tables, lists, quotes, notes, maths, theorems, boxes, index, background or watermark appear in the sample. Components that `cleanthesis` may add by itself (the `hangsection` look, colours, listing style) are covered by the `class.cleanthesis` rows; they are recorded from option names only.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\thesisTitle`, `\thesisName`, `\thesisSubject`, `\thesisDate`, `\thesisVersion` | main.tex:20-24 | yes | `\newcommand` string aliases; inline-expand where used (main.tex:67, 69, 71, 78); `\thesisDate` is kernel `\today`; `\thesisVersion` is never used |
| `\thesisFirstReviewer`, `...University`, `...Department`, `\thesisFirstSupervisor` | main.tex:26-28, 30 | yes | string aliases; used at main.tex:75, 76; `...Department` is unused |
| `\thesisUniversity` and its Department, Institute, Group, City, StreetAddress, PostalCode aliases | main.tex:32-38 | yes | string aliases; only `\thesisUniversity` and `\thesisUniversityDepartment` are used (main.tex:72, 73); the other five are unused |
| `\protect{Clean Thesis University}` | main.tex:27, 32 | yes | a `\protect` around a braced string, no effect on the look; dropped by inline expansion |

That is 16 `\newcommand` lines, all reducible (9 used, 7 unused). Whether `cleanthesis` itself reads the `\thesis*` names (for example for PDF metadata) is not established, since its source was not read. If it does, the emitter prints them as kernel `\newcommand` lines and they stay inputs to a published style.

## Content-opaque
none

## Lib changes
- New ways proposed: none. `class.scrreprt` is in the lib; `class.cleanthesis` is written plainly as a class way (no proposal needed), with its vocabulary under "Class setting". Considered: `cleanthesis` as a separate `front.*` or `head.*` way, rejected because it sets headings, colours, links, listings and bibliography at once, which is class-like.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
