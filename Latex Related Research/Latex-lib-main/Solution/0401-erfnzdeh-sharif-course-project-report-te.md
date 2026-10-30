no

# 0401-erfnzdeh-sharif-course-project-report-te: Course Project Report Template (Sharif / TexReady, Persian, XePersian)

- Unverified: read from the source, not compiled.
- Source: Source/0401-erfnzdeh-sharif-course-project-report-te/ (origin: https://codeload.github.com/erfnzdeh/sharif-course-project-report-template/zip/refs/heads/main; licence: not established)
- Kind: report
- Lib: v4
- Engine: needs XeLaTeX (`xepersian` loads fontspec/bidi; README.md:14-17 says compile with XeLaTeX, not pdfLaTeX; `\settextfont` with `.ttf` files at styles/common.tex:50-57)
- Look carried by: preamble (kernel `article` plus `styles/common.tex` and `styles/custom.tex`, plain `\input` files; no zip-local `.cls` or loaded `.sty`; the look is xepersian, fonts, geometry, caption and algorithm settings)
- Class origin: tex-distribution-unbundled
- Main file: Seminar.tex (other samples: none; `chapters/context.tex` is the body it `\include`s)
- Read: main yes, zip-local classes and styles all (no `.cls`; the four `.sty` files in `styles/packages/` are read in full and none is loaded; `unsrtabbrv.bst` header only, it is commented out at bibs/bibs.tex:13)

## Verdict
No. Almost every component maps to a lib way, because xepersian's Persian-named commands are aliases of kernel commands (`lang.polyglossia`) and the rest is `article`, `geometry`, `caption`, `algorithmicx`, `multicol`, `hyperref`. One construct has no way: `\def\MathDecimalSeparator{\decimalseparator@point}` (styles/common.tex:102-104) overwrites a private macro of xepersian's `unicode-persianmath.sty` to change how every decimal point in maths prints; no option of any lib way does that, so it is irreducible `BESPOKE/preamble` (a wrong yes costs more). The remaining zip-local code is reducible, and the one pstricks figure is content.

## Blockers
- `BESPOKE/preamble` `\makeatletter\def\MathDecimalSeparator{\decimalseparator@point}\makeatother` redefines an internal macro of the published xepersian package (not in the zip) so the maths decimal point is a plain period instead of U+066B; fails W2 (code edit, not an option); the README says so itself (styles/common.tex:102-104; README.md:243-248) and its only declarative alternative `mathdigits=default` changes the digits to Latin, which is a different look (README.md:262)

## Class setting
- Class: `class.article` options: `oneside,a4paper,12pt` (Seminar.tex:12). The class is the TeX distribution's kernel article; its source is not read.
- Class-native vocabulary used: `\section` `\subsection` `\subsubsection` (chapters/context.tex:18,24,78), `\appendix` through `\begin{appendix}` (Seminar.tex:50), `\pagestyle` `\pagenumbering` (Seminar.tex:31-38); no `\maketitle`, no `abstract` environment, no `\tableofcontents`. Persian-named commands of xepersian are used for `itemize` (chapters/context.tex:39), `enumerate` (:278), `figure` (:176), `\caption` (:178), `\label` (:179), `\ref` (:173), `\cite` (:51-52), `\footnote` (:51), `\noindent` (:5), `table` (:212), `\centering` (:213), `tabular` (:216), `\hline` (:217).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| paper, size, sides | Seminar.tex:12 | `page.class-options` | `a4paper`, `12pt`, `oneside` |
| page geometry | styles/common.tex:11,36 | `page.geometry` | `\usepackage{geometry}`, then `\newgeometry{margin=1in,bottom=1.1in,footskip=.4in}` (a `3cm/2.5cm` variant is commented at :35) |
| line spacing | styles/common.tex:38-39 | `sp.linespread` | `\baselinestretch`=1.4, then `\linespread{1.6}` (the later one is the effective value) |
| paragraph spacing | styles/common.tex:40 | `sp.lengths` | `\parskip`=0.45em |
| Persian language, direction, digits | styles/common.tex:22-26 | `lang.polyglossia` | `xepersian` with `localize=on,extrafootnotefeatures`; the `\ifnewXePer` branch only picks the spelling `localize`/`localise` (Seminar.tex:14) |
| text, digit and sans fonts | styles/common.tex:50-71 | `lang.polyglossia`, `font.fontspec` | `\settextfont` and `\setdigitfont` with `Scale=1.1667,Extension=.ttf,Path=styles/fonts/,BoldFont/ItalicFont/BoldItalicFont` for family `XB Niloofar`; `\defpersianfont\sayeh` `XB Kayhan Pook` `Scale=1` (defined, never used) |
| optional Sharif font switch | styles/common.tex:78-91; Seminar.tex:25 | `lang.polyglossia`, `font.fontspec` | macro `\shariffont` = the same two commands with `Scale=1.5`, family `Sharif1.3-Regular`, `BoldFont=Sharif1.3-SemiBold`; its only call is commented out |
| maths decimal separator | styles/common.tex:102-104 | none (blocker above) | `\def\MathDecimalSeparator{\decimalseparator@point}` |
| number-separator mark | styles/common.tex:110 | `lang.polyglossia` | `\SepMark{-}` |
| bullets | styles/common.tex:111 | `list.kernel`, `font.size-commands` | `\labelitemi` = `{\small\textbullet}` |
| link colours, hyperlinks | styles/common.tex:8 | `meta.hyperref` | `colorlinks,linkcolor=blue,citecolor=blue` |
| colour option names | styles/common.tex:9 | `color.xcolor` | `usenames,dvipsnames` given to the `pstricks` load line; no `\definecolor` outside the figure at figs/cover.tex:11 |
| title page | front/template/title.tex:2-47; Seminar.tex:31-33 | `front.titlepage-env`, `hf.pagestyle-kernel` | hand-laid `center` environment: logo `\includegraphics[scale=0.2]`, `\vspace`, `\\[-0.3em]`, `\LARGE\textbf`, `\Large`, a `latin` block, `\newpage`; `\pagestyle{empty}` before it. Strings come from `\newcommand`s in front/info.tex:6-35 |
| logo image | front/template/title.tex:4 | `fig.graphicx` | `scale=0.2`, file front/template/images/logo.png |
| optional besmellah page | front/template/besmellah.tex:2-6; Seminar.tex:34 | `fig.graphicx` | `\includegraphics[scale=0.7]` in `center`; the call is commented out |
| abstract and keywords | chapters/context.tex:5,14 | `abs.keywords`, `mark.kernel` | no abstract environment: a `\noindent` paragraph with the bold label from `\مهم` (= `\textbf`, common.tex:178) for both the abstract and the keyword line |
| headings, numbering | chapters/context.tex:18,24,78 | `head.kernel`, `lang.polyglossia` | default article `\section` to `\subsubsection`, no `\titleformat` or `\renewcommand` of the heading look; Persian digits and the `-` separator come from xepersian (styles/common.tex:23,110) |
| appendix | Seminar.tex:50-52; chapters/appendix.tex:2 | `num.appendix` | `\begin{appendix}` ... `\end{appendix}` around a section made with `\قسمت` (= `\section`) |
| file structure | Seminar.tex:17-18,30,33,42,45,51 | `struct.input` | `\input` of two style files, `\include` of info, title, context, bibs, appendix |
| page style, numbering | Seminar.tex:31,37-38 | `hf.pagestyle-kernel`, `pgnum.pagenumbering` | `empty` then `plain`; `\pagenumbering{arabic}` (`tartibi` commented at :39) |
| list and contents names | styles/common.tex:141-142; bibs/bibs.tex:8 | `toc.kernel` | `\listfigurename`, `\listtablename` renewed; `\addcontentsline{toc}{section}{مراجع}` (no `\tableofcontents` in the sample) |
| lists | chapters/context.tex:39-44,103-144,159-163,278-290 | `list.kernel` | `itemize` and `enumerate` under Persian names |
| columns | chapters/context.tex:152-165 | `cols.multicol` | `multicols{2}` around two lists |
| display and inline maths | styles/common.tex:7,12; chapters/context.tex:86-90,457-459 | `math.amsmath`, `math.amssymb`, `math.bm` | `amsmath`, `amssymb`, `\usepackage[mathscr]{euscript}` (a math-alphabet package, as `mathrsfs`); `equation` environment |
| theorem-like statements | styles/common.tex:118-125; chapters/context.tex:262-265,453-476,512-519 | `thm.kernel` | eight `\newtheorem` with Persian names and header words, counters `[section]`, one shared counter `[قضیه]`; `تعریف` takes an optional name argument |
| proof environment | styles/common.tex:128-130 | `thm.kernel` | reducible, see bespoke table (not used in the sample body) |
| algorithms | styles/common.tex:17,28-29; styles/alg-fa.tex:5-35; chapters/context.tex:236-250 | `alg.algorithmicx` | `algorithmicx`, `algorithm`, `algpseudocode[noend]`; keyword strings renewed to Persian (`\algorithmicfor` ... `\algorithmicensure`); `\algorithmiccomment` = `$\triangleleft$ \emph{#1}`; `algorithmic[1]` numbered lines |
| figures | chapters/context.tex:176-180,186-190,195-200,446-451,478-482 | `fig.graphicx`, `fig.placement` | `figure[ht]` and `[t]` under the Persian name, `\centerimg{file}{width}` and `\centerfig{file}{.9}`; `\graphicspath{{figs/}}`; `\setlength{\intextsep}{0pt}` (styles/common.tex:205-206) |
| wrapped figure helpers | styles/common.tex:209-224 | `fig.wrapfig` | `\floatbox`, `\fig`, `\img` over `wrapfigure{l}`; defined, never called in the sample |
| sub-figures | styles/common.tex:10 | `fig.subcaption` | `subfigure` loaded, no use in the sample |
| tables | chapters/context.tex:212-228,553-570; styles/common.tex:14 | `tbl.tabular`, `tbl.multirow` | `table[ht]` / `[t]`, `\centering`, `tabular{|c|c|}`, `\hline` doubled; `multirow` loaded, not called |
| captions | styles/common.tex:15; chapters/context.tex:178,214 | `cap.caption`, `cap.kernel` | `figureposition=bottom,tableposition=top,font={small,bf},labelfont=bf`; `\شرح` = `\caption` |
| footnotes | styles/common.tex:185; chapters/context.tex:51-55,286,369 | `fn.kernel`, `lang.polyglossia` | `\footnote` under three Persian names; `\پاورقی` puts the text in `\lr{}`; xepersian option `extrafootnotefeatures` |
| cross-references, links | chapters/context.tex:173,179,299 | `xref.kernel`, `xref.hyperref` | `\برچسب` (= `\label`) and `\رجوع` (= `\ref`); `\href` in a footnote; `\phantomsection` at bibs/bibs.tex:7 |
| bibliography | bibs/bibs.tex:6-21 | `bib.bibtex-bst` | `\bibliographystyle{ieeetr-fa}` (not in the zip, taken to come with the xepersian install; not verified), `\bibliography{bibs/full,bibs/refs}` inside a `latin` block, `\footnotesize`, `\baselineskip=.8\baselineskip`; citations through `\مرجع` (= `\cite`); heading word `\refname` = `\rl{{مراجع}\hfill}` (styles/common.tex:143) |
| mixed-direction helpers | styles/common.tex:132-135,183-184; bibs/bibs.tex:10 | `lang.polyglossia` | `latin` environment, `\lr`, `\rl` |
| LaTeXDraw picture in a figure | styles/common.tex:9,207; figs/cover.tex:8-20 | `art.pstricks` | content-opaque, see below |
| glossary page (not built) | styles/common.tex:192-200; front/dictionary.tex:1-115; Seminar.tex:46 | `sp.rule`, `box.minipage`, `sp.manual-space` | `\dic` = `\noindent #2 \dotfill \lr{#1}\\`; `\dicalphabet` = `minipage` + `\centerline`; the `\include` is commented, and dictionary.tex uses `\chapter*` (:6), which `article` lacks |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\MathDecimalSeparator` redefinition | styles/common.tex:102-104 | no | edits a private macro of xepersian through `\makeatletter`; BESPOKE/preamble (blocker) |
| `\renewcommand{\psscalebox}[1]{}` | styles/common.tex:207 | yes, content support | swallows the scale wrapper that LaTeXDraw writes at figs/cover.tex:8; it only serves the content-opaque pspicture, not the template look |
| `\newif\ifnewXePer` and the two `\usepackage` branches | Seminar.tex:14-15; styles/common.tex:22-26 | yes | fold the constant: `\usepackage[localize=on,extrafootnotefeatures]{xepersian}` (`lang.polyglossia`) |
| `\shariffont` | styles/common.tex:78-91 | yes | two xepersian font commands (`lang.polyglossia`, `font.fontspec`), call commented out |
| `\مهم` `\لر` `\کد` `\پاورقی` `\REM` and the `\renewcommand` aliases `\برچسب` `\حذف` | styles/common.tex:178-185 | yes | inline expansion: `\textbf`, `\lr`, `\lr{\tt #1}`, `\footnote{\lr{#1}}`, empty macro |
| maths macros `\IN` `\set` `\seq` `\ceil` `\floor` `\card` `\setcomp` `\iequiv` `\imod` `\poly` `\polylog` `\eps` `\lee` `\gee`, and `\renewcommand` of `\le` `\leq` `\ge` `\geq` | styles/common.tex:149-176 | yes | aliases of `\mathbb`, `\left..\right`, `\overset`, `\mathop{\mathrm{}}`, `\leqslant` (`math.amsmath`, `math.amssymb`) |
| `\OPT` `\APX` `\ALG` | styles/custom.tex:7-9 | yes | `\mathop{\mathrm{}}` aliases |
| theorem set | styles/common.tex:118-125 | yes | kernel `\newtheorem` calls (`thm.kernel`) |
| `اثبات` environment | styles/common.tex:128-130 | yes | kernel `trivlist` with an italic head, `\hspace*{\fill}` and `\square`; kernel, `mark.kernel`, `sp.manual-space`, `math.amssymb`; not called in the sample |
| `alg` environment | styles/common.tex:132-135 | yes | `latin` block + `\settextfont[Scale=1.0]{Times New Roman}` + `algorithm[t]` + `algorithmic[1]`; Times New Roman is not shipped; not called |
| `الگوریتم` environment | styles/alg-fa.tex:5-7 | yes | `\bigskip`, `algorithm`, `\caption`, `\label`, `\vspace{0.5em}`, `algorithmic[1]` (`alg.algorithmicx`, `sp.manual-space`) |
| algorithm keyword strings and Persian aliases | styles/alg-fa.tex:10-35 | yes | `\renewcommand` of `\algorithmic*` strings, `\newcommand` aliases of `\If` `\Else` `\ElsIf` `\EndIf` `\For` `\While` `\State` `\Statex` `\Comment` `\Return` `\Require` `\Ensure` |
| `\floatbox` `\centerfig` `\fig` `\centerimg` `\img` | styles/common.tex:209-224 | yes | inline expansion to `wrapfigure`, `\centering\scalebox{}{\input{}}`, `\includegraphics[width=]{}` between `\vspace`; `\NewDocumentCommand` with `\IfValueTF` only picks a default width |
| `\dic` `\dicalphabet` | styles/common.tex:192-200 | yes | see the glossary row; not built |
| info macros | front/info.tex:6-35 | yes | content strings for the title page |
| vendored `algorithm.sty`, `algorithmic.sty`, `algpseudocode.sty`, `algorithmicx.sty` | styles/packages/ | not loaded | published packages with their own headers (algorithm.sty:28-30, algorithmicx.sty:12); the copy of `algorithmicx.sty` is edited at :71 (`\lr{}` round the line number) and :581 (comment "Changed by Hamid"); the sample loads the packages by name (styles/common.tex:17,28), so these are found only if the build puts `styles/packages` on the search path, which nothing in the zip does |

## Content-opaque
- LaTeXDraw `pspicture` graph (circles, lines, `\rput`) input in a figure: figs/cover.tex:8-20, used at chapters/context.tex:177; `art.pstricks`. It needs pstricks with XeLaTeX; README.md:278 reports a clean build, which was not checked.
- PDF figures (Ipe and drawio exports) in `figure` floats: chapters/context.tex:187,196,447,479; logo.png in the title (front/template/title.tex:4).
- Not part of the build: tools/normalize-glyph-names.py is a one-time repair of the bundled fonts (README.md:206-211); the document does not call it and the fonts are shipped already repaired. Noted so nothing is hidden; it is not scored as EXTERNAL.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
