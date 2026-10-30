yes

# 0181-practical-lab-report: Practical Lab Report

- Unverified: read from the source, not compiled.
- Source: Source/0181-practical-lab-report/ (origin: https://latextemplates.com/downloads/practical-lab-report.zip; licence: LPPL-1.3c)
- Kind: report
- Lib: v3
- Engine: pdfLaTeX-compatible (the sample loads no `fontspec`, `unicode-math` or Lua code, main.tex:1-5; the source of the unbundled package `practicalreports` was not read, so its own dependencies are not checked)
- Look carried by: preamble (a published package, `practicalreports`, loaded at main.tex:2 and not bundled in the zip, plus `geometry`; no zip-local file; `article` supplies only defaults)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds one file, main.tex; the published package `practicalreports` is not in it and its source was not read)

## Verdict
Yes. The zip is a single 99-line sample on the kernel `article` class. Every template-defining command comes from `practicalreports`, a package that is on CTAN (LPPL 1.3c, v2.0.3, "a handful of macros for writing up science practical reports", in TeX Live and MiKTeX; ctan.org/pkg/practicalreports) and is not part of the zip. The sample defines no macro, environment, counter or artwork of its own, so there is no bespoke code and no `ART`. An emitter would print `\usepackage{practicalreports}` and the package's own commands around the content. The one caveat is that the package source and manual were not read: what `\setpagefancy`, `\goodfoot`, `\newtitlepage`, `\newtable`, `\boxanswer` and `\shift` print internally is inferred from their names and arguments only. The yes rests on the package being published (W1) and being driven by strings, a column spec and one number (W2).

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (main.tex:1)
- Class-native vocabulary used: `\section` (main.tex:17, 26, 42, 65, 81, 92), `\[ \]` display maths (22-24, 73-76). No `\title`/`\author`/`\maketitle` and no `abstract` environment: the title block comes from the package's `\newtitlepage` (main.tex:13-15).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:1 | `class.article` | `11pt`, `a4paper` |
| paper and size | main.tex:1 | `page.class-options` | `11pt`, `a4paper` |
| page geometry | main.tex:3 | `page.geometry` | `margin=2.5cm` |
| report package load | main.tex:2 | `report.practicalreports` | `\usepackage{practicalreports}`, no options; loaded before `geometry`, `siunitx`, `booktabs` |
| header and footer | main.tex:7-9 | `report.practicalreports` | `\setpagefancy`; `\header{Physics Lab --- Experiment 3}{}{\today}` (three strings: left, centre empty, right the kernel `\today`); `\goodfoot` (no argument; the footer it prints is unread). The names suggest `fancyhdr` underneath; not verified |
| title block | main.tex:13-15 | `report.practicalreports` | `\newtitlepage{title}{author \quad course and section}{\today}`: three strings; the title holds inline maths `$g$`; whether it makes a separate page is unread (a `\section` follows at 17) |
| headings | main.tex:17, 26, 42, 65, 81, 92 | `head.kernel` | six unstarred `\section`, no restyling in the sample (the package may restyle them; unread) |
| display maths | main.tex:22-24, 73-76 | `math.kernel` | `\[ \]` with `\frac`, `\sqrt`, `\times`, `\approx`; no `amsmath` loaded by the sample |
| inline maths | main.tex:13, 19, 30, 60-61 | `math.kernel` | `$...$`, `^\circ` |
| units and numbers | main.tex:4, 28, 46, 60, 63, 68-71, 75, 78, 83-84 | `mark.siunitx` | `\usepackage{siunitx}` no options; `\SI{value}{unit}`, `\si{unit}`, `\SI{9.78 \pm 0.15}{...}`, units `\gram` `\meter` `\second\squared` `\per` `\milli\meter` |
| booktabs | main.tex:5 | `tbl.booktabs` | loaded with no options; the sample never calls `\toprule` `\midrule` `\bottomrule` (no match in the file), so it is probably there for `\newtable` (inferred, unread) |
| captioned table | main.tex:44-55 | `report.practicalreports` | `\newtable{caption}{ccc}{header cells}{six rows}{label}`: caption string `Period vs.\ pendulum length`, column spec `ccc`, header and rows as cell content (with `\si` and maths), label `pendulum-data` |
| table reference | main.tex:57 | `report.practicalreports` | `\reftable{pendulum-data}`: prints a reference to the table by label (what it prints is unread) |
| boxed answer | main.tex:63 | `report.practicalreports` | `\boxanswer{<display equation>}` wraps a result equation; the box look is unread |
| indented note | main.tex:37-40 | `report.practicalreports` | `\shift{0.5}{<italic paragraph>}`: one number (unit unread) and the paragraph as content |
| italic span | main.tex:37 | `mark.kernel` | `\textit` |
| manual space | main.tex:14 | `sp.manual-space` | `\quad` between author and course (kernel horizontal space) |

Not defined or used by the sample (nothing to map): fonts, colour, abstract, contents, lists, theorem-like statements, figures, code, notes, bibliography, index, language setup, PDF metadata. The unread package may set some of these as defaults (for example fonts or `amsmath`); that is recorded here, not assumed.

## Bespoke code
none. The sample has no `\newcommand`, `\def`, `\renewcommand`, environment or counter (grep over main.tex finds none). The only unfamiliar commands (`\setpagefancy`, `\header`, `\goodfoot`, `\newtitlepage`, `\newtable`, `\reftable`, `\boxanswer`, `\shift`) belong to the published package, not to the zip, so they are not zip-local code.

## Content-opaque
none (the table cells and the equations are content; the sample has no TikZ, image or other artwork).

## Lib changes
- New ways proposed: `report.practicalreports` `practicalreports` (CTAN, LPPL 1.3c, Justin Cawood, v2.0.3, in TeX Live and MiKTeX), engine pdf as far as the sample shows (source unread). Body and preamble commands for a science practical report: `\setpagefancy` `\header{l}{c}{r}` `\goodfoot`, `\newtitlepage{title}{author}{date}`, `\newtable{caption}{colspec}{header}{rows}{label}` with `\reftable{label}`, `\boxanswer{equation}`, `\shift{factor}{text}`; no package option is used. Grepped the lib for `practical`, `report` and `lab`: no existing line fits (`front.titling` and `hf.fancyhdr` would be only lower-level guesses about its internals, and `exam.schooldocs` is a different package). A doc-kind way, as `exam.schooldocs` and `notebook.ftc` are.
  - W1 published: on CTAN under LPPL 1.3c with a README and a PDF manual (ctan.org/pkg/practicalreports), and in TeX Live and MiKTeX; not zip-local.
  - W2 declarative: the sample drives it with plain strings (header fields, title, author line, caption), a column spec, a label and one number; no editing of its code.
  - W3 generic: it serves a kind of document (science practical reports), not this one experiment.
  - W4 printable: one `\usepackage{practicalreports}` preamble line, `\setpagefancy` `\header` `\goodfoot` preamble calls, and body wrappers around a title block, a table's rows, an equation and a paragraph.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this).
