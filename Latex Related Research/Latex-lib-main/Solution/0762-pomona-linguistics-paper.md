yes

# 0762-pomona-linguistics-paper: Pomona Linguistics Paper (a reusable LaTeX starter)

- Unverified: read from the source, not compiled.
- Source: Source/0762-pomona-linguistics-paper/ (origin: https://latextemplates.com/downloads/pomona-linguistics-paper.zip, which cites the upstream page https://www.overleaf.com/latex/templates/pomona-linguistics-latex-template/bvdxdtpwysnd at README.md:7; licence: CC-BY-4.0, README.md:8 and ATTRIBUTION.txt:3)
- Kind: assignment (a short course paper starter: "Author Name | Course or Issue", main.tex:21; the manifest hint "report" is only a category guess)
- Lib: v6
- Engine: pdfLaTeX-compatible (fontenc, inputenc, microtype, geometry, xcolor, booktabs, enumitem, fancyhdr; README.md:10 also states pdfLaTeX)
- Look carried by: preamble (plain kernel `article`; the only styling is the preamble at main.tex:2-16 plus a hand-laid title block in the body)
- Class origin: tex-distribution-unbundled (kernel `article`, not shipped in the zip)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex, README.md and ATTRIBUTION.txt; no .cls, .sty, .def, .cfg, .clo, .bst or .dtx)

## Verdict
The whole template is 52 lines of `main.tex` over the unmodified kernel `article` class: six published packages with a few option values, one `\definecolor`, a `fancyhdr` header, and a body that uses only kernel commands, `booktabs` and `enumitem`. There is no zip-local class or style, no `\newcommand` or `\def`, no counter or conditional, no TikZ or other artwork and no external tool, so every component maps to an existing lib way and nothing is irreducible.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (main.tex:1)
- Class-native vocabulary used: `abstract` environment (main.tex:24-26), `\section` (main.tex:27, 29, 31, 38, 46, 50). `\title` `\author` `\date` `\maketitle` are not used: the title block is typed by hand (main.tex:18-22).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | `11pt` |
| paper and base size | main.tex:1 | `page.class-options` | `11pt`; no paper option, so the class default paper size applies |
| page geometry | main.tex:4, 10 | `page.geometry` | `margin=1in` on all sides |
| encoding | main.tex:2-3 | `font.fontenc-t1` | `fontenc` with `T1`; `inputenc` with `utf8` |
| microtypography | main.tex:5 | `sp.microtype` | load-only, no options |
| colour | main.tex:6, 11 | `color.xcolor` | `\definecolor{accent}{HTML}{245A72}`; used by `\textcolor{accent}` at main.tex:14 and main.tex:19 |
| header and page number | main.tex:9, 12-16 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}` (clears all fields, so the footer is empty), `\lhead{\small\textcolor{accent}{...}}`, `\rhead{\small\thepage}`, `\renewcommand{\headrulewidth}{0.4pt}` |
| title block | main.tex:18-22 | `sp.ragged` | `center` environment around the block (no `\title`/`\maketitle`; `front.titlepage-env` is not used because no `titlepage` environment appears) |
| title block sizes and weight | main.tex:19-21 | `font.size-commands` | `\LARGE`, `\large`, `\small` |
| title block emphasis | main.tex:19 | `mark.kernel` | `\bfseries`; `\textcolor{accent}` is `color.xcolor` |
| title block spacing | main.tex:19, 21, 23 | `sp.manual-space` | `\medskip` after the title line, `\quad` around `\textbar`, `\vspace{1em}` after the block (`\today` and `\textbar` are kernel text values, content) |
| abstract | main.tex:24-26 | `abs.kernel` | `abstract` environment, no package |
| keyword line | main.tex:47-48 | `abs.keywords` | `\noindent\textbf{Keywords:}` followed by a comma list, placed after the Discussion section, with `\par\medskip` before it (`sp.manual-space`) |
| section headings | main.tex:27, 29, 31, 38, 46, 50 | `head.kernel` | `\section` with the article defaults, no `\renewcommand` of format or counters |
| numbered sections | main.tex:27-50 | `num.secnumdepth` | article default depth (no `\setcounter{secnumdepth}`) |
| emphasis | main.tex:30 | `mark.kernel` | `\emph` |
| ordered list | main.tex:8, 33-37 | `list.enumitem` over `list.kernel` | `enumerate[label=\arabic*.]` (equal to the default first-level label) |
| table | main.tex:40-45 | `tbl.tabular` | `tabular` with colspec `@{}lll@{}`, three left-aligned columns, no side padding |
| table rules | main.tex:7, 40-45 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule`, load-only |
| table centring | main.tex:40, 45 | `sp.ragged` | `center` environment around `tabular`; no `table` float and no `\caption` |

Not present in the sample (checked by reading all 52 lines): a text-font package (Computer Modern default), footnotes, equations and theorems, figures and captions, code, boxes, bibliography or `\cite`, index, `\label` and `\ref`, contents list, `\appendix`, language packages, `hyperref`. README.md:3 mentions "numbered examples" and an appendix; `main.tex` contains neither, and the README is documentation, not template code.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand{\headrulewidth}{0.4pt}` | main.tex:16 | yes | the documented `fancyhdr` rule-width parameter, a parameter value of `hf.fancyhdr` |
| zip-local macros, environments, counters, conditionals, classes, styles | none (no `\newcommand`, `\def`, `\newenvironment`, `\newcounter`, `\newif` in main.tex) | not applicable | not applicable |

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes: nothing in the zip is addressed to an AI. ATTRIBUTION.txt:6-8 asks that Michael Diercks and Franny Brogan be credited when the template is distributed; it is a CC-BY-4.0 attribution note, relevant to licence handling and not to the template's look.
