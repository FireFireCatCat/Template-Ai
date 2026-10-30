yes

# 0880-niki864-thesistemplate: NIT Tiruchirappalli B.Tech thesis template (niki864/ThesisTemplate)

- Unverified: read from the source, not compiled.
- Source: Source/0880-niki864-thesistemplate/ (origin: https://codeload.github.com/niki864/ThesisTemplate/zip/refs/heads/master; licence: MIT)
- Kind: thesis
- Lib: v6
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (main.tex preamble plus hand-laid front-matter pages in the files it `\input`s; the zip has no .cls or .sty)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; the pages titlepage.tex, bonafide.tex, abstract.tex, acknowledgement.tex, Chapter1.tex, Chapter2.tex, appendix.tex are `\input` by main.tex:74-77,79,96,98,111)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The zip is a kernel `book` document whose look is set only by published packages loaded in the preamble (main.tex:14-67) and by hand-laid front-matter pages made of kernel commands. There is no zip-local class, style, environment, counter or conditional: the only redefinitions are `\renewcommand` of published hooks (`\cftchapleader`, `\contentsname`, `\headrulewidth`, `\footrulewidth`), all reducible to lib ways. No drawing, no external tool. Read-only analysis; `tabu` (loaded at main.tex:51) is not checked against current kernels because nothing is compiled.

## Blockers
none

