yes

# 0876-huangyxi-whutmod: whutmod (WHUT summer mathematical-modelling training paper)

- Unverified: read from the source, not compiled.
- Source: Source/0876-huangyxi-whutmod/ (origin: https://codeload.github.com/huangyxi/whutmod/zip/refs/heads/master; licence: not established)
- Kind: report (a contest-style modelling paper: cover page, abstract, contents, numbered sections, appendix code; the manifest hint `misc` is wrong)
- Lib: v6
- Engine: needs XeLaTeX (class guard `\RequireXeTeX` and `\ClassError` for other engines at whutmod.cls:42-47; `\setmainfont` at whutmod.cls:106; ctex over xeCJK; `metalogo` at demo.tex:2)
- Look carried by: zip-local (whutmod.cls is a thin zip-local class over the published `ctexart`; it only loads published packages and re-declares kernel-level sectioning, abstract, cover and bibliography; the sample adds field values only)
- Class origin: zip-local (whutmod.cls says "UNOFFICIAL" at line 2 and is derived from latexstudio/CUMCMThesis at line 3; ctan.org/pkg/whutmod is a 404; the base class `ctexart` is published, CTAN `ctex`, and is not bundled)
- Main file: demo.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (whutmod.cls, 397 lines, read in full; the `ctexart` source is not bundled and was not read)

## Verdict
yes. Every in-scope component maps to a lib way: `\LoadClass{ctexart}` plus published packages (geometry, caption, enumitem, titletoc, listings, booktabs, hyperref...). Every zip-local macro is a `\newcommand` alias, a kernel-level redefinition written with documented kernel commands (`\@startsection`, `\@setfontsize`, `\renewenvironment`, `\list`), or a hand-laid cover page built from kernel boxes, rules, an image and a `tabular`. Nothing computes layout, there is no TikZ/PGF/picture artwork (the cover logo is an included `whut.jpg`), and nothing needs a tool outside TeX. Caveats, none a blocker: the `withoutpreface` branch is broken in the source (the closing `\fi` is commented out, whutmod.cls:245) and only the default path is recovered; the fonts (Times New Roman, Arial, SimKai, SimSun, SimFang) are system fonts the zip does not ship.

## Blockers
none

## Class setting
- Class: `class.ctexart` options: `a4paper,12pt` (whutmod.cls:40); the sample passes none (demo.tex:1), the class runs `\ExecuteOptions{colorprint}` (whutmod.cls:37). The zip-local `whutmod` reduces to `\documentclass[a4paper,12pt]{ctexart}` plus the rows below.
- Class-native vocabulary used: from `ctexart`: `\zihao{..}` (whutmod.cls:226-242, 293, 312), `\chinese{section}` (whutmod.cls:262), `\songti` (whutmod.cls:152, 393), `\heiti` (whutmod.cls:312), `\CJKfamily` and `\setCJKfamilyfont[AutoFakeBold]` (xeCJK, whutmod.cls:108-117), the Chinese caption names. Zip-local (reduced by inlining): `\team` `\tihao` `\membera` `\memberb` `\memberc` `\joba` `\jobb` `\jobc` (demo.tex:3-12), `\keywords` (demo.tex:28). The `ctexart` source was not read; `\zihao`, `\chinese` and the name macros are taken from how the class and sample call them.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | whutmod.cls:40; demo.tex:1 | `class.ctexart` | `a4paper,12pt`; ctex loads xeCJK and Chinese names |
| paper and base size | whutmod.cls:40 | `page.class-options` | a4paper, 12pt |
| page geometry | whutmod.cls:48, 96 | `page.geometry` | top=25mm, bottom=25mm, left=25mm, right=25mm |
| line spacing | whutmod.cls:97 | `sp.linespread` | `\baselinestretch`=1.38 |
| paragraph shape | whutmod.cls:89, 93, 105 | `sp.lengths`, `sp.indentfirst` | `\parindent`=2em; `indentfirst`; `calc` loaded |
| normal size | whutmod.cls:127-131 | `font.size-commands`, `sp.lengths` | `\@setfontsize\normalsize{12.05}{14.45}`; `\abovedisplayskip` 12pt plus3pt minus7pt; `\abovedisplayshortskip` 0pt plus3pt; `\belowdisplayshortskip` 6.5pt plus3.5pt minus3pt |
| Latin fonts | whutmod.cls:106-107 | `font.fontspec` | `\setmainfont{Times New Roman}`, `\setsansfont{Arial}` |
| CJK font families | whutmod.cls:108-123 | `lang.cjk` | `\setCJKfamilyfont{kai}[AutoFakeBold]{simkai.ttf}`, `{song}` SimSun, `{fs}` simfang (or simfang.ttf, else `\songti`); aliases `\kai` `\song` `\fs` by `\providecommand` |
| colours | whutmod.cls:54, 64, 67-69, 228 | `color.xcolor` | dkgreen rgb 0,0.6,0; gray rgb 0.5,0.5,0.5; mauve rgb 0.58,0,0.82; `red` on the cover fields |
| links and PDF | whutmod.cls:65, 94 | `meta.hyperref` | `pdfborder=001` |
| TeX logos | demo.tex:2, 21 | `font.icons` | `metalogo` for `\XeLaTeX` (a logo-by-name package, as `hologo`) |
| cover page (layout) | whutmod.cls:197-246 | `front.titlepage-env`, `front.maketitle` | hand-laid page: `\newpage`, `\null`, `\vskip2ex`, centred block, `\includegraphics[width=12.83cm]{whut.jpg}`, title in `\zihao{2}\fs\textbf`, `\rule{12.83cm}{2pt}`, a two-column `tabular{w{l}{28ex}w{c}{20ex}}` of names and directions, `\vfill`, date `\the\year` `\the\month` `\the\day`; `\title` and `\maketitle` are the entry points (demo.tex:11, 16) |
| cover page style and breaks | whutmod.cls:199, 216, 221, 246 | `hf.pagestyle-kernel`, `pg.break` | `\thispagestyle{empty}`, `\newpage` |
| cover spacing, rule, marks | whutmod.cls:220, 225-241 | `sp.manual-space`, `sp.rule`, `mark.kernel`, `sp.ragged` | `\vskip` 2ex 7ex 5ex 14ex, `\\[-30pt]`, `\vfill`, `\rule` 12.83cm x 2pt, `\textbf`, `center` |
| cover fields | whutmod.cls:17-29, 345-366; demo.tex:3-12 | `front.titlepage-env` | team, topic number, three member names and jobs are strings printed in `\color{red}` or plain; year, month, day default to `\the\year` etc. |
| abstract | whutmod.cls:286-297; demo.tex:18-32 | `abs.kernel`, `hf.pagestyle-kernel`, `pgnum.pagenumbering`, `pg.break` | `\thispagestyle{empty}`, `\setcounter{page}{0}`, centred `\zihao{4}\bfseries\abstractname`, `quotation` body, closing `\newpage\null`; the `\if@twocolumn` branch is not taken (one column) |
| abstract body list | whutmod.cls:298-305 | `quote.kernel`, `sp.lengths` | `\list{}` with `\listparindent` 2em, `\itemindent`=`\listparindent`, `\rightmargin` 0, `\leftmargin` 0, `\parsep` 0pt plus1pt |
| keywords | whutmod.cls:307-313; demo.tex:28-31 | `abs.keywords` | `\par\vskip1ex`, `\noindent\zihao{-4}\heiti 关键词：` then `\bf` keywords |
| contents | whutmod.cls:391-396; demo.tex:34 | `toc.titletoc`, `toc.kernel` | `\titlecontents{section}[0pt]{\vspace{2mm}\bfseries}{\thecontentslabel\hskip.5em}{}{\titlerule*[0.5pc]{.}\contentspage}`; subsection `[30pt]{\songti}`; subsubsection `[55pt]{\songti}` |
| headings | whutmod.cls:265-284 | `head.kernel` | `\@startsection` with section {1}{\z@}{-3.5ex plus-1ex minus-.2ex}{2.3ex plus.2ex}{\centering\normalfont\Large\bfseries}; subsection {2} {-3.25ex ...}{1.5ex plus.2ex}{\normalfont\large\bfseries}; subsubsection {3} normalsize bold; paragraph {4} run-in -1em; subparagraph {5} indent `\parindent` |
| heading numbers | whutmod.cls:261-264 | `num.counters` | `\@seccntformat` = number and a space; `\thesection`=`\chinese{section}、`; `\thesubsection`=`\arabic{section}\thinspace.\thinspace\arabic{subsection}`; `\thesubsubsection`=`\thesubsection` with a third `.` part |
| numbering depth | whutmod.cls:260 | `num.secnumdepth` | secnumdepth=3 |
| appendix | whutmod.cls:315-323; demo.tex:105 | `num.appendix`, `num.counters` | kernel `\appendix` then `\thesection`=`\appendixname\@Alph\c@section`, `\thesubsection`=`\Alph{section}.\@arabic\c@subsection`, `\thesubsubsection` likewise |
| Chinese names | whutmod.cls:250-258, 368-389 | `lang.cjk` | contents 目录, list of figures 插图清单, list of tables 附表清单, references 参考文献, index 索引, figure 图, table 表, appendix 附录, abstract 摘要, keywords 关键词 (kernel string macros `\renewcommand`) |
| lists | whutmod.cls:91, 167-176; demo.tex:52-57 | `list.enumitem`, `list.kernel` | `\setlist{topsep=0.3em, partopsep=0pt, itemsep=0ex plus 0.1ex, parsep=0pt, leftmargin=1.5em, rightmargin=0em, labelsep=0.5em, labelwidth=2em}`; `itemize` |
| theorem-like | whutmod.cls:132-143, 368-379 | `thm.kernel` | 12 `\newtheorem` (definition, theorem, lemma, corollary, assumption, conjecture, axiom, principle, problem, example, proof, solution) with Chinese names; each counts alone; not used in the sample |
| graphics | whutmod.cls:55, 149-151; demo.tex:78-82 | `fig.graphicx` | `\DeclareGraphicsExtensions{.pdf,.eps,.jpg,.png}`; `\graphicspath` of figures/ figure/ pictures/ picture/ pic/ pics/ image/ images/; `figure[!h]`, `\includegraphics[width=.6\textwidth]` |
| float placement | whutmod.cls:145-148 | `fig.placement` | `\textfraction` 0.05, `\topfraction` 0.9, `\bottomfraction` 0.8, `\floatpagefraction` 0.85 |
| captions | whutmod.cls:90, 152-165; demo.tex:81, 87 | `cap.caption`, `cap.kernel` | `\DeclareCaptionFont{song}{\songti}`, `{minusfour}{\zihao{-4}}`; figure and table: `format=hang, labelsep=quad, font={song,minusfour,bf}`, `position=bottom` (figure), `position=top` (table) |
| tables | whutmod.cls:56-61, 98-104; demo.tex:60-70, 86-97 | `tbl.tabular`, `tbl.booktabs`, `tbl.longtable`, `tbl.multirow` | `array`; `\arraystretch`=1.38 inside every `tabular`; `\hline` table; `\toprule[1.5pt]` `\midrule[1pt]` `\bottomrule[1.5pt]`; `longtable`, `multirow`, `bigstrut`, `bigdelim` loaded and not called (considered: they stay in `tbl.multirow`, the table-cell package family) |
| fixed-width cell | demo.tex:63 | `sp.manual-space` | `\makebox[0.3\textwidth][c]{..}` and `[0.4\textwidth][c]` (a kernel box, as `\raisebox`) |
| cross-references | demo.tex:75, 85, 87 | `xref.kernel` | `\label{tab001}` (87) `\ref{tab001}` (85) `\cite{bib:one}` (75) |
| code listings | whutmod.cls:63, 70-88, 179-191; demo.tex:108, 128 | `code.listings` | `\lstset{frame=tb, aboveskip=3mm, belowskip=3mm, showstringspaces=false, columns=flexible, framerule=1pt, rulecolor=\color{gray!35}, backgroundcolor=\color{gray!5}, basicstyle={\small\ttfamily}, numbers=none, keywordstyle=\color{blue}, commentstyle=\color{dkgreen}, stringstyle=\color{mauve}, breaklines, breakatwhitespace, tabsize=3}`; `\lstnewenvironment{tcode}` with `language=TeX, frame=single, escapechar=`, frameround=tttt`; `lstlisting[language=matlab]` and `[language=c]` |
| verbatim in arguments | whutmod.cls:62 | `code.verbatim` | `cprotect` loaded, never called (load-only, `\cprotect` lets `\verb` sit in an argument; considered a separate way, decided against) |
| bibliography | whutmod.cls:325-343; demo.tex:100-103 | `bib.thebibliography`, `sp.penalties`, `sp.hyphenat` | same body as the kernel article `thebibliography`: `\section*{\refname}`, `\list{\@biblabel{..}}`, `\sloppy`, `\clubpenalty4000`, `\widowpenalty4000`; `thebibliography{9}` |
| maths packages | whutmod.cls:49-52 | `math.amsmath`, `math.amssymb`, `math.bm` | amsmath, amsfonts, amssymb, bm loaded; sample has inline maths only (demo.tex:45) |
| underline | whutmod.cls:92 | `mark.ulem` | `ulem` load-only |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\maketitle` and `\@maketitle` (hand-laid cover, one-shot resets) | whutmod.cls:197-246 | yes | the `\global\let` lines (203-213) only make `\maketitle` run once and have no layout effect; the page is `front.titlepage-env` from kernel boxes, `sp.rule`, `fig.graphicx`, `tbl.tabular` with array's `w` column, `color.xcolor`; date as `\the\year` etc. |
| token macros and field commands `\team` `\tihao` `\membera`..`\jobc` `\yearinput` `\monthinput` `\dayinput` | whutmod.cls:17-29, 345-366 | yes | `\newcommand`/`\renewcommand` string stores; inline the strings into the cover page |
| `withoutpreface` switch `\if@mcm@preface` | whutmod.cls:14, 34, 217 | yes | boolean: the emitter emits the cover or omits `\maketitle`; the `\fi` is commented out at line 245, so the `false` path swallows following text and the `true` path leaves an unclosed `\if`; only the default path is recovered |
| `bwprint` and `colorprint` options | whutmod.cls:13, 32-33, 37 | yes | the flag `\if@mcm@bwprint` is set and never read (grep finds no other use); no effect, omit |
| tabular wrapper (`\renewenvironment{tabular}` with `\arraystretch`) | whutmod.cls:98-104 | yes | `\renewcommand{\arraystretch}{1.38}` (or the same wrapper), `tbl.tabular` |
| section commands, `\@seccntformat`, `\the...` | whutmod.cls:261-284 | yes | `head.kernel` with the documented `\@startsection` arguments (or `head.titlesec` `\titleformat` and `\titlespacing` with the same values), `num.counters` |
| `\normalsize` redefinition | whutmod.cls:127-131 | yes | `\@setfontsize` is the kernel size command (as in `size12.clo`); `font.size-commands` and `sp.lengths` |
| `abstract` and `quotation` environments | whutmod.cls:286-305 | yes | kernel `\list` with lengths, `\thispagestyle`, `\setcounter{page}`, `\newpage`; `\if@twocolumn` is the kernel switch and the one-column branch is used |
| `\keywords` | whutmod.cls:307-313 | yes | `\newcommand` alias of `\par\vskip1ex{\noindent\zihao{-4}\heiti 关键词：}~{\bf ..}` |
| `\appendix` wrapper (`\let\@oldappendix`) | whutmod.cls:315-323 | yes | kernel `\appendix` followed by three `\gdef\the...` |
| `thebibliography` | whutmod.cls:325-343 | yes | a copy of the kernel article definition; emit `bib.thebibliography` with the class default |
| font fallback `\IfFontExistsTF` and `\providecommand` aliases | whutmod.cls:108-123 | yes | fontspec conditional (published); the emitter fixes the branch for the fonts present; `\ClassWarning` is not output |
| caption-name macros `\mcm@cap@*` | whutmod.cls:250-258, 368-389 | yes | string `\newcommand`s inlined into `\renewcommand\contentsname` etc. and into `\newtheorem` titles |
| `{\fs}` font-load line | whutmod.cls:195 | yes | a group that selects the `fs` CJK family, no printed output; emit it or omit it |
| `tcode` environment | whutmod.cls:179-191 | yes | `\lstnewenvironment` with `listings` keys only (`code.listings`) |
| engine guard (`ifxetex`, `\RequireXeTeX`, `\ClassError`) | whutmod.cls:42-47 | yes | no printed effect; the emitter tags the output XeLaTeX |
| `\DeclareOption*` pass-through to `article` | whutmod.cls:35 | yes | option routing only; no option is used by the sample |

## Content-opaque
- figure artwork `1.png` (demo.tex:80); listing code text (demo.tex:109-125, 129-150); the cover logo `whut.jpg` (whutmod.cls:224) is an included image, shipped in the zip, not drawn artwork.

## Lib changes
- New ways proposed: none. Considered: a separate way for `cprotect` (decided against: `code.verbatim`, a verbatim-in-argument helper, load-only here); `bigstrut` and `bigdelim` (kept in `tbl.multirow`); `metalogo` (kept in `font.icons`, a logo-by-name package).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
