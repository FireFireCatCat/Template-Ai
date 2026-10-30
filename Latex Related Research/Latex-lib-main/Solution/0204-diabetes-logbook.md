no

# 0204-diabetes-logbook: diabetes-logbook (dmlb), a coloured longtable logbook with 28-day glucose graphs

- Unverified: read from the source, not compiled.
- Source: Source/0204-diabetes-logbook/ (origin: https://mirrors.ctan.org/macros/latex/contrib/diabetes-logbook.zip; licence: other-free per CTAN; the shipped LICENSE file is the GNU AGPL v3, LICENSE:1)
- Kind: misc (a data-entry logbook: one long table of dated readings plus generated graphs; manifest hint `misc`)
- Lib: v2
- Engine: pdfLaTeX-compatible (dmlb.sty has a pdfTeX branch, dmlb.sty:41-44, and a XeLaTeX branch, dmlb.sty:45-71); the `graph` option needs a second `-shell-escape` run (README.md:21-23)
- Look carried by: mixed (dmlb.sty, the CTAN/TeX Live package `diabetes-logbook` shipped in the zip, carries header, table, row colours, fonts, graphs; the sample preamble supplies geometry, colours, caption colour, and a calendar macro)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip; dmlb.sty is a style, not a class)
- Main file: dmlb-template.tex (other samples: dmlb-graphme.tex, an empty graph-build driver; QQ/TEST/99-12.tex and QQ/20-04.tex, data files input by the main file)
- Read: main yes, zip-local classes and styles all (dmlb.sty read in full, 671 lines; QQ/TEST/99-12.tex read in part, the rest checked by grep to be only `\QQQ` rows; the two PDFs are compiled outputs and were not opened)

## Verdict
No. The look is almost entirely the CTAN package `diabetes-logbook` (dmlb.sty), which I propose as one doc-kind way `logbook.dmlb`, but two things stop a `yes`. The sample selects `[graph]` (dmlb-template.tex:9), whose graphs are built by tikz externalisation in a separate `-shell-escape` run driven by a second file (dmlb.sty:209-214, README.md:21-23, dmlb-graphme.tex:37-38): that is EXTERNAL. The sample body also carries a hand-written `\pgfcalendar` loop with `\ifdate` tests that prints a clickable calendar (dmlb-template.tex:44-71): an irreducible program, BESPOKE/body.

## Blockers
- `EXTERNAL/package` graph pages need the tikz `external` library: `\tikzexternalize[prefix=\myRelPath]` (dmlb.sty:209-214) and, per the README, a first pass without `[graph]` to write `.dat` files, then `<engine> -shell-escape graphme.tex` to build the graph PDFs, then a rebuild with `[graph]` (README.md:19-23; dmlb-graphme.tex:37-38). The sample selects the option (dmlb-template.tex:9). Without the PDFs the README says it errors (README.md:20). Not compiled here, so pgf's behaviour without shell escape is not checked.
- `BESPOKE/body` calendar: `\pgfcalendar{cal}{1999-12-01}{2006-04-01}{...}` with nested `\ifdate{equals=...}`, `\ifdate{end of month=0}`, `\pgfcalendarjuliantodate`, `\hyperref[\iY-\iM-\iD]{\%d0}`, `\hbox to1.7cm` (dmlb-template.tex:44-71). The per-day argument is code, so pgfcalendar fails W2 and has no lib way. The file calls it optional ("COMMENT OUT", dmlb-template.tex:42), but it is in the sample.
- `BESPOKE/class` (only if `logbook.dmlb` is rejected under W2): row, date and page-break engine inside dmlb.sty: `\QQQ` measures the remark with `\setbox0\hbox{#7}`, divides by `\mym` to count rows, compares with `\dmlb@maxrows`, inserts `\pagebreak` (dmlb.sty:528-557); leap-year and month-end arithmetic (dmlb.sty:286-294, 371-440); `.dat` writing and reading (dmlb.sty:304-323, 447-495); recursive `\autoFileInput` (dmlb.sty:255-267).
- `ART/class` (only if `logbook.dmlb` is rejected): the pgfplots graph pages the style appends at the end of the document, with `y coord trafo` code, a colormap and `yticklabel` code (dmlb.sty:123-208, 590-597, 216-223). They are the package's own pages, not figure content.

