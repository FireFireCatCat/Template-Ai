yes

# 0735-leouieda-academic-cv: Leouieda Academic CV (one-page academic CV over `article`)

- Unverified: read from the source, not compiled.
- Source: Source/0735-leouieda-academic-cv/ (origin: https://latextemplates.com/downloads/leouieda-cv.zip; licence: BSD-3-Clause)
- Kind: cv
- Lib: v5
- Engine: needs XeLaTeX or LuaLaTeX (inferred, not tested: `\usepackage[TU]{fontenc}` at main.tex:42 is the Unicode-engine encoding; the font packages atkinson, academicons, sourcecodepro and fontawesome5 each have a pdfLaTeX route, so none forces it alone)
- Look carried by: preamble (stock `article`; the look is the sample's own preamble, main.tex:11-151, plus the header block in the body, main.tex:156-184)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex, 252 lines; `article` is published and was not read)

## Verdict
yes. The zip is one `main.tex` over the kernel `article` class with no zip-local class or style. Every package it loads is published (CTAN), every printed effect maps to an existing lib way, and every zip-local macro is a text alias, a one-line spacing or font alias, or a `\NewEnviron` wrapper around `tabularx` that reduces by inline expansion. No TikZ or other artwork, no tool outside TeX. Two oddities are recorded below, not blocking: `9pt` is not an `article` size option, and `academicons` and `enumitem` are loaded but never used in the body.

## Blockers
none

## Class setting
- Class: `class.article` options: `9pt,a4paper` (main.tex:11). Per my knowledge of `article.cls` (source not read), `article` has `10pt`, `11pt`, `12pt` only, so `9pt` would be an unused option and the size stays 10pt; the emitter should keep it as a parameter or map it to a real size.
- Class-native vocabulary used: none (`\section` only; no `\maketitle`, no `abstract`, no bibliography). The header is hand-laid in the body.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:11 | `class.article` | `9pt,a4paper` |
| paper size | main.tex:11 | `page.class-options` | `a4paper` (`9pt` as written, see Class setting) |
| page geometry | main.tex:56, 67-74 | `page.geometry` | margin=12.5mm, headsep=0mm, headheight=0mm, footskip=5mm, includehead=true, includefoot=true |
| input and font encoding | main.tex:40, 42 | `font.fontenc-t1` | `inputenc` utf8; `fontenc` TU |
| sans text face (body default) | main.tex:44 | `font.helvet` | package `atkinson` (CTAN, supports pdfLaTeX, XeLaTeX, LuaLaTeX), option sfdefault (a sans text-face package is the parameter, lib v1 change log) |
| monospace face | main.tex:45, 116-117 | `font.mono` | package `sourcecodepro`, option ttdefault; printed by `\texttt` in `\Duration` and `\Year` |
| icon fonts | main.tex:47, 48, 122 | `font.icons` | `fontawesome5` (`\faGithub` at 122); `academicons` (CTAN, LPPL 1.3c) loaded, no command of it used in the body |
| any font size | main.tex:51 | `font.exscale` | `anyfontsize` (CTAN, LPPL 1.2, no options): load-only switch that lets `\fontsize` take sizes the font does not list; same type as `fix-cm` already on that line; the line's text names only `fix-cm`, so the consolidator may widen it |
| font sizes | main.tex:86, 116, 117, 127, 157 | `font.size-commands` | `\Large` (heading); `\fontsize{10pt}{0}\selectfont` (dates); `\footnotesize` (footer); `\fontsize{20pt}{0}\selectfont` (name) |
| language | main.tex:41 | `lang.babel` | english |
| hyphenation off | main.tex:50 | `sp.hyphenat` | `hyphenat` option none |
| paragraph indent | main.tex:80 | `sp.lengths` | `\parindent`=0cm |
| line spacing | main.tex:81 | `sp.linespread` | `\baselinestretch`=1.1 |
| array row stretch | main.tex:82 | `tbl.tabular` | `\arraystretch`=1.25 (array parameter, applies to the entry tables) |
| colours | main.tex:59, 76-78 | `color.xcolor` | options usenames,dvipsnames; mediumgray gray 0.5; lightgray gray 0.9; mediumblue HTML 2060c2 |
| section heading look | main.tex:60, 85-94 | `head.titlesec` | `\titleformat{\section}{\normalfont\Large\mdseries}{}{0pt}{}[\titlerule]`; `\titlespacing*{\section}{0pt}{0.1cm}{0cm}` |
| section numbers hidden | main.tex:87, 96-98 | `head.titlesec` | empty label argument `{}` in `\titleformat` already prints no number; the `\@seccntformat` line is a second, redundant way to the same end (see Bespoke code) |
| section commands | main.tex:187, 201, 216, 225, 238 | `head.kernel` | `\section{...}` x5, unnumbered by the empty label |
| list defaults | main.tex:58, 83 | `list.enumitem` | `\setlist{nosep}`; no list in the body |
| entry tables | main.tex:52, 101-114, 189-198, 203-213, 218-222, 227-235, 240-250 | `tbl.tabularx` | `tabularx` at `\textwidth`; colspec `@{}p{0.10\textwidth}@{\hspace{0.02\textwidth}}p{0.88\textwidth}@{}` (date range, main.tex:103) and `@{}p{0.05\textwidth}@{\hspace{0.01\textwidth}}p{0.94\textwidth}@{}` (year, main.tex:110); date in column 1, entry in column 2, `&` and `\\` |
| tabularx that breaks pages | main.tex:53 | `tbl.longtable` | `ltablex` (CTAN, combines `tabularx` and `longtable`; same type as `xltabular` on that line), no options |
| table padding | main.tex:100, 102, 106 | `sp.manual-space` | `\vspace{-0.2cm}` above and below each table |
| header block (name, title, contacts, address) | main.tex:156-183 | `cols.minipage` | two pairs of `minipage[t]{0.5\textwidth}` side by side; right halves in `flushright` |
| right-aligned text | main.tex:160, 176 | `sp.ragged` | `flushright` environment |
| header spacing | main.tex:164, 184, 126 | `sp.manual-space` | `\\[-0.1cm]`; `\vspace{0.3cm}`; `\hspace{3pt}|\hspace{3pt}` |
| header rule | main.tex:165 | `sp.rule` | `\textcolor{lightgray}{\rule{\textwidth}{3pt}}` (a kernel rule, not artwork) |
| rule colour, footer text colour | main.tex:127, 165 | `color.xcolor` | `\textcolor{lightgray}`; `\color{mediumgray}` |
| running footer | main.tex:61, 128-143 | `hf.fancyhdr` | `\pagestyle{fancy}`; `\fancyhf{}`; `\lfoot` = name, separator, title (130-135); `\rfoot` = date, separator, page (136-141); `\headrulewidth`=0pt; `\footrulewidth`=1pt |
| page X of Y | main.tex:57, 140 | `pgnum.lastpage` | `lastpage`; `\thepage\space of\space \pageref*{LastPage}` |
| starred page reference | main.tex:140 | `xref.hyperref` | `\pageref*` (hyperref's no-link form; same package family as `\autoref`) |
| "last updated" date | main.tex:55, 124, 138 | `front.datetime` | `datetime`; `\newdateformat{monthyear}{\monthname[\THEMONTH], \THEYEAR}`; printed `\monthyear\today{}` |
| links and PDF metadata | main.tex:62, 145-151 | `meta.hyperref` | colorlinks=true; allcolors=mediumblue; breaklinks=true; pdftitle; pdfauthor |
| link commands in body | main.tex:120-122, 167-173 | `meta.hyperref` | `\href{https://doi.org/#1}{#1}`, `\href{mailto:..}`, `\href{https://orcid.org/..}` (hyperref command, same way as its options) |
| emphasis marks | main.tex:116, 191, 205 | `mark.kernel` | `\textbf`, `\textit`, `\texttt` |
| underlined author name | main.tex:25 | `mark.ulem` | kernel `\underline{...}` (no `ulem` loaded; the way's type is the underline of a span, the command is kernel) |
| publications | main.tex:240-250 | `tbl.tabularx` | hand-set rows in the same year table; no bibliography machinery (`bib.*` not used); entries are content |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\UCT` `\WITS` `\STELL` `\GEOL` | main.tex:14-17 | yes | text aliases; expand inline (content) |
| `\Title` `\FirstName` `\LastName` `\Initials` `\MyName` `\Email` `\PersonalWebsite` `\LabWebsite` `\ORCID` `\GitHubProfile` | main.tex:20-30 | yes | string aliases; expand inline (content) |
| `\Me` and coauthor names `\Thabo` `\Anja` `\Kagiso` | main.tex:25, 33-35 | yes | strings; `\Me` is `\underline{...}` = `mark.ulem` (kernel `\underline`) |
| `\TablePad` | main.tex:100 | yes | `sp.manual-space` `\vspace{-0.2cm}` inline |
| `EntriesTableDuration`, `EntriesTableYear` (`\NewEnviron`, `\BODY`) | main.tex:101-114 | yes | at each use write `\vspace{-0.2cm}`, `\begin{tabularx}{\textwidth}{<colspec>}`, the rows, `\end{tabularx}`, `\vspace{-0.2cm}` (`tbl.tabularx` + `sp.manual-space`); `environ` only collects the body for `tabularx`, no layout logic of its own; considered: `environ` (not proposed, a macro-definition helper that expands away, as `sp.xspace` in the v4 rejection) |
| `\Duration`, `\Year`, `\Ongoing` | main.tex:116-118 | yes | `font.size-commands` `\fontsize{10pt}{0}\selectfont` + `mark.kernel` `\texttt{..}`; `\Ongoing` is the string `on` |
| `\DOI`, `\Website`, `\GitHub` | main.tex:120-122 | yes | inline `\href` (`meta.hyperref`) and `\faGithub` (`font.icons`) |
| `\Separator`, `\FooterFont` | main.tex:126-127 | yes | `sp.manual-space` `\hspace{3pt}|\hspace{3pt}`; `font.size-commands` `\footnotesize` + `color.xcolor` `\color{mediumgray}` |
| `\renewcommand{\@seccntformat}[1]{}` | main.tex:96-98 | yes | one-line kernel format hook that prints no section number; redundant with the empty label in `\titleformat` (main.tex:87); the same effect is `num.secnumdepth` or `head.kernel` `\renewcommand` of the number format; no conditionals, no counters |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered and not proposed: `environ` (a macro-definition helper, reduces by inline expansion); `anyfontsize` (placed in `font.exscale`, same type as `fix-cm`); `ltablex` (placed in `tbl.longtable`, same type as `xltabular`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
