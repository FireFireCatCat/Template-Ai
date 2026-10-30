no

# 0675-basic-latex2e-book-template: Basic LaTeX2e Book Template

- Unverified: read from the source, not compiled.
- Source: Source/0675-basic-latex2e-book-template/ (origin: https://latextemplates.com/downloads/basic-book-template.zip; licence: Unlicense)
- Kind: book
- Lib: v5
- Engine: pdfLaTeX-compatible (T1 + inputenc utf8, `microtype`, `babel`; README.md:24 builds with pdflatex and bibtex)
- Look carried by: preamble (kernel `book` class unchanged except `a4paper`; the look is the package set in lib/packages.tex and the macros in lib/macros.tex, both `\input` by main.tex:10-11)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip has no .cls, .sty, .def, .cfg or .clo; lib/packages.tex, lib/macros.tex and lib/biblio.bib read in full)

## Verdict
The template is a plain `book` class plus a preamble of published packages (`geometry`, `microtype`, `natbib`, `ntheorem`, `algorithm`/`algpseudocode`, `booktabs`, `dcolumn`, `hyperref`...) and a handful of small macros. Every package and every component maps to an existing lib way, and nearly every macro reduces by inline expansion. One construct does not: lib/macros.tex:6-8 appends `\boldmath` to the kernel's `\bfseries` through `\g@addto@macro`, which changes the behaviour of every bold switch in the document by editing kernel macro code. That fails W2 and no lib way expresses it as a global effect, so the verdict is `no`. The sample itself has no bold math (no math in a heading or in `\textbf`), so the patch is invisible in this one sample; it still sits in the template's preamble.

## Blockers
- `BESPOKE/preamble` global patch `\makeatletter\g@addto@macro\bfseries{\boldmath}\makeatother`: every `\bfseries` (so every heading, `\textbf`, bold table head) also selects the bold math version (lib/macros.tex:6-8; the comment at lib/macros.tex:5 says "add bold mathematical symbols to section titles")

