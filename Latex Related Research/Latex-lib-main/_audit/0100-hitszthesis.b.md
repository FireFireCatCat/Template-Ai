no

# 0100-hitszthesis: HITSZThesis (Harbin Institute of Technology, Shenzhen dissertation template)

- Unverified: read from the source, not compiled.
- Source: Source/0100-hitszthesis/ (origin: https://mirrors.ctan.org/macros/latex/contrib/hitszthesis.zip; licence: LPPL 1.3c)
- Kind: thesis
- Lib: v2
- Engine: needs XeLaTeX (the class aborts with ClassError unless XeTeX, hitszthesis.dtx:1204-1209; it loads ctexbook, xeCJK, xeCJKfntef, fontspec; CJK fonts come from the system)
- Look carried by: mixed (the class code in hitszthesis.dtx:937-3309 plus the generated .cfg carry page, cover, headings, headers, captions, toc, bibliography; the zip-local hitszthesis.sty, loaded at hitszthesis-example.tex:55, adds algorithm2e, listings, siunitx, glossaries, tikz styles and math macros)
- Class origin: ctan
- Main file: hitszthesis-example.tex (other samples: none; hitszthesis.dtx is the manual driver under ltxdoc, not a thesis sample)
- Read: main yes, zip-local classes and styles partly (read in full: hitszthesis.sty, hitszthesis.dtx incl. all class/cfg code and the manual prose, hitszthesis.ins, ctex-fontset-siyuan.def, Makefile, latexmkrc, all front/ body/ back/ files; NOT read: hitszthesis.bst beyond its header and a grep outline of its 1978 lines, compile.bat only grepped, README.md only its first 60 lines)

Citation key: ex = hitszthesis-example.tex, dtx = hitszthesis.dtx, sty = hitszthesis.sty, chNN = body/chapterNN.tex, apNN = back/appendixNN.tex.

## Verdict
no. The class itself is a published CTAN class (`class.hitszthesis`) and carries almost the whole look, and most of the zip-local `hitszthesis.sty` reduces to lib ways. One thing does not: the sty rewrites algorithm2e's internal caption and rule macros with box and `\hsize` juggling and builds a bilingual algorithm list on ccaption's internal title macro (sty:47-78), and the sample uses algorithm floats (ch06:81-89, ap02:123-129), so the look depends on it. I treated the sty as the sample's own preamble file, because the manual says it exists to hold extra packages and macros so the class stays small (dtx:209-211, ex:54), and it has no options (W2) and holds one thesis's own macros (W3), so it is not a way in itself. If a reader instead counts it as published because it ships in the CTAN bundle, this blocker would fall away.

## Blockers
- `BESPOKE/preamble` algorithm2e caption and rule internals overridden, plus bilingual algorithm list on ccaption internals: `\@algocf@post@ruled` (sty:50), `\algocf@captiontext` (sty:62), `\algocf@makecaption` with `\addtolength{\hsize}`, `\sbox`, `\parbox` (sty:68-74), `\@cftmakeaentitle` (sty:57), conditional on internal `\algocf@within` (sty:63-67). Used by the sample at ch06:81-89 and ap02:123-129. Under a stricter reading of scope this is `BESPOKE/class` (it is a .sty).
- Considered and not counted: Makefile/latexmkrc/compile.bat run xelatex, bibtex, makeindex and splitindex (TeX Live tools, no .tex generated; Makefile:67-89, latexmkrc:11-35); `-shell-escape` is passed to xelatex but no loaded package needs it (minted is commented out, sty:124); EPS assets figures/*.eps need a Ghostscript conversion in the XeTeX path (asset format, noted); the bachelor cover images hitlogo.eps and bthesistitle.eps (dtx:2636, 2649) are shipped image files, so assets and not ART.

## Class setting
- Origin check: https://ctan.org/pkg/hitszthesis lists HITSZThesis 3.2.1, LPPL 1.3c, contained in TeX Live and MiKTeX. The zip ships only hitszthesis.dtx and hitszthesis.ins; hitszthesis.cls, .cfg and .ist are DocStrip output (hitszthesis.ins:87-94), so the class code was read in the .dtx (lines 937-3309, guards cls and cfg).
- Class: `class.hitszthesis` options: type=bachelor, infoleft=true (ex:25); all other keys default (campus=shenzhen, mathfont=newtxmath, boldcaption=false, capcenterlast=true, subcapcenterlast=true, raggedbottom=true, alphappendix=true, bsheadrule=true, bsmainpagenumberline=true, fontset empty; dtx:965-1130). The class LoadClass es `ctexbook[a4paper,openany,UTF8,zihao=-4,scheme=plain]` (dtx:1181) and passes `oneside` for bachelor and master, `twoside` for doctor (dtx:1142-1150).
- Class-native vocabulary used: `\hitszsetup{key=value}` and cover keys (ctitleone, ctitletwo, ctitlecover, ctitle, csubtitle, cxueke, cpostgraduatetype, csubject, caffil, cauthor, csupervisor, cassosupervisor, cdate, cdatesecond, cstudentid, cstudenttype, etitle ... estudenttype, statesecrets, natclassifiedindex, intclassifiedindex, ckeywords, ekeywords; front/coverinformation.tex:3-63), `cabstract` and `eabstract` environments (coverinformation.tex:66-81), `\makecover` (ex:75), `\frontmatter` `\mainmatter` `\backmatter`, `\tableofcontents`, `\chapter{zh}[en]` and `\section{zh}[en]` with an optional English toc title, `conclusions` `acknowledgements` environments, `appendix` environment with `\title{}` as a centered bold heading, `\authorization[scan.pdf]`, `\bicaption`, `\longbionenumcaption`, `\ltfontsize`, `\appendixcaption`, `algorithmen`, `\figref` `\tabref` `\equref`, `\inlinecite`, `\sindex[china]`, size commands `\wuhao[ratio]` etc., `\songti` `\heiti` `\kaishu` `\fangsong`, `\hitszthesis` `\PGR` `\UGR` text macros, `\SetPageNumberingFromOne`, `\SetAppendixWithOnlyHeadings`, `\infowidth`, theorem environments from the cfg (theorem, definition, lemma, ... proof).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | ex:25; dtx:938, 1181 | `class.hitszthesis` | type=bachelor, infoleft=true; base ctexbook a4paper, openany, UTF8, zihao=-4, scheme=plain, oneside |
| CJK support, punctuation, names | dtx:1125, 1161, 1285, 1720, 2011-2021 | `lang.cjk` | ctexbook/xeCJK, AutoFakeBold=2, `\ctexset{punct=quanjiao,space=auto,autoindent=true}`, names 第,章 / 附录 / 目录 / 插图索引 / 表格索引 / 图 / 表 / 参考文献, xeCJKfntef |
| text and math font | dtx:1226, 1231-1233 | `font.newtx` | `newtxtext[defaultsups]`, `newtxmath` (mtpro2 branches dtx:1234-1242 not selected by the sample) |
| fontspec option | dtx:1137 | `font.fontspec` | `no-math` passed to fontspec; CJK families songti/heiti/kaishu by ctex font set (system fonts) |
| font sizes | dtx:1492-1497, 1528-1573 | `font.size-commands` | `\normalsize` 12bp/19.27374bp; `\wuhao[ratio]` family via `\fontsize{#2}{ratio*#2}\selectfont`, e.g. wuhao 10.5bp, xiaosi 12bp, xiaoer 18bp |
| page geometry | dtx:1342-1360 | `page.geometry` | a4paper, hcentering, ignoreall, nomarginpar; text={150mm,224mm}, top=37.5mm, left=30mm, head=5mm, headsep=3mm, footskip=0mm, foot=8mm |
| header and footer | dtx:1611-1707 | `hf.fancyhdr` | styles hitsz@empty, hitsz@onlyheadings, hitsz@headings; bachelor: centre head 宋体 xiaowu school+本科+毕业设计（论文）, centre foot "- n -", headrule = 2.276208pt rule + 0.75pt rule |
| head rule drawing | dtx:1683-1688 | `sp.rule` | `\hrule\@height2.276208pt`, `\hrule\@height.75pt`, `\vskip` 1.190132pt and 0.75pt |
| running-head marks | dtx:1707 | `hf.fancyhdr` | `\chaptermark` gives `\CTEXthechapter\enspace#1` |
| page numbering | dtx:1451, 1471, 2915 | `pgnum.pagenumbering` | Roman in frontmatter, arabic in mainmatter; `\SetPageNumberingFromOne` (dtx:3107) |
| matter switches and blank pages | dtx:1437-1480 | `pg.break` | `\cleardoublepage` wrapped in an empty page style, `\clearpage`, openright and library switches |
| bottom flush | dtx:1266-1268 | `pg.flush` | `\raggedbottom` (class option raggedbottom=true) |
| paragraph and spacing | dtx:1728, 2001, 1494-1497, 3252 | `sp.lengths` | `\parindent=2em`, `\setlist{nosep}`, abovedisplayskip 8pt, `\arraycolsep=1.6pt` |
| display penalties | dtx:1776-1778 | `sp.penalties` | `\predisplaypenalty=0`, `\postdisplaypenalty=0` |
| french spacing in bibliography | dtx:3252, 3272 | `sp.frenchspacing` | `\frenchspacing` inside thebibliography |
| manual spacing | dtx:2557, 2561, 2622; ch04:47 | `sp.manual-space` | `\vspace*`, `\vspace`, `\hspace` on cover and in tables |
| front matter, cover pages | dtx:2549-2898; ex:72-75 | `front.class-native` | bachelor first page: `\parbox[t][h][t]`, tabular of 学院/学号/专业/指导教师; second page: `\includegraphics{hitlogo}` + `{bthesistitle}`, `\underline{\makebox[\infowidth]}` rows (infoleft left-aligned) |
| cover images | dtx:2636, 2649 | `fig.graphicx` | `\includegraphics[width=6.2cm]{hitlogo}`, `[width=10.5cm]{bthesistitle}`; EPS assets shipped in figures/ |
| image search path | ex:58 | `fig.graphicx` | `\graphicspath{{figures/}{pictures/}}` |
| abstracts | dtx:2379-2382, 2911-2923; coverinformation.tex:66-81 | `abs.class-native` | `cabstract` / `eabstract` collected bodies printed by `\makecover` as unnumbered chapters |
| keywords | dtx:2383-2395, 2904-2909, 2918, 2923 | `abs.keywords` | `ckeywords`, `ekeywords` comma lists; separators ；and `,`; hanging box |
| originality and authorization page | dtx:3182-3223; ex:123 | `front.dedication` | `\authorization` prints the bachelor statement; optional `[scan.pdf]` uses `\includepdf` |
| scanned page include | dtx:1253-1254, 3210 | `pg.include-pdf` | `\includepdf[fitpaper=true,pagecommand=...]` (not used by the sample, loaded unconditionally) |
| conclusion, acknowledgements, resume environments | dtx:3124-3135; back/conclusion.tex:4, acknowledgements.tex:4 | `front.class-native` | `\hitsz@appendix@chapter*{title}[en title]` unnumbered chapter with toc and English toc entry |
| contents | dtx:2971-3022; ex:81 | `toc.kernel` | `\tableofcontents` overridden: tocdepth 2, `\@pnumwidth`=4em, `\l@chapter` with dot leaders, `\l@section` 1em/1.8em, `\l@subsection` 2em/2.5em |
| English contents and lists | dtx:3036-3054, 2939-2956 | `toc.kernel` | `\tableofengcontents` reads the `toe` file; `\listoffigures` `\listoftables` `\listofequations` via `\@starttoc` |
| heading looks | dtx:2095-2179 | `head.class-native` | `\ctexset` chapter: centered heiti xiaoer, beforeskip 18.74658bp, afterskip 24.74658bp, aftername `\enspace`, hang title; section 15bp/21bp, 20.25bp skips; subsection 14bp/18bp, 16.5bp; subsubsection normalsize, 13.5bp |
| bilingual headings | dtx:2226-2325 | `head.class-native` | `\RenewDocumentCommand{\chapter}{s o m o}` etc.: 4th argument = English toc entry written to `toe` |
| section depth | dtx:2964-2966 | `num.secnumdepth` | secnumdepth=3, tocdepth=2 (3 with tocfour) |
| counters and numbering | dtx:1779, 1940-1943, 3084 | `num.counters` | `\thefigure`=`\arabic{chapter}-\arabic{figure}`, same for table and equation; `\thesubfigure`=(a); appendix `\thechapter`=`\Alph` |
| appendix | dtx:3078-3091; ex:135 | `num.appendix` | `\appendix` wrapped as environment, `\ctexset{appendix/number=...}` |
| footnotes | dtx:1267, 1738-1766 | `fn.footmisc` | `footmisc[bottom,perpage,hang]`, `\footnotemargin1.5em`, circled numbers `\textcircled{\xiaoliu\arabic{footnote}}`, rule 0.3`\textwidth` |
| footnote command | ch06:9, 93 | `fn.kernel` | `\footnote{...}` |
| float spacing and fractions | dtx:1848-1863, 1388 | `fig.placement` | `\intextsep` `\textfloatsep` 8.50398bp, `\floatsep` 12bp, textfraction .15, topfraction .85, bottomfraction .65, floatpagefraction .60; `placeins[below]`, `flafter` |
| figure float and rotation | ch02:21-25, 188-203 | `fig.graphicx` | `figure[htpb]`, `\includegraphics[width=0.4\textwidth]{golfer}` |
| rotated float | ch02:190, ch04:133 | `fig.rotating` | `sideways` environment inside `minipage{\textheight}` |
| sub-figures | dtx:1393, 1939-1942; ch02:120-133 | `fig.subcaption` | `subfigure[centerlast]`, nested `\subfigure[en]{\subfigure[zh]{...}}` with `\addtocounter{subfigure}{-2}`, `\subfigcapskip=-1bp` |
| captions, bilingual | dtx:1394, 1880-1922, 1968-1972; ch02:24; ch04:19, 50-52 | `cap.memoir` | ccaption `\bicaption`, `\longbionenumcaption`, `\captionnamefont{\wuhao}`, `\captiontitlefont{\wuhao}`, `\abovecaptionskip=0pt`; class `\@makecaption` centers the last line (capcenterlast) |
| single caption | ch02:44; ap01:30 | `cap.kernel` | `\caption{}`, `\caption*{}` |
| tables | ch04:21-29, ap01:32-42 | `tbl.tabular` | `tabular`, `\centering\wuhao`, `m{1.5cm}` columns |
| three-line rules | ch04:22-28; dtx:1295 | `tbl.booktabs` | `\toprule[1.5pt]`, `\midrule[1pt]`, `\bottomrule[1.5pt]` |
| adjustable columns | ch03:20-26; ch04:112-118 | `tbl.tabularx` | `tabularx{\textwidth}{@{}l@{\quad}r@{———}X@{}}`, `{0.7\textwidth}{llX}` |
| long table | ch04:49-95; dtx:1930-1932 | `tbl.longtable` | `longtable`, `\ltfontsize{\wuhao[1.667]}`, `\endfirsthead` `\endhead` `\endfoot` |
| merged cells | ap01:36-39 | `tbl.multirow` | `\multirow{2}{2em}{...}`, `\multicolumn` |
| side-by-side boxes | ch02:59-69, 171-184 | `box.minipage` | `minipage{0.4\textwidth}`, `[t]` variants |
| framed images | ch02:193 | `box.fancybox` | `\fbox{\includegraphics...}` |
| lists | dtx:1259, 1961-1962, 3120-3123, 3149-3164; ap02:179-184; back/appendixB.tex:12-24 | `list.enumitem` | `\setlist{nosep}`, `\setitemize{leftmargin=0em,itemindent=3em,...}`, `\newlist{translationbib}`, `\newlist{idxwordlist}` |
| publication list | dtx:1974-1988; publications.tex:6 | `list.kernel` | `\begin{list}{［\arabic{pubctr}］}` with `\usecounter`, margins set by lengths |
| display equations | ch03:17-19, ap02:26-33 | `math.amsmath` | `equation`, `\tag*{(123)}`, `\bm`, `\allowdisplaybreaks[4]` (dtx:1776), amsmath tag internals patched (dtx:1792-1803) |
| equation numbering | dtx:1779; ch03:36-44; dtx:1307 | `math.eqnumber` | `\theequation`=chapter-n; `subeqnarray` with `\slabel` for sub-equation numbers |
| bold math | sty:26; ch03:18 | `math.bm` | `bm`, `mathrsfs` (sty:29) |
| theorem styles from the class | dtx:1815-1837, 1993-2002 | `thm.class-native` | cfg names 假设 定义 命题 引理 定理 公理 推论 练习 例 注释 问题 猜想, proof 证明, numbered within chapter, 黑体 header, no separator, `\theoremsymbol` square |
| theorem engine and body additions | dtx:1220, 1993-1995; ap02:37, 49 | `thm.ntheorem` | `ntheorem[amsmath,thmmarks,hyperref]`, `\renewtheoremstyle{plain}`, body `\newtheorem{mpdef}{Definition}[chapter]`, `\newtheorem{mpdefop}[mpdef]{Definition}` |
| algorithms | sty:47; ch06:81-89; ap02:123-129 | `alg.algorithm2e` | `algorithm2e[algoruled,linesnumbered,algochapter]`, `\DontPrintSemicolon`, `\KwData`, `\KwResult`, `\setlength\AlCapSkip{1.2ex}`; caption internals are the blocker |
| code listings | sty:81-120; ch03:35 | `code.listings` | `\lstset{language=[LaTeX]TeX, basicstyle=\small\ttfamily, numbers=left, frame=single, breaklines=true, ...}`, `\lstinline` |
| colours | sty:32-36, 84-86; dtx:2558 | `color.xcolor` | `\definecolor` colorzero..colorthree, lightgrey, frenchplum, winered; `\textcolor[rgb]{1,1,1}` dummy line on non-siyuan cover |
| numbers | sty:21-23; ch06:21-22 | `mark.siunitx` | `\sisetup{group-minimum-digits=4,group-separator={\hspace{0.25em}},detect-weight,detect-mode,detect-family}`, `\num{}` |
| citations | dtx:1302, 3226-3297; ch05:13-25 | `bib.natbib` | `natbib[sort&compress]`, `\citestyle{numerical}`, `\bibpunct`, `\inlinecite`, NAT@ internals patched |
| GB/T 7714 citation package | dtx:1301 | `bib.apacite` | `gbt7714` loaded unconditionally (standard-specific citation package) |
| bibliography | ex:119-120; dtx:3237-3272 | `bib.bibtex-bst` | `\bibliographystyle{hitszthesis}` (zip-local hitszthesis.bst with `language=zh` switch, hitszthesis.bst:469-472), `\bibliography{reference}`; class `thebibliography` full-width brackets ［n］ |
| multiple indexes | dtx:1399-1401; ch05:11; ch06:30 | `idx.makeidx` | `splitidx[makeidx]`, `\newindex[]{china}`, `\newindex[]{english}`, `\sindex[china]{key!text}`; `hitszthesis.ist` makeindex style (dtx:1407-1413) |
| index environment | dtx:3140-3147 | `page.adjustwidth` | `adjustwidth{2em}{2em}` inside `ceindex` (not used in the bachelor flow) |
| index columns | dtx:3145 | `cols.multicol` | `multicols*{2}`, `\columnsep=4em` |
| terms and acronyms | sty:128-141; ch06:35 | `idx.glossaries` | `glossaries`, `\setacronymstyle{short-long}`, `\renewcommand*{\genacrfullformat}`, `\newacronym`, `\gls` |
| hyperlinks and bookmarks | dtx:1312-1325 | `meta.hyperref` | CJKbookmarks, linktoc=all, bookmarksnumbered, bookmarksopen, bookmarksopenlevel=3, breaklinks, colorlinks=false, pdfborder={0 0 0}, pdfstartview=FitH, plainpages=false |
| url style | dtx:1330 | `meta.url` | `\urlstyle{same}` |
| cross-reference shorthands | dtx:1951-1953, 1808; ch02:19, ch04:129 | `xref.kernel` | `\figref`=图\ref, `\tabref`=表\ref, `\equref`=式(\ref), `\eqref` |
| external links in text | appendixB.tex:7; dtx:3428-3431 | `xref.hyperref` | `\href{url}{text}` |
| text shape of marks | ch04:28 | `mark.kernel` | `\textbf`, `\emph`, `\textit`, `\textsc` |
| sloppy and ragged setting | dtx:3308 | `sp.hyphenat` | `\AtEndOfClass{\sloppy}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| algorithm2e rule and caption internals, bilingual algorithm list | sty:49-50, 53-58, 62-78 | no (blocker) | overrides `\@algocf@post@ruled`, `\algocf@captiontext`, `\algocf@makecaption` (box and `\hsize` rewrite) and ccaption's internal `\@cftmakeaentitle`; no lib way or declarative key shown for these |
| `\thealgocf` conditional | sty:63-67 | partly | alone it is `\renewcommand\thealgocf` (`num.counters`), but it tests the internal `\algocf@within`; tied to the item above |
| `\AlgoBiCaption` | sty:75-78 | yes, but unused | composition of `\caption` and `\addcontentsline{aen}{algoen}`; depends on the list above; sample never calls it |
| tikz styles and cell macros | sty:143-354; used ch02:222-248 | content | figure artwork for one diagram (`art.tikz`); not template identity |
| math shortcut macros | sty:357-457 | yes | `\newcommand` aliases of `\displaystyle`, `\lim\limits`, `\frac`; `\DeclareMathOperator` (`math.amsmath`) |
| `\cs`, `\cmd` | sty:460-462; `\cs` used ch05:17, ch02:106, 207, 264 | yes | `\cs{x}` = `\texttt{\char`\\x}` (`mark.kernel`); `\cmd` is unused token juggling that only prints a name |
| glossary entries and `\gtssbp` aliases | sty:136-141 | yes | `\newacronym` calls and aliases of `\gls` plus `\sindex` (`idx.glossaries`, `idx.makeidx`) |
| `\lstset` | sty:89-120 | yes | one `\lstset` call (`code.listings`) |
| siunitx setup | sty:22-23 | yes | `\sisetup` (`mark.siunitx`) |
| class code: `\@makecaption` with `\lastbox`, `\@afterheading`, `\l@chapter`, `\@dottedtocline` patch, NAT@ patches, `\make@df@tag` | dtx:1880-1902, 2078-2090, 2995-3015, 2993-2994, 3273-3297, 1792-1803 | not counted | would be BESPOKE/class if the class were zip-local; it is the published CTAN class (W1), so it is one way |
| cfg strings and macros | dtx:2011-2537 | not counted | inside the published class; strings only |
| font set definition | ctex-fontset-siyuan.def:1-86 | yes, unused | loaded only with `fontset=siyuan`; the XeTeX branch (lines 64-78) is `\setCJKmainfont` / `\setCJKfamilyfont` names (`lang.cjk`, `font.fontspec`); the pdfTeX and upTeX branches are irrelevant to an XeLaTeX-only class |
| nested subfigure with counter decrement | ch02:120-133 | yes | published `\subfigure` plus kernel `\addtocounter` (`fig.subcaption`, `num.counters`) |
| body `\newtheorem` | ap02:37, 49 | yes | ntheorem `\newtheorem` (`thm.ntheorem`) |
| docs-only `dtx-style.sty` | dtx:3313-3422 | not loaded | manual driver only |
| build scripts | Makefile, latexmkrc, compile.bat | not template code | orchestrate xelatex, bibtex, makeindex, splitindex |

## Content-opaque
- tikz picture over an included image in a figure (ch02:161-167) and the tumour-evolution tikz diagram in a figure (ch02:222-248) with its styles and cell macros (sty:143-354)
- dummy text from `\lipsum[n]` (ch02:55, 109, 113, 282, 286; ch03:8, 50; ch04:152; ch05:7, 29; ch06:70, 110): content generator, no look effect; the `lipsum` package has no lib way
- included artwork golfer.eps, hitlogo.eps, bthesistitle.eps (shipped assets in EPS; XeTeX converts EPS through Ghostscript, noted)

## Lib changes
- New ways proposed: none. Mappings that stretch an existing line, for the consolidator: `splitidx` to `idx.makeidx` (multi-index package, same family as `index`/`imakeidx`); `gbt7714` to `bib.apacite` (standard-specific citation package, as in the v1 merge); `subeqnarray` to `math.eqnumber` (sub-equation numbering; `math.kernel` is the alternative); ccaption `\bicaption` to `cap.memoir` (its line names ccaption); `\ctexset` heading keys to `head.class-native`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
