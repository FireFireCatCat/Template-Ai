yes

# 0244-esami: esami (exam construction package, starter exam)

- Unverified: read from the source, not compiled.
- Source: Source/0244-esami/ (origin: https://latextemplates.com/downloads/esami.zip; licence: LPPL)
- Kind: exam
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:22 builds with `pdflatex main`; nothing in the loaded files needs XeLaTeX or LuaLaTeX)
- Look carried by: mixed (the published package `esami` carries the exam look: esami.sty plus its option-selected files esami-xyz.cfg and es-UKenglish.lng; main.tex sets options, strings and the version loop)
- Class origin: tex-distribution-unbundled (`article`, not in the zip; esami.sty is a vendored copy of the CTAN package, header v2.8 at esami.sty:58, CTAN lists v2.9 2024-07-03, TeX Live and MiKTeX)
- Main file: main.tex (other samples: mcq-dice.tex, mcq-median.tex, problem-stderr.tex, problem-coinflip.tex; these are question-bank files that main.tex pulls in with `\esercizi`, not documents)
- Read: main yes, zip-local classes and styles all (esami.sty 2295 lines, esami-xyz.cfg 357, es-UKenglish.lng 66; `random.tex`, `fp`, `currfile`, `xargs`, `environ` are not bundled and were not read)

