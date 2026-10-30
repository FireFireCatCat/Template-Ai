yes

# 0428-calendar: The LaTeX Calendar Bundle (user's guide `calguide.tex` and the bundle's package sources)

- Unverified: read from the source, not compiled.
- Source: Source/0428-calendar/ (origin: https://mirrors.ctan.org/macros/latex/contrib/calendar.zip; licence: `nosell` in the manifest. allcal.ins:66-76 forbids changing the generated files, distributing one file alone and selling; contrib/evautofl/evautofl.ins:31-34 and contrib/evweek/evweek.ins:31-34 state LPPL 1.3a)
- Kind: misc (the sample is a software user manual in `article`; the manifest hint `calendar` describes the bundle, not the sample)
- Lib: v5
- Engine: pdfLaTeX-compatible for the sample (it loads only `article` and `float`). Not established for the bundle's own styles: `weekly` and `timetabl` rotate text with `lscape`/`rotating`, and the guide ties rotation and colour to PostScript drivers (calguide.tex:589-592, 756-760, 402)
- Look carried by: mixed (sample: kernel `article` defaults plus the `float` package's `plain` and `boxed` figure styles set in preamble and body, calguide.tex:8, 87-88, 166-167; the bundle's calendar looks live in CTAN styles generated from the `.dtx` files, which the sample does not load)
- Class origin: tex-distribution-unbundled (`article`; the zip also carries the CTAN classes `weekly`, `evweek`, `filoaddr` only as `.dtx` source, none loaded by the sample)
- Main file: calguide.tex (other samples: none as separate `.tex`; documentation examples inside caldemos.dtx:68-179, contrib/evautofl/evautofl.dtx:35-62, contrib/evweek/evweek.dtx:35-41, mkaddr.dtx:138-157)
- Read: main yes, zip-local classes and styles all (every unprefixed code line of the 16 `.dtx` files via a comment-stripped listing, plus margins.sty, calopts.cfg, dates.cfg and allcal.ins in full and the two contrib `.ins` files as code lines; the `.dtx` documentation prose, `bigdemo.tgz` and the contrib PDFs were not opened)

## Verdict
yes, on the rubric's scope (the class and style files the sample loads, its preamble and its body constructs). `calguide.tex` loads `article` and `float` only, every body construct has a lib way, and its four zip-local macro groups (`\cs`, `\myeg` with its lengths, the local `\{` `\}`, the version strings) reduce by inline expansion. Look carried by a published class plus `float`, so this is mainly evidence about the class dimension.
Outside the sample's reach and recorded, not scored: the nine calendar styles are CTAN-published (the zip is the CTAN bundle, so W1 holds) and are driven by keyval options, name lists and `.cld` data, which the lib's `cal.termcal` line admits as "another configurable calendar package as the parameter"; their code is heavy irreducible TeX (custom output routine, date parser, sorter) but it is published, not copied by an emitter. The Tcl and Emacs scripts of `mkaddr.dtx` and the bash/dvips script of `plotutil.dtx` are tools outside TeX and no style or demo loads them; if a reader scopes the verdict to the whole bundle instead of the sample, those make it `EXTERNAL`, so this `yes` rests on the sample scope.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (calguide.tex:7)
- Class-native vocabulary used: `\title` `\author` `\thanks` `\maketitle` `\tableofcontents` `\section` `\section*` `\subsection` `\subsubsection` `\footnote` `\thispagestyle{empty}` `\newpage` `\setcounter{page}`, `figure` (placements `[tbp]` `[bh]` `[bht]` `[ht]` `[H]`) with `\caption`, `itemize`, `description`, `quote`, `verbatim`, `\verb`

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | calguide.tex:7 | `class.article` | a4paper |
| paper size | calguide.tex:7 | `page.class-options` | a4paper |
| fonts | calguide.tex:7-12 | none (default Computer Modern, no font package loaded) | n/a |
| font size in a group | calguide.tex:97, 521-537 | `font.size-commands` | `\small` inside `\bgroup ... \egroup` and inside the figure |
| title block | calguide.tex:14-21 | `front.maketitle` | `\title{User's Guide to the \LaTeX{} Calendar Bundle...}`, `\author{Frank G. Bennett, Jr.}`, `\maketitle` |
| author-note footnote on the title | calguide.tex:15-17 | `front.thanks` | `\thanks{... \fileversion ... \filedate}` |
| title-page style | calguide.tex:22 | `hf.pagestyle-kernel` | `\thispagestyle{empty}`; all other pages keep the `article` default (no code) |
| contents | calguide.tex:24 | `toc.kernel` | `\tableofcontents` |
| page break and page counter | calguide.tex:25, 27 | `pg.break`, `pgnum.pagenumbering` | `\newpage`; `\setcounter{page}{1}` |
| headings | calguide.tex:29, 40, 56, 164, 192, 626, 680 | `head.kernel` | `\section*`, `\section`, `\subsection`, `\subsubsection`; no `\renewcommand` of the heading format |
| cross-references | calguide.tex:125, 132, 164, 628 | `xref.kernel` | `\label{lists}`, `\ref{lists}`, `\label{options}`, `\ref{options}` |
| lists | calguide.tex:690-738, 755-770 | `list.kernel` | `description` with `\item[\texttt{..}]`; `itemize` |
| block quotation | calguide.tex:940-942 | `quote.kernel` | `quote` holding `\verb+blocks=...+` |
| inline marks | calguide.tex:46, 116 | `mark.kernel` | `\texttt`, `\textit` |
| footnotes | calguide.tex:287-291, 638-641 | `fn.kernel` | `\footnote{..}` |
| figure floats | calguide.tex:90-114, 180-190, 202-208, 253-261 | `fig.graphicx` | the kernel `figure` float holding verbatim or boxes (no `\includegraphics`); placements tbp, bh, bht, ht, H |
| float styles | calguide.tex:8, 87-88, 166-167, 253, 263 | `fig.float` | `\floatstyle{plain}` then `\floatstyle{boxed}`, each followed by `\restylefloat{figure}`; `[H]` placement |
| captions | calguide.tex:113, 189, 207, 260 | `cap.kernel` | `\caption{..}` |
| verbatim code | calguide.tex:181-188, 203-206, 521-537, 605-614 | `code.verbatim` | `verbatim` environment, `\verb+..+`; `.cld` and `.tex` snippets are code text (content) |
| boxed examples, frames | calguide.tex:73-85, 93-94 | `box.fancybox` | `\fbox` with `\fboxsep=2pt`, `\fboxrule=0.4pt`; each `\hbox to w{text\hfill}` line is a left-aligned kernel `\makebox[w][l]{text}` |
| boxed examples, fixed-height stack | calguide.tex:75, 85 | `box.minipage` | `\vbox to\myboxAheight{..\vfill}` is `\parbox[t][3cm][t]{119.4pt}{..}` |
| manual spacing and filling | calguide.tex:98-112 | `sp.manual-space` | `\hfill`, `\hskip10pt`, `\vskip10pt`, `\vfill`, `\hskip\fboxsep` |
| user lengths | calguide.tex:71-72, 93-96 | `sp.lengths` | `\newlength\myboxAwidth`, `\myboxAwidth=119.4pt`, `\myboxAheight=3cm` |
| [outside sample, recorded] calendar environments `monthly` `yearly` `timesheet` `timetable` `weekly` `eventlist` | caldemos.dtx:68-76, 112-179; calendar.dtx:469-540; contrib/evweek/evweek.dtx:35-41 | `cal.termcal` | package is the parameter (`\usepackage{monthly}` or `\documentclass{weekly}`), body `\begin{env}{keyval options}{data lists} <date or range> \end{env}`; options are strings, lengths, integers, booleans and font switches (monthly.dtx:245-256, timesht.dtx:247-261, timetabl.dtx:211-227, autofilo.dtx:540-566); events from `.cld` files (caldemos.dtx:182-207) |
| [outside sample, recorded] language name lists | dates.cfg:1-13; calopts.cfg:1-2 | `cal.termcal` | `\DeclareCalendarLanguage{..}` with weekday, month and short-name lists (the lib line names "name lists") |
| [outside sample, recorded] Filofax page frame, punch holes | autofilo.dtx:367-446, 588-629 | `cal.termcal` | declared by keys `pageheight` `pagewidth` `punchcluster` `punchgroups` `interspace` `intraspace` `grip` `punchmargin` `punchpoints` `jawspread` `jawline`; drawn inside the published package with `\circle` and rules, so package-internal, not zip artwork |
| [outside sample, recorded] margin control | margins.sty:4-22; caldemos.dtx:114, 133, 147 | `page.setlength` | `\margins{1.5cm}` sets `\topmargin`, `\oddsidemargin`, `\evensidemargin` to -1in plus the margin, `\textwidth` and `\textheight` to paper size minus twice the margin, `\headheight=0pt`, `\headsep=0pt`; the same effect as `page.geometry` with equal margins |
| [outside sample, recorded] HTML styles `hmonth` `hlist` `hml` | htmlstuf.dtx:116-381; caldemos.dtx:79-108 | no way claimed | typeset result is empty; the markup goes to the `outputfile` string through `\openout` and `\write` (htmlstuf.dtx:129-141, 164-167), no tool outside TeX; not a printed look |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\cs` | calguide.tex:11 | yes | `\DeclareRobustCommand\cs[1]{\texttt{\char`\\#1}}` is an alias; expand each call to `\texttt{\textbackslash name}` (`mark.kernel`) |
| `\myeg`, `\myboxAwidth`, `\myboxAheight` | calguide.tex:71-85, called at 98-110 (nine calls with constant arguments) | yes | inline-expand each call; the `\ifcat$#2$\else..\fi` test only skips the `\usepackage` line when the argument is empty, and it is decided per call site; boxes become `box.fancybox` + `box.minipage` + `sp.manual-space` with `sp.lengths` (119.4pt, 3cm, `\fboxsep` 2pt, `\fboxrule` 0.4pt) |
| local `\{` and `\}` | calguide.tex:91-92 | yes | defined inside the figure group to print tt braces; replace by `\char`\{`/`\char`\}` or `\textbraceleft`/`\textbraceright` (content glyphs) |
| `\fileversion`, `\filedate` | calguide.tex:9-10 | yes | string macros used once in `\thanks` (calguide.tex:16-17); expand inline |
| `calopts.cfg`, `dates.cfg` | calopts.cfg:1-67; dates.cfg:1-13 | not needed for the sample | option pass-through to `color` and `graphics` and the two language lists; declarative; recorded with the bundle |
| bundle styles `calendar`, `dates`, `overword`, `monthly`, `yearly`, `timesht`, `timetabl`, `weekly`, `evntlist`, `autofilo`, `hmonth`/`hlist`/`hml`, `evautofl`, `evweek` | calendar.dtx:446-1906; dates.dtx:650-2414; overword.dtx:216-270; autofilo.dtx:205-634; weekly.dtx:109-428 and the others | not copied by an emitter | published CTAN code (W1) and not loaded by the sample; as code it would be irreducible: custom output routine `\@outputpage` `\@outputdblcol` (autofilo.dtx:272-283, 334-358, 456-520), word-by-word reader with catcode changes (overword.dtx:216-270; dates.dtx:942-947, 1886-1907), sorter (calendar.dtx:886-1077), calendar date arithmetic (dates.dtx:2051-2167) |
| `filoaddr.cls`, `mkaddr.tcl`, `.emacs.for.bbdb` | mkaddr.dtx:443-537, 235-435, 165-224 | out of the sample | the class lays out address pages; the `.tex` body is generated by a Tcl script from an Emacs BBDB database: `EXTERNAL`, if it were in scope |
| `hpplotsz.sty`, `dvipshpplotq` | plotutil.dtx:62-75, 34-56 | out of the sample | writes a `.hps` header for a bash and dvips run on HP plotters: `EXTERNAL`, if it were in scope |

## Content-opaque
none for the sample (the `.cld` event lists and example documents shown in `verbatim` are code text, calguide.tex:181-188, 204-205, 255-269). Not opened: `bigdemo.tgz` (binary archive of demo data, MANIFEST:31) and the pre-built PDFs in contrib/.

## Lib changes
- New ways proposed: none. Considered and not proposed: a separate calendar-bundle way, because the lib's `cal.termcal` line already admits another configurable calendar package as the parameter; the HTML styles are left without a way because they print nothing and fall outside the sample.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
