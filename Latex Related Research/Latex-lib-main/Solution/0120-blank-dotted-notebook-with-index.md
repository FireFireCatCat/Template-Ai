no

# 0120-blank-dotted-notebook-with-index: Blank Dotted Notebook with Index

- Unverified: read from the source, not compiled.
- Source: Source/0120-blank-dotted-notebook-with-index/ (origin: https://latextemplates.com/downloads/blank-dotted-notebook.zip; licence: not established (the manifest says "Unknown"; README.md:8-10 says the upstream licence status is unresolved))
- Kind: misc (a printable dotted notebook / lab-book starter; the manifest hint "book" is wrong, the sample is a short article-class notebook)
- Lib: v2
- Engine: pdfLaTeX-compatible (README.md:8 says "Compile with PDFLaTeX"; nothing in main.tex needs XeLaTeX or LuaLaTeX; the TikZ `remember picture` overlay needs two TeX runs, which is TeX-only, not an external tool)
- Look carried by: preamble (no zip-local class or style; the look is `article` plus the packages and the `\dotpage` macro in main.tex:1-23, and the body in main.tex:25-74)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex and README.md; `article`'s own source was not read)

## Verdict
No. Almost everything maps to existing lib ways with simple parameters (`article` at `a5paper`, `geometry`, `fancyhdr`, `tabular`, `enumitem`, `multicol`, kernel rules and spacing). But the template's identity is its dotted writing page, and that is a hand-written TikZ overlay inside the `\dotpage` macro (main.tex:15-23): a `remember picture,overlay` picture that draws a 5 mm dotted-line grid between page-corner anchors on each entry page. It is template-defining artwork with no declarative lib way, so it is an `ART` blocker. Nothing else in the sample blocks.

## Blockers
- `ART/preamble` dotted-grid page background drawn by TikZ inside the macro `\dotpage`: `\draw[step=5mm,gray!35,very thin,dotted] (...current page.north west) grid (...current page.south east)` (main.tex:17-20); the macro is defined in the preamble (main.tex:15-23) and called in the body at main.tex:58, 63, 68. This is what makes the notebook "dotted", so it is identity, not figure content.

## Class setting
- Class: `class.article` options: `10pt`, `a5paper` (main.tex:1)
- Class-native vocabulary used: `\section*` (unnumbered sectioning, main.tex:39, 49, 59, 64, 69), `center`, `tabular`, `itemize`, `enumerate` (kernel). No `\maketitle`, no `abstract`, no `\tableofcontents`, no `\bibliography`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 10pt, a5paper |
| paper and base size | main.tex:1 | `page.class-options` | a5paper, 10pt |
| page geometry | main.tex:2 | `page.geometry` | margin=15mm, includeheadfoot |
| header/footer | main.tex:5, 9-13 | `hf.fancyhdr` | `\pagestyle{fancy}`; `\fancyhf{}` clears all fields; `\fancyhead[L]{\small Field notebook}`, `\fancyhead[R]{\small Your project}`; `\fancyfoot[C]{\thepage}`; head rule left at the fancyhdr default (not set in the source) |
| head height | main.tex:14 | `page.setlength` | `\headheight` = 13pt (nearest: a raw page-box length used with fancyhdr) |
| header text size | main.tex:11-12 | `font.size-commands` | `\small` |
| per-page page style | main.tex:16 | `hf.pagestyle-kernel` | `\thispagestyle{fancy}` after `\clearpage` (redundant with the global style, main.tex:9) |
| page breaks | main.tex:16, 38 | `pg.break` | `\clearpage` |
| colours | main.tex:3, 18, 52-55 | `color.xcolor` | `gray!35` (grid), `blue`, `red`, `green!50!black`, `orange` through `\textcolor` (label bullets) |
| dotted page background | main.tex:4, 17-21 | `art.tikz` | `tikzpicture[remember picture,overlay]`, `grid` path op, `step=5mm`, `very thin`, `dotted`, corners inset 12mm/18mm (top left) and -12mm/15mm (bottom right) from `current page`; **ART** (see Blockers) |
| cover block | main.tex:25-37 | `front.titlepage-env` | hand-laid cover inside `center` (no `\maketitle`, no `titlepage` environment, so this is the nearest front way, not an exact one); built from the rows below |
| cover centring | main.tex:25, 35 | `sp.ragged` | kernel `center` environment (the environment form of `\centering`) |
| cover and entry type sizes | main.tex:26-27 | `font.size-commands` | `\LARGE`, `\large` |
| bold and italic | main.tex:22-23, 26, 29, 37, 41, 60-62, 65-67 | `mark.kernel` | `\bfseries`, `\textbf`, `\textit` |
| vertical and horizontal spacing | main.tex:22-23, 26-28, 36, 41, 61-62, 65-66 | `sp.manual-space` | `\medskip`, `\vspace{12mm}`, `\vspace{5mm}`, `\vspace*{4mm}`, `\vspace{8mm}`, `\vspace{3mm}`, `\vfill`, `\hfill`, `\quad`, `\\[2pt]` |
| fill-in rules | main.tex:22-23, 28, 65-66 | `sp.rule` | `\rule{35mm}{.4pt}`, `\rule{12mm}{.4pt}`, `\rule{.75\linewidth}{.6pt}`, `\rule{25mm}{.4pt}` |
| cover info table | main.tex:6, 29-34 | `tbl.tabular` | `array` column prefix `>{\bfseries}p{32mm}p{72mm}` |
| index page | main.tex:39-48 | `tbl.tabular` | hand-typed 3-column table, `@{}p{13mm}p{75mm}p{18mm}@{}`, header row, `\hline` after `\\[2pt]`; not a real index (no `\makeindex` or `\printindex`) |
| headings | main.tex:39, 49, 59, 64, 69 | `head.kernel` | `\section*{...}` at the class default look; the "1." to "3." numbers are typed into the titles by hand (content) |
| key list in two columns | main.tex:8, 50-57 | `cols.multicol` | `multicols{2}` |
| key list | main.tex:7, 51-56 | `list.kernel` | `itemize` |
| key list options | main.tex:7, 51-55 | `list.enumitem` | `leftmargin=*`, `itemsep=2pt`, custom label `\item[\textcolor{..}{\textbullet}]` |
| follow-up list | main.tex:70-74 | `list.kernel` | `enumerate` |
| follow-up list options | main.tex:7, 70 | `list.enumitem` | `leftmargin=8mm` |

Not rows: `\noindent` and `\par` (main.tex:22-23, 37, 60-67) are kernel paragraph-flow commands in the content; `\textbullet`, `\,` and the raw `°` (main.tex:52-55, 61) are glyph content under the kernel's default UTF-8 input. Nothing is set for fonts (no font package, default Computer Modern, no `fontenc`), maths, theorems, floats, captions, footnotes, code, boxes, cross-references, bibliography, language or PDF metadata: the sample uses none (no `\label`, no `\begin{figure}`, no `hyperref`).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\dotpage` macro | main.tex:15-23 (called main.tex:58, 63, 68) | no (ART) | The wrapper parts reduce: `\clearpage` (`pg.break`), `\thispagestyle{fancy}` (`hf.pagestyle-kernel`), `\vspace*{4mm}`/`\hfill`/`\vspace{8mm}` (`sp.manual-space`), `\textbf{Entry date:} \rule{35mm}{.4pt}` and `\textbf{Page:} \rule{12mm}{.4pt}` (`mark.kernel`, `sp.rule`). The TikZ overlay at main.tex:17-21 is a free drawing positioned on `current page`, so it is `art.tikz` used for template identity, hence `ART/preamble`. |

No other `\newcommand`, `\def`, environment, counter or conditional is defined; no zip-local class or style exists.

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered, not proposed: `tikzpagenodes` (`bg.tikzpagenodes` is the nearest lib way, but the sample does not load it and the lib line itself marks it ART when it draws the template's identity). Considered: `gridpapers` (CTAN, "preset yet customizable graph paper backgrounds" including a dot grid, size and colour options; seen only on its ctan.org/pkg page, documentation not read). It is not proposed because I cannot show it reproduces this page: the sample draws a dotted-line grid (`dotted` style on a `grid` path, `step=5mm`) inset from the page corners (12mm left, 18mm top, 12mm right, 15mm bottom) on only the three entry pages, not on the cover, index or key page (main.tex:17-20, 58, 63, 68). If a later reading of its manual shows it can place a page-selective, inset dotted-line grid declaratively, the page background would reduce to it and the verdict could become `yes` after proposing it.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
