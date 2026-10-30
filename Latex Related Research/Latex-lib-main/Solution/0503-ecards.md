no

# 0503-ecards: eCards, electronic flash cards (D. P. Story, AcroTeX)

- Unverified: read from the source, not compiled.
- Source: Source/0503-ecards/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ecards.zip; licence: LPPL 1.2 per the manifest; ecards.dtx:8-12 names the LPPL, version 1 or later; ctan.org/pkg/ecards read: LPPL 1.2, TeX Live contrib, "uses the acroTeX bundle")
- Kind: exam
- Lib: v5
- Engine: pdfLaTeX-compatible (doc/ecardsman.tex:229-241 says `web`/`exerquiz`/`ecards` take the pdftex driver automatically; the cards then need Acrobat JavaScript at view time; the manual's `docassembly` also needs Acrobat, see Blockers)
- Look carried by: mixed (the published package `ecards` over `web` and `exerquiz` defines the question, hint and answer pages and the nav panel; the sample's preamble sets their parameters and a logo alias)
- Class origin: tex-distribution-unbundled
- Main file: examples/ecardstst.tex (other samples: doc/ecardsman.tex, which the manifest lists as `main` and is the package manual typeset with `aeb_pro`; examples/ecardstst_nohint.tex)
- Read: main yes, zip-local classes and styles all (no `.cls` or `.sty` is shipped; `ecards.sty` is generated from `ecards.dtx` by `ecards.ins`, and the whole `.dtx` was read; the sources of `web`, `exerquiz`, `insdljs`, `eforms`, `aeb_pro` are not in the zip and were not read)

## Verdict
no. The demo deck and the package code map onto lib ways under `class.article`, and every alias in the demo reduces, so the template proper is close to `yes`. The zip also ships the manual `doc/ecardsman.tex` (the manifest's main), and that file has an Acrobat-run `docassembly` build step (EXTERNAL) and an `acroman` style that is neither shipped nor on CTAN, so its body macros cannot be read or reduced. For the cards themselves it is not established that pdfLaTeX alone yields the working deck, because the card navigation is document-level JavaScript that the manual says Acrobat must save. A wrong yes costs more, so the verdict is `no`. No text addressed to an AI was found in the zip.

## Blockers
- `EXTERNAL/preamble` Acrobat-run JavaScript build in the manual: `docassembly` opens a blank background PDF from `C:/Users/Public/Documents/ManualBGs/`, saves a copy, flattens it and adds it as a watermark with `\appopenDoc`, `\docSaveAs`, `\addWatermarkFromFile`, `\executeSave` (doc/ecardsman.tex:61-94); needs Acrobat, and a local file the zip does not ship
- `BESPOKE/preamble` the manual loads `acroman` (doc/ecardsman.tex:17): not in the zip, and ctan.org/pkg/acroman is a 404, so it is not published; it supplies the manual's body macros `\app` `\pkg` `\opt` `\env` `\cs` `\ameta` `\darg` `\bVerb` `\eVerb` `\takeMeasure`, the `dCmd` environment, `\amtIndent`, `\bxSize` (doc/ecardsman.tex:154,233,278-283,424-437); the source is absent, so reducibility cannot be shown. `lucidbry` (doc/ecardsman.tex:13) is also not shipped and was not checked
- `EXTERNAL/package` Acrobat JavaScript runtime of the cards: `ecards` loads `web` and `exerquiz` unconditionally (ecards.dtx:320-321), turns the `insdljs` import on (ecards.dtx:1024) and ships the card logic as document-level JavaScript (`getNextCard`, `beginECards`, `toggleOrder`, ecards.dtx:1029-1169); the manual says imported document-level JavaScript is stored only when the PDF is opened and saved in Acrobat, which the `execJS` option automates, for the pdftex route too (doc/ecardsman.tex:342-350); `insdljs.sty` is not in the zip and its CTAN page does not say how pdfTeX embeds it. Not established either way; counted under the rubric's rule for unsure cases

## Class setting
- Class: `class.article` options: none (examples/ecardstst.tex:1; same in the other two samples)
- Class-native vocabulary used: `\title`, `\author`, `\maketitle` (examples/ecardstst.tex:29-30,101); the manual adds `\section`, `\subsection`, `\paragraph*`, `\tableofcontents` (doc/ecardsman.tex:101,146,265)

## Component map
The look of the cards is in `ecards.dtx` (published) and in the demo's preamble. Rows 1 to 18 are the demo deck, 19 to 30 the package code, 31 to 42 the manual and the documentation driver.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| 1 class | examples/ecardstst.tex:1 | `class.article` | no options |
| 2 maths package | examples/ecardstst.tex:2 | `math.amsmath`, `math.eqnumber` | option `fleqn`; no maths in the body |
| 3 images in answers | examples/ecardstst.tex:3,119 | `fig.graphicx` | `\includegraphics[scale=\rescale]{presidents/gw1}`, scale .4 (line 96); no float; `.jpg` `.png` `.pdf` `.eps` all shipped in examples/presidents/ |
| 4 screen page and nav panel | examples/ecardstst.tex:5 | `page.pdfscreen` | `web` options `tight`, `rightpanel`; pdfTeX support rests on doc/ecardsman.tex:229-241, `web` source not read |
| 5 page size | examples/ecardstst.tex:16-17 | `page.pdfscreen` | `\margins{.25in}{.25in}{24pt}{.25in}`, `\screensize{3.72in}{366.24bp}` |
| 6 title block | examples/ecardstst.tex:29-30,101 | `front.maketitle` | `\title`, `\author`, `\maketitle` |
| 7 title fields | examples/ecardstst.tex:18-28,31,36 | `page.pdfscreen` | `web` field commands `\subject`, `\keywords`, `\university{..\\..}`, `\email`, `\version{2.0}`, `\copyrightyears{\the\year}`, `\norevisionLabel`, `\hproportionwebtitle` .9 |
| 8 PDF string | examples/ecardstst.tex:30 | `meta.hyperref` | `\texorpdfstring{\\}{,}` |
| 9 colours | examples/ecardstst.tex:33-34 | `color.color`, `page.pdfscreen` | `\definecolor{logoblue}{rgb}{0,0,0.267}`; `\panelBgColor{logoblue}` |
| 10 panel logo text | examples/ecardstst.tex:37-39; ecards.dtx:968 | `box.minipage`, `font.size-commands`, `color.color`, `mark.kernel`, `sp.manual-space`, `fig.rotating` | `\parbox{1.75in}`, `\large`, `\small`, `\color{red}` `\color{blue}`, `\textsl`, `\smash` `\raisebox{3pt}` `\hfill`; ecards rotates it with `\rotatebox{-90}` |
| 11 first-page instructions | examples/ecardstst.tex:41-83 | `page.pdfscreen`, `box.fancybox`, `box.minipage`, `sp.manual-space`, `sp.ragged`, `color.color`, `meta.hyperref`, `mark.kernel` | `\optionalPageMatter{..}`, `\vspace{\stretch{1}}`, `center`, `\fcolorbox{blue}{webyellow}`, `minipage` .85`\linewidth` (47) or .67`\linewidth` (67), `\textbf`, `\textcolor`, `\href{http://www.whitehouse.gov/history/presidents/}` (58-59) |
| 12 ecards strings and link | examples/ecardstst.tex:86-93 | `exam.questions` | `\ecLogoLink{http://www.uakron.edu/}`, `\cardsFinishedMsg{..}`, `\pressBeginMsg{..}`; `\noHintJSAction{app.alert(..)}` is JavaScript, see Content-opaque |
| 13 indentation | examples/ecardstst.tex:97 | `sp.lengths` | `\parindent0pt` |
| 14 cards | examples/ecardstst.tex:109-235 | `exam.questions` | `ecards[memLogo]` (line 7): `card` > `response` > `hint` + `answer`, six cards; optional argument `hint` or `nohint` (ecards.dtx:506-515) |
| 15 multiple choice | examples/ecardstst.tex:147-150,154-157 | `exam.questions` | `multiChoice{2}` with `\Ans0` `\Ans1`, `&` and `\\` columns (exerquiz `answers`, ecards.dtx:438-457) |
| 16 fill-in | examples/ecardstst.tex:174-176 | `exam.questions`, `form.eforms` | `fillIn`, `\RespBoxTxt[\rectW{1.5in}]{0}{0}{2}{James Madison}{Madison}`; text field appearance `\everyRespBoxTxt{\BG{1 1 1}}` (ecards.dtx:474) |
| 17 answer layout and listing head | examples/ecardstst.tex:104,118,172,178 | `sp.ragged`, `font.size-commands`, `mark.kernel`, `sp.manual-space` | `\centering`, `\raggedright`, `\Large\bfseries`, `\bigskip`; the heading (103-107) prints only under `listing` |
| 18 hint switches | examples/ecardstst_nohint.tex:10,126,147,200,225 | `exam.questions` | `ecards[memLogo,nohints]`, `\useHints`, `\useNoHints`, `card[nohint]`, `card[hint]` |
| 19 package options | ecards.dtx:235,249,256,262,312 | `exam.questions` | `memLogo`, `listing`, `custom`, `nohints`, `notrandomized` |
| 20 card page layout | ecards.dtx:559-575,646-662,692-707 | `sp.manual-space`, `sp.ragged`, `font.size-commands`, `box.minipage`, `mark.kernel` | per page `\vspace*{\stretch{.1}}`, `center`, `\Large` title (`\textbf{QUESTION}`, `HINT`, `ANSWER`), skip .25in (550,637,683), `minipage` .85`\linewidth` (552,639,685), `\large\noindent`, tail `\vspace{\stretch{2}}` |
| 21 page colours | ecards.dtx:336,343-345 | `page.pdfscreen` | `\textBgColor{cornsilk}`, `\cardColor{vlightblue}`, `\hintColor{cornsilk}`, `\solnColor{webyellow}` (`web` background commands) |
| 22 nav icons | ecards.dtx:717,848-871,913-914 | `page.pdfscreen` | `\newNaviIcon[j]` buttons `Soln` `Hint` `Next` `Prev` `Begin` `Home` `FS` `Close`; `\iconWidth` 40pt, `\iconHeight` 15pt, `\iconWidthPanel` 28pt, `\panelGrpWidth` 57pt |
| 23 nav panel and bar | ecards.dtx:922-946,963-971,989-991 | `page.pdfscreen`, `box.minipage`, `meta.hyperref` | `\buildpanel`, `\panelNaviGroup` with `\parbox[c]{\panelGrpWidth}`, logo `\href{\@ecLogoLink}`, bottom bar `\insNaviBar` when no panel |
| 24 random-order check box | ecards.dtx:886-889 | `form.eforms` | `\checkBox[\A{\JS{toggleOrder();}}\DV \V \TU \textSize{0} \textColor{1 0 0} \BC{0 0 .8}]{eccbtoggleorder}{9bp}{9bp}{randomOrder}` |
| 25 page open action | ecards.dtx:1012-1016 | `form.eforms` | `\thisPageAction{\JS{}}{\JS{..}}`; the value is JavaScript |
| 26 default logo | ecards.dtx:731 | `fig.graphicx` | `\includegraphics[scale=.4]{graphics/uakron}`; the file is examples/graphics/uakron.* |
| 27 listing mode | ecards.dtx:1204-1230,1236-1239,1277-1278,1302-1303 | `exam.questions`, `num.counters`, `mark.kernel`, `box.minipage` | `\newcounter{ecCnt}`, bold `\arabic{ecCnt}.\thinspace` in `\makebox[0pt][r]`, `\textit{Hint}:` `\textit{Answer}:`; `ecardslist.def` is read at ecards.dtx:1175 |
| 28 proofing answer format | ecards.dtx:415-426 | `mark.kernel`, `sp.lengths` | `\textbf{Ans:\thinspace[}`, `\ttfamily`, `\spaceskip=2pt\xspaceskip=2pt` |
| 29 customisation file | ecard.cus:4-9; ecards.dtx:1180 | `mark.kernel` | `custom` option inputs it; it renews `\listing@headHint` to `\textit{Try this}!`; the demos do not select `custom` |
| 30 doc-level JavaScript | ecards.dtx:1029-1169 | none | JavaScript program, see Content-opaque and Blockers |
| 31 documentation driver | ecards.dtx:19-47 | `class.ltxdoc`, `dtx.doc`, `meta.hyperref` | `ltxdoc`, `hyperref[colorlinks,hyperindex=false]`, `\OnlyDescription`, `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput`, `\PrintIndex`, `\PrintChanges`; `aebdocfmt.def` is optional with a fallback (26-28); index and change list print a note when `.ind` or `.gls` is absent (41-46) |
| 32 manual class, maths | doc/ecardsman.tex:2-3,10 | `class.article`, `math.amsmath`, `math.eqnumber`, `fig.graphicx`, `tbl.tabular` | `fleqn`; `graphicx`, `array` loaded, no tabular in the body |
| 33 manual page and title | doc/ecardsman.tex:4-9,23-37,42-51,98 | `page.pdfscreen`, `form.eforms`, `front.maketitle` | `aeb_pro[web={centertitlepage,designv,forcolorpaper,latextoc,pro},eforms,..]`, `\DeclareDocInfo{..}`, `\universityLayout`, `\titleLayout`, `\tocLayout{fontsize=Large,color=aeb}`, `\sectionLayout{indent=-62.5pt,fontsize=large,color=aeb}`, `\widestNumber{0.00.}`; `aeb_pro` source not read |
| 34 manual metadata options | doc/ecardsman.tex:4-9,23-37 | `meta.hyperxmp`, `meta.hyperref` | `aebxmp`, `linktoattachments` and `\DeclareDocInfo` are `aeb_pro` commands; closest ways by name, source not read |
| 35 manual fonts | doc/ecardsman.tex:13 | `font.serif-pkg` | `lucidbry[altbullet]`, not shipped, not read; the way is the closest guess |
| 36 manual contents, headings | doc/ecardsman.tex:100-102,146,207,265 | `toc.kernel`, `head.kernel`, `page.pdfscreen` | `\selectColors{linkColor=black}`, `\tableofcontents`, `\section` `\paragraph*` |
| 37 manual links, text switches | doc/ecardsman.tex:21,31,58,126,150,176 | `meta.url`, `meta.hyperref`, `xref.hyperref`, `sp.frenchspacing` | `\urlstyle{sf}`, `\url`, `\href`, `\hypersetup{linktocpage}`, `\hyperref[..]{..}`, `\frenchspacing` |
| 38 manual figures | doc/ecardsman.tex:166-174,183-191,202-205 | `fig.graphicx`, `cap.kernel`, `xref.kernel`, `box.minipage`, `box.fancybox`, `sp.manual-space`, `sp.lengths` | `figure[htb]`, `\includegraphics[width=.32\linewidth]`, `minipage{\linewidth+62.5pt}` with `\hskip-62.5pt`, `\caption`, `\label`, `\fbox`, `\fboxsep` 0pt; the images in doc/graphics/ are not shipped |
| 39 manual lists, notes | doc/ecardsman.tex:255,267-308,360-410 | `list.kernel`, `fn.kernel`, `mark.kernel` | `enumerate`, `itemize`, `\footnote`, `\texttt` `\textsf` |
| 40 manual code blocks | doc/ecardsman.tex:233,289,330,364 | `code.verbatim` | `Verbatim` with `xleftmargin=\amtIndent`, `commandchars`; which package supplies it is not shown (`acroman` not available) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand\aebLogo` | examples/ecardstst.tex:37-39 | yes | inline the `\parbox` text of row 10; ecards uses it only at ecards.dtx:968 |
| `\makeatletter` block with `\ifecListing` and `\ifnum\@panelconfig>0` | examples/ecardstst.tex:41-83 | yes | both tests are fixed by the same file (`rightpanel` at line 5, no `listing` at line 7), so emit only the first `\optionalPageMatter` branch (44-62) of row 11 |
| `\def\rescale{.4}` | examples/ecardstst.tex:96 | yes | write `scale=.4` in each `\includegraphics` |
| `\ifecListing .. \else \centering .. \fi` in answers | examples/ecardstst.tex:116-122 (also 134-140, 160-166, 186-192, 208-214, 226-232) | yes | `ecards` boolean set by option `listing`; emit the `\else` branch (row 3, `sp.ragged`) for the screen build |
| `\renewcommand\noHintJSAction{app.alert("..")}`, `\pressBeginMsg` | examples/ecardstst.tex:89,92-93 | yes | string values of documented ecards commands (doc/ecardsman.tex:403-409); the JavaScript text is outside the way as in `form.eforms` |
| `ecard.cus` | ecard.cus:4-9 | yes | not loaded by any sample; one `\renewcommand` of a hook to italic text (`mark.kernel`) |
| ecards package code, including its edits of `exerquiz` internals (`\endsolnexerhookaux`, `\include@solutions`, `\ReturnTo`) | ecards.dtx:359-380,400 | not counted | published (ctan.org/pkg/ecards read), so a way, not bespoke; had it been zip-local it would be BESPOKE/class, irreducible |
| `ecards.ins` | ecards.ins:50-54 | not a template part | docstrip driver that writes `ecards.sty` and `ecardslist.def`; TeX only |
| manual `docassembly` | doc/ecardsman.tex:61-94 | no | Acrobat JavaScript, see Blockers |
| manual `acroman` macros | doc/ecardsman.tex:17,154,233,278-283 | no | source absent, see Blockers |
| manual `\def\dps` (twice), `\def\AcroT`, `\AcroEB`, `\AcroB`, `\bUrl` | doc/ecardsman.tex:39-40,55-56,121-124 | yes | inline expansion; `\mathfrak` and `\mathcal` from `math.amssymb`, `\kern` as `sp.manual-space` |

## Content-opaque
- JavaScript text: `\noHintJSAction` (examples/ecardstst.tex:89; examples/ecardstst_nohint.tex:89), the `\JS{..}` action strings (ecards.dtx:887,1013-1015) and the document-level script (ecards.dtx:1029-1169)
- Portrait images in the answers: examples/presidents/*.jpg|png|pdf|eps and examples/graphics/uakron.* (images, not template artwork)
- Exerquiz answer keys in `\Ans0`/`\Ans1` and `\RespBoxTxt{..}{James Madison}{Madison}` (examples/ecardstst.tex:147-150,175)
- Template artwork: none (no TikZ, PGF, PSTricks or `picture` anywhere in the zip)

## Lib changes
- New ways proposed: none. Considered: `ecards` as a doc-kind way of its own; it is kept under `exam.questions`, whose line already admits other question-bank packages as the parameter (the package is `exerquiz`/`ecards`, with `card`, `response`, `hint`, `answer`, `multiChoice`, `fillIn`). `web` stays the parameter of `page.pdfscreen`; this zip gives it a pdfTeX reference (doc/ecardsman.tex:229-241) the lib line lacks.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
