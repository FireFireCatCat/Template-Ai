yes

# 0565-daily-planner-calendar: Daily Planner Calendar

- Unverified: read from the source, not compiled.
- Source: Source/0565-daily-planner-calendar/ (origin: https://latextemplates.com/downloads/daily-planner-calendar.zip; licence: LPPL-1.0)
- Kind: calendar
- Lib: v4
- Engine: pdfLaTeX-compatible (no fontspec; main.tex:13 says "No fontspec -- pdflatex-safe"; no package is loaded at all)
- Look carried by: preamble (a kernel `article` page set up by four `\setlength` lines at main.tex:22-31, plus a hand-vendored plain `tabular` grid in the body; no class or style file in the zip)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; the zip holds only this one file, 236 lines)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The zip is one 236-line `main.tex` on kernel `article`. It loads no package, and every construct is a kernel command: four `\setlength` page lines, `\pagestyle{empty}`, a `center` environment, and a `tabular` with `\hline`, `\cline`, `\multicolumn` and `p{}` columns. The only bespoke items are two `\newcommand` aliases of `\rule{0pt}{12pt}`, which reduce by inline expansion. There is no artwork, no counter or conditional logic, and no tool outside TeX is needed to compile it.

The header comment (main.tex:1-20) says the grid came from the Perl generator of CTAN's `yplan` and was vendored as plain `tabular` text, edited by hand to bold five dates. The sample never does `\usepackage{yplan}` (main.tex:6-7 say it is not bundled). So the Perl script is not an input to this document, and `EXTERNAL` does not apply. A document that really called the generator would be a different case.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:21). Kernel class, not in the zip, so its source was not read.
- Class-native vocabulary used: none. There is no `\maketitle`, `abstract`, `\section` or `\bibliography`. The page heading is a hand-set `\LARGE` line (main.tex:38).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:21 | `class.article` | `a4paper` |
| paper size | main.tex:21 | `page.class-options` | `a4paper` |
| page geometry (raw lengths) | main.tex:22-24, main.tex:31 | `page.setlength` | `\topmargin=-1.6cm`, `\oddsidemargin=-13.5mm`, `\textwidth=18.5cm`, `\textheight=26cm` (no `geometry` package) |
| header/footer, page number | main.tex:35 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| page heading line ("2026 -- January to June") | main.tex:37-38, main.tex:138-139 | `sp.ragged` | kernel `center` environment (the `\centering` type) around the heading and the table |
| heading size | main.tex:38, main.tex:139 | `font.size-commands` | `{\LARGE ...}` |
| heading offset and blank line | main.tex:38-39, main.tex:139-140 | `sp.manual-space` | `\hspace{1cm}`, `\\`, `{\ } \\` (an empty line made by a control space and a line break) |
| year grid, one table per half-year | main.tex:40-128, main.tex:141-229 | `tbl.tabular` | column spec `\|c\|\|p{2.5cm}\|p{2.5cm}\|p{2.5cm}\|p{2.5cm}\|p{2.5cm}\|p{2.5cm}\|` (main.tex:40, main.tex:141); 7 columns, 6 months by weekday rows |
| grid rules | main.tex:42, main.tex:51-52, main.tex:54, main.tex:56, main.tex:127 | `tbl.tabular` | kernel `\hline`, `\hline\hline` (week separators), per-column `\cline{a-a}` (62 lines carry `\cline`); the `\cline` set is static text, no logic |
| month header row | main.tex:43-50, main.tex:144-151 | `tbl.tabular` | `\multicolumn{1}{\|c\|}{JANUARY}` and the blank corner `\multicolumn{1}{\|c\|\|}{\monthstrut\ }` |
| row height strut | main.tex:32-33, used at main.tex:43, main.tex:53 | `sp.rule` | `\rule{0pt}{12pt}` through the aliases `\monthstrut` and `\datestrut` |
| highlighted dates | main.tex:61, main.tex:63, main.tex:69, main.tex:87, main.tex:97, main.tex:188, main.tex:206, main.tex:226 | `mark.kernel` | `\textbf{n}` in a cell |
| key paragraph | main.tex:131-134, main.tex:232-234 | `sp.manual-space` | `\vspace{1em}` before it |
| key paragraph start | main.tex:132, main.tex:233 | `sp.lengths` | `\noindent` (paragraph indent suppressed for that paragraph; filed as paragraph-shape control, the nearest lib line) |
| key paragraph label | main.tex:132, main.tex:233 | `mark.kernel` | `\textbf{Key:}` and `\textbf{bold}` |
| page break between half-years | main.tex:136 | `pg.break` | `\clearpage` |

No fonts, colours, language, hyperlinks, lists, floats, captions, notes, maths, theorems, code, boxes or bibliography are set or used (confirmed by grep: no `\usepackage`, `\RequirePackage` or `\input`; the only `\def`-family line is `\newcommand` at main.tex:32-33). The default Computer Modern fonts stay, so no `font.*` way is needed.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\monthstrut` | main.tex:32 | yes | alias of `\rule{0pt}{12pt}`; inline-expand to `sp.rule` (width 0, height 12pt) at main.tex:43 and main.tex:144 |
| `\datestrut` | main.tex:33 | yes | the same alias; inline-expand to `sp.rule` at the start of each row cell, for example main.tex:53 |

No environments, counters, conditionals, `\def`, `\@`-level code or hand-written class exist in the zip.

## Content-opaque
none. The date numbers, month and weekday names, the bold highlights and the key text are cell and paragraph content. The grid is a plain `tabular`, not artwork (no TikZ, `picture` or PSTricks).

## Lib changes
- New ways proposed: none. considered: yplan (CTAN, LPPL 1, per ctan.org/pkg/yplan; ships a Perl generator). The sample does not load it (main.tex:6-7), so no way is proposed for it.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
