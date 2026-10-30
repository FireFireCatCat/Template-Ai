yes

# 0325-edinburgh-maths-thesis-edmaths: Edinburgh Maths Thesis (edmaths)

- Unverified: read from the source, not compiled.
- Source: Source/0325-edinburgh-maths-thesis-edmaths/ (origin: https://latextemplates.com/downloads/edmaths-thesis.zip; licence: LPPL-1.3+ per manifest; main.tex:9 and README.md:78-82 say edmaths.sty is LPPL-1.3-or-later, README.md:84-85 says the starter adds no restrictions; the CTAN page lists LPPL 1.3c and 0BSD)
- Kind: thesis
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:26 builds with `pdflatex main`; the packages edmaths loads are pdf-engine packages, README.md:61-62)
- Look carried by: class (the published `edmaths` style over `report` carries cover, margins, spacing, running head, PDF metadata, abstract and front-matter environments; the sample preamble adds only the four `\newtheorem` lines, main.tex:56-61)
- Class origin: tex-distribution-unbundled (`edmaths.sty` is on CTAN and in TeX Live but not in the zip, main.tex:4-9, README.md:16-22; the base class `report` is kernel)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex and README.md; the `edmaths.sty` source was not read, it is not in the zip)

## Verdict
The zip is a 147-line starter that loads the published `edmaths` thesis style over kernel `report` and adds only option settings, title data, four `\newtheorem` lines and sample content. There is no zip-local class, style or macro (grep of main.tex finds no `\newcommand`, `\def`, `\makeatletter`; the only `\usepackage` is main.tex:44), no artwork, and no tool outside TeX. The style is published (ctan.org/pkg/edmaths: version 1.0.0, in TeX Live and MiKTeX), so it is one class-like way whose internals were not read, as the rubric allows for a published class that ships with the distribution. This is evidence about the class dimension, not about component ways.

## Blockers
none

