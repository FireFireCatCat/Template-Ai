yes

# 0458-cs-technical-lab-report: CS Technical Lab Report

- Unverified: read from the source, not compiled.
- Source: Source/0458-cs-technical-lab-report/ (origin: https://latextemplates.com/downloads/cs-technical-lab-report.zip; licence: LPPL-1.3c)
- Kind: report
- Lib: v4
- Engine: pdfLaTeX-compatible (inferred: the sample loads no `fontspec`, Lua or `polyglossia`; the class source was not read, so a load inside the class is not excluded)
- Look carried by: class (the zip holds only `main.tex` and `refs.bib`; every look is set by the published class `hebdomon`, loaded at main.tex:1, which adds no package and no macro of its own in the sample)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is two files: a sample that calls the published class `hebdomon` with one option and uses only that class's own commands (`\StudentName`, `\Chapter`, `\Section`) plus kernel and `listings` and `booktabs` constructs, and a `.bib` file. The class is on CTAN and in TeX Live and MiKTeX (one read of ctan.org/pkg/hebdomon: v0.1, 2024-08-08, LPPL 1.3c, McGuiness), so it is one `class.hebdomon` way and the zip contains no bespoke code and no artwork. Every component the sample uses has a lib way, so `yes`. Limit of this reading: the class file is not in the zip and was not read, so what the class loads unconditionally (an EXTERNAL package such as `minted` would be a blocker by the rubric's ruling) and the class's page, font and colour values are unchecked; the option name `lstlisting` at main.tex:1 points to `listings`, not `minted`, being the code package here.

## Blockers
none

## Class setting
- Class: `class.hebdomon` options: `lstlisting` (main.tex:1; selects the `listings` package for code, inferred from the option name and from `\begin{lstlisting}` at main.tex:51)
- Class-native vocabulary used: `\StudentName{}` (main.tex:5), `\Chapter{}` (main.tex:13, 30, 74, 100, 118), `\Section{}` (main.tex:21, 32, 49); the class's `\maketitle` (main.tex:10) and `\tableofcontents` (main.tex:11) as redefined by the class; biblatex commands `\addbibresource` (main.tex:2), `\parencite` (main.tex:26, 28, 108), `\printbibliography` (main.tex:125), supplied through the class (the sample loads no package, main.tex has no `\usepackage`). Capital `\Chapter` and `\Section` fit the CTAN page's statement that the class overwrites no TeX or LaTeX command; their typeset look is not visible in the zip.
- Class source: not read (published, unbundled; not in the zip, not installed here, and not fetchable under the three-read limit).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.hebdomon` | option `lstlisting`; no other option, no `\LoadClass` or local file |
| page geometry, fonts, header/footer, colour, spacing, heading and title looks | main.tex:1 (nothing set in the sample) | `class.hebdomon` | none set by the zip; all values are the class's own defaults (class source not read) |
| bibliography resource | main.tex:2; refs.bib:1-19 | `bib.biblatex-biber` | `\addbibresource{refs.bib}`; backend not stated in the zip (biblatex default is biber; the class may set it, not read); entries are content |
| title block | main.tex:4-6, 10 | `front.maketitle` | `\title{...}`, `\date{\today}`, `\maketitle` (the kernel names the sample uses) |
| title-page student field | main.tex:5 | `front.class-native` | `\StudentName{P. Novak}`; the title page the class prints from it is the class's |
| contents | main.tex:11 | `toc.kernel` | `\tableofcontents`, no options |
| headings | main.tex:13, 21 (and 30, 32, 49, 74, 100, 118) | `head.class-native` | `\Chapter{...}` and `\Section{...}`, two levels, no optional argument |
| inline emphasis | main.tex:19, 38, 40 | `mark.kernel` | `\emph{}`, `\textbf{}` |
| bulleted list | main.tex:37-43 | `list.kernel` | `itemize` with two `\item`, default label and spacing (any class styling not read) |
| inline maths | main.tex:45 | `math.kernel` | `$\times$` in text, no display equation, no `amsmath` call in the sample |
| code listing | main.tex:51-67 | `code.listings` | `lstlisting` with keys `language=Python`, `caption={CLOCK eviction core}`; loaded by the class option `lstlisting` (main.tex:1); listing style not set in the sample |
| table float | main.tex:76-88 | `tbl.tabular` | `table[h]` float and `tabular{lrr}`; the kernel table float is of the same kernel family as `tabular` |
| table caption | main.tex:78 | `cap.kernel` | `\caption{...}` above the tabular; caption look (if the class loads `caption`) not read |
| table rules | main.tex:80, 82, 86 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule`; the sample loads no package, so `booktabs` must come from the class (inferred, class not read) |
| table centring | main.tex:77 | `sp.ragged` | `\centering` inside the float |
| citations | main.tex:26, 28, 108 | `bib.biblatex-biber` | `\parencite{key}` (three uses, two keys) |
| bibliography print | main.tex:125 | `bib.biblatex-biber` | `\printbibliography`, no options, no heading override |

## Bespoke code
none (main.tex has no `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, `\newcounter`, `\newif` or `\usepackage`: checked by grep; there is no `.cls` or `.sty` in the zip)

## Content-opaque
none (the Python code at main.tex:52-66 is code text, the table cells at main.tex:81 and 83-85 and the entries in refs.bib:1-19 are content; no picture, no tikz)

## Lib changes
- New ways proposed: none (`class.hebdomon` is written plainly as a class way; its native vocabulary is recorded above)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
