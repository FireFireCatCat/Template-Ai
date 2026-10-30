yes

# 0366-simpletexcv: SimpleTeXCV (restrained CV plus matching cover letter on the kernel `letter` class)

- Unverified: read from the source, not compiled.
- Source: Source/0366-simpletexcv/ (origin: https://latextemplates.com/downloads/simpletexcv.zip; licence: MIT, main.tex:1-21, README.md:17-18)
- Kind: cv (main.tex is the CV; cover_letter.tex is a second, separate letter sample; manifest hint was `misc`)
- Lib: v3
- Engine: pdfLaTeX-compatible (no fontspec, unicode-math or Lua code anywhere)
- Look carried by: preamble (the zip has no `.cls` or `.sty`; the look is `\newcommand` definitions and package options in the samples: main.tex:30-189, cover_letter.tex:29-88)
- Class origin: tex-distribution-unbundled (kernel `letter`, loaded unchanged; its source is not in the zip and was not read)
- Main file: main.tex (other samples: cover_letter.tex)
- Read: main yes, zip-local classes and styles none present (3 files in the zip: README.md, main.tex, cover_letter.tex; all read in full)

## Verdict
Yes. No class or style file is zip-local, no TikZ or picture artwork exists, and no counter, conditional, `\def` or token-level code exists in either sample (grep for `\if`, `\def`, `\let`, `\newcounter`, `\newif`, `\makeatletter`: only `\newcommand`/`\renewcommand` and one `\let`). Every zip-local macro is a composition of kernel commands and published-package commands with lengths, colours and strings, so each is reducible and written down below. The one point a reviewer may weigh is that the CV's heading, title and entry macros are hand-rolled rather than a published CV class (`cv.entries` does not apply: W1 fails, they exist only in this zip); they are held as reducible compositions, not as a way.

## Blockers
none

## Class setting
- Class: `class.letter` options: `a4paper`, `11pt` (main.tex:24; cover_letter.tex:24)
- Class-native vocabulary used: main.tex uses none (the CV is set on `letter` without a `letter` environment or `\opening`; it defines its own `\section` and `\maketitle`, main.tex:84,101). cover_letter.tex uses `\date` (49), `\signature` (62), `\longindentation` (64), `\raggedleft` (65, hacked), `\begin{letter}{recipient}` (92-98), `\opening` (104), `\closing` (124), `\encl` (127). No `\address`/`\name` is used: the sender block is the sample's own `\contact` (81-88).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:24; cover_letter.tex:24 | `class.letter` | a4paper, 11pt |
| paper and point size | main.tex:24; cover_letter.tex:24 | `page.class-options` | a4paper, 11pt |
| page geometry, CV | main.tex:64 (values 57-60) | `page.geometry` | a4paper, bindingoffset=0.0cm, left=2cm, right=2cm, top=2cm, bottom=2cm, footskip=.25in |
| page geometry, letter | cover_letter.tex:52 (values 43-46) | `page.geometry` | same keys; left=2.5cm, right=2.5cm, top=2.5cm, bottom=3cm |
| widows and clubs | main.tex:75-76 | `sp.penalties` | `\widowpenalty`=10000, `\clubpenalty`=10000 (CV only) |
| type sizes | main.tex:86,103,126,139,151,189; cover_letter.tex:68,75 | `font.size-commands` | `\Large`; `\fontsize{12pt}{12pt}` (section, 52); `\fontsize{11pt}{11pt}` (entries, 53); `\tiny` (bullet); no font-family package: Computer Modern default |
| colour | main.tex:48-50,86,103; cover_letter.tex:41 | `color.color` | named `black` (title, section), `blue` (links); `\textcolor` is called (86,103) but no `color`/`xcolor` load is in the sample; hyperref `colorlinks` is the likely loader (not checked), an emitter would load `xcolor` |
| URLs | main.tex:65; cover_letter.tex:54 | `meta.url` | `url` package, no options; `\url` used at main.tex:93 |
| hyperref and PDF metadata | main.tex:66-67; cover_letter.tex:55-56 | `meta.hyperref` | bookmarks, colorlinks, breaklinks, pdftitle=`CV~\cvauthor` (44), pdfauthor (45); `\hypersetup{linkcolor=blue, citecolor=blue, filecolor=black, urlcolor=blue}`; `\href` links at main.tex:94-95,170,178 |
| CV title block | main.tex:84-89,193 | composition of `sp.ragged` (`center` env), `font.size-commands` (`\Large`), `mark.kernel` (`\bf`), `color.color` (`\textcolor{black}`), `sp.manual-space` (`\smallskip`), `sp.rule` (`\hrule height 1pt`) | one argument (the name); not kernel `\title`/`\maketitle` data flow |
| CV contact block | main.tex:92-98,195 | composition of `meta.url`, `meta.hyperref` (`\href`), `mark.kernel` (`\texttt`), `sp.manual-space` (`\hfill`, `\\`) | five label rows, left text and right address, split with `\hfill` |
| section headings | main.tex:101-107; used at 198,207,225,242,249,256 | `head.kernel` (a `\section` defined by kernel `\newcommand`: the class has none) over `sp.manual-space` (`\medskip`, `\smallskip`), `font.size-commands`, `mark.kernel`, `color.color`, `sp.rule` (`\hrule height 0.5pt`) | unnumbered, bold, 12pt/12pt, black, rule below; no counter, no toc entry (equivalent under an article-like class: `head.titlesec` `\titleformat` + `\titlespacing`) |
| work, education and skill entries | main.tex:137-146,149-158,161-165; used 209-246 | composition of `mark.kernel` (`\textbf`, `\textit`), `font.size-commands`, `sp.manual-space` (`\hfill`, `\\`, `\vspace{0mm}`), `list.enumitem` (local `\setlist`), `sp.lengths` (`\parskip`) | title+employer bold left, date bold right, 11pt/11pt; inner list `itemsep=0.1em, topsep=0.1em, leftmargin=0.8cm`; `\parskip=0cm plus0mm minus0mm` (132,144,157); `\cvitem` bold label + `: ` + text with `\parskip=.2em` (163) |
| unused entry variants | main.tex:124-134,168-179,182-183 | same compositions as above | `\workentrytwolines`, `\publicationeasyread`, `\publicationclassic` and the selectors `\workentry`, `\publication` are defined but only `\workentry` (209,218) is called |
| bullet lists | main.tex:200-204,211-215,230-232,251-253; cover_letter.tex:115-119 | `list.kernel` | `itemize`; label redefined at main.tex:189, cover_letter.tex:68 |
| list spacing | main.tex:70,186 | `list.enumitem` | global `\setlist{itemsep=.2em, topsep=.0em, leftmargin=0.8cm}` |
| bullet glyph | main.tex:189; cover_letter.tex:68 | `list.kernel` (`\renewcommand\labelitemi`; same value as `list.enumitem` `label=`) | `$\vcenter{\hbox{\tiny$\bullet$}}$`: a single small centred bullet glyph |
| references in two columns | main.tex:117-121,256-268 | `tbl.tabular` over `box.minipage` | `tabular{p{0.5\linewidth} p{0.5\linewidth}}`, cells `\parbox[t]{\textwidth}{...}`; `\threecolumns` (110-114) is the same with 3 x 0.33 and is unused |
| loaded, never called | main.tex:71,72,73 | `page.adjustwidth` (`changepage`), `list.scrextend` (`scrextend`), `mark.ulem` (`ulem`, option `normalem`) | load-only; no `adjustwidth`, `addmargin`, `labeling`, `\uline`, `\sout` appears in either sample |
| loaded, no effect | main.tex:69 | no way needed | `ifthen` is loaded and `\ifthenelse` is never used; it has no output effect, so it is not part of the look |
| letter envelope structure | cover_letter.tex:49,62,92-98,104,124,127,129 | `ltr.opening` | `\date{\today}`, `\signature{Jordan Ashworth}`, recipient argument of `letter`, `\opening{Dear Hiring Team,}`, `\closing{Yours sincerely,}`, `\encl{Curriculum vitae}` |
| letter flush-left hacks | cover_letter.tex:64,65 | `ltr.opening` (`\longindentation=0pt`, a class length) and `sp.ragged` (`\let\raggedleft\raggedright`) | closing and date flush left |
| letter title block | cover_letter.tex:73-78,100 | composition of `sp.ragged`, `font.size-commands`, `mark.kernel`, `sp.manual-space`, `sp.rule` | `center`, `\Large\bf`, `\smallskip\hrule height 1pt`; no colour here (`\titlefontsize` at 42 is defined, never used) |
| letter sender block | cover_letter.tex:81-88,102 | composition of `sp.ragged` (`center`), `meta.hyperref` (`\href`), `meta.url`, `mark.kernel` (`\texttt`), `sp.manual-space` (`\\`) | address, email, web, tel, centred |
| footnote placement | cover_letter.tex:53 | `fn.footmisc` | option `bottom`; no footnote is called |
| page numbers | cover_letter.tex:57 | `pgnum.pagenumbering` | `\pagenumbering{gobble}` (CV sets none; no `\pagestyle` or `\thispagestyle` in either sample, so the `letter` class default applies, class source not read) |
| math, theorems, floats, captions, code, bibliography, index, cross-references, abstract, contents, font-family packages | none | none | not used in either sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| author and style constants (`\cvauthor`, `\marginleft`, `\linespacing`, ...) | main.tex:30-60; cover_letter.tex:29-46 (scope: preamble) | yes | plain `\newcommand` aliases for strings, lengths and colour names; they are the parameters of `page.geometry`, `list.enumitem`, `color.color`, `meta.hyperref` |
| `\renewcommand{\maketitle}[1]` | main.tex:84-89 (scope: body, defined after `\begin{document}`) | yes | `center` + `\Large\bf` + `\smallskip\hrule height 1pt` (ways in the table) |
| `\contact` (CV) | main.tex:92-98 (body) | yes | text rows with `\url`, `\href`, `\texttt`, `\hfill`, `\\` |
| `\section` | main.tex:101-107 (body) | yes | `\medskip`, `\fontsize` + bold, `\smallskip`, `\hrule height 0.5pt`, `\smallskip`; no counter or conditional. `\fontsize` has no `\selectfont` of its own (103); the size presumably takes effect through the `\bf` that follows (the kernel `\bf` calls `\selectfont`, from memory of the kernel, not checked here); recorded, not a blocker |
| `\threecolumns`, `\twocolumns` | main.tex:110-121 (body) | yes | `tabular` of `p{0.33\linewidth}` / `p{0.5\linewidth}` columns holding `\parbox[t]{\textwidth}` |
| `\workentrytwolines`, `\workentryoneline` | main.tex:124-134, 137-146 (body) | yes | bold `\hfill` line, then a group with `\setlist{...}` and `\setlength{\parskip}{0cm plus0mm minus0mm}` around the description argument |
| `\eduentry` | main.tex:149-158 (body) | yes | same pattern with `\textit` degree line |
| `\cvitem` | main.tex:161-165 (body) | yes | `\parskip=.2em` group around `\textbf{#1}: #2` |
| `\publicationeasyread`, `\publicationclassic` | main.tex:168-179 (body) | yes | `\href` + `\textbf`/`\textit` + `\\` (unused in the body) |
| selectors `\workentry`, `\publication` | main.tex:182-183 (body) | yes | pure aliases (`\newcommand{\workentry}{\workentryoneline}`); no `\ifthenelse` or switch |
| `\renewcommand{\labelitemi}` | main.tex:189; cover_letter.tex:68 | yes | kernel list label set to a string; one centred `\tiny` bullet (`\vcenter{\hbox{...}}` here builds one glyph, not a layout algorithm) |
| `\makecovertitle` | cover_letter.tex:73-78 (scope: body, defined after `\begin{document}` at 60 and before `\begin{letter}` at 92) | yes | `center`, `\Large\bf`, `\smallskip\hrule height 1pt` |
| `\contact` (letter) | cover_letter.tex:81-88 | yes | centred rows with `\href`, `\url`, `\texttt`, `\\` |
| `\let\raggedleft\raggedright` | cover_letter.tex:65 | yes | alias of a kernel command to another kernel command (`sp.ragged`); written as one preamble line |
| `\renewcommand{\maketitle}` target | main.tex:84 | yes (note) | `letter` itself defines no `\maketitle` to my knowledge (class source not read); some loaded package must supply one for `\renewcommand` to work. Source does not show which; not checked, does not change the reduction |

## Content-opaque
none

## Lib changes
- New ways proposed: none. (Considered: `ifthen`, loaded but never called, so it contributes no component; `cv.entries` rejected for the CV macros because they are zip-local, W1 fails, and reduced to compositions instead.)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
