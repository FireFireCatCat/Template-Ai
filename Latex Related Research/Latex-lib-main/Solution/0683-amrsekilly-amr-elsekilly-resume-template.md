yes

# 0683-amrsekilly-amr-elsekilly-resume-template: Amr Elsekilly one-page resume (hand-laid article CV)

- Unverified: read from the source, not compiled.
- Source: Source/0683-amrsekilly-amr-elsekilly-resume-template/ (origin: https://codeload.github.com/amrsekilly/amr-elsekilly-resume-template/zip/refs/heads/master; licence: not established)
- Kind: cv
- Lib: v5
- Engine: pdfLaTeX-compatible (no `fontspec`; `mathpazo` and T1 only, amr-elsekilly-resume.tex:6-7)
- Look carried by: preamble (an unchanged kernel `article` plus published packages set in the sample's own preamble, amr-elsekilly-resume.tex:1-46; no zip-local class or style)
- Class origin: tex-distribution-unbundled
- Main file: amr-elsekilly-resume.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The whole look is `class.article` with `letterpaper`, six published packages (`geometry`, `hyperref`, `mathpazo`, `fontenc`, `sectsty`, `enumitem`) and a few kernel commands. The three zip-local macros are a string alias, an unused `\def`, and one `\renewenvironment{itemize}` that is a kernel `list` with an empty label and one length, so each reduces to lib ways. There is no TikZ, no artwork and no outside tool. The other files are the author's build leftovers or stray (see Content-opaque).

## Blockers
none

## Class setting
- Class: `class.article` options: `letterpaper` (amr-elsekilly-resume.tex:1); the class is not in the zip, its source was not read
- Class-native vocabulary used: `\section*` (unnumbered, amr-elsekilly-resume.tex:69, 75, 108); `\subsectionfont` is configured at :36 but `\subsection` is never called; no `\maketitle`, no `abstract`, no bibliography

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | amr-elsekilly-resume.tex:1 | `class.article` | option `letterpaper` |
| paper size | amr-elsekilly-resume.tex:1 | `page.class-options` | `letterpaper` |
| page geometry | amr-elsekilly-resume.tex:4, 24-28 | `page.geometry` | `body={6.5in, 8.5in}`, `left=1.0in`, `top=1.25in` |
| text encoding | amr-elsekilly-resume.tex:6 | `font.fontenc-t1` | `fontenc` option `T1`; no `inputenc` line (kernel default) |
| body and math font | amr-elsekilly-resume.tex:7 | `font.palatino` | `\usepackage[sc,osf]{mathpazo}` |
| pdf metadata and links | amr-elsekilly-resume.tex:3, 14-22 | `meta.hyperref` | `colorlinks=true`, `urlcolor=black`, `pdfauthor={\name}`, `pdfkeywords`, `pdftitle`, `pdfsubject`, `pdfpagemode=UseNone` |
| header and footer | amr-elsekilly-resume.tex:30-32 | `hf.pagestyle-kernel` | `\pagestyle{myheadings}`, `\markright{\name}`, `\thispagestyle{empty}` (the first page, and the author's log shows a one-page output, so the running head is set but would not print) |
| heading fonts | amr-elsekilly-resume.tex:34-36 | `head.sectsty` | `\sectionfont{\rmfamily\mdseries\Large}`, `\subsectionfont{\rmfamily\mdseries\large}` |
| heading font switches | amr-elsekilly-resume.tex:35-36 | `mark.kernel` | `\rmfamily`, `\mdseries` (kernel font-switch commands inside the `sectsty` hooks) |
| heading sizes | amr-elsekilly-resume.tex:35-36 | `font.size-commands` | `\Large`, `\large` |
| sectioning in body | amr-elsekilly-resume.tex:69, 75, 108 | `head.kernel` | `\section*{Technologies}`, `\section*{Experience}`, `\section*{Education}` (starred, no numbers) |
| paragraph indent | amr-elsekilly-resume.tex:38 | `sp.lengths` | `\setlength\parindent{0em}` |
| list environment (redefined itemize) | amr-elsekilly-resume.tex:40-46 | `list.kernel` | kernel `list` with empty label `{}`, `\setlength{\leftmargin}{1.5em}` (leftmargin by `sp.lengths`) |
| list package, load only | amr-elsekilly-resume.tex:2 | `list.enumitem` | `\usepackage{enumitem}` with no options and no `\setlist` call in the file |
| list bodies (nested) | amr-elsekilly-resume.tex:71-73, 77-106, 79-83 | `list.kernel` | `\begin{itemize}` nested two deep, `\item` entries (the redefined environment, no label) |
| bullet glyph in sub-items | amr-elsekilly-resume.tex:80-82, 86-89, 93-97, 102 | `math.kernel` | inline `$\bullet$` typed at the start of each nested `\item` (content marker, not a label setting) |
| name line | amr-elsekilly-resume.tex:50 | `font.size-commands` | `{\huge \name}` (no `\maketitle`, the title block is hand-laid) |
| vertical space after name | amr-elsekilly-resume.tex:52 | `sp.manual-space` | `\vspace{0.25in}` |
| address and contact side by side | amr-elsekilly-resume.tex:54-59, 60-67 | `cols.minipage` | two `minipage` of width `0.45\linewidth` |
| address line breaks | amr-elsekilly-resume.tex:55-58, 62-65 | `sp.manual-space` | `\\` line breaks in the address and the table rows |
| contact table | amr-elsekilly-resume.tex:61-66 | `tbl.tabular` | `tabular{ll}`, four rows, no rules |
| links in text | amr-elsekilly-resume.tex:63-65, 78, 84, 91, 99, 100, 104 | `meta.hyperref` | `\href{url}{text}` (the `hyperref` command family; the `mailto:` link at :63 has spaces inside the URL, that is content) |
| monospace link text | amr-elsekilly-resume.tex:63-65, 78, 84, 91, 99, 100, 104 | `mark.kernel` | legacy kernel font switch `\tt` inside each link text |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\name{Amr Elsekilly}` | amr-elsekilly-resume.tex:9 (used at :17, :19, :31, :50) | yes | a string alias: the emitter writes the author name inline at each use; no logic |
| `\def\footerlink{https://amrsekilly.com/}` | amr-elsekilly-resume.tex:12 | yes | never used anywhere in the file (searched `footerlink`: the only hit is the definition); drop it |
| `\renewenvironment{itemize}{\begin{list}{}{\setlength{\leftmargin}{1.5em}}}{\end{list}}` | amr-elsekilly-resume.tex:40-46 | yes | the whole effect is the kernel `list` environment (`list.kernel`) with an empty label and `\leftmargin=1.5em` (`sp.lengths`). The emitter can print it as the same preamble lines, or as `\setlist[itemize]{label={},leftmargin=1.5em}` from `list.enumitem`, which the sample already loads (:2). No counter, no conditional, no output-routine code. |

## Content-opaque
none. Notes on files and characters that are not template:
- amr-elsekilly-resume.tex:78 holds an invisible zero-width space (U+200B) after "Ltd."; the author's own build log records a `inputenc` error for it (amr-elsekilly-resume.log:284). It is a content defect, not a template construct; an emitter would strip it.
- `__latexindent_temp.tex` is one line, the word `Postgres` (line 1): a formatter leftover with no `\documentclass`, not a template. `installation.profile` is a TeX Live install profile (installation.profile:1-30), not a template. `.aux`, `.log`, `.out`, `.fls`, `.fdb_latexmk`, `.synctex.gz` and `.pdf` are the author's build artefacts; none was opened as authority, and nothing was compiled here.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
