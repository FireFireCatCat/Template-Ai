yes

# 0359-thesis-cover-sheet-and-declaration: Thesis Cover Sheet and Declaration

- Unverified: read from the source, not compiled.
- Source: Source/0359-thesis-cover-sheet-and-declaration/ (origin: https://latextemplates.com/downloads/scientific-thesis-cover-declaration.zip; licence: LPPL-1.3c, as in the manifest, README.md:99-103 and main.tex:9; ctan.org/pkg/scientific-thesis-cover also gives LPPL 1.3c)
- Kind: thesis
- Lib: v3
- Engine: pdfLaTeX-compatible (main.tex:34 loads `inputenc`; README.md:32-35 builds with `pdflatex`; the package source was not read, so this is the README's claim, not checked)
- Look carried by: class (the kernel `report` class plus one published package, `scientific-thesis-cover`, that prints the cover and declaration pages; the zip adds option values and two macro calls only)
- Class origin: tex-distribution-unbundled (`report` is the LaTeX base class; `scientific-thesis-cover` is on CTAN, version 4.1.0 at the time of reading, in TeX Live and MiKTeX, and the zip deliberately does not bundle it, README.md:24-30, main.tex:3-5)
- Main file: main.tex (other samples: none; the zip holds only main.tex and README.md)
- Read: main yes, zip-local classes and styles none present (the cover package `scientific-thesis-cover.sty` is not in the zip, so its source was NOT read; its behaviour below is taken from main.tex comments and README.md, which are the zip author's statements)

## Verdict
Yes. The zip has no class, style or macro of its own: main.tex is a plain `report` document with one published package that prints a thesis cover sheet and a declaration page from key=value options, plus kernel front-matter and sectioning commands (main.tex:27-95, 104, 116, 118-140). An emitter writes `\usepackage[keys]{scientific-thesis-cover}` and the two body calls; nothing is copied from the zip. The weak point is that the package source was not available to read; it passes W1 to W4 as a published, option-driven package, and the rubric does not require reading a published package's own source.

## Blockers
none

## Class setting
- Class: `class.report` options: `11pt`, `a4paper`, `oneside` (main.tex:27)
- Class-native vocabulary used: `\chapter` (main.tex:120, 136, 140), `\section` (main.tex:128, 132), `\tableofcontents` (main.tex:118).
- Class-like front-matter package (lib v3 change log: a one-institution cover or front-matter package is recorded as a class way, its vocabulary under the class setting): `class.scientific-thesis-cover`, key=value options `language`, `type`, `institute`, `course`, `title`, `author`, `examiner`, `supervisor`, `startdate`, `enddate`, `setPageNumberToOne` (main.tex:55-94, README.md:47-49); body commands `\Titelblatt` (alias `\Coverpage`, main.tex:101-104) and `\Versicherung` (alias `\Affirmation`, main.tex:106-116, README.md:93).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:27 | `class.report` | 11pt, a4paper, oneside |
| paper size, base font size, sides | main.tex:27 | `page.class-options` | a4paper, 11pt, oneside |
| input and font encoding | main.tex:34-35 | `font.fontenc-t1` | `inputenc` with `utf8` loaded before the cover package (main.tex:29-33); `fontenc` with `T1` |
| text font | main.tex:36 | `font.lmodern` | no options |
| cover sheet (type, institute, course, title, author, examiner, supervisor, start and end date) | main.tex:50-95, 104 | `class.scientific-thesis-cover` | `language=english` (only the literal `english` selects English labels, README.md:77-81); `type={Master's Thesis}`, `institute={Department of Computing Science\\Example University\\Somewhere}`, `course={Computing Science}`, `title`, `author`, `examiner`, `supervisor`, `startdate`, `enddate` as free strings (main.tex:70-89; unrecognised values print verbatim, main.tex:67-69, 74-77, README.md:51-64); body `\Titelblatt` |
| declaration page (fixed wording, rule, place/date/signature line) | main.tex:106-116, README.md:91-97 | `class.scientific-thesis-cover` | body `\Versicherung`; no parameters beyond the package options; wording is fixed by the package (content of the package, not editable, README.md:93-95) |
| page numbering restart after the cover | main.tex:91-94 | `class.scientific-thesis-cover` | `setPageNumberToOne=true` (a boolean option; the comment says the page after the cover becomes page 1; the mechanism inside the package is unread) |
| page break around the cover | main.tex:101-103 | `class.scientific-thesis-cover` | the package issues its own `\cleardoublepage` before and after the cover (main.tex comment); no author-written break in the sample |
| load-order prerequisite for the cover package | main.tex:38-48 | `class.scientific-thesis-cover` (prerequisite preamble line) | `\usepackage{ifluatex}` written before the package; load-only compatibility stub, no printed effect (considered: `ifluatex`, in the CTAN `iftex` bundle, LPPL 1.3c; see Lib changes) |
| PDF links and metadata | main.tex:97 | `meta.hyperref` | no options, loaded after the cover package |
| table of contents | main.tex:118, README.md:37-38 | `toc.kernel` | `\tableofcontents`, two passes |
| chapters and sections | main.tex:120, 128, 132, 136, 140 | `head.kernel` | `\chapter`, `\section` with `report` defaults; no `\renewcommand` |
| inline typewriter text and `\verb` | main.tex:125-126 | `mark.kernel`, `code.verbatim` | `\texttt{scrbook}`, `\verb\|\usepackage\|` (kernel) |

Components not present in the sample: headers and footers, abstract, lists, theorems, floats, tables, captions, bibliography, index, cross-references, math. The class defaults apply for headers and footers (`report` plain page style).

## Bespoke code
none (no `\newcommand`, `\def`, environment, counter, conditional or `\makeatletter` in main.tex; a grep for them found only `\usepackage` lines, `\documentclass` and one `\verb`). The zip contains no `.cls`, `.sty`, `.def` or `.cfg`.

## Content-opaque
none (the declaration text and the German or English cover labels are printed by the package, not written in the zip; they are content as far as the emitter is concerned)

## Lib changes
- New ways proposed: none. `class.scientific-thesis-cover` is written as a class-like way under the v3 convention (a one-institution cover or front-matter package is class-like), so it needs no proposal.
- Considered, not proposed: `ifluatex` (CTAN `iftex` bundle): a load-only conditional shim needed before the cover package in the zip author's workaround (main.tex:38-48); it defines no document part or page setting, so it is a prerequisite line of the cover way, not a component. `front.dedication` (declaration pages): not used because the declaration page here is the package's own fixed page, not a hand-laid one.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes for reviewers
- The package version named in the zip comments is 4.0.2 (main.tex:39); CTAN lists 4.1.0, so the `ifluatex` workaround may be redundant on a current install. Loading it is harmless either way.
- The zip says its package carries no logo or artwork (main.tex:9-10). That is the zip's statement; with the source unread it is not checked, and it is the one assumption the `yes` depends on besides W1 to W4. If the package drew template artwork, it would still sit inside a published package, not in the zip.
- No text addressed to an AI was found in main.tex or README.md.
