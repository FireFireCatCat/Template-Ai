no

# 0394-jankapunkt-latexcv: latexcv, a collection of nine CV templates (main sample: Left Sidebar CV)

- Unverified: read from the source, not compiled.
- Source: Source/0394-jankapunkt-latexcv/ (origin: https://codeload.github.com/jankapunkt/latexcv/zip/refs/heads/master; licence: MIT)
- Kind: cv
- Lib: v4
- Engine: pdfLaTeX-compatible (README.md:113 says no XeTeX, Koma or LuaTeX; scripts/test.sh:14 calls `pdflatex`; every package loaded by the main sample is an 8-bit/Type 1 package)
- Look carried by: preamble (no zip-local .cls/.sty; `sidebarleft/main.tex:171-338` defines the colours and the `\cv*` macros on top of kernel `article`)
- Class origin: tex-distribution-unbundled
- Main file: sidebarleft/main.tex (other samples: classic/main.tex, modern/main.tex, two_column/main.tex, sidebar/main.tex, rows/main.tex, minimalistic/main.tex, infographics/main.tex, infographics2/en/main.tex, infographics2/fr/main.tex)
- Read: main yes, zip-local classes and styles none present (other samples read partly: package and macro outlines of all, full preamble of sidebar and infographics, the TikZ helper files infographics/g/{piechart,barchart,timeline}.tex; `docs/cjk/cjk.tex` in full; `infographics2/en` package outline only, `infographics2/fr`, `two_column`, `rows`, `modern` and `classic` by grep outline of macros and packages)

## Verdict
The main sample is plain `article` plus a preamble of `\newcommand` macros that reduce, by inline expansion, to published ways (`paracol`, `geometry`, `tabular*`, `\fcolorbox`, `\rule`, `fontawesome`, `xcolor`). One piece does not reduce to a way that is in lib v4: the skill-level bar of `\cvskill` is a TikZ drawing of two rounded filled rectangles (main.tex:249-252), template-defining and with no declarative lib way, so it is `ART`. A CTAN package for such bars exists (`progressbar`) but its keys were not read, so the reduction is not shown (see Lib changes). The other eight samples add more blockers (TikZ arrows, counter/pgfmath chart environments).

## Blockers
- `ART/preamble` skill-level bar drawn with TikZ inside `\cvskill`: `\fill [lightcol] ... rectangle (1\mpwidth, 0.15)` under `\fill [maincol] ... rectangle (#3\mpwidth, 0.15)`, `rounded corners=2pt` (sidebarleft/main.tex:249-252); used 8 times (sidebarleft/main.tex:367-381)
- `ART/preamble` (other sample, not the main) TikZ arrow shapes `\larrow` `\rarrow` that decorate the section headlines (classic/main.tex:181-201; same in modern, two_column, rows, sidebar, minimalistic)
- `BESPOKE/preamble` + `ART/preamble` (other sample, not the main) chart environments `piechart`, `barchart`, `cvtimeline` and chart commands `\bubbles`, `\squares`, `\factbubble`: `\newcounter` plus `\pgfmathparse` plus `\foreach`/`\whiledo` computing angles, offsets and bar positions (infographics/g/piechart.tex:24-58, infographics/g/barchart.tex:22-59, infographics/g/timeline.tex:24-94, infographics/g/bubbles.tex:33-38, infographics/g/squares.tex:23-38, infographics/g/factbubble.tex:29-31; loaded at infographics/main.tex:227-254; infographics2 repeats them), plus `\pagecolor{bgcol}` (infographics/main.tex:195)

## Class setting
- Class: `class.article` options: `10pt`, `A4` (main.tex:32). `A4` is not a declared article option (the page size comes from `geometry` `a4paper`, main.tex:120); its effect was not tested.
- Class-native vocabulary used: none of article's own front matter. No `\maketitle`, `abstract`, `\section` or `thebibliography` appears; only kernel `itemize`, `center`, `flushleft`, `minipage`, `tabular*`, `\parbox` are used.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:32 | `class.article` | 10pt, A4 (see above) |
| encodings | main.tex:40, 66 | `font.fontenc-t1` | `inputenc` utf8; `fontenc` T1 |
| text face | main.tex:58 | `font.helvet` | `raleway`, option `default` (a sans text-face package is the parameter, as the lib's `font.helvet` merge) |
| default family | main.tex:65 | `font.family-default` | `\renewcommand*\familydefault{\sfdefault}` |
| font sizes | main.tex:69, 230, 466, 468 | `font.size-commands` | `\LARGE`, `\large`, and `\HUGE` which comes from `moresize` (same type: a size-switch command from a package; considered as a widening of the line, nothing proposed) |
| icon glyphs | main.tex:76, 91, 388-390 | `font.icons` | `fontawesome`; `\faMapMarker`, `\faMobilePhone`, `\faEnvelope` built by `\csname fa#1\endcsname`, so the emitter prints the three commands directly |
| fixed-size icon box | main.tex:91 | `box.fancybox` | kernel `\makebox(12,12){...}` (picture-mode argument form of `\makebox`, used as a 12pt by 12pt box, no picture environment, no drawing) with `\textcolor{maincol}` |
| vertical centring of the icon | main.tex:86-87, 96 | `box.minipage` | `\parbox{\wd0}{\box0}` around the icon box; the width is the icon box width, 12pt, so it is `\parbox[c]{12pt}{...}` (see Bespoke code) |
| page geometry | main.tex:120, 123 | `page.geometry` | `a4paper`, top=1cm, bottom=1cm, left=1cm, right=1cm |
| two columns (sidebar and main) | main.tex:117, 351-356, 460 | `cols.paracol` | `paracol{2}`, `leftcolumn`, `rightcolumn`, `\columnratio{0.31}`, `\columnsep` 2.2em, `\columnseprule` 4pt, `\colseprulecolor{lightcol}` |
| page style | main.tex:126 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| header/footer package | main.tex:125 | `hf.fancyhdr` | loaded, never configured (no `\fancyhf`, no `fancy` style); no printed effect |
| paragraph indent | main.tex:132 | `sp.lengths` | `\parindent` 0mm |
| table layout | main.tex:139, 216, 244, 276 | `tbl.tabular` | `array`, `tabular*` with `p{...}` and `r` columns used as layout, not as data tables |
| unused column type | main.tex:143-144 | `tbl.tabular` | `\newcolumntype{x}[1]{>{\raggedleft\hspace{0pt}}p{#1}}`, defined and never used in this sample |
| images | main.tex:152, 360, 336 | `fig.graphicx` | `\includegraphics[width=\linewidth]{untitled.jpg}` (162x201 JPEG, shipped); `\includegraphics[width={#1}\mpwidth]{qrcode}` (1160x1160 PNG, shipped); no float |
| centring | main.tex:335-337 | `sp.ragged` | `center` environment around the QR code |
| left-aligned block | main.tex:315 | `sp.ragged` | `flushleft` environment around the sidebar entry title |
| colours | main.tex:171, 177, 180 | `color.xcolor` | `\definecolor{...}{RGB}{...}`: maincol 225,0,0; darkcol 70,70,70; lightcol 245,245,245. The `RGB` model is xcolor's; the sample never loads xcolor itself, TikZ does (PGF manual; not checked here) |
| legacy colour package | main.tex:168 | `color.color` | `\usepackage{color}`, loaded after tikz, no options |
| opacity package | main.tex:167 | `color.transparent` | loaded; `\transparent` is not called in this sample |
| links | main.tex:184 | `meta.hyperref` | `hidelinks`, loaded last as the comment says |
| link commands | main.tex:101, 106, 390 | `xref.hyperref` | `\href{mailto:...}{...}` and `\href{url}{...}` (hyperref command of the same package) |
| name banner | main.tex:464-470 | `box.fancybox` | `\fcolorbox{white}{darkcol}{...}` around a `minipage` |
| banner box | main.tex:464 | `box.minipage` | `minipage[c][3.5cm][c]{\mpwidth}` |
| banner text | main.tex:466-468 | `mark.kernel` | `\textbf`, `\textcolor{white}`, `\large`; `\HUGE` row above |
| uppercase text | main.tex:230, 466 | `mark.case` | kernel `\uppercase{...}` |
| rules | main.tex:231, 467 | `sp.rule` | `\rule{0.1\textwidth}{2pt}` in maincol; `\rule{0.1\textwidth}{1.25pt}` in white |
| manual spacing | main.tex:228, 248, 279, 302, 367-381, 385, 392, 455-457, 643-650 | `sp.manual-space` | `\vspace`, `\hspace`, `\\[len]`, `\vfill`, `\mbox{}` fillers (hand-tuned to this content) |
| page breaks in the sidebar | main.tex:398, 423, 454 | `pg.break` | `\newpage` inside `leftcolumn` to line the sidebar up with the right column's pages |
| section headlines | main.tex:227-233, 365, 386, 399, 424, 477, 491 | `mark.kernel`, `font.size-commands`, `mark.case`, `sp.rule`, `sp.manual-space` | zip-local `\cvsection`: `\vspace{14pt}`, bold `\LARGE` darkcol uppercase text, `\\[-4pt]`, a maincol rule. No `\section` is used. The emitter route is `head.titlesec` `\titleformat{\section}` with the same pieces (considered; the sample does not load titlesec) |
| paragraph wrapper | main.tex:215-219 | `tbl.tabular`, `box.minipage` | `tabular*{1\mpwidth}{p{0.98\mpwidth}}` holding `\parbox{1\mpwidth}{...}` |
| experience entries | main.tex:271-303, 493-641 | `tbl.tabular`, `box.minipage`, `box.fancybox`, `mark.kernel`, `color.xcolor`, `sp.manual-space` | zip-local `\cvevent`: parbox of a two-row `tabular*` (title and employer left, date chip right: `\colorbox{maincol}{\makebox[0.25\mpwidth]{\textcolor{white}{...}}}`), then optional paragraphs; bold lead-ins "Technologies include:" and "Achievements include:" (main.tex:293, 299) |
| sidebar entries | main.tex:314-326, 401-449 | `sp.ragged`, `mark.kernel`, `color.xcolor`, `tbl.tabular` | zip-local `\cvmetaevent`: maincol bold title in `flushleft`, optional darkcol subtitle and customer, text through `\cvtext` |
| bullet lists | main.tex:204-206, 498-503 | `list.kernel` | `itemize` through `\cvlist{...}` = `\begin{itemize}{#1}\end{itemize}`; kernel defaults, no `enumitem` |
| skill level bar | main.tex:243-253 | `art.tikz` | **ART**: `tikzpicture[scale=1,rounded corners=2pt,very thin]`, two `\fill` rectangles of height 0.15 and width `1\mpwidth` (lightcol) and `#3\mpwidth` (maincol) after a `tabular*` of name and years (main.tex:244-246) |
| optional language add-in (not in the main sample) | docs/cjk/cjk.tex:27, 49, 53-54 | `lang.cjk` | `CJKutf8`, `\cjklang` font name, `CJK*` environment opened by `\AfterEndPreamble` and closed by `\AtEndDocument`; the CJK package itself runs under pdfTeX although the lib tags this way `xe/lua` |
| math, theorems, floats, captions, bibliography, index, contents, abstract, footnotes, language | none | none | the sample uses none of these |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\cvsection` | main.tex:227-233 | yes | inline expansion to `mark.kernel` + `font.size-commands` + `mark.case` + `sp.rule` + `sp.manual-space` (row above), or one `head.titlesec` format |
| `\cvtext` | main.tex:215-219 | yes | `tabular*` + `\parbox`, widths as length expressions |
| `\cvevent` | main.tex:271-303 | yes | inline expansion; the four `\ifthenelse{\isempty{#n}}` guards (main.tex:281, 286, 291, 297) only skip an empty optional argument, so the emitter simply omits the field (the guard has no counter and no state) |
| `\cvmetaevent` | main.tex:314-326 | yes | same: guards at main.tex:317, 321 skip empty subtitle and customer |
| `\cvlist` | main.tex:204-206 | yes | alias of `itemize` |
| `\cvqrcode` | main.tex:334-338 | yes | `center` + `\includegraphics` with a width expression |
| `\cvskill` | main.tex:243-253 | no (for v4) | the tabular half reduces to `tbl.tabular`; the bar is `ART/preamble` (Blockers) |
| `\icon`, `\icontext`, `\iconemail`, `\iconhref` | main.tex:90-107 | yes | inline expansion: fixed box, `\faXxx` command, `\textcolor`, `\href`; `\iconhref` is never called in this sample |
| `\vcenteredhbox` | main.tex:86-87 | yes | `\setbox0=\hbox{X}\parbox{\wd0}{\box0}` has a known width at every use (the 12pt icon box), so it is `\parbox[c]{12pt}{X}`; no output routine or glue algorithm |
| `\vcenteredinclude` | main.tex:80-82 | yes | defined, never called |
| `\mpwidth` | main.tex:189 | yes | a macro holding the length expression `\linewidth-\fboxsep-\fboxsep`; every use (`0.9\mpwidth`, `#3\mpwidth`) expands to `k\linewidth-\fboxsep-\fboxsep`, a length value written out by the emitter (`\dimexpr` or `calc` syntax). `xstring`, `xifthen` (main.tex:47) and the `calc` they bring are load-only helpers with no printed effect (considered, not proposed: same reading as the lib's rejected `sys.compat-load` and `sp.xspace`) |
| `\newcolumntype{x}` | main.tex:143-144 | yes | `array` column type, never used here |
| `\cjklang`, `cjkenv`, hooks | docs/cjk/cjk.tex:49-54 | yes | the emitter writes `\begin{CJK*}{UTF8}{gbsn}` ... `\end{CJK*}` itself (optional add-in, not in the main sample) |

## Content-opaque
none

## Lib changes
- New ways proposed: none.
- Considered, not proposed: `progressbar` (ctan.org/pkg/progressbar, one read: CTAN, TeX Live and MiKTeX, LPPL 1.3c, built on TikZ, `\progressbar{<number 0 to 1>}`; the page says customisation is possible but lists no keys). It would pass W1, W3 and W4, and W2 if its keys cover width, height, a filled and an empty colour, no border and rounded ends; those keys were not read, so the skill bar is not shown to reduce and the verdict stays `no`. This is the one finding that could flip the main sample to `yes`.
- Considered, not proposed: `calc`, `xstring`, `xifthen` (load-only logic and length-expression helpers, see Bespoke code); `moresize` (read as the same type as `font.size-commands`, the consolidator may widen that line).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
