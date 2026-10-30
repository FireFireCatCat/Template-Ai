yes

# 0397-austrian-journal-of-statistics: Austrian Journal of Statistics (article starter)

- Unverified: read from the source, not compiled.
- Source: Source/0397-austrian-journal-of-statistics/ (origin: https://latextemplates.com/downloads/austrian-journal-statistics.zip; licence: CC-BY-4.0; ATTRIBUTION.txt:1-4 credits Austrian Statistical Society / Matthias Templ and names an Overleaf page as the upstream)
- Kind: journal
- Lib: v4
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (kernel `article` plus seven published packages loaded and set in `main.tex:2-7`; the zip holds no `.cls`, `.sty`, `.def` or `.cfg`)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
A 73-line `main.tex` on kernel `article` (11pt, a4paper) with `geometry`, `amsmath`, `booktabs`, `tabularx`, `xcolor`, `hyperref`, `microtype`, two `\setlength` calls and `\hypersetup` (main.tex:2-7). It defines no macro, environment, counter or conditional (grep for `newcommand`, `renewcommand`, `\def`, `\let`, `newenvironment`, `newcounter`, `RequirePackage`, `\input`, `shell` found none), uses no drawing, and needs no tool outside TeX. Every component maps to a lib way with declarative parameters, so the verdict is `yes`. This is a neutral AJS-style starter (README.md:3-6 says it leaves out the publisher logo). It is not the journal's own class, so it says nothing about the real AJS kit.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (main.tex:2). Source of the class not read (ships with the TeX distribution).
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (main.tex:8-12), `abstract` environment (main.tex:13-18), `\section` `\section*` (main.tex:21, 62), `thebibliography` with `\bibitem` (main.tex:68-72).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:2 | `class.article` | `11pt`, `a4paper` |
| paper and size | main.tex:2 | `page.class-options` | `a4paper`, `11pt` |
| page geometry | main.tex:3 | `page.geometry` | `margin=2.25cm` (all four sides) |
| paragraph shape | main.tex:6-7 | `sp.lengths` | `\parindent`=0pt, `\parskip`=0.55em |
| microtypography | main.tex:4 | `sp.microtype` | `microtype` loaded, no options |
| fonts | (none) | none set | default Computer Modern, no font package or `\familydefault` in the file |
| colour | main.tex:4, 5 | `color.xcolor` | `xcolor` loaded; colour expression `blue!50!black` used as link colour |
| hyperlinks | main.tex:4, 5 | `meta.hyperref` | `colorlinks=true`, `urlcolor=blue!50!black`, `linkcolor=blue!50!black`, `citecolor=blue!50!black` |
| title, author | main.tex:8-9, 12 | `front.maketitle` | `\title{...}`, `\author{name\\\small affiliation\\\small university}`, `\maketitle` |
| author-block lines and sizes | main.tex:9 | `sp.manual-space`, `font.size-commands` | `\\` line breaks; `\small` on the two affiliation lines |
| date line | main.tex:10 | `front.maketitle` | `\date{Austrian Journal of Statistics --- Volume 55, Issue 1 (2026)}`, a string in place of `\today` |
| abstract | main.tex:13-18 | `abs.kernel` | kernel `abstract` environment, no package |
| keywords line | main.tex:19 | `abs.keywords`, `mark.kernel` | `\textbf{Keywords:}` followed by a `;`-separated list (the `\par\textbf{Keywords}` form the lib names) |
| section headings | main.tex:21, 26, 35, 53, 58 | `head.kernel` | `\section{...}`, article defaults, numbered |
| unnumbered heading | main.tex:62 | `head.kernel` | `\section*{Address}` |
| address block | main.tex:63-66 | `sp.manual-space`, `mark.kernel` | `\\` line breaks; `\texttt{...}` for the e-mail |
| equation | main.tex:29-31 | `math.kernel` | kernel `equation` (numbered) with `\widehat`, `\frac`, `\qquad`, `\leq` |
| math package | main.tex:4 | `math.amsmath` | `amsmath` loaded, no options; nothing amsmath-specific is called in the body |
| table float | main.tex:38-39, 51 | `tbl.tabular`, `sp.ragged` | kernel `table[ht]` float, `\centering` |
| table body | main.tex:42-50 | `tbl.tabularx` | `tabularx{0.78\linewidth}{@{}lrrX@{}}`; `X` column in last position |
| table rules | main.tex:43, 45, 49 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` (no `\cmidrule`) |
| table caption | main.tex:40 | `cap.kernel` | `\caption{...}` placed above the tabular, no `caption` package |
| cross-references | main.tex:36, 41 | `xref.kernel` | `\label{tab:estimate}`, `Table~\ref{tab:estimate}` |
| bibliography | main.tex:68-72 | `bib.thebibliography` | `thebibliography{9}` with one `\bibitem{efron}` and `\emph` for the title; no citation in the text, no `natbib` |
| emphasis | main.tex:70 | `mark.kernel` | `\emph{...}` |
| header and footer | (none) | none set | no `\pagestyle`, `fancyhdr` or `\thispagestyle`; article default `plain` style applies |
| language, lists, theorems, footnotes, code, boxes, contents, index | (none) | not used | no `babel`, `itemize`, `\newtheorem`, `\footnote`, listings, `\tableofcontents`, `\printindex` in the file |

## Bespoke code
none. The two `\setlength` calls (main.tex:6-7) are `sp.lengths`; `\hypersetup` (main.tex:5) is `meta.hyperref`; `\date{...}` (main.tex:10) is a plain string. No `\newcommand`, `\def`, environment, counter or conditional exists in any file of the zip (`main.tex` is the only `.tex`; the other two files are `README.md` and `ATTRIBUTION.txt`).

## Content-opaque
none (the three-row table at main.tex:42-50 and the inline maths are ordinary content; there is no figure, TikZ picture or included image)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- README.md:1-12 and ATTRIBUTION.txt:1-10 are plain documentation; no text addressed to an AI was found, nothing to ignore.
- The zip holds no journal class: it carries only `main.tex` on kernel `article` (README.md:3-6 calls it a self-contained starter). The look is the kernel `article` look plus the preamble above, so this is evidence about the preamble ways only; `Look carried by` is `preamble`, not `class`. Whether the journal's own kit (the Overleaf page named at ATTRIBUTION.txt:4) ships a class was not checked.
- The seven packages are loaded in one `\usepackage` list (main.tex:4) in the order `amsmath, booktabs, tabularx, xcolor, hyperref, microtype`; an emitter can keep that order.
