yes

# 0391-seu-machine-learning-assignment: SEU Machine Learning Assignment

- Unverified: read from the source, not compiled.
- Source: Source/0391-seu-machine-learning-assignment/ (origin: https://latextemplates.com/downloads/seu-ml-assignment.zip; licence: MIT)
- Kind: assignment
- Lib: v4
- Engine: pdfLaTeX-compatible (main.tex:1 and README.md:20-21 name pdflatex; the unused `lang=cn` option would need ctex under XeLaTeX or LuaLaTeX, README.md:29-31, 55-56)
- Look carried by: class (the zip holds a 95-line sample whose preamble is the `\documentclass` line plus class-native metadata commands; main.tex:29-39)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The look is carried entirely by the published class `seu-ml-assign` (CTAN, MIT, v1.1, also in TeX Live and MiKTeX per https://ctan.org/pkg/seu-ml-assign; the author's own package, not an official kit). The class is not in the zip (README.md:11-14), so its source was not read. The sample adds no `\usepackage`, no `\newcommand`, no `\def` and no length setting (main.tex:29-95), only class options, metadata commands, `\problem`/`\subproblem`, `proof` and `equation`. An emitter writes `\documentclass[oneside,solution]{seu-ml-assign}`, the metadata commands and those body wrappers. This is evidence about the class dimension, not about the component ways. What cannot be checked here is the class's own package list (for an unconditional EXTERNAL package such as `minted`); the zip states a plain pdflatex build (main.tex:13, README.md:20-21), which weighs against it.

## Blockers
none

## Class setting
- Class: `class.seu-ml-assign` options: `oneside`, `solution` (main.tex:29). Options the class defines and the sample does not set: `twoside`, `problem` (hides the worked solutions, a student copy), `lang=` (default English; `lang=cn` is meant to load ctex and is reported broken by the README) (README.md:29-40, 66-68).
- Class-native vocabulary used: `\studentID` `\instructor` `\duedate` `\assignno` `\semester` `\mainproblem` (main.tex:33, 34, 36-39), kernel `\title` `\author` `\date` `\maketitle` (main.tex:31, 32, 35, 43), `\problem{Title}` and `\subproblem{}` (main.tex:45, 46, 75, 76), `\subsubproblem` (README.md:62, not in the sample), the `proof` environment (main.tex:51-59).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:29; README.md:11-14 | `class.seu-ml-assign` | options `oneside`, `solution`; class source not read |
| page binding | main.tex:29; README.md:66-68 | `page.class-options` | `oneside` (alternative `twoside`) |
| title fields, kernel | main.tex:31, 32, 35 | `front.maketitle` | `\title{Assignment}`, `\author{Ada Lovelace}`, `\date{\today}` |
| assignment header fields | main.tex:33, 34, 36, 37, 38, 39; README.md:60-61 | `front.class-native` | `\studentID{20270001}`, `\instructor{Prof. Example}`, `\duedate{20:00, January 8, 2027}`, `\assignno{4}`, `\semester{SEU --- 2027 Spring}`, `\mainproblem{Support Vector Machines and Kernel Methods}`; strings |
| header block print | main.tex:43; README.md:39-40 | `front.class-native` | `\maketitle` (the class's header; the README says English mode prints the default course name "Machine Learning"); layout unread |
| problem headings | main.tex:45, 75; README.md:62-63 | `head.class-native` | `\problem{Title}`, numbered, section level per the README |
| sub-problem headings | main.tex:46, 61, 76; README.md:62-63 | `head.class-native` | `\subproblem{}` with an empty title, numbered, subsection level per the README |
| worked solutions | main.tex:51-59, 64-73, 81-93; README.md:64-65, 66-67 | `thm.amsthm` | `proof` environment, default QED tombstone; amsthm is loaded by the class (the sample has no `\usepackage`), shown or hidden by the class option `solution`/`problem` |
| numbered display maths | main.tex:53-56, 66-70, 83-87 | `math.amsmath` | `equation`, `\text` (main.tex:55), `\left` `\right` (main.tex:84, 86), `\mathbf`; amsmath is loaded by the class (inferred from `\text`) |
| bold symbols in maths | main.tex:67 | `math.bm` | `\bm{\alpha}`; `bm` loaded by the class (inferred, class source not read) |
| page geometry, running head and foot, fonts, colours, spacing, theme | not in the zip | `class.seu-ml-assign` | defined inside the class and unread; the sample sets none of them (no `\geometry`, `\setlength`, `\pagestyle`, `\definecolor` in main.tex:29-95) |

## Bespoke code
none. The sample defines no macro, environment, counter or conditional; the `\def` and `\ifx` text at main.tex:14-19 is inside a comment about the class. The README's suggested `\def\@course@default` workaround (README.md:55) is not used by the sample.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Not read: the class `seu-ml-assign.cls` and its option code (not bundled; the README says it ships with TeX distributions, README.md:11-14). Everything about its page layout, colours and loaded packages is therefore unrecorded. The one ctan.org/pkg read made was for `seu-ml-assign`.
- The README's claim that `lang=cn` never loads ctex (README.md:29-39) is the zip author's report; it does not affect this verdict because the sample uses the default English mode (main.tex:29).
- No text addressed to an AI was found in main.tex or README.md.
