no

# 0132-sjtug-sjtubeamer: SJTUBeamer (Shanghai Jiao Tong University beamer theme, SJTUG)

- Unverified: read from the source, not compiled.
- Source: Source/0132-sjtug-sjtubeamer/ (origin: https://codeload.github.com/sjtug/SJTUBeamer/zip/refs/heads/main; licence: Apache-2.0 per manifest and LICENSE; sjtuvi.sty, sjtucover.sty and the vi/ logos carry a separate SJTU copyright, sjtuvi.sty:9-18 and src/doc/sjtubeamerquickstart.tex:8-10; the example text is CC BY-NC-SA 4.0, main.tex:9-13)
- Kind: presentation
- Lib: v3
- Engine: needs XeLaTeX (`% !TeX program = xelatex` main.tex:1; `ctexbeamer` with Chinese text; Makefile:6 builds with `-xelatex`)
- Look carried by: zip-local (the `sjtubeamer` beamer theme: beamerthemesjtubeamer.sty plus colour, font, inner and outer theme files, `sjtuvi.sty`, `sjtucover.sty`; main.tex adds package loads, `\lstset`, hyperref and biblatex settings, documentation helper macros)
- Class origin: tex-distribution-unbundled (`ctexbeamer` from the `ctex` bundle, CTAN and TeX Live, not in the zip; the theme files are zip-local and are styles, not a class)
- Main file: main.tex (other samples: contrib/default/default.tex, contrib/minted/minted.tex, contrib/poster/poster.tex, contrib/sjtug/sjtug.tex, contrib/touying/touying.tex, src/doc/sjtubeamer*.tex; not analysed beyond grep)
- Read: main yes (main.tex and its four `\include`d files contents/introduction.tex, basis.tex, thesis.tex, summary.tex), zip-local classes and styles partly (all seven root `.sty` read in full; the `contrib/*.ltx` plug-ins only by grep outline, the `.dtx` sources, `src/build.lua` and `src/support/` not read)

## Verdict
No. The class is the published `ctexbeamer`, but the look is carried by the `sjtubeamer` theme in the zip. `ctan.org/pkg/sjtubeamer` is a 404, and this zip is the `main` branch snapshot that README_en.md:132 and 141 call the development version ("Code - Download Zip"; releases are listed apart at README_en.md:133, 146), not a tagged release, so under W1 the theme is zip-local. It draws the title page, bottom page, TOC number badges and logos with TikZ overlays and pgf fading masks (`ART/class`) and hand-lays the frame title and the cover machinery on beamer internals (`BESPOKE/class`). The sample's own preamble and body map to lib ways (one proposed, `sp.shapepar`). Sensitivity: if a later ruling counts the SJTUG repository as an official release, the theme becomes a published `slide.beamer-theme` parameter and the verdict would flip to yes; a wrong yes costs more, so it stays `no`.

## Blockers
- `ART/class` maxplus title page is a TikZ overlay: photo node, two filled rectangles and text nodes placed in fractions of `\paperwidth`/`\paperheight` (sjtucover.sty:42-79); active through `\maketitle` (main.tex:155)
- `ART/class` maxplus bottom page: clipped photo, `path fading`, `\sjtugate` badge node, centred thanks text (sjtucover.sty:221-253); active through `\makebottom` (main.tex:196). The `max`/`min` covers and section pages are the same kind (sjtucover.sty:80-116, 127-201, 254-331, 380-516), inactive for `[maxplus]`
- `ART/class` `\stamptext` draws a polygon badge with a `tikzpicture` per TOC section number (sjtuvi.sty:145-168), used by the `section in toc` template (beamerinnerthemesjtubeamer.sty:126-128, 138); active in the TOC frames (main.tex:139, 149, 183)
- `ART/class` stamp pattern, `stampline` decoration, `stampbox`, `\stamphrule` (sjtuvi.sty:173-217, 236-255; beamerinnerthemesjtubeamer.sty:169-203); inactive in the sample (no call)
- `BESPOKE/class` `\definelogo` turns PDF/PNG files into pgf fading masks and defines the logo commands with `\csname`, `\pgfmathparse{notgreater(..)}` (sjtuvi.sty:62-96); the title and bottom pages draw the logo through it (sjtucover.sty:28-33, 72-75)
- `BESPOKE/class` frame-title template for `topright` logos, hand-laid with `\@tempdima`, `\beamer@leftmargin`, `\csname beamer@fte#1\endcsname`, `\if@tempswa` and tuned `\vskip` offsets (beamerouterthemesjtubeamer.sty:41-86); active because `maxplus` sets `topright` (beamerthemesjtubeamer.sty:25-26)
- `BESPOKE/class` cover machinery `\coverpage`/`\definecover` redefines `\titlepage`, `\maketitle`, `\makebottom` and overrides `\beamer@writeslidentry` (beamerinnerthemesjtubeamer.sty:79-117)
- `BESPOKE/class` box-measuring conditional `\IsEmpty` and `\secondaryinstlogo` (vbox/`\prevdepth` layout) (sjtuvi.sty:41-47, 97-144); used by the `min` cover only (sjtucover.sty:157-164), inactive here

## Class setting
- Class: `class.ctexbeamer` options: `xcolor=table,dvipsnames,svgnames,aspectratio=169` (main.tex:19); `fontset=` is only suggested in comments (main.tex:20-23). Source of `ctexbeamer` not read; CTAN page https://ctan.org/pkg/ctex confirms the bundle, the class name is from the bundle's own documentation, not from that page.
- Class-native vocabulary used: `frame` and `frame[fragile]`, `\frametitle` (main.tex:158), `\framesubtitle` (contents/basis.tex:89), `columns[T]`/`columns[c]`, `column`, `\column{.8\textwidth}` (contents/introduction.tex:21-22; contents/basis.tex:101-102), `block`, `alertblock` (contents/introduction.tex:73; contents/basis.tex:117), `\alert` (contents/introduction.tex:256), `\institute[short]` `\subtitle` `\subject` `\keywords` and `\title[short]{long}` (main.tex:123-131), `\AtBeginSection[]` (main.tex:136), `\tableofcontents[currentsection,subsectionstyle=show/show/hide]` and `[hideallsubsections]` (main.tex:139, 183), `\setbeamertemplate{bibliography item}[online]` (main.tex:160), ctex font switches `\songti` `\heiti` (contents/basis.tex:94, 97). Theme-native (zip-local): `\makebottom` (main.tex:196), colours `cprimary` `csecondary` `ctertiary` (main.tex:113, 116-118).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:19 | `class.ctexbeamer` | options above |
| page size | main.tex:19 | `page.class-options` | `aspectratio=169` |
| Chinese typesetting | main.tex:19; contents/basis.tex:94,97 | `lang.cjk` | provided by `ctexbeamer` (ctex, xeCJK); `\songti`, `\heiti`; CJK fonts not shipped (missing assets, note) |
| theme load | main.tex:94 | `slide.beamer-theme` | `\usetheme[maxplus]{sjtubeamer}`; the way covers only the call, the theme `sjtubeamer` is zip-local (see Blockers). Resolved options: cover=maxplus, logopos=topright, red, dark, zh (via `\@ifclassloaded{ctexbeamer}`), nav=miniframes (beamerthemesjtubeamer.sty:25-26, 42, 45, 48-49, 59) |
| inner/outer/colour/font themes | beamerthemesjtubeamer.sty:70-74; beamerouterthemesjtubeamer.sty:88; beamerfontthemesjtubeamer.sty:27-28 | `slide.beamer-theme` | `\useoutertheme[footline=institutetitle]{miniframes}`; `\usefonttheme{professionalfonts}`, `{structurebold}` |
| theme colours | beamercolorthemesjtubeamer.sty:33-86; sjtuvi.sty:55-60 | `color.xcolor`, `slide.beamer-template` | `\definecolor` sjtuRedPrimary RGB 167,32,56, Secondary 240,131,0, Tertiary 253,208,0; `\colorlet` cprimary/csecondary/ctertiary/cquanternary(black); `\setbeamercolor` palette primary/secondary/tertiary (bg=cprimary, fg=white, dark mode), block title `bg=cprimary!90`, frametitle bg=white fg=titlelike.fg, etc. |
| theme fonts | beamerfontthemesjtubeamer.sty:29-32 | `slide.beamer-template` | `\setbeamerfont` part/section/subsection name `size=\normalsize`, footnote `size=\footnotesize` |
| frame title | beamerouterthemesjtubeamer.sty:41-86 | `slide.beamer-template` + BESPOKE | `\defbeamertemplate*{frametitle}{sjtubeamer}` with logo at right; not a way, see Blockers |
| footline and logo | beamerouterthemesjtubeamer.sty:114-142 | `hf.class-native`, `slide.beamer-template`, `sp.manual-space` | `\addtobeamertemplate{navigation symbols}` frame number/total; footline `\hfill`, `\llap{\raisebox{1pc}...{\insertlogo}}` for bottomright (not active), `\vskip 4pt` |
| title page | sjtucover.sty:42-79; main.tex:155 | `front.maketitle` + ART | kernel `\title \author \date \maketitle`; the page itself is `ART/class` |
| front-matter fields | main.tex:122-131 | `front.maketitle`, `front.class-native` | `\author`, `\date{\the\year 年 \the\month 月}`, `\institute[SJTUG]{...}`, `\subject`, `\keywords`, `\title[short]{...}`, `\subtitle` |
| bottom page | sjtucover.sty:221-253; main.tex:196 | ART | `\makebottom`, text `\bottomthanks` = 谢\,谢 (sjtucover.sty:213-217) |
| contents frames | main.tex:136-153, 182-184 | `slide.beamer-section-hook`, `toc.kernel` | `\AtBeginSection[]`/`\AtBeginSubsection[]` frames with `\tableofcontents[currentsection,subsectionstyle=show/show/hide]` and `show/shaded/hide`; frame `\tableofcontents[hideallsubsections]` |
| TOC entry look | beamerinnerthemesjtubeamer.sty:126-138 | `slide.beamer-template` + ART | `sections/subsections in toc` = `stamp` template (stamp badge, `\leftskip=8mm`, `\hspace{36mm}`) |
| sectioning | contents/introduction.tex:16,18; basis.tex:16-17; thesis.tex:16-17; summary.tex:16 | `head.kernel` | `\section`, `\subsection` (visible only through the section hooks) |
| lists | beamerinnerthemesjtubeamer.sty:121-125; contents/introduction.tex:23-43 | `list.kernel`, `sp.lengths`, `slide.beamer-template` | `itemize` nested to level 2, `enumerate`, `description`; `\setbeamertemplate{items}[circle]`, `\leftmargini/ii/iii=1.4em`, `\setbeamersize{description width=0.72em}` |
| blocks | contents/introduction.tex:73-87; beamerinnerthemesjtubeamer.sty:162-164 | `class.ctexbeamer` (native), `slide.beamer-template` | `block`, `alertblock`; `\setbeamertemplate{blocks}[rounded]` (not for `min`) |
| columns | contents/introduction.tex:21-48; contents/basis.tex:101-112 | `class.ctexbeamer` (native) | `columns[T]`, `\column{.8\textwidth}`, `\begin{column}{.45\textwidth}`, `\hspace{1em}` |
| equations | contents/introduction.tex:74-102 | `math.amsmath` | `equation*`, `align` with `\nonumber`, `multline`, `\label`, `\left\right`, `\mathrm` |
| tables | contents/introduction.tex:53-69; basis.tex:120-134, 425-429; thesis.tex:118-131 | `tbl.tabular`, `tbl.booktabs`, `sp.ragged`, `font.size-commands` | `tabular{c|c}` with `\hline`; `tabular{cl}` with `\toprule \midrule \bottomrule`; `\multicolumn`; `\centering`, `\footnotesize` |
| table colour package | main.tex:19, 31 | `tbl.colortbl` | `colortbl` plus class option `xcolor=table`; no `\rowcolor` or `\cellcolor` is called |
| figures | contents/introduction.tex:210-213, 233-236; thesis.tex:30-36 | `fig.graphicx`, `box.fancybox` | `figure[h]`, `\centering`, `\includegraphics[width=.8\textwidth]`; `\graphicspath{{figures/}}` (main.tex:48); `\setlength{\fboxsep}{0pt}` + `\fcolorbox{black}{white}{...}` (thesis.tex:33-34) |
| minipage | contents/basis.tex:158-179, 382-398 | `box.minipage` | `minipage{0.4\linewidth}`, `\hspace{1.5cm}`, `\hfill` |
| footnotes | contents/basis.tex:59, 154 | `fn.kernel` | `\footnote`; colour/font from the theme (beamercolorthemesjtubeamer.sty:76) |
| multicolumn list | contents/basis.tex:505-593 | `cols.multicol` | `multicols{3}` (package main.tex:37) |
| cross-references | contents/basis.tex:227, 431; contents/introduction.tex:95 | `xref.kernel` | `\label{eq:vsphere}`, `\ref`, `\label{eq:reset}` |
| code listings | main.tex:35, 111-120; contents/basis.tex:74-85; contents/introduction.tex:326-329 | `code.listings` | `\lstset{language=[LaTeX]TeX, texcsstyle=*\color{cprimary}, tabsize=2, basicstyle=\ttfamily\small, keywordstyle=\color{cprimary}, stringstyle=\color{csecondary}, commentstyle=\color{ctertiary!50!gray}, breaklines}`; `lstlisting[language=bash]`, `[basicstyle=\ttfamily]`, `morekeywords` |
| inline code | contents/basis.tex:56-57; contents/introduction.tex:300-301 | `code.verbatim` | `\verb` in `fragile` frames |
| theme code blocks | beamerinnerthemesjtubeamer.sty:231-266, 272-297 | `code.listings`, `code.tcblisting`, `box.tcolorbox` | `\newtcblisting{codeblock}`, `\newtcbinputlisting{\codeblockinput}`: `listing engine=listings`, `numbers=left`, `colback=cprimary!5`, `colframe=cprimary!80`, `sharp corners`, `overlay` gutter fill; not called by the sample |
| bibliography | main.tex:44-45, 191-194; contents/basis.tex:500-501 | `bib.biblatex-biber` | `biblatex[backend=biber,style=gb7714-2015]`, `\addbibresource{ref.bib}`, `\cite`, `\printbibliography[heading=none]` |
| hand-written source list | main.tex:159-165 | `bib.thebibliography`, `slide.beamer-template` | `thebibliography{00}` with `\bibitem{}`, `\newblock`, `bibliography item` = `online` |
| hyperlinks and metadata | main.tex:40, 50-62 | `meta.hyperref`, `meta.hyperxmp` | `hyperref`; `\hypersetup{pdfcopyright, pdflicenseurl, unicode=true, psdextra=true, pdfdisplaydoctitle=true}`; `\pdfstringdefDisableCommands{\let\\\relax, \let\quad\relax, \let\hspace\@gobble}`; `hyperxmp` (main.tex:33); `\url`, `\href`, `\nolinkurl` (hyperref commands) |
| date package | main.tex:38 | `front.datetime` | `datetime2` loaded, no `\DTM...` call (the date is `\the\year`, `\the\month`) |
| icons and logos | main.tex:30, 39, 64-77, 86; contents/summary.tex:129 | `font.icons` | `fontawesome5` (`\faLink`, `\faWindows`, `\faGithub`); `hologo` (`\hologo{TeX}`, `\hologo{LaTeX}`, `\hologo{Xe}`) |
| strike-out | main.tex:26; contents/summary.tex:144, 168 | `mark.ulem` | `ulem[normalem]`, `\sout` |
| marks and sizes | main.tex:87-92; contents/basis.tex:240-243 | `mark.kernel`, `font.size-commands`, `color.xcolor`, `sp.manual-space` | `\texttt`, `\textbf`, `{\bf ..}`, `\emph`, `\textsc`; `\footnotesize`, `\small`; `\color{red}` (contents/introduction.tex:216); `\hspace{1em}`, `\vskip1em`, `\bigskip`, `\medskip`, `\\[1em]` |
| shaped paragraph | main.tex:32; contents/introduction.tex:217-225 | `sp.shapepar` | `\heartpar{\footnotesize ...}` in a column, `\color{red}` before it |
| mode switch | beamerthemesjtubeamer.sty:70 | `slide.beamer-mode` | `\mode<presentation>`; `\only` inside `\highlight` (beamerinnerthemesjtubeamer.sty:165-167) |
| diagram packages | main.tex:25, 27 | `art.tikz` | `tikz` with `arrows` library; `\tikzexternalize` is commented out (main.tex:108), so no shell escape is needed |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\DefineOption`, `\EqualOption`/`\ifEqualOption`, `\PassOptionsToPackage` plumbing | sjtuvi.sty:25-40; beamerthemesjtubeamer.sty:25-69 | yes for this sample only | options are fixed (maxplus, red, dark, zh, miniframes, topright), so every `\if\EqualOption...` resolves to a constant branch; emit the resolved lines. This does not make the theme a way |
| colour theme | beamercolorthemesjtubeamer.sty:25-86 | yes | `color.xcolor` + `slide.beamer-template` with the resolved values in the map |
| font theme (`silence` `\WarningFilter`) | beamerfontthemesjtubeamer.sty:25-32 | yes | two `\usefonttheme`, four `\setbeamerfont`; `\WarningFilter{latexfont}{Font shape}` only filters the log, dropped |
| `\usesjtutheme` plug-in loader | beamerthemesjtubeamer.sty:75-93 | yes by omission | never called by main.tex (grep: no `\usesjtutheme`); not needed for this sample |
| outer theme footline and navigation symbols | beamerouterthemesjtubeamer.sty:114-142 | yes (judgement) | beamer templates built from `\hfill`, `\raisebox`, `\insertframenumber/\inserttotalframenumber` |
| frame-title template | beamerouterthemesjtubeamer.sty:41-86 | no | hand-laid box code on beamer internals with measured `\vskip` offsets; `BESPOKE/class` |
| cover machinery `\coverpage`, `\definecover` | beamerinnerthemesjtubeamer.sty:79-117 | no | overrides `\beamer@writeslidentry` and `\titlepage`; `BESPOKE/class` |
| `\definelogo` logo masks | sjtuvi.sty:62-96 | no | pgf fading from picture, command definitions by `\csname`; `BESPOKE/class` |
| title, bottom, section covers | sjtucover.sty:42-79, 80-116, 127-201, 221-331, 380-516 | no | TikZ overlays, `ART/class` |
| `\stamptext`, stamp pattern, `stampline`, `stampbox`, `\stamphrule`, `stampblock` | sjtuvi.sty:145-255; beamerinnerthemesjtubeamer.sty:169-228 | no | TikZ polygon, `\tikzdeclarepattern`, `\pgfdeclaredecoration`; `ART/class` |
| `\IsEmpty`, `\secondaryinstlogo` | sjtuvi.sty:41-47, 97-144 | no | box measuring and hand-set vbox layout; inactive for `[maxplus]` |
| `\ifbeamercolorwhite` | sjtucover.sty:427-438 | no | reads beamer internals (`\beamer@thc@docolor`); used by the `max` cover only |
| `bibliolist` env, `\articleitem` `\bookitem` `\onlineitem` | beamerinnerthemesjtubeamer.sty:139-161 | no | overrides `\item` and uses `\beamer@newblock`; not called by the sample |
| `codeblock`, `\codeblockinput`, `\highlight`, `\highlightline`, `\paragraph` fallback | beamerinnerthemesjtubeamer.sty:165-168, 242-297 | yes | `code.tcblisting`/`box.tcolorbox` keys; `\only<..>{\textcolor{white}{\colorbox{..}}}` (`slide.beamer-mode`, `color.xcolor`); `\rlap{\color..\rule[-\dp\strutbox]{\linewidth}{\baselineskip}}` (`sp.rule`) |
| pgfplots / pgfplotstable defaults in `\AtEndPreamble` | beamerinnerthemesjtubeamer.sty:298-361 | partly | `\pgfplotsset` keys are declarative (`art.tikz` settings); `\colorrows`/`\zapcolorreset` with `\aftergroup` (337-338) is a hand-rolled hack. Both inactive: main.tex does not load pgfplots |
| `\Hy@WarnOptionDisabled` override | beamerinnerthemesjtubeamer.sty:367-378 | yes by omission | it only changes which hyperref warnings print |
| `\cmd`, `\env`, `\cmdxmp`, `\link`, `\pkg` | main.tex:86-92 | yes | `\texttt{\color{structure}\footnotesize $\backslash$#1}`, `\href{#1}{\faLink}`, `\texttt` (`mark.kernel`, `color.xcolor`, `font.size-commands`, `font.icons`, `meta.hyperref`, `sp.manual-space`) |
| `\renewcommand{\TeX}` ... `\LuaLaTeX`, `\TeXLive`, `\TL`, version strings | main.tex:64-84 | yes | aliases of `\hologo{..}` (`font.icons`) and fixed strings |
| `\SJTUBeamer`, `\SJTUThesis` | main.tex:79-84 | yes | `\textsc{..}` aliases (`mark.kernel`) |

## Content-opaque
- two TikZ pictures (3D cone, line junctions) in frames, contents/introduction.tex:108-204 (`art.tikz`)
- IPA transcriptions `\textipa{..}` from `tipa`, contents/introduction.tex:24-25, 35, `tipa` loaded at main.tex:36 (`art.content-package`, linguistics)
- lstlisting demo code, lorem ipsum, bibliography entries (ref.bib), figure images (figures/*.pdf, *.jpg, *.png)

## Lib changes
- New ways proposed: `sp.shapepar` `shapepar` (CTAN, TeX Live; Donald Arseneau, v2.2; page read https://ctan.org/pkg/shapepar): `\shapepar{<shape>}` and predefined shapes such as `\heartpar{text}` typeset one paragraph in a shape, scaling the text to fill it; engine `pdf` (not verified). W1: on CTAN. W2: the shape is chosen by a macro name and the paragraph text, no code is edited. W3: serves any paragraph, not one document. W4: a body wrapper around the paragraph. No existing way fits: `sp.lengths` takes lengths, `fig.wrapfig` wraps text round floats, `box.minipage` sets a width.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
