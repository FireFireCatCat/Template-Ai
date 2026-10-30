yes

# 0434-monthly-calendar: Monthly Calendar

- Unverified: read from the source, not compiled.
- Source: Source/0434-monthly-calendar/ (origin: https://latextemplates.com/downloads/monthly-calendar.zip; licence: LPPL-1.3)
- Kind: calendar
- Lib: v4
- Engine: needs LuaLaTeX (the class loads `luacode` and Lua-side CSV and date helpers unconditionally, per the sample's own comment at main.tex:3-5; the class source is not in the zip and was not read)
- Look carried by: class (the whole look is `wallcalendar`; the sample adds only class options, one class page command and a data file)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; events.csv is the data file the sample reads)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is a 24-line starter: one `\documentclass[...]{wallcalendar}` call with class options, one class page command, and an `events.csv` data file; it holds no zip-local `.cls`, `.sty`, macro, environment or counter, and no artwork of its own. The whole look is the published class `wallcalendar` (one way, `class.wallcalendar`), which is on CTAN and in TeX Live but not bundled in the zip (main.tex:2-4), so its source was not read and its vocabulary is recorded below. The verdict is `yes` as a class-carried zip, which is evidence about the class dimension, not about the component ways. It needs LuaLaTeX, which is recorded as the engine and is not a blocker.

## Blockers
none

## Class setting
- Class: `class.wallcalendar` options: `year = 2026`, `eventsCsv = ./events.csv`, `a4PaperLandscape`, `hMargin = 5mm`, `topMargin = 5mm`, `bottomMargin = 5mm` (main.tex:12-19). Options are given as key=value pairs and bare flags in the class's own option syntax.
- Class-native vocabulary used: page command `\YearPlannerLandscapeGridPage` (main.tex:23), a full-year landscape grid page, with no photographs (main.tex:7-11). The sample does not use the class's photo-collage `\MonthPage` layouts (main.tex:8-9, named in a comment only). Events come from a semicolon-separated CSV (events.csv:1) whose header names the class's event fields: `date`, `date_end`, `day_text`, `annotation`, `annotation_end`, `annotation_color`, `footnote`, `sidenote`, `image`, `image_options`, `note_show_date`, `note_show_day_text`. Only `date` and `sidenote` are filled (events.csv:2-8).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:12-19 | `class.wallcalendar` | `year=2026`, `eventsCsv=./events.csv`, `a4PaperLandscape`, `hMargin=5mm`, `topMargin=5mm`, `bottomMargin=5mm`; options are read by the class (source not read) |
| paper size and orientation | main.tex:15 | `page.class-options` | class option `a4PaperLandscape` (the class's own spelling of A4 landscape) |
| page margins | main.tex:16-18 | `page.class-options` | class options `hMargin=5mm` (left and right), `topMargin=5mm`, `bottomMargin=5mm`; whether the class passes them to `geometry` is not known (class source not read) |
| calendar year | main.tex:13 | `class.wallcalendar` | class option `year=2026`; the weekday alignment and month grid are the class's own computation |
| year-planner grid page | main.tex:23 | `class.wallcalendar` | body command `\YearPlannerLandscapeGridPage`, no arguments; the grid, the month and day labels and the event marks are the class's output |
| event marks and side notes | main.tex:14, events.csv:1-8 | `class.wallcalendar` | class option `eventsCsv=./events.csv`; seven rows with `date` and `sidenote` set (events.csv:2-8); the row text is data (see Content-opaque) |
| empty anchor box before the page command | main.tex:22 | `sp.manual-space` | kernel `\mbox{}`, an empty zero-width box with no printed effect that starts the first paragraph; filed with the kernel box and space commands as `\raisebox` and `\hspace` are (borderline filing, a placeholder rather than a layout choice) |

The class's headers, footers, fonts, colours, language and day names are chosen by the class and its defaults. The sample sets none of them, so no row is written for them (no `hf.*`, `font.*`, `color.*` or `lang.*` command appears in main.tex).

## Bespoke code
none. main.tex defines no macro, environment, counter or conditional (main.tex:12-24). The zip has no `.cls`, `.sty`, `.def` or `.cfg` file.

## Content-opaque
- events.csv:2-8: seven event rows (`date` plus a `sidenote` string such as a holiday name); this is data the class reads through `eventsCsv`, not template. The class reads it with its own Lua-side helper (main.tex:4-5), so no outside tool is involved as far as the sample shows (class source not read).
- The year grid and its drawing inside `\YearPlannerLandscapeGridPage` are produced by the unread class; the sample contains no TikZ, PGF or picture code of its own (no `art.*` use in main.tex).

## Lib changes
- New ways proposed: none. (`class.wallcalendar` is a class way and needs no proposal. The v3 change log already folds a calendar-specific way into this class way: `cal.wallcalendar` into `class.wallcalendar`.)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The zip is named "Monthly Calendar", but the sample typesets a full-year grid page, not month pages (main.tex:7-11, 23). The kind hint `calendar` still fits.
- Unverified points that rest on the sample's header comment and the CTAN page, not on the class source: that the class needs LuaLaTeX and `luacode` (main.tex:3-5, CTAN page tagged LuaTeX), which packages the class loads, and how `hMargin` and the other margin options reach the page. If the class turned out to load a package that needs shell escape, the verdict would change to `EXTERNAL/package`; the sample gives no sign of that.
- The header comment (main.tex:1-11) is a plain description of the licence and the engine; it addresses no AI and gives no instruction.
