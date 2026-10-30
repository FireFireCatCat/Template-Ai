yes

# 0093-foiltex: FoilTeX (the `foils` class for overhead transparencies and slides)

- Unverified: read from the source, not compiled.
- Source: Source/0093-foiltex/ (origin: https://mirrors.ctan.org/macros/latex/contrib/foiltex.zip; licence: nosell, the IBM "not to be sold or commercially exploited" user agreement, foiltex.ins:6-80 and foiltex.dtx:1153-1158; CTAN lists it as "Do Not Sell Except by Arrangement")
- Kind: presentation
- Lib: v1
- Engine: pdfLaTeX-compatible (the class detects pdfTeX at foiltex.dtx:1902-1911 and ignores `dvips`/`dvipsone` with a warning at foiltex.dtx:1923-1933; the sample's `dvips` option is a driver parameter an emitter would drop)
- Look carried by: class (the zip is the CTAN package of the `foils` class itself, as docstrip source; the sample adds only `latexsym`, header/footer commands from the class vocabulary, and one alias)
- Class origin: ctan (https://ctan.org/pkg/foiltex, read once: "A LaTeX2e class for overhead transparencies", author J. Hafner, IBM; the zip holds no unpacked `.cls`, `foiltex.ins:105-117` generates `foils.cls`, `foil17/20/25/30.clo`, `foilshrt.clo`, `foils.sty`, `fltfonts.def` and `sampfoil.tex` from `foiltex.dtx`)
- Main file: foiltex.dtx lines 1252-1647 (the docstrip module `sample`, which foiltex.ins:117 writes as `sampfoil.tex`; there is no standalone `.tex`) (other samples: none; the `driver` block at foiltex.dtx:38-79 is an `ltxdoc` documentation driver, not a template sample)
- Read: main yes, zip-local classes and styles all (none is a standalone file; the class, size options and font file are the `package`, `17pt`..`short`, `fonts` modules of foiltex.dtx:1702-4243, read in full, plus the user guide at foiltex.dtx:104-1245)

## Verdict
The zip is the source of one published CTAN class, `foils`, plus its sample. The sample's look is carried by that class: it loads `foils` with option `20pt`, uses only the class's own vocabulary (`\foilhead`, `\rotatefoilhead`, `\leftheader`, `\rightheader`, `\rightfooter`, `\Restriction`, `\LogoOn/Off`, `Theorem`/`Proof`, `boldequation`) and kernel constructs (itemize, enumerate, quote, `$$`, `equation`, `eqnarray`, `tabular`, `picture`, `footnote`, `marginpar`, `thebibliography`). Under W1 the class is one way, `class.foils`; its internals (kernel-hacking `\@makecaption`, `\@xfloat`, `\newtheorem`, `\@maketitle`, `\@begindvi`) would be `BESPOKE/class` if the class were zip-local, but it is published, so they are not counted. The two sample-local macros are reducible and there is no ART, so the answer is `yes`. This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.foils` options: `20pt` (the default size, redundant; foiltex.dtx:1258, default set at 1899), `dvips` (driver option; no effect under pdfLaTeX, foiltex.dtx:1923-1933). Unused options the class defines: `17pt` `25pt` `30pt` `shortform`, `headrule` `footrule`, `landscape`, `a4paper` `letterpaper` `ledgerpaper` `legalpaper` `a3paper` `a2paper` `a1paper` `35mmSlide` `Screen4to3` `Screen16to9`, `leqno` `fleqn` `draft` `openbib`, `magscalefonts` `useDCfonts` (foiltex.dtx:1749-1844)
- Class-native vocabulary used: `\foilhead[len]{text}` (foiltex.dtx:1320, 1332, 1366), `\rotatefoilhead{text}` (1555), `\leftheader` `\rightheader` `\rightfooter` (1301-1302, 1392-1394), `\Restriction` (1303), `\LogoOff` `\LogoOn` (1333, 1367), `\foiltexdate` (1302, 1394), `\FoilTeX` logo (1322), `Theorem`, `Corollary*`, `Proof` (1538-1550), `boldequation`, `boldequation*`, `\bm` (1520-1532), non-floating `figure` and `table` (1573, 1592), `\maketitle` as a title foil (1310), `abstract` on the title foil (1312), `\marginpar` made ragged (1615)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | foiltex.dtx:1258 | `class.foils` | options 20pt, dvips (dvips dropped by an emitter targeting pdfLaTeX) |
| paper size | foiltex.dtx:1749-1783, 1899 | `page.class-options` | default `letterpaper` (11in by 8.5in, portrait, 1752-1754); the sample sets no paper option; `landscape`, `a4paper`, `Screen16to9` etc. are the other values |
| margins, text block, head and foot heights | foiltex.dtx:2432-2556 | `class.foils` | not set by the sample; class sets `\oddsidemargin` 0, `\topmargin` 0, textwidth = paperwidth minus 2in, textheight = paperheight minus 2in minus `\head@footskip` (1in), headsep 14pt, headheight 15pt (2532-2533, 2529-2531, 2435-2447) |
| typeface and base size | foiltex.dtx:3771-4242, 4107-4117, 3558-3597 | `class.foils` | sans-serif default (`\familydefault` = `\sfdefault` = `fcmss`), roman `fcmr`, typewriter `fcmtt`, OT1 Computer Modern built from design sizes, `\normalsize` 20pt on 25pt leading, nothing smaller than 12pt; no font package loaded by the sample |
| size commands in text | foiltex.dtx:1403-1409 | `font.size-commands` | `\tiny` `\scriptsize` `\footnotesize` `\small` `\normalsize` `\large` `\Large` `\LARGE` `\huge` `\Huge` (at 20pt: 12, 12, 14, 17, 20, 25, 30, 36, 43, 51pt; foiltex.dtx:3558-3591, 1015-1024) |
| text marks | foiltex.dtx:1397-1402 | `mark.kernel` | `\textit` `\textsl` `\textbf` `\texttt` `\textrm` `\textsc` `\textsf` `\emph` (the class's `\em` toggles upright and slanted, 4132-4133) |
| spacing defaults | foiltex.dtx:2089-2099, 2112-2113, 2156-2157 | `class.foils` | not set by the sample; `\parskip` 18pt plus 4pt minus 4pt, `\parindent` 30pt, `\lineskip` 1pt, `\jot` 10pt, hyphenation off (`\lefthyphenmin` = `\righthyphenmin` = 100), `\sloppyfoils` (`\tolerance` 9000, `\hfuzz` 2pt) |
| ragged text | foiltex.dtx:1634 | `sp.ragged` | `\raggedright` inside one foil; `center` environment at 1380 |
| manual spacing in text | foiltex.dtx:1407-1408, 1394, 1530 | `sp.manual-space` | `\,`, `\quad`, `\hfil\break` |
| title block | foiltex.dtx:1281-1289, 1310, 2674-2706 | `front.maketitle` | `\title`, `\author` (four `\\`-separated lines, last in `\texttt`), `\date{\today}`; class `\maketitle` makes a title foil on its own page: `\Large\bfseries` centred title, author in `tabular[t]{c}`, date; `\abovetitleskip` 2em, `\titleauthorskip` 1.5em, `\authorauthorskip` .5em, `\authordateskip` 1em (2656-2660); class redefines `\today` as "Month D, YYYY" (2063-2066) |
| abstract | foiltex.dtx:1312-1315, 2718-2732 | `abs.kernel` | `abstract` environment on the title foil; centred bold `\abstractname` ("Abstract"), body in a list with `\listparindent` 1.5em, `\dateabstractskip` 1em, ends in `\vfill` |
| foil heading and new foil | foiltex.dtx:1320, 1332, 1366, 1391, 1415, 1439, 1462, 1493, 1516, 1536, 3108-3222 | `head.class-native` | `\foilhead[length]{text}`: `\vfill\eject` then `\large\bfseries` centred text, then space = `\parskip` + `\baselineskip` + `\foilheadskip` (18pt plus 0pt minus 18pt) + optional length; the sample uses `[-.5in]` (1332) and an empty `{}` (1366) |
| rotated foil | foiltex.dtx:1555, 3175-3195, 2545-2547, 3141-3142 | `head.class-native` | `\rotatefoilhead{Rotated Foils}`: swaps text width and height and, under pdfTeX, `\pdfpagewidth`/`\pdfpageheight`; the sample says it works under pdflatex without options (1560-1561); stays rotated until the next `\foilhead` (1564-1566) |
| header and footer | foiltex.dtx:1301-1303, 1333, 1367, 1392-1394, 1556, 1569, 2756-2838 | `hf.class-native` | `\leftheader{Jim Hafner}`, `\rightheader{\foiltexdate}`, `\Restriction{Is this for a restricted audience?}`, `\LogoOff` on one foil and `\LogoOn` after, later `\rightheader{}` `\leftheader{}` and `\rightfooter{\foiltexdate\quad\textsf{\thepage}}`; defaults `\MyLogo{-- Typeset by \FoilTeX\ --}` (2790) and `\rightfooter{\quad\textsf{\thepage}}` (2761); page style `foilheadings`, `\tiny` text, optional `headrule`/`footrule` options (1819-1820) unused |
| page numbering | foiltex.dtx:2850, 2676 | `pgnum.pagenumbering` | set by the class, not the sample: arabic, title foil is page 0 and shows no number (2812, 2821) |
| bullet list | foiltex.dtx:1345-1361, 2169-2243, 2368-2371 | `list.kernel` | `itemize` nested three levels; labels bullet, bold en-dash, asterisk, centred dot; `\leftmargini` 25pt, `\leftmarginii` 22pt, `\leftmarginiii` 18.7pt; level-1 spacing `\@listIa` (topsep, parsep, itemsep 14pt) |
| numbered list | foiltex.dtx:1375-1378, 2357-2367 | `list.kernel` | `enumerate`, labels `1.` `(a)` `i.` `A.` |
| block quote | foiltex.dtx:1370-1373, 2395 | `quote.kernel` | `quote` environment (a list with `\rightmargin` = `\leftmargin`) |
| framed box | foiltex.dtx:1380-1383, 1619, 2621-2626 | `box.fancybox` | `\framebox{...}`, `\fbox{...}`; `\fboxsep` 10pt, `\fboxrule` 1pt |
| parbox | foiltex.dtx:1381 | `box.minipage` | `\parbox{5.5in}{...}` inside `center` |
| display maths | foiltex.dtx:1441-1460, 1464-1504, 2123-2124 | `math.kernel` | `$$...$$`, `array` (`{clcr}`), `\left\right`, `equation`, `eqnarray` with `\nonumber`; number set as `(\theequation)` in sans, arabic; `amsmath` is not loaded |
| symbol package | foiltex.dtx:1277 | `math.amssymb` | `\usepackage{latexsym}` (published LaTeX base symbol-font package, used for `\Diamond` `\mho` and the proof box); the package is the parameter, as `font.helvet` was folded into `font.helvet`; no new way proposed |
| bold equations | foiltex.dtx:1518-1527, 3483-3487 | `math.kernel` | class-native `boldequation` and `boldequation*` = `\boldmath` + `$$...$$` + `\eqno` with `\refstepcounter{equation}` (starred: no number); `\label{eq:bold}` and `\ref` at 1520, 1527 |
| bold math inline | foiltex.dtx:1529-1532, 3481-3482 | `math.bm` | class-native `\bm{...}` (`\mathpalette` + `\boldmath`), same command name as the `bm` package, which an emitter would load instead |
| theorem-like statements | foiltex.dtx:1538-1550, 3408-3458 | `thm.class-native` | `Theorem` (numbered, optional note `[TUG'92]`), `Corollary*` (starred = unnumbered), `Proof` ending in a box; label bold sans, body `\slshape` (3416-3423); `Lemma` `Proposition` `Definition` predefined (3441-3445); class `\newtheorem` makes the starred twin (3408-3412) |
| cross-references | foiltex.dtx:1520, 1527, 1580, 1584 | `xref.kernel` | `\label`, `\ref` to an equation and a table |
| table | foiltex.dtx:1573-1582, 2608-2612 | `tbl.tabular` | `tabular{|l|c|r|}` with `\hline` and `\hline\hline`, inside `center` in a `table`; `\tabcolsep` 12pt, `\arrayrulewidth` 1pt, `\arraycolsep` 10pt |
| figure and table wrappers | foiltex.dtx:1573, 1592, 3022-3090 | `fig.graphicx` | kernel `figure` and `table` wrappers without `\includegraphics`; the class makes both non-floating (placement ignored, no lists of figures or tables), `figure*` and `table*` are unnumbered (`\newnonfloat`, 3060-3090) |
| captions | foiltex.dtx:1580, 1604, 2931-3010 | `cap.kernel` | `\caption{...}` below the content, "Table 1: text"; class `\@makecaption` centres a one-line caption or sets a `\parbox` of `\captionfraction` (1.0) times `\hsize`; `\abovecaptionskip` 15pt plus 5pt minus 5pt, `\abovefloatskip` 20pt plus 5pt minus 10pt |
| margin note | foiltex.dtx:1615, 2036-2042, 2464-2466 | `note.marginpar` | `\marginpar{...}`; class forces `\raggedright` (`\raggedleft` for left margin); `\marginparwidth` 54pt |
| footnotes | foiltex.dtx:1613, 1617, 2013-2016, 2449-2450 | `fn.kernel` | `\footnote{...}`; rule 0.4 `\textwidth` long, sans-serif marks, `\footnotesep` 10pt |
| citations and bibliography | foiltex.dtx:1620, 1623-1631, 2871-2900 | `bib.thebibliography` | `thebibliography{99}` with two `\bibitem`, `\cite{rocky}`; class prints `\refname` ("References") in `\large\bfseries` with no sectioning command |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand\bs{\char '134}` | foiltex.dtx:1305 | yes (body scope) | prints a backslash in `\texttt` for the sample's own documentation prose (1381-1382, 1401); kernel `\textbackslash` inside `\texttt`, no lib way needed; content helper |
| `\foiltexdate` | foiltex.dtx:14, 28; used at 1302, 1394 | yes (class scope constant) | a constant string, `2008/01/28`; defined by the class, so it is class vocabulary; an emitter can write the literal text into `hf.class-native` |
| class internals of `foils` (`\@makecaption` 2976-3004, `\@caption` 3005, `\@xfloat` 3022, `\newnonfloat` 3060, `\newtheorem` 3408, `\@maketitle` 2691, `thebibliography` 2875, `\ps@foilheadings` 2810, `\@foilhead` 3211, `\@begindvi` 3267, size files 3558-3702, `fltfonts.def` 3771-4242) | foiltex.dtx:1702-4243 | not applicable | published CTAN class, so counted as the one way `class.foils` (W1); would be `BESPOKE/class` only if the class were zip-local. Noted so the class dimension can be re-read under a stricter definition |
| `foiltex.ins` docstrip driver | foiltex.ins:1-138 | not applicable | `\input docstrip.tex` plus `\generateFile` lines; docstrip is TeX itself, so it is not `EXTERNAL`; it only unpacks the class and sample from the `.dtx` |

## Content-opaque
- `picture` environment drawn inside a `figure` (a framed box "gnat", two circles, a vector, an oval, a filled dot) at foiltex.dtx:1594-1602: figure artwork, content; a lib way would be `art.pstricks`.
- Bibliography entries (foiltex.dtx:1625-1629), formulas (1441-1534), accent and symbol lists (1417-1437), prose: content.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The sample is Jim Hafner's `sampfoil.tex` embedded in the `.dtx`; its own comments (foiltex.dtx:1253-1254) say the first lines are relevant only to the sample. No text in the zip is addressed to an AI.
- `foiltex.pdf` (6 pages, 369 KB) was not read: the PDF page renderer is not installed here, and it is documentation, not a source of the template.
- The class is a one-off look: sans-serif Computer Modern at 20pt and larger, centred bold `\foilhead` titles, a footer reading "-- Typeset by FoilTeX --" with page number, non-floating figures and tables. Under pdfLaTeX the class warns when `dvips` is given (foiltex.dtx:1923-1933) and the old `\@begindvi` hack at foiltex.dtx:3254-3271 is guarded only by `\CheckCommand*`; whether it still runs on a current TeX Live was not tested.
- The licence forbids selling or commercial exploitation of the program and derivatives (foiltex.dtx:1153-1158); that bears on bundling the class into a product, not on the rubric verdict.
- Accents and special characters in the sample (foiltex.dtx:1417-1437) are OT1 kernel text commands (content); no `fontenc` is loaded.
