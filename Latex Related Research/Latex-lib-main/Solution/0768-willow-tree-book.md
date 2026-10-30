yes

# 0768-willow-tree-book: Willow Tree Book

- Unverified: read from the source, not compiled.
- Source: Source/0768-willow-tree-book/ (origin: https://latextemplates.com/downloads/willowtreebook.zip; licence: LPPL-1.3c per manifest and the CTAN page)
- Kind: book (lecture notes)
- Lib: v6
- Engine: pdfLaTeX-compatible (the class is a memoir wrapper; its source was not read and the CTAN page names no engine; the sample loads no fontspec or unicode-math)
- Look carried by: class (the zip is a 2-file stub: `main.tex` sets no layout and defines no macro; every look decision sits in the published class `willowtreebook`, which is not in the zip)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip holds only `main.tex` (65 lines) and `references.bib` (7 lines), with no `.cls` or `.sty`. The sample loads `willowtreebook`, a published class (CTAN v1.03, 2021-09-28, LPPL 1.3c, in TeX Live and MiKTeX, "just selects options for the more sophisticated memoir class", from ctan.org/pkg/willowtreebook), so it is one `class.*` way whose source was not read. The sample adds only content, class-native commands, and `booktabs`; it defines no macro, counter or artwork. So there is no bespoke code and no ART, and `yes` follows by the rubric's ruling for a look carried by a published class (evidence about the class dimension, not about component ways). Caveat: what the class does with `\define`, `problem`, `answer`, `\Colophon`, `\afterpreface` and `\BibliographyFile` is inferred from the sample's own prose (main.tex:11-13, 61-63), not from class code.

## Blockers
none

## Class setting
- Class: `class.willowtreebook` options: none (main.tex:1 `\documentclass{willowtreebook}`); source not read (unbundled, ships with the TeX distribution)
- Class-native vocabulary used: preamble commands `\Title` (main.tex:2), `\Author` (main.tex:3), `\Colophon` (main.tex:4), `\BibliographyFile` (main.tex:5); body `\afterpreface` (main.tex:14), inline `\define{term}` (main.tex:20, 44), environments `problem{key}` (main.tex:47-49) and `answer{key}` (main.tex:50-54) sharing one key, which yields the label `problem:<key>` (main.tex:56); kernel-looking `\chapter` and `\section` whose look the class sets

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.willowtreebook` | no options; memoir-based book class |
| title block | main.tex:2-3 | `front.class-native` | `\Title{Lecture Notes on Sequences}`, `\Author{Noor Fatima}`; no `\maketitle` in the sample, so the class prints it (not read) |
| colophon | main.tex:4 | `front.class-native` | `\Colophon{Released for classroom use.}` (one string) |
| preface and main-matter switch | main.tex:10, 14 | `front.class-native` | `\chapter{Preface}` then `\afterpreface`, a class command (its effect is not read) |
| chapter headings | main.tex:10, 16, 59 | `head.class-native` | `\chapter{...}`; look chosen inside the class by memoir options (not read) |
| section headings | main.tex:18, 24, 42 | `head.class-native` | `\section{...}`, no overrides in the sample |
| defined-term markup | main.tex:20, 44 | `thm.class-native` | `\define{convergent sequence}` after `\emph{convergent}`; the sample says "definitions ... set apart from the running text" (main.tex:12-13); the effect (index entry or definition record) is not read; `idx.makeidx` considered, not established |
| problem statement | main.tex:47-49 | `thm.class-native` | `problem` environment, one key argument `seq.bounded.convergent` |
| answer to a problem | main.tex:50-54 | `thm.class-native` | `answer` environment with the same key |
| emphasis | main.tex:20, 44 | `mark.kernel` | `\emph` |
| typewriter text | main.tex:12, 62-63 | `mark.kernel` | `\texttt` |
| inline maths | main.tex:51-53 | `math.kernel` | kernel `\( ... \)` (`\(L\)`, `\(1\)`) |
| table float | main.tex:28-40 | `tbl.tabular` | `table[h]` float, `tabular{ll}` |
| table centring | main.tex:29 | `sp.ragged` | `\centering` |
| table rules | main.tex:6, 31, 33, 36 | `tbl.booktabs` | `\usepackage{booktabs}`, `\toprule` `\midrule` `\bottomrule` |
| table caption | main.tex:38 | `cap.kernel` | `\caption{...}` below the tabular, no caption settings (memoir's own caption code sits under it) |
| labels and references | main.tex:26, 39, 56 | `xref.kernel` | `\label{tab:terms}`, `Table~\ref{tab:terms}`, `Problem~\ref{problem:seq.bounded.convergent}` |
| citations | main.tex:22, 57; references.bib:1-7 | `bib.bibtex-bst` | `\cite{knuth1984texbook}`, one `@book` entry |
| bibliography | main.tex:5, 61-63 | `bib.bibtex-bst` | `\BibliographyFile{references}`; style `amsplain` is stated in the sample's own text (main.tex:62), not checked in class code; no `\bibliography` call in the sample, so the class prints it (not read) |
| page geometry, fonts, running heads, spacing, colour | not in the zip (sample sets none: main.tex:1-8) | `class.willowtreebook` | chosen inside the class by memoir options; not read, so no parameters can be listed |

## Bespoke code
none. `main.tex` has no `\newcommand`, `\def`, `\newenvironment`, counter or conditional (main.tex:1-65 read in full). The class's own macros (`\define`, `problem`, `answer`) belong to a published class and are covered by `class.willowtreebook`.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Note for the class profile: `class.willowtreebook` (CTAN, memoir-based simple book class by Benjamin McKay, v1.03, LPPL 1.3c; options none seen; vocabulary as listed under Class setting; the CTAN page lists no commands)
- Zip note: the latextemplates.com zip ships no class file (manifest `local_class` empty), so a compile needs the TeX distribution's `willowtreebook` and `memoir`.
