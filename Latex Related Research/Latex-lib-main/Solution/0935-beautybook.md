yes

# 0935-beautybook: beautybook (decorative maths/science book)

- Unverified: read from the source, not compiled.
- Source: Source/0935-beautybook/ (origin: https://latextemplates.com/downloads/beautybook.zip; licence: LPPL-1.3c, README.md:26)
- Kind: book
- Lib: v6
- Engine: pdfLaTeX-compatible (`lang=en` loads kernel `book`, beautybook.cls:8,35; `lang=cn` would load `ctexbook` and need XeLaTeX, not used by the sample)
- Look carried by: class (the CTAN `beautybook` class and its `stys/beautybook-cover-en.sty` draw cover, headings, margins and contents; main.tex only adds option values, colours, five theorem declarations and published packages)
- Class origin: ctan
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (beautybook.cls 1215 lines, stys/beautybook-cover-en.sty 149 lines; `stys/beautybook-bottompage.sty` is required at beautybook.cls:114 but is not in the zip, so it is unread)

## Verdict
`yes`, on the class ruling: ctan.org/pkg/beautybook lists the class (Shilong Lu, LPPL 1.3c, version 2024-07-03; README.md:9,31-32 and beautybook.cls:2 agree), so `class.beautybook` is a published class way and the sample adds only option values, colours, class-native commands, `\newtheorem*` and published packages. The class's own TikZ cover, headings, margin bars and ornament boxes are inside that published class: they are listed under Bespoke code as "not counted", and if the class were zip-local they would be `ART/class` and `BESPOKE/class` blockers and the answer would be `no`. Caveats: the zip's copy was not compared with the CTAN release, and `stys/beautybook-bottompage.sty` (loaded unconditionally) is missing from the zip, assumed to belong to the CTAN bundle.

## Blockers
none

## Class setting
- Class: `class.beautybook` options: `lang=en` (a key, beautybook.cls:6-10), `12pt` (not a key: collected by `\beautybook@unknown` and passed to the loaded `book`, beautybook.cls:11-31). Underlying class `class.book` (beautybook.cls:8,35).
- Class-native vocabulary used: `\coverstyle={cover-choose=en,}`, `\mathstyle={math-font=plain,}`, `\mynewtheorem{env={name}[within]{tcolorbox keys}}`, `\subtitle` `\edition` `\bookseries` `\pressname` `\presslogo` `\makecover`, `\oddoutermargin` `\evenoutermargin` `\chapimage`, `\partabstract` with `\part`, `\chapter` `\chapter*` `\section`, the redefined `proof` environment, and the colour names `coverfgcolor` `coverbar` `nuanbai` `outermarginfgcolor` `outermarginbgcolor` (main.tex:20-30,32-38,43-60,87-90).

## Component map
Rows marked (class) are set inside the published class, not by the sample; they are listed because the lib sections are the checklist.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:13; beautybook.cls:30-35 | `class.beautybook` | `lang=en,12pt`; loads `book` |
| underlying class | beautybook.cls:8,35; main.tex:65,84 | `class.book` | `\frontmatter`, `\mainmatter`, `\chapter`, `\part` |
| paper and size | main.tex:13 | `page.class-options` | `12pt` only, no paper option; the A4 test at beautybook.cls:44-49 only picks a cover macro and both cover macros are identical (stys/beautybook-cover-en.sty:141-145) |
| page geometry (class) | beautybook.cls:129 | `page.geometry` | left=2cm,right=2cm,top=.6cm,bottom=2.2cm |
| header/footer (class) | beautybook.cls:187,585-587,654-665,769-779 | `hf.scrlayer-scrpage` | `automark`; page style `scth` built from layers and added to `scrheadings` and `plain.scrheadings`; `\headheight`=40pt; `\clearpairofpagestyles`; `\KOMAoptions{markcase=upper}`; `\outermarginwidth`=1.5cm (beautybook.cls:173-174) |
| margin text | main.tex:57-58; beautybook.cls:635-651 | `hf.class-native` | odd margin `\sffamily \leftmark`, even margin `\sffamily\@title`; margin colours `outermarginbgcolor`=#e0e0e0, `outermarginfgcolor`=#2c4f54 (main.tex:53-56) |
| page style per page | main.tex:42,68,81; beautybook.cls:493-494 | `hf.pagestyle-kernel` | `\thispagestyle{empty}`; class `\assignpagestyle{\part}{empty}` and `{\chapter}{empty}` |
| page numbering | main.tex:66,85 | `pgnum.pagenumbering` | `Roman` in front matter, `arabic` in main matter |
| text face | main.tex:15 | `font.mathptmx` | `times` |
| encodings | main.tex:14,16 | `font.fontenc-t1` | `utf8` inputenc, `T1` fontenc |
| microtype | main.tex:17 | `sp.microtype` | defaults |
| colours | main.tex:20-24,53-56,62-63; beautybook.cls:58,63-64,1066-1070 | `color.xcolor` | HTML colours `coverbgcolor` e0e0e0, `coverfgcolor` 1f3134, `coverbar` 7c9092, `bottomcolor` 2c4f54, `nuanbai` f5f5f5, `bg` e0e0e0, `fg` 2c4f54; class loads `xcolor` with `dvipsnames,svgnames,x11names,table` and defines `CyaN` `OrangE` `BluE` `ReD` `GreeN` |
| cover and title block | main.tex:25-27,43-50; stys/beautybook-cover-en.sty:141-145 | `front.class-native` | `cover-choose=en`; title "An Introduction to Graph Colouring", subtitle, edition, empty `\bookseries{}`, author, `\pressname{beautybook}`, `\presslogo{inner_pics/beautybook-mark.png}`, one `\makecover` call; the cover page itself is drawn by the class's cover style (class) |
| math font switch | main.tex:28-30; beautybook.cls:93-97 | `math.amssymb` | `math-font=plain` requires `amssymb`, `amsfonts`, `upgreek` |
| preface page | main.tex:68-79 | `front.dedication` | closest line: an unnumbered `\chapter*{Preface}` with text, run under `\thispagestyle{empty}` and closed by `\clearpage` |
| signature block | main.tex:74-78 | `tbl.tabular` | `tabular{lr}`, two rows; preceded by `\hfill` (`sp.manual-space`) |
| page breaks | main.tex:79,82 | `pg.break` | `\clearpage`; `\let\cleardoublepage\clearpage` after the contents |
| table of contents | main.tex:82 | `toc.kernel` | `\tableofcontents` |
| contents entry look (class) | beautybook.cls:189,195-244 | `toc.titletoc` | `\titlecontents` for chapter (tcolorbox side-by-side boxes `\boxednum` `\boxednonum`, `box.tcolorbox`), section, subsection, subsubsection with dot leaders |
| depth counters (class) | beautybook.cls:192-193 | `num.secnumdepth` | `tocdepth`=3, `secnumdepth`=3 |
| part heading | main.tex:87-90; beautybook.cls:391-395 | `head.class-native` | `\partabstract{...}` then `\part{Foundations}`; page layout, `\titleformat{\part}` (class) |
| chapter heading | main.tex:69,92,141; beautybook.cls:291-373 | `head.class-native` | `\chapter`, `\chapter*`; `\chapimage{inner_pics/beautybook-mark.png}` (main.tex:59); `\titlespacing{\chapter}{0pt}{0pt}{70pt}` |
| section heading | main.tex:95; beautybook.cls:498-524 | `head.class-native` | `\section`; `\titleformat{\section}` with `\mysectionformat`; `\titlespacing*{\section}{0pt}{3.5ex plus 1ex minus .2ex}{2.3ex plus .2ex}`; `\subsection` is defined (beautybook.cls:569-575) but the sample does not use it |
| headings package (class) | beautybook.cls:188 | `head.titlesec` | `\RequirePackage[explicit]{titlesec}` |
| theorem declarations | main.tex:32-38; beautybook.cls:1075-1083 | `thm.amsthm` | `\newtheorem` for `defi` Definition, `thm` Theorem, `lem` Lemma, `prop` Proposition (each `[section]`) and `exam` Example (`[chapter]`), names `\textbf{...}`, default `plain` style, one counter each |
| theorem boxes | main.tex:33-37; beautybook.cls:1071-1073,1080 | `box.tcolorbox` | `\tcolorboxenvironment` with `enhanced jigsaw, breakable, enlarge left by=-3.5mm, width=\textwidth+3.5mm, boxrule=0pt, top=2pt, bottom=2pt, left=2.5mm, frame hidden` plus per environment `interior style={left color=..,right color=..}` and `borderline west={1.5mm}{0mm}{colour}` with `ReD`, `CyaN`, `BluE`, `OrangE`, `DarkGreen` |
| remark | main.tex:39 | `thm.amsthm` | `\newtheorem*{remark}{\textbf{Remark}}` |
| proof | main.tex:115-120; beautybook.cls:1199-1211 | `thm.thmtools` | `\declaretheoremstyle[spaceabove=3pt,spacebelow=3pt,headfont=\normalfont\bfseries,notefont=\normalfont\bfseries,notebraces={(}{)},bodyfont=\normalfont,postheadspace=.5em,headpunct={.},qed=\color{cyan!40!black}$\blacksquare$]{Proofstyle}`; `\declaretheorem[style=Proofstyle,numbered=no,name={\itbf{Proof}}]{Proof}`; `\renewenvironment{proof}{\begin{Proof} }{\end{Proof}}`; the same style gives a `solution` environment (beautybook.cls:1212) |
| display and inline maths | main.tex:99-100,112 | `math.amsmath` | inline maths with `\colon`, `\dots`, `\leq`, `\neq`; class loads `amsmath,amsthm,mathrsfs,extarrows,bropd` (beautybook.cls:127); `mathrsfs` is `math.bm`, `upgreek` (beautybook.cls:96) is `math.bm` |
| emphasis | main.tex:99,106 | `mark.kernel` | `\emph`, `\textbf` |
| cross-references | main.tex:93,98,124,136,149 | `xref.kernel` | `\label` and `\ref` with `Theorem~\ref{..}` |
| link look (class) | beautybook.cls:141 | `meta.hyperref` | `colorlinks`, `linkcolor`/`anchorcolor`/`urlcolor`/`citecolor` = purple |
| citations | main.tex:18,151-152 | `bib.natbib` | `[round]`, `\citet` |
| bibliography | main.tex:154-155 | `bib.bibtex-bst` | `plainnat`, database `references.bib` |
| loaded by the class, not used by the sample | beautybook.cls:121-134,140,528 | `list.enumitem` `cap.caption` `fig.graphicx` `tbl.nicematrix` `mark.ulem` `num.appendix` `idx.makeidx` `sp.indentfirst` `font.exscale` `box.minipage` `font.icons` | `\setlist{font=\upshape}`; `caption` with `\colorlet{captioncolor}{outermarginfgcolor}`; `\graphicspath{{inner_pics/}...}` and `\DeclareGraphicsExtensions{.pdf,.eps,.jpg,.png}`; `tabularray`; `ulem[normalem]`; `appendix`; `imakeidx`; `indentfirst`; `anyfontsize`; `varwidth`; `pifont` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\let\cleardoublepage\clearpage` | main.tex:82 | yes | an alias between two `pg.break` commands; emitted as one body line (every later `\chapter`/`\part` then uses `\clearpage`) |
| `\@title` inside `\evenoutermargin` between `\makeatletter` and `\makeatother` | main.tex:52-60 | yes | the kernel title macro as margin text of `hf.class-native`; or print the title string itself |
| `\mynewtheorem{...}` call (class-native, expl3 `\keyval_parse`) | main.tex:32-38; beautybook.cls:1075-1083,1112-1113 | yes | per entry: `\newtheorem{env}{name}[within]` (`thm.amsthm`) + `\tcbset{my@env@thmstyle/.style={keys}}` + `\tcolorboxenvironment{env}{base keys, style}` (`box.tcolorbox`) |
| `\coverstyle={..}` and `\mathstyle={..}` calls (class-native expl3 keys) | main.tex:25-30; beautybook.cls:72-112 | yes | option values: load the `en` cover style; load `amssymb,amsfonts,upgreek` |
| Not counted (published CTAN class): chapter, numberless chapter, part, section and subsection headings drawn with TikZ overlays, fades and `sixpointed stars` patterns | beautybook.cls:291-372,393-491,498-575 | n/a | would be `ART/class` if the class were zip-local |
| Not counted: cover page of full-page TikZ shapes, fades and triangle loops (`\aivcover`, `\lettercover`, identical) | stys/beautybook-cover-en.sty:23-139 | n/a | would be `ART/class` if zip-local |
| Not counted: margin bars, checkerboard pattern, page-number tabs and chapter-number box as scrlayer layers with TikZ contents | beautybook.cls:595-780 | n/a | would be `ART/class` if zip-local |
| Not counted, unused by the sample: `ys style` ornamental `fancybox` (tcolorbox `interior code` with stars and corner ornaments) and theorem `overlay` macros used only by `\mynewtcbtheorem` | beautybook.cls:787-1058,1087-1195 | n/a | would be `ART/class` if zip-local |
| Not counted, expl3 helpers: A4 test `\ifaivpaper@TF`, `\titleimage` image-list lookup by page parity and counter (never called by the class headings or the sample), `\xapptocmd` patches of `\chaptermark` and `\sectionmark` with `\marks` | beautybook.cls:44-49,255-288,590-593 | n/a | would be `BESPOKE/class` if zip-local |
| Missing file `stys/beautybook-bottompage.sty` (back cover), required unconditionally | beautybook.cls:114 | not shown | not in the zip, unread; the sample calls no back-cover command |

## Content-opaque
none (`inner_pics/beautybook-mark.png` is a shipped asset passed to `\presslogo` and `\chapimage`, main.tex:49,59; it is not figure content)

## Lib changes
- New ways proposed: none. `class.beautybook` is written plainly as a class way (CTAN, ctan.org/pkg/beautybook read: LPPL 1.3c, 2024-07-03).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
