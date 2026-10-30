yes

# 0321-arubertoson-resume-and-cover-letter: Arubertoson Resume and Cover Letter

- Unverified: read from the source, not compiled.
- Source: Source/0321-arubertoson-resume-and-cover-letter/ (origin: https://latextemplates.com/downloads/arubertoson-resume-cover-letter.zip; licence: MIT)
- Kind: cv
- Lib: v3
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (no class or style file in the zip; each sample is `article` plus a one-line preamble of published packages)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: cover_letter.tex, a matching letter)
- Read: main yes, zip-local classes and styles none present

Citation note: `main.tex` and `cover_letter.tex` are each a single physical line (2130 and 1662 bytes, no CR), so every citation below is line 1; the quoted command locates the claim inside that line.

## Verdict
Both samples are kernel `article` with a short preamble of published packages (`geometry`, `fontenc`, `lmodern`, `xcolor`, `enumitem`, `hyperref`, `titlesec`) and plain kernel body commands. The zip has no `.cls`, `.sty` or other zip-local file. The only bespoke item is one `\newcommand` alias, `\entry`, which is a composition of `\textbf`, `\textit`, `\hfill` and `\\`, so it reduces to lib ways. There is no artwork, no external tool and no unmapped component. The manifest hint says `letter`, but the main sample is the resume, so Kind is `cv`; the second sample is a hand-set letter on `article` (no letter class), not a `ltr.opening` use.

## Blockers
none

