yes

# 0121-uio-latex-uioposter: uioposter (University of Oslo scientific poster, beamer + beamerposter)

- Unverified: read from the source, not compiled.
- Source: Source/0121-uio-latex-uioposter/ (origin: https://codeload.github.com/uio-latex/uioposter/zip/refs/heads/master; licence: MIT, LICENSE:1-3, Martin Helsø 2020)
- Kind: poster
- Lib: v2
- Engine: pdfLaTeX-compatible (beamer, beamerposter, pgfpages, inputenx, T1, lmodern, beramono, textpos, todonotes; no fontspec, no shell escape, no external tool)
- Look carried by: zip-local (uioposter.cls holds every colour, font role, headline, footline and block template; the two samples add only title, authors, content and one textpos note)
- Class origin: zip-local (ctan.org/pkg/uioposter returned 404; the zip is a personal-author GitHub release, README.md:1-9 names no official UiO release; the class is a wrapper over the published `beamer`, `\LoadClass[t]{beamer}`, uioposter.cls:50)
- Main file: portrait.tex (other samples: landscape.tex, read in full; same class with option `landscape`, three columns, no institute)
- Read: main yes, zip-local classes and styles all (uioposter.cls 389 lines in full; README.md, LICENSE; the three PDFs in uioposter-images/ are logo images, not read as source)

## Verdict
Yes. The only zip-local code is `uioposter.cls`, which is `\LoadClass[t]{beamer}` plus `beamerposter` plus beamer theme, colour, font and template calls (headline, footline, three block templates) and a few preamble length and font lines; it has no TikZ, no picture code and no external tool. Its option handling, two `etoolbox` tests and one `\def` on a beamer internal are resolved when an emitter writes the preamble (the emitter knows size, language and whether an institute exists), and its custom `pgfpages` layout is declarative, with a proposed way `pg.pgfpages`. Judgement calls for a stricter reader are listed under "Bespoke code" (rows 5 and 6).

## Blockers
none

## Class setting
- Class: `class.beamer` options: `t` (uioposter.cls:50); every option the class does not declare is passed on to beamer (uioposter.cls:40). The zip-local class `uioposter` is not a way: it reduces to `class.beamer` plus the preamble below. Its own options (cls:11-39): language `english` (default) | `norsk`, orientation `portrait` (default) | `landscape`, paper `a0paper` (default) .. `a6paper`; defaults set at cls:43-45. Beamer source not read (ships with the TeX distribution).
- Class-native vocabulary used: beamer `frame` (portrait.tex:49), `columns[onlytextwidth]` and `column{<width>}` (portrait.tex:50,53,78), `block`, `exampleblock`, `alertblock` (portrait.tex:54,58,62), `\structure`, `\alert` (portrait.tex:55,63), `\title`, `\author` with `\inst` and `\and`, `\institute` (portrait.tex:24-39), `\inserttitle` `\insertauthor` `\insertinstitute` (cls:181,187,193), `beamercolorbox` with keys `wd ht dp leftskip rightskip vmode` (cls:170,222,235), `\setbeamercolor` `\setbeamerfont` `\setbeamertemplate` `\usebeamerfont` `\usebeamercolor` `\usebeamertemplate*` `\setbeamersize`. From beamerposter: `\VeryHuge` size command (cls:131).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | portrait.tex:14; landscape.tex:14; uioposter.cls:50 | `class.beamer` | `t`; sample options none / `landscape` (landscape is consumed by uioposter, cls:26-30) |
| poster page size, scale, orientation | uioposter.cls:21-30,45,53 | `poster.baposter` | `beamerposter[size=a0, scale=1.5]`, `orientation=portrait|landscape` passed with `\PassOptionsToPackage` from the class options; size is always a0 here |
| shrink the a0 page onto a1..a6 sheet | uioposter.cls:33-39,43,55,360-385 | `pg.pgfpages` | `\pgfpagesdeclarelayout{resize and center}` with `logical pages=1`, `physical height/width=\pgfpageoptionheight/Width`, `resized width/height=\pgfphysicalwidth/height`, `border shrink=\pgfpageoptionborder` (default 0pt), `center=\pgfpoint{.5\pgfphysicalwidth}{.5\pgfphysicalheight}`; `\pgfpagesuselayout{resize and center}[<size>paper, <orientation>]` emitted only when size is not `a0paper` |
| encoding | uioposter.cls:56-57 | `font.fontenc-t1` | `inputenx[utf8]`, `fontenc[T1]` (inputenx is the input-encoding sibling of inputenc) |
| micro-typography | uioposter.cls:59 | `sp.microtype` | `final` |
| roman face | uioposter.cls:60 | `font.lmodern` | `lmodern` |
| mono face | uioposter.cls:61 | `font.mono` | `beramono[scaled]` |
| sans default | uioposter.cls:69 | `font.family-default` | `\renewcommand{\sfdefault}{phv}` (Helvetica) |
| large math symbols | uioposter.cls:70-78 | `font.nfss` | `\DeclareFontShape{OMX}{cmex}{m}{n}` sizes `<-7.5>cmex7 <7.5-8.5>cmex8 <8.5-9.5>cmex9 <9.5->cmex10`; `\SetSymbolFont{largesymbols}{normal|bold}{OMX}{cmex}{m}{n}` |
| font theme, inner theme | uioposter.cls:85-86 | `slide.beamer-theme` | `\usefonttheme{serif}`, `\useinnertheme{rectangles}` |
| links | uioposter.cls:64-68 | `meta.hyperref` | `\hypersetup{colorlinks, urlcolor=uiolink, linkcolor=, citecolor=, filecolor=}` |
| margin-note width | uioposter.cls:79 | `page.setlength` | `\marginparwidth` = 2cm |
| text margins | uioposter.cls:96 | `slide.beamer-template` | `\setbeamersize{text margin left=3cm, text margin right=3cm}` |
| line-breaking lengths | uioposter.cls:80 | `sp.lengths` | `\emergencystretch` = 1em |
| line-breaking tolerance (norsk only) | uioposter.cls:12-18 | `sp.hyphenat` | `\pretolerance=2000`, `\tolerance=6000`, `\hbadness=6000` (the family `\sloppy` presets; `sp.penalties` considered, these are not penalties) |
| space after period | uioposter.cls:81 | `sp.frenchspacing` | `\frenchspacing` |
| list geometry | uioposter.cls:94-95 | `sp.lengths` | `\labelsep` = 3ex, `\leftmargini` = 18ex |
| navigation symbols, caption, qed mark, bullets | uioposter.cls:87-91 | `slide.beamer-template` | `navigation symbols`={}; `caption`=numbered; `caption label separator`={: }; `qed symbol`=`\(\blacksquare\)`; `itemize items`=`\color{itemize item.fg}\(\blacksquare\)` (`\blacksquare` is amssymb; beamer's own loading of it not read here) |
| colours | uioposter.cls:100-105 | `color.xcolor` | `\definecolor` uiored cmyk 0,1,1,0; uiowhite cmyk 0,0,0,0; uioblack cmyk 0,0,0,1; uioheader cmyk 0,0,0,0.6; uiobackground cmyk 0,0,0,0.2; uiolink HTML 0B5A9D |
| colour roles | uioposter.cls:109-125 | `slide.beamer-template` | `\setbeamercolor`: structure fg=uioheader; alerted text fg=uiored; background canvas fg=uioblack bg=uiobackground; headline and footline fg=uiowhite bg=uioblack; title in headline fg=uiored; block title/example/alerted bg=structure/uioblack/uiored fg=uiowhite; block body (three variants) fg=uioblack bg=uiowhite |
| font roles | uioposter.cls:129-164 | `slide.beamer-template`, `font.size-commands`, `mark.kernel` | `\setbeamerfont`: title in headline sf bold `\VeryHuge`; author in headline sf bold `\Large`; institute sf medium `\normalsize`; block titles sf bold `\large` (x3); block bodies rm `\normalfont` `\normalsize` (x3); item projected sf bold `\small` |
| headline | uioposter.cls:168-198 | `hf.class-native`, `slide.beamer-template` | `\setbeamertemplate{headline}`: `beamercolorbox[wd=\paperwidth, leftskip=3cm, rightskip=3cm plus 20cm]{headline}` holding logo, `\inserttitle`, `\insertauthor`, optional `\insertinstitute`; then `\vskip1cm` |
| headline logo | uioposter.cls:174-175 | `fig.graphicx` | `\includegraphics[scale=1.5]{uioposter-images/uioposter-logo-<english|norsk>}`; the language option only picks the file name; PDFs shipped |
| headline spacing | uioposter.cls:173,179-180,182,186,190,195,197 | `sp.manual-space` | `\vskip-0.5cm`, `\vskip0ex`, `\hskip-0.05ex`, `\vskip1ex`, `\vskip3cm`, `\vskip1cm` |
| footline | uioposter.cls:202-211 | `hf.class-native`, `slide.beamer-template`, `fig.graphicx`, `sp.manual-space` | `footline`: `beamercolorbox[wd=\paperwidth]{footline}` with `\vskip2cm`, `\hskip4.1cm`, `\includegraphics[scale=1.5]{uioposter-images/uioposter-apollon}`, `\vskip2cm`; removable by `\setbeamertemplate{footline}{}` (portrait.tex:45, commented) |
| block look (plain, example, alerted) | uioposter.cls:215-255,259-299,303-343 | `slide.beamer-template` | `block begin/end`, `block example begin/end`, `block alerted begin/end`: title `beamercolorbox[ht=3.2ex, dp=1.3ex, leftskip=2ex, rightskip=2ex]`, body `beamercolorbox[dp=2ex, leftskip=2ex, rightskip=2ex, vmode]`, `\vskip2ex`, `\nointerlineskip`, end `\vskip0.2ex` then `\vskip3cm`; per-block `\setbeamercolor` for itemize item, item projected, description item |
| block body wrapper | uioposter.cls:243-245,251 | `box.minipage`, `sp.lengths` | `minipage{\textwidth-4ex}` opened in `block begin`, closed in `block end`; `\parskip` = 1.5ex, `\abovecaptionskip` = 1ex; width expression needs `calc` (cls:58) or `\dimexpr` |
| enumerate-style cross-reference | uioposter.cls:347-355 | `slide.beamer-template`, `xref.kernel` | `\enumitem{x}` = `\usebeamertemplate*{enumerate item}` with `\insertenumlabel` = x; `\enumref{k}` = `\enumitem{\ref{k}}`; not used in either sample |
| front matter | portrait.tex:24-39; landscape.tex:24-41 | `front.class-native` | `\title`, `\author{.. \inst{1} \and ..}`, `\institute{\inst{1} .. \and ..}`; printed by the headline template, no `\maketitle` or `\titlepage` |
| frame and columns | portrait.tex:49-97; landscape.tex:49-96 | `class.beamer` (native) | one `frame`; `columns[onlytextwidth]`; two columns `0.5\textwidth - 1.5cm` (portrait), three columns `\textwidth/3 - 2cm` (landscape); needs `calc` (cls:58) or `\dimexpr` |
| blocks in body | portrait.tex:54-93; landscape.tex:54-92 | `slide.beamer-template` | `block`, `exampleblock`, `alertblock` with titles; look from the templates above |
| inline emphasis | portrait.tex:55,59,63; landscape.tex:66,83 | `mark.kernel`, `slide.beamer-template` | `\textbf`; `\structure`, `\alert` (colours from the `structure` and `alerted text` roles) |
| placeholder figure | portrait.tex:18,72; landscape.tex:18,71 | `draft.todo` | `todonotes[figwidth=0.98\linewidth]`, `\missingfigure{..}`; a stand-in for a figure, followed by `\unskip` |
| absolutely placed note | portrait.tex:19-21,100-106; landscape.tex:19-21,99-105 | `pg.textpos`, `sp.lengths`, `color.xcolor`, `mark.kernel`, `sp.manual-space` | `textpos[absolute, overlay]`; `\TPHorizModule`=`\paperwidth`, `\TPVertModule`=`\paperheight`; `textblock{0.5}(0.18, 0.94)` (landscape (0.12, 0.92)); `\color{white}`, `\sffamily`, `\textbf`, `\\` |

Not mapped, by design: `etoolbox` (cls:54, programming helper, fails W2; its two tests are resolved at emit time, see below), `calc` (cls:58, syntax for length expressions, replaceable by `\dimexpr`), `lipsum` (portrait.tex:17, dummy-text generator, content). No babel or polyglossia is loaded, so the `english`/`norsk` option sets no hyphenation language, only the logo file and the norsk tolerances.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| 1. `uioposter.cls` as a whole | uioposter.cls:1-389 | yes | `\documentclass[t]{beamer}` followed by the preamble rows above (inlined) |
| 2. option machinery `\DeclareOption`, `\ExecuteOptions`, `\ProcessOptions`, `\DeclareOption*` pass-through | uioposter.cls:11-47 | yes | option values are parameters fixed per emitted poster (defaults a0paper, english, portrait, cls:43-45); the emitter writes their effects directly (beamerposter orientation, logo file, pgfpages call) |
| 3. string macros `\uioposter@lang`, `\uioposter@size`, `\uioposter@orientation` | uioposter.cls:11,14,24,29,33-39,175,383-384 | yes | plain substitution into the logo file name and the `pgfpages` option list |
| 4. `\ifdefstring{\uioposter@size}{a0paper}{}{...}` | uioposter.cls:381-385 | yes | emit-time test: write `\pgfpagesuselayout{resize and center}[<size>, <orientation>]` only when size is not a0 |
| 5. `\ifdefempty{\insertinstitute}{}{...}` (judgement call) | uioposter.cls:188-194 | yes | the emitter knows whether the poster has an institute; emit the headline with or without the institute lines (`\vskip1ex`, `\usebeamerfont{institute}`, `\insertinstitute`); no loop, counter or computed layout |
| 6. `\def\beamer@andinst{\quad}` (judgement call) | uioposter.cls:192 | yes | one value on a beamer internal: `\and` between institutes prints `\quad`; the emitter can write `\quad` (`sp.manual-space`) between the institute entries instead, or keep the line with `\makeatletter` |
| 7. custom pgfpages layout `resize and center` | uioposter.cls:360-378 | yes | `pg.pgfpages`: layout declaration with key lists only, no box code |
| 8. `\enumitem`, `\enumref` | uioposter.cls:347-355 | yes | aliases of beamer `\usebeamertemplate*{enumerate item}` with `\insertenumlabel` and `\ref` (`slide.beamer-template`, `xref.kernel`) |
| 9. cmex size table and `\SetSymbolFont` | uioposter.cls:70-78 | yes | `font.nfss` declarations, values only |
| 10. three near-identical block templates | uioposter.cls:215-343 | yes | `slide.beamer-template` x6 (begin/end per variant); note: the example variant calls `\usebeamerfont{block example body}` (cls:285) while the font defined is `block body example` (cls:154); not determined here what beamer does with the unknown name |

## Content-opaque
none (the three logo PDFs are images held by `fig.graphicx`, shipped in uioposter-images/; `\lipsum[n]` at portrait.tex:67,71,80,84,88,92 and landscape.tex:55,59,70,76,87,91 is dummy text, content)

## Lib changes
- New ways proposed: `pg.pgfpages` `pgfpages` (part of the PGF bundle, CTAN `pgf`, TeX Live), engine pdf: `\pgfpagesuselayout{<layout>}[<keys>]` and `\pgfpagesdeclarelayout{<name>}{<defaults>}{<page options>}` place logical pages onto physical sheets (n-up, resize, centre, border shrink, paper-size keys). W1: published in PGF with a public manual. W2: behaviour chosen by key values (`logical pages`, `physical width`, `resized width`, `border shrink`, `center`, `a4paper`, `landscape`). W3: serves any document (handouts, n-up, resizing), not this poster. W4: one preamble call. Not `slide.beamer-mode` (beamer's handout switch), not `pg.landscape` (rotates pages), not `poster.baposter` (sets the logical page, not the physical sheet), not `art.tikz` (no drawing).
- Considered, no way: `etoolbox`, `calc` (support packages, see the note under the component map).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
