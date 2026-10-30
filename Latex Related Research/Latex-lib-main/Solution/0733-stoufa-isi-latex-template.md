no

# 0733-stoufa-isi-latex-template: ISI PFE internship-report template (zip-local `isipfe` class on `book`)

- Unverified: read from the source, not compiled.
- Source: Source/0733-stoufa-isi-latex-template/ (origin: https://codeload.github.com/stoufa/ISI-LaTeX-Template/zip/refs/heads/master; licence: not established; the file headers say "Proprietary ... All Rights Reserved", tpl/isipfe.cls:5-6)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (as written: `inputenc` utf8 and `fontenc` T1, tpl/isipfe.cls:111-112, no `fontspec`; Arabic script goes through babel `arabic`, tpl/isipfe.cls:116 and global_config.tex:62; whether pdfTeX typesets it was not checked, README.md:3 names ShareLaTeX and TeXMaker only)
- Look carried by: zip-local (the class `tpl/isipfe.cls` over `book` sets page, headers, spacing, captions, chapter head; `tpl/new_commands.tex` and `tpl/cover_page*.tex`, `tpl/signatures.tex`, `tpl/resume.tex` set the covers; main.tex's own preamble is only `\graphicspath`, `\input`, `\makeindex`, main.tex:14-23)
- Class origin: zip-local (`isipfe` is one institute's class "produced based on mqthesis.cls", tpl/isipfe.cls:3, marked Proprietary; the zip is a student's GitHub repository, not an official release; no CTAN page was read)
- Main file: main.tex (other samples: none; introduction.tex, chap_01..chap_04.tex, conclusion.tex, annexes.tex, acronymes.tex, dedicaces.tex, remerciement.tex are `\input` parts of it)
- Read: main yes, zip-local classes and styles all (isipfe.cls 353 lines, new_commands.tex, global_config.tex, cover_page.tex, cover_page_black.tex, signatures.tex, resume.tex; every `.tex` in the zip). Not read: `biblio.bib` and `main-blx.bib` (content), `Rapport_Template_ISI.pdf`, images.

## Verdict
`no`. The look is a zip-local `book`-based class plus plain `tcolorbox`/`minipage` cover pages, and almost all of it reduces to lib ways (below). The blocker is the hand-rolled `\thesection` switch: `\renewcommand{\thesection}` goes through a `\csname` indirection that `\minitocsection` flips inside a group, so section numbers print differently in the chapter mini-contents than elsewhere (tpl/isipfe.cls:193-195); no lib way expresses that, and its effect depends on expansion order that was read, not compiled. No TikZ or PSTricks artwork draws anything (`pstricks` is loaded, tpl/isipfe.cls:206, and never called). Open point: `\textLR` and `\textAR` (tpl/isipfe.cls:321) are defined nowhere in the zip; `babel` with `arabic` (tpl/isipfe.cls:116) is the only loaded package that could supply them, which was not verified.

## Blockers
- `BESPOKE/class` the `\thesection` redefinition through `\csname filterminitoc \endcsname` (note the space inside the name), the `\filterminitoc` identity macro, and `\minitocsection`, which redefines `\filterminitoc` to swallow the chapter prefix inside a group around `\minitoc`; called from the chapter head (tpl/isipfe.cls:193-195, 227)

## Class setting
- Class: `class.book` options: 11pt, a4paper, oneside (tpl/isipfe.cls:32), reached through the zip-local class `isipfe`, loaded as `\documentclass[]{./tpl/isipfe}` with no option (main.tex:13; `[pfe]` is commented out, main.tex:12). The class's own options `isBinomal` and `wantToTypeCompanyAddress` are booleans (tpl/isipfe.cls:20-26).
- Class-native vocabulary used: `\frontmatter` (main.tex:28), `\mainmatter` (main.tex:54), `\backmatter` (main.tex:82), `\chapter` and `\chapter*` (chap_01.tex:1, dedicaces.tex:1), `\section`, `\subsection`, `\tableofcontents`, `\listoffigures`, `\listoftables` (main.tex:42,46,48). Zip-local vocabulary (not published): `\diplomaName`, `\speciality`, `\proFramerName`, `\academicFramerName`, `\companyName`, `\collegeYear`, `\arabicAbstract`, `\frenchAbstract`, `\englishAbstract` and the other field setters (tpl/new_commands.tex:24-92).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:13; tpl/isipfe.cls:32 | `class.book` | 11pt, a4paper, oneside |
| paper size | tpl/isipfe.cls:32-33 | `page.class-options`, `page.geometry` | `a4paper` class option; `geometry` loaded with `a4paper` only |
| text block | tpl/isipfe.cls:37-77 | `page.setlength` | `\oddsidemargin` and `\evensidemargin` = -1in then +22mm; `\topmargin` = -1in then +20mm; `\hoffset` `\voffset` 0mm; `\marginparwidth` 40pt; `\marginparsep` 10pt; `\headsep` 0.2in; `\headheight` +2.5pt; `\textwidth` 21cm and `\textheight` 30cm reduced by the margins and 2in; how this interacts with `geometry` (line 33) was not determined |
| cover and back-cover geometry | tpl/cover_page.tex:17; tpl/cover_page_black.tex:115; tpl/resume.tex:16 | `page.geometry` | `\newgeometry{bottom=25mm,left=20mm,top=15mm,right=20mm}`, `\restoregeometry`; back cover `bottom=25mm,left=15mm,top=20mm,right=15mm` |
| running head and foot | tpl/isipfe.cls:104,267-274 | `hf.fancyhdr` | `\fancyhf{}`, head rule 0.3pt, foot rule 0.3pt, `\lhead{\nouppercase{\leftmark}}`, `\rfoot{\centering\thepage}`, `\pagestyle{fancy}` |
| named page styles | tpl/isipfe.cls:278-348 | `hf.fancyhdr` | `frontmatter` (foot rule 0.3pt, `\fancyfoot[r]{\footnotesize\thepage}`), `lscape` (empty), `plain` (foot rule, centred footnotesize number), `cover` (centred "Année Universitaire" + year), `backcover` (`\color{isiBlue}`, `\rule` lines, French and Arabic address lines in `\makebox[\textwidth][c]`, `\headheight` and `\footskip` 0mm) |
| choosing a page style | main.tex:35-52; tpl/cover_page.tex:16; tpl/signatures.tex:1; tpl/resume.tex:15 | `hf.pagestyle-kernel` | `\thispagestyle{frontmatter}`, `{cover}`, `{empty}`, `{backcover}` |
| running-head marks | introduction.tex:3; conclusion.tex:3; annexes.tex:3 | `hf.pagestyle-kernel` | `\markboth{...}{}` |
| page numbering | main.tex:33 | `pgnum.pagenumbering` | `\setcounter{page}{1}` after the covers |
| line spacing, indent | tpl/isipfe.cls:96-97,99 | `sp.setspace`, `sp.lengths` | `\setstretch{1.6}`; `\parindent` 12mm |
| penalties | tpl/isipfe.cls:79 | `sp.penalties` | `\brokenpenalty=10000` |
| hyphenation off | tpl/isipfe.cls:86 | `sp.hyphenat` | `hyphenat` option `none` |
| float page fraction | tpl/isipfe.cls:83 | `fig.placement` | `\floatpagefraction` 0.8 |
| encodings and faces | tpl/isipfe.cls:111-112 | `font.fontenc-t1` | `inputenc` utf8, `fontenc` T1; no text-face package, default Computer Modern |
| size and shape switches | tpl/cover_page.tex:26,47-49; tpl/resume.tex:23,43 | `font.size-commands`, `mark.kernel` | `\footnotesize`, `\large`, `\LARGE`, `\huge`, `\Huge`; `\textbf`, `\textsc`, `\textit`, `\scshape`, `\bfseries` |
| colour | tpl/isipfe.cls:182-183,316; tpl/cover_page.tex:72,114 | `color.xcolor` | option `table`; `\definecolor{isiBlue}{RGB}{31, 78, 121}`; `\color{isiBlue}` |
| coloured-table option | tpl/isipfe.cls:182 | `tbl.colortbl` | `xcolor[table]` only; no coloured cell in the sample |
| languages | tpl/isipfe.cls:116,120; tpl/new_commands.tex:103; tpl/resume.tex:21,41,61 | `lang.babel` | `[english,arabic,french]`, `\frenchbsetup{LowercaseSuperscripts=false}`, `\selectlanguage{french|arabic|english}`; `\textLR` `\textAR` provider not shown in the zip |
| quotation marks | tpl/isipfe.cls:121 | `lang.csquotes` | load-only |
| section spacing | tpl/isipfe.cls:89-92 | `head.titlesec` | `\titlespacing*` section 7mm/12pt/8pt, subsection 15mm/12pt/8pt, subsubsection 18mm/12pt/6pt (no `\titleformat`) |
| chapter head | tpl/isipfe.cls:208-233 | `head.titlesec`, `sp.rule`, `toc.etoc` (as the reduction, see Bespoke code) | numbered: `\vspace*{30\p@}`, centred line of `\thickhrulefill` quad `\scshape\bfseries\textit{\@chapapp{} \thechapter}` quad `\thickhrulefill`, `\hrule`, `\Huge\bfseries` title, `\hrule`, `\vskip 50\p@`, then `\minitocsection`, `\thispagestyle{empty}`, `\newpage`; starred: `\huge\textbf{#1}` then `\vskip 1cm` |
| heading depth | main.tex:39-40 | `num.secnumdepth` | secnumdepth 3, tocdepth 2 |
| unnumbered headings | dedicaces.tex:1; remerciement.tex:1; acronymes.tex:1; chap_01.tex:2,97 | `head.kernel` | `\chapter*{...}`, `\section*{...}`, `\section[short]{long \cite{..}}` (chap_01.tex:9) |
| section number print | tpl/isipfe.cls:193-195 | none (BESPOKE/class) | `\renewcommand{\thesection}{\csname filterminitoc \endcsname{\arabic{chapter}.}\arabic{section}}` |
| cover page | tpl/cover_page.tex:16-118; tpl/cover_page_black.tex:16-115 | `front.titlepage-env`, `box.minipage`, `box.tcolorbox`, `fig.graphicx`, `box.fancybox`, `sp.manual-space` | logos in `minipage` 0.2/0.6/0.18\columnwidth; nested `tcolorbox` for the title (`colframe=isiBlue,colback=white,boxrule=0pt,toprule=3pt,bottomrule=3pt,arc=0pt,...`, inner `toprule=1pt,bottomrule=1pt,enlarge bottom by=-0.9mm,auto outer arc`, cover_page.tex:76-77); `\fbox` with `\fboxrule=2.5pt` around the company logo (cover_page.tex:114); title and author read from `\@title` and `\@author` (cover_page.tex:68,79); black variant omits `colframe` (cover_page_black.tex:73-74) |
| signature page | tpl/signatures.tex:3-35 | `box.tcolorbox`, `box.minipage` | `colback=white,boxrule=5pt,arc=10pt,height=105mm` in `minipage` 1\columnwidth, two boxes |
| dedication | dedicaces.tex:1-16 | `front.dedication`, `sp.ragged` | `\chapter*{\Huge Dédicaces}`, `\raggedright`, `flushright` author |
| acknowledgements | remerciement.tex:1-10 | `front.dedication` | `center` with `\it \Large` |
| three-language abstract | tpl/resume.tex:18-76 | `box.minipage`, `lang.babel`, `abs.keywords`, `list.kernel` | `changemargin{3mm}{0cm}`, `minipage` 0.96\columnwidth, headings `\LARGE\textbf`, text `\small` or `\large`, keyword line `\textbf{Mots clés : }` |
| contents lists | main.tex:42,46,48 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables` |
| chapter mini-contents | tpl/isipfe.cls:186-190; main.tex:41,43 | `toc.etoc` | `minitoc[french]`, `\mtcsettitle{minitoc}{Plan}`, `\setcounter{minitocdepth}{1}`, `\mtcsetrules{minitoc}{off}`, `\mtcsetoffset{minitoc}{-1.0em}`, `\dominitoc`, `\adjustmtc` |
| hand-made contents lines | introduction.tex:2; conclusion.tex:2; annexes.tex:2,5-6,12,16,38,40 | `toc.kernel` | `\addcontentsline{toc|lot|lof}{...}`, `\addtocontents{lot}{\vspace{3.8mm}}` |
| appendix | annexes.tex:1-47 | `head.kernel`, `num.counters` | `\chapter*{Annexes}`, `\stepcounter{chapter}`, hand-numbered `\section*{Annexe 1.~...}`; `\appendix` is not used |
| bullet lists | introduction.tex:10-14,19-24; conclusion.tex:19-25 | `list.kernel`, `list.enumitem` | `itemize`; `[label=\textbullet,font=\normalsize]` (conclusion.tex:19); `enumitem` loaded (cls:154) |
| indented block | tpl/new_commands.tex:12-18 | `list.kernel`, `sp.lengths` | `list` with `\leftmargin` and `\rightmargin` set from two arguments (`page.adjustwidth` is the published equivalent) |
| abbreviation list | tpl/isipfe.cls:155-179; acronymes.tex:8-22 | `struct.datatool`, `list.kernel`, `box.minipage` | database `list`, key `sortlabel`, `\DTLsort`, `\DTLforeach*`; each item = three `minipage` of 0.1, 0.05, 0.85 \columnwidth (label, "=", text) |
| figures | chap_01.tex:16-21; annexes.tex:43-47 | `fig.graphicx`, `box.fancybox`, `cap.kernel` | `figure[htpb]`, `\frame{\includegraphics[width=0.5\columnwidth]{Logo_Entreprise}}`, `\caption`, `\label`; annex figure has a hand-set bold caption line |
| float package, paths | tpl/isipfe.cls:351-353; main.tex:14 | `fig.float`, `fig.graphicx` | `graphicx`, `graphics`, `float` loaded; `\graphicspath{{./img/}}` |
| caption style | tpl/isipfe.cls:237-254 | `cap.caption` | table: `labelfont=bf`, `name=Tableau`, `justification=justified`, `singlelinecheck=false`, `labelsep=colon` (set after `newline`), `skip=\medskipamount`; figure: `name=Figure`, `justification=centering`, same others |
| long tables | chap_01.tex:34-91; annexes.tex:21-33 | `tbl.longtable` | column spec `\|p{.20\textwidth}\|p{.60\textwidth}\|`, `\caption` and `\label` then `\\` (chap_01.tex:38-39), `\hline` rows; annex table has no caption |
| column types, loaded table packages | global_config.tex:18-20; tpl/new_commands.tex:109 | `tbl.tabular`, `tbl.multirow` | `\newcolumntype{L}{>{\raggedright\arraybackslash}}` and R, C (unused in the sample); `array`, `longtable`, `multirow` loaded |
| page-flow helpers | tpl/new_commands.tex:95-99,108,112; tpl/cover_page.tex:118 | `pg.afterpage`, `pg.break`, `pg.landscape` | `\afterpage{\blankpage}`; `\blankpage` = `\null\thispagestyle{empty}\addtocounter{page}{-1}\newpage`; `pdflscape` loaded, not used |
| other loaded packages | tpl/new_commands.tex:110,113-114 | `font.icons`, `fig.rotating`, `fig.wrapfig` | `pifont`, `rotating`, `wrapfig` loaded, no call found |
| bibliography | tpl/isipfe.cls:122-148; main.tex:77; introduction.tex:5; chap_01.tex:9 | `bib.biblatex-bibtex` | `PassOptionsToPackage` with `backend=biber,language=auto,style=ieee,sorting=none`, then `\usepackage[backend=bibtex]{biblatex}` (the later load names bibtex), `\addbibresource{biblio.bib}`, `\printbibliography[heading=bibintoc]`, `\cite` |
| index | main.tex:23 | `idx.makeidx` | kernel `\makeindex` only; no `\printindex` in the zip |
| cross-references | chap_01.tex:13,20,39 | `xref.kernel` | `\ref`, `\label` |
| file inclusion | main.tex:18,26,29,30 | `struct.input` | `\input`, `\include{tpl/cover_page_black}` |
| manual layout | tpl/cover_page.tex:18,44,70; introduction.tex:5,16 | `sp.manual-space`, `sp.ragged` | `\hspace{-47pt}`, `\vskip1.5cm`, `\\`, `center`, `\raggedright` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `isipfe` | tpl/isipfe.cls:13-353 | yes, except the row below | `class.book` plus the component ways in the map; the `\RequirePackage` and `\usepackage` lines are published packages with options |
| `\thesection` / `\filterminitoc` / `\minitocsection` | tpl/isipfe.cls:193-195,227 | no | hand-rolled switch: `\filterminitoc` is the identity, `\minitocsection` makes it swallow its argument inside a group, and `\thesection` reaches it through a `\csname` whose name ends in a space (that space seems to defer the expansion to the moment the contents file is read; not compiled); `toc.etoc` has no option for number format, so no lib way expresses the per-context number |
| chapter head `\@makechapterhead`, `\@makeschapterhead`, `\thickhrulefill` | tpl/isipfe.cls:208-233 | yes in principle, caveat | `head.titlesec` `\titleformat{\chapter}[display]` with the label line using `sp.rule` (`\leaders\hrule height 1.2ex \hfill`, a bare leader), `\titlespacing*` for 30pt and 50pt, after-code `\minitoc` `\thispagestyle{empty}` `\newpage`, and `\titleformat{name=\chapter,numberless}` for the starred head; the `\minitocsection` call carries the blocker above |
| `acronyms` environment, `\sortitem` | tpl/isipfe.cls:156-179 | yes | `struct.datatool` calls (`\DTLnewdb`, `\DTLnewrow`, `\DTLnewdbentry`, `\DTLsort`, `\DTLforeach*`) around `list.kernel` and three `box.minipage`; the emitter may also write the sorted `itemize` directly |
| booleans `isBinomal`, `wantToTypeCompanyAddress` with `\ifthenelse` | tpl/isipfe.cls:17-26,317-333; tpl/cover_page.tex:61-69; tpl/resume.tex:36-39,56-59; global_config.tex:82 | yes | each picks one of two static fragments; the emitter writes the chosen branch (isBinomal false, address block on) |
| field setters `\diplomaName` ... `\companyAddressFR` | tpl/new_commands.tex:24-92; global_config.tex:25-88 | yes | `\gdef` store and read of strings: inline the strings from global_config.tex into the cover, signature and back-cover text |
| `changemargin` | tpl/new_commands.tex:12-18 | yes | kernel `list` with `\leftmargin` and `\rightmargin` (`list.kernel`, `sp.lengths`) |
| `\blankpage` | tpl/new_commands.tex:95-99 | yes | `pg.afterpage`, `hf.pagestyle-kernel`, `num.counters`, `pg.break` as listed |
| `\fancypagestyle` bodies | tpl/isipfe.cls:278-348 | yes | `hf.fancyhdr` with `sp.rule`, `sp.manual-space`, `color.xcolor` |
| `\newcolumntype` L, R, C | global_config.tex:18-20 | yes | `array` declarations, `tbl.tabular` |
| `pstricks` load | tpl/isipfe.cls:206 | not code | load-only, no PSTricks command appears anywhere in the zip; `art.pstricks` is not used for artwork; also `xspace` loaded (tpl/isipfe.cls:108) and never called |

## Content-opaque
none besides shipped images: logos `img/LogoISI.png`, `img/Logo_UTM.png`, `img/Logo_Entreprise.jpg` and the black variants (tpl/cover_page.tex:21,42,114; tpl/cover_page_black.tex:20,41,111; chap_01.tex:18). Arabic, French and English abstract text and the bibliography entries are content.

## Lib changes
- New ways proposed: none. Considered: `xspace` (loaded, never called; lib v4 rejected `sp.xspace`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
