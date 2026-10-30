yes

# 0378-fariscovernew: fariscovernew (Arabic and English cover-page generator, with its Arabic user manual)

- Unverified: read from the source, not compiled.
- Source: Source/0378-fariscovernew/ (origin: https://mirrors.ctan.org/macros/unicodetex/latex/fariscovernew.zip; licence: LPPL 1.3c, README.md:4 and LICENSE.md:1-3)
- Kind: misc (the sample is the package's own Arabic user manual on kernel `report`; the covers the package prints are for books, chapters and course notes, so no listed kind fits better)
- Lib: v4
- Engine: needs XeLaTeX (fariscovernew.sty:17-22 stops with a `\PackageError` under pdfTeX; it loads `fontspec` and `bidi` at :23-24; README.md:15 and :29 say XeLaTeX or LuaLaTeX; the manual loads `fontspec` and `polyglossia`, fariscovernew-doc.tex:9-10)
- Look carried by: mixed (the nine cover designs are carried by the published CTAN package `fariscovernew`, shipped in the zip as fariscovernew.sty; the manual's page, fonts, listings, counters and link colours are carried by its own preamble on kernel `report`, fariscovernew-doc.tex:5-78)
- Class origin: tex-distribution-unbundled (the sample's class is kernel `report`, not in the zip; the only local file that is not the sample, fariscovernew.sty, is a package, not a class, and is the author's own CTAN release: https://ctan.org/pkg/fariscovernew read once, author Faris Hameed, LPPL 1.3c, v1.1, path macros/unicodetex/latex/fariscovernew)
- Main file: fariscovernew-doc.tex (other samples: none; fariscovernew-doc.pdf is compiled output and was not read)
- Read: main yes (all 1096 lines), zip-local classes and styles all (fariscovernew.sty, all 766 lines; no `.cls`, `.def`, `.cfg` or `.clo` in the zip)

## Verdict
yes. The zip is one package, `fariscovernew.sty`, which is on CTAN (so W1 holds), plus its Arabic manual. The manual's own preamble and body use only published packages and kernel commands (`report`, `geometry`, `fontspec`, `polyglossia`, `listings`, `hyperref`, `chngcntr`, `adjustbox`) and four tiny macros or shims that reduce by inline expansion. Everything the package does (nine TikZ cover designs, point-size guards, a colour complement and triad computed with `pgfmath`) sits inside the published package, which I propose as one way, `front.fariscovernew`, chosen by a closed style name and declarative values. The emitter writes `\usepackage{fariscovernew}` and calls, and copies none of that code. This is a judgement: a reviewer who counts the package's internal TikZ drawings as template-defining artwork, even though a published package holds them, would turn it into `ART/package`; I did not, following the earlier rulings for `cal.kalender`, `label.mceinleger` and `uni-titlepage`.

## Blockers
none

## Class setting
- Class: `class.report` options: `a4paper`, `12pt` (fariscovernew-doc.tex:5). Kernel class, loaded unchanged and not bundled; its source was not read.
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (fariscovernew-doc.tex:49-52, 84), `\tableofcontents` (:86), `\section` `\subsection` `\subsubsection` (:91, 129, 704), `itemize` (:915-923, 1044-1054, 1062-1071), `tabular` (:307-328), `center` (:306, 1090). No `\chapter` and no `abstract` environment (the manual detaches `section` from `chapter`, :69).
- Vocabulary of the published package (not of the class): `\FarisTitlePage[Lang][TitlePt][SubtitlePt][Color][MainFont][SubFont][SubRatio]{Title}{Subtitle}` (fariscovernew.sty:764-767; on 66 lines of the manual, first at fariscovernew-doc.tex:96), environment `FarisTitlePageEnv` (fariscovernew.sty:533), setters `\FarisSetStyle` `\FarisSetColor` `\FarisSetAccentColor` `\FarisSetDims` (fariscovernew.sty:84-102), text colours `\FarisSetTitleTextColor` `\FarisSetSubtitleTextColor` `\FarisReset*` (:56-63), `diamondx` settings `\FarisDiamondBackComplementOn/Off`, `\FarisSetDiamondTints` `\FarisSetDiamondBackTintII` `\FarisSetDiamondAngles` `\FarisSetDiamondAnglePair` `\FarisSetDiamondBackDelta` `\FarisSetDiamondTriadOffset` (:208-237).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | fariscovernew-doc.tex:5 | `class.report` | `a4paper,12pt` |
| paper and size | fariscovernew-doc.tex:5 | `page.class-options` | `a4paper`, `12pt` |
| page geometry | fariscovernew-doc.tex:6 | `page.geometry` | `margin=1.5cm` |
| text and Arabic faces | fariscovernew-doc.tex:9, 13-14 | `font.fontspec` | `\newfontfamily\arabicfont[Script=Arabic]{Amiri}`, `\newfontfamily\englishfont{Latin Modern Roman}` |
| monospace face | fariscovernew-doc.tex:17 | `font.fontspec` | `\setmonofont{DejaVu Sans Mono}[Scale=MatchLowercase]` |
| languages and numerals | fariscovernew-doc.tex:10-12 | `lang.polyglossia` | `\setmainlanguage[numerals=eastern]{arabic}`, `\setotherlanguage{english}` |
| English passages | fariscovernew-doc.tex:27, 94-98, 49 | `lang.polyglossia` | `\textenglish{...}` and the `english` environment around each listing |
| right-to-left span inside a listing escape | fariscovernew-doc.tex:26 | `lang.bidi` | `\beginR ... \endR` (bidi), inside `\text` |
| math text helper | fariscovernew-doc.tex:20, 26 | `math.amsmath` | `\usepackage{amsmath}`; only `\text` is used |
| colour | fariscovernew-doc.tex:22, 33-34, 892 | `color.xcolor` | `rulecolor=\color{gray!60}`, `backgroundcolor=\color{gray!3}`, `\definecolor{CustomBlue}{RGB}{25,118,210}` |
| code listings | fariscovernew-doc.tex:23, 29-40, 95 | `code.listings` | `\lstdefinestyle{fariscode}`: `basicstyle=\ttfamily\small`, `breaklines`, `frame=single`, `columns=fullflexible`, `keepspaces`, `language={[LaTeX]TeX}`, `showstringspaces=false`, `escapeinside={@}{@}` |
| title block | fariscovernew-doc.tex:49-52, 84 | `front.maketitle` | `\title{...\\...}`, `\author`, `\date{\en{2026/03/21}}`, `\maketitle` |
| cover pages (the package's whole job) | fariscovernew-doc.tex:43, 96, 105; fariscovernew.sty:533-767 | `front.fariscovernew` | `\usepackage{fariscovernew}`; `\FarisSetStyle` one of `triple` `diagonal` `wave` `badge` `diamond` `minimal` `ribbon` `sidebar` `diamondx` (fariscovernew.sty:304-518, 521-527); `\FarisTitlePage` args `[A\|E][TitlePt][SubtitlePt][Color][MainFont][SubFont][SubRatio]{Title}{Subtitle}`, values such as `[A][90][-][DarkOrange1][Diwani Simple Striped][Amiri][0.6]` (fariscovernew-doc.tex:1022); colours `\FarisSetColor{SlateBlue}`; `diamondx` tints 30/30/40, angle pair 45, delta 15, triad offset 75 (fariscovernew-doc.tex:208-216) |
| cover text colours | fariscovernew-doc.tex:381-383, 404-406 | `front.fariscovernew` | `\FarisSetTitleTextColor{orange}`, `\FarisSetSubtitleTextColor{DarkOrange1}`, `\FarisResetTextColors` |
| cover page size and corner | fariscovernew-doc.tex:932 | `front.fariscovernew` | `\FarisSetDims{width}{height}{corner}` (defaults 18cm, 26.7cm, 8mm, fariscovernew.sty:43-45) |
| scaled preview of each cover | fariscovernew-doc.tex:46, 103-107 | `fig.adjustbox` | `\adjustbox{scale=0.3,center}{...}` (27 uses) |
| box around the preview | fariscovernew-doc.tex:104 | `box.minipage` | `\begin{minipage}{\textwidth}` around one `\FarisTitlePage` |
| table of contents | fariscovernew-doc.tex:86 | `toc.kernel` | `\tableofcontents` |
| contents and numbering depth | fariscovernew-doc.tex:71-72 | `num.secnumdepth` | `secnumdepth=3`, `tocdepth=3` |
| counters detached and nested | fariscovernew-doc.tex:65, 69-70, 74-76 | `num.counters` | `\counterwithout{section}{chapter}`, `\counterwithin{subsection}{section}`, `\renewcommand\thesubsection{\arabic{section}-\arabic{subsection}}`, `\thesubsubsection` likewise; all inside `\AtBeginDocument` (:67-78) |
| section numbers | fariscovernew-doc.tex:91, 129, 704 | `head.kernel` | `\section` `\subsection` `\subsubsection` at default look; `\@seccntformat` set to `\csname the#1\endcsname\quad` (:54-56) |
| links and bookmarks | fariscovernew-doc.tex:58-63 | `meta.hyperref` | `unicode`, `colorlinks=true`, `linkcolor=blue`, `bookmarks=false`; `\pdfstringdefDisableCommands` shims for `\textarabic` `\textenglish` |
| lists | fariscovernew-doc.tex:915-923 | `list.kernel` | `itemize` with `\item \textbf{..}:` |
| table | fariscovernew-doc.tex:306-328 | `tbl.tabular` | `{|c|c|c|c|}` with `\hline` (no `booktabs`) |
| emphasis | fariscovernew-doc.tex:102, 309 | `mark.kernel` | `\textbf` |
| manual spacing | fariscovernew-doc.tex:100, 102, 109 | `sp.manual-space` | `\vspace{0.5cm}`, `\\[0.3cm]`, `\vspace{6cm}` |
| page breaks | fariscovernew-doc.tex:85, 88, 151 | `pg.break` | `\newpage`, `\clearpage` |
| header, footer, page numbers | none set | n/a | no `\pagestyle`, no `fancyhdr`; `report` defaults. The cover itself sets `\thispagestyle{empty}` inside the package (fariscovernew.sty:734) |
| floats, captions, theorems, bibliography, index, notes, boxes | none in the sample | n/a | not used (grep found no `figure`, `\caption`, `\cite`, `\label`, `\ref`, theorem or bibliography command) |
| load-only extras | fariscovernew-doc.tex:47 | `box.fancybox` | `\usepackage{fancybox}` is loaded and no `\fbox`, `\shadowbox`, `\ovalbox` call is made (grep) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\AR{x}` | fariscovernew-doc.tex:26 | yes | inline expansion `\(\text{\beginR\arabicfont x\endR}\)`: `lang.bidi`, `font.fontspec` (`\arabicfont`), `math.amsmath` (`\text`) |
| `\en{x}` | fariscovernew-doc.tex:27 | yes | inline expansion `\textenglish{ x}`: `lang.polyglossia` |
| `\def\@seccntformat` | fariscovernew-doc.tex:54-56 | yes | the heading-number format string `\csname the#1\endcsname\quad` under `head.kernel`; this matches the kernel's own definition as far as I know (the kernel source is not in the zip, not read), so it may be a no-op |
| `\pdfstringdefDisableCommands{\def\textarabic..\def\textenglish..}` | fariscovernew-doc.tex:60-63 | yes | two hyperref bookmark-string shims, parameters of `meta.hyperref` |
| `\AtBeginDocument{...}` block | fariscovernew-doc.tex:67-78 | yes | the `chngcntr` calls, `\renewcommand\the...` and two `\setcounter` lines of `num.counters` and `num.secnumdepth`, printed at the same hook |
| `fariscovernew.sty` internals: size guards (`\FarisSetBaseDim`, `\FarisBuildSubSize`, `\FarisApplyRatioOrAuto`), colour complement and triad through `pgfmath` (`\FarisDefineComplementColor`, `\FarisDefineTriadFromColor`), nine `\farisDraw<style>` TikZ macros, the `xparse` environment | fariscovernew.sty:166-203, 244-299, 304-518, 533-759 | not applicable: published (CTAN release, W1) | this is the code of the way `front.fariscovernew`; the emitter calls the package and never reproduces the code. It would be irreducible if the package were zip-local, so the verdict rests on W1 (CTAN page read once) |

## Content-opaque
- Arabic and English text throughout, and the code text inside every `lstlisting` body, which holds `\FarisTitlePage` calls and Arabic escapes written with `escapeinside` (fariscovernew-doc.tex:95-97, 116-126 and the same pattern after each demo). No artwork sits in the sample itself: the manual has no `tikzpicture`; every drawing comes from the package.
- Fonts not shipped: Amiri, DejaVu Sans Mono, Latin Modern Roman, `Diwani Simple Striped`, `Times New Roman`, `Georgia` (fariscovernew-doc.tex:13-17, 248, 832). The package tests each font name with `\IfFontExistsTF` and keeps the default with a warning when it is missing (fariscovernew.sty:697-707, 717-727). Note only; ship them.

## Lib changes
- New ways proposed: `front.fariscovernew` `fariscovernew` (CTAN, LPPL 1.3c, Faris Hameed, v1.1; ctan.org/pkg/fariscovernew read once; XeLaTeX/LuaLaTeX), engine xe/lua. A full-page cover generator: `\usepackage{fariscovernew}`, `\FarisSetStyle{name}` (nine names, a closed list), `\FarisSetColor`, `\FarisSetDims`, text-colour and `diamondx` setters, and one body call `\FarisTitlePage[Lang][TitlePt][SubtitlePt][Color][MainFont][SubFont][SubRatio]{Title}{Subtitle}` or the `FarisTitlePageEnv` environment. W1: released on CTAN. W2: behaviour is chosen by a style name, colours, point sizes, a ratio, two font names, a language letter, tints, angles and lengths, never by editing code. W3: it serves the cover page of any document (the title and subtitle are the content), not one document. W4: preamble lines and one body call wrapping two strings. Not `front.uni-titlepage` (a KOMA `scrbase` package of 13 styles that replaces `\maketitle`; this package draws its own page and leaves `\maketitle` alone), not `front.class-native` (it is a package, not a class), not `front.titlepic` (a picture slot). It could be folded into `front.uni-titlepage` as "a cover-page package chosen by style name", which is the consolidator's call. The drawings inside the package are fixed shapes, parameterised only by colour, size and angle, as `cal.kalender` and `label.mceinleger` have fixed sizes.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
