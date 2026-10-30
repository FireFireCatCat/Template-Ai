yes

# 0780-esami: esami (exam generator package) and its ltxdoc manual

- Unverified: read from the source, not compiled.
- Source: Source/0780-esami/ (origin: https://mirrors.ctan.org/macros/latex/contrib/esami.zip; licence: LPPL 1, per manifest `lppl1` and ctan.org/pkg/esami)
- Kind: exam (the zip is the CTAN package `esami`; its manifest main sample is the package manual, a `misc` document under `ltxdoc`)
- Lib: v6
- Engine: pdfLaTeX-compatible (manual and `master.tex` use pdfLaTeX; `doc/examples/testA-xetex.tex:3-4` and `testA-luatex.tex:2` are variants that add `fontspec`/`luatextra`; ctan.org/pkg/esami states no engine)
- Look carried by: mixed (manual: class `ltxdoc` plus a small preamble, `doc/esami-doc-it.tex:6-44`; exam output: the published package `esami.sty`, its config file `esami-xyz.cfg` and the `es-*.lng` files, which all ship in the CTAN zip)
- Class origin: tex-distribution-unbundled (`ltxdoc` for the manual, `article` for the exam samples; neither is in the zip; `esami.sty` itself is on CTAN, ctan.org/pkg/esami read: v2.9, 2024-07-03)
- Main file: doc/esami-doc-it.tex (other samples: doc/esami-doc-en.tex, doc/examples/master.tex, master-sol.tex, testA-pdflatex.tex, testA-pdflatex-sol.tex, testA-xetex.tex, testA-luatex.tex, totale-versioni.tex; test*.tex and problem*.tex are `\input` exercise fragments)
- Read: main yes (Italian manual in full; the exam samples `master.tex`, `testA-pdflatex.tex`, `testA-xetex.tex`, `testA-luatex.tex`, `totale-versioni.tex` and the exercise files `test4/13/14.tex`, `problem1/2/2-tabella/3/4.tex` in full; `esami-doc-en.tex` only by a grep of its preamble and macro lines, it is the English translation with `\usepackage[english]{babel}` at :17), zip-local classes and styles all (`esami.sty` 1-2295 and `esami-xyz.cfg` 1-353 in full; the eight `es-*.lng` files read)

## Verdict
The manual is a plain `ltxdoc` driver whose preamble loads only published packages and defines a few aliases and one boxed "Esempio N" environment, all of which reduce to lib ways. The exam look is carried by `esami.sty`, which is released on CTAN (W1), so it is one way, `exam.questions` (the lib line already names `esami`); the config file `esami-xyz.cfg` and the localisation files are small compositions of lib ways once the option-dependent branches are fixed. No artwork, no external tool is loaded by default, and no zip-local irreducible code was found. The `yes` rests on counting `esami.sty` (about 2300 lines of seeded permutation and selection code, `esami.sty:1749-2294`) as a published package and not as bespoke code; a reviewer who treats that internal code as in scope would flip it to `no`.

## Blockers
none

Considered and not blockers (recorded):
- `EXTERNAL/package` only when selected: option `autopston` loads `auto-pst-pdf`, which needs shell escape (`esami.sty:161-167`); `autopstoff` loads it in `off` mode and only `doc/examples/totale-versioni.tex:3` uses that, no exam sample selects `autopston`.
- `esami.sty:148` loads `tagpdf-base` and `master.tex:9` loads `fixltx2e`; both are load-only with no printed effect, so not components (lib v4 change log, rejected `sys.compat-load`).
- `esami.sty:172` `\input random` reads `random.tex`, which is not in the zip; ctan.org/pkg/random read: Donald Arseneau, public domain, in TeX Live (published, W1 holds; its source was not read).

## Class setting
- Class: `class.ltxdoc` options: none (`doc/esami-doc-it.tex:6`); exam samples use `class.article` options `a4paper,italiano` (`doc/examples/master.tex:1`), `a4paper,italian` (`testA-pdflatex.tex:1`).
- Class-native vocabulary used: `\DescribeMacro` `\DescribeEnv` (`doc/esami-doc-it.tex:235,254`), `\changes` (:71-82), `\CheckSum` `\OnlyDescription` `\EnableCrossrefs` `\CodelineIndex` `\PageIndex` `\RecordChanges` (:39-44), `\GlossaryPrologue` (:85), `\GetFileInfo` (:91), `\MakeShortVerb` `\DeleteShortVerb` (:559-560), `\cmd` `\marg` `\oarg` `\meta` (used throughout, defined neither in the zip nor in the sample; their source package, `ltxdoc`, `doc` or `colordoc`, was not read; ctan.org/pkg/colordoc read: colour for `doc`-based documentation, LPPL 1, in TeX Live).

## Component map
Rows D are the manual (`doc/esami-doc-it.tex`); rows E are the exam template (`esami.sty`, `esami-xyz.cfg`, `es-italian.lng`, `doc/examples/master.tex`).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| D class | doc/esami-doc-it.tex:6 | `class.ltxdoc` | no options |
| D doc markup | doc/esami-doc-it.tex:9, 39-44, 71-85, 235, 559-560 | `dtx.doc` | `colordoc` (CTAN, LPPL 1, ctan.org/pkg/colordoc) with option `braces`; `\EnableCrossrefs \CodelineIndex \PageIndex \RecordChanges \OnlyDescription \CheckSum{6041}`; `\changes` entries; `\GlossaryPrologue{\section*{Changelog}}`; `\DescribeMacro/\DescribeEnv`; `\MakeShortVerb` |
| D page geometry | doc/esami-doc-it.tex:20 | `page.geometry` | lmargin=3.5cm, rmargin=3.5cm |
| D encodings and face | doc/esami-doc-it.tex:10, 13, 15 | `font.fontenc-t1`, `font.lmodern` | fontenc T1, inputenc utf8, lmodern |
| D macro font hook | doc/esami-doc-it.tex:86-90 | `font.nfss` | `\fontencoding\encodingdefault \fontfamily\ttdefault \fontseries\mddefault \fontshape\updefault`, then `\footnotesize` (`font.size-commands`) |
| D language | doc/esami-doc-it.tex:16 | `lang.babel` | italian |
| D colour | doc/esami-doc-it.tex:18, 171, 212, 248 | `color.xcolor` | options dvipsnames, svgnames; `\textcolor[rgb]{1,0,0}`, `{\color{blue}...}`, `\fcolorbox{red}{white}` |
| D links | doc/esami-doc-it.tex:21 | `meta.hyperref` | colorlinks=true, pdftex, hyperindex=true |
| D TeX logos | doc/esami-doc-it.tex:12, 114, 127 | `font.icons` | `hologo`: `\hologo{pdfLaTeX}` `\Hologo{XeLaTeX}` |
| D calc lengths | doc/esami-doc-it.tex:11, 33, 246-249 | `sp.lengths` | `calc`; `\textwidth-2\fboxsep-2\fboxrule`; `\fboxrule`=2pt, `\fboxsep`=2mm |
| D graphicx | doc/esami-doc-it.tex:17 | `fig.graphicx` | load-only, no `\includegraphics` in the sample |
| D verbatim | doc/esami-doc-it.tex:19, 142-145, 226 | `code.verbatim` | `fancyvrb`, `verbatim` environment, `\VerbatimFootnotes` |
| D example box | doc/esami-doc-it.tex:22-36 | `box.fancybox`, `box.minipage`, `num.counters`, `mark.kernel`, `sp.manual-space` | `\fbox` around a `minipage`, counter `esempio` stepped, bold sans label "Esempio N.", `\par\medskip` around |
| D warning frame | doc/esami-doc-it.tex:246-252 | `box.fancybox`, `box.minipage` | `\fcolorbox{red}{white}` around a `minipage` |
| D title block | doc/esami-doc-it.tex:96-101 | `front.maketitle`, `front.thanks` | `\title` with `\thanks`, `\author` with `\\`, `\maketitle` |
| D contents | doc/esami-doc-it.tex:103-104 | `toc.kernel`, `pg.break` | `\tableofcontents`, `\newpage` |
| D headings | doc/esami-doc-it.tex:111, 138, 430 | `head.kernel` | `\section \subsection \paragraph` with the `ltxdoc` look |
| D lists | doc/esami-doc-it.tex:119-124, 211-230, 793-806 | `list.kernel` | `enumerate`, `itemize`, `description` |
| D footnotes | doc/esami-doc-it.tex:118, 227 | `fn.kernel` | plain `\footnote` |
| D margin notes | doc/esami-doc-it.tex:99 | `note.marginpar`, `sp.ragged`, `font.size-commands`, `mark.kernel` | `\marginpar{\raggedleft{\footnotesize{\textsf{Nuovo #1}}}}` |
| D name aliases | doc/esami-doc-it.tex:105-108 | `mark.kernel` | `\texttt`, `\emph`, `\textsf` |
| D tables and rules | doc/esami-doc-it.tex:515-521, 557-567 | `tbl.tabular`, `sp.rule` | `tabular{l l l}`, `{r\|c}` with `\hline`, `\arraystretch`=3, `\rule{1cm}{1pt}` |
| D spacing | doc/esami-doc-it.tex:245, 504-523 | `sp.manual-space`, `sp.ragged` | `\\[2mm]`, `center` |
| D cross-references | doc/esami-doc-it.tex:146, 208 | `xref.kernel` | `\label` `\ref` |
| D bibliography | doc/esami-doc-it.tex:809-810 | `bib.bibtex-bst` | style `plain`, database `doc/esami.bib`, `\cite` |
| E class | doc/examples/master.tex:1 | `class.article` | a4paper, italiano |
| E exam package and options | doc/examples/master.tex:3; esami.sty:63-142 | `exam.questions` | `esami` with shuffle, xyz, pointsonright, nosolutions, noquizsolutions, twocolumns; other options allowrandomize, norandomize, shufflerandom, noshuffle, solutions, quizsolutions, prova, param, correzione, solutionsonly, sansserif, language names |
| E exam preamble values | doc/examples/master.tex:18-21 | `exam.questions` | strings `\examname`, `\numcompiti`=10, `\date{2014/07/22}` (also the seed source, esami.sty:732), `\Data{\longdate}` |
| E exam body routine | doc/examples/master.tex:28-94 | `exam.questions` | `\testversioni`, `\whiledo{\thevers<\numcompiti}{\stepvers ... \closevers}`, `\FPeval\seme{...}`, `\randomi=\seme`, `\permuta`, `\testa`, `\istruzionii`, `test`, `questions`, `esdb` + `\selectrandomlyn`, `\esercizi`, `\selectallproblems` |
| E exercise vocabulary | doc/examples/test14.tex:1-15; problem1.tex:1-22; problem2-tabella.tex:8-18; problem3-matching.tex:2-14 | `exam.questions` | `\newproblem`, `\PTs`, `answers` `\bChoices[random]` `\Ans0/\Ans1` `\eFreeze`, `solution`, `problem` `problem*` `parts`, `workarea`, `tabella`, `\pair` `\matching`, `\fillin`, `\FPsetpar` `\FPsv` `\estrai` `\estraialfa` |
| E fonts and encodings | doc/examples/master.tex:10-12 | `font.fontenc-t1`, `font.lmodern` | T1, utf8, lmodern, textcomp |
| E language | doc/examples/master.tex:24 | `lang.babel` | default language of the class |
| E sans option | esami.sty:93 | `font.family-default` | `\familydefault` set to `\sfdefault` when option `sansserif` |
| E page block | esami.sty:195-203 | `page.setlength` | `\topmargin`=-90pt, `\textheight`=`\paperheight`-80pt, `\textwidth`=`\paperwidth`-70pt, `\oddsidemargin`=-60pt, `\footskip`=28pt, `\marginparwidth`=0pt, `\marginparsep`=0pt |
| E page block, localised | es-italian.lng:60-61 | `page.geometry` | a4paper, lmargin=6mm, rmargin=22mm, tmargin=10mm, bmargin=18mm, marginparsep=2mm, footskip=1cm (loaded last, so it overrides the lengths above); the other `.lng` files use rmargin=18mm and tmargin=6mm (es-french.lng:54) |
| E spacing | esami.sty:240, 242-245, 251, 253 | `sp.lengths` | `\parindent`=0pt, `\tabcolsep` +2pt, `\arraycolsep` +2pt, `\aboveanswersSkip`=6pt, `\medskipamount` for exercise skips |
| E exam heading | esami-xyz.cfg:73-83 | `tbl.tabular`, `font.size-commands`, `mark.kernel`, `sp.ragged`, `sp.manual-space`, `sp.rule` | bold sans `\small`, `center`, `tabular{\|lp{.33\textwidth}\|...}` with `\multicolumn`, `\hline`, row gaps `[4ex]` `[3ex]`; fields are the strings `\examname \profname \studsignname \studlastname \studfirstname \studid` |
| E footer page style | esami-xyz.cfg:91-110 | `hf.pagestyle-kernel` | kernel `\ps@esame` and `\ps@soltest` with empty heads and a centred foot "Versione n. N -- Pagina P" (with "Soluzioni" when option `solutions`); `\pagestyle{esame}` at master.tex:29 |
| E page counter | esami.sty:723; doc/examples/master.tex:91-93 | `pgnum.pagenumbering`, `pg.break` | `\newpage\setcounter{page}{1}` after every version |
| E instructions | esami-xyz.cfg:127-136 | `list.kernel`, `box.fancybox`, `box.minipage`, `sp.lengths`, `mark.kernel` | `itemize` under a bold sans heading; `\framebox{\parbox{\textwidth}{...}}` with `\fboxsep`=1.5ex, `\fboxrule`=1.2pt |
| E solution string | esami-xyz.cfg:112-117; esami.sty:703-713, 738-752 | `struct.input`, `pg.break`, `sp.manual-space`, `hf.pagestyle-kernel` | `\newpage\vspace{.8cm}\pagestyle{soltest}\input{\jobname.sol.tex}`; the file is written by the package with `\write` in the same run |
| E headings | esami.sty:1723-1737; doc/examples/master.tex:53 | `head.kernel` | `\section` and `\subsection` rebuilt with `\@startsection` parameters: indent 0mm, before -`\baselineskip`, after 0.5/1 `\baselineskip`, style `\sffamily\Large\centering`; sample uses `\section*{Part One}` |
| E exercise counter | esami.sty:324-328, 359-361 | `num.counters` | `ex@no` reset per `section` (`\@addtoreset`), part counter printed `\alph`, question labels `\arabic` `\alph` `\roman` |
| E question lists | esami.sty:1270-1297, 1330-1345, 1586-1602 | `list.kernel` | generic `list` with `\usecounter`, `\labelwidth` measured with `\settowidth`, `\topsep` 3pt, `\itemsep` 3pt, `\labelsep` from `\mylabelsep` |
| E columns | esami.sty:1252-1257, 1097, 1220; doc/esami-doc-it.tex:302-310 | `cols.multicol`, `box.minipage` | `multicols{2}` under option `twocolumns`; each test question in `minipage{.95\linewidth}` |
| E points box | esami.sty:620-651 | `tbl.tabular`, `box.minipage`, `sp.manual-space`, `sp.rule` | `\parbox{40pt}` holding `tabular{\|c\|}` with `\hline`, `\vrule height20pt`, `\raisebox`, `\hspace*{\textwidth}`; text "N punti" in `\small\emph` |
| E answer layout | esami.sty:1349-1354, 1397-1404 | `tbl.tabular` | `tabular{*{n}{p{\linewidth/n}}}` for multi-column answers |
| E solution colour | esami.sty:672, 878-882, 923 | `color.xcolor` | answers `\bfseries\color{red}` with option `solutions`, `\phantom` without; `\colorlet{tab@ans@color}{red}` |
| E open-answer areas | esami.sty:884-886, 892-910, 1702-1715 | `tbl.tabular`, `box.fancybox`, `box.minipage`, `sp.rule`, `sp.manual-space` | `tabella` (`\arraystretch`=2, column types `C`), `risposta` box (`\fbox{\parbox}`) or dotted lines (`\dotfill`), `workarea` (`lrbox`, `minipage`, `\smash`) |
| E fill-in blank | esami.sty:676-700 | `box.fancybox`, `box.minipage`, `mark.kernel` | `\underbar`, `\fbox` or nothing around `\parbox[b][.8\height][b]{width}` |
| E number printing | esami.sty:404; es-italian.lng:65-72 | `mark.siunitx` | `numprint` with `np`; `\npthousandsep{\,}`, `\npproductsign`, `\npunitseparator{~}`, `\npthousandthpartsep{}`, `\npfourdigitnosep`; other `.lng` use `np,autolanguage` |
| E maths | esami-xyz.cfg:19-61; esami.sty:158; es-italian.lng:62 | `math.amsmath`, `math.amssymb`, `math.icomma`, `math.kernel` | `amsmath`, `amssymb`, `icomma`; `\DeclareMathOperator` for `\sen \tg \arcsen \arctg`; `\left\lbrace` + `array` system; `\vartheta` family aliases |
| E currency | es-italian.lng:63, 75-77 | `font.icons`, `font.nfss` | `eurosym`; `\officialeuro` = `\fontencoding{U}\fontfamily{eurosym}\selectfont e` |
| E long date | es-italian.lng:46-53; esami.sty:738-742 | `front.datetime` | `\es@longdate` prints "D month-name YYYY" from the `\date{YYYY/MM/DD}` value; `\shortdate` prints "D/M/YYYY" |
| E localised strings | es-italian.lng:3-19; es-UKenglish.lng:3-19 | `exam.questions` | strings `\es@exercisename \es@solutionname \es@pointname \profname \versionname \pagename ...` per language file |
| E package loads | esami.sty:148-158 | `fig.graphicx`, `list.enumerate-pkg`, `tbl.tabular`, `cols.multicol`, `math.amssymb` | `graphicx`, `enumerate`, `array`, `multicol`, `amssymb`; `fp`, `currfile`, `environ`, `ifthen`, `xargs` are helper packages inside the exam way |
| E engine variants | doc/examples/testA-xetex.tex:3-4; testA-luatex.tex:2 | `font.fontspec` | `fontspec` with `\XeTeXinputencoding utf8`; `luatextra`; not the main samples |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `esempio`/`example` environments, counter `esempio`, box `\fcolbox` | doc/esami-doc-it.tex:22-36 | yes | `box.fancybox` (`\fbox`) around `box.minipage` of width `\textwidth-2\fboxsep-2\fboxrule` (`sp.lengths` with `calc`); label from `num.counters` in `mark.kernel` bold sans |
| `\nuovo` | doc/esami-doc-it.tex:99 | yes | alias of `note.marginpar` + `sp.ragged` + `font.size-commands` + `mark.kernel` |
| `\pkgname \clsname \optname \envname` | doc/esami-doc-it.tex:105-108 | yes | aliases of `mark.kernel` (`\texttt`, `\emph`, `\textsf`) |
| `\MacroFont`, `\fileversion`, `\filedate` | doc/esami-doc-it.tex:86-93 | yes | `font.nfss` + `font.size-commands`; two content strings |
| `\testa` heading table | esami-xyz.cfg:70-85 | yes | `tbl.tabular` as in the map; the `\@ifpackagewith{esami}{prova}` branch is fixed at emission (empty for option `prova`) |
| `\ps@esame`, `\ps@soltest`, `\stringasol` | esami-xyz.cfg:91-120 | yes | `hf.pagestyle-kernel` (or `hf.fancyhdr` centred foot) plus `struct.input`; the `\ifes@solutions` branch is known when the emitter writes the file |
| `\istruzionii`, `\istruzioniii` | esami-xyz.cfg:127-136 | yes | `list.kernel` and `box.fancybox`/`box.minipage` as in the map |
| math shortcuts, `sistema`, `\annu`, `\vect`, greek aliases | esami-xyz.cfg:19-61 | yes | `\DeclareMathOperator` and `\providecommand` aliases of `math.amsmath`; `sistema` and `\annu` are `array` constructs with fixed lengths (`tbl.tabular` in maths) and are expanded in place, no counters or conditionals |
| `\@PTs` patch and `\checkpoints` (score-sum check with `\punteggio`) | esami-xyz.cfg:148-165 | yes, by omission | it prints nothing and only raises a package error on a score mismatch; `testA-pdflatex.tex:17` already disables it with `\renewcommand{\checkpoints}{ }` |
| `\es@longdate` month lookup by `\ifcase` | es-italian.lng:46-53 (same pattern in every `.lng`) | yes | the date is a known value at emission, so the emitter prints the formatted date (`front.datetime`) or the babel `\today` form |
| `.lng` label strings, `\npstyle...`, `\officialeuro` | es-italian.lng:3-19, 65-77 | yes | strings as `exam.questions` parameters (or `lang.translator` entries), `mark.siunitx` settings, `font.nfss` |
| commented override block (minipage removal, `\shuffle`, `\esercizidb`) | esami-xyz.cfg:168-353 | n/a | every line is a comment, nothing is active |
| `esami.sty` internals (seed arithmetic, permutation tables, `\selectrandomly`, `\rand@getitems`, `\write` of `.sol.tex` `.loe` `.parametri.tex`) | esami.sty:773-827, 1053-1106, 1749-2294 | not counted | published package (CTAN, LPPL 1), one way `exam.questions`; the emitter writes `\usepackage[options]{esami}` and the documented vocabulary, it does not copy this code; compiles with TeX only, no outside tool |

## Content-opaque
none (exercise texts and formulas in `doc/examples/test*.tex` and `problem*.tex`, and the sample tables in the manual, are content held by the mapped ways)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