## Class setting
- Class: `class.article` options: `a4paper` (dmlb-template.tex:1)
- Class-native vocabulary used: none beyond the kernel. The sample has no `\maketitle`, sectioning, abstract, lists, maths or bibliography; only a `longtable` with `\caption` (dmlb-template.tex:73-98).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | dmlb-template.tex:1 | `class.article` | a4paper |
| paper size | dmlb-template.tex:1 | `page.class-options` | a4paper |
| page geometry | dmlb-template.tex:2-8 | `page.geometry` | top=1.5cm, bottom=0.6cm, hmargin=1cm, footskip=4.40004pt, headsep=10pt |
| logbook style | dmlb-template.tex:9; dmlb.sty:1, 114-227 | `logbook.dmlb` | option `graph`; whole look of rows, dates, graphs below |
| logbook parameters | dmlb-template.tex:14-16 (`\mya` `\myb` `\myc` commented, :17-19) | `logbook.dmlb` | `\mym`=11cm (remarks column width), `\myRelPath`=./graphs/, `\myd`=28 (days per graph) |
| colours (palette) | dmlb-template.tex:23-36; defaults dmlb.sty:89-99 | `color.xcolor` | `\definecolor` RGB oddRowColor 55,24,34, evenRowColor 28,19,23, tableColor 180,232,252, pageBG 29,25,32; `\colorlet` oddRowTextColor=-oddRowColor and evenRowTextColor=-evenRowColor (complement), headerColor=green!55, curveColor=pink!80!black; defaults are greys |
| table colour support | dmlb.sty:17 | `color.xcolor` | `\RequirePackage[table]{xcolor}` |
| page background | dmlb-template.tex:34 | `color.pagecolor` | pageBG |
| running head and foot | dmlb.sty:15, 78-83 | `hf.fancyhdr` | `\pagestyle{fancy}`, lhead "Diabetes Logbook", rhead `p.\,\thepage`, cfoot empty, headrulewidth=footrulewidth=0.8pt |
| head and foot colour | dmlb.sty:100-104 (`\color{headerColor}` at line 103) | `color.xcolor` | headerColor applied at end of preamble |
| body text colour | dmlb.sty:105-107 | `color.xcolor` | `\color{tableColor}` at begin document |
| default text size | dmlb.sty:109; dmlb.sty:345 | `font.size-commands` | `\footnotesize` for the body, `\small` in the date cell |
| default sans family | dmlb.sty:108 | `mark.kernel` | `\sffamily` at begin document |
| sans default under pdfTeX | dmlb.sty:43 | `font.family-default` | `\renewcommand{\sfdefault}{pag}` |
| language under pdfTeX | dmlb.sty:42 | `lang.babel` | english |
| language under XeLaTeX | dmlb.sty:46-47 | `lang.polyglossia` | `\setdefaultlanguage{english}` |
| fonts under XeLaTeX | dmlb.sty:48, 58-70 | `font.fontspec` | `\setmainfont{lmroman10}[Extension=.otf, *-regular/-bold/-italic/-bolditalic]`, `\setsansfont{lmmono}[Extension=.otf, *10-regular, *10-italic, *lt10-bold]` |
| microtype | dmlb.sty:7 | `sp.microtype` | defaults |
| ellipsis spacing | dmlb.sty:74 | `sp.ellipsis` | option `xspace` |
| paragraph indent | dmlb.sty:76 | `sp.lengths` | `\parindent`=0pt |
| PDF metadata and links | dmlb.sty:18-37 | `meta.hyperref` | unicode, bookmarks, bookmarksopen=false, pdftoolbar, pdfmenubar, pdffitwindow=false, pdfstartview={FitH}, pdftitle={Diabetes Logbook}, pdfnewwindow, colorlinks, linkcolor=magenta, citecolor=green, filecolor=magenta, urlcolor=cyan, linkbordercolor=cyan |
| bookmark tree | dmlb.sty:38, 279, 298-299; dmlb-template.tex:44 | `meta.bookmark` | `\pdfbookmark` per year, month, calendar, graph |
| the logbook table | dmlb-template.tex:73-98, 285; dmlb.sty:9 | `tbl.longtable` | column spec `{ =r +r | +r +r +r +r +r | +m{\mym} }`, `\endfirsthead`, `\endhead`, `\endfoot`, `\hline`, `\multicolumn{2}{c|}` |
| column types | dmlb-template.tex:73; dmlb.sty:10, 656-662 | `tbl.tabular` | `array` with package-defined `=` (resets row style) and `+` (applies row style) via `\newcolumntype` |
| row banding and cell fills | dmlb.sty:106, 514-515; dmlb-template.tex:74, 99 | `tbl.colortbl` | `\rowcolors{0}{evenRowColor}{oddRowColor}`, `\cellcolor`, `\hiderowcolors`, `\showrowcolors` |
| rotated date cell | dmlb.sty:12, 352-367 | `tbl.multirow` | `\multirow{-n}{*}{...}` spanning the day's rows |
| rotated date text | dmlb.sty:13, 352, 361 | `fig.rotating` | `\rotatebox{90}` of `dd--mm[--yy[yy]]` |
| table caption | dmlb-template.tex:76-78, 88 | `cap.kernel` | `\caption{...}` in the first header, `\caption{\emph{cont.}}` in the repeat header |
| caption look | dmlb.sty:14, 85-86; dmlb-template.tex:39-40 | `cap.caption` | `\DeclareCaptionFormat{myformat}{\rmfamily\small\textsc{#1}#2{#3}}`, `\DeclareCaptionFont{cc}{\color{pink}}`, `\captionsetup{format=myformat, labelsep=period, font+=cc}` |
| date row labels | dmlb.sty:342 | `xref.kernel` | `\refstepcounter` + `\label{yyyy-mm-dd}` per day |
| links in remarks | dmlb-template.tex:283-284 | `xref.hyperref` | `\hyperref[2000-01-07]{this}` |
| data rows and dates | dmlb-template.tex:100-103, 105-284; QQ/TEST/99-12.tex:1-178 | `logbook.dmlb` | `\dmlbsetdate{Y}{M}{D}[path]`, `\QQQ{time}{BG}{Ins}{CHO}{Pro}{Fat}{remarks}[*]` (cells are content) |
| row-count offset | dmlb-template.tex:72 | `logbook.dmlb` | `\global\advance\row 1\relax` (one extra row for the long first header, README.md:16) |
| automatic page break | dmlb.sty:545-550 | `pg.break` | `\pagebreak` issued when the row counter equals `\dmlb@maxrows` (inside the way) |
| graph pages | dmlb.sty:114-224, 559-608 | `art.tikz` | pgfplots axis, `\addplot[scatter, smooth, color=curveColor] table`, tikz `external` (EXTERNAL, see blockers) |
| calendar page | dmlb-template.tex:44-71 | `art.tikz` | `\pgfcalendar` loop; BESPOKE/body (see blockers) |
| calendar bookmark | dmlb-template.tex:44 | `meta.bookmark` | `\pdfbookmark[0]{Calendar}{cal}` |
| calendar day links | dmlb-template.tex:67 | `xref.hyperref` | `\hyperref[\iY-\iM-\iD]{...}` |
| calendar rules, spaces | dmlb-template.tex:53-54, 60, 62, 67 | `sp.rule` | `\hrulefill` in a `\large\bfseries` group; with `sp.manual-space` (`\vspace*{2.2pt}`, `\hspace*{4.8pt}`, `\hbox to1.7cm`) |
| calendar type | dmlb-template.tex:53-54 | `font.size-commands` | `\large`, `\small` (with `mark.kernel` `\bfseries`) |
| calendar page break | dmlb-template.tex:71 | `pg.break` | `\clearpage` |
| loaded, never used | dmlb.sty:11 | `cols.multicol` | `multicol` required, no `multicols` in any file |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| pgfcalendar day loop | dmlb-template.tex:44-71 | no | per-day code in the argument; no lib way; BESPOKE/body |
| `\QQQ` row, date, page-break, `.dat` and graph engine, `\autoFileInput`, `\changestrut`, `\calcmaxrows`, `\rowstyle`, counters `\row` `\Year` `\Month` `\Day` `\@potato` | dmlb.sty:230-262, 255-267, 269-340, 344-557, 559-662 | yes only as the published package | the zip does not copy this code: it is CTAN/TeX Live `diabetes-logbook`, used whole as `logbook.dmlb`; if W2 is judged failed, irreducible (BESPOKE/class, listed in blockers) |
| expl3 engine branch | dmlb.sty:40-72 | yes | the emitter picks one branch per engine: pdfTeX is `lang.babel` + `font.family-default`, XeLaTeX is `lang.polyglossia` + `font.fontspec` |
| `\edef` constants | dmlb-template.tex:14-16 | yes | strings and lengths: parameters of `logbook.dmlb` |
| `\global\advance\row 1\relax` | dmlb-template.tex:72 | yes, borderline | one printed line; an integer set on the package's private register (README.md:16) |
| support packages `xparse`, `etoolbox`, `xstring` | dmlb.sty:5-8 | not components | programming support for the internals above, no output of their own |
| `silence` `\WarningsOff[latex]` | dmlb-template.tex:11-12 | not a component | log filter with no effect on the page (considered: silence) |
| tikz `external` | dmlb.sty:209-214 | no | EXTERNAL/package (see blockers) |
| sublime snippet `q` | dmlbrow.sublime-snippet:1-9 | not template | editor aid that types a `\QQQ` line |

