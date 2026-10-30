yes

# 0549-chalk-annotate: chalk-annotate (hand-drawn chalk annotations for Beamer)

- Unverified: read from the source, not compiled.
- Source: Source/0549-chalk-annotate/ (origin: https://mirrors.ctan.org/macros/unicodetex/latex/chalk-annotate.zip; licence: MIT)
- Kind: presentation
- Lib: v4
- Engine: needs XeLaTeX (the author states "XeLaTeX or LuaLaTeX": README.md:149, chalk-annotate-doc.tex:236, `% !TEX program = xelatex` at chalk-annotate-doc.tex:1; the CTAN page says it works with XeLaTeX and LuaLaTeX and does not mention pdfLaTeX. The .sty itself loads only `tikz`, `graphicx`, `calc` and has no engine-specific code, chalk-annotate.sty:19-22, but pdfLaTeX support is not stated, so the way is tagged xe/lua.)
- Look carried by: mixed (the sample is the stock beamer `default` theme with preamble overrides at chalk-annotate-doc.tex:13-27; the published `chalk-annotate` package carries the annotation marks)
- Class origin: tex-distribution-unbundled (`beamer`, not in the zip; `chalk-annotate.sty` is a CTAN package, read at ctan.org/pkg/chalk-annotate, so it is not zip-local)
- Main file: chalk-annotate-doc.tex (other samples: none; chalk-annotate-doc.pdf is the compiled doc, not read)
- Read: main yes, zip-local classes and styles all (chalk-annotate.sty, 118 lines; no .cls)

## Verdict
The zip is the CTAN package `chalk-annotate` (inline text marks drawn by pre-rendered chalk PNG overlays) and its beamer documentation deck. The deck's own look is stock beamer plus declarative preamble settings and kernel rules, all covered by existing ways. The package itself passes W1 (CTAN, v1.1, MIT), W2 (a colour name from a closed list of five, plus one path string), W3 (any text span in any document) and W4 (one `\usepackage` line plus an inline wrapper around a node's content), so it is proposed as one new mark way. There is no irreducible code, no template-defining artwork and no outside tool for what the sample uses. Answer yes, with the caveats under Bespoke code (assets to ship, `generate-colors.py` not shipped).

## Blockers
none

