yes

# 0615-h2020proposal: h2020proposal (EU Horizon 2020 RIA proposal class with ICT and FET templates)

- Unverified: read from the source, not compiled.
- Source: Source/0615-h2020proposal/ (origin: https://mirrors.ctan.org/macros/latex/contrib/h2020proposal.zip; licence: GPL-3.0 (cls header h2020proposal.cls:17-20, manifest `gpl3`, CTAN page ctan.org/pkg/h2020proposal))
- Kind: misc (funding-proposal template: cover page, participants table, work-package tables, Sections 1 to 5)
- Lib: v5
- Engine: pdfLaTeX-compatible (`pdfcprot` at template-ict/template-ict.tex:80 is a pdfLaTeX package; the comment at :44 offers `fontspec` only as a commented-out XeLaTeX route)
- Look carried by: class (the page layout, running heads, title block, framed work-package boxes and every cross-referenced table are made by `h2020proposal.cls`; the sample preamble only loads published packages and sets memoir heading hooks)
- Class origin: ctan
- Main file: template-ict/template-ict.tex (other samples: template-fet/template-fet.tex, manual/h2020proposal.tex)
- Read: main yes, zip-local classes and styles all (h2020proposal.cls lines 1-1182 read; memoir, which it loads, is not bundled and its source was not read)

## Verdict
Yes, by the rubric's class ruling, and that ruling is what carries it. `h2020proposal.cls` is the CTAN release (the zip comes from `macros/latex/contrib/h2020proposal`, version 1.0 of 2015-09-20 on the CTAN page), so it is a published class, `class.h2020proposal`, over the published `class.memoir`. Read as zip-local code its internals would be irreducible (aux-file table writers at h2020proposal.cls:645-706 and :781-840, an insertion sort over counters at :739-779, `\whiledo` column packing at :414-485), so the verdict would flip to `no` if the class were not published. The sample preamble loads only published packages and its two own macros reduce to lib ways. No `ART` and nothing EXTERNAL. This is evidence about the class dimension, not about component ways.

## Blockers
none

## Class setting
- Class: `class.h2020proposal` options: `draft` (template-ict/template-ict.tex:37; the non-draft line is commented at :36). The class runs `\ExecuteOptions{a4paper}` (h2020proposal.cls:55) and then `\LoadClass[article,a4paper,11pt]{memoir}` (:68), or with `draft` `\LoadClass[article,a4paper,draft,showtrims,11pt]{memoir}` (:62); `draft` also loads `showkeys[notref,notcite]` and `rotating[final]` (:63-65) and switches `\instructions` on (:88-92). Base class: `class.memoir`.
- Class-native vocabulary used: `\shortname` `\titlelogo` `\fundingscheme` `\topic` `\coordinator` `\participant` (template-ict.tex:116-123), `\instructions` (:157-174), `\makeparticipantstable` (:201), `\makewplist` `\makedeliverablelist` `\makemilestoneslist` `\makerisklist` `\makesummaryofefforttable` `\makecoststable` `\makelritable` (template-ict/implementation.tex:54,82,113,120,148,160,171), `\milestone[date]{title}{verification}{WPs}` (:109-111), `\criticalrisk{description}{WPs}{mitigation}` (:118), `\costsTravel` `\costsEquipment` `\costsOther` `\costslri` (:155-158,168-169), environment `workpackage{title}` with `\wpstart` `\wpend` `\wptype` `\personmonths[*]` `\makewptable` `wpobjectives` `wpdescription` `\wptask{leader}{contributors}{start}{end}{title}{text}` `wpdeliverables` `\wpdeliverable[month]{leader}{nature}{level}{title}` (template-ict/wp-management.tex:5-90), `\ganttchartdata` (template-ict/gantt.tex:36). Memoir vocabulary used by the sample: `\makeheadstyles` `\headstyles` `\chapterstyle` `\chaptitlefont` `\chapnumfont` `\secheadstyle` (template-ict.tex:138-151), `\cftbeforechapterskip` `\cftchapterbreak` (:199-200), `\backmatter` (:225).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | template-ict.tex:37; h2020proposal.cls:62,68 | `class.h2020proposal` over `class.memoir` | option `draft`; memoir options `article,a4paper,11pt` (+`draft,showtrims` in draft) |
| paper and size | h2020proposal.cls:55,62,68 | `page.class-options` | `a4paper`, `11pt` |
| page geometry | h2020proposal.cls:72-82 | `page.memoir-layout` | `\setmarginnotes{17pt}{51pt}{\onelineskip}`, `\settrimmedsize{297mm}{210mm}{*}`, `\settypeblocksize{693pt}{490pt}{*}`, `\setulmargins{2.75cm}{*}{*}`, `\setlrmargins{1.75cm}{*}{*}`, `\setheadfoot{\onelineskip}{2\onelineskip}`, `\setheaderspaces{*}{2\onelineskip}{*}`, `\checkandfixthelayout` |
| page style `proposal` (rule, running heads and feet) | h2020proposal.cls:99-107 | `hf.memoir-pagestyle` | `\copypagestyle{proposal}{ruled}`, `\makeevenfoot`/`\makeoddfoot` {shortname}{page}{`\date{\today}`}, `\makeoddhead`/`\makeevenhead` {`\rightmark`/`\leftmark`}; heads call `\disptoken{@acronym}`, which nothing in the zip defines, so that field prints nothing |
| page style selected by the sample | template-ict.tex:135 | `hf.class-native` | `\pagestyle{proposal}`; commented overrides at :127-132 |
| empty first page style | h2020proposal.cls:179; template-fet.tex:203 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| title block | template-ict.tex:115-123,189; h2020proposal.cls:168-209 | `front.class-native` | `\maketitle` redefined: `\LARGE` title, `\Large` shortname, optional `\includegraphics[scale=]` logo; `\fundingscheme`, `\topic`, `\coordinator` are stored (:123-133) and the class never prints them |
| title logo image | h2020proposal.cls:203-205; template-ict.tex:117 | `fig.graphicx` | `\includegraphics[scale=0.25]{file}` (the sample passes an empty name) |
| participants table | template-ict.tex:201; h2020proposal.cls:215-233 | `class.h2020proposal` | `\makeparticipantstable` builds a ruled `tabular` `{|p{0.22\textwidth}|p{0.375\textwidth}|c|p{0.175\textwidth}|}` from the `\participant` list |
| abstract (FET sample) | template-fet/abstract.tex:1-3; template-fet.tex:202 | `abs.kernel` | `abstract` environment |
| contents list | template-ict.tex:198,202 | `toc.kernel` | `\contentsname`=Table of Contents, `\tableofcontents*` |
| contents spacing | template-ict.tex:199-200 | `toc.tocloft` | memoir's built-in tocloft commands: `\cftbeforechapterskip`=1.0em plus 0.3em minus 0.1em, `\cftchapterbreak`=`\addpenalty{-4000}` |
| chapter and section style | template-ict.tex:138-151 | `head.memoir-style` | `\makeheadstyles{default}{...}`, `\chapterstyle{section}`, chapter/number/title fonts `\normalfont\Large\bfseries`, `\secheadstyle`=`\normalfont\bfseries` |
| headings in text | template-ict/excellence.tex:4,11; implementation.tex:44; wp-management.tex:57 | `head.kernel` | `\chapter` `\section` `\subsection` `\paragraph` with optional short title (excellence.tex:4) |
| table numbering | template-ict/excellence.tex:2; implementation.tex:87,135; h2020proposal.cls:631-632 | `num.counters` | `\renewcommand{\thetable}{\thesection\alph{table}}`, `\setcounter{table}{0}`, `\stepcounter{table}` |
| appendix and back matter | template-ict.tex:221,225 | `num.appendix` | `\appendix`; `\backmatter` is memoir vocabulary |
| lists | template-ict/excellence.tex:14; wp-management.tex:29,58 | `list.kernel` | `itemize`, `enumerate`, `description` |
| compressed lists | template-ict.tex:86; template-ict/wp-test.tex:29,58 | `list.paralist` | `mdwlist` starred `enumerate*` and `description*` |
| emphasis and underline | template-ict/implementation.tex:20,30-36 | `mark.kernel`, `mark.ulem` | `\emph` `\textit` `\textbf`; `\ul{...}` from `soul` (template-ict.tex:63) |
| line and space control | template-ict.tex:159,197; template-ict/implementation.tex:19 | `sp.manual-space` | `\vskip0.5cm`, `\vspace{-1em}`, `\vskip0.2cm`, `\\`, `\hfill` (h2020proposal.cls:351), `\vspace{-15pt}` (:290) |
| paragraph shape | template-ict/implementation.tex:20,30,66 | `sp.lengths` | `\indent` and `\noindent`, the per-paragraph switch of `\parindent` |
| centred cover lines | template-ict.tex:157-160 | `sp.ragged` | `\centerline{...}` inside `\instructions` |
| page breaks | template-ict.tex:204,216 | `pg.break` | `\pagebreak`, `\clearpage` |
| character protrusion | template-ict.tex:80 | `sp.microtype` | `\usepackage[activate]{pdfcprot}`; considered: `pdfcprot` as its own way, folded here (same protrusion effect, "largely superseded by microtype" on its CTAN page) |
| draft instruction text | h2020proposal.cls:88-92; template-ict.tex:157-174,190-195 | `class.h2020proposal` | `\instructions{...}` prints `{\color{blue}...}` only under `draft`, else nothing |
| draft label keys | h2020proposal.cls:63-66 | `draft.todo` | `showkeys[notref,notcite]`; `\showkeyslabelformat` = sideways `\framebox` of `\tiny\ttfamily\color{red}` key |
| rotated label text | h2020proposal.cls:65-66 | `fig.rotating` | `rotating[final]`, `sideways` |
| margin comments | template-ict.tex:39-40; h2020proposal.cls:72 | `note.marginpar` | `\marginpar{comment text}` named in a comment only |
| font encoding | template-ict.tex:47 | `font.fontenc-t1` | `fontenc[OT1]` |
| text and math face | template-ict.tex:67 | `font.palatino` | `mathpazo[sc]` |
| font sizes | template-ict.tex:93; h2020proposal.cls:66 | `font.size-commands` | `\footnotesize` (natbib `\bibfont`), `\tiny`, `\Large`, `\LARGE`, `\normalsize` |
| colour | template-ict.tex:108; h2020proposal.cls:66,92 | `color.color` | `\color{red}`, `\color{blue}`, gray 0.8 via `colortbl` |
| language | template-ict.tex:60 | `lang.babel` | `[english]` |
| hyperlinks | template-ict.tex:96-102 | `meta.hyperref` | `colorlinks,pagebackref,breaklinks`; `hypertexnames=true`, `linkcolor=blue`, `anchorcolor=black`, `citecolor=blue`, `urlcolor=blue` |
| URLs | template-ict.tex:89,104 | `meta.url` | `\usepackage{url}`, `\urlstyle{rm}` |
| cross-references | template-ict/implementation.tex:111; wp-management.tex:51,59 | `xref.kernel` | `\label`, `\ref` (also inside `\milestone` and `\criticalrisk` arguments) |
| footnotes | template-ict/excellence.tex:15; implementation.tex:28,58 | `fn.kernel` | `\footnote` |
| maths packages (loaded, not called in the body) | template-ict.tex:71 | `math.amsmath`, `math.amssymb`, `math.bm` | `amsmath,amssymb,amsfonts,mathrsfs` |
| graphics | template-ict.tex:77,105-106 | `fig.graphicx` | `\DeclareGraphicsExtensions{.jpg,.pdf,.mps,.png}`, `\graphicspath{{img/} {./}}` |
| Gantt figure (not included by the sample) | template-ict/gantt.tex:4-42; implementation.tex:42 | `fig.graphicx` | `figure`, `\centering`, `\caption[Gantt chart]{Project Gantt chart.}`, `\label{fig:gantt}`; the chart is content, see Content-opaque |
| caption | h2020proposal.cls:654,790,873,941,994; template-ict/gantt.tex:40 | `cap.kernel` | `\caption` inside the class's tables and the Gantt figure |
| work-package frames | h2020proposal.cls:286-322 | `box.mdframed` | memoir's built-in `framed` environment around `\subsubsection*{Objectives}`, `{Description of work}`, `{Deliverables}`, with `\vspace{-15pt}` |
| work-package summary and person-month tables | h2020proposal.cls:443-485; template-ict/wp-management.tex:19-24 | `class.h2020proposal` | `\personmonths*{UoC}{12}`, `\makewptable`; `tabularx` `{|p{0.25\textwidth}|l|r|X|}` and six-`X` rows, `\cellcolor[gray]{0.8}` |
| task and deliverable headings | h2020proposal.cls:328-387; template-ict/wp-management.tex:45-53,79-85 | `class.h2020proposal` | `\wptask` prints `\paragraph{Task Tn.m: title (Ma-Mb)}` and an `\hfill` leader line; `\wpdeliverable[month]` prints `\paragraph{Dn.m}` |
| generated lists (WPs, deliverables, milestones, risks, tasks) | h2020proposal.cls:637-978,1081-1136; template-ict/implementation.tex:54,82,113,120 | `tbl.longtable` | `longtable` written to `\jobname.lwp` `.ldl` `.lms` `.lrk` `.ltk` by `\AtEndDocument` (:1174-1182), read back by `\InputIfFileExists`; deliverables sorted by month; the commands are `class.h2020proposal` vocabulary |
| summary of effort, cost tables | h2020proposal.cls:520-585,601-619,988-1078; template-ict/implementation.tex:148,160,171 | `tbl.tabularx` | `table` float with `\caption{Summary of staff effort}`, `tabularx` `{|c|X|l|l|l|l|l|l|l|p{6em}|}`; per-participant cost tables `{|l| p{4em}| X |}` |
| hand-set tables | template-ict/members.tex:32-47,49-64,67-82 | `tbl.tabular` | `tabular{|p{.85\textwidth}|p{.05\textwidth}|}`, `\multicolumn{2}{|l|}{\cellcolor[gray]{0.8}\textbf{UoC}}`, `\hline`, `\cellcolor[gray]{0.8}` (`tbl.colortbl`) |
| shaded cells | h2020proposal.cls:86,447,551; template-ict/members.tex:34 | `tbl.colortbl` | `\cellcolor[gray]{0.8}` |
| table packages loaded | h2020proposal.cls:84; template-ict.tex:83 | `tbl.booktabs` | `booktabs` loaded, no `\toprule` in any `.tex`; `longtable` (:84) is `tbl.longtable` |
| file inclusion | template-ict.tex:211-213,218-219,223; template-ict/implementation.tex:48-50 | `struct.input` | `\input`, `\include` (first WP by `\input`, the rest by `\include`) |
| bibliography | template-ict.tex:92-93,227-228 | `bib.natbib`, `bib.bibtex-bst` | `natbib[numbers,sort&compress,square]`; `\bibliographystyle{plain}`, `\bibliography{refs}` (`refs.bib` is not in the zip) |
| manual sample | manual/h2020proposal.tex:1-21,166-172,227-236 | `class.article` | `[pdftext]` is not an article option; `\maketitle` (`front.maketitle`), `abstract` (`abs.kernel`), `\tableofcontents` (`toc.kernel`), `tabular` (`tbl.tabular`), `verbatim` (`code.verbatim`), `url` (`meta.url`), `description` (`list.kernel`) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `h2020proposal.cls` whole class | h2020proposal.cls:1-1182 | not applicable: published (CTAN) | the way is `class.h2020proposal`; read as zip-local its aux-file writers, counter insertion sort (:739-779) and `\whiledo` packing (:414-485) would be irreducible |
| `\alert` | template-ict.tex:108 | yes (defined, never called in any `.tex`) | `mark.kernel` `\textbf` inside `color.color` `\color{red}` |
| `\def\bibfont{\footnotesize}` | template-ict.tex:93 | yes | natbib hook set to a font size, `font.size-commands` |
| `\showkeyslabelformat` redefinition | h2020proposal.cls:66 | yes | showkeys hook: `box.fancybox` `\framebox`, `fig.rotating` `sideways`, `font.size-commands` `\tiny`, `mark.kernel` `\ttfamily`, `color.color` red |
| table counter edits | template-ict/excellence.tex:2; implementation.tex:87,135; h2020proposal.cls:631-632 | yes | `num.counters` |
| `\disptoken{@acronym}` | h2020proposal.cls:106-107 | not applicable (inside the published class) | the name is not defined anywhere in the zip, so the field prints nothing; quirk, not a blocker |

## Content-opaque
- `pgfgantt` chart in a figure (template-ict/gantt.tex:7-38; styled with `x unit`, `bar/.style`, `title/.style`; data from `\ganttchartdata`, written by h2020proposal.cls:1146-1170); not included by the sample because implementation.tex:42 is `%\include{gantt}`, `art.tikz` family. Figure artwork inside a float, so content.
- `\titlelogo{}` image slot (template-ict.tex:117), empty in the sample; the logo is a file the user ships.
- Missing assets: `refs.bib` and the `img/` directory are not in the zip.

## Lib changes
- New ways proposed: none. Considered and not proposed: `pdfcprot` (folded into `sp.microtype`, same protrusion effect, W1 read at ctan.org/pkg/pdfcprot: on CTAN, TeX Live and MiKTeX, LPPL 1.2), `morewrites` and `coolstr` (loaded at h2020proposal.cls:63,69,85, load-only helpers with no printed effect, as the rejected `sys.compat-load`), `pgfgantt` (a TikZ-based chart in a figure, so `art.tikz` content).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
