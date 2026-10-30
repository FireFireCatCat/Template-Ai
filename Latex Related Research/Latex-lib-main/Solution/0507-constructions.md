yes

# 0507-constructions: Constructions (article, submission-style substitute)

- Unverified: read from the source, not compiled.
- Source: Source/0507-constructions/ (origin: https://latextemplates.com/downloads/constructions-article.zip; licence: LPPL-1.3c per the manifest, README.md:44-51 says main.tex is CC0 upstream and the LPPL file `unified.bst` is not shipped)
- Kind: journal
- Lib: v4
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (plain `article` at 11pt/a4paper; the only look settings are the preamble lines main.tex:1-9 and 17-18; no class or style file is in the zip)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip ships only `main.tex`, `references.bib` and a README: no `.cls`, `.sty`, `.bst`, `\newcommand`, `\def` or picture code. Every component is a kernel command or a CTAN package (`article`, `geometry`, `amsmath`, `hyperref`, `booktabs`, `natbib`) and maps to an existing lib way, so an emitter could write it from published parts. The README (README.md:23-33) says the real journal template uses a custom `constructions` class and `unified.bst`, which are not in the zip; this analysis covers what is shipped, and that class is not read or assumed.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (main.tex:1)
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle`, `abstract` environment, `\section`, `quote`, `table` float, `\caption`, `\bibliography` (main.tex:20-31, 33-72)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 11pt, a4paper |
| paper and base size | main.tex:1 | `page.class-options` | `11pt`, `a4paper` |
| page geometry | main.tex:5 | `page.geometry` | `margin=1in` |
| encodings | main.tex:3-4 | `font.fontenc-t1` | `fontenc[T1]`, `inputenc[utf8]`; no family package, so the Computer Modern default stays |
| math packages (loaded, no maths in the body) | main.tex:6 | `math.amsmath`, `math.amssymb` | no options |
| graphics package (loaded, no `\includegraphics` in the body) | main.tex:7 | `fig.graphicx` | no options |
| PDF links | main.tex:8 | `meta.hyperref` | `hidelinks` |
| title block | main.tex:20-22, 26 | `front.maketitle` | `\title{...}`, `\author{Author Name \\ \small Institution}`, `\date{}` (empty date) |
| author line break and size | main.tex:21 | `sp.manual-space`, `font.size-commands` | `\\` line break; `\small` |
| abstract | main.tex:28-31 | `abs.kernel` | `abstract` environment, kernel look |
| headings | main.tex:33, 39, 48, 67 | `head.kernel` | four numbered `\section`s, no restyling |
| numbered example | main.tex:44-46 | `quote.kernel` | `quote` environment holding hand-typed "(1)" and `\quad` (a kernel space, `sp.manual-space`); the number is text, not a counter |
| table float | main.tex:53, 65 | `fig.graphicx` | kernel `table` float, the mechanism the line names for `figure`; placement `[ht]` |
| table body | main.tex:55-62 | `tbl.tabular` | `tabular{@{}ll@{}}` |
| table rules | main.tex:9, 56, 58, 61 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| table centring | main.tex:54 | `sp.ragged` | `\centering` |
| caption | main.tex:63 | `cap.kernel` | `\caption{Example constructions}` below the tabular, no `caption` package |
| label | main.tex:64 | `xref.kernel` | `\label{tab:constructions}` (defined, never referenced in the body) |
| citations | main.tex:17, 51 | `bib.natbib` | package option `round`; `\citep{goldberg1995constructions}` |
| bibliography style | main.tex:18 | `bib.bibtex-bst` | `\bibliographystyle{plainnat}` (natbib's own `.bst`; the README states the journal's `unified.bst` is replaced by it, README.md:23-33) |
| bibliography call | main.tex:72 | `bib.bibtex-bst` | `\bibliography{references}`; data in references.bib:1-6 (one `@book`, content) |

Page style, section numbering depth, fonts and spacing are all class defaults and are not set anywhere in the zip (no `\pagestyle`, `\setlength`, `\setcounter` or font package in main.tex).

## Bespoke code
none (no `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, `\newcounter`, conditional or `\makeatletter` in main.tex:1-74; no other `.tex`, `.cls` or `.sty` in the zip)

## Content-opaque
none (the example sentence at main.tex:45, the table cells at main.tex:57-60 and the `@book` entry at references.bib:1-6 are plain content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Considered, not proposed: a linguistics numbered-example package (for example `gb4e` or `linguex`); the sample does not load one, it types "(1)" by hand (main.tex:45), so no way is needed here. The journal's real template and `unified.bst` (README.md:23-33) are not shipped and so not analysed.
