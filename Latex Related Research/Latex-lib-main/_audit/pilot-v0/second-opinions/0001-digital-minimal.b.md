no

# 0001-digital-minimal: Digital Minimal (beamer theme, F. Sihler)

- Unverified: read from the source, not compiled.
- Source: Source/0001-digital-minimal/ (origin: https://latextemplates.com/downloads/digitalminimal-beamer.zip; licence: GPL-3.0)
- Kind: presentation
- Lib: v0
- Engine: pdfLaTeX-compatible (Lato, FiraMono, fontawesome, mdsymbol, relsize, pgf are all pdfTeX packages; none ships in the zip, they come with the TeX distribution)
- Main file: main.tex (other samples: none)
- Read: main yes (77 of 77 lines), zip-local classes and styles all (beamerthemedigital-minimal.sty, 508 of 508 lines; LICENSE is the GPL-3.0 text, not read as template). The published `beamer` class, `lato`, `FiraMono`, `fontawesome`, `relsize`, `pgf` sources were not read.

## Verdict
The sample is a 77-line beamer deck whose entire look comes from a zip-local theme, `beamerthemedigital-minimal.sty`. Colours, fonts, bullets and `\setbeamer*` settings reduce to lib ways. The theme's core does not. The footline is a hand-built mini table of contents driven by `\foreach` and `pgfmath`, a redefined `\section` that writes a counter to the `.aux` file, and a cached savebox. A `pgfpicture` draws the subsection markers. Section banner frames, a frame injected at `\AtEndDocument`, and the frame-title and title-page bodies are hand-laid box code driven by global conditionals. No published way or declarative parameter set expresses these, so the answer is `no`.

## Blockers
- `BESPOKE` footline with section mini-TOC: `\foreach` over sections, `\pgfmathsetmacro` fade distances, `\slideentry`/`\sectionentry` redefined, `\beamer@sectionbox` reuse, per-frame savebox cache (beamerthemedigital-minimal.sty:218-313, 340-351)
- `BESPOKE` `\section` redefined to write `\btdmcustomauxdef` and a section counter into the `.aux`, plus `\AtEndDocument` counter write (beamerthemedigital-minimal.sty:316-328)
- `BESPOKE` section banner frames injected by `\AtBeginSection[]`, with a global self-clearing footline-prefix state and `\BtdmMakeNextFullBottom` rewriting colours (beamerthemedigital-minimal.sty:483-508)
- `BESPOKE` frame injected at `\AtEndDocument` and total frame number faked as `\inserttotalframenumber+1` (beamerthemedigital-minimal.sty:394-411)
- `BESPOKE` frame-title template: hand-laid `\beamercolorbox`/`minipage`/`\llap` with a font-glyph triangle sized from ex units and cached by `\AtBeginDocument` (beamerthemedigital-minimal.sty:413-442). Borderline: it is a literal template body, but it is not declarative.
- `BESPOKE` title-page template: hand-laid `\smash`/`\llap`/`\vfill` body fed by `\titlenumber` and `\titlesuffix` (beamerthemedigital-minimal.sty:444-458). Borderline, same reasoning.
- `ART` pgf rounded-rectangle markers drawn with `\pgfpicture` for the footline's subsection indicators (beamerthemedigital-minimal.sty:234-243). They are part of the template's footer identity, not figure content, and no lib way draws them.
- `BESPOKE` custom biblatex bibliography driver and cite command (beamerthemedigital-minimal.sty:353-392). It is inactive here because biblatex is not loaded (guard at 356-359), so it is recorded but is not what decides the verdict.

## Class setting
- Class: `class.beamer` options: `10pt` (main.tex:1)
- Class-native vocabulary used: `\usetheme` (main.tex:2); `\title` `\subtitle` `\author` `\institute` `\date` `\maketitle` (main.tex:8-12, 16); `frame` with a title argument (main.tex:18, 24, 34, 49, 70); `\tableofcontents` inside a frame (main.tex:19); `columns` and `column` with a width (main.tex:50-65); `table` inside a frame with no caption (main.tex:35-46). I did not read beamer's source, so I did not check that `\maketitle` in beamer builds the title-page frame.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.beamer` | 10pt |
| theme selection | main.tex:2 | none: `digital-minimal` is zip-local, so W1 fails (not `slide.beamer-theme`) | see Bespoke code |
| encoding | main.tex:4-5 | `font.fontenc-t1` | inputenc=utf8, fontenc=T1 |
| table rules | main.tex:6, 38-44 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule`, defaults |
| table body | main.tex:37-45 | `tbl.tabular` | colspec `lcc`, 4 rows x 3 columns |
| table centring | main.tex:36 | `sp.ragged` | `\centering` |
| title block | main.tex:8-12, 16 | `front.class-native` | title, subtitle, author, institute, `\date{\today}` |
| columns | main.tex:50-65 | `NEW:cols.beamer-columns` | two columns, each width 0.48\textwidth |
| lists in body | main.tex:25-29, 53-56, 60-63, 71-74 | `list.kernel` | itemize, enumerate (the theme sets their labels) |
| bold labels | main.tex:52, 59 | `mark.kernel` | `\textbf` |
| contents frame | main.tex:19 | `toc.kernel` | `\tableofcontents`; the theme sets no `section in toc` template (grep found none) |
| sectioning | main.tex:22, 32, 68 | `head.kernel` | `\section`; the theme overrides `\section` (bespoke row 8) |
| sans text font | beamerthemedigital-minimal.sty:36 | `font.helvet` | `\RequirePackage[default]{lato}`. Lato is a published sans package, same way type as the lib's sans row; the lib row names only helvet/avant/tgheros/sfmath. |
| mono font | beamerthemedigital-minimal.sty:37 | `font.mono` | `FiraMono`, scaled=.95 |
| math symbol font | beamerthemedigital-minimal.sty:38 | `math.amssymb` | `mdsymbol` loaded via `\AtEndPreamble`. CTAN: symbol fonts to match Myriad Pro. This is the nearest lib row, a stretch; the theme uses it for `\lozenge` `\blacklozenge` at :228. |
| series reset | beamerthemedigital-minimal.sty:39 | `font.size-commands` | `\AtBeginDocument{\fontseries{m}\selectfont}`, NFSS selector (nearest row) |
| line spacing | beamerthemedigital-minimal.sty:40 | `sp.linespread` | 1.015 |
| relative sizes | beamerthemedigital-minimal.sty:48, 347 | `font.size-commands` | `relsize` `\smaller` in the footline |
| icon font | beamerthemedigital-minimal.sty:51, 203, 207, 430 | `font.icons` | `fontawesome`: `\faAngleRight`, `\faCircle`, `\faCaretLeft` |
| colour definitions | beamerthemedigital-minimal.sty:53-58, 93-108 | `color.xcolor` | default state is `lightmode-fill` (:19): primary RGB 51,93,126; text black!99!gray; background white!99!gray; frametitle white!99!primary; border@up primary; border@down lightgray!12!white; block primary!60!text; softtext gray!42!white!95!primary; foot gray |
| other colour modes | beamerthemedigital-minimal.sty:61-126 | `color.xcolor` | darkmode, lightmode, darkmode-git, each a `\colorlet`/`\definecolor` set. Not selected by the sample (no options passed, main.tex:2). |
| beamer colours | beamerthemedigital-minimal.sty:149, 163-176, 187-188 | `slide.beamer-template` | `\setbeamercolor` for palette primary, structure, title, background canvas, normal text, frametitle, section title/text, footline, page numbers, enumerate item, bibliography |
| beamer fonts | beamerthemedigital-minimal.sty:43, 151-161, 449 | `slide.beamer-template` | `\setbeamerfont`: structure bold; frametitle `\Large` ub; title `\Huge`; subtitle `\LARGE` slanted; section title `\huge`; section text `\scriptsize` slanted; titlenumber 72pt |
| text margins | beamerthemedigital-minimal.sty:191 | `slide.beamer-template` | `\setbeamersize{text margin left=6mm,text margin right=6mm}` (same family as `\setbeamerfont`; the lib row does not name `\setbeamersize`) |
| navigation symbols off | beamerthemedigital-minimal.sty:330 | `slide.beamer-template` | `\usenavigationsymbolstemplate{}` |
| enumerate labels | beamerthemedigital-minimal.sty:177-179 | `slide.beamer-template` + `sp.lengths` | enumerate item `\insertenumlabel.`; `\AtBeginEnvironment{enumerate}{\leftmargini.5cm \leftmarginii.5cm}` |
| itemize labels | beamerthemedigital-minimal.sty:193-211 | `slide.beamer-template` + `sp.lengths` + `fig.graphicx` | itemize item `\mdseries\faAngleRight`; sub items `\raisebox{1.5pt}{\scalebox{.5}{\faCircle}}` in btdm@softtext; `\settowidth`/`\addtolength` on `\leftmargini`..`\leftmarginiii`. `\scalebox` is mapped to graphicx box transforms (nearest row). |
| hyperlinks | beamerthemedigital-minimal.sty:228, 297, 325, 463 | `meta.hyperref` | `\hyperlink` `\hypertarget` `\href`; hyperref is loaded by beamer, not read here |
| overlay-conditional footer | beamerthemedigital-minimal.sty:332 | `slide.beamer-mode` | `\only<-n-1\|handout:0>`; used only by `\titleframe`, which main.tex does not call |
| bibliography | beamerthemedigital-minimal.sty:353-392 | `bib.biblatex-biber` | biblatex, backend not set here; not exercised by the sample (no biblatex in main.tex) |
| frame title look | beamerthemedigital-minimal.sty:433-442 | none: bespoke row 5 | n/a |
| title page look | beamerthemedigital-minimal.sty:451-458 | none: bespoke row 4 | n/a |
| footline (page n / total, section mini-TOC, email/date) | beamerthemedigital-minimal.sty:218-313, 338, 340-351 | none: bespoke rows 6 and 7 | n/a |
| section banner frames | beamerthemedigital-minimal.sty:483-508 | none: bespoke row 9 | n/a |
| footline subsection markers | beamerthemedigital-minimal.sty:234-243 | `ART` | n/a |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| 1 theme option and colour-mode plumbing (kvoptions, `\DeclareVoidOption`, `\newif`s, `\@namedef` mode macros) | beamerthemedigital-minimal.sty:11-33, 60-146 | Yes, for a fixed mode | The emitter chooses a mode and writes that mode's `\colorlet`/`\definecolor` set (`color.xcolor`, values in the map). The option machinery is not needed. |
| 2 runtime theme API (`\UpdateBtdmColor`, `\IfBtdmMode`, `\BtdmSetDarkmode`, `\updateTriangle`, `\btdmsetfootlinethreshold`, `\setfootmarker`, `\titlenumber`, `\titlesuffix`, `\outro`, `\email`, `\PostPage`, `\SetNextSectionText`, `\nosframe`, `\titleframe`, `\revealfooton`) | beamerthemedigital-minimal.sty:133-146, 218-219, 332-338, 395-398, 444-448, 461-477, 479-481, 499 | Yes, here | main.tex calls none of them, so the emitter writes final values. The API is a set of state mutators with no way of its own. |
| 3 itemize and enumerate label macros (`\updateitemize*`, `\btdm@update@subboxes`, `\AtBeginEnvironment{enumerate}`) | beamerthemedigital-minimal.sty:177-179, 193-211 | Yes | `\setbeamertemplate{itemize items}{...}` etc. plus `\settowidth`/`\addtolength` (`slide.beamer-template`, `sp.lengths`, `fig.graphicx`), as in the map. |
| 4 title-page template | beamerthemedigital-minimal.sty:444-458 | No (borderline) | A hand-written `\defbeamertemplate*{title page}` body of `\smash`, `\llap`, `\raisebox`, `\vfill`. Its content is code, so W2 fails. |
| 5 frame-title template and triangle cache (`\btdm@update@triangle`, `\btdm@triangle`, `\btdm@vertshift`) | beamerthemedigital-minimal.sty:413-442 | No (borderline) | Same reasoning: hand-laid box code, with the triangle sized from `3.75ex+.45ex+4.12pt` and drawn from a font glyph. No lib way gives a notched title bar. |
| 6 footline template | beamerthemedigital-minimal.sty:340-351 | No | `\setbeamertemplate{footline}` body built from `\minipage`, `\rlap`, `\llap`, `\parbox`, with a `\btdm@inserttotalframenumber` hack; it calls the mini-TOC below. |
| 7 footline section mini-TOC (`\btdm@@typesettocfooter`, `\btdm@typesettocfooter`, `\btdm@subsections@low`, `\btdm@footer@tsymb`, `\btdm@typesettocfooter@footfade`) | beamerthemedigital-minimal.sty:213-313 | No | `\foreach`, `\pgfmathsetmacro`, redefinition of `\slideentry`/`\sectionentry`, `\hb@xt@`, saveboxes cached by frame number. It computes layout, so no lib way applies. |
| 8 `\section` override and aux counter (`\btdm@section`, `btdm@sectioncount`, `\btdmcustomauxdef`) | beamerthemedigital-minimal.sty:316-328 | No | Redefines the kernel `\section`, writes into `\@auxout`, and builds `\csname btdm@section@N@content\endcsname`. It is a hand-rolled counter and conditional that drive what is printed. |
| 9 section banner frames and footer colour state (`\AtBeginSection[]`, `\BtdmMakeNextFullBottom`, `\btdm@footline@prefix`) | beamerthemedigital-minimal.sty:483-508 | No | Global self-clearing flags and `\colorlet` rewrites change the next frame's footline, with branches on `\if@btdm@darkmode@`. |
| 10 outro frame and total-frame hack (`\AtEndDocument`, `\btdm@inserttotalframenumber`) | beamerthemedigital-minimal.sty:394-411 | No | The injected frame itself could be emitted as a body frame, but the `+1` arithmetic and the `btdm@slide@marker.N` labels are glue for items 6 to 7, so it is blocked with them. |
| 11 custom biblatex driver and cite command | beamerthemedigital-minimal.sty:353-392 | No (inactive here) | `\DeclareBibliographyDriver`, `\DeclareCiteCommand`, `\DeclareBibliographyAlias` loops. Code, not parameters. Gated on biblatex being loaded (356-359), so unused in this sample. |
| 12 pgf subsection markers (`\btdm@sub`) | beamerthemedigital-minimal.sty:234-243 | No (`ART`) | `\pgfpicture`, `\pgfsetcornersarced`, `\pgfpathrectanglecorners` drawing 1.7mm x 0.43mm rounded bars stored in two saveboxes. |

## Content-opaque
none. The only table is a plain `tabular` (main.tex:37-45), which the lib holds.

## Lib changes
- New ways proposed: `NEW:cols.beamer-columns` beamer's `columns` and `column` environments (main.tex:50-65), engine pdf. W1: part of the published beamer class. W2: width argument and the `t`/`c`/`b`/`T`/`onlytextwidth`/`totalwidth` keys. W3: any beamer slide with side-by-side material. W4: it prints as `\begin{columns}...\begin{column}{w}` wrappers around content. The lib's `cols.minipage` is the nearest row, but the printed form and options differ, so I propose a separate way.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes for the consolidator: Lato is mapped to `font.helvet` and mdsymbol to `math.amssymb` because they are the nearest rows by family. If more zips need other font or symbol packages, the lib's font and math rows may need broader wording.

## Other observations (read-only, not verified by compiling)
- The footline links to `btdm@slide@marker.1` (beamerthemedigital-minimal.sty:228), a label only the theme's `\titleframe` defines (:472). main.tex builds its title page with `\maketitle` (main.tex:16), so that label is probably undefined in the sample's output. I did not compile to confirm.
- No text addressed to an AI was found in the zip (grep for AI-directed wording returned nothing).