## Verdict
yes. The look is carried by `esami`, a package published on CTAN and in TeX Live (one ctan.org/pkg/esami read), and the sample only passes options, strings and calls to its documented commands; I propose it as `exam.questions`. The zip-local parts (the patched esami-xyz.cfg, the language file, the main.tex strings and driver loop) are compositions of lib ways or no-op hooks, each reduced below, and there is no artwork and no tool outside TeX. Judgement call, flagged: main.tex drives the versions with a TeX loop and a seed formula (main.tex:51-55); I count it as calls to published macros (ifthen, fp, esami), not as zip-local macro logic.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `english` (main.tex:30; `english` is also handled by esami, esami.sty:73, which reads es-UKenglish.lng)
- Class-native vocabulary used: `\date` (main.tex:40), `\section*` (main.tex:60, 69; esami redefines `\section`, esami.sty:1723), `\newpage` (main.tex:68, 76), `\setcounter{page}` (main.tex:77), `\pagestyle` (main.tex:49), `itemize` and `\item` (esami-xyz.cfg:133-136)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:30 | `class.article` | a4paper, english |
| exam package and options | main.tex:32; esami.sty:101,108,117,119,121 | `exam.questions` | shuffle, xyz (option name read as file `esami-<name>.cfg`, esami.sty:121), pointsonright, nosolutions, noquizsolutions; defaults stay (`allowrandomize` esami.sty:96-98) |
| esami UI strings and date format | es-UKenglish.lng:3-17,45-56; esami.sty:73,738-741 | `exam.questions` | language file chosen by the `english` option: point/points, Exercise, Solution, Prof., Version, Page, Last Name...; `\longdate` prints the `\date` string as "14th October 2026" (lng:45-55) |
| language | main.tex:30,42; es-UKenglish.lng:61 | `lang.babel` | `english` global option; `\usepackage{babel}` loaded by the language file at end of esami and again in main.tex |
| page geometry | es-UKenglish.lng:62-63 | `page.geometry` | a4paper, lmargin=6mm, rmargin=18mm, tmargin=6mm, bmargin=18mm, marginparsep=2mm, footskip=1cm |
| page geometry (package defaults) | esami.sty:195-203 | `page.setlength` | topmargin=-90pt, textheight=paperheight-80pt, textwidth=paperwidth-70pt, oddsidemargin=-60pt, footskip=28pt, marginparwidth=0pt, marginparsep=0pt; set before the geometry call, which is loaded at end of package (lng:60-63) |
| encoding | main.tex:34-35 | `font.fontenc-t1` | T1; utf8 inputenc; textcomp (main.tex:36) |
| text face | main.tex:36 | `font.lmodern` | `lmodern` |
| font switches | esami-xyz.cfg:74,132; esami.sty:378,733 | `mark.kernel` | `\bfseries\sffamily` title block, `\sffamily\textbf{INSTRUCTIONS}`, `\scshape` exercise label, `\emph` points hook |
| font sizes | esami-xyz.cfg:74; esami.sty:635,1728 | `font.size-commands` | `\small` title block and points text, `\Large` section titles |
| alignment | esami.sty:1357,1728 | `sp.ragged` | `\centering` section titles; `\raggedright` inside answer items |
| spacing lengths | esami.sty:240,251,253,1280-1283 | `sp.lengths` | parindent=0pt; tabcolsep and arraycolsep +2pt; answers skip 6pt; question list topsep/itemsep 3pt, parsep 0pt |
| manual spacing | esami-xyz.cfg:78,82; esami.sty:639-640 | `sp.manual-space` | `\\[4ex]` and `\\[3ex]` in the title table; `\hspace*`, `\raisebox{-.5\height}` for the points box |
| rules | esami.sty:644,656 | `sp.rule` | `\vrule height20pt width0pt` strut in the points box |
| title block (candidate and exam fields) | esami-xyz.cfg:73-85; main.tex:57 | `tbl.tabular` | `|lp{.33\textwidth}|lp{.3\textwidth}|lp{.3\textwidth}|`, `\multicolumn`, `\hline`, in `center`; fields `\examname` `\Data` `\profname` `\studsignname` `\studlastname` `\studfirstname` `\studid` |
| exam date | main.tex:40-41 | `front.maketitle` | `\date{2026/10/14}` (the `YYYY/MM/DD` form esami parses, esami.sty:732,740) |
| footer definition | esami-xyz.cfg:98-101 (branch for `nosolutions`; the other branch is cfg:92-96) | `hf.fancyhdr` | reduction of `\def\ps@esame` with `\@oddfoot`: empty head, centred foot `\textbf{Version n. \thevers -- Page \thepage}` |
| page style call | main.tex:49 | `hf.pagestyle-kernel` | `\pagestyle{esame}` |
| page numbers | esami.sty:721-723; main.tex:77 | `pgnum.pagenumbering` | `\setcounter{page}{1}` at the end of each version |
| page breaks | main.tex:68,76; esami.sty:723 | `pg.break` | `\newpage` |
| instructions block | esami-xyz.cfg:131-140; main.tex:58,70 | `list.kernel` | `itemize` with three items (cfg:133-137) |
| instructions frame | esami-xyz.cfg:139-140 | `box.fancybox` | `\framebox`, `\fboxsep`=1.5ex, `\fboxrule`=1.2pt; same way for `\fillin[b]` box (esami.sty:682) |
| boxed text width | esami-xyz.cfg:140; esami.sty:641,686 | `box.minipage` | `\parbox{\textwidth}`; `\parbox{40pt}` in the points box; `\parbox[b][.8\height][b]{#2}` in `\fillin` |
| section headings | main.tex:60,69; esami.sty:1723-1728 | `head.kernel` | `\@startsection{section}{1}{0mm}{-\baselineskip}{0.5\baselineskip}{\sffamily\Large\centering}`, used starred; reducible to `head.titlesec` |
| counters and labels | esami.sty:299-304,324-328,359-361 | `num.counters` | `ex@no` reset per section (`\@addtoreset`); question labels `\arabic` bold, parts `\alph`, `\roman` |
| version driver loop | main.tex:39,48,51-55,75-78; esami.sty:178,714-730,1749-1753 | `exam.questions` | `\numcompiti`=1, `\testversioni`, `\whiledo` (ifthen) around `\stepvers` ... `\closevers`, seed `\FPeval\seme{...}` and `\randomi=\seme`, `\permuta` |
| exercise bank and ordering | main.tex:64,72-73; esami.sty:2092,2111-2127,2135-2144 | `exam.questions` | `\esercizi{file,file}` with `shuffle`: pseudorandom permutation tables up to 8 files (esami.sty:1749-1943) |
| question variants | mcq-dice.tex:1; problem-coinflip.tex:1; esami.sty:1028-1045,1053-1106 | `exam.questions` | one `\newproblem{...}` per file; `\selectrandomly` picks one variant from a seed |
| multiple-choice section | main.tex:62-66; esami.sty:1248-1266,1270-1297,1301-1318 | `exam.questions` | `test[8]` (declared total), `questions` (kernel `list`, bold arabic labels), `shortquiz` |
| multiple-choice answers | mcq-dice.tex:4-9; esami.sty:1311,1330-1345,1355-1364,1411-1433,2220-2294 | `exam.questions` | `answers{1}` (one column, list mode), `\Ans1`/`\Ans0` ... `\eAns` (digit marks the right choice), `\bChoices[random]` ... `\eChoices`, labels `(a)` via `\linkContentWrapper` (esami.sty:369-370), answers shuffled |
| points tally | mcq-dice.tex:2; esami.sty:602-609,733 | `exam.questions` | `\PTs{4}` prints an emphasised "(4 points)" through `\PTsHook` |
| points box on the right | main.tex:32; esami.sty:107-108,620-651 | `exam.questions` | option `pointsonright`; `\examenddef` puts a 40pt boxed points cell right of the text block |
| points box construction | esami.sty:636-651 | `tbl.tabular` | `{|c|}`, two `\hline` cells, `\tabcolsep=0pt`, inside `\makebox[0pt][l]` |
| worked problem | problem-coinflip.tex:3-7; esami.sty:1489-1497,1607-1623,378 | `exam.questions` | `problem[6]` over `exercise`; heading `\scshape Exercise n.`; points box with `\punti`=6 |
| fill-in answer | problem-coinflip.tex:6; problem-stderr.tex:7; esami.sty:671-675,676-700 | `exam.questions` | `\fillin[b]{2cm}{...}`: boxed answer space, answer hidden by `\phantom` without the `solutions` option |
| random parameters | problem-coinflip.tex:2,6; problem-stderr.tex:2-3,7; esami.sty:402-405,780-827 | `exam.questions` | `\FPsetpar{k}{3}{9}` draws an integer in a range from seed and counters; `\FPsv[4]{expr}` prints a computed value through numprint (lng:65; considered: numprint, fp) |
| points consistency check | main.tex:44; esami.sty:307; esami-xyz.cfg:152-169 | `exam.questions` | hook `\checkpoints` blanked with `\renewcommand{\checkpoints}{ }`; no typeset effect |
| solutions mode (not selected) | main.tex:32 (`nosolutions`); esami.sty:110-116,738-752; esami-xyz.cfg:108-120 | `exam.questions` | option `solutions` would write and `\input` `\jobname.sol.tex` with TeX's own `\write` (two passes, no external tool); not used by this sample |
| maths package | esami-xyz.cfg:19,24-27 | `math.amsmath` | `amsmath`, four `\DeclareMathOperator` |
| inline maths in questions | mcq-dice.tex:5-8; problem-stderr.tex:5-7 | `math.kernel` | inline `$...$` (content) |
| symbols package | esami.sty:158,735 | `math.amssymb` | `amssymb` loaded; `\blacktriangleright` only in solutions mode |
| loaded, not exercised | esami.sty:149 | `fig.graphicx` | `graphicx` loaded, no figure in the sample |
| loaded, not exercised | esami.sty:150 | `list.enumerate-pkg` | `enumerate` loaded, no use in the sample |
| loaded, not exercised | esami.sty:157,1253 | `cols.multicol` | `multicol` used only with option `twocolumns` (esami.sty:92) |
| loaded, not exercised | esami.sty:169,672 | `color.xcolor` | `xcolor`; red answers only in solutions mode |
| support packages, no look | esami.sty:148,151-156,172 | `exam.questions` | `tagpdf-base`, `fp`, `currfile`, `array`, `environ`, `ifthen`, `xargs`, and `\input random` (random.tex, CTAN `macros/generic/random`); they run the shuffling and seeds |

