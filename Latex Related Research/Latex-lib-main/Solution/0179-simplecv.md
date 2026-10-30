yes

# 0179-simplecv: simplecv (CV class, CTAN)

- Unverified: read from the source, not compiled.
- Source: Source/0179-simplecv/ (origin: https://mirrors.ctan.org/macros/latex/contrib/simplecv.zip; licence: LPPL 1.2)
- Kind: cv
- Lib: v3
- Engine: pdfLaTeX-compatible (the class loads no package and uses only kernel and `article` commands; the shipped testcv.pdf carries a pdfTeX producer string, which is metadata, not a test; the RTL branch uses e-TeX `\beginR`/`\endR` at simplecv.dtx:327 but is reached only when babel sets `\if@rl`, which the sample never does)
- Look carried by: class (the package is the class: `simplecv.dtx` generates `simplecv.cls` through `simplecv.ins:38`; the sample adds only content and calls the class's own commands)
- Class origin: ctan
- Main file: testcv.tex (other samples: the documentation driver inside simplecv.dtx:28-35, `\documentclass{ltxdoc}`; it documents the class and is not the template)
- Read: main yes, zip-local classes and styles all (simplecv.dtx 457 lines, simplecv.ins 55 lines, README 12 lines; no `.cls` or `.sty` file is in the zip, the class exists only as the `class` module of the `.dtx`; the two PDFs were not read)

## Verdict
The zip is the CTAN package `simplecv`, a published class. The sample is `\documentclass{simplecv}` plus content and the class's own vocabulary (`\leftheader`, `\rightheader`, `\title`, `\maketitle`, `\section`, the `topic` environment, `thebibliography`), with no preamble and no zip-local macro. An emitter writes `\documentclass{simplecv}` and the body wrappers, so every component is one lib way, there is no bespoke code in the sample or the class (the class is the published way), and there is no artwork. The only zip-local macros are three documentation-driver helpers in the `.dtx` (not the template), and all are reducible. `yes` is a verdict about the class dimension (Look carried by: class), not about the component ways.

## Blockers
none

## Class setting
- Class: `class.simplecv` options: none in the sample (testcv.tex:1). Defaults forced by the class: `sf,letterpaper,10pt,oneside,onecolumn,final` (simplecv.dtx:287). Own options: `sf` (default) and `plain` select a font set (simplecv.dtx:253-268), `topictitle` (269-272), `notopicbreak` (273-276), `contbibnum` (277-281), `titleabove` (282-285); every other option is passed to `article` (286). The class ends in `\LoadClass{article}` (289) and loads no package (grep: no `\RequirePackage`, no `\usepackage` in simplecv.dtx).
- Class-native vocabulary used: `\leftheader[pos]{text}`, `\rightheader[pos]{text}` (testcv.tex:5, 8; defined simplecv.dtx:304-305), `\title` (testcv.tex:11; redefined to store text, simplecv.dtx:314), `\maketitle` (testcv.tex:13; simplecv.dtx:335-344), `\section` (testcv.tex:18, 28, 36; simplecv.dtx:350-353), environment `topic` with `\item[label]` (testcv.tex:20-26, 30-34; simplecv.dtx:420-424), `thebibliography` redefined (testcv.tex:38-43; simplecv.dtx:437-451). Defined but not used by the sample: `\subsection` (simplecv.dtx:361-364), font setters `\sectionfont` `\subsectionfont` `\topiclabelfont` `\topictitlefont` `\headerfont` `\titlefont` (234-239), length macro `\topicmargin` (385). Disabled by the class: `\subsubsection`, `\paragraph`, `\subparagraph` (371-372).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | testcv.tex:1; simplecv.dtx:23, 289 | `class.simplecv` | no options in the sample; built on `article` (`\LoadClass{article}`) |
| page size and base size | simplecv.dtx:287 | `page.class-options` | `letterpaper`, `10pt`, `oneside`, `onecolumn`, `final`; margins are those of `article` at 10pt (size10.clo, not in the zip, not read) |
| title block (header row and title) | testcv.tex:5-13; simplecv.dtx:304-305, 314, 319, 325-344 | `front.class-native` | `\leftheader{123 Hamlet Street\\ Stratford-upon-Avon}` left, `\rightheader{TEL...}` right, `\title{William Shakespeare}`; layout `tabular*` of `\textwidth` with `@{}l@{\extracolsep{\fill}}l@{}` (simplecv.dtx:338), alignment `l` per header (default `l`, simplecv.dtx:304-305), title in a `center` after `\par\bigskip` (333-334), `\bigskip` after (344); option `titleabove` moves the title above (336, 343); fonts `\headerfont` and `\titlefont` |
| title block fonts under option `sf` | simplecv.dtx:258-259 | `mark.kernel`, `font.nfss`, `font.size-commands` | header `\sffamily`; title `\sffamily\fontseries{sbc}\selectfont\LARGE`; with option `plain`: `\headerfont{}` and `\titlefont{\bfseries\LARGE}` (266-267) |
| header cell of the title block | simplecv.dtx:325-332 | `tbl.tabular` | kernel `tabular[t]` with a one-column `@{<font>}l@{}` spec per header, inside the class's `\maketitle`; no `array` package loaded |
| section headings | testcv.tex:18, 28, 36; simplecv.dtx:350-353 | `head.class-native` | `\@startsection{section}{1}{\z@}{-3.5ex plus -1ex minus -.2ex}{2.3ex plus .2ex}{\cv@sec@fnt}` (flush-left, no indent); font under `sf`: `\sffamily\fontseries{sbc}\selectfont` (254), under `plain`: `\bfseries` (262); only `\section` and `\subsection` exist (371-372) |
| subsection heading (not used by the sample) | simplecv.dtx:361-364, 255 | `head.class-native` | same skip values, indent `3em`, level 1, font `\cv@ssec@fnt` |
| heading numbering | simplecv.dtx:377 | `num.secnumdepth` | `\setcounter{secnumdepth}{0}` (no numbers) |
| section font switches | simplecv.dtx:254-255, 262-263 | `mark.kernel`, `font.nfss` | `\sffamily`, `\fontseries{sbc}\selectfont` (semibold condensed), `\bfseries` |
| CV entries (dates and text) | testcv.tex:20-26, 30-34; simplecv.dtx:394-424 | `cv.entries` | environment `topic` = kernel `\list{}` with `\leftmargin`=`\topicmargin`=`0.20\columnwidth` (385, 414), `\rightmargin`=0 (415), `\labelwidth`=`0.8\t@picmargin` (417), `\makelabel` = label font then `\hfill` (394, 418); a label wider than `\labelwidth` is followed by `\mbox{}\\*` unless `notopicbreak` (397-402); `\item[1593--1609]` text, several paragraphs allowed (testcv.tex:25) |
| entry label font | simplecv.dtx:256, 264 | `cv.entries` | `\topiclabelfont`: `\sffamily\slshape` (`sf`), `\itshape` (`plain`); with option `topictitle` the first paragraph of an entry takes `\topictitlefont` (403-406) |
| right-to-left support | simplecv.dtx:294, 326-330, 410-416 | `class.simplecv` | `\if@rl` switch set by babel for RTL languages; margins swap; not used by the sample |
| bibliography list | testcv.tex:38-43; simplecv.dtx:437-451 | `bib.thebibliography` | hand-written `thebibliography{1}`, `\bibitem{firstref}` `\bibitem{secondref}`, `\cite{firstref}` (testcv.tex:42); the class gives it the `topic` geometry (`\@topic@setup`, 439), labels `\@biblabel{\theenumiv}` in `\arabic` (438, 443), `\sloppy`, `\clubpenalty 4000`, `\widowpenalty 4000`, `\sfcode`\.=\@m` (447); these live inside the published class, the emitter writes only the environment |
| bibliography numbering across lists | simplecv.dtx:277-281, 444-451 | `class.simplecv` | option `contbibnum` saves `enumiv` in counter `cv@save@bib@num` between lists; not used by the sample |
| text and inline marks | testcv.tex:9 | `mark.kernel`, `font.size-commands` | `\texttt{\small bill@globe.org}` |
| intro paragraph and kernel logo and dots macros | testcv.tex:15-16, 41 | (content) | `\LaTeX{}`, `\TeX`, `\ldots{}` are kernel macros inside running text, content |
| running heads and page style | (none set) | `hf.pagestyle-kernel` | no `\pagestyle` in simplecv.dtx or testcv.tex (grep); `article` default `plain` applies |
| documentation driver | simplecv.dtx:28-35 | `class.ltxdoc`, `dtx.doc` | `\documentclass{ltxdoc}`, `\CodelineIndex`, `\RecordChanges`, `\DocInput{simplecv.dtx}`; the `.dtx` uses `\changes`, `\DescribeMacro`, `\DescribeEnv`, `\StopEventually`, `\Finale`, `\CheckSum`, `\CharacterTable`, `\DoNotIndex` (not the template) |

## Bespoke code
The class code (simplecv.dtx:233-452) is published on CTAN and is the way `class.simplecv`, so none of it is zip-local bespoke. The sample defines no macro, environment or counter. The only zip-local macros sit in the documentation driver, outside the `class` module and outside testcv.tex:

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\SpecialOptionIndex` | simplecv.dtx:57-61 | yes | two kernel `\index` entries between `\@bsphack` and `\@esphack`: `idx.makeidx` (makeindex special characters), `mark.kernel` for the `\ttfamily` |
| `\DescribeOption`, `\Describe@Option` | simplecv.dtx:62-66 | yes | `\marginpar{\raggedleft...}` (`note.marginpar`, `sp.ragged`) plus the index call above (`idx.makeidx`), a copy of ltxdoc's own `\DescribeMacro` pattern |
| `\LyX` (`\providecommand`) | simplecv.dtx:67 | yes | logo from kerns and a lowered `Y`: `font.icons` (`hologo`, if its name list has LyX) or `sp.manual-space` (`\hspace{-.1667em}`, `\raisebox{-.25em}{Y}`); a logo in documentation text |

## Content-opaque
none

## Lib changes
- New ways proposed: none. The `topic` entry environment maps to `cv.entries` (a CV class's own entry command, the lib line already names the family), and the class's own vocabulary is recorded under `class.simplecv` as the rubric asks.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
