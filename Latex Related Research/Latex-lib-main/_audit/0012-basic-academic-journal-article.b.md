yes

# 0012-basic-academic-journal-article: Basic Academic Journal Article

- Unverified: read from the source, not compiled.
- Source: Source/0012-basic-academic-journal-article/ (origin: https://latextemplates.com/downloads/basic-academic-journal-article.zip; licence: CC-BY-4.0; ATTRIBUTION.txt:1-4 credits John Hammersley, Overleaf template "basic-academic-journal-article-template")
- Kind: journal
- Lib: v2
- Engine: pdfLaTeX-compatible (`times`, `mathptmx`, `inputenc` in olplainarticle.cls:9,20-21; no fontspec, no Lua)
- Look carried by: zip-local (the whole look is in olplainarticle.cls; main.tex adds only class options and content, main.tex:1-83)
- Class origin: zip-local (olplainarticle.cls is not on CTAN: ctan.org/pkg/olplainarticle returned 404; the zip comes from latextemplates.com, not from an Overleaf or publisher kit; the class header says "Created by Overleaf (writeLaTeX)... Based on the SelfArx document class", olplainarticle.cls:3-5)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (olplainarticle.cls 204 lines, read in full; references.bib and ATTRIBUTION.txt also read)

## Verdict
yes, with a caveat. olplainarticle.cls is `\LoadClass{article}` plus published packages (times/mathptmx, geometry, caption, fancyhdr, titlesec, titletoc, authblk, natbib, xcolor, parskip, microtype, lineno) with declarative settings, plus three kernel-hook redefinitions: `\@maketitle`, a capture-style `abstract`, and a `\thebibliography` wrapper. None uses counters, output routines, box measuring or expl3: each is a straight line of kernel commands, so each reduces to published ways plus body wrappers (see "Bespoke code"). There is no TikZ or other artwork. The caveat is that the title block and the bibliography wrapper reduce by composition (`front.titling` hooks, `\colorbox` and `\parbox` wrappers, lengths), and whether the vertical glue matches exactly is not checked, since nothing was compiled.

## Blockers
none

## Class setting
- Class: `class.article` (reached through zip-local olplainarticle.cls: `\LoadClass{article}` at olplainarticle.cls:19; options `\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}` at :17 and `\ProcessOptions*` at :18). The sample is `\documentclass[fleqn,10pt]{olplainarticle}` (main.tex:1): `fleqn` and `10pt` go to article; the class's own option `lineno` (olplainarticle.cls:15-16, main.tex:2-3 comment) is a boolean that is off here.
- Class-native vocabulary used: `\title`, `\author[n]{}`, `\affil[n]{}` (authblk, loaded at olplainarticle.cls:31), `\keywords{}` (zip-local, :135), `abstract` environment placed before `\begin{document}` and captured by a zip-local macro (:137-146; main.tex:14-19), `\maketitle` (redefined `\@maketitle`, :151-180), `\citep` (natbib), `\bibliography{references}`, `\section*`, `\subsection*`. Kernel article is the base.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | olplainarticle.cls:17-19; main.tex:1 | `class.article` | options 10pt, fleqn |
| paper and size | main.tex:1; olplainarticle.cls:38 | `page.class-options` | 10pt (class option); letterpaper is given to geometry |
| page geometry | olplainarticle.cls:33-38 | `page.geometry` | left=3cm, right=3cm, top=2.25cm, bottom=2.25cm, headheight=12pt, letterpaper |
| columns | olplainarticle.cls:182 | `sp.lengths` | `\columnsep`=0.55cm (single column, so no visible effect) |
| bottom flush | main.tex:23 | `pg.flush` | `\flushbottom` |
| running head and foot | olplainarticle.cls:50-62 | `hf.fancyhdr` | `\pagestyle{fancy}`; lhead, chead, rhead, lfoot, cfoot empty; `\rfoot{\small\sffamily\bfseries\thepage}`; headrulewidth=0pt, footrulewidth=0pt |
| first-page style | main.tex:25; olplainarticle.cls:153 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` after `\maketitle` (kernel article's `\maketitle` sets plain after `\@maketitle`, which is why the sample repeats it) |
| page X of Y | olplainarticle.cls:51, :60 | `pgnum.lastpage` | package loaded; `\pageref{LastPage}` is commented out, so unused |
| paragraph spacing | olplainarticle.cls:27 | `sp.parskip-pkg` | package defaults |
| microtype | olplainarticle.cls:14 | `sp.microtype` | loaded with `\AtEndOfClass`, defaults |
| line numbers (option) | olplainarticle.cls:15-16, 22-23, 163, 168, 174; main.tex:2 | `sp.draft-lineno` | package `lineno`; `\linenumbers` when option `lineno` is on; `\nolinenumbers` and `\internallinenumbers` in the title block; off in this sample |
| text and math fonts | olplainarticle.cls:20-21 | `font.mathptmx` | `times` + `mathptmx`; the sans face used throughout is the one `times` selects (Helvetica; package source not read) |
| input encoding | olplainarticle.cls:9 | `font.fontenc-t1` | `inputenc` utf8 only; no `fontenc` T1 line |
| author/affiliation fonts | olplainarticle.cls:189-190 | `font.nfss` | `\usefont{OT1}{phv}{b}{n}` inside `\Authfont` (`\fontsize{12}{14}`) and `\Affilfont` (`\fontsize{10}{12}`) |
| font sizes and families in title block | olplainarticle.cls:155,157,161,168 | `font.size-commands` | title `\fontsize{20}{25}`, authors `\fontsize{12}{16}`, `\large`, `\small`, `\sffamily`, `\bfseries` |
| colours | olplainarticle.cls:29, 185-186 | `color.xcolor` | `\definecolor{color1}{RGB}{0,0,0}` (headings, black); `\definecolor{color2}{RGB}{182,193,251}` (abstract box) |
| language | olplainarticle.cls:10 | `lang.babel` | `english` |
| title block | main.tex:5, 24; olplainarticle.cls:151-180 | `front.maketitle` | `\title`, `\author`, `\maketitle` (look: see next row) |
| title and author block look | olplainarticle.cls:153-157 | `front.titling` | reduction: `\pretitle`/`\posttitle`/`\preauthor`/`\postauthor`: `\vskip-36pt`, title `\raggedright\sffamily\bfseries\fontsize{20}{25}\selectfont`, `\vskip10pt`, authors `\raggedright\sffamily\fontsize{12}{16}\selectfont`, `\vskip18pt` |
| author, affiliation | main.tex:7-10; olplainarticle.cls:31, 189-190 | `front.authblk` | `\author[1]{}`, `\affil[1]{}`; Authfont and Affilfont as above |
| manual spacing in title block | olplainarticle.cls:154, 156, 158, 163, 171, 178 | `sp.manual-space` | `\vskip` -36pt, 10pt, 18pt, 10pt, 18pt, 25pt |
| abstract | main.tex:14-19; olplainarticle.cls:137-146, 159-170 | `box.fancybox` | `\colorbox{color2}{...}` (fill RGB 182,193,251) around a parbox; heading "ABSTRACT" above it in `\color{color1}\large\sffamily\textbf` |
| abstract box width | olplainarticle.cls:161, 167, 173 | `box.minipage` | `\parbox{\dimexpr\linewidth-2\fboxsep\relax}`; inside `\sffamily\small\vskip1ex` |
| keywords | main.tex:12; olplainarticle.cls:135, 173-176, 187 | `abs.keywords` | line after the abstract box: `{\color{color1}Keywords:\hspace*{1em}}` then the string (`\keywordname` = "Keywords:") |
| sectioning formats | olplainarticle.cls:67-91 | `head.titlesec` | `explicit`; section and numberless section: `\color{color1}\large\sffamily\bfseries`, `\MakeUppercase{#1}`, sep 0.5em or 0em; subsection `\sffamily\bfseries`; subsubsection `\sffamily\small\bfseries\itshape`; all with label `\the...` and sep 0.5em |
| paragraph heading | olplainarticle.cls:92-96 | `head.titlesec` | `\titleformat{\paragraph}[runin]{\sffamily\small\bfseries}{}{0em}{#1}` |
| heading spacing | olplainarticle.cls:97-100 | `head.titlesec` | `\titlespacing*`: section 0pc / 3ex plus4pt minus3pt / 5pt; subsection 0pc / 1.5ex plus1.5pt minus2pt / 0pt; subsubsection 0pc / 2ex plus2.5pt minus1.5pt / 0pt; paragraph 0pc / 1.5ex plus2pt minus1pt / 10pt |
| sectioning used in sample | main.tex:27,33,37,60,69,73,77 | `head.titlesec` | all starred (`\section*`, `\subsection*`), so the numberless section format is the one printed; no numbering |
| contents (defined, not called) | olplainarticle.cls:105-124 | `toc.titletoc` | `\contentsmargin{0cm}`; `\titlecontents` for section (`\small\bfseries\sffamily`, `\hfill\thecontentspage`), subsection (`\small\sffamily`, dot leader `\titlerule*[.5pc]{.}`), `\titlecontents*` subsubsection (`\footnotesize\sffamily`, bullet separator); indent `\tocsep`; `\tableofcontents` is not called in main.tex |
| toc depth and indent | olplainarticle.cls:192-194 | `num.secnumdepth` | `\setcounter{tocdepth}{3}` |
| toc indent length | olplainarticle.cls:192-193 | `sp.lengths` | `\newlength{\tocsep}`, `\tocsep`=1.5pc |
| lists (loaded, unused) | olplainarticle.cls:126-127 | `list.enumitem` | package loaded; `\setlist{nolistsep}` commented out; no list in main.tex |
| display math | main.tex:62-67 | `math.kernel` | `$$ ... $$`; inline maths with `\text`, `\mathcal`, `\frac`, `\sum` (content) |
| math packages | olplainarticle.cls:28 | `math.amsmath` | `amsmath`; `\text` used at main.tex:63-64 |
| math symbols | olplainarticle.cls:28 | `math.amssymb` | `amsfonts`, `amssymb` |
| equation alignment | main.tex:1 | `math.eqnumber` | class option `fleqn` |
| figure float | main.tex:43-48; olplainarticle.cls:29 | `fig.graphicx` | `figure[ht]`, `\centering`; the boxed rule placeholder is content |
| float package (loaded, unused) | olplainarticle.cls:26 | `fig.float` | `float` loaded; no `[H]`, no `\newfloat` |
| table | main.tex:50-58 | `tbl.tabular` | `table[ht]`, `\centering`, `tabular{l\|r}` with `\hline`; caption below the tabular |
| booktabs (loaded, unused) | olplainarticle.cls:30 | `tbl.booktabs` | package loaded; the sample uses `\hline` |
| captions | olplainarticle.cls:40-42; main.tex:46, 57 | `cap.caption` | `labelfont={bf,sf}`, `labelsep=period`, `justification=raggedright` |
| captions (command) | main.tex:46, 57 | `cap.kernel` | `\caption` |
| frame rule width | olplainarticle.cls:183; main.tex:45 | `sp.lengths` | `\fboxrule`=0.75pt (the comment says it is the abstract border, but the abstract uses `\colorbox` with no frame; it applies to the `\fbox` placeholder) |
| citations | olplainarticle.cls:44; main.tex:31 | `bib.natbib` | package with no options; `\citep{lees2010theoretical}` |
| bibliography | olplainarticle.cls:45; main.tex:81; references.bib:1-9 | `bib.bibtex-bst` | `\bibliographystyle{apalike}`, `\bibliography{references}`; one `@article` entry |
| bibliography label format | olplainarticle.cls:130 | `bib.natbib` | `\renewcommand{\@biblabel}[1]{\bfseries\color{color1}\textsuperscript{[#1]}}`; likely inert under author-year apalike (natbib source not read) |
| bibliography wrapper | olplainarticle.cls:198-205 | `toc.kernel` | `\addcontentsline{toc}{section}{\hspace*{-\tocsep}\refname}` before the list |
| bibliography wrapper lengths | olplainarticle.cls:202-204 | `sp.lengths` | after the list opens: `\itemsep`=0pt, `\parindent`=0pt, `\parskip`=`\baselineskip` |
| cross-references | main.tex:39, 47, 57 | `xref.kernel` | `\label`, `\ref`; no hyperref anywhere |
| inline marks | main.tex:62-67; olplainarticle.cls:155-175 | `mark.kernel` | `\textbf`, `\sffamily`, `\itshape` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| the class olplainarticle.cls as a whole | olplainarticle.cls:1-205 | yes | `\documentclass[10pt,fleqn]{article}` plus the packages and settings in the map above |
| `\if@reqslineno` and `\DeclareOption{lineno}` | olplainarticle.cls:15-16, 23, 163, 168, 174 | yes | one boolean selecting `sp.draft-lineno`: `\linenumbers` in the preamble, `\nolinenumbers`/`\internallinenumbers` in the title wrappers (all lineno commands); off in this sample |
| option pass-through | olplainarticle.cls:17-18 | yes | options 10pt and fleqn become `class.article` options |
| `\AtEndOfClass{\RequirePackage{microtype}}` | olplainarticle.cls:14 | yes | `sp.microtype` loaded last |
| `\keywords` / `\@keywords` / `\keywordname` | olplainarticle.cls:135, 187 | yes | store-and-print of one string; emitted as a keyword line wrapper (`abs.keywords`) |
| capture-style `abstract` (`\long\def\abstract#1\end#2`, `\gdef\theabstract`, `\ifx` check, `\typeout` warning) | olplainarticle.cls:137-146 | yes | its only job is to store the abstract text so `\@maketitle` can print it; the emitter does not need the capture and writes the box wrapper where the abstract belongs (after `\maketitle`). The warning text is a diagnostic, not layout. The abstract written before `\begin{document}` (main.tex:14-19) is an artefact of the capture |
| `\renewcommand{\@maketitle}` | olplainarticle.cls:151-180 | yes | straight-line kernel commands: title and author blocks by `front.titling` hooks; "ABSTRACT" heading, `\colorbox` and `\parbox` by `box.fancybox` and `box.minipage`; keywords line by `abs.keywords`; skips by `sp.manual-space`. No counters, no measuring, no output routine |
| `\Authfont` and `\Affilfont` redefinitions | olplainarticle.cls:189-190 | yes | authblk's documented font hooks set with `font.nfss` and `font.size-commands` |
| `\tocsep` length | olplainarticle.cls:192-193 | yes | `sp.lengths` |
| `\let\oldbibliography` and `\renewcommand{\thebibliography}` wrapper | olplainarticle.cls:198-205 | yes | a toc entry (`toc.kernel`) plus three lengths set after the list opens (`sp.lengths`); no logic. Exact spacing under natbib is not checked |
| `\renewcommand{\@biblabel}` | olplainarticle.cls:130 | yes | one label format from `mark.kernel` and `color.xcolor`; probably unused under apalike |
| unused loads `ifthen`, `calc`, `ifpdf`, `lipsum`, `lastpage`, `float`, `booktabs`, `enumitem` | olplainarticle.cls:12-13, 25, 26, 30, 51, 126, 196 | yes | no use found in either file (grep: no `\ifthenelse`, `\widthof`, `\ifpdf`, `\lipsum`, `\pageref{LastPage}` outside a comment, `\toprule`); they print nothing here. `ifthen`, `calc` and `ifpdf` have no lib way and need none, since they produce no look; `lipsum` is dummy-text content |

## Content-opaque
- Placeholder figure `\fbox{\rule{0pt}{3cm}\rule{0.7\linewidth}{0pt}}` inside the figure float (main.tex:45): artwork placeholder, content.
- Display equation for `S_n` and the CLT sentence (main.tex:62-67): content.
- `lipsum` is loaded (olplainarticle.cls:196) but never called; dummy text would be content.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Nothing in the zip addresses an AI; no instructions found to quote.
- Reading the mixed signals: the class is zip-local (not on CTAN), but everything it does is a composition of published packages and kernel commands. If a stricter reading treats the `\@maketitle` and capture-`abstract` redefinitions as irreducible kernel surgery, this file would flip to `no` (`BESPOKE/class`).
- Not read: the source of natbib, titling, titlesec, authblk and other published packages (they are not in the zip); statements about `times` selecting Helvetica and natbib's use of `\@biblabel` come from general knowledge, not from files here.
