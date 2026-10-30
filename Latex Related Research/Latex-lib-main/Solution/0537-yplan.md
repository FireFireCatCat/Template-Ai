yes

# 0537-yplan: yplan (vertical year-planner calendar)

- Unverified: read from the source, not compiled.
- Source: Source/0537-yplan/ (origin: https://mirrors.ctan.org/macros/latex/contrib/yplan.zip; licence: lppl1, the file headers say LPPL "version 1 ... or any later version", yplan00a.tex:6-12)
- Kind: calendar
- Lib: v4
- Engine: pdfLaTeX-compatible (kernel `article`, `tabular`, `\rule`; no font or Unicode package)
- Look carried by: preamble (the sample's own preamble sets margins and two rule struts, yplan00a.tex:52-54,78,81; the grid is the `tabular` column spec in the body, yplan00a.tex:92; `yplan.sty` is not loaded by the sample and only holds name strings)
- Class origin: tex-distribution-unbundled
- Main file: yplan00a.tex (other samples: yplan00b.tex, same construction for July to December; yplan00.doc and yplan.doc are plain-text documentation; `yplan` is a Perl generator)
- Read: main yes, zip-local classes and styles all (only `yplan.sty`, 294 lines, read in full; the kernel `article` class source was not read)

## Verdict
yes. The sample is a kernel `article` page of margin lengths holding one `table` float with a `tabular` whose cells are text; every construct is a kernel command, and the aliases (`\def` month names, `\monthstrut`, `\datestrut`, `\leapyear`) reduce by inline expansion. `yplan.sty` is a CTAN package that only selects one of six name tables by option and has no layout effect; the sample does not load it (yplan00a.tex:50 is commented out), so recovery does not depend on it. No artwork, no counters, no output routine.
Flagged, not counted: the zip also ships a Perl program `yplan` that writes `.tex` for any year (yplan.doc:34-41). No sample loads or needs it: the shipped `.tex` files stand alone (yplan.doc:47-50), and its output is the same `tabular` as the sample (yplan:275-321). Read as part of the template it would be `EXTERNAL/package`; the day numbers and `\cline` placement it computes are cell content here (rubric: cell contents are content), so it is not counted.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (yplan00a.tex:49; yplan00b.tex:49); 10pt default, no other option
- Class-native vocabulary used: none (no `\maketitle`, no sectioning, no abstract; the page is one float)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | yplan00a.tex:49 | `class.article` | a4paper |
| paper size | yplan00a.tex:49 | `page.class-options` | a4paper |
| margins and text width | yplan00a.tex:52-54 (yplan00b.tex:52-54 identical) | `page.setlength` | `\topmargin`=-1cm, `\oddsidemargin`=-13.5mm, `\textwidth`=18.5cm; no `\textheight` or `\headheight` change |
| page style | yplan00a.tex:87 (yplan00b.tex:88) | `hf.pagestyle-kernel` | `\thispagestyle{empty}` (no page number); the Perl output uses `\pagestyle{empty}`, yplan:263 |
| month-row and day-row struts | yplan00a.tex:78,81 | `sp.rule` | `\rule{0pt}{12pt}`, a zero-width 12pt-high rule used as the first item of the header cell (yplan00a.tex:94) and of every day row (e.g. yplan00a.tex:104) |
| year heading line | yplan00a.tex:90 | `sp.manual-space`, `font.size-commands`, `mark.kernel` | `\hspace{1cm}`, `{\LARGE 2000}`, `\hspace{8mm}`, `\textsc` leap-year label (yplan00a.tex:75), `\\` |
| blank spacer lines | yplan00a.tex:91,177 | `sp.manual-space` | `{\ } \\` (control space and line break) |
| float wrapper | yplan00a.tex:89,180 | `tbl.tabular` | kernel `table` float, default placement, no `\caption` |
| grid | yplan00a.tex:92 | `tbl.tabular` | column spec `\|c\|\|` plus six `p{2.5cm}` columns each closed by `\|` |
| header row (month names) | yplan00a.tex:94-100 | `tbl.tabular` | `\multicolumn{1}{\|c\|\|}{strut}` then six `\multicolumn{1}{\|c\|}{month}`; month names are text |
| table rules | yplan00a.tex:93,101-102,113,117,165 | `tbl.tabular` | `\hline`, `\hline\hline` after the header and after each Sunday, `\cline{a-b}` only against filled cells |
| day rows | yplan00a.tex:104-174 | `tbl.tabular` | weekday abbreviation (`\Mo` ... `\Su`) plus six day-number cells (content) |
| month, weekday and leap-year strings | yplan00a.tex:56-75 | `tbl.tabular` (cell text) | English upper-case strings, defined as macros and used as cell text; other languages are the same kind of string (yplan.sty:62-290) |
| source line under the table | yplan00a.tex:178-179 | `mark.kernel` | `\textsc{ctan}` plus a path as text; the `\hfill\hbox{\copyright ...}` after the `%` is commented out |
| fonts, colour, language, bibliography, floats other than the one table | whole sample | none | no `\usepackage` is active in either sample; the page uses the class default font and no colour |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\January` ... `\December`, `\Mo` ... `\Su` | yplan00a.tex:56-74; yplan00b.tex:57-75 | yes | text aliases: write each string where it is used (header cells and weekday cells), `tbl.tabular` content |
| `\leapyear` | yplan00a.tex:75; yplan00b.tex:76 | yes | alias of `\textsc{leap year}`: `mark.kernel` in the heading line |
| `\monthstrut`, `\datestrut` | yplan00a.tex:78,81; yplan00b.tex:79,82 | yes | alias of `\rule{0pt}{12pt}`: `sp.rule`, expanded in place |
| `yplan.sty` (not loaded; CTAN package, so published) | yplan.sty:43-290 | yes | `\newboolean{upper}` (46), six language options and two case options (48-55), `\AtBeginDocument` with `\ifthenelse` (62-290) pick one set of `\def` strings; no length, rule or font is set. With the options known when the emitter writes the file, it writes the chosen strings as cell text |
| `yplan` Perl generator (not TeX; not loaded by any sample) | yplan:44-321 | n/a (outside the compile) | day-of-week arithmetic (yplan:44-51,148-164) and rule placement (yplan:298-311) produce plain `tabular` rows; the same rows are cell content for the emitter. Flagged under Verdict |

## Content-opaque
none (the grid of day numbers is cell content held in `tbl.tabular`, not an opaque construct)

## Lib changes
- New ways proposed: none. Considered: `yplan` (CTAN) as a language-name package for the planner; not proposed, because no sample loads it (yplan00a.tex:50 is commented out), its strings are plain cell text, and recovery does not need it (the lib v4 log rejected `xref.upref` for the same reason). A zip whose sample loads it may propose it.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
