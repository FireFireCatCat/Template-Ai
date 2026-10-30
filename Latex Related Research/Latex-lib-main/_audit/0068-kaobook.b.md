no

# 0068-kaobook: Kaobook

- Unverified: read from the source, not compiled.
- Source: Source/0068-kaobook/ (origin: https://latextemplates.com/downloads/kaobook.zip; licence: LPPL-1.3c)
- Kind: book
- Lib: v2
- Engine: pdfLaTeX-compatible (README builds with `pdflatex`; kao.sty:49-69 picks the `tex` font branch under pdfTeX and a Libertinus/`unicode-math` branch under XeLaTeX/LuaLaTeX, kao.sty:1141-1182)
- Look carried by: zip-local (the sample preamble is almost empty, main.tex:7-23; the look lives in kaobook.cls, kao.sty, kaorefs.sty, kaotheorems.sty)
- Class origin: zip-local (`kaobook` is not on CTAN: ctan.org/pkg/kaobook returned 404; kaobook.cls:16 says "Modified for LaTeX Templates by Vel", so the zip is a derivative, not the author's release; the README's "unmodified copies" and "kaobiblio.sty is not included" are both contradicted by the zip itself)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (kaobook.cls 282 lines, kao.sty 1431, kaorefs.sty 261, kaotheorems.sty 396, kaobiblio.sty 426 read in full; kaobiblio.sty is NOT loaded by the sample or by the class)

## Verdict
No. The visible look of kaobook is carried by zip-local code that is not published, and a large part of it is irreducible: the `kao` chapter heading is a hand-laid `\smash`/`\makebox`/`\parbox`/`\rule` construct with page-parity and layout-state branches (kaobook.cls:172-232), `\sidenote` is rebuilt by redefining internals of the `sidenotes` package (kao.sty:490-523), margin floats depend on a global in-float flag set by `\AtBeginEnvironment` hooks (kao.sty:459-488, 594-697), `\section` is redefined to feed a margin table of contents measured in a dry run (kao.sty:997-1135), and `\@footnotemark`/`\@makefntext` are replaced (kao.sty:1216-1253). The `bar` chapter style is TikZ overlay artwork. Most other parts (geometry, fonts, captions, floatrow, theorems, cleveref, listings, tocbasic) reduce cleanly to lib ways.

## Blockers
- `BESPOKE/class` chapter style `kao` (selected by the sample, main.tex:65 and kaobook.cls:68): box-and-glue heading with `\Ifthispageodd`, `\if@twoside`, `\IfWideLayout` branches and widths from `\textwidth`/`\marginparwidth`/`\marginparsep`/`\f@size`, hooked into KOMA's `\chapterlinesformat` (kaobook.cls:172-232); the `lines` style is the same kind (kaobook.cls:145-169)
- `BESPOKE/class` sidenote internals: `\sidenote`, `\sidenotetext` and the package-internal `\@sidenotes@thesidenotemark` redefined (kao.sty:490-523); the sample calls `\sidenote` (main.tex:74, 87)
- `BESPOKE/class` margin note and margin float machinery: `\marginnote` redefined around a global `\ifinfloat` flag set by `\AtBeginEnvironment{minipage}` and `{tcolorbox}` (kao.sty:459-488); `marginfigure`/`margintable` built from `lrbox`+`minipage`+`\marginnote`+`\marginskip` on that flag (kao.sty:594-630); `kaocaption` toggle plus `\RawFloats` at the end of figure/table (kao.sty:650-697). Sample: main.tex:92-114
- `BESPOKE/class` margin table of contents: `\section`/`\subsection` redefined with a fourth optional argument that writes `mtocsection` etoc lines on every call (kao.sty:1018-1065; hit by main.tex:72, 78, 83), and `\margintoc` measuring entry widths in a dry run with `\setbox0` and `\edef` (kao.sty:1071-1135). The sample never calls `\margintoc`, but the redefined `\section` runs.
- `BESPOKE/class` footnote internals: kernel `\@footnotemark` and `\@makefntext` replaced using hyperref internals (`\Hy@saved@currentHref`, `\hyper@makecurrent`, `\BHFN@OldMakefntext`), `\patchcmd{\footref}` (kao.sty:432-434, 1216-1253)
- `ART/class` chapter style `bar`: `tikzpicture[remember picture, overlay]` node drawing a grey band (kaobook.cls:116-139) and `\setchapterimage`, a full-bleed image above the heading (kaobook.cls:235-244). Not selected by the sample (it sets only `kao` and `plain`, main.tex:65, 133), but the class file is in scope.

Not blockers, checked: `minted` is loaded only when the class option `listing=minted` is given (kao.sty:529-549, 564-567); the default is `listings`, the sample passes no such option, so no EXTERNAL/package here (it would be EXTERNAL/package if that option were chosen). `glossaries[xindy,...]` is loaded unconditionally (kao.sty:1395) but xindy is only run after `\makeglossaries`, which the sample never calls, so the document does not need xindy to build. `makeindex` for `imakeidx` is a standard TeX Live tool (README step 3), the same kind as BibTeX under `idx.makeidx`.

## Class setting
- Class: `class.scrbook` loaded by the zip-local class `kaobook` (kaobook.cls:29, 42). Options set by kaobook: a4paper, fontsize=10pt, parskip=half, headings=optiontoheadandtoc (kaobook.cls:32-35), toc=listof, toc=index, toc=bibliography (kaobook.cls:271-273). Sample options: fontsize=10pt, twoside=false, secnumdepth=1 (main.tex:7-11). `kaobook` itself is zip-local, so it is not a class way.
- Class-native vocabulary used: KOMA `\titlehead`, `\publishers`, `\uppertitleback`, `\lowertitleback`, `\maketitle`, `\frontmatter` `\mainmatter` `\backmatter`, `\chapter*`, `\addpart`, `\appendix` (main.tex:27-64, 124-132). KOMA hooks the class uses: `\chapterlinesformat`, `\chapterformat`, `\RedeclareSectionCommand`, `\setchapterpreamble`, `\addtokomafont`, `\setkomafont`, `\Ifthispageodd`, `\DeclareTOCStyleEntries`, `\setuptoc`. kaobook-own (zip-local): `\setchapterstyle{kao|plain|bar|lines}`, `\pagelayout{margin|wide|fullwidth}`, `\sidenote`, `marginfigure`, `margintable`, `marginlisting`, `\margintoc`, `kaobox`, `kaocounter`, `widepar`, `wideequation`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | kaobook.cls:29-44; main.tex:7-11 | `class.scrbook` | a4paper, fontsize=10pt, parskip=half, headings=optiontoheadandtoc, toc=listof/index/bibliography, twoside=false, secnumdepth=1 |
| page geometry, default | kao.sty:117-118, 125, 170-173, 234 | `page.geometry` | paperwidth=210\hscale, paperheight=297\vscale, with \hscale=\vscale=1mm for a4paper |
| page layout `margin` | kao.sty:192-203; kaobook.cls:67 | `page.geometry` | `\newgeometry` top=bottom=27.4mm, inner=24.8mm, textwidth=107mm, marginparsep=6.2mm, marginparwidth=47.7mm |
| page layout `wide` | kao.sty:206-217; kaobook.cls:55, 88; main.tex:123, 125 | `page.geometry` | `\newgeometry` top=bottom=27.4mm, inner=outer=24.8mm, marginparsep=0mm, marginparwidth=0mm |
| header/footer | kao.sty:240, 245, 266-326; kaobook.cls:54, 66, 87 | `hf.scrlayer-scrpage`, `hf.pagestyle-kernel` | `\renewpagestyle{scrheadings}` with kernel-box fields (`\makebox`, `\smash`, `\rule[-1mm]{0.5pt}{19mm-1mm}`, `\thepage`, `\leftmark`, `\rightmark`); `plain.scrheadings` empty; headsep=11mm; `\pagestyle` switched per matter |
| paragraph shape | kao.sty:332-363 | `sp.ragged`, `sp.setspace`, `sp.frenchspacing`, `font.size-commands`, `sp.lengths` | body: `\justifying`, `\singlespacing`, `\frenchspacing`, `\normalsize`; margin: `\justifying`, `\parindent`=0, `\RaggedRightParindent`=0, `\parskip`=0.5pc, `\footnotesize` |
| line spacing | kao.sty:1187 | `sp.linespread` | `\linespread{1.07}` |
| text-flow packages | kao.sty:332-336 | `sp.microtype`, `sp.hyphenat`, `pg.needspace` | load-only (defaults); `ragged2e` and `setspace` above |
| display and column rules | kao.sty:584-591 | `sp.lengths` | \abovedisplayskip=10pt plus 2pt minus 5pt, \abovedisplayshortskip=0pt plus 3pt, \belowdisplayshortskip=6pt plus 3pt minus 3pt, \columnseprule=.4pt |
| fonts, pdfTeX branch (default) | kao.sty:1160-1170 | `font.fontenc-t1`, `font.palatino`, `font.mono`, `math.amssymb`, `math.bm`, `fig.placement` | inputenc utf8, fontenc T1; `newpxtext[scaled=.97,helvratio=.93,p,theoremfont]` with `newpxmath[vvarbb,smallerops,bigdelims]` (Palatino-like package as the parameter); `beramono[scaled=.85]`; `mathalfa[scr=rsfso,cal=boondoxo]`; `morewrites` (load-only float-register fix, closest home `fig.placement`) |
| fonts, XeLaTeX/LuaLaTeX branch | kao.sty:1141-1159 | `font.fontspec`, `font.unicode-math`, `math.amssymb` | Libertinus Serif Scale=1.04, Libertinus Sans, Liberation Mono Scale=.89, Libertinus Math; engine-conditional, not the pdfLaTeX default |
| colour | kao.sty:19, 883-887, 1271-1283, 1321 | `color.xcolor` | `xcolor[usenames,dvipsnames,table]`; link colours citecolor=OliveGreen, filecolor=OliveGreen, linkcolor=Black, urlcolor=OliveGreen; listing and box colours defined (RoyalBlue!25!White) |
| language | main.tex:13-14 | `lang.babel`, `lang.csquotes` | `babel[english]`; `csquotes[english=british]` |
| PDF metadata and links | kao.sty:78-102, 1196-1214; kaobook.cls:77, 86 | `meta.hyperref`, `meta.bookmark`, `meta.url` | `hyperref`: unicode, pdfborder={0 0 0}, bookmarksdepth=section, bookmarksopen=true, linktoc=all, breaklinks=true, colorlinks=true; `bookmark`, `\bookmarksetup{startatroot}`; `url` option hyphens (kao.sty:1199); `pdftitle`/`pdfauthor` set via `\hypersetup` |
| title block | main.tex:27-31, 36-51; kao.sty:78-102 | `front.koma-title`, `front.maketitle` | `\titlehead{Lecture Notes}`, `\publishers{...}`, `\uppertitleback`, `\lowertitleback{...}`, `\title[plain]{...}`, `\author[plain]{...}`, `\date{\today}`, `\maketitle` |
| preface chapter | main.tex:53-56 | `head.kernel` | `\chapter*{Preface}` |
| front/main/back matter | main.tex:33, 64, 132; kaobook.cls:50-90 | `class.scrbook` vocabulary, `hf.pagestyle-kernel`, `page.geometry` | `\frontmatter` -> plain page style, wide layout, chapter style plain; `\mainmatter` -> `scrheadings`, margin layout, chapter style kao; `\backmatter` -> plain, wide, plain |
| table of contents | main.tex:58-62; kao.sty:944-973, 985 | `toc.kernel`, `toc.etoc`, `toc.tocbasic` | `\etocstandarddisplaystyle`, `\etocstandardlines` around `\tableofcontents`; `\setuptoc{toc}{totoc}`; `\DeclareTOCStyleEntries[level=1,indent=0em,numwidth=2em,dynnumwidth=yes,pagenumberwidth=2.1em]{tocline}{figure,table,lstlisting,listing}`; `tocdepth=\subsectiontocdepth`; `scrhack` (load-only KOMA compat, kao.sty:29; closest home `toc.tocbasic`) |
| heading fonts | kaobook.cls:254-264; kao.sty:700 | `head.koma-fonts`, `cap.koma` | `\addtokomafont` part/partentry `\normalfont\scshape\bfseries`; chapter/chapterentry/section/subsection/subsubsection/paragraph `\normalfont\bfseries`; `descriptionlabel` `\normalfont\bfseries`; `captionlabel` `\bfseries` |
| heading spacing | kaobook.cls:105-113 | `head.class-native` | `\RedeclareSectionCommand[beforeskip=0cm,afterskip=10mm]{chapter}`; `\addpart{Appendix}` (main.tex:124) |
| chapter heading look `kao` | kaobook.cls:172-232; main.tex:65 | BESPOKE (no way) | blocker, see above |
| numbering | kaobook.cls:281; kao.sty:9, 950, 987-988, 1343; main.tex:10, 127 | `num.secnumdepth`, `num.counters`, `num.appendix` | secnumdepth=1 via family key; tocdepth; `\counterwithin*{sidenote}{chapter}`; `\counterwithin{kaocounter}{section}`; `\appendix` plus `\bookmarksetup{startatroot}` |
| lists | kao.sty:1289-1294; kaobook.cls:264 | `list.kernel`, `list.enumitem` | `\labelitemi`=`\small$\blacktriangleright$`, `\labelitemii`=`\textbullet`; `enumitem[inline]`, `\setlist[itemize,enumerate,description]{noitemsep}` (sample has no lists) |
| wide blocks | kao.sty:370-406 | `list.scrextend` | `addmargin[0cm]{-\marginparwidth-\marginparsep}` (and twoside variants); `widepar`, `fullwidthpar`, `wideequation`; unused by the sample |
| sidenotes | main.tex:74, 87; kao.sty:415-418, 490-523 | `note.sidenotes`, `note.marginnote`, `note.marginpar` | packages `marginnote`, `sidenotes`, `chngcntr`; look is BESPOKE (blocker) |
| footnotes | kao.sty:421-429 | `fn.footmisc`, `fn.footnotebackref` | `footmisc[bottom,symbol*,hang,flushmargin,stable]`; `footnotebackref`; internals BESPOKE (blocker); sample has no `\footnote` |
| margin figure and table | main.tex:92-114; kao.sty:603-630 | `note.sidenotes`, `cap.caption`, `box.minipage` | `marginfigure`, `margintable` = `lrbox`+`minipage{\marginparwidth}`+`\captionsetup{type=...}`+`\marginnote`; BESPOKE as built (blocker) |
| float placement | kao.sty:412-413, 574-581 | `fig.placement` | `placeins[section]`, `\extrafloats{100}`, \topfraction=.9, \textfraction=0.35, \floatpagefraction=0.8, \FBaskip=.4\topskip |
| float captions layout | kao.sty:648, 731-879 | `fig.floatrow` | `\DeclareFloatStyle{kaofloat}{capposition=beside, capbesideframe=yes, capbesidewidth=\marginparwidth, capbesidesep=marginparsep, floatwidth=\textwidth}`; `\floatsetup[figure,table,widefigure,widetable,lstlisting,listing,widelisting,longtable]` margins=hangoutside/hangright, facing, capbesideposition; `\DeclareFloatSeparators{marginparsep}{\hskip\marginparsep}` |
| captions | kao.sty:555, 699-729 | `cap.caption` | `caption[hypcap=true]`; `\captionsetup{format=margin, labelsep=colon, strut=no, singlelinecheck=false, indention=0pt, parindent=0pt, aboveskip=6pt, belowskip=6pt}`; `\DeclareCaptionFormat{margin}{\@margin@par #1#2#3}`, `{llap}`; `\DeclareCaptionLabelFormat{cont}` |
| graphics | main.tex:21; kao.sty:551-552, 560 | `fig.graphicx`, `fig.rotating` | `\setkeys{Gin}{width=\linewidth,totalheight=\textheight,keepaspectratio}`; `\graphicspath{{images/}{./}}`; `rotating` |
| tables | main.tex:104-111; kao.sty:557-558, 19 | `tbl.tabular`, `tbl.booktabs`, `tbl.multirow`, `tbl.colortbl` | `tabular{lr}` with `\toprule` `\midrule` `\bottomrule`; `multirow`; `xcolor[table]` |
| equations and theorems | kaotheorems.sty:32-34, 246-395; main.tex:18 | `math.amsmath`, `thm.amsthm`, `thm.thmtools` | package loaded with no options, so the unframed branch: `\declaretheoremstyle[spaceabove=.6\thm@preskip, spacebelow=.1\thm@postskip, bodyfont=\normalfont\itshape, headpunct={}]{kaoplain/kaodefinition/kaoassumption/kaoremark/kaoexample}`, `kaoexercise` with postheadspace; `\declaretheorem[name, refname, Refname, numberwithin=section | sibling=theorem]` for theorem, proposition, lemma, corollary, definition, assumption, remark, example, exercise |
| framed theorems (unselected) | kaotheorems.sty:40-243 | `thm.tcolorbox` | `\tcolorboxenvironment{...}{colback=Goldenrod!45!white, breakable, sharp corners, boxrule=0pt, frame hidden, ...}` |
| cross-references | main.tex:79-81, 99, 116; kaorefs.sty:12-21, 252-261 | `xref.cleveref`, `xref.varioref`, `xref.hyperref`, `xref.kernel` | `cleveref[capitalise,nameinlink,noabbrev]`; `\creflabelformat{equation}`, `\crefname{subsection}`; `varioref`; `\label{ch:intro}`; `\hyperref` wrapper around `\vpageref` |
| caption names | kaorefs.sty:48-107 | `lang.babel` | `\addto\captionsenglish` (and german, danish, italian, russian) renaming `\sectionname`, `\eqname`, `\thmname`... |
| boxes | kao.sty:1301-1347 | `box.tcolorbox` | `tcolorbox[most]`; `\newtcolorbox{kaobox}[1][]{breakable, before/after skip=1.5\topskip, left=right=4pt, top=bottom=2pt, sharp corners, boxrule=0pt, titlerule=.4pt, colback=RoyalBlue!25!White, fonttitle=\bfseries}` |
| placeholder figure | main.tex:94 | `box.fancybox`, `box.minipage` | `\fbox{\parbox{0.9\linewidth}{...}}` (content of the float) |
| code | kao.sty:529-563, 881-938 | `code.listings` | default `listing=listings`; `\lstdefinestyle{kaolst}` basicstyle=\small\ttfamily, numbers=left, frame=l, breaklines=true, captionpos=t, ...; `kaolstplain`; `\lstset{style=kaolst}`; `code.minted` only when `listing=minted` (unselected) |
| algorithms | kao.sty:1388 | `alg.algorithm2e` | `algorithm2e[linesnumbered,ruled,vlined]`; load-only, unused |
| index | main.tex:23, 135; kao.sty:27, 1394 | `idx.makeidx` | `imakeidx`; `\makeindex[columns=2, title=Index, intoc]`; `\printindex` |
| glossary, nomenclature | kao.sty:1395-1396 | `idx.glossaries` | `glossaries[xindy,toc,numberedsection=nameref]`, `nomencl[intoc]`; load-only, no `\makeglossaries` in the sample |
| other load-only packages | kao.sty:26, 554, 1378-1380, 1391 | `pg.afterpage`, `bg.tikzpagenodes`, `pg.include-pdf`, `pg.standalone-pkg`, `draft.todo`, `font.icons`, `cols.multicol` | `afterpage`; `tikzpagenodes`; `pdfpages`; `subfiles` (folded into `pg.standalone-pkg` in the v2 change log); `todonotes`; `ccicons`; `multicol` (kao.sty:559) |
| bibliography | none in sample; kaobiblio.sty:59 (not loaded) | none | the sample has no citation and no `\printbibliography`; `kaobiblio` would be `bib.biblatex-biber` plus bespoke `\sidecite` (see below) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class shell | kaobook.cls:29-44 | yes | `class.scrbook` with the option list above |
| matter wrappers `\frontmatter` `\mainmatter` `\appendix` `\backmatter` | kaobook.cls:50-90 | yes | emit `\pagestyle`, `\newgeometry`, chapter-style choice and `\bookmarksetup` at each switch |
| `\setchapterstyle` dispatcher | kaobook.cls:97-102 | yes | pick one style per use; the styles themselves are rows below |
| `\chapterstyleplain` | kaobook.cls:105-113 | yes | KOMA default heading plus `\RedeclareSectionCommand[beforeskip=0cm,afterskip=10mm]{chapter}` |
| `\chapterstylebar`, `\setchapterimage` | kaobook.cls:116-139, 235-244 | no | `ART/class`, TikZ overlay node (unselected by the sample) |
| `\hrulefill` redefinition | kaobook.cls:142-144 | yes | `sp.rule`: `\leaders\hrule height <t>\hfill` |
| `\chapterstylelines` | kaobook.cls:145-169 | no | box layout with `\scalebox{3.5}`, nested `\makebox` over `\textwidth`/`\marginparsep`/`\marginparwidth`; `BESPOKE/class` (unselected) |
| `\chapterstylekao` | kaobook.cls:172-232 | no | parity and layout-state branches over hand-laid boxes; blocker |
| KOMA fonts, toc options, sidenote counter | kaobook.cls:254-282 | yes | `head.koma-fonts`, class options, `num.counters` |
| family option `secnumdepth`, `fontmethod` | kao.sty:7-10, 42-69 | yes | `\setcounter{secnumdepth}{1}`; choose the pdfTeX `tex` branch |
| `\title`/`\author` with plain-text optional argument | kao.sty:77-102 | yes | `\title{}`, `\author{}` plus `\hypersetup{pdftitle=,pdfauthor=}` and `\pdfbookmark` |
| `\hscale`/`\vscale` paper table | kao.sty:113-167 | yes | literal lengths for the one paper size used (a4paper, 1mm) |
| `\pagelayout`, `\marginlayout`, `\widelayout`, `\recalchead`, `\IfWideLayout` | kao.sty:175-263 | yes, with a note | inline `\newgeometry{...}`; header lengths become `\dimexpr`; `\fullwidthlayout` is called (kao.sty:179) but only `\fullwidthpage` is defined (kao.sty:220), a latent bug; the `\IfWideLayout` flag also feeds the irreducible chapter style |
| page styles `scrheadings`, `plain.scrheadings`, `pagenum.scrheadings`, `centeredpagenum.scrheadings` | kao.sty:266-326 | yes, with a note | `\defpagestyle` fields built from kernel `\makebox`/`\smash`/`\rule`/`\hspace`; no lib way names `\makebox` or `\smash`, closest `sp.rule`, `sp.manual-space`, `box.fancybox` |
| `\@body@par`, `\@margin@par` | kao.sty:342-363 | yes | `sp.ragged`, `sp.setspace`, `sp.frenchspacing`, `sp.lengths`, `font.size-commands` |
| `widepar`, `fullwidthpar`, `wideequation` | kao.sty:370-406 | yes | `addmargin` with lengths (`list.scrextend`); one-sided branch only for `twoside=false` |
| `\marginnote` redefinition and `\ifinfloat` flag | kao.sty:451-488 | no | state set by `\AtBeginEnvironment` hooks decides what is printed; blocker |
| `\sidenote`, `\sidenotetext`, marker format | kao.sty:490-523 | no | redefines `sidenotes` package internals; blocker |
| `\marginskip`, `marginfigure`, `margintable`, `marginlisting` | kao.sty:594-645 | no | each is a composition of published commands, but depends on the `\marginnote` flag above; counted in that blocker |
| `kaocaption` toggle, `\RawFloats` | kao.sty:650-697 | no | per-environment conditional that changes float layout; blocker (unused by the sample) |
| caption formats, `kaofloat` style, `\marginfloatsetup`, `\widefloatsetup` | kao.sty:699-879 | yes | `cap.caption` and `fig.floatrow` keys as listed |
| listings styles | kao.sty:881-938 | yes | `code.listings` `\lstdefinestyle` keys |
| tocbasic setup | kao.sty:944-973 | yes | `toc.tocbasic` calls as listed |
| `\mtocsection`, `\mtocsubsection`, `\section`/`\subsection` redefinition, `\margintoc` | kao.sty:997-1135 | no | `\etoctoccontentsline` side effect plus dry-run width measurement; blocker |
| font methods | kao.sty:1141-1190 | yes | `font.palatino`, `font.fontenc-t1`, `font.mono`, `math.bm` (pdfTeX) |
| footnote and `\thanks` internals | kao.sty:432-434, 1216-1253 | no | replaces `\@footnotemark`, `\@makefntext`; blocker |
| `\let\c@abspage\relax` | kao.sty:570 | yes | workaround with no printed effect; drop |
| items, `kaobox`, `kaocounter` | kao.sty:1289-1347 | yes | `list.enumitem`, `box.tcolorbox` plus a counter |
| `kaofloating` float | kao.sty:1354-1371 | yes | `\DeclareFloatingEnvironment` (`fig.newfloat`) plus `toc.tocbasic`; as written the macros are named `floatingbox` while the environment is `kaofloating` (unused, latent bug) |
| text macros `\Class`, `\ie`, `\eg`, `\etal`, `\monthyear`, `\hangp`... | kao.sty:1400-1431 | yes | `\newcommand` aliases over `mark.kernel` and `font.size-commands`; unused by the sample |
| `kaorefs` label and ref macros, language strings | kaorefs.sty:29-261 | yes | `xref.cleveref`, `xref.varioref`, `xref.hyperref`, `lang.babel` caption names; `\vpageref` wrapper is `\hyperref` around varioref |
| `kaotheorems` | kaotheorems.sty:1-395 | yes | `thm.thmtools` and `thm.tcolorbox` as listed |
| `kaobiblio` | kaobiblio.sty:1-426 | not loaded | `\sidecite` family uses `\DeclareCiteCommand` and `\xpatchbibmacro` (irreducible if used); not loaded by the sample or by kao.sty, so not counted as a blocker here |

## Content-opaque
none that matters: `\fbox{\parbox{...}}` placeholder figure (main.tex:94) and the `tabular` cell text (main.tex:104-111) are float content and map to `box.fancybox`, `box.minipage`, `tbl.tabular`.

## Lib changes
- New ways proposed: none. Three load-only helpers have no line of their own and were placed in the nearest existing way, flagged in the rows: `scrhack` in `toc.tocbasic`, `morewrites` in `fig.placement`, `subfiles` in `pg.standalone-pkg`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes: no text addressed to an AI was found in the zip. The manifest hint `xelualatex,tikz,minted,biblatex` is only a hint; `minted` and `biblatex` are not loaded by default (kao.sty:529-567; kaobiblio.sty is unused) and the default engine is pdfLaTeX. Programming-support packages (`etoolbox`, `calc`, `iftex`, `xifthen`, `options`, `xparse`, `xpatch`, `xstring`, `kvoptions`, `xspace`, kao.sty:16-26, 337) serve the bespoke macros and carry no look, so they get no way. Nothing was compiled; no claim is made that the reductions reproduce the output.
