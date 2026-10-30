yes

# 0297-marcelomijas-econometrics-cheatsheet: Econometrics Cheat Sheet Project (three A4 landscape, three-column cheat sheets, en and es)

- Unverified: read from the source, not compiled.
- Source: Source/0297-marcelomijas-econometrics-cheatsheet/ (origin: https://codeload.github.com/marcelomijas/econometrics-cheatsheet/zip/refs/heads/main; licence: CC-BY-4.0, LICENSE:1 and the pdfsubject at time-series-cheatsheet/time-series-cheatsheet-es.tex:20)
- Kind: misc (a dense reference cheat sheet, not one of the listed kinds; manifest hint `misc`)
- Lib: v4
- Engine: pdfLaTeX-compatible (no fontspec, unicode-math, luacode or polyglossia in any of the six samples)
- Look carried by: preamble (kernel `article` plus published packages set in the sample's own preamble; the zip ships no `.cls`, `.sty`, `.def`, `.cfg` or `.clo`)
- Class origin: tex-distribution-unbundled
- Main file: time-series-cheatsheet/time-series-cheatsheet-es.tex (other samples: time-series-cheatsheet/time-series-cheatsheet-en.tex, econometrics-cheatsheet/econometrics-cheatsheet-en.tex and -es.tex, additional-cheatsheet/additional-cheatsheet-en.tex and -es.tex)
- Read: main yes (lines 1-736), zip-local classes and styles none present

Note: the zip also holds six prebuilt `.pdf` files and README.md. They are not template source. README.md is prose and contains no text addressed to an AI.

## Verdict
Every in-scope component is a published package or kernel command with declarative parameters: `article` at `10pt, a4paper, landscape`, `geometry` margin 1cm, `multicol` with 3 columns, `fancyhdr` with one centred footer, `titlesec` spacing only, `enumitem`, `amsmath`, `hyperref` metadata. The zip has no zip-local class or style and no hand-written control code (grep over all six `.tex` for `\def`, `\let`, `\if`, `\newif`, `\newcounter`, `\newenvironment`, `\input`, `\catcode` finds nothing). The only definitions are `\DeclareMathOperator` and `\newcommand` aliases, which reduce by inline expansion. The seven TikZ drawings in the main sample are statistical illustrations of the text (data plots, a correlogram, a Durbin-Watson decision strip), not a banner, frame or other part of the template's identity, so they are Content-opaque, not `ART`. That reading is the one judgement call in this verdict. Result: `yes`.

## Blockers
none

## Class setting
- Class: `class.article` options: `10pt`, `a4paper`, `landscape` (time-series-cheatsheet/time-series-cheatsheet-es.tex:3)
- Class-native vocabulary used: starred sectioning `\section*` (:64, :113, :158, :249, :502, :512, :535, :555, :588, :695, :716) and `\subsection*` (16 uses, first :66); `center`, `itemize`, `enumerate`, `tabular`, `minipage` environments; `\begin{document}` at :52. No `\maketitle`, no `abstract`, no numbered headings. `\subsubsection*` is used only in the econometrics and additional samples; the main sample sets its spacing (:43) but never calls it.

## Component map
All paths are relative to Source/0297-marcelomijas-econometrics-cheatsheet/. `TS` = time-series-cheatsheet/time-series-cheatsheet-es.tex, `EC` = econometrics-cheatsheet/econometrics-cheatsheet-en.tex, `AD` = additional-cheatsheet/additional-cheatsheet-en.tex.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | TS:3 | `class.article` | see Class setting |
| paper, orientation, size | TS:3 | `page.class-options` | `a4paper`, `landscape`, `10pt` |
| page geometry | TS:9, TS:37 | `page.geometry` | `\geometry{margin=1cm}` (all four margins) |
| footer distance | TS:49 | `page.setlength` | `\setlength{\footskip}{12pt}` (a raw page-layout length; the footer itself is the `hf.fancyhdr` row) |
| columns | TS:12, TS:54, TS:734; `\columnbreak` at TS:111, 154, 247, 358, 468, 533, 586, 683 | `cols.multicol` | `\begin{multicols}{3}` around the whole body; hand-placed column breaks. AD:481-482 and AD:622 also use `multicols{2}` after `\setlength{\multicolsep}{6pt}` |
| header and footer | TS:8, TS:46-48 | `hf.fancyhdr` | `\pagestyle{fancy}`; `\renewcommand{\headrulewidth}{0pt}`; `\cfoot{...}` is the only field set, the others stay at fancyhdr defaults |
| footer content | TS:48 | `xref.hyperref`, `font.size-commands`, `mark.kernel` | `\href{<github url>}{\normalfont \footnotesize <string>}`: a link around a version code, URL and licence string |
| page numbers | TS:38 | `pgnum.pagenumbering` | `\pagenumbering{gobble}` (page numbers suppressed; the TS:38 comment says "remove page numeration") |
| paragraph spacing | TS:13, TS:39 | `sp.parskip-pkg`, `sp.lengths` | `parskip` loaded, then `\setlength{\parskip}{0cm}` overrides it (paragraph indent stays 0) |
| heading spacing | TS:15, TS:41-43 | `head.titlesec` | no `\titleformat`; `\titlespacing{\section}{0pt}{2ex}{1ex}`, `{\subsection}{0pt}{1ex}{0ex}`, `{\subsubsection}{0pt}{0.5ex}{0ex}` (left, before, after) |
| heading commands | TS:64, TS:66 | `head.kernel` | starred `\section*` and `\subsection*`, so no numbers and no ToC entries; the heading look is the unchanged article default |
| title block | TS:56-62 | `sp.ragged`, `font.size-commands`, `mark.kernel`, `xref.hyperref` | hand-laid in a `center` environment at the top of column 1: `\textbf{\LARGE \href{url}{title}}`, then two `{\footnotesize ...}` lines (author and institution, project name); `\href` is a link, no `\maketitle` |
| PDF metadata | TS:11, TS:18-24 | `meta.hyperref` | `\hypersetup{pdftitle, pdfsubject, pdfauthor, pdfkeywords, pdfduplex={DuplexFlipShortEdge}}`; no link colouring options |
| lists | TS:7, TS:72, TS:119-137, TS:234, TS:705 | `list.kernel`, `list.enumitem` | `itemize`/`enumerate` with `[leftmargin=*]`; `label=t\arabic{*}.` (TS:119) and `label=\alph{*}.` (TS:121, 131, 234) |
| side-by-side blocks | TS:188-192, TS:270-310, TS:544-550, TS:630-645 | `cols.minipage`, `sp.manual-space` | two or three `minipage` of `0.48`, `0.31` or `0.45` of `\columnwidth` joined by `\hfill`; at TS:544-550 and EC:92-100 the minipages sit inside an `itemize` or `enumerate` and hold the `\item` lines (kernel markup, no custom code) |
| manual vertical space | TS:224, TS:676 | `sp.manual-space` | `\vspace*{0.1cm}` (AD:799 `0.2cm`) |
| centred display | `center` x33, e.g. TS:93-95, TS:253-255 | `sp.ragged` | each displayed formula is inline math `\( ... \)` inside a `center` environment; there is no numbered `equation` |
| mathematics | TS:6, TS:30-34, TS:146 | `math.amsmath` | `amsmath`; `\DeclareMathOperator` for `\E \Var \se \Cov \Corr`; also `\operatorname` (TS:146), `\underset` (TS:148), `\dfrac` (TS:384), `\text`, `\lvert`, `\lbrace`. AD:7 also loads `amssymb` for `\mathbb` (AD:359, 530) |
| maths alias | AD:41-45 | `math.amsmath` | the `\newcommand` aliases are in the Bespoke table |
| emphasis marks | TS:68, TS:75, TS:354, TS:571 | `mark.kernel` | `\textbf`, `\textit`, `\textsl`, `\underline` (kernel, no ulem) |
| colour | TS:150, TS:226, TS:640 | `color.xcolor` | named colours only: `\textcolor{blue}{BLUE}`, `{\color{red} ...}`; no colour package line in the preamble, so the names rely on the `xcolor` that `tikz` loads (not read; an emitter writes `\usepackage{xcolor}`). `lightgray` and `red` are also used inside the TikZ code |
| table | TS:614-622 | `tbl.tabular` | `tabular` `{ c c c }` with one `\hline`, inside `center`; no float, no caption, no `booktabs`. EC:253-261 and AD:380-381 wrap the `tabular` in `\scalebox{0.85}`/`{0.90}` (see next row) |
| scaled tables and matrices | EC:253, AD:114, AD:380, AD:655, AD:772 | `fig.graphicx` | `\scalebox{0.80..0.95}{...}` around a `tabular` or a `bmatrix` formula; `graphicx` is loaded at TS:10 |
| inline figures | TS:193, 271, 281, 291, 313, 402, 646 | `art.tikz` | `tikzpicture` at `scale` 0.11 to 0.30 inside `minipage` or `center`; no `figure` float, no caption, no `\includegraphics` anywhere in the zip. Content-opaque, see below |
| language | TS:1 | none | the first line is an editor spellcheck comment (`es_ES`), not a package; no `babel`, no `polyglossia`, no `inputenc`; Spanish accents are written as UTF-8 |
| fonts | whole file | none | no font package or `\familydefault`: the Computer Modern default carries the text |
| not present | whole zip | none | no abstract, ToC, numbering depth, theorem, float, caption, footnote, margin note, code, box, bibliography, index, cross-reference or `\maketitle` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\DeclareMathOperator{\E}{E}`, `\Var`, `\se`, `\Cov`, `\Corr` | TS:30-34 | yes | published `amsmath` command; the macro is `\operatorname{E}` and so on, so expand each use inline (`math.amsmath`); the Spanish file only changes the text of `\se` to `ee` (TS:32) |
| `\DeclareMathOperator{\resid}`, `\diag`, `\rk`, `\Cr`, `\AIC`, `\HQ`, `\BIC` | EC:35-36; AD:36-40 | yes | same: `\operatorname{...}` inline |
| `\newcommand{\SSR}{\text{SSR}}`, `\SSE`, `\SST`, `\trend`, `\const` | EC:37-39; AD:41-45 | yes | plain aliases of `\text{...}` (with a subscript for `\trend`): expand inline (`math.amsmath` `\text`); the `-es` files only change the strings (SRC, SEC, STC, Tend) |
| `\pgfmathsetseed{12}` | TS:27 (AD:28 uses `10`) | yes, as content | a pgf random seed for the `rnd` calls inside the TikZ plots (TS:275, 285, 295); it carries no layout and belongs to the Content-opaque drawings |
| none other | whole zip | n/a | no zip-local `.cls`, `.sty`, environment, counter, conditional, `\def` or `\let` |

## Content-opaque
- Seven `tikzpicture` illustrations in the main sample (TS:193-221 seasonal series with a dashed adjusted line, TS:271-297 three residual scatter plots using `rnd`, TS:313-350 ACF and PACF bars with a grey band and a `\rotatebox{90}` axis label at TS:315 and TS:333, TS:402-427 Durbin-Watson regions, TS:646-673 level and first-difference series). The other samples carry more of the same type: the econometrics sheet has 9 (EC:172, 207, 322, 340, 558, 568, 619, 629, 639), the additional sheet 2 (AD:490, AD:595), and the English time-series sheet 7. They sit in `minipage` or `center`, not in a float, and depict the statistics being explained. None draws a banner, page frame, sidebar or other template identity, so none is `ART`. Under a stricter reading that counts any TikZ in the body as template artwork the verdict would be `no`.
- Mathematical formulas, the `bmatrix` systems in AD (24 matrices), and all cell text are content.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
