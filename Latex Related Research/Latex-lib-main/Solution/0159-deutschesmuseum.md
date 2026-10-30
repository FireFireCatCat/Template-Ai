yes

# 0159-deutschesmuseum: Deutsches Museum contribution class (deutschesmuseum)

- Unverified: read from the source, not compiled.
- Source: Source/0159-deutschesmuseum/ (origin: https://mirrors.ctan.org/macros/latex/contrib/deutschesmuseum.zip; licence: LPPL 1.3)
- Kind: book (a contribution to Deutsches Museum publications, "Typesetting books for Deutsches Museum", deutschesmuseum.dtx:193; the sample is a short article on a 155 x 220 mm page; the manifest hint `journal` is only the source category)
- Lib: v3
- Engine: needs XeLaTeX or LuaLaTeX (`fontspec` loaded unconditionally, deutschesmuseum.dtx:288; `unicode-math` loaded by default, deutschesmuseum.dtx:346; the manual says "you need to use LuaTeX or XeTeX", deutschesmuseum.dtx:99-100; Makefile:20 runs `lualatex`)
- Look carried by: class (the sample's own preamble only adds `kantlipsum`, `booktabs`, `graphicx`, sample.tex:2; every look decision is inside the published class)
- Class origin: ctan (one read of https://ctan.org/pkg/deutschesmuseum: listed as a LaTeX class for contributions to Deutsches Museum publications, v1.7 2026-02-04, LPPL 1.3, path macros/latex/contrib/deutschesmuseum)
- Main file: sample.tex (other samples: none; deutschesmuseum.dtx is also the documentation driver, an `ltxdoc` document, deutschesmuseum.dtx:199-209, not a template sample)
- Read: main yes, zip-local classes and styles all (no `.cls` is shipped; the class exists as `deutschesmuseum.dtx` and `deutschesmuseum.ins`, Makefile:30-31 and deutschesmuseum.ins:14-15 generate it with docstrip; I read the whole `.dtx`, 579 lines, including every `<class>` line, deutschesmuseum.dtx:211-568)

## Verdict
yes. The look is carried entirely by one published CTAN class, `deutschesmuseum`, which loads `amsart` and is steered only by class options (`nocfonts`, `fleqn`, `folios`, sample.tex:1). The sample adds three published packages and plain content; it defines no macro, environment or counter of its own and draws no artwork. Fonts (EB Garamond, Lato, `Garamond-Math.otf`) are not shipped, which the rubric records but does not count as a blocker. Class internals that rewrite amsart/kernel hooks are listed for the record under "Bespoke code" and are not counted, because the class is published (W1).

## Blockers
none

## Class setting
- Class: `class.deutschesmuseum` options: `nocfonts` (free fonts instead of Garamond BQ / Futura PT; deutschesmuseum.dtx:221-224), `fleqn` (not a class option; passed on to `amsart`, deutschesmuseum.dtx:268), `folios` (print running heads and page numbers, off by default; deutschesmuseum.dtx:245-248). Other options of the class: `cfonts` (default), `garamondmath`/`nogaramondmath` (default on, deutschesmuseum.dtx:232-235), `nofolios`; the size options `8pt` to `12pt` are accepted but only warn (deutschesmuseum.dtx:255-262).
- Base class loaded by the class: `class.amsart` (`\LoadClass{amsart}`, deutschesmuseum.dtx:277), all unknown options go to it (deutschesmuseum.dtx:268-269).
- Class-native vocabulary used: `\subtitle{}` (deutschesmuseum.dtx:407, sample.tex:5), redefined `\maketitle` (deutschesmuseum.dtx:415, sample.tex:7), `\title` `\author` with `\and` (amsart, sample.tex:4,6), `abstract` environment redefined as an unnumbered section (deutschesmuseum.dtx:443, sample.tex:9-11), `\section` `\subsection` redefined (deutschesmuseum.dtx:453,460), `quote` redefined (deutschesmuseum.dtx:384, sample.tex:18), `\cite[pre][post]{keys}` redefined to print a footnote with `\citealt` (deutschesmuseum.dtx:548, sample.tex:17), `\shorttitle` `\shortauthors` for the running heads (deutschesmuseum.dtx:417,517-518), colour `DeutschesMuseumRed` (deutschesmuseum.dtx:398), caption position rule "captions before tables, after figures" (deutschesmuseum.dtx:145,534).

## Component map
Rows marked "(inside class)" are what the class composes internally from published ways; an emitter prints only `\documentclass[nocfonts,fleqn,folios]{deutschesmuseum}` for them. They are listed so the class's make-up is on record.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | sample.tex:1; deutschesmuseum.dtx:192-193 | `class.deutschesmuseum` | `[nocfonts,fleqn,folios]` |
| base class (inside class) | deutschesmuseum.dtx:277 | `class.amsart` | `\LoadClass{amsart}`, all other options passed on |
| page geometry (inside class) | deutschesmuseum.dtx:368-370 | `page.geometry` | paperwidth=155mm, paperheight=220mm, includeheadfoot, headheight=15pt, headsep=0.35in, inner=20mm, outer=17mm, top=8.3mm, bottom=14.1mm; fixed, the sample cannot change it |
| body size and leading (inside class) | deutschesmuseum.dtx:355-360 | `font.size-commands` | amsart's `\@typesizes` table replaced: normalsize 9.25pt on 11pt, `\normalsize` then `\linespacing=\baselineskip` |
| paragraph shape (inside class) | deutschesmuseum.dtx:371-372 | `sp.lengths` | `\parskip`=0pt, `\parindent`=5mm |
| text fonts, free branch (inside class) | deutschesmuseum.dtx:288,318-324 | `font.fontspec` | `\setmainfont{EBGaramond}[Extension=.otf, UprightFont=*-Regular, BoldFont=*-Bold, ItalicFont=*-Italic, BoldItalicFont=*-BoldItalic]` |
| sans role fonts, free branch (inside class) | deutschesmuseum.dtx:325-334 | `font.fontspec` | `\newfontfamily\LatoLight{Lato-Light}[Extension=.ttf, ItalicFont=*Italic, BoldFont=Lato-Medium, BoldItalicFont=Lato-MediumItalic]` and `\LatoMedium{Lato-Medium}` |
| role font sizes, free branch (inside class) | deutschesmuseum.dtx:335-342 | `font.size-commands` | `\foliofont` Lato Light 9/11; `\hIfont` Lato Medium 14/16; `\hIIfont` 12.5/12; `\hIIIfont` 11/12; `\hIVfont` 10/12; `\fnmarkfont` 10/11; `\fnmarktextfont` 8/10; `\fnfont` Lato Light 8/10 (the commercial branch, not used by the sample, is deutschesmuseum.dtx:289-317) |
| math fonts (inside class) | deutschesmuseum.dtx:345-347 | `font.unicode-math` | `math-style=ISO, bold-style=ISO`; `\setmathfont{Garamond-Math.otf}[StylisticSet={7,9}]`; with `nogaramondmath` it loads `amssymb` instead (deutschesmuseum.dtx:349) |
| colour (inside class) | deutschesmuseum.dtx:397-398 | `color.xcolor` | `\definecolor{DeutschesMuseumRed}{cmyk}{0.36,0.87,0.61,0.33}` |
| title block | sample.tex:4-7; deutschesmuseum.dtx:407-408,415-430 | `front.class-native` | title in DeutschesMuseumRed with `\hIfont`; `\subtitle` in `\hIIfont` after one `\baselineskip`; authors italic at normalsize; `\thispagestyle{firstpage}`; `\@topnum\z@` keeps floats off the first page top |
| abstract | sample.tex:9-11; deutschesmuseum.dtx:443 | `abs.class-native` | `\par\vspace{2.5ex}\section*{\abstractname}`, an unnumbered section heading, no own formatting |
| headings | sample.tex:13,25; deutschesmuseum.dtx:453-461 | `head.class-native` | section `\@startsection{section}{1}{\z@}{-2\baselineskip}{\baselineskip}{\hIIIfont}`; subsection `{2}{\z@}{-\baselineskip}{1sp}{\hIVfont}`; numbering and depth stay amsart's defaults (amsart not read) |
| running heads and folios | sample.tex:1; deutschesmuseum.dtx:507-519,565 | `hf.class-native` | option `folios`: first page style `firstpage` has only `\thepage` in `\foliofont` (RO and LE); `standard` style: RO `\shorttitle\quad\thepage`, LE `\thepage\quad\shortauthors`; without `folios` the fields are empty |
| running-head engine (inside class) | deutschesmuseum.dtx:496,501-502,507-519 | `hf.fancyhdr` | `\fancypagestyle{firstpage}` and `{standard}`, `\fancyhf{}`, `\fancyhead[RO]`/`[LE]`, `\headrulewidth`=0pt, `\footrulewidth`=0pt |
| quotation | sample.tex:18-23; deutschesmuseum.dtx:384-389 | `quote.kernel` | `quote` redefined with `\list{}{\rightmargin5mm\leftmargin\rightmargin}\item[]` and `\vspace\baselineskip` at the end; `quotation` likewise (deutschesmuseum.dtx:374-383) |
| footnotes | sample.tex:28; deutschesmuseum.dtx:472,479,486-487 | `fn.kernel` | `\footnoterule` empty; mark superscript in DeutschesMuseumRed `\fnmarktextfont`; note text = red number, `\quad`, `\fnfont` |
| citations | sample.tex:17,34; deutschesmuseum.dtx:542,548 | `bib.natbib` | class loads `natbib`; `\cite[pre][post]{keys}` = `\footnote{\citealt[pre][post]{keys}}` (class-native vocabulary, recorded above) |
| bibliography list | sample.tex:99-100; deutschesmuseum.dtx:344,554-557 | `bib.bibtex-bst` | `\bibliographystyle{plainnat}` with `sample.bib`; `\bibsection` empty, `\refname`=Bibliography, `\bibfont`=`\fnfont`, list inside `multicols{2}` under a full-width `\section*{\refname}` |
| two-column bibliography (inside class) | deutschesmuseum.dtx:280,556-557 | `cols.multicol` | `\multicolsep`=0, `\begin{multicols}{2}[\section*{\refname}]` ... `\vskip-\lastskip\end{multicols}` |
| display maths, starred | sample.tex:40-42,46-48 | `math.kernel` | `\[ ... \]` |
| aligned equations | sample.tex:51-60 | `math.amsmath` | `align` with four numbered lines, `\text`; amsmath arrives through amsart (amsart not read) |
| equation numbering | sample.tex:1 | `math.eqnumber` | `fleqn` (amsart option reached through `\DeclareOption*`, deutschesmuseum.dtx:268) |
| theorem-like statements | sample.tex:38,44 | `mark.kernel` | hand-typed `\textbf{Theorem 1 (...).}` and `\emph{...}`; no `\newtheorem` in sample or class (grep), so no theorem way is needed |
| figure | sample.tex:65-70 | `fig.graphicx` | `figure`, `\centering`, `\includegraphics{vitruvian}` (vitruvian.jpg 400 x 400 px is shipped) |
| table | sample.tex:72-86 | `tbl.tabular` | `tabular{lll}`, header cells `\bfseries`; `\renewcommand{\arraystretch}{0.9}` (deutschesmuseum.dtx:373) |
| table rules | sample.tex:2,77-83 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| captions (inside class) | sample.tex:68,73-75; deutschesmuseum.dtx:529-534 | `cap.caption` | `\DeclareCaptionFont{capfont}{\foliofont}`; `font=capfont, textfont=capfont, labelfont={capfont,bf}, labelsep=quad, justification=centering`; figure `name=Fig.`; table `name=Table, position=top` |
| cross-references | sample.tex:14,26,62-63 | `xref.kernel` | `\label`, `\ref` |
| PDF links (inside class) | deutschesmuseum.dtx:278-279 | `meta.hyperref` | `breaklinks, colorlinks, linkcolor=black, citecolor=black, pagecolor=black, urlcolor=black, hyperindex=false` |
| filler text | sample.tex:2,95 | `draft.todo` | `kantlipsum` `\kant[1-25]`, a lipsum-type dummy text package (content) |
| language, contents, lists, index | none in sample or class | none | no `babel`/`polyglossia`, no `\tableofcontents`, no list environments, no index or glossary (grep) |

## Bespoke code
none in the sample (it defines no macro, environment, counter or conditional; sample.tex:1-102).

For the record, not counted because the class is published (W1) and the emitter prints only its `\documentclass` line. These are the class's redefinitions of amsart/kernel hooks, which would be the items to judge if the class ever had to be rebuilt from the lib rather than used:

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\@typesizes` replacing amsart's size table | deutschesmuseum.dtx:355-360 | not assessed (published) | `font.size-commands` for one size pair; the table swap itself is an amsart internal |
| `\renewcommand\maketitle` | deutschesmuseum.dtx:415-430 | not assessed (published) | `front.class-native` |
| `\@makefnmark`, `\@makefntext`, `\footnoterule` | deutschesmuseum.dtx:472-487 | not assessed (published) | `fn.kernel` kernel hooks; no lib way names the hook |
| `\renewenvironment{quote}` / `{quotation}` | deutschesmuseum.dtx:374-389 | not assessed (published) | `quote.kernel` with `list` lengths |
| `\RenewDocumentCommand{\cite}` | deutschesmuseum.dtx:548 | not assessed (published) | alias of `fn.kernel` over `bib.natbib` `\citealt` |
| `\bibpreamble` / `\bibcleanup` hooks with `multicols` | deutschesmuseum.dtx:556-557 | not assessed (published) | `cols.multicol` plus `bib.natbib` hooks |
| `\ifdeutschesmuseum@cfonts`, `@garamondmath`, `@folios` switches | deutschesmuseum.dtx:221-248 | not assessed (published) | class options (parameters of `class.deutschesmuseum`) |

## Content-opaque
- Figure artwork `vitruvian.jpg` inside the figure float (sample.tex:67); it is shipped.
- Filler paragraphs from `\kant[1-25]` (sample.tex:95) and the `.bib` entries (sample.bib:1-38) are content.
- Notes on assets, not blockers: `EBGaramond-*.otf`, `Lato-*.ttf` and `Garamond-Math.otf` are not in the zip (whether TeX Live carries these exact file names was not checked); the default `cfonts` branch needs commercial Garamond BQ and Futura PT files (deutschesmuseum.dtx:102-125), which cannot be shipped, so only the `nocfonts` branch used by the sample is analysed.

## Lib changes
- New ways proposed: none (`class.deutschesmuseum` is written plainly as a class way; considered and not proposed: a footnote-style or citation-as-footnote way, because the class's own `\cite` and footnote look are class vocabulary recorded above and the underlying commands are `fn.kernel` and `bib.natbib`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
