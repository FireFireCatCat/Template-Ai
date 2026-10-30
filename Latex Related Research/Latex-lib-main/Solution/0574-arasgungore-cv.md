yes

# 0574-arasgungore-cv: arasgungore CV ("Resume in LaTeX", one-page engineering-student CV)

- Unverified: read from the source, not compiled.
- Source: Source/0574-arasgungore-cv/ (origin: https://latextemplates.com/downloads/arasgungore-cv.zip; licence: MIT, stated at main.tex:4 and in the manifest)
- Kind: cv
- Lib: v4
- Engine: pdfLaTeX-compatible (`\pdfgentounicode` and `glyphtounicode` are pdfTeX features, main.tex:26,53; `fontawesome5` is on CTAN and in TeX Live, its pdfTeX support is not stated on the CTAN page I read)
- Look carried by: preamble (kernel `article` plus published packages; the look is the preamble at main.tex:7-93, the entry macros are `\newcommand` aliases over those packages)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds one file, main.tex, 193 lines; no .cls, .sty, .def, .cfg)

## Verdict
Every component is realised by a lib way: kernel `article` with `letterpaper,11pt`, `fullpage` plus raw length adjustments for the margins, `titlesec` for the small-caps ruled section heads, `fancyhdr` set to empty header and footer, `enumitem` for the borderless entry list, `tabular*` for the two-column entry rows, and `fontawesome5` icons in the heading. All zip-local code is `\newcommand` aliases (main.tex:58-93) and a `\renewcommand` of a list label (main.tex:88), each reducible by inline expansion into those ways. There is no class or style file, no TikZ or other artwork, and no tool outside TeX, so no blocker.

## Blockers
none

