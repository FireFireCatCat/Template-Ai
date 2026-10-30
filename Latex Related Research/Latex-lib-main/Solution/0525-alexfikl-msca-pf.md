yes

# 0525-alexfikl-msca-pf: MSCA Postdoctoral Fellowship proposal template (unofficial, Part B-1 and B-2)

- Unverified: read from the source, not compiled.
- Source: Source/0525-alexfikl-msca-pf/ (origin: https://codeload.github.com/alexfikl/msca-pf/zip/refs/heads/main; licence: CC0-1.0)
- Kind: misc (grant application form with CV entries and fixed tables)
- Lib: v4
- Engine: needs LuaLaTeX (the samples' tagged `\DocumentMetadata`, msca-pf-part-b1-template.tex:9-19, README.md:80-81; the class and body also build under pdfLaTeX once that block is deleted, README.md:102-106, .github/workflows/ci.yml:29)
- Look carried by: zip-local (msca-pf.cls sets fonts, headers/footer, headings, title and tables; the samples only add `cleveref`, `booktabs`, `microtype` and a section counter)
- Class origin: zip-local
- Main file: msca-pf-part-b1-template.tex (other samples: msca-pf-part-b2-template.tex)
- Read: main yes (both samples in full), zip-local classes and styles all (msca-pf.cls in full; no .sty/.def/.cfg present)

## Verdict
yes. `msca-pf.cls` is a zip-local, thin wrapper: `\LoadClass{scrartcl}` (msca-pf.cls:38), a list of published packages with options, `\@startsection` and `\@maketitle` calls whose arguments are plain lengths and font switches, wrappers around `tabular` and `longtable`, `\NewDocumentCommand` aliases, and one hand-rolled time-of-day stamp that the `datetime` family prints natively. Every item reduces to lib ways with parameters (reductions below), there is no artwork and no external tool in the document build. The weakest points are the time stamp (cls:94-103) and the two kernel-internal redefinitions (cls:191-193, cls:228-237); I judged them reducible because a published way with the same parameters exists for each. The class is not on CTAN (ctan.org/pkg/msca-pf is a 404) and the README calls it unofficial (README.md:8), so it is zip-local, not a published class.

## Blockers
none

## Class setting
- Class: `class.scrartcl` (reached through the zip-local `msca-pf` class, `\documentclass[12pt,draftproposal]{msca-pf}` at msca-pf-part-b1-template.tex:21) options: `DIV=15,12pt,a4paper,parskip=half*` forced by the class (msca-pf.cls:35), any other option is forwarded (msca-pf.cls:34), `minimal` adds `fontsize=11pt` (msca-pf.cls:131).
- Class-native vocabulary used: KOMA `\KOMAoptions` (cls:131), `\addtokomafont{disposition}` (cls:187), `scrlayer-scrpage` commands `\clearpairofpagestyles` `\pagestyle{scrheadings}` `\ihead` `\ohead` `\cfoot` with optional plain-page arguments (cls:217-222). The `msca-pf` vocabulary the samples call (zip-local, reduced below): options `draftproposal` `layoutgrid` `minimal` (cls:16-25), `\mscaidentifier` `\mscaproject` (cls:203-204, commented out in the samples at b1:55-56), environments `mscaexplanation` `mscaorgoverview` `mscaorgcapacity` `cvitem`, commands `\cventry` `\cvdetail` `\cvpub` `\cventryitem` `\cvpubitem` (cls:243-350).

## Component map
Paths: `cls` = msca-pf.cls, `b1` = msca-pf-part-b1-template.tex, `b2` = msca-pf-part-b2-template.tex.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | cls:38, b1:21 | `class.scrartcl` | via `\LoadClass`; options DIV=15, 12pt, a4paper, parskip=half* (cls:35) |
| paper and base size | cls:35 | `page.class-options` | a4paper, 12pt (11pt through `\KOMAoptions{fontsize=11pt}` under `minimal`, cls:131) |
| text area | cls:35 | `page.typearea` | DIV=15 |
| paragraph skip | cls:35 | `class.scrartcl` | KOMA option parskip=half* (a class option, not the `parskip` package) |
| minimal margins (option `minimal`) | cls:130-141 | `page.geometry` | top=bottom=left=right=15mm, headsep=2mm, footskip=16mm, includefoot |
| footskip, text height | cls:196-197 | `page.setlength` | `\footskip`=25pt, `\textheight`=`\dimexpr\textheight+4em` (set after geometry, so it wins; keep the order) |
| running head and foot | cls:217-222 | `hf.scrlayer-scrpage` | `\clearpairofpagestyles`, `\pagestyle{scrheadings}`, `\ihead[x]{x}`, `\ohead[y]{y}`, `\cfoot[z]{z}` (the optional arguments style the title page) |
| head and foot field text | cls:209-215 | `font.size-commands`, `mark.kernel`, `sp.manual-space`, `color.xcolor` | `\scriptsize`, `\textnormal`, `\vspace{\baselineskip}`, `\\`, `\textcolor{MSCAHeaderGray}`; strings from `\mscaidentifier` and `\mscaproject` defaults (cls:206-207) |
| page X of Y | cls:56, cls:215 | `pgnum.lastpage` | `lastpage`, `\pageref*{LastPage}`; text "Part B -- Page \thepage\, of\, ..." |
| colours | cls:53, cls:156 | `color.xcolor` | `xcolor[table]`; `\definecolor{MSCAHeaderGray}{RGB}{180,180,180}` |
| hyperlinks | cls:48, cls:159-164 | `meta.hyperref` | hypertexnames=false, breaklinks=true; colorlinks=true, urlcolor=blue, citecolor=black, linkcolor=black |
| bookmarks | cls:49, cls:145 | `meta.bookmark` | `\bookmarksetup{numbered}` at begin document |
| fonts (pdfTeX branch) | cls:167-171 | `font.fontenc-t1`, `font.newtx`, `font.helvet` | `[T1]{fontenc}`, `newtxtext`, `newtxmath`, `helvet` |
| fonts (Xe/Lua branch) | cls:173-183 | `font.fontspec` | `\setmainfont[Ligatures={TeX,Historic},Renderer=Basic]{Times New Roman}` fallback Nimbus Roman; `\setsansfont[Ligatures=TeX]{Arial}` fallback Nimbus Sans; fallback chain is `\IfFontExistsTF` |
| heading family | cls:187 | `head.koma-fonts` | `\addtokomafont{disposition}{\rmfamily}` |
| section, subsection, subsubsection | cls:191-193 | `head.kernel` | `\renewcommand\section{\@startsection{section}{1}{\z@}{0.5em}{0.5em}{\large\bfseries\itshape}}`; subsection `{2}{\z@}{0.5em}{0.5em}{\normalsize\bfseries\itshape}`; subsubsection `{3}{\z@}{0.25em}{0.25em}{\normalsize\bfseries\itshape}` (alternative `head.titlesec`: `\titleformat` with the same shape, `\titlespacing*` with the same skips) |
| section start number | b1:37, b2:37 | `num.counters` | `\setcounter{section}{0}` (B-1), `{3}` (B-2) |
| title block | b1:50-52, b1:62, cls:228-237 | `front.maketitle`, `front.titling` | `\title{Part B-1}`, empty `\author{}` `\date{}`; reduction of `\@maketitle`: pretitle `\null\centering\vspace{-\baselineskip}\huge\bfseries`, posttitle `\par\vspace{\baselineskip}`, author/date hooks empty |
| draft time stamp (option `draftproposal`) | cls:93-106 | `front.datetime` | "Draft of \today at HH:MM" with `\,:\,` between hours and minutes; the time is the `datetime`/`datetime2` current-time command with a 24-hour two-digit format (CTAN page of `datetime`: "commands for displaying the current time ... in 12-hour, 24-hour or text format") |
| line numbers (draft) | cls:109-116, cls:148 | `sp.draft-lineno` | `lineno[mathlines]`, `\linenumbers`; `\linenumberfont` = `\normalfont\footnotesize` in `black!50` |
| layout grid (option `layoutgrid`) | cls:119-127 | `bg.eso-pic`, `draft.todo` | `eso-pic[grid,gridBG,gridunit=mm,gridcolor=gray!70,subgridcolor=gray!70,texcoord]`; `showframe` |
| accessibility metadata | b1:9-19, b2:9-19 | `meta.documentmetadata` | `\DocumentMetadata{lang=en, pdfstandard=ua-2, pdfstandard=a-4f, tagging=on, testphase={phase-II,table,firstaid}, tagging-setup={math/setup={mathml-AF,mathml-SE}, extra-modules={verbatim-mo}}}` |
| tagging roles and wrappers | cls:28-31, cls:72-87, cls:233-235, cls:281, cls:307, cls:325 | `meta.documentmetadata` | `\IfDocumentMetadataTF`; `\tagpdfsetup{role/new-tag={tag=msca-pf-comment, role=Div}` and three more}; `\tagstructbegin{tag=...}` / `\tagstructend`; `table/tagging`, `table/header-rows`, `table/header-columns` |
| guidance boxes `mscaexplanation` | cls:243-253, b1:64-69 | `meta.documentmetadata` | draft mode: tag struct `msca-pf-comment` around a plain group; final mode: the node is not emitted (the class typesets it into a discarded box, cls:252); considered: `comment` package (not needed) |
| organisation overview table | cls:279-302, b2:205-236 | `tbl.tabular`, `tbl.colortbl`, `sp.ragged`, `sp.lengths` | `\footnotesize`, `\centering`; column spec `\|>{\raggedright\arraybackslash}p{0.15\tablewidth}\|...` for six columns (0.15, 0.12, 0.25, 0.14, 0.15, 0.19); `\tablewidth` = `\dimexpr\textwidth - 12\tabcolsep - 7\arrayrulewidth` (cls:282); header row `\rowcolor{gray!40}` with bold centred cells; `\hline` rules |
| organisation capacity table | cls:305-317, b2:255-290 | `tbl.longtable`, `tbl.tabular`, `sp.ragged`, `sp.lengths` | `\small`, `\centering`, `longtable` columns `\|>{\ra}p{0.3\tablewidth}\|>{\ra}p{0.7\tablewidth}\|`; `\tablewidth` = `\dimexpr\textwidth - 4\tabcolsep - 3\arrayrulewidth`; `\multicolumn{2}{\|l\|}` header rows (b2:256) |
| CV item blocks | cls:323-350, b2:132-158 | `tbl.tabular`, `sp.ragged`, `mark.kernel`, `sp.lengths` | `\noindent` `tabular{@{}>{\raggedright\arraybackslash}p{0.18\tablewidth}>{\raggedright\arraybackslash}p{0.82\tablewidth}}`, `\tablewidth` = `\dimexpr\textwidth - 4\tabcolsep`; row aliases `#1 & \textbf{#2}, \emph{#3}, #4. \\` (cls:334), `& \textbf{#1}: #2. \\` (cls:336), `#1 & #2, \emph{#3}, #4. \\` (cls:338) |
| lists | b1:81-87, b1:121-131, b2:85-92 | `list.kernel` | `itemize`, nested `itemize`, `enumerate` with `\renewcommand{\labelenumi}{\alph{enumi})}` (b2:86) |
| footnotes | b1:109, b1:112, b1:381, b1:389, b2:312, b2:317 | `fn.kernel` | `\footnotemark` / `\footnotetext` pairs |
| inline marks | b1:65, b1:66, b1:100, b1:209 | `mark.kernel` | `\itshape`, `\emph`, `\textbf`, `\texttt` |
| manual spacing | b2:276, b2:365 | `sp.manual-space` | `\bigskip`, `\hfill` |
| labels and references | b1:72, b2:175, b2:177 | `xref.kernel` | `\label`, `\ref` |
| cleveref package | b1:26, b2:26 | `xref.cleveref` | `[nameinlink, noabbrev]`; no `\cref` call in the samples |
| external links | b1:130, b2:191, b2:317 | `xref.hyperref`, `meta.url` | `\href{url}{text}`, `\url{...}` |
| micro-typography | b1:30, b2:30 | `sp.microtype` | `activate={true,nocompatibility}, tracking=true` |
| rule package | b1:27, b2:27 | `tbl.booktabs` | loaded, no `\toprule` call in either sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class `msca-pf` as a whole | msca-pf.cls:1-354 | yes | not a published class; the emitter writes `class.scrartcl` with its options plus the preamble rows above |
| options `draftproposal` `layoutgrid` `minimal`, `\newif` switches, `\DeclareOption*`, `\ProcessOptions` | cls:16-37 | yes | resolved when the emitter chooses the preamble; each option selects the rows tagged above |
| `\@draftproposal` time stamp (`\newcount\timehh` `\timemm`, `\ifnum` padding) | cls:94-103 | yes | `front.datetime`: the current-time command of `datetime` or `datetime2` with a two-digit 24-hour pattern; same printed content, no copied counters |
| `\draftheader` empty branch | cls:105 | yes | the field is left empty |
| `\renewcommand\section` `\subsection` `\subsubsection` via `\@startsection` | cls:191-193 | yes | six-argument kernel `\@startsection` with lengths and font switches = `head.kernel`, or `head.titlesec` `\titleformat`/`\titlespacing`; no routine of its own |
| `\def\@maketitle` | cls:228-237 | yes | `front.titling` pre/post hooks with the same spacing and font; it ignores `\@author` and `\@date`, so the emitter keeps `\author{}` `\date{}` empty |
| `\mscaidentifier`, `\mscaproject`, `\callihead`, `\callohead`, `\pagefooter` | cls:203-215 | yes | `\def` string aliases; expand inline into `\ihead` `\ohead` `\cfoot` |
| `\providecommand{\tagstructbegin}`, `\let` aliases | cls:72-77 | yes | compatibility shims; emit the tagging commands directly when tagging is on, nothing when off |
| `mscaexplanation` | cls:243-253 | yes | draft: tag struct plus group; final: node not emitted (see map) |
| `\ra`, `\tablewidth` | cls:259-261 | yes | `\raggedright\arraybackslash` in column specs; one `\newlength` set with `\dimexpr` |
| `msctable`, `msclongtable`, `mscaorgoverview`, `mscaorgcapacity` | cls:263-317 | yes | `\centering` + size switch + `tabular`/`longtable` with the column specs in the map; header row via `\rowcolor` |
| `cvitem`, `\cventry`, `\cvdetail`, `\cvpub`, `\cvpubitem`, `\cventryitem` | cls:323-350 | yes | two-column `tabular` and row text in the map; the `*item` forms are the same rows wrapped once |
| `iftex`, `xparse` loads and `\ifpdftex` branch | cls:46-47, cls:167-184 | yes | helper packages with no printed effect; the emitter picks the font branch by engine |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered: `comment` package for the discarded `mscaexplanation` box (not proposed: in draft mode the environment prints nothing of its own, and in final mode the emitter drops the node).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
