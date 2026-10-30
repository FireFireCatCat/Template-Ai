no

# 0469-latex-brochure: The LaTeX Brochure (Peter Flynn, Silmaril Consultants; 4-page A4 flyer, folds from A3)

- Unverified: read from the source, not compiled.
- Source: Source/0469-latex-brochure/ (origin: https://mirrors.ctan.org/info/latex-brochure.zip; licence: lppl)
- Kind: misc (advertising brochure/flyer; manifest category `advert`)
- Lib: v4
- Engine: pdfLaTeX-compatible (`build:19` runs `pdflatex brochure`; `utf8x` needs the `ucs` bundle; the text only mentions XeLaTeX, brochure.tex:209)
- Look carried by: mixed (zip-local brochure.sty carries geometry, fonts, colours, list labels and bibliography; the page layout is a grid of `tabular` cells in the body; one logo macro is in the sample preamble, brochure.tex:6-7)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip)
- Main file: brochure.tex (other samples: none; brochure.sty is the only zip-local style)
- Read: main yes, zip-local classes and styles all (brochure.sty 118 of 118 lines; also README, `build`, brochure.bib head, index.html head)

## Verdict
No. Almost everything reduces to published ways: the class is plain `article`, and the style file is mostly `\usepackage` lines plus `\newcommand` aliases. Two things stop a `yes`. `\bulletrule` (brochure.sty:62-73) is hand-built leaders over a glyph box with computed widths, which `sp.rule` rules bespoke; it is defined but never called by brochure.tex, yet it sits in a style file the sample loads, so it is in scope. The serif and sans faces come from `warnock` and `aller` (brochure.sty:34-35), which are not in the zip, and whose ctan.org/pkg pages returned 404, so W1 is not shown. The shell script `build` (pdf2ps, pstops, ps2pdf, and a `sed` that swaps `a4paper` for `letterpaper` in brochure.sty, build:27-31) makes the A3 and Ledger folded copies; it sits outside class, preamble and body, the A4 document needs only pdflatex and bibtex, so it is noted here and not scored.

## Blockers
- `BESPOKE/class` `\bulletrule`: `\xleaders` over `\hbox to\bulletrulewidth{\hfil\CircleSolid\hfil}` inside `\hbox to\bulletrulesize`, widths from `\divide`/`\addtolength` (brochure.sty:62-73); not called in brochure.tex (grep: only brochure.sty:62-71), but in a loaded style file
- `UNMAPPED/preamble` `warnock` (default) and `aller` (default): not shipped, not on CTAN by the pages read (ctan.org/pkg/warnock and ctan.org/pkg/aller: HTTP 404), the file's own comment calls luximono "in the standard distribution" and says nothing of the other two (brochure.sty:34-37); the way (`font.serif-pkg`, `font.helvet`) exists, W1 of the package is not shown, font files not shipped

