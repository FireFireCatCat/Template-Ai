yes

# 0690-termcal-de: termcal-de (German localisation of the termcal term calendar)

- Unverified: read from the source, not compiled.
- Source: Source/0690-termcal-de/ (origin: https://mirrors.ctan.org/macros/latex/contrib/termcal-de.zip; licence: lppl1.3c)
- Kind: calendar (the zip is a calendar add-on package; its only sample is the package manual, which prints two calendar grids)
- Lib: v5
- Engine: needs LuaLaTeX (the manual driver calls `\RequireLuaTeX`, termcal-de-doc.dtx:30, and loads `fontspec` :32, `polyglossia` :33, `selnolig` :35; the package `termcal-de` itself loads only `termcal`, `pgfkeys`, `pgfopts`, `datetime2`, termcal-de.dtx:50-57, :173-180, so it is pdfLaTeX-compatible)
- Look carried by: mixed (manual page and `.dtx` layout by the `ltxdoc` class plus the driver preamble; the calendar grid and its German dates by the published packages `termcal` and `termcal-de`)
- Class origin: tex-distribution-unbundled
- Main file: termcal-de-doc.dtx (no `.tex` file exists; this driver holds `\documentclass` at :27 and `\begin{document}` at :75). Other samples: termcal-de-doc-example1.dtx, termcal-de-doc-example2.dtx (calendar bodies that the driver `\DocInput`s at :314, :414 and `\input`s at :319, :419); package source termcal-de.dtx (docstrip input of `termcal-de.sty`, termcal-de.ins:29-38)
- Read: main yes, zip-local classes and styles all (no `.cls` or `.sty` is shipped; `termcal-de.dtx`, the source of `termcal-de.sty`, was read in full; `ltxdoc`, `termcal`, `datetime2` are published and their sources were not read)

## Verdict
The zip is the CTAN package `termcal-de`, a German add-on that loads `termcal` (termcal-de.dtx:50) and is steered by three key-value option sets (`compat`, `drawdateframe`, `datetime2`; termcal-de.dtx:93-148), so it is one published, declarative, generic, printable way: `cal.termcal` with the add-on package as the parameter. The only sample is the package manual, a published `ltxdoc` document whose preamble, headings, lists, boxes, tables, figures and `.dtx` machinery all land on lib ways. The zip-local macros are two one-line aliases or hook redefinitions in the driver, both reducible; there is no artwork and no tool beyond the standard `makeindex` pass of `idx.makeidx`. The `yes` rests on `termcal-de.sty` being published: its code redefines termcal internals (termcal-de.dtx:202, :217) and would be irreducible if it were zip-local.

## Blockers
none

## Class setting
- Class: `class.ltxdoc` options: `11pt` (termcal-de-doc.dtx:27); `ltxdoc` is LaTeX base and is not in the zip (Class origin above), while the zip's own package `termcal-de` is a CTAN package whose source is termcal-de.dtx
- Class-native vocabulary used: `\DocInput` (termcal-de-doc.dtx:314, :414, :505), `\MakeShortVerb{"}` (:58), `\CheckSum` (:59), `\PageIndex` (:65), `\RecordChanges` (:66), `\DescribeEnv` (:275), `\DescribeMacro` (:295, :299, :304, :341, :353, :382, :396), `\StopEventually` (:490), `\PrintChanges` (:494), `\IndexPrologue` (:496), `\PrintIndex` (:497), `\CodelineNumbered` (:504), `\Finale` (:508), counter `IndexColumns` (:495), index-format hooks `\usage` `\main` (:61-62); in termcal-de.dtx the `macrocode` environment (:39), `macro` environment (:160) and `\changes` (:37, :54, :91, :105, :158).

## Component map
Paths are termcal-de-doc.dtx unless named.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | :27 | `class.ltxdoc` | `11pt` |
| page geometry | :52 | `page.geometry` | left=4.50cm, right=2.75cm, top=3.25cm, bottom=2.75cm, nohead |
| paragraph indent | :45 | `sp.lengths` | `\parindent0pt` |
| list spacing | :155, :332, :444 | `sp.lengths` | `\itemsep 0pt` / `\itemsep0pt` |
| hyphenation exception | :55 | `sp.hyphenat` | `\hyphenation{ori-ginal}` |
| ligature suppression | :35 | `sp.selnolig` | language option `english` |
| text fonts | :32, :48-50 | `font.fontspec` | `no-math`; `\setmainfont{erewhon}`; `\setsansfont[Scale=MatchLowercase]{Source Sans Pro}`; `\setmonofont[Scale=MatchLowercase]{Hack}` (fonts not shipped) |
| math font | :47 | `font.newtx` | `newtxmath` with option `erewhon` (no maths is typeset in the sample) |
| TeX-logo package | :38 | `font.icons` | `hologo` loaded; no `\hologo` call in the file (logos used are the kernel `\LaTeX` and `\LaTeXe`, :102, :120) |
| size commands | :69, :138, :281, :313, :453 | `font.size-commands` | `\large`, `small` environment, `\Large`, `\small` |
| font switches and marks | :83, :85, :281, :313 | `mark.kernel` | `\itshape`, `\textsc{\upshape ..}`, `\bfseries`, `\scshape`, `\ttfamily`, `\texttt`, `\textit`, `\textbf`, `\emph` |
| underline | :202, :216, :228 | `mark.ulem` | kernel `\underline{..}` (`ulem` is not loaded; filed here by effect, an underlined default value) |
| text symbol | :140 | `font.fontenc-t1` | `\textcopyright` |
| colour | :41, :313, :413 | `color.xcolor` | `xcolor`; `\color{green!50!black}` on the listing caption lines |
| language | :33-34 | `lang.polyglossia` | `\setdefaultlanguage{english}` (termcal-de is documented to load after `babel` or `polyglossia`, :189) |
| quotation marks | :37, :84, :149 | `lang.csquotes` | `\enquote`, `\enquote*` |
| hyperref setup | :39, :73 | `meta.hyperref` | options `unicode`, `pdfborder={0 0 0}`, `linktoc=all`, `hyperindex=false`; `\hypersetup{pdftitle=..,pdfauthor=..}` |
| url text | :69, :146 | `meta.url` | `\url{..}` (supplied through hyperref here) |
| links and anchors | :70, :181, :492 | `xref.hyperref` | `\href`, `\phantomsection`; `\hyperpage` in the index hooks (:61-62) |
| labels and references | :175, :184, :322-323 | `xref.kernel` | `\label`, `\ref` |
| title block | :69-71, :76 | `front.maketitle` | `\title{.. \\ {\large\url{..}}}`, `\author{.. \\ \href{..}{..}}`, `\date{2018/03/23 (v2.0)}`, `\maketitle` |
| first page style | :77 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` (no other header or footer is set; `nohead` is in the geometry row) |
| centred quotation block | :83-86 | `sp.ragged` | `center` environment with an italic body and `\enquote` |
| manual spacing | :88, :90, :124, :207, :459, :461 | `sp.manual-space` | `\medskip`, `\smallskip`, `\bigskip`, `\hspace{-1.5em}`, `\\[\smallskipamount]`, `\vspace{-.75ex}`, `\hspace{.45\textwidth}`, `\vspace{-1.5em}` |
| leaders | :202, :228 | `sp.rule` | `\dotfill` between an option name and its values |
| abstract | :89-92 | `abs.kernel` | `abstract` environment, `\hspace{-1.5em}` first |
| contents | :95, :101, :117, :139, :493 | `toc.kernel` | `\tableofcontents`; manual `\addcontentsline{toc}{subsection}` and `{part}` |
| page breaks | :97, :171, :267, :331, :431, :491, :498 | `pg.break` | `\clearpage`; `\nopagebreak[4]` (:331, the same family of kernel break commands) |
| headings | :100, :172-173, :188, :198, :496 | `head.kernel` | `\part`, `\section`, `\subsection`, `\subsection*`, `\subsubsection*`, `\section*` with the class look unchanged; termcal-de.dtx:36, :46, :62, :157, :195 (`\subsubsection*`) |
| lists | :104-114, :119-122, :154-163, :179-185, :208-220 | `list.kernel` | `description`, `enumerate`, `itemize`, `\item[a)]`; termcal-de.dtx:100-104, :118-125 (`\item[\texttt{always}]`) |
| columns | :40, :154-163 | `cols.multicol` | `multicols{2}` around the file list |
| note boxes | :280, :360, :434, :468 | `box.fancybox` | `\framebox{\framebox{..}}`, a double frame |
| box content width | :280, :317 | `box.minipage` | `minipage{.95\textwidth}` |
| tables | :369-373, :454-460 | `tbl.tabular` | `[t]{ccccccc}`, `{cc}`, `\hline` (:455), `\renewcommand{\arraystretch}{1.25}` (:453) |
| table float and caption | :453, :463-464 | `cap.kernel` | `table[ht]`, `\centering`, `\caption`, `\label{dateformatcomp}` |
| figure floats | :316-324, :416-424 | `fig.graphicx` | `figure[h]` with `\centering`; no `\includegraphics`, the body is a calendar grid; `\caption` is `cap.kernel` |
| file inclusion | :319, :419 | `struct.input` | `\input{termcal-de-doc-example1.dtx}`, `\input{termcal-de-doc-example2.dtx}` |
| inline code | :58 | `code.verbatim` | short verb character `"` (declared by `\MakeShortVerb`) used for every `"\cmd"` in the text |
| literate-programming driver | :58-59, :65-66, :275, :314, :414, :490-497, :504-508; termcal-de.dtx:37, :39, :160 | `dtx.doc` | `\DocInput` of the two examples (:314, :414) and of `termcal-de.dtx` (:505), `\CheckSum{132}`, `\PageIndex`, `\RecordChanges`, `\DescribeEnv`, `\DescribeMacro`, `\StopEventually{..}`, `\PrintChanges`, `\CodelineNumbered`, `\Finale`; `macrocode`, `macro`, `\changes` |
| index | :63, :496-497 | `idx.makeidx` | `\index{..}` with the `main` encapsulator, `\IndexPrologue{\section*{Index}}`, `\PrintIndex`; the `makeindex` runs are listed at :126-127 and README.md:25-26 (standard TeX toolchain, as `bibtex` in `bib.bibtex-bst`) |
| index columns | :495 | `num.counters` | `\setcounter{IndexColumns}{2}` |
| calendar environment (body) | termcal-de-doc-example1.dtx:15-23; termcal-de-doc-example2.dtx:15-43 | `cal.termcal` | `calendar{10.12.2012}{3}` with `\calday[heading]{..}`, `\skipday`, `\classday`, `\weeklytext{..}`; example 2 adds `\setlength{\calwidth}{.95\textwidth}` and `\calboxdepth` `1.25cm` (example2:16-17), `\options{date}{..}` with `\noclassday`, `\caltext{date or Cn}{..}`, `\caltexton{2}{..}`, `\caltextnext{..}` (example2:27-42); the manual sets `\calwidth` to `\linewidth` (:318, :418); both lengths are named at :340-342 |
| calendar add-on package | :43; termcal-de.dtx:50-57, :152 | `cal.termcal` | `\usepackage[datetime2={local=german}]{termcal-de}` (loads `termcal`, `pgfkeys`, `pgfopts`; options read by `\ProcessPgfPackageOptions{/termcal-de}`) |
| termcal-de options | termcal-de.dtx:93-114, :127-148 | `cal.termcal` | `compat` (true/false, default false: dates typed `D.M.YYYY` instead of `m/d/y`), `drawdateframe` (always, atNewMonth, never; frame drawn by `\framebox` in `\calprintdate`, :235-240), `datetime2` subkeys `local` `numeric` `frompreamble`; the sample sets only `datetime2={local=german}` |
| German date printing in cells | :43, :80; termcal-de.dtx:173-190, :226-240 | `front.datetime` | `datetime2` loaded with the `german` module through the option (:173-180); numeric style `\DTMsetstyle{german-numeric}` set at begin of document by the package (termcal-de.dtx:189) and once by hand in the driver (:80); cells printed with `\DTMdisplaydate` and `\DTMDisplaydate` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\opt{..}` | termcal-de-doc.dtx:63 | yes | alias of `\texttt{#1}` (`mark.kernel`) plus `\index{#1=\texttt{#1}...}` with the `main` encapsulator (`idx.makeidx`); expand inline at each use (:227, :231, :238, :283) |
| `\usage`, `\main` redefined | termcal-de-doc.dtx:61-62 | yes | the `doc` index-entry format hooks set to hyperref's `\hyperpage{#1}` (`dtx.doc` with `xref.hyperref`); no new typesetting logic |
| `termcal-de.sty` internals: five `\newif`s (termcal-de.dtx:66-70), option sets (:93-148), computed `datetime2` load (:164-190), redefined `\setdate@` (:202), `\curdate` (:217), `\currentdate` (:226), `\calprintdate` (:235) | termcal-de.dtx | not bespoke | published CTAN package (the manifest origin is mirrors.ctan.org); the emitter writes `\usepackage[opts]{termcal-de}` and copies none of this code. Were the file zip-local, redefining termcal's internals would be irreducible |
| `termcal-de.ins` docstrip driver | termcal-de.ins:29-38 | not bespoke | install-time extraction of the package file by a TeX run; not part of any document |

## Content-opaque
none (the example calendars are `cal.termcal` output, not artwork; cell texts, the Bernstein quotation and the table words are content; the shipped termcal-de-doc.pdf is a build product and was not read)

## Lib changes
- New ways proposed: none. `cal.termcal` already serves it: `termcal-de` loads `termcal` and adds localised date input and printing through options, so the add-on package is the parameter, as the `cal.termcal` line already allows for a sibling calendar package. The consolidator may widen that line with the add-on and its option keys `compat`, `drawdateframe`, `datetime2={local,numeric,frompreamble}`. Considered: `iftex` `\RequireLuaTeX` (:29-30) as a way (a load-only engine guard with no printed effect, as the rejected `sys.compat-load`; recorded under Engine instead).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
