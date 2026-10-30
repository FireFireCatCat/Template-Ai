yes

# 0539-ucbthesis: UC Berkeley thesis class (ucbthesis 3.6)

- Unverified: read from the source, not compiled.
- Source: Source/0539-ucbthesis/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ucbthesis.zip; licence: lppl1.3)
- Kind: thesis
- Lib: v4
- Engine: pdfLaTeX-compatible (the manual's build line is `pdflatex thesis`, `biber thesis`: ucbthesis.tex:106-110; memoir, biblatex, rotating all run under pdfTeX)
- Look carried by: class (the page block, spacing, page styles and all front-matter pages are in `ucbthesis.cls`, a memoir-based CTAN class; the sample preamble adds only biblatex, rotating, one caption length and one theorem: thesis.tex:8-9,23,25)
- Class origin: ctan (ctan.org/pkg/ucbthesis read: v3.6, LPPL 1.3, in TeX Live; the manual says "modified for release on CTAN", ucbthesis.tex:395)
- Main file: thesis.tex (other samples: ucbthesis.tex, the class manual, an `article` document; abstract.tex, chap1.tex, chap2.tex are `\include`d parts of thesis.tex)
- Read: main yes, zip-local classes and styles all (ucbthesis.cls read in full, lines 1-718; the `memoir` class it loads ships with the TeX distribution and its source was not read)

## Verdict
Yes. The look is carried by the published `ucbthesis` class (CTAN, TeX Live, LPPL 1.3), so it is one class way, `class.ucbthesis`, whose native vocabulary (`\degree`, `\chair`, `\maketitle`, `\approvalpage`, `\copyrightpage`, `abstract`, `frontmatter`, `acknowledgements`) is recorded below; the class itself loads `memoir` and adds no package. The sample preamble and body use only kernel and published constructs (biblatex, rotating, `\newtheorem`, tabular, figure floats). The `picture` drawings inside figures are float content, not template artwork. There is no zip-local unpublished macro logic, no `ART`, and no tool outside TeX beyond `biber`, which the lib already holds as `bib.biblatex-biber`. This is evidence about the class dimension (a published class carries the look), not about the component ways.

## Blockers
none

## Class setting
- Class: `class.ucbthesis` options: none in the sample (thesis.tex:7). Declared options are `phd` (default), `masters`, `oldmasters` (ucbthesis.cls:139-143), `oneside` (default) and `twoside` (153-157, 203-206), point sizes `9pt` to `60pt` and `*pt` (default `12pt`: 162-188, 208-211); every other option, `draft` included, is forwarded to memoir (192). The class then does `\LoadClass{memoir}` (215), so `class.memoir` is the base class (memoir's `\SingleSpacing`, `\setSpacing`, `\aliaspagestyle`, `\setlrmarginsandblock`, `\ifdraftdoc` are used by the class).
- Class-native vocabulary used: declarations `\degreesemester` `\degreeyear` `\degree` `\chair` `\othermembers` `\numberofmembers` `\field` (thesis.tex:38-52; defined at ucbthesis.cls:328-363); optional and commented out in the sample: `\cochair` `\cochairs` `\prevdegrees` `\emphasis` `\jointinstitution` `\campus` (thesis.tex:45-58); page commands `\maketitle` `\approvalpage` `\copyrightpage` (thesis.tex:65-68); environments `abstract` (abstract.tex:3), `frontmatter` (thesis.tex:72), `dedication` (74), `acknowledgements` (96); string `\acknowledgename` (ucbthesis.cls:315). Class helpers not used by the sample: `\ssp` `\dsp` (255-256), `alwayssingle` (372-374).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | thesis.tex:7 | `class.ucbthesis` | no options; defaults phd, oneside, 12pt (ucbthesis.cls:143,203-211) |
| base class | ucbthesis.cls:215 | `class.memoir` | `\LoadClass{memoir}`; oneside and 12pt are forced as defaults through `\PassOptionsToClass` (204,209); source not read |
| paper and size options | ucbthesis.cls:153-188,203-211 | `page.class-options` | `oneside`, `12pt` (any of 9pt..60pt, `*pt`) |
| page geometry | ucbthesis.cls:217-222 | `page.memoir-layout` | `\setlrmarginsandblock{1in}{*}{*}`; `\setulmarginsandblock{1in+25pt+\normalbaselineskip}{.75in+30pt}{*}`; `\checkandfixthelayout` at begin document |
| page style, all pages | ucbthesis.cls:227-231 | `hf.memoir-pagestyle` | `\pagestyle{simple}`; `\aliaspagestyle{book,part,chapter,title}{simple}`; page number top right (ucbthesis.tex:79) |
| page style, body | thesis.tex:111 | `hf.pagestyle-kernel` | `\pagestyle{headings}` after the front matter |
| page style, front pages | ucbthesis.cls:401,465,510,532 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` on title, approval, copyright; `simple` on the abstract |
| line spacing | ucbthesis.cls:255-256,263-273,277-281 | `sp.setspace` | memoir `\SingleSpacing`, `\setSpacing{1.37}` (only for `oldmasters`, not draft); contents and lists wrapped in `SingleSpace`; the sample stays single-spaced (thesis.tex:16-17 commented out) |
| front-page type size | ucbthesis.cls:380-381 | `font.size-commands` | `\fontsize{12}{14.5}\selectfont`; `\fontsize{12}{14pt}\selectfont` |
| title and author | thesis.tex:36-37 | `front.maketitle` | `\title`, `\author` (read back by the class pages) |
| degree and committee declarations | thesis.tex:38-52; ucbthesis.cls:328-363 | `front.class-native` | `\degreesemester{Spring}` `\degreeyear{1995}` `\degree{Doctor of Philosophy}` `\chair` `\othermembers{..\\..}` `\numberofmembers{3}` `\field{Mathematics}` |
| title page | thesis.tex:65; ucbthesis.cls:383-447 | `front.class-native` | `\maketitle`: centred block at 12/14.5pt, vertically centred, fixed English text, variants for `\jointinstitution` `\emphasis` `\cochair` |
| approval page | thesis.tex:67; ucbthesis.cls:457-500 | `front.class-native` | `\approvalpage`: one signature line per `\numberofmembers` (3 to 6), `\@dissertation` word from `masters` |
| copyright page | thesis.tex:68; ucbthesis.cls:508-519 | `front.class-native` | `\copyrightpage`: title, "Copyright" year, author, `\vspace{1in}` |
| abstract | abstract.tex:3-12; thesis.tex:70; ucbthesis.cls:529-555 | `abs.class-native` | `abstract` environment: centred heading block (title, "by" author, degree in field, campus, chair), `\setcounter{page}{1}`, `\parindent` 0pt, `\parskip` `\baselineskip` then `.6\baselineskip` |
| front matter page numbers | thesis.tex:72,109; ucbthesis.cls:598-600 | `pgnum.pagenumbering` | `frontmatter` environment: page reset to 1, lower roman; on exit `\newpage`, arabic, page 1 |
| front matter page numbers (counter) | ucbthesis.cls:599-600 | `num.counters` | `\renewcommand{\thepage}{\roman{page}}`, then `\arabic{page}` |
| dedication | thesis.tex:74-85; ucbthesis.cls:574-576 | `front.dedication` | environment: own page (`alwayssingle`); text laid by hand |
| dedication layout | thesis.tex:75-84 | `sp.manual-space` | `\null\vfil`, `\vspace{12pt}`, `\vfil\null`; `center` environment is `sp.ragged` |
| contents lists | thesis.tex:90-94; ucbthesis.cls:263-273 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables`, each wrapped in `SingleSpace` by the class |
| page breaks | thesis.tex:91,93 | `pg.break` | `\clearpage` between the lists |
| acknowledgements | thesis.tex:96-107; ucbthesis.cls:315,583-589 | `front.dedication` | environment: own page, centred `\large\bfseries` `\acknowledgename` ("Acknowledgments") |
| file inclusion | thesis.tex:70,115,116 | `struct.input` | `\include{abstract}`, `\include{chap1}`, `\include{chap2}` |
| headings | chap1.tex:1,3,20; chap2.tex:1,3,46,55 | `head.kernel` | `\chapter` `\section` `\subsection`, memoir default look (the class sets no `\chapterstyle` or section style: grep of ucbthesis.cls) |
| footnote | chap1.tex:11 | `fn.kernel` | `\footnote` (memoir look; the class only touches footnote size and rule on the title page, ucbthesis.cls:399-400) |
| quote | chap1.tex:25-33 | `quote.kernel` | `quote` environment (the class replaces it only for `oldmasters`, ucbthesis.cls:605-661) |
| list | chap1.tex:141-159 | `list.kernel` | `itemize` |
| theorem | thesis.tex:25; chap1.tex:43-47,170-175 | `thm.kernel` | `\newtheorem{theorem}{Jibberish}` |
| theorem line breaking | chap1.tex:44,171 | `sp.hyphenat` | `\tolerance=10000\hbadness=10000` inside the environment (raw parameters behind `\sloppy`; `\hbadness` only silences warnings; nearest way, a stretch noted) |
| hyphenation exceptions | thesis.tex:29-30 | `sp.hyphenat` | `\hyphenation{mar-gin-al-ia}`, `\hyphenation{bra-va-do}` |
| tables | chap1.tex:57-69,76-92 | `tbl.tabular` | `table`, `\centering`, `tabular` with `{|c|c|c|}` and `{|ccccc|}`, `\hline`; header cells `\textbf` (`mark.kernel`) |
| sideways table | thesis.tex:9; chap1.tex:123-139 | `fig.rotating` | `\usepackage{rotating}`, `sidewaystable` |
| figures | chap1.tex:98-112; chap2.tex:11-35 | `fig.graphicx` | `figure` float, no `\includegraphics`; chap2 puts two `\parbox{.4\textwidth}` side by side, each with its own `\caption`, joined by `\hfill` |
| figure side by side | chap2.tex:12,23,24 | `box.minipage` | `\parbox{.4\textwidth}{\centering ...}` twice; `\hfill` is `sp.manual-space` |
| captions | chap1.tex:68,91,109,138; chap2.tex:22,34 | `cap.kernel` | `\caption`; thesis.tex:23 `\addtolength{\abovecaptionskip}{\baselineskip}` (length of the caption mechanism; memoir source not read) |
| figure artwork | chap1.tex:99-108; chap2.tex:13-21,25-33 | `art.pstricks` | `picture` environment inside floats: content, see below |
| citations | chap1.tex:8,96,119,164 | `bib.biblatex-biber` | `\cite{..}`, `\cite[page 45]{waveshaping}` |
| bibliography | thesis.tex:8,27,118 | `bib.biblatex-biber` | `\usepackage{biblatex}` with no options (default backend biber), `\bibliography{references}`, `\printbibliography`; thesis.tex:11 allows `bibtex` instead (`bib.biblatex-bibtex` then) |
| doc sample: class | ucbthesis.tex:1 | `class.article` | `11pt` |
| doc sample: headings | ucbthesis.tex:2 | `head.titlesec` | option `sf` only, no `\titleformat` |
| doc sample: hyperref | ucbthesis.tex:3,11,40 | `meta.hyperref` | `colorlinks=true`; `\href`, `\url` |
| doc sample: breakurl | ucbthesis.tex:4 | `meta.url` | load-only, `\burl` never called; ctan.org/pkg/breakurl read: it serves the dvips route, pdfTeX effect not established (a breakable-URL package, as `xurl`) |
| doc sample: listings | ucbthesis.tex:5,14-24,106-110,132-134,140-142 | `code.listings` | `\lstset` `basicstyle=\ttfamily\small`, `commentstyle=\itshape\ttfamily\small`, `showspaces=false`, `showstringspaces=false`, `breaklines`, `breakautoindent`, `frame=single`, `captionpos=t`, `language=TeX`; `lstlisting`, `\lstinline` |
| doc sample: verbatim | ucbthesis.tex:362-371 | `code.verbatim` | `verbatim`, `\verb` |
| doc sample: tables | ucbthesis.tex:6,144-169,229-267,332-345 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| doc sample: tabularx | ucbthesis.tex:7,146,232 | `tbl.tabularx` | `tabularx{.8\textwidth}{>{\ttfamily}lX}`, `\multicolumn` |
| doc sample: title block | ucbthesis.tex:9-12,29 | `front.maketitle` | `\title`, `\author` with `\\` lines, `\date{Version 3.6\\...}`; `\thispagestyle{empty}` (30) is `hf.pagestyle-kernel` |
| doc sample: abstract | ucbthesis.tex:31-42 | `abs.kernel` | `\renewcommand{\abstractname}{\sffamily Abstract}`; `\abstract{...}` is called as a command, not an environment |
| doc sample: lists | ucbthesis.tex:66-83,214-219 | `list.kernel` | `enumerate`, `itemize` |
| doc sample: references | ucbthesis.tex:138,144,168 | `xref.kernel` | `\label`, `\ref` |

## Bespoke code
Everything below sits in `ucbthesis.cls`, which is published (CTAN, TeX Live), so it is covered by `class.ucbthesis` and is not zip-local bespoke code under W1. The reductions are written down in case the class way were ever refused: each is a closed template or kernel composition, none is typesetting logic beyond the lib.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option parser and defaults | ucbthesis.cls:139-211 | yes | `\ExecuteOptions` and `\PassOptionsToClass` only: class options of `class.memoir` (`oneside`, `12pt`) plus `\@masters` as a switch |
| `\maketitle` | ucbthesis.cls:383-447 | yes | `center` of fixed text with `\ifdefined` choosing text variants (optional declarations); vertical centring is length arithmetic fed to `\vspace` (`sp.manual-space`) between `\vfill`s, `\hrule height 0pt` (`sp.rule`); for fixed geometry the length is a constant |
| `\approvalpage` | ucbthesis.cls:457-500 | yes | rows of `\hbox to\textwidth` with `\leaders\hrule` (`sp.rule`, rule-only leaders), `\raise 3pt` (`sp.manual-space`), `\baselineskip=36pt`; row count is `\numberofmembers` (3 to 6) |
| `\copyrightpage` | ucbthesis.cls:508-519 | yes | `center`, `\vspace{1in}`, fixed text |
| `abstract` environment | ucbthesis.cls:529-555 | yes | heading block plus `\setcounter{page}{1}`, `\setlength{\parindent}`, `\setlength{\parskip}` (`sp.lengths`) |
| `frontmatter` environment | ucbthesis.cls:598-600 | yes | `\pagenumbering{roman}`, then `\newpage\pagenumbering{arabic}` |
| `alwayssingle` | ucbthesis.cls:372-374 | yes | `\newpage`, or `\onecolumn` and `\twocolumn` (`cols.twocolumn-cmd`) when the class is two-column; `\if@twocolumn` is a kernel switch |
| `dedication`, `acknowledgements` | ucbthesis.cls:574-589 | yes | `alwayssingle` plus a centred `\large\bfseries` heading string |
| contents wrappers | ucbthesis.cls:263-273 | yes | `\SingleSpacing` around `\tableofcontents`, `\listoffigures`, `\listoftables` |
| `\ssp` `\dsp` `\fmfont` `\fmsmallfont` | ucbthesis.cls:255-256,380-381 | yes | aliases of `\SingleSpacing`, `\setSpacing{1.37}`, `\fontsize` calls |
| `oldmasters` copies of `quote`, `quotation`, `verse` | ucbthesis.cls:605-691 | yes | memoir's list-based definitions with `\SingleSpacing` added; unused by the sample (phd) |
| `\pkg` | ucbthesis.tex:26 | yes | `\newcommand*{\pkg}[1]{\texttt{#1}}`, an alias of `\texttt` (`mark.kernel`) |

## Content-opaque
- `picture` drawings inside figures (circle, vector, oval, `framebox`): chap1.tex:99-108, chap2.tex:13-21, chap2.tex:25-33 (content of a float, not template artwork).
- Filler text of the sample (chap1.tex, chap2.tex, abstract.tex:10) and the bibliography entries (references.bib) are content.

## Lib changes
- New ways proposed: none. Considered: `breakurl` (placed under `meta.url`), raw `\tolerance` and `\hbadness` (placed under `sp.hyphenat`, the nearest way; the stretch is noted in the map).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
