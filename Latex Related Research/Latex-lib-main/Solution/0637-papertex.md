yes

# 0637-papertex: paperTeX (newspaper class)

- Unverified: read from the source, not compiled.
- Source: Source/0637-papertex/ (origin: https://mirrors.ctan.org/macros/latex/contrib/papertex.zip; licence: lppl1.2)
- Kind: newsletter
- Lib: v5
- Engine: pdfLaTeX-compatible (README:20-21 asks for PDFLaTeX; the class picks `pdftex` drivers at papertex.dtx:462-465 and puts images inside `\ifpdf` at papertex.dtx:1170, 1202, 1225)
- Look carried by: class (the sample adds only options, `\edition`, a counter value and class-native environments; everything visible is defined by `papertex`, whose source is papertex.dtx)
- Class origin: ctan (the zip is the CTAN package itself; ctan.org/pkg/papertex read: v1.2b, LPPL 1.2, included in TeX Live and MiKTeX, no dependencies listed)
- Main file: example/example.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (no .cls or .sty ships; the class source papertex.dtx was read in full, lines 1-1662, with papertex.ins, README and CHANGES; the shipped PDFs and the four .jpg files were not read)

## Verdict
The look is carried by the published CTAN class `papertex`. The sample only sets class options (example/example.tex:21), `\edition`, the class counter `\minraggedcols`, and calls class-native environments (frontpage, news, editorial, shortnews). It defines no macro, length, colour or environment of its own (every `\renewcommand` and `\definecolor` at example/example.tex:30-40 is commented out). The class loads only published packages, needs no tool outside TeX, and draws no TikZ, PGF or picture artwork. An emitter writes `\documentclass[...]{papertex}`, three `\usepackage` lines and the class-native calls, so no zip-local logic is copied. The class-internal conditionals (free-space test in `\image`, page-left test in `\newssep`) belong to the published class and are covered by `class.papertex`; this reaches `yes` under the rubric ruling on class-carried looks and is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.papertex` options: `10pt` (passed to article, papertex.dtx:409), `hyphenatedtitles` (papertex.dtx:427; sets the internal boolean that gates `\nohyphens` on titles to false), `final` (not among the options the class declares, papertex.dtx:409-430; its effect was not traced). Own options the sample does not use: `9pt`, `a3paper`, `columnlines`, `showgrid` (papertex.dtx:426-430); `twocolumn`, `twoside`, `notitlepage` only warn (papertex.dtx:416-421). Base class: article loaded with `10pt, onecolumn, titlepage, a4paper` (papertex.dtx:437).
- Class-native vocabulary used: `\edition{}` (example/example.tex:44), counter `\minraggedcols=3` (example/example.tex:50), `frontpage` environment (example/example.tex:56-100) with `\firstimage` `\firstnews` `\secondnews` `\thirdnews`, `indexblock` + `\indexitem`, `weatherblock` + `\weatheritem`, `authorblock`; `\newsection`, `news`, `\authorandplace`, `\image`, `\timestamp`, `\columntitle`, `\expandedtitle`, `\newssep`, `editorial`, `shortnews` + `\shortnewsitem` (example/example.tex:102-200). Customisation hooks the class offers but the sample leaves unused: `\logo` `\mylogo` `\minilogo` `\heading` `\foot` and the `\...Format` commands (papertex.dtx:565-811, 629, 646, 991-1022).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | example/example.tex:21; papertex.dtx:437 | `class.papertex` | options 10pt, final, hyphenatedtitles; article base fixed at 10pt onecolumn titlepage a4paper |
| paper and size | papertex.dtx:437, 426, 430 | `page.class-options` | a4paper fixed; `a3paper` and `9pt` are own options (the sample uses neither); 10pt from the sample |
| page geometry | papertex.dtx:453-457 | `page.geometry` | headsep=0.5cm, vmargin={2cm,2cm}, hmargin={1.5cm,1.5cm} (the a3paper variant adds `a3paper`); loaded by the class |
| front page layout | example/example.tex:56-100; papertex.dtx:474, 922, 936-970, 391-394, 1079-1082 | `pg.textpos` | `textpos[absolute]`, `\textblockorigin{1cm}{1cm}`, a 50 by 40 module grid; each front block sits at a fixed grid cell, e.g. firstnews at (22,5) width 24 (28 with `hyphenatedtitles` off); positions are fixed in the class |
| front page blocks | example/example.tex:58-98; papertex.dtx:1034-1061, 1075, 1113, 1151, 1197, 1222, 1251, 1287, 1317, 1350 | `front.class-native` | `frontpage`; `\firstimage{file}{caption}`; `\firstnews{title}{text}{time}`; `\secondnews{title}{subtitle}{text}{section}{time}`; `\thirdnews{title}{subtitle}{text}{image}{section}{time}`; `indexblock{title}` with `\indexitem{text}{label}`; `weatherblock{title}` with `\weatheritem{icon}{day}{max}{min}{desc}`; `authorblock` |
| masthead (logo, edition, date line) | example/example.tex:44; papertex.dtx:991-1003, 1028, 564-570, 593-597 | `front.class-native` | `\edition{my papertex edition}`; default `\logo` is `\hrulefill`, edition, www string, the word paperTeX in two fonts, `\hrulefill`, date and time |
| date and time | papertex.dtx:444, 1485-1487, 596 | `front.datetime` | class loads `datetime`; `\date` redefined to `\longdate{\today}`; time as `\currenttime h` |
| title commands | example/example.tex:42-43; papertex.dtx:255, 827-860 | `front.maketitle` | `\author{Ignacio Llopis}` `\title{my first paperTeX}` only; `\maketitle` is commented out at example/example.tex:54 and the class redefines it (papertex.dtx:827); the manual says `\author`, `\title` have no effect without it (papertex.dtx:255) |
| news article headings | example/example.tex:104-108, 124-128, 153-157, 180, 190; papertex.dtx:1520-1538, 1590-1605, 1628-1642, 1515 | `head.class-native` | `news{cols}{title}{subtitle}{section}{label}`, `editorial{cols}{title}{author}{label}`, `shortnews{cols}{title}{subtitle}{label}`; sample columns 3, 4, 4, 1, 4; filed here because the class has no sectioning commands (papertex.dtx:1515) and the news environment is its heading unit; formats `\innerTitleFormat` `\Huge` (733), `\innerSubtitleFormat` `\large` (748) |
| news columns | papertex.dtx:445, 1524, 1593, 1631, 984, 362, 428 | `cols.multicol` | class opens `multicols{n}[heading][4cm]`; `\columnseprule` = `\columnlines`, 0pt default, 0.1pt with option `columnlines`; the sample's `\columnsep` line is commented out (example/example.tex:46) |
| ragged text rule | example/example.tex:50; papertex.dtx:402, 486-487, 1532-1534 | `sp.ragged` | `\minraggedcols=3`; a news is set ragged when its column count is greater than the counter; `\raggedFormat` = `\RaggedRight` from `ragged2e` |
| title hyphenation | example/example.tex:21; papertex.dtx:475, 427, 661 | `sp.hyphenat` | `\nohyphens{...}` around titles unless option `hyphenatedtitles` |
| title line spacing | papertex.dtx:478, 658, 677, 700 | `sp.setspace` | `spacing` environment: 2.0 (first title), 1.5 (second, third) |
| byline and time stamp | example/example.tex:109, 114; papertex.dtx:1492-1497, 757-761 | `head.class-native` | `\authorandplace{author}{place}` (`\footnotesize`, `\footnotesize\bfseries`); `\timestamp{08:25}` (`\small`, colour `color`, text `h`, separator `\|`) |
| section tag and bookmark | example/example.tex:102, 150; papertex.dtx:1503-1506, 726 | `head.class-native` | `\newsection{name}` sets the running-head section name and a PDF bookmark; the tag is printed with `\MakeUppercase` |
| in-article titles | example/example.tex:116, 139, 171; papertex.dtx:1385-1426, 1439-1478 | `head.class-native` | `\columntitle{lines}{..}`, `\expandedtitle{doublebox}{..}`, `\expandedtitle{lines}{..}`; type is one of shadowbox, doublebox, ovalbox, Ovalbox, lines; `\fboxsep` 5pt, `\shadowsize` 2pt |
| frames of the title boxes | papertex.dtx:447, 1392-1407, 873-875, 985 | `box.fancybox` | `fancybox` `\shadowbox` `\doublebox` `\ovalbox` `\Ovalbox`; block frames use `\fbox` of an lrbox, `\fboxrule` 0.1pt |
| block interiors | papertex.dtx:580-582, 1224-1234, 1263, 1293, 1327 | `box.minipage` | `minipage` of 13 or 32 grid modules, 45pt and 50pt for weather cells |
| image in a news | example/example.tex:111, 161; papertex.dtx:884-917, 716-719 | `fig.class-native` | `\image{file}{caption}`: width `\columnwidth` minus `\columnsep`, `keepaspectratio`, `\fbox` with `\fboxsep` 1pt, inserted only when `1.5*width+50pt < \page@free`; caption by `\pictureCaptionFormat` = `\small\bfseries` (not `\caption`) |
| image drawing | papertex.dtx:463, 905, 1171, 1203, 1226 | `fig.graphicx` | `graphicx[pdftex]` `\includegraphics[width=...]` (images example/img/ireland.jpg and example/img/weather/*.jpg are shipped) |
| wrapped image | papertex.dtx:476, 1168-1173 | `fig.wrapfig` | `wrapfigure{r}{.3\textwidth}`, only when `\thirdnews` gets an image argument (the sample does: example/example.tex:72) |
| running head and foot | papertex.dtx:446, 617-650, 979-982, 1048-1056 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\headheight` 14pt, `\headrulewidth` 0.4pt; fields L, C, R filled from class macros |
| running head and foot content | papertex.dtx:617-627, 638-644, 629, 646 | `hf.class-native` | head: logo words and date, section name, edition and page; foot: copyright and "Created using paperTeX"; changed by `\heading`/`\foot` (unused) |
| front page style | papertex.dtx:1037, 1043 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` at the start and end of `frontpage` |
| page X of Y | papertex.dtx:477, 626 | `pgnum.lastpage` | `\thepage\ / \pageref{LastPage}` |
| page break | papertex.dtx:1044-1045 | `pg.break` | `\clearpage\newpage` at end of `frontpage` |
| news separator | example/example.tex:122, 148, 178, 188, 199-200; papertex.dtx:1545-1561 | `sp.rule` | `\newssep`: `\hrule` between news, drawn only when the page-left test passes |
| separator spacing and line break | papertex.dtx:1556-1558; example/example.tex:96 | `sp.manual-space` | `\vspace*{10pt plus 10pt minus 5pt}` above and `\vspace*{10pt plus 5pt minus 5pt}` below the rule; `\\[5pt]` in the author block |
| end-of-news mark | papertex.dtx:779, 1536 | `sp.rule` | `\innerTextFinalMark` = `\rule{0.65em}{0.65em}`, printed after the last character |
| logo faces | papertex.dtx:618-619, 997-998, 1006-1007 | `font.nfss` | `\usefont{T1}{bch}{b}{n}` (Charter bold) and `\usefont{T1}{pag}{m}{n}` (Avant Garde); the font families are not shipped (asset note, not checked here) |
| font sizes | papertex.dtx:655, 675, 698, 733, 804-816, 507-538 | `font.size-commands` | first title `\Huge\sffamily\bfseries`, second `\LARGE`, third `\Large`; `\fontsize{10mm}{12mm}` in the logo (997); `9pt` option renews the size commands (unused here) |
| font switches | papertex.dtx:565, 575, 788-794; example/example.tex:93, 96 | `mark.kernel` | `\sffamily` `\bfseries` `\texttt` `\textsc` `\textbf` in format macros and in the sample |
| upper case | papertex.dtx:726 | `mark.case` | `\MakeUppercase` on the section tag |
| colour | papertex.dtx:463, 548-550, 568, 587, 604 | `color.color` | legacy `color[pdftex]`; `color` cmyk{0.5,0,1,0.5}, `max` cmyk{0,0.5,0.5,0.5}, `min` cmyk{0.5,0,0.5,0.5}; `\textcolor` |
| input encoding | example/example.tex:23, 25 | `font.fontenc-t1` | `inputenc[latin1]`; `fontenc[T1]` is commented out |
| language | example/example.tex:24 | `lang.babel` | `babel[latin]` |
| underline package | example/example.tex:26 | `mark.ulem` | `ulem` loaded with no options; no ulem command in the body |
| links and bookmarks | example/example.tex:96-97; papertex.dtx:464, 1038, 1504, 1530 | `meta.hyperref` | `hyperref[pdftex]` loaded by the class; `\href{mailto:..}{..}` and `\href{http://..}{..}`; `\pdfbookmark` |
| labels in the index | example/example.tex:77-83, 108, 128, 157; papertex.dtx:1353, 1531 | `xref.kernel` | `news` fifth argument sets `\label`; `\indexitem` prints `\pageref` of it |
| editorial heading rule | papertex.dtx:1569-1583, 1570 | `tbl.tabular` | one-column `tabular{c}` with `\hline`, `\arrayrulewidth` 0.1pt, title above and author below |

Components the sample does not use: lists, quotes, footnotes, notes, math, theorems, floats with `\caption`, code, bibliography, contents lists, abstract, makeindex (removed, CHANGES:29).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| sample macros | example/example.tex:23-50 | none exist | only `\usepackage`, `\author`, `\title`, `\edition`, `\minraggedcols=3`; the `\renewcommand` and `\definecolor` lines (30-40, 46) are comments |
| `\image` free-space test | papertex.dtx:884-917 | not zip-local | in the published class; the emitter calls `\image{file}{caption}` (`fig.class-native`) |
| `\newssep` page-left test | papertex.dtx:1545-1561 | not zip-local | in the published class; the emitter calls `\newssep` (`sp.rule`) |
| `\grid` and textpos front-page cells | papertex.dtx:936-970, 1075-1215 | not zip-local | in the published class; the emitter writes `frontpage` and its block commands (`front.class-native`, `pg.textpos`) |
| `\expandedtitle` closes and reopens `multicols` | papertex.dtx:1385-1426 | not zip-local | in the published class; called by name with a type and a text |
| `\maketitle` and `\date` redefinitions | papertex.dtx:827-860, 1485-1487 | not zip-local | in the published class; the sample never calls `\maketitle` (example/example.tex:54) and `\date` is read as `\longdate{\today}` |
| `\minraggedcols` counter | example/example.tex:50; papertex.dtx:402-403, 497, 501, 1532 | not zip-local | a documented integer setting of the published class (papertex.dtx:288-296); the emitter writes `\minraggedcols=3` after `\documentclass`; the class lowers the counter by one at load (papertex.dtx:497, 501), before the sample's assignment, so the test `n > counter` makes only the 4-column news ragged, where the manual says 3 or more (papertex.dtx:291-292); the integer is copied unchanged either way |
| author's note on `datetime.sty` | papertex.dtx:1482-1483 | not a blocker | the author says he adapted his own copy of `datetime.sty`; no such file ships here and the class calls the published package; that stock `datetime` offers `\longdate` was not established; no `.sty` of any kind is zip-local |

Notes: README:10-11 and papertex.dtx:96 mention a Perl script that fills the `.tex` from a database. It is the author's own workflow; the example is plain LaTeX and needs no tool, so it is not `EXTERNAL`. papertex.ins:38 generates `papertex.cls` from the dtx with DocStrip (a TeX run); the published class is in TeX Live and MiKTeX. Nothing in the zip addresses an AI. Load-only helpers the class requires (`ifthen`, `ifpdf`, `multido`, papertex.dtx:442-443) print nothing and have no component line.

## Content-opaque
none (the image files example/img/ireland.jpg and example/img/weather/{clouds,rain,sun}.jpg are shipped content; no TikZ or picture drawing exists in the sample or the class)

## Lib changes
- New ways proposed: none (class vocabulary is recorded under `class.papertex` and the `*.class-native` ways; the underlying packages all have lib lines)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