## Content-opaque
- 178 `\QQQ` data rows in QQ/TEST/99-12.tex:1-178, 143 uncommented rows in dmlb-template.tex:105-284, and the date stubs in QQ/20-04.tex:1-31 (comment lines only).
- The glucose curve inside each graph (pgfplots from `.dat` data, dmlb.sty:594); the graph pages themselves are listed under blockers.
- Missing assets: the `./graphs/` folder (the `.dat` writer needs it to exist, dmlb.sty:305) and the generated graph PDFs are not in the zip.
- Naming note: dmlb-graphme.tex:9 loads `diabetes-logbook` while the shipped file is dmlb.sty and the template loads `dmlb` (dmlb-template.tex:9).

## Lib changes
- New ways proposed: `logbook.dmlb` (CTAN and TeX Live package `diabetes-logbook`, files named `dmlb.*`; pdf engine, graph pass needs `-shell-escape`; doc-kind way, section "doc-kind specific"). W1: on CTAN and in TeX Live (ctan.org/pkg/diabetes-logbook). W2: look chosen by colour names (`oddRowColor`, `evenRowColor`, `tableColor`, `headerColor`, `curveColor`, `pageBG`), `\edef` strings and lengths (`\mym`, `\myd`, `\myRelPath`) and the `graph` option; the row cells are content. Weak point: the `\row` offset and the `yy-mm.tex` file naming are fixed in code (README.md:14, 16). W3: serves one kind of document, as `cal.kalender` and `notebook.ftc` do. W4: printable as `\usepackage[graph]{dmlb}`, `\edef`s and `\definecolor`s in the preamble, and a `longtable` wrapper of `\QQQ` rows in the body. The `graph` option is EXTERNAL when selected, as `mode=build*` is in `pg.standalone-pkg`.
- New ways proposed: `sp.ellipsis` (`ellipsis`, CTAN and TeX Live, LPPL; pdf engine; load-only fix for the uneven space around `\dots`, option `xspace`, used at dmlb.sty:74). W1: published. W2: a boolean option. W3: any text. W4: one `\usepackage` line.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
