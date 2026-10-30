no

# 0948-didec: didec package manual (the CTAN package `didec`, its `ltxdoc` manual and documentation style)

- Unverified: read from the source, not compiled.
- Source: Source/0948-didec/ (origin: https://mirrors.ctan.org/macros/latex/contrib/didec.zip; licence: lppl1.3, LPPL 1.3 per README.md:7-9 and the CTAN page)
- Kind: misc (the manifest hint says invoice; the only sample is the manual of an arithmetic package, a documentation file)
- Lib: v6
- Engine: pdfLaTeX-compatible (nothing needs XeLaTeX or LuaLaTeX; the build needs shell escape, see Blockers)
- Look carried by: mixed (class `ltxdoc` plus the zip-local style `didec.doc.sty`, which sets nearly all of the look, plus the sample's own title block; tcolorbox's documentation library draws the command and key boxes)
- Class origin: tex-distribution-unbundled
- Main file: didec.tex (other samples: none; `didec.pdf` is the author's compiled manual, a binary, not read)
- Read: main yes, zip-local classes and styles all (`didec.doc.sty` 1-160, `didec.sty` 1-1380; the sources of `ltxdoc`, `tcolorbox` and its documentation library are not in the zip and were not read)

## Verdict
No. The look is reducible: `didec.doc.sty` only loads published packages and sets their options, and every zip-local macro in it and in the sample reduces by inline expansion. The zip is blocked by the toolchain: `didec.doc.sty` loads `minted2` unconditionally (a Pygments, Python route; the author's own comment says it is "currently broken with Python 3.14"), and the manual runs a nested `pdflatex` from inside the document through tcolorbox's `run pdflatex`. Both need shell escape, so the document does not compile without a tool outside TeX. There is no `ART`: TikZ is loaded only as tcolorbox's skin engine.

## Blockers
- `EXTERNAL/package` `minted2` is loaded unconditionally and the tcolorbox `minted` library is switched on, and `listing engine=minted` is the engine of every example box (didec.doc.sty:65, didec.doc.sty:67, didec.doc.sty:105: `\RequirePackage{minted2}% minted currently broken with Python 3.14`). Ruling from the rubric: loaded unconditionally, so it counts even though the sample never calls `\inputminted`.
- `EXTERNAL/body` the benchmark block writes a file and compiles it with a nested `pdflatex` run (`tcbverbatimwrite` and `tcblisting` with `compilable listing`, `freeze pdf`, `run pdflatex`; didec.tex:268-277, didec.tex:355-365; the same `compilable listing` key sits in `fullexample`, didec.doc.sty:112-113). The numbers it prints are machine timings measured with expl3 `\benchmark:n` (didec.tex:290-294).
- No other blocker. If a reviewer rejects the one proposed way below, `didec.sty` itself would become `UNMAPPED/package`; the verdict stays `no` either way.

## Class setting
- Class: `class.ltxdoc` options: a4paper, 11pt (didec.tex:24); it is loaded unchanged; no `ltxdoc.cfg` in the zip.
- Class-native vocabulary used: the sample does not use the `doc` vocabulary (`macrocode`, `\DescribeMacro`, `\DocInput`, `\changes`); it uses `\makeindex`/`\printindex` (didec.tex:34, didec.tex:1247, here served by `imakeidx`), `\tableofcontents`, `\section`, `\footnote`, `\meta` (didec.tex:194), and the short verbatim form `|...|` (didec.tex:111, didec.tex:234; `ltxdoc` source not read, so that `\MakeShortVerb{\|}` comes from it is the usual behaviour, not checked).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | didec.tex:24 | `class.ltxdoc` | a4paper, 11pt |
| paper and size | didec.tex:24 | `page.class-options` | a4paper, 11pt |
| style file loaded | didec.tex:25 | (the zip-local `didec.doc.sty`, rows below) | `\usepackage{didec.doc}` |
| page geometry | didec.doc.sty:46-50 | `page.geometry` | a4paper, left=2.5cm, right=2.5cm, top=1.5cm, bottom=1.5cm, marginparsep=3mm, marginparwidth=18mm, headheight=0mm, headsep=0cm, footskip=1.5cm, includeheadfoot |
| header and footer | didec.doc.sty:51-56 | `hf.fancyhdr` | `\fancyhf{}`, `\fancyfoot[C]{\thepage}`, headrulewidth=0pt, footrulewidth=0pt, `\pagestyle{fancy}` |
| paragraph spacing | didec.doc.sty:34 | `sp.parskip-pkg` | load-only (`parskip`, no options) |
| line breaking | didec.doc.sty:57 | `sp.hyphenat` | raw `\tolerance=2000` (the parameter `\sloppy` sets; filed here by type, the lib has no raw-tolerance line) |
| line breaking | didec.doc.sty:58 | `sp.lengths` | `\setlength{\emergencystretch}{20pt}` |
| protrusion | didec.doc.sty:35-36 | `sp.microtype` | `\microtypesetup{nopatch=footnote}` |
| encoding | didec.doc.sty:32 | `font.fontenc-t1` | `[T1]{fontenc}` |
| text face | didec.doc.sty:34 | `font.lmodern` | load-only |
| language | didec.doc.sty:33 | `lang.babel` | english |
| quotation marks | didec.tex:67, didec.tex:1071, didec.tex:1081 | `lang.csquotes` | `\enquote` is used but defined nowhere in the zip and `csquotes` is not loaded by `didec.doc.sty`; the provider (probably the tcolorbox documentation library) was not verified |
| colour definitions | didec.doc.sty:37, didec.doc.sty:75-79 | `color.xcolor` | options svgnames, table; Green_Dark rgb(0.078431,0.407843,0.176471), Blue_Dark rgb(0.090196,0.211765,0.364706), Blue_Bright rgb(0.858824,0.898039,0.945098), Blue_Gray = blue!50!gray |
| coloured table rules | didec.doc.sty:37 | `tbl.colortbl` | `table` option of `xcolor` only; no `\rowcolor` or `\cellcolor` in the sample |
| links and metadata | didec.doc.sty:41; didec.tex:27-32 | `meta.hyperref` | bookmarks, raiselinks, pageanchor, hyperindex, colorlinks; pdftitle, pdfauthor, pdfsubject, pdfkeywords; `\phantomsection` at didec.tex:1246 |
| url face | didec.doc.sty:110; didec.tex:59-60 | `meta.url` | `\urlstyle{sf}`; `\url` and `\href` in the title block (didec.tex:57-60) |
| PDF backend parameter | didec.tex:36 | `meta.pdf-params` | `\pdfsuppresswarningpagegroup=1` (pdfTeX integer parameter) |
| index | didec.doc.sty:40; didec.tex:34; didec.tex:1247 | `idx.makeidx` | `imakeidx` with option `makeindex`, `\makeindex`, `\printindex` (the usual makeindex pass) |
| cross-references (loaded) | didec.doc.sty:39, didec.doc.sty:42 | `xref.varioref`, `xref.cleveref` | load-only; the sample never calls `\vref` or `\cref` (its links are `\refCom` and `\refKey`) |
| title block | didec.tex:46-62 | `box.tcolorbox` | enhanced, hbox, tikznode, left=8mm, right=8mm, boxrule=0.4pt, colback=white, colframe=Blue_Gray, drop lifted shadow=Blue_Gray!50, arc is angular, before=`\par\vspace*{5mm}`, after=`\par\bigskip`; around it `center` (`sp.ragged`), `\bfseries\LARGE` and `\large` (`font.size-commands`, `mark.kernel`), `\\[3mm]` `\medskip` `\bigskip` (`sp.manual-space`) |
| title block alignment | didec.tex:46, didec.tex:62 | `sp.ragged` | `center` environment |
| title block text size | didec.tex:51-52, didec.tex:54 | `font.size-commands` | `\LARGE`, `\large`, `\normalsize` |
| title block weight | didec.tex:51 | `mark.kernel` | `\bfseries` |
| title block spacing | didec.tex:50, didec.tex:57, didec.tex:63 | `sp.manual-space` | `\vspace*{5mm}`, `\bigskip`, `\medskip`, `\\[3mm]` |
| author note | didec.tex:54-57 | `fn.kernel` | `\footnote` in the author line |
| abstract | didec.tex:64-69 | `dtx.doc` | `absquote` environment (a tcolorbox documentation-library environment, not defined in the zip, source not read) holding a centred bold "Abstract" line |
| contents | didec.tex:71 | `toc.kernel` | `\tableofcontents` |
| contents indents | didec.doc.sty:29-30 | `toc.kernel` | `\l@subsection` = `\@dottedtocline{2}{1.5em}{2.7em}`, `\l@subsubsection` = `\@dottedtocline{3}{4.2em}{3.2em}` (kernel entry macro with level, indent, number width; `toc.tocloft` says the same with `\cftsubsecindent`, `\cftsubsecnumwidth`) |
| headings | didec.tex:75, didec.tex:174, didec.tex:421 | `head.kernel` | plain `\section`, default numbering and `ltxdoc` look |
| page breaks | didec.tex:74, didec.tex:173, didec.tex:260 | `pg.break` | `\clearpage` before most sections |
| lists | didec.tex:233-237, didec.tex:246-257, didec.tex:457-461 | `list.kernel` | `itemize` |
| footnote | didec.tex:195 | `fn.kernel` | `\footnote` inside running text |
| maths | didec.tex:198, didec.tex:218 | `math.kernel` | inline `$ ... $` with `\;` thin spaces, no `amsmath` |
| tables | didec.tex:128-134, didec.tex:298-345, didec.tex:1007-1011 | `tbl.tabular` | `tabular` with `lp{9cm}rr`, `lr`, `>{\ttfamily}l>{\ttfamily}c>{\ttfamily}c>{\ttfamily}c>{\ttfamily}c`; `\multicolumn`; `array` loaded (didec.doc.sty:34, didec.doc.sty:60) |
| table rules | didec.tex:128-133, didec.tex:1007-1011 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| table width (loaded) | didec.doc.sty:60 | `tbl.tabularx` | load-only; the sample has no `tabularx` |
| numbers in tables (nested document) | didec.doc.sty:63; didec.tex:284, didec.tex:293 | `mark.siunitx` | `siunitx` loaded for the benchmark table: `\tablenum[table-format=4.0]{..}\,\unit{\micro\second}` (inside the nested document, so content of the benchmark block) |
| dummy text (loaded) | didec.doc.sty:61 | `draft.todo` | `lipsum` loaded, never called |
| minipage-like box (loaded) | didec.doc.sty:43 | `box.minipage` | `varwidth` loaded, never called in the main file |
| tcolorbox loaded | didec.doc.sty:66-67 | `box.tcolorbox` | libraries skins, minted, breakable, documentation, raster; `skin=enhanced` (didec.doc.sty:81) |
| raster of boxes | didec.tex:355-365 | `box.tcolorbox` | `tcbraster` with `raster column skip=0pt` (raster library) |
| inline code box (declared, unused) | didec.doc.sty:115-119 | `box.tcolorbox` | `\DeclareTotalTCBox{\myverb}{ O{} v }`: tile, fontupper=`\ttfamily`, nobeforeafter, tcbox raise base, boxsep=0.5mm, boxrule=0.3mm, colback=yellow!10, borderline horizontal={0.3mm}{0pt}{red!50}; no use of `\myverb` in the sample |
| example boxes | didec.tex:82-84, didec.tex:95-97, didec.tex:113-167; didec.doc.sty:95-108 | `code.tcblisting` | style `docexample`: bicolor, arc=0.66mm, boxrule=0.33mm, fonttitle=`\bfseries`, fontlower=`\footnotesize`, colframe=Blue_Gray, colback=Blue_Gray!5!white, colbacklower=white, drop small lifted shadow, `listing engine=minted`, `documentation minted options={tabsize=2,fontsize=\small,breaklines,autogobble}`, `documentation minted style=colorful`, before skip=4pt plus 2pt minus 1pt, after skip=8pt plus 4pt minus 2pt (didec.doc.sty:91-94); environments `dispListing`, `dispExample`, `dispExample*{breakable}` (their definitions are not in the zip) |
| compiled listing | didec.doc.sty:112-113; didec.tex:269-277 | `code.tcblisting` | `listing and comment`, `pdf comment`, `freeze pdf`, `compilable listing`, `run pdflatex` (**EXTERNAL**, see Blockers) |
| highlighter | didec.doc.sty:65, didec.doc.sty:67, didec.doc.sty:105 | `code.minted` | `minted2`, tcolorbox `minted` library (**EXTERNAL**, see Blockers) |
| short verbatim | didec.tex:111, didec.tex:234 | `code.verbatim` | `\|...\|` short verbatim; `tcbverbatimwrite` at didec.tex:268 writes a file |
| documentation commands and keys | didec.tex:190-205, didec.tex:373-386, didec.tex:902-920; didec.doc.sty:81-87, didec.doc.sty:127-136, didec.doc.sty:139-150 | `dtx.doc` | tcolorbox `documentation` library as the parameter: environments `docCommands`, `docPackageOptions`, `docDidecKeys` (made by `\tcbmakedocSubKey(s)[doc key prefix=,index key formatter=\formatPackageOption(s)]{name}{didec}`), keys `doc name`, `doc parameter`, `doc description`, `doc new`, `doc updated`; `doc head={colback=yellow!10!white,interior style=fill}`, `doc head key={colback=magenta!5!white,interior style=fill}`, color key=DarkViolet, color value=Teal, color color=Teal, color counter=Orange!85!black, color length=Orange!85!black, index colorize, index annotate; deprecation styles `deprecated*` and `deprecated` (black!1!white, black!3!white, black!80!white, black!60!white); inline `\refCom` `\refKey` `\docValue` `\docColor` `\docAuxCommand` `\marg` `\oarg` `\brackets`; labels `\tcbdocnew`, `\tcbdocupdated` recoloured (didec.doc.sty:121-122, `green!50!black`, `blue!75!black`, `\sffamily\bfseries`) |
| colour swatch helper | didec.doc.sty:152-160; didec.tex:1043-1045 | `sp.rule` | `\docColorExample{c}` = colour group, `\rule[-1mm]{5mm}{4mm}`, `~`, `\docColor{c}` (colour by `color.xcolor`, label by `dtx.doc`) |
| the documented package | didec.doc.sty:69-73; didec.tex:38-40, didec.tex:85-165, and every example | `NEW:mark.didec` | `\usepackage{didec}` options `int` or `fp` (didec.sty:29-43); `\didecnew` `\didecset` `\didecsub` `\didecuse` `\dideccoluse` `\dideccolinvuse` `\didecformat`; `\didecsetup{currency={\pounds}{}, currency-negative=, decimal-separator, grouping-separator, german|english|french|float, color-positive, color-negative, rounding}` (didec.sty:900-969, didec.sty:1325) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\version`, `\def\datum` | didec.doc.sty:24-25 | yes | string macros; expand inline (1.2.1, 2026/06/01) in the title block, didec.tex:52 |
| `\IfFileExists{didec.doc.cfg}` and `\ifdefined\didecpackageprefix` | didec.doc.sty:27, didec.doc.sty:69-73; didec.tex:278 | yes | author-side hook; the cfg file is not in the zip, so only the fallback applies: `\RequirePackage{didec}` |
| `\l@subsection`, `\l@subsubsection` redefinition | didec.doc.sty:29-30 | yes | `toc.kernel` entry indents, or `toc.tocloft` lengths, values in the map |
| `\tcbset{...}` styles `docexample`, `beforeafter example`, `deprecated`, `deprecated*` | didec.doc.sty:81-109, didec.doc.sty:139-150 | yes | key lists of `code.tcblisting`, `dtx.doc`; values in the map |
| `\newtcblisting{fullexample}` | didec.doc.sty:112-113 | yes | `code.tcblisting` keys; not used in the sample |
| `\DeclareTotalTCBox{\myverb}` | didec.doc.sty:115-119 | yes | `box.tcolorbox`; not used in the sample |
| `\renewcommand*{\tcbdocnew}`, `{\tcbdocupdated}` | didec.doc.sty:121-122 | yes | `\textcolor` and font switches |
| `\formatPackageOption(s)` | didec.doc.sty:124-125 | yes | two string aliases ("package option", "Package options") |
| `\tcbmakedocSubKey(s)` declarations | didec.doc.sty:127-136 | yes | published tcolorbox documentation commands with key lists (`dtx.doc`) |
| `\docColorExample` (expl3) | didec.doc.sty:152-160 | yes | colour group + `\rule` + `\docColor`; expand inline at didec.tex:1043-1045 |
| `householdbook` environment, `\transaction` command | didec.tex:126-149 | yes | `householdbook` is `tabular` with `booktabs` rules; `\transaction` has a star branch that picks which didec variable is reduced (didec.tex:143-145), so each call expands inline into fixed `\didecset`/`\didecsub` lines plus a table row; this is example text inside a `dispExample*` box |
| `\didec_benchmark:n` (expl3, uses `\benchmark:n`) | didec.tex:290-294 | no | runs inside the nested document compiled by a second `pdflatex`; it prints measured times, so it is the `EXTERNAL/body` blocker and its output is content-opaque |
| `didec.sty` (expl3 arithmetic and formatter) | didec.sty:21-1380 | not bespoke | published on CTAN, TeX Live and MiKTeX (the zip is the package's own release, so W1 holds); its code (a cent-integer or `fp` store, digit-grouping `\if_case:w` formatter at didec.sty:497-534 and didec.sty:569-607, a number scanner at didec.sty:640-693) stays inside the proposed way. Under a stricter reading that treats it as zip-local, the formatter is irreducible; no verdict changes |

## Content-opaque
- Compiled example outputs next to every `dispExample` (didec.tex:95-1239); they show amounts computed by `didec`.
- The benchmark table of machine timings (didec.tex:298-345) and the nested document that produces it (didec.tex:278-351).
- The running-balance table of the `householdbook` example (didec.tex:157-165): cell values are computed by `didec`.

## Lib changes
- New ways proposed: `NEW:mark.didec` `didec` (CTAN, TeX Live, MiKTeX, LPPL 1.3; T. F. Sturm; v1.2.1; expl3; the CTAN page names no engine and the code read has no engine-specific part, `\NeedsTeXFormat{LaTeX2e}[2023-11-01]` at didec.sty:21): fixed-point two-decimal currency values; `\usepackage[int|fp]{didec}`, preamble `\didecsetup{keys}`, declarations `\didecnew{var}`, setters `\didecset` `\didecsetequal` `\didecsetnegative` `\didecsetfp` `\didecsetsum`, arithmetic `\didecadd` `\didecsub` `\didecmulfp` `\didecdivfp`, printers `\didecuse` `\dideccoluse` `\dideccolinvuse` `\didecformat` `\dideccolformat` `\dideccolinvformat`, conditionals `\didecifpositive` `\didecifnegative` `\didecifzero` `\didecifgreaterthan` `\dideciflowerthan` `\didecifequal`, `\didecwrite`; engine pdf. W1: CTAN, LPPL 1.3, public manual. W2: the kernel is the option `int` or `fp`; format keys are strings, colours and a closed rounding choice (`half-away-from-zero`, `half-to-even` and synonyms); amounts are values. W3: any bookkeeping, invoice or price amount in any currency. W4: preamble `\usepackage` and `\didecsetup`, body `\didecformat[keys]{value}` wraps one number. Kept apart from `mark.siunitx` (prints a number, no variable store, no arithmetic) and `tbl.calctab` (a table environment); if the consolidator prefers, it can be a section of `mark.siunitx` with the package as the parameter, as `numprint` is.
- Considered, not proposed: `grffile`, `xfp`, `incgraph` (loaded at didec.doc.sty:62, didec.doc.sty:63, didec.doc.sty:43; no printed effect in the sample, so no component, as the v4 ruling on load-only packages).
- Notes: no text addressed to an AI was found in the zip. The `dtx.doc` rows use that line's wording "other package-documentation packages are the parameter" for the tcolorbox documentation library; `dispExample`, `absquote`, `\refCom` are assumed to come from it, which was not verifiable here.
