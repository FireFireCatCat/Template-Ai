yes

# 0873-r-journal: The R Journal article template (RJwrapper.tex + RJournal.sty)

- Unverified: read from the source, not compiled.
- Source: Source/0873-r-journal/ (origin: https://github.com/rjournal/share/raw/refs/heads/master/RJtemplate.zip; licence: not established)
- Kind: journal
- Lib: v6
- Engine: pdfLaTeX-compatible (Type 1 faces `helvet`, `mathpazo`, `inconsolata` under T1 and `inputenc` utf8; no fontspec, Lua or expl3)
- Look carried by: class (RJournal.sty, the journal's own style package over kernel `report`; the wrapper only loads packages and sets issue strings, the template holds content only)
- Class origin: publisher-official (RJournal.sty is the R Journal's own author kit, RJournal.sty:1-15; the `\documentclass` itself, `report`, ships with the TeX distribution and is not in the zip)
- Main file: RJwrapper.tex (other samples: RJtemplate.tex, pulled in by `\input` at RJwrapper.tex:22; RJwrapper_orig.pdf is a reference render and was not read)
- Read: main yes, zip-local classes and styles all (RJournal.sty 353 of 353 lines; the zip has no .cls, .def, .cfg or .bst)

## Verdict
Yes. The zip is the R Journal's own author kit (GitHub `rjournal/share`), so `RJournal.sty` counts as published under the official-kit ruling (RJournal.sty:8-12 says the journal resets any edit to it) and carries the whole look as a class-like style over kernel `report`; the wrapper only loads packages and sets issue strings and the template holds content only (RJwrapper.tex:8-23, RJtemplate.tex:1-61). Read without that ruling, every macro in the style still reduces to lib ways with parameters (Bespoke code table), the one residue being the kernel `\@noligs` call inside `\code` and `\samp` (RJournal.sty:250, 256), which names no lib way and which the sample never calls. There is no artwork: `tikz` is loaded at RJournal.sty:17 but no picture, node or path is drawn in any file (Grep of all .tex and .sty). Nothing was compiled; the missing `RJreferences.bib` and the unnamed `graphicx` load are asset and load-order notes, not blockers.

## Blockers
none

## Class setting
- Class: `class.report` options: `a4paper` (RJwrapper.tex:1). The look-carrying layer is `class.RJournal` (`\usepackage{RJournal}`, RJwrapper.tex:4; `\ProvidesPackage{RJournal}[2025/07/15 v0.16 RJournal package]`, RJournal.sty:15), a publisher-official house-style package, class-like by the lib's v6 precedent (`class.revquantum`, `class.llncsconf`); no options.
- Class-native vocabulary used: issue strings `\sectionhead` `\volume` `\volnumber` `\year` `\month` (RJwrapper.tex:14-18); environment `article` (RJwrapper.tex:21-23); `\title` `\author` `\maketitle` (RJtemplate.tex:2-5; `\subtitle` exists, RJournal.sty:99, not used); `\abstract{...}` (RJtemplate.tex:7-9); `\address` and `\email` (RJtemplate.tex:42-61); `example` environment (RJtemplate.tex:31-34); `\bibliography` with natbib `\citep` `\citet` (RJtemplate.tex:13-14, 40). Defined but unused by the sample: `\review`, `\titlepage`, `\tableofcontents`, `\code` `\samp` `\pkg` `\CRANpkg` and the other inline markup, `Sinput` family, `widefigure`, `widetable`, `\pandocbounded`, `\P` `\E` `\VAR` `\COV` `\COR`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | RJwrapper.tex:1 | `class.report`, `page.class-options` | a4paper |
| house-style package | RJwrapper.tex:4; RJournal.sty:15 | `class.RJournal` | no options; v0.16 of 2025/07/15 |
| encodings | RJwrapper.tex:2-3; RJournal.sty:54 | `font.fontenc-t1` | `inputenc` utf8; `fontenc` T1 |
| page geometry | RJournal.sty:24-28 | `page.geometry` | a4paper, textwidth=14cm, top=1cm, bottom=1cm, includehead, includefoot, centering, footskip=1.5cm |
| page flow, line breaking | RJournal.sty:29-30 | `pg.flush`, `sp.hyphenat` | `\raggedbottom`; `\sloppy` |
| issue strings for running heads | RJwrapper.tex:14-18; RJournal.sty:81-84, 96 | `hf.class-native` | `\sectionhead`, `\volume`, `\volnumber`, `\month`, `\year` store strings by `\def` and feed the header, footer and PDF title |
| header and footer | RJournal.sty:32-40 | `hf.fancyhdr`, `mark.kernel` | `\fancyhead{}` `\fancyfoot{}`, `\fancyheadoffset{2cm}`; head L `\textsc{<section head>}`, head R `\thepage`; foot L "The R Journal Vol. <vol>/<no>, <month>~<year>", foot R "ISSN 2073-4859"; `\pagestyle{fancy}` |
| text faces | RJournal.sty:49, 51-53 | `sp.microtype`, `font.helvet`, `font.palatino`, `font.mono` | microtype defaults; `helvet` scaled=0.92; `palatino` + `mathpazo`; `inconsolata` scaled=1.02 (comment at :42-47 states rm Palatino, tt Inconsolata, sf Helvetica) |
| links | RJournal.sty:56-58, 61-69 | `meta.url`, `meta.hyperref`, `color.color` | `url` option `hyphens`; `hyperref` option `pagebackref`, `\backref` = `[p#1]`; `\definecolor{link}{rgb}{0.45,0.51,0.67}`; `\hypersetup{colorlinks, citecolor, filecolor, linkcolor, urlcolor = link}` |
| paragraph spacing | RJournal.sty:72-74 | `sp.lengths`, `sp.setspace` | `\parskip`=3pt; `\setstretch{1.05}` |
| section headings | RJournal.sty:105, 107-108; RJtemplate.tex:11, 16, 27, 36 | `head.titlesec` | option `medium`; `\section`: `\normalfont\large\bfseries`, label `\arabic{section}`, sep 1em; `\subsection`: `\normalfont\normalsize\bfseries`, label `\arabic{section}.\arabic{subsection}`, sep 0.5em; before-code empty |
| article heading (a `\chapter` used as the title) | RJournal.sty:153-161, 132 | `head.kernel` as written (`\@startsection`), reducible to `head.titlesec` | `\@startsection{chapter}{0}{0mm}{-2\baselineskip \@plus -\baselineskip \@minus -.2ex}{\p@}{\phantomsection\normalfont\huge\bfseries\raggedright}`; number format emptied by `\renewcommand{\@seccntformat}[1]{}`; `\secdef` keeps report's `\chapter*` |
| title block | RJournal.sty:96-99, 130-144; RJtemplate.tex:2-5 | `front.class-native` | `\title` `\author` `\subtitle` store strings; `\maketitle` = article heading, then optional bold subtitle and italic author line, each `\par\nobreak\addvspace{\baselineskip}`, then `\@afterindentfalse\@nobreaktrue\@afterheading` |
| article wrapper | RJwrapper.tex:21-23; RJournal.sty:116-117 | `fig.placement` | `\FloatBarrier` (placeins) at both ends; clears title, author, subtitle |
| abstract | RJournal.sty:122-123; RJtemplate.tex:7-9 | `abs.class-native` | `\noindent\textbf{Abstract}~` followed by the text |
| float and equation numbers | RJournal.sty:182-185 | `num.counters` | `\theequation`, `\thefigure`, `\thetable` printed as plain arabic, no article number (`\numberwithin` line is commented out at :182) |
| contents depth | RJournal.sty:225-227 | `num.secnumdepth` | `tocdepth` 0 around `\tableofcontents`, then 2 |
| contents list (unused) | RJournal.sty:106, 109, 192-197 | `toc.kernel`, `toc.titletoc` | `\contentsname`=Contents; `\vspace{1cm}\section*{\contentsname}` then `\@starttoc{toc}`; `\titlecontents{chapter}[0em]{}{}{}{\titlerule*[1em]{.}\contentspage}` |
| issue cover page (unused) | RJournal.sty:199-229 | `front.titlepage-env`, `hf.pagestyle-kernel`, `meta.hyperref`, `font.size-commands`, `fig.graphicx`, `sp.manual-space`, `sp.rule`, `pg.break` | `\thispagestyle{empty}`; `\hypersetup{pdftitle, pdfauthor}`; `\fontsize{50pt}{50pt}\selectfont` title with `Rlogo-5` at height=77pt, `\raisebox{-8pt}`, `\hspace{10pt}`; `\large` volume line; `\rule{\textwidth}{1pt}`; `\Large` tagline; `\clearpage` |
| book review (unused) | RJournal.sty:166-170 | `meta.hyperref`, `head.kernel`, `toc.kernel` | `\pdfbookmark[1]`, `\section*`, `\addtocontents{toc}{\protect\contentsline{chapter}{..}}` |
| author addresses | RJournal.sty:234-235; RJtemplate.tex:42-61 | `front.class-native`, `sp.manual-space`, `mark.kernel`, `meta.hyperref`, `font.mono` | `\address` = `\addvspace{\baselineskip}\noindent\emph{#1}`; `\email` = `\href{mailto:#1}{\normalfont\texttt{#1}}` |
| inline semantic markup (unused) | RJournal.sty:233, 250-273 | `mark.kernel`, `mark.case`, `meta.hyperref`, `sp.hyphenat` | `\code` `\samp` `\kbd` `\key` `\var` `\file` `\dfn` `\strong` `\pkg` `\CRANpkg` `\ctv` `\BIOpkg` as `\texttt` `\textsl` `\textsf` `\fontseries{b}` `\uppercase` over `\href` and `\texorpdfstring` |
| sample inline emphasis and link | RJtemplate.tex:38 | `mark.kernel`, `meta.hyperref` | `\emph`; `\href{https://journal.r-project.org/share/author-guide.pdf}{..}` |
| citations | RJournal.sty:174; RJtemplate.tex:13-14 | `bib.natbib` | options `sectionbib`, `round`; `\citep`, `\citet` |
| bibliography | RJournal.sty:175-176; RJtemplate.tex:40 | `bib.bibtex-bst`, `bib.natbib` | `\bibliographystyle{abbrvnat}`; `\renewcommand{\bibsection}{\section*{References}}`; `\bibliography{RJreferences}` (the .bib is not in the zip) |
| code blocks | RJournal.sty:276-293; RJtemplate.tex:31-34 | `code.verbatim` | `fancyvrb`: `\DefineVerbatimEnvironment{example}{Verbatim}{}` and the same for `Sinput` `Soutput` `Scode` `Sin` `Sout`; `alltt` for `example*`; `Schunk` is an empty environment |
| maths | RJwrapper.tex:5; RJournal.sty:303-313 | `math.amsmath`, `math.amssymb` | `amsmath`, `amssymb`, `amsfonts`; `\P` `\E` = `\mathop{\operator@font I\hspace{-1.5pt}P\hspace{.13pt}}` (and `E`); `\VAR` `\COV` `\COR` = `\operatorname{var,cov,cor}` |
| figure | RJtemplate.tex:18, 20-25 | `fig.graphicx`, `sp.ragged`, `xref.kernel` | `figure[htbp]`, `\centering`, `\includegraphics{Rlogo-5}`, `\label` and `\ref`; `graphicx` is named nowhere in the zip |
| captions | RJournal.sty:329; RJtemplate.tex:23 | `cap.caption`, `cap.kernel` | `caption` options `font=small`, `labelfont=bf` |
| wide float wrappers (unused) | RJournal.sty:332-353 | `fig.graphicx`, `tbl.tabular`, `page.adjustwidth`, `cap.caption` | `widefigure`, `widetable`: block width `\textwidth+4cm` shifted by `\leftskip-2cm`, `\captionsetup{margin=2cm}` |
| tables | RJwrapper.tex:5-6 | `tbl.tabular`, `tbl.booktabs` | `array`, `booktabs` loaded; the sample has no table |
| image fit (unused) | RJournal.sty:318-327 | `fig.adjustbox` | pandoc image wrapper; same effect as `max size={\linewidth}{\textheight}` |
| `tikz` load | RJournal.sty:17 | none needed | load-only, nothing drawn (comment at :190 mentions a rounded rectangle, but `\tableofcontents` at :193-197 draws none) |

## Bespoke code
RJournal.sty is the publisher-official kit, so its internals are published code and not bespoke under W1. For a reader who does not accept that, each zip-local macro group is judged below; the wrapper and template define no macros of their own (RJwrapper.tex:8, RJtemplate.tex:1-61).
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\RJ@*` issue and article strings | RJournal.sty:81-84, 96-99, 38, 202 | yes | strings written straight into the `hf.fancyhdr` fields and `\hypersetup` (`hf.class-native`) |
| `article` environment | RJournal.sty:117 | yes | `\FloatBarrier` before and after (`fig.placement`); the title, author and subtitle resets only matter with several articles in one file |
| `\chapter` redefinition and `\RJ@chapter` | RJournal.sty:153-161 | yes | `head.titlesec`: `\titleformat{\chapter}{\normalfont\huge\bfseries\raggedright}{}{0pt}{\phantomsection}` and `\titlespacing*{\chapter}{0mm}{-2\baselineskip plus -\baselineskip minus -.2ex}{1pt}`; `\name@of@eq` only names equation link anchors (comment at :150-151) and prints nothing, so a `\theHequation` setting (`num.counters`) or nothing for a one-article file |
| `\maketitle` | RJournal.sty:130-144 | yes | heading, then `\noindent\textbf{..}` and `\noindent\textit{..}` lines (`mark.kernel`) each followed by `\par\nobreak\addvspace{\baselineskip}` (`sp.manual-space`); the `\ifx\empty` tests are decided by the emitter, which knows if a subtitle or author exists; `\@afterheading` becomes `\noindent` plus a local `\clubpenalty=10000` (`sp.penalties`), an approximation of the kernel hook |
| `\abstract` | RJournal.sty:122-123 | yes | `\noindent\textbf{Abstract}~`; `\abstract` is defined twice, the one-argument command at :122 is then replaced by `\renewenvironment{abstract}` at :123 (a start macro with no argument), so the sample's `\abstract{...}` (RJtemplate.tex:7-9) reads as that macro plus a braced group (read, not run) |
| `\review` | RJournal.sty:166-170 | yes | `meta.hyperref` bookmark, `\section*`, `toc.kernel` `\addtocontents` line |
| `\tableofcontents`, `\titlepage` | RJournal.sty:193-229 | yes | the cover and contents rows of the component map; `\@starttoc{toc}` is the kernel's own contents call |
| inline markup `\code` `\samp` ... | RJournal.sty:233-273 | yes, one residue | `\newcommand` aliases of `\texttt` `\textsl` `\textsf` over `\href`; `\code` also sets `\hyphenchar\font=-1` (`sp.hyphenat`); `\@noligs` (:250, :256) switches off typewriter ligatures such as `--`, has no lib way, and the sample never calls it |
| `\nohyphens` | RJournal.sty:154-155 | yes | `\hyphenpenalty=10000 \exhyphenpenalty=10000` (`sp.penalties`) |
| `example`, `Sinput` family, `Schunk` | RJournal.sty:279-293 | yes | `code.verbatim` (`fancyvrb`, `alltt`); the Sweave names are kept only for R output, no R run is needed by the sample |
| `\P` `\E` `\VAR` `\COV` `\COR` | RJournal.sty:303-313 | yes | `\DeclareMathOperator`-style definitions (`math.amsmath`); `\operatorname` at :303 is only a `\providecommand` fallback, and `amsmath` (RJwrapper.tex:5) is loaded after the style |
| `\pandocbounded` | RJournal.sty:318-327 | yes | `fig.adjustbox` `max size={\linewidth}{\textheight}`; pandoc is an optional upstream producer of `.tex` (comment at :317), not needed by the sample, so not EXTERNAL |
| `widefigure`, `widetable` | RJournal.sty:335-353 | yes | `\begin{figure}` or `\begin{table}` around `adjustwidth{-2cm}{-2cm}` (`page.adjustwidth`) with `\captionsetup{margin=2cm}`; `\NewEnviron` from `environ` is only the environment wrapper |

## Content-opaque
none (the PNG in the sample figure, RJtemplate.tex:22, is figure artwork and is held by `fig.graphicx`; `Rlogo-5.png` is shipped, `RJreferences.bib` is not)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
