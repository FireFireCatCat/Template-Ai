yes

# 0827-exercise-worksheet-class: Exercise Worksheet Class

- Unverified: read from the source, not compiled.
- Source: Source/0827-exercise-worksheet-class/ (origin: https://latextemplates.com/downloads/worksheet-kryzar.zip, upstream https://github.com/kryzar/worksheet per README.md:29; licence: GPL-3.0)
- Kind: assignment
- Lib: v6
- Engine: pdfLaTeX-compatible (README.md:19 builds with `pdflatex main`; no fontspec, no Lua)
- Look carried by: zip-local (worksheet.cls defines the running head, the exercise/solution theorem environments, the nested question lists and the solution colour; main.tex only sets five string fields and the `solutions` option)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (worksheet.cls, 120 lines, read in full; main.tex, 76 lines, read in full)

## Verdict
yes. `worksheet.cls` is `\LoadClass[11pt]{article}` (worksheet.cls:3) plus eight published packages (worksheet.cls:4-11) and a few macros (worksheet.cls:19-120). Every macro reduces to kernel, `amsthm`, `enumitem`, `fancyhdr`, `lastpage` and `xcolor` calls with fixed parameters, as written under "Bespoke code". There is no artwork, no output-routine or kernel redefinition, and no tool outside TeX.
The weakest point is the boolean `\ifshowsolutions` (worksheet.cls:19-23, 45, 110). It does drive what is printed, a solution block and the running-head word. I treat it as a two-valued document variant that the emitter resolves when it writes the file (the sample selects "show", main.tex:1), not as layout logic. Mid-document use of `\showsolutions`/`\hidesolutions` (worksheet.cls:119-120) is not in the sample and not in the README (README.md:21-25). Because `\rhead` is evaluated at each page's output, a document that used them would make the head word follow the switch page by page, and a static emitter would not copy that.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (fixed inside the zip-local class, worksheet.cls:3); no paper option, so article's default paper. The zip-local class `worksheet` is not on CTAN (README.md:12-14; ctan.org/pkg/worksheet read: a different package, Benjamin Zöllner, LPPL 1.3c, `exercise` environment over `scrlayer-scrpage`, which the lib already records under `exam.questions`), so `class.worksheet` is not a published class; it reduces to `class.article` plus the preamble below.
- Class-native vocabulary used (zip-local, so reduced rather than recorded as a published class): option `solutions` (main.tex:1; declared at worksheet.cls:21, `nosolutions` at :22; `\ProcessOptions\relax` at :23 passes nothing on to article); string commands `\coursename` `\semester` `\weeknumber` `\worksheetnumbertotal` `\worksheetnumber` (main.tex:5-9; defined worksheet.cls:33-37); environments `exercise`, `solution`, `questions`, `answers` and commands `\question`, `\answer` (main.tex:13, 19, 29, 31, 57, 59).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | worksheet.cls:3; main.tex:1 | `class.article` | `11pt`; `solutions` is a boolean of the zip-local wrapper, resolved by the emitter |
| paper and size | worksheet.cls:3 | `page.class-options` | `11pt` |
| page geometry | worksheet.cls:8 | `page.geometry` | load-only: `\RequirePackage{geometry}` with no options and no `\geometry` call anywhere in the zip (grep over *.tex, *.cls) |
| fonts | worksheet.cls:10 | `font.lmodern` | `\RequirePackage{lmodern}`, no options |
| colours | worksheet.cls:11, 107, 111, 115 | `color.xcolor` | `\definecolor{solutioncolor}{rgb}{0.0,0.18,0.65}`; named `gray`; `\color{solutioncolor}` ... `\color{black}` |
| header and footer style | worksheet.cls:7, 30, 40, 47 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\renewcommand{\headrulewidth}{0pt}` |
| left head | worksheet.cls:41; main.tex:6 | `hf.fancyhdr` | `\lhead{\textcolor{gray}{<semester>}}` (string "Fall 2026") |
| centre head | worksheet.cls:42-44; main.tex:5, 7-9 | `hf.fancyhdr` | `\chead{\textcolor{gray}{<course>. Week <n>. Worksheet <n>/<total>.}}` (strings from main.tex:5, 7, 8, 9) |
| right head (variant word) | worksheet.cls:45 | `hf.fancyhdr` | `\rhead{\textcolor{gray}{Solutions}}` when `solutions` (main.tex:1), `Exercises` otherwise; the word is chosen when emitting |
| centre foot, page X of Y | worksheet.cls:9, 46 | `hf.fancyhdr` + `pgnum.lastpage` + `xref.kernel` | `\cfoot{\textcolor{gray}{\thepage/\pageref{LastPage}}}`; `lastpage` load-only |
| head and foot text colour | worksheet.cls:41-46 | `color.xcolor` | `\textcolor{gray}{...}` |
| exercise statement | worksheet.cls:4, 63-64, 102; main.tex:13-17, 25-48 | `thm.amsthm` | `\theoremstyle{definition}`, `\newtheorem{exercise}{Exercise}`: own counter, no `within` |
| solution statement | worksheet.cls:63-64, 103, 109-117; main.tex:19-23, 50-74 | `thm.amsthm` + `color.xcolor` | `\newtheorem{solutionthm}{Solution}` (definition style, own counter); wrapper `{\color{solutioncolor}\begin{solutionthm}...\end{solutionthm}}` written only when solutions are shown |
| sub-question and sub-answer numbering | worksheet.cls:68-71, 102-103 | `num.counters` | `\newcounter{question}[exercise]`, `\renewcommand{\thequestion}{\theexercise.\arabic{question}}`; `\newcounter{answer}[solutionthm]`, `\renewcommand{\theanswer}{\thesolutionthm.\arabic{answer}}` |
| `questions` and `answers` lists | worksheet.cls:5, 75-83; main.tex:29-36, 41-46, 57-72 | `list.enumitem` + `list.kernel` | `\begin{enumerate}[leftmargin=0pt, label=\textbf{\thequestion}]` then `\setcounter{enumi}{\value{question}}` (the same with `answer`) |
| item command | worksheet.cls:86-89; main.tex:31, 33, 43, 59, 62, 66 | `num.counters` + `list.kernel` | `\stepcounter{question}` then `\item` (inlined, or kept as a `\newcommand` alias) |
| bold item label | worksheet.cls:78 | `mark.kernel` | `\textbf{...}` |
| maths | main.tex:3, 15, 21, 31, 44 | `math.amsmath` | `\usepackage{amsmath}` (the class loads `amsthm` itself, worksheet.cls:4); formulas are content |
| language | main.tex:2 | `lang.babel` | `english` |

Not used by the sample and not defined by the class: title block, abstract, sectioning commands (article defaults, never called), contents, floats, tables, code, bibliography, index.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\CreateWorksheetEnvironment{#1}{#2}{#3}` generator (builds names with `\csname`/`\expandafter`) | worksheet.cls:56-90; called at :102, :103 | yes | It is a name-parameterised wrapper over kernel and published commands. Expand it inline for its two calls: `\theoremstyle{definition}\newtheorem{exercise}{Exercise}` (`thm.amsthm`), `\newcounter{question}[exercise]` and `\renewcommand{\thequestion}{\theexercise.\arabic{question}}` (`num.counters`), the enumitem list above (`list.enumitem`), `\stepcounter{question}\item` (`num.counters`, `list.kernel`); same with `solutionthm`/`answer`. The counters are ordinary kernel counters and print in no way beyond `\the...` formats. Line ends inside the macro body (e.g. worksheet.cls:69-71, 76-79) are not commented out, so stray spaces in labels are possible; this is unverified and the emitter writes the intended label. |
| `\newif\ifshowsolutions`, `\DeclareOption{solutions}`, `\DeclareOption{nosolutions}`, `\ProcessOptions\relax` | worksheet.cls:19-23 | yes | One boolean selecting between two fixed outputs; no layout is computed. The emitter writes the chosen branch: with `solutions`, the solution blocks and `Solutions` in `\rhead`; with `nosolutions`, it drops the solution nodes and writes `Exercises`. No class option reaches article. |
| `\NewEnviron{solution}` (`environ`) with `\ifshowsolutions` | worksheet.cls:6, 109-117 | yes | `environ` has no printed effect here; it only collects the body so that it can be dropped. Reduction: `{\color{solutioncolor}\begin{solutionthm}<body>\end{solutionthm}}` or nothing. Considered: `environ`, `comment` (`\excludecomment`/`\specialcomment` are a published form of the same show/hide); neither is needed as a way. |
| `\showsolutions`, `\hidesolutions` | worksheet.cls:119-120 | yes for the sample | Aliases that set the boolean mid-document; unused in main.tex. The emitter keeps or drops each solution node; see the caveat in the Verdict about the per-page head word. |
| `\coursename`, `\semester`, `\weeknumber`, `\worksheetnumbertotal`, `\worksheetnumber` (`\def\@...` storage) | worksheet.cls:33-37, used :41-45; values main.tex:5-9 | yes | String storage; inline the five values into `\lhead` and `\chead`. |
| `worksheet.cls` as a whole | worksheet.cls:1-120 | yes | `\documentclass[11pt]{article}` + `amsthm`, `enumitem`, `fancyhdr`, `geometry`, `lastpage`, `lmodern`, `xcolor` + the preamble lines in the map above. |

## Content-opaque
none (inline formulas in main.tex:15, 21, 31, 44, 59-70 are content; no float, picture or table).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
