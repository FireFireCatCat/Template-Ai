yes

# 0333-e-ink-planner: E-Ink Planner

- Unverified: read from the source, not compiled.
- Source: Source/0333-e-ink-planner/ (origin: https://latextemplates.com/downloads/e-ink-planner.zip; licence: Apache-2.0)
- Kind: calendar
- Lib: v3 (the snapshot you read)
- Engine: pdfLaTeX-compatible (no fontspec, no shell escape; the TikZ overlay as written needs two passes for `remember picture`, README.md:5-6 says no external fonts or shell-escape)
- Look carried by: preamble (one 102-line `main.tex` on the kernel `article` class; the look is the preamble colours and the `\monthbox` macro plus hand-set body tables; no zip-local class or style)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only `main.tex` and `README.md`; `ls -la` shows no hidden files)

## Verdict
Yes, with one judgment call. The sample is a landscape A4 planner built from published pieces only: `article` with `geometry`, `array`/`tabularx`/`booktabs` tables, `\fbox`/`\colorbox`/`\parbox`/`minipage` boxes, `xcolor` colours and kernel font and spacing commands. The only bespoke items are a three-argument `\newcommand` alias (`\monthbox`), a TikZ macro `\notegrid` that is defined but never called, and a first-page TikZ overlay that draws two full-width flat rectangles (the black header band and a grey rule under it). The band is template artwork as written, but it is nothing more than two coloured rectangles anchored to the page top, so it reduces to `bg.eso-pic` placing two coloured `sp.rule` bars with a colour, width, height and offset each; that reduction is what makes the answer `yes`. If a reviewer holds that a TikZ-drawn band is `ART` whatever it reduces to, the answer flips to `no` on that one item (it would be `ART/body`, main.tex:35-38); nothing else in the file is in doubt.

## Blockers
none

