yes

# 0083-ntu-thesis: NTU Thesis (Nanyang Technological University PhD thesis, Thesis.cls derived from Steve Gunn's ECSthesis)

- Unverified: read from the source, not compiled.
- Source: Source/0083-ntu-thesis/ (origin: https://latextemplates.com/downloads/ntu-thesis.zip; licence: MIT, LICENSE:1-3, copyright Chen Wang, NTU)
- Kind: thesis
- Lib: v1
- Engine: pdfLaTeX-compatible (no fontspec, no Unicode-engine code; PNG images, TikZ, hyperref, natbib)
- Look carried by: zip-local (Thesis.cls, a `\LoadClass{book}` shell with hand-laid front matter; main.tex adds the running heads and `\setstretch` in the body, main.tex:26-32, 94-99)
- Class origin: zip-local (CTAN `thesis` is a different package, a 404 for `ecsthesis`, a 404 for `lstpatch`; the zip came from latextemplates.com, not a university's official kit; the base class `book` is published)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (Thesis.cls 556 lines, Styles/mydefs.sty 33, Styles/lstpatch.sty 393, plus Chapters/, Appendices/, references.bib, LICENSE, the three PNGs viewed)

## Verdict
`yes`. The look lives in the zip-local `Thesis.cls`, but every piece of it is a composition of published packages and kernel commands: `\LoadClass{book}`, `vmargin`, `setspace`, `fancyhdr`, `amsthm`, `caption`, `listings`, `hyperref` and hand-laid pages (title, three declarations, acknowledgements, abstract, dedication) made of `titlepage`, `\vfill`, `\rule`, `\dotfill`, `\includegraphics`. The only TikZ in the zip is a node that places a shipped PNG tile with `opacity=0.9` (Thesis.cls:461-462), so it is an image placement, not drawn artwork. Three judgement calls (the stamp node, `lstpatch.sty`, `epstopdf`) are written out under "Bespoke code" with the scope they would carry if a stricter reading flips them.

## Blockers
none

## Class setting
- Class: `class.book` (reached through the zip-local `Thesis.cls`: `\def\baseclass{book}` Thesis.cls:31, `\LoadClass{\baseclass}` :45); options 12pt, a4paper (main.tex:1; `a4paper` is also forced at Thesis.cls:43; 11pt is the default if none of 10pt/11pt/12pt is given, :42). `twoside` and `openright` are book's own defaults (kernel class, not read), although main.tex:1 comments "one-sided".
- Class-native vocabulary used: book's `\frontmatter` `\mainmatter` (main.tex:24, 92), `\backmatter` (redefined, Thesis.cls:545), `\chapter`, `\chaptermark`, `\appendix`, `\cleardoublepage`. Thesis.cls vocabulary used by the sample: `\thesistitle` `\supervisor` `\degree` `\authors` `\university` `\department` `\group` (main.tex:14-20), `\maketitle`, `\thesisdeclareOriginality` `\thesisdeclareSupervisor` `\thesisdeclareAuthorship` (main.tex:36-40), `\acknowledgements` (main.tex:44), `\addtotoc` (main.tex:67), `\abstract{...}` (the environment's begin code used as a command with a braced body, main.tex:69; no `\endabstract`, so the class's end code at Thesis.cls:340-343 never runs and the next `\chapter*` supplies the page break), `\tableofcontents` `\listoffigures` `\listoftables` (redefined), and the alias `\cref` (Thesis.cls:131, used at Chapter1.tex:37-38).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | Thesis.cls:31,45; main.tex:1 | `class.book` | 12pt, a4paper (book defaults twoside, openright) |
| option plumbing | Thesis.cls:32-44 | `page.class-options` | `\PassOptionsToClass` of every option to book; default 11pt; a4paper forced |
| page geometry | Thesis.cls:70-81 | `page.vmargin` | `\setmarginsrb` left 1.456in, top 0.8in, right 1.0in, bottom 0.8in, head height 20pt, head sep 0.25in, foot height 9pt, foot sep 0.3in |
| bottom flush | Thesis.cls:83 | `pg.flush` | `\raggedbottom` |
| text shape lengths | Thesis.cls:68-69,84 | `sp.lengths` | parindent 0pt, parskip 2.0ex plus0.5ex minus0.2ex, topskip `1\topskip plus 5pt` |
| line spacing | Thesis.cls:66-67; main.tex:26,42,94,115 | `sp.setspace` | `\onehalfspacing` (class), `\setstretch{1.3}` in front/main matter, `\setstretch{1}` before the bibliography |
| widow/break control | Thesis.cls:85-89 | `sp.penalties` | doublehyphendemerits 10000, brokenpenalty 10000, widowpenalty 9999, clubpenalty 9999, interfootnotelinepenalty 9999 (TeX integer parameters, same family) |
| running heads | Thesis.cls:90-94; main.tex:28-32,61-65,96-99 | `hf.fancyhdr` | `\lhead[\rm\thepage]{\fancyplain{}{\sl\rightmark}}`, `\rhead[...]{\rm\thepage}`, empty chead/foot fields; sample resets: `\fancyhead[LO]{\sl\leftmark}`, `[RE]{\sl\rightmark}`, `[LE,RO]{\thepage}` |
| running-head marks | Thesis.cls:95-98; Chapter1.tex:3 | `hf.fancyhdr` | `\chaptermark` = `\markboth{\@chapapp\ \thechapter.\ #1}` both sides (no uppercase), `\sectionmark` = `\markright{\thesection.\ #1}`, `\subsectionmark` empty; `\btypeout` inside is log only |
| page styles | Thesis.cls:51,321,441; main.tex:28,52,61,84 | `hf.pagestyle-kernel` | `\pagestyle{fancy,empty}`, `\thispagestyle{plain,empty}` on declaration/abstract/acknowledgement pages |
| blank verso pages | Thesis.cls:99-103 | `pg.emptypage` | kernel `\cleardoublepage` whose inserted page gets `\thispagestyle{empty}` |
| page breaks | Thesis.cls:58,286,366,402,446; main.tex:59,110 | `pg.break` | `\cleardoublepage` after every front-matter page |
| page numbering | main.tex:24,93 | `pgnum.pagenumbering` | `\frontmatter` (roman), `\mainmatter` + `\pagenumbering{arabic}` |
| title page | Thesis.cls:262-287; main.tex:34 | `front.titlepage-env` | `titlepage` + `center`, `\setstretch{2}`, `\vfill` x4, bold `\LARGE` title between two `\rule{\linewidth}{2pt}` with `\vspace{-7pt}`, `\href`-wrapped logo `\includegraphics[width=230pt]`, author `\Large\textbf`, department `\large`, fixed submission sentence, `\the\year` |
| title page (review variant) | Thesis.cls:289-312 | `front.titlepage-env` | same without logo and rules; defined, not called by the sample |
| title page rules | Thesis.cls:273 | `sp.rule` | two `\rule{\linewidth}{2pt}` around the title |
| title and declaration spacing | Thesis.cls:273-283,458,465,480,487 | `sp.manual-space` | `\vfill`, `\vspace{-7pt}`, `\\[1cm]`, `\\[2cm]`, `\vspace{2.5cm}`, `\vspace{-1.8cm}`, `\hfill` |
| title page text sizes | Thesis.cls:273-283,456 | `font.size-commands` | `\LARGE`, `\Large`, `\large`, `\huge`, `\Huge` |
| marks | Thesis.cls:54,456,478,500; main.tex:30 | `mark.kernel` | `\textbf`, `\bf`, `\sl`, `\em`, `\underline`, `\textnormal` |
| PDF metadata | Thesis.cls:171-178,264-267 | `meta.hyperref` | pdfpagemode=UseOutlines, bookmarks=true, bookmarksopen, bookmarksopenlevel=1, bookmarksnumbered, hypertexnames, colorlinks, linkcolor/citecolor=blue, urlcolor=black, pdfstartview=FitV, unicode, breaklinks, plainpages=false, backref=page; `\hypersetup{pdftitle,pdfsubject,pdfauthor,pdfkeywords}` in `\maketitle`; `\pdfstringdefDisableCommands`, `\texorpdfstring`, `\href` |
| declaration pages (x3) | Thesis.cls:452-519; main.tex:36-40 | `front.dedication` | `\thispagestyle{empty}`, `spacing` env (2), centred `\Large\underline{\bf title}`, `\textnormal{\large text}`, two `\makebox[4cm]` columns joined by `\hfill`: date text and signature `\includegraphics[height=0.9cm]`, dotted line `\makebox[4cm]{\dotfill}`, labels "Date" and name; `\cleardoublepage` |
| declaration dotted lines | Thesis.cls:467,489,514 | `sp.rule` | `\dotfill` inside `\makebox[4cm]` |
| declaration stamp | Thesis.cls:461-462,483-484,508-509 | `fig.graphicx` | `\includegraphics[width=4cm,height=1.527cm]{Styles/ntu-watermark.png}` (a 275x105 "NTU NTU" text tile); see Bespoke code row 14 |
| declaration stamp opacity | Thesis.cls:462,484,509 | `color.transparent` | `\transparent{0.9}` for `opacity=0.9` |
| declaration stamp offset | Thesis.cls:461-462 | `sp.manual-space` | zero-width `\makebox` + `\hspace` + `\raisebox` for the node at (2.13cm, 0.5cm) |
| acknowledgements page | Thesis.cls:438-447; main.tex:44-50 | `front.dedication` | `\thispagestyle{plain}`, `\vspace*{1.5cm}`, `\flushleft\Huge\textbf{Acknowledgements}` in `center`, `\vfil\vfil\null`, `\cleardoublepage`; `\addtocontents{toc}{\vspace{0.8em}}` in the argument |
| dedication page | main.tex:52-59 | `front.dedication` | `\pagestyle{empty}`, `\null\vfill`, centred `\large` line, `\vfill\vfill\null`, `\cleardoublepage` (hand-laid in the sample); class has `\dedicatory` too (Thesis.cls:536-544, `\vskip 60\p@`, `\Large\sl`) |
| other front pages (defined, not called) | Thesis.cls:48-59,522-534 | `front.dedication` | `\Declaration` (centred `\huge\bf`), `\authorpublications` (`\flushleft\Huge\textbf` heading with `\footnote[1]` via `fn.kernel`) |
| abstract | Thesis.cls:318-343; main.tex:67-82 | `abs.class-native` | `\thispagestyle{plain}`, `\vspace*{1.5cm}`, `center` with `\setlength{\parskip}{0pt}`, `{\flushleft\Huge\textbf{Abstract}\par}`; end code `\vfil\vfil\vfil\null\cleardoublepage` |
| flush-left heading in centre env | Thesis.cls:328,443,530 | `sp.ragged` | `\flushleft` |
| contents, lists | Thesis.cls:352-404; main.tex:86-90 | `toc.kernel` | `\tableofcontents` `\listoffigures` `\listoftables` each: `spacing` env (1), `\parskip` 1pt, `\chapter*{\contentsname \@mkboth{upper}{upper}}`, `\@starttoc`, `\cleardoublepage`; lof/lot first add a toc entry |
| spacing wrap of the lists | Thesis.cls:354,372,390 | `sp.setspace` | `\begin{spacing}{1}` |
| toc entries for unnumbered pages | Thesis.cls:348-351,67,551 | `toc.kernel` | `\addcontentsline{toc}{chapter}{...}` after `\refstepcounter{dummy}` (anchor for hyperref); `\addtocontents{toc}{\vspace{0.8em}}` (main.tex:44,69,104) |
| depth counters | Thesis.cls:346-347 | `num.secnumdepth` | `\addtocounter{secnumdepth}{1}`, `\setcounter{tocdepth}{6}` |
| headings | Chapter1.tex:2,6; Chapter2.tex:2 | `head.kernel` | book's own `\chapter`/`\section` look, no `\titleformat`; `\chaptermark` call after `\chapter` |
| appendix | main.tex:106-108; AppendixA.tex:2 | `num.appendix` | `\appendix` then `\chapter` |
| lists | Chapter1.tex:26-34 | `list.kernel` | `itemize`, three `\item` |
| theorem-like statements | Thesis.cls:104-121 | `thm.amsthm` | `\theoremstyle{plain}`: theorem [chapter], corollary and lemma and axiom share theorem's counter, proposition [chapter]; `definition`: definition, assumption, example [chapter]; `\newtheorem*{pf}{Proof}`; `remark`: remark [chapter]. Not used in the sample body |
| AMS maths | Thesis.cls:104; main.tex:6-7 | `math.amsmath` | `amsmath`, `amsfonts` (and `amssymb` in main.tex) |
| AMS symbols | Thesis.cls:104; main.tex:7 | `math.amssymb` | `amsfonts`, `amssymb` |
| commutative diagrams (loaded, unused) | Thesis.cls:104 | `art.content-package` | `amscd` load-only; `xspace` is a macro-writing helper with no look and no call in the zip (grep) |
| captions | Thesis.cls:123-125 | `cap.caption` | `[centerlast,small,sc]`, `\captionsetup{justification=justified,singlelinecheck=true}`, `\setlength{\captionmargin}{20pt}` (legacy caption2 length; current key is `margin=20pt`) |
| cross-reference aliases | Thesis.cls:126-139; Chapter1.tex:37-38 | `xref.kernel` | `\newcommand{\cref}[1]{Chapter~\ref{#1}}` and 13 siblings (`\fref` Figure, `\tref` Table, `\eref` Equation~(...), ...); `\label` at Chapter1.tex:4, main.tex:114 |
| float placement | Thesis.cls:141-150 | `fig.placement` | topfraction .85, bottomfraction .85, textfraction .1, dbltopfraction .85, floatpagefraction .75, dblfloatpagefraction .75, topnumber 9, bottomnumber 9, totalnumber 20, dbltopnumber 9 |
| images | Thesis.cls:151-152; main.tex:3 | `fig.graphicx` | `graphicx`, `epstopdf` (converter only runs for an included .eps; none here), `\graphicspath{{./Figures/}}` (folder not shipped, no figure used) |
| rotation (loaded, unused) | Thesis.cls:155 | `fig.rotating` | `rotating` |
| tables | Thesis.cls:154,406,417,428 | `tbl.booktabs` | `booktabs` |
| long tables for lists | Thesis.cls:405-437 | `tbl.longtable` | `\listofsymbols{cols}{rows}` `\listofconstants` `\listofnomenclature`: `\chapter*` + `\addtotoc` + `longtable[c]{#1}#2`; names "Abbreviations", "Physical Constants", "Symbols and Acronyms"; not called by the sample |
| code listings | Thesis.cls:156-167 | `code.listings` | `\lstset{captionpos=b, frame=tb, basicstyle=\scriptsize\ttfamily, showstringspaces=false, keepspaces=true}`; `\lstdefinestyle{matlab}{language=Matlab, keywordstyle=\color{blue}, commentstyle=\color[rgb]{0.13,0.55,0.13}\em, stringstyle=\color[rgb]{0.7,0,0}}`; no listing in the sample |
| colours | Thesis.cls:166-167,173; mydefs.sty:28 | `color.xcolor` | blue, rgb(0.13,0.55,0.13), rgb(0.7,0,0), red (`\textcolor` in `\alert`); `xcolor` comes in through `tikz` |
| overlay package (loaded, unused) | Thesis.cls:450 | `bg.eso-pic` | `eso-pic` load-only, no `\AddToShipoutPicture` anywhere (grep) |
| bibliography | main.tex:8,114-117; Chapter1.tex:13 | `bib.natbib` | `[square, numbers, comma, sort&compress]`, `\citep` |
| bibliography backend | main.tex:116-117 | `bib.bibtex-bst` | `\bibliographystyle{unsrtnat}`, `\bibliography{References/references}`; `bibtex` is the TeX Live processor |
| back matter | Thesis.cls:545-553; main.tex:110-117 | `toc.kernel` | redefined `\backmatter`: `\cleardoublepage` (openright) + toc entry for `\bibname` + `\@mainmatterfalse`; sample `\cleardoublepage` before it |
| author macros and shorthands | mydefs.sty:4-34 | `math.amsmath` | `\def`/`\newcommand` aliases only (`\norm`, `\abs`, `\expect`, `\diag`, `\alert`, `\etal`, `\myfigwidth`...) ; none used by the sample body |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| 1. Class shell and option plumbing (`\@checkoptions`, `\DeclareOption*`) | Thesis.cls:27-45 | yes | `class.book` with options 12pt, a4paper; the 11pt default is an emitter default; no printed output |
| 2. `\bhrule`, `\btypeout` | Thesis.cls:46,61 | yes | `\typeout` log lines only; dropped |
| 3. `\def\today` month-and-year | Thesis.cls:62-65 | yes | `front.datetime`: `\newdateformat{monthyear}{\monthname[\THEMONTH] \THEYEAR}`; the sample never calls `\today` (title page prints `\the\year`) |
| 4. `\def\cleardoublepage` | Thesis.cls:99-103 | yes | a copy of the kernel's own definition plus `\thispagestyle{empty}`; that is `pg.emptypage` |
| 5. `\chaptermark` `\sectionmark` `\subsectionmark` redefinitions | Thesis.cls:95-98 | yes | the `\renewcommand\chaptermark{\markboth{...}{...}}` form that `fancyhdr`'s manual documents; text in the map |
| 6. Data macros (`\supervisor` ... `\FACULTY`) and defaults with `\texorpdfstring{\href..}` | Thesis.cls:179-252 | yes | `\newcommand*{\x}[1]{\def\xname{#1}}` string stores; the emitter prints the document-model fields directly (supervisor, degree, author, department; `\university`, `\group`, upper-case variants and `\examiner` are stored, never printed) |
| 7. `\maketitle`, `\maketitleforreview` | Thesis.cls:262-312 | yes | `front.titlepage-env` hand-laid page, composition in the map; `\ttitle` is used instead of `\@title`, so `\title{\ttitle}` only feeds `pdftitle` |
| 8. `abstract` environment | Thesis.cls:318-343 | yes | `abs.class-native` hand-laid page; sample's `\abstract{...}` form is a begin-code call with a group body |
| 9. `\addtotoc` with `dummy` counter | Thesis.cls:348-351 | yes | the counter only makes a hyperref anchor (`\refstepcounter` prints nothing); `\phantomsection\addcontentsline{toc}{chapter}{text}` does the same with published commands |
| 10. `\tableofcontents`, `\listoffigures`, `\listoftables` | Thesis.cls:352-404 | yes | book's own definitions (`\@starttoc`, `\@mkboth`, `\if@restonecol`) wrapped in `spacing{1}` + local `\parskip` 1pt + trailing `\cleardoublepage`; `toc.kernel` with `sp.setspace`, `sp.lengths`, `pg.break` |
| 11. `\listofsymbols`, `\listofconstants`, `\listofnomenclature` | Thesis.cls:405-437 | yes | `\chapter*` + toc entry + `longtable`; `tbl.longtable` |
| 12. `\acknowledgements`, `\Declaration`, `\dedicatory`, `\authorpublications` | Thesis.cls:48-59,438-447,522-544 | yes | hand-laid pages from kernel commands (map). `\authorpublications` does `\newcommand\secname` inside its body (:523), which would fail on a second call; with one use it is `\def`; not called by the sample |
| 13. `\backmatter` | Thesis.cls:545-553 | yes | `\cleardoublepage` (or `\clearpage`) + `\addcontentsline{toc}{chapter}{\bibname}` + book's `\@mainmatterfalse` |
| 14. Declaration stamp `\tikz[remember picture,overlay]\node[opacity=0.9,inner sep=0pt] at (2.13,0.5){\includegraphics...}` x3 | Thesis.cls:461-462,483-484,508-509 | yes (judgement) | node content is one `\includegraphics` of a shipped PNG: no path, fill or drawing. Anchor is the picture origin where `\tikz` runs, immediately before the signature `\makebox[4cm]`, centred 2.13cm right and 0.5cm up. Same effect with kernel boxes: `\makebox[0pt][l]{\hspace{0.13cm}\raisebox{-0.2635cm}{\transparent{0.9}\includegraphics[width=4cm,height=1.527cm]{...}}}` (0.13 = 2.13-4/2, -0.2635 = 0.5-1.527/2). `fig.graphicx` + `sp.manual-space` + `color.transparent`. If a stricter reading calls a text-flow-anchored overlay artwork, this becomes `ART/class` |
| 15. Cross-reference aliases (14 `\newcommand`) | Thesis.cls:126-139 | yes | each is a fixed word + `~\ref{#1}`; `xref.kernel` |
| 16. `Styles/lstpatch.sty` | Thesis.cls:157; lstpatch.sty:64-76 | yes (judgement) | Carsten Heinz's 2004 patch for listings 1.3 (not on CTAN, 404). It opens with `\lst@CheckVersion{1.3}{...Patch file not loaded...\endinput}` (:64-73), so on any listings other than 1.3 it ends at once. Even when active it only fixes 1.3 bugs and adds `rangeprefix`-type and `multicols` keys that nothing in this zip uses (no listing in the sample, `\lstset` keys are stock). Emitter writes `\usepackage{listings}` and `\lstset` and drops the file. If a stricter reading counts patching a published package's internals as irreducible, this becomes `BESPOKE/package` |
| 17. `epstopdf` loaded unconditionally | Thesis.cls:152 | yes (judgement) | the package calls a converter (ghostscript via restricted `\write18`) only when an `.eps` is included; the zip has none, so the document does not depend on the tool and the pilot's `minted` ruling does not apply. If a stricter reading counts any shell-calling package, this becomes `EXTERNAL/package` |
| 18. `Styles/mydefs.sty` | main.tex:12; mydefs.sty:4-34 | yes | only `\def`/`\newcommand` aliases of maths and length constants, no counters or conditionals; `\Ones` needs `dsfont` (`math.bm`) which is not loaded, `\diag` needs an undefined `\diagfences`; neither is called |
| 19. `\setlength{\captionmargin}{20pt}` | Thesis.cls:125 | yes | `cap.caption` parameter `margin=20pt`; whether the current `caption` still accepts the legacy length was not checked |

## Content-opaque
none beyond the following content items: bibliography entries (references.bib:1-17), the signature image (Styles/signature.png, an example signature), the NTU logo (Styles/ntu_logo.png, shipped; NTU trademark), chapter and abstract text. Missing asset: `Figures/` (main.tex:3) is not shipped; the sample uses no figure.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
