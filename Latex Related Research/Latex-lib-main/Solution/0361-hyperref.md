yes

# 0361-hyperref: the hyperref bundle and its manual (hyperref-doc)

- Unverified: read from the source, not compiled.
- Source: Source/0361-hyperref/ (origin: https://mirrors.ctan.org/macros/latex/contrib/hyperref.zip; licence: lppl1.3 per manifest, LPPL 1.3 in hyperref.ins:69-72; the manual itself says GNU FDL, doc/hyperref-doc.tex:9-14)
- Kind: misc (the sample is a software manual, a long `article`; the zip is a CTAN package distribution, not a layout template)
- Lib: v3
- Engine: pdfLaTeX-compatible (the manual has an `\ifTUTeX` branch for `fontspec` that pdfLaTeX does not take, doc/hyperref-doc.tex:130-137)
- Look carried by: mixed (the sample's own preamble sets page, fonts, hyperref options and the command-syntax box; zip-local bmhydoc.sty adds only PDF outline entries and a help section)
- Class origin: tex-distribution-unbundled (kernel `article`, doc/hyperref-doc.tex:21; not in the zip)
- Main file: doc/hyperref-doc.tex (other samples: the documentation drivers inside hyperref.dtx:94-157, backref.dtx:39-67, nameref.dtx:40-72, hyperref-linktarget.dtx:26-38, hyperref-patches.dtx:29-37, hluatex.dtx:15-28, xr-hyper.dtx:31-44; a nested legacy archive paperslides99.zip, see Blockers)
- Read: main yes (all 4070 lines), zip-local classes and styles partly (bmhydoc.sty, minitoc-hyper.sty, ntheorem-hyper.sty, hyperref.ins in full; the .dtx files only at their driver parts and a grep outline, because their code is the published packages themselves; the nested archive's two classes read to stdout only)

## Verdict
`yes`, for the main sample and the style it loads. Every component of doc/hyperref-doc.tex maps to a lib way (an `article` with raw length edits, `longtable`, `description` lists, `verbatim`, `hyperref` options, `bookmark`), and every zip-local macro reduces to lib ways or to a constant at emission time. There is no artwork and no outside tool on the PDF path. Two reductions are borderline and are written out below (the `\section` lowercase hack at doc/hyperref-doc.tex:3615-3644 and the jobname test `\@thisfile` at bmhydoc.sty:105-115); the nested 1999 archive is out of scope but would be `BESPOKE/class` if it were counted.

## Blockers
none

Not counted, recorded:
- `BESPOKE/class` (out of scope, not counted) paperslides99.zip holds the 1999 EuroTeX talk sources with two zip-local classes, `foils99.cls` and `common99.cls`, whose code changes catcodes (`\catcode` of ^^A, ^^B, ^^C and `*` made active for colour and abbreviation markup, common99.cls:24-36, 221-224), rewrites `\verbatim@start` (common99.cls:133-140) and uses the pdfTeX primitive `\pdfannotlink` (foils99.cls:118-141). Nothing in doc/hyperref-doc.tex or bmhydoc.sty loads it, it is not unpacked in the project folder, and its own README says it "probably" does not compile with current systems (read with `unzip -p` to stdout: README.txt:6-7). If a stricter reading counted it, the answer would be `no`.
- the tex4ht branch of the preamble (doc/hyperref-doc.tex:82-105, 157-161) feeds the shipped doc/hyperref-doc*.html; the PDF path never takes it, so it is not an `EXTERNAL` blocker.
- `hyperref.dtx` package code (lines about 200-26760) is the published package; it was not read line by line (grep for `write18`, shell escape, `\directlua` found nothing in any .dtx or .sty).

## Class setting
- Class: `class.article` options: none (doc/hyperref-doc.tex:21; `\RequirePackage{iftex}` sits before it, line 19)
- Class-native vocabulary used: `\title` `\author` (with `\and` and `\thanks`) `\date` `\maketitle` (doc/hyperref-doc.tex:158-175), `\tableofcontents` (:176), `\section` `\subsection` `\subsubsection` and starred forms, `description` `itemize` `enumerate` `quote` `verbatim`, `\footnote`, `\marginpar`, `\pagestyle{headings}` (:69), no `\appendix`, no `abstract`, no bibliography, no index.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | doc/hyperref-doc.tex:21 | `class.article` | no options |
| engine conditionals | doc/hyperref-doc.tex:19, 130-137, 141-154 | none (support package `iftex`) | `\ifpdf` and `\ifTUTeX` choose per-engine lines; the emitter writes the pdfLaTeX branch only, so no printed effect of its own |
| page size and margins | doc/hyperref-doc.tex:61-67 | `page.setlength` | `\advance`: `\textwidth` +1.1in, `\oddsidemargin` and `\evensidemargin` -.55in, `\textheight` +1in, `\topmargin` -.5in, `\footskip` -.5in |
| running head | doc/hyperref-doc.tex:69 | `hf.pagestyle-kernel` | `\pagestyle{headings}` |
| title page without number | doc/hyperref-doc.tex:174 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| overfull-line stretch | doc/hyperref-doc.tex:72 | `sp.lengths` | `\emergencystretch=.1\hsize` |
| badness threshold | doc/hyperref-doc.tex:73 | `sp.hyphenat` | `\hbadness=3000` (raw TeX parameter in the `\sloppy` family; it only silences warnings) |
| text face and encoding | doc/hyperref-doc.tex:134-136 | `font.fontenc-t1`, `font.lmodern`, `font.family-default` | `[T1]{fontenc}`, `lmodern`, `\renewcommand*{\ttdefault}{lmvtt}` |
| text face, Unicode engines (not taken) | doc/hyperref-doc.tex:130-132 | `font.fontspec` | `fontspec`, `\ttdefault` lmvtt |
| symbol and logo glyphs | doc/hyperref-doc.tex:24, 27, 168, 2773, 2808 | `font.icons` | `pifont` (`\ding{43}` style glyphs), `hologo` (`\hologo{LaTeX}` in the title) |
| size and font switches | doc/hyperref-doc.tex:109, 410, 32-33 | `font.size-commands`, `mark.kernel` | `\small`, `\tiny`; `\textsf`, `\texttt`, `\emph`, `\textit`, `\textbf` |
| support package `calc` | doc/hyperref-doc.tex:25, 1036 | none (support package) | only use: column width `p{\widthof{key value}}` inside a `tbl.longtable` column spec, a length expression (a parameter), not a component |
| title block | doc/hyperref-doc.tex:158-169, 175 | `front.maketitle`, `front.thanks`, `meta.url` | `\author{A\thanks{deceased}\and B\thanks{inactive}\and C\thanks{\url{...}}}`, `\title`, `\date{2026-10-09 v7.01s}`; the tex4ht variant at :158-160 is not taken |
| hyperref load | doc/hyperref-doc.tex:141-154 | `meta.hyperref` | options `colorlinks`, `hyperindex`, `plainpages=false`, `bookmarksopen`, `bookmarksnumbered`, `pdfusetitle` (pdf branch); plain `{hyperref}` otherwise |
| bookmark outline at end | bmhydoc.sty:30-38, 40-58 | `meta.bookmark` | `bookmark[atend]`; `\bookmarksetup{startatroot,open,openlevel=2}`; six `\bookmark[gotor={file},color={[rgb]{0,0,1}},level={0..2},view={XYZ null null null}]{text}` entries (hyperref-doc.pdf level 0 `open=false`, slides.pdf 1, paper.pdf 2, hyperref.pdf 1, backref.pdf 2, nameref.pdf 2) |
| contents | doc/hyperref-doc.tex:176 | `toc.kernel` | `\tableofcontents` |
| contents depth | doc/hyperref-doc.tex:177, 3620 | `num.secnumdepth`, `toc.kernel` | `\setcounter{tocdepth}{2}` after the toc (bookmark levels); `\addtocontents{toc}{\protect\setcounter{tocdepth}{1}}` before the licence |
| headings | doc/hyperref-doc.tex:179, 199, 209, 1801-1802, 3258-3259, 3313-3314 | `head.kernel` | article defaults; short toc title with a footnote in the long title (`\section[New Features]{New Features\footnote{...}}`) |
| licence appendix headings | doc/hyperref-doc.tex:3615-3648, 3659, 4037 | `head.kernel`, `meta.hyperref`, `toc.kernel` | headings one level down (`\chapter` as `\section`, `\section` as `\subsection`), starred forms kept, titles lowercase except the first letter, `\hypersetup{bookmarksopenlevel=1}` (:3619); see Bespoke code |
| lists | doc/hyperref-doc.tex:233-239, 468-476, 622-647, 886-894 | `list.kernel` | `description`, `itemize`, `enumerate` |
| list label | doc/hyperref-doc.tex:3839-3889 | `list.kernel`, `num.counters` | `\renewcommand{\labelenumi}{\Alph{enumi}.}` |
| quotes | doc/hyperref-doc.tex:312-314, 697-699 | `quote.kernel` | `quote` |
| code and command text | doc/hyperref-doc.tex:331-333, 424-426, 3223-3225 | `code.verbatim` | `verbatim`, `\verb|..|` |
| line-per-line blocks | doc/hyperref-doc.tex:2203-2214, 2217-2221 | `sp.manual-space` | `{\obeylines ...}` group: each source line is a line break |
| spacing | doc/hyperref-doc.tex:674, 923, 1365 | `sp.manual-space` | `\medskip`, `\smallskip`, `\noindent` |
| page break | doc/hyperref-doc.tex:3645 | `pg.break` | `\clearpage` before the licence |
| option tables | doc/hyperref-doc.tex:129, 675-683, 824-831, 937-972, 1036-1119, 1234-1354 | `tbl.longtable`, `tbl.tabular` | `array` and `longtable`; column specs `>{\ttfamily}ll>{\itshape}ll`, `@{}`, `p{9cm}`, `\hline`, `\\*` |
| plain table | doc/hyperref-doc.tex:597-619 | `tbl.tabular`, `sp.ragged` | `{>{\ttfamily}l>{\raggedright\arraybackslash}p{5cm}}`, `\hline` |
| command-syntax box | doc/hyperref-doc.tex:107-126 | `tbl.tabular`, `font.size-commands`, `sp.manual-space`, `sp.rule`, `pg.break` | `\small`, `\addvspace{3.2ex plus 0.8ex minus 0.2ex}`, `\vskip -\parskip`, one-cell `tabular{\|l\|}` with `\hline`, `\rule{0pt}{1em}`, `\nopagebreak` |
| command-syntax box, HTML branch (not taken) | doc/hyperref-doc.tex:82-105 | `box.fancybox`, `tbl.tabular` | `\fbox` around an `lrbox`; tex4ht only |
| meta variable | doc/hyperref-doc.tex:43-58, 818 | `dtx.doc` | doc.sty's own `\meta` (line 35 says "from doc.sty"); see Bespoke code |
| notes | doc/hyperref-doc.tex:212, 229, 298 | `fn.kernel` | `\footnote` |
| margin notes | doc/hyperref-doc.tex:410, 1865 | `note.marginpar` | `\marginpar{\tiny New in version 7.00s}`, `\marginpar{Deprecated ...}` |
| cross references | doc/hyperref-doc.tex:1143, 1769, 3684, 3783 | `xref.kernel` | `\label`, `\ref`, `\pageref` (hyperref turns them into links) |
| links | doc/hyperref-doc.tex:165, 212, 219 | `meta.url`, `xref.hyperref` | `\url`, `\nolinkurl`; `\href` appears in bmhydoc.sty:77 |
| inline symbols | doc/hyperref-doc.tex:263, 1145, 2168 | `math.kernel` | `$\verb\|"\|$`, `$\times$`, `$\rightarrow$` |
| aliases | doc/hyperref-doc.tex:29-33, 78-79, 139 | `mark.kernel` | `\cs`, `\xpackage`, `\xoption`, `\ci`, `\Quote`; see Bespoke code |
| bibliography, index, floats, math display, theorems | none in the sample | n/a | `hyperindex` is set (:144) but there is no `\printindex`, no `table` or `figure` float, no `equation`; the backref and `thebibliography` code at :2562-2572 sits inside a `verbatim` block (content) |
| documentation driver of hyperref.dtx | hyperref.dtx:95-157 | `class.ltxdoc`, `dtx.doc`, `meta.hyperref`, `font.fontenc-t1`, `font.family-default`, `sp.lengths` | `ltxdoc`; `array,iftex`; `hyperref[colorlinks,hyperindex=false,pdfusetitle,pdfpagelabels]`; `hypdoc[numbered]` (considered a separate way, filed under `dtx.doc` as a doc add-on); `bmhydoc`; `\pdfstringdefDisableCommands{\let\\\textbackslash}`; `\EnableCrossrefs` `\CodelineIndex`; `\setlength{\hfuzz}{2pt}`; `\DocInput` `\PrintIndex` `\GetFileInfo` |
| drivers of backref.dtx and nameref.dtx | backref.dtx:39-67; nameref.dtx:40-72 | `class.ltxdoc`, `dtx.doc`, `front.thanks`, `toc.kernel`, `font.icons` | same pattern; `\thanks` for version and date, `\HyperrefOverview*`, `\tableofcontents`, `hologo` |
| drivers of hyperref-linktarget.dtx and hyperref-patches.dtx | hyperref-linktarget.dtx:26-38; hyperref-patches.dtx:29-37 | `class.l3in2edoc`, `meta.documentmetadata`, `meta.hyperref`, `tbl.tabular`, `tbl.booktabs`, `box.tcolorbox`, `color.xcolor`, `cap.caption` | `\DocumentMetadata{tagging=on}`; `l3in2edoc[full]` (origin not established: ctan.org/pkg/l3in2edoc is a 404 and the class is not in the zip); `\hypersetup{pdfauthor,pdftitle}`; `\newtcolorbox{doccomment}[1][]{enhanced,frame hidden,colback=myblue!10,fontupper=\footnotesize}` with `myblue` RGB 0,33,99 |
| drivers of hluatex.dtx and xr-hyper.dtx | hluatex.dtx:15-28; xr-hyper.dtx:31-44 | `class.ltxdoc`, `class.l3doc`, `dtx.doc`, `front.thanks` | `ltxdoc`; `l3doc` (published, not verified here) |
| index page widening | hyperref.dtx:169-187 | `page.setlength`, `sp.lengths` | `\clearpage`, then `\addtolength{\textwidth}{\marginparwidth}` and `\marginparsep`, `\oddsidemargin` recomputed, `\parfillskip=0pt plus 1fil` before `\theindex` |
| obsolete wrappers | minitoc-hyper.sty:3-7; ntheorem-hyper.sty:3-7 | `toc.etoc`, `thm.ntheorem` | each only warns and does `\RequirePackage{minitoc}` or `{ntheorem}`; the sample loads neither |
| the hyperref code itself | hyperref.dtx:501-26760, nameref.dtx, backref.dtx, xr-hyper.dtx, hyperref-linktarget.dtx, hyperref-patches.dtx, hluatex.dtx | `meta.hyperref`, `xref.hyperref` | the published packages (W1: CTAN, the zip is their own distribution); they are the ways, not a template built on them |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| aliases `\cs` `\xpackage` `\xoption` `\Quote` `\ci` `\bs` | doc/hyperref-doc.tex:29-33, 78-79, 139 | yes | `\texttt{\textbackslash #1}`, `\textsf`, `\textquotedblleft...\textquotedblright`; `\bs` is `\symbol{'134}`, a glyph: `mark.kernel` |
| `\meta` copy with `\newlanguage\l@nohyphenation` | doc/hyperref-doc.tex:36-58 | yes | a copy of doc.sty's `\meta` (the file says so, :35): `\meta` of `dtx.doc`; only the hidden hyphenation switch has no printed effect |
| `cmdsyntax` environment | doc/hyperref-doc.tex:81-127 | yes | one-cell framed `tabular` plus `\small`, `\addvspace`, `\vskip`, `\rule`, `\nopagebreak`: all lib ways (see map); the tex4ht variant is `\fbox`+`lrbox` and is not on the PDF path |
| engine and tex4ht conditionals | doc/hyperref-doc.tex:19, 82, 130, 141, 157 | yes | resolved when the emitter picks pdfLaTeX; they choose setup lines, they do not typeset |
| licence-appendix heading hack: `\let\chapter=\section`, `\def\section` -> `\lc@subsection` -> `\lc@sec` with `\@ifstar`, `\lowercase` and `\edef` | doc/hyperref-doc.tex:3615-3644 | yes (borderline) | the whole effect is a level shift plus a text change: `\chapter` becomes a `\section`, `\section` and `\section*` become `\subsection` and `\subsection*` (`head.kernel`), and each title is lowercase except its first letter. The lowercasing is a content transform done once when the headings are emitted (as the ucsmonograph analysis treated `\uppercase`); the side effects are declarative: `\hypersetup{bookmarksopenlevel=1}` (:3619, `meta.hyperref`) and `\addtocontents{toc}{\protect\setcounter{tocdepth}{1}}` (:3620, `toc.kernel` + `num.secnumdepth`). No lib way performs the case change itself |
| bookmark entries added at end | bmhydoc.sty:32-58 | yes | `\BookmarkAtEnd`, `\AtEndDocument` and `\@bmhydoc` only defer and call `\bookmark[gotor,color,level,view]` six times: `meta.bookmark` parameters (the gotor targets are shipped PDFs in doc/: assets) |
| `\HyperrefOverview`, `\@HyperrefOverview`, local `\entry` | bmhydoc.sty:60-104 | yes | a `\section` (`head.kernel`) with a `description` list (`list.kernel`) whose labels are `\href{file:...}{...}` (`xref.hyperref`); not called by the main sample, called by the drivers (hyperref.dtx:135-139, backref.dtx:60-62, nameref.dtx:65-67) |
| `\@thisfile` | bmhydoc.sty:105-115 | yes (borderline) | `\edef\@jobname{\jobname}` and `\@onelevel@sanitize` compare an entry name with the job name and print `\marginpar{\hfill\ding{43}}` plus "(this file)". The test depends only on which driver file is being typeset, so it is a constant per document: write the marker (`note.marginpar`, `font.icons`) in that entry and nowhere else. Stricter reading: a hand-rolled conditional that drives printing; then it would be `BESPOKE/class`, but the main sample never calls it |
| index page widening wrapper | hyperref.dtx:169-187 | yes | `\let\SavedTheIndex\theindex` and `\def\theindex{...}` only run length assignments and `\clearpage` before the saved index: `page.setlength` and `sp.lengths` |
| driver macros `\Email` | hyperref.dtx:150 | yes | `\let\Email\nolinkurl`: `xref.hyperref` |
| `\newtcolorbox{doccomment}` | hyperref-linktarget.dtx:33 | yes | `box.tcolorbox` keys `enhanced,frame hidden,colback=myblue!10,fontupper=\footnotesize` |
| the hyperref bundle code | hyperref.dtx and the other .dtx | not bespoke | published packages (W1), not template code; no shell escape, no Lua, no outside tool found by grep |

## Content-opaque
none (the `verbatim` examples and the GNU FDL text are content; there is no TikZ, PGF, picture or included image in the sample)

## Lib changes
- New ways proposed: none. Considered and not proposed: `calc` and `iftex` (load-only support packages with no printed effect of their own, as earlier analysts filed them); `hypdoc` (a doc add-on loaded after `ltxdoc`, filed under `dtx.doc`; its only option in the drivers is `numbered`); `class.l3in2edoc` and `class.l3doc` are class ways, written plainly, with origin not established or not verified.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Vocabulary recorded for the class ways: `class.article`: `\title` `\author` `\and` `\thanks` `\date` `\maketitle`, `\tableofcontents`, `\section` family, `\pagestyle{headings}`; `class.ltxdoc`: `\GetFileInfo`, `\EnableCrossrefs`, `\CodelineIndex`, `\DocInput`, `\PrintIndex`, `\MakeShortVerb`, `\StopEventually`, `\Finale` (hyperref.dtx:116-117, 151, 155, 160-161); `class.l3in2edoc`: `documentation`, `implementation`, `function`, `syntax` environments, option `full` (hyperref-linktarget.dtx:27, 58).
