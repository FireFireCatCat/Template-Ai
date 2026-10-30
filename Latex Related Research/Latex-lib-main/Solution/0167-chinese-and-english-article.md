yes

# 0167-chinese-and-english-article: Chinese and English Article

- Unverified: read from the source, not compiled.
- Source: Source/0167-chinese-and-english-article/ (origin: https://latextemplates.com/downloads/chinese-english-article.zip; licence: LPPL-1.3c (Overleaf gallery statement); README.md:11 says the gallery source is LPPL 1.3c by Jack Chen)
- Kind: misc (a bilingual Chinese/English article starter; the manifest hint is `article`)
- Lib: v3
- Engine: needs XeLaTeX (README.md:15 "Compile with XeLaTeX"; the Chinese text goes through `ctexart`, which uses xeCJK/fontspec under XeLaTeX)
- Look carried by: mixed (the published class `ctexart` carries the base look; five lines of preamble add geometry, 1.5 line spacing and blue link colours, main.tex:2-5)
- Class origin: tex-distribution-unbundled (`ctexart` is in the CTAN `ctex` bundle and TeX Live, ctan.org/pkg/ctex, LPPL 1.3c; the zip does not bundle it)
- Main file: main.tex (other samples: none; the zip holds only `main.tex` and `README.md`)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The sample is a published class (`ctexart`, source not read because it is not in the zip) plus six published packages and kernel commands, with no `\newcommand`, `\def`, environment, counter or drawing defined anywhere. Every component maps to an existing lib way, there is no artwork and no tool outside TeX. `README.md:6-9` says the gallery original used a custom `chenart` package that was not available, so this zip is a stand-in built on `ctexart`; only the stand-in was analysed. The zip ships no font files; `ctexart` picks CJK fonts itself (the sample names none), so the fonts are an environment dependency to note, not a blocker.

## Blockers
none

## Class setting
- Class: `class.ctexart` options: `12pt`, `a4paper`, `twoside` (main.tex:1). Source not read (published, in TeX Live, not bundled in the zip).
- Class-native vocabulary used: `\zihao{-3}` (ctex size command that takes a Chinese size number, main.tex:8); the article-family front matter `\title` `\author` `\date` `\maketitle` (main.tex:7-10, 13); `abstract` environment (15-22); `\section` (24, 33, 39, 54, 61); `table` + `\caption` (40-42); `thebibliography` + `\bibitem` (66-71). ctex also localises the fixed names (abstract title, "Table", bibliography title) and loads the CJK engine support; the sample's source does not show these, and the class source was not read, so they are recorded as expected class behaviour, not as read facts.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.ctexart` | `12pt`, `a4paper`, `twoside` |
| page size and base font size | main.tex:1 | `page.class-options` | `a4paper`, `12pt`; `twoside` also set here |
| page margins | main.tex:3 | `page.geometry` | `top=2.5cm, bottom=2.5cm, left=2.7cm, right=2.7cm` |
| line spacing | main.tex:2, 4 | `sp.setspace` | `\onehalfspacing` |
| link colours | main.tex:2, 5 | `meta.hyperref` | `\hypersetup{colorlinks=true, linkcolor=blue, urlcolor=blue}` |
| Chinese typesetting and CJK fonts | main.tex:1, 8, 21, 34-36, 58-59; README.md:15 | `lang.cjk` | `ctex` loaded implicitly by the class `ctexart`; no `\setCJKmainfont` or `fontset` option given, so the class default font set applies |
| title block | main.tex:7-10, 13 | `front.maketitle` | `\title{...}` with a `\\` break and a second language line, `\author{Alex Chen / 陈明}`, `\date{}` (empty, no date), `\maketitle` |
| title line break | main.tex:7-8 | `sp.manual-space` | bare `\\` between the English and Chinese title lines |
| Chinese subtitle size | main.tex:8 | `class.ctexart` | native `\zihao{-3}`: sets the type size by Chinese size number; it does the job of a font-size command and is recorded as class vocabulary, not as a separate lib way |
| abstract | main.tex:15-22 | `abs.kernel` | `abstract` environment, one English paragraph plus a keyword paragraph |
| keyword line | main.tex:21 | `abs.keywords` | `\textbf{关键词：}` followed by `；`-separated terms, a hand-written line inside the abstract |
| bold run-in label | main.tex:21 | `mark.kernel` | `\textbf` |
| section headings | main.tex:24, 33, 39, 54, 61 | `head.kernel` | `\section{...}` only, no `\renewcommand`, no `\ctexset`; the heading look is the class default (not read) |
| display equation | main.tex:29-31 | `math.amsmath` | `equation` with `\frac`, subscripts; `amsmath` loaded at main.tex:2; default numbering |
| keep-together before a table | main.tex:38 | `pg.needspace` | `\Needspace{10\baselineskip}`; package at main.tex:2 |
| table float | main.tex:40-52 | `tbl.tabular` | `table[ht]`, `\centering`, `tabular{lrr}` |
| table centring | main.tex:41 | `sp.ragged` | `\centering` inside the float |
| table rules | main.tex:44, 46, 50 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule`; package at main.tex:2 |
| table caption | main.tex:42 | `cap.kernel` | `\caption{English / 中文}` above the tabular, no `caption` package |
| bibliography | main.tex:66-71 | `bib.thebibliography` | `thebibliography{9}`, two `\bibitem` entries, no `\cite` in the body |

Header and footer, heading numbering, fonts for Latin text and cross-references are not set by the sample (no `\pagestyle`, no `\label`, no font package), so they have no row; they follow the class defaults.

## Bespoke code
none. The preamble (main.tex:1-5) loads packages and sets options only; the body (7-72) defines no macro, environment, counter or conditional.

## Content-opaque
none. The equation (main.tex:29-31), the table cells (45-49) and the prose in both languages are content.

## Lib changes
- New ways proposed: none. `\zihao` is kept inside `class.ctexart`'s vocabulary; the Chinese text support is `lang.cjk` (its lib line already names `ctex`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
