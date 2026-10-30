yes

# 0092-exesheet: exesheet (exercise/exam sheet with margin points and a questions/answers switch)

- Unverified: read from the source, not compiled.
- Source: Source/0092-exesheet/ (origin: https://latextemplates.com/downloads/exesheet.zip; licence: LPPL-1.3)
- Kind: assignment
- Lib: v1
- Engine: pdfLaTeX-compatible (README.md:20 builds with `pdflatex main`; nothing in main.tex needs fontspec, Lua or shell escape; the exesheet package source is not in the zip and was not read)
- Look carried by: preamble (plain `article` plus published packages loaded in the sample's preamble: `geometry`, `babel`, `amsmath`, and the CTAN package `exesheet`, which is not bundled in the zip; the zip adds no class, style or macro)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is two files, `main.tex` and a README. It defines no class, style, macro, environment or counter. Everything it uses is published: kernel `article`, `geometry`, `babel`, `amsmath`, and the CTAN/TeX Live package `exesheet` (README.md:14-16, 47), which the zip deliberately does not bundle. The exercise/subpart/question/answer/note/annex vocabulary and the output/display switches all belong to that package and are chosen by option values (main.tex:18). An emitter could write this zip's preamble and body wrappers with published packages and kernel commands only. Limit: the `exesheet` source was not read (only the CTAN page, the README and the sample), so what the package prints for `\annex` and how it numbers exercises is taken from the zip's comments, not checked in code.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:5). Kernel class, not in the zip, source not read (published class loaded unchanged).
- Class-native vocabulary used: the `center` environment (main.tex:22-25), display math `\[ ... \]` (main.tex:31-33). Not used: `\maketitle`, `abstract`, `\section`. The exesheet package is loaded on top of `article`, not as its own class (main.tex:1-4, README.md:22-27).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:5 | `class.article` | a4paper |
| paper size via class option | main.tex:5 | `page.class-options` | a4paper |
| page geometry | main.tex:10 | `page.geometry` | a4paper, hmarginratio=2:1, marginparwidth=2.5cm (wide outer margin so the package's margin boxes render, main.tex:6-9, README.md:34-36) |
| language | main.tex:11 | `lang.babel` | english |
| maths package | main.tex:12 | `math.amsmath` | no options; `\text{}` used in running and display maths (main.tex:40, 43, 51) |
| exercise sheet package | main.tex:18 | `exam.questions` | package `exesheet`, options output=questions (student copy; output=answers gives the correction copy, README.md:38-42), display=notes (point value and grading-note text in the margin, main.tex:13-17) |
| exercise and subpart structure with margin points | main.tex:29, 56 (`\exercise[\points{n}]`); main.tex:38, 45, 61, 65, 69 (`\subpart[\points{n}]`) | `exam.questions` | package commands; point value passed as `\points{10}` etc. in the optional argument (README.md:31-33); margin placement is done by the package, which per main.tex:6-7 uses `\marginpar` (not checked in source) |
| question text | main.tex:30, 39, 46, 57, 62, 66, 70 (`\question{...}`) | `exam.questions` | content in the braces |
| worked answers, shown or hidden by output= | main.tex:34-36, 41-43, 48-51, 63, 67, 72-73 (`\answer{...}`) | `exam.questions` | hidden under output=questions (README.md:40-41) |
| grading note in the margin | main.tex:53-54 (`\note{...}`) | `exam.questions` | shown under display=notes (main.tex:15-17) |
| closing annex paragraph | main.tex:75-77 (`\annex` then text) | `exam.questions` | package command; its printed form is not verified (source not read) |
| title block (hand-set, no `\maketitle`) | main.tex:22-25 | `sp.ragged` (kernel `center` environment, the environment form of `\centering`), `font.size-commands` (`\Large`), `mark.kernel` (`\textbf`), `sp.manual-space` (`\\[0.3em]`) | centred title line, then one instruction line; every piece is a kernel command, nothing is defined in the zip |
| vertical gap after title | main.tex:27 | `sp.manual-space` | `\bigskip` |
| display equation | main.tex:31-33 | `math.amsmath` | `\[ ... \]` with `\mathrm`, `\longrightarrow`: content |
| inline maths and units | main.tex:34-73 | `math.amsmath` | `$...$`, `\,`, `\text{mol}` etc.: content |

Not set by the sample, so nothing to recover: fonts (Computer Modern default, no font package), header/footer (article default; the class form would add `schooldocs` headers, README.md:24-26, not used here), headings, lists, floats, tables, code, bibliography, index, colour, background.

## Bespoke code
none. grep for `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, `\newcounter`, `\newif`, `\newtheorem` and `\setlength` in main.tex finds none; the only `\RequirePackage` hit is in a comment (main.tex:2). The zip holds no `.cls`, `.sty`, `.def`, `.cfg` or `.bst`.

## Content-opaque
none (the balanced-reaction equation at main.tex:31-33 is plain amsmath maths with `\mathrm`, not a chemistry package, so it is ordinary content).

## Lib changes
- New ways proposed: none. `exesheet` is placed in `exam.questions` as a family member beside `exam` and `examdesign`: it is published on CTAN and in TeX Live (W1; https://ctan.org/pkg/exesheet, version 2.9, LPPL-1.3), behaviour chosen by options `output=` and `display=` and by `\points{}` (W2), serves any exercise or exam sheet (W3), and prints as `\usepackage[output=...,display=...]{exesheet}` plus body wrappers `\exercise`, `\subpart`, `\question`, `\answer`, `\note`, `\annex` (W4). It does the same job as the existing `exam.questions` entry (numbered questions with point values and a switch for showing answers), and the lib already folds same-job packages into one way (`font.helvet` into `font.helvet`, `bib.apacite` into `bib.apacite`). If the consolidator prefers a separate way, the id would be `exam.exesheet` with the same W1 to W4 argument.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Source claims about the package (margin placement through `\marginpar`, the schooldocs dependency of the class form) come from the zip's own comments and README, which are untrusted data; the CTAN page agrees only on the schooldocs dependency of the class and on the package being in TeX Live and MiKTeX.
- No text addressed to an AI was found in the zip.
- CTAN reads used: 1 of 3 (ctan.org/pkg/exesheet).
