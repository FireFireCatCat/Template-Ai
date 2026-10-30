yes

# 0041-fancyhandout: fancyhandout (handout class and its manual)

- Unverified: read from the source, not compiled.
- Source: Source/0041-fancyhandout/ (origin: https://mirrors.ctan.org/macros/latex/contrib/fancyhandout.zip; licence: lppl1.3c)
- Kind: presentation (a handout class for talks; the sample is its own ltxdoc manual, not a handout)
- Lib: v1
- Engine: needs LuaLaTeX (the sample loads `selnolig`, which its CTAN page says needs a recent LuaLaTeX format; `fontspec` and `polyglossia` need XeLaTeX or LuaLaTeX; `fancyhandout.cls` itself is pdfLaTeX-compatible)
- Look carried by: mixed (the handout look is in `fancyhandout.cls`, a CTAN-published class the sample does not load; the sample's own look is the published `ltxdoc` plus a preamble of fonts, language and geometry)
- Class origin: ctan
- Main file: fancyhandout-doc.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
yes. The only sample, `fancyhandout-doc.tex`, is the class's manual written on the published `ltxdoc` class; its preamble and body reduce to lib ways, with one new way (`sp.selnolig`) that passes W1 to W4. The template proper, `fancyhandout.cls`, is the CTAN release (ctan.org/pkg/fancyhandout: class, LPPL 1.3c, 2018-01-22), so it is one published way, `class.fancyhandout`; there is no zip-local macro, no ART and no EXTERNAL tool. Two cautions: the sample never loads `fancyhandout`, so the class look is evidenced by reading its source only; and if the class were flattened into lib ways its section-label trick (`fancyhandout.cls:279-304`) would have no lib home, which does not matter while the class is published.

## Blockers
none

## Class setting
- Class: `class.ltxdoc` options: `11pt` (fancyhandout-doc.tex:27). Also `class.fancyhandout` (zip's own class, not loaded by the sample): options `10pt` | `12pt` (11pt default, fancyhandout.cls:50-51, 65-68), `letter` (:38, 89-91), `oneside` (:43, 85, 112), `rmfont` (:56, 167).
- Class-native vocabulary used by the sample (ltxdoc/doc): `\DescribeMacro` (fancyhandout-doc.tex:127, 132, 136, 140, 149...), `\MakeShortVerb{"}` (:44) with `"..."` short verbs through the body, `abstract` environment (:60), `multicols` (:85, loaded by doc).
- Class-native vocabulary of `fancyhandout` (defined in fancyhandout.cls, described in fancyhandout-doc.tex:144-253, not used by the sample): `\title[short]{..}`, `\subtitle[short]{..}`, `\author[short]{..}` with `\and`, `\institute[short]{..}`, `\date[short]{..}` (cls:175-211); `\maketitle` colour box (cls:214-228); unnumbered `\section` `\subsection` `\subsubsection` and starred forms, no optional argument (cls:279-304); colour names `fancyhandoutmaincolor`, `fancyhandoutsecondarycolor`, `fancyhandoutsectlinecolor`, `fancyhandoutsubsectlinecolor`, `fancyhandouttboxlinecolor`, `fancyhandouttboxfillcolor` set with `\colorlet` (cls:148-160).

## Component map
Sample (fancyhandout-doc.tex, class ltxdoc):

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class and size | fancyhandout-doc.tex:27 | `class.ltxdoc` | 11pt |
| paper and size option | fancyhandout-doc.tex:27 | `page.class-options` | 11pt |
| quotation marks | fancyhandout-doc.tex:29, 100 | `lang.csquotes` | `\enquote*` used once |
| hyperlinks and metadata | fancyhandout-doc.tex:30, 55; `\url`/`\href` at :51-52, 97, 110, 274 | `meta.hyperref` | unicode, pdfborder={0 0 0}; pdftitle, pdfauthor via `\hypersetup` |
| verbatim and short verb | fancyhandout-doc.tex:31, 44 | `code.verbatim` | `verbatim` package loaded; `\MakeShortVerb{"}` |
| math font | fancyhandout-doc.tex:33 | `font.newtx` | `newtxmath` only, option erewhon (the package is the parameter) |
| text fonts | fancyhandout-doc.tex:34-37 | `font.fontspec` | `\setmainfont{erewhon}`; `\setsansfont[Scale=MatchLowercase]{Source Sans Pro}`; `\setmonofont[Scale=MatchLowercase]{Hack}` |
| language | fancyhandout-doc.tex:39-40 | `lang.polyglossia` | `\setdefaultlanguage{english}` |
| ligature suppression | fancyhandout-doc.tex:41 | `sp.selnolig` | option english |
| paragraph indent | fancyhandout-doc.tex:45, 60 | `sp.lengths` | `\parindent0pt` (also inside abstract) |
| page geometry | fancyhandout-doc.tex:47 | `page.geometry` | left=4.50cm, right=2.75cm, top=3.25cm, bottom=2.75cm, nohead |
| hyphenation | fancyhandout-doc.tex:49 | `sp.hyphenat` | `\hyphenation{re-du-cing}` |
| title block | fancyhandout-doc.tex:51-53, 58 | `front.maketitle` | `\title` with `\texttt`, `\\`, `\large`, `\url`; `\author` with `\\`, `\href{mailto:..}`; `\date{2018/01/22}` |
| abstract | fancyhandout-doc.tex:60-74 | `abs.kernel` | `\parindent0pt`, `\noindent`, `\smallskip` inside |
| contents | fancyhandout-doc.tex:77 | `toc.kernel` | `\tableofcontents`; manual `\addcontentsline{toc}{subsection}{..}` after starred headings (:83, 90, 109) |
| page breaks | fancyhandout-doc.tex:78, 113, 258 | `pg.break` | `\clearpage` |
| headings | fancyhandout-doc.tex:82, 89, 108, 119-120, 144, 178, 201, 236 | `head.kernel` | `\section`, `\subsection`, `\subsection*`, `\subsubsection*` (numbered under ltxdoc) |
| columns | fancyhandout-doc.tex:85-87 | `cols.multicol` | `multicols{3}` |
| alignment | fancyhandout-doc.tex:85 | `sp.ragged` | `\centering` |
| lists | fancyhandout-doc.tex:102-105, 190-198, 210-218, 261-272 | `list.kernel` | `itemize`, `enumerate`; `\itemsep 0pt` at :102 via `sp.lengths` |
| list spacing | fancyhandout-doc.tex:102 | `sp.lengths` | `\itemsep 0pt` |
| manual spacing | fancyhandout-doc.tex:64, 123, 126, 131, 150 | `sp.manual-space` | `\smallskip`, `\medskip`, `\bigskip`, `\\[\smallskipamount]` |
| cross-reference | fancyhandout-doc.tex:144, 186 | `xref.kernel` | `\label{docinfo}`, `\ref{docinfo}` |
| text marks and family switches | fancyhandout-doc.tex:62, 70, 85, 151 | `mark.kernel` | `\textbf`, `\emph`, `\textsf`, `\textit`, `\texttt`, `\ttfamily` |

The class `fancyhandout` (fancyhandout.cls, a published class: each row is carried by the one way `class.fancyhandout`; the note in Parameters is what the class does, not an emitted way):

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| base class | fancyhandout.cls:65-75 | `class.fancyhandout` | loads article at 10/11/12pt, `twoside` unless oneside; `\parindent 0pt` (:78) |
| page | fancyhandout.cls:85-97 | `class.fancyhandout` | geometry a4paper or letterpaper, twoside, 2.25cm on all four sides, includehead, includefoot |
| header and footer | fancyhandout.cls:108-130 | `class.fancyhandout` | fancyhdr `fancy`; head ro,le = short author, ":~", short title; foot ro,le = page, re,lo = short date; oneside variant r/l/r; `\footrulewidth` 0.4pt; headheight 14pt |
| lists | fancyhandout.cls:105-106 | `class.fancyhandout` | enumitem `\setlist{itemsep=0ex,topsep=.75ex}` |
| colour | fancyhandout.cls:145-160 | `class.fancyhandout` | `fancyhandoutblue` = rgb 0.2,0.2,0.7; secondary = blue!85; title-box fill = main!12.5 |
| font | fancyhandout.cls:167 | `class.fancyhandout` | `\familydefault` = `\sfdefault` unless rmfont |
| title data | fancyhandout.cls:175-211 | `class.fancyhandout` | beamer-like `\insert...` macros, short forms in optional argument |
| title box | fancyhandout.cls:214-228 | `class.fancyhandout` | `\thispagestyle{empty}`; two nested `\fcolorbox` around a `\parbox{.95\textwidth}`; title `\LARGE\bfseries`, subtitle `\large`, rest `\small` |
| contents | fancyhandout.cls:235-241 | `class.fancyhandout` | `\tableofcontents` plus `\vskip 1.5\bigskipamount`; `\numberline` emptied (no numbers) |
| headings | fancyhandout.cls:244-304 | `class.fancyhandout` | section `\Large\bfseries` over a 3pt rule in `sectlinecolor`; subsection `\large\bfseries` over a 1.5pt rule in `subsectlinecolor`; subsubsection `\bfseries`, no rule; never numbered; `\addcontentsline` unless starred; `\@currentlabel` = `\enquote{title}` |
| quotes | fancyhandout.cls:103 | `class.fancyhandout` | csquotes loaded at end of preamble |
| PDF metadata hook | fancyhandout.cls:134-139 | `class.fancyhandout` | `\hypersetup{pdftitle, pdfauthor, pdfcreator}` when hyperref is present |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| whole `fancyhandout.cls` | fancyhandout.cls:1-311 | not bespoke: CTAN release (W1), one way `class.fancyhandout` | W2 options and `\colorlet` names; W3 a handout class; W4 `\documentclass[opts]{fancyhandout}` plus `\title[..]{..}` |
| title/short-form macros | fancyhandout.cls:175-211 | n/a (published); flattened: yes | strings go into `hf.fancyhdr` and `front.maketitle`; empty fields dropped at emit time |
| `\maketitle` colour box | fancyhandout.cls:214-228 | n/a (published); flattened: yes | `box.fancybox` (`\fcolorbox` twice) + `box.minipage` + `font.size-commands` + `sp.manual-space` |
| fancy section commands | fancyhandout.cls:244-276 | n/a (published); flattened: yes | `head.titlesec` block format + `sp.rule` coloured by `color.xcolor` + `sp.manual-space` |
| section wrappers, `\@currentlabel` = `\enquote{title}` | fancyhandout.cls:279-304 | n/a (published); flattened: no lib home | `\ref` printing the title is hand-rolled label rewriting; nearest is `xref.hyperref` `\nameref`, not equivalent |
| `\numberline` emptied | fancyhandout.cls:241 | n/a (published); flattened: partly | `toc.tocloft` or `toc.titletoc` could drop numbers, but the redefinition is global (also lists of figures) |
| sample's own macros | fancyhandout-doc.tex (grep: no `\newcommand`, `\def`, new environment, counter or conditional) | none present | none |

## Content-opaque
none

Notes: the fonts Erewhon, Source Sans Pro and Hack are named by `\setmainfont`, `\setsansfont`, `\setmonofont` (fancyhandout-doc.tex:35-37) and are not shipped (missing assets, not a blocker). `fancyhandout-doc.pdf` (the compiled manual) is in the zip and was not read. `fancyhandout.cls:311` holds a TODO comment ("Beamer styled boxes!!") and the manual lists planned features (fancyhandout-doc.tex:259-272): unbuilt, not part of the look. `etoolbox` is loaded by the class (cls:29) as infrastructure only (`\AtEndPreamble`, cls:103).

## Lib changes
- New ways proposed: `sp.selnolig` `selnolig` package (CTAN, ctan.org/pkg/selnolig read: selective suppression of typographic ligatures by search patterns; needs LuaLaTeX per that page; seen with option english at fancyhandout-doc.tex:41), engine xe/lua. W1: CTAN package. W2: language option and rule lists, no code edited. W3: serves one kind of component (ligature suppression across a document). W4: one preamble line. No lib way covers it (`sp.microtype` is protrusion and expansion, `font.fontspec` is face selection).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this). `class.fancyhandout` needs no proposal (class way); native vocabulary is recorded under "Class setting".
