no

# 0745-sjtu-exam-paper: SJTU Exam Paper

- Unverified: read from the source, not compiled.
- Source: Source/0745-sjtu-exam-paper/ (origin: https://latextemplates.com/downloads/sjtu-exam-paper.zip, upstream https://github.com/Thysrael/SJTUExamLaTeX per README.md:43; licence: MIT, LICENSE:1-3, "unofficial" per README.md:3)
- Kind: exam
- Lib: v5
- Engine: needs XeLaTeX (`fontspec` `\setmainfont` main.tex:39, xeCJK commands `\setCJKmainfont` main.tex:41 via `ctex`; README.md:22-23 says it will not compile under pdflatex)
- Look carried by: preamble (a single main.tex over kernel `article`; no zip-local class or style; the look is the preamble at main.tex:1-165 plus the body wrappers)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
no. Nearly every component is a published package with declarative settings (article, geometry, ctex/xeCJK, fontspec, fancyhdr, titlesec, enumitem, listings, tabularx, tabularray, afterpage), and all of that reduces to lib ways. Two preamble constructs are hand-rolled TeX conditionals that decide what is printed: the `\ifshowans` switch with the `answer` environment (show the answer in red or print a blank strut) and the compile-date academic-year and semester macros (`\ifnum\month<10`, `\the\year`, `\numexpr`). The rubric lists "hand-rolled counters and conditionals that drive what is printed" as irreducible, and no lib way covers a show/hide answer toggle or a date-derived semester, so the zip is not fully recoverable from the lib.

## Blockers
- `BESPOKE/preamble` answer-key switch and `answer` environment: `\newif\ifshowans` with `\showansfalse`, and `\NewEnviron{answer}` branching on `\ifshowans` (main.tex:68-70, 153-165; 27 `\begin{answer}` uses, first at main.tex:222)
- `BESPOKE/preamble` academic-year and semester computed from the compile date: `\currentsemester` with `\ifnum\month<10`, `\startyear` as `\the\year`, `\nextyear` as `\the\numexpr\startyear+1\relax` (main.tex:51-57, 62-64; printed at main.tex:172)

## Class setting
- Class: `class.article` options: `a4paper`, `12pt` (main.tex:1). Kernel class, not bundled in the zip, source not read.
- Class-native vocabulary used: `center` environment, `\section` `\subsection` `\subsubsection` (restyled by titlesec), `table`, `figure`, `tabular`, `itemize`, `\caption`, `\label`; no `\maketitle`, no `abstract`, no `\title` `\author`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | a4paper, 12pt |
| paper and base size | main.tex:1 | `page.class-options` | a4paper, 12pt |
| page geometry | main.tex:5 | `page.geometry` | margin=0.79in |
| CJK support | main.tex:4 | `lang.cjk` | `ctex` options UTF8, fontset=none (ctex's font detection off, fonts chosen by hand) |
| Latin text and mono fonts | main.tex:39-40 | `font.fontspec` | `\setmainfont{texgyretermes}[Extension=.otf,UprightFont=*-regular,BoldFont=*-bold,ItalicFont=*-italic,BoldItalicFont=*-bolditalic]`, `\setmonofont{DejaVuSansMono}[Extension=.ttf]` (loaded by file name; README.md:25-33 says upstream used Times New Roman, Consolas, SimSun, SimHei, KaiTi) |
| CJK main and sans fonts | main.tex:41-42 | `lang.cjk` | `\setCJKmainfont{FandolSong}[Extension=.otf,UprightFont=*-Regular,BoldFont=FandolSong-Bold]`, `\setCJKsansfont{FandolHei}[...]` |
| CJK family switches | main.tex:45-48 | `lang.cjk` | `\setCJKfamilyfont{zhkai}{FandolKai}`, `{zhhei}{FandolHei}`; aliases `\kaishu` `\heiti` = `\CJKfamily{zhkai}` `\CJKfamily{zhhei}` |
| Chinese font sizes | main.tex:171-174, 187, 197 | `lang.cjk` | ctex `\zihao{3}` `\zihao{4}` `\zihao{5}` |
| title block (hand-laid) | main.tex:170-179 | `front.titlepage-env` | no `\maketitle`; lines of school, paper type, academic year and semester, then a fields table, all hand-set |
| title centring | main.tex:170-179 | `sp.ragged` | kernel `center` environment |
| blank fill-in fields | main.tex:171-177 | `mark.ulem` | kernel `\underline{...}` around `\ ` spaces and `\hspace{0.15 \textwidth}` / `0.2` (no `ulem` package loaded) |
| manual spacing | main.tex:173, 177, 188-193 | `sp.manual-space` | `\vspace{0.5cm}`, `\vspace{1.8em}`, `\vspace{2.5em}`, `\vspace{0.2em}`, `\hspace{2em}`, `\hfill`, `\underline{\makebox[0.43 \textwidth][l]{\hfill \coursename \hfill}}`, `\\` at main.tex:483 |
| title fields table | main.tex:11, 175-178 | `tbl.tabularx` | `{XXX}`, width 0.9 `\textwidth`, `\multicolumn{2}{l}{...}` (kernel, `tbl.tabular`) |
| table row merge | main.tex:10 | `tbl.multirow` | package loaded, no `\multirow` call in the sample |
| header and footer | main.tex:7, 73-84 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\renewcommand{\headrulewidth}{0.4pt}`, `\fancyfoot[C]{\footnotesize ...}` with text 卷 / 第 页 / 共 页 and `\underline` around `\papertype`, `\thepage`, `\pageref{LastPage}` |
| header rule | main.tex:77 | `sp.rule` | `\renewcommand{\headrule}{\hrule width\textwidth height\headrulewidth}` (fancyhdr's own hook, bare `\hrule`) |
| page X of Y | main.tex:8, 83, 620 | `pgnum.lastpage` | `lastpage` package, `\pageref{LastPage}` in the footer |
| labels and page refs | main.tex:83, 620 | `xref.kernel` | `\pageref{LastPage}`, manual `\label{LastPage}` before `\end{document}` |
| section heading | main.tex:87-92, 112 | `head.titlesec` | `\titleformat{\section}{\normalfont\Large\bfseries\heiti}{\thesection、}{0pt}{}`, `\titlespacing{\section}{0em}{1em}{0pt}`; titlesec loaded twice, first with `compact` (main.tex:2, 14) |
| section number as Chinese numeral | main.tex:87 | `num.counters` | `\renewcommand{\thesection}{\chinese{section}}` (`\chinese` is ctex's counter formatter, `lang.cjk`) |
| subsection heading (run-in) | main.tex:95-100, 113 | `head.titlesec` | `\titleformat{\subsection}[runin]{\normalfont\large\bfseries}{\thesubsection.\ }{0pt}{}`, `\titlespacing{\subsection}{0pt}{0.1em}{0.5em}` |
| subsubsection heading (run-in) | main.tex:104-109, 114 | `head.titlesec` | `[runin]`, `{\normalfont\bfseries}`, `{\thesubsubsection)\ }`, `\titlespacing{\subsubsection}{1em}{0.1em}{0.5em}` |
| subsection and subsubsection numbers | main.tex:95, 104 | `num.counters` | `\renewcommand{\thesubsection}{\arabic{subsection}}`, same for `subsubsection` |
| paragraph spacing | main.tex:117 | `sp.lengths` | `\setlength{\parskip}{0.5em}` |
| first-line indent | main.tex:15 | `sp.indentfirst` | `indentfirst`, no options |
| list layout | main.tex:16, 120-132 | `list.enumitem` | `\setlist[itemize]` and `\setlist[enumerate]`: itemsep=0.20em, parsep=0em, topsep=0.20em, partopsep=0.20em |
| lists in body | main.tex:480-485, 592-596, 600-604, 608-614 | `list.kernel` | `itemize` only (no `enumerate` in the body) |
| code listings | main.tex:17, 135-147, 443-472 | `code.listings` | `\lstset{basicstyle=\small\ttfamily, numbers=left, breaklines=true, extendedchars=true, frame=single, framesep=1pt, float, linewidth=0.8\linewidth, framexleftmargin=0.5em, framexrightmargin=0.5em, lineskip=0.1em}`, body `lstlisting` (also 520-530, 557-586) |
| inline code | main.tex:413, 421, 490, 602 | `code.verbatim` | kernel `\verb\|...\|` |
| listing container | main.tex:440-474, 517-532, 554-588 | `tbl.tabular` | `table[htb]` float, `\centering`, one-cell `tabular{c}` holding the listing, no caption |
| figure | main.tex:18, 434-438 | `fig.graphicx` | `figure[!htb]`, `\centering`, `\includegraphics[width=0.7\textwidth]{img/simt.png}` |
| figure caption | main.tex:437 | `cap.kernel` | kernel `\caption{CUDA SIMT}` (no `caption` package) |
| commitment and score block on page 2 | main.tex:12, 183-210 | `pg.afterpage` | `\afterpage{...}` with `\color{black}`, `\noindent` |
| side-by-side blocks | main.tex:186-208 | `box.minipage` | `minipage` widths 0.22 `\textwidth` and 0.73 `\textwidth` joined by `\hfill` |
| score table | main.tex:13, 198-207 | `tbl.nicematrix` | `tabularray` `tblr` with `colspec = {\|X[3,l]\|X[c]\|... (9 centred X)\|}`, `rows = {ht=9mm}`, `hlines`, `vlines`; row labels 题号 得分 批阅人 |
| colour | main.tex:19, 156, 184 | `color.xcolor` | `\textcolor{red}`, `\color{black}` |
| math | main.tex:6, 239 | `math.amsmath` | package loaded; only inline `$2^{x}$` in the body |
| math symbols | main.tex:6 | `math.amssymb` | package loaded, no symbol call seen |
| font sizes | main.tex:80, 89, 97, 136, 611 | `font.size-commands` | `\footnotesize`, `\Large`, `\large`, `\small` (the ctex `\zihao` sizes are in the `lang.cjk` row above) |
| font switches | main.tex:89, 97, 106, 189 | `mark.kernel` | `\normalfont`, `\bfseries`, `\textbf`, `\ttfamily` |
| filler text | main.tex:21, 234 | `draft.todo` | `lipsum`, `\lipsum[3]` at 25 lines (filler content) |
| answer-key environment | main.tex:68-70, 153-165 | none (BESPOKE) | `\newif\ifshowans`, `\NewEnviron{answer}`; shown: `\par\textcolor{red}{\BODY}\par`; hidden: `\par\noindent\rule{0pt}{0.5em}\par` |
| academic year and semester | main.tex:51-57, 62-64, 172 | none (BESPOKE) | `\ifnum\month<10 1 \else 2 \fi`, `\the\year`, `\the\numexpr\startyear+1\relax` |
| marks per question | main.tex:150 | none needed (alias) | `\newcommand{\score}[1]{(#1')}`, a plain text wrapper used in headings and bodies (reducible alias, see Bespoke code) |
| load-only package, no call | main.tex:9 | none (considered: `xifthen`) | no `\ifthenelse` anywhere; no printed effect |
| abstract, contents, bibliography, index, theorems, footnotes, hyperref | none present | none | not in the sample or preamble |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newif\ifshowans`, `\showansfalse`, `answer` via `\NewEnviron` | main.tex:68-70, 153-165 | no | A hand-rolled conditional chooses what is printed (answer body in red vs a blank strut). `environ` (ctan.org/pkg/environ: "a new interface for creating environments", `\NewEnviron`) defines an environment from code, so it fails W2 as `\newenvironment` does. Frozen at `\showansfalse` it would be `\par\noindent\rule{0pt}{0.5em}\par` (`sp.rule`) with the body dropped, but then the switch and the answer-key mode, which README.md:35-38 names as a feature, are gone. No lib way toggles shown/hidden answers (`exam.questions` is question environments from a package, not used here). |
| `\currentsemester`, `\startyear`, `\nextyear`, `\semester` | main.tex:51-57, 62-64 | no | TeX conditional and arithmetic on `\month` and `\year` computing printed text from the compile date. `front.datetime` formats a date, it does not compute a semester. |
| `\school`, `\papertype`, `\coursename` | main.tex:60, 61, 65 | yes | string macros; inline the text (content) |
| `\score` | main.tex:150 | yes | inline `(#1')` |
| `\kaishu`, `\heiti` | main.tex:46, 48 | yes | `\CJKfamily{zhkai}` and `\CJKfamily{zhhei}` after `\setCJKfamilyfont` (`lang.cjk`) |
| `\renewcommand{\headrule}`, `\headrulewidth` | main.tex:76-77 | yes | `hf.fancyhdr` parameters; bare `\hrule` (`sp.rule`) |
| `\renewcommand{\thesection}`, `\thesubsection`, `\thesubsubsection` | main.tex:87, 95, 104 | yes | `num.counters` with ctex `\chinese` and `\arabic` |
| `\titleformat`, `\titlespacing`, `\setlist`, `\lstset` | main.tex:88-114, 120-147 | yes | declarations of `head.titlesec`, `list.enumitem`, `code.listings` |

## Content-opaque
none (the image `img/simt.png`, main.tex:436, is a shipped asset inside a `fig.graphicx` figure; the listings at main.tex:443-472, 520-530, 557-586 are code text)

## Lib changes
- New ways proposed: none. Considered and not proposed: `environ` (definition command, fails W2), `comment`, `etoolbox` toggles (neither reproduces the red-or-blank-strut alternation without a hand-written conditional); `xifthen` (load-only, never called).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes: missing assets, not shipped in the zip: TeX Gyre Termes OTF, DejaVu Sans Mono TTF and the Fandol Song/Hei/Kai OTF families (loaded by file name from TeX Live, main.tex:39-48). Sample quirks, not tested: `\label{LastPage}` at main.tex:620 is set by hand although `lastpage` is loaded (main.tex:8); `\lstset` has a doubled comma at main.tex:136; README.md:25-33 records that the font block was patched from upstream.
