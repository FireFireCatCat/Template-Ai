yes

# 0177-danielteles-ats-friendly-latex-cv: ATS-friendly single-column CV (danielteles)

- Unverified: read from the source, not compiled.
- Source: Source/0177-danielteles-ats-friendly-latex-cv/ (origin: https://codeload.github.com/danielteles/ats-friendly-latex-cv/zip/refs/heads/main; licence: CC BY-NC-SA 4.0 per LICENSE:3 and README.md:121; the manifest says NOASSERTION)
- Kind: cv
- Lib: v3
- Engine: pdfLaTeX-compatible (`cmap`, `inputenc`, `fontenc` T1 and the `\pdfgentounicode` primitive are pdfTeX features; the `\ifdefined` guard at pt-br/main.tex:41 only skips the glyphtounicode lines on other engines)
- Look carried by: preamble (kernel `article` plus nine published packages and five zip-local `\newcommand`s in the sample's own preamble, pt-br/main.tex:1-79; no zip-local class or style file exists)
- Class origin: tex-distribution-unbundled
- Main file: pt-br/main.tex (other samples: en/main.tex, same preamble line for line; it differs only in the strings at en/main.tex:33, 35, 75 and in body text)
- Read: main yes, zip-local classes and styles none present

## Verdict
The look is a plain single-column CV built on kernel `article` with published packages (`geometry`, `titlesec`, `enumitem`, `xcolor`, `hyperref`, `lmodern`, `cmap`) and a handful of `\newcommand`/`\newlength` aliases that expand into kernel commands. Every alias is reducible to lib ways (see Bespoke code), there is no artwork, no external tool and no zip-local class. The one component with no lib home is the `cmap` load-only package, which passes W1 to W4 and is proposed as `meta.glyphtounicode`. Verdict `yes`; both language samples share one preamble, so the pt-br and en files are the same template.

## Blockers
none

## Class setting
- Class: `class.article` options: `letterpaper`, `11pt` (pt-br/main.tex:1). Kernel class, source not read (ships with the TeX distribution).
- Class-native vocabulary used: `\section` (through the `\cvsection` alias, pt-br/main.tex:54), `itemize` (pt-br/main.tex:126). Not used: `\maketitle`, `abstract`, `\chapter`, `\appendix`, `thebibliography`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | pt-br/main.tex:1 | `class.article` | see Class setting |
| paper and base size | pt-br/main.tex:1 | `page.class-options` | `letterpaper`, `11pt` |
| input and font encoding | pt-br/main.tex:5-6 | `font.fontenc-t1` | `\usepackage[utf8]{inputenc}`, `\usepackage[T1]{fontenc}` |
| text-extraction CMaps | pt-br/main.tex:4 | `meta.glyphtounicode` | `\usepackage{cmap}`, no options; must come before `fontenc` (comment at line 4) |
| ToUnicode map for ligatures | pt-br/main.tex:41-44 | `meta.glyphtounicode` | `\input{glyphtounicode}`, `\pdfgentounicode=1`, wrapped in `\ifdefined\pdfgentounicode` |
| page geometry | pt-br/main.tex:7 | `page.geometry` | `margin=0.6in` |
| base font family | pt-br/main.tex:11-12 | `font.lmodern`, `font.family-default` | `lmodern`; `\renewcommand{\familydefault}{\sfdefault}` (Latin Modern sans as body face) |
| colour definition | pt-br/main.tex:10, 25 | `color.xcolor` | `\definecolor{accent}{HTML}{1F4E79}` |
| page-fill behaviour | pt-br/main.tex:15 | `pg.flush` | `\raggedbottom` |
| widow and club lines | pt-br/main.tex:17-18 | `sp.penalties` | `\clubpenalty=10000`, `\widowpenalty=10000` |
| paragraph indent | pt-br/main.tex:59 | `sp.lengths` | `\setlength{\parindent}{0pt}` |
| section call | pt-br/main.tex:54, 103, 110, 123, 184, 199 | `head.kernel` | `\section{#1}`, reached through the `\cvsection` alias |
| section look | pt-br/main.tex:47-50 | `head.titlesec` | `\titleformat{\section}{...}{}{0em}{}[{\color{accent}\titlerule[0.8pt]}]`; `\titlespacing{\section}{0pt}{10pt}{6pt}`; empty label, so no section number prints |
| heading format fields | pt-br/main.tex:48 | `sp.ragged`, `font.size-commands`, `mark.kernel`, `color.xcolor` | `\raggedright`, `\large`, `\bfseries`, `\color{accent}` |
| bullet list shape | pt-br/main.tex:57 | `list.enumitem` | `\setlist[itemize]{leftmargin=0.18in, labelsep=5pt, itemsep=2pt, parsep=0pt, topsep=3pt}` |
| bullet lists | pt-br/main.tex:126-132, 138-147, 153-160, 166-170, 176-179, 200-203 | `list.kernel` | `itemize`, `\small` as first command inside each list |
| page style | pt-br/main.tex:82 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no header, no footer, no page number) |
| PDF metadata and link colours | pt-br/main.tex:31-37 | `meta.hyperref` | `colorlinks=true,linkcolor=accent,urlcolor=accent`; `\hypersetup{pdftitle,pdfauthor,pdflang={pt-BR},pdfdisplaydoctitle=true}` (en: `pdflang={en-US}`, en/main.tex:35) |
| header block (name, role, contacts) | pt-br/main.tex:87-98 | `sp.ragged`, `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.manual-space`, `meta.hyperref` | `center` environment; `\huge`, `\normalsize`, `\small`; `\textbf`; `\color{accent}`; `\\`, `\vspace{2pt}`, `\vspace{4pt}`, `\\[3pt]`, `\quad`; `\href{tel:...}`, `\href{mailto:...}`, `\href{https://...}` (hyperref commands, same package as the options row) |
| vertical rhythm | pt-br/main.tex:28-29, 100, 107, 120, 135, 188, 196 (and the other `\vspace` lines between entries) | `sp.manual-space` | `\vspace{\cvblocksep}` (4pt), `\vspace{\cventrysep}` (6pt); the two lengths are `\newlength` aliases |
| paragraph size in sections | pt-br/main.tex:104, 111 | `font.size-commands` | `\small` set after the section call and left on until the next group boundary |
| entry head (role, dates, company, place) | pt-br/main.tex:67-72, 125, 137, 186-194 | `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.manual-space`, `pg.break` | line 1: `\noindent\normalsize\textbf{#1}\hfill\small\textbf{#4}\par`; line 2: `\normalsize\textit{\textcolor{accent}{#2}}\hfill\small\textit{#3}\par`; `\nopagebreak[4]` after each line (kernel sibling of `\pagebreak[n]`) |
| key-technologies line | pt-br/main.tex:75, 133, 148, 161, 171 | `font.size-commands`, `mark.kernel` | `\small\textbf{Tecnologias-Chave:} #1\par` (en: "Key Technologies:", en/main.tex:75) |
| skills rows | pt-br/main.tex:79, 112-118 | `mark.kernel`, `sp.manual-space`, `sp.lengths` | `\noindent\textbf{#1:} #2\par\vspace{2pt}`; `\noindent` has no effect once `\parindent` is 0pt (line 59) |
| certifications lines | pt-br/main.tex:201-202 | `list.kernel`, `mark.kernel`, `sp.manual-space` | `\item \textbf{...} -- ... \hfill dates` |
| language | pt-br/main.tex:35 | `meta.hyperref` | only `pdflang={pt-BR}`; no `babel` or `polyglossia` is loaded in either sample, so there is no language component beyond the PDF tag |
| bibliography, index, floats, tables, maths, theorems, code, boxes, notes | none | none | the sample uses none of these |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\candidatename` | pt-br/main.tex:23, 33-34, 88 | yes | A string alias for the candidate name; the emitter writes the name inline in `pdftitle`, `pdfauthor` and the header (content) |
| `\cventrysep`, `\cvblocksep` | pt-br/main.tex:28-29 | yes | `\newlength` plus `\setlength` aliases; inline `6pt` and `4pt` into `\vspace` (`sp.manual-space`) |
| `\cvsection` | pt-br/main.tex:54 | yes | `\newcommand{\cvsection}[1]{\section{#1}}`: plain alias of `\section` (`head.kernel`) |
| `\cventry` | pt-br/main.tex:67-72 | yes | Four-argument macro whose whole body is kernel commands: `\noindent`, `\normalsize`/`\small`, `\textbf`, `\textit`, `\textcolor`, `\hfill`, `\par`, `\nopagebreak[4]`. Expand it per entry or print the `\newcommand` in the preamble. It shares its name with moderncv's `\cventry` but is not that class's macro, so `cv.entries` is not used |
| `\keytech` | pt-br/main.tex:75 | yes | `\small\textbf{label} #1\par`: font size and bold wrapper |
| `\skillrow` | pt-br/main.tex:79 | yes | `\noindent\textbf{#1:} #2\par\vspace{2pt}`: bold wrapper plus a 2pt `\vspace` |
| `\ifdefined\pdfgentounicode ... \fi` | pt-br/main.tex:41-44 | yes | An engine guard, not layout logic: it decides only whether the two glyphtounicode lines run. For a pdfTeX target the emitter writes `\input{glyphtounicode}` and `\pdfgentounicode=1` unconditionally (`meta.glyphtounicode`) |

## Content-opaque
none (en/main.pdf and pt-br/main.pdf are compiled outputs, binary, not read; en/wolfresume-parser-report.txt:1-14 is a third-party parser report on the en PDF and says nothing about the template's construction)

## Lib changes
- New ways proposed: `meta.glyphtounicode` the `cmap` package (CTAN, LPPL, in TeX Live; ctan.org/pkg/cmap: "Make PDF files searchable and copyable"), pdfLaTeX. W1: published on CTAN. W2: a load-only package with no documented options. W3: serves any document that uses 8-bit font encodings, not one template. W4: one preamble line, `\usepackage{cmap}`, placed before `fontenc`. Why not `meta.glyphtounicode`: that line is a pdfTeX primitive and a file (`\input{glyphtounicode}`, `\pdfgentounicode`), while `cmap` is a package that supplies CMap resources for the T1 font encodings; both have the same goal (text copies and parses cleanly). This template loads both (pt-br/main.tex:4 and 41-44), so a consolidator may fold `cmap` into `meta.glyphtounicode` as "the package is the parameter" instead of keeping a separate line.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
