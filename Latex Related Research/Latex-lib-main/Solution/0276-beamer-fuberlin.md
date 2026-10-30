yes

# 0276-beamer-fuberlin: beamer-FUBerlin (class FUbeamer and theme BerlinFU, Freie Universitaet Berlin corporate design)

- Unverified: read from the source, not compiled.
- Source: Source/0276-beamer-fuberlin/ (origin: https://mirrors.ctan.org/macros/latex/contrib/beamer-FUBerlin.zip; licence: LPPL 1.3)
- Kind: presentation
- Lib: v3
- Engine: pdfLaTeX-compatible (images chosen by `\ifpdf`: PNG/JPG under pdf, EPS otherwise, tex/latex/beamerouterthemeBerlinFU.sty:18-24; no fontspec, no Lua)
- Look carried by: class (the published theme `BerlinFU` and class `FUbeamer` hold the whole look; the main sample adds only class options, `inputenc`, `babel`, `\usetheme` and content)
- Class origin: ctan (ctan.org/pkg/beamer-fuberlin, v0.02b, LPPL 1.3, also in TeX Live; this zip is that CTAN package)
- Main file: doc/exampleTheme.tex (other samples: doc/exampleClass.tex)
- Read: main yes, zip-local classes and styles all (FUbeamer.cls 156 lines and the four `beamer*BerlinFU.sty` files, 197 lines, all read; Changes, README, doc/README.doc read; the two doc PDFs not opened)

## Verdict
yes. Both the theme `BerlinFU` and the class `FUbeamer` are released on CTAN by their author (Herbert Voss) with LPPL and example documents, so W1 holds and they are published ways, not zip-local code (rubric: "a package or class released on CTAN"). The main sample is `\documentclass[t,smaller,compress]{beamer}` plus `inputenc`, `babel[ngerman]` and `\usetheme{BerlinFU}` (doc/exampleTheme.tex:1-4); an emitter writes those lines and copies no theme macro. The theme's logo and banner images are not in the zip (missing assets, not a blocker).
Sensitivity, stated so the answer is not read as stronger than it is: the theme's own code (a `\defbeamertemplate*` title page that sizes the picture with `\numexpr` from `\wd\FU@box`, a `\maketitle` rewrite, a `\titlegraphic` redefinition) would not reduce to `\setbeamertemplate`-style lib ways if a reviewer decided to decompose a published theme instead of counting it as one way. I applied the rubric as written: published means a way, the theme name is a parameter of `slide.beamer-theme`.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `t`, `smaller`, `compress` (doc/exampleTheme.tex:1). Second sample: `class.FUbeamer` with the same options (doc/exampleClass.tex:1); FUbeamer forwards every option to beamer with `\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}` (tex/latex/FUbeamer.cls:21-22) and loads `\LoadClass[profesionalfonts,covered]{beamer}` (tex/latex/FUbeamer.cls:23; spelled with one `s`, beamer's own option is `professionalfonts`, so it may be a typo; read, not tested).
- Class-native vocabulary used: beamer `frame` environment with a title argument (doc/exampleTheme.tex:16,22), `\title` `\subtitle` `\author` with `\inst` and `\and`, `\institute`, `\date`, `\titlegraphic{file}`, `\maketitle`, `\tableofcontents`, `\section`, `\subsection`, `itemize` with an overlay specification (doc/exampleTheme.tex:7-14,17,20-23). FU additions: `\fachbereich{text}` (tex/latex/beamerouterthemeBerlinFU.sty:77; tex/latex/FUbeamer.cls:104) and `\titlegraphic[includegraphics options]{file}` redefined (tex/latex/beamerouterthemeBerlinFU.sty:64-73; tex/latex/FUbeamer.cls:90-98).
- Overlay text at doc/exampleTheme.tex:23 and tex/latex/beamerthemeBerlinFU.sty:27 is `<+-| alert@+>` (kept out of the table because of the pipe).

