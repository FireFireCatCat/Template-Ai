yes

# 0714-iop-conference-series: IOP Conference Series (`iopconfser`, IOP's own LaTeX kit)

- Unverified: read from the source, not compiled.
- Source: Source/0714-iop-conference-series/ (origin: https://cms.iopscience.iop.org/alfresco/d/d/workspace/SpacesStore/a83f1ab6-cd8f-11e0-be51-5d01ae4695ed/LaTeXTemplates.zip; licence: not established in the manifest; the class header states LPPL 1.3c, iopconfser.cls:14-16)
- Kind: conference
- Lib: v5
- Engine: pdfLaTeX-compatible (no package is loaded, no fontspec, no shell escape, no image)
- Look carried by: class (iopconfser.cls:27-125 defines every look; the sample has no preamble and no macro of its own and only supplies content through the class's own commands, iopconfser-template.tex:1-28)
- Class origin: publisher-official
- Main file: iopconfser-template.tex (other samples: none; iopconfser-LaTeXguidelines.pdf is documentation, not a sample)
- Read: main yes (lines 1-33), zip-local classes and styles all (iopconfser.cls lines 1-125; no .sty/.def/.cfg/.clo/.bst present). Not read: iopconfser-LaTeXguidelines.pdf (the Read tool could not render it, pdftoppm is not installed; documentation only).

## Verdict
yes. The look is carried entirely by `iopconfser.cls`, IOP Publishing's own class (iopconfser.cls:8-12 and 24 name IOP Publishing Ltd as author and maintainer; the zip comes from IOP's own site), so under the rubric's W1 ruling for a publisher's official kit it is one published way, `class.iopconfser`. The verdict does not rest on that ruling alone: the class loads no package, draws nothing and needs no outside tool, and every macro in it is kernel commands with fixed values, so even read as zip-local it reduces to lib ways (see Bespoke code). No `ART`, `EXTERNAL`, `UNMAPPED` or irreducible `BESPOKE` item was found. Unverified: nothing was compiled.

## Blockers
none

## Class setting
- Class: `class.iopconfser` options: none in the sample (iopconfser-template.tex:1). The class declares no option and has no `\ProcessOptions` (Grep over both files found no `DeclareOption`, `ProcessOptions`, `RequirePackage` or `usepackage`), so any option given would be unused. It hard-loads `article` with `a4paper, 11pt` (iopconfser.cls:30); version 2022/11/30 (iopconfser.cls:28).
- Class-native vocabulary used: `\title{}` (template:5), `\author{}` (7), `\affil{}` twice (9, 10), `\email{}` (12), environment `abstract` (14-16), kernel `\section` and `\subsection` (18, 23). `\title`, `\author`, `\affil` and `\email` each print at once (cls:76-91), so they sit in the body after `\begin{document}` (template:3) and `\maketitle` is never called. The class also redefines `\subsubsection`, `\paragraph`, `\subparagraph` (cls:109-120), unused by the sample.

## Component map
Rows marked [sample] are what an emitter writes. Rows marked [class] are fixed inside `class.iopconfser` and are shown so that the reduction is on record. "template" is iopconfser-template.tex, "cls" is iopconfser.cls.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class [sample] | template:1 | `class.iopconfser` | `\documentclass{iopconfser}`, no options |
| base class [class] | cls:30 | `class.article` | `\LoadClass[a4paper, 11pt]{article}`; the base the class sits on, and the reduction if the class were read as zip-local |
| paper and body size [class] | cls:30 | `page.class-options` | `a4paper`, `11pt`; one column (no `twocolumn`) |
| page geometry [class] | cls:34-45 | `page.setlength` | `\hoffset` 0mm, `\voffset` 15mm, `\textwidth` 160mm, `\textheight` 230mm, `\oddsidemargin` = `\evensidemargin` -0.4mm, `\topmargin` 0mm, `\headheight` `\headsep` `\footskip` 0mm, `\marginparsep` `\marginparwidth` 0mm. Derived by me, not stated: left and right margin 25mm, top 40.4mm, bottom 26.6mm on A4 |
| page-builder depth [class] | cls:48-49 | `page.setlength` | `\maxdepth` = .5`\topskip`, `\@maxdepth` = `\maxdepth` (raw page-level parameters, the type of `\textheight`) |
| header and footer [class] | cls:72 | `hf.pagestyle-kernel` | `\pagestyle{empty}`: no running head, no page number; head and foot heights are 0mm (cls:41-43) |
| float spacing [class] | cls:52-62 | `fig.placement` | `\floatsep` 14pt plus 2pt minus 4pt; `\textfloatsep` 24pt plus 2pt minus 4pt; `\intextsep` 16pt plus 4pt minus 4pt; `\dblfloatsep` 16pt plus 2pt minus 4pt; `\dbltextfloatsep` 24pt plus 2pt minus 4pt; `\@fptop` `\@fpbot` `\@dblfptop` `\@dblfpbot` 0pt; `\@fpsep` `\@dblfpsep` 10pt plus 1fil. The sample has no float |
| footnote and list glue [class] | cls:50-51, 63 | `sp.lengths` | `\footnotesep` 8.4pt; `\skip\footins` 10.8pt plus 4pt minus 2pt; `\partopsep` 3pt plus 2pt minus 2pt (raw kernel glue parameters, the type of `\topsep`; the sample has no footnote) |
| front-matter indent block [class] | cls:66-68 | `quote.kernel` | `quote` redefined as kernel `\list{}{\leftmargin=25mm}\item\relax` ... `\endlist`; it is the container for authors, affiliations, email and abstract, and it also changes any `quote` in the body (global `\renewenvironment`) |
| title [sample] | template:5; cls:76-78 | `front.class-native`, `font.size-commands`, `mark.kernel`, `sp.penalties`, `sp.ragged` | `\title{#1}` prints at once as a group: `\exhyphenpenalty=10000\hyphenpenalty=10000` (cls:76), `\fontsize{18}{24}\selectfont\bf\noindent\raggedright` (77), `\textsf{#1}\par` (78); bold sans, ragged right, no hyphenation |
| authors [sample] | template:7; cls:81-83 | `front.class-native`, `sp.manual-space`, `font.size-commands`, `quote.kernel`, `sp.ragged`, `mark.kernel` | `\author{#1}`: `\vspace*{1.5pc}` (81), `\fontsize{11}{13}` (82, no `\selectfont` and no enclosing group, so it acts at the `\textbf` inside the quote and is not closed by the macro; my reading), `quote` with `\raggedright \textbf{#1}` (83); the `$^{1}$` markers and the commas and "and" are content |
| affiliations [sample] | template:9-10; cls:85-87 | `front.class-native`, `font.size-commands`, `quote.kernel`, `sp.ragged`, `sp.manual-space` | `\affil{#1}` per line: group with `\fontsize{10}{11}\selectfont`, `quote` with `\raggedright`, then `\vspace*{-22pt}` |
| e-mail [sample] | template:12; cls:89-91 | `front.class-native`, `sp.manual-space`, `font.size-commands`, `quote.kernel`, `sp.ragged` | `\email{#1}`: `\vspace*{12pt}`, `\fontsize{10}{11}\selectfont`, `quote` with `\raggedright E-mail: #1` (the label is fixed text), then `\vspace*{-22pt}` |
| abstract [sample] | template:14-16; cls:93-97 | `abs.class-native`, `sp.manual-space`, `quote.kernel`, `mark.kernel` | `abstract` redefined: `\vspace{16pt plus3pt minus3pt}` (94), `quote` (95), run-in `\bfseries \abstractname.\quad\rm\ignorespaces` (96), end `\end{quote}\vspace{5mm}` (97); heading word from `\abstractname` |
| section [sample] | template:18; cls:101-104 | `head.kernel` | `\@startsection{section}{1}{\z@}{-3.25ex\@plus -1ex \@minus -.2ex}{1sp}{\reset@font\normalsize\bfseries\raggedright}`: display heading, bold, ragged right |
| subsection [sample] | template:23; cls:105-108 | `head.kernel` | level 2, same skips, after-skip 1sp, `\reset@font\normalsize\itshape\raggedright` |
| deeper headings [class] | cls:109-120 | `head.kernel` | `\subsubsection` level 3, before `-3.25ex\@plus -1ex \@minus -.2ex`, after `-1em \@plus .2em` (run-in), `\itshape`; `\paragraph` level 4, before `3.25ex \@plus1ex \@minus.2ex`, after `-1em`, `\itshape`; `\subparagraph` level 5, indent `\parindent`, same skips as `\paragraph`, `\itshape`. Unused by the sample |
| heading numbering [class] | template:18,23 (no change in cls) | `num.secnumdepth` | article defaults: neither file sets `secnumdepth` or a `\the...` print; the Grep for `setcounter` and `renewcommand\the` found none |
| fonts [class] | cls (no font package) | `font.size-commands`, `mark.kernel` | kernel Computer Modern; sans only through `\textsf` in the title; old two-letter switches `\bf` and `\rm` beside `\bfseries` and `\itshape` |
| not present | template, cls | none | no language, bibliography, list, equation, theorem, figure, table, caption, code, footnote or index construct in the sample, and the class loads no package for them |

## Bespoke code
All items sit inside `iopconfser.cls`, a published class (IOP's official kit). They are listed so that the reduction is on record. The sample itself defines nothing (template:1-28, no `\newcommand`, `\def` or counter).

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\title` redefinition, prints at once | cls:76-78 | yes | inline kernel commands: `sp.penalties` + `font.size-commands` + `mark.kernel` + `sp.ragged` + `\par`; no counter, no conditional. `\maketitle` then has no `\@title` to print; the sample never calls it |
| `\author` redefinition, prints at once | cls:81-83 | yes | `sp.manual-space` + `font.size-commands` + `quote.kernel` + `sp.ragged` + `mark.kernel` |
| `\affil` (new) | cls:85-87 | yes | `\newcommand` alias over `font.size-commands`, `quote.kernel`, `sp.ragged`, `sp.manual-space` |
| `\email` (new) | cls:89-91 | yes | `\newcommand` alias over the same ways plus the fixed text "E-mail: " |
| `quote` redefinition | cls:66-68 | yes | `\renewenvironment` over kernel `\list` with `\leftmargin=25mm`; it is `quote.kernel` with one length |
| `abstract` redefinition | cls:93-97 | yes | `\renewenvironment` over `quote.kernel`, `mark.kernel` (`\bfseries`, `\rm`), `sp.manual-space`; `\abstractname` is the kernel name |
| five `\renewcommand\section` ... `\subparagraph` through `\@startsection` | cls:101-120 | yes | the kernel's documented heading interface with fixed arguments, the call `article.cls` itself makes with other values (`head.kernel`). Same look in `head.titlesec`: `\titleformat{\section}[block]{\normalfont\normalsize\bfseries\raggedright}{\thesection}{1em}{}` and `\titlespacing*{\section}{0pt}{3.25ex plus 1ex minus .2ex}{1sp}`; `\subsection` the same with `\itshape`; `\subsubsection`, `\paragraph`, `\subparagraph` with `[runin]`, `\itshape`, after-space `1em plus .2em` (level 3) or `1em`, left indent `0pt` or `\parindent` (level 5) |
| `\setlength` of `@` lengths (`\@maxdepth`, `\@fptop` ... `\@dblfpbot`) and the page lengths | cls:34-63 | yes | plain length assignments; emitted between `\makeatletter` and `\makeatother`; no logic |

## Content-opaque
none (the sample has no figure, table or picture; the title, authors, affiliations, e-mail, abstract and section text are placeholder content, template:5-21)

## Lib changes
- New ways proposed: none (`class.iopconfser` is a class way and needs no proposal; its native vocabulary is recorded under "Class setting").
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
