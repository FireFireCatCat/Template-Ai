no

# 0016-rho-class-research-article: Rho class (research article)

- Unverified: read from the source, not compiled.
- Source: Source/0016-rho-class-research-article/ (origin: https://latextemplates.com/downloads/rho-class-article.zip; licence: CC-BY-4.0)
- Kind: journal
- Lib: v0
- Engine: pdfLaTeX-compatible (main.tex:30 says pdfLaTeX; no fontspec/unicode-math). The class also loads `minted`, which needs shell escape and a Python highlighter to be used.
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (rho-class/rho.cls 570 lines, rhobabel.sty 140, rhoenvs.sty 90, rho.bib 9)

## Verdict
`no`, on one blocker: `rho.cls` loads `minted` unconditionally and configures it (style, frame, background, line numbers), and the rubric files `minted` under `EXTERNAL`. The sample itself never calls `minted` (its code block is `lstlisting`, main.tex:86), so if the project decides that class-loaded options the sample does not exercise are out of scope, the blocker disappears. Everything else reduces to lib ways: the zip-local class is `extarticle` plus published packages, and its macros are font and spacing aliases, `titlesec`/`titletoc`/`caption`/`mdframed`/`tcolorbox` settings and a redefined `\@maketitle` that `titling` can express. Three ways are missing from the lib (`balance`, `lettrine`, kernel `equation`) and are proposed below.

## Blockers
- `EXTERNAL` `minted` loaded unconditionally and configured: `\usepackage{minted}`, `\usemintedstyle{lovelace}`, `\setminted{frame=single, breaklines, numbersep=5pt, fontsize=\small, bgcolor=codeback}`, `\theFancyVerbLine` (rho-class/rho.cls:522-532). The `code` environment (rho.cls:470) exists to caption such listings. The sample does not use it (main.tex:86 uses `lstlisting`).

## Class setting
- Class: `class.extarticle` options: 9pt, a4paper, twocolumn, twoside (main.tex:6). The zip-local `rho-class/rho.cls` forwards every option to extarticle with `\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}` and `\LoadClass{extarticle}` (rho.cls:40-42). The extarticle source is not bundled and was not read.
- Class-native vocabulary used: `\doctype`, `\title`, `\author[marks]{}` and `\affil[a]{}` (authblk syntax), `\dates`, `\corres`, `\docinfo`, `\journalname`, `\journal`, `\theday`, `\vol`, `\no` (main.tex:13-36); `abstract` environment before `\begin{document}` (main.tex:42-46); `\keywords` (main.tex:48); `\maketitle`; environments `note` and `info` (main.tex:65, 83); `\printbibliography` (main.tex:117). Defined by the class but not used in the sample: `rhoenv`, `\rhostart`, `\inlinecode`, `code`, `\tabletext`, `\figref \figsref \tabref \coderef \equref` (rho.cls:113, 167-171, 236, 470, 538).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| paper, size, sides | main.tex:6 | `page.class-options` | a4paper, 9pt, twoside |
| two columns | main.tex:6 | `cols.twocolumn-option` | twocolumn |
| page geometry | rho.cls:119-126 | `page.geometry` | left=1.25cm, right=1.25cm, top=2cm, bottom=2cm, headsep=0.75cm (showframe commented out) |
| last-page column balance | rho.cls:58 | `NEW:cols.balance` | package loaded, no options; `\balance` is never called in the zip |
| full-width floats in two columns | rho.cls:102 | `cols.cuted` | `stfloats` loaded, no options |
| running head and foot | rho.cls:185, 187, 216-217, 224-228 | `hf.fancyhdr` | `\pagestyle{fancy}`; headrulewidth=0pt, footrulewidth=0pt; head `[RO,LE]` = title, `[RE,LO]` = journal, both in `\footerfont`; foot `[C]` = page and `\textendash` and last page |
| page X of Y | rho.cls:186, 228 | `pgnum.lastpage` | `\pageref{LastPage}` |
| first-page style | rho.cls:198-213 | `hf.fancyhdr` | `\fancypagestyle{firststyle}`: empty head, foot L = journal name, date, Vol., No., foot R = journal and page X-Y. Defined but never selected: no `\thispagestyle{firststyle}` in the zip, so main.tex:32-36 only feed `\journal` in the head |
| footnotes | rho.cls:184 | `fn.footmisc` | bottom, hang, flushmargin, ragged |
| input and font encoding | rho.cls:49, 90 | `font.fontenc-t1` | inputenc utf8; fontenc T1 |
| body and math font | rho.cls:91 | `font.mathptmx` | `stix2` with notextcomp (Times-like text and math; package not in the way's listed members) |
| sans font | rho.cls:92 | `font.helvet` | `FiraSans` (sans family package; used for title, abstract, headings, captions) |
| mono font | rho.cls:93 | `font.mono` | `FiraMono` scaled=0.80 |
| icon font | rho.cls:55 | `font.icons` | `fontawesome5` loaded, no icon used in sample |
| size commands | rho.cls:190, 236, 244-247, 284, 113 | `font.size-commands` | `\fontsize{8}{9}` foot, `{8.5}{11}` abstract, `{9}{11}` abstract head, `{7.8}{9}` keywords, `{18}{22}` title, `{27}{24}` drop cap, `{7}{9}` table text |
| microtype | rho.cls:43 | `sp.microtype` | loaded `\AtEndOfClass`, defaults |
| ragged text | rho.cls:56, 288-291 | `sp.ragged` | `ragged2e`, `\RaggedRight` in title block |
| display skips | rho.cls:132-139 | `sp.lengths` | `\eqskip`=9pt; above/below display (short) skip set from `\eqskip` and `\baselineskip`, re-applied by extending `\normalsize` (see Bespoke code) |
| colours | rho.cls:145-148, 475-479, 525 | `color.xcolor` | rhocolor rgb 0.12,0.3,0.17; rhocodeback RGB 248,248,248; rhocodecomment 135,135,135; rhocodekey 41,56,176; rhocodestring 184,56,56; rhogray `{RGB}{0.5,0.5,0.5}` as written; codeback RGB 248,248,248; inline code uses gray!15, gray!30 |
| links | rho.cls:162, 164 | `meta.hyperref`, `meta.bookmark` | colorlinks=true, allcolors=rhocolor; `bookmark` loaded; `\href` used at main.tex:28 |
| URLs | rho.cls:154-156 | `meta.url` | `url`, `xurl`; `\UrlFont` = `\selectfont` |
| cross-references | main.tex:76, 79, 94, 101; rho.cls:163 | `xref.kernel`, `xref.cleveref` | `\label`; `cleveref` loaded after hyperref, `\cref` and `\Cref` used |
| typed reference helpers | rho.cls:167-171 | `xref.hyperref` | `\hyperref[label]{<label word>\nobreakspace\ref*{label}}`, label words from rhobabel.sty:61-103 (unused in sample) |
| lists | rho.cls:177-178 | `list.enumitem` | `\setlist{noitemsep}` (no list in sample) |
| title block | rho.cls:278, 286-295; main.tex:13-14 | `front.titling` | doctype line in bold sans (vskip -22pt, or -20pt if no doctype), title `\titlefont` (bold, rhocolor, 18/22, sans) then vskip 8pt, authors `\normalsize\sffamily`, dates 7/8pt sans after vskip 10pt, then vskip 18pt, abstract box, vskip 18pt |
| authors and affiliations | rho.cls:358-368; main.tex:20-24 | `front.authblk` | `\author[marks]{}`, `\affil[a]{}`; affilsep=10pt; Authfont `\normalfont\sffamily\fontsize{9}{11}`; Affilfont `\sffamily\itshape\fontsize{7.5}{9}\selectfont`; Authand and Authands = " and " (" y " if spanish) |
| abstract | rho.cls:250-272; main.tex:42-46 | `box.tcolorbox` | colback=rhocolor!13, arc=3pt, boxrule=0pt, left, right, top, bottom=6pt, before skip=0pt, after skip=0pt; head in `\absheadfont` (rhocolor sans 9/11 bold), body `\absfont` (black sans 8.5/11, linespread 1); placed inside `\maketitle` so it spans both columns |
| keywords | rho.cls:243, 246-247, 269; rhobabel.sty:50; main.tex:48 | `abs.keywords` | label "Keywords:" bold sans 7.8/9, then the keywords italic sans 7.8/9, last line inside the abstract box |
| first-page note block | rho.cls:301-352; main.tex:28, 30 | `pg.afterpage` | `\afterpage{\begin{figure}[b!] \footnotesize\sffamily \footnoterule <corres> \vskip8pt <docinfo> \vspace{-0.2\baselineskip}}`; one of four cases chosen by which fields exist |
| section headings | rho.cls:279, 374, 376-381, 410 | `head.titlesec` | `explicit`; section: `\color{rhocolor}\sffamily\large\bfseries`, label `\thesection.`, sep 0.5em, text `\MakeUppercase{#1}`; spacing before 3ex plus4pt minus3pt, after 5pt, left 0pc |
| unnumbered section heading | rho.cls:383-388 | `head.titlesec` | `name=\section,numberless`, block, same font, text = filled square (1.25ex, rhocolor, 2.5pt gap) then uppercase title; the square is drawn with TikZ (see Bespoke code) |
| subsection, subsubsection, paragraph | rho.cls:390-408 | `head.titlesec` | subsection block `\sffamily\bfseries`, label `\thesubsection.`, sep 0.5em; subsubsection block `\small\sffamily\bfseries\itshape`; paragraph runin `\small\bfseries`, no label; other `\titlespacing` lines are commented out (411-413) |
| numbering depth | rho.cls:374 | `num.secnumdepth` | secnumdepth=5 |
| table of contents | rho.cls:419-445 | `toc.titletoc` | `\contentsmargin{0cm}`; section level `[1.5pc]` bold sans, label width `\tocsep`, `\hfill\thecontentspage`; subsection `[3pc]` `\small\sffamily`, dotted leader `\titlerule*[.5pc]{.}`; subsubsection run-in `\titlecontents*` `[3pc]` `\footnotesize\sffamily`, separator ` \textbullet ` (not in sample) |
| figure and table captions | rho.cls:451-461; main.tex:100 | `cap.caption` | figure: format=plain, labelsep=period, textfont=small, justification=centering, labelfont={small,bf,sf}; table (`\captionsetup*`): labelfont={small,bf,sf}, textfont=small, position=below, aboveskip=0pt, labelsep=period; lstlisting: font=small, labelfont={bf,sf}, aboveskip=0pt, belowskip=9pt, position=below, textfont=small, labelsep=period |
| caption command | main.tex:100 | `cap.kernel` | `\caption{}` and `\label{}` inside the figure |
| subfigures | rho.cls:57, 452 | `fig.subcaption` | `subcaption` loaded (twice), none in sample |
| figure float | rho.cls:99; main.tex:97-102 | `fig.graphicx` | `figure[htbp]`, `\centering`, caption below; artwork is a placeholder (see Content-opaque) |
| float placement | rho.cls:100-101 | `fig.float` | `here` (emulates `float`'s H; CTAN page read) and `float` |
| figure and table sizing | rho.cls:108 | `fig.adjustbox` | `adjustbox` loaded, no options |
| table base | rho.cls:53, 112-113 | `tbl.tabular` | `array`; every `tabular` starts with `\small\sffamily` (`\AtBeginEnvironment`); `\tabletext` = 7/9 sans italic note text |
| table rules and colour | rho.cls:110-111 | `tbl.booktabs` | `booktabs` loaded; `colortbl` below |
| table colour | rho.cls:110 | `tbl.colortbl` | `colortbl` loaded, no use in sample |
| code listings | rho.cls:469-516; main.tex:86-89 | `code.listings` | style `rhocoding`, set by `\lstset{style=rhocoding}`: basicstyle `\small\ttfamily`, backgroundcolor rhocodeback, comment, keyword, string colours, numberstyle `\tiny`, numbers=none, breaklines=true, breakatwhitespace=false, keepspaces=true, captionpos=b, frame=single, rulecolor rhogray, tabsize=2, aboveskip=12pt, belowskip=7pt, xleftmargin=3.8pt, xrightmargin=3pt, columns=fullflexible, postbreak hook arrow; `\lstlistingname` = "Code"; sample: language=Python, caption |
| minted code | rho.cls:522-532 | `code.minted` | style lovelace, frame=single, breaklines, numbersep=5pt, fontsize=\small, bgcolor=codeback. **EXTERNAL**, not used by the sample |
| inline code | rho.cls:538-553 | `box.tcolorbox` | `\tcbox` boxrule=0.4pt, arc=1pt, colback=gray!15, colframe=gray!30, coltext=rhocolor, left, right, top, bottom=1pt, boxsep=0pt, fontupper=`\ttfamily\small`, valign=center, nobeforeafter, box align=base (unused in sample) |
| note and info callouts | rhoenvs.sty:49-87; rho.cls:51; main.tex:65-68, 83-90 | `box.mdframed` | `framemethod=tikz`; style: backgroundcolor=rhocolor!13, linecolor=rhocolor, all four lines off, frametitlerule=true, frametitlerulewidth=0.2pt, frametitlefont `\color{rhocolor}\bfseries\sffamily`, frametitlealignment `\raggedright`, inner margins 6pt, font `\sffamily\small`, fontcolor=rhocolor, frametitleaboveskip and belowskip 4pt, skipabove=9pt, roundcorner=3pt; titles "Information" and "Note" ("Informaci\'on", "Nota" if spanish); `rhoenv` is the same style with no title |
| drop cap | rho.cls:234-236 | `NEW:sp.lettrine` | `\lettrine[lines=2, lraise=0, findent=2pt, nindent=0em]`, letter in 27/24 bold rhocolor (unused in sample) |
| equation | main.tex:74-77, 79-81 | `NEW:math.kernel` | kernel `equation` with `\label`; no amsmath or amssymb (main.tex:79-81); math symbols come from `stix2` |
| language and labels | main.tex:7; rhobabel.sty:61-137 | `lang.babel` | `[english]`; label words chosen with `\iflanguage{spanish}{...}{...}` (Fig., Figs., Table, Code, Equation, Keywords, and, Information, Note) |
| quotation marks | rho.cls:559 | `lang.csquotes` | loaded, no options |
| bibliography | main.tex:5, 117; rho.cls:560-567 | `bib.biblatex-bibtex` | as shipped: `\PassOptionsToPackage{backend=bibtex}{biblatex}`, style=ieee, sorting=ynt, citestyle=numeric-comp, `\addbibresource{rho.bib}`, `\printbibliography` |
| bibliography (class default) | rho.cls:561 | `bib.biblatex-biber` | same options with backend=biber; main.tex:5 overrides it for the starter's pipeline |
| inline marks | main.tex:66, 79 | `mark.kernel` | `\texttt` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\@maketitle` redefinition | rho.cls:286-295 | yes | `front.titling`: `\pretitle` = doctype line + `\titlefont`, `\posttitle` = `\par\vskip8pt`, authors from authblk, `\predate`/`\postdate` = dates line and the abstract box; article's `\maketitle` puts it in `\twocolumn[...]`. All spacing and fonts are listed in the title row. Doctype and date presence picks the branch at emit time |
| `\abstract` token capture into `\theabstract` | rho.cls:250-260 | yes | The capture only lets the abstract sit in the preamble and print inside `\maketitle`; the emitter writes the abstract text directly into the `box.tcolorbox` in the title block. Relies on extarticle's `\endabstract` doing nothing in twocolumn (source not read) |
| `\rhoabstract` | rho.cls:263-272 | yes | `box.tcolorbox` with the parameters in the abstract row, plus keywords row |
| `\appto{\maketitle}{\afterpage{...}}`, `\corres`, `\docinfo` | rho.cls:303-352 | yes | `pg.afterpage` around a `figure[b!]` with `\footnoterule`; the four-case `\ifx` tests reduce to emitting the case that matches the fields present; `\corres` text is concatenated by the emitter |
| `\normalsize` extended with display skips | rho.cls:132-139 | yes, value uncertain | `sp.lengths`: `\abovedisplayskip`, `\belowdisplayskip` and the short versions set to 9pt minus `\baselineskip`, 9pt for the last. Written as `\eqskip-\baselineskip`, which is not glue arithmetic in plain TeX (no `\glueexpr`); intended value is not verifiable here, so an emitter must pick explicit lengths |
| authblk internals `\AB@affilnote`, `\AB@authnote` | rho.cls:363-364 | yes (assumption) | Only add `\sffamily` to the superscript marks. Authfont and Affilfont already select `\sffamily` (rho.cls:361-362), so authblk's default marks should give the same family. authblk source not read; this is the weakest reduction after the TikZ square |
| `\Authand`, `\Authands` | rho.cls:367-368; rhobabel.sty:109-115 | yes | documented authblk hooks; set to " and " (" y " for spanish) |
| TikZ square in numberless headings | rho.cls:387 | yes, borderline | `\tikz\draw[rhocolor, fill=rhocolor] (0,0) rectangle (1.25ex, 1.25ex)` replaced by a `\textcolor{rhocolor}{\rule{1.25ex}{1.25ex}}` inside the `head.titlesec` text; the TikZ one adds a 0.4pt outline. If the project does not accept a kernel `\rule` inside a titlesec parameter as a lib way, this is a second blocker (`ART`) |
| `\AtBeginEnvironment{tabular}{\small\sffamily}`, `\tabletext` | rho.cls:112-113 | yes | wrap each table body in `\small\sffamily` (`font.size-commands`); `\tabletext` is a font alias |
| `firststyle` page style and `\journalname`, `\theday`, `\vol`, `\no` | rho.cls:190-213 | yes | `hf.fancyhdr` `\fancypagestyle`; never applied in the zip (see header row) |
| `\rhostart`, `\dropcapfont` | rho.cls:235-236 | yes | alias of `\lettrine` with fixed options |
| `code` environment, `\lstlistingname`, `\lstlistlistingname` | rho.cls:462-463, 470 | yes | `\captionsetup{type=lstlisting}` (`cap.caption`) around a `\caption`; the two names set to the language word "Code"; only useful with minted |
| `\inlinecode` (`v` argument) | rho.cls:538-553 | yes | `\tcbox[...]{text}` with the text escaped by the emitter |
| `rhoenv`, `info`, `note` (`\newmdenv`, `\mdfdefinestyle`) | rhoenvs.sty:49-87 | yes | `box.mdframed` style and environments, parameters in the callout row |
| rhobabel label macros and `\figref` family | rhobabel.sty:50-137; rho.cls:167-171 | yes | label words chosen at emit time for the document language; `\hyperref[l]{word\nobreakspace\ref*{l}}` |
| font and length aliases (`\footerfont`, `\titlefont`, `\absfont` and others, `\tocsep`, `\eqskip`) | rho.cls:132, 190, 244-247, 284, 419-421 | yes | `font.size-commands` and `sp.lengths` values listed in the component map |
| option and hook plumbing: `\DeclareOption*`, `\AtEndOfClass`, `\PassOptionsToPackage{backend=bibtex}` | rho.cls:40, 43; main.tex:5 | yes | class options go to `class.extarticle`; `microtype` is a preamble line; the backend is a biblatex option |

Unused loads, recorded for completeness: `xifthen`, `iflang`, `etoolbox` helpers beyond the two uses above (rho.cls:50, 52, 54). No text addressed to an AI was found in the zip.

## Content-opaque
- Figure artwork placeholder `\fbox{\rule{0pt}{3cm}\rule{0.7\linewidth}{0pt}}` (main.tex:99); a real figure would be `\includegraphics`.
- The equation `E = mc^2` (main.tex:74-77), the Python snippet (main.tex:87-88), the bib entry (rho.bib:1-9) and all prose are content.

## Lib changes
- New ways proposed:
  - `NEW:cols.balance` package `balance` (CTAN, preprint bundle, ctan.org/pkg/balance read), pdf. Balances column heights on the last page of a two-column document. W1 on CTAN; W2 weak, it is an on/off switch (the CTAN page lists no options; any `\balance` or `\nobalance` commands are from its documentation, not read); W3 any two-column document; W4 a `\usepackage{balance}` preamble line.
  - `NEW:sp.lettrine` package `lettrine` (CTAN, not fetched), pdf. Drop capitals. W1 on CTAN; W2 key=value options (`lines`, `lraise`, `findent`, `nindent`, and others); W3 any document with initial capitals; W4 body wrapper `\lettrine[opts]{C}{rest}`.
  - `NEW:math.kernel` kernel `equation` environment (and `\[ \]`), pdf. The lib has no home for plain kernel display math: `math.amsmath` is a different package and `math.eqnumber` is only numbering style. W1 kernel; W2 numbering through counters and `\theequation`; W3 any document; W4 body wrapper. The consolidator may fold it into `math.eqnumber` if preferred.
- Package-list notes, no new way: `stix2` as a Times-like family member of `font.mathptmx`; `FiraSans` as a sans family member of `font.helvet`; `here` as an emulation of `float` under `fig.float`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
