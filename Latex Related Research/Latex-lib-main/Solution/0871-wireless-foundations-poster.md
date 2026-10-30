yes

# 0871-wireless-foundations-poster: Wireless Foundations poster (beamer + beamerposter, manual textpos grid)

- Unverified: read from the source, not compiled.
- Source: Source/0871-wireless-foundations-poster/ (origin: https://latextemplates.com/downloads/wireless-foundations-poster.zip; licence: Unknown (Overleaf: Other as stated in the work); not established, README.md:13-15 calls it a provenance/licence warning)
- Kind: poster
- Lib: v6
- Engine: pdfLaTeX-compatible (main.tex:66 says the starter uses PDFLaTeX; no fontspec or Lua)
- Look carried by: preamble (published class `beamer` loaded unchanged; the look is the preamble's `\setbeamercolor` and `\setbeamertemplate` calls plus `beamerposter` page size, and the body's `textpos` grid of `block`s)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; README.md is prose only)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is one 104-line `main.tex` and a README, with no zip-local `.cls`, `.sty` or other macro file. It is `class.beamer` loaded unchanged, `beamerposter` for the 40in x 30in page, and a preamble of published ways (beamer colour and template calls, `xcolor`, `fontenc`, `lmodern`, `amsmath`, `booktabs`, `textpos`). Every body construct is a `textblock*` holding a beamer `block`, a list, a display equation, a kernel theorem or a `booktabs` table. The only hand-written template code is the `block begin` and `block end` body, which composes beamer's own `beamercolorbox` with kernel font and spacing commands, so it reduces. The one TikZ picture is a demonstration figure inside a block, not template identity, so it is content. No `ART`, `BESPOKE`, `EXTERNAL` or `UNMAPPED` blocker found. The beamer and beamerposter sources are not bundled and were not read.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `final` (main.tex:3). No `\usetheme`, so beamer's default theme with navigation symbols removed (main.tex:13).
- Class-native vocabulary used: `frame[t]` (main.tex:21), `block{title}` environment (main.tex:27, 38, 49, 62, 69, 78, 89, 95), `\insertblocktitle` and `beamercolorbox[wd=,sep=]{name}` (main.tex:17), template names `navigation symbols`, `block begin`, `block end` (main.tex:13, 17, 18), colour names `normal text`, `block title`, `block body` (main.tex:14-16). `beamerposter` (main.tex:4) is a package loaded after the class, with options `size=custom,width=101.6,height=76.2,scale=1.0` (cm, so 40in x 30in landscape, README.md:3).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:3 | `class.beamer` | option `final` |
| page size / poster scale | main.tex:4 | `poster.baposter` | beamerposter `size=custom`, `width=101.6`, `height=76.2`, `scale=1.0`; no `geometry` call anywhere in the sample |
| page layout (manual grid) | main.tex:7, 22, 27, 38, 49, 62, 69, 78, 89, 95, 102 | `pg.textpos` | package `textpos` loaded without options; one `textblock*{width}(x,y)` per part; width 23cm at x = 2, 27, 52, 77cm and y = 12cm (main.tex:27, 38, 49, 62) and y = 39cm (main.tex:69, 78, 89, 95); title block 96cm wide at (2cm,1.6cm) (main.tex:22); footer 96cm at (2cm,70.2cm) (main.tex:102) |
| text encoding | main.tex:5 | `font.fontenc-t1` | `\usepackage[T1]{fontenc}` |
| text face | main.tex:6 | `font.lmodern` | `\usepackage{lmodern}` |
| colour definitions | main.tex:9-12 | `color.xcolor` | `\definecolor` in model HTML: wirelessblue 123B63, signalblue 1976A8, paper F6F9FB, warm F2A900 (`warm` is never used); beamer loads xcolor |
| colour switches in body | main.tex:23, 25, 102 | `color.xcolor` | `\color{wirelessblue}`, `\color{signalblue}` |
| frame text and background colours | main.tex:14 | `slide.beamer-template` | `\setbeamercolor{normal text}{fg=wirelessblue,bg=paper}` |
| navigation symbols | main.tex:13 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` (empty) |
| block (section box) colours | main.tex:15-16 | `slide.beamer-template` | `block title` fg=white bg=wirelessblue; `block body` fg=wirelessblue bg=white |
| block shape | main.tex:17-18 | `slide.beamer-template` | `block begin`: `beamercolorbox[wd=\linewidth,sep=0.45cm]{block title}` with `\Large\bfseries\insertblocktitle`, `\nointerlineskip`, then `beamercolorbox[wd=\linewidth,sep=0.55cm]{block body}`; `block end`: close box, `\vspace{0.45cm}` |
| block text sizes in template | main.tex:17 | `font.size-commands`, `mark.kernel` | `\Large`, `\bfseries` |
| block gap | main.tex:18 | `sp.manual-space` | `\vspace{0.45cm}` |
| frame | main.tex:21, 103 | `class.beamer` vocabulary | `frame[t]` (top alignment), one frame holds the whole poster |
| title block (no `\maketitle`) | main.tex:22-26 | `pg.textpos`, `sp.ragged`, `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.manual-space`, `sp.rule` | hand-set in a `textblock*`: `\centering`; title `\fontsize{34}{40}\selectfont\bfseries` (main.tex:23); subtitle `\Large` (main.tex:24); `\vspace{0.25cm}`, `\vspace{0.45cm}`; `\rule{92cm}{0.18cm}` in signalblue (main.tex:25); considered `front.titlepage-env`, not used: there is no `titlepage` environment |
| abstract / contents / headings / numbering | none | n/a | the sample has no abstract, `\section`, `\tableofcontents` or section numbers; each block title is the heading and is set by the block template (main.tex:17) |
| header / footer | main.tex:102 | `pg.textpos` | no page style and no `\setbeamertemplate{footline}`; the footer line is a `textblock*` at (2cm,70.2cm) with `\centering\color{wirelessblue}\large` (`sp.ragged`, `color.xcolor`, `font.size-commands`) |
| unordered list | main.tex:32-36 | `list.kernel`, `sp.lengths` | `itemize` with `\itemsep0.25em` |
| numbered reference list | main.tex:96-100 | `list.kernel`, `sp.lengths`, `font.size-commands` | `enumerate` with `\itemsep0.3em\small`; the references are typed as items, no `thebibliography` and no BibTeX; titles in `\textit` (`mark.kernel`, main.tex:97-98) |
| display maths | main.tex:40-42, 72-74 | `math.kernel`, `math.amsmath` | `\[ ... \]`; `amsmath` loaded (main.tex:7) |
| maths symbols | main.tex:7 | `math.amssymb` | `\usepackage{amssymb}` |
| theorem-like statement | main.tex:19, 45-47 | `thm.kernel` | `\newtheorem{claim}{Claim}`, used as `claim[Measurement]`; no `\theoremstyle`; its look comes from beamer's own theorem template, which the sample leaves at the default |
| table | main.tex:79-84 | `tbl.tabular`, `tbl.booktabs` | `tabular{lrrr}` with `\toprule` `\midrule` `\bottomrule`; inside a block, not a float, no caption |
| table alignment | main.tex:79, 85 | `sp.ragged` | `\centering` before the table, `\raggedright` after it |
| space between table and text | main.tex:85 | `sp.manual-space` | `\vspace{0.5cm}` |
| figure | main.tex:54-60 | `art.tikz` (content) | one `tikzpicture` in a `center` inside a block, no float and no caption; see Content-opaque |
| captions / floats | none | n/a | no `figure`, `table` or `\caption` in the sample (main.tex:87 only mentions a caption in prose) |
| cross-references / hyperref / language / meta | none | n/a | no `\label`, `\ref`, `\hypersetup`, `babel` or PDF metadata in the sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\setbeamertemplate{block begin}` body | main.tex:17 | yes | `slide.beamer-template`; the body is only beamer's `beamercolorbox` (options `wd=\linewidth`, `sep=0.45cm` and `0.55cm`, colour names `block title`, `block body`), `\Large\bfseries` (`font.size-commands`, `mark.kernel`), `\insertblocktitle` and `\nointerlineskip` (a kernel spacing command, listed with the `sp.manual-space` family); no `\def`, no conditional, no counter |
| `\setbeamertemplate{block end}` body | main.tex:18 | yes | `slide.beamer-template` with `\end{beamercolorbox}` and `\vspace{0.45cm}` (`sp.manual-space`) |
| `\newtheorem{claim}{Claim}` | main.tex:19 | not bespoke | kernel declaration (`thm.kernel`), listed only because it defines a name in the zip |

No `\newcommand`, `\def`, `\newif`, `\newcounter`, zip-local class or style exists (main.tex has none; the folder holds only main.tex and README.md).

## Content-opaque
- `art.tikz` picture at main.tex:55-59 (a drawn 12 x 7 grid, a thick corner line and one node), inside the "Layout details" block (main.tex:49-61). It illustrates the text of that block and is placeholder figure content, not a banner, frame or block shape of the template, so it is content and not `ART`. `\usetikzlibrary{arrows.meta,positioning}` (main.tex:8) is loaded but the picture does not use either library. Judgment call: README.md:9-11 says TikZ replaced the original EPS logos, but the sample places TikZ only in this one figure.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The beamer class and `beamerposter` are published and not bundled, so their sources were not read; `beamerposter` is filed under `poster.baposter` as the lib line says. How `beamerposter` sets the paper size internally is not read; only its option values are recorded.
- Text in README.md and main.tex comments (main.tex:1-2, README.md:8-16) is descriptive and addressed to no agent.
