yes

# 0062-sp5lma-ee-dyplom: EE-dyplom (WUT Faculty of Electrical Engineering thesis template)

- Unverified: read from the source, not compiled.
- Source: Source/0062-sp5lma-ee-dyplom/ (origin: https://codeload.github.com/SP5LMA/EE-dyplom/zip/refs/heads/main; licence: CC-BY-4.0, README.md:61, LICENSE present)
- Kind: thesis
- Lib: v1
- Engine: pdfLaTeX-compatible (the class is dual-engine: its `\ifXeTeX` branch loads mathspec, xltxtra, polyglossia; the sample's magic comment says pdflatex, EE-dyplom.tex:1; README.md:32 recommends XeLaTeX)
- Look carried by: zip-local (EE-dyplom.cls loads `book`, a stack of published packages, and a few straight-line macros; the sample preamble only sets class options and metadata fields)
- Class origin: zip-local (ctan.org/pkg/ee-dyplom returned 404; the zip is one WUT staff member's GitHub project, not a publisher or university release; it loads published `book`)
- Main file: EE-dyplom.tex (other samples: none; the body chapters are tekst/wstep.tex, analiza.tex, realizacja.tex, podsumowanie.tex, appendices.tex, loaded by `\input` at EE-dyplom.tex:74-77 and cls:773)
- Read: main yes, zip-local classes and styles all (EE-dyplom.cls 1-774; every tekst/*.tex; Makefile, READMEs; not read: EE-dyplom.bib and src/Keccak-inplace32BI.c, which are content)

## Verdict
Yes, with five judgement calls stated below. The whole class reduces to `class.book`, published packages with parameters, and short straight-line macros made only of kernel commands: no output routine, no box algorithm, no expl3 or Lua. Judgement calls: (1) the `\strcmp` option dispatch on `thesis=` and `faculty=` is finite and is resolved when the emitter picks one variant, so it does not need copying; (2) the `easyappendix` environment and its `app` contents list reduce to kernel commands plus a new list-of type (`toc.tocbasic`); (3) the banner images on the title page are shipped bitmaps inserted by `\includegraphics`, which I treat as assets, not TeX-drawn ART; (4) the class counts as zip-local, so its code was judged, not taken as a published class; (5) `menukeys` and `polski` are proposed as new ways. A stricter reading of (1) or (3) would flip this to `no`.

## Blockers
none

## Class setting
- Class: `class.book` (loaded by the zip-local wrapper at EE-dyplom.cls:34) options: a4paper, 11pt, twoside, openright. The wrapper `EE-dyplom` itself takes the string keys `thesis=inz|mgr|bsc|msc` and `faculty=arch|gik|ee|wip` through `kvoptions` (cls:50-54); the sample uses `thesis=inz,faculty=ee` (EE-dyplom.tex:9).
- Class-native vocabulary used (all zip-local, none published): `\instytut` `\kierunek` `\specjalnosc` `\album` `\promotor` `\engtitle` `\longdate` (EE-dyplom.tex:30-39), `\streszczeniepracy` `\slowakluczowe` `\thesisabstract` `\thesiskeywords` (:45-60), `\frontpages` (:69), `\bibliografia` (:81), `\acronymslist` (:87), `\easyappendices` (:93), environment `easyappendix` (tekst/appendices.tex:2, 460, 464). Standard `\title` `\author` `\date` are used too (:33-38).

## Component map
Rows marked "loaded" are loaded by the class (cls line) but not exercised by the sample body.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | cls:34 | `class.book` | a4paper, 11pt, twoside, openright |
| paper, size, sides | cls:34 | `page.class-options` | a4paper, 11pt, twoside, openright |
| page geometry | cls:155-161 | `page.geometry` | a4paper, includehead, includefoot, inner=30mm, outer=20mm, vmargin=25mm |
| line spacing | cls:169, 181 | `sp.setspace` | `\setstretch{1.2213}` (other values commented, cls:172-190); the title page overrides locally with `\linespread{1.15}` (cls:629) |
| paragraph shape | cls:231-232 | `sp.lengths` | parindent=0.5cm, parskip=0em |
| widows, clubs, hyphen penalty | cls:309-310, 317 | `sp.penalties` | widowpenalty=20000, clubpenalty=20000, hyphenpenalty=1000 |
| line-breaking tolerance | cls:316, 318-321 | `sp.hyphenat` | pretolerance=1000, tolerance=2000, emergencystretch=.618em, righthyphenmin=4, lefthyphenmin=4 (raw TeX parameters, read in the `\sloppy` family) |
| bottom alignment | cls:311 | `pg.flush` | `\raggedbottom` |
| blank pages truly empty | cls:220 | `pg.emptypage` | load-only |
| page breaks | cls:251, 673, 685, 702, 735, 758 | `pg.break` | `\cleardoublepage` |
| running heads and feet | cls:197-215 | `hf.fancyhdr` | `\fancyhf{}`; style `plain`: foot `[RO,LE]{\thepage}`, no rules; style `headings`: headrulewidth=1pt, headoffset=0cm, head `[LE]` italic `\nouppercase{\leftmark}`, `[RO]` italic `\nouppercase{\rightmark}`, foot `[RO,LE]{\thepage}`, headheight=16pt; `\pagestyle{headings}` |
| page style switching | cls:631, 674, 691, 724, 736, 745 | `hf.pagestyle-kernel` | `\pagestyle{empty}`, `\thispagestyle{empty}`, `\pagestyle{plain}`, `\pagestyle{headings}` |
| text face | cls:102, 105 | `font.helvet` | package `sourcesanspro`, option `default` (pdfTeX) or `default,oldstyle` (XeTeX); a sans text-face package is the parameter, as in the lib's `font.helvet` |
| default family | cls:106, 109 | `font.family-default` | `\familydefault` = `\sfdefault` |
| encodings | cls:107, 143-145 | `font.fontenc-t1` | fontenc T1, inputenc utf8, `\DeclareUnicodeCharacter{00B0}{$^{\circ}$}`, `{00D7}{x}` |
| XeLaTeX font stack | cls:100-101, 114-116 | `font.fontspec` | `mathspec` (loads fontspec; no `\setmathsfont` call), `xltxtra`; XeTeX branch only |
| font size switches | cls:643-646, 762-766 | `font.size-commands` | `\large`, `\LARGE`, `\normalsize`, `\Huge` |
| language (pdfTeX) | cls:137-142 | `lang.babel` | `[english,polish]` or `[polish,english]` by `\locallang`; `\selectlanguage{polish|english}` |
| Polish support package | cls:135 | `lang.babel` | `\RequirePackage[MeX]{polski}` before babel |
| language (XeTeX) | cls:122-133 | `lang.polyglossia` | `\setdefaultlanguage{polish|english}`, `\setotherlanguage{polish}`, `{english}` |
| colours | cls:346-358 | `color.xcolor` | options usenames, dvipsnames; `\definecolor` RGB x9: ciemnozielony 0,104,114; granatowy 0,74,108; bezowy 200,193,182; mietowy 192,209,200; niebieski 52,102,175; zolty 231,162,23; jasnoczerwony 230,51,18; ciemnoczerwony 154,15,6; fioletowy 94,49,86 |
| PDF links and metadata | cls:397-418 | `meta.hyperref` | unicode, colorlinks=true, linkcolor=granatowy, citecolor=ciemnoczerwony, filecolor=granatowy, urlcolor=granatowy, linktoc=all, pdfstartview=FitH, pdfnewwindow, pdftoolbar, pdfmenubar, pdffitwindow=false |
| external links, anchors | tekst/analiza.tex:11, 13; cls:253 | `xref.hyperref` | `\href`, `\phantomsection` |
| cross-references | tekst/wstep.tex:2, 25, 38, 48; appendices.tex:3, 138 | `xref.kernel` | `\label`, `\ref`, `\pageref` |
| title, author, date fields | EE-dyplom.tex:33, 36, 38 | `front.maketitle` | `\title{...}`, `\author{...}`, `\date{2077}` feed the hand-laid page below |
| title page | cls:627-653 | `front.titlepage-env` | hand-laid in a `center` block: `\thispagestyle{empty}`; `\includegraphics[width=\textwidth]` of the faculty banner; `\vskip 3em`; institute; `\vskip 3em`; `\includegraphics[width=\linewidth]` of the thesis-type banner; `\vskip 1em`; "na kierunku <kierunek>"; `\vskip .5em`; "w specjalności <specjalność>"; `\vskip 3em`; `\large` title; `\vskip 3em`; `\LARGE` author; `\normalsize`; "numer albumu <album>"; `\vskip 2em`; "promotor" `\\` name; `\vfill`; "WARSZAWA <date>" |
| title page spacing | cls:634-651 | `sp.manual-space` | `\vskip` 3em, 1em, .5em, 2em, `\vfill` |
| title page images | cls:633, 637 | `fig.graphicx` | gfx/HeadEEPL.png and gfx/inzhead.png, shipped bitmaps (assets) |
| abstract pages | cls:672-703 | `pg.break` | per page: `\cleardoublepage`, `\thispagestyle{empty}`, centred bold `\large` title, bold word "Streszczenie" or "Abstract", text, `\vskip 2em`, keyword line, `\cleardoublepage`; no `abstract` environment is used, the page is hand-laid |
| keyword lines | cls:683, 700 | `abs.keywords` | `\noindent\textbf{Słowa kluczowe: }` / `\textbf{Keywords: }` |
| abstract order | cls:707-715 | `pg.break` | Polish page then English for `inz`/`mgr`; English first for `bsc`/`msc` (an emit-time choice) |
| table of contents | cls:720, 734 | `toc.kernel` | `\tableofcontents`; `\AtBeginDocument{\addtocontents{toc}{\protect\thispagestyle{empty}}}` |
| list of figures, tables | EE-dyplom.tex:89, 91 | `toc.kernel` | `\listoffigures`, `\listoftables` |
| list entries in toc | cls:271 | `toc.etoc` | `tocbibind`, option nottoc |
| headings | tekst/wstep.tex:1, 31, 70; appendices.tex:18 | `head.kernel` | `book` defaults for `\chapter`, `\section`, `\paragraph`; `titlesec` block is commented out (cls:516-526) |
| continuous numbering | cls:279-282, 723 | `num.counters` | `\counterwithout{figure}{chapter}`, `{table}`, `{equation}`; `\counterwithout{lstlisting}{chapter}` inside `\frontpages` |
| appendices | cls:756-774, tekst/appendices.tex:2, 460, 464 | `num.counters` | `\newcounter{easyappendix}[chapter]`, `\refstepcounter` (see Bespoke code) |
| list of appendices | cls:760, 772 | `toc.tocbasic` | new list type `app` (`\DeclareNewTOC{app}` plus entry style) and `\addcontentsline{app}{chapter}{...}`, `\@starttoc{app}` as the kernel form |
| appendix heading look | cls:762-766 | `mark.kernel` | `\Huge\textbf{<appendixname> <n>}`, `\par\medskip`, `\Huge\textbf{title}`, `\par\bigskip`, with `\dotfill` leader (cls:760, `sp.rule`) |
| bullet lists | cls:534-542; tekst/wstep.tex:6-14, 57-62 | `list.enumitem` | `\setlist[itemize,1]{nosep, topsep=.25em}`; level 2 `nosep,label=--`; level 3 `nosep,label=-`; level 4 `nosep,label=$\cdot$` |
| list environments | tekst/wstep.tex:6; appendices.tex:31-34 | `list.kernel` | `itemize`, with `\item[--]` |
| footnote | tekst/appendices.tex:309 | `fn.kernel` | one `\footnote` holding an `\href` |
| text marks | tekst/appendices.tex:21-25 | `mark.kernel` | `\textbf`, `\textit`, `\texttt`, `\underline`, `\emph` |
| key, menu, path marks | cls:490-493; appendices.tex:40, 42, 371-390 | `mark.menukeys` | `\RequirePackage[os=win]{menukeys}`; `\renewmenumacro{\menu}[>]{roundedmenus}`, `{\directory}{pathswithfolder}`, `{\keys}{shadowedroundedkeys}`; body `\keys{}`, `\menu{}`, `\directory{}` |
| display maths | cls:95; tekst/appendices.tex:126-296 | `math.amsmath` | `equation`, `equation*`, `align`, `gather`, `bmatrix`, `vmatrix`, `\pmb`, `\nonumber`, `\label` |
| math symbols | cls:94, 96, 98; appendices.tex:149, 266-269 | `math.amssymb` | amsfonts, amssymb, and `esint` (`\oiint`, `\oint`); esint read as a symbol-set package in this family |
| theorems | cls:97 | `thm.amsthm` | loaded only; no `\newtheorem` in the zip |
| figures | tekst/wstep.tex:22-26; appendices.tex:99-103; cls:332-333 | `fig.graphicx` | `figure[!htbp]` and `[!ht]`, `\centering`, `\includegraphics[width=0.618\linewidth]`, `[height=0.25\textheight]`; `\graphicspath{{gfx/}{rysunki/}}` |
| subfigures | cls:298 | `fig.subcaption` | loaded only |
| tables | tekst/appendices.tex:64-75 | `tbl.tabular` | `table[!ht]`, `\centering`, `tabular{p{2.5cm}c\|l}`, `\hline\hline` |
| table packages | cls:338-341 | `tbl.multirow` | loaded only: `multirow`; `longtable` (`tbl.longtable`), `colortbl` (`tbl.colortbl`), `multicol` (`cols.multicol`) likewise loaded only |
| captions | cls:295-297 | `cap.caption` | format=hang, labelfont=bf, labelsep=period, font=small, justification=raggedright, singlelinecheck=true |
| caption command | tekst/wstep.tex:24; appendices.tex:65 | `cap.kernel` | `\caption` (below figures, above the table) |
| code listings | cls:423-485 | `code.listings` | `\lstdefinestyle{basiclststyle}` then `\lstset{style=basiclststyle}`: backgroundcolor mietowy!10!white, basicstyle `\ttfamily\small`, keywordstyle `\bfseries` ciemnoczerwony, commentstyle mietowy!50!black, identifierstyle niebieski, stringstyle fioletowy, numbers=left, numberstyle `\tiny`, numbersep=5pt, stepnumber=1, frame=lrbt, frameround=ffff, xleftmargin=4ex, breaklines, captionpos=b, tabsize=2, aboveskip=1.46557em, belowskip=1em, inputpath=src, escapeinside, `literate` table of accented letters |
| listing body use | tekst/appendices.tex:315, 341, 358, 398, 432 | `code.listings` | `lstlisting[language=Python|C|bash, caption, label, backgroundcolor, numbers=none]`; `\lstinputlisting[firstline=31, lastline=50, firstnumber=31, caption=\lstname]{Keccak-inplace32BI.c}` |
| bibliography | cls:242-258; tekst/analiza.tex:7 | `bib.biblatex-biber` | backend=biber, style=ieee, sorting=none, citestyle=numeric-comp; `\addbibresource{EE-dyplom.bib}`; `\DeclareNameAlias{default}{family-given}`; `\printbibliography` inside `\sloppy`; `\cite`, `\cite[s.~38]{}` |
| acronyms and symbols | cls:74-82, 742-751; tekst/glossary.tex:2-32 | `idx.glossaries` | `glossaries` options acronym, symbols, nopostdot; `\setglossarysection{section}`; `\makeglossaries`; `\loadglsentries{tekst/glossary}`; `\printglossary[type=\acronymtype,title={}]`, `[type=symbols,title={}]`; body `\gls`, `\acrshort`, `\acrlong`, `\acrfull` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option dispatch `thesis`, `faculty` | cls:41-68, 586-625 | yes (judgement) | `kvoptions` + `\ifnum\strcmp` only pick one of 4 thesis types x 4 faculties: language PL/EN, strings, banner file names. Evaluate once at emit time for the chosen variant (inz/ee: Polish, `inzhead.png`, `HeadEEPL.png`) and write the constants; the other variants are other parameter values of the same ways. No layout is computed. |
| `iftex` engine switch, `\strcmp` alias | cls:41-45, 100-146 | yes | Two branches of the same ways under an engine tag: pdfTeX (`babel`, `polski`, `inputenc`, T1) and XeTeX (`polyglossia`, `mathspec`, `xltxtra`). Emit the branch for the target engine. |
| metadata setters | cls:564-584, 658-669 | yes | `\newcommand{\instytut}[1]{\newcommand{\@instytut}{#1}}` and the like only store text; inline the values into the title page and abstract pages. `\longdate` is stored and never printed (cls:582). |
| `\maketitle` redefinition | cls:627-653 | yes | A fixed sequence of `\includegraphics`, `\vskip`, size switches and text inside `center`; written as the hand-laid block in the component map (`front.titlepage-env`, `fig.graphicx`, `sp.manual-space`, `font.size-commands`). |
| abstract pages | cls:672-715 | yes | `\newcommand` pages made of `\cleardoublepage`, `\thispagestyle`, `center`, `\textbf`, `\vskip`; PL/EN order is the emit-time choice. |
| `\frontpages` | cls:720-737 | yes | Fixed call sequence: `\counterwithout{lstlisting}{chapter}`, `\pagestyle{empty}`, title page, abstract pages, `\tableofcontents`, `\cleardoublepage`, `\pagestyle{headings}`; the `\addtocontents{toc}{\protect\thispagestyle{empty}}` hook is kernel. |
| `\bibliografia` | cls:250-258 | yes | `\cleardoublepage\phantomsection\addcontentsline{toc}{chapter}{\refname}{\sloppy\printbibliography}`; biblatex plus kernel. |
| `\acronymslist` | cls:742-751 | yes | `\chapter*{<title>}`, `\pagestyle{plain}`, `\addcontentsline`, two `\printglossary` calls: `idx.glossaries` parameters and kernel. The title string is PL/EN by option (cls:78-82). |
| `easyappendix` environment, `\easyappendices` | cls:756-774, 501-509 | yes (least declarative item) | Straight-line kernel commands, no conditionals: `\cleardoublepage`, `\refstepcounter{easyappendix}`, `\addcontentsline{app}{chapter}{...\dotfill}`, `\par\bigskip`, `\Huge\textbf{...}`, `\normalsize`. The `app` file is a new list-of type, written with `toc.tocbasic` (`\DeclareNewTOC`) instead of `\@starttoc{app}`. The `\let\appendixname\appendixprefix` re-assertion (cls:509, 769) is a string override and becomes the literal word. The counter is a plain `\newcounter{easyappendix}[chapter]` that never resets in the sample (no `\chapter` between appendices), giving 1, 2, 3. |
| `\lstdefinestyle` and `literate` table | cls:424-485 | yes | `code.listings` keys and values, listed in the component map. |
| `\renewmenumacro` calls | cls:491-493 | yes | Choose preset menukeys style names (`mark.menukeys`). |
| `\fancypagestyle` redefinitions | cls:199-215 | yes | `hf.fancyhdr` parameters in the map. |
| `\DeclareUnicodeCharacter` | cls:144-145 | yes | `font.fontenc-t1` family (kernel inputenc declaration; `$^{\circ}$` and `x` as replacements). |
| `\docparskip`, `etoolbox` | cls:499, 535-536 | yes | No effect on output: the length is defined and never used; `etoolbox` is loaded and none of its commands is called (grep of cls, tex and tekst). Nothing to emit. |
| language string tables | cls:78-82, 501-507, 599-614 | yes | Strings chosen by `\locallang` (PL/EN); the emitter writes the chosen set. |

## Content-opaque
none (equations, listing text, the 13-entry bibliography and the .c file are plain content; the glossary file is data for `idx.glossaries`)

## Lib changes
- New ways proposed:
  - `lang.babel`: package `polski` (CTAN, in TeX Live), pdfLaTeX-compatible (the class uses polyglossia instead under XeLaTeX). W1: on CTAN. W2: options choose the font encoding and back end (`MeX`, `QX`, `OT4`, `T1`, babel/polyglossia). W3: Polish language support for any document. W4: one preamble line `\usepackage[MeX]{polski}` before babel. A consolidator could fold it into `lang.babel` as a language-helper family, as `font.helvet` was folded into `font.helvet`; I propose it separately because it is a distinct package with its own options.
  - `mark.menukeys`: package `menukeys` (CTAN), pdfLaTeX-compatible (it loads tikz internally; the template supplies only style names and the `os=` option). W1: on CTAN. W2: `os=win|mac|linux`, `\renewmenumacro{\menu|\keys|\directory}[sep]{style name}`. W3: inline key, menu and path markup for any software documentation. W4: preamble `\usepackage[os=win]{menukeys}` plus `\renewmenumacro` lines, and body wrappers `\keys{...}`, `\menu{...}`, `\directory{...}` around node content. Not ART: the boxes are the package's own presets, not drawings authored by the template.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Build: Makefile:1-13 runs xelatex or pdflatex, then `biber`, then `makeglossaries`, then two more passes. Biber and makeglossaries are the standard tool steps of `bib.biblatex-biber` and `idx.glossaries`, so I do not count them as EXTERNAL. The `sololetters` target (Makefile:15-16) runs `sed` over tekst/*.tex to insert `~` after single-letter words; it is optional, already applied to the shipped text (tekst/appendices.tex:44), and generates no `.tex`, so it is not a blocker.
- `listings` with `language=bash` and `lstinputlisting` are pure TeX; no `minted`, no shell escape.
- Asset note (unverified): the banner file name is built as `Head` + option value + `PL.png` (cls:616-620), the sample passes `faculty=ee` (EE-dyplom.tex:9) while the shipped file is `gfx/HeadEEPL.png`; on a case-sensitive file system this may not resolve. A portability note about an asset, not a template blocker.
- Source defect, content only: `\href{https://tableconvert.com/latex-generator}` at tekst/appendices.tex:96 has no link-text argument.
- tekst/symbols.tex is a hand-written alternative symbol list that is not loaded (cls:750 is commented out).
- Nothing in the zip addresses an AI; no instructions were found to quote.
