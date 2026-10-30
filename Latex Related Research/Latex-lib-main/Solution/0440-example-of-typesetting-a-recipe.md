no

# 0440-example-of-typesetting-a-recipe: Example of Typesetting a Recipe

- Unverified: read from the source, not compiled.
- Source: Source/0440-example-of-typesetting-a-recipe/ (origin: https://latextemplates.com/downloads/typesetting-recipe-example.zip; licence: Other (as stated in the work) per the manifest; the zip carries no licence text and README.md:5 calls the upstream grant uncertain)
- Kind: misc
- Lib: v4
- Engine: pdfLaTeX-compatible (T1, lmodern, xcolor, fancyhdr, multicol, enumitem, tikz: no fontspec or Lua)
- Look carried by: preamble (plain `article`; the look is the preamble at main.tex:2-12 and the `\recipe` macro at main.tex:13-16, with a hand-laid cover at main.tex:18)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex and README.md; the kernel `article` source was not read)

## Verdict
`no`. Almost everything reduces to lib ways: class `article`, geometry, fonts, colours, a `fancyhdr` head and foot, a two-column `multicols` spread, an `enumitem` list, and a `\newcommand` (`\recipe`) that only composes those, so inline expansion per recipe is enough. The blocker is the cover emblem at main.tex:18, a TikZ drawing (a circle and two arcs) set straight on the cover page, outside any float. The README lists "a small TikZ illustration" among the layout features (README.md:3). The rubric treats such template-identity artwork as ART when no declarative lib way holds it, and none does. If a reviewer rules the emblem a replaceable illustration slot, that is content and the only blocker goes away, so the verdict would flip to `yes` with no other change.

