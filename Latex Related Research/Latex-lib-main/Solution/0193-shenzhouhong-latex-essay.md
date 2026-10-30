yes

# 0193-shenzhouhong-latex-essay: Humanize essay template (ShenZhouHong/latex-essay)

- Unverified: read from the source, not compiled.
- Source: Source/0193-shenzhouhong-latex-essay/ (origin: https://codeload.github.com/ShenZhouHong/latex-essay/zip/refs/heads/master; licence: GPL-3.0)
- Kind: misc (a generic humanities essay template; the closest listed kinds are assignment and report)
- Lib: v4
- Engine: needs LuaLaTeX (`fontspec` and `libertinus-otf` are loaded unconditionally, latex/humanize.cls:150,152; the makefile builds with `-lualatex`, makefile:23; README.md:63)
- Look carried by: zip-local (the class `humanize.cls` and the file `configuration.tex` it is paired with carry everything; `paper.tex` only sets class options, title and author)
- Class origin: zip-local (ctan.org/pkg/humanize returned 404; the class exists only in this repository; no official-release or publisher status)
- Main file: latex/paper.tex (other samples: none; `latex/sections/body.tex` and `latex/sections/endpage.tex` are `\include`d by it, `latex/figures/template-*.tex` are optional snippets that nothing includes)
- Read: main yes, zip-local classes and styles all (humanize.cls 214 lines, mt-protrusion.cfg 30, configuration.tex 89, paper.xmpdata 14, all five figures snippets, makefile)

## Verdict
Every part of the look is a published package or kernel command with parameters. The zip-local class `humanize` is `\LoadClass{report}` plus `\RequirePackage` lines, option switches that call `titlesec`, `setspace`, `fontspec`, `geometry` and `microtype`, and two `AtBeginDocument` checks on which package is loaded; all of it reduces by writing the chosen ways out directly. No TikZ or other artwork defines the template, and no tool outside TeX is needed by the loaded document (the only `minted` use sits in an optional snippet that nothing loads, with its package line commented out). The answer is `yes`, with the `Engine` note that the template needs LuaLaTeX.

## Blockers
none

## Class setting
- Class: `class.report` (loaded by the zip-local class `humanize`, latex/humanize.cls:147; README.md:2 says "based off the article class", the code says report, humanize.cls:3,146-147). Options in the sample: `protrudelabels, onehalfspacing, extraligatures, notitlepage, english, widemargins` (latex/paper.tex:19-26). The class sets defaults `10pt, a4paper, final, onecolumn, oneside, notitlepage, onehalfspacing, hangingpunct` (latex/humanize.cls:132-141) and passes every undeclared option to `report` (latex/humanize.cls:113-115).
- Class-native vocabulary used: `\title` `\author` (with `\and`) `\date{\today}` `\maketitle`, `\tableofcontents`, `\section`..`\subsubsection` and starred forms (latex/paper.tex:31-42; latex/sections/body.tex:1,14,30,38). No `\chapter`, no `abstract`.
- Source of `humanize.cls` itself is the zip's own; `report` is the kernel class (its source was not read).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | latex/humanize.cls:147 | `class.report` | options `10pt a4paper final onecolumn oneside notitlepage` (humanize.cls:132-141) |
| paper, size, columns, sides | latex/humanize.cls:132-141 | `page.class-options` | `a4paper`, `10pt`, `oneside`, `onecolumn` |
| page geometry | latex/humanize.cls:154,105-110; latex/paper.tex:25 | `page.geometry` | `\RequirePackage{geometry}` with no options; option `widemargins` runs `\geometry{pass}` |
| line spacing | latex/humanize.cls:6-17,139,156; latex/paper.tex:21 | `sp.setspace` | `\AtEndOfClass{\onehalfspacing}` (also `\singlespacing`, `\doublespacing` options) |
| paragraph style | latex/humanize.cls:157 | `sp.parskip-pkg` | `[indent=3em, skip]` |
| microtypography | latex/humanize.cls:153,82-88 | `sp.microtype` | `\RequirePackage{microtype}`; option `hangingpunct` (default) runs `\LoadMicrotypeFile{protrusion}` |
| protrusion table | latex/mt-protrusion.cfg:3-31 | `sp.microtype` | `\LoadMicrotypeFile{ptm}`; `\SetProtrusion[name=hangingpunct, load=ptm-T1]{encoding=TU}{ . , - ( ) « » and the quote commands with left/right values }` |
| font engine and features | latex/humanize.cls:150,166-179,181,94-102 | `font.fontspec` | `\defaultfontfeatures+{Script=Latin, Language=Default, Ligatures={Common,Discretionary}, Contextuals={Alternate}, Letters=Uppercase, RawFeature=+ccmp, Kerning={On,Uppercase}, Diacritics={MarkToBase}, UprightFeatures={StylisticSet={2,5,6}}}`; `\setmainfont{LibertinusSerif}`; `extraligatures` adds `Ligatures={Common,Discretionary,Historic}` |
| typeface | latex/humanize.cls:152 | `font.libertine` | package `libertinus-otf` (the OpenType variant, so needs XeLaTeX or LuaLaTeX although the lib line is tagged pdf) |
| language | latex/humanize.cls:151; latex/paper.tex:24 | `lang.babel` | `\RequirePackage{babel}` with global option `english` |
| quotation marks | latex/humanize.cls:155,190; latex/sections/body.tex:10,18,27 | `lang.csquotes` | `[autopunct]`, `\MakeOuterQuote{"}`; body uses `\enquote{}` and `\blockquote{}` |
| heading look | latex/humanize.cls:158,26-50; latex/sections/body.tex:1,14,30,38; latex/sections/endpage.tex:7 | `head.titlesec` | `[compact]`; `\titleformat{\section}{\normalfont\Large\bfseries}{\marginsecnumber\thesection}{0pt}{}`, subsection `\large\bfseries`, subsubsection `\normalsize\bfseries`, `\paragraph` and `\subparagraph` with shape `[runin]`; shown when option `protrudelabels` is on (it is, paper.tex:20) |
| number in the left margin | latex/humanize.cls:23-25 | `box.fancybox` | `\makebox[0pt][r]{#1\hspace{6pt}}` inside the titlesec label (kernel LR box family: `\makebox` filed with `\fbox`, no better home in the lib) |
| number gap | latex/humanize.cls:24 | `sp.manual-space` | `\hspace{6pt}` |
| title block | latex/paper.tex:31-37,41 | `front.maketitle` | `\title{\LaTeX\ Essay Template}`, `\author{... \and Institution}`, `\date{\today}`, `\maketitle`; class option `notitlepage` |
| title position | latex/humanize.cls:159,187 | `front.titling` | `\RequirePackage{titling}`, `\setlength{\droptitle}{-2em}` |
| contents | latex/paper.tex:42 | `toc.kernel` | `\tableofcontents` |
| file inclusion | latex/paper.tex:28,44,46 | `struct.input` | `\input{configuration.tex}`, `\include{sections/body.tex}`, `\include{sections/endpage.tex}` |
| quote | latex/humanize.cls:193-198; latex/sections/body.tex:18 | `quote.kernel` | `\renewenvironment{quote}` = `\small\list{}{\rightmargin=\parindent \leftmargin=\parindent}\item\relax` ... `\endlist` |
| quote size and margins | latex/humanize.cls:194 | `font.size-commands` | `\small` |
| quote and list lengths | latex/humanize.cls:194,202 | `sp.lengths` | `\rightmargin`, `\leftmargin`, `\parindent`, `\itemindent` |
| list layout | latex/humanize.cls:160,201-204 | `list.enumitem` | `\setlist[itemize,enumerate,description]{leftmargin=\dimexpr\parindent-\itemindent\relax, noitemsep}` |
| lists in body | latex/sections/body.tex:8-12,24-28 | `list.kernel` | `itemize`, `enumerate` |
| inline marks | latex/sections/body.tex:9,11 | `mark.kernel` | `\textbf`, `\emph` |
| header and footer | latex/configuration.tex:5,8-29,32 | `hf.fancyhdr` | `\fancypagestyle{plain}`: `\fancyhf{}`, head and foot rules 0pt, `\fancyfoot[C]{Page~\thepage~of~\pageref*{LastPage}}`; `\fancypagestyle{fancy}`: `\headrulewidth` 0.4pt, `\fancyhead[L]{LaTeX Template}`, `[R]{Humanize}`, same foot; `\pagestyle{fancy}` |
| page n of m | latex/configuration.tex:6,15,27 | `pgnum.lastpage` | `\usepackage{lastpage}`, label `LastPage` |
| starred page reference | latex/configuration.tex:15,27 | `xref.hyperref` | `\pageref*` (hyperref's starred form; hyperref arrives through `pdfx`) |
| dummy text | latex/configuration.tex:2; latex/sections/body.tex:3,5,16,22,32,36,40,44,48,52 | `draft.todo` | `\usepackage{lipsum}`, `\lipsum[n][a-b]` (filler content) |
| PDF/A and metadata | latex/humanize.cls:207; latex/paper.xmpdata:1-14 | `meta.pdfx` | `[a-3u, mathxmp]`; `.xmpdata` keys `\Author \Title \Language \Keywords \Publisher \Subject \Date \PublicationType \Source \URLlink` (strings) |
| link colours, bookmarks | latex/humanize.cls:210-214 | `meta.hyperref` | `colorlinks=true, allcolors=blue, bookmarksopen=true` |
| URL font | latex/humanize.cls:215; latex/sections/endpage.tex:18 | `meta.url` | `\urlstyle{sf}`, body `\url{}` |
| closing page layout | latex/sections/endpage.tex:14,20-23 | `sp.manual-space` | `\vfill`; `center` environment is `sp.ragged`; `\noindent` is a kernel paragraph-start command with no closer lib line (filed with `sp.lengths`, the paragraph-shape family) |
| centred note | latex/sections/endpage.tex:21-23 | `sp.ragged` | `center` environment |
| no-break span | latex/sections/endpage.tex:22 | `box.fancybox` | `\mbox{plain text}` (kernel LR box) |
| bibliography (off in sample) | latex/configuration.tex:86-87; latex/sections/endpage.tex:1-5; latex/humanize.cls:53-76,119-122 | `bib.biblatex-biber` | `\usepackage[style=ieee]{biblatex}`, `\addbibresource{citations.bib}`, `\nocite{*}`, `\printbibliography[heading=none]`; class adds `\defbibenvironment{ieee-protrusion}`, `\DeclarePrintbibliographyDefaults{env=ieee-protrusion}`, `\SetCiteCommand{\autocite}` only when biblatex is loaded (all commented out in the sample) |
| pgfplots defaults (off in sample) | latex/humanize.cls:124-128 | `art.tikz` | `\pgfplotsset{compat=1.18}`, `\pgfplotsset{samples=300}` only when pgfplots is loaded; global options, nothing is drawn by the template |
| figure snippet: image | latex/figures/template-image.tex:2-7 | `fig.graphicx` | `figure[H]`, `\centering`, `\includegraphics[width=\textwidth]`; `\caption` is `cap.kernel`, `\label` is `xref.kernel`; `[H]` is `fig.float` |
| figure snippet: PDF page | latex/figures/template-pdf.tex:2-13 | `fig.graphicx` | `\includegraphics[page=1,width=0.5\textwidth,angle=0]` inside `\fbox` (`box.fancybox`) |
| algorithm snippet | latex/figures/template-algo.tex:2-27 | `alg.algorithmicx` | `algorithm` + `algorithmic[1]` with `\Function \State \While \Comment` |
| side-by-side snippet | latex/figures/template-algo.tex:38-52 | `box.minipage` | two `minipage{0.50\textwidth}` with `\hfill` (`sp.manual-space`) and `\centering` |
| minted snippet (opt-in, not loaded) | latex/figures/template-algo.tex:30-35,48; latex/configuration.tex:45-46 | `code.minted` | `minted[baselinestretch=1.0, frame=lines, mathescape, fontfamily=helvetica]{python}`; EXTERNAL only if the author enables it (package line commented out, the file is never included) |
| optional extra packages (commented) | latex/configuration.tex:35-83 | `math.amsmath` `thm.amsthm` `math.amssymb` `tbl.booktabs` `tbl.tabularx` `fig.float` `page.geometry` `lang.cjk` | commented-out lines, nothing loaded; `\newgeometry{... includemp, marginparwidth=4cm, marginparsep=0.5cm, hcentering, vcentering, headsep=0.5cm, footskip=1cm}` (configuration.tex:61-76) is `page.geometry` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class `humanize` (whole) | latex/humanize.cls:1-215 | yes | `class.report` plus the `\RequirePackage` list in humanize.cls:150-160,207 and the option-driven calls below; no kernel internals are redefined |
| `\marginsecnumber` | latex/humanize.cls:23-25 | yes | `\newcommand` alias for `\makebox[0pt][r]{#1\hspace{6pt}}`; inline it in the `head.titlesec` label |
| `protrudelabels` option (five `\titleformat`) | latex/humanize.cls:20-51 | yes | five `head.titlesec` `\titleformat` calls with the parameters in the table |
| ieee label-protrusion bib environment | latex/humanize.cls:52-77 | yes (inactive in the sample) | `bib.biblatex-biber` `\defbibenvironment` (biblatex's documented declaration) whose list setup is `\setlength` calls (`sp.lengths`); the `\IfPackageLoadedWithOptionsTF{biblatex}{style=ieee}` test resolves statically when the emitter knows the bibliography way. This is the borderline item: the environment is code, not options, but it only assigns list lengths and prints biblatex fields. |
| `\SetCiteCommand{\autocite}` check | latex/humanize.cls:117-122 | yes (inactive in the sample) | one biblatex line, printed when biblatex is chosen (the command is not defined in the zip; its owning package was not read) |
| pgfplots defaults check | latex/humanize.cls:124-128 | yes (inactive in the sample) | two `\pgfplotsset` lines, printed when pgfplots is chosen |
| spacing options | latex/humanize.cls:6-17 | yes | `sp.setspace` one command |
| `hangingpunct` + `mt-protrusion.cfg` | latex/humanize.cls:82-91; latex/mt-protrusion.cfg:3-31 | yes | microtype's own declarations (`\LoadMicrotypeFile`, `\SetProtrusion` character lists); can be printed in the preamble instead of a `.cfg` file |
| `extraligatures`, `widemargins` | latex/humanize.cls:94-110 | yes | `\defaultfontfeatures+` (`font.fontspec`); `\geometry{pass}` (`page.geometry`) |
| default option block and pass-through | latex/humanize.cls:113-115,132-144 | yes | class options of `class.report` plus the chosen ways |
| `\renewenvironment{quote}` | latex/humanize.cls:193-198 | yes | the kernel's own `\list` pattern with `\small` and two margin lengths: `quote.kernel` with parameters |
| `fancypagestyle` redefinitions | latex/configuration.tex:8-29 | yes | `hf.fancyhdr` calls |
| Makefile (`latexmk -lualatex`, `SOURCE_DATE_EPOCH`, `git log`, `sha256sum`) | makefile:16,23,25 | not a template construct | a build driver that runs the engine; it generates no `.tex` and feeds no values into the document, so it is not `EXTERNAL` under the rubric (the engine need is recorded under Engine) |

## Content-opaque
- pgfplots `axis` picture in figure snippet (latex/figures/template-graph.tex:3-57); tkz-euclide picture in figure snippet (latex/figures/template-tikz.tex:4-20). Both are artwork inside a figure float in files nothing includes.
- Bibliography entries (latex/citations.bib:1-39) and the filler paragraphs are content.
- Not in any lib way and not needed: the README's `betterprotrusionboundary.lua` (README.md:35) is listed but absent from the zip and not referenced by any `.tex`, `.cls` or `.cfg`.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes for the consolidator: `font.libertine` is tagged pdf in the lib, but the package used here (`libertinus-otf`) needs XeLaTeX or LuaLaTeX; the document engine is LuaLaTeX either way. W1 for `libertinus-otf`, `pdfx`, `titlesec`, `titling`, `csquotes`, `enumitem`, `parskip`, `lastpage` and `lipsum` was taken from their being standard CTAN/TeX Live packages, not read from ctan.org page by page (one CTAN read was made, for `humanize`, 404).
