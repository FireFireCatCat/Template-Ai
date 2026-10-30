yes

# 0454-user-persona: user-persona (structured UX persona sheets)

- Unverified: read from the source, not compiled.
- Source: Source/0454-user-persona/ (origin: https://mirrors.ctan.org/macros/latex/contrib/user-persona.zip; licence: LPPL 1.3c)
- Kind: misc (a one-page persona profile sheet for UX and HCI work; the main sample is the package manual, an article)
- Lib: v4
- Engine: pdfLaTeX-compatible (inputenc/fontenc, no fontspec; `\pdfmapfile` at user-persona.sty:16 is a pdfTeX primitive)
- Look carried by: mixed (the manual page is `article` plus its own preamble, user-persona.tex:6-32; the persona sheet look is carried by the CTAN package user-persona.sty, loaded at user-persona.tex:10, which is a published package and a way of its own)
- Class origin: tex-distribution-unbundled
- Main file: user-persona.tex (other samples: user-persona-example.tex, user-persona-detailed.tex)
- Read: main yes, zip-local classes and styles all (user-persona.sty read in full; both other samples read in full; README.md read in full; the three prebuilt PDFs were not opened)

## Verdict
The zip is the CTAN release of the `user-persona` package (ctan.org/pkg/user-persona read once: the page exists, v1.0.0, LPPL 1.3c, listed for TeX Live and MiKTeX). The package is published, takes strings, a position word, a colour name and a mode word, serves any persona sheet, and prints as one `\usepackage` line plus one environment, so it passes W1 to W4 as a doc-kind way, proposed as `persona.user-persona`. Everything else in the three samples (article preamble, listings, booktabs table, thebibliography, helvet) is an existing way, no sample defines its own macro, and there is no artwork and no tool outside TeX (tcolorbox is loaded with `many`, which does not load `minted`). Even if the package were not counted as a way, its macros reduce to existing ways (see Bespoke code).

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `11pt` (user-persona.tex:6; the same in user-persona-example.tex:6 and user-persona-detailed.tex:6)
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (user-persona.tex:34-42), `abstract` (44-46), `\tableofcontents` (48), `\section` `\subsection` `\subsubsection` (50, 52, 110), `itemize` (104-106), `center` and `tabular` (235-247), `thebibliography` and `\bibitem` (301-315)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | user-persona.tex:6 | `class.article` | a4paper, 11pt |
| paper and size | user-persona.tex:6 | `page.class-options` | a4paper, 11pt |
| page geometry | user-persona.tex:7 | `page.geometry` | margin=1in |
| encodings | user-persona.tex:8-9 | `font.fontenc-t1` | inputenc utf8, fontenc T1 |
| link colours | user-persona.tex:11, 16-21 | `meta.hyperref` | colorlinks=true, linkcolor=blue, urlcolor=blue, citecolor=blue |
| external links | user-persona.tex:310, 313 | `xref.hyperref` | `\href{https://doi.org/...}{doi:...}` |
| title block | user-persona.tex:34-38, 42 | `front.maketitle` | `\title` with `\\` and `\large` subtitle, `\author` with name and `\texttt` e-mail, two-line `\date` |
| title subtitle size | user-persona.tex:35 | `font.size-commands` | `\large` |
| abstract | user-persona.tex:44-46 | `abs.kernel` | plain `abstract` environment |
| contents | user-persona.tex:48 | `toc.kernel` | `\tableofcontents`, no options |
| headings | user-persona.tex:50, 52, 110 | `head.kernel` | default section, subsection, subsubsection, no renewcommand |
| code listings | user-persona.tex:12, 23-32, 61-87 | `code.listings` | language=[LaTeX]TeX, basicstyle=\ttfamily\small, breaklines=true, frame=single, backgroundcolor=\color{gray!5}, keywordstyle=\color{blue}, commentstyle=\color{gray}, stringstyle=\color{red}; listing text is content |
| colour mixes | user-persona.tex:13, 28-31 | `color.xcolor` | `gray!5`, named blue, gray, red |
| bullet lists | user-persona.tex:104-106, 152-157, 219-222, 260-264, 267-271 | `list.kernel` | `itemize`, defaults |
| colour table | user-persona.tex:236-246 | `tbl.tabular` | `tabular{lll}` inside `center`, bold header cells |
| table rules | user-persona.tex:14, 237, 239, 245 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| centred block | user-persona.tex:235, 247 | `sp.ragged` | kernel `center` environment |
| inline marks | user-persona.tex:54, 56, 105 | `mark.kernel` | `\textbf`, `\textit`, `\texttt` |
| bibliography | user-persona.tex:54, 301-315 | `bib.thebibliography` | `thebibliography{9}`, four `\bibitem`, `\cite` in text; no BibTeX run |
| persona package load | user-persona.tex:10; user-persona-example.tex:15; user-persona-detailed.tex:15 | `persona.user-persona` | `\usepackage{user-persona}`, no options |
| persona sheet wrapper | user-persona-example.tex:19, 70; user-persona.sty:44-100 | `persona.user-persona` | `\begin{persona}{Zhang Wei}`; header band "USER PERSONA: NAME" with the name upper-cased (sty:53-56); columns 0.35 and 0.61 of `\textwidth` (sty:59, 85) fixed in the package |
| portrait | user-persona-example.tex:21; user-persona.sty:61-69, 102 | `persona.user-persona` | `\personaphoto{zhang-placeholder.jpg}`; a grey placeholder box is drawn when the file is missing |
| pull quote | user-persona-example.tex:23-25; user-persona.sty:88-92, 103 | `persona.user-persona` | `\personaquote{text}`, shown in the PersonaQuoteBg box with a PersonaQuoteBorder frame |
| identity table | user-persona-example.tex:27-32; user-persona.sty:73-79, 104 | `persona.user-persona` | `\personafact{Age}{30}` rows, key in bold with a colon |
| list card | user-persona-example.tex:34-50; user-persona-detailed.tex:36-56, 81-92; user-persona.sty:106-114 | `persona.user-persona` | `\personasection[left or right or span]{Title}{PersonaGreen or PersonaBlue or PersonaRed or PersonaDark or PersonaGrey}{\item ...}`; right is the default |
| free-content card | user-persona-example.tex:53-58; user-persona-detailed.tex:58-68, 75-79; user-persona.sty:116-122 | `persona.user-persona` | `\personacard[right or left]{Title}{colour}{content}` |
| context card | user-persona-example.tex:60-62; user-persona.sty:124 | `persona.user-persona` | `\personacontext{Title}{text}`, left by default, PersonaGrey frame |
| pill label | user-persona-example.tex:54-55; user-persona.sty:126-128 | `persona.user-persona` | `\personapill{Android 14}` |
| icon badge | user-persona-example.tex:56-57; user-persona-detailed.tex:64-67; user-persona.sty:130-142 | `persona.user-persona` | `\personabrand[fa]{\faWeixin}` or `[img]{file}` |
| persona colours | user-persona.sty:18-24 | `persona.user-persona` | PersonaDark 354254, PersonaQuoteBg FFF8DF, PersonaQuoteBorder F6B762, PersonaGreen 5CA662, PersonaBlue 5D86D6, PersonaRed E26556, PersonaGrey 8E94A0 (the manual's table at user-persona.tex:236-246 lists five) |
| sheet typeface | user-persona-example.tex:12-13; user-persona-detailed.tex:12-13 | `font.helvet` | `\usepackage{helvet}` |
| default family | user-persona-example.tex:13; user-persona-detailed.tex:13 | `font.family-default` | `\renewcommand{\familydefault}{\sfdefault}` |
| load-only lines | user-persona-example.tex:8-9; user-persona-detailed.tex:8-9 | considered: `ifxetex`, `ifluatex`, `etoolbox` | no printed effect; no command of them is called in a sample (same type as the `fixltx2e` and `etex` ruling in the v4 change log), so not a component |

## Bespoke code
The samples define no macro, environment or counter (grep of the three `.tex` files finds only `\renewcommand{\familydefault}` at user-persona-example.tex:13 and user-persona-detailed.tex:13, and a `\definecolor` shown as listing text at user-persona.tex:252). All items below sit in user-persona.sty, which is the published CTAN package, so an emitter writes `\usepackage{user-persona}` and copies none of it. The reductions are given so the verdict does not rest on that alone.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `persona` environment: macros collect facts and cards, the end code lays them out | user-persona.sty:44-100 | yes | `box.tcolorbox` header (colback=PersonaDark, coltext=white, sharp corners, boxrule=0pt, fontupper=\bfseries\large\sffamily, left=2mm, top=2.5mm, bottom=2.5mm, before skip=0pt, after skip=3mm, sty:54); two `box.minipage` columns of 0.35 and 0.61 of `\textwidth` joined by `\hfill` (sty:59, 84-85); span cards below (sty:98); `sp.manual-space` `\vspace{5mm}` (sty:99). The `\appto` and `\csappto` accumulators (sty:48-50, 104, 107, 117) only route each card to a column; an emitter does that by ordering its output, so no typesetting logic is lost |
| identity table | user-persona.sty:73-79 | yes | `tbl.tabularx` `{@{} l >{\raggedright\arraybackslash}X @{}}` with `\renewcommand{\arraystretch}{1.4}`, `\sffamily\scriptsize` (`font.size-commands`), rows `\textbf{key:} & value \\` (`mark.kernel`) |
| card box style `personasectionbox` | user-persona.sty:27-40 | yes | `box.tcolorbox` keys: colback=white, boxrule=1pt, arc=1.5mm, left=3mm, right=3mm, top=1mm, bottom=2mm, fonttitle=\bfseries\sffamily\footnotesize, colbacktitle=white, titlerule=0pt, bottomtitle=0mm, toptitle=2.5mm, boxsep=0pt, before skip=2mm, after skip=1mm; frame and title colour are the card's colour argument |
| `\personasection`, `\personacard`, `\personacontext` | user-persona.sty:106-124 | yes | the box above; title through `mark.case` `\MakeUppercase`; for `\personasection` an `list.enumitem` `itemize[leftmargin=3.5mm, nosep, itemsep=3pt, label={\tiny$\bullet$}]` with `\scriptsize\sffamily`; `\personacontext` is `\personacard` with PersonaGrey |
| quote box | user-persona.sty:89-91 | yes | `box.tcolorbox` colback=PersonaQuoteBg, colframe=PersonaQuoteBorder, boxrule=0.8pt, arc=1.5mm, left=3.5mm, right=3.5mm, top=2.5mm, bottom=2.5mm, before skip=0pt, after skip=2.5mm; `\sffamily\itshape\footnotesize` |
| `\personapill`, `\personabrand` | user-persona.sty:126-142 | yes | `\tcbox` (`box.tcolorbox`) with on line, tcbox raise base, arc and padding keys; image mode `fig.graphicx` `\includegraphics[height=3.5mm, keepaspectratio]` inside `sp.manual-space` `\raisebox`; icon mode `font.icons` (`fontawesome5`); `\enskip` after each (`sp.manual-space`) |
| `\ifstrequal`, `\IfFileExists`, `\ifx...\@empty` tests | user-persona.sty:61-62, 88, 132-133 | yes | they choose between an image and a placeholder or skip an empty field; the emitter knows which files it ships and which fields are set, so it writes the chosen branch directly. Missing-image placeholder is a `box.tcolorbox` (width=\linewidth, height=\linewidth, colback=gray!15, colframe=gray!40, halign=center, valign=center, arc=0mm, boxrule=1pt, sty:65) |
| colour declarations | user-persona.sty:18-24 | yes | `color.xcolor` `\definecolor{...}{HTML}{...}` |
| `\pdfmapfile{}` | user-persona.sty:16 | not a layout item | an empty-argument pdfTeX directive that places nothing on the page; I could not establish its effect here (pdfTeX manual not read). It sits inside the published package, so the emitter never writes it; it is why the engine line says pdfLaTeX |
| package loads | user-persona.sty:9-15 | yes | `fig.graphicx`, `box.tcolorbox` (`[many]`; tcolorbox.sty in an installed TeX tree defines `many` as raster, skins, breakable, hooks, theorems, fitting, so no `minted`), `color.xcolor`, `list.enumitem`, `tbl.tabularx`, `font.icons`; `etoolbox` is load-only for the emitter (its commands appear only inside the package) |

## Content-opaque
none. Not shipped: the two portrait files named at user-persona-example.tex:21 and user-persona-detailed.tex:21 (the package draws its placeholder box, user-persona.sty:62-68), and the example file names `alex.jpg`, `path/to/image.jpg`, `logos/slack.png` that appear only as listing text (user-persona.tex:68, 113, 226). They are figure content; ship real images when rebuilding.

## Lib changes
- New ways proposed: `persona.user-persona` `user-persona` (CTAN, listed in TeX Live and MiKTeX per ctan.org/pkg/user-persona; LPPL 1.3c; v1.0.0 dated 2026/04/20, user-persona.sty:7; engine pdf). Printed as `\usepackage{user-persona}` and a body `persona` environment `\begin{persona}{Name}` ... `\end{persona}` holding `\personaphoto{file}`, `\personaquote{text}`, `\personafact{key}{value}`, cards `\personasection[left|right|span]{Title}{colour}{\item ...}`, `\personacard[pos]{Title}{colour}{content}`, `\personacontext[pos]{Title}{content}`, and inline `\personapill{text}` and `\personabrand[img|fa]{file or icon}`; the seven `Persona*` colours are predefined. W1: released on CTAN (the zip is the CTAN archive; the CTAN page read once exists). W2: the values are strings, file names, a position word, a colour name and a mode word; the 0.35 and 0.61 column split and the header band are fixed in the package, as the sizes are in `recipe.xcookybooky`. W3: it serves any persona sheet for UX and HCI, not one document. W4: one load line plus one environment wrapper with child commands around node content. Not `box.tcolorbox` (one box, no sheet), not `cv.entries` (CV class entries), not `recipe.xcookybooky` (recipes). Same type as the lib's other single-package doc-kind ways.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
