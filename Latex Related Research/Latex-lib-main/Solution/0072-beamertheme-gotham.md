no

# 0072-beamertheme-gotham: Gotham beamer theme (beamertheme-gotham 1.2.5.a)

- Unverified: read from the source, not compiled.
- Source: Source/0072-beamertheme-gotham/ (origin: https://mirrors.ctan.org/macros/latex/contrib/beamer-contrib/themes/beamertheme-gotham.zip; licence: lppl1.3c and cc-by-sa-4 per manifest; gotham.ins:1-35 says LPPL 1.3c)
- Kind: presentation
- Lib: v1
- Engine: pdfLaTeX-compatible (Fira Sans/Mono need XeLaTeX or LuaLaTeX: the theme loads fontspec only there and otherwise warns and falls back to standard fonts, gotham.dtx:308-370, gotham-doc.tex:217-221; `minted` also needs shell escape)
- Look carried by: class (the published beamer theme `gotham` on CTAN, a class-level style; the decks add only option settings and hook text. The theme ships here only as DocStrip source `gotham.dtx`/`gotham.ins`, gotham.ins:43-53)
- Class origin: ctan
- Main file: gotham-doc.tex (the manifest's main; an `l3doc` manual of the theme, `\input` by the gotham.dtx driver at gotham.dtx:133). Template samples: gotham-example169transp.tex (+ section-Beamer.tex, section-Gotham.tex, section-Conclusion.tex pulled in by `\input`, gotham-example169transp.tex:59-63), gotham-example43dark.tex, gotham-exampleSimple.tex
- Read: main yes (gotham-doc.tex all 1304 lines; all three example decks and all three section files complete), zip-local classes and styles partly (no `.cls`/`.sty` is present, they are generated from gotham.dtx; dtx lines 1-1260, 1700-1810, 1930-2130, 2210-2330, 2430-2560, 4590-4630, 6905-6995, 8225-8295, 8740-8810, 9280-9533 read, the rest of the 9533 lines outlined by grep, so inner/outer template bodies are only partly read)

## Verdict
no. The theme is a published CTAN beamer theme, so `\usetheme{gotham}` with `\gothamset{key=value}` maps to `slide.beamer-theme` with declarative parameters, and every other construct in the example decks and in the manual maps to a lib way or reduces (aliases, two hook redefinitions, one documentation environment). The blocker is `minted`: both example decks load it unconditionally in their preamble and section-Gotham.tex shows all its code through `minted` environments and `\mintinline`, which needs pygments and shell escape (`EXTERNAL/package`). Under a stricter reading that did not count the published theme as a way, its implementation would be irreducible (see Bespoke code).

## Blockers
- `EXTERNAL/package` `minted` loaded in the deck preamble (gotham-example169transp.tex:20, gotham-example43dark.tex:21; `\usemintedstyle`, `\setminted[tex]`, `\setmintedinline[tex]` at 169transp:23-30) and called 45 times in the body (section-Gotham.tex:10, 32-35, 53, 109, 121, ...); needs pygments and shell escape.

## Class setting
- Class: `class.beamer` options: `aspectratio=169, 10pt` (gotham-example169transp.tex:1), `aspectratio=43, 10pt` (gotham-example43dark.tex:1), none (gotham-exampleSimple.tex:1). The manual uses `class.l3doc` (gotham-doc.tex:1), no options; beamer and l3doc are not in the zip (they ship with the TeX distribution, source not read).
- Class-native vocabulary used (beamer): `frame` with options `fragile`, `allowframebreaks`; the frame title as the frame's second argument, `\framesubtitle` (section-Gotham.tex:384); `\title[short]`, `\subtitle`, `\author[short]`, `\date[short]`, `\institute`, `\titlegraphic`, `\logo`, `\maketitle`; `\section`, `\appendix`, `\tableofcontents`; `columns[T,onlytextwidth]` + `\column`; `block`, `alertblock`, `exampleblock`; `\alert`, `\only`, overlay specs `<+- | alert@+>`.
- Gotham-native vocabulary used (published theme): `\gothamset{...}` (169transp:4-10, section-Gotham.tex:73,80,105,182,399); frame options `toc` (gotham-example169transp.tex:51), `watermark`, `standout`, `rotateFooter`, `edging`, `noedging`, `nofooter` (section-Gotham.tex:264,294,320,342,360); frame-wrapping environments `standinenv`, `standoutenv` (section-Gotham.tex:276, section-Conclusion.tex:24); hooks `\gothamRightFiligrane`, `\gothamInstituteLogoSquare` (section-Gotham.tex:338,378).
- Class-native vocabulary used (l3doc, the manual): `\DescribeOption`, `function`, `variable`, `arguments` environments (gotham-doc.tex:66,799-923).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (decks) | gotham-example169transp.tex:1 | `class.beamer` | aspectratio=169, 10pt (43dark: aspectratio=43, 10pt) |
| page size / ratio | gotham-example169transp.tex:1, gotham-example43dark.tex:1 | `page.class-options` | aspectratio=169 or 43; 10pt |
| theme loading | gotham-example169transp.tex:2; gotham.dtx:9316-9319 | `slide.beamer-theme` | `\usetheme{gotham}` (loads font, color, inner, outer sub-themes); sub-themes also loadable singly (gotham-doc.tex:1173-1179) |
| theme options (global) | gotham-example169transp.tex:4-10; gotham-example43dark.tex:4-11 | `slide.beamer-theme` | `\gothamset{numbering=framenumber, parttocframe default=off, sectiontocframe default=off, subsectiontocframe default=off}`; dark deck adds `background=dark` |
| theme options (mid-deck, group-scoped) | section-Gotham.tex:73,80,95,105,126,141,161,182,399 | `slide.beamer-theme` | `format frametitle=upper\|lower\|titlecase`, `shape frametitle=italic\|smallcaps`, `background=dark`, `colorset=red`, `block=native\|transparent\|fill`, `progressbar position=left, progressbar style=rounded box, progressbar advancement=brlt, numbering=circle` (keys: gotham.dtx:669-1070, 1733-1770, 6920, 8755, 9084, 9139) |
| title, section and frame-title case and shape | gotham.dtx:669-1070; section-Gotham.tex:48-100 | `slide.beamer-theme` | `format <part> = regular\|lower\|upper\|titlecase`, `shape <part> = regular\|smallcaps\|italic` for title, subtitle, frametitle, framesubtitle, part, section, subsection, subsubsection |
| text-case marks shown in the demo | section-Gotham.tex:56-58 | `mark.kernel` | kernel `\MakeLowercase`, `\MakeUppercase`, `\MakeTitlecase` (content of a list item) |
| typeface (Fira) | gotham.dtx:308-359 | `font.fontspec` | the theme itself calls `\setsansfont` (FiraSans Light/Regular/Italic .otf) and `\setmonofont` (FiraMono Medium/Bold .otf), tries the `OT` names, else warns and keeps standard fonts; the decks load no fontspec. Fonts are not in the zip (missing assets) |
| colour palette | gotham.dtx:1149-1248, 1333-1364; gotham-example169transp.tex:21-22 | `color.xcolor` | named colours gAnthracite 2d3e50, gLightTeal, gPaleYell, ...; `colorA`..`colorE` set by `\colorlet`; decks add `\definecolor{codeback}{rgb}{0.90,0.91,0.92}`, `{codebackdark}{rgb}{0.10,0.11,0.12}` |
| dark / light / transparent background, block fill | gotham.dtx:1385-1452, 1733-1755; section-Gotham.tex:105-180 | `slide.beamer-theme` | `background`, `block` keys; `\setbeamercolor` inside the theme |
| title page | gotham-example169transp.tex:39-49; gotham.dtx:2056,2128,2218,2296 | `front.class-native` | `\title[]{Gotham}`, `\subtitle`, `\date[]{\today}`, `\author[]{...}`, `\institute`, `\maketitle`; template via `title page = gotham normal\|reversed\|dividedpic\|splitvert` |
| title page logo and background hooks | gotham.dtx:2020,2037 | `slide.beamer-theme` | hooks `\gothamtitlepagelogo`, `\gothamtitlepagebg` (empty by default; the decks do not set them) |
| section / part pages and their toc frames | gotham-example169transp.tex:7-9, 56-60; section-Gotham.tex:238-261; gotham.dtx:3786-4413 | `head.class-native` | `\section`; `sectionframe default/template`, `parttocframe default` ... (decks set the toc frames `off`) |
| table of contents | gotham-example169transp.tex:51-53; section-Gotham.tex:220-235 | `toc.kernel` | `\begin{frame}[toc]{Table of contents}\tableofcontents`; `tocframe template = gotham bullet\|simple` |
| frame title and subtitle | section-Gotham.tex:378-395; gotham.dtx:6125-6315 | `head.class-native` | `frametitle template`, `framesubtitle template`, `frametitle continuation template`; `\framesubtitle{...}` |
| footer, frame number, rotated footer | gotham-example169transp.tex:5-6; section-Gotham.tex:303-334; gotham.dtx:6433-6880 | `hf.class-native` | `numbering = framenumber\|circle\|...`, `footer template`, `rotateFooter default`; short title, date and author through `\title[..]`, `\date[..]`, `\author[..]` (section-Gotham.tex:316-318) |
| custom footer text | section-Gotham.tex:303 | `slide.beamer-template` | `\setbeamertemplate{frame footer}{My custom footer}` |
| progress bar and mini-frame navigation | section-Gotham.tex:399; gotham.dtx:7019-7150, 8233-8284 | `hf.class-native` | `progressbar position/style/advancement/mfn`, `mini frames shape/bundle/compress/nav ...` |
| edging (sidebar canvas) and hook | section-Gotham.tex:338-356; gotham.dtx:5694-5701 | `slide.beamer-theme` | frame option `edging`; hook `\gothamRightFiligrane` set to a rotated string (text content) |
| rotated string inside that hook | section-Gotham.tex:338-340 | `fig.rotating` | `\rotatebox{90}{gotham right filigrane pattern}` |
| logo hooks | section-Gotham.tex:378-381 | `fig.graphicx` | `\renewcommand{\gothamInstituteLogoSquare}[1][4ex]{\includegraphics[height=#1]{gotham-logo.pdf}}`; `\logo{extra LOGO}` |
| watermark, standin, standout frames | section-Gotham.tex:264,276-298; section-Conclusion.tex:24-37; gotham.dtx:2526-2530,2848,2930 | `slide.beamer-theme` | frame options `watermark`, `standout`; environments `standinenv`, `standoutenv`; keys `watermark template/default`, `standout template`, `standin BG template` |
| overlays | section-Beamer.tex:163-169 | `slide.beamer-mode` | `itemize[<+- \| alert@+>]`, `\alert<4>`, `\only<4>` |
| lists | section-Beamer.tex:116-160, 136-154 | `list.kernel` | `itemize`, `enumerate`, `description` (item shapes set by the theme: gotham.dtx:5288-5298) |
| columns | section-Beamer.tex:132-156; section-Gotham.tex:51-67,119-179 | `class.beamer` | beamer `columns[T,onlytextwidth]`, `\column{0.33\textwidth}` (native, not `cols.minipage`) |
| blocks | section-Beamer.tex:259-273; section-Gotham.tex:116-180 | `class.beamer` | `block`, `alertblock`, `exampleblock`; styled by `block=` of `slide.beamer-theme` |
| quote | section-Beamer.tex:329-334 | `quote.kernel` | `quote` |
| equation | section-Beamer.tex:277-279 | `math.kernel` | `equation` with `\lim`, `\left(`, `\frac` |
| figure and caption | section-Beamer.tex:212-237, 283-326 | `fig.graphicx` | `figure`, `\centering`, content is TikZ/pgfplots (content-opaque) |
| caption | section-Beamer.tex:235,244,297,324; gotham.dtx:5328 | `cap.kernel` | `\caption`; separator `: ` set by the theme |
| table | section-Beamer.tex:241-256 | `tbl.tabular` | `tabular{@{} lr @{}}` in `table` with `\centering`, `\caption` |
| table rules | section-Beamer.tex:246-253 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| table package loaded, not used | gotham-example169transp.tex:15-16; section-Beamer.tex:7-8 | `tbl.nicematrix` | `\usepackage{tabularray}`, `\UseTblrLibrary{booktabs}`; no `tblr` environment in any body (grep) |
| verbatim code | section-Beamer.tex:65-75, 82-85, 174-186; section-Conclusion.tex:27-31 | `code.verbatim` | `verbatim`, `\verb\|..\|`, `\verb$..$` inside `fragile` frames |
| minted code | gotham-example169transp.tex:20-30; section-Gotham.tex:32-35, 53, 109 | `code.minted` | `minted` environment and `\mintinline`, language `tex`; style `emacs`; `bgcolor=codeback`/`codebackdark`, `autogobble`, `tabsize=4`, `extrakeywords={...}` (EXTERNAL) |
| bibliography | section-Beamer.tex:338, 348-377 | `bib.thebibliography` | hand-written `thebibliography{1}` in `frame[allowframebreaks]`; `\cite{...}` with five keys; the BibTeX data in `filecontents*` and `\bibliography` (11-55, 343-344) are unused or commented |
| appendix / backup slides | gotham-example169transp.tex:18, 66-74 | `num.appendix` | `\appendix` with package `appendixnumberbeamer` (frame numbers and progress bar stop in the appendix, per deck text 73) |
| wide block | section-Gotham.tex:361-373 | `page.adjustwidth` | `changepage` `adjustwidth{-2em}{-2em}` |
| icon | section-Conclusion.tex:5, 20; gotham-example169transp.tex:32 | `font.icons` | `ccicons` `scale=2`, `\ccbysa` |
| links | section-Beamer.tex:236; section-Conclusion.tex:17,19 | `meta.hyperref` | `\href`, `\url` (the decks do not load hyperref themselves; beamer does, not read) |
| emphasis and manual spacing | section-Beamer.tex:103-127, 158; section-Gotham.tex:28,69 | `mark.kernel` | `\emph`, `\alert`, `\textbf`, `\textit`, `\textsc`, `\texttt`; `sp.manual-space` for `\vspace{2em}`, `\bigskip` |
| multi-file assembly | gotham-example169transp.tex:12, 59-63 | `pg.standalone-pkg` | `\usepackage{standalone}` then `\input{section-*.tex}`; the section files carry their own `\documentclass`+preamble, which the package skips (read, not run) |
| drawing packages | gotham-example169transp.tex:13-14, 33-34 | `art.tikz` | `tikz`, `pgfplots`, `\usepgfplotslibrary{dateplot}`; used only inside figures (content-opaque) |
| manual: document class | gotham-doc.tex:1 | `class.l3doc` | no options |
| manual: encoding | gotham-doc.tex:2 | `font.fontenc-t1` | `[T1]{fontenc}` |
| manual: paragraph and line spacing | gotham-doc.tex:12-15 | `sp.parskip-pkg`, `sp.setspace` | `parskip`; `setspace` with `\onehalfspacing` |
| manual: colours | gotham-doc.tex:17-21 | `color.xcolor` | `\definecolor` tPrim 00707F, tSec 5FA4B0, tAccent F07F3C, tGrey E6E6E1 |
| manual: code listings | gotham-doc.tex:23-56 | `code.listings` | `\lstset{language=[LaTeX]{TeX}, basicstyle=\ttfamily, keywordstyle=\color{tPrim}\bfseries, commentstyle/stringstyle=\color{tSec}, frame=none, breaklines=true, morekeywords={...}}`, `\lstMakeShortInline\|` |
| manual: links and cross-references | gotham-doc.tex:58, 62, 178 | `meta.hyperref`, `xref.cleveref` | `hyperref`; `cleveref` `\cref{fig-minimal}` |
| manual: subfigures | gotham-doc.tex:61, 322-338 | `fig.subcaption` | two `subfigure[b]{0.475\textwidth}` with `\includegraphics`, `\caption`, `\label` |
| manual: title, contents, headings | gotham-doc.tex:88-99, 103ff | `front.maketitle`, `toc.kernel`, `head.kernel` | `\title{\textsc{Gotham}\\ ...}`, `\author`, `\date`, `\tableofcontents`, `\section`..`\subsubsection` |
| manual: lists | gotham-doc.tex:143-165, 208-215, 344-346 | `list.kernel` | `description`, `itemize` |
| manual: framed figures | gotham-doc.tex:60, 198-203, 1082-1086 | `box.fancybox`, `fig.graphicx`, `cap.kernel` | `\setlength{\fboxsep}{0pt}`, `\fbox{\includegraphics[width=0.7\textwidth]{...}}` |
| manual: pdfpages loaded, not called | gotham-doc.tex:3 | `pg.include-pdf` | `\usepackage{pdfpages}`; no `\includepdf` in the file |
| manual: option and function descriptions | gotham-doc.tex:65-84, 240, 799-923 | `class.l3doc` | `\DescribeOption`, `function`, `variable`, `arguments`, local `DescribeGothamOption` (see Bespoke code) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\famName`, `\themename` aliases | gotham-example169transp.tex:19,36; section-Gotham.tex:14-15; section-Conclusion.tex:6; gotham-doc.tex:92 | yes | inline `\textsc{..}` and `\textbf{\textsc{Gotham}}` (`mark.kernel`); `\xspace` in the manual alias is dropped by writing spaces |
| hook redefinition `\gothamRightFiligrane` | section-Gotham.tex:338-340 | yes | published hook set to `\rotatebox{90}{text}` (`fig.rotating`), a text parameter of `slide.beamer-theme` |
| hook redefinition `\gothamInstituteLogoSquare` | section-Gotham.tex:378-380 | yes | published hook set to `\includegraphics[height=#1]{gotham-logo.pdf}` (`fig.graphicx`) |
| `\newcounter{density}` + `\pgfmathsetcounter` | section-Beamer.tex:215-233 | yes (content) | counter only drives the fill percentages of a TikZ picture inside a figure (content-opaque, not template) |
| `DescribeGothamOption` environment and `\defopt` | gotham-doc.tex:64-84; gotham.dtx:95-115 | yes | documentation-only macro: `minipage` (`box.minipage`), `\rule[2.5ex]{\linewidth}{0.3pt}` (`sp.rule`), `\\[-3.5ex]`, `\vspace{0.5em}` (`sp.manual-space`), `\textcolor{tSec}`, `\textit\textbf`, `\dotfill`, `\underline`; the `\IfNoValueTF` test only chooses whether to print the dated side note, so an emitter writes each case out |
| `\edef\GothamVersion`, `\GothamDate` | gotham-doc.tex:8-9 | yes | plain text strings in `\date{}` |
| gotham theme implementation (`beamerthemegotham`, `beamerfont/color/inner/outerthemegotham` from gotham.dtx:198-9526) | gotham.dtx:198, 1132, 1812, 5390, 9289 | not bespoke by the rubric: published on CTAN (manifest url, ctan.ann, README.md:113-115 `tlmgr install beamertheme-gotham`), so it is the way `slide.beamer-theme`; no ctan.org read was made | Recorded for a stricter re-reading: if counted as zip-local it would be `BESPOKE/class` irreducible (`\patchcmd` of beamer internals gotham.dtx:452-621, expl3 key routing across four sub-modules 9332-9358, dimension and `\ratio` arithmetic for progress bars 8236-8238) and `ART/class` (TikZ title separator 1996-2001, divided-picture clip 2258-2282, DRAFT watermark 2527-2529, progress bars 8242-8282) |

## Content-opaque
- TikZ rotated-polygon picture in a figure (section-Beamer.tex:217-234).
- pgfplots line plot and bar chart in figures (section-Beamer.tex:286-296, 305-323).
- Images in the manual: gotham-exampleSimple.pdf (gotham-doc.tex:200), gotham-layout.pdf (1084), gotham-test-035-a.png and -b.png (326, 332; these two PNGs are not in the zip, listed as support files in MANIFEST.md).
- Unused BibTeX data in `filecontents*` (section-Beamer.tex:11-55).
- Missing assets, shipped by the project: Fira Sans and Fira Mono fonts (gotham.dtx:317-359), the two PNGs above. No text addressed to an AI was found in the zip.

## Lib changes
- New ways proposed:
  - `tbl.nicematrix` `tabularray` (CTAN), pdf-compatible, key-value table specification `\begin{tblr}{colspec=..., rowspec=...}` plus `\UseTblrLibrary{...}`. W1 CTAN package; W2 behaviour chosen by key=value lists; W3 serves tables generally; W4 preamble line plus an environment wrapper. Only loaded here, never used in a body, so it could instead be folded into `tbl.nicematrix` (key-value table engines) by the consolidator.
  - `pg.standalone-pkg` `standalone` package used for `\input` of files that carry their own `\documentclass` and preamble (the package skips them), pdf, load-only. W1 CTAN package; W2 no code to edit, a load-only switch like `pg.emptypage` and `cols.balance`; W3 generic file assembly; W4 one preamble line and `\input` body lines. It has no visual effect, so the consolidator may also classify it as not a template component.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