## Class setting
- Class: `class.beamer` options: `aspectratio=169`, `11pt` (chalk-annotate-doc.tex:6)
- Class-native vocabulary used: `frame` environment with optional `[c]` (chalk-annotate-doc.tex:33) and a `{title}` argument (:45); `\usetheme` (:13); `\setbeamertemplate` (:14, :15, :24); `\setbeamercolor` (:20, :21); `\setbeamerfont` (:22); `\insertframenumber` and `\inserttotalframenumber` (:16); `\insertframetitle` (:25). No overlays, no `\title`/`\maketitle`, no `\section`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | chalk-annotate-doc.tex:6 | `class.beamer` | aspectratio=169, 11pt |
| CJK support (loaded, no CJK text in the body: the only non-ASCII characters are `·` `×` `—` at :115, :150, :211, :244) | chalk-annotate-doc.tex:8 | `lang.cjk` | `ctex` package, no options |
| inline annotation marks (ellipse, underline, box, arrow, strike, circle) | chalk-annotate-doc.tex:9; chalk-annotate.sty:53-116 | `slide.chalk-annotate` | `\usepackage{chalk-annotate}`; wrappers `\hlellipse` `\hlunderline` `\hlbox` `\hlarrowright` `\hlstrike` `\hlcircle`, each `[colour]{content}`, colour in red (default), blue, green, orange, purple; optional `\annsetpath{dir}` (sty:26) |
| marks used in body | chalk-annotate-doc.tex:62, :100-108, :119-123, :140-144, :159-181, :189-194 | `slide.chalk-annotate` | the five colours across the four kinds; `\hlbox[green]{$\beta_1 < 0$}` (:192) wraps inline math; `\hlellipse[blue]{$\beta_1$}` (:201) sits inside a display formula |
| beamer theme | chalk-annotate-doc.tex:13 | `slide.beamer-theme` | `\usetheme{default}` |
| navigation symbols off | chalk-annotate-doc.tex:14 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` |
| footline (page counter at right) | chalk-annotate-doc.tex:15-17 | `slide.beamer-template` | `\setbeamertemplate{footline}{\hfill\insertframenumber{}/\inserttotalframenumber\hspace{1em}\vspace{0.5em}}` |
| footline spacing | chalk-annotate-doc.tex:16 | `sp.manual-space` | `\hfill`, `\hspace{1em}`, `\vspace{0.5em}` |
| accent colour | chalk-annotate-doc.tex:19 | `color.xcolor` | `\definecolor{accent}{HTML}{C0392B}` |
| frame title colour, bullet colour | chalk-annotate-doc.tex:20-21 | `slide.beamer-template` | `\setbeamercolor{frametitle}{fg=black}`, `\setbeamercolor{itemize item}{fg=accent}` |
| frame title font | chalk-annotate-doc.tex:22 | `slide.beamer-template` | `\setbeamerfont{frametitle}{size=\large, series=\bfseries}` (the values are `font.size-commands` and `mark.kernel` switches) |
| frame title template with accent rule | chalk-annotate-doc.tex:24-27 | `slide.beamer-template` | body `\vspace{0.5em}\insertframetitle\par\vspace{-0.2em}{\color{accent}\rule{2cm}{2pt}}\vspace{0.2em}` |
| title rule under the frame title | chalk-annotate-doc.tex:26 | `sp.rule` | `\rule{2cm}{2pt}`, colour accent (kernel `\rule`, not artwork) |
| frame title spacing | chalk-annotate-doc.tex:25-26 | `sp.manual-space` | `\vspace{0.5em}`, `\vspace{-0.2em}`, `\vspace{0.2em}` |
| title slide (hand-laid in a `frame`, no `\maketitle`) | chalk-annotate-doc.tex:33-42 | `sp.ragged`, `font.size-commands`, `mark.kernel`, `sp.manual-space`, `color.xcolor` | `\centering`; `\Large`, `\normalsize`, `\small`; `\bfseries`; `\vspace{0.5em}` `{1em}` `{0.3em}`; `\color{gray}` |
| body text marks | chalk-annotate-doc.tex:46-51, :57, :67 | `mark.kernel` | `\textbf`, `\texttt` |
| enumerate and itemize lists | chalk-annotate-doc.tex:55-59, :68-71, :75-78, :82-86, :118-124, :188-195, :210-214, :218-222, :226-229, :235-239, :243-246 | `list.kernel` | `enumerate`, `itemize` (default labels; bullet colour from the beamer colour above) |
| list item spacing | chalk-annotate-doc.tex:118, :188 | `sp.lengths` | `\setlength{\itemsep}{0.8em}` and `{0.6em}` |
| centred frames | chalk-annotate-doc.tex:129, :151 | `sp.ragged` | `\centering` |
| small text in one frame | chalk-annotate-doc.tex:152 | `font.size-commands` | `\small` |
| tables (commands, colours, styles) | chalk-annotate-doc.tex:94-110, :135-146, :153-183 | `tbl.tabular` | `tabular` with `{ll}`, `{cl}`, `{lccccc}`; `\renewcommand{\arraystretch}{2.2}` `{2.5}` |
| table rules | chalk-annotate-doc.tex:11, :96-109 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| math packages | chalk-annotate-doc.tex:10 | `math.amsmath`, `math.amssymb` | no options |
| display formula | chalk-annotate-doc.tex:199-204 | `math.kernel` | `\[ ... \]` (content; with `amsmath` loaded) |
| vertical gaps between blocks | chalk-annotate-doc.tex:49, :53, :61, :73, :80, :93, :117, :130, :134, :197, :216, :224, :241 | `sp.manual-space` | `\vspace{0.8em}`, `\vspace{1em}`, `\vspace{0.5em}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `chalk-annotate.sty` (macros `\ann@assetpath`, `\annsetpath`, `\ann@img`, `\annmeasure`, six `\hl*` commands) | chalk-annotate.sty:16-118 | not bespoke: the file is the published CTAN package (W1) | The emitter prints `\usepackage{chalk-annotate}` and wraps a span in `\hl...[colour]{...}`; nothing in the sty is copied. |
| `\IfFileExists` switch between flat file names (`ann-ellipse-red.png`) and `assets/<colour>/ann-ellipse.png` | chalk-annotate.sty:33-37 | yes (package internal) | The zip ships the flat form (34 PNGs at the zip root, 30 used by the sty: six kinds times five colours). The emitter ships the PNGs beside the main file; `\annsetpath` only matters in directory mode. |
| `\annmeasure` sizes the image from `\wd0`, `\ht0`, `\dp0` with `\pgfmathsetlengthmacro` | chalk-annotate.sty:40-44 | yes (package internal) | Same: automatic, no parameter for the emitter. |
| Doc preamble template bodies (footline, frametitle) | chalk-annotate-doc.tex:15-17, :24-27 | yes | `slide.beamer-template` bodies of beamer insert commands, `sp.manual-space`, a kernel `\rule` (`sp.rule`) and `\color` (`color.xcolor`); no `\newcommand`, `\def`, counter or conditional in the sample. |
| `\renewcommand{\arraystretch}` in frames | chalk-annotate-doc.tex:94, :135, :153 | yes | An array parameter of `tbl.tabular`. |

Caveats that do not change the verdict:
- `generate-colors.py` (named at README.md:84-93 and chalk-annotate-doc.tex:211-212) is not in the zip. It only adds a sixth colour; the sample uses the five shipped ones. A template that needed a new colour would need that Python script, which would be `EXTERNAL`.
- Four files `ann-box-red.png`, `ann-box-blue.png`, `ann-box-orange.png`, `ann-box-purple.png` (no green) are not referenced by the sty (only `box-fill` and `box-border` are, chalk-annotate.sty:81, :85).
- The TikZ in the sty (`\tikz`, `\node`, `pgfonlayer{background}`, chalk-annotate.sty:55-86) is package internals, not a drawing in the template; the template has no TikZ picture of its own.

## Content-opaque
none (the formula at chalk-annotate-doc.tex:199-204 and the `\texttt{...}` command listings are text content; the PNG overlays are the way's shipped assets, not content)

## Lib changes
- New ways proposed: `slide.chalk-annotate` (`chalk-annotate`, CTAN, v1.1, MIT; XeLaTeX and LuaLaTeX as stated by the author; section mark). `\usepackage{chalk-annotate}` and inline wrappers `\hlellipse` `\hlunderline` `\hlbox` `\hlarrowright` `\hlstrike` `\hlcircle` with `[colour]{content}`, colour from red, blue, green, orange, purple, optional `\annsetpath{dir}`; the package ships its PNG overlays.
  - W1: on CTAN (ctan.org/pkg/chalk-annotate: description, author Zitong Zhang, MIT, v1.1 2026-04-25). W2: the colour is a name from a closed list and the content is the node's text; no code is edited. W3: serves any inline emphasis span in any document, not one deck. W4: one preamble line plus a wrapper around a node's content.
  - Not `mark.ulem` (rules and highlight drawn by TeX, no images), not `mark.contour` (text outline), not `box.fancybox`; considered: `art.tikz` (the TikZ is inside the package, the template draws no picture).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
