no

# 0090-exam-rtl: exam-rtl (Arabic/RTL exam package)

- Unverified: read from the source, not compiled.
- Source: Source/0090-exam-rtl/ (origin: https://mirrors.ctan.org/macros/latex/contrib/exam-rtl.zip; licence: LPPL 1.3c)
- Kind: exam
- Lib: v1
- Engine: needs XeLaTeX (`fontspec`, `polyglossia`, `bidi` are loaded unconditionally, exam-rtl.dtx:790-792; README.md:81 and exam-rtl.dtx:91 say pdfLaTeX and LuaLaTeX are not supported)
- Look carried by: preamble (the sample's preamble loads one published CTAN package, `exam-rtl`, which carries the whole exam look over kernel `article`; the zip holds that package only as `.dtx`/`.ins`, no zip-local class or style, and `example.tex` defines nothing itself)
- Class origin: tex-distribution-unbundled (`article`, not in the zip; the package `exam-rtl` itself is on CTAN, ctan.org/pkg/exam-rtl read once: v1.0, LPPL 1.3c)
- Main file: example.tex (other samples: exam-rtl-doc.tex; the ltxdoc driver at exam-rtl.dtx:16-33)
- Read: main yes, zip-local classes and styles all (no `.cls`/`.sty` in the zip; all of exam-rtl.dtx read, including the package code at 774-2005, which `exam-rtl.ins:32` extracts to `exam-rtl.sty`; exam-rtl-doc.tex read at 1-330 and 600-649 plus an outline grep of the rest; the two `.pdf` files are compiled output and were not read)

## Verdict
No. The look is carried by the CTAN package `exam-rtl` over `article`, and the sample adds only parameters, so it would count as one published, declarative, XeLaTeX-only way (`exam.rtl-questions`). What blocks it is the package's unconditional `\tcbuselibrary{all}` (exam-rtl.dtx:789). tcolorbox's `all` loads every tcolorbox library, `minted` among them, which needs shell escape and pygments; by the pilot ruling the document then does not compile without a tool outside TeX, even though the sample never prints code. That rests on tcolorbox's documented behaviour: tcolorbox is not in the zip and was not read here, so it is the one unverified step. Without it the answer would be yes, because the package's expl3 shuffling and answer-key logic is the internals of a published way, not zip-local bespoke code.

## Blockers
- `EXTERNAL/package` `\tcbuselibrary{all}` loaded unconditionally; tcolorbox's `all` pulls in the `minted` library (shell escape, pygments) and `external`; the sample uses neither (exam-rtl.dtx:789). Source of the claim: tcolorbox's documentation as I know it, not read in this run.

## Class setting
- Class: `class.article` options: `a4paper` (example.tex:1)
- Class-native vocabulary used: `center` environment (example.tex:22-24); no `\maketitle`, no abstract, no sectioning in the sample. The package's own vocabulary is listed in the map below.

## Component map
Rows marked (in package) are what `exam-rtl.sty` does internally; they are listed to show what an emitter would have to reproduce if it did not call the package. They do not add blockers beyond the one above.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | example.tex:1 | `class.article` | `a4paper` |
| paper size | example.tex:1 | `page.class-options` | `a4paper` |
| margins | example.tex:2 | `page.geometry` | `margin=2.5cm` |
| exam package | example.tex:3; exam-rtl.dtx:782 | `exam.rtl-questions` | `\usepackage{exam-rtl}`, no package options (none are declared) |
| output modes | example.tex:8-9, 11-15; exam-rtl.dtx:871-900 | `exam.rtl-questions` | `\StudentMode` (`\TeacherMode` commented out), `\ShowMarks`, `\ShowDifficulty`, `\ShowType`, `\ShowCorrection`, `\ExamID{1234}` (seed for the shuffles) |
| title line | example.tex:22-24 | `sp.ragged`, `font.size-commands`, `mark.kernel`, `sp.manual-space` | `center` env, `\Large`, `\bfseries`, `\par\vspace{1em}`; hand-set, no `\maketitle` |
| question wrapper | example.tex:30, 64, 73, 86, 128, 147, 158, 173, 186, 198; exam-rtl.dtx:972-1046 | `exam.rtl-questions` | `Question{type}{difficulty}{marks}{text}`: counter "سؤال n:" in Arabic-Indic digits, type/difficulty/marks tags on the left, answer box after it in teacher mode |
| multiple choice | example.tex:30-58; exam-rtl.dtx:1078-1216 | `exam.rtl-questions` | `MC[4]` columns, `\MCQuestion{text}{correct index}`, `\MCOption{...}`; options shuffled with the seed |
| true/false | example.tex:64-80; exam-rtl.dtx:1240-1299 | `exam.rtl-questions` | `TF` default `bracket`, and `TF[options]`; `\TFQuestion{statement}{answer}` |
| ordering | example.tex:86-122; exam-rtl.dtx:1336-1525 | `exam.rtl-questions` | `Ordering[5]`, `\OrderQuestion`, `\OrderOption`, `\OrderAnswer` |
| fill in the blank | example.tex:128-141; exam-rtl.dtx:1546-1630 | `exam.rtl-questions` | `FillBlank[true]` (word bank on), `\WordBank{comma list}`, `\FillQuestion{text with \Blank}{answer}`, `\Blank` and `\Blank[20mm]` |
| matching | example.tex:147-167; exam-rtl.dtx:1670-1790 | `exam.rtl-questions` | `Matching` (ratio 0.5) and `Matching[0.2]`, `\MatchPair{left}{right}`; left column shuffled |
| short answer | example.tex:173-180, 203-208; exam-rtl.dtx:1895-1956 | `exam.rtl-questions` | `ShortAnswer[true]`, `\ShortQuestion[0]{q}{a}` and `[1]` |
| essay | example.tex:186-192; exam-rtl.dtx:1813-1871 | `exam.rtl-questions` | `Essay[true]` ruled lines, `\EssayQuestion{q}{a}` and `[3]`, `[4]` line counts |
| reading passage | example.tex:198-209; exam-rtl.dtx:1961-1998 | `exam.rtl-questions` | `ReadingPassage{title}` followed by other question types inside the same `Question` |
| language and digits (in package) | exam-rtl.dtx:791, 799-800, 808 | `lang.polyglossia` | `\setmainlanguage{arabic}`, `\setotherlanguages{english}`, `\textarabic{\arabicdigits{..}}` |
| fonts (in package) | exam-rtl.dtx:790, 801-803 | `font.fontspec` | `\newfontfamily\arabicfont[Script=Arabic,BoldFont={* Medium}]{IBM Plex Sans Arabic}`, same for sans, mono `Cascadia Code-SemiLight`; fonts not shipped |
| direction switch (in package) | exam-rtl.dtx:792, 1978-1979 | `lang.bidi` | `bidi` loaded; `\begin{RTL}` before the reading passage text |
| answer-key box (in package) | exam-rtl.dtx:925-963 | `box.tcolorbox` | `enhanced, breakable, colback=white, colframe=black, arc=0pt, boxrule=1pt, top/bottom/left/right=10pt`, boxed title to top right |
| passage box (in package) | exam-rtl.dtx:1964-1993 | `box.tcolorbox` | same keys, boxed title to top center, `fontupper=\linespread{1.4}` |
| tcolorbox libraries (in package) | exam-rtl.dtx:789 | `box.tcolorbox` | `\tcbuselibrary{all}`; the blocker above |
| word-bank frame (in package) | exam-rtl.dtx:1579-1591 | `box.fancybox`, `box.minipage` | `\fbox` around a `minipage` |
| matching columns (in package) | exam-rtl.dtx:1713-1754 | `cols.minipage` | two top-aligned `minipage`s, `\raggedleft` |
| rules and blanks (in package) | exam-rtl.dtx:809, 1597, 1600, 1853, 1941 | `sp.rule` | `\rule{..}{0.4pt}`, `\underline{\hspace{..}}`, `\hrulefill`, `\vrule` strut |
| line spacing (in package) | exam-rtl.dtx:941, 1977 | `sp.linespread` | `\linespread{1.3}` and `{1.4}`; `\baselineskip` scaling 1.3 elsewhere |
| answer arrows (in package) | exam-rtl.dtx:1196 and others | `math.kernel` | `$\;\Leftarrow\;$` |
| doc sample: class, page | exam-rtl-doc.tex:1-3 | `class.article`, `page.class-options`, `page.geometry` | as example.tex |
| doc sample: links, lists | exam-rtl-doc.tex:4-6 | `list.enumitem`, `meta.hyperref` | `enumitem` load only; `colorlinks=true, linkcolor=blue` |
| doc sample: fonts | exam-rtl-doc.tex:8-10 | `font.fontspec` | `\setmainfont[BoldFont={* Medium}]{IBM Plex Sans}`, sans the same, `\setmonofont{Cascadia Code-SemiLight}` |
| doc sample: paragraph shape | exam-rtl-doc.tex:18-19 | `sp.lengths` | `\parindent=0pt`, `\parskip=0.4\baselineskip` |
| doc sample: section numbers | exam-rtl-doc.tex:12-16 | `num.counters` | `\renewcommand{\thesection}{\arabic{section}}`, subsection numbers wrapped in `\LR{}` |
| doc sample: toc, headings, lists | exam-rtl-doc.tex:40, 43, 50-57, 78 | `toc.kernel`, `head.kernel`, `list.kernel` | `\tableofcontents`, `\section`, `\subsection*`, `\paragraph*`, `itemize`/`enumerate` |
| doc sample: direction switches | exam-rtl-doc.tex:14-15, 129-156 (74 lines use `\RL{}`) | `lang.bidi` | `LTR` environment, `\LR{}`, `\RL{}` |
| doc sample: code listings | exam-rtl-doc.tex:147-155 | `code.verbatim` | `\verb|...|` inside `LTR` with `\ttfamily` |
| doc sample: english spans | exam-rtl-doc.tex:21-22 | `lang.polyglossia`, `mark.kernel` | `\textenglish{\textsf{..}}`, `\textenglish{\texttt{..}}` |
| ltxdoc driver | exam-rtl.dtx:18-31 | `class.ltxdoc` | `\EnableCrossrefs`, `\RecordChanges`, `\OnlyDescription`, `\DocInput`; loads `xcolor`, `tcolorbox` (skins, breakable), `enumitem`, `hyperref[hyperindex=false]` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `exam-rtl.sty` as a whole | exam-rtl.dtx:774-2005 (generated by exam-rtl.ins:32) | n/a, published on CTAN | counted as the way `exam.rtl-questions`; not bespoke under W1 |
| seeded shuffling of options, items and pairs | exam-rtl.dtx:894-920, 1138, 1418, 1709 | irreducible by lib ways | inside the published package; would be `BESPOKE/package` if the package were not accepted as a way |
| answer-key collection into `\g__question_answer_tl` and the key box | exam-rtl.dtx:839, 1040-1044, 1191, 1289, 1514-1524 | irreducible by lib ways | same as above |
| measured layout (widths from `\settowidth`, option grids, ragged padding cells) | exam-rtl.dtx:995-1036, 1150-1216, 1568-1591 | irreducible by lib ways | same as above |
| `\ArNum`, `\arbstrut` | exam-rtl.dtx:808-809 | reducible | `lang.polyglossia` Arabic digits; a zero-width `\vrule` strut (`sp.rule`) |
| `\FullBlank` (defined, never used by the sample) | exam-rtl.dtx:1599 | reducible | `\hrulefill` (`sp.rule`) |
| `\engsf`, `\engtt` | exam-rtl-doc.tex:21-22 | reducible | `lang.polyglossia` `\textenglish` plus `mark.kernel` `\textsf`/`\texttt` |
| `\thesection`, `\thesubsection`, `\thesubsubsection` redefinitions | exam-rtl-doc.tex:12-16 | reducible | `num.counters` with `\LR{}` from `lang.bidi` |
| example.tex | whole file | none defined | no `\newcommand`, `\def`, counters or environments |

## Content-opaque
none (the sample has no figure, table, TikZ or image; the Arabic questions, word bank and answers are content).

## Lib changes
- New ways proposed:
  - `exam.rtl-questions` | `exam-rtl` (CTAN), XeLaTeX only | typed `Question{type}{difficulty}{marks}{text}` wrapper, `MC` `TF` `FillBlank` `Ordering` `Matching` `Essay` `ShortAnswer` `ReadingPassage` environments, student/teacher mode switches, `\ExamID` seed, answer-key boxes; Arabic labels fixed in the package. W1: on CTAN (ctan.org/pkg/exam-rtl, v1.0, LPPL 1.3c). W2: behaviour is chosen by environment and command arguments (columns, `bracket`/`options`, `true`/`false`, ratio, line counts, seed) and mode switches; the sample edits no code. W3: serves any exam content, not one document. W4: preamble `\usepackage{exam-rtl}` plus mode lines, and body wrappers `\begin{Question}{..}..\end{Question}` around question nodes. It could be folded into `exam.questions` (the way for `exam`/`examdesign`), but that way is tagged `pdf` and this one needs XeLaTeX, so a separate id keeps the engine tag true, as `lang.polyglossia` does beside `lang.babel`.
  - `lang.bidi` | `bidi` (CTAN), XeLaTeX/LuaLaTeX | right-to-left and left-to-right switches `RTL`/`LTR` environments, `\RL{}`, `\LR{}`, used in the package (exam-rtl.dtx:1978) and in the doc sample body (exam-rtl-doc.tex:14, 129-156). W1: CTAN package. W2: direction chosen by environment or command, no code edited. W3: any mixed-direction text. W4: body wrappers around a node's content, package line in the preamble. Section: lang, meta, xref.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
