yes

# 0123-auriga: Auriga (Anish Athalye's minimalist Beamer theme, vendored starter)

- Unverified: read from the source, not compiled.
- Source: Source/0123-auriga/ (origin: https://latextemplates.com/downloads/auriga.zip; licence: MIT per manifest, and main.tex:1 "github:anishathalye/auriga, MIT")
- Kind: presentation
- Lib: v2
- Engine: needs XeLaTeX (the theme loads `fontspec` unconditionally, beamerthemeauriga.sty:11, and picks system fonts by name, beamerthemeauriga.sty:24-35; main.tex:3-10 says xelatex; LuaLaTeX would also run `fontspec`)
- Look carried by: zip-local (the two theme styles `beamerthemeauriga.sty` and `beamercolorthemeauriga.sty` set every font, colour, template and list spacing on top of beamer; main.tex adds three colour names, `tikz`, and the title data)
- Class origin: tex-distribution-unbundled (class `beamer`, not in the zip; the two `.sty` files are zip-local themes, not classes: ctan.org/pkg/beamertheme-auriga and ctan.org/pkg/auriga are both 404, and the copy is a modified vendored one, see Verdict)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (beamerthemeauriga.sty 118 lines, beamercolorthemeauriga.sty 29 lines, main.tex 85 lines, whole files)

## Verdict
The deck is `class.beamer` plus two small zip-local theme styles. Both styles are straight-line declarations: package loads, `fontspec` calls, `\setbeamerfont`/`\setbeamercolor`/`\setbeamertemplate` lines whose bodies are beamer insert macros and kernel spacing, a few lengths, and one `\xpatchcmd` on `\itemize`. That patch only picks `\itemsep` by nesting depth (3ex, 0.5ex, 0.5ex), which an emitter reduces to a per-list `\setlength{\itemsep}{...}` chosen at emit time. No counters, no output routines, no drawing in the theme. The only picture is a TikZ figure inside a `figure` float, which is content. Answer `yes`, with the one caveat recorded under Bespoke code (a stricter reader could call the `\itemize` patch irreducible).

## Blockers
none

## Class setting
- Class: `class.beamer` options: `14pt`, `aspectratio=169` (main.tex:11)
- Class-native vocabulary used: `frame` environment and its title argument (main.tex:29, 34, 42, 66, 77), frame option `fragile` (main.tex:66), `\titlepage` (main.tex:30), `\title` `\author` `\and` `\inst` `\institute[short]{...}` (main.tex:21-23), `columns` and `column{0.5\linewidth}` (main.tex:43-52), `\usetheme` `\usecolortheme` (main.tex:14-15), `\usefonttheme` (beamerthemeauriga.sty:27), template and insert macros `\setbeamertemplate`, `\setbeamercolor`, `\setbeamerfont`, `\usebeamerfont`, `\usebeamercolor`, `\inserttitle` `\insertauthor` `\insertinstitute` `\insertframetitle` `\insertframenumber` `\insertcaption` (beamerthemeauriga.sty:56-117), `\beamertemplatenavigationsymbolsempty` (beamerthemeauriga.sty:86). Beamer's own source was not read (not in the zip).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:11 | `class.beamer` | options 14pt, aspectratio=169 |
| page size and type size | main.tex:11 | `page.class-options` | 14pt body size, 16:9 frame |
| theme selection | main.tex:14-15; beamerthemeauriga.sty:27 | `slide.beamer-theme` | `\usetheme{auriga}` and `\usecolortheme{auriga}` name the zip-local themes (the reduction inlines their contents, rows below); `\usefonttheme{professionalfonts}` is published |
| font engine and faces | beamerthemeauriga.sty:11, 24-25, 29-35 | `font.fontspec` | `\newfontfamily\Raleway[Ligatures=TeX]{Nimbus Sans}`, `\newfontfamily\Lato[Ligatures=TeX]{Nimbus Sans}`; `\setsansfont{Nimbus Sans}[UprightFont=*, ItalicFont=* Italic, BoldFont=* Bold, BoldItalicFont=* Bold Italic]`; `\setmonofont{DejaVu Sans Mono}` |
| math font scaling | beamerthemeauriga.sty:8 | `font.exscale` | `\RequirePackage{exscale}`, no options |
| font roles | beamerthemeauriga.sty:37-42 | `slide.beamer-template` | `\setbeamerfont`: title page family=\Raleway; title page title size=\LARGE series=\bfseries; title page author size=\footnotesize; title page institute size=\scriptsize; frametitle family=\Raleway size=\large series=\bfseries; caption size=\footnotesize |
| type sizes and bold | beamerthemeauriga.sty:38-42 | `font.size-commands`, `mark.kernel` | `\LARGE` `\large` `\footnotesize` `\scriptsize`; `\bfseries` (the values inside the font roles) |
| colour names | main.tex:17-19; beamercolorthemeauriga.sty:8-9 | `color.xcolor` | `\definecolor` red 181,23,0; blue 0,118,186; gray 146,146,146 (all RGB); lightgray 245,246,250; darkgray 79,79,79 |
| colour roles | beamercolorthemeauriga.sty:16-29 | `slide.beamer-template` | palette primary fg=black,bg=white; secondary fg=black,bg=white; tertiary bg=black,fg=white; quaternary fg=black,bg=white; structure fg=darkgray; item fg=black; page number in head/foot fg=structure.fg; frametitle fg=black |
| local colour override | main.tex:27-32 | `slide.beamer-template` | `\setbeamercolor{page number in head/foot}{fg=white}` inside a brace group around the title frame |
| title data | main.tex:21-23 | `front.class-native` | `\title`, `\author{\underline{...} \inst{1} \and ...}`, `\institute[shortinst]{\inst{1} ...}` |
| author underline | main.tex:22 | `mark.kernel` | kernel `\underline` on one author (inline markup in content) |
| title page layout | beamerthemeauriga.sty:93-102; main.tex:29-31 | `slide.beamer-template` | template `title page`: centred block, title (font title page title, colour title page), author, institute separated by `\\[1.5ex]`, `\\[2ex]`, `\\[1ex]`, framed by `\vskip5ex plus 1filll` and `\vskip0pt plus 1filll` |
| title page spacing and centring | beamerthemeauriga.sty:95-101 | `sp.manual-space`, `sp.ragged` | `\vskip`, `\\[len]`; `centering` environment (ragged2e loaded at :9) |
| footer and page number | beamerthemeauriga.sty:105-111 | `hf.class-native`, `slide.beamer-template` | template `footline`: `\hfill`, colour and font `page number in head/foot`, `\hspace{2em}`, `\insertframenumber`, `\kern1em`, `\vskip2ex` |
| frame title | beamerthemeauriga.sty:114-118; main.tex:34 | `slide.beamer-template` | template `frametitle`: `\nointerlineskip`, `\vskip2ex`, font and colour frametitle, `\insertframetitle` |
| frames | main.tex:29, 34, 42, 66, 77 | `class.beamer` | `frame` with title argument; `[fragile]` on the verbatim frame |
| navigation symbols | beamerthemeauriga.sty:86 | `slide.beamer-template` | `\beamertemplatenavigationsymbolsempty` (navigation symbols template emptied) |
| bullet lists | main.tex:35-39, 45-50, 78-82; beamerthemeauriga.sty:56-58 | `list.kernel`, `slide.beamer-template` | `itemize`; `\setbeamertemplate{itemize item}[circle]`, `itemize subitem` `[circle]`, `itemize subsubitem` `[circle]` |
| list spacing by depth | beamerthemeauriga.sty:59-72 | `sp.lengths` | `\itemsep` 3ex at depth 1, 0.5ex at depth 2 and 3 (reduction of the `\xpatchcmd`, Bespoke code row 2) |
| columns | main.tex:43-52 | `cols.minipage` | beamer `columns` with two `column{0.5\linewidth}` (beamer builds each column as a parbox of that width) |
| load-only package | beamerthemeauriga.sty:10 | `page.adjustwidth` | `changepage` loaded; no `adjustwidth` environment is called in the theme or the sample |
| display-maths spacing | beamerthemeauriga.sty:75 | `sp.lengths` | `\belowdisplayshortskip` = 2ex (no display maths in the sample) |
| figure float | main.tex:53-61 | `fig.graphicx` | `figure` with `\centering` and `\caption`; no `\includegraphics` |
| caption look | beamerthemeauriga.sty:42, 78-83; main.tex:60 | `cap.kernel`, `slide.beamer-template`, `sp.lengths` | `\caption{...}`; template `caption` prints only `\insertcaption` in font caption (no label or number); `\abovecaptionskip` 2ex, `\belowcaptionskip` 1ex |
| code listing | main.tex:66-74 | `code.verbatim` | `verbatim` inside a `fragile` frame |
| figure artwork | main.tex:12, 55-59 | `art.tikz` | `tikz` loaded, `tikzpicture[scale=1.6]` grid and polygon inside the figure: content, not template |

Not used by the sample or the theme: sectioning, theorems, tables, bibliography, index, cross-references, language, PDF metadata, overlays, notes.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `beamerthemeauriga.sty` as a whole (zip-local, vendored with fonts swapped: main.tex:3-10, beamerthemeauriga.sty:18-22 say upstream hardcodes Raleway, Lato and Hack) | beamerthemeauriga.sty:1-118 | yes | Inline into the preamble: `\usepackage` of `exscale`, `ragged2e`, `changepage`, `fontspec` (:8-11); the `font.fontspec` calls (:24-35); `\usefonttheme{professionalfonts}` (:27); the `\setbeamerfont` lines (:37-42); lengths (:75, 78-79); `\setbeamertemplate` lines (:56-58, 80-83, 93-102, 105-111, 114-118); `\beamertemplatenavigationsymbolsempty` (:86). Every item is a published command with values; the `\usetheme{auriga}` line then names nothing zip-local. |
| `\xpatchcmd{\itemize}` with `\ifnum\@itemdepth=1/2/3` | beamerthemeauriga.sty:59-72 | yes | Its whole effect is `\setlength\itemsep` of 3ex, 0.5ex, 0.5ex for itemize depth 1, 2, 3. The emitter knows each list's depth, so it writes `\setlength{\itemsep}{<len>}` (`sp.lengths`) as the first line of each itemize body, or `\setlist[itemize,<n>]{itemsep=<len>}` (`list.enumitem`, whose fit with beamer's own lists was not checked here). `xpatch` itself edits code, so it fails W2 and is not proposed as a way; the reduction drops it. enumerate lists are not touched by the patch. |
| template bodies: `title page`, `footline`, `frametitle`, `caption` | beamerthemeauriga.sty:80-83, 93-102, 105-111, 114-118 | yes | Straight-line bodies made of beamer `\use...`/`\insert...` macros, `\vskip`, `\hspace`, `\kern`, `\hfill`, `\\[len]` and the `centering` environment: `slide.beamer-template` with `sp.manual-space` and `sp.ragged`. No conditionals, counters or boxes. |
| `beamercolorthemeauriga.sty` (zip-local) | beamercolorthemeauriga.sty:8-29 | yes | Two `\definecolor` lines (`color.xcolor`) and `\setbeamercolor` lines (`slide.beamer-template`), listed in the colour rows. |
| `\newcommand{\samelineand}{\qquad}` | beamerthemeauriga.sty:48 | yes | Alias for `\qquad` (`sp.manual-space`); never called in main.tex, so nothing to emit. |
| `\newfontfamily\Raleway` and `\Lato` | beamerthemeauriga.sty:24-25 | yes | Created by `fontspec`; both point to Nimbus Sans, used only as `family=\Raleway` in `\setbeamerfont` (:37, 41). Part of the `font.fontspec` row. |

