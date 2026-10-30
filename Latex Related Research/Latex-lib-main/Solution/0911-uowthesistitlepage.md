yes

# 0911-uowthesistitlepage: uowthesistitlepage (University of Wollongong thesis title page package) and its manual

- Unverified: read from the source, not compiled.
- Source: Source/0911-uowthesistitlepage/ (origin: https://mirrors.ctan.org/macros/latex/contrib/uowthesistitlepage.zip; licence: lppl1.3c and cc-by-sa-4 per the manifest, same pair on ctan.org/pkg/uowthesistitlepage, v3.0.1, read once)
- Kind: thesis
- Lib: v6
- Engine: needs LuaLaTeX (the manual: magic comment uowthesistitlepage_doc.tex:1, `luatex85` :3, `fontspec` :23, microtype letterspacing :29; the .sty alone loads only geometry, ragged2e, setspace, etoolbox, graphicx at uowthesistitlepage.sty:79-83)
- Look carried by: mixed (the title, copyright and declaration pages are carried by the CTAN package uowthesistitlepage.sty; the manual's own look is its preamble over `article`, and the manual does not load the package)
- Class origin: ctan (the package is the CTAN release; the manual's `article` is tex-distribution-unbundled)
- Main file: uowthesistitlepage_doc.tex (other samples: none; README.md:37-68 shows a usage snippet only)
- Read: main yes, zip-local classes and styles all

## Verdict
The zip holds one CTAN package, `uowthesistitlepage.sty` (a UOW thesis title page, copyright page and declaration page), and its manual `uowthesistitlepage_doc.tex`. The manual never loads the package: its own look is `article` plus published packages with parameters, and its few macros are aliases that reduce by inline expansion. The package is published (W1, ctan.org/pkg/uowthesistitlepage), is chosen by option keywords and strings (W2), and is printed as one `\usepackage[options]` line plus field commands and `\maketitle` / `\declaration` (W4); by the lib's rule for one-institution front-matter packages it is the class-like way `class.uowthesistitlepage`, so its conditionals are the way's own code, not zip-local bespoke. One new way is proposed (`NEW:sp.embrac`); the missing logo, example PDFs and fonts are assets, not blockers.

## Blockers
none

## Class setting
- Class: `class.article` options: 12pt, oneside (uowthesistitlepage_doc.tex:5). Class-like way for the package: `class.uowthesistitlepage`, options (default `honours`, executed at uowthesistitlepage.sty:696): honours honors mastersbycoursework mastersbyresearch phd PhD partialsubject fullsubject report other noschool nosupervisor cosupervisor horizontal nologo onesupervisor multiplesupervisors nocopyright international nortpacknowledgement altpage (uowthesistitlepage.sty:120-279). Intended host class `class.book` (uowthesistitlepage.sty:15; README.md:7, README.md:12).
- Class-native vocabulary used: the sample uses none (no `\usepackage{uowthesistitlepage}` in uowthesistitlepage_doc.tex; the names are typeset text at :98, :127-145). The package defines `\degree` (uowthesistitlepage.sty:377), `\school` (:400), `\supervisor[n]{}` (:319), `\cosupervisor[n]{}` (:344), `\subject` (:388), `\graphic` (:411), `\copyrighttext` (:442), `\RTPacknowledgement` (:433), `\declaration` (:473) and a redefined `\maketitle` (:548); `\title` `\author` `\date` keep their names with new default strings (:284-309).

## Component map
Part A: what uowthesistitlepage_doc.tex executes.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | uowthesistitlepage_doc.tex:5 | `class.article` | 12pt, oneside |
| class options | uowthesistitlepage_doc.tex:5 | `page.class-options` | 12pt, oneside |
| page geometry | uowthesistitlepage_doc.tex:6-7 | `page.geometry` | a4paper, bottom=5cm |
| colour | uowthesistitlepage_doc.tex:9-12, :16-17 | `color.xcolor` | usenames,dvipsnames; UOWred RGB 245,15,20; UOWblue RGB 0,51,204; UOWdarkblue RGB 12,35,64; dvipsnames `Blue` |
| section heading | uowthesistitlepage_doc.tex:14-17 | `head.titlesec` | explicit; format `\color{Blue}\normalfont\Large\sffamily`, label `\color{Blue}\thesection`, sep 1em, code `\allcaps{#1}` |
| subsection heading | uowthesistitlepage_doc.tex:18-20 | `head.titlesec` | format `\normalfont\large\sffamily`, label `\thesection`, sep 1em, code `#1` |
| heading numbering | uowthesistitlepage_doc.tex:85 | `num.secnumdepth` | secnumdepth=0 |
| letterspaced capitals | uowthesistitlepage_doc.tex:39-40 | `sp.microtype`, `mark.case` | `\textls*[40]{\MakeTextUppercase{#1}}` |
| microtype | uowthesistitlepage_doc.tex:29-38 | `sp.microtype` | tracking=true, protrusion=true, expansion=true; `\DeclareMicrotypeSet*[tracking]{my}`, `\SetTracking` size/shape rules 20, -20, 60 |
| fonts | uowthesistitlepage_doc.tex:23-27 | `font.fontspec` | fontspec+xltxtra; `\defaultfontfeatures{Mapping=tex-text}`; roman `Times LT Std` Numbers=OldStyle; sans `Montserrat` Scale=MatchLowercase; mono `Menlo` Scale=MatchLowercase |
| case change | uowthesistitlepage_doc.tex:42 | `mark.case` | textcase, `\MakeTextUppercase` |
| emphasis bracket fix | uowthesistitlepage_doc.tex:43 | `NEW:sp.embrac` | `\usepackage{embrac}`, no options |
| licence icons | uowthesistitlepage_doc.tex:22, :309 | `font.icons` | ccicons scale=2; `\ccbysa` in a centred `\color{UOWdarkblue}` block |
| include PDF pages | uowthesistitlepage_doc.tex:44, :395-399 | `pg.include-pdf` | `\includepdf{Examples/*.pdf}` x5, no options |
| links | uowthesistitlepage_doc.tex:45, :305, :307 | `meta.hyperref` | default options; `\url` in footnotes |
| code listing | uowthesistitlepage_doc.tex:47-71, :196-223 | `code.listings` | basicstyle `\footnotesize\ttfamily`, breakatwhitespace=false, keepspaces=true, numbers=left, numbersep=5pt, numberstyle `\tiny`; `lstlisting` without language |
| title block | uowthesistitlepage_doc.tex:89-93 | `front.maketitle` | title `\textsf{uowthesistitlepage}`; author `\small Thomas M. Griffiths`; date `Released \today, Version 3.0.1`; kernel `\maketitle` |
| contents | uowthesistitlepage_doc.tex:95, :75 | `toc.kernel`, `toc.tocloft` | `\tableofcontents`; section entry indent 1.5em, number width 2.3em, dotted leader |
| lists | uowthesistitlepage_doc.tex:155-225, :325-337, :387-393 | `list.kernel` | description with bold-coloured labels, itemize, enumerate |
| quotes | uowthesistitlepage_doc.tex:244-251, :255-262 | `quote.kernel` | `quote` environment |
| alignment | uowthesistitlepage_doc.tex:245, :256, :309, :321 | `sp.ragged` | `raggedright` environment, `center` environment |
| table | uowthesistitlepage_doc.tex:257-260 | `tbl.tabular` | `{@{}ll@{}}`, two rows |
| footnotes | uowthesistitlepage_doc.tex:145, :195, :305, :307 | `fn.kernel` | `\footnote` |
| image | uowthesistitlepage_doc.tex:321-323 | `fig.graphicx` | `\includegraphics[height=20mm]{uow_logo.png}` in `center`, no float |
| page break | uowthesistitlepage_doc.tex:311 | `pg.break` | `\clearpage` |
| spacing and rule in example text | uowthesistitlepage_doc.tex:172-173 | `sp.manual-space`, `sp.rule` | `\vspace{1cm}`, `\rule{0.4\textwidth}{0.5pt}` |
| inline marks | uowthesistitlepage_doc.tex:78-83, :335 | `mark.kernel`, `color.xcolor` | `\texttt`, `\emph`, `\textbf`, `\textsc`, `\textsf`, `\color`, `\textcolor` |

Part B: the package uowthesistitlepage.sty (not loaded by the sample) and the README's setup.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| package as class-like way | uowthesistitlepage.sty:76-77, :696-697 | `class.uowthesistitlepage` | option keywords above; strings `\degree` `\school` `\supervisor[n]` `\cosupervisor[n]` `\subject` `\copyrighttext` `\graphic` |
| title page | uowthesistitlepage.sty:548-668 | `front.class-native` | `\maketitle` redefined: logo, bold `\Large` title, author, italic requirement line (wording from options, :416-422), degree or subject, `\vspace*{\fill}`, supervisor block (stacked, or `tabular{@{}ll@{}}` with `horizontal`, :588-627), "The University of Wollongong", school line, date |
| copyright page | uowthesistitlepage.sty:670-689, :442-466 | `front.class-native` | page after the title page, `\footnotesize`, `\@copyrighttext`; off with `nocopyright`; RTP acknowledgement off with `international` (:267) |
| declaration page | uowthesistitlepage.sty:473-494 | `front.class-native` | `\declaration`: `\section*{Declaration}`, wording by options, `\vspace{\fill}`, `\rule{0.4\linewidth}{0.5pt}`, bold author, `\today` |
| title-page geometry | uowthesistitlepage.sty:550-555, :672-677, :505-541 | `page.geometry` | `\newgeometry{inner,outer,top,bottom}` from lengths 0.10, 0.10, 0.068, 0.10 of `\paperheight`; `\restoregeometry` |
| page style | uowthesistitlepage.sty:549, :474, :678, :691 | `hf.pagestyle-kernel` | `\thispagestyle{empty}`, `\pagestyle{empty}` |
| alignment, spacing | uowthesistitlepage.sty:556-557, :679-680, :476 | `sp.ragged`, `sp.setspace` | `raggedright`, `singlespace`, `singlespacing` |
| gaps and rules | uowthesistitlepage.sty:568-570, :580, :486 | `sp.manual-space`, `sp.rule` | gaps `\biggap` 0.10, `\midgap` 0.044, `\smallgap` 0.024, `\vsmallgap` 0.012 of `\paperheight` |
| logo | uowthesistitlepage.sty:405-407 | `fig.graphicx` | `\includegraphics[height=\crestheight]{uow_logo}`, `\crestheight` 0.068 `\paperheight` |
| type | uowthesistitlepage.sty:567-576, :569, :682 | `mark.kernel`, `font.size-commands` | `\textbf`, `\textit`, `\Large`, `\footnotesize` |
| table | uowthesistitlepage.sty:590-609 | `tbl.tabular` | `@{}ll@{}` |
| heading | uowthesistitlepage.sty:475 | `head.kernel` | `\section*{Declaration}` |
| page breaks | uowthesistitlepage.sty:493, :671, :691 | `pg.break` | `\clearpage`, `\cleardoublepage` |
| README host class | README.md:12 | `class.book` | twoside, 12pt, a4paper (documented advice, not executed by any file; also uowthesistitlepage_doc.tex:104) |
| README margins | README.md:13-14 | `page.geometry` | a4paper, inner=4.0cm, outer=2cm, top=3cm, bottom=2cm (documented, not executed) |
| README spacing and font | README.md:16-18, :22 | `sp.setspace`, `font.mathptmx` | `\onehalfspacing` or `\doublespacing`; `mathptmx` (documented, not executed) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\allcapsspacing`, `\allcaps` | uowthesistitlepage_doc.tex:39-40 | yes | aliases; inline `\textls*[40]{\MakeTextUppercase{#1}}` as the `\titleformat` code (:17): `sp.microtype` (tracking=true, :29) + `mark.case` |
| `\option`, `\command`, `\comoptions` | uowthesistitlepage_doc.tex:78, :80, :82 | yes | aliases of `\texttt{\color{UOWblue}#1}`, `\texttt{\color{UOWred}#1}`, `\texttt{\color{UOWdarkblue}#1}`: `mark.kernel` + `color.xcolor`; expand inline |
| `\renewcommand*\l@section{\@dottedtocline{1}{1.5em}{2.3em}}` | uowthesistitlepage_doc.tex:74-76 | yes | the kernel's own three-parameter toc entry command; `toc.tocloft` with section indent 1.5em, number width 2.3em, dotted leader (these are, from memory, the values `article` already uses, so the line may only restate the default) |
| `\DeclareMicrotypeSet*[tracking]{my}` | uowthesistitlepage_doc.tex:30-35 | yes | a declarative `sp.microtype` command; no line in the file selects set `my`, so it has no printed effect I could find |
| `luatex85`, `shellesc` | uowthesistitlepage_doc.tex:3-4 | yes (not components) | load-only engine shims with no printed effect, as the v4 ruling on `sys.compat-load`; considered: luatex85, shellesc; recorded under Engine; no shell command is called |
| the whole `.sty`: `\newif` switches (:86-109), option bodies (:120-279), `\supervisor` counting with etoolbox `\ifnumless` (:319-336), `\@requirement` wording (:416-422), `\maketitle` (:548-692), `\declaration` (:473-494) | uowthesistitlepage.sty | not counted as zip-local | published on CTAN, so it is the code of the way `class.uowthesistitlepage`; the emitter writes `\usepackage[phd,cosupervisor,horizontal]{uowthesistitlepage}`, field strings, `\maketitle`, `\declaration`. Under a reading that ignored the CTAN origin, the wording conditionals and the `\maketitle` redefinition would be `BESPOKE/class`; each fixed configuration would still reduce to the Part B ways |
| `noschool` option body | uowthesistitlepage.sty:224-227 | n/a | observation only: it uses `\newcommand` on `\@schooltitle` and `\@school`, defined at :425 and :394 before `\ProcessOptions` (:697), so it would be expected to raise a redefinition error; not verified |

## Content-opaque
none. Missing assets, not blockers (ship them): `uow_logo` (uowthesistitlepage.sty:406; uowthesistitlepage_doc.tex:322, copyrighted crest, not in the zip), `Examples/report.pdf`, `honours.pdf`, `phd.pdf`, `copyrighttext.pdf`, `declaration.pdf` (uowthesistitlepage_doc.tex:395-399), fonts Times LT Std, Montserrat, Menlo (uowthesistitlepage_doc.tex:25-27); the zip has 4 files (README.md, .sty, .tex, .pdf).

## Lib changes
- New ways proposed: `NEW:sp.embrac` `embrac` (CTAN, TeX Live, MiKTeX, LPPL 1.3, Clemens Niederberger; ctan.org/pkg/embrac read; needs expl3, xparse, l3keys2e), engine pdf (the CTAN page names no engine; used here under LuaLaTeX); a load-only fix that makes `\emph` and `\textit` set parentheses and square brackets upright, loaded without options at uowthesistitlepage_doc.tex:43; source not read. W1 CTAN; W2 no options in the sample, the CTAN page lists none; W3 serves any document; W4 one preamble line. A sibling of `sp.ellipsis`, `sp.underscore`, `code.upquote` (not `mark.kernel`, kernel switches only).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