## Component map
Rows 1 to 16 are what the sample and the theme set; rows 17 to 27 are the theme's and class's inner parts (reference: they travel inside the published way). Paths are under `tex/latex/` unless they start with `doc/`; `thm` = beamerthemeBerlinFU.sty, `col` = beamercolorthemeBerlinFU.sty, `fnt` = beamerfontthemeBerlinFU.sty, `out` = beamerouterthemeBerlinFU.sty, `cls` = FUbeamer.cls.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| 1 document class (main sample) | doc/exampleTheme.tex:1 | `class.beamer` | t, smaller, compress |
| 2 document class (second sample) | doc/exampleClass.tex:1; cls:16-23 | `class.FUbeamer` | t, smaller, compress, forwarded to beamer |
| 3 theme selection | doc/exampleTheme.tex:4; thm:18-20 | `slide.beamer-theme` | `\usetheme{BerlinFU}`; the theme then calls `\usecolortheme` `\usefonttheme` `\useoutertheme` with the same name; theme option `compress` (thm:13-14) |
| 4 input encoding | doc/exampleTheme.tex:2; cls:24 | `font.fontenc-t1` | inputenc utf8; the class adds fontenc T1 |
| 5 language | doc/exampleTheme.tex:3; cls:18,25 | `lang.babel` | ngerman (the class passes it as a package option) |
| 6 title block | doc/exampleTheme.tex:7-14 | `front.class-native` | title, subtitle, author with `\inst` and `\and`, institute, date `\today`, `\titlegraphic{silberlaube2}`, `\fachbereich{ZEDAT}`, `\maketitle` |
| 7 contents frame | doc/exampleTheme.tex:16-18; thm:23 | `toc.kernel` | `\tableofcontents` in a frame; entry template `sections/subsections in toc` = ball |
| 8 sectioning | doc/exampleTheme.tex:20-21 | `head.class-native` | `\section`, `\subsection` (beamer: toc entries, no printed heading) |
| 9 itemised list | doc/exampleTheme.tex:23-27 | `list.kernel` | `itemize` with a beamer overlay specification |
| 10 overlays | thm:27; cls:23,67; doc/exampleTheme.tex:23 | `slide.beamer-mode` | `\beamerdefaultoverlayspecification` (text above); option `covered`; `\mode<presentation>` and `\mode<all>` (thm:16; cls:87-88,101-102) |
| 11 item and navigation templates | thm:22,24-25; cls:62,64-65; out:44-47 | `slide.beamer-template` | `itemize item`=default, `headline`={}, `navigation symbols`={}, four sidebar templates {} |
| 12 colour definitions | col:10-14; cls:30-34 | `color.xcolor` | FUblue RGB 0,51,102; FUgreen 153,204,0; FUred 204,0,0; FUorange 255,153,51; FUgray gray 0.6 |
| 13 beamer colours | col:16-32; cls:38-52 | `slide.beamer-template` | `\setbeamercolor*` for frametitle (fg FUgray), normal text, alerted text (FUred), footline (FUblue), structure (FUred), palette primary/secondary, separation line (FUblue), example text (FUgreen), block title and block body in three variants (20 percent and 50 percent mixes), titlelike parent structure (col:32 only) |
| 14 beamer fonts | fnt:15-21; cls:54-60 | `slide.beamer-template` | `\setbeamerfont`: tiny structure \tiny; title \Large bold; author \normalsize bold; frametitle \large bold; framesubtitle \footnotesize; footline \Tiny (the class adds mdseries, cls:59); date \footnotesize |
| 15 text face (class only) | cls:28 | `font.helvet` | `\RequirePackage[scaled]{helvet}`; the theme does not load it |
| 16 hyperlinks | cls:20; thm:12 | `meta.hyperref` | bookmarks, colorlinks (passed as options) |
| 17 page margins and text width | cls:36,71-72; out:12-13 | `slide.beamer-template` and `page.setlength` | `\setbeamersize{text margin left=15pt,text margin right=15pt}`; `\textwidth` = `\paperwidth` minus 30pt |
| 18 inner lengths | cls:73-75,85; out:14-16,25 | `sp.lengths` | `\newlength` and `\setlength`: image width = `\textwidth`, image height 2.5cm, rule 0.6pt, `\titlevsep` 2mm |
| 19 title page template | out:80-100; cls:108-128 | `slide.beamer-theme` | `\defbeamertemplate*{title page}{FU}`: logo at right, grey banner, title, subtitle, author and institute colour box, date, spaced by `\vfill` |
| 20 frame title template | out:51-54; cls:130-136 | `slide.beamer-theme` | `\defbeamertemplate{frametitle}{FU}`: logo at right, title in FUgray, full-width rule; the class puts title and logo in two `\parbox` of 0.6 and 0.32 `\textwidth` (cls:132-134) |
| 21 frametitle continuation | out:59 | `slide.beamer-theme` | `\defbeamertemplate*{frametitle continuation}{FU}` prints the roman continuation count |
| 22 footline | out:30-40; cls:141-151 | `hf.class-native` | `\defbeamertemplate{footline}{FU}`: rule, then fachbereich, title, date, and frame number over total frames (`\insertframenumber/\inserttotalframenumber`) |
| 23 template switch after the title page | thm:30-31; cls:138-139 | `slide.beamer-theme` | `\maketitle` redefined: title page frame, then `\setbeamertemplate{frametitle}[FU]` and `{footline}[FU]` |
| 24 logo, banner and title picture | out:18-26,64-73,82-85; cls:77-86,90-98 | `fig.graphicx` | `\pgfdeclareimage` and `\pgfuseimage` of FULogo.png (height 1cm) and FUbib.jpg (height 2.5cm), `\includegraphics[height=2.5cm,keepaspectratio=false]` for the title picture; image files only, no drawing code; assets not shipped |
| 25 rules and spacing | out:36,54,82,87; cls:110,115,135,147 | `sp.rule` and `sp.manual-space` | `\rule{\paperwidth}{\FU@rule}`, `\vspace`, `\vfill`, `\hfill`, `\\[len]` |
| 26 grey banner box | out:83-86; cls:111-114 | `box.fancybox` | `\colorbox{FUgray}{\makebox[\textwidth][l]{...}}` with `\fboxsep=0pt` |
| 27 packages loaded by the class, not used by the sample | cls:19,26,27 | `tbl.colortbl`, `fig.graphicx`, `tbl.tabularx` | xcolor option `table`; graphicx; tabularx |

