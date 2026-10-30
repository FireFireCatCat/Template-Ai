yes

# 0390-titling: the `titling` package (source and manual, `.dtx`)

- Unverified: read from the source, not compiled.
- Source: Source/0390-titling/ (origin: https://mirrors.ctan.org/macros/latex/contrib/titling.zip; licence: lppl1.3c)
- Kind: misc (a package distribution: `.dtx` source plus its own manual; no document template)
- Lib: v4
- Engine: pdfLaTeX-compatible (`ltxdoc` and `doc` run under pdfLaTeX; the README names plain `latex` and a DVI hardcopy only as the build route, README:75-78)
- Look carried by: class (the manual's page, headings and macro displays come from `ltxdoc` + `doc`; the zip adds `\DocInput`, three driver settings and six font aliases, titling.dtx:19-25, 100-105)
- Class origin: tex-distribution-unbundled (`ltxdoc` is LaTeX base, not in the zip; its source was not read). The zip's own package, `titling`, is published on CTAN (origin above), so it is the lib's `front.titling`, not a zip-local style.
- Main file: titling.dtx (other samples: none; the only other files are README, titling.ins, titling.pdf)
- Read: main yes (titling.dtx 1-1475 in full), zip-local classes and styles none present (no `.cls` or `.sty` ships; the package code inside titling.dtx:803-1328 was read in full, as were titling.ins and README; titling.pdf, a derived binary manual, was not opened)

## Verdict
The sample is the `.dtx` driver (titling.dtx:18-27): `\documentclass{ltxdoc}` plus `\DocInput{titling.dtx}`. Everything it prints is built from lib ways (`class.ltxdoc`, `dtx.doc`, kernel front matter, headings, lists, verbatim, math, hand-written bibliography), and its only zip-local macros are font aliases and string `\def`s that reduce by inline expansion. The package code that the `.dtx` carries (titling.dtx:803-1328) is the published CTAN package `titling` itself, which the lib already holds as `front.titling`; it is the way, so it is not counted as bespoke. Ruling flagged for the reviewer: had this code been a zip-local style, its redefinition of `\maketitle` and `\@makefntext` (titling.dtx:1089-1161) would be `BESPOKE/package`, and the verdict would be `no`.

## Blockers
none

## Class setting
- Class: `class.ltxdoc` options: none (`\documentclass{ltxdoc}`, titling.dtx:19)
- Class-native vocabulary used: `\EnableCrossrefs` (20), `\CodelineIndex` (21), counter `StandardModuleDepth` (23), `\DocInput` (25), `\CheckSum` (31), `\DoNotIndex` (33-72), `\changes` (74-81 and in the code part), `\DescribeMacro` (171-176), `\DescribeEnv` (322), `macro` and `environment` environments (813-824, 1168-1191), `macrocode` (802-1328), `\meta` (178), `\cs` (882), `\StopEventually` (766), `\Finale` (1454), `\PrintIndex` (1455), the `|...|` short verbatim (120-123), the `^^A` comment character (84-91, 337-346), DocStrip guards `%<*driver>` (18) and `%<*usc>` (803). `\OnlyDescription` is commented out (22), so the code part is typeset.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | titling.dtx:19 | `class.ltxdoc` | no options |
| manual driver switches | titling.dtx:20-21, 25 | `dtx.doc` | `\EnableCrossrefs`, `\CodelineIndex`, `\DocInput{titling.dtx}` |
| doc counter | titling.dtx:23 | `dtx.doc`, `num.counters` | `\setcounter{StandardModuleDepth}{1}` |
| checksum, index exclusions, change log | titling.dtx:31, 33-72, 74-81 | `dtx.doc` | `\CheckSum{490}`; `\DoNotIndex` lists; `\changes{version}{date}{text}` (recorded; `\PrintChanges` is not called) |
| title block | titling.dtx:107-117 | `front.maketitle` | `\title{...}`, three-line `\author{...\\...}`, `\date{\filedate}`, `\maketitle`; the driver does not load `titling` |
| title footnote | titling.dtx:107-109 | `front.thanks` | one `\thanks` holding file name, version and date |
| abstract | titling.dtx:118-124 | `abs.kernel` | plain `abstract` environment |
| contents | titling.dtx:125 | `toc.kernel` | `\tableofcontents` |
| headings | titling.dtx:129, 144, 165, 167, 495, 792, 798 | `head.kernel` | `\section`, `\subsection`, `\subsubsection`, class-default look and numbering |
| appendix | titling.dtx:1331-1332 | `num.appendix` | `\appendix` then `\section{Original code for making a title}` |
| macro and environment descriptions | titling.dtx:171-176, 322, 813-824, 1168-1191 | `dtx.doc` | `\DescribeMacro`, `\DescribeEnv`, `macro`, `environment` |
| printed package code | titling.dtx:802-1328 | `dtx.doc` | `macrocode` blocks; the code text is content here |
| final matter | titling.dtx:766, 1454-1455 | `dtx.doc` | `\StopEventually{...}`, `\Finale`, `\PrintIndex` (the index needs the `makeindex -s gind.ist titling` pass, README:76, a standard pass like BibTeX) |
| verbatim examples (a selection) | titling.dtx:189-198, 203-208, 221-244, 255-265, 283-293, 582-586, 708-714, 735-741, 1336-1449 | `code.verbatim` | `verbatim` environment and `\|...\|` short verbatim (120-123) |
| smaller type for examples | titling.dtx:189-199, 735-741, 745-759, 1336-1353 | `font.size-commands` | `small` environment |
| name aliases | titling.dtx:100-105 | `mark.kernel`, `font.size-commands` | `\Lpack`, `\Lopt` = `\textsf`; `\file`, `\Lenv` = `\texttt`; `\Lcount` = `\textsl{\small #1}`; `\pstyle` = `\textsl` |
| emphasis | titling.dtx:137, 209 | `mark.kernel` | `\textsc{docstrip}`, `\textbf{NOTE:}` |
| lists | titling.dtx:614-643 | `list.kernel` | `itemize`, two levels |
| quotation | titling.dtx:215-250 | `quote.kernel` | `quotation` environment |
| footnote | titling.dtx:368-369 | `fn.kernel` | one `\footnote` |
| display and inline maths | titling.dtx:375-388 | `math.kernel` | `\[ ... \]`, `\( ... \)`, `$...$` |
| manual line breaks | titling.dtx:111-115, 183, 274, 511-516 | `sp.manual-space` | `\\` |
| cross-references | titling.dtx:140-144, 792, 810 | `xref.kernel` | `\label`, `\ref` |
| citations and bibliography | titling.dtx:138, 728, 761, 768-787 | `bib.thebibliography` | hand-written `thebibliography{GMS94}` with three `\bibitem[label]{key}`; `\bibliographystyle{alpha}` (767) has no `\bibliography`, so no BibTeX data |
| package: title block | titling.dtx:830-835, 854-872, 884-887, 1075-1076, 1089-1161 | `front.titling` | `\pretitle \posttitle \preauthor \postauthor \predate \postdate` (defaults copy article: `\begin{center}\LARGE`, `\vskip 0.5em`, `\large \lineskip .5em`, tabular `[t]{c}`); hooks `\maketitlehooka`..`d`; length `\droptitle`=0pt |
| package: thanks controls | titling.dtx:902-1065 | `front.titling` | `\thanksmarkseries{fnsymbol or arabic}`, `\symbolthanksmark`, `\continuousmarks`, `\thanksheadextra{}{}`, `\thanksfootextra{}{}`, `\thanksmark{n}`, `\thanksgap{len}`, lengths `\thanksmarkwidth`=1.8em, `\thanksmargin`=-\thanksmarkwidth, `\thanksscript`, `\makethanksmarkhook`, `\usethanksrule`/`\cancelthanksrule` |
| package: titling page | titling.dtx:1174-1188 | `front.titling` | `titlingpage` environment (empty page style, single column, page reset) |
| package: centring | titling.dtx:1200-1207 | `front.titling` | `\calccentering{length}{margin}` |
| package: kept values | titling.dtx:1216-1319 | `front.titling` | `\emptythanks`, `\keepthetitle`, `\killtitle`, `\thetitle` `\theauthor` `\thedate` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\Lpack \Lopt \file \Lcount \pstyle \Lenv` | titling.dtx:100-105 | yes | `\newcommand*` aliases of `\textsf`, `\texttt`, `\textsl`, `\small`: inline expansion (`mark.kernel`, `font.size-commands`) |
| `\dtxfile \fileversion \filedate` | titling.dtx:83, 92-99 | yes | string `\def`s used only as text in the title footnote (107-109) and date (116); the last pair wins, v2.1d and 2009/09/04; inline expansion |
| the `titling` package code (guard `usc`) | titling.dtx:803-1328 | not applicable: published | the published CTAN package `titling` (origin URL; README:40-41 names author and maintainer, README:44-50 the LPPL terms), the lib's `front.titling`; the emitter writes `\usepackage{titling}` and the commands in the package rows above; its kernel-internal redefinitions (`\@maketitle` 1148-1161, `\@makefntext` 1098, 1122) belong to the package, not to the template |
| `titling.ins` DocStrip batch | titling.ins:22-23, 52 | yes | `\input docstrip.tex` and `\generate{\file{titling.sty}{\from{titling.dtx}{usc}}}` only generate the published `titling.sty`; no printed effect, so not a component (as the rejected `sys.compat-load` in the lib change log); the emitter takes `titling.sty` from the TeX distribution |
| DocStrip guards `%<*driver>`, `%<*usc>` | titling.dtx:18, 27, 803, 1328 | yes | `dtx.doc`; guards are comment lines for DocStrip, and inside `macrocode` they print as text |

## Content-opaque
none (the TeX examples in `verbatim` and the `macrocode` blocks are code text, held by `code.verbatim` and `dtx.doc`; the zip has no figures, tables or pictures; the examples name `chngpage` (400-403), `@twocolumnfalse` (748-755) and `patchcmd` (727) only as printed text)

## Lib changes
- New ways proposed: none (considered: `docstrip` for `titling.ins`, not proposed because it has no printed effect)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
