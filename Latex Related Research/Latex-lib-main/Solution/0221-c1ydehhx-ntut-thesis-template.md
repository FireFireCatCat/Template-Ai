yes

# 0221-c1ydehhx-ntut-thesis-template: NTUT thesis template (XeLaTeX, Traditional Chinese master's thesis)

- Unverified: read from the source, not compiled.
- Source: Source/0221-c1ydehhx-ntut-thesis-template/ (origin: https://codeload.github.com/c1ydehhx/NTUT-Thesis-Template/zip/refs/heads/main; licence: MIT, LICENSE:1)
- Kind: thesis
- Lib: v2
- Engine: needs XeLaTeX (`xeCJK`, `fontspec` via `\setmainfont`; README.md:3 and build.sh:2 say XeLaTeX)
- Look carried by: mixed (zip-local `ntut-report.cls`, a modified copy of kernel `report.cls`, sets chapter/TOC/abstract looks; `main.tex` preamble sets page, fonts, captions, watermark; `ntut-labels.tex` holds only string macros)
- Class origin: zip-local
- Main file: main.tex (other samples: none; `page/*.tex` and `chapter/*.tex` are included pieces of the one document)
- Read: main yes, zip-local classes and styles all (`ntut-report.cls` 918 of 918 lines, `ntut-labels.tex`, every `page/*.tex` and `chapter/*.tex`)

## Verdict
`yes`, with caveats. The only zip-local code is `ntut-report.cls`, a hand-edited copy of the kernel report class. Every edit is a composition of lib ways: chapter heads and TOC lines through `titlesec`/`titletoc`, abstract and thanks pages as `\newenvironment` aliases over `\chapter*` and `setspace`, caption names as plain name macros, and the `\@float` hook is dead code. No artwork is drawn in TeX; the watermark is the published `wallpaper` package. Caveats: `mla.sty` is loaded and not read (not in the zip), and the reductions of chapter and TOC lines are written from the source, not compiled.

## Blockers
none

## Class setting
- Class: `class.report` options: `12pt`, `a4paper` (main.tex:1). The zip-local `ntut-report` is a modified copy of kernel `report.cls`: header comment ntut-report.cls:1-3 and 42-60, `\ProvidesClass{ntut_report}` at ntut-report.cls:88 (name differs from the file name). Not on CTAN or in an official release, so zip-local; reduced to `class.report` plus the edits in "Bespoke code". It loads no package itself (grep: no `RequirePackage`/`LoadClass`), yet uses `\zhnumber` (ntut-report.cls:387,405) and `spacing` (ntut-report.cls:507) that `main.tex` loads (main.tex:11,13).
- Class-native vocabulary used: report's `\chapter`, `\section`..`\subsubsection`, `titlepage`, `\tableofcontents`, `\listoffigures`, `\listoftables`, `figure*`, `table*` (main.tex, chapter/*.tex, page/*.tex); zip-local `ZhAbstract`, `ZhAbstractItems`, `ZhAbstractDescription`, `EnAbstract`, `EnAbstractItems`, `EnAbstractDescription`, `Thanks`, `TableOfContent`, `ZhChapter` environments (ntut-report.cls:502-576) and the font-size switch `\text` (ntut-report.cls:895; used page/abstract.tex:5, chapter/chapter1-introduction.tex:13).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1; ntut-report.cls:160-162 | `class.report` | 12pt, a4paper; defaults `letterpaper,10pt,oneside,onecolumn,final,openany` |
| paper and size | main.tex:1; ntut-report.cls:97-99,126 | `page.class-options` | a4paper, 12pt |
| page geometry | main.tex:5,31 | `page.geometry` | a4paper, total={297mm,210mm}, top=4.5cm, bottom=0.75cm, left=2.5cm, right=2.5cm (total width/height as written, looks landscape-sized; effect not checked) |
| CJK setup | main.tex:7,28,29 | `lang.cjk` | xeCJK; AutoFakeBold=true, AutoFakeSlant=true; `\setCJKmainfont{DFKai-SB.ttf}` (font shipped as DFKai-SB.ttf) |
| Chinese numerals | main.tex:13; ntut-report.cls:387,405 | `lang.cjk` | `zhnumber` (CJK support package, the package is the parameter, as `polski` under `lang.babel`); `\zhnumber\thechapter` |
| Latin font | main.tex:30 | `font.fontspec` | `\setmainfont{Times New Roman}` (system font, not shipped) |
| font sizes | ntut-report.cls:890-894; titlepage.tex:10-33 | `font.size-commands` | `\huge` 24/24pt, `\LARGE` 20/20, `\Large` 18/18, `\large` 14/14, `\normalsize` 12/12 via `\@setfontsize`; page use `\huge` `\LARGE` `\Large` |
| old font switches | ntut-report.cls:735-743; titlepage.tex:10 | `mark.kernel` | `\bf` `\rm` `\sf` `\tt` `\it` `\sl` `\sc` via `\DeclareOldFontCommand` (kernel set) |
| `\text` size switch | ntut-report.cls:895 | `font.size-commands` | `\@setfontsize\text{12}{12pt}`; amsmath (main.tex:15, loaded after the class) also defines `\text`, which one survives is not established |
| line spacing | main.tex:27; ntut-report.cls:165 | `sp.linespread` | `\baselinestretch`=1.5 |
| spacing package | main.tex:11; ntut-report.cls:507,531,555,565,572 | `sp.setspace` | `setspace`; `spacing` environment, factor 2 |
| first-line indent | main.tex:10 | `sp.indentfirst` | package only |
| paragraph lengths | ntut-report.cls:163-167 | `sp.lengths` | `\parindent`=2em, `\parskip`=0pt plus 1pt, `\lineskip`=1pt |
| manual spacing | ntut-report.cls:505,513; page/titlepage.tex:17,22,27,32 | `sp.manual-space` | `\vspace{0.5cm}`, `\vfill` |
| table centring box | chapter/chapter1-introduction.tex:18 | `sp.manual-space` | `\makebox[\linewidth][c]{...}` (kernel LR box, same family as `\raisebox`) |
| page breaks | page/titlepage.tex:2; page/blankpage.tex:1; main.tex:40,42 | `pg.break` | `\newpage`, `\include` (forces `\clearpage`) |
| page style | main.tex:32; ntut-report.cls:902; page/blankpage.tex:2 | `hf.pagestyle-kernel` | `plain`; `\thispagestyle{empty}` |
| page numbers | main.tex:53,65; ntut-report.cls:903 | `pgnum.pagenumbering` | roman for front matter, arabic from chapter 1 |
| include PDF | main.tex:9,51 | `pg.include-pdf` | `\includepdf[pages=-]{static-page/signpage.pdf}` (signed form scan is an asset, content) |
| watermark | main.tex:8,45 | `bg.eso-pic` | `wallpaper` package (CTAN, built on eso-pic): `\CenterWallPaper{.64}{ntut-logo.png}` from the second cover on; the package is the parameter, as `font.helvet` under `font.helvet` |
| hyperlinks | main.tex:12; ntut-report.cls:508 | `meta.hyperref` | default options; `\phantomsection` in the abstract envs |
| cover page | page/titlepage.tex:1-36; main.tex:40,48 | `front.titlepage-env` | `titlepage` + `center`; `\includegraphics[width=13cm]{ntut-logo-with-label.png}`; `\vfill` between blocks; lines from `\deptCname` `\degreeCname` `\cTitle` `\eTitle` `\myCname` `\advisorCname` `\cYear` `\cMonth` |
| cover logo | page/titlepage.tex:5 | `fig.graphicx` | `\includegraphics[width=13cm]`; `graphicx[dvips,xetex]` main.tex:2 |
| abstract pages (zh, en) | page/abstract.tex:2-13; page/abstract-en.tex:2-13; ntut-report.cls:502-549 | `head.kernel` + `sp.setspace` | unnumbered `\chapter*{摘要}` / `\chapter*{ABSTRACT}`, `\addcontentsline{toc}{chapter}{...}`, `spacing` 2, `\vspace{0.5cm}` |
| keyword line | page/abstract.tex:5; page/abstract-en.tex:5 | `abs.keywords` | hand-written `\noindent ... 關鍵詞：` / `Keyword:` line |
| acknowledgement page | page/thanks.tex:1-3; ntut-report.cls:550-562 | `front.dedication` | `Thanks` env: `\chapter*{誌謝}`, `spacing` 2, TOC entry |
| contents, lists | page/table-of-content.tex:1-11; ntut-report.cls:748-760,799-826 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables`, each inside `spacing` 2; extra `\addcontentsline{toc}{chapter}{目錄/圖目錄/表目錄}` |
| contents chapter line | ntut-report.cls:791-793,382-387 | `toc.titletoc` | reduction: `\titlecontents{chapter}[0em]` with 第 `\zhnumber{\thecontentslabel}` 章 label, 1.4em number box, 2em gap, dotted leaders; sections keep report's `\@dottedtocline` values (:794-798) |
| TOC depth, numbering depth | ntut-report.cls:306,747 | `num.secnumdepth` | secnumdepth=3, tocdepth=2 |
| chapter heading | ntut-report.cls:374-378,400-411,439-444 | `head.titlesec` | reduction: `\titleformat{\chapter}[block]{\normalfont\centering\LARGE\bfseries}{第\zhnumber{\thechapter}章}{1em}{}`, `\titlespacing*{\chapter}{0pt}{0pt}{20pt}`, starred form same without label (titlesec is loaded, main.tex:14, but no `\titleformat` in the zip) |
| section headings | ntut-report.cls:445-464 | `head.kernel` | `\@startsection` arguments: section `\normalfont\LARGE\bfseries`, subsection `\Large`, subsubsection `\large`, paragraph and subparagraph `\normalsize\bfseries`; skips -3.5ex/2.3ex, -3.25ex/1.5ex |
| counters | ntut-report.cls:307-321,669-674,686-687,874 | `num.counters` | sections, equation, figure, table numbered within chapter (`\theequation`, `\thefigure`, `\thetable`); footnote reset per chapter |
| appendix | ntut-report.cls:656-660 | `num.appendix` | report `\appendix` (unused in sample) |
| chapter wrapper | chapter/chapter1-introduction.tex:1,99; chapter/chapter2-related-work.tex:1,36; ntut-report.cls:570-576 | `sp.setspace` | `ZhChapter` = `spacing` 2 around each chapter |
| names | ntut-report.cls:879-889 | `lang.cjk` | `\contentsname`=目錄, `\listfigurename`=圖目錄, `\listtablename`=表目錄, `\figurename`=圖, `\tablename`=表 (reduction: ctex name keys or kernel `\renewcommand`); other names stay English |
| quotes | main.tex:18,21,22 | `lang.csquotes` | `\MakeAutoQuote{“}{”}`, `\MakeOuterQuote{"}` |
| equations | chapter/chapter1-introduction.tex:7-9,35-37; main.tex:15 | `math.amsmath` | `equation` with `\mbox{$...\dfrac...$}` (equation text is content) |
| figures | chapter/chapter1-introduction.tex:43-62,92-97; chapter/chapter2-related-work.tex:29-34 | `fig.graphicx` | `figure*[htbp]`, `\centering`, `\includegraphics[width=1\textwidth]` and `0.5\textwidth`; `\label` |
| tables | chapter/chapter1-introduction.tex:15-31,64-82; chapter/chapter2-related-work.tex:9-23 | `tbl.tabular` | `table*[htbp]`, `\renewcommand\arraystretch{1.2}`, `tabular{| l | c c c c |}`, `\hline` |
| subfigure, tabularx | main.tex:17,19 | `fig.subcaption`, `tbl.tabularx` | load-only; no use in the sample (grep) |
| captions | main.tex:24,25; ntut-report.cls:698-701,725-734 | `cap.caption` | `\captionsetup{justification=centering,singlelinecheck=false,font={normalsize,stretch=2}}`, same for `[sub]`; supersedes the class `\@makecaption` (abovecaptionskip 10pt, below 0pt) |
| caption command | chapter/chapter1-introduction.tex:17,46 | `cap.kernel` | `\caption{...}` |
| cross references | chapter/chapter1-introduction.tex:17,47; chapter/chapter2-related-work.tex:11,33 | `xref.kernel` | `\label` (labels repeated; no `\ref` in the sample) |
| bibliography | main.tex:16,33; page/reference.tex:1; reference.bib | `bib.biblatex-bibtex` | `backend=bibtex,sorting=none`, `\addbibresource{reference.bib}`, `\printbibliography[heading=bibintoc, title=參考文獻]`, `\cite{latex2e}` (chapter2:7); `IEEEtran.bst` in the zip is not referenced |
| MLA package | main.tex:3 | `bib.apacite` | `mla` (ctan.org/pkg/mla: BibTeX MLA styles) loaded with `ifpdf`; no MLA command used in the sample; `mla.sty` not read, effect not established; mapped to the standard-specific citation family |
| lists, quotes, footnotes, index | ntut-report.cls:466-501,577-625,870-878,851-869 | `list.kernel`, `quote.kernel`, `fn.kernel`, `idx.makeidx` | report's own definitions, unchanged in values; none used in the sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `ntut-report.cls` as a whole | ntut-report.cls:1-918 | yes | `class.report` plus the rows below; no class-level `RequirePackage` to reproduce |
| `\@chapter`, `\@makechapterhead`, `\@makeschapterhead`, `\countermapping`, `\prechaptername`, `\postchaptername`, `\tocprechaptername`, `\tocpostchaptername` | ntut-report.cls:374-444 | yes | `head.titlesec` chapter format and `toc.titletoc` chapter line as in the component map; `\countermapping` is the identity (:379); the name macros are the strings 第 and 章 |
| `\l@chapter`, `\tableofcontents`, `\listoffigures`, `\listoftables` edits | ntut-report.cls:748-760,791-793,799-826 | yes | `toc.kernel` commands plus `\addcontentsline{toc}{chapter}{...}`; `\l@chapter` as `\@dottedtocline{0}{0em}{1.4em}` or `\titlecontents` |
| `ZhAbstract`, `EnAbstract`, `Thanks`, `TableOfContent`, `ZhChapter` and the `...Items`/`...Description` envs | ntut-report.cls:502-576 | yes | `\newenvironment` aliases over `\chapter*`, `spacing`, `\vspace`, `\phantomsection`, `\addcontentsline` (no conditionals, no counters) |
| `\@float`/`\@dblfloat` hook, `\ntut@captionstretch`, `\ntut@applycaptionstretch` | ntut-report.cls:703-723 | yes | no printed effect: the stored stretch is read only by `\ntut@applycaptionstretch`, which is never called anywhere in the zip (grep `ntut@`); the caption spacing is `cap.caption` `stretch=2` (main.tex:24) |
| `\@makecaption` | ntut-report.cls:725-734 | yes | the `caption` package (main.tex:19 loads it through `subcaption`) takes over; options `justification=centering,singlelinecheck=false` |
| font size table | ntut-report.cls:890-895 | yes | preamble `\renewcommand\huge{\@setfontsize\huge{24}{24pt}}` etc. (`font.size-commands`); the bare `\@setfontsize` form also drops the display-skip and list resets the standard `\normalsize` carries (standard size file not read) |
| name macros | ntut-report.cls:879-889 | yes | strings, see component map |
| `\text` | ntut-report.cls:895 | yes | a 12pt size switch; clash with amsmath's `\text` noted above |
| `\newcounter{abstract}`, tail after `\endinput` | ntut-report.cls:308,915-916 | yes | unused; the `\renewcommand\bibsection{Reference}` after `\endinput` is never read |
| label macros | ntut-labels.tex:14-94 | yes | `\newcommand` string macros (`\cTitle`, `\eTitle`, `\myCname`, `\advisorCname`, `\deptCname`, `\degreeCname`, `\cYear`, `\cMonth` used in page/titlepage.tex:10-33; the rest unused): inline the strings |
| Makefile, build.sh | Makefile:1-9; build.sh:1-4 | yes | only call `xelatex`, `bibtex`, `xelatex`; TeX tools, not an EXTERNAL tool |

## Content-opaque
- `static-page/signpage.pdf` scan inserted by `\includepdf` (main.tex:51); `image.jpeg` in figures (chapter/chapter1-introduction.tex:45); equation text (chapter/chapter1-introduction.tex:8,36); `lipsum` is loaded (main.tex:6) and never called (grep).

## Lib changes
- New ways proposed: none (`wallpaper` filed under `bg.eso-pic`, `zhnumber` and caption-name keys under `lang.cjk`, `mla` under `bib.apacite`; considered: the `wallpaper` package as a way of its own, not proposed because ctan.org/pkg/wallpaper says it uses `eso-pic` and it does the same job)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
