no

# 0232-aguplus: AGU++ (aguplus), Daly's extension of AGUTeX for American Geophysical Union journals

- Unverified: read from the source, not compiled.
- Source: Source/0232-aguplus/ (origin: https://mirrors.ctan.org/macros/latex/contrib/aguplus.zip; licence: lppl1, "LaTeX Project Public License version 1 or later" at aguplus.cls:18-21)
- Kind: journal
- Lib: v2
- Engine: pdfLaTeX-compatible (as read; the sample has no external graphics. agupp.sty:339-344 `\plotone`/`\plotfiddle` use epsf and a dvips `\special`, unused by the samples)
- Look carried by: class (aguplus.cls plus the AGUTeX substyle it inputs: `agupp.sty` is in the zip, `jgrga.sty` of the main sample is not; the sample's preamble only fills class-native fields)
- Class origin: ctan
- Main file: samplus.tex (other samples: aguplus.tex, the manual typeset as `[twoside,agupp]` at aguplus.tex:52, which the manifest names as main; geophys.tex, a plain `article`+`longtable` listing)
- Read: main yes (samplus.tex 1-304, aguplus.tex 1-1104), zip-local classes and styles partly (aguplus.cls 1-1227 and agupp.sty 1-970 in full; aguplus.sty = the LaTeX 2.09 port of the class, read as lines 1-80 plus the diff against aguplus.cls; the four `.bst` files only heads and outlines; geophys.tex lines 1-139 and structure greps; `jgrga.sty`/`agums.sty` are NOT in the zip)

## Verdict
No. The look the main sample asks for (`\documentclass[jgrga]{aguplus}`) is defined by the AGUTeX 4.0 substyle `jgrga.sty`, which this zip does not ship (README.aguplus:93-96), so page, font, margin and title settings of that mode cannot be named. In the code that is shipped, `aguplus.cls` hand-writes several irreducible mechanisms: floats and table bodies are copied verbatim to `.lof`/`.lot` files and replayed at the end, the supplemental abstract re-inputs the job file, title and abstract are held in boxes and flushed by a `\section` hook, `planotable` is an `\halign`-based paginator, and counters are hijacked by `\stepcounter` redefinition. The citation, balance and several smaller parts do reduce to published ways.

## Blockers
- `UNMAPPED/class` the camera-ready look (page size, fonts, margin marks, heads) lives in `jgrga.sty` (AGUTeX 4.0, AGU's own kit), not in the zip and unread (samplus.tex:14; aguplus.cls:71-76; README.aguplus:93-96)
- `BESPOKE/class` "figcaps" module: `figure`/`plate`/`table`/`planotable`/`longtable` bodies are read with catcode 12, `\write`n to `\jobname.lof`/`.lot`, and replayed by `\AtEndDocument` into caption and table pages (aguplus.cls:515-793, 762)
- `BESPOKE/class` supplemental abstract re-`\input`s `\jobname` with `\documentclass` and catcodes redefined to cut out the abstract (aguplus.cls:246-265)
- `BESPOKE/class` `\title`/`\author`/`\affil`/`abstract` build a `\vbox` in a box register, flushed by a hook inside `\section`, then `\twocolumn[\box\@title\box\@abstract\null]` (aguplus.cls:135-185, 188-192, 227-245)
- `BESPOKE/class` `planotable`: `\halign`-based tabular, row counter and page-fit computation (`\pt@calcnlines`, `\pt@nl`), continued-table captions (aguplus.cls:284-376); a second, box-measuring version with active `&` (agupp.sty:587-840)
- `BESPOKE/class` "sublabel": global redefinition of `\stepcounter`/`\addtocounter`/`\endeqnarray` with hidden `sb@` counters that change printed numbers (aguplus.cls:386-457)
- `BESPOKE/class` agupp.sty rewrites `eqnarray` with raw `\halign` and `\@@eqncr`, `mathletters`, and an `\enddocument` hook that prints one running-head line per page (agupp.sty:528-548, 255-262, 100-106, 851-852)
- `BESPOKE/body` (secondary sample geophys.tex only) active `%` and `\catcode`\M=0` reader that interprets a `.mbs` listing inside a `longtable` (geophys.tex:79-88)

## Class setting
- Class: `class.aguplus` (loads `class.article` through `\LoadClass{article}`, aguplus.cls:59). Options: one AGUTeX substyle name (`agums` forces 12pt, `agupp`, `jgrga`, `grlga`, `tecga`, `radga`, `paleo`, `rtjga`: aguplus.cls:47-55), `tighten` (:56); anything else goes to article (:57). The sample uses `jgrga` (samplus.tex:14).
- Class-native vocabulary used: `\lefthead` `\righthead` `\received` `\revised` `\accepted` `\journalid` `\articleid` `\paperid` `\ccc` `\cpright` `\authoraddr` `\slugcomment` (samplus.tex:57-78); `\title` `\author` `\affil` `\altaffilmark` `\altaffiltext` (samplus.tex:82-93); `abstract` and `article` environments (samplus.tex:101, 111, 302); `\printfigures` `\doublecaption` `\sectionnumbers` `\extraabstract` (samplus.tex:41-48); `\figbox`/`\figbox*`, `plate*`, `\platewidth` (samplus.tex:139-145); `planotable` with `\tablewidth` `\tablecaption` `\tablehead` `\colhead` `\startdata` `\nl` (samplus.tex:167-180); `\citet` `\citep` (samplus.tex:118); `\balance` `\iftwocol` `notation` `\acknowledgments` (samplus.tex:221, 234, 253, 261). Present but unused: `\keywords` (agupp.sty:161), `\tablenotetext`, `\tablecomments` (agupp.sty:605-615), `\sublabon`, `\afour`, `\figmarkoff`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | samplus.tex:14; aguplus.cls:47-59 | `class.aguplus` | option `jgrga` (AGUTeX substyle selector via `\getAGU`) |
| base class | aguplus.cls:57-59 | `class.article` | other options passed through; `agums` -> `12pt` (:48) |
| camera-ready substyle look | samplus.tex:14; aguplus.cls:71-76 | none (UNMAPPED/class) | `jgrga.sty` not in zip; unread |
| class paper-size options | aguplus.cls:48 | `page.class-options` | `12pt` for agums |
| page geometry (preprint mode) | agupp.sty:38-44, 52; aguplus.cls:279-282 | `page.setlength` | textwidth 6.9in, textheight 8.6in, topmargin 0in, headheight 9pt, headsep 12pt, odd/evensidemargin 0in, hoffset -0.2in; `\afour`: textheight 24cm, textwidth 17.4cm, oddsidemargin -0.5cm |
| two columns, title across | aguplus.cls:131, 171-173; agupp.sty:51, 514-515 | `cols.twocolumn-cmd` | `\twocolumn[...]`, columnsep .26in (class) / .5in (agupp), `article` env = `\twocolumn` ... `\onecolumn` |
| balanced last page | samplus.tex:221; aguplus.cls:1174-1224 | `cols.balance` | `\balance`, `\nobalance` |
| running heads | aguplus.cls:186-192; agupp.sty:846-849 | `hf.pagestyle-kernel`, `hf.class-native` | `\pagestyle{myheadings}`, `\markboth{\@versohead}{\@rectohead}` (twoside) or `\markright{..: ..}`; texts from `\lefthead`/`\righthead` |
| per-page head lines at end of document | agupp.sty:100-106, 851-852 | none (BESPOKE/class) | loop over `\c@page` |
| spacing | agupp.sty:45, 50, 168, 298 | `sp.lengths` | parindent 1.2em, parskip .5ex, footins 3ex plus 1ex minus .5ex, footnotesep 2ex, itemsep -2.5pt |
| penalties, tolerance | agupp.sty:55, 298 | `sp.penalties`, `sp.hyphenat` | clubpenalty 4000, widowpenalty 4000; `\sloppy`; `\tolerance` 600 (not a penalty; filed under `sp.hyphenat` as nearest) |
| rules and footnote rule | agupp.sty:518-520 | `sp.rule` | `\footnoterule` = kern -3pt, hrule width 4pc, kern 2.6pt |
| float placement | agupp.sty:863-875 | `fig.placement` | topnumber 10, bottomnumber 10, topfraction .99, bottomfraction .99, textfraction .01, floatpagefraction .5, totalnumber 20, dbltopnumber 2, dbltopfraction .7, dblfloatpagefraction .5 |
| type sizes | aguplus.cls:141, 147, 153, 157; agupp.sty:230-236 | `font.size-commands`, `mark.kernel` | title `\Large\bf`, authors `\large`, affiliation `\small`, abstract `\large` with `{\bf Abstract.}`, section `\large\raggedright\bf` |
| optional Times | samplus.tex:22 (commented) | `font.mathptmx` | `\usepackage{times}` |
| title, authors, affiliations | aguplus.cls:135-153, 227-238; samplus.tex:82-93 | none (BESPOKE/class) | `\parbox{\@fmwidth}` with `\@fmwidth`=33pc, `\raggedright`, `\pretolerance=10000` |
| author footnotes | aguplus.cls:176-181, 239-242; agupp.sty:458-478 | `front.thanks`, `fn.kernel` | `\altaffilmark`, `\altaffiltext` collected in `\@titlenote`, printed with `\footnotetext` and `\@makefntext` redefined |
| slug, dates, copyright, paper id | samplus.tex:57-78; agupp.sty:68-97, 109-126 | `front.class-native` | `\received`, `\revised`, `\accepted`, `\journalid`, `\articleid`, `\paperid`, `\ccc`, `\cpright{AGU}{1999}`, `\slugcomment`; printed after the references (agupp.sty:271-281, 300-310) |
| abstract | aguplus.cls:154-166, 220-223; samplus.tex:101-107 | none (BESPOKE/class) | `abstract` stored in `\@abstract` box, `minipage{\@fmwidth}`, `\large`, rightskip 2em |
| supplemental abstract | aguplus.cls:246-265; samplus.tex:48 | none (BESPOKE/class) | `\extraabstract` |
| headings | agupp.sty:229-237; aguplus.cls:106-121 | `head.kernel` | `\@startsection` section {1}{-\parindent}{2.3ex plus 1ex minus .2ex}{1.5ex plus .2ex}; subsection {2}{-\parindent}{2ex plus 1ex minus .2ex}{1ex plus .2ex}; subsubsection run-in {1sp}{-1em}; `\@seccntformat` with `\sectype`/`\sectchar` |
| numbering depth and formats | agupp.sty:174, 239-242; aguplus.cls:117-121 | `num.secnumdepth`, `num.counters` | secnumdepth 0 by default, `\sectionnumbers` sets 3; `\thesubsection` = `\thesection.\@arabic{...}` |
| appendices | aguplus.cls:480-514; samplus.tex:223-228 | `num.appendix`, `num.counters` | `\appendix`: `\Alph{section}`, `\@addtoreset` equation/figure/table/plate in section, `\appendixname~` + ":" run-in, single appendix `\section*` |
| acknowledgments | aguplus.cls:124-129; agupp.sty:942-950; samplus.tex:261 | `front.dedication` | `\acknowledgments`: `{\small\bf Acknowledgments.}` then `\small` |
| notation list | aguplus.cls:266-277; samplus.tex:253-259 | `list.kernel` | kernel `list` with `\settowidth{\labelwidth}`, labelsep 1em, itemsep 0, parsep 0, `\hfill` labels, unnumbered `\section*{Notation}` |
| plain lists and quotes (manual) | aguplus.tex:138-161, 163-167, 880-904 | `list.kernel`, `quote.kernel` | `description`, `quote`, `enumerate` |
| display maths | samplus.tex:190-199, 234-243 | `math.kernel` | `equation`, `eqnarray` (`\nonumber`); agupp.sty:528-548 replaces `eqnarray` (BESPOKE/class) |
| one- vs two-column maths | aguplus.cls:278; samplus.tex:234-243 | none (BESPOKE/body, reducible) | `\iftwocol{two}{one}` picks a branch by class mode |
| equation numbering in appendix | aguplus.cls:486-488 | `num.counters` | `\theequation` = `\thesection\arabic{equation}` |
| equation, figure, table sublabels | aguplus.cls:386-457 | none (BESPOKE/class) | `\sublabon{counter}` / `\sublaboff` |
| figures | samplus.tex:138-142; aguplus.cls:571-587 | `fig.graphicx` | `figure` with `\figbox`, `\caption[]`; floats collected by figcaps (BESPOKE/class) |
| figure body box | aguplus.cls:826-834; samplus.tex:139, 145 | `box.fancybox`, `sp.rule`, `sp.manual-space` | `\figbox{w}{h}{content}` = `\framebox[w][c]` with a `\vrule` strut of height h; `\figbox*` = `\makebox` |
| plates | agupp.sty:324-331; aguplus.cls:596-622; samplus.tex:143-154 | `fig.newfloat` | `plate`/`plate*`, placement `bp`, ext `lof`, label "Plate" bold |
| captions | aguplus.cls:193-200; agupp.sty:446-451 | `cap.kernel`, `cap.caption` | `\@makecaption`: 10pt skip, centred if it fits on one line, else paragraph; `\fnum@figure` bold "Figure n." |
| double-width captions | aguplus.cls:844-854; samplus.tex:43 | none (BESPOKE/class) | `\doublecaption{35pc}` re-prints captions at a second width |
| tables | samplus.tex:167-180; aguplus.cls:284-376; agupp.sty:639-840 | none (BESPOKE/class) | `planotable` with `\tablehead`, `\colhead`, `\startdata`, `\nl`, rules after title, head and data |
| table notes | agupp.sty:605-623 | `tbl.threeparttable` | `\tablenotetext{a}{..}`, `\tablecomments{..}` collected in `\tblnote@list` |
| tabular in manual | aguplus.tex:714-719, 729-733 | `tbl.tabular` | `l@{~$\Rightarrow$~}l` |
| longtable allowed | aguplus.tex:669-673; geophys.tex:88 | `tbl.longtable` | `longtable{lp{6cm}}` (single column only) |
| margin float markers | aguplus.cls:577, 835 | `note.marginpar`, `box.fancybox` | `\marginpar{\fbox{\fnum@figure}}`, `\figmarkoff` |
| cross-references | samplus.tex:113, 129-131, 163 | `xref.kernel` | `\label`, `\ref` |
| citations | aguplus.cls:861-1088; samplus.tex:118-123 | `bib.natbib` | embedded natbib 7.0: open `[`, close `]`, sep `;`, note sep `, `, aysep `,`, yrsep `,~`, sort off (aguplus.cls:864-867); `\citet`, `\citep` with two optional arguments |
| bibliography env | samplus.tex:278-300; agupp.sty:292-310, 312; aguplus.cls:959, 1089-1090 | `bib.thebibliography` | `thebibliography{}`, `\bibitem[{\it Name}(year)]{key}`, hanging indent 1.2em, `\newblock` skip, empty `\@biblabel` |
| BibTeX style | README:4-10; samplus.tex:273-274; agu.bst:1-8 | `bib.bibtex-bst` | `agu`, `agufull`, `agu04`, `agufull04` (generated from merlin.mbs by makebst) |
| verbatim (manual) | aguplus.tex:403-407, 545-561 | `code.verbatim` | `verbatim`, `\verb` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| figcaps module (floats to end files) | aguplus.cls:515-793 | no | considered: `endfloat` (CTAN) moves whole floats to the end; it does not give AGU's caption-only pages, tables page, optional figure pages and double-width captions in this order, so it is not a faithful way |
| supplemental abstract | aguplus.cls:246-265 | no | needs the job file to be re-read at the end |
| title and abstract boxes, `\xmaketitle`, `\section` hook | aguplus.cls:135-192, 227-245 | no | box registers flushed by a hook; no lib way |
| planotable | aguplus.cls:284-376; agupp.sty:639-840 | no | `\halign` paginator; a `tbl.longtable` rewrite would change caption-width and break behaviour |
| sublabel | aguplus.cls:386-457 | no | global `\stepcounter` redefinition |
| agupp eqnarray, mathletters, end-of-document head loop | agupp.sty:528-548, 255-262, 100-106 | no | raw `\halign`, `\enddocument` hook |
| `\@sect` restore, `\@ssect`, `\@seccntformat`, `\@hangfrom`, `\sectype` | aguplus.cls:70-80, 106-121 | yes | `head.kernel` parameters as in the table; `\@startsection` arguments from agupp.sty:229-237 |
| appendix and `\noappendix` | aguplus.cls:480-514, 122-129 | yes, with caveat | `num.appendix` + `num.counters` set at `\appendix`, reverted before acknowledgments by the emitter; the `\@Alph` patch (:499) is odd and not checked |
| balance copy | aguplus.cls:1174-1224 | yes | `cols.balance` (`balance` 4.3 by the same author) |
| natbib 7.0 copy | aguplus.cls:861-1167 | yes | `bib.natbib` with `\bibpunct` values at :864-867; `\thebibliography` wrapper (:1089-1090) only adds `\noappendix` |
| `\figbox` | aguplus.cls:826-834 | yes | `box.fancybox` (`\framebox[w][c]`) + `sp.rule` strut |
| `notation` | aguplus.cls:266-277 | yes | `list.kernel` `list` with the same lengths, or `list.enumitem` description |
| `\iftwocol`, `\afour` | aguplus.cls:278-282 | yes | emitter picks one branch/values for its chosen mode |
| `\@makecaption` (preprint branch) | aguplus.cls:193-200 | yes | `cap.caption` single-line centring; the double caption is not (figcaps) |
| plate float | agupp.sty:324-331 | yes | `fig.newfloat` |
| table notes list | agupp.sty:605-631 | yes | `tbl.threeparttable` |
| slug and address block after references | agupp.sty:271-281, 300-310 | yes, for agupp mode | strings placed after the bibliography under `\footnoterule` (`sp.rule`) and `\footnotesize`; camera-ready (jgrga) code unread |
| geophys.tex `\ACRO`, `\PF`, active `%` reader | geophys.tex:27-30, 79-88 | no | catcode-driven reader of a docstrip listing (secondary sample only) |

## Content-opaque
none. The figure bodies are text placeholders (samplus.tex:139, 145); the `\includegraphics{cc1492.eps}` line is commented out (samplus.tex:147). Equations, `sample.bib` entries and `.bst` internals are content or published-style data.

## Lib changes
- New ways proposed: none (considered: `endfloat`, rejected as above; no `NEW:` way is used in this file)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
