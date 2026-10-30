yes

# 0029-scientific-template-collection-essay: Scientific Template Collection essay starter

- Unverified: read from the source, not compiled.
- Source: Source/0029-scientific-template-collection-essay/ (origin: https://latextemplates.com/downloads/scientific-template-collection-essay.zip; licence: MIT, as given in the manifest; README.md:11 also says the upstream repository is MIT licensed)
- Kind: report
- Lib: v1
- Engine: pdfLaTeX-compatible (no fontspec, unicode-math or luacode; README.md:11-12 says to compile with PDFLaTeX)
- Look carried by: mixed (the stock kernel `article` class defines title, abstract and headings; five published packages in the sample's own preamble set margins, maths, table rules, microtype and hyperref)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The zip is two files, `README.md` and a 78-line `main.tex`. The sample is `\documentclass[11pt,a4paper]{article}` plus five published packages with at most one option each (`geometry`, `amsmath`, `booktabs`, `microtype`, `hyperref`), and it uses kernel front matter, abstract, sectioning, one display equation and one `table` float. There is no zip-local class, style, `\newcommand`, `\def`, environment, counter or conditional and no artwork, so every component maps to an existing lib way. This is close to the stock `article` look, so it is weak evidence for the component ways beyond the common ones.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (main.tex:3). The class is kernel LaTeX and ships with the TeX distribution, so its source was not read and is not needed.
- Class-native vocabulary used: `\title`, `\author` (with `\\` inside), `\date{\today}`, `\maketitle`, `abstract` environment, `\section` (main.tex:10-12, 15, 17-21, 23, 31, 42, 64, 72).
- No font package is loaded (no `fontenc`, `lmodern` or similar), so the text face is the class default. There is nothing for an emitter to write for it.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:3 | `class.article` | 11pt, a4paper |
| paper and base size | main.tex:3 | `page.class-options` | a4paper, 11pt (class options, not a separate package) |
| page geometry | main.tex:4 | `page.geometry` | margin=2.7cm (all four sides) |
| display and inline maths | main.tex:5, 34-38 | `math.amsmath` | package loaded with no options; `equation` with `\frac`, numbered by the default counter (no `leqno`, `fleqn` or `\numberwithin`); inline `$T_0$`, `$T_1$` |
| table rules | main.tex:6, 52, 54, 60 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| microtypography | main.tex:7 | `sp.microtype` | defaults, no options |
| PDF links and metadata | main.tex:8 | `meta.hyperref` | loaded last in the preamble, no options, no `\hypersetup` |
| title block | main.tex:10-12, 15 | `front.maketitle` | `\title`, `\author`, `\date{\today}`, `\maketitle` |
| author line break | main.tex:11 | `sp.manual-space` | `\\` between name and affiliation inside `\author` (nearest home, a bare line break) |
| abstract | main.tex:17-21 | `abs.kernel` | `abstract` environment, no package |
| headings | main.tex:23, 31, 42, 64, 72 | `head.kernel` | five numbered `\section`, default numbering and format |
| table float | main.tex:47-62 | `tbl.tabular` | `table` float placement `[ht]`; `tabular` column spec `{lrrr}` |
| table centring | main.tex:48 | `sp.ragged` | `\centering` inside the float |
| table caption | main.tex:49 | `cap.kernel` | `\caption` above the tabular, no `caption` package |
| table label and reference | main.tex:50, 43 | `xref.kernel` | `\label{tab:results}`, `Table~\ref{tab:results}` (hyperref turns it into a link, no `\autoref`) |

## Bespoke code
none. The preamble defines nothing: no `\newcommand`, `\def`, `\newtheorem`, `\titleformat`, counter or conditional (main.tex:3-8 are only `\documentclass` and `\usepackage`), and the body defines nothing either (main.tex:14-78).

## Content-opaque
none. The table cell values (main.tex:53-59), the equation and the prose are content.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
