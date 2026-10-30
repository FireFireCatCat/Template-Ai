no

# 0487-calxxxx: calxxxx (card-size calendar of any year, AD or BC)

- Unverified: read from the source, not compiled.
- Source: Source/0487-calxxxx/ (origin: https://mirrors.ctan.org/macros/latex/contrib/calxxxx.zip; licence: other-nonfree, "License that prevents distribution" on ctan.org/pkg/calxxxx; readme.tex:154-156 allows copying only complete and unmodified)
- Kind: calendar
- Lib: v4
- Engine: pdfLaTeX-compatible (kernel article, `array`, `picture`; no fontspec, no Lua)
- Look carried by: preamble (the whole template is the TeX arithmetic and table-building macros in the stand-alone sample's own preamble; the class `article` carries nothing)
- Class origin: tex-distribution-unbundled
- Main file: calxxxx.tex (other samples: cal2000.tex, readme.tex; the manifest names readme.tex, but that only documents the two calendar programs)
- Read: main yes, zip-local classes and styles none present (the zip has no .cls, .sty, .def or .cfg; readme.pdf is the compiled readme and was not read)

## Verdict
`no`. calxxxx.tex is a stand-alone program, not a package: it computes the weekday of the first of each month and the leap year with `\newcount` arithmetic and `\ifnum`/`\ifcase` chains (calxxxx.tex:55-89), then picks which hand-defined row macros fill each month's `tabular*` (calxxxx.tex:92-127). Hand-rolled counters and conditionals drive what is printed, so this is irreducible `BESPOKE` code, and an emitter could only reproduce the document by copying that macro logic. No lib way holds a year calendar of this kind (`cal.kalender` and `cal.termcal` have other grids), and calxxxx itself fails W2 and W4 as a way (see Lib changes). cal2000.tex and readme.tex alone would be reducible (a hand-laid `tabular` of precomputed values, and plain article text); they do not change the verdict.

## Blockers
- `BESPOKE/preamble` calendar arithmetic: counters `\y \m \x \p \q`, switches `\ifleap \ifJulian \ifZeroExist`, weekday formula `\dayofweek`, leap test `\setleap`, month-length row definitions `\rows` (calxxxx.tex:11-17, 55-75, 78-89, 92-108)
- `BESPOKE/preamble` month and year assembly: `\Month` picks one of seven row orders with `\ifcase\x`; `\SetWidth` measures seven day letters with `\settowidth`/`\ifdim` to set the `p{\Wd}` column; `\printyear` builds the year heading with B.C./A.D./Julian conditionals (calxxxx.tex:111-127, 141-148, 151-161)
- `BESPOKE/preamble` year entry: `\enteryear` asks for the year with `\typein` inside a `\loop ... \repeat`, so the file needs a person at the terminal and does not run unattended (calxxxx.tex:130-138; the year is not an option value). A person is not an outside tool, so this is not recorded as `EXTERNAL`
- `ART/preamble` `\cmscale`: a `picture` ruler drawn with `\multiput`/`\put` and a counter-driven label (calxxxx.tex:164-170; the same code at cal2000.tex:39-45). It is switched off by default (`\CmRulefalse`, calxxxx.tex:48; cal2000.tex:32) but it is in the preamble, so it is recorded
- `UNMAPPED/preamble` the 3 by 4 grid of months with day columns, English names, Julian/Gregorian and zero-year options has no lib way: `cal.kalender` is a fixed German one-page grid with the year as its only value, `cal.termcal` is a calendar of weeks (calxxxx.tex:151-161)

## Class setting
- Class: `class.article` options: none (calxxxx.tex:6; cal2000.tex:9; readme.tex:1). Kernel class, not bundled, source not read.
- Class-native vocabulary used: calxxxx.tex and cal2000.tex use none (no `\maketitle`, no sectioning, no float); readme.tex uses `\section*`, `\subsection*` (readme.tex:9, 16).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | calxxxx.tex:6; cal2000.tex:9; readme.tex:1 | `class.article` | no options |
| page geometry | calxxxx.tex:38; cal2000.tex:18 | `page.setlength` | `\topmargin`=-1in, `\oddsidemargin`=-1in ("no margins") |
| page style | calxxxx.tex:8; cal2000.tex:11 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| no aux files | calxxxx.tex:8; cal2000.tex:11; readme.tex:2 | none (kernel `\nofiles`, no printed effect, so not a component; not a blocker) | none |
| month and year fonts | calxxxx.tex:24 | `font.size-commands` | `\yearfont`=`\normalsize`, `\monthfont`=`\scriptsize`, `\dayfont`=`\tiny` |
| month and year font shapes | calxxxx.tex:24, 34-35 | `mark.kernel` | `\bfseries`, `\scshape`, `\textbf{S}` day letters |
| spacing between months | calxxxx.tex:39, 155 | `sp.manual-space` | `\sm`=`\hspace{2pt}`, `\\[.5ex]` |
| paragraph start | calxxxx.tex:173 | `sp.lengths` | `\noindent` (nearest home, one paragraph without indent) |
| year block container | calxxxx.tex:152-161 | `box.minipage` | width `.5\textwidth` |
| month grid wrapper | calxxxx.tex:7, 113-117, 126-127 | `tbl.tabular` | `array`; `tabular*{7em}`; spec `\|>{\centering}p{\Wd}\|@{\extracolsep{\fill}}rrrrrr\|`; `\tabcolsep`=0pt; `\multicolumn{7}{l}`; `\hline` |
| month grid cells | calxxxx.tex:92-108, 118-125 | BESPOKE (not a lib way) | row macros `\rone`..`\bseven` chosen by `\ifcase\x`; see Bespoke code |
| calendar logic | calxxxx.tex:11-17, 55-89, 130-161 | BESPOKE (not a lib way) | see Bespoke code |
| cm ruler | calxxxx.tex:164-170; cal2000.tex:39-45 | `art.pstricks` (**ART**) | `picture`, `\unitlength`=1mm, `\multiput` ticks every 1 and 10 |
| credit line | calxxxx.tex:160; cal2000.tex:99-100 | `mark.kernel` | `\copyright`, `\texttt{...}` (content) |
| year table (cal2000) | cal2000.tex:10, 51-53, 61-63, 84, 101 | `tbl.tabular` | `array`; spec `\|r\|*{4}{*{3}{>{\centering}m{6pt}}\|}\|c\|rrrrrr\|c\|rrrrrr\|`; `\hline`, `\cline{14-27}`, `\multicolumn{7}{c\|}` |
| table spacing (cal2000) | cal2000.tex:20-21 | `tbl.tabular` | `\tabcolsep`=.6pt, `\arraystretch`=.9, `\extrarowheight`=1pt, `\doublerulesep`=2pt |
| table text sizes (cal2000) | cal2000.tex:23, 47 | `font.size-commands` | `\nsize`=`\tiny`, `\tsize`=`\scriptsize`; `\bfseries` (cal2000.tex:27-29) is `mark.kernel` |
| readme headings | readme.tex:9, 16, 26, 46, 80, 106, 152, 161 | `head.kernel` | `\section*`, `\subsection*`, default style |
| readme verbatim | readme.tex:11, 62-78 | `code.verbatim` | `\verb\|..\|`, `verbatim` environment (Pascal listing as text) |
| readme maths | readme.tex:4-5, 49-55, 83, 96-98 | `math.kernel` | `\[ \]`, `array{ll}` with `\left\{ \right.`, `\mbox`, `\displaystyle\frac`; `\rm` (readme.tex:4) is `mark.kernel` |
| readme line break hint | readme.tex:92 | `sp.manual-space` | `\linebreak[1]` (a line break, nearest home) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\dayofweek`, `\setleap`, counters and `\newif` switches | calxxxx.tex:11-17, 55-89 | no | counters and `\ifnum` chains compute the weekday and leap year that decide what prints; no lib way computes dates |
| `\rows`, `\rone`..`\bseven` | calxxxx.tex:92-108 | no | month-length-dependent row strings selected by `\ifnum\m=` chains |
| `\Month` | calxxxx.tex:111-127 | no | assembles the grid from `\ifcase\x` over the row macros; the `tabular*` shell alone is `tbl.tabular` |
| `\SetWidth` | calxxxx.tex:141-148 | no | measures seven boxes and keeps the widest to set a column width (a layout algorithm) |
| `\printyear` | calxxxx.tex:151-161 | no | year heading with sign, B.C., A.D., Julian and zero-year conditionals, then 12 `\Month` calls in a 3 by 4 order |
| `\enteryear` | calxxxx.tex:130-138 | no | interactive `\typein` loop that rejects year 0 when no zero year exists |
| `\cmscale` | calxxxx.tex:164-170; cal2000.tex:39-45 | no | `picture` ruler (**ART**); also `\newcounter{cms}` created inside the macro |
| safe-modification block: `\yearfont` `\monthfont` `\dayfont`, `\BC` `\AD`, `\Jan`..`\Dec`, `\Sun`..`\Sat`, `\sm`, `\Julianfalse`, `\ZeroExistfalse`, `\CmRulefalse` | calxxxx.tex:24, 28, 30-32, 34-35, 39, 42-43, 48 | yes, each alone | strings and font switches by inline expansion (`font.size-commands`, `mark.kernel`, `sp.manual-space`); they only set parameters of the irreducible code above |
| `\YearMonths`, `\Day`, `\nsize`, `\tsize` | cal2000.tex:23, 26-29 | yes | aliases; `\Day` is an `\ifcase` that picks one letter, expanded inline into `\bfseries S` etc. |
| cal2000 `tabular` of 31 year rows | cal2000.tex:51-101 | yes | one `tbl.tabular` with the spec in the map; the numbers are cell content (precomputed in the readme's Pascal code, readme.tex:62-78) |
| `\renewcommand{\div}`, `\newcommand{\mod}`, `\newcommand{\dfrac}` | readme.tex:4-5 | yes | inline `\rm\,div\,`, `\rm\,mod\,`, `\displaystyle\frac` in `math.kernel` |
| text after `\end{document}` (a `\cfrac` display) | readme.tex:168-170 | not needed | after `\end{document}` (readme.tex:164), never typeset |

## Content-opaque
none (the printed day numbers of calxxxx.tex are produced by the bespoke code, not held as content; the numbers in cal2000.tex are table cell content)

## Lib changes
- New ways proposed: none. Considered: calxxxx itself as a calendar way next to `cal.kalender` (it is on CTAN, so W1 holds, but it fails W2: the look is changed by editing definitions inside the file (calxxxx.tex:3-4, 20-52) and the year comes from a `\typein` prompt (calxxxx.tex:135), not from option values; and it fails W4: it is a stand-alone `\documentclass` file with no `.sty` (calxxxx.tex:6, 172-176), so an emitter would have to copy its macro logic into the preamble). Also considered, not proposed: the pgf `calendar` library (`art.tikz`, a drawing language, would not reproduce this grid by parameters alone).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
