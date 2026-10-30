yes

# 0669-worksheet: worksheet (the CTAN package `worksheet`, with its own manual as the sample)

- Unverified: read from the source, not compiled.
- Source: Source/0669-worksheet/ (origin: https://mirrors.ctan.org/macros/latex/contrib/worksheet.zip; licence: lppl1.3c)
- Kind: assignment (an exercise-sheet package; the sample is the package's own manual, a faculty-branded document)
- Lib: v5
- Engine: needs XeLaTeX (the sample loads `fontspec` and sets `\setsansfont{Helvetica Neue}`, worksheet.tex:29-30; the package alone is stated to work with pdflatex and xelatex, README.md:7 and worksheet.tex:369)
- Look carried by: mixed (scrartcl defaults, the CTAN package `worksheet.sty` shipped in the zip for exercises, title and header, and the sample's own preamble macros and hand-laid title page)
- Class origin: tex-distribution-unbundled
- Main file: worksheet.tex (other samples: none; `worksheet.pdf` is the precompiled manual, a binary, not read)
- Read: main yes, zip-local classes and styles all (`worksheet.sty`, 406 lines, read in full; no `.cls`, `.cfg`, `.def` or `.clo` present)

## Verdict
Every component of the sample maps to a lib way. The one file the zip adds, `worksheet.sty`, is the CTAN release of `worksheet` (the manifest origin is a CTAN URL; ctan.org/pkg/worksheet shows v1.1, LPPL 1.3c, in TeX Live and MiKTeX), so it passes W1; its behaviour is set by strings, on/off flags and a closed difficulty list (W2), it serves any exercise sheet (W3), and it prints as `\usepackage{worksheet}` plus an `exercise` wrapper and a few preamble commands (W4). The sample's own macros are colour aliases, text aliases and one `center`+`minipage` wrapper, all reducible by inline expansion; there is no artwork and no external tool. Caveat: the package internals (jobname digit scan, `\@iinput` patch, flag counters) are irreducible TeX if the file were zip-local; the `yes` rests on W1, and the emitter copies none of that code.

## Blockers
none

## Class setting
- Class: `class.scrartcl` options: `12pt`, `a4paper`, `listof=flat` (worksheet.tex:2); the class source is not in the zip and was not read.
- Class-native vocabulary used: `\section`, `\subsection*`, `\subsubsection*` (KOMA headings at their defaults), `\tableofcontents`, `titlepage` environment, the page style names `plain` and `headings` (the latter driven through `scrlayer-scrpage`); the package tests `\KOMAClassName` (worksheet.sty:354). No `\setkomafont`, `\KOMAoptions` or `\subject` is used.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | worksheet.tex:2 | `class.scrartcl` | 12pt, a4paper, listof=flat |
| paper and base size | worksheet.tex:2 | `page.class-options` | a4paper, 12pt; margins are the KOMA default, no geometry call |
| language | worksheet.tex:5; body 358, 365 | `lang.babel` | options `ngerman, english` (english is the main language); `\selectlanguage{ngerman}` then `\selectlanguage{english}` |
| graphics | worksheet.tex:8, 101-104 | `fig.graphicx` | `figure[t]` with `\centering\includegraphics[width=0.8\textwidth]{./HS-Osna-Logo.png}`, no caption (the image is not in the zip) |
| colour | worksheet.tex:11, 14-26 | `color.xcolor` | `\textcolor[RGB]{r,g,b}` with 13 RGB triples (maraschino 255,38,0 ... gray 127,127,127) |
| sans font | worksheet.tex:29-30 | `font.fontspec` | `\setsansfont{Helvetica Neue}` (a system font, not shipped; README.md:7 also suggests Raleway) |
| package load | worksheet.tex:33; worksheet.sty:9 | `exam.questions` | `\usepackage{worksheet}` (v1.1, 2018/08/08), no options; needs `scrlayer-scrpage` |
| exercise environment | worksheet.sty:234-321; used worksheet.tex:355-361 | `exam.questions` | `exercise[\score{10}\easy\learningtargets{1, 2, 3}\occurrence{Exam WS 2018}]`; counter label "Exercise n" (bold, `\sffamily`, `\normalsize`, `\addvspace{\topsep}` before and after, sty:239-245, 320); score and learning targets `\footnotesize\hfill`, difficulty `\footnotesize` (sty:250-286); `\score` `\learningtargets` `\occurrence` take strings, `\easy` `\medium` `\hard` a closed list (sty:181-231) |
| exercise label language | worksheet.sty:62-107; used worksheet.tex:358-361 | `exam.questions` | label strings picked from the babel language name: english, french, german, ngerman (sty:62-89, 92-96, 99-104) |
| exercise display flags | worksheet.tex:351-354; worksheet.sty:162-178 | `exam.questions` | booleans `\worksheetShowScore` `\worksheetShowLearningTargets` `\worksheetShowDifficulty` `\worksheetShowOccurrence` `\worksheetShowFileName` and the `\worksheetHide*` forms (worksheet.tex:172-184, 197-200) |
| exercise file name display | worksheet.tex:231-234; worksheet.sty:151-152, 296-300 | `struct.input` | `\input{file1.tex}` .. `\input{file4.tex}`: the file name prints (`\scriptsize\sffamily[name]`) only for an exercise read through `\input` (the four files are not in the zip) |
| worksheet title | worksheet.tex:258-261; worksheet.sty:114-132 | `exam.questions` | `\worksheetTitle{My Title}` `\worksheetSubTitle{My Subtitle}` `\worksheetMakeTitle`: centred, `\textbf{\sffamily\huge title~number}`, subtitle `\sffamily\LARGE` (sty:125, 127); the number is the first digit run of `\jobname` (sty:35-55; `worksheet` has none) |
| running header strings | worksheet.tex:85-87; worksheet.sty:336-344, 371-377 | `exam.questions` | `\worksheetAuthors{Ignored Author}` `\worksheetCourseName{Ignored Header}` `\worksheetChangelvFile{./MySubDirectory/lv.tex}` (file absent, so the two strings win); default file `./lv.tex`; `\worksheetHideHeader` `\worksheetNoSFFamilyInHeader` are flags (sty:332-333) |
| running header machinery | worksheet.sty:11-12, 351-362, 365-395 | `hf.scrlayer-scrpage` | loaded by the package with `headsepline=1pt`; `\clearpairofpagestyles`, `\cfoot*{\pagemark}`, `\ihead{<course>}` `\ohead{<authors>}` (`\sffamily` under KOMA), `\pagestyle{headings}`; the sample's text puts authors inner (worksheet.tex:272), the code puts the course in `\ihead` (sty:384), a doc-versus-code mismatch that does not change the way |
| page style choice | worksheet.tex:93, 267, 317 | `hf.pagestyle-kernel` | `\pagestyle{plain}` for the body, `\thispagestyle{headings}` on two pages |
| title page | worksheet.tex:99-124 | `front.titlepage-env` | `titlepage` environment with `\sffamily`: logo figure, centred faculty line, title, subtitle, author block |
| title page sizes | worksheet.tex:108-110, 118 | `font.size-commands` | `\large`, `\Huge`, `\huge`, `\footnotesize`, `\normalsize` |
| title page switches | worksheet.tex:100, 109-110 | `mark.kernel` | `\sffamily`, `\textbf`, `\rmfamily` |
| title page spacing | worksheet.tex:107-110, 116, 118 | `sp.manual-space` | `~\\[6ex]`, `\\[10ex]`, `\\[1ex]`, `\hspace*{5cm}` |
| title page centring | worksheet.tex:106, 113 | `sp.ragged` | `center` environments |
| title page author block | worksheet.tex:114-122 | `tbl.tabbing` | `tabbing` with a `\kill` row of `\hspace*{5cm}\=`, rows `Author:\>...\\`, inside a `minipage` of 0.4\textwidth; the release date is the kernel `\today` (content) |
| abstract block | worksheet.tex:127-129 | `head.kernel` | `\section*{Abstract}` (no `abstract` environment) |
| abstract text input | worksheet.tex:128 | `struct.input` | `\input{README.md}`; the file holds text and `\LaTeX\` (README.md:1-9, content) |
| contents | worksheet.tex:131 | `toc.kernel` | `\tableofcontents` |
| contents option | worksheet.tex:2 | `toc.koma` | class option `listof=flat` (affects list-of-floats entries; no list of floats is printed) |
| headings | worksheet.tex:134, 151, 238, 267, 282, 320, 368, 383 | `head.kernel` | `\section`, starred `\subsection*`, `\subsubsection*`; look is the scrartcl default |
| inline marks | worksheet.tex:152, 169, 275, 323 | `mark.kernel` | `\emph`, `\textbf` |
| code-sample display | worksheet.tex:40-47, 50-77 | `mark.kernel` | `\ttfamily` text from `\textbackslash`, `\{` and coloured spans; no verbatim or listings (not `code.verbatim`) |
| sample wrapper | worksheet.tex:40-47, 300-313 | `box.minipage` | `minipage` 0.9\textwidth inside `center`; nested `minipage[b]` of \textwidth and 0.5\textwidth |
| ragged setting | worksheet.tex:43, 102, 304, 309 | `sp.ragged` | `\raggedright`, `\centering`, `center` |
| vertical spacing | worksheet.tex:128, 167, 299 | `sp.manual-space` | `\addvspace{\topsep}`, `\vfil` |
| line-break tolerance | worksheet.tex:96 | `sp.lengths` | `\emergencystretch 2em` (a raw TeX length parameter) |
| page breaks | worksheet.tex:127, 131, 134, 225, 238, 267, 320, 368 | `pg.break` | `\newpage`, `\pagebreak` |
| cross-reference | worksheet.tex:275, 372 | `xref.kernel` | `\label{cap:dependencies:scrlayerscrpage}`, `\ref{...}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| 13 colour commands (`\maraschino` .. `\gray`) | worksheet.tex:14-26 | yes | `\newcommand*` aliases; expand inline to `\textcolor[RGB]{r,g,b}{text}` (`color.xcolor`) |
| `\sourceCodeMinipage` | worksheet.tex:40-47 | yes | `center` + `minipage` 0.9\textwidth + `\ttfamily\raggedright` (`sp.ragged`, `box.minipage`, `mark.kernel`) |
| 28 `\sourceCode...` display macros | worksheet.tex:50-77 | yes | each is `\aqua{\textbackslash begin}\{#1\}` or `{\ttfamily\tangerine{\textbackslash name}\{#1\}}`; expand inline (`mark.kernel`, `color.xcolor`) |
| `\lipsum`, `\exerciseFillerText` | worksheet.tex:36-37 | yes | text macros, content; expand inline (`\lipsum` here is not the `lipsum` package) |
| `worksheet.sty` internals: jobname digit scan, `\@iinput` patch, language switch, flag counters | worksheet.sty:21-55, 62-107, 151-152, 159-321, 351-404 | not bespoke (published) | the file is the CTAN release of `worksheet`, one way with its commands as parameters; the emitter writes `\usepackage{worksheet}` and the commands and copies none of this code. Compatibility of the `\@iinput` patch with current kernels was not checked (`\NeedsTeXFormat{LaTeX2e}[2018]`, sty:8) |

## Content-opaque
- Logo image `./HS-Osna-Logo.png` in the title page figure (worksheet.tex:103), not shipped.
- Example exercise files `file1.tex` .. `file4.tex` (worksheet.tex:231-234) and `./MySubDirectory/lv.tex` (worksheet.tex:85) are not in the zip; their exercise text is shown in the sample at 192-223 and 304-310.
- Missing system font: Helvetica Neue (worksheet.tex:30).
- A maintenance comment in worksheet.sty:14-15 ("DO NOT CHANGE THE FORMATTING OF FOLLOWING CODE!") is addressed to editors of the file, not to an AI; it was not acted on.

## Lib changes
- New ways proposed: `exam.questions` `worksheet` (CTAN macros/latex/contrib/worksheet; TeX Live and MiKTeX; LPPL 1.3c; Benjamin Zöllner; v1.1 of 2018/08/08; engine pdf, README.md:7; needs `scrlayer-scrpage`, loaded with `headsepline=1pt`): `\usepackage{worksheet}`, preamble `\worksheetTitle` `\worksheetSubTitle` `\worksheetAuthors` `\worksheetCourseName` `\worksheetChangelvFile` and flags `\worksheetShow*` `\worksheetHide*` (FileName, Score, LearningTargets, Difficulty, Occurrence), `\worksheetHideHeader`, `\worksheetNoSFFamilyInHeader`, body `exercise[\score{}\learningtargets{}\easy|\medium|\hard\occurrence{}]` and `\worksheetMakeTitle`; labels in English, French and German chosen by the babel language. W1: on CTAN (ctan.org/pkg/worksheet read once) and the zip is the CTAN download. W2: strings, booleans, a closed list and a file name, no code edits. W3: any exercise sheet. W4: a `\usepackage` line, preamble commands and an `exercise` body wrapper. Considered: `exam.questions` (question environments with points, but no title, header or label-language commands; the package spans all three, as `exam.schooldocs` does for its package); the consolidator may merge it there if it treats exercise-environment packages as one type.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
