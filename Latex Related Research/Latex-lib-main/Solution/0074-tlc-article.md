yes

# 0074-tlc-article: tlc-article (article-based class for formal documents, with a Getting Started Guide sample)

- Unverified: read from the source, not compiled.
- Source: Source/0074-tlc-article/ (origin: https://mirrors.ctan.org/macros/latex/contrib/tlc-article.zip; licence: BSD-3-Clause, LICENSE:1)
- Kind: report (a formal document with title page, abstract, table of contents and a status/version header; the sample is a user guide for the class)
- Lib: v1
- Engine: pdfLaTeX-compatible (pdfTeX-safe loads only: `inputenc`/`fontenc`, `lmodern`; `csvsimple[l3]` is expl3 but runs under pdfTeX; no `fontspec`, no Lua)
- Look carried by: class (page, fonts, header/footer, table of contents, colours, listing style and links are all in `tlc-article.cls`; the sample has no preamble, and `data/additional-layout.tex` adds only text aliases and a CSV table style)
- Class origin: ctan (the zip is from CTAN `macros/latex/contrib`; README.md:23 says `tlmgr install tlc-article`; the zip's own `.cls` is that release, v1.2.43, tlc-article.cls:18)
- Main file: tlc-article.tex (other samples: none; `data/additional-layout.tex` is a preamble hook the class `\input`s, not a sample)
- Read: main yes, zip-local classes and styles all (tlc-article.cls 535 lines, data/additional-layout.tex 68 lines, data/version.csv, data/required-packages.csv, README.md, LICENSE; `doc/tlc-article.pdf`, `images/titlepage.png` and `data/logo.png` are binary and were not opened)

## Verdict
The class is published on CTAN and in TeX Live, so it is one way, `class.tlc-article`, which loads `class.article` (tlc-article.cls:20-23). An emitter writes `\documentclass[12pt]{tlc-article}` and the class's native commands; the look is the class's, so this is evidence about the class dimension, not about the component ways. Everything else in the zip that is not published (the sample's `\def` aliases and its `\csvstyle`) is a text alias or a longtable layout, and reduces to lib ways written out below. There is no artwork, no tool outside TeX is needed to build the sample, and no new way is proposed.

## Blockers
none

Recorded, not counted (conditional, never exercised by the sample or by the class itself):
- `EXTERNAL/class` (latent) `\tlcGetEnvironmentVariable` runs `kpsewhich` through a shell pipe, `\CatchFileEdef{\temp}{"|kpsewhich --var-value #2 ..."}` (tlc-article.cls:299-318). Nothing calls it: not the class, not `tlc-article.tex`, not `additional-layout.tex` (grep over all three finds only the definition). `catchfile` itself needs no external tool, so this is not the "package loaded unconditionally that needs a tool" case of the pilot ruling. An emitter does not emit it.
- `glossaries` is loaded unconditionally with `acronym,nopostdot,nonumberlist,style=altlist,toc` (tlc-article.cls:45-50) but without `\makeglossaries`, and the sample has no `\gls` or `\printglossary`; so no `makeglossaries`/`makeindex` run is needed to compile. Using it later would need that run.

## Class setting
- Class: `class.tlc-article` options: `12pt` (tlc-article.tex:1). Every option is forwarded to `class.article` by `\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}` (tlc-article.cls:20-23); the class fixes A4 and 1in margins itself (cls:28), so no paper option is needed.
- Class-native vocabulary used: front matter `\tlcTitlePageAndTableOfContents{title}{author}{abstract}` (tex:10-15; cls:372-395); `\tlcVspace` (tex:51 and others; cls:360); `\tlcDarkblue` (cls:245; used through the aliases); `\tlcBeginLandscape` / `\tlcEndLandscape` (cls:232-235, 290-293; named in the text, tex:347-355, never called); column types `L{w}` `C{w}` `R{w}` (cls:205-207; used by the CSV table style, additional-layout.tex:62); `\ER` row end (cls:214, defined, not used); `\inputIfExists` (cls:224, not used); `\tlcDebug` (cls:254-283; the sample overrides the name with an alias, additional-layout.tex:23); file hooks under `data/`: `additional-layout.tex`, `header-footer.tex` (absent), `logo.png`, `version.csv` (cls:182-186, 487-528); header commands `\useDefaultHeaderFooter` `\useLogoFile` `\useTitle` `\useVersionFile` `\useRuler` (cls:402-480), shown as listing text in the sample.

## Component map
Each row names the lib way that realises the part. The class sets the part for the emitter, which reaches all of them with the one `class.tlc-article` line; the parameters are read from the class source so that the look can also be written out by component.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | tlc-article.cls:23; tlc-article.tex:1 | `class.tlc-article` | `\LoadClass{article}`; option `12pt` forwarded |
| base class | tlc-article.cls:20-23 | `class.article` | all options passed through |
| paper, size | tlc-article.tex:1 | `page.class-options` | `12pt` (the sample's only option); paper is set by `geometry` below |
| margins | tlc-article.cls:28 | `page.geometry` | a4paper, top=1.0in, bottom=1.0in, left=1.0in, right=1.0in |
| landscape pages | tlc-article.cls:84, 232-235, 290-293 | `pg.landscape` | `pdflscape` `landscape` environment; `\newgeometry{top=1in,bottom=1in,left=1in,right=1in}` / `\restoregeometry`; helper pair never called in the sample |
| include PDF | tlc-article.cls:78 | `pg.include-pdf` | `pdfpages` loaded, no `\includepdf` in the sample |
| page breaks | tlc-article.tex:60, 157, 314, 518; cls:391, 393 | `pg.break` | `\clearpage`, `\newpage` |
| multi-column | tlc-article.cls:29 | `cols.multicol` | `multicol` loaded, not used in the sample |
| fonts | tlc-article.cls:35 | `font.lmodern` | `lmodern` |
| encodings | tlc-article.cls:36-38 | `font.fontenc-t1` | `textcomp`; `inputenc` `utf8`; `fontenc` `T1`; `\textdegree` used at tex:348 |
| size switches | tlc-article.cls:141, 441, 458-466, 479; tex:88 | `font.size-commands` | `\tiny`, `\footnotesize`, `\large` (header, footer, listings) |
| colours | tlc-article.cls:56, 126-130 | `color.xcolor` | `xcolor[table]`; `backcolour` rgb 0.95,0.95,0.92; `codegray` 0.5,0.5,0.5; `codegreen` 0,0.6,0; `codepurple` 0.58,0,0.82; `darkblue` 0,0,0.5 |
| coloured table rows | tlc-article.cls:56 | `tbl.colortbl` | the `table` option of `xcolor`; no row colours set in the sample |
| hyperlinks | tlc-article.cls:39, 158-177 | `meta.hyperref` | `hyperref[colorlinks]`; `\hypersetup{bookmarksopen=true, linkcolor/citecolor/filecolor/urlcolor=darkblue, link/cite/file/menu/run/urlbordercolor=white!100, linktoc=all, pdfborder={0 0 0 [0 0]}, pdfstartview=FitH, pdfauthor/pdftitle/pdfsubject/pdfkeywords={}}` |
| bookmarks | tlc-article.cls:40 | `meta.bookmark` | `bookmark` loaded; `bookmarksopen=true` |
| URLs | tlc-article.tex:435, 521 | `meta.url` | `\url{...}` through `hyperref` |
| cross-references | tlc-article.tex:77, 95, 256, 368-369, 451 | `xref.kernel` | `\label` `\ref` |
| links in refs | tlc-article.cls:39, 165-166 | `xref.hyperref` | colour links from `hyperref` (no `\autoref`) |
| title, author, date | tlc-article.cls:372-383; tex:10-12 | `front.maketitle` | `\title{...}` `\author{...}` `\maketitle`; date left to the default `\today`; empty title or author gives `\title{}` / `\author{}` (cls:373-383) |
| front-matter macro | tlc-article.cls:372-395; tex:10-15 | `front.class-native` | `\tlcTitlePageAndTableOfContents{title}{author}{abstract}`: `\maketitle`, optional abstract, `\thispagestyle{empty}`, `\clearpage`, `\tableofcontents`, `\clearpage` |
| title restyling | tlc-article.cls:109, 479 | `front.titling` | `titling` loaded; only `\thetitle` is read, in the centre header; no `\pretitle` or `\posttitle` is set |
| abstract | tlc-article.cls:388; tex:13-15 | `abs.kernel` | `\begin{abstract}...\end{abstract}`, omitted when the argument is empty |
| first page style | tlc-article.cls:390 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` on the title page; `\pagestyle{fancy}` (cls:111) |
| header and footer | tlc-article.cls:108, 111, 191-192, 415-480 | `hf.fancyhdr` | `\pagestyle{fancy}`; head L = logo `\includegraphics[width=3cm,height=1cm]{data/logo.png}` (when the file exists), C = `\large\thetitle`, R = `\tiny status \\ date \\ version`; foot L = `\tiny institution`, C = `\tiny permission`, R = `\tiny Page \thepage~of~\pageref{LastPage}`; `\headrulewidth` 0.1pt, `\footrulewidth` 0.1pt, `\headheight` 34pt |
| header image | tlc-article.cls:418 | `fig.graphicx` | `\includegraphics[width=3cm,height=1cm]` inside `\fancyhead[L]` |
| page X of Y | tlc-article.cls:110, 442 | `pgnum.lastpage` | `lastpage`, `\pageref{LastPage}` |
| toc pages style | tlc-article.cls:119-121 | `toc.kernel` | `\AtBeginDocument{\addtocontents{toc}{\protect\thispagestyle{fancy}}}` |
| contents | tlc-article.cls:392; tex:10 (via the macro) | `toc.kernel` | `\tableofcontents` |
| contents leaders | tlc-article.cls:99-100 | `toc.tocloft` | `tocloft`; `\renewcommand\cftsecleader{\cftdotfill{\cftdotsep}}` (dotted leaders for sections) |
| headings | tlc-article.tex:20, 28, 42, 61, 83, 95, 130, 158, 342 | `head.kernel` | article `\section` `\subsection` `\subsubsection*`, unchanged: no `titlesec`, no `\renewcommand` of the heading format |
| appendices | tlc-article.cls:89 | `num.appendix` | `appendix[toc,page]` loaded, no `\appendix` in the sample |
| paragraph indent | tlc-article.cls:73 | `sp.lengths` | `\setlength{\parindent}{0pt}` |
| margin-note width | tlc-article.cls:90 | `sp.lengths` | `\setlength{\marginparwidth}{2cm}` |
| manual space | tlc-article.cls:360; tex:51, 67, 123 | `sp.manual-space` | `\tlcVspace` = `\vspace{3mm}` |
| todo notes | tlc-article.cls:91 | `note.todonotes` | `todonotes` loaded, not used in the sample |
| lists | tlc-article.tex:131-135, 141-145, 455-461 | `list.kernel` | `description`, `enumerate` |
| list options | tlc-article.cls:69; tex:261; cls:259 | `list.enumitem` | `enumitem`; `description[style=nextline]`; `description[align=right,labelindent=5cm]` |
| text marks | tlc-article.tex:29, 44, 185 | `mark.kernel` | `\texttt`, `\textit`; colour text via `\textcolor{darkblue}{...}` (cls:245) |
| code listings | tlc-article.cls:61, 135-153; tex:31-33, 88, 174 | `code.listings` | `\lstdefinestyle{tlcStyle}{backgroundcolor=\color{backcolour}, commentstyle=\color{codegreen}, keywordstyle=\color{magenta}, numberstyle=\tiny\color{codegray}, stringstyle=\color{codepurple}, basicstyle=\footnotesize, breakatwhitespace=false, breaklines=true, captionpos=b, keepspaces=true, numbers=left, numbersep=4pt, showspaces=false, showstringspaces=false, showtabs=false, tabsize=2}`; `\lstset{style=tlcStyle}`; per-listing `language=bash` or `basicstyle=\tiny` |
| verbatim | tlc-article.cls:62 | `code.verbatim` | `spverbatim` (`\spverb`, `spverbatim`: verbatim that breaks at spaces) loaded, not used in the sample |
| figure | tlc-article.tex:73-78 | `fig.graphicx` | `\begin{figure}[h]` `\centering` `\includegraphics{images/titlepage.png}` |
| caption | tlc-article.tex:76 | `cap.kernel` | `\caption{Document Layout}` `\label{fig:layout}`; no `caption` package |
| long table | tlc-article.tex:525; additional-layout.tex:61-66; cls:70 | `tbl.longtable` | `longtable` with column spec `\|L{3cm}\|L{12cm}\|`; head `\hline Name & Description\\\hline\hline\endhead`; each row ends `\\\hline` |
| column types | tlc-article.cls:67, 205-207 | `tbl.tabular` | `array` `\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash}p{#1}}`, `C` with `\centering`, `R` with `\raggedleft` |
| table helpers | tlc-article.cls:71-72, 30 | `tbl.tabularx` | `tabularx` loaded, not used in the sample |
| multirow cells | tlc-article.cls:30, 71 | `tbl.multirow` | `multirow` and `makecell` loaded, not used in the sample |
| glossaries | tlc-article.cls:45-50 | `idx.glossaries` | `glossaries[acronym,nopostdot,nonumberlist,style=altlist,toc]` loaded, not used in the sample |
| pie charts | tlc-article.cls:83 | `art.tikz` | `pgf-pie` loaded for the author's use; the sample draws none (content capability, not template artwork) |

## Bespoke code
None of the class's own code is bespoke under the rubric, because the class is published (class origin ctan). The items below are what the zip adds that is not a published package, plus the class internals worth recording.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| text aliases `\tlcA`, `\tlcAL`, `\tlcBL`, `\tlcDB`, `\tlcEL`, `\tlcHF`, `\tlcLG`, `\tlcNCT`, `\tlcTOC`, `\tlcVE`, `\tlcDebug`, `\tlcVC` `\tlcDC` `\tlcSC` `\tlcIC` `\tlcPC` | data/additional-layout.tex:10-29 | yes | each is `\textcolor{darkblue}{literal}` (`color.xcolor`, `mark.kernel`); the emitter writes the coloured word in place. `\tlcDebug` (line 23) replaces the class command of the same name (cls:254) with a coloured word; the class command is never called |
| string aliases `\kpse` `\texDist` `\tlcDist` `\tlcGlobalDist` `\tlcHome` `\tlcMyDoc` `\gitHub` `\gitHubUrl` `\tlcRepo` `\tlcPkgFile` `\tlcProduct` `\tlcNote` | data/additional-layout.tex:10-45 | yes | plain text (with `\$`), or `\textcolor{darkblue}{Note}`; written inline |
| CSV names and table style `\csvnames{tlcPkgNames}`, `\csvstyle{tlcPkgStyle}` | data/additional-layout.tex:50-66 | yes | `csvsimple` only reads `data/required-packages.csv` into a longtable; the rows (31 package names with descriptions) are content. The emitter writes the longtable directly: `tbl.longtable` with `\|L{3cm}\|L{12cm}\|`, head row `Name & Description`, `\hline\hline\endhead`, `\\\hline` after each row. The look sits in the column spec and rules, which are lib parameters; the CSV reader is data plumbing, not a look |
| header values via `\tlcVersionPart` and `\tlc@version` `\tlc@date` `\tlc@status` `\tlc@institution` `\tlc@permission` | tlc-article.cls:343-353, 498-512; data/version.csv:2 | yes | `csvreader[separator=pipe]` fetches one field of `version.csv`; the emitter writes the literal field text into `\fancyhead[R]` and `\fancyfoot[L,C]` (`hf.fancyhdr`). The `\IfFileExists` fallback `\textcolor{red}{NOT USED}` (cls:507-511) only decides, at emit time, whether the file exists |
| file hooks `\IfFileExists{...}{\input{...}}` for `additional-layout.tex`, `header-footer.tex`, `logo.png`, `version.csv` | tlc-article.cls:182-186, 416-423, 453-471, 487-491, 522-528 | yes | the emitter knows which files it ships, so each test is decided once; `header-footer.tex` is absent here, so the default `\useDefaultHeaderFooter` (cls:402-407) applies. A user-supplied `header-footer.tex` would be arbitrary code and would be written as `hf.fancyhdr` calls instead |
| `\tlcTitlePageAndTableOfContents` with `\ifthenelse{\equal{#n}{}}` tests | tlc-article.cls:372-395 | yes | the `ifthen` tests only skip empty title, author or abstract; written out at emit time they leave `\title`, `\author`, `\maketitle`, `abstract`, `\thispagestyle{empty}`, `\clearpage`, `\tableofcontents`, `\clearpage` (`front.maketitle`, `abs.kernel`, `hf.pagestyle-kernel`, `pg.break`, `toc.kernel`) |
| `\tlcBeginLandscape` / `\tlcEndLandscape` | tlc-article.cls:232-235, 290-293 | yes | `\begin{landscape}\newgeometry{...}` and `\restoregeometry\end{landscape}` (`pg.landscape`, `page.geometry`); not used in the sample body |
| `\tlcDebug`, `\tlcIsDefined` | tlc-article.cls:254-283, 328-332 | yes (not emitted) | diagnostic listing of hook state (`description` with `enumitem`, `\textcolor{green}{DEFINED}`); a debugging aid, no part of the look; never called |
| `\tlcGetEnvironmentVariable` | tlc-article.cls:299-318 | not emitted | shell pipe to `kpsewhich` (see Blockers, latent); unused, so it is not part of the sample's output |
| `\ER`, `\inputIfExists`, `\tlcDarkblue`, `\tlcVspace` | tlc-article.cls:214, 224, 245, 360 | yes | aliases: `\\ \hline`, `\IfFileExists{f}{\input{f}}{}`, `\textcolor{darkblue}{...}`, `\vspace{3mm}` |

## Content-opaque
- `images/titlepage.png` included as the figure at tex:75 (an image, figure content; shipped by the zip).
- `data/logo.png` in the left header (cls:418): a shipped asset, an included image rather than drawn artwork, recorded as `fig.graphicx` above.
- `pgf-pie` is loaded (cls:83) but the sample draws no chart, so no TikZ picture is in the template or the sample.
- `doc/tlc-article.pdf` is the compiled guide, a binary not read; the README says the output matches it apart from header details (README.md:63-65), not checked here.

## Lib changes
- New ways proposed: none. (`class.tlc-article` is written plainly as a class way; its native vocabulary is recorded above. `csvsimple` is data plumbing for content, so no `tbl` way is proposed for it; `catchfile` and `ifthen` are used only inside unused or emit-time-decidable macros.)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
