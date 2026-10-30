yes

# 0468-calendar-grid: Calendar Grid (deterministic month and year grids)

- Unverified: read from the source, not compiled.
- Source: Source/0468-calendar-grid/ (origin: https://mirrors.ctan.org/macros/latex/contrib/calendar-grid.zip; licence: LPPL 1.3c (manifest `lppl1.3c`; LICENSE:2-3; calendar-grid.sty:3-6))
- Kind: calendar (the zip is a package kit; its main sample is the package's own user guide in `article`, and the template product is the month and year grid)
- Lib: v4
- Engine: pdfLaTeX-compatible (calendar-grid.sty:11 needs a LaTeX format of 2020-10-01 or later; calendar-grid-doc.tex:32 says pdfLaTeX, XeLaTeX and LuaLaTeX work; verify_installation.py:34 compiles a consumer with `pdflatex`; no `fontspec`, no shell escape)
- Look carried by: preamble (the page is `article` 11pt plus published packages loaded at calendar-grid-doc.tex:4-10; the grids come from the CTAN package `calendar-grid`, loaded at calendar-grid-doc.tex:6, whose copy ships in the zip as calendar-grid.sty)
- Class origin: tex-distribution-unbundled
- Main file: calendar-grid-doc.tex (other samples: calendar-grid-example-basic-month.tex, calendar-grid-example-events.tex, calendar-grid-example-fixed-grid.tex, calendar-grid-example-ranges.tex, calendar-grid-example-year-overview.tex; calendar-grid-regression.lvt is an l3build test, not a sample)
- Read: main yes (133 lines), zip-local classes and styles all (calendar-grid.sty read in full, 493 lines; the five examples, regression.lvt, build.lua, README.md, CHANGELOG.md, manifest.txt and the five dev scripts also read; calendar-grid-doc.pdf is compiled output and was not read)

## Verdict
The sample is a 133-line `article` manual: `fontenc`, `hyperref`, `geometry`, two length settings, kernel front matter, sections, a `description` list, `verbatim` blocks, and calls to `\CalendarGrid` and `\CalendarYear`. The grids come from `calendar-grid.sty`, which is the CTAN package `calendar-grid` (ctan.org/pkg/calendar-grid: Mateo Pedersen, 1.0.0, LPPL 1.3c, in TeX Live and MiKTeX; the manifest origin is CTAN's own zip). It is published (W1), its behaviour is set by key=value options (W2), so its 493 lines of expl3 are the body of one way, `cal.termcal`, not bespoke code, as `cal.kalender` was accepted for `kalender`. The sample defines no macro, and the one hook redefinition it shows sits inside a `verbatim` block (calendar-grid-doc.tex:107-110), so it is content.
The `yes` rests on one judgement: that a published expl3 package whose source ships in the zip is a way and not irreducible code. If a reviewer rules that the 493-line date and layout code counts as bespoke even though it is on CTAN, the verdict flips to `no` (`BESPOKE/class`). The zip's copy of the `.sty` was not compared byte for byte with CTAN's.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (calendar-grid-doc.tex:1)
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (calendar-grid-doc.tex:11-15), `\tableofcontents` (:16), `\section` and `\subsection` (:18, :64), `description` (:56-62); no `abstract`, no `thebibliography`

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | calendar-grid-doc.tex:1 | `class.article` | 11pt |
| paper and type size | calendar-grid-doc.tex:1 | `page.class-options` | `11pt` only; no paper option, article default |
| font encoding | calendar-grid-doc.tex:4 | `font.fontenc-t1` | `fontenc` T1; no `inputenc` |
| hyperlinks | calendar-grid-doc.tex:5, 8 | `meta.hyperref` | `colorlinks=true`, `urlcolor=blue`, `linkcolor=blue` |
| page margins | calendar-grid-doc.tex:7 | `page.geometry` | `margin=25mm` (loaded after `calendar-grid`) |
| paragraph spacing | calendar-grid-doc.tex:9-10 | `sp.lengths` | `\parskip` .5em, `\parindent` 0pt |
| title block | calendar-grid-doc.tex:11-13, 15 | `front.maketitle` | two-line title, two-line author (name, company), two-line date (version, date); `\maketitle` |
| title line breaks | calendar-grid-doc.tex:11-13 | `sp.manual-space` | `\\` inside `\title`, `\author`, `\date` |
| subtitle size | calendar-grid-doc.tex:11 | `font.size-commands` | `\large` |
| contents | calendar-grid-doc.tex:16 | `toc.kernel` | `\tableofcontents`, no options |
| headings | calendar-grid-doc.tex:18, 24, 30, 34, 52, 64, 68, 72, 78, 90, 101, 114, 123, 127 | `head.kernel` | `\section`, `\subsection`, article defaults, numbered, no `titlesec` |
| definition list | calendar-grid-doc.tex:56-62 | `list.kernel` | `description` with `\item[\texttt{...}]` labels |
| inline code | calendar-grid-doc.tex:22, 32, 54, 57-61, 74 | `mark.kernel` | `\texttt{}`, `\textbackslash` |
| verbatim code blocks | calendar-grid-doc.tex:36-48, 82-86, 94-97, 107-110 | `code.verbatim` | `verbatim` environment; `\verb\|..\|` at :54, :112, :125; the text is content |
| URLs | calendar-grid-doc.tex:129, 131 | `meta.url` | `\url{}` (the command `hyperref` loads) |
| calendar grids in the body | calendar-grid-doc.tex:6, 50, 76, 118-121 | `cal.termcal` | `\usepackage{calendar-grid}`; body `\CalendarGrid[year,month,week-start,layout,overflow,cell-width,cell-height,header-height,row-gap,column-gap,month-names,weekday-names,weekday-short-names]`; `\CalendarYear[columns=1..4, same keys]` |
| per-date notes | calendar-grid.sty:421-432; calendar-grid-example-events.tex:4-5 | `cal.termcal` | `\CalendarGridEvent{YYYY-MM-DD}{text}`; repeated date appends a line; the guide shows it only in `verbatim` (calendar-grid-doc.tex:82-86) |
| named date ranges | calendar-grid.sty:434-456; calendar-grid-example-ranges.tex:4 | `cal.termcal` | `\CalendarGridRange[style=name]{start}{end}`; inclusive, may cross month and year; shown only in `verbatim` (calendar-grid-doc.tex:94-97) |
| defaults (inside the way) | calendar-grid.sty:193-217 | `cal.termcal` | year 2027, month 1, columns 3, week-start monday, layout fixed, overflow adjacent, cell-width 1.35cm, cell-height 8mm, header-height 7mm, row-gap 1pt, column-gap 2pt |
| month grid shape (inside the way) | calendar-grid.sty:381-407 | `cal.termcal` | `tabular` of seven `p{cell-width}` centred columns with `\hline` rules, `\tabcolsep` = column-gap, `\extrarowheight` = row-gap; weekday header row rotated by week-start; 6 rows when `fixed`, 4 to 6 when `compact` |
| year overview shape (inside the way) | calendar-grid.sty:458-490 | `cal.termcal` | `tabular` of 12 `minipage`s in 1 to 4 columns at `\scriptsize`; cell sizes derived from `\linewidth` (.55cm and .45cm heights, 1pt and 0pt gaps) |
| date arithmetic (inside the way) | calendar-grid.sty:102-141, 143-179 | `cal.termcal` | proleptic Gregorian, Julian day number, years 1 to 9999, ISO `YYYY-MM-DD` only, errors on bad dates |
| day and title hooks (inside the way) | calendar-grid.sty:310-322 | `cal.termcal` | default month title `\bfseries` centred; default day cell: bold weekend or range date, italic adjacent-month date, event text in `\scriptsize` below the number; redefining the hooks is outside the way (see Bespoke code) |
| `array` dependency (inside the way) | calendar-grid.sty:14 | `cal.termcal` | loaded by the package itself, not a separate row |

Not defined by this zip (no row): colour, fonts beyond T1, page styles (article default), theorems, floats, captions, bibliography, index, cross-references, footnotes. The sample sets none of them.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `calendar-grid.sty` (expl3: key definitions :191-223, Julian day :128-141, cell placement :243-283, range lookup :285-307, rendering :324-407, public commands :409-490) | calendar-grid.sty:12-493 | n/a: published on CTAN (W1), so not bespoke; it is the body of `cal.termcal` | If the zip's copy did not match CTAN's, this would be irreducible `BESPOKE/class` (expl3 date arithmetic and counter-driven cell placement) and the verdict would be `no`. The manifest origin is CTAN's own zip and the version (1.0.0, calendar-grid.sty:12) matches the CTAN page; the files were not compared byte for byte. |
| redefinition of `\CalendarGridFormatMonthTitle` | calendar-grid-doc.tex:107-110 | n/a: inside a `verbatim` block, so content, not executed | If a template did execute it, it would be body or preamble code outside the way (`\RenewDocumentCommand` with `\par\smallskip\centering\Large\sffamily\bfseries`); it would reduce to `sp.ragged`, `font.size-commands` and `mark.kernel` wrappers only if inlined per use. The sample does not need it. |
| sample macros, environments, counters | calendar-grid-doc.tex | none defined | the sample has no `\newcommand`, `\def`, environment, counter or conditional |
| `calendar-grid-regression.lvt` | calendar-grid-regression.lvt:1-82 | n/a: l3build test harness (`\input{regression-test.tex}` at :2, internal `\__cg_*` calls), not loaded by the sample | out of scope: it is not a template and the guide compiles without it |
| `build.lua`, five `.py` scripts (compile, verify, report) | build.lua:1-39; compile_examples.py, verify_*.py, release_report.py | n/a: release tooling (`l3build`, `pdflatex`, `kpsewhich` calls), not needed to produce the guide | not a blocker: they check the package, they do not feed values to the document (README.md:53-55). Note: manifest.txt:18-22 lists them under `scripts/`, but they sit at the zip root. |

## Content-opaque
none (the grids are generated by the way from year and month values, not drawn in the sample; the `verbatim` blocks at calendar-grid-doc.tex:36-48, 82-86, 94-97, 107-110 are code text, content)

## Lib changes
- New ways proposed: `cal.termcal` (component: doc-kind specific, sibling of `cal.kalender` and `cal.termcal`; package `calendar-grid`, CTAN `/macros/latex/contrib/calendar-grid`; engine pdf; preamble `\usepackage{calendar-grid}`, body `\CalendarGrid[keys]`, `\CalendarYear[keys]`, `\CalendarGridEvent{date}{text}`, `\CalendarGridRange[style=]{start}{end}`).
  - W1 Published: on CTAN (one read of ctan.org/pkg/calendar-grid: Mateo Pedersen, 1.0.0, LPPL 1.3c, in TeX Live and MiKTeX); the zip's origin URL is CTAN's own zip.
  - W2 Declarative parameters: behaviour is chosen by values: integers (`year`, `month`, `columns`), a closed choice (`week-start`, `layout`, `overflow`), dimensions (`cell-width`, `cell-height`, `header-height`, `row-gap`, `column-gap`) and label lists (`month-names`, `weekday-names`, `weekday-short-names`), calendar-grid.sty:191-221. Redefining the day and title hooks is extending its code and stays outside the way.
  - W3 Generic: serves a kind of component (a month grid or a twelve-month overview placed inside any document), for any year from 1 to 9999, not one document.
  - W4 Printable: one preamble line, and one body line per grid, note or range with string and key=value arguments.
  - Not `cal.kalender` (a fixed German year-at-a-glance grid, one parameter) and not `cal.termcal` (a course calendar of weeks). Not `art.content-package`: the parameters are values, not programs or free drawings. Not `tbl.tabular`: the date arithmetic, week rotation and cell content come from the package. Searched the lib first (`grep -n 'cal\.' _Lib.md` found `cal.kalender` at line 393, `cal.termcal` at line 408, and the change-log note at line 437 that merged `cal.wallcalendar` into `class.wallcalendar`; no line names `calendar-grid`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
