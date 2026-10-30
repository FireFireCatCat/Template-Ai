no

# 0674-greenpark-buaa-beamer: GreenPark BUAA Beamer (`gpark` theme on `ctexbeamer`)

- Unverified: read from the source, not compiled.
- Source: Source/0674-greenpark-buaa-beamer/ (origin: https://latextemplates.com/downloads/greenpark-beamer.zip; licence: CC-BY-4.0; the theme comes from github.com/Thysrael/GreenParkBeamerTheme, ATTRIBUTION.txt:4)
- Kind: presentation (the manifest hint `exam` is wrong)
- Lib: v5
- Engine: needs XeLaTeX (`% !TeX program = xelatex` main.tex:1; fontspec `\setmainfont` and `\IfFontExistsTF` in beamerthemegpark.sty:80,94; CJK family commands of xeCJK through ctex)
- Look carried by: zip-local (the look is in beamerthemegpark.sty and gparkcolor.sty, loaded by `\usetheme{gpark}` at main.tex:10; main.tex only sets title, author, date, two image paths and content)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (beamerthemegpark.sty 1-508, gparkcolor.sty 1-37; the sources of `ctexbeamer`, `beamer`, `minted`, `etoolbox`, `animate` not read). Line numbers are those of the Read tool (checked against a line-numbered search).

## Verdict
No. The zip-local theme loads `minted` unconditionally (beamerthemegpark.sty:43), so the deck needs shell escape and pygments although the sample never calls it (pilot ruling: EXTERNAL/package); main.tex:3-7 says the same about the upstream deck. Two more blockers stand without it: a TikZ clip-polygon macro that draws the split title and chapter backgrounds (ART/class, theme code off the sample's path) and a `\pretocmd` patch of beamer's `\beamer@checkframetitle` with `\ifx` conditionals that sets a section subtitle on every frame (BESPOKE/class, active on every sample frame). The rest (colours, beamer templates, fonts, listings, tables, hooks, macros) reduces to lib ways.

## Blockers
- `EXTERNAL/package` `minted` loaded unconditionally by the zip-local theme, with `\setminted{...}`, a `\mintedcodefont` family and environment hooks (beamerthemegpark.sty:43, 44-50, 53-54, 114-128); the sample avoids `\begin{minted}` (main.tex:3-7) but the package still loads.
- `ART/class` `\TikzSplitSlide`: a `tikzpicture` with a `\clip` polygon that crops a background image to a slanted band (beamerthemegpark.sty:290-301); reached by `\titlebackground*` (307-310, 318) and by the `chapter` environment when its image argument is given (341). The sample calls the unstarred `\titlebackground{...}` (main.tex:17, beamerthemegpark.sty:305-306, 320), so this branch does not run here, but it is style-file code the sample loads. No lib way clips an image to a polygon.
- `BESPOKE/class` `\pretocmd\beamer@checkframetitle{\framesubtitle{...\ifx\insertsection\empty...}}` patches a beamer internal and chooses the printed subtitle with nested conditionals (beamerthemegpark.sty:418-432); it runs for every frame, and the frametitle template prints the slot (267-273).

## Class setting
- Class: `class.ctexbeamer` options: none (main.tex:8). Not in the zip. It is the beamer variant of the ctex bundle (the ctan.org/pkg/ctex page was read: LPPL 1.3c, pdfLaTeX, XeLaTeX and LuaLaTeX; it does not name `ctexbeamer`, so that the bundle holds it is prior knowledge; class source not read). The theme `gpark` is zip-local: ctan.org/pkg/beamerthemegpark is a 404 and the zip is a latextemplates.com repack with its own PATCH notes (beamerthemegpark.sty:70-79, 88-93, 106-113, 132-135).
- Class-native vocabulary used: `\begin{frame}{title}` (main.tex:24, 30, 38, 56, 64, 74, 82, 100, 108), `\subtitle` (main.tex:14), `\titlepage` (beamerthemegpark.sty:325), `\tableofcontents` in a frame (main.tex:25), `\section` as navigation (main.tex:28), `\usetheme` (main.tex:10), `\usefonttheme` (sty:406); in the theme only: `block`, `columns`, `column`, `beamercolorbox`, `\setbeamertemplate`, `\setbeamercolor`, `\setbeamerfont`, `\AtBeginSection`, `\AtBeginSubsection`, `\insertsection` and the `\insert...` family, frame options `[c]` and `[allowframebreaks]`; Chinese `\date{\today}` (main.tex:16).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:8 | `class.ctexbeamer` | no options |
| beamer theme | main.tex:10; beamerthemegpark.sty:406 | `slide.beamer-theme` | `\usetheme{gpark}` (zip-local, analysed below); `\usefonttheme{serif}` |
| CJK and language | main.tex:8, 13-16; beamerthemegpark.sty:94-104, 136-145 | `lang.cjk` | ctex via the class; `\setCJKmainfont{LXGW WenKai}` else `[Extension=.otf,UprightFont=*-Regular]{FandolFang}`; `\newCJKfontfamily{\sintefserif}` Source Han Serif CN else FandolSong; `\setCJKfamilyfont{heiti}` and `{hwxingkai}` with AutoFakeBold=2.17 (fallbacks FandolHei, FandolKai) |
| Latin text face | beamerthemegpark.sty:80-86 | `font.fontspec` | `\setmainfont{texgyretermes}` Extension=.otf, UprightFont=*-regular, BoldFont=*-bold, ItalicFont=*-italic, BoldItalicFont=*-bolditalic |
| font fallback chains | beamerthemegpark.sty:94-98, 100-104, 114-124, 136-145 | `font.fontspec` | `\IfFontExistsTF{..}{..}{..}`: first installed font wins; an emitter fixes one branch and ships or names the font |
| code font for minted | beamerthemegpark.sty:114-128 | `font.fontspec` | `\newfontfamily{\mintedcodefont}{..}[NFSSFamily=mintedcodefont]` over JetBrainsMono Nerd Font Mono, Cascadia Code, Consolas, DejaVu Sans Mono; read only by minted |
| math and font packages | beamerthemegpark.sty:129 | `math.amsmath`, `math.amssymb`, `math.bm`, `font.lmodern`, `font.display` | `\RequirePackage{amsfonts, amsmath, oldgerm, lmodern, bm}`; `oldgerm` is a blackletter package (not read; load only) |
| CJK switch aliases | beamerthemegpark.sty:130-131, 146-147 | `lang.cjk` | `\let\songti\relax`, `\let\heiti\relax`, `\newcommand{\heiti}{\CJKfamily{heiti}}`, `\hwxingkai` |
| page size | beamerthemegpark.sty:61-62 | `page.geometry` | paperwidth=16cm, paperheight=9cm |
| line spacing | beamerthemegpark.sty:65 | `sp.linespread` | `\baselinestretch`=1.2 |
| paragraph lengths | beamerthemegpark.sty:66-67 | `sp.lengths` | `\parskip`=0.2\baselineskip, `\parindent`=2em |
| space around lists and minted | beamerthemegpark.sty:53-58 | `sp.manual-space` | `\smallskip` before and after `minted`, `itemize`, `enumerate` (etoolbox `\BeforeBeginEnvironment`, `\AfterEndEnvironment`) |
| colour definitions | gparkcolor.sty:7, 11, 14-15, 17-18, 20-21, 24-26, 29-31, 34-37; beamerthemegpark.sty:13-16 | `color.xcolor` | `\definecolor` (sintefblue RGB 0,80,160; airforceblue; emphred; greys; sintefgrey RGB/cmyk), `\definecolorset` prefix `sintef` (greens, yellow, red, lilla, HTML cyan magenta lightgrey), `\colorlet` |
| beamer colours | beamerthemegpark.sty:212-233 | `slide.beamer-template` | `\setbeamercolor` normal text (fg=darkgray,bg=white), structure (sintefblue), block title and body, title, alerted text (sintefred), author, date |
| beamer fonts | beamerthemegpark.sty:235-243 | `slide.beamer-template` | `\setbeamerfont` author \scriptsize, date \tiny, title and frametitle bold sans, subtitle \footnotesize, footline \scriptsize, block title \small, block body \scriptsize |
| navigation symbols | beamerthemegpark.sty:174 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}`; no page numbers are printed |
| footline | beamerthemegpark.sty:177, 180-184, 188-201 | `slide.beamer-template` | `beamercolorbox` wd=\textwidth ht=5mm dp=3mm rightskip=1cm; `\footlinecolor{}` called empty (201): `footline` bg empty, motto empty (gparkcolor.sty:5), block colours at 192-193 |
| headline logo | beamerthemegpark.sty:204-206, 264 | `slide.beamer-template`, `fig.graphicx` | `headline`: `\hspace{0.06\textwidth}` and the image; `\pgfdeclareimage[width=0.09\paperwidth]` reduces to `\includegraphics[width=0.09\paperwidth]{images/logo}` (or `logo_negative`) |
| theme-colour switch | beamerthemegpark.sty:212-227 | `slide.beamer-template` | `\themecolor{white\|blue}` = two fixed sets of `\setbeamercolor` and a logo choice; call sites pass literals (227, 332, 385, 446, 499), so inline expansion removes the `\ifstrequal` |
| frame title | beamerthemegpark.sty:267-273, 435; main.tex:30 | `slide.beamer-template`, `head.class-native` | `frametitle`: `\vspace*{-3.5ex}`, colorbox leftskip=2cm, title then subtitle; `frametitle continuation` empty |
| automatic frame subtitle | beamerthemegpark.sty:418-432 | none | blocker, see above |
| title block | main.tex:13-16, 22; beamerthemegpark.sty:276-288 | `front.maketitle`, `front.class-native`, `slide.beamer-template` | `\title` `\subtitle` `\author` `\date{\today}`; `title page`: `\vskip0pt plus 1filll`, `\hspace{-12mm}`, colorbox wd=0.9\textwidth sep=10pt leftskip=8mm |
| title frame and image | main.tex:17, 22; beamerthemegpark.sty:303-328 | `slide.beamer-template`, `fig.graphicx` | `\maketitle` redefined: group, empty footline, `background` template `\includegraphics[height=\paperheight]{images/titlebackground}`, frame with `\Large\titlepage`; the starred branch is the ART blocker |
| page background | main.tex:18; beamerthemegpark.sty:437 | `slide.beamer-template`, `fig.graphicx` | `\background{images/background2}` = `\setbeamertemplate{background}{\includegraphics[height=\paperheight]{..}}` |
| block boxes | beamerthemegpark.sty:246, 253-261 | `slide.beamer-template` | `\setbeamertemplate{blocks}[rounded]`; `colorblock[fg]{bg}{title}` = group around `block` (not used) |
| list bullets | main.tex:31-35; beamerthemegpark.sty:249-251 | `list.kernel`, `slide.beamer-template` | `itemize`; item templates `\textbullet`, `\ensuremath{\circ}`, `\textemdash` |
| sectioning | main.tex:28, 54, 72, 98 | `head.kernel` | `\section{..}` feeds hook and contents, prints no heading itself |
| contents frame and entries | main.tex:24-26; beamerthemegpark.sty:411, 414 | `toc.kernel`, `slide.beamer-template` | `\tableofcontents` in a frame; `section in toc` = `$\blacktriangleright$~\inserttocsection`; `subsection in toc` empty |
| section contents hook | beamerthemegpark.sty:441-452 | `slide.beamer-section-hook` | group, empty footline and background, `\themecolor{blue}`, frame titled "Table of Contents" (English literal) with `\tableofcontents[currentsection]` |
| subsection divider (not used) | beamerthemegpark.sty:456-482 | `slide.beamer-section-hook`, `slide.beamer-template`, `font.nfss`, `mark.kernel`, `color.xcolor`, `font.size-commands`, `sp.manual-space` | frametitle template swapped and restored, `\fontfamily{ptm}\selectfont`, `\textsl{\textbf{\textcolor{sintefblue}{\LARGE .. \vskip15pt \huge ..}}}`; the footline reset at 458 is not grouped; the sample has no `\subsection` |
| bold, slant, emphasis | beamerthemegpark.sty:151-160; main.tex:47 | `mark.kernel`, `color.xcolor`, `lang.cjk` | `\textbf` = bold plus `\heiti`; `\textsl` plus `\hwxingkai`; `\emph` = bold in emphred; `\ctextbf` `\ctextsl` in airforceblue |
| inline code chip (not used) | beamerthemegpark.sty:162-163 | `box.tcolorbox` | reduction `\tcbox`, fill lightgray, arc 1.5pt; the TikZ node does not apply `\ttfamily` (`\oldtexttt` is saved but not called) |
| hyperlink alias (not used) | beamerthemegpark.sty:165 | `meta.hyperref` | `\chref{url}{text}` = `\textcolor{airforceblue}{\href{..}{..}}` |
| tables | main.tex:11, 39-51, 83-95; beamerthemegpark.sty:170-171 | `tbl.tabular`, `tbl.booktabs` | `table`, `tabular{lrr}`, `\toprule \midrule \bottomrule`; `array` loaded by the theme |
| caption | main.tex:50, 94; beamerthemegpark.sty:508 | `cap.kernel`, `slide.beamer-template` | `\caption` below the table; `\setbeamertemplate{caption}[numbered]` |
| display maths | main.tex:66-68 | `math.amsmath` | `\[ .. \]` with `\mathbf`, `\mathcal`, `\text`, `\sum` (content: the formula) |
| centred text | main.tex:40, 84, 109-110 | `sp.ragged`, `font.size-commands`, `sp.manual-space` | `\centering`, `{\Large ..}`, `\\[1em]` |
| closing slide (not used) | beamerthemegpark.sty:381-396 | `class.ctexbeamer`, `math.kernel`, `font.size-commands`, `sp.ragged`, `mark.kernel`, `box.minipage` | `\backmatter` (overrides a kernel name): group, empty footline and background, `\themecolor{blue}`, `frame[c]`, `$$\mathcal Q \& \mathcal A$$`, `\textsl{Thank you for listening!...}` |
| side picture and chapter frames (not used) | beamerthemegpark.sty:330-378 | `slide.beamer-template`, `fig.graphicx`, `box.minipage` | `sidepic{image}{title}`: background `\hspace*{0.6\paperwidth}\includegraphics[height=\paperheight]{..}`, minipage 0.6\textwidth; `chapter[image]{colour}{title}`, its image route is the ART blocker |
| centred statement, bibliography (not used) | beamerthemegpark.sty:485-505 | `class.ctexbeamer`, `bib.biblatex-biber` | `\centerstate` = beamer `columns`/`column` 0.8\textwidth; `\bibliographpage` = `\section{References}` and `frame[allowframebreaks]` with `\tiny\printbibliography[heading=none]`; biblatex is not loaded by the zip and its backend is not chosen |
| code listings (not used) | beamerthemegpark.sty:10, 18-39 | `code.listings` | `\lstdefinestyle{mystyle}`: commentstyle airforceblue, keywordstyle magenta, basicstyle \ttfamily\scriptsize, breaklines, numbers=left, numbersep=5pt, tabsize=4, xleftmargin and xrightmargin 10pt; `\lstset{style=mystyle}` |
| verbatim | beamerthemegpark.sty:41 | `code.verbatim` | load only |
| minted | beamerthemegpark.sty:43-50, 126-128 | `code.minted` | `\setminted{tabsize=4, encoding=utf8, fontfamily=mintedcodefont}`; EXTERNAL |
| images, subfigures | beamerthemegpark.sty:167-168 | `fig.graphicx`, `fig.subcaption` | `graphicx`, `subfigure` loaded; no figure in the sample |
| animation package | beamerthemegpark.sty:404 | `fig.animate` | `\usepackage{animate}`, load only, no command called anywhere in the zip |
| TikZ split background | beamerthemegpark.sty:7, 290-301 | `art.tikz`, `sp.rule` | `\rule{0.4\paperwidth}{0pt}` spacer, then a `tikzpicture`: `\clip` of a 4-point polygon and a `\node` holding `\includegraphics[height=\paperheight]`; ART |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| gparkcolor.sty as a whole | gparkcolor.sty:1-37 | Yes | `xcolor` calls only (`color.xcolor`); `\@SINTEFmotto` is an empty string macro (5) |
| `\textbf` `\textsl` `\emph`, `\ctextbf` `\ctextsl` | beamerthemegpark.sty:151-160 | Yes | `mark.kernel` switch plus a CJK family switch (`lang.cjk`) and `\textcolor` (`color.xcolor`); no conditional |
| `\heiti` `\hwxingkai` | beamerthemegpark.sty:130-131, 146-147 | Yes | `\CJKfamily{heiti}`, `\CJKfamily{hwxingkai}` inline |
| `\texttt` as a TikZ node | beamerthemegpark.sty:162-163 | Yes (unused) | `\tcbox` of `box.tcolorbox` |
| `\chref`, `\strtoc`, `\strsubsec`, `\centerstate`, `\background` | beamerthemegpark.sty:165, 400-401, 485-492, 437 | Yes | aliases of `\href`, two strings, beamer `columns`, a `background` template |
| etoolbox environment hooks | beamerthemegpark.sty:53-58 | Yes | `\smallskip` emitted before and after each list node |
| `\footlinecolor`, `\@footlinepayoff` | beamerthemegpark.sty:177, 188-201 | Yes | the one call is `\footlinecolor{}`: fixed `\setbeamercolor{footline}{bg=}`, block colours, empty motto |
| `\themecolor`, `\@SINTEFlogo` | beamerthemegpark.sty:206, 212-227 | Yes | literal call sites expand to fixed `\setbeamercolor` lines and a fixed logo file; the comment at 209-211 says it is a preamble-time setting, so the emitter writes it where the hook runs, as the theme does |
| `colorblock`, `sidepic` | beamerthemegpark.sty:253-261, 359-378 | Yes | group, `\setbeamercolor` or templates, `block` or minipage |
| `\titlebackground`, `\FullBackground`, `\SplitBackground`, `splittitle` bool | beamerthemegpark.sty:303-310 | Yes for the full branch | static choice; the starred branch calls `\TikzSplitSlide` |
| `\maketitle` redefinition | beamerthemegpark.sty:312-328 | Yes for the full branch | group, empty footline, background template, frame with `\titlepage` |
| `\TikzSplitSlide` | beamerthemegpark.sty:290-301 | No | ART/class: TikZ polygon clip of an image; no lib way |
| `chapter` environment | beamerthemegpark.sty:330-357 | No (image route) | without the image it is templates plus a minipage; with it, it calls `\TikzSplitSlide`; the `\ifstrequal{#2}{sinteflightgreen}` test is static |
| `\backmatter` redefinition | beamerthemegpark.sty:381-396 | Yes | one fixed frame |
| `\pretocmd\beamer@checkframetitle` | beamerthemegpark.sty:418-432 | No | BESPOKE/class: `\ifx` chain over `\insertsection` and `\insertsubsection` patched into a beamer internal; a frametitle template that prints those macros is a different mechanism, and conditionals that drive printing are not a lib way |
| `\AtBeginSection[]` hook | beamerthemegpark.sty:441-452 | Yes | frame of `\setbeamertemplate` calls and `\tableofcontents[currentsection]` after inline `\themecolor{blue}` |
| `\AtBeginSubsection[]` hook | beamerthemegpark.sty:456-482 | Yes (unused) | frame with font, colour, size switches and the counters `\thesection` `\thesubsection` |
| `\bibliographpage` | beamerthemegpark.sty:495-505 | Yes (unused) | section plus frame with `\printbibliography`; needs biblatex from the document |
| `\IfFontExistsTF` chains | beamerthemegpark.sty:94-124, 136-145 | Yes | one fixed font per slot; the fonts are assets to ship or name |
| `etoolbox` load | beamerthemegpark.sty:6 | Yes | helper for the conditionals and hooks above, all removed by static expansion |

## Content-opaque
none (the two tables at main.tex:39-51 and 83-95 are plain `tabular` content; no figure, TikZ picture or image appears in the sample body; the formula at main.tex:66-68 is content)

## Lib changes
- New ways proposed: `fig.animate` `animate` (CTAN, LPPL; Alexander Grahn; ctan.org/pkg/animate read: JavaScript-driven PDF animations from sets of graphics files or inline content; the page lists no commands, engines or external tools, so the following is prior knowledge): `\usepackage[controls,loop,...]{animate}`, body `\animategraphics[opts]{frame-rate}{basename}{first}{last}` and the `animateinline` environment; engine pdf (not stated). W1 CTAN package; W2 options, frame rate, file basenames; W3 serves any document with a frame sequence; W4 preamble line plus a body call around a file set. Proposed because the zip-local theme loads it unconditionally (beamerthemegpark.sty:404), as the lib kept `math.inference` for an unconditional `mathpartir` load; no sample content calls it.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