Stricter re-reading, recorded for the reviewers: if the `\xpatchcmd` on beamer's `\itemize` internals (beamerthemeauriga.sty:59-72) were counted as irreducible hand-written conditional logic, it would be `BESPOKE/class` and the answer `no`. By the rubric it is a length per depth, so it reduces.

## Content-opaque
- TikZ picture (grid and polygon) inside the figure float, main.tex:55-59 (`art.tikz`, figure content).
- Missing assets: the fonts Nimbus Sans and DejaVu Sans Mono are named by system font name, beamerthemeauriga.sty:24-35, and are not shipped (upstream Raleway, Lato and Hack are replaced, beamerthemeauriga.sty:18-22); ship or install them.

## Lib changes
- New ways proposed: `font.exscale` `exscale` (Standard LaTeX base; ctan.org/pkg/exscale: "Implements scaling of the cmex fonts"), pdf engine, load-only `\usepackage{exscale}`. W1: part of the LaTeX base distribution. W2: no options, a load-only switch in the same manner as `cols.balance` and `pg.emptypage`. W3: serves any document with Computer Modern maths at sizes above 10pt, not this theme. W4: one preamble line. No existing way fits: `font.size-commands` selects sizes and does not scale the math extension font; `font.unicode-math` and `font.newtx` replace the maths fonts.
- Considered, not proposed: `xpatch` (patches command code, fails W2).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
