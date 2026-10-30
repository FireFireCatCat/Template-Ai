no

# 0350-trybibby-business-card-grid: TryBibby Business Card Grid

- Unverified: read from the source, not compiled.
- Source: Source/0350-trybibby-business-card-grid/ (origin: https://latextemplates.com/downloads/trybibby-business-card-grid.zip; licence: not established, the manifest says "MIT (reported by index result; source page inaccessible)" and README.md:4-6 repeats that the reported MIT status is only a warning)
- Kind: misc (a ten-up business-card print sheet; the manifest hint is also `misc`, and the lib has no card kind)
- Lib: v3
- Engine: pdfLaTeX-compatible (`tikz`, `xcolor`, `lmodern`, `fontenc` run in pdfLaTeX; the `qrcode` package is on CTAN and per its CTAN page needs no PSTricks or other graphics package, main.tex:5; the CTAN page does not state engine support, so this is from the package set, not from a read of its manual)
- Look carried by: preamble (the whole card face is one `\newcommand{\card}` TikZ picture in the sample's own preamble, main.tex:9-27; there is no class or style file)
- Class origin: tex-distribution-unbundled (kernel `article`, main.tex:1, not in the zip; its source was not read)
- Main file: main.tex (other samples: none; the zip holds only main.tex and README.md)
- Read: main yes, zip-local classes and styles none present

## Verdict
No. The sample is 33 lines: an A4 `article` page with a tiny margin, an empty page style, and a `tabular` that places ten copies of one macro, `\card`. Every part of the look is inside `\card` (main.tex:9-27): a TikZ picture that draws the card outline, a blue masthead band, a yellow tab, and five text nodes and a QR code at hard-coded absolute coordinates. That is template-defining artwork (the card face is the template), not figure content, and it has no declarative lib way: it is `ART`. The page setup and the grid around it do map to lib ways, but the artwork does not, so the answer is `no`.

## Blockers
- `ART/preamble` card face drawn as one `tikzpicture` in `\newcommand{\card}`: outline rectangle (main.tex:11), blue masthead band (main.tex:12), yellow tab (main.tex:13), wordmark and contact text nodes at fixed (x,y) in cm (main.tex:14-23), QR code node (main.tex:24-25). The macro is used ten times in the body (main.tex:30-31).

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:1)
- Class-native vocabulary used: none (the body has no `\maketitle`, no sectioning, no `abstract`; it is one `tabular`)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | `a4paper` |
| paper size | main.tex:1 | `page.class-options` | `a4paper` |
| page geometry | main.tex:2 | `page.geometry` | `margin=0.4cm` |
| font encoding | main.tex:3 | `font.fontenc-t1` | `T1` |
| text font | main.tex:4 | `font.lmodern` | no options |
| colour package | main.tex:5 | `color.xcolor` | loaded in the same `\usepackage` as `tikz` and `qrcode` |
| colour definitions | main.tex:7-8 | `color.xcolor` | `\definecolor{blue}{HTML}{1D4ED8}`, `\definecolor{yellow}{HTML}{FACC15}` (the names `blue` and `yellow` are redefined) |
| header and footer | main.tex:6 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| card face (outline, masthead band, yellow tab, positioned text) | main.tex:5, 9-26 | `art.tikz` | **ART**: `tikzpicture` with `\draw[fill=white,draw=blue,line width=.8pt]`, two `\fill` rectangles, five `\node[anchor=...] at (x,y)`; coordinates in cm, card 8.6 by 5.4 (main.tex:11-23) |
| card text styling inside the nodes | main.tex:14, 16, 18, 20, 22 | `mark.kernel`, `font.size-commands` | `\sffamily` `\bfseries` and `\Large` `\small` `\large` `\scriptsize`; part of the ART picture |
| QR code on the card | main.tex:5, 24-25 | `art.content-package` | `\qrcode[height=1.28cm]{<url>}` from the `qrcode` package (CTAN); inside the ART picture, the URL is content |
| card sheet layout (2 columns, 5 rows) | main.tex:29-32 | `tbl.tabular` | `tabular{cc}` used as a layout grid, ten `\card` cells; `\\[.15cm]` row gaps via `sp.manual-space` |
| paragraph start | main.tex:29 | `sp.lengths` | `\noindent` (kernel paragraph-indent family with `\parindent`; the lib has no line that names `\noindent`, immaterial to the verdict) |

Considered and not used: `ticket.sheet` (`ticket` package: imposed sheet of tickets and cards). The source does not load it and builds the grid with `tabular`; the lib line itself says the ticket face is outside the way (content, or ART when it draws the template's identity), so it would not remove the ART blocker.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\card` (no-argument macro wrapping one picture) | main.tex:9-27 | no (as typesetting); the macro wrapper itself is a plain alias | The alias is trivial, but its body is TikZ artwork with absolute coordinates and per-node fonts. `tcolorbox` would still need its `overlay` TikZ code for the nodes, so no declarative way holds it: `ART/preamble` |

No zip-local class, style, counter, conditional or other macro exists (the only `\newcommand` is `\card`, main.tex:9).

## Content-opaque
- QR code symbol encoding `https://taylorbrooks.example` (main.tex:24-25), recorded under `art.content-package`.
- Card texts: wordmark, name, role, e-mail and phone (main.tex:15, 17, 19, 21, 23).

## Lib changes
- New ways proposed: none (`qrcode` is filed under the existing `art.content-package` as a specialised content package; considered: `qrcode` as its own component way, not proposed, since the QR symbol sits inside the ART picture and does not change the verdict).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
