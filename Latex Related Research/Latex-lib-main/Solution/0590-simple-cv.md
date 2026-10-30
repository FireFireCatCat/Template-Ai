no

# 0590-simple-cv: Simple CV

- Unverified: read from the source, not compiled.
- Source: Source/0590-simple-cv/ (origin: https://latextemplates.com/downloads/simple-cv-dcetin.zip; licence: MIT)
- Kind: cv
- Lib: v5
- Engine: pdfLaTeX-compatible (no fontspec or unicode-math is loaded by active code; the README builds with XeLaTeX, README.md:46-51, and the patch note at simplecv.sty:4-11 says `fontawesome5` branches by engine; the Cyrillic option of `babel` under pdfTeX was not checked)
- Look carried by: zip-local
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; the nine files in sections/ are `\import`ed from it)
- Read: main yes, zip-local classes and styles all

## Verdict
No. The look is a plain `article` plus the zip-local helper package `simplecv.sty`, and almost all of it reduces to lib ways: `\newcommand` aliases, wrappers over `enumitem` lists, `tabular*` rows, `minipage` heads, a `multicols` pair and one `\titleformat`. One item does not reduce: `simplecv.sty:157-165` redefines the biblatex hooks `\mkbibnamegiven` and `\mkbibnamefamily` with an `\ifboolexpr`/`\ifdefequal` test that decides, name by name at typeset time, whether to print the name in bold. That is a hand-rolled conditional that drives what is printed, and it needs its own code inside a published package, so it fails W2 and has no lib way. The zip is a close call: if a reviewer accepts the three-string author highlight as a parameter of `bib.biblatex-bibtex`, every other row below is already `yes`.

## Blockers
- `BESPOKE/class` author-name highlight in the bibliography: `\boldname` stores three strings (simplecv.sty:151-155), and `\renewcommand` of `\mkbibnamegiven` and `\mkbibnamefamily` tests them against `\namepartgiven`/`\namepartfamily` with `\ifboolexpr` and `\ifdefequal` to choose `\mkbibbold` (simplecv.sty:157-165; strings set at main.tex:19). The test runs once per printed name, so inline expansion cannot remove it, and no lib way holds it.

