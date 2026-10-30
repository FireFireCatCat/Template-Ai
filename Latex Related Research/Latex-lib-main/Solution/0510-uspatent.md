yes

# 0510-uspatent: uspatent (U.S. Patent Application Tools for LaTeX and LyX)

- Unverified: read from the source, not compiled.
- Source: Source/0510-uspatent/ (origin: https://mirrors.ctan.org/macros/latex/contrib/uspatent.zip; licence: lppl1.3)
- Kind: misc (legal: a U.S. patent application)
- Lib: v5
- Engine: pdfLaTeX-compatible (the class branches on `\ifpdf`; its dvips branch is only a fallback, tex/uspatent.cls:56-77; the manual says only pdfLaTeX works, doc/PatentApplicationGuide.tex:778-787)
- Look carried by: class (tex/uspatent.cls sets page, headers, title page, sections, paragraph numbers, claims and drawings; tex/PatentApplication.tex adds only class commands and text; the manual doc/PatentApplicationGuide.tex is a separate article-class document with its own preamble)
- Class origin: ctan
- Main file: tex/PatentApplication.tex (other samples: doc/PatentApplicationGuide.tex, the manifest's main, a LyX-exported manual on `article`; tex/Drawings.tex is the data file the main sample includes)
- Read: main yes, zip-local classes and styles all

## Verdict
The look of the template is carried by `uspatent.cls`, a class that is on CTAN and in TeX Live (ctan.org/pkg/uspatent read: "U.S. Patent Application Tools for LaTeX and LyX", LPPL 1.3, v1.0), and the zip is its own CTAN file set (README:3). It is therefore a published class way, `class.uspatent`, and its internal macros are not counted as bespoke code. The main sample defines no macro of its own; the manual's preamble holds only reducible aliases and published packages. The only missing home is a prefix-keyed reference formatter (`prettyref`, `refstyle`), proposed as `xref.prettyref`. This yes rests on W1 for the class: if a class's own macros were counted, the figure and annotation registry (`\csname` tables, `\loop` list printing, tex/uspatent.cls:395-692) would be `BESPOKE/class`.

## Blockers
none

## Class setting
- Class: `class.uspatent` options: `english` (a global option: the class processes none, `\DeclareOption*` and `\ProcessOptions` are commented out, tex/uspatent.cls:23-24; it reaches `babel`, cls:87). The class fixes `memoir` with `letterpaper,12pt` (cls:25; README:17 "based on memoir"). The manual uses `class.article` `[twoside,english]` (doc/PatentApplicationGuide.tex:3).
- Class-native vocabulary used (PatentApplication.tex, Drawings.tex): front matter `\setAssigneeName` `\setAssigneeAddress` `\setAssigneeCity` `\setAssigneePhone` `\setDocketNumber` `\setLawyerName` `\setLawyerNumber` `\setLawyerPhone` `\setOtherInventor` `\setDocumentVersion` `\setPrintingModeApplication` (and `\setPrintingModeDraft`, cls:40), `\title` `\date` `\inventor` `\maketitle`; body `\patentSection{}` `\patentParagraph` `\patentDrawingDescriptions` `\patentClaimsStart` `\beginClaim{}` `\claimRef{}` `\patentClaimsEnd` `\patentDrawings`; figures `\figureDefinition` `\figureExtension` `\figureDescription` `\figureCaption` (also `\figureClearPageAfter`, cls:594), `\annotationDefinition` `\annotationName` `\annotationDescription`, references `\referencePatentFigure` `\annotateWithName` `\annotate` `\annotationNumberReference` `\annotationNumberReferenceUnderlined` `\annotateNoBrackets`; customisable strings `\WhatIsClaimed` (cls:296), `\annotationFigureListSectionName`, `\annotationFigureListPreamble`, `\setFigureListNoRunOn` (cls:531); draft-only `\patentComment` (cls:203). Environments: none of its own (it uses memoir `titlingpage` and `SingleSpace`).

## Component map
Paths are relative to Source/0510-uspatent/; `cls` = tex/uspatent.cls, `app` = tex/PatentApplication.tex, `guide` = doc/PatentApplicationGuide.tex.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (main sample) | app:20; cls:21-25 | `class.uspatent` | `[english]`; loads memoir `letterpaper,12pt` |
| paper and size | cls:25 | `page.class-options` | letterpaper, 12pt |
| page geometry | cls:44-53 | `page.memoir-layout` | `\settrimmedsize{11in}{8.5in}{*}`, `\settypeblocksize{8.5in}{36pc}{*}`, `\setulmargins{1.5in}{*}{*}`, `\setlrmargins{*}{*}{1}`, `\setmarginnotes{17pt}{51pt}{\onelineskip}`, `\setheadfoot{5\onelineskip}{3\onelineskip}`, `\setheaderspaces{*}{2\onelineskip}{*}`, `\checkandfixthelayout` (trims `\trimtop` `\trimedge` 0pt, cls:45-46) |
| header/footer, application mode | cls:132-138, 233-239 | `hf.memoir-pagestyle` | `\pagestyle{title}` then `\pagestyle{myheadings}`; `\makeoddhead`/`\makeevenhead` right field `\scriptsize{\patentNumber}`; `\makeoddfoot`/`\makeevenfoot` centre `\thepage`; `\aliaspagestyle{titlingpage}{myheadings}` (cls:152) |
| header/footer, draft mode | cls:139-149, 240-250 | `hf.memoir-pagestyle` | left `\confidentialAssignee`, right `\scriptsize{Draft of \thedate\\version ...}`, foot `\thepage` with `\scshape\tiny\thetitle`; chosen by the boolean `\ifPatentOfficeMode` (cls:27-28, 40-41) |
| header of drawing pages | cls:315-337 | `hf.memoir-pagestyle` | centre field of five `\tiny` lines: title, author with `\etal` (cls:195-200), docket, lawyer name and phone, `\thepage/\thelastpage` (memoir counter, source not read); feet empty |
| drawing page numbering | cls:316, 320 | `pgnum.pagenumbering` | `\setcounter{page}{1}` in application mode; `\cleartooddpage` first |
| front-matter data | app:23-34, 38-40; cls:30-42, 270-281 | `front.class-native` | strings only; up to eight other inventors (guide:1569-1571); `\inventor` is `\author` (cls:42); defaults `~` and `0.0` (cls:97-130) |
| title page | app:42; cls:95-191 | `front.class-native` | `\maketitle` = `\patentTitlePage` + `\patentStart` (cls:188-191); heading "APPLICATION FOR UNITED STATES LETTERS PATENT" (cls:154) |
| title page container | cls:151-183 | `front.titlepage-env` | memoir `titlingpage` |
| title page inventor list | cls:159-169 | `tbl.tabular` | `{rl}`, rows of `\inventorListName{1..8}` |
| title page gaps | cls:155, 158, 172, 176 | `sp.manual-space` | `\vskip 172 pt` twice, `\vskip 10 pt`, `[2\baselineskip]` |
| title page alignment | cls:153, 159, 170 | `sp.ragged` | `center`, `flushleft`, `flushright` |
| title page type | cls:154, 253 | `mark.kernel` | `\textbf` on the heading and the repeated title |
| title page case | cls:156, 253 | `mark.case` | `\MakeUppercase{\thetitle}` |
| title page size | cls:171 | `font.size-commands` | `\tiny`, `\scriptsize` (cls:136, 145) |
| patent section heading | app:44; cls:214-221 | `head.class-native` | `\patentSection{T}` = `\section[T][]{}` (empty title, bookmark only) + centred bold underlined upper-case T |
| heading keep-together | cls:215 | `pg.needspace` | `\Needspace{8pc}` (memoir) |
| heading skips | cls:261-262 | `head.memoir-style` | `\setbeforesecskip{0pc}`, `\setaftersecskip{0pc}` |
| section numbering | cls:256-259 | `num.secnumdepth` | secnumdepth=-1, tocdepth=1 (no numbers; kept for PDF bookmarks) |
| numbered paragraph | app:46; cls:223-230, 266 | `num.counters` | counter `parnum`, `\refstepcounter`, printed bold in brackets, zero-padded to four digits |
| paragraph and line spacing | cls:184-185, 263 | `sp.lengths` | `\parindent 10pt`, `\parskip=10pt`; `sp.setspace` `\DoubleSpacing` and `SingleSpace` (memoir's own, cls:185, 208, 354) |
| equations | app:84-92; cls:79 | `math.amsmath` | `equation` with `\label{eq:...}` |
| prefix-keyed references | app:94; cls:84, 90-93 | `xref.prettyref` | `\newrefformat{eq}{\textup{(\ref{#1})}}`, `{cla}{claim \ref{#1}}`, `{tab}{Table \ref{#1}}`, `{fig}{\figurename \ \textbf{\ref{#1}}}`; body `\prettyref{eq:energy}` |
| claims block | app:100-110; cls:298-309 | `list.kernel` | `enumerate`; `\newpage`, `\section[Claims][]{}`, `\parskip=0pt`, text `\WhatIsClaimed` ("What is claimed:") |
| claim items and references | app:102, 108; cls:293-294 | `xref.kernel` | `\beginClaim{x}` = `\item \label{cla:x}`; `\claimRef{x}` = `claim \ref{cla:x}` |
| claims page breaks | cls:299, 308, 316, 360 | `pg.break` | `\newpage`, `\clearpage`, `\cleartooddpage` |
| abstract | app:112-114 | `head.class-native` | a last `\patentSection{Abstract}`, no `abstract` environment |
| include of the drawings file | app:36 | `struct.input` | `\include{Drawings}` |
| figure and annotation registry | Drawings.tex:1-28; cls:395-616 | `fig.class-native` | figure name, extension, description, caption; annotation name, text, description (numbers assigned in order) |
| brief description of drawings | app:72; cls:541-561, 694-711 | `fig.class-native` | generated list "FIG. n ..." with `;` / `; and` / `.` punctuation; heading through `\patentSection` (cls:694-695) |
| drawing pages | app:116; cls:315-361, 659-692, 715-725 | `fig.class-native` | `\patentDrawings` loops over figures; `\clearpage` when `\figureClearPageAfter` was given (cls:683-686) |
| figure body | cls:618-624, 642-657 | `fig.graphicx` | `figure[!ht]`, `\centering`, `\includegraphics[]{name.ext}`, "FIG. n  caption" set by hand with no `\caption` |
| figure and annotation references | app:78-80; cls:437-452, 613, 706-708 | `fig.class-native` | "FIG.~n", "name [n]", "[n]", bare n, underlined n |
| caption delimiter | cls:54 | `cap.memoir` | `\captiondelim{}` |
| draft margin comment | cls:203-212 | `note.marginpar` | `\marginpar{\tiny\textcolor{red}{...}}` in draft mode only; `color.color` `\textcolor` (the colour package is loaded by hyperref or tikz, not named in the class) |
| hyperlinks and PDF metadata | cls:59-72 | `meta.hyperref` | `hyperindex=true`, `pdfusetitle`, `bookmarks=true`, `extension=pdf`, `linkcolor=black`, `colorlinks=true`, `hyperfootnotes=false`, `pdffitwindow`, `pdftoolbar`, `pdfmenubar`, `debug=false`, `pagebackref=true` |
| graphics loading | cls:57, 73 | `fig.graphicx` | `[pdftex]`, `\DeclareGraphicsExtensions{.pdf,.jpg,.tif}` |
| maths package | cls:79 | `math.amsmath` | load only |
| list package | cls:80 | `list.enumitem` | load only; the claims list sets no key |
| acronym package | cls:81 | `idx.glossaries` | `[nolist]`; no `\ac` in the sample |
| fonts and encoding | cls:85-86 | `font.lmodern` | `lmodern`; `font.fontenc-t1` `[T1]` |
| language | cls:87; app:20 | `lang.babel` | no language argument; takes the global option `english` |
| tikz loaded | cls:88 | `art.tikz` | loaded unconditionally; used only inside drawing content (below) |
| manual: document class | guide:3 | `class.article` | `twoside,english` |
| manual: encoding | guide:4, 14 | `font.fontenc-t1` | `[OT1]`, `textcomp` |
| manual: geometry | guide:6-7 | `page.geometry` | `verbose,tmargin=1in,bmargin=1in,lmargin=1in,rmargin=1in` |
| manual: language | guide:10 | `lang.babel` | global option `english` |
| manual: listings | guide:5, 72, 2931, 3674 | `code.listings` | `\lstset{basicstyle=\footnotesize\ttfamily,breaklines=true,breakatwhitespace=false}`; `lstlisting` for the class and the sample |
| manual: header and footer | guide:74-82, 2922, 2930 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\rhead{\rightmark}`, `\cfoot{\thepage}`, `\headrulewidth` 0pt, `\sectionmark` renewed to `\markright{...}` |
| manual: hyperlinks | guide:23-26, 335 | `meta.hyperref` | `unicode=true,pdfusetitle,bookmarks=true,bookmarksnumbered=false,bookmarksopen=false,breaklinks=true,pdfborder={0 0 0},backref=false,colorlinks=true`; `\href` |
| manual: url | guide:15, 27, 117 | `meta.url` | `url`, `breakurl`, `\url` |
| manual: named references | guide:12, 33-37, 46-54, 334, 340, 383, 619, 2182 | `xref.prettyref` | `refstyle` is the package: `\newref{sub}{name = section~}`, body `\enuref` `\subref` `\secref` `\figref` `\tabref` |
| manual: plain references | guide:292, 2303 | `xref.kernel` | `\ref`, `\pageref`, `\label` |
| manual: title block | guide:92-100 | `front.maketitle` | `\title`, `\author`, `\date` with `\textsuperscript`, `\maketitle` |
| manual: contents | guide:101, 2929 | `toc.kernel` | `\tableofcontents{}`, `\addcontentsline{toc}{section}{...}` |
| manual: headings | guide:108, 155, 425, 2750 | `head.kernel` | `\section*`, `\section`, `\subsection`, `\subsubsection` |
| manual: lists | guide:163, 286 | `list.kernel` | `itemize`, `enumerate` (item spacing `\setlength{\itemsep}{0mm}` at guide:2794: `sp.lengths`) |
| manual: boxes | guide:298-305 | `box.fancybox` | `\framebox` around `box.minipage` `minipage[t]{0.6\columnwidth}` |
| manual: figures | guide:630-637 | `fig.graphicx` | `figure`, `centering`, `\includegraphics`; `cap.kernel` `\caption`, `\label` |
| manual: table | guide:2186-2214 | `tbl.tabular` | `{|c|c|c|}`, `\hline`, `\cline`, `\tabularnewline`; `tbl.multirow` `\multirow{4}{*}{1}` (guide:2193) |
| manual: footnotes | guide:362-364 | `fn.kernel` | `\footnote` |
| manual: index | guide:18-19, 110, 3812 | `idx.makeidx` | `makeidx`, `\makeindex`, `\index{...}`, `\printindex` |
| manual: underline | guide:21-22, 1025 | `mark.ulem` | `\PassOptionsToPackage{normalem}{ulem}`, `\uline` |
| manual: included PDF | guide:16, 3808 | `pg.include-pdf` | `\includepdf[pages=-]{PatentApplication}` |
| manual: keep together | guide:68, 565 | `pg.needspace` | `\needspace{5\baselineskip}` |
| manual: page breaks | guide:85, 103-105, 2921, 3798 | `pg.break` | `\clearpage`, `\pagebreak`, `\cleardoublepage`; `nextpage` `\cleartooddpage`, `\cleartoevenpage` (the same type of effect as `\cleardoublepage`; the package is not named in the lib line) |
| manual: hyphenation | guide:59-67, 1354 | `sp.hyphenat` | `\hyphenation{...}`; `sloppypar` |
| manual: spacing | guide:1021, 1291, 2665 | `sp.manual-space` | `\medskip`, `\smallskip`, `\linebreak` |
| manual: alignment | guide:297-306, 631 | `sp.ragged` | `center`, `centering` |
| manual: type | guide:72, 1297, 1294 | `font.size-commands` | `\footnotesize`, `\Large`, `\small`; `mark.kernel` `\texttt` `\textbf` `\emph` `\textsuperscript` |
| manual: inline maths | guide:2727, 2846 | `math.kernel` | `$5"\times8"$` |
| manual: load-only packages | guide:9, 11, 13 | `color.color` | `color` (load only), `array` (inside `tbl.tabular`), `calc` (no calc expression is used; no lib line, no printed effect) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| figure and annotation registry (`\csname` tables, counters, `\loop` list printing with `; and`) | cls:363-692 | not counted: part of the published class `class.uspatent` (W1) | emitter writes `\figureDefinition` ... `\annotationDescription` calls and `\patentDrawingDescriptions` / `\patentDrawings`; if counted it would be `BESPOKE/class` |
| `\patentParagraph` zero-padded counter | cls:223-230 | not counted (published class) | class command; by hand it is `\refstepcounter{parnum}` plus a padded `\arabic` with `\ifnum` conditionals |
| `\patentTitlePage`, `\patentStart`, `\patentDrawingsStart` (mode-dependent `\makeoddhead` sets) | cls:95-191, 232-355 | not counted (published class) | memoir page-style commands (`hf.memoir-pagestyle`), `titlingpage`, tabular, rules as in the rows above |
| `\patentSection`, `\patentClaimsStart`, `\beginClaim`, `\claimRef` | cls:214-221, 293-309 | yes | inline expansion to `pg.needspace`, `head.kernel` with an empty title, `sp.ragged` centre, `mark.kernel`, `mark.case`; `list.kernel` `enumerate` with `\item \label{cla:x}` and `xref.kernel` |
| `\patentComment` | cls:203-212 | yes | `note.marginpar` in draft mode, nothing in application mode |
| manual `\LyX` logo | guide:38-40 | yes | `\texorpdfstring{L\hspace{-.1667em}\raisebox{-.25em}{Y}\hspace{-.125em}X}{LyX}` (`sp.manual-space`, `meta.hyperref`) |
| manual `\TikZ`, `\lyxdot`, `\tabularnewline` | guide:70, 44, 42 | yes | text aliases: `Ti\emph{k}Z` (`mark.kernel`), `.`, `\\` |
| manual `\providecommand` reference aliases | guide:33-37 | yes | `\ref{enu:..}`, `\ref{sub:..}` (`xref.kernel`), or the refstyle forms |
| manual refstyle hooks `\RS@ifundefined{subref}{\def\RSsubtxt{section~}\newref{sub}{name = \RSsubtxt}}{}` | guide:46-54 | yes | the declarative calls `\newref{sub}{name=section~}`, `\newref{thm}{name=theorem~}`, `\newref{lem}{name=lemma~}` |
| manual `\theindex` wrapper | guide:58 | yes | before `\printindex`: `\cleardoublepage\phantomsection\addcontentsline{toc}{section}{\indexname}` (`pg.break`, `meta.hyperref`, `toc.kernel`) |
| manual `\synctex=-1` | guide:8 | no printed effect | a SyncTeX debug switch; not a component, no lib way, not a template look |
| `uspatent.layout` (LyX layout file) | tex/uspatent.layout:1-634 | not LaTeX | maps LyX styles to the class commands above (for example `LatexName patentSection`, layout:98); LyX-only, never emitted as LaTeX |
| listing of the class inside the manual | guide:2931-3661 | n/a | a verbatim copy that differs slightly from the shipped class (guide:2953 says v0.0, cls:22 says v1.0; guide:3642 adds "is" where cls:710-711 does not); the shipped `cls` is analysed |

## Content-opaque
- TikZ drawing inside a patent figure: tex/TpXDrawing.tpx:26-56 (`tikzpicture` produced by the TpX tool, with `\annotateNoBrackets` labels at lines 51-55); it is figure artwork, not template identity.
- Shipped figure and page images: tex/VisioDrawing.pdf (drawn in Visio, `.vsd` sources are binary and not read), doc/*.png, and doc/PatentApplication.pdf (included at guide:3808).
- Equations at tex/PatentApplication.tex:84-92 and the patent text.
- Not read: tex/PatentApplication.lyx, tex/Drawings.lyx, doc/PatentApplicationGuide.lyx (LyX sources of the same documents; the `.tex` files are their exports).

## Lib changes
- New ways proposed: `xref.prettyref` `prettyref` (CTAN and TeX Live, public domain, Kevin Ruland; read at ctan.org/pkg/prettyref), engine pdf: `\usepackage{prettyref}`, preamble `\newrefformat{prefix}{format with #1}`, body `\prettyref{prefix:label}`; the package is the parameter, with `refstyle` (CTAN and TeX Live, LPPL 1.3c, Daniel Els; read at ctan.org/pkg/refstyle) as the same type: `\newref{prefix}{name=...}` and the commands `\figref` `\secref`. W1: both are on CTAN. W2: the formats and names are strings and booleans, chosen per label prefix. W3: any document with typed labels, not one document. W4: preamble declarations plus a body wrapper around a label. Not `xref.cleveref` (a different package that names references by counter type, with no label prefix) and not `xref.kernel` (no format table); a reviewer may fold it into `xref.cleveref` as a package-is-the-parameter widening.
- Considered, not proposed: `memhfixc` (load-only memoir and hyperref compatibility, no printed effect, the type of the rejected `sys.compat-load`), `xspace` (loaded, never called), `calc` (loaded, no expression used).
