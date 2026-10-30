no

# 0915-tpslifonts: tpslifonts (TeXPower presentation-font configuration package and its font-specimen example)

- Unverified: read from the source, not compiled.
- Source: Source/0915-tpslifonts/ (origin: https://mirrors.ctan.org/macros/latex/contrib/texpower/tpslifonts.zip; licence: GPL v2 or later, tpslifonts.dtx:7-10)
- Kind: presentation
- Lib: v6
- Engine: pdfLaTeX-compatible (slifontsexample.tex:6-9 says pdfLaTeX or plain LaTeX; NFSS font declarations only, no fontspec); Type 1 fonts such as cm-super, hfbright and doublestroke are missing assets (01install.txt:72-79)
- Look carried by: mixed (page and slide size by the powersem class, fonts by the tpslifonts package options at slifontsexample.tex:228,262,290, spacing and headings by the sample preamble, the specimen pages by body macros)
- Class origin: tex-distribution-unbundled (`powersem`, not in the zip; its TeXPower membership is not confirmed from CTAN here, see Blockers; the fallback branch loads kernel `article`)
- Main file: slifontsexample.tex (other samples: tpslifonts.dtx via its `ltxdoc` driver at tpslifonts.dtx:33-41; tpslifonts.ins is a DocStrip batch file)
- Read: main yes (all 1600 lines), zip-local classes and styles all (tpslifonts.dtx all 1621 lines, tpslifonts.ins all 64 lines; no `.cls` or `.sty` is in the zip, `tpslifonts.sty` is generated from the `.dtx`). Not read: the source of `powersem`, `texpower`, `fixseminar`, `cmtt`, `easymat` (none is in the zip).

## Verdict
The zip holds one published package (`tpslifonts`, CTAN TeXPower bundle, options only) and an example document that shows it. The package maps to a proposed way, and the preamble maps to lib ways. The answer is `no` because the example's body is a font-specimen generator built from hand-rolled counters, `\@for` loops, `\ifcase` dispatch and a `\@namedef` dictionary that read the package's internal macros (`\charlist`, `\mksymline`, `\listdescriptions`). Those loops drive what is printed and are irreducible by the rubric. `fixseminar` and the `powersem` class also could not be shown to be published from the files and the CTAN pages read.

## Blockers
- `BESPOKE/body` `\charlist`: counter `char`, `\whiledo{\value{char}<#2}`, `\@for\charht := #3\do{\fontsize{\charht}{\charht}\selectfont#4}`, `\stepcounter{char}` (slifontsexample.tex:1403,1406-1419; called at 1495, 1526, 1552)
- `BESPOKE/body` `\mksymline`: counter `symcnt`, `\@for\thesymbol := #1\do`, `\ifcase\value{symcnt}` with nested `\ifthenelse` on `\TPSFMathfont` and the package booleans choosing which cell prints (slifontsexample.tex:1404,1420-1453; called at 1583-1595)
- `BESPOKE/body` font-name registry and printer: about 100 `\@namedef{TextFontName...}`, `{TextFonts...}`, `{TTFonts...}`, `{MathFontName...}` entries keyed by `\TPSFTextfont\encodingdefault`, read back by `\@for\temp := #1 \do{\expandafter\mkdescription\temp}`; `\mkdescription` is renewed twice to print a rule, a label and a sample (slifontsexample.tex:420-731, 775-785, 805-815). The keys `\TPSFTextfont`, `\TPSFMathfont`, `\TPSFOperatorfont` are package internals (tpslifonts.dtx:236,321,327; the package says it has no user-level commands, tpslifonts.dtx:107-108).
- `UNMAPPED/preamble` `\usepackage{fixseminar}` (slifontsexample.tex:297): load-only fix for `seminar`; not in the zip and the CTAN texpower page lists no files, so W1 is not established. If it ships in TeXPower it would be a load-only add-on of `slide.texpower`.

## Class setting
- Class: `class.powersem` options: letterpaper, landscape, KOMA, smallheadings, calcdimensions, display (slifontsexample.tex:30). Chosen only when `texpower.sty` is found (26-27, 29). Otherwise `class.article` (58). The `powersem` source was not read, and `ctan.org/pkg/powersem` is a 404.
- Class-native vocabulary used: `\slidetopmargin` `\slidebottommargin` `\slideleftmargin` `\sliderightmargin` (33-36), `\raggedsection` `\size@section` `\sectfont` (43,47), `\slideitemsep` (48), `\slidesmag` (303,328), `\slideframe` (304), `slide` environment and counter `slide` (396, 307), `\newslide` and `\centerslidestrue` (322-324). The body also uses `\code` `\concept` `\underl` `\macroname` `\present` `presentbox`, which the sample defines only in the fallback branch (364-374); in the powersem branch they must come from the class or texpower (not read).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | slifontsexample.tex:29-30 | `class.powersem` | letterpaper, landscape, KOMA, smallheadings, calcdimensions, display |
| fallback class | slifontsexample.tex:56-58 | `class.article` | no options; branch on `\IfFileExists{texpower.sty}` (26-27) |
| paper and orientation | slifontsexample.tex:30 | `page.class-options` | letterpaper, landscape |
| slide margins | slifontsexample.tex:33-36 | `class.powersem` (class-native lengths) | 5mm each, top bottom left right |
| slide magnification and frame | slifontsexample.tex:303-304,328 | `class.powersem` (seminar-native) | `\slidesmag{5}` then `\slidesmag{4}`; `\slideframe{none}` |
| page size, fallback | slifontsexample.tex:59-60 | `page.setlength` | `\paperwidth` 13cm, `\paperheight` 10cm |
| margins, fallback | slifontsexample.tex:61 | `page.geometry` | left=3mm,right=3mm,top=3mm,bottom=3mm |
| paragraph shape, fallback | slifontsexample.tex:62-64,66 | `sp.lengths`, `sp.linespread` | `\parindent` 0pt, `\parskip` 1ex plus .5ex minus .5ex, `\linespread{1.3}`, `calc` loaded |
| flush | slifontsexample.tex:67 | `pg.flush` | `\raggedbottom` |
| item separation | slifontsexample.tex:48 | `sp.lengths` | `\slideitemsep` .5ex plus .3ex minus .2ex |
| math delimiter parameter | slifontsexample.tex:93 | `sp.lengths` (TeX dimension parameter, filed by kind) | `\delimitershortfall` -1sp |
| page style | slifontsexample.tex:305,331 | `hf.pagestyle-kernel` | empty |
| section heading | slifontsexample.tex:40-43 | `head.kernel`, `head.class-native` | `\@startsection{section}{1}{\z@}`, before -1.5ex plus -1ex minus -.5ex, after .5ex plus .2ex, style `\raggedsection\normalfont\size@section\sectfont`; class option smallheadings (30) |
| subsection heading | slifontsexample.tex:44-47 | `head.kernel`, `head.class-native` | level 2, before -1.25ex plus -1ex minus -.2ex, after .5ex plus .2ex, same style macros |
| section heading, fallback | slifontsexample.tex:359-362 | `head.kernel` | before -1.5ex plus -1ex minus -.5ex, after .5ex plus .2ex, style `\normalfont\large\sffamily\bfseries` |
| contents depth | slifontsexample.tex:306 | `num.secnumdepth` | tocdepth=2 |
| encodings | slifontsexample.tex:53,262 | `font.fontenc-t1` | inputenc latin1; fontenc T1 |
| presentation fonts | slifontsexample.tex:228,290 | `NEW:font.tpslifonts` | active scenario 7: options cmr, scale7pt; scenarios 1-6, 8-9 are commented (140-250) |
| font scale macros | slifontsexample.tex:144,164,180,270-282 | `NEW:font.tpslifonts` | `\TPSFttscale`, `\TPSFmathscale`, `\TPSFeulerscale`, `\TPSFcmbrscale`, all commented out |
| typewriter face | slifontsexample.tex:90 | `font.mono` | `cmtt`, option override |
| math symbol fonts | slifontsexample.tex:83-88 | `math.amssymb` (amssymb, latexsym, stmaryrd), `font.icons` (wasysym), `math.bm` (mathrsfs, dsfont) | load-only; the lib lines name only some of these packages, the package is the parameter |
| maths | slifontsexample.tex:100 | `math.amsmath`, `math.eqnumber` | `[leqno]` |
| commutative diagrams | slifontsexample.tex:102,1162-1172 | `math.amsmath` (amscd, AMS-LaTeX bundle) | `CD` environment inside `align*` |
| matrix with drawn path | slifontsexample.tex:106,1203-1211 | `math.physics` (easymat, CTAN, LPPL; commands taken from the sample) | `MAT(b){ccccccc}`, `\addpath{(2,0,0)rrrrruuuuulllllddddd}`; optional by `\IfFileExists` |
| tables | slifontsexample.tex:104,1466-1472 | `tbl.tabular` | `array` loaded; `tabular{lll}`, `\hline`; inside a block that the active scenario never prints (1456) |
| URL typesetting | slifontsexample.tex:52,65 | `meta.url` | `url` |
| hyperlinks and PDF | slifontsexample.tex:296,327 | `meta.hyperref` | plainpages=false, bookmarksopen, colorlinks, urlcolor=red, pdfpagemode=FullScreen; pdftitle |
| slide overlays package | slifontsexample.tex:111,114,300,325 | `slide.texpower` | options lightbackground, colorhighlight, colormath; `\setcounter{firststep}{1}`; body wrappers such as `\step` are never called (Grep) |
| page counter for links | slifontsexample.tex:307 | `slide.texpower` | `\currentpagevalue` = `\value{slide}` |
| title block, powersem | slifontsexample.tex:310-326,735 | `front.maketitle` | `\title{The \TeX Power bundle\\[2ex]{\normalfont #1}}`, `\author{...\url{mailto:...}}`, `\centerslidestrue`, `\maketitle`, `\newslide` |
| title block, fallback | slifontsexample.tex:332-357 | `front.titlepage-env`, `sp.manual-space`, `font.size-commands`, `mark.kernel`, `pg.break` | `center`, `\leavevmode\Large\sffamily`, five `\vspace*{\fill}`, `\textbf`, `\today`, `\newpage` |
| slide environment | slifontsexample.tex:396,370 | `class.powersem`; fallback `sp.ragged` | `slide` env; fallback `\newenvironment{slide}{\raggedright}{}` |
| inline marks and font aliases | slifontsexample.tex:55,364-368,403-417 | `mark.kernel`, `font.nfss` | `\let\name=\textsc`, `\let\code\texttt`, `\textbfsl`, `\fontseries{sbc}\selectfont`, `\fontshape{ui}`, `\fontfamily{cmfr}` |
| lists | slifontsexample.tex:751-759,1156-1175 | `list.kernel` | `enumerate`, `\item[(i)]` |
| rules and spacing | slifontsexample.tex:778-791,852 | `sp.rule`, `sp.manual-space`, `pg.break` | `\hrule`, `\medskip`, `\pagebreak[3]`, `\nopagebreak` |
| page-flow group | slifontsexample.tex:869-875,903-910,930-956 | `pg.break` | `samepage` |
| boxes | slifontsexample.tex:372,374,1045-1047,881,917 | `box.minipage`, `box.fancybox`, `sp.lengths` | `minipage[t]{\linewidth}`, `\parbox{\linewidth-\widthof{...}-1ex}`, `\let\present=\fbox` |
| display skips | slifontsexample.tex:1048,1231-1232 | `sp.lengths` | `\abovedisplayskip` .3 of itself; `\belowdisplayskip` .5 of itself |
| display maths | slifontsexample.tex:1054-1067,1245-1248 | `math.amsmath`, `math.kernel` | `align*`, `displaymath`, `\text`, `\operatorname`, `\underbrace`, `\substack`, `\lefteqn` |
| equation number and tag | slifontsexample.tex:1109-1111,1263 | `math.amsmath`, `num.counters`, `xref.kernel` | `\setcounter{equation}{8}`, `\label{eq:GaussLemma1}`, `\tag{23.12}` |
| label | slifontsexample.tex:735 | `xref.kernel` | `\label{Sec:tpslifonts}` |
| sections and subsections in body | slifontsexample.tex:771,793,823,1036,1460 | `head.kernel` | `\section`, `\subsection` |
| page breaks | slifontsexample.tex:748,761,1035 | `pg.break` | `\newpage` |
| dtx driver class | tpslifonts.dtx:34 | `class.ltxdoc` | `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges` (35-37), `\DocInput` (39) |
| dtx documentation | tpslifonts.dtx:45,66,189,193-226 | `dtx.doc` | `\CheckSum`, `\DoNotIndex`, `\StopEventually{\PrintChanges\PrintIndex}`, `\changes` |
| dtx title and contents | tpslifonts.dtx:68-74 | `front.maketitle`, `front.thanks`, `toc.kernel` | `\title` with `\thanks`, `\author`, `\maketitle`, `\tableofcontents` |
| dtx option tables | tpslifonts.dtx:123-130,142-147,156-160,176-187 | `tbl.tabular` | `@{}l@{\hspace{1cm}}l`, `p{0.6\textwidth}`, `\hline` |
| dtx index | Makefile:28-29 | `idx.makeidx` | `makeindex -s gglo.ist`, `-s gind.ist` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\ifTPaware` file test choosing class | slifontsexample.tex:26-27,29,56,68 | yes | The emitter picks one branch: powersem (29-55) or article (56-68) |
| `\@startsection` redefinitions | slifontsexample.tex:40-47,359-362 | yes | `head.kernel` with the skips above; `\raggedsection` `\size@section` `\sectfont` are class vocabulary (`head.class-native`) |
| `\makeslidetitle` (two versions) | slifontsexample.tex:310-326,332-357 | yes | `\newcommand` over `front.maketitle` (powersem) or hand-laid `center` page (fallback), as in the map |
| alias macros `\code` `\concept` `\underl` `\name` `\macroname` `\present` `presentbox` `slide` | slifontsexample.tex:55,364-374 | yes | `\let` and `\newenvironment` of `\texttt` `\textbf` `\textsc` `\fbox` `minipage` `\raggedright` |
| font-wrapper macros `\textbfsl` ... `\textfibsl` | slifontsexample.tex:403-417 | yes | NFSS calls `\fontseries` `\fontshape` `\fontfamily` (`font.nfss`) and `mark.kernel` nests |
| `\let\iint\@undefined\let\iiint\@undefined` | slifontsexample.tex:99 | yes | kernel `\let` between the wasysym and amsmath loads, a package-conflict guard with no printed effect; whether a wasysym option could replace it was not checked |
| `\newboolean{TPSF...}` and `\@ifpackageloaded` flags | slifontsexample.tex:377-388 | yes | the emitter knows which packages it loads and prints the matching blocks |
| `\ifthenelse{\isundefined{\align}...}` blocks | slifontsexample.tex:1039-1400 | yes | emit the unconditional branch; the `ifthen` package (116) is only the carrier |
| `\DeclareRobustCommand` notation macros `\with` `\Set` `\Lcap` ... and `\def\FpFl(#1,#2)` with `\mathchoice` and `\sideset` | slifontsexample.tex:1229-1230,1365-1382 | yes | pure expansion, inline each use inside the equation (content) |
| `\charlist` | slifontsexample.tex:1403,1406-1419 | no | counter loop over a size list that prints a rule and a font-size row per value; see Blockers |
| `\mksymline` | slifontsexample.tex:1404,1420-1453 | no | `\ifcase` counter dispatch over package state; see Blockers |
| font-name registry, `\listdescriptions`, `\mkdescription`, `\TextFontName` | slifontsexample.tex:420-731,775-785,805-815 | no | `\csname` dictionary and `\@for` loop over package internals; could only be printed by unrolling one configuration, which copies the logic's output |
| tpslifonts internals (`\DeclareFontShape@TPSF`, `\FilterSizes@TPSF`, `\EC@family`) | tpslifonts.dtx:447-502,700-769 | n/a | inside the published package, not emitted; the way is the package load |

## Content-opaque
- `amscd` `CD` diagrams (slifontsexample.tex:1162-1172) and the `easymat` path drawing (1203-1211) inside display equations.
- The specimen text and symbol strings printed by the loops (1495-1595); the printed font names depend on the loaded configuration.

## Lib changes
- New ways proposed: `NEW:font.tpslifonts` `tpslifonts` v0.6d (2004/07/27), pdfLaTeX-compatible (NFSS only). W1: part of the TeXPower bundle on CTAN, this zip comes from `macros/latex/contrib/texpower/tpslifonts.zip` (ctan.org/pkg/texpower read: GPL, TeX Live and MiKTeX; the page lists no files, so the membership rests on the zip origin and 01install.txt:21-22). W2: only package options `cmr` `cmfib` `cmss` `cmbright` `concrete` `scale5pt` `scale6pt` `scale7pt` `scaleupmath` `scaleuptt` `textops` `eulermath` `eulerdigits` `cmbrightmath` (tpslifonts.dtx:240-355) plus scale factors defined before loading (dtx:376-390); the package states it has no user-level commands (dtx:107-108). W3: serves any document that needs Computer Modern family text, typewriter and math faces, and is independent of texpower (00readme.txt:87-89). W4: `\PassOptionsToPackage{opts}{tpslifonts}` and `\RequirePackage{tpslifonts}` in the preamble (slifontsexample.tex:228,290), no body wrapper. Not `font.nfss` (one declared family, no option-driven set), not `font.serif-pkg` or `font.helvet` (one named face), not `font.math-face` (maths only), not `font.family-default` (it sets the defaults itself, dtx:1479-1521, but also declares the faces and math symbol fonts).
- Considered, not proposed: `ifthen` (carrier of the bespoke conditionals, no component), a way for `fixseminar` (W1 not established, so not written as a proposal).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