## Bespoke code
By the rubric's definition nothing here is zip-local: every definition below sits in the CTAN release (class FUbeamer, theme BerlinFU), so it is the published way and is not decomposed. Listed so nothing is hidden.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\defbeamertemplate*{title page}{FU}` | out:80-100; cls:108-128 | not applicable (published) | named by `\usetheme{BerlinFU}`, row 19 |
| `\defbeamertemplate{frametitle}{FU}`, `{footline}{FU}`, `{frametitle continuation}{FU}` | out:34-40,51-54,59; cls:130-136,145-151 | not applicable (published) | rows 20 to 22 |
| `\def\maketitle` rewrite | thm:30-31; cls:138-139 | not applicable (published) | row 23 |
| `\renewcommand\titlegraphic[2][]` with `\edef` and `\numexpr` width from `\wd\FU@box` | out:64-73; cls:90-98 | not applicable (published) | row 24 |
| `\fachbereich` and `\insertfachbereich` | out:77-78; cls:104-105 | not applicable (published) | theme vocabulary, `front.class-native` |
| `\def\beamer@andinst{\quad }`, `\def\beamer@fteright{...}`, `\beamer@suppressreplacementstrue` | thm:28; out:56; fnt:14; cls:68 | not applicable (published) | tweaks of beamer internals, travel inside the theme |
| `\newlength` set, `\newsavebox\FU@box` | out:14-16,25-26; cls:73-75,85-86 | not applicable (published) | row 18 |

## Content-opaque
none. No TikZ, PGF drawing, `picture` or PSTricks code anywhere (only the PGF image-loading commands in row 24). Missing assets, not blockers: FULogo.png and FUbib.jpg (cls:78,84; out:19-20; removed from CTAN, Changes:3; official FU files, doc/README.doc:1-6), the EPS variants for non-pdf output (cls:81-82; out:22-23), and the sample title picture `silberlaube2` (doc/exampleTheme.tex:12). Ship them with the template.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
