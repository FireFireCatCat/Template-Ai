yes

# 0061-cascadilla-proceedings-project: Cascadilla Proceedings Project paper starter

- Unverified: read from the source, not compiled.
- Source: Source/0061-cascadilla-proceedings-project/ (origin: https://latextemplates.com/downloads/cascadilla-proceedings.zip; licence: LPPL-1.3, manifest; main.tex:9 says the same for the class)
- Kind: conference (linguistics proceedings; the manifest hint `calendar` is wrong, the sample is a paper with title block, sections, a table and references)
- Lib: v1
- Engine: pdfLaTeX-compatible (the sample loads no engine-specific package and no `\usepackage` at all; the class source was not read, so what it loads for fonts is unchecked. CTAN describes it as an extension of `article`)
- Look carried by: class (the zip adds no style file and no preamble code: main.tex:16-22 is the class call plus five class-native metadata commands)
- Class origin: tex-distribution-unbundled (`cascadilla` is on CTAN, version 1.8.2, Max Bane, LPPL-1.3c, in TeX Live and MiKTeX: https://ctan.org/pkg/cascadilla, 1 of 3 allowed reads; main.tex:3-9 says the class is deliberately not bundled and ships with the distribution)
- Main file: main.tex (other samples: none; references.bib is the data file read by `\cascadillabibliography`)
- Read: main yes (95 lines, whole), zip-local classes and styles none present (the zip holds only main.tex and references.bib; references.bib read too, 29 lines)

## Verdict
Yes. The whole look is the published `cascadilla` class (CTAN, TeX Live). The sample adds no package, no macro, no counter and no drawing: `grep` for `newcommand`, `renewcommand`, `\def`, `newenvironment`, `usepackage`, `RequirePackage`, `newcounter`, `newif`, `tikz` and `hline` over main.tex finds nothing. Every command the sample calls beyond the kernel (`\institution`, `\completed`, `\copyrightyear`, `\immedsubsection`, `\cascadillabibliography`, and natbib's `\citet`/`\citep`) belongs to the published class or to natbib, so an emitter needs only the class call with its metadata commands, kernel sectioning, a kernel table and BibTeX with natbib. Judgement call for a stricter re-reading: the class source and its `cascadilla.bst` were not available (not in the zip, not read), so page geometry, fonts, running heads, heading and caption looks are carried by the class and recorded as such, not decomposed; per the rubric a published class loaded unchanged needs no reading of its own source. This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.cascadilla` options: none (main.tex:16 `\documentclass{cascadilla}`). Source of the class was not read (ships with the TeX distribution; not in the zip).
- Class-native vocabulary used: `\title`, `\author` (main.tex:18-19), `\institution{...}` (main.tex:20), `\completed{\today}` (main.tex:21), `\copyrightyear{2026}` (main.tex:22), `\maketitle` (main.tex:26), `\section` and `\subsection` (main.tex:28,44,51,72,76,82), `\immedsubsection{...}` (main.tex:45,83), `\cascadillabibliography{references}` (main.tex:93, applies `cascadilla.bst` automatically, main.tex:14-15), and natbib's `\citet` and `\citep` because the class auto-loads natbib (main.tex:13; not verified in the class source). No abstract environment, keyword command or appendix is used.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:16 | `class.cascadilla` | no options |
| page geometry (paper, margins, columns) | main.tex:16 | `page.class-options` | nothing passed; the class default layout, not read |
| fonts | main.tex:16 | `class.cascadilla` | no font package or font command in the sample (grep); whatever the class sets, not read |
| running heads, page numbers | main.tex:16 | `hf.class-native` | no `\pagestyle` or header command in the sample (grep); class default, not read |
| title, author | main.tex:18,19,26 | `front.maketitle` | `\title{Prosodic Cues to ...}`, `\author{Ada Lovelace}`, `\maketitle` (the class lays the block out) |
| institution, completion date, copyright year | main.tex:20-22 | `front.class-native` | `\institution{Institute of Analytical Engines}`, `\completed{\today}` (kernel `\today` as the value), `\copyrightyear{2026}` |
| headings | main.tex:28,44,51,72,76,82 | `head.class-native` | `\section`, `\subsection`; numbering and look are the class defaults, no `\setcounter{secnumdepth}`, no titlesec |
| heading directly after a heading | main.tex:45,83 | `head.class-native` | `\immedsubsection{Participants}`, `\immedsubsection{Implications for acquisition theory}`: the class's own subsection command; what it does differently from `\subsection` (the name suggests a subsection set straight after its section heading) is inferred from the name, not read |
| footnote | main.tex:41 | `fn.kernel` | `\footnote{We follow ...}`, class default look |
| emphasis | main.tex:61 | `mark.kernel` | `\emph` on three header cells |
| table float and table | main.tex:58-70 | `tbl.tabular` | kernel `table` float, no placement argument, `\centering`, `tabular{lll}`, no rules (no `\hline`, no booktabs, grep), four data rows |
| table alignment | main.tex:59 | `sp.ragged` | `\centering` inside the float |
| table caption | main.tex:67-68 | `cap.kernel` | `\caption{...}` after the `tabular` (below); caption look is the class's, not read |
| cross-references | main.tex:55,69 | `xref.kernel` | `\label{tab:conditions}`, `Table~\ref{tab:conditions}` |
| inline maths | main.tex:74 | `math.kernel` | `$\kappa = 0.91$`; whether the class loads amsmath is not known |
| citations | main.tex:35,36,38 | `bib.natbib` | `\citet{Shosted2006}`, `\citet{Shannon1948}`, `\citep{Goodman1943}`; natbib loaded by the class (options not read) |
| bibliography | main.tex:93; references.bib:1-29 | `bib.bibtex-bst` | `\cascadillabibliography{references}`, which runs BibTeX with the class's `cascadilla.bst` (main.tex:13-15); three `@article` entries |

## Bespoke code
none. The zip defines no macro, environment, counter or conditional (grep-checked, main.tex has no definition and no `\usepackage`). The five class-native commands are the published class's own API, not zip-local code.

## Content-opaque
none

## Lib changes
- New ways proposed: none (`class.cascadilla` is a class way, written plainly as the rubric asks; every other row uses an existing id)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes for the consolidator
- Not read, because not in the zip: the class `cascadilla.cls` and `cascadilla.bst`. Anything the class loads or defines (heading looks, caption format, running heads, fonts, whether it loads `amsmath`) is unverified. A stricter reading could require the class source before accepting `yes`.
- Text in main.tex:1-15 is the zip author's header comment (origin, licence, usage hint). It is addressed to the template user, not to an AI, and nothing in it was acted on.
