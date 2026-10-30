yes

# 0483-gcard: gcard (one sheet folded twice into a greeting card)

- Unverified: read from the source, not compiled.
- Source: Source/0483-gcard/ (origin: https://mirrors.ctan.org/macros/latex/contrib/gcard.zip; licence: LPPL, README:9, manifest `lppl`)
- Kind: misc (the manifest hint says letter; the samples are four-panel greeting cards, which no other kind in the list fits)
- Lib: v4
- Engine: pdfLaTeX-compatible (the sample loads `palatino` and `geometry`, gcardex.tex:13-14; gcard.sty loads `textpos`, `graphicx`, `calc`, gcard.sty:11-13; no fontspec or Lua. The `dvips` driver option at gcardex.tex:14 is, by the sample's own comment, ignored under pdftex, gcardex.tex:4-8; not tested here)
- Look carried by: mixed (the four-panel sheet layout is in gcard.sty, a published CTAN/TeX Live package that the zip ships unchanged, so not zip-local; the sample's preamble adds the font, `landscape`, the driver option and the four margin lengths, gcardex.tex:12-24)
- Class origin: tex-distribution-unbundled (kernel `article`, gcardex.tex:12 and gcardminexample.tex:4; the zip's one style, gcard.sty, is a CTAN package, checked at ctan.org/pkg/gcard: George McBane, LPPL, version 2007-08-21, in TeX Live and MiKTeX, requires `textpos` and `graphicx`)
- Main file: gcardex.tex (other samples: gcardminexample.tex; gcard.pdf is the shipped 4-page manual, not read because no PDF renderer was available)
- Read: main yes (all 61 lines), zip-local classes and styles all (gcard.sty, 83 lines, in full; README in full; gcardminexample.tex in full)

## Verdict
Yes. The look is one published package, `gcard`, on top of kernel `article`. The sample's preamble gives it four length values, and each of the four panels is an environment whose content is plain kernel text commands. There is no zip-local macro, no artwork and no tool outside TeX. `gcard.sty` is a CTAN and TeX Live package, so it is a way (`card.gcard`) and not bespoke code; its internals (`textpos[absolute]`, `graphicx` `\rotatebox`, `calc`, `minipage`) are loaded by the package itself and need no separate emitter line. No text addressed to an AI was found in any file.

## Blockers
none

## Class setting
- Class: `class.article` options: `12pt`, `landscape` (gcardex.tex:12); `12pt` only (gcardminexample.tex:4). The source writes `12 pt` with a space; option lists ignore spaces, so it is the same option.
- Class-native vocabulary used: none beyond the kernel (`\documentclass`, `document`, `center`); no `\maketitle`, `abstract`, sectioning or lists in either sample.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | gcardex.tex:12; gcardminexample.tex:4 | `class.article` | 12pt, landscape (main); 12pt (minimal) |
| paper size and orientation | gcardex.tex:12 | `page.class-options` | `landscape`, `12pt`; no paper size given, so the class default |
| page geometry (called only to carry orientation and the driver) | gcardex.tex:14, comment gcardex.tex:4-8 | `page.geometry` | driver option `dvips`; no margin keys; the comment says it is unnecessary with pdftex and the driver is ignored there (read, not tested) |
| text face | gcardex.tex:13 | `font.palatino` | package `palatino`, no options; the minimal example has no font package and keeps the default Computer Modern (gcardminexample.tex:2, :4-5) |
| font sizes in the panels | gcardex.tex:31, :48, :55 | `font.size-commands` | `\huge` (front), `\small` (inside left), `\Huge` (inside right) |
| the whole card: four panels on one sheet, two rotated 180 degrees | gcardex.tex:15; gcardminexample.tex:5; gcard.sty:41-67, :74-80 | `card.gcard` | `\usepackage{gcard}`, no package options (the one option `showboxes` is passed to `textpos`, gcard.sty:9, and is unused here) |
| panel margins | gcardex.tex:21-24; defaults gcard.sty:32-35 | `card.gcard` | `\gcguttermargin`=8 mm, `\gcedgemargin`=`\gcguttermargin`, `\gctopmargin`=6 mm, `\gcbottommargin`=`\gctopmargin`; package default 0.2 in each; must be set before `\begin{document}` because the panel sizes are computed at `\AtBeginDocument` (gcard.sty:69-77) |
| front cover panel | gcardex.tex:29-34; gcardminexample.tex:9-12 | `card.gcard` | `frontcover` environment (gcard.sty:41-47), content in a minipage of `\panelwidth` by `\panelheight`, vertically centred, rotated 180 degrees |
| back cover panel | gcardex.tex:38-43 | `card.gcard` | `backcover` environment (gcard.sty:49-55), same box, placed one panel to the right, rotated 180 degrees |
| inside left panel | gcardex.tex:46-50 | `card.gcard` | `insideleft` environment (gcard.sty:57-61), not rotated, second row |
| inside right panel | gcardex.tex:53-59; gcardminexample.tex:14-17 | `card.gcard` | `insideright` environment (gcard.sty:63-67), not rotated, second row, second column |
| header and footer | gcard.sty:71 | `card.gcard` | fixed by the package: `\pagestyle{empty}` at begin document; the sample sets nothing |
| text alignment in panels | gcardex.tex:30, :39, :47, :54-58 | `sp.ragged` | `\centering` in three panels; `center` environment in the fourth (same effect, comment at gcardex.tex:54) |
| italic text | gcardex.tex:32, :56 | `mark.kernel` | `\textit{...}` |
| manual spacing and line breaks | gcardex.tex:32, :56, :40, :42; gcardminexample.tex:10 | `sp.manual-space` | `\\` line breaks; `\vfill` then `\vspace{.5 cm}` to push the back-cover line down |

Not used by either sample, so no row: title block, abstract, contents, headings, numbering, lists, quotes, notes, maths, theorems, floats, tables, captions, code, boxes, bibliography, index, cross-references, colour, background, language, PDF metadata.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `gcard.sty` (`\newenvironment` x4, six `\newlength`, one `\newsavebox`, `\AtBeginDocument` block, `\DeclareOption{showboxes}`) | gcard.sty:9-82 | not bespoke: published on CTAN and in TeX Live, shipped here unchanged | `card.gcard` with its four lengths and four environments. No `\newcommand`, `\def`, counter or conditional in the file (grep count 0) |
| the samples' own definitions | gcardex.tex, gcardminexample.tex | none exist | the only assignments are `\setlength` on the package's four margin lengths, gcardex.tex:21-24 |

Observation, not a blocker: the origin call at gcard.sty:80 passes `\gcedgemargin` and `\gcbottommargin` although the comment above it (gcard.sty:78-79) says "upper left corner"; both samples give top and bottom the same value, so it has no effect on them.

## Content-opaque
none (the panel texts, the accent in `McB\"{u}chau` at gcardex.tex:41 and `\ldots` at gcardex.tex:33 are plain text content)

## Lib changes
- New ways proposed: none. `card.gcard` is already in the lib (v4) with its source "not read"; this zip reads it: option `showboxes` (gcard.sty:9), loads `textpos` with `absolute`, `graphicx` and `calc` (gcard.sty:11-13), sets `\pagestyle{empty}` at begin document (gcard.sty:71), default margins 0.2 in (gcard.sty:32-35), panel size formulas (gcard.sty:74-77); the four lengths and four environments in the lib line are confirmed. Considered: `textpos` as a separate way (`pg.textpos`), not used, because the package loads it itself and the sample never calls it.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
