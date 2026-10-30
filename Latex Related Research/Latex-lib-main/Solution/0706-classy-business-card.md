no

# 0706-classy-business-card: Classy Business Card

- Unverified: read from the source, not compiled.
- Source: Source/0706-classy-business-card/ (origin: https://latextemplates.com/downloads/classy-business-card.zip; licence: MIT)
- Kind: misc
- Lib: v5
- Engine: pdfLaTeX-compatible (`tikz`, `xcolor`, `qrcode` and kernel commands only; no `fontspec`, no Lua; the README says no fonts are bundled, README.md:3)
- Look carried by: preamble (the whole card face is the `\card` macro at main.tex:5, a TikZ picture; the 5 x 2 sheet is a `tabular` in the body at main.tex:6; the class adds no look)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
no. The class, page size and margins, colour, QR code and sheet grid all map to lib ways, but the template's identity is the card face. That face is a hand-placed TikZ drawing inside `\newcommand{\card}` (main.tex:5): a 1pt outline rectangle, a filled left sidebar, a 90-degree rotated brand label, text nodes and a QR node at absolute centimetre coordinates. This is template-defining artwork with no declarative lib way, so it is `ART/preamble`. I could not show a reduction to `box.tcolorbox` or `ticket.sheet`: placing the nodes and the QR code at those coordinates would still need free overlay drawing code. `ticket.sheet` (`elzcards`, `bizcard`) could hold an imposed sheet of cards, but its card face stays outside the way and is ART when it draws the template's identity (considered, not used: the zip loads none of those packages).

## Blockers
- `ART/preamble` card face drawn with TikZ inside `\newcommand{\card}`: border `\draw[blue,line width=1pt] (0,0) rectangle (8.6,5.4)`, sidebar `\fill[blue] (0,0) rectangle (2.05,5.4)`, rotated label `\node[rotate=90,text=white,...] at (1.02,2.7) {CLASSY}`, five text nodes `\node[anchor=north west,...]` at `(2.45,4.65)` down to `(2.47,2.55)`, and the QR node `\node[anchor=south east] at (8.15,.35)` (main.tex:5; called ten times in the body, main.tex:6)

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:1). The kernel class is not in the zip and its source was not read; it ships with the TeX distribution.
- Class-native vocabulary used: none (no `\maketitle`, no `abstract`, no sectioning; main.tex:6 holds only the tabular of cards).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | `a4paper` |
| paper size | main.tex:1 | `page.class-options` | `a4paper` |
| page geometry | main.tex:2 | `page.geometry` | `margin=0.4cm` (all four sides) |
| header/footer | main.tex:4 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| colour | main.tex:3, main.tex:5 | `color.xcolor` | `\usepackage{xcolor}`; `\definecolor{blue}{HTML}{1769AA}` (redefines the name `blue`; used as draw, fill and text colour in the picture); `text=white` |
| card face: outline, sidebar fill, rotated label, positioned text nodes | main.tex:3, main.tex:5 | `art.tikz` (**ART**) | `\usepackage{tikz}`; `tikzpicture`; `line width=1pt`; rectangles 8.6 x 5.4 and 2.05 x 5.4; `rotate=90`; nodes with `anchor=north west` and `south east` at fixed coordinates |
| fonts inside the card nodes | main.tex:5 | `mark.kernel` | `font=\sffamily\bfseries` (brand label, name), `\sffamily` (job title, phone, e-mail, web address) |
| font sizes inside the card nodes | main.tex:5 | `font.size-commands` | `\Large` (brand label), `\large` (name), `\small` (other lines) |
| QR code of a string | main.tex:3, main.tex:5 | `fig.qrcode` | `\usepackage{qrcode}`, `\qrcode[height=1.25cm]{https://jordanlee.example}` placed inside a TikZ node |
| sheet grid of ten cards | main.tex:6 | `tbl.tabular` | `tabular{cc}`, five rows of `\card&\card`, no rules |
| row gap | main.tex:6 | `sp.manual-space` | `\\[.15cm]` after each of the first four rows |
| no paragraph indent before the grid | main.tex:6 | `sp.lengths` | `\noindent` is a kernel paragraph primitive; its effect here equals a zero `\parindent` for that one paragraph, so it is written as a `sp.lengths` setting (a boundary mapping, it does not change the verdict) |

Components the sample does not define or use: title block, abstract, contents, headings, lists, quotes, notes, maths, theorems, floats and captions, code, bibliography, index, cross-references, text-face packages, language, hyperlinks.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\card` (`\newcommand` with no arguments, one `tikzpicture`) | main.tex:5 (defined), main.tex:6 (used 10 times) | Reducible as an alias: no counters, conditionals, `\def` logic or kernel redefinition. Its content is the ART picture, so the blocker is `ART/preamble`, not `BESPOKE`. | An emitter would inline the picture ten times, which is still `art.tikz` with free drawing parameters; no declarative lib way holds it. |

No zip-local `.cls`, `.sty` or other file exists; the zip holds only main.tex (6 lines) and README.md (a description of the card, with no instructions to an AI; README.md:3).

## Content-opaque
- The card text is content: name "Jordan Lee", title "Research engineer", phone, e-mail and web address (main.tex:5).
- The QR payload `https://jordanlee.example` is content (main.tex:5).
- The TikZ card face is not figure content: it is the template's own artwork, listed under Blockers.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
