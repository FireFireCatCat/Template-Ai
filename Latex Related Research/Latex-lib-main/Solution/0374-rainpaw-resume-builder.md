yes

# 0374-rainpaw-resume-builder: Modern Professional Resume (rainpaw/resume-builder, one-page black-and-white CV on `article`)

- Unverified: read from the source, not compiled.
- Source: Source/0374-rainpaw-resume-builder/ (origin: https://codeload.github.com/rainpaw/resume-builder/zip/refs/heads/main; licence: MIT, LICENSE:1 and data/resume.tex:4)
- Kind: cv
- Lib: v3
- Engine: pdfLaTeX-compatible (no `fontspec`, `unicode-math` or other XeLaTeX/LuaLaTeX-only package in data/resume.tex:13-28; README.md:74 names `pdflatex`, Dockerfile:3 runs `xelatex`)
- Look carried by: preamble (the whole look is the sample's own preamble, data/resume.tex:13-105; the class is the unmodified kernel `article`, no zip-local .cls/.sty)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip; its source was not read)
- Main file: data/resume.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip is one `.tex` on the kernel `article` class. Every component (geometry, empty fancyhdr header and footer, `titlesec` section heading with a rule, `enumitem` lists, `tabular*` entry rows, `hyperref` links, `fontawesome5` icons, hand-laid centred title block) maps to an existing lib way with declarative parameters. All nine zip-local `\newcommand`s are aliases of those ways; the two that would need `xstring` and `scalerel` are never called (the source itself marks one "unused", data/resume.tex:102), so no output depends on them. There is no artwork, and the Dockerfile only wraps a TeX engine call (not an EXTERNAL tool).

## Blockers
none

## Class setting
- Class: `class.article` options: `letterpaper`, `10pt` (data/resume.tex:7)
- Class-native vocabulary used: `\section`, `\section*` (data/resume.tex:119, 215), `center` environment (113, 120), `itemize`/`\item` (76, 95, 217). No `\maketitle`, `\title`, `\author`, `abstract` or `\bibliography` is used.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | data/resume.tex:7 | `class.article` | letterpaper, 10pt |
| paper and size | data/resume.tex:7, 45 | `page.class-options` | letterpaper, 10pt |
| page geometry | data/resume.tex:26, 44-51 | `page.geometry` | paper=letterpaper, left=0.75in, right=0.75in, top=0.6in, bottom=0.6in, columnsep=0.25in (columnsep has no effect: no multicols is used) |
| legacy margin package | data/resume.tex:13 | `page.vmargin` | `fullpage` with option `empty`; loaded before `geometry` (line 26, 44), which sets the margins afterwards |
| header and footer | data/resume.tex:21, 52-55, 57 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}` (all fields empty), `\headrulewidth`=0pt, `\footrulewidth`=0pt, `\headheight`=12pt |
| tabular column gap | data/resume.tex:56 | `sp.lengths` | `\tabcolsep`=0in |
| colours | data/resume.tex:16, 37-41 | `color.xcolor` | options `usenames,dvipsnames`; `\definecolor{...}{HTML}`: primary 000000, secondary 333333, accent 666666, lightgray 999999, sectionline CCCCCC (used: primary 64/69/84, accent 91/104, sectionline 65; secondary and lightgray are never used) |
| language | data/resume.tex:19 | `lang.babel` | english |
| links | data/resume.tex:25, 91, 123-128, 161, 174, 195 | `meta.hyperref` | option `hidelinks`; `\href{url}{text}` |
| url style | data/resume.tex:60 | `meta.url` | `\urlstyle{same}` (hyperref loads `url`; no `\url` is called) |
| section headings | data/resume.tex:14, 63-65, 119, 133, 142, 154, 188, 215 | `head.titlesec` | `\titleformat{\section}` format `\vspace{-4pt}\scshape\raggedright\large\bfseries\color{primary}`, empty label, sep 0em, empty before-code, after-code `[\color{sectionline}\titlerule\vspace{-5pt}]`; no `\titlespacing`; the starred `\section*` at line 215 takes the same format |
| lists | data/resume.tex:18, 68-69, 76, 95, 217 | `list.enumitem` | `\setlist[itemize]{leftmargin=*, label=$\bullet$, itemsep=2pt, topsep=2pt}`; `\setlist[itemize,1]{label=\color{primary}\large\textbullet}`; per-list `[leftmargin=0.15in,label={}]` (76, 217) and `[leftmargin=12pt]` (95) |
| list environment | data/resume.tex:76-77, 95-97, 217-222 | `list.kernel` | `itemize`, `\item` |
| entry rows (employer/date/role/place) | data/resume.tex:80-86, 158-162, 171-175 | `tbl.tabular` | kernel `tabular*` of width `1.0\textwidth`, `[t]`, column spec `l@{\extracolsep{\fill}}r` (or `@{}l@{\extracolsep{\fill}}r@{}`), `\multicolumn{2}{@{}l}{...}` (161, 174) |
| name block | data/resume.tex:113-116 | `sp.ragged` | hand-laid `center` environment (no `\maketitle`); content is the name and city |
| name block type | data/resume.tex:114-115 | `font.size-commands` | `\Huge` (name), `\large` (city); also `\small` (97, 123) |
| contact line | data/resume.tex:120-129 | `font.icons` | `fontawesome5` (line 22): `\faEnvelope`, `\faLinkedin`, `\faGithub`, `\faCode`, `\faHackerrank`, `\faKaggle`; each in `\href` (`meta.hyperref`) with `\raisebox{-0.1\height}` (`sp.manual-space`) |
| text marks | data/resume.tex:83-84, 114, 160, 166, 200 | `mark.kernel` | `\textbf`, `\textit`, `\scshape`, `\bfseries`, `\underline`, `\texttt` |
| manual spacing | data/resume.tex:64-65, 85, 92, 114-115, 134, 143, 155, 169, 181, 200, 216 | `sp.manual-space` | `\vspace{-4pt}`, `{-5pt}`, `{-2pt}`, `{-6pt}`, `{5 pt}`, `{5pt}`; `\\[6pt]`, `\\[8pt]`; `\raisebox`; `\quad` |
| packages loaded, never used | data/resume.tex:15, 17, 20, 23, 24 | `font.icons`, `code.verbatim`, `tbl.tabularx`, `cols.multicol`, `fig.graphicx` | `marvosym` (no glyph command in the body), `verbatim`, `tabularx`, `multicol`, `graphicx`: load-only, no options, no call in the body (a grep finds no `multicols`, `tabularx`, `includegraphics`) |

Not present in the sample: theorems, math, floats and captions, code listings, bibliography, index, cross-references, footnotes, abstract, table of contents, running page numbers (the header and footer are empty).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\resumeSubHeadingListStart` / `End` | data/resume.tex:76-77 | yes | alias pair for `\begin{itemize}[leftmargin=0.15in,label={}]` and `\end{itemize}`: `list.enumitem` |
| `\resumeSubheading[4]` | data/resume.tex:80-86 | yes | `\item` + `tabular*` (`tbl.tabular`, spec `l@{\extracolsep{\fill}}r`, two rows) with `\textbf`, `{\small\bfseries}`, `\textit{\color{primary}}` (`mark.kernel`, `font.size-commands`, `color.xcolor`) + `\vspace{-2pt}` (`sp.manual-space`) |
| `\resumeProjectHeading[2]` | data/resume.tex:88-93 | yes (and never called) | `tabular*` row + `\href` + `\faExternalLinkSquare*` (`tbl.tabular`, `meta.hyperref`, `font.icons`) + `\vspace{-6pt}`; the Projects section writes this out inline instead (158-162, 171-175) |
| `\resumeItemListStart` / `End`, `\resumeItem[1]` | data/resume.tex:95-97 | yes | alias for `itemize[leftmargin=12pt]` and `\item\small{...}` (`list.enumitem`, `font.size-commands`) |
| `\sbullet[1]` | data/resume.tex:100 | moot: never called (grep finds it only at its definition); no output depends on it | would be a `scalerel` `\scalerel*{\textbullet}{#1}` scaled bullet; `scalerel` has no lib way (considered: `scalerel`, not proposed because nothing prints it) |
| `\contactItem[2]` | data/resume.tex:103-105 | moot: never called, and the source labels it "(unused)" (data/resume.tex:102) | uses `\StrBehind` from `xstring` to compute printed text from a URL; `xstring` has no lib way (considered: `xstring`, not proposed: a string-computing utility, not a template component). If it were called it would be `BESPOKE/preamble` |

Nine `\newcommand` in all (76, 77, 80, 88, 95, 96, 97, 100, 103); no `\def`, counter, conditional, `\makeatletter` or zip-local .cls/.sty.

## Content-opaque
none (data/sequenceDiagram.svg is a README diagram of the build workflow, README.md:17; data/resume.tex has no `\includegraphics`)

## Lib changes
- New ways proposed: none. Considered and not proposed: `scalerel` and `xstring` (loaded at data/resume.tex:27-28, used only inside two macros that are never called).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Dockerfile:3 and README.md:65 only run a TeX engine in a container; the GitHub Actions files named at README.md:26-34 are not in the zip. That is a build wrapper, not an EXTERNAL tool that produces the output.
- docs/resume.pdf is a generated output, not read. Whether the installed `fontawesome5` has every glyph named at data/resume.tex:123-128 was not checked.
