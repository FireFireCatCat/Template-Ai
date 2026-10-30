yes

# 0839-assignment-essay: Assignment Essay (starter over CTAN's `assignment` class)

- Unverified: read from the source, not compiled.
- Source: Source/0839-assignment-essay/ (origin: https://latextemplates.com/downloads/assignment-essay.zip; licence: LPPL-1.3 per the manifest)
- Kind: assignment
- Lib: v6
- Engine: pdfLaTeX-compatible (the sample loads `fontenc`, `inputenc`, `lmodern`, `microtype`, main.tex:5-8; the class source was not read, so an unconditional XeLaTeX or external-tool dependency inside it is not excluded)
- Look carried by: class (the zip is one 70-line `main.tex` that sets class options, class-native fields and six standard packages; every page-level look comes from the unbundled class)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip holds no class, style or macro of its own: `main.tex` loads the published CTAN class `assignment` (ctan.org/pkg/assignment: "A class file for typesetting homework and lab assignments", Madhusudan Singh, LPPL 1.3, version 2004-07-14, in TeX Live and MiKTeX), adds six standard packages, and fills the class's own fields and environments. Everything in the preamble and body maps to a lib way, there is no bespoke code and no artwork. Caveat: the class source is not in the zip and was not read, and the CTAN page lists no commands, so the existence and exact output of `\coursetitle`, `\pbitem`, `problemlist` and the rest rest on the sample alone (a `yes` for the class dimension, not evidence for component ways).

## Blockers
none

## Class setting
- Class: `class.assignment` options: `11pt`, `a4paper` (main.tex:4). Published, not bundled in the zip (ships with the TeX distribution); its source was not read.
- Class-native vocabulary used: preamble fields `\coursetitle{}` (main.tex:11), `\courselabel{}` (12), `\exercisesheet{title}{subtitle}` (13), `\student{}` (15), `\semester{}` (16), with kernel `\title` (14) and `\date` (17); body `problemlist` environment (21-69) holding `\pbitem <heading text>` items (22, 28, 47, 64), each followed by a `problem` environment (23-26, 29-45, 48-62, 65-68), and an `answer` environment inside a problem (35-44). No `\maketitle` is called anywhere in the body (main.tex:19-70), so where the title block is printed is the class's business (unread).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:4 | `class.assignment` | options 11pt, a4paper; native vocabulary as above |
| paper and base size | main.tex:4 | `page.class-options` | a4paper, 11pt |
| encodings | main.tex:5-6 | `font.fontenc-t1` | `fontenc` option T1; `inputenc` option utf8 |
| text face | main.tex:7 | `font.lmodern` | `lmodern`, no options |
| micro-typography | main.tex:8 | `sp.microtype` | `microtype`, default settings |
| maths | main.tex:9, 37-41 | `math.amsmath` | `amsmath`; unnumbered display `\[ \]` with `\text{}` (main.tex:40) and `\qquad`; inline `$...$` is content |
| maths symbols | main.tex:9 | `math.amssymb` | `amssymb`, loaded with no options |
| PDF links | main.tex:10 | `meta.hyperref` | `hyperref`, no options, no `\hypersetup` |
| course, sheet, student, semester fields | main.tex:11-13, 15-16 | `front.class-native` | `\coursetitle`, `\courselabel`, `\exercisesheet{..}{..}`, `\student{..}`, `\semester{..}`; values are strings |
| title and date fields | main.tex:14, 17 | `front.maketitle` | kernel `\title{..}` and `\date{..}` set as fields; printing is the class's (no `\maketitle` in the body) |
| line break inside the student field | main.tex:15 | `sp.manual-space` | `\\` between name and ID |
| problem structure | main.tex:21-69 | `class.assignment` | `problemlist`, `\pbitem` (heading text, 4 uses), `problem`, `answer`: class-native vocabulary, recorded under the class way as the lib's v3 and v4 rulings handle a published class's own vocabulary; styling is the class's and unread |
| enumerated list in a problem | main.tex:54-61 | `list.kernel` | `enumerate` with `\item`, default labels |
| fill-in blanks | main.tex:55-60 | `sp.rule` | `\rule{<w>\linewidth}{0.4pt}` with w = 0.62, 0.59, 0.64; two items |
| line breaks inside list items | main.tex:55-60 | `sp.manual-space` | `\\` after the first two blanks of each item |
| running heads, page numbers, heading and problem/answer looks, title-block layout | not in the sample | `class.assignment` | nothing is set in `main.tex` (no `\pagestyle`, `\geometry`, `\titleformat`, `\setlength`); whatever the class does is inside the class and was not read |

Not in the sample: sectioning commands, tables, floats, captions, theorem environments, code, boxes, notes, bibliography, index, cross-references, colour, backgrounds, appendices.

## Bespoke code
none. `main.tex` has no `\newcommand`, `\def`, environment, counter, conditional or `\makeatletter` (main.tex:1-70, read in full). No zip-local `.cls`, `.sty`, `.def` or `.cfg` exists: the folder holds only `main.tex` (manifest `local_class` is empty).

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
