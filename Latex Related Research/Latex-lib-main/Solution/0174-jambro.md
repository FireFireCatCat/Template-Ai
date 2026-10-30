no

# 0174-jambro: Jambro (Beamer theme with hand-drawn annotations)

- Unverified: read from the source, not compiled.
- Source: Source/0174-jambro/ (origin: https://latextemplates.com/downloads/jambro-beamer.zip; licence: GPL-3.0)
- Kind: presentation
- Lib: v3 (the snapshot read)
- Engine: pdfLaTeX-compatible, with a pdfTeX-only primitive (`\pdfliteral` at beamerthemejambro.sty:293); `remember picture` overlays need two passes; the handwriting family `augie` is selected by name only (beamerthemejambro.sty:284), no `\usepackage` loads it, availability not checked
- Look carried by: zip-local (`\documentclass{beamer}` main.tex:1 is unchanged; the whole look is `beamerthemejambro.sty`, loaded by `\usetheme{jambro}` main.tex:2; `ctan.org/pkg/beamerthemejambro` is a 404, so the theme is not published)
- Class origin: tex-distribution-unbundled (class `beamer`; its source was not read; the zip-local theme is the separate, zip-local part)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (beamerthemejambro.sty, 1379 lines, read in full)

## Verdict
No. The theme is mostly a composition of published packages and beamer templates (colours, fonts, footline, lists, tables, boxes), and all of that reduces to lib ways. But its identity is a family of hand-drawn TikZ annotations (`\lapis`, `\lapisnote`, `\marker`, `\lapisbox`, `\jarrow*`) built on a custom `sketch` pgf decoration that draws with `rand`, and the sample uses three of them (main.tex:21, 67, 72). That is template-defining artwork (`ART`) plus irreducible bespoke code (`BESPOKE`); `\handbold` also writes a raw `\pdfliteral` (main.tex:90).

## Blockers
- `ART/class` hand-drawn pencil annotations: `\lapis` underline (beamerthemejambro.sty:740-759), `\lapisbox` and `\lapisboxeq` boxes (:777-807, :815-846), `\jarrow*` arrows (:872-911), `\marker` anchor nodes (:731-735), `pencil`/`arrow`/`snake` styles (:694-719); the sample uses `\lapis` (main.tex:21), `\marker` (main.tex:67), `\lapisnote` (main.tex:72); the theme states this is its purpose (:9-10)
- `BESPOKE/class` `sketch` decoration declared with `\pgfdeclaredecoration` and `rand` (:667-687), "intentionally non-deterministic" (:659), fed by a hand-written `wiggle=` option parser over `\@classoptionslist` (:99-120)
- `BESPOKE/class` `\lapisnote` dispatch code: an `\ifx` cascade over 8 compass directions computing anchors and angles, plus numeric bend via `\pgfmathparse` (:955-1139; used main.tex:72)
- `BESPOKE/class` `\handbold` writes raw PDF operators `\pdfliteral direct{#1 w 2 Tr}` (:292-294; used main.tex:90); no lib way, pdfTeX-only
- `BESPOKE/class` patches of other packages' private macros: soul `\hl` rebound to beamer's `\beamerorig@set@color` (:1157-1160, used through `\stabilo` main.tex:76) and natbib `\NAT@open`/`\NAT@close` (:1370-1371)
- `ART/class` footline colour band painted with a TikZ `current page` overlay (:599-604 and :616-621); a plain filled rectangle, probably expressible as a `beamercolorbox`, but not shown here, so counted

## Class setting
- Class: `class.beamer` options: none in the sample (main.tex:1). The theme declares `3to2` `shownotes` `handout2x1` `light` `cabin` `roboto` `red` `night` `onesec` `itemsep` `hidememo` `centertitle` `wiggle=<n>` (beamerthemejambro.sty:74-85, :114); none is set, so the defaults apply (16:9, blue, Fira Sans Book)
- Class-native vocabulary used: `\usetheme` (main.tex:2), `\title` `\subtitle` `\author` `\institute` `\date` `\maketitle` (main.tex:7-15), `\section` (main.tex:17), `frame` with a title argument (main.tex:19), `columns`/`column` with `[T]` (main.tex:31-48), `itemize`/`enumerate` in frames, `table` in a frame (main.tex:56). Theme side: `\setbeamertemplate`, `\defbeamertemplate`, `\setbeamercolor`, `\setbeamerfont`, `\setbeamersize`, `beamercolorbox`, `\insertsectionnavigationhorizontal`, `\insertframenumber`

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.beamer` | no options |
| theme selection | main.tex:2 | `slide.beamer-theme` for the published inner theme only; `jambro` is zip-local (not a published name), so it is replaced by the rows below | `\useinnertheme{rounded}` (:392) |
| slide size | beamerthemejambro.sty:134-138 | `page.geometry` | paperwidth=16cm, paperheight=9cm (option `3to2`: 15cm x 10cm); beamer loads `geometry` itself (not read) |
| text margins | beamerthemejambro.sty:402 | `slide.beamer-template` | `\setbeamersize{text margin left=0.3cm, text margin right=0.1cm}` |
| margin-note width | beamerthemejambro.sty:255 | `page.setlength` | `\marginparwidth`=2cm |
| navigation symbols, headline | beamerthemejambro.sty:395, 398 | `slide.beamer-template` | navigation symbols empty; `\defbeamertemplate*{headline}` empty hbox |
| footline | beamerthemejambro.sty:615-634 | `hf.class-native`, `slide.beamer-template` | `\defbeamertemplate*{footline}`: beamercolorbox `author in head/foot` wd=paperwidth-2pt, ht=2.5ex, dp=1.125ex, `\insertsectionnavigationhorizontal{.90\textwidth}`, `\# \insertframenumber`; shaded inactive sections `[default][30]` (:409); colour band is ART (see Blockers) |
| colours | beamerthemejambro.sty:304-350 | `color.xcolor` | `\definecolor` RGB: title 7,40,91; main 57,83,124; text 0,0,0; light 255,255,255; bubble 230,233,239; hlight 235,203,139; carandache 218,165,32; BoE and extended palettes; script 255,248,225; red variant :362-370, night variant :374-382 |
| beamer colours | beamerthemejambro.sty:412-422 | `slide.beamer-template` | `normal text` fg=text; `background canvas` bg=light; `math text` fg=title!95; `titlelike`, `frametitle`, `section/author/title in head/foot`, `button` |
| beamer fonts | beamerthemejambro.sty:405-406, 425-426 | `slide.beamer-template`, `font.size-commands` | title `series=\bfseries` `\fontsize{18}{19}`; frametitle `\fontsize{15}{16}` bold |
| encodings | main.tex:4-5; beamerthemejambro.sty:203-204 | `font.fontenc-t1` | `inputenc` utf8, `fontenc` T1 |
| sans text and math faces | beamerthemejambro.sty:205, 212-216, 222, 228 | `font.helvet` | `FiraSans` options `sfdefault,book` (`light` with option); `cabin` `sfdefault`; `roboto` `sfdefault,light`; `arevmath` (a sans math package of the `sfmath` kind; mapping to this line is a judgement call) |
| monospace, upright Greek | beamerthemejambro.sty:206-207 | `font.mono`, `math.bm` | `courier`; `upgreek` (an extra math symbol alphabet; closest line, judgement call) |
| handwriting face | beamerthemejambro.sty:283-286 | `font.nfss` | `\fontfamily{augie}\fontshape{n}\selectfont`, `\DeclareTextFontCommand{\textaugie}{\hand}`; used main.tex:50 |
| extra sizes | beamerthemejambro.sty:1193, 1199, 454 | `font.size-commands` | `\miniscule` `\@setfontsize` 4/6; `\tablesize` 7.25/8.0 (used main.tex:58); `\ssmall` from `moresize` (:245) |
| math packages | beamerthemejambro.sty:232 | `math.amsmath`, `math.amssymb`, `math.mathtools`, `math.physics` | `amsmath,amssymb,amsfonts,mathtools,braket`; `\EE`=`\mathbb{E}` (:1340) |
| title page | main.tex:7-11, 15 | `front.class-native`, `front.maketitle` | `\title \subtitle \author \institute \date{\today}` then `\maketitle`; title font `\setbeamerfont{title}` (:405) |
| sections | main.tex:17, 28, 53, 84 | `head.kernel` | `\section{...}`, shown only in the footline navigation |
| frame titles | main.tex:19; beamerthemejambro.sty:406, 418, 432-439 | `head.class-native`, `slide.beamer-template` | `frametitle` colours/font; option `centertitle` redefines the `frametitle` template with `beamercolorbox[wd=\paperwidth,sep=0.3cm,center]` |
| bullet lists | main.tex:20-24, 34-38, 42-46, 77-81; beamerthemejambro.sty:449-459, 466-470 | `list.kernel`, `slide.beamer-template`, `font.icons` | `itemize items` triangle; subitem `\ssmall\ding{81}`; subsubitem `\ssmall\ding{59}`; colours fg=main |
| numbered list | main.tex:87-91; beamerthemejambro.sty:463, 469-470 | `list.kernel`, `slide.beamer-template` | `\setbeamertemplate{enumerate item}{\insertenumlabel)}` |
| list spacing (option off) | beamerthemejambro.sty:486-552, 558 | `sp.lengths` | per-depth `\itemsep`/`\topsep` 14pt (level 1), 5pt (level 2); `\lineskiplimit`=-5pt on `\AtBeginEnvironment{itemize}` |
| two columns | main.tex:31-48 | `cols.minipage` | beamer `columns[T]` with two `column` of 0.48\textwidth (side-by-side fixed-width boxes; a class-native construct filed under the closest line) |
| table | main.tex:56-71; beamerthemejambro.sty:238-243, 1265, 1271-1272 | `tbl.tabularx`, `tbl.booktabs`, `tbl.tabular`, `tbl.colortbl`, `sp.ragged` | `tabularx{\textwidth}{lYYY}`, `\toprule \midrule \bottomrule`, `\renewcommand{\arraystretch}{1.15}`, `\newcolumntype{Y}`/`{S}` (centred X; S adds `\color{gray!25}`), `\centering` |
| captions | beamerthemejambro.sty:237 | `cap.caption` | package loaded, no options; no `\caption` in the sample |
| centred closing slide | main.tex:95-99 | `sp.ragged`, `font.size-commands` | `\centering \Large ... \normalsize` |
| manual spacing | main.tex:49, 97; beamerthemejambro.sty:1322 | `sp.manual-space` | `\vs{n}` = `\vspace{0.ncm}` |
| highlighter | main.tex:76; beamerthemejambro.sty:1163-1165 | `mark.ulem` | `soul` `\sethlcolor{hlight}\hl{..}` (the colour-hook patch is a blocker) |
| draft memo | main.tex:23; beamerthemejambro.sty:1311-1316 | `font.nfss`, `font.size-commands`, `color.xcolor`, `mark.ulem` | `\textcolor{c}{{\hand\small\underline{user}: text}}`, keys `user=` `color=` |
| callout bubble | main.tex:25; beamerthemejambro.sty:253, 1177-1181 | `draft.todo`, `box.minipage` | `todonotes` options `bordercolor=white,backgroundcolor=script,linecolor=black`; `\todo[textcolor=text,color=bubble,inline,caption={}]` in a minipage of `\textwidth` |
| hand-drawn bold | main.tex:90; beamerthemejambro.sty:292-294 | none (BESPOKE) | `\hand` plus `\pdfliteral direct{0.6 w 2 Tr}` |
| pencil underline, arrow, anchor | main.tex:21, 67, 72; beamerthemejambro.sty:731-1139 | `art.tikz` (ART, a blocker) | see Blockers |
| tcolorbox boxes | beamerthemejambro.sty:258-259, 1221-1255 | `box.tcolorbox` | `\newtcbox{\jcode}` colback=script!80, boxrule=0pt; `jCodeBox` arc=0.6mm, enhanced, breakable, width=0.9\textwidth; `\tcbuselibrary{breakable,skins}`; not used in the sample |
| verbatim helpers | beamerthemejambro.sty:258, 1211-1217 | `code.verbatim` | `\jverb`=`\texttt{\detokenize{#1}}`; `jVerb` wraps fancyvrb `Verbatim` with `\small` and 1ex spacing; `listings` loaded (:258), never called (`code.listings`); not used in the sample |
| indented block | beamerthemejambro.sty:244, 1326-1336 | `page.adjustwidth` | `changemargin{left}{right}` is a `list` with `\leftmargin`/`\rightmargin`; reducible to `adjustwidth` |
| symbols | beamerthemejambro.sty:247, 250, 1343-1344 | `font.icons`, `color.xcolor` | `eurosym`, `pifont`, `bbding`; `\cmark` `\ding{51}` tomato, `\xmark` `\ding{55}` cobalt |
| absolute positioning | beamerthemejambro.sty:240 | `pg.textpos` | `textpos` options `absolute,overlay` (loaded, no `textblock` call) |
| hyperlinks | beamerthemejambro.sty:262-269 | `meta.hyperref` | `colorlinks, citecolor=main, urlcolor=main, linkcolor=main`; footline and ToC links set to white/title (:570, :581, :606, :623) |
| contents slide (not in sample) | beamerthemejambro.sty:568-587 | `slide.beamer-template`, `font.nfss` | `section in toc` / `subsection in toc` parbox with numbering `n)`; the section entry calls `\lapis[BoEacqua]` (ART) |
| citations | beamerthemejambro.sty:272, 1358, 1362 | `bib.natbib`, `bib.thebibliography`, `color.xcolor` | `\citej`=`\textcolor{main}{[\cite{#1}]}`; `\newblock` glue; no bibliography in the sample |
| handout 2-up and notes | beamerthemejambro.sty:141-145, 152-165 | `slide.beamer-mode`, `pg.pgfpages` | `shownotes`, `handout2x1`: `\pgfpagesuselayout{2 on 1}[a4paper, border shrink=1mm]`, `\pgfpageslogicalpageoptions{1..4}{border code=...2.5pt}`; theme sets beamer's internal flags directly, the declarative forms are the `handout` class option and `\setbeameroption` |
| notes block | beamerthemejambro.sty:177-192 | `sp.ragged`, `mark.ulem`, `font.size-commands`, `sp.lengths`, `num.counters` | `flushleft` + underlined bold "Notes", `\footnotesize`, `\parskip`=.15cm; `\shownotesblockzero` saves and resets counter `framenumber` |
| graphics | beamerthemejambro.sty:236 | `fig.graphicx` | package loaded; no image in the sample |
| load-only, never called | beamerthemejambro.sty:246, 258, 262 | `sp.setspace` (setspace); `box.mdframed` (mdframed, framed); `math.subdepth` (subdepth) | setspace, mdframed and framed are loaded without a call in theme or sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option switches `\newif` x12, `\DeclareOption`, `\ProcessOptions*` | beamerthemejambro.sty:46-85, 123 | yes | the emitter writes the chosen branch only (colour set, font package, footline variant) |
| `wiggle=` parser, `\jambrowiggleamp` | beamerthemejambro.sty:99-120 | no | only feeds the `sketch` decoration amplitude |
| `sketch` decoration | beamerthemejambro.sty:667-687 | no | custom pgf decoration with `rand`; no lib way |
| `pencil` `arrow` `snake` styles | beamerthemejambro.sty:694-719 | no | `pencil` needs `sketch`; drawing styles (ART) |
| `\marker`, `\lapis`, `\lapisbox`, `\lapisboxeq`, `\jarrow*` | beamerthemejambro.sty:731-911 | no | TikZ drawings that are the template's identity (ART) |
| `\lapisnote` | beamerthemejambro.sty:955-1139 | no | compass dispatch by `\ifx`, overlay node plus arrow, `\vspace{-.4cm}` fudge (:1138) |
| `\handbold` | beamerthemejambro.sty:292-294 | no | raw PDF text-rendering-mode literal |
| `\hand`, `\textaugie` | beamerthemejambro.sty:283-286 | yes | `font.nfss`: `\fontfamily{augie}\selectfont` |
| `\oldstylenums` redefinition | beamerthemejambro.sty:213, 216 | yes | alias to FiraSans `\firaoldstyle` (part of the `font.helvet` package) |
| `\stabilo`, `\hl` colour-hook patch | beamerthemejambro.sty:1157-1165 | `\stabilo` yes, patch no | `\stabilo` = `mark.ulem` `\sethlcolor`+`\hl`; the `\let\set@color\beamerorig@set@color` patch edits beamer/soul internals |
| natbib paren patch | beamerthemejambro.sty:1370-1371 | no | redefines natbib's private `\NAT@open`/`\NAT@close` |
| `\NB`, `\memo`, `\vs`, `\jverb`, `jVerb`, `\jcode`, `jCodeBox`, `\jCode`, `\citej`, `\cmark`, `\xmark`, `\sym`, `\EE`, `\tablesize`, `\miniscule` | beamerthemejambro.sty:1177-1358 | yes | each is a composition of rows in the Component map (aliases and key=value wrappers; `\sym` is `{#1}`) |
| `Y`, `S` column types | beamerthemejambro.sty:1271-1272 | yes | `\newcolumntype` over `X` with `\centering\arraybackslash` and `\color{gray!25}` |
| `changemargin` | beamerthemejambro.sty:1326-1336 | yes | `page.adjustwidth{left}{right}` |
| `itemsep` option: `\RenewDocumentEnvironment{itemize}`/`{enumerate}` with `\@listdepth` tests | beamerthemejambro.sty:486-552 | yes (option off here) | per-depth `\itemsep`/`\topsep` values through beamer `itemize/enumerate body begin` templates; not enabled by the sample |
| `\AtBeginEnvironment{itemize}{\setlength{\lineskiplimit}{-5pt}}` | beamerthemejambro.sty:558 | yes | `sp.lengths` set at the start of each itemize body |
| `\shownotesblock`, `\shownotesblockzero` | beamerthemejambro.sty:178-192 | yes | see "notes block" row |
| beamer internals `\beamer@ignorenonframefalse`, `\gdef\beamer@currentmode{handout}` | beamerthemejambro.sty:142-145, 153 | yes | `slide.beamer-mode` (`\setbeameroption{show notes}`, class option `handout`) |
| footline `\tikz` band | beamerthemejambro.sty:596-631 | not shown | counted with ART |
| `\newblock` definition | beamerthemejambro.sty:1362 | yes | kernel bibliography glue |

## Content-opaque
none (the `tabularx` table at main.tex:56-71 is ordinary table content; the `\marker` node inside it, main.tex:67, belongs to the ART blocker, not to the table)

## Lib changes
- New ways proposed: `math.subdepth` `subdepth` (CTAN, Will Robertson, LPPL 1.3c, one `ctan.org/pkg/subdepth` read), pdfLaTeX; load-only fix that gives subscripts the same depth with or without a superscript, no options (loaded at beamerthemejambro.sty:262). W1 published on CTAN and TeX Live; W2 no code to edit, a load-only switch like `math.icomma`; W3 serves any maths document; W4 one `\usepackage` line.
- Considered, not proposed: `animate` (loaded at beamerthemejambro.sty:241, no `\animategraphics` or `animateinline` call in the theme or the sample; would be proposed by a zip that uses it), `comment` (loaded at :262, no `comment` environment or `\excludecomment` call), `xkeyval` and `xspace` (programming helpers, no printed effect).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
