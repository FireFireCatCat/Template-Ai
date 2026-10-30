yes

# 0865-shaiq-dev-resume: shaiq-dev/resume (one-page developer resume)

- Unverified: read from the source, not compiled.
- Source: Source/0865-shaiq-dev-resume/ (origin: https://codeload.github.com/shaiq-dev/resume/zip/refs/heads/main; licence: MIT, README.md:67-69 and the manifest row)
- Kind: cv
- Lib: v6
- Engine: pdfLaTeX-compatible (build.sh:15 runs `pdflatex`; `[pdftex]` driver at src/resume.tex:10; no fontspec, no Lua, no shell escape)
- Look carried by: preamble (the only TeX file is src/resume.tex; the look is `article` plus the preamble at src/resume.tex:3-73: margins, `titlesec` section rule, `enumitem` lists, `\newcommand` entry wrappers, an `xwatermark` TEMPLATE watermark)
- Class origin: tex-distribution-unbundled
- Main file: src/resume.tex (other samples: none)
- Read: main yes (all 164 lines), zip-local classes and styles none present (the zip has no `.cls`, `.sty`, `.def`, `.cfg` or other TeX support file)

## Verdict
Yes. The class is the kernel `article` and every preamble line loads a published package or sets a kernel or package parameter. The nine zip-local definitions (eight `\newcommand` wrappers and one `\renewcommand` of a list label) are plain wrappers over `itemize`, `tabular*`, font switches and `\vspace`, with no counters, conditionals, `\def`s or output-routine code, and reduce by inline expansion. There is no TikZ or other artwork, and the Docker, GitHub Actions, R2 and Worker files are a deployment pipeline around the PDF, not part of the template; the `__VERSION__` placeholder that `build.sh` substitutes does not occur in `src/resume.tex`, so the sample compiles on its own.

## Blockers
none

## Class setting
- Class: `class.article` options: `letterpaper`, `11pt` (src/resume.tex:1)
- Class-native vocabulary used: none. The sample never calls `\title`, `\author`, `\maketitle`, `abstract` or `thebibliography`; its header block is a hand-set `tabular*` (src/resume.tex:79-82). Only `\section` (src/resume.tex:85, 94, 133, 146) and `itemize` are used.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | src/resume.tex:1 | `class.article` | `letterpaper,11pt` |
| paper and point size | src/resume.tex:1 | `page.class-options` | `letterpaper`, `11pt` |
| base page margins | src/resume.tex:4 | `page.vmargin` | `\usepackage[empty]{fullpage}`; its page-style option `empty` is overridden by the later `\pagestyle{fancy}` (src/resume.tex:18). The fullpage source was not read, so its base margin values are not recorded |
| margin adjustment | src/resume.tex:25-29 | `page.setlength` | `\addtolength`: `\oddsidemargin` -0.375in, `\evensidemargin` -0.375in, `\textwidth` +1in, `\topmargin` -.5in, `\textheight` +1.0in; emitted after the fullpage line because they add to its values |
| header and footer | src/resume.tex:11, 18-22 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\fancyfoot{}`, `\headrulewidth` 0pt, `\footrulewidth` 0pt (no header, footer, page number or rule) |
| page-bottom flow | src/resume.tex:33 | `pg.flush` | `\raggedbottom` |
| paragraph shape | src/resume.tex:34 | `sp.ragged` | `\raggedright` globally |
| table column padding | src/resume.tex:35 | `sp.lengths` | `\setlength{\tabcolsep}{0in}` (raw kernel length parameter) |
| section headings | src/resume.tex:5, 38-40 | `head.titlesec` | `\titleformat{\section}` format `\vspace{-4pt}\scshape\raggedright\large`, label `{}`, sep `0em`, before-code `{}`, after-code `[\color{black}\titlerule \vspace{-5pt}]`; no `\titlespacing` |
| section commands | src/resume.tex:85, 94, 133, 146 | `head.kernel` | four `\section{..}` (label field is empty, so no number prints) |
| heading format pieces | src/resume.tex:39-40 | `mark.kernel`, `font.size-commands`, `sp.manual-space`, `sp.ragged`, `color.color` | `\scshape`; `\large`; `\vspace{-4pt}`, `\vspace{-5pt}`; `\raggedright`; `\color{black}` |
| colour packages | src/resume.tex:7, 13 | `color.color`, `color.xcolor` | `\usepackage[usenames,dvipsnames]{color}`; `\usepackage{xcolor}` (no options) |
| watermark | src/resume.tex:12, 16 | `bg.watermark` | `\usepackage[printwatermark]{xwatermark}`; `\newwatermark[allpages,color=red!35,angle=45,scale=3.5,xpos=0,ypos=0]{TEMPLATE}` (a diagonal pale-red word on every page; the comment at :15 says to remove it when the template is used). The xwatermark source was not read; W1 rests on the lib line |
| watermark colour | src/resume.tex:16 | `color.xcolor` | `red!35` tint expression |
| header block (name and contacts) | src/resume.tex:79-82 | `tbl.tabular`, `mark.kernel`, `font.size-commands`, `xref.hyperref` | kernel `tabular*` width `\textwidth`, column spec `l@{\extracolsep{\fill}}r`; `\textbf{\href{..}{\Large ..}}`; two rows ending `\\`; not `front.maketitle` (no `\maketitle`) |
| entry rows | src/resume.tex:55-61 | `tbl.tabular`, `mark.kernel`, `font.size-commands`, `sp.manual-space` | `\resumeSubheading`: `\vspace{-1pt}\item` then `tabular*` width `0.97\textwidth`, spec `l@{\extracolsep{\fill}}r`, rows `\textbf{#1} & #2 \\` and `\textit{\small#3} & \textit{\small #4} \\`, then `\vspace{-5pt}` |
| bullet item | src/resume.tex:43-47, 49-53 | `list.kernel`, `font.size-commands`, `mark.kernel`, `sp.manual-space` | `\item\small{...}`; `\resumeItem` bolds the lead `\textbf{#1}{: #2 ...}`; `\vspace{-2pt}` after the text |
| entry list | src/resume.tex:9, 67, 69 | `list.enumitem` | `\begin{itemize}[leftmargin=*]` ... `\end{itemize}` (used at :86-90, 95-130, 134-143, 147-152) |
| bullet list | src/resume.tex:71, 73 | `list.kernel`, `sp.manual-space` | plain `itemize`, nested inside the entry list (:99-110, :115-129); closed by `\end{itemize}\vspace{-5pt}` |
| bullet label, level 2 | src/resume.tex:65 | `list.kernel` | `\renewcommand{\labelitemii}{$\circ$}`; used by the nested bullet lists at :99-110 and :115-129; the skills list (:147-152) is level 1 and keeps the default bullet |
| project item | src/resume.tex:63, 135-142 | `list.kernel`, `sp.manual-space`, `mark.kernel` | `\resumeSubItem` = `\resumeItem` + `\vspace{-4pt}`; `\\` break and `\textbf{Technologies}` inside the text |
| links | src/resume.tex:10, 80-81, 138, 142 | `meta.hyperref`, `xref.hyperref`, `color.xcolor` | `\usepackage[pdftex]{hyperref}` (driver option only, no `\hypersetup`); `\href{..}{..}`; `\textcolor{blue}{\href{..}{..}}` on the project links |
| URL style | src/resume.tex:31 | `meta.url` | `\urlstyle{same}` |
| version footer | src/resume.tex:154-160 | `sp.manual-space`, `font.size-commands` | `\vspace{16pt}`, `\smallskip`, `footnotesize` environment around a one-line stamp (the stamp text is content, see Content-opaque) |
| loaded, never used | src/resume.tex:3 | `math.amssymb` | `\usepackage{latexsym}` (LaTeX base symbol-font package; no symbol of it is called) |
| loaded, never used | src/resume.tex:6 | `font.icons` | `\usepackage{marvosym}`; no glyph command in the body |
| loaded, never used | src/resume.tex:8 | `code.verbatim` | `\usepackage{verbatim}`; no `verbatim`, `\verb` or `comment` in the body |

Not defined or used: fonts (no font package and no `\familydefault`, so the text keeps the class default; the non-ASCII `µ` at :101 and `–` at :136 rely on the kernel's default UTF-8 input, no `inputenc` line), language, floats, captions, contents lists, theorems, equations, code, bibliography, index, footnotes, appendices.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\resumeItem{#1}{#2}` | src/resume.tex:43-47 | yes | inline `\item\small{\textbf{#1}{: #2 \vspace{-2pt}}}` (`list.kernel`, `font.size-commands`, `mark.kernel`, `sp.manual-space`) |
| `\resumeItemC{#1}` | src/resume.tex:49-53 | yes | inline `\item\small{{#1 \vspace{-2pt}}}` |
| `\resumeSubheading{#1}{#2}{#3}{#4}` | src/resume.tex:55-61 | yes | inline `\vspace{-1pt}\item` + `tabular*` as in the table (`tbl.tabular`, `mark.kernel`, `font.size-commands`, `sp.manual-space`) |
| `\resumeSubItem{#1}{#2}` | src/resume.tex:63 | yes | `\resumeItem` expansion + `\vspace{-4pt}` |
| `\resumeSubHeadingListStart` and `End` | src/resume.tex:67, 69 | yes | `\begin{itemize}[leftmargin=*]` and `\end{itemize}` (`list.enumitem`); balanced at every use (:86-90, :95-130, :134-143, :147-152) |
| `\resumeItemListStart` and `End` | src/resume.tex:71, 73 | yes | `\begin{itemize}` and `\end{itemize}\vspace{-5pt}` (`list.kernel`, `sp.manual-space`); balanced at :99-110 and :115-129 |
| `\renewcommand{\labelitemii}` | src/resume.tex:65 | yes | a kernel label macro whose value is the fixed symbol `$\circ$`; written as the label parameter of `list.kernel` |
| `\titleformat` call | src/resume.tex:38-40 | yes | a declarative `head.titlesec` call; format and after-code hold only kernel font switches, `\vspace`, `\color` and `\titlerule` |
| deployment files | build.sh:11-15, upload.sh, Dockerfile, .github/workflows/upload-resume-to-r2.yml, worker/index.js, wrangler.toml | outside the template | `build.sh:12` seds a `__VERSION__` placeholder that `src/resume.tex` does not contain (the stamp at :159 is already literal); the build is `pdflatex resume.tex` in a TeX Live image (build.sh:15, Dockerfile:1); the rest uploads the PDF to Cloudflare R2. Not EXTERNAL: the `.tex` needs no tool outside TeX |

## Content-opaque
- Version stamp at src/resume.tex:159: the text `GitHub <month>.<year>.<hash>` where month and year come from TeX's `\month` and `\year` registers and the hash is a literal; compile-date text with no macro logic, so content.

## Lib changes
- New ways proposed: none. Mapping choices for a reviewer: `\href` filed under `xref.hyperref` (hyperref's link command; the `[pdftex]` option is `meta.hyperref`); `latexsym` under `math.amssymb` (symbol-font package, loaded and never called); `\tabcolsep` under `sp.lengths`; `\addtolength` of `\textwidth` and the side margins under `page.setlength`; `\smallskip` under `sp.manual-space`; `xwatermark` under `bg.watermark` as the lib lists it.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
