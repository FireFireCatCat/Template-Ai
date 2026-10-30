yes

# 0535-iscram: ISCRAM conference paper class and its documentation sample

- Unverified: read from the source, not compiled.
- Source: Source/0535-iscram/ (origin: https://mirrors.ctan.org/macros/latex/contrib/iscram.zip; licence: lppl1.3 per manifest, the files' own headers offer LPPL and/or GPL, iscram.cls:1-6 and README)
- Kind: conference
- Lib: v4
- Engine: pdfLaTeX-compatible (newtxtext/newtxmath, biblatex with biber, tikz and tikzpagenodes all run under pdfTeX; no fontspec or Lua; the figure asset HMI.pdf is a PDF, which pdfTeX includes)
- Look carried by: mixed (iscram.cls carries page, fonts, headings, running head and footer, title block, abstract and bibliography; the sample's preamble adds only the documentation's own listings styles, option list, boxes and inline macros)
- Class origin: ctan (ctan.org/pkg/iscram: "LaTeX class", Paul Gaborit, v1.1, LPPL 1.3, also in TeX Live and MiKTeX; the zip is the CTAN package)
- Main file: iscram-class-doc.tex (other samples: none; iscram-class-doc.pdf is the shipped compiled output, HMI.pdf the figure asset, iscram-class-doc.bib the data)
- Read: main yes, zip-local classes and styles all (iscram.cls, 270 of 270 lines)

## Verdict
Yes. The look is carried by the published CTAN class `iscram` (`\documentclass{iscram}` plus `\iscramset{...}` key values: strings and booleans), so an emitter writes one class line and one key block. Every preamble addition in the sample is a composition of published packages (listings, enumitem, tcolorbox, xcolor, multicol, siunitx) or an alias that reduces by inline expansion. One judgment call: `\iscramshowframe` is a TikZ overlay that annotates the page margins; it is defined only in the sample, never in the class, and illustrates the document, so it is recorded as Content-opaque and not ART (a stricter reading would call it ART/body and turn this into no).

## Blockers
none

## Class setting
- Class: `class.iscram` options: none in the sample (`\documentclass[]{iscram}`, iscram-class-doc.tex:10); the class fixes `10pt,a4paper` and `\LoadClass{article}` (iscram.cls:98-100). Its own options are pgfkeys values set by `\iscramset` (iscram.cls:19-57): booleans `anonymous` `firstalone` `draft`, strings `title` `short title` `footer/line 1..3`, repeatable `author={short name, full name, affiliation}`, and presets `iscram 2017 footer` `WiPe Paper 2017` `CoRe Paper 2017` and the 2018 equivalents (iscram.cls:60-93).
- Class-native vocabulary used: `\iscramset{title, short title, author}` (iscram-class-doc.tex:90-116), `\maketitle` (165), `\abstract{...}` as a one-argument command (171), `\keywords{...}` (204), `\section` `\subsection` `\subsubsection`, `\printbibliography[heading=bibliography]` (666) with the class's `bibliography` heading, `\thanks` inside title and author values (102, 105). The sample also prints the class's own `\iscram@version` and `\iscram@date` (168).

## Component map
Rows marked (class) are set inside iscram.cls and come with `class.iscram`; the way named is the published package or command the class uses, so the same table reads as a decomposition of the class.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | iscram-class-doc.tex:10; iscram.cls:12,100 | `class.iscram` | no class options; `iscramset` keys title, short title, 2 authors |
| paper and size (class) | iscram.cls:98-99 | `page.class-options` | `10pt`, `a4paper`, `draft` or `final` from the `draft` key |
| page geometry (class) | iscram.cls:103-107 | `page.geometry` | a4paper, margin=1in, headheight=10bp, headsep=.5in-10bp, footskip=1in-1cm, marginparsep=3mm, marginparwidth=1in-6mm |
| microtype (class) | iscram.cls:108 | `sp.microtype` | defaults |
| text and math font (class) | iscram.cls:112-113 | `font.newtx` | newtxtext, newtxmath; the sample's doc text names TeX Gyre Termes and Heros (iscram-class-doc.tex:523-525) |
| input encoding | iscram-class-doc.tex:12 | `font.fontenc-t1` | inputenc utf8 |
| heading numbering (class) | iscram.cls:118 | `num.secnumdepth` | secnumdepth=0 (no numbers) |
| section headings (class) | iscram.cls:116,120-127 | `head.titlesec` | `\titleformat` block, empty label; section: `\sffamily\bfseries` 10bp/12bp uppercase; subsection: sf bold 10bp/12bp; subsubsection: sf italic 10bp/12bp; `\titlespacing` 0pt, before `*2` `*2` `*1`, after `*.3` |
| uppercase section titles (class) | iscram.cls:121 | `mark.case` | `\MakeUppercase` in the section format |
| heading fonts (class) | iscram.cls:121-127 | `font.size-commands` | `\fontsize{10bp}{12bp}\selectfont` |
| running head (class) | iscram.cls:130-142,152 | `hf.class-native` | left: italic 9bp/11bp first author short name plus "et al." or "Anonymous version"; right: short title or title; built with `hf.titleps` commands `\sethead*` |
| footer (class) | iscram.cls:143-153 | `hf.class-native` | three centred italic `\small` lines in `\parbox[b][0bp][b]`, strings from `footer/line 1..3`; built with `hf.titleps` `\setfoot*` |
| page styles (class) | iscram.cls:116,155-158 | `hf.titleps` | titlesec option `pagestyles`: `\newpagestyle{iscram}`, `\renewpagestyle{plain}`; activated by `\pagestyle{iscram}` as `hf.pagestyle-kernel` |
| paragraph shape (class) | iscram.cls:162-163 | `sp.lengths` | parindent=0pt, parskip=.5\baselineskip plus .3\baselineskip minus .2\baselineskip |
| full pages (class) | iscram.cls:262 | `pg.flush` | `\flushbottom` |
| widow and club (class) | iscram.cls:255 | `sp.penalties` | `nowidow` with option `all` |
| title block (class) | iscram.cls:166-177; iscram-class-doc.tex:165 | `front.class-native` | `\title` stores the text; `\@maketitle`: title centred sf bold 26.666bp/28bp, `\vspace*` 28bp, authors 20.666bp/22bp |
| author boxes (class) | iscram.cls:203-252 | `front.class-native` | two `minipage[t]{.48\linewidth}` per row (`box.minipage`, `sp.manual-space` `\hfill`), name 16bp bold, affiliation 12bp, `\vspace{3mm}`; `anonymous` and `firstalone` booleans |
| author notes | iscram-class-doc.tex:102,105 | `front.thanks` | `\thanks` in full name and affiliation values |
| version line | iscram-class-doc.tex:167-169 | `sp.ragged` | `\centering\large` over the class's two string macros (reducible, see Bespoke) |
| abstract (class) | iscram.cls:258; iscram-class-doc.tex:171-200 | `abs.class-native` | `\abstract{text}` = `\section{Abstract}` then the text |
| keywords (class) | iscram.cls:259; iscram-class-doc.tex:204 | `abs.keywords` | `\keywords{text}` = `\subsection{Keywords}` |
| number printing | iscram-class-doc.tex:182-187 | `mark.siunitx` | pgf `\pgfmathprintnumber{4000}` (number-printing package is the parameter) |
| lists | iscram-class-doc.tex:672-683 | `list.kernel` | `itemize` |
| description list | iscram-class-doc.tex:62-70,231-279 | `list.enumitem` | `\newlist{options}{description}{1}`; `\setlist`: beginpenalty=10000, itemsep/parsep/topsep/partopsep=.5\parskip plus .3\parskip minus .2\parskip, style=nextline, labelindent=1em, font=\normalfont\ttfamily |
| boxes | iscram-class-doc.tex:78,218-227 | `box.tcolorbox` | `\newtcolorbox{pseudoTeX}`: colback=blue!5, colframe=blue!5, before=\nobreak |
| side-by-side blocks | iscram-class-doc.tex:480-500,550-557,644-656 | `box.minipage` | `minipage` widths .32/.65, .6/.35, .5/.475 of `\linewidth`, `\hfill` between |
| columns | iscram-class-doc.tex:343-361 | `cols.multicol` | `multicols{6}` for the package list |
| listings styles | iscram-class-doc.tex:22-60 | `code.listings` | `\lstdefinestyle` common, TeX, console: frame=single, framerule=0pt, framesep=.5em, xleftmargin/xrightmargin=.5em, basicstyle=\ttfamily, keyword/comment/string colours, backgroundcolor blue!5 or gray!10, aboveskip/belowskip=5pt, language=[LaTeX]TeX, `moretexcs`, `fancyvrb=true` |
| listings use | iscram-class-doc.tex:215,442-453,489-499,531-538,645,687-716 | `code.listings` | `lstlisting` and `\lstinline` with `style=TeX` or `style=console`, one `basicstyle=\small\ttfamily` override |
| verbatim support | iscram-class-doc.tex:16 | `code.verbatim` | `fancyvrb` loaded for the listings `fancyvrb` key |
| figure | iscram-class-doc.tex:539-543,562-574 | `fig.graphicx` | `figure`, `\centering`, `\includegraphics[width=4cm]{HMI}` (HMI.pdf), caption below |
| figure here | iscram-class-doc.tex:586-592 | `fig.float` | placement `[H]`; class loads `float` (iscram.cls:180) |
| figure rotation | iscram-class-doc.tex:589 | `fig.rotating` | `\includegraphics[angle=90]` |
| table | iscram-class-doc.tex:599-614 | `tbl.tabular` | `tabular{rrr}`, `\centering`, caption above |
| table rules (class) | iscram.cls:183; iscram-class-doc.tex:604-612 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| captions (class) | iscram.cls:181-182; iscram-class-doc.tex:540-542,600 | `cap.caption` | `\captionsetup{margin=10pt, font={bf,small}, labelsep=period}`; sample uses `\caption` as `cap.kernel` |
| cross-references | iscram-class-doc.tex:210,529,597 | `xref.kernel` | `\label` `\ref`, e.g. fig:exampledoc |
| links and url (class) | iscram.cls:265-269; iscram-class-doc.tex:84-88,477-482 | `meta.url` | `url`; sample `\urldef{\jdmail}\url{...}` (5 definitions) and `\url` |
| hyperref (class) | iscram.cls:268-269; iscram-class-doc.tex:105,229,481 | `meta.hyperref` | colorlinks, linkcolor, citecolor, filecolor, urlcolor = `iscram links`; sample `\href`, `\texorpdfstring` |
| colours (class and sample) | iscram.cls:266-267; iscram-class-doc.tex:72-74 | `color.xcolor` | `\colorlet{iscram links}{blue!50!black}`; sample `macro color`, `option color`, `generic color` |
| bibliography (class) | iscram.cls:186-198 | `bib.biblatex-biber` | biblatex style=authoryear, url/doi/isbn=false, maxbibnames=10, minbibnames=10, maxcitenames=2, mincitenames=1, giveninits, uniquename=init, dashed=false; `\DeclareNameAlias{sortname}{last-first}`; `\AtEveryBibitem{\clearfield{note}}`; `\defbibheading{bibliography}[References]{\section{#1}}`; `\bibitemsep`=1ex; default backend (doc says biber, iscram-class-doc.tex:431-434) |
| bibliography use | iscram-class-doc.tex:82,636-666 | `bib.biblatex-biber` | `\addbibresource`, `\parencite`, `\citeauthor`, `\citeyear`, `\citetitle`, `\printbibliography[heading=bibliography]`, 10 entries in the .bib |
| inline marks | iscram-class-doc.tex:75-77,175-200 | `mark.kernel` | `\emph`, `\textbf`, `\texttt`, `\textcolor` spans; `\macro` `\option` `\generic` aliases |
| manual spacing | iscram.cls:170,172; iscram-class-doc.tex:77,484 | `sp.manual-space` | `\vspace*`, `\hfill`, `\makebox` (kernel LR box, same family as `\raisebox`) |
| penalties | iscram-class-doc.tex:78,643 | `sp.penalties` | `\nobreak` (before a box, after a paragraph) |
| logo font | iscram-class-doc.tex:79-80 | `font.nfss` | `\fontfamily{lmr}\selectfont\upshape` around kernel `\LaTeX` |
| dummy-text package | iscram-class-doc.tex:14 | `draft.todo` | `lipsum` loaded; no `\lipsum` call in the body (grep) |
| number and unit | iscram-class-doc.tex:21,137-159 | `mark.siunitx` | `\SI{1}{in}` inside the margin diagram only |
| margin diagram | iscram-class-doc.tex:15,118-161,668 | `art.tikz` and `bg.tikzpagenodes` | see Content-opaque |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `class.iscram` internals (pgfkeys option tree, `\@maketitle`, recursive author-pairing macros) | iscram.cls:19-57,166-252 | not bespoke: published CTAN class (W1) | one class way with key values; unpacked, the author-pairing recursion (`\csdef` counters, `\ifcsdef` conditionals, iscram.cls:211-252) would be irreducible, so the `yes` rests on accepting the CTAN class as a way |
| `\lstdefinestyle` common, TeX, console | iscram-class-doc.tex:22-60 | yes | `code.listings` keys as in the table |
| `\newlist{options}` and `\setlist[options]` | iscram-class-doc.tex:62-70 | yes | `list.enumitem` keys as in the table |
| `\colorlet` x3 | iscram-class-doc.tex:72-74 | yes | `color.xcolor` |
| `\macro`, `\option`, `\generic` | iscram-class-doc.tex:75-77 | yes | inline expansion: `\textcolor{c}{\ttfamily\bfseries <name>}`, `\textcolor{c}{\ttfamily <text>}`, `\textcolor{c}{\ttfamily\itshape <text>}`; the `\string#1` only prints a control-sequence name, the printed backslash name is content |
| `\newtcolorbox{pseudoTeX}` | iscram-class-doc.tex:78 | yes | `box.tcolorbox` |
| `\let\LaTeXorig` and `\renewcommand\LaTeX` | iscram-class-doc.tex:79-80 | yes | `font.nfss` wrapper around the kernel logo, two preamble lines |
| `\urldef` x5 | iscram-class-doc.tex:84-88 | yes | `meta.url` |
| `\makeatletter ... \iscram@version ... \iscram@date` | iscram-class-doc.tex:167-169 | yes | the two macros hold fixed strings (iscram.cls:10-11); write them as text in a centred `\large` paragraph |
| `\iscramshowframe` | iscram-class-doc.tex:120-161 | content, not template | TikZ overlay; see Content-opaque |

## Content-opaque
- TikZ margin diagram `\iscramshowframe`: `tikzpicture[remember picture,overlay]` with `fit` nodes on `current page text area`, `current page header area`, `current page footer area`, red rectangles, dashed guides, dimension arrows labelled `\SI{1}{in}`, `\SI{1/2}{in}`, `\SI{1}{cm}` (iscram-class-doc.tex:120-161), called once at iscram-class-doc.tex:668. It draws on the documentation page to show its margins, is defined only in the sample, and removing it leaves the ISCRAM look unchanged; needs two compiles. Held as `art.tikz` with `bg.tikzpagenodes`.
- The listing inside the closing figure (iscram-class-doc.tex:685-719) is code text.
- Bibliography entries (iscram-class-doc.bib, 10 entries) and all prose.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
