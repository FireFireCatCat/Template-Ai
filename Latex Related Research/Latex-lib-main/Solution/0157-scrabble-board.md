yes

# 0157-scrabble-board: Scrabble Board (CTAN `Scrabble` package demo)

- Unverified: read from the source, not compiled.
- Source: Source/0157-scrabble-board/ (origin: https://latextemplates.com/downloads/scrabble.zip; the README names https://ctan.org/pkg/scrabble as the upstream; licence: LPPL-1.3c-or-later, Scrabble.sty:2 and README.md:14)
- Kind: misc (a one-page demo of a word-game board diagram plus inline letter tiles)
- Lib: v3
- Engine: pdfLaTeX-compatible (nothing engine-specific in Scrabble.sty; it needs a 2022+ kernel for `\fpeval` and `\NewDocumentCommand`; the random-list backend in `randintlist` was not read, CTAN describes it as not needing LuaLaTeX)
- Look carried by: preamble (the page is `article` + `geometry`; the board and tiles are the output of the published CTAN package `Scrabble`, loaded at main.tex:6; the bundled Scrabble.sty is a copy of that package, not a zip-local invention)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip, source not read)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (Scrabble.sty read in full, 696 lines; README.md read)

## Verdict
`yes`, resting on one ruling: the bundled `Scrabble.sty` is **published**. Its header says `\ProvidesPackage{Scrabble}[2025/16/12 0.20a Scrabble]` (Scrabble.sty:7), and ctan.org/pkg/scrabble lists package `scrabble` version 0.20a dated 2025-12-16, LPPL 1.3c, author C. Pierquet, in TeX Live and MiKTeX (one CTAN read; the bytes were not diffed against CTAN, README.md:14 says it is unchanged). The sample then needs only `\usepackage{Scrabble}` and the package's own environment and commands with key=value options and word strings, so the board is a declarative way (proposed `art.content-package`), not template-defining TikZ artwork written in the zip. The rest is `article` with `geometry`, `fontenc`, `xcolor` and a kernel title block, all lib ways. The verdict flips to `no` if a reviewer treats the bundled copy as zip-local: its pics, `\foreach` loops and xstring dispatch (Scrabble.sty:108-244, 283-400, 426-692) would then be BESPOKE/class and ART/class.

## Blockers
none

