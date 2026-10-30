no

# 0100-hitszthesis: HITSZThesis (Harbin Institute of Technology, Shenzhen dissertation template)

- Unverified: read from the source, not compiled.
- Source: Source/0100-hitszthesis/ (origin: https://mirrors.ctan.org/macros/latex/contrib/hitszthesis.zip; licence: lppl1.3c)
- Kind: thesis
- Lib: v1
- Engine: needs XeLaTeX (the class stops with a ClassError unless the engine is XeTeX, hitszthesis.dtx:1203-1209; ctexbook/xeCJK, system CJK fonts)
- Look carried by: mixed (the published class `hitszthesis` carries cover, headers, headings, captions, TOC, theorems, bibliography; the zip-local `hitszthesis.sty` is an example-only preamble layer that adds packages, math aliases, TikZ figure macros and algorithm2e caption hacks)
- Class origin: ctan (ctan.org/pkg/hitszthesis, also in TeX Live; the zip ships `hitszthesis.dtx`/`.ins`, not the generated `.cls`/`.cfg`, which docstrip produces: hitszthesis.ins:87-94)
- Main file: hitszthesis-example.tex (other samples: none; `hitszthesis-{bachelor,master,doctor}.pdf` are outputs; the master/doctor order is the commented block at hitszthesis-example.tex:144-177)
- Read: main yes (186 lines plus every `\input` file under front/, body/, back/), zip-local classes and styles partly (read in full: hitszthesis.sty, ctex-fontset-siyuan.def, every cls/cfg/ist/dtx-style code block of hitszthesis.dtx:937-3440; not read in full: `hitszthesis.bst` (1978 lines, head, tail and outline only) and the Chinese documentation prose of hitszthesis.dtx lines 130-930)

## Verdict
No. The look is almost entirely carried by a published class (`class.hitszthesis`, CTAN and TeX Live), which maps well. But the sample also loads the zip-local `hitszthesis.sty` (hitszthesis-example.tex:55), whose algorithm2e block rewrites package internals (`\algocf@makecaption` always a centred `\parbox`, `\algocf@captiontext`, `\@algocf@post@ruled`; hitszthesis.sty:48-78). No `alg.algorithm2e` option expresses that, and the sample's algorithm float (body/chapter06.tex:81-89) uses it, so an emitter would have to copy zip-local macro logic. The rest of the `.sty` (siunitx, bm, xcolor, listings, glossaries, math aliases) reduces to lib ways, and its TikZ macros only draw one figure (content).
The class's own internals (`\@makecaption` box algorithm, `\@afterheading`, `\l@chapter`, amsmath and natbib patches) are NOT counted, because the class is published (W1) and is itself the way. A reader who counts them, or who counts `hitszthesis.sty` as part of the published package, would change the result (see Bespoke code).

## Blockers
- `BESPOKE/preamble` hitszthesis.sty hand-rewrites algorithm2e internals: always-centred `\parbox` caption (`\algocf@makecaption`), caption text/font (`\algocf@captiontext`), fixed 1.5pt closing rule (`\@algocf@post@ruled`); used by the sample's `algorithm` float (hitszthesis.sty:48-78; body/chapter06.tex:81-89)

## Class setting
- Class: `class.hitszthesis` options: `type=bachelor`, `infoleft=true` (hitszthesis-example.tex:25). Unlisted options go to `ctexbook` (hitszthesis.dtx:1125), which the class loads with `a4paper,openany,UTF8,zihao=-4,scheme=plain` (dtx:1181). Defaults in force: raggedbottom, chapterhang, capcenterlast, subcapcenterlast, absupper, alphappendix, bsheadrule, bsmainpagenumberline, bsfrontpagenumberline true; campus shenzhen; mathfont=newtxmath (dtx:986-1122). Other options exist: campus, arialtoc, arialtitle, covertitletworow, boldcaption, tocfour, fulltime, subtitle, openright, library, fontset, glue, splitbibitem, debug.
- Class-native vocabulary used: `\hitszsetup{statesecrets, natclassifiedindex, intclassifiedindex, ctitleone, ctitletwo, ctitlecover, ctitle, csubtitle, cxueke, cpostgraduatetype, csubject, caffil, cauthor, csupervisor, cassosupervisor, cdate, cdatesecond, cstudentid, cstudenttype, etitle, esubtitle, exueke, esubject, eaffil, eauthor, esupervisor, edate, estudenttype, ckeywords, ekeywords}` (front/coverinformation.tex:3-63); envs `cabstract`, `eabstract` (coverinformation.tex:66-81), `conclusions`, `acknowledgements`, `appendix` (with `\title{}` inside), `algorithmen`, `denotation`, `ceindex`, `publication`, `resume` (the last four only in commented or inactive paths); `\makecover`, `\authorization[pdf]`, `\frontmatter` `\mainmatter` `\backmatter`, `\chapter{zh}[en]` and `\section{zh}[en]` down to `\subsubsection` (bilingual TOC entries), `\bicaption[label]{}{zh}{Fig.}{en}`, `\longbionenumcaption` and `\ltfontsize`, `\appendixcaption`, `\figref` `\tabref` `\equref`, `\inlinecite`, size commands `\wuhao[k]` `\xiaosi` ..., font switches `\songti` `\heiti` `\kaishu`, `\SetPageNumberingFromOne`, `\SetAppendixWithOnlyHeadings`, theorem envs (theorem, definition, assumption, lemma, corollary, exercise, problem, remark, axiom, conjecture, proof), `\sindex[china|english]`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | hitszthesis-example.tex:25; dtx:1125-1130,1181 | `class.hitszthesis` | type=bachelor, infoleft=true; wraps ctexbook[a4paper,openany,UTF8,zihao=-4,scheme=plain]; bachelor/master oneside, doctor twoside (dtx:1142-1150) |
| page size and margins (inside class) | dtx:1337-1360 | `page.geometry` | a4paper, hcentering, ignoreall, nomarginpar; text={150true mm,224true mm}, top=37.5true mm, left=30true mm, head=5true mm, headsep=3true mm, footskip=0true mm, foot=8true mm; debug adds showframe |
| bottom alignment | dtx:1012,1266-1268 | `pg.flush` | `\raggedbottom` (option raggedbottom=true) |
| page breaks | dtx:1437-1441,1449,1466,1479 | `pg.break` | `\cleardoublepage` redefined to flush with an empty page style; `\clearpage` otherwise; openright and library options |
| header/footer | dtx:1087-1089,1611-1707 | `hf.class-native` | page styles hitsz@empty, hitsz@onlyheadings, hitsz@headings (fancyhdr inside); bachelor: centre head = school + degree + thesis name, songti `\xiaowu[0]`; foot `- n -` `\xiaowu`; double head rule 2.276208pt + 0.75pt; options bsheadrule, bsmainpagenumberline, bsfrontpagenumberline |
| page numbering | dtx:1451,1471,2915,3107 | `pgnum.pagenumbering` | Roman in front matter and abstracts, arabic in main matter; `\SetPageNumberingFromOne` |
| Latin text and math font | dtx:1226-1243 | `font.newtx` | newtxtext[defaultsups]; newtxmath (mathfont=newtxmath; mtpro2 lite or full are alternatives) |
| CJK setup, punctuation, indent | dtx:1161-1171,1181,1285,1720-1723 | `lang.cjk` | ctexbook scheme=plain; `\ctexset{punct=quanjiao,space=auto,autoindent=true}`; xeCJK AutoFakeBold=2; xeCJKfntef; fontset option |
| font sizes | dtx:1492-1497,1528-1573 | `font.size-commands` | `\normalsize` = 12bp on 19.27374bp; `\wuhao` etc. = `\fontsize{pt}{k*pt}\selectfont`, optional factor, default 1.3 |
| paragraph and display spacing | dtx:1494-1497,2001-2002 | `sp.lengths` | abovedisplayskip=8pt, belowdisplayskip equal, parindent=2em, arraycolsep=1.6pt |
| penalties | dtx:1776-1778,3258-3268,3308 | `sp.penalties` | allowdisplaybreaks[4], predisplaypenalty=0, postdisplaypenalty=0; bibliography club/widow/interline penalties; `\sloppy` |
| manual spacing | body/chapter04.tex:20,47,96; chapter02.tex:122 | `sp.manual-space` | `\vspace{0.5em}`, `\vspace{-1.5bp}`, `\hspace{2em}` |
| colour | hitszthesis.sty:32-36,84-86 | `color.xcolor` | `\definecolor` colorzero..colorthree, lightgrey, frenchplum, winered |
| cover pages | dtx:2549-2698,2875-2898; coverinformation.tex:3-63 | `front.class-native` | bachelor: first page (title in `\erhao[0]\heiti`, name `\xiaoer[0]`, info table, date), second page (hitlogo.eps 6.2cm, bthesistitle.eps 10.5cm, underlined info table, infoleft); inside `titlepage` env; master/doctor pages inactive |
| abstracts | dtx:2379-2382,2911-2923; coverinformation.tex:66-81 | `abs.class-native` | `cabstract` and `eabstract` store their body; `\hitsz@makeabstract` prints two starred-chapter pages (摘要 and ABSTRACT) |
| keywords | dtx:2383-2395,2903-2909; coverinformation.tex:61-62 | `abs.keywords` | `ckeywords` joined with ；, `ekeywords` with a comma, hanging box after a bold label |
| declaration, conclusion, acknowledgement | dtx:3124-3129,3189-3223; hitszthesis-example.tex:113,123,129 | `front.dedication` | originality statement page (`\authorization`), `conclusions`, `acknowledgements` envs as starred chapters |
| scanned authorization page (alternative) | dtx:1253-1254,3210; hitszthesis-example.tex:126 | `pg.include-pdf` | `\includepdfset{fitpaper=true}`, `\authorization[scan.pdf]` (commented in the sample) |
| table of contents | hitszthesis-example.tex:81; dtx:2964-2977,2985-3022 | `toc.kernel` | secnumdepth=3, tocdepth=2 (3 with tocfour); `\@pnumwidth` 4em; `\l@chapter`..`\l@subsubsection` indents 1em, 2em, 3\ccwd; heiti chapter entries |
| headings | dtx:2064-2179,2226-2325; body/chapter01.tex:4-32 | `head.class-native` | `\ctexset` chapter: centred heiti `\xiaoer[1.57481]`, beforeskip 18.74658bp, afterskip 24.74658bp, name {第,章}, hanging title; section 15bp/21bp, subsection 14bp/18bp, subsubsection normalsize; skips 20.25/16.5/13.5bp; afterindent; bilingual `[en]` argument writes a second `toe` TOC |
| heading numbering depth | dtx:2964-2966 | `num.secnumdepth` | secnumdepth=3, tocdepth=2 |
| counters and numbers | dtx:1779,1940-1943,1857-1859 | `num.counters` | figure, table, equation as `chapter-n`; subfigure `(a)`; `\addtocounter{subfigure}{-2}` in body (chapter02.tex:120) |
| appendix | hitszthesis-example.tex:135-139; dtx:3078-3091 | `num.appendix` | `appendix` env renewed; bachelor chapters lettered by alphappendix; numbering of figures and tables per chapter |
| lists | dtx:1728,1961-1962,3120-3123; body/chapter02.tex:172-183 | `list.enumitem` | `\setlist{nosep}`, itemize leftmargin=0em itemindent=3em, enumerate itemindent=3.5em, `\newlist{translationbib}` label=［\arabic*］, description font=\normalfont |
| lists (inactive) | back/appendixB.tex:12-24; dtx:1974-1988 | `list.kernel` | `enumerate`; `publist` built on `list` with counter (master/doctor path, commented in the sample) |
| footnotes | dtx:1267,1738-1766; body/chapter06.tex:9,93 | `fn.footmisc` | footmisc[bottom,perpage,hang], footnotemargin=1.5em, circled numbers, rule 0.3\textwidth by 0.4pt |
| footnote command | body/chapter06.tex:9,93 | `fn.kernel` | `\footnote{...}` |
| equations | dtx:1215,1779-1808; hitszthesis.sty:447-457; body/chapter03.tex:17-19 | `math.amsmath` | `equation`, `\eqref` as (n), `\tag*`, `\DeclareMathOperator`, allowdisplaybreaks |
| math symbols and fonts | dtx:1221; hitszthesis.sty:26,29 | `math.amssymb` | amssymb; bm and mathrsfs below |
| bold and script math | hitszthesis.sty:26,29; body/chapter03.tex:18 | `math.bm` | bm `\bm{}`, mathrsfs `\mathscr` |
| sub-equation numbering | dtx:1307; body/chapter03.tex:36-44 | `math.eqnumber` | `subeqnarray` env with `\slabel`; mapped here, see Lib changes |
| theorem machinery | dtx:1220,1815-1837,1993-2000; body/chapter06.tex:39-68; back/appendix02.tex:37,49 | `thm.ntheorem` | ntheorem[amsmath,thmmarks,hyperref]; `\renewtheoremstyle{plain}`, bodyfont `\songti\rmfamily`, headerfont `\heiti\rmfamily`, symbol `$\square$`, separator empty, pre 0pt, post -2pt, `[chapter]` numbering; sample adds `\newtheorem{mpdef}{Definition}[chapter]` |
| theorem names | dtx:1815-1837; body/chapter06.tex:39-68 | `thm.class-native` | 假设 定义 命题 引理 定理 公理 推论 练习 例 注释 问题 猜想, proof 证明 |
| figures | dtx:1248; body/chapter02.tex:21-25,41-46; hitszthesis-example.tex:58 | `fig.graphicx` | `figure[htpb]`, `\centering`, `\includegraphics[width=0.4\textwidth]`, `\graphicspath{{figures/}{pictures/}}` |
| sub-figures | dtx:1390-1394; body/chapter02.tex:115-157 | `fig.subcaption` | `subfigure[centerlast]` (option subcapcenterlast), nested bilingual `\subfigure`, `\subfigcapskip=-1bp`, `\subcapsize=\wuhao` |
| rotated floats | hitszthesis.sty:39; body/chapter02.tex:188-203; chapter04.tex:131-148 | `fig.rotating` | `sideways` around `minipage{\textheight}` |
| float placement | dtx:1387-1388,1848-1863 | `fig.placement` | placeins[below], flafter; intextsep 8.50398bp, textfloatsep 8.50398bp, floatsep 12bp; textfraction 0.15, topfraction 0.85, bottomfraction 0.65, floatpagefraction 0.60 |
| side-by-side floats | body/chapter02.tex:57-100 | `cols.minipage` | two `minipage{0.4\textwidth}` with `[t]` or centre alignment |
| tables | body/chapter04.tex:18-30 | `tbl.tabular` | `tabular{ccccc}` with `\wuhao`; `array` loaded by other packages |
| rules | dtx:1295; body/chapter04.tex:22-28 | `tbl.booktabs` | `\toprule[1.5pt]`, `\midrule[1pt]`, `\bottomrule[1.5pt]` |
| long tables | dtx:1290,1913-1932; body/chapter04.tex:48-95 | `tbl.longtable` | `longtable` with `\endfirsthead` `\endhead` `\endfoot`, `\ltfontsize{\wuhao[1.667]}`, bilingual caption through `\longbionenumcaption` |
| adjustable-width tables | dtx:1379; body/chapter03.tex:20-26; chapter04.tex:112-118 | `tbl.tabularx` | `tabularx{\textwidth}{@{}l@{\quad}r@{———}X@{}}`, `tabularx{0.7\textwidth}{llX}` |
| merged cells | dtx:1389; back/appendix01.tex:36-39 | `tbl.multirow` | `\multirow{2}{2em}{..}`, `\multicolumn`, `\cline` |
| captions: kernel | body/chapter02.tex:44; back/appendix01.tex:30 | `cap.kernel` | `\caption{...}`, `\caption*{...}` |
| captions: bilingual | dtx:1394,1880-1902,1968-1972; body/chapter02.tex:24 | `cap.memoir` | ccaption[subfigure]: `\bicaption`, captionnamefont and captiontitlefont `\wuhao`, above/belowcaptionskip 0pt; options boldcaption, capcenterlast |
| cross references | dtx:1951-1953; body/chapter02.tex:19 | `xref.kernel` | `\ref`, `\label`; `\figref` = 图\ref, `\tabref` = 表\ref, `\equref` = 式(\ref) |
| PDF metadata and links | dtx:1312-1325,1330 | `meta.hyperref` | CJKbookmarks, linktoc=all, bookmarksnumbered, bookmarksopen, bookmarksopenlevel=3, breaklinks, colorlinks=false, plainpages=false, pdfstartview=FitH, pdfborder={0 0 0}, pdfcreator |
| url style | dtx:1330 | `meta.url` | `\urlstyle{same}` |
| inline code | hitszthesis.sty:81-120; body/chapter03.tex:35,46 | `code.listings` | `\lstset` (language [LaTeX]TeX, basicstyle `\small\ttfamily`, frame single, numbers left, breaklines); `\lstinline` active; `lstlisting` only in inactive back/appendixB.tex:34-38; minted not loaded (sty:124 commented) |
| framed image | body/chapter02.tex:193 | `box.fancybox` | `\fbox{\includegraphics..}` |
| boxes | body/chapter02.tex:59,118,171 | `box.minipage` | `minipage` wrappers for captions and sub-captions |
| bibliography run | hitszthesis-example.tex:119-120; hitszthesis.bst | `bib.bibtex-bst` | `\bibliographystyle{hitszthesis}` (GB/T 7714-2005 `.bst`, shipped), `\bibliography{reference}`; `gbt7714` package loaded (dtx:1301); thebibliography renewed (dtx:3237-3272) |
| citations | dtx:1302,3226-3297; body/chapter05.tex:11-25 | `bib.natbib` | natbib[sort&compress], `\citestyle{numerical}`, `\bibpunct{[}{]}{,}{s}{,}{\textsuperscript{,}}`, `\inlinecite`, `\cite[100-197]{key}`, `\@biblabel` full-width brackets |
| split index | dtx:1399-1401,1407-1413; body/chapter05.tex:11; chapter06.tex:30 | `idx.makeidx` | splitidx[makeindex], `\newindex{china}`, `\newindex{english}`, `\sindex[china]{..}`; `.ist` heading style; printing (`ceindex` + `\printsubindex*`) only in the commented master/doctor order; mapped here, see Lib changes |
| index page layout (inactive) | dtx:3140-3147 | `page.adjustwidth` | `adjustwidth{2em}{2em}` around the index (ceindex, commented in the sample) |
| index columns (inactive) | dtx:3145 | `cols.multicol` | `multicols*{2}`, columnsep=4em |
| acronyms | hitszthesis.sty:128-141; body/chapter06.tex:35 | `idx.glossaries` | glossaries, `\setacronymstyle{short-long}`, `\newacronym`, `\gls`; `\makeglossaries` commented |
| algorithms | hitszthesis.sty:47; body/chapter06.tex:81-89; back/appendix02.tex:123-129 | `alg.algorithm2e` | `[algoruled,linesnumbered,algochapter]`, `\SetAlgoSkip{1pt}`, `\setlength\AlCapSkip{1.2ex}`, `\DontPrintSemicolon`, `\KwData`, `\KwResult`; look depends on the blocked sty hacks |
| numbers | hitszthesis.sty:21-23; body/chapter06.tex:21-22 | `mark.siunitx` | `\sisetup{group-minimum-digits=4, group-separator=\hspace{0.25em}}`, `\num{}` |
| text marks | back/appendix02.tex:9-10; dtx:2583,2623 | `mark.kernel` | `\textbf`, `\emph`, `\songti\textbf{..}` |
| TikZ figures (content) | body/chapter02.tex:159-167,220-255 | `art.tikz` | in-float pictures; styles and macros at hitszthesis.sty:144-354 are content (see Content-opaque) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| algorithm2e caption internals: `\algocf@makecaption`, `\algocf@captiontext`, `\@algocf@post@ruled`, `\foocaption` | hitszthesis.sty:48-50,62-74 | No (counted) | Centred `\parbox` caption has no `alg.algorithm2e` option. Only `\@algocf@post@ruled` (fixed 1.5pt rule) and the caption font look expressible by algorithm2e lengths and `\SetAlCap*` (not verified: algorithm2e source not read). `\foocaption` is defined, never called |
| English list of algorithms: `\newfloatlist`, `\newfixedcaption`, `\@cftmakeaentitle`, `\AlgoBiCaption`, conditional `\thealgocf` | hitszthesis.sty:53-58,63-67,75-78 | Yes in part | ccaption commands (`cap.memoir`) plus `\renewcommand\thealgocf{\thechapter-\arabic{algocf}}` (`num.counters`); `\@cftmakeaentitle` is an internal rewrite; `\AlgoBiCaption` and the list are never used by the sample |
| TikZ macros `\gseg` `\gsegr` `\rcell` `\ncell` `\tcell*` and `\tikzstyle` set | hitszthesis.sty:149-354 | n/a | content: they only draw one figure (body/chapter02.tex:220-255) |
| math shortcut aliases and `\DeclareMathOperator` | hitszthesis.sty:357-457 | Yes | `\newcommand` aliases of amsmath/bm commands (`math.amsmath`, `math.bm`); no layout logic |
| `\cmd`, `\cs` | hitszthesis.sty:460-462 | Yes | `\texttt{\textbackslash name}` (`mark.kernel`); `\cs` used in body text (body/chapter02.tex:106) |
| `\gtssbp`, `\gscna`, `\gscnas` | hitszthesis.sty:137,140-141 | Yes | `\gls` plus two `\sindex` calls (`idx.glossaries`, `idx.makeidx`) |
| body `\subfigure{\label{..}}\addtocounter{subfigure}{-2}` trick | body/chapter02.tex:120-133 | Yes | published subfigure commands plus `\addtocounter` (`fig.subcaption`, `num.counters`) |
| `ctex-fontset-siyuan.def` (expl3 ctex fontset, branches on engine) | ctex-fontset-siyuan.def:1-86; used only with fontset=siyuan (dtx:1164-1170) | Yes, and not loaded by the sample | `\setCJKmainfont`, `\setCJKfamilyfont`, `\songti` `\heiti` `\kaishu` definitions under XeLaTeX (`lang.cjk`) |
| class: `\@makecaption` box/`\lastbox` last-line centring, `\longbionenumcaption` and longtable `LT@c@ption` swap | dtx:1880-1902,1913-1932 | Not counted: published class | covered by `class.hitszthesis` options (capcenterlast, boldcaption); would be BESPOKE/class if the class were zip-local |
| class: `\@afterheading`, `\l@chapter` plus `\patchcmd{\@dottedtocline}`, `\renewcommand\today` CJK date, circled `\hitsz@textcircled`, `\hitsz@def@fontsize` | dtx:2078-2090,2993-3015,2038-2049,1738-1749,1528-1573 | Not counted: published class | same |
| class: amsmath `\make@df@tag`/`\tagform@` patch, natbib `\NAT@citex`/`\NAT@cite`/`\NAT@citexnum` patches | dtx:1792-1803,3273-3297 | Not counted: published class | same |
| class: key-value machinery `\hitsz@def@term`, `\hitsz@parse@keywords`, `\Collect@Body` | dtx:2338-2395 | Not counted: published class | `\hitszsetup{key=value}` is declarative |
| build files: Makefile, compile.bat, latexmkrc | Makefile:36,67-89; compile.bat:76-85; latexmkrc:9-35 | Not template code | run docstrip (`latex hitszthesis.ins`, TeX itself), `bibtex`, `makeindex`/`splitindex`; pass `-shell-escape` though nothing in the class or sample needs it (no minted: sty:124); `npm run build` (Makefile:120) is release tooling only. They name `main.tex`, which the zip does not ship (the sample is hitszthesis-example.tex) |

## Content-opaque
- TikZ tumour-evolution figure and its macros and styles (body/chapter02.tex:220-255; hitszthesis.sty:149-354); TikZ overlay with a), b) labels on an image (body/chapter02.tex:161-167)
- `\lipsum` filler text (hitszthesis.sty:42; used in body/chapter02-06); algorithm bodies (body/chapter06.tex:86-88; back/appendix02.tex:126-127); reference.bib entries
- Image assets shipped as EPS: figures/hitlogo.eps, figures/bthesistitle.eps (a vectorised title in 华文新魏, dtx:2628-2629), figures/golfer.eps. Placed with `\includegraphics`, so assets, not `ART`. Under XeLaTeX, EPS is converted by Ghostscript through xdvipdfmx.
- Missing assets, not shipped: Chinese system fonts (SimSun, SimHei, KaiTi, STXinwei equivalents via the ctex fontset; Source Han Serif and YaHei for fontset=siyuan), optional mtpro2.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Mapping notes for the consolidator (not proposals): `subeqnarray` is placed in `math.eqnumber` (equation numbering style); `splitidx` in `idx.makeidx` (the `index`/`imakeidx` family, package is the parameter); `gbt7714` with natbib in `bib.natbib` plus `bib.bibtex-bst`; `ccaption` `\bicaption` in `cap.memoir`; `ntheorem` in `thm.ntheorem`. Index printing needs `splitindex` or `makeindex`, the same class of TeX Live helper as `bibtex`; the sample's active path does not print the index. Not treated as `EXTERNAL`.