## Class setting
- Class: `class.book` options: a4paper, 12pt, oneside (main.tex:14). The class is the LaTeX base `book`, not bundled in the zip; its source was not read.
- Class-native vocabulary used: `\frontmatter` (main.tex:72), `\mainmatter` (main.tex:89), `\chapter` (main.tex:95,97,110), `\section` `\subsection` `\subsubsection` (Chapter1.tex:4,7,13), `\tableofcontents` `\listoftables` `\listoffigures` (main.tex:81,84,87), `\bibliography` as the unnumbered bibliography chapter (main.tex:105), `\appendix`-style chapters via the `appendices` environment of the `appendix` package (main.tex:107).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:14 | `class.book` | a4paper, 12pt, oneside |
| paper and size | main.tex:14 | `page.class-options` | a4paper, 12pt, oneside |
| page geometry | main.tex:48,53 | `page.geometry` | a4paper, tmargin=1in, rmargin=1in, bmargin=1in, lmargin=1.5in |
| input encoding | main.tex:15 | `font.fontenc-t1` | `inputenc` option utf8 |
| text face | main.tex:47 | `font.mathptmx` | `\usepackage{times}`, no options |
| point sizes and line pitch on the hand-laid pages | titlepage.tex:4,7,11,28; bonafide.tex:8,20,34; abstract.tex:3,10; acknowledgement.tex:8,13,19,25,30 | `font.size-commands` | `\fontsize{18pt}{1cm}`, `{14pt}{21pt}`, `{14pt}{1cm}`, `{16pt}{16pt}`, `{12pt}{24pt}`, `{16pt}{24pt}`, `{12pt}{18pt}` with `\selectfont` |
| line-spacing package | main.tex:49 | `sp.setspace` | `\usepackage{setspace}`, load only (no `\setstretch` or `\onehalfspacing` call anywhere; the 24pt pitch above comes from `\fontsize`) |
| maths packages | main.tex:16,17 | `math.amssymb`, `math.amsmath` | load only (no equation in any sample file) |
| colours | main.tex:19-23 | `color.color` | `color` package; `\definecolor` codegreen {0,0.6,0}, codegray {0.5,0.5,0.5}, codepurple {0.58,0,0.82}, backcolour {0.95,0.95,0.92} (rgb); named `magenta` at main.tex:27 |
| header and footer | main.tex:52,62-67 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\cfoot{\thepage}`, `\rhead{}`, `\lhead{}`, `\headrulewidth`=0pt, `\footrulewidth`=0pt |
| plain-style front pages | bonafide.tex:1; abstract.tex:1; acknowledgement.tex:1 | `hf.pagestyle-kernel` | `\thispagestyle{plain}` |
| chapter heading look | main.tex:54,56-58 | `head.titlesec` | `\titleformat{\chapter}[display]{\normalfont\huge\bfseries\centering}{\chaptertitlename\ \thechapter}{20pt}{\Huge}` |
| section, subsection, subsubsection | Chapter1.tex:4,7,13; Chapter2.tex:3,19,32; appendix.tex:1 | `head.kernel` | `book` default looks and numbering |
| appendices | main.tex:55,107-112 | `num.appendix` | `appendix` package options `toc,page`; `appendices` environment; letter-numbered chapter |
| front matter and main matter switch | main.tex:72,89 | `class.book` | `\frontmatter`, `\mainmatter` (vocabulary of the class; roman then arabic page numbers come from the class) |
| document title (declared only) | main.tex:71 | `front.maketitle` | `\title{B.Tech Thesis Template}`; no `\maketitle` call exists, so nothing is printed |
| title page | titlepage.tex:1-34 | `front.titlepage-env` | `titlepage` environment holding a `center` environment, bold and sized lines, `\vspace*` gaps 1.4cm 0.8cm 2.0cm 0.3cm 0.5cm |
| centred blocks | titlepage.tex:2; bonafide.tex:2,11; abstract.tex:2; acknowledgement.tex:2 | `sp.ragged` | kernel `center` environment (and `\centering` in the chapter format, main.tex:57) |
| bold and italic marks | titlepage.tex:4,11,15,21,28,32; bonafide.tex:3,26,41; abstract.tex:3; acknowledgement.tex:3 | `mark.kernel` | `\textbf`, `\textit`; `\underline{\hspace{2in}}` at bonafide.tex:34 is a signature blank (a `\rule` of `sp.rule` would give the same) |
| vertical and horizontal gaps | titlepage.tex:6,10,13,17,23,26,30; bonafide.tex:6,9,17,22,31,37; abstract.tex:6; acknowledgement.tex:10,15,21,27; bonafide.tex:34; Chapter2.tex:35 | `sp.manual-space` | `\vspace`/`\vspace*` in cm, `\hspace{2in}`, `\noindent` (bonafide.tex:18), `\\`; `\hfill` in main.tex:73 |
| title-page logo | titlepage.tex:24 | `fig.graphicx` | `\includegraphics[width=1.25in]{NITT-Logo}` (NITT-Logo.png is shipped) |
| bonafide certificate page | bonafide.tex:1-45 | `front.dedication` | hand-laid declaration page: centred bold heading, 12pt/24pt paragraph, signature rows |
| bonafide signature rows | bonafide.tex:24-29,39-43 | `tbl.nicematrix` | `tabu` (main.tex:51), `\begin{tabu} to \textwidth { X[l] X[c] }` (the package is the parameter) |
| viva-voce line | bonafide.tex:33-35 | `tbl.tabular` | `tabular{lc}` with a blank |
| abstract page | abstract.tex:1-16 | `front.dedication` | hand-laid page, no `abstract` environment: centred bold 16pt/24pt heading, one 12pt/18pt paragraph |
| keyword line | abstract.tex:14 | `abs.keywords` | `\textit{Keywords}: ...` run-in line |
| acknowledgement page | acknowledgement.tex:1-32 | `front.dedication` | centred bold heading, 12pt/24pt paragraphs, `\vspace` 2.0cm and 1.0cm |
| contents and lists | main.tex:80-87 | `toc.kernel` | `\tableofcontents`, `\listoftables`, `\listoffigures` |
| toc extra entries and caption | main.tex:61,73,76,78,80,83,86,103 | `toc.kernel` | `\renewcommand\contentsname{\centerline{TABLE OF CONTENTS}}`; `\addtocontents{toc}{\textbf{Title}\hfill\textbf{Page No.}\par}`; `\addcontentsline{toc}{chapter}{...}` for ABSTRACT, ACKNOWLEDGEMENT, TABLE OF CONTENTS, LIST OF TABLES, LIST OF FIGURES, References |
| toc chapter dot leaders | main.tex:50,60 | `toc.tocloft` | `tocloft` package; `\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}` |
| toc depth in appendix | main.tex:108 | `num.secnumdepth` | `\addtocontents{toc}{\protect\setcounter{tocdepth}{0}}` |
| page breaks | main.tex:82,85,101; bonafide.tex:45; abstract.tex:16; acknowledgement.tex:32 | `pg.break` | `\newpage` |
| file inclusion | main.tex:74-77,79,96,98,111 | `struct.input` | `\input{titlepage}`, `{bonafide}`, `{abstract}`, `{acknowledgement}`, `{Chapter1}`, `{Chapter2}`, `{appendix}` |
| figure float | Chapter2.tex:9-16,25-30 | `fig.graphicx` | `figure`, `\centering`, `\includegraphics[width=.8\textwidth,center]{NodeMCU}` and `{Inert}`; `\graphicspath{ {images/} }` (main.tex:46) |
| figure placement `[H]` | main.tex:44; Chapter2.tex:25 | `fig.float` | `float` package; `figure[H]` |
| image key `center` | main.tex:45; Chapter2.tex:12,27 | `fig.adjustbox` | `\usepackage[export]{adjustbox}` makes `center` an `\includegraphics` key |
| table float and body | Chapter2.tex:39-56 | `tbl.tabular` | `table[h!]`, `\centering`, `tabular{||c c||}`, `\hline`, `\hline\hline`, row gaps `\\ [0.5ex]` and `\\[1ex]` |
| captions | Chapter2.tex:13,28,54 | `cap.kernel` | `\caption` below the float, kernel defaults |
| cross-references | Chapter2.tex:6,15,29,37,55 | `xref.kernel` | `\label{fig:NodeMCU}`, `{fig:IMU}`, `{table:Spec}`; `\ref` |
| code listing style | main.tex:18,24-42 | `code.listings` | `\lstdefinestyle{mystyle}`: backgroundcolor=\color{backcolour}, commentstyle=\color{codegreen}, keywordstyle=\color{magenta}, numberstyle=\tiny\color{codegray}, stringstyle=\color{codepurple}, basicstyle=\footnotesize, breakatwhitespace=false, breaklines=true, captionpos=b, keepspaces=true, numbers=left, numbersep=9pt, showspaces=false, showstringspaces=false, showtabs=false, tabsize=2; `\lstset{style=mystyle}` |
| code listing body | appendix.tex:6-45 | `code.listings` | `lstlisting[language=Python]` (Python text is content) |
| bibliography | main.tex:104,105; Chapter1.tex:11; reference.bib:1,13 | `bib.bibtex-bst` | `\bibliographystyle{unsrt}`, `\bibliography{reference}`, `\cite{akram}` `\cite{5334925}` (kernel `\cite`, no natbib) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}` | main.tex:60 | yes | a `tocloft` hook set to its own dot-fill command: `toc.tocloft` parameter |
| `\renewcommand\contentsname{\centerline{TABLE OF CONTENTS}}` | main.tex:61 | yes | a kernel caption string set to a centred line: `toc.kernel` string plus `sp.ragged` |
| `\renewcommand{\headrulewidth}{0pt}`, `\footrulewidth` | main.tex:66,67 | yes | `fancyhdr` rule lengths: `hf.fancyhdr` parameters |
| `\addtocontents{toc}{...}` and `\addcontentsline{toc}{chapter}{...}` lines | main.tex:73,76,78,80,83,86,103,108 | yes | kernel contents-file writes, one printed line each: `toc.kernel` and `num.secnumdepth` |
| `\lstdefinestyle{mystyle}` and `\lstset{style=mystyle}` | main.tex:24-42 | yes | `listings` option list (see the code row): `code.listings` |
| `\definecolor` x4 | main.tex:20-23 | yes | `color.color` names with rgb triples |
| `\geometry{...}`, `\titleformat{...}` | main.tex:53,56-58 | yes | `page.geometry` and `head.titlesec` calls |
| no `\newcommand`, `\def`, `\newenvironment`, `\newcounter`, `\newif` | grep over all .tex files finds none | not applicable | the zip defines no macro of its own |

## Content-opaque
none (the two JPG images in the floats at Chapter2.tex:12,27 and the Python code at appendix.tex:6-45 are content; both are plain `fig.graphicx` and `code.listings` material)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
