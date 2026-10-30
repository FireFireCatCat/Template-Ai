yes

# 0070-ntgclass: NTG document classes (rapport3 sample, `rapdoc.tex`)

- Unverified: read from the source, not compiled.
- Source: Source/0070-ntgclass/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ntgclass.zip; licence: lppl1.3, LPPL 1.3c per README:16-21)
- Kind: report (the manifest hint "letter" is the `brief` class in the same bundle; the main sample is a Dutch report documenting the `rapport` classes)
- Lib: v1
- Engine: pdfLaTeX-compatible (babel `dutch`, default Computer Modern; no fontspec, no shell escape)
- Look carried by: class (the sample adds only `babel` and content; every visual decision is `rapport3` design 3, option `oldtoc`)
- Class origin: ctan (the zip is the CTAN `ntgclass` bundle; no `.cls` is shipped, `ntgclass.ins:84-94` generates `rapport3.cls` from `ntgclass.dtx`)
- Main file: rapdoc.tex (other samples: brief-sample.tex, artdoc.tex, briefdoc.tex, classdoc.tex)
- Read: main yes, zip-local classes and styles all (no `.cls`/`.sty` present; code lines of `ntgclass.dtx`, `brief.dtx`, `a4.dtx` read, documentation prose not; `artdoc.tex` and `briefdoc.tex` only skimmed)

## Verdict
yes. The main sample loads the published CTAN class `rapport3` with three options plus `babel[dutch]`, defines no macro, counter or environment of its own (the `\def`s at rapdoc.tex:333 and :430 sit inside `verbatim` blocks and are printed text), and its body uses only kernel constructs. An emitter writes `\documentclass[oldtoc,a4paper,10pt]{rapport3}`, `\usepackage[dutch]{babel}` and kernel body commands. The class internals (`\@sect`, `\@makecaption`, `\@makefntext`, `\l@chapter`, a `unitindent` written to `.aux`) would be irreducible if the class were zip-local; they are not counted as bespoke because the class is a CTAN release (W1) chosen by options only (W2).

## Blockers
none

