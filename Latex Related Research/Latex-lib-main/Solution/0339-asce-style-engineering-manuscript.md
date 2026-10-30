yes

# 0339-asce-style-engineering-manuscript: ASCE-Style Engineering Manuscript

- Unverified: read from the source, not compiled.
- Source: Source/0339-asce-style-engineering-manuscript/ (origin: https://latextemplates.com/downloads/ascelike-engineering-manuscript.zip; licence: LPPL-1.3 per the manifest; README.md:50-53 and main.tex:13 say the same for `ascelike`, and README.md:55-56 gives the starter text no extra restriction)
- Kind: journal
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:25-30 builds with `pdflatex` and `bibtex`; the sample loads only `fontenc` and `graphicx`, main.tex:19-20; the class source was not read)
- Look carried by: class (`ascelike` is loaded unchanged, main.tex:17; the sample adds only `fontenc`, `graphicx`, one class command `\NameTag` and content)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The whole look is carried by the published class `ascelike` (CTAN, LPPL-1.3, in TeX Live and MiKTeX, unofficial for ASCE; read on https://ctan.org/pkg/ascelike), which the zip deliberately does not bundle (README.md:11-17, main.tex:3-6), so there is no zip-local class, style, macro, environment or artwork. The sample sets one class option (`Review`) and uses the class's own vocabulary plus kernel commands, so it is one way, `class.ascelike`. The class source was not read (not in the zip, no TeX tree here), so what it loads internally is taken on trust from its published status; the CTAN page lists no dependencies, which leaves an unconditional external-tool package unlikely but not excluded by reading. This is evidence about the class dimension, not the component ways.

## Blockers
none

## Class setting
- Class: `class.ascelike` options: `Review` (main.tex:17); the only other option the zip names is `NewProof`, the single-spaced camera-ready form (README.md:36-43, main.tex:15-16)
- Class-native vocabulary used: `\NameTag{Lovelace, \today}` (main.tex:22); `\author[n]{}` and `\affil[n]{}` in `authblk` style, with `\title` and `\maketitle` (main.tex:26-37; README.md:46-48 says the class uses `authblk`, and that `\thanks` and `\and` must not be used for affiliations); `abstract` environment (main.tex:39-42); `\KeyWords{a; b; c}` (main.tex:44); `\bibliographystyle{ascelike}` (main.tex:77), a `.bst` that ships with the same CTAN package ("document class and bibliography style", per ctan.org/pkg/ascelike)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:17 | `class.ascelike` | option `Review` (double spaced with numbered lines at submission, README.md:40-41; the class's own claim, not read in source) |
| page geometry, base font size, margins | not set in the sample or the zip | `class.ascelike` | fixed by the class (source not read) |
| line spacing and line numbers | main.tex:15-17, README.md:40-43 | `class.ascelike` | chosen by the class option `Review` or `NewProof`; no spacing or lineno package in the sample |
| font encoding | main.tex:19 | `font.fontenc-t1` | `\usepackage[T1]{fontenc}` |
| graphics loading | main.tex:20 | `fig.graphicx` | `\usepackage{graphicx}`; no `\includegraphics` and no figure float in the sample |
| class name tag | main.tex:22 | `front.class-native` | `\NameTag{Lovelace, \today}`; one string argument; where the class prints it (running head, foot or title) is not established, the class source was not read |
| title block | main.tex:26, 37 | `front.maketitle` | `\title{...}`, `\maketitle` |
| authors and affiliations | main.tex:31-35 | `front.authblk` | `\author[1]{}`, `\author[2]{}`, `\affil[1]{}`, `\affil[2]{}`; numeric labels; `authblk` is loaded by the class per README.md:46-48 |
| abstract | main.tex:39-42 | `abs.kernel` | `abstract` environment, no options; its look is the class's |
| keywords | main.tex:44 | `abs.keywords` | class command `\KeyWords{First keyword; second keyword; third keyword}`, semicolon-separated string |
| headings | main.tex:46, 53, 56, 74 | `head.class-native` | four `\section{}`; look and numbering set by the class, no heading code in the sample |
| table float | main.tex:58-70 | `tbl.tabular` | `table` float, `tabular` with `{lrr}` and `\hline` rules (no `booktabs`); `\centering` |
| table alignment | main.tex:61 | `sp.ragged` | `\centering` |
| caption | main.tex:59 | `cap.kernel` | kernel `\caption` placed before the `tabular` (caption above, text at main.tex:59); look set by the class |
| label and reference | main.tex:60, 72 | `xref.kernel` | `\label{tab:results}`, `Table~\ref{tab:results}` |
| citation | main.tex:47 | `bib.bibtex-bst` | kernel `\cite{knuth1984texbook}`; whether the class routes it through `natbib` is not established (source not read) |
| bibliography | main.tex:77-78, references.bib:1-7 | `bib.bibtex-bst` | `\bibliographystyle{ascelike}`, `\bibliography{references}`; one `@book` entry; README.md:25-30 runs `bibtex` between two `pdflatex` passes |

Components the sample does not use and the zip does not define: lists, quotes, footnotes, maths, theorems, code, boxes, colour, hyperlinks and metadata, language, index, appendix, contents pages, glossaries.

## Bespoke code
none. The zip holds `main.tex`, `references.bib` and `README.md` only (wc: 80, 7, 56 lines). `main.tex` has no `\newcommand`, `\def`, `\newenvironment`, counter or conditional. The zip-external class `ascelike` is a published way (W1: CTAN, TeX Live and MiKTeX; W2: option `Review` or `NewProof`; W3: one journal format; W4: printed as `\documentclass[Review]{ascelike}` plus body commands).

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
