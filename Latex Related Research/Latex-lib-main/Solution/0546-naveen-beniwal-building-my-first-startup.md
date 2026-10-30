yes

# 0546-naveen-beniwal-building-my-first-startup: Apex Resume (one-page ATS CV on kernel article)

- Unverified: read from the source, not compiled.
- Source: Source/0546-naveen-beniwal-building-my-first-startup/ (origin: https://codeload.github.com/Naveen-Beniwal/building-my-first-startup/zip/refs/heads/main; licence: MIT, LICENSE:1)
- Kind: cv
- Lib: v4
- Engine: pdfLaTeX-compatible (preamble has no `fontspec`, `unicode-math`, `luacode` or `polyglossia`, apex_resume.tex:3-24; `\pdfgentounicode` at :43 and :70 is a pdfTeX primitive, so the file is pdfTeX-bound, not XeTeX)
- Look carried by: preamble (kernel `article` plus the sample's own preamble: margin lengths, one `\titleformat`, a set of `\newcommand` row macros, apex_resume.tex:1-116)
- Class origin: tex-distribution-unbundled (kernel `article`, LaTeX base; the zip ships no `.cls`, `.sty`, `.def`, `.cfg` or `.clo`, checked with `find`)
- Main file: apex_resume.tex (other samples: none; README.md and docs/*.md describe the CVInsight web app, not LaTeX)
- Read: main yes (all 222 lines), zip-local classes and styles none present

## Verdict
Every in-scope component maps to an existing lib way: kernel `article`, `fullpage` plus `\addtolength` margins, `fancyhdr` set to empty, one `titlesec` heading, `enumitem` lists, `tabular*` entry rows, `fontawesome5` icons, `hyperref`. The twelve zip-local `\newcommand`/`\renewcommand` definitions are static wrappers over those ways and reduce by inline expansion (no counters, conditionals or box algorithms). `tikz` is loaded but no picture is drawn, so there is no `ART`. Nothing needs a tool outside TeX. The answer is `yes`, but the look is carried by the preamble over a kernel class, so it is evidence about component ways, not about the class dimension.

## Blockers
none

Sample defects, not blockers (recorded so nobody assumes the file compiles as shipped):
- `\begin{justify}` at apex_resume.tex:137-139 needs the `justify` environment of `ragged2e`, which the preamble never loads (grep for `ragged2e` in the zip's `.tex` and `.md` files finds nothing; no loaded package is known to define `justify`). The emitter writes it as `sp.ragged` with `ragged2e` added; that is a package from the lib, not zip-local logic.
- `fontawesome5` (:14) and the older `fontawesome` (:22) are both loaded; the two define overlapping `\fa...` commands. Whether they clash was not checked. One icon package is enough for the emitter.
- `\pdfgentounicode=1` is set twice (:43, :70).

## Class setting
- Class: `class.article` options: `letterpaper`, `11pt` (apex_resume.tex:1)
- Class-native vocabulary used: `\section` (apex_resume.tex:136, 143, 156, 172, 197), `center`, `itemize`, `tabular*`; no `\maketitle`, no `abstract` environment, no `\subsection`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | apex_resume.tex:1 | `class.article` | letterpaper, 11pt |
| paper and size | apex_resume.tex:1 | `page.class-options` | letterpaper, 11pt |
| base margins | apex_resume.tex:4 | `page.vmargin` | `fullpage` with option `empty` (a pagestyle option; the page style is reset at :45) |
| margin adjustments | apex_resume.tex:52-56 | `page.setlength` | `\addtolength`: `\oddsidemargin` -0.6in, `\evensidemargin` -0.5in, `\textwidth` +1.19in, `\topmargin` -.7in, `\textheight` +1.4in; relative to what `fullpage` set, so emit after it |
| header and footer | apex_resume.tex:11, 45-49 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\fancyfoot{}`, `\headrulewidth` 0pt, `\footrulewidth` 0pt (empty head and foot) |
| paragraph shape | apex_resume.tex:61, 124-134, 137-139 | `sp.ragged` | `\raggedright` globally; `center` environment around the name and contact block; `justify` around the summary (needs `ragged2e`, see defects) |
| page fill | apex_resume.tex:60 | `pg.flush` | `\raggedbottom` |
| table column pad | apex_resume.tex:62 | `sp.lengths` | `\tabcolsep` 0in |
| manual spacing | apex_resume.tex:66-67, 76, 87, 91, 125, 133, 140, 153, 169 | `sp.manual-space` | `\vspace` -2pt to -16pt and 8pt (negative values tighten to one page), `\raisebox{-0.1\height}` / `-0.2\height` on icons (:128-131), `~` spacers |
| font sizes | apex_resume.tex:66, 89-90, 125, 127 | `font.size-commands` | `\Huge` name, `\large` heading rows and section titles, `\small` items and contact line, `\tiny` bullet |
| inline marks | apex_resume.tex:66, 89-90, 125, 146-150, 176 | `mark.kernel` | `\scshape`, `\bfseries`, `\textbf`, `\textit`, `\emph` |
| underline | apex_resume.tex:128-131 | `mark.ulem` | kernel `\underline` on the contact strings; `ulem` is not loaded, the effect type (underline) is the same |
| icons | apex_resume.tex:6, 14, 22, 128-131 | `font.icons` | `fontawesome5` (and `fontawesome`, `marvosym` load-only); `\faPhone` `\faEnvelope` `\faLinkedin` `\faGithub` |
| PDF text map | apex_resume.tex:18, 43, 70 | `meta.glyphtounicode` | `\input{glyphtounicode}`, `\pdfgentounicode=1` |
| colour, legacy | apex_resume.tex:7 | `color.color` | `color` with `usenames,dvipsnames` |
| colour, named | apex_resume.tex:21, 26-40, 67 | `color.xcolor` | `\definecolor{..}{HTML}{..}`: cvblue 0E5484, black 130810 (redefines `black`), darkcolor 0F4539, cvgreen 3BD80D, taggreen 00E278, SlateGrey 2E2E2E, LightGrey 666666; `\colorlet` aliases name, tagline, heading, headingrule, subheading, accent, emphasis, body (none is used in the body); only `\color{black}` is used, in the heading rule (:67) |
| language | apex_resume.tex:12 | `lang.babel` | `english` |
| hyperlinks | apex_resume.tex:10, 128-131 | `meta.hyperref` | `hidelinks`; `\href` with `tel:`, `mailto:` and https targets |
| URL style | apex_resume.tex:58 | `meta.url` | `\urlstyle{same}` (`url` comes in through `hyperref`) |
| front block | apex_resume.tex:124-134 | `sp.ragged` | hand-laid: no `\maketitle`; name `{\Huge \scshape ..} \\ \vspace{8pt}`, then one `\small` line of four `\href` items separated by `~ $|$ ~`; built from the rows above, so no `front.*` way is needed |
| headings | apex_resume.tex:5, 64-67 | `head.titlesec` | `\titleformat{\section}{\vspace{-4pt}\scshape\raggedright\large\bfseries}{}{0em}{}[\color{black}\titlerule \vspace{-5pt}]`: empty label, 0em sep, no before-code, after-code rule; one level only |
| list, entries | apex_resume.tex:9, 113, 144 | `list.enumitem` | `itemize[leftmargin=0.0in, label={}]` for entry blocks; `itemize[leftmargin=0.15in, label={}]` for the skills block |
| list, bullets | apex_resume.tex:110-111, 115 | `list.kernel` | `itemize`; `\labelitemi` and `\labelitemii` set to `$\vcenter{\hbox{\tiny$\bullet$}}$` (a static label, no logic) |
| entry rows | apex_resume.tex:88-91, 103-106 | `tbl.tabular` | `tabular*` with `l@{\extracolsep{\fill}}r`, width 1.0\textwidth (subheading, two rows: `\textbf{\large}` / `\textbf{\small}` then `\textit{\large}` / `\textit{\small}`) and 1.001\textwidth (project heading, one row) |
| Load-only: table | apex_resume.tex:13 | `tbl.tabularx` | `tabularx` loaded, no `tabularx` environment in the body |
| Load-only: columns | apex_resume.tex:15-17 | `cols.multicol` | `multicol` loaded with `\multicolsep` -3.0pt and `\columnsep` -1pt (`sp.lengths`); no `multicols` in the body |
| Load-only: verbatim | apex_resume.tex:8 | `code.verbatim` | `verbatim` loaded, never used |
| Load-only: symbols | apex_resume.tex:3 | `math.amssymb` | `latexsym` (LaTeX base) is a math-symbol package of the `amssymb` type; no symbol used |
| Load-only: drawing | apex_resume.tex:20, 23-24 | `art.tikz` | `tikz` with library `svg.path`; no `tikzpicture` or `\draw` in the body (grep), so no content and no `ART` |

No component for: abstract, contents, theorems, floats, captions, code, boxes, bibliography, index, footnotes, cross-references, page numbers (the foot is empty). Fonts stay at the default Computer Modern: no font package or `\familydefault` is set.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\resumeItem` | apex_resume.tex:74-78 | yes | `\item` + `\small{#1 \vspace{-2pt}}`: `list.kernel`, `font.size-commands`, `sp.manual-space` |
| `\classesList` | apex_resume.tex:80-84 | yes (unused) | four-argument copy of `\resumeItem`; never called in the body |
| `\resumeSubheading` | apex_resume.tex:86-92 | yes | `\vspace{-2pt}\item` + two-row `tabular*{1.0\textwidth}[t]{l@{\extracolsep{\fill}}r}` + `\vspace{-7pt}`: `tbl.tabular`, `mark.kernel`, `font.size-commands`, `sp.manual-space`; expand inline per call (:159, 200, 205, 210) |
| `\resumeSubSubheading` | apex_resume.tex:94-99 | yes (unused) | one-row `tabular*{0.97\textwidth}`; never called |
| `\resumeProjectHeading` | apex_resume.tex:101-106 | yes | `\item` + one-row `tabular*{1.001\textwidth}` + `\vspace{-7pt}`; called at :175, 184 |
| `\resumeSubItem` | apex_resume.tex:108 | yes (unused) | `\resumeItem{#1}\vspace{-4pt}`; never called |
| `\resumeSubHeadingListStart` | apex_resume.tex:113 | yes | `\begin{itemize}[leftmargin=0.0in, label={}]` (`list.enumitem`); the env is opened in one macro and closed in the next, so the emitter writes the wrapper pair directly |
| `\resumeSubHeadingListEnd` | apex_resume.tex:114 | yes | `\end{itemize}` |
| `\resumeItemListStart` | apex_resume.tex:115 | yes | `\begin{itemize}` (`list.kernel`) |
| `\resumeItemListEnd` | apex_resume.tex:116 | yes | `\end{itemize}\vspace{-5pt}` |
| `\labelitemi` | apex_resume.tex:110 | yes | `\renewcommand` of a kernel list label; the string `$\vcenter{\hbox{\tiny$\bullet$}}$` is a raised-bullet glyph, no computation (`list.kernel`, or the `label=` key of `list.enumitem`) |
| `\labelitemii` | apex_resume.tex:111 | yes (unused) | same string; no second-level list in the body |

The `\colorlet` aliases (:33-40) and `\definecolor` calls (:26-32) are declarations of `color.xcolor`, not bespoke code.

## Content-opaque
none (the `tikz` load at :20, :23-24 draws nothing; contact strings, dates and bullet text are content)

## Lib changes
- New ways proposed: none. Considered and not needed: `ragged2e` (already `sp.ragged`), `latexsym` (type of `math.amssymb`), kernel `\underline` (effect type of `mark.ulem`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
