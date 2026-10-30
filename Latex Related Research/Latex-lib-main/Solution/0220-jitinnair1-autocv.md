yes

# 0220-jitinnair1-autocv: autoCV (one-page CV on `article`, hand-laid with tabularx and titlesec)

- Unverified: read from the source, not compiled.
- Source: Source/0220-jitinnair1-autocv/ (origin: https://codeload.github.com/jitinnair1/autoCV/zip/refs/heads/main; licence: not established in the manifest; cv.tex:2-19 carries an MIT notice, Copyright 2021 Jitin Nair)
- Kind: cv
- Lib: v2
- Engine: pdfLaTeX-compatible (no engine-specific package is active: the `fontspec` block is commented out, cv.tex:35-45; `fontawesome5` is the only font package, cv.tex:95; `biblatex` keeps its default biber backend, cv.tex:85)
- Look carried by: preamble (the class is plain `article`; the look is the sample's own preamble: `geometry`, one `titlesec` heading format, `tabularx` column types and two `\newenvironment` wrappers, cv.tex:29-122)
- Class origin: tex-distribution-unbundled (kernel `article`; the zip holds no class)
- Main file: cv.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip has no .cls, .sty, .def, .cfg, .clo, .bbx or .cbx; Makefile, README.md, citations.bib, index.html, CNAME and .github/workflows/build.yml were also read)

## Verdict
The look is `article` plus a 217-line `cv.tex` preamble and body that use only published packages (`geometry`, `titlesec`, `tabularx`, `enumitem`, `fontawesome5`, `hyperref`, `biblatex`, `xcolor`). The only zip-local code is a column type, one unused length and two `\newenvironment` wrappers, and each reduces to `tbl.tabularx`, `box.minipage` and `list.enumitem` with parameters. There is no artwork and no zip-local class or style. The Makefile and the GitHub workflow only call `latexmk` on `cv.tex` (Makefile:4, .github/workflows/build.yml:19-22) and generate no `.tex`, so they are not an `EXTERNAL` blocker; index.html and CNAME are web-hosting files with no look.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `12pt` (cv.tex:29)
- Class-native vocabulary used: `\section` (cv.tex:158,162,175,185,199,208) restyled by `titlesec`. Not used: `\maketitle`, `abstract`, `\chapter`. `\today` (cv.tex:215) is a kernel date macro, treated as text content.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | cv.tex:29 | `class.article` | a4paper, 12pt |
| paper and base size | cv.tex:29 | `page.class-options` | a4paper, 12pt |
| page geometry | cv.tex:57 | `page.geometry` | scale=0.9 (no other keys) |
| page style | cv.tex:132 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no header, footer or number) |
| paragraph spacing | cv.tex:51 | `sp.parskip-pkg` | package defaults (the line carries a trailing tab only) |
| main text font | cv.tex:35-45 | none needed | no font package is loaded, so the class default stays; the `fontspec` / `\setmainfont` (Fontin) block is commented out |
| font sizes | cv.tex:81,145,187,210,215 | `font.size-commands` | `\Large` (section format), `\Huge` (name), `\normalsize` (GPA, skill text), `\footnotesize` (last-updated line) |
| text shapes | cv.tex:81,105,114,178,187 | `mark.kernel` | `\scshape` (in the section format), `\textbf` (job title, project, institution) |
| icons | cv.tex:95,146-150 | `font.icons` | `fontawesome5`, no options; `\faGithub` `\faLinkedin` `\faGlobe` `\faEnvelope` `\faMobile` |
| colour packages | cv.tex:54,56 | `color.color`, `color.xcolor` | `\RequirePackage{color}`; `xcolor` with `usenames,dvipsnames` |
| link colour | cv.tex:89 | `color.xcolor` | `\definecolor{linkcolour}{rgb}{0,0.2,0.6}` |
| hyperlinks | cv.tex:88-90 | `meta.hyperref` | package options `unicode`, `draft=false`; `\hypersetup{colorlinks,breaklinks,urlcolor=linkcolour,linkcolor=linkcolour}` |
| `\href` in header, summary, project | cv.tex:146-150,159,178 | `meta.hyperref` | `\href{https://...}{...}`, `mailto:`, `tel:` targets |
| url package | cv.tex:50 | `meta.url` | loaded before `hyperref`, no options |
| section headings | cv.tex:75,81-82 | `head.titlesec` | `\titleformat{\section}{\Large\scshape\raggedright}{}{0em}{}[\titlerule]` (label empty, sep 0em, before-code empty, after-code `\titlerule`); `\titlespacing{\section}{0pt}{10pt}{10pt}` |
| heading alignment | cv.tex:81 | `sp.ragged` | `\raggedright` inside the heading format |
| CV header block (name and contact line) | cv.tex:144-151 | `tbl.tabularx` | `tabularx{\linewidth}{@{} C @{}}`, one centred cell; `\Huge{Your Name} \\[7.5pt]` then five `\href` items joined by `\ $|$ \ ` (separator is text content) |
| header spacing and icon lift | cv.tex:145-150 | `sp.manual-space` | `\\[7.5pt]`; `\raisebox{-0.05\height}` before each icon (the `\height` form is graphicx's `\raisebox`, see the next row) |
| graphics package | cv.tex:55 | `fig.graphicx` | loaded with `\RequirePackage{graphicx}`; no `\includegraphics` or figure anywhere; its extended `\raisebox` is what cv.tex:146-150 use |
| centred column type | cv.tex:66 | `tbl.tabular` | `\newcolumntype{C}{>{\centering\arraybackslash}X}` (array's `\newcolumntype`; `\centering` is `sp.ragged`) |
| tabularx package (loaded twice) | cv.tex:60,70 | `tbl.tabularx` | no options |
| job entry, short (header row plus text) | cv.tex:102-109,164-166 | `tbl.tabularx` | `tabularx{\linewidth}{@{}l X r@{}}`, row `\textbf{#1} & \hfill & #2 \\[3.75pt]`; `\hfill`, `\\[3.75pt]` are `sp.manual-space` |
| job entry, long (header row plus bullets) | cv.tex:111-122,169-172 | `tbl.tabularx`, `box.minipage`, `list.enumitem` | same header table as above, then `minipage[t]{\linewidth}` holding `itemize[nosep,after=\strut,leftmargin=1em,itemsep=3pt,label=--]` |
| projects table | cv.tex:177-180 | `tbl.tabularx`, `tbl.tabular` | `tabularx{\linewidth}{ @{}l r@{} }`, row `\textbf{..} & \hfill \href{..}{..} \\[3.75pt]`, then `\multicolumn{2}{@{}X@{}}{...}` (kernel `\multicolumn`) |
| education table | cv.tex:186-194 | `tbl.tabularx` | `tabularx{\linewidth}{@{}l X@{}}`, four rows, `\hfill` and `\normalsize` inside the X cell, `\textbf` on institutions |
| skills table | cv.tex:209-212 | `tbl.tabularx` | `tabularx{\linewidth}{@{}l X@{}}`, two rows, `\normalsize{...}` in the X cell |
| bibliography package | cv.tex:85,91 | `bib.biblatex-biber` | `biblatex` options `style=authoryear`, `sorting=ynt`, `maxbibnames=2` (backend not set, default biber); `\addbibresource{citations.bib}` |
| bibliography spacing | cv.tex:92 | `bib.biblatex-biber` | `\setlength\bibitemsep{1em}` (biblatex length) |
| publications list | cv.tex:200-203 | `bib.biblatex-biber`, `bib.multi` | `\begin{refsection}[citations.bib]`, `\nocite{*}`, `\printbibliography[heading=none]` (the refsection takes its own resource file) |
| closing line | cv.tex:214-215 | `sp.manual-space`, `sp.ragged`, `font.size-commands` | `\vfill`; `\center{\footnotesize Last updated: \today}` (centred block; see Bespoke code for the unclosed `\center`) |
| loaded, never used: supertabular | cv.tex:69 | `tbl.longtable` | `\usepackage{supertabular}`; no `supertabular` environment in the body (grep) |
| loaded, never used: multicol | cv.tex:76 | `cols.multicol` | `\usepackage{multicol}`; no `multicols` in the body (grep) |
| loaded, never used: multirow | cv.tex:77 | `tbl.multirow` | `\usepackage{multirow}`; no `\multirow` in the body (grep) |
| declared, never used: `\fullcollw` | cv.tex:71-72 | `sp.lengths` | `\newlength{\fullcollw}`, `\setlength{\fullcollw}{0.47\textwidth}`; the name appears only on these two lines (grep) |
| debug frame (inactive) | cv.tex:97-98 | none needed | `\usepackage{showframe}` is commented out |
| build driver, not a template component | Makefile:4,7; .github/workflows/build.yml:18-22 | none needed | `latexmk -pdf cv.tex`; the clean target names `.bcf` and `.run.xml` (Makefile:7), the biblatex/biber files; no `.tex` is generated |

Not mapped, because the zip has none: abstract, table of contents, numbering and counters, footnotes, margin notes, maths and theorems, figures and captions, code, boxes, index, language, cross-references, running headers.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcolumntype{C}{>{\centering\arraybackslash}X}` | cv.tex:66 | yes | array's own declarative command; the emitter writes the same `\newcolumntype` line, or inlines the column spec `>{\centering\arraybackslash}X` at cv.tex:144. Ways: `tbl.tabular`, `tbl.tabularx`, `sp.ragged` |
| `\newlength{\fullcollw}` + `\setlength` | cv.tex:71-72 | yes | never referenced; omit, or `sp.lengths` with value 0.47\textwidth |
| `jobshort{#1}{#2}` environment | cv.tex:102-109 | yes | alias for one `tabularx{\linewidth}{@{}l X r@{}}` row `\textbf{#1} & \hfill & #2 \\[3.75pt]` followed by the body text; end code is empty. Ways: `tbl.tabularx`, `mark.kernel`, `sp.manual-space` |
| `joblong{#1}{#2}` environment | cv.tex:111-122 | yes | the same header table, then `minipage[t]{\linewidth}` around `itemize[nosep,after=\strut,leftmargin=1em,itemsep=3pt,label=--]`; the end code closes both. Ways: `tbl.tabularx`, `box.minipage`, `list.enumitem` (enumitem keys are options, so W2 holds). No counters, conditionals or `\def` logic |
| `\center{...}` used as a command, never closed | cv.tex:215 | yes (not a definition) | kernel misuse of the `center` environment's opening macro; the emitter writes `\begin{center}...\end{center}` (`sp.ragged`). Recorded because the output of the original may differ slightly from a closed environment; no look is claimed |

## Content-opaque
none (citations.bib holds two dummy `@article` entries, content; the icons are font glyphs, not drawings)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Not used: `cv.entries` covers the entry commands of a CV class (moderncv, altacv, awesome-cv family); this zip loads no CV class and builds its entries from `tabularx`, so the ways above carry it.
- Notes: no text addressed to an AI was found in any file of the zip. The README's setup steps (README.md:12-21) and the workflow describe deployment only and were not followed.
