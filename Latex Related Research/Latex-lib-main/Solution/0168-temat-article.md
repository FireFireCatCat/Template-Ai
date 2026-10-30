yes

# 0168-temat-article: TEMat Article

- Unverified: read from the source, not compiled.
- Source: Source/0168-temat-article/ (origin: https://latextemplates.com/downloads/temat-article.zip; upstream credited in ATTRIBUTION.txt:4 as an Overleaf TEMat template; licence: CC-BY-4.0)
- Kind: journal
- Lib: v3
- Engine: pdfLaTeX-compatible (`inputenc` + `fontenc`, main.tex:3-4; README.md:15 says "Compile with PDFLaTeX")
- Look carried by: preamble (the zip is one `main.tex` on the kernel `article` class; the page, fonts, languages, theorem names and link colours are set by published packages in main.tex:2-10; no zip-local file defines any look)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip, source not read)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex, README.md, ATTRIBUTION.txt)

## Verdict
Yes. The whole look is the kernel `article` class plus eleven published packages (`inputenc`, `fontenc`, `babel`, `geometry`, `amsmath`, `amssymb`, `amsthm`, `booktabs`, `enumitem`, `xcolor`, `hyperref`) loaded with options in main.tex:3-8, two `\newtheorem` declarations (main.tex:9-10), and body constructs that are all kernel or `amsthm`/`booktabs`. There is no `.cls`, `.sty`, `\newcommand`, `\def`, counter or conditional anywhere in the zip, no artwork, and no tool outside TeX. An emitter could write this preamble and body using only lib ways.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (main.tex:2)
- Class-native vocabulary used: `\title` `\author` (with `\thanks` and `\and`) `\date` `\maketitle` (main.tex:11-13, 16); `abstract` environment, used twice (main.tex:17-23, 27-31); `\section` (main.tex:34, 39, 60, 81, 87); `\appendix` (main.tex:86); `table` float with `\caption` (main.tex:67-79); `equation` environment (main.tex:41-44).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:2 | `class.article` | 11pt, a4paper |
| paper and base size | main.tex:2 | `page.class-options` | `a4paper`, `11pt` |
| input and font encoding | main.tex:3-4 | `font.fontenc-t1` | `inputenc` utf8; `fontenc` T1; default Computer Modern family otherwise (no font package loaded) |
| languages | main.tex:5, 26, 32 | `lang.babel` | options `spanish,english`; `\selectlanguage{english}` before the second abstract, `\selectlanguage{spanish}` after it; babel takes the last option as main language, so `english` is the document default (not compiled) |
| page geometry | main.tex:6 | `page.geometry` | margin=2.7cm |
| display maths | main.tex:7, 41-44 | `math.amsmath` | `equation` with `\label{eq:update}`; `\frac`, `\sum`, `\sim`, `\deg` are content |
| math symbols | main.tex:7 | `math.amssymb` | load only (no symbol from it is called in the body) |
| theorem-like statements | main.tex:7, 9-10, 49-52, 61-65 | `thm.amsthm` | `\newtheorem{proposition}{Proposición}`, `\newtheorem{example}{Ejemplo}`, both with their own counters and the default (plain) style; `proposition` and `example` environments |
| proof | main.tex:7, 53-58 | `thm.amsthm` | `proof` environment, default name and end mark |
| booktabs rules | main.tex:7, 71, 73, 77 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| lists package | main.tex:7 | `list.enumitem` | load only, no list in the body |
| colour | main.tex:7-8 | `color.xcolor` | `blue!50!black` colour expression (no `\definecolor`) |
| link colours and metadata | main.tex:7-8 | `meta.hyperref` | `colorlinks=true`, `linkcolor=blue!50!black`, `urlcolor=blue!50!black` |
| title block | main.tex:11-13, 16 | `front.maketitle` | title, two authors joined with `\and`, `\date{TEMat -- artículo de muestra}` (a literal string, not `\today`) |
| author affiliation note | main.tex:12 | `front.thanks` | `\thanks{Universidad de Ejemplo}` on the first author |
| abstract, Spanish | main.tex:17-23 | `abs.kernel` | `abstract` environment |
| abstract, English | main.tex:26-32 | `abs.kernel`, `lang.babel` | second `abstract` environment inside a `\selectlanguage{english}` ... `\selectlanguage{spanish}` span |
| keyword line | main.tex:24 | `abs.keywords` | `\noindent\textbf{Palabras clave:}` followed by the list (the pattern the lib names for a keyword line) |
| inline emphasis | main.tex:24 | `mark.kernel` | `\textbf` |
| sectioning | main.tex:34, 39, 60, 81 | `head.kernel` | numbered `\section`, article default look |
| appendix | main.tex:86-87 | `num.appendix` | `\appendix`, then one `\section` |
| cross-reference | main.tex:43, 45, 55 | `xref.kernel` | `\label{eq:update}`, `\ref` with a `~` tie; made into links by `meta.hyperref` |
| table float | main.tex:67-70, 78-79 | `tbl.tabular` | `table[ht]`, `tabular` column spec `crrrr`; cells are content |
| table caption | main.tex:69 | `cap.kernel` | `\caption` above the tabular, default kernel format |
| centring | main.tex:68 | `sp.ragged` | `\centering` inside the float |

Not defined by the sample (class defaults, no way needed): running heads and page style, section numbering depth, list labels, bibliography (there is none), footnote style, contents.

## Bespoke code
none (no zip-local `.cls`, `.sty`, `.def`, `.cfg`, `\newcommand`, `\def`, `\newenvironment`, counter or conditional; the only declarations are the two kernel `\newtheorem` calls at main.tex:9-10, which are `thm.amsthm` parameters)

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Nothing in the zip addresses an AI reader. README.md:9-15 and ATTRIBUTION.txt:1-10 are licence and attribution text only.
- ATTRIBUTION.txt:1-8 requires crediting TEMat / Asociación Nacional de Estudiantes de Matemáticas (CC-BY-4.0); it is a licence condition, not template code.
- README.md:7 says the file keeps "the standard `article` class" and README.md:9-11 tells the reader to confirm the journal's current style; the zip does not ship the journal's own class, so what is analysed is the portable starter only.
