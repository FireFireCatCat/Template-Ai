yes

# 0296-tclldoc: tclldoc, the doc/docstrip literate-documentation class and package for Tcl code (v2.40), with its ltxdoc-driven manual

- Unverified: read from the source, not compiled.
- Source: Source/0296-tclldoc/ (origin: https://mirrors.ctan.org/macros/latex/contrib/tclldoc.zip; licence: lppl1.2)
- Kind: misc (package documentation: a `.dtx` manual, plus four `.dtx` documents that use the class to document Tcl programs)
- Lib: v4
- Engine: pdfLaTeX-compatible (grep over all files finds no `fontspec`, `luacode`, XeTeX or LuaTeX code and no `write18`; only TeX primitives and kernel commands)
- Look carried by: mixed (the main driver's look is the published class `ltxdoc` plus `amsmath` and `xdoc2[dolayout]`, with a small zip-local preamble layer, tclldoc.dtx:24-95; the other four drivers are carried by the zip's own published class `tclldoc`, defined at tclldoc.dtx:3597-3761)
- Class origin: ctan (tclldoc is on CTAN, ctan.org/pkg/tclldoc, LPPL 1.2, v2.40; the main driver's class `ltxdoc` is tex-distribution-unbundled, tclldoc.dtx:24)
- Main file: tclldoc.dtx (driver at tclldoc.dtx:23-102; other samples: tools/sourcedtx.dtx, tools/eemenu.dtx, examples/parsetcl.dtx, examples/pdf.dtx)
- Read: main yes, zip-local classes and styles all (there are no separate `.cls`/`.sty` files: `tclldoc.cls`, `tclldoc.sty`, `tcldoc.cls`, `tcldoc.sty` are generated from tclldoc.dtx by tclldoc.ins:35-48, and tclldoc.dtx was read in full, lines 1-4065). Secondary samples partly: sourcedtx.dtx all; eemenu.dtx 1-180 plus the `details` uses; parsetcl.dtx 1-120; pdf.dtx 1-120 and the end; the rest of those three is Tcl code and prose.

## Verdict
yes. The main driver loads only published things (class `ltxdoc`, `amsmath`, and `xdoc2` with `dolayout`, from the CTAN/TeX Live `xdoc` bundle) and fills the `doc` package's own vocabulary (tclldoc.dtx:24-26, 93-100). Its zip-local preamble definitions are aliases, one list wrapper, fallbacks and warning thresholds, each of which reduces by inline expansion to kernel commands and lib ways. The zip's own deliverable, class and package `tclldoc`, is published on CTAN, so its source (a catcode-based verbatim reader and paragraph reboxing, which is irreducible TeX in itself) is the `class.tclldoc` way's own behaviour and not zip-local bespoke code; the class file itself is `\LoadClass{article}` plus lengths and a package load (tclldoc.dtx:3646-3760). Two items a stricter reading could count are recorded under "Considered, not counted".

## Blockers
none

Considered, not counted (so a stricter reading can reuse them):
- `BESPOKE/body` (if read strictly) the hand-built "visible tab" glyph made from `\cleaders`, `\mkern`, `\vrule` inside a `\makebox` in running prose (tclldoc.dtx:869-871). It defines nothing and illustrates what the `tcl*` environment prints, so it is held as content (see Content-opaque). The lib line `sp.rule` calls leaders over arbitrary boxes bespoke.
- `BESPOKE/preamble` (if read strictly) the `\meta` robustness patch (`\futurelet`, `\protect` test) at tclldoc.dtx:29-41. It runs only when `xdoc2` is not loaded and `doc` is older than 2000/05/20; the driver loads `xdoc2` on line 26, and README.txt:16-17 names `xdoc2` as a dependency, so the branch is dead and is dropped.
- `EXTERNAL` not raised: the index and change history need a `makeindex` pass (the package prints "Use docindex.ist when sorting .idx and .glo files", tclldoc.dtx:1514-1519), but the document does not need it to build (a missing `.ind` only prints "No file", tclldoc.dtx:2943, 2965) and `idx.makeidx` is a lib way with the same toolchain. The `.ins` files run docstrip, which is TeX (tclldoc.ins:35-48; examples/parsetcl.ins:36-37).
- Text addressed to an AI: none found.

## Class setting
- Class (main driver): `class.ltxdoc` options: none (tclldoc.dtx:24). Its source is in the LaTeX base, not in the zip, not read.
- Class-native vocabulary used by the main driver (ltxdoc and `doc` with `xdoc2`): `\DocInput` (98), `\CheckSum` (1), `macrocode` and `macro` and `environment` and `option` and `instance` environments (246-254, 1545, 2702, 3591, 2921), `\DescribeMacro` `\DescribeEnv` (735, 876), `\changes` (1495), `\DoNotIndex` (133-159), `\StopEventually` and `\Finale` (1423, 4062), `\CodelineIndex` `\EnableCrossrefs` `\RecordChanges` (93-95), `\PrintChanges` `\PrintIndex` (99-100), `\SortIndex` (1506), `\cs` `\meta` `\marg` `\oarg`, and the `|...|` short verb.
- Class (the zip's own, used by tools/sourcedtx.dtx:4, tools/eemenu.dtx:4, examples/parsetcl.dtx:4, examples/pdf.dtx:4): `class.tclldoc` options: none, except `a4paper` (tools/eemenu.dtx:4). The class declares `a5paper` and `olddocinclude` as errors (tclldoc.dtx:3598-3603), forwards `notrawchar` to the package (3614-3616), passes every other option to `article` (3622-3623), reads `tclldoc.cfg` if present (3630), and loads `article` (3646). It also calls `\RequirePackage[dolayout]{tclldoc}` (3710), `\MakeShortTclverb{\|}` at `\begin{document}` (3719), `\CodelineNumbered` and `\DisableCrossrefs` (3755-3756), and sets `StandardModuleDepth` to 1 (3760). The package loads `xdoc2` with the class options and `docidx2e` (1512-1513).
- Class-native vocabulary used by the four other samples: `tcl` environment (tools/sourcedtx.dtx:24; defined at tclldoc.dtx:2708-2716), `tcl*` (2719-2728), `proc` and `variable` and `arrayvar` and `arrayentry` environments with `\setnamespace` (tclldoc.dtx:3048-3126, 2847-2852; tools/sourcedtx.dtx:28-30), `\describestring` (3155-3188; tools/sourcedtx.dtx:123), `\describeopt` (3208-3232), `\tclverb` and the `|...|` short verb (2749-2769, 2800-2820, 3719), `\word` (3545-3560), `\regopt` `\regstar` `\regplus` `\regalt` and `regblock` (3372-3374, 3504-3517, 3430-3455; examples/parsetcl.dtx:44), `regexp` as the old name of `regblock` (3463; examples/pdf.dtx:306), `\Tcllogo` (3577; tools/sourcedtx.dtx:17), `\TclInput` (2781-2791), `\settabsize` (2696-2697), `Cfunction` `Cvariable` `Ctype` (3292-3311), plus `doc`/`xdoc2` commands `\PageIndex` `\CodelineNumbered` `\IndexPrologue` (examples/pdf.dtx:5-11).
- Compatibility class `tcldoc` (the old name): `\LoadClass{tclldoc}` (3827), option `macinputenc` loads `rtkinenc` and redeclares OT1 text commands (3794-3797, 3887-3996), unsupported since v2.30 (1326-1327); no sample uses it.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class, main driver | tclldoc.dtx:24 | `class.ltxdoc` | no options |
| document class, other four drivers | tools/sourcedtx.dtx:4; tools/eemenu.dtx:4; examples/parsetcl.dtx:4; examples/pdf.dtx:4 | `class.tclldoc` | none; `a4paper` in eemenu |
| paper size | tools/eemenu.dtx:4; tclldoc.dtx:3622-3623 | `page.class-options` | `a4paper` forwarded to `article` |
| page geometry of `tclldoc.cls` | tclldoc.dtx:3656, 3666-3667, 3747-3750 | `page.setlength` | `\textwidth`=355pt; `\oddsidemargin` and `\evensidemargin` +20pt; `\marginparwidth` = `\evensidemargin` + 1in - `\marginparsep` - 1cm |
| list defaults of `tclldoc.cls` | tclldoc.dtx:3686-3701 | `sp.lengths` | on every `\@listi`..`\@listvi`: `\parsep`=0pt plus 1pt, `\itemsep` reduced by the old `\parsep`, `\listparindent`=1em |
| silent font-shape substitutions | tclldoc.dtx:3727-3734 | `font.nfss` | `\DeclareFontShape` OT1/cmtt/bx/n to cmtt/m/n, OMS/cmtt m and bx to cmsy, OT1/cmss/m/it to m/sl |
| math package | tclldoc.dtx:25 | `math.amsmath` | no options |
| documentation package stack | tclldoc.dtx:26 | `dtx.doc` | parameter `xdoc2`, option `dolayout`, date 2000/11/18, load guarded by `\IfFileExists` |
| doc switches and driver commands | tclldoc.dtx:93-100 | `dtx.doc` | `\CodelineIndex`, `\EnableCrossrefs`, `\RecordChanges`, `\DocInput`, `\PrintChanges`, `\PrintIndex` |
| documented-code blocks and margin headings | tclldoc.dtx:246-254, 735, 876, 1495-1496, 1423, 4062 | `dtx.doc` | `macrocode`, `macro`, `\DescribeEnv`, `\DescribeMacro`, `\changes`, `\StopEventually{...}`/`\Finale` |
| index and glossary layout values | tclldoc.dtx:87, 89-91 | `num.counters` | `IndexColumns`=2 (a `doc` counter); `\GlossaryParms` extended by `\hbadness=10000` (log only) |
| overfull-box warning threshold | tclldoc.dtx:88 | `sp.lengths` | `\hfuzz`=10pt (affects warnings only) |
| Tcl-code environments and namespaced markup (class vocabulary, other samples) | tclldoc.dtx:2708-2728, 3048-3126, 3155-3232, 3430-3455; tools/sourcedtx.dtx:24-30 | `dtx.doc` | parameter `tclldoc`: environment bodies are Tcl code (content); arguments are namespace and name strings; `\settabsize` integer 2-255 (2696-2697) |
| inline Tcl verbatim and short verb | tclldoc.dtx:2749-2769, 2800-2820, 3719 | `dtx.doc` | parameter `tclldoc`: `\tclverb`, `\tclverb*`, `\MakeShortTclverb{\|}` |
| title block | tclldoc.dtx:3-8; tools/sourcedtx.dtx:11-14 | `front.maketitle` | `\title`, `\author` with `\thanks`, `\date`, `\maketitle` |
| author note | tclldoc.dtx:4-6 | `front.thanks` | `\thanks{E-mail: ...}` |
| abstract | tclldoc.dtx:106-129 | `abs.kernel` | `abstract` environment |
| contents | tclldoc.dtx:131 | `toc.kernel` | `\tableofcontents` |
| headings | tclldoc.dtx:161, 192 | `head.kernel` | `\section`, `\subsection`, class numbering |
| verbatim and `\verb` | tclldoc.dtx:204-210, 300-322, 903 | `code.verbatim` | `verbatim` environment, `\verb`, `|...|` |
| quotes | tclldoc.dtx:384, 902 | `quote.kernel` | `quote` environment |
| bullet list; description and enumerate in samples | tclldoc.dtx:853; examples/parsetcl.dtx:62, 69 | `list.kernel` | `itemize`, `description`, `enumerate` |
| syntax-display list `isyntax` | tclldoc.dtx:77-85, 1172-1176, 1198-1201 | `list.kernel` | `\list{}{}` with `\parsep`=0pt plus 1pt, `\listparindent`=-1em, `\itemindent`=`\listparindent`, `\leftmargin`+1em, `\rightskip` plus 5cm (`sp.lengths`) |
| figures | tclldoc.dtx:271-330, 781-833 | `fig.graphicx` | `figure` float, no included graphic |
| figure captions | tclldoc.dtx:328, 831 | `cap.kernel` | `\caption` |
| figure contents: boxes, ragged text, math delimiters | tclldoc.dtx:783-828 | `box.minipage` | `minipage` 350pt/298pt/241pt/184pt with `flushleft`/`flushright` (`sp.ragged`) and `\left\lvert ... \right\rvert` (`math.amsmath`) |
| manual spacing | tclldoc.dtx:793, 805, 817, 1292, 1302 | `sp.manual-space` | `\smallskip`, `\medskip`, `\quad` |
| line-break hints in prose | tclldoc.dtx:751-753, 1028-1031, 1381 | `sp.hyphenat` | `\penalty0`, `\discretionary{}{}{}`, `\-` |
| inline marks | tclldoc.dtx:6, 58-60, 1399 | `mark.kernel` | `\textsf`, `\textit`, `\emph`, `\textsc`, `\texttt` |
| text symbols | tclldoc.dtx:868, 1267, 899 | `font.fontenc-t1` | `\textvisiblespace`, `\textperiodcentered`, `\textellipsis` |
| footnotes | tclldoc.dtx:338-341, 543-544 | `fn.kernel` | `\footnote` |
| labels and references | tclldoc.dtx:267, 329 | `xref.kernel` | `\label{Fig:procex}`, `\ref`, `\cite` |
| bibliography | tclldoc.dtx:1424-1485; examples/pdf.dtx:780-791 | `bib.thebibliography` | `{9}`, `\bibitem` entries |
| index | tclldoc.dtx:100, 1506 | `idx.makeidx` | `\PrintIndex`, `\SortIndex`; `makeindex` with `docindex.ist` as the sorting pass |
| index columns | tclldoc.dtx:2944-2959 | `cols.multicol` | `multicols{\c@IndexColumns}` inside the redefined `docindex` index instance |
| index page style | tclldoc.dtx:2951, 2957 | `hf.pagestyle-kernel` | `\pagestyle{docindex}` (style defined by `docidx2e`, not read; only with option `usedocindexps`, 2928) |
| marginal note stub | tclldoc.dtx:70 | `note.marginpar` | `\marginpar{\texttt{#1} option}` |
| `\href` stub in two drivers | examples/parsetcl.dtx:7; tools/eemenu.dtx:14 | `meta.hyperref` | `\href{url}{text}` |
| class counters | tclldoc.dtx:3760 | `num.counters` | `\setcounter{StandardModuleDepth}{1}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\package`, `\Tcl`, `\word` aliases | tclldoc.dtx:58-60 | yes | inline `\textsf{#1}` (`mark.kernel`), `T\kern-0.1em cl` (`mark.kernel`, `sp.manual-space`), `\mbox{$\{$\itshape#1\/$\}$}` (`mark.kernel`, `math.kernel`) |
| `\swtpc` | tclldoc.dtx:62-68 (used 1270, 1272) | yes | `\makebox[\fontdimen2\font]{\textperiodcentered}`: it measures one interword space and makes a box of that width holding a centred dot (`sp.manual-space`) |
| `option` and `instance` fallback environments | tclldoc.dtx:42-55 (used 2921, 3591-3592) | yes | defined only if `xdoc2` lacks them; each is a heading-less `\trivlist\item[]` (`list.kernel`) that resets the `doc` counter `\macro@cnt`; if `xdoc2` supplies the environments, omit |
| `\meta` robustness patch | tclldoc.dtx:28-41 | yes | omit: dead branch when `xdoc2` is loaded (line 26) |
| `\describeoption`, `\PrintChar`, `\DoNotIndexHarmless`, `\DoNotIndexBy` stubs | tclldoc.dtx:70-76 | yes | `\providecommand` fallbacks, each used only if `xdoc2` lacks the command; the margin note is `\marginpar{\texttt{#1} option}` (`note.marginpar`), the others are no-ops |
| `isyntax` environment | tclldoc.dtx:77-85 | yes | expand at each of its two uses to `\list{}{...}` with the five length settings in the map row (`list.kernel`, `sp.lengths`) |
| `\GlossaryParms` extension with `\hbadness`, and `\hfuzz` | tclldoc.dtx:88-91 | yes | raw TeX warning thresholds with no printed effect (`sp.lengths`); the hook itself is a `doc` command (`dtx.doc`) |
| `details` environment and `\detailitem` | tools/eemenu.dtx:17-31 (used 2436-2540) | yes | `description` (`list.kernel`) whose items print `\texttt{name}` and call `xdoc2`'s `\IndexEntry` with `\LevelSame` and `\LevelSorted` (`dtx.doc`); expand inline, writing the name with an escaped underscore |
| `\eemenu`, `\Alpha`, `\AlphaEight`, `\AlphaTk`, `\AlphaTcl`, `\TclAE`, `\package`, `\ParseTcl` aliases | tools/eemenu.dtx:6-12; examples/parsetcl.dtx:6 | yes | inline `\textsf`, `\textit`, `\Tcllogo` calls (`mark.kernel`, class vocabulary) |
| `tclldoc.cls`, `tclldoc.sty`, `tcldoc.cls`, `tcldoc.sty` source | tclldoc.dtx:1511-3578 (package), 3597-3761 (class), 3780-4052 (compat) | not bespoke | published on CTAN (ctan.org/pkg/tclldoc), so it is the `class.tclldoc` way and its `dtx.doc` package parameter; the code itself (catcode verbatim reader 1937-1993, line reboxing 2322-2405, `regblock` box counting 3430-3488) is irreducible TeX, recorded so a stricter reading can reuse it |

## Content-opaque
- Hand-built "visible tab" glyph in prose (tclldoc.dtx:869-871).
- Figure 1 mock output of a `proc` margin heading with `macrocode`, and figure 2 line-break illustrations in minipages (tclldoc.dtx:271-330, 781-833); figure content, though each part also maps to the boxes, maths and spacing ways above.
- The Tcl programs documented in the `tcl`, `proc` and `variable` bodies and in the `%<*pkg>` guarded lines (tools/sourcedtx.dtx:24-228; tools/eemenu.dtx; examples/parsetcl.dtx; examples/pdf.dtx), and the docstrip guard lines.

## Lib changes
- New ways proposed: none. The `tclldoc` package is held as a parameter of `dtx.doc` (the line says other package-documentation packages are the parameter, as for `hypdoc` and `codedescribe`), and `xdoc2` the same; W1 read at ctan.org/pkg/tclldoc and ctan.org/pkg/xdoc (both CTAN and TeX Live).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
