no

# 0355-sexam: sexam / bacex, Arabic exam styles on the `exam` class (XeLaTeX)

- Unverified: read from the source, not compiled.
- Source: Source/0355-sexam/ (origin: https://mirrors.ctan.org/macros/xetex/latex/sexam.zip; licence: lppl1.3)
- Kind: exam
- Lib: v3
- Engine: needs XeLaTeX (`polyglossia` Arabic, `fontspec` families `Amiri`, `Aljazeera`, `Simplified Arabic`, bacex.sty:22-29; the sample says so at bac_template-DZ.tex:1)
- Look carried by: mixed (the published `exam` class supplies question, points and running-head machinery; bacex.sty sets its hooks and loads packages; the sample preamble adds `\newcommand` aliases for the title block)
- Class origin: tex-distribution-unbundled (`exam` is on CTAN and in TeX Live, not in the zip; its source was not read; the zip itself is CTAN's `sexam` release)
- Main file: bac_template-DZ.tex (other samples: exam_with_sexam_ar-DZ.tex, exam_with_wexam_ar-DZ.tex, sexam_wexam_doc_ar.tex)
- Read: main yes, zip-local classes and styles all (no zip-local class; bacex.sty, sexam.sty, wexam.sty read in full)

## Verdict
No. The question skeleton, points, headers and fonts all map to lib ways (`class.exam`, `exam.questions`, `hf.class-native`, `lang.polyglossia`), but the style file the main sample loads defines two pieces of hand-written typesetting logic: an `\ifcase` table that prints the exercise number as an Arabic ordinal word, and an EAN-13 `\barcode` box-and-glue macro in the running head. Both are irreducible under the rubric (the `\ifcase` table is also copied into sexam.sty and wexam.sty; the barcode is only in bacex.sty). The alternative `wexam` style also draws a TikZ page frame with shadow boxes (ART).

## Blockers
- `BESPOKE/class` `\words`/`\xwords`: `\ifcase` lookup of the question counter into Arabic ordinal words, used by `\renewcommand{\thequestion}{\words{question}}` (bacex.sty:32-46; same code in sexam.sty:30-44 and wexam.sty:64-78)
- `BESPOKE/class` `\barcode`: hand-rolled EAN-13 barcode from `\vrule`, `\oalign`, `\ifcase` and group-swapped macros, printed in the running head by `\chead` (bacex.sty:81-101, 103)
- `ART/class` `wexam.sty` page decoration: `background` package whose contents are a TikZ picture (double rounded frame with blur shadow, three `\shadowbox` nodes holding page X of Y and the last-page messages), loaded by the alternative sample (wexam.sty:32-60; exam_with_wexam_ar-DZ.tex:5); not loaded by the main sample

## Class setting
- Class: `class.exam` options: `12pt` (bac_template-DZ.tex:2; also exam_with_sexam_ar-DZ.tex:4)
- Class-native vocabulary used: `questions`, `\question[pts]` (bac_template-DZ.tex:48,50), `parts`/`\part` (75-76), `subparts`/`\subpart` (85-86); preamble hooks in bacex.sty: `\pointsinmargin` (:55), `\marginpointname` (:57), `\pointformat` (:58), `\marginpointssep` and `\rightpointsmargin` (:59-60), `\thepartno` `\thesubpart` `\partlabel` `\subpartlabel` (:61-64), `\partshook` (:65), `\pointpoints` (:67), `\qformat` (:68), `\runningheadrule` `\firstpageheadrule` `\firstpagefootrule` `\runningfootrule` (:70-72,75-76), `\footer` `\lfoot` `\rfoot` `\chead` (:74,78-79,103), `\numpages` (:74); `\pointsinrightmargin` and `\iflastpage` in the other styles (exam_with_sexam_ar-DZ.tex:47; sexam.sty:74,78)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | bac_template-DZ.tex:2 | `class.exam` | `12pt`; vocabulary as listed above |
| paper and size | bac_template-DZ.tex:2 | `page.class-options` | `12pt` only, no paper-size option |
| page geometry | bacex.sty:5 | `page.geometry` | margin=1.6cm (sexam.sty:4 and wexam.sty:4 use 1.8cm) |
| language | bacex.sty:22,26 | `lang.polyglossia` | `\setdefaultlanguage[calendar=gregorian,,locale=algeria]{arabic}` |
| text direction switch | bacex.sty:103 | `lang.bidi` | `\LR{...}` inside `\chead` (`\RL` in wexam.sty:44,49,57) |
| Arabic font families | bacex.sty:27-29 | `font.fontspec` | `\newfontfamily\arabicfont[Script=Arabic,Scale=1.2]{Simplified Arabic}`, `\arabicfontsf` Scale=1.3 same font, `\arabicfonttt` Scale=0.8; fonts not shipped |
| Latin text and math face | bacex.sty:2 | `font.fourier` | `fouriernc` (read as a member of the Fourier family; not checked on CTAN) |
| Palatino-style math (other styles only) | sexam.sty:21; wexam.sty:23 | `font.palatino` | `mathpple` (CTAN page says obsolete, replaced by `mathpazo`; commented out in bacex.sty:23) |
| math packages | bacex.sty:1; bac_template-DZ.tex:120,177,376,439 | `math.amsmath`, `math.amssymb`, `math.bm`, `math.kernel` | amsmath, amsfonts, amssymb, mathrsfs (`\mathscr` at :376); content: `\dfrac`, `cases`, `\mathbb`, `\mathop\limits`, inline `$...$` |
| colour | bacex.sty:17 | `color.xcolor` | `\definecolor{blue}{rgb}{0.1,0.5,0.4}` (redefines `blue`; xcolor arrives through tikz) |
| symbol glyphs | bacex.sty:19-21; exam_with_sexam_ar-DZ.tex:11 | `font.icons` | `yagusylo`, `wasysym`, `pifont`; one call `\yagding[ifsymclock]{151}` in an alias of the other sample |
| line spacing | bacex.sty:49,53 | `sp.setspace`, `sp.linespread` | `\singlespacing`; `\renewcommand{\baselinestretch}{1.3}` |
| paragraph indent | bacex.sty:50 | `sp.lengths` | `\parindent 0ex` |
| head separation | bacex.sty:66 | `sp.lengths` | `\headsep` 8pt (1pt in sexam.sty:61; `\baselineskip=0.9cm` in sexam.sty:62) |
| running head and foot | bacex.sty:70-79 | `hf.class-native` | `\runningheadrule`, `\firstpageheadrule`, `\firstpagefootrule`, `\runningfootrule`, `\footer{}{\bf صفحة \thepage\ من \numpages}{}`, `\lfoot{}`, `\rfoot{}`; page X of Y comes from exam's `\numpages` |
| barcode in running head | bacex.sty:81-103 | none: `BESPOKE/class` | `\barcode` macro; `ean13isbn` is loaded at bacex.sty:8 but never called (considered: ean13isbn) |
| title block (republic, ministry, session, level, subject, duration) | bac_template-DZ.tex:7-18,23-38 | `sp.ragged`, `sp.rule`, `sp.manual-space`, `mark.kernel` | `center` environment, `\centerline`, `\rule{\textwidth}{1.4pt}`, `\\[-2pt]`, `\\[-8pt]`, `\hfill`, `\bf`; text is content |
| topic heading and choice line | bacex.sty:104-106; bac_template-DZ.tex:41,44,412 | `sp.ragged`, `mark.ulem`, `mark.kernel` | `\one` `\two`: `\centering` + `\uline{\textbf{...}}`; `\choi`: `\centering{\bf ...}` |
| exercise list | bac_template-DZ.tex:48,50,132,265,403,414,801 | `exam.questions` | `questions` + `\question[04]`, `[07]` points |
| question parts | bac_template-DZ.tex:75-76,85-86,107,129 | `exam.questions` | `parts`/`\part`, `subparts`/`\subpart` |
| exercise heading format | bacex.sty:68 | `exam.questions`, `mark.ulem`, `mark.kernel`, `sp.manual-space` | `\qformat{\textbf{\uline{\sffamily{التمرين \thequestion :}}}\quad \bf{(\thepoints)}\hfill }` |
| exercise number as Arabic word | bacex.sty:32-46 | none: `BESPOKE/class` | `\thequestion` redefined through `\words` (`num.counters` carries the redefinition, not the lookup) |
| point labels in margin | bacex.sty:55-60,67 | `exam.questions`, `box.fancybox` | `\pointsinmargin`, `\marginpointname{ن}`, `\pointformat{\fbox{...}}`, `\marginpointssep`=1.8cm, `\rightpointsmargin`=4.5cm, `\pointpoints{نقطة}{نقاط}` |
| part and subpart labels | bacex.sty:61-65 | `num.counters`, `sp.lengths` | `\thepartno`=`\arabic{partno}`, `\thesubpart`=`\Alph{subpart}`, `\partlabel` `\thepartno)`, `\subpartlabel` `\thesubpart)`, `\partshook` sets `\topsep`=-0.2in |
| vertical space | bac_template-DZ.tex:46 | `sp.manual-space` | `\vspace{0.6cm}` |
| page break between topics | bac_template-DZ.tex:410 | `pg.break` | `\newpage` |
| empty page style (wexam only) | wexam.sty:100 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| framed page background (wexam only) | wexam.sty:10,32-60 | `bg.background`, `art.tikz`: `ART/class` | `\usepackage[color=black,opacity=1,angle=0,scale=1]{background}`; contents are a TikZ drawing |
| last-page messages (sexam only) | sexam.sty:73-79 | `hf.class-native` | `\lfoot`/`\rfoot` with exam's `\iflastpage{...}{...}` |
| table in other sample | exam_with_sexam_ar-DZ.tex:116-125 | `tbl.tabular` | `table[h]`, `\centering`, `tabular{|c|c|c|c|c|c|c|c|}`, `\hline`, no caption; cell numbers are content |
| documentation sample (user guide, not the template) | sexam_wexam_doc_ar.tex:2,3,9,12-21,29-31,37-48,66-81 | `class.article`, `page.geometry`, `list.enumitem`, `meta.hyperref`, `box.tcolorbox`, `code.listings`, `front.maketitle`, `toc.kernel` | `[11pt,A4]`, margins 2cm/2.5cm, `bicolor` tcolorbox, `listings` with `escapeinside`, `\tcbuselibrary{skins,listings,breakable}`; frames `\artdecoframe` and `\niceframe` (:77-81) from `niceframe`/`umrand`/`swrule` have no lib way (considered: niceframe, umrand, swrule; not proposed because this file documents the package) |
| loaded, never called in the main sample | bacex.sty:3,4,7-16,18 | none (no output effect) | `fmtcount`, `etoolbox`, `listings`, `ean13isbn`, `tikz` + libraries, `fancybox`, `bclogo[tikz]`, `multicol`, `moreenum` (CTAN: enumeration label styles for `enumitem`, English words and hex, no Arabic); no command of these appears in bac_template-DZ.tex, and `ulem` (bacex.sty:24) is the one that is called (`\uline` at :68,104-105) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\words`, `\xwords`, `\renewcommand{\thequestion}` | bacex.sty:32-46 | No | A hand-written `\ifcase` table over the counter that prints ten literal Arabic words and a fallback string; `mark.numspell` has no Arabic, `fmtcount` is loaded but not called, so no lib way produces the words |
| `\barcode` and its `\chead` use | bacex.sty:81-101,103 | No | Box-and-glue EAN-13 encoder (`\vrule`, `\oalign`, parity `\ifcase`, swapped macros); the published `ean13isbn` is loaded but not used by the zip, and nothing shows it matches |
| `\one`, `\two`, `\choi` | bacex.sty:104-106 | Yes | `sp.ragged` + `mark.ulem` + `mark.kernel` wrappers with fixed Arabic strings |
| `\alg`, `\gov`, `\bac`, `\duree`, `\niveau`, `\exam` | bac_template-DZ.tex:7-18 | Yes | `\newcommand` aliases of `\bf` text and `\hfill`: `mark.kernel`, `sp.manual-space` |
| `\lycee`, `\annee`, `\examnum`, `\examdate`, `\duree`, `\niveau` | exam_with_sexam_ar-DZ.tex:7-12 | Yes | `\newcommand` aliases; `\yagding` is `font.icons` |
| redefinitions of `\thepartno` `\thesubpart` `\partlabel` `\subpartlabel` `\partshook` `\qformat` `\pointformat` | bacex.sty:58,61-65,68 | Yes | Class hooks set to `\arabic`, `\Alph`, `\fbox`, `\uline`, `\textbf`, `\quad`, `\hfill`, `\setlength{\topsep}` (`exam.questions`, `num.counters`, `mark.ulem`, `sp.lengths`) |
| wexam page decoration | wexam.sty:32-60 | No | `ART`: TikZ rounded double frame, `blur shadow`, three nodes at `current page.south` coordinates with `\shadowbox` and `\iflastpage` |
| `sexam.sty`, `wexam.sty`, `bacex.sty` as packages | all three files | Mixed | No `\ProvidesPackage`; they only load packages and set exam hooks (reducible as above) except the items marked No; the documentation tells the user to edit `sexam.sty` to change fonts (sexam_wexam_doc_ar.tex:114-117) and `bacex.sty:103` hard-codes the barcode digits, so a way built on the package would fail W2 (considered: sexam as a single way) |

## Content-opaque
none (the main sample has no figure or table floats; variation tables and graphs appear only in the question text, e.g. bac_template-DZ.tex:287,364; the other sample's table cells at exam_with_sexam_ar-DZ.tex:120-122 are content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
