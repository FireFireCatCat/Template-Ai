yes

# 0644-rorygregson-oscola-latex-template: OSCOLA LaTeX Template (law thesis / law article)

- Unverified: read from the source, not compiled.
- Source: Source/0644-rorygregson-oscola-latex-template/ (origin: https://codeload.github.com/rorygregson/OSCOLA-LaTeX-Template/zip/refs/heads/master; licence: not established)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (no fontspec or unicode-math; biblatex needs the biber program, README.md:21)
- Look carried by: zip-local (`classes/law-thesis.cls` loads `book` and sets every look decision; `thesis.tex` only chooses the class and the file order; `classes/law-article.cls` is the swap-in alternative, thesis.tex:5)
- Class origin: zip-local (personal template classes from a GitHub repository; not read at ctan.org; the LaTeX behind them is `book`/`article` plus published packages)
- Main file: thesis.tex (other samples: none; `classes/law-article.cls` is a second class chosen by uncommenting thesis.tex:5)
- Read: main yes, zip-local classes and styles all (law-thesis.cls 110 lines, law-article.cls 89 lines, every chapter, front-matter and back-matter file; references/references.bib lines 1-60 and references/templates.bib lines 1-40 only, they are bibliographic content; README.docx not read, README.md read)

## Verdict
Yes. Both zip-local classes are `\LoadClass{book}` or `\LoadClass{article}` followed by `\usepackage` lines and published-command settings (class lines 3-110 and 3-89); all of it reduces to lib ways, and the one zip-local macro `\chaptoc` is an alias of two `titletoc` commands. One way is new, `quote.quoting` (the CTAN package `quoting`). There is no artwork and no hand-rolled counter, conditional or output routine. Build chain: pdflatex, biber, then `splitindex` plus makeindex for the tables of cases and statutes (thesis.tex:16, law-thesis.cls:16 `noautomatic`). I count `splitindex` as the same type of TeX-distribution post-processor as biber and makeindex (not shell escape, not a non-TeX tool such as pygments), so it is recorded, not a blocker; a reviewer who counts it as `EXTERNAL/package` would turn the verdict to `no`.

## Blockers
none

## Class setting
- Class: `class.book` options: `a4paper, oneside, 12pt` (classes/law-thesis.cls:3), reached through the zip-local wrapper `classes/law-thesis` (thesis.tex:4; `\ProvidesClass` at classes/law-thesis.cls:1). Alternative: `class.article` options `a4paper, 12pt` (classes/law-article.cls:3, selected by thesis.tex:5).
- Class-native vocabulary used: `\chapter`, `\section`, `\subsection`, `\subsubsection` (chapters/chapter1.tex:1-22), `\frontmatter` `\mainmatter` `\backmatter` (thesis.tex:13,19,30), `titlepage` environment (frontmatter/title.tex:1), `\tableofcontents` (frontmatter/tables.tex:5), marks `\leftmark` (classes/law-thesis.cls:63). Not used: `\appendix`, `abstract` environment.
- Published, not bundled: `biblatex-oscola` (style `oscola`, CTAN `oscola` v1.7, Paul Stanley, LPPL 1.3, in TeX Live; README.md:23; page read at ctan.org/pkg/oscola; its source not read). The user has to install it; the zip does not ship it.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | thesis.tex:4; classes/law-thesis.cls:3 | `class.book` | a4paper, oneside, 12pt (alternative `class.article`: classes/law-article.cls:3) |
| paper and size | classes/law-thesis.cls:3 | `page.class-options` | a4paper, 12pt, oneside |
| page geometry | classes/law-thesis.cls:51-53 | `page.setlength` | `\hoffset`=0mm, `\oddsidemargin`=7mm, `\textwidth`=146mm (comment at :54-57 gives the 34mm margin reasoning) |
| header and footer | classes/law-thesis.cls:60-64 | `hf.fancyhdr` | `\fancyhf{}`, `\pagestyle{fancy}`, `\fancyhead[R]{\bfseries\leftmark}`, `\fancyfoot[C]{\thepage}` (article: `\rightmark`, law-article.cls:59) |
| header changes inside the body | frontmatter/abstract.tex:1-2,13; frontmatter/tables.tex:8,18 | `hf.fancyhdr`, `hf.pagestyle-kernel` | `\thispagestyle{plain}`; `\fancyhead[R]{\textbf{ABSTRACT}}` and `{\textbf{TABLE OF CASES}}`, each reset to `\bfseries\leftmark` |
| running-head marks in a heading | backmatter/bibliography.tex:13-16 | `hf.fancyhdr` | `\markboth{BIBLIOGRAPHY -- \MakeUppercase{#1}}{...}` (marks read by `\leftmark`) |
| chapter heading look | classes/law-thesis.cls:67-68 | `head.titlesec` | `\titleformat{\chapter}{\Huge\bfseries\centering}{\thechapter}{20pt}{}` |
| sectioning | chapters/chapter1.tex:1,4,6,22; chapters/chapter2.tex:1,4,6 | `head.kernel` | `\chapter` to `\subsubsection`; sections of chapters 2-6 are the same placeholders |
| numbering and toc depth | classes/law-thesis.cls:71,101 | `num.secnumdepth` | secnumdepth=4, tocdepth=1 |
| line spacing | classes/law-thesis.cls:75-76 | `sp.setspace`, `sp.linespread` | `\usepackage{setspace}` (no options), `\linespread{2}` |
| spacing changes inside the body | frontmatter/tables.tex:1,25; backmatter/bibliography.tex:1 | `sp.setspace` | `\spacing{1.5}` then `\spacing{2}` (setspace's `spacing` environment opener used unpaired; setspace source not read) |
| French spacing | classes/law-thesis.cls:73 | `sp.frenchspacing` | `\frenchspacing` |
| microtype | classes/law-thesis.cls:74 | `sp.microtype` | defaults |
| block quotations | classes/law-thesis.cls:79-80; chapters/chapter1.tex:15-17 | `quote.quoting` | `\usepackage{quoting}`, `\quotingsetup{font=singlespace}`, body `quoting` environment |
| lists | classes/law-thesis.cls:83-85 | `list.enumitem` | enumerate: itemsep=0px, parsep=0px, leftmargin=1.75cm, rightmargin=1cm, label=(\arabic*); itemize: same plus labelsep=4mm (no list in the sample body) |
| footnote layout | classes/law-thesis.cls:88-89 | `fn.footmisc`, `sp.lengths` | options `bottom, hang`; `\footnotesep`=20pt |
| footnotes in text | chapters/chapter1.tex:23,31 | `fn.kernel` | `\footnote{...}`, citations inside notes |
| bibliography engine | classes/law-thesis.cls:11,13 | `bib.biblatex-biber` | style=oscola, indexing=cite, ibidtracker=false, citereset=chapter; `\addbibresource{references/references.bib}` |
| URL delimiters | classes/law-thesis.cls:92-93 | `bib.biblatex-biber` | `\renewcommand{\legalstarturl}{\textless}`, `\legalendurl` = `\textgreater` (macros of the oscola style, defined in no zip file) |
| bibliography printing | backmatter/bibliography.tex:9-10,13-16,20,24,28,32 | `bib.biblatex-biber` | four `\printbibliography[title, type/filter/nottype, heading=mysubbibintoc]`; `\defbibfilter{inbookorincoll}`; `\defbibheading{mysubbibintoc}` |
| bibliography heading body | backmatter/bibliography.tex:6,14-15 | `head.kernel`, `toc.kernel`, `mark.case` | `\chapter{Bibliography}`, `\section*{#1}`, `\addcontentsline{toc}{section}{#1}`, `\MakeUppercase` |
| citations in text | chapters/chapter1.tex:38-51 | `bib.biblatex-biber` | `\cite{key}`, `\cite[10]{key}`, oscola pinpoint `\cite[1012\|680--81]{moses}` (arguments are content) |
| quotation marks | classes/law-thesis.cls:12 | `lang.csquotes` | `style=british` |
| tables of cases and statutes | classes/law-thesis.cls:16-25,28-42,45; frontmatter/tables.tex:7,10-16,20,22-23 | `idx.makeidx` | `imakeidx[splitindex,noautomatic]`; nine `\makeindex[name=,title=,columns=1,intoc]`; fifteen `\DeclareIndexAssociation{virtual}{real}`; `\indexsetup{level=\section*,toclevel=section,noclearpage}`; body `\printindexearly[name]` x9 after `\chapter{Table of cases}` and `\chapter{Table of statutes}` (`\DeclareIndexAssociation` and `\printindexearly` are defined in no zip file; I take them from imakeidx or the oscola style, not read) |
| contents | frontmatter/tables.tex:4-5 | `toc.kernel` | `\addcontentsline{toc}{chapter}{Contents}`, `\tableofcontents` |
| contents title look | classes/law-thesis.cls:96,98-99 | `toc.tocloft` | `\cfttoctitlefont`=`\Huge\bfseries\hfill`, `\cftaftertoctitle`=`\hfill` |
| contents at chapter start | classes/law-thesis.cls:104-106; chapters/chapter1.tex:2; chapters/chapter2.tex:2; backmatter/bibliography.tex:2 | `toc.titletoc` | `\startcontents`, `\printcontents{}{1}{...}`, `\stopcontents` (see bespoke row `\chaptoc`) |
| links and pdf metadata | classes/law-thesis.cls:110 | `meta.hyperref` | colorlinks=true, linktoc=all, hyperfootnotes=false (loaded last, :109) |
| cross-references | chapters/chapter1.tex:26-27,31 | `xref.kernel` | `\label`, `\ref` |
| text marks | chapters/chapter1.tex:34; frontmatter/title.tex:4,10 | `mark.kernel` | `\textbf`, `\emph`, `\underline`, `\textsc`, `\textit` |
| verbatim package | classes/law-thesis.cls:7 | `code.verbatim` | load-only (`comment` environment, not used in the sample) |
| title page | frontmatter/title.tex:1-15 | `front.titlepage-env` | `titlepage`, `center`, `\vfill` x3, `\Huge\textsc{...}`, `\large`, text lines |
| title page spacing, size, alignment | frontmatter/title.tex:2-6 | `sp.manual-space`, `font.size-commands`, `sp.ragged` | `\vfill`; `\Huge`, `\large`; `center` environment |
| abstract page | frontmatter/abstract.tex:3,5-10 | `front.dedication`, `toc.kernel`, `sp.manual-space` | hand-laid page: `\addcontentsline{toc}{chapter}{Abstract}`, centred `\Huge \textbf{Abstract}`, `\vspace{20pt}`, `\noindent` (no `abstract` environment) |
| page break | frontmatter/abstract.tex:12 | `pg.break` | `\newpage` |
| front/main/back matter | thesis.tex:13,19,30 | `class.book` | `\frontmatter` `\mainmatter` `\backmatter` (class vocabulary; no explicit `\pagenumbering`) |
| file structure | thesis.tex:1,11-17,20-25,31 | `struct.input` | `\include{path}` x10, `\includeonly` commented at :1 |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class `law-thesis` | classes/law-thesis.cls:1-110 | yes | `class.book[a4paper,oneside,12pt]` plus the preamble ways in the map above, written in the same order (biblatex, csquotes, imakeidx, margins, fancyhdr, titlesec, counters, spacing, quoting, enumitem, footmisc, tocloft, titletoc, hyperref last); no macro logic |
| class `law-article` | classes/law-article.cls:1-89 | yes | same list on `class.article[a4paper,12pt]`; no titlesec, tocloft or titletoc; `\rightmark` in the head (:59) |
| `\chaptoc` | classes/law-thesis.cls:105 | yes | alias by inline expansion at each chapter start: `\startcontents\printcontents{}{1}{\setcounter{tocdepth}{9}\singlespacing}` (`toc.titletoc`, `num.secnumdepth`, `sp.setspace`) |
| `\defbibfilter`, `\defbibheading` | backmatter/bibliography.tex:9-10,13-16 | yes | biblatex declarations (published API) whose bodies are kernel and lib commands, listed in the map |
| `\fancyhead[R]` switching, `\spacing{}` switching | frontmatter/abstract.tex:2,13; frontmatter/tables.tex:1,8,18,25; backmatter/bibliography.tex:1 | yes | published commands printed at those points of the body, in order; no conditionals or counters of the zip |
| `\renewcommand{\legalstarturl}`, `\legalendurl` | classes/law-thesis.cls:92-93 | yes | string settings of the oscola style (value `\textless`, `\textgreater`) |

No `\newcommand` other than `\chaptoc`, no `\def`, `\newcounter`, `\newif`, `\@startsection`, `\@maketitle` or `\@makecaption` redefinition anywhere in the zip (Grep and full reads).

## Content-opaque
none (the `.bib` entries in references/references.bib and references/templates.bib are bibliographic content)

## Lib changes
- New ways proposed: `quote.quoting` `quoting` package (CTAN, Thomas Titz, LPPL 1.3, v0.1c; page read at ctan.org/pkg/quoting), pdfLaTeX; `\usepackage{quoting}`, `\quotingsetup{key=value}` (key-value interface; only `font=singlespace` seen, classes/law-thesis.cls:80) and body `quoting` environment (chapters/chapter1.tex:15). W1: on CTAN. W2: behaviour by key=value options (font, spacing, orphan control per the CTAN page). W3: any displayed quotation. W4: one preamble line, one setup line, one body wrapper. Not `quote.kernel` (kernel `quote`/`quotation`/`verse` only; a package is a separate way, as `quote.verse-pkg`); `grep -n 'quoting' _Lib.md` found nothing.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
