yes

# 0723-amnestyreport: amnestyreport (Amnesty International report class, B. Veytsman)

- Unverified: read from the source, not compiled.
- Source: Source/0723-amnestyreport/ (origin: https://mirrors.ctan.org/macros/latex/contrib/amnestyreport.zip; licence: LPPL 1.3, amnestyreport.dtx:3-13)
- Kind: report
- Lib: v5
- Engine: needs XeLaTeX (or LuaLaTeX): `fontspec` loaded unconditionally with font files named by file (amnestyreport.dtx:505-530); Makefile:13,26,29 and sample.Rmd:23 build with xelatex
- Look carried by: class (the published class defines the look; the sample preamble only adds pandoc code-highlighting macros, sample.tex:3-57, and `\thesection`, sample.tex:43)
- Class origin: ctan
- Main file: sample.tex (other samples: sample.Rmd, the R Markdown source of the same sample; amnestytemplate.tex, a pandoc template; amnestyreport.dtx, class source plus manual)
- Read: main yes, zip-local classes and styles all (no .cls or .sty is shipped; the class exists as amnestyreport.dtx, read in full, 1141 lines, code at 351-1131)

## Verdict
The look is carried by `class.amnestyreport`, a published CTAN class (the zip is its own CTAN distribution). The sample adds only reducible pandoc boilerplate (`\newcommand` colour aliases, a `fancyvrb` environment, a `framed` shaded box, `\thesection`) and a list of published packages. No TikZ, no custom output routine, no tool outside TeX is needed to compile `sample.tex`. Considered and not applied: `EXTERNAL` for the R/pandoc route (Makefile:22-23, amnestytemplate.tex), because it only feeds the class's own commands and `sample.tex` is the plain LaTeX result; missing fonts and figure images are missing assets, not blockers. A reviewer who counts the Rmd route as part of the template would flip this to `no`.

## Blockers
none

## Class setting
- Class: `class.amnestyreport` options: `freefonts, nologo` (sample.tex:1-2). Class defines `a4paper` (default) `letterpaper` (dtx:385-386), `amnestyfonts` (default) `freefonts` (dtx:400-401), `logo` `nologo` (dtx:415-416), `\ExecuteOptions{a4paper,amnestyfonts}` (dtx:421); loads `article` (dtx:436). `logo` is switched off when `Amnesty_logo.png` is missing (dtx:427).
- Class-native vocabulary used: `\title` `\subtitle` `\titleimage` `\titleimagecaption` `\copyrightyear` `\firstpublicationyear` `\reportindex` `\blurb` (sample.tex:58-74), `\frontmatter` `\maketitle` `\mainmatter` `\backmatter` (sample.tex:79-84,399), `AmnestyGlossary[width]` (sample.tex:86), `\tightlist` (sample.tex:129), `\sideTableCaptions` `\normalTableCaptions` `\sideFigureCaptions` (sample.tex:274,294,354), `\citep` (sample.tex:218), `\attribution` (sample.tex:396), colours `AmnestyYellow` `AmnestyGray1`..`4` (dtx:586-591). Defined but not called by the sample: `\reportyear` `\reportmonth` (dtx:643-654, used on the back cover at dtx:805), `\normalFigureCaptions` (dtx:995), `\citet` (dtx:478).

## Component map
Rows marked "(in class)" are realised inside the class by the named published package; the emitter writes only the class call and its commands.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | sample.tex:1-2; dtx:436 | `class.amnestyreport` | options freefonts, nologo; base `article` |
| paper size | dtx:385-386,421 | `page.class-options` | a4paper (default) or letterpaper, forwarded to geometry |
| page geometry (in class) | dtx:441-442 | `page.geometry` | top=1.02in, bottom=1.38in, left=1.26in, right=1.26in, footskip=40pt |
| title-page geometry (in class) | dtx:692-693,744 | `page.geometry` | `\newgeometry` top=0.55in, bottom=1.18in, left=right=0.55in, footskip=20pt; `\restoregeometry` |
| text sizes (in class) | dtx:540-575 | `font.size-commands` | `\normalsize` 9/11pt (copied from size9.clo), `\small` 8/9, `\footnotesize` 7/8, `\large` 10/12 ... `\Huge` 17/22 |
| paragraph and display spacing (in class) | dtx:542-546,576-577 | `sp.lengths` | `\parskip` 6pt, `\parindent` 0, display skips 8pt plus 4pt minus 4pt |
| ragged right (in class) | dtx:1129 | `sp.ragged` | `\raggedright` for the whole document |
| hyphenation off (in class) | dtx:447 | `sp.hyphenat` | `hyphenat[none]` |
| text and condensed fonts (in class) | dtx:505-528 | `font.fontspec` | `\setmainfont` Amnesty Trade Gothic Light, or with `freefonts` TeX Gyre Adventor regular/bold/italic/bolditalic .otf; `\newfontfamily\condensed` Amnesty Cn18, or QTHelvetCnd-Light/QTHelvetCnd |
| monospace font (in class) | dtx:529-530 | `font.fontspec` | `\setmonofont[StylisticSet={1,2,3}]{Inconsolatazi4-Regular.otf}[BoldFont=Inconsolatazi4-Bold.otf]` |
| icon glyphs (in class) | dtx:531,743,930-935,1039-1049 | `font.icons` | `fontawesome5`: `\faEye[regular]` `\faEnvelope` `\faPhone*` `\faFacebook` `\faTwitter` |
| colours (in class) | dtx:585-591 | `color.xcolor` | `\definecolor` RGB/cmyk: AmnestyYellow 255,255,0; Gray1 228; Gray2 178; Gray3 118; Gray4 defined twice (82 then 37, the later wins); Gray5 is documented at dtx:238-239 but never defined |
| highlight (in class) | dtx:592-593,703 | `mark.ulem` | `soul` `\hl{}` with `\sethlcolor{AmnestyYellow}`; title, mission text, back-cover title |
| case change (in class) | dtx:703,707,823 | `mark.case` | `\MakeUppercase` on title, subtitle, headings, toc entries |
| links and URL font (in class) | dtx:452-456 | `meta.hyperref` | `colorlinks=false`, `\def\UrlFont{}`, `\sectionautorefname`/`\subsectionautorefname`/`\subsubsectionautorefname` = Section |
| URL in text | sample.tex:114 | `meta.url` | `\url{...}` |
| cross-references | sample.tex:224,336,351 | `xref.kernel`, `xref.hyperref` | `\label`, `\autoref` |
| front matter and title page | sample.tex:58-80; dtx:600-745 | `front.class-native` | title 48pt condensed bold uppercase on yellow `\hl`; subtitle 22pt; image `\includegraphics[width=18.17cm]` of a square file (dtx:699); back of title page: 22pt mission text, two footnotesize `\parbox` columns with licence, imprint and cover-photo caption (dtx:711-743) |
| back-of-title page style | dtx:786-792 | `hf.class-native` | `backtitlepage`: foot L "Index: ..." plus amnesty.org link, foot R logo |
| header and footer page styles (in class) | dtx:779-809 | `hf.fancyhdr` | head and foot rules 0pt; styles `titlepage`, `backtitlepage`, `main` (foot L title, subtitle, "Amnesty International"; foot R page number plus `\hspace{1in}`), `backcoverpage` |
| style selection by matter | sample.tex:79,84; dtx:682-685,756-758 | `hf.class-native` | `\frontmatter` sets `empty`; `\mainmatter` sets `main` |
| page numbering and breaks | dtx:683,756,1022 | `pgnum.pagenumbering` | `\pagenumbering{arabic}` in `\frontmatter` |
| page breaks | sample.tex:116,208,365; dtx:756 | `pg.break` | `\clearpage`, `\cleardoublepage` |
| contents list | sample.tex:83 | `toc.kernel` | `\tableofcontents` |
| toc entry look (in class) | dtx:859-919 | `front.class-native` | `\l@section` 11pt bold condensed uppercase, `\l@subsection` 10pt, `\l@subsubsection` 9pt, indents 1.5em/2em/2.5em, `\numberline` = number plus `~` |
| toc entries for starred headings | sample.tex:119,148,158 | `toc.kernel` | `\addcontentsline{toc}{section|subsection}{...}` |
| headings (in class) | dtx:820-848; sample.tex:118,210,227,230,367,369,371,373,378 | `head.class-native` | `\@startsection` redefined, all condensed bold raggedright uppercase: section 45pt, subsection 21pt, subsubsection 16pt, paragraph 11pt; paragraph afterskip `1sp` gives a line break after the heading (sample.tex:375) |
| section numbering | sample.tex:43,118,146 | `num.counters` | `\renewcommand{\thesection}{\Alph{section}}`; starred `\section*` for unnumbered |
| lists | sample.tex:128-136,162-170,383-387 | `list.kernel` | `itemize`, `description` |
| tight lists | dtx:1119-1120; sample.tex:129 | `sp.lengths` | `\tightlist` = `\itemsep` 0pt, `\parskip` 0pt |
| quotation | sample.tex:391-397; dtx:1099-1111 | `quote.kernel` | `quote` redefined as a framed left bar: `\vrule width 6pt \hspace{10pt}` through `\MakeFramed`, text `\Huge\bfseries\condensed\raggedright`; `\attribution` in `\normalsize\mdseries` |
| quote left bar (in class) | dtx:489,1100-1103 | `box.mdframed` | `framed` `\FrameCommand`, `\MakeFramed`, `\FrameRestore` |
| footnotes | sample.tex:235; dtx:1008-1011 | `fn.kernel` | `\@makefntext` unindented, `\hangindent` 2em, `\@makefnmark\,` |
| citations | sample.tex:218-219; dtx:466,474-478 | `bib.biblatex-bibtex` | `biblatex[backend=bibtex]`; `\citep` and `\citet` = `\footfullcite` (footnote citations) |
| bibliography data | sample.tex:76; examplereferences.bib:1-17 | `bib.biblatex-bibtex` | `\addbibresource`; the sample never calls `\printbibliography` |
| mixed marks | sample.tex:121,218,248 | `mark.kernel` | `\texttt`, `\textbf`, `\textit`, `\textsuperscript` |
| table | sample.tex:276-291,296-311 | `tbl.tabular` | `tabular[t]{lrr}`, caption before table, `[!ht]`, `\centering` |
| table rules | sample.tex:282-289 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| glossary | sample.tex:86-111; dtx:1076-1086 | `front.class-native` | `AmnestyGlossary[10em]`: `\clearpage`, `\section*{Glossary}`, term column width = argument (default 5em) |
| glossary table (in class) | dtx:1068,1080-1085 | `tbl.longtable` | `longtable` with `p{#1}<{\raggedright}p{\textwidth-2\tabcolsep-#1}<{\raggedright}`, `\extrarowheight` 1pt |
| glossary striping (in class) | dtx:1081 | `tbl.colortbl` | `\rowcolors{1}{AmnestyGray1}{white}` (needs xcolor table support; not checked) |
| side captions (in class) | dtx:495-496,946-954,984-987; sample.tex:274,354 | `fig.floatrow` | `sidecap[rightcaption]`, `\def\table{\SCtable[50]}`, `\def\figure{\SCfigure[50]}`, `\def\SC@figure@vpos{t}`; `\normalTableCaptions` restores `table` |
| figures | sample.tex:341-348,356-363 | `fig.graphicx` | `figure`, `\centering`, `\includegraphics` without options, caption after |
| float placement | sample.tex:313; dtx:484,940-943 | `fig.placement` | `placeins` `\FloatBarrier`; `\fps@figure`, `\fps@table`, `\fps@SCfigure`, `\fps@SCtable` = `hb` |
| caption look (in class) | dtx:929-939 | `cap.caption` | `caption[font=it]`; `\DeclareCaptionLabelFormat` table (down arrow, eye icon, italic), figure (up arrow), side (left arrow); `\captionsetup[table|figure|SCfigure|SCtable]{labelformat=...}` |
| caption command | sample.tex:278,298,347,362 | `cap.kernel` | `\caption` with `\label` |
| logo or strut (in class) | dtx:769-774 | `fig.graphicx` | `\includegraphics[height=0.5in]{Amnesty_logo}` or `\rule{0pt}{0.5in}` (`sp.rule`) |
| back cover (in class) | sample.tex:399; dtx:1021-1057 | `front.class-native` | `\backmatter`: 40pt uppercase slogan in a 5in `\vbox`, yellow bar `\rule{10pt}{\ht\@tempboxa}`, two contact `\parbox` columns with icons and `\href`, then `backcoverpage` style with title, subtitle, `\@blurb` |
| back-cover pieces (in class) | dtx:1031,1034-1049 | `sp.rule`, `box.minipage`, `sp.manual-space` | `\rule`, `\parbox[t]{0.45\textwidth}`, `\vfill`, `\hspace{5pt}` |
| pandoc code blocks | sample.tex:7,174-206,240-244 | `code.verbatim` | `fancyvrb` `\DefineVerbatimEnvironment{Highlighting}{Verbatim}{commandchars=\\\{\}}`, plain `verbatim` |
| code shading | sample.tex:9-11 | `box.mdframed` | `framed` `snugshade` inside `Shaded`; `shadecolor` RGB 248,248,248 |
| code token colours | sample.tex:3,12-42 | `color.xcolor` | `\textcolor[rgb]{...}` with `\textbf`, `\textit` (`mark.kernel`) |
| preamble packages loaded by pandoc | sample.tex:44-57 | `tbl.longtable`, `tbl.multirow`, `fig.wrapfig`, `fig.float`, `pg.landscape`, `tbl.nicematrix`, `tbl.threeparttable`, `mark.ulem` | `array`, `multirow`, `makecell`, `wrapfig`, `float`, `colortbl`, `pdflscape`, `tabu`, `threeparttable`, `threeparttablex`, `ulem[normalem]`; none is called in the body |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\VerbBar`, `\VERB` | sample.tex:5-6 | yes | aliases of `\Verb[commandchars=\\\{\}]` from `fancyvrb`: `code.verbatim` |
| `Highlighting` environment | sample.tex:7 | yes | `\DefineVerbatimEnvironment`: `code.verbatim` |
| `shadecolor`, `Shaded` | sample.tex:10-11 | yes | `\definecolor` plus `snugshade` from `framed`: `color.xcolor`, `box.mdframed` |
| 31 `...Tok` commands | sample.tex:12-42 | yes | each is `\textcolor[rgb]{r,g,b}{#1}`, optionally with `\textbf` or `\textit`; inline expansion: `color.xcolor`, `mark.kernel` |
| `\thesection` | sample.tex:43 | yes | `\renewcommand{\thesection}{\Alph{section}}`: `num.counters` |
| `amnestytemplate.tex`, `Makefile`, `sample.Rmd` | amnestytemplate.tex:1-70; Makefile:22-23 | not LaTeX code | pandoc template and R build route; its LaTeX skeleton (lines 1-8,48-70) is the same class commands as sample.tex, so it adds nothing for an emitter |

Class internals are published, so they are not bespoke here. If the class were treated as zip-local, each part still reduces to published packages: `\@startsection` headings (dtx:820-848) to `titlesec` `\titleformat`; `\l@section` family (dtx:859-919) to `tocloft` or `titletoc`; `\@makefntext` (dtx:1008-1011) to `footmisc` hang options; `\maketitle` (dtx:691-745) to geometry, graphicx, soul, `\parbox`, fancyhdr styles; `\backmatter` (dtx:1021-1057) to `\parbox` columns plus a `framed` left bar in place of the measured `\ht\@tempboxa` rule; `\def\table{\SCtable[50]}` switches (dtx:950-998) to `SCtable` and `SCfigure` written per float. No `\halign`, output routine, expl3 or Lua code. Nothing in the zip is addressed to an AI.

## Content-opaque
Figure images `sample_files/figure-latex/species-petal-size-1` and `petal-size-sepal-size-1` (sample.tex:343,358; R-generated, not shipped); title image BoschFragment.png (sample.tex:60); code token text (sample.tex:240-332); glossary, table and quotation text. Missing assets: Amnesty Trade Gothic fonts (proprietary, not used with `freefonts`), `Amnesty_logo.png` (suppressed by `nologo`), `QTHelvetCnd*.otf` (provenance not established), the figure images; TeX Gyre Adventor ships with TeX Live, the other font files were not checked.

## Lib changes
- New ways proposed: none. Considered and mapped to existing lines: `sidecap` to `fig.floatrow`, `soul` to `mark.ulem`, `framed` to `box.mdframed`, `placeins` to `fig.placement`; `xparse` is loaded only to define `\citep` (dtx:473) and prints nothing.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