## Class setting
- Class: `class.article` options: `letterpaper`, `11pt` (main.tex:1). `article` is a published class that ships with the TeX distribution and is not bundled in the zip; its source was not read.
- Class-native vocabulary used: `\section` (every file in sections/, for example sections/education.tex:2), `\pagebreak` (main.tex:41). Nothing else from the class: no `\maketitle`, no `abstract`, no `\tableofcontents`.
- The zip-local package `simplecv.sty` is not the CTAN class `simplecv` (ctan.org/pkg/simplecv is a different class by Jean-Marc Lasgouttes for CVs); this one is `\ProvidesPackage{simplecv}` (simplecv.sty:1) and the README says it is not on CTAN (README.md:16), so it is zip-local.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | letterpaper, 11pt |
| paper and size | main.tex:1 | `page.class-options` | letterpaper, 11pt |
| margins | simplecv.sty:13 | `page.vmargin` | `fullpage` with option `cm` (package source not read) |
| page style | simplecv.sty:21,36 | `hf.fancyhdr` | `\pagestyle{fancy}` |
| header and footer fields | simplecv.sty:37-39,116 | `hf.fancyhdr` | `\fancyhf{}` clears all fields; `\headrulewidth` and `\footrulewidth` = 0pt; `\fancyfoot[R]{Page \thepage \hspace{1pt} of \pageref{LastPage}}` |
| page X of Y | simplecv.sty:20,116 | `pgnum.lastpage` | `lastpage` package, label `LastPage` |
| ragged text | simplecv.sty:42 | `sp.ragged` | `\raggedright` for the whole document |
| ragged page bottom | simplecv.sty:41 | `pg.flush` | `\raggedbottom` |
| table column padding | simplecv.sty:43 | `sp.lengths` | `\setlength{\tabcolsep}{0in}` |
| icon glyphs | simplecv.sty:12; main.tex:25-27 | `font.icons` | `fontawesome5` option `fixed`; `\faEnvelope` `\faGlobe` `\faGithub` |
| big name size | simplecv.sty:25,77,91 | `font.size-commands` | `moresize` `\HUGE` (CTAN: Moresize, LPPL 1; its source was not read); `\small` (simplecv.sty:131), `\Large` (simplecv.sty:112) |
| font switches | simplecv.sty:112,137 | `mark.kernel` | `\scshape`, `\textit`; `\textbf` in sections/*.tex (sections/education.tex:7) |
| colour package | simplecv.sty:18 | `color.xcolor` | options `usenames,dvipsnames` |
| colours | simplecv.sty:54-56; main.tex:15 | `color.xcolor` | `color-text` gray 0.10, `color-detail` gray 0.40, `color-title` = `\colorlet` of `\theme`, which main.tex:15 defines as `MidnightBlue` |
| text colour | simplecv.sty:59-62,77,132 | `color.xcolor` | `\color{color-text}` at `\AtBeginDocument`, `\textcolor{color-title}` on the name, `\textcolor{color-detail}` on extra lines |
| language | simplecv.sty:22 | `lang.babel` | `russian,english` (English is the main language; only English text appears) |
| quotation marks | simplecv.sty:46-47; sections/education.tex:10 | `lang.csquotes` | `autostyle`, `english=american`, `\MakeOuterQuote{"}` makes the typed `"` pairs into quotes |
| links | simplecv.sty:14,40,51,65-68 | `meta.hyperref` | `hidelinks`; `\href` links with `https://` and `mailto:` prefixes |
| URL face | simplecv.sty:40 | `meta.url` | `\urlstyle{same}` |
| file inclusion | simplecv.sty:16; main.tex:37-39,44-50 | `struct.input` | `\import{sections/}{education.tex}` and eight more |
| page break | main.tex:41 | `pg.break` | `\pagebreak` |
| heading block | simplecv.sty:74-84; main.tex:24-28 | `box.minipage` | two top-aligned `minipage` boxes, 0.60 and 0.39 of `\textwidth`; the right one holds a `flushright` block |
| heading spacing | simplecv.sty:76 | `sp.manual-space` | `\vspace*{\fill}` at the start of the name box |
| photo heading (defined, commented out in the sample) | simplecv.sty:87-101; main.tex:30-34 | `box.minipage` | same two boxes with `\vspace{5mm}\\` between name and details |
| photo image | simplecv.sty:23,98 | `fig.graphicx` | `\includegraphics[width=.5\linewidth,keepaspectratio,valign=t]` |
| photo alignment | simplecv.sty:24,98 | `fig.adjustbox` | `adjustbox` option `export` supplies `valign=t` |
| two-column pair | simplecv.sty:17,104-108; main.tex:45-47 | `cols.multicol` | `multicols{2}` with `\columnbreak`; skills left, languages right |
| side-by-side projects | sections/projects.tex:7-28 | `box.minipage` | two `minipage[t]` of 0.505 and 0.48 `\textwidth` |
| section headings | simplecv.sty:15,111-113 | `head.titlesec` | `\titleformat{\section}`: format `\scshape\raggedright\Large\color{color-title}`, empty label, sep 0em, no before-code, after-code `\color{color-title}\titlerule\vspace{-\smallskipamount}` |
| section use | sections/education.tex:2; sections/volunteering.tex:2 | `head.titlesec` | `\section{...}`, one level only; the title `Volunteering \& Mentoring` is content |
| lists | simplecv.sty:19,119-128 | `list.enumitem` | `itemize` and `enumerate` with `leftmargin=*`; dense forms add `itemsep=0pt`; inner list `topsep=0pt` |
| item labels | simplecv.sty:133,135-137; sections/teaching.tex:6; sections/languages.tex:6 | `list.kernel` | `\item[label]` with `\textbullet` or `--`; `\item[]` for a label-free second line |
| entry rows | simplecv.sty:139-141; sections/education.tex:6-8 | `tbl.tabular` | `tabular*` of width `\linewidth`, columns `l@{\extracolsep{\fill}}r`, two rows `#2 & #3 \\ {\small#4} & {\small #5} \\` |
| entry row, one column | simplecv.sty:143-145 | `tbl.tabular` | same with width `0.97\textwidth` (defined, not called in the sample) |
| entry lines | simplecv.sty:131-137 | `sp.manual-space` | `\hfill` between two fields, `\vspace{-\smallskipamount}` between the two items of `\entrymid` |
| right-aligned years | sections/awards.tex:6-16; simplecv.sty:148 | `sp.manual-space` | `\hfill` plus `\phantom{\textendash 2020}` (`\fillyear`) to align single years with ranges |
| inline maths in text | sections/education.tex:15; sections/awards.tex:8 | `math.kernel` | `$3^{rd}/210$`, `$2^{nd}$` (content in an entry) |
| bibliography package | main.tex:8,11 | `bib.biblatex-bibtex` | `\PassOptionsToPackage{backend=bibtex}{biblatex}`; options `style=ieee,url=false,doi=false,maxbibnames=99,sorting=ydnt,dashed=false` |
| bibliography use | main.tex:12; sections/publications.tex:2,4 | `bib.biblatex-bibtex` | `\bibliography{papers}`, `\nocite{*}`, `\printbibliography[title=Publications]` |
| contents entry (no list printed) | sections/publications.tex:3 | `toc.kernel` | `\addcontentsline{toc}{section}{Publications}`; the sample prints no `\tableofcontents` |
| author name in bold (blocker) | simplecv.sty:151-165; main.tex:19 | none (see Blockers) | strings `Alvarez`, `Sofia`, `S.` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\theme` | main.tex:15 | yes | a colour name; print `\colorlet{color-title}{MidnightBlue}` (`color.xcolor`) |
| `\link` `\github` `\email` `\website` `\linkedin` | simplecv.sty:51,65-68 | yes | aliases of `\href`; expand inline (`meta.hyperref`) |
| `\globalcolor` and `\AtBeginDocument{\globalcolor{color-text}}` | simplecv.sty:59-62 | yes, with a remark | one text colour `color-text` set with `\color` and made the page default by `\global\let\default@color\current@color`; no conditional and no layout logic, so print the same line under `color.xcolor`; it touches `color.sty` internals, so a reviewer may disagree |
| `dummyenv` | simplecv.sty:71 | yes | empty environment used only as a group around `\HUGE` (simplecv.sty:89-92); replace with braces |
| `\headinginline`, `\headingphoto` | simplecv.sty:74-101 | yes | `minipage` + `\vspace*{\fill}` + `\HUGE` + `\textcolor` + `flushright` (+ `\includegraphics` with `valign=t`); expand inline |
| `\sidebyside` | simplecv.sty:104-108 | yes | `multicols{2}` ... `\columnbreak` ... (`cols.multicol`) |
| `\outerlist`, `\denseouterlist`, `\innerlist`, `\orderedouterlist`, `\denseorderedouterlist` | simplecv.sty:119-128 | yes | `itemize`/`enumerate` with the enumitem keys listed in the map; the body is a macro argument, so print `\begin{itemize}[leftmargin=*]` ... `\end{itemize}` around it |
| `\entry`, `\entryextra`, `\entrylabeled` | simplecv.sty:131-133 | yes | `\item\small{x}`; `\textcolor{color-detail}{\item\small{x}}` (the `\item` sits inside the colour argument, which the emitter must write literally); `\item[label]\small{x}` |
| `\entrymid` | simplecv.sty:135-137 | yes | `\item[l] \small{a} \hfill \small{b}` then `\vspace{-\smallskipamount}` then `\item[]\small{\textit{c}}` |
| `\entrybig`, `\entrybigonecol` | simplecv.sty:139-145 | yes | `\item[l]` + `tabular*` as in the map |
| `\fillyear` | simplecv.sty:148 | yes | `\phantom{x}` |
| `\titleformat{\section}` | simplecv.sty:111-113 | yes | published `titlesec` call, parameters in the map |
| `\boldname` and the two `\renewcommand` hooks | simplecv.sty:151-165 | **no** | typeset-time conditional (`\ifboolexpr`, `\ifdefequal`) inside a biblatex hook; blocker `BESPOKE/class` |

## Content-opaque
none (the one `.bib` entry, papers.bib:1-9, and the fictional CV text are content; no TikZ or other artwork)

## Lib changes
- New ways proposed: none. Considered: a way for "highlight one author in the bibliography"; it fails W1 because the macros exist only in this zip (they come from a tex.stackexchange answer cited at simplecv.sty:150, not a package) and W2 because the behaviour is code, not an option, so it was not written as a way.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Missing asset: `photo.png` for `\headingphoto` is not shipped (README.md:40-44); the call is commented out (main.tex:30-34).
- Inactive alternatives: `xeCJK` and `\babelfont` lines are comments (simplecv.sty:27-33); enabling them would need XeLaTeX.
- Build tools: `bibtex` only, which is the normal toolchain of `bib.biblatex-bibtex`; no shell escape, no pygments, no generated `.tex`. Nothing in the zip addresses an AI.
- Not read: the source of `fullpage`, `moresize`, `fontawesome5`, `titlesec`, `enumitem`, `biblatex` (published packages that ship with TeX Live or CTAN); the TeX Live `article` class.
