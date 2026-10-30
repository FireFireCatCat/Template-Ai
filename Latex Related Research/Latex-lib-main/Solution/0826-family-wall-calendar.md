no

# 0826-family-wall-calendar: Family Wall Calendar (class `famcal`)

- Unverified: read from the source, not compiled.
- Source: Source/0826-family-wall-calendar/ (origin: https://latextemplates.com/downloads/family-wall-calendar.zip; licence: MPL-2.0; main.tex:1-2 names github:ArneMeier/famcal as upstream)
- Kind: calendar
- Lib: v6
- Engine: pdfLaTeX-compatible (main.tex:5-6 says pdflatex-safe; famcal.cls:114-118 has a LuaTeX branch through `iftex`; XeLaTeX is not stated, although the manifest hint lists it)
- Look carried by: zip-local (famcal.cls defines the whole page; main.tex holds only `\documentclass{famcal}` and one `\makeFamCal` call)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (famcal.cls, 235 lines, read in full)

## Verdict
`no`. The look is carried by the zip-local class `famcal`, which is not published: ctan.org/pkg/famcal returns 404, main.tex:2-3 says it is not in TeX Live, and the zip is a latextemplates.com bundle, not an official release. `\makeFamCal` draws each of the 12 month pages as a TikZ `\calendar` picture with a hand-written `day code` (template-defining artwork, `ART`), and it decides which days are coloured with julian-date counters and a global boolean (irreducible bespoke logic). No lib way takes a list of date ranges or draws a day list with one column per person. Only the shell (scrartcl load, colours, language option, page style) reduces to lib ways.

## Blockers
- `BESPOKE/class` vacation test: `\checkvacation`, `\checkvacations`, `\splitdaterange`, counters `\startjulian` `\endjulian` `\checkjulian`, flag `\ifvacation`; hand-rolled julian-date comparison and a global conditional that drive the fill colour of every day (famcal.cls:52-58, 64-108, 214-218)
- `ART/class` `\makeFamCal`: one `tikzpicture` per month with a `\calendar` and a custom `day code` of circle and box nodes plus a row of name nodes; this is the template's whole identity (famcal.cls:180-235, called at main.tex:17)
- `BESPOKE/class` `\makeFamCal` layout algorithm: family size counted by a `\foreach` (famcal.cls:182-184) and the column width `\boxsize` computed from it with `\dimexpr` (famcal.cls:61, 196, 225)
- `UNMAPPED/class` calendar page: no lib way covers a vertical per-day list with one named column per person and highlighted date ranges (`cal.kalender` is a fixed German year grid, `cal.termcal` and its `calendar-grid` parameter are week or month grids whose day hooks would need redefining, `cal.litetable` and `cal.chronology` are other layouts) (famcal.cls:202-231)
- `ART/class` `\randomdots` random-bubble page background, active only under option `theme-bubbles`: 101 random nodes with random sizes and colours (famcal.cls:113-129, 169-175). The sample selects no option, so this branch is dormant for main.tex, but it is class code in scope and cannot be reduced. The verdict does not rest on it alone.

## Class setting
- Class: `class.famcal` (zip-local, so it fails W1 and is recorded for its vocabulary only; main.tex:14) over `class.scrartcl` (famcal.cls:49: `\LoadClass[fontsize=14pt,a4paper,DIV=20]{scrartcl}`). Class options: `theme-bubbles` (famcal.cls:37-39), `german` (famcal.cls:42-45, passed to `babel` and `translator`), processed by `\ProcessOptionsX*` (famcal.cls:47). main.tex passes none.
- Class-native vocabulary used: `\makeFamCal{year}{comma list of names}{comma list of YYYY-MM-DD/YYYY-MM-DD ranges or single dates}` (main.tex:17; defined famcal.cls:180). Also defined by the class and not used by the sample: `\theme`, `\bgtheme`, `\randomdots{c1}{c2}`, colours `vacation` `weekends` `bgdots` `bglightblue` (famcal.cls:30-33, 36, 113, 169).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:14; famcal.cls:49 | `class.scrartcl` | via famcal; `fontsize=14pt`, `a4paper`, `DIV=20` |
| paper and size | famcal.cls:49 | `page.class-options` | `a4paper`, `fontsize=14pt` |
| text area | famcal.cls:49 | `page.typearea` | `DIV=20` |
| colours | famcal.cls:6, 30-33 | `color.xcolor` | `\colorlet` vacation=green!75!white, weekends=red!75!black, bgdots=blue!50!black, bglightblue=white!91!blue |
| input encoding | famcal.cls:10 | `font.fontenc-t1` | `inputenc` option `utf8` |
| language | famcal.cls:14, 42-45 | `lang.babel` | loaded without language option; `german` passed through when selected |
| language strings | famcal.cls:15, 42-45 | `lang.translator` | loaded; `german` passed through when selected |
| page style | famcal.cls:188 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (set inside the month loop) |
| page break per month | famcal.cls:233 | `pg.break` | `\newpage` after each month picture |
| month heading text | famcal.cls:207 | `font.size-commands`, `mark.kernel` | `\large`, `\bfseries` inside `month text` |
| page colour per month (theme-bubbles only) | famcal.cls:11, 171-172 | `color.pagecolor` | `\newpagecolor{<month colour>!10!white}` |
| page overlay (theme-bubbles only) | famcal.cls:25, 173 | `bg.eso-pic` | `\AddToShipoutPictureBG*{...}`; content is `\randomdots`, ART |
| calendar pages (12 months) | famcal.cls:180-235; main.tex:17 | `art.tikz` (restricted; ART, no lib way) | pgf `calendar` library: `dates=Y-M-01 to Y-M-last`, `day list downward`, `day yshift=1.55em`, `month label left vertical`, `every month/.append style={yshift=1em}`, `if (Saturday) [weekends]`, `if (Sunday) [weekends]`, custom `day code` (famcal.cls:203-230) |
| person header row | famcal.cls:191-201 | `art.tikz` (part of the picture) | nodes `fill=white`, `rounded corners`, `minimum width=\boxsize`, `minimum height=1.6em` |
| day bubbles and person boxes | famcal.cls:220-226 | `art.tikz` (part of the picture) | circle nodes `minimum size=0.8cm`, `opacity=0.93`, fill `vacation` or `white`; per person a `draw=black` box `minimum height=1.55em` |
| vacation highlighting | famcal.cls:64-108, 213-218 | none (BESPOKE/class) | see Bespoke code |
| random dots background | famcal.cls:113-129 | `art.tikz` (ART, theme-bubbles only) | see Bespoke code |
| front matter, headings, lists, floats, tables, maths, code, notes, bibliography | main.tex:16-18 | none used | the body holds only the `\makeFamCal` call |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\checkvacation`, `\checkvacations`, `\splitdaterange`, `\startjulian` `\endjulian` `\checkjulian`, `\ifvacation` | famcal.cls:52-58, 64-108 | No | julian-date counters, `\ifnum` range test and a global flag decide each day's colour; no lib way takes a date-range list. |
| `\makeFamCal` | famcal.cls:180-235 | No | a loop over 12 months emitting a TikZ `\calendar` with a custom `day code`; template-defining picture (ART) plus counted columns. |
| `\boxsize` and the family-size count | famcal.cls:61, 182-184 | No | `\dimexpr` arithmetic on `\linewidth` and a counted list length size every column inside the picture; belongs with `\makeFamCal`. |
| `\randomdots` | famcal.cls:113-129 | No | 101 nodes with `rand`-driven size, position and colour, seeded by `\pdfrandomseed` or `\directlua`; not a watermark way, output differs per run. |
| `\monthcolorname`, `\monthcolorrgb`, `\bgtheme` | famcal.cls:135-175 | Table: yes, whole: no | the 12 RGB values reduce to `\definecolor` calls (`color.xcolor`) and `\newpagecolor` (`color.pagecolor`), but their only use is the per-month overlay with `\randomdots`. |
| `\theme`, option `theme-bubbles`, option `german`, `\ProcessOptionsX*` | famcal.cls:36-47 | `german`: yes; `theme-bubbles`: no | `german` is `lang.babel` and `lang.translator` option passing; `theme-bubbles` only switches on the `\randomdots` branch. |
| `\LoadClass{scrartcl}` call | famcal.cls:49 | Yes | `class.scrartcl` with `fontsize=14pt,a4paper,DIV=20`. |
| `\colorlet` defaults | famcal.cls:30-33 | Yes | `color.xcolor` colour definitions. |

## Content-opaque
none (the names and date ranges in main.tex:17 are macro arguments, content; the calendar picture is the template, not a figure).

## Lib changes
- New ways proposed: none. Considered: the pgf `calendar` library (`\calendar`, part of `art.tikz`; W2 fails because the day look is `day code`, which is TikZ code, not option values); `xkeyval`, `xstring`, `ifthen`, `iftex`, `pgffor`, `pgfcalendar` (programming aids with no printed effect; the macros they serve are the bespoke items above).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
