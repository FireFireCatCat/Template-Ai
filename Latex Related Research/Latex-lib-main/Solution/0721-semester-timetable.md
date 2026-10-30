yes

# 0721-semester-timetable: Semester Timetable

- Unverified: read from the source, not compiled.
- Source: Source/0721-semester-timetable/ (origin: https://latextemplates.com/downloads/semester-timetable.zip; licence: LPPL-1.3, from the manifest; main.tex:1-6 repeats it, and the CTAN page of `semesterplanner` also gives LPPL 1.3)
- Kind: calendar
- Lib: v5
- Engine: needs LuaLaTeX (the CTAN page ctan.org/pkg/semesterplanner says documents must be compiled with LuaLaTeX; main.tex:8-13 says pdfLaTeX also compiles it, a claim inside the zip that was not checked)
- Look carried by: preamble (the published package `semesterplanner`, loaded at main.tex:21, draws all three blocks; the zip holds no class, style, macro or drawing of its own)
- Class origin: tex-distribution-unbundled (kernel `article`, main.tex:19, not in the zip)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip is one 50-line `main.tex`; `semesterplanner.sty` is not shipped, main.tex:5-6, so its source was not read)

## Verdict
The zip is one 50-line `main.tex`. It loads the kernel `article` class, `geometry` and the CTAN package `semesterplanner`, then fills the package's three environments (`timetable`, `exams`, `deadlines`) with strings, day codes, time ranges, ISO dates and kind or priority macros (main.tex:19-48). A search of main.tex for `\newcommand`, `\def`, `\let`, `\newenvironment`, `\newcounter`, `\newif`, `tikz` and `pgf` finds nothing, so there is no bespoke code and no `ART`. An emitter writes one `\usepackage` line and the body environments, so the answer is `yes`. The main uncertainty is that the package source was not read: its look is taken from the sample's use and from the CTAN page (dependencies `color`, TikZ, `schedule`, `fontawesome`; no external tool named), and `\written` `\oral` `\phigh` `\pmandatory` are assumed to be defined by the package because main.tex does not define them.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (main.tex:19)
- Class-native vocabulary used: none (no `\maketitle`, abstract or sectioning; the body is the three package environments only, main.tex:25-48)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:19 | `class.article` | option `11pt` |
| type size and paper | main.tex:19 | `page.class-options` | `11pt`; no paper option, so the class default paper |
| page geometry | main.tex:20 | `page.geometry` | `margin=1.5cm` |
| weekly timetable grid | main.tex:21, 25-36 | `cal.semesterplannerlua` | package `semesterplanner` (the package is the parameter, see Lib changes); environment `timetable` with no option; entry commands `\lecture` (26, 27, 29, 30, 32), `\tutorial` (28, 34), `\officehour` (31), `\seminar` (33), `\meeting` (35), each with six positional arguments `{title}{room}{}{day}{hh:mm-hh:mm}{}`; day codes `M` `T` `W` `Th` `F`; arguments 3 and 6 are empty on every line (meaning not established, source not read) |
| exam list | main.tex:38-42 | `cal.semesterplannerlua` | environment `exams`; `\exam{YYYY-MM-DD}{hh:mm-hh:mm}{course}{kind}` with kind macros `\written` (39, 40) and `\oral` (41) |
| deadline list | main.tex:44-48 | `cal.semesterplannerlua` | environment `deadlines`; `\deadline{YYYY-MM-DD}{course}{description}{priority}` with priority macros `\phigh` (45, 47) and `\pmandatory` (46) |

Inside the package, not emitted by the template: main.tex:9 lists the package's own `RequirePackage` set (`fontawesome`, `color`, `schedule`, `tikz`), and the CTAN page gives the same dependencies. The grid is drawn by `schedule` (a `picture`-based weekly schedule, ctan.org/pkg/schedule) and TikZ inside the package, and the icons come from `fontawesome`; the sample calls none of them, so there is no row for `font.icons`, `art.tikz` or `color.xcolor`, and no `ART` (the sample draws nothing of its own).

Not defined or used by the sample, so no row: title block, abstract, contents, headings, header or footer, fonts, colour, background, lists, floats, tables, captions, code, notes, bibliography, language, metadata.

## Bespoke code
none. main.tex defines no command, environment, counter or conditional; its only `\usepackage` lines are main.tex:20 and main.tex:21. `\written` `\oral` `\phigh` `\pmandatory` are used as arguments (main.tex:39-47) and are not defined in the zip, so they belong to the package (assumed, not read). The commands `\lecture` `\seminar` `\tutorial` `\meeting` `\officehour` `\exam` `\deadline` have the same names in the lib line for `cal.semesterplannerlua` (`_Lib.md:441`).

## Content-opaque
none (course names, rooms, times, dates and deadline texts are content typed into package environments, main.tex:26-47; the sample draws no picture of its own)

## Lib changes
- New ways proposed: none
- Considered: `semesterplanner` (CTAN, Niklas Schneider, v1.0 of 2020-11-02, LPPL 1.3, in TeX Live and MiKTeX; ctan.org/pkg/semesterplanner read) as a way of its own. It passes W1 (CTAN and TeX Live), W2 (strings, day codes, times, dates), W3 (any weekly timetable, exam list or deadline list) and W4 (one `\usepackage` line and body environments around node content). It is not proposed, because it has the same type of effect as the lib line `cal.semesterplannerlua` (a `timetable` environment with `\lecture` `\seminar` `\tutorial` `\meeting` `\officehour`, plus `exams` and `deadlines` environments), so the package is the parameter, as `cal.calendar-grid` was merged into `cal.termcal` in v5. The two CTAN pages differ in author and year (semesterplanner: Niklas Schneider, 2020; semesterplannerlua: Lukas Heindl, 2024, ctan.org/pkg/semesterplannerlua read) and the second lists the first only under "See also", saying nothing on how they are related. The calling form also differs: the sample passes positional arguments, while the lib line records key lists. The consolidator may widen the `cal.semesterplannerlua` line to name `semesterplanner` and its positional form (`\lecture{title}{room}{}{day}{time}{}`, `\exam{date}{time}{course}{kind}`, `\deadline{date}{course}{desc}{priority}`). The EXTERNAL note on that line (a Lua module `date` for the calendar module) is not shown to apply here: the sample loads no calendar module and the CTAN page of `semesterplanner` names no tool beyond LuaLaTeX. This is the main uncertainty behind the `yes`.
- Read at CTAN for context: `schedule` (Jason Alexander, Ethan Deneault, v1.20, LPPL 1.3c, in TeX Live; calc and color; no external tool named), a dependency of `semesterplanner` that the sample never loads, so it needs no way.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
