yes

# 0756-beamertheme-upenn-bc: beamer colour themes in the colours of the University of Pennsylvania and Boston College

- Unverified: read from the source, not compiled.
- Source: Source/0756-beamertheme-upenn-bc/ (origin: https://mirrors.ctan.org/macros/latex/contrib/beamer-contrib/themes/upenn-bc.zip; licence: LPPL 1.3 or later, maintained by Georg Strasser, README:33-38 and the licence header of every .tex and .sty)
- Kind: presentation
- Lib: v6
- Engine: pdfLaTeX-compatible (the sample passes the driver option `dvips`, beamerBCstyle.tex:21; the README lists .ps outputs, README:25-26; the driver is a class option and the look does not depend on it, so an emitter for pdfTeX drops it)
- Look carried by: mixed (the colour palette is in the two zip colour-theme files, the frame structure and the Warsaw look come from the unbundled beamer class and its `Warsaw` theme)
- Class origin: tex-distribution-unbundled
- Main file: beamerBCstyle.tex (other samples: none; beamerPENNstyle.pdf is shipped as output only, there is no beamerPENNstyle.tex)
- Read: main yes, zip-local classes and styles all (color/beamercolorthemegoeagles.sty and color/beamercolorthemepenn.sty); the beamer class and the Warsaw theme are not in the zip and were not read

## Verdict
The sample is a short beamer deck in the stock `Warsaw` theme. The only template code in the zip is two colour-theme files that hold nothing but `\definecolor` and `\setbeamercolor` calls, so they reduce to `color.xcolor` and `slide.beamer-template`. The sample defines no macro, counter or picture, and the body uses beamer's own frames, blocks and theorem environments. Every component has a lib way, no bespoke code is irreducible and there is no ART, so the answer is yes. This zip is evidence about the class and beamer-theme dimension: the structure is carried by a published class and the zip adds a palette.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `dvips` (a driver option, beamerBCstyle.tex:21; no aspect-ratio, font-size or `handout` option is given)
- Class-native vocabulary used: `frame` environment and `\frame{...}` (beamerBCstyle.tex:37, 45, 91), `\frametitle` (46, 62, 77, 121), `\titlepage` (37), `\sectionpage` (41, 87), `\institute` (32), optional short-title arguments of `\title` `\author` `\section` (30, 31, 40), `exampleblock` and `alertblock` environments with a title argument (108, 114), the built-in `definition`, `theorem` and `proof` environments (92, 98, 102), overlay specification on `itemize` (122), theme calls `\usetheme` and `\usecolortheme` (22, 23), `\setbeamercolor` and `\mode<..>` inside the colour themes.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | beamerBCstyle.tex:21 | `class.beamer` | option `dvips` (driver choice, dropped under pdfTeX) |
| presentation theme | beamerBCstyle.tex:22 | `slide.beamer-theme` | `\usetheme{Warsaw}` |
| colour theme | beamerBCstyle.tex:23 (line 24 is a commented `\usecolortheme{penn}`) | `slide.beamer-theme` | `\usecolortheme{goeagles}`; theme name is the parameter; the theme file is shipped or inlined (see Bespoke code) |
| colour definitions, BC | color/beamercolorthemegoeagles.sty:25-28 | `color.xcolor` | `BCmaroon` cmyk 0.40,1,0.60,0.30; `BCschwarz` cmyk 0,0,0,1; `BCrot` cmyk 0,1,1,0; `BCgold` cmyk 0.19,0.27,0.67,0.12 |
| colour definitions, Penn | color/beamercolorthemepenn.sty:25-27 | `color.xcolor` | `hellrot` RGB 180,0,0; `pennrot` RGB 140,22,24; `pennblau` RGB 0,25,70 |
| beamer colour roles, BC | color/beamercolorthemegoeagles.sty:30-57 | `slide.beamer-template` | `\setbeamercolor` (and the starred form) of `structure` fg=BCgold; `palette primary` to `quaternary` fg/bg; `titlelike`; `block title`, `block title alerted`, `block title example`; `block body` (parent, use, `bg=block title.bg!10!white`), `block body alerted`, `block body example`; `sidebar`; `palette sidebar primary` to `quaternary`; `separation line` and `fine separation line` set empty; `item projected` |
| beamer colour roles, Penn | color/beamercolorthemepenn.sty:29-56 | `slide.beamer-template` | the same role names; mixes such as `pennrot!75!pennblau`, `alerted text.fg!75!bg`, `block title.bg!10!bg` |
| beamer mode switch | color/beamercolorthemepenn.sty:23, 58-59; color/beamercolorthemegoeagles.sty:23, 59-60 | `slide.beamer-mode` | `\mode<presentation>` ... `\mode<all>` around the colour settings |
| language | beamerBCstyle.tex:25 | `lang.babel` | `english` |
| text font | beamerBCstyle.tex:27 | `font.lmodern` | `lmodern` |
| encoding | beamerBCstyle.tex:28 | `font.fontenc-t1` | `fontenc` with `T1` |
| title block and title page | beamerBCstyle.tex:30-33, 37 | `front.class-native` | `\title[Color Themes]{..\\..}`, `\author[Georg Strasser]{..}`, `\institute{Boston College}`, `\date{March 2013}`, `\frame{\titlepage}`; the `\\` inside the title is a line break (`sp.manual-space`) |
| sectioning and section pages | beamerBCstyle.tex:40-43, 86-89 | `head.class-native` | `\section[short]{long}`, `\subsection{..}`, `\frame{\sectionpage}`; the look (navigation bar of Warsaw) comes from the theme |
| frames and frame titles | beamerBCstyle.tex:45-46, 61-62, 76-77, 91, 121, 139 | `class.beamer` | `frame` environment, `\frame{..}`, `\frametitle{..}` |
| lists | beamerBCstyle.tex:48-51, 63-73, 122-135 | `list.kernel` | `enumerate`, `itemize`, nested `itemize` |
| overlays | beamerBCstyle.tex:122 | `slide.beamer-mode` | `\begin{itemize}[<+-\| alert@+>]`, an overlay specification |
| theorem-like statements | beamerBCstyle.tex:92-94, 98-104 | `thm.class-native` | beamer's built-in `definition`, `theorem`, `proof` (no `\newtheorem` in the sample) |
| blocks | beamerBCstyle.tex:107-117 | `class.beamer` | `exampleblock{Example}` and `alertblock{An Old Alert}`; the block colours are the `block title example`, `block title alerted`, `block body *` roles set above |
| emphasis | beamerBCstyle.tex:79 | `mark.kernel` | `\emph` |
| manual spacing | beamerBCstyle.tex:54 | `sp.manual-space` | `\vspace{0.3cm}` |
| inline maths | beamerBCstyle.tex:47 | `math.kernel` | one inline `$\mathrm{..}$` with `\!` `\;` spacing and `\scriptstyle` `\displaystyle`; it is a hand-spaced logo inside running text, so content |
| page geometry, headers, footers, numbering | not set in the sample | none needed | beamer defaults and the Warsaw footline apply; nothing to emit |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `beamercolorthemegoeagles.sty` | color/beamercolorthemegoeagles.sty:20-60 | yes | `\definecolor` calls (`color.xcolor`) and `\setbeamercolor` calls (`slide.beamer-template`) inside `\mode<presentation>`; no logic. It is the CTAN package `beamertheme-upenn-bc` (W1), so a published colour theme loaded with `\usecolortheme{goeagles}`; an emitter can also inline the same lines in the preamble. |
| `beamercolorthemepenn.sty` | color/beamercolorthemepenn.sty:20-59 | yes | the same reduction: three `\definecolor` and `\setbeamercolor` lines for the roles listed above. |
| `\typeout` banner and `\ProvidesPackage` | color/beamercolorthemepenn.sty:20-21; color/beamercolorthemegoeagles.sty:20-21 | yes | a log message and a file declaration, no typeset effect; dropped. |
| `\xspace` after `\LaTeX` in the title | beamerBCstyle.tex:26, 30 | yes | `xspace` is only loaded for one inline use in title text; expands to `\LaTeX\ beamer` (a control space) in the content string, as the v4 ruling on `\xspace` (a helper with no node content to wrap) reduces by inline expansion. Considered: `xspace` package; no new way. |
| hand-spaced `LaTeX` logo in maths | beamerBCstyle.tex:47 | yes | inline maths text, copied as content, not a macro. |

The sample defines no `\newcommand`, `\def`, counter, conditional or environment. The README says to use `\usepackage{goeagles}` (README:20, repeated in beamerBCstyle.tex:79), while the sample itself uses `\usecolortheme{goeagles}` (beamerBCstyle.tex:23); the sample's form is the working one for a beamer colour theme.

## Content-opaque
none (the Cicero quotations at beamerBCstyle.tex:109 and 115 and the installation paths at 67-71 are text content)

## Lib changes
- New ways proposed: none (considered: `xspace` package, which the lib change log v4 already rejected as a way and which reduces here by inline expansion)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes: beamer and the `Warsaw` theme are published (TeX Live), shipped with the distribution and not in the zip, so their source was not read. W1 for the two colour themes rests on the origin path under `macros/latex/contrib/beamer-contrib/themes/` on CTAN and one read of https://ctan.org/pkg/beamertheme-upenn-bc (the page exists, Georg Strasser, LPPL 1.3, v1.0; the fetch summary also made a claim about TeX Live naming that was not relied on). Both themes are described by their author as unofficial approximations of the university colours (README:6, beamerBCstyle.tex:56). Nothing in the zip is addressed to an AI.