## Class setting
- Class: `class.article` options: `fleqn` (brochure.tex:1); paper size and margins come from `geometry`, not the class (brochure.sty:13-14)
- Class-native vocabulary used: `\subsection`, `\subsection*`, `\subsubsection`, `\subsubsection*` (no `\section`, no `\maketitle`, no `abstract`); `\refname`; `thebibliography` (redefined at brochure.sty:79-96)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | brochure.tex:1 | `class.article` | fleqn |
| input encoding | brochure.sty:1 | `font.fontenc-t1` | inputenc utf8x |
| font encoding | brochure.sty:2, 16 | `font.fontenc-t1` | fontenc T1; textcomp |
| page geometry | brochure.sty:13-14 | `page.geometry` | a4paper, left=15mm, right=15mm, nohead, nofoot, top=10mm, bottom=10mm (Letter copy: `sed` at build:27) |
| header/footer, page numbers | brochure.sty:58 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| colour | brochure.sty:15, 39, 42, 69; brochure.tex:13, 17, 278-281, 295 | `color.xcolor` | svgnames; DarkBlue, DarkGreen, MidnightBlue, Brown, ForestGreen, SpringGreen, Lavender, LightGoldenrod |
| serif text face | brochure.sty:34 | `font.serif-pkg` (W1 of the package not shown, see Blockers) | package `warnock`, option `default` |
| sans text face | brochure.sty:35 | `font.helvet` (W1 of the package not shown) | package `aller`, option `default` |
| mono text face | brochure.sty:37; used brochure.tex:532, `\url` | `font.mono` | `luximono`, scaled=.87 |
| any-size CM fonts | brochure.sty:17 | `font.exscale` | `type1cm` (load-only, same type as `fix-cm`) |
| blackletter | brochure.sty:17, 40, 60; brochure.tex:463 | `font.display` | `oldgerm`, `\frakfamily` |
| symbol and logo glyphs | brochure.sty:17, 71, 76; brochure.tex:55, 58, 208, 228, 460, 603 | `font.icons` | `bbding` (`\SquareCastShadowBottomRight`, `\CircleSolid`), `mflogo` (`\MF`, `\MP`) |
| font declaration | brochure.sty:23-28 | `font.nfss` | `\DeclareFontFamily{U}{logo}`, `\DeclareFontShape{U}{logo}{m}{n}` mapping sizes to `logo10` (mflogo scaling bodge) |
| initial and light series | brochure.sty:38, 49; brochure.tex:442 | `font.nfss`, `font.family-default` | `\fontencoding{U}\fontfamily{yinit}\selectfont`; `\fontseries{l}`; `\def\bfdefault{m}` |
| sizes | brochure.tex:17, 22, 35, 193, 353, 392, 542, 603 | `font.size-commands` | `\fontsize{80}{0}`, `{16}{18}`, `{7.25}{8}`, `{11}{13}`, `\fontsize89`, `\fontsize56`; `\Huge`..`\tiny` |
| line and word spacing | brochure.sty:41-42 | `sp.linespread`, `sp.lengths`, `sp.frenchspacing` | `\baselinestretch` .5; `\spaceskip=2pt plus.5pt minus.5pt`; `\frenchspacing` |
| drop capital | brochure.sty:47; brochure.tex:91 | `sp.lettrine` | `\lettrine[lines=3]{I}{f}` |
| alignment | brochure.sty:17, 43; brochure.tex:144, 297, 338 | `sp.ragged` | `\raggedleft`, `\RaggedRight`, `\raggedright`, `\centering`, `\flushright` |
| hyphenation | brochure.sty:59, 89 | `sp.hyphenat` | `\hyphenation{...}` word list; `\sloppy` |
| widow/club penalties | brochure.sty:90-92 | `sp.penalties` | `\clubpenalty` 4000, `\widowpenalty` 4000 |
| rules | brochure.tex:19-20, 348, 408, 269 | `sp.rule` | `\hrule`, `\hrule height3pt`, `\vrule depth.5pc width0pt` (strut) |
| manual spacing | brochure.tex:16, 19-27, 144, 203, 449, 452; brochure.sty:60 | `sp.manual-space` | `\vspace*{7pt}`, `\vfill`, `\bigskip`, `\medskip`, `\raisebox{-55pt}`, `\linebreak`, `\\[4pt]`, `\thinspace`, `\llap`/`\rlap` |
| paragraph and list lengths | brochure.tex:139, 141, 257, 352, 374, 409, 471 | `sp.lengths` | `\leftmargini` 12pt/14pt, `\parindent` 1em, `\parskip` 2pt, 0pt, `1em minus.75em` |
| page breaks | brochure.tex:130, 255, 433 | `pg.break` | `\clearpage` (4 pages) |
| columns | brochure.tex:257-346, 350-432 (nested at 352-365), 470-600 | `cols.multicol` | `multicols` {3}, {2}, nested {2}; `\columnbreak` (358, 391, 541); `\columnsep` 2em (470) |
| page layout grid | brochure.tex:9-25, 29-128, 137-238, 441-468 | `tbl.tabular` | `array` columns `p{}` `b{}` `|` `@{}` `>{..}`, widths as fractions of `\columnwidth`, `\tabcolsep` .02\columnwidth (137); title block is a tabular, no `\maketitle` |
| data tables | brochure.tex:275-299, 504-512, 531-539, 549-564 | `tbl.tabular`, `tbl.colortbl`, `tbl.multirow` | `\columncolor{SpringGreen}` `{Lavender}`, `\rowcolor{LightGoldenrod}`, `\multirow`, `\multicolumn`, `\cline`, `\hline`, `\arrayrulewidth` .1pt, `m{}` columns; the "Table 6.2" caption is plain text, no float |
| framed boxes | brochure.tex:66-88, 369-389 | `box.fancybox`, `box.minipage` | `\fbox` with `\fboxsep` 3pt; `Sbox` + `minipage` .9\columnwidth + `\shadowbox`, `\fboxsep` 1em; `\vbox to8pc{..\vfill}` reduces to `\parbox[c][8pc]{..}` |
| headings | brochure.tex:47, 145, 188, 258, 494, 515 | `head.kernel` | article `\subsection`, `\subsection*`, `\subsubsection(*)`, bodies with `\sffamily` |
| heading numbering | brochure.sty:57 | `num.secnumdepth` | `secnumdepth` 0 |
| counters | brochure.tex:241-243 | `num.counters` | `\setcounter{section}{10}`, `\setcounter{equation}{56}`, `\renewcommand{\theequation}{\thesection.\arabic{equation}}` |
| display maths | brochure.tex:244-249; brochure.tex:1 | `math.kernel`, `math.eqnumber` | `equation` without amsmath; `fleqn` |
| lists | brochure.tex:98, 152, 475, 568, 580; brochure.sty:76-77 | `list.kernel`, `list.enumitem` | `itemize[noitemsep]`; `\labelitemi` = `\footnotesize` bbding glyph, `\labelitemii` = `\textbullet` |
| attributions | brochure.sty:74; brochure.tex:53, 63, 364 | `sp.manual-space`, `mark.kernel`, `sp.lengths` | `\quoted`: `\hfill`, `\textit`, `\parfillskip=0pt` |
| inline marks | brochure.tex:22, 164, 505 | `mark.kernel` | `\itshape`, `\textsc`, `\scshape`, `\textit`, `\emph`, `\bfseries` |
| verbatim | brochure.tex:194-197 | `code.verbatim` | `\verb` with `\linebreak` |
| images | brochure.tex:120, 219, 337, 354 | `fig.graphicx` | bare `\includegraphics[width=..\columnwidth]` (no float), `\scalebox{.94}[1]` (77, 82) |
| URLs | brochure.sty:16; brochure.tex:76, 499, 519 | `meta.url` | `\url+..+` |
| bibliography | brochure.tex:367-373; brochure.sty:16, 79-96 | `bib.bibtex-bst`, `bib.apacite`, `bib.thebibliography` | `\refname`="Documentation", `\nocite{*}`, `\bibliography{brochure}`, style `apacite`, 8 entries in brochure.bib |
| headline logo | brochure.tex:6-7, 17 | `sp.manual-space`, `font.size-commands`, `mark.kernel` | `\wLaTeX`: kerns, `\raisebox`, `\fontsize{70}{0}`, `\textsc{a}` |
| TeX-family logos | brochure.sty:51-53, 112-118; brochure.tex:200, 209, 325-326 | `font.icons`, `mark.kernel` | `\hologo{BibTeX}`, `\hologo{LyX}`, `\hologo{XeLaTeX}` (hologo); `\BibLaTeX` = `\textsc{Bib}\LaTeX` |
| none present | whole sample | none | no theorems, floats, captions, footnotes, index, contents, hyperref, cross-references, babel |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\bulletrule`, `\bulletrulesize`, `\bulletrulewidth` | brochure.sty:62-73 | no | leaders over a glyph box with lengths computed by `\divide`; `sp.rule` excludes leaders over boxes; unused by the sample |
| `\deco`, `\frak`, `\rubric`, `\lite` | brochure.sty:38-43, 49 | yes | aliases of `font.nfss` + `color.xcolor` + `font.size-commands` + `sp.manual-space` / `font.display` + `sp.linespread` + `sp.lengths` + `sp.frenchspacing` / `sp.ragged`; `\deco` ends in `\raisebox{-\baselineskip}` and takes the cell content as its argument (emitter writes the explicit wrapper) |
| `\et`, `\fakesubsection`, `\ding` | brochure.sty:60, 54-56, 61 | yes | inline expansion: `font.display`, `font.size-commands`, `\llap`; `\Large\bfseries` heading line; `font.nfss`; the last two are never called |
| `\quoted` | brochure.sty:74 | yes | `\hfill` + `\textit` + `\parfillskip=0pt` inside a group |
| `\BibTeX`, `\BibLaTeX`, `\LyX` | brochure.sty:51-53 | yes | `\hologo{BibTeX}`, `\textsc{Bib}\LaTeX`, `\hologo{LyX}` (`font.icons`), or inline kerns |
| `\tubreflect`, `\Xe`, `\XeTeX`, `\XeLaTeX`, `\tubhideheight`, `\TBError` | brochure.sty:98-118 | yes | logo copy with an `\ifdim\fontdimen1\font` test; replaced by `\hologo{XeLaTeX}` (`font.icons`), not copied; only `\XeLaTeX` is used (brochure.tex:209) |
| `thebibliography` redefinition | brochure.sty:79-96 | yes, with a caveat | the kernel article list (`\@biblabel`, `enumiv`) plus `\subsection*{\refname}` (`head.kernel`), `\vspace*{.5\baselineskip}` (`sp.manual-space`), `\sloppy` (`sp.hyphenat`), penalties 4000 (`sp.penalties`); the emitter must be able to change the heading level around apacite's generated environment |
| `\bibitem` wrapper | brochure.tex:371 | yes | `\vspace*{-.5\baselineskip}` before each item: `sp.manual-space` or `\itemsep` (`sp.lengths`) |
| `\wLaTeX` | brochure.tex:6-7 | yes | kernel kerns, `\raisebox`, `\fontsize`, `\textsc` only, no logic |
| `\vstrut`, `\bigstrutjot`, `\multirowsetup` | brochure.tex:268-270 | yes | `sp.rule` strut; `tbl.multirow` settings |
| raw `\vbox to8pc` with `\hsize` arithmetic | brochure.tex:68-70 | yes | `\fbox{\parbox[c][8pc]{.38\columnwidth-2\fboxsep-2\fboxrule}{..}}` (`box.minipage`, `box.fancybox`) |
| `build` script | build:18-87 | not scored | imposition and Letter copy by external tools; outside class, preamble and body |

## Content-opaque
- Four images in the body: fullscreen.png, sample-crop.pdf, diagram-crop.pdf, typo-degraded.png (brochure.tex:120, 219, 337, 354); the zip also ships EPS copies for the DVI run, and under pdfLaTeX the PDF and PNG are found first
- Fraktur text with abbreviation marks and the decorative initial text (brochure.tex:441-468), the equation (brochure.tex:244-249), cell contents and bibliography entries
- No TikZ, PGF, PSTricks or `picture` drawings anywhere

## Lib changes
- New ways proposed: none. Considered and not proposed: `calc` (loaded at brochure.sty:16, no infix length expression or `\widthof` in either file, no printed effect); `hologo` is already under `font.icons`; `type1cm` read as the same type as `fix-cm` under `font.exscale`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Not checked (no read left after three): that `luximono`, `oldgerm`, `bbding`, `mflogo`, `type1cm`, `ucs` and the `yinit` initials are on CTAN or in TeX Live; taken from memory and from brochure.sty:36. Fonts and `warnock`/`aller` files are not shipped (missing assets).
