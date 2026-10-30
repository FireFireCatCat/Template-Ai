yes

# 0273-cookybooky: Cookybooky (recipe-book starter)

- Unverified: read from the source, not compiled.
- Source: Source/0273-cookybooky/ (origin: https://latextemplates.com/downloads/cookybooky.zip; licence: LPPL-1.3 per the manifest; the zip's own files state no licence for the starter, README.md:10-11 speaks of the upstream package)
- Kind: misc (a recipe sheet or cookbook starter; manifest category Recipes)
- Lib: v3
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (main.tex:1-20 only loads published packages, sets their options and defines one `\newcommand`; the zip holds no `.cls`, `.sty` or other class file)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The class is the published kernel `article`, and the whole look is a preamble of published packages (`geometry`, `xcolor`, `multicol`, `enumitem`, `tcolorbox`, `titlesec`, `fancyhdr`, `hyperref`) with option values. The only bespoke item is the `\recipe` macro (main.tex:17-20), a plain 4-argument `\newcommand` with no counters, conditionals or box algorithms; it is a composition of lib ways and reduces to per-recipe body wrappers. There is no artwork and no tool outside TeX. The zip does not load or ship the `cookybooky` package it is named after (README.md:3-6 calls it "inspired by"; `grep` for the name in main.tex finds nothing), so no cookybooky vocabulary is in scope.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `11pt` (main.tex:1). The class source is not bundled and was not read.
- Class-native vocabulary used: `\section*` (main.tex:18, 27), `center` environment (main.tex:22), `itemize` / `enumerate` (main.tex:20, 28). No `\maketitle`, `\title`, `abstract`, `\tableofcontents` or bibliography.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:1 | `class.article` | a4paper, 11pt |
| paper and base size | main.tex:1 | `page.class-options` | a4paper, 11pt |
| page geometry | main.tex:2 | `page.geometry` | margin=1.7cm |
| encoding | main.tex:3 | `font.fontenc-t1` | fontenc T1; no `inputenc` line, the `·` at main.tex:22 relies on the kernel's UTF-8 default |
| text font | main.tex:4 | `font.lmodern` | Latin Modern; the `\sffamily` text (main.tex:15, 22) is then Latin Modern Sans |
| colours | main.tex:5, 12-14, 19 | `color.xcolor` | `\definecolor` HTML: tomato B84A3A, leaf 516B4D, cream FBF6EA; mix `tomato!55!black`; used through `\color` and `\textcolor` (15, 16, 18, 22) |
| running head and foot | main.tex:10, 15 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\lhead` "THE EVERYDAY TABLE", `\rhead` "RECIPES", `\cfoot{\thepage}`, `\headrulewidth` 0pt |
| head and foot type | main.tex:15 | `mark.kernel`, `font.size-commands`, `color.xcolor` | `\sffamily`, `\small`, leaf colour left, tomato colour right |
| title block | main.tex:22 | `sp.ragged`, `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.manual-space` | hand-laid in a `center` environment (the kernel wrapper of `\centering`, filed under `sp.ragged`): `\sffamily\fontsize{28}{30}\selectfont\bfseries\color{leaf}`, `\large` subtitle, `\textcolor{tomato}` tagline, `\par\smallskip`; no `\title`/`\maketitle` is used, so `front.maketitle` does not apply |
| gap after title | main.tex:23 | `sp.manual-space` | `\vspace{4pt}` |
| section heading look | main.tex:9, 16 | `head.titlesec` | `\titleformat{\section}`: format `\Large\bfseries\color{leaf}`, label empty, sep 0pt, before-code empty, after-code `\color{tomato}\titlerule`; no `\titlespacing`, so package defaults |
| section heading use | main.tex:18, 27 | `head.kernel` | only the starred `\section*`; no numbering, no counter changes |
| recipe meta line | main.tex:18 | `mark.kernel`, `color.xcolor`, `sp.manual-space` | `\textit{serves}` `\hfill` `\textcolor{tomato}{time}` `\par\smallskip` |
| recipe box | main.tex:8, 19 | `box.tcolorbox` | colback=cream, colframe=tomato!55!black, boxrule=.4pt, arc=1mm; no tcolorbox libraries loaded |
| two columns in the box | main.tex:6, 20 | `cols.multicol` | `multicols{2}`, `\columnbreak` between the Ingredients and Method halves |
| box sub-heads | main.tex:20 | `mark.kernel`, `sp.manual-space` | `\textbf{Ingredients}`, `\textbf{Method}`, each followed by `\par\smallskip` |
| ingredient list | main.tex:7, 20 | `list.enumitem` (items are `list.kernel` `itemize`) | `leftmargin=*,nosep` |
| method steps | main.tex:20 | `list.enumitem` (items are `list.kernel` `enumerate`) | `leftmargin=*,nosep`; three fixed items (content of the macro) |
| notes list | main.tex:28 | `list.enumitem` (items are `list.kernel` `itemize`) | `leftmargin=*` |
| space after a recipe | main.tex:20 | `sp.manual-space` | `\medskip` |
| inline mono | main.tex:28 | `mark.kernel` | `\texttt` |
| PDF links | main.tex:11 | `meta.hyperref` | `hidelinks`; no `\hypersetup` metadata |

Not present in the sample (main.tex:21-29): footnotes, floats, figures, tables, captions, maths, theorems, code listings, abstract, contents, bibliography, index, cross-references, language setup, appendix.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\recipe{#1}{#2}{#3}{#4}` | main.tex:17-20 | yes | A `\newcommand` alias with no counters, conditionals or box arithmetic. It expands to: `\section*{#1}` (`head.kernel`, look from `head.titlesec`); `\textit{#2}\hfill\textcolor{tomato}{#3}\par\smallskip` (`mark.kernel`, `color.xcolor`, `sp.manual-space`); a `tcolorbox` (`box.tcolorbox`) holding `multicols{2}` (`cols.multicol`) with `\columnbreak`, an `itemize[leftmargin=*,nosep]` taking `#4` (the ingredient items) and an `enumerate[leftmargin=*,nosep]` of three fixed steps (`list.enumitem`), then `\medskip`. An emitter writes this wrapper once per recipe; the title, serving text, time and items are content. |

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
