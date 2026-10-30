no

# 0486-semesterplannerlua: semesterplannerLua (timetable, appointment and calendar package)

- Unverified: read from the source, not compiled.
- Source: Source/0486-semesterplannerlua/ (origin: https://mirrors.ctan.org/macros/luatex/latex/semesterplannerlua.zip; licence: LPPL 1.3)
- Kind: calendar
- Lib: v4
- Engine: needs LuaLaTeX (`\directlua` and `luapackageloader` at load time: semesterplannerlua.dtx:105, 443, 544-545)
- Look carried by: zip-local (the look is defined by the package source in the zip: the `package` code of semesterplannerlua.dtx plus two Lua modules; there is no class and no `.tex` sample, the zip is the CTAN package itself)
- Class origin: tex-distribution-unbundled
- Main file: semesterplannerlua.dtx (documentation driver at 32-47, usage examples at 242-249 and 284-295; other samples: none)
- Read: main yes, zip-local classes and styles all (no `.cls` or `.sty` present: the `.sty` is generated from the dtx, so its code was read from the dtx `package` guard at 437-902, plus `semesterplannerlua_timetable.lua`, `semesterplannerlua_calendar.lua`, `semesterplannerlua_dmenu.lua`, `semesterplannerlua.ins`, `README.md`)

## Verdict
The zip is the published CTAN package `semesterplannerlua` itself (CTAN page read: LPPL 1.3, in TeX Live and MiKTeX), not a document template, so its way is the package: `cal.semesterplannerlua` passes W1 to W4 (key=value `timetable` and calendar environments, `\usepackage` plus body wrappers). The verdict is `no` because of one `EXTERNAL/package` blocker: `semesterplannerlua_calendar.lua` begins with `require "date"` (a Lua module that is neither in the zip, nor in the README or the documentation, nor named on the CTAN page) and the package loads that file unconditionally, through `luapackageloader`, which exists to pull in system Lua modules (for example from LuaRocks). So the document does not build without a Lua library from outside TeX, even if it never prints a calendar. I did not establish that TeX Live ships a Lua module named `date`; I could not check a TeX installation here. The TikZ drawing and the Lua layout code are the package's own published implementation, not zip-local bespoke code of a template, so they are not counted as `BESPOKE` or `ART`.

## Blockers
- `EXTERNAL/package` the calendar module needs the Lua module `date` from the system Lua path: `local dateLib = require "date"` (semesterplannerlua_calendar.lua:1), loaded at package load by `\directlua{cal = require("semesterplannerLua_calendar.lua")}` (semesterplannerlua.dtx:545) after `\RequirePackage{luapackageloader} % use the default lua path as well` (semesterplannerlua.dtx:443); the dependency is not listed in README.md:26-29 or in the abstract (semesterplannerlua.dtx:104-105, which names `xcolor`, `fontawesome`, `tikz`, `pgfkeys` only)

Recorded, not blockers:
- File name case: the package requires `semesterplannerLua_timetable.lua` and `semesterplannerLua_calendar.lua` (semesterplannerlua.dtx:544-545; README.md:26-27), while the zip ships `semesterplannerlua_timetable.lua` and `semesterplannerlua_calendar.lua` (lower-case `l`); only a case-sensitive file system would notice.
- `semesterplannerlua_dmenu.lua` is a standalone `texlua` script that reads the written `\jobname-data.dat` and calls `dmenu`, `xsel`, `notify-send` (semesterplannerlua_dmenu.lua:39-46, 138, 148-155; README.md:37-43). The document never loads it, so it is outside the template; it is not an `EXTERNAL` blocker.

## Class setting
- Class: `class.ltxdoc` options: none (semesterplannerlua.dtx:33); this is the documentation driver's class, the package itself works under any class.
- Class-native vocabulary used: `\DocInput` (43), `\EnableCrossrefs` (39), `\CodelineIndex` (40), `\RecordChanges` (41), `\PrintChanges` (44), `\PrintIndex` (45), `\CheckSum` (50), `\CharacterTable` (52-66), `\changes` (69-80), `\DoNotIndex` (83), `\GetFileInfo` (86) with `\fileversion` `\filedate` (92), `\DescribeEnv` (114) and `\DescribeMacro` (156-168), `macro` and `environment` wrappers around `macrocode` (456-468, 690-814), `\Finale` (908), and the `|...|` short verbatim used throughout the text. Source of `ltxdoc` not read (LaTeX base).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | semesterplannerlua.dtx:33 | `class.ltxdoc` | no options (documentation driver) |
| page geometry (driver) | semesterplannerlua.dtx:34 | `page.geometry` | a4paper, margin=25mm, left=50mm, nohead |
| documentation machinery | semesterplannerlua.dtx:35, 39-45, 50, 69-80, 83, 456-468 | `dtx.doc` | `hypdoc` option numbered; `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput`, `\PrintChanges`, `\PrintIndex`, `\changes`, `\DoNotIndex`, `macrocode` |
| array package (driver) | semesterplannerlua.dtx:36 | `tbl.tabular` | `array` loaded, no options |
| language (driver) | semesterplannerlua.dtx:37 | `lang.babel` | `babel`, no options |
| title block | semesterplannerlua.dtx:87-94 | `front.maketitle` | `\title`, `\author` (with `\url` and `\faGithub`), `\date{\fileversion~from \filedate}`, `\maketitle`; `\providecommand*{\url}{\texttt}` at 85 is a kernel alias |
| abstract | semesterplannerlua.dtx:96-106 | `abs.kernel` | `abstract` environment |
| contents | semesterplannerlua.dtx:108 | `toc.kernel` | `\tableofcontents` |
| headings (documentation) | semesterplannerlua.dtx:110, 112, 210, 251, 305, 342, 375, 405, 430 | `head.kernel` | `\section`, `\subsection`, `\subsubsection`, `\paragraph` (264), class defaults |
| option lists (documentation) | semesterplannerlua.dtx:134-154, 171-205, 318-341 | `list.kernel` | `description` environment, `\item[|key|]` |
| manual breaks and indent (documentation) | semesterplannerlua.dtx:220, 228, 230-240, 264 | `sp.lengths`, `pg.break`, `sp.manual-space` | `\hangindent=4.5em \hangafter=1`; `\newpage`; `\\` in verbatim lines; `\mbox{}\\` |
| cross-reference | semesterplannerlua.dtx:175, 405 | `xref.kernel` | `\label{icons}`, `\ref{icons}` |
| icon table (documentation) | semesterplannerlua.dtx:408-425 | `tbl.tabular`, `font.icons`, `color.xcolor` | `tabular{rl|rl}` with `\hline`; `\textcolor{DodgerBlue}{\faCamera}` and similar |
| inline code | semesterplannerlua.dtx:114, 156-168 | `code.verbatim` | `|...|` short verbatim, a `ltxdoc` default |
| package: loading | semesterplannerlua.dtx:111, 437-444, 38 | `cal.semesterplannerlua` | `\usepackage{semesterplannerlua}[2024/02/27]`; the package loads `tikz` with libraries `calendar, positioning, shapes.misc, backgrounds`, `pgfkeys`, `xcolor`, `fontawesome`, `luapackageloader` |
| package: timetable | semesterplannerlua.dtx:695-812; sample 242-249; semesterplannerlua_timetable.lua:83-165 | `cal.semesterplannerlua` | `timetable[days={Mon,Tue,Wend,Thur,Fri}, dayse={M,T,W,Th,F}, start time, end time (minutes), width=\textwidth, length=10 (cm)]` (577-585) |
| package: event commands | semesterplannerlua.dtx:749-802; keys 614-632 | `cal.semesterplannerlua` | `\lecture` `\seminar` `\tutorial` `\meeting` `\officehour` `\laboratory` `\fieldstudy[title, speaker, location, day, time, prio, scale width=1, offset=0, tikz, content, textcolor, password, type, formatter]`; fill colour per type, `textcolor=white` |
| package: appointment, exam and deadline tables | semesterplannerlua.dtx:828-900; sample 284-293; semesterplannerlua_calendar.lua:38-66 | `cal.semesterplannerlua` | `appointments[Room]{true/false}` with `\appointment`, `exams{..}` with `\exam`, `deadlines{..}` with `\deadline`; keys `draw` `room` `time` `prio` `course` `desc` `date` `end` `tikz` `period` `type` `shift` `print` (652-665) |
| package: calendar drawing | semesterplannerlua.dtx:823; sample 295; semesterplannerlua_calendar.lua:68-123 | `cal.semesterplannerlua` | `\printSpCalendar[cols=3]{YYYY-MM-DD}{YYYY-MM-DD}` (needs the Lua module `date`, calendar.lua:1) |
| package: icons | semesterplannerlua.dtx:456-539 | `cal.semesterplannerlua`, `font.icons` | `\zoom` `\teams` `\youtube` `\BBB` `\pmandatory` `\phigh` `\pmid` `\plow` `\pnone` `\tbd` `\tba` `\oral` `\written`, built on `fontawesome` glyphs with `\textcolor` |
| package: type colours | semesterplannerlua.dtx:447-454 | `color.xcolor` | `\definecolor` rgb: seminar 1.0,0.8,0.0; lecture 0.2,0.7,1.0; tutorial 0.0,0.8,0.0; meeting, laboratory, fieldstudy 0.8,0.0,0.0; officehour 0.0,0.4,0.6; DodgerBlue HTML 1E90FF |
| package: fixed section headings | semesterplannerlua.dtx:696, 847, 872, 895 | `head.kernel` | `\section*{\faClockO~Timetable}`, `\section*{\faCalendar~Appointments}`, `\section*{\faStickyNoteO~Exams}`, `\section*{\faStickyNoteO~Deadlines}` emitted by each environment |
| package: table headers | semesterplannerlua.dtx:848-849, 873-874, 896-897 | `tbl.tabular`, `mark.kernel` | `tabular{rlllll}`, `{rllll}`, `{rlll}`; headers in `\textbf` |
| package: data file | semesterplannerlua_timetable.lua:2-3, 66-67, 164 | `cal.semesterplannerlua` | writes `\jobname-data.dat` with `\immediate\openout` (no shell escape) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| timetable layout and tikz drawing in Lua | semesterplannerlua_timetable.lua:83-165 | not applicable: code of the published package, which is the way | the way `cal.semesterplannerlua` holds it; written as zip-local code of a template it would be irreducible layout code |
| calendar layout in Lua (month matrix, marks, shifts) | semesterplannerlua_calendar.lua:68-123 | not applicable: published package code | same way; its `require "date"` is the blocker above |
| `timetable`, `appointments`, `exams`, `deadlines` environments and event commands | semesterplannerlua.dtx:695-900 | not applicable: published package code | same way |
| `\semesterplannerLua@encircle` and the `\protected\def` icon macros | semesterplannerlua.dtx:460-537 | not applicable: published package code (internal helper, minipage plus tikz node) | same way, with `font.icons` |
| `\tikzoption{day headings}` and the `day letter headings` style, using pgf internals `\tikz@lib@cal@xshift` | semesterplannerlua.dtx:671-687 | not applicable: published package code | same way |
| `\providecommand*{\url}{\texttt}` | semesterplannerlua.dtx:85 | yes | kernel alias of `\texttt`, `mark.kernel` |
| `semesterplannerlua_dmenu.lua` | semesterplannerlua_dmenu.lua:1-156 | outside the template: a separate script, never loaded by the document | none needed; it consumes `\jobname-data.dat` and is not part of the printed output |

## Content-opaque
none (event, appointment and exam strings, dates and the fixed icon glyphs are content or parameters; the TikZ pictures are produced by the package, the sample draws none of its own)

## Lib changes
- New ways proposed: `cal.semesterplannerlua` `semesterplannerlua` (CTAN, TeX Live, MiKTeX, LPPL 1.3; Lukas Heindl; v1.1.2), engine xe/lua (LuaLaTeX): `\usepackage{semesterplannerlua}`; body `timetable[days,dayse,start time,end time,width,length]` with `\lecture` `\seminar` `\tutorial` `\meeting` `\officehour` `\laboratory` `\fieldstudy[title,speaker,location,day,time,prio,scale width,offset,tikz,...]`; `appointments` `exams` `deadlines` with `\appointment` `\exam` `\deadline[date,course,room,time,prio,desc,end,period,draw,print,shift,tikz]`; `\printSpCalendar[cols]{start}{end}`; icon commands `\zoom` `\phigh` `\pmandatory` and others; **EXTERNAL** when loaded, because the calendar module requires the system Lua module `date`. W1: on CTAN, in TeX Live and MiKTeX (ctan.org/pkg/semesterplannerlua read). W2: behaviour chosen by pgf keys with strings, numbers, booleans and name lists (the `tikz` key is a pgf option list; `content` and `formatter` are optional). W3: serves any weekly timetable, appointment list or date-range calendar, not one document. W4: a preamble `\usepackage` line and body environments with per-entry commands that an emitter can print around node content. Not `cal.termcal` (a term-weeks `calendar` environment, no timetable grid) and not `cal.kalender` (a fixed German year grid with one year value).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
