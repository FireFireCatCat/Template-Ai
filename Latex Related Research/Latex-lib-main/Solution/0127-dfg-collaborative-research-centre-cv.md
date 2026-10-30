yes

# 0127-dfg-collaborative-research-centre-cv: DFG Collaborative Research Centre CV

- Unverified: read from the source, not compiled.
- Source: Source/0127-dfg-collaborative-research-centre-cv/ (origin: https://latextemplates.com/downloads/dfg-crc.zip; licence: LPPL-1.3c)
- Kind: cv
- Lib: v2
- Engine: needs XeLaTeX or LuaLaTeX (`fontspec` `\setmainfont{TeX Gyre Heros}` at main.tex:2; README.md:3 calls it a LuaLaTeX starter)
- Look carried by: preamble (the whole look is in the sample's own preamble: geometry, colours, two `\newcommand` macros, `enumitem` and `hyperref` settings; the kernel `article` class adds nothing)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is two files: a 47-line `main.tex` and a README. It loads the kernel `article` class and only published packages (`geometry`, `fontspec`, `xcolor`, `tabularx`, `booktabs`, `enumitem`, `hyperref`), so no zip-local `.cls` or `.sty` exists. The only bespoke items are two `\newcommand` macros (`\heading`, `\record`), and each is a plain composition of lib ways with fixed lengths and colours, so both are reducible. There is no TikZ or other artwork (the coloured line under a heading is a kernel `\rule`) and no external tool. Verdict `yes`, with the engine tag XeLaTeX/LuaLaTeX because of `fontspec`.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (main.tex:1). Kernel class, not bundled in the zip (source not read, not needed).
- Class-native vocabulary used: none. The sample calls no `\maketitle`, no `abstract`, no `\section`; both the title block and the section headings are hand-laid with its own macros (main.tex:7, main.tex:10-13).
- README.md:3 says the starter is "based on" the CTAN `dfg-crc` package, but main.tex never loads it (the only `\usepackage` lines are main.tex:2-3), so that package is not part of this zip's look and was not analysed.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 11pt, a4paper |
| paper and base size | main.tex:1 | `page.class-options` | `11pt`, `a4paper` |
| page geometry | main.tex:2 | `page.geometry` | `margin=1.65cm` (all four sides) |
| main font | main.tex:2 | `font.fontspec` | `\setmainfont{TeX Gyre Heros}` (font from TeX Live `tex-gyre`, not shipped in the zip) |
| colour definitions | main.tex:3, main.tex:4 | `color.xcolor` | `\definecolor` HTML: dfgblue 174A7E, teal 147D86 (redefines xcolor's built-in name), muted 5D6873 |
| links | main.tex:3, main.tex:5, main.tex:13 | `meta.hyperref` | `colorlinks=true`, `urlcolor=teal`, `linkcolor=dfgblue`; `\href{mailto:...}{...}` is a command of the same package |
| header and footer | main.tex:5 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no running head or foot, no page number) |
| paragraph indent | main.tex:5 | `sp.lengths` | `\setlength{\parindent}{0pt}` |
| title block, two columns | main.tex:10-13 | `cols.minipage` | `minipage[t]` widths `0.70\linewidth` and `0.26\linewidth`, `\hfill` between (hand-laid, no `\maketitle`) |
| title block, name line | main.tex:10 | `font.size-commands` | `\fontsize{24}{28}\selectfont`; with `mark.kernel` (`\bfseries`) and `color.xcolor` (`\color{dfgblue}`) |
| title block, affiliation line | main.tex:11 | `mark.kernel` | plain text under the name |
| title block, right column | main.tex:12-13 | `sp.ragged` | `\raggedleft`; lines broken with `\\` (`sp.manual-space`) |
| spacing and fills | main.tex:7, main.tex:11, main.tex:46 | `sp.manual-space` | `\vspace{8pt}`, `\vspace{2pt}`, `\vspace{3pt}`, `\hfill`, `\vfill`, `\\` |
| rule under heading | main.tex:7 | `sp.rule` | `\rule{\linewidth}{1.1pt}` coloured teal through `color.xcolor` |
| section headings (`\heading`) | main.tex:7, calls at main.tex:14, :21, :24, :28, :33, :39 | `sp.manual-space`, `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.rule` | space 8pt above; `\large\bfseries` in dfgblue; `\par`; 2pt; teal 1.1pt full-width rule; 3pt below. Not a `\section`: no number, no toc entry. Considered: `titlesec` `\titleformat` with after-code (same look, as a real sectioning level) |
| entry lines (`\record`) | main.tex:8, calls at main.tex:22-23, :25-27 | `mark.kernel`, `color.xcolor`, `sp.manual-space` | `\textbf{title}` `\hfill` `\textcolor{muted}{years}` `\par` `\textit{place}` `\par` |
| key-value table | main.tex:15-20 | `tbl.tabularx` | `tabularx{\linewidth}{@{}>{\bfseries}p{0.24\linewidth}X@{}}`; column prefix `>{}` and `@{}` come from `array` (`tbl.tabular`) |
| column spec of the same table | main.tex:15 | `tbl.tabular` | `array` `>{\bfseries}` prefix, `p{0.24\linewidth}` column, `@{}` edge removal |
| activity table | main.tex:40-45 | `tbl.tabularx`, `tbl.booktabs` | `tabularx{\linewidth}{@{}lXr@{}}`, `\toprule` `\midrule` `\bottomrule` |
| body paragraph | main.tex:29-32 | `mark.kernel` | plain text, no spacing change |
| bullet list | main.tex:34-38 | `list.kernel` | `itemize` with three `\item`, `\textit` for journal names (main.tex:35-36) |
| list spacing | main.tex:6 | `list.enumitem` | `\setlist[itemize]{leftmargin=1.3em,itemsep=2pt,topsep=3pt}` |
| bottom note | main.tex:46 | `sp.manual-space`, `font.size-commands`, `color.xcolor` | `\vfill` then `\footnotesize\color{muted}` disclaimer text |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\heading{#1}` | main.tex:7 | yes | Body wrapper around a node's text: `\vspace{8pt}`, group `{\large\bfseries\color{dfgblue} text}`, `\par`, `\vspace{2pt}`, group `{\color{teal}\rule{\linewidth}{1.1pt}}`, `\vspace{3pt}`. Only `sp.manual-space`, `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.rule`; no counters, no conditionals, no kernel redefinition. The same look is reachable with `titlesec` (considered) if a real sectioning level is wanted. |
| `\record{#1}{#2}{#3}` | main.tex:8 | yes | `\textbf{#1}\hfill\textcolor{muted}{#2}\par\textit{#3}\par`: `mark.kernel`, `sp.manual-space`, `color.xcolor`. A three-field alias with no logic. |

No zip-local `.cls`, `.sty`, `.def`, `.cfg`, `.clo`, `.bst`, counters, environments or conditionals exist (the zip holds only main.tex and README.md; grep of main.tex finds only the two `\newcommand` lines, main.tex:7-8).

## Content-opaque
none

## Lib changes
- New ways proposed: none. Every component maps to an existing lib way. `\raggedleft` is the same family as the kernel commands listed under `sp.ragged`; `\vfill` is the same family as `\hfill` under `sp.manual-space`; `\href` is a `hyperref` command and goes with that package's way `meta.hyperref`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
