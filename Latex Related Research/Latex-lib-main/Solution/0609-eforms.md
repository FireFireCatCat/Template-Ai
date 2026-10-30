no

# 0609-eforms: AcroTeX eDucation Bundle (web, exerquiz, eforms, insdljs, dljslib, taborder) and its AeB manual

- Unverified: read from the source, not compiled.
- Source: Source/0609-eforms/ (origin: https://mirrors.ctan.org/macros/latex/contrib/acrotex.zip; licence: lppl1)
- Kind: misc (a package bundle; the main sample is its reference manual, the demos in examples/ are quiz and exercise sheets)
- Lib: v5
- Engine: pdfLaTeX-compatible (`web` and `exerquiz` detect pdfTeX, web.dtx:201, doc/aeb_man.tex:1012-1014; dvips with Distiller, dvipdfm and XeTeX are also supported, web.dtx:130-217). The main sample's `docassembly` block needs Acrobat (doc/aeb_man.tex:311-317).
- Look carried by: mixed (the published `web` package, set by options and layout commands in doc/aeb_man.tex:6-11 and 118-126, loaded through the unshipped `aeb_pro`; preamble overrides at doc/aeb_man.tex:49-134)
- Class origin: tex-distribution-unbundled (`article`, loaded unchanged; no class file in the zip)
- Main file: doc/aeb_man.tex (other samples: doc/eformman.tex, examples/webeqtst.tex, examples/jquiztst.tex, examples/jtxttst.tex)
- Read: main partly (doc/aeb_man.tex lines 1-1259, 1262-1301, 1520-1580, 1720-1800, 2420-2610, 2697-2766, 3655-3745, 4270-4500, 5255-5315, 9880-10010 and 11555-11855 read, plus the dead text after `\end{document}` at 12380-12829; the rest of its 11,771 typeset lines is prose and Verbatim listings, taken from a grep outline of environments and definitions), zip-local classes and styles partly (aeb-comment.sty, web.cfg, contsolns.dtx, taborder.dtx read in full; of the published package sources web.dtx, eforms.dtx, exerquiz.dtx, insdljs.dtx and dljslib.dtx only the option, RequirePackage, sectioning and page-style parts were read; eformman.tex lines 1-400 and 547-790 read, the rest by outline; the three examples/*.tex read in full)

## Verdict
The look of the packages is carried by published `web`, `exerquiz`, `eforms`, `insdljs` and `dljslib` (CTAN acrotex bundle), which map onto `page.pdfscreen`, `exam.questions` and `form.eforms`, and the three examples/*.tex demos would map without blockers. The main sample doc/aeb_man.tex, however, loads four packages that are neither in the zip nor shown to be published (`aeb_pro` is not on CTAN: ctan.org/pkg/aeb_pro answers HTTP 410; the CTAN acrotex page lists only web, exerquiz, eforms, insdljs, dljslib and eq2db), and the hundreds of body macros that come from them cannot be reduced here. It also embeds an Acrobat JavaScript post-processing block. So `no`, on the main sample.

## Blockers
- `UNMAPPED/preamble` `aeb_pro` loads web, exerquiz and dljslib with option lists and `aebxmp`; not shipped, not on CTAN, source unread (doc/aeb_man.tex:6-11; doc/eformman.tex:4-8)
- `UNMAPPED/preamble` `spdef` (doc/aeb_man.tex:2), `aeb_mlink` (doc/aeb_man.tex:22) and `acroman` (doc/aeb_man.tex:35) not shipped, not listed on the CTAN acrotex page; the macros the body uses from them have no definition in the zip (grep over every .dtx, .sty, .cfg and .ins finds none): `dCmd`/`dCmd*` environments with `\bVerb\takeMeasure{..}` and `\bxSize` (doc/aeb_man.tex:1270-1275, 47 uses), `\newtopic` (342), `\redpoint` (474), `\handpoint` (444), `\Com` (1526), `\exAeBBlogPDF` (714), counter `aebEx` (282-286), switch `\ifusebw` (201), `\DeclareInitView` (29)
- `EXTERNAL/preamble` `docassembly` environment runs Acrobat JavaScript (`\addWatermarkFromFile`, `\executeSave`) after PDF creation, on a background PDF at an absolute path that is not shipped (doc/aeb_man.tex:310-317; same in doc/eformman.tex:280-316); the manual itself says the `aeb_pro` features need Acrobat 7 or higher (doc/aeb_man.tex:893-896)

## Class setting
- Class: `class.article` options: none (doc/aeb_man.tex:3)
- Class-native vocabulary used: `\title` `\author` `\maketitle` (320) `\tableofcontents` (336) `\part` `\section` `\subsection` `\paragraph`, `thebibliography` (11702), `quote`, `itemize` `enumerate` `description`, `figure` (536); the `web` extensions `\subject` `\Keywords` `\university` `\email` `\version` `\prepared` `\copyrightyears` `\nocopyright` `\DesignTitlePageTrailer` (232-266)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | doc/aeb_man.tex:3 | `class.article` | no options |
| screen page layout, title page, section look | doc/aeb_man.tex:6-11, 118-126, 232-266; web.dtx:396, 2683-2703, 4336, 5079-5107 | `page.pdfscreen` | `web` options centertitlepage, designv, forcolorpaper, latextoc, pro; `\hproportionwebtitle{.75}`; `\universityLayout{fontsize=Large,fontfamily=sffamily}` `\titleLayout` `\authorLayout` `\tocLayout{color=aeb}`; `\sectionLayout{indent=-62.5pt,fontsize=large,color=aeb,fontfamily=sffamily}` `\subsectionLayout{indent=-31.25pt}` `\subsubsectionLayout{indent=0pt}`; `\subsubDefaultDing`; `\DesignTitlePageTrailer{ul,ur,lr,raise=-25pt}`; `\universityColor{aeb}` `\tocColor{aeb}`. web.dtx:201 gives a `pdftex` driver option, which settles the pdfTeX question the lib line leaves open |
| running head and foot | doc/aeb_man.tex:109-112; web.dtx:2600-2615 | `page.pdfscreen` | web page style `webheadings`; hook `\webheadwrapper` redefined as `\makebox[\totaltextwidth][s]{#1}` with `\totaltextwidth` from `\fullscreenwidth` plus `\oddsidemargin` (106-108) |
| exercises, short quizzes, quizzes | doc/aeb_man.tex:9, 101-102, 4325-4332, 4392-4424, 5281-5293, 11695-11697; examples/webeqtst.tex:96-115, 243-252, 326-343 | `exam.questions` | package `exerquiz` as the parameter: option `nocorrections`; `exercise`, `exercise*`, `parts[2]`, `solution`, `shortquiz`, `quiz`, `answers{4}` with `\Ans0`/`\Ans1`, `manswers`, `\includeexersolutions` `\includequizsolutions`; label hooks `\exlabelformat` `\exlabelformatwp` |
| form fields and document JavaScript library | doc/aeb_man.tex:10, 5304-5306; exerquiz.dtx:869; eforms.dtx:295; dljslib.dtx:175-176; examples/jquiztst.tex:10 | `form.eforms` | exerquiz loads `eforms` (which loads `insdljs`); `dljslib` options ImplMulti, limitArith, nodec, satisfyEq; check boxes and radio fields set by key lists; the JavaScript text stays outside the way |
| document-level JavaScript insertion | doc/aeb_man.tex:294-306; insdljs.dtx:841-880 | `form.eforms` | `insDLJS[indefCompare]{compare}{Comparisons}`; the body is program code (see Content-opaque) |
| path macro | doc/aeb_man.tex:167, 310; eforms.dtx:2543 | `form.eforms` | `\definePath{\urlAcroTeXBlog}{http://www.acrotex.net/blog}` (defined in eforms) |
| maths | doc/aeb_man.tex:5, 83 | `math.amsmath`, `math.eqnumber` | `fleqn`; `\mathindent` set to `\parindent` |
| hyperlinks and PDF metadata | web.dtx:999-1017; doc/aeb_man.tex:151, 188-191, 212 | `meta.hyperref` | web loads hyperref with bookmarks, bookmarksnumbered, bookmarksopen, colorlinks, linkcolor=webgreen, filecolor=webbrown, citecolor=webgreen, urlcolor=webbrown, pagebackref, pdfpagemode=UseNone, pdfstartview=Fit, pdfpagelayout=SinglePage; `\hypersetup{linktocpage}`; `\pdfstringdefDisableCommands`; `\backrefalt` |
| bookmarks | doc/aeb_man.tex:28-30, 322-329 | `meta.bookmark` | package `xbmks` (on CTAN, LPPL 1.2, read once) is the parameter: `\xbmksetup{colors={int=red},styles={intbf}}`, `\pdfbookmarkx[1]{..}[action={\GoToR/F(..)/D[0 /Fit]},color=blue,style={bf}]{..}`, `\belowpdfbookmarkx`; actions `\Named` `\GoToR` `\URI` come from insdljs.dtx:841-880 |
| cross-references | doc/aeb_man.tex:477, 534, 183-185 | `xref.kernel`, `xref.hyperref` | `\label` `\ref` `\pageref`, `\hyperref[..]{..}`, `\nameref` `\Nameref` |
| contents list | doc/aeb_man.tex:336, 49-65; web.dtx:267 | `toc.kernel` | option `latextoc` keeps the standard list; `\l@section` `\l@subsection` `\l@subsubsection` `\@pnumwidth` redefined (reduction in Bespoke code) |
| section numbering depth | doc/aeb_man.tex:38-39 | `num.secnumdepth` | secnumdepth 4, tocdepth 4 |
| paragraph headings | doc/aeb_man.tex:129-134 | `head.kernel` | `\paragraph` as `\@startsection{paragraph}{4}{0pt}{6pt}{-3pt}`, `\subparagraph` level 5 with `\parindent`, both `\normalfont\normalsize\bfseries` |
| colour | doc/aeb_man.tex:222 | `color.xcolor` | `\definecolor{aeb}{rgb}{0.24,0.38,0.68}`; web uses xcolor unless `noxcolor` (web.dtx:109) |
| text face | doc/aeb_man.tex:12 | `font.serif-pkg` | `lucidbry[altbullet]`: a font package, origin not established, fonts not shipped (noted, not a blocker) |
| symbols and font selection | doc/aeb_man.tex:203-205, 214-215 | `font.icons`, `font.nfss` | `\Pisymbol{webd}{254}`, `\ding{045}` (pifont); `\usefont{OMS}{cmsy}{m}{n}` in `\AmS` |
| spacing parameters | doc/aeb_man.tex:149, 308 | `sp.lengths`, `sp.frenchspacing` | `\hfuzz=1pt`; `\frenchspacing` |
| manual spacing and boxes | doc/aeb_man.tex:196-199, 269-276 | `sp.manual-space`, `box.fancybox`, `note.marginpar` | `\makebox`, `\raisebox`, `\fbox`; `\reversemarginpar` (32); margin notes `\FmtMP` |
| lists | doc/aeb_man.tex:192-194, 666-693, 3724-3730 | `list.kernel` | `\list{}{\leftmargin\amtIndent}`; `list` with `\usecounter{questionno}`, `\settowidth{\labelwidth}`, `\labelsep0pt`, `\makelabel` set to a `\hyperref` bullet |
| quotation | doc/aeb_man.tex:344-346, 505-509 | `quote.kernel` | `quote` |
| verbatim listings | web.dtx:28; doc/aeb_man.tex:718-723, 1536-1543 | `code.verbatim` | `fancyvrb` `Verbatim` (loaded by web, eforms, exerquiz, insdljs), 365 uses; keys xleftmargin=\amtIndent, commandchars=!(), fontsize=\small, numbers=left |
| long and plain tables | doc/aeb_man.tex:23, 79-81, 926-932, 1741-1745, 11572-11692 | `tbl.longtable`, `tbl.tabular` | `\setlongtables`, `\LTpre=0pt`, `\LTpost=-2\medskipamount`; column types `>{\ttfamily}l`, `p{.5\linewidth}`; `colortbl` is loaded but used only in a comment (11564) |
| figures | doc/aeb_man.tex:24, 536-539, 811-814 | `fig.graphicx`, `cap.kernel` | `figure[hbt]` with `\includegraphics[scale=.6]{figures/miktex_roots}` and `[width=.5\linewidth]{figures/SecurityPrefs}` and `\caption`; the figures/ folder is not in the zip |
| footnotes | doc/aeb_man.tex:480, 573 | `fn.kernel` | `\footnote` |
| bibliography | doc/aeb_man.tex:11702-11767 | `bib.thebibliography` | `thebibliography{[1]}`, `\bibitem`, `\backrefprint` |
| web-only and paper-only text | doc/aeb_man.tex:2426-2473 (shown in listings only) | `page.pdfscreen` | `forpaper`, `forscreen`, `\prtscr`, `\NewPage` of web; not live in the sample |

Loaded but unused or without printed effect, so not a component: `multicol` (25, no `multicols` environment), `collectbox` (26), `\newbox\aebbox` (33), `srcltx[active]` (36, source specials), the `comment` environment (451-457; aeb-comment.sty:296 `\excludecomment{comment}` discards its text). Considered: `xbmks` into `meta.bookmark`.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\l@section` (hand-built `\leftskip` `\rightskip` `\parfillskip`), `\l@subsection`, `\l@subsubsection`, `\@pnumwidth` | doc/aeb_man.tex:49-65 | yes | `toc.tocloft`: `\cftsecfont{\bfseries}`, `\cftsecindent`, `\cftsecnumwidth{2em}`, `\cftbeforesecskip{1em plus 1pt}`, `\cftpnumwidth{2.55em}`, `\cftsubsecindent{2em}` `\cftsubsecnumwidth{3.5em}`, `\cftsubsubsecindent{5.5em}` `\cftsubsubsecnumwidth{1.5em}` |
| `\paragraph`, `\subparagraph` | doc/aeb_man.tex:129-134 | yes | `head.kernel` (kernel `\@startsection` parameters), or `\titleformat`+`\titlespacing` |
| `\webheadwrapper` redefinition, `\totaltextwidth` | doc/aeb_man.tex:106-112 | yes | web's own hook (web.dtx:2602) plus a `\makebox` width in `sp.manual-space` |
| `\aebCng`, `\@aebCng` | doc/aeb_man.tex:135-136 | yes | the inner macro is empty, no printed effect; delete |
| name and logo macros `\AcroT` `\AcroB` `\AEB` `\AcroFLeX` `\AmS` `\dps` `\Y&Y` `\latex/` | doc/aeb_man.tex:155-179, 206-207, 214-220, 228-230 | yes | inline expansion with `\kern`, `\lower`, `\textsf`, `\textcolor` (`sp.manual-space`, `mark.kernel`, `color.xcolor`) |
| `\chgCurrLblName` | doc/aeb_man.tex:47 | yes | sets the string `\nameref` prints; replace by the string (`xref.hyperref`) |
| `aebQuote`, `\FmtMP`, `\aebbkFmtMp`, `\BlogArticle`, `\exPDF`, `\makeExBox`, `\expoint` | doc/aeb_man.tex:192-205, 269-276 | yes, but the font `webd`/`zqacr` is not shipped | `list.kernel`, `note.marginpar`, `font.icons`, `box.fancybox`, `meta.hyperref` (`\href{run:..}`), colour; `\ifusebw` (200-201) is a switch from `spdef` |
| `\Ex`, `\CmdLoc`, `\EnvLoc`, `\KVP`, `\PD`, `\Important`, `\CmdDescription`, `\insMargin` | doc/aeb_man.tex:285-292 | yes | `\par\medskip\noindent\textbf{..}` run-in labels (`mark.kernel`, `sp.manual-space`) and `\refstepcounter` of a counter (`num.counters`) |
| `\FitItIn`, `\endredpoint` | doc/aeb_man.tex:208-209 | yes | call into exerquiz's own `\eq@fititin`, so the way is `exam.questions`; the symbol is `\blacktriangleleft` in red or black |
| `\js` with an active `^` | examples/jquiztst.tex:38-41 | yes | inline `\texttt{..}` text (`code.verbatim`) |
| `problem` and `example` environments with `\newcounter{probno}[section]` | examples/webeqtst.tex:38-60 | yes | exerquiz hooks `\exlabel` `\exlabelformat` `\exrtnlabelformat` `\exsecrunhead` set in a `\newenvironment` that wraps `exercise` (`exam.questions`, `num.counters`) |
| `dCmd`, `dCmd*`, `\bVerb\takeMeasure`, `\bxSize`, `\newtopic`, `\redpoint`, `\handpoint`, `\Com`, `\exAeBBlogPDF`, counter `aebEx`, `\DeclareInitView` | body, 47+ environments (doc/aeb_man.tex:1270-1275 and later); definitions are in `aeb_mlink`, `aeb_pro` or `spdef` | no (source not present, W1 not shown) | blocker `UNMAPPED/preamble` above |
| `docassembly` block | doc/aeb_man.tex:311-317 | no | blocker `EXTERNAL/preamble` above |

## Content-opaque
- JavaScript function `indefCompare` in `insDLJS` (doc/aeb_man.tex:294-306) and the Acrobat JavaScript in `docassembly` (311-317): program code, not typesetting
- figure artwork `figures/miktex_roots` and `figures/SecurityPrefs` (doc/aeb_man.tex:537, 812), not shipped
- the quiz and exercise texts, answers and the Verbatim listings of the manual; JavaScript strings in field keys such as `\A{\JS{app.alert(..)}}` (doc/eformman.tex:589)
- text after `\end{document}` (doc/aeb_man.tex:11773-12829) is never typeset and was not counted

## Lib changes
- New ways proposed: none
- Remarks for the consolidator (no proposal): `page.pdfscreen` line says pdfTeX support for `web` is not established; web.dtx:201 declares a `pdftex` driver option and web.dtx:96 loads `ifpdf`. `xbmks` was read at ctan.org/pkg/xbmks (LPPL 1.2, D. P. Story) and filed under `meta.bookmark`. `exerquiz` filed under `exam.questions`. The CTAN pages read were acrotex, aeb_pro (HTTP 410) and xbmks.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