## Class setting
- Class: `class.article` options: `10pt`, `a4paper` (main.tex:1)
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (main.tex:9-11, 14), `\section*` (main.tex:31); no `abstract`

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 10pt, a4paper |
| paper size | main.tex:1 | `page.class-options` | a4paper |
| page geometry | main.tex:2 | `page.geometry` | margin=15mm |
| font encoding | main.tex:3 | `font.fontenc-t1` | fontenc T1 |
| input encoding | main.tex:4 | `font.fontenc-t1` | inputenc utf8 |
| colour package | main.tex:5 | `color.xcolor` | no options |
| named colour | main.tex:8 | `color.xcolor` | `\definecolor{boardblue}{HTML}{164A68}`; defined, never used in main.tex or Scrabble.sty (grep: one hit) |
| title block | main.tex:9, 10, 11, 14 | `front.maketitle` | title "A Word-Game Board", author "Your Name", `\date{\today}`, `\maketitle` |
| paragraph start | main.tex:16 | `sp.lengths` | `\noindent` (one-paragraph form of parindent 0, same TeX parameter family) |
| centred block | main.tex:20, 29 | `sp.ragged` | `center` environment around the board |
| board package load | main.tex:6; deps Scrabble.sty:21-26 | `art.content-package` | `\usepackage{Scrabble}`, no options; it loads `tikz`, `pgf`/`pgffor`, `randintlist`, `calc` and TikZ libraries `calc`, `shapes.geometric` itself |
| board diagram | main.tex:21, 28 | `art.content-package` | `EnvScrabble` (Scrabble.sty:367-400), optional language `<LANG>` omitted so default EN (Scrabble.sty:367), keys `Scale=0.43`, `Labels=false`, `Help` (bare boolean, draws the 1-15 axis numbers, Scrabble.sty:391-396); keys defined at Scrabble.sty:263-266, 274-280 |
| word placements | main.tex:22-27 | `art.content-package` | `\ScrabblePutWord[dir]{WORD}{x,y}` six times: LATEX 1,13; TEX 3,15 V; CODE 5,11; STYLE 8,8 V; PUZZLE 7,5; GRID 12,6 V (Scrabble.sty:252-256); strings and integer coordinates are the arguments |
| board colours | Scrabble.sty:97-102 (not overridden in main.tex) | `color.xcolor` | `\colorlet` defaults: triplewordscore red!75, doublewordscore red!25, tripleletterscore blue!50!cyan!75, doubleletterscore blue!50!cyan!50, scrabblebgtile yellow!40, scrabblebloard gray!25; the way's colour parameters, a user restyles them with `\colorlet` |
| unnumbered heading | main.tex:31 | `head.kernel` | `\section*{Inline example}`, default look |
| inline word tiles | main.tex:33 | `art.content-package` | `\ScrabbleWord[Lang=EN,Scale=0.55]{TEX}` (Scrabble.sty:570-692); keys Colback, Font, Colfonte, Lang, Offset, Scale, Score, Shuffle (Scrabble.sty:550-568) |
| page style, header/footer, numbering | not set in main.tex | none | class default (`plain`); nothing to emit |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| sample's own macros, counters, environments | main.tex | none exist | n/a (the only definition is the unused `\definecolor` at main.tex:8) |
| `Scrabble.sty` internals: tikz pics `pointes` `casecentrale` `jeton` `placemotH`/`V` (Scrabble.sty:108-185), square styles (186-244), `\scrabblescorelettre` and point tables (36-64), localised labels `\SCRBM*` `\SCRBL*` (67-94), key families (259-280, 406-424, 550-568), `EnvScrabble`, `EnvScrabbleFR`, `\ScrabbleBoard`, `\PlateauScrabble`, `\ScrabbleWord`, `\MotScrabble` (283-692) | Scrabble.sty | not zip bespoke: the file is the published CTAN package `scrabble` 0.20a (Scrabble.sty:7), so this is the implementation of the way, called through its public interface | the emitter writes `\usepackage{Scrabble}`, the environment `EnvScrabble[keys]` with `\ScrabblePutWord` lines, and `\ScrabbleWord[keys]{WORD}`; ship Scrabble.sty if the target TeX tree lacks it (README.md:5-6 says the pinned image does not have it) |

Observations, not blockers: `\ScrabbleWord` reads the key family `SCRABBLEWORDINLINEFR` for `Score` in its plain-letter branch (Scrabble.sty:682, the English command otherwise uses the `...EN` family), an upstream quirk that touches only whether the small score digit prints. The package header date `2025/16/12` is not a valid year/month/day order (Scrabble.sty:7); CTAN lists 2025-12-16. `xstring`, `listofitems` and `simplekv` commands are used (Scrabble.sty:38-40, 48-64, 259-262) but never `\RequirePackage`d in the file, so they must arrive through `randintlist` (its source was not read).

## Content-opaque
none (the six word placements and the inline word are arguments of the way: strings and integer coordinates; the board artwork itself is generated by the published package, no TikZ is written in main.tex)

## Lib changes
- New ways proposed:
  - `art.content-package` `Scrabble` (CTAN, TeX Live, LPPL 1.3c, `\usepackage{Scrabble}`), engine pdf (nothing engine-specific read), a Scrabble board diagram and inline letter tiles. Body: `\begin{EnvScrabble}[<LANG>][Scale,ScaleLabels,Border,Labels,Help]` wrapping `\ScrabblePutWord[V]{WORD}{x,y}`, and inline `\ScrabbleWord[Colback,Font,Colfonte,Lang,Offset,Scale,Score,Shuffle]{WORD}`; French command set `EnvScrabbleFR`, `\PlateauScrabble`, `\MotScrabble`; languages EN, FR, DE, ES set by `Lang`/`<LANG>`. W1: package on CTAN and in TeX Live, version of the bundled file matches CTAN (0.20a, 2025-12-16). W2: behaviour chosen by keys (scale, booleans, colours, a language code) and string and integer arguments, no code is edited. W3: serves a kind of component (a word-game board diagram in any worksheet, puzzle or handout; four languages), as `cal.kalender` and `logbook.dmlb` serve one kind of page or record. W4: one preamble line plus one environment wrapper and per-word commands. Considered and set aside: `art.content-package` (its parameters are programs or free drawings; here they are keys, strings and coordinates over a fixed board, and read as content it also gives `yes`); `art.tikz` (the sample draws no TikZ itself).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
