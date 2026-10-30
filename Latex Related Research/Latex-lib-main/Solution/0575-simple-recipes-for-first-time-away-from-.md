yes

# 0575-simple-recipes-for-first-time-away-from-: Simple Recipes for First-Time-Away-From-Home Cooks

- Unverified: read from the source, not compiled.
- Source: Source/0575-simple-recipes-for-first-time-away-from-/ (origin: https://latextemplates.com/downloads/simple-away-cooks-recipes.zip; upstream Overleaf gallery per ATTRIBUTION.txt:4; licence: CC-BY-4.0)
- Kind: misc (a two-column pocket recipe booklet; the manifest hint `misc` / category Recipes fits)
- Lib: v4
- Engine: pdfLaTeX-compatible (T1 + `lmodern`, no `fontspec`, no Lua)
- Look carried by: preamble (no zip-local class or style; a kernel `article` plus seven published packages and one `\newcommand` alias in main.tex:1-12)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes (all 28 lines), zip-local classes and styles none present (the zip holds only main.tex, ATTRIBUTION.txt, README.md)

## Verdict
Yes. The whole template is one 28-line file. It loads the kernel `article` class, six published packages that do something (`geometry`, `fontenc`, `lmodern`, `xcolor`, `multicol`, `fancyhdr`) and `enumitem`, which sets a list default that no list in the body uses. Every component maps to an existing lib way. The only bespoke item is `\quickrecipe` (main.tex:12), a pure `\newcommand` alias of kernel commands with no conditional or counter, which reduces by inline expansion. There is no artwork, no external tool, no zip-local class or style, and no missing asset.

## Blockers
none

## Class setting
- Class: `class.article` options: `10pt`, `a5paper` (main.tex:1). Source of the class was not read (it ships with the TeX distribution; a published class loaded unchanged).
- Class-native vocabulary used: `\section*` (starred, unnumbered sectioning) only. The sample uses no `\title`, `\author`, `\date`, `\maketitle` and no `abstract` environment.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | `10pt`, `a5paper` |
| paper size and base type size | main.tex:1 | `page.class-options` | `a5paper`, `10pt` |
| page geometry | main.tex:2 | `page.geometry` | `margin=13mm` (one value for all four margins) |
| font encoding | main.tex:3 | `font.fontenc-t1` | `fontenc` with option `T1`; no `inputenc` line |
| text font | main.tex:4 | `font.lmodern` | `lmodern`, no options |
| colours | main.tex:5, 9 | `color.xcolor` | `xcolor` loaded without options; `\definecolor{blueberry}{HTML}{365C7D}`, `\definecolor{sun}{HTML}{E5A83B}` |
| header and footer | main.tex:8, 10 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}` (clears all fields); `\fancyhead[C]{\small\sffamily\color{blueberry}COOKING FOR ONE}`; `\fancyfoot[C]{\thepage}`; no `\headrulewidth` or `\footrulewidth` change, so the package defaults apply |
| header text face | main.tex:10 | `font.size-commands`, `mark.kernel`, `color.xcolor` | `\small`; `\sffamily`; `\color{blueberry}` (all inside the header field) |
| page numbering | main.tex:10 | `hf.fancyhdr` | `\thepage` printed in the centre foot field; no `\pagenumbering` call |
| title block (hand-laid, no `\maketitle`) | main.tex:14 | `sp.ragged` | `center` environment holds three lines |
| title text faces | main.tex:14 | `font.size-commands`, `mark.kernel`, `color.xcolor` | title `\Huge\sffamily\bfseries\color{blueberry}`; subtitle `\large`; tagline `\textcolor{sun}{BUY LESS \quad WASTE LESS \quad EAT WELL}` |
| title block spacing | main.tex:14, 15 | `sp.manual-space` | `\par\smallskip`, `\par\vspace{3mm}`, `\quad`, then `\bigskip` after the block |
| columns | main.tex:6, 16, 26 | `cols.multicol` | `\begin{multicols}{2}` ... `\end{multicols}`; no `\columnsep` or `\columnseprule` set |
| recipe heading | main.tex:12 | `head.kernel` | `\section*{...}` (unnumbered, default article format, no `titlesec`); the title text is wrapped in `\color{blueberry}` (`color.xcolor`) |
| recipe sub-line ("Serves 1") | main.tex:12, 17, 20, 23 | `color.xcolor` | `\textcolor{sun}{#2}` |
| recipe body labels | main.tex:18, 19, 21, 22, 24, 25 | `mark.kernel` | `\textbf{You need:}`, `\textbf{Do this:}` |
| recipe body line break | main.tex:18, 21, 24 | `sp.manual-space` | `\\[2pt]` ends the "You need" line and adds 2pt before the "Do this" line, inside one paragraph |
| recipe block spacing | main.tex:12 | `sp.manual-space` | `\par\smallskip` before the body, `\par\medskip` after |
| list defaults (declared, unused) | main.tex:7, 11 | `list.enumitem` | `\setlist{nosep,leftmargin=*}`; main.tex has no `itemize`, `enumerate` or `description` environment, so this has no effect on the sample page |
| closing note | main.tex:27 | `sp.manual-space`, `sp.ragged`, `font.size-commands`, `mark.kernel` | `\vfill` pushes it to the page foot; `center` environment; `\small`; `\textit{...}` |
| document body wrapper | main.tex:13, 28 | `class.article` | `document` environment (kernel) |
| not defined or used | main.tex (whole file) | none needed | no abstract, contents list, numbering change, theorem, math, float, table, caption, code, bibliography, index, cross-reference, footnote, language or metadata line |

The lib line `recipe.xcookybooky` exists, but this sample does not load `xcookybooky` (main.tex:1-8 lists every package), so it is not used. The lib line `front.titlepage-env` was considered for the title block and not used: the sample uses a `center` environment, not `titlepage`.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\quickrecipe}[3]{\section*{\color{blueberry}#1}\textcolor{sun}{#2}\par\smallskip #3\par\medskip}` | main.tex:12 (used at main.tex:17, 20, 23) | yes | A three-argument alias of kernel and `xcolor` commands: no conditional, counter or computed layout. Expand it at each use as `head.kernel` (`\section*{` + `color.xcolor` `\color{blueberry}` + title + `}`), then `color.xcolor` `\textcolor{sun}{...}`, then `sp.manual-space` `\par\smallskip`, the body text, `\par\medskip`. |

## Content-opaque
none (no figure, table, picture or image in the sample; recipe text is content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- README.md:8-10 says "font and pocketmod workflow provenance remain warnings only". This is provenance text about the upstream gallery. main.tex has no imposition or page-folding code (no `pgfpages`, no `pdfpages`), so no pocketmod step is part of the template as shipped; it is not a blocker and not in scope. Nothing in the zip is addressed to an AI.
- Missing assets: none (no images; fonts are Latin Modern from the TeX distribution).
