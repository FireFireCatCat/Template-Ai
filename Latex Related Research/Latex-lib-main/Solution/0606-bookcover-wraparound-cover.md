yes

# 0606-bookcover-wraparound-cover: Bookcover Wraparound Cover (CTAN `bookcover` starter)

- Unverified: read from the source, not compiled.
- Source: Source/0606-bookcover-wraparound-cover/ (origin: https://latextemplates.com/downloads/bookcover.zip; licence: LPPL-1.2-or-later)
- Kind: misc (a wraparound paperback cover: front, spine, back panels; not a text document)
- Lib: v5
- Engine: pdfLaTeX-compatible (not established: the `bookcover` class source was not read and its CTAN page names no engine; the sample itself uses only pdfTeX-safe commands)
- Look carried by: mixed (the cover model of three panels, bleed and trim marks belongs to the published class `bookcover`, main.tex:1-7 and README.md:3-5; the panel designs are body wrappers in kernel boxes, main.tex:14-38; the preamble adds two colours, main.tex:8-10)
- Class origin: tex-distribution-unbundled (README.md:9-10 says the class is supplied by TeX Live and is not in the zip; ctan.org/pkg/bookcover lists it as a class, v4.1, LPPL 1.2, in TeX Live and MiKTeX)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex and README.md; the `bookcover` class source was not read)

## Verdict
The zip has no zip-local class, style, macro, environment or counter. The whole sample is one published class (`bookcover`, on CTAN and in TeX Live) with five option values, plus two `xcolor` colours, plus panel bodies written with kernel and `graphicx` boxes, rules, colours and font switches. Each of these maps to an existing lib way, and there is no drawing code (`ART`) and no outside tool in the sample. The caveats are that the class source was not read, so its panel, bleed and trim-mark behaviour is taken from the README and the class-native commands as used, and that the engine and the hidden package loads of the class are not established.

## Blockers
none

## Class setting
- Class: `class.bookcover` options: coverwidth=156mm, coverheight=234mm, spinewidth=14mm, bleedwidth=3mm, cover=front (main.tex:1-7)
- Class-native vocabulary used: environment `bookcover` (main.tex:13, 39); command `\bookcovercomponent{kind}{panel}{content}` with kind `color` or `normal` and panel names `bg whole`, `bg spine`, `back`, `spine`, `front` (main.tex:14-16, 27, 30); class lengths `\partwidth` and `\partheight` used as the width and height of the current panel (main.tex:17, 31; defined by the class, not in the zip, source not read). README.md:3-5 says the class produces front, spine, back, bleed and trim marks.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1-7 | `class.bookcover` | coverwidth=156mm, coverheight=234mm, spinewidth=14mm, bleedwidth=3mm, cover=front |
| page size, spine, bleed | main.tex:2-5 | `page.class-options` | trim size 156mm x 234mm, spine 14mm, bleed 3mm, all set by class options |
| colour definitions | main.tex:8-10 | `color.xcolor` | `\usepackage{xcolor}`; `\definecolor{coverblue}{HTML}{123B5D}`, `\definecolor{covergold}{HTML}{E8B44F}` |
| cover wrapper, panels and trim marks | main.tex:13, 39; README.md:3-5 | `front.class-native` | `bookcover` environment; one `\bookcovercomponent` per panel; `cover=front` is a class option (main.tex:6) |
| whole-cover background fill | main.tex:14 | `front.class-native` | `\bookcovercomponent{color}{bg whole}{coverblue}` |
| spine background fill | main.tex:15 | `front.class-native` | `\bookcovercomponent{color}{bg spine}{covergold}` |
| back panel content | main.tex:16-26 | `front.class-native` | `\bookcovercomponent{normal}{back}{...}` holding a `\parbox` |
| spine panel content | main.tex:27-29 | `front.class-native` | `\bookcovercomponent{normal}{spine}{...}` holding a rotated text |
| front panel content | main.tex:30-38 | `front.class-native` | `\bookcovercomponent{normal}{front}{...}` holding a `\parbox` |
| panel text block (back) | main.tex:17 | `box.minipage` | `\parbox[c][0.72\partheight][c]{0.82\partwidth}`: centred, height and width as fractions of the panel lengths |
| panel text block (front) | main.tex:31 | `box.minipage` | `\parbox[c][0.82\partheight][c]{0.78\partwidth}` |
| spine title rotated | main.tex:28 | `fig.rotating` | `\rotatebox[origin=c]{90}{...}` (graphicx command; the sample does not load `graphicx`, so the class must load it: not verified) |
| text colour | main.tex:18, 28, 32, 35, 36 | `color.xcolor` | `\color{white}`, `\color{coverblue}`, `\color{covergold}` (colours from main.tex:9-10) |
| alignment | main.tex:18, 32 | `sp.ragged` | `\raggedright` (back), `\centering` (front) |
| font sizes | main.tex:19, 28, 33, 34, 36 | `font.size-commands` | `\Large`, `\large`, `\Huge`, `\small` |
| font weight and shape | main.tex:19, 23, 28, 33 | `mark.kernel` | `\bfseries`, `\textsc` |
| vertical spacing | main.tex:19, 21, 22, 33-35 | `sp.manual-space` | `\medskip`, `\smallskip`, `\vfill` between paragraphs (`\par` is the kernel paragraph break) |
| rules | main.tex:22, 35 | `sp.rule` | `\rule{0.7\linewidth}{0.4pt}` (back); `\rule{0.55\linewidth}{1.5pt}` in `covergold` (front) |

Components the sample does not define or use: headings, header and footer, fonts beyond the default, language and meta, abstract, contents, lists, quotes, notes, math, theorems, floats, tables, captions, code, bibliography, index, cross-references.

## Bespoke code
none. The sample has no `\newcommand`, `\def`, environment, counter or conditional (main.tex is 40 lines; read in full), and no zip-local `.cls` or `.sty`.

## Content-opaque
none. The text on the panels is placeholder content (main.tex:19-24, 28, 33-36).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
