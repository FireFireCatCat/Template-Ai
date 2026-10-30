yes

# 0248-ruohoruotsi-latex-template-arxiv-preprin: simpleConference (simple two-column paper / technical report template)

- Unverified: read from the source, not compiled.
- Source: Source/0248-ruohoruotsi-latex-template-arxiv-preprin/ (origin: https://codeload.github.com/ruohoruotsi/latex-template-arxiv-preprint/zip/refs/heads/master; licence: MIT)
- Kind: conference
- Lib: v3
- Engine: pdfLaTeX-compatible
- Look carried by: zip-local (simpleConference.sty sets page size, title block, abstract, headings and captions over stock `article`; the preamble adds only `times`)
- Class origin: tex-distribution-unbundled
- Main file: mainTemplatePDF.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
Yes. The look is one 136-line zip-local style (`simpleConference.sty`, a modified copy of IEEE `latex8.sty`; `ctan.org/pkg/simpleconference` is a 404, so it is zip-local, not published) over stock `article[10pt,twocolumn]`. Every redefinition in it (page lengths, `\@maketitle`, the abstract, `\@makecaption`, `\@startsection` headings, two raw TFM fonts) reduces to a composition of lib ways with parameters (`page.setlength`, `front.titling`, `abs.abstract-pkg`, `cap.caption`, `head.kernel`, `font.nfss`), so there is no irreducible code, no `ART` and no tool outside TeX beyond ordinary BibTeX. Residual doubts that do not block the verdict (equivalence of output was not measured, nothing is compiled): the caption one-line test width, `\small` after a raw font switch, and whether TFM files `phvb`/`ptmb` exist in a given TeX tree (sty:18-20 itself says the name may differ per site).

## Blockers
none

## Class setting
- Class: `class.article` options: `10pt`, `twocolumn` (mainTemplatePDF.tex:1). Not bundled in the zip; its source was not read.
- Class-native vocabulary used: `\title` `\author` `\maketitle` `\thispagestyle` (mainTemplatePDF.tex:10-23), `abstract` environment (:25), `\section` (:32), `description` / `enumerate` (:36, :128), `figure` + `\caption` + `\label` (:151-158), `\bibliographystyle` / `\bibliography` (:183-184).

## Component map
Paths: `main` = mainTemplatePDF.tex, `sty` = simpleConference.sty. Where the zip redefines a kernel hook, the Way column names the lib way that realises it and the Bespoke table gives the reduction.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main:1 | `class.article` | `10pt`, `twocolumn` |
| type size | main:1 | `page.class-options` | `10pt` |
| columns | main:1; sty:29 | `cols.twocolumn-option` | class option `twocolumn`; `\columnsep`=0.3125in |
| page geometry | sty:27-28, 30-32, 34-35 | `page.setlength` | `\textheight`=8.875in, `\textwidth`=6.875in, `\topmargin`=0in, `\headheight`=0in, `\headsep`=0in, `\oddsidemargin`=`\evensidemargin`=-.304in |
| paragraph indent | sty:33; main:134,142 | `sp.lengths` | `\parindent`=1pc; `\noindent` per paragraph at main:134,142 |
| page style | main:23; sty:31-32 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` on page 1; later pages keep article's default `plain` (not set in the zip); head height and sep are 0 |
| body font | main:3 | `font.mathptmx` | `\usepackage{times}`, no options |
| caption and subsection fonts | sty:21,24 | `font.nfss` | raw `\font` loads: `phvb` at 10pt (Helvetica bold), `ptmb` scaled 1100 (Times bold 11pt); reduction in Bespoke table |
| size and weight switches | sty:55,59,69,89,127 | `font.size-commands` | `\Large`, `\large`; with kernel `\bf` `\tt` (`mark.kernel`, sty:55,77,89,127) |
| title, author, today | main:10-22 | `front.maketitle` | `\title`, `\author` (rows split with `\\`, `\today` inside the author block, main:12-20), `\maketitle`; no `\date` anywhere, and `\@maketitle` prints none (sty:49-85) |
| title block layout | sty:49-85 | `front.titling` | reduction of the `\@maketitle` override (see Bespoke table) |
| title block tables | sty:61-63, 70-72, 76-78 | `tbl.tabular` | `tabular[t]{c}` for author and affiliation, `tabular{r@{~}l}` for the e-mail line |
| title block spacing | sty:53,57,67,83 | `sp.manual-space` | `\vskip .375in`, `\vspace*{24pt}`, `\vskip .5em`, `\vspace*{12pt}`; `\lineskip .5em` (sty:60, `sp.lengths`) |
| page start | sty:51-52 | `pg.break` | `\newpage` then `\null` at the head of the title block |
| abstract | main:25-29; sty:87-98 | `abs.kernel` | `\begin{abstract}` in the sample; the zip replaces the environment's start and end code (reduction in Bespoke table) |
| centred title line | sty:54,84,89 | `sp.ragged` | `center` environment around the title block; `\centerline{...}` for the abstract name |
| section headings | sty:126-127; main:32 | `head.kernel` | `\@startsection{section}{1}{\z@}{14pt plus 2pt minus 2pt}{14pt plus 2pt minus 2pt}{\large\bf}` |
| subsection headings | sty:128-129 | `head.kernel` | `\@startsection{subsection}{2}{\z@}{13pt plus 2pt minus 2pt}{13pt plus 2pt minus 2pt}{\elvbf}`; not used by the sample |
| heading numbering | none set | `num.secnumdepth` | article defaults kept (nothing in the zip changes counters) |
| lists | main:36-42, 50-53, 64-68, 75-93, 103-106 | `list.kernel` | `description` with `[$\bullet$]` labels, nested twice (main:80-84, 86-91) |
| numbered lists | main:128-133, 136-141 | `list.kernel` | plain `enumerate` |
| inline emphasis | main:57,59 | `mark.kernel` | `\textbf{Guideline n:}` |
| manual breaks | main:60-61 | `sp.manual-space` | two bare `\\` lines |
| figure | main:151-159 | `fig.graphicx` | `figure[!b]`, `\begin{center}`, `\includegraphics[width=3.5in]{figure.pdf}`, `\label{fig-label}` |
| caption | main:156-157; sty:109-123 | `cap.caption` | reduction of the `\@makecaption` override; the sample's `\caption{\small ...}` uses `cap.kernel` |
| cross-reference | main:158,162 | `xref.kernel` | `\label`, `\ref` |
| url and links | main:6,26 | `meta.url` | `\usepackage{url,hyperref}`, `\url{...}` |
| hyperref | main:6 | `meta.hyperref` | no options |
| math symbols | main:5 | `math.amssymb` | `\usepackage{amssymb}`; `$\rightarrow$` at main:174 |
| graphics loader | main:4 | `fig.graphicx` | `\usepackage{graphicx}` |
| bibliography | main:166,183-184; refs.bib:1 | `bib.bibtex-bst` | `abbrv`, database `refs`; `\cite{PtolemyVol1:04}`; the sty comment names `simpleConference.bst` (sty:11) but no `.bst` ships and the sample uses `abbrv` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| raw fonts `\tenhv`, `\elvbf` | sty:21, 24 | yes | `\tenhv` = Helvetica bold 10pt: `font.nfss` (`\fontfamily{phv}\fontseries{b}`, family `phv` is `times`'s `\sfdefault`) with `font.size-commands` 10pt, or `\sffamily\bfseries` (`mark.kernel`). `\elvbf` = Times bold 11pt: `\fontsize{11}{13.6}\selectfont\bfseries`. Caveat: a raw `\font` switch is outside NFSS, so a later `\small` (main:156) falls back to the NFSS text face; the NFSS version keeps the family. Considered, not proposed: the raw `\font` primitive as its own way, because NFSS expresses the same face and size. |
| `\setlength` block | sty:27-35 | yes | `page.setlength` and `sp.lengths` values as in the Component map; or `page.geometry` with the same numbers |
| `\def\@maketitle` | sty:49-85 | yes | `front.titling` hooks, strings only: `\pretitle{\newpage\null\vskip .375in\begin{center}\Large\bfseries}`, `\posttitle{\par\normalfont\normalsize\vspace*{24pt}}`, `\preauthor{\large\lineskip .5em\begin{tabular}[t]{c}}`, `\postauthor{\end{tabular}\par\vskip .5em <affiliation tabular> <e-mail tabular> \vspace*{12pt}\end{center}}`, `\predate{}` `\postdate{}` (no date printed). Ways inside the strings: `pg.break`, `sp.manual-space`, `sp.ragged`, `font.size-commands`, `tbl.tabular`. Unverified: that `titling` keeps the `\twocolumn[...]` wrapper of article's `\maketitle`. |
| `\affiliation`, `\email`, `\ifx \@empty \@email` | sty:100-103, 74-80 | yes | field stores and a print-if-set test; the sample sets neither (main:12-20). An emitter knows at emit time whether an e-mail exists and prints or omits the tabular; the empty affiliation tabular (sty:70-72) is an empty `tabular[t]{c}` line. |
| `\def\abstract`, `\def\endabstract` | sty:87-98 | yes | `abs.abstract-pkg`: name font `\large\bfseries`, name centred, 12pt after the name, zero side indents; 12pt after the text through `sp.manual-space` (parameter names of that package not re-read). Or a printed wrapper: `\centerline{\large\bf Abstract}\vspace*{12pt}` before the node and `\vspace*{12pt}` after (`sp.ragged`, `font.size-commands`, `mark.kernel`, `sp.manual-space`). |
| lengths `\@ctmp`, `\@figindent` | sty:105-107 | yes | `\@figindent`=1pc is the caption `margin` value; `\@ctmp` is scratch for the width test |
| `\long\def\@makecaption` | sty:109-123 | yes | `cap.caption`: `\captionsetup{font={sf,bf,normalsize}, labelsep=period, margin=1pc, skip=10pt, singlelinecheck=true, format=plain}`: label and text in Helvetica bold 10pt, 10pt above the caption and none below (sty:110), one-line captions centred (sty:122), longer ones set as a paragraph with 1pc side margins (sty:117-118). The box-width test (sty:111-115) is the one-line check the kernel `\@makecaption` and `caption` both implement. Unverified: whether the package's one-line width equals `\hsize` minus 2pc (parameter difference, not a missing way). |
| `\def\section`, `\def\subsection` | sty:126-129 | yes | `head.kernel` (documented `\@startsection` arguments, values in the Component map); equal in `head.titlesec`: `\titleformat{\section}{\large\bfseries}{\thesection}{1em}{}` and `\titlespacing{\section}{0pt}{14pt plus 2pt minus 2pt}{14pt plus 2pt minus 2pt}`. Positive before-skip keeps the first paragraph after a heading indented. |
| `\Section`, `\SubSection` | sty:132-133 | yes | unused by the sample; wrappers that add a period after the number with `\hskip -1em`. The same label is a `head.titlesec` `\titleformat` label `\thesection.`. |
| `\font` memento and usage comments | sty:2-17, 37-47 | yes | comments only |

## Content-opaque
- `figure.pdf` included at mainTemplatePDF.tex:153 (a one-page PDF, 3.5in wide), shipped in the zip: figure artwork, content.
- `refs.bib:1` holds one `@techreport` entry: bibliographic content.
- `mainTemplatePDF.pdf` is a compiled copy of the sample (output, not source); not used as evidence.

## Lib changes
- New ways proposed: none. (Considered: the raw `\font` primitive as `font.*`; not proposed, see Bespoke table row 1.)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
