yes

# 0446-turabian: Turabian LaTeX class (Liberty Baptist Theological Seminary paper)

- Unverified: read from the source, not compiled.
- Source: Source/0446-turabian/ (origin: https://mirrors.ctan.org/macros/latex/contrib/turabian.zip; licence: LPPL, turabian.cls:17 and the CTAN page ctan.org/pkg/turabian, v0.1.0 2015-02-16, author Wesley Surber)
- Kind: assignment (a course paper: title page, contents page, body with footnotes, bibliography; turabian.tex:19-25)
- Lib: v4
- Engine: pdfLaTeX-compatible (every package the class loads is a pdfTeX-side package; `cjhebrew` needs e-TeX per ctan.org/pkg/cjhebrew; nothing needs fontspec)
- Look carried by: class (turabian.cls sets margins, face, spacing, headings, footnotes and the header; the sample's own preamble adds only `draftwatermark`, turabian.tex:7, and hand-lays the title page in the body, turabian.tex:14-36)
- Class origin: ctan
- Main file: turabian.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (turabian.cls, 90 lines; no .sty/.def/.cfg/.clo/.bst in the zip)

## Verdict
The zip is the CTAN package `turabian` itself (manifest origin and README:2), so its one class file is published (W1) and is the way `class.turabian`. Read through, the class is a base `report` plus published packages (`geometry`, `times`, `fancyhdr`, `titlesec`, `scrextend`, `hyphenat`, `indentfirst`, `babel`, `cjhebrew`) and a handful of small macros, each of which reduces to lib ways with parameters (table below). The sample adds `draftwatermark`, a hand-laid title page and hand-typed contents and bibliography lines, all kernel commands or published packages. No artwork, no external tool, no irreducible code, no way outside the lib.

## Blockers
none

## Class setting
- Class: `class.turabian` options: none (turabian.tex:1). Inside the class: `\LoadClass[a4paper,oneside,12pt]{report}` (turabian.cls:22).
- Class-native vocabulary used: `\papercontents` (turabian.cls:58, used turabian.tex:44), `\content` (turabian.cls:70, used turabian.tex:54; userguide.txt:100 calls it `\contents`, the class defines `\content`), `\bibliography` redefined to take no argument (turabian.cls:78, used turabian.tex:68), `\bibline` (turabian.cls:87, used turabian.tex:70,74). Documented, not used by the sample: `\textgreek` from babel's greek option (userguide.txt:161). Removed commands the guide still lists (`\headpage`, `\tocone`..`\tocfour`, `\header`, `\subheader`, userguide.txt:111-134) are not defined in the class.

## Component map
Rows citing turabian.cls describe what the published class does inside; an emitter can write `\documentclass{turabian}` (one way) or the same preamble on `class.report`.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | turabian.tex:1; turabian.cls:20-22 | `class.turabian` | no options; loads `report` |
| paper, size, sides | turabian.cls:22 | `page.class-options` | a4paper, oneside, 12pt |
| page geometry | turabian.cls:24 | `page.geometry` | hmargin=1in, vmargin=1in |
| header height | turabian.cls:44 | `page.setlength` | `\headheight`=15pt |
| base text size | turabian.cls:21 | `font.size-commands` | `\normalsize` = `\fontsize{12}{12}\selectfont`, set before `\LoadClass` (line 22), so the order is a point to check in a compile |
| text face | turabian.cls:25 | `font.mathptmx` | package `times` (Times text; math stays Computer Modern) |
| hyphenation | turabian.cls:32 | `sp.hyphenat` | option `none` |
| first-paragraph indent | turabian.cls:31 | `sp.indentfirst` | load-only |
| line spacing, body | turabian.cls:70-71; turabian.tex:54 | `sp.lengths` | `\openup 1em` (adds 1em to `\baselineskip`, `\lineskip`, `\lineskiplimit`) |
| setspace | turabian.cls:27 | `sp.setspace` | load-only; no `\setstretch` or spacing command is called anywhere |
| alignment | turabian.cls:72; turabian.tex:14 | `sp.ragged` | `\raggedright` in `\content`; `\centering` from the title page until `\content` |
| paragraph indent | turabian.cls:73 | `sp.lengths` | `\parindent`=1.5em |
| section heading | turabian.cls:41-42; turabian.tex:56 | `head.titlesec` | `\titleformat{\section}{\normalfont\normalsize\bfseries\centering}{}{0em}{}`: centred, bold, 12pt, empty label; no `\titlespacing`; no other level is formatted |
| space after heading | turabian.tex:57 | `sp.manual-space` | `\vspace{-4mm}` |
| title page | turabian.tex:14-36 | `front.titlepage-env` | hand-laid, no `titlepage` environment: centred lines ending `\\*`, `\vspace{30mm}` and `{6mm}`, one `\vfill` before the location and date lines |
| title page spacing | turabian.tex:16-35 | `sp.manual-space` | `\vspace{30mm}`, `\vspace{6mm}`, `\vfill`, `\\*` |
| title page style | turabian.tex:38 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| page breaks | turabian.tex:39,49,63 | `pg.break` | `\pagebreak` |
| running head | turabian.cls:59-62 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\fancyhead[R]{\thepage}`, `\headrulewidth`=0pt; set by `\papercontents`, so it holds from the contents page on |
| contents page heading | turabian.cls:64; turabian.tex:44 | `head.titlesec` | `\section{Table of Contents}` |
| contents entry | turabian.tex:46,48 | `sp.rule` | hand-typed `First Section\dotfill 3\\*` (no `\tableofcontents`), then `\vfill` (`sp.manual-space`) |
| contents package | turabian.cls:28 | `toc.tocloft` | load-only; no `\cftsetindents` or other setting in the class or sample |
| footnote layout | turabian.cls:30,39 | `fn.footmisc` | package `scrextend`, `\deffootnote[3em]{0em}{1em}{\thefootnotemark . }` (footnote-layout command of a package; `list.scrextend` considered, no `labeling` or `addmargin` is used) |
| footnote | turabian.tex:61 | `fn.kernel` | `\footnote{...}` twice |
| Hebrew | turabian.cls:29; turabian.tex:61 | `lang.babel` | package `cjhebrew` (CTAN, TeX Live), `\cjRL{bd'}`; a language-specific support package beside babel (`font.display` considered: the package serves a script, not a display face) |
| babel | turabian.cls:35 | `lang.babel` | options `greek,english` (english main) |
| graphics | turabian.cls:34 | `fig.graphicx` | load-only; no figure in the sample |
| dummy text | turabian.cls:23; turabian.tex:59,61 | `draft.todo` | `lipsum`: `\lipsum[1-2]`, `\lipsum[1]` in a footnote (filler content) |
| watermark | turabian.tex:7 | `bg.watermark` | `\usepackage{draftwatermark}`, no options (default text) |
| bibliography heading | turabian.cls:78-85; turabian.tex:68 | `head.titlesec`, `sp.manual-space`, `sp.lengths` | `\section{Bibliography}`, `\vspace{5mm}`, `\openup -1em`, `\vspace{-5mm}`, `\parindent=0em` |
| bibliography entries | turabian.cls:87-90; turabian.tex:70,74 | `bib.thebibliography`, `sp.lengths` | hand-typed entries, no BibTeX (userguide.txt:108); the sample uses no `thebibliography` environment, each entry is a hanging paragraph (`\hangindent`=1.5em, `\hangafter`=1), so `bib.thebibliography` is the nearest way for hand-written entries |
| entry spacing | turabian.tex:70,72,74 | `sp.manual-space` | `\bigskip`, `\medskip` |
| emphasis | turabian.tex:70 | `mark.kernel` | `\emph{Book Title}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `turabian.cls` as a whole | turabian.cls:19-90 | yes | published on CTAN (W1), so one `class.turabian` way; its content is also a composition of the ways above |
| `\papercontents` | turabian.cls:58-66 | yes | `\pagestyle{fancy}\fancyhf{}\fancyhead[R]{\thepage}\renewcommand{\headrulewidth}{0pt}\section{Table of Contents}`: `hf.fancyhdr` + `head.titlesec` |
| `\content` | turabian.cls:70-74 | yes | `\openup 1em\raggedright\parindent=1.5em`: `sp.lengths` + `sp.ragged` |
| `\bibliography` (redefined, no argument) | turabian.cls:78-85 | yes | `\section{Bibliography}\vspace{5mm}\openup -1em\vspace{-5mm}\parindent=0em`: `head.titlesec` + `sp.manual-space` + `sp.lengths` (the `\openup -1em` undoes `\content`'s `\openup 1em`) |
| `\bibline` | turabian.cls:87-90 | yes | `\hangindent=1.5em\hangafter=1` before the paragraph (takes no argument, so the `{...}` at turabian.tex:70 is a plain group): `sp.lengths` |
| `\normalsize` redefinition | turabian.cls:21 | yes | `\fontsize{12}{12}\selectfont`: `font.size-commands` |
| `\renewcommand\lips@dolipsum` | turabian.cls:47-53 | yes, by omission | patches the loop inside `lipsum` that prints `\lipsum@<roman n>` paragraphs in turn, with no explicit `\par` in the new body; it acts only on dummy filler text, which is content and which an emitter does not print as template; `lipsum`'s own source was not read |
| `\batchmode` | turabian.cls:37 | yes, dropped | TeX interaction-mode primitive, no printed effect (the comment says it lets a compile continue on error); not a component, as the rejected `sys.compat-load` in the v4 log |

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
