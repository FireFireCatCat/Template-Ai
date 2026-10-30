yes

# 0279-musuos: musuos (term-paper class, Uni Osnabrueck music department)

- Unverified: read from the source, not compiled.
- Source: Source/0279-musuos/ (origin: https://mirrors.ctan.org/macros/latex/contrib/musuos.zip; licence: LPPL 1.2 (manifest `lppl1.2`; musuos.dtx:6-14))
- Kind: assignment (seminar term paper, "Hausarbeit"; the manifest hint says thesis; the title page names seminar, lecturer, term and examiners, musuos.dtx:867-883)
- Lib: v3
- Engine: pdfLaTeX-compatible (the manual asks for pdfLaTeX with T1 or XeLaTeX, musuos.dtx:291-293; the class code uses no fontspec or Lua)
- Look carried by: class (the published CTAN class `musuos`, whose source is the `class` code of musuos.dtx:636-1299; the zip holds no generated `.cls`, musuos.ins:40 makes it)
- Class origin: ctan (read of ctan.org/pkg/musuos: class by Tobias Weh, path macros/latex/contrib/musuos, LPPL 1.2; the manifest URL is the CTAN mirror)
- Main file: none as a `.tex`; the only compilable document is the `.dtx` documentation driver, Source/0279-musuos/musuos.dtx:27-124 (`\documentclass[a4paper]{ltxdoc}` at 28, `\begin{document}` at 121); the only usage example of the class is the minimal document at musuos.dtx:315-335 (other samples: none)
- Read: main yes (musuos.dtx lines 1-1299 in full, README, musuos.ins and musuos-doc.ist in full; musuos.pdf is the compiled manual, a build product, not read), zip-local classes and styles all (the class source is the `.dtx` code; no `.cls`/`.sty` file is present)

## Verdict
yes. The template is the published CTAN class `musuos` (a KOMA `scrartcl` layer), so it is one class way, `class.musuos`, with documented options and string commands. For completeness its code was also decomposed: every piece reduces to lib ways (geometry, kpfonts and tgheros, titletoc, csquotes, verse, float, scrextend `addmargin`, a hand-laid titlepage). The manual driver is `class.ltxdoc` plus `dtx.doc`. One package has no home in the lib and is proposed (`fn.footmisc`). No TikZ or other artwork, no tool outside TeX beyond `makeindex` (a lib way, `idx.makeidx`). Judgement call to state: the three `\def`s that rewrite doc's index-entry text in the driver preamble (musuos.dtx:84-99) are rated reducible (strings for `\index`); a stricter reader who calls them irreducible would turn the driver, not the class, into a `BESPOKE/preamble` blocker.

## Blockers
none

## Class setting
- Class: `class.musuos` options: `blockquote=withqmarks|withoutqmarks` (musuos.dtx:649, 699-702), `qmarks=german|gfrench|english|french` (650, 1066-1077), `poorlayout` (655), `manyfnotes` (660), `twocolfnotes` (662), `nofnoterule` (664), `dontcenterfloats` (670); every other option goes to `scrartcl` (676); defaults passed on: `fontsize=12pt,titlepage=true` (681). Base: `class.scrartcl` (`\LoadClass{scrartcl}`, 691).
- Class-native vocabulary used: title data `\street` `\city` `\email` `\phone` `\lecturer` `\seminar` `\term` `\uni` `\study` `\sterm` `\examinerI{label}{name}` `\examinerII{label}{name}` (804-830; `\examiner` obsolete, 837-841), `\makeshorttitle` (907); `\blockmargin` length (1104); environments `quote[source]` (1106), `block` (1139), `verse[first line number]` (1222), float `music` (1253) with `\listofmusic` (1264); `\linenumbermodulo{n}` (1173); inline `\elp` `\sic` `\miss{text}` (1128-1130); KOMA font elements `quotetext` (1103), `verse` (1198), `linenumbers` (1165).
- Base-class (`scrartcl`) vocabulary the code uses: `\subject` `\subtitle` (873-877), `\minisec` (404), `\KOMAoptions` (752, 986), `\setkomafont` `\newkomafont` `\usekomafont` (1014, 1103, 1110), `\deffootnote` (998-1002), `addmargin` (1109), `\appendix` (407). `scrartcl`'s own source was not read (published class loaded unchanged).
- Driver class: `class.ltxdoc` option `a4paper` (28); vocabulary `\DocInput` `\MakeShortVerb` `\CheckSum` `\CharacterTable` `\GetFileInfo` `\DoNotIndex` `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges` `\IndexPrologue` `\GlossaryPrologue` `\changes` `\StopEventually` `\PrintChanges` `\PrintIndex` `\Finale` and the `macro`, `environment`, `macrocode` environments.

## Component map
Paths are musuos.dtx unless named. The class rows (C) show what `class.musuos` sets, in lib ways; the driver rows (D) are the manual's own preamble and body.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| (C) class | 22-25, 691 | `class.musuos` | options above; sits on `class.scrartcl` |
| (C) base class | 676-691 | `class.scrartcl` | `\PassOptionsToClass{fontsize=12pt,titlepage=true}{scrartcl}` |
| (D) driver class | 28 | `class.ltxdoc` | `a4paper` |
| (C) paper, size | 681, 752 | `page.class-options` | `fontsize=12pt`; default layout `\KOMAoptions{fontsize=11.5pt}`; `titlepage=true` |
| (D) paper | 28 | `page.class-options` | `a4paper` |
| (C) geometry, default | 717, 741 | `page.geometry` | left=3.5cm, right=4.75cm, top=3.25cm, bottom=5.5cm |
| (C) geometry, `poorlayout` | 719 | `page.geometry` | left=2cm, right=3cm, top=3cm, bottom=3cm |
| (C) geometry, title page | 861, 897 | `page.geometry` | `\newgeometry{left=4cm,right=4cm,top=4cm,bottom=4cm}` then `\restoregeometry` |
| (C) text face, default | 746 | `font.serif-pkg` | package `kpfonts` (a Palatino-like family no other `font.*` line names) |
| (C) sans face, default | 747 | `font.helvet` | package `tgheros`, scale=0.9 (used for headings and the title page, `\sffamily` 875) |
| (C) faces, `poorlayout` | 723-724 | `font.mathptmx`, `font.helvet` | `txfonts`; `helvet` scaled=0.9 |
| (C) line spacing, `poorlayout` | 728-729, 865, 908, 921, 977-978, 1108, 1115 | `sp.setspace` | `\setstretch{1.45}`; `\singlespacing` on title and toc; `\setstretch{1.1}` in quote and block |
| (C) tolerance | 759-760 | `sp.hyphenat` | `\tolerance 1414`, `\hbadness 1414` (the `\sloppy` family of line-break tolerance parameters; nearest line) |
| (C) fuzz, stretch | 761-762, 765-766 | `sp.lengths` | `\emergencystretch 1.5em`, `\hfuzz 0.3pt`, `\vfuzz\hfuzz` (reads as `\vfuzz` = `\hfuzz`) |
| (C) penalties | 763-764 | `sp.penalties` | `\widowpenalty=10000`, `\clubpenalty=5000` |
| (C) page flow | 767 | `pg.flush` | `\raggedbottom` |
| (C) title page layout | 860-899 | `front.titlepage-env` | `titlepage` env: `\centering`, `\vspace{4.5cm}`/`0.5cm`/`3cm`, `\sffamily\Huge\textbf{title}`, `ll` tabular of examiners, `\vspace{\fill}`, `\raggedright`, `\hfill` address lines |
| (C) title page data | 867-877, 887-891 | `front.koma-title` | `\@uni` bold, `\@subject` italic, `\@title`, `\@subtitle`, `\@author`, `\@date` (KOMA fields) |
| (C) title page extra fields | 804-830 | `front.class-native` | `\street \city \email \phone \lecturer \seminar \term \uni \study \sterm \examinerI \examinerII` |
| (C) short title | 907-924, 933-935 | `front.class-native` | `\makeshorttitle`; `\let\maketitle\makeshorttitle` when `titlepage` is off |
| (C) first paragraph after title | 897-899, 922-923 | `sp.lengths` | indent suppressed with `\@afterindentfalse` (kernel internals; `\noindent` equivalent) |
| (C) contents entries | 946-966 | `toc.titletoc` | `\titlecontents{section}[0mm]`, `{subsection}[7mm]`, `\titlecontents*{subsubsection}[14mm]` run-in with `[~$\cdot$~]` |
| (C) contents depth | 971 | `num.secnumdepth` | `tocdepth=3` |
| (C) lists in contents | 986 | `toc.koma` | `\KOMAoptions{listof=totoc}` |
| (C) headings | 403-408 (doc), no override in code | `head.class-native` | `scrartcl` default disposition, sans via tgheros; no `\titleformat` in the class (`scrartcl` source not read) |
| (C) appendix | 407 | `num.appendix` | `\appendix`, top level lettered |
| (C) footnote mark layout | 997-1003 | `class.scrartcl` | KOMA `\deffootnote[1.5em]{1.5em}{1em}{\makebox[1.5em][l]{\thefootnotemark}}`; `manyfnotes` 1.75em (no `fn.*` line for `\deffootnote`) |
| (C) two-column footnotes | 1011-1013 | `fn.footmisc` | `\usepackage{dblfnote}`, `\setlength{\DFNcolumnsep}{2em}` |
| (C) footnote font | 1014 | `head.koma-fonts` | `\setkomafont{footnote}{\scriptsize}` (same command type as `\setkomafont{section}`) |
| (C) footnote rule | 1015, 1025 | `fn.kernel`, `sp.rule` | `\footnoterule` = `\rule{85mm}{.4pt}` + `\vspace{1mm}`; with `nofnoterule` `\rule{0mm}{.4pt}` |
| (C) list labels | 1036-1043 | `list.kernel`, `sp.rule` | itemize bullet `\rule[0.35ex]{0.5ex}{0.5ex}` at four levels; enumerate `\theenumi)` at four levels |
| (C) block quote | 1103-1116 | `quote.kernel` | `quote` redefined: `\vspace{0.5\baselineskip}`, `addmargin{\blockmargin}` (`list.scrextend`), font element `quotetext`=`\footnotesize` (`head.koma-fonts`), `\enquote{..}` (`lang.csquotes`) unless `blockquote=withoutqmarks`, source `[#1]` after the text |
| (C) block env | 1139-1148 | `class.musuos` | `block`: as `quote` without marks or source (class-native) |
| (C) editorial marks | 1127-1130 | `class.musuos` | `\elp` = `[\kern0.5pt\dots\kern-1pt]`, `\sic` = `[sic]`, `\miss{t}` = `[t]` (class-native inline marks) |
| (C) quotation marks | 1052-1086 | `lang.csquotes` | loaded at end of preamble; `style=german,german=quotes` (default) / `german=guillemets` / `style=english,english=american` / `style=french,french=guillemets` |
| (C) verse | 1157-1166, 1172-1173, 1198, 1220-1237 | `quote.verse-pkg` | `\verselinenumbersleft`, `\vrightskip=-1.5\leftmargin`, `\verselinenumfont`, `\poemlines{modulo=2}`, `\setverselinenums{n}{n}`; font elements `verse`=`\itshape`, `linenumbers`=`\normalfont\tiny` |
| (C) music float | 1252-1254, 1264-1266 | `fig.float` | `\newfloat{music}{htpb}{lom}`, `\floatname{music}{Notenbeispiel}`, `\listof{music}{Notenbeispiele}` |
| (C) music sub-captions | 1255-1259 | `fig.subcaption` | `\DeclareCaptionSubType{music}` when `subcaption` is loaded |
| (C) float centering | 1273-1293 | `sp.ragged` | `\centering` inside `music`, `table`, `figure` (default placement `htpb`, `fig.placement`); off with `dontcenterfloats`; `figure` is `fig.graphicx`, `table` is `tbl.tabular` |
| (C) bibliography | 543-551, 987 | `bib.biblatex-biber` | `biblatex` + style `musuos` (separate CTAN package, not in the zip) with `bibliography=totoc`; BibTeX backend also allowed (545) |
| (D) manual: scores | 464-500 | `pg.include-pdf` | `\includepdf[pages,pagecommand,frame,scale=0.7]`; `\captionof{music}` (`cap.caption`) in a `minipage` (`box.minipage`); `\thispagestyle{empty}` (`hf.pagestyle-kernel`) |
| (D) encoding | 30-31 | `font.fontenc-t1` | `fontenc[T1]`, `inputenc[latin1]` |
| (D) language | 32 | `lang.babel` | `ngerman` |
| (D) font | 34 | `font.lmodern` | `lmodern` |
| (D) ragged text | 35, 60, 625-627 | `sp.ragged` | `ragged2e`: `\RaggedRight`, `\raggedleft` |
| (D) footnotes | 36, 38 | `fn.footmisc` | `footmisc[hang]`, `\footnotemargin=1em` |
| (D) two-column footnotes | 37 | `fn.footmisc` | `\usepackage{dblfnote}` |
| (D) KOMA base package | 39 | `font.icons` | `scrbase`, loaded only for the `\KOMAScript` logo (73, 77, 219); nearest line (logo by name; the package is the parameter) |
| (D) urls | 40 | `meta.url` | `url[hyphens]`; `\url`, `\href` in the title (203-205) |
| (D) colours | 41-43 | `color.xcolor` | `darkred` HTML 770011, `darkblue` HTML 003b8b |
| (D) hyperlinks | 44-48 | `meta.hyperref` | `\PassOptionsToPackage{linkcolor=darkblue,urlcolor=darkred}{hyperref}`; `hypdoc` (doc's hyperref glue, load only) |
| (D) doc driver | 81, 104-106, 108-119, 122, 127-199, 252, 625-627, 1298 | `dtx.doc` | `\MakeShortVerb{\|}`, `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\generalname`=Global, `\IndexPrologue`, `\GlossaryPrologue`, `\DocInput`, `\CheckSum{611}`, `\GetFileInfo`, `\DoNotIndex`, `\changes`, `\PrintChanges`, `\StopEventually{\RaggedRight\PrintIndex}`, `\Finale` |
| (D) index entries | 61-62, 66-67, 84-99; musuos-doc.ist:7-28 | `idx.makeidx` | `\index{..=..|usage}` entries with German labels; makeindex style `actual '='`, `quote '!'`, `level '>'`, `symhead_positive "Symbole"`; README:43-44 runs `makeindex` |
| (D) margin tags | 59-68 | `note.marginpar` | `\marginpar{\raggedleft\texttt{#1} \footnotesize(Opt.)}` |
| (D) title, abstract, toc | 201-248, 102 | `front.maketitle`, `abs.kernel`, `toc.kernel` | `\title \author \date \maketitle`; `abstract` with an `itemize` of `\item[v1.1]` (`list.kernel`); `\clearpage` (`pg.break`); `\setcounter{tocdepth}{1}` (`num.secnumdepth`) |
| (D) sections, footnotes, verbatim | 251-253, 515-517, 470-495 | `head.kernel`, `fn.kernel`, `code.verbatim` | `\section` `\subsection`; `\footnote`; `verbatim`, `\verb*`, `\|..\|` short verb |

## Bespoke code
Not zip-local: `class.musuos` is published on CTAN, so its macros are the way's internals. They are listed to show that none would block even if read as zip-local.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| doc index-entry rewrites `\SpecialMainEnvIndex`, `\SpecialUsageIndex`, `\SpecialEnvIndex` | musuos.dtx:84-99 (driver preamble) | yes, judgement | strings for `\index` (`idx.makeidx`) with `\ttfamily` (`mark.kernel`) and a German "(Umgebung)" label; hooks of `dtx.doc`, no layout logic |
| doc aliases `\musuos \pkg \env \fnt \opt \DM \DE \KOMAfont \KOMAfonts` | 54-58, 69-79 | yes | `\newcommand` aliases of `\texttt`, `\DescribeMacro`, `\DescribeEnv`, `\footnote` (`mark.kernel`, `dtx.doc`, `fn.kernel`) |
| `\DO`, `\DF` | 59-68 | yes | `\marginpar` + `\index` (`note.marginpar`, `idx.makeidx`, `sp.ragged`, `font.size-commands`) |
| `\renewcommand{\usage}`, `\renewcommand{\main}`, `\def\generalname` | 51-52, 108 | yes | doc's documented hooks set to `\textbf{\hyperpage{#1}}`, `\textit{#1}`, a string (`dtx.doc`, `mark.kernel`) |
| `musuos.ins` (DocStrip install file) | musuos.ins:16-40 | yes | no typesetting; it only extracts `musuos.cls`, which is the published `class.musuos` |
| `musuos-doc.ist` | musuos-doc.ist:7-28 | yes | makeindex style parameters (`idx.makeidx`); line 11 string loads `\makeatletter\scan@allowedfalse` into the index file |
| class `\maketitle` redefinition, `\if@letesep` | 859-900 | yes | `front.titlepage-env` + `page.geometry` + `sp.ragged` + `sp.manual-space` + `tbl.tabular`; the " -- " separator is printed only when lecturer and term are both set (decided at emit time) |
| `\makeshorttitle` | 907-924 | yes | `sp.manual-space`, `sp.ragged`, `font.size-commands` |
| `quote` / `block` via `\NewEnviron` | 1106-1116, 1139-1148 | yes | `list.scrextend` `addmargin` + KOMA font element + `lang.csquotes` `\enquote` |
| `\if@integer` (lccode/`\romannumeral` test) and `verse` wrapper | 1204-1212, 1222-1237 | yes | guards the optional argument and prints a warning; an emitter writes `\poemlines{n}` and `\setverselinenums{s}{s}` (`quote.verse-pkg`) directly |
| float-centering wrappers | 1273-1293 | yes | `\centering` as the first line of each float (`sp.ragged`) |
| `\AtEndPreamble` csquotes loader | 1052-1086 | yes | `lang.csquotes` loaded once with the chosen `\ExecuteQuoteOptions` |
| `\tableofcontents` patch with `\preto`/`\appto` | 976-979 | yes | `\singlespacing` before and `\setstretch{1.45}` after the contents (`sp.setspace`) |
| option machinery (`kvoptions`, `etoolbox` switches) | 636-686 | yes | class options are the way's parameters (W2) |

## Content-opaque
- Score pages in the `\includepdf` example (`mozart-sinf41.pdf`, musuos.dtx:478-492) are the author's own PDFs, not shipped; content.
- Music examples in `music` floats (the class gives only the float, 1252-1254); content.
- musuos.pdf (compiled manual) is a build product, not template.

## Lib changes
- New ways proposed: `fn.footmisc` `dblfnote` (CTAN, in the yafoot bundle, Hiroshi Nakashima, LPPL; checked with one read of ctan.org/pkg/dblfnote), pdfLaTeX. It sets the footnotes of a single-column document in two columns (`\usepackage{dblfnote}`, length `\DFNcolumnsep`). W1: published on CTAN. W2: its behaviour is a length and the load itself. W3: any single-column document. W4: one preamble line plus one length. Considered folding it into `fn.footmisc` ("a footnote-layout package is the parameter"); that is the consolidator's call.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes for the consolidator: `class.musuos` vocabulary is recorded under "Class setting". Doc inconsistencies in the source, not blockers: the manual names the `blockquote` values `marks`/`nomarks` (526) while the code uses `withqmarks`/`withoutqmarks` (699-702); README:44 runs `makeindex -s gind.ist` while musuos.dtx:273 uses `musuos-doc.ist`.
