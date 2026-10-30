yes

# 0371-ppt-slides: ppt-slides (slide decks a la PowerPoint, package with template and schemes)

- Unverified: read from the source, not compiled.
- Source: Source/0371-ppt-slides/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ppt-slides.zip; licence: MIT, LICENSE.txt:1)
- Kind: presentation
- Lib: v4
- Engine: pdfLaTeX-compatible (no fontspec, unicode-math or Lua in the package or template; `lastpage` and `remember picture` need two runs: ppt-templates/ppt-9x6.tex:14, ppt-slides.dtx:774)
- Look carried by: class (not a class but one published CTAN package, `ppt-slides`, with its shipped template and four colour schemes, loaded under kernel `article`; the samples add only options and content)
- Class origin: ctan (the carrying package is on CTAN; the document class the samples name is kernel `article`, ships with the TeX distribution)
- Main file: none (no `.tex` holds both `\documentclass` and a body; the samples are README.md:19-28 and the docshot examples in ppt-slides.dtx:73-98, 195-273, 310-322; other samples: the `verbatim` examples, e.g. ppt-slides.dtx:108-121, 136-138, 148-160, 174-183, 333-339)
- Read: main yes (no `.tex` main exists; README.md and the whole of ppt-slides.dtx read), zip-local classes and styles all (no `.cls` or `.sty` is shipped: ppt-slides.dtx code lines 425-896, ppt-templates/ppt-9x6.tex, four `ppt-schemes/*.tex`, ppt-slides.ins read; `ppt-slides.pdf` and `socrates.jpg` not read)

## Verdict
The look is carried entirely by one published package, `ppt-slides` (CTAN, MIT), which `\input`s a shipped template (`ppt-9x6`) and a colour scheme. The zip adds no local macro for an emitter to copy: it writes `\usepackage[template,scheme=dark]{ppt-slides}` and the body commands `\pptBanner`, `\pptChapter` and the rest, plus `clicks` steps. I propose two doc-kind ways, `slide.ppt-slides` and `slide.clicks`, as the lib already holds one way per published doc-kind package (`songbook.songs`, `recipe.xcookybooky`, `cal.kalender`). The `yes` rests on accepting that: if a reviewer holds that a published package's own code must be rebuilt by composition, the answer flips to `no` (BESPOKE counters and conditionals in ppt-templates/ppt-9x6.tex:16-91 and ppt-slides.dtx:683-716, and TikZ decoration in ppt-slides.dtx:692-703, 774-791, 802-809), see the Bespoke code table. One open item: the manual build loads `docshots`, whose shell-escape need the CTAN page does not state; the manual is not the template, so I did not count it.

## Blockers
none

