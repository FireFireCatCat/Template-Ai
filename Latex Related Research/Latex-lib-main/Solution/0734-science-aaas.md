yes

# 0734-science-aaas: Science (AAAS) LaTeX template v1.1

- Unverified: read from the source, not compiled.
- Source: Source/0734-science-aaas/ (origin: https://www.science.org/cms/asset/b7828fbf-d59a-4277-b199-753782283f9e/science_template_v1.1.zip; licence: not established; readme.txt:4 gives AAAS copyright, readme.txt:6 a rename-on-modify rule)
- Kind: journal
- Lib: v5
- Engine: pdfLaTeX-compatible (newtxtext/newtxmath, graphicx, geometry; no fontspec, no shell escape)
- Look carried by: mixed (kernel `article` at 12pt plus the sample's own preamble, science_template.tex:14-57; the citation look is in the publisher-kit style `scicite.sty`; the reference format is in the publisher-kit `sciencemag.bst`)
- Class origin: tex-distribution-unbundled
- Main file: science_template.tex (other samples: none)
- Read: main yes (1-511), zip-local classes and styles all (no `.cls` in the zip; `scicite.sty` 1-512 read in full; `sciencemag.bst` 1-200, 1280-1334 read plus a grep outline of the rest; `science_template.bib` 1-64 read)

## Verdict
yes. The sample is kernel `article` at 12pt with a short preamble that loads published packages (`newtxtext`/`newtxmath`, `graphicx`, `geometry`, `url`) and sets kernel hooks and strings. Every bespoke item (the `abstract` redefinition, `\fnum@figure`/`\fnum@table`, `\def\scititle`, the never-called `\pcc`, the counter resets) is an alias, a string or a counter setting that reduces to lib ways. The one zip-local style, `scicite.sty`, is a Science-edited copy of Arseneau's `cite.sty` shipped in the publisher's own kit; it is loaded with no options, so it is `bib.cite-pkg` with the package as the parameter. ctan.org/pkg/scicite returned 404, so its W1 rests on the official-kit ruling of the rubric: this is the weakest point of the `yes`. No ART, no EXTERNAL (BibTeX is the ordinary toolchain), no UNMAPPED.

## Blockers
none

## Class setting
- Class: `class.article` options: `12pt` (science_template.tex:14); the class is not in the zip (ships with the TeX distribution, source not read)
- Class-native vocabulary used: `\title` `\author` with `\and` `\date` `\maketitle` (science_template.tex:85, 89-104, 41, 113); `abstract` environment (redefined at 36-38, used at 119-129); `\refname` (44); `\fnum@figure` `\fnum@table` (48-49); `\thefigure` `\thetable` `\theequation` `\thepage` (361-364); starred `\section*` `\subsection*` `\subsubsection*` `\paragraph*` (291, 196, 390, 296); environments `quotation`, `center`, `figure`, `table`, `tabular`, `equation`; `\clearpage` `\newpage`

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | science_template.tex:14 | `class.article` | 12pt |
| base font size | science_template.tex:14 | `page.class-options` | 12pt |
| page geometry | science_template.tex:27 | `page.geometry` | letterpaper, margin=1in |
| text and math font | science_template.tex:18 | `font.newtx` | newtxtext, newtxmath, no options (Times-like); lines 20-21 name `mathptmx` and `txfonts` as commented-out fallbacks (`font.mathptmx`, not used) |
| line spacing | science_template.tex:30 | `sp.linespread` | `\linespread{1.5}` (called "double spacing", captions included) |
| space after period | science_template.tex:33 | `sp.frenchspacing` | `\frenchspacing` |
| title | science_template.tex:81-85 | `front.maketitle` | `\title{\bfseries \boldmath \scititle}`; the title text sits in `\def\scititle` |
| title and abstract weight | science_template.tex:85, 119 | `mark.kernel` | `\bfseries`, `\boldmath` |
| no date | science_template.tex:41 | `front.maketitle` | `\date{}` |
| authors and affiliations | science_template.tex:89-104, 113 | `front.maketitle` | `\author{...}` with items separated by `\and` (comment at 94 forbids `\\`), hard-coded `$^{1\ast\dagger}$` marks, `\maketitle` at 113; no `\thanks`, no `\footnote` (comment at 88) |
| affiliation size | science_template.tex:96-103 | `font.size-commands` | `\small` on each institution and note line |
| abstract content | science_template.tex:36-38, 119-129 | `abs.kernel` | environment `abstract`, redefined to print no heading (see Bespoke code) |
| abstract shape | science_template.tex:37-38 | `quote.kernel` | `\quotation` / `\endquotation` as the abstract body |
| first paragraph unindented | science_template.tex:134, 185 | `sp.lengths` | `\noindent` (per-paragraph override of `\parindent`; closest home, a kernel paragraph-shape primitive) |
| headings (all unnumbered) | science_template.tex:196, 291, 344, 375, 390, 398, 406, 425, 432, 439 | `head.kernel` | starred `\subsection*` `\section*` `\subsubsection*`; kernel `article` look, no `\renewcommand` of the heading format |
| run-in headings | science_template.tex:296, 301, 304, 310, 489, 496 | `head.kernel` | `\paragraph*{...}` and `\paragraph{...}`; kernel look |
| reference-list heading string | science_template.tex:44 | `class.article` | class-native `\renewcommand\refname{References and Notes}`; `thebibliography` prints it as the section heading |
| figure and table label | science_template.tex:47-50 | `cap.kernel` | hooks `\fnum@figure` and `\fnum@table` set to `\textbf{Figure \thefigure}` and `\textbf{Table \thetable}` (bold by `mark.kernel`) |
| caption | science_template.tex:221, 235, 455, 467 | `cap.kernel` | `\caption{\textbf{short bold title.} text}`; below figures (221 after the image at 216), above tables (235 before the tabular at 240) |
| figure float | science_template.tex:214-227, 449-460 | `fig.graphicx` | `figure`, `\includegraphics[width=0.6\textwidth]{example_figure}`, default placement, `\label` |
| centring, supplement title block | science_template.tex:215, 233, 374-385 | `sp.ragged` | `\centering` in floats, `center` environment around the supplement title |
| table | science_template.tex:232-251, 464-482 | `tbl.tabular` | `tabular{lccc}` and `{lccr}`, `\hline` rules (242, 245, 249; 474, 476, 480), `\centering` |
| cross-references | science_template.tex:148, 171, 186, 226, 238 | `xref.kernel` | `\label` `\ref`; no `hyperref` |
| display equation | science_template.tex:180-183, 420-423 | `math.kernel` | `equation` environment with `\label`, `\frac` `\sqrt` `\pm` `\cos` |
| `\text` in maths | science_template.tex:176 | `math.amsmath` | `$T_\text{max}$`; the sample does not load amsmath, so the emitter loads it (newtxmath is presumed to bring it, not read) |
| manual breaks and thin spaces | science_template.tex:345-352, 375, 382-383, 391-399, 190-191 | `sp.manual-space` | `\\` line breaks, `\,` thin spaces, `~` ties |
| page breaks | science_template.tex:257, 356, 402, 487 | `pg.break` | `\clearpage` (flush floats), `\newpage` |
| supplement numbering | science_template.tex:361-367 | `num.counters` | `\renewcommand{\thefigure}{S\arabic{figure}}`, same for `table` and `equation`; `\setcounter{...}{0}` |
| supplement page numbers | science_template.tex:364, 368 | `pgnum.pagenumbering` | `\setcounter{page}{1}`; the `S` prefix is `\renewcommand{\thepage}` (`num.counters`) |
| last reference number | science_template.tex:349 | `num.counters` | `\arabic{enumiv}` prints the kernel counter of `thebibliography` in prose |
| header and footer | science_template.tex (no `\pagestyle`) | `class.article` | not set by the sample; article default page style `plain` applies |
| numeric citations | science_template.tex:54, 158-162 | `bib.cite-pkg` | `\usepackage{scicite}` with no options; the package is the parameter (see Bespoke code) |
| bibliography via BibTeX | science_template.tex:262-263 | `bib.bibtex-bst` | `\bibliography{science_template}`, `\bibliographystyle{sciencemag}` |
| bibliography as pasted `.bbl` | science_template.tex:272-286 | `bib.thebibliography` | commented-out alternative the template asks for after review: `thebibliography` with `\bibitem` |
| URLs and DOIs | science_template.tex:57 | `meta.url` | `\usepackage{url}`, no options (the `.bst` writes `\url{...}` and `\doi{...}`, sciencemag.bst:481, 563) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewenvironment{abstract}{\quotation}{\endquotation}` | science_template.tex:36-38 | yes | alias of the kernel `quotation` environment (`quote.kernel`), so the abstract prints with no heading; the emitter writes this preamble line or `\begin{quotation}\bfseries\boldmath ... \end{quotation}` around the abstract node (`abs.kernel`, `mark.kernel`) |
| `\fnum@figure` and `\fnum@table` redefinition inside `\makeatletter` | science_template.tex:47-50 | yes | the kernel caption-label hooks set to a bold label string: `cap.kernel` + `mark.kernel`; the published `caption` package with `labelfont=bf` is an alternative route, not claimed identical (separator weight may differ) |
| `\renewcommand\refname{...}` | science_template.tex:44 | yes | one string of the class (`class.article`), no logic |
| `\newcommand{\pcc}{\,cm$^{-3}$}` | science_template.tex:66 | yes | alias of a thin space and a superscript (`sp.manual-space`); never called in the sample (grep: only line 66) |
| `\def\scititle{...}` | science_template.tex:81-83, used at 85 and 375 | yes | plain text macro with no logic; inline expansion of the title text at both uses (content) |
| `\renewcommand{\thefigure}` `\thetable` `\theequation` `\thepage` and `\setcounter` | science_template.tex:361-368 | yes | `num.counters` and `pgnum.pagenumbering`, no conditional |
| `scicite.sty` (v4.01 `cite.sty` of Arseneau, edited for Science) | scicite.sty:1-328 | yes, as a published package | publisher's own kit (readme.txt:19, origin science.org); loaded without options (science_template.tex:54), so the emitter prints `\usepackage{scicite}` and ships the file: `bib.cite-pkg`, package scicite. W1: official kit, not on CTAN (ctan.org/pkg/scicite returned 404). W2: behaviour chosen by options (scicite.sty:269-291) and strings `\citeleft` `\citeright` `\citeform` `\citepunct` (41-60). W3: any Science-family paper. W4: one preamble line. Science's edits: `(` `)` list delimiters (41, 44), bibliography label `#1.` (47), italic numbers inside roman parentheses through `\@cite` (166-172). The sort and range code (83-155) is Arseneau's `cite` algorithm, which `bib.cite-pkg` names, not logic the emitter copies. If the kit ruling were refused, the fallback is published `cite` with `\citeleft` `\citeright` `\citeform` set (scicite.sty:434-459 lists them), close but not identical (the italic note and `\@biblabel` need extra lines) |
| `sciencemag.bst` | sciencemag.bst:1-1334 | yes | generated by custom-bib (sciencemag.bst:9-16, readme.txt:17; LPPL notice at 26-29) with three manual tweaks (1-4); a `.bst` is the parameter of `bib.bibtex-bst`; entries are written as `\bibitem` in `thebibliography` (590-592, 1308-1330); no `SORT` command, so citation order |

## Content-opaque
none (the image `example_figure` at science_template.tex:216 and 451 is figure artwork held by `fig.graphicx`; the zip ships `.png`, `.eps` and `.ps` versions, so no asset is missing)

## Lib changes
- New ways proposed: none
- considered: `scicite` as its own bibliography way; decided against, `bib.cite-pkg` already says the package is the parameter for load-only citation-run packages
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- No text addressed to an AI found. science_template.tex:4-5, 9-11 and readme.txt:6 are rules for authors (rename a modified file, keep the preamble in the `.tex`); they were not acted on.
- The sample's comments forbid extra packages (science_template.tex:71-73), so the template has no `hyperref`, `amsmath`, `caption` or `babel` of its own.
- science_template.pdf (compiled by the publisher) was not read: no PDF renderer in this environment.
