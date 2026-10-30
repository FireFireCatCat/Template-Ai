no

# 0587-c-i-p-h-e-r-phinished: PhinisheD (unofficial IIT Kharagpur PhD thesis template)

- Unverified: read from the source, not compiled.
- Source: Source/0587-c-i-p-h-e-r-phinished/ (origin: https://codeload.github.com/c-i-p-h-e-r/PhinisheD/zip/refs/heads/master; licence: MIT)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (the shipped log says pdfTeX, TeX Live 2015: thesisInParts/myThesis.log:1)
- Look carried by: mixed (published `memoir` with its `veelo` chapter style, plus a five-file preamble in 0_preamble/ that restyles part titles, running heads and the contents list)
- Class origin: ctan
- Main file: thesisInParts/myThesis.tex (other samples: thesisInChapters/myThesis.tex, same preamble minus the part machinery)
- Read: main yes, zip-local classes and styles partly (see Notes at the end)

## Verdict
No. The class is plain published `memoir` and most of the preamble reduces to lib ways, but the preamble also holds three constructs that no lib way expresses: the part-title page (a hand-built grey number tab from boxes, plus a stateful epigraph hook built on a boolean and a stored environment body) and a patch of a `todonotes` private macro. Each is copied macro logic that an emitter would have to reproduce verbatim. The other sample, thesisInChapters, drops the part code but keeps the identical `3-myCommands.tex` with the `todonotes` patch, so it is `no` too.

## Blockers
- `ART/preamble` part-number tab: `\partlabel` draws a grey filled box with a white number from `\fcolorbox`, `\raisebox` offsets (8.4ex, -9ex, 7ex/37ex), `\resizebox` to a `\settowidth` measure and an `\fbox{\phantom{..}}` overlay, selected through `\titleformat{\part}` (thesisInParts/0_preamble/1-latexHacks.tex:28-45). Its pieces are lib commands, but the arrangement is hand-tuned geometry that is the template's part-page identity; no declarative parameters describe it (could equally be filed as BESPOKE).
- `BESPOKE/preamble` stateful part epigraph: `\newbool{withepi}`, `\NewEnviron{PartEpigraph}{\global\let\mypartepigraph\BODY}`, `\thispartepigraph` and the `\ifbool{withepi}{...\global\setbool{withepi}{false}}{}` after-code of `\titleformat{\part}` (thesisInParts/0_preamble/1-latexHacks.tex:19-26 and :48). A hand-rolled conditional and a global stored body decide what prints after the part title; `quote.epigraph` alone cannot place the epigraph inside the title's after-hook.
- `BESPOKE/preamble` patch of a package-private macro: `\renewcommand{\@todonotes@drawMarginNoteWithLine}` is replaced by a `tikzpicture[remember picture, overlay]` coordinate plus `\marginnote[left]{right}` (thesisInParts/0_preamble/3-myCommands.tex:55-67; identical file in thesisInChapters). It rewrites `todonotes` internals; `todonotes` options cannot express it.

## Class setting
- Class: `class.memoir` options: `12pt,twoside,a4paper` (thesisInParts/myThesis.tex:13). The class actually loaded is TeX Live's memoir 2015/07/08 v3.7e (thesisInParts/myThesis.log:9-10). The zip also holds `thesisInParts/11_latex_files/memoir.cls`, a stale copy (`\ProvidesClass{memoir}[2002/08/10 v1.2 ...]`, docstrip output, CR-only line ends) that lies off the search path and lacks `\chs@veelo`, `\nouppercaseheads`, `\memRTLleftskip` and `Spacing`, so the sample cannot have used it.
- Class-native vocabulary used: `\checkandfixthelayout` (myThesis.tex:15); `\frontmatter` `\mainmatter` `\backmatter` (:27, :58, :80); `\chapterstyle{veelo}` (:23); `\makeheadrule` `\nouppercaseheads` `\makeevenhead` `\makeoddhead` (0_preamble/1-latexHacks.tex:4-9); `\setsecnumdepth` `\maxtocdepth` (:62-63); `\makechapterstyle` `\addtodef` and chapter hooks `\chapnumfont` `\printchapternum` `\beforechapskip` (:75-112); toc hook `\cftpartafterpnum` with `\memRTLleftskip` (:66-68; memoir emulates tocloft, thesisInParts/myThesis.log:331); `Spacing` environment (1_front_matter/titlepagefile.tex:4).

## Component map
Paths are relative to Source/0587-c-i-p-h-e-r-phinished/thesisInParts/ and written in full from there.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | myThesis.tex:13 | `class.memoir` | 12pt, twoside, a4paper |
| paper and size | myThesis.tex:13 | `page.class-options` | a4paper, 12pt, twoside |
| layout fix | myThesis.tex:15 | `page.memoir-layout` | `\checkandfixthelayout` |
| margins | myThesis.tex:17-18; 0_preamble/3-myCommands.tex:70 | `page.setlength` | `\oddsidemargin`=1.8cm, `\evensidemargin`=0.5cm, `\marginparwidth`=2.5cm |
| file inclusion | myThesis.tex:21,31-45,60,62,64,68,72,78,82-84 | `struct.input` | `\input`, `\include{3_introduction/intro}` |
| matter and page numbers | myThesis.tex:27,29,58,59,80 | `pgnum.pagenumbering` | roman in front matter, arabic from `\mainmatter` |
| page breaks | myThesis.tex:47,50,54,55; 1_front_matter/dedication.tex:1,15; 5_contributory_part/contri-part.tex:9 | `pg.break` | `\cleardoublepage` `\clearpage` `\newpage` |
| running heads and feet | 0_preamble/1-latexHacks.tex:4-9 | `hf.memoir-pagestyle` | redefines style `headings`: head rule `\textwidth` x `\normalrulethickness`; even head `\thepage` left, `\leftmark` right; odd head `\rightmark` left, `\thepage` right; `\nouppercaseheads` |
| page-style switches and marks | 1_front_matter/titlepagefile.tex:1; 5_contributory_part/intro.tex:2 | `hf.pagestyle-kernel` | `\thispagestyle{empty}`, `\markboth{Introduction}{Introduction}` |
| chapter heading look | myThesis.tex:23; 0_preamble/1-latexHacks.tex:101-112 | `head.memoir-style` | `\chapterstyle{veelo}`, then `\chapnumfont`=`\normalfont\HUGE\bfseries`, `\printchapternum`=`\makebox[0pt][l]{\enspace\resizebox{!}{\numberheight}{\chapnumfont\thechapter}}`, `\numberheight`=`\beforechapskip` (:72-73) |
| part heading | 0_preamble/1-latexHacks.tex:42-50 | `head.titlesec` (label and after-code are blockers) | `\titleformat{\part}[display]`, label sep 10ex, format `\thispagestyle{empty}\filleft\fontsize{26}{34}\selectfont\sffamily`; `\titlespacing{\part}{0pt}{1.25\baselineskip}{10\baselineskip}` |
| section commands | 3_introduction/intro.tex:1,4,10,13; 4_lit_survey/litSurvey.tex:1; 5_contributory_part/contri-part.tex:3 | `head.kernel` | `\chapter` `\chapter*` `\section` `\subsection` `\paragraph` `\part[short]{long \\ long}` |
| numbering depth | 0_preamble/1-latexHacks.tex:62-63 | `num.secnumdepth` | secnumdepth=subsection, maxtocdepth=subsection |
| counter display | 0_preamble/3-myCommands.tex:15,19 | `num.counters` | `\thesubfigure`=`(\alph{subfigure})`, `\thesubtable`=`(\alph{subtable})` |
| part epigraph text | 0_preamble/1-latexHacks.tex:18; 5_contributory_part/quote.tex:1; thesisInChapters/5_contributory_part/first_chapter.tex:4 | `quote.epigraph` | `\epigraphwidth`=0.6\linewidth; `\epigraph{text}{source}` |
| title page | 1_front_matter/titlepagefile.tex:1-41 | `front.titlepage-env` | hand-laid `center`; `\vspace{-15mm}`; filler lines `\hspace{0pt plus 1filll}\\`; `\fSize{12,13,14}`; logo `\includegraphics[trim=0 0 0 0, clip, scale=0.4]` in `figure[h]` (:29-32) |
| front-matter pages | 1_front_matter/dedication.tex:1-15; approval.tex:1-28; certif_guide.tex:1-19; acknows.tex:1-15; declaration.tex:1-20 | `front.dedication` | `\chapter[short]{TITLE \\ TITLE}`, `\sffamily`, signature rules `\underline{\hspace{5.8cm}}`, `\vspace{2cm}` |
| abstract page | 1_front_matter/abstract.tex:1-8 | `front.dedication` (hand-laid; no `abstract` env used), `toc.kernel`, `meta.hyperref` | `\phantomsection`, `\addcontentsline{toc}{chapter}{Abstract}`, `\textbf{\hspace{0pt plus 1filll}\huge Abstract}`, `\vspace{15mm}` |
| line spacing | 1_front_matter/titlepagefile.tex:4,11,33; approval.tex:7; certif_guide.tex:3 | `sp.setspace` | memoir `Spacing{1.5}` and `Spacing{1.4}` (memoir emulates setspace) |
| manual spacing and fill | 1_front_matter/titlepagefile.tex:2,7-10; dedication.tex:3,10; 9_back_matter/pubs.tex:4 | `sp.manual-space` | `\vspace`, `\vspace*{7.9cm}`, `\hspace{0pt plus 1filll}` |
| underline and overline | 1_front_matter/approval.tex:3,18-20; declaration.tex:17 | `mark.ulem` (kernel `\underline`), `math.kernel` (`\overline`) | `\underline{\hspace{2.9cm}}`, `$\overline{\mbox{(Supervisor)}}$` |
| font switches | 1_front_matter/titlepagefile.tex:5,12; approval.tex:8 | `mark.kernel`, `font.size-commands` | `\textbf` `\emph` `\sffamily`; `\Large` `\LARGE` `\huge`; relsize loaded (0_preamble/0-packages.tex:7, no call) |
| dedication face | 1_front_matter/dedication.tex:8,11; 0_preamble/0-packages.tex:31; 0_preamble/1-latexHacks.tex:13-15 | `font.display`, `font.nfss` | `\calligra`; `\DeclareFontFamily{OT1}{pzc}{}`, `\DeclareFontShape{OT1}{pzc}{m}{it}{<-> s * [1.10] pzcmi7t}{}`, `\DeclareMathAlphabet{\mathpzc}{OT1}{pzc}{m}{it}` |
| encoding and sizes | 0_preamble/0-packages.tex:12,18 | `font.fontenc-t1`, `font.exscale` | `inputenc[utf8]`; `anyfontsize` (same type as `fix-cm`: load-only switch for any `\fontsize`) |
| colours | 0_preamble/0-packages.tex:17; 1-latexHacks.tex:29; 3-myCommands.tex:47-49 | `color.xcolor` | `x11names`; `titlecolour`=black!40, `lightorange`=orange!50, `mygray`=gray!58! |
| link and PDF setup | 0_preamble/0-packages.tex:20,24,30; 1-latexHacks.tex:54-59; myThesis.tex:53,56,76 | `meta.hyperref`, `meta.url`, `meta.bookmark` | `backref=page`; `colorlinks, linkcolor=red!50!black, citecolor=blue!50!black, urlcolor=blue!80!black`; `\backrefsetup{disable/enable}`; `\bookmarksetup{startatroot}` |
| cross-reference names | 0_preamble/3-myCommands.tex:16,21-23; 2-shortcuts.tex:28 | `xref.hyperref`, `xref.kernel` | `\subfigureautorefname` `\algorithmautorefname` `\chapterautorefname` `\sectionautorefname`; `\label{fig:dummy}` |
| language and quotes | 0_preamble/0-packages.tex:37,29 | `lang.babel`, `lang.csquotes` | `babel[english]`; `csquotes` loaded, no call |
| contents lists | myThesis.tex:48-51,54,55 | `toc.kernel` | `{\sffamily\tableofcontents}`, `\listoffigures`, `\listoftables` |
| toc part entries | 0_preamble/1-latexHacks.tex:66-68; myThesis.tex:66,70,74 | `toc.tocloft`, `sp.rule`, `sp.manual-space` | `\cftpartafterpnum` = two `\hrulefill` rules with `\vspace{-2\baselineskip}` and `\vspace{0.31\baselineskip}`; `\addtocontents{toc}{\noindent\protect\hrulefill\protect\leavevmode\par}` |
| lists | 3_introduction/intro.tex:39-57; 9_back_matter/pubs.tex:2-26; 1_front_matter/declaration.tex:7 | `list.kernel`, `list.enumitem` | `itemize`, `\item[]` group headings; `enumerate[label=\alph*.,leftmargin=3\parindent]`; `paralist` loaded (0-packages.tex:6, no call: `list.paralist`) |
| boxes | 0_preamble/0-packages.tex:22; 2-shortcuts.tex:8; 4_lit_survey/litSurvey.tex:7-9 | `box.tcolorbox` | `skins`; `\tcbset{beamer, drop shadow southwest, sharp corners, coltitle=black, colbacktitle=gray!20, halign title=flush left, titlerule=1mm}`; `tcolorbox[title=\textbf{..}]` |
| floats and captions | 0_preamble/2-shortcuts.tex:22-40; 0-packages.tex:1,21,38 | `fig.graphicx`, `fig.adjustbox`, `fig.subcaption`, `cap.kernel` | `figure[!t]`/`table[!t]` + `\centering`; `adjustbox{margin=1em,width=\textwidth,set height=4cm,set depth=4cm,frame,center}`; `subfig[labelformat=simple]` |
| tables | 1_front_matter/list_abbrs.tex:5-10; 0_preamble/3-myCommands.tex:44 | `tbl.tabular` | `tabular{r|l}`, `\arraystretch`=1.2; `\newcolumntype{C}{>{\centering\arraybackslash}m{0.2cm}}`; `multirow` and `colortbl` loaded (0-packages.tex:8,25): `tbl.multirow`, `tbl.colortbl` |
| theorem-like | 0_preamble/3-myCommands.tex:2-12; 0-packages.tex:2-4 | `thm.amsthm`, `thm.thmtools` | `\newtheorem{theorem}{Theorem}`, `lemma`/`mydef`/`thm` counted within `chapter`; `\qedsymbol`=`$\blacksquare$`; `thm-restate` loaded, no `restatable` used |
| maths | 0_preamble/0-packages.tex:2,5,10,11 | `math.amsmath`, `math.amssymb`, `math.mathtools`, `math.bm` | amsmath, amssymb, mathtools, `mathrsfs`, `stmaryrd` (a math-symbol package, filed under `math.amssymb`) |
| notes and review aids | 0_preamble/0-packages.tex:26,27; 3-myCommands.tex:55-68 | `draft.todo`, `note.marginnote` | `todonotes[color=cyan!50,textsize=scriptsize,colorinlistoftodos]`; `marginnote`; no `\todo` call in any sample file |
| highlight | 0_preamble/0-packages.tex:28; 3-myCommands.tex:48 | `mark.ulem` | `soul`, `\sethlcolor{lightorange}` |
| filler text | 0_preamble/0-packages.tex:35,36; 3_introduction/intro.tex:2,14; 4_lit_survey/first_topic.tex:4 | `draft.todo` | `\lipsum[..]`; `blindtext[pangram]`: `\Blindtext` `\blinddocument` `\blindmathpaper` `\blinditemize`; filler content |
| index and nomenclature | 0_preamble/preamble.tex:5; 0-packages.tex:9 | `idx.makeidx`, `idx.glossaries` | `\makeindex` only; `nomencl` loaded; no `\printindex`, `\nomenclature` or `\printnomenclature` anywhere in the sample |
| bibliography | myThesis.tex:89-90; 10_bibliography/myThesis.bib:1 | `bib.bibtex-bst` | `\bibliographystyle{alpha}`, `\bibliography{10_bibliography/myThesis}`; the .bib is a one-line placeholder |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\fSize`, `\baselineSkipFactor` | 0_preamble/2-shortcuts.tex:3-4 | yes | alias: `\fontsize{N}{1.2N}\selectfont`; the second argument is text concatenation, so `\fSize{12}` is `\fontsize{12}{1.212}\selectfont` (`font.size-commands`) |
| `\dummyfig`, `\dummytab` | 0_preamble/2-shortcuts.tex:22-40 | yes | inline expansion: `fig.graphicx` float + `fig.adjustbox` keys + `cap.kernel` + `xref.kernel`; both set `\label{fig:dummy}` (duplicate) |
| `myitemize` + `\tcolorboxenvironment` | 0_preamble/2-shortcuts.tex:11-16 | yes | `list.kernel` itemize wrapped by `box.tcolorbox` keys `blanker, before skip=6pt, after skip=6pt, borderline west={2mm}{0pt}{black}`; never called |
| `\repeatcaption` | 0_preamble/3-myCommands.tex:27-31 | yes | `\renewcommand{\thefigure}{\ref{..}}` (`num.counters`, `xref.kernel`) + `\captionsetup{list=no}` (`cap.caption`, loaded through subfig, thesisInParts/myThesis.log:1058) + `\caption`; never called |
| `\Scale` | 0_preamble/3-myCommands.tex:34 | yes | `\scalebox{4}{$..$}` (`fig.graphicx`); never called |
| `\myxleftarrow`, `\longleftrightarrowfill@` | 0_preamble/3-myCommands.tex:38-41 | yes, with a caveat | alias of amsmath `\xleftarrow[under]{over}` (`math.amsmath`); it uses `\ext@arrow 0099` and `\arrowfill@` internals, so the padding digits may differ from `\xleftarrow`; never called |
| column type `C` | 0_preamble/3-myCommands.tex:44 | yes | `\newcolumntype` (`tbl.tabular`) |
| `\ttbold` | 0_preamble/1-latexHacks.tex:116 | yes | `\fontfamily{lmtt}\selectfont` (`font.nfss`); never called |
| `\cftpartafterpnum` redefinition | 0_preamble/1-latexHacks.tex:66-68 | yes | a memoir/tocloft hook whose body is two `\hrulefill` rules and two `\vspace` values (`toc.tocloft`, `sp.rule`, `sp.manual-space`); `\memRTLleftskip` is a memoir length |
| `\addtodef\chs@veelo` and `\numberheight` | 0_preamble/1-latexHacks.tex:72-73,100-113 | yes, not checked against memoir 3.7e source | `\chapterstyle{veelo}` followed by `\renewcommand*` of the public hooks `\chapnumfont` and `\printchapternum` (`head.memoir-style`, `fig.graphicx` `\resizebox`, `sp.manual-space`); `\numberheight` is memoir's default `\beforechapskip` read at preamble time (value not read) |
| `\makechapterstyle{myveelo}` | 0_preamble/1-latexHacks.tex:75-95 | not applicable | dead code: only `veelo` is selected (myThesis.tex:23) |
| part tab `\partlabel`, `\labelframewd`, `\partlabelbox` | 0_preamble/1-latexHacks.tex:28-45 | no | blocker `ART/preamble` above |
| `PartEpigraph`, `withepi`, `\thispartepigraph` | 0_preamble/1-latexHacks.tex:19-26,48 | no | blocker `BESPOKE/preamble` above |
| `todonotes` margin-note patch | 0_preamble/3-myCommands.tex:55-67 | no | blocker `BESPOKE/preamble` above |
| `mweights.sty` | mweights.sty:1-87 | not loaded | Bob Tennent's weights package (redefines `\bfseries` `\mdseries` `\rmfamily`); no `\usepackage{mweights}` anywhere (Grep), out of scope |
| `bengali.sty` (BWTI) | bengali.sty:24-480 | not loaded | plain-TeX `bnr10` font setup, enabling line commented out (0_preamble/0-packages.tex:44); enabling it would add irreducible font code, but it is not part of this sample |

## Content-opaque
none (the logo image 1_front_matter/fig/kgpLogo.pdf, included at 1_front_matter/titlepagefile.tex:31, is a shipped asset; `front_cover.docx` is a binary Word cover, not analysed)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Not read in full: `thesisInParts/11_latex_files/memoir.cls` (5306 lines, stale published-class copy not loaded; only its header, version and a feature-count scan were read), `bengali.sty` (lines 1-120 of 480; not loaded). Read in full: every other .tex and .sty under thesisInParts/ (main, preamble, front matter, chapters, back matter, `mweights.sty`) and the differing files of thesisInChapters (`myThesis.tex`, `0_preamble/0-packages.tex`, `0_preamble/1-latexHacks.tex`, `first_chapter.tex`); `2-shortcuts.tex`, `3-myCommands.tex` and `preamble.tex` are byte-identical in both variants.
- README text (README.md:12) advertises Bengali support through `bwti`; it was read as data, with no instruction to act on.
- The shipped log (thesisInParts/myThesis.log) is a 2017 compile under TeX Live 2015. It was used only to learn which memoir was loaded (:9-10) and that memoir emulates `tocloft` (:331) and that the `caption` package was loaded after `subfig` (:1055-1058); it is not evidence of how the template looks today.