## Class setting
- Class: `class.article` options: none (the template sets the text size itself with `fontsize=24pt`, ppt-templates/ppt-9x6.tex:11; without the `template` option the package renders plain `article`, ppt-slides.dtx:343-346)
- Class-native vocabulary used: only `document`; no `\maketitle`, `abstract` or `\section` of `article` (`\section` is taken over by `crumbs`, ppt-slides.dtx:610-613; the title slide is `\pptTitle`)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | README.md:19; ppt-slides.dtx:74 | `class.article` | no options |
| package and options | README.md:21; ppt-slides.dtx:75, 427-438 | `slide.ppt-slides` | `\usepackage[template,scheme=dark]{ppt-slides}`; `template` (default `9x6`, the only one shipped, ppt-slides.dtx:343-346), `scheme` (`light` default, `dark`, `light-mono`, `dark-mono`, or a file path: ppt-slides.dtx:360-369, 478-489), `directory` (ppt-slides.dtx:374-385), booleans `nominutes` (ppt-slides.dtx:387-399) and `nocrumbs` (ppt-slides.dtx:401-412) |
| page size and margins | ppt-templates/ppt-9x6.tex:4-5 | `slide.ppt-slides` | `template=9x6`: paperwidth 16in, paperheight 9in, left 4in, right 2in, top 1.5in, bottom 1.5in |
| positioning grid | ppt-templates/ppt-9x6.tex:6-7 | `slide.ppt-slides` | `template=9x6`: 16 by 16 absolute grid (`textpos`), used by head, foot and `\pptPunch` |
| base size and line shape | ppt-templates/ppt-9x6.tex:10-11, 94-109 | `slide.ppt-slides` | `template=9x6`: 24pt text, `\raggedright`, `\raggedbottom`, `\topskip` 0pt, `\footskip` 32pt, `\parindent` 0pt, `\parskip` 18pt, `\columnsep` 32pt, `\headheight` 32pt (6pt with `nocrumbs`) |
| colour scheme and page colour | ppt-schemes/ppt-light.tex:4-13; ppt-schemes/ppt-dark.tex:4-13; ppt-slides.dtx:478-489 | `slide.ppt-slides` | `scheme=light\|dark\|light-mono\|dark-mono`: seven named colours (white, red, orange, black, grey, green, blue) as HTML values, text colour, page colour; the mono schemes use only black and white (ppt-schemes/ppt-dark-mono.tex:4-13, ppt-schemes/ppt-light-mono.tex:4-13) |
| top-left navigation (crumbs) | ppt-templates/ppt-9x6.tex:16-32, 39-51; ppt-slides.dtx:460, 550 | `slide.ppt-slides` | option `nocrumbs`; chapter crumbs `\small\ttfamily`, current chapter blue and underlined, section crumbs grey `\scriptsize` in brackets; fed by `\pptChapter` and `\pptSection` (ppt-slides.dtx:629, 643) |
| page number and minute tracker | ppt-templates/ppt-9x6.tex:14, 52-70 | `slide.ppt-slides` | top right `n/LastPage`, hidden on page 1; with `clicks` in non-static mode a circled minute counter (ppt-templates/ppt-9x6.tex:57-66) unless `nominutes` |
| foot, left and right | ppt-templates/ppt-9x6.tex:73-91; ppt-slides.dtx:167-188 | `slide.ppt-slides` | preamble `\pptLeft{title}` `\pptRight{author}`; grey `\scriptsize\ttfamily`, hidden on page 1; nothing printed when unused |
| title slide | ppt-slides.dtx:77-79, 666-672 | `slide.ppt-slides` | `\pptTitle{title}{subtitle}` inside `pptMiddle`; subtitle omitted when empty |
| banner heading | ppt-slides.dtx:91, 230-236, 599-604 | `slide.ppt-slides` | `\pptBanner[colour]{text}`; colour default `green`; text in the page colour |
| chapter slide | ppt-slides.dtx:114-118, 137, 627-635 | `slide.ppt-slides` | `\pptChapter[short name]{title}`, `\renewcommand\pptChapterLabel{Part}` (default `Chapter`); blue `\LARGE` banner turned 1 degree |
| section header | ppt-slides.dtx:152-154, 211, 642-656 | `slide.ppt-slides` | `\pptSection[short name]{title}`, `\pptHeader{text}`; orange `\Large` banner turned 1 degree |
| table of contents | ppt-slides.dtx:113, 125-128, 683-716 | `slide.ppt-slides` | `\pptToc[Agenda]`; label-less list of chapter names beside a 4pt blue bar |
| image | ppt-slides.dtx:199, 758-766 | `slide.ppt-slides` | `\pptPic{0.2}{socrates.jpg}`: width as a fraction of `\columnwidth`, 1pt grey frame |
| quotation with photo | ppt-slides.dtx:231-232, 725-750 | `slide.ppt-slides` | `\pptQuote[person]{image}{quote}{author}`: photo in a quarter-width cell, quotation in `\enquote` |
| thought block | ppt-slides.dtx:244-246, 800-811 | `slide.ppt-slides` | `\pptThought{text}`: centred, `\Large`, 0.8\textwidth, 8pt green bar on the left |
| vertical centring | ppt-slides.dtx:256-259, 590-592 | `slide.ppt-slides` | environment `pptMiddle` |
| centred block | ppt-slides.dtx:816-831 | `slide.ppt-slides` | `\pptPunch{text}`: centre of the grid; needs `template`; no sample uses it |
| QR code | ppt-slides.dtx:271-276, 850-858 | `slide.ppt-slides` | `\pptQR[2in]{url}` (linked) |
| pinned corner block | ppt-slides.dtx:288-289, 773-792, 865-876 | `slide.ppt-slides` | `\pptPin[right\|left]{text}`, `\pptPinQR[left]{url}` |
| verbatim snippet | ppt-slides.dtx:302, 839-843 | `slide.ppt-slides` | `\pptSnippet[\footnotesize]{file}`; default `\small` |
| wide blocks | ppt-slides.dtx:315-324, 884-889 | `slide.ppt-slides` | environments `pptWideOne`, `pptWide{n}`: widened by -2in left and -1in right, `n` columns |
| bibliography heading | ppt-slides.dtx:616-620 | `slide.ppt-slides` | when `biblatex` is loaded by the document, the heading is `\pptBanner`; no sample loads biblatex |
| click steps | README.md:20-28; ppt-slides.dtx:85-98, 705-714 | `slide.clicks` | `\usepackage[static]{clicks}` (README.md uses it without options); body `\plick{...}` and `\plush{...}` |
| line breaks in samples | ppt-slides.dtx:199, 271 | `sp.manual-space` | `\\` after an image and after a line of text |
| manual driver: class and doc commands | ppt-slides.dtx:37, 51-59 | `class.ltxdoc`, `dtx.doc` | `\DocInput`, `\PageIndex`, `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\PrintChanges`, `\PrintIndex`; `\DescribeMacro` and `\DescribeEnv` in the text (documentation, not the template) |
| manual driver: preamble and title | ppt-slides.dtx:38-39, 43-44, 45-46, 48, 50, 64-70 | `font.fontenc-t1`, `font.lmodern`, `sp.microtype`, `fig.graphicx`, `color.xcolor`, `meta.hyperref`, `meta.bookmark`, `front.maketitle`, `front.thanks`, `head.kernel` | `[T1]`, `lmodern`, `microtype` with protrusion off in verbatim, `\PassOptionsToPackage{hyperindex=false}{hyperref}`, `\title`/`\author`/`\date`/`\maketitle`, `\thanks` on the title, `\section` |

