yes

# 0562-qyxf-book: qyxf-book (钱院学辅书籍模板, Qian Yuan Xue Fu book class)

- Unverified: read from the source, not compiled.
- Source: Source/0562-qyxf-book/ (origin: https://mirrors.ctan.org/macros/latex/contrib/qyxf-book.zip; licence: MIT, LICENSE:1 and ctan.org/pkg/qyxf-book)
- Kind: book (Chinese course-helper book; the manifest hint `book` agrees with the sample)
- Lib: v4
- Engine: needs XeLaTeX (`\setmainfont` and `unicode-math` at qyxf-book.cls:44-47, xeCJK option at qyxf-book.cls:38; the sample states XeLaTeX only, qyxf-book-doc.tex:1 and :103-105)
- Look carried by: class (the look is `qyxf-book.cls`, a CTAN class; the sample sets class options and a few class-native hooks only)
- Class origin: ctan (ctan.org/pkg/qyxf-book: "a LaTeX document class", v3.1.0 2020-09-11, MIT; same version as qyxf-book.cls:9-10)
- Main file: qyxf-book-doc.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (qyxf-book.cls read in full, 426 lines; it is the CTAN release, so published and not zip-local; the classes and packages it loads, `ctexbook` and `kvoptions` and others, are not bundled and were not read)

## Verdict
Yes. The sample document is a user manual whose body uses only constructs the CTAN class `qyxf-book` defines or that kernel LaTeX provides, so the look is carried by a published class (W1 met: CTAN, MIT). As a cross-check, if the class were instead treated as zip-local, every macro in it still reduces to published packages with parameters (tcolorbox, titlesec, titletoc, fancyhdr, enumitem, caption, natbib, xcolor, hyperref, kernel commands), with no irreducible code, no artwork and no external tool, so the answer would stay yes (see Bespoke code; the `\tableofcontents` redefinition is the one place where exact spacing parity is not claimed).

## Blockers
none

## Class setting
- Class: `class.qyxf-book` options: `10pt`, `twoside`, `openany`, `b5paper` (all passed on to `ctexbook`, qyxf-book.cls:33), `colorscheme = basic` (qyxf-book-doc.tex:2-8). Class-only options: `colorscheme` (basic, black, rbb, bootstrap-v4), `primary`, `secondary`, `xits` (default true), `noCJKfont` (qyxf-book.cls:18-22, :109-178).
- Loaded class: `ctexbook` (qyxf-book.cls:39; CTAN ctex bundle, source not read). The class is XeLaTeX-only through `fontspec` and `xeCJK`.
- Class-native vocabulary used: `\subtitle`, `\org`, `\footorg`, `\cover`, `\license`, `\typo` (set, not used) (qyxf-book-doc.tex:11,17-20,14); hooks `\titlefont`, `\subtitlefont` redefined (qyxf-book-doc.tex:23-24; defaults `\authorfont`, `\datefont` at qyxf-book.cls:344-347); `\maketitle` (cover page plus work-information page, qyxf-book.cls:348-384); `\tableofcontents` (qyxf-book.cls:396-407); environments `theorem` `lemma` `define` `note` `alert` (qyxf-book.cls:211-228; used at qyxf-book-doc.tex:435-453); markers `\exercise{}` `\solve[]` `\analysis[]` (qyxf-book.cls:206-208; used at qyxf-book-doc.tex:510,515,530); colour interface macros `\TitleColor` `\ListColor` `\CaptionColor` `\LinkColor` `\MiscColor` `\Box*` `\Alert*` `\Define*` `\Theorem*` and `\selectcolor` (qyxf-book.cls:83-105,410-424; listed at qyxf-book-doc.tex:203-231); the ctex interface `\ctexset` and `\CTEXthechapter` (qyxf-book.cls:258,259,315).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | qyxf-book-doc.tex:2-8; qyxf-book.cls:39 | `class.qyxf-book` | see Class setting |
| paper, size, sides | qyxf-book-doc.tex:3-6 | `page.class-options` | 10pt, twoside, openany, b5paper |
| page geometry | qyxf-book.cls:231-232 | `page.geometry` | margin=1in |
| head and foot heights | qyxf-book.cls:233-234 | `page.setlength` | `\footskip`=30pt, `\headheight`=15pt |
| language, CJK | qyxf-book.cls:22,33,38,39; qyxf-book-doc.tex:359-394 (documented, not set in the sample) | `lang.cjk` | ctexbook with xeCJK, `CJKmath=true`; `noCJKfont` gives `fontset=none` |
| western text fonts | qyxf-book.cls:37,43-45 | `font.fontspec` | `\setmainfont{XITS}`, `\setsansfont{TeX Gyre Heros}[Scale=0.93]`, fontspec option `no-math`; `xits=false` skips them |
| math font | qyxf-book.cls:46-47 | `font.unicode-math` | `\setmathfont{XITS Math}` |
| symbols and logos | qyxf-book.cls:49,296; qyxf-book-doc.tex:86,105,256 | `font.icons` | `hologo` (`\hologo{XeLaTeX}`, `\hologo{BibTeX}`), `pifont` (`\ding{51}`, `\ding{55}`) |
| font sizes | qyxf-book.cls:259-262,344-347,399 | `font.size-commands` | `\fontsize{2.25em}{1.2ex}` and the like, `\Huge` `\huge` `\LARGE` `\Large` `\small` `\normalsize` |
| math | qyxf-book.cls:42; qyxf-book-doc.tex:143-148,511-526 | `math.amsmath` | `amsmath` loaded; `equation`, `\[ \]`, `\eqref`, `\frac`, `\left \right` |
| inline marks | qyxf-book-doc.tex:36,63,480 | `mark.kernel` | `\emph`, `\textbf`, `\textsc`, `\textit`, `\itshape`, `\bfseries` |
| underline | qyxf-book.cls:52,280 | `mark.ulem` | `ulem[normalem]`, `\uline` inside the footer box |
| footnote mark | qyxf-book.cls:55 | `num.counters` | `\renewcommand{\thefootnote}{\textbf{(\arabic{footnote})}}` |
| footnotes | qyxf-book-doc.tex:39,73,95 | `fn.kernel` | `\footnote` |
| images | qyxf-book.cls:58-59; qyxf-book-doc.tex:19,501 | `fig.graphicx` | `\graphicspath{{./figure/}{./pic/}{./image}}`, `\includegraphics[width=.3\textwidth]`, float `[htbp]`, `\centering` |
| float spacing | qyxf-book.cls:60-61 | `fig.placement` | `\textfloatsep`=6pt plus 2pt minus 4pt, `\intextsep`=6pt plus 2pt minus 2pt |
| tables | qyxf-book.cls:62; qyxf-book-doc.tex:203-231,483-495 | `tbl.tabular` | `table[htbp]`, `\centering\small`, `tabular{llcc}`, nested `tabular[c]{@{}l@{}}` (:262) |
| table rules | qyxf-book.cls:62; qyxf-book-doc.tex:204,212,230,487-493 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| long tables | qyxf-book.cls:62 | `tbl.longtable` | package loaded; the sample does not use it |
| cell parbox | qyxf-book-doc.tex:205,211 | `box.minipage` | `\parbox{5em}{\centering ...}`, `\parbox{7em}{...}` |
| caption text | qyxf-book.cls:68-73; qyxf-book-doc.tex:202,485,502 | `cap.caption`, `cap.kernel` | `\DeclareCaptionFormat{colored}{\small{\bfseries\color{\CaptionColor}#1} #3}`, `\captionsetup{format=colored, skip=1ex}`; `\caption` above tables and figures |
| boxes | qyxf-book.cls:63-65,181-203,220-228; qyxf-book-doc.tex:42-52,132-141,447-453 | `box.tcolorbox` | `tcolorbox[many]`; `\tcbset{enhanced, noparskip, after=\noindent, colback/colframe/coltitle/colbacktitle/coltext from the scheme macros, title filled, fonttitle=\bfseries, arc=0.25em, boxrule=0.5pt, toptitle=0.75em, bottomtitle=0.75em, boxsep=0pt, left/right/top/bottom=1.25em, drop fuzzy shadow, breakable}`; `\newtcolorbox{note}{title={注记}}`, `\newtcolorbox{alert}{title={警告}, Alert* colours}`; `tikz` with `\usetikzlibrary{calc,backgrounds,shadows}` is loaded only as tcolorbox's engine, no picture is drawn |
| colour scheme | qyxf-book.cls:76-178; qyxf-book-doc.tex:156-232 | `color.xcolor` | named schemes as xcolor expressions (`black!75`, `blue!50!cyan`, `cyan!80!olive`, ...), `primary` and `secondary` strings (cls:19-20,77-78); `\selectcolor` refreshes hyperref and tcolorbox colours (cls:410-424) |
| theorem-like statements | qyxf-book.cls:211-219; qyxf-book-doc.tex:435-445 | `thm.class-native`, `thm.kernel`, `box.tcolorbox` | `\newtheorem{theorem}{定理}`, `{lemma}[theorem]{引理}`, `{define}{定义}`; etoolbox `\BeforeBeginEnvironment`/`\AfterEndEnvironment` wrap each in `tcolorbox[colback=\TheoremBackground, colframe=\TheoremFrame, coltext=\TheoremColor]` (`define`: the `\Define*` triple) |
| section markers | qyxf-book.cls:206-208; qyxf-book-doc.tex:118-122,510,515,530 | `mark.kernel`, `color.xcolor`, `sp.lengths` | `\noindent\textbf{\color{\MiscColor}练习 #1}\ `, `\solve[解]`, `\analysis[分析]` (`\emph`); `\noindent` is the per-paragraph form of `\parindent` |
| lists | qyxf-book.cls:295-304; qyxf-book-doc.tex:55-59,456-476 | `list.enumitem`, `list.kernel` | `enumitem[shortlabels]`; `\setlist{nosep, partopsep=0.5ex}`; itemize labels `\ding{228}`/`\ding{111}`/`\ding{109}` coloured `\ListColor`, `left`=0.8em/2.8em/4.8em; enumerate labels `\textbf{\arabic*}.`, `\arabic*.`, `(\arabic*)`; description `style=nextline`, `font=\color{\ListColor}\bfseries` |
| headings | qyxf-book.cls:257,259-265 | `head.titlesec` | `\titleformat{\chapter}[block]{\color{\TitleColor}\centering\bfseries\fontsize{2.25em}{1.2ex}}{\CTEXthechapter}{1em}{}`; `\titleformat*` section 1.75em/1.225ex centred, subsection 1.5em/1.43ex, subsubsection 1.25em/1.4ex, paragraph bold, subparagraph plain, all `\color{\TitleColor}`; `\titlespacing{\chapter}{0pt}{*1}{*4}` |
| heading names and appendix numbers | qyxf-book.cls:258,315 | `head.class-native` | `\ctexset{section={name={\S,}}}`, `\ctexset{appendix={number={\Roman{chapter}}}}` |
| contents entries | qyxf-book.cls:257,266-274 | `toc.titletoc` | `\titlecontents` chapter [24pt], section [20pt], subsection [18pt]; leaders `\titlerule*[8pt]{.}`, `\filright`, `\contentspush` |
| contents depth | qyxf-book.cls:275 | `num.secnumdepth` | `tocdepth`=2 |
| contents title and page flow | qyxf-book-doc.tex:30; qyxf-book.cls:396-407 | `toc.kernel` | `\tableofcontents` redefined: `\pagestyle{empty}`, centred `\normalfont\LARGE\bfseries\contentsname`, `\vskip 3ex`, `\parskip`=0pt, `\@starttoc{toc}`, `\cleardoublepage`, `\pagestyle{fancy}`, `\setcounter{page}{1}`; reduction in Bespoke code |
| page-flow commands | qyxf-book.cls:367,383,404 | `pg.break` | `\newpage`, `\cleardoublepage` |
| page numbers restart | qyxf-book.cls:406 | `pgnum.pagenumbering` | `\setcounter{page}{1}` after the contents |
| running heads and feet | qyxf-book.cls:282-292 | `hf.fancyhdr` | `\fancyhead[EC]{\itshape\nouppercase\leftmark}`, `[OC]` `\rightmark`, `[EL,OR]` and `[ER,OL]` empty; `\fancyfoot[C]{\footerbox}`; `fancypagestyle{plain}` with `\fancyhf{}`, rules 0pt |
| footer box | qyxf-book.cls:278-281 | `hf.fancyhdr`, `mark.ulem`, `sp.manual-space`, `color.xcolor` | page number in `\MiscColor` bold, `\uline{\hphantom{org text}}`, `\\[-\baselineskip]`, then the org text |
| page styles | qyxf-book.cls:366,384,397,405 | `hf.pagestyle-kernel` | `\pagestyle{fancy}`, `\pagestyle{empty}`, `\thispagestyle{empty}` |
| front matter | qyxf-book-doc.tex:10-28; qyxf-book.cls:318-337,348-384 | `front.class-native` | cover page (titlepage, tcolorbox bars with `borderline west`={1mm}, title, subtitle, author, date, `\@cover` slot, org block), then a work-information page (tcolorbox with an `itemize` of title, author, typesetter, date, page count) and an optional licence box |
| cover layout | qyxf-book.cls:349-365 | `front.titlepage-env`, `box.tcolorbox`, `sp.manual-space` | `titlepage`, `center`, `blanker` boxes (`left=20pt`, `top=1ex`, `bottom=1ex`, `no shadow`), `\vfil`; reduction in Bespoke code |
| total pages | qyxf-book.cls:313,376 | `pgnum.lastpage` | `\pageref{LastPage}` |
| links and metadata | qyxf-book.cls:237-254,385-393 | `meta.hyperref` | `unicode`, `breaklinks`, `linktoc=all`, `bookmarksnumbered`, `bookmarksopen`, `pdfborder={0 0 0}`, `linktocpage`, `colorlinks=true` with `\LinkColor`/`\MiscColor`; `pdfauthor` `pdftitle` `pdfsubject` `pdfkeywords={qyxf, book}` `pdfcreator` |
| URLs, links | qyxf-book-doc.tex:39,66,426 | `meta.url` | `\url`, `\href` from hyperref |
| cross-references | qyxf-book-doc.tex:199,202,511,523 | `xref.kernel` | `\label`, `\ref`, `\eqref` |
| verbatim code | qyxf-book-doc.tex:36,133-140,163 | `code.verbatim` | `\verb`, `verbatim` environment inside `tcolorbox` (the manual shows its own source; `listings` is not loaded, doc:406) |
| citations | qyxf-book.cls:307-309; qyxf-book-doc.tex:530 | `bib.natbib` | `natbib[square,numbers]`; `\citenumfont` and `\bibnumfmt` redefined to colour the numbers |
| bibliography list | qyxf-book-doc.tex:537-540 | `bib.thebibliography` | hand-written `thebibliography{99}` with `\bibitem` |
| bibliography in contents | qyxf-book.cls:310 | `toc.etoc` | `\AtBeginEnvironment{thebibliography}{\addcontentsline{toc}{chapter}{\bibname}}`; the same effect as `tocbibind`; reduction in Bespoke code |
| appendix | qyxf-book.cls:314-315 | `num.appendix` | `appendix` package loaded; the sample has no `\appendix` |

## Bespoke code
The class is CTAN-published, so its macros are the class's own vocabulary and not counted as bespoke. The rows below are listed so a re-reading under the zip-local definition needs no new analysis. Scope when read that way: class. None is irreducible.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option layer (`kvoptions`, `\DeclareStringOption`, `\DeclareBoolOption`, `\DeclareVoidOption`) | qyxf-book.cls:14-34 | yes | the options are parameters of `class.qyxf-book`; the six deprecated options only print warnings (cls:25-30) |
| colour-scheme dispatch (`\IfEqCase`, `\providecommand`, `\renewcommand` tables) | qyxf-book.cls:76-178 | yes | a lookup from scheme name to xcolor expressions, resolved when the emitter writes the file: `color.xcolor` values fed to `box.tcolorbox`, `meta.hyperref`, `cap.caption`, `list.enumitem`, `head.titlesec` |
| `\tcbset` defaults and `\selectcolor` | qyxf-book.cls:181-203,410-424 | yes | `box.tcolorbox` keys; `\selectcolor` only refreshes colours already known when emitting |
| theorem wrappers (`\BeforeBeginEnvironment`, `\AfterEndEnvironment`) | qyxf-book.cls:214-219 | yes | `thm.kernel` plus a `box.tcolorbox` wrapper written around each statement in the body |
| markers `\exercise` `\solve` `\analysis` | qyxf-book.cls:206-208 | yes | inline expansion to `\noindent`, `\textbf` or `\emph`, `\color` (`mark.kernel`, `color.xcolor`, `sp.lengths`) |
| `\footerbox` | qyxf-book.cls:278-281 | yes | `hf.fancyhdr` foot field holding `mark.ulem` `\uline{\hphantom{..}}`, `sp.manual-space` `\\[-\baselineskip]`, `color.xcolor` |
| metadata store (`\subtitle`, `\typo`, `\cover`, `\org`, `\footorg`, `\license`, `\gdef`) | qyxf-book.cls:318-337 | yes | strings and one content slot (`\cover`); the emitter fills the values directly |
| `\maketitle` redefinition | qyxf-book.cls:348-384 | yes | `front.titlepage-env` with `box.tcolorbox` (`blanker`, `borderline west`, `left`, `top`, `bottom`, `before skip`, `after skip`, `no shadow`), `sp.manual-space` (`\vfil`), `list.kernel`, `pgnum.lastpage`, `pg.break`, `hf.pagestyle-kernel`; the `\ifdefempty` tests become emission-time choices because the emitter knows whether subtitle, typesetter and licence are set; `\hypersetup{pageanchor}` is `meta.hyperref` |
| `\tableofcontents` redefinition (uses the kernel internals `\@starttoc`, `\@mkboth`) | qyxf-book.cls:396-407 | yes, with a caveat | kernel `\tableofcontents` with `toc.tocloft` title font and skip parameters (`\cfttoctitlefont`, `\cftaftertoctitleskip`), wrapped by `hf.pagestyle-kernel`, `pg.break` (`\cleardoublepage`), `pgnum.pagenumbering`; exact spacing parity is not claimed (nothing compiled) |
| `\AtBeginEnvironment{thebibliography}` toc entry | qyxf-book.cls:310 | yes | `toc.etoc` (`tocbibind`), or the same `\addcontentsline` line printed before `thebibliography` |
| `\AtBeginDocument` metadata | qyxf-book.cls:385-393 | yes | `meta.hyperref` keys (`\hypersetup`) with strings from the document |
| cover font hooks `\titlefont` `\subtitlefont` `\authorfont` `\datefont` | qyxf-book.cls:344-347; qyxf-book-doc.tex:23-24 | yes | font-switch lists (`font.size-commands`, `mark.kernel`), parameters of the class |

Nothing else is defined in the sample's preamble or body: there is no `\newcommand`, `\def`, counter or environment in qyxf-book-doc.tex (it only calls class vocabulary). The sample's one inconsistency: the manual names a `definition` environment (qyxf-book-doc.tex:128) but the class defines `define` (qyxf-book.cls:213), and the sample uses `define` (qyxf-book-doc.tex:435). The `\verb` and `verbatim` examples are documentation text of the manual itself.

## Content-opaque
none (the two included images `figure/qyxf-logo.pdf` at qyxf-book-doc.tex:19 and `figure/qyxf-cover.pdf` at qyxf-book-doc.tex:501 are shipped PDFs, content; no `tikzpicture`, `pgfplots` or `picture` appears in the class or the sample; the manual only mentions Ti$k$Z at qyxf-book-doc.tex:299). Assets: the Western fonts XITS and TeX Gyre Heros ship with TeX Live; the Chinese fonts are chosen by `ctexbook` from the system (qyxf-book-doc.tex:359-394) and are not shipped.

## Lib changes
- New ways proposed: none (considered: `etoolbox` environment hooks, not proposed because every use reduces to a body `box.tcolorbox` wrapper; `kvoptions`, a class option mechanism, parameters of the class way)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
