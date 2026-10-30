no

# 0068-kaobook: Kaobook (wide-margin book/notes class)

- Unverified: read from the source, not compiled.
- Source: Source/0068-kaobook/ (origin: https://latextemplates.com/downloads/kaobook.zip; licence: LPPL-1.3c)
- Kind: book
- Lib: v1
- Engine: pdfLaTeX-compatible (default `fontmethod=tex` on pdfTeX, kao.sty:60-64, 1172-1175; README.md:23-26 builds with `pdflatex`)
- Look carried by: zip-local (the look is defined in the zip-local `kaobook.cls` + `kao.sty`, with `kaorefs.sty` and `kaotheorems.sty` loaded by the sample; `main.tex` only passes class options, loads those two styles and sets the index)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (kaobook.cls, kao.sty, kaorefs.sty, kaotheorems.sty, and kaobiblio.sty, which the sample does not load)

## Verdict
No. The look is not in the sample: it is in a zip-local class (`kaobook.cls`, not on CTAN) built on `scrbook`, and that class contains typesetting code beyond the lib. The chapter heading `kao` style is hand-placed boxes and a rule with odd/even branching, the margin table of contents redefines `\section`/`\subsection` and measures widths with `\setbox`, the margin notes and margin floats rebuild the `sidenotes` package internals, and the running heads are overlapping zero-width boxes. A TikZ overlay band (`bar` chapter style) is also template artwork. The theorem, cross-reference, box, listing, caption and float settings do reduce to lib ways; the blockers are the margin and heading machinery.

## Blockers
- `BESPOKE/class` chapter style `kao`: `\chapterlinesformat` built from `\smash`, `\makebox`, `\parbox`, `\scalebox{2.85}`, a `\rule` of computed height, branching on `\if@twoside`, `\Ifthispageodd`, `\IfWideLayout` (kaobook.cls:172-232; selected by main.tex:65)
- `BESPOKE/class` chapter style `lines`: hand-set boxes sized by `\marginparsep`/`\marginparwidth` with leaders rules (kaobook.cls:145-169; defined, not selected by the sample)
- `ART/class` chapter style `bar` and `\setchapterimage`: TikZ `remember picture, overlay` node, grey band with opacity; full-width image in a chapter preamble (kaobook.cls:116-139, 235-244; defined, not selected by the sample)
- `BESPOKE/class` margin notes and sidenotes: `\marginnote` and `\sidenote` rebuilt, `\@sidenotes@thesidenotemark` (an internal of the published `sidenotes` package) redefined, a hand flag `\ifinfloat` set by `\AtBeginEnvironment{tcolorbox}` and `{minipage}` decides what `\marginnote` prints (kao.sty:441-523)
- `BESPOKE/class` margin floats: `marginfigure`, `margintable`, `marginlisting` rebuilt from `lrbox` + `minipage` + `\marginnote` + `\marginskip` + `\FloatBarrier` (kao.sty:594-645)
- `BESPOKE/class` caption-presence toggle: `\caption` is rebound inside `figure` and `table` and a `kaocaption` toggle changes `\RawFloats\centering` at environment end (kao.sty:651-697)
- `BESPOKE/class` margin table of contents: `\section` and `\subsection` redefined with a fourth optional argument, hand `mtocsection` entries through `\etoctoccontentsline`, `etoc` styles with a `\setbox` dry run to measure widths, `\leaders`, `\rlap` (kao.sty:987-1135). Active for every `\section` in the sample (main.tex:72, 78, 83) even though `\margintoc` is never called.
- `BESPOKE/class` running heads: `\renewpagestyle{scrheadings}` with overlapping `\smash`/`\makebox`/`\rule` boxes placed into the margin, separate odd/even specs (kao.sty:266-283)
- `BESPOKE/class` hyperref and footnote internals: `\@footnotemark` rewritten with `\Hy@saved@currentHref`, `\hyper@makecurrent`, `\hyper@linkstart`; `\define@key{Hyp}{footnotecolor}`; `\@makefntext` rewritten; `\patchcmd{\footref}` (kao.sty:429-434, 1216-1253)
- `BESPOKE/class` `kaobiblio.sty` (in the zip, NOT loaded by the sample): `\DeclareCiteCommand`, `\xpatchbibmacro`, `\DeclareSourcemap`, `\sidecite` family (kaobiblio.sty:62-71, 74-91, 149-309, 318-402)

## Class setting
- Class: `class.scrbook` (kaobook.cls:29, 42 `\LoadClass{scrbook}`; the zip-local `kaobook` wrapper is not a published class, so it is not a way). Options set by the wrapper: `a4paper`, `fontsize=10pt`, `parskip=half`, `headings=optiontoheadandtoc` (kaobook.cls:32-35), `toc=listof`, `toc=index`, `toc=bibliography` (kaobook.cls:271-273). Options from the sample: `fontsize=10pt`, `twoside=false`, `secnumdepth=1` (main.tex:7-11), forwarded by `\DeclareOption*` (kaobook.cls:38).
- Class-native vocabulary used: KOMA `\titlehead`, `\publishers`, `\uppertitleback`, `\lowertitleback`, `\maketitle`, `\@titlehead` (main.tex:27-51); `\frontmatter`, `\mainmatter`, `\backmatter`, `\appendix`, `\chapter*`, `\addpart` (main.tex:33, 53, 64, 124, 127, 132); `\KOMAScript` (main.tex:45). Zip-local vocabulary: `\setchapterstyle{kao|plain}` (main.tex:65, 133), `\pagelayout{wide|margin}` (main.tex:123, 125), `\sidenote`, `marginfigure`, `margintable` (main.tex:74, 87, 92, 102).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | kaobook.cls:29-42; main.tex:7-11 | `class.scrbook` | a4paper, fontsize=10pt, parskip=half, headings=optiontoheadandtoc, twoside=false, secnumdepth=1 |
| paper | kaobook.cls:32; kao.sty:113-125, 170-173 | `page.class-options` | a4paper; `\hscale`=`\vscale`=1mm for a4paper (constant table keyed by paper option, kao.sty:121-167) |
| page geometry, margin layout | kao.sty:192-203 | `page.geometry` | `\newgeometry`: top=27.4mm, bottom=27.4mm, inner=24.8mm, textwidth=107mm, marginparsep=6.2mm, marginparwidth=47.7mm; paperwidth=210mm, paperheight=297mm (kao.sty:170-173) |
| page geometry, wide layout | kao.sty:206-217; main.tex:123 | `page.geometry` | `\newgeometry`: top/bottom=27.4mm, inner=outer=24.8mm, marginparsep=0mm, marginparwidth=0mm; front and back matter use it (kaobook.cls:55, 88) |
| header and footer | kao.sty:240-326; kaobook.cls:54, 66, 87 | `hf.scrlayer-scrpage` | styles `scrheadings`, `plain.scrheadings`, `pagenum.scrheadings`, `centeredpagenum.scrheadings`; `\headsep`=11mm (kao.sty:245); content is hand boxes (BESPOKE) |
| page style switches | kaobook.cls:54, 66, 87; kao.sty:319-326 | `hf.pagestyle-kernel` | `\pagestyle`, `\thispagestyle{empty}` in `\blankpage` |
| page break | kao.sty:322 | `pg.break` | `\newpage` in `\blankpage` |
| paragraph shape, body | kao.sty:342-348, 363 | `sp.ragged` | `\justifying` (ragged2e) |
| line spacing | kao.sty:345, 1187 | `sp.setspace` | `\singlespacing` |
| line spread | kao.sty:1187 | `sp.linespread` | `\linespread{1.07}` |
| space after periods | kao.sty:346, 357 | `sp.frenchspacing` | `\frenchspacing` in body and margin paragraph settings |
| margin paragraph lengths | kao.sty:351-360 | `sp.lengths` | `\RaggedRightParindent`=0em, `\parindent`=0em, `\parskip`=0.5pc |
| margin paragraph size | kao.sty:359 | `font.size-commands` | `\footnotesize` |
| display skips, column rule | kao.sty:584-591 | `sp.lengths` | `\abovedisplayskip`=10pt plus 2pt minus 5pt, `\abovedisplayshortskip`=0pt plus 3pt, `\belowdisplayshortskip`=6pt plus 3pt minus 3pt, `\columnseprule`=.4pt |
| microtypography, hyphenation | kao.sty:334-335 | `sp.microtype`, `sp.hyphenat` | defaults (load only) |
| needspace | kao.sty:336 | `pg.needspace` | load only |
| fonts, text (tex method) | kao.sty:1160-1170 | `font.palatino` | `newpxtext` scaled=.97, helvratio=.93, p, theoremfont; `newpxmath` vvarbb, smallerops, bigdelims |
| fonts, mono | kao.sty:1167 | `font.mono` | `beramono` scaled=.85 |
| math alphabets | kao.sty:1168 | `math.bm` | `mathalfa` scr=rsfso, cal=boondoxo |
| encoding | kao.sty:1161-1162 | `font.fontenc-t1` | inputenc utf8, fontenc T1 |
| math symbols | kao.sty:1164 | `math.amssymb` | load only (needed for `\blacktriangleright`) |
| fonts (modern method, XeLaTeX/LuaLaTeX only) | kao.sty:1141-1159 | `font.fontspec`, `font.unicode-math` | `\setromanfont` Libertinus Serif Scale=1.04; `\setsansfont` Libertinus Sans; `\setmonofont` Liberation Mono Scale=.89; `\setmathfont` Libertinus Math |
| colour model | kao.sty:19 | `color.xcolor` | options usenames, dvipsnames, table |
| link and listing colours | kao.sty:883-887, 1270-1283 | `color.xcolor` | citecolor/filecolor/urlcolor=OliveGreen, linkcolor=Black; listingkeywords rgb 0,.5,0, listingcomments .25,.5,.5, listingstrings .73,.13,.13, listingnumbers .25 grey |
| language | main.tex:13 | `lang.babel` | english |
| quotes | main.tex:14 | `lang.csquotes` | english=british |
| language strings | kaorefs.sty:28-147 | `lang.babel` | `\addto\captionsenglish/german/danish/italian/russian` `\renewcommand` of ref names (declarative strings) |
| PDF links, metadata | kao.sty:1196-1214 | `meta.hyperref` | unicode, pdfborder={0 0 0}, bookmarksdepth=section, bookmarksopen=true, linktoc=all, breaklinks=true, colorlinks=true |
| PDF bookmarks | kao.sty:102, 1197; kaobook.cls:77, 86 | `meta.bookmark` | `\pdfbookmark[1]` before `\maketitle`; `\bookmarksetup{startatroot}` after `\appendix` and `\backmatter` |
| URLs | kao.sty:1199 | `meta.url` | `\PassOptionsToPackage{hyphens}{url}` |
| title block | main.tex:27-31, 35-51; kao.sty:77-99 | `front.koma-title` | `\titlehead{Lecture Notes}`, `\publishers{Department of Whatever}`, `\uppertitleback{\@titlehead}`, `\lowertitleback{...}` |
| title, author, date | main.tex:28-30; kao.sty:77-99 | `front.maketitle` | `\title[plain]{full}`, `\author[plain]{full}`, `\date{\today}`; the optional plain text goes to `\hypersetup{pdftitle/pdfauthor}` |
| class title vocabulary | main.tex:51 | `front.class-native` | scrbook titlepage `\maketitle` |
| preface | main.tex:53-56 | `head.class-native` | `\chapter*{Preface}` (no abstract environment is used) |
| table of contents | main.tex:58-62 | `toc.kernel` | `\tableofcontents` |
| toc local-style reset | main.tex:59-60 | `toc.etoc` | `\etocstandarddisplaystyle`, `\etocstandardlines` inside a group; `etoc` loaded kao.sty:985 |
| toc entry styles | kao.sty:944-973 | `toc.tocbasic` | `\setuptoc{toc}{totoc}`; `\DeclareTOCStyleEntries[level=1,indent=0em,numwidth=2em,dynnumwidth=yes,pagenumberwidth=2.1em]{tocline}{figure,table,lstlisting,listing}`; chapter/part pagenumberwidth=2.5em; section levels 2.1em |
| toc class options | kaobook.cls:271-273 | `toc.koma` | toc=listof, toc=index, toc=bibliography |
| toc depth | kao.sty:950 | `num.secnumdepth` | `\setcounter{tocdepth}{\subsectiontocdepth}`; secnumdepth=1 from main.tex:10 |
| chapter heading, plain | kaobook.cls:105-113 | `head.class-native` | `\RedeclareSectionCommand[beforeskip=0cm,afterskip=10mm]{chapter}` (reducible) |
| chapter heading, kao | kaobook.cls:172-232 | none (BESPOKE) | see Blockers |
| heading fonts | kaobook.cls:254-264 | `head.koma-fonts` | `\addtokomafont{part|partentry}{\normalfont\scshape\bfseries}`; chapter, chapterentry, section, subsection, subsubsection, paragraph: `\normalfont\bfseries`; `\setkomafont{descriptionlabel}{\normalfont\bfseries}` |
| numbering | kaobook.cls:281; kao.sty:9 | `num.counters` | `\counterwithin*{sidenote}{chapter}`; `chngcntr` loaded kao.sty:418 |
| appendix | main.tex:127; kaobook.cls:74-78 | `num.appendix` | `\appendix` |
| margin notes | main.tex:74, 87; kao.sty:415-417, 442-445 | `note.sidenotes` | `sidenotes` package, `\sidenote` (class rebinds it, BESPOKE) |
| margin notes, positioning | kao.sty:415, 442-445, 477-488 | `note.marginnote` | `\marginfont`=`\@margin@par`, `\marginnotevadjust`=0.8mm, raggedleft/raggedright margin hooks emptied |
| footnotes | kao.sty:421-428 | `fn.footmisc` | bottom, symbol*, hang, flushmargin, stable (sample has no `\footnote`) |
| footnote back-links | kao.sty:429 | `fn.footnotebackref` | `footnotebackref`, load only (not exercised by the sample) |
| review notes | kao.sty:1380 | `note.todonotes` | load only |
| margin figure | main.tex:92-97; kao.sty:605-616 | `note.sidenotes` | `marginfigure` env (class overrides it, BESPOKE); placeholder content `\fbox{\parbox{0.9\linewidth}{...}}` |
| margin table | main.tex:102-114; kao.sty:619-630 | `note.sidenotes` | `margintable` env (class overrides it, BESPOKE) |
| placeholder box in figure | main.tex:94 | `box.fancybox`, `box.minipage`, `sp.manual-space` | `\fbox`, `\parbox{0.9\linewidth}`, `\vspace{1.2cm}` (content) |
| tabular | main.tex:104-111 | `tbl.tabular` | `{lr}` |
| table rules | main.tex:106-110; kao.sty:557 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| table helpers | kao.sty:558, 19 | `tbl.multirow`, `tbl.colortbl` | `multirow`; xcolor option `table` (load only) |
| table helper macros | kao.sty:1424-1426 | `sp.manual-space` | `\na`=`\quad--`, `\hangp`, `\hangstar` with zero-width `\makebox` (reducible aliases) |
| figure inclusion | main.tex:21; kao.sty:551-552 | `fig.graphicx` | `\graphicspath{{images/}{./}}`; Gin keys width=\linewidth, totalheight=\textheight, keepaspectratio |
| float placement | kao.sty:412-413, 575-577 | `fig.placement` | `placeins` option section; `\extrafloats{100}`; `\topfraction` .9, `\textfraction` 0.35, `\floatpagefraction` 0.8 |
| float rotation | kao.sty:560 | `fig.rotating` | load only |
| float layout | kao.sty:556, 648, 731-737, 740-879 | `fig.floatrow` | `\DeclareFloatStyle{kaofloat}{capposition=beside,capbesideframe=yes,capbesidewidth=\marginparwidth,capbesidesep=marginparsep,floatwidth=\textwidth}`; `\floatsetup[figure|table|lstlisting|listing|widefigure|widetable|widelisting|longtable]` margins=hangoutside (twoside) or hangright, facing, capbesideposition; wide layout: capposition, margins=centering, floatwidth=\textwidth; `\FBaskip`=`\FBbskip`=.4\topskip (kao.sty:580-581) |
| caption setup | kao.sty:555, 700-729 | `cap.caption` | hypcap=true; `\captionsetup{format=margin, labelsep=colon, strut=no, singlelinecheck=false, indention=0pt, parindent=0pt, aboveskip=6pt, belowskip=6pt}`; `\DeclareCaptionFormat{margin}{\@margin@par #1#2#3}`; `llap` format for listings; `\DeclareCaptionLabelFormat{cont}` |
| caption label font | kao.sty:700 | `cap.koma` | `\addtokomafont{captionlabel}{\bfseries}` |
| caption command | main.tex:95, 112 | `cap.kernel` | `\caption{...}` after content, `\label` after `\caption` (kaorefs.sty:9) |
| code | kao.sty:529-562, 881-938 | `code.listings` | default `listing=listings`; `\lstdefinestyle{kaolst}` (basicstyle=\small\ttfamily, numbers=left, numbersep=1em, frame=l, framerule=.7pt, tabsize=4, breaklines=true, captionpos=t, defaultdialect=[LaTeX]Tex, aboveskip=0.7\topskip, belowskip=0.1\topskip) and `kaolstplain`; `\lstset{style=kaolst}`. `minted` only if `listing=minted` (kao.sty:539-566, `code.minted`), so it is not loaded by default |
| boxes | kao.sty:1301-1327 | `box.tcolorbox` | `tcolorbox[most]`; `\newtcolorbox{kaobox}[1][]{breakable, before/after skip=1.5\topskip, left/right=4pt, top/bottom=2pt, sharp corners, boxrule=0pt, titlerule=.4pt, colback=RoyalBlue!25!White, colbacktitle=RoyalBlue!25!White, coltitle=black, colframe=black, fonttitle=\bfseries}` |
| counted box | kao.sty:1334-1346 | `num.counters` | `kaocounter` counter within section, title `Comment~\thekaocounter` in `kaobox` |
| extra float with list | kao.sty:1354-1371 | `fig.newfloat` | intent: `\DeclareFloatingEnvironment` (placement tbph, name Insight, fileext loi, listname "List of Insights"); written with `\@float` internals and inconsistent names (`kaofloating` vs `floatingbox`) |
| list of floats | kao.sty:1368-1371 | `toc.tocbasic` | `\addtotoclist[float]{loi}`, `\listoftoc{loi}` |
| list bullets | kao.sty:1289-1290 | `list.kernel` | `\labelitemi`=`\small$\blacktriangleright$`, `\labelitemii`=`\textbullet` |
| list spacing | kao.sty:1291-1294 | `list.enumitem` | `enumitem[inline]`; `\setlist[itemize|enumerate|description]{noitemsep}` (sample has no lists) |
| theorem package set | kaotheorems.sty:32-34 | `thm.amsthm`, `math.amsmath`, `thm.thmtools` | load order amsmath, amsthm, thmtools; `\let\openbox\relax` workaround |
| theorem styles | kaotheorems.sty:60-131 (framed), 247-318 (default) | `thm.thmtools` | `\declaretheoremstyle` kaoplain, kaodefinition, kaoassumption, kaoremark, kaoexample, kaoexercise: bodyfont=\normalfont\itshape (plain, definition, assumption), headpunct={}, postheadspace={.5em plus .1em minus .1em}, spaceabove=.6\thm@preskip, spacebelow=.1\thm@postskip |
| theorem environments | kaotheorems.sty:133-240 (framed), 320-390 (default) | `thm.thmtools` | `\declaretheorem` theorem (numberwithin=section), proposition, lemma, corollary (sibling=theorem), definition, assumption, remark, example, exercise (numberwithin=section); refname/Refname |
| framed theorems | kaotheorems.sty:40-57, 143-240 | `thm.tcolorbox` | option `framed` (default false, line 13): `\tcolorboxenvironment{theorem}{colback=Goldenrod!45!white,tcbkao}`; style tcbkao: breakable, before/after skip=\topskip, top=5pt, bottom=3pt, left/right=2pt, sharp corners, boxrule=0pt, frame hidden |
| cross-references | main.tex:68, 79-80, 99, 116; kaorefs.sty:17-21 | `xref.cleveref` | `cleveref[capitalise,nameinlink,noabbrev]`; `\creflabelformat{equation}{#2\textup{#1}#3}` (kaorefs.sty:257); `\crefname{subsection}` (kaorefs.sty:260-261) |
| cross-reference helpers | kaorefs.sty:155-245 | `xref.varioref` | `\vref`/`\vpageref`; `\newcommand` aliases `\labch`, `\refch`, `\vrefsec`, ... (reducible) |
| labels | main.tex:68, 96, 113 | `xref.kernel` | `\label`, `\ref` |
| hyperlinks | main.tex:45-47; kaorefs.sty:20 | `xref.hyperref` | `\href`, `\hyperref`, `\nameref` |
| index | main.tex:23, 135; kao.sty:27, 1394 | `idx.makeidx` | `\makeindex[columns=2, title=Index, intoc]`, `\printindex` (imakeidx); README.md:23-27 runs `makeindex` by hand |
| glossary, nomenclature | kao.sty:1395-1396 | `idx.glossaries` | `glossaries[xindy,toc,numberedsection=nameref]`, `nomencl[intoc]`; load only, no `\makeglossaries` in the sample |
| algorithms | kao.sty:1388 | `alg.algorithm2e` | linesnumbered, ruled, vlined; load only |
| bibliography | kaobiblio.sty:36, 59 | `bib.biblatex-biber` | backend=biber, citestyle=numeric-comp, bibstyle=numeric, sorting=none, backref=true; file not loaded by the sample (README.md:15-19) |
| wide blocks | kao.sty:370-406 | `list.scrextend` | `addmargin[0cm]{-\marginparwidth-\marginparsep}`; branch by `\Ifthispageodd` for twoside (not in sample) |
| other load-only packages | kao.sty:26, 1378, 1391, 553-554, 559 | `pg.afterpage`, `pg.include-pdf`, `font.icons`, `art.tikz`, `bg.tikzpagenodes`, `cols.multicol` | `afterpage`; `pdfpages`; `ccicons`; `tikz` (used by the `bar` chapter style), `tikzpagenodes`; `multicol` |
| date format | kao.sty:1429-1431 | `front.datetime` | `\monthyear` via `\ifcase\month` (reducible to `\newdateformat`; not used by the sample) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\setchapterstyle` dispatcher | kaobook.cls:97-102 | yes | `\ifthenelse` on a string; the emitter writes the chosen style directly |
| `\chapterstyleplain` | kaobook.cls:105-113 | yes | KOMA defaults restored: `\RedeclareSectionCommand[beforeskip=0cm,afterskip=10mm]{chapter}` |
| `\chapterstylekao` | kaobook.cls:172-232 | no | boxes, rule, `\scalebox`, odd/even and wide/narrow branches |
| `\chapterstylelines` | kaobook.cls:145-169 | no | hand-laid boxes and leaders rules |
| `\hrulefill` redefinition | kaobook.cls:142-144 | yes | `\leaders\hrule height #1\hfill` is `sp.rule` |
| `\chapterstylebar`, `\setchapterimage` | kaobook.cls:116-139, 235-244 | no (ART) | TikZ overlay node, `\includegraphics` in a chapter preamble |
| `\frontmatter`/`\mainmatter`/`\backmatter`/`\appendix` redefinitions | kaobook.cls:50-90 | yes | sequence of `\pagestyle`, `\pagelayout`, `\setchapterstyle`, `\bookmarksetup{startatroot}`; reducible once its callees are |
| `\hscale`/`\vscale`, `\pagelayout`, `\marginlayout`, `\widelayout` | kao.sty:113-234 | yes | `\newgeometry` values in the Component map plus `\marginfloatsetup`/`\widefloatsetup`; `\pagelayout{fullwidth}` calls `\fullwidthlayout` but only `\fullwidthpage` is defined (kao.sty:179, 220), a latent inconsistency, not used by the sample |
| running-head page styles | kao.sty:266-316 | no | overlapping zero-width boxes into the margin |
| `\title`/`\author` optional plain text, `\pretocmd{\maketitle}` | kao.sty:77-102 | yes | `\title`, `\author`, `\hypersetup{pdftitle,pdfauthor}`, `\pdfbookmark` |
| `\@body@par`, `\@margin@par` | kao.sty:342-363 | yes | `\justifying`, `\singlespacing`, `\frenchspacing`, lengths and `\footnotesize` as in the Component map |
| `widepar`, `fullwidthpar`, `wideequation` | kao.sty:370-406 | yes | `addmargin` with lengths (the twoside branch is the part not in the sample) |
| `\marginnote`, `\sidenote`, `\sidenotetext`, `\IfInFloatingEnvir` | kao.sty:451-523 | no | redefines `sidenotes` internals, hand flag set by `\AtBeginEnvironment` |
| `marginfigure`, `margintable`, `marginlisting`, `\marginskip` | kao.sty:594-645 | no | `lrbox` + `minipage` + `\marginnote` composition with `\FloatBarrier` |
| `kaocaption` toggle on `figure`/`table` | kao.sty:651-697 | no | hand toggle driving `\RawFloats\centering` |
| float and caption settings | kao.sty:700-879 | yes | `\floatsetup`, `\DeclareFloatStyle`, `\captionsetup`, `\DeclareCaptionFormat` calls (parameters in the Component map) |
| `\margintoc`, `\mtocsection`, `\mtocsubsection`, `\section`/`\subsection` redefinition | kao.sty:987-1135 | no | `\RenewDocumentCommand` of the sectioning commands, `etoc` style code with `\setbox` measuring |
| hyperref/footnote internals | kao.sty:429-434, 1216-1253 | no | rewrites `\@footnotemark`, `\@makefntext`, `\footref`, adds a hyperref key |
| `kaobox`, `kaocounter` | kao.sty:1301-1346 | yes | `\newtcolorbox` options; counter within section |
| `kaofloating`, `\listofinsights` | kao.sty:1354-1371 | yes | `\DeclareFloatingEnvironment` + `\addtotoclist`; written as kernel `\@float` hooks with mismatched names |
| listing styles | kao.sty:881-938 | yes | `\lstdefinestyle` |
| `kaotheorems.sty` | kaotheorems.sty:1-395 | yes | `\declaretheoremstyle`/`\declaretheorem`/`\tcolorboxenvironment`; the `framed` and `background` options are load-time choices |
| `kaorefs.sty` | kaorefs.sty:1-261 | yes | `\newcommand` aliases, `cleveref` options, `\addto\captions...` strings |
| shorthand macros | kao.sty:1400-1431 | yes | `\newcommand` aliases (`\Class`, `\ie`, `\eg`, `\etal`, `\monthyear`...) |
| `\blankpage` | kao.sty:319-323 | yes | `\null\thispagestyle{empty}\newpage` |
| `\@titlehead` use in the sample | main.tex:35-49 | yes | KOMA internal holding the title head text; the emitter writes the text |
| programming support packages | kao.sty:16-28 | yes | `kvoptions`, `etoolbox`, `calc`, `iftex`, `xifthen`, `options`, `xparse`, `xpatch`, `xstring`, `xspace`, `scrhack`, `morewrites`, `filehook`: no look of their own, they serve the bespoke code above |
| `subfiles` | kao.sty:1379 | yes | no look effect (modular input); no lib way and none proposed |
| `kaobiblio.sty` | kaobiblio.sty:1-426 | no (not loaded) | biblatex `\DeclareCiteCommand`/`\xpatchbibmacro` programming |
| `\let\c@abspage\relax` | kao.sty:570 | yes | compatibility patch, no look |

## Content-opaque
none (the margin-figure placeholder `\fbox{\parbox{...}}` at main.tex:94 is content and has lib homes; no TikZ picture inside a float)

## Lib changes
- New ways proposed:
  - `sp.frenchspacing` kernel `\frenchspacing`/`\nonfrenchspacing`, pdf. W1: kernel/TeX primitive. W2: a boolean switch, no code to edit. W3: any text. W4: one preamble line or a group wrapper. No home found in `sp.*` (`sp.lengths` and `sp.penalties` are parameters, not this switch).
  - `fn.footnotebackref` `footnotebackref` package (CTAN), pdf. W1: published. W2: load-time switch like `cols.balance`. W3: serves footnotes in any document. W4: `\usepackage{footnotebackref}` after `hyperref`. Loaded by the class (kao.sty:429), not exercised by the sample body.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Manifest hints `xelualatex,tikz,minted,biblatex` do not match the files: `minted` loads only for `listing=minted` (kao.sty:539-566), `biblatex` only in `kaobiblio.sty`, which the sample does not load, and the README builds with `pdflatex` and `makeindex` (README.md:23-27). No `EXTERNAL` blocker is raised: `minted` is conditional, `glossaries[xindy]` needs a tool only after `\makeglossaries` (absent), and `makeindex` ships with the TeX distribution (as `bibtex` does for `bib.bibtex-bst`).
- README.md:15-19 says `kaobiblio.sty` is "deliberately not included", yet the file is in the zip.
- No text addressed to an AI was found in the zip.
- Class origin basis: README.md:14-15 says kaobook "is not on TeX Live"; one read of https://ctan.org/pkg/kaobook returned HTTP 404 (the only ctan.org read used); the class header says "Modified for LaTeX Templates by Vel" (kaobook.cls:16), so the zip is not an official release kit.
- Under XeLaTeX/LuaLaTeX the class switches to `fontspec` + `unicode-math` Libertinus (kao.sty:1141-1159); that is an option path, not what the README builds.
