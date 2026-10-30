yes

# 0928-suai-report: suai-report (SUAI student reports, GOST 7.32-2017)

- Unverified: read from the source, not compiled.
- Source: Source/0928-suai-report/ (origin: https://mirrors.ctan.org/macros/xetex/latex/suai-report.zip; licence: MIT)
- Kind: report
- Lib: v6
- Engine: needs XeLaTeX (suai-report.sty:8-9 `\RequireXeTeX`; `fontspec` at :16; `\XeTeXinterchartoks` at :90-98)
- Look carried by: class (the whole look is in `suai-report.sty`, a CTAN package of the house-style kind, loaded under `extarticle`; the sample adds only `\suaisetup` values and content)
- Class origin: ctan (`suai-report` v2.7 of 2026-10-05, Grigorii Moiseev, MIT, CTAN `/macros/xetex/latex/suai-report`, page ctan.org/pkg/suai-report read; the document class `extarticle` is from the `extsizes` bundle in the TeX distribution, not in the zip, source not read)
- Main file: suai-report-demo.tex (other samples: suai-report-template.tex)
- Read: main yes, zip-local classes and styles all (`suai-report.sty` lines 1-1506; template, README read; CHANGELOG only grepped; the PDF and PNG not read)

## Verdict
yes. The zip is the CTAN release of the package `suai-report`, so the style file is published (W1) and is not zip-local bespoke code. The sample (demo and template) defines no macro, counter or environment of its own: it loads `extarticle` with `a4paper,14pt`, loads the package, sets string keys with `\suaisetup`, and writes content in the package's own block syntax (line-based `\suaitasks`, `\suailist`, `\suaitable`, `\suaieq`, `\suaisources`, `\suaicode`). An emitter can print that with `class.extarticle`, `class.suai-report` and body wrappers only. The package internals (expl3 line reader, table-width algorithm, XeTeX break classes) are irreducible to other lib ways, so the `yes` rests on counting `class.suai-report` as a class-like way (as `class.chs-physics-report` and `class.thesis-titlepage-fhac` were in v6); they are listed under "Bespoke code" for re-reading under a stricter definition. This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.extarticle` options: `a4paper`, `14pt` (suai-report-demo.tex:9; suai-report-template.tex:3). Class-like package way: `class.suai-report` (no options; `\usepackage{suai-report}` at suai-report-demo.tex:10).
- Class-native vocabulary used (`class.suai-report`): `\suaisetup{department, teacher-post, teacher, type, number, title, course, group, student, date}` (suai-report-demo.tex:14-27; keys defined at suai-report.sty:393-412, also `course-label`, `city`, `year`), `\maketitle` (redefined, suai-report.sty:495-537), `\suaitoc` (:149), `\suaiintro` (:130), `\suaiconclusion` (:131), `\suaitasks` (:793-801), `\suailist` (:787-788), `\suaitable[label]{caption}` (:1199-1200), `\suaieq[label]{formula}` (:1251-1252), `\suaiimg[width]{file}{caption}[label]` (:573-583), `\suaicode[lang, label]{caption}` (:1325-1339), `\suaisources` (:1269-1270), `\figref` `\tabref` `\lstref` `\formref` (:550-553). Defined by the package but not used by the sample: `\suaienum` (:789), `\suainum` (:791), `\suaiapp` (:368), `\suaisection` (:125), `gostenum` list (:204), `code` environment (:1504), `\suaitablestretch` hook (:175).

## Component map
Every row below is realised inside `suai-report.sty` and loaded unchanged; the Way column names the component way each part reduces to, `class.suai-report` where the part is the package's own mechanism.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | suai-report-demo.tex:9 | `class.extarticle` | a4paper, 14pt |
| class-like house style | suai-report-demo.tex:10; suai-report.sty:6 | `class.suai-report` | package v2.7, no options, `\suaisetup` string keys |
| paper and size | suai-report-demo.tex:9 | `page.class-options` | a4paper, 14pt |
| page geometry | suai-report.sty:18-19; title page :496, :536 | `page.geometry` | a4paper, left=30mm, right=15mm, top=20mm, bottom=20mm, footskip=12mm, headsep=0pt; title page `\newgeometry` left=30mm,right=10mm; `\restoregeometry` |
| page style | suai-report.sty:68, :497 | `hf.pagestyle-kernel` | `plain`; title page `\thispagestyle{empty}` |
| page counter | suai-report.sty:537 | `pgnum.pagenumbering` | `\setcounter{page}{2}` after the title page |
| line spacing | suai-report.sty:52, :176-178 | `sp.setspace` | `\onehalfspacing`; table `\setstretch{\suaitablestretch}` through env hooks (empty by default) |
| paragraph and display lengths | suai-report.sty:55-61 | `sp.lengths` | parindent=1.25cm, parskip=0pt, `\above/belowdisplay(short)skip`=`\baselineskip` at begin document |
| widow and club | suai-report.sty:62-63 | `sp.penalties` | `\clubpenalty`=10000, `\widowpenalty`=10000 |
| first-line indent | suai-report.sty:20 | `sp.indentfirst` | load-only |
| microtype | suai-report.sty:20 | `sp.microtype` | load-only, defaults |
| line-break tolerance | suai-report.sty:65-66 | `sp.lengths` | `\emergencystretch`=3em; `\tolerance`=1000 is an integer parameter (package-internal, nearest lib line is `sp.hyphenat`, `\sloppy` type) |
| break classes in long words | suai-report.sty:75-98 | `class.suai-report` | `\XeTeXintercharclass`, `\XeTeXinterchartoks` insert `\penalty50` after `_ / = + ! -` (package-internal, see Bespoke code) |
| fonts | suai-report.sty:16, :43-46 | `font.fontspec` | `\setmainfont` Times New Roman (fallback TeX Gyre Termes), `\setsansfont` Liberation Sans (fallback TeX Gyre Heros), `\setmonofont` Liberation Mono (fallback TeX Gyre Cursor, Scale=MatchLowercase) |
| language | suai-report.sty:17 | `lang.babel` | english, russian (russian main) |
| quotes package | suai-report.sty:26 | `lang.csquotes` | load-only (for biblatex) |
| colours | suai-report.sty:213-218 | `color.xcolor` | `\definecolor` HTML: suaiFrame B5B5B5, suaiNumber 8A8A8A, suaiKeyword 0B4F9E, suaiComment 5C7A5C, suaiString A03030, suaiBack F5F6F7 |
| title block | suai-report-demo.tex:14-27, :31; suai-report.sty:495-537 | `front.class-native` | `\maketitle` rebuilt: form of the GUAP title sheet from strings (department, teacher-post, teacher, type, number, title, course, group, student, date, city, year); vertical glue in bp, `\makebox`, `\parbox`, `\rule`, no drawing package |
| title-form rules and cells | suai-report.sty:473-493 | `sp.rule` | `\rule[-3.25bp]{w}{0.5bp}` under each cell; `\suai@cell` `\parbox`/`\makebox` (`box.minipage`) |
| title-form spacing | suai-report.sty:485-487 | `sp.manual-space` | `\vskip\glueexpr` with `minus` shrink, `\hspace` fractions of `\textwidth` |
| intro and conclusion headings | suai-report-demo.tex:35, :94; suai-report.sty:125-131 | `head.class-native` | `\clearpage`, `\phantomsection`, `\section*`, `\addcontentsline{toc}{section}` with `\MakeUppercase` |
| heading looks | suai-report.sty:103, :111-122 | `head.titlesec` | `\titleformat` section, subsection, subsubsection `[block]` bold 14/17 pt `\raggedright`, label indented by `\parindent`, sep 0.6em; numberless section `\filcenter` + `\MakeUppercase`; `\titlespacing` 0pt/14pt before-after |
| heading font | suai-report.sty:103 | `font.size-commands` | `\fontsize{14}{17}\selectfont\bfseries` |
| section on new page | suai-report.sty:123 | `pg.break` | `\sectionbreak{\clearpage}` (titlesec hook) |
| uppercase | suai-report.sty:118, :129 | `mark.case` | `\MakeUppercase` |
| heading depth | suai-report.sty:104-105 | `num.secnumdepth` | secnumdepth=3, tocdepth=3 |
| contents | suai-report-demo.tex:32; suai-report.sty:133-149 | `toc.tocloft` | `\cfttoctitlefont`, title skips 0pt/14pt, `\cftsecleader`=`\cftdotfill`, indents 0, 1.7em, 4.3em, num widths 1.7em, 2.6em, 3.4em; `\suaitoc`=`\clearpage\tableofcontents` (`toc.kernel`); `\contentsname`=СОДЕРЖАНИЕ |
| captions | suai-report.sty:155-163 | `cap.caption` | labelsep=emdash (`\DeclareCaptionLabelSeparator`), font={normalsize,stretch=1}, skip=6pt; figure: name=Рисунок, position=below, justification=centering; table: name=Таблица, position=above, justification=raggedright; lstlisting: position=above, singlelinecheck=false |
| lists | suai-report.sty:187-192; suai-report-demo.tex:57-60 | `list.enumitem` | `\setlist` nosep, topsep/partopsep/parsep/itemsep=0pt, wide=`\parindent`, labelsep=0.5em; level 2 wide=2cm; itemize label `--`; enumerate label `\arabic*)` |
| task list | suai-report-demo.tex:40-44; suai-report.sty:793-801; :204-206 | `list.enumitem` | `\newlist{gostenum}{enumerate}{2}`, label `\gostletter*)` then `\arabic*)`; intro sentence in `\suaitasks[...]`; punctuation `;` and final `.` added by the reader (:732-785) |
| Cyrillic list letters | suai-report.sty:195-202 | `num.counters` | `\AddEnumerateCounter{\gostletter}{\suai@lower}{я}`, `\ifcase` of 24 letters (see Bespoke code) |
| table env | suai-report-demo.tex:66-70; suai-report.sty:24, :165-170, :1177-1196 | `tbl.longtable` | `xltabular{\textwidth}`, `\caption` inside, `\endfirsthead`, `\endhead`, continuation `\multicolumn` "Продолжение таблицы", `\hline`, `\LTcapwidth`=`\textwidth` |
| table columns | suai-report.sty:166-169, :1104-1125 | `tbl.tabularx` | `X` columns with `\hsize` fractions; `\newcolumntype` P, L, R, Y; `\arraystretch`=1.25 (`tbl.tabular`, `array`) |
| table width algorithm | suai-report.sty:817-1125 | `class.suai-report` | four measured width levels per column (see Bespoke code) |
| equations | suai-report-demo.tex:75-78; suai-report.sty:21, :1236-1249 | `math.amsmath` | `equation` + `\label{eq:..}`; `amssymb` (`math.amssymb`) |
| symbol explanation block | suai-report.sty:1210-1234 | `sp.lengths` | `где` box, `\hangindent`=width of box, `\hangafter`=1; `\nobreakspace\textemdash`; items end `;` and `.` |
| figures | suai-report-demo.tex:54; suai-report.sty:22, :67, :574-583 | `fig.graphicx` | `\includegraphics[width=min(0.8\textwidth,\linewidth), height=0.75\textheight, keepaspectratio]`, `\centering`, `\graphicspath{{images/}{./}}` |
| figure placement | suai-report.sty:575 | `fig.float` | `figure[H]` |
| code listings | suai-report-demo.tex:86-91; suai-report.sty:25, :226-253 | `code.listings` | `\lstdefinestyle{gost}`: basicstyle `\ttfamily\fontsize{12}{14.4}`, numbers=left, frame=single, rulecolor suaiFrame, framesep 7pt, breaklines, postbreak `\hookrightarrow`, tabsize=4, columns=fullflexible, upquote, captionpos=t, above/belowskip 12pt; `gostcolor` adds backgroundcolor, keyword/comment/string colours; `\lstset{style=gost}` |
| listing languages | suai-report.sty:273-339, :344-354 | `code.listings` | `\lstdefinelanguage` JavaScript, TypeScript, Kotlin, Rust, JSON, YAML, Dockerfile; `\lstalias` cpp, cs, csharp, js, ts, py, kt, rs, yml, docker; `\lstlistingname`=Листинг |
| inline code reader | suai-report.sty:1325-1500 | `class.suai-report` | `\suaicode` collects indented lines, writes `\jobname.code`, calls `\lstinputlisting` (TeX only, see Bespoke code) |
| sources list | suai-report-demo.tex:101-103; suai-report.sty:1258-1270 | `list.enumitem` | `\suaisection{Список использованных источников}`, `enumerate[label=\arabic*., wide=\parindent]`; with no lines it calls `\printbibliography[heading=none]` if defined (`bib.biblatex-biber`, not used by the sample) |
| cross references | suai-report-demo.tex:52, :64, :74, :84; suai-report.sty:549-553, :565-571 | `xref.kernel` | `\ref` with `\ifcsname r@..`; `\figref` etc. print "рисунке~N"; auto label `fig:<file base>` |
| PDF links and metadata | suai-report.sty:542-547 | `meta.hyperref` | `hidelinks`, `bookmarksnumbered`; `\hypersetup{pdftitle, pdfauthor, pdflang={ru-RU}}` |
| bookmarks and url | suai-report.sty:543 | `meta.bookmark` | load-only; `xurl` (`meta.url`) load-only |
| appendices (unused by sample) | suai-report.sty:359-384 | `num.appendix` | `\suaiapp[status]{title}`, counter `suaiapp`, `\the<counter>` redefined to letter.number (`num.counters`) |
| bold and italic marks | suai-report.sty:103, :244, :250 | `mark.kernel` | `\bfseries`, `\itshape` |

## Bespoke code
All items sit in `suai-report.sty`, a published CTAN package loaded unchanged, so none is zip-local bespoke code and none is a blocker under the rubric. Column 3 records what they would be if the package were counted zip-local, so the file can be re-read under another definition.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| XeTeX inter-character break classes | suai-report.sty:75-98 | no (would be BESPOKE/class) | none in the lib; engine-level token classes |
| line-block reader `\suai_read_lines:n` (catcode 13 switch, reads to blank line) | suai-report.sty:594-701 | no (BESPOKE/class) | none; it is the input syntax of the package |
| list punctuation by regex | suai-report.sty:732-767 | no (BESPOKE/class) | none; computes `;` and `.` per item |
| table width algorithm (four widths per column, box measuring, `\fp_eval`) | suai-report.sty:817-1200 | no (BESPOKE/class) | none; only the result (`xltabular` with `X` columns) is lib ways |
| equation explanation block | suai-report.sty:1207-1252 | partly | `equation` plus hanging paragraphs (`sp.lengths`); the line parsing is the reader above |
| inline code reader and `.code` temp file | suai-report.sty:1325-1500 | no (BESPOKE/class) | result is `code.listings`; written and read in one TeX run, no shell escape |
| `listings` character-table hook for Cyrillic | suai-report.sty:258-269 | no (BESPOKE/class) | internal patch of `listings` for XeTeX |
| `\lstdefinelanguage`, `\lstalias`, `\lstdefinestyle` | suai-report.sty:226-339 | yes | `code.listings` declarations |
| language-probe override of `\KV@lst@language` | suai-report.sty:344-354 | no (BESPOKE/class) | internal patch of `listings` keys |
| title page `\maketitle` and `\suaisetup` keys | suai-report.sty:392-537 | partly | strings into `front.class-native`; the geometry and glue are fixed in the package |
| `\gostletter` list counter | suai-report.sty:195-206 | partly | `\newlist`/`\setlist` are `list.enumitem`; the `\ifcase` letter table is a hand-rolled counter print (BESPOKE/class) |
| appendix counters | suai-report.sty:359-384 | partly | `\newcounter`, `\the..` redefinitions (`num.counters`); not used by the sample |
| sample body and preamble macros | suai-report-demo.tex:1-105; suai-report-template.tex:1-40 | n/a | none defined: no `\newcommand`, `\def`, environment or counter |

## Content-opaque
- Included picture `images/scheme.png` in the figure (suai-report-demo.tex:54): content, shipped asset.
- Table cell text (suai-report-demo.tex:67-70), equation and symbol list (:75-78), bash code text (:87-91), source entries (:102-103), report text: content.
- Notes: Times New Roman, Liberation Sans and Liberation Mono are not shipped; the package falls back to TeX Gyre fonts (suai-report.sty:43-46). The `suai` command-line tool, Makefile and VS Code settings named in the README (README.md:55-57) and the `make new` comment (suai-report-demo.tex:3) are not in the zip and the sample does not need them. No text addressed to an AI was found in the zip.

## Lib changes
- New ways proposed: none (`class.extarticle` and `class.suai-report` are class ways, written plainly; `class.suai-report` is a house-style package of one institution, as `class.chs-physics-report` in v6).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
