yes

# 0875-koma-moderncvclassic: koma-moderncvclassic (classic moderncv look for KOMA-Script classes)

- Unverified: read from the source, not compiled.
- Source: Source/0875-koma-moderncvclassic/ (origin: https://mirrors.ctan.org/macros/latex/contrib/koma-moderncvclassic.zip; licence: lppl1.3)
- Kind: cv
- Lib: v6
- Engine: pdfLaTeX-compatible
- Look carried by: class (the published CTAN package koma-moderncvclassic.sty, shipped in the zip, plays the class's role over scrartcl; the sample adds only the colour option, data strings, footer, language and bibliography)
- Class origin: ctan
- Main file: cvbasic.tex (other samples: none; the shipped cvbasic.pdf was not read)
- Read: main yes, zip-local classes and styles all

## Verdict
The look is defined by koma-moderncvclassic.sty (354 lines, read in full). It is the CTAN release itself (ctan.org/pkg/koma-moderncvclassic read: LPPL 1.3, v0.5, Salome Sodergran), so it passes W1. Its behaviour is chosen by one colour option, string macros defined before loading, one optional length and font or colour macros (W2); it serves any CV (W3); an emitter prints one `\usepackage[myblue]{koma-moderncvclassic}` line, the data macros and `\cvline`/`\cventry` calls (W4). The sample preamble adds only published ways (scrartcl options, scrpage2 footer, babel, csquotes, biblatex), so the answer is yes. The verdict rests on the CTAN origin of the package; the table below also shows that its macros reduce to lib ways as a cross-check.

## Blockers
none

## Class setting
- Class: `class.scrartcl` options: fontsize=11pt, a4paper, pagesize, headinclude, footinclude, headings=normal (cvbasic.tex:22-28). KOMA-Script's scrartcl is not in the zip (tex-distribution-unbundled; its source was not read).
- Class-native vocabulary used: `\usekomafont{pagenumber}` (cvbasic.tex:92); scrpage2 `\pagestyle{scrheadings}` `\clearscrheadfoot` `\ifoot` `\ofoot` (cvbasic.tex:97-100); inside the package `\setkomafont{section}` and `\setkomafont{subsection}` (koma-moderncvclassic.sty:116-117).
- Template-layer vocabulary (koma-moderncvclassic, CTAN): data macros `\firstname` `\familyname` `\acadtitle` `\addressstreet` `\addresscity` `\mobile` `\phone` `\faxnr` `\email` `\extrainfo` `\quote` (read at sty:224-255), `\photo[frame or noframe]{width}{file}` (sty:199-202), redefined `\maketitle` `\section` `\subsection` (sty:218, 265, 274), `\cvline` `\cvdoubleitem` `\cventry` `\cvlanguage` `\cvcomputer` (sty:285-318), `\link` `\httplink` `\emaillink` (sty:328-343), option names `myblue` `blue` `red` `green` `cyan` `magenta` `yellow` `black` `white` `gray` `darkgray` `lightgray` (sty:23-34), optional length `\myhintscolumnwidth` (sty:130), font macros `\firstnamefont` `\addressfont` etc. (sty:110-115).
- Order constraint: the data macros, `\myhintscolumnwidth` and the page layout must come before `\usepackage{koma-moderncvclassic}`, because the widths are computed at load time (cvbasic.tex:43, 63; sty:129-168, 193).

## Component map
Rows 1 to 22 are what the emitter prints (sample level). Rows 23 to 41 are what the package does inside (cross-check reduction); an emitter that loads the package does not print them.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| 1 class | cvbasic.tex:22-28 | `class.scrartcl` | fontsize=11pt, a4paper, pagesize, headinclude, footinclude, headings=normal |
| 2 paper and font size | cvbasic.tex:23-24 | `page.class-options` | a4paper, fontsize=11pt, pagesize |
| 3 type area | cvbasic.tex:26 (the geometry line at cvbasic.tex:29 is commented out) | `page.typearea` | headinclude, footinclude; DIV and BCOR left at the KOMA defaults |
| 4 header and footer | cvbasic.tex:30, 97-100 | `hf.scrlayer-scrpage` | package scrpage2 (the KOMA predecessor of scrlayer-scrpage with the same `\ifoot` `\ofoot` field commands; its source was not read); pagestyle scrheadings, `\clearscrheadfoot`, ifoot `CV~\firstname~\familyname`, ofoot `\totalpagemark`; ihead and ohead commented out (cvbasic.tex:101-102) |
| 5 page X/Y in footer | cvbasic.tex:92, 153 | `xref.kernel` | `\label{lastpage}` just before `\end{document}`, `\thepage/\pageref{lastpage}` in the footer field, font `\usekomafont{pagenumber}`; the `lastpage` package (`pgnum.lastpage`) is the packaged equivalent and is not loaded |
| 6 input and font encoding | cvbasic.tex:31-32 | `font.fontenc-t1` | inputenc utf8, fontenc T1 |
| 7 language | cvbasic.tex:33 | `lang.babel` | ngerman |
| 8 quotation marks | cvbasic.tex:34 | `lang.csquotes` | german=quotes |
| 9 line-break tolerance | cvbasic.tex:36 | `sp.hyphenat` | `\tolerance=200` (the LaTeX default, the `\fussy` value, same family as `\sloppy`; no printed change) |
| 10 widows and clubs | cvbasic.tex:37-38 | `sp.penalties` | `\clubpenalty=1000`, `\widowpenalty=1000` |
| 11 CV data fields | cvbasic.tex:47-51, 54, 56; commented out 53, 55, 57-58 | `cv.entries` | `\newcommand*` string holders for firstname Minna, familyname, acadtitle, addressstreet, addresscity, phone, email (package input fields); mobile, faxnr, extrainfo, quote unused |
| 12 package load and colour theme | cvbasic.tex:77; koma-moderncvclassic.sty:22-36 | `cv.entries` | option `myblue` (the default; other colour names listed at sty:23-34) |
| 13 photo slot | cvbasic.tex:80 (commented out); sty:199-202, 242-250 | `cv.entries` | `\photo[frame]{3cm}{picture.jpg}`; unused in the sample, picture.jpg is not shipped |
| 14 title block | cvbasic.tex:121; sty:218-257 | `cv.entries` | `\maketitle` of the package: name minipage (34pt sans), acadtitle line, right-aligned details minipage (address, phone, email link), optional photo and quote |
| 15 section | cvbasic.tex:123, 128, 139, 144; sty:265-271 | `cv.entries` | `\section{title}`: coloured rule in the left column plus title in the main column, unnumbered |
| 16 subsection | cvbasic.tex:129, 132, 135; sty:274-275 | `cv.entries` | `\subsection{title}` = `\cvline[0.45em]{}{title}` |
| 17 line entry | cvbasic.tex:124-126; sty:285-288 | `cv.entries` | `\cvline[skip]{margintext}{linetext}` |
| 18 entry | cvbasic.tex:130-137; sty:303-311 | `cv.entries` | `\cventry{years}{degree}{institution}{localization}{grade}{comment}` |
| 19 language row | cvbasic.tex:140-142; sty:314-315 | `cv.entries` | `\cvlanguage{name}{level}{comment}` |
| 20 computer row | cvbasic.tex:145-146; sty:318, 292-299 | `cv.entries` | `\cvcomputer{cat}{programs}{cat}{programs}` = `\cvdoubleitem` with `\small` |
| 21 bibliography | cvbasic.tex:108-113, 150-151 | `bib.biblatex-biber` | backend=biber, style=authortitle, sorting=ydnt; `\bibliography{cvbasic.bib}`; `\defbibheading{bibliography}[Publications]{\section{#1}}`; `\nocite{*}`; `\printbibliography`; the .bib file is written by `filecontents` at cvbasic.tex:6-20 (entries are content) |
| 22 page break | cvbasic.tex:148 | `pg.break` | `\newpage` before the bibliography |
| 23 packages the package loads | sty:42-50 | `color.xcolor`, `font.lmodern`, `font.icons`, `meta.url`, `fig.graphicx`, `meta.hyperref` | xcolor, lmodern, marvosym, url, graphicx, hyperref, all without options (changelog:21); `ifthen` and `ifpdf` are load-only helpers with no printed effect |
| 24 symbols | sty:86-91 | `font.icons` | `\Mobilefone`, `\Telefon`, `\FAX`, `\Letter` (marvosym), `\textbullet` |
| 25 colours | sty:94-106 | `color.xcolor` | `\xdefinecolor{myblue}{rgb}{0.2,0.3,0.65}`; `\colorlet` for colortheme, sectionrectanglecolor, sectiontitlecolor, subsectiontitlecolor, firstnamecolor, hintcolor and others |
| 26 font defaults | sty:109 | `font.family-default` | `\ttdefault` = pcr |
| 27 font sizes | sty:110-115 | `font.size-commands` | `\fontsize{34}{36}`, `\LARGE`, `\normalsize`, `\large`, `\small` |
| 28 font switches | sty:110-115, 305-306, 315 | `mark.kernel` | `\sffamily` `\rmfamily` `\mdseries` `\upshape` `\slshape` `\bfseries` `\itshape` |
| 29 heading fonts | sty:116-117 | `head.koma-fonts` | `\setkomafont{section}{\Large\sffamily\mdseries\upshape}`, `\setkomafont{subsection}{\large\sffamily\mdseries\upshape}` |
| 30 spacing | sty:120-124 | `sp.lengths`, `sp.linespread` | `\lineskip` 1pt, `\normallineskip` 1pt, `\parindent` 0pt, `\parskip` 0pt; `\baselinestretch` set empty |
| 31 columns | sty:125-126, 350 | `cols.twocolumn-cmd` | `\columnsep` 10pt, `\columnseprule` 0pt, `\onecolumn` (no printed effect in single-column text) |
| 32 column widths | sty:129-168 | `sp.lengths` | hints column 2,79cm or `\myhintscolumnwidth`, separator 0.025`\textwidth`, main = text - separator - hints, further widths by `\setlength` `\addtolength` `\settowidth` |
| 33 row table | sty:285-288 | `tbl.tabular` | `p{\hintscolumnwidth}`, `@{\hspace{\separatorcolumnwidth}}`, `p{\maincolumnwidth}`, `@{}` |
| 34 boxes | sty:220, 229, 246, 269-271, 294-299, 310, 315 | `box.minipage` | minipage `[b]` or `[t]`, `\parbox[m]` with computed widths |
| 35 photo frame | sty:246-250 | `box.fancybox`, `fig.graphicx` | `\framebox{\includegraphics[width=\photowidth]{...}}` |
| 36 alignment | sty:230, 255, 269, 287, 296, 315 | `sp.ragged` | `\raggedleft`, `\centering` |
| 37 section rule | sty:269 | `sp.rule` | `\color{sectionrectanglecolor}\rule{\hintscolumnwidth}{1ex}` |
| 38 manual spacing | sty:216, 266, 275, 298 | `sp.manual-space` | `\\[.2em]`, `\vspace*{3.5ex plus 1ex minus .2ex}`, `\vspace{0.5ex}`, `\hspace*{\separatorcolumnwidth}`, `\hfill` |
| 39 toc entry and anchor | sty:267-268 | `toc.kernel`, `meta.hyperref` | `\addcontentsline{toc}{part}{#1}` (written to .toc; the sample has no `\tableofcontents`), `\phantomsection` |
| 40 links | sty:328-343 | `meta.hyperref` | `\link` `\httplink` `\emaillink` over `\href` (only `\emaillink` is used, in the title block at sty:238) |
| 41 page flow | sty:349 | `pg.flush` | `\raggedbottom` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| koma-moderncvclassic.sty as a whole (`\maketitle`, `\section`, `\subsection`, `\cvline`, `\cventry`, `\cvlanguage`, `\cvcomputer`, `\photo`, length and colour setup) | koma-moderncvclassic.sty:1-354 | published, not bespoke (CTAN release) | `\usepackage[myblue]{koma-moderncvclassic}` is `cv.entries`; rows 23 to 41 show it also reduces to lib ways. If the CTAN release were not accepted as a way, the `\maketitle` field logic and the `\section` row would be BESPOKE/class |
| `\maketitledetailsnewline` with `\newif` first-element flag | koma-moderncvclassic.sty:211-216 | yes | separator `\\[.2em]` between the printed fields, in order |
| `\ifthenelse{\isundefined{field}}` branches | koma-moderncvclassic.sty:224-255 | yes | print only the fields that exist (the emitter knows the field set) |
| name width capped at `.525\textwidth` | koma-moderncvclassic.sty:190-195 | yes | `\settowidth` and `\ifnum` comparison, computed at load time inside the package |
| `\providelength` guard for `\myhintscolumnwidth` | koma-moderncvclassic.sty:75-83, 129-135 | yes | the emitter sets `\myhintscolumnwidth` before loading or leaves the 2,79cm default |
| `\renewcommand*{\title}{Lebenslauf}` | cvbasic.tex:46 | yes | inert: the package never reads `\title` (its `\hypersetup` lines are commented out, sty:52-67); drop it, or `\hypersetup{pdftitle=Lebenslauf}` with `meta.hyperref` |
| `\newcommand*{\address}[2]` | cvbasic.tex:52 | yes | never called in the body; drop |
| `\newcommand*{\totalpagemark}` | cvbasic.tex:92 | yes | alias, inline its text into `\ofoot` (row 4 and 5) |
| `\ifthenelse{\isundefined{\quote}}` | koma-moderncvclassic.sty:252-255 | observation, not a blocker | the kernel already defines `\quote`, and `\quotewidth` is only created (sty:146), never set, so by reading the quote branch seems to run even though the sample comments `\quote` out (cvbasic.tex:58); this is the package's behaviour and is not checked by compiling |

## Content-opaque
none (the placeholder strings in the body and the two `.bib` entries written by `filecontents` at cvbasic.tex:7-19 are content; the photo file picture.jpg is not shipped and its `\photo` call is commented out at cvbasic.tex:80)

## Lib changes
- New ways proposed: none. Considered and not proposed: a class-like way for koma-moderncvclassic itself (`cv.entries`, the moderncv family line, is its home); the `lastpage` package (`pgnum.lastpage` already exists, the sample uses kernel `\label` and `\pageref`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes: the biblatex setup needs a biber run (`bib.biblatex-biber`); the sample loads `scrpage2`, which is obsolete in KOMA-Script (its source was not read), and `hf.scrlayer-scrpage` stands for it.
