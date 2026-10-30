yes

# 0316-per-musi: Per Musi

- Unverified: read from the source, not compiled.
- Source: Source/0316-per-musi/ (origin: https://latextemplates.com/downloads/per-musi.zip, which cites the Overleaf gallery template https://www.overleaf.com/latex/templates/template-revista-per-musi/cbjdrqhtmnqq (ATTRIBUTION.txt:4); licence: CC-BY-4.0 (ATTRIBUTION.txt:3))
- Kind: journal
- Lib: v3
- Engine: needs XeLaTeX (`fontspec` main.tex:2, `polyglossia` main.tex:4; README.md:14 says "Compile with XeLaTeX")
- Look carried by: preamble (a published kernel class used unchanged; fonts, language, geometry, link colours and two `\newcommand` aliases are all in the sample's preamble, main.tex:2-14)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip is one 69-line `main.tex` on the kernel `article` class (not bundled, source not read) plus published packages, with no zip-local `.cls`, `.sty` or other file. The only bespoke code is two one-line `\newcommand` aliases (`\resumo`, `\keywords`) that expand to `\par`, `\smallskip` and `\textbf`, which reduce to lib ways. No artwork, no external tool. Note the README says the real Per Musi look lives in a `permusi` class and `anonymize` package that are not in this zip (README.md:6-8); this analysis covers what the zip actually contains, a standard-LaTeX stand-in, not the journal's class.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (main.tex:1)
- Class-native vocabulary used: `\title`, `\author` with `\and`, `\date`, `\maketitle`, `abstract` environment, `\section`, `table`, `thebibliography` (main.tex:10-12, 17-18, 27, 43, 63). The kernel class's source was not read.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 11pt, a4paper |
| paper and base size | main.tex:1 | `page.class-options` | a4paper, 11pt |
| page geometry | main.tex:7-8 | `page.geometry` | left=3cm, right=3cm, top=2.5cm, bottom=2.5cm |
| main font | main.tex:2-3 | `font.fontspec` | `\setmainfont{TeX Gyre Termes}`; math stays the class default (no `unicode-math`) |
| language | main.tex:4-6 | `lang.polyglossia` | `\setmainlanguage{english}`, `\setotherlanguage{portuguese}` (the Portuguese text at main.tex:23-24 is not wrapped in a language switch) |
| hyperlinks / PDF links | main.tex:7, 9 | `meta.hyperref` | colorlinks=true, linkcolor=black, urlcolor=blue |
| title block | main.tex:10-12, 17 | `front.maketitle` | `\title`, `\author{\textbf{..} \and \textbf{..}}`, `\date{text}` (the date field carries a journal line, content) |
| bold author names | main.tex:11 | `mark.kernel` | `\textbf` |
| abstract | main.tex:18-22 | `abs.kernel` | `abstract` environment, default look |
| second-language abstract | main.tex:13, 23-24 | `mark.kernel` + `sp.manual-space` | body wrapper `\par\smallskip\textbf{Resumo.} <text>`; the alias is `\newcommand` (see Bespoke code) |
| keyword line | main.tex:14, 25 | `abs.keywords` | `\par\smallskip\textbf{Keywords:} <list>` (the exact `\par\textbf{Keywords}` form the lib names, with `\smallskip` from `sp.manual-space`) |
| headings | main.tex:27, 32, 41, 58 | `head.kernel` | `\section` numbered, default article look, no `\titleformat` |
| equation | main.tex:35-37 | `math.amsmath` | `equation` environment, `\sum`, `\frac`, inline maths main.tex:33-34 (`amsmath` loaded main.tex:7) |
| numbering | main.tex:35 | `math.amsmath` | default `equation` counter, no `\numberwithin` |
| table float | main.tex:43-44, 56 | `tbl.tabular` | kernel `table` float, placement `[ht]`; `\centering` is `sp.ragged` (main.tex:44) |
| table body | main.tex:47-55 | `tbl.tabular` | `tabular` with column spec `lrr` |
| table rules | main.tex:48, 50, 54 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` (`booktabs` loaded main.tex:7) |
| table centring | main.tex:44 | `sp.ragged` | `\centering` |
| caption | main.tex:45 | `cap.kernel` | `\caption`, default look |
| label and reference | main.tex:42, 46 | `xref.kernel` | `\label{tab:events}`, `Table~\ref{tab:events}` |
| bibliography | main.tex:63-68 | `bib.thebibliography` | hand-written `thebibliography{9}`, two `\bibitem`; `\emph` for titles (`mark.kernel`, main.tex:64, 66) |
| spacing aliases | main.tex:13-14 | `sp.manual-space` | `\smallskip` |

Defaults left untouched: running heads (the class default page style), footnotes, lists, theorems, code and index are not used or set in the sample.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\resumo` | main.tex:13 (used main.tex:23) | yes | `\newcommand{\resumo}[1]{\par\smallskip\textbf{Resumo.} #1}`: an alias for a paragraph break, `\smallskip` (`sp.manual-space`) and a bold run-in label (`mark.kernel`); an emitter writes the expansion at each use |
| `\keywords` | main.tex:14 (used main.tex:25) | yes | `\newcommand{\keywords}[1]{\par\smallskip\textbf{Keywords:} #1}`: same shape, the lib's `abs.keywords` pattern; emit the expansion at the use site |

No `.cls`, `.sty`, `.def`, `.cfg`, `.clo` or `.bst` in the zip (the whole zip is ATTRIBUTION.txt, README.md, main.tex).

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Missing assets: none shipped; `TeX Gyre Termes` (main.tex:3) is a TeX Live font, installed with the distribution, not in the zip.
- Quoted for the record, not acted on: README.md:6-8 states the original journal class `permusi` and the `anonymize` package are not in the zip; the double-blind review fields it mentions (README.md:4) are not present in `main.tex` beyond placeholder author names (main.tex:11).
