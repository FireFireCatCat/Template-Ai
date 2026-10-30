yes

# 0830-lfoppiano-phd-thesis: PhD dissertation "Automated Extraction and Curation of Materials Information from Scientific Literature" (L. Foppiano, University of Tsukuba)

- Unverified: read from the source, not compiled.
- Source: Source/0830-lfoppiano-phd-thesis/ (origin: https://codeload.github.com/lfoppiano/PhD-Thesis/zip/refs/heads/main; licence: not established)
- Kind: thesis
- Lib: v6
- Engine: pdfLaTeX-compatible (PNG/JPG figures, BibTeX, no fontspec; the commented `dvipdfmx` option at 0main.tex:4 and the `\gt` in unused macros at 0main.tex:73-74 are pTeX leftovers that never run)
- Look carried by: preamble (kernel `report` class plus one preamble of published packages in 0main.tex; the zip has no .cls, .sty or .bst)
- Class origin: tex-distribution-unbundled
- Main file: 0main.tex (other samples: none; the chapter files 1abstract.tex ... 11_publications.tex are `\input`/`\include`d by it)
- Read: main yes, zip-local classes and styles none present (0main.tex read whole; all eleven chapter files 1abstract.tex to 11_publications.tex also read whole, plus a command tally over all .tex files for the macros defined in the preamble; references.bib is content and was only counted, 554 entries)

## Verdict
yes. The look is the kernel `report` class (a4paper, 11pt) plus a preamble of published packages (CTAN or TeX Live, checked for `listliketab`, `iitem` and `here` at ctan.org/pkg). Every body construct (chapters, abstract, lists, figures, subfigures, sideways tables, booktabs and `tblr` tables, a `listings` block, `verbatim`, `displayquote`, BibTeX citations) maps to a lib way. The zip-local macros are `\newcommand` aliases, unused stubs and one hand-laid cover macro built only from kernel commands, all reducible; there is no TikZ drawing (the package is loaded but never called) and nothing needs a tool outside TeX (`epstopdf` is loaded but the zip holds no .eps file).

## Blockers
none

## Class setting
- Class: `class.report` options: `a4paper`, `11pt` (0main.tex:1)
- Class-native vocabulary used: `\chapter`, `\chapter*`, `abstract` environment (a separate page in `report`), `\maketitle` (a title page by default in `report`), `\tableofcontents` `\listoffigures` `\listoftables`, `\appendix` not used. The kernel class source was not read.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | 0main.tex:1 | `class.report` | a4paper, 11pt |
| paper and size | 0main.tex:1 | `page.class-options` | a4paper, 11pt |
| page geometry | 0main.tex:98-102 (the `geometry` line is commented out at :82) | `page.setlength` | \oddsidemargin=9mm, \evensidemargin=9mm, \topmargin=5mm, \textwidth=140mm, \textheight=200mm |
| paragraph and list spacing | 0main.tex:104-105 | `sp.lengths` | \parskip=1em, \topsep=0em |
| calc syntax | 0main.tex:13 | `sp.lengths` | `calc` loaded, no infix expression used in the files read |
| line spread | 0main.tex:107, 149 | `sp.linespread` | \baselinestretch=1.0 |
| text face (Times) | 0main.tex:3 | `font.mathptmx` | `times` (loaded first) |
| text face (Latin Modern) | 0main.tex:35 | `font.lmodern` | `lmodern`, loaded after `times`, so it sets the final family defaults (comment: "for bold teletype font") |
| maths packages | 0main.tex:5-7, 36, 79-80 | `math.amsmath`, `math.amssymb` | amsmath (twice), amssymb, amsfonts, amsopn; `\DeclareMathOperator{\diag}{diag}` (unused) |
| maths arrows | 0main.tex:21 | `math.physics` | `esvect` loaded (a math-notation package as the parameter); no `\vv` call in any file |
| colour | 0main.tex:37, 44 | `color.xcolor` | `\textcolor{red}` inside the listings `postbreak` value |
| hyperlinks | 0main.tex:152-157 | `meta.hyperref` | colorlinks=true, linkcolor=blue, filecolor=magenta, urlcolor=cyan |
| url package and style | 0main.tex:10, 68, 158 | `meta.url` | `url` loaded twice, `\urlstyle{same}` |
| anchors for toc entries | 0main.tex:173, 178, 188, 193, 253, 260 | `xref.hyperref` | `\phantomsection` before each `\addcontentsline` |
| bookmark strings | 0main.tex:226; 3introduction.tex:185 | `meta.hyperref` | `\texorpdfstring{\textsuperscript{2}}{2}` in chapter and subsection titles |
| outer cover page | 0main.tex:115-135, 162 | `front.titlepage-env` | hand-laid page: \newpage \null \vskip 5em, centre block, `\LARGE` title, `tabular[t]{c}` holding `\authorlarge`, `\large \@date`, `\thispagestyle{empty}`; built from `pg.break`, `sp.manual-space`, `font.size-commands`, `sp.ragged` (the `center` environment), `tbl.tabular`, `hf.pagestyle-kernel` |
| cover text block | 0main.tex:115-120 | `sp.manual-space` | \vspace{35mm}, \vspace{10mm}, `\LARGE March 2024`, `\Huge Luca Foppiano` |
| title block (second cover) | 0main.tex:138-147, 163 | `front.maketitle` | `\title{\vspace{-15mm}{...}\vspace{65mm}}`, `\author{...}` with `\Large`/`\LARGE`/`\Huge` lines and `\vspace{4mm}`/`\vspace{10mm}`, `\date{}` |
| abstract | 0main.tex:173-175; 1abstract.tex:1, 22 | `abs.kernel` | `abstract` environment, entry added by `\addcontentsline{toc}{chapter}{Abstract}` |
| blank verso page | 0main.tex:176 | `pg.break` | \newpage \thispagestyle{empty} \mbox{} \newpage (the empty `\mbox{}` is a kernel box that keeps the page; page style is `hf.pagestyle-kernel`) |
| acknowledgements page | 0main.tex:178-181; 2acknowledgements.tex:1 | `front.dedication` | `\chapter*{Acknowledgements}` (a `head.kernel` heading) with a hand-added toc entry |
| contents and lists | 0main.tex:183-195 | `toc.kernel` | \tableofcontents, \listoffigures, \listoftables, each after `\pagebreak` (`pg.break`) |
| contents depth | 0main.tex:95 | `num.secnumdepth` | tocdepth=3 |
| page numbering | 0main.tex:96, 168-169, 198-199 | `pgnum.pagenumbering` | roman (front matter, page reset to 1), then arabic (page reset to 1) |
| page style | 0main.tex:134 | `hf.pagestyle-kernel` | no `\pagestyle` call, so the `report` default `plain`; `\thispagestyle{empty}` on the cover |
| headings | 0main.tex:201-232; 3introduction.tex:62, 114, 136; 7supermat.tex:89 | `head.kernel` | `\chapter` `\section` `\subsection` `\subsubsection` `\paragraph` with the class defaults; no `titlesec` |
| chapter and part files | 0main.tex:175, 181, 203-232, 262 | `struct.input` | `\input{...}` for each chapter, `\include{11_publications.tex}` for the last (the argument carries a `.tex` suffix and the kernel `\include` adds one itself; whether that name resolves was not checked) |
| theorem declarations | 0main.tex:16, 69-72, 85-90 | `thm.amsthm` | `amsthm` loaded, `\newtheorem` for Definition, Theorem, Lemma, Proof (numbered in section) and definition, lemma, observation, example, theorem, problem; no `\theoremstyle`; no theorem environment is used in any file |
| itemize, enumerate | 10curation.tex:15, 233; 9supercon2.tex:31 | `list.kernel` | `itemize`, `enumerate` |
| list margins | 0main.tex:57-59 | `list.enumitem` | \setlist[enumerate]{leftmargin=.5in}, \setlist[itemize]{leftmargin=.5in} |
| other list packages | 0main.tex:11, 65 | `list.paralist` | `listliketab` (CTAN, Scott Pakin) and `iitem` (CTAN, Ben Vitecek), another list-environment package as the parameter; loaded, never called |
| block quotation | 6ner_materials.tex:180-182, 189-191; 0main.tex:32 | `lang.csquotes` | `csquotes` loaded without options, `displayquote` environment used twice |
| inline marks | 3introduction.tex:82, 109; 7supermat.tex:36; 10curation.tex:8, 48 | `mark.kernel` | `\textbf` `\textit` `\emph` `\texttt` `\textsuperscript` `\textsubscript` |
| T_c shorthand | 0main.tex:47 | `mark.kernel` | `\newcommand{\tc}{T$_{c}$}` (used on 38 lines of 3introduction, 6ner_materials, 7supermat and 9supercon2) |
| footnotes | 3introduction.tex:64; 9supercon2.tex:5 | `fn.kernel` | `\footnote{\url{...}}` |
| figure float | 9supercon2.tex:23-28 | `fig.graphicx` | `figure[htbp]`, `\centering`, `\includegraphics[width=\textwidth]`, `\caption` below, `\label` |
| graphics extensions | 0main.tex:50-54 | `fig.graphicx` | `\DeclareGraphicsExtensions{.eps,.pdf,.png,.jpg}` under `\ifpdf` (the else branch `{.eps}` is dead under pdfLaTeX) |
| EPS conversion | 0main.tex:18 | `fig.epstopdf` | loaded; no .eps file in the zip (all figures are .png or .jpg), so no tool runs |
| here placement | 0main.tex:15 | `fig.float` | `here` (loads `float`, gives `[H]`); no `[H]` is used, floats use [ht], [htbp], [htpb] |
| subfigures | 0main.tex:62; 7supermat.tex:321-328 | `fig.subcaption` | `subfig[subrefformat=parens,labelformat=parens]`, `\subfloat[..]{\resizebox*{8cm}{!}{..}}` with `\hspace{5pt}` between |
| scaled tables | 8measurements.tex:145; 6ner_materials.tex:245, 399; 10curation.tex:326; 9supercon2.tex:155 | `fig.graphicx` | `\scalebox{0.6}`, `{0.8}`, `{0.9}`, `{0.7}`, `{0.8}` around a tabular or `tblr`; `\resizebox*` at 7supermat.tex:323 |
| rotated tables | 6ner_materials.tex:43-70, 241-265, 395-421 | `fig.rotating` | `sidewaystable[ht]`, `[htbp]` (package `rotating`, 0main.tex:24) |
| landscape pages | 0main.tex:19 | `pg.landscape` | `lscape` loaded, no `landscape` environment used |
| wrapped figures | 0main.tex:22 | `fig.wrapfig` | `wrapfig` loaded, no `wrapfigure` used |
| float flush | 9supercon2.tex:149-206 | `pg.afterpage` | `\afterpage{\clearpage ... table ... \clearpage}` around one table (`\clearpage` is `pg.break`) |
| tables | 5pdf_extraction.tex:87-101 | `tbl.tabular` | `table[ht]`, `\centering`, `\caption` above, `tabular{lccc}` |
| table rules | 5pdf_extraction.tex:92-97; 8measurements.tex:149 | `tbl.booktabs` | \toprule \midrule \bottomrule \cmidrule(lr){a-b} |
| table spans | 7supermat.tex:206, 209; 6ner_materials.tex:248; 8measurements.tex:148 | `tbl.multirow` | `\multirow{2}{5em}`, `\multicolumn{3}{c}`, `\makecell{..\\..}` |
| paragraph columns | 6ner_materials.tex:46, 98; 7supermat.tex:204 | `tbl.tabular` | `m{30em}`, `m{10em}` columns (array) |
| tblr table | 9supercon2.tex:152-204; 0main.tex:27 | `tbl.nicematrix` | `tabularray` `tblr{Q[l,m]Q[r,m]Q[r,m]}`, `\SetCell[c=3]{c}`, `\hline[1pt]`, `\hline[dashed]`, `\hline[dotted]` |
| tabularx | 0main.tex:23 | `tbl.tabularx` | loaded, no `tabularx` environment used |
| captions | 9supercon2.tex:26, 154 | `cap.kernel` | kernel `\caption`, figures below, tables above; no `caption` package |
| code listing | 0main.tex:33, 39-45; 9supercon2.tex:64-110 | `code.listings` | \lstset{basicstyle=\ttfamily, columns=fullflexible, frame=single, breaklines=true, postbreak=\mbox{\textcolor{red}{$\hookrightarrow$}\space}}; `lstlisting[numbers=left,numbersep=5pt,caption=...]` |
| verbatim code | 7supermat.tex:335-363, 374-391 | `code.verbatim` | `verbatim` environment (TEI XML text) |
| cross references | 0main.tex:240; 9supercon2.tex:21 | `xref.kernel` | `\label`, `\ref`, `Chapter~\ref{..}` |
| citations | 0main.tex:9, 248, 255-256 | `bib.cite-pkg` | `cite` package, `\cite` |
| bibliography | 0main.tex:253-256 | `bib.bibtex-bst` | `\bibliographystyle{unsrt}`, `\bibliography{references.bib}`, toc entry by `\addcontentsline` |
| publications list | 11_publications.tex:1-13 | `head.kernel` | `\chapter*`, `\section*`, `enumerate`, `\url` (body under `list.kernel`, `meta.url`) |
| algorithms | 0main.tex:8 | `alg.algorithm2e` | `algorithm2e[ruled,linesnumbered]` loaded, no algorithm environment used |
| columns | 0main.tex:31 | `cols.multicol` | loaded, no `multicols` used |
| filler text | 0main.tex:12 | `draft.todo` | `lipsum` loaded, no `\lipsum` call |
| drawing package | 0main.tex:20 | `art.tikz` | `tikz` loaded; no `tikzpicture`, `\draw` or `\node` in any .tex file, so there is no artwork and no `ART` |
| rule macros | 0main.tex:76-77 | `sp.rule` | `\bhline` and `\bvline` wrap `\hrule` and `\vrule` (unused) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\maketitleouter` with `\authorlarge`, `\makeatletter` reading `\@title` and `\@date` | 0main.tex:115-136, 162 | yes | A fixed sequence of kernel commands (no conditional, no counter, no kernel redefinition). The emitter writes the page inline with the text in place of `\@title`/`\@date`: `front.titlepage-env` made of `pg.break`, `sp.manual-space`, `font.size-commands`, `sp.ragged`, `tbl.tabular`, `hf.pagestyle-kernel` |
| `\tc` | 0main.tex:47 | yes | alias of `T$_{c}$` (`mark.kernel`); inline it or keep the `\newcommand` |
| `\keywords` stub | 0main.tex:48 | yes | `\providecommand` with no real body, never called; drop |
| `\mathchardef\mhyphen="2D` | 0main.tex:25 | yes | primitive assignment never used (no `\mhyphen` in any file); drop |
| `\fig`, `\eq` | 0main.tex:73-74 | yes | aliases that print `\gt fig.\ref{..}`; never called, and `\gt` is a pTeX font switch; drop, or `xref.kernel` text if needed |
| `\minmin`, `\argmax`, `\argmin`, `\normx` | 0main.tex:75, 92-93, 121 | yes | aliases of `\mathop`, `\limits`, `\left\Vert` (`math.amsmath`); never called |
| `\vect`, `\mat`, `\unitvect` | 0main.tex:109-111 | yes | aliases of `\mbox` with `\boldmath`/`\bf` (`mark.kernel`); never called |
| `\bhline`, `\bvline` | 0main.tex:76-77 | yes | `\noalign{\hrule height}` and `\vrule width` (`sp.rule`); never called |
| `\eat` | 0main.tex:113 | yes | swallows its argument; never called; drop |
| `\ifpdf ... \else ... \fi` | 0main.tex:50-54 | yes | engine test from the published `ifpdf`; the emitter writes the pdf branch, one `\DeclareGraphicsExtensions` line (no `ifpdf` is loaded by name in 0main.tex; where `\ifpdf` comes from was not traced) |
| listings `postbreak` value | 0main.tex:44 | yes | a box with a red `\hookrightarrow` as the value of a `code.listings` key |

## Content-opaque
none (the figures are .png/.jpg files, the `lstlisting` JSON at 9supercon2.tex:64-110 and the TEI XML at 7supermat.tex:335-391 are code text)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
