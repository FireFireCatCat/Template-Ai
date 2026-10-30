yes

# 0907-timkpaine-oreilly-latex-template: O'Reilly/Packtpub-style book template (Joan Queralt Gil, English translation)

- Unverified: read from the source, not compiled.
- Source: Source/0907-timkpaine-oreilly-latex-template/ (origin: https://codeload.github.com/timkpaine/oreilly-latex-template/zip/refs/heads/main; licence: not established)
- Kind: book
- Lib: v6
- Engine: pdfLaTeX-compatible (hyperref `pdftex` option at packtpub.tex:84; T1 and inputenc at :9-10; no fontspec; the shipped packtpub.pdf names pdfTeX-1.40.19 as producer, which is not proof of anything here)
- Look carried by: preamble (no zip-local class or style exists; the sample's own preamble, packtpub.tex:2-162, restyles stock `scrbook` with titlesec, scrlayer-scrpage, enumitem, colortbl and bclogo)
- Class origin: tex-distribution-unbundled (KOMA-Script `scrbook`; not in the zip, its source was not read)
- Main file: packtpub.tex (other samples: none; the zip also holds README.md, .gitignore, write.png and the rendered packtpub.pdf)
- Read: main yes (all 771 lines), zip-local classes and styles none present

## Verdict
yes. The zip has one `.tex` file and no `.cls`, `.sty`, `.def` or `.cfg`; every look-defining construct is a published package with option values (titlesec, scrlayer-scrpage, enumitem, colortbl, hyperref, bera, pifont, bclogo) or a kernel NFSS command. One way is proposed: `NEW:box.bclogo` (CTAN package). The one judgement call is the TikZ filled bar behind section and subsection headings (packtpub.tex:109, 116): it is template identity, so it would be ART, but it is a plain coloured band, which the rubric names as reducible to a `tcolorbox` or `fancybox` band; the reduction is written below and its geometry is approximate. A reviewer who rejects that reduction turns this into `no` with `ART/preamble`.

## Blockers
none

## Class setting
- Class: `class.scrbook` options: `a4paper`, `twoside`, `BCOR1.0cm`, `DIV11`, `parskip=full`, `11pt` (packtpub.tex:2-7)
- Class-native vocabulary used: `\dictum[author]{text}` (packtpub.tex:180-183, 686-689), `\minisec{}` (:368, 381, 395, 603, 726), `\addtokomafont` / `\setkomafont` / `\usekomafont` with the font elements `chapter` `section` `subsection` `sectioning` `pagehead` `headsepline` `captionlabel` `caption` (:28-33, 74, 102, 108, 115), `\maketitle` with `\title` `\author` `\date` (:167-173), `\chapter` `\section` `\subsection` `\subsubsection`, `\tableofcontents` (:175). `\setheadwidth` and `\setheadsepline` (:72-73) are scrpage2 commands (the sample's own text at :285 says scrpage2) while :69 loads `scrlayer-scrpage`; whether that package accepts them was not checked (KOMA source not in the zip). Either way the way is the same, with headwidth and head-rule as parameters.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | packtpub.tex:2-7 | `class.scrbook` | options above; `parskip=full` is a class option, the paragraph gap is not set elsewhere |
| paper, sides, size | packtpub.tex:2-3, 7 | `page.class-options` | a4paper, twoside, 11pt |
| type area | packtpub.tex:4-5 | `page.typearea` | BCOR=1.0cm, DIV=11 |
| head height | packtpub.tex:70 | `page.setlength` | `\headheight`=25pt |
| encodings | packtpub.tex:9-10 | `font.fontenc-t1` | fontenc T1, inputenc utf8 |
| text faces | packtpub.tex:12 | `font.serif-pkg` | package `bera` (CTAN: Bera Serif, Sans, Mono, Bitstream Vera repackaged; the CTAN page does not say which defaults it sets and `bera.sty` was not read); no options |
| symbol glyphs | packtpub.tex:13, 134-137, 145, 150-153, 369, 382, 397 | `font.icons` | `pifont`, `\ding{110}` `{108}` `{72}` `{117}` `{224}` `{252}` `{212}` `{232}` `{217}`, `\ding{\value{enumi}}` |
| math symbol | packtpub.tex:14, 141 | `math.amssymb` | `\blacktriangleright` as a bullet |
| colours | packtpub.tex:15, 20 | `color.xcolor`, `color.color` | xcolor `dvipsnames`; `color` loaded as well; used: gray, white, lightgray, black!40, black!60, gray!30, blue (`\textcolor[named]{gray}` at :103) |
| images | packtpub.tex:16, 156 | `fig.graphicx` | `\includegraphics[width=14pt]{write}` (shipped write.png) |
| tikz and pgf loaded | packtpub.tex:17-19, 35-67 | `art.tikz` | `\usetikzlibrary{shapes,calc,trees,...}` and `\tikzset` styles `punktchain` `peu` `line` `element`; none is called in the body (Grep: only :109, 116 and verbatim text use `\tikz`); the bars are in the heading rows below |
| xspace | packtpub.tex:11 | considered: `xspace` | loaded, `\xspace` never called; no printed effect |
| fixed-size fonts | packtpub.tex:24-26 | `font.nfss` | `\DeclareFixedFont{\numcap}{T1}{phv}{bx}{n}{3cm}`, `{\textcap}{...}{1.5cm}`, `{\textaut}{...}{0.8cm}` (Helvetica bold) |
| heading font elements | packtpub.tex:28-30 | `head.koma-fonts` | chapter += `\color{gray}\textcap`; section and subsection += `\color{white}` |
| caption fonts | packtpub.tex:32-33 | `cap.koma` | captionlabel `\sffamily\small\bfseries`; caption `\sffamily\small` |
| page style | packtpub.tex:31, 69-74 | `hf.scrlayer-scrpage` | `\pagestyle{scrheadings}`; pagehead font `\sffamily\small`; headwidth `textwithmarginpar`; head rule .4pt, rule colour lightgray; header text is the package default (the sample's prose at :281-284 describes chapter mark left, section mark right) |
| footers | packtpub.tex:76-82 | `hf.scrlayer-scrpage`, `sp.rule`, `box.fancybox`, `box.minipage` | even `\lefoot` and odd `\lofoot` = `\color{black!40}\hrulefill`; centre = `\parbox[c][.5in][c]{1cm}{\fcolorbox{black!40}{white}{\thepage}}`; plain-style option `[---  \thepage ---]` at :81; `\refoot{}` `\rofoot[]{}` empty |
| PDF links and info | packtpub.tex:84-93 | `meta.hyperref` | pdftex, colorlinks=true, linkcolor/filecolor/citecolor=blue, pdftitle `Llibre amb estil`, pdfauthor, pdfsubject, pdfkeywords, bookmarks, bookmarksnumbered |
| line breaking | packtpub.tex:95-96 | `sp.hyphenat` | `\tolerance=4000`, `\emergencystretch=20pt` (the two parameters `\sloppy` sets) |
| numbering depth | packtpub.tex:98 | `num.secnumdepth` | secnumdepth=3 |
| chapter heading | packtpub.tex:99, 101-105 | `head.titlesec` | `\titleformat{\chapter}[display]`: format `\usekomafont{sectioning}\usekomafont{chapter}\filleft`, label `\numcap\textcolor[named]{gray}\thechapter`, sep 1em, before empty; `scrhack[standardsections]` (:8) is loaded first (considered: `scrhack`, a load-only KOMA-bundle switch so titlesec works on KOMA headings; its manual was not read) |
| section heading | packtpub.tex:107-112 | `head.titlesec`, `box.fancybox` | `[block]`, format `\usekomafont{sectioning}\usekomafont{section}` plus a black bar (TikZ overlay at :109); label `\thesection`, sep 1em; bar reduction in the Bespoke table |
| subsection heading | packtpub.tex:114-119 | `head.titlesec`, `box.fancybox` | same, bar colour `black!60` (:116), label `\thesubsection` |
| epigraph and mini headings | packtpub.tex:180-183, 686-689; 368, 603 | `class.scrbook` | native `\dictum[author]{text}`, `\minisec{}` (not epigraph-package commands) |
| lists | packtpub.tex:123-153 | `list.enumitem` | `\newlist` + `\setlist`: steps (enumerate, 4 levels, `label*=\arabic*.`), points (itemize, 4 levels, `\tiny\ding{110/108/72/117}`), objectives (itemize, 1 level, `\tiny$\blacktriangleright$`), attention (itemize, 1 level, `\ding{224}`), arrows (itemize, 4 levels, `\tiny\ding{252/212/232/217}`); all: topsep=0pt, partopsep=0pt, itemsep=0pt, parsep=0pt, labelindent=0.5cm, leftmargin=* |
| list use in body | packtpub.tex:344-352, 425-430, 444-449, 466-489, 506-529, 709-717 | `list.enumitem` | the five environments, nested up to 4 levels; inline `enumerate[nolistsep,label=\ding{\value{enumi}},start=172/182/202]` at :369, 382, 397 |
| framed callout | packtpub.tex:155-157, 672-682, 691-701 | `NEW:box.bclogo` | `\usepackage[tikz]{bclogo}`; `\renewcommand\logowidth{14pt}`; `\begin{bclogo}[logo=\novaimatge,couleur=gray!30,barre=none,noborder=true,marge=10,ombre=true,couleurOmbre=black!60,blur]{\sffamily{ Objectives}}` with `\sffamily\scriptsize` and a list inside |
| table rules | packtpub.tex:159-162 | `tbl.colortbl`, `tbl.tabular`, `sp.manual-space` | `\arrayrulecolor{gray}`; `\hline` = `\noalign{\vskip3pt}` rule `\noalign{\vskip4pt}` |
| title block | packtpub.tex:167-173 | `front.maketitle` | `\title{\textcap{Latex Template}}`, `\author{\textaut{Joan Queralt Gil}\\ URL}`, `\date{\today}`, class `\maketitle` |
| contents | packtpub.tex:175 | `toc.kernel` | `\tableofcontents` |
| sectioning commands | packtpub.tex:178, 188, 204, 330, 531 | `head.kernel` | `\chapter` `\section` `\subsection` `\subsubsection`, `\label` |
| verse | packtpub.tex:538-577 | `quote.kernel`, `sp.manual-space`, `sp.ragged` | `verse`, `\\*`, `\medskip`; closing `flushright` |
| quotes | packtpub.tex:585-597, 720-724 | `quote.kernel` | `quote`, `quotation` |
| tables | packtpub.tex:613-643, 728-744 | `tbl.tabular`, `cap.kernel`, `sp.ragged`, `font.size-commands` | `table[h]`, `\centering`, `tabular{l|c|c|l}` and `{c|c|c}`, `\hline`, `\caption` + `\label`; `\scriptsize` at :729 |
| cross-references | packtpub.tex:178, 668 | `xref.kernel`, `xref.hyperref` | `\label`, `\pageref`, `\nameref` (:668 writes `sec: lists` with a space, an undefined label: content defect) |
| inline marks and fonts | packtpub.tex:185, 673-674 | `mark.kernel` | `\textit`, `\sffamily` |
| documentation snippets | packtpub.tex:186, 191-201, 207-219 and following | `code.verbatim`, `font.size-commands` | `\verb+...+`, `verbatim` inside `scriptsize` or `tiny` |
| filler text | packtpub.tex:121, 604, 690, 704 | `draft.todo` | `\usepackage{lipsum}`, `\lipsum[1-2]` and other ranges |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\tikz[overlay]\fill[color=black,rounded corners=.2ex] (0,-1ex) rectangle (\textwidth-2cm,1em)` inside `\titleformat{\section}`; same with `black!60` for subsections. ART/preamble, judged reducible | packtpub.tex:109, 116 | yes (judgement call) | the TikZ draws one filled rectangle of fixed width `\textwidth-2cm`, from 1ex below to 1em above the baseline, colour black or black!60, corner radius .2ex (about 0.1 mm), under white heading text. Emit it as a `head.titlesec` `\titleformat{\section}[block]` whose last argument wraps label and title in a band: `box.fancybox` `\colorbox{black}{\parbox{\dimexpr\textwidth-2cm-2\fboxsep\relax}{\thesection\hspace{1em}#1}}` (colour `black!60` for subsections), or `box.tcolorbox` with `colback`, `colframe`=black, `boxrule=0pt`, `arc=.2ex`, `width=\textwidth-2cm`. `\fboxsep` replaces the 1ex/1em overlay extents, so the bar height and its behaviour on a two-line title differ slightly from the overlay. Not identical, only the same look |
| `\DeclareFixedFont` for `\numcap` `\textcap` `\textaut` | packtpub.tex:24-26 | yes | kernel NFSS command, the way `font.nfss`; emit as written, or the inline switch `\fontencoding{T1}\fontfamily{phv}\fontseries{bx}\fontshape{n}\fontsize{3cm}{3cm}\selectfont` |
| `\newlist{steps}`, `points`, `objectives`, `attention`, `arrows` | packtpub.tex:125, 132, 139, 143, 148 | yes | published enumitem `\newlist` and `\setlist` with the keys in the map; emit as written |
| `\newcommand\novaimatge{\includegraphics[width=14pt]{write}}` | packtpub.tex:156 | yes | alias; inline `\includegraphics[width=14pt]{write}` as the `logo=` value |
| `\renewcommand\logowidth{14pt}` | packtpub.tex:157 | yes | a one-value redefinition of a bclogo macro; bclogo.sty and its manual were not read, so that `\logowidth` is a documented parameter is not established; the emitter prints the same single preamble line |
| `\let\shline\hline` + `\def\hline{\noalign{\vskip3pt}\shline\noalign{\vskip4pt}}` | packtpub.tex:161-162 | yes | fixed expansion of one kernel command plus two kernel skips, no conditional or counter; inline each `\hline` as `\noalign{\vskip3pt}\hline\noalign{\vskip4pt}` (`tbl.tabular`, `sp.manual-space`); the gaps are what keeps the `|` rules from touching the horizontal rules (prose at :609) |
| `\tikzset` styles `punktchain` `peu` `line` `element` | packtpub.tex:39-67 | yes | never used in the body; drop (no printed effect) |
| dead code after `\end{document}` (a `\titleformat` with `\shade`, a `pgfonlayer` fragment) | packtpub.tex:746-771 | yes | not typeset; ignore |

## Content-opaque
none (write.png is a shipped asset included through `\includegraphics`, packtpub.tex:156; typos in the sample text are content, not template: `\ dots` at :557 and :561, `\ hline` at :733)

## Lib changes
- New ways proposed: `NEW:box.bclogo` (`bclogo`, CTAN, TeX Live and MiKTeX, LPPL 1.3, Maxime Chupin, v3.15 of 2024-01-23; ctan.org/pkg/bclogo read: "colorful boxes with a title and logo", TikZ or PSTricks as graphics engine, no hard engine requirement stated; pdfLaTeX with the `tikz` option). W1: on CTAN. W2: key=value options (`logo`, `couleur`, `barre`, `noborder`, `marge`, `ombre`, `couleurOmbre`, `blur`) and the package option `tikz`. W3: generic titled boxes with a logo, not tied to this document. W4: one `\usepackage` line and a `bclogo[keys]{title}` environment wrapped round node content. Merge candidate: it is the same type as `box.tcolorbox` and `box.awesomebox` (a titled box with an icon), kept as its own line because those lines name other packages; the package draws its box with TikZ internally, which is not template artwork, as `thm.tcolorbox` also loads TikZ.
- Considered, not proposed: `xspace` (load-only, never called), `scrhack` (load-only compat switch of the KOMA bundle, filed under `head.titlesec`; the lib rejected the same type as `sys.compat-load` in v4).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
