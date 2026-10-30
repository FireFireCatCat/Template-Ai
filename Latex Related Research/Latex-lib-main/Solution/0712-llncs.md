yes

# 0712-llncs: Springer llncs (Lecture Notes in Computer Science) class kit, v2.26

- Unverified: read from the source, not compiled.
- Source: Source/0712-llncs/ (origin: https://mirrors.ctan.org/macros/latex/contrib/llncs.zip; licence: cc-by-4, README.md:39-40)
- Kind: conference (LNCS proceedings papers; the only sample, llncsdoc.tex, is the class manual, a doc-kind document)
- Lib: v5
- Engine: pdfLaTeX-compatible (the class loads no engine-specific package; the sample's `hyperref` option `dvips`, llncsdoc.tex:8, names the DVI driver, see Verdict)
- Look carried by: class (llncs.cls sets every look; the sample defines no macro of its own, it only calls the class vocabulary and loads `doc`, `graphicx`, `hyperref`)
- Class origin: ctan (Springer's own kit: copyright Springer, README.md:5; ctan.org/pkg/llncs reads: maintainer Markus Richter, v2.26, CC BY 4.0, "Contained in TeX Live as llncs"; so also publisher-official)
- Main file: llncsdoc.tex (other samples: none; history.txt:33 mentions samplepaper.tex but it is not in the zip)
- Read: main yes, zip-local classes and styles all (llncs.cls whole, 1244 lines; splncs04.bst partly: header, ENTRY block, `format.url`/`format.doi`, `format.date`, `presort`, `begin.bib`/`end.bib`; a BibTeX program that the lib holds as a parameter of `bib.bibtex-bst`; history.txt and README.md read)

## Verdict
yes. The zip is Springer's official kit and `llncs.cls` is a published class (W1: CTAN, TeX Live, release by the publisher), so the look is one way, `class.llncs`, with its class-native vocabulary; the sample adds no macro, calls only that vocabulary plus `doc`, `graphicx`, `hyperref`, and `splncs04.bst` is the parameter of `bib.bibtex-bst`. No drawing, no tool outside TeX, no zip-local code. Two items are recorded and are not counted as blockers: the sample loads a package `llncsdoc` that this zip does not ship (llncsdoc.tex:5; README.md:16-28 lists no `.sty`), so it is unread, and it loads `hyperref` with the `dvips` driver (llncsdoc.tex:8), a driver parameter that a pdfTeX emitter drops. This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.llncs` options: none in the sample (`\documentclass{llncs}`, llncsdoc.tex:4). The class declares `envcountreset`, `citeauthoryear`, `oribibl`, `orivec`, `envcountsame`, `envcountsect`, `runningheads`, `openbib` (llncs.cls:25-40), language switches `deutsch` `francais` (llncs.cls:44-45), and passes every other option to `article` (llncs.cls:47). Base: `\LoadClass[twoside]{article}` (llncs.cls:51); it loads `multicol` and `aliascnt` unconditionally (llncs.cls:52-53), both on CTAN, neither needs an outside tool (`aliascnt` serves only `\newaliascnt` for `envcountsame`, llncs.cls:1089, and has no lib way of its own).
- Class-native vocabulary used by the sample: `\title`, `\subtitle`, `\author{}`, `\institute{}`, `\maketitle` (llncsdoc.tex:13-21); math symbols `\grole` `\getsto` `\lid` `\gid` and `\bbbc` `\bbbf` `\bbbh` `\bbbk` `\bbbm` `\bbbn` `\bbbp` `\bbbq` `\bbbr` `\bbbs` `\bbbt` `\bbbz` `\bbbone` (llncsdoc.tex:241-258). Shown only inside `verbatim` (documented, not run): `\titlerunning` `\inst` `\orcidID` `\authorrunning` `\email` `\url` `\homedir` `\keywords` `abstract` `\thanks` `\fnmsep` (llncsdoc.tex:99-221), the theorem environments and `\spnewtheorem` (llncsdoc.tex:270-338), `credits` `\ackname` `\discintname` (llncsdoc.tex:343-358), `\doi` `\bibitem` with option `citeauthoryear` (llncsdoc.tex:376-411), the obsolete options (llncsdoc.tex:420-438).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | llncsdoc.tex:4; llncs.cls:22,51 | `class.llncs` | no options; base `article[twoside]`; options listed above |
| paper and sides | llncs.cls:51; llncsdoc.tex:10 | `page.class-options` | `twoside` fixed by the class; sample line 10 `\makeatletter\@twosidefalse\@mparswitchfalse\makeatother` is the pair of kernel switches that article's `oneside` sets (article.cls not read here), written as `oneside` |
| page geometry | llncs.cls:55-56,234-236,238 | `page.setlength` | textwidth=12.2cm, textheight=19.3cm, oddsidemargin=evensidemargin=63pt, marginparwidth=90pt, headsep=16pt (raw lengths inside the class; the emitter writes nothing extra) |
| footnote length | llncs.cls:240 | `sp.lengths` | footnotesep=7.7pt |
| float placement | llncs.cls:241-242,818,826 | `fig.placement` | textfloatsep=8mm plus 2pt minus 4pt, intextsep=8mm plus 2pt minus 2pt, default placement `htbp` for figure and table |
| columns (index only) | llncs.cls:52,790 | `cols.multicol` | `multicols{2}` in `theindex`; not used by the sample |
| header/footer | llncs.cls:1214-1238 | `hf.class-native` | `\ps@headings` (page number outer, `\leftmark`/`\rightmark` inner, `\headlineindent`=1.166cm), `\ps@titlepage` (number only), default `\ps@empty` unless option `runningheads` |
| sample page style and marks | llncsdoc.tex:21-22 | `hf.pagestyle-kernel` | `\thispagestyle{empty}`, `\markright{...}` (no visible effect under the default `\ps@empty`: inferred) |
| page numbering | llncs.cls:249-255 | `pgnum.pagenumbering` | `\frontmatter` = Roman, `\mainmatter` = arabic, `\backmatter`; not used by the sample |
| spacing switch | llncs.cls:230 | `sp.frenchspacing` | `\frenchspacing` on |
| widow/club | llncs.cls:231-232,704 | `sp.penalties` | `\widowpenalty=10000`, `\clubpenalty=10000` (4000 in the bibliography) |
| font sizes | llncs.cls:204-214,391 | `font.size-commands` | `\small` = `\@setfontsize\small\@ixpt{11}` with display skips and list parameters; `\footnotesize` aliased to `\small`; no font package (Computer Modern default) |
| title block | llncs.cls:849-897,915,923-1038; llncsdoc.tex:13-21 | `front.class-native` | centered `\Large\bfseries\boldmath` title, optional `\large` subtitle, authors with `\and` rules, `\small` `\institutename` numbered `$^n$`, footnote symbols from `\@fnsymbol`, counters reset at `\maketitle` (llncs.cls:925-932); the sample passes empty `\author{}` and `\institute{}` (llncsdoc.tex:18-19) |
| running-head strings | llncs.cls:854-858,955-1001 | `front.class-native` | `\titlerunning`, `\authorrunning` as token lists; over-long text replaced by a fixed message when `runningheads` is on; documented, not run |
| author notes | llncs.cls:947,949-950; llncsdoc.tex:99-109 | `front.thanks` | `\thanks` in the title, `\fnmsep` separator; documented, not run |
| abstract | llncs.cls:1204-1212; llncsdoc.tex:209-214 | `abs.class-native` | list-based, `\small`, leftmargin=rightmargin=1cm, bold run-in `\abstractname` ("Abstract."); documented, not run |
| keywords | llncs.cls:95,906-908; llncsdoc.tex:215-223 | `abs.keywords` | `\keywords{A \and B}`, separator `\textperiodcentered`, label `\keywordname`; documented, not run |
| contents and lists of | llncs.cls:57-58,60-77,527-541,585-622,624-656,668-678 | `toc.kernel` | `\tableofcontents` with `\l@title` `\l@author` `\l@chapter` `\l@part`, tocdepth=0, indents 0/15/23/27/35/43pt; not used by the sample |
| contents look | llncs.cls:543-557,585-622 | `front.class-native` | class-owned toc line formats (the lib folds `toc.class-native` into this way) |
| sectioning | llncs.cls:357-377; llncsdoc.tex:24-415 | `head.class-native` | `\section` `\large\bfseries\boldmath` before -18pt after 12pt; `\subsection` `\normalsize\bfseries` after 8pt; `\subsubsection` run-in bold; `\paragraph` run-in italic; `\subparagraph` disabled with a warning; the sample uses `\section` and `\subsection` only |
| part and chapter | llncs.cls:246-247,257-355 | `head.class-native` | `\part`, `\chapter` centered, `\Huge`/`\Large\bfseries`; for volume compilations; not used by the sample |
| heading depth | llncs.cls:244 | `num.secnumdepth` | secnumdepth=2 |
| counters | llncs.cls:925-932,1058-1059,1089,1145-1148 | `num.counters` | resets at `\maketitle`, theorem counters reset per `chapter` (`envcountreset`: per section), `\newaliascnt` for `envcountsame` |
| acknowledgements | llncs.cls:81,91,218-228; llncsdoc.tex:343-358 | `head.class-native` | `credits` environment: `\small` group with run-in `\subsubsection` and `\paragraph`; names `\ackname`, `\discintname`; documented, not run |
| lists | llncs.cls:495-519,521-522; llncsdoc.tex:366-371,419-439 | `list.kernel` | leftmargini=17pt, labelsep=.5em, topsep 8pt plus 2pt minus 4pt, itemsep=0, `\labelitemi` bold en dash, `\labelitemii` bullet |
| quote | llncsdoc.tex:393-395 | `quote.kernel` | `quote` with the kernel look (the class does not change it) |
| text marks | llncsdoc.tex:13,26,54,108,397 | `mark.kernel` | `\texttt`, `\emph`, `{\em ..}`, `{\sc ..}`, `{\itshape ..}` |
| centering | llncsdoc.tex:238,249 | `sp.ragged` | `center` environment |
| manual spacing | llncsdoc.tex:237,239-240,243,248,259 | `sp.manual-space` | `\smallskip`, `\hspace{1em}` and `\hspace{3em}` in column specs |
| footnotes | llncs.cls:794-804,889-892 | `fn.kernel` | `\footnoterule` 2truecm wide, `\@makefntext` hanging with `\fnindent`=1em (class-owned layout, `class.llncs` vocabulary); no footnote in the sample |
| captions | llncs.cls:806-816,839-844 | `cap.kernel` | `\@makecaption`: `\small`, bold "Fig. n." label, centred when it fits one line; table caption above (abovecaptionskip=0pt, belowcaptionskip=10pt); no float in the sample |
| figures | llncs.cls:818-825; llncsdoc.tex:6 | `fig.graphicx` | `graphicx` loaded, no `figure` or `\includegraphics` in the sample; float box `\small` |
| tables | llncsdoc.tex:239-243,250-259; llncs.cls:524-525,1240-1241 | `tbl.tabular` | `tabular` with `l@{\hspace{1em}yields\hspace{1em}}c@{\hspace{3em}}l...`, arraycolsep=tabcolsep=1.4pt |
| theorem-like | llncs.cls:1040-1183,1198-1202; llncsdoc.tex:264-338 | `thm.class-native` | `\spnewtheorem{env}[like]{Caption}{cap font}{body font}` and starred form; theorem, corollary, definition, lemma, proposition (bold head, italic body); case, conjecture, example, exercise, note, problem, property, question, solution, remark (italic head, roman body); `claim`, `proof` unnumbered (llncs.cls:1153-1154); `\theopargself`; `\qed`; documented, not run |
| math symbols | llncs.cls:379-389,393-398,400-403,405-491; llncsdoc.tex:241-258 | `class.llncs` | class vocabulary in inline maths: italic capital Greek, bold-italic `\vec`, `\qed` square, `\grole` `\getsto` `\lid` `\gid`, `\bbb*` blackboard letters; the sample prints them in two tabulars |
| bibliography env | llncs.cls:680-768 | `bib.thebibliography` | `\section*{\refname}`, `\small`, labels "n." (llncs.cls:684), `\newblock` 0.11em, `\sloppy`; options `citeauthoryear`, `oribibl`, `openbib`; compressed numeric `\cite` ranges (llncs.cls:712-732); not used by the sample |
| BibTeX style | splncs04.bst:1-21,72-98,448-454,1476-1504,1524-1537; llncsdoc.tex:397-405 | `bib.bibtex-bst` | style=splncs04 (shipped, derived from `merlin.mbs`, LPPL, splncs04.bst:41-55); sorts by author, year, title (splncs04.bst:1476-1504); writes `\doi{..}` and `\url{..}` and `\begin{thebibliography}{widest label}`; not used by the sample |
| DOI and URL | llncs.cls:899,906-911; llncsdoc.tex:147,189-192 | `meta.url` | `\url` (class fallback `\def\url#1{#1}` only if undefined), `\doi` as `\href{https://doi.org/..}` when `hyperref` is loaded; the sample uses `\url` once (llncsdoc.tex:147) |
| hyperref | llncsdoc.tex:8; llncs.cls:561-564,919-921 | `meta.hyperref` | options `dvips,bookmarksopen` (the driver is a parameter; see Verdict); the class keeps `\phantomsection` and `\toclevel@*` compatible |
| index | llncs.cls:770-792 | `idx.makeidx` | `theindex` in two `multicols` with `\@makeschapterhead`, `\small`, `\idxquad`=10pt; not used by the sample |
| language names | llncs.cls:44-45,79-198,899-905 | `lang.babel` | `\switcht@albion`/`francais`/`deutsch` name tables, hooked into `babel` via `\extras...`; the sample loads no `babel` |
| cross references | llncsdoc.tex:51,80-81,264,324 | `xref.kernel` | `\label{Sec2}`, `\ref{Sec2}`, `\ref{SecClassOptions}` |
| code and verbatim | llncsdoc.tex:44,61-67,86-88 | `code.verbatim` | `verbatim` environment, `\verb|..|` |
| package documentation | llncsdoc.tex:7,84,266 | `dtx.doc` | `doc` loaded for `\DescribeMacro`, `\DescribeEnv` (margin notes; class `marginparwidth` 90pt, llncs.cls:236) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `llncs.cls` internals (`\@startsection`, `\@makecaption`, `\@maketitle`, `\@dottedtocline`, `\halign`-built symbols `\getsto` `\lid` `\gid` `\grole`, `\spnewtheorem`) | llncs.cls:60-77,357-374,405-440,806-816,923-1138 | not bespoke | code of a published class (W1: CTAN, TeX Live, Springer's own release); recovered as `class.llncs` with the native ways above, not copied; a hand-written class like this would be `BESPOKE/class` if it were zip-local |
| `\makeatletter\@twosidefalse\@mparswitchfalse\makeatother` | llncsdoc.tex:10 | yes | two kernel switches, no zip-defined macro; `page.class-options` `oneside` effect, or the same one preamble line; the reason it is a raw line (`\LoadClass[twoside]` fixes the option, llncs.cls:51) is inferred |
| `llncsdoc` package | llncsdoc.tex:5 | unknown | not shipped (README.md:16-28 and Glob list no `.sty`), so not read; the name suggests manual-formatting support for `doc`; `\AmSTeX` (llncsdoc.tex:246) is defined in no shipped file, probably there; if it were shipped and irreducible it would be `BESPOKE/preamble` |
| `\newcommand`, `\def`, `\newenvironment`, `\setlength` in the sample | llncsdoc.tex:1-442 | none exist | grep finds none in the sample |

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
