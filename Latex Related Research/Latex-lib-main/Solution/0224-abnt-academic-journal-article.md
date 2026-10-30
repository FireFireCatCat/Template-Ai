yes

# 0224-abnt-academic-journal-article: ABNT Academic Journal Article

- Unverified: read from the source, not compiled.
- Source: Source/0224-abnt-academic-journal-article/ (origin: https://latextemplates.com/downloads/abnt-journal-article.zip, itself based on https://www.overleaf.com/latex/templates/modelo-latex-abnt-para-revistas-academicas-e-cientificas/gbtdpmrdwnrx; licence: CC-BY-4.0, author credit Lucas Rodrigues Costa, ATTRIBUTION.txt:1-5)
- Kind: journal
- Lib: v2
- Engine: pdfLaTeX-compatible (README.md:16 says "Compile with PDFLaTeX"; `fontenc` T1 and `inputenc` utf8 only, main.tex:2-3)
- Look carried by: preamble (published `article` plus nine published packages and four setting lines, main.tex:1-9; the title block is hand-laid in the body, main.tex:15-23)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The whole zip is one 94-line `main.tex` on the kernel `article` class. It loads only published packages (`fontenc`, `inputenc`, `babel`, `amsmath`, `booktabs`, `geometry`, `setspace`, `array`, `hyperref`) and defines no macro, environment, counter or conditional of its own (a grep for `\newcommand`, `\def`, `\let`, `\newenvironment`, `\newcounter`, `\makeatletter`, `\input` found nothing). There is no artwork. Every part of the look reduces to existing lib ways with parameters. Caveat: the README says the gallery's `abakos` package and institutional artwork are deliberately not bundled (README.md:6-8), so the original Overleaf look is not in the zip and is not analysed; this verdict covers the starter as shipped.

## Blockers
none

## Class setting
- Class: `class.article` options: `12pt`, `a4paper` (main.tex:1)
- Class-native vocabulary used: `abstract` environment (main.tex:25, 34), `\section` and `\section*` (main.tex:43, 88), `quote` (main.tex:59), `table`/`tabular` with `\caption` (main.tex:67-80), `enumerate` (main.tex:89), `\title` `\author` `\date` with `\thanks` and `\and` (main.tex:10-12). `\maketitle` is never called.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 12pt, a4paper |
| paper and size | main.tex:1 | `page.class-options` | a4paper, 12pt |
| page geometry | main.tex:6 | `page.geometry` | top=3cm, bottom=2cm, left=3cm, right=2cm (ABNT margins) |
| line spacing | main.tex:7 | `sp.setspace` | `\onehalfspacing` |
| paragraph indent | main.tex:8 | `sp.lengths` | `\parindent`=1.25cm |
| encodings | main.tex:2-3 | `font.fontenc-t1` | fontenc T1, inputenc utf8 |
| language | main.tex:4, 33, 41 | `lang.babel` | options brazilian,english (last option is babel's main language, so the document starts in English; reading, not compiled); `\selectlanguage{english}` at line 33, `\selectlanguage{brazilian}` at line 41 |
| links | main.tex:5, 9 | `meta.hyperref` | colorlinks=true, linkcolor=black, urlcolor=blue, citecolor=black (no `\url` or `\cite` in the sample) |
| title, author, date declarations | main.tex:10-12 | `front.maketitle` | `\title`, `\author` with `\and`, `\date{}` empty; declared but never printed (no `\maketitle`) |
| author footnote | main.tex:11 | `front.thanks` | `\thanks{e-mail}` inside `\author`; never printed for the same reason |
| hand-laid title block, alignment | main.tex:15-21 | `sp.ragged` | kernel `center` environment (same family as `\centering`) |
| hand-laid title block, sizes | main.tex:16, 18 | `font.size-commands` | `\large`, `\Large` |
| hand-laid title block, weight and case | main.tex:16, 18 | `mark.kernel` | `\bfseries`, `\MakeUppercase` (the case command is the one borderline fit; the alternative is to write the title in capitals as content) |
| title block, spacing and breaks | main.tex:17, 19, 20, 23 | `sp.manual-space` | `\vspace{6pt}`, `\quad`, `\\` |
| author and affiliation superscripts | main.tex:20, 22-23 | `mark.kernel` | `\textsuperscript{1}`, `\textsuperscript{2}` |
| affiliation block, no indent | main.tex:22 | `sp.lengths` | `\noindent` (the per-paragraph switch for `\parindent`) |
| abstract, Portuguese | main.tex:25-30 | `abs.kernel` | `abstract` environment |
| abstract, English | main.tex:34-39 | `abs.kernel` | second `abstract` environment after `\selectlanguage{english}` |
| keyword lines | main.tex:31, 40 | `abs.keywords` | `\noindent\textbf{Palavras-chave:}` and `\noindent\textbf{Keywords:}`, items separated by `;` |
| headings | main.tex:43, 49, 64, 82 | `head.kernel` | numbered `\section`, kernel look unchanged |
| unnumbered heading | main.tex:88 | `head.kernel` | `\section*{Referências}` |
| display equation | main.tex:51-54 | `math.amsmath` | `equation` with `\label{eq:normalization}`; inline maths at lines 50, 55 |
| equation reference | main.tex:85 | `math.amsmath` | `\eqref{eq:normalization}` (amsmath command) |
| block quotation | main.tex:59-62 | `quote.kernel` | `quote` environment |
| table float | main.tex:67-80 | `tbl.tabular` | `table[ht]` float, `tabular` with `p{0.25\linewidth}p{0.27\linewidth}p{0.30\linewidth}` columns (`array`) |
| table centring | main.tex:68 | `sp.ragged` | `\centering` |
| table rules | main.tex:72, 74, 78 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| table caption | main.tex:69 | `cap.kernel` | `\caption` above the tabular, default style |
| labels and refs | main.tex:53, 65, 70 | `xref.kernel` | `\label{eq:...}`, `\label{tab:trace}`, `\ref{tab:trace}` |
| reference list | main.tex:88-93 | `list.kernel` | `enumerate` of two hand-typed entries, `\emph` titles, ``...'' quotes; no `thebibliography`, no `\cite`, no `.bib` |
| emphasis in references | main.tex:90, 92 | `mark.kernel` | `\emph` |

## Bespoke code
none. The preamble holds only `\usepackage`, `\geometry`, `\onehalfspacing`, `\setlength`, `\hypersetup`, `\title`, `\author`, `\date` (main.tex:1-12), all calls into published ways. The body defines nothing.

## Content-opaque
none (the equation at main.tex:51-54 is content held by `math.amsmath`; the table cells are content)

## Lib changes
- New ways proposed: none. Considered and not used: `bib.thebibliography` (the sample uses an `enumerate` list, not the `thebibliography` environment), `front.titlepage-env` (no `titlepage` environment is used, the block is a `center` environment), `xref.hyperref` (no `\autoref`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