## Blockers
- `ART/body` cover emblem: `\begin{tikzpicture}\draw[olive,line width=1.2pt] (0,0) circle (13mm);` plus two `terracotta` 1pt arcs (200 to 340 and -20 to 160 degrees, radius 9mm), centred on the title page between the subtitle and the author line (main.tex:18).

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (main.tex:1)
- Class-native vocabulary used: kernel `center` and `itemize` only (main.tex:16, 18, 19). The sample uses no `\maketitle`, `\title`, `abstract` or sectioning command, so the cover is hand-laid in the body.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 11pt, a4paper |
| paper and base size | main.tex:1 | `page.class-options` | a4paper, 11pt |
| page geometry | main.tex:2 | `page.geometry` | margin=20mm (all four sides) |
| encoding | main.tex:3 | `font.fontenc-t1` | fontenc T1 |
| text face | main.tex:4 | `font.lmodern` | lmodern |
| colour definitions | main.tex:5, 12 | `color.xcolor` | `\definecolor` HTML: olive 6A783C (redefines xcolor's base name), terracotta B65D43, paper FFF9EF |
| running head and foot | main.tex:6, 10 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, head L `\small\sffamily THE RECIPE NOTEBOOK`, head R `\small\textcolor{olive}{SEASONAL}`, foot C `\thepage`; rule and lengths left at defaults |
| paragraph indent | main.tex:11 | `sp.lengths` | `\parindent` = 0pt |
| list spacing and margin | main.tex:8, 11 | `list.enumitem` | `\setlist{nosep,leftmargin=*}` (applies to every list) |
| ingredients list | main.tex:19, 20 | `list.kernel` | `itemize`, five `\item` per recipe, bullet label from the class |
| cover: block alignment | main.tex:18 | `sp.ragged` | `center` environment around the whole cover |
| cover: title and subtitle | main.tex:18 | `font.size-commands` | `\fontsize{34}{39}\selectfont` for TABLE NOTES; `\large` for the subtitle |
| cover: face and weight | main.tex:18 | `mark.kernel` | `\sffamily\bfseries` (no `\maketitle`; a hand-laid block of existing ways) |
| cover: colour | main.tex:18 | `color.xcolor` | `\color{terracotta}` title, `\textcolor{olive}` author line |
| cover: spacing | main.tex:18 | `sp.manual-space` | `\vspace*{20mm}`, `\smallskip`, `\vspace{20mm}`, `\vfill`, `\quad`; `\textbullet` between name and year is a symbol in the content |
| cover emblem | main.tex:9, 18 | `art.tikz` | ART: `\draw` circle r=13mm olive 1.2pt, two arcs r=9mm terracotta 1pt |
| page break before each recipe | main.tex:14 | `pg.break` | `\clearpage` (also ends the cover page) |
| recipe page background | main.tex:14 | `color.pagecolor` | `paper` (FFF9EF), reduced from a TikZ overlay: `[remember picture,overlay]` `\fill[paper] (current page.south west) rectangle (current page.north east)`; see Bespoke code for a painting-order caveat |
| recipe title | main.tex:15 | `font.size-commands` | `\fontsize{25}{29}\selectfont`, after `\vspace*{7mm}` |
| recipe title face and colour | main.tex:15 | `mark.kernel` | `\sffamily\bfseries`, with `color.xcolor` `\color{terracotta}` |
| yield and time line | main.tex:15 | `color.xcolor` | `\textcolor{olive}{#2}`, `\hspace{1em}`, terracotta bullet, `\hspace{1em}`, `#3` (spacing is `sp.manual-space`) |
| divider | main.tex:15 | `sp.rule` | `\rule{\linewidth}{1pt}` in terracotta, between `\medskip` gaps (`sp.manual-space`) |
| ingredients and method spread | main.tex:7, 16 | `cols.multicol` | `multicols{2}`, one `\columnbreak` between the ingredients and the method |
| column headings | main.tex:16 | `mark.kernel` | `\sffamily\bfseries INGREDIENTS` and `PREPARATION` in olive (`color.xcolor`), then `\smallskip` |
| footer note on the page | main.tex:16 | `sp.manual-space` | `\vfill` pushes it down; `center` (`sp.ragged`), `\small` (`font.size-commands`), `\textit` (`mark.kernel`) |
| `\recipe` as a whole | main.tex:13-16, 19, 20 | the rows above, in order | five arguments: title, yield, time, ingredients, method |

Not present in the sample, so no row: sectioning, abstract, contents, floats, tables, captions, maths, theorems, footnotes, citations, hyperref, language packages.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\recipe}[5]` | main.tex:13-16 | yes | Pure composition. Per recipe the emitter writes: `\clearpage`, `\pagecolor{paper}`, `\vspace*{7mm}`, a group `{\sffamily\bfseries\color{terracotta}\fontsize{25}{29}\selectfont <title>}`, `\par\smallskip`, the olive yield, bullet and time line, `\par\medskip`, the 1pt terracotta `\rule{\linewidth}{1pt}`, `\par\medskip`, `multicols{2}` with the ingredients, `\columnbreak` and the method, then `\vfill` and the centred small italic note. No counters, conditionals or output-routine code. |
| TikZ page fill inside `\recipe` | main.tex:14 | yes, with a caveat | The whole effect is one flat colour over the page: `color.pagecolor` with `paper`. Caveat (not verified, nothing compiled): the kernel ships out head box, body, then foot, so an opaque fill drawn from the body would likely paint over the running head on recipe pages, while `\pagecolor` paints behind it. If that matters, the exact effect is only reproducible as the same TikZ overlay (`art.tikz`). I record it as a fidelity note, not a blocker, because the page background colour is the template's evident intent. |
| TikZ cover emblem | main.tex:18 | no | A free drawing (circle and two arcs), no declarative lib way. ART/body. |
| `\definecolor` x3 | main.tex:12 | not bespoke | Published `xcolor` declarations (`color.xcolor`). |

## Content-opaque
none (the cover emblem is not held as content here: it is the ART blocker above; recipe text, the ingredient items and the cover strings are plain content)

## Lib changes
- New ways proposed: none. `recipe.xcookybooky` is in the lib but this zip loads no recipe package, so it is not used; the `\recipe` macro is zip-local and reduces as shown.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