## Class setting
- Class: `class.article` options: `10pt`, `a4paper`, `landscape` (main.tex:1)
- Class-native vocabulary used: only the `center` environment (main.tex:60, 83) and `\newpage` (main.tex:59, 82). None of article's front matter (`\maketitle`, `abstract`) or sectioning commands is used; the headings are hand-set text (main.tex:40, 61, 84).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 10pt, a4paper, landscape |
| paper size and orientation | main.tex:1 | `page.class-options` | `a4paper`, `landscape`, `10pt` |
| page geometry | main.tex:2 | `page.geometry` | `margin=12mm` |
| colours | main.tex:6, 10-12 | `color.xcolor` | `ink` RGB 20,24,29; `papergray` RGB 242,244,246; `linegray` RGB 150,158,166; used by `\color` at main.tex:18, 40, 42, 61, 63, 84, 86 |
| page style | main.tex:13 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no header, footer or page number) |
| paragraph indent | main.tex:14 | `sp.lengths` | `\parindent` = 0pt |
| page-1 header band (ink 28mm, grey 3mm under it) | main.tex:35-38 | `bg.eso-pic` | one-page overlay (`\AddToShipoutPictureBG*`), origin `\AtPageUpperLeft`; two bars: ink at offset 0 height 28mm, papergray at offset -28mm height 3mm, both `\paperwidth` wide; as written it is TikZ `remember picture,overlay` (see Bespoke code) |
| page-1 header band bars | main.tex:36-37 | `sp.rule` | `\rule{\paperwidth}{28mm}` in ink, `\rule{\paperwidth}{3mm}` in papergray, drawn through `\color` |
| page-1 title text, hand-set (no `\maketitle`) | main.tex:39-42 | `font.size-commands` | `\fontsize{25}{29}\selectfont`, `\large`, `\small` |
| title text emphasis | main.tex:40, 42 | `mark.kernel` | `\bfseries` |
| title spacing and right-hand tagline | main.tex:39, 41, 42, 43 | `sp.manual-space` | `\vspace*{3mm}`, `\vspace{5mm}`, `\vspace{6mm}`, `\hfill` |
| month card container | main.tex:17 | `box.minipage` | `minipage[t][38mm][t]{0.30\linewidth}` |
| month card title strip | main.tex:18 | `box.fancybox` | `\colorbox{ink}`, text in white (`\color{white}`), `\bfseries`, `\hfill`, year in `\scriptsize` |
| month card title strip inner box | main.tex:18 | `box.minipage` | `\parbox{\dimexpr\linewidth-2\fboxsep\relax}{...}` (an e-TeX length expression as the width value) |
| month day grid | main.tex:19-23 | `tbl.tabularx` | `tabularx{\linewidth}{@{}` + 7 x `>{\centering\arraybackslash}X` + `@{}}`; header row `\textbf{M}` ... `\textbf{S}` (main.tex:21); day cells are content (#3) |
| month day grid row height and size | main.tex:19 | `tbl.tabular` | `\renewcommand{\arraystretch}{1.15}`, `\tiny` group |
| day grid cell centring | main.tex:20 | `sp.ragged` | `\centering\arraybackslash` in the column prefix |
| annual overview, 3 x 4 months | main.tex:44-57 | `tbl.tabular` | `tabular{@{}p{0.32\linewidth}p{0.32\linewidth}p{0.32\linewidth}@{}}`, rows ended by `\\[3mm]` (main.tex:47, 50, 53) |
| overview row gaps | main.tex:47, 50, 53 | `sp.manual-space` | `\\[3mm]` |
| page breaks | main.tex:59, 82 | `pg.break` | `\newpage` |
| page headings, hand-set | main.tex:60-64, 83-87 | `sp.ragged` | `center` environment |
| page heading size and weight | main.tex:61, 84 | `font.size-commands` | `\fontsize{20}{24}\selectfont`, `\small` subline |
| page heading emphasis | main.tex:61, 84 | `mark.kernel` | `\bfseries` |
| heading spacing | main.tex:62, 65, 85, 88 | `sp.manual-space` | `\vspace{2mm}`, `\vspace{5mm}`, `\vspace{4mm}` |
| quarterly focus table | main.tex:66-75 | `tbl.tabularx` | `tabularx{\linewidth}{@{}>{\bfseries\large}p{25mm} X X X@{}}`, 4 body rows Q1 to Q4 |
| quarterly table rules | main.tex:67, 69, 74 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| quarterly table row heights | main.tex:70-73 | `sp.rule` | strut `\rule{0pt}{18mm}` |
| quarterly table column prefix | main.tex:66 | `tbl.tabular` | `array` column prefix `>{\bfseries\large}p{25mm}`, `@{}` |
| spacing between tables | main.tex:76, 96 | `sp.manual-space` | `\vspace{7mm}`, `\vspace{5mm}` |
| framed note boxes (2 on page 2, 3 on page 3) | main.tex:77-80, 97-101 | `box.fancybox` | `\fbox{...}` (default `\fboxsep`, `\fboxrule`) |
| framed note boxes inner box | main.tex:78-79, 98-100 | `box.minipage` | `\parbox[t][36mm][t]{\linewidth}` (page 2), `\parbox[t][25mm][t]{\linewidth}` (page 3), bold label + `\par\vspace{20mm}` or `\vspace{12mm}` |
| framed note boxes layout | main.tex:77, 97 | `tbl.tabularx` | `tabularx{\linewidth}{@{}X X@{}}` and `{@{}X X X@{}}` |
| framed note boxes label | main.tex:78-79, 98-100 | `mark.kernel` | `\textbf{...}` |
| daily notes table | main.tex:89-95 | `tbl.tabularx` | `tabularx{\linewidth}{@{}p{25mm} X p{25mm} X@{}}`, `\multicolumn{3}{l}{...}` (kernel tabular) |
| daily notes table rules | main.tex:90, 92, 94 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| daily notes table row heights | main.tex:91, 93 | `sp.rule` | struts `\rule{0pt}{14mm}`, `\rule{0pt}{62mm}` |
| fill-in lines on page 3 | main.tex:86 | `sp.rule` | `\rule{35mm}{0.4pt}`, `\rule{20mm}{0.4pt}`, spread by `\hfill` (`sp.manual-space`) |
| unused ruled note grid | main.tex:27-32 | `box.fancybox` | never called (grep finds `notegrid` only at main.tex:27); if an emitter wanted it, see Bespoke code |

Nothing else is present: no font package (default Computer Modern from the class), no `babel`, no `hyperref`, no maths, no floats or captions, no lists, no bibliography, no sectioning commands, no front matter. Those components are absent, not unmapped.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\monthbox{month}{year}{days}` | main.tex:16-25 | yes | A `\newcommand` alias with three arguments and no logic. Expand it per call (12 calls at main.tex:45-56) into the lines at main.tex:17-23: `box.minipage` + `box.fancybox` + `tbl.tabularx` as listed above. The `&` characters inside argument #3 are cell content. |
| `\notegrid{n}` | main.tex:27-32 | yes (dead code) | Defined, never called, so it contributes nothing to the printed pages; an emitter that works from used constructs omits it. If it were kept: a framed box `\linewidth` by `\textheight-18mm` (`box.fancybox` + `box.minipage`) holding n bars `\rule{\linewidth}{0.4pt}` in `linegray!65` (`sp.rule`, `color.xcolor`) spaced 7mm (`sp.manual-space`), the `\foreach` unrolled by the emitter. This is a bounded repeat, not computed layout. As written it is `art.tikz` (`\foreach`, `rectangle`, `calc` arithmetic). |
| first-page header band | main.tex:35-38 | yes (judgment call) | As written: TikZ artwork, `ART/body` if it did not reduce (`remember picture,overlay`, `current page.north west`, two `\fill` rectangles). Two flat rectangles with a colour, a full-page width, a height and a vertical offset each, so they reduce to `bg.eso-pic` placing two `sp.rule` bars: `\AddToShipoutPictureBG*{\AtPageUpperLeft{\put(0,\LenToUnit{-28mm}){\color{ink}\rule{\paperwidth}{28mm}}\put(0,\LenToUnit{-31mm}){\color{papergray}\rule{\paperwidth}{3mm}}}}` before the first text. The starred form is for the current page only. The reduction drops the TikZ package and its two-pass `remember picture`. Not compiled here, so no claim that the output is identical. |
| `\definecolor` x3 | main.tex:10-12 | yes | Published `xcolor` command: `color.xcolor`. Not bespoke. |

## Content-opaque
- The month day numbers typed into the `\monthbox` arguments (main.tex:45-56) are cell content; no way is needed for them.
- The `Q1` to `Q4` labels and the box titles (main.tex:70-73, 78-79, 91-93, 98-100) are text content.
- `\usetikzlibrary{calc}` (main.tex:8) is needed only by the unused `\notegrid` macro; nothing else in the sample uses it.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
