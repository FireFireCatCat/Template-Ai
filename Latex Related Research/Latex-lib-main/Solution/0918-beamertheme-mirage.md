yes

# 0918-beamertheme-mirage: Mirage beamer and ltx-talk theme (beamertheme-mirage v1.2)

- Unverified: read from the source, not compiled.
- Source: Source/0918-beamertheme-mirage/ (origin: https://mirrors.ctan.org/macros/latex/contrib/beamer-contrib/themes/beamertheme-mirage.zip; licence: lppl1.3c)
- Kind: presentation
- Lib: v6
- Engine: pdfLaTeX-compatible (main sample, by the author's statement at beamertheme-mirage-doc.tex:67; the zh samples, `mirage-poster-zh.tex` and the doc sample need XeLaTeX: ctexbeamer, unicode-math, xeCJK; the talk sample is not XeLaTeX, mirage-talk.tex:13)
- Look carried by: mixed (colours, rounded blocks, gradient headline rule, glowing footline and `pullquote` come from the published CTAN theme `beamerthemeMirage.sty` (ctan.org/pkg/beamertheme-mirage: beamer-contrib/themes, TeX Live, LPPL 1.3c, read); fonts, `beamerposter`, biblatex and poster tweaks come from the samples' preambles)
- Class origin: tex-distribution-unbundled
- Main file: mirage-beamer-en.tex (other samples: mirage-beamer-zh.tex, mirage-poster-en.tex, mirage-poster-zh.tex, mirage-talk.tex, beamertheme-mirage-doc.tex; the manifest's `main` is the doc file, an article that only documents the theme, so the beamer sample is taken as main)
- Read: main yes (all six .tex files read in full), zip-local classes and styles all (`beamerthemeMirage.sty` 166 lines, `talkthemeMirage.sty` 233 lines; both are the CTAN package itself, not zip-local by the rubric)

## Verdict
Yes, but the yes rests on one ruling. `beamerthemeMirage.sty` and `talkthemeMirage.sty` are the files of the CTAN package `beamertheme-mirage` (the zip is its CTAN release), so they pass W1 and `\usetheme[light]{Mirage}` is the existing way `slide.beamer-theme` with the theme name and `light` as parameters, as the lib already treats `talkthemetcolorbox`. The samples add only font packages, `beamerposter`, biblatex, length and beamer colour/font settings, and a few redefinitions that all reduce to lib ways. No new way is needed. The pgf/tikz artwork and `regexpatch` patches inside the theme (`beamerthemeMirage.sty:35-37`, `:98-118`, `:123-147`) would be `ART/class` and `BESPOKE/class` blockers if the theme were rebuilt from lib ways instead of loaded as the published package; they are not counted because the theme is published.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `aspectratio=1610` (mirage-beamer-en.tex:1; `mirage-poster-en.tex:1` has none). Also `class.ctexbeamer` options `aspectratio=1610,linespread=1.4,t` (mirage-beamer-zh.tex:2) and `linespread=1.4` (mirage-poster-zh.tex:3); `class.ltx-talk` option `font-size=12pt` (mirage-talk.tex:7; ctan.org/pkg/ltx-talk read: class, TeX Live, LPPL 1.3c, needs LaTeX 2025-11-01); `class.article` (beamertheme-mirage-doc.tex:1). None of these class sources is in the zip and none was read.
- Class-native vocabulary used: beamer `frame` with `[c]` and `[allowframebreaks]` (mirage-beamer-en.tex:73,103), `\frametitle`, `\frame{\maketitle}`, `\title \subtitle \author \institute \date` (mirage-beamer-en.tex:17-21,43), `\section`, `columns`/`column[T]{w}` (mirage-beamer-en.tex:75-93), `block` `exampleblock` `alertblock`, `theorem` `proof` `definition` (mirage-beamer-en.tex:105-127), `\alert` (mirage-beamer-en.tex:69), `\setbeamercolor` `\setbeamerfont` `\addtobeamertemplate`; ltx-talk `\maketitle[framestyle = wallpaper]` (mirage-talk.tex:30); ctexbeamer `\ccwd` (mirage-beamer-zh.tex:84).
- Theme-native vocabulary (beamerthemeMirage v1.2, published): option `light` (beamerthemeMirage.sty:8); environment `pullquote` (:82-92); strings `\MiragePullquoteOpen` `\MiragePullquoteClose` `\MirageFrametitlePrefix` `\MirageProofPrefix` `\MirageTheoremPrefix` `\MirageFootlineContents` (:60-61,80-81,128,161); length `\MirageGlowRadius` (:129-130); colours `MirageGray0..3` `MiragePink` `MirageBlue` (:15-20); beamer colour and font name `pullquote` (:75-79). Talk theme: options `light` `dark` (talkthemeMirage.sty:6-7), colour names `mirage@*` (:27-60).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | mirage-beamer-en.tex:1 | `class.beamer` | aspectratio=1610 |
| page size | mirage-beamer-en.tex:1 | `page.class-options` | aspectratio=1610 (16:10 slide) |
| theme | mirage-beamer-en.tex:9-10 | `slide.beamer-theme` | theme=Mirage, option `light` (default is dark, `:9`); the theme itself calls `\usetheme[compress]{Singapore}` (beamerthemeMirage.sty:38) |
| colour palette | beamerthemeMirage.sty:15-20 | `color.xcolor` | six RGB colours (30,30,30; 48,48,48; 140,140,140; 60,66,71; 212,183,183; 156,185,220); carried by the theme |
| colour roles and canvas | beamerthemeMirage.sty:22-33 | `slide.beamer-template` | `\setbeamercolor` normal text (bg and fg), structure, item, alerted text, section and page number in head/foot; dark or light set chosen by `light` |
| blocks look | beamerthemeMirage.sty:39-58 | `slide.beamer-template` | `\setbeamertemplate{blocks}[rounded]`, block title font family rm series bold, block/example/alerted title and body colours |
| navigation symbols off, item markers, continuation titles | beamerthemeMirage.sty:95-97 | `slide.beamer-template` | `itemize items`=circle, `navigation symbols` empty, `frametitle continuation`=from second |
| headline gradient rule | beamerthemeMirage.sty:98-118 | `slide.beamer-theme` | published theme internals (pgf vertical shading, four colour stops); no sample parameter |
| footline glow, rule and frame count | beamerthemeMirage.sty:123-147 | `slide.beamer-theme` | published theme internals; parameters `\MirageGlowRadius` (length, mirage-poster-en.tex:35, commented at mirage-beamer-en.tex:13) and `\MirageFootlineContents` (string, mirage-poster-en.tex:74) |
| frame title look | beamerthemeMirage.sty:149,159,161-165 | `slide.beamer-template` | frametitle template [default][left], font family rm size Large series bold, prefix glyph `\MirageFrametitlePrefix` (a `font.icons` command, `\faBorderTopLeft`) |
| frame title font and letterspace | beamerthemeMirage.sty:150-158 | `sp.microtype` | pdfLaTeX branch `letterspace=50` and `\lsstyle` (`:154-155`); XeLaTeX/LuaLaTeX branch `\addfontfeatures{LetterSpace=5}` is `font.fontspec` (`:152`) |
| icons | beamerthemeMirage.sty:12; mirage-beamer-en.tex:15 | `font.icons` | `fontawesome7` option `fixed`; glyph names are commands |
| relative sizes | beamerthemeMirage.sty:13,65,70,164 | `font.size-commands` | `relsize` with `\relsize{-1}` |
| title block | mirage-beamer-en.tex:17-21,43 | `front.class-native` | title, subtitle, author, institute, date as strings; `\frame{\maketitle}` |
| sections | mirage-beamer-en.tex:45,97 | `head.class-native` | `\section{Introduction}`, `\section{Blocks}` |
| frame titles | mirage-beamer-en.tex:48,62,74,103 | `head.class-native` | `\frametitle{..}` and `\begin{frame}[allowframebreaks]{title}` |
| unordered list | mirage-beamer-en.tex:51-58 | `list.kernel` | two nested `itemize` levels |
| ordered list | mirage-beamer-en.tex:63-70 | `list.kernel` | two nested `enumerate` levels |
| alerted text | mirage-beamer-en.tex:69 | `slide.beamer-template` | `\alert{..}`, colour `alerted text` set at beamerthemeMirage.sty:31 |
| columns | mirage-beamer-en.tex:75-93 | `cols.minipage` | beamer `columns` with `column[T]{.4\textwidth}` and `{.5\textwidth}` |
| pullquote | mirage-beamer-en.tex:77-91 | `slide.beamer-theme` | theme-native environment; `\setbeamercolor{pullquote}{fg=MirageBlue}` (`:84`) is `slide.beamer-template`; `\renewcommand{\MiragePullquoteOpen}{«}` (`:85`) is a string; quote glyph `\faQuoteLeft` is `font.icons` (beamerthemeMirage.sty:80) |
| block, exampleblock, alertblock | mirage-beamer-en.tex:105-115 | `slide.beamer-template` | beamer block environments with a title argument; look set at beamerthemeMirage.sty:39-58 |
| theorem, proof, definition | mirage-beamer-en.tex:117-127 | `thm.class-native` | beamer's own theorem and proof environments; title prefix glyphs `\MirageTheoremPrefix` `\MirageProofPrefix` added by `\addtobeamertemplate` (beamerthemeMirage.sty:63-71) |
| display and inline maths | mirage-beamer-en.tex:106,110,114 | `math.kernel` | `$..$`, `\[ \]`, `\frac`, `\sqrt`, `\pm`; `\therefore` is `math.amssymb` |
| sans text face | mirage-beamer-en.tex:26 | `font.helvet` | `carlito` with `lining,tabular` |
| serif text face | mirage-beamer-en.tex:27 | `font.serif-pkg` | `caladea` |
| pdfLaTeX maths face | mirage-beamer-en.tex:36-37 | `font.fontenc-t1` | `[T1]{fontenc}`; `newtxsf` (sans maths, the type of `sfmath`) is `font.helvet` |
| XeLaTeX/LuaLaTeX maths face | mirage-beamer-en.tex:29-34 | `font.unicode-math` | `unicode-math`, `\setmathfont{Fira Math}`; branch taken only under XeTeX or LuaTeX |
| zh class and CJK | mirage-beamer-zh.tex:2 | `lang.cjk` | `ctexbeamer` (`class.ctexbeamer`) supplies the CJK support; XeLaTeX |
| zh maths face | mirage-beamer-zh.tex:32-35 | `font.unicode-math` | `\setmathfont{Fira Math}` |
| poster class and sheet | mirage-poster-en.tex:1,3 | `poster.baposter` | `beamerposter` size=a3, orientation=portrait, scale=1.4 over `class.beamer` |
| poster headline and footline sizes | mirage-poster-en.tex:28-29,47-48 | `slide.beamer-template` | `\setbeamerfont` headline `\huge`, footline `\large`, title `\Huge`, author `\large` |
| poster head/foot colours | mirage-poster-en.tex:38-46 | `slide.beamer-template` | `\setbeamercolor{section in head/foot}` and `{page number in head/foot}` with fg values per mode |
| poster headline spacing | mirage-poster-en.tex:50 | `slide.beamer-template` | `\addtobeamertemplate{headline}{}{\vspace*{1ex}}` |
| poster list indents | mirage-poster-en.tex:64-65 | `sp.lengths` | `\leftmarginii`=1.75em, `\leftmarginiii`=2.5em |
| poster glow size and footline text | mirage-poster-en.tex:35,74 | `sp.lengths` | `\setlength{\MirageGlowRadius}{0.5ex}`; footline string by `\renewcommand` |
| poster bibliography | mirage-poster-en.tex:68-69,164-169 | `bib.biblatex-biber` | `style=numeric,natbib`, `\addbibresource{sample-refs.bib}`, `\printbibliography[heading=none]`; `\bibfont`=`\small` (`font.size-commands`), `\bibitemsep` and `\biblabelsep` (`sp.lengths`) |
| poster bibliography colours | mirage-poster-en.tex:30-34 | `slide.beamer-template` | five `\setbeamercolor{bibliography ..}` with fg=`block body.fg` |
| poster citation | mirage-poster-en.tex:155 | `bib.biblatex-biber` | `\citep{..}` from the `natbib` option |
| poster image, URL, spacing | mirage-poster-en.tex:156,159,117,162 | `fig.graphicx` | `\includegraphics[width=0.95\hsize]{miragesup.png}` in `center`; `\url` is `meta.url`; `\bigskip` `\vfill` are `sp.manual-space` |
| poster-zh line spread | mirage-poster-zh.tex:3,147,157 | `sp.linespread` | class option `linespread=1.4`; `\linespread{1}\selectfont` locally |
| talk class and metadata | mirage-talk.tex:1-7 | `meta.documentmetadata` | `lang=en, pdfstandard=ua-2, tagging=on, tagging-setup={math/setup=mathml-SE}`; class `class.ltx-talk` font-size=12pt |
| talk theme | mirage-talk.tex:8 | `slide.beamer-theme` | `\usepackage[light]{talkthemeMirage}` (an ltx-talk theme, the case named in the lib line); internals load `talkthemetcolorbox` with `blocks,rounded,titlepage=false` (talkthemeMirage.sty:16) |
| talk title and frames | mirage-talk.tex:22-26,30,34 | `front.class-native` | `\maketitle[framestyle = wallpaper]`, `\frametitle` (`head.class-native`) |
| talk fonts | mirage-talk.tex:10-11,14-21 | `font.serif-pkg` | `caladea`; `carlito` `lining,tabular,sfdefault` is `font.helvet`; branch Fira Math or `newtxsf` as in the main sample |
| talk pullquote | mirage-talk.tex:62-72 | `slide.beamer-theme` | theme-native `\NewTColorBox{pullquote}` (talkthemeMirage.sty:202-233); `\colorlet{mirage@pullquote}{MirageBlue}` (`:67`) is `color.xcolor`; `\raggedright` (`:69`) is `sp.ragged` |
| talk display skip | mirage-talk.tex:91,96 | `sp.lengths` | `\abovedisplayshortskip`=-1em |
| doc: class and fonts | beamertheme-mirage-doc.tex:1-5 | `class.article` | xeCJK (`lang.cjk`), carlito (`font.helvet`), caladea (`font.serif-pkg`), microtype (`sp.microtype`) |
| doc: title block | beamertheme-mirage-doc.tex:6-8,19-24 | `front.titling` | `\pretitle{\begin{center}\LARGE\bfseries}`, `\posttitle{\par\end{center}}`; fields by `front.maketitle` |
| doc: page | beamertheme-mirage-doc.tex:9 | `page.geometry` | a4paper, columnsep=3em, margin=0.5in, footskip=2em |
| doc: two-language columns | beamertheme-mirage-doc.tex:11,26-38 | `cols.paracol` | `paracol{2}`, `\switchcolumn`, `\switchcolumn*` |
| doc: abstract | beamertheme-mirage-doc.tex:27-37 | `abs.kernel` | `abstract` twice, `\abstractname` set to 摘要 (`:34`) |
| doc: verbatim, logos | beamertheme-mirage-doc.tex:10,12,60-62 | `code.verbatim` | `fancyvrb` `BVerbatim`, `\verb`; `hologo` is `font.icons` |
| doc: lists | beamertheme-mirage-doc.tex:15-16,128-147,175-181 | `list.enumitem` | `\setlist{leftmargin=*}`, `[nosep]`; `itemize` and `description` bodies are `list.kernel` |
| doc: links | beamertheme-mirage-doc.tex:17,29 | `meta.hyperref` | `colorlinks`, `\href`; `\url` is `meta.url` |
| doc: sections, boxes, images | beamertheme-mirage-doc.tex:46,75,78 | `head.kernel` | `\section`; `\setlength{\fboxsep}{0pt}` (`sp.lengths`), `\fbox` (`box.fancybox`), `\includegraphics[page=n,width=.49\hsize]` (`fig.graphicx`) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\insertnavigation` redefinition (title and author in the poster headline) | mirage-poster-en.tex:52-60; mirage-poster-zh.tex:43-51 | yes (weakest point) | `\renewcommand*` of a documented beamer insert; body is `\centering` (`sp.ragged`), `\usebeamerfont{title}` / `{author}` with `\insertshorttitle` / `\insertshortauthor[width=0.95\hsize,respectlinebreaks,center]` (`slide.beamer-template` inserts), `\vspace*{0.5ex}` (`sp.manual-space`); the emitter prints the same line in the preamble. Poster samples only, not the main sample |
| `\ifMirage@light` branch | mirage-poster-en.tex:38-46; mirage-poster-zh.tex:29-37 | yes | picks one of two `\setbeamercolor` pairs; the emitter knows whether it wrote `[light]` and prints one branch (`slide.beamer-template`) |
| engine switch `\ifboolexpr{bool{xetex} or bool{luatex}}` | mirage-beamer-en.tex:23,29-38; mirage-poster-en.tex:9,15-24; mirage-talk.tex:14-21 | yes | published `iftex` and `etoolbox`; the emitter picks the target engine and prints one branch (`font.unicode-math` or `font.fontenc-t1` plus `font.helvet`) |
| `\foreach` loops of `\includegraphics[page=\n]` | beamertheme-mirage-doc.tex:78,84 | yes | published `pgffor` loop; unroll to six `\includegraphics` calls (`fig.graphicx`, `box.fancybox`); images are content |
| `\renewcommand{\MiragePullquoteOpen}` and `\setbeamercolor{pullquote}` overrides | mirage-beamer-en.tex:84-85; mirage-beamer-zh.tex:83-84; mirage-poster-en.tex:119-120; mirage-talk.tex:67-68 | yes | values for published theme parameters: a glyph or string, a colour |
| theme internals: `\xpatchcmd` and `\pretocmd` on `\beamerboxesrounded` | beamerthemeMirage.sty:35-37 | not counted: published (CTAN) | if rebuilt without the theme: irreducible `BESPOKE/class` (patches beamer internals, no declarative way) |
| theme internals: headline shading and footline glow (pgf `pgfdeclareverticalshading`, tikz `circular glow`, `path fading`) | beamerthemeMirage.sty:98-118,123-147; talkthemeMirage.sty:66-96,107-123 | not counted: published (CTAN) | if rebuilt without the theme: `ART/class`, template-defining artwork with no declarative lib way |
| theme internals: `pullquote` environment | beamerthemeMirage.sty:82-92; talkthemeMirage.sty:202-233 | not counted: published (CTAN) | the beamer version is a composition of `beamercolorbox`, `\hrule`, `\raisebox` and a `font.icons` glyph; the ltx-talk version adds tagging commands |
| theme internals: option and conditionals, `\AddToHook` hooks, `\EditInstance` edits | beamerthemeMirage.sty:7-9,132-139,150-157; talkthemeMirage.sty:5-12,155-188 | not counted: published (CTAN) | internal to the published theme |

## Content-opaque
none that no lib way can hold. Content only: `miragesup.png` (mirage-poster-en.tex:156), PDF pages of the sample decks (beamertheme-mirage-doc.tex:41-42,78,84,103,109), entries of `sample-refs.bib`, and the filler text, equations and Chinese text of every sample.

## Lib changes
- New ways proposed: none. Considered and not proposed: a `quote.pullquote` way (the `pullquote` environment is theme vocabulary, carried by `slide.beamer-theme`), and a patching way for `etoolbox`/`regexpatch` (patching edits code, so W2 fails).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
