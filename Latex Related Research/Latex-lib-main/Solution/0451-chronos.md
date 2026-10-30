no

# 0451-chronos: chronos (TikZ timelines package, DocStrip source with its ltxdoc manual)

- Unverified: read from the source, not compiled.
- Source: Source/0451-chronos/ (origin: https://mirrors.ctan.org/macros/latex/contrib/chronos.zip; licence: LPPL 1.3c, README.md:7-16)
- Kind: misc (the only documents are the package manual and the code manual of a timeline-drawing package, README.md:5; manifest hint was `calendar`)
- Lib: v4
- Engine: pdfLaTeX-compatible (the package is tested under pdfTeX, LuaTeX and XeTeX, manifest.txt:52-59; the manual driver sets `\pdfminorversion=7`, chronos.dtx:28, and needs a 2023+ format for `\property_ref`, chronos.dtx:1351-1358; no fontspec, no Lua)
- Look carried by: mixed (the manual's look is the published class `ltxdoc` plus a zip-local preamble of about 1,350 lines in the driver, chronos.dtx:27-1409; the timelines are drawn by the published CTAN package `chronos`, whose source is the unprefixed lines of chronos-code.dtx)
- Class origin: tex-distribution-unbundled (`ltxdoc` is LaTeX base and is not in the zip; `chronos.sty` is the CTAN release, generated from the dtx by chronos.ins:62-67, not a zip-local invention)
- Main file: chronos.dtx (its `driver` block, lines 27-1409, holds `\documentclass` at 43 and `\begin{document}` at 1398; there is no .tex file) (other samples: chronos-code.dtx driver, lines 31-65, `\documentclass[11pt,british]{ltxdoc}` at 43 with no further preamble; chronos-doc.pdf and chronos-imp.pdf are built output and were not read)
- Read: main partly (chronos.dtx lines 1-1928, 2088-2207, 2608-2737, 3312-3422, 6489-6730, 7472-7622, 7735-7770 read; not read: 2208-2607, 2738-3311, 3423-6488, 6731-7471, 7623-7734, which are the key reference entries, style gallery figures and custom-style examples, sampled by grep), zip-local classes and styles partly (no separate .cls or .sty is shipped; the package code in chronos-code.dtx was read at 1-405, 4290-4440, 7043-7152 and 7653-7829; not read: 406-4289, 4441-7042 and 7153-7652, outlined by grep)

## Verdict
No. The zip is the CTAN source of the `chronos` package and two `ltxdoc` manuals; the package is published (W1) and its timelines are figure content in the manual (`art.tikz`, restricted), so they alone would not block. The block is the manual's own driver preamble (chronos.dtx:27-1409), which is the only sample and is in scope: it carries irreducible zip-local expl3 code (a key, concept and index layer that writes `\@wrindex` entries and builds hyperlink targets from regex-normalised names, a rotate-and-fit box routine, and patches of `doc` and kernel internals). One new way is proposed for the float-page page style (`hf.floatpag`); everything else in the preamble and body maps to existing ways or reduces.

## Blockers
- `BESPOKE/preamble` documentation key, concept, hypertarget and index layer: expl3 keys `chronos doc / name` (chronos.dtx:201-267), regex-normalised target names (182-187, 336-440), computed multi-level `\@wrindex` index writes (591-638, 684-741), `\__chronosdoc_name:nn` (755-782), the user commands `\keyname` `\conceptname` `\pkgname` `\fortags` `\chronosdocidx` `\NewDocElements` (849-924, 973-1121); the body uses `\keyname` about 740 times and `\chronosdocidx` about 96 times (counts include the definitions), so it drives what is printed
- `BESPOKE/preamble` `\chronosdoctroibocs{angle}{width}{height}{content}`: rotates a box with `\box_rotate:Nn`, then forces it to a width and a computed height with `\hbox_set_to_wd:Nnn` and `\vbox_set_to_ht:Nnn` (chronos.dtx:643-681); used by two figures (chronos.dtx:2672, 3102)
- `BESPOKE/preamble` redefinition of `doc` and kernel internals: `\patchcmd{\@doc@describe}` to map a comma list of names (chronos.dtx:1071-1076) and `\def\@xobeysp{\leavevmode\penalty100\ }` (chronos.dtx:1394)

## Class setting
- Class: `class.ltxdoc` options: `10pt,british,a4paper` (chronos.dtx:43); the code manual uses `11pt,british` (chronos-code.dtx:43)
- Class-native vocabulary used: `\DocInput` (chronos.dtx:1401, 1406), `\EnableCrossrefs` (90), `\CodelineIndex` (91), `\RecordChanges` (92), `\changes` (six uses: 1790, 5194, 5620, 5747, 7720, 7722), `\DescribeMacro` (26 uses, first at 3332), `\PrintChanges` and `\PrintIndex` (7732-7733), `macrocode` (47), `theindex`, DocStrip guards `%<*driver>` `%<*doc>` `%<*doc-code>` (27, 7739, 7752); `\DescribeKey` (100 uses, first at 3269) and the other `\Describe...` commands come from `doctools` (132-135), not from `ltxdoc`

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | chronos.dtx:43 | `class.ltxdoc` | 10pt, british, a4paper; doc, index and change-history vocabulary above |
| paper and size | chronos.dtx:43 | `page.class-options` | `a4paper`, `10pt` |
| page geometry | chronos.dtx:96, 1296, 1412-1413, 2084, 7469 | `page.geometry` | `headheight=12pt, marginparwidth=45mm, hmarginratio=4:1, vscale=.8, hscale=.7, verbose`; `\newgeometry{headheight=12pt,scale=.8,marginparwidth=0pt,marginparsep=0pt}`, `\savegeometry{safonol}`, `\loadgeometry{safonol}` |
| wide float and table indent | chronos.dtx:105, 2639, 6673 | `page.adjustwidth` | `\begin{adjustwidth}{-\tewadjust}{0pt}` around figures and tables |
| computed length | chronos.dtx:99, 1297-1298 | `sp.lengths` | `\newlength\tewadjust`, `\setlength\tewadjust{\marginparwidth+\marginparsep-\paperwidth+\textwidth+\oddsidemargin+1in}` via `calc` |
| header and footer | chronos.dtx:97, 1304-1330, 1415 | `hf.fancyhdr` | style `fancy`: left head `\leftmark` italic, right head `\rightmark` italic when different, centre foot `--- \thepage{} of \lastpage{} ---`; `plain`, `fancyplain`, `fancyempty` variants; `\fancyheadoffset[lh]{0pt}` |
| page style switching | chronos.dtx:1331-1336 | `hf.pagestyle-kernel` | `\pagestyle{fancy}`, `\thispagestyle{plain}` at `begindocument/end` |
| float-page page style | chronos.dtx:101, 1348-1349, 2110, 2424, 2668 | `hf.floatpag` | `floatpag` (sttools): `\floatpagestyle{fancy}`, `\rotfloatpagestyle{fancy}`, per float `\thisfloatpagestyle{empty}` |
| page X of Y | chronos.dtx:1350-1358 | `pgnum.lastpage` | `\lastpage` is zip-local (kernel properties); reduces to the `lastpage` package |
| paragraph spacing | chronos.dtx:104 | `sp.parskip-pkg` | `parskip`, no options |
| microtypography | chronos.dtx:119 | `sp.microtype` | `microtype`, no options |
| text fonts | chronos.dtx:118 | `font.lmodern` | `cfr-lm` (CTAN, enhanced Latin Modern) with `rm={lining},sf={lining},tt={tabular,lining,monowidth}` |
| font-switch aliases | chronos.dtx:1125-1141 | `mark.kernel` | `\ConceptFont` = `\normalfont\sffamily\normalcolor`, `\KeyFont` = `\ttfamily`, `\macrolabelfont` = `\footnotesize\em`; `\DeclareTextFontCommand` wrappers |
| pictograms | chronos.dtx:108, 123-127 | `font.icons` | `pifont`: `\ding{52}`, `\ding{56}`, `\Pisymbol{psy}{191}` |
| math symbol | chronos.dtx:110, 125 | `math.amssymb` | `\checkmark` |
| colours | chronos.dtx:1391-1393 | `color.xcolor` | `strawberry` rgb 1,0,.502; `blueberry` rgb 0,0,1; `moss` rgb 0,.502,.251 |
| language | chronos.dtx:43, 95 | `lang.babel` | `british` |
| quotation marks | chronos.dtx:115-117 | `lang.csquotes` | `\MakeAutoQuote{‘}{’}`, `\MakeAutoQuote*{“}{”}` |
| PDF metadata and links | chronos.dtx:132-148 | `meta.hyperref` | `doctools[loadHyperref=true]`; `\hypersetup{colorlinks=true, citecolor=moss, linkcolor=strawberry, linktocpage=true, urlcolor=blueberry, pdfcreator, pdfproducer, extension=pdf}` |
| bookmarks | chronos.dtx:138 | `meta.bookmark` | `bookmark`, no options |
| URLs | chronos.dtx:1684 | `meta.url` | `\url{...}` (via hyperref) |
| PDF version | chronos.dtx:28 | `meta.documentmetadata` | `\pdfminorversion=7` reduces to `\DocumentMetadata{pdfversion=1.7}` |
| cross-references | chronos.dtx:149-151, 1706 | `xref.cleveref` | `\crefname{paragraph}{note}{notes}`, `\cref` `\Cref` |
| labels | chronos.dtx:1676 | `xref.kernel` | `\label{sec:raisondetre}` |
| title block | chronos.dtx:1417-1428 | `front.maketitle` | `\title{\lpack{\chronosfilebase}}`, `\author`, `\date{\chronosfileversion\ (\textsc{svn} \chronosfilerev)}`, `\maketitle`; version strings from `svn-prov` are content |
| author note | chronos.dtx:1418-1425 | `front.thanks` | `\thanks{Bug tracker: ...}` |
| abstract | chronos.dtx:1433-1439 | `abs.kernel` | `abstract` environment |
| contents | chronos.dtx:1674 | `toc.kernel` | `\tableofcontents` |
| headings | chronos.dtx:1676, 1693, 2088 | `head.kernel` | `\section`, `\subsection`, `\subsubsection`, `\subparagraph*` |
| numbering depth | chronos.dtx:1337 | `num.secnumdepth` | `\setcounter{secnumdepth}{5}` |
| lists | chronos.dtx:98, 1342-1344, 1680, 3373 | `list.enumitem` | `enumitem[inline]`; `\newlist{chronosmethod}{enumerate}{2}`, `\setlist[chronosmethod,1]{label=\textbf{Method \arabic*:},ref=\arabic*,wide}`, `\setlist[chronosmethod,2]{label=\textbf{(\alph*)},...,wide}`; `description[font=\normalfont]` |
| plain lists | chronos.dtx:1680, 7487 | `list.kernel` | `itemize`, `enumerate` |
| footnotes | chronos.dtx:1436, 1735 | `fn.kernel` | `\footnote{...}` with `\href`; `\texsethanks` and `\texseans` wrap it |
| margin ticks | chronos.dtx:123-124, 6927, 6937 | `note.marginpar` | `\cywir` and `\anghywir` = `\marginpar{\raggedleft...\textcolor{green}{\ding{52}}}` and red `\ding{56}` |
| case change | chronos.dtx:1140 | `mark.case` | `\Pkg` = `\textpkg{\MakeUppercase#1}` |
| tables | chronos.dtx:111-113, 2696, 2702-2729, 7497-7509 | `tbl.tabularx` | `tabularx` with `>{\ttfamily}l>{\ttfamily}H>{\ttfamily}lHlcc`, `\newcolumntype{H}{>{\raggedright}X}` |
| table rules | chronos.dtx:111, 2703-2728, 7498-7508 | `tbl.booktabs` | `\toprule \midrule \cmidrule(lr){3-7} \bottomrule` |
| plain tabular | chronos.dtx:7497 | `tbl.tabular` | `\begin{tabular}{ll}` |
| figures | chronos.dtx:2638-2661 | `fig.graphicx` | `figure` float holding a drawing (not `\includegraphics`), `\centering`, `[!b]` at 1443 |
| rotated figures | chronos.dtx:100, 2108-2296, 2422-2575 | `fig.rotating` | `sidewaysfigure` |
| subfigures | chronos.dtx:114, 2762, 2779 | `fig.subcaption` | `\subcaptionbox{...}{...}` |
| captions | chronos.dtx:121-122, 2659 | `cap.caption` | `\DeclareCaptionLabelFormat{continued}{Continued #1 #2}`, `\captionsetup[ContinuedFloat]{labelformat=continued}` |
| caption command | chronos.dtx:2659, 2691 | `cap.kernel` | `\caption{...}\label{fig:rhag}` |
| code listings | chronos.dtx:1195-1244, 1769 | `code.listings` | `\lstdefinestyle{lstchronos}` (based on doctools' `lstDemoStyleLaTeXCode`, `gobble=2`, `numbers=none`, keyword colour `chronosWildStrawberry` bold, `frame=none`), `lstchronosframe` (`frame=single, framesep=3pt, rulesep=2pt, framerule=0.4pt`); `\lstnewenvironment{chronoscode}[1][]` |
| verbatim | chronos.dtx:103, 7022, 7375 | `code.verbatim` | `verbatim` environment, `\verb` |
| doc and doctools vocabulary | chronos.dtx:132-137, 1160-1171, 7732-7733 | `dtx.doc` | `hypdoc` and `doctools` as parameters: `\NewDocElements{boolkey|boolean key, ..., tag}`, `\RenewDocElement[...]{Macro}{macro}` (933-946), `\PrintChanges`, `\PrintIndex` |
| index | chronos.dtx:107, 1172-1191, 1192-1194 | `idx.makeidx` | `makeidx`; `\renewenvironment{theindex}` and `\renewcommand\glossary@prologue` (see Bespoke code) |
| index in two columns | chronos.dtx:1174-1182 | `cols.twocolumn-cmd` | `\twocolumn[\section*{\indexname}...]` |
| timelines (the documented package) | chronos.dtx:1461-1666, 2112, 2641-2658; chronos-code.dtx:235-246, 4441 | `art.tikz` | `chronos` environment with pgfkeys options and `\chronosevent` `\chronoslife` `\chronosperiod`; 81 `chronos` environments; restricted way, so `Content-opaque` (see below) |
| memoisation of the timelines | chronos.dtx:63-81 | none (no printed effect) | `memoize[extract=python]` and `\mmzset{prefix=memos/, auto=\cref{multiref}, ...}`; a build-speed layer, not a component |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| documentation key, concept, hypertarget and index layer | chronos.dtx:182-267, 270-792, 849-924, 955-1121 | no | expl3 keys, regex name normalisation, `\@wrindex` writes with computed levels, hypertarget/hyperlink pairs keyed to the normalised string; `idxcmds` (`idx.makeidx`) writes one fixed entry per command and cannot take `idx pre`, `idx post`, `link to` or `target as` |
| `\chronosdoctroibocs` | chronos.dtx:643-681, used 2672, 3102 | no | rotate then fit a box to a width and a height computed from its own size; box-and-glue algorithm, not `fig.rotating` (which only rotates) |
| `\patchcmd{\@doc@describe}` | chronos.dtx:1071-1076 | no | patches a `doc.sty` internal so `\Describe...` takes a comma list |
| `\def\@xobeysp{\leavevmode\penalty100\ }` | chronos.dtx:1394 | no | redefines a kernel internal (the space of `\obeyspaces`) |
| `\DeclareUnknownKeyHandler` | chronos.dtx:50-60 | yes | defined with l3keys private functions and never called anywhere in the zip; delete |
| `\lastpage` | chronos.dtx:1350-1358 | yes | `pgnum.lastpage` (`lastpage` package) |
| `\patchcmd{\sectionmark}`, `\patchcmd{\HDorg@tableofcontents}` | chronos.dtx:1338-1340 | yes | the effect is headings not set in capitals: `\renewcommand\sectionmark` under `hf.fancyhdr`, and a contents title that is not upper-cased under `toc.kernel` |
| `\renewenvironment{theindex}` and `\glossary@prologue` | chronos.dtx:1172-1194 | yes | the standard recipe: `cols.twocolumn-cmd` with `\section*{\indexname}`, `\parindent\z@`, `\parskip\z@ \@plus .3\p@` (`sp.lengths`), `\let\item\@idxitem` |
| `\chronosdocidxfn`, `\chronosdocrestorefn` | chronos.dtx:783-791 | yes | `\footnotemark` before and `\footnotetext` after a `\twocolumn[...]` argument, `fn.kernel` |
| alias macros `\TikZ` `\PGF` `\pgf` `\fycheck` `\fycross` `\sqarrow` `\cywir` `\anghywir` `\pkg` `\Pkg` `\lib` `\val` `\valmarg` `\vals` | chronos.dtx:123-127, 794-801, 1088-1092, 1139-1141, 1301-1303 | yes | `\newcommand` aliases of `mark.kernel`, `font.icons`, `mark.case` calls |
| font switches `\ConceptFont` `\PkgFont` `\KeyFont` `\macrolabelfont` and `\textconcept` etc. | chronos.dtx:1125-1138 | yes | `\DeclareRobustCommand` and `\DeclareTextFontCommand` over `\normalfont\sffamily`, `\ttfamily`, `\footnotesize\em`, `mark.kernel` |
| `\texsethanks`, `\texseans` | chronos.dtx:1279-1295 | yes | `\footnote{I am grateful to ... \href{...}{...}}`, `fn.kernel` with `meta.hyperref` |
| listing environments and styles | chronos.dtx:1195-1244 | yes | `\lstdefinestyle`, `\lstnewenvironment` calls, `code.listings`; the line `\RenewDocumentCommand \lstnewenvironment {moomm}{\relax}` (1244) only blocks later redefinitions and has no printed effect |
| `\newlist{chronosmethod}` | chronos.dtx:1342-1346 | yes | `list.enumitem` with the labels above |
| date split for "Current Release" | chronos.dtx:1444-1453 | yes | `\def\tempa#1/#2/#3\nil{#1}` splits the DocStrip file date into year, month and day for one event; a literal date (content) |
| `chronos.sty` and its libraries | chronos-code.dtx:144-7038, 7043-7649, 7653-7756, 7760-7821 | not bespoke: published | the CTAN release; `\usepackage[...]{chronos}` is `art.tikz` content; stricter reading below |

Stricter reading, for re-use: if `chronos.sty` were counted as zip-local code it would be `BESPOKE/package` and irreducible, because it redefines PGF internals (`\pgf@sh@savedanchor` anchors of the `rectangle` shape, chronos-code.dtx:2114-2153; `\patchcmd{\chronos@settodim}`, 1750; global patches of `tikzpicture` initialisation, chronos.dtx:1704) and computes positions from dates with expl3 and `pgfcalendar` (chronos-code.dtx:239, 591). It is on CTAN, in TeX Live and MiKTeX (ctan.org/pkg/chronos), so this analysis does not take that reading. The verdict `no` does not depend on it.

## Content-opaque
- The timelines drawn by `chronos` in the manual's examples and figures (81 `chronos` environments, first at chronos.dtx:1461) and the raw TikZ inside them (`\foreach` and `\draw [chronos connect=...]`, chronos.dtx:1594-1599, 1618-1651; the anatomy diagram, 2108-2296; two `tikzpicture` blocks with `remember picture`, 5257, 6884): figure artwork of the manual, not the manual's own identity. If the timeline package had to count as the template look, it would need its own way and a stricter analyst would rule the TikZ annotation figures `ART/body`; considered: `chronos` as a way of its own, not proposed because the lib files TikZ-based picture packages (`tikz-cd`, `pgfplots`) under the restricted `art.tikz`.
- The `macrocode` listings of the implementation (chronos-code.dtx:148 onward) and the 130 `chronoscode` listings in the body are code text.
- DocStrip bookkeeping and `%^^A` comment lines print nothing (chronos.dtx:42-81 and throughout).

## Lib changes
- New ways proposed: `hf.floatpag` `floatpag` (CTAN, in TeX Live as part of `sttools`, LPPL 1.3; ctan.org/pkg/floatpag), pdfLaTeX. It sets the page style of ordinary float pages and of rotated float pages (`\floatpagestyle{name}`, `\rotfloatpagestyle{name}`) and for one float (`\thisfloatpagestyle{name}`). W1: published on CTAN and TeX Live. W2: each command takes one page-style name. W3: serves any document with float pages. W4: one `\usepackage` line plus one preamble line, and an optional line inside a float. Not `hf.pagestyle-kernel` (`\pagestyle`, `\thispagestyle` act on the current page, not on float pages) and not `hf.fancyhdr` (defines the styles, does not select them for floats).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The zip is a package source, not a document template: the manual's timelines are examples of the package, so this zip tests `art.tikz` as a documented package and the `dtx.doc` family (`doctools`, `hypdoc`) as a manual toolchain. If the manual's tooling were excluded as out of scope, as for the documentation-only tools in a template's `doc/` folder, the verdict would turn on the package alone and would be `yes` with `hf.floatpag` as the only addition. The rubric names the sample's preamble in scope and the driver is the only sample, so the verdict here is `no`.
- Not counted: `\usepackage[extract=python]{memoize}` (chronos.dtx:63) names a Python extraction script that memoize runs only when shell escape is allowed; the manual's text says small documents compile quickly without it and that automemoisation is switched on by loading it (chronos.dtx:6539-6541, 6554-6556), so the PDF does not depend on it, so it is not `EXTERNAL`. This was not verified against the memoize manual. The index and change list need `makeindex`, part of the TeX distribution (as `idx.makeidx`).
- Other published packages in the driver and not read: `doctools` (CTAN, TeX Live and MiKTeX, ctan.org/pkg/doctools), `hypdoc`, `cfr-lm`, `svn-prov`, `memoize`, `floatpag`, `changepage`, `enumitem`, `cleveref`, `fancyhdr`.
- `\partokencontext=0` (chronos.dtx:45) is a format compatibility switch with no printed effect. `\errorcontextlines=10` (1396) is a debugging parameter.
- The package needs `NeedsTeXFormat{LaTeX2e}[2021-11-15]` and expl3 from 2022-02-24 (chronos-code.dtx:157, 168-177).
- No text addressed to an AI was found in the zip.
