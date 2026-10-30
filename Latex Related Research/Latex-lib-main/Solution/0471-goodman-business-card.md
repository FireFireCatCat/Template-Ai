no

# 0471-goodman-business-card: Goodman Business Card

- Unverified: read from the source, not compiled.
- Source: Source/0471-goodman-business-card/ (origin: https://latextemplates.com/downloads/goodman-business-card.zip; licence: GPL-3.0)
- Kind: misc (a business card sheet: 8 cards imposed on US Letter)
- Lib: v4
- Engine: needs XeLaTeX (`fontspec` with `\setmainfont` by font name, main.tex:18,22-24; the first line also asks for xelatex, main.tex:1)
- Look carried by: preamble (the whole card face is one `\newcommand` holding a `tikzpicture`, main.tex:34-52; the class is plain article)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
No. The page setup (`geometry`, `parskip`, `fontspec`, `xcolor`, kernel `\pagestyle{empty}`) all map to lib ways, but the template's identity is the card face. That face is a `tikzpicture` of absolutely positioned nodes, a hairline border and two coloured rules (main.tex:34-52), repeated 8 times (main.tex:58-61). It is template-defining TikZ artwork, which the rubric makes `ART`, and it does not reduce to a declarative lib way. Even if the 2 x 4 imposition were moved to `ticket.sheet`, that lib line leaves the ticket face outside the way (content, or ART when it draws the template's identity). Only the card text (name, title, contact strings) is content, and the geometry around it is not.

## Blockers
- `ART/preamble` card face drawn as one `tikzpicture` (`x=1in,y=1in`): bounding box and `black!25` border rectangle (main.tex:36-37), a centred name node at y=1.65in and a title node at y=1.42in (main.tex:38-39), two 1pt green rules at y=1.22in and y=0.16in (main.tex:40,49), four label/value rows at y=1.00, 0.78, 0.56, 0.34in with the labels at x=w/2-0.9in and the values at x=w/2-0.62in (main.tex:41-48), a centred tagline node `text width=2.6in` at y=0.08in (main.tex:50). The macro is defined in the preamble (main.tex:34-52) and called in the body (main.tex:58-61).

## Class setting
- Class: `class.article` options: `10pt` (main.tex:14)
- Class-native vocabulary used: none. The sample uses no `\maketitle`, `abstract`, sectioning or theorem command. The class only supplies the page and font-size defaults.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:14 | `class.article` | `10pt` |
| base font size | main.tex:14 | `page.class-options` | `10pt` (the article default size) |
| page geometry | main.tex:16 | `page.geometry` | paperwidth=8.5in, paperheight=11in, margin=0.5in, noheadfoot (text block 7.5in x 10in; two 3.5in cards fit across) |
| paragraph spacing | main.tex:17 | `sp.parskip-pkg` | no options |
| paragraph indent | main.tex:56 | `sp.lengths` | `\setlength{\parindent}{0pt}` |
| main, sans and mono fonts | main.tex:18,22-24 | `font.fontspec` | `\setmainfont{Nimbus Sans}`, `\setsansfont{Nimbus Sans}`, `\setmonofont{DejaVu Sans Mono}`; system fonts, not shipped (see Content-opaque and notes) |
| colours | main.tex:20,29-32 | `color.xcolor` | `\definecolor` HTML: seplinecolour 357f2d, labelcolour 357f2d, textcolour 2f3142, jobtitlecolour 474a65; the border colour is the expression `black!25` (main.tex:37) |
| header and footer | main.tex:55,16 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (and `noheadfoot` in `geometry`) |
| font sizes inside the card | main.tex:38-39,41-50 | `font.size-commands` | `\Large` (name), `\normalsize` (title), `\footnotesize` (rows and tagline) |
| bold and italic inside the card | main.tex:39,41,43,45,47,50 | `mark.kernel` | `\itshape` (title), `\bfseries` (row labels, tagline) |
| sheet imposition: 2 cards per line, 4 lines | main.tex:57-61 | `sp.manual-space` | eight `\BusinessCardFace` calls, `\par\vspace{0pt}` after each pair (main.tex:58-60); `\noindent` and `\par` are plain paragraph flow; the 2 x 4 grid comes from card size against the text block, not from a package |
| card face (border, text nodes, rules, labels, tagline) | main.tex:34-52 | `art.tikz` | `tikzpicture[x=1in,y=1in]`, `\useasboundingbox`, `\draw` rectangle and lines, `\node[anchor=...,font=...,color=...]` at fixed coordinates: **ART**, template-defining |
| card size values | main.tex:26-27 | `sp.lengths` | `\newlength{\cardwidth}` = 3.5in, `\newlength{\cardheight}` = 2in (helper lengths feeding the TikZ coordinates) |

Not used by the sample (no row): title block, abstract, contents, headings, numbering, lists, quotes, notes, maths, theorems, floats, tables, captions, code, boxes, bibliography, index, cross-references, language setup, PDF metadata.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\cardwidth`, `\cardheight` lengths | main.tex:26-27 | yes | inline the constants 3.5in and 2in; no logic |
| four `\definecolor` names | main.tex:29-32 | yes | `color.xcolor`, HTML model, the hex values listed above |
| `\BusinessCardFace` | main.tex:34-52 | no | an alias for one `tikzpicture` whose absolute coordinates, anchors and rules are the design. A flow-layout rebuild (`\parbox`, `\rule`, `\fcolorbox`) would be a different construction, not this look. `ART/preamble` |

## Content-opaque
- The card text is content: name, title, four labels and values, tagline, and the `\textbullet` separators (main.tex:38-50). The sample's comment says the upstream design used Fira Sans/Fira Mono and Font Awesome icons and that plain text labels replace the icons here (main.tex:6-13). This is a comment about the design, not an instruction to anyone.
- Fonts are not shipped in the zip: `Nimbus Sans` and `DejaVu Sans Mono` (main.tex:22-24) are looked up on the system by name. Ship them with the template; this is a missing asset, not a blocker.
- The TikZ geometry is not content here: it draws the template's own face, so it is the ART blocker above, not a `Content-opaque` item.

## Lib changes
- New ways proposed: none. (`ticket.sheet` was considered for the imposition, but the sample does not load the `ticket` package and the lib line leaves the face outside the way.)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
