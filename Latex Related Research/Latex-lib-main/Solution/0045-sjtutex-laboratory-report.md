yes

# 0045-sjtutex-laboratory-report: SJTUTeX Laboratory Report

- Unverified: read from the source, not compiled.
- Source: Source/0045-sjtutex-laboratory-report/ (origin: https://latextemplates.com/downloads/sjtutex.zip; licence: LPPL-1.3c)
- Kind: report
- Lib: v1
- Engine: needs XeLaTeX (README.md:14 "Compile with XeLaTeX"; the class source is not in the zip and was not read, so the reason, presumably `fontspec`/CJK support inside the class, is not verified)
- Look carried by: class (the zip is only `main.tex` plus a README; the whole look is the published `sjtureport` class, and the sample adds three packages and content)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes, on the rubric's class-carried ruling. The zip holds no `.cls`, `.sty` or macro definition: `main.tex` loads `sjtureport` (the SJTUTeX bundle, on CTAN and in TeX Live per one read of https://ctan.org/pkg/sjtutex, LPPL 1.3c, classes `sjtuthesis`, `sjtuarticle`, `sjtureport`), three published packages, and uses only kernel and class-native commands in the body. Every in-scope component maps to a lib way, there is no bespoke code and no artwork in the sample. This is evidence about the class dimension, not about component ways. The class source was not read, so its internals (what it loads, its cover page, headings, running heads, fonts) are unverified; an `EXTERNAL` package in the class, if any, would turn this to `no`. The README says the university badge is not bundled (a missing asset, see below).

## Blockers
none

## Class setting
- Class: `class.sjtureport` options: `lang=en` (main.tex:1). Source not read (published in the TeX distribution, not bundled in the zip).
- Class-native vocabulary used: `\title`, `\author`, `\subject`, `\keywords` (main.tex:6-9), `\maketitle` (main.tex:12), `\chapter` (main.tex:14, 20, 31, 50, 56, 62), `\appendix` (main.tex:61); class option `lang=en`. No abstract environment, no `\tableofcontents`, no bibliography in the sample.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.sjtureport` | `lang=en`; class sets page, fonts, running heads, cover, heading looks (not read, no separate rows because the sample sets none of them) |
| title block | main.tex:6-9, 12 | `front.class-native` | `\title{A Measurement Report on Queueing Delay}`, `\author{Jordan Blake}`, `\subject{Systems Engineering Laboratory}`, then `\maketitle`; the class defines how they print (not read) |
| keywords | main.tex:9 | `abs.keywords` | class command `\keywords{queueing, latency, reproducibility}`; where it prints (cover, PDF metadata, or both) is in the unread class |
| headings | main.tex:14, 20, 31, 50, 56, 62 | `head.class-native` | `\chapter{...}` only, no `\section`; look set by the class, no options given |
| appendix | main.tex:61-62 | `num.appendix` | `\appendix` then `\chapter{Run checklist}` |
| equation | main.tex:25-27 | `math.amsmath` | `\usepackage{amsmath}` (main.tex:2); `equation` environment, `\frac`, `\qquad`, `\leq`; numbering is the class's default (not read) |
| table | main.tex:32-44 | `tbl.tabular` | `table[ht]`, `\centering`, `tabular{@{}lrrr@{}}` (array `@{}` column specs), 4 columns, 3 data rows |
| table rules | main.tex:3, 36, 38, 42 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| table caption | main.tex:34 | `cap.kernel` | `\caption{Illustrative queue measurements.}` above the tabular; caption look comes from the class (whether it loads `caption` is unread) |
| centring in float | main.tex:33 | `sp.ragged` | `\centering` |
| units package | main.tex:4 | `mark.siunitx` | `\usepackage{siunitx}` loaded, no options; load-only here (no `\SI`, `\num`, `\si` or `S` column in main.tex, table numbers at lines 39-41 are plain) |
| list | main.tex:63-67 | `list.kernel` | `enumerate` with three `\item`, default labels |

## Bespoke code
none. `main.tex` has no `\newcommand`, `\def`, environment, counter or conditional, and the zip has no `.cls`, `.sty`, `.def`, `.cfg` or `.clo`.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes for the consolidator
- Class vocabulary to record for `class.sjtureport`: `\title` `\author` `\subject` `\keywords` `\maketitle`, `\chapter`, `\appendix`, option `lang=en`; report-style (chapter-based), XeLaTeX per README.md:14.
- Missing asset (not a blocker): README.md:8-10 says the SJTU badge used by the installed class is not bundled and the PDF may carry the class's institutional branding when the installation provides it. If it is the class's own logo it sits inside the published class; it is not zip-local artwork.
- Flouest's engine is pdfTeX: this zip is a way-level `yes` that still needs XeLaTeX (a `class.sjtureport` engine tag of xe/lua).
- No text addressed to an AI was found in `main.tex` or `README.md`.
- One ctan.org/pkg read used (sjtutex).
