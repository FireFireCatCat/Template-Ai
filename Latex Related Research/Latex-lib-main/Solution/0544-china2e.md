yes

# 0544-china2e: china2e (Chinese calendar symbols, a short font report)

- Unverified: read from the source, not compiled.
- Source: Source/0544-china2e/ (origin: https://mirrors.ctan.org/macros/latex/contrib/china2e.zip; licence: nosell, CTAN lists "Do Not Sell Except by Arrangement"; china2e.sty:7-20 allows unchanged copies only and no sale)
- Kind: misc (a font-package manual; the manifest hint "calendar" is wrong, the sample is a documentation report, chinadoc.tex:1-448)
- Lib: v4
- Engine: pdfLaTeX-compatible (OT1 family `chin`, china2e.sty:43-44; the glyphs come from a METAFONT face, so the TeX system must run `mf` to make bitmaps, see Verdict)
- Look carried by: mixed (the page and text look is the sample's own preamble on `article`, chinadoc.tex:1-6; the symbol glyphs and their commands come from the published package china2e.sty plus the METAFONT face china10.mf/china10.tfm shipped in the zip)
- Class origin: tex-distribution-unbundled
- Main file: chinadoc.tex (other samples: none; readme.txt:51-53 only quotes a three-line example inside prose, and chinadoc.ps is the dvips output of chinadoc.tex, `%%Title: chinadoc.dvi`, not source)
- Read: main yes, zip-local classes and styles all (china2e.sty is the only .sty; there is no .cls, .def, .cfg or .clo; the METAFONT sources china10.mf read in full, chinasym.* outlined only, chinadoc.ps header only)

## Verdict
yes. The sample is kernel `article` at 12pt with raw length settings and kernel constructs, plus one non-kernel package, `china2e`, which is on CTAN (macros/latex/contrib/china2e, maintainer Udo Heyl), so it passes W1 and is a way (`font.icons`, the package as parameter, like `marvosym`) and not bespoke code. An emitter writes `\usepackage{china2e}` and its commands as inline content; its own counters and range checks (china2e.sty:49-75) are the package's internals and are not copied. The three body macros of the sample reduce by inline expansion, and the `tabbing` environment needs one new way (`tbl.tabbing`). Two risks are recorded, not counted as blockers: the face exists only as METAFONT source plus a TFM (china10.mf:44-76), so pdfTeX needs the TeX system's own `mktexpk`/`mf` pass for bitmaps (a TeX-system program like bibtex or makeindex, so not `EXTERNAL`; if the compile service cannot run it the glyphs would be missing, a shipped-asset problem), and the nosell licence limits redistribution.

## Blockers
none

## Class setting
- Class: `class.article` options: `12pt` (chinadoc.tex:1)
- Class-native vocabulary used: `\section` (chinadoc.tex:31), `\footnote` (chinadoc.tex:393), `table` with `\caption` (chinadoc.tex:326-327), `center`, `itemize` (chinadoc.tex:43-52), `\thispagestyle{empty}` (chinadoc.tex:10); no `\maketitle`, no `abstract`, no `\tableofcontents`, no bibliography.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | chinadoc.tex:1 | `class.article` | 12pt |
| type size by class option | chinadoc.tex:1 | `page.class-options` | 12pt |
| page geometry | chinadoc.tex:4-5 | `page.setlength` | `\textwidth6in`, `\textheight9in`, `\topmargin-.5in`, `\oddsidemargin.3in` |
| paragraph shape | chinadoc.tex:5 | `sp.lengths` | `\parindent0pt` |
| line breaking and hyphenation | chinadoc.tex:4, 6 | `sp.hyphenat` | `\sloppy`; `\hyphenation{chi-na-sym}` |
| symbol and calendar-glyph package | chinadoc.tex:2; china2e.sty:41-42, 69-75, 80-104, 109-128, 133-158 | `font.icons` | package=china2e, no options; commands `\TerrEle{n}` `\AstrEle{n}` `\MoonSta{n}` `\MoonPha{n}` (integer 1..12, 1..10, 1..28, 1..4), `\Year` `\Month` `\Day`, Chinese numerals `\One`..`\Ninety`, `\symA`..`\symZ`, `\Euro` `\Pound` `\Telephone` `\Postbox` `\Greenpoint`; `\uchr<n>` prints font code n (chinadoc.tex:393-394) |
| glyph face declaration (inside the package) | china2e.sty:43-47 | `font.nfss` | `\DeclareFontFamily{OT1}{chin}{}`, `\DeclareFontShape{OT1}{chin}{m}{n}{<-> china10}{}`, `\usefont{OT1}{chin}{m}{n}` |
| block-letter face for running text | china2e.sty:48; chinadoc.tex:35, 209-224, 233-237, 396 | `font.display` | package=china2e, switch `\BLOCK` (upper-case letters, digits and stops only, chinadoc.tex:236-237) |
| math symbols from the face (inside the package) | china2e.sty:164-174; chinadoc.tex:255-261, 276-282 | `font.nfss` | `\DeclareSymbolFont{numbers}{OT1}{chin}{m}{n}`, ten `\DeclareMathSymbol` (`\Real` `\Natural` `\Integer` `\Rational` `\Complex` and the upper-case bold variants) |
| display and inline maths | chinadoc.tex:12, 255-261, 276-282, 318 | `math.kernel` | `eqnarray*` with `&\in&` columns, `$14^{th}$`, `\ldots`, `\nearrow`, `\lambda_{\odot}` |
| bold maths version | chinadoc.tex:275, 283 | `mark.kernel` | `\boldmath` ... `\unboldmath` (kernel math-version switch) |
| page style | chinadoc.tex:10 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` on page 1; later pages keep `article`'s default `plain` |
| hand-made title line (no `\maketitle`) | chinadoc.tex:11-12 | `mark.ulem` | kernel `\underline{...}` (same type as underline; no package needed); with `font.size-commands` (`\LARGE`), `sp.manual-space` (`\\[1ex]`), `mark.kernel` (`\sc`) |
| address frame | chinadoc.tex:13-29 | `box.fancybox` | `\fbox{...}` around `\parbox{6in}{...}` (`box.minipage`); inner `center` is `sp.ragged`; `\it` is `mark.kernel` |
| closing address frame | chinadoc.tex:436-446 | `box.minipage` | `\fbox{\parbox[b]{4in}{\vbox{\hbox{..}\hbox{..}...}}}`; the four `\hbox` lines reduce to a parbox with `\\` breaks; `\hfill` is `sp.manual-space` |
| section headings | chinadoc.tex:31, 40, 72, 185, 239, 293, 311, 382 | `head.kernel` | `\section` at `article` defaults, no renewcommand; some titles hold `\Chinasym` and `\Thousand\Year\Book` |
| bulleted list | chinadoc.tex:43-52 | `list.kernel` | `itemize` |
| verbatim text | chinadoc.tex:47, 60-64, 101-110, 212-218, 228-231, 246-254, 264-274, 285-289 | `code.verbatim` | `verbatim`, `\verb/.../` |
| tab-stop tables (five) | chinadoc.tex:78-97, 113-134, 136-167, 187-207, 403-426 | `tbl.tabbing` | `tabbing`, stops from a `\kill` row of `\hspace{1.5in}` `\hspace{.8in}` (chinadoc.tex:79), `\=` `\>` `\\*` |
| glyph code table | chinadoc.tex:299-309 | `tbl.tabular` | `tabular` colspec `{\|r\|lllll\|lllll\|}`, `\hline`, 26 rows of a code cell and ten `\Large\uchr` cells |
| table float and caption | chinadoc.tex:326-367 | `tbl.tabular` | `table[ht]`, colspec `{\|l\|rr\|rr\|rr\|rr\|rr\|\|l\|}`, `\multicolumn{2}{\|c}` (kernel), `\hline\hline`; `\caption` at 327 is `cap.kernel` |
| footnote | chinadoc.tex:393-397 | `fn.kernel` | `\footnote{...}` holding `\label{foot}` |
| cross references | chinadoc.tex:183, 293, 311, 391, 398 | `xref.kernel` | `\label`, `\ref`, `\pageref` |
| type sizes | chinadoc.tex:11, 295, 401-426 | `font.size-commands` | `\tiny` ... `\Huge`, `\LARGE`, `\Large`, `\small` |
| font switches | chinadoc.tex:12, 16, 80, 301, 317, 370, 380 | `mark.kernel` | `\sc`, `\bf`, `\it`, `\sf` (chinadoc.tex:55) |
| manual spacing | chinadoc.tex:11, 79, 175, 436 | `sp.manual-space` | `\\[1ex]`, `\hspace{..}`, `\hspace*{1in}`, `\hfill` |
| TeX logos | chinadoc.tex:33, 55 | `font.icons` | kernel `\LaTeX` (as `\LaTeX2e`) and `\TeX` (logo-printing commands, same type as `hologo`); `\Chinasym` (china2e.sty:177-179, used at chinadoc.tex:11, 31) is the package's own logo, a command of the same way |

Not used by the sample: `\maketitle`, abstract, contents, colour, bibliography, index, theorems, code listings, headers or footers beyond the kernel page style, fonts other than the face above.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\hl` | chinadoc.tex:294 | yes | alias for `\hline &0&1&...&9\\ \hline`; expand inline at chinadoc.tex:303, 305 into a header row of digits between two `\hline`s (`tbl.tabular`) |
| `\newcommand{\tF}[1]` | chinadoc.tex:295 | yes | alias for `\Large\uchr#1`: `font.size-commands` plus the package command `\uchr` (`font.icons`), expanded in each cell |
| `\newcommand{\chiline}[1]` | chinadoc.tex:296-298 | yes | alias for one table row: a math cell `$#10$` and ten `\tF` cells (`#1` pasted to a digit); no loop or counter, 25 explicit calls at chinadoc.tex:302-306 (the 26th row, codes 250 to 255, is typed out at chinadoc.tex:307), expanded into explicit rows of `tbl.tabular` |
| `\vbox{\hbox..}` stack | chinadoc.tex:439-444 | yes | four lines of text boxed by `\fbox{\parbox}`: `box.minipage` with `\\` breaks (content only, no box-and-glue algorithm) |
| `china2e.sty` macros (`\chiprt`, `\chincorr`, counters `\chinarg` `\upperlimit` `\prtarg`, redefined `\AE` `\OE` `\UE` `\vdots`) | china2e.sty:49-75, 147, 159 | not bespoke | published on CTAN, so a way (`font.icons`), loaded not copied; the range checks, error messages and the kernel-macro overrides are the package's behaviour, which the sample relies on at chinadoc.tex:203-205 and 154 |

## Content-opaque
- METAFONT glyph programs: china10.mf runs six glyph files (china10.mf:59-69; `.ele`, `.num`, `.sta` twice, at offsets 0 and 128 with thinner pens) with pens at china10.mf:51-57; chinasym.add, .ele, .num, .sta, .alf, .sbl hold 194 `beginchar` programs (counts 32, 22, 12, 28, 65, 35): a font program shipped as an asset and chosen through `font.nfss`; not template code and not `ART` (no picture placed by the template). Only the outlines and the first glyph blocks of chinasym.add and chinasym.ele were read.
- The glyph code table (chinadoc.tex:299-309), the 60-year cycle table (chinadoc.tex:326-367) and the `eqnarray*` content (chinadoc.tex:255-261) are cell and formula content.

## Lib changes
- New ways proposed: `tbl.tabbing` the LaTeX kernel `tabbing` environment (pdfLaTeX-compatible): `\begin{tabbing} ... \= ... \> ... \kill ... \\* ... \end{tabbing}`, tab stops set by a first row of `\=` marks, usually a `\kill` row of `\hspace{len}` boxes, then `\>` rows. W1: a kernel environment. W2: behaviour is chosen by the stop widths (lengths) and the `\\*` no-break marker, not by extending code. W3: serves any text aligned on tab stops, not one document. W4: a body wrapper environment around the node's rows, with the stop row as its first line. Not `tbl.tabular` (that needs a column spec and puts intercolumn padding between columns; `tabbing` has neither), not `tbl.nicematrix`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
