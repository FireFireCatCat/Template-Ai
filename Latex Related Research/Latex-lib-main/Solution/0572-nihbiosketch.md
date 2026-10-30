yes

# 0572-nihbiosketch: NIH Biographical Sketch class (nihbiosketch)

- Unverified: read from the source, not compiled.
- Source: Source/0572-nihbiosketch/ (origin: https://mirrors.ctan.org/macros/latex/contrib/nihbiosketch.zip; licence: LPPL 1.3)
- Kind: cv
- Lib: v4
- Engine: needs XeLaTeX (`fontspec` with the system font Arial, nihbiosketch.cls:33-34; the class comment at :32 and `%!TEX TS-program = xelatex` at example-nihbiosketch.tex:1 name XeTeX or LuaTeX)
- Look carried by: class (nihbiosketch.cls sets the page, font, headings, lists, links, the NIH header form and both tables; the sample adds only class-native commands and one `draftwatermark` demo)
- Class origin: ctan
- Main file: example-nihbiosketch.tex (other samples: none; example-nihbiosketch.pdf is the author's rendered output, not read)
- Read: main yes, zip-local classes and styles all

## Verdict
The look is carried by `nihbiosketch`, a published class (ctan.org/pkg/nihbiosketch, TeX Live and MiKTeX, LPPL 1.3, author Paul M. Magwene), so it is one class way. The sample adds only class-native commands and a watermark. The class file is 132 lines and was read whole; none of its code is irreducible, so every macro in it reduces by inline expansion to lib ways, as the Bespoke table shows. No artwork, no external tool, no unmapped component. XeLaTeX is required and Arial is not shipped; both are recorded, not blockers.

## Blockers
none

## Class setting
- Class: `class.nihbiosketch` options: none (the class declares none; `\ProcessOptions\relax` at nihbiosketch.cls:24 runs before `\LoadClass`). It loads `class.article` with `11pt,letterpaper` (nihbiosketch.cls:25).
- Class-native vocabulary used: `\name{}` `\eracommons{}` `\position{}` (strings, nihbiosketch.cls:66-68; used at example-nihbiosketch.tex:10-12); the NIH header form `\piinfo`, printed automatically at begin-document by `\AfterEndPreamble{\piinfo}` (nihbiosketch.cls:72-86, :131), so the sample never calls it; environment `education` (nihbiosketch.cls:94, used at example-nihbiosketch.tex:17-21); environment `datetbl` (nihbiosketch.cls:108, used at example-nihbiosketch.tex:71-77, :80-88, :91-95); `\grantinfo{6 args}` (nihbiosketch.cls:88, used at example-nihbiosketch.tex:206, :214, :222, :234); `\section` numbered A. B. C. D. (nihbiosketch.cls:46); starred `\subsection*`. Defined but not used by the sample: `statement` (nihbiosketch.cls:113), `\pgline` (nihbiosketch.cls:70, only inside `\piinfo`).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | example-nihbiosketch.tex:2 | `class.nihbiosketch` | no options; native vocabulary above |
| base class | nihbiosketch.cls:25 | `class.article` | `\LoadClass[11pt,letterpaper]{article}` |
| paper and size | nihbiosketch.cls:25 | `page.class-options` | `11pt`, `letterpaper` |
| page geometry | nihbiosketch.cls:31, :127 | `page.geometry` | `[letterpaper]`; `left=0.5in,right=0.5in,top=0.5in,bottom=0.5in` (the comment at :127 says this is the last call) |
| page numbers and footer | nihbiosketch.cls:122 | `pgnum.pagenumbering` | `\pagenumbering{gobble}`; no `\pagestyle` call, so the article default footer prints an empty number |
| paragraph indent | nihbiosketch.cls:125 | `sp.lengths` | `\parindent` 0pt |
| main font | nihbiosketch.cls:33-34 | `font.fontspec` | `\setmainfont[Ligatures=TeX]{Arial}` (system font, not shipped) |
| micro-typography | nihbiosketch.cls:35 | `sp.microtype` | no options |
| section headings | nihbiosketch.cls:45, :47, :51 | `head.titlesec` | `\titleformat{\section}[hang]{\normalfont\bfseries}{\thesection}{0.5em}{}`; `\titlespacing{\section}{0pt}{2ex}{1ex}` |
| subsection headings | nihbiosketch.cls:48, :52 | `head.titlesec` | `\titleformat{\subsection}[hang]{\normalfont\bfseries}{\thesubsection}{0.5em}{\uline}` (before-code `\uline` underlines the title); `\titlespacing{\subsection}{0pt}{1.25ex}{0.5ex}`; sample uses only `\subsection*` (example-nihbiosketch.tex:70, :79, :90, :196, :204, :232) |
| subsubsection headings | nihbiosketch.cls:49, :53 | `head.titlesec` | `[hang]{\itshape}{\thesubsubsection}{0.5em}{}`; `\titlespacing{0pt}{1.25ex}{0.5ex}`; not used by the sample |
| section numbering | nihbiosketch.cls:46 | `num.counters` | `\renewcommand{\thesection}{\Alph{section}.}` |
| underline | nihbiosketch.cls:39, :48 | `mark.ulem` | `ulem` loaded with no options (so `\emph` would underline, unused by the sample); `\uline` as the subsection before-code |
| lists, level 1 and 2 | example-nihbiosketch.tex:47-65, :101-194 (nested at :118, :150, :176) | `list.kernel` | `enumerate`, nested two deep |
| list level 2 | nihbiosketch.cls:41-42 | `list.enumitem` | `\setlist[enumerate,2]{label=\alph*.,itemsep=0pt,parsep=1pt,partopsep=1pt}` |
| links | nihbiosketch.cls:55-56 | `meta.hyperref` | `urlcolor=blue,colorlinks=true,breaklinks=true` via `\PassOptionsToPackage` before `\RequirePackage{hyperref}` |
| URL style | nihbiosketch.cls:57; example-nihbiosketch.tex:197 | `meta.url` | `\urlstyle{same}`; body `\url{...}` |
| header form (name, eRA, position) | nihbiosketch.cls:62-68, :72-86, :131; example-nihbiosketch.tex:10-12 | `front.class-native` | three strings; the form text is fixed in the class; printed once at begin-document |
| header form rules | nihbiosketch.cls:70 (definition), :73, :79, :81, :83, :85 (uses) | `sp.rule` | `\rule{\textwidth}{0.5pt}` between the form blocks |
| header form centred title | nihbiosketch.cls:74-78 | `sp.ragged` | `\centering` in a group |
| header form type | nihbiosketch.cls:75, :86 | `mark.kernel` | `\textbf`, `\textit` |
| header form small print | nihbiosketch.cls:76 | `font.size-commands` | `\footnotesize` |
| education table | nihbiosketch.cls:94-106; example-nihbiosketch.tex:17-21 | `tbl.nicematrix` | tabu: `\begin{tabu} to \textwidth {X[3.73,l,m]\|X[1,c,m]\|X[1,c,m]\|X[1.8,l,m]}`, `\tabulinesep=1.5mm`, `\hline` before and after the header row, `\rowfont[c]{}`; header strings fixed in the class; no closing `\hline` |
| education table centring | nihbiosketch.cls:96 | `sp.ragged` | `\bgroup\centering` around the table (closed by `\egroup` at :106) |
| dated list table | nihbiosketch.cls:108-111; example-nihbiosketch.tex:71-77, :80-88, :91-95 | `tbl.nicematrix` | tabu: `\begin{tabu} to 7.5in{X[1,l]X[6.5,l,p]}`, `\tabulinesep=0mm` |
| grant block | nihbiosketch.cls:88-92; example-nihbiosketch.tex:206-227, :234-238 | `tbl.tabular` | `\begin{tabular}{@{}lll@{}}` with one row of #1 #2 #3; then #4 #5 #6 |
| grant block line breaks | nihbiosketch.cls:92 | `sp.manual-space` | `\newline` between the three text fields |
| vertical gap between grants | example-nihbiosketch.tex:212, :220 | `sp.manual-space` | `\bigskip` |
| indented statement block | nihbiosketch.cls:113-115 | `sp.lengths` | `\parindent` 2em at start, 0pt at end; not used by the sample |
| watermark (demo only) | example-nihbiosketch.tex:4-6 | `bg.watermark` | `\usepackage{draftwatermark}`, `\SetWatermarkText{Sample}`, `\SetWatermarkLightness{0.9}`; the sample's own comments say to delete these lines |

Components the sample and class do not define or use: abstract, contents, theorems, floats, captions, code, boxes, bibliography (publications are hand-typed `enumerate` items, example-nihbiosketch.tex:47-65), index, cross-references. Sample quirks, recorded not blockers: the third `\grantinfo` call passes five of its six arguments (example-nihbiosketch.tex:222-227), so its sixth argument takes the following paragraph break (not compiled, effect not verified); with `\thesection` ending in a dot (nihbiosketch.cls:46), a numbered `\thesubsection` would read "A..1", but the sample uses only `\subsection*`.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `nihbiosketch.cls` as a file | nihbiosketch.cls:1-132 | not needed: published | the class is on CTAN and in TeX Live (read at ctan.org/pkg/nihbiosketch), so it is the `class.nihbiosketch` way; the rows below show it would also reduce if treated as zip-local |
| `\@name` `\@eracommons` `\@position`, `\name` `\eracommons` `\position` | nihbiosketch.cls:62-68 | yes | string storage; inline the three strings into the header form body |
| `\pgline` | nihbiosketch.cls:70 | yes | `sp.rule` `\rule{\textwidth}{0.5pt}`; `\newline` is `sp.manual-space`; `\makebox[\linewidth]` is as wide as the rule at top level, adds nothing; `\noindent` repeats `\parindent` 0pt of :125 (`sp.lengths`) |
| `\piinfo` | nihbiosketch.cls:72-86 | yes | body text at the top of the document: `sp.ragged` group, `mark.kernel`, `font.size-commands`, `sp.rule` lines, fixed NIH strings |
| `\AfterEndPreamble{\piinfo}` | nihbiosketch.cls:131 | yes | an `etoolbox` hook that runs `\piinfo` at `\begin{document}`; the emitter writes the `\piinfo` body as the first lines of the body; there is no node content to wrap (considered: `etoolbox`, not a way, as v4 rejected `sp.xspace` for the same reason) |
| `\grantinfo` (6 arguments) | nihbiosketch.cls:88-92 | yes | inline expansion: `tbl.tabular` `@{}lll@{}` one row, then `\newline` three times (`sp.manual-space`) |
| `education` environment | nihbiosketch.cls:94-106 | yes | `\newenvironment` wrapper over `tbl.nicematrix` (tabu) with the column spec, `\tabulinesep`, `\hline`, `\rowfont` read above; `\bgroup\centering` is `sp.ragged` |
| `datetbl` environment | nihbiosketch.cls:108-111 | yes | `\newenvironment` wrapper over `tbl.nicematrix` (tabu) with the column spec and `\tabulinesep` read above |
| `statement` environment | nihbiosketch.cls:113-115 | yes | `sp.lengths` on `\parindent` (2em, then 0pt) |
| `\renewcommand{\thesection}` | nihbiosketch.cls:46 | yes | `num.counters` |
| load-only `ifxetex`, `ifluatex`, `ifthen` | nihbiosketch.cls:32, :38 | yes | never called (grep finds no `\ifxetex`, `\ifluatex`, `\ifthenelse`); no printed effect (considered: not ways, as v4 rejected `sys.compat-load`) |

## Content-opaque
none

## Lib changes
- New ways proposed: none (considered: `etoolbox`, `ifxetex`, `ifluatex`, `ifthen`; each has no printed effect or is one hook that reduces by inline expansion)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
