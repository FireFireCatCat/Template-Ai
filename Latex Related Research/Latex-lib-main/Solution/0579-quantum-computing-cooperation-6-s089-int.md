yes

# 0579-quantum-computing-cooperation-6-s089-int: 6.s089 Introduction to Quantum Computing, lecture notes (MIT IAP 2019/2020)

- Unverified: read from the source, not compiled.
- Source: Source/0579-quantum-computing-cooperation-6-s089-int/ (origin: https://codeload.github.com/Quantum-Computing-Cooperation/6.s089-Intro-to-Quantum-Computing/zip/refs/heads/master; licence: not established)
- Kind: misc (course lecture notes in a plain article document; the manifest hint "book" is not borne out by the sample)
- Lib: v5
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (kernel `article` loaded unchanged; the settings are the sample's own preamble lines, Lecture2.tex:1-21; the zip has no `.cls` or `.sty`)
- Class origin: tex-distribution-unbundled
- Main file: Lecture2.tex (other samples: Lecture0.tex, Lecture1.tex, Lecture3.tex, Lecture4.tex, Lecture5.tex, Lecture6.tex, Lecture7.tex, Old2019/Lectures.tex)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip holds no `.cls`, `.sty` or `.dtx`: all nine `.tex` files are plain `article` documents whose preambles load only published packages (Lecture2.tex:3-21). The only zip-local code is three `\newcommand` aliases (`\bra`, `\ket`, `\braket`, Lecture2.tex:25-27), which reduce by inline expansion to kernel math delimiters. There is no TikZ or other template artwork (figures are included PNG/PDF files, which are content), no bibliography and no external tool. A few body macros in other lectures (`\bigtimes`, `\equivy`, `\nequiv`, `\Vec`) are not defined anywhere in the zip; they are content-level typos or compile faults, not template constructs.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (Lecture2.tex:1; the comment on that line mentions paper size but no paper option is passed)
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (Lecture2.tex:33-38), `\tableofcontents` (:40), `\section` `\subsection` (:44, :47), `\subsubsection` (Lecture4.tex:174), `figure`, `table`, `tabular`, `center`, `itemize`, `enumerate`, `\footnote`. No `abstract` environment, no `\appendix` and no `thebibliography` in any file.

## Component map
All rows cite Lecture2.tex unless a path is given. The nine files share one preamble (Lecture4.tex to Lecture7.tex add `\usepackage{makecell}` at line 8; Old2019/Lectures.tex omits the duplicate `hyperref` and `wrapfig` loads).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | :1 | `class.article` | `11pt` |
| font size | :1 | `page.class-options` | `11pt`; no paper option |
| page geometry | :5 | `page.geometry` | `\usepackage{geometry}` with no options (effect left to the package defaults; not computed) |
| text encoding | :21 | `font.fontenc-t1` | `T1`; no text-font package, so the Computer Modern default |
| degree-sign symbols | :3; Lecture3.tex:109 | `font.icons` | package `gensymb` (a load-only symbol-glyph package, used as `\degree`); an earlier zip filed `gensymb` under `math.amssymb`, either home is a load-only symbol package |
| micro-typography | :14 | `sp.microtype` | `protrusion=true,expansion=true` |
| line spacing | :18 | `sp.linespread` | `\linespread{1.12}` |
| link colours and PDF options | :7-13, :15 | `meta.hyperref` | `colorlinks=true, linkcolor=black, filecolor=magenta, urlcolor=blue` via `\hypersetup`; `hyperref` is loaded twice (:7, :15), the second with no options |
| mail links and URLs | :33; Lecture0.tex:361 | `meta.hyperref` | `\href{mailto:..}{..}` inside `\author`; hyperref's `\url{..}` in the reading lists (Lecture0.tex:361-365, 372-382) |
| title block | :33-35, :38 | `front.maketitle` | `\title{Introduction to Quantum Computing\\Lecture 2: ...}`, `\author{name\footnote{..}\\\href{..}{..}}`, `\date{Massachusetts Institute of Technology\\6.s089 IAP 2020}`, `\maketitle` with the stock article look |
| author note | :33 | `front.thanks` | a `\footnote{Notes LaTeXed by ...}` inside `\author` (also Lecture1.tex:33, Lecture3.tex:33, Lecture4.tex:35, Lecture6.tex:35) |
| page breaks around front matter | :39, :41 | `pg.break` | `\newpage` after `\maketitle` and after the contents; also before sections (Lecture0.tex:48, 272, 356) |
| contents | :40 | `toc.kernel` | `\tableofcontents`, default depth |
| headings | :44, :47 | `head.kernel` | `\section`, `\subsection`, `\subsubsection` (Lecture4.tex:174, Old2019/Lectures.tex:153); default numbering and look, no `titlesec` |
| lists | Lecture0.tex:359-368; Lecture1.tex:123-139; Lecture4.tex:176-187 | `list.kernel` | `itemize`; `enumerate` with nested `itemize`; no `enumitem` |
| centred statement | :48-50; Lecture7.tex:145 | `sp.ragged` | `center` environment around each postulate; `\centerline{..}` (plain TeX macro) in Lecture7.tex |
| inline marks | :48-50, :80 | `mark.kernel` | `\textit`, `\textbf`, `\textrm` |
| underlined labels | Lecture7.tex:80, 90, 110 | `mark.ulem` | kernel `\underline{Given}` etc. (no `ulem` loaded); the type is "underline a span" |
| line breaks and manual space | :33-35; Lecture7.tex:57-58, 308, 337 | `sp.manual-space` | `\\` in title/author/date; `\newline`; `\\[5pt]` rows; `\hspace{1.7in}` |
| paragraph indent off | :76 | `sp.lengths` | `\noindent` (one-paragraph form of `\parindent`) |
| small text | Lecture0.tex:361 | `font.size-commands` | `{\footnotesize ...}` |
| footnotes | :228, :271, :337 | `fn.kernel` | plain `\footnote` in the body |
| display equations | :55-57, :96-98; Lecture7.tex:179-182, 332 | `math.amsmath` | `align`, `\nonumber`, `pmatrix`, `cases` (Lecture7.tex:218), `aligned` (Lecture7.tex:332), `array`, `\pmod`; default right-hand numbering |
| math extras | :19; Lecture7.tex:179 | `math.mathtools` | `\usepackage{mathtools}`; `rcases` environment |
| math symbols | :3 | `math.amssymb` | `amssymb` (`\mathbb{R}`, `\mathbb{C}`, Lecture0.tex:88) |
| Dirac macros | :25-27 | `math.kernel` | `\left\langle #1 \right|`, `\left|#1\right\rangle`, `\left\langle#1 |  #2\right\rangle`, kernel math delimiters, inlined |
| proof-end mark | Lecture7.tex:316; :3 | `thm.amsthm` | `amsthm` loaded; only `\qed` is used; no `\newtheorem`, `\theoremstyle` or `proof` anywhere |
| figures | :275-279; Lecture0.tex:310-315; Lecture7.tex:347-352 | `fig.graphicx` | `figure` float, `\includegraphics[scale=0.35]{..png}` or `[width=.7\textwidth]{..pdf}`; placements `[t!]` `[h!]`, `\centering` |
| in-line image package | :6, :17 | `fig.wrapfig` | load-only; no `wrapfigure` environment in any file |
| tables | Lecture6.tex:64-74; Lecture3.tex:47-75; Lecture4.tex:54-63 | `tbl.tabular` | `table[!htbp]` or `[h!]` with `\centering`, `tabular{c|c c}`, `\hline`; three tabulars in one float (Lecture3.tex:50-72) |
| multi-line cells | Lecture4.tex:8, 199 | `tbl.multirow` | `makecell` package, `\makecell{..\\..}` |
| caption style | :20; Lecture7.tex:350 | `cap.caption` | `font=footnotesize, labelfont=bf`; `\caption*` (unnumbered) |
| captions | :277; Lecture3.tex:73 | `cap.kernel` | `\caption{..}` in figures and tables |
| cross-references | :44, :85, :210, :274 | `xref.kernel` | `\label` / `\ref` (`Eq. \ref{..}`, `Fig \ref{..}`); `\autoref` is not used |
| bibliography | :30 | none | only a commented `%\addbibresource{bibliography.bib}`; no bibliography, `\cite` or `thebibliography` in any file |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\bra` | Lecture2.tex:25 | yes | alias: expands to `\left\langle #1 \right|` (kernel math delimiters, `math.kernel`); an emitter inlines it |
| `\ket` | Lecture2.tex:26 | yes | alias: expands to `\left|#1\right\rangle`; inline |
| `\braket` | Lecture2.tex:27 | yes | alias: expands to `\left\langle#1 |  #2\right\rangle`; inline |
| `\makeatletter` .. `\makeatother` | Lecture2.tex:23, 28 | yes | wraps only the three `\newcommand` lines, no `@` name inside; drops with no effect |
| same four items | Lecture0.tex:23-28, Lecture1.tex:23-28, Lecture3.tex:23-28, Lecture4.tex:25-30, Lecture5.tex:25-30, Lecture6.tex:25-30, Lecture7.tex:25-30, Old2019/Lectures.tex:21-26 | yes | identical text, same reduction |

No counter, conditional, environment, `\def`, `.cls` or `.sty` is defined in any file.

## Content-opaque
Included images only, no TikZ or PSTricks: Lecture3Figs/BlochSphere_diag.png (Lecture2.tex:276), Lecture0Figs/ComplexPlane.pdf (Lecture0.tex:312), Lecture4Figs/*.png|pdf (Lecture4.tex:113, 155), ten circuit and diagram PDFs under Lecture7Figs/ (Lecture7.tex:127-364). The figure files ship in the zip. Body macros not defined in the zip and not template: `\Vec` (Lecture0.tex:90), `\bigtimes` (Lecture4.tex:178), `\equivy` (Lecture7.tex:82), `\nequiv` (Lecture7.tex:143); an invalid float placement `[Bloch Sphere]` (Lecture2.tex:275).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
