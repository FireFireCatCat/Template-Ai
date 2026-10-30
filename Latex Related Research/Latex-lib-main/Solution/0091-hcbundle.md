yes

# 0091-hcbundle: HC Bundle for LaTeX2e (hcart, hcreport, hcletter, hcslides)

- Unverified: read from the source, not compiled.
- Source: Source/0091-hcbundle/ (origin: https://mirrors.ctan.org/macros/latex/contrib/hc.zip; licence: other-free per manifest; README says "Free / GNU GPL", hc.ins:12-15 cites the GNU Library GPL v2 or later)
- Kind: misc (a class bundle documented by its own `.dtx`; the manifest hint `letter` is wrong, only one of the four classes is a letter class and the sample is a manual)
- Lib: v1
- Engine: pdfLaTeX-compatible (the class tests `\pdfoutput` and calls `\pdfinfo`, hc.dtx:340-344, 1112-1117; the shipped `hc.ps` is a dvips run, hc.ps:2-4; `T1`/`latin1`, `palatino`, `eurofont` are pdfTeX-era packages, hc.dtx:469-470, 715-718, 769; not usable under XeLaTeX/LuaLaTeX as written)
- Look carried by: class (the published classes `hcart`/`hcreport`/`hcletter`/`hcslides` carry the look; the sample adds only `\usepackage{doc}` and a few `\newcommand` aliases)
- Class origin: ctan (CTAN package `hc`, "Included in TeX Live and MiKTeX, both as `hc`", author Christian Siefkes; one ctan.org/pkg/hc read, whose page lists the four classes; the zip is the CTAN file)
- Main file: hc.dtx (driver at hc.dtx:57-63; no separate `.tex`; other samples: none; `hc.ps` is the dvips output of that driver, 36 pages A4, hc.ps:2-7, read for its header only)
- Read: main yes (driver and the whole of hc.dtx, lines 1-1624), zip-local classes and styles all (no `.cls`/`.sty` ships; the class code is the unprefixed lines of hc.dtx, read in full; `hc.ins` read in full; the two `.bst` files read at the header and function outline only, see notes)

## Verdict
yes. There is no zip-local class or style file: the zip is the CTAN release of four published classes, shipped as one `.dtx` plus the `hc.ins` DocStrip driver (hc.ins:41-46). The only sample is the doc driver `\documentclass[paper]{hcart}` + `\usepackage{doc}` + `\DocInput{hc.dtx}` (hc.dtx:58-61), so the look is `class.hcart` with option `paper`, plus the published `doc` package (proposed as `dtx.doc`). The sample's own macros (hc.dtx:66-106) are `\newcommand` aliases over class commands and kernel font commands, so they reduce. No artwork, no external tool. Sensitivity: the classes' internals (a hand-built `\ps@headings`, the `\q` state swap, a patched `\NAT@cite`) would be `BESPOKE/class` if the classes were zip-local; they are published (CTAN, TeX Live), so the class is one way and they are not counted.

## Blockers
none

## Class setting
- Class: `class.hcart` options: `paper` (sets `bib` and `html`, hc.dtx:331-333). Defaults the class adds when no option overrides them: 12pt (438-440), a4paper (446-450), `headsepline` (424-426), always `twoside,pointlessnumbers,liststotoc,bibtotoc,idxtotoc` (433-434), `palatino`, `euro`, `fancyref`, `html`, `hcarea`, `hcfootnotes`, `fnbib`, `htmlbib`, `pdf` auto-set when `\pdfoutput` is defined (340-344). Base class is KOMA `scrartcl` (124, 451). Unknown options only warn (375-377). Not implemented: other paper sizes, `oneside`, `DIV`/`BCOR`, `titlepage`, `landscape`, `draft` (379-396).
- Class-native vocabulary used by the sample: `\tit[date]{title}` (hc.dtx:95; `\titaut` paper branch 1297-1355 builds a title page with `\vfill`s and a table of contents page), `\section`/`\subsection`/`\subsubsection`, `\minisec` (1080), `\item[...]` in `flexlist` (111-120, 538-545) and `widedesc` (380-396, 552-554), `\marginbox` through the sample's `\descOpt`/`\descCom`/`\descEnv` (98-102, 635-643), `\q{}` `\hq{}` `\fq{}` (496-526), `\qdots` (564), `\phyp` (570), `\arrow` (576), `\E` (764, 770), `\LaTeXe` (kernel logo, 95, 109), `\BibTeX` (used at 295 etc.; defined nowhere in the zip, so it comes from a loaded published package; which one was not checked).
- Class-native vocabulary documented but not exercised by the sample: `\titsubinfo` `\titsub` `\titinfo` (1183-1224), `\autinfo` (1233), `\abs` (1251), `\keywords` (1262), `\hyperinfo` (1278), `\biblio` `\cfcite` `\qu` `\qul` `\biburl` `\bibvol` `\etal` `\bibmov` (981-1090), `\htlink` `\hturl` `\htmail` (826-844), `\fref` `\Fref` `\see` (788-797), `ticklist`/`crosslist`/`checklist` with option `ding` (722-760), `\Es` (771), `dialog` + `\newspeaker` (672-688), `art`/`artsubtit`/`arttitsub` with option `magazine` (927-952), `\distance` `\stardistance` `\linedistance` `\sig` `\intro` `\hint` `\cen` `\rightaddress` `\pcent` `\f` `\ff` `\shorttoday` `\fictionsec` `\enge` (559-694, 1430), option `german` (150-155, 1571-1616).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | hc.dtx:58, 123-124, 451 | `class.hcart` | option `paper`; base `scrartcl` with 12pt, a4paper, twoside, pointlessnumbers, liststotoc, bibtotoc, idxtotoc, headsepline passed down |
| paper and point size | hc.dtx:438-450 | `page.class-options` | `a4paper`, `12pt` (class defaults); `letterpaper`, `10pt`, `11pt` selectable (163-171, 285-290) |
| text area | hc.dtx:895-898, 242-245 | `page.typearea` | KOMA `typearea`, `\areaset[15mm]{150mm}{240mm}` (BCOR 15mm, 150 x 240 mm) when `hcarea` (default) |
| running heads, empty foot | hc.dtx:858-891 | `hf.class-native` | `\ps@headings`: page number outer, mark truncated to 0.92\textwidth (856, 861-870), `\hrule` under head when `headsepline` (863, 870), foot empty (871-876); `\pagestyle{headings}` (891) |
| page styles in front matter | hc.dtx:1134, 1145, 1351, 1398 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` on title and toc pages |
| page counter reset | hc.dtx:1350, 1332 | `pgnum.pagenumbering` | `\setcounter{page}{0}` after the title page |
| line and page breaking | hc.dtx:455-461 | `sp.penalties` | `\clubpenalty9999`, `\widowpenalty9999`, `\displaywidowpenalty1000`, `\brokenpenalty1000`; `\sloppy` under `sp.hyphenat` (455); `\frenchspacing` (461) is a TeX primitive switch carried by the class, no separate lib way |
| paragraph skip option | hc.dtx:956-959 | `sp.lengths` | `parskip`: `\parskip=\medskipamount`, `\parindent=0pt` (not used by sample) |
| line spacing option | hc.dtx:963-965 | `sp.linespread` | `wide`: `\linespread{1.3}`, reset to 1 around title/toc (1299, 1353) (not used by sample) |
| text fonts | hc.dtx:715-718 | `font.palatino` | packages `palatino` + `mathpple` (default, option `palatino`/`nopalatino`); `hc.ps:7` lists Palatino-Roman, Helvetica-Bold, Courier as the fonts of the sample |
| encodings | hc.dtx:469-470 | `font.fontenc-t1` | `fontenc[T1]`, `inputenc[latin1]` |
| Euro symbol | hc.dtx:768-772 | `class.hcart` vocabulary | `\E`, `\Es{}` over `eurofont[right,notextcomp]` (no lib way for a glyph package; carried by the class); sample uses `\E` (191) |
| language | hc.dtx:143-155, 443-445, 472 | `lang.babel` | `babel` with `english` by default; `german` -> `ngerman` and `german.hld` at end of class (153, 1571-1616); `\captionsngerman` texts |
| hyperlinks and PDF info | hc.dtx:1098-1120 | `meta.hyperref` | at end of class: `hyperref[hyperindex,colorlinks=true,pdftex,latex2html,extension=pdf]`; `\pdfinfo` from `\hypertitle` `\hyperauthor` `\hyperabstract` `\hyperkeywords` (1112-1117); `html` package supplies `\htmladdnormallink` (830, 1313-1315) |
| title block | hc.dtx:95, 1297-1355, 1407 | `front.class-native` | `\tit[date]{title}` -> `\titaut`: `\title{\normalfont\huge ...\vfill}`, `\author{...}`, `\date{\vfill\vfill\normalfont\normalsize ...}`, `\maketitle` |
| title via kernel command | hc.dtx:1305-1329 | `front.maketitle` | `\title` `\author` `\date` `\maketitle` as called inside `\titaut` |
| table of contents | hc.dtx:1131-1141 | `toc.kernel` | `paper`: `\newpage`, `\thispagestyle{empty}`, `\tableofcontents`, `\newpage` (`\toc` itself is empty under `paper`) |
| toc options | hc.dtx:433-434 | `toc.koma` | KOMA options `liststotoc,bibtotoc,idxtotoc` always on |
| heading looks | hc.dtx:433, 1080, 1507-1509 | `head.class-native` | `scrartcl` heading fonts; `pointlessnumbers`; `\minisec` (KOMA) used at 1080; `\part` forced onto a new page (1439-1441) |
| section depth | hc.dtx:854-855 | `num.secnumdepth` | `secnumdepth=3`, `tocdepth=3` |
| abstract and keywords | hc.dtx:1249-1264, 1334-1349 | `abs.class-native` | `\abs[other]{}` and `\keywords{}` stored, printed under the title with `\minisec{\centering...}` (not called by sample) |
| `flexlist` and `widedesc` lists | hc.dtx:538-554 | `list.kernel` | kernel `list` with `\settowidth{\labelwidth}{\sffamily\bfseries ...}`, `\leftmargin=\labelwidth+\labelsep`, `\makelabel` bold sans plus separator (`sp.lengths` for the lengths) |
| margin box | hc.dtx:635-643 | `tbl.tabular` | `\marginbox`: `\small`, `\addvspace{4.5ex plus 1ex}`, `\hspace{-.75\leftmargini}`, `tabular{\|l\|}` with `\hline`; spacing under `sp.manual-space` |
| nested quotes | hc.dtx:496-526 | `class.hcart` vocabulary | `\q` alternates outer and inner quote marks, `\hq` always inner, `\fq` always outer |
| emphasis marks | hc.dtx:611, 617, 1073; sample text | `mark.kernel` | `\emph`, `\textbf`, `\texttt`, `\textsc` |
| footnote layout | hc.dtx:902-905 | `fn.kernel` | KOMA `\deffootnote{1em}{0.5em}{\textsuperscript{\normalfont\thefootnotemark}\,}` when `hcfootnotes` (inherited KOMA setting, carried by the class); `\footnote` used by `\see` (797) |
| rules in text helpers | hc.dtx:599-606, 1525-1526 | `sp.rule` | `\hrule` in `\linedistance`; `\rule{\textwidth}{0.6pt}` in the slides page style |
| citations | hc.dtx:468, 981-997 | `bib.natbib` | `natbib` always for hcart/hcreport/hcslides; `fnbib` `\bibpunct[, ]{}{}{;}{a}{}{,}` with `\NAT@cite` made a footnote (985-989); `autbib` author-year in brackets; `numbib` numeric (not called by sample) |
| bibliography style | hc.dtx:981, 1014-1018; hc-en.bst:3-8; hc-de.bst:3-10 | `bib.bibtex-bst` | `\biblio[style]{files}` -> `\bibliographystyle`, `\bibliography`; styles `hc-en` / `hc-de` made with custom-bib `merlin.mbs` (natbib author-year `\bibitem[...]`, hc-en.bst:30-32) |
| doc driver | hc.dtx:59-62 | `dtx.doc` | `\usepackage{doc}`, `\DocInput{hc.dtx}`, `\GetFileInfo` (93), `\changes` (67-92), `\StopEventually` and `\Finale` (1619-1620), `macrocode` environments around every code block |
| short verbatim | hc.dtx:97 | `code.verbatim` | `\MakeShortVerb{\|}` so `\|text\|` is `\verb` (used throughout the prose) |
| other bundle classes (not loaded by sample) | hc.dtx:131-132, 354-357, 1455-1478 | `class.hcreport` | base `scrreprt`; `openany`/`openright`; `\chapter`/`\addchap`/`\part` start with `\thispagestyle{empty}`; abstract on `\lowertitleback` (1318-1328) |
| letter class (not loaded) | hc.dtx:127-128, 436, 1448 | `class.hcletter` | base `scrlettr`; option `wlocfield` always; `\foldmarksoff`; vocabulary of `ltr.opening` |
| slides class (not loaded) | hc.dtx:135-136, 1497-1559 | `class.hcslides` | base `seminar`; `\renewcommand{\rmdefault}{\sfdefault}`, slide sizes 0.74/0.84 of paper, `\slideframe{none}`, `\newpagestyle{HC}`, sections via `\shadowbox` (`box.fancybox`, 1531-1536), option `twotoc` with `multicol` (`cols.multicol`, 1548-1559) |
| columns (option, not used) | hc.dtx:927-952, 232-235 | `cols.multicol` | `magazine`: `art` environments in `multicols{2}`; `twocolumn` passed to the base class (`cols.twocolumn-option`) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\cs`, `\m`, `\oarg`, `\rarg`, redefined `\arg`, `\comdiv` | hc.dtx:66, 102-106 | yes | `\newcommand` aliases of `\texttt`, `\textbackslash`, `\mbox{\it ..\/}` (`mark.kernel`) |
| `\descOpt`, `\descCom`, `\descEnv` | hc.dtx:98-101 | yes | aliases of the class's `\marginbox` with `\texttt` content; `\marginbox` itself is `tbl.tabular` + `sp.manual-space` (above) |
| `\ps@headings` redefinition | hc.dtx:858-891 | published class internals, not counted | `class.hcart` is the way (`hf.class-native`); would be `BESPOKE/class` (hand-built `\vbox`/`\hb@xt@` heads) if zip-local |
| `\q` nested-quote state swap | hc.dtx:496-516 | published class internals, not counted | class vocabulary; `\let` swapping of quote macros |
| `\NAT@cite` patch for footnote citations | hc.dtx:986-989 | published class internals, not counted | patches natbib internals; part of `fnbib` |
| `\titaut` flow with page-counter resets and `\@toc` | hc.dtx:1297-1402, 1132-1153 | published class internals, not counted | class vocabulary `\tit` |
| `\shorttoday` counter arithmetic | hc.dtx:660-665 | published class internals, not counted | counter `shortyear` with `\whiledo` |
| `\part`, `\chapter`, `\addchap` overrides | hc.dtx:1439-1478, 1537-1544 | published class internals, not counted | `\secdef`-based variants of kernel/KOMA commands |
| hcslides `\tableofcontents` override | hc.dtx:1550-1558 | published class internals, not counted | `multicols{2}` around `\@starttoc`, `\columnseprule` saved and restored (option `twotoc`) |
| support packages `ifthen`, `xspace`, `truncate`, `html`, `fancyref` | hc.dtx:471, 473, 856, 830, 789 | not counted | loaded by the class itself (class vocabulary); the sample calls none of their commands directly |
| generated files `hcart.cls` etc., `german.hld` | hc.ins:41-46 | n/a | DocStrip output of hc.dtx, the same published classes; DocStrip is a TeX run, not an outside tool |

## Content-opaque
none (the `macrocode` bodies are the classes' own source printed as code text, which is content for `dtx.doc`)

## Lib changes
- New ways proposed: `dtx.doc` (`doc` package, LaTeX base, pdf engine; `\usepackage[multicol]{doc}` plus `\DocInput{file.dtx}` wrapping `macrocode`/`macro` blocks, `\GetFileInfo`, `\changes`, `\StopEventually`/`\Finale`). W1: `doc.sty` ships in the LaTeX base distribution. W2: package options (`multicol`, `debugshow`) and switches (`\RecordChanges`, `\CodelineNumbered`, `\EnableCrossrefs`, `\DoNotIndex`, `\MakeShortVerb`). W3: serves any documented DocStrip source, not one document. W4: one preamble line and one body wrapper (`\DocInput`). `class.ltxdoc` is the class that loads this same package; no lib way covers `doc` loaded by another class, as here.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- No instruction text addressed to an AI was found in README, FILES, hc.ins, hc.dtx or the `.bst` files.
- `hc-en.bst` and `hc-de.bst` are custom-bib (`merlin.mbs`) output with standard makebst function names (outline grepped; hc-en.bst:1-75 read; bodies of the entry-type functions not read). The sample never cites or calls `\biblio`, so they are not exercised.
- Dependencies the zip does not ship: `eurofont`, `fancyref`, `truncate`, `html` (latex2html style), `mathpple`, `pifont`, `fancybox`, `seminar`, KOMA `typearea`/`scrartcl`/`scrreprt`/`scrlettr`. Whether each is present in a current TeX Live was not checked; `hcletter` builds on the old KOMA `scrlettr`, which current KOMA-Script may not provide as a class (not checked). None needs a tool outside TeX; `html.sty` is only a style file, not the latex2html program.
- The empty author block of the title page still emits `\htmladdnormallink{}{mailto:}` because `\defaultemail` and `\defaulthomepage` are empty by default (1313-1315); not checked how it renders.
