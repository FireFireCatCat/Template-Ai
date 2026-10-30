yes

# 0337-lachaise-assignment: Lachaise Assignment (substitute: the `homework` problem-set class)

- Unverified: read from the source, not compiled.
- Source: Source/0337-lachaise-assignment/ (origin: https://latextemplates.com/downloads/lachaise-assignment.zip; licence: LPPL-1.3c for the `homework` class, README.md:39-40; the starter text adds no restriction, README.md:42-43)
- Kind: assignment
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:16-17 builds with `pdflatex main` twice; the class source is not in the zip, so this is the README's word, not checked against `homework.cls`)
- Look carried by: class (the zip holds no .cls or .sty; main.tex:11-16 loads the published class `homework` and sets five class options; everything that prints is the class's own vocabulary)
- Class origin: tex-distribution-unbundled (`homework`, Jinwen XU, LPPL-1.3c, "in TeX Live" and MiKTeX; read once at https://ctan.org/pkg/homework; README.md:34-35 says the class is deliberately NOT bundled)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is two files: a README and one 90-line `main.tex`. The README says it is a substitute: the original "Lachaise Assignment" design (CC-BY-NC-SA) is not here, and this download is only the upstream CTAN class `homework` with a starter problem set (README.md:3-8). `main.tex` has no `\usepackage`, no `\newcommand`, `\def`, environment or counter (a grep returns nothing); its preamble is `\documentclass` with five options plus `\title`, `\author`, `\date`. The look is one published class, `class.homework`, and the body uses only that class's native environments and commands. The answer is `yes` because an emitter can write the `\documentclass` line, the three metadata commands and the class's own `problem`/`solution`/`fact` wrappers using published ways. This is evidence about the class dimension, not about the component ways. Caveat: `homework.cls` was not read, so what it loads internally is unchecked; a package it loads unconditionally that needs a tool outside TeX would turn this into `EXTERNAL/package`, and nothing in the zip points to one (README.md:16-17 builds with plain `pdflatex`).

## Blockers
none

## Class setting
- Class: `class.homework` options: `11pt`, `title in boldface`, `theorem in new line`, `simple names`, `colored solution` (main.tex:11-16). Options are space-separated words, not `key=value`; each is a switch.
- Class-native vocabulary used: environments `problem` (main.tex:24, 38, 56), `solution` (main.tex:29, 43, 61, 68, 75), `fact` (main.tex:83); optional title argument `[Ratio test]`, `[Proof]`, `[Several parts]` (main.tex:38, 43, 56); `\qedhere` (main.tex:53); `\proofless` (main.tex:85); `\DNF<text>` (main.tex:88); `\TheDate{ISO date}` (main.tex:20). The README also lists `answer`, `proof`, `lemma` environments the sample does not use (README.md:24-25).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:11-16 | `class.homework` | options 11pt, title in boldface, theorem in new line, simple names, colored solution |
| paper and base size | main.tex:11 | `page.class-options` | `11pt`; no paper-size option, so the class default applies (not read) |
| page geometry, margins | not set in the sample | `class.homework` | inherited from the class (not read); nothing to emit |
| fonts, spacing, colours of the page | not set in the sample | `class.homework` | inherited from the class (not read); the only colour choice is the `colored solution` option (main.tex:15) |
| header, footer, page numbers | not set in the sample | `hf.class-native` | inherited from the class (not read). The CTAN page describes "Page X of Y" numbering; not confirmed from source |
| title, author, date fields | main.tex:18-20 | `front.maketitle` | `\title{Problem Set 4: Sequences and Series}`, `\author{Prof.\ Ana Petrova}`; `\date{...}` holds the class date command and a free-text course name. There is no `\maketitle` call anywhere in main.tex (grep), so the class must print the block itself at `\begin{document}` (inferred, not read) |
| title block look and date format | main.tex:12, 20 | `front.class-native` | `title in boldface` option (main.tex:12); `\TheDate{2026-02-10}` turns an ISO date into the class's printed date (main.tex:20) |
| numbered problem statements | main.tex:24-27, 38-41, 56-81 | `thm.class-native` | `problem` environment, automatic numbering, optional title argument; `theorem in new line` (main.tex:13) puts the statement head on its own line |
| solution blocks | main.tex:29-36, 43-54, 61-64, 68-71, 75-79 | `thm.class-native` | `solution` environment, optional title `[Proof]` (main.tex:43); `colored solution` (main.tex:15) colours the solution text; nested inside `enumerate` items at main.tex:61-79 |
| statement with no proof | main.tex:83-86 | `thm.class-native` | `fact` environment closed by `\proofless` (main.tex:85) so it carries no QED mark (README.md:27-28) |
| QED mark placement | main.tex:53 | `thm.class-native` | `\qedhere` at the end of a solution puts the automatic QED mark on the last line |
| label wording | main.tex:14 | `thm.class-native` | `simple names` option picks the class's simpler label names; effect inferred from the option name, class not read |
| unfinished-problem marker | main.tex:88 | `thm.class-native` | `\DNF<the divergence test for the harmonic series>`; README.md:26 calls it a marker for a problem not yet solved; the CTAN page says the class can print a reminder report of such parts at the end (mechanism not read) |
| list inside a problem | main.tex:58-80 | `list.kernel` | `enumerate` with three `\item`, each followed by its own `solution` |
| display and inline maths (content) | main.tex:25, 31-34, 40, 45-51, 57, 62-63, 69, 76-78 | `math.amsmath` | `\dfrac`, `\tfrac`, `\text`, `\displaystyle`, `\left`/`\right`, `\[ \]`. No math package is loaded in the sample, so amsmath must come from the class (not verified). The equations are content |
| figures, tables, code, headings, bibliography, cross-references | not used in main.tex | none | none in the sample. README.md:19 mentions `\cref`, but main.tex has no `\cref` or `\label` |

## Bespoke code
none. main.tex has no `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, `\newcounter` or `\usepackage`. `\TheDate`, `\DNF`, `\proofless`, `\qedhere` and the environments are the published class's, not zip-local.

## Content-opaque
none (no figure, table, code or drawing in the sample; the equations are plain math content).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The zip is a substitute for the original design (README.md:3-8): this analysis covers the `homework` class as used by the starter, not the original Lachaise look. It does hold a LaTeX sample on a published class, so it is not `NOTEMPLATE`.
- The `homework.cls` source was not read (it is on CTAN and in TeX Live, not in the zip), so the column "inherited from the class" in the map is not checked against code. Only the CTAN page's one-paragraph description (colored problems and solutions, per-statement QED symbols, "Page X of Y", unfinished-part reminder report, multilingual support) was used for hints.
- No text addressed to an AI was found in the README or main.tex.
