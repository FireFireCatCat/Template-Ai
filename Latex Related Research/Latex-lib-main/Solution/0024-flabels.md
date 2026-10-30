yes

# 0024-flabels: flabels (binder-spine labels package, documentation driver)

- Unverified: read from the source, not compiled.
- Source: Source/0024-flabels/ (origin: https://mirrors.ctan.org/macros/latex/contrib/flabels.zip; licence: LPPL 1 or later, README:12-17, manifest `lppl1`)
- Kind: misc
- Lib: v1
- Engine: pdfLaTeX-compatible (no fontspec, no Lua; kernel `picture` plus `color`; README:54-57 still talks of a dvips-era `color.cfg`, but makedoc-patched:57 runs `pdflatex`; not compiled here)
- Look carried by: mixed (the labels are drawn by the published CTAN/TeX Live package `flabels`, shipped here only as `flabels.dtx`; the manual page is `ltxdoc`; the driver preamble adds only the option `nice`)
- Class origin: tex-distribution-unbundled (`ltxdoc`, LaTeX base, not in the zip; the package itself is CTAN: https://ctan.org/pkg/flabels, "Included in TeX Live and MiKTeX", read once)
- Main file: flabels.dtx (the `%<*driver>` block, lines 13-26; other samples: none. `makedoc`, `makedoc-patched`, `makedoc.bat` are documentation build scripts, `flabels.ins` is the docstrip driver, `flabels.pdf` is a shipped output and was not read: no PDF renderer in this session)
- Read: main yes (all 944 lines of flabels.dtx), zip-local classes and styles all (no .cls/.sty/.def/.cfg/.clo is shipped; the package code is the unprefixed lines flabels.dtx:484-941, read in full)

## Verdict
The zip is the source of the published package `flabels` (CTAN, in TeX Live) plus its `ltxdoc` manual, not a document template. Every in-scope component maps to a lib way: the manual is `class.ltxdoc` with kernel components, and the labels are one new way, `label.flabels`, which passes W1 to W4 (published, option and length driven, a printable preamble line plus two body commands). No irreducible bespoke code is copied from the zip, and no template-defining artwork exists: the two `picture` drawings are manual illustrations, recorded as Content-opaque. The yes depends on two rulings stated below (flabels internals are the published way, not bespoke; the manual's pictures are content); read as a zip-local package its internals would be `BESPOKE/class`.

## Blockers
none

## Class setting
- Class: `class.ltxdoc` options: none in the driver (flabels.dtx:14); `\PassOptionsToClass{a4paper}{article}` arrives through the generated `ltxdoc.cfg` (makedoc:16, 22-24, makedoc.bat:13)
- Class-native vocabulary used: `\GetFileInfo` (16), `\fileversion` `\filedate` (19, 22), `\DocInput` (24), `\CheckSum` (55), `\DoNotIndex` (40-53), `\DescribeMacro` (137 and after), `macro` and `macrocode` environments (484-941), `\StopEventually` (480), `\Finale` (943), `\bslash` (324), the `|...|` short verbatim; through `ltxdoc.cfg`: `\CodelineIndex\EnableCrossrefs`, `\PrintIndex` (makedoc:39-41), `\RecordChanges`, `\PrintChanges` (commented out at makedoc:37-38, active at makedoc-patched:40-41)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | flabels.dtx:14 | `class.ltxdoc` | no options; DocStrip `.dtx` driver, `\DocInput{flabels.dtx}` (24) |
| paper size | makedoc:16, 22-24 | `page.class-options` | `a4paper` passed to article via ltxdoc.cfg |
| label package load | flabels.dtx:15, 501-573 | `label.flabels` | `\usepackage[nice]{flabels}`; options available: `leitz` (default), `fullheight`, `narrow`, `color`, `a4paper`, `nice`, `nohole` (dtx:137-180, 501-573) |
| label page model | flabels.dtx:619-629, 640-643 | `label.flabels` | without `nice`: `\textheight=\paperheight`, `\topmargin=-1in`, side margins 0, no head/marginpar; `nice` switches this off (driver uses `nice`); vertical offset only via `\extratopmargin<dim>` (default 0mm); loading `geometry` or `fullpage` after it overrides it (dtx:107-108, 614-617) |
| label size | flabels.dtx:746-767, 697-737 | `label.flabels` | width 60mm, `narrow` 37mm; height 190mm, `fullheight` 285mm; switches `\narrowlabels` `\widelabels` `\fullheight` `\normalheight` (883-886); `\unitlength` 1mm (586) |
| label parts | flabels.dtx:857-874, 814-828, 838-847 | `label.flabels` | outline with 0.01pt rules; company box (`\company{...}`, default `\huge LEITZ`, height 17mm, `\yuppercompany` 160, `\ylowercompany` -68); hole cross marker 29mm (`nohole` removes it); `numberauxlines` counter 4, `\auxlinedistance` 30mm |
| label text field | flabels.dtx:670-672, 923-936 | `label.flabels` | `\labeltextmargin` 3mm, `\hspaceinterlabel` 0mm; text is a plain `\parbox` argument |
| label colours | flabels.dtx:788-800, makedoc-patched:23, 28-29 | `label.flabels`, `color.color` | option `color` runs `\RequirePackage{color}` (789); `\setbgcompany` black, `\setfgcompany` green, `\setbglabel` yellow, `\setfglabel` black (names, not RGB); docs build passes `\PassOptionsToPackage{color}{flabels}` |
| label body commands | flabels.dtx:900-911, 923-936 | `label.flabels` | `\emptylabel{n}` (n identical blank labels), `\labeltext{text}`; `\hspace{\hspaceinterlabel}` between labels |
| label text face (user side) | flabels.dtx:270-275, 298, 313, 337 | `font.size-commands`, `font.family-default`, `mark.kernel`, `sp.manual-space` | `\huge` `\Large` `\large` `\footnotesize`, `\sffamily`/`\sf`, `\textbf` `\textsl`, `\vspace{1ex}`, `flushleft` inside `\labeltext` |
| title block | flabels.dtx:18-23 | `front.maketitle`, `front.thanks` | `\title`, `\author` with `\\` and two `\thanks`, `\date{\filedate}`, `\maketitle` |
| abstract | flabels.dtx:57-64 | `abs.kernel` | `abstract` environment |
| contents | flabels.dtx:66; makedoc:41 | `toc.kernel` | `\tableofcontents` (66); `\addcontentsline{toc}{section}{Index}` from the cfg |
| headings | flabels.dtx:68, 91, 98, 135, 182, 185, 219, 232, 259, 286, 461, 482 | `head.kernel` | `\section`, `\subsection`, `\subsubsection` at class defaults, `\label{sec:...}` |
| lists | flabels.dtx:99-132, 140-180, 188-218, 462-475 | `list.kernel` | nested `itemize`, `description`, no enumitem |
| inline marks | flabels.dtx:86, 313, throughout | `mark.kernel` | `\emph`, `\textbf`, `\texttt`, `\textsf` |
| code and verbatim | flabels.dtx:95, 269-275 | `code.verbatim` | `|...|` short verbatim, `verbatim` environment |
| boxed note | flabels.dtx:81-88 | `box.fancybox`, `box.minipage`, `sp.lengths` | `\fbox{\parbox{\mytextwidth}{...}}`, `\mytextwidth` = `\textwidth` - 2`\fboxsep` |
| footnotes | flabels.dtx:154-156, 283-284 | `fn.kernel` | `\footnote` |
| cross-references | flabels.dtx:98, 148, 163, 263, 379, 695 | `xref.kernel` | `\label`, `\ref`, `\pageref{all_dimens}` |
| spacing, rules, breaks | flabels.dtx:83, 363, 893 | `sp.manual-space`, `sp.rule`, `pg.break` | `\smallskip\noindent`, `\hrule`, `\pagebreak[2]` |
| inline maths | flabels.dtx:78 | `math.kernel` | `$28.3 \times 31.8$` only |
| index and change log | makedoc:39-41, makedoc-patched:40-44, 61-65 | `class.ltxdoc` (native) | `\PrintIndex`, `makeindex -s gind.ist` (a TeX Live tool; `gind.ist` is listed in README:42-44 but is not in the zip) |
| manual figures | flabels.dtx:294-361, 374-459 | `art.pstricks` (content) | `picture` environments with `\put`, `\multiput`, `\line`, `\vector`, `\dashbox`, `\framebox`; see Content-opaque |
| fonts, language, header/footer, bibliography, tables, theorems | none set in the driver or the code | not used | `ltxdoc`/article defaults only |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| package internals: `\newif` switches, `\C@nvertToCount` sp-to-mm, `\full@height`, `\n@rrow`, `\loop` in `\emptylabel`, `\l@beloutline` picture | flabels.dtx:501-936 | not bespoke here (published) | This is the CTAN package, so it is the way `label.flabels` itself (W1 by ctan.org/pkg/flabels); an emitter writes `\usepackage[...]{flabels}` and calls `\emptylabel`/`\labeltext`, never copies this code. If it were a zip-local package it would be hand-rolled counters, conditionals and picture layout, `BESPOKE/class` |
| `\mytextwidth` length | flabels.dtx:81-82 | yes | `box.fancybox` + `box.minipage` + `sp.lengths`: `\fbox{\parbox{\dimexpr\textwidth-2\fboxsep\relax}{...}}` |
| `\mylabel` example macro | flabels.dtx:270-275 (inside `verbatim`) | yes | `\newcommand` alias of `\labeltext{...}` with `font.size-commands`, `font.family-default`, `mark.kernel`, `sp.manual-space`; it is verbatim text, so content anyway |
| pokes at private registers in the manual figures (`\cnt@paperheight=297`, `\cnt@pictvoffset=5`, `\savebox{\theh@le}`, `\makeatletter`) | flabels.dtx:294-298, 305-311, 374-376, 383-392 | no, but not template | Scale the miniature figures by rewriting package internals; figure artwork of the manual, recorded as Content-opaque |
| `ltxdoc.cfg` written by a shell script | makedoc:12-41, makedoc.bat:13-23 | yes | A static five-line `ltxdoc.cfg` (`\PassOptionsToClass`, `\AtBeginDocument`, `\AtEndDocument`); the shell only writes text, it feeds no values into the sample |
| `sed -i '.bak'` rewrite of `flabels.idx` | makedoc-patched:62-63 | outside scope | Workaround for the manual's optional index entries (`->fullheight` etc., dtx:688, 740, 770); not part of the driver, the class files or the body, so recorded, not a blocker |
| docstrip driver | flabels.ins:1-36 | yes | `\generateFile{flabels.sty}{t}{\from{flabels.dtx}{package}}` is TeX itself; TeX Live already ships `flabels.sty` |

## Content-opaque
- `picture` environment with a paper contour, `\put`-placed live labels and framed notes (flabels.dtx:294-361)
- `picture` environment, annotated dimension diagram with arrows and numbered circles (flabels.dtx:374-459)
- Ruling: these are the manual's illustrations of the package, not the template's identity (the labels themselves come from the way, `\emptylabel` and `\labeltext` inside them). A stricter reading would call them `ART/body`.

## Lib changes
- New ways proposed: `label.flabels` (section: doc-kind specific). Package `flabels` (CTAN, LPPL 1, in TeX Live and MiKTeX), pdfLaTeX; `\usepackage[leitz|fullheight|narrow|color|a4paper|nice|nohole]{flabels}`, `\company`, `\setbgcompany` `\setfgcompany` `\setbglabel` `\setfglabel`, `\labeltextmargin`, `\hspaceinterlabel`, `\extratopmargin`, body `\emptylabel{n}` and `\labeltext{text}`. W1: CTAN and TeX Live. W2: options, lengths, a counter, colour names and strings choose the result, no code is edited. W3: serves a kind of component (a ring-binder spine label with free text), not this one document. W4: one preamble line plus two body wrappers around a node's content. Checked first: `ticket.sheet` is the `ticket` package (imposed ticket sheets, `\ticket` face, cutmarks) and `ltr.envlab` is `envlab` (envelope and mailing-label sheets under letter classes); flabels shares no commands or page model with either (it draws a fixed 60/37 by 190/285 mm spine label and sets its own page layout), so it has no home there.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
