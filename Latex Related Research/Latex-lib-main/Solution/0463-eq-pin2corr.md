no

# 0463-eq-pin2corr: eq-pin2corr (PIN security for exerquiz quizzes), package manual, demos and DocStrip source

- Unverified: read from the source, not compiled.
- Source: Source/0463-eq-pin2corr/ (origin: https://mirrors.ctan.org/macros/latex/contrib/eq-pin2corr.zip; licence: LPPL 1.2, eq-pin2corr.ins:11-16, eq-pin2corr.dtx:10-14 and the CTAN page; README.md states none)
- Kind: misc (a package manual with demo quizzes; the manifest hint `exam` reflects the quiz demos, not the document the main sample is)
- Lib: v4
- Engine: pdfLaTeX-compatible as the manual states (doc/eqpin2corrman.tex:304-308 lists pdflatex, lualatex, xelatex, dvips); the quiz logic runs only as JavaScript in Adobe Reader or Acrobat (README.md:5-7; doc/eqpin2corrman.tex:265-277)
- Look carried by: preamble (the manual's page, title, contents and heading look is the published `web` layer loaded through `aeb_pro` and tuned by preamble keys, doc/eqpin2corrman.tex:9-20, 121-148; the package adds no visible look beyond one text field)
- Class origin: tex-distribution-unbundled (`article` for the manual and demos, doc/eqpin2corrman.tex:6; `ltxdoc` for the `.dtx` driver, eq-pin2corr.dtx:21)
- Main file: doc/eqpin2corrman.tex (other samples: examples/qz-p2c.tex, examples/get-hash-string.tex, doc/install_jsfiles.tex; the `.dtx` driver at eq-pin2corr.dtx:20-110)
- Read: main yes, zip-local classes and styles all (no `.cls`, `.sty` or `.def` ships; `eq-pin2corr.sty` is generated from the `.dtx` by eq-pin2corr.ins:46-49, and the `.dtx` was read in full). Not read, because not in the zip: `aeb_pro`, `web`, `exerquiz`, `eforms`, `eq-save`, `spdef`, `aeb_mlink`, `acroman`, `lucidbry`.

## Verdict
No. The package is a published CTAN add-on (in TeX Live) whose whole effect is Acrobat JavaScript that gates the Correct button of an `exerquiz` quiz; TeX prints almost nothing of it. The manual that serves as the main sample ends its preamble with a `docassembly` block that runs in Acrobat and reads background PDFs that are not in the zip (`EXTERNAL`), and it leans on four unshipped packages and a dozen documentation macros whose definitions are not in the zip, so no way can be named for them (`UNMAPPED`). There is no `ART` blocker and no irreducible zip-local TeX: every macro the sample defines itself reduces.

## Blockers
- `EXTERNAL/preamble` `docassembly` JavaScript opens `C:/Users/Public/Documents/ManualBGs/Manual_BG_Brown.pdf`, saves, flattens and watermarks the output in Acrobat; with `buildIt=false` the watermark call still reads `Manual_BG_Print_pin2corr.pdf`, which the zip does not hold (doc/eqpin2corrman.tex:166-200, 171, 173, 194-198)
- `EXTERNAL/package` the package's one job runs in Acrobat's JavaScript engine (`Collab.hashString`, `app.response`, `app.alert`, `getField().readonly`), and the hash string that `\declPINId` needs is produced by running a JavaScript button in Acrobat, not by TeX (eq-pin2corr.dtx:271-336, 285, 376-391, 422-438; doc/eqpin2corrman.tex:375-390; examples/get-hash-string.tex:8-26). The PDF itself is built by TeX, so this is the weaker of my two EXTERNAL grounds; the verdict does not rest on it alone
- `EXTERNAL/body` a push button whose action is a JavaScript program defined with `defineJS`, shown as a live demo inside the manual (doc/eqpin2corrman.tex:152-161, 378-380)
- `UNMAPPED/package` `spdef` (doc/eqpin2corrman.tex:5, supplies `\ifusebw` used at 86, 89), `aeb_mlink` (21), `lucidbry` (46), `acroman` (58): none ships in the zip, and the CTAN pages read here (`eq-pin2corr`, `acrotex`, `aeb-pro`) name none of them, so W1 is not established; `aebxmp` (option, line 19) is an `aeb_pro` option whose effect was not read
- `UNMAPPED/body` documentation macros used throughout and defined in no file of the zip: `\cs` (334, 346, ...), `\pkg` (220, 227, ...), `\env` (227, 231, 442), `\opt` (331, 335, 338), `\cmd` (540, 548, ...), `\ameta` (355, 357, ...), `\darg` (355, 369, ...), `\bVerb` `\eVerb` `\takeMeasure` (313, 355, 435, ...), environment `dCmd` with `\bxSize` (359, 438, 475, ...), `\newtopic` (452, 489, ...), `\tightsettings` (279), `\eflength` (472)
- `UNMAPPED/body` PDF form widgets with script actions, `\pushButton` and `\textField` from `eforms` (doc/eqpin2corrman.tex:378-380; examples/get-hash-string.tex:47-59): considered `eforms` (CTAN `acrotex` bundle): W1, W3 and W4 pass, W2 fails for what the sample uses, because the action argument is a JavaScript program; not proposed

## Class setting
- Class: `class.article` options: `10pt` (doc/eqpin2corrman.tex:6); the other samples use no option (examples/qz-p2c.tex:1; examples/get-hash-string.tex:1; doc/install_jsfiles.tex:1). The `.dtx` driver uses `class.ltxdoc` (eq-pin2corr.dtx:21).
- Class-native vocabulary used: `\title` is replaced by `\DeclareDocInfo` (doc/eqpin2corrman.tex:121-134), `\maketitle` (204), `\tableofcontents` (208), `\part` (218, 445), `\section` `\paragraph*` `\footnote` `description` `enumerate` `itemize` (see the table).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | doc/eqpin2corrman.tex:6 | `class.article` | `10pt` |
| paper and size | doc/eqpin2corrman.tex:6 | `page.class-options` | `10pt` |
| math package | doc/eqpin2corrman.tex:7 | `math.amsmath` | `fleqn`; no display equation is typeset in the body (inline `$..$` only, 251, 254) |
| display alignment | doc/eqpin2corrman.tex:7 | `math.eqnumber` | `fleqn` (no effect visible in the sample) |
| screen page layout | doc/eqpin2corrman.tex:9-20 | `page.pdfscreen` | via `aeb_pro`: `web={centertitlepage,designv,forcolorpaper,latextoc,extended}`; demos `[designv]{web}` (examples/qz-p2c.tex:2) |
| title block | doc/eqpin2corrman.tex:121-141, 204 | `page.pdfscreen`, `front.maketitle` | `\DeclareDocInfo{university,title,author,email,subject,talksite,version,Keywords,copyrightStatus,copyrightNotice,copyrightInfoURL}`, `\universityLayout{fontsize=Large}`, `\titleLayout{fontsize=LARGE}`, `\authorLayout{fontsize=Large}`, `\maketitle` |
| contents | doc/eqpin2corrman.tex:26-27, 142, 207-209 | `page.pdfscreen`, `toc.kernel` | `\tocLayout{fontsize=Large,color=aeb}`, `\tocPartTitle{..}`, `\selectColors{linkColor=black}` then `webgreen`, `\tableofcontents` |
| heading looks | doc/eqpin2corrman.tex:143-148 | `page.pdfscreen` | `\sectionLayout{indent=-62.5pt,fontsize=large,color=aeb}`, `\subsectionLayout{indent=-31.25pt,color=aeb}`, `\subsubsectionLayout{indent=0pt,color=aeb}`, `\subsubDefaultDing`, `\widestNumber{0.00.}` |
| section depth | doc/eqpin2corrman.tex:61-62 | `num.secnumdepth` | `secnumdepth` 5, `tocdepth` 5 |
| heading numbers | doc/eqpin2corrman.tex:64-66 | `num.counters` | `\thesubsubsection`=bullet, `\theparagraph`=pilcrow, `\thesubparagraph`=two pilcrows (`\texorpdfstring` for the PDF string) |
| paragraph headings | doc/eqpin2corrman.tex:67-73 | `head.kernel` | `\@startsection{paragraph}{4}{0pt}{6pt}{-3pt}{\bfseries}`; `{subparagraph}{5}{\parindent}{6pt}{-3pt}{\bfseries}` |
| toc entry for paragraph | doc/eqpin2corrman.tex:70 | `toc.tocloft` | `\l@paragraph` = `\@dottedtocline{4}{5.0em}{1em}` (as `\cftparaindent` 5em, `\cftparanumwidth` 1em) |
| parts and sections | doc/eqpin2corrman.tex:218, 225, 310, 445 | `head.kernel` | `\part`, `\section`, `\paragraph*` |
| margin lengths | doc/eqpin2corrman.tex:53 | `page.setlength` | `\marginparwidth` +20pt |
| margin notes | doc/eqpin2corrman.tex:80-90, 281-298 | `note.marginpar`, `box.minipage`, `sp.manual-space`, `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.ragged` | `\marginpar{\raisebox{.5\baselineskip}{\parbox[t]{\marginparwidth}{\kern0pt\itshape\small\color{blue}\raggedleft\hspace{0pt}..}}}`; colour is `blue` or `gray` by `\ifusebw` (unread `spdef`) |
| lists | doc/eqpin2corrman.tex:266-278, 280-300, 407-421, 454-460 | `list.kernel` | `description` with `\item[..]`, `enumerate`, `itemize`; label `\descriptionlabel` = `\hspace\labelsep\normalfont #1` (116-117) |
| indented block | doc/eqpin2corrman.tex:77-79, 266, 377 | `list.kernel` | `\list{}{\leftmargin\amtIndent}\item\relax`, `\amtIndent`=`\parindent` (114) |
| code displays | doc/eqpin2corrman.tex:315, 342, 388, 410, 416 | `code.verbatim` | `Verbatim` with `xleftmargin=\amtIndent`, `fontsize=\small`, `commandchars=!()` (`fancyvrb` is loaded by an unread package, not by the sample) |
| inline marks | doc/eqpin2corrman.tex:110-112 | `mark.kernel` | `\uif`,`\app`=`\textsf`; `\psf`=`\textbf{\textsf{..}}` |
| url style | doc/eqpin2corrman.tex:109, 128, 456 | `meta.url` | `\urlstyle{sf}`, `\url` |
| links and metadata | doc/eqpin2corrman.tex:119, 216, 425, 455 | `meta.hyperref` | `\hypersetup{linktocpage}`, `\href`, `\texorpdfstring` (`\tops`); hyperref is loaded by an unread package |
| cross-references | doc/eqpin2corrman.tex:218, 223, 351, 710 | `xref.kernel`, `xref.hyperref` | `\label`, `\pageref`, `\ref`, `\hyperref[label]{text}` |
| footnotes | doc/eqpin2corrman.tex:371, 455-459 | `fn.kernel` | `\footnote` |
| spacing | doc/eqpin2corrman.tex:164, 757 | `sp.frenchspacing`, `sp.manual-space` | `\frenchspacing`; `\medbreak\noindent` |
| author monogram | doc/eqpin2corrman.tex:74-75, 91-92, 136-137, 758 | `math.amssymb`, `sp.manual-space` | `\mathfrak D`, `\mathfrak P`, `\mathcal S` with `\kern-.3em`, `\kern-.6em`; `\mathfrak` comes from a package the sample does not load |
| quiz | doc/eqpin2corrman.tex:237-257, 492-514, 552-574, 613-635, 666-689, 728-750 | `exam.questions` | package `exerquiz` (unread): `quiz*{name}`, `questions`, `answers{8}`, `\bChoices` `\Ans0..\eAns` `\eChoices`, `\RespBoxMath{ans}{n}{tol}{interval}`, `\CorrAnsButton`; interactive part is Acrobat JavaScript (`EXTERNAL`, see Blockers) |
| quiz controls | doc/eqpin2corrman.tex:30-32, 257, 511 | `exam.questions` | `\useBeginQuizButton[\CA{Begin}]`, `\useEndQuizButton[\CA{End}]`, `\useMCCircles`, `\ScoreField[\rectW{2.25in}]`, `\CorrButton`, `\AnswerField` |
| PIN add-on | doc/eqpin2corrman.tex:22, 34, 235; eq-pin2corr.dtx:160-163, 348-358, 461-478 | `exam.questions` | package `eq-pin2corr`: option `!showscore` (`showscore`), `\declPINId{pin}{hash}`, `\declRePINId`, `\classPINVar`, `\usePINCorrBtn`/`\restoreCorrBtn`, `\useWarnEndQuiz`, `\FreezeThisQuiz`, `\useBeginQuizPIN`, `\useBeginQuizCnt`, `\qzResetTally`, `\setMaxRetakes{qz}{n}`; strings, one boolean option and integers; behaviour is JavaScript (`EXTERNAL`) |
| quiz side note | doc/eqpin2corrman.tex:238 | `box.minipage`, `sp.manual-space`, `color.xcolor`, `font.icons` | `\hfill\llap{\smash{\parbox[t]{145pt}{\leavevmode\llap{\color{red}\ding{042}\enspace}..}}}` (pifont `\ding`) |
| `.dtx` driver class | eq-pin2corr.dtx:21 | `class.ltxdoc` | no options |
| `.dtx` documentation | eq-pin2corr.dtx:29-32, 86, 99-108, 112 | `dtx.doc` | `\OnlyDescription`, `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\GetFileInfo`, `\DocInput`, `\MakeShortVerb{\|}`, `\PrintIndex`, `\PrintChanges` |
| `.dtx` links and code | eq-pin2corr.dtx:23-24 | `meta.hyperref`, `code.verbatim` | `hyperref[colorlinks,hyperindex=false]`, `fancyvrb` |
| `.dtx` title and contents | eq-pin2corr.dtx:87-98 | `front.maketitle`, `toc.kernel`, `num.secnumdepth` | `\title \author \date \maketitle`, `\tableofcontents`, `secnumdepth`/`tocdepth` 5 then 3 inside a group |
| `.dtx` headings | eq-pin2corr.dtx:47-73 | `head.kernel`, `num.counters` | `\@startsection` calls for section to subparagraph, `\theparagraph` and `\thesubparagraph` with pilcrows |
| `.dtx` helper | eq-pin2corr.dtx:25 | none | `calc`: a length-expression helper with no printed effect; considered, not proposed (nothing to wrap, W4) |
| quiz demo (qz-p2c) | examples/qz-p2c.tex:1-4, 8-12, 19-21, 23-24, 28, 40-64 | `class.article`, `page.pdfscreen`, `exam.questions`, `sp.lengths` | `[designv]{web}`, `\showCreditMarkup`, `\parindent0pt\parskip6pt`, `\section*`; lines 69-99 lie after an `\end{document}` at 67 |
| hash demo | examples/get-hash-string.tex:1-3, 6, 8-26, 40-59 | `class.article`, `page.pdfscreen`, `code.verbatim`, `mark.kernel` | `eforms` buttons and fields (`UNMAPPED`/`EXTERNAL`), `verbatim`, `\cs` defined at line 6 |
| install notes | doc/install_jsfiles.tex:1-12, 15-21, 136-142, 163-173 | `class.article`, `page.pdfscreen`, `math.amsmath`, `math.eqnumber`, `head.kernel`, `code.verbatim`, `font.icons` | `[fleqn]{amsmath}`, `[web]{aeb_pro}`, `fancyvrb`, `pifont` `\ding`, `equation`+`minipage` displays (136-142), `\paragraph` via `\@startsection`; JavaScript buttons (34-37) are `EXTERNAL` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\paragraph`, `\subparagraph`, `\theparagraph`, `\l@paragraph` | doc/eqpin2corrman.tex:64-73 | yes | `head.kernel` with the six `\@startsection` values above, `num.counters`, `toc.tocloft`; caution: `\renewcommand{\@seccntformat}` inside `\paragraph` changes global state, and whether the unread `web` layer resets it was not read |
| `\dps` (defined three times; the last wins) | doc/eqpin2corrman.tex:74-75, 91-92, 136-137 | yes | `math.amssymb` letters with `\kern` |
| `aebQuote` | doc/eqpin2corrman.tex:77-79 | yes | `list.kernel` one-item `\list` with `\leftmargin`=`\parindent` |
| `\FmtMP`, `\parboxValign`, `\aebbkFmtMp` | doc/eqpin2corrman.tex:80-90 | yes | inline expansion: `\parboxValign` is the constant `t`; `\ifusebw` is a constant of the unread `spdef`, the emitter keeps one branch |
| `\BlogArticle` | doc/eqpin2corrman.tex:87-90 | yes, and never called | `font.icons` (`\Pisymbol{webd}{254}`, `\ding{045}`); a `webd` family is not defined in the zip |
| `\chgCurrLblName`, `\echgCurrLblName`, `\db` | doc/eqpin2corrman.tex:94-96 | yes, and never called | nothing to emit |
| `\uif`, `\app`, `\psf`, `\tops` | doc/eqpin2corrman.tex:110-112, 119 | yes | aliases: `mark.kernel`, `meta.hyperref` |
| `\AcroT`, `\AcroEB`, `\AcroB`, `\bUrl` and colour copies | doc/eqpin2corrman.tex:211-214 | yes | text macros expanded inline; `color.xcolor` `blue` |
| `\def\1`, `\def\2` (code-display captions) | doc/eqpin2corrman.tex:313-314, 358, 436-437, 473-474 | yes | `\rlap{\hskip..}` with `\sffamily`: `sp.manual-space` |
| `\cs` (demo) | examples/get-hash-string.tex:6 | yes | `\texttt{\eqbs#1}`: `mark.kernel`; `\eqbs` comes from an unread package |
| `.dtx` driver macros | eq-pin2corr.dtx:33-45, 74-79 | yes | `\brpr`, `\ameta`, `\SUB`, `aebQuote`: `mark.kernel`, `list.kernel`; `\let\@latex@warning\@gobble` has no printed effect |
| `eq-pin2corr` package code | eq-pin2corr.dtx:160-526 | not bespoke: published (CTAN, TeX Live) | JavaScript strings through `defineJS`, hooks `\let` into `exerquiz` internals (`\eQzBtnActns` 212-220, `\CorrBtnActionsJS` 226-237, `\BeginQuizG@te` 402-404), token vacuums `\PINgobii` `\PINgobiii` (375, 419); effect is `EXTERNAL`, not typesetting |
| `defineJS{\btnAct}` | doc/eqpin2corrman.tex:152-161 | no | JavaScript for Acrobat (`EXTERNAL/body`) |
| `docassembly`, `\chngDocObjectTo` | doc/eqpin2corrman.tex:166-200 | no | Acrobat document assembly (`EXTERNAL/preamble`) |
| documentation macros of unshipped packages | doc/eqpin2corrman.tex:313-360, 452, 279 | not decidable | definitions are not in the zip (`UNMAPPED/body`) |

## Content-opaque
none. The answer keys inside `\RespBoxMath{-1}{1}{.0001}{[0,1]}` and `\CorrAnsButton{-1}` (doc/eqpin2corrman.tex:251-255) are content; the quiz fields themselves are not treated as content, they are in Blockers.

## Lib changes
- New ways proposed: `page.pdfscreen` (the `web` package of the AcroTeX bundle, pdfLaTeX; CTAN `acrotex` page lists it as "redefines page layout to web-friendly dimensions"; loaded here through `aeb_pro`, itself on CTAN as `aeb-pro`). W1: on CTAN, in the `acrotex` bundle (read at ctan.org/pkg/acrotex). W2: chosen by options (`designv`, `forcolorpaper`, `centertitlepage`, `latextoc`) and by key-value layout commands (`\sectionLayout{indent=,fontsize=,color=}`). W3: serves any document that is read on screen, not this manual. W4: preamble option and key lines. Its source was not read; the way's name and parameters come from the sample's usage and the CTAN description. A sibling of `page.pdfscreen`, which is a different package.
- Considered, not proposed: `eforms` (W2 fails for script actions), `calc` (no printed effect).
