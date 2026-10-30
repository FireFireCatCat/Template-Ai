yes

# 0787-limap: limap (Information Mapping class and package)

- Unverified: read from the source, not compiled.
- Source: Source/0787-limap/ (origin: https://mirrors.ctan.org/macros/latex/contrib/gene/limap.zip; licence: LPPL 1.3c for sources, CC BY-SA 4.0 for the manual, CC0 for samples, README.md:67-76)
- Kind: report
- Lib: v6
- Engine: pdfLaTeX-compatible (the class loads only kernel, longtable, etoolbox, booktabs, fancyhdr, limap.dtx:1563-1582; the four samples load no engine-specific package; the Makefile builds with LuaLaTeX by choice, Makefile:56; the manual's own driver loads fontspec, limap.dtx:1243, and is not scored, see Bespoke code)
- Look carried by: class (the whole look is defined by the CTAN class `limap`; the sample adds only content and class options)
- Class origin: ctan (ctan.org/pkg/limap read: CTAN package, v2.3, Gerd Neugebauer, LPPL 1.3c, in TeX Live and MiKTeX, engine not stated; `limap.cls` and `limap.sty` are not in the zip, they are generated from `limap.dtx` by `limap.ins:21-23`)
- Main file: samples/sample.ltx (other samples: samples/boxed-toc.ltx, samples/hyper.ltx, samples/nolines.ltx)
- Read: main yes, zip-local classes and styles all (no `.cls` or `.sty` file in the zip; the whole of `limap.dtx`, documentation and code, was read; the three other samples were read by grep and the first 30 lines of hyper.ltx)

## Verdict
yes. The look is carried entirely by the published CTAN class `limap` (W1: CTAN and TeX Live, the zip is the CTAN bundle). The sample uses the class-native vocabulary (`Map`, `\Block`, `\MapTableOfContents`, class-set `\maketitle`) plus kernel `tabular` with `booktabs` rules, and it defines no macro of its own. No artwork in any sample, no external tool, no new way needed. This is evidence about the class dimension, not about component ways. Sensitivity: the class internals (aux-file map tree, recursive contents loop, `longtable` page mechanics) would be irreducible BESPOKE/class if the class were zip-local; it is not, so they are not re-emitted.

## Blockers
none

## Class setting
- Class: `class.limap` options: `11pt,a4paper,german` (samples/sample.ltx:3). Class options of limap: language `german` `english` `french` `austrian` `USenglish` (limap.dtx:1440-1444, default english 1434), type `book` `report` `article` `letter` (1487-1490, default report 1481), variant `base` `koma` (1507-1508, default base 1501), `nolines` (1463), `nonstrict` (1458); every other option goes to the base class (1529-1531), which is loaded by `\LoadClass` (1549-1550) as report here.
- Class-native vocabulary used: `\begin{Map}{title}` ... `\end{Map}` nested two deep (samples/sample.ltx:11,24,64,66,85,86), `\Block{label}` (sample.ltx:13,26,35,46,57,68,74,80), `\MapTableOfContents` (sample.ltx:22), `\maketitle` as redefined by the class (sample.ltx:8; limap.dtx:2328). Used in the other samples: `\renewcommand\MapTableOfContentsStyle{boxed}` (samples/boxed-toc.ltx:4), class option `nolines` (samples/nolines.ltx:3). Defined, not used by the main sample: `Abstract`/`abstract` (limap.dtx:2308-2319), `\WideBlock` (2132), `MapTabular` (2264-2270), parameters `\MapRuleWidth` `\MapRuleStart` `\MapFont` `\MapTitleFont` `\MapBlockLabelFont` `\MapParskip` `\MapTitleFraction` `\MapTextFraction` `\MapTabularFraction` `\MapNewpage` `\MapTOCheadfont` (1615-1804, 2255).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | samples/sample.ltx:3; limap.dtx:1351,1549 | `class.limap` | options 11pt, a4paper, german; base class report (default type and variant) |
| paper and size | samples/sample.ltx:3; limap.dtx:1529-1531 | `page.class-options` | a4paper, 11pt passed to report; no `geometry`, text block is the base class's |
| language strings | samples/sample.ltx:3; limap.dtx:1401-1403,1441,2347 | `class.limap` | option german sets `\MapContinued`=" Fortsetzung", `\MapContinuing`="Fortsetzung\dots", `\MapTOCname`="Titel", `\MapTOCpage`="Seite"; no hyphenation patterns loaded (limap.dtx:447-455) |
| header and footer | limap.dtx:1582-1588 | `hf.class-native`, `hf.fancyhdr` | fancyhdr loaded unconditionally; `\headheight`+2ex; `\pagestyle{fancy}`; `\cfoot{}`; `\rhead{\small\thepage}`; `\lhead{\textit{\footnotesize\@title}}`; title page `\thispagestyle{empty}` (2282) |
| title block | samples/sample.ltx:6-8; limap.dtx:2282-2300,2328 | `front.maketitle`, `front.class-native` | `\author`, `\title`, `\maketitle` from kernel; class `\MakeTitle`: gap .25\textheight, minipage `\MapTextFraction`\textwidth pushed right, two 2pt rules round `\sf\huge` title, author `\MapFont\large`, date `\MapFont\footnotesize`, gaps 2.5\MapParskip |
| abstract (not in sample) | limap.dtx:2308-2319,2329-2330 | `abs.class-native` | `Abstract` env: `\vfill`, right-hand minipage `\MapTextFraction`\textwidth, 1pt rules above and below, `\parskip`=1ex |
| Map (titled unit, nests) | samples/sample.ltx:11,24,66; limap.dtx:1868-1935,1981-2013 | `head.class-native`, `tbl.longtable` | `Map{title}`: `longtable` of two `p` columns (`\MapTitleFraction`=.2, `\MapTextFraction`=.75 of \textwidth); title `\MapFont{\MapTitleFont ...}` (`\textsf`, `\Large`); repeated on later pages with `\MapContinuedFormat{\MapContinued}` (`\small`); foot rule and `\MapContinuingFormat{\MapContinuing}` (`\textit{\footnotesize}`); `\MapNewpage`=`\newpage` after each map (1747); at most 12 levels (doc 836-839, 1956-1968) |
| Block (labelled unit) | samples/sample.ltx:13,26,35,46,57,68,74,80; limap.dtx:2094-2112 | `head.class-native` | `\Block{label}`: label in left column in `\MapFont{\MapBlockLabelFont{#1}}` (empty font hook), rule above, `\parskip`=`\MapParskip`=2ex, `\raggedright`, `\MapBlockStartHook` if defined; warns above 7 blocks per map (2031-2038); outside a Map it only warns (2121) |
| strict sectioning | limap.dtx:2351-2366 | `head.class-native` | `\chapter`, `\subsection` ... redefined to warnings unless option nonstrict; `\section` left alone (2354 commented) |
| block rules | limap.dtx:1615,2002,2102,1463 | `sp.rule` | `\rule{\MapTextFraction\textwidth}{\MapRuleWidth}`, `\MapRuleWidth`=.25pt; option nolines makes 0pt (samples/nolines.ltx:3); `\MapRuleStart` colour hook |
| contents of a map | samples/sample.ltx:22; limap.dtx:2153-2164,2207-2211,2225-2242 | `front.class-native`, `tbl.tabular`, `tbl.booktabs` | `\MapTableOfContents`: centred `tabular{p{.6\textwidth}r}`, `\toprule` `\midrule` `\bottomrule`, head cells in `\MapTOCheadfont` (`\scriptsize\emph`), one row per direct child map by `\ref` and `\pageref`; style open (default 2196) or boxed (`tabular{\|p{.6\textwidth}\|r\|}` with `\hline`, 2176-2187; samples/boxed-toc.ltx:4) |
| contents entries | limap.dtx:1757-1760,1770-1774 | `toc.kernel` | `\MapTOC` writes `\addcontentsline{toc}{chapter,section,...}{title}` by nesting level (1956-1968); the sample has no `\tableofcontents`, so nothing prints from it (manual: limap.dtx:217) |
| cross-references | limap.dtx:2010-2011,2232; doc 849-868 | `xref.kernel` | `\label{Map@n}` per map with `\@currentlabel`=title; user `\label` after `\begin{Map}`; `\ref`, `\pageref` |
| table in a block | samples/sample.ltx:58-63; limap.dtx:1575,2255,2264-2270 | `tbl.tabular`, `tbl.booktabs` | `tabular{lll}` with `\toprule` `\midrule` `\hline` `\bottomrule`; booktabs loaded by the class; `MapTabular` = `tabular*` of `\MapTabularFraction`=.95 `\linewidth` in `center` (unused) |
| wide block (not in sample) | limap.dtx:2132 | `head.class-native` | `\WideBlock{material}` spans both columns, `\multicolumn2{@{}l@{}}` |
| fonts and sizes | limap.dtx:1674,1683,1693,1804,2289 | `mark.kernel`, `font.size-commands` | `\textsf`, `\textit`, `\emph`, `\sf`; `\Large`, `\huge`, `\large`, `\small`, `\footnotesize`, `\scriptsize`; no font package, default Computer Modern |
| spacing and flow | limap.dtx:1596,2095-2098,2025 | `pg.flush`, `sp.manual-space`, `sp.lengths`, `sp.ragged` | `\raggedbottom`; `\vspace*{-\parskip}` `\vspace*{-1ex}` `\vspace*{1.5ex}`; `\parskip=\MapParskip`; `\raggedright` |
| page break | samples/sample.ltx:9 | `pg.break` | `\newpage` after the title |
| colour (hyper sample) | samples/hyper.ltx:6 | `color.xcolor` | option svgnames, colour Navy |
| links (hyper sample) | samples/hyper.ltx:5,7-11 | `meta.hyperref` | `colorlinks`, `citecolor` `filecolor` `linkcolor` `urlcolor`=Navy |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `limap.cls`, `limap.sty` (generated from the dtx) | limap.ins:21-23; limap.dtx:1341-2366 | not bespoke: published | CTAN and TeX Live class, W1 holds; the emitter writes `\documentclass[...]{limap}` and the `Map`/`\Block` wrappers; its internals (aux-written map tree 1894-1918, `longtable` page mechanics 1989-2009, recursive child loop 2225-2242) stay in the class |
| sample macros | samples/*.ltx | yes | none defined; the only `\renewcommand` is the class parameter `\MapTableOfContentsStyle` (samples/boxed-toc.ltx:4) |
| manual driver (`%<*driver>`) | limap.dtx:1211-1311 | not scored | documentation build under `class.ltxdoc`, not exported by docstrip (limap.dtx:1208); it patches doc.sty (`\DescribeMacro`, `\DescribeEnv`, 1281-1286; `\let\marginpar\Block`, 1293) and loads fontspec (1243). If it were scored as a sample it would be BESPOKE/preamble and XeLaTeX/LuaLaTeX |
| `limap.cfg` hook | limap.dtx:2340 | n/a | optional local file, not shipped in the zip |

## Content-opaque
none in the samples (Lorem text and tabular cell contents are content). Manual only, not scored: TikZ mindmap and class diagrams at limap.dtx:243-260,266-283,309-340,748-756 and a `picture` diagram built with `\picMap` macros at limap.dtx:769-818, all illustrations inside blocks.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
