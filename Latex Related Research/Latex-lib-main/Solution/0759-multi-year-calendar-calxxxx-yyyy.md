no

# 0759-multi-year-calendar-calxxxx-yyyy: Multi-Year Calendar (calxxxx-yyyy)

- Unverified: read from the source, not compiled.
- Source: Source/0759-multi-year-calendar-calxxxx-yyyy/ (origin: https://latextemplates.com/downloads/calxxxx-yyyy.zip; licence: LPPL-1.3c)
- Kind: calendar
- Lib: v6
- Engine: pdfLaTeX-compatible (kernel `report`, `babel`, `geometry`, `array`; no fontspec or Lua code; the only non-ASCII text sits in comments and in the German name `März`, main.tex:12-13, 112)
- Look carried by: preamble (the whole zip is one `main.tex`, a standalone `.tex` program that defines its own calendar macros before `\begin{document}`; there is no class or style file)
- Class origin: tex-distribution-unbundled (kernel `report`, not shipped in the zip)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The look of this zip is a calendar that TeX computes itself: a hand-written day-of-week formula, a leap-year test, per-month row strings and an `\ifcase` that picks which row string lands on which weekday, all on `\newcount` registers and `\newif` switches (main.tex:67-85, 154-228), plus a year loop on a counter (main.tex:326-336). That is hand-rolled counters and conditionals that drive what is printed, which the rubric calls irreducible. The page furniture around it (class `report`, `geometry`, `babel`, `array` tabular, font switches) maps to lib ways, but the multi-year month-grid component has no lib way: `cal.kalender` is a fixed one-year German grid and `cal.termcal` is a term of weeks. The published CTAN file `calxxxx-yyyy` is not a way either (see Lib changes), and this copy is patched by latextemplates.com (main.tex:274-287). The answer is `no`.

## Blockers
- `BESPOKE/preamble` calendar engine: `\dayofweek` (main.tex:154-174), `\setleap` (main.tex:177-189), `\rows` (main.tex:192-208), `\Month` with its `\ifcase\x` weekday dispatch and the German and Danish copies (main.tex:212-271), `\printyear` with the B.C./A.D./Julian heading logic (main.tex:300-315): counter arithmetic and conditionals decide which day number is printed in which cell
- `BESPOKE/body` year-range loop: `\newcounter{year}`, `\loop ... \ifnum\value{year}<\YearZ ... \stepcounter{year} ... \repeat` calls `\printyear` once per year (main.tex:326, 329-336)
- `UNMAPPED/body` the multi-year, transposed month-grid page (three months per row, weekday letters down the left, day numbers across, years side by side; main.tex:211-228, 306-314): no lib way produces it (`cal.kalender` one German year, `cal.termcal` term weeks; considered `calendar-grid`, see Lib changes)

## Class setting
- Class: `class.report` options: `12pt`, `a4paper`, `ngerman`, `danish`, `english` (the last language option is the main language, main.tex:55-56); class date guard `[2025/01/22]`
- Class-native vocabulary used: none (no `\chapter`, `\maketitle`, `abstract` or `titlepage`; the document is one page of `minipage` calendars, main.tex:328-352)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:55 | `class.report` | 12pt, a4paper, ngerman, danish, english |
| language | main.tex:58-59 | `lang.babel` | `\usepackage{babel}[2025/12/11]`, languages from the class options, `\selectlanguage{english}` |
| page size and text block | main.tex:60 | `page.geometry` | a4paper, textwidth=\paperwidth, textheight=\paperheight (text block as big as the sheet) |
| margin offsets | main.tex:137 | `page.setlength` | `\topmargin`=-1in, `\oddsidemargin`=-1in (the comment says "no margins"); set after `geometry`, whose interplay is not checked |
| page style | main.tex:63 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` placed before `\begin{document}` |
| font sizes and shapes | main.tex:91-93 | `font.size-commands`, `mark.kernel` | year `\normalsize\bfseries`, month `\scriptsize\scshape`, day block `\tiny` (aliases `\yearfont` `\monthfont` `\dayfont`) |
| day-name marks | main.tex:103-104 | `mark.kernel` | `\textbf{S}`, `\textbf{M}`, ... (German `\textbf{Mo}` etc., main.tex:116-117) |
| spacing | main.tex:138, 214, 309 | `sp.manual-space`, `sp.lengths` | `\sm`=`\hspace{2pt}`, `\setlength{\tabcolsep}{0pt}`, `\\[.5ex]` after the year |
| month table | main.tex:61, 215-228 | `tbl.tabular` | `array`; `tabular*{7em}{\|>{\centering}p{\Wd}\|@{\extracolsep{\fill}}rrrrrr\|}`, `\multicolumn{7}{l}` month name, `\hline` top and bottom |
| centred first column | main.tex:215 | `sp.ragged` | `>{\centering}` in the `p{\Wd}` column |
| year block | main.tex:306-315 | `box.minipage` | `minipage` of width `.3\paperwidth`, `\dayfont` inside |
| widest day-name width | main.tex:290-297 | `sp.lengths` | `\settowidth` of each day name and `\ifdim` max into `\Wd`; consumed by the engine, see Bespoke code |
| credit line | main.tex:339-349 | `font.size-commands`, `sp.manual-space` | `\tiny`, `\newline`, `\indent`; text and `\iflanguage` choice of translator credit are content |
| calendar arithmetic and grid | main.tex:154-228, 300-336 | none | BESPOKE, UNMAPPED (see Blockers) |

No heading, list, theorem, float, caption, code, bibliography, index, front-matter, abstract, contents or cross-reference component occurs in the zip.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\dayofweek` (Julian/Gregorian and zero-year branches on `\count` registers) | main.tex:154-174 | no | computes a weekday from a year and month by counter arithmetic; no lib way holds a date algorithm |
| `\setleap`, `\ifleap` | main.tex:177-189 | no | leap-year conditional on `\count` registers, drives February's row strings |
| `\rows` (`\rone`..`\bseven` strings of `&` and day numbers) | main.tex:192-208 | no | row content chosen by month and leap flag; ampersands come out of macro expansion |
| `\Month` and its German and Danish redefinitions | main.tex:212-271 | no | `\ifcase\x` selects which row macro sits on which weekday line; tabular built by expansion |
| `\printyear` | main.tex:300-315 | no | heading branches on sign of year, `\ifZeroExist`, `\ifJulian`; prints 4 rows of 3 months |
| year loop (`\newcounter{year}`, `\loop`..`\repeat`) | main.tex:326, 329-336 | no | counter-driven repetition up to `\YearZ`; the emitter would have to compute the calendar itself |
| `\Year`, `\YearZ`, `\enteryear` | main.tex:280-287 | no | two year values feed the engine; `\typeout` only logs. The patch replaced the interactive `\typein` (main.tex:274-279) |
| `\SetWidth` | main.tex:290-297 | yes in isolation | widest of seven one-letter names in `\dayfont`: `box.eqparbox` equal-width tag or a fixed `\setlength`; its result only feeds `\Month` |
| name macros `\Jan`..`\Dec`, `\Mon`..`\Sun`, `\BC`, `\AD` and the `\iflanguage` chain | main.tex:97-134 | yes for one language | for English, plain strings (or `lang.translator` per-language strings); the per-language switch is a choice the emitter makes once |
| `\yearfont` `\monthfont` `\dayfont` `\sm` | main.tex:91-93, 138 | yes | aliases, expanded inline to `font.size-commands`, `mark.kernel`, `sp.manual-space` |
| `\cmscale` (cm ruler with `picture`, `\multiput`, `\newcounter{cms}`) | main.tex:318-324 | not printed here | `\CmRulefalse` (main.tex:147) and `\ifCmRule\cmscale` (main.tex:351) leave it off; if switched on it is picture-drawn artwork (`art.pstricks` family) and would be `ART/preamble`; not counted as a blocker because the sample never prints it |
| `\listfiles`, `\ProvidesFile`, `\NeedsTeXFormat`, `\typeout`, `\message` | main.tex:8-10, 62, 107, 285, 303-304 | yes | log and file-list output only, no printed effect |

Nothing in the zip is addressed to an AI.

## Content-opaque
none (no figure or table float; the calendars are the template's own body, not float content)

## Lib changes
- New ways proposed: none.
- Considered and not proposed: `calxxxx-yyyy` as a way (`cal.calxxxx-yyyy`). ctan.org/pkg/calxxxx-yyyy lists it as LPPL 1.3c, v20.26a, by H.-Martin Münch, so W1 holds for the published file; but the file itself says it is "no style file" (main.tex:27-28) and carries its own `\documentclass` (main.tex:55), so W4 fails (it cannot be written as preamble lines and body wrappers, only copied whole); its options are `\def` and `\newif` edits inside the file under "Safe Modifications" (main.tex:87-150), so W2 fails; and this zip's copy is patched (main.tex:274-287), so it is not the published file. The page's remark that it is loaded with `\usepackage` is the fetch tool's inference, not the page's statement, and contradicts the file.
- Considered and not proposed: `calendar-grid` (ctan.org/pkg/calendar-grid, LPPL 1.3c: LaTeX3 month and year grids with first weekday and compact layout; the page does not state a transposed month grid, so the look is not shown to be reachable); `cal.kalender` and `cal.termcal` (see Verdict).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
