yes

# 0383-chronology: chronology (a horizontal timeline utility, package plus its manual)

- Unverified: read from the source, not compiled. Nothing here claims that anything compiles or looks identical.
- Source: Source/0383-chronology/ (origin: https://mirrors.ctan.org/macros/latex/contrib/chronology.zip; licence: LPPL 1.3 (manifest `lppl1.3` and one read of ctan.org/pkg/chronology; the zip's own files state no licence))
- Kind: calendar (a timeline utility, CTAN topics Planning and Calendar; the only document in the zip is its package manual, so the manifest hint is kept)
- Lib: v4
- Engine: pdfLaTeX-compatible (loads `calc`, `tikz`, `xparse` only, chronology.sty:3-5; no fontspec, no Lua; ctan.org/pkg/chronology states no engine requirement)
- Look carried by: preamble (one published CTAN package, `chronology.sty`, loaded by `\usepackage{chronology}`, chronology.pdf p.1 "Installation"; no class, no zip-local style, no sample .tex)
- Class origin: none (the zip ships no class and no .tex; the manual's own class is unknown because its source is not shipped)
- Main file: none (no .tex in the zip: the folder holds README, chronology.pdf, chronology.sty; analysed instead the style file and the documentation examples in chronology.pdf p.1-4)
- Read: main none (no sample exists), zip-local classes and styles all (chronology.sty read in full, 132 lines; README read in full, 15 lines). chronology.pdf was read as extracted text only (a data-only zlib pass written to the scratchpad; no PDF renderer is installed), so the drawn figures and the manual's own layout were not seen.

## Verdict
The zip is the CTAN release of the `chronology` package (version 2.0, 2023-08-20 in chronology.sty:2 and README:8-9, the same version ctan.org/pkg/chronology lists, which also says TeX Live and MiKTeX carry it). Its code is therefore published (W1), not bespoke, and it is one component way: a horizontal dated timeline drawn from declarative values (years, a width, dates, colour names, opacity, a bar height, a bottom-label flag). No class or sample preamble is shipped, so nothing else needs a way, and the five timelines in the manual are outputs of the package, not hand-drawn artwork. The `yes` rests on accepting `chronology` as a doc-kind way beside `cal.kalender` and `cv.timeline`; if a reviewer files it under `art.content-package` instead, the verdict still holds, because the manual draws no template identity (it is content-opaque, not ART).

## Blockers
none

## Class setting
- Class: none shipped. The package works under any class; chronology.pdf p.1 asks only for `\usepackage{chronology}` and says no other dependencies are required. When an emitter uses it, the class comes from the host document.
- Class-native vocabulary used: none (no `\maketitle`, `abstract` or sectioning in any file the zip lets us read).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| package load | chronology.sty:2; chronology.pdf p.1 | `cal.chronology` | `\usepackage{chronology}`; the style declares no option (chronology.sty:1-5) |
| timeline environment | chronology.sty:33-39, 40-76; chronology.pdf p.1 | `cal.chronology` | `\begin{chronology}[step]{year-start}{year-stop}{timeline-width}[scaling]` ... `\end{chronology}`; step default 5 (chronology.sty:41), scaling defaults to the width (chronology.sty:44); doc examples `[5]{2009}{2020}{\textwidth}` (p.2), `[5]{1965}{2023}{\textwidth}[100ex]` and `[1]{1987}{1996}{4in}[60ex]` (p.4) |
| flipped variant | chronology.sty:32-35, 47-52, 70-74; chronology.pdf p.2 | `cal.chronology` | `chronology*` (the star flips the year labels above the axis and `\event` labels below it at -45 degrees, chronology.sty:21, 71, 85-87); footnote on p.2: not available with `\eventspan` and `\eventpoint`, which never test the flag (chronology.sty:109-128) |
| axis, ticks, year labels (inside the way) | chronology.sty:62-75 | `cal.chronology` | arrow axis `[|->]` (63), a tick every year of height .1\unit (64-65), a major tick every `step` of height .3\unit with the year printed `below=.2\unit` (`above` when flipped) (67-75) |
| scale and placement (inside the way) | chronology.sty:38, 56-57 | `cal.chronology` | `\unit` = scaling / number of years; the finished picture is `\resizebox{\timelinewidth}{!}` inside `\raisebox{2ex}`, so label text scales with the picture; not a float, no caption |
| event (legacy) | chronology.sty:81-105; chronology.pdf p.2 | `cal.chronology` | `\event[start]{end}{label}`; without start a circle of radius .2\unit, with start a rounded bar of height .4\unit; style `chronevent` fill black opacity .5 (16); label at 45 degrees (20) |
| event span | chronology.sty:109-119; chronology.pdf p.3 | `cal.chronology` | `\eventspan{start}{end}{label}[fill=black][opacity=.3][height=.2][bottom flag]`; rounded corners .05\unit; the optional last argument centres the label on the span instead of the 45 degree label (117) |
| event point | chronology.sty:123-128; chronology.pdf p.3 | `cal.chronology` | `\eventpoint{date}{label}[fill=red][opacity=1][height=.3]`; a triangle arrow of height `height`\unit |
| per-day dates | chronology.sty:130; chronology.pdf p.1 | `cal.chronology` | `\decimaldate{day}{month}{year}` expands to `(d-1)/31/12+(m-1)/12+y`, used as the date argument of any event command |
| colour names as fill values | chronology.pdf p.4 | `color.xcolor` | `blue`, `green`, `orange`, `red`, `brown`, `black` passed to the `fill` argument; `tikz` is the package that brings `xcolor` (chronology.sty:4) |
| label markup | chronology.pdf p.4 | `mark.kernel`, `color.xcolor` | label text `\textbf{\color{blue}Unix}`, `\textbf{\color{orange}Linux}` |
| font switch around a timeline | chronology.pdf p.4 | `mark.kernel` | `\sffamily` before and `\normalfont` after the second example |
| label and event style hooks (inside the way) | chronology.sty:15-23 | `cal.chronology` | `chronevent`, `chronlabel`, `chrontickslabel`, `chroneventlabel`, `eventlabel` (anchor south west, yshift .2\unit, rotate 45), `flippedeventlabel` (rotate -45), `eventlabelbottom`; overriding them with `\tikzset` would be TikZ keys, not a parameter of the way, and no shipped example does it |
| babel compatibility (inside the way) | chronology.sty:27-30 | `cal.chronology` | `handle active characters in code`, `handle active characters in nodes` |
| helper packages (inside the way) | chronology.sty:3-5 | `cal.chronology` | `calc`, `tikz`, `xparse` are loaded by the package itself; internals, not separate rows |

Not defined by this zip, so no row: page geometry (the examples take `\textwidth` or `4in` from the host page), fonts, header/footer, title block, abstract, headings, lists, theorems, tables, captions, code, bibliography, index, cross-references. The manual's own typesetting (title block with abstract, bullet lists, code listings) comes from a source that is not shipped, so it cannot be mapped and is not part of what the package defines.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `chronology.sty` as a whole: counters `step` `stepstart` `stepstop` `yearstart` `yearstop` `deltayears` (7-8), lengths `\xstart` `\xstop` `\unit` `\timelinewidth` (9-10), `\timelinebox` (11), `\newif\ifchronology@star` (32), `\newif\ifflipped` (47), the `\def` chain `\chronology@i`-`@iii` (40-76), `\DeclareDocumentCommand` for `\event` (81) `\eventspan` (109) `\eventpoint` (123), `\decimaldate` (130) | chronology.sty:1-132 | n/a: published on CTAN (W1) | not bespoke; it is the body of `cal.chronology`. The version line (chronology.sty:2) matches the CTAN version, but the zip's copy was not compared byte for byte. If it differed, the counter-driven tick loops and the `lrbox` + `tikzpicture` split across begin and end code (36-37, 61-62) would be irreducible `BESPOKE/class` plus `ART/class`, and the verdict would flip to `no`. |
| sample macros, environments, counters | none | n/a | the zip holds no .tex, so no sample defines anything |

Observations from the read (no effect on the verdict): (1) the CTAN page tags the package as Tagged-PDF incompatible, which matters only if `meta.documentmetadata` tagging is switched on. (2) By my reading of chronology.sty:58, a `year-start` that is a multiple of `step` (1965 with step 5, the p.4 example) gets its first year label one step in, at 1970; yet the p.3 extracted text lists 1965 among the labels, while the second p.3 example (1987 with step 1) starts at 1988, as the formula predicts. Either the first picture was built from another revision, or my reading is off. Not resolved, because nothing was compiled.

## Content-opaque
- Event dates and label text (chronology.pdf p.2-4): content, the values the way takes.
- The five timelines drawn in the manual (one on p.1, two on p.2, two on p.3; p.4 holds code only) are generated by the package from those values; no hand-written `tikzpicture` is in any readable file, so nothing here is ART.

## Lib changes
- New ways proposed: `cal.chronology` (component: doc-kind specific, calendar family; package `chronology`, CTAN `/macros/latex/contrib/chronology`, version 2.0; engine pdf; preamble `\usepackage{chronology}`, body `chronology` and `chronology*` environments holding `\event`, `\eventspan`, `\eventpoint` calls and `\decimaldate`). Searched the lib first (`timeline` finds only `cv.timeline`, the `moderntimeline` bars on moderncv entries; `cal.kalender` is a fixed German year grid, `cal.termcal` a term calendar of weeks; none draws a standalone dated timeline).
  - W1 Published: on CTAN, in TeX Live and MiKTeX, LPPL 1.3 (one read of ctan.org/pkg/chronology; the zip is the CTAN mirror's own archive).
  - W2 Declarative parameters: the year step, start and stop years, a width, an optional scaling length, the star flag, per event a date (decimal number), a colour name, an opacity, a bar height and a bottom-label flag; no code is edited.
  - W3 Generic: serves a kind of component, a horizontal timeline of spans, points and events over any year range, for any document.
  - W4 Printable: one preamble line and one body wrapper around a list of one-line event calls.
  - Not `art.content-package`: that row is for packages whose parameters are programs or free drawings; here they are dates, colours and lengths, as `cal.kalender` takes a year and `cv.timeline` takes year ranges. Not `art.tikz`: the picture is produced by the package, not drawn by the template.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
