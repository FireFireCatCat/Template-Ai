yes

# 0673-polossk-math-symbols-in-latex: Math-Symbols-in-LaTeX (math-symbols.sty and its manual)

- Unverified: read from the source, not compiled.
- Source: Source/0673-polossk-math-symbols-in-latex/ (origin: https://codeload.github.com/polossk/Math-Symbols-in-LaTeX/zip/refs/heads/master; licence: MIT)
- Kind: misc (a documentation article that lists the macros of a maths-notation style file)
- Lib: v5
- Engine: pdfLaTeX-compatible (the zip's makefile builds with `xelatex`, makefile:1, but no `fontspec`, `xeCJK` or `ctex` is loaded; the Chinese text is in comments only, article-setting.tex:1-2)
- Look carried by: mixed (page, header/footer, link and listing look in the `\input` preamble file article-setting.tex; the notation macros in the zip-local math-symbols.sty)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip)
- Main file: readme.tex (other samples: none; custom-math-symbols.tex is a copy of the macros for the VSCode hover preview and no file loads it, custom-math-symbols.tex:6-7)
- Read: main yes, zip-local classes and styles all (math-symbols.sty, article-setting.tex, custom-math-symbols.tex read in full; helper/math-symbols.rb read, helper/help.rb and helper/gentab.py first lines only, helper/symbols.py and helper/greekchar.py not read: authoring aids, not loaded by the document)

## Verdict
yes. `readme.tex` is a plain `article` with a preamble of published packages and options (article-setting.tex:3-75). The one zip-local style, `math-symbols.sty`, is not on CTAN (`ctan.org/pkg/math-symbols` returned 404), but it only loads published maths packages and defines `\newcommand` aliases, `\DeclareMathOperator`s and one `\newenvironment` wrapper, all of which expand inline into `math.amsmath`, `math.bm` and `math.amssymb` calls. There are no floats, theorems, bibliography or artwork. The only proposed way is `xref.prettyref`, for a package that is loaded and never called; the verdict does not depend on it.

## Blockers
none

## Class setting
- Class: `class.article` options: none (readme.tex:1)
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (readme.tex:5-7,11), `\section` `\subsection`, `itemize`, `tabular`, `\thispagestyle`; no `abstract` and no `\tableofcontents` (commented out at readme.tex:17)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | readme.tex:1 | `class.article` | no options |
| preamble in a separate file | readme.tex:2 | `struct.input` | `\input{article-setting}` (file name string) |
| page geometry | article-setting.tex:3-4 | `page.geometry` | a4paper, left=1.91cm, right=1.91cm, top=2.05cm, bottom=2.05cm |
| title block | readme.tex:4-7,11 | `front.maketitle` | title `Math-Symbols-in-\LaTeX{}-Manual`, author `polossk`, date `Version: v\artversion, Last Update: \today`; `\artversion` is a string macro (2.2.3.1026) |
| PDF metadata and link look | article-setting.tex:9,11-19,21-28 | `meta.hyperref` | options unicode=true, colorlinks=false, pdfborder={0 0 0}; `\hypersetup` bookmarks, bookmarksopen, pdftoolbar, pdfmenubar, pdffitwindow (true), pdfstartview={FitH}, pdfnewwindow; pdftitle, pdfauthor, pdfsubject, pdfcreator, pdfproducer, pdfkeywords as strings |
| external link in the footer | article-setting.tex:54 | `xref.hyperref` | `\href{https://github.com/polossk}{polossk}` |
| running head and foot | article-setting.tex:46,48-57 | `hf.fancyhdr` | `\pagestyle{fancy}`; `\lhead{}` `\rhead{}` `\chead{}`; `\lfoot{Version: v\artversion}`, `\cfoot{\thepage}`, `\rfoot{by \href{..}{polossk}}`; headrulewidth 0.4pt, footrulewidth 0pt, `\headwidth` set to `\textwidth` |
| first-page style | readme.tex:18 | `hf.pagestyle-kernel` | `\thispagestyle{fancy}` |
| line spacing | readme.tex:19 | `sp.linespread` | `\renewcommand{\baselinestretch}{1.25}` after `\maketitle` |
| setspace (load only) | article-setting.tex:35 | `sp.setspace` | no options, no command called in the sample |
| headings | readme.tex:24,36,121,133 (sections), 41,61,77,93,110 (subsections) | `head.kernel` | article defaults, no `\titleformat`, no counter change |
| bullet list with bold run-in labels | readme.tex:135-169 (labels 136,153,155,157,168) | `list.kernel`, `mark.kernel` | `itemize`, five `\item \textbf{..}` |
| list packages (load only) | article-setting.tex:40-41 | `list.enumerate-pkg`, `list.enumitem` | no options; the sample sets no label or spacing keys |
| symbol tables | readme.tex:26-31,45-56,65-72,81-88,97-105,112-115,123-128,139-150,159-166 | `tbl.tabular` | `tabular` with `*{N}{l}` columns, N = 10,12,14,14,12,6,12,4,4; `\renewcommand{\arraystretch}{2}` at 138, back to 1.25 at 151; not floats, no `\caption` (readme.tex has none) |
| table rules | readme.tex:140,142,149,160,162,165; article-setting.tex:34 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| caption package (load only) | article-setting.tex:33 | `cap.caption` | font=small, labelsep=quad; no `\caption` is called |
| inline text marks | readme.tex:43,63,79,95 (`\underline{M}ath ...`), 136 | `mark.kernel` | `\underline`, `\textbf` |
| inline code | readme.tex:13 and every table cell (e.g. 27) | `code.listings` | `\lstinline` with backtick delimiter; `\lstset{basicstyle=\color{darkred}\normalsize\ttfamily, backgroundcolor=\color{lightgray}, breaklines=true}` (article-setting.tex:70-75) |
| listing size and face | article-setting.tex:72 | `font.size-commands` | `\normalsize` (and `\ttfamily` as a `mark.kernel` switch) |
| colours | article-setting.tex:67-69 | `color.xcolor` | `\colorlet{lightgray}{gray!40}`, `\colorlet{darkred}{red!70!black}` |
| fancy cross-references (load only) | article-setting.tex:47 | `xref.prettyref` | `\usepackage{fancyref}`, no options; no `\fref` or `\Fref` in readme.tex |
| maths packages | math-symbols.sty:9-15 | `math.bm`, `math.amsmath`, `math.amssymb`, `math.mathtools` | `bm`, `mathrsfs`, `mathbbol` (`math.bm`); `amsmath`; `amssymb`, `amsfonts`; `mathtools` (load only, no mathtools command is used in the style) |
| maths alphabets | math-symbols.sty:16-17 | `math.bm` | `\DeclareSymbolFontAlphabet{\mathbb}{AMSb}` and `{\mathbbl}{bbold}`: kernel NFSS binding of the symbol font `mathbbol` declares, filed with the alphabets of `math.bm` (`font.nfss` is the other possible home) |
| display breaks | math-symbols.sty:21 | `math.amsmath` | `\allowdisplaybreaks[4]` |
| operators | math-symbols.sty:240-260 | `math.amsmath` | `\DeclareMathOperator` (plain: diff `d\!`, Diff, Expect, diag, eig, tr, lcm, rand, mean, var, corr, conv, card, rot, curl, divergence; starred: argmin, argmax, argopt, dist) |
| auto-size brackets, equation group | math-symbols.sty:283,287-289,300-301 | `math.amsmath` | `\left`/`\right` pairs, `aligned` inside `\left\{ ... \right.` |

Not present in the zip's template: abstract, contents (commented out at readme.tex:17), floats, theorems, footnotes, bibliography, index, appendix, fonts (no font package: Computer Modern default), language packages.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `math-symbols.sty` as a package | math-symbols.sty:5-301 | yes | not on CTAN (404), so zip-local; it is `\RequirePackage` of published packages (`math.bm`, `math.amsmath`, `math.amssymb`, `math.mathtools`) plus the macro definitions below, which the emitter loads as those packages and expands inline |
| constants and set aliases `\mi \mj \me \mdeg \mnatr \mintg \mrato \mreal \mcmpx \mhilb \mcond \mconst` | math-symbols.sty:35-46 | yes | `\newcommand` aliases of `\mathrm`, `\mathbb`, `^\circ` (`math.amssymb`) |
| function-space aliases with optional argument `\mscon \mscab \mslbg \mssbl` | math-symbols.sty:47-50 | yes | `\newcommand` with one `[I]` default, plain text substitution of `C`, `L^{..}(..)`, `H^{..}(..)` |
| vector, matrix, tensor and transposed aliases (about 200 names) | math-symbols.sty:54-108,112-148,152-188,192-235 | yes | each is one `\bm`, `\mathbf`, `\mathbb` or `\mathbbl` call on a letter or Greek symbol (`math.bm`, `math.amssymb`), `^{\mathrm T}` for transposes |
| `\mathbi` | math-symbols.sty:25 | yes | `\def\mathbi#1{\textbf{\em #1}}`: alias of `mark.kernel` switches; the readme never calls it |
| operators `\abs \norm \normlp` | math-symbols.sty:264-266 | yes | `\lvert \rvert`, `\|` and a subscript: `\newcommand` aliases over `math.amsmath` |
| derivative generators `\fracdiff \dfracdiff \fracpartial \dfracpartial` and their `s` forms | math-symbols.sty:272-279 | yes | `\frac`/`\dfrac` of `\diff` or `\partial`, composition of macros defined above; no conditionals or counters |
| `\mfwhen`, `\mclosure*`, `\mvct*` | math-symbols.sty:283,287-289,293-296 | yes | `\left. ... \right|_{..}`, `\left( ... \right)` pairs, a fixed index list with `\ldots`; plain `\newcommand` |
| `\mequlist` and environment `equlist` | math-symbols.sty:300-301 | yes | `\left\{ \begin{aligned} .. \end{aligned} \right.`; the environment only opens and closes the `\left`/`\right` pair, so inline expansion gives the same markup |
| `\artversion` | readme.tex:4 | yes | string macro, expands to `2.2.3.1026` in `\date` and the footer (article-setting.tex:52) |
| article-setting.tex | article-setting.tex:1-79 | yes | an `\input` file of `\usepackage`, `\geometry`, `\hypersetup`, `\lstset` and `fancyhdr` commands: the preamble written out in the ways above |
| custom-math-symbols.tex | custom-math-symbols.tex:1-291 | not needed | not loaded by readme.tex or by math-symbols.sty; only a macro copy for the VSCode hover preview (it redefines `\bm` as `\boldsymbol` at :11, outside the sample) |
| helper scripts and makefile | helper/*.py, helper/*.rb, makefile:1-47 | not needed | author-side generators of macro and table text that is already pasted into the shipped files; the makefile runs `xelatex` with `-shell-escape` (makefile:3) but no loaded package needs shell escape (no `minted`); not a blocker |

## Content-opaque
none

## Lib changes
- New ways proposed: `xref.prettyref` `fancyref` (CTAN page read: Axel Reichert, GPL, in TeX Live and MiKTeX; load-only here, `\usepackage{fancyref}` with no options). W1: published on CTAN and in TeX Live. W2: the CTAN page lists no options and the commands `\fref{label}` and `\Fref{label}`, which take one label whose prefix (`sec:`, `fig:`) picks the wording; how far its format hooks are declarative was not checked (documentation PDF not read). W3: serves any document with labelled sections and floats, not one zip. W4: a preamble load line plus an inline `\fref{key}` call; it sits beside `xref.cleveref` and `xref.varioref`. The sample never calls it, so dropping it would not change the output.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
