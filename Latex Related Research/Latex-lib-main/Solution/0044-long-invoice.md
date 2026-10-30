yes

# 0044-long-invoice: Long Invoice

- Unverified: read from the source, not compiled.
- Source: Source/0044-long-invoice/ (origin: https://latextemplates.com/downloads/longinvoice.zip; licence: not established. The manifest says "Unknown (not stated in research source)" and README.md:12-14 says the upstream licence was not exposed; README.md:10 names an upstream reference, https://gitlab.com/asabina/naw_tex, which was not read)
- Kind: invoice
- Lib: v1
- Engine: needs XeLaTeX (`fontspec` at main.tex:3 with `\setmainfont` at main.tex:13; README.md:3 and :8 say "Compile with XeLaTeX"; the U+00B7 dots at main.tex:19 and :27 are plain UTF-8 text, read natively by XeTeX)
- Look carried by: preamble (the zip is one `main.tex`; it loads published packages and styles the invoice in its own preamble and body markup, with no zip-local class or style)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The zip holds two files, `README.md` and a 57-line `main.tex`. It sets the kernel `article` class with ten published packages (`geometry`, `fontspec`, `array`, `longtable`, `booktabs`, `xcolor[table]`, `tabularx`, `fancyhdr`, `lastpage`, `hyperref`), all on CTAN. It defines no macro, environment, counter or conditional of its own (grep for `\newcommand`, `\def`, `\newenvironment`, `\newcounter`, `\if` finds only `\definecolor` and `\renewcommand{\headrulewidth}`). The two coloured bands are `\colorbox` around `\parbox`, not a TikZ or picture drawing. Every component therefore maps to an existing lib way with parameters, and no new way is needed.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:1). The kernel class is not in the zip; its source was not read.
- Class-native vocabulary used: none; no `\maketitle`, `abstract`, `\section` or bibliography is used. The invoice head is built by hand from boxes and tables.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | a4paper |
| paper size | main.tex:1 | `page.class-options` | a4paper |
| page geometry | main.tex:2 | `page.geometry` | margin=1.8cm (all four sides) |
| main typeface | main.tex:3, 13 | `font.fontspec` | `\setmainfont{TeX Gyre Heros}`; no `\setsansfont`, so `\sffamily` at :24 selects fontspec's default sans (read, not checked). The font is not in the zip; it ships with TeX Live (tex-gyre). |
| colour palette | main.tex:7, 14-16 | `color.xcolor` | `xcolor` option `table`; `\definecolor` model HTML: navy 20344A, bluegray E9EFF4, teal 148A8A (redefines xcolor's base `teal`); `\color{white}`, `\textcolor{teal}` (:24, :32, :34, :39, :41) |
| footer | main.tex:9, 17-21 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}` (clears all), `\fancyfoot[L]{Northline Design Cooperative · long invoice}`, `\fancyfoot[R]{\thepage\ / \pageref{LastPage}}`, `\headrulewidth` 0pt; no header text |
| page X of Y | main.tex:10, 20 | `pgnum.lastpage` | `lastpage`, label `LastPage` |
| reference to last page | main.tex:20 | `xref.kernel` | `\pageref{LastPage}` |
| links | main.tex:11-12, 28 | `meta.hyperref` | option via `\hypersetup{hidelinks}`; `\href{mailto:accounts@example.org}{...}` is hyperref's own link command |
| title banner "INVOICE ... number" | main.tex:24 | `box.fancybox` | `\colorbox{navy}{...}` (xcolor's box, sibling of `\fcolorbox`), `\noindent` before it |
| banner inner box | main.tex:24 | `box.minipage` | `\parbox{\dimexpr\linewidth-2\fboxsep\relax}{...}`, a width equal to the line minus the colorbox padding (e-TeX length expression, an argument value) |
| banner text shape | main.tex:24 | `font.size-commands` | `\Large` for the word, `\normalsize` for the number after `\hfill` |
| banner text weight/family | main.tex:24 | `mark.kernel` | `\sffamily\bfseries` declarations (same way as `\textsf`/`\textbf`) |
| sender and dates block | main.tex:25-29 | `tbl.tabularx` | `{\linewidth}{@{}Xr@{}}`, three rows; `\Large\bfseries` name (`font.size-commands`, `mark.kernel`); `\textbf{Issued:}` etc. |
| client and reference block | main.tex:31-35 | `tbl.tabularx` | `{\linewidth}{@{}X X@{}}`, one row, two cells; `\textcolor{teal}{\textbf{CLIENT}}` / `{REFERENCE}` labels (`color.xcolor`, `mark.kernel`), `\par` lines inside cells (content) |
| cell padding | main.tex:22 | `sp.lengths` | `\setlength{\tabcolsep}{6pt}` (applies to every table below) |
| vertical spacing | main.tex:24, 30, 36, 55 | `sp.manual-space` | `\\[12pt]`, `\vspace{15pt}`, `\vspace{13pt}`, `\vfill` (pushes the payment box to the foot of the last page) |
| line-item table | main.tex:38-50 | `tbl.longtable` | `\begin{longtable}`, `\endfirsthead` (:40) and `\endhead` (:42) give a repeated header "SERVICE (CONT.)" on later pages; no `\endfoot` or `\endlastfoot` |
| line-item column spec | main.tex:38 | `tbl.tabular` | `array` preamble `@{}>{\raggedright\arraybackslash}p{0.48\linewidth}r r r@{}` |
| ragged cell | main.tex:38 | `sp.ragged` | `\raggedright` through `>{...}` with `\arraybackslash` |
| header band and zebra rows | main.tex:7, 37, 39, 41 | `tbl.colortbl` | `\rowcolors{2}{white}{bluegray}`, `\rowcolor{navy}` on both header rows with `\color{white}` text. `\rowcolors` has no `\hiderowcolors` or group around it, so it appears to still be active for the totals table at :51 (read, not checked). |
| table end rule | main.tex:49 | `tbl.booktabs` | `\bottomrule` inside the longtable |
| totals block | main.tex:51-54 | `tbl.tabular` | `\begin{tabular}{lr}` inside `flushright`; three rows |
| totals alignment | main.tex:51, 54 | `sp.ragged` | `flushright` environment (kernel, same family as `\raggedleft`) |
| totals rule and emphasis | main.tex:53 | `tbl.booktabs` | `\toprule` above "Amount due"; `\Large\textbf` (`font.size-commands`, `mark.kernel`) |
| payment note box | main.tex:56 | `box.fancybox` | `\colorbox{bluegray}{...}`; inner `\parbox{\dimexpr\linewidth-2\fboxsep\relax}` is `box.minipage`; `\textbf{Payment}\quad` (`mark.kernel`, `sp.manual-space`) |

Not defined or not used: no `babel` or other language package (English by default, dates typed as text), no sectioning, lists, math, theorems, figures, captions, code, bibliography or index.

## Bespoke code
none. Every command in the preamble and body is kernel or from a published package: `\definecolor`, `\hypersetup`, `\fancyhf`, `\fancyfoot`, `\renewcommand{\headrulewidth}{0pt}` (a fancyhdr length parameter, as `sp.lengths` admits raw length parameters), `\setlength{\tabcolsep}{6pt}`, `\rowcolors`, `\rowcolor`, `\dimexpr`. The `\parbox` width `\dimexpr\linewidth-2\fboxsep\relax` is a length expression passed as an argument, not a macro or algorithm.

## Content-opaque
none (no figure, tikz picture, image or table float; the invoice figures, names, address and bank details at main.tex:25-35, 43-48, 52-53, 56 are text content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
