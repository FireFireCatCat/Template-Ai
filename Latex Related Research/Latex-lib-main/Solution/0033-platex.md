no

# 0033-platex: pLaTeX2e community edition (bundle with the `plnews` newsletter class)

- Unverified: read from the source, not compiled.
- Source: Source/0033-platex/ (origin: https://mirrors.ctan.org/macros/jptex/latex/platex.zip; licence: bsd3, 3-clause BSD, LICENSE:1-28)
- Kind: newsletter (the manifest hint says presentation, which is wrong; the zip is the pLaTeX format and class source bundle, and its only template is `plnews`, a two-column Japanese news sheet)
- Lib: v1
- Engine: needs pTeX (pLaTeX2e format run by platex on pTeX or e-pTeX; DVI output, PDF only through dvipdfmx, README.md:3-6 and README.md:49-50; `\NeedsTeXFormat{pLaTeX2e}` at plnews.cls:1). Not pdfLaTeX, not XeLaTeX, not LuaLaTeX. The lib has no engine tag for this; it is written `ptex` below.
- Look carried by: mixed (plnews.cls over jarticle sets page, footer, title block and itemize; the sample's own preamble overrides `\section` and `\maketitle`; the sample body redefines a tabular internal)
- Class origin: ctan (plnews.cls ships in the CTAN `platex` bundle this zip is, and the bundle's own `make install` copies every .cls to tex/platex/base, Makefile:179-182; not checked against a TeX Live tree)
- Main file: plnewsc07.tex (other samples: plnews01.tex to plnews08.tex, plnewsc01.tex to plnewsc16.tex, same class, grepped only)
- Read: main yes, zip-local classes and styles partly (plnews.cls and exppl2e.sty read in full; jclasses.dtx, the source of the base class jarticle, read in part; the other .dtx format sources and the PDFs not read)

## Verdict
No. The sample body redefines the internal tabular preamble builder `\@tabclassz` twice, with the pTeX primitive `\inhibitglue`, which no lib way can express (BESPOKE/body). It also loads `pxftnright`, a package that is not in the zip and that two CTAN reads did not identify, so no way can be justified for it (UNMAPPED/preamble). Everything else in the sample (class, page, footer, title block, headings, lists, tables, verbatim, footnotes) maps to lib ways or reduces to them, with two proposed new ways; and the class is published (it ships in the CTAN bundle), so its own macros are not counted against the zip. The pTeX-only engine is recorded, not counted as a blocker.

## Blockers
- `BESPOKE/body` two `\def\@tabclassz` redefinitions (`\ifcase\@lastchclass`, `\edef\@preamble`, `\inhibitglue`) rewrite the kernel tabular column-preamble builder; irreducible (plnewsc07.tex:66-88 and plnewsc07.tex:109-131)
- `UNMAPPED/preamble` `\usepackage{pxftnright}` wrapped in a `\let\origfootnoterule` save and restore; the package is not in the zip, CTAN `pxftnright` returned 404 and the `pxbase` page does not name it, so its identity and effect are not established (plnewsc07.tex:18-20). Weaker than the first blocker; the verdict does not depend on it.

## Class setting
- Class: `class.plnews` options: none given by the sample (plnewsc07.tex:2). The class fixes its base: `\LoadClass[a4j,twocolumn,oneside]{jarticle}` (plnews.cls:10), so `class.jarticle` is also in play (a published pLaTeX class, generated from jclasses.dtx by plcls.ins:19-27, not shipped as a .cls in the zip). Unknown options are swallowed (plnews.cls:8-9).
- Class-native vocabulary used by the sample: `\publicationyear`, `\publicationmonth`, `\publicationissue` (plnewsc07.tex:4-6, defined plnews.cls:21-31), `\author`, `\maketitle`, `\file` (plnews.cls:94), `\section`, `itemize`; the bar short-verb from `shortvrb` (plnews.cls:11-12). Defined by the class but not used by the sample: `\issuename` (plnews.cls:32, never printed), `\option` (plnews.cls:95), `\title` (default set at plnews.cls:18).
- jarticle facts that decide the layout (jclasses.dtx): `a4j` sets A4 and turns on `\@stysize` (317-319); with `\@stysize` and two columns the text width is `.8\paperwidth` (1084-1086); `secnumdepth` 3 (2474); `\Cvs` is `\baselineskip` (659).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | plnewsc07.tex:2; plnews.cls:2,10 | `class.plnews` | no options; loads `class.jarticle` with a4j, twocolumn, oneside |
| base class | plnews.cls:10; jclasses.dtx:317-319 | `class.jarticle` | a4j, twocolumn, oneside |
| paper and columns | plnews.cls:10 | `page.class-options` | a4j, oneside |
| columns | plnews.cls:10 | `cols.twocolumn-option` | twocolumn (inherited from jarticle) |
| margins and footskip | plnews.cls:13, 66-68 | `page.setlength` | footskip=15mm, topmargin=0pt, headheight=0pt, headsep=0pt |
| Japanese typesetting settings | plnews.cls:1, 96-98 | `lang.ptex` | format pLaTeX2e; `\xspcode` of the backslash, less-than and greater-than characters set to 3 |
| running footer | plnews.cls:47-53 | `hf.class-native` | page style `titlepage` (set by `\pagestyle`): empty head, foot = title, issue number, fill, page number |
| title block, class fields | plnewsc07.tex:4-7, 48; plnews.cls:18-45 | `front.class-native` | publicationyear=2017, publicationmonth=07, publicationissue=c7, author = community name and URL; default title "pLaTeX news" (Japanese, plnews.cls:18) |
| title block, spanning the columns | plnews.cls:35; plnewsc07.tex:28 | `cols.twocolumn-cmd` | `\twocolumn[{...}]` with the title block as its optional argument |
| title block boxes | plnewsc07.tex:29, 37 | `box.minipage` | `\parbox[t][6\baselineskip]{\textwidth}` and `\parbox[t][3\baselineskip]{\textwidth}` |
| title block author list | plnewsc07.tex:33-35 | `tbl.tabular` | `tabular[t]{l}` holding `\@author` |
| title block spacing | plnewsc07.tex:30-32; plnews.cls:37-39 | `sp.manual-space` | `\hspace{3mm}`, `\\[\medskipamount]` |
| title block type sizes | plnews.cls:19, 38; plnewsc07.tex:31-32 | `font.size-commands` | `\Huge` (via `\@titlefont`), `\normalsize`, `\normalfont` |
| title note and author note | plnewsc07.tex:39, 49 | `front.thanks` | `\footnotemark` in the title box, `\footnotetext` after `\maketitle` |
| section headings | plnewsc07.tex:22-26; plnews.cls:57-61 | `head.kernel` | `\section` = `\@startsection{section}{1}{\z@}{1.5\Cvs plus .6\Cvs minus .2\Cvs}{.5\Cvs plus .3\Cvs}{\reset@font\large\bfseries}` (the class has `\Large`, the sample `\large`, comment at plnewsc07.tex:25) |
| numbering depth | jclasses.dtx:2474 | `num.secnumdepth` | secnumdepth=3 (set by jarticle) |
| lists | plnewsc07.tex:169-206, 234-243, 255-272; plnews.cls:73-89 | `list.kernel` | nested `itemize`, custom item labels `\item[A]`; class forces parskip, itemsep, parsep = 0 and `\makelabel` = `\hss\llap` |
| list indent | plnewsc07.tex:172, 184, 198 | `sp.lengths` | `\itemindent-18pt` |
| tables | plnewsc07.tex:91-94, 134-137, 155-163 | `tbl.tabular` | `tabular{\|l\|c\|r\|}` and `tabular{lcccc}` |
| table rules | plnewsc07.tex:17, 156-162 | `tbl.booktabs` | `\toprule \midrule \bottomrule` |
| verbatim and short verb | plnewsc07.tex:58-63, 249-251; plnews.cls:11-12; plnewsc07.tex:90, 95, 133, 138 | `code.verbatim` | `verbatim` env; `shortvrb` bar short-verb, switched off and on around tabulars |
| footnotes | plnewsc07.tex:224, 258, 263 | `fn.kernel` | `\footnote` |
| footnote placement package | plnewsc07.tex:18-20 | none (UNMAPPED) | `pxftnright`, `\footnoterule` saved and restored around it |
| text marks | plnewsc07.tex:228; plnews.cls:94-95 | `mark.kernel` | `\textbf`, `\texttt`, `\textsf` (`\file` = `\textsf`, `\option` = `\texttt`) |
| vertical spacing | plnewsc07.tex:96, 107, 164 | `sp.manual-space` | `\medskip`, `\bigskip` |
| logo and command aliases | plnewsc07.tex:9-14 | `mark.kernel` | `\cs`, `\pTeX`, `\eTeX`, `\epTeX`, `\pLaTeX`, `\pLaTeXe` as `\def` aliases with `\kern`; `\varepsilon` inside (a `math.kernel` use) |

Not used by the main sample, so no row: abstract, contents, bibliography, index, theorems, floats and captions (a `figure*` and `table*` appear only in other samples, plnews06.tex:68 and plnews01.tex:187), colour, cross-references, code listings.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\@tabclassz` redefinition, plain version | plnewsc07.tex:66-88 | no | edits array's internal preamble builder to add `\hskip1sp` in cells; no lib way (BESPOKE/body) |
| `\@tabclassz` redefinition, `\inhibitglue` version | plnewsc07.tex:109-131 | no | same, with the pTeX primitive `\inhibitglue` and a doubled `\unskip`; the sample's prose (plnewsc07.tex:141-145, read from the JIS text) says loading `array` voids this fix and points to the `plarray` package of the platex-tools bundle, which is not in the zip (BESPOKE/body) |
| `\maketitle` override | plnewsc07.tex:27-42 | yes | `\twocolumn[...]` + two `\parbox` + author `tabular`: `cols.twocolumn-cmd`, `box.minipage`, `tbl.tabular`, `sp.manual-space`, `front.thanks`; only kernel commands over stored text, no conditionals |
| `\section` override | plnewsc07.tex:22-26 | yes | plain `\@startsection` parameter set; `head.kernel`, or `head.titlesec` with `\titleformat` (large bold) and `\titlespacing` |
| footnote rule save and restore | plnewsc07.tex:18-20 | yes in form | load-order trick around one package; reducible once the package has a way (UNMAPPED) |
| logo aliases | plnewsc07.tex:9-14 | yes | `\newcommand` aliases over `\texttt`, `\char92`, `\kern`, `\TeX`, `\LaTeX` |
| `\maketitle` and publication fields (class) | plnews.cls:19-45 | yes | stored text macros (the unset defaults raise `\ClassError`, a guard that prints nothing, plnews.cls:22-31) and the same kernel-command title block |
| `\ps@titlepage` (class) | plnews.cls:47-53 | yes | `hf.fancyhdr`: empty head, foot = title, issue number, `\hfil`, `\thepage` |
| `\section` (class) | plnews.cls:57-61 | yes | as the sample override, `\Large` |
| `itemize` (class) | plnews.cls:73-89 | yes in form | `list.enumitem` with parsep, itemsep, parskip = 0 and right-aligned label; the `\iftdir` branch is vertical-writing only and inert in jarticle (horizontal). Equal output not claimed. |
| `\xspcode` (class) | plnews.cls:96-98 | yes | three integer assignments: `lang.ptex` |
| `\file`, `\option` (class) | plnews.cls:94-95 | yes | aliases of `\textsf` and `\texttt` |
| `polnews.cfg` hook | plnews.cls:4-6 | yes | optional local config; the file is not in the zip, so it adds nothing |
| exppl2e.sty | exppl2e.sty:33-58, 248-269 | not in scope | published in the same bundle; patches pLaTeX internals (`\strut` with `\iftdir`, `\ifmdir`, `\tstrutbox`; loads `platexrelease`). No sample loads it: every `\RequirePackage{exppl2e}` hit sits on the line after a `\begin{verbatim}` (plnewsc03.tex:53-54, plnewsc04.tex:63-64, plnewsc12.tex:55-56) and plnewsc07.tex:249-251. |
| pLaTeX format and class sources | plcore.dtx, platex.dtx, plfonts.dtx, kinsoku.dtx, plext.dtx, plexpl3.dtx, plvers.dtx, platexrelease.dtx, pl209.dtx, jclasses.dtx, jltxdoc.dtx (about 20000 lines) | not assessed | published format and class code, the engine layer the sample runs on, not template code; outlined or not read. jarticle is loaded unchanged, so its source needs no reading. |

## Content-opaque
none (the verbatim listings and table cells are content; the kanji text is content).

## Lib changes
- New ways proposed:
  - `lang.ptex` pTeX / e-pTeX Japanese typesetting settings in the preamble: `\xspcode`, `\kanjiskip`, `\xkanjiskip`, `\prebreakpenalty`, `\postbreakpenalty`, with the pLaTeX2e format and the kanji source encoding as the engine flag. Engine: `ptex` (a new tag, not pdf and not xe/lua). W1: pTeX primitives are released with TeX Live and documented in public by the Japanese TeX Development Community (README.md:3-6, 14-17); this is the weakest test, since they are engine primitives, not a LaTeX package. W2: integers, glue and penalties. W3: serves any Japanese document, not one. W4: printed as preamble assignments. No home in the lib: `lang.cjk` is CJK, xeCJK and ctex under XeLaTeX or LuaLaTeX and has no `\xspcode`.
  - `cols.twocolumn-cmd` kernel `\twocolumn[full-width heading]` (and `\onecolumn`): starts a new page in two columns with a spanning block above them. Engine: pdf. W1: kernel command. W2: the argument is a content block, the column gap and rule are lengths. W3: any two-column document. W4: body wrapper around the node. Not `cols.twocolumn-option` (that is the class option) and not `cols.cuted` (a package for material in the middle of a page).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- All kanji strings are ISO-2022-JP with JIS escapes (README.md:61-65, `-kanji=jis` at Makefile:9). They were read as: "第…号" (issue), "…年…月 発行" (published), "作成者：" (author label) at plnews.cls:38-40; I did not decode the body prose beyond that, and it is content.
- No text addressed to an AI was found in the files read.
- The Makefile builds the bundle's own documents with platex, mendex, dvipdfmx and, for the English documents, perl (Makefile:12-14, 120, 130). That is the bundle's build, not the sample's, so it is not counted as EXTERNAL; a stricter reading could count the DVI to PDF step (dvipdfmx) for the sample.
- CTAN reads used (3 of 3): `platex` (found; bsd3, pTeX and e-pTeX, community edition), `pxftnright` (404), `pxbase` (no mention of pxftnright).
- The other samples were grepped for preamble commands only: they use the same class and add `plext`, `amsmath` (plnewsc04.tex:3-4), `minijs` (plnewsc16.tex:3), `\fbox` with a pTeX direction-option `minipage<t>` (plnewsc04.tex:85) and `tabbing` (plnews01.tex:189). None of that was read in full, so none of it is in the map.
