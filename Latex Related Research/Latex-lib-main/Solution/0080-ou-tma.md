yes

# 0080-ou-tma: OU TMA

- Unverified: read from the source, not compiled.
- Source: Source/0080-ou-tma/ (origin: https://latextemplates.com/downloads/ou-tma.zip; licence: LPPL-1.3c)
- Kind: assignment
- Lib: v1
- Engine: pdfLaTeX-compatible (README.md:17 builds with `pdflatex`; expl3 is used only for token-list storage; no fontspec, no Lua)
- Look carried by: preamble (a published CTAN package `ou-tma` vendored as `ou-tma.sty` is loaded with options at main.tex:4; the sample adds only option and metadata settings)
- Class origin: ctan
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
The zip is the CTAN package `ou-tma` (one read of https://ctan.org/pkg/ou-tma: "A package to aid in the writing of Tutor Marked Assessments for the Open University", Geoff Riley, LPPL 1.3c; the CTAN version number was not compared with the vendored v1.21) on top of kernel `article`. It passes W1 to W4 as one package way, and it also decomposes completely into lib ways (geometry, fancyhdr, lastpage, counters, hyperref bookmarks, amsmath/amsthm, kernel boxes and spacing), so the answer does not depend on treating it as published. There is no artwork, no external tool, no irreducible code: the expl3 part only stores five strings, and every conditional is resolved at emit time because the document model knows the question index and the options.

## Blockers
none

## Class setting
- Class: `class.article` options: a4paper, 12pt (main.tex:1). Kernel class, not bundled, source not read.
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (set by the package, main.tex:12); no `abstract`, no `\section`.
- Look-carrying file: `ou-tma.sty` (341 lines, all read) is a docstrip-generated copy of the CTAN package `ou-tma` v1.21 2025-09-30 (ou-tma.sty:1-23). Package options (ou-tma.sty:131-148): `roman` `alph` `cleveref` `pdfbookmark` `legacy`; the sample passes `roman,pdfbookmark` (main.tex:4). Package commands the sample uses: `\myname` `\mypin` `\mycourse` `\mytma` (main.tex:6-9), environment `question[n]`, `\qpart[n]`, `\qsubpart[n]`, and maths helpers `\deriv` `\e`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | a4paper, 12pt |
| paper and size | main.tex:1 | `page.class-options` | a4paper, 12pt |
| page geometry | ou-tma.sty:80, 87-97 | `page.geometry` | headheight=10mm, headsep=5mm, bottom=25mm, footskip=15mm, left=30mm, right=30mm, marginparwidth=0mm, marginparsep=0mm, includemp |
| geometry for margin notes | ou-tma.sty:101-108 (`\marginnotes`, not called by the sample) | `page.geometry` | marginparwidth=40mm, marginparsep=5mm, left=20mm, right=15mm |
| margin note | ou-tma.sty:100 (`\marginnote` = `\marginpar{#1}`, not used by the sample) | `note.marginpar` | none |
| header | ou-tma.sty:79, 330-335 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, head L `\name\ \pin`, C `\course\ TMA-\tma`, R `Page \thepage\ of <LastPage>`, `\headrulewidth`=0pt, footer empty |
| header font | ou-tma.sty:332-334 | `mark.kernel` | `\textrm` on all three header fields |
| page X of Y | ou-tma.sty:76, 130, 207, 334 | `pgnum.lastpage` | `lastpage`, label `LastPage`; `\pageref`, or `\pageref*` when `pdfbookmark` is on |
| paragraph spacing | ou-tma.sty:325-326 | `sp.lengths` | `\parindent`=0pt, `\parskip`=2ex plus 0.3ex minus 0.2ex |
| fonts | no font package anywhere | none | default Computer Modern; no `font.*` way is needed |
| title block | ou-tma.sty:61-62, 66; main.tex:6-9, 12 | `front.maketitle` | `\title{\textbf{TMA: <course>-<tma>}}`, `\author{\textbf{<name> <pin>}}`, `\date{\today}`; metadata strings are content |
| date format | ou-tma.sty:82-83, 66 | `front.datetime` | `isodate` with option UKenglish, `\cleanlookdateon`; `\date{\today}` (package is the parameter, see Lib changes) |
| question block | ou-tma.sty:223-232; main.tex:14, 42, 57 | `exam.questions` | package `ou-tma`; `question` env with optional start number; label "Q n" hung in the left margin; `\vspace{3em}` after (package is the parameter, see Lib changes) |
| part and subpart markers | ou-tma.sty:234-251; main.tex:15, 34, 58, 67 | `exam.questions` | `\qpart[n]`, `\qsubpart[n]`; labels `(i)` and `(a)` with `roman`, `(a)` and `(i)` with the default |
| question counters | ou-tma.sty:111-114, 125-126, 174-180 | `num.counters` | `\newcounter{question}`, `{qpart}[question]`, `{qsubpart}[qpart]`; `\thequestion`=arabic; `\theqpart`, `\theqsubpart` = roman/alph by option |
| counter arithmetic | ou-tma.sty:81, 224, 235, 244 | `num.counters` | `calc` in `\setcounter{question}{#1-1}` for the `[n]` argument |
| equation numbering | ou-tma.sty:324 | `math.amsmath` | `\numberwithin{equation}{question}` |
| footnote marks | ou-tma.sty:323 | `fn.kernel` | `\thefootnote` = `\fnsymbol{footnote}` (no footnote in the sample) |
| manual label geometry | ou-tma.sty:228-229, 240, 250 | `sp.manual-space` | `\makebox[0em][r]`, `\makebox[0pt][r]`, `\makebox[2em][l]`, `\hspace{0.3em}`, `\hspace{1.5em}`, `\hspace{-2em}`, `\vspace{3em}` |
| label size | ou-tma.sty:228, 240, 250 | `font.size-commands` | `\large` |
| PDF bookmarks | ou-tma.sty:194, 208-210, 226-227, 237-238, 246-247 | `meta.hyperref` | `\pdfbookmark[level]{text}{name}` per question (0), part (1), subpart (2); active only with `pdfbookmark` |
| hyperref options | ou-tma.sty:181-195 | `meta.hyperref` | `[pdfencoding=unicode,psdextra]`; `\hypersetup{colorlinks=true, linkcolor=blue, urlcolor=blue, pdfstartview=FitH, pdftitle, pdfauthor, pdfkeywords, pdfsubject}` |
| cleveref names | ou-tma.sty:197-204, 217-221 (option `cleveref`, not used by the sample) | `xref.cleveref` | `\crefname` for question, qpart, qsubpart; `\refstepcounter` instead of `\stepcounter` |
| theorem-like | ou-tma.sty:71, 315-316 | `thm.amsthm` | `\newtheorem{lemma}{Lemma}`, `\newtheorem{theorem}{Theorem}`, default plain style (no statement in the sample) |
| qed symbol | ou-tma.sty:72, 317-319; main.tex:32 | `thm.amsthm` | `\qedsymbol` renewed to `\blacksmiley`; the glyph comes from `wasysym` (`math.amssymb`, symbol package as parameter) |
| display maths | main.tex:17-19, 27-30, 44-46, 51-53 | `math.amsmath` | `\[ \]` display, `pmatrix`; content |
| maths operators | ou-tma.sty:69, 288-297, 300-305 | `math.amsmath` | `\DeclareMathOperator` x10 (Re Im Log Arg Wnd Res Ker Orb Stab Fix); `\frac`, `\partial` |
| maths alphabets | ou-tma.sty:70, 73-74, 261-267 | `math.amssymb` | `amssymb` for `\mathbb`; `upgreek` loaded with no use in the file (nearest home `math.bm`) |
| bold maths | ou-tma.sty:73, 272 | `math.bm` | `bm` loaded; `\ve` uses `\textbf` |
| text marks | main.tex:22, 25; ou-tma.sty:272, 275-278 | `mark.kernel` | `\emph`, `\textbf`, `\textsuperscript` |
| end-of-proof fill | main.tex:32 | `sp.manual-space` | `\hfill\qed` |
| graphics | ou-tma.sty:75 | `fig.graphicx` | load only; no figure in the sample |
| verbatim | ou-tma.sty:78 | `code.verbatim` | load only; unused |
| not present | n/a | none | abstract, contents, headings (`\section` is never called), lists, tables, captions, code listings, boxes, bibliography, index, language package, colour package |

## Bespoke code
(Treated as published CTAN internals; the reduction is given so the verdict does not depend on that.)
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| expl3 string store and setters `\myname` `\mytma` `\mycourse` `\mypin` `\setdate` | ou-tma.sty:32-60 | yes | `\tl_new:N` and `\tl_gset:Nn` only hold five strings, no layout computation; the emitter substitutes the strings into `\title`, `\author` and the header fields |
| preset `\title`, `\author`, `\setdate{\today}`, `\setquestionstring{Q}` | ou-tma.sty:61-66, 213 | yes | `front.maketitle` with the strings written out; "Q" is a literal in the label |
| option booleans, `\DeclareOption`, `\typeout` logging | ou-tma.sty:116-171 | yes | options are static at emit time, so the emitter writes only the chosen branch; `\typeout` prints to the log, not the page |
| counters and their `\the` formats | ou-tma.sty:111-114, 125-126, 174-180 | yes | `num.counters`: `\newcounter` x3 and `\renewcommand\thequestion`, `\theqpart`, `\theqsubpart` (roman or alph chosen by the option) |
| `question` environment | ou-tma.sty:223-232 | yes | begin: `\setcounter{question}{n-1}` only when `[n]` is given, `\stepcounter{question}`, `\pdfbookmark[0]{Question n}{questionn}`, `\makebox[0em][r]{\large Q~n\hspace{0.3em}}\par`; end: `\par\vspace{3em}` |
| `\qpart` | ou-tma.sty:234-241 | yes | `\setcounter` when `[n]`, `\stepcounter{qpart}`, `\pdfbookmark[1]`, `\par`, `\makebox[0pt][r]{\large(label)\hspace{1.5em} }` |
| `\qsubpart` | ou-tma.sty:243-251 | yes | same pattern with `\pdfbookmark[2]` and `\hspace{-2em}\makebox[2em][l]{\large(label)}`; `\ifthenelse{\value{qsubpart}>1}{\par}{}` is a first-subpart test the emitter resolves from the item's index (emit `\par` unless it is the first), so no conditional is copied |
| maths aliases (`\dd` `\e` `\ii` `\N` `\Z` `\Q` `\R` `\Complex` `\Rr` `\vect` `\ve` `\st` `\nd` `\rd` `\nth` `\rect` `\comb` `\perm` `\deriv` `\pderiv` `\psderiv`) and operators | ou-tma.sty:256-305 | yes | `\newcommand` aliases over amsmath/amssymb (`\mathrm`, `\mathbb`, `\overrightarrow`, `\frac`, `\textsuperscript`); operators are `\DeclareMathOperator` |
| `\marginnote`, `\marginnotes` | ou-tma.sty:100-108 | yes | `note.marginpar` and one `page.geometry` call (not exercised by the sample) |
| qed symbol | ou-tma.sty:317-319 | yes | `\renewcommand{\qedsymbol}{\blacksmiley}` with `wasysym` (the `\ProvideDocumentCommand` with `\unicode{263B}` is only a fallback) |
| footnote symbols | ou-tma.sty:323 | yes | `\renewcommand{\thefootnote}{\fnsymbol{footnote}}` |
| indirections `\tma@pageref` `\tma@stepcounter` `\tma@crefname` `\tma@bookmark` | ou-tma.sty:127-130, 202-210 | yes | each is `\relax` or one published command swapped by option; the emitter writes the chosen command (`\pageref*`, `\refstepcounter`, `\crefname`, `\pdfbookmark`) |
| `legacy` option macros (`\vec`, `\C`) | ou-tma.sty:307-311 | yes | two `\renewcommand` aliases; the option is off in the sample |

## Content-opaque
none (the sample has no figure, table or drawing; the induction proof, the ODE and the matrix are text and equations)

## Lib changes
- New ways proposed: none
- Folds I made, for the consolidator to check (no new id proposed): (1) `front.datetime` carries `isodate` (UKenglish, `\cleanlookdateon`); the lib line names `datetime`/`datetime2`, same job, package as parameter, as `font.helvet` was folded into `font.helvet`. (2) `exam.questions` carries the `ou-tma` question/part/subpart markers; the lib line names `exam`/`examdesign` question environments, same component. If it is judged too far from exam, the decomposition in "Bespoke code" (`num.counters`, `sp.manual-space`, `meta.hyperref`) still holds, so the verdict is unchanged. (3) `sp.manual-space` carries `\makebox[w][r]` hanging labels beside `\raisebox` and `\hspace`; there is no `\makebox` line in the lib. (4) `wasysym` and `upgreek` are load-only symbol packages placed under `math.amssymb` and `math.bm`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
