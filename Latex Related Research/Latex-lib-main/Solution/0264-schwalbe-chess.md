yes

# 0264-schwalbe-chess: schwalbe (class and style for the chess problem magazine "Die Schwalbe")

- Unverified: read from the source, not compiled.
- Source: Source/0264-schwalbe-chess/ (origin: https://mirrors.ctan.org/macros/latex/contrib/schwalbe-chess.zip; licence: LPPL 1.3c, README:31-36)
- Kind: journal
- Lib: v3
- Engine: pdfLaTeX-compatible (no fontspec, no Lua; `\AddToHook` needs a LaTeX kernel from late 2020, a fallback prints a warning, schwalbe.dtx:2238-2239; the chess fonts and `diagram.sty` are outside the zip and were not read)
- Look carried by: class (the zip is the CTAN package `schwalbe-chess`; `schwalbe.cls`, `schwalbe.sty`, `swruler.sty` are generated from `schwalbe.dtx` by `schwalbe.ins:3-7`; the only sample is the dtx documentation driver on `article`)
- Class origin: ctan
- Main file: schwalbe.dtx (documentation driver at lines 490-506; other samples: none, there is no `.tex` file)
- Read: main yes, zip-local classes and styles all (none is zip-local; the class, style and ruler code, schwalbe.dtx:513-2253, was read in full, with README and schwalbe.ins)

## Verdict
`yes`, on the rubric as written. The zip is the CTAN package `schwalbe-chess` (ctan.org/pkg/schwalbe-chess read: on CTAN, in TeX Live and MiKTeX, v2.13, LPPL 1.3c), so `schwalbe.cls` and `schwalbe.sty` pass W1 and form one class way, `class.schwalbe`. The one sample, the dtx driver, is an `article` document using `doc`, and every part of it has a lib way. This is class-dimension evidence (Look carried by: class), not evidence about the component ways. Read the other way, with the class source counted as zip-local, the answer would be `no`: the class is hand-written TeX (a `\write`-based contents file, author-list token parsing, an active `/`, box-measuring diagram headers). Those items are listed under Bespoke code, group B, with `BESPOKE/class`, so the result can be re-read without redoing the analysis.

## Blockers
none (under the W1 ruling for a published class). Not counted, listed for re-reading under another definition: `BESPOKE/class` contents machinery (schwalbe.dtx:1791-1794, 1880-1881, 1943-1971), `BESPOKE/class` author-list parsing (schwalbe.dtx:1066-1093, 1807-1876), `BESPOKE/class` active slash (schwalbe.dtx:1993-1999), `BESPOKE/class` issue arithmetic (schwalbe.dtx:851-864, 1004-1016), `BESPOKE/class` diagram header layout (schwalbe.dtx:2115-2190); one optional feature has a possible `EXTERNAL/class` step (schwalbe.dtx:1057, see Bespoke code).

## Class setting
- Class: `class.schwalbe` options: `ruler` only (schwalbe.dtx:517-520, shows a page ruler unless a file `__finalpdf__.tex` exists). It loads `class.article` with `11pt,a4paper` (schwalbe.dtx:522) and `\RequirePackage[12pt]{schwalbe}` (schwalbe.dtx:523), whose options `10pt` `11pt` `12pt` are passed to `diagram` (schwalbe.dtx:2035-2038). The dtx sample itself uses `class.article` with `a4paper` (schwalbe.dtx:491); line 493 `% \LoadClass{schwalbe}` is a comment.
- Class-native vocabulary (defined by the class, not used by the dtx sample): issue head `\Heft{vol}{issue}{month}{year}{page}` (648); environments `Editorial[title]{toc}` (678), `aktuell` (702), `InformalEntscheid` and star form (781), `Aufsatz{title}{authors}` (823), `Titel` and `Untertitel` (1188-1191), `Urdrucke{n}` (918) with `\Abteilung` (935, 981), `Loesungen` and star form (1018), `\Loesung` and star form (1103), `\Loeser` (982), `\ListeLoeserKuerzel` (1053), `Loeserliste` (1112), `BuB` (1153), `Bericht` `Gruss` `Tagung` (1197-1241), `Turnierbericht` (1263), `turnierberichte` with `\turnier` (1287, 1307), `Entscheid` (1368), `Buecher` with `\Buch` (1397, 1442), `WebSites` with `\WebSite` (1475, 1497), `maerchenlexikon` with `\maerchenart` (1322-1337), `retrolexikon` with `\retroart` (1346-1361); commands `\aTurnier` `\bTurnier` `\eEntscheid` `\TurnierAusschreibung` (1517-1590), `\Geburtstag` `\Verstorben` `\Nachruf` `\Einladung` (1636-1754), `\Inhalt` (1943), `\normaldia` `\smalldia` (2063-2072), `\doublediagram` (2175), `\figline` (593), `\foto` (602), `\reprint` (2099), `\ShowRuler` (2241), `\MeasureNewpage` (2014), `\bsol` `\esol` (1995-1996), abbreviations `\dh \ua \zB \su \ep \seedia \win \loose \mal` (580-587, 2007).

## Component map
Block A is the main sample (the documentation driver and the dtx text). Block B is what the class and style set (what `\documentclass{schwalbe}` brings), recorded so the class way's content is visible. Paths are schwalbe.dtx unless stated.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| A. class | schwalbe.dtx:491 | `class.article` | a4paper |
| A. dtx typesetting | schwalbe.dtx:492, 500-504, 76-92, 482, 489 | `dtx.doc` | `\usepackage{doc}`; `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`; `\DocInput{schwalbe.dtx}`; `\DoNotIndex{...}`; `\StopEventually{\PrintIndex\PrintChanges}`; `macrocode`; `\CheckSum{2273}` (18); `\changes` (19-74); `\DescribeMacro` `\DescribeEnv` (118-145) |
| A. language | schwalbe.dtx:495 | `lang.babel` | ngerman |
| A. input encoding | schwalbe.dtx:494 | `font.fontenc-t1` | inputenc utf8 |
| A. page | schwalbe.dtx:496-499 | `page.setlength` | `\hoffset`=-1in, `\voffset`=-1in, `\textwidth`=10cm, `\oddsidemargin`=65mm |
| A. title block | schwalbe.dtx:97-102 | `front.maketitle` | title with `\\{\large Version~\fileversion}`, author `Stefan Höning\\Neuss`, date `\docdate` |
| A. abstract | schwalbe.dtx:104-113 | `abs.kernel` | plain `abstract` |
| A. headings | schwalbe.dtx:116, 360-362 | `head.kernel` | article defaults, `\section` `\subsection` |
| A. lists | schwalbe.dtx:123-131, 951-960 | `list.kernel` | `enumerate`, `itemize` |
| A. footnote | schwalbe.dtx:124-126 | `fn.kernel` | one `\footnote` in an `\item` |
| A. table | schwalbe.dtx:395-406 | `tbl.tabular` | `{|l|l|l|}`, `\hline`, bold header cells |
| A. verbatim | schwalbe.dtx:463-465, 111, 119 | `code.verbatim` | `verbatim` environment, inline `\verb+..+` |
| A. inline marks and spacing | schwalbe.dtx:94-95, 143, 394, 399-404 | `mark.kernel`, `sp.manual-space` | `\textbf` `\textit` `{\bfseries}`; `\medskip`, `\,` |
| B. class base | schwalbe.dtx:516, 522-523 | `class.schwalbe` | `\LoadClass[11pt,a4paper]{article}`; option `ruler` |
| B. page | schwalbe.dtx:557-566 | `page.setlength` | `\hoffset`=-1in, `\voffset`=-1in, `\textheight`=26cm, `\textwidth`=157mm, `\oddsidemargin`=22.5mm, `\topmargin`=19mm, `\headheight`=0cm, `\headsep`=0cm, `\footskip`=10mm |
| B. paragraph | schwalbe.dtx:567-568 | `sp.lengths` | `\parindent`=0mm, `\parskip`=1ex plus 1ex minus .5ex |
| B. emergency stretch | schwalbe.dtx:546 | `sp.lengths` | `\emergencystretch`=15pt |
| B. header/footer | schwalbe.dtx:569-576 | `hf.class-native` | empty head; foot is the page number at the outer edge (right on odd pages, left on even); reducible to `hf.fancyhdr` |
| B. text face | schwalbe.dtx:531 | `font.mathptmx` | `times` |
| B. encodings | schwalbe.dtx:526-527 | `font.fontenc-t1` | fontenc `T2A,T1`; inputenc `koi8-r,utf8` |
| B. mono family | schwalbe.dtx:551-552 | `font.family-default` | `\ttdefault`=`zi4` (Inconsolata); `\zifour@spc` sets `\hyphenchar\font=-1` |
| B. symbols | schwalbe.dtx:529 | `font.icons` | `eurosym` |
| B. languages | schwalbe.dtx:528 | `lang.babel` | `russian,german,english,ngerman` (last is the main language) |
| B. hyphenation and tolerance | schwalbe.dtx:541, 545 | `sp.hyphenat` | `\hyphenation{Patt-idee Da-men-op-fer nicht-ortho-doxe Grim-shaw Rein-form}`; `\tolerance`=2000 (closest way: the `\sloppy` family) |
| B. penalty | schwalbe.dtx:544 | `sp.penalties` | `\exhyphenpenalty` lowered by 10 |
| B. footnote size | schwalbe.dtx:618-628 | `font.size-commands` | `\footnotesize` = 10pt on 12pt (`\@setfontsize\footnotesize\@xpt\@xiipt`); display and list skips as at 12pt (`sp.lengths`) |
| B. loaded helper packages | schwalbe.dtx:532-535 | `cols.multicol`, `meta.url`, `list.paralist`, `pg.afterpage` | loaded without options, not used by the class code; `ifthen` (530) is a programming aid for the class internals, not a component |
| B. sectioning | schwalbe.dtx:2002-2004 | `head.kernel` | `\@startsection` calls: section 0pt / 2ex / .5ex `\normalfont\large\bfseries`; subsection 0pt / 1ex / .3ex `\normalfont\bfseries`; subsubsection 0pt / .4ex / .1ex `\normalfont`; reducible to `head.titlesec` |
| B. article headings | schwalbe.dtx:678-696, 702-704, 1188-1191, 1800-1801 | `head.class-native` | heading = `\ttitel@skip` (`\vskip24pt plus 4pt`, `\goodbreak`) + `\centerline{\Large\bfseries text}` + `\titel@skip` (`\nopagebreak\vskip2pt`); `Titel` is `\centering` with baseline +4pt |
| B. issue head | schwalbe.dtx:648-671 | `front.class-native` | `\Heft`: 60mm empty `\vbox`, line `\large\bfseries HEFT n \hfill BAND \Roman{vol} \hfill month year`, 2mm skip, 1pt `\hrule`, 5mm skip; defines `\SchwalbeCopyright` (669-670) |
| B. contents | schwalbe.dtx:1791-1794, 1883, 1943-1971 | `front.class-native` | `\Inhalt`: entries written as `\write` to `\jobname.inhalt` during the run, replayed by `\input`; each line is `text \hrulefill page` |
| B. diagram setup | schwalbe.dtx:2042, 2048-2051, 2063-2085 | `art.content-package` | `diagram` (chess problem diagrams, CTAN `chess-problem-diagrams`): `\nocomputer`, `piececounter` true, `\diagcenter`, `\setmonthstyle{Roman}`, `\diagramxii` / `\diagramx`, frame distances 0, `showacademictitle` false (2077) |
| B. diagram text fonts | schwalbe.dtx:2053-2061 | `mark.kernel`, `font.size-commands` | `\authorfont`=`\bfseries`, `\cityfont`=`\itshape`, `\sourcefont`=`\slshape`, `\dedicfont`=`\itshape`, `\labelfont` and `\cpd@boardfont`=`\footnotesize` |
| B. separator line | schwalbe.dtx:593-598 | `art.content-package` | `\figline`: `\centerline` of 39 `\wK` king glyphs from the chess fonts |
| B. proof ruler | schwalbe.dtx:517-520, 2209-2243 | `bg.eso-pic` | option `ruler` calls `\ShowRuler{32mm / 1pt}{-44mm / 1pt}` unless `__finalpdf__.tex` exists; a `picture` ruler put on every page through `\AddToHook{shipout/background}`; an editor's proofing aid (467-470), not the look |

## Bespoke code
Group A is code not published (the dtx driver and text). Group B is code inside the published class and style; the rubric does not count it as bespoke (W1), and it is listed so the result can be re-read if the class source is counted as zip-local.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| A. `\Schwalbe`, `\DieSchwalbe` | schwalbe.dtx:94-95 | yes | `\newcommand` aliases of `\textbf{\textit{..}}`: `mark.kernel` |
| A. `\fileversion`, `\docdate` | schwalbe.dtx:16-17 | yes | two plain strings used in the title and date (`front.maketitle`) |
| B. abbreviation and glyph aliases `\dh \ua \zB \su \ep \seedia \win \loose \mal \rb` | schwalbe.dtx:580-587, 2007, 2047 | yes | `\def` aliases of text with `\,` and of `\times` `\pm`: `sp.manual-space`, `math.kernel` |
| B. `\foto`, `\reprint`, `\windowpar` | schwalbe.dtx:602-612, 2092-2094, 2099-2103 | yes | fixed-width `minipage` with an empty `\vtop to h` and a caption (`box.minipage`); `\hbox to \textwidth` with `\hfill` (`sp.manual-space`) |
| B. `\Heft` boxes, `\ttitel@skip` family | schwalbe.dtx:648-671, 1800-1803 | yes | counters (`num.counters`), `\hrule` (`sp.rule`), skips (`sp.manual-space`) |
| B. footer `\@oddhead` `\@oddfoot` | schwalbe.dtx:569-576 | yes | `hf.fancyhdr`: `\fancyhead{}`, `\fancyfoot[LE,RO]{\thepage}`, `\renewcommand{\headrulewidth}{0pt}` |
| B. `\@startsection` calls, `\footnotesize` | schwalbe.dtx:2002-2004, 618-628 | yes | `head.titlesec` `\titleformat` and `\titlespacing`; `font.size-commands` |
| B. `MeasureMode`, `\MeasureNewpage` | schwalbe.dtx:2012-2016 | yes | a build-time choice of `\newpage` or nothing (`pg.break`) |
| B. month names `\sw@monat` | schwalbe.dtx:634-637 | yes | twelve German strings indexed by the month counter (data) |
| B. contents machinery: `\sw@contents`, `\@nearverbatim`, per-environment `\write` blocks, `\Inhalt` rebinding environment names, `\i@line` | schwalbe.dtx:1791-1794, 1880-1881, 1883, 1943-1971; blocks e.g. 678-696, 823-842 | no | hand-rolled write and replay of a contents file; `toc.kernel` with `toc.tocloft` would give a different design, not this code. `BESPOKE/class` |
| B. author-list parsing: `\sw@author`, `\sw@writeauthor#1, #2/#3;`, `\sw@problem`, counters `sw@loesung@author@*`, `\cpd@parse@list` (package `cpdparse`) | schwalbe.dtx:1066-1093, 1807-1820, 1826-1876 | no | delimited-argument token parsing and counters that drive what is printed. `BESPOKE/class` |
| B. active slash `/`: `\sol@slash`, `\bsol`, `\esol`, catcode switches | schwalbe.dtx:999, 1021, 1993-1999 | no | catcode change for body text, with stretchable glue and a break after `/`; no lib way. `BESPOKE/class` |
| B. issue arithmetic `\LoesungenBis`, `\sw@loesungen@star` | schwalbe.dtx:851-864, 1004-1016 | no | counters and `\ifthenelse` on month, year, issue number. `BESPOKE/class` |
| B. diagram header: `\@dia@authors`, `\sw@dia@writename`, `\dia@above@InformalEntscheid`, `\doublediagram`, `\do@dia@job` | schwalbe.dtx:737-780, 924-929, 1842-1845, 2115-2190 | no | `\setbox`, `\wd`, `\ifdim` width tests choose the header layout; overrides internals of `diagram.sty`. `BESPOKE/class` |
| B. side files: `.problems` `.lsgh` `.ll` written, `.llx` read | schwalbe.dtx:876-900, 1031-1059, 1793-1794 | n/a | `\ListeLoeserKuerzel` reads `\jobname.llx` (1057), which nothing in the zip writes (the zip writes `.ll`, 1032); the step that makes it lies outside the zip, and the read is optional (`\InputIfFileExists`). `EXTERNAL/class` for that one feature only |
| B. `schwalbe.ext` hook | schwalbe.dtx:536 | n/a | optional local file, not shipped; open-ended code if present |

## Content-opaque
- Chess diagrams (the `diagram` environment of `diagram.sty`, rows of pieces from `bartel-chess-fonts`): no diagram appears in the dtx; the class is built to hold them (schwalbe.dtx:2042). Dependencies outside the zip (README:28-29), sources not read.
- `\figline` row of 39 king glyphs (schwalbe.dtx:593-598), a separator that is glyph content.
- The proof ruler drawn with `picture`, `\multiput` (schwalbe.dtx:2209-2227): an optional overlay, not the template's identity.

## Lib changes
- New ways proposed: none (considered: `ifthen`, a programming aid, not a component way).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes: the zip holds no `.tex` sample; the dtx driver is the only runnable-looking text. Missing assets, published and not shipped (README:28-29): `chess-problem-diagrams` (`diagram.sty`, `cpdparse.sty`; ctan.org/pkg/chess-problem-diagrams read: on CTAN, v1.23, LPPL 1.2, no external tool named on the page) and `bartel-chess-fonts` (named by the schwalbe-chess CTAN page, not read). None of their sources was read. `schwalbe.ins:1-8` is a DocStrip run (TeX only), not an external tool.
