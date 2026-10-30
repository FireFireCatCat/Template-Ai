yes

# 0832-cai4cai-xclthesistemplate: XCLThesisTemplate (King's College London / UCL thesis, unofficial)

- Unverified: read from the source, not compiled.
- Source: Source/0832-cai4cai-xclthesistemplate/ (origin: https://codeload.github.com/cai4cai/XCLThesisTemplate/zip/refs/heads/main; licence: not established (manifest NOASSERTION; LICENSE:1-5 says a proper licence is missing and the UCL logo may be restricted))
- Kind: thesis
- Lib: v6
- Engine: pdfLaTeX-compatible (T1 + inputenc utf8 + lmodern, `\pdfbookmark` via hyperref; the repo builds with `latexmk -pdf`, .github/workflows/build.yml:4)
- Look carried by: mixed (zip-local ThesisStyle.cls, a hand-edited copy of book.cls, sets chapter opener, front/main matter switch and ToC; FormatAndDefsThesisExtra.tex sets geometry, headers, theorems, bibliography, hyperref; TitlePageKCL.tex / TitlePageUCL.tex hand-lay the cover)
- Class origin: zip-local (ThesisStyle is not on CTAN: ctan.org/pkg/thesisstyle returned 404; GitHub repo, not a publisher kit)
- Main file: Thesis.tex (other samples: none; TitlePageUCL.tex is the commented-out alternative cover, Thesis.tex:33)
- Read: main yes, zip-local classes and styles all (ThesisStyle.cls 1-726, FormatAndDefsBasic.tex, FormatAndDefsThesisExtra.tex, both title pages, all chapter files, tools/plainwatermark.tex, tools/tex4ht_no_css.cfg; the tools/ shell and Python scripts only to their first 25 lines); archive/these.bst (1277 lines, an old BibTeX style, never loaded) not read

## Verdict
Yes, with one judgement call. Every part of the class and preamble reduces to published ways: ThesisStyle.cls is book.cls with a changed chapter opener, a page-number-neutral `\frontmatter`/`\mainmatter` and a ToC bookmark, so it is `class.book` + `head.titlesec` + kernel commands; the preamble is standard `geometry`, `setspace`, `fancyhdr`, `emptypage`-equivalent, `ntheorem`, `biblatex`, `hyperref`, `minitoc` calls. The judgement call is the front/main matter switch (ThesisStyle.cls:244-253 drops the `\pagenumbering` calls of book.cls): the reduction below emits front chapters as starred chapters instead of calling `\frontmatter`, which keeps page numbers continuous. I compared ThesisStyle.cls with book.cls from memory (the stock source is not in the zip), so a small difference I did not recognise could remain. No artwork beyond included logo images (`bg.background`), no external tool for `Thesis.tex` (tools/ holds optional pandoc, qpdf, epstopdf scripts that the build never calls).

## Blockers
none

## Class setting
- Class: `class.book` (reduction of zip-local ThesisStyle, `\documentclass[british,a4paper,11pt,twoside]{ThesisStyle}`, Thesis.tex:10) options: `a4paper` (ThesisStyle.cls:15-17), `11pt` (:43), `twoside` (:48); defaults `openright` `onecolumn` (:79). `british` is declared nowhere in the class and no babel/polyglossia is loaded, so nothing consumes it (biblatex reaction not checked).
- Class-native vocabulary used: `\frontmatter` (Thesis.tex:30), `\mainmatter` (:66), `\backmatter` (:74), `\chapter` (:41, Introduction.tex:1), `\chaptermark` (Methods.tex:2), `\section` to `\paragraph` (Introduction.tex:16-28), `\include` (Thesis.tex:68-72), kernel `\tableofcontents` `\listoftables` `\listoffigures` (:53, :59, :64). The class's own names: `\contentsname` "Table of Contents" etc. (ThesisStyle.cls:695-704).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | Thesis.tex:10; ThesisStyle.cls:4-6,79-81 | `class.book` | a4paper, 11pt, twoside; reduction of the zip-local fork; the class inputs kernel `bk11.clo` (:81) |
| paper / size | Thesis.tex:10; ThesisStyle.cls:15-17,43 | `page.class-options` | a4paper, 11pt |
| page geometry | FormatAndDefsThesisExtra.tex:4 | `page.geometry` | left=1.5in, right=1.3in, top=1.1in, bottom=1.1in, includefoot, includehead, headheight=13.6pt |
| line spacing | FormatAndDefsThesisExtra.tex:9-10 | `sp.setspace` | `\onehalfspacing` |
| running head and foot | FormatAndDefsThesisExtra.tex:17-23,44-62 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\headrulewidth` 1.0pt; twoside: `\fancyhead[LE,RO]{\bfseries\thepage}`, `[RE]` `\bfseries\nouppercase{\leftmark}`, `[LO]` `\bfseries\nouppercase{\rightmark}`, `\fancyfoot[LE,RO]{\draftnote}` |
| `plain` and `empty` page styles | FormatAndDefsThesisExtra.tex:57-69 | `hf.fancyhdr` | `\fancypagestyle{plain}`: footer `[C]` `\bfseries\thepage` + draftnote, `\headrulewidth` 0pt; `empty`: draftnote only |
| one-sided variant of the heads | FormatAndDefsThesisExtra.tex:70-85 | `hf.fancyhdr` | dead branch for `twoside`; the emitter prints only the twoside branch |
| header marks | FormatAndDefsThesisExtra.tex:29-42; Methods.tex:2 | `hf.fancyhdr` | marks set through `\markboth` (a `\chaptermark` hook): upper-case "Chapter N. Title" left, same text not upper-cased right; short title via `\chaptermark{Short title for headers}` |
| upper-casing in marks | FormatAndDefsThesisExtra.tex:30 | `mark.case` | `\MakeUppercase` (cancelled by `\nouppercase` at :49,:51) |
| blank verso pages empty | FormatAndDefsThesisExtra.tex:90-94 | `pg.emptypage` | load-only; the redefinition is the `emptypage` code (`\hbox{}\thispagestyle{empty}\newpage`) |
| page breaks | Thesis.tex:40,44,48,52,56,61; Methods.tex:8 | `pg.break` | `\cleardoublepage`, `\clearpage`, `\newpage` |
| page-style switches | TitlePageKCL.tex:4; FormatAndDefsThesisExtra.tex:101,114,124 | `hf.pagestyle-kernel` | `\pagestyle{empty}`, `\thispagestyle{empty|plain}` |
| page numbering | ThesisStyle.cls:247,252 (commented out), :712 | `pgnum.pagenumbering` | arabic, continuous from the cover; no `\pagenumbering` call is emitted |
| fonts | FormatAndDefsThesisExtra.tex:170 | `font.lmodern` | `lmodern` |
| encodings | FormatAndDefsBasic.tex:32,35,38 | `font.fontenc-t1` | `inputenc` utf8, `fontenc` T1, `textcomp` |
| font sizes and marks (cover) | TitlePageKCL.tex:11,15,24-25,35 | `font.size-commands`, `mark.kernel` | `\LARGE` `\huge` `\Large`; `\textbf`, `\textrm` |
| raw lengths | TitlePageKCL.tex:15; FormatAndDefsBasic.tex:65; FormatAndDefsThesisExtra.tex:157 | `sp.lengths` | `\baselineskip=0.95em plus 1pt`; `\tabcolsep` 3pt; `\theorempostskipamount` 15pt |
| manual spacing on cover | TitlePageKCL.tex:8,13,21,28,38,43,48-52 | `sp.manual-space` | `\vspace*{1.5cm}`, `\vspace{0.6cm}`, 3cm, 1.5cm, 0.2cm, 1.0cm, `\\` |
| colour | Thesis.tex:20; FormatAndDefsThesisExtra.tex:224,230-231 | `color.color` | `color` package; `\textcolor[gray]{0.5}`; `\definecolor{linkcol}{rgb}{0,0,0}`, `citecol` same |
| cover logo / banner | TitlePageKCL.tex:6; TitlePageUCL.tex:6; FormatAndDefsThesisExtra.tex:139 | `bg.background` | `wallpaper`: `\ThisURCornerWallPaper{0.25}{figs/kcllogo}`, `\ThisULCornerWallPaper{1}{figs/University_College_London_banner}` (image files shipped in figs/) |
| framed boxes (loaded, unused) | FormatAndDefsThesisExtra.tex:136-137 | `box.fancybox` | `fancybox`, `\shadowsize` 1pt |
| title data | Thesis.tex:12-15 | `front.maketitle` | `\title`, `\author` only (data for `pdfusetitle` and the `\let` aliases); `\maketitle` is never called |
| cover page | TitlePageKCL.tex:1-57 | `front.titlepage-env` | `titlepage` environment of `center` blocks: author, title, institution, degree text, `\today`, supervisor table |
| cover supervisor table | TitlePageKCL.tex:46-54 | `tbl.tabular` | column spec `{l p{3.3cm} l l}` |
| copyright page | FormatAndDefsThesisExtra.tex:100-110; Thesis.tex:37 | `front.dedication` | `\copyrightpage{\the\year}{\theauthor}`: `\thispagestyle{empty}`, `\vfill`, centred copyright line |
| declaration page | FormatAndDefsThesisExtra.tex:113-119; Thesis.tex:38 | `front.dedication` | `\declarationpage{\theauthor}`: plain page, one sentence, `\cleardoublepage` (Declaration.tex:1 holds the same text and is never input) |
| quotation page (defined, unused) | FormatAndDefsThesisExtra.tex:123-134 | `front.dedication`, `quote.kernel` | `\vspace*{\stretch{1}}`, `quotation`, `flushright`, `\stretch{3}` |
| abstract, impact statement, acknowledgments | Thesis.tex:41-50 | `head.kernel` | unnumbered chapters in the front matter (no `abstract` environment); emitted as `\chapter*{T}` + `\addcontentsline{toc}{chapter}{T}` (`toc.kernel`) + `\markboth` |
| contents lists | ThesisStyle.cls:562-577,613-638; Thesis.tex:53,56-64 | `toc.kernel` | `\tableofcontents` `\listoftables` `\listoffigures`; `\pdfbookmark[0]{\contentsname}{contents}` (:574, `meta.hyperref`) |
| list titles | FormatAndDefsThesisExtra.tex:141-143; ThesisStyle.cls:695-704 | `toc.kernel` | `\renewcommand` of `\contentsname` "Table of contents", `\listfigurename`, `\listtablename` |
| mini contents per chapter | FormatAndDefsThesisExtra.tex:147,150; Thesis.tex:35,58,63; Introduction.tex:3 | `toc.etoc` | `minitoc[nohints]`, `\mtcsettitle{minitoc}{\contentsname}`, `\dominitoc`, `\minitoc`, `\mtcaddchapter[\listtablename]` |
| contents depth | ThesisStyle.cls:228,561 | `num.secnumdepth` | secnumdepth 2, tocdepth 2 (book defaults) |
| chapter opener, numbered | ThesisStyle.cls:342-359 | `head.titlesec` | `\titleformat{\chapter}[display]{\normalfont\flushright}{\Large\scshape\chaptername\space\thechapter}{0pt}{\Huge\bfseries}[rule]`, `\titlespacing*{\chapter}{0pt}{0pt}{20pt}` (the class ends the title with `\hrulefill`, 0.4pt full-width rule; no 50pt top space, :343 commented) |
| chapter opener, starred / front | ThesisStyle.cls:367-377 | `head.titlesec` | `\titleformat{name=\chapter,numberless}[display]{\normalfont\flushright}{}{0pt}{\Huge\bfseries}[rule]`, same spacing |
| section to subparagraph | ThesisStyle.cls:378-397 | `head.class-native` | book defaults: section `\Large\bfseries`, subsection `\large\bfseries`, subsubsection and paragraph `\normalsize\bfseries`; sample uses to `\paragraph` (Introduction.tex:16-28) |
| counters | ThesisStyle.cls:229-242,506-511,522-524 | `num.counters` | numbering per chapter for section, equation, figure, table (book defaults) |
| appendix (defined, unused) | ThesisStyle.cls:493-497 | `num.appendix` | `\appendix` as in book |
| theorem-like | FormatAndDefsThesisExtra.tex:155-164 | `thm.ntheorem` | `[amsmath,thmmarks,hyperref]`, `\theoremstyle{break}`, header font `\normalfont\bfseries`, separator empty, body font `\normalfont`, symbol `\rule{1ex}{1ex}`, `\newtheorem{algorithm}{Algorithm}` (no theorem in the sample body) |
| math packages | FormatAndDefsBasic.tex:10-11 | `math.amsmath`, `math.amssymb` | `amsmath`, `amssymb` |
| display maths | Conclusion.tex:16-21 | `math.amsmath` | `align` with `\label`, `\eqref` |
| math macros | FormatAndDefsBasic.tex:71-128 | `math.amsmath`, `math.amssymb` | `\DeclareMathOperator`, `\operatornamewithlimits`, `\boldsymbol`, `\mathbb`, `\left\lvert` aliases |
| figure | Conclusion.tex:8-13 | `fig.graphicx` | `figure[htb!]`, `\centering`, `\includegraphics[width=0.60\linewidth]{figs/kcllogo}` |
| caption | ThesisStyle.cls:535-548; Conclusion.tex:12 | `cap.kernel` | book `\@makecaption` unchanged: `\abovecaptionskip` 10pt, `\belowcaptionskip` 0pt, centred when short |
| tables | FormatAndDefsBasic.tex:58,62 | `tbl.multirow` | `multirow`, `diagbox` loaded, not used in the sample |
| foreword box | Introduction.tex:5-11 | `box.minipage` | `minipage[b]{0.9\linewidth}` in `center`, `\small`, `\textbf`, `\emph` (`mark.kernel`) |
| cross-references | FormatAndDefsBasic.tex:158-168; Conclusion.tex:6,15 | `xref.kernel` | `\ref`, `\label`; `\figref` etc. expand to "Fig.~\ref{..}" |
| links and PDF metadata | FormatAndDefsThesisExtra.tex:233-261; Thesis.tex:57,62 | `meta.hyperref` | `pdfusetitle`, `pdfpagelabels=true`, `colorlinks=true`, link/cite/url colour black, `bookmarksdepth=3`, `bookmarksopenlevel=0`, `bookmarksnumbered`, `draft=false`, `plainpages=false`, `pdfstartview=FitH`, `pdfkeywords`, `pdfsubject={PhD Thesis}`, `pdflang`; `\phantomsection` |
| bibliography | FormatAndDefsThesisExtra.tex:179; Thesis.tex:23-26,76 | `bib.biblatex-biber` | `style=alphabetic,maxnames=99,maxcitenames=1,giveninits=false,uniquename=init,backref=true`; `\addbibresource{JNFull.bib}`, `{ThesisBibliography.bib}`, `{xampl.bib}`; `\printbibliography[heading=bibintoc,env=thesisbibenv]` |
| citation commands and labels | FormatAndDefsThesisExtra.tex:181-212 | `bib.biblatex-biber` | `\cite`=`\parencite`, `\citep`; `\DeclareCiteCommand{\citet}` (name + [year]); `\labelalphaothers` empty; `\DeclareLabelalphaTemplate` (shorthand, 1 name, label, `\addhighpenspace`, year) |
| bibliography list layout | FormatAndDefsThesisExtra.tex:214-218 | `bib.biblatex-biber`, `list.enumitem` | `\defbibenvironment{thesisbibenv}` over `\description[font=\normalfont]` with `\mkbibbrackets{\printfield{labelalpha}}` |
| file inclusion | Thesis.tex:17,21,32,42,50,68-72 | `struct.input` | `\input`, `\include` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| ThesisStyle.cls as a whole | ThesisStyle.cls:1-726 | yes | copy of book.cls (options, headings pagestyle, sections, lists, floats, ToC entries all as in book) with the four changes below; emit `class.book` `[a4paper,11pt,twoside]` + the ways in the map |
| `\@makechapterhead`, `\@makeschapterhead` | ThesisStyle.cls:342-377 | yes | `head.titlesec` `\titleformat`/`\titlespacing` as in the map; label only for numbered chapters |
| `\frontmatter` / `\mainmatter` without `\pagenumbering`, `\chapter` breaking the page only in main matter | ThesisStyle.cls:244-253,312-319 | yes (judgement call) | do not emit `\frontmatter`/`\mainmatter`; numbered chapters by plain `\chapter`; front chapters by `\chapter*{T}\addcontentsline{toc}{chapter}{T}\markboth{\MakeUppercase{T}}{T}` (what the unnumbered branch of `\@chapter`, :320-340, does; do not call `\chaptermark` there, `\thechapter` would print 0); the sample already has `\cleardoublepage` before each front chapter (Thesis.tex:40,44,48,52); `\addtocontents{lof|lot}{\protect\addvspace{10\p@}}` of front chapters merges with the later ones, no visible effect; page numbers stay arabic and continuous (book default) |
| `\tableofcontents` with `\pdfbookmark` | ThesisStyle.cls:562-577 | yes | kernel `\tableofcontents` + `\pdfbookmark[0]{\contentsname}{contents}` before it |
| `\thebibliography` using `\chapter` | ThesisStyle.cls:642-664 | yes (unused) | never reached: biblatex prints the list (Thesis.tex:76) |
| `\chaptermark` redefinition with `\if@mainmatter`, `\c@secnumdepth`, `\@chapapp` | FormatAndDefsThesisExtra.tex:29-42 | yes | the `fancyhdr` documented pattern `\renewcommand{\chaptermark}[1]{\markboth{..}{..}}`; the conditionals evaluate to "numbered, Chapter label" for numbered chapters; front chapters use `\markboth` (above) |
| `\if@twoside ... \else ... \fi` in preamble | FormatAndDefsThesisExtra.tex:44-85 | yes | class option known at emit time: print the twoside branch |
| `\cleardoublepage` redefinition | FormatAndDefsThesisExtra.tex:90-94 | yes | `pg.emptypage` (same code) |
| `\copyrightpage`, `\declarationpage`, `\quotationpage` | FormatAndDefsThesisExtra.tex:100-134 | yes | inline expansion into `front.dedication`, `hf.pagestyle-kernel`, `sp.manual-space`, `quote.kernel` |
| `\thetitle`, `\theauthor`, `\draftnote` | Thesis.tex:13-14,20; FormatAndDefsThesisExtra.tex:14 | yes | inline strings; draft note = `\textcolor[gray]{0.5}{\textbf{DRAFT -- \today}}` printed in the foot fields |
| `\DeclareCiteCommand{\citet}`, `\DeclareLabelalphaTemplate`, `\defbibenvironment` | FormatAndDefsThesisExtra.tex:187-195,200-212,215-218 | yes | biblatex's documented declaration API, bodies compose biblatex's own printing macros (`\printnames`, `\printfield`, `\usebibmacro`) with no TeX-level logic; same package, so the same way `bib.biblatex-biber` |
| `\onedot`, `\eg` `\ie` `\cf` `\etc` `\etal`, `\microns`, `\cvz*`, `\FCMLeica` | FormatAndDefsBasic.tex:136-152 | yes (unused) | content shortcuts (`\futurelet` looks for a period); inline expansion to the text "e.g.", "i.e." ...; `xspace` has no node to wrap |
| `\figref` `\secref` `\chapref` `\algref` `\tabref` and capitalised forms | FormatAndDefsBasic.tex:158-168 | yes | aliases of "Fig.~\ref{..}" (`xref.kernel`) |
| `\ifpdf ... \else dvips ... \fi` for hyperref | FormatAndDefsThesisExtra.tex:233-237 | yes | engine is pdfLaTeX: print the first branch |
| `nag[l2tabu,orthodox]`, `ifpdf` | Thesis.tex:8; FormatAndDefsBasic.tex:4 | yes | diagnostics and a conditional helper with no printed effect (considered: `nag`, as the rejected `sys.compat-load`) |
| `\expandafter{...}` around cover text | TitlePageKCL.tex:15,24,25 | yes | odd but content-level; the same text printed without it |

## Content-opaque
- included image `figs/kcllogo` inside the figure (Conclusion.tex:11); the cover logos (TitlePageKCL.tex:6, TitlePageUCL.tex:6) are image files placed by `bg.background`, not drawn artwork.
- Missing asset: `xampl.bib` (Thesis.tex:26) is not in the zip; it ships with the TeX distribution (BibTeX examples). `JNFull.bib` and `ThesisBibliography.bib` are present.
- Not part of the document build, not blockers: tools/ (pandoc + make4ht in convertlatex2word:4-15, qpdf in watermarkpdf:4, epstopdf/convert in graphicsconvertforlatex.py:8) and tools/plainwatermark.tex (a separate `article` with `draftwatermark`, :8) and tools/tex4ht_no_css.cfg (a tex4ht config, :1-10). Thesis.pdf is a shipped build product.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