## Class setting
- Class: `class.report` options: `11pt`, `oneside` (main.tex:21)
- Class: `class.edmaths` (a thesis style loaded over `report`, not a class: main.tex:12-15, README.md:33-39) options: `phd` (degree), `onehalf` (spacing), `hyperref`, `fancyhdr` (main.tex:44). Source not read.
- Class-native vocabulary used: options `phd` (also `masterph | mastersc | mmath | y4project | firstyear | secondyear | thirdyear`, main.tex:37-38), `onehalf` (`single | onehalf | double`, main.tex:40), `hyperref`, `fancyhdr`; commands `\shorttitle{}` (only with option `fancyhdr`, main.tex:46-50), `\declaration{}` (empty argument gives the School's standard wording, main.tex:67-71), `\dedication{}` (main.tex:92), `\degreetext` (internal, named at main.tex:34); environments `abstract`, `laysummary`, `acknowledgements` (main.tex:73-90; defined with `\chapter*`, main.tex:12-15); kernel `\maketitle` is the style's own text-only title page (main.tex:19-20, README.md:68-69).
- Ordering rules the emitter must keep: `\title`, `\author`, `\date` before `\usepackage{edmaths}` (main.tex:23-31); `\shorttitle` after it (main.tex:46-50); the sample must not load `hyperref` or `fancyhdr` itself (main.tex:41-43); a degree option is required (main.tex:33-36).
- Packages the style loads, by the sample's and README's own statement, not from its source: `amsmath`, `amssymb`, `amscd`, `amsthm`, `geometry`, `ifthen`, `setspace` (main.tex:114-115, README.md:61-62); the CTAN page lists `amsmath`, `amsthm`, `amscd`, `amssymb` and `setspace`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:21 | `class.report` | kernel report; `\chapter`; options 11pt, oneside |
| thesis style | main.tex:44, main.tex:12-15 | `class.edmaths` | options phd, onehalf, hyperref, fancyhdr; loaded over report |
| paper and size | main.tex:21 | `page.class-options` | 11pt, oneside (no paper option given) |
| page geometry | main.tex:114-115, README.md:61-62, README.md:73-75 | `class.edmaths` | margins set inside the style, which loads `geometry` (School's rules, CTAN page); values not read |
| line spacing | main.tex:40, main.tex:44 | `class.edmaths` | option `onehalf` (choices single, onehalf, double); the style loads `setspace` (main.tex:114-115); mechanism not read |
| running head | main.tex:41-43, main.tex:46-50 | `hf.class-native` | option `fancyhdr`, `\shorttitle{Short Title}`; without it the header uses the full title; the style configures `fancyhdr` itself, content and rules not read |
| PDF metadata | main.tex:25-28, main.tex:40-43 | `meta.class-native` | option `hyperref`; pdftitle and pdfauthor are baked from `\@title` and `\@author` at load time; the style configures `hyperref` itself, other keys not read |
| title, author, date data | main.tex:29-31 | `front.maketitle` | `\title{The Title of Your Thesis}`, `\author{Your Name}`, `\date{2026}`; placed before `\usepackage{edmaths}` |
| title page | main.tex:65, main.tex:17-20, main.tex:33-36 | `front.class-native` | `\maketitle` is the style's text-only cover; degree line from option `phd` via `\degreetext`; layout not read |
| declaration page | main.tex:71 | `front.class-native` | `\declaration{}` with an empty argument = standard wording |
| abstract | main.tex:73-77 | `abs.class-native` | `abstract` environment, defined by the style with `\chapter*` (main.tex:12-15) |
| lay summary | main.tex:82-85 | `abs.class-native` | `laysummary` environment; required for PhD, delete otherwise (main.tex:79-81) |
| acknowledgements | main.tex:87-90 | `front.class-native` | `acknowledgements` environment |
| dedication | main.tex:92 | `front.class-native` | `\dedication{For someone.}` |
| table of contents | main.tex:94 | `toc.kernel` | `\tableofcontents` with no options |
| chapters | main.tex:96, main.tex:101, main.tex:119, main.tex:138, main.tex:144 | `head.kernel` | `\chapter` from report; whether the style restyles chapter heads is unread |
| appendix | main.tex:142-144 | `num.appendix` | `\appendix` then `\chapter{Supplementary Material}` |
| theorem-like statements | main.tex:56-61, main.tex:105-108 | `thm.amsthm` | `\theoremstyle{plain}`: theorem numbered within chapter; lemma and corollary share the theorem counter; `\theoremstyle{definition}`: definition shares the counter; `amsthm` loaded by the style (main.tex:52-55) |
| proof | main.tex:110-112, main.tex:116-117 | `thm.amsthm` | `proof` environment from `amsthm`, no declaration needed |
| table float | main.tex:124-136 | `tbl.tabular` | `table[htbp]`, `\centering`, `tabular{lrr}`, `\hline` rules (main.tex:127, :129, :132); kernel table float, no `booktabs` |
| table caption | main.tex:134 | `cap.kernel` | `\caption` below the tabular; no `caption` package in the sample |
| cross-references | main.tex:97, main.tex:106, main.tex:121, main.tex:135 | `xref.kernel` | `\label` and `\ref` with `ch:`, `thm:`, `tab:` keys |
| math symbols | main.tex:107, main.tex:130-131 | `math.amssymb` | `\mathbb{R}`, `\times`; `amssymb` is loaded by the style (README.md:61), not by the sample |

Not used by the sample: fonts and colours (report defaults), language, lists, footnotes, code, bibliography, index, glossary.

## Bespoke code
none. The sample defines no macro, environment, counter or conditional (main.tex:1-147). `edmaths.sty` is a published style (ctan.org/pkg/edmaths; README.md:18-22), not zip-local, so its internal macros (`\degreetext`, the `laysummary` and `declaration` code) are part of the published way and were not read.

## Content-opaque
none

## Lib changes
- New ways proposed: none. `class.edmaths` is a class-like way (a one-institution thesis style over a published class) written plainly as the rubric asks, with its vocabulary recorded under "Class setting".
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
