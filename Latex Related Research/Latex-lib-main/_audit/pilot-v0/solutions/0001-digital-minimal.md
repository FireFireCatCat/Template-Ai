no

# 0001-digital-minimal: Digital Minimal (beamer theme by Florian Sihler)

- Unverified: read from the source, not compiled.
- Source: Source/0001-digital-minimal/ (origin: https://latextemplates.com/downloads/digitalminimal-beamer.zip; licence: GPL-3.0)
- Kind: presentation
- Lib: v0
- Engine: pdfLaTeX-compatible (every package the theme loads is a pdfTeX-usable package: kvoptions, lato, FiraMono, mdsymbol, relsize, pgf, fontawesome; as read, not tested)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (beamerthemedigital-minimal.sty lines 1-508 read in full; LICENSE is the stock GPL-3 text, header only)

## Verdict
No. The sample itself is plain beamer (frames, itemize, enumerate, a booktabs table, columns, a contents frame), but it loads the zip-local theme `digital-minimal`, which is not published and cannot be named as a `slide.beamer-theme` parameter. Its colours, fonts, markers and title page decompose into `slide.beamer-template`, `color.xcolor` and font ways. Its footline is a hand-written section navigator (windowed section list, a section registry written to the aux file by a redefined `\section`, subsection pips drawn with pgf, an auto-appended end frame and auto section frames). That is irreducible code plus template-defining artwork, so 100% recovery from published ways is not shown.

## Blockers
- `BESPOKE` footline section navigator: `\foreach` over a computed window of sections, `\pgfmathsetmacro` fade colours, cached box, redefined `\slideentry`/`\sectionentry` (beamerthemedigital-minimal.sty:218-311, 313, 340-351)
- `BESPOKE` `\section` redefined to `\write` each section title to the aux file and count sections, read back by the footline (beamerthemedigital-minimal.sty:316-328)
- `ART` subsection pips: `\pgfpicture` rounded rectangles stored in boxes, tiled into the footline (beamerthemedigital-minimal.sty:234-258)
- `BESPOKE` auto-inserted frames and global state: end frame appended by `\AtEndDocument`, frame total faked as +1, section banner frames by `\AtBeginSection[]`, `\BtdmMakeNextFullBottom` globally rewriting colours and a footline prefix for the next frame (beamerthemedigital-minimal.sty:394-411, 400, 480-508)
- `BESPOKE` frame-title bar with a computed, cached left triangle (font glyph sized by `\dimexpr` from `ex` and magic point offsets, `\llap`/`\smash` placement, two size variants) (beamerthemedigital-minimal.sty:413-442). Borderline: it could only be emitted as copied TeX box code inside `\defbeamertemplate`, which the rubric's test excludes.
- `BESPOKE` (dormant for this sample) custom biblatex driver and cite command, active only when biblatex is loaded (beamerthemedigital-minimal.sty:353-392)

## Class setting
- Class: `class.beamer` options: 10pt (main.tex:1)
- Class-native vocabulary used: `\usetheme` (main.tex:2), `\title` `\subtitle` `\author` `\institute` `\date` (main.tex:8-12), `\maketitle` (main.tex:16), `frame` with a title argument (main.tex:18,24,34,49,70), `\tableofcontents` inside a frame (main.tex:19), `\section` (main.tex:22,32,68), `columns`/`column{0.48\textwidth}` (main.tex:50-65). The theme file uses `\defbeamertemplate*`, `\setbeamertemplate`, `\setbeamercolor`, `\setbeamerfont`, `\setbeamersize`, `\usenavigationsymbolstemplate`, `\AtBeginSection`, overlay specs (`\only<...|handout:0>`). Beamer `frame` and `columns` are treated here as class-native vocabulary of `class.beamer` (no separate way proposed).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.beamer` | 10pt |
| class size option | main.tex:1 | `page.class-options` | 10pt |
| theme load | main.tex:2 | not a lib way: `digital-minimal` is zip-local (W1 fails); decomposed in the rows below | theme options in sample: none, so defaults apply: lightmode-fill, small-triangle, gray-foot, nofootfade (sty:15-33, 19) |
| input and font encoding | main.tex:4-5 | `font.fontenc-t1` | inputenc=utf8, fontenc=T1 |
| title block | main.tex:8-12,16 | `front.class-native` | title, subtitle, author, institute, date=\today; \maketitle |
| title page look | sty:444-458 | `slide.beamer-template` | `\defbeamertemplate*{title page}`: centred title and subtitle, vfill above and below, big faint number top right (`\titlenumber`, unused), `\titlesuffix` bottom left (unused); fonts title Huge, subtitle LARGE slanted |
| contents frame | main.tex:18-20 | `toc.kernel` | `\tableofcontents` inside frame "Overview" |
| section commands | main.tex:22,32,68 | `head.kernel` | `\section{...}` (beamer navigation entries; printed heading comes from the theme's section banner frame, bespoke) |
| itemize | main.tex:25-29,53-56,60-63 | `list.kernel` | itemize |
| enumerate | main.tex:71-74 | `list.kernel` | enumerate; item label `\insertenumlabel.` via `\setbeamertemplate{enumerate item}` (sty:177-178) |
| item markers | sty:193-211 | `slide.beamer-template` + `font.icons` | itemize items `\faAngleRight`; subitem `\faCircle` scaled .5 raised 1.5pt in softtext colour; subsubitem same at .77 |
| list indents | sty:179,193-201 | `sp.lengths` | `\leftmargini=\leftmarginii=.5cm` for enumerate; itemize `\leftmargini` set to marker width plus `\labelsep` |
| table | main.tex:35-46 | `tbl.tabular` | table env, tabular `{lcc}` |
| table rules | main.tex:6,38-44 | `tbl.booktabs` | `\toprule \midrule \bottomrule` |
| table centring | main.tex:36 | `sp.ragged` | `\centering` |
| columns | main.tex:50-65 | `class.beamer` (native `columns`) | two columns, width 0.48\textwidth each |
| frame structure | main.tex:18-75 | `class.beamer` (native `frame`) | `\begin{frame}{Title}` |
| theme colour palette | sty:53-126 | `color.xcolor` | primary RGB(51,93,126) (sty:58); lightmode-fill bundle (sty:93-108): text black!99!gray, background white!99!gray, frametitle white!99!primary, border@up=primary, block=primary!60!text, border@down lightgray!12!white, foot gray, section@fill=primary |
| beamer colours | sty:149,163-176,182-188 | `slide.beamer-template` | `\setbeamercolor` for palette primary, structure, title, description item, bibliography item, background canvas, normal text, frametitle (parent structure, bg=border@up), section title/text, footline, page number, current page number, enumerate item, active section in head/foot |
| beamer fonts | sty:151-161,449 | `slide.beamer-template` | `\setbeamerfont`: structure bold; frametitle Large ub; section title huge; section text scriptsize slanted; title Huge ub; subtitle LARGE slanted; active section b; enumerate items parent normal text; titlenumber 72pt |
| text margins | sty:191 | `slide.beamer-template` | `\setbeamersize{text margin left=6mm, text margin right=6mm}` |
| navigation symbols | sty:330 | `slide.beamer-template` | `\usenavigationsymbolstemplate{}` (none) |
| sans text family | sty:36 | `font.helvet` | `lato` with `default` (a sans family package as the document default; see Lib changes note) |
| monospace family | sty:37 | `font.mono` | `FiraMono` scaled=.95 |
| math symbol font | sty:38 | `math.amssymb` | `mdsymbol`, loaded at end of preamble (nearest symbol-font way; see Lib changes note) |
| icon font | sty:51 | `font.icons` | `fontawesome` (old package); glyphs `\faAngleRight \faCircle \faCaretLeft` (sty:203,207,430) |
| default font series | sty:39 | `font.size-commands` | `\AtBeginDocument{\fontseries{m}\selectfont}` (NFSS selection command, nearest home) |
| relative sizes | sty:48,347 | `font.size-commands` | `relsize`, `\smaller` in the footline |
| line spacing | sty:40 | `sp.linespread` | `\linespread{1.015}` |
| author mail link | sty:461-463 | `meta.hyperref` | `\href{mailto:<email><?Subject=...>}{\insertauthor}`; `\hyperlink`/`\hypertarget` used by the footline (sty:228,297,325,506) |
| footline | sty:340-351 and 218-311 | none: BESPOKE | left: author or email plus short date; middle: windowed section list with next-markers; right: frame number and total (see Blockers) |
| frame title bar | sty:433-442 | none: BESPOKE (borderline) | full-width coloured bar, ht=3.75ex dp=.45ex sep=2pt, left triangle glyph |
| section banner frame | sty:480-508 | none: BESPOKE | full-colour frame per section, section title centred, optional corner text via `\SetNextSectionText` |
| end frame | sty:401-411 | none: BESPOKE | `\outro` and `\PostPage` content on an auto frame |
| subsection pips | sty:234-258 | none: `art.tikz` used as ART | pgf rounded rectangles .17cm x .043cm, stroke or stroke+fill |
| bibliography look | sty:353-392 | none: BESPOKE, dormant | custom biblatex driver aliased over all entry types (not loaded in the sample) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| kvoptions option set and `btdm@mode@*` colour bundles | sty:11-33, 53-126 | yes | choose one bundle at emit time; write its `\definecolor`/`\colorlet` lines (`color.xcolor`) and the matching `\setbeamercolor` (`slide.beamer-template`) |
| runtime re-theming: `\UpdateBtdmColor`, `\IfBtdmMode`, `\BtdmSetDarkmode`, `\BtdmSetLightmode` | sty:129-146 | static yes, live switch no | a fixed mode reduces as above; re-running colour bundles and rebuilding cached boxes mid-document has no lib way (unused by the sample) |
| `\updateitemize`, `\updateitemizesub`, `\updateitemizesubsub`, marker boxes | sty:193-211 | yes | `\setbeamertemplate{itemize items}` etc. plus `\settowidth`/`\addtolength` on `\leftmargini` (`slide.beamer-template`, `sp.lengths`), marker `\faAngleRight` / `\faCircle` (`font.icons`) |
| footline navigator (`\btdm@@typesettocfooter`, `\btdm@typesettocfooter`, cache box, `\btdmsetfootlinethreshold`) | sty:218-311, 313, 340-351 | no | computes a sliding window of sections, caches per frame; custom algorithm, no lib way |
| fade colours in the footline (`\btdm@typesettocfooter@footfade`) | sty:262-267 | no | `\pgfmathsetmacro` per entry inside `\foreach`; computed layout colour (option `footfade`, off by default) |
| section registry: `\section` redefinition, `\btdmcustomauxdef`, `btdm@sectioncount`, `\AtEndDocument` aux write | sty:316-328 | no | writes titles and the count to the .aux and reads them back on the next run; no lib way |
| subsection pips: `\btdm@sub`, `\btdm@subsections@low` (redefines `\sectionentry`, `\slideentry`) | sty:234-258 | no | pgf drawing plus a reader of beamer's internal navigation data; `ART` |
| frame title template and triangle (`\btdm@update@triangle`, `\btdm@vertshift`) | sty:413-442 | no (borderline) | only as verbatim TeX box code inside `\defbeamertemplate*`; hand-tuned offsets in two variants |
| title page template, `\titlenumber`, `\titlesuffix` | sty:444-458 | yes | `\setbeamertemplate{title page}` body of centred title/subtitle with `\vfill`; the two macros are plain content slots (unused in the sample) |
| `\titleframe`, `\revealfooton`, `\dmfoot`, `\setfootmarker`, `\setfoottitlemarker` | sty:331-338, 466-477 | partly | `\titleframe` is a frame around `\titlepage` (reducible); `\revealfooton` toggles a global conditional from overlay specs (`\only<-n-1\|handout:0>`) to decide whether the footline prints: irreducible state (unused by the sample) |
| section banner frames, `\BtdmMakeNextFullBottom`, `\SetNextSectionText`, `\ifsectionbanner`, `\nosframe` | sty:480-508 | no | `\AtBeginSection[]` frame whose colours, footline prefix and corner text are rewritten through global macros; hand-rolled conditionals drive what prints |
| end frame, faked totals, `\outro`, `\PostPage`, `\email` | sty:394-411, 400 | no | frame appended at `\AtEndDocument`; `\btdm@inserttotalframenumber` adds 1 to account for it |
| author mail macros `\insertauthoremail`, `\setauthormailsubject` | sty:461-463 | yes | `\href{mailto:...}{...}` (`meta.hyperref`) |
| biblatex driver, cite command, name format, category (`\DeclareBibliographyDriver`, `\DeclareCiteCommand`, `\DeclareBibliographyAlias`) | sty:353-392 | no (dormant) | a custom bibliography style program; no lib way parameterises a driver; guarded by `ver@biblatex.sty`, so inactive in this sample |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Notes for the consolidator: (1) `lato[default]` was mapped to `font.helvet`, read as "a sans family package as document default"; the id's description names helvet/avant/tgheros/sfmath only, so a description widening or a separate sans-family way may be wanted. (2) `mdsymbol` was mapped to `math.amssymb` as the nearest symbol-font way; the lib has no home for third-party math symbol font packages. (3) `\fontseries{m}\selectfont` was mapped to `font.size-commands`; `font.family-default` is the other candidate. (4) Beamer `frame` and `columns` were treated as `class.beamer` native vocabulary; the lib has no beamer-columns or frame way.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Not verified here: `\AtEndPreamble` (sty:38, 356) and `\AtBeginEnvironment` (sty:179) are etoolbox commands and the style has no `\RequirePackage{etoolbox}`; whether beamer supplies it was not checked.
