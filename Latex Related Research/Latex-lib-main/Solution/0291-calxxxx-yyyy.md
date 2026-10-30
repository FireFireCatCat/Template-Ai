no

# 0291-calxxxx-yyyy: calxxxx-yyyy (multi-year calendar printer)

- Unverified: read from the source, not compiled.
- Source: Source/0291-calxxxx-yyyy/ (origin: https://mirrors.ctan.org/macros/latex/contrib/calxxxx-yyyy.zip; licence: LPPL 1.3c, README:34 and calxxxx-yyyy.tex:23-31)
- Kind: calendar
- Lib: v3
- Engine: pdfLaTeX-compatible (no fontspec, no Lua; babel with `ngerman`, `danish`, `english`, calxxxx-yyyy.tex:48,51). The years are read from the terminal with `\typein` (calxxxx-yyyy.tex:272,283).
- Look carried by: preamble (the whole look and the calendar logic are defined in the sample's own preamble, calxxxx-yyyy.tex:58-330; no zip-local class or style file exists)
- Class origin: tex-distribution-unbundled (kernel `report`, calxxxx-yyyy.tex:48; the class is not in the zip)
- Main file: calxxxx-yyyy.tex (other samples: calxxxx-yyyy-doc.tex, a one-page readme document; cal2026-2043_DE.pdf, cal2026-2043_DK.pdf, cal2026-2043_EN.pdf, calxxxx-yyyy-doc.pdf are compiled outputs and were not opened)
- Read: main yes, zip-local classes and styles none present

## Verdict
No. The package is a single `.tex` file that is itself the document: it computes the day of the week and leap years with TeX counters and `\ifnum` chains, builds the month grids from row strings selected by `\ifcase`, and asks the years at the terminal with `\typein`. That is hand-rolled counter and conditional logic that decides what is printed, so it is irreducible. The only near lib way, `cal.kalender`, is a different package (one-page German year grid, the year is its only value) and cannot produce this 3-by-4 month layout in English, German or Danish. The file itself as a way fails W2 and W4 (below). The page-level settings (class, geometry, fonts, babel, one `tabular*` per month) all map to lib ways; the calendar engine does not.

## Blockers
- `BESPOKE/preamble` day-of-week and leap-year arithmetic in counters `\y \m \x \p \q` and `\newif\ifleap\ifJulian\ifZeroExist` (calxxxx-yyyy.tex:60-74, 147-167, 170-182)
- `BESPOKE/preamble` month-row generator `\rows` and the month grid `\Month`, which picks one of seven row orders by `\ifcase\x`; it is copied once per language for the Monday-first languages (calxxxx-yyyy.tex:185-201, 205-221, 225-241, 243-259)
- `BESPOKE/preamble` year block `\printyear` and the width scan `\SetWidth` that keeps the widest of seven day names in `\Wd` (calxxxx-yyyy.tex:294-301, 304-319)
- `BESPOKE/preamble` interactive year entry `\enteryear`: `\typein` loops that validate the start and end year (calxxxx-yyyy.tex:267-291); the values that decide the document are terminal answers, not options
- `BESPOKE/body` driver loop `\loop ... \repeat` over counter `year` that prints one year block per step (calxxxx-yyyy.tex:333-340)
- `ART/preamble` `\cmscale`, a `picture` ruler with `\multiput` tick marks, switched on by `\CmRuletrue` (calxxxx-yyyy.tex:322-328, 141, 355); off by default (calxxxx-yyyy.tex:140), but part of the file's look
- `UNMAPPED/body` a multi-year, multi-language (English, German, Danish), Gregorian or Julian month-grid calendar has no lib way. `cal.kalender` was considered and rejected: its German names and one-page grid are fixed. `calxxxx-yyyy` itself as a new way is published (CTAN, README:48-49) but fails W2 (looks are chosen by editing the "Safe Modifications" block, calxxxx-yyyy.tex:80-143, and a new language by editing the code at calxxxx-yyyy.tex:121-125 and 260-262) and W4 (it is a whole document with its own `\documentclass` at calxxxx-yyyy.tex:48 and `\begin{document}` at 332, not loadable by `\usepackage`, and the years cannot be printed as preamble lines or a body wrapper). Not written as a NEW way.

## Class setting
- Class: `class.report` options: `12pt`, `a4paper`, `ngerman`, `danish`, `english` (the last language option is the main language, calxxxx-yyyy.tex:48-50); version guard `[2025/01/22]`
- Class-native vocabulary used: none. No `\chapter`, no `\maketitle`, no `abstract`; only `\thispagestyle{empty}` (calxxxx-yyyy.tex:56). The `report` class is not in the zip; its source was not read.
- Second sample: `class.article`, no options (calxxxx-yyyy-doc.tex:4).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | calxxxx-yyyy.tex:48 | `class.report` | 12pt, a4paper, ngerman, danish, english |
| language | calxxxx-yyyy.tex:51-52 | `lang.babel` | `\usepackage{babel}[2025/12/11]` with the class language options; `\selectlanguage{english}` (ngerman or danish also possible) |
| language switch for strings | calxxxx-yyyy.tex:99-127, 223-264, 346-352 | `lang.babel` (`\iflanguage` test) | selects the month, day and "B.C." string set per language; the string sets and the lookup are bespoke (see Bespoke code) |
| page geometry | calxxxx-yyyy.tex:53 | `page.geometry` | a4paper, textwidth=\paperwidth, textheight=\paperheight |
| margins | calxxxx-yyyy.tex:130 | `page.setlength` | \topmargin=-1in, \oddsidemargin=-1in |
| page style | calxxxx-yyyy.tex:56 | `hf.pagestyle-kernel` | \thispagestyle{empty}, written before `\begin{document}` |
| year, month, day fonts | calxxxx-yyyy.tex:84-86 | `font.size-commands`, `mark.kernel` | \yearfont=\normalsize\bfseries; \monthfont=\scriptsize\scshape; \dayfont=\tiny |
| inter-month space | calxxxx-yyyy.tex:131 | `sp.manual-space` | \sm=\hspace{2pt} |
| month grid table | calxxxx-yyyy.tex:207-221 | `tbl.tabular` | `array` loaded (calxxxx-yyyy.tex:54); `tabular*{7em}`, columns `\|>{\centering}p{\Wd}\|@{\extracolsep{\fill}}rrrrrr\|`, `\multicolumn{7}{l}` month name, `\hline`; \tabcolsep=0pt (`sp.lengths`). The cell content comes from the bespoke row logic |
| day-name column alignment | calxxxx-yyyy.tex:208 | `sp.ragged` | `>{\centering}` |
| table cell spacing | calxxxx-yyyy.tex:207 | `sp.lengths` | \tabcolsep=0pt |
| year block | calxxxx-yyyy.tex:310-319 | `box.minipage` | width .3\paperwidth; year heading with \yearfont, `\\[.5ex]` (`sp.manual-space`) |
| year counter | calxxxx-yyyy.tex:330,334,338 | `num.counters` | \newcounter{year}, \setcounter, \stepcounter (drives the loop, see Bespoke code) |
| credit line | calxxxx-yyyy.tex:343-353 | `font.size-commands`, `mark.kernel` | \tiny, \texttt; text in three languages |
| cm ruler | calxxxx-yyyy.tex:322-328 | `art.pstricks` (picture) | \unitlength=1mm, \put, \multiput, \line, \makebox; ART, default off |
| month, weekday, B.C. strings | calxxxx-yyyy.tex:90-120 | none (data, see Bespoke code) | English, German, Danish name sets |
| day-of-week, leap, rows, loop, year entry | calxxxx-yyyy.tex:147-201, 205-259, 267-291, 294-319, 333-340 | none: BESPOKE | see Bespoke code |
| log listing | calxxxx-yyyy.tex:55 | none (`\listfiles`, writes the log only, no PDF effect) | |
| readme: class | calxxxx-yyyy-doc.tex:4 | `class.article` | no options |
| readme: PDF metadata and links | calxxxx-yyyy-doc.tex:5-19 | `meta.hyperref` | extension=pdf, plainpages=false, pdfpagelabels=true, hyperindex=false, pdflang={en}, pdftitle, pdfauthor, pdfsubject, pdfkeywords, pdfview=Fit, pdfstartview=Fit, pdfpagelayout=SinglePage, bookmarksopen=true; `\url` (calxxxx-yyyy-doc.tex:29,53,56,69-70,74) comes from hyperref |
| readme: page style | calxxxx-yyyy-doc.tex:20 | `hf.pagestyle-kernel` | empty |
| readme: heading | calxxxx-yyyy-doc.tex:22 | `head.kernel` | \section* |
| readme: list | calxxxx-yyyy-doc.tex:68-71 | `list.kernel` | description with `--` labels |
| readme: marks | calxxxx-yyyy-doc.tex:22,27 | `mark.kernel` | \texttt, \textsf, \textsc |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\dayofweek`, `\setleap`, counters `\y \m \x \p \q`, flags `\ifleap \ifJulian \ifZeroExist \ifCmRule` | calxxxx-yyyy.tex:60-74, 147-182 | No | Date arithmetic (a day-of-week formula with a Julian switch and a zero-year switch) done in TeX counters; its result selects the printed rows. No lib way computes dates (`front.datetime` prints named dates, it does not derive weekdays for a grid) |
| `\rows` | calxxxx-yyyy.tex:185-201 | No | Builds the seven row strings and shortens them for 28, 29 or 30 day months with nested `\ifnum`; conditionals drive what is printed |
| `\Month` (English, and German and Danish copies) | calxxxx-yyyy.tex:205-221, 225-241, 243-259 | No | One `tabular*` per month whose rows are chosen by `\ifcase\x`; the table shell itself is `tbl.tabular` but the body is generated text. The three variants differ only in the order of the weekday names (Sunday first, or Monday first) |
| `\SetWidth` | calxxxx-yyyy.tex:294-301 | No | Seven `\settowidth` measurements and `\ifdim` maximum into `\Wd`, which sets a column width |
| `\printyear` | calxxxx-yyyy.tex:304-319 | No | Assembles one year: heading with "B.C." or "(Julian)" decided by `\ifnum`, `\ifZeroExist`, `\ifJulian`, then twelve `\Month` calls |
| `\enteryear` | calxxxx-yyyy.tex:267-291 | No | `\typein` loops with validation; the years are not a document option, so an emitter has nothing to print for them |
| main loop `\loop ... \repeat` with `\stepcounter{year}` | calxxxx-yyyy.tex:333-340 | No | Counter-driven repetition that decides how many year blocks exist |
| `\cmscale` | calxxxx-yyyy.tex:322-328 | No (ART) | `picture` ruler; declared `\newcounter{cms}` inside the macro (calxxxx-yyyy.tex:324) |
| language string sets `\Jan`..`\Dec`, `\Sun`..`\Sat`, `\BC`, `\AD` | calxxxx-yyyy.tex:90-120 | Data only | Plain strings per language (English, German, Danish) that could be written as per-language definitions; the number-to-name lookup `\ifcase\m ... \or\Jan...` (calxxxx-yyyy.tex:210) stays in the irreducible `\Month` |
| `\yearfont`, `\monthfont`, `\dayfont`, `\sm` | calxxxx-yyyy.tex:84-86, 131 | Yes | Aliases for kernel font switches (`font.size-commands`, `mark.kernel`) and `\hspace` (`sp.manual-space`) |

## Content-opaque
none beyond the calendar data itself: month and weekday names and the credit text are strings (calxxxx-yyyy.tex:90-120, 343-353).

## Lib changes
- New ways proposed: none. Considered and rejected: `cal.kalender` (a different, fixed-grid package, see Blockers); the file `calxxxx-yyyy.tex` as a way (fails W2 and W4, see Blockers).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
