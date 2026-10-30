yes

# 0436-jacobs-landscape-poster: Jacobs Landscape Poster (substitute: tikzposter, A0 landscape, Wave theme)

- Unverified: read from the source, not compiled.
- Source: Source/0436-jacobs-landscape-poster/ (origin: https://latextemplates.com/downloads/jacobs-landscape-poster.zip; licence: LPPL-2.0 per the manifest; README.md:38 says the class is LPPL-2.0, the starter text carries no extra restriction)
- Kind: poster
- Lib: v5
- Engine: pdfLaTeX-compatible (README.md:16 builds with `pdflatex main`; the sample loads no font or Unicode package)
- Look carried by: class (the sample only picks a tikzposter layout theme and colour style by name; no zip-local style, no preamble macros)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The zip holds one 100-line `main.tex` and a README. The look is the published `tikzposter` class (CTAN) with one layout theme and one colour style chosen by name. The only other package is `booktabs`. The sample defines no `\newcommand`, `\def`, environment or counter, and draws no TikZ of its own, so there is no bespoke code and no ART. The class is not bundled (README.md:30-34), so its source was not read; the poster blocks and themes it provides are already the lib way `poster.tikzposter`.

The README (README.md:3-8) says this is a substitute: the original "Jacobs Landscape Poster" (bardsoftware, CC-BY-NC-SA) is not in the zip, so this analysis covers the substitute only.

## Blockers
none

## Class setting
- Class: `class.tikzposter` options: `a0paper`, `landscape` (main.tex:11)
- Class-native vocabulary used: `\usetheme{Wave}` (main.tex:14), `\usecolorstyle[colorPalette=BlueGrayOrange]{Britain}` (main.tex:15), `\title` `\author` `\institute` (main.tex:17-19), `\maketitle` (main.tex:22), environment `columns` with `\column{<fraction>}` (main.tex:24, 26, 46, 77, 98), `\block{<title>}{<content>}` (main.tex:28, 37, 48, 61, 79, 87, 94). Not used: `\titlegraphic`, `\note`, `\innerblock`, `\useblockstyle`, `\usetitlestyle`, `\usebackgroundstyle`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:11 | `class.tikzposter` | options a0paper, landscape |
| page size and orientation | main.tex:11 | `page.class-options` | a0paper, landscape (class options; no geometry call, margins left to the class) |
| layout theme (title shape, block shape, page decoration) | main.tex:14 | `poster.tikzposter` | `\usetheme{Wave}` |
| colour style and palette | main.tex:15 | `poster.tikzposter` | `\usecolorstyle[colorPalette=BlueGrayOrange]{Britain}` |
| title block | main.tex:17-19, 22 | `front.class-native` | `\institute{...}` and the theme-drawn `\maketitle`; title text, author line and institute are content |
| title and author fields | main.tex:17-18 | `front.maketitle` | kernel `\title`, `\author` (tikzposter reads them for its title box) |
| columns | main.tex:24-98 | `poster.tikzposter` | `columns` environment; `\column` widths 0.33, 0.34, 0.33 (main.tex:26, 46, 77) |
| content blocks | main.tex:28, 37, 48, 61, 79, 87, 94 | `poster.tikzposter` | `\block{title}{body}` x 7, default block style of the Wave theme |
| bullet lists | main.tex:38-43, 53-58 | `list.kernel` | `itemize`, default labels |
| results table | main.tex:63-70 | `tbl.tabular` | `tabular{lcc}`, header row, two data rows |
| table rules | main.tex:12, 64, 66, 69 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| centred table | main.tex:62, 71 | `sp.ragged` | kernel `center` environment around the table |
| right-aligned contact line | main.tex:95 | `sp.manual-space` | `\hfill` between two strings |
| inline maths (degree sign, R squared) | main.tex:56, 65 | `math.kernel` | `$^\circ$C`, `$R^2$` (content) |
| fonts | none set | none | no font package in the sample; the class and theme defaults apply |
| header, footer, bibliography, headings, floats, theorems, code | none in sample | none | not used in the sample |

## Bespoke code
none (no `\newcommand`, `\def`, `\newenvironment`, counter, conditional or zip-local `.cls`/`.sty`; main.tex:11-19 is the whole preamble).

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The class source was not read, because the zip does not bundle it and it ships with TeX distributions (README.md:30-34); that the Wave theme and Britain colour style exist, and the `colorPalette` key, rest on the README (README.md:21-28) and the sample's own calls.
- main.tex:1-8 and README.md contain only comments and prose about licensing and substitution; no text is addressed to an AI.
