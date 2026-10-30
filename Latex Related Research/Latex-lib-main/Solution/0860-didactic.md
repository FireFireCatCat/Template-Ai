no

# 0860-didactic: didactic (tools for writing teaching material; package source and manual)

- Unverified: read from the source, not compiled.
- Source: Source/0860-didactic/ (origin: https://mirrors.ctan.org/macros/latex/contrib/didactic.zip; licence: LPPL 1.3c)
- Kind: misc (the only sample is the package's own manual under `ltxdoc`; the package itself targets teaching slides and handouts)
- Lib: v6
- Engine: pdfLaTeX-compatible (Makefile:2, Makefile:12 run `pdflatex`); it needs `-shell-escape` and the `pythontex` script (see Blockers)
- Look carried by: mixed (the package code in didactic.dtx:22-1241 carries the look; the docstrip driver preamble at didactic.dtx:41-57 loads it over `ltxdoc`)
- Class origin: tex-distribution-unbundled (the driver's class `ltxdoc` is LaTeX base and is not in the zip; the package `didactic` is on CTAN, v1.7, LPPL 1.3c, TeX Live, read at ctan.org/pkg/didactic)
- Main file: didactic.dtx (the driver block at didactic.dtx:40-58 holds `\documentclass` and `\begin{document}`; there is no standalone sample .tex; other samples: idea.tex and lightblock.tex are fragments that the manual `\input`s at didactic.dtx:161 and didactic.dtx:191)
- Read: main yes, zip-local classes and styles all (no .cls or .sty ships: `didactic.sty` is generated from didactic.dtx by didactic.ins:38, and I read didactic.dtx 1-1241 and didactic.ins in full; didactic.pdf and LICENSE were not read)

## Verdict
No. `didactic.sty` loads `pythontex` and `minted` unconditionally (didactic.dtx:31-32, `minted` again at didactic.dtx:1215), so by the pilot ruling the document does not compile without shell escape, Pygments, and the PythonTeX script, even for a manual page that never calls them; the package also ships a `pycode` block that runs `python3` (didactic.dtx:1117-1132) and a Makefile that drives both tools. Apart from that, nearly everything reduces to lib ways (`thm.thmtools`, `slide.beamer-template`, `page.memoir-layout`, `lang.translator`, `note.marginpar`, `page.adjustwidth`), with one more irreducible piece: the named on/off toggles of `\NewNoteType`.

## Blockers
- `EXTERNAL/package` `minted` loaded unconditionally and used by `\lstexample`, `\codebycode` and the manual's `\inputminted` calls (didactic.dtx:32, didactic.dtx:1094-1098, didactic.dtx:1215-1226, didactic.dtx:163, didactic.dtx:180, didactic.dtx:193; Makefile:3 `LATEXFLAGS=-shell-escape`)
- `EXTERNAL/package` `pythontex` loaded unconditionally (didactic.dtx:31, didactic.dtx:44); `\runpython` and `\runbyrun` run a Python program through `subprocess.run(["python3", m])` inside a `pycode` block (didactic.dtx:1117-1143, didactic.dtx:1234-1236); the build runs the `pythontex` script between LaTeX runs (Makefile:4, Makefile:13-15)
- `BESPOKE/class` `\NewNoteType` and the `\ltnote` instance: per-type `\newbool`/`\ifbool` toggles with generated `...off` and `...on` commands decide whether a note prints at all (didactic.dtx:1034-1064, didactic.dtx:1073); no lib way holds a named boolean switch, so this is a hand-rolled conditional that drives what is printed

## Class setting
- Class: `class.ltxdoc` options: none (didactic.dtx:41). The package itself reacts to `class.beamer` and `class.memoir` when either is loaded (didactic.dtx:315, didactic.dtx:333); the driver loads neither, so those branches are read from source only. Package options (didactic.dtx:314-387): `nobeamer`, `nobeamertheme`, `noarticle`, `nomemoir`, `notheorems`, `inner`, `outer`, `top`, `bottom`, `marginparmargin`; the driver passes `marginparmargin=left` (didactic.dtx:46).
- Class-native vocabulary used: `ltxdoc` (the `doc` package): `\DocInput`, `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\PrintChanges`, `\CheckSum`, `\CharacterTable`, `\GetFileInfo`, `\DoNotIndex`, `\changes`, `\DescribeEnv`, `\DescribeMacro`, `\StopEventually`, `\Finale`, environments `macrocode`, `macro`, `environment`, and the `|...|` short verbatim (didactic.dtx:50-57, didactic.dtx:61-100, didactic.dtx:290, didactic.dtx:313-314, didactic.dtx:1240). `class.memoir` vocabulary read in the package: `\footnotesinmargin`, `\sidefootform`, `\foottextfont`, `\setmpjustification`, `\sidecapmargin`, `\setsidecappos`, `\setsidecaps`, `\nouppercaseheads`, `\setlxvchars` (didactic.dtx:487-520). `class.beamer` vocabulary: `block`, `alertblock`, `exampleblock`, `beamercolorbox`, `\insertshortauthor` and the other `\insert...` fields (didactic.dtx:413-429, didactic.dtx:680-692, didactic.dtx:796).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (sample) | didactic.dtx:41 | `class.ltxdoc` | no options |
| class detection | didactic.dtx:314-334, didactic.dtx:387 | `class.beamer`, `class.memoir` | `\@ifclassloaded` booleans resolved when the emitter knows the class; options `nobeamer` `nomemoir` `nobeamertheme` `noarticle` `notheorems` |
| input encoding | didactic.dtx:42 | `font.fontenc-t1` | `inputenc` option `utf8` |
| languages | didactic.dtx:43, didactic.dtx:629, didactic.dtx:643, didactic.dtx:639 | `lang.babel` | options `swedish,british`; `\selectlanguage{swedish}` and `{british}` |
| translations of block names | didactic.dtx:34, didactic.dtx:807-866, didactic.dtx:1072 | `lang.translator` | package `translations`: `\ProvideTranslation{swedish}{Idea}{Idé}` (60 lines for 15 words in 4 forms), `\GetTranslationWarn{Idea}` at didactic.dtx:682, didactic.dtx:705-707, didactic.dtx:1073 |
| beamer in article mode | didactic.dtx:45 | `slide.beamer-mode` | `\usepackage[notheorems]{beamerarticle}`; supplies `block` and `\setbeamercolor` to the article |
| documentation driver | didactic.dtx:50-57, didactic.dtx:61-98, didactic.dtx:290, didactic.dtx:1240 | `dtx.doc` | `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput{didactic.dtx}`, `\PrintChanges`, `\CheckSum{0}`, `\CharacterTable`, `\GetFileInfo`, `\StopEventually{}`, `\Finale`; `\PrintIndex` is commented out (didactic.dtx:56) |
| hyperref | didactic.dtx:48 | `meta.hyperref` | default options |
| url in footnote | didactic.dtx:1159-1161 | `fn.kernel`, `meta.url` | `\footnote{... \url{...}}` |
| cross-references | didactic.dtx:49, didactic.dtx:622-623, didactic.dtx:637-651, didactic.dtx:725-736 | `xref.cleveref`, `xref.kernel` | `\cref{a,b}` lists; `\label{theidea}` at idea.tex:1; `\crefname{idea}{..}{..}` and `\Crefname` at `\AtBeginDocument` |
| title block | didactic.dtx:103-108 | `front.maketitle`, `front.thanks` | `\title{...\thanks{...}}`, `\author{Daniel Bosk\\\texttt{..}}`, `\maketitle` |
| contents | didactic.dtx:110 | `toc.kernel` | `\tableofcontents` |
| headings | didactic.dtx:112, didactic.dtx:119, didactic.dtx:147 | `head.kernel` | `\section`, `\subsection` in the `ltxdoc` look; no override |
| enumerated list | didactic.dtx:169-178 | `list.kernel` | `enumerate` with 8 items |
| centred text | didactic.dtx:268-270, didactic.dtx:661-664 | `sp.ragged` | `center` environment |
| filler text | didactic.dtx:47, didactic.dtx:1153 | `draft.todo` | `\usepackage{lipsum}`, `\lipsum[1]` |
| semantic blocks, article mode | didactic.dtx:35-36, didactic.dtx:37-38, didactic.dtx:703-718, didactic.dtx:750-765, didactic.dtx:778-798 | `thm.thmtools`, `thm.amsthm` | `\declaretheorem[style=definition,name=..,refname=..,Refname=..]{idea}`; `remark` and `summary`: `numbered=no,style=remark`; `theorem` `corollary` `lemma`: `numbered=unless unique,style=theorem` (uses package `unique` with option `unq`); `proof` and `solution`: `numbered=no,style=proof`; amsthm supplies the styles |
| semantic blocks, beamer mode | didactic.dtx:680-692, didactic.dtx:750-765, didactic.dtx:779-797 | `class.beamer` | one environment alias per name with optional title argument `[##1]`: assumption and remark `alertblock`, idea `greenblock`, question `orangeblock`, exercise and activity `yellowblock`, summary, definition, theorem, corollary, lemma, proof, solution `block`, example `exampleblock`; the alias itself is a kernel `\newenvironment` alias (see Bespoke code) |
| coloured blocks | didactic.dtx:887-939 | `slide.beamer-template`, `color.xcolor` | `\setbeamercolor{block body}{bg=#1!10,fg=black}`, `{block title}{bg=#1,fg=black}` (lightblock) or `fg=white` (darkblock), `{local structure}{fg=#1}`; red, blue, purple use darkblock, green, yellow, orange use lightblock; whiteblock and bwblock set `white!10`, `black` |
| beamer theme | didactic.dtx:404 | `slide.beamer-theme` | `\usetheme{Berlin}` (skipped by `nobeamertheme`, didactic.dtx:403) |
| beamer footline | didactic.dtx:411-430 | `slide.beamer-template` | `\setbeamertemplate{footline}` of four `beamercolorbox` rows: `upper separation line foot` `colsep=1.5pt`, `author in head/foot` `ht=2.5ex,dp=1.125ex,leftskip=.3cm,rightskip=.3cm plus1fil`, `title in head/foot` same lengths, `lower separation line foot`; fields `\insertshortauthor` `\insertshortinstitute` `\insertshorttitle` `\insertframenumber` |
| beamer covered items, bibliography item | didactic.dtx:438-439 | `slide.beamer-template` | `\setbeamercovered{transparent}` (a `\setbeamer...` setter), `\setbeamertemplate{bibliography item}{\relax}` |
| section and subsection frames | didactic.dtx:448-459 | `slide.beamer-section-hook` | `\tableofcontents[currentsection,subsectionstyle=show/show/hide]` and `show/shaded/hide` inside `\begin{frame}<beamer>` |
| memoir margins | didactic.dtx:354-361, didactic.dtx:480-485, didactic.dtx:503, didactic.dtx:519 | `page.memoir-layout` | `\setlrmarginsandblock{inner}{outer}{*}`, `\setulmarginsandblock{top}{bottom}{*}`, `\checkandfixthelayout`; defaults inner 20mm, outer 70mm, top 25mm, bottom 40mm (didactic.dtx:354-357); option defaults 25mm, 65mm, 25mm, 40mm (didactic.dtx:358-361) |
| margin side of notes | didactic.dtx:373-381 | `page.memoir-layout` | `\marginparmargin{#1}`, `\strictpagechecktrue`, `\checkandfixthelayout`; `left` in the driver (didactic.dtx:46) |
| chars per line | didactic.dtx:518 | `page.memoir-layout` | `\setlxvchars\setxlvchars` |
| footnotes in the margin | didactic.dtx:487-491 | `class.memoir` | `\footnotesinmargin`, `\renewcommand{\sidefootform}{\RaggedRight}`, `\renewcommand{\foottextfont}{\footnotesize\RaggedRight}`; memoir vocabulary, as the lib change log filed `\deffootnote` under its class |
| ragged margin text | didactic.dtx:489, didactic.dtx:493 | `sp.ragged`, `font.size-commands` | `ragged2e`, `\setmpjustification{\RaggedRight}{\RaggedRight}`, `\footnotesize` |
| margin-note placement patch | didactic.dtx:479 | `note.mparhack` | load-only `\RequirePackage{marginfix}` (ctan.org/pkg/marginfix read: v1.2, LPPL, TeX Live; patches `\marginpar` so long notes do not run off the page, the type of `mparhack`) |
| margin figures and their captions | didactic.dtx:496-497 | `fig.class-native`, `cap.memoir` | `\setfloatadjustment{marginfigure}{\mpjustification}`, `\setmarginfloatcaptionadjustment{figure}{\captionstyle{\mpjustification}}` |
| side captions | didactic.dtx:501-507 | `cap.memoir` | `\sidecapmargin{outer}`, `\setsidecappos{t}`, `\setsidecaps{\marginparsep}{\marginparwidth}`, `\sidecapstyle` = `\captionstyle{\RaggedRight}` |
| side caption without memoir | didactic.dtx:568-571 | `cap.kernel` | `sidecaption{omo+b}` prints the body then `\caption{#2\label{#3}}` |
| flush towards caption | didactic.dtx:578-588 | `sp.ragged` | `\flushleft` or `\flushright` by memoir's `\ifscapmargleft`, else `\centering` |
| text faces | didactic.dtx:511, didactic.dtx:514, didactic.dtx:517 | `font.palatino`, `font.helvet`, `font.mono` | `mathpazo[osf,sc]`, `helvet[scaled=0.90]`, `beramono[scaled=0.85]` |
| memoir running heads | didactic.dtx:520 | `hf.class-native` | `\nouppercaseheads` |
| biblatex footnote citations | didactic.dtx:529-547 | `bib.biblatex-biber` | `\ExecuteBibliographyOptions{autocite=footnote,singletitle=false,maxbibnames=99,isbn=false,doi=false,url=false}`, `\DeclareCiteCommand{\fullauthorcite}` (only when `biblatex` is already loaded; the driver loads none) |
| csquotes footnote citations | didactic.dtx:548-550 | `lang.csquotes` | `\SetCiteCommand{\footcite}` (only when `csquotes` is loaded) |
| margin notes | didactic.dtx:967-973, didactic.dtx:985-997, didactic.dtx:256-260 | `note.marginpar`, `sp.lengths`, `font.size-commands`, `mark.kernel` | `\marginpar` with `\parindent` 1.0em, `\footnotesize`, `\emph{Title:}` or a font command in `[fmtcmd]` |
| full-width block | didactic.dtx:1165-1184 | `page.adjustwidth`, `sp.lengths` | `changepage` `adjustwidth` or `adjustwidth*` by the `marginparmargin` value (`inner` `left` `outer` `right`), lengths `-\marginparwidth-\marginparsep` and `-2em`; `\columnwidth` set to `\textwidth+2em+\marginparwidth+\marginparsep` and restored |
| side-by-side blocks | didactic.dtx:1191-1197, didactic.dtx:1214 | `tbl.tabularx` | `tabularx{\columnwidth}{XX}` inside `fullwidth` |
| source listings | didactic.dtx:1094-1098, didactic.dtx:1216-1226, didactic.dtx:219-226, didactic.dtx:240-242 | `code.minted` (EXTERNAL) | `\inputminted[escapeinside=||,<opts>]{lang}{file}`; `\codebycode` is two of them in `\textbytext`; manual calls with `linenos`, `highlightlines=4`, `breaklines` |
| run a program and print its output | didactic.dtx:1117-1143, didactic.dtx:1234-1236, didactic.dtx:234, didactic.dtx:247 | none (EXTERNAL; considered: `pythontex`) | `\pyc{run_module("..")}`, `\printpythontex[verbatim]`, `\setpythontexautoprint{false}`; the parameter is a Python program, which fails W2, and the tool runs outside TeX |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\ProvideSemanticEnv` (8 arguments, `\@ifundefined` guard) | didactic.dtx:666-738 | yes | expand per environment at emit time: beamer, `\newenvironment{idea}[1][]{\begin{greenblock}{<translated Idea>: #1}}{\end{greenblock}}`; article, `\declaretheorem[..]{idea}` (`thm.thmtools`); names from `lang.translator`; `\crefname` from `xref.cleveref`; the `\AtBeginDocument` wrapper is a preamble line after `\begin{document}` is known |
| `lightblock`, `darkblock`, `blackblock`, `whiteblock`, `bwblock`, `redblock` ... `orangeblock` | didactic.dtx:887-939 | yes | `\newenvironment` aliases that set `\setbeamercolor` (`slide.beamer-template`) with `color.xcolor` tints, then `\begin{block}{title}` |
| `\indentedmarginpar` | didactic.dtx:967-973 | yes | `note.marginpar` with `\setlength{\parindent}{1.0em}`, `\footnotesize`; `\@afterindentfalse\@afterheading` only stops the first-line indent, i.e. `\noindent` |
| `\newnotetype` | didactic.dtx:985-997 | yes | `\newcommand{\x}[1]{\indentedmarginpar{\emph{Title:} #1}}`; in beamer it is `\relax` (no output), decided statically |
| `\NewNoteType`, `\ltnote` and the generated `\<name>off` `\<name>on` | didactic.dtx:1034-1064, didactic.dtx:1073, didactic.dtx:1022-1026 | no | etoolbox `\newbool`, `\ifbool`, `\booltrue`, `\boolfalse` and `\csname` commands switch printing at run time (hand-rolled conditional); static resolution would drop the `...off` and `...on` commands the manual uses |
| `fullwidth` | didactic.dtx:1165-1184 | yes | `\IfStrEqCase` picks one `adjustwidth` form from the known option value (`page.adjustwidth`); `\columnwidth` changes are `sp.lengths` with calc syntax |
| `\textbytext` | didactic.dtx:1191-1197 | yes | `tbl.tabularx` `XX` row inside `fullwidth` |
| `\codebycode`, `\runbyrun` | didactic.dtx:1216-1226, didactic.dtx:1234-1236 | yes in form, blocked by EXTERNAL | aliases of `\textbytext` over `\lstexample` and `\runpython`; the commands they wrap are the EXTERNAL blockers |
| `\lstexample` | didactic.dtx:1094-1098 | yes in form, blocked by EXTERNAL | alias of `\inputminted[escapeinside=||,..]` (`code.minted`) |
| `pycode` functions `run_module`, `mintedoutput`, `\runpython` | didactic.dtx:1117-1143 | no | Python program run by the PythonTeX script; `mintedoutput` (didactic.dtx:1125-1131) is defined and never called in the file |
| `sidecaption`, `\flushscap` | didactic.dtx:568-588 | yes | `cap.kernel` and `sp.ragged`, with the memoir branch decided statically |
| option booleans `\if@didactic@*` | didactic.dtx:314-387 | yes | the emitter knows the class and options, so the branch is chosen at emit time |
| biblatex `\DeclareCiteCommand{\fullauthorcite}` | didactic.dtx:539-546 | yes (borderline) | biblatex's own declaration commands (`\usebibmacro`, `\usedriver`, `\DeclareNameAlias`) are the same package family as `bib.biblatex-biber`; not exercised by the sample |
| `didactic.ins` | didactic.ins:15-38 | yes | plain `docstrip` run that writes `didactic.sty` from the `package` guard; no tool outside TeX (it is `latex didactic.ins`, Makefile:17-18) |

## Content-opaque
none (`hello.py` at hello.py:1-7 is code text; its listing and run at didactic.dtx:219-247 are covered by the EXTERNAL blockers, not by this line)

## Lib changes
- New ways proposed: none. Considered and not proposed: `didactic` itself as a doc-kind way (every part decomposes into existing ways, and a way that loads `minted` and `pythontex` unconditionally would be EXTERNAL anyway); `pythontex` (published, but its parameter is a Python program and it needs the `pythontex` script, so it fails W2); `etoolbox` toggles (programming support, no printed component). `unique` (option `unq`, didactic.dtx:37-38) is read as the helper behind thmtools' `numbered=unless unique` key, a parameter of `thm.thmtools`; ctan.org/pkg/unique returned a 404 and that it ships with thmtools is from memory, not verified here. Load-only helpers `xparse`, `xkeyval`, `xstring` (didactic.dtx:27-29) have no printed effect and vanish when the macros are expanded.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
