yes

# 0030-seu-ml-assign: SEU Machine Learning Assignment template (seu-ml-assign class)

- Unverified: read from the source, not compiled.
- Source: Source/0030-seu-ml-assign/ (origin: https://mirrors.ctan.org/macros/latex/contrib/seu-ml-assign.zip; licence: MIT, seu-ml-assign.cls:9, README.md:33-34)
- Kind: assignment
- Lib: v1
- Engine: pdfLaTeX-compatible (sample header `%! TEX program = pdflatex`, seu-ml-assign-sample.tex:1; class header lists latex, pdflatex, xelatex, lualatex, seu-ml-assign.cls:11). The class selects the `LinuxLibertineT-OsF`, `LinuxBiolinumT-OsF`, `bch` and `cmr` families by `\fontfamily` without loading a font package (seu-ml-assign.cls:115, 326, 330); they are not shipped in the zip, so the TeX distribution must provide them (assumed from TeX Live's libertine and charter; not checked).
- Look carried by: class (the main sample adds no preamble and no zip-local macro; every look decision is in `seu-ml-assign.cls`, a CTAN class)
- Class origin: ctan (zip is the CTAN package itself: README.md:27-28 "contained in CTAN, and so is in TeX Live"; `\ProvidesClass{seu-ml-assign}`, seu-ml-assign.cls:16)
- Main file: seu-ml-assign-sample.tex (other samples: seu-ml-assign-doc.tex, which the manifest lists as `main`; it is the class manual and also loads the class)
- Read: main yes (sample 385 lines and doc 347 lines, in full), zip-local classes and styles all (seu-ml-assign.cls, 369 lines, in full). Not read: seu-ml-assign-doc.pdf (compiled manual, binary).

## Verdict
yes. The look is carried entirely by the published CTAN class `seu-ml-assign`, and the main sample adds only content plus the class's own front-matter fields and sectioning commands (seu-ml-assign-sample.tex:3-17, 21-22). This is the pilot's "look carried by a published class" case, so the result is evidence about the class dimension, not about component ways. The class internals are heavy (TikZ gradient rules, a TikZ heading band, a tcolorbox underlay, a rewritten `\maketitle`); they are recorded under Bespoke code and would be `ART/class` and `BESPOKE/class` if the class were not published, but under the rubric they sit inside one published way. The only zip-local definition outside the class is the manual's `\grayrow` alias (seu-ml-assign-doc.tex:26), which is reducible.

## Blockers
none

## Class setting
- Class: `class.seu-ml-assign` options: `oneside` (default) or `twoside`; `solution` (default) or `problem`; `9pt` `10pt` (default) `11pt` `12pt` (seu-ml-assign.cls:19-29; README.md:11-20). The class then does `\LoadClass[a4paper,onecolumn,<ptsize>]{article}` (seu-ml-assign.cls:31). The sample uses `[oneside,solution]` (sample:3); the manual uses `[twoside]` (doc:3). Quirk, not checked: `9pt` is documented but article declares only 10pt, 11pt and 12pt.
- Class-native vocabulary used: `\title` `\author` `\date` plus `\studentID` `\instructor` `\duedate` `\assignno` `\semester` `\mainproblem` (cls:46-51; sample:5-13), `\maketitle` (cls:292), `\problem[points]{title}` and `\problem*` (cls:106-107), `\subproblem{}` and `\subproblem*` (cls:127-128), `\subsubproblem` (cls:130-131), `\problempts`, `\setproblem`, `\setsubproblem` (cls:69, 104-105), string hooks `\sectionheadname` `\solutionname` `\pdftitleadditionalname` `\hintstyle` (cls:71, 108, 144, 290), `\startsolution[print]` (cls:109-124; commented out at sample:19, shown at doc:191), `\hint{}` (cls:145), environments `fancybox{title}` and `notice{title}` (cls:182-212; doc:286, 298), `theorem` `proposition` `lemma` `corollary` `proof` (cls:136, 140-143), operators `\argmin` `\argmax` (cls:146-147).

## Component map
Part A is what the main sample uses; part B is what the class does inside; part C is what only the manual's preamble and body add.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| A class | sample:3 | `class.seu-ml-assign` | oneside, solution |
| A front-matter fields | sample:5-13; cls:39-51 | `front.class-native` | title=Assignment, author, studentID, instructor, date=\today, duedate, assignno=1, semester, mainproblem (strings stored by `\gdef`) |
| A title block | sample:17; cls:292-368 | `front.class-native` | two minipages 10.5cm and 5cm; "Machine Learning" 36/48pt small caps Plum; ID, author, "Instructor:"; semester BrickRed; title+number `\LARGE`; cyan fading rule; optional centred `\S main problem \S` RoyalPurple!50!black |
| A problem heading | sample:21, 38, 197; cls:85-93, 106 | `head.class-native` | `\problem{title}` calls `\section`; optional argument is the points shown at right; prefix word from `\sectionheadname` |
| A sub-problem heading | sample:22 etc.; cls:126-127 | `head.class-native` | `\subproblem{}` calls `\subsection`; run-in, label `(\arabic{subsection})`, empty title in the sample |
| A equations | sample:32 etc.; cls:134, 139 | `math.amsmath` | `equation`, `aligned`, `\eqref`; `\numberwithin{equation}{section}` |
| A equation numbering | cls:139 | `num.counters` | `\numberwithin{equation}{section}` |
| A proof | sample:30, 119, 372 | `thm.amsthm` | `proof` environment of amsthm (cls:136) |
| A matrices | sample:45, 73 etc. | `tbl.nicematrix` | `bNiceArray{rrr:rrr}`, `bNiceArray{r}`, `vNiceArray{rr}` (cls:138); matrices are math content |
| A math symbols | sample:23, 39, 141, 168 | `math.mathtools` | `\mathrlap` (cls:134); `\bm` via `math.bm`, `\mathbb` via `math.amssymb` (cls:135, 137) |
| A cross-references | sample:65, 84 | `xref.kernel` | `\label{eq:...}`, `Eq.~\eqref{}` |
| A code listing | sample:182-195 | `code.listings` | `lstlisting[language=Matlab, title={MATLAB Code for Check}]`; look from class `\lstset` (row B listings) |
| A manual spacing | sample:181 | `sp.manual-space` | `\vspace{2mm}` |
| B base class | cls:31 | `class.article` | loaded with a4paper, onecolumn, ptsize |
| B paper, size | cls:19-23, 31 | `page.class-options` | a4paper, onecolumn, 9/10/11/12pt |
| B geometry | cls:34 | `page.geometry` | inner=2.0cm, outer=2.0cm, top=1.2cm, bottom=3.5cm |
| B header lengths | cls:222-223 | `page.setlength` | `\headheight` 52pt, `\marginparwidth` 2cm |
| B spacing params | cls:36, 217, 35 | `sp.lengths` | `\hfuzz`=.5em, `\footnotesep`=1em, `\firstfooteradditionalheight`=2em |
| B font encoding | cls:54 | `font.fontenc-t1` | fontenc T1 |
| B colour | cls:55, 151-153 | `color.xcolor` | options usenames,dvipsnames; `\definecolor` dkgreen (0,.5,0), gray (.5,.5,.5), mauve (.58,0,.82); names used: Plum, BrickRed, WildStrawberry, SeaGreen, RoyalPurple, MidnightBlue, cyan, purple |
| B typefaces | cls:115, 227, 305, 326, 330, 344 | `font.family-default` | kernel `\fontfamily{...}\selectfont`: LinuxLibertineT-OsF (title, header, solution banner, footer), LinuxBiolinumT-OsF (semester), bch (assignment number), cmr (body after title) |
| B title sizes | cls:310, 325, 330, 340 | `font.size-commands` | `\fontsize{36}{48}`, `\large`, `\LARGE`; small caps via `\scshape`/`\textsc` (`mark.kernel`) |
| B section heading | cls:63, 85-103, 125 | `head.titlesec` | `explicit`; `\titleformat{\section}` `\Large\bfseries`, empty label, sep 0pt, before-code `\boxedsection`, after-code points at right; numberless variant; `\titlespacing*` 0em, 2.5\baselineskip, 1\baselineskip |
| B sub-headings | cls:126, 129 | `head.titlesec` | `[runin]`; subsection `\large\bfseries`, label `(\arabic{subsection})`, sep 0.33em; subsubsection `\bfseries`, label `\arabic{subsubsection}.` |
| B heading band | cls:66-67, 73-83 | `art.tikz` | `\boxedsection`: two `tikzpicture` nodes plus `\shade[left color=blue!20,right color=white]` on a `background` pgf layer. Class-internal artwork (see Bespoke code) |
| B fading rules | cls:57-60, 121-122, 216, 235, 270-271, 333 | `art.tikz` | `\tikzrule[<fill>, path fading=east/west]{w}{h}`: WildStrawberry, SeaGreen, BrickRed, purple, cyan. Class-internal artwork |
| B header and footer | cls:220-285 | `hf.fancyhdr` | `pagestyle{fancy}`; oneside `\lhead` `\rhead`; twoside `\fancyhf{}` with `\fancyhead[LO,RE,LE,RO]`; `\headrule` redefined; `\fancypagestyle{firstpage}` with two-sided fading footer rule and due-date text |
| B footnotes | cls:215-217 | `fn.footmisc` | `[bottom]`; `\footnoterule` is a TikZ rule (`art.tikz`), `\footnotesep` 1em |
| B hyperlinks and PDF info | cls:221, 349-367 | `meta.hyperref` | colorlinks=true, urlcolor=blue, linkcolor=purple, citecolor=red, hypertexnames=false; `\hypersetup` pdfauthor, pdftitle, pdfsubject, pdfkeywords, pdfcreator |
| B captions | cls:177 | `cap.caption` | font=footnotesize, labelfont=bf (loaded; no `\caption` in either sample) |
| B theorems | cls:136, 140-143 | `thm.amsthm` | `\newtheorem` theorem, proposition, lemma, corollary, numbered within section (plain style) |
| B operators | cls:146-147 | `math.amsmath` | `\DeclareMathOperator*{\argmin}{\arg\min}`, `\argmax` |
| B hint | cls:144-145 | `mark.kernel` | `\hint{x}` = `({\itshape Hint: x})` |
| B listings look | cls:150-174 | `code.listings` | numbers=left, frame=tb, framerule=1pt, rulecolor gray!35, backgroundcolor gray!5, basicstyle \ttfamily\small, numberstyle \footnotesize gray, keywordstyle \bfseries MidnightBlue!95!black, commentstyle dkgreen, stringstyle mauve, breaklines, breakatwhitespace, tabsize=2, aboveskip/belowskip 3mm, postbreak hook arrow |
| B boxes | cls:180-212 | `box.tcolorbox` | `[many]`; `fancybox` and `notice` via `\newtcolorbox` (enhanced skins, boxed title, colours blue/red/yellow, `varwidth` boxed title); title and underlay code are TikZ paths |
| B solution banner | cls:109-124 | `front.class-native` | `\startsolution[print]`: resets section counter, centred `\LARGE\scshape` "Solution", two fading WildStrawberry rules |
| B loaded, unused | cls:288-289 | `tbl.tabularx` | `tabularx` loaded; no use in sample or manual |
| B loaded, unused | cls:289 | `pg.afterpage` | `afterpage` loaded; no use |
| C extra packages | doc:5-8 | `tbl.booktabs` | `booktabs`; `\aboverulesep=0mm`, `\belowrulesep=0mm` (doc:24); `\toprule` `\midrule` `\bottomrule` |
| C row shading | doc:6, 26, 42 | `tbl.colortbl` | `colortbl` `\rowcolor[rgb]{.906,.902,.902}` |
| C tables | doc:36-55, 66-87 | `tbl.tabular` | `tabular{ll}`/`{llc}`; `\def\arraystretch{1.2}`, `\setlength{\tabcolsep}{1.5em}` |
| C table notes | doc:8, 244-262 | `tbl.threeparttable` | `threeparttable`, `tablenotes` |
| C two columns | doc:7, 322-340 | `cols.multicol` | `multicols{2}` |
| C lists | doc:132, 314, 323-338 | `list.kernel` | `itemize`, nested `enumerate` |
| C footnotes | doc:154, 167 | `fn.kernel` | `\footnote` |
| C appendix | doc:309-310 | `num.appendix` | `\appendix` then `\renewcommand{\sectionheadname}{Appendix}` |
| C links | doc:47-51 | `meta.url` | `\url`, `\href` |
| C listings | doc:62, 265, 346 | `code.listings` | `language=tex`, `numbers=none`, `morekeywords={begin}`, `\lstinputlisting[linerange={15-1000},firstnumber=15]{seu-ml-assign.cls}` |
| C class strings | doc:20-21, 156, 175 | `head.class-native` | `\renewcommand{\sectionheadname}{Section/Problem/Appendix}`, `\pdftitleadditionalname` emptied |
| C vertical tweaks | doc:144, 154, 189 | `sp.manual-space` | `\vspace{-8mm}`, `\vspace{-\baselineskip}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\grayrow` | doc:26 | yes | alias for colortbl `\rowcolor[rgb]{.906,.902,.902}` (`tbl.colortbl`) |
| manual's fake headings | doc:162-173 | yes | `\problempts{15}` then `\section*{...}` with `\hspace` and `\\`: class-native commands plus `sp.manual-space`; content |
| `\tikzrule` fading rules and `\boxedsection` band | cls:60, 73-83, 121-122, 216, 235-252, 270-271, 333 | n/a: published class | TikZ artwork inside the CTAN class, carried by `class.seu-ml-assign`. Not reducible to lib ways; would be `ART/class` if the class were rebuilt from components |
| `\maketitle` redefinition | cls:292-368 | n/a: published class | minipage layout, mode conditionals, `\hypersetup`; would be `BESPOKE/class` if rebuilt |
| mode flags `\@@solutionmode`, `\@twoside` and the `\if` tests that change printed text | cls:24-29, 228-232, 247-250, 274-278, 294-317 | n/a: published class | option-driven text switches; `BESPOKE/class` if rebuilt |
| `\problem`, `\subproblem` and starred forms via `\WithSuffix` | cls:64, 104-131 | n/a: published class | `suffix`-based wrappers over `\section*` and `titlesec`; no lib component of their own |
| `fancybox`, `notice` tcolorbox definitions | cls:182-212 | n/a: published class | `\newtcolorbox` options (`box.tcolorbox`) but the `underlay boxed title`, `frame code`, `interior code` values are TikZ paths (`ART/class` if rebuilt) |
| `\startsolution` | cls:109-124 | n/a: published class | counter reset plus banner with two fading rules |

## Content-opaque
none. The matrices are `nicematrix` math content (`tbl.nicematrix`), the listing is `listings` code, and neither sample has a TikZ or pgfplots figure or an `\includegraphics`.

## Lib changes
- New ways proposed: none. `class.seu-ml-assign` is written plainly as a class way (the class section is filled from solution files); vocabulary is under "Class setting".
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
