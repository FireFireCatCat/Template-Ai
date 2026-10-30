yes

# 0345-simplecv: SimpleCV

- Unverified: read from the source, not compiled.
- Source: Source/0345-simplecv/ (origin: https://latextemplates.com/downloads/simplecv.zip; licence: LPPL-1.2)
- Kind: cv
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:14 builds with `pdflatex main`; the sample loads no font or Unicode package)
- Look carried by: class (the whole look is the published class `simplecv`; the sample's preamble is empty, main.tex:1-3)
- Class origin: tex-distribution-unbundled (README.md:9-10 says the class ships with TeX Live and is not bundled; ctan.org/pkg/simplecv lists it, LPPL 1.2, v1.6a, TeX Live and MiKTeX)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (`simplecv.cls` is not in the zip; its source was not read, and the CTAN page was read only for what the package is)

## Verdict
yes. The zip is one 52-line CV that loads the published class `simplecv` with no options and no preamble (main.tex:1), and adds only content and the class's own commands. It defines no macro, environment, counter or package of its own (grep of main.tex finds no `\newcommand`, `\def`, `\usepackage`, `\setlength`), so there is no bespoke code and no artwork. The class source was not read: a published class loaded unchanged needs no reading of its own source (rubric), and it is one way, `class.simplecv`. This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.simplecv` options: none (main.tex:1 is `\documentclass{simplecv}`). CTAN describes it as a derivative of the `cv` class (renamed to avoid a clash with the `cv` package); README.md:3-5 describes it as a two-column contact header, an italic-dated `topic` list environment and a numbered bibliography section.
- Class-native vocabulary used: `\leftheader{..}` (main.tex:5), `\rightheader{..}` (main.tex:8), `\title{..}` + `\maketitle` (main.tex:11, 13), `topic` environment with `\item[dates]` (main.tex:20-30, 34-39), `\section{..}` (main.tex:18, 32, 41). The kernel `thebibliography` environment with `\bibitem` and `\cite` is also used (main.tex:43-50).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.simplecv` | no options |
| page geometry, fonts, spacing, header/footer, colour | not set in the sample (preamble empty, main.tex:1-3) | `class.simplecv` | class defaults; the class source was not read, so what it sets is not recorded here |
| title block: left contact block, right contact block, name as title | main.tex:5-13 | `front.class-native` | `\leftheader` = two lines (address, city), `\rightheader` = two lines (TEL, `\texttt{\small}` e-mail), `\title` = the name, then `\maketitle` |
| line breaks inside the header blocks | main.tex:5-9 (`\\`) | `sp.manual-space` | plain `\\` between header lines, no length argument |
| e-mail in typewriter small | main.tex:9 | `mark.kernel` + `font.size-commands` | `\texttt{...}`, `\small` |
| opening paragraph (summary) | main.tex:15-16 | content | plain text, no way needed |
| section headings | main.tex:18, 32, 41 | `head.class-native` | `\section{Work Experience}`, `\section{Education}`, `\section{Publications}`; look set by the class, no option or command in the sample |
| CV entries (dated rows) | main.tex:20-30, 34-39 | `cv.entries` | `topic` environment, `\item[2021--present]` style label (date range) then the entry text; four entries in two environments |
| bibliography (publications) | main.tex:43-50 | `bib.thebibliography` | `\begin{thebibliography}{1}`, two `\bibitem{key}` entries, one `\cite{abara2020}` at main.tex:49; no `.bib` file (README.md:17-18) |
| italic journal name in a reference | main.tex:45 | `mark.kernel` | `\textit{...}` |

## Bespoke code
none (main.tex defines nothing; there is no zip-local `.cls`, `.sty`, `.def` or `.cfg`; `ls -R` shows only `README.md` and `main.tex`).

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
