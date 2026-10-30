yes

# 0638-onrannual: ONR Ocean Battlespace Sensing annual report class (onrannual)

- Unverified: read from the source, not compiled.
- Source: Source/0638-onrannual/ (origin: https://mirrors.ctan.org/macros/latex/contrib/onrannual.zip; licence: lppl1.3)
- Kind: report
- Lib: v5
- Engine: pdfLaTeX-compatible (README:46-49 says Times comes from `mathptmx`; XeTeX is described as possible but gave no bold title in the author's test; nothing in the class needs fontspec or Lua)
- Look carried by: class (onrannual.cls defines every page, heading, title-block and caption setting; skeleton.tex only loads packages and sets option values)
- Class origin: ctan (the zip is the CTAN package `onrannual`, A. R. Maxwell, LPPL 1.3; README:1-2 and onrannual.cls:2-16; the README at :3-5 says it is not an official ONR release, which does not matter because W1 rests on CTAN)
- Main file: skeleton.tex (other samples: none; skeleton.pdf is the author's built output and was not read)
- Read: main yes, zip-local classes and styles all (onrannual.cls, 164 lines, read in full; it is the CTAN class itself, not a modified copy)

## Verdict
The look is carried by one published CTAN class, `class.onrannual`, which is a modified `article` (onrannual.cls:57). The sample adds only published packages (`textcomp`, `natbib`, `graphicx`, `color`) and option values, and the body uses only class-native commands and kernel constructs. Every in-scope component maps to a lib way; there is no artwork, no external tool and no unmapped component. Under the rubric's class-way rule the class's internal redefinitions (`\section`, `\maketitle`, `\@maketitle`) are carried by the class way; read as plain preamble code they are also reducible (see Bespoke code). This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.onrannual` options: none in the sample (skeleton.tex:1); the class itself loads kernel article with `12pt` (onrannual.cls:57) and `mathptmx` before it (onrannual.cls:54).
- Class-native vocabulary used: `\distribution{...}` (skeleton.tex:62), `\awardnumber{...}` (skeleton.tex:70), `\projecturl{...}` (skeleton.tex:73), `\title` and `\maketitle` (skeleton.tex:67,84), `\author{...}` with `\affil{...}` from `authblk` (skeleton.tex:45-58), `\section` only (sections are typed in capitals by the author; the class bolds them and applies `\MakeUppercase`, onrannual.cls:87-90), `\bibliography` and `\nocite` (skeleton.tex:191-192). `\subsection` and `\subsubsection` raise a package error (onrannual.cls:94-95). No abstract environment, no keywords, no date (the class never prints it: onrannual.cls:117,124-143).

## Component map
Rows marked "(inside class)" are settings made by onrannual.cls; the emitter reaches them through `class.onrannual`, and the row names the published way each one is an instance of.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | skeleton.tex:1; onrannual.cls:24 | `class.onrannual` | no options; base is kernel article |
| type size | onrannual.cls:57 (inside class) | `page.class-options` | `12pt` |
| page geometry | onrannual.cls:60 (inside class) | `page.geometry` | margin=0.8in, bottom=1.0in |
| text and maths font | onrannual.cls:54 (inside class) | `font.mathptmx` | `\RequirePackage{mathptmx}`, loaded before the class |
| extra characters | skeleton.tex:4 | `font.fontenc-t1` | `textcomp` only; no `fontenc` or `inputenc` |
| font sizes | onrannual.cls:71-72,128,132; skeleton.tex:116 | `font.size-commands` | `\fontsize{12}{14}\selectfont`; title `\fontsize{14}{\f@baselineskip}` plus `\fontseries{b}`; distribution line `\footnotesize`; verbatim block in `\scriptsize` |
| paragraph shape | onrannual.cls:69,75 (inside class) | `sp.lengths` | `\parindent`=0, `\parskip`=`\baselineskip` (set before `parskip` is loaded) |
| paragraph skip package | onrannual.cls:76 (inside class) | `sp.parskip-pkg` | `\RequirePackage{parskip}`, no options |
| alignment | onrannual.cls:127,160; skeleton.tex:156 | `sp.ragged` | `\raggedright` at begin document; `center` environment for the title block and the figure |
| manual spacing | onrannual.cls:129,133,138,143,155 | `sp.manual-space` | `\vskip` 2\baselineskip, \baselineskip, \baselineskip, 1.5em; `\vspace{7pt}` |
| title and maketitle | skeleton.tex:67,84; onrannual.cls:99-123 | `front.maketitle` | `\title`, `\maketitle`; no `\date` use |
| title block fields | skeleton.tex:62,70,73; onrannual.cls:42-49,124-143 | `front.class-native` | `\distribution` (footnotesize italic, above the title), `\awardnumber` ("Award Number: ..."), `\projecturl` (optional link line) |
| authors and affiliations | skeleton.tex:45-58; onrannual.cls:63,134 | `front.authblk` | `\usepackage[blocks]{authblk}` (inside class); `\author` plus `\affil` per author; `\affilsep`=0 |
| author block layout | onrannual.cls:135-137 | `tbl.tabular` | `tabular[t]{c}` holds the authors |
| title footnotes | onrannual.cls:101-105,130 | `front.thanks` | footnote symbols via `\@fnsymbol`, `\footnote` aliased to `\thanks`; the sample uses no `\thanks` |
| title page break | onrannual.cls:106,126 | `pg.break` | `\newpage` before the title block |
| title page style | onrannual.cls:109 | `hf.pagestyle-kernel` | `\thispagestyle{plain}` |
| headings | onrannual.cls:87-90; skeleton.tex:86 | `head.kernel` | `\section` via `\@startsection{section}{1}{\z@}{-10pt}{7pt}{\normalfont\bfseries\MakeUppercase}` |
| heading case | onrannual.cls:90 | `mark.case` | `\MakeUppercase` in the heading font hook |
| heading numbers | onrannual.cls:66 (inside class) | `num.secnumdepth` | `secnumdepth` = -2 (no numbers) |
| equations | skeleton.tex:135-145 | `math.kernel` | `equation` (default numbering), `\frac` `\overrightarrow` `\mathrm` `\left\right`; no amsmath |
| figure | skeleton.tex:155-162 | `fig.graphicx` | `figure` with `center` and `\includegraphics{samplefigure}` (no extension; both `.pdf` and `.eps` ship) |
| no float at top of title page | onrannual.cls:107 | `fig.placement` | `\global\@topnum\z@` (the `topnumber` counter set to 0 for that page) |
| caption look | onrannual.cls:79-80 (inside class) | `cap.caption` | `\captionsetup{font={bf,it}, justification=centering}` |
| caption command | skeleton.tex:159 | `cap.kernel` | `\caption` with a long text |
| cross references | skeleton.tex:161,164 | `xref.kernel` | `\label{fig:label}`, `Figure~\ref{...}` |
| hyperlinks | onrannual.cls:147; skeleton.tex:18-23,51,58,100 | `meta.hyperref` | `colorlinks=true, pdfborder={0 0 0}, linkcolor=black, citecolor=black, urlcolor=blue, bookmarks=false` (loaded last by the class); `\hypersetup{pdftitle,pdfsubject,pdfauthor,pdfkeywords}`; `\href` |
| URL face | onrannual.cls:163; skeleton.tex:73,102 | `meta.url` | `\urlstyle{rm}` when `url` is loaded; `\url` |
| colour | skeleton.tex:15,185,196,202,209 | `color.color` | `\usepackage{color}`; `\textcolor{blue}{...}` |
| inline marks | skeleton.tex:185; onrannual.cls:128 | `mark.kernel` | `\textbf`, `\textit` |
| verbatim and `\verb` | skeleton.tex:106-112,115-126 | `code.verbatim` | `\verb=...=`, `verbatim` environment in a `\scriptsize` group |
| citations | skeleton.tex:8-9,133 | `bib.natbib` | `\usepackage[round]{natbib}`, `\setlength{\bibhang}{0pt}`, `\citet{Schlichting:2000}` |
| bibliography | skeleton.tex:81,191-192; sample.bib:4-15; onrannual.cls:83 | `bib.bibtex-bst` | `\bibliographystyle{abbrvnat}`, `\bibliography{sample}`, `\nocite{omitifnone}`; heading text `\refname`=REFERENCES |
| bibliography heading | onrannual.cls:153-157 | `head.kernel` | with natbib loaded, `\bibsection` is `\section{\refname...\vspace{7pt}}`, so it looks like any section |

Components the zip does not define or use: abstract, keywords, contents lists, lists, theorem-like statements, tables (apart from the author tabular), code listings, boxes, index, language packages, headers and footers beyond the kernel `plain` style, footnotes in the body.

## Bespoke code
All items sit inside onrannual.cls, which is published (CTAN), so `class.onrannual` carries them. The reductions are recorded in case the class is read as plain preamble code.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\awardnumber` `\projecturl` `\distribution` | onrannual.cls:42-49 | yes | three `\def` string slots that `\@maketitle` prints; `front.class-native` with three strings |
| `\section` redefinition | onrannual.cls:87-90 | yes | one `\@startsection` call with skips -10pt and 7pt and font `\normalfont\bfseries\MakeUppercase`: `head.kernel` (or `head.titlesec`) plus `mark.case` |
| `\subsection` `\subsubsection` error stubs | onrannual.cls:94-95 | yes | no typeset effect; they only forbid the commands, so the emitter never writes them for this class |
| `\maketitle` redefinition | onrannual.cls:99-123 | yes | copy of article's `\maketitle` with symbol footnotes, a `\newpage`, `\thispagestyle{plain}` and the usual global resets; `front.maketitle` with `front.thanks`, `pg.break`, `hf.pagestyle-kernel` |
| `\@maketitle` | onrannual.cls:124-143 | yes | fixed vertical sequence in a `center` environment (distribution line, title, author tabular, award line, URL line, spacing); `front.class-native`, `sp.manual-space`, `tbl.tabular`, `font.size-commands`; no output routine, no counters that drive printing |
| `\AtBeginDocument` block with `\@ifpackageloaded` | onrannual.cls:150-164 | yes | the natbib and url tests are decided by the emitter's own preamble (natbib is loaded in the sample, `url` always comes with hyperref); results are `\bibsection` as a section, `\raggedright`, `\urlstyle{rm}` |
| `\fontsize{12}{14}\selectfont` at class load | onrannual.cls:71-72 | yes | `font.size-commands` as written; whether it survives the `\normalsize` at the start of the document was not worked out from reading |

## Content-opaque
- The Navier-Stokes display equations (skeleton.tex:135-143) are content; they use kernel maths only.
- The included image `samplefigure` (skeleton.tex:157; samplefigure.pdf and samplefigure.eps) is figure artwork, content; it needs no EPS conversion because the PDF version ships.
- The `@misc` entry whose key holds `\textcolor{blue}{\textbf{Omit if none.}}` (sample.bib:4-6) is bibliography data used by `\nocite{omitifnone}` (skeleton.tex:191), content.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
