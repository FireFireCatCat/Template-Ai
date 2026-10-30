yes

# 0300-labbook: labbook (laboratory journal class, Frank Kuester)

- Unverified: read from the source, not compiled.
- Source: Source/0300-labbook/ (origin: https://mirrors.ctan.org/macros/latex/contrib/labbook.zip; licence: LPPL, as the manifest says; the .dtx header names LPPL 1.0, labbook.dtx:7-9)
- Kind: misc
- Lib: v4
- Engine: pdfLaTeX-compatible (labbook.dtx:1633-1634 says pdflatex is fine; the German sample loads latin1 inputenc, labbook.dtx:1767)
- Look carried by: class (the published class `labbook` on `scrbook` defines the look; the sample sets only class options, hyperref options, `\newexperiment` strings and content)
- Class origin: ctan
- Main file: labbook.dtx:1632-1751 (the `examplen` docstrip module, written to examplen.tex by labbook.ins:64; no .tex file is present) (other samples: labbook.dtx:1752-1874 `examplde`, German; labbook.dtx:1875-1905 `boilerplates`; labbook.dtx:1908-2162 `labboode`, German manual; labbook.dtx:49-90 driver of the English manual)
- Read: main yes, zip-local classes and styles all (no .cls or .sty file is present; the class code was read in full from labbook.dtx:334-1628). Not read: labbook.pdf and labboode.pdf (compiled output of the .dtx); labbook.el read (AUCTeX style, editor support only).

## Verdict
yes: the look is carried by the published class `labbook` (CTAN and TeX Live, LPPL, built on `scrbook`; ctan.org/pkg/labbook read), and the sample adds only class options, `hyperref` options, `\newexperiment` strings and content, so every component has a lib way and there is no ART. The zip is the class's own docstrip source (labbook.dtx, labbook.ins) with no .cls or .tex file, so the main sample is the `examplen` module and the class code was read from the .dtx. The verdict rests on W1 for the class: its code (comma-list parser, abbreviation tables, an `\addcontentsline` redefinition that writes index ranges, labbook.dtx:495-1627) would be `BESPOKE/class` if the class were zip-local. The index is filled only after a `makeindex` run (README:22, labbook.dtx:1633-1638), the same toolchain family as BibTeX and an existing lib way (`idx.makeidx`), so it is recorded and not counted as EXTERNAL; compatibility with current KOMA-Script (the class copies `\sectfont` and `\size@section`) was not checked.

## Blockers
none

## Class setting
- Class: `class.labbook` options: `idxtotoc` (a KOMA option, passed on by `\DeclareOption*`, labbook.dtx:363; used at labbook.dtx:1640), `hyperref` (the class's own switch, labbook.dtx:356-357, required before loading hyperref, labbook.dtx:185-193, mismatch errors at labbook.dtx:1608-1626); `openany` is documented and not used (labbook.dtx:196-197). Everything else goes to `scrbook` (labbook.dtx:363-365). The class loads `makeidx` and runs `\makeindex` (labbook.dtx:374).
- Class-native vocabulary used: `\labday{}` (labbook.dtx:1358-1364, sample 1690), `\experiment[short]{long}` (labbook.dtx:970-1201, sample 1693), `\subexperiment[short]{long}` (labbook.dtx:1227-1334, sample 1694), `\newexperiment{key}[short]{long}` and `\newsubexperiment` (labbook.dtx:394-466, sample 1663-1674), a comma list in the optional argument (labbook.dtx:1743), `\frontmatter` `\mainmatter` (scrbook, sample 1679 and 1687), `\printindex` (makeidx, sample 1684). Documented and not used by the sample: `\appendix`, `\backmatter` (wrapped at labbook.dtx:1539-1561), `\minisec` (labbook.dtx:164).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | labbook.dtx:1640, 47-48, 365 | `class.labbook` | options idxtotoc, hyperref; `\LoadClass{scrbook}`; v1.1 2003/05/20 |
| page geometry | labbook.dtx:365 (nothing set in the sample) | `page.typearea` | no parameters; scrbook defaults are inherited, scrbook source not read |
| running heads | labbook.dtx:208, 222-223, 944-945 | `hf.class-native` | `\labday` text becomes the running title through `\addchap`; `\experimentmark` and `\subexperimentmark` are `\let` to `\@gobble`; the manual says experiment text is in the page head, the code sets the marks empty, not resolved by reading |
| page numbers | labbook.dtx:113, 1679, 1687 | `pgnum.pagenumbering` | roman after `\frontmatter`, arabic after `\mainmatter` (scrbook); the sample calls no `\pagenumbering` |
| matter switches | labbook.dtx:1679, 1687 | `front.class-native` | `\frontmatter`, `\mainmatter` |
| title block | labbook.dtx:1680-1682 | `front.maketitle` | `\title{Laboratory Journal from 2003-04-22 to \dots}`, `\author{Jane Eager}`, `\maketitle`; no `\date` |
| day heading | labbook.dtx:1358-1364, 1690 | `head.class-native` | `\labday{text}` = `\refstepcounter{labday}` + `\addchap`: unnumbered chapter look, no star, no optional argument |
| experiment heading | labbook.dtx:970-1001, 1039-1043, 1693 | `head.class-native` | `\@startsection{experiment}{1}{\z@}{-3.5ex plus -1ex minus -.2ex}{2.3ex plus .2ex}{\raggedsection\normalfont\sectfont\nobreak\size@section\nobreak}`, a copy of the scrbook section call; optional argument `[short]` or a list |
| subexperiment heading | labbook.dtx:1227-1256, 1694 | `head.class-native` | level 2, same spacing, section font and `\size@section` (labbook.dtx:1243-1247) |
| abbreviation declarations | labbook.dtx:394-466, 1663-1674 | `head.class-native` | `\newexperiment{key}[short]{long}`, `\newsubexperiment`: strings in the preamble, duplicate key is an error |
| multi-entry index list | labbook.dtx:629-720, 1743 | `head.class-native` | `[toc text, key1, key2]`: first item for toc and running title, the rest become index entries |
| lower levels | labbook.dtx:943, 1394-1399 | `head.kernel` | `\subsubsection` wrapped so it writes no index entries; counter reset under subexperiment |
| heading numbers | labbook.dtx:933-935, 1409-1424 | `num.counters` | counters `labday`, `experiment`[labday], `subexperiment`[experiment]; `\theexperiment` = arabic, `\thesubexperiment` = experiment.subexperiment; lower levels rebuilt on them |
| float and footnote numbers | labbook.dtx:936, 1429-1434, 1547, 1558 | `num.counters` | figure and table reset per labday and print plain arabic; footnote reset per labday and at `\appendix` or `\backmatter` |
| toc depth | labbook.dtx:955 | `num.secnumdepth` | `tocdepth` = 3 |
| contents | labbook.dtx:1685, 1443-1445 | `toc.kernel` | `\tableofcontents`; `\l@labday`=`\l@chapter`, `\l@experiment`=`\l@section`, `\l@subexperiment`=`\l@subsection` |
| index in contents | labbook.dtx:1640-1643, 191-193 | `toc.koma` | option `idxtotoc` |
| index | labbook.dtx:374, 808, 821-822, 1684 | `idx.makeidx` | `\RequirePackage{makeidx}\makeindex`; `\printindex`; range entries `\index{text|(}` and `\index{text|)}`, subentries `experiment!subexperiment`; a `makeindex` pass is needed (README:22) |
| appendix and backmatter | labbook.dtx:1539-1561 | `num.appendix` | class wraps `\appendix` and `\backmatter` to close the last index range; not used by the sample |
| file inclusion | labbook.dtx:1656 | `struct.input` | `\input{boilerplates}` (the file only defines content macros) |
| hyperlinks | labbook.dtx:1647-1653 | `meta.hyperref` | backref=page, pdfpagelabels=true, plainpages=false, colorlinks=true, bookmarks=true, pdfview=FitB |
| hyperref glue | labbook.dtx:1587-1607 | `meta.hyperref` | class sets `\toclevel@labday`=0, experiment 1, subexperiment 2 and `\theH...` anchors; pairs with the class option `hyperref` |
| figure | labbook.dtx:1700-1705 | `fig.graphicx` | kernel `figure[htbp]` only; graphicx is not loaded in this sample |
| alignment | labbook.dtx:1701 | `sp.ragged` | `\centering` |
| caption and label | labbook.dtx:1703-1704 | `cap.kernel`, `xref.kernel` | `\caption{...}`, `\label{fig:digest-sds}` |
| emphasis | labbook.dtx:1707 | `mark.kernel` | `\textit{E. coli}` |
| language, encoding (German sample) | labbook.dtx:1766-1768 | `lang.babel`, `font.fontenc-t1` | `[T1]{fontenc}`, `[latin1]{inputenc}`, `[english,german]{babel}` |
| manual: class | labbook.dtx:50, 1909 | `class.article` | `a4paper` in the German manual (labbook.dtx:1909) |
| manual: doc driver | labbook.dtx:51, 53, 55-85, 88, 99-100, 326 | `dtx.doc` | `\EnableCrossrefs`, `\DoNotIndex`, `\CodelineIndex`, `\DocInput`, `\MakeShortVerb`, `\StopEventually{\PrintIndex\PrintChanges}` |
| manual: symbols | labbook.dtx:52 | `font.icons` | `marvosym` |
| manual: title, abstract | labbook.dtx:102-105, 108-119 | `front.maketitle`, `abs.kernel` | `\date{\filedate}` |
| manual: page style, flow | labbook.dtx:107, 121, 124 | `hf.pagestyle-kernel`, `pg.enlarge`, `pg.break` | `\thispagestyle{empty}`, `\enlargethispage{-5\baselineskip}`, `\clearpage` |
| manual: contents, sections, lists, notes | labbook.dtx:122, 125-130, 150-176, 187, 230, 134 | `toc.kernel`, `head.kernel`, `list.kernel`, `code.verbatim`, `fn.kernel`, `mark.kernel` | `\part` `\section` `\subsection`, `description`, `verbatim`, `\footnote`, `\emph` |
| manual: German | labbook.dtx:1911-1913 | `lang.babel`, `font.fontenc-t1` | `ngerman`, `[T1]{fontenc}`, `[latin1]{inputenc}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\sometext` `\Xsometext` `\othertext` `\Xothertext` | labbook.dtx:1878-1886 (body, boilerplates.tex) | yes | aliases of repeated filler sentences; inline expansion; content |
| `\sdsband` `\sdsbandh` `\sdsbandl` | labbook.dtx:1888-1890 (body) | yes | `sp.rule`: `\rule{1cm}{0.15cm}`, `\rule[0.2cm]{1cm}{0.15cm}`, `\rule[-0.15cm]{1cm}{0.15cm}` |
| `\sdsgel` | labbook.dtx:1891-1904 (body) | yes | `tbl.tabular` `{cccccccc}` of five rows of rule cells, rows separated by `\\[0.5cm]` (`sp.manual-space`); figure artwork, so content |
| labbook.cls internals: `\ifwe@use@hyperref`, `\fk@getcommasep@list`, abbreviation tables `long@exp@*`, `\define@addcontentsline`, `\fk@close@labindex` | labbook.dtx:356-1627 (class) | not counted | published class (CTAN, TeX Live), one way `class.labbook`; would be irreducible `BESPOKE/class` if the class were zip-local |

## Content-opaque
- The "SDS gel" in the figure is a grid of rule cells (labbook.dtx:1700-1705, 1891-1904); it is figure artwork and also reduces to `tbl.tabular` + `sp.rule`. No TikZ, PGF or picture code anywhere in the zip.
- Filler text `\Xsometext` and `\Xothertext` (labbook.dtx:1878-1886), and the lab-protocol sentences of the sample (labbook.dtx:1731-1738).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
