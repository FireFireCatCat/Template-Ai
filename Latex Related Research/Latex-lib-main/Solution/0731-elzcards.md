no

# 0731-elzcards: elzcards (business, index and flash cards on imposed sheets, with an optional back side)

- Unverified: read from the source, not compiled.
- Source: Source/0731-elzcards/ (origin: https://mirrors.ctan.org/macros/latex/contrib/elzcards.zip; licence: lppl1.3 per the manifest, LPPL 1.3c in the header at elzcards.dtx:4-14)
- Kind: misc (a card-sheet package with a bilingual manual; manifest category card-gen)
- Lib: v5
- Engine: pdfLaTeX-compatible (the manual's driver loads `fontspec` only under XeTeX or LuaTeX, elzcards.dtx:116-118, and T1 plus utf8 otherwise, elzcards.dtx:120-121; the dtx tells the reader to run `pdflatex`, elzcards.dtx:80-81; the manifest hint says xelualatex)
- Look carried by: mixed (the cards and crop marks come from the published package `elzcards` loaded in the example preamble, elzcards.dtx:975; the manual's look comes from the published class `ltxdoc` plus a driver preamble with patches, elzcards.dtx:100-190)
- Class origin: tex-distribution-unbundled (`article` for the example, `ltxdoc` for the driver; neither is in the zip; the package source `elzcards.sty` is not in the zip either, only its `.dtx`, and the package is on CTAN)
- Main file: Source/0731-elzcards/elzcards.dtx (no standalone `.tex`; the dtx embeds the documentation `driver` at elzcards.dtx:99-192, the all-in-one example `ejemplo` at elzcards.dtx:973-1072 and the `package` code at elzcards.dtx:1079-1765; other samples: none; `elzcards.pdf` and `elzcards-examples.pdf` are compiled outputs and were not read)
- Read: main yes (the whole dtx, lines 1-1767, and README), zip-local classes and styles none present as files (the only style code is the `package` part of the dtx, read in full)

## Verdict
No, and only because of the documentation driver. The package `elzcards` is published on CTAN and its example (`article` + `elzcards` + `geometry`, one `\mycenter` alias) is covered by `ticket.sheet` and kernel ways, so the package and example alone would be `yes`. The driver that typesets `elzcards.pdf` is the one shipped document with its own preamble, and it redefines `\changes@` and `\@wrglossary` (elzcards.dtx:154-173). That is hand-written token logic on the change-history writer, which no lib way expresses. The blocker is tagged `preamble` so the answer can be re-read with the driver out of scope.

## Blockers
- `BESPOKE/preamble` driver redefines `\changes@` (elzcards.dtx:154-168): builds the change-history key as bold "version --- date" and, through a test on `\saved@macroname`, rebuilds the macro-name part from `\saved@indexname`, `\actualchar`, `\verbatimchar` and `\levelchar`; not a composition of lib ways.
- `BESPOKE/preamble` driver redefines `\@wrglossary` (elzcards.dtx:170-173): writes `\glossaryentry{#1}{1}` with the literal `1` in the second field, so the change history carries no real page number; a patch of the glossary writer, not a parameter of `dtx.doc`.

## Class setting
- Class: `class.article` (example, no options, elzcards.dtx:974) and `class.ltxdoc` (documentation driver, no options, elzcards.dtx:100)
- Class-native vocabulary used: `article`: none (the example body uses only package commands). `ltxdoc` (with `doc`): `\DocInput` (190), `\CheckSum` (195), `\CharacterTable` (197), `\changes` (213-234), `\GetFileInfo` (236), `\DoNotIndex` (238), `\DescribeMacro` `\marg` `\oarg` (503), `\cs` (481), `macrocode` (972), `\StopEventually` and `\PrintIndex` `\PrintChanges` (970), `\Finale` (1767), `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges` (182-184), short verb `|..|` (454).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class, example | elzcards.dtx:974 | `class.article` | no options |
| class, manual | elzcards.dtx:100 | `class.ltxdoc` | no options |
| card sheets: load | elzcards.dtx:975, 1081 | `ticket.sheet` | `\usepackage{elzcards}`, no options (elzcards.dtx:448-449); `elzcards` is the package named under `ticket.sheet` |
| business cards | elzcards.dtx:985-1023 | `ticket.sheet` | `\BusinessCard{front}[back]`; `\MakeBC` and `\MakeBC*`; keys `segments` `hsize=2in` `vsize=3.5in` `line thickness=1pt` `segment length=0.5cm` `dots` `dot size=4pt` `hgap=1.666cm` `vgap=0.666cm` `crop color=green` `lines` `no marks` `autogap inner` `autogap total`; `\BCdim{74mm}{52mm}` (1015) |
| index and flash cards | elzcards.dtx:1026-1070 | `ticket.sheet` | `\IndexCard{front}[back]`, `\MakeIC*`, `\MakeFC*`; `\CardGap{0.5cm}{0.5cm}` `\SegmentLength{10pt}` `\LineThickness{1pt}` `\CropColor{orange}` `\CropSegments` `\ICdim{4in}{2in}` `\DotSize{1mm}` `\CropDots`; keys `rows=3` `columns=3` `order=1 5 4 8 6 3 7 2` `transverse` (1049, 1063, 1070); counters `\CurrentIC` `\TotalIC` |
| key list and defaults of the package | elzcards.dtx:1190-1223, 1749-1761 | `ticket.sheet` | keyval keys of family `ELZc`; defaults 3.5in x 2in, 5in x 3in, gap 0, segment 1mm, line 0.1mm, `red!90!black`, crosses |
| crop marks and page grid | elzcards.dtx:1395-1439, 1648-1686 | `ticket.sheet` | `picture` `\put` `\line` `\circle*` inside the package, chosen by the keys crosses, segments, dots, lines, no marks (1203-1207); part of the published package, not artwork the zip adds, so no `ART` |
| crop colour | elzcards.dtx:1208, 1249, 1758; xcolor at 1087 | `color.xcolor` | `crop color=red!90!black` default; names `green` `orange`; xcolor is loaded by the package at `\begin{document}` if absent |
| page geometry, example | elzcards.dtx:976 | `page.geometry` | landscape, letterpaper, vmargin={0mm,0mm}, hmargin={0mm,0mm}; the grid is computed from `\textwidth` and `\textheight` (432, 1447-1448) |
| page geometry, manual | elzcards.dtx:101 | `page.geometry` | letterpaper, vmargin={2.5cm,2cm}, hmargin={3cm,2cm} |
| geometry switch for the sample card page | elzcards.dtx:954-955, 963 | `page.geometry` | `\savegeometry{tempgeo}`, `\newgeometry{vmargin={0mm,0mm},hmargin={0mm,0mm}}`, `\loadgeometry{tempgeo}` |
| card face alias `\mycenter` | elzcards.dtx:978-981, 956-959 | `sp.manual-space`, `sp.ragged`, `font.size-commands`, `math.kernel` | `\vspace*{2pt}` `\hspace*{2pt}` `\vfill` `\hfill`; `center`; `\LARGE`; `$\nwarrow$` `$\searrow$` |
| colours in the manual | elzcards.dtx:102, 131-132, 452 | `color.xcolor` | option `dvipsnames`; `\color{Red}` `\color{Green}` `\color{RoyalBlue}` |
| languages | elzcards.dtx:103, 126-127, 421 | `lang.babel` | `spanish,english`; `\selectlanguage` |
| bilingual parallel columns | elzcards.dtx:104, 126-129, 134 | `cols.paracol` | `paracol` with 2 columns; `\switchcolumn[1]`, `\switchcolumn[0]*`; `\footnotelayout{m}` |
| manual font, XeTeX or LuaTeX branch | elzcards.dtx:116-118 | `font.fontspec` | `\setmainfont[Ligatures=TeX,Mapping=TeX]{Linux Libertine O}` |
| manual font, pdfTeX branch | elzcards.dtx:119-122 | `font.fontenc-t1` | `[T1]{fontenc}`, `[utf8]{inputenc}` |
| overfull rule | elzcards.dtx:124 | `sp.lengths` | `\overfullrule2cm` (a raw TeX length parameter; a draft aid) |
| margin-note threshold | elzcards.dtx:125 | `dtx.doc` | `\marginparthreshold{0}`; defined outside the zip, source not read, so the filing is a best guess |
| index and change-history machinery | elzcards.dtx:182-184, 190, 970 | `dtx.doc` | `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges`, `\DocInput{\jobname.dtx}`, `\StopEventually{\clearpage\PrintIndex\PrintChanges}`; the lists are built by `makeindex` with `gind.ist` and `gglo.ist` (65-66, 82-85), the same tool type as `idx.makeidx`, so not `EXTERNAL` |
| dtx documentation markup | elzcards.dtx:195-197, 213-238, 503, 972, 1767 | `dtx.doc` | `\CheckSum{1574}`, `\CharacterTable`, 22 `\changes`, `\GetFileInfo`, `\DoNotIndex`, `\DescribeMacro`, `macrocode`, `\Finale` |
| index heading | elzcards.dtx:149-151, 180 | `head.kernel`, `hf.pagestyle-kernel` | `\section*{\glosname}` and `\markboth{\glosname}{\glosname}` |
| change-history heading string | elzcards.dtx:175, 179 | `dtx.doc` | `\patchcmd{\glossary@prologue}{Change History}{\changesname}{}{}`; the effect is a heading string |
| title block | elzcards.dtx:416-423 | `front.maketitle`, `front.thanks`, `num.counters`, `lang.babel` | `\title` with two `\thanks`, `\stepcounter{footnote}`, `\author`, `\date` with `\today` under two `\selectlanguage` |
| contents | elzcards.dtx:189, 424 | `toc.kernel`, `sp.lengths` | `\renewcommand{\contentsname}{Contents / Tabla de contenido}`; `{\parskip2.7pt\tableofcontents}` |
| paragraph spacing | elzcards.dtx:186 | `sp.lengths` | `\setlength{\parskip}{5pt}` |
| headings | elzcards.dtx:427, 446, 497, 573 | `head.kernel` | `\section`, `\subsection`, `\subsubsection` in the default `ltxdoc` look; no renewed heading format |
| lists | elzcards.dtx:459-463, 480-483 | `list.paralist`, `list.kernel` | `enumerate[\bfseries 1.]` (label template through `paralist`); `itemize` |
| footnotes | elzcards.dtx:429, 481 | `fn.kernel` | `\footnote` |
| verbatim code | elzcards.dtx:941-952 | `code.verbatim` | `verbatim` environment and the short verb `|..|` |
| boxes and centred blocks | elzcards.dtx:451-455, 459 | `box.minipage`, `sp.ragged` | `\parbox{.4\textwidth}`, `center` |
| marks and page breaks | elzcards.dtx:131, 448, 459, 506, 445, 962, 970 | `mark.kernel`, `pg.break` | `\slshape` `\bfseries` `\itshape` `\ttfamily`; `\newpage`, `\clearpage` |
| loaded, no use found | elzcards.dtx:104 | `tbl.tabular`, `pg.landscape` | `array` and `pdflscape`; a search finds no `tabular` and no `landscape` environment (only the geometry option at 476 and 976) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\mycenter` | elzcards.dtx:978-981, 956-959 | yes | inline expansion into each card face: `sp.manual-space` + `center` + `\LARGE` + `math.kernel` arrows |
| `\eng` `\esp` `\iniciotrad` `\fintrad` | elzcards.dtx:126-129 | yes | alias expansion; the star form opens or closes `paracol`: `cols.paracol` + `lang.babel` |
| `\Default` `\Keyval` | elzcards.dtx:131-132 | yes | `\noindent\slshape\color{Red or Green}` plus a string chosen by the star |
| `\newif\ifmotorunicode` and the font branch | elzcards.dtx:108-122 | yes | the emitter knows its engine and prints one branch: `font.fontspec` or `font.fontenc-t1` |
| `\index@prologue` | elzcards.dtx:149-151 | yes | `\section*` plus `\markboth` with one string: `head.kernel` + `hf.pagestyle-kernel` |
| `\patchcmd{\glossary@prologue}...` | elzcards.dtx:175 | yes | the whole effect is the heading string `\changesname` |
| `\patchcmd{\changes@}{:}{}{}{}` | elzcards.dtx:176 | yes (no-op) | it patches the new `\changes@`, whose body (154-168) holds no colon; dropped |
| `\def\changesname`, `\def\glosname` | elzcards.dtx:179-180 | yes | two strings |
| `\changes@` redefinition | elzcards.dtx:154-168 | no | token-level logic on private `doc` macros with a conditional; `BESPOKE/preamble` |
| `\@wrglossary` redefinition | elzcards.dtx:170-173 | no | rewrites the glossary writer to print a constant page field; `BESPOKE/preamble` |
| elzcards internals: counters, loops, expl3 `\seq_set_split`, `\write\@auxout` of `\@twosidetrue` | elzcards.dtx:1127-1159, 1179-1188, 1292, 1304, 1763 | not bespoke | the package is published on CTAN (origin above); it is the way `ticket.sheet`, not zip-local macro logic |

## Content-opaque
none (the card faces at elzcards.dtx:985-1070 are plain text through `\mycenter`, so they are content, not artwork)

## Lib changes
- New ways proposed: none (considered: `elzcards` as a way of its own; v5 already folded it into `ticket.sheet`, and the manual's commands fall under `dtx.doc`)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
