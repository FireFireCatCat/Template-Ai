yes

# 0893-philosophersimprint: Philosophers' Imprint article class (philosophersimprint)

- Unverified: read from the source, not compiled.
- Source: Source/0893-philosophersimprint/ (origin: https://mirrors.ctan.org/macros/latex/contrib/philosophersimprint.zip; licence: LPPL 1.3)
- Kind: journal (a class for articles of the online journal Philosophers' Imprint, philosophersimprint.dtx:100-112; the sample is the journal's own mission statement typeset as a short article)
- Lib: v6
- Engine: pdfLaTeX-compatible (the class is "intended to be used with pdflatex", philosophersimprint.dtx:162; it sets the pdfTeX lengths `\pdfpageheight` `\pdfpagewidth` and warns under DVI, philosophersimprint.dtx:750-762; Makefile:19 runs `pdflatex`)
- Look carried by: class (the sample's own preamble only adds `opcit`, `kantlipsum`, `url` and `hyperref`, sample.tex:2-5; every look decision is inside the published class)
- Class origin: ctan (one read of https://ctan.org/pkg/philosophersimprint: LaTeX class for articles of Philosophers' Imprint, v1.5, LPPL 1.3, Boris Veytsman, path macros/latex/contrib/philosophersimprint; the zip is the CTAN package itself)
- Main file: sample.tex (other samples: none; philosophersimprint.dtx is also an `ltxdoc` documentation driver, philosophersimprint.dtx:65-93, which is not a template sample)
- Read: main yes, zip-local classes and styles all (no `.cls` is shipped: `philosophersimprint.ins` generates it with docstrip, philosophersimprint.ins:14-15; I read the whole `.dtx`, 1444 lines, including every `<class>` line, philosophersimprint.dtx:459-1432)

## Verdict
yes. The look is carried entirely by one published CTAN class, `philosophersimprint`, which loads `article` and is steered by class options (the sample passes `noflushend`, sample.tex:1). The sample defines no macro, environment, counter or conditional and draws no artwork; it adds four published packages and plain content. The class code (custom `\maketitle`, `\section`, footnote hook) is listed for the record and not counted, because the class is published on CTAN (W1) and an emitter prints only its `\documentclass` line. No tool outside TeX is needed (BibTeX is the ordinary bibliography tool).

## Blockers
none

## Class setting
- Class: `class.philosophersimprint` options: `noflushend` (sample.tex:1; default, philosophersimprint.dtx:513-515). Other options of the class: `flushend` (balanced last page, loads `flushend.sty` if present, :514,604-612), `titleimage` (default) / `notitleimage` (:469-471), `trajantitle` (default) / `notrajantitle` (:479-481), `nosc`, `noosf` (:489-497), `slantedGreek`, `noBBpl` (passed to `mathpazo`, :503-506); every other option goes to `article` (:522). A `philosophersimprint.cfg` is read when present (:527-531); none is shipped.
- Base class loaded by the class: `class.article` with `\LoadClass[landscape,letterpaper,twocolumn]{article}` (philosophersimprint.dtx:546).
- Class-native vocabulary used by the sample: `\title[short]{full}` (sample.tex:8; philosophersimprint.dtx:1036-1039), `\author[short]{full}` (sample.tex:10; :1045-1048), `\affiliation` (sample.tex:12; :1074), `\subject` (sample.tex:14; :1078), `\keywords` (sample.tex:16; :1080), `\copyrightinfo` (sample.tex:18; :1076), `\journalvolume` and `\journalnumber` (sample.tex:21-22; :1124-1137), `\date` (sample.tex:24; the class redefines `\today`, :1056-1060), redefined `\maketitle` (sample.tex:27; :1169-1180), `\section` `\subsection` (redefined, :1281-1357). Present in the class but not used by the sample: `\titleimage` (commented out, sample.tex:26; :1072), `\copyrightlicense` (commented out, sample.tex:19; :1093), `\appendix` (:1369-1373). `\and` and `\thanks` are disabled with an error (:1020-1030).

## Component map
Rows marked "(inside class)" are what the class composes internally; an emitter prints only `\documentclass[noflushend]{philosophersimprint}` for them. They are listed so the class's make-up is on record.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | sample.tex:1; philosophersimprint.dtx:459-536 | `class.philosophersimprint` | `[noflushend]` |
| base class (inside class) | philosophersimprint.dtx:546 | `class.article` | `\LoadClass[landscape,letterpaper,twocolumn]{article}` |
| paper and orientation (inside class) | philosophersimprint.dtx:546 | `page.class-options` | `landscape`, `letterpaper` |
| columns (inside class) | philosophersimprint.dtx:546,792 | `cols.twocolumn-option` | `twocolumn`; `\columnsep`=54pt (a `page.setlength` row below) |
| page geometry (inside class) | philosophersimprint.dtx:769-795,813-815,827-829 | `page.setlength` | `\textheight`=459pt; `\topmargin`=61pt minus 1in, `\topskip`, `\headsep`; `\textwidth`=2x297pt+`\columnsep`; `\oddsidemargin`=`\evensidemargin`=6pc minus 1in; `\headsep`=13.5pt; `\footskip`=3x13.5pt; `\marginparwidth`=3x13.5pt, `\marginparsep`=`\marginparpush`=0.5x13.5pt; fixed, the sample cannot change them |
| pdfTeX page size (inside class) | philosophersimprint.dtx:750-754 | `page.setlength` | `\pdfpageheight=\paperheight`, `\pdfpagewidth=\paperwidth` (pdfTeX length primitives, as `sp.lengths` admits raw length parameters; considered `meta.pdf-params`, which names integer and string primitives) |
| base unit (inside class) | philosophersimprint.dtx:649-650 | `sp.lengths` | `\PHIM@baselength`=13.5pt, used as the unit of all leading and spacing (reduction in "Bespoke code") |
| body size and leading (inside class) | philosophersimprint.dtx:686-697 | `font.size-commands` | `\normalsize` 9.5/13.5pt, `\small` 9/13.5, `\footnotesize` 8.5/9.5, `\scriptsize` 8/9, `\tiny` 7.5/8.5, `\large` 11/16, `\Large` 13/19, `\LARGE` 16/23, `\huge` 19/28, `\Huge` 23/33, new `\HUGE` 30/45 |
| paragraph shape and skips (inside class) | philosophersimprint.dtx:720-723,735-737,769-770,780-783 | `sp.lengths` | `\parindent`=13.5pt, `\parskip`=0pt; `\smallskipamount`=0.25 and `\medskipamount`=0.5 and `\bigskipamount`=1 base unit; `\lineskiplimit`=-3pt, `\lineskip`=13.5pt; display skips=13.5pt |
| baseline stretch (inside class) | philosophersimprint.dtx:720 | `sp.linespread` | `\renewcommand\baselinestretch{}` (empty: no line-spread factor) |
| French spacing (inside class) | philosophersimprint.dtx:1430-1431 | `sp.frenchspacing` | `\frenchspacing` after `\normalsize` |
| footnote split penalty (inside class) | philosophersimprint.dtx:1419 | `sp.penalties` | `\interfootnotelinepenalty=0` |
| text face, Palatino-like (inside class) | philosophersimprint.dtx:556-558 | `font.palatino` | `mathpazo` with `sc` and `osf` (switched off by `nosc` `noosf`; `slantedGreek` `noBBpl` pass through) |
| typewriter and sans faces (inside class) | philosophersimprint.dtx:565-566 | `font.mono`, `font.helvet` | `courier`; `helvet` with `scaled` |
| encoding (inside class) | philosophersimprint.dtx:572-573 | `font.fontenc-t1` | `fontenc` `[T1]`, `textcomp` |
| microtypography (inside class) | philosophersimprint.dtx:578 | `sp.microtype` | `\IfFileExists{microtype.sty}{\RequirePackage{microtype}}`, no options |
| title face (inside class) | philosophersimprint.dtx:591-599,1225 | `font.display` | `trajan` (CTAN, TeX Live, LPPL 1.3; one read of ctan.org/pkg/trajan: capitals only, no lowercase or digits) loaded if installed; `\trjnfamily` for the simulated title only; the package is the parameter |
| colour (inside class) | philosophersimprint.dtx:551,1253-1254 | `color.color` | `color` package; `\definecolor{PHIM@blue}{rgb}{0.184,0.431,0.7749}`, `\definecolor{PHIM@gray}{gray}{0.549}`; `\textcolor` in the simulated title |
| running heads and feet (inside class) | philosophersimprint.dtx:551,1145-1155 | `hf.fancyhdr` | `\pagestyle{fancy}`; `\lhead` `\makebox[\PHIM@colwidth]{\centering\scshape\large\MakeLowercase{short author}}`; `\rhead` same width, `\itshape\large` short title; `\lfoot` `\scshape\large philosophers' imprint`; `\cfoot` `-\space\large\thepage\space-`; `\rfoot` `vol.~..., no.~...` and the lower-cased date; `\headrulewidth`=`\footrulewidth`=0pt |
| running-head content | sample.tex:8,10,21-22,24; philosophersimprint.dtx:1146-1153 | `hf.class-native` | short title and short authors come from the optional arguments of `\title` and `\author`; volume, number and date from `\journalvolume` `\journalnumber` `\date` |
| running-head case and faces (inside class) | philosophersimprint.dtx:1146-1153 | `mark.case`, `mark.kernel` | `\MakeLowercase` on short author and date; `\scshape` `\itshape` |
| title page | sample.tex:8-27; philosophersimprint.dtx:1169-1180,1211-1247 | `front.class-native` | `\maketitle` sets `\thispagestyle{empty}`, then the image title or the simulated title, then `\newpage`; the simulated title (used here because the default image `NoSuchImageDotUse.pdf` is absent, :1073,1189-1200): two 2in `\parbox` boxes (logo text in blue and gray, volume line), `\vskip 0pt plus 0.3fill` and other fill glue, title in `\HUGE` upper case (Trajan if present), authors `\huge\itshape`, affiliation `\large\itshape`, copyright line, licence line, URL `<www.philosophersimprint.org/NNNNNN/>` |
| title page, page style | philosophersimprint.dtx:1170 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| title page boxes and fill (inside class) | philosophersimprint.dtx:1213-1247 | `box.minipage`, `sp.manual-space` | `\parbox{2in}`; `\vskip 0pt plus <n>fill`, `\hfill`, `\\[-1.4ex]` |
| title image (inside class, not used here) | philosophersimprint.dtx:1188-1193; sample.tex:26 | `fig.graphicx` | `\includegraphics{\@titleimage}` placed by a zero-size `picture` and `\put(-6,6){\makebox(0,0)[lt]{...}}`; the picture draws nothing, it only places the editors' title-page PDF, which is an external asset |
| PDF metadata and links (inside class) | philosophersimprint.dtx:1171-1174,1240 | `meta.hyperref` | `\hypersetup{pdfauthor,pdftitle,pdfsubject,pdfkeywords}` from `\title` `\author` `\subject` `\keywords` (those two are never printed, :1078-1081); `\href{http://\PHIM@url}` |
| hyperref options (sample) | sample.tex:4-5 | `meta.hyperref` | `breaklinks, colorlinks, linkcolor=black, citecolor=black, pagecolor=black, urlcolor=black` |
| url package | sample.tex:3,143,166,171 | `meta.url` | `\usepackage{url}`; `\path{...}` and `\url{...}` in the body |
| sectioning, level 1 | sample.tex:29,66,137,149; philosophersimprint.dtx:1281-1311,1321-1326 | `head.class-native` | `\section`: `\addvspace{0.75 base unit}`, `\noindent\raggedright\normalsize\bfseries`, number plus `.\quad`, `\vspace*{0.25 base unit}`; starred form without number; contents line `\thesection.\quad title` |
| sectioning, levels 2 to 5 | sample.tex:151,160,168; philosophersimprint.dtx:1342-1357 | `head.class-native` | `\@startsection` with `\normalfont\normalsize\itshape`: subsection (level 2, beforeskip -13.5pt, afterskip 1sp) and subsubsection (level 3, beforeskip -1sp, afterskip 1sp) are display headings in italic; `\paragraph` (level 4) and `\subparagraph` (level 5, indent `\parindent`) have afterskip -1sp, so they run in, upright `\normalfont\normalsize`; 1sp and -1sp serve as effective zero (:1338-1340) |
| appendix (class vocabulary, not used) | philosophersimprint.dtx:1265-1273,1297-1305,1369-1373 | `num.appendix` | `\appendix` sets a flag, resets `section`/`subsection`, `\thesection`=`\@Alph`; headings print "Appendix A." |
| lists (inside class, not used) | philosophersimprint.dtx:885-947 | `list.kernel`, `sp.lengths` | `\leftmargini`..`\leftmarginvi`=`\listparindent`=`\itemindent`=13.5pt, `\labelsep`=0.5em, `\topsep`=0.5x13.5pt, `\itemsep`=0pt; `\@listi`..`\@listvi` emptied |
| quotations (inside class, not used) | philosophersimprint.dtx:962-968 | `quote.kernel` | `quote` `quotation` `verse` redefined as `\list{}{\rightmargin\leftmargin ...}` |
| floats and captions spacing (inside class, not used) | philosophersimprint.dtx:850-856 | `sp.lengths` | `\floatsep` `\textfloatsep` `\intextsep` `\dblfloatsep` `\dbltextfloatsep` `\abovecaptionskip`=13.5pt, `\belowcaptionskip`=0 |
| odds and ends (inside class) | philosophersimprint.dtx:985,994,1004-1006 | `sp.lengths` | `\bibindent`=13.5pt, `\jot`=0, `\arraycolsep`=`\tabcolsep`=0.5 unit, `\fboxsep`=0.25 unit |
| footnote | sample.tex:86-87 | `fn.kernel` | `\footnote{...}` |
| footnote layout (inside class) | philosophersimprint.dtx:1388-1391,1399,1410 | `fn.kernel` | `\@makefntext` hook: text mark `\@thefnmark.` in a 13.5pt left box plus `\parbox[t]` for the text (hanging indent); `\footnotesep` = strut of `\footnotesize`; `\skip\footins`=13.5pt plus 13.5pt (no lib way names the hook) |
| citation package | sample.tex:2,86-87 | `bib.apacite` | `\usepackage{opcit}`, no options, `\cite{key}` inside `\footnote`; opcit is a footnote-citation package (ibid. and op. cit.) filed with its sibling `jurabib`, the package is the parameter (opcit source not read; CTAN says LPPL 1, TeX Live, MiKTeX) |
| bibliography | sample.tex:176; philosophersimprint.bib:115-140 | `bib.bibtex-bst` | `\bibliography{philosophersimprint}`; neither sample.tex nor the class names a `\bibliographystyle` (grep: the only one is `unsrt` in the documentation, philosophersimprint.dtx:450), so the style is presumably supplied by `opcit` (not verified); `\bibindent` set by the class |
| filler text | sample.tex:2 | `draft.todo` | `\usepackage{kantlipsum}` loaded, never called (grep: no `\kant` in sample.tex); a lipsum-family filler package |
| emphasis and inline text | sample.tex:31-173 | `mark.kernel` | `\emph{...}` |
| manual vertical space | sample.tex:68 | `sp.manual-space` | `\vspace*{-0.25\baselineskip}` after `\section` |
| language, contents, index, floats, tables, maths, theorems, code, boxes | none in sample or class | none | no `babel`, no `\tableofcontents`, no `\makeindex`, no figure or table, no maths, no `\newtheorem`, no `listings` (grep) |
| documentation driver (not template scope) | philosophersimprint.dtx:65-93 | `class.ltxdoc` | `\documentclass{ltxdoc}` with `array`, `url` and `hyperref` (the sample's options plus `hyperindex=false`, :85-86), then `\PageIndex` `\CodelineIndex` `\RecordChanges` `\EnableCrossrefs` (:87-90); builds the manual only |

## Bespoke code
The sample defines none: no `\newcommand`, `\def`, `\renewcommand`, environment, counter or conditional (sample.tex:1-179).

For the record, not counted because the class is published (W1) and the emitter prints only its `\documentclass` line. These are the zip's class-side constructs; if the class were zip-local, `\maketitle`, `\@section` and the footnote hook are the ones the rubric's kernel-redefinition test would put in doubt, the rest reduce at once.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\PHIM@baselength`, `\PHIM@colwidth` lengths | philosophersimprint.dtx:649-650,790-795 | yes | constants 13.5pt and 297pt in `sp.lengths` / `page.setlength` |
| option switches `\ifPHIM@titleimage` `@trajantitle` `@sc` `@osf` `@flushend` | philosophersimprint.dtx:469-515 | yes | class options (parameters of `class.philosophersimprint`) |
| `\renewcommand\normalsize` .. `\newcommand\HUGE` | philosophersimprint.dtx:686-697 | yes | `font.size-commands` |
| list, float, quote, skip lengths | philosophersimprint.dtx:720-738,850-856,885-968,985-1006 | yes | `sp.lengths`, `quote.kernel` |
| `\title` `\author` with optional short form, `\affiliation` `\subject` `\keywords` `\copyrightinfo` `\copyrightlicense` `\titleimage` | philosophersimprint.dtx:1036-1095 | not assessed (published) | `front.class-native` (stored strings printed by `\maketitle`) |
| `\PHIM@addzeros` (zero-pads volume and number to 3 digits for the URL) | philosophersimprint.dtx:1106-1138 | not assessed (published) | string built by `\edef` with `\ifnum` tests; part of `front.class-native` |
| `\and` and `\thanks` error stubs, `\today` redefinition | philosophersimprint.dtx:1020-1030,1056-1060 | not assessed (published) | class vocabulary |
| `\maketitle`, `\maketitle@image`, `\maketitle@simulated` | philosophersimprint.dtx:1169-1247 | not assessed (published) | `front.class-native`; fill-glue page layout with `\parbox` and `\vskip` |
| `\section` `\@section` `\@ssection`, `\appendix`, `\@startsection` calls | philosophersimprint.dtx:1281-1373 | not assessed (published) | `head.class-native`, `num.appendix` |
| `\@makefntext` redefinition | philosophersimprint.dtx:1388-1391 | not assessed (published) | `fn.kernel` kernel hook; no lib way names it |
| hyperref detection with `\AtBeginDocument` | philosophersimprint.dtx:619-629 | not assessed (published) | class logic: `meta.hyperref` metadata only when hyperref is loaded |
| documentation macros `\DescribeOption` `\DescribeOptions` and docs-only `\newcommand{\progname}` | philosophersimprint.dtx:68-84,99 | n/a | manual driver only, not part of the template |

## Content-opaque
- The editors' title-page image (`\titleimage{...}`, default file `NoSuchImageDotUse.pdf`, philosophersimprint.dtx:1073) is an external asset, not shipped; the sample leaves it commented out (sample.tex:26) and so gets the simulated title (the class falls back with a warning, :1189-1200). The `picture` around it draws nothing (:1190-1193), so it is not `ART`.
- The `.bib` entries (philosophersimprint.bib), the mission-statement text and the footnote citation strings (sample.tex:29-176) are content.
- Fonts not shipped (the FPL/Palatino set loaded through `mathpazo`, URW `courier` and `helvet`, optional `trajan`) are part of TeX Live; noted as assets, not blockers.

## Lib changes
- New ways proposed: none. Considered and not proposed: `opcit` as its own bibliography way (filed under `bib.apacite` with its footnote-citation sibling `jurabib`, and `bib.cite-pkg` was rejected as that line is for citation-run switches); `flushend` (sttools; loaded only under the class option `flushend`, which the sample does not select; same type as `cols.balance`, recorded as a class option instead).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
