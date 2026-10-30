yes

# 0681-arxiv-preprint-style: arXiv Preprint Style (arxiv.sty over article)

- Unverified: read from the source, not compiled.
- Source: Source/0681-arxiv-preprint-style/ (origin: https://latextemplates.com/downloads/arxiv-style.zip; licence: MIT)
- Kind: journal
- Lib: v5
- Engine: pdfLaTeX-compatible
- Look carried by: zip-local (arxiv.sty:1-262 holds the whole look; main.tex only loads packages and fills title, authors, abstract, keywords)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
yes. The class is the unmodified kernel `article` (main.tex:12). The look comes from the zip-local style `arxiv.sty`, which is not a CTAN package (ctan.org/pkg/arxiv returns 404; main.tex:3-5 says the same), so it is zip-local and had to be reduced. Everything in it is a composition of kernel commands and published packages (`geometry`, `fancyhdr`, `\@startsection` calls, length assignments, `\@setfontsize`, rules, `tabular`); there is no output routine, no hand-rolled counter, no drawing, and no tool outside TeX (BibTeX with `unsrtnat` is `bib.bibtex-bst`). The two weakest points are the redefined `\@maketitle` (arxiv.sty:216-239) and the redefined `table` environment (arxiv.sty:128-132); both reduce as written under "Bespoke code". Nothing was compiled, so only the reductions are claimed, not equal output.

## Blockers
none

## Class setting
- Class: `class.article` options: none (main.tex:12); published class from the TeX distribution, not in the zip, source not read. `arxiv.sty` is a style loaded on top of it (main.tex:16), not a class.
- Class-native vocabulary used: `\title` `\author` `\maketitle` (main.tex:25-40), `abstract` environment (42-45), `\section` (49), `table` float with `\caption` `\label` (56-68), `\bibliography` (77). Zip-local additions the sample calls: `\And` (main.tex:32), `\keywords` with `\and` (main.tex:47).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:12 | `class.article` | no options |
| encodings | main.tex:14-15 | `font.fontenc-t1` | fontenc `T1`, inputenc `utf8` |
| text families | arxiv.sty:6-7 | `font.family-default` | `\rmdefault`=ptm, `\sfdefault`=phv; maths and `\ttdefault` untouched |
| page geometry | arxiv.sty:10-20 | `page.geometry` | load `verbose=true,letterpaper`; `\newgeometry` in `\AtBeginDocument`: textheight=9in, textwidth=6.5in, top=1in, headheight=14pt, headsep=25pt, footskip=30pt |
| page flow | arxiv.sty:24 | `pg.flush` | `\flushbottom` |
| widows and clubs | arxiv.sty:22-23 | `sp.penalties` | `\widowpenalty`=10000, `\clubpenalty`=10000 |
| line breaking | arxiv.sty:25 | `sp.hyphenat` | `\sloppy` |
| microtype | main.tex:20 | `sp.microtype` | defaults |
| running head and foot | arxiv.sty:33-40 | `hf.fancyhdr` | `\fancyhf{}`, `\pagestyle{fancy}`, `\headrulewidth`=0.4pt, `\fancyheadoffset{0pt}`, `\rhead` "A Preprint" in `\scshape\footnotesize`, `\chead` the title, `\cfoot{\thepage}` |
| first page style | arxiv.sty:193 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` inside `\maketitle` |
| head field fonts | arxiv.sty:38 | `mark.kernel` | `\scshape`, with `\footnotesize` |
| size commands | arxiv.sty:50-72 | `font.size-commands` | `\@setfontsize` pairs: normalsize `\@xpt`/`\@xipt`, small and footnotesize `\@ixpt`/`\@xpt`, scriptsize `\@viipt`/`\@viiipt`, tiny `\@vipt`/`\@viipt`, large `\@xiipt`/14, Large `\@xivpt`/16, LARGE `\@xviipt`/20, huge `\@xxpt`/23, Huge `\@xxvpt`/28; `\normalsize` called once at 57 |
| display skips | arxiv.sty:52-55, 60-63 | `sp.lengths` | abovedisplayskip 7pt plus 2pt minus 5pt (normal), 6pt plus 1.5pt minus 4pt (small); below-short 4pt plus 3pt minus 3pt and 3pt plus 2pt minus 2pt |
| paragraph shape | arxiv.sty:141-142 | `sp.lengths` | `\parindent`=0, `\parskip`=5.5pt |
| headings | arxiv.sty:75-109; main.tex:49, 52, 70, 73 | `head.kernel` | `\@startsection` calls, indent `\z@`: section (level 1) before -2.0ex plus -0.5ex minus -0.2ex, after 1.5ex plus 0.3ex minus 0.2ex, `\large\bf\raggedright`; subsection (2) -1.8ex.., 0.8ex plus 0.2ex, `\normalsize\bf\raggedright`; subsubsection (3) -1.5ex.., 0.5ex plus 0.2ex; paragraph (4) and subparagraph (5) 1.5ex plus 0.5ex minus 0.2ex, after -1em (run-in), `\normalsize\bf`. Numbering is article's own (not changed). Same effect through `head.titlesec` |
| stub heading | arxiv.sty:110-113 | `sp.manual-space` | `\subsubsubsection` = `\vskip5pt` and an empty group; sample does not call it |
| title block | arxiv.sty:180-239; main.tex:25, 40 | `front.maketitle`, `front.titling` | `\title`, `\author`, `\maketitle` kernel; look by `\@maketitle` (reduction in Bespoke code) |
| title rules and gaps | arxiv.sty:203-213, 221, 227 | `sp.rule`, `sp.manual-space` | `\hrule height 2pt` top and bottom; vskips 0.1in, 0.25in, 0.29in, 0.09in, 0.1in, each bar minus `\parskip` |
| title face | arxiv.sty:223-226 | `font.size-commands`, `mark.kernel` | `\centering`, `\LARGE\sc` title, `\textsc{\undertitle}` ("A Preprint", arxiv.sty:30) |
| authors | arxiv.sty:228-236; main.tex:27-37 | `tbl.tabular`, `sp.manual-space` | one `tabular[t]{c}` per author with `\bf\rule{\z@}{24\p@}`; `\And` (main.tex:32) = `\end{tabular}\hfil\linebreak[0]\hfil\begin{tabular}[t]{c}...`; `\AND` same with `\linebreak[4]` |
| date | arxiv.sty:237 | `front.maketitle` | `\vskip 0.4in minus 0.1in`, `\center{\@date}`, `\vskip 0.2in`; sample sets no `\date`, so `\today` |
| title footnotes | arxiv.sty:184-192, 195, 198-199 | `front.thanks`, `num.counters`, `fn.kernel` | in a group: `\thefootnote`=`\fnsymbol{footnote}`; `\@makefntext` indent 1em, mark in a 1.8em right-aligned box; `\@thanks`; the sample has no `\thanks` |
| footnote layout | arxiv.sty:135-138 | `fn.kernel`, `sp.lengths`, `sp.rule`, `num.counters` | `\footnotesep`=6.65pt, `\skip\footins`=9pt plus 4pt minus 2pt, `\footnoterule`=`\kern-3pt\hrule width 12pc\kern 2.6pt`, `\setcounter{footnote}{0}` |
| abstract | arxiv.sty:252-260; main.tex:42-45 | `abs.kernel`, `quote.kernel`, `sp.ragged` | `abstract` redefined: `\centerline{\large\bfseries\scshape Abstract}` then a `quote` environment (side margins from `\leftmargini`=3pc) |
| keywords | arxiv.sty:44-47; main.tex:47 | `abs.keywords` | label `{\bfseries\emph{Keywords}}`, `\par\addvspace\medskipamount`, `\rightskip=0pt plus1cm`, `\noindent`, `\enspace`, separator `$\cdot$` for `\and` |
| list lengths | arxiv.sty:145-154 | `sp.lengths`, `list.kernel` | topsep 4pt plus 1pt minus 2pt, partopsep 1pt plus 0.5pt minus 0.5pt, itemsep and parsep 2pt plus 1pt minus 0.5pt; leftmargin(i)=3pc, ii=2em, iii=1.5em, iv=1em, v=0.5em |
| list level hooks | arxiv.sty:155-177 | `sp.lengths`, `list.kernel` | `\@listi`..`\@listvi`: leftmargin from the level margin (level i only that), levels ii to vi also labelwidth=margin minus labelsep; levels ii and iii reset topsep, parsep, itemsep (ii 2pt/1pt/=parsep; iii 1pt/0/=topsep). Same effect through `list.enumitem` `\setlist` per level |
| float placement | arxiv.sty:116-119; main.tex:56 | `fig.placement` | topfraction 0.85, bottomfraction 0.4, textfraction 0.1, floatpagefraction 0.7; table placement `[htbp]` |
| caption skips | arxiv.sty:121-125 | `cap.kernel` | `\abovecaptionskip`=7pt, `\belowcaptionskip`=0pt |
| table float | arxiv.sty:128-132; main.tex:56-68 | `cap.kernel`, `tbl.tabular` | `table` swaps the two skips (above 0pt, below 7pt); caption above the tabular (main.tex:57), `\centering` (59), `tabular{lrr}` (60) |
| table rules | main.tex:18, 61, 63, 66 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| table alignment | main.tex:59 | `sp.ragged` | `\centering` |
| cross-references | main.tex:53, 58, 71 | `xref.kernel` | `\label{sec:method}`, `\label{tab:example}`, `Table~\ref{tab:example}` |
| hyperlinks | main.tex:17 | `meta.hyperref` | no options, loaded after `arxiv` |
| symbols | main.tex:19 | `math.amssymb` | `amsfonts` |
| images | main.tex:21 | `fig.graphicx` | loaded; the sample has no figure |
| DOI links | main.tex:23 | `meta.url` | `doi` (CTAN, Heiko Oberdiek, LPPL; one command `\doi{}`), loaded only; `\doi` is never called in the sample |
| citations | main.tex:22, 50 | `bib.natbib` | no options; `\citep{knuth1984texbook}` |
| bibliography | main.tex:76-77; references.bib:1-8 | `bib.bibtex-bst` | `\bibliographystyle{unsrtnat}`, `\bibliography{references}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\headeright` `\undertitle` `\shorttitle` | arxiv.sty:29-31 | yes | string aliases: write "A Preprint" into the `\rhead` field and the title block, the title text into `\chead` (`hf.fancyhdr`) |
| `\keywordname` `\keywords` `\and` | arxiv.sty:44-47 | yes | inline expansion: `\par\addvspace\medskipamount{\rightskip=0pt plus1cm\noindent{\bfseries\emph{Keywords}}\enspace K1~$\cdot$ K2~$\cdot$ K3\par}`; `\unskip\nobreak\ ` before `$\cdot$` is the tie `~` (`sp.manual-space`); `\ifhmode` only guards `\unskip`, it selects no printed content |
| size renewals | arxiv.sty:50-72 | yes | `\renewcommand{\normalsize}` etc. with `\@setfontsize` plus display-skip assignments: `font.size-commands` and `sp.lengths`, a preamble block under `\makeatletter` |
| section commands | arxiv.sty:75-109 | yes | `\@startsection{name}{level}{indent}{beforeskip}{afterskip}{style}` calls with the values in the map: `head.kernel` (or `\titleformat` and `\titlespacing`, `head.titlesec`); the paragraph level is run-in (afterskip -1em) |
| `\subsubsubsection` | arxiv.sty:110-113 | yes | unused; prints `\vskip5pt` and an empty group: `sp.manual-space` |
| caption lengths | arxiv.sty:121-125 | yes | `\newlength` helpers `\@abovecaptionskip` `\@belowcaptionskip` then `\setlength` of the two kernel skips: values 7pt and 0pt (`cap.kernel`) |
| `table` environment | arxiv.sty:128-132 | yes | its whole body is two `\setlength` calls plus the kernel `\@float{table}`; write the two lengths (above 0pt, below 7pt) at the start of each table float, or once in a hook that runs at `table` start (`cap.kernel`, `sp.lengths`) |
| list hooks `\@listi`..`\@listvi` | arxiv.sty:155-177 | yes | only length assignments per level: `sp.lengths` on `list.kernel`, or `list.enumitem` per level |
| `\maketitle` | arxiv.sty:180-200 | yes | kernel pieces only: a group, `\thefootnote`=`\fnsymbol`, `\@makefntext` (1em indent, mark in a 1.8em box with `\hss` before it; article's own definition is close to this, its source was not read), `\thispagestyle{empty}`, `\@maketitle`, `\@thanks`, then `\let\maketitle\relax`; with `front.titling`: `\thanksmarkseries{fnsymbol}` and `hf.pagestyle-kernel` |
| title bars | arxiv.sty:203-213 | yes | `\hrule height 2pt` and `\vskip` values: `sp.rule`, `sp.manual-space` |
| `\@maketitle` | arxiv.sty:216-239 | yes | linear stack of kernel boxes and glue, no counters or conditionals: `front.titling` hooks. `\pretitle` = vbox open with `\hsize\textwidth`, `\vskip 0.1in`, `\hrule height 2pt`, `\vskip 0.25in`, `\vskip -\parskip`, `\centering\LARGE\sc`; `\posttitle` = `\par`, 0.29in skip, `\hrule height 2pt`, 0.09in skip, `\textsc{A Preprint}\\`, 0.1in skip; `\preauthor`/`\postauthor` = `\begin{tabular}[t]{c}\bf\rule{0pt}{24pt}` and `\end{tabular}`; `\predate` = `\vskip 0.4in minus 0.1in` and a centred date; `\postdate` = `\vskip 0.2in` and the vbox close |
| `\And` `\AND` | arxiv.sty:228-235 | yes | `\def`s inside the title vbox, equal to `\end{tabular}\hfil\linebreak[0 or 4]\hfil\begin{tabular}[t]{c}\bf\rule{0pt}{24pt}\ignorespaces`; a `\newcommand` alias or inline text in the author field (`sp.manual-space`, `tbl.tabular`) |
| `\@notice` `\ftype@noticebox` | arxiv.sty:242-249 | yes (dead) | the only call is commented out (arxiv.sty:196) and `\@noticestring` is defined nowhere in the zip (Grep), so it prints nothing; drop |
| `abstract` environment | arxiv.sty:252-260 | yes | `\centerline` heading plus `quote`: `abs.kernel` with `quote.kernel`; or the `abstract` package, `abs.abstract-pkg`, with the name font set to `\large\bfseries\scshape` |

## Content-opaque
none (the one entry in references.bib:1-8 is bibliographic content)

## Lib changes
- New ways proposed: none
- Considered: `doi` as its own way; filed under `meta.url` (a link-typesetting command with special-character handling, load-only here, called nowhere). The consolidator may widen that line's text.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
