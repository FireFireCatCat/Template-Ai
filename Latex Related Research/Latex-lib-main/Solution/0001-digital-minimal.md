no

# 0001-digital-minimal: Digital Minimal (beamer theme)

- Unverified: read from the source, not compiled.
- Source: Source/0001-digital-minimal/ (origin: https://latextemplates.com/downloads/digitalminimal-beamer.zip; licence: GPL-3.0)
- Kind: presentation
- Lib: v1
- Engine: pdfLaTeX-compatible
- Look carried by: zip-local (the zip-local theme `beamerthemedigital-minimal.sty` carries the whole look; `main.tex` only loads published `beamer` and sets title data)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
No. The document class is the published `beamer` (not bundled, source not read) and the sample's body is plain beamer content, but the look lives in a zip-local theme that is not on CTAN (ctan.org/pkg/beamerthemedigital-minimal returned 404). That theme is mostly irreducible code: a footer navigation typesetter driven by section titles recorded in the `.aux`, a redefined `\section`, an extra end frame appended at `\AtEndDocument`, a section-banner frame hook that mutates the footline globally, and pgf-drawn marker bars. These run in this sample (it has `\section`s and a `\maketitle`). The palette, option and itemize-label code would reduce to lib ways, but the rest does not.

## Blockers
- `BESPOKE/class` footer navigation typesetter: `\foreach` + `pgfmath` colour fade, window of sections computed from counters, section titles read back from `.aux`, `\slideentry`/`\sectionentry` redefined to harvest subsection links, result cached in a box per frame (beamerthemedigital-minimal.sty:214-313, 262-311)
- `BESPOKE/class` `\section` redefined to `\write` its title to `.aux` and plant `\hypertarget`; hand-rolled `btdm@sectioncount` counter (sty:315-328)
- `BESPOKE/class` footline template body that assembles the above plus a faked total frame count (sty:340-351, 400)
- `BESPOKE/class` `\AtEndDocument` appends a whole extra frame (outro) and adds 1 to `\inserttotalframenumber` (sty:394-411)
- `BESPOKE/class` `\AtBeginSection[]` banner frame: raw `\hypertarget`, `\vfill`, `\llap`, global `\gdef` of a footline prefix, background-canvas and footer colour swaps via `\BtdmMakeNextFullBottom`; beyond the declarative limit of `slide.beamer-section-hook` (sty:479-508)
- `BESPOKE/class` custom biblatex driver, name format and cite command with aliases for every entry type; inactive in this sample (no biblatex loaded, guard at sty:356-359) but part of the style file (sty:353-392)
- `ART/class` `pgfpicture` rounded-rectangle marker bars in the footer, built into saveboxes and shown per subsection (sty:235-243, used at 252)
- `ART/class` frame-title triangle tab: a `\faCaretLeft` glyph scaled by `\resizebox*` to a size computed in ex/pt from the title font, hung left with `\llap`, rebuilt on colour change (sty:413-431, 440). Judgement call: a glyph rather than a drawing; stated as ART because it is the template's signature shape. The verdict does not depend on it.

## Class setting
- Class: `class.beamer` options: `10pt` (main.tex:1). The theme options (`footfade`, `darkmode`, `lightmode`, `lightmode-fill` default, `darkmode-git`, `small-triangle`/`large-triangle`, `primary-foot`/`gray-foot`, `nobib`/`showbib`, `color`) are declared at sty:11-33 and none is passed by the sample (main.tex:2).
- Class-native vocabulary used: `\usetheme` (main.tex:2), `\title` `\subtitle` `\author` `\institute` `\date` (8-12), `\maketitle` (16), `frame` with title argument (18, 24, 34, 49, 70), `\tableofcontents` in a frame (19), `\section` (22, 32, 68), `columns`/`column` with `\textwidth` fractions (50-65), `itemize`/`enumerate` (25-29, 71-74).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:1 | `class.beamer` | 10pt |
| page size/options | main.tex:1 | `page.class-options` | 10pt; beamer default frame size |
| theme call | main.tex:2 | `slide.beamer-theme` | name `digital-minimal`; the target is zip-local, so only the call is a way (body in Bespoke) |
| side margins | sty:191 | `slide.beamer-template` | `\setbeamersize{text margin left=6mm,text margin right=6mm}` (nearest home) |
| nav symbols off | sty:330 | `slide.beamer-template` | `\usenavigationsymbolstemplate{}` (nearest home) |
| input/font encoding | main.tex:4-5 | `font.fontenc-t1` | inputenc utf8, fontenc T1 |
| text and sans face | sty:36 | `font.helvet` | `lato`, option `default` (a sans text-face package is the parameter) |
| mono face | sty:37 | `font.mono` | `FiraMono`, `scaled=.95` |
| icon font | sty:51, 203, 207, 228, 260, 430 | `font.icons` | `fontawesome` (v4); `\faAngleRight` item mark, `\faCircle` sub-item mark, `\faCaretLeft` |
| symbol font | sty:38, 228 | `math.amssymb` | `mdsymbol` loaded `\AtEndPreamble`; `\blacklozenge` `\lozenge` (nearest home; used only in the bespoke footer) |
| relative sizes | sty:48, 347 | `font.size-commands` | `relsize` `\smaller` (nearest home) |
| series reset | sty:39 | `font.size-commands` | `\AtBeginDocument{\fontseries{m}\selectfont}` (nearest home) |
| beamer fonts | sty:151-161, 449 | `slide.beamer-template` | `\setbeamerfont`: structure series, frametitle `\Large` ub, section title `\huge`, title `\Huge`, subtitle `\LARGE` `\slshape`, enumerate items |
| line spacing | sty:40 | `sp.linespread` | 1.015 |
| list indents | sty:179, 193-201 | `sp.lengths` | `\leftmargini`, `\leftmarginii` = .5cm in enumerate; itemize indents from `\settowidth` of the label plus `\labelsep` |
| colour definitions | sty:55, 58, 113, 116-117 | `color.xcolor` | `\definecolor` RGB (255,161,92), (51,93,126), (173,186,199), (34,39,46), (28,33,40) |
| palettes | sty:60-126 | `color.xcolor` | `\colorlet` mixes per mode; default `lightmode-fill` (sty:19, 93-108) |
| beamer colours | sty:149, 163-176, 187-188 | `slide.beamer-template` | `\setbeamercolor` for structure, title, normal text, background canvas, frametitle, footline, page numbers, enumerate item, bibliography |
| item labels | sty:177-178, 203, 207-211 | `slide.beamer-template` | `\setbeamertemplate` enumerate item `\insertenumlabel.`; itemize items `\faAngleRight`; sub-items scaled `\faCircle` |
| title data | main.tex:8-12, 16 | `front.class-native` | `\title` `\subtitle` `\author` `\institute` `\date{\today}` `\maketitle` |
| title page look | sty:444-458 | `slide.beamer-template` | `\defbeamertemplate*{title page}`: hand-laid boxes, centred title and subtitle, corner number and suffix; reducible in principle (see Bespoke) |
| frame title look | sty:433-442 | `slide.beamer-template` | `\defbeamertemplate*{frametitle}`: `beamercolorbox` wd=\paperwidth, ht=3.75ex, dp=.45ex, sep=2pt, plus the triangle (blocker) |
| footline | sty:342-351 | `slide.beamer-template` | `\setbeamertemplate{footline}`: body is bespoke (blocker) |
| section banner frame | sty:500-508 | `slide.beamer-section-hook` | nearest way only; insufficient (blocker) |
| contents | main.tex:18-20 | `toc.kernel` | `\tableofcontents` inside a frame, beamer default entries |
| sections | main.tex:22, 32, 68 | `class.beamer` | native `\section` entries; the theme redefines `\section` (blocker) |
| bullet list | main.tex:25-29 | `list.kernel` | `itemize`, three items |
| numbered list | main.tex:71-74 | `list.kernel` | `enumerate`, two items |
| table | main.tex:35-46 | `tbl.tabular` | `table` float, `tabular{lcc}`, no caption |
| table rules | main.tex:6, 38, 40, 44 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| table centring | main.tex:36 | `sp.ragged` | `\centering` |
| columns | main.tex:49-66 | `class.beamer` | native `columns`/`column` environments, width 0.48\textwidth each |
| bold run-in labels | main.tex:52, 59 | `mark.kernel` | `\textbf` |
| links | sty:228, 297, 325, 463 | `xref.hyperref` | `\hyperlink`, `\hypertarget`, `\href{mailto:...}` (used by bespoke footer and `\insertauthoremail`) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| Theme option layer | sty:11-33 | yes | `kvoptions` void options only choose a palette, triangle size and footer variant; an emitter writes the chosen mode's colours directly and `\usetheme[...]` is not needed |
| Palette machinery, `\UpdateBtdmColor`, `\IfBtdm*` | sty:60-146 | yes | `color.xcolor` `\colorlet` set of the chosen mode (default `lightmode-fill`, sty:93-108); runtime recolouring is unused by the sample |
| `\updateitemize*` label sizing | sty:193-211 | yes | `slide.beamer-template` item templates plus `sp.lengths` (`\settowidth`, `\addtolength`) |
| `\AtBeginEnvironment{enumerate}` margins | sty:179 | yes | `sp.lengths` `\leftmargini`, `\leftmarginii` |
| Title page template, `\titlenumber`, `\titlesuffix` | sty:444-458 | yes, with doubt | beamer title-page body from kernel boxes (`sp.manual-space`, `font.size-commands`); the extra macros are unused by the sample; counted as reducible only if hand-laid template bodies are allowed |
| Frame-title template | sty:433-442 | partly | box body is `beamercolorbox` plus `minipage` with fixed lengths; the triangle it embeds is the ART item |
| Footer navigation typesetter and cache | sty:214-313 | no | `\foreach`/`pgfmath` window and fade, aux-recorded titles, redefined `\slideentry`, per-frame box cache; computes layout from document state |
| `\section` redefinition, `btdm@sectioncount` | sty:315-328 | no | writes to `.aux` and plants anchors; hand-rolled counter that drives what is printed |
| Footline body, faked frame total | sty:340-351, 400 | no | depends on the two items above |
| Outro frame at `\AtEndDocument` | sty:394-411 | no | adds a frame the author never wrote and adjusts totals |
| Section banner hook, `\BtdmMakeNextFullBottom` | sty:479-508 | no | global footline-prefix `\gdef`, canvas and footer colour swaps, raw box commands; exceeds `slide.beamer-section-hook` |
| Foot-reveal and API macros (`\revealfooton`, `\titleframe`, `\setfootmarker`, `\outro`, `\email`, `\PostPage`, `\insertauthoremail`) | sty:331-338, 394-398, 461-477 | no | flag `\ifdmfoot` and global macros steering the footer; `\insertauthoremail` and `\setfoottitlemarker` are active through the banner and end frames; `\titleframe`, `\outro`, `\email` unused by the sample |
| Marker bars | sty:235-243 | no (ART) | `pgfpicture` drawing in saveboxes |
| Triangle tab | sty:413-431 | no (ART, judgement) | scaled glyph sized from font metrics |
| biblatex driver and cite command | sty:353-392 | no | `\DeclareBibliographyDriver`, `\DeclareCiteCommand`, aliases for all entry types; inactive here |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Nearest homes used, not proposed: `relsize` and `\fontseries{m}\selectfont` under `font.size-commands`; `mdsymbol` under `math.amssymb`; `\setbeamersize` and `\usenavigationsymbolstemplate` under `slide.beamer-template`; beamer `columns`/`column` as `class.beamer` vocabulary (the lib has no beamer-columns way, and `cols.minipage` does not cover beamer's alignment options).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
