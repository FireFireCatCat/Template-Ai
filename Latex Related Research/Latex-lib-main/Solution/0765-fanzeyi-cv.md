no

# 0765-fanzeyi-cv: Fanzeyi CV

- Unverified: read from the source, not compiled.
- Source: Source/0765-fanzeyi-cv/ (origin: https://latextemplates.com/downloads/fanzeyi-cv.zip; upstream github:fanzeyi/cv per README.md:4; licence: LPPL-1.3c, main.tex:4-10 and README.md:27)
- Kind: cv
- Lib: v6
- Engine: needs XeLaTeX (`fontspec` loaded at main.tex:23, Raleway loaded as `.otf` files at main.tex:72-81; README.md:13-14 says xelatex). `pstricks` (main.tex:25) is loaded unconditionally; its route under XeLaTeX was not checked here and is not counted as a blocker.
- Look carried by: preamble (one self-contained main.tex, 256 lines by the Read tool and 255 by Get-Content; no `.cls` or `.sty` in the zip, README.md:5; the look is package calls and `\newcommand` aliases in main.tex:18-144, plus a tikz panel and a pstricks macro)
- Class origin: tex-distribution-unbundled (kernel `article`, main.tex:18; its source was not read)
- Main file: main.tex (other samples: none)
- Read: main yes (all of main.tex and README.md), zip-local classes and styles none present

## Verdict
no. Most of the template reduces to lib ways: the preamble macros are aliases of font, colour, spacing, table and list calls, and the sidebar column is `textpos`. Two drawings block it. `\skill` draws a PSTricks `pspicture` (rail, tick marks, and a progress line whose length is the skill value) and is called eleven times; the README names "skill sliders" as a feature (README.md:3), so it is `ART` with no declarative lib way (`art.pstricks` is restricted). The grey sidebar panel is a hand-written TikZ page-node rectangle, a CV sidebar shape, counted as `ART` as a judgement call (a reduction to `bg.eso-pic` plus `sp.rule` is conceivable but changes the page flow and is not claimed). The verdict rests on the sliders alone.

## Blockers
- `ART/preamble` skill slider drawn with PSTricks: `\psset{xunit=0.197\linewidth, yunit=5pt}` and `\begin{pspicture}[showgrid=false](5,1)` with five `\psline` calls (grey rail `skillbg`, two `|-|` tick pairs, an `-|` end tick, a black bar `(0,0.5)(#2,0.5)`) (main.tex:123-136); called for Go, Python, SQL, Kubernetes, Kafka, PostgreSQL, Git, Terraform, Linux, Nginx, Redis (main.tex:179-199)
- `ART/body` grey sidebar panel: `\begin{tikzpicture}[remember picture,overlay]` with `\fill[mygray]` from `current page.south west` to `current page.north east` shifted by `-\amount` (main.tex:150-152; `\amount` is 5.7in, main.tex:39). Judgement call, the verdict does not depend on it (see Bespoke code)

## Class setting
- Class: `class.article` options: none (main.tex:18)
- Class-native vocabulary used: `\section` (main.tex:159, 165, 177, 206, 214, 239, 250), `\item` (main.tex:220-246), `center` (main.tex:86, 94), `tabular` (main.tex:169); no `\maketitle`, no `abstract`, no bibliography

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:18 | `class.article` | no options (letter paper, 10pt by default) |
| page geometry | main.tex:19 | `page.geometry` | top=.4in, bottom=.0in, left=3in, right=0.4in, marginparwidth=2.5in (the 3in left margin leaves room for the sidebar; no margin note is used) |
| sidebar background | main.tex:20, 150-152, 39, 34 | `art.tikz` | ART (see Blockers): one `\fill[mygray]` rectangle, width paperwidth minus 5.7in, full page height, drawn in the text flow with `remember picture,overlay` |
| sidebar column | main.tex:22, 115-116, 156-201 | `pg.textpos` | `[absolute,overlay]`; `\TPHorizModule`=`\TPVertModule`=1mm; `\begin{textblock}{58.5}(6,7.7)` holds name, About me, Contacts, Skills |
| text face | main.tex:23, 79-81 | `font.fontspec` | `\setmainfont{Raleway-Regular}[Extension=.otf, BoldFont=Raleway-Bold, ItalicFont=Raleway-RegularItalic, BoldItalicFont=Raleway-BoldItalic]` |
| weight switches | main.tex:72-77 | `font.fontspec` | `\newfontfamily` for `\raleway` (Regular), `\ralewaym` (Medium), `\ralewaysb` (SemiBold), `\ralewayb` (Bold), `\ralewayeb` (ExtraBold), `\ralewaybb` (Black, never called), each `[Extension=.otf]`; the font files are not in the zip (main.tex:68-70 says TeX Live ships them under `impallari/raleway`), so ship them |
| colours | main.tex:21, 34-37 | `color.xcolor` | `\definecolor` gray values: mygray 0.95, lightdark 0.55, dark 0.3, skillbg 0.7 |
| colour use | main.tex:96, 107, 141, 161 | `color.xcolor` | `\color{dark}` in the heading format (107) and sidebar text (161), `\color{lightdark}` on the date and place line (141), `\color{dark}` in the unused `\tagline` (96) |
| line spacing | main.tex:42 | `sp.linespread` | 1.2 |
| paragraph indent | main.tex:117 | `sp.lengths` | `\parindent`=0mm |
| page numbers | main.tex:43 | `pgnum.pagenumbering` | `\pagenumbering{gobble}` (no number printed); no `\pagestyle`, so no header or footer way is set |
| section headings | main.tex:24, 105-113 | `head.titlesec` | `\titleformat{\section}[hang]{\ralewaysb\large\color{dark}}{}{.0em}{}[{\titlerule[0.8pt]}]` (empty label, a 0.8pt rule after the title); `\titlespacing*{\section}{0pt}{4pt}{10pt}` |
| heading counter | main.tex:40, 103 | `num.counters` | `\setcounter{section}{-1}`; `\renewcommand{\thesection}{\twodigits{\arabic{section}}.}`; the title label is empty (main.tex:108), so the number is not printed |
| type sizes | main.tex:87, 95, 107, 139 | `font.size-commands` | `\Huge` (name), `\large` (tagline, heading, block title) |
| name line | main.tex:85-91, 157 | `sp.ragged` | `center` environment holding `\Huge` and `\ralewayeb` (`font.fontspec`) around the two name arguments |
| contact table | main.tex:119-121, 167-175 | `tbl.tabular` | column spec `{rl}`; `\renewcommand{\arraystretch}{1.1}`; label cell `\ralewaysb`, value cell `\raleway` |
| contact links | main.tex:32, 172-174 | `meta.hyperref` | `\usepackage{hyperref}` with no options (an options variant is commented out, main.tex:29-31); body `\href{url}{text}` (an external link, not a cross-reference) |
| experience bullets | main.tex:27, 46, 219, 232, 242 | `list.paralist` | `\renewenvironment{itemize}[1]{\begin{compactitem}#1}{\end{compactitem}}`: the mandatory argument takes the `[` of `\begin{itemize}[-]` and `-]` follows, so each list is `compactitem` with label `-` |
| default bullet | main.tex:26, 45 | `list.kernel` | `\renewcommand{\labelitemi}{$\blacksquare$}` with `\blacksquare` from `math.amssymb`; overridden by the `[-]` label in all three lists |
| symbol package | main.tex:26, 45 | `math.amssymb` | `\usepackage{amssymb}`; `\blacksquare` |
| experience block | main.tex:138-144, 208-248 | `font.fontspec` | title `{\large\ralewayb ..}` (`font.size-commands`), line 2 `\ralewaym{\color{lightdark}..}`, body `\raleway{..}`, three paragraphs |
| manual spacing | main.tex:99, 124, 205, 226 | `sp.manual-space` | `\vspace{.2em}` (in `\skill` and the unused `\tagline`), `\vspace{-25pt}` before Education, `\vspace{.5em}` between jobs |
| awards lines | main.tex:252, 254 | `sp.manual-space` | `\ralewaysb ... \raleway ...\hfill date` on one line, with `font.fontspec` switches |
| skill sliders | main.tex:25, 123-136, 179-199 | `art.pstricks` | `\skill{label}{value}`: label in `\ralewayb`, then a `pspicture` of five `\psline`s (ART, see Blockers) |
| not set | none | none | no header or footer, language, floats, theorem, math display, code, bibliography or index |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\amount` | main.tex:39 | yes | a constant length, 5.7in; it only feeds the tikz panel (main.tex:151) |
| `\twodigits` | main.tex:50-52 | yes (judgement call) | an `\ifnum` zero-pad used only in `\thesection` (main.tex:103); the empty heading label (main.tex:108) means it is never printed, so the emitter drops it. If a number were printed it is a `\renewcommand\thesection` redefinition (`num.counters`) |
| `\hl` | main.tex:55 | yes | identity alias `#1`; the commented variant at main.tex:54 would add `\ralewaysb` (`font.fontspec`); inline the text |
| `\name` | main.tex:85-91 | yes | alias of `center`, `\Huge`, `\ralewayeb` (`sp.ragged`, `font.size-commands`, `font.fontspec`) |
| `\tagline` | main.tex:93-101 | yes (unused) | alias of `center`, `\large`, `\color{dark}`, `\ralewaysb`, `\vspace{.2em}`; no call in the body (grep over main.tex) |
| `\contactline` | main.tex:119-121 | yes | alias of a table row `\ralewaysb{..} & \raleway{..}` (`tbl.tabular`, `font.fontspec`) |
| `\block` | main.tex:138-144 | yes | alias of three paragraphs with `\large\ralewayb`, `\ralewaym` plus `\color{lightdark}`, `\raleway` |
| `\renewenvironment{itemize}` | main.tex:46 | yes | alias of `compactitem` with the label argument passed through; emit `\begin{compactitem}[-]` (`list.paralist`); read, not tested |
| `\skill` | main.tex:123-136 | no | PSTricks drawing driven by the value `#2`; no lib way names a rating bar (`art.pstricks` is restricted); another CV class's skill commands are class vocabulary, not a package under `article`: `ART/preamble` |
| tikzpicture panel | main.tex:150-152 | no (judgement call) | a single filled rectangle; the rubric names a CV sidebar shape as ART. A composition of `bg.eso-pic` (`\AddToShipoutPictureBG*`), `color.xcolor` and `sp.rule` (a `\rule` of width `\paperwidth` minus 5.7in and height `\paperheight`) is conceivable, but the tikz picture sits in the text flow as a zero-height line and `\vspace{-25pt}` (main.tex:205) compensates by hand, so the reduction would need a re-tuned length; considered, not claimed: `ART/body` |

No `\newenvironment`, `\newcounter`, `\newif`, `\def`, `\makeatletter` or expl3 appears in main.tex (grep). Nothing outside TeX is called by the sample, so no `EXTERNAL`.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- README.md:3 says "dark sidebar", but the code colours the sidebar `gray` 0.95, a light grey (main.tex:34, 151). The README is data and was not followed.
- The zip is a latextemplates.com patch of the upstream file: the font loading was changed to file names (main.tex:60-71, README.md:16-23). The comment at main.tex:205 calls the `\vspace{-25pt}` an adjustment of the right column's position. No text addressed to an AI was found.
