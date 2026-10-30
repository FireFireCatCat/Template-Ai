yes

# 0198-arsclassica: ArsClassica (a thesis layout on top of ClassicThesis)

- Unverified: read from the source, not compiled.
- Source: Source/0198-arsclassica/ (origin: https://mirrors.ctan.org/macros/latex/contrib/arsclassica.zip; licence: LPPL, README:11-13)
- Kind: thesis
- Lib: v4
- Engine: pdfLaTeX-compatible (`% !TEX TS-program = pdflatex` at ArsClassica.tex:1; biblatex defaults to biber)
- Look carried by: class (published style packages `classicthesis` and `arsclassica` over KOMA `scrreprt`; the sample adds package options, a listings style, a bibliography heading and doc aliases. `arsclassica.sty` ships in the zip but is the CTAN release, ctan.org/pkg/arsclassica, 2017-10-31, also in TeX Live; `classicthesis` is unbundled and its source was not read)
- Class origin: tex-distribution-unbundled (`scrreprt` is KOMA-Script; the carrying style `arsclassica.sty` is `ctan`)
- Main file: ArsClassica.tex (other samples: none; Chapters/Fundamentals.tex, Chapters/Code.tex and FrontBackMatter/*.tex are `\input` from it)
- Read: main yes (ArsClassica.tex and all 9 `\input` files in full), zip-local classes and styles all (arsclassica.sty and arsclassica-settings.tex in full; there is no `.cls`; `classicthesis.sty` is not in the zip and was not read)

## Verdict
yes. The look is carried by two published CTAN packages, `classicthesis` (unbundled) and `arsclassica` (bundled, unmodified release), over the published KOMA class `scrreprt`. The lib's v3 ruling files "a thesis style, a house style" under a class-like way, so they are `class.classicthesis` and `class.arsclassica` (no options for the second: README:16-24, Fundamentals.tex:65). Everything the zip adds itself (arsclassica-settings.tex) is aliases, `\lstset`, a `\lstnewenvironment` and a `\defbibheading`, all reducible. There is no TikZ, PGF or PSTricks anywhere and nothing that needs a tool beyond the standard biber pass. The `yes` rests on counting those two packages as ways; two limits are listed under Notes below (`\formatchapter`, and `classicthesis.sty` not read).

## Blockers
none

## Class setting
- Class: `class.scrreprt` options: `a4paper,twoside,openright,titlepage,headinclude,footinclude,BCOR5mm,numbers=noenddot,cleardoublepage=empty,tablecaptionabove` (ArsClassica.tex:4-7; the empty `,,` at :5 is harmless)
- Class-native vocabulary used (KOMA): `\areaset[current]{w}{h}` (arsclassica.sty:17), page style `scrheadings` (ArsClassica.tex:35), `\lehead` `\rohead` `\rofoot` `\clearscrplain` `\headfont` `\pnumfont` `\manualmark` (arsclassica.sty:72-79,151-152; arsclassica-settings.tex:76), starred `\chapter*` (Acknowledgements.tex:9, settings:79)
- Class-like style `class.classicthesis`: `\usepackage[eulerchapternumbers,subfig,beramono,eulermath,pdfspacing,listings]{classicthesis}` (ArsClassica.tex:23); vocabulary used: `\spacedallcaps` `\spacedlowsmallcaps` (Titlepage.tex:17,19; Contents.tex:11), `\tocEntry` (settings:78), colour names `halfgray` `Maroon` `RoyalBlue` `webbrown` `webgreen` `Emerald` (sty:72-79,179-180; settings:35,37) and the internal flags `\ifct@eulerchapternumbers` `\ifct@pdfspacing` `\ifct@minionprospacing` `\ifct@parts` `\ifct@linedheaders` (sty:30,40,46,88,95). Source not in the zip, not read.
- Class-like style `class.arsclassica`: `\usepackage{arsclassica}` after classicthesis (ArsClassica.tex:24); no options, no commands (Changes:10, Fundamentals.tex:65)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | ArsClassica.tex:4-7 | `class.scrreprt` | options as above |
| paper, sides | ArsClassica.tex:4 | `page.class-options` | a4paper, twoside, openright |
| type area | ArsClassica.tex:5; arsclassica.sty:17 | `page.typearea` | headinclude, footinclude, BCOR5mm; `\areaset[current]{370pt}{784pt}` |
| thesis style (look carrier) | ArsClassica.tex:23-24 | `class.classicthesis`, `class.arsclassica` | classicthesis options eulerchapternumbers, subfig, beramono, eulermath, pdfspacing, listings; arsclassica none |
| encodings | ArsClassica.tex:9-10 | `font.fontenc-t1` | fontenc T1, inputenc utf8 |
| language | ArsClassica.tex:11 | `lang.babel` | english |
| maths | ArsClassica.tex:12; Fundamentals.tex:154-156,180-185,200-203 | `math.amsmath`, `math.amssymb` | equation, bmatrix, cases, `\hdotsfor`, `\text` |
| first-line indent | ArsClassica.tex:13 | `sp.indentfirst` | load only |
| centred title-page text block | ArsClassica.tex:15-16; Titlepage.tex:9 | `page.adjustwidth` | chngpage `\changetext{}{}{}{((\paperwidth - \textwidth) / 2) - \oddsidemargin - \hoffset - 1in}{}`; `calc` loaded only for the expression (considered: calc, no way proposed, load-only, no printed effect); chngpage is shipped inside the CTAN package `changepage` (ctan.org/pkg/chngpage redirects there, "deprecated but still provided") |
| raw length parameters in that expression | Titlepage.tex:9 | `page.setlength` | `\paperwidth` `\textwidth` `\oddsidemargin` `\hoffset` read, not set |
| input of parts | ArsClassica.tex:26,31-42 | `struct.input` | `\input{arsclassica-settings}`, `\input{FrontBackMatter/..}`, `\input{Chapters/..}` |
| page breaks | ArsClassica.tex:33,37,41 | `pg.break` | `\cleardoublepage`, `\clearpage` |
| page numbering | ArsClassica.tex:29,38 | `pgnum.pagenumbering` | roman for front matter, arabic from chapter 1 |
| plain and empty page styles | ArsClassica.tex:30; Titleback.tex:7 | `hf.pagestyle-kernel` | `\pagestyle{plain}`, `\thispagestyle{empty}`; `\markboth` Contents.tex:11; `\markright` sty:70-71 |
| blank pages | ArsClassica.tex:6 | `hf.class-native` | KOMA `cleardoublepage=empty` |
| running heads, feet | ArsClassica.tex:35; arsclassica.sty:72-79,151-152 | `hf.scrlayer-scrpage` | `\lehead`/`\rohead`: page number, `\vline` and `\headmark` in `halfgray`; `\headfont`=`\normalfont\sffamily`; `\pnumfont`=`\small\sffamily`; `\clearscrplain`, `\rofoot[..]{}` |
| title page | Titlepage.tex:7-31 | `front.titlepage-env` | `titlepage` env: `\LARGE`, `\vfill`, `\spacedlowsmallcaps{\myName}`, `{\color{Maroon}\spacedallcaps{\myTitle}}`, image 0.7\textwidth, subtitle |
| copyright and colophon page | Titleback.tex:7-35 | `front.dedication` | empty page style, `\vspace{\stretch{2}}`/`{1}`, centred lines, two run-in captions in `\spacedlowsmallcaps`, `\mail` line |
| acknowledgements page | Acknowledgements.tex:7-28 | `front.dedication` | `\chapter*`, italic `flushright` epigraph, `\bigskip`, one text block |
| epigraph block | Acknowledgements.tex:11-19 | `sp.ragged` | `flushright` env with `\itshape` |
| shaped paragraph | Acknowledgements.tex:24; ArsClassica.tex:21 | `sp.shapepar` | `\heartpar{..}` |
| contents | Contents.tex:7-11 | `toc.kernel` | `\tableofcontents`; `\markboth{\spacedlowsmallcaps{\contentsname}}{..}` |
| toc depth | Contents.tex:9 | `num.secnumdepth` | tocdepth=2 |
| PDF bookmarks, anchors | Titlepage.tex:8; Titleback.tex:8; Acknowledgements.tex:7; Contents.tex:7-8 | `meta.hyperref` | `\pdfbookmark{..}{..}`, `\phantomsection` |
| sectioning commands | Fundamentals.tex:5,13,109,113,117 | `head.kernel` | `\chapter`, `\section`, `\subsection*`, `\subsubsection*`, `\paragraph` |
| heading numbers | ArsClassica.tex:6 | `head.class-native` | KOMA `numbers=noenddot` |
| heading looks | arsclassica.sty:86-149 | `head.titlesec` | section `\titleformat{\section}{\normalfont\Large\sffamily}{\textsc{\MakeTextLowercase{\thesection}}}{1em}{\spacedlowsmallcaps}`; subsection `{\normalfont\sffamily\bfseries}`, label small caps, `\normalsize`; subsubsection `\bfseries\itshape`; paragraph `[runin]`, sep 0pt; chapter `[block]` `{\normalfont\Large\sffamily}`, label `\chapterNumber\thechapter\hspace{10pt}\vline`, sep 10pt, body `\formatchapter`; `\titlespacing*`: chapter 1/2 baselineskip, section 2/.8 with right `\marginparsep`, subsection 1.5/.8, paragraph 1/1; branches for `parts` and `linedheaders` follow classicthesis flags (not used by the sample: no `\part`, `linedheaders` not given) |
| spaced (letter-spaced) capitals | arsclassica.sty:46-51 | `sp.microtype` | pdfspacing branch: `\microtypesetup{expansion=false}`, `\textls[160]` for all caps, `\textls[80]` for low small caps |
| case change in those macros | arsclassica.sty:49-51,70-71 | `mark.case` | `\MakeTextUppercase`, `\MakeTextLowercase` |
| font switches | arsclassica.sty:41-62,104-130 | `mark.kernel` | `\sffamily` `\scshape` `\bfseries` `\itshape` `\textsc` `\normalfont` |
| sans family | arsclassica.sty:23 | `font.family-default` | `\renewcommand{\sfdefault}{iwona}` (font files come from TeX Live, not the zip) |
| chapter-number font | arsclassica.sty:29-34 | `font.nfss` | kernel `\newfont{\chapterNumber}{eurb10 scaled 5000}` (eulerchapternumbers branch; the other branch is `pplr9d scaled 5000`) |
| font sizes | Titlepage.tex:11; arsclassica.sty:72,79,104 | `font.size-commands` | `\LARGE`, `\Large`, `\small`, `\normalsize` |
| spacing, raising | Titlepage.tex:13-15; Titleback.tex:10-29; arsclassica.sty:72-77,106,148 | `sp.manual-space` | `\hfill`, `\vfill`, `\vspace{\stretch{n}}`, `\bigskip` `\medskip` `\smallskip`, `\kern1em`, `\llap` `\rlap` `\hspace`, `\raisebox{-0.33ex}` (Titleback.tex:35) |
| rules | arsclassica.sty:72-77,106,148 | `sp.rule` | `\vline` between page number and head text and after the chapter number |
| centring | Titlepage.tex:10; Titleback.tex:14; arsclassica.sty:143 | `sp.ragged` | `center` env, `\raggedright` inside `\formatchapter` (`\raggedleft`/`\raggedright` also sit in the inactive linedheaders branch, sty:97,99) |
| symbol glyph | ArsClassica.tex:22; Titleback.tex:35 | `font.icons` | pifont `\ding{43}` |
| colours | arsclassica.sty:72-77,92,179-180; settings:32,35,37,43 | `color.xcolor` | `\color{halfgray}`, `Maroon`, `RoyalBlue`, `webbrown`, `webgreen`, `Emerald` (definitions are in classicthesis, not read); `\definecolor{lightergray}{gray}{0.99}` |
| itemize bullet | arsclassica.sty:158; Fundamentals.tex:57-63,76-84 | `list.kernel` | `\renewcommand\labelitemi{\color{halfgray}$\bullet$}` |
| description labels | arsclassica.sty:129-130; Fundamentals.tex:127-132 | `list.kernel` | `\renewcommand{\descriptionlabel}[1]{\hspace*{\labelsep}\bfseries\spacedlowsmallcaps{#1}}` |
| captions | arsclassica.sty:11,164-165; ArsClassica.tex:7; Fundamentals.tex:101,135 | `cap.caption` | `\captionsetup{format=hang,font=small,labelfont={sf,bf}}`, `\captionsetup[table]{skip=\medskipamount}` |
| caption position | ArsClassica.tex:7 | `cap.koma` | `tablecaptionabove` |
| caption command | Fundamentals.tex:101,135 | `cap.kernel` | `\caption[short]{long}` |
| figure | Fundamentals.tex:90-103; ArsClassica.tex:18,19; settings:26 | `fig.graphicx` | `figure`, `\centering`, `\includegraphics[width=.45\columnwidth]`, `\graphicspath{{Graphics/}}` |
| sub-figures | Fundamentals.tex:92-100; ArsClassica.tex:19 | `fig.subcaption` | subfig `\subfloat[..]{..}`, four panels in a 2x2 grid with `\quad` and `\\` |
| table | Fundamentals.tex:134-146 | `tbl.tabular` | `tabular{ll}` |
| table rules | Fundamentals.tex:138-144 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule`; booktabs is not in the sample's preamble (ArsClassica.tex:9-24), so it must come in through classicthesis (not read): an emitter should print it |
| hyperlinks and PDF settings | arsclassica.sty:171-184 | `meta.hyperref` | `\hypersetup{colorlinks=true, linktocpage=true, pdfstartpage=1, pdfstartview=FitV, breaklinks=true, pdfpagemode=UseOutlines, pageanchor=true, plainpages=false, bookmarksnumbered, bookmarksopen=true, bookmarksopenlevel=1, hypertexnames=true, pdfhighlight=/O, urlcolor=webbrown, linkcolor=RoyalBlue, citecolor=webgreen, hyperfootnotes=false, pdfpagelabels, pdfcreator={pdfLaTeX}, pdfproducer={LaTeX with ArsClassica}}`; `pdfpagemode` is given twice (:173,:174), the later wins |
| cross-references, links | Fundamentals.tex:6,95,102; settings:20 | `xref.kernel`, `xref.hyperref` | `\label`; `\href{mailto:..}{..}` |
| code listings | ArsClassica.tex:17; settings:34-47,51-62; Code.tex:9-13,18 | `code.listings` | language=[LaTeX]Tex, keywordstyle `\color{RoyalBlue}`, basicstyle `\small\ttfamily`, commentstyle `\color{Emerald}\ttfamily`, stringstyle `\rmfamily`, numberstyle `\scriptsize`, showstringspaces=false, breaklines=true, frame=lines, backgroundcolor `\color{lightergray}`, flexiblecolumns=true, escapeinside `{£*}{*£}`, firstnumber=last, then numbers=left, stepnumber=1, numbersep=8pt, `morekeywords` list |
| code environment | settings:64-66; Fundamentals.tex:21-30 | `code.listings` | `\lstnewenvironment{code}` with `columns=fullflexible,keepspaces=true`, basicstyle `\small\ttfamily` |
| bibliography | ArsClassica.tex:14; settings:72-82; Bibliography.tex:7-8; Fundamentals.tex:15 | `bib.biblatex-biber` | `style=philosophy-modern` (the `biblatex-philosophy` style, not in the zip), `hyperref`, `\bibliography{Bibliography}`, `\nocite{*}`, `\printbibliography`, `\parencite`; `\renewcommand*{\nameyeardelim}{\addcomma\space}`; five entries in Bibliography.bib (book, manual) |
| bibliography heading | settings:74-80 | `bib.biblatex-biber` | `\defbibheading{bibliography}`: `\cleardoublepage`, `\manualmark`, `\phantomsection`, `\addcontentsline{toc}{chapter}{\tocEntry{\bibname}}`, `\chapter*{\bibname\markboth{..}{..}}`; parts are `pg.break`, `hf.scrlayer-scrpage`, `meta.hyperref`, `toc.kernel`, `head.titlesec` |
| filler text | ArsClassica.tex:20; Fundamentals.tex:111,115,177,188,215,223 | `draft.todo` | `\lipsum[n]` (content) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\myName` `\myTitle` `\mySubTitle` | settings:4-6 | yes | text aliases, expand inline (content) |
| `\clsname` `\pkgname` `\optname` | settings:8-10 | yes | `\DeclareRobustCommand*` wrappers over `\normalfont` plus `\sffamily` or `\ttfamily` (`mark.kernel`) |
| `\cmdname` | settings:11 | yes | `\mbox{\lstinline[basicstyle=\normalsize\ttfamily]!\\#1!}` (`code.listings` inline) |
| `\classicthesis` `\arsclassica` | settings:13-14 | yes | text aliases (`mark.kernel`) |
| `\mail` | settings:20 | yes | `\href{mailto:#1}{\texttt{#1}}` (`xref.hyperref`, `mark.kernel`) |
| `\meta` | settings:49 | yes | `$\langle$` `\itshape` `$\rangle$`; used only inside listing escapes (Fundamentals.tex:22,24) |
| `code` environment | settings:64-66 | yes | `code.listings` declarative `\lstnewenvironment` |
| `\defbibheading{bibliography}` | settings:74-80 | yes | biblatex declarative heading, composition listed in the map |
| `\nameyeardelim` | settings:82 | yes | biblatex delimiter value |
| `\definecolor{lightergray}` | settings:32 | yes | `color.xcolor`, gray 0.99 |

Defined inside the zip but **published, so not counted as bespoke** (arsclassica.sty is the CTAN release; it is printed as one `\usepackage{arsclassica}`): `\spacedallcaps` `\spacedlowsmallcaps` (sty:40-64, `\DeclareRobustCommand` over `sp.microtype`, `mark.case`, `mark.kernel`, switched by classicthesis flags), `\chapterNumber` (sty:29-34), `\formatchapter` (sty:140-144).

## Content-opaque
- Included PDF image on the title page, FrontBackMatter/Titlepage.tex:25 (Graphics/TFZSuperEllisse.pdf, shipped); an `\includegraphics` asset, not drawing code.
- Four JPEGs in the figure at Chapters/Fundamentals.tex:90-103 (Graphics/Lorem.jpg, Ipsum.jpg, Dolor.jpg, Sit.jpg, shipped).
- Display equations at Chapters/Fundamentals.tex:154-221; the listings of the package's own code at Chapters/Code.tex:18-203; dummy text.

## Lib changes
- New ways proposed: none. Considered and not proposed: `calc` (load-only extension of length expressions, no printed effect; used once at Titlepage.tex:9), `eulervm` math font (only reached as the classicthesis option `eulermath`, a parameter of `class.classicthesis`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes (gaps and limits, read-only analysis)
- `classicthesis.sty` (CTAN, GPL, unbundled) is not in the zip and was not read. Its text face, margins, Euler maths, colour definitions, `\tocEntry`, loading of hyperref and (apparently) booktabs, and its defaults for `\ifct@parts` and `\ifct@linedheaders` are therefore not decomposed here. The CTAN page does not list what it loads.
- If someone chose to rebuild `arsclassica.sty` from component ways instead of printing `\usepackage{arsclassica}`, `\formatchapter` (arsclassica.sty:140-144: `\vbox to \ht\strutbox`, `\setbox0`, `\advance\hsize`, `\vss`) is a box-and-glue construct with no lib way; it would then be `BESPOKE/class`. Under the published-package reading it is not counted.
- The arsclassica-settings.tex file and Chapters/Fundamentals.tex are ISO-8859-1 (byte 0xA3 as the listings escape delimiter at settings:45 and Fundamentals.tex:22,24,28,39,46), while ArsClassica.tex:10 declares `utf8`. Not compiled, so whether the escape works under `utf8` was not tested.
- `\toprule` (Fundamentals.tex:138) has no booktabs in the sample's own preamble; see the table row above.
- The shipped ArsClassica.pdf was not read (a compiled output, not source).
