yes

# 0677-cqjtuthesis: cqjtuthesis (Chongqing Jiaotong University thesis template)

- Unverified: read from the source, not compiled.
- Source: Source/0677-cqjtuthesis/ (origin: https://mirrors.ctan.org/macros/latex/contrib/cqjtuthesis.zip; licence: LPPL 1.3c)
- Kind: thesis
- Lib: v5 (the snapshot you read)
- Engine: needs XeLaTeX (tex/cqjtuthesis.cls:37 `\RequireXeTeX`; `\setmainfont` at :98; ctex CJK fonts)
- Look carried by: class (tex/cqjtuthesis.cls defines page, headings, cover, declaration, abstracts, header/footer, captions; the samples only set field values and supply content)
- Class origin: ctan
- Main file: examples/cqjtuthesis-bachelor.tex (other samples: examples/cqjtuthesis-master.tex, examples/cqjtuthesis-professional.tex, examples/cqjtuthesis-doctor.tex, doc/cqjtuthesis-doc.tex, the manifest's main, a user guide on ctexart)
- Read: main yes, zip-local classes and styles all (tex/cqjtuthesis.cls, 712 lines; ctexbook and gbt7714 sources are not in the zip and were not read)

## Verdict
yes. The look is carried by `cqjtuthesis`, a class published on CTAN (ctan.org/pkg/cqjtuthesis read: v1.0.2 of 2026-02-11, LPPL 1.3c, path /macros/latex/contrib/cqjtuthesis; the manifest origin is the CTAN mirror), and every sample only calls `\documentclass[degree=...]`, field setters and content. Read under the stricter test that treats the class source as zip-local, all of its macros still reduce to lib ways (hand-laid cover and declaration pages, abstract environments, header/footer, counter formats, titlesec/titletoc/caption settings): there is no output routine, `\halign`, expl3/Lua, kernel-internal redefinition or TikZ. XeLaTeX is required; system fonts, the `gbt7714-numerical.bst` style (CTAN `gbt7714`, not in the zip) and the university logo images (restricted-use notice at README.md:83-97) are assets to ship or note, not blockers.
Observations that do not change the verdict: `\CQJTU@degreetype` is read at cls:400 and cls:421 while the key is declared `degree-type` at cls:31 (how kvoptions names that macro was not checked); `\classnum` and `\professionaltype` are defined (cls:264, cls:282) but never printed; `\cqjtuthesis@coverline` (cls:298) is never called; `CJKnumb` is loaded (cls:59) and never used.

## Blockers
none

## Class setting
- Class: `class.cqjtuthesis` options: `degree=bachelor|master|doctor` (default bachelor, cls:30), `degree-type=academic|professional` (default academic, cls:31); any other option goes to ctexbook (cls:32). It loads `class.ctexbook` with `a4paper,12pt,openany,oneside` (cls:35). Samples: `\documentclass{../tex/cqjtuthesis}` (examples/cqjtuthesis-bachelor.tex:6), `[degree=master]` (examples/cqjtuthesis-master.tex:4), `[degree=master, degree-type=professional]` (examples/cqjtuthesis-professional.tex:4), `[degree=doctor]` (examples/cqjtuthesis-doctor.tex:4).
- Class-native vocabulary used: `\makecover`, `\makedeclaration`; field setters `\title` (renewed to store `\@ctitle`, cls:252), `\englishtitle`, `\author`, `\studentid`, `\school`, `\major`, `\cohort`, `\classnum`, `\advisor`, `\completedate`, `\coverlogo{blue|red|legacy}`, graduate fields `\clc`, `\securitylevel`, `\discipline`, `\subdiscipline`, `\professionalfield`, `\degreecategory`, `\submitdate`, `\defenddate`; environments `cabstract`, `eabstract`, `acknowledgement`; commands `\ckeywords`, `\ekeywords`; the superscript `\cite` wrapper; the redefined `\appendix`; `\frontmatter` and `\mainmatter` as wrapped by the class, `\backmatter` and `\chapter*` from ctexbook; ctex's `\zihao`, `\songti`, `\heiti`, `\kaishu`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | examples/cqjtuthesis-bachelor.tex:6; tex/cqjtuthesis.cls:35 | `class.cqjtuthesis` | degree, degree-type (see Class setting) |
| underlying class | tex/cqjtuthesis.cls:35 | `class.ctexbook` | a4paper, 12pt, openany, oneside; book `\frontmatter` `\mainmatter` `\backmatter` |
| paper, size, sides | tex/cqjtuthesis.cls:35 | `page.class-options` | a4paper, 12pt, oneside, openany |
| page geometry, bachelor | tex/cqjtuthesis.cls:61-72 | `page.geometry` | top=2.5cm, bottom=2.0cm, left=3.0cm, right=2.0cm, headheight=1cm, headsep=0.5cm, footskip=1cm |
| page geometry, master/doctor | tex/cqjtuthesis.cls:77-87 | `page.geometry` | top=3.0cm, bottom=2.5cm, left=3.0cm, right=3.0cm, bindingoffset=0.5cm, headheight=0.5cm, headsep=0.5cm, footskip=1.0cm |
| header/footer, bachelor | tex/cqjtuthesis.cls:117-133 | `hf.fancyhdr` | `\fancyhf{}`; head[C] `\zihao{-5}\songti` text "school, cohort, major, thesis name"; foot[C] `\zihao{5}\thepage`; headrulewidth 0.4pt, footrulewidth 0pt |
| header/footer, graduate | tex/cqjtuthesis.cls:136-143 | `hf.fancyhdr` | head[CE] school and degree name, head[CO] `\leftmark`, foot[C] `\zihao{-5}\thepage`; headrulewidth 0.4pt |
| front-matter page style, plain alias | tex/cqjtuthesis.cls:146-169 | `hf.fancyhdr`, `hf.pagestyle-kernel` | `\fancypagestyle{frontmatter}` (foot[C] page number, no rules); `\pagestyle{frontmatter}` after `\frontmatter`, `\pagestyle{fancy}` after `\mainmatter`; `\let\ps@plain` alias |
| front-matter page numbers | tex/cqjtuthesis.cls:153-157 | `pgnum.pagenumbering` | roman front matter comes from the ctexbook `\frontmatter` (its source not read) |
| title and cover, bachelor | tex/cqjtuthesis.cls:312-367 | `front.class-native`, `front.titlepage-env`, `fig.graphicx`, `box.minipage`, `tbl.tabular`, `mark.ulem`, `sp.manual-space` | `titlepage`; `\includegraphics[width=10cm]`; `\zihao{2}\heiti`; minipage 14cm and 12cm; `tabular{cl}`; `\uline{\makebox[8cm][l]{..}}`; `\vfill` |
| title and cover, graduate | tex/cqjtuthesis.cls:370-445 | `front.class-native`, `front.titlepage-env`, `fig.graphicx`, `box.minipage`, `tbl.tabular`, `mark.ulem`, `sp.manual-space` | two minipages 0.5\textwidth with `tabular{@{}r@{..}l@{}}`; `\zihao{1}\heiti\bfseries`; `\arraystretch` 1.8 and 1.5; professional variant tabular at :423-427 |
| cover field strings, logo choice | tex/cqjtuthesis.cls:247-295, :320-330 | `front.class-native` | `\coverlogo` blue/red/legacy picks one of the files examples/figures/cqjtu-logo-*.png or .tif; `\@completedate` default `\the\year 年\the\month 月` (cls:271) |
| declaration and copyright pages | tex/cqjtuthesis.cls:449-583 | `front.dedication`, `pg.break`, `hf.pagestyle-kernel`, `box.minipage`, `sp.rule`, `sp.ragged`, `mark.ulem` | `\cleardoublepage`, `\thispagestyle{empty}`, `\setstretch{1.5}`, `\parindent` 2em, `\rule{\textwidth}{0.4pt}`, two minipages 0.48\textwidth |
| Chinese abstract | tex/cqjtuthesis.cls:584-608; examples/contents/abstract.tex:4 | `abs.class-native`, `sp.setspace`, `sp.lengths`, `sp.linespread` | bachelor `\zihao{-3}\heiti`, `\setstretch{1.5}`; graduate `\zihao{3}\heiti`, `\parindent` 2em, `\linespread{1.0}`, `\baselineskip` 20pt; `\addcontentsline{toc}{chapter}`, `\phantomsection` |
| English abstract | tex/cqjtuthesis.cls:618-644; examples/contents/abstract.tex:16 | `abs.class-native`, `sp.setspace`, `sp.lengths`, `sp.linespread` | bachelor title `\@etitle` and "Abstract" `\zihao{-3}\bfseries`, `\setstretch{1.5}`; graduate "ABSTRACT" `\zihao{3}\heiti`, baselineskip 20pt |
| keywords | tex/cqjtuthesis.cls:610-617, :646-653; examples/contents/abstract.tex:12, :22 | `abs.keywords` | `\ckeywords{..}` bold-face label "关键词：" `\zihao{-4}\heiti`; `\ekeywords{..}` "Key Words: " / "KEY WORDS: " `\bfseries` |
| acknowledgement | tex/cqjtuthesis.cls:662-671; examples/contents/thanks.tex:3 | `front.dedication` | `\clearpage`, `\addcontentsline{toc}{chapter}{致谢}`, centred `\zihao{-3}\heiti`; graduate sample adds `\vspace{2\baselineskip}` and `flushright` (examples/contents-graduate/thanks.tex:23-25) |
| contents list | examples/cqjtuthesis-bachelor.tex:40; tex/cqjtuthesis.cls:202-219 | `toc.kernel`, `toc.titletoc` | `\contentsname` 目 录 `\zihao{3}\heiti`; `\titlecontents` chapter [0pt], section [2em], subsection [4em]; leader `\titlerule*[6pt]{.}` |
| chapter headings | tex/cqjtuthesis.cls:171-179 | `head.class-native` | `\ctexset{chapter={format=\centering\zihao{3}\heiti, name={第,章}, number=\arabic{chapter}, beforeskip=-10pt, afterskip=20pt}}` |
| section headings | tex/cqjtuthesis.cls:182-201 | `head.titlesec` | `\titleformat` section (bachelor `\zihao{4}\heiti`, graduate `\zihao{-3}\heiti`), subsection and subsubsection `\zihao{-4}\heiti`; label `\thesection` sep 1em; `\titlespacing*` 0pt 12pt 6pt |
| appendix | tex/cqjtuthesis.cls:672-681; examples/cqjtuthesis-bachelor.tex:60 | `num.appendix`, `num.counters`, `head.titlesec` | `\setcounter{chapter}{0}`, `\thechapter`=附录\Alph, `\titleformat{\chapter}` centred `\zihao{3}\heiti` |
| unnumbered chapter | examples/contents-graduate/achievements.tex:12-16 | `head.kernel`, `toc.kernel`, `lang.cjk`, `sp.lengths` | `\chapter*`, `\addcontentsline{toc}{chapter}`, `\zihao{-4}\songti`, `\parindent` 2em |
| counters and numbers | tex/cqjtuthesis.cls:241-246 | `num.counters` | `\@addtoreset` figure, table, equation in chapter; `\thefigure`, `\thetable`, `\theequation` = chapter-number |
| CJK fonts and sizes | tex/cqjtuthesis.cls:129, :173, :238; :59 | `lang.cjk` | ctex `\zihao`, `\songti`, `\heiti`, `\kaishu`; `CJKnumb` loaded (cls:59), no use found |
| Latin main font | tex/cqjtuthesis.cls:97-104 | `font.fontspec` | `\setmainfont{Times New Roman}` else `TeX Gyre Termes`, via `\IfFontExistsTF` |
| paragraph and line spacing | tex/cqjtuthesis.cls:706-708, :163-169 | `sp.linespread`, `sp.lengths`, `sp.indentfirst` | `\linespread{1.5}`, `\parindent` 2em, `\parskip` 0pt; graduate `\mainmatter` sets `\linespread{1.0}`, `\baselineskip` 20pt; `indentfirst` (cls:50) |
| display and float spacing | tex/cqjtuthesis.cls:695-702 | `sp.lengths`, `fig.placement` | `\floatsep` 10pt plus 2pt minus 2pt, `\textfloatsep` 12pt, `\intextsep` 10pt; `\abovedisplayskip` 10pt and the other display skips; `\emergencystretch` 1em |
| widows and clubs | tex/cqjtuthesis.cls:703-705 | `sp.penalties` | `\clubpenalty`, `\widowpenalty`, `\displaywidowpenalty` = 10000 |
| lists | tex/cqjtuthesis.cls:694; examples/contents/chapter01.tex:13-18, :24-35 | `list.kernel`, `list.enumitem` | `\setlist{topsep=6pt, itemsep=0pt, parsep=0pt, partopsep=0pt}`; itemize, enumerate; enumerate label `{[\arabic*]}` (examples/contents-graduate/achievements.tex:19) |
| figure | examples/contents/chapter01.tex:63-68 | `fig.graphicx`, `sp.ragged`, `xref.kernel` | `[htbp]`, `\centering`, `\includegraphics[width=0.6\textwidth]`, `\caption`, `\label`; `\graphicspath{{figures/}}` (bachelor.tex:22) |
| table | examples/contents/chapter01.tex:76-88; examples/contents-graduate/appendix.tex:15-27 | `tbl.tabular`, `tbl.booktabs` | `[htbp]`, `\centering`, `tabular{ccc}`, `\toprule` `\midrule` `\bottomrule`; `tabularx`, `longtable`, `multirow` loaded (cls:52-54) |
| captions | tex/cqjtuthesis.cls:220-239 | `cap.caption`, `cap.kernel` | `labelsep=space, font={small,bf}, textfont=small, justification=centering, singlelinecheck=false`; figure `position=bottom, aboveskip=6pt, belowskip=6pt`; table `position=top`; `\DeclareCaptionFormat{cqjtu}{{\heiti\zihao{5}#1#2}#3}` |
| equations | examples/contents/chapter01.tex:96-99; examples/contents/chapter02.tex:35-38, :44-49, :73-79 | `math.amsmath`, `math.amssymb`, `math.kernel` | `equation`, `align`, `subequations`, `bmatrix`, `\notag`, `\eqref`; amsmath cls:44, amssymb cls:46 |
| theorem-like | tex/cqjtuthesis.cls:45 | `thm.amsthm` | `amsthm` loaded; no `\newtheorem` anywhere in the zip |
| code | examples/contents/appendix.tex:11-30, :36-46; doc/cqjtuthesis-doc.tex:7, :18-25, :68-72 | `code.verbatim`, `code.listings` | `verbatim`; doc `\lstset{basicstyle=\ttfamily\small, breaklines=true, frame=single, backgroundcolor=\color{gray!10}, keywordstyle=\color{blue}, stringstyle=\color{red}}`, `lstlisting[language=TeX]` |
| bibliography | tex/cqjtuthesis.cls:654-657; examples/cqjtuthesis-bachelor.tex:54; examples/cqjtuthesis-doctor.tex:61-62 | `bib.bibtex-bst`, `bib.natbib`, `sp.lengths`, `sp.setspace` | `\bibliographystyle{gbt7714-numerical}`; natbib `sort&compress,square,super` (cls:55); `\bibname` 参考文献; `\bibsep` 0pt; `\nocite{..}` list; thebibliography hook sets `\zihao{5}\songti\setstretch{1}` |
| citations | tex/cqjtuthesis.cls:660-661; examples/contents/chapter01.tex:49 | `bib.natbib`, `mark.kernel` | `\cite[#1]{#2}` wrapped in `\textsuperscript` |
| cross-references | examples/contents/chapter01.tex:61, :67, :74, :98; tex/cqjtuthesis.cls:56 | `xref.kernel`, `xref.hyperref` | `\ref`, `\label`, `\eqref`; hyperref loaded |
| PDF and link settings | tex/cqjtuthesis.cls:682-693 | `meta.hyperref` | `colorlinks=true, linkcolor=black, citecolor=black, urlcolor=blue, bookmarksnumbered, bookmarksopen`, `pdftitle`, `pdfauthor`, `pdfsubject`, `pdfkeywords` |
| colour | tex/cqjtuthesis.cls:43 | `color.xcolor` | `xcolor` loaded; colours only through hyperref and the doc's listings |
| underline, text marks | tex/cqjtuthesis.cls:58, :306-307; examples/contents/chapter01.tex:26 | `mark.ulem`, `mark.kernel` | `ulem[normalem]`, `\uline`, `\ULdepth` 2pt, `\ULthickness` 0.4pt; `\textbf` |
| user guide (doc) class and page | doc/cqjtuthesis-doc.tex:1-3 | `class.ctexart`, `page.geometry`, `meta.hyperref` | `a4paper,12pt`; geometry top=2.5cm, bottom=2.5cm, left=3cm, right=2.5cm; hyperref `colorlinks=true, linkcolor=blue, filecolor=magenta, urlcolor=cyan` (:11-16) |
| user guide front and numbering | doc/cqjtuthesis-doc.tex:27-43 | `front.maketitle`, `pgnum.pagenumbering`, `toc.kernel`, `head.kernel`, `hf.pagestyle-kernel` | `\pagenumbering{gobble}`, `{Roman}`, `{arabic}`, `\setcounter{page}{1}`; `\renewcommand{\sectionmark}[1]{\markright{#1}}`; `\thispagestyle{empty}` |
| user guide tables and lists | doc/cqjtuthesis-doc.tex:50, :116-135, :222 | `list.kernel`, `list.enumitem`, `tbl.longtable`, `tbl.booktabs`, `tbl.tabular` | `longtable{llll}`, `tabular{ll}` with `\toprule` `\midrule` `\bottomrule`; `enumitem` loaded (:9) |

## Bespoke code
All items sit in the published class (look carried by the class); the reduction shows they would also pass if the class were zip-local.
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\makecover`, `\cqjtuthesis@covertitlebox`, `\cqjtuthesis@covertitlewidth`, logo selection | tex/cqjtuthesis.cls:296-448 | yes | `front.titlepage-env` with `fig.graphicx`, `box.minipage`, `tbl.tabular`, `mark.ulem`, `sp.manual-space`; the `\ifdefstring` chains only pick one fixed branch and one image file per option value |
| `\makedeclaration` | tex/cqjtuthesis.cls:449-583 | yes | `front.dedication` over `pg.break`, `hf.pagestyle-kernel`, `box.minipage`, `sp.rule`, `sp.setspace`, `mark.ulem`; static text and spacing, branch on degree |
| `cabstract` and `\ckeywords` | tex/cqjtuthesis.cls:584-617 | yes | `abs.class-native`, `abs.keywords`: `\clearpage`, `\addcontentsline`, centred heading, font and spacing switches |
| `eabstract` and `\ekeywords` | tex/cqjtuthesis.cls:618-653 | yes | same ways as the Chinese abstract |
| `acknowledgement` | tex/cqjtuthesis.cls:662-671 | yes | `front.dedication`: `\clearpage`, `\addcontentsline`, centred heading |
| `\appendix` redefinition | tex/cqjtuthesis.cls:672-681 | yes | `num.appendix`, `num.counters` (`\thechapter` format), `head.titlesec` (`\titleformat{\chapter}`) |
| `\frontmatter` and `\mainmatter` wrappers, `frontmatter` page style, `\cqjtuthesis@applyfancy` | tex/cqjtuthesis.cls:125-169 | yes | `hf.fancyhdr` styles plus `\pagestyle` calls placed after `\frontmatter` and `\mainmatter`; `plain` alias is `\fancypagestyle{plain}`; graduate line settings are `sp.linespread` and `sp.lengths` |
| `\cite` wrapper | tex/cqjtuthesis.cls:660-661 | yes | `bib.natbib` `super` option or a body wrapper `\textsuperscript{\cite{..}}` (`mark.kernel`) |
| field setters, `\title` redefinition, `\completedate` default | tex/cqjtuthesis.cls:247-295 | yes | `\def` storage of strings printed by the cover; inline expansion into the cover text |
| degree and degree-type option branching | tex/cqjtuthesis.cls:28-33, :61-88, :125-144 | yes | class options of `class.cqjtuthesis`; an emitter writes the chosen branch only |
| counter resets and printed numbers | tex/cqjtuthesis.cls:241-246 | yes | `num.counters`: `\@addtoreset`/`\counterwithin`, `\renewcommand\thefigure` etc. |
| `\AtBeginEnvironment{thebibliography}` hook | tex/cqjtuthesis.cls:657 | yes | a group `{\zihao{5}\songti\setstretch{1}\bibliography{..}}` around the body call (`sp.setspace`, `lang.cjk`); considered: etoolbox hook, not proposed |
| dead code: `\cqjtuthesis@coverline`; unused `CJKnumb` | tex/cqjtuthesis.cls:298-300; :59 | yes | never called or used, nothing to emit |

## Content-opaque
none (the one figure is the included picture examples/figures/image012.jpg at examples/contents/chapter01.tex:65, held by `fig.graphicx`; the cover logos are shipped image files, no drawing code)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
