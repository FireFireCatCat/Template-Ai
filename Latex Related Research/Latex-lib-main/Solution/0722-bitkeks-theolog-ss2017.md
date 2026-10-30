yes

# 0722-bitkeks-theolog-ss2017: TheoLog SS2017 lecture notes (TU Dresden, plain article)

- Unverified: read from the source, not compiled.
- Source: Source/0722-bitkeks-theolog-ss2017/ (origin: https://codeload.github.com/bitkeks/theolog-ss2017/zip/refs/heads/master; licence: not established in the manifest; README.md:9 states CC BY-SA 4.0)
- Kind: misc (lecture notes with exercise-sheet solutions and a mock exam; the manifest hint `book` does not fit the sample)
- Lib: v5
- Engine: pdfLaTeX-compatible (`inputenc` utf8, `fontenc` T1, `tgpagella`, `babel`; no fontspec)
- Look carried by: preamble (kernel `article` loaded with two options; every look setting is a package call or a `\newcommand` alias in main:3-78)
- Class origin: tex-distribution-unbundled
- Main file: til-vl-ss2017-notizen.tex, cited as `main` (other samples: none; it `\include`s and `\input`s 19 files under includes/ and includes/ueb/, all read)
- Read: main yes (plus all 19 included .tex files), zip-local classes and styles none present (no .cls, .sty, .cfg, .def in the zip)

## Verdict
yes. The zip is a plain `article` document with a package-only preamble: no zip-local class or style, no TikZ or other artwork, no tool outside TeX. Every component is a lib way (`hf.fancyhdr`, `head.sectsty`, `list.enumitem`, `code.listings`, `tbl.colortbl`, `font.palatino`, `struct.input`...) and every zip-local macro (32 `\newcommand` aliases at main:40-78 and `\HRule` at includes/ueb/10.tex:1-4) reduces by inline expansion to lib ways. The Makefile only runs `latexmk -pdf` on the main file (Makefile:5-6), which drives ordinary TeX passes and generates no `.tex`, so it is not EXTERNAL.

## Blockers
none

## Class setting
- Class: `class.article` options: a4paper, 10pt (main:1)
- Class-native vocabulary used: `\section` `\subsection` `\subsubsection` and starred forms, `abstract` and `titlepage` environments (the title page is hand-laid inside `titlepage`; `\maketitle` `\title` `\author` are never used), `\tableofcontents`, `figure`, `description`/`itemize`/`enumerate`, `\include` and `\input`. The `titlepage` environment also sets `\thispagestyle{empty}` and restarts the page counter (kernel behaviour, no sample line).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main:1 | `class.article` | a4paper, 10pt |
| paper and base size | main:1 | `page.class-options` | a4paper, 10pt |
| page geometry | main:5 | `page.geometry` | top=2.5cm, bottom=2.5cm, left=2.5cm, right=2.5cm |
| input and font encoding | main:3, main:6, main:43, main:106 | `font.fontenc-t1` | inputenc utf8, fontenc T1; `\textvisiblespace` (in `\blank`) and `\textcopyright` as text symbols |
| text font | main:10 | `font.palatino` | `tgpagella`, no options; maths stays Computer Modern (no maths-font package) |
| size switches | main:41, main:84, main:94-95, main:122-124 | `font.size-commands` | `\small`, `\footnotesize`, `\Large`, `\LARGE`, `\large`, `\normalsize` |
| language | main:4, main:115, includes/rep1.tex:10, includes/musterklausur.tex:90, includes/ueb/11.tex:51-52 | `lang.babel` | ngerman; `\glqq` `\grqq`, the `"a` shorthand, `\today` printed in German |
| colours | main:8, main:24-30 | `color.xcolor` | option `table`; light-gray=gray 0.9, light-red=RGB 255,105,105, vl=RGB 84,200,70, link=RGB 84,100,220, sectionblue=RGB 0,64,114, subsectionblue=RGB 0,94,167, subsubsectionblue=RGB 0,110,195; named red, green, orange, blue, white, black, gray used by `\textcolor` and `rulecolor` (main:78, includes/musterklausur.tex:4, 87, 90, includes/plogik.tex:211) |
| PDF metadata and link colours | main:18-22 | `meta.hyperref` | pdfauthor, pdftitle, pdfsubject, colorlinks=true, linkcolor=black, urlcolor=link |
| URLs | main:101-106 | `meta.url` | `\url{...}` (the command comes from hyperref; no `url` package is loaded) |
| labels and references | main:12, main:45, includes/formale-systeme.tex:3, includes/theoretische-informatik.tex:5, includes/ueb/04.tex:41 | `xref.kernel`, `xref.hyperref` | `\label`, `\ref`; `\nameref` (package `nameref`, used inside `\verweis`) |
| running head and foot | main:9, main:37, main:83-89, main:134, main:138, includes/uebungen.tex:15 | `hf.fancyhdr` | `\pagestyle{fancy}`; `\lhead{\footnotesize Theoretische Informatik und Logik SS2017}`; `\chead{}`; `\rhead` reset by `\authorHead{Pataky}` or `{Schmittmann}` between parts; `\lfoot{}` `\rfoot{}`; `\cfoot{\thepage}`; `\headrulewidth`=0.1pt |
| title page | main:91-119 | `front.titlepage-env` | `titlepage` environment holding title lines, contents, abstract and info table; no `\maketitle` |
| title-page text | main:92-95 | `sp.ragged`, `mark.kernel`, `font.size-commands` | `\centering`; `{\scshape\Large ... \par}`, `{\scshape\LARGE ... \par}` |
| contents | main:97 | `toc.kernel` | `\tableofcontents` inside the title page, default depth |
| vertical fill | main:98, main:109 | `sp.manual-space` | `\vfill` |
| abstract | main:100-107 | `abs.kernel` | `abstract` environment inside `titlepage`; content has `\url`, `\vl`, `\\`, `\textcopyright` |
| title-page info table | main:110-117 | `tbl.tabular` | `{p{3cm} p{10cm}}`, six rows; `\today` and the licence text are content |
| paragraph indent | main:121 | `sp.lengths` | `\setlength\parindent{0cm}` |
| heading look | main:15, main:122-124 | `head.sectsty`, `color.xcolor`, `font.size-commands` | `\sectionfont{\color{sectionblue}\Large}`, `\subsectionfont{\color{subsectionblue}\large}`, `\subsubsectionfont{\color{subsubsectionblue}\normalsize}` |
| headings | includes/formale-systeme.tex:1-2, includes/rep1.tex:3-4, includes/musterklausur.tex:12 | `head.kernel` | `\section`, `\subsection` numbered; `\subsection*`, `\subsubsection*` unnumbered; no counter changes |
| file structure | main:126-128, main:131, main:135-136, main:139-140, includes/uebungen.tex:4-19 | `struct.input` | `\include{includes/...}` (page break before and after), `\input{includes/...}` |
| page breaks | main:130, main:133, includes/uebungen.tex:11, 14, 18 | `pg.break` | `\newpage` |
| lists | includes/formale-systeme.tex:5-22, includes/theoretische-informatik.tex:8-13, includes/theoretische-informatik.tex:143, includes/musterklausur.tex:85 | `list.kernel` | `description` nested to three levels (includes/theoretische-informatik.tex:63-77), `itemize`, `enumerate` |
| list parameters | main:14, main:33-34, includes/musterklausur.tex:53, 125, includes/ueb/09.tex:19, 36, includes/rep3.tex:227 | `list.enumitem` | `\setlist[enumerate,1]{label=\textbf{\alph*)}, leftmargin=2em}`, `\setlist{itemsep=0em}`; per-list `[leftmargin=1.75cm]`, `[label=\roman*)]`, `[leftmargin=1cm]`, `[leftmargin=2cm]` |
| list item spacing | includes/theoretische-informatik.tex:144, 243 | `sp.lengths` | `\setlength\itemsep{0em}` inside `itemize` |
| inline marks | main:42, main:45, includes/ueb/11.tex:58-59 | `mark.kernel`, `mark.ulem` | `\textbf`, `\textit`; kernel `\underline` (the underline type; `ulem` is not loaded) |
| highlight boxes | main:41, main:44 | `box.fancybox` | `\colorbox{vl}{...}` and `\colorbox{light-gray}{...}` (the `\fcolorbox` family from xcolor) |
| display maths | includes/rep3.tex:4-6, 38-43, includes/musterklausur.tex:64, 107, includes/ueb/01.tex:30-35, includes/ueb/09.tex:16 | `math.amsmath` | `equation*`, `align*`, inline `cases`, `\substack`, `\underbrace`, `\overbrace`, `\boxed` (includes/ueb/01.tex:100), `\text` |
| maths symbols | main:13, main:53-56, includes/rep1.tex:14 | `math.amssymb` | `\mathbb`, `\mathfrak`, `\mathcal` with amssymb and amsfonts |
| code listings | main:17, includes/musterklausur.tex:1-7, 16-33, includes/ueb/02.tex:1-9, 18 | `code.listings` | `\lstset{frame=single, basicstyle=\footnotesize, rulecolor=\color{gray}, xleftmargin=0.3cm, xrightmargin=3cm}`, set twice with the same values; `lstlisting` without `language`, once inside a table cell |
| tables | includes/musterklausur.tex:15, 51, includes/rep3.tex:156-181, includes/ueb/01.tex:21-28, 47-57, 73-90 | `tbl.tabular` | `{p{0.5\textwidth} p{0.5\textwidth}}` (also `[t]`), `{\|l\|l\|}` with `\hline`, `{l\|llll}`, `{ll}` |
| table cell colour | main:8, includes/ueb/01.tex:50-53 | `tbl.colortbl` | `\cellcolor{light-red}` (xcolor option `table`) |
| float wrapper | includes/ueb/01.tex:45-58, 71-91 | `fig.graphicx` | `figure[h]` with `\centering{}`, holding only a tabular; no `\caption`, no image |
| load-only packages | main:7, main:11, main:16 | `fig.graphicx`, `note.marginnote`, `fig.wrapfig` | `graphicx`, `marginnote`, `wrapfig` loaded without options and never called (no `\includegraphics`, `\marginnote`, `wrapfigure` in any file) |
| manual spacing and line breaks | includes/musterklausur.tex:35, includes/rep2.tex:72-76, includes/plogik.tex:209-210, includes/rep3.tex:146-147, 157 | `sp.manual-space` | `\vspace{1.5cm}`, `\hspace{.52cm}`, `\hspace{2.55cm}`, `\hspace{1cm}`, `\phantom`, `\hspace{0.3em}`, `\newline` in cells |
| rule | includes/ueb/10.tex:3, includes/ueb/10.tex:83 | `sp.rule` | `\rule{3cm}{0.2mm}` via `\HRule` |
| centred block | includes/ueb/09.tex:86-88 | `sp.ragged` | `center` environment |
| hyphenation hints | includes/theoretische-informatik.tex:107 | `sp.hyphenat` | kernel `\-` inside one long word |
| bibliography, index, footnotes, theorems, captions, TikZ, images | none in any file | none | not used |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\authorHead{#1}` | main:40 | yes | `\rhead{\footnotesize Dozent: Prof. Krötzsch, Autor: #1, CC BY-SA 4.0}` (`hf.fancyhdr`, `font.size-commands`); the emitter writes the `\rhead` line at main:86, 134, 138 and includes/uebungen.tex:15 |
| `\vl{#1}` | main:41 | yes | `\colorbox{vl}{\textcolor{white}{\small\textbf{#1}}}` (`box.fancybox`, `color.xcolor`, `font.size-commands`, `mark.kernel`) |
| `\f{#1}` | main:42 | yes | `\textbf{#1}` (`mark.kernel`) |
| `\blank` | main:43 | yes | `\text{\textvisiblespace}` (`math.amsmath`, `font.fontenc-t1`) |
| `\hili{#1}` | main:44 | yes | `\colorbox{light-gray}{\textcolor{black}{#1}}` (`box.fancybox`, `color.xcolor`) |
| `\verweis{#1}` | main:45 | yes | `\textit{\ref{#1} \nameref{#1}}` (`mark.kernel`, `xref.kernel`, `xref.hyperref`) |
| `\LOES` | main:46 | yes | `\textbf{Lösung:~}` |
| `\prob`, `\prspec`, `\phalt`, `\paq` | main:48-51 | yes | `\textbf{#1}`; `\textbf{P}_{\text{#1}}`; nested alias expansion (`math.amsmath`, `mark.kernel`) |
| `\N \Q \R \POT` | main:53-56 | yes | `\mathbb{N}`, `\mathbb{Q}`, `\mathbb{R}`, `\mathcal{P}` (`math.amssymb`) |
| `\TMM \LANG \SIGS` | main:58-60 | yes | `\mathcal{M}_{#1}`, `\mathcal{L}`, `\Sigma^{*}` |
| `\MT \NP` | main:62-63 | yes | `\mathit{#1}`; `\mathit{NP}` |
| `\INT \ZUW \FM \HU \HE \GDW` | main:65-70 | yes | `\mathcal{I}`, `\mathcal{Z}`, `\mathcal{T}`, `\Delta_{F}`, `\mathit{HE}`, `\Leftrightarrow` |
| `\C \SESP \SUBINT` | main:72-74 | yes | `\mathcal{C}`, `\mathit{SETSPLITTING}`, `\mathcal{J}` |
| `\copaq \M \POINT` | main:76-78 | yes | `\overline{\mbox{\textbf{P}\strut}}_{\text{äquiv}}` (maths content), `\mathcal{M}`, `{\textcolor{red}{* }}` (`color.xcolor`) |
| `\HRule{#1}{#2}` | includes/ueb/10.tex:1-4 | yes | `\par\vspace*{\dimexpr-\parskip-\baselineskip+#2}\noindent\rule{#1}{0.2mm}\par\vspace*{\dimexpr-\parskip-.5\baselineskip+#2}`: only length expressions, a rule and paragraph breaks (`sp.manual-space`, `sp.rule`); one call, includes/ueb/10.tex:83, `\HRule{3cm}{3mm}` |
| `\lstset` blocks in the body | includes/musterklausur.tex:1-7, includes/ueb/02.tex:1-9 | yes | `code.listings` key=value settings, identical values twice |
No `.cls`, `.sty`, `\def`, `\newif`, `\newcounter`, `\newenvironment` or `\makeatletter` anywhere in the zip; the only `\renewcommand` is `\headrulewidth` (main:37).

## Content-opaque
none (the two `figure` floats at includes/ueb/01.tex:45 and :71 hold plain tabulars, which `tbl.tabular` covers; no picture, image or TikZ anywhere). Source quirks that are content, not template: `\boxed` arguments that switch in and out of maths (includes/ueb/04.tex:33), the `"a` shorthand inside maths (includes/rep1.tex:10).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
