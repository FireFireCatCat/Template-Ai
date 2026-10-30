no

# 0103-relatese: relatese, a general report helper package

- Unverified: read from the source, not compiled.
- Source: Source/0103-relatese/ (origin: https://mirrors.ctan.org/macros/latex/contrib/relatese.zip; licence: LPPL 1.3c)
- Kind: report
- Lib: v2
- Engine: pdfLaTeX-compatible (biber backend for biblatex; `svg` needs Inkscape and probably shell escape)
- Look carried by: zip-local (a helper style, not a class: `relatese.sty` is generated from the macrocode of relatese.dtx:1249-1724 and only loads published packages with options, plus notation macros; the manual driver sits on `ltxdoc`)
- Class origin: tex-distribution-unbundled
- Main file: relatese.dtx (the only driver is relatese.dtx:20-36, `\documentclass{ltxdoc}` + `\usepackage[full]{relatese}`; no `.tex` file in the zip; other samples: verbatim examples in relatese.dtx:206-225, 279-299, 673-705, 797-819, 885-900, 1007-1028, 1208-1239 and README.md:78-95)
- Read: main yes, zip-local classes and styles all (no `.cls`/`.sty` is shipped; the source of `relatese.sty` is relatese.dtx:1249-1724, read in full, with the driver, the documentation text and relatese.ins; relatese.pdf (build output) and LICENSE (LPPL 1.3c text) not read)

## Verdict
`no`. The zip is a CTAN helper package (`relatese`, ctan.org/pkg/relatese read: LPPL 1.3c, v0.3) that bundles published packages behind options; every other component maps to a lib way and every macro is reducible. The blocker is `\RequirePackage{svg}` (relatese.dtx:1603): the `figures` option, and so `full`, which the manual driver loads (relatese.dtx:23, 1330-1340), unconditionally loads `svg`, whose `\includesvg` calls the Inkscape command line (ctan.org/pkg/svg read), a tool outside TeX; the manual documents the use itself (relatese.dtx:651-667). Without that one package the verdict would be `yes`, with two small new ways proposed below.

## Blockers
- `EXTERNAL/package` `svg` loaded by `figures` and `full`, needs Inkscape (and shell escape when it converts); documented use `\includesvg` (relatese.dtx:1603, 653-662; driver loads `full` at relatese.dtx:23, `full` sets `figures` at relatese.dtx:1333)

## Class setting
- Class: `class.ltxdoc` options: none (relatese.dtx:21). The package is meant for `class.article` (examples use `a4paper` or `letterpaper`: relatese.dtx:209, 232, 239); relatese sets margins only and never the paper size (relatese.dtx:227-229).
- Class-native vocabulary used: `\DocInput`, `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges` (relatese.dtx:30-34), `\ProvidesFile`, `\GetFileInfo`, `\filedate`, `\fileversion` (relatese.dtx:39-47), `\cs`, `macrocode` (relatese.dtx:1249, 1724). Package options of relatese: `layout` `math` `figures` `tables` `science` `sciencecomma` `siunitx` `chemistry` `refs` `biblatex` `cleveref` `drafttools` `full` (relatese.dtx:1290-1340).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (manual) | relatese.dtx:21 | `class.ltxdoc` | no options |
| DocStrip source and manual | relatese.dtx:20, 30-34, 1247, 1249 | `dtx.doc` | `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput{relatese.dtx}`, `%<*driver>` and `%<*package>` guards; `.ins` runs docstrip (relatese.ins:1, 28-30) |
| encoding | relatese.dtx:22 | `font.fontenc-t1` | `T1` |
| paper size | relatese.dtx:227-241 | `page.class-options` | left to the class (`a4paper`, `letterpaper`) |
| page margins | relatese.dtx:1393, 1419-1421, 1452 | `page.geometry` | default preset `standard`: `hmargin=2.5cm,vmargin=3.5cm` |
| geometry presets | relatese.dtx:1422-1449 | `page.geometry` | `compact` hmargin=2cm,vmargin=2.5cm; `wide` hmargin=2cm,top=2.5cm,bottom=3cm; `binding` inner=3cm,outer=2cm,top=3cm,bottom=3.5cm; `draft` hmargin=3cm,vmargin=3.5cm; body variant `\newgeometry`, `\restoregeometry` (relatese.dtx:1435-1449, 342) |
| colours | relatese.dtx:1352, 1362-1370 | `color.xcolor` | nine `\definecolor` RGB entries: darkblue 0,0,192; lightblue 48,224,255; darkgreen 0,128,0; darkred 192,0,0; lightred 224,92,92; orange 254,80,0; wine 142,54,70; superlightgray 240,240,240; darkergray 80,80,80 |
| typography | relatese.dtx:1353 | `sp.microtype` | defaults |
| graphics | relatese.dtx:1354, 1374-1375 | `fig.graphicx` | `\graphicspath{{img/}}`, extensions `.pdf,.png,.jpg,.jpeg,.eps` |
| maths base | relatese.dtx:1355-1356, 1479 | `math.amsmath`, `math.bm`, `math.amssymb` | defaults |
| cancel | relatese.dtx:1481-1482 | `math.physics` | `cancel`; `\CancelColor` = `\color{red}` |
| slash fractions | relatese.dtx:1480 | `math.nicefrac` | `xfrac` loaded under `math`; `\sfrac` never called in the zip |
| numbering | relatese.dtx:1589-1591 | `num.counters` | `\numberwithin{equation}{section}`, `{table}`, `{figure}` |
| table rules | relatese.dtx:1357 | `tbl.booktabs` | `\toprule \midrule \bottomrule` used in the manual (relatese.dtx:153-169, 311-336) |
| table row height | relatese.dtx:1592 | `tbl.tabular` | `\renewcommand{\arraystretch}{1.5}` |
| captions | relatese.dtx:1358, 1378-1379 | `cap.caption` | package options `hang,footnotesize,bf,tableposition=top`; `\captionsetup[figure]{font=footnotesize,format=hang}`; `[table]{font=footnotesize,format=hang,position=above}` |
| compact itemize | relatese.dtx:1359, 1382-1387 | `list.enumitem` | `\setlist[itemize]{itemsep=2pt,topsep=10pt,parsep=0pt,partopsep=0pt}` |
| layout option: block indent | relatese.dtx:1455 | `page.adjustwidth` | `changepage`, load only |
| layout option: columns | relatese.dtx:1456 | `cols.multicol` | load only (doc example 294-296) |
| layout option: authors | relatese.dtx:1457 | `front.authblk` | load only (doc example 284-287) |
| layout option: line spacing | relatese.dtx:1458 | `sp.setspace` | load only (doc example 292) |
| layout option: first-paragraph indent | relatese.dtx:1459 | `sp.indentfirst` | load only |
| layout option: contents lists | relatese.dtx:1460 | `toc.tocloft` | load only |
| layout option: page count | relatese.dtx:1461 | `pgnum.lastpage` | load only |
| layout option: run-in paragraph heading | relatese.dtx:1462, 1466-1467 | `head.titlesec` | `\titleformat{name=\paragraph,numberless}[runin]{\normalfont\normalsize\bfseries}{}{5pt}{}` |
| layout option: footnotes | relatese.dtx:1463 | `fn.footmisc` | load only |
| layout option: footnote marks | relatese.dtx:1471 | `num.counters` | `\renewcommand{\thefootnote}{\fnsymbol{footnote}}` |
| display-maths spacing | relatese.dtx:1487-1492 | `sp.lengths` | `\abovedisplayskip`=15pt, `\belowdisplayskip`=25pt, `\abovedisplayshortskip`=10pt, `\belowdisplayshortskip`=20pt |
| maths notation | relatese.dtx:1495-1584 | `math.amsmath`, `math.kernel` | in-place expansion of the macros listed under Bespoke code |
| figure float style | relatese.dtx:1599, 1609-1610 | `fig.float` | `\floatstyle{plaintop}`, `\restylefloat{table}` |
| subfigures | relatese.dtx:1600, 1605-1606 | `fig.subcaption`, `cap.caption` | `\captionsetup[subfigure]{font=footnotesize,format=hang}`; `[subtable]{font=footnotesize,format=hang,position=above,singlelinecheck=false}` |
| float barrier | relatese.dtx:1601 | `fig.placement` | `placeins`, `\FloatBarrier` (doc 609) |
| landscape pages | relatese.dtx:1602 | `pg.landscape` | `pdflscape` |
| SVG images | relatese.dtx:1603 | `fig.svg` | `svg`, `\includesvg[width=...]{file}` (doc 659); EXTERNAL (Inkscape); see Blockers |
| coloured rows | relatese.dtx:1618 | `tbl.colortbl` | `colortbl`, `\rowcolor{superlightgray}` (doc 780) |
| multi-line cells | relatese.dtx:1619 | `tbl.multirow` | `makecell`, `\makecell{..\\..}` (doc 757) |
| units | relatese.dtx:1627-1638 | `mark.siunitx` | `[detect-all]`; `\sisetup{group-digits=none,range-phrase=--,per-mode=symbol}`; under `sciencecomma` `output-decimal-marker={,}` |
| chemistry | relatese.dtx:1643 | `art.content-package` | `mhchem` `[version=4]`; `\ce{}` is content, restricted way |
| quotes | relatese.dtx:1651 | `lang.csquotes` | defaults |
| bibliography | relatese.dtx:1652-1658 | `bib.biblatex-biber` | `backend=biber,style=numeric-comp,sorting=none,backref=true,autocite=superscript` |
| hyperlinks | relatese.dtx:1663-1674 | `meta.hyperref` | `unicode,bookmarks=true,breaklinks`; `\hypersetup{colorlinks=true,linkcolor=darkblue,urlcolor=darkblue,citecolor=darkblue}` |
| clever references | relatese.dtx:1693 | `xref.cleveref` | loaded after hyperref; manual uses `\cref` (relatese.dtx:302) |
| cross-references | relatese.dtx:309, 302 | `xref.kernel` | `\label{tab:geometry-presets}` |
| dummy text | relatese.dtx:1701 | `draft.todo` | `lipsum` under `drafttools`; `\lipsum[1-3]` only in a verbatim example (1168) |
| quotation block macro | relatese.dtx:1705-1714 | `quote.kernel`, `mark.kernel`, `sp.ragged`, `pg.break` | `samepage` + `quotation` + `\emph{``..''}` + `flushright` |
| revision marker | relatese.dtx:1717-1720 | `font.size-commands`, `sp.manual-space`, `idx.makeidx` | `\Huge`, kerns/lowered boxes, `\index{CoXa}` |
| manual front matter | relatese.dtx:45-49, 51-57, 59 | `front.maketitle`, `abs.kernel`, `toc.kernel` | `\title \author \date \maketitle`, `abstract`, `\tableofcontents` |
| manual headings and tables | relatese.dtx:61, 306-337 | `head.kernel`, `tbl.tabular`, `cap.kernel` | `\section`, `\paragraph` (206); `table[htbp]`, `\centering`, `p{.18\linewidth}` columns (310) |
| manual code and inline markup | relatese.dtx:121-123, 25-28, 151 | `code.verbatim`, `mark.kernel`, `sp.ragged` | `verbatim`; `\opt \pkg \prog \env` = `\texttt`/`\textsf`; `center` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option machinery `\newif`, `\DeclareOption`, `\ProcessOptions` | relatese.dtx:1274-1346 | yes | only sets switches that choose which packages load; the emitter writes the chosen `\RequirePackage` lines directly (`full` = layout, math, figures, tables, siunitx, chemistry, refs, biblatex, cleveref: 1330-1340) |
| conditional loading, hyperref once for `refs` or `cleveref` | relatese.dtx:1662-1694 | yes | resolved at emission: one `meta.hyperref` call, then `xref.cleveref` |
| `\setgeometry`, `\newsetgeometry` name dispatch | relatese.dtx:1397-1417 | yes | `\@ifundefined`/`\csname` lookup of a preset name; emit `page.geometry` `\geometry{..}` or `\newgeometry{..}` with the preset's values |
| geometry preset macros | relatese.dtx:1419-1449 | yes | `\newcommand` aliases of `\geometry` and `\newgeometry` |
| `\seteqskip` | relatese.dtx:1487-1492 | yes | four `\setlength` calls, `sp.lengths` |
| `\mean \lapla \innp \chisq \chisqred` and unit vectors `\vi`..`\vtheta` | relatese.dtx:1495-1496, 1551, 1554-1555, 1571-1584 | yes | `\newcommand` aliases of `\left<..\right>`, `\nabla^2`, `\hat{e}_{..}`, `\chi^2`; expanded in place (`math.amsmath`, `math.kernel`) |
| `\relprime \ud \dd \dda \ddp \ddpa` | relatese.dtx:1498-1548 | yes | `\NewDocumentCommand` with an optional order: `\IfNoValueTF` picks one of two fixed `\frac{\mathrm{d}..}{\mathrm{d}..}` or `\partial` forms, a function of the literal arguments only; expanded in place; no layout effect |
| `\slparallel` | relatese.dtx:1563-1568 | yes (judgement) | a math symbol, `\mathchoice` of `\mathrel{/\mkern-5mu/}` (script sizes -4mu, -3mu); expanded in place keeping the four-way `\mathchoice`; content-level notation, used in a subscript (relatese.dtx:376) |
| `\rmnum`, `\Rmnum` | relatese.dtx:1559-1560 | yes | `\romannumeral` and kernel `\@slowromancap` on a literal number; the emitter writes the numeral as text |
| `\quoteblock` | relatese.dtx:1705-1714 | yes | composition of `pg.break` (kernel `samepage`; the kernel page-break family is a stretch of that line), `quote.kernel`, `mark.kernel`, `sp.ragged`; never called in the zip |
| `\coxa` | relatese.dtx:1717-1720 | yes | `\Huge`, `\kern` and `\lower.5ex\hbox{}` as `sp.manual-space`/`\raisebox`, `\index{CoXa}` when `makeidx` is loaded (`\@ifundefined{index}`, a load-time test the emitter resolves); a text logo, never called in the zip |
| `\renewcommand{\CancelColor}{\color{red}}` | relatese.dtx:1482 | yes | a documented parameter macro of `cancel` |
| `xparse` loaded for `\NewDocumentCommand` | relatese.dtx:1484 | yes | macro-definition aid, no output of its own (in the kernel since 2020); disappears with the expansion above |
| manual macros `\opt \pkg \prog \env` | relatese.dtx:25-28 | yes | `\newcommand` aliases of `\texttt` and `\textsf`, `mark.kernel` |

## Content-opaque
- `mhchem` `\ce{..}` formulae in verbatim examples (relatese.dtx:866-870, 876-878, 1233); `\SI` quantities (840-843); `\includesvg` image files (659); `\lipsum` dummy text (1168); the derivative and unit-vector equations in the manual (430-436, 501-507).

## Lib changes
- New ways proposed:
  - `math.nicefrac`: `xfrac` (CTAN l3packages), `\sfrac[..]{1}{2}` slash fractions, instances set with `\DeclareInstance`; pdfLaTeX. W1 on CTAN, W2 key and instance options, W3 any document, W4 `\usepackage{xfrac}` plus inline `\sfrac`. It does the same job as `math.nicefrac` with another package; merge candidate (as `tbl.nicematrix` into `tbl.nicematrix`). Load-only here (relatese.dtx:1480).
  - `draft.todo`: `lipsum` (CTAN), `\lipsum[range]` dummy paragraphs, `\setlipsum`; pdfLaTeX. W1 on CTAN, W2 paragraph range and options, W3 any document, W4 preamble load plus body `\lipsum[1-3]`. A drafting aid like `showframe` but not a review aid, so not a clean fit for `draft.todo`; merge candidate there (relatese.dtx:1701).
  - `fig.svg`: `svg` (CTAN), `\includesvg[width=..]{file}` and `\includeinkscape`; pdfLaTeX. W1 on CTAN, W2 options, W3 any figure, W4 preamble load plus body command. **EXTERNAL**: it runs the Inkscape command line (ctan.org/pkg/svg), tagged as `code.minted` is. It is not `fig.graphicx` (`\includegraphics` takes no SVG without a converter). Evidence relatese.dtx:1603, 659.
- considered, no way: `xparse` (macro-definition aid only), `\mathchoice` (a TeX math primitive inside a content symbol).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
