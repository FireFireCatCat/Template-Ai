no

# 0724-xiehao-cuzbeamer: cuzbeamer (Communication University of Zhejiang beamer slides, metropolis based)

- Unverified: read from the source, not compiled.
- Source: Source/0724-xiehao-cuzbeamer/ (origin: https://codeload.github.com/xiehao/cuzbeamer/zip/refs/heads/master; licence: not established in the manifest; README.md:84 says CC BY-SA 4.0, cuzbeamer/cuzbeamer.cls:7-10 says GPL v3 or later)
- Kind: presentation
- Lib: v5
- Engine: needs XeLaTeX (or LuaLaTeX): metropolis and the Chinese sample need it (README.md:65; fontspec/xeCJK branch cuzbeamer/cuzbeamer.cls:106-109); also `-shell-escape` for minted (README.md:65)
- Look carried by: zip-local (the class `cuzbeamer/cuzbeamer.cls` loads `ctexbeamer` plus the `metropolis` theme and sets title-page templates, code, algorithm and TikZ settings; the sample preamble adds only `ccicons` and `framed`)
- Class origin: zip-local
- Main file: demo.tex (other samples: none; it `\input`s initialization.tex)
- Read: main yes, zip-local classes and styles partly (cuzbeamer.cls all 498 lines; tikz-uml.sty lines 1-260 and 5330-5376 read, the other 5100 lines outlined by grep only; initialization.tex all)

## Verdict
no. Every construct of the zip-local class `cuzbeamer` reduces to published ways (ctexbeamer, metropolis, beamer templates, amsmath, tcolorbox, algorithmicx, booktabs): the option machinery resolves at emit time and the helper macros are aliases or wrappers. It is blocked by `minted`: the class loads it by default (`minted` option defaults to true, cuzbeamer.cls:28, loaded at :257-258), the sample uses it (demo.tex:140), and the README says it needs `-shell-escape` and Python pygments (README.md:43-46,65). No ART blocker: the TikZ material is diagram content inside frames.

## Blockers
- `EXTERNAL/package` minted needs shell escape and pygments; loaded under the default `minted=true`, used by `minted` environments and `\mintinline` (cuzbeamer/cuzbeamer.cls:28,257-258; demo.tex:140,149,157,229; README.md:43-46,65)

## Class setting
- Class: `class.ctexbeamer` (loaded by the zip-local wrapper `cuzbeamer`; source of ctexbeamer, beamer and metropolis not in the zip and not read) options: `UTF8,10pt,professionalfont,zihao=false` plus `aspectratio=43|1610|169` passed to beamer from the `pagestyle` option (cuzbeamer.cls:43-50); sample uses `[algorithm,pgfplots,colortheme=light]` of the wrapper (demo.tex:1)
- Class-native vocabulary used: `frame` with options `fragile`, `standout`, `allowframebreaks` and a title argument (demo.tex:15,22,309); `\title` `\subtitle` `\author` `\date` `\maketitle` (initialization.tex:1-5, demo.tex:8); `\titlegraphic` (cuzbeamer.cls:139,141); `\section` `\appendix` `\tableofcontents` (demo.tex:17,20,305); `columns[T,onlytextwidth]` with `\column{w}` and `column{w}` (demo.tex:42-91; cuzbeamer.cls:209-218); `block` `alertblock` `exampleblock` (demo.tex:44,60,76); overlay `\alt<2>{}{}` (demo.tex:145); `\metroset{numbering,background,block}` of metropolis (cuzbeamer.cls:56-60, demo.tex:51); `\setbeamertemplate{section in toc}[sections numbered]` (demo.tex:16); `\setbeamertemplate{title|subtitle|author|date|institute}` with `\inserttitle` family (cuzbeamer.cls:433-496)
- Wrapper options (zip-local, resolved at emit time): `colortheme` `pagestyle` `titlealignment` `minted` `algorithm` `pgfplots` (cuzbeamer.cls:25-30)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | cuzbeamer.cls:50; demo.tex:1 | `class.ctexbeamer` | UTF8, 10pt, professionalfont, zihao=false; unknown options go to beamer (cuzbeamer.cls:31-33) |
| paper/aspect | cuzbeamer.cls:43-49 | `page.class-options` | aspectratio=1610 for pagestyle=wide (the default, sample does not override); 43 or 169 otherwise |
| Chinese support | cuzbeamer.cls:50,108 | `lang.cjk` | ctex through ctexbeamer; xeCJK required explicitly under XeLaTeX |
| theme | cuzbeamer.cls:54 | `slide.beamer-theme` | `\usetheme{metropolis}` |
| theme options | cuzbeamer.cls:56-61; demo.tex:51,67,83 | `slide.beamer-theme` | `\metroset{numbering=fraction}`, `\metroset{background=light}` (sample uses colortheme=light, demo.tex:1; dark is the default), `\metroset{block=fill}` mid-frame |
| footline frame numbers, appendix frame count | cuzbeamer.cls:55,56; demo.tex:305 | `num.appendix` | `appendixnumberbeamer` loaded with no option (CTAN, v1.2.1, J. Lelong, read); `\appendix` in the body; footline `n/N` is metropolis `numbering=fraction` |
| title page templates | cuzbeamer.cls:433-496 | `slide.beamer-template` | `\setbeamertemplate{title,subtitle,author,date,institute}` bodies: `\raggedright` (titlealignment=left default; centering/raggedleft otherwise), `\linespread{1.0}`, `\vspace*{0.5em}`/`{2em}`/`{0.25em}`/`{0.02em}`, author block with email in `\scriptsize\itshape` |
| title alignment, spacing | cuzbeamer.cls:435,441,444,467,472 | `sp.ragged`, `sp.linespread`, `sp.manual-space` | `\raggedright`/`\centering`/`\raggedleft`, `\linespread{1.0}`, `\vspace*` lengths in em |
| title fields | initialization.tex:1-5; demo.tex:8 | `front.maketitle`, `front.class-native` | `\title`, `\date{\today}`, `\author`; beamer `\subtitle`; `\maketitle` as the title frame |
| email line | cuzbeamer.cls:458,470 | `meta.hyperref`, `mark.kernel`, `font.size-commands` | `\href{mailto:..}{\itshape ..}` in `\scriptsize`; `\email` is zip-local (reducible, see Bespoke) |
| title logo | cuzbeamer.cls:133-144; images/*.pdf | `front.class-native`, `fig.graphicx` | `\titlegraphic{\hfill\includegraphics[width=0.28\textwidth]{cuzlogo}}` (cuzlogo-brown for dark); `\graphicspath{{./images/}}` (:227) |
| standout frames | cuzbeamer.cls:152-156; demo.tex:10-13,301-303 | `slide.beamer-theme` | frame option `standout` (metropolis), optional frame title |
| fragile frames | cuzbeamer.cls:160-166; demo.tex:94,125,136,165,215 | `class.ctexbeamer` | `frame[fragile]` (the wrapper adds `environment=fragile`) |
| contents | demo.tex:15-18 | `toc.kernel`, `slide.beamer-template` | `\tableofcontents` in a frame; `\setbeamertemplate{section in toc}[sections numbered]` |
| sectioning | demo.tex:20,39,282,307 | `head.kernel` | `\section{..}` (beamer navigation, metropolis progress bar) |
| columns | demo.tex:42-43,59,75; cuzbeamer.cls:209-218 | `class.ctexbeamer` | `columns[T,onlytextwidth]`, `\column{0.33\textwidth}`; wrapper widths 0.618 and `\textwidth-` left (default, `[0.382]` in the sample) |
| blocks | demo.tex:23,44,52,60,76 | `class.ctexbeamer`, `slide.beamer-theme` | `block`, `alertblock`, `exampleblock` with titles; look set by `block=fill` |
| quote bars | demo.tex:24-35,285-298 | `box.mdframed`, `sp.ragged` | `leftbar` of `framed` (loaded demo.tex:4); `\raggedleft` attribution line |
| lists | demo.tex:45,61,77 | `list.kernel` | `itemize`, `enumerate`, `description` |
| tables | cuzbeamer.cls:225; demo.tex:106-120 | `tbl.tabular`, `tbl.booktabs`, `tbl.multirow`, `font.size-commands` | `table` with `\small`, `tabular{llr}`, `\toprule` `\cmidrule(r){1-2}` `\midrule` `\bottomrule`, `\multirow{2}{*}`, `\multicolumn`; the rules come from booktabs, which `ctable` loads (considered: `ctable`, none of its commands is called) |
| images | demo.tex:96-103 | `fig.graphicx`, `sp.ragged` | `\includegraphics[width=0.65\textwidth]` in `center` inside a block |
| display maths | cuzbeamer.cls:100; demo.tex:128-131 | `math.amsmath`, `math.mathtools`, `math.amssymb` | `align` with `\nonumber`; amsmath, mathtools, amsfonts loaded by the class |
| math font | cuzbeamer.cls:129 | `font.newtx` | `\RequirePackage[libertine,liby,libaltvw]{newtxmath}` (maths only under XeLaTeX) |
| text fonts | cuzbeamer.cls:106; :110-127 commented out | `font.fontspec` | `fontspec` loaded; no `\setmainfont` active (Fira Sans comes from metropolis, source not read); README.md:42 asks for the Ubuntu font although the code is commented out |
| pdfLaTeX branch (not taken) | cuzbeamer.cls:101-104 | `font.fontenc-t1`, `font.newtx` | inputenc utf8, fontenc T1, `newtxtext`; only if neither XeTeX nor LuaTeX |
| code | cuzbeamer.cls:257-292; demo.tex:140-160,229-235 | `code.minted` | `\setminted{autogobble, linenos=true, fontsize=\footnotesize, frame=leftline, framerule=.5pt, numbers=left, numbersep=0em, mathescape=true}`, `\usemintedstyle{xcode}` (light) or `dracula`, `highlightcolor=lightgray` or `darkgray`, `\setmintedinline{fontsize=\normalsize}`; sample keys `escapeinside=@@,beameroverlays`; EXTERNAL |
| code line numbers | cuzbeamer.cls:259-263 | `font.size-commands`, `code.minted` | `\renewcommand{\theFancyVerbLine}{\smaller{\arabic{FancyVerbLine}}}` with `relsize` (:228) |
| overlays in code | demo.tex:145,153,159 | `slide.beamer-mode` | `\alt<2>{\highlightbox{..}}{..}` inside `escapeinside` |
| highlight box | cuzbeamer.cls:229-256 | `box.tcolorbox`, `color.xcolor` | `\newtcbox{\highlightbox}[1][red]{arc=3pt, outer arc=3pt, colback=bg!10!fg, fontupper=\color{bg}, boxrule=.5pt, nobeforeafter, shrink tight, extrude by=2pt, box align=base}`; `bg` and `fg` are beamer colour names (not read) |
| algorithm | cuzbeamer.cls:170-179,418-425; demo.tex:169-179 | `alg.algorithmicx`, `fig.float`, `cap.kernel`, `cap.caption`, `font.size-commands` | `algorithm[H]`, `\caption{#2}`, `algorithmic[1]`; `\algrenewcommand\ALG@beginalgorithmic{\footnotesize}`, `\algorithmiccomment[2][\scriptsize\ttfamily]{{#1\hfill\(\triangleright\) #2}}`, `\captionsetup[algorithm]{font=footnotesize}`; `\Procedure` `\While` `\State` `\Comment` `\EndWhile` |
| labels | demo.tex:176 | `xref.kernel` | `\label{euclidendwhile}` |
| float captions | cuzbeamer.cls:226 | `cap.caption` | package loaded; only the algorithm caption is set (:424) |
| multicolumn text | cuzbeamer.cls:225 | `cols.multicol` | package loaded, no `multicols` in the sample |
| bibliography | demo.tex:187,309-312; references.bib:1-50 | `bib.bibtex-bst` | `\bibliography{references}`, `\bibliographystyle{unsrt}` inside `frame[allowframebreaks]`; `\cite{..}` with 8 keys |
| links | demo.tex:289-294 | `meta.hyperref` | `\href{url}{text}` |
| licence icon | demo.tex:3,296 | `font.icons` | `\usepackage[scale=2]{ccicons}`, `\ccbysa` (CTAN package, not read) |
| inline code font | demo.tex:286 | `mark.kernel` | `\texttt{..}` |
| shared title data | demo.tex:7; initialization.tex | `struct.input` | `\input{initialization.tex}` |
| UML package and settings | cuzbeamer.cls:293-315; tikz-uml.sty | `art.content-package` | `\RequirePackage{tikz-uml}`; `\tikzumlset{font=\bfseries\ttfamily\tiny}` (light) plus `text=white, draw=white, fill class=black!80, fill template=blue!80, fill note=darkgray!100, fill package=black!80` (dark); content only |
| TikZ settings | cuzbeamer.cls:316-417,426-429 | `art.tikz` | `\usetikzlibrary{intersections,through,shapes.geometric,shapes.misc,positioning,calc,arrows,graphs,math}`, `\tikzstyle` node styles `terminal` `nonterminal` `status box` `motion box` `comment box` (text black for light, white for dark), `every picture` += `remember picture`, `pgfplots` with `dateplot` library; used only by diagrams in frames |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option interface (`kvoptions`, `\DeclareStringOption` `\DeclareBoolOption` `\DeclareDefaultOption` `\ProcessKeyvalOptions`) | cuzbeamer.cls:20-37 | yes | The emitter knows the option values; it prints the resolved class load and packages. Unknown options go to beamer (`class.ctexbeamer` options) |
| `\ifxstringequal` alias of etoolbox `\ifstrequal` and its branches on `colortheme`, `pagestyle`, `titlealignment` | cuzbeamer.cls:41-49,57-61,138-142,264-274,295-417,434-496 | yes | Branch chosen at emit time; each branch is `\metroset`, `\usemintedstyle`, `\tikzumlset`, `\tikzstyle`, `\setbeamertemplate` or aspect-ratio lines already in the map |
| platform fontset detection (expl3 reads `\g__ctex_fontset_tl`; flags `\ifcuz@windows` `\ifcuz@mac` `\ifcuz@linux`) | cuzbeamer.cls:65-85 | yes | The flags are read only in commented lines (:113-127), so the block prints nothing; drop it |
| engine detection (`ifxetex`, `ifluatex`, `\ifcuz@pdftex`...) and font branches | cuzbeamer.cls:89-129 | yes | Emitter targets one engine: `font.fontspec` plus `lang.cjk` (xeCJK) for XeLaTeX; the pdfLaTeX branch is `font.fontenc-t1` plus `font.newtx` |
| `\AtBeginDocument` title logo | cuzbeamer.cls:133-144 | yes | `\titlegraphic{..}` line in the preamble, file chosen by `colortheme` |
| `standout` and `fragile` environments | cuzbeamer.cls:152-166 | yes | `\begin{frame}[standout]{t}` and `\begin{frame}[fragile]{t}` (`environment=fragile` only renames the closing tag) |
| `algorithmx` environment (label argument `#1` unused, :173) | cuzbeamer.cls:170-179 | yes | `\begin{algorithm}[H]\caption{..}\begin{algorithmic}[1]..` written by the emitter |
| `\bicolumns` (catcode changes, `\scantokens`, `\cuz@cleanup`, lengths `\cuz@leftwidth` `\cuz@rightwidth`, `calc`) | cuzbeamer.cls:195-221 | yes | Its typeset effect is `columns[T,onlytextwidth]` with two `column`s of width `w\textwidth` and `\textwidth-w\textwidth` (w=0.618 default). The catcode and `\scantokens` code only lets verbatim material sit in macro arguments (comment :181-194); an emitter that writes the environments needs none of it |
| `\QQ` `\Q` | cuzbeamer.cls:290-291 | yes | inline expansion to `"..."` and `'...'` inside code escapes (code text is content) |
| `\email` and title templates | cuzbeamer.cls:458,433-496 | yes | `\gdef\cuz@email` stores a string; the emitter writes it into the author template body |
| `\highlightbox` | cuzbeamer.cls:230-256 | yes | one `\newtcbox` with declarative keys (`box.tcolorbox`) |
| `\algrenewcommand` and `\renewcommand{\theFancyVerbLine}` | cuzbeamer.cls:259-263,420-423 | yes | font-size switches, `\hfill` and a triangle symbol set through the packages' own redefinition commands |
| `tikz-uml.sty` (5376 lines, zip-local copy) | cuzbeamer/tikz-uml.sty:1-5376 | not reduced | Header names the author and a 2016 fix (:6-8) and the README links the author's page (README.md:30); treated as a published content package, a pgfkeys/TikZ drawing library with `\umlclass`-family commands. W1 is not confirmed: ctan.org/pkg/tikz-uml returned 404 in this run. A grep found no `\write18`, `\immediate`, `\openout`, `\input`, `\directlua` or `\catcode` in it. It is used only in a figure (demo.tex:195-210), so it is content-opaque; the verdict is `no` either way |

## Content-opaque
- UML class diagram with tikz-uml commands in a block (demo.tex:195-210)
- state-machine TikZ picture with `\matrix`, `\node`, `\draw` and `\mintinline` labels (demo.tex:218-239)
- pgfplots line chart and bar chart using the metropolis styles `mlineplot` and `mbarplot` (demo.tex:247-255,264-276; styles not in the zip, source not read)
- school logo images (demo.tex:98-101; cuzbeamer/images/*.pdf), code text, the equation (demo.tex:128-131), the algorithm steps (demo.tex:170-178), table cells, `references.bib` entries

## Lib changes
- New ways proposed: `font.size-commands` `relsize` (CTAN, TeX Live; not read in this run, the 3 CTAN reads went to tikz-uml, appendixnumberbeamer and cuzbeamer), pdf, relative font-size switches `\smaller[n]`, `\larger[n]`, `\relsize{n}`, `\textsmaller{}`. W1 CTAN package (by recollection); W2 the step is an integer; W3 any text; W4 a group or argument wrapper. Same type as `font.size-commands` but another package, so the consolidator may merge it there. Used once, around the code line numbers (cuzbeamer.cls:259-263)
- Considered, not proposed: `ctable` (its `\ctable` command is never called; the booktabs rules map to `tbl.booktabs`), `appendixnumberbeamer` (a load-only patch of `\appendix`, mapped to `num.appendix`)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