## Bespoke code
`esami.sty` is published (CTAN, TeX Live), so it is the way, not bespoke. README.md:15-16 calls the cfg "edited from the upstream template", and README.md:48-54 with esami-xyz.cfg:127-130 name the instruction macros as the edit; the cfg and the language file were not compared with the CTAN copies here, so every item below is treated as zip-local and reduced.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| title block macro `\testa` | esami-xyz.cfg:70-85 | yes | `tbl.tabular` in `center` with `mark.kernel` and `font.size-commands`; branch for option `prova` (cfg:70-71) not taken |
| footer page style `\ps@esame` | esami-xyz.cfg:91-102 | yes | `hf.fancyhdr` named style with one centred foot field; branch fixed by `nosolutions` |
| solutions page style and `\stringasol` | esami-xyz.cfg:108-120 | yes (not taken) | with `nosolutions` `\stringasol` is `\relax` (cfg:119); `\ps@soltest` is never called |
| instruction macros `\istruzionii`, `\istruzioniii` | esami-xyz.cfg:131-140 | yes | `list.kernel` + `box.fancybox` + `box.minipage` + `sp.lengths`/`sp.manual-space`, plain strings (patched text) |
| math shortcuts and Greek aliases | esami-xyz.cfg:24-32,53,57-61 | yes | `\DeclareMathOperator` and `\providecommand`/`\renewcommand` aliases (`\theta`->`\vartheta`); `math.amsmath` |
| `sistema` environment | esami-xyz.cfg:34-37 | yes | `\left\lbrace` + `array` `{@{}l@{}}`: `math.kernel` + `tbl.tabular`; unused by the sample |
| `\annu` | esami-xyz.cfg:39-51 | yes | two nested `array`s with `\arraystretch`, `\arraycolsep`, `\arrayrulewidth`: `tbl.tabular` + `sp.lengths`; unused by the sample |
| score check `\punteggio`, `\@PTs`, `\checkpoints` | esami-xyz.cfg:152-169 | yes | an assertion that raises `\PackageError`, no printed output; main.tex:44 blanks it; an emitter can drop or keep it |
| language file labels and `\es@longdate` | es-UKenglish.lng:3-56 | yes | plain strings; the date `\ifcase` (lng:45-55) only turns `2026/10/14` into text, so fixed text or `front.datetime` `\newdateformat` gives the same words |
| string definitions `\examname`, `\numcompiti`, `\Data` | main.tex:38-41 | yes | strings and an alias consumed by esami hooks (`\testa`, `\testversioni`) |
| hook override `\renewcommand{\checkpoints}{ }` | main.tex:44 | yes | `\checkpoints` is an empty hook by default (esami.sty:307); blank override has no printed effect |
| version loop | main.tex:51-78 | yes | no new macro is defined: ifthen `\whiledo`, esami `\stepvers` `\closevers` `\permuta`, fp `\FPeval`; an emitter writes it as a fixed body wrapper around the section content |