## Class setting
- Class: `class.rapport3` options: `oldtoc`, `a4paper`, `10pt` (rapdoc.tex:1). Class defaults not overridden: `oneside`, `onecolumn`, `final`, `uctitle`, `openany` (ntgclass.dtx:525-527), titlepage on for report-type classes (ntgclass.dtx:255). Other options the class declares and the sample does not use: `twoside`, `twocolumn`, `openright`, `voorwerk`/`geenvoorwerk`, `titlecentered`, `mctitle`, `leqno`, `fleqn`, `openbib`, `11pt`, `12pt` (ntgclass.dtx:335-513).
- Class-native vocabulary used: `\part`, `\chapter`, `\section`..`\paragraph`, `\maketitle` (titlepage form), `abstract` (own page), `\tableofcontents`, `\listoftables`, `\listoffigures`, `thebibliography`; option `oldtoc`. Defined by the class, not exercised by the main sample: `\HeadingFonts`, `\RunningFonts`, `\CaptionFonts`, `\TitleFont` `\PartFont` `\ChapFont` `\SectFont` `\SSectFont` `\SSSectFont` `\ParaFont` `\SParaFont` (ntgclass.dtx:1854-1865, 1899, 2667, 2919, 3034-3174, 4233-4246), `\appendix` (3870), `theindex` (5072), `\pagestyle{headings|myheadings}` (1715-1844), kernel-style theorem look (3778-3786).
- Other classes in the same bundle, from the secondary samples (not in the component table, they do not change the verdict): `class.artikel1` (artdoc.tex:1, briefdoc.tex:1, classdoc.tex:1; options `a4paper`, `10pt`; `babel[dutch]`); `class.brief` (brief-sample.tex:1; brief.dtx), whose native vocabulary is `\maakbriefhoofd`, `\antwoordadres`, `\uwbriefvan`, `\datum`, `\onskenmerk`, `\voetitem`, environment `brief{address}`, `\betreft`, `\opening`, `\ondertekening`, `\afsluiting[width]`, `\bijlagen`, `\cc`, `\ps`, options `adresrechts` `streepjes` `typhulp` and language options `dutch|english|american|german|french` (brief.dtx:323-376, 1159-1848, 2588-2700). It is a CTAN class chosen by options and called through those commands, so it would map to `class.brief` plus `ltr.opening`, with the same reasoning. `class.artikel2`, `class.artikel3`, `class.boek`, `class.boek3`, `class.rapport1` are generated from the same `ntgclass.dtx` (ntgclass.ins:84-94). The `a4` package (a4.dtx) is not loaded by any sample.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | rapdoc.tex:1; ntgclass.dtx:50, 525-527, 542, 547 | `class.rapport3` | oldtoc, a4paper, 10pt; design 3 = flush-left headings, `\parindent=0`, `\parskip=.5\baselineskip plus .1 minus .1` (ntgclass.dtx:892-896); `\unitindent` = width of "2.2.2" + .5em (804-812), grown at each heading and written to `.aux` (833-871); `\frenchspacing` (5405); `\em` is slanted (4344-4350) |
| paper, size, text block | rapdoc.tex:1; ntgclass.dtx:335-337, 377, 610-612, 1026-1080, 1117-1148, 1231-1322 | `page.class-options` | a4paper (210x297mm), 10pt (`\normalsize` 10/12), textwidth min(paper-2in, 361pt), textheight a whole number of baselines, margins centred; no `geometry` |
| language | rapdoc.tex:2 (shorthand `"i` at :20, :164, :315, :344, :587) | `lang.babel` | dutch; replaces the class's English names (ntgclass.dtx:5271-5312) |
| title block | rapdoc.tex:6-10; ntgclass.dtx:1916-2007 | `front.maketitle` | `\date`, `\title` (with `\\` and `$x$`), `\author` set after `\begin{document}`, then `\maketitle`; class look: `titlepage` page, `\TitleFont`=`\rmfamily`, title `\LARGE`, author `\large` in a centred tabular, date `\large`, all three upper case by `uctitle` (1917-1973) |
| abstract | rapdoc.tex:12-26; ntgclass.dtx:3652-3660 | `abs.kernel` | `abstract` environment, set on its own page by the class (heading `\SectFont \abstractname`, bold); holds an `enumerate` and a `\footnote` |
| contents and lists of floats | rapdoc.tex:28-30; ntgclass.dtx:4438-4476, 4551-4552, 4630-4631, 4731-4770, 4836-4869, 4888-4949 | `toc.kernel` | `\tableofcontents`, `\listoftables`, `\listoffigures`; `oldtoc` selects the dotted-leader layout (`\@dottedtocline`, bold chapter lines); tocdepth 2 (4422); each opens with `\chapter*` |
| sectioning commands | rapdoc.tex:32, 34, 52, 135, 161, 499 | `head.kernel` | `\part`, `\chapter`, `\section`, `\subsection`, `\subsubsection`, `\paragraph`; counters and `secnumdepth`=2 (ntgclass.dtx:2464, 2482-2539) |
| heading look | ntgclass.dtx:2298-2301, 2316-2398, 2632-2656, 2725-2764, 2850-2865, 2933-2961, 3017-3144 | `head.class-native` | section `\large\SectFont` (bold), subsection bold, subsubsection `\slshape`, paragraph `\slshape` run-in; space before -2/-1/-1 `\baselineskip` flex, after .01`\baselineskip` (design 3); numbers in a `\unitindent` box, ragged, no hyphenation (`\head@style`); chapter: 50pt drop, "Chapter N" `\Large` bold on its own line, title `\Large` bold, 40pt after, plain page style; part: own page, centred, upper case, page style empty |
| page number | ntgclass.dtx:1689-1705, 5367; rapdoc.tex:1 | `hf.class-native` | default `\pagestyle{plain}` unchanged: no header, number at the right of the foot (oneside), `\PageFont`=`\rmfamily` |
| lists | rapdoc.tex:16, 58, 297, 303, 551, 564, 630 | `list.kernel` | `enumerate`, `itemize` (itemize nested in enumerate at :297-308); class: `\leftmargin=\unitindent`, `\labelsep=.5em`, labels left-aligned (`makelabel` `##1\hfil`), `\topsep=-.5\parskip plus 1pt`, `\itemsep=0 plus 1pt` (ntgclass.dtx:3280-3290, 3428-3458, 3514-3543) |
| quotation | rapdoc.tex:471-480 | `quote.kernel` | `quotation`; class: `\listparindent=0`, `\itemindent=\listparindent`, `\rightmargin=\leftmargin` (ntgclass.dtx:3739-3748) |
| text marks | rapdoc.tex:118, 174, 286 | `mark.kernel` | `\emph`, `\texttt`; `\emph` prints slanted not italic (ntgclass.dtx:4344-4350) |
| footnotes | rapdoc.tex:23-25, 84-86, 115-116, 365-374, 654-657 | `fn.kernel` | `\footnote`; class: reset per chapter (ntgclass.dtx:5166), rule `\unitindent` wide (5146-5152), mark in a half-`\unitindent` box (5224-5234), `\footnotesize` 8/9.5 (697) |
| inline maths | rapdoc.tex:7, 13 | `math.kernel` | `$x$` only; no display maths in the sample |
| table float | rapdoc.tex:170-184, 220-225 | `tbl.tabular` | `table[h]` with `center` and `tabular{|l|r|r|}` plus `\hline` (170-181); `tabular{ll}` inside a `figure` (220-225); header cells `\emph`; the `table` float wrapper is kernel (ntgclass.dtx:4157-4162) |
| figure float | rapdoc.tex:218-228 | `fig.graphicx` | kernel `figure`, default placement `tbp` (ntgclass.dtx:4084), numbered per chapter (4069-4072); holds a tabular, no `\includegraphics` and no `graphicx` loaded |
| captions | rapdoc.tex:182-183, 227 | `cap.kernel` | `\caption` below the body; class `\@makecaption`: "Label: text", centred when it fits one line, else a paragraph; `\abovecaptionskip`=10pt (ntgclass.dtx:4182-4224) |
| verbatim and inline code | rapdoc.tex:233-235, 332-336, 379-382, 385-387, 389-395, 422-424, 429-431, 524-526; `\verb` at :63, :136, :163 | `code.verbatim` | `verbatim` environment, `\verb` with `.` and `+` delimiters; class `\topsep=-.5\parskip` (ntgclass.dtx:3620-3632) |
| bibliography | rapdoc.tex:645-667; `\cite` at :43-48 | `bib.thebibliography` | `thebibliography{9}` with five `\bibitem`; class heading via `\chapter*{\bibname}` (ntgclass.dtx:4999-5020) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| none defined by the sample | rapdoc.tex:1-674 | n/a | no `\newcommand`, `\def`, environment or counter outside `verbatim`; `\def\@listi` (:333) and `\def\headstyle` (:430) are verbatim text |
| `rapport3` internals (`\@sect`, `\@makecaption`, `\@makefntext`, `\l@chapter`, `\@regtocline`, `\unitindent` written to `.aux`) | ntgclass.dtx:2316, 4197, 5224, 4731, 4513, 855-871 | not counted: published class | CTAN release (W1), chosen by options (W2), emitted as one `\documentclass` line (W4); would be BESPOKE/class if the class were zip-local |

## Content-opaque
none (the `figure` at rapdoc.tex:218-228 holds a tabular of text; the `verbatim` blocks hold printed LaTeX source, which is code content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
