yes

# 0199-florida-state-university-thesis: Florida State University Thesis (neutral dissertation starter)

- Unverified: read from the source, not compiled.
- Source: Source/0199-florida-state-university-thesis/ (origin: https://latextemplates.com/downloads/fsulatex.zip; licence: not established, the manifest says UNKNOWN and README.md:8 says the institutional source states none)
- Kind: thesis
- Lib: v4
- Engine: pdfLaTeX-compatible (README.md:10 says `pdflatex main.tex`; every package loaded is a pdfTeX package; no fontspec, no unicode-math)
- Look carried by: preamble (main.tex preamble loads published packages and defines one colour; the title page is hand-laid in the body; the class is the kernel `report` unchanged)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is two files: README.md and a 27-line main.tex. There is no zip-local `.cls`, `.sty` or other helper, and main.tex defines no macro, environment or counter of its own; its only definition is one `\definecolor` (main.tex:5). Every component maps to an existing lib way: kernel `report` plus geometry, fancyhdr, lmodern, microtype, booktabs, xcolor, hyperref, and a hand-laid `titlepage` made of kernel spacing and font-size commands. No artwork and no external tool is involved. This is the neutral starter, not Florida State's official class: README.md:3-6 says it omits university marks and upstream assets, so the verdict covers only what the zip holds.

## Blockers
none

## Class setting
- Class: `class.report` options: `12pt`, `a4paper`, `oneside` (main.tex:1). Kernel class, not bundled in the zip; its source was not read.
- Class-native vocabulary used: `\chapter`, `\chapter*`, `\appendix`, `titlepage` environment, `\tableofcontents`, `\listoftables`, `thebibliography` (main.tex:7-26). No `abstract` environment is used: Abstract is a starred chapter (main.tex:14).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.report` | 12pt, a4paper, oneside |
| paper and size | main.tex:1 | `page.class-options` | `a4paper`, `12pt`, `oneside` |
| page geometry | main.tex:2 | `page.geometry` | margin=32mm, headheight=15pt |
| encoding | main.tex:2 | `font.fontenc-t1` | `\usepackage[T1]{fontenc}` |
| text and math face | main.tex:3 | `font.lmodern` | `lmodern`, no options |
| microtypography | main.tex:3 | `sp.microtype` | `\usepackage{microtype}`, defaults |
| maths package | main.tex:3 | `math.amsmath` | loaded, no options; the body has no equation |
| colour package | main.tex:3 | `color.xcolor` | `xcolor`, no options |
| named colour | main.tex:5 | `color.xcolor` | `\definecolor{fsuaccent}{HTML}{782F40}` (used once, main.tex:8) |
| PDF links and metadata | main.tex:4 | `meta.hyperref` | `hidelinks`; no `\hypersetup` |
| running header/footer | main.tex:4, 6 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\lhead{Dissertation Starter}`, `\rhead{\thepage}`; headheight comes from geometry (main.tex:2) |
| title page | main.tex:7-12 | `front.titlepage-env` | `titlepage` environment hand-laid: `\centering`, a coloured label line, title, degree line, author block, date, with `\vspace*`/`\vspace`/`\vfill` between |
| title page spacing | main.tex:7-12 | `sp.manual-space` | `\vspace*{25mm}`, `\vspace{20mm}`, `\vspace{10mm}`, three `\vfill` |
| title page centring | main.tex:7 | `sp.ragged` | `\centering` |
| title page type sizes | main.tex:8-12 | `font.size-commands` | `\Large`, `\Huge`, `\large` |
| title page bold and colour | main.tex:8-9 | `mark.kernel` | `\bfseries`; `\color{fsuaccent}` (`color.xcolor`) |
| title page date | main.tex:12 | `front.maketitle` | kernel `\today`, printed by hand in the page; the `\date` family, no argument |
| front page numbering | main.tex:13, 16 | `pgnum.pagenumbering` | `\pagenumbering{roman}` before front matter, `\pagenumbering{arabic}` after the lists |
| approval page | main.tex:13 | `front.dedication` | `\chapter*{Approval}` then a `\noindent` paragraph (see next row) |
| first paragraph without indent | main.tex:13 | `sp.lengths` | kernel `\noindent`, same family as `\parindent`; one primitive, no value |
| abstract page | main.tex:14 | `head.kernel` | `\chapter*{Abstract}`; the `abstract` environment (`abs.kernel`) is not used |
| acknowledgements page | main.tex:15 | `front.dedication` | `\chapter*{Acknowledgements}` |
| contents and list of tables | main.tex:16 | `toc.kernel` | `\tableofcontents`, `\listoftables`; no `\listoffigures` |
| page break | main.tex:16 | `pg.break` | `\clearpage` |
| chapter headings | main.tex:17-25 | `head.kernel` | `\chapter{...}` x7, report defaults, no `titlesec`, no counter changes |
| appendix | main.tex:25 | `num.appendix` | kernel `\appendix` then `\chapter{Supplementary Material}` |
| table float and rules | main.tex:19-21 | `tbl.tabular` | `table[ht]`, `\centering`, `tabular{lll}` |
| table rules | main.tex:20-21 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| table caption | main.tex:19 | `cap.kernel` | `\caption{Study protocol}` above the table; no `caption` package |
| bibliography | main.tex:26 | `bib.thebibliography` | `thebibliography{9}`, one `\bibitem{sample}`; no `\cite`, no `.bst` |
| emphasis | main.tex:26 | `mark.kernel` | `\emph` |

Components the sample does not define or use: columns, background, language (no babel), spacing packages (no `setspace`, no `parskip`), lists, quotes, notes, footnotes, theorems, figures, code, boxes, index, cross-references (`\label`/`\ref`), doc-kind ways.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `fsuaccent` colour | main.tex:5 | yes | `color.xcolor` `\definecolor{fsuaccent}{HTML}{782F40}`; a declaration, not a macro |

No `\newcommand`, `\def`, environment, counter, conditional, `.cls` or `.sty` in the zip. The title page (main.tex:7-12) is kernel commands in a `titlepage` environment, so it reduces to `front.titlepage-env` with `sp.manual-space`, `font.size-commands`, `mark.kernel`, `sp.ragged`, `color.xcolor`. It draws no TikZ, picture or rule artwork, so it is not `ART`.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- README.md:3-6 says the starter is "based on the official FSULaTeX template lead" and omits university marks and upstream assets. The zip does not contain that template, so the official FSU look, class and assets are not evidenced here and are not part of this verdict.
- No text addressed to an AI was found in README.md or main.tex. README.md:10 tells the reader how to compile; nothing was compiled or run here.
- Classification choices a reviewer may revisit: `\today` under `front.maketitle` (kernel date family; it could equally be read as content), and `\noindent` under `sp.lengths` (paragraph-indent family; one primitive, not a component of its own). Neither changes the verdict.