## Bespoke code
Everything below sits inside the published package (the proposed way) or its shipped files. Nothing is a zip-local macro that an emitter has to copy; the table shows what would have to be rebuilt if the package were not accepted as a way.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `ppt-slides.sty`, generated from the `.dtx` by DocStrip | ppt-slides.ins:30; ppt-slides.dtx:33-896 | not needed: published | the emitter writes `\usepackage[...]{ppt-slides}` and the body commands; no code is copied |
| option parser: pgfopts keys and an expl3 trailing-slash step | ppt-slides.dtx:425-453 | not needed: plumbing for five options | the options are the way's parameters |
| template page setup: geometry, textpos grid, microtype, anyfontsize, fontsize, length assignments | ppt-templates/ppt-9x6.tex:4-11, 94-109 | yes if taken alone | published packages `geometry`, `textpos`, `microtype`, `fontsize` and raw lengths with the values listed in the component map |
| colour schemes | ppt-schemes/ppt-light.tex:4-13 and the three siblings | yes if taken alone | seven `\definecolor`, `\color`, `\pagecolor` |
| crumb and sub-crumb redefinition, header text blocks with `\ifnum\value{page}=1`, `\ifcsname c@minutes\endcsname` | ppt-templates/ppt-9x6.tex:16-91 | no, as a composition (counter-driven conditionals decide what prints) | resolved by the way; BESPOKE/class if the package were refused |
| `\pptToc` collector (`\gappto`, redefined `\crumb`, `\print`/`\flush` hooks) | ppt-slides.dtx:683-716 | no, as a composition | same |
| TikZ decoration: contents bar, thought bar, pinned block overlay, QR frame, minute circle | ppt-slides.dtx:692-703, 802-809, 774-791, 851-857; ppt-templates/ppt-9x6.tex:61-64 | no, as a composition (TikZ drawings of the template's own identity, the lib's restricted art.tikz kind) | resolved by the way; ART/class if the package were refused |
| the other commands (`\pptBanner`, `\pptQuote`, `\pptPic`, `\pptSnippet`, `pptWide`) | ppt-slides.dtx:599-604, 725-766, 839-843, 884-889 | yes if taken alone | `\colorbox`, `tabularx`, `\fcolorbox`/`\includegraphics`, `verbatim`, `changepage`/`multicol` |

## Content-opaque
- `ffcode` code block in the `\pptHeader` example (ppt-slides.dtx:209-216): a soft dependency (DEPENDS.txt:35) that the sample loads itself, not `ppt-slides`; not read; the code text is content and the frame look belongs to `ffcode`.
- `socrates.jpg` (shipped, ppt-slides.dtx:199, 231), QR targets, snippet file names (ppt-slides.dtx:271, 302): content.
- Not mapped, documentation build aids outside the template: `docshots` (ctan.org/pkg/docshots read: renders `.dtx` examples as PDF snapshots; shell-escape need not stated), `fail-fast`, `silence`, `href-ul` (ppt-slides.dtx:40-41, 47, 49; `href-ul` is also loaded by the package at ppt-slides.dtx:501 and not read at ctan.org).

## Lib changes
- New ways proposed:
  - `slide.ppt-slides` (section `slide`, engine pdf): `ppt-slides` (CTAN, MIT, v0.8.2, ppt-slides.dtx:34; in the 0371 manifest as a CTAN zip); `\usepackage[template,scheme=...,directory=...,nominutes,nocrumbs]{ppt-slides}`, preamble `\pptLeft` `\pptRight`, body `\pptTitle` `\pptBanner[colour]` `\pptChapter` `\pptSection` `\pptHeader` `\pptToc` `\pptPic` `\pptQuote` `\pptThought` `\pptPunch` `\pptQR` `\pptPin` `\pptPinQR` `\pptSnippet`, environments `pptMiddle` `pptWide` `pptWideOne`; a PowerPoint-style slide deck on `article`. W1 CTAN package, the author's own release; W2 options are strings and booleans, command arguments are text, colour names, fractions and lengths; W3 serves any slide deck, not one talk; W4 a `\usepackage` line plus body wrappers. Not `slide.beamer-theme` (beamer only), `slide.texpower` (foiltex or seminar overlays).
  - `slide.clicks` (section `slide`, engine pdf, not stated on the CTAN page): `clicks` (CTAN, MIT, v0.4.4, TeX Live and MiKTeX; ctan.org/pkg/clicks read: "simulate animation in your slide deck"); `\usepackage[static]{clicks}` and body `\plick{...}` `\plush{...}` (ppt-slides.dtx:85-98, README.md:20-28); step-by-step reveal under a plain class. W1 CTAN; W2 option `static`, content in braces; W3 any slide deck; W4 load line plus wrappers. Not `slide.beamer-mode` (beamer `\only` `\pause`), `slide.texpower` (needs foiltex, seminar or pdfslide). Commands and engine support come from the sample, not the CTAN page.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
