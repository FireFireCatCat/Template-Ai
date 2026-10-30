no

# 0114-scu-beamer: SCU Beamer (Sichuan University beamer theme)

- Unverified: read from the source, not compiled.
- Source: Source/0114-scu-beamer/ (origin: https://latextemplates.com/downloads/scu-beamer.zip; licence: LPPL-1.3c per manifest; file headers say "LaTeX Project Public License and/or GNU Public License", beamerthemescu.sty:7-8)
- Kind: presentation
- Lib: v2
- Engine: needs XeLaTeX (`unicode-math` and fontspec `\setsansfont`/`\setmathfont` at beamerthemescu.sty:187, beamerfontthemescu.sty:258-264, main.tex:18; `ctex` with `fontset=none` at beamerthemescu.sty:181-183)
- Look carried by: zip-local (the five `beamer*themescu.sty` files define the headline, footline, title page, colours, fonts and boxes; main.tex only picks theme options at main.tex:41-55)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (beamerthemescu.sty 1-1324, beamerouterthemescu.sty 1-688, beamerinnerthemescu.sty 1-163, beamercolorthemescu.sty 1-248, beamerfontthemescu.sty 1-311)

## Verdict
No. The document class is the published `beamer`, but everything that makes the deck look like this template lives in zip-local theme files that are not on CTAN (`ctan.org/pkg/beamerthemescu` and `ctan.org/pkg/beamertheme-scu` both return 404) and that came from latextemplates.com in a patched form (beamerinnerthemescu.sty:71-77 "PATCHED from upstream"), so W1 fails for the theme. The title page, headline and footline are hand-drawn TikZ shapes (polar curves, shading, fading, seeded random arcs), which is template-defining artwork (`ART`), and the footline's progress bar and the headline's mini-frames are hand-rolled counter, dimen and `\slideentry` logic (`BESPOKE`). The colour theme, font theme, frame-title template and most package loading do reduce to lib ways, but the artwork does not.

## Blockers
- `ART/class` title page: one `tikzpicture` with a smooth-plot swoosh (`path fading`, `fading transform`), shaded wedge, gradient outline and ten random short arcs from `\pgfmathsetseed{10}` + `\foreach` + `rnd` (beamerinnerthemescu.sty:87-152, arcs at :113-126); also placed logo, landmark and "verify" images at fixed coordinates (:91-96).
- `ART/class` headline background: polar-curve shapes `r=(2+2^(sin(3θ)))/2` drawn with `\shade`/`\fill`/`plot[smooth]`, stored in a savebox (beamerouterthemescu.sty:114-121, :125-155).
- `ART/class` footline background and progress-bar ornament: the same curve family for the logo tab, the bar end-cap and its highlight arcs (beamerouterthemescu.sty:450-494, :635-649).
- `ART/class` tcolorbox `overlay`/`overlay first|middle|last|unbroken` keys whose values are `\draw` programs (rounded rules anchored on `title.north-|frame.east`, `frame.south west`, faded accent strokes) giving every theorem, example, definition, lemma, condition and code box its look (beamerthemescu.sty:416-469, :472-528; tcolorbox is published, the drawing in the key is not a declarative value).
- `BESPOKE/class` footline progress bar and navigation: bar width computed with `\divide`/`\multiply` on dimen registers from frame counters (beamerouterthemescu.sty:430-434, :497-505, :626-634); the page-number cell uses `\Acrobatmenu{GoToPage}` (:515-523); the tool strip parses the `NavigationTool` string with `\StrSubstitute`/`\StrCount` and loops with `\foreach` (:526-575).
- `BESPOKE/class` headline mini-frames: re-implements beamer's `\slideentry` and `\sectionentry`, resets `\beamer@sectionbox`, calls `\dohead` and `\fakeslideentry` (beamerouterthemescu.sty:182-213), positioned with `picture`/`\put` and hand-measured box heights (:310-352).
- `BESPOKE/class` option-dispatch machinery `\EqualOptionsBeamer` / `\ifEqualOptionsBeamer` (a `\relax\fi\ifEqualOptionsBeamer` trick that `\newif`s inside the macro) used for every branch in the theme (beamerthemescu.sty:50-64). Reducible by fixing each option and inlining the chosen branch, so it is not blocking by itself; it is listed because the theme cannot be copied without it.

## Class setting
- Class: `class.beamer` options: `aspectratio=169`; `hyperref` and `UTF8` (main.tex:3). Beamer passes unknown global options to the packages it loads, and `hyperref`/`UTF8` are options of `ctex`, which the theme loads (beamerthemescu.sty:181-183); this reading is an inference, not a file fact. The beamer class source was not read (distribution class).
- Class-native vocabulary used: `frame` with optional title `\begin{frame}{Title}` (main.tex:78), `\titlepage` (:69), `\tableofcontents` (:73), `\section` (:76), `columns` with `[onlytextwidth]` and `column` with width (:89-90), `\structure{...}` (:91), `\title[short]{}`, `\subtitle`, `\author{A \and B}`, `\institute`, `\date` (:60-64), `itemize` and `enumerate` inside frames (:79, :130), `table` float with `tabular` (:112-114).
- Theme-native vocabulary (zip-local, not published): `\usetheme[ColorDisplay, LanguageMode, FontTheme, MathFont, BIBMode, Background, VI, BlockDisplay, CodeTheme, MintedStyle, Miniframes, NavigationTool, LogoWidth, ContentMuticols]{scu}` (beamerthemescu.sty:12-28, :101-141); environments `scutheorem`, `scuexample`, `scualgorithm`, `scudefinition`, `scuaxiom`, `scuproperty`, `scuproposition`, `sculemma`, `scucorollary`, `scucondition`, `scuconclusion`, `scuassumption`, `scuremark`, `scuproof`, `scucode`, `scutcbrb`, `scutcbyg`; commands `\scucodeinput`, `\scugoto`, `\scugoback`. The sample uses none of these.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:3 | `class.beamer` | `aspectratio=169`, global `hyperref`, `UTF8` |
| page size / ratio | main.tex:3 | `page.class-options` | `aspectratio=169` |
| text margins | beamerthemescu.sty:244 | `slide.beamer-template` | `\setbeamersize{text margin left=0.03\paperwidth, text margin right=0.03\paperwidth}` (a `\setbeamersize` call is the same beamer-setter family as `\setbeamertemplate`) |
| theme selection | main.tex:41-55; beamerthemescu.sty:328-334 | `slide.beamer-theme` | call form only: `\usetheme[...]{scu}` then `\usecolortheme{scu}`, `\useoutertheme{scu}`, `\useinnertheme{scu}`, `\usefonttheme{scu}`; the theme name `scu` is zip-local, so the effect is the bespoke items below, not a published theme |
| beamer item and caption templates | beamerthemescu.sty:336-346 | `slide.beamer-template` | `itemize items`=square, `enumerate items`=square, `sections/subsections in toc`=square, `caption`=numbered, `theorems`=numbered, `blocks`=rounded |
| uncovered overlay look | beamerthemescu.sty:250 | `slide.beamer-mode` | `\setbeamercovered{transparent}` (overlay behaviour; the sample uses no overlays) |
| navigation symbols | beamerthemescu.sty:252 | `slide.beamer-template` | `\beamertemplatenavigationsymbolsempty` |
| compress mode | beamerthemescu.sty:348 | `class.beamer` | internal `\beamer@compresstrue` (the class option `compress`) |
| colours | beamercolorthemescu.sty:46, :64-121 | `color.xcolor` | `\definecolor` cmyk for scured (0.12,0.92,0.95,0.20), scugrey, scublue, scugreen, scuyellow; `\colorlet` tints 10 to 90 percent; main.tex:2 `\PassOptionsToPackage{cmyk}{xcolor}` |
| colour roles | beamercolorthemescu.sty:143-155, :198-240 | `slide.beamer-template` | `\colorlet` of PrimaryC, AuxiliaryC, IntersperseC, AlertedTextC, Block*C for ColorDisplay=JXred; `\setbeamercolor` for structure, palettes, head/foot parts, title, block title/body, items, normal/alerted text. Whole colour theme is reducible |
| sans / mono fonts | main.tex:18-19; beamerfontthemescu.sty:246-254 | `font.fontspec` | `\setsansfont{Nimbus Sans}`, `\setmonofont{DejaVu Sans Mono}` through the `FontTheme=Custom` hook `\beamer@scu@fontextend` |
| math font | beamerfontthemescu.sty:256-265; main.tex:51 | `font.unicode-math` | `\setmathfont{latinmodern-math.otf}` (file shipped in the zip) |
| font sizes and weights per role | beamerfontthemescu.sty:281-299 | `slide.beamer-template` | `\setbeamerfont` for frametitle `\large` bold, title `\LARGE` bold, subtitle `\small`, author `\small`, date `\footnotesize`, head/foot roles `\tiny`/`\scriptsize` |
| CJK and language framework | beamerthemescu.sty:180-184; main.tex:57 | `lang.cjk`, `lang.babel` | `ctex[fontset=none, scheme=plain]` for LanguageMode=en; `\usepackage[english]{babel}` |
| math packages | beamerthemescu.sty:185-187 | `math.amsmath`, `math.amssymb`, `math.mathtools` | `amsmath,amsfonts,amssymb`, `mathtools`; inline math `$-56\%$` at main.tex:118 |
| icons | beamerthemescu.sty:216, :1235, :1240; beamerouterthemescu.sty:542-560 | `font.icons` | `fontawesome5` glyphs `\faCode`, `\faCaretLeft`, `\faSearch`, `\faExpand`, `\faReply` |
| front matter data | main.tex:60-64 | `front.class-native` | `\title[Cold-Chain Logistics Review]{...}`, `\subtitle`, `\author{Wei Lin \and Fatima Haidari}`, `\institute`, `\date{\today}` |
| title page look | beamerinnerthemescu.sty:68-155 | `art.tikz` | **ART**: `\defbeamertemplate*{title page}` with one tikzpicture (see Blockers) |
| automatic title frame | beamerthemescu.sty:1162-1176; main.tex:68-70 | `slide.beamer-template` | `\AtBeginDocument` frame `[plain]` with headline and footline emptied; the sample then adds a second `\titlepage` frame, so two title slides result; reducible to a frame wrapper |
| table of contents frame | main.tex:72-74 | `toc.kernel` | beamer `\tableofcontents` in `\begin{frame}{Outline}` |
| toc depth | beamerthemescu.sty:246 | `num.secnumdepth` | `\setcounter{tocdepth}{2}` |
| toc helper and subsection hook | beamerthemescu.sty:1179-1212 | `slide.beamer-section-hook`, `cols.multicol` | `\AtBeginSubsection[]` frame titled Outline holding `\tableofcontents[sectionstyle=show/shaded, subsectionstyle=show/shaded/hide, subsubsectionstyle=show/shaded/hide]`, optionally in `multicols{2}`; background swapped by `\setbeamertemplate{background}`. Reducible. The sample has no `\subsection`, so it never fires |
| section commands | main.tex:76, :86, :109, :127 | `head.class-native` | beamer `\section{...}` (appears only in headline and toc) |
| frame title | beamerouterthemescu.sty:376-398 | `slide.beamer-template` | `\defbeamertemplate*{frametitle}`: `beamercolorbox[wd=\paperwidth, ht=2.2ex, leftskip=9pt]`, subtitle separated by `\rule[-.2ex]{.08em}{1.8ex}` (`sp.rule`); reducible |
| headline | beamerouterthemescu.sty:355-360 | `hf.class-native` | beamer `headline` template, content is the ART/BESPOKE headline (Blockers) |
| footline | beamerouterthemescu.sty:656-663 | `hf.class-native` | beamer `footline` template, content is the ART/BESPOKE footline (Blockers) |
| page numbering | beamerouterthemescu.sty:497-523; beamerthemescu.sty:1250 | `num.counters` | `\setcounter{page}{\c@framenumber}` under `\AtBeginEnvironment{beamer@framepauses}`; `\insertframenumber`, `\insertmainframenumber` |
| lists | main.tex:79-83, :92-96, :130-134 | `list.kernel` | `itemize`, `enumerate`; item marks set by `slide.beamer-template` above |
| columns | main.tex:89-106 | `class.beamer` | beamer `columns[onlytextwidth]` + `column{.48\textwidth}` (class vocabulary) |
| inline emphasis | main.tex:91, :99 | `class.beamer` | beamer `\structure{...}`; `\alert` in theme macros (beamerthemescu.sty:67-70) |
| table | main.tex:111-123 | `tbl.tabular`, `tbl.booktabs` | `table` + `\centering` + `tabular{lccc}`, `\toprule \midrule \bottomrule` (`\usepackage{booktabs}` main.tex:58) |
| table packages | beamerthemescu.sty:217 | `tbl.tabularx` | load-only |
| closing slide | main.tex:137-140 | `font.size-commands`, `sp.ragged` | `\centering`, `\Huge` |
| theorem-like boxes | beamerthemescu.sty:662-732, :738-784 | `thm.tcolorbox`, `box.tcolorbox` | `\DeclareTColorBox[use counter=..., number within=section, reset counter on overlays]` per kind with `O{} m !s !O{}` arguments, `nameref`, `label`; box skin keys `enhanced jigsaw`, `arc=1.5mm`, `colframe`, `breakable`, `break at=.78\textheight`; the decorative `overlay` keys are `ART` (Blockers). The sample uses none |
| code boxes | beamerthemescu.sty:1001-1144 | `code.tcblisting`, `code.listings` | `\DeclareTCBListing` with `listing engine=listings`, options `basicstyle=\scriptsize\ttfamily`, `keywordstyle=\color{scured}`, `commentstyle`, `stringstyle`, `numbers=left`; `CodeTheme=listing` is the default and the sample leaves it. Overlay decoration is `ART` as above |
| cross references | beamerthemescu.sty:191, :195, :1244-1247 | `xref.varioref`, `xref.cleveref`, `xref.hyperref` | packages loaded; `\cref` and `\vref` wrapped in `\hyperlink{label}{...}`; Crefname strings per language (cn list :1253-1314, en :1316) |
| button boxes | beamerthemescu.sty:1227-1241 | `box.tcolorbox`, `xref.hyperref`, `font.icons` | `\NewTotalTCBox{\scuminijump}`, `\scugoto`, `\scugoback`; reducible |
| bibliography | beamerthemescu.sty:218-230, :358-369 | `bib.biblatex-biber` | only when `BIBMode=biber` (`gb7714-2015` style, `ref.bib`); the sample sets `BIBMode=none` (main.tex:52) so it is not loaded, `xstring` is loaded instead |
| background | beamerthemescu.sty:270-292 | `slide.beamer-template` | `Background=none` (main.tex:53): `\setbeamercolor{background canvas}{bg=BackgroundC}` only; SCU-Full would need `resources/background.png` images that the zip does not ship |
| logo images | main.tex:33-38; beamerthemescu.sty:308-325 | `art.tikz` | `\pgfdeclareimage` slots `lg`, `lg-name`, `landmark`, `verify` all pointed at `resources/blank.png`; they feed the ART title page and footline |
| graphics path | beamerthemescu.sty:248 | `fig.graphicx` | `\graphicspath{{image/}{images/}{figure/}{figures/}{resources/}}` |
| doc-style macros | beamerthemescu.sty:44-46, :67-82 | `mark.kernel`, `font.size-commands` | `\cmd`, `\env`, `\pkg`, `\cls`, `\marg`, `\oarg`, `\Arg` are `\alert{\texttt{..}}` aliases; `\setfontscu` = `\fontsize{#1}{4}\selectfont`; reducible aliases, unused by the sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| Title page template | beamerinnerthemescu.sty:68-155 | No | TikZ artwork with plots, fading and seeded random arcs; no declarative way (`ART`) |
| Headline background and curve macros | beamerouterthemescu.sty:111-155 | No | TikZ polar curves in a savebox (`ART`) |
| Footline background, progress bar, ornament | beamerouterthemescu.sty:448-494, :626-650 | No | TikZ shapes plus `\divide`/`\multiply` bar-length arithmetic from counters (`ART` + `BESPOKE`) |
| Mini-frames re-implementation of `\slideentry` | beamerouterthemescu.sty:182-213 | No | rewrites beamer navigation internals to filter by section and subsection |
| Navigation tool strip with string parsing | beamerouterthemescu.sty:526-575 | No | `\StrSubstitute`, `\StrCount`, `\foreach` over a parsed option string choosing Acrobat actions and icon groups |
| `\EqualOptionsBeamer` dispatcher | beamerthemescu.sty:50-64 | Yes, by inlining | with every option fixed, each `\if\EqualOptionsBeamer{k}{v}` collapses to its chosen branch; not blocking alone |
| Theorem and code box overlays | beamerthemescu.sty:416-469, :472-528 | No | `\draw` programs inside tcolorbox `overlay` keys (`ART`) |
| Theorem environment generator `\beamer@scu@theo` | beamerthemescu.sty:662-720 | Yes (apart from overlays) | twelve `\DeclareTColorBox` + `\DeclareDocumentEnvironment` pairs = `thm.tcolorbox` declarations with `use counter`, `number within=section`, title prefix from a translated name, plus `actionenv` for overlay spec |
| `scuremark`, `scuproof` | beamerthemescu.sty:738-784 | Yes | tcolorbox declarations; `\providecommand\pushQED{\def\beamer@qed}` is a stub, `\pushQED{\qed}`/`\popQED` are amsthm calls |
| `\cref`/`\vref` rewrap | beamerthemescu.sty:1244-1247 | Yes, with a caveat | composition `\hyperlink{x}{\cref{x}}`; the target name equals the label, which only works if a matching `\hypertarget` exists |
| Page counter hook | beamerthemescu.sty:1250 | Yes, with a caveat | `\setcounter{page}{\c@framenumber}` inside an etoolbox hook on beamer's internal `beamer@framepauses` environment |
| Chinese varioref/cleveref names | beamerthemescu.sty:1253-1314 | Yes | strings for `xref.varioref` and `xref.cleveref`; the en sample uses :1316 only |
| Auto title frame and subsection TOC frame | beamerthemescu.sty:1162-1212 | Yes | frame bodies of beamer commands (`slide.beamer-section-hook`) |
| Colour theme | beamercolorthemescu.sty:1-248 | Yes | `color.xcolor` definitions and `\setbeamercolor` lines; the `Custom` branch's `\@ifundefined\color@` probe (:173) is a fallback-if-undefined guard |
| Font theme | beamerfontthemescu.sty:1-311 | Yes | `font.fontspec` and `font.unicode-math` calls and `\setbeamerfont`; the `Auto` branch probes the OS with `\IfFileExists` (:55-65) and is not used when `FontTheme=Custom` |
| Sample preamble hooks `\beamer@scu@fontextend`, `\beamer@scu@viextend` | main.tex:11-39 | Yes | `\setsansfont`, `\setmonofont` (`font.fontspec`) and four `\pgfdeclareimage` slots; they only exist because the zip-local theme calls them by name |
| `\mycopyright`, `\myestablish`, `\myupdate`, `\mailscu`, `\scuminijump` | beamerthemescu.sty:44-46, :82, :1227-1231 | Yes | text aliases and one `\NewTotalTCBox`; unused by the sample |

## Content-opaque
none (the table at main.tex:111-123 is expressible with `tbl.tabular` and `tbl.booktabs`; the placeholder `resources/blank.png` is 10x10 pixels and stands in for institution artwork that the zip does not ship, beamerthemescu.sty:310-316)

## Lib changes
- New ways proposed: none. Considered and rejected: `comment` (beamerthemescu.sty:189) provides a text-discarding environment, prints nothing and is not a template component; `xparse`, `ifthen`, `calc`, `xstring`, `etoolbox` (:190, :215, :232, :229) are load-only helper packages with no visible output. `\defbeamertemplate*` is filed under `slide.beamer-template` as the same beamer setter family.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Unselected branches that would add EXTERNAL cost: `CodeTheme=minted` and `minted2` load `minted` (beamerthemescu.sty:202-214) and `BIBMode=biber` loads `biblatex` with biber (:218-227). They are conditional and the sample selects neither (`BIBMode=none` main.tex:52; `CodeTheme` left at `listing`, beamerthemescu.sty:146). The ruling about unconditional `minted` therefore does not apply. The manifest hints list minted and biblatex because of these branches.
- Missing assets: with the defaults `VI=SCU` and `Background=SCU-Full` the theme needs `resources/SCUname.pdf`, `SCUlogo+name.pdf`, `SCUbuilding.png`, `SCUverify.png`, `background.png` and two more backgrounds (beamerthemescu.sty:270-273, :308-316); the zip ships only `blank.png`, and main.tex:21-32 says why.
- The sample prints two title slides (theme hook at beamerthemescu.sty:1162-1176 plus main.tex:68-70).
- No text addressed to an AI was found in the zip.
