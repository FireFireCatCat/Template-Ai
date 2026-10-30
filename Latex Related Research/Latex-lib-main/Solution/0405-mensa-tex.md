yes

# 0405-mensa-tex: mensa-tex (school cafeteria weekly menu class)

- Unverified: read from the source, not compiled.
- Source: Source/0405-mensa-tex/ (origin: https://mirrors.ctan.org/macros/latex/contrib/mensa-tex.zip; licence: LPPL 1.3c, README.md:4 and mensa-tex.cls:5)
- Kind: misc (a one-week cafeteria menu sheet, two lunches, dessert and dinner; the manifest hint `misc` is kept, no listed kind fits better)
- Lib: v4
- Engine: pdfLaTeX-compatible for the class and the example (read: mensa-tex.cls:78-93 loads no XeTeX-only package); the manual doc/mensa-tex-doc.tex needs LuaLaTeX or XeLaTeX (`fontspec`, `polyglossia`, `selnolig`; it carries `% !TeX program=lualatex`, doc/mensa-tex-doc.tex:28)
- Look carried by: class (mensa-tex.cls builds the whole menu page at `\begin{document}` from stored macros; the example adds only class options, class-native setters and content; the manual adds a documentation preamble of published packages, doc/mensa-tex-doc.tex:32-65)
- Class origin: ctan (the zip is the CTAN release, ctan.org/pkg/mensa-tex read: "Mensa-TeX", Sebastian Friedl, LPPL 1.3c, 2017-12-03; one `.cls`, no `.sty`)
- Main file: doc/mensa-tex-example.tex (other samples: doc/mensa-tex-doc.tex = the class manual and the manifest's `main`, class `ltxdoc`)
- Read: main yes (mensa-tex-example.tex 86 lines and mensa-tex-doc.tex 561 lines, both in full), zip-local classes and styles all (mensa-tex.cls, 517 lines, in full; it is the only .cls/.sty and it is the published CTAN class). Not read: the source of the packages the class and manual load; the two shipped PDFs (compiled output) and cafe-logo.png.

## Verdict
yes. `mensa-tex` is a published CTAN class, so it is one way, `class.mensa-tex`. The example uses it through one class option (`en-US`), class-native setters and data commands, and `babel` and `inputenc`; it defines no macro of its own. The manual is `ltxdoc` plus a preamble of published packages and defines no macro either (the `\renewcommand` and `\def` lines at doc/mensa-tex-doc.tex:337-492 sit inside `\verb`). No ART, no EXTERNAL, no NOTEMPLATE. The class's own code is a class internal under W1.

Reading note for other definitions: if mensa-tex.cls were treated as zip-local, the candidates for `BESPOKE/class` would be the `\AtBeginDocument` blocks that write the whole page body from stored macros (mensa-tex.cls:428-465 print layout, :506-512 app layout), and the hand-rolled `\newif` and `\ifcase\DTMfetchdow` switches (mensa-tex.cls:42-69, 264-303, 360-399). I read them as reducible, because the conditionals only choose localized strings and date patterns, and the page itself is one fixed `tabular` plus minipages (ways below). Under the rubric (W1: on CTAN) they are class internals and are not counted.

## Blockers
none

## Class setting
- Class: `class.mensa-tex` options: `app` (mensa-tex.cls:44; A6 pages, one page per day), `en-GB` (:53; default, :50-52), `en-US` (:58; used at doc/mensa-tex-example.tex:27), `german` (:67). Base class: `article` at 12pt (:35). The manual documents the same four options (doc/mensa-tex-doc.tex:136-139).
- Class-native vocabulary used by the example: `\institute{}` (example:38; cls:117), `\mensaname{}` (example:39; cls:111), `\setimage{}` (example:41; cls:213), `\startdate{YYYY-MM-DD}` (example:44; cls:144), `\monday` `\tuesday` `\wednesday` `\thursday` `\friday` with four arguments Menu 1, Menu 2, Dessert, Dinner (example:46-66; cls:219-252), `\longremarks{}` (example:68; cls:255), `\setbgcolor` `\setcolorfg` `\setctextcolor` (example:32-34; cls:201-203), colour names `\ctextcolor` (example:69; cls:197), symbols `\vgt` `\vgn` (example:46, 80; cls:135-136), `\sup{}` (example:51; cls:129).
- Defined, not used by the example: `\shortremarks{}` (cls:258; shown at doc:236-238), `\daypage` (cls:473; app mode), `\printday` (cls:122), column type `M` (cls:132), name macros `\menuname` `\dessertname` `\dinnername` `\dietname` (cls:306-309, 402-405), date macros `\shortdate` `\dowshortdate` `\longdate` `\daterange` (cls:318-331, 340-353, 408-421), `\wdayname` `\swdayname` (cls:267, 287, 363, 383). The menu is generated at `\begin{document}`, so every setter belongs in the preamble (doc/mensa-tex-doc.tex:146).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | doc/mensa-tex-example.tex:27 | `class.mensa-tex` | option `en-US` |
| base class inherited | mensa-tex.cls:35 | `class.article` | `\LoadClass[12pt]{article}` |
| type size | mensa-tex.cls:35 | `page.class-options` | 12pt |
| page geometry (print) | mensa-tex.cls:91 | `page.geometry` | a4paper, left=right=top=bottom=1.5cm, ignorehead, ignorefoot |
| page geometry (app) | mensa-tex.cls:92 | `page.geometry` | a6paper, margins 1cm, ignorehead, ignorefoot |
| head and foot | mensa-tex.cls:96 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| paragraph indent | mensa-tex.cls:99 | `sp.lengths` | `\parindent`=0pt |
| default family | mensa-tex.cls:102 | `font.family-default` | `\familydefault`=`\sfdefault` |
| text face | mensa-tex.cls:88 | `font.lmodern` | `lmodern` (Latin Modern Sans through the line above) |
| symbols and encoding | mensa-tex.cls:81; doc/mensa-tex-example.tex:30 | `font.fontenc-t1` | `textcomp` (for `\textleaf`); example `inputenc` utf8 |
| language | doc/mensa-tex-example.tex:29 | `lang.babel` | `american` |
| class localization | mensa-tex.cls:264-422 | `class.mensa-tex` | strings for menu, dessert, dinner, "Weekly menu" and weekday names chosen by the `en-GB` `en-US` `german` options |
| dates | mensa-tex.cls:84-85, 144-153, 319-331 | `front.datetime` | `datetime2` + `datetime2-calc`: `\DTMsavedate{monday}{#1}` to `{#1+4}`, `\DTMfetchday` `\DTMfetchmonth` `\DTMfetchyear` `\DTMfetchdow`, `\DTMtwodigits`; start date 2017-09-18 (example:44) |
| header block | mensa-tex.cls:430-442; example:38-41 | `front.class-native` | centred `\huge` institute, then a half-width minipage with the image and a right-aligned `\scalebox{2}` mensa name, "Weekly menu" and the date range; colour `\ctextcolor` |
| header block, scaled name | mensa-tex.cls:439 | `fig.graphicx` | `\scalebox{2}` of `\Huge` text (graphicx command) |
| header block, boxes | mensa-tex.cls:435-442 | `box.minipage` | `minipage[b][.15\textheight][b]{.5\textwidth}` and `[c]{.48\textwidth}` |
| menu table | mensa-tex.cls:444-461; example:46-66 | `front.class-native` | the five day rows are the class's data commands; the table is class output |
| menu table, machinery | mensa-tex.cls:132, 447-460 | `tbl.tabular` | `tabular` with `|>{\bfseries}M{0.95cm}*{2}{|M{5cm}}*2{|M{2.4cm}}|`, `\hline`, `\tabularnewline`; `\newcolumntype{M}[1]{>{\centering\arraybackslash}m{#1}}`; `\arrayrulewidth` 1.25pt (cls:444) |
| menu table, shading | mensa-tex.cls:446, 449 | `tbl.colortbl` | `\rowcolors{2}{\bgcolor!20}{white}`, `\rowcolor{\bgcolor}` on the header; `xcolor` option `table` (cls:80) |
| menu table, day cell | mensa-tex.cls:123-125 | `box.minipage` | `minipage[b][2.5cm][c]{.75cm}` around `\swdayname` |
| colours | doc/mensa-tex-example.tex:32-34; mensa-tex.cls:80, 195-208 | `color.xcolor` | background `blue`, text-on-box `white`, structure text `red`; defaults white, black, black |
| symbols | mensa-tex.cls:135-136 | `font.fontenc-t1` | `\vgt` = `{\rmfamily\color{green!50!black}\textleaf}`, `\vgn` two leaves (textcomp glyphs; `font.icons` considered, textcomp is named under `font.fontenc-t1`) |
| superscript alias | mensa-tex.cls:129 | `mark.kernel` | `\sup{#1}` = `\textsuperscript` |
| remarks block | doc/mensa-tex-example.tex:68-83; mensa-tex.cls:463-464 | `front.class-native` | `\longremarks{}` is printed after `\vfill` below the table |
| remarks content | doc/mensa-tex-example.tex:69-82 | `sp.manual-space`, `mark.kernel`, `color.xcolor` | `\medskip` `\bigskip` `\quad`, `\textbf{Key:}`, `\color{\ctextcolor}`; `\vfill` (cls:463) |
| app day pages | mensa-tex.cls:473-512 | `box.minipage`, `box.fancybox`, `pg.break` | per day: `\clearpage`, minipages `.58\textwidth` and `.4\textwidth`, then four `.15\textheight` minipages each headed by `\colorbox{\bgcolor}{\hbox to .975\textwidth{...}}`; `\small` |
| manual: class | doc/mensa-tex-doc.tex:32 | `class.ltxdoc` | `11pt`; the class loads `doc`, which supplies `\DescribeMacro` |
| manual: type size | doc/mensa-tex-doc.tex:32 | `page.class-options` | 11pt |
| manual: geometry | doc/mensa-tex-doc.tex:57 | `page.geometry` | left=4.50cm, right=2.75cm, top=3.25cm, bottom=2.75cm, nohead |
| manual: fonts | doc/mensa-tex-doc.tex:34 | `font.fourier` | `mathdesign` option `utopia` (the Utopia family, as 0457 filed it) |
| manual: fontspec | doc/mensa-tex-doc.tex:35, 53-55 | `font.fontspec` | `no-math`; `\setmainfont[Numbers=OldStyle]{erewhon}`, `\setsansfont[Numbers=OldStyle,Scale=MatchLowercase]{Source Sans Pro}`, `\setmonofont[...]{Source Code Pro}` |
| manual: language | doc/mensa-tex-doc.tex:37-38 | `lang.polyglossia` | `\setdefaultlanguage{english}` |
| manual: ligatures | doc/mensa-tex-doc.tex:39 | `sp.selnolig` | option `english` |
| manual: quotes | doc/mensa-tex-doc.tex:43, 72, 109 | `lang.csquotes` | `\enquote{}` and `\enquote*{}` |
| manual: hyperlinks | doc/mensa-tex-doc.tex:45, 62, 65 | `meta.hyperref` | `\hypersetup{pdftitle={The mensa-tex class},pdfauthor={Sebastian Friedl}}`; `\href` |
| manual: urls | doc/mensa-tex-doc.tex:61, 106 | `meta.url` | `\url{}` |
| manual: colour | doc/mensa-tex-doc.tex:48, 146, 257 | `color.xcolor` | `\color{red}`, `\color{green!50!black}` |
| manual: spacing | doc/mensa-tex-doc.tex:51, 59 | `sp.lengths`, `sp.hyphenat` | `\parindent`=0pt; `\hyphenation{}` (empty list) |
| manual: title block | doc/mensa-tex-doc.tex:61-63, 68 | `front.maketitle` | `\title` with `\\ {\large\url{...}}`, `\author` with `\href` mail, `\date{2017/12/03}`, `\maketitle` |
| manual: title page style | doc/mensa-tex-doc.tex:69 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| manual: epigraph-like block | doc/mensa-tex-doc.tex:71-74 | `sp.ragged`, `mark.kernel` | `center` environment with `\itshape`, `\textsc{\upshape ...}`; `quote.epigraph` not used |
| manual: abstract | doc/mensa-tex-doc.tex:77-80 | `abs.kernel` | `abstract` with `\noindent` |
| manual: contents | doc/mensa-tex-doc.tex:83, 90, 99, 120 | `toc.kernel` | `\tableofcontents`; `\addcontentsline{toc}{subsection}{...}` |
| manual: headings | doc/mensa-tex-doc.tex:89, 130, 144, 148, 226, 407 | `head.kernel` | numbered `\section` `\subsection` `\subsubsection`; unnumbered `\subsection*`, `\subsubsection*` |
| manual: page breaks | doc/mensa-tex-doc.tex:85, 124, 212, 462 | `pg.break` | `\clearpage`; `\nopagebreak[4]`, `\pagebreak[0]` |
| manual: lists | doc/mensa-tex-doc.tex:111, 135-140, 193-198, 408 | `list.kernel`, `sp.lengths` | `itemize` with `\itemsep 0pt`, `\item[\texttt{app}]` labels, `enumerate` with `\itemsep0pt` |
| manual: columns | doc/mensa-tex-doc.tex:46, 92, 192, 202 | `cols.multicol` | `multicols` with 3, 4 and 2 columns |
| manual: tables | doc/mensa-tex-doc.tex:168-178, 310-326, 442-445 | `tbl.tabular`, `cap.kernel`, `xref.kernel` | `table[b]` and `table` floats with `\sffamily` `\small`, `\arraystretch`=1.25, `>{\centering\ttfamily}m{.25\textwidth}<{\arraybackslash}` columns, `\multicolumn`, `\hline\hline`; `\caption`, `\label` and `\ref` (doc:166, 305) |
| manual: tabbing demo | doc/mensa-tex-doc.tex:203-209 | `tbl.tabular` | kernel `tabbing` with `\kill` and `\=`, filed under the kernel table way (judgement call, as 0053 did) |
| manual: macro index | doc/mensa-tex-doc.tex:153, 163, 185, 189 | `dtx.doc` | `\DescribeMacro{\mensaname}` and the other documented macros |
| manual: code | doc/mensa-tex-doc.tex:131, 212-215, 336-353 | `code.verbatim` | `\verb|...|` lines |
| manual: spacing and type | doc/mensa-tex-doc.tex:76, 98, 133, 257, 559 | `sp.manual-space`, `font.size-commands`, `mark.kernel` | `\medskip` `\bigskip` `\smallskip` `\\[\medskipamount]`; `small` environment; `\textit` `\texttt` `\sffamily` `\rmfamily` |
| manual: symbols | doc/mensa-tex-doc.tex:47, 100 | `font.fontenc-t1` | `textcomp`, `\textcopyright` |
| manual: boxed output | doc/mensa-tex-doc.tex:41, 560 | `math.amsmath`, `fig.graphicx` | `$\boxed{\text{\includegraphics[width=.95\textwidth]{mensa-tex-example}}}$`, the shipped PDF of the example output |

## Bespoke code
All macros live in the published class; the example and the manual define none. Rows are for the record, under a zip-local reading (see the reading note).
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option switches `\if@print` `\if@english` `\if@engb` `\if@enus` `\if@german` | mensa-tex.cls:42-69 | yes, if read as zip-local | class options of `class.mensa-tex`; only select strings and date patterns |
| name and date macros per language (`\wdayname`, `\swdayname`, `\shortdate`...) | mensa-tex.cls:264-422 | yes, if read as zip-local | `\ifcase\DTMfetchdow` strings and `datetime2` field fetches, as `front.datetime` calls |
| storage macros for days, colours, image, remarks | mensa-tex.cls:109-258 | yes | `\def` and `\renewcommand` setters, expand inline into the page they feed |
| `\vgt` `\vgn` `\sup` `\printday` | mensa-tex.cls:122-136 | yes | aliases of `\textleaf` with colour, `\textsuperscript`, and a minipage around `\swdayname` |
| `\newcolumntype{M}` | mensa-tex.cls:132 | yes | `array`'s `m` column with `\centering\arraybackslash` |
| page body written at `\begin{document}` (print and app) | mensa-tex.cls:428-465, 471-513 | arguable, read as reducible if zip-local | one `tabular` with `colortbl` shading and `minipage`s; no output routine, no `\halign` |

## Content-opaque
Image `cafe-logo` at doc/mensa-tex-example.tex:41 (the file is doc/cafe-logo.png, public domain, README.md:7) and the included PDF `mensa-tex-example` at doc/mensa-tex-doc.tex:560 are included images, content. No TikZ, PGF, `picture` or PSTricks in any file (grepped).

## Lib changes
- New ways proposed: none. Judgement calls, no new way: `mathdesign[utopia]` under `font.fourier` (0457 did the same); kernel `tabbing` under `tbl.tabular` (0053, 0191); `\textleaf` (textcomp) under `font.fontenc-t1`, `font.icons` considered; `\colorbox` under `box.fancybox`; the class-native `\monday`...`\friday`, `\longremarks`, `\institute`, `\mensaname`, `\setimage` under `front.class-native`; `\scalebox` under `fig.graphicx` (a graphicx command).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Missing assets: the fonts `erewhon`, Source Sans Pro and Source Code Pro used only by the manual (doc/mensa-tex-doc.tex:53-55) are not shipped.
