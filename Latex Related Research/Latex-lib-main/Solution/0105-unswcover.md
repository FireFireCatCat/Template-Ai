yes

# 0105-unswcover: unswcover (UNSW dissertation cover page and statements)

- Unverified: read from the source, not compiled.
- Source: Source/0105-unswcover/ (origin: https://mirrors.ctan.org/macros/latex/contrib/unswcover.zip; licence: LPPL 1.3, README:95-103)
- Kind: thesis
- Lib: v2
- Engine: pdfLaTeX-compatible (pdfpages, graphicx with a PDF logo, inputenc utf8, hyperref, biblatex with `backend=bibtex`; the Makefile calls `pdflatex` and `bibtex`, Makefile:7-8)
- Look carried by: mixed (memoir carries chapters, page and running heads by its defaults; the published CTAN package unswcover.sty carries the cover and the three statements; the sample preamble sets only strings and hyperref/biblatex options)
- Class origin: tex-distribution-unbundled
- Main file: thesis.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (unswcover.sty is the only one; memoir's own source not read)

## Verdict
yes. The class is the published `memoir` (not in the zip) and the zip's only style, `unswcover.sty`, is the CTAN release of the unswcover package itself (unswcover.sty:16 "Initial CTAN release"; ctan.org/pkg/unswcover read: LPPL 1.3, in TeX Live), so it is published (W1) and not zip-local. It is driven only by strings (`\unswschool`, `\unswdegree`, `\unswcotutelle`, `\unswdissertationsheet`) and one body call, so it is proposed as one doc-kind front-matter way. Even if a reviewer refuses that way under W3, its body reduces to existing ways (see Bespoke code). The sample's own macros are string aliases and a date override, all reducible. No artwork is drawn (the logo is an included PDF) and nothing needs a tool outside TeX to produce the document.

## Blockers
none

## Class setting
- Class: `class.memoir` options: `11pt`, `a4paper`, `openright` (thesis.tex:1)
- Class-native vocabulary used: `\frontmatter` (thesis.tex:39), `\mainmatter` (thesis.tex:67), `\backmatter` (thesis.tex:81), `\chapter` and `\chapter*` (thesis.tex:58,61,69-79,87), `\tableofcontents` (thesis.tex:65), `\cleardoublepage` (thesis.tex:64), `\appendix` (thesis.tex:85). The package adds `\section*` and `\chapter*{}` (unswcover.sty:93-95,119-121,145). The sample uses no memoir-only command such as `\chapterstyle`, `\makepagestyle` or `\setlrmarginsandblock`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | thesis.tex:1 | `class.memoir` | 11pt, a4paper, openright |
| paper and size | thesis.tex:1 | `page.class-options` | a4paper, 11pt; no margins set anywhere, class defaults apply |
| input encoding | thesis.tex:2 | `font.fontenc-t1` | inputenc utf8 only; no fontenc, no font package (default fonts) |
| language | unswcover.sty:25; unswcover.sty:51; thesis.tex:29 | `lang.babel` | option `australian` loaded by the package (thesis.tex:7 comment); `\selectlanguage{australian}`; `otherlanguage` env around `\today` |
| UNSW cover page | thesis.tex:7,14,17-18,44; unswcover.sty:46-84 | `class.unswcover` | `\usepackage{unswcover}`; `\unswschool{The School of Electrical Engineering and Telecommunications\\}`; `\unswcotutelle{Dép. Mathématiques ... France}`; `\unswdegree` unset so default "Doctor of Philosophy" (unswcover.sty:34); body `\makeunswfrontmatter`; reads `\@title` `\@author` `\@date` |
| UNSW statement pages | unswcover.sty:93-161; thesis.tex:44 | `class.unswcover` | Originality, Copyright and Authenticity statements, fixed text, each with a Signed/Date table; optional `\extrainfobox` slot (unswcover.sty:115), undefined in the sample |
| cover logo | unswcover.sty:69 | `fig.graphicx` | `\includegraphics[width=3cm]{logo_unsw_short}`, not in a float; asset `logo_unsw_short.pdf` (and `.ps`) is in the zip |
| dissertation sheet (inactive) | unswcover.sty:27,89-91; thesis.tex:20 | `pg.include-pdf` | `\includepdf{\UNSW@dissertationsheet}`; the call is commented out in the sample; its PDF is not shipped (missing asset, not used) |
| title, author, date data | thesis.tex:26-27,30,33-35 | `front.maketitle` | `\title{\theTitle}`, `\author{\theAuthor}`; `\date` not called (commented, thesis.tex:30); `\maketitle` not called, the cover macro replaces it; date forced to 14 12 2011 by the overrides |
| compile-date note | thesis.tex:28-29,46-56 | `box.minipage` | kernel `\newsavebox` `\savebox` `\usebox` (kernel box family, nearest way) holding `lang.babel` `otherlanguage{australian}` + `\today`; sits in a `flushleft` |
| page breaks | thesis.tex:46,64; unswcover.sty:47 | `pg.break` | `\newpage`, `\cleardoublepage`, `\clearpage` |
| page style | thesis.tex:47; unswcover.sty:47,53 | `hf.pagestyle-kernel` | `\thispagestyle{empty}`, `\pagestyle{empty}` in a group |
| running heads | not set by the sample | `hf.class-native` | memoir's default applies (memoir source not read) |
| page number restart | unswcover.sty:52 | `pgnum.pagenumbering` | `\setcounter{page}{1}` |
| front, main, back matter | thesis.tex:39,67,81 | `front.class-native` | `\frontmatter`, `\mainmatter`, `\backmatter` |
| spacing and fill | thesis.tex:48-49; unswcover.sty:55,59,61,63,67,71,75,77,80,82,108,115,117,136,143,152,159 | `sp.manual-space` | `\vfill`, `\strut`, `\vphantom{g}` (unswcover.sty:59), `\vspace{N\bigskipamount}` N=2..5, `\bigskip`, `\vspace{1em}`, `\vspace{3em}` |
| alignment | thesis.tex:50-56; unswcover.sty:54,68 | `sp.ragged` | `flushleft`, `center` (nested) |
| cover type sizes | unswcover.sty:59,62 | `font.size-commands` | `\Huge` title, `\Large` author |
| cover emphasis | unswcover.sty:59,62,66,72-73,78 | `mark.kernel` | `\textbf` |
| chapters and sections | thesis.tex:58,61,69-79,87; unswcover.sty:93,95,119,121,145 | `head.class-native` | memoir default chapter and section look; `\chapter`, `\chapter*`, `\section*`; no style set |
| appendix | thesis.tex:85-87 | `num.appendix` | `\appendix` then one `\chapter` |
| table of contents | thesis.tex:65 | `toc.kernel` | `\tableofcontents`, defaults |
| signature tables | unswcover.sty:110-113,138-141,154-157 | `tbl.tabular` | `tabular[h!]{ll}` (`h!` is a float specifier in the position slot) rows `Signed` and `Date` |
| hyperref | thesis.tex:22-24 | `meta.hyperref` | option `unicode`; `colorlinks=true`, `linkcolor=black`, `citecolor=black`, `urlcolor=blue`; `pdftitle` `pdfauthor` `pdfkeywords` from the aliases |
| PDF bookmarks | thesis.tex:59,62; unswcover.sty:48-50 | `meta.hyperref` | `\pdfbookmark{text}{anchor}`; the package guards it with `\@ifundefined{pdfbookmark}` |
| URLs | thesis.tex:53,55 | `meta.url` | `\url{...}` |
| bibliography | thesis.tex:4-5,83,89 | `bib.biblatex-bibtex` | `backend=bibtex`, `\addbibresource{thesis.bib}`, `\printbibliography`, `\cite{...}`; no `style=` so biblatex default; one `@phdthesis` entry (thesis.bib:1) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\theTitle` `\theAuthor` `\theKeywords` | thesis.tex:9-12 | yes | string aliases; inline into `front.maketitle` `\title` `\author` and `meta.hyperref` `pdfkeywords` |
| `\compiledate` savebox | thesis.tex:28-29,51 | yes | kernel box commands plus `lang.babel` `otherlanguage` and `\today`; the box must stay (or the real date be written as text), because the day/month/year overrides come later (thesis.tex:33-35) and `\today` at line 51 would then print the forced date |
| `\renewcommand\day{14}` `\month{12}` `\year{2011}` | thesis.tex:33-35 | yes | a value override with no layout effect; the emitter writes `\date{14 December 2011}` (`front.maketitle`); the exact string babel's australian `\today` gives is not read here |
| `unswcover.sty` macros: `\unswschool`, `\unswdegree`, `\unswcotutelle`, `\unswdissertationsheet`, `\makeunswphdtitlepage`, `\makeunswfrontmatter`, three `\newif` switches | unswcover.sty:29-161 | yes (published, so not bespoke) | published on CTAN, so it is the way `class.unswcover`. Fallback if that way is refused: the `\def` string holders are values; the `\newif` switches (cotutelle, dissertation sheet) are decided once by the emitter; the cover is `pg.break` + `hf.pagestyle-kernel` + `pgnum.pagenumbering` + `sp.ragged` (`center`) + `sp.manual-space` + `font.size-commands` + `mark.kernel` + `fig.graphicx` + `front.titlepage-env` (hand-laid, as the file says it avoids the env, unswcover.sty:3); statements are `front.dedication` + `head.class-native` + `tbl.tabular`; sheet is `pg.include-pdf`. No output routine, no `\halign`, no kernel redefinition. |
| Makefile | Makefile:1-57 | n/a | install, package and logo-conversion rules (inkscape for `.svg` to `.pdf`/`.ps`, Makefile:44-47); the `.svg` is not shipped and the converted logos are, so the document does not need inkscape; it generates no `.tex`. Not EXTERNAL. `bibtex` is the standard TeX-family tool of `bib.biblatex-bibtex`. |

## Content-opaque
none (the logo is an included PDF image under `fig.graphicx`, not drawn artwork; the chapters are empty headings, thesis.tex:69-79)

## Lib changes
- New ways proposed: `class.unswcover` `unswcover` (CTAN, TeX Live), pdf. A UNSW dissertation cover page plus originality, copyright and authenticity statements: `\usepackage{unswcover}`, strings `\unswschool{}` `\unswdegree{}` `\unswcotutelle{}`, file `\unswdissertationsheet{file.pdf}`, body `\makeunswphdtitlepage` or `\makeunswfrontmatter`; needs a class with `\chapter` and the file `logo_unsw_short.pdf` (name fixed, unswcover.sty:69). W1: CTAN release by its author (unswcover.sty:16). W2: behaviour set by strings and a file name. W3: any UNSW thesis, not one document (same scope as `class.ulthese`, an institution's thesis). W4: preamble lines plus one body call. Considered `front.class-native`: it is defined for a class, unswcover is a style package.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
