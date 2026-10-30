yes

# 0059-ftc-notebook: ftc-notebook (FIRST Tech Challenge engineering notebook)

- Unverified: read from the source, not compiled.
- Source: Source/0059-ftc-notebook/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ftc-notebook.zip; licence: LPPL 1.3, ftc-notebook.sty:996-1004; CTAN page read once: package is on CTAN and in TeX Live)
- Kind: report
- Lib: v1
- Engine: pdfLaTeX-compatible (no fontspec/Lua; `inputenx`, `t1enc`, `mathptmx`, `tikz`, `tabu` are pdfTeX-era packages; not run)
- Look carried by: class (the published package ftc-notebook.sty, on CTAN and in TeX Live, carries the whole look over kernel `article`; the sample's preamble sets only two options, example-notebook.tex:3)
- Class origin: ctan
- Main file: example-notebook.tex (other samples: ftc-notebook.tex, the package manual on `ltxdoc`; body files src/story.tex, src/bio.tex, src/aug19.tex)
- Read: main yes, zip-local classes and styles all (the only one, ftc-notebook.sty, 1017 lines, read in full; manual ftc-notebook.tex 974 lines also read in full; the .jpg and .pdf files are not read)

## Verdict
Yes, but only on one ruling: ftc-notebook.sty is published (CTAN, TeX Live, LPPL, public manual), so its macros are not zip-local bespoke code and the sample reduces to `class.article` + one doc-kind way `notebook.ftc` (package options in the preamble, environments and commands in the body) plus kernel lists, `\newpage`, `\vspace`. The sample defines no macro of its own, there is no ART (the cover is a coloured `tabular` plus `textpos` blocks, no drawing primitives; the TikZ callout is a per-photo annotation, i.e. content) and nothing needs an external tool at build time. The way is weak on W3 (one genre, near-fixed look: letter paper, fixed 2 cm margin widths, three colour schemes); if W1 is read as not covering a whole-document package, the answer flips to `no` and the latent blockers under "Bespoke code" apply.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (example-notebook.tex:1). Manual only: `class.ltxdoc`, no options (ftc-notebook.tex:2).
- Class-native vocabulary used: none from `article` itself (no `\maketitle`, `\section`, `abstract` in the sample; the package supplies `\CoverPage`, `\Section`, ...). Manual uses `\maketitle`, `abstract`, `\thanks`, `macro` environment, `\changes`, `\StopEventually`, `\PrintChanges`, `\PrintIndex` (ftc-notebook.tex:31-62, 279, 968-971). `class.article` is not bundled in the zip (TeX distribution, source not read).

## Component map
Rows marked (pkg) are the genre-specific commands of the published package; rows marked (inside sty) are the published packages the style loads and how it sets them. Underlying rows are evidence of what the way is built from, not extra things the emitter writes.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class + size | example-notebook.tex:1 | `class.article`, `page.class-options` | 11pt |
| package options (pkg) | example-notebook.tex:3; ftc-notebook.sty:18-38 | `notebook.ftc` | `Num=FTC~9773`, `Name=Robocracy`; unused here: `Logo` (default logo.jpg), `Notebook` (Engineering Notebook), `KindOne..KindSix` (Strategy, Design, Build, Math/Physics, Software, Team), `Grid`, `Green`/`Orange`/`Blue` |
| cover page (pkg) | example-notebook.tex:7; sty:821-885 | `notebook.ftc` | `\CoverPage{2018-19}{src/images/robocracy2018.jpg}[14]`; then a page with a "typeset with ftc-notebook" credit |
| cover page layout (inside sty) | sty:828-873 | `pg.textpos` | `\begin{textblock}{10}(2.5,3.5)` overlay: team number `\Huge`, name `\fontsize{60}{70}` `\textbf\textsc`, picture `height=14cm`, notebook title `\fontsize{30}{40}`; second block `{12}(2,14)` |
| cover page background (inside sty) | sty:839-873 | `tbl.colortbl` | `tabular` with `\columncolor{MainTableHeaderColor}` on column 2, 33 empty rows to fill the page, `multirow` logo (height 4cm), year `\Huge` right-aligned |
| cover multirow, logo (inside sty) | sty:840 | `tbl.multirow` | `\multirow{3}{*}{\includegraphics[height=4cm]{logo}}` |
| front-matter lists (pkg) | example-notebook.tex:9-11; sty:899-947 | `notebook.ftc` | `\ListOfTasks`, `\ListOfFigures`, `\ListOfTables`; the task list is titled "Table of Contents" (`\listexamplename`, sty:899) |
| list-of tasks (inside sty) | sty:900-919 | `toc.tocloft` | `\newlistof{mycustomtask}{mcf}{...}`; `\cftmycustomtaskfont`, `\cftfigfont`, `\cfttabfont` = `\large`; `\cftloftitlefont`, `\cftlottitlefont` = `\Huge\bfseries` |
| lists of figures/tables (inside sty) | sty:937-947 | `toc.kernel` | `\listoffigures`, `\listoftables`, each followed by `\newpage` |
| page numbering (pkg + inside sty) | example-notebook.tex:13; sty:910, 928 | `pgnum.pagenumbering` | `roman` in front matter (`\listoftasks`), `arabic` from `\StartNotebook` |
| page geometry (inside sty) | sty:80 | `page.geometry` | `letterpaper, portrait, margin=2cm` |
| header/footer (inside sty) | sty:81-83, 911, 925-927 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, front matter `\cfoot{\thepage}`; body `\lfoot{team no, name, notebook title.}` `\rfoot{<date, Task n,> Page \thepage.}` (no `\headrulewidth` change read) |
| notebook start (pkg) | example-notebook.tex:13; sty:923-929 | `notebook.ftc` | `\StartNotebook` (resets footer, restarts arabic numbering) |
| month divider (pkg) | example-notebook.tex:17; sty:202-219 | `notebook.ftc` | `\Month{August}{aug18.jpg}`: new page, logo + coloured Title-Cased month, rule under it, picture `0.85\textwidth` |
| team story (pkg) | src/story.tex:1-54; sty:799-819 | `notebook.ftc` | `\begin{TeamStory}{<one-liner>}` (optional title default "Our Team Story"): logo 3cm, `\fontsize{40}{50}` bold italic title in TitleColor, `\LARGE` quoted one-liner, body in `Large` |
| team bio (pkg) | src/bio.tex:1-18; sty:751-793 | `notebook.ftc` | `Bio` env + `\BioEntry{name}{blurb}[Role]{..}[Outreach]{..}{pic}[0.5]{bio}`: two-column long table, header "Meet the team" |
| meeting header and signature box (pkg) | src/aug19.tex:1-13, 207; sty:223-286 | `notebook.ftc` | `\begin{Meeting}[Preseason]{title}{dates}{duration}{members with \Signee}{\TaskInfo...}`; header table with logo, kind-and-date, title, rule; task box (3 columns 1/5.5/9.7cm); `\end{Meeting}` prints "Signed by / Date" box |
| task header (pkg) | src/aug19.tex:31, 143; sty:341-374 | `notebook.ftc` | `\Task[<continuing from>]{2}[3]`: 6-cell table of the six task kinds, selected kinds filled black with light text, title row from `\TaskInfo` |
| task sections (pkg) | src/aug19.tex:34, 41, 81, 124; sty:378-421 | `notebook.ftc` | `\Section{..}` numbered `<task>.<n>:` in TitleColor `\large\textbf`; `\Section*`, `\Subsection`, `\Highlight`, `\MeetingSummary` not-numbered |
| task tables (pkg) | src/aug19.tex:49-77, 106-120; sty:594-743 | `notebook.ftc` | `DescriptionTable{col1}{col2}{caption}{label}` (5cm + 12cm) and `DescriptionTable*` (8.5cm + 8.5cm); rows by `\TableEntryTextItem`, `\TableEntryItemItem`; `DecisionTable` (manual only) 4/6.5/6.5cm |
| picture figures (pkg) | src/aug19.tex:89-104, 166-204; sty:484-537 | `notebook.ftc` | `\PictFigure[htb]{file}[0.9]{caption}{label}[callouts]`, `\ExplainedPictFigure{file}[0.4]{caption}{label}{explanation}`; captions get a trailing "." |
| cross-reference commands (pkg) | src/aug19.tex:85, 143, 147; sty:893-895 | `notebook.ftc` | `\TaskRef`, `\FigureRef`, `\TableRef` = "Figure~\ref{} on page~\pageref{}" |
| task/meeting table (inside sty) | sty:211, 243, 256, 271, 356, 809 | `tbl.nicematrix` | `tabu` with `p{}`, `>{\raggedright\arraybackslash}` columns, `\tabulinesep=1.2mm`/`3mm`, `\rowcolors`, `\arrayrulecolor{TitleColor}` |
| long tables (inside sty) | sty:601-619, 759-771 | `tbl.longtable` | `longtable` with caption inside, `\endfirsthead`/`\endhead` repeated header row in NormalTableHeaderColor |
| plain tabular and rules (inside sty) | sty:59, 96, 591 | `tbl.tabular` | `array`; `\setlength\arrayrulewidth{2pt}`; `\renewcommand{\arraystretch}{1.5}` |
| table colour (inside sty) | sty:91-92, 255, 354, 602, 758 | `tbl.colortbl` | `\rowcolors{1}{c}{c}`, `\cellcolor`, `\rowcolor`, `\columncolor`, `\arrayrulecolor` |
| table cell blocks (inside sty) | sty:680-743 | `box.minipage` | `minipage[t]{\linewidth}` with `\vspace{1mm}`/`\vspace{2mm}`, `\raggedright`, per cell |
| colour scheme (inside sty) | sty:91, 953-985 | `color.xcolor` | `[table,dvipsnames]`; `\definecolor` of TitleColor, MainTableHeaderColor, MainTableCellColor, NormalTableHeaderColor, NormalTableCellColor, NormalTableCellWhite, rgb sets for Green (default, e.g. TitleColor 0.65/0.73/0.29), Orange, Blue chosen by `\ifFTC@Blue`/`\ifFTC@Orange` |
| hyperlinks (inside sty) | sty:176-180 | `meta.hyperref` | `colorlinks=true, linkcolor=black` |
| references (inside sty) | sty:893-895 | `xref.kernel` | `\label` `\ref` `\pageref`; labels set by `\refstepcounter` |
| captions (inside sty) | sty:47, 495, 606 | `cap.caption` | `labelfont=bf, textfont=bf` |
| caption command (inside sty) | sty:495, 534, 584, 606 | `cap.kernel` | `\caption{#.}` |
| figures (inside sty) | sty:87-88, 492-497 | `fig.graphicx` | `figure[htb]`, `\includegraphics[width=#\textwidth]`, `\graphicspath{{src/images/}}` |
| subfigures (inside sty) | sty:48, 541-586 | `fig.subcaption` | `subfigure` of `0.4`/`0.9\textwidth`, `GroupedFigures` figure wrapper |
| float package (inside sty) | sty:50 | `fig.float` | load only (the manual uses `[H]`, ftc-notebook.tex:110) |
| lists (sample body) | src/aug19.tex:35-39, 146-150 | `list.kernel` | `itemize` |
| compact lists (inside sty) | sty:62, 707, 734; src/aug19.tex:92 | `list.paralist` | `compactitem` inside explanation boxes and table cells; `EnumerateWithTitle`, `ItemizeWithTitle` (sty:438-454) wrap `enumerate`/`itemize` |
| fonts (inside sty) | sty:52, 54, 106-107 | `font.mathptmx` | `mathptmx` Times text and math |
| encoding (inside sty) | sty:54, 106-107 | `font.fontenc-t1` | `t1enc`, `textcomp`, `inputenx[utf8]` |
| font sizes (inside sty) | sty:53, 811, 832, 835 | `font.size-commands` | `anyfontsize`; `\fontsize{40}{50}`, `{60}{70}`, `{30}{40}\selectfont`, `\Huge`, `\LARGE` |
| space and alignment (inside sty) | sty:209, 216, 249, 349, 380 | `sp.manual-space` | `\vspace{5mm}`, `\vspace{10mm}`, `\bigskip`, `\vspace{-2mm}\\`; story.tex:6 `\\ \vspace{3mm}` |
| alignment (inside sty) | sty:209, 241, 268, 349, 381 | `sp.ragged` | `flushleft`, `\centering`, `\raggedright` |
| keep-together (inside sty) | sty:51, 267, 347, 380, 405 | `pg.needspace` | `\Needspace{5cm}`, `\Needspace{4cm}`, `\needspace{3cm}` |
| page breaks (inside sty, sample body) | sty:206-207, 238-239, 753-754; src/aug19.tex:152 | `pg.break` | `\cleardoublepage`, `\newpage`, `\clearpage` |
| absolute positioning (inside sty) | sty:56, 828, 877 | `pg.textpos` | `textpos[absolute,overlay]` |
| custom numbering (inside sty) | sty:190-196, 350, 391, 417 | `num.counters` | counters TaskCounter, TaskSection, TaskSubSection[TaskSection], TaskSubSubSection; `\theTaskSubSection` = `n.m` |
| load-only: titlesec | sty:84 | `head.titlesec` | no `\titleformat` anywhere; headings are the package's own `\Section` |
| load-only: listings | sty:111; ftc-notebook.tex:14-21 | `code.listings` | no `\lstset` in the sty; the manual defines `dtxverblisting` (`gobble=2`, `basicstyle=\ttfamily`, `columns=fullflexible`, `keepspaces`) |
| load-only: newunicodechar | sty:108 | `font.newunicodechar` | no `\newunicodechar` call |
| load-only: datetime | sty:45-46 | `front.datetime` | `\newdateformat{monthyeardate}` defined, never printed |
| photo callouts | src/aug19.tex:104; sty:133-170, 465-480 | `art.tikz` | `\Callout{x,y}{text}{x,y}` text box + red arrow over a picture; `Grid` option draws a help grid; content, not template identity |
| manual: class and fonts | ftc-notebook.tex:2-4 | `class.ltxdoc`, `font.fontenc-t1`, `font.lmodern` | `[T1]{fontenc}`, `lmodern` |
| manual: links | ftc-notebook.tex:5 | `meta.hyperref` | `hypdoc[numbered]` |
| manual: page and spacing | ftc-notebook.tex:22, 55 | `page.setlength` | `\addtolength\textwidth{15pt}`; `\sloppy` is `sp.hyphenat` |
| manual: front matter | ftc-notebook.tex:31-62 | `front.maketitle` | `\title` `\author` `\date` `\maketitle`, `\thanks` (`front.thanks`), `abstract` (`abs.kernel`), `\tableofcontents` (`toc.kernel`), `tocloft` `\cftloftitlefont{\Large}` (`toc.tocloft`) |
| manual: tables | ftc-notebook.tex:212-234, 713-730 | `tbl.tabular` | `tabular` `{|p{2cm}|p{5cm}|p{5cm}|}` in `table[H]`; `multirow`, `tabu` loaded (ftc-notebook.tex:9-10) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| All macros, environments, counters, arrays of ftc-notebook.sty (`Meeting`, `\TaskInfo`, `\Task`, `\Signee`, `\@TypeColor`, `\Month`, `\CoverPage`, `\BioEntry`, `TeamStory`, `MyTable`, ...) | sty:133-1017 | not bespoke: published (W1) | realised as `notebook.ftc`; the emitter writes `\usepackage[Num=..,Name=..]{ftc-notebook}` and the body environments of src/*.tex, no macro copied |
| Latent, only if the package is not accepted as a way: title/label hand-off from `\TaskInfo` to `\Task` through `arrayjobx` arrays (`\TaskTitle(n)`, `\checkTaskLabel`, `\cachedata`), signee list through `\SigneeName` + `multido`, running-footer date kept in array `\@TaskDate(1)`, `\PackageError` count check at `\end{Meeting}`, `\@TypeColor` `ifthen` conditional, an expl3 `\IfNoValueOrEmptyTF` | sty:185-186, 232-285, 290-327, 330-337, 351-373 | would be irreducible (hand-rolled counters, arrays and conditionals that drive what is printed) | `BESPOKE/class` in that reading |
| Inlined, lightly adapted copy of CTAN `callout.sty` (`annotate`, `\callout`, `\helpgrid`, `\note`, `\arrow`; arrow widened, colours hard-wired) | sty:117-172 | not bespoke (inside the published package); output is photo annotation, content | `art.tikz` content, see Content-opaque |
| `newmeeting.sh`: bash script that writes a pre-filled `src/<name>.tex` skeleton (hard-coded team list) | newmeeting.sh:1-83 | not part of the build; authoring aid only, the sample's .tex files ship ready (README.md:64-70) | not counted as `EXTERNAL`; the document compiles without it |
| `\ProvidesPackage{ftc9773}` in a file named ftc-notebook.sty | sty:11 | metadata quirk only (a name-mismatch warning is expected, not checked) | none |
| Sample preamble and body macros | example-notebook.tex, src/*.tex | none defined (no `\newcommand`, `\def`, counters) | n/a |
| Support packages with no lib component: `kvoptions`, `xparse`, `suffix`, `calc`, `ifthen`, `xifthen`, `arrayjobx`, `multido`, `mfirstuc` (`\capitalisewords` with `\MFUnocap` list: are or and for by a an in am pm to of, sty:64-77, used sty:213, 245, 361) | sty:18-77, 95-103, 123-125 | programming helpers inside the published package, not template components | none written; Title Case of kind, month and task title is part of the way's fixed look |

## Content-opaque
- TikZ callout overlay on a photograph (`\Callout{-8, 4}{Unsupported Idle Pulley}{-0.5, -0.5}`, src/aug19.tex:104; machinery sty:133-170, 465-480) and the optional `Grid` help grid (sty:473-475).
- Photographs and CAD images (src/aug19/*.jpg, src/images/*.jpg, src/bio/mitsiki.jpg), all shipped; `logo.jpg` default (sty:25) is src/images/logo.jpg.
- Text of the story, bio and meeting entries; no equations, code or bibliography in the sample.

## Lib changes
- New ways proposed: `notebook.ftc` (package `ftc-notebook`, pdfLaTeX, doc-kind family like `cv.entries`/`legal.contract`): FTC engineering/outreach notebook, options `Num` `Name` `Logo` `Notebook` `KindOne..KindSix` `Grid` `Green`/`Orange`/`Blue`; body `\CoverPage` `\ListOfTasks` `\StartNotebook` `\Month` `TeamStory` `Bio` `Meeting` `\TaskInfo` `\Task` `\Section` `DescriptionTable` `DecisionTable` `\PictFigure` `\ExplainedPictFigure` `GroupedFigures`. W1: CTAN, in TeX Live, LPPL 1.3, public manual (ftc-notebook.tex/.pdf). W2: look is chosen by string and boolean options, six named colours and command arguments, not by editing code. W3: serves a document genre for any FTC team (weak point: one genre, near-fixed layout; same footing as the accepted `class.gsemthesis` and `class.ulthese`). W4: one `\usepackage[...]` preamble line plus environment wrappers around entry content.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