## Class setting
- Class: `class.article` options: `letterpaper`, `11pt` (main.tex:7). The class source is not in the zip and was not read (kernel class, ships with the TeX distribution).
- Class-native vocabulary used: `\section` (main.tex:118,129,140,163,183), `center` environment (main.tex:102-114), `itemize` (main.tex:90,92). Not used: `\maketitle`, `abstract`, `\subsection`, `\tableofcontents`, `thebibliography`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:7 | `class.article` | `letterpaper,11pt` |
| paper size and base font size | main.tex:7 | `page.class-options` | `letterpaper`, `11pt` |
| page margins, package | main.tex:10 | `page.vmargin` | `\usepackage[empty]{fullpage}`; option `empty` is a page-style option (the page style is set again by `\pagestyle{fancy}` at main.tex:28); fullpage source not read |
| page margins, adjustment | main.tex:35-39 | `page.setlength` | `\addtolength`: `\oddsidemargin` -0.5in, `\evensidemargin` -0.5in, `\textwidth` +1in, `\topmargin` -.5in, `\textheight` +1.0in (relative to the fullpage values) |
| header and footer | main.tex:16,28-32 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\fancyfoot{}`, `\headrulewidth` 0pt, `\footrulewidth` 0pt: all fields empty, no rules |
| page flow | main.tex:43 | `pg.flush` | `\raggedbottom` |
| paragraph shape | main.tex:44 | `sp.ragged` | `\raggedright` for the whole document |
| fonts | (none loaded) | none | no font package, default Computer Modern; sizes by `\Huge` `\large` `\small` `\tiny` (main.tex:49,59,103,104,88) |
| font sizes | main.tex:49,59,68,84,88,103,104,132 | `font.size-commands` | `\Huge`, `\large`, `\small`, `\tiny` |
| colour package | main.tex:12 | `color.color` | `\usepackage[usenames,dvipsnames]{color}`; uses `\color{black}` (main.tex:50) and `\color{blue}` (main.tex:168,174) |
| hyperlinks | main.tex:15,105-111,168,174 | `meta.hyperref` | `hidelinks`; `\href{url}{text}` for tel:, mailto: and https links |
| URL style | main.tex:41 | `meta.url` | `\urlstyle{same}` (no `\url` is printed in the body) |
| language | main.tex:17 | `lang.babel` | `english` |
| PDF text extraction | main.tex:26,53 | `meta.glyphtounicode` | `\input{glyphtounicode}`, `\pdfgentounicode=1` |
| icons | main.tex:25,105-113 | `font.icons` | `fontawesome5` with option `fixed`; `\faMobile` `\faAt` `\faLinkedin` `\faGithub` `\faMapMarker`. The comment at main.tex:20-24 says `fixed` remaps v4 names; the CTAN page does not mention that option, so its effect is not verified here |
| math symbols package | main.tex:9 | `math.amssymb` | `latexsym` loaded, no symbol from it is printed by the sample (nearest way: a math symbol-font package; no printed effect) |
| inline math symbols | main.tex:106,108,110,112,187,88 | `math.kernel` | `$|$` separators, `$\geq$`, `$\bullet$` (content-level kernel math) |
| heading block (name and contact line) | main.tex:102-114 | `sp.ragged` | `center` environment; no `\maketitle`; name `\textbf{\Huge \scshape ...}`, contact line `\small`, items separated by `$|$` |
| heading block fonts and spacing | main.tex:103-104 | `mark.kernel`, `sp.manual-space` | `\textbf`, `\scshape`; `\\ \vspace{3pt}`; `\hspace{.5pt}` between icon and text (main.tex:105-113) |
| section heads | main.tex:11,48-50 | `head.titlesec` | `\titleformat{\section}{\vspace{-4pt}\scshape\raggedright\large}{}{0em}{}[\color{black}\titlerule \vspace{-5pt}]`: shape display (default), empty label, sep 0em, small caps, large, rule below; no `\titlespacing`; only `\section` is formatted |
| section head spacing in the body | main.tex:119,130,141,164,184 | `sp.manual-space` | `\vspace{3pt}` or `\vspace{2pt}` after each `\section` |
| entry list (outer) | main.tex:14,90-91 | `list.enumitem` | `\begin{itemize}[leftmargin=0.15in, label={}]` (borderless, no marker) |
| bullet list (inner) | main.tex:92-93,88 | `list.kernel` | `itemize` nested at level 2; `\renewcommand\labelitemii{$\vcenter{\hbox{\tiny$\bullet$}}$}`; `\vspace{-5pt}` after `\end{itemize}` (main.tex:93) |
| bullet item | main.tex:58-62 | `list.kernel`, `font.size-commands`, `sp.manual-space` | `\item\small{#1 \vspace{-2pt}}` |
| entry heading rows | main.tex:64-86 | `tbl.tabular` | `tabular*` of width `0.97\textwidth`, colspec `l@{\extracolsep{\fill}}r`, position `[t]` (not on the project heading), rows of `\textbf` / `\textit{\small}` |
| tabular spacing | main.tex:45 | `tbl.tabular` | `\setlength{\tabcolsep}{0in}` |
| entry heading fonts and spacing | main.tex:64-86 | `mark.kernel`, `font.size-commands`, `sp.manual-space` | `\textbf`, `\textit`, `\small`; `\vspace{-2pt}` before, `\vspace{-7pt}` or `\vspace{-5pt}` after |
| skills and awards blocks | main.tex:129-136,183-190 | `list.enumitem`, `mark.kernel`, `font.size-commands`, `sp.manual-space` | one `\small{\item{...}}` in the outer list; `\textbf{label:}` then text; `\\ \vspace{3pt}` between lines |
| project line | main.tex:167-177 | `meta.hyperref`, `mark.kernel`, `color.color` | `\textbf{name} $|$ \emph{\href{url}{\color{blue}GitHub}}` |
| loaded, not used by the sample | main.tex:13 | `code.verbatim` | `verbatim` package, no `verbatim` or `comment` environment in the body |
| loaded, not used by the sample | main.tex:18 | `tbl.tabularx` | `tabularx`; the body uses `tabular*`, never `tabularx` |
| loaded, not used by the sample | main.tex:19 | `sp.hyphenat` | `hyphenat`, no options, no `\hyp` or `\nohyphens` in the body |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\resumeItem` | main.tex:58-62 | yes | inline expansion to `\item\small{...\vspace{-2pt}}` (`list.kernel`, `font.size-commands`, `sp.manual-space`) |
| `\resumeSubheading` | main.tex:64-70 | yes | `\vspace{-2pt}\item` then `tabular*` `0.97\textwidth`, `[t]`, `l@{\extracolsep{\fill}}r`, two rows, then `\vspace{-7pt}` (`tbl.tabular`, `mark.kernel`) |
| `\resumeEducationHeading` | main.tex:72-79 | yes | the same with three rows and `\vspace{-5pt}` after |
| `\resumeProjectHeading` | main.tex:81-86 | yes | the same with one row `\small#1 & #2`, no `[t]`, `\vspace{-7pt}` after |
| `\resumeSubHeadingListStart` / `End` | main.tex:90-91 | yes | a begin/end pair that is only `\begin{itemize}[leftmargin=0.15in, label={}]` and `\end{itemize}`; the emitter prints the environment as a body wrapper (`list.enumitem`) |
| `\resumeItemListStart` / `End` | main.tex:92-93 | yes | `\begin{itemize}` and `\end{itemize}\vspace{-5pt}` (`list.kernel`, `sp.manual-space`) |
| `\renewcommand\labelitemii` | main.tex:88 | yes | a kernel list-label macro set to a small raised bullet built from `\vcenter`, `\hbox`, `\tiny`, `$\bullet$`; a value of `list.kernel` |
| `\titleformat` code arguments | main.tex:48-50 | yes | parameters of `head.titlesec` (before code, after code `\titlerule`); not new macros |

No counter, conditional, `\def`, output routine or box algorithm is defined in the zip.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
