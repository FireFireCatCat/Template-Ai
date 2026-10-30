no

# 0364-objectionary-eolang-sty: eolang (LaTeX package for phi-calculus formulas and SODG graphs)

- Unverified: read from the source, not compiled.
- Source: Source/0364-objectionary-eolang-sty/ (origin: https://codeload.github.com/objectionary/eolang.sty/zip/refs/heads/master; licence: MIT, LICENSE.txt:1, eolang.dtx:3)
- Kind: misc (not a template: a CTAN package source with its documentation driver; no sample document has its own look)
- Lib: v3
- Engine: pdfLaTeX-compatible (the package also keys its temp directory by engine, `-xe` / `-lua`, eolang.dtx:804, 1126); every body construct needs `-shell-escape` and Perl (see Blockers)
- Look carried by: mixed (the documentation driver is class `ltxdoc` plus a preamble, eolang.dtx:37-56; the package's own notation and graph look is code in eolang.dtx:768-1990, a CTAN package, ctan.org/pkg/eolang read once: v0.26.4, MIT)
- Class origin: tex-distribution-unbundled (`ltxdoc` in the driver, eolang.dtx:37; `article` in testfiles/*.lvt)
- Main file: eolang.dtx (driver at lines 28-62: `\documentclass{ltxdoc}` at 37, `\begin{document}` at 57; the package code is the unprefixed lines, e.g. 768-1990) (other samples: testfiles/colorful.lvt, macros.lvt, nocolor.lvt, phiq.lvt, phiquation.lvt, sodg.lvt, testfiles/support/*.tex, and the `docshot` examples inside eolang.dtx, e.g. 93-106; the `.tlg` logs not read)
- Read: main yes, zip-local classes and styles none present (no `.cls` or `.sty` is shipped; `eolang.sty` is generated from the dtx by eolang.ins:30, and its code in eolang.dtx I read in full, 768-1990); also read eolang.pl, eolang.ins, build.lua, DEPENDS.txt, README.md, the testfiles; tests/*.pl only skimmed (Perl test scripts, not part of the look)

## Verdict
No. The zip is the source of a published notation package, not a template, and the package cannot be written as published ways with declarative parameters: its `phiquation` environment, `\phiq` and `sodg` hand the text to Perl scripts through `iexec` under `-shell-escape` (EXTERNAL), the Perl scripts and the catcode, cache and box-and-glue TeX around them are irreducible (BESPOKE), and the SODG graph look is TikZ code that defines the package's identity (ART). The documentation driver is otherwise ordinary (ltxdoc, biblatex, microtype, hyperref) and maps to lib ways, but it loads three small packages with no lib line.

## Blockers
- `EXTERNAL/package` `phiquation`, `phiquation*`, `\phiq` and `sodg` write their body to a temp file and run `perl` through `\iexec`; the author states `-shell-escape` and Perl are required, with a fallback only to files cached by an earlier run (eolang.dtx:72-75, 848, 1177-1192, 1243-1246, 1732-1745)
- `EXTERNAL/package` `iexec` is required at load: line 789 tests `\eolang@noshell`, but that flag is only set by the option processing at line 812, so by reading it loads before the option can take effect (eolang.dtx:789, 812); `noshell` itself only turns the failure into a missing-file one (eolang.dtx:457-459, 843-845, 1147-1148); DEPENDS.txt:7 lists `iexec` as hard
- `EXTERNAL/package` the companion script `eolang.pl` rewrites a `.tex` file outside TeX to inline the cached results (eolang.pl:51-132, eolang.1:7-9)
- `BESPOKE/package` two Perl programs embedded in the package and written to disk by `VerbatimOut`: the phi parser (regex rewriting, choice of `gathered`/`split`/`align` by counting indents and `&&`) and the SODG parser (vertex and edge commands, clone `+`, relative `xy:` placement, TikZ code generation) (eolang.dtx:927-1096, 1302-1575)
- `BESPOKE/package` hand-rolled TeX machinery: md5-hash file cache and `\eolang@ifabsent` conditionals (eolang.dtx:1131-1205), `\phiSaveTo`/`\sodgSaveTo` state with `\aftergroup` (1115-1116, 1202, 1705-1706, 1755), the active `$` redefinition and catcode switches (1209, 1216, 1236, 1249, 1260-1266, 1602, 1718, 1725, 1757), the counter protecting `FancyVerbLine` (865, 1204, 1593)
- `BESPOKE/package` glyph and box construction: `\phiDotted` clips and resizes arrows in a `\mathpalette` box (eolang.dtx:1888-1907), `\phiOset`/`\phiUset` place text with `\vbox to 0ex{\kern-2\ex@...}` (1840-1847)
- `ART/package` the SODG drawing look: `phicture` environment, `phi-object`/`phi-data`/`phi-atom`/`phi-marker`/`phi-box`/`phi-attr` node styles, the `phi-rho` snake-arrow decoration computed with `\tikzmath` and `atan2`, and the TikZ arrow drawn inside `\phiEvaluate` (eolang.dtx:1618-1696, 1955-1958)
- `UNMAPPED/preamble` `docshots` (options `runs=2,dtx`): renders each `docshot` example and embeds its snapshot beside the source; CTAN page read, it does not say how the snapshots are made, so no way can be justified (eolang.dtx:47, 93-106; `_docshots` is a build directory, build.lua:14)
- `UNMAPPED/preamble` `fail-fast`: makes the build fail on warnings; no printed effect, no lib line (eolang.dtx:40)
- `UNMAPPED/preamble` `href-ul`: a link-styling package of the same author, not read, not on any lib line (eolang.dtx:50)
- `BESPOKE/preamble` `\renewcommand{\RerunFileCheck}[3]{\AddToHook{enddocument/info}{#2}}` rewires a kernel diagnostic hook; no printed effect, but no lib way holds a kernel-hook redefinition (eolang.dtx:52)

## Class setting
- Class: `class.ltxdoc` options: none (eolang.dtx:37); the regression samples use `class.article` with no options (testfiles/phiq.lvt:5); the docshot examples show `article`, `acmart`, `standalone`, `minimal` as verbatim source (content, not template, e.g. eolang.dtx:94, 545, 202)
- Class-native vocabulary used: `\DocInput` (58), `\PrintChanges` (59), `\PrintIndex` (60), `\PageIndex` (53), `\EnableCrossrefs` (54), `\CodelineIndex` (55), `\RecordChanges` (56), `\DescribeMacro` and `\DescribeEnv` (108, 183), `\changes` (763), `macro` and `macrocode` environments (767-769, 815-829), `\StopEventually` (760), `\Finale` (1994), `\GetFileInfo` (24), `\DoNotIndex` (25), `\CheckSum` (6), `\CharacterTable` (8-22), the `|...|` short verbatim (e.g. 73; supplied by ltxdoc, which is not in the zip and was not read)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | eolang.dtx:37 | `class.ltxdoc` | no options |
| documentation source typesetting | eolang.dtx:6, 24-25, 53-60, 108, 760-769, 1994 | `dtx.doc` | `\PageIndex`, `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput{eolang.dtx}`, `\PrintChanges`, `\PrintIndex`, `\GetFileInfo`, `\DoNotIndex`, `\CheckSum` |
| encoding, fonts | eolang.dtx:38-39 | `font.fontenc-t1`, `font.lmodern` | `fontenc` option `T1`; `lmodern` |
| bibliography | eolang.dtx:41-42, 90, 1997 | `bib.biblatex-biber` | `maxnames=1`, `minnames=1`, `maxbibnames=1`, `natbib=true`, `citestyle=authoryear`, `bibstyle=authoryear`, `doi=false`, `url=false`, `isbn=false`; `\addbibresource{eolang.bib}`; `\printbibliography`; backend not set (biber is the default; DEPENDS.txt:15-16 lists biber as soft) |
| micro-typography | eolang.dtx:43-44 | `sp.microtype` | package loaded plainly; `\microtypesetup{protrusion=false}` run at the start of every `verbatim` through a kernel `\AddToHook{env/verbatim/begin}` wrapper |
| image in title | eolang.dtx:45, 65 | `fig.graphicx` | `\includegraphics[height=1in]{cactus.pdf}` (the PDF is shipped, cactus.pdf) |
| colour | eolang.dtx:46, 71, 825, 1926 | `color.xcolor` | `\color{red}` (warning), `\color{orange}` (terminals, anonymised text), `\color{red}` (operational arrows); both switched off by option `nocolor` (820-827, 1923-1927) |
| hyperlinks and metadata | eolang.dtx:49, 51, 73, 1767-1775 | `meta.hyperref`, `meta.bookmark` | `\PassOptionsToPackage{hyperindex=false}{hyperref}`; `bookmark` plain; `\href`; `\pdfstringdefDisableCommands{...}` mapping `\alpha`, `\varphi`, `\upalpha`, `\upvarphi` to words |
| title block | eolang.dtx:65-69 | `front.maketitle`, `front.thanks` | `\title`, `\author` with a `\texttt` e-mail, `\date{\filedate, \fileversion}`, `\maketitle`, `\thanks{... \href{...}{...}}` |
| warning paragraph | eolang.dtx:71 | `mark.kernel`, `color.xcolor` | `\textbf{\color{red}NB!}` |
| sectioning | eolang.dtx:86, 397, 470, 762 | `head.kernel` | `\section{...}` with the class's default look |
| lists | eolang.dtx:111, 150, 222 | `list.kernel`, `sp.lengths` | `itemize` with `\setlength\itemsep{0em}` |
| code and verbatim | eolang.dtx:404-406, 416-418 | `code.verbatim` | `verbatim` environments (wrapped in `%<*verb>` tags for docstrip) |
| page flow | eolang.dtx:1996, 1998 | `pg.break` | `\clearpage` around `\printbibliography` |
| math packages the package loads | eolang.dtx:768, 772, 777, 781 | `math.amsmath`, `math.amssymb`, `math.bm` | `amsmath` (`equation*`, `split`, `gathered`, `\xrightarrow`); `amssymb` after `\let\Bbbk\relax`; `stmaryrd` (`\llbracket`) filed under `math.amssymb`, `upgreek` (`\uprho`, `\upxi`, `\uplambda`, `\upalpha`, `\upvarphi`) filed under `math.bm`: closest homes, the lib lines name other packages (see Lib changes) |
| notation commands | eolang.dtx:1821-1822, 1830-1831, 1856-1857, 1865, 1875, 1937-1985 | `math.amsmath`, `math.amssymb`, `color.xcolor`, `mark.kernel`, `sp.manual-space` | aliases built from `\mapstochar`, `\leadsto`, `\xrightarrow`, `\Downarrow`, `\Rrightarrow`, `\Rightarrow`, `\sffamily\scshape`, `\\[-4pt]`, `\color`; reducible aliases (see Bespoke code) |
| name macros and anonymous mode | eolang.dtx:1777-1812 | `color.xcolor`, `mark.kernel` | `\eoAnon[alt]{text}` expandable switch on option `anonymous`; `\eolang`, `\phic`, `\xmir` set `{\sffamily EO}`, `\upvarphi`-calculus, `XMIR` |
| formula and graph environments | eolang.dtx:1208-1220, 1233-1250, 1717-1759 | `art.content-package` | `phiquation`, `phiquation*`, `\phiq`, `sodg` as a specialised notation package; the shell and Perl dependence is the EXTERNAL blocker above |
| SODG drawing | eolang.dtx:1600-1611, 1618-1696, 1955-1958 | `art.tikz` | `tikz` with libraries `arrows`, `shapes`, `decorations`, `decorations.pathmorphing`, `decorations.pathreplacing`, `positioning`, `calc`, `math`, `arrows.meta`; this is template-defining drawing, hence the ART blocker |
| regression samples | testfiles/phiq.lvt:5-7, 22-24 | `class.article` | `\usepackage[nocomments]{eolang}`; harness `\input{regression-test.tex}` is l3build's (testfiles/phiq.lvt:4), outside the template |
| package options | eolang.dtx:798-812 | none (package-internal) | `pgfopts`/`pgfkeys`: `tmpdir`, `nocomments`, `nodollar`, `nocolor`, `anonymous`, `noshell` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| phi parser in Perl | eolang.dtx:927-1096 | no | computes the equation form from the text and rewrites tokens by regex; outside TeX |
| SODG parser in Perl | eolang.dtx:1302-1575 | no | generates positioned TikZ nodes and edges from a line language, with clone expansion |
| `eolang.pl` post-processor | eolang.pl:51-132 | no | text rewriting of a `.tex` file outside TeX |
| file cache, `\eolang@process`, `\eolang@ifabsent`, `\hash` | eolang.dtx:1131-1205 | no | md5 and file-existence conditionals that drive what is read back |
| `phiquation`, `phiquation*`, `sodg` environments | eolang.dtx:1208-1220, 1717-1759 | no | `VerbatimOut` to a file, catcode `|` and `$` changes, `\input` of Perl output |
| `\phiq` and the active `$` | eolang.dtx:1233-1250, 1260-1266 | no | catcode and `\detokenize` handling; the dollar sign is turned active at `\begin{document}` |
| `\phiDotted` | eolang.dtx:1888-1907 | no | `\mathpalette`, `\sbox`, `\clipbox`, `\resizebox` assembly of a dotted arrow glyph |
| `\phiOset`, `\phiUset` | eolang.dtx:1840-1847 | no | `\mathop...\limits` with a zero-height `\vbox` and fixed `\kern` values |
| `\phiMany` | eolang.dtx:1856-1857 | no | composes the two items above |
| `\phiWave`, `\phiSlot`, `\phiEOL`, `\phiTerminal`, `\eolang@arrow`, `\eolang@sub` | eolang.dtx:1821-1822, 1830-1831, 1865, 1875, 1924-1937 | yes | `\newcommand` aliases of published math symbols with `\color` and `\\[-4pt]`; `\eolang@sub` uses `xstring` `\IfStrEq` (1231), a published conditional |
| `\phiNormalize`, `\phiDataize`, `\phiMorph`, `\phiContextualize` | eolang.dtx:1946, 1967, 1976, 1985 | yes | aliases `\leadsto`, `\Downarrow`, `\Rrightarrow`, `\Rightarrow` in red with an optional subscript |
| `\phiEvaluate` | eolang.dtx:1954-1958 | no | a `tikzpicture` inside `\vcenter{\hbox{...}}` to draw an arrow |
| `\eoAnon`, `\eolang`, `\phic`, `\xmir` | eolang.dtx:1777-1812 | yes | an option-driven conditional text switch; reducible to two strings per command when the option value is known to the emitter |
| `phicture` environment and `phi-*` TikZ styles | eolang.dtx:1618-1696 | no | `\tikzstyle` set plus `\tikzmath` decoration code that computes geometry |
| `\let\Bbbk\relax` | eolang.dtx:777 | yes | one compatibility line before `math.amssymb` |
| `\renewcommand{\RerunFileCheck}...` | eolang.dtx:52 | no | kernel hook rewiring (no lib way); no printed effect |
| `\AddToHook{env/verbatim/begin}{\microtypesetup{protrusion=false}}` | eolang.dtx:44 | yes | `sp.microtype` setup call inside a kernel hook |
| counter `eolang@lineno` | eolang.dtx:865, 1204, 1210, 1217, 1719 | no | saves and restores `FancyVerbLine` around the file-writing environments |

## Content-opaque
- Every `phiquation`, `\phiq` and `sodg` body in the examples and tests (eolang.dtx:97-104, 205-212, 384-386; testfiles/phiquation.lvt:20-68, testfiles/sodg.lvt:21-81): notation text and graphs, content of the package.
- The `docshot` example sources and their rendered snapshots (eolang.dtx:93-106 and the others between 186 and 758).
- `cactus.pdf` in the title (eolang.dtx:65): an image asset to ship.
- `eolang.bib` entries (eolang.bib:4-29): bibliographic data.

## Lib changes
- New ways proposed: none. Considered and not proposed: `eolang` itself as a way (it fails W3: one notation for one language, so it stays under `art.content-package`, and it fails W4 as an emitter target because it needs `-shell-escape` and Perl); `fail-fast` and `href-ul` (no printed effect or not read, so no argument could be made; recorded as UNMAPPED); `docshots` (how it works not established from the CTAN page).
- Lines to widen if the consolidator agrees: `math.amssymb` for `stmaryrd` (a symbol package) and `math.bm` for `upgreek` (an upright-Greek alphabet package); I used them as the closest homes rather than proposing a line.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