## Class setting
- Class: `class.article` options: `10pt` (main.tex:1 `\documentclass[10pt]{article}`), `11pt` (cover_letter.tex:1 `\documentclass[11pt]{article}`). Source not read: the class ships with the TeX distribution.
- Class-native vocabulary used: none beyond kernel `center`, `itemize`, `\section*`, `\par`, `\today`; no `\maketitle`, no `abstract`, no `\bibliography`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 `\documentclass[10pt]{article}`; cover_letter.tex:1 `\documentclass[11pt]{article}` | `class.article` | see Class setting |
| base font size | main.tex:1 `[10pt]`; cover_letter.tex:1 `[11pt]` | `page.class-options` | 10pt (resume), 11pt (letter) |
| page geometry | main.tex:1 `\usepackage[margin=0.62in]{geometry}`; cover_letter.tex:1 `\usepackage[margin=0.85in]{geometry}` | `page.geometry` | margin=0.62in (resume); margin=0.85in (letter) |
| encoding | main.tex:1 `\usepackage[T1]{fontenc}`; cover_letter.tex:1 same | `font.fontenc-t1` | T1; the one non-ASCII character, a curly apostrophe in "user’s" (cover_letter.tex:1), is UTF-8 text handled by the default input encoding |
| text face | main.tex:1 `\usepackage{lmodern}`; cover_letter.tex:1 same | `font.lmodern` | no options |
| accent colour | main.tex:1 `\usepackage{xcolor}` and `\definecolor{accent}{HTML}{7A3E48}`; cover_letter.tex:1 same two | `color.xcolor` | name=accent, model=HTML, value=7A3E48 (same in both files) |
| header and footer | main.tex:1 `\pagestyle{empty}`; cover_letter.tex:1 same | `hf.pagestyle-kernel` | style=empty |
| paragraph indent | main.tex:1 `\setlength{\parindent}{0pt}`; cover_letter.tex:1 same | `sp.lengths` | \parindent=0pt |
| section command | main.tex:1 `\section*{Summary}`, `\section*{Experience}`, `\section*{Projects and skills}`, `\section*{Education}` | `head.kernel` | starred (unnumbered) `\section`, four uses |
| section look (rule under title) | main.tex:1 `\titleformat{\section}{\large\bfseries\color{accent}}{}{0pt}{}[\color{accent}\titlerule]` | `head.titlesec` | format=`\large\bfseries\color{accent}`; label empty; sep=0pt; before empty; after=`\color{accent}\titlerule` |
| section spacing | main.tex:1 `\titlespacing*{\section}{0pt}{8pt}{4pt}` | `head.titlesec` | left=0pt, before=8pt, after=4pt |
| bullet lists | main.tex:1 `\usepackage{enumitem}` and `\setlist[itemize]{leftmargin=1.2em,itemsep=2pt,topsep=2pt}`; `\begin{itemize}` (two lists) | `list.kernel` with `list.enumitem` | leftmargin=1.2em, itemsep=2pt, topsep=2pt |
| centred title block | main.tex:1 `\begin{center}{\Huge\bfseries Samira Lee}\\[3pt]Product-minded software engineer\\[3pt]\href{...}{...} \quad ... \end{center}` | `sp.ragged` (the kernel `center` environment) with `font.size-commands` and `mark.kernel` | `\Huge`, `\bfseries`; `\\[3pt]` line gaps (see spacing row) |
| entry line (job, project, degree) | main.tex:1 `\newcommand{\entry}[4]{\textbf{#1}\hfill #2\\\textit{#3}\hfill #4\\}`; four calls `\entry{Northstar Tools}{2022--Present}{...}{...}` etc. | `mark.kernel` and `sp.manual-space` (via the reducible alias, see Bespoke code) | bold first field, `\hfill`, italic third field, `\hfill`, `\\` |
| skills lines | main.tex:1 `\textbf{Languages:} ...\\\textbf{Practice:} ...` | `mark.kernel` with `sp.manual-space` | bold run-in label, `\\` break |
| manual spacing in body | main.tex:1 `\\[3pt]`, `\quad`, `\par\vspace{3pt}`; cover_letter.tex:1 `\vspace{2em}`, `\vspace{1.5em}`, `\vspace{1em}`, `\vspace{0.8em}`, `\vspace{1.2em}`, `\\[1.5em]`, `\quad` | `sp.manual-space` | lengths as quoted |
| links | main.tex:1 `\usepackage[hidelinks]{hyperref}` | `meta.hyperref` | hidelinks |
| mailto and url links | main.tex:1 `\href{mailto:samira@example.org}{samira@example.org}`, `\href{https://example.org}{example.org/samira}`; cover_letter.tex:1 `\href{mailto:...}{...}` | `xref.hyperref` | `\href{target}{text}`; the target and text are content |
| letter sender block | cover_letter.tex:1 `{\Large\bfseries\color{accent}Samira Lee}\\London, UK \quad \textbar{} \quad \href{mailto:...}{...} \quad \textbar{} \quad +44 ...` (the source writes a bare vertical bar, shown here as `\textbar`) | `font.size-commands`, `mark.kernel`, `color.xcolor` | `\Large`, `\bfseries`, `\color{accent}`; `\quad` gaps around the bar via `sp.manual-space` |
| letter date | cover_letter.tex:1 `\par\today\par` | `front.maketitle` | kernel `\today` (the macro `\date` defaults to); the printed date is generated text |
| letter recipient, subject, salutation, closing | cover_letter.tex:1 `Hiring team\\Northstar Tools\\London`, `\textbf{Re: Software Engineer}`, `Dear hiring team,`, `Kind regards,\\[1.5em]Samira Lee` | `mark.kernel` with `sp.manual-space` | bold subject; plain paragraphs separated by `\par\vspace{...}`; no `letter` class, so `ltr.opening` is not used |
| letter body | cover_letter.tex:1 three body paragraphs; `\par\vspace{0.8em}` after the salutation and between paragraphs, `\par\vspace{1.2em}` before the closing | `sp.manual-space` | gaps 0.8em (three times), then 1.2em; paragraph text is content |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\entry}[4]{\textbf{#1}\hfill #2\\\textit{#3}\hfill #4\\}` | main.tex:1 (preamble definition; used four times in the body) | yes | A pure alias of kernel commands: `mark.kernel` (`\textbf`, `\textit`) and `sp.manual-space` (`\hfill`, `\\`). An emitter writes the expanded text at each call, or keeps the one-line alias; there is no counter, conditional or box logic. |

No other `\newcommand`, `\def`, `\let`, environment, counter or conditional in either sample (grep of `\newcommand|\renewcommand|\def|\let|\newenvironment|\newcounter|\newif` finds only `\entry`). No `\input`, `\include`, `write18` or shell-escape use.

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered and not used: `ltr.opening` (the letter sample calls no letter-class command; it is hand-set on `article`), `cv.entries` (the sample defines no CV class and `\entry` is a plain alias), `front.datetime` (the date is the kernel `\today`, not the `datetime` package).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- README.md:1-15 is a short build note (`pdflatex main.tex`, `pdflatex cover_letter.tex`, README.md:10-11) with the MIT statement (README.md:14); plain pdfLaTeX, no external tool. It holds no text addressed to an AI.
- The zip ships no fonts or images, and none are referenced.
