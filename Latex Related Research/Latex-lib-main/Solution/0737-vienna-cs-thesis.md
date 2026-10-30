yes

# 0737-vienna-cs-thesis: Vienna CS Thesis (University of Vienna, Faculty of Computer Science; plain `report` starter)

- Unverified: read from the source, not compiled.
- Source: Source/0737-vienna-cs-thesis/ (origin: https://latextemplates.com/downloads/vienna-cs-thesis.zip; licence: CC-BY-4.0)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (T1 + inputenc utf8, README.md:15 builds with `pdflatex`; no fontspec, no Lua)
- Look carried by: mixed (kernel `report` defaults give the chapter, page and contents look; the preamble only loads published packages at default options; the title page is hand-laid in the body)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip holds one 148-line `main.tex` on the kernel `report` class and nothing zip-local: no `.cls`, `.sty`, `\newcommand`, `\def`, counter or conditional. Every preamble line is a published package (`fontenc`, `inputenc`, `babel`, `microtype`, `graphicx`, `booktabs`, `algorithm`, `algpseudocode`, `listings`, `hyperref`) and every body construct maps to an existing lib way. The title page is a hand-laid `titlepage` environment of font sizes, `\vspace` and `\vfill`. There is no artwork and no tool outside TeX. Caveat: the upstream template's own `UniVieCS_Thesis` class was NOT vendored (main.tex:1-8, README.md:21-31), so this verdict covers the substitute as shipped and says nothing about the upstream class.

## Blockers
none

## Class setting
- Class: `class.report` options: `a4paper`, `11pt` (main.tex:9). The class is not in the zip (it ships with the TeX distribution); its source was not read.
- Class-native vocabulary used: `\chapter`, `\chapter*`, `\section`, `\appendix` (main.tex:88, 56, 97, 143); `abstract` environment (main.tex:60-64); `titlepage` environment (main.tex:33-54); `\tableofcontents` `\listoffigures` `\listoftables` (main.tex:72-74).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:9 | `class.report` | a4paper, 11pt |
| paper and base size | main.tex:9 | `page.class-options` | a4paper, 11pt; no `geometry`, no margin settings, so class margins |
| font encoding | main.tex:11-12 | `font.fontenc-t1` | `fontenc` T1; `inputenc` utf8 |
| language | main.tex:17 | `lang.babel` | options `ngerman,english`, english last so it is the main language (comment main.tex:13-16) |
| language switch for the German abstract | main.tex:66, 70 | `lang.babel` | `\selectlanguage{ngerman}` then `\selectlanguage{english}` |
| micro-typography | main.tex:18 | `sp.microtype` | defaults |
| graphics package | main.tex:19 | `fig.graphicx` | loaded with no options; no `\includegraphics` in the body, no figure float |
| title data | main.tex:26-28 | `front.maketitle` | `\title{Thesis Title}` `\author{Student Name}` `\date{\today}`; `\maketitle` is never called, so these only define fields |
| title page | main.tex:33-54 | `front.titlepage-env` | `titlepage` environment holding hand-set lines (institution, title, degree text, author, supervisor, date) |
| title page alignment | main.tex:34 | `sp.ragged` | `\centering` |
| title page sizes and weight | main.tex:36-53 | `font.size-commands` | `\LARGE` `\large` `\Huge` `\Large`; `\bfseries` at main.tex:39 via `mark.kernel` |
| title page bold | main.tex:39 | `mark.kernel` | `\bfseries` |
| title page vertical space | main.tex:35, 38, 40, 42, 45, 47, 50, 52 | `sp.manual-space` | `\vspace*{2cm}`, `\vspace{3cm}`, `\vspace{2cm}`, `\vspace{1cm}`, `\vspace{0.5cm}`, `\vfill`; forced line break `\\` at main.tex:43 |
| title page date | main.tex:53 | `front.maketitle` | `\today` (kernel date, English because english is the main babel language) |
| acknowledgements page | main.tex:56-58 | `front.dedication` | unnumbered page: `\chapter*{Acknowledgements}` (`head.kernel`) |
| toc entry for unnumbered chapter | main.tex:57, 61, 68, 77 | `toc.kernel` | `\addcontentsline{toc}{chapter}{...}` |
| abstract | main.tex:60-64 | `abs.kernel` | `abstract` environment of `report` |
| German abstract (Kurzfassung) | main.tex:66-70 | `head.kernel` | `\chapter*{Kurzfassung}` under `\selectlanguage{ngerman}` (`lang.babel`) |
| contents and lists | main.tex:72-74 | `toc.kernel` | `\tableofcontents` `\listoffigures` `\listoftables`, no options |
| acronym list | main.tex:76-85 | `head.kernel` | `\chapter*{List of Acronyms}`; the list is a plain table, not `glossaries` (comment main.tex:6-8, README.md:28-31) |
| acronym table | main.tex:78-85 | `tbl.tabular` | colspec `@{}ll@{}`, header row in `\textbf` (`mark.kernel`) |
| table rules | main.tex:79-84, 101-107 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| chapters | main.tex:88, 93, 129, 133, 138 | `head.kernel` | `\chapter{...}`, class default look, no `titlesec` |
| sections | main.tex:97, 112, 118 | `head.kernel` | `\section{...}` |
| table float | main.tex:98-110 | `tbl.tabular` | `table[ht]`, `\centering`, colspec `@{}lr@{}` (`sp.ragged`) |
| caption | main.tex:108 | `cap.kernel` | `\caption` below the tabular, default format |
| algorithm packages | main.tex:21-22 | `alg.algorithmicx` | `algorithm` + `algpseudocode`, no options |
| algorithm float | main.tex:119-127 | `alg.algorithmicx` | `algorithm` float with `\caption` (`cap.kernel`), `algorithmic` body with `\State` `\While` `\EndWhile` |
| inline maths in pseudocode | main.tex:122, 123, 124 | `math.kernel` | `$x \gets 0$`, `$x < 10$`, `$x \gets x + 1$` (content) |
| code listings | main.tex:23, 113-116 | `code.listings` | `lstlisting` with `language=Python`, `caption={An example listing}`; no `\lstset`, no style definition |
| hyperlinks | main.tex:24 | `meta.hyperref` | option `hidelinks` |
| cross-references | main.tex:89, 109, 136 | `xref.kernel` | `\label{ch:intro}` `\label{tab:example}`, `Table~\ref{tab:example}`; `\autoref` is not used |
| appendix | main.tex:143-144 | `num.appendix` | `\appendix` then `\chapter{Supplementary Material}` |

Not set anywhere, so left at the `report` class defaults (no row): text font (no font package is loaded, main.tex:11-24), headers and footers, page numbering, spacing, colour, footnotes, lists, theorems, bibliography, index. The sample has none of these in its body either (no `\cite`, no `thebibliography`, no `\footnote`, no `itemize`).

## Bespoke code
none (no `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, counter or conditional in main.tex; no local class or style files).

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Placeholder text only (`Thesis Title`, `Student Name`, `Supervisor Name`); the starter has no running heads, no custom colours and no custom heading formats.
- Nothing in the zip is addressed to an AI. README.md and ATTRIBUTION.txt hold build steps and a licence/credit notice for human users; neither was acted on.
- The main.tex comment (main.tex:1-8) and README.md:21-31 say the real UniVieCS_Thesis class, its title-page variants and a `glossaries` acronym list (which would need `makeglossaries`, EXTERNAL) were left out. Had they been shipped the verdict would need a second look; as shipped there is no EXTERNAL need.
- `algorithm` (algorithms bundle) and `algpseudocode` (algorithmicx bundle) are the lib's `alg.algorithmicx` pair; I did not read their sources.
