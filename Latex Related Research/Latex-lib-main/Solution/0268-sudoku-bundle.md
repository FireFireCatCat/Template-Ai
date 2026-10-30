yes

# 0268-sudoku-bundle: Sudoku Bundle (worksheet starter)

- Unverified: read from the source, not compiled.
- Source: Source/0268-sudoku-bundle/ (origin: https://latextemplates.com/downloads/sudokubundle.zip; licence: LPPL-1.3-or-later (manifest; README.md:15 says LPPL 1.3 or later, Peter R. Wilson))
- Kind: misc (a puzzle worksheet: title, a printed Sudoku, then the solver's view and a short workflow note)
- Lib: v3
- Engine: pdfLaTeX-compatible (the sample uses `fontenc` T1 + `inputenc` utf8 and no `fontspec`, main.tex:3-4; the sudokubundle sources are not in the zip and ctan.org/pkg/sudokubundle names no engine or tool requirement, so this is read from the sample and the CTAN page, not from the package code)
- Look carried by: preamble (a plain `article` plus published packages `printsudoku` and `solvesudoku` loaded in the preamble, main.tex:6-7; no zip-local class, style or macro; the grid itself is drawn inside the published package, whose source was not read)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; the zip also holds README.md and the data file puzzle.sud)
- Read: main yes, zip-local classes and styles none present (the whole zip is 62 lines: main.tex 36, puzzle.sud 11, README.md 15; the published `printsudoku.sty` and `solvesudoku.sty` ship with TeX Live, not in the zip, and were not read)

## Verdict
yes. The zip adds nothing that is not published: kernel `article`, `geometry`, `fontenc`, `inputenc`, `xcolor`, and the CTAN/TeX Live bundle `sudokubundle` (packages `printsudoku`, `solvesudoku`), which is told only a file name, a font switch and a length. There is no zip-local macro, no `\newcommand`, no artwork of the author's own and no tool outside TeX (the solver is part of the TeX package, README.md:3-6; `createsudoku` is not loaded). The one component no lib line holds is the Sudoku grid, proposed as one doc-kind way `art.content-package`. Caveat: the package sources were not read, so what `\cluefont` and `\cellsize` do is inferred from their names and use (main.tex:22, 28), and the README does not document them.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (main.tex:1). Source of the class not read (ships with the TeX distribution).
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (main.tex:10-12, 15), `\section*` (main.tex:27, 31), `\newpage` (main.tex:26), `center` environment (main.tex:20-24). No `abstract`, no bibliography, no `\appendix`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 11pt, a4paper |
| paper size and base size | main.tex:1 | `page.class-options` | `a4paper`, `11pt` |
| page geometry | main.tex:2 | `page.geometry` | `margin=20mm` |
| encodings | main.tex:3-4 | `font.fontenc-t1` | `fontenc` option `T1`; `inputenc` option `utf8` |
| text font | main.tex:1-4 (no font package) | none needed | Computer Modern, the class default; no `font.*` line is set |
| colour definition | main.tex:5, 9 | `color.xcolor` | `\definecolor{puzzleblue}{HTML}{1E4E79}` |
| coloured label text | main.tex:17 | `color.xcolor` | `\textcolor{puzzleblue}{...}` |
| title block | main.tex:10-12, 15 | `front.maketitle` | `\title{Sudoku Puzzle and Solution}`, `\author{Your Name}`, `\date{\today}`, `\maketitle` |
| label line, bold run-in | main.tex:17 | `mark.kernel` | `\bfseries` |
| paragraph without indent | main.tex:17 | `sp.lengths` | `\noindent` (the per-paragraph form of `\parindent`; judgement call, no better kernel line) |
| vertical gaps | main.tex:18, 21 | `sp.manual-space` | `\medskip` twice |
| centred block | main.tex:20-24 | `sp.ragged` | kernel `center` environment (same family as `\centering`) |
| sub-heading text in the block | main.tex:21 | `font.size-commands` + `mark.kernel` | `\large`, `\bfseries` |
| puzzle print, first view | main.tex:6, 22-23 | `art.content-package` | `\usepackage{printsudoku}`; `\cluefont{\Large}`, `\cellsize{2.2\baselineskip}`, `\sudoku{puzzle.sud}` |
| solver view | main.tex:7, 28-29 | `art.content-package` | `\usepackage{solvesudoku}`; `\cluefont{\small}`, `\cellsize{1.2\baselineskip}`, `\sudokusolve{puzzle.sud}` |
| page break | main.tex:26 | `pg.break` | `\newpage` |
| unnumbered headings | main.tex:27, 31 | `head.kernel` | `\section*{Solver output}`, `\section*{Workflow}`; no `secnumdepth` change |
| body text | main.tex:32-35 | content | plain paragraphs, TeX-style quote marks; nothing to map |
| header/footer, page numbers | none set (no `\pagestyle`) | none needed | article default style |
| lists, tables, figures, captions, maths, theorems, code, boxes, notes, bibliography, index, cross-references, hyperref | not present | none | none |

## Bespoke code
none. `\definecolor{puzzleblue}` (main.tex:9) is a `color.xcolor` declaration, not a macro of the zip. The zip defines no `\newcommand`, `\def`, environment, counter, conditional, class or style. `\cluefont` and `\cellsize` are published commands of `printsudoku`/`solvesudoku` (called, never defined, in main.tex:22, 28).

## Content-opaque
- The puzzle data file `puzzle.sud:1-9` (nine rows of digits and dots, one per line) with a free-text comment line (`puzzle.sud:11`) that `printsudoku` ignores (main.tex:32-34; README.md:5-6 describes the file). It is the data argument of `art.content-package` and is content; the emitter ships it as an asset next to the `.tex`. Nothing else is opaque.

## Lib changes
- New ways proposed: `art.content-package`. Package `sudokubundle` (CTAN `macros/latex/contrib/sudokubundle`, version 1.0a, in TeX Live and MiKTeX, LPPL 1.3, Peter R. Wilson; verified on ctan.org/pkg/sudokubundle): `printsudoku` (`\sudoku{file}` prints a puzzle read from a plain-text file), `solvesudoku` (`\sudokusolve{file}` prints the puzzle and the solution found by its TeX-coded solver), `createsudoku` (not loaded here; generates a puzzle with the `random` package); engine pdf (read from the sample and the CTAN page, not from the package source). Doc-kind way, one per package family, as `cal.kalender`, `logbook.dmlb`, `inv.simpleinvoice`.
  - W1: published on CTAN and in TeX Live. W2: behaviour is chosen by a file name, a font switch (`\cluefont{<size command>}`) and a length (`\cellsize{<len>}`), set in values, never by editing code. W3: it serves a kind of component (a Sudoku grid) for any puzzle file. W4: an emitter writes `\usepackage{printsudoku}` and/or `\usepackage{solvesudoku}` in the preamble and `\cluefont{..}\cellsize{..}\sudoku{file}` or `\sudokusolve{file}` in the body, and ships the `.sud` file.
  - Considered `art.content-package` and not used: that Restricted line is for packages whose parameters are programs or free drawings (chemistry, music, circuits); here the parameters are a file name, a font switch and a length, and the grid is the puzzle the worksheet exists to show, not drawing the author makes. If the consolidator prefers to fold it into `art.content-package`, the grid would be content-opaque in the document body and this verdict stays `yes` (no drawing of the author's own appears in the zip).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
