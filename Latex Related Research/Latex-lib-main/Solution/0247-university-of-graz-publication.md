yes

# 0247-university-of-graz-publication: University of Graz Publication (unigrazpub monograph starter)

- Unverified: read from the source, not compiled.
- Source: Source/0247-university-of-graz-publication/ (origin: https://latextemplates.com/downloads/unigrazpub.zip; licence: LPPL-1.3c-or-later)
- Kind: book
- Lib: v3
- Engine: needs LuaLaTeX (README.md:7-8 says the class's documented workflow requires LuaLaTeX; the class source is not in the zip and was not read, so this is the README's claim, not checked; main.tex itself loads only `microtype`, `booktabs`, `hyperref` and uses no `fontspec`, main.tex:2-4)
- Look carried by: class (the published `unigrazpub` class sets page, fonts, title page, headings, contents and running heads; main.tex adds three published packages, a `\hypersetup` call and content)
- Class origin: tex-distribution-unbundled (README.md:8 "supplied by TeX Live and is not bundled"; one read of https://ctan.org/pkg/unigrazpub confirms a class on CTAN, LPPL 1.3c, author Marei Peischl, v1.00, in TeX Live and MiKTeX, described as following the University of Graz Library Publishing Services preparation guidelines; the zip ships no `.cls` or `.sty`)
- Main file: main.tex (other samples: none; README.md is documentation only)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes, on the rubric's ruling for a published class that is not bundled. The zip is a 52-line `main.tex` plus a README. It loads the published class `unigrazpub` (CTAN and TeX Live), three published packages and one `\hypersetup` call, and defines no macro, environment, counter or drawing of its own (no `\newcommand`, `\def` or `tikz` in main.tex). An emitter writes one `\documentclass{unigrazpub}` line, three `\usepackage` lines, the `\hypersetup` line and the sectioning, list, table and contents commands. Caveat: the class source was not read, so nothing inside it (an unconditional external-tool package, hidden irreducible code) can be excluded; the answer is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.unigrazpub` options: none (main.tex:1 `\documentclass{unigrazpub}`)
- Class source: NOT read (published, not bundled). The CTAN page names no base class, options or commands. The sample's `\chapter` and `\chapter*` (main.tex:11, 17, 27, 44, 48) show a chapter-level, book-like class; which base class it loads is not established here.
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (main.tex:6-8, 10); `\chapter*` and `\chapter` (main.tex:11, 17, 27, 44, 48); `\section` (main.tex:21); `\tableofcontents` (main.tex:16); `table` float with `\caption` and `tabular` (main.tex:31-43); `enumerate` (main.tex:22-26). All are standard book-class vocabulary; no unigrazpub-specific command appears in the sample.

## Component map
Rows for parts the class sets are marked "class" in Evidence: the sample only calls the standard commands, and the look lives in the unread class source.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.unigrazpub` | no options |
| paper, margins, running heads, page numbers, text and heading fonts, spacing, colour | class (not read; main.tex sets none of them) | `class.unigrazpub` | defaults of the class; an emitter writes no geometry, `fancyhdr`, font or spacing lines for this template |
| language of the document | content main.tex:12-51 (German text); no `babel`/`polyglossia` line in main.tex | `class.unigrazpub` | not established whether the class loads a language package; an emitter that must set German itself would need a language way (`lang.babel` or `lang.polyglossia` under LuaLaTeX); not claimed here |
| microtype | main.tex:2 | `sp.microtype` | default options |
| booktabs | main.tex:3 | `tbl.booktabs` | package load; commands `\toprule` `\midrule` `\bottomrule` at main.tex:35, 37, 41 |
| hyperref | main.tex:4-5 | `meta.hyperref` | `\hypersetup{colorlinks=true,linkcolor=black,urlcolor=blue}`; the class may already load `hyperref` (not read), the sample loads it with no options |
| title data and title block commands | main.tex:6-8, 10 | `front.maketitle` | `\title{A Practical Guide to Open Field Notes}`, `\author{Your Name}`, `\date{2026}`, `\maketitle` |
| look of the title page | class (main.tex:10 calls `\maketitle`) | `front.class-native` | the class's own title-page rendering; source not read |
| unnumbered preface and imprint chapters | main.tex:11, 48 | `head.kernel` | `\chapter*{Vorwort}`, `\chapter*{Impressum}` (content text at main.tex:12-15, 49-51) |
| numbered chapters | main.tex:17, 27, 44 | `head.kernel` | `\chapter{Ausgangslage}`, `\chapter{Ergebnisse}`, `\chapter{Ausblick}` |
| section | main.tex:21 | `head.kernel` | `\section{Arbeitsablauf}` |
| look of chapter and section headings | class (main.tex:11-48) | `head.class-native` | heading fonts, sizes, spacing and numbering are the class's; source not read |
| table of contents | main.tex:16 | `toc.kernel` | `\tableofcontents`, placed after the unnumbered preface; entry look is the class's (unread) |
| ordered list | main.tex:22-26 | `list.kernel` | `enumerate`, three `\item` |
| table float and tabular | main.tex:31-34, 42-43 | `tbl.tabular` | `table[ht]`, `tabular{lrr}`, rows main.tex:36, 38-40 |
| table centring | main.tex:32 | `sp.ragged` | `\centering` |
| table caption | main.tex:33 | `cap.kernel` | `\caption{Beispielhafte Arbeitsstände}`; caption look is the class's (unread) |
| inline typewriter mark | main.tex:13 | `mark.kernel` | `\texttt{unigrazpub}` |

## Bespoke code
none. main.tex defines nothing (no `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, `\newcounter`, conditionals; main.tex:1-52). The class `unigrazpub` is published (CTAN, TeX Live), so it is not bespoke; its internals were not read.

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered and not used: a language way (`lang.babel`) for the German text, because the sample sets no language and whether the class does is unread.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
