yes

# 0897-curve: CurVe (rubric-based CV)

- Unverified: read from the source, not compiled.
- Source: Source/0897-curve/ (origin: https://latextemplates.com/downloads/curve.zip; licence: LPPL-1.1 per the manifest; ctan.org/pkg/curve also gives LPPL 1.1, CurVe v1.16, Didier Verna, in TeX Live and MiKTeX)
- Kind: cv
- Lib: v6
- Engine: pdfLaTeX-compatible (the sample loads no font, Unicode or Lua package; the CTAN page names no engine and curve.cls was not read, so this is not confirmed from the class source)
- Look carried by: class (curve.cls defines the whole CV look; the zip holds only `\documentclass{curve}`, class-native header and title commands, and three content files of `rubric` environments)
- Class origin: tex-distribution-unbundled (curve.cls is on CTAN and in TeX Live; the zip does not contain it, and the manifest's local_class column is empty)
- Main file: main.tex (other samples: none; education.tex, experience.tex and skills.tex are the rubric files that main.tex pulls in with `\makerubric`)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip adds no macro, package, length or colour of its own. Its whole look is carried by the published class `curve` (CTAN, LPPL 1.1, TeX Live), which the sample drives with the class's own commands: two header blocks, a title and subtitle, three `rubric` environments with `\entry*` rows and one `\subrubric`. Every part maps to a lib way, there is no bespoke code and no artwork, so the answer is `yes`. The class source (`curve.cls`) was not available and was not read, so what the class does inside `\makeheaders`, `\maketitle` and `rubric` (page geometry, fonts, the page-break title repeat mentioned in the comment at main.tex:1-4) is recorded only as the class's behaviour, not verified.

## Blockers
none

## Class setting
- Class: `class.curve` options: none (`\documentclass{curve}`, main.tex:6)
- Class-native vocabulary used: `\leftheader{}` `\rightheader{}` (main.tex:8, 11); `\title{}` and `\subtitle{}` (main.tex:15-16); `\makeheaders[t]` (main.tex:20); `\maketitle` (main.tex:21); `\makerubric{file}` (main.tex:23-25); environment `rubric{Title}` (education.tex:1, experience.tex:1, skills.tex:1); `\entry*[label]` followed by text (education.tex:2, 5; experience.tex:2, 7, 12; skills.tex:2, 4, 6); `\subrubric{Title}` (experience.tex:11)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:6 | `class.curve` | no options; `\NeedsTeXFormat{LaTeX2e}` at main.tex:5 is kernel and carries no look |
| left header block (name, role, email) | main.tex:8-10 | `front.class-native` | `\leftheader{...}` with three lines split by `\\` |
| right header block (address, phone) | main.tex:11-13 | `front.class-native` | `\rightheader{...}` with three lines split by `\\`; `~` ties inside the phone number (content) |
| print the header blocks | main.tex:20 | `front.class-native` | `\makeheaders[t]`, optional argument value `t` (its meaning was not read from the class) |
| title and subtitle | main.tex:15-16, 21 | `front.class-native` | `\title{Curriculum Vitae}`, `\subtitle{Marcus Odera}`, then `\maketitle`; the names are kernel names but the class sets the rendering (class not read) |
| CV sections as separate files | main.tex:23-25 | `cv.entries` | `\makerubric{experience}`, `\makerubric{education}`, `\makerubric{skills}`; the comment at main.tex:2 says each rubric file is `\input` by `\makerubric`, so an emitter can also write the three environments inline |
| section heading | experience.tex:1, education.tex:1, skills.tex:1 | `head.class-native` | `\begin{rubric}{Experience}`, `{Education}`, `{Skills}`: the class draws the rubric title; no heading option is set by the sample |
| sub-section heading | experience.tex:11 | `head.class-native` | `\subrubric{Earlier}` |
| dated and labelled entry rows | education.tex:2, 5; experience.tex:2, 7, 12; skills.tex:2, 4, 6 | `cv.entries` | `\entry*[2014--2016] text` (starred form with a date range), `\entry*[Languages] text` (label), `\entry*` with no label (skills.tex:6) |
| bold job title inside an entry | experience.tex:3, 8, 13 | `mark.kernel` | `\textbf{...}` |
| line breaks inside header blocks | main.tex:8-13 | `sp.manual-space` | kernel `\\` with no length argument |
| page geometry, fonts, colours, running heads, spacing | not set by the sample | `class.curve` | all class defaults; none overridden in main.tex or the rubric files (class not read) |

Components with no use in the sample: abstract, contents, numbering, lists, quotes, notes, math, theorems, floats, tables, captions, code, boxes, bibliography, index, cross-references, language, metadata. Nothing to map.

## Bespoke code
none. A search of all four files finds no `\newcommand`, `\def`, `\newenvironment`, counter, conditional, `\usepackage` or `\RequirePackage` (the only commands are the class-native ones listed above, `\textbf`, `\\`, `\%` and `~`). There is no zip-local `.cls`, `.sty` or `.cfg`.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Not read: `curve.cls` (and any package it loads), because it is not in the zip. The comment at main.tex:1-4 is a description of the class, not an instruction, and it was not acted on.
- `cv.entries` is used for the `\entry` rows because it is the lib's CV-class entry way; the lib line names the moderncv, altacv and awesome-cv family, and curve is a further CV class with its own entry command.
