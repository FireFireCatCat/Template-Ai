yes

# 0559-mentis: mentis (LaTeX class for books of Mentis Verlag, Paderborn)

- Unverified: read from the source, not compiled.
- Source: Source/0559-mentis/ (origin: https://mirrors.ctan.org/macros/latex/contrib/mentis.zip; licence: lppl1.2)
- Kind: book
- Lib: v4
- Engine: pdfLaTeX-compatible (`microtype` expansion and protrusion, `fontenc`, `babel`, `jurabib`; no `fontspec`, no Lua; the manual driver's `pdfcprot` is pdfTeX-only)
- Look carried by: class (the zip is the class's own DocStrip source plus the generated `mentis.cls`; the look is `mentis.cls:28-416`, on top of `scrbook`)
- Class origin: ctan (CTAN package `mentis` v1.5, LPPL 1.2, in TeX Live, confirmed at ctan.org/pkg/mentis; README:3 says it is not an official release of the publisher, so not publisher-official)
- Main file: none (no .tex sample exists; the typical document start at mentis.dtx:288-313 stands in for one; the driver at mentis.dtx:19-52 is an `ltxdoc` build file for the manual, not a template sample) (other samples: none)
- Read: main yes (mentis.dtx 1-1357, whole), zip-local classes and styles all (`mentis.cls` 1-419 in full; its code equals the unprefixed code lines of mentis.dtx:451-1355, checked by diff; `mentis.ins` read; `mentis.pdf`, the compiled manual, not read; the `scrbook` source is not in the zip and was not read)

## Verdict
The zip is the DocStrip source of `mentis`, a class published on CTAN and in TeX Live (README:1-2, mentis.cls:11-21, ctan.org/pkg/mentis), so it is one way, `class.mentis`, loading `class.scrbook` (mentis.cls:28). An emitter writes `\documentclass[mentisgross,...]{mentis}`; the class itself sets page, running heads, contents, footnotes, quotes, index and bibliography, every component maps to a lib way, and its own commands (`\Pnum`, `\absatz`, `\Psatz`, `tolerant`) are class-native vocabulary, with no artwork and no external tool. The class patches kernel internals (`\@sect`, `\@chapter`, `\l@chapter`) and keeps hand-rolled counters in `\Pnum`; that code would be irreducible if the class were zip-local, so the `yes` rests on W1 (the class is published), see Bespoke code.

## Blockers
none

Recorded, not counted:
- Latent dependencies on the author's preamble, not declared by the class (not verified, nothing compiled): `\scalebox` in `\fett` needs `graphicx` (mentis.cls:402); `\mathbb` in `\setB`..`\setZ` needs `amsfonts`/`amssymb`, whose load line is commented out (mentis.cls:27, :368-373); the family `yfrak` of `\fraktext` `\swabtext` `\gothtext` comes from `yfonts` or `blacklettert1`, named at mentis.dtx:1330 (mentis.cls:399-401); `\ifthenelse` (mentis.cls:266-325) has no `\RequirePackage{ifthen}` in the zip, so a loaded package must supply it; `\ftntm@font` (mentis.cls:160) is not defined in the zip, so `scrbook` must supply it.
- `scrpage2` (mentis.cls:43) is the old KOMA page-style package; whether the current TeX Live still ships it was not checked.
- The manual driver (mentis.dtx:19-52) loads `picinpar` (`tabwindow`, mentis.dtx:152-171) and `pdfcprot` (mentis.dtx:36), which have no lib way; considered: `picinpar`, `pdfcprot` (both on CTAN; `pdfcprot` is "largely superseded by" `microtype`, `picinpar` is a legacy package). They typeset the manual, not a book in the mentis template, so they are outside the template scope (same ruling as the `ucsmonograph` driver) and no way is proposed.

## Class setting
- Class: `class.mentis` options: `mentisgross`, `mentisklein`, `mentisroemisch` (mentis.cls:57-59); every other option goes to `scrbook` (mentis.cls:54-56): `smallheadings`/`normalheadings`/`bigheadings`, `openany`/`openright`, `10pt`/`11pt`/`12pt`, `oneside`/`twoside`, `a5paper`, `final`/`draft`, and babel language names (mentis.dtx:182-187, :218-241). The manual says one of `mentisgross`/`mentisklein` must be given (mentis.dtx:189-192); the code does not enforce it (mentis.cls:137). Example call: `[mentisgross,smallheadings,openright,11pt,greek,english,french,ngerman]{mentis}` (mentis.dtx:290-299).
- Class-native vocabulary used (documented; the zip has no body sample): `\chapter[short]{long}` and the other sectioning commands with an optional short title for the running head only (mentis.dtx:318-330), `\Pnum{}` / `\Pnum{text}`, `\absatz`, `quote` (and obsolete `footquote`), `\Psatz{number}{sentence}`, `\randnummer`, quotation shortcuts `\Dll \Drr \Dl \Dr \Ell \Err \El \Er`, `\strich \stern \spitz \textsubscript \tief \hochtief \textbfsf \roem \setB \setC \setN \setQ \setR \setZ`, `tolerant[n]`, `\fraktext \swabtext \gothtext \antiktext \fett`, lengths `\ChapterExtraWidth \SectionExtraWidth \SubsectionExtraWidth`, `jurabib` citation commands, and inherited KOMA commands (`\deffootnote`, `\usekomafont`, `\marginline`).

## Component map
Each row names the lib way that realises the part inside the class; an emitter reaches all of them with the one `class.mentis` line. The `scrbook` source and the loaded packages' sources are not in the zip and were not read.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | mentis.cls:23-24, :28; mentis.dtx:452 | `class.mentis` | `\ProvidesClass{mentis}[2006/03/01 v1.5]`; `\LoadClassWithOptions{scrbook}` |
| base class | mentis.cls:28, :54-56 | `class.scrbook` | `\LoadClassWithOptions{scrbook}`; unknown options passed on by `\DeclareOption*` and `\PassOptionsToClass`; source not read |
| class options | mentis.cls:57-59, :63-67, :131-136, :137 | `class.mentis` | `mentisgross`, `mentisklein` (text block), `mentisroemisch` (roman chapter numbers, wider contents labels); `\ProcessOptions\relax` |
| paper, size, sides, draft | mentis.dtx:200-241 | `page.class-options` | `a4paper` (default), `a5paper`, `10pt` `11pt` `12pt`, `oneside`/`twoside`, `openany`/`openright`, `draft` (black bars on overlong lines), `final` |
| text block | mentis.cls:53, :131-136; mentis.dtx:152-171 | `page.geometry` | `mentisgross`: width=117mm,height=195mm,includehead; `mentisklein`: width=100mm,height=182mm,includehead |
| margin note and head distance | mentis.cls:128-130 | `page.setlength` | `\marginparsep` 2mm, `\marginparwidth` 17mm, `\headsep` .5\baselineskip |
| bottom alignment | mentis.cls:34 | `pg.flush` | `\raggedbottom`, run `\AtBeginDocument` |
| running heads, page numbers | mentis.cls:32-33, :142, :143-158; mentis.dtx:713-737 | `hf.class-native` | page style `mentis` made with `\newpagestyle` (`scrpage2`, :43); head even `\rlap{\pagemark}\hfill\leftmark\hfill`, odd `\hfill\rightmark\hfill\llap{\pagemark}`, one-sided `\hfill\headmark\hfill`; foot empty when two-sided, `\hfill\pagemark\hfill` when one-sided; `\headfont` = `\normalfont\small\itshape`; style selected at begin document |
| pages without head and foot | mentis.cls:138-141; mentis.dtx:692-707 | `hf.class-native` | `\titlepagestyle` `\partpagestyle` `\chapterpagestyle` `\indexpagestyle` = `empty` |
| headings | mentis.cls:200-259; mentis.dtx:215-217, :883-976 | `head.class-native` | `scrbook` heading looks chosen by `smallheadings`/`normalheadings`/`bigheadings`; `\@chapter` and `\@sect` re-defined so that contents lines get the full title (`#2`, `#8`) and the running head the optional short title (`#7`) |
| roman chapter numbers | mentis.cls:63-67; mentis.dtx:194-198, :584-594 | `num.counters` | `mentisroemisch`: `\thechapter` = `\Roman{chapter}`, `\thesection` = `\arabic{section}` (no chapter prefix) |
| contents | mentis.cls:60-127; mentis.dtx:556-654 | `toc.kernel` | `\tableofcontents`; `\l@chapter` `\l@section` `\l@subsection` `\l@subsubsection` re-defined: `\@dottedtocline` levels 1-3, label widths 1.5em/2.3em/3.2em/4.1em, section indents 1.5em/3.8em/7.0em, `\@pnumwidth` 1.95em; user lengths `\ChapterExtraWidth` (1em under `mentisroemisch`), `\SectionExtraWidth`, `\SubsectionExtraWidth` (0em), set by `\setlength` |
| numbered untitled paragraph | mentis.cls:260-310; mentis.dtx:331-344 | `class.mentis` | `\Pnum{}`: `\bigskip\par\noindent`, steps the next free sectioning counter, prints it in `\usekomafont{sectioning}`; `\Pnum{text}` prints the text instead; not in contents; `\ClassError` when no level is free |
| star paragraph break | mentis.cls:311-313; mentis.dtx:346-348 | `class.mentis` | `\absatz`: `\removelastskip\medskip`, centred `$\star$`, `\medskip\noindent` |
| long quotation | mentis.cls:181-190; mentis.dtx:350-358 | `quote.kernel` | `quote` re-defined as `\list`: listparindent 1em, itemindent 0, leftmargin 2em, rightmargin 0, parsep 0, `\smaller` (`relsize`, :49); `footquote` = `quote`, obsolete since v1.1 (mentis.cls:191; mentis.dtx:812-816) |
| example sentence | mentis.cls:314-333; mentis.dtx:385-391 | `class.mentis` | `\Psatz{n}{text}`: `list` with topsep, parsep, parskip 0, leftmargin 2em, rightmargin 0, listparindent `\parindent`, `\fussy`; number as `\marginline{\small(n)}` (KOMA), omitted when empty |
| guillemets | mentis.cls:192-195; mentis.dtx:360-382 | `lang.babel` | `\Dll`=`\frqq`, `\Drr`=`\flqq`, `\Dl`=`\frq`, `\Dr`=`\flq` (babel quotation commands) |
| English quotes | mentis.cls:196-199 | `font.fontenc-t1` | `\Ell`=`\textquotedblleft`, `\Err`=`\textquotedblright`, `\El`=`\textquoteleft`, `\Er`=`\textquoteright` (kernel/`textcomp` text symbols) |
| footnote mark and text | mentis.cls:159-161, :176; mentis.dtx:747-779 | `class.scrbook` | `\deffootnote[1.2em]{1.2em}{1.2em}{\textsuperscript{\thefootnotemark}\ }` (KOMA); `\@makefnmark` carries `\microtypecontext{protrusion=footnotes}` |
| footnote | mentis.dtx:240, :319-323, :365-372 | `fn.kernel` | `\footnote{...}`; the manual itself uses it |
| footnote rule | mentis.cls:177-180; mentis.dtx:782-787 | `sp.rule` | `\footnoterule` = `\hrule\@width 2cm` then `\kern8\p@` |
| protrusion and expansion | mentis.cls:50, :162-175; mentis.dtx:517-521, :243-247 | `sp.microtype` | `stretch=15,shrink=15,step=5`; `\SetProtrusion[context=footnotes]{font=*/*/*/*/scriptsize}` with digit table 0={,400} 1={,650} 2={,400} 3-6={,400} 7={,500} 8,9={,400} (right side only); `\microtypesetup{expansion=false}` offered to the user |
| widows and clubs | mentis.cls:367; mentis.dtx:1239-1244 | `sp.penalties` | `\clubpenalty=5001`, `\widowpenalty=5001` |
| ragged index | mentis.cls:52, :410; mentis.dtx:522-523 | `sp.ragged` | `ragged2e`, `\RaggedRight` at the start of `theindex` |
| tolerance wrapper | mentis.cls:394-398; mentis.dtx:423-428 | `class.mentis` | `tolerant[4900]` environment: `\par\tolerance=#1\relax` ... `\par` (manual: values up to 9999) |
| index | mentis.cls:31, :48, :404-416; mentis.dtx:1339-1354 | `idx.makeidx` | `makeidx`; `\makeindex` at begin document; `\theindex`/`\endtheindex` wrapped around the kernel environment |
| index columns | mentis.cls:51, :407-416 | `cols.multicol` | `multicols{2}` replaces `\twocolumn` inside `theindex` |
| citations, bibliography | mentis.cls:44, :334-366; mentis.dtx:417-420, :1116-1230 | `bib.apacite` | `jurabib`; `\jurabibsetup{authorformat=citationreversed, authorformat=firstnotreversed, authorformat=and, edby=true, titleformat=all, titleformat=colonsep, ibidem=strict, bibformat=ibidem, see=true, human=true, commabeforerest=true}`; `\bibpldelim` `(`, `\bibprdelim` `)`, `\bibauthormultiple` `-- `, `\biblnfont` and `\bibelnfont` `\textsc`, `\bibfnfont` and `\bibefnfont` empty, `\bibtfont` `\bibbtfont` `\bibjtfont` `\textit`, `\bibapifont` and `\jbapifont` = guillemets; `\jbbibhang` 1em; `\jbdotafterbibentry`; `\ibidemname` Ebenda, `\ibidemmidname` ebenda via `\AddTo\bibsgerman` |
| bibliography backend | mentis.dtx:417-420 | `bib.bibtex-bst` | BibTeX with `jurabib` (manual recommends it); `.bst` chosen by the author |
| language | mentis.cls:37; mentis.dtx:231-234, :295-298 | `lang.babel` | `\RequirePackage{babel}` with no option; languages come as global class options (sample `greek,english,french,ngerman`, last = main) |
| encodings | mentis.cls:36, :42; mentis.dtx:300 | `font.fontenc-t1` | `fontenc` `LY1,OT4,T5,OT1,T3,T1` (T1 last, default), `textcomp`; author adds `\usepackage[latin1]{inputenc}` |
| blackletter shortcuts | mentis.cls:399-401, :403; mentis.dtx:1325-1337 | `font.nfss` | `\fraktext` `{\fontfamily{yfrak}\selectfont}`, `\swabtext` adds `\textsl`, `\gothtext` adds `\textbf`; `\antiktext` = `\textrm{\textup{}}`; family `yfrak` is the author's to load |
| fake bold | mentis.cls:402 | `fig.graphicx` | `\fett` = `\scalebox{1.25}[1]{#1}` (a `graphicx` command; the class does not load it) |
| text marks | mentis.cls:379-381, :393 | `mark.kernel` | `\textbfsf` = `{\sffamily\bfseries #1}`; `\roem` = `\textsc{\@roman{#1}}` |
| script and prime shortcuts | mentis.cls:374-378, :382-392; mentis.dtx:1254-1308 | `math.kernel` | `\strich` `{}^{\prime}`, `\stern` `{}^{\ast}`, `\spitz` `\langle\text{#1}\rangle`, `\textsubscript`/`\tief` `_{\mbox{\fontsize\sf@size\z@#1}}`, `\hochtief` upper and lower script |
| number-set symbols | mentis.cls:368-373; mentis.dtx:1245-1252 | `math.amssymb` | `\setB \setC \setN \setQ \setR \setZ` = `{\mathord{\mathbb X}}\xspace`; `amsfonts`/`amssymb` not loaded by the class (cls:27 commented out); `\xspace` is a macro-body helper (lib v4 rejected `sp.xspace`) |
| author's preamble: references | mentis.dtx:301 | `xref.varioref` | `\usepackage{varioref}` |
| author's preamble: PDF metadata | mentis.dtx:302-306 | `meta.hyperref` | `pdftitle`, `pdfauthor`, `pdfsubject` |
| author's preamble: tables | mentis.dtx:307 | `tbl.tabularx` | `\usepackage{tabularx,booktabs}` |
| author's preamble: rules | mentis.dtx:307 | `tbl.booktabs` | same line |
| author's preamble: images | mentis.dtx:308 | `fig.graphicx` | `\usepackage{graphicx}` |
| manual driver (not counted): class | mentis.dtx:25 | `class.ltxdoc` | `\documentclass[a4paper]{ltxdoc}` |
| manual driver (not counted): doc tools | mentis.dtx:46-50, :76-78, :431, :1356 | `dtx.doc` | `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput`, `\GetFileInfo`, `\DoNotIndex`, `\StopEventually`, `\Finale`, `\DescribeMacro` |
| manual driver (not counted): fonts | mentis.dtx:30-32, :34-35, :28 | `font.mathptmx` | `mathptmx`; with `helvet` `scaled=.90` (`font.helvet`), `courier` (`font.mono`), `inputenc` latin1, `fontenc` T3,T1, `textcomp` (`font.fontenc-t1`) |
| manual driver (not counted): sans, mono | mentis.dtx:31-32 | `font.helvet` | `\usepackage[scaled=.90]{helvet}`; `courier` is `font.mono` |
| manual driver (not counted): language | mentis.dtx:37 | `lang.babel` | `[german,ngerman]` |
| manual driver (not counted): metadata | mentis.dtx:29, :38-44 | `meta.hyperref` | `\hypersetup{pdftitle,pdfauthor,pdfsubject,pdfkeywords}` |
| manual driver (not counted): line breaking | mentis.dtx:45 | `sp.lengths` | `\setlength{\emergencystretch}{25pt}` |
| manual driver (not counted): title, abstract | mentis.dtx:81-101 | `front.maketitle` | `\title{...\thanks{}}`, `\author`, `\maketitle`; `abstract` is `abs.kernel`, `\thanks` is `front.thanks` |
| manual driver (not counted): body | mentis.dtx:152-171, :289-313, :693-701 | `tbl.tabular` | `tabular` with `p{}` columns inside picinpar's `tabwindow` (considered: `picinpar`); `verbatim` is `code.verbatim`, `itemize` is `list.kernel` |

## Bespoke code
None counts as bespoke under the rubric: every definition below sits inside `mentis.cls`, which is published on CTAN (W1) and carried as `class.mentis`. The last column says what rebuilding from component ways alone would take, so the class dimension is not hidden. The sample preamble (mentis.dtx:288-313) defines nothing.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| whole class code | mentis.cls:23-416 | not bespoke (published) | one `\documentclass` line with options |
| text block per option | mentis.cls:57-59, :131-136 | yes | `page.geometry` with the two size sets |
| page style `mentis` | mentis.cls:138-158 | yes | `hf.fancyhdr` or `hf.scrlayer-scrpage` with the same head and foot fields, `\pagestyle{empty}` on title, part, chapter and index pages |
| roman numbering | mentis.cls:63-67 | yes | `num.counters` `\renewcommand\thechapter` and `\thesection` |
| contents entries `\l@chapter`..`\l@subsubsection` | mentis.cls:79-127 | yes, loosely | `toc.titletoc` or `toc.tocloft` indents and label widths (dimensions copied, the `\sectfont` chapter line aside) |
| `\@chapter` and `\@sect` (full title in contents, short title in head) | mentis.cls:200-259 | no, by components | kernel-internal patch; the effect (short title only in the head) is reachable with `\chapter[short]{long}` plus `\addcontentsline` by hand; would be BESPOKE/class if the class were zip-local |
| `\Pnum` with counters `Pn@msection`.. | mentis.cls:260-310 | no, by components | hand-rolled counters and nested `\ifthenelse` decide what is printed; needs the class; would be BESPOKE/class if zip-local |
| `\absatz`, `\Psatz`, `\randnummer` | mentis.cls:311-333 | yes | `sp.manual-space` + `sp.ragged` for `\absatz`; `list.kernel` + `sp.lengths` + `note.marginpar` for `\Psatz` |
| `quote` re-definition | mentis.cls:181-190 | yes | `quote.kernel` with `sp.lengths` and a relative size |
| footnote mark, protrusion table | mentis.cls:159-176 | yes | `sp.microtype` `\SetProtrusion` and `\microtypecontext`; `\deffootnote` is KOMA |
| `\footnoterule` | mentis.cls:177-180 | yes | `sp.rule` |
| jurabib set-up and hooks | mentis.cls:334-366 | yes | `bib.apacite` option list and `\renewcommand` of `jurabib` font hooks |
| `theindex` wrapper | mentis.cls:404-416 | yes | `idx.makeidx` + `cols.multicol` + `sp.ragged` |
| `tolerant` | mentis.cls:394-398 | yes | `sp.hyphenat` family (`\sloppy`) or a raw `\tolerance` group |
| `\textsubscript`, `\hochtief`, `\spitz`, `\strich`, `\stern` | mentis.cls:374-378, :382-392 | yes | `math.kernel` inline maths |
| `\setB`..`\setZ`, `\roem`, `\textbfsf`, `\fett`, blackletter shortcuts | mentis.cls:368-373, :379-381, :393, :399-403 | yes | `math.amssymb`, `mark.kernel`, `fig.graphicx`, `font.nfss` as in the map |

## Content-opaque
none (the zip has no figure or table artwork; the manual's `tabwindow` table at mentis.dtx:152-171 is documentation content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
