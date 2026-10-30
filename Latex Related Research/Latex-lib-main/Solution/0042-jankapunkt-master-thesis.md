no

# 0042-jankapunkt-master-thesis: Master Thesis LaTeX template (jankapunkt, two samples: simple and complex)

- Unverified: read from the source, not compiled.
- Source: Source/0042-jankapunkt-master-thesis/ (origin: https://codeload.github.com/jankapunkt/master-thesis/zip/refs/heads/master; licence: not established in the manifest; README.md:13 states MIT)
- Kind: thesis
- Lib: v1
- Engine: pdfLaTeX-compatible (simple/main.tex:1 `% !TEX TS-program = pdflatex`; complex/main.tex:14 `pdftex` option). Needs the TeX Live `xindy` index processor for the glossary (see Verdict).
- Look carried by: preamble (simple: its own preamble, simple/main.tex:35-245; complex: the zip-local `complex/includes/declarations.tex` loaded at complex/main.tex:33 plus `includes/title.tex`; the kernel `report` class only supplies chapters)
- Class origin: tex-distribution-unbundled
- Main file: simple/main.tex (other samples: complex/main.tex with includes/declarations.tex, title.tex, chapter1.tex, chapter2.tex)
- Read: main yes, zip-local classes and styles none present (no .cls/.sty/.bst in the zip; the zip-local `declarations.tex`, `title.tex`, both chapter files, `glossary.tex` and the `.bib` files were read in full; `complex/main.xdy` and `main.ilg` are generated output, only the headers were read)

## Verdict
no. The zip holds two templates. The `simple` one maps entirely to lib ways with zip-local macros that are all aliases, so on its own it would be a yes. The `complex` one draws its cover banner with a zip-local TikZ overlay (`\TITLEBOX`, filled rectangle from `current page.north west` to the hard-coded point `(25.0,-3.5)`), and the white "Master Thesis" text on the title page sits on it. That is template-defining artwork. I considered `bg.background` with a coloured `\rule` (the package is even loaded and never used), but the band edge is given in picture-local coordinates of a `remember picture` overlay anchored at the text flow, so a page-anchored declarative height would have to be derived, not read; I do not accept that as shown. Per the rubric ("a wrong yes costs more"), `ART/preamble` stands and the verdict is no. Judgement call recorded: `glossaries[xindy]` (both samples) and `imakeidx[xindy]` (simple) need the `xindy` processor; I treat it like makeindex/biber/bibtex (TeX Live processors behind lib ways `idx.glossaries`, `idx.makeidx`) and not as `EXTERNAL`. If index processors are later ruled external, both samples would carry `EXTERNAL/package` as well.

## Blockers
- `ART/preamble` cover banner `\TITLEBOX`: TikZ overlay filled rectangle, used on the title page of the complex sample (complex/includes/declarations.tex:187-192; used at complex/includes/title.tex:5)
- `ART/preamble` page band `\SECTBOX`: TikZ overlay filled rectangle from `current page.west` to `current page.north east`; defined but never called anywhere in the zip, so it does not change either output (complex/includes/declarations.tex:179-184)

## Class setting
- Class: `class.report` options: `11pt,titlepage,twoside,openright` (simple/main.tex:35); complex adds `pdftex` (complex/main.tex:14). Published kernel class, not in the zip, source not read.
- Class-native vocabulary used: `\chapter[short]{title}`, `\section[short]{title}`, `\subsection`, `\subsubsection` (complex/includes/chapter1.tex:53), `abstract` environment (renamed through `\abstractname`), `titlepage` environment (complex/includes/title.tex:1), `\maketitle` (simple/main.tex:264), `\tableofcontents`, `\listoffigures`, `\listoftables` (complex/main.tex:73-75), `\cleardoublepage`, `\chaptermark`, `\sectionmark`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | simple/main.tex:35; complex/main.tex:14 | `class.report` | 11pt, titlepage, twoside, openright (+ pdftex in complex) |
| page geometry | simple/main.tex:94,97; complex/includes/declarations.tex:62,65 | `page.geometry` | simple: inner=4cm, outer=2cm, bottom=3.5cm, a4paper; complex: bottom=3cm, marginparwidth=1.5cm, marginparsep=0.5cm, a4paper |
| raw side margins | simple/main.tex:99-100; declarations.tex:68-69 | `page.setlength` | \oddsidemargin=15.5pt, \evensidemargin=15.5pt (set in the preamble after geometry; how geometry and the raw lengths interact is unverified) |
| paragraph shape | simple/main.tex:102-103; declarations.tex:72-73 | `sp.lengths` | simple: \parindent=4mm, \parskip=1mm; complex: \parindent=0mm, \parskip=1mm |
| line spacing | simple/main.tex:84; declarations.tex:52 | `sp.linespread` | \linespread{1.05} simple, {1.25} complex |
| microtypography | simple/main.tex:75; declarations.tex:42 | `sp.microtype` | protrusion=true, expansion=true |
| input encoding, font encoding | simple/main.tex:42,81; complex/main.tex:22; declarations.tex:48 | `font.fontenc-t1` | inputenc utf8 (simple) / utf8x (complex, needs `ucs`, on CTAN); fontenc T1 |
| text font simple | simple/main.tex:78 | `font.palatino` | mathpazo |
| text font complex | declarations.tex:45 | `font.mathptmx` | `pslatex` (CTAN, psnfss: Times, Helvetica 90%, Courier 85%); package is the parameter |
| extra sizes | simple/main.tex:87; declarations.tex:55; used simple:220,189,346,365 | `font.size-commands` | `moresize` (CTAN) provides `\HUGE`, `\ssmall`; also `\LARGE`, `\large`, `\huge`, `\scriptsize`, `\small` in the bodies. `\HUGE` equals a `\fontsize` switch, so no new way |
| colours simple | simple/main.tex:48,51,54,57 | `color.color` | \definecolor citationscol rgb 0.1,0.1,0.5; urlscol RGB 220,120,0; linkscol rgb 0.2,0.2,0.3 |
| colours complex | declarations.tex:6,9-23 | `color.xcolor` | options table, usenames, dvipsnames; CITATION_COL 121,0,226; SECTION_COL and MAIN_COL 0,117,226; LINK_COL black; CODE_COL grey 0.8; DEF_COL 226,109,0 |
| links and metadata | simple/main.tex:65; declarations.tex:30 | `meta.hyperref` | colorlinks=true, citecolor, urlcolor, linkcolor from the colours above |
| url style | simple/main.tex:66-67; declarations.tex:33-34 | `meta.url` | \urlstyle{same} |
| header and footer simple | simple/main.tex:146-166 | `hf.fancyhdr` | \lhead \sffamily urlscol "Chapter \thechapter: \leftmark"; \rhead \rightmark; \fancyhf[FLE,FRO]{\sffamily\large\thepage}; \cfoot{}; plain page style redefined with empty \fancyhf, rules 0pt, centred \thepage |
| header and footer complex | declarations.tex:130-158 | `hf.fancyhdr` | \fancyhf[HLE,HRO] page number in a MAIN_COL \colorbox (white, \sffamily\LARGE); \fancyhf[HRE,HLO]{\sffamily\textcolor{MAIN_COL}{\leftmark}}; footers empty; plain redefined |
| running-head marks | simple/main.tex:148-153; declarations.tex:133-139 | `head.kernel` | \renewcommand \chaptermark -> \markboth{#1}{}; \sectionmark -> \markright{\thesection\ #1} (kernel mark commands) |
| page styles in flow | simple/main.tex:273,282,342; complex/main.tex:68,91,138 | `hf.pagestyle-kernel` | \pagestyle empty, fancy, plain |
| page numbering | simple/main.tex:260-261,280-281; complex/main.tex:61-62,93-94 | `pgnum.pagenumbering` | roman for front matter, arabic from chapter 1; \setcounter{page}{1} |
| section heads | simple/main.tex:178-195; declarations.tex:199-205 | `head.titlesec` | `explicit`; \section \LARGE\bf\sffamily with coloured "number, 12pt, title"; \subsection \large\bf\sffamily; simple also \chapter \HUGE\bf\sffamily with the label in a `\colorbox{urlscol}` of `\makebox[1\linewidth][c]` shifted by `\hspace{-0.25\linewidth}`; spacing 0pt, no before code |
| section fonts | simple/main.tex:173-176; declarations.tex:166,196 | `head.sectsty` | \allsectionsfont{\sffamily\mdseries\upshape} (loaded together with titlesec; titlesec's formats are applied on top) |
| toc depth | complex/main.tex:72 | `num.secnumdepth` | tocdepth=1 |
| title block simple | simple/main.tex:220-228,264 | `front.maketitle` | \title{\HUGE\textbf{...}}; \author with \\ lines; \date{\today}; class option titlepage; manual \vspace around (lines 221,227,265) |
| title page complex | complex/includes/title.tex:1-61 | `front.titlepage-env` | titlepage, center, \sffamily; two logos via \includegraphics (0.45 and 0.15 \textwidth) with \makebox[1.5cm]{}; \HRule above and below the title; two minipages 0.4\textwidth with flushleft/flushright; \vfill, \today |
| title page parts | title.tex:12,17,22-29,34-47 | `fig.graphicx`, `cols.minipage`, `sp.manual-space`, `sp.rule`, `mark.kernel`, `font.size-commands` | \\[4cm], \\[1.5cm], \\[0.4cm], \vfill; \textsc, \bfseries, \emph |
| cover banner | complex/includes/title.tex:5; declarations.tex:187-192 | `art.tikz` | `tikzpicture[remember picture,overlay]`, \path[fill=MAIN_COL] (current page.north west) rectangle (25.0,-3.5). **ART**, not accepted as reducible (see Verdict) |
| unused page band and background | declarations.tex:172,175-176,179-184 | `art.tikz`, `bg.background` | `background[some]` loaded and never called; tikz libraries shapes, backgrounds, mindmap, trees loaded; \SECTBOX never used |
| abstract | simple/main.tex:206,274-276; declarations.tex:226; complex/main.tex:82-87 | `abs.kernel` | \abstractname renamed to "Executive Summary"; with class option titlepage the abstract takes its own page |
| contents lists | simple/main.tex:269; complex/main.tex:73-75 | `toc.kernel` | \tableofcontents, \listoffigures, \listoftables; \addcontentsline{toc}{chapter}{...} (simple:345,361,380; complex:137) |
| toc style | simple/main.tex:202-204 | `toc.tocloft` | options titles, subfigure; \cftsecfont and \cftsecpagefont set to \rmfamily\mdseries\upshape (commented out in complex, declarations.tex:219-223) |
| lists | simple/main.tex:302; complex/includes/chapter1.tex:23,37 | `list.kernel` | itemize, enumerate |
| list package | simple/main.tex:130; declarations.tex:108 | `list.paralist` | loaded, no paralist-only syntax used |
| footnotes | complex/includes/chapter1.tex:18 | `fn.kernel` | three \footnote, one containing \url |
| text marks | chapter1.tex:14-78 | `mark.kernel` | \textit, \textbf, \emph, \textsc |
| maths | declarations.tex:169; chapter2.tex:62-87 | `math.amsmath`, `math.kernel` | amsmath loaded; inline `$...$` with \frac and \displaystyle\sum inside `center`; no numbered equations |
| figure | chapter1.tex:96-101 | `fig.graphicx`, `fig.float` | figure[H], center, \includegraphics[width=0.8\textwidth] |
| captions | chapter1.tex:100,131; chapter2.tex:29,31 | `cap.kernel` | \caption[short]{long} with a \citep inside |
| loaded float packages | simple/main.tex:113; declarations.tex:89,93,262 | `fig.subcaption`, `fig.wrapfig`, `fig.float` | subfig, wrapfig, float loaded; subfig and wrapfig never used |
| table | chapter1.tex:112-132; chapter2.tex:42-57 | `tbl.tabular`, `tbl.multirow`, `tbl.colortbl` | `\hline`, `\cline`, `\multicolumn`, `\multirow{5}{*}`, `\cellcolor{green}` (xcolor[table]); wrapped in table[H] |
| table packages loaded | simple/main.tex:117,120; declarations.tex:96,99,258 | `tbl.booktabs`, `tbl.tabularx` | booktabs, array, tabularx loaded; booktabs and tabularx rules never used |
| pseudocode | declarations.tex:255; chapter2.tex:8-32 | `alg.algorithm2e` | options ruled, linesnumbered; \KwData, \KwResult, \Repeat, \For, \If, \tcp*[l]; algorithm[H] nested in a figure with its own caption |
| verbatim | simple/main.tex:134; chapter2.tex:93-104 | `code.verbatim` | verbatim environment under \scriptsize |
| listings | declarations.tex:245-285; chapter2.tex:107-116 | `code.listings` | \lstset backgroundcolor=\color{CODE_COL}, language=C, breaklines, basicstyle=\ttfamily, columns=fullflexible, showstringspaces=false, commentstyle=\color{gray}\upshape; \lstdefinelanguage{XML} (morestring, morecomment, stringstyle, identifierstyle, keywordstyle, morekeywords) |
| boxes | simple/main.tex:185; declarations.tex:147,156 | `box.fancybox` | \colorbox with \textcolor{white} (chapter head, page number tab) |
| rules and strut | simple/main.tex:139; declarations.tex:122,234,236; chapter1.tex:16 | `sp.rule` | \rule widths \linewidth 0.5mm and 0.5\linewidth 0.05mm in CODE_COL; \mystrut |
| manual spacing | simple/main.tex:221,227,265; title.tex | `sp.manual-space` | \vspace, \hspace, \\[len], \vfill, \hspace*{\fill} (chapter1.tex:116) |
| page breaks | simple/main.tex:266,296,315; complex/main.tex:77,111,121,126 | `pg.break` | \cleardoublepage, \newpage |
| included PDF pages | declarations.tex:261 | `pg.include-pdf` | pdfpages loaded, never used |
| bibliography complex | complex/main.tex:25,144-145 | `bib.natbib`, `bib.bibtex-bst` | natbib [square, authoryear]; abbrvnat; two .bib files; \citep, \citet with page note (chapter1.tex:74-78) |
| bibliography simple | simple/main.tex:366-369 | `bib.bibtex-bst` | `plain`; \nocite{*}; heading is a hand-made \textbf{\LARGE{Bibliography}}\\ (line 365) |
| index | simple/main.tex:244-245,313,332,348,382; complex/main.tex:46-47 | `idx.makeidx` | simple: imakeidx [xindy], \makeindex, \index, \printindex; complex: makeidx and \makeindex only (no \index or \printindex; main.ilg records 0 entries) |
| glossary | simple/main.tex:239-243,384; simple/glossary.tex:1-8; complex/main.tex:41-45 | `idx.glossaries` | glossaries [style=long, nonumberlist, toc, xindy, acronym, nomain]; \newacronym, \newglossaryentry; \makeglossaries; \printglossaries (simple only). complex \include{glossary} points to a file absent from complex/ (only simple/glossary.tex exists) |
| appendix and back-matter heads | simple/main.tex:340-348,359-365,378-384 | `toc.kernel`, `mark.kernel`, `font.size-commands`, `sp.manual-space` | no \appendix; \phantomsection + \addcontentsline{toc}{chapter}{...} + \textbf{\LARGE{...}}\\ as a hand-made heading |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\mystrut` | simple/main.tex:139; declarations.tex:122 | yes (never called) | `sp.rule`: \rule[-.3\baselineskip]{0pt}{\baselineskip} |
| `\NOTE` | declarations.tex:77 | yes | `mark.kernel` \textit + `color.xcolor` \textcolor{DEF_COL} on the argument (used chapter1.tex:14-72, chapter2.tex:4-6) |
| `\HRule`, `\ThinHRule` | declarations.tex:234,236 | yes | `sp.rule` with width/height and `color.xcolor` colour |
| `\TITLEBOX` | declarations.tex:187-192 | no | `ART/preamble`; TikZ overlay band with absolute coordinates (see Verdict) |
| `\SECTBOX` | declarations.tex:179-184 | no, but dead | `ART/preamble`; never called |
| `\chaptermark`, `\sectionmark` redefinitions | simple/main.tex:148-153; declarations.tex:133-139 | yes | kernel \markboth and \markright for `hf.fancyhdr` |
| chapter heading box | simple/main.tex:183-193 | yes | `head.titlesec` format with `\colorbox` (`box.fancybox`) and `sp.manual-space`; boxes and lengths only |
| `\fancypagestyle{plain}` redefinitions | simple/main.tex:161-166; declarations.tex:152-158 | yes | `hf.fancyhdr` declarations |
| hand-made headings | simple/main.tex:346,365,381 | yes | `mark.kernel` + `font.size-commands` + `\\` |

## Content-opaque
none. Notes: the algorithm2e pseudocode in a figure (complex/includes/chapter2.tex:8-32) is held by `alg.algorithm2e`; the images `media/unilogo.png`, `media/faculty.png`, `media/amp.jpg` are shipped in complex/media/ (figure artwork, content); the simple sample uses no images; no tikz or pgfplots picture sits in a figure.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
