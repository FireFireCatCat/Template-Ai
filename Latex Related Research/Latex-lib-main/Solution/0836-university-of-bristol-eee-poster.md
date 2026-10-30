yes

# 0836-university-of-bristol-eee-poster: University of Bristol EEE Poster

- Unverified: read from the source, not compiled.
- Source: Source/0836-university-of-bristol-eee-poster/ (origin: https://latextemplates.com/downloads/bristol-eee-poster.zip; licence: CC-BY-4.0)
- Kind: poster
- Lib: v6
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (a plain `article` carries nothing; the look is the 72-line `main.tex`: its geometry, four colours, the `\head` alias and the hand-laid body, ATTRIBUTION.txt:4 and README.md:5 say the design is an independent example on an Overleaf listing)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is one `main.tex` over the kernel `article` class; it ships no `.cls`, `.sty` or other TeX file (the zip holds `main.tex`, `README.md`, `ATTRIBUTION.txt`). Every component maps to an existing lib way, and the only zip-local macro, `\head` (main.tex:14), is a one-line alias that expands inline into lib ways. The single judgement call is the TikZ header band (main.tex:17-20): it is two flat full-width rectangles whose only parameters are a colour and a height, so it is taken as a coloured band that reduces to `bg.eso-pic` + `sp.rule` rather than as free artwork (`ART`); a reviewer who counts any page-top banner as template identity would turn this into `ART/body`. Nothing here was compiled.

Reading notes (not blockers, not verified by compiling): `20pt` (main.tex:1) is not a size option of `article` (10pt, 11pt and 12pt are), so the base size is presumably the default 10pt, and the large sizes come from `\fontsize` and `\Large`. The `tikzpicture` (main.tex:17-20, an inline picture) and the author line (main.tex:24) are not closed by `\par`, so by TeX's rules the paragraph stays open: `\vspace*{-7mm}` (main.tex:21) and `\vspace{14mm}` (main.tex:25) then act as `\vadjust` after the current line, `\noindent` (main.tex:26) is a no-op, and the minipage row is set inside that open paragraph. Where TeX breaks that line was not worked out, so the exact vertical placement of the title and the columns is left open; none of this changes which ways are needed.

## Blockers
none

## Class setting
- Class: `class.article` options: `20pt` (main.tex:1; not declared by article, presumably unused; class source not read, it ships with LaTeX)
- Class-native vocabulary used: none (no `\title`, `\maketitle`, `abstract` or sectioning command is used; the title is typeset by hand, main.tex:21-24)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:1 | `class.article`, `page.class-options` | option `20pt` (a size class option; see Class setting) |
| page geometry | main.tex:2 | `page.geometry` | paperwidth=1189mm, paperheight=841mm, margin=24mm (A0 landscape by the dimensions) |
| encoding | main.tex:3, 24 | `font.fontenc-t1` | `[T1]`; `\textbullet` at :24 is a textcomp symbol |
| text face | main.tex:4 | `font.lmodern` | no options |
| microtype | main.tex:8 | `sp.microtype` | load-only, no options |
| colour definitions | main.tex:5, 10-13 | `color.xcolor` | `\definecolor` in model HTML: accent=143D6B, highlight=C93C4B, panel=EDF4FC, ink=182331 |
| text colour | main.tex:16, 22, 25 | `color.xcolor` | `\color{ink}` for the body, `\color{white}` for the title block, `\color{ink}` again at :25 |
| page style | main.tex:9 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| header band (page top, full width) | main.tex:6-7, 17-20 | `bg.eso-pic`, `sp.rule`, `sp.manual-space`, `color.xcolor` | reduction of two TikZ `\fill`s: accent rectangle 35mm tall from the top page edge, highlight rectangle 5mm tall below it (35mm to 40mm); as `\AddToShipoutPictureBG*{\AtPageUpperLeft{...}}` holding coloured `\rule{\paperwidth}{35mm}` and `\rule{\paperwidth}{5mm}` offset by `\raisebox` or `\put(0,\LenToUnit{..})` |
| title block (hand-laid, no `\maketitle`) | main.tex:21-24 | `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.manual-space` | `\vspace*{-7mm}`; `\fontsize{38}{42}\selectfont\bfseries`; `\vspace{5mm}`; `\fontsize{25}{30}\selectfont\bfseries`; `\vspace{3mm}`; `\Large` author line with `\quad\textbullet\quad`; all under `\color{white}` |
| gap before columns | main.tex:25-26 | `sp.manual-space`, `sp.lengths` | `\vspace{14mm}`; `\noindent` (kernel paragraph command, a no-op here per the reading notes; where it acts it equals `\parindent` at 0pt for one paragraph, so `sp.lengths` as a group-local `\setlength{\parindent}{0pt}`) |
| three columns | main.tex:27, 36-38, 52-54, 70 | `cols.minipage` | three `minipage[t]{0.31\linewidth}` joined by `\hfill` (`sp.manual-space`) |
| section headings (via `\head`) | main.tex:14, 28, 30, 32, 34, 39, 46, 48, 50, 55, 57, 59, 65, 67 | `head.titlesec` | equivalent form: `\titleformat{\section}{\Large\bfseries\color{accent}}{}{0pt}{}` with `\titlespacing*{\section}{0pt}{2mm}{2mm}`; the sample itself uses the alias, inline-expanded in the Bespoke table; unnumbered, not in a contents list |
| callout panels | main.tex:33, 47, 66 | `box.fancybox`, `box.minipage` | `\colorbox{panel}{\parbox{0.94\linewidth}{...}}` (`\colorbox` is the colour-package sibling of `\fcolorbox`) |
| panel inner type | main.tex:33, 47, 66 | `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.ragged` | `\large\textbf` (:33); `\centering`, `\fontsize{42}{46}\selectfont\bfseries\color{highlight}`, then `\par\Large` (:47); `\Large\bfseries\color{accent}` (:66) |
| inline maths | main.tex:33, 47 | `math.kernel` | `$\rightarrow$`, `$\times$` (kernel symbols in text maths) |
| results table | main.tex:40-45 | `tbl.tabular` | `tabular{p{0.52\linewidth}rr}`, `\hline` under the header row, `\textbf` (`mark.kernel`) on the "Proposed" cells; no float, no caption |
| bullet list | main.tex:60-64 | `list.kernel`, `sp.lengths` | `itemize` with `\setlength\itemsep{3mm}` inside the environment |
| contact lines | main.tex:68-69 | `sp.manual-space`, `mark.kernel` | `\\` line break; `\texttt{...}` |
| closing line | main.tex:71 | `sp.manual-space`, `font.size-commands` | `\vfill\hfill{\small ...}` (printed in the body, not a running footer) |
| TikZ load | main.tex:6-7 | `art.tikz` | `\usepackage{tikz}` and `\usetikzlibrary{positioning}`; used only for the band at :17-20; no node uses a `positioning` key; dropped by the reduction above |

Not used in this zip: front matter commands, abstract, contents, numbering, quotes, notes, theorems, figures, captions, code, bibliography, index, cross-references, language and PDF metadata packages.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\head` alias | main.tex:14 | yes | `\newcommand` alias with one argument; inline expansion: `\vspace{2mm}` (`sp.manual-space`), `{\Large\bfseries\color{accent}#1}` (`font.size-commands`, `mark.kernel`, `color.xcolor`), `\par`, `\vspace{2mm}`; or the `head.titlesec` form in the Component map |
| TikZ header band | main.tex:17-20 | yes (judgement call) | two `\fill`s from `current page.north west`: accent over 0 to 35mm, highlight over 35mm to 40mm below the top edge; `bg.eso-pic` + `sp.rule` + `sp.manual-space` + `color.xcolor` with those colours and lengths (an overlay drawn behind the page content, as the picture precedes the title text in the source); no computation, loop or conditional in the picture |
| four colour names | main.tex:10-13 | yes | `\definecolor` calls, `color.xcolor` |

No counters, conditionals, `\def`s, output routines or expl3 code in the zip.

## Content-opaque
none (no figure or table float; the sample's "Evidence" paragraph at main.tex:51 is placeholder text and the results table at :40-45 is plain `tabular` content)

## Lib changes
- New ways proposed: none (considered and rejected as a way for the band: `tikzpagenodes`, which `bg.tikzpagenodes` names as ART when it draws identity; considered for the heading: `sectsty`, same type as `head.titlesec`)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
