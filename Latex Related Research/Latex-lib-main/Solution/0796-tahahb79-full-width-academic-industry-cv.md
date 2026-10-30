yes

# 0796-tahahb79-full-width-academic-industry-cv: Full-Width Academic/Industry CV (resume.cls)

- Unverified: read from the source, not compiled.
- Source: Source/0796-tahahb79-full-width-academic-industry-cv/ (origin: https://codeload.github.com/tahahb79/Full-Width-Academic-Industry-CV-Resume-Template/zip/refs/heads/main; licence: MIT, LICENSE, README.md:70-74, resume.cls:8)
- Kind: cv
- Lib: v6
- Engine: pdfLaTeX-compatible (README.md:41 says compile with pdfLaTeX; only `palatino`, `fontawesome` v4, `fancyhdr`, `lastpage`, `hyperref`, `xcolor`, `etoolbox` are loaded)
- Look carried by: zip-local (the look is defined by the 112-line `resume.cls`, resume.cls:12-112; the sample adds only `inputenc`, `geometry` and one `\setfooter` call, cv-template.tex:9-12)
- Class origin: zip-local (`resume.cls` is a from-scratch class by the zip's author, resume.cls:1-8, README.md:14-15; ctan.org/pkg/resume returned 404, so it is not on CTAN; not an official kit of a publisher)
- Main file: cv-template.tex (other samples: none; `CV_Template.pdf` is a compiled preview, binary, not read)
- Read: main yes, zip-local classes and styles all (`resume.cls`, whole file)

## Verdict
The zip is one zip-local class that is `\LoadClass[11pt]{article}` plus published packages (`palatino`, `fontawesome`, `xcolor`, `fancyhdr`, `lastpage`, `hyperref`) and six `\newcommand` macros. Every macro is a straight composition of kernel boxes, skips, font switches, colours, rules and icons with fixed lengths; the only logic is `\ifblank` (etoolbox) on an argument, which the emitter resolves at emit time because the argument is static text. There is no TikZ or other artwork, no output-routine or counter code, and no external tool. Every component maps to an existing lib way, so the answer is `yes`.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (set inside the zip-local class, resume.cls:12; the sample says `\documentclass{resume}` with no options, cv-template.tex:8). The emitter writes `\documentclass[11pt]{article}` and the preamble below instead of `resume.cls`.
- Class-native vocabulary used: article's `\newblock` (an inter-block skip defined by article, used in a hand-written publication entry, cv-template.tex:52-53). No `\maketitle`, `abstract`, `\section` or `\chapter` is used. Zip-local vocabulary (not article's): `\setfooter`, `\name`, `\personalinfo`, `\cvsection`, `\cveventfull`, `\cvitemfull`, `\cvsubitemfull`, `\cvrefereefull` (reduced under "Bespoke code").

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | resume.cls:12; cv-template.tex:8 | `class.article` | 11pt |
| font size and paper | resume.cls:12 | `page.class-options` | 11pt; paper left at the class default (no paper option anywhere) |
| page geometry | cv-template.tex:10 | `page.geometry` | margin=2cm |
| input encoding | cv-template.tex:9 | `font.fontenc-t1` | `inputenc` with utf8 |
| text symbols in contact and link rows | resume.cls:51-52 (`\textperiodcentered`); cv-template.tex:21-23 (`\textbar`) | `font.fontenc-t1` | kernel/textcomp text symbol glyphs |
| paragraph indent | resume.cls:13 | `sp.lengths` | `\setlength{\parindent}{0pt}` |
| text face | resume.cls:15 | `font.palatino` | `\usepackage{palatino}` (text only; maths stays Computer Modern) |
| icon glyphs | resume.cls:19 (load); used at :51, :54, :56, :83, :85, :91, :98, :106, :108, :109, :110 | `font.icons` | `fontawesome` (v4 names): `\faMapMarker` `\faEnvelope` `\faMobile` `\faCalendar` `\faAngleDoubleRight` `\faMortarBoard` `\faInstitution` `\faPhone`; no options |
| colours | resume.cls:18, 26-28 | `color.xcolor` | `\definecolor{accentblue}{RGB}{0,150,180}`; `\colorlet{emphcolor}{accentblue}`; `\colorlet{bodytext}{black!80!white}` (defined, never used, grep of both files) |
| coloured text | resume.cls:37-38, 65, 67, 84 | `color.xcolor` | `\color{accentblue}`, `\color{emphcolor}` inside groups |
| hyperlinks | resume.cls:16 (load), :54, :106, :109; cv-template.tex:21-24, 52 | `meta.hyperref` | `\usepackage{hyperref}` with no options and no `\hypersetup`; `\href` calls incl. `mailto:` |
| footer (page style) | resume.cls:20, 33-39 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\renewcommand{\headrulewidth}{0pt}`, `\cfoot{...}`, `\rfoot{...}`; called once, cv-template.tex:12 |
| footer page count | resume.cls:21, 37 | `pgnum.lastpage` | `lastpage`, `\pageref{LastPage}` printed as "N of M" in `accentblue` |
| footer page reference | resume.cls:37 | `xref.kernel` | `\pageref` |
| footer text | cv-template.tex:12; resume.cls:38 | `hf.fancyhdr` | right-foot string "Updated in Jan 2026" in `accentblue` (string is content) |
| name line | resume.cls:44-46; cv-template.tex:16 | `sp.ragged` | `\centerline{\Huge #1}` (kernel centring of one line) |
| name size | resume.cls:45 | `font.size-commands` | `\Huge` |
| contact line | resume.cls:49-58; cv-template.tex:17-18 | `sp.ragged` | `\centerline{...}` holding icon + city, country (+ optional postcode), email as `\href{mailto:}`, phone; separators `\textperiodcentered`; `\hspace{2pt}` between groups |
| contact-line spacing | resume.cls:53, 55 | `sp.manual-space` | `\hspace{2pt}`, `~`, `\ ` |
| link row | cv-template.tex:20-25 | `sp.ragged` | `center` environment with `\small` (`font.size-commands`) and four `\href` links (`meta.hyperref`) joined by `\ \textbar\ ` |
| section heading (`\cvsection`) | resume.cls:63-69; used cv-template.tex:28, 37, 48, 57, 69, 82, 89, 94 | `font.size-commands`, `mark.kernel`, `sp.ragged`, `color.xcolor`, `sp.rule`, `sp.manual-space` | `\bigskip`; `{\Large\scshape\raggedright\color{emphcolor}#1\par}`; `\vspace{-0.6\baselineskip}`; `{\color{accentblue}\noindent\rule{\linewidth}{1pt}\par}`; `\smallskip`. Not `\section`: no counter, no TOC entry. Equivalent published form: `head.titlesec` on `\section*` with the rule as after-code |
| entry header (`\cveventfull`) | resume.cls:81-87; used cv-template.tex:39-40, 43-44, 71-72, 77-78 | `font.size-commands`, `mark.kernel`, `sp.manual-space`, `color.xcolor`, `font.icons` | `\medskip`; line 1 `{\large\bfseries title}\hfill{\small\faCalendar~date}`; line 2 `{\color{emphcolor}\bfseries org}` and optional `\hfill{\small\faMapMarker~place}`; `\smallskip` |
| full-width bullet (`\cvitemfull`) | resume.cls:90-94; used throughout cv-template.tex:30-101 | `box.minipage`, `font.icons`, `sp.manual-space` | `\noindent\makebox[1.3em][c]{\faAngleDoubleRight}\parbox[t]{0.93\linewidth}{#1}\par\smallskip`; `\makebox` is the kernel LR-box sibling of `\parbox` |
| sub-bullet (`\cvsubitemfull`) | resume.cls:97-101; used cv-template.tex:60, 65 | `box.minipage`, `font.icons`, `sp.manual-space` | `\noindent\hspace{3mm}\makebox[1.3em][c]{\faAngleDoubleRight}\parbox[t]{0.89\linewidth}{#1}\par\smallskip` |
| referee entry (`\cvrefereefull`) | resume.cls:104-112; used cv-template.tex:96-101 | `meta.hyperref`, `font.size-commands`, `mark.kernel`, `sp.manual-space`, `font.icons` | `\medskip`; `\href{url}{\large\bfseries name}\hfill{\small\faMortarBoard~title}`; `\small\faInstitution~dept`; `\faEnvelope~\href{mailto:}{email}`; optional `\hspace{2em}\faPhone~phone`; `\medskip` |
| inline emphasis | cv-template.tex:33, 51-53, 59, 64, 84-86 | `mark.kernel` | `\textbf`, `\emph` |
| vertical gaps in the body | cv-template.tex:63 | `sp.manual-space` | `\medskip` between two project items |
| publication entry | cv-template.tex:50-54 | `sp.manual-space`, `mark.kernel`, `meta.hyperref` | hand-written text inside `\cvitemfull`; `\newblock` (article's `\hskip` block skip), `\textbf`, `\emph`, `\href`; no bibliography machinery is used (no `thebibliography`, no `.bib`) |
| small caps in headings | resume.cls:65 | `mark.kernel` | `\scshape` |

Components the zip does not define or use: abstract, contents lists, theorems, maths, floats, tables, captions, code, boxes beyond the item parboxes, footnotes, margin notes, bibliography, index, cross-references other than `\pageref{LastPage}`.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `resume` | resume.cls:10-112 | yes | `\documentclass[11pt]{article}` (`class.article`) plus `\usepackage` of `palatino`, `hyperref`, `xcolor`, `fontawesome`, `fancyhdr`, `lastpage` and the colour lines; `etoolbox` is not needed once `\ifblank` is expanded inline |
| `\setlength{\parindent}{0pt}` | resume.cls:13 | yes | `sp.lengths`, one preamble line |
| colours `accentblue`, `emphcolor`, `bodytext` | resume.cls:26-28 | yes | `color.xcolor` `\definecolor` and `\colorlet` |
| `\setfooter{text}` | resume.cls:33-39 | yes | alias for five `hf.fancyhdr` preamble lines; the argument is a string; the emitter writes the expanded lines (the macro is called once, cv-template.tex:12) |
| `\name{text}` | resume.cls:44-46 | yes | body wrapper `\centerline{\Huge text}` |
| `\personalinfo{city}{country}{postcode}{email}{phone}` | resume.cls:49-58 | yes | body wrapper of `sp.ragged`, `font.icons`, `meta.hyperref`, `sp.manual-space`; the `\ifblank{#3}` test (postcode, empty at cv-template.tex:17) is resolved at emit time: the emitter omits the postcode group when the field is empty |
| `\cvsection{title}` | resume.cls:63-69 | yes | body wrapper as in the component map (or `head.titlesec` for an unnumbered `\section*`) |
| `\cveventfull{date}{title}{org}{place}` | resume.cls:81-87 | yes | body wrapper as in the component map; `\ifblank{#4}` (resume.cls:85) resolved at emit time per entry |
| `\cvitemfull{text}` | resume.cls:90-94 | yes | body wrapper `\noindent\makebox[1.3em][c]{icon}\parbox[t]{0.93\linewidth}{text}\par\smallskip` |
| `\cvsubitemfull{text}` | resume.cls:97-101 | yes | body wrapper with a 3mm indent and 0.89\linewidth |
| `\cvrefereefull{...}` (six arguments) | resume.cls:104-112 | yes | body wrapper as in the component map; `\ifblank{#5}` (resume.cls:110) resolved at emit time (phone is empty at cv-template.tex:100, so no phone group is emitted) |
| `\ifblank` conditionals (etoolbox) | resume.cls:17, 52, 85, 110 | yes | each tests whether one macro argument is empty; the emitter knows the argument, so it writes the chosen branch and no conditional reaches the output. Considered: `etoolbox` as a way, rejected (W2 fails: it is programming tools, not declarative parameters), as `sp.xspace` was in lib v4 |

No output routine, no `\@startsection` or `\@maketitle` redefinition, no counters, no `\halign`, no expl3 or Lua. All macros are `\newcommand` with fixed lengths.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
