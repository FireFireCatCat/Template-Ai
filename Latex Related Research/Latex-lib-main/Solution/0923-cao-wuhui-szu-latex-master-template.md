no

# 0923-cao-wuhui-szu-latex-master-template: SZU master's thesis template (Shenzhen University)

- Unverified: read from the source, not compiled.
- Source: Source/0923-cao-wuhui-szu-latex-master-template/ (origin: https://codeload.github.com/Cao-Wuhui/SZU_Latex_Master_Template/zip/refs/heads/main; licence: MIT, LICENSE in the zip and README.md:17)
- Kind: thesis
- Lib: v6
- Engine: needs XeLaTeX (`fontspec` `\setmainfont`/`\newfontfamily`/`\IfFontExistsTF`, ctex with xeCJK-style CJK fonts; README.md:7 says to switch the compiler to XeLaTeX, .github/workflows/build.yml:22 `latexmk_use_xelatex: true`)
- Look carried by: mixed (zip-local szu-master.cls defines the abstract, contents, heading, appendix pages and head rule on top of ctexart; master_pang.tex adds margins, footnote marks, theorems, per-chapter numbering, bibliography spacing)
- Class origin: zip-local (szu-master.cls is a community class of the SZU template; it loads the published ctexart; not checked on CTAN, the 3 allowed CTAN reads went to slashbox, bibspacing and gbt7714)
- Main file: master_pang.tex (other samples: none; it `\input`s chapter/abstract.tex, cp1.tex to cp5.tex, sign_and_ABC.tex, thanks.tex, myPapers.tex and tables/EXP.tex)
- Read: main yes, zip-local classes and styles all (szu-master.cls, bibspacing.sty, slashbox.sty, gbt7714.sty, other-old-file gbt7714.sty and slashbox/slashbox.tex read in full; slashbox/slashbox.sty is byte-identical to the root copy by hash); the .bst files only partly (headers)

## Verdict
Almost everything reduces: szu-master.cls is `\LoadClass{ctexart}` plus package loads and body wrappers made of lib ways, bibspacing.sty is a copy of the kernel `thebibliography`, and slashbox.sty is a CTAN package that is loaded but never called. The answer is `no` on one construct: the circled footnote mark, a hand-written `\ifcase` table of 50 glyphs with a font fallback chain bound to `\thefootnote` (master_pang.tex:55-81). No published package prints such marks, so it is zip-local conditional logic that drives what is printed, which the rubric lists as irreducible. This is the borderline call of the file: a reviewer who reads a glyph table under `\renewcommand\thefootnote` as the parameter of `num.counters` would turn it into `yes`; there is no `ART`, no `EXTERNAL`, no `UNMAPPED` otherwise.

## Blockers
- `BESPOKE/preamble` hand-written circled-number footnote style: `\circledfootnotenum` with `\ifcase#1 \or ①\or ... ㊿\else #1\fi` (50 glyphs, arabic fallback beyond 50) in a font chosen by a nested `\IfFontExistsTF` chain, then `\renewcommand{\thefootnote}{\circledfootnotenum{\value{footnote}}}` (master_pang.tex:55-81; stated limit "50" in chapter/cp2.tex:59). Part of it reduces (the font chain is `font.fontspec`, the `\thefootnote` hook is `num.counters`); the glyph table with its branch and fallback has no published package behind it (considered: `pifont` `\ding`, which covers only 1 to 10).

## Class setting
- Class: `class.ctexart` options: `cs4size,12pt,a4paper,fntef,UTF8` (szu-master.cls:4, loaded with a version date `[2024/4/1]`); the sample adds `UTF8,AutoFakeBold` (master_pang.tex:1; the zip class declares no options, so how they pass on was not traced). Published class of the ctex bundle, source not in the zip, not read.
- Class-native vocabulary used (ctexart): `\zihao{n}` sizes, `\heiti`, `\songti` (redefined at szu-master.cls:52), `\CJKfamily{zhsong}`, `\setCJKmainfont`, `\setCJKfamilyfont`, `\ctexset{section={format+=,name={第,章},number=\chinese{section}}}` (szu-master.cls:233-239, repeated at master_pang.tex:116-122), `\CTEXdigits` (szu-master.cls:16, result `\mynumber` never used).
- Zip-local vocabulary (not published, reduces below): environments `abstractCN` `keywordCN` `abstractEN` `keywordEN` `signAndABC` `szuAppendix` `szuAppendixB`, strings `\titleCN` `\titleEN`, `\upcite`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | szu-master.cls:4; master_pang.tex:1 | `class.ctexart` | cs4size, 12pt, a4paper, fntef, UTF8, AutoFakeBold |
| paper and size | szu-master.cls:4 | `page.class-options` | a4paper, 12pt |
| margins | master_pang.tex:19 | `page.geometry` | left=31.7mm, right=31.7mm, top=25.4mm, bottom=25.4mm |
| head height and sep | master_pang.tex:103-104 | `page.setlength` | `\headheight`=23pt, `\headsep`=7.25mm |
| cover pages | master_pang.tex:154 | `pg.include-pdf` | file chapter/masterPage.pdf, pages={1,2} (shipped PDF asset, content) |
| running head and foot | master_pang.tex:158-160,176-183,230-232; szu-master.cls:108-109,125-126 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhead[C]` (title strings, `\leftmark` with `\nouppercase`, fixed chapter names), `\fancyfoot[C]{\thepage}` in `\songti\zihao{5}` |
| head rule | szu-master.cls:54-58 | `hf.fancyhdr` `sp.rule` `sp.manual-space` | `\headrule` = `\hrule` 1.5pt, `\vspace{1pt}`, `\hrule` 0.75pt, width `\headwidth` |
| page style switch | szu-master.cls:84,107,129 | `hf.pagestyle-kernel` | `\pagestyle{plain}` for contents, `\thispagestyle{fancy}` |
| page numbers | szu-master.cls:106; master_pang.tex:175,184 | `pgnum.pagenumbering` | Roman for abstracts, arabic restart `\setcounter{page}{1}` |
| page breaks | szu-master.cls:93,105; master_pang.tex:174,228 | `pg.break` | `\newpage`, `\clearpage` |
| line spacing | master_pang.tex:165; chapter/abstract.tex:2; szu-master.cls:97,116 | `sp.lengths` `sp.linespread` `sp.setspace` | `\baselineskip`=23pt, `\linespread{1.0}`, `\setstretch{1.25}`, `spacing` 1.8 around the bibliography (master_pang.tex:238) |
| manual space and centring | master_pang.tex:167; szu-master.cls:118,127; chapter/myPapers.tex:9 | `sp.manual-space` `sp.ragged` | `\vspace*{-1\baselineskip}`, `\vspace{18pt}`, `\vspace{2\baselineskip}`, `\centering` |
| bibliography line breaking | master_pang.tex:239-240; bibspacing.sty:21 | `sp.hyphenat` `sp.penalties` | `\sloppy`, `\interlinepenalty=10000`, `\clubpenalty`/`\widowpenalty` 4000 |
| space factor in bibliography | bibspacing.sty:22 | `sp.frenchspacing` | space factor of the period set to 1000 (`\sfcode` of `.` only; same type as the switch, nearest line) |
| main and CJK fonts | szu-master.cls:47,49,51-52,225-226,231 | `font.fontspec` `lang.cjk` | Times New Roman main, simsun.ttc as CJK main and `zhsong` family, SimHei family, `\sectionef`=Arial |
| legacy font loads | szu-master.cls:7-8 | `font.mathptmx` `font.fontenc-t1` | `times`, `textcomp`; ctex loaded again at master_pang.tex:6 |
| font sizes | szu-master.cls:13-14; used throughout | `font.size-commands` | `\zihao{-5}`..`\zihao{3}`, `\fontsize{0}{0}\selectfont` (alias `\xiaochu`) |
| contents list | master_pang.tex:131-145,168; szu-master.cls:29,75-77,248-265 | `toc.kernel` `toc.titletoc` | `\titlecontents` for section, subsection and subsubsection with `\titlerule*[0.4pc]{.}`, indents 0em, 1em, 1.8em, 小四, `\contentsname` redefined |
| section headings | master_pang.tex:116-127; szu-master.cls:233-253 | `head.class-native` `head.titlesec` | ctex `section` format and name 第..章 with `\chinese`; `\titleformat` for subsection (`\zihao{-3}`), subsubsection (`\zihao{4}`), paragraph (`\zihao{-4}`), Arial font |
| numbering depth | szu-master.cls:62,64 | `num.secnumdepth` | secnumdepth=4, tocdepth=3 |
| abstract pages | szu-master.cls:104-121,135-152; chapter/abstract.tex:1-12,19-30 | reduces to `pg.break` `hf.fancyhdr` `pgnum.pagenumbering` `toc.kernel` `xref.hyperref` `sp.ragged` `font.size-commands` `lang.cjk` | centred heading 摘要/ABSTRACT in `\heiti\zihao{3}` bold, text `\songti\zihao{-4}`, `\addcontentsline{toc}{section}`, `\phantomsection`, `\hypertarget` |
| keyword lines | szu-master.cls:124-132,155-163; chapter/abstract.tex:15-17,33-35 | `abs.keywords` | label 关键词： / Key words: in `\noindent` bold, `\vspace{2\baselineskip}`, `\newpage` at the end |
| symbols and abbreviations page | szu-master.cls:166-183; chapter/sign_and_ABC.tex:1-49 | `front.dedication` `tbl.longtable` `page.adjustwidth` | `adjustwidth{-\leftskip}{0pt}`, `longtable{l@{\hspace{4em}}p{10.5cm}}`, `\arraystretch`=1.5, empty `\endhead`/`\endfoot` |
| acknowledgement and results pages | szu-master.cls:187-220; chapter/thanks.tex:1-10; chapter/myPapers.tex:1-32 | `front.dedication` | heading arg 致~谢, `\songti\zihao{5}` or `{-4}`, `\baselineskip` 23pt/15pt |
| anchors and links | szu-master.cls:9,111-112; master_pang.tex:107-109 | `meta.hyperref` `xref.hyperref` | `\hypersetup{pdfborder={0 0 0}}`, `\phantomsection`, `\hypertarget` |
| urls | master_pang.tex:24; chapter/abstract.tex:10 | `meta.url` | `\url{...}` |
| equation numbering | master_pang.tex:193-197; chapter/cp2.tex:22-26 | `math.amsmath` `num.counters` | `\@addtoreset{equation}{section}`, `\theequation`={\thesection}-{\arabic{equation}}, `equation`, `\eqref` |
| theorem-like | master_pang.tex:83-88; chapter/cp2.tex:69-93 | `thm.kernel` `thm.amsthm` | `\newtheorem` definition 定义, theorem 定理, lemma and corollary on theorem counter, proposition 命题, `\proofname`=证明, `proof` env; the `[]` empty optional argument at lines 83,84,87 is as written |
| figures | master_pang.tex:206-215; chapter/cp2.tex:33-38 | `fig.graphicx` `fig.floatrow` `cap.kernel` | `figure[h]`, `\includegraphics[width=0.8\textwidth]`, per-section counter `\thefigure`=\thesection-\arabic{figure}, `\floatsetup[figure]{capposition=bottom}` |
| tables | tables/EXP.tex:1-18; master_pang.tex:47,200-204 | `tbl.tabular` `tbl.booktabs` `cap.caption` | `table*[t]`, `\arraystretch`=1.4, `tabular{l@{\hspace{4em}}c@{...}c@{...}c}`, `\toprule` `\midrule` `\bottomrule`, `\floatsetup[table]{capposition=top}`, `\captionsetup[table]{labelsep=space,labelfont=bf}` |
| captions | szu-master.cls:11,23,25-26; master_pang.tex:204,210 | `cap.caption` | `\captionsetup{font={bf,wuhao}}` with `\DeclareCaptionFont{wuhao}{\zihao{5}}`, counters without chapter prefix in the class and with it in the sample |
| subfigure numbering | master_pang.tex:213-215 | `num.counters` | `\p@subfigure`=`\thefigure` |
| footnotes | chapter/cp1.tex:7,9; chapter/cp2.tex:59; master_pang.tex:81 | `fn.kernel` `num.counters` (mark style is the blocker) | `\footnote`, `\thefootnote` set to circled digits |
| bibliography | master_pang.tex:238-244; szu-master.cls:91-101; bibspacing.sty:5-25 | `bib.bibtex-bst` `bib.thebibliography` | `\bibliographystyle{gbt7714-2005}`, `\bibliography{ref_paper}`, `\refname` set at szu-master.cls:31, list parameters per bibspacing.sty |
| citations | master_pang.tex:27,99; chapter/cp2.tex:48,50 | `bib.cite-pkg` `mark.kernel` | `cite` package; `\upcite`=`\textsuperscript{\cite{..}}` |
| file inclusion | master_pang.tex:163,171,221-225,250,256; chapter/cp2.tex:42 | `struct.input` | `\input{chapter/...}`, `\input{tables/EXP}` |
| inline code | chapter/cp2.tex:9,31,40 | `code.verbatim` `mark.kernel` | `\verb`, `\texttt`, `\textbf` |
| load-only or unused packages | master_pang.tex:7,9-10,12,21-23,28-31,36-46 | `hf.fancyhdr` `tbl.longtable` `pgnum.lastpage` `tbl.multirow` `head.titlesec` `fig.subcaption` `alg.algorithmicx` `pg.include-pdf` `page.adjustwidth` `math.bm` `list.enumitem` `mark.ulem` `tbl.arydshln` `tbl.tabularx` `num.counters` `color.color` `tbl.colortbl` `math.amssymb` `quote.epigraph` | `lastpage`, `makecell`, `subfigure`, `subcaption`, `algorithm`, `algorithmic`, `epsfig`, `bm`, `slashbox`, `enumitem`, `ulem`, `arydshln`, `tabularx`, `chngcntr`, `color`, `colortbl`, `epigraph` (szu-master.cls:8); never called in the sample (`subfigure` and `subcaption` are both loaded, master_pang.tex:23,26,40; whether they coexist was not checked) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| szu-master.cls as a whole | szu-master.cls:1-268 | yes | `class.ctexart` options above, plus the preamble rows of the map and body wrappers |
| `\circledfootnotenum`, font fallback chain, `\thefootnote` | master_pang.tex:55-81 | no | see the blocker; partial reduction `font.fontspec` (`\IfFontExistsTF`, `\newfontfamily`) and `num.counters` (`\renewcommand\thefootnote`) leaves the 50-glyph `\ifcase` table and its arabic fallback as zip-local logic |
| `\def\@cite` superscript brackets | szu-master.cls:36-38 | yes | `bib.cite-pkg` hooks (`\citeleft` `\citemid` `\citeright`); moot here since `cite` is loaded afterwards at master_pang.tex:27 (the sample text at chapter/cp2.tex:48 says `\cite` prints in line), whether cite.sty overwrites it was not checked |
| `\titleCN` `\titleEN` `\newContects` string macros | szu-master.cls:41-43; master_pang.tex:2-3 | yes | inline the strings in `\fancyhead` and `\addcontentsline{toc}{section}` (`hf.fancyhdr`, `toc.kernel`) |
| `\xiaowu` `\xiaochu` aliases | szu-master.cls:13-14 | yes | `font.size-commands`; never used in the sample |
| `\renewcommand\tableofcontents` wrapper | szu-master.cls:80-87 | yes | `\pagestyle{plain}` then `\tableofcontents` (`hf.pagestyle-kernel`, `toc.kernel`) |
| `\renewcommand\bibliographystyle` wrapper | szu-master.cls:91-101 | yes | write in the body before `\bibliographystyle`: `\newpage`, `\phantomsection`, `\hypertarget`, `\setstretch{1.25}`, `\addcontentsline{toc}{section}{...}`, `\songti\zihao{5}` |
| `abstractCN` `keywordCN` `abstractEN` `keywordEN` | szu-master.cls:104-163 | yes | body wrappers of lib ways listed in the abstract and keyword rows; `\setmainfont{Arial}` inside `abstractEN` (szu-master.cls:147) is `font.fontspec` |
| `signAndABC` `szuAppendix` `szuAppendixB` | szu-master.cls:166-220 | yes | same composition (`pg.break`, `hf.fancyhdr`, `toc.kernel`, `xref.hyperref`, `font.size-commands`) |
| `\headrule` redefinition | szu-master.cls:54-58 | yes | `hf.fancyhdr` documented hook with `sp.rule` |
| `\renewcommand\contentsname`, `\refname` | szu-master.cls:29,31 | yes | name strings with `\heiti\zihao{}` `\textbf`; `toc.kernel`, `bib.thebibliography` |
| bibspacing.sty (`\renewenvironment{thebibliography}`) | bibspacing.sty:1-25 | yes | `bib.thebibliography` with `\itemsep`, `\parsep`=0 (`sp.lengths`), `\sloppy`, penalties 4000 (`sp.penalties`), heading `\section*{\refname}` in `spacing{1}` (`sp.setspace`); `\bibspacing` is declared and set (bibspacing.sty:3-4; master_pang.tex:93) but not read by the environment body, so it has no effect |
| `\upcite`, `\norm` | master_pang.tex:99,51 | yes | aliases of `\textsuperscript{\cite{}}` and `\left\lVert..\right\rVert` (`math.amsmath`); `\norm` unused |
| `\newfloatcommand{capbtabboxTable}` `{capbtabboxFigure}` | master_pang.tex:49-50 | yes | floatrow's own published command, never called |
| slashbox.sty (picture-based) | slashbox.sty:1-77; master_pang.tex:37 | yes | CTAN package `slashbox` (CTAN page read; same hash as slashbox/slashbox.sty); `tbl.multirow` line (diagonal-cell package as `diagbox`); no `\backslashbox` call in the sample, not template artwork |
| gbt7714.sty (v2.1.5) and other-old-file copies | gbt7714.sty:1-333 | yes | published (CTAN gbt7714, LPPL); neither the class nor the sample loads it |
| gbt7714-2005.bst | gbt7714-2005.bst:1-1962 (header read) | yes | the `.bst` style is the parameter of `bib.bibtex-bst`; header names the NJU thesis project (GPL), not the CTAN gbt7714 files; only the header was read |
| per-section numbering of figure, table, equation | master_pang.tex:193-215 | yes | `\@addtoreset` is a kernel command, `num.counters` |

## Content-opaque
- Cover pages 1 and 2 of chapter/masterPage.pdf (master_pang.tex:154) are a shipped PDF held by `pg.include-pdf`; the .docx covers beside it are inputs to a Word step, not part of the build.
- Figure artwork figure/cp1/xxx.pdf (chapter/cp2.tex:35) is an image asset.
- Missing assets: Times New Roman, Arial and SimHei are not shipped (the CI installs them, .github/workflows/build.yml:43-65); simsun.ttc is shipped; songti-Bold.otf and lucida-console.ttf are used only by comments or the CI list (master_pang.tex:260,263).

## Lib changes
- New ways proposed: none (considered: `pifont` for circled digits, rejected, it prints 1 to 10 only)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
