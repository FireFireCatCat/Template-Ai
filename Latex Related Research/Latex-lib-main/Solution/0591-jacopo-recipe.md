yes

# 0591-jacopo-recipe: Jacopo Recipe (a one-page two-column recipe card)

- Unverified: read from the source, not compiled.
- Source: Source/0591-jacopo-recipe/ (origin: https://latextemplates.com/downloads/jacopo-recipe.zip; licence: not established, the manifest says "N/A — original starter, no upstream package")
- Kind: misc (a recipe card; the manifest hint is also misc)
- Lib: v5
- Engine: pdfLaTeX-compatible (`fontenc` T1 and `inputenc` utf8 at main.tex:4-5; no fontspec, no Lua)
- Look carried by: preamble (the zip is one `main.tex` on the kernel `article` class; the look is the packages at main.tex:3-8, the colour at main.tex:10, the page style at main.tex:12, one `\newcommand` at main.tex:14-22, and hand-formatted body markup)
- Class origin: tex-distribution-unbundled (kernel `article`, main.tex:1; not in the zip; its source was not read)
- Main file: main.tex (other samples: none; the zip holds one file of 95 lines and no .cls, .sty, .def, .cfg, .clo, .bst or .dtx)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The zip is one 95-line sample on the kernel `article` class with `geometry`, `fontenc`/`inputenc`, `xcolor`, `enumitem` and `paracol`, a kernel page style, and one zip-local `\newcommand` (`\recipetitle`) that only stacks kernel rules, font switches, colour and skips, so it reduces by inline expansion at its single call. There is no zip-local class or style, no artwork, no external tool, and no component without a lib way. The lib has a recipe way (`recipe.xcookybooky`) but the sample does not load it; the card is built by hand from the ways below, so that way is considered, not used.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `11pt` (main.tex:1)
- Class-native vocabulary used: `\documentclass`, `document` environment, `center` environment (main.tex:15), `itemize` (main.tex:36), `enumerate` (main.tex:65), `\pagestyle` (main.tex:12); the sample uses no `\maketitle`, no `abstract` and no `\section`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | a4paper, 11pt |
| paper size and base font size | main.tex:1 | `page.class-options` | a4paper, 11pt |
| page geometry | main.tex:3 | `page.geometry` | margin=2.2cm (all four sides) |
| encoding and glyphs | main.tex:4-5, 36, 56, 67 | `font.fontenc-t1` | `fontenc` T1, `inputenc` utf8 (literal `Côtes du Rhône` at main.tex:56), `\textbullet` (main.tex:36), `\textdegree` (main.tex:67) |
| text face | main.tex:1-8 | (no font way) | no font package is loaded, so the default Computer Modern stays; nothing to emit |
| colour definition | main.tex:6, 10 | `color.xcolor` | `\definecolor{accent}{HTML}{7A2E2E}` |
| colour use | main.tex:16, 19, 32, 36, 53, 62, 66, 87 | `color.xcolor` | `\color{accent}` on rules, part labels and list labels |
| page style | main.tex:12 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no header, footer or page number) |
| title block (hand-laid macro) | main.tex:14-22, 26 | composition of the five rows below | no `front.*` way is needed: `\recipetitle` is inline-expanded at its one call; the title text and the subtitle line (main.tex:26) are content |
| title block, alignment | main.tex:15, 20 | `sp.ragged` | kernel `center` environment (the `\centering` family) |
| title block, rules | main.tex:16, 19 | `sp.rule` | `\rule{0.4\linewidth}{1pt}` in colour `accent` |
| title block, sizes | main.tex:17-18 | `font.size-commands` | `\Large` (title), `\small` (subtitle) |
| title block, font switches | main.tex:17-18 | `mark.kernel` | `\bfseries` (title), `\itshape` (subtitle) |
| title block, skips | main.tex:16-18, 21, 26 | `sp.manual-space` | `\\[4pt]`, `\\[2pt]`, `\\[2pt]`, `\vspace{0.6em}`; the subtitle separators `\quad\|\quad` at main.tex:26 |
| two parallel columns | main.tex:8, 28, 31, 58, 60, 93 | `cols.paracol` | `paracol{2}` environment, `leftcolumn` environment (main.tex:31-58), `\switchcolumn` (main.tex:60) into the right column, which has no wrapper |
| column gutter | main.tex:29 | `cols.paracol`, `sp.lengths` | `\setlength{\columnsep}{1.8em}`, a raw length that the `paracol` gutter reads, set inside the `paracol` environment |
| part labels (hand-formatted, no sectioning) | main.tex:32, 53, 62, 87 | `mark.kernel` | `{\color{accent}\bfseries ...}` for Ingredients, Wine Pairing, Method, Chef's Note; no `\section` is used |
| part labels, colour | main.tex:32, 53, 62, 87 | `color.xcolor` | `\color{accent}` |
| part labels, skips | main.tex:33, 52, 54, 63, 86, 88 | `sp.manual-space` | `\vspace{0.4em}` after each of the four labels (main.tex:33, 54, 63, 88), `\vspace{1em}` before Wine Pairing and before Chef's Note (main.tex:52, 86) |
| ingredient list | main.tex:7, 36-49 | `list.enumitem` | `itemize[leftmargin=1.1em, itemsep=3pt, label={\color{accent}\textbullet}]` |
| ingredient list, environment | main.tex:36-49 | `list.kernel` | `itemize` with 12 `\item` rows (main.tex:37-48) |
| italic ingredient text | main.tex:35, 50 | `mark.kernel` | `itshape` environment around the list |
| method list | main.tex:7, 65-84 | `list.enumitem` | `enumerate[leftmargin=1.6em, itemsep=6pt, label={\color{accent}\bfseries\arabic*.}]` |
| method list, environment | main.tex:65-84 | `list.kernel` | `enumerate` with 8 `\item` rows (main.tex:67, 69, 72, 74, 76, 78, 80, 82) |
| wine pairing paragraph | main.tex:56-57 | `mark.kernel` | `\textit{...}` |
| unit and value spacing | main.tex:43-45 | `sp.manual-space` | `250\,ml`, `400\,g`, `500\,ml` (thin space in running text) |
| chef's note paragraph | main.tex:90-91 | (content) | plain text with no markup; the `---` and `--` dashes at main.tex:75, 78, 81, 90-91 are content characters |