## Class setting
- Class: `class.book` options: `a4paper` (main.tex:8). The class is the LaTeX base class, not bundled in the zip; its source was not read.
- Class-native vocabulary used: `\frontmatter` (main.tex:19), `\mainmatter` (main.tex:35), `\backmatter` (main.tex:104), `\chapter` (main.tex:23, 29, 37, 90), `\maketitle` (main.tex:21), `\tableofcontents` (main.tex:33). No abstract, no appendix, no index.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:8 | `class.book` | a4paper |
| paper size | main.tex:8 | `page.class-options` | a4paper |
| page geometry | lib/packages.tex:1 | `page.geometry` | a4paper only (no margin keys; repeats the class option) |
| text font | lib/packages.tex:4 | `font.lmodern` | Latin Modern, no options |
| encodings | lib/packages.tex:5-6 | `font.fontenc-t1` | fontenc `T1`, inputenc `utf8` |
| language | lib/packages.tex:9 | `lang.babel` | `british` |
| micro-typography | lib/packages.tex:12 | `sp.microtype` | activate={true,nocompatibility}, final, tracking=true, kerning=true, spacing=true, factor=1100, stretch=10, shrink=10 |
| matter switches | main.tex:19, 35, 104 | `class.book` (native vocabulary) | `\frontmatter` `\mainmatter` `\backmatter` |
| title block | main.tex:13-15, 21 | `front.maketitle` | title "Notes on Algorithmic Number Theory", author "Alan Turing", `\date{}` empty, `\maketitle` |
| preface and acknowledgements | main.tex:23-31 | `head.kernel`, `front.dedication` | two `\chapter` pages in `\frontmatter` (unnumbered by the book class; book default heading) |
| chapter headings | main.tex:37, 90 | `head.kernel` | `\chapter` with book defaults, no `\renewcommand`, no `titlesec` |
| contents | main.tex:33 | `toc.kernel` | `\tableofcontents` |
| contents depth | lib/macros.tex:1 | `num.secnumdepth` | `tocdepth` = 1 |
| contents entry for bibliography | lib/packages.tex:16 | `toc.etoc` | `tocbibind` with nottoc, notlot, notlof (bibliography listed in contents) |
| page style | lib/macros.tex:3 | `hf.pagestyle-kernel` | `plain` |
| cross-references | main.tex:38, 41, 51, 72, 99 | `xref.kernel` | `\label` `\ref`; `\autoref` is not used |
| links | lib/packages.tex:43 | `meta.hyperref` | colorlinks, citecolor=blue, urlcolor=blue, filecolor=blue |
| theorem-like statements | lib/packages.tex:23; lib/macros.tex:25-29; main.tex:44-49, 93-97 | `thm.ntheorem` | package options amsmath, thref, thmmarks; `\theoremstyle{plain}`, `\theorembodyfont{\upshape}`, `\theoremseparator{.}`, `\theoremindent1\parindent`, `\newtheorem{example}{Example}[chapter]`; body `example` with an optional title |
| example counter, algorithm number | lib/macros.tex:10, 29 | `num.counters` | `example` numbered within `chapter`; `\renewcommand\thealgorithm{A.\arabic{algorithm}}` |
| algorithm float | lib/packages.tex:32-33; main.tex:53-70 | `alg.algorithmicx` | `algpseudocode` + `algorithm` (no options); `\State` `\While` `\If` `\EndIf` `\EndWhile` `\Return` `\gets`; `\Input` `\Output` items (see Bespoke code) |
| algorithm caption | main.tex:54-55 | `cap.kernel` | `\caption` of the `algorithm` float, no `caption` package |
| table float | main.tex:75-88 | `tbl.tabular` | `table[htbp]`, `tabular{l l}` |
| table rules | lib/packages.tex:39; main.tex:80-86 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| table centring | main.tex:76 | `sp.ragged` | `\centering` |
| table caption | main.tex:77-78 | `cap.kernel` | `\caption` above the tabular |
| decimal column type | lib/packages.tex:40; lib/macros.tex:22 | `tbl.siunitx` | `dcolumn`; `\newcolumntype{d}[1]{D{.}{.}{#1}}`; not used by the body table |
| math packages | lib/packages.tex:19-20 | `math.mathtools`, `math.amssymb` | no options |
| math operators | lib/macros.tex:19-20 | `math.amsmath` | `\DeclareMathOperator*` for `\argmin` and `\argmax`; not used by the body |
| figures | lib/packages.tex:26 | `fig.graphicx` | load only; no `\includegraphics` in the sample |
| code listings | lib/packages.tex:29 | `code.listings` | load only; no `\lstset`, no listing in the sample |
| list customisation | lib/packages.tex:36 | `list.enumitem` | load only; no list in the sample |
| citations | lib/packages.tex:15; main.tex:42, 101-102 | `bib.natbib` | option `round`; `\citep`, `\citet` |
| bibliography | main.tex:106-107 | `bib.bibtex-bst` | `\bibliographystyle{abbrvnat}`, `\bibliography{lib/biblio}` (entries in lib/biblio.bib:1-15 are content) |
| back-matter page break (defined, unused) | lib/macros.tex:15 | `pg.break`, `hf.pagestyle-kernel` | `\clearpage`, `\cleardoublepage` under `\pagestyle{empty}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\g@addto@macro\bfseries{\boldmath}` | lib/macros.tex:6-8 | no | Edits the code of a kernel font switch, so W2 fails; the effect (bold math version inside every bold span, not only headings) is not a call of any lib way. The nearest reduction is `\boldmath` inside every `head.titlesec` `\titleformat`, which narrows the effect to headings and would need every chapter and section format re-specified; not accepted as a faithful reduction. `BESPOKE/preamble`. |
| `\renewcommand\thealgorithm{A.\arabic{algorithm}}` | lib/macros.tex:10 | yes | `num.counters`: `\renewcommand` of a counter's printed form |
| `\algnewcommand{\Input}{\item[\textbf{Input:}]}` and `\Output` | lib/macros.tex:12-13 (used main.tex:57-58) | yes | Inline expansion to `\item[\textbf{Input:}]` and `\item[\textbf{Output:}]` inside `algorithmic` (`alg.algorithmicx` with `mark.kernel`); `\algnewcommand` is the package's own published command |
| `\clearemptydoublepage` | lib/macros.tex:15 | yes | Alias of `\clearpage{\pagestyle{empty}\cleardoublepage}` (`pg.break`, `hf.pagestyle-kernel`); never called |
| `\de` | lib/macros.tex:17 | yes | Alias of `\mathrm{d}`; never called |
| `\argmin`, `\argmax` | lib/macros.tex:19-20 | yes | `\DeclareMathOperator*` is `math.amsmath` (loaded through `mathtools`); never called |
| `\newcolumntype{d}[1]{D{.}{.}{#1}}` | lib/macros.tex:22 | yes | `array`'s `\newcolumntype` over `dcolumn`'s `D` column (`tbl.siunitx`); never called |
| `example` theorem environment | lib/macros.tex:25-29 | yes | `thm.ntheorem`: published `\newtheorem` with `ntheorem` style commands |

## Content-opaque
none (the sample has no figure, no tikz picture and no template artwork; the in-text formulas such as main.tex:46-48 and 95 are content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
