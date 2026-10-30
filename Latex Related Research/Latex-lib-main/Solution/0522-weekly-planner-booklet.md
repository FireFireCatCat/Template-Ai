yes

# 0522-weekly-planner-booklet: Weekly Planner Booklet (TeXalendar `calendar` class)

- Unverified: read from the source, not compiled.
- Source: Source/0522-weekly-planner-booklet/ (origin: https://latextemplates.com/downloads/weekly-planner-booklet.zip; licence: MIT, README.md:22-24 and LICENSE:1-3)
- Kind: calendar
- Lib: v5
- Engine: needs XeLaTeX (calendar.cls:21-22 loads `polyglossia` and `fontspec` unconditionally; README.md:18 says xelatex; LuaLaTeX is not stated)
- Look carried by: zip-local (calendar.cls defines the whole look; main.tex has no preamble and only calls the class macros `\timetable` and `\weekpage`)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (calendar.cls 192 lines, localisation.tex 14 lines; main.tex 43 lines)

## Verdict
yes. The look is a zip-local class, `calendar.cls`, that is `\LoadClass[a5paper,12pt]{article}` plus `geometry`, `array`, `multirow`, `graphicx`, `xcolor` settings and a few `\newcommand` macros that expand to `tabular` rows. Every macro reduces by inline expansion or constant folding to a lib way with parameters (table, multirow, rotated label, rule strut, colour, page break), and there is no artwork. The nearest thing to logic is the `\daymonth` conditional that decides whether a side cell carries a month label; its inputs are literals in each `\weekpage` call, so an emitter resolves it before printing (see Bespoke code). Class origin is zip-local, so the zip's own `calendar.cls` is the source of the look, not a published class.

## Blockers
none

## Class setting
- Class: `class.article` options: `a5paper`, `12pt` (set by the zip-local class at calendar.cls:4; main.tex:10 only says `\documentclass{calendar}`). `calendar` is not on CTAN as a class: ctan.org/pkg/calendar is Frank Bennett's different package; this one is Enrico Miccoli's TeXalendar from GitHub (README.md:23-24), repackaged by latextemplates.com with a patched `main.tex` (main.tex:25-32), so it is not an official release.
- Class-native vocabulary used: none from `article` itself beyond kernel `center` and `\pagebreak`; the zip-local commands `\weekpage[keys]` (main.tex:33-41) and `\timetable{title}` (main.tex:15) are bespoke and reduced below.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | calendar.cls:4; main.tex:10 | `class.article` | a5paper, 12pt (via `\LoadClass`) |
| paper and type size | calendar.cls:4 | `page.class-options` | a5paper, 12pt |
| page geometry | calendar.cls:7-13 | `page.geometry` | landscape, top=4mm, bottom=4mm, left=0mm, right=0mm |
| page numbers | calendar.cls:28 | `pgnum.pagenumbering` | `\pagenumbering{gobble}` (style name `gobble`: no number printed); no header or footer text anywhere, default `plain` style |
| language support | calendar.cls:21 | `lang.polyglossia` | loaded with no options; no `\setmainlanguage` in the class or the sample, so no language is declared |
| font engine package | calendar.cls:22 | `font.fontspec` | load only; no `\setmainfont` anywhere, so no face is selected |
| day-name and month-label sizes | calendar.cls:45-47 | `font.size-commands` | `\footnotesize` (weekday name, month label), `\Large` (day number) |
| timetable title size | calendar.cls:118 | `font.size-commands` | `\Large` |
| small caps | calendar.cls:47; calendar.cls:118 | `mark.kernel` | `\scshape` for month label and timetable title |
| colours | calendar.cls:19; calendar.cls:50-51; calendar.cls:45-47; calendar.cls:90 | `color.xcolor` | `rulegray` and `rgray` both `cmyk` 0,0,0,0.5; `\textcolor{black}`, `\textcolor{rgray}`, `\color{rgray}`, page-table rules `\color{rulegray}` |
| timetable colour | calendar.cls:151 | `color.xcolor` | `\color{rgray!60}` (60 percent mix) |
| weekday strings | calendar.cls:34; localisation.tex:6-12 | `struct.input` | `\input{localisation.tex}`; the file only holds `\newcommand` string aliases Mon..Sun (and `\firstlabel`, `\secondlabel` at localisation.tex:13-14, never used) |
| week page grid | calendar.cls:89-103; calendar.cls:77-85 | `tbl.tabular` | 3 columns `p{5mm}@{}p{\wklxwdth}@{\vline}p{98mm}<{\rule[-2mm]{0pt}{\wkrowh}}`; `\cline{2-3}`, `\cline{3-3}`; 7 days of 3 rows each; `\setlength{\arrayrulewidth}{0.1mm}` (calendar.cls:43); widths 5mm, 98mm, 93mm (98mm minus 5mm, calendar.cls:37-40) |
| month label cell | calendar.cls:71-75 | `tbl.multirow` | `\multirow[c]{3}{*}{...}` spanning the 3 rows of a day |
| month label rotation | calendar.cls:73 | `fig.rotating` | `\rotatebox[origin=c]{90}` (graphicx, loaded at calendar.cls:15) |
| row-height strut | calendar.cls:92; calendar.cls:42 | `sp.rule` | `\rule[-2mm]{0pt}{\textheight / 21}`, an invisible rule (width 0pt) setting row height to textheight over 21 (three rules per day, calendar.cls:41) |
| week page wrapper | calendar.cls:108-110 | `sp.ragged` | kernel `center` environment (the `\centering` family) around the table |
| page ends | calendar.cls:111; calendar.cls:191 | `pg.break` | `\pagebreak` after each week page and after the timetable |
| timetable title line | calendar.cls:148-149 | `sp.rule`, `sp.manual-space`, `sp.lengths` | `\rule{5mm}{0pt}` at both ends, `\hfill` between the two copies of the title; `\noindent` (paragraph-indent control, filed with the `\parindent` family) |
| timetable grid | calendar.cls:155-188; calendar.cls:138-140 | `tbl.tabular` | 8 columns `R{10mm}` then six `C{25mm}` then `L{10mm}` separated by `\|`; strut `\rule[-2mm]{0pt}{5mm}` (calendar.cls:157); `\hline`, `\cline{2-7}`; 11 time rows 08:15 to 18:15 (calendar.cls:166-186) |
| timetable column types | calendar.cls:143-145 | `tbl.tabular` | `\newcolumntype{L,C,R}[1]` = `>{\raggedright or \centering or \raggedleft, \let\newline\\, \arraybackslash, \hspace{0pt}}m{#1}` (array package) |
| timetable column alignment | calendar.cls:143-145 | `sp.ragged` | `\raggedright`, `\centering`, `\raggedleft` inside the column prefixes |
| timetable zero-width spacer | calendar.cls:143-145 | `sp.manual-space` | `\hspace{0pt}` in the column prefixes |
| timetable vertical space | calendar.cls:153; calendar.cls:190 | `sp.manual-space` | `\medskip` above the grid, `\vfill` below it |
| sample body | main.tex:15; main.tex:33-41 | `tbl.tabular` | one `\timetable{Spring 2026}` and five `\weekpage{...}` calls; their keys are content (day numbers 5 to 11 up to 2 to 8, month names) |

Not present in the zip (no rows): headings, lists, quotes, notes, math, theorems, floats and captions, code, boxes, bibliography, index, front matter, abstract, contents, cross-references.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| layout-length macros `\wkmnthwdth` `\wkrxwdth` `\wklxwdth` `\wkrowh` | calendar.cls:37-42 | yes | constants 5mm, 98mm, 98mm - 5mm = 93mm, and textheight / 21 (the emitter knows the geometry, so it folds it to a number; `calc` at calendar.cls:20 only evaluates these two sums, considered: `calc`, load-only, no way proposed) |
| font aliases `\weekdayfont` `\numdayfont` `\monthfont` | calendar.cls:45-47 | yes | aliases of `font.size-commands` + `color.xcolor` + `mark.kernel`; expand inline |
| colour definitions | calendar.cls:50-51 | yes | two `\definecolor` calls, `color.xcolor` |
| key-value interface `\define@key{week}{...}` and `\setkeys{week}{...}` defaults | calendar.cls:54-68; calendar.cls:107 | yes | the keys only store day numbers and month labels into macros; the emitter substitutes the effective values into the expanded table (values persist between `\weekpage` calls because the keys are never reset, an emit-time state the emitter tracks: for example `newmonth=february` set at main.tex:39-40 stays set at main.tex:41, but `newday=8` keeps it from printing) |
| `\wkmultirow`, `\wkday` | calendar.cls:71-85 | yes | inline expansion to `\multirow` + `\rotatebox` and three `tabular` rows with `\cline`, `tbl.tabular` + `tbl.multirow` + `fig.rotating` |
| `\daymonth` conditional `\ifthenelse{\equal{#1}{#2}}{#3}{}` | calendar.cls:87; used at calendar.cls:95-101 | yes | decides only whether a day's side cell holds a month label or is empty; compares the row number with the literal `newday` value from the call, so the result is known at emit time and the emitter writes the label text or nothing (content selection, no layout effect). `xifthen` (calendar.cls:17) and `keyval` (calendar.cls:18) are load-only support for this macro and vanish after expansion |
| `\week` | calendar.cls:89-103 | yes | one `tabular`; inline |
| `\weekpage` | calendar.cls:106-112 | yes | `\begin{center}` + the `\week` table + `\pagebreak`; inline per call (main.tex:33-41) |
| `\tttitle`, `\timefont`, `\ttdayfont`, `\ttweekdays` | calendar.cls:117-136 | yes | aliases and a row of weekday-name cells; inline |
| timetable lengths `\ttcolwdth` `\tttimewdth` `\ttrowh` | calendar.cls:138-140 | yes | constants 25mm, 10mm, 5mm in the column specs |
| `\newcolumntype` L, C, R | calendar.cls:143-145 | yes | inline each column prefix in the column spec (`>{\centering\arraybackslash\hspace{0pt}}m{25mm}`), `tbl.tabular` + `sp.ragged` |
| `\timetable` | calendar.cls:147-192 | yes | one argument, the title (printed twice); the grid and the eleven time labels are fixed text; inline |
| weekday strings | localisation.tex:6-12 | yes | `\newcommand` string aliases; substitute the strings into the cells |
| `\pagenumbering{gobble}` | calendar.cls:28 | yes | kernel command with a style name that prints nothing (`pgnum.pagenumbering`) |

No `\def` of kernel internals, no output routine, no counter-driven logic, no expl3 or Lua code. The upstream generator `gencal.py` (README.md:13-16) is not shipped and the starter writes the calls by hand (main.tex:5-9), so there is no `EXTERNAL`.

## Content-opaque
none

## Lib changes
- New ways proposed: none (considered: `calc`, load-only length arithmetic that folds to constants; `xifthen` and `keyval`, load-only helpers of a macro that is expanded away; no `NEW:` way).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
