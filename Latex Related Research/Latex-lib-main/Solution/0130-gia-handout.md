yes

# 0130-gia-handout: gia-handout (LaTeX class for Gesellschaft fuer Informatik publications, with its German documentation)

- Unverified: read from the source, not compiled.
- Source: Source/0130-gia-handout/ (origin: https://mirrors.ctan.org/macros/latex/contrib/gia-handout.zip; licence: LPPL 1.3 (gia-handout.cls:4-10))
- Kind: misc (class documentation; the class itself targets GI handouts and reports)
- Lib: v2
- Engine: pdfLaTeX-compatible (sample loads `inputenc`+`fontenc` at gia-handout-doc.tex:36-37; the class branches on `iftex` to `fontspec` for other engines, gia-handout.cls:32-37)
- Look carried by: mixed (the GI look is in gia-handout.cls, a published CTAN class the sample does not load; the documentation sample is `article` plus preamble packages and re-declared extracts, gia-handout-doc.tex:34-175)
- Class origin: ctan (https://ctan.org/pkg/gia-handout read: "A LaTeX class for typesetting publications of the German Informatics Association", sources /macros/latex/contrib/gia-handout)
- Main file: gia-handout-doc.tex (other samples: none; README.md lines 44-46 and gia-handout-doc.tex:276-290 only show a `\documentclass{gia-handout}` stub as listing text)
- Read: main yes, zip-local classes and styles all (gia-handout.cls, 318 lines; it is published, so read for the record only)

## Verdict
The main sample is the class manual. It is `article` plus published packages and kernel commands, and its own macros (`\myopt` `\mycmd` `\myenv`, `\GI` `\gi`, the `giacolorbox` wrapper) are aliases or compositions of `xcolor`, `\texttt` and `tcolorbox` that inline at each call, so every component maps to a lib way. The zip's template, gia-handout.cls, is on CTAN (one ctan.org read), so it is one published class way, `class.gia-handout`, with its options and commands as parameters; the sample does not load it. The class's own internals hold a TikZ-drawn default cover and an expl3/tagpdf socket patch of `qrcode`; these are not counted because of the published-class ruling, but they are recorded below so a stricter reading can reuse them. Nothing was compiled.

## Blockers
none. (Not counted, recorded only: the class's TikZ cover and its qrcode socket patch, see Bespoke code rows 8 and 9.)

## Class setting
- Class: `class.article` options: `a4paper` (gia-handout-doc.tex:34). The zip's own template class is `class.gia-handout` (CTAN, gia-handout.cls:20-28), a `scrartcl` wrapper (a4paper, toc=flat, fontsize=10pt, parskip=half) that the sample does not load.
- Class-native vocabulary used (by the sample): none; `article`'s `abstract` env (:207), `\section`..`\subsubsection`, `\paragraph`, `\tableofcontents` (:215), `table`/`figure` floats.
- Native vocabulary of `class.gia-handout` (documented at gia-handout-doc.tex:292-396, defined in gia-handout.cls): options `autorenListe`, `koordination`, `frontcover=<pdf>`, `backcover=<pdf>` (gia-handout.cls:92-105); commands `\GIAsetzeautorenListe`, `\GIAsetzekoordination`, `\GIAautorenListe`, `\GIAkoordination`, `\GIAmitwirkende` (:88-91, :223-231), `\hervor` (:217), `\GI`, `\gi` (:219-221); environments `zweispaltig[n]` (:236-240), `giacolorbox[title]` (:245-265); colours `giaBlue`, `giaYellow`, `giaLightYellow`, `giaGray` (:60-63); `\title` `\author` `\date` feed the default front cover (:290-296); no `\maketitle`.
- Inside the class (published, not counted as Component-map evidence): geometry top/bottom 1.7cm, left/right 3.5cm, includehead, includefoot (:45-52); `\interfootnotelinepenalty` 10000 (:53); `\headheight` plus `\baselineskip` (:54); `scrlayer-scrpage` loaded with no `\pagestyle` or head/foot fields set (:56; grep found none); `babel` ngerman and `csquotes` german=guillemets (:39-40); `microtype`, `setspace` (:42-43); `FiraSans[sfdefault]`, `FiraMono` (:108-109); `hyperref`, `bookmark` with defaults (:76-77); `tocdepth` 1 (:166); KOMA `\sectionformat` and `\subsectionformat` redefined as a `tcolorbox` number tab (`on line`, `colback=seccolor!70`, `grow to left by=1.5cm`, `tcbox raise=-4pt`) with `\addtokomafont{section}{\color{seccolor!90}}` (:168-213); `\columnsep` 30pt and a `multicols` wrapper (:235-240); `giacolorbox` with a `\tagstructbegin{tag=Div}` wrapper (:245-265).

## Component map
Rows cite gia-handout-doc.tex unless a path is given. Ways are for the sample as loaded; the class way is last.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | :34 | `class.article` | a4paper |
| page size | :34 | `page.class-options` | a4paper; no `geometry`, default margins |
| encodings | :36-37 | `font.fontenc-t1` | `inputenc` utf8, `fontenc` T1; no font package, default Computer Modern |
| language | :39 | `lang.babel` | ngerman |
| quotes | :41, :208, :295 | `lang.csquotes` | german=guillemets; body `\enquote{}` |
| microtype | :67 | `sp.microtype` | defaults |
| colours | :71, :74-77, :104, :124, :160 | `color.xcolor` | giaBlue RGB 14,32,80; giaYellow 255,230,0; giaLightYellow 255,242,204; giaGray 74,74,74; mixes `giaYellow!75!giaGray`, `green!50!black`, `giaBlue!0!giaYellow` |
| PDF metadata | :107-116 | `meta.hyperref` | `\hypersetup` pdftitle, pdfsubject, pdfkeywords, pdfauthor (German strings; the English pair is commented out) |
| urls | :118, :201, :223, :226 | `meta.url` | `url` package, `\url{}`; `\nolinkurl` at :198 is hyperref's |
| bibliography | :43-46, :47-64, :65, :321, :335 | `bib.biblatex-biber` | backend=biber, style=authoryear; two `@online`/`@manual` entries written by `filecontents*`; `\addbibresource{\jobname.bib}`; cited only with `\footfullcite` (no `\printbibliography`) |
| title block | :148-150, :179-203 | `front.maketitle` | `\title{\pkg{gia-handout}}`, `\author{... \qquad ...}`, `\date`; `\maketitle` never called, values read back by `\@title` `\@author` at :186, :195 |
| title block layout | :179-203 | `sp.ragged` | `centering` environment around the whole block |
| title block spacing | :181-199, :205, :212 | `sp.manual-space` | `\vspace*{0.03\textheight}`, `\vspace{1.5\baselineskip}`, 1, 1.2, 2, 1.5, 0.67 `\baselineskip`, `\vfill` |
| title block sizes and marks | :183-201 | `font.size-commands` | `\Large`, `\huge`, `\large`, `\normalsize` |
| title block marks | :183, :186 | `mark.kernel` | `\textsc`, `\bfseries`; `\LaTeX` at :189 |
| abstract | :207-210 | `abs.kernel` | `abstract` env between two `\vfill`; two `\footnote`s inside |
| footnotes | :208, :226 | `fn.kernel` | `\footnote{}` with `\enquote`, `\url` inside |
| contents | :214-216, :272 | `toc.kernel` | `\tableofcontents` inside `multicols{2}`; `\addtocontents{toc}{\protect\setcounter{tocdepth}{1}}` |
| toc depth | :272 | `num.secnumdepth` | `tocdepth` set to 1 mid-document through the toc file |
| page break | :218 | `pg.break` | `\clearpage` |
| headings | :220-225, :259, :265, :373, :378, :412, :420 | `head.kernel` | `\section`, `\subsection`, `\subsubsection`, `\paragraph{...}\hfill` (run-in heading used as block); article defaults, no restyling |
| lists | :260, :294, :342, :352, :374, :379, :413, :421 | `list.kernel` | `itemize`; `description` with custom `\item[...]` labels |
| swatch labels | :343-346 | `box.fancybox` | `\fcolorbox{black}{giaBlue}{...}` as item label |
| swatch fill | :343-346 | `sp.rule` | `\phantom{\rule{1em}{.67em}}` |
| manual line control | :295-300, :353-368, :422-427 | `sp.manual-space` | `\phantom{}\newline`, `\hfill{...}` after description labels |
| columns | :214, :258-270, :341-348 | `cols.multicol` | `multicols{2}`, `\columnbreak` at :264 |
| side-by-side blocks | :305-317, :383-410 | `cols.minipage` | two `minipage{.45\textwidth}` separated by `\hfill` (figure pair; listing beside rendered box) |
| page-break guard | :322-333 | `box.minipage` | `minipage{\linewidth}` around text plus listing |
| table | :227-255 | `tbl.tabular` | `table[!h]` float, `\centering`, `tabular{ll}`, `\hline`, bold header row |
| figure | :303-318 | `fig.graphicx` | `figure[!h]`, `\includegraphics[width=\textwidth]{gia-default-*cover.pdf}` |
| image frame | :307, :314 | `box.fancybox` | `\fbox{...}` around each image |
| captions | :308, :315 | `cap.kernel` | two `\caption` calls in one figure, each with a `\protect\hyperlink` |
| cross-references | :302, :309, :316 | `xref.kernel` | `\label`, `\ref`, `\pageref` |
| internal links | :295-300, :308, :353-368 | `xref.hyperref` | `\hypertarget`, `\hyperlink`, `\href{mailto:...}` at :198 |
| code listings | :98-105, :276-290, :324-332, :384-402 | `code.listings` | `\lstset` basicstyle=`\ttfamily`, columns=fullflexible, language=[LaTeX]TeX, escapechar=`*`, commentstyle=`\color{green!50!black}\bfseries` |
| inline code | :356, :358 | `code.verbatim` | `\verb\|...\|` |
| coloured box | :95-96, :152-175, :393-395, :407-409 | `box.tcolorbox` | libraries breakable, skins; colback=white, colframe=`giaBlue!0!giaYellow`, `sharp corners=all`, `title=#1`, fonttitle=`\color{black}`, `enhanced jigsaw`, `grow sidewards by=2mm`, `borderline={4mm}{-4mm}{giaGray!5!white}`, `borderline={0.5pt}{0pt}{giaYellow}`, `before skip`=`after skip`=`\giacolorboxskip`, `notitle` when no title |
| box skip length | :153-155 | `sp.lengths` | `\newlength`, `\setlength` 4mm, `\addtolength` 3pt |
| doc helpers | :120-146 | `mark.kernel` | `\texttt`, `\textnormal`, `\textbackslash` inside `\pkg`, `\myopt`, `\mycmd`, `\myenv` (colour from `color.xcolor`) |
| tikz preamble | :92-93 | `art.tikz` | `\usepackage{tikz}`, libraries calc, positioning; no `tikzpicture` in the sample (grep count 0), so no ART |
| template class | gia-handout.cls:20-28, :92-105, :223-265 | `class.gia-handout` | the zip's own class, not loaded by the sample (:34 loads `article`); options and commands listed under Class setting |

## Bespoke code
| # | Item | Where | Reducible? | Reduction |
|---|---|---|---|---|
| 1 | `\myopt`, `\mycmd`, `\myenv` | gia-handout-doc.tex:123-146 | yes | each call inlines to `\textcolor{giaYellow!75!giaGray}{\texttt{...}}` (`color.xcolor`, `mark.kernel`) plus optional ` = value`, `{arg}` or `[opt]` text; the `\if\relax\detokenize{#}\relax` tests only omit an empty slot and are decided by the call's own arguments |
| 2 | `\pkg`, `\mypdflatex`, `\mylualatex` | :120-122 | yes | aliases of `\texttt{...}` (`mark.kernel`) |
| 3 | `\GI`, `\gi` | :79-80 | yes | text aliases: `GI`; `Gesellschaft f\"ur Informatik e.\,V.`; inline at each use |
| 4 | `giacolorbox` environment | :156-174 | yes | xparse wrapper over one `tcolorbox` (`box.tcolorbox`, keys in the Component map); `\IfNoValueT{#1}{notitle}` becomes `title=...` or `notitle` per call |
| 5 | `\giacolorboxskip` | :153-155 | yes | one length, 4mm+3pt (`sp.lengths`), used as `before skip` and `after skip` |
| 6 | `\makeatletter\@title`, `\@author` | :186, :195 | yes | read-back of `\title` and `\author` values; the emitter writes the content directly |
| 7 | `\definecolor` extracts, `\newcommand` extracts | :73-81, :152-175 | yes | copies of published-class vocabulary re-declared in the preamble; `color.xcolor` calls |
| 8 | default front cover: `\AtBeginDocument` with `\newgeometry` 0cm and a TikZ overlay (full-page `giaBlue` rectangle inset 0.5cm, `giaYellow` node anchored by `calc` at 70% page height, uppercase `\@author` `\@title` `\@date`), then `\clearpage`, `\restoregeometry` | gia-handout.cls:268-306 | n/a, inside the published class way; would be ART/class under a stricter reading | only an included PDF (`frontcover=`) or the default cover through `class.gia-handout`; a TikZ page overlay would be `bg.tikzpagenodes`, which the lib marks ART when it draws the template's identity |
| 9 | `qrcode` tagpdf workaround: `\ExplSyntaxOn` position saving, `\NewSocket`/`\NewSocketPlug`, `\tagpdfsetup`, `\patchcmd\qrcode@int` | gia-handout.cls:111-164 | n/a, inside the published class way; would be BESPOKE/class under a stricter reading | none inside the lib (expl3, tagging sockets and a patch of another package's internals); `qrcode` itself is pure TeX, so no EXTERNAL |
| 10 | class options through `pgfkeys`/`pgfopts` with `\newif` flags; `\GIAautorenListe`, `\GIAkoordination`, `\GIAmitwirkende` print only when the flag is set | gia-handout.cls:80-105, :223-231 | n/a, class-native vocabulary of the published class | the emitter writes the options and the `\GIAsetze...` strings as class parameters |
| 11 | back cover: `\AtEndDocument` with `\newgeometry` 0cm and `\pagecolor{giaBlue}\null`, or an included image | gia-handout.cls:307-317 | n/a, inside the published class; reduces to `color.pagecolor` plus `page.geometry` | `\pagecolor{giaBlue}` on a zero-margin page, or `\includegraphics` of the `backcover=` file |

## Content-opaque
none that no way can hold. Figure artwork: two PDF cover images included at gia-handout-doc.tex:307 and :314 (content, held by `fig.graphicx`; the PDFs are in the zip). Listing text at :276-290, :324-332, :384-388, :398-402 is code content. Commented-out parts are not counted: `\DocumentMetadata` block (:20-32) and the `enumitem` block (:83-88).

## Lib changes
- New ways proposed: none. (Considered `meta.documentmetadata` for the tagging setup: it appears only in comments and listing text, so it is not used.)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
