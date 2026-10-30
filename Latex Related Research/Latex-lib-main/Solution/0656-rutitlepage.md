yes

# 0656-rutitlepage: rutitlepage (Radboud University title page package, v3.0)

- Unverified: read from the source, not compiled.
- Source: Source/0656-rutitlepage/ (origin: https://mirrors.ctan.org/macros/latex/contrib/rutitlepage.zip; licence: LPPL 1.3 (dtx header lines 6-12; manifest `lppl1.3`))
- Kind: misc (a package manual whose subject is thesis/report title pages; manifest hint `misc`, category `logo,titlepage`)
- Lib: v5
- Engine: pdfLaTeX-compatible (README.md:14 says it works with `latex` and `pdflatex`; `\ifpdf` picks the `.pdf` logo, rutitlepage.dtx:213)
- Look carried by: class (the published package `rutitlepage`, treated as the class-like way `class.rutitlepage`, draws the three title pages; the manual page is the published `ltxdoc` class; the sample adds only option values and text)
- Class origin: ctan
- Main file: rutitlepage.dtx (DocStrip file; its `%<*driver>` part holds `\documentclass` at line 18 and `\begin{document}` at line 30; no separate .tex; other samples: none)
- Read: main yes, zip-local classes and styles none present (no .cls or .sty ships; the .sty is generated from lines 168-295 of the .dtx, which I read in full, as I read the .ins and README.md)

## Verdict
The zip is the CTAN release of one published package, `rutitlepage` (ctan.org/pkg/rutitlepage: LPPL 1.3, v3.0 of 2022-02-21, contained in TeX Live and MiKTeX). An emitter writes `\usepackage{rutitlepage}` and `\maketitleru[key=value,...]`, plus the `ltxdoc` manual machinery for the sample, all published and all declarative. Every component of the sample and of the package's own three layouts maps to an existing lib way, there is no artwork (the logos are shipped image files included with `\includegraphics`), and every internal macro (key parser, list parser, conditionals) reduces by expansion at emit time. Yes.

## Blockers
none

## Class setting
- Class: `class.ltxdoc` options: none (rutitlepage.dtx:18). LaTeX-base class, not bundled; its source was not read.
- Class-like package: `class.rutitlepage` (rutitlepage.dtx:19, defined at 168-295). W1: CTAN page read (LPPL 1.3, TeX Live, MiKTeX; zip from the CTAN tree). W2: all choices are `keyval` keys (178-188). W3: serves the title page of any Radboud thesis or report; one institution, so class-like, as the lib log (v3) files one-institution cover packages (`class.unswcover`, `class.navydocs`) under a class way. W4: one preamble line and one body call.
- Class-native vocabulary used: `\maketitleru[...]` with keys `layout` (closed list `traditional`, `seventeen`, `twentytwo`; default `twentytwo` per code at 176), `authors`, `date`, `others` (`{{Header}{Names},{Header}{Names}}`), `course`, `title`, `subtitle` (rutitlepage.dtx:145-166). Declared but not used by the sample: `authorstext` (179), `colour` (180), `institution` (183), `nextpagenr` (185). `ltxdoc` vocabulary used: `\DocInput`, `\PrintChanges`, `\GetFileInfo`, `\filedate`, `\changes`, `\DescribeMacro` (see `dtx.doc` below).

## Component map
Part A: what the sample (the documentation driver and its manual text) uses.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | rutitlepage.dtx:18 | `class.ltxdoc` | no options |
| title page package | rutitlepage.dtx:19 | `class.rutitlepage` | `\usepackage{rutitlepage}`, no options |
| title pages (front matter) | rutitlepage.dtx:145-152, 153-159, 160-166 | `front.class-native` | three `\maketitleru` calls: `layout=traditional` with `authors={John Doe}`, `date`, `others` (two groups), `course={Master's Thesis}`, `title`, `subtitle`; `layout=seventeen` without `course`; `layout=twentytwo` with `course` |
| documentation machinery | rutitlepage.dtx:16, 22, 31-32, 37-42, 60, 167 | `dtx.doc` | `\GetFileInfo{rutitlepage.dtx}`, `\DocInput{\filename}`, `\PrintChanges{}`, six `\changes{vN}{date}{text}` entries, `\DescribeMacro\maketitleru`; `%\endinput` at 167 ends the doc-mode read before the code (kernel primitive) |
| manual title block | rutitlepage.dtx:25-28, 43 | `front.maketitle` | `\title{\thetitle}`, `\date{\filedate{}}`, `\author{Mart Lubbers}`, `\maketitle` |
| headings | rutitlepage.dtx:45, 52, 59, 114 | `head.kernel` | `\section`, `\subsection`; no redefinition (class defaults) |
| URLs | rutitlepage.dtx:21, 24, 54 | `meta.url` | `\usepackage{url}`, `\urlstyle{tt}`, `\url{...}` in footnotes |
| option table | rutitlepage.dtx:20, 66-107 | `tbl.tabular` | `tabular{lp{.5\linewidth}lp{.15\linewidth}}`, inline (no float, no caption) |
| table rules | rutitlepage.dtx:20, 67, 69, 106 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| footnotes | rutitlepage.dtx:54, 68, 87, 109-111 | `fn.kernel` | `\footnote` (three in one paragraph), `\footnotemark` in table cells, `\footnotetext` |
| footnote counter | rutitlepage.dtx:108, 112 | `num.counters` | `\addtocounter{footnote}{-1}` before and `{1}` after the `\footnotetext` |
| inline marks | rutitlepage.dtx:46-50, 118-143 | `mark.kernel` | `\texttt`, `\textbackslash`, `\tt` |
| manual spacing | rutitlepage.dtx:65, 117-143 | `sp.manual-space` | `\medskip`, `\\`, `\null\qquad` |
| paragraph start | rutitlepage.dtx:118, 128, 137 | `sp.lengths` | `\noindent` (paragraph-shape switch, the family of `\parindent`) |

Part B: inside the package (rutitlepage.dtx:168-295). `\maketitleru` reaches all of this through the way above; the rows show that each layout also reduces to lib ways if the package were not loaded.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| packages loaded | rutitlepage.dtx:170 | `page.geometry`, `fig.graphicx` | `geometry`, `graphicx`; `ifpdf`, `keyval`, `iflang` are load-only helpers with no printed effect (considered, see Lib changes) |
| page margins per layout | rutitlepage.dtx:198, 220, 241, 217, 238, 281 | `page.geometry` | `\newgeometry{left=25mm,top=25mm,right=15mm,bottom=10mm,hmarginratio=1:1}` for `seventeen` and `twentytwo`; `\newgeometry{hmarginratio=1:1}` for `traditional`; `\restoregeometry` after each |
| title page body | rutitlepage.dtx:199-216, 221-237, 242-280 | `front.titlepage-env` | kernel `titlepage` environment, hand-laid in all three layouts |
| vertical distribution | rutitlepage.dtx:200, 207, 210, 212, 222, 228, 231, 233, 277 | `sp.manual-space` | `\null\vfill`, `\vfill` x2, `\hfill` before the logo (`seventeen`, `twentytwo`); `\vfill` before the date (`traditional`) |
| gaps between fields | rutitlepage.dtx:202, 204, 205, 225, 226, 244, 248-259, 270-272 | `sp.manual-space` | `\\[1.5cm]` (after course), `\\[2\baselineskip]` and `\\[4\baselineskip]` (around subtitle), `\\[\baselineskip]` (after authors); `traditional`: `\vspace{0.4cm}` x3, `\\[1cm]`, `\\[0.4cm]`, `\vspace{2cm}` (no subtitle), `\vspace{8mm}` |
| paragraph indent | rutitlepage.dtx:201, 223 | `sp.lengths` | `\parindent0pt` |
| field sizes | rutitlepage.dtx:202-206, 224-227, 244, 249, 252, 261, 267, 278 | `font.size-commands` | `\LARGE` (course), `\Huge` (title, big layouts), `\Large` (authors, institution), `\large` (date, subtitle, traditional title and blocks) |
| field shapes | rutitlepage.dtx:189, 202-205, 224-226, 244, 249, 252, 256, 262 | `mark.kernel` | `\textsc` (course, institution), `\bfseries`/`\textbf` (title), `\itshape` with `\/` and `\textit` (subtitle, headers), `\scshape` (authors) |
| alignment | rutitlepage.dtx:243-279 | `sp.ragged` | `center` (whole `traditional` page), `flushleft` (authors block), `flushright` (others block) |
| two side-by-side blocks | rutitlepage.dtx:260-276 | `cols.minipage` | two `minipage[t]{0.45\textwidth}` |
| rules | rutitlepage.dtx:250, 253 | `sp.rule` | bare `\hrule` above and below the title (`traditional`) |
| logo | rutitlepage.dtx:213-215, 234-236, 245-247 | `fig.graphicx` | `\includegraphics[width=80mm]` (`seventeen`, `twentytwo`), `[height=150pt]` (`traditional`); file `rutitlepage-logo-[nl-](cmyk\|bw).pdf` or `.eps`; `traditional` always `rutitlepage-logo.pdf` or `.eps`; files ship in the zip |
| language of strings and logo | rutitlepage.dtx:172, 174, 213, 234 | `lang.babel` | `\IfLanguageName{dutch}` selects "Auteur:" / "Author:", "Universiteit" / "University", the `nl-` logo; the language is set by babel, which the sample does not load, so the English forms apply |
| page number of next page | rutitlepage.dtx:185, 294 | `pgnum.pagenumbering` | key `nextpagenr` runs `\setcounter{page}{...}` after the title page |

## Bespoke code
All rows sit in a published package or in the sample; none is a blocker.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\thetitle` text alias | rutitlepage.dtx:25 | yes | inline the string into `\title` (`front.maketitle`) |
| key interface `\define@key`, `\setkeys` | rutitlepage.dtx:178-188, 284 | yes | the emitter writes each value where `\maketitleru` would place it; for the way itself the keys are its parameters (W2) |
| defaults `\def\@rutitle...` | rutitlepage.dtx:171-176 | yes | fixed strings and the default layout name `twentytwo` (176) |
| layout dispatch `\ifcsname ... \PackageError` | rutitlepage.dtx:285-293 | yes | the layout is a name from a closed list; the emitter picks the matching row of Part B |
| optional fields `\ifdefined` | rutitlepage.dtx:202, 204, 209, 225, 230, 244, 254-259, 268 | yes | print the field only when the model has it (`traditional` uses `\vspace{2cm}` when there is no subtitle, 258) |
| colour switch `\newif\if@rutitlecolour` | rutitlepage.dtx:177, 180, 213-214, 234-235 | yes | chooses a file name (`cmyk` or `bw`); the emitter writes the name |
| `\ifpdf` driver switch | rutitlepage.dtx:213-215, 234-236, 245-247 | yes | pdfTeX takes the `.pdf` branch; no extension at all also works with `graphicx` |
| `others` list parser `\rutitlepage@others`, `\kernel@ifnextchar` recursion | rutitlepage.dtx:189-196, 209, 230, 268-274 | yes | unroll: per group `\textit{header}\\names`, groups separated by `\\[\baselineskip]` (`seventeen`, `twentytwo`) or by a paragraph break and `\vspace{8mm}` (`traditional`, 269-272) |
| three layout macros `\rutitle@layout@...` | rutitlepage.dtx:197-282 | yes | Part B rows: `page.geometry`, `front.titlepage-env`, `sp.manual-space`, `font.size-commands`, `mark.kernel`, `sp.ragged`, `cols.minipage`, `sp.rule`, `fig.graphicx` |
| hand-balanced footnote number | rutitlepage.dtx:108-112 | yes | `num.counters` with `\addtocounter`; two marks (68, 87) share one `\footnotetext` |
| DocStrip driver | rutitlepage.ins:15-38 | not template | `\generate` builds `rutitlepage.sty` from the `package` part of the .dtx by running `latex`; a TeX program, so not EXTERNAL; an emitter loads the published `.sty` instead |

Cautions for an emitter (read from the code, not run): the key values are set by `\def` outside any group (178-188, 284), so they persist into the next `\maketitleru` call; a second title page must repeat or override each key it wants. The documentation text and the code disagree in three places: default layout `seventeen` in the table (91) against `twentytwo` in the code (176); `nextpagenr` default `\thepage+1` (94) against no default in the code (185, 294); the manual has two `\footnotemark` (68, 87) but one `\footnotetext` (109), so the mark at 87 seems to have no text.

## Content-opaque
none (the logos `rutitlepage-logo*.eps` and `.pdf` are shipped image assets included with `\includegraphics`, not drawings made in the template; no TikZ, PGF or picture code anywhere)

## Lib changes
- New ways proposed: none. Considered, not proposed: `ifpdf`, `iflang`, `keyval` (load-only helper packages with no printed effect and no node content to wrap, so W4 fails and nothing needs them once the layout is a parameter).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
