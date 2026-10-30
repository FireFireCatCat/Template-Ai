no

# 0496-flowfram: flowfram (frame-based page layout package, with its user manual and samples)

- Unverified: read from the source, not compiled.
- Source: Source/0496-flowfram/ (origin: https://mirrors.ctan.org/macros/latex/contrib/flowfram.zip; licence: lppl1.3)
- Kind: book (the main sample is a landscape KOMA `scrbook` user manual; the bundle's own purpose and its samples are poster, brochure and newsletter layouts)
- Lib: v4
- Engine: needs LuaLaTeX (the manual: `% arara: lualatex` flowfram-manual.tex:1, `\directlua{os.execute(...)}` :10, `fontspec` :22); `flowfram.sty` itself is pdfLaTeX-compatible (the shipped examples are built with `% arara: pdflatex`, flowfram-manual-examples/flowfram-manual-example001.tex:4)
- Look carried by: mixed (KOMA `scrbook` defaults; the manual's own preamble of flowfram frames, flowfram-manual.tex:4392-4527; and `nlctuserguide.sty`, which is not in the zip, for boxes, examples and glossaries)
- Class origin: tex-distribution-unbundled (`scrbook`, KOMA-Script, not read); `flowfram.sty` itself is on CTAN and in TeX Live (ctan.org/pkg/flowfram: v2.3, LPPL 1.3)
- Main file: flowfram-manual.tex (other samples: samples/sample.tex, sample1.tex, sample2.tex, sample3.tex, sample-article.tex, sample-blanks.tex, sample-book.tex, sample-brochure.tex, sample-news.tex, sample-news2.tex, sample-pages.tex, sample-poster.tex, sample-rot.tex, sampleRL.tex; flowfram-manual-examples/flowfram-manual-example001..005.tex; code source flowfram.dtx)
- Read: main partly (read lines 1-1900, 3401-5900, 6016-6135, 6340-6400, 6415-6835, 7059-7800, 8725-8800, 8880-8960, 9001-9040, 9448-9560, 10260-10300, 10600-10643; NOT read: 1901-3400 which is the same glossary-data form as 401-1900 and 3401-4390, and 5901-6015, 6136-6339, 6836-7058, 7801-8724 (except spots), 8801-9000, 9041-9447, 9561-10259, 10301-10599, which are documentation prose with no `\newcommand`, `\def`, `\input` or `tikzpicture` per a grep of the file); samples read: sample.tex, sample3.tex, sample-pages.tex 1-80, sample-poster.tex 1-200, sample-news.tex 1-80, sample-brochure.tex 1-110, sample-article.tex 1-60, sample-book.tex 1-60, sample-rot.tex, sampleRL.tex, sample-blanks.tex; zip-local classes and styles: partly (no .cls or .sty file is present; `flowfram.sty` and `flowframtkutils.sty` exist only inside flowfram.dtx, of which I read lines 1-300 and a grep outline of the 42952 lines, not the package code body, which is the published package)

## Verdict
no. The main sample is the author's user manual for the package, not a template class. It needs the author's own `nlctuserguide.sty` (not in the zip, and ctan.org/pkg/nlctuserguide returned 404), bib2gls glossary data, and shell escape plus arara to build its examples on the fly. The manual's page look (landscape `scrbook`, flowfram flow/static/dynamic frames, thumbtabs, header and footer frames) would reduce to existing ways plus one proposed way `page.flowfram`, and `flowfram.sty` is a published package, so the package is not what blocks. The manual's tooling is. Read alone, most of `samples/*.tex` would fit `page.flowfram` plus published classes, except `samples/sample3.tex` and example 5, which draw TikZ borders and rules (ART).

## Blockers
- `EXTERNAL/preamble` shell escape and an arara-driven example build: `\directlua{os.execute("mkdir -p \jobname-examples")}` (flowfram-manual.tex:10), `% arara: lualatex: { shell: yes }` (:3), examples written and compiled through `arara={pdflatex}` keys (:4691, :8392, :8956) into flowfram-manual-examples/
- `EXTERNAL/package` bib2gls (a Java program, glossary pass) required by `nlctuserguide`/`glossaries-extra`: `% arara: bib2gls` (:2, :4), "requires glossaries-extra v1.49, bib2gls v3.0 and nlctuserguide.sty" (:14); entries are written with `\glsbibwriteentry` (:95-106) and printed at :10617-10636 (bib2gls is a TeX Live helper like biber, which the lib accepts as `bib.biblatex-biber`, so the verdict does not rest on this line alone)
- `BESPOKE/preamble` `nlctuserguide.sty`, loaded at flowfram-manual.tex:31-40, is not in the zip and not on CTAN, so W1 fails and no reduction can be written; it supplies `codebox` and `coderesult` (:4548, :6484), `information`/`important`/`warning` boxes (:4543, :4601, :7082), `\createresultexampleindynamicframe*` (:4690, :4910, :6350, :8390, :8955), `\defsemanticcmd` (:44-48), `\listofexamples` (:4568), `\sectionref`/`\figureref`/`\exampleref`
- `BESPOKE/preamble` the `\nlctuserguidegls{...}` data block (flowfram-manual.tex:93-4390, about 4300 lines of `\gctr` `\gcmd` `\gopt` `\gstyopt` entries via local `\def\gframeopt` ... at :95-106), documentation data defined through that same absent style
- `ART/body` (secondary samples only, not the main sample): TikZ `bumps` border `\fancyframe` (samples/sample3.tex:25-34, used at :38); TikZ zigzag `\ffvrule` and `\ffhrule` (flowfram-manual-examples/flowfram-manual-example005.tex:15-33, shown in the manual at flowfram-manual.tex:8955)

## Class setting
- Class: `class.scrbook` options: `fontsize=12pt` (flowfram-manual.tex:17); paper size and margins come from `geometry` (:19), not from class options
- Class-native vocabulary used: `\frontmatter` (:4563), `\mainmatter` (:4570), `\backmatter` (:10634), `\appendix` (:10611), `\chapter` (:4572), `\addtokomafont{chapter}{\color{blue}}` (:4451), `\renewcommand\chapterheadstartvskip{}` (:4452), `\tableofcontents` (:4567), `\title` `\author` `\date` `\maketitle` (:4521-4535). The secondary samples also use `book` (samples/sample.tex:5), `report` (samples/sample-brochure.tex:5), `article` (samples/sample-news.tex:3) and `a0poster` (samples/sample-poster.tex:3).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | flowfram-manual.tex:17 | `class.scrbook` | fontsize=12pt |
| page geometry | flowfram-manual.tex:19 | `page.geometry` | a4paper, landscape, margin=1in, top=1in, bottom=1in |
| margin-note width | flowfram-manual.tex:4414 | `page.setlength` | `\marginparwidth`=2cm |
| colour | flowfram-manual.tex:20 | `color.xcolor` | package defaults; frame colours (`magenta`, `[cmyk]{0,0.48,0,0}`, `[rgb]{0.15,0.15,1}`) are flowfram values, :4405, :4480 |
| micro-typography | flowfram-manual.tex:21 | `sp.microtype` | defaults |
| fonts | flowfram-manual.tex:22 | `font.fontspec` | package load only; no `\setmainfont` in this file (`nlctuserguide` may set faces; unread) |
| graphics | flowfram-manual.tex:24 | `fig.graphicx` | package load; `\includegraphics[width=\linewidth]{example-image-a}` appears only inside example text (:4872) |
| frame-based page layout | flowfram-manual.tex:25-27, :4419-4439 | `page.flowfram` | `pages=absolute`; `\newflowframe{0.6\textwidth}{\textheight}{0pt}{0pt}[main]`, `\newdynamicframe{0.38\textwidth}{\textheight}{0.62\textwidth}{0pt}[chaphead]`, `\twocolumninarea[none]{0.6\textwidth}{\textheight}{0pt}{0pt}[left,right]`, `\setflowframe*{main}{evenx=0.4\typeblockwidth}`, `margin=inner`; static frames :4429-4433; `flowframtkutils` (same bundle) loaded at :29 |
| backdrop stripes | flowfram-manual.tex:4405-4411 | `page.flowfram` | `\vtwotone[1]{\leftwidth}{magenta}{backleft}{\rightwidth}{[cmyk]{0,0.48,0,0}}{backright}`, `\vtwotonetop[odd]{1cm}...`; widths from `\computeleftedgeodd` (:4398) |
| header and footer | flowfram-manual.tex:4499-4519 | `page.flowfram`, `hf.pagestyle-kernel` | `\makedfheaderfooter`; `\pagestyle{ffheadings}` (:4503); footer dynamic frame `oddx=\xoffset,y=\yoffset,width=2cm,height=2cm,backcolor=blue,textcolor=white,style=footstyle,pages=none` (:4513-4514) |
| thumbtabs and mini-tocs | flowfram-manual.tex:4466-4496 | `page.flowfram` | `\flowframsetup{dynamic-empty-page-style=hide,toc-thumbtabs,thumbtabs=number,thumbtab-text=normal}`, `\makethumbtabs{0.6in}`, `\enableminitoc`, `\setthumbtab{1}{backcolor=[rgb]{0.15,0.15,1}}` to 9, `\setthumbtab{all}{valign=c,style=thumbtabstyle,textcolor=white}` |
| chapter heading | flowfram-manual.tex:4449-4455 | `page.flowfram`, `head.koma-fonts` | `\ChapterInDynamic*{chaphead}`, `\appenddfminitoc*{chaphead}`; `\addtokomafont{chapter}{\color{blue}}`; `\renewcommand\chapterheadstartvskip{}` |
| sections below chapter | flowfram-manual.tex:5034, :5649 | `head.class-native` | `scrbook` defaults |
| title block | flowfram-manual.tex:4521-4535 | `front.maketitle` | `\title`, `\author` with `\href{...}{\nolinkurl{...}}` (:4525), `\date{2026-06-19}`; frames swapped around the title page with `\ffswapoddeven*{main}` and `\dfswapoddeven*{chaphead}` (:4531-4539) |
| page numbering | flowfram-manual.tex:4534 | `pgnum.pagenumbering` | `alph` for the title page |
| contents | flowfram-manual.tex:4567-4568 | `toc.kernel` | `\tableofcontents`; `\listofexamples` is an `nlctuserguide` command (unreadable) |
| links | flowfram-manual.tex:4525 | `meta.hyperref` | `\href` is used; hyperref is not loaded in this file (via `nlctuserguide`, unread); samples/sample.tex:11-13 loads `hidelinks,plainpages=false,pdfpagelabels=true` |
| cross-references | flowfram-manual.tex:4572 | `xref.kernel` | `\label{sec:intro}`; `\sectionref` `\figureref` `\exampleref` are `nlctuserguide` commands |
| fixed-place figure | flowfram-manual.tex:4775-4779 | `page.flowfram`, `cap.kernel` | `staticfigure` environment with `\caption{Frame Layers}\label{fig:framelayers}` |
| shaped frame text | flowfram-manual.tex:7700-7790 | `sp.lengths`, `sp.shapepar` | frame key `shape={\parshape=20 ...}` (kernel `\parshape`) or `\shapepar`/`\Shapepar`; `shapepar` loaded at :28 |
| code and info boxes | flowfram-manual.tex:42, :4548, :4662 | `box.tcolorbox` | `\tcbuselibrary{hooks}`; the `codebox`, `coderesult`, `information`, `important`, `warning` environments come from `nlctuserguide` (unread) |
| glossary and index | flowfram-manual.tex:10612-10636 | `idx.glossaries` | `\setupglossaries`, `\printmain`, `\printicons`, `\printcmdenvsummary`, `\printclsstysummary`, `\printuserguideindex` (EXTERNAL: bib2gls) |
| other samples: classes | samples/sample.tex:5; samples/sample-brochure.tex:5; samples/sample-news.tex:3; samples/sample-poster.tex:3 | `class.book`, `class.report`, `class.article`, `class.a0poster` | `a4paper,twoside`; `a4paper`; none; `a0` |
| other samples: fonts | samples/sample.tex:7-9; samples/sample-brochure.tex:13; samples/sample-poster.tex:6-8 | `font.mathptmx`, `font.mono`, `font.helvet`, `font.family-default` | `times`, `courier`, `helvet`; `\familydefault`=`cmss`; `mathptmx`, `courier`, `helvet` scaled=0.92 |
| other samples: frame layouts | samples/sample-poster.tex:18-37; samples/sample-news.tex:11-60; samples/sample-pages.tex:17-64; samples/sample-rot.tex:14-15 | `page.flowfram` | `\NcolumnStop{4}{0.2\textheight}`, `\insertvrule`, `\inserthrule`, `\setallflowframes{backcolor=[cmyk]{...}}`; `\flowswitchoffnext*` and `\ffprechapterhook`; `angle=45` and `angle=90` on flow frames |
| other samples: long table | samples/sample-rot.tex:6, :26-47 | `tbl.longtable` | `supertabular` in a rotated frame |
| other samples: TikZ border and rules | samples/sample3.tex:25-34; flowfram-manual-examples/flowfram-manual-example005.tex:15-33 | `art.tikz` (ART) | `bumps` and `zigzag` decorations as a frame border and as column rules |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `flowfram.sty`, `flowframtkutils.sty` (generated from the dtx; expl3; replaces the kernel `\@outputpage`) | flowfram.dtx:197, :20073, :10143-10144 | published, so not bespoke | it is the proposed way `page.flowfram`; its implementation is the package, not zip macro logic |
| `nlctuserguide.sty` (absent) | flowfram-manual.tex:31-40 | No | source not available, not on CTAN; supplies the boxes, example builder and glossary markup |
| `\defsemanticcmd`, `\glsxtrnewgls` and the `\frameoptval`... `\newcommand` wrappers | flowfram-manual.tex:44-91 | No (depends on the absent style) | documentation markup (`\textsf` fonts, glossary links) |
| `\nlctuserguidegls{...}` data block | flowfram-manual.tex:93-4390 | No | glossary data for bib2gls (EXTERNAL) |
| frame set-up lengths `\leftwidth`, `\rightwidth`, `\xoffset`, `\yoffset` | flowfram-manual.tex:4395-4402, :4505-4509 | Yes | numeric values fed to `page.flowfram` lengths (`\computeleftedgeodd`, `\computerightedgeodd`, `\computebottomedge` are flowfram's own commands) |
| `\IfTeXParserLib{...}{...}` | flowfram-manual.tex:4441-4463 | Yes | keep the second (PDF) branch: `\ChapterInDynamic*`, `\appenddfminitoc*`, `\chapdesc` |
| `\chapdesc` | flowfram-manual.tex:4457-4459 | Yes | `\appenddynamiccontents*{chaphead}{\par \normalfont\emph{#1}}` (flowfram call plus `mark.kernel`) |
| `\thumbtabstyle`, `\footstyle` | flowfram-manual.tex:4491-4494, :4511 | Yes | font and alignment switches (`\centering\bfseries\large\sffamily`; `\bfseries\LARGE`) passed as the frame `style` key |
| `\directlua` / arara lines | flowfram-manual.tex:1-10 | No | external driver and shell command (EXTERNAL) |
| `\fancyframe` TikZ border | samples/sample3.tex:25-34 | No | ART |
| `\ffvrule`, `\ffhrule` redefinitions | flowfram-manual-examples/flowfram-manual-example005.tex:15-33 | No | ART |
| `\newcommand{\sty}`, `\env`, `\cmdname`, `\meta` aliases | samples/sample.tex:19-22 | Yes | inline `\textsf`, `\texttt`, `\textit` |
| `\DFchapterstyle` redefinition | samples/sample-brochure.tex:32-34 | Yes | flowfram hook set to `\raggedright\Huge\slshape\MakeUppercase{#1}\par` |

## Content-opaque
- FlowframTk-exported `pgfpicture` figures included in `staticfigure`: images/flowframe-layers1.tex (397 lines) and images/flowframe-layers2.tex (212 lines) via `\includeteximage` (flowfram-manual.tex:4776-4777).
- samples/sample-news.tex:81 and :115 include `egg` and `sheep` with no extension (PNG and EPS twins ship in samples/); samples/sample-article.tex:237 and :243 include `example-image` (an `mwe` image, not shipped).

## Lib changes
- New ways proposed: `page.flowfram` `flowfram` (CTAN and TeX Live, LPPL 1.3; Nicola Talbot), pdf engine: frame-based page layout. Flow, static and dynamic frames of any size and position take the document text, fixed text, and per-page text; `\newflowframe[pages]{w}{h}{x}{y}[label]`, `\newstaticframe`, `\newdynamicframe`, column helpers (`\twocolumninarea`, `\NcolumnStop`), `\setflowframe*{label}{key=value}` (keys `pages` `margin` `evenx` `border` `backcolor` `textcolor` `style` `valign` `shape` `angle` `clear` `hide`), package options (`draft`, `pages=absolute`, `LR`, `RL`), `\flowframsetup{...}`, `\makedfheaderfooter`, `\makethumbtabs`, backdrop stripes `\vtwotone`, rules `\insertvrule`, body wrappers `staticcontents*`, `\setdynamiccontents*`, `staticfigure`, `\framebreak`. W1: published on CTAN and in TeX Live. W2: frames are set by lengths, page lists, booleans, colours and key lists. W3: it serves posters, brochures, magazines and any non-column layout, not one document. W4: an emitter prints the frame declarations in the preamble and wraps node content in the contents environments. Not `pg.textpos` (absolute text boxes with no flow between them), not `cols.multicol`/`cols.paracol` (equal columns), not `poster.tikzposter`/`poster.baposter` (block themes). Caveat: the package replaces the output routine, and its manual warns of conflicts with packages that also touch it (`flowfram-manual.tex:4602-4610`), so other ways must be checked against it.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