## Content-opaque
- question and answer texts: mcq-dice.tex:2-8, mcq-median.tex:2-8, problem-stderr.tex:5-7, problem-coinflip.tex:4-6
- fp formulas in `\FPsv` and the value ranges in `\FPsetpar` (problem-coinflip.tex:2,6; problem-stderr.tex:2-3,7): values are drawn at compile time from a seed
- answer order inside each MCQ (`\bChoices[random]`, mcq-dice.tex:4): decided at compile time

## Lib changes
- New ways proposed: `exam.questions` (section: doc-kind specific). Package `esami` (CTAN, TeX Live, LPPL), pdfLaTeX. Options `shuffle`/`noshuffle`, `pointsonright`, `solutions`/`nosolutions`, `quizsolutions`/`noquizsolutions`, `allowrandomize`/`norandomize`, `twocolumns`, `sansserif`, a language name, and any other name read as `esami-<name>.cfg`; strings `\examname` `\numcompiti` `\date`; body driver `\stepvers` `\closevers` `\permuta`, `\esercizi{files}`, `\newproblem`, `test` `questions` `answers` `\Ans` `\eAns` `\bChoices[random]`, `problem` `exercise`, `\PTs`, `\fillin`, `\FPsetpar`, `\FPsv`. W1: on CTAN and in TeX Live. W2: behaviour comes from options, strings, ranges and flags, not from editing its code. W3: serves any exam, not one document. W4: `\usepackage[options]{esami}` in the preamble, a loop wrapper in the body and one bank file per question. Nearest home `exam.questions` (`exam`/`examdesign`) is not used because esami adds seeded variant selection, answer shuffling and per-version numeric parameters; a consolidator may instead fold it there with the package as the parameter (as `font.helvet` went into `font.helvet`).
- Considered, not proposed: `numprint` (loaded by the language file, lng:65, reached only through `\FPsv`), `fp` (loaded by esami.sty:151; the one `\FPeval` in main.tex:53 only sets esami's `\seme`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
