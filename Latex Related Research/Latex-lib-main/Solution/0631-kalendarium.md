yes

# 0631-kalendarium: kalendarium (Latin Roman-calendar dates; the package's l3doc manual)

- Unverified: read from the source, not compiled.
- Source: Source/0631-kalendarium/ (origin: https://mirrors.ctan.org/macros/latex/contrib/kalendarium.zip; licence: LPPL 1.3c)
- Kind: misc (a package manual in `.dtx` form; the manifest hint `calendar` is wrong: the package prints one date as Latin text, it does not lay out a calendar page)
- Lib: v5
- Engine: pdfLaTeX-compatible (kalendarium.dtx:2 `% !TEX program = pdfLaTeX`; `inputenc` latin1 and `fontenc` T1 at :85-86; the package is expl3 and runs under pdfTeX)
- Look carried by: mixed (the page look and the `function`/`variable`/`syntax` blocks come from the published class `l3doc`; fonts, colours and the three `mdframed` boxes are the driver preamble at kalendarium.dtx:84-145)
- Class origin: tex-distribution-unbundled (`l3doc` is not in the zip; ctan.org/pkg/l3kernel lists "The l3doc class" and "Contained in TeX Live as l3kernel")
- Main file: kalendarium.dtx (driver at :83-150, run through `\DocInput` at :148; other samples: none, README.md:9-15 only repeats one `\usepackage` line)
- Read: main yes, zip-local classes and styles none present (`kalendarium.sty` is not in the zip: kalendarium.ins:48-50 generates it from the `package` part of the `.dtx`, and that code, kalendarium.dtx:643-1277, was read in full)

## Verdict
yes. The zip is CTAN's own release of the package `kalendarium` (the manifest origin is `mirrors.ctan.org`; ctan.org/pkg/kalendarium shows Andrew Smith, v1.0, LPPL 1.3c, in TeX Live), so the package is a published way (W1) with key=value options (W2), serving any text that needs a Roman date (W3), written as one `\usepackage[keys]{kalendarium}` line and inline `\KalDate{y}{m}{d}` calls (W4); it fits the existing `front.datetime` way, whose text says a date-printing package is the parameter. The driver preamble loads only published packages, and its own macros (an alias, two label macros, one skip macro, three `\newmdenv`) and one expl3 table loop reduce to lib ways or to unrolled rows. There is no artwork and no tool outside TeX beyond `makeindex` for the index, which the lib already accepts for `dtx.doc` and `idx.makeidx`. The `yes` rests on counting `kalendarium.sty` as published: if its expl3 date arithmetic (kalendarium.dtx:895-1081, :1157-1199) were counted as zip-local code, it would be irreducible.

## Blockers
none

## Class setting
- Class: `class.l3doc` options: `full`, `english` (kalendarium.dtx:84). Source of `l3doc` not read (it ships with the TeX distribution).
- Class-native vocabulary used: environments `documentation` (:163), `implementation` (:636), `function[EXP]{names}` (:296), `syntax` (:297), `variable{name}` and `variable[internal]` (:378, :682), `macro[internal]` (:766), `macrocode` (:639); commands `\cs` `\marg` `\oarg` (:298), `\meta` (:301) and `\pkg` (:169); doc-level commands `\GetFileInfo` (:153), `\fileversion` `\filedate` (:157), `\changes` (:161), `\DocInput` (:148), `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges` (:101-103), `\PrintIndex` (:1285), `\Finale` (:1286). `\toprule` `\midrule` `\cmidrule` `\bottomrule` are used (:192-210) with no `\usepackage{booktabs}` in the driver, so they must come in through `l3doc` (not checked: class source absent).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | kalendarium.dtx:84 | `class.l3doc` | options full, english |
| input encoding, font encoding | kalendarium.dtx:85-86 | `font.fontenc-t1` | inputenc latin1, fontenc T1 (the file itself is Latin-1: the accented byte in the name "P?teau" at :249 is not valid UTF-8) |
| text fonts | kalendarium.dtx:94 | `font.helvet` | tgheros, scale=0.875 |
| text fonts | kalendarium.dtx:95 | `font.serif-pkg` | tgschola (TeX Gyre Schola), no options |
| symbol glyphs | kalendarium.dtx:96, :143-144, :233-239 | `font.icons` | wasysym: `\bell`, `\astrosun` `\leftmoon` `\mars` `\mercury` `\jupiter` `\venus` `\saturn` |
| microtype | kalendarium.dtx:92 | `sp.microtype` | defaults |
| colour | kalendarium.dtx:97, :105-106 | `color.xcolor` | maroon = HTML A40000, navy = HTML 2929D8; `\textcolor` at :142-144 |
| links | kalendarium.dtx:107 | `meta.hyperref` | `\hypersetup{allcolors=maroon,colorlinks=true}` (hyperref is loaded by the class; not checked) |
| maths packages | kalendarium.dtx:88, :90 | `math.amsmath`, `math.mathtools` | defaults; used at :394 (`\underbrace`, `\text`, `\mathclap`) |
| display equations (content) | kalendarium.dtx:1144, :1154 | `math.kernel` | `\[ ... \]` with `\left\lfloor`, `\mod` |
| page geometry | kalendarium.dtx:89, :262, :291 | `page.geometry` | `[pass]` at load, `\newgeometry{margin=0.25in}`, `\restoregeometry` |
| landscape page | kalendarium.dtx:93, :263-290 | `pg.landscape` | `pdflscape`, `landscape` environment around the day table |
| page style | kalendarium.dtx:264 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| centring, vertical fill | kalendarium.dtx:265-267, :288-289 | `sp.ragged`, `sp.manual-space` | `\centering`; `\hspace{0pt}` `\vfill` above and below the table |
| spacing | kalendarium.dtx:295, :306, :145 | `sp.manual-space` | `\vspace{-8pt}`, `\medskip`, `\hspace*{2em}` (:324), `\hspace{0.5em}` (:143) |
| paragraph start, list gap | kalendarium.dtx:307, :1146 | `sp.lengths` | `\noindent`; `\itemsep0em` |
| type size | kalendarium.dtx:143-144, :375 | `font.size-commands` | `\large` |
| inline marks | kalendarium.dtx:142, :181, :307 | `mark.kernel` | `\sffamily\bfseries`, `\textit`, `\textsc`, `\texttt` |
| verbatim | kalendarium.dtx:172, :175 | `code.verbatim` | `\verb\|...\|` |
| boxes | kalendarium.dtx:91, :109-116, :118-128, :130-140 | `box.mdframed` | `\newmdenv` for `sample`, `example`, `accepted`: backgroundcolor=black!10, linecolor=maroon or navy, linewidth=1.5pt, topline/rightline/bottomline=false (a left bar only), frametitle=Example or Accepted values, frametitlefont=\sffamily\bfseries, frametitlebelowskip=2pt or 0pt |
| date printing (the package under test) | kalendarium.dtx:99, :157, :279-285, :307 | `front.datetime` | kalendarium: load options abbreviate=true, bissextum=false, era=none; per-call keys abbreviate, antediem, bissextum, dayfmt, era, julian, oldmonths, periods, yearfmt (the key list is read at :656-675); calls `\KalDate[keys]{y}{m}{d}`, `\KalDateStr[keys]{YMD}{-}{string}` (:157), `\KalToday`, `\KalWeekday` |
| doc machinery | kalendarium.dtx:101-103, :148, :153, :161, :639, :1285-1286 | `dtx.doc` | `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput`, `\GetFileInfo`, `\changes`, `macrocode`, `\PrintIndex`, `\Finale` (all reached through `l3doc`, which loads `doc`) |
| title block | kalendarium.dtx:155-159 | `front.maketitle`, `front.thanks` | `\title{The \kalendarium/ Package}`, `\author{...\thanks{Email: ...}}`, `\date{Version \fileversion\ --- Released \KalDateStr[era=auc]{YMD}{-}{\filedate}}`, `\maketitle` |
| abstract | kalendarium.dtx:164-166 | `abs.kernel` | `abstract` environment inside `documentation` |
| headings | kalendarium.dtx:168, :183, :637-638 | `head.class-native` | `\section` and `\subsection` with no option; the look is the class's |
| code and doc blocks | kalendarium.dtx:296-309, :378-396, :636-1283 | `class.l3doc` | the `function`, `syntax`, `variable`, `macro`, `macrocode` blocks (class-native; recorded above) |
| footnotes | kalendarium.dtx:181, :186, :188, :214, :216, :224, :249 | `fn.kernel` | `\footnote` |
| tables | kalendarium.dtx:191-211, :229-241, :268-287, :382-385, :402-405 | `tbl.tabular` | column specs `l l c c c`, `l l c l`, `r l l l l l l`, `l p{0.8\textwidth}`; `\multicolumn` (:193, :270) |
| table rules | kalendarium.dtx:192-210, :269-273, :286 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` `\cmidrule{3-5}` `\cmidrule(lr){2-3}` |
| list | kalendarium.dtx:1145-1152 | `list.kernel` | `itemize` with four items |
| cross-reference | kalendarium.dtx:178, :374 | `xref.kernel` | `\ref{fopt}`, `\label{fopt}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\kalendarium/{...}` (delimiter `/`) | kalendarium.dtx:142 | yes | inline expansion: `\textcolor{maroon}{\sffamily\bfseries kalendarium}` (`color.xcolor`, `mark.kernel`); used in the title (:155) and the prose |
| `\default{#1}` and `\nondefault{#1}` | kalendarium.dtx:143-144 | yes | `\textcolor{navy}{{\large \bell}\hspace{0.5em}\texttt{#1}}` and the same with `\phantom{\large \bell}` (`color.xcolor`, `font.size-commands`, `font.icons`, `sp.manual-space`, `mark.kernel`) |
| `\interblocksp` | kalendarium.dtx:145 | yes | `\vspace{-10pt}` (`sp.manual-space`) |
| `\newmdenv` x3: `sample`, `example`, `accepted` | kalendarium.dtx:109-140 | yes | `box.mdframed` with the key lists in the component map |
| expl3 loop that writes 28 table rows | kalendarium.dtx:274-282 (`\int_new:N \g_table_day_int`, `\int_do_until:nNnn`) | yes, by unrolling | the counter only supplies the day number to the row label and to the day argument of `\KalDate`; an emitter writes rows 1 to 28 as literal rows `N & \KalDate[abbreviate=false,dayfmt=latin]{2018}{1}{N} & ...`, then the literal rows 29 to 31 already at :283-285 |
| `kalendarium.sty` (derived by DocStrip, `\jobname.sty` from the `package` part) | kalendarium.ins:48-50; kalendarium.dtx:79-82, :643-1277 | not bespoke | the zip is CTAN's release of this package, so it is the published way `front.datetime` (see Verdict); `\KalAbbrFormat` `\KalDayFormat` `\KalYearFormat` (:1274-1276) are its documented hooks, and the sample never redefines them: the three `\renewcommand` examples at :596, :613, :630 are typeset as text and their results typed by hand |
| DocStrip driver and guards | kalendarium.dtx:3-78; kalendarium.ins:15-51 | not typeset | the `internal`, `install` and `readme` parts only write files (`.ins`, `.sty`, README.txt); they print nothing in the manual |

## Content-opaque
none (no TikZ or other drawing; the Latin date strings, the two month tables and the weekday symbol table at :190-287 are text content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Considered and kept inside existing ways: `kalendarium` as `front.datetime` (same effect type as the merged `datemultical`: a y/m/d date printed in a named calendar); considered `mark.numspell` (Latin numerals) and rejected, because the package prints whole dates, not numbers.
- `makeindex` is needed for the `\PrintIndex` page (kalendarium.dtx:1285), as for `idx.makeidx` and the BibTeX ways; no `\PrintChanges` appears, so no change-history pass. Not counted as EXTERNAL because the lib already accepts this tool type.
- `kalendarium.pdf` (the shipped compiled manual) was not read. The `.ins` was read in full (kalendarium.ins:1-71).
