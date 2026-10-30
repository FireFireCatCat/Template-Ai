yes

# 0519-unamth-template: Tesis FI UNAM (unamth-template, class PhDthesisPSnPDF)

- Unverified: read from the source, not compiled.
- Source: Source/0519-unamth-template/ (origin: https://mirrors.ctan.org/macros/latex/contrib/unamth-template.zip; licence: GPL-3 (manifest `gpl3`; the CTAN page names GNU GPL version 3, bundle version 2.0, maintainer Jesús Velázquez, in TeX Live))
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (README.md:42 says only PDFLaTeX works; the class tests `\pdfoutput`, PhDthesisPSnPDF.cls:15 and `\ifpdf`, :112)
- Look carried by: mixed (the class file PhDthesisPSnPDF.cls carries page, heads, cover and front matter; Latex/Macros/MacroFile1.tex carries the two cover colours and rule macros the cover needs; tesis.tex adds metadata, `blindtext` and spacing)
- Class origin: ctan (the zip is the CTAN bundle `unamth-template`, read at ctan.org/pkg/unamth-template; the class name PhDthesisPSnPDF is not listed on that page, so the verdict below does not rest on the class being published: every class construct is analysed as bespoke and found reducible)
- Main file: tesis.tex (other samples: none; chapter files are `\include`d content)
- Citation shorthand: `cls` = Latex/Classes/PhDthesisPSnPDF.cls; `diseno_experimento.tex` = Capitulo3/diseno_experimento.tex; `marco_teorico.tex` = Capitulo2/marco_teorico.tex; `MacroFile1.tex` = Latex/Macros/MacroFile1.tex
- Read: main yes, zip-local classes and styles all (PhDthesisPSnPDF.cls 507 lines and MacroFile1.tex 119 lines in full; the five `.bst` files are not loaded by the sample, only the head of Latex/Classes/PhDbiblio-bold.bst was read)

## Verdict
yes. The sample is a `book`-based thesis class whose page, header/footer, chapter heading, caption and package settings are all published packages with option values, and every zip-local macro (title page, front-matter environments, colour and rule macros, metadata stores) is a composition of kernel boxes, rules, images, page breaks and published packages, so each reduces to lib ways. No TikZ or picture artwork exists; the cover is minipages, two `\vrule`/`\hrule` bars and four PDF crests. No tool outside TeX and BibTeX is needed.

## Blockers
none

## Class setting
- Class: `class.phdthesispsnpdf` options: `twoside,11pt` (tesis.tex:13); the class forwards every option to `book` (PhDthesisPSnPDF.cls:13-14) and loads `class.book` with `pdftex,a4paper` (cls:15-19).
- Class-native vocabulary used: `\degree` `\director` `\degreedate` `\lugar` (tesis.tex:27-30), `\portadatrue` (tesis.tex:32; `\portadafalse` commented at :31), `\keywords` `\subject` (tesis.tex:34-35; stored, never read), redefined `\maketitle` (cls:311-389; tesis.tex:42), environments `dedication` `acknowledgements` `declaration` `abstracts` (Dedicatoria.tex:1, Agradecimientos.tex:4, Declaracion.tex:3, Resumen.tex:6). Book vocabulary: `\frontmatter` `\mainmatter` `\appendix` `\chapter` (tesis.tex:47,69,80). titlesec vocabulary: `\chaptertitlename` (cls:61).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | tesis.tex:13; cls:13-19 | `class.phdthesispsnpdf`, `class.book` | twoside, 11pt, a4paper, pdftex |
| paper size | cls:16,18,170-176 | `page.class-options`, `page.setlength` | a4paper; `\pdfpageheight`=297mm `\pdfpagewidth`=210mm |
| page geometry | cls:178-192 | `page.setlength` | hoffset 0, voffset 0, oddsidemargin 1.5cm, evensidemargin 0cm, topmargin 1mm, headheight 1.36cm (+0.5pt at cls:226), headsep 1cm, textheight 20.84cm, textwidth 14.5cm, marginparsep 1mm, marginparwidth 3cm, footskip 2.36cm |
| flush bottom | cls:33 | `pg.flush` | `\raggedbottom` |
| blank pages empty | cls:25 | `pg.emptypage` | load-only |
| header/footer | cls:212-222,226-230 | `hf.fancyhdr` | `\pagestyle{fancy}`; `\fancyhf{}`; head RO `\rightmark`, LE `\leftmark`; foot C `\thepage`; headrulewidth 0.5pt, footrulewidth 0.1pt; `plain` redefined with empty head and headrulewidth 0pt |
| running-head marks | cls:213-214 | `hf.fancyhdr`, `mark.case` | `\chaptermark` -> `\markboth{\MakeUppercase{\thechapter. #1}}{}`; `\sectionmark` -> `\markright{\thesection\ #1}` |
| cover and front-matter page styles | cls:314,402,418,430,443,455,466,484 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` (cover), `\pagestyle{empty}` in front-matter environments (cls:402,418,430,443,455,466,484) |
| page number format | cls:241; tesis.tex:47,69 | `num.counters`, `pgnum.pagenumbering` | `\renewcommand{\thepage}{\roman{page}}`; `\frontmatter` roman, `\mainmatter` arabic (book) |
| chapter headings | cls:54-65 | `head.titlesec` | `\titleformat{\chapter}[display]{\Huge}{\titlerule\filleft\Large\chaptertitlename\ \Large\thechapter}{0mm}{\filleft}[\vspace{0.5mm}\bigrule]`, `\bigrule`=`\titlerule[0.5mm]` |
| section levels | Capitulo1/introduccion.tex:21; Capitulo3/diseno_experimento.tex:29,48 | `head.kernel` | book `\section` `\subsection` defaults, no titlesec for them |
| coloured heading text | Capitulo3/diseno_experimento.tex:47 | `head.kernel`, `color.color` | `\section{\textcolor{Azul}{...}}` |
| numbering depth | tesis.tex:57-58 | `num.secnumdepth` | secnumdepth 3, tocdepth 3 |
| appendix | tesis.tex:80; Apendice1/Apendice1.tex:3 | `num.appendix` | `\appendix` then `\chapter` |
| contents lists | tesis.tex:59,61,62 | `toc.kernel` | `\tableofcontents` `\listoffigures` `\listoftables` |
| bib and lists in toc | cls:43 | `toc.etoc` | `tocbibind[nottoc]` |
| line spacing | tesis.tex:70 | `sp.linespread` | `\def\baselinestretch{1.5}` (after `\mainmatter`) |
| text encoding, fonts | cls:23 | `font.fontenc-t1` | `inputenc[utf8]`; no text-face package (Computer Modern default) |
| language | cls:36 | `lang.babel` | `spanish,mexico` |
| colours | MacroFile1.tex:8,11; cls:37 | `color.color` | `\definecolor{Azul}{RGB}{0,63,119}`, `\definecolor{Oro}{RGB}{234,221,150}` |
| coloured rules | MacroFile1.tex:18-25 | `sp.rule`, `color.color` | `\colorvrule{col}{w}{h}` = `\color\vrule width height`; `\colorhrule{col}{h}` |
| cover page | cls:311-389; tesis.tex:42 | `front.titlepage-env` | alwayssingle page, centered, two minipages (below) |
| cover fields | tesis.tex:25-30; cls:250-282,361-382 | `front.maketitle`, `front.class-native` | `\title` `\author` (kernel); `\degree` `\director` `\degreedate` `\lugar` strings printed at cls:368,370,374,382 |
| cover boxes | cls:317,336 | `box.minipage` | `[c][10cm][s]{3cm}` (crest bar), `[c][9.5cm][s]{11cm}` (titles); `\hskip -2cm` at cls:316 |
| cover crests | cls:320,324,326,330 | `fig.graphicx` | `\includegraphics[height=2.6cm]` of Escudos/unam_azul_5x5cm, fi_azul, unam_negro_5x5cm, fi_negro (PDFs shipped) |
| cover bars | cls:321-323,343-346,327-329,348-350 | `sp.rule` | colour branch: Azul 2.5pt + Oro 1pt, vertical 13cm and horizontal; black branch: `\vrule width2.5pt height13cm`, `width1pt`, `\hrule height2.5pt`, `height1pt` |
| cover type and spacing | cls:339-382 | `font.size-commands`, `mark.kernel`, `sp.manual-space` | `\large \scshape`, `\Large \scshape` title, `\makebox[8cm][s]{\Huge T E S I S}` (cls:366), `\textbf`, `\small`, `\vspace` .3cm/3cm/2cm/.5cm/1.5cm, `\\[40pt]`, `\null\vfill` (cls:388) |
| cover colour switch | tesis.tex:32; cls:285,319-331,341-351 | `front.class-native` | boolean `\ifportada`: colour or black variant |
| dedication | Agradecimientos/Dedicatoria.tex:1-6; cls:400-407 | `front.dedication` | own page, `\pagestyle{empty}`, `\vspace*{1.5cm}`, flushright italic |
| acknowledgements | Agradecimientos/Agradecimientos.tex:4-8; cls:417-423 | `front.dedication` | own page, `\chapter*{Reconocimientos}`, `\vspace*{1.5cm}` |
| declaration | Declaracion/Declaracion.tex:3-9; cls:484-490 | `front.dedication` | own page, `\chapter*{Declaración de autenticidad}` in `center`, closing right-aligned author, place, year |
| abstract | Resumen/Resumen.tex:6-11; cls:443-449 | `abs.class-native` | own page, `\chapter*{Resumen}` in `center`, `\vspace*{1.5cm}` |
| page-break wrapper | cls:302-305 | `pg.break` | `alwayssingle`: `\newpage` before and after (the two-column branch is unreachable here) |
| code | Capitulo2/marco_teorico.tex:10-18; cls:24 | `code.listings` | `lstlisting[frame=single]`, no `\lstset` |
| figure | Capitulo3/diseno_experimento.tex:34-39; cls:137-138 | `fig.graphicx` | `figure`, `\centering`, `\includegraphics[scale=0.5]`, `\label{planta}`; extensions .png,.jpg,.pdf |
| sub-figures | cls:28 | `fig.subcaption` | `subfigure[bf,SL,BF]`, not used in the sample |
| table | Capitulo3/diseno_experimento.tex:52-82 | `tbl.tabular` | `table[htdp]`, `tabular` with column spec `\|\|c \| c \|\|`, `\hline\hline` |
| captions | cls:27; diseno_experimento.tex:37,80 | `cap.caption`, `cap.kernel` | `caption[margin=10pt,font=small,labelfont=bf]`; `\caption[short]{\textbf{..} - ..}` |
| cross-references | diseno_experimento.tex:31,49 | `xref.kernel` | `\ref{planta}`, `~\ref{tab:tabla}` |
| links and PDF options | cls:121-136 | `meta.hyperref` | pdftex, plainpages=false, pdfpagelabels, pdfpagelayout=OneColumn, bookmarks, bookmarksopen, bookmarksnumbered, breaklinks, linktocpage, pagebackref, colorlinks, linkcolor=blue, urlcolor=blue, citecolor=red, anchorcolor=green, hyperindex, hyperfigures |
| footnotes | cls:38 | `fn.footmisc` | `[perpage]` |
| maths packages | cls:22,31,32,35 | `math.amsmath`, `math.amssymb`, `math.bm`, `math.physics` | amssymb amsmath amsbsy amsfonts; `mathrsfs` and `eucal` (alphabets, `math.bm`); `mathdots` (`\iddots`, folded into the add-on bag `math.physics`) |
| columns package | cls:41-42 | `cols.multicol` | `\columnsep` 20pt; no `multicols` in the sample |
| bibliography | cls:39; tesis.tex:87,95; diseno_experimento.tex:8,9,30 | `bib.natbib`, `bib.bibtex-bst` | `natbib[round,sort,numbers]`; `\citet` `\citeauthor` `\citep`; style `apalike`; `\bibliography{Bibliografia/referencias}`; other styles are commented (tesis.tex:90-93) |
| index package | cls:29 | `idx.makeidx` | `makeidx` loaded, no `\makeindex` call |
| nomenclature | cls:69-74 | `idx.glossaries` | `nomencl[intoc]`, `\nomname`=Glossary, `\nomlabel` bold, `\makenomenclature`; `\printnomenclature` never called |
| file inclusion | tesis.tex:20,48-51,71-75,81 | `struct.input` | `\include` of macro file, front matter, five chapters, appendix |
| dummy text | tesis.tex:15; Capitulo1/introduccion.tex:22 | `draft.todo` | `blindtext` (`\blindtext`, `\Blindtext`): filler content |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `alwayssingle` environment | cls:302-305 | yes | `\newpage` before and after (single-column document); two-column branch uses `\onecolumn`/`\twocolumn`, unused here (`pg.break`) |
| `\maketitle` redefinition | cls:311-389 | yes | one `titlepage`-style page of `box.minipage` x2, `sp.rule`, `fig.graphicx`, `sp.manual-space`, `font.size-commands`, `mark.kernel` (`front.titlepage-env`) |
| `\ifportada` switch | cls:285,319-331,341-351 | yes | emit-time choice of branch (`\portadatrue` => colour, as tesis.tex:32): both branches are static compositions, no computed layout |
| metadata stores `\degree`, `\director`, `\lugar`, `\degreedate` | cls:250-251,254-255,277-278,281-282 | yes | the value is written inline where cls:368,374,382 print it |
| `\keywords`, `\subject`, `\dept`, `\college`, `\university`, `\escudo*`, `\submissiontext` | cls:258-274,288,292-298 | yes | stored and never read: grep finds `pdfkeywords` and `pdfsubject` only in comments (cls:291,296), so no PDF metadata is produced; drop |
| `dedication`, `acknowledgements`, `declaration`, `abstracts` | cls:400-407,417-423,484-490,443-449 | yes | `pg.break` + `hf.pagestyle-kernel` + `sp.manual-space` + `head.kernel` (`\chapter*`) + `sp.ragged` (`flushright`/`center`) + `mark.kernel` (`\itshape`) |
| `acknowledgementslong`, `abstractslong`, `abstractseparate` | cls:429-435,455-461,466-480 | yes (unused) | same composition; `abstractseparate` calls undefined `\submittedtext` (cls:475; the class defines `\submissiontext`, cls:288), so it is dead code |
| `\g` footnote alias | cls:74 | yes (unused) | `\footnote{..\pageref{nom}.}` (`fn.kernel`, `xref.kernel`) |
| engine conditionals | cls:15-19,112-163 | yes | pdfTeX branch only; the dvips branch is not emitted |
| stray group `{\newpage\renewcommand{\thepage}{\arabic{page}}\setcounter{page}{1}}` | cls:507 | yes | left over from the commented `romanpages` environment (cls:501-505); the `\renewcommand` is local to the group, so no look effect; drop |
| `\pdfcompresslevel=9` | cls:140 | yes | file-size setting, no look or structure effect; not emitted |
| `ifpdf`, `ifthen` | cls:96,40 | yes | load-only helpers, `ifthen` unused (only in commented code, cls:78-90); no component |
| `\colorvrule`, `\colorhrule` | MacroFile1.tex:18-25 | yes | `\begingroup\color{c}\vrule width w height h\endgroup`: `color.color` + `sp.rule` |
| `\derivada`, `\e` | MacroFile1.tex:30,39 | yes (unused) | `\dfrac`/`\mbox` aliases (`math.amsmath`) |
| `\figuremacro`, `\figuremacroW`, `\figuremacroN`, `\InsertFig`, `\IncludeGraphicsH/W`, `\PdfPsText` | MacroFile1.tex:47-108 | yes (unused) | `figure[htbp]` + `\centering` + `\includegraphics[width]` + `\caption[..]{\textbf{..} - ..}` + `\label` (`fig.graphicx`, `cap.kernel`); `\figuremacroN` needs `wrapfigure` (`fig.wrapfig`) but `wrapfig` is commented out (cls:26); `\PdfPsText` keeps the pdf branch |
| `\def\baselinestretch{1.5}` | tesis.tex:70 | yes | `sp.linespread` |
| `\include` before `\begin{document}` | tesis.tex:20 | yes | emitter writes `\input{Latex/Macros/MacroFile1}` (`struct.input`); I believe the kernel rejects `\include` in the preamble, not verified here |

## Content-opaque
none (Capitulo3/figs/planta.jpg at diseno_experimento.tex:36 is an included image, content; the Matlab text in the listing at marco_teorico.tex:10-18 is code content)

## Lib changes
- New ways proposed: none. Considered: `mathdots` as its own way (decided against: folded into the add-on bag `math.physics`; it is unused by the sample), `eucal` (folded into `math.bm`, a math-alphabet package).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes: not loaded by the sample and not read: `CUEDbiblio.bst`, `PhDbiblio-bold.bst` (head only), `PhDbiblio-case.bst`, `PhDbiblio-url.bst`, `PhDbiblio-url2.bst`, `urlbst`, `CUEDthesisPSnPDF.texshop`; the `.bst` styles would be the parameter of `bib.bibtex-bst`. Assets shipped in the zip: four crest PDFs used (plus two 5x5 variants), `planta.jpg`. README.md:47 warns that `blindtext` has no Spanish support (warnings only). No text addressed to an AI was found.
