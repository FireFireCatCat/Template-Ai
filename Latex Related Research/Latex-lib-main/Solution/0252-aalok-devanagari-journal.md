yes

# 0252-aalok-devanagari-journal: Aalok Devanagari Journal (Marathi journal starter)

- Unverified: read from the source, not compiled.
- Source: Source/0252-aalok-devanagari-journal/ (origin: https://latextemplates.com/downloads/aalok.zip; licence: GPL-3.0-or-later; GFDL-1.3-or-later (documentation only))
- Kind: journal
- Lib: v3
- Engine: needs XeLaTeX (`fontspec` `\setmainfont` and `\IfFontExistsTF`, main.tex:3-4)
- Look carried by: preamble (kernel `article` plus a 10-line preamble; the zip ships no class or style file)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip is a neutral shell: the kernel `article` class, a preamble of published packages (`fontspec`, `geometry`, `booktabs`, `tabularx`, `microtype`, `xcolor`, `hyperref`) and kernel front matter, abstract, sections, one table and a caption. README.md:5-7 and 9-11 say the shell is deliberate and the upstream Aalok class is not redistributed, and main.tex never loads it (main.tex:2). Every component maps to a lib way, the one zip-local macro is an unused identity alias, and there is no artwork and no external tool. The real Aalok class (CTAN, per README.md:14) is not in the zip and was not analysed.

## Blockers
none

## Class setting
- Class: `class.article` options: `12pt`, `a4paper` (main.tex:2)
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle`, `abstract` environment, `\section`, `table` float with `\caption` (main.tex:11-21, 24-54)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:2 | `class.article` | 12pt, a4paper |
| paper and base size | main.tex:2 | `page.class-options` | `a4paper`, `12pt` |
| main font | main.tex:3-4 | `font.fontspec` | `\setmainfont{Noto Serif Devanagari}`, falling back to `FreeSerif` through `\IfFontExistsTF{Noto Serif Devanagari}{...}{...}`; no `Script=` or `Language=` option; fonts are not shipped (missing assets, noted) |
| page geometry | main.tex:5 | `page.geometry` | margin=2.2cm |
| paragraph shape | main.tex:8-9 | `sp.lengths` | `\parindent`=0pt, `\parskip`=0.55em |
| microtypography | main.tex:6 | `sp.microtype` | package defaults, no options |
| colours | main.tex:6-7 | `color.xcolor` | loaded without options; the only colour is the expression `blue!50!black` (main.tex:7) |
| hyperlinks | main.tex:6-7 | `meta.hyperref` | `colorlinks=true`, `urlcolor=blue!50!black`, `linkcolor=blue!50!black`, via `\hypersetup` |
| title block | main.tex:11-13, 15 | `front.maketitle` | `\title`, `\author` (stacked lines with `\\`), `\date{Volume 12, Issue 2 \textbullet{} 2026}`, `\maketitle` |
| author-block sizing and monospace email | main.tex:12 | `font.size-commands` | `\small` on the affiliation and email lines |
| author email in monospace | main.tex:12 | `mark.kernel` | `\texttt{...}` |
| abstract | main.tex:17-21 | `abs.kernel` | `abstract` environment, no package |
| keywords line | main.tex:22 | `abs.keywords` | `\textbf{Keywords:}` followed by a `;`-separated list (the plain-text form the lib names) |
| headings | main.tex:24, 30, 34, 54 | `head.kernel` | four numbered `\section`, kernel defaults; one title is Devanagari (content, main.tex:30) |
| table float | main.tex:39-40, 52 | `tbl.tabular` | kernel `table` float, placement `[ht]` |
| float centring | main.tex:40 | `sp.ragged` | `\centering` |
| table body | main.tex:43-51 | `tbl.tabularx` | `\begin{tabularx}{0.9\linewidth}{@{}lXr@{}}`: left, stretching, right columns, `@{}` outer padding removed |
| table rules | main.tex:44, 46, 50 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| caption | main.tex:41 | `cap.kernel` | `\caption{...}` above the table, no `caption` package |
| cross-reference | main.tex:37, 42 | `xref.kernel` | `\label{tab:stages}`, `Table~\ref{tab:stages}` (linked through the `hyperref` load) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\marathi}[1]{#1}` | main.tex:10 | yes | identity wrapper, defined and never called (the only hit for `marathi` in main.tex is this line); the emitter drops it, or prints the argument unchanged |

## Content-opaque
none (Marathi text at main.tex:30-32 is ordinary Unicode content typeset by the `font.fontspec` face; no figure, picture or equation exists in the sample)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The sample sets no language or script (no `polyglossia`, no `babel`, no `Script=Devanagari` on the font, main.tex:3-4), so no `lang.*` way is used. The Marathi paragraph says it shows Devanagari numerals (main.tex:31), but the source does not switch the digits; README.md:4 also mentions a bilingual abstract, while the abstract in main.tex:17-21 is English only.
- `Noto Serif Devanagari` and `FreeSerif` are installed fonts, not shipped files (main.tex:4); an emitter would ship or name them.
- No text addressed to an AI was found in README.md or main.tex.
