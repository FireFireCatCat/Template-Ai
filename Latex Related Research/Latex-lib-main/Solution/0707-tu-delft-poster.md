yes

# 0707-tu-delft-poster: TU Delft Poster (A0 portrait, tikzposter with a TU Delft colour style)

- Unverified: read from the source, not compiled.
- Source: Source/0707-tu-delft-poster/ (origin: https://latextemplates.com/downloads/tu-delft-poster.zip; licence: CC-BY-4.0)
- Kind: poster
- Lib: v5
- Engine: pdfLaTeX-compatible (README.md:16 builds with `pdflatex`; `inputenc` utf8 and `fontenc` T1 at main.tex:6-7; no `fontspec`)
- Look carried by: mixed (the published `tikzposter` class draws the title bar, columns and blocks; the preamble adds a named colour style at main.tex:25-39 and the sans default at main.tex:18)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds no `.cls`, `.sty`, `.def`, `.cfg`; `tikzposter` itself ships with TeX Live and its source was not read)

## Verdict
The zip is one 154-line `main.tex` on the published `tikzposter` class plus a README, an attribution file and a logo PNG. Every construct is either a `tikzposter` command (`\definecolorstyle`, `\usecolorstyle`, `\institute`, `\maketitle`, `columns`, `\column`, `\block`), a kernel command, or a published package loaded with no options. There is no zip-local class or style, no `\newcommand`, `\def`, counter or conditional, no TikZ drawing of its own and no external tool, so the answer is `yes`. The README (README.md:3-28) says the original custom class was not obtainable and this file is a substitute on `tikzposter`; only the substitute is analysed.

## Blockers
none

## Class setting
- Class: `class.tikzposter` options: `a0paper`, `portrait` (main.tex:4)
- Class-native vocabulary used: `\definecolorstyle{name}{palette}{roles}` with `\colorlet` of `colorOne` `colorTwo` `colorThree` and of `backgroundcolor` `framecolor` `titlefgcolor` `titlebgcolor` `blocktitlebgcolor` `blocktitlefgcolor` `blockbodybgcolor` `blockbodyfgcolor` (main.tex:25-38); `\usecolorstyle{tudelft}` (main.tex:39); `\title` `\author` `\institute` `\maketitle` (main.tex:41-43, 47); `columns` environment with `\column{0.33}` `\column{0.34}` `\column{0.33}` (main.tex:49-50, 83, 118, 147); `\block{title}{body}` ten times (main.tex:52, 60, 74, 85, 108, 114, 120, 128, 132, 143) and once after the columns (main.tex:149).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:4 | `class.tikzposter` | a0paper, portrait |
| page size and orientation | main.tex:4 | `page.class-options` | `a0paper`, `portrait` (tikzposter's other layout lengths are left at class defaults) |
| input and font encoding | main.tex:6-7 | `font.fontenc-t1` | `\usepackage[utf8]{inputenc}`, `\usepackage[T1]{fontenc}` |
| default text family | main.tex:18 | `font.family-default` | `\renewcommand{\familydefault}{\sfdefault}` (the README at README.md:30-38 says DejaVu Sans stands in for Arial; no font package is loaded) |
| colour definitions | main.tex:21-23 | `color.xcolor` | `\definecolor` RGB: tudelftblue 0,166,214; tudelftdarkblue 0,31,77; tudelftblack 0,0,0 |
| poster colour style (palette, frame, title bar, block title and body colours) | main.tex:25-39 | `poster.tikzposter` | `\definecolorstyle{tudelft}`: colorOne=tudelftdarkblue, colorTwo=tudelftblue, colorThree=white; backgroundcolor=white, framecolor=tudelftdarkblue, titlefgcolor=white, titlebgcolor=tudelftdarkblue, blocktitlebgcolor=tudelftblue, blocktitlefgcolor=white, blockbodybgcolor=white, blockbodyfgcolor=black; `\usecolorstyle{tudelft}` |
| title block (title, authors, logo slot) | main.tex:41-43, 47 | `front.class-native` | `\title{..}`, `\author{..}`, `\institute{..}` (holds the logo), `\maketitle`; tikzposter's own title bar in `titlebgcolor` |
| author line separator | main.tex:42 | `sp.manual-space` | `\quad\textbar\quad` (kernel spacing around a text bar) |
| logo in title block | main.tex:43 | `fig.graphicx` | `\includegraphics[height=2.5cm]{tudelft-logo}`; asset `tudelft-logo.png` is shipped in the zip; not in a float and not drawn by TeX, so content |
| three-column body | main.tex:49-50, 83, 118, 147 | `poster.tikzposter` | `columns` environment, `\column{0.33}`, `\column{0.34}`, `\column{0.33}` |
| content blocks with titles | main.tex:52-145, 149-152 | `poster.tikzposter` | `\block{title}{body}`: ten blocks inside the columns, `Contact` full width below them |
| bullet lists | main.tex:65-71, 75-80, 136-140 | `list.kernel` | `itemize` with `\item`, default labels |
| data table | main.tex:91-100 | `tbl.tabular` | `tabular{lr}` with kernel `\hline` rules, no float and no caption |
| table rule package | main.tex:9 | `tbl.booktabs` | `\usepackage{booktabs}`, loaded with no option; no `\toprule` `\midrule` `\bottomrule` call in the body, so load-only |
| vertical spacing in blocks | main.tex:89, 102 | `sp.manual-space` | `\vspace{0.5em}`, `\vspace{1em}` |
| contact line fill | main.tex:150 | `sp.manual-space` | `\hfill` between the e-mail and the credit text |
| monospaced e-mail | main.tex:150 | `mark.kernel` | `\texttt{...}` |
| filler paragraphs | main.tex:10, 53-57, 61-63, 86, 103-105, 109-111, 115, 121-125, 129, 133, 144 | `draft.todo` | `\usepackage{lipsum}`, `\lipsum[n]` for n = 1 to 17 (filler text is content) |
| graphics package | main.tex:8 | `fig.graphicx` | `\usepackage{graphicx}`, no options |

Not present in the sample: abstract, headings outside `\block`, footnotes, equations, theorems, floats with captions, code, bibliography, index, cross-references, header and footer, language packages, hyperref.

## Bespoke code
none. The sample defines no macro, environment, counter or conditional. `\definecolorstyle` (main.tex:25-38) is a published `tikzposter` command whose arguments are only `\colorlet` calls on colour names, so it is declarative parameters of `poster.tikzposter`. `\renewcommand{\familydefault}` (main.tex:18) is a kernel default-family switch, `font.family-default`.

## Content-opaque
none (the logo PNG at main.tex:43 and the `\lipsum` text are content; no TikZ, pgfplots or other drawing sits in the sample)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Poster shapes (title bar, block frames) are drawn by `tikzposter` internally, which is the published class itself, so they are not template artwork of this zip (no `ART`).
- The README and ATTRIBUTION.txt are metadata (author Novanext for the template code, TU Delft for the corporate-design assets, CC-BY-4.0, README.md:40-56, ATTRIBUTION.txt:1-4); they hold no instruction to an AI.
- `tudelft-logo.png` is a shipped asset (README.md:11-12) and its use is a plain `\includegraphics`.
