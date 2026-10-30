yes

# 0919-rpg-module: rpg-module (old-school D&D adventure module class, CTAN)

- Unverified: read from the source, not compiled.
- Source: Source/0919-rpg-module/ (origin: https://mirrors.ctan.org/macros/latex/contrib/rpg-module.zip; licence: lppl1.3)
- Kind: misc (RPG adventure module / monster manual; two-column game supplement)
- Lib: v6
- Engine: pdfLaTeX-compatible (pdfTeX primitive `\pdfstrcmp` basic-stats.sty:66; no fontspec; Souvenir is an optional installed font, Bookman is the fallback)
- Look carried by: class (the whole look is in rpg-module.cls plus its stat-block style basic-stats.sty; the main sample only chooses options and calls class vocabulary)
- Class origin: ctan (CTAN package "rpg-module", Michael C. Davis, LPPL 1.3, v1.0 2016-04-25, confirmed by one read of ctan.org/pkg/rpg-module; the page does not list it in TeX Live, it lists MiKTeX; the zip is the CTAN distribution itself, so `basic-stats.sty` and `basic-stats.def` ship inside the same published package)
- Main file: examples/monster_manual.tex (other samples: doc/rpg-module.tex, examples/basic.tex, examples/b1.tex, examples/b3.tex, examples/x2.tex)
- Read: main yes, zip-local classes and styles all (rpg-module.cls, basic-stats.sty, basic-stats.def all read in full; the .def is a 321-row data file); other samples read: doc/rpg-module.tex, basic.tex, x2.tex in full, b1.tex lines 1-120, b3.tex lines 1-70

## Verdict
yes. The zip is the CTAN `rpg-module` package, so `class.rpg-module` is a published class (W1) and everything in `rpg-module.cls`, `basic-stats.sty` and `basic-stats.def` is the internals of that one class way, not zip-local code. The main sample defines no macro, environment or counter of its own (no `\newcommand`, `\def`, `\newenvironment` in examples/monster_manual.tex), has no drawing and needs no tool outside TeX. This is evidence about the class dimension, not about the component ways. Honest caveat for re-reading under another definition: the class internals include a stat-block engine (pgfkeys store, `\ifcase` over a counter, xstring plural rules, ascending-AC arithmetic, token-list table headers) that no lib way expresses; if the class were treated as zip-local those items would be `BESPOKE/class` and the answer would be `no` (listed in "Bespoke code", informational, not counted as blockers).

## Blockers
none

## Class setting
- Class: `class.rpg-module` options: `a4paper` (default, rpg-module.cls:108), `serif` (default is `sansserif`, rpg-module.cls:109); other options `letterpaper` `tightsqueeze` `basic` `advanced` `acdesc` `acasc` `acb1` `acsw` (rpg-module.cls:83-101). The class loads `article` with `twocolumn` (rpg-module.cls:169).
- Class-native vocabulary used by the main sample: `\title` + `\showtitle` (examples/monster_manual.tex:12,14), `\part` (:20), environments `newmonster` (:22), `newmonster2` (:49), `newmonster2*` (:50), `newmonster3` (:38), `newmonster3*` (:220,356), `\statblock[name]{key}{number}{hp}` (:25), `wanderingmonsters` + `\wanderitem[die]{key}{number}` (:767-1090), `ogl` environment (:1101), `\tableofcontents` (:1113); direct write of the class key store `\pgfkeys{/<key>/SingleName/.initial=...}` (:36,42).
- Further vocabulary seen in the other samples: `\subtitle` `\author` `\titlerunning` `\coverimage` `\abstract` `\copyrightblock` `\contactblock[cols]{}{}{}` `\maketitle` (doc/rpg-module.tex:92-136), `boxtext`, `\tableheader[col]{}`, column type `b`, `onecolumninline`, `onecolumnfloat`, `statblockfreestyle`, `ifbasicstats`, `monsterroster` + `\rosteritem`, `\stats[name]{}{}{}`, `\monster[plural]{key}{Name}{fields}`, `\changealignment`, `\modulecopyright`, `productidentity`, `opengamecontent`, hooks `\newmonsterfont` `\newmonsterbottomskip`, text macros `\x` `\minus` `\?` `\+` `\half` `\ArmourClass`.

## Component map
Sample level (examples/monster_manual.tex unless stated):

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | examples/monster_manual.tex:5 | `class.rpg-module` | a4paper, serif |
| paper size | examples/monster_manual.tex:5; rpg-module.cls:84,160-161 | `page.class-options` | a4paper (A4 also passes `twoside` to article, rpg-module.cls:161); letterpaper branch shifts offsets (rpg-module.cls:156-157) |
| title block | examples/monster_manual.tex:12,14 | `front.class-native` | `\title{Monster Manual}`, `\showtitle` (centred `\LARGE\textbf`, rpg-module.cls:390-393) |
| parts / headings | examples/monster_manual.tex:20,620,665,678,714,765,1098 | `head.class-native` | `\part{...}` only; look set by the class (see class internals) |
| stat-block entries | examples/monster_manual.tex:22-25,38-45,49-54 | `class.rpg-module` | `newmonster`, `newmonster2(*)`, `newmonster3(*)` with monster keys, `\statblock{key}{3}{4 each}`; text inside is `\lipsum[n]` or empty |
| monster-name override | examples/monster_manual.tex:36,42 | `class.rpg-module` | published `\pgfkeys` setting the class key `/vampire_bat/SingleName` (a data string; key store rpg-module.cls:335) |
| wandering-monster tables | examples/monster_manual.tex:767-1090 | `class.rpg-module` | `wanderingmonsters` env, `\wanderitem[die roll]{key}{number}` (:819 `[50]`, :1089 `{zargon}{1}`) |
| column switch | examples/monster_manual.tex:763,1092 | `cols.twocolumn-cmd` | `\onecolumn` before the tables, `\twocolumn` after |
| licence part | examples/monster_manual.tex:1098-1105 | `class.rpg-module` | `ogl` environment with one `\item` for the copyright notice (text rpg-module.cls:570-637) |
| flush | examples/monster_manual.tex:10 | `pg.flush` | `\raggedbottom` |
| filler text | examples/monster_manual.tex:7,23 | `draft.todo` | `lipsum`, `\lipsum[1]` |
| cross-references | examples/monster_manual.tex:18,766,1099 | `xref.kernel` | `\ref`, `\label{wandering_monsters}`, `\label{ogl}` |
| inline code | examples/monster_manual.tex:16 | `code.verbatim` | `\verb|basic-stats.sty|` |
| page break | examples/monster_manual.tex:1111 | `pg.break` | `\newpage` |
| contents | examples/monster_manual.tex:1113 | `toc.kernel` | `\tableofcontents` (class redefinition, rpg-module.cls:475-477) |

Other samples (same class, extra constructs):

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| cover front matter | doc/rpg-module.tex:92-136 | `front.class-native` | `\author` `\subtitle` `\coverimage` `\copyrightblock` `\contactblock[p{2.9cm} p{5.0cm} p{9.8cm}]` `\maketitle` |
| abstract | doc/rpg-module.tex:100 | `abs.class-native` | `\abstract{...}` (class command, rpg-module.cls:406) |
| running title | doc/rpg-module.tex:94 | `hf.class-native` | `\titlerunning{...}` (A4 only, rpg-module.cls:424-434) |
| boxed read-aloud text | doc/rpg-module.tex:259,485 | `class.rpg-module` | `boxtext` environment (internals: `box.mdframed`, rpg-module.cls:490-494) |
| one-column insert / float | doc/rpg-module.tex:597; examples/basic.tex:124 | `cols.twocolumn-cmd` | `\onecolumninline{...}` (`\twocolumn[{...}]`, rpg-module.cls:505-511), `onecolumnfloat[t]` (a `table*`, rpg-module.cls:514-517) |
| ruled table heading | doc/rpg-module.tex:280,298 | `class.rpg-module` | `\tableheader[b]{A & B}`, column type `b` (rpg-module.cls:523,546-559) |
| plain tables | doc/rpg-module.tex:181,279; examples/basic.tex:133 | `tbl.tabularx` | `tabularx{\linewidth}{lX}`; also `tbl.tabular` `tabular{cl}` |
| floats and captions | doc/rpg-module.tex:469-473,550-551 | `fig.graphicx` | `figure*[p]`, `figure[t]`, `\includegraphics[width=0.75\textwidth]`; `\caption*` via `cap.caption` |
| footnote | doc/rpg-module.tex:396 | `fn.kernel` | `\footnote` (symbols, rpg-module.cls:321) |
| link text | doc/rpg-module.tex:106,110 | `xref.hyperref` | `\href`, `\hyperref[ogl]{...}` |
| bullet list | doc/rpg-module.tex:382-383 | `list.kernel` | `itemize`, `\renewcommand{\labelitemi}{$\bullet$}`, `\setlength{\itemsep}{0pt}` |
| paragraph skip | examples/basic.tex:3; examples/b1.tex:3 | `sp.parskip-pkg` | `\usepackage{parskip}` |
| list options | examples/basic.tex:4,155; examples/x2.tex:101 | `list.enumitem` | `[leftmargin=5cm,rightmargin=5cm]`, `[labelindent=1em,leftmargin=1em]` |
| page style override | examples/basic.tex:12-19 | `hf.fancyhdr` | `\fancypagestyle{plain}`, `\fancyfoot[C]{B\thepage}`, rules 0pt |
| counters | examples/basic.tex:9-10; examples/b1.tex:14,59 | `pgnum.pagenumbering` | `\setcounter{page}{44}`; part and subsection starts via `num.counters` |
| text-block nudge | examples/b1.tex:9-10; examples/b3.tex:9-10 | `page.setlength` | `\addtolength{\topmargin}{-0.3cm}`, `\addtolength{\textheight}{0.7cm}` |
| table spacing | examples/basic.tex:132; doc/rpg-module.tex:296 | `sp.lengths` | `\addtolength{\tabcolsep}{...}` |
| 3/4 glyph | examples/basic.tex:32 | `font.nfss` | `\usefont{T1}{lmr}{m}{n}` with `\sfrac{3}{4}` (`math.nicefrac`) |

Class internals (what the published class sets; listed so the class can be re-read, all inside `class.rpg-module`):

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| base class | rpg-module.cls:169 | `class.article` | `\LoadClass[twocolumn]{article}`; `cols.twocolumn-option` |
| text block | rpg-module.cls:175-188 | `page.setlength` | oddsidemargin=evensidemargin=0.8cm, topmargin=2.6cm, textheight=25.4cm, textwidth=19.4cm, marginparwidth=0cm, footskip=0.7cm, columnsep=1.15cm |
| paper pass-through | rpg-module.cls:277 | `page.geometry` | `[pass,paperwidth=\paperwidth,paperheight=\paperheight]` |
| header/footer | rpg-module.cls:198-207 | `hf.fancyhdr` | A4 only: `\fancyhead[LO,RE]{\slshape\leftmark}`, `[RO,LE]{\slshape\rightmark}`, `\fancyfoot[C]{\thepage}`, rules 0pt |
| page numbers | rpg-module.cls:190 | `pgnum.pagenumbering` | arabic |
| float parameters | rpg-module.cls:215-232,285 | `fig.placement` | topfraction .9, bottomfraction .8, textfraction .07, floatpagefraction .7, topnumber 2, totalnumber 4; `dblfloatfix` |
| encoding, symbols | rpg-module.cls:238-242 | `font.fontenc-t1` | `[T1]`; `font.lmodern`; `math.nicefrac` (`xfrac`, `\half`) |
| serif face | rpg-module.cls:244-256 | `font.serif-pkg` | `souvenir` with `\bfdefault`=d if installed, else `bookman`; `font.family-default` `\familydefault`=`\rmdefault` |
| sans face | rpg-module.cls:258-259 | `font.helvet` | `avant`; `\familydefault`=`\sfdefault` |
| font sizes | rpg-module.cls:262-271 | `font.size-commands` | `\normalsize` 9pt/10.8pt, `\large` 10/12, `\Large` 11/13.2, `\LARGE` 13/15.6, `\small` 8/9.6 |
| links and colour | rpg-module.cls:290-295 | `meta.hyperref` | `linktocpage`, `colorlinks=true`, url/link/cite colour MidnightBlue; `color.xcolor` `[dvipsnames]` (:291) |
| headings | rpg-module.cls:444-462 | `head.titlesec` | `\part` block `\LARGE\bfseries\filcenter` label "PART \thepart:"; `\section` hang `\Large\bfseries\filright`, `\MakeUppercase`; `\section*` block centred; `\subsection`, `\subsubsection` hang `\normalfont\bfseries` with `\thesubsection.`; package options `explicit,newparttoc` (:278) |
| heading numbers | rpg-module.cls:439-442 | `num.counters` | `\thepart` arabic, `\thesection` empty, `\thesubsubsection` = number+letter |
| upper case | rpg-module.cls:404,425,446,476 | `mark.case` | `\MakeUppercase` |
| contents list | rpg-module.cls:279,475-484 | `toc.titletoc` | `\titlecontents{part}` and run-in `\titlecontents*{section..subsubsection}`; `num.secnumdepth` tocdepth 1 (:480) |
| footnote marks | rpg-module.cls:321 | `num.counters` | `\thefootnote`=`\fnsymbol{footnote}` |
| boxed text | rpg-module.cls:283,490-494 | `box.mdframed` | `framed` package, `\begin{framed}`; `\FrameSep5pt` under `tightsqueeze` (:313, `sp.lengths`) |
| tables | rpg-module.cls:280-281,314-316,523 | `tbl.tabular` | `array`, `\arraystretch` 1.2 (1 under `tightsqueeze`); `tbl.booktabs` `\cmidrule(l{\tabcolsep}r{\tabcolsep})` (:532) |
| stat-block tables | basic-stats.sty:46,300-313 | `tbl.tabularx` | `tabularx{\linewidth}{@{}l>{\raggedright\arraybackslash}Xl...}`; `\cmidrule` at basic-stats.sty:327 |
| captions | rpg-module.cls:282 | `cap.caption` | loaded without options (non-numbered captions) |
| images | rpg-module.cls:284,405 | `fig.graphicx` | `\includegraphics[width=\textwidth]` for `\coverimage` |
| title page | rpg-module.cls:364-388 | `front.titlepage-env` | `titlepage` with `\vspace*{\fill}`, centred `\Huge\textbf{\@title}` (`\renewcommand\maketitle`) |
| quote, copyright | rpg-module.cls:408-412 | `quote.kernel` | `quote` with `\centering` |
| licence list | rpg-module.cls:570-637 | `list.kernel` | `enumerate` of 15 clauses under `\subsection*` in `\footnotesize` |
| free-form stat block | rpg-module.cls:328 | `list.kernel` | `list` with `\leftmargin=1em`, `\rightmargin=1em` |

## Bespoke code
Defined by the main sample: none (examples/monster_manual.tex has no `\newcommand`, `\def`, `\newenvironment`, counter or conditional).

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand{\newmonsterfont}`, `\newmonsterbottomskip` | examples/basic.tex:6-7 | yes | values of two class hooks (`\bfseries`, `0ex`), `class.rpg-module` parameters |
| `\monster{...}` redefinitions | examples/basic.tex:23-28 | yes | re-calls of the class data command, data only |
| `\newcommand{\threequarters}` | examples/basic.tex:32 | yes | `font.nfss` + `math.nicefrac` |
| `\fancypagestyle{plain}` | examples/basic.tex:12-19 | yes | `hf.fancyhdr` |
| `\addtolength` margin nudges | examples/b1.tex:9-10 | yes | `page.setlength` |
| Class internals, informational (inside published `class.rpg-module`, not counted): stat-block store `\monster` + `\scan@stats` + `\setstatbasic` | rpg-module.cls:332-350; basic-stats.sty:121-177 | no (as lib ways) | pgfkeys store, `\ifcase\thecurrentstat`, xstring plurals; carried by the class way |
| Class internals: ascending-AC arithmetic `\ac@module`, `\sv@module`, `\ml@module`, `\al@module` | basic-stats.sty:64-111 | no (as lib ways) | counter arithmetic and string cuts driven by class options `acdesc` `acasc` `acb1` `acsw` |
| Class internals: `\tableheader`, `\tableul` | rpg-module.cls:529-559 | no (as lib ways) | token lists, `\StrSubstitute`, `\loop` building `\cmidrule` rows |
| Class internals: `\maketitle` with `\gdef` accumulators, `\showtitle`, `\contactblock` | rpg-module.cls:364-418 | partly | `front.titlepage-env` + `tbl.tabular`, but the once-only `\global\let` logic is class code |
| Class internals: `\@makefntext` override | rpg-module.cls:322 | no (exactly) | kernel-internal redefinition |
| Class internals: `newmonster*` environments with `\@afterheading` | basic-stats.sty:300-382 | no (as lib ways) | `tbl.tabularx` layout plus `\aftergroup` flow control |

## Content-opaque
- Monster database, 321 `\monster` rows of stat strings (basic-stats.def:53-373); Open Game License text (rpg-module.cls:570-637); cover, logo, map and art images (doc/rpg-module.tex:98,120,471,551). Assets missing from the zip: Souvenir font (commercial, Bookman fallback rpg-module.cls:245-255), examples/basic.tex:58 `troglodyte.png`, examples/b3.tex:59 `CaveLocust.png`, examples/x2.tex:22 `X2_CoverImage.png`, `TSR_Logo.png` (:46).
- No text addressed to an AI was found in the zip.

## Lib changes
- New ways proposed: none. Considered and rejected: a generic RPG stat-block way, because it is one package's engine and fails W3; it stays in the vocabulary of `class.rpg-module`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
