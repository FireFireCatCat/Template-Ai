yes

# 0416-modernclassnotes: modernclassnotes (course notes, handouts and worksheets class)

- Unverified: read from the source, not compiled.
- Source: Source/0416-modernclassnotes/ (origin: https://mirrors.ctan.org/macros/latex/contrib/modernclassnotes.zip; licence: LPPL 1.3c and MIT per manifest and modernclassnotes.cls:4-12)
- Kind: misc (lecture notes, handouts, worksheets; the manifest hint is `misc`)
- Lib: v5
- Engine: pdfLaTeX-compatible (Makefile:4 builds with pdflatex; every font option loads a pdfTeX package, modernclassnotes.cls:92-136; no fontspec, no Lua)
- Look carried by: class (the zip is the class's own CTAN distribution; every sample adds only option values, metadata commands and content)
- Class origin: ctan (ctan.org/pkg/modernclassnotes read: listed, v1.1.0 of 2026-08-04, LPPL 1.3c and MIT, path macros/latex/contrib/modernclassnotes)
- Main file: doc/modernclassnotes-doc.tex (other samples: examples/01-complete-course-notes.tex, examples/02-single-lecture-handout.tex, examples/03-homework-worksheet.tex, examples/04-chapter-notes.tex)
- Read: main yes, zip-local classes and styles all (modernclassnotes.cls 1-699, modernclassnotes.sty 1-518; the four examples, README.md and Makefile also read in full)

## Verdict
The look is carried by one published class, `class.modernclassnotes` (CTAN, W1 holds), whose behaviour is chosen by key=value options (`mode`, `palette`, `fontsize`, `font`, `showsolutions`, `parskip`, `official`); the five sample files define no macro of their own and use only that class's native vocabulary plus published packages the class loads. So an emitter writes `\documentclass[...]{modernclassnotes}`, the metadata commands and the class-native body wrappers. No ART, no EXTERNAL (the Makefile only runs pdflatex and zips a release, Makefile:19-46), no UNMAPPED component. The `yes` rests on the class being published: its internals are hand-written macros (mode-switched `\maketitle`, `\lecture`/`\chapter` state, an lrbox callout engine, `\comment`-based solution hiding), and had this class been zip-local I would have leaned `no` (table under Bespoke code). This is evidence about the class dimension, not about component ways.

## Blockers
none

## Class setting
- Class: `class.modernclassnotes` options: `mode=notes|handout|worksheet|chapternotes` (modernclassnotes.cls:26), `palette=ocean|midnight|nord|emerald|burgundy|amethyst|mono|purple` (:27), `fontsize=10pt|11pt|12pt` (:28), `font=default|kpfonts|pagella|sourceserif|charter|helvet|sans|fira|libertine|utopia` (:29, branches :92-136), `showsolutions` (:30), `parskip` (:31), `official` (:33), `numbering` (:32). Options set by samples: mode=notes palette=ocean fontsize=11pt (doc/modernclassnotes-doc.tex:1); mode=handout palette=nord (examples/02-single-lecture-handout.tex:1); mode=worksheet palette=emerald showsolutions=true (examples/03-homework-worksheet.tex:1); mode=chapternotes palette=purple fontsize=12pt font=charter official=false (examples/04-chapter-notes.tex:1). The class loads kernel article with `\LoadClass[\mcn@fontsize,a4paper]{article}` (modernclassnotes.cls:38).
- Class-native vocabulary used: preamble `\course` `\coursecode` `\professor` `\institution` `\term` `\docsubtitle` `\lecturedate` `\assignmentname` (modernclassnotes.cls:249-257), `\title`; `\maketitle` redefined (:307); body `\lecture[date]{n}{title}` (:389), `\chapter{n}{title}{objectives}` (:416, `\NewDocumentCommand{\chapter}{m m g}`), `\subchapter{n}{title}` (:466); environments `theorem` `lemma` `proposition` `corollary` `definition` `example` `remark` `warning` `tip` `takeaways` `exercise` `solution` `proof` `codebox` (:514-684).
- Options declared but not wired, so they change nothing: `numbering` (declared at modernclassnotes.cls:32, no `\ifmcn@numbering` anywhere in .cls or .sty); `font=palatino` is documented (doc/modernclassnotes-doc.tex:51, README.md:32) but the class branches on `pagella` (modernclassnotes.cls:96) and has no `palatino` branch; the README lists a `note` environment (README.md:37) that neither .cls nor .sty defines.
- modernclassnotes.sty (same package, for article/report/book): repeats the options, palettes, metadata commands, `\lecture`, `\chapter`, callouts, `proof`, `\lstset` and `codebox` (modernclassnotes.sty:13-516) but sets no `fancy` page style, no `\maketitle`, no hyperref (no sample loads it; considered as its own way, not proposed, because recovery of these samples does not need it).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | doc/modernclassnotes-doc.tex:1; modernclassnotes.cls:35-38 | `class.modernclassnotes` | options as listed above; base article, a4paper, size from `fontsize` |
| page size, margins | modernclassnotes.cls:38,65-76 | `page.class-options` | a4paper, 11pt; margins fixed by `mode` inside the class (notes 2.5cm, headheight 28pt, headsep 15pt; handout, worksheet, chapternotes 2.0cm, headsep 12pt); no sample sets geometry |
| fonts | modernclassnotes.cls:44,90,92-136; examples/04-chapter-notes.tex:1 | `class.modernclassnotes` | option `font=` (default Latin Modern with T1; `charter` also loads newtxmath when installed, :109-112); pure option value |
| colour palette | modernclassnotes.cls:142-232; doc/modernclassnotes-doc.tex:1 | `class.modernclassnotes` | option `palette=` redefines mcnPrimary, mcnSecondary, mcnAccent, mcnBg, mcnText, mcnBoxBg, mcnBorder (:142-218); callout colours are fixed (:221-232) |
| paragraph spacing | modernclassnotes.cls:31,60-62 | `class.modernclassnotes` | option `parskip=true` (default) loads parskip |
| language strings | modernclassnotes.cls:350,371,400,427,634 | `class.modernclassnotes` | English labels fixed in the class ("LECTURE", "CHAPTER", "Solution:", "Professor:", "Student Name:"); no babel |
| running header and footer | modernclassnotes.cls:264-302 | `hf.class-native` | fancy style; lhead course code and name (small sf bold mcnPrimary, :267-278); rhead current lecture or chapter, else term, else institution (small sf mcnSecondary, :280-291); cfoot page number (:297); lfoot professor and rfoot institution only with `official=true` (:293-296); head rule 0.8pt mcnPrimary, foot rule 0.4pt mcnBorder (:299-302) |
| title block | modernclassnotes.cls:237-257,307-381; doc/modernclassnotes-doc.tex:3-9,13 | `front.class-native` | `\course \coursecode \professor \institution \term \docsubtitle \title` then `\maketitle`; mode notes: centred framed banner with rule and professor, term, institution line (:359-380); handout: compact two-column banner with `\lecturedate` (:308-332, examples/02-single-lecture-handout.tex:8,14); worksheet: banner with blank Student Name, ID, Date rules, title from `\assignmentname` (:334-357, :257, examples/03-homework-worksheet.tex:6,10) |
| table of contents | doc/modernclassnotes-doc.tex:15; examples/01-complete-course-notes.tex:15; modernclassnotes.cls:407,461,476 | `toc.kernel` | `\tableofcontents`; the class appends its own entries with `\addcontentsline` for lectures (section level), chapters (section level) and subchapters (subsection level), written under `front.class-native` below |
| class-added contents entries | modernclassnotes.cls:407,461,476 | `front.class-native` | `\addcontentsline{toc}{section}{Lecture n: title}`, `{Chapter n: title}`, `{toc}{subsection}{...}` with `\texorpdfstring` |
| unnumbered kernel headings | doc/modernclassnotes-doc.tex:18,32,41,60,75,97,116; examples/03-homework-worksheet.tex:12 | `head.kernel` | `\section`, `\subsection`, `\section*`; the class does not restyle them (no titlesec, sectsty or `\@startsection` in the .cls) |
| lecture banner | modernclassnotes.cls:388-409; examples/01-complete-course-notes.tex:21,76 | `head.class-native` | `\lecture[date]{n}{title}`: framed box (mcnSecondary frame on mcnBoxBg), "LECTURE n" small sf with optional right-aligned date, title Large sf bold mcnPrimary; sets the running right head (:391) |
| chapter banner with objectives | modernclassnotes.cls:414-464; examples/04-chapter-notes.tex:18-24,62-73 | `head.class-native` | `\chapter{n}{title}{comma list}`: same framed box, "CHAPTER n", optional rule and enumerate of objectives (enumitem keys `label=\color{mcnPrimary}\arabic*.`, `nosep`, `leftmargin=*`, :436-441; items in mcnSecondary, :464); counter set from the argument (:417) |
| subchapter heading | modernclassnotes.cls:466-483; examples/04-chapter-notes.tex:36-57,75 | `head.class-native` | `\subchapter{n}{title}`: large sf bold mcnPrimary, `\makebox[2.5em][l]{\thechapter.n}`, 2pt rule in mcnBorder |
| callout statements | modernclassnotes.cls:489-629; examples/01-complete-course-notes.tex:25,35,52,59,63,101,105 | `thm.class-native` | `theorem lemma proposition corollary` share counter mcnTheoremCount (mcnTheorem on mcnTheoremBg, labels [THM] [LEM] [PROP] [COR]); `definition` own counter, `example` own counter, `exercise` own counter (mcnSecondary); unnumbered `remark warning tip takeaways`; each takes an optional `[title]`, wraps its body in a minipage 24pt narrower than the line, and frames it through `\mcn@callout` |
| proof | modernclassnotes.cls:649-654; examples/01-complete-course-notes.tex:48-50 | `thm.class-native` | `\renewenvironment{proof}[1][Proof]`: bold sf mcnPrimary label with colon, closing `\hfill$\blacksquare$` |
| solution toggle | modernclassnotes.cls:631-644; examples/03-homework-worksheet.tex:31-48,55-61 | `thm.class-native` | `solution` prints "Solution:" in mcnSecondary when `showsolutions=true`, else the body is swallowed with `\comment` |
| titled code block | modernclassnotes.cls:679-684; doc/modernclassnotes-doc.tex:35,63,78 | `thm.class-native` | `codebox[title]` is a named block environment of the class vocabulary: small sf bold mcnPrimary title with 0.3em gap; no frame (closest home; it prints a title only) |
| code listings | modernclassnotes.cls:50,659-677; examples/01-complete-course-notes.tex:85-98; doc/modernclassnotes-doc.tex:36-38 | `code.listings` | `\lstset`: basicstyle `\small\ttfamily` mcnText, keywordstyle bold mcnPrimary, stringstyle mcnExample, commentstyle italic mcnRemark, numbers=left, numberstyle `\tiny` gray, numbersep=8pt, backgroundcolor mcnBoxBg, frame=single, rulecolor mcnBorder, breaklines=true, tabsize=2, xleftmargin=12pt, framexleftmargin=12pt; `language=Python` and `language=TeX` per listing |
| bullet and numbered lists | modernclassnotes.cls:81-84; examples/01-complete-course-notes.tex:30-33,64-68; examples/04-chapter-notes.tex:26-34 | `list.kernel` | `itemize`, `enumerate`; `\labelitemi` to `\labelitemiv` set to bullet, circ, blacksquare, diamond |
| list labels by key | examples/03-homework-worksheet.tex:24-28; modernclassnotes.cls:58 | `list.enumitem` | `\begin{enumerate}[label=(\alph*)]`; the class loads enumitem when the file exists |
| table | doc/modernclassnotes-doc.tex:42-58 | `tbl.tabular` | `table[h]` float, `tabular{lll}`, bold header cells |
| table rules | doc/modernclassnotes-doc.tex:45,47,55; modernclassnotes.cls:52 | `tbl.booktabs` | `\toprule \midrule \bottomrule` |
| table caption | doc/modernclassnotes-doc.tex:57; modernclassnotes.cls:51 | `cap.caption` | `caption` loaded with no options, `\caption` below the table |
| table centring | doc/modernclassnotes-doc.tex:43 | `sp.ragged` | `\centering` |
| display maths | examples/01-complete-course-notes.tex:38-45; examples/03-homework-worksheet.tex:17-23,34-36; modernclassnotes.cls:47 | `math.amsmath` | `\[ \]` with `cases`, `\text`, `\implies`; amsmath loaded by the class |
| math symbols | examples/02-single-lecture-handout.tex:21; examples/03-homework-worksheet.tex:46; modernclassnotes.cls:47 | `math.amssymb` | `\mathbb{R}`, `\mathbb{E}`; amssymb loaded by the class |
| inline emphasis | doc/modernclassnotes-doc.tex:20,25; examples/04-chapter-notes.tex:27-30 | `mark.kernel` | `\textbf`, `\texttt`, `\textit` |
| page breaks | doc/modernclassnotes-doc.tex:16; examples/01-complete-course-notes.tex:16,71 | `pg.break` | `\newpage` |
| links and PDF colours | modernclassnotes.cls:689-697 | `meta.hyperref` | colorlinks=true, linkcolor=mcnPrimary, citecolor=mcnSecondary, urlcolor=mcnSecondary, pdfborder={0 0 0}, breaklinks=true; loaded last, unconditionally |

Not used by any sample, so no row: bibliography, index, footnotes, figures, cross-references, abstract, appendix.

## Bespoke code
None in the samples: the five .tex files define no macro, environment, counter or conditional (no `\newcommand`, `\def`, `\renewcommand`, `\newenvironment`, `\newcounter` in examples/ or in doc/modernclassnotes-doc.tex), and the class is published, so its macros are not zip-local. Informational only (class-internal constructs, not blockers because of W1; reductions use way ids as plain reading aids, not as ways the emitter needs):

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option presets for geometry, font, palette | modernclassnotes.cls:65-76,92-136,142-218 | yes | `\ifstrequal` choice among fixed alternatives: `page.geometry` values, `font.lmodern` `font.charter` `font.helvet` `font.palatino` `font.libertine` `font.fourier` `font.serif-pkg` packages, `color.xcolor` `\definecolor` sets |
| fancyhdr heads and rules | modernclassnotes.cls:264-302 | mostly | `hf.fancyhdr` fields plus `mark.kernel` and `color.xcolor`; the rhead reads the state macro `\mcn@currentlecture` set by `\lecture` and `\chapter` (:391,:418), a hand-rolled runtime variable |
| mode-switched `\maketitle` | modernclassnotes.cls:307-381 | borderline | three alternative layouts of `box.fancybox` + `box.minipage` + `sp.rule` + `font.size-commands`; the switch is `\ifstrequal{\mcn@mode}`; an emitter would copy the macro bodies |
| `\lecture`, `\chapter`, `\subchapter` | modernclassnotes.cls:388-483 | borderline | `box.fancybox` + `box.minipage`, `list.enumitem`, `sp.rule`, `num.counters` (counters set from arguments, :417), `\forcsvlist` loop over a comma list (:442,:449) |
| callout engine and statement environments | modernclassnotes.cls:489-629 | borderline | `thm.tcolorbox` or `box.fancybox` around `box.minipage` with `num.counters`; the lrbox save-then-frame logic and shared counters are macro logic |
| `solution` hiding | modernclassnotes.cls:631-644 | borderline | `\comment` from verbatim chosen by `showsolutions`; a boolean switch around a wrapper |
| `proof` redefinition | modernclassnotes.cls:649-654 | yes | `thm.amsthm` proof with a label and `\blacksquare` |
| `\lstset` | modernclassnotes.cls:659-677 | yes | `code.listings` keys only |
| `\hypersetup` | modernclassnotes.cls:689-697 | yes | `meta.hyperref` keys only |

## Content-opaque
none (the Python text at examples/01-complete-course-notes.tex:85-98 and the TeX snippets inside `lstlisting` at doc/modernclassnotes-doc.tex:36-38,64-72,79-81,86-94,109-113 are code content held by `code.listings`; the theorem and exercise equations are maths content)

## Lib changes
- New ways proposed: none (considered: `modernclassnotes.sty` as a package way; not proposed, no sample loads it; `thm.class-native` hosts the class's callout environments; a separate class-native box way was considered and not proposed because those environments are statement-like blocks of the same class engine)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
