yes

# 0012-basic-academic-journal-article: Basic academic journal article (Overleaf `olplainarticle`, single column)

- Unverified: read from the source, not compiled.
- Source: Source/0012-basic-academic-journal-article/ (origin: https://latextemplates.com/downloads/basic-academic-journal-article.zip; licence: CC-BY-4.0, author credit John Hammersley, ATTRIBUTION.txt:1-8)
- Kind: journal
- Lib: v1
- Engine: pdfLaTeX-compatible (inputenc utf8, `times`/`mathptmx` PostScript fonts, no fontspec; olplainarticle.cls:9,20-21)
- Look carried by: zip-local (olplainarticle.cls defines the whole look; main.tex only supplies content and calls its commands)
- Class origin: zip-local (`olplainarticle` is not on CTAN: ctan.org/pkg/olplainarticle returned 404; the zip is a latextemplates.com repackaging of an Overleaf gallery template, not an official release; olplainarticle.cls:1-6 says it is based on the SelfArx class)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (olplainarticle.cls, 204 lines, read in full; references.bib read; published packages natbib, titling, authblk, titlesec, titletoc not read)

## Verdict
Yes, with one judgement call. The look sits in a zip-local class that is `\LoadClass{article}` plus published packages and their declarative settings, plus three kernel redefinitions (`\@maketitle`, `\abstract`, `\thebibliography`) and a `lineno` option. Each redefinition is a vertical stack of kernel box, skip and font commands or a relocation device, not a layout algorithm, so each reduces to lib ways (reductions below). There is no artwork, no external tool and no unmapped component. A reviewer who reads the rubric's `\@maketitle` example literally would flip this to `no`, with BESPOKE/class at olplainarticle.cls:137-146, 151-180 and 198-205.

## Blockers
none

## Class setting
- Class: `class.article` (olplainarticle.cls:19 `\LoadClass{article}`); options `fleqn,10pt` (main.tex:1) are passed through unchanged by `\DeclareOption*` (olplainarticle.cls:17-18); the zip-local class itself is not a way (zip-local, reducible to `class.article` plus the rows below).
- Class-native vocabulary used (all zip-local, none from the kernel class): `\keywords{}` (main.tex:12), `abstract` environment placed before `\begin{document}` (main.tex:14-19), `\author[n]{}` and `\affil[n]{}` (authblk, main.tex:7-10), `\maketitle` (main.tex:24), numberless `\section*`/`\subsection*` (main.tex:27-77), `\citep` (main.tex:30), `\bibliography{references}` with the class's own `\bibliographystyle{apalike}` (olplainarticle.cls:45). The class also offers a `lineno` option (olplainarticle.cls:15-16), unused in the sample (main.tex:2-3 comment).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1; olplainarticle.cls:17-19 | `class.article` | fleqn, 10pt |
| paper size and margins | olplainarticle.cls:33-38 | `page.geometry` | letterpaper, left=3cm, right=3cm, top=2.25cm, bottom=2.25cm, headheight=12pt |
| base font size | main.tex:1 | `page.class-options` | 10pt |
| single column | (default; `\columnsep` 0.55cm set but unused, olplainarticle.cls:182) | `sp.lengths` | columnsep=0.55cm (no effect in one column) |
| text face | olplainarticle.cls:20-21 | `font.mathptmx` | `times` then `mathptmx` (roman Times, math Times) |
| sans face | olplainarticle.cls:20 (`times` sets `\sfdefault`=phv), 60, 69-100 | `font.helvet` | Helvetica (phv) through psnfss `times`; used by `\sffamily` |
| encoding | olplainarticle.cls:9 | `font.fontenc-t1` | inputenc only, utf8 (no fontenc, OT1 default) |
| font selection in title block | olplainarticle.cls:155,157,161,168,189-190 | `font.size-commands` | `\fontsize{20}{25}`, `\fontsize{12}{16}`, `\fontsize{12}{14}`, `\fontsize{10}{12}`, `\large`, `\small`, kernel `\usefont{OT1}{phv}{b}{n}` (same family as `font.helvet`) |
| language | olplainarticle.cls:10, 187 | `lang.babel` | english; `\keywordname` = "Keywords:" |
| microtype | olplainarticle.cls:14 | `sp.microtype` | defaults, loaded `\AtEndOfClass` |
| paragraph spacing | olplainarticle.cls:27 | `sp.parskip-pkg` | defaults |
| colours | olplainarticle.cls:29, 185-186 | `color.xcolor` | color1 = RGB 0,0,0 (headings, ABSTRACT label, keywords label, bib label); color2 = RGB 182,193,251 (abstract box) |
| header and footer | olplainarticle.cls:50-62 | `hf.fancyhdr` | `\pagestyle{fancy}`; lhead, chead, rhead, lfoot, cfoot empty; `\rfoot{\small\sffamily\bfseries\thepage}`; headrulewidth=0pt, footrulewidth=0pt |
| first-page style | main.tex:25 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` after `\maketitle` (article's `\maketitle` forces `plain` last) |
| page X of Y | olplainarticle.cls:51, 60 | `pgnum.lastpage` | loaded only; `\pageref{LastPage}` is commented out |
| flush bottom | main.tex:23 | `pg.flush` | `\flushbottom` |
| title (title block, reduction of `\@maketitle`) | olplainarticle.cls:151-156 | `front.titling` | pretitle: `\vskip-36pt\raggedright\sffamily\bfseries\fontsize{20}{25}\selectfont`; posttitle: `\par\vskip10pt`; `\date{}` with empty predate/postdate (no date printed) |
| authors and affiliations | main.tex:7-10; olplainarticle.cls:31, 157-158, 189-190 | `front.authblk` | `\author[1]` `\affil[1]`; Authfont=`\fontsize{12}{14}\usefont{OT1}{phv}{b}{n}`; Affilfont=`\fontsize{10}{12}\usefont{OT1}{phv}{b}{n}`; printed via `\theauthor` under `front.titling` preauthor `\raggedright\sffamily\fontsize{12}{16}\selectfont`, postauthor `\par\vskip18pt` |
| ABSTRACT label | olplainarticle.cls:159-162 | `box.minipage` | `\parbox{\dimexpr\linewidth-2\fboxsep\relax}{\color{color1}\large\sffamily\textbf{ABSTRACT}}` then `\vskip10pt` (`sp.manual-space`) |
| abstract content | main.tex:14-19 | `abs.kernel` | content of the abstract node; the abstract env in the sample is the class's capture macro (see Bespoke code) |
| abstract tinted box | olplainarticle.cls:165-171 | `box.fancybox` | `\colorbox{color2}{\parbox{\dimexpr\linewidth-2\fboxsep\relax}{\sffamily\small\vskip1ex ...}}`; `\colorbox` is the xcolor sibling of `\fcolorbox`; then `\vskip18pt` |
| keywords line | main.tex:12; olplainarticle.cls:135, 172-176, 187 | `abs.keywords` | `{\color{color1}Keywords:\hspace*{1em}}` then the keyword text, in a `\parbox` of the same width; `\vskip25pt` after the block |
| line numbers (option) | olplainarticle.cls:15-16, 22-23, 163, 168, 174 | `sp.draft-lineno` | `lineno` loaded always; `\linenumbers` only when option given; `\nolinenumbers` before the abstract box, `\internallinenumbers` inside its parboxes when numbered; off in the sample |
| section heading | olplainarticle.cls:67-79, 97 | `head.titlesec` | `explicit`; `\section`: `\color{color1}\large\sffamily\bfseries`, label `\thesection`, sep 0.5em, title `\MakeUppercase{#1}`; numberless form same, empty label, sep 0em; spacing before 3ex plus4pt minus3pt, after 5pt, left 0pc |
| subsection heading | olplainarticle.cls:80-85, 98 | `head.titlesec` | `\sffamily\bfseries`, label `\thesubsection`, sep 0.5em, title `#1`; before 1.5ex plus1.5pt minus2pt, after 0pt |
| subsubsection heading | olplainarticle.cls:86-91, 99 | `head.titlesec` | `\sffamily\small\bfseries\itshape`, sep 0.5em; before 2ex plus2.5pt minus1.5pt, after 0pt (not in sample) |
| paragraph heading | olplainarticle.cls:92-96, 100 | `head.titlesec` | `runin`, `\sffamily\small\bfseries`, sep 0em; before 1.5ex plus2pt minus1pt, after 10pt (not in sample) |
| contents depth | olplainarticle.cls:194 | `num.secnumdepth` | tocdepth=3 |
| contents styling | olplainarticle.cls:105-124, 192-193 | `toc.titletoc` | `\contentsmargin{0cm}`; section entry `[\tocsep]` bold sans small, leader-less with `\hfill\thecontentspage`; subsection entry sans small with `\titlerule*[.5pc]{.}`; subsubsection run-in `\titlecontents*` footnotesize sans with `\textbullet` separator; `\tocsep`=1.5pc (`sp.lengths`); no `\tableofcontents` in the sample |
| lists | olplainarticle.cls:126-127 | `list.enumitem` | loaded only; `\setlist{nolistsep}` commented out |
| display maths | main.tex:65 | `math.kernel` | `$$...$$` with class option `fleqn` |
| equation alignment | main.tex:1 | `math.eqnumber` | `fleqn` (flush-left displays) |
| math packages | olplainarticle.cls:28; main.tex:63-64 | `math.amsmath` | `\text{}` used in inline maths; `amsfonts`, `amssymb` also loaded |
| math symbols | olplainarticle.cls:28 | `math.amssymb` | loaded; sample uses `\mathcal`, `\to`, `\sum` |
| figure float | main.tex:43-48; olplainarticle.cls:29 | `fig.graphicx` | `figure[ht]`, `\centering`; no `\includegraphics` (placeholder box); `float` loaded but `[H]` unused (olplainarticle.cls:26) |
| figure placeholder | main.tex:45 | `box.fancybox` | `\fbox{\rule{0pt}{3cm}\rule{0.7\linewidth}{0pt}}` (`sp.rule`); frame width set by `\fboxrule`=0.75pt (olplainarticle.cls:183) |
| caption | main.tex:46, 57; olplainarticle.cls:40-42 | `cap.caption` | labelfont={bf,sf}, labelsep=period, justification=raggedright; `\caption` kernel (`cap.kernel`) |
| table | main.tex:50-58 | `tbl.tabular` | `tabular{l|r}`, `\hline`; `booktabs` loaded (olplainarticle.cls:30) but not used by the sample's table |
| cross-references | main.tex:39, 47, 57 | `xref.kernel` | `\label`, `\ref`; no hyperref loaded |
| citations | main.tex:30; olplainarticle.cls:44 | `bib.natbib` | default options, `\citep` |
| bibliography | main.tex:81; olplainarticle.cls:45 | `bib.bibtex-bst` | `\bibliographystyle{apalike}`, `\bibliography{references}`, references.bib:1-9 |
| bibliography label and spacing | olplainarticle.cls:130, 198-205 | `bib.thebibliography` | `\@biblabel` kernel hook set to `\bfseries\color{color1}\textsuperscript{[#1]}`; spacing via natbib `\bibsep` (see Bespoke code) |
| marks | olplainarticle.cls:161, 72, 130 | `mark.kernel` | `\textbf`, `\textsuperscript`, `\MakeUppercase` |
| acknowledgements | main.tex:77-79 | `head.titlesec` | an ordinary numberless section, no special way |

Load-only helpers with no template effect, so no row: `ifthen`, `calc`, `ifpdf` (olplainarticle.cls:12-13, 25), `lipsum` (olplainarticle.cls:196, not called by the sample).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `olplainarticle.cls` as a class | olplainarticle.cls:1-205 | yes | `class.article` plus the preamble ways in the map above, in the order the class loads them |
| `lineno` option, `\if@reqslineno` | olplainarticle.cls:15-16, 23, 168, 174 | yes | boolean switch for `sp.draft-lineno`: `\usepackage{lineno}\linenumbers`; `\nolinenumbers` and `\internallinenumbers` are lineno's own commands; off in the sample |
| option pass-through | olplainarticle.cls:17-18 | yes | `fleqn,10pt` written straight on `class.article` |
| `\keywords`, `\@keywords`, `\keywordname` | olplainarticle.cls:135, 175, 187 | yes | `abs.keywords`: a keyword line `{\color{color1}Keywords:\hspace*{1em}}text`; `\keywordname` is a string alias |
| `\abstract` capture macro (`\long\def\abstract#1\end#2`, `\theabstract`) | olplainarticle.cls:137-146 | yes | a relocation device: it stores the abstract so `\@maketitle` can print it. An emitter writes the abstract at its place after `\maketitle` as the `box.fancybox` + `box.minipage` wrapper; the error branch only prints a warning for malformed input and no layout depends on it. It also calls `\end{abstract}` through article's `\endabstract` (not verified how that behaves) |
| `\@maketitle` redefinition | olplainarticle.cls:151-180 | yes | stack of kernel commands: title, author block, ABSTRACT label, tinted abstract box, keyword line, with `\vskip` gaps (-36pt, 10pt, 18pt, 10pt, 18pt, 25pt). Written as `front.titling` hooks (pretitle, posttitle, preauthor, postauthor, empty date) plus body wrappers `box.minipage`, `box.fancybox`, `abs.keywords`, `sp.manual-space`; no algorithm, no counters |
| `\Authfont`, `\Affilfont` | olplainarticle.cls:189-190 | yes | authblk's documented font hooks, set as `front.authblk` parameters |
| `\@biblabel` | olplainarticle.cls:130 | yes | kernel list-label hook; one-line label format. Whether natbib with an apalike `.bst` prints it was not checked (natbib not read) |
| `thebibliography` wrapper (`\let\oldbibliography`, `\renewcommand\thebibliography`) | olplainarticle.cls:198-205 | yes, weakest reduction | effect is an unnumbered toc entry (`\addcontentsline{toc}{section}{\hspace*{-\tocsep}\refname}`, invisible: the sample has no `\tableofcontents`; `toc.etoc` `tocbibind` or the kernel command), itemsep 0pt, parindent 0pt and parskip=`\baselineskip` inside the list. With natbib this is item gap = `\baselineskip`, i.e. `\setlength{\bibsep}{\baselineskip}` (`bib.natbib`) plus `sp.lengths`. Assumes natbib's list resets parsep to 0, from memory, not read here |
| `\tocsep` length | olplainarticle.cls:192-193 | yes | `\newlength` + `\setlength` as a parameter of `toc.titletoc` entries |
| `\definecolor`, `\fboxrule`, `\columnsep` | olplainarticle.cls:182-186 | yes | `color.xcolor`; `sp.lengths` (note `\fboxrule` also frames the sample's placeholder `\fbox`, main.tex:45) |
| `\titlespacing` with `\@plus` `\@minus` | olplainarticle.cls:97-100 | yes | ordinary stretchable glue values for `head.titlesec` |

## Content-opaque
- Figure placeholder `\fbox{\rule...}` (main.tex:45), table cells (main.tex:52-56), displayed and inline equations (main.tex:62-67): content, expressible by existing ways anyway.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes: nothing in the zip is addressed to an AI. The class lacks `\bibliographystyle` in main.tex; it is set in the class (olplainarticle.cls:45). `main.tex:2-3` only comments on the `lineno` option.
