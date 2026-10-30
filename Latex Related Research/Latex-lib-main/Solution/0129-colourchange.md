no

# 0129-colourchange: the colourchange package (beamer structure-colour changer) and its manual

- Unverified: read from the source, not compiled.
- Source: Source/0129-colourchange/ (origin: https://mirrors.ctan.org/macros/latex/contrib/colourchange.zip; licence: gpl3, README:66)
- Kind: misc (the sample is a package manual on `scrartcl`; the package itself, `colourchange.sty`, targets beamer presentations)
- Lib: v2
- Engine: pdfLaTeX-compatible (the sample's `\immediate\write18` line additionally needs shell escape, see Blockers)
- Look carried by: mixed (the manual's look is `scrartcl` defaults plus the preamble at colourchangedoc.tex:5-29; `colourchange.sty` is not loaded by the manual)
- Class origin: tex-distribution-unbundled (`scrartcl`, KOMA-Script, not in the zip; the package's host class `beamer` is also not in the zip)
- Main file: colourchangedoc.tex (other samples: none; `colourchange.sty` is the package under documentation, `colourchangedoc.pdf` is a 2-page build of the manual and was not read as source)
- Read: main yes, zip-local classes and styles all (one `.sty`, 156 lines, read in full; it is on CTAN, so it is not zip-local in the rubric's sense)

## Verdict
The manual's look is a published class (`scrartcl`) plus published packages, and each of those components maps to a lib way. The sample is nevertheless `no`: its preamble runs a local shell script with `\immediate\write18{./vc}` and then `\input{vc}`. That script and the `vc.tex` it generates are not in the zip. The footer fields (`\GITTag`, `\VCDateISO`, `\GITAbrHash`) get their values from git through that script, and the author's own comment at line 2 says the file does not compile without it. That is `EXTERNAL`. `colourchange.sty` itself is a published CTAN package whose user-facing surface is declarative (five options, two colour commands), so it would be a way, but the sample does not exercise it.

## Blockers
- `EXTERNAL/preamble` `\immediate\write18{./vc}` runs a shell script and `\input{vc}` reads the file it generates; neither is in the zip, and the footer macros come from it (colourchangedoc.tex:3-4, 9-10; author warning at colourchangedoc.tex:2)

## Class setting
- Class: `class.scrartcl` options: none (colourchangedoc.tex:1)
- Class-native vocabulary used: `\maketitle` with `\title` `\author` (colourchangedoc.tex:15-16, 31), `\setkomafont{pagefoot}` (colourchangedoc.tex:8), `\section`. No `\subject`, `\date`, abstract or `\KOMAoptions`. Not read: the `scrartcl` source (published class, loaded unchanged).

## Component map
Part A, the manual (colourchangedoc.tex), which is the sample.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | colourchangedoc.tex:1 | `class.scrartcl` | no options |
| page size and margins | colourchangedoc.tex:1 | `page.class-options` | none set; class defaults |
| font encoding | colourchangedoc.tex:5 | `font.fontenc-t1` | `fontenc` option `T1` |
| body font | colourchangedoc.tex:13 | `font.libertine` | package `libertine`, no options |
| mono font | colourchangedoc.tex:14 | `font.mono` | package `inconsolata`, no options |
| microtype | colourchangedoc.tex:11 | `sp.microtype` | defaults |
| page header/footer | colourchangedoc.tex:6-7, 9-10 | `hf.scrlayer-scrpage` | package `scrpage2` (obsolete KOMA predecessor of `scrlayer-scrpage`, same `\ifoot` `\ofoot` `\pagestyle{scrheadings}` interface; the package is the parameter); `\pagestyle{scrheadings}`; `\ifoot[..]{..}` and `\ofoot[..]{..}` hold the git macros (EXTERNAL, see Blockers) |
| footer font | colourchangedoc.tex:8 | `hf.scrlayer-scrpage` | `\setkomafont{pagefoot}{\small\normalfont\sffamily}` |
| footer font switches | colourchangedoc.tex:8 | `font.size-commands`, `mark.kernel` | `\small`; `\normalfont` `\sffamily` |
| URL typesetting | colourchangedoc.tex:12, 35-36 | `meta.url` | package `url`, `\url{..}` |
| title block | colourchangedoc.tex:15-16, 31 | `front.maketitle` | `\title{The colourchange package}`, `\author{Seamus Bradley}`, no `\date` (KOMA default) |
| contact block under the title | colourchangedoc.tex:33-37 | `sp.manual-space`, `sp.ragged`, `font.size-commands`, `meta.url` | `\vspace{-2\normalbaselineskip}`; `center` environment; `\small`; `\\` line break |
| headings | colourchangedoc.tex:39, 44, 49, 59, 72, 78 | `head.class-native` | six numbered `\section`s, `scrartcl` default look, no `\setkomafont{section}` |
| inline code | colourchangedoc.tex:17-29, 41-86 | `code.listings` | `\lstloadlanguages{[LaTeX]TeX}`; `\lstset{basicstyle=\ttfamily\small, commentstyle=\itshape\ttfamily\small, showspaces=false, showstringspaces=false, breaklines=true, breakautoindent=true, captionpos=t, frame=single, escapeinside={(*}{*)}}`; the body uses only `\lstinline+..+`, so `frame`, `captionpos` and `escapeinside` are set but not exercised |

The manual has no lists, floats, tables, math, theorems, footnotes, cross-references or bibliography.

Part B, `colourchange.sty` (the zip's subject; the manual does not load it, so it is outside the sample's scope but recorded because it is the template content of this zip).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| host class | README:3, 10-12; colourchange.sty:57-70 (beamer colour names) | `class.beamer` | the package is meant for beamer (README:12: other classes "at your own risk") |
| progressive structure-colour change | colourchange.sty:22-44, 99-124, 141-144 | `slide.colourchange` | options `slidechange` `framechange` `draft` `defaultstyle` `final` (`final` is declared and never used, colourchange.sty:40-42, 18); `\selectcolourchanges{first}{second}` (alias `\selectcolorchanges`, colourchange.sty:144), defaults `blue` to `dred` (colourchange.sty:132-134); `\selectmanualcolour{colour}` between frames (colourchange.sty:76-81, README:23-25); two compiles needed (README:8) |
| default look shortcut | colourchange.sty:48-51; README:34-40 | `slide.beamer-theme` | `defaultstyle` expands to `\useoutertheme[footline=authorinstitutetitle]{miniframes}` and `\useinnertheme{rectangles}` |
| structure palette | colourchange.sty:56-70 | `slide.beamer-template` | `\setbeamercolor*` for `palette primary/secondary/tertiary/quaternary`, `sidebar`, `palette sidebar *`, `titlelike`, `itemize item`, `block title`, `block body`, all derived from `structure.fg` with fixed fg/bg percentages (75, 50, 80, 10 black or white mixes) |
| named colour | colourchange.sty:132 | `color.xcolor` | `\definecolor{dred}{rgb}{0.9,0.15,0.15}`; blends written `\second@colour!N!\first@colour` (colourchange.sty:136) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\GITTag`, `\VCDateISO`, `\GITAbrHash`, `vc.tex`, script `./vc` | colourchangedoc.tex:3-4, 9-10 | no | EXTERNAL: values produced by a shell script and git; not in the zip. If the footer were dropped (the author says this at line 2) the preamble would reduce to ways listed above, but the sample as shipped does not |
| `colourchange.sty` internals: `\newif`s, `clch@*` counters, `\setcolours`, `\fractionate`, `\setstruccol`, redefinition of beamer's `\beamer@checkframetitle`, `\preto\frame`, `\AtBeginDocument`, `\AtEndDocument` writing `\inserttotalslidenumber` into `.aux` | colourchange.sty:14-18, 56-70, 87-124, 135-156 | not bespoke by the rubric's rule | The file is a published CTAN package (origin URL is the CTAN mirror), so W1 holds. An emitter prints `\usepackage[option]{colourchange}`, `\selectcolourchanges{a}{b}` and `\selectmanualcolour{c}`, and never copies this code. The internals do patch a beamer kernel macro (colourchange.sty:110-112), which is why README:58 and colourchangedoc.tex:74 list unsupported outer themes (`smoothbars`, `smoothtree`); that limit is the package's, not a lib gap |

## Content-opaque
none

## Lib changes
- New ways proposed: `slide.colourchange` `colourchange` (CTAN, GPLv3), engine pdf: a beamer add-on that moves the structure colour from one colour to another per slide or frame, or sets it by hand. W1 published: it is on CTAN (the zip's own origin). W2 declarative: five options and two colour-argument commands (colourchange.sty:22-44, 76-81, 141-144). W3 generic: serves any beamer deck, not one document; its look is a colour pair. W4 printable: one `\usepackage[opts]{colourchange}` line, one preamble command and a body command between frames. Not covered by `slide.beamer-template`, which sets a static colour and has no per-frame progression. The sample does not exercise it, so the consolidator may hold it until a zip uses it.
- Considered, no proposal: `scrpage2` (kept under `hf.scrlayer-scrpage`, package as parameter; ctan.org/pkg/scrpage2 shows it in `koma-script-obsolete`, successor `scrlayer-scrpage`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Documentation typos that do not run (they sit inside `\lstinline`): `\selectcolourchange` (colourchangedoc.tex:53) for the defined `\selectcolourchanges` (colourchange.sty:141), and `\useinnnertheme` (colourchangedoc.tex:66).
- CTAN reads used: `https://ctan.org/pkg/vc` (script-based version control for Bazaar, Git and Subversion, Unix and Windows scripts, so an external tool) and `https://ctan.org/pkg/scrpage2`.
- The zip has four files: README, colourchange.sty, colourchangedoc.pdf, colourchangedoc.tex. No `vc.tex`, no `vc` script.