No heading, front-matter, abstract, contents, math, theorem, float, table, caption, code, box, bibliography, index, cross-reference, language, metadata or note component appears in the sample (a search of main.tex for `\section`, `\maketitle`, `\label`, `\ref`, `figure`, `tabular`, `\cite`, `babel` and `hyperref` finds none; the document body is main.tex:24-95).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\recipetitle` (`\newcommand`, 2 arguments) | main.tex:14-22, called once at main.tex:26 | yes | Inline expansion at the one call: `center` environment (`sp.ragged`) holding `{\color{accent}\rule{0.4\linewidth}{1pt}}\\[4pt]` (`color.xcolor`, `sp.rule`, `sp.manual-space`), `{\Large\bfseries #1}\\[2pt]` (`font.size-commands`, `mark.kernel`), `{\small\itshape #2}\\[2pt]` (same ways), the closing coloured rule, then `\vspace{0.6em}` (`sp.manual-space`). No counter, conditional, `\def` or box algorithm; the two arguments are plain text. |

No other `\newcommand`, `\def`, `\newenvironment`, counter or conditional is defined in main.tex. The `accent` colour is a published `\definecolor` call, not bespoke code. The `leftcolumn` environment and the `\switchcolumn` command belong to the published `paracol` package (main.tex:8), not to the zip.

## Content-opaque
none (no figure, table, TikZ, image or code listing in the sample)

## Lib changes
- New ways proposed: none (every row uses an existing lib way; `class.article` is a class way and needs no proposal; considered: `xcookybooky`, the lib's `recipe.xcookybooky`, not used because the sample does not load it).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
