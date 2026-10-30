yes

# 0450-pmichaillat-cv: Pmichaillat CV

- Unverified: read from the source, not compiled.
- Source: Source/0450-pmichaillat-cv/ (origin: https://latextemplates.com/downloads/pmichaillat-cv.zip; licence: MIT)
- Kind: cv
- Lib: v4
- Engine: pdfLaTeX-compatible (cv.sty:4-5 uses the pdfTeX primitive `\pdfgentounicode`, so not XeLaTeX or LuaLaTeX as written)
- Look carried by: zip-local (cv.sty holds fonts, geometry, spacing, headings, lists, footer and the CV macros; main.tex only loads it and supplies footer values and the PDF title)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
A two-file zip: an unmodified kernel `article` plus a zip-local `cv.sty`. `cv.sty` is 124 lines of published-package loads with options and eight small `\newcommand`/`\DeclareRobustCommand` aliases, and every alias expands inline into lib ways (see Bespoke code). No artwork, no counters or conditionals that drive output, no external tool. One component has no lib line (math letters taken from the text face, `mathastext`) and is proposed as `font.mathastext`; every other component maps to an existing way.

## Blockers
none

## Class setting
- Class: `class.article` options: `letterpaper`, `10pt` (main.tex:4)
- Class-native vocabulary used: `\section*` and `\subsection*` (through the `\name` and `\block` aliases, cv.sty:109,118); `itemize` (main.tex:19); no `\maketitle`, no `abstract`, no page numbers printed.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class and paper/size | main.tex:4 | `class.article`, `page.class-options` | letterpaper, 10pt |
| zip-local style load | main.tex:5 | (bespoke, see below) | `\usepackage{cv}`: the file is cv.sty in the zip, not the CTAN package `cv` |
| PDF text map | cv.sty:4-5 | `meta.glyphtounicode` | `\input{glyphtounicode}`, `\pdfgentounicode=1` |
| font encoding | cv.sty:8 | `font.fontenc-t1` | fontenc T1 |
| text face | cv.sty:11 | `font.serif-pkg` | sourceserifpro, no options |
| semibold series switch | cv.sty:14-15 | `font.nfss` | `\fontseries{sb}\selectfont` named `\sbseries`; `\DeclareTextFontCommand{\textsb}{\sbseries}` (`\textsb` is not used in main.tex) |
| monospaced face | cv.sty:18 | `font.mono` | sourcecodepro, no options (no `\texttt` in the sample) |
| math symbol font | cv.sty:23 | `math.amssymb` | MnSymbol, no options (math symbol-font package is the parameter; considered `font.icons`, which names pictogram packages) |
| math alphabets | cv.sty:26 | `math.bm` | mathalpha, `cal=euler`, `bb=fourier` (alphabet package is the parameter, as `mathrsfs`, `dsfont`) |
| math letters from the text face | cv.sty:29-35 | `font.mathastext` | options `italic, eulergreek, nolessnomore, noparenthesis, noplusnominus, noequal, nohbar`; `\MTsetmathskips{f}{3mu}{0mu}`, `{y}{2mu}{0mu}`, `{p}{2mu}{0mu}`, `{j}{2mu}{0mu}` |
| page geometry | cv.sty:39 | `page.geometry` | top=0.9in, left=1.2in, right=1.2in, bottom=1.1in, footskip=0.7in |
| line spacing | cv.sty:44,47 | `sp.setspace` | `\setstretch{1.1}` |
| microtype | cv.sty:50 | `sp.microtype` | package defaults, no options |
| space after a period | cv.sty:53 | `sp.frenchspacing` | `\frenchspacing`, run at begin of document |
| colour set | cv.sty:57 | `color.xcolor` | `x11names`; the only colour used is `gray` (cv.sty:82,90,99,112,115,124) |
| page style | cv.sty:62,65,68,71 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\headrulewidth`=0pt, `\fancyhf{}` clears all fields, so no header and no page number |
| footer fields | cv.sty:124; main.tex:9-11 | `hf.fancyhdr`, `font.size-commands`, `color.xcolor`, `meta.url` | `\fancyfoot[C|L|R]{\footnotesize\textcolor{gray}{...}}`; values: e-mail `\url`, site `\url`, year |
| CV name line | cv.sty:109; main.tex:15 | `head.kernel` | `\section*{name}` (unnumbered), look from the titlesec row below |
| section heading look | cv.sty:76,79 | `head.titlesec`, `sp.ragged`, `font.size-commands`, `mark.kernel` | `\titleformat*{\section}{\centering\Huge\scshape}` |
| block heading look | cv.sty:82 | `head.titlesec`, `sp.manual-space`, `font.nfss`, `mark.kernel`, `color.xcolor` | `\titleformat*{\subsection}{\vskip-3mm\sbseries\scshape\color{gray}}` |
| block opener (rule + heading) | cv.sty:115,118; main.tex:17 | `sp.rule`, `sp.lengths`, `color.xcolor`, `head.kernel`, `pg.break` | `samepage` wrapper around: `\noindent`, `\textcolor{gray}{\rule{\textwidth}{0.7pt}}`, `\subsection*{title}` |
| bullet list | cv.sty:90; main.tex:19 | `list.kernel`, `list.enumitem` | `\setlist[itemize,1]{leftmargin=2em, label=\color{gray}{\textendash}}` |
| numbered list level 1 | cv.sty:93,99 | `list.enumitem`, `list.kernel` | `\setlist[enumerate,1]{leftmargin=2em}`; `\labelenumi` = gray `\theenumi.` |
| reverse-numbered list | cv.sty:96; main.tex:38 | `list.paralist` | `\usepackage[leftmargin=2em]{etaremune}`, body `etaremune` environment (an extra list-environment package; considered `list.enumitem`, the CTAN page does not say it builds on enumitem) |
| inline separator | cv.sty:112; main.tex:20 | `color.xcolor`, `sp.manual-space` | gray bullet glyph between thin spaces; glyph is a kernel text symbol under `font.fontenc-t1` |
| coauthor note | cv.sty:121; main.tex:39 | `sp.manual-space` | thin space then the text `(with ...)` |
| line break in an item, italic run | main.tex:28-31 | `sp.manual-space`, `mark.kernel` | `\\`; `\textit` |
| hyperlinks and PDF info | cv.sty:104; main.tex:7 | `meta.hyperref` | `hidelinks, hypertexnames=false, pdfpagemode=UseNone, pdfdisplaydoctitle=true`; `\hypersetup{pdftitle={...}}` |
| URL line breaking | cv.sty:103 | `meta.url` | `hyphens` passed to `url` before hyperref loads |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `cv.sty` as a whole | cv.sty:1-124 | yes | Only package loads with options plus the aliases below; no output routine, counter, conditional or kernel redefinition. Emitter inlines the rows above into the preamble; it must not ship a file called `cv.sty` (the CTAN package `cv`, by another author, shares the name) |
| `\sbseries`, `\textsb` | cv.sty:14-15 | yes | `font.nfss`: `\fontseries{sb}\selectfont` in the title format; `\textsb` unused |
| `\name{#1}` | cv.sty:109 | yes | `\section*{#1}` |
| `\sep` | cv.sty:112 | yes | inline `{\color{gray}\,\textbullet\,\,}` at each use |
| `\hsep` | cv.sty:115 | yes | `\noindent\textcolor{gray}{\rule{\textwidth}{0.7pt}}` |
| `\block{#1}` | cv.sty:118 | yes | `\begin{samepage}` + the `\hsep` expansion + `\subsection*{#1}` + `\end{samepage}` |
| `\with{#1}` | cv.sty:121 | yes | inline `\,(with #1)` |
| `\grayfoot{#1}{#2}` | cv.sty:124 | yes | `\fancyfoot[#1]{\footnotesize\textcolor{gray}{#2}}` |
| `\AtBeginDocument{\frenchspacing}` | cv.sty:53 | yes | `\frenchspacing` in the emitted preamble or at the start of the body (`sp.frenchspacing`) |

## Content-opaque
none

## Lib changes
- New ways proposed: `font.mathastext` `mathastext` (CTAN and TeX Live, LPPL 1.3c, J.-F. Burnol; the CTAN page, read, says it lets a document use its text font for the Latin letters in math mode). Engine: pdf (the CTAN page states no engines; here it loads beside T1 and a pdfTeX primitive). W1 published on CTAN; W2 chosen by package options (`italic`, `eulergreek`, ...) and `\MTsetmathskips{char}{muskip}{muskip}` with a character and two skips; W3 serves any document that wants math letters in its own text face; W4 one `\usepackage[opts]{mathastext}` line plus preamble calls. Not `font.newtx`, `font.mathptmx`, `font.palatino` (each loads one named text-and-math face bundle), not `font.serif-pkg` (a text-face package), not `math.bm` (alphabets, not the base math letters).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Judgement calls, in case a reviewer reads them differently: `samepage` is filed under `pg.break` (kernel page-break control family, as `\nopagebreak`); `\noindent` under `sp.lengths` (the one-paragraph form of `\parindent=0pt`); MnSymbol under `math.amssymb` and etaremune under `list.paralist` (package is the parameter in both).
- Published packages not bundled in the zip (their sources were not read): sourceserifpro, sourcecodepro, MnSymbol, mathalpha, mathastext, etaremune. The CTAN pages of `etaremune` (LPPL 1.3, labels count down), `mathastext` (LPPL 1.3c) and `cv` (a different package, by Philipp Maier) were read; MnSymbol and mathalpha are in TeX Live from prior knowledge, not read here.
- Whether the `\labelenumi` redefinition (cv.sty:99) also reaches the `etaremune` labels depends on etaremune's source, which was not read; it does not change the verdict, since either way the label is a colour on a list label under `list.kernel`/`list.enumitem` parameters.
- No missing assets: the fonts come from the TeX distribution. main.tex has a `£` in UTF-8 text (main.tex:58) under T1; content.
