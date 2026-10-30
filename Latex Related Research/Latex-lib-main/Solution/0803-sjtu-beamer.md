no

# 0803-sjtu-beamer: SJTU Beamer (SJTUBeamer theme, Chinese/English starter deck)

- Unverified: read from the source, not compiled.
- Source: Source/0803-sjtu-beamer/ (origin: https://latextemplates.com/downloads/sjtu-beamer.zip; licence: Apache-2.0 per the manifest and LICENSE:2-3; sjtuvi.sty:9-18 and sjtucover.sty:9-18 add a separate SJTU Visual Identity notice that asks for SJTU's acknowledgement of commercial use)
- Kind: presentation
- Lib: v6
- Engine: needs XeLaTeX (main.tex:1 `% !TeX program = xelatex`; Chinese text through the ctex class; no theme file loads fontspec)
- Look carried by: zip-local (the deck is `ctexbeamer` plus `\usetheme{sjtubeamer}`, main.tex:8-9; the look is defined by the zip-local theme styles beamerthemesjtubeamer.sty, beamer{color,font,inner,outer}themesjtubeamer.sty, sjtuvi.sty and sjtucover.sty)
- Class origin: tex-distribution-unbundled (`ctexbeamer` of the ctex bundle, CTAN and TeX Live, LPPL 1.3c; the ctan.org/pkg/ctex page read names no beamer class, so that `ctexbeamer` ships in it rests on the ctex manual from memory; not in the zip; the class source was not read; the theme styles it loads are zip-local, not on CTAN: ctan.org/pkg/sjtubeamer is a 404)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
No. The class is published, but the whole look comes from a zip-local theme family that is not on CTAN and not an official release as zipped. That theme draws its identity with TikZ: a stamp-shaped badge and a custom PGF decoration, logos recoloured through `tikzfadingfrompicture` masks, a full-page background made from such a mask, and TikZ-drawn title, closing and section pages. It also carries hand-written option conditionals, a cover-macro factory that redefines `\titlepage` and `\maketitle`, and box algorithms. The sample's own body (frames, itemize, columns, booktabs table, block) maps cleanly to lib ways, but the theme's `ART` and `BESPOKE` code blocks the `yes`.

## Blockers
- `ART/class` stamp badge `\stamptext`, a TikZ polygon node drawn behind the text; the sample's table of contents prints every section number through it (sjtuvi.sty:145-168; used at beamerinnerthemesjtubeamer.sty:126-129; main.tex:25-27)
- `ART/class` custom PGF decoration `stampline` (state machine of `\pgfpathlineto`) and `\tikzdeclarepattern{name=stamp}` with `\stamparray`: the "stamp edge" motif (sjtuvi.sty:169-255); used by `stampbox` (beamerinnerthemesjtubeamer.sty:169-186), `\stamphrule` (:187-203) and the min title page (sjtucover.sty:127-201)
- `ART/class` SJTU logos and background pictures turned into recolourable fading masks: `\definelogo` builds a `tikzfadingfrompicture` plus a clipped `tikzpicture` per image (sjtuvi.sty:62-96); the default `max` cover paints one as the page background of every frame (beamerinnerthemesjtubeamer.sty:68-71) and as the title graphic (sjtucover.sty:35)
- `ART/class` title page `max`: a `tikzpicture[overlay]` filled rectangle plus a scaled title graphic behind boxed title, author, institute and date (sjtucover.sty:80-116; called by the sample's `\titlepage`, main.tex:22); the other covers are drawn the same way: title `maxplus` (sjtucover.sty:42-79) and `min` (:127-201), bottom pages (:221-331), section pages (:388-423, :451-466, :479-513)
- `BESPOKE/class` hand-rolled option and conditional machinery that decides what is printed: `\DefineOption`, `\EqualOption` (a `\fi\ifEqualOption` trick over `\edef` and `\newif`) and `\IsEmpty` (box-width test) (sjtuvi.sty:22-47); used at every `\if\EqualOption{...}` in the theme files
- `BESPOKE/class` cover-macro factory `\definecover` that `\def`s `\titlepage`, `\maketitle`, `\makebottom`, `\makepart`, `\makesection` and `\makesubsection` through `\csname` and rewrites `\beamer@writeslidentry` (beamerinnerthemesjtubeamer.sty:79-112)
- `BESPOKE/class` `\secondaryinstlogo`, a box-and-glue layout (`\vbox to 1cm`, `\offinterlineskip`, `\prevdepth`) with a vertical rule and two font sizes (sjtuvi.sty:97-144); used by the `min` cover (sjtucover.sty:158-163)
- `BESPOKE/class` section-number names read from ctex internals `\CTEX@thepart`, `\CTEX@partname` and `\ctexset{section/name={第~,~节}}`, and `\ifbeamercolorwhite` over beamer internals `\beamer@thc@prepcolor` (sjtucover.sty:344-361, 427-438)
- `BESPOKE/class` frame-title template with internals (`\@tempdima`, `\beamer@leftmargin`, `\csname beamer@fte#1\endcsname`, hand-tuned negative `\vskip`s); inactive under the default logo position (beamerouterthemesjtubeamer.sty:41-80)
- `BESPOKE/class` `stampblock` environment with an optional-argument counter default (`\stepcounter{stampblockcnt}`) over `\stamptext`; not used by the sample (beamerinnerthemesjtubeamer.sty:204-228)
- `BESPOKE/class` pgfplotstable colour-row hack `\zapcolorreset` and `\colorrows` (`\noalign{\aftergroup...}`); active only if `pgfplotstable` is loaded, which the sample does not do (beamerinnerthemesjtubeamer.sty:334-361)

## Class setting
- Class: `class.ctexbeamer` options: `xcolor=table`, `aspectratio=169` (main.tex:8). The outer theme also forces `\beamer@compresstrue` (beamerouterthemesjtubeamer.sty:40), the same switch as the class option `compress`. Theme options are not given in the sample (main.tex:9). By reading order the defaults resolve to cover `max` with the logo at the bottom right (parent theme :34-39 runs `maxplus,min,my,max` and the last one wins, :25-33), colour `red` (:40-42), luminance `dark` (:43-45), language `zh` because `ctexbeamer` is loaded (:46-49) and navigation `miniframes` (:50-59). Read, not run.
- Class-native vocabulary used: `\title` `\subtitle` `\author` `\institute` `\date` (main.tex:13-17), `frame` with a title argument (main.tex:25), `\titlepage` (main.tex:22), `\tableofcontents` in a frame (main.tex:26), `\section` (main.tex:29), `columns[T]` and `column{0.5\textwidth}` (main.tex:42-51), `block` (main.tex:80); from ctex, Chinese text with automatic font setup.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:8 | `class.ctexbeamer` | `xcolor=table`, `aspectratio=169` |
| slide size | main.tex:8 | `page.class-options` | `aspectratio=169` (16:9 frame) |
| deck theme | main.tex:9; beamerthemesjtubeamer.sty:70-74 | `slide.beamer-theme` | `\usetheme{sjtubeamer}` (zip-local theme; the parent loads colour, font, inner and outer themes); the theme's code is a blocker, not the call |
| navigation / outer theme | beamerouterthemesjtubeamer.sty:87-88 | `slide.beamer-theme` | `\useoutertheme[footline=institutetitle]{miniframes}` |
| font theme | beamerfontthemesjtubeamer.sty:27-28 | `slide.beamer-theme` | `professionalfonts`, `structurebold` |
| fonts per element | beamerfontthemesjtubeamer.sty:29-32 | `slide.beamer-template` | `\setbeamerfont{part name,section name,subsection name}{size=\normalsize}`, `{footnote}{size=\footnotesize}` |
| colour constants | sjtuvi.sty:55-60 | `color.xcolor` | `\definecolor` RGB: red 167,32,56; orange 240,131,0; yellow 253,208,0; blue 0,64,152; green 51,141,39; teal 0,81,78 |
| colour aliases | beamercolorthemesjtubeamer.sty:33-43 | `color.xcolor` | `\colorlet{cprimary,csecondary,ctertiary,cquanternary}` (red branch; the blue branch is the other `\colorlet` set) |
| beamer colour roles | beamercolorthemesjtubeamer.sty:44-86 | `slide.beamer-template` | `\setbeamercolor` for structure, palette primary/secondary/tertiary (dark: `bg=cprimary`, `fg=white`), titles, block title/body (`bg=block title.bg!15`), head/foot, frametitle (`bg=white`, `fg=cprimary`), alerted text |
| frame title look | beamercolorthemesjtubeamer.sty:84-85; outer :111-112 | `slide.beamer-template` | `frametitle` white background, structure-red text |
| footline, logo, page counter | beamerouterthemesjtubeamer.sty:115-125, 126-133, 142 | `slide.beamer-template` | `\addtobeamertemplate{navigation symbols}` and `{footline}`: `\insertframenumber/\inserttotalframenumber` at `footline.fg!50`, logo raised 1pc, `\vskip 4pt`; `page number in head/foot` emptied |
| footline spacing and raise | beamerouterthemesjtubeamer.sty:117-122, 128-132 | `sp.manual-space` | `\raisebox{1.2pt}`, `\hspace*{0.2em}`, `\hfill`, `\llap`, `\hspace*{0.1cm}`, `\vskip 4pt` |
| Chinese typesetting | main.tex:8, 13-16; sjtucover.sty:349, 352 | `lang.cjk` | ctex via `ctexbeamer`; `\ctexset{section/name={第~,~节}}` and `{subsection/name={第~,~小节}}` |
| title block fields | main.tex:13-17 | `front.class-native` | `\title`, `\subtitle`, `\author`, `\institute`, `\date{\today}` |
| title page | main.tex:21-23; beamerinnerthemesjtubeamer.sty:92-95, 106, 108; sjtucover.sty:80-116 | `front.class-native` | `\titlepage` is redefined by the theme to `\usebeamertemplate*{title page}` with the `max` template; the drawing is `ART` (`art.tikz`) |
| title page artwork | sjtucover.sty:84-90 | `art.tikz` | `tikzpicture[overlay]`, `\fill [palette primary.bg]` rectangle, `\resizebox{1.3\paperwidth}{!}{\inserttitlegraphic}`; template identity, so `ART` |
| contents list | main.tex:25-27 | `toc.kernel` | `\tableofcontents` inside a frame |
| contents entry look | beamerinnerthemesjtubeamer.sty:126-138 | `slide.beamer-template` | `\defbeamertemplate{section in toc}{stamp}` with `\leftskip=8mm`, `\hspace{36mm}` for subsections, then `\setbeamertemplate{sections/subsections in toc}[stamp]` |
| contents badge | beamerinnerthemesjtubeamer.sty:127; sjtuvi.sty:145-168 | `art.tikz` | `\stamptext[structure]{number}`; `ART` |
| sectioning | main.tex:29, 39, 77, 89 | `head.class-native` | beamer `\section{...}`; no heading is printed in the frame area; entries feed the navigation bar and contents; no `\AtBeginSection` hook is used |
| page background | beamerinnerthemesjtubeamer.sty:68-71 | `art.tikz` | `\setbeamertemplate{background}{\bgcenterbox{\sjtubg[cprimary!50,opacity=0.2]}}` (cover `max`); `ART` |
| bulleted lists | main.tex:32-36, 45-49, 53-57, 83-86, 92-96 | `list.kernel` | `itemize` |
| list marker and indent | beamerinnerthemesjtubeamer.sty:121-125 | `slide.beamer-template` | `\setbeamertemplate{items}[circle]`, `\setbeamersize{description width=0.72em}` (`\setbeamersize` is taken as the same command family) |
| list indent lengths | beamerinnerthemesjtubeamer.sty:122-124 | `sp.lengths` | `\leftmargini`, `\leftmarginii`, `\leftmarginiii` all `1.4em` |
| two columns | main.tex:42-59, 51-58 | `cols.minipage` | beamer `columns[T]` of two `column{0.5\textwidth}`; side-by-side top-aligned boxes (class-native commands, the closest lib type) |
| table body | main.tex:63-74 | `tbl.tabular` | `tabular{lrr}` in a centred `table` float |
| table rules | main.tex:11, 66-71 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| table colour support | main.tex:8 | `tbl.colortbl` | class option `xcolor=table` (no colour command is called in the sample) |
| table caption | main.tex:73 | `cap.kernel` | `\caption{...}` (beamer's own caption template, unchanged) |
| centring | main.tex:64, 100 | `sp.ragged` | `\centering` |
| block | main.tex:80-82; beamerinnerthemesjtubeamer.sty:162-164 | `slide.beamer-template` | `\setbeamertemplate{blocks}[rounded]` (for covers other than `min`); title `fg=white`, `bg=cprimary!90`; body `bg=block title.bg!15` (beamercolorthemesjtubeamer.sty:64-74) |
| closing frame text | main.tex:100-102 | `font.size-commands` | `\Large`, `\normalsize` |
| closing frame line break | main.tex:101 | `sp.manual-space` | `\\` |
| code listing style (not used in sample) | beamerinnerthemesjtubeamer.sty:231-241 | `code.listings` | `\lstset{basicstyle=\ttfamily\small, keywordstyle=\color{cprimary}, stringstyle=\color{csecondary}, commentstyle=\color{ctertiary!50!gray}, columns=flexible, showstringspaces=false, breaklines}` |
| code box (not used in sample) | beamerinnerthemesjtubeamer.sty:57-60, 242-266, 272-297 | `code.tcblisting` | `\newtcblisting{codeblock}` and `\newtcbinputlisting{\codeblockinput}`: `listing engine=listings`, `numbers=left`, `colback=cprimary!5`, `colframe=cprimary!80`, `sharp corners`, one `overlay` fill for a number gutter; libraries `skins`, `listingsutf8`; `shield externalize` |
| box package (not used in sample) | beamerinnerthemesjtubeamer.sty:26, 57 | `box.tcolorbox` | `\RequirePackage{tcolorbox}` |
| pgfplots defaults (not used in sample) | beamerinnerthemesjtubeamer.sty:299-333 | `art.tikz` | `\pgfplotsset{every axis/.style=...}` with theme colours; only if `pgfplots` is loaded; styles chart content |
| algorithm name (not used in sample) | beamerinnerthemesjtubeamer.sty:362-366 | `alg.algorithm2e` | `\SetAlgorithmName` for `zh`, only if `algorithm2e` is loaded |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| Parent theme option plumbing (`\DeclareOptionBeamer`, `\PassOptionsToPackage`) | beamerthemesjtubeamer.sty:25-69 | Yes | An emitter resolves the options and writes `slide.beamer-theme` calls for the chosen branch; the `\def`-based conditionals are dropped. Only once the theme is a published way (it is not) |
| `\usesjtutheme` contrib loader (`\@for`, `\csname`, `\input` of a missing `contrib/` file) | beamerthemesjtubeamer.sty:75-93 | No | Hand-written loader; not used by the sample; the `contrib/` files are not in the zip. `BESPOKE/class` |
| `\DefineOption`, `\EqualOption`, `\IsEmpty` | sjtuvi.sty:25-47 | No | Hand-rolled conditionals driving what is printed. `BESPOKE/class` |
| `\definecover` factory | beamerinnerthemesjtubeamer.sty:79-112 | No | Redefines the kernel-level beamer commands `\titlepage`, `\maketitle`, `\sectionpage` through `\csname`. `BESPOKE/class` |
| `\definelogo` and the logo commands | sjtuvi.sty:62-96 | No | Per-image TikZ fading mask recoloured to the theme colour, with a `pgfmath` choice of width or height; no declarative lib way. `ART/class` |
| `\secondaryinstlogo` | sjtuvi.sty:97-144 | No | Box-and-glue layout. `BESPOKE/class` |
| `\stamptext`, `stampline`, stamp pattern, `\stamparray`, `\stamphrule`, `stampbox` | sjtuvi.sty:145-255; beamerinnerthemesjtubeamer.sty:169-203 | No | TikZ and PGF drawing code. `ART/class` |
| `\defbeamertemplate*` title, bottom, section pages | sjtucover.sty:42-331, 380-513 | No | TikZ overlay pages and tuned vertical glue; `\defbeamertemplate` writes new template code, which `slide.beamer-template` (set/select) does not cover. `ART/class` |
| Frame-title template (top-right logo position) | beamerouterthemesjtubeamer.sty:41-80 | No | Beamer internals and negative skips. `BESPOKE/class` (inactive by default) |
| `stampblock` and its counter | beamerinnerthemesjtubeamer.sty:204-228 | No | Optional-argument counter default drives the printed number. `BESPOKE/class` (unused) |
| ctex internals for section names, `\ifbeamercolorwhite` | sjtucover.sty:344-361, 427-438 | No | Reads package internals; the `\ctexset` calls alone would be `lang.cjk`. `BESPOKE/class` |
| `bibliolist` environment with `\articleitem`, `\bookitem`, `\onlineitem` | beamerinnerthemesjtubeamer.sty:139-161 | Yes | `bib.thebibliography` plus `slide.beamer-template` (`\setbeamertemplate{bibliography item}[article|book|online]`); aliases; unused by the sample |
| `\highlight`, `\highlightline`, `\paragraph` | beamerinnerthemesjtubeamer.sty:165-168, 267-271 | Yes | `slide.beamer-mode` (`\only<..>`), `box.fancybox` (`\colorbox`), `color.xcolor` (`\textcolor`), `sp.rule` (`\rule`); aliases; unused by the sample |
| `\bgcenterbox` | beamerinnerthemesjtubeamer.sty:63-67 | Yes, alone | `\parbox` plus `\resizebox`; it only carries the `ART` background above |
| `\Hy@WarnOptionDisabled` patch and `silence` `\WarningFilter` | beamerinnerthemesjtubeamer.sty:367-378; beamerfontthemesjtubeamer.sty:25-26 | Yes | Warning filters only, no printed effect; dropped (as the lib's v4 ruling on load-only packages without effect) |
| `\newdimen\beamer@sidebarwidth`, `\coverpage` | beamerinnerthemesjtubeamer.sty:77-91 | No | Part of the cover factory; sidebar offset logic. `BESPOKE/class` |
| pgfplotstable colour-row hack | beamerinnerthemesjtubeamer.sty:334-361 | No | `\aftergroup` hack. `BESPOKE/class` (inactive) |

## Content-opaque
none (the sample has no figure, TikZ picture or equation; the logo and background images in `vi/` are shipped assets used by the theme, not content, and are counted under `ART/class`)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
