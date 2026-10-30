yes

# 0607-rzach-ucalgmthesis: ucalgmthesis, University of Calgary Memoir Thesis class and sample thesis

- Unverified: read from the source, not compiled.
- Source: Source/0607-rzach-ucalgmthesis/ (origin: https://codeload.github.com/rzach/ucalgmthesis/zip/refs/heads/master; licence: MIT)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible
- Look carried by: mixed (the thesis look is defined in `ucalgmthesis.cls` over memoir: title page, type block, spacing, running heads, contents; the sample preamble adds conventional packages: link colours, microtype, theorems, natbib, bookmarks)
- Class origin: ctan
- Main file: sample-thesis.tex (other samples: none; `\include`d parts titlepage.tex, frontmatter.tex, chapter1.tex, chapter2.tex, backmatter.tex, appendix.tex)
- Read: main yes, zip-local classes and styles all

## Verdict
The class `ucalgmthesis` is published: ctan.org/pkg/ucalgmthesis lists it (R. Zach, MIT, version 2023-03-18, in TeX Live and MiKTeX), and README.md:67-73 says so. It is a 209-line wrapper that loads `memoir` (ucalgmthesis.cls:101) and only sets options, type block calls, a memoir page style, a title-page macro, a dedication macro and toc tweaks. Every piece reduces to lib ways with fixed parameters, there is no output routine, no hand-rolled counter and no artwork, and the sample preamble loads only published packages. No blocker, so `yes`; nothing was compiled.

## Blockers
none

## Class setting
- Class: `class.ucalgmthesis` (loads `class.memoir`, ucalgmthesis.cls:101) options: `utopia,headers,manuscript` (sample-thesis.tex:38); the class passes `openany,oneside,11pt` to memoir (ucalgmthesis.cls:96) and `12pt` when `manuscript` is given (ucalgmthesis.cls:81).
- Class-native vocabulary used (class): options `utopia` (ucalgmthesis.cls:47-51), `headers` (ucalgmthesis.cls:61), `manuscript` (ucalgmthesis.cls:80-83); other options in the class, not used by the sample: `singlespaced` `onehalfspaced` `doublespaced` (28-30), `palatino` `times` `garamond` `libertine` (34-46, 52-56), `plain` (60), `fullpage` (73-74); commands `\makethesistitle` (titlepage.tex:6), `\degree` `\prog` `\monthname` `\thesisyear` (sample-thesis.tex:114,121,125,129), `\dedication` (frontmatter.tex:63), also defined: `\dept` `\gradyear` `\thesis` `\fullpagethesis` `\manuscriptthesis` (ucalgmthesis.cls:110-130,172-179).
- Class-native vocabulary used (memoir, through the class): `\frontmatter` `\mainmatter` `\backmatter` (sample-thesis.tex:161,176,185), `\chapter` (chapter1.tex:4), `\makepagenote` `\pagenote` `\printpagenotes` (sample-thesis.tex:137, chapter1.tex:37, backmatter.tex:2), `\epigraph` (chapter1.tex:6-9), `\thetitle` `\theauthor` (sample-thesis.tex:133), `\maxsecnumdepth` (commented, sample-thesis.tex:157), `\includeonly` (commented, sample-thesis.tex:145,150).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | sample-thesis.tex:38; ucalgmthesis.cls:101 | `class.ucalgmthesis` | options `utopia,headers,manuscript`; base `class.memoir` |
| base class | ucalgmthesis.cls:101 | `class.memoir` | loaded by `\LoadClass{memoir}`; its vocabulary is listed above |
| paper and size options | ucalgmthesis.cls:96,81 | `page.class-options` | `openany`, `oneside`, `11pt`; `12pt` from `manuscript` |
| type block and margins | ucalgmthesis.cls:121-130 | `page.memoir-layout` | `\setlxvchars`; `\settypeblocksize{25\baselineskip}{1.1\lxvchars}{*}`; oneside branch `\setlrmargins{*}{*}{1}` (127); `\setulmargins{*}{*}{*}`; `\checkandfixthelayout` |
| type block, `fullpage` option (not used by sample) | ucalgmthesis.cls:110-114 | `page.memoir-layout` | `\settypeblocksize{9in}{6.5in}{*}`; `\setlrmarginsandblock{1in}{*}{*}`; `\setulmarginsandblock{1in}{*}{*}` |
| line spacing | ucalgmthesis.cls:28-30,82,91 | `sp.setspace` | `manuscript` runs `\ExecuteOptions{doublespaced}` (82) giving `\DoubleSpacing` (30); default `\OnehalfSpacing` (29,91); memoir's own spacing commands, the same type as setspace's (memoir cannot load setspace); lib line not stretched to another type |
| microtype | sample-thesis.tex:47 | `sp.microtype` | defaults |
| paragraph centring | ucalgmthesis.cls:140,168; chapter1.tex:53 | `sp.ragged` | `center` environment, `\centering` |
| title-page spacing and fill | ucalgmthesis.cls:140-160 | `sp.manual-space` | `\vfill` between title-page blocks, `\\`, `\par` |
| text fonts, encoding | ucalgmthesis.cls:48 | `font.fontenc-t1` | `[T1]` |
| text font Utopia-like | ucalgmthesis.cls:50 | `font.serif-pkg` | package `erewhon`, no options; chosen by class option `utopia` |
| maths font | ucalgmthesis.cls:51 | `font.newtx` | `newtxmath` options `utopia,vvarbb` |
| font option `times` (not used) | ucalgmthesis.cls:38-41 | `font.newtx` | `newtxtext,newtxmath`, `[T1]` |
| font option `garamond` (not used) | ucalgmthesis.cls:42-46 | `font.serif-pkg` | `garamondx`; maths `newtxmath[garamondx,cmbraces]`; README.md:116-119 says `garamondx` is not in TeX Live |
| font option `palatino` (not used) | ucalgmthesis.cls:34-37 | `font.palatino` | `newpxtext,newpxmath`, `[T1]` (a Palatino-family package; the package is the parameter) |
| font option `libertine` (not used) | ucalgmthesis.cls:52-56 | `font.libertine` | `libertine`; maths `newtxmath[libertine]` |
| colour | sample-thesis.tex:43 | `color.xcolor` | option `dvipsnames` |
| links, metadata | sample-thesis.tex:51,57,133; chapter1.tex:28 | `meta.hyperref` | `colorlinks,allcolors=MidnightBlue`; `pdfinfo={Title={\thetitle},Author={\theauthor}}`; `\href` |
| PDF bookmarks | sample-thesis.tex:78 | `meta.bookmark` | option `numbered` |
| default page style | ucalgmthesis.cls:60,91,165 | `hf.pagestyle-kernel` | `\pagestyle{plain}` by default (`plain` option), `\thispagestyle{plain}` on the dedication page |
| running head and foot | ucalgmthesis.cls:61,186-195 | `hf.memoir-pagestyle` | `headers` option sets `\pagestyle{ucalgaryruled}` (61); `\copypagestyle{ucalgaryruled}{ruled}` (186); oneside `\makeoddhead{ucalgaryruled}{}{}{\leftmark}` (191); `\makeoddfoot{ucalgaryruled}{}{\thepage}{}` (194); twoside branch (188-189,195) not selected |
| page numbering by matter | ucalgmthesis.cls:194; README.md:99-101 | `pgnum.pagenumbering` | roman in front matter, arabic in main matter (memoir `\frontmatter` `\mainmatter`), folio centred in footer |
| matter divisions | sample-thesis.tex:161,176,185 | `front.class-native` | `\frontmatter`, `\mainmatter`, `\backmatter` (memoir vocabulary) |
| title page | titlepage.tex:6; ucalgmthesis.cls:138-162 | `front.class-native` | `\makethesistitle`; fields `\title` `\author` (sample-thesis.tex:106,110) and `\degree` `\prog` `\monthname` `\thesisyear` (114-129); reduces to `front.titlepage-env`, see Bespoke code |
| title page environment | ucalgmthesis.cls:139,161 | `front.titlepage-env` | memoir `titlingpage*` hand-laid with `center` and `DoubleSpace` |
| title page upper case | ucalgmthesis.cls:157,172-178 | `mark.case` | `\MakeUppercase{\@monthname}`, `\uppercase{#1}` in the setters |
| dedication | frontmatter.tex:63; ucalgmthesis.cls:164-168 | `front.class-native` | `\dedication{To mom.}`; effect is a centred page, reduces to `front.dedication` plus `pg.break`, `hf.pagestyle-kernel`, `toc.kernel` |
| abstract, preface, acknowledgements | frontmatter.tex:4,15,48; README.md:173-174 | `front.dedication` | no abstract environment: each is a `\chapter{..}` under `\frontmatter`; the heading is `head.kernel` |
| chapter and section headings | chapter1.tex:4,35; chapter2.tex:28; appendix.tex:8 | `head.kernel` | `\chapter`, `\section`, `\subsection`, `\chapter*`; memoir default chapter style, no `\chapterstyle` or `\setsecheadstyle` anywhere |
| numbering depth | sample-thesis.tex:154-157 | `num.secnumdepth` | memoir default (numbered from sections up); `\maxsecnumdepth{subsection}` is commented out |
| appendix | sample-thesis.tex:193; appendix.tex:8,14 | `num.appendix` | `\appendix`; `\chapter*{Appendix}` with `\addcontentsline{toc}{chapter}{Appendix}` (`toc.kernel`) |
| contents and lists | frontmatter.tex:65,69,73 | `toc.kernel` | `\tableofcontents`, `\listoftables`, `\listoffigures`; `\renewcommand{\contentsname}{Table of Contents}` (ucalgmthesis.cls:203) |
| contents entry style | ucalgmthesis.cls:201-202 | `toc.tocloft` | `\setlength{\cftbeforechapterskip}{3pt plus 0pt}`; `\renewcommand{\cftchapterleader}{\normalfont\cftdotfill{\cftsectiondotsep}}` (memoir carries tocloft's commands) |
| new page before lists | ucalgmthesis.cls:207-209 | `pg.break` | `\clearpage` prepended to each of the three list commands by `\addtodef` |
| lists | appendix.tex:25-31 | `list.kernel` | `enumerate` |
| quote | frontmatter.tex:22-30 | `quote.kernel` | `quote` environment |
| epigraph | chapter1.tex:6-9 | `quote.epigraph` | `\epigraph{text}{source}` (memoir includes it) |
| emphasis marks | chapter1.tex:12-13 | `mark.kernel` | `\textbf`, `\emph`, `\textsl`, `\textsc` |
| verbatim text | chapter1.tex:16; frontmatter.tex:59 | `code.verbatim` | `\verb` |
| footnotes | frontmatter.tex:60; chapter2.tex:19 | `fn.kernel` | `\footnote` |
| endnotes | sample-thesis.tex:137; chapter1.tex:37; chapter2.tex:30; backmatter.tex:2 | `fn.endnotes` | memoir `\makepagenote`, `\pagenote{..}`, `\printpagenotes` (the memoir counterpart of `endnotes`, same type: collect notes and print them at one place) |
| display maths | chapter2.tex:13-16,22; sample-thesis.tex:84 | `math.kernel` | `\[ \]`; `amsmath` is also loaded (`math.amsmath`) |
| theorem-like statements | sample-thesis.tex:84,86-88; chapter1.tex:41-44; chapter2.tex:8-17 | `thm.amsthm` | `\newtheorem{thm}{Theorem}[chapter]`; `\theoremstyle{definition}`; `\newtheorem{defn}[thm]{Definition}`; optional title `[Residue Theorem]`; the font options load `amsthm` first (ucalgmthesis.cls:49) |
| figure float | chapter2.tex:21-24 | `fig.graphicx` | `figure` float holding a display formula, no image |
| table | chapter1.tex:52-61 | `tbl.tabular` | `tabular{c|c}`, `\hline`, inside `table` and `center` |
| captions | chapter1.tex:60; chapter2.tex:23 | `cap.kernel` | `\caption` below each float, memoir defaults |
| labels and links | appendix.tex:8,21 | `xref.kernel` | `\label{appendix}` |
| hyperlinked reference | appendix.tex:21 | `xref.hyperref` | `\hyperref[appendix]{Appendix}`; `\phantomsection` in `\dedication` (ucalgmthesis.cls:166) |
| citations | sample-thesis.tex:94; frontmatter.tex:61 | `bib.natbib` | option `round`; `\citet{Knuth1986,Lamport1986,Wilson2016}` |
| bibliography | sample-thesis.tex:95; backmatter.tex:4 | `bib.bibtex-bst` | `\bibliographystyle{plainnat}`; `\bibliography{sample-thesis}`; three entries in sample-thesis.bib:1,9,16 |
| file inclusion | sample-thesis.tex:166,171,178,180,187,195 | `struct.input` | `\include{titlepage}` and the other five parts; `\includeonly` lines commented (145,150) |
| filler text | sample-thesis.tex:100; chapter1.tex:37,39,46,50,63 | `draft.todo` | `blindtext` `\blindtext[n]` (filler content, the package is the parameter) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\makethesistitle` | ucalgmthesis.cls:138-162 | yes | `front.titlepage-env` (`titlingpage*`) with `sp.ragged` (`center`), `sp.setspace` (`DoubleSpace`), `sp.manual-space` (`\vfill`, `\\`), `mark.case`; literal strings "UNIVERSITY OF CALGARY", "SUBMITTED TO THE FACULTY OF GRADUATE STUDIES ..." and the title, author, thesis, degree, dept, month, year fields; no counters or conditionals |
| metadata setters `\dept` `\degree` `\monthname` `\gradyear` `\thesis`, aliases `\prog` `\thesisyear` | ucalgmthesis.cls:172-179 | yes | `\gdef` string stores (`\uppercase` for dept, degree, thesis); inline the field text into the title page; `\thesis{Thesis}` default (179) is the literal "THESIS" |
| `\dedication` | ucalgmthesis.cls:164-168 | yes | `pg.break` (`\clearpage`), `hf.pagestyle-kernel` (`\thispagestyle{plain}`), `sp.manual-space` (`\vfill`), `xref.hyperref` (`\phantomsection`), `toc.kernel` (`\addcontentsline{toc}{chapter}{Dedication}`), `sp.ragged` (`\centering`) |
| `\fullpagethesis`, `\manuscriptthesis` | ucalgmthesis.cls:110-130 | yes | `page.memoir-layout` calls with literal values; the `\if@twoside` test (124-128) is the kernel switch set by the `twoside` option, so the emitter keeps one branch (oneside here) |
| page style `ucalgaryruled` | ucalgmthesis.cls:186-195 | yes | `hf.memoir-pagestyle` (`\copypagestyle`, `\makeoddhead`, `\makeoddfoot`); `\if@twoside` branch chosen by the option as above |
| contents tweaks and `\addtodef` hooks | ucalgmthesis.cls:201-209 | yes | `toc.tocloft` lengths and leader; `\contentsname` string; `\clearpage` as `pg.break` before each list |
| option plumbing | ucalgmthesis.cls:28-30,60-61,73-97 | yes | `\DeclareOption`, `\ExecuteOptions`, `\PassOptionsToClass`, `\AtEndOfClass`, `\AtBeginDocument{\pagestyle{..}}` map options to the calls above; options are parameters of `class.ucalgmthesis` |
| font options | ucalgmthesis.cls:34-56 | yes | `\AtEndOfClass{\usepackage ...}` of published font packages only (see font rows) |
| `\fixmdhrulefill` | ucalgmthesis.cls:134 | yes | never called in the class or the sample (the only match in the zip is its definition); if used, `\leaders\hrule` is `sp.rule` |

## Content-opaque
- Figure content: a display formula `\[ \circ \to \circ \]` stands in for the artwork (chapter2.tex:22).
- Bibliography entries and filler paragraphs from `blindtext` (sample-thesis.bib:1-21; sample-thesis.tex:100).
- README.md:22-23 mentions `natbib-oup.bst`; it is not in the zip and the sample uses `plainnat` (sample-thesis.tex:95).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
