no

# 0687-fantasy-rpg-calendar: Fantasy / RPG Calendar (Calendar of Harptos, year 200)

- Unverified: read from the source, not compiled.
- Source: Source/0687-fantasy-rpg-calendar/ (origin: https://latextemplates.com/downloads/fantasy-rpg-calendar.zip; licence: LPPL-1.3c)
- Kind: calendar
- Lib: v5
- Engine: pdfLaTeX-compatible (expl3, TikZ/PGF and `zref-savepos`; no `fontspec`, no Lua; not compiled, so this is read from the source only)
- Look carried by: zip-local (the whole page is produced by three zip-local `.code.tex` files that `main.tex` `\input`s; the class adds only `paper=landscape`)
- Class origin: tex-distribution-unbundled (`scrartcl`, KOMA-Script; not in the zip, its source was not read)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (`fantasycalender.code.tex` 1966 lines, `fantasycalenderbase.code.tex` 1807 lines, `fantasycalendermoon.code.tex` 1199 lines, each read in full; there is no `.cls` or `.sty`)

## Verdict
The sample is 59 lines and only configures a zip-local calendar engine. The engine is three expl3 files, about 5000 lines in all. They compute dates (day-of-year to month, day and weekday, leap-year rules, ISO week, Easter and Advent), place every day cell by a hand-written layout calculation, and draw the month grids with TikZ nodes. That code is irreducible bespoke code, the grid is template-defining artwork, and the calendar component has no published way. The engine is not on CTAN (`ctan.org/pkg/fantasycalendar` and `ctan.org/pkg/fantasycalender` both return 404), so it fails W1 and is zip-local. It cannot be filed under the "configurable calendar-grid package" parameter of `cal.termcal`. The verdict is `no`.

## Blockers
- `BESPOKE/preamble` date-arithmetic engine in expl3: ordinal-to-date loop over cumulative month-length sequences (fantasycalenderbase.code.tex:587-630, 1184-1220, 1238-1274), ISO-style week number loop (:1320-1376), leap-year rule parser for the phrase `year divisible by N; but not ... divisible by M;` that builds `\cs_set:Npo` check macros (:360-376, :479-541, :548-579), Easter and Advent computations (:1398-1491, :1519-1546), and the `\ifdate` condition keys (:748-969). The files are zip-local code that main.tex loads from its preamble (main.tex:7); they play the role of a style file.
- `BESPOKE/preamble` layout engine in expl3 and PGF: the "fit" box-size calculation from `\textwidth` and `\textheight` (fantasycalender.code.tex:242-324), day-cell placement by week list and month list (:756-795, :807-859), label placement keys (:869-1143), phantom boxes (:693-738), a hand-written token scanner that replaces the TikZ calendar parser (:1820-1913), and task lines (:1622-1680).
- `BESPOKE/preamble` moon-phase code, loaded unconditionally (fantasycalender.code.tex:19). The sample never defines a moon (no `\NewFantasyMoon` in main.tex), so nothing is printed from it here. It holds `\fp_set:Nn ... cosd` phase maths (fantasycalendermoon.code.tex:108-204), moons drawn with `arc` paths (:208-266), and lcm and gcd search loops (:1044-1149).
- `ART/preamble` the month grids are TikZ pictures made of nodes: one `tikzpicture` per month (fantasycalender.code.tex:1770-1788), boxed day nodes (:455-487) and dashed phantom boxes (:562, :693-738). The grid is the template's identity, and no declarative lib way draws it.
- `UNMAPPED/preamble` calendar engine as a component: month names with lengths, weekday names, leap rule, yearly date entries (main.tex:11-54). Its only candidate way, `cal.termcal` with its parameter "another configurable calendar-grid package", needs a published package. Both CTAN reads returned 404.

## Class setting
- Class: `class.scrartcl` options: `paper=landscape` (main.tex:2)
- Class-native vocabulary used: none (no `\maketitle`, no sectioning, no `\setkomafont`; only the paper option)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:2 | `class.scrartcl` | paper=landscape |
| paper orientation | main.tex:2 | `page.class-options` | paper=landscape |
| page geometry | main.tex:4 | `page.geometry` | margin=1cm |
| colour package | main.tex:5; fantasycalendermoon.code.tex:25-26 | `color.color` | `\usepackage{color}`; `\textcolor{black}` and `\textcolor{white}` in the moon glyph text |
| file inclusion of the engine | main.tex:7; fantasycalender.code.tex:19; fantasycalendermoon.code.tex:12 | `struct.input` | `\input{fantasycalender.code}`, `\input fantasycalendermoon.code.tex`, `\input fantasycalenderbase.code.tex` (the files inputted are the blockers, not the command) |
| calendar-cell alignment | fantasycalender.code.tex:13-14, 468, 634-646 | `sp.ragged` | `ragged2e` loaded if absent; `\RaggedRight` (default), `\RaggedLeft`, `\Centering` inside the day `\parbox` |
| day-cell container | fantasycalender.code.tex:463-470 | `box.minipage` | `\parbox[c][height][t]{width}` holding `\fantasycalTextDay` (the box size comes from the bespoke "fit" code) |
| month and weekday heading fonts | fantasycalender.code.tex:453 | `font.size-commands`, `mark.kernel` | `\Large\bfseries` for month names (weekday font is empty by default, :447) |
| note fonts | fantasycalender.code.tex:1229, 1341 | `mark.kernel`, `font.size-commands` | `\sffamily` for yearly notes, `\small` for the note block |
| moon glyph text | fantasycalendermoon.code.tex:25-26 | `font.size-commands`, `mark.kernel` | `\tiny\textsf{...}` (not printed by this sample) |
| one month per page | fantasycalender.code.tex:1789-1791 | `pg.break` | `\newpage` after each month (key `newpage`, default true, :1713-1714, :1730) |
| load-only position package | fantasycalender.code.tex:15 | `xref.zref` | `\RequirePackage{zref-savepos}`; no `\zsavepos` call found in the zip |
| month grid, day nodes, dashed phantom cells, labels | fantasycalender.code.tex:1770-1788, 455-487, 693-738 | `art.tikz` (ART) | tikz keys set at :1774-1784: `week list`, `box size = fit`, `box draw = black`, `month label above centered`, `month add number = { [\%m0]}`, `weekday label above`, `add moons`, `add day notes`, `add year to month` |
| calendar data model (months, weekdays, leap year) | main.tex:11-24, 26-38, 41-45; fantasycalenderbase.code.tex:193-200, 279-287, 360-365 | none (UNMAPPED, BESPOKE) | `\FantasyCalendarAddMonths{4}{Hammer=31, ... Nightal=30}` (offset 4, twelve months), `\FantasyCalendarAddDays{first-day ... tenth-day}` (ten-day week), `\DefineLeapYear{year divisible by 4;}{Hammer=+1}` |
| festival and yearly notes | main.tex:49-54; fantasycalender.code.tex:1239-1241, 1342-1357 | none (UNMAPPED, BESPOKE) | `\FantasyCalendarDateEntry{1-31}{Midwinter}` and five more; notes print inside the day cell after the number |
| year print command | main.tex:58; fantasycalender.code.tex:1735-1751 | none (UNMAPPED, BESPOKE) | `\PrintFantasyCalendarYear {200} { }`, loops over months 1 to `nr_months_per_year` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| ordinal and ISO date conversion, year search loop | fantasycalenderbase.code.tex:587-630, 1066-1119, 1184-1274 | no | computes dates with `\int_do_until`-style loops over cumulative-day sequences; no lib way computes dates |
| leap-year rule parser | fantasycalenderbase.code.tex:360-376, 479-579 | no | token-delimited parser (`year ~ divisible ~ by ~ #2;`) that builds macros by `\cs_set:Npo` |
| week number, Easter, Advent | fantasycalenderbase.code.tex:1320-1376, 1398-1491, 1519-1546 | no | arithmetic algorithms in expl3 |
| `\ifdate` conditions as pgfkeys | fantasycalenderbase.code.tex:748-969 | no | key handlers that set a global boolean from the current ordinal |
| `\%` shorthand formatters | fantasycalenderbase.code.tex:1624-1748 | no | macros that print day, month, year, weekday and week number for the current date |
| cell-size "fit" calculation | fantasycalender.code.tex:242-336 | no | divides `\textwidth` and `\textheight` by the weekday count and computed row count |
| week-list and month-list placement | fantasycalender.code.tex:756-859 | no | per-day `\pgftransformxshift` and `yshift` from weekday and month offsets |
| calendar scanner | fantasycalender.code.tex:1820-1939 | no | reads `(name)`, `at`, `[options]`, `if` tokens by `\afterassignment` and `\let`, replacing the TikZ parser |
| tasks | fantasycalender.code.tex:1622-1680 | no (not used by the sample) | draws coloured margin lines by `\draw` with computed shifts |
| moon phases | fantasycalendermoon.code.tex:44-266, 635-665, 857-1149 | no (not used by the sample) | `cosd` fp maths, `arc` drawing, lcm search loops |
| `\FantasyCalendarAddMonths`, `...AddDays`, `\DefineLeapYear`, `\FantasyCalendarDateEntry`, `\PrintFantasyCalendarYear` | fantasycalenderbase.code.tex:193, 279, 360; fantasycalender.code.tex:1239, 1735 | no | these commands only feed the engine above; there is no lib way to receive them |

## Content-opaque
none (month, weekday and festival names at main.tex:11-54 are data; there are no figures or tables)

## Lib changes
- New ways proposed: none. Considered: `fantasycalendar` as a calendar-grid parameter of `cal.termcal`, rejected on W1 because both ctan.org/pkg reads returned 404 and the zip is a latextemplates.com repackaging of a GitHub repository (the README names https://github.com/Vidabe/FantasyCalendar, README.md:23); it would also fail W2 for the engine's hooks (`day code`, `month code`) that extend its code.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
