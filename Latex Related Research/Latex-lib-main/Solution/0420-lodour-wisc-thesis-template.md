yes

# 0420-lodour-wisc-thesis-template: UW-Madison dissertation template (memoir + thesis.sty)

- Unverified: read from the source, not compiled.
- Source: Source/0420-lodour-wisc-thesis-template/ (origin: https://codeload.github.com/Lodour/wisc-thesis-template/zip/refs/heads/main; licence: MIT, LICENSE and thesis.sty:1-21)
- Kind: thesis
- Lib: v4
- Engine: pdfLaTeX-compatible (no `fontspec`, `unicode-math` or Lua code anywhere; `LY1` through `fontenc`, `lmodern`, `tgpagella`: thesis.sty:46, example.tex:7-8)
- Look carried by: zip-local (the thesis-specific look, namely spacing, page numbers, title page, front matter and contents-list styles, is in the one style file thesis.sty; memoir supplies every unset default; the sample preamble adds fonts, hyperref and natbib)
- Class origin: zip-local (the document class is `memoir`, not in the zip and not read; the template's own `thesis.sty` is zip-local, written by Yue Gao, MIT. CTAN has a package named `thesis` (Wenzel Matiaske's `thesis`/`thema` classes, read once at https://ctan.org/pkg/thesis), a different bundle that ships classes, so this `thesis.sty` is not that package)
- Main file: example.tex (other samples: none; example_contents.tex is the body `\input` at example.tex:57)
- Read: main yes, zip-local classes and styles all (thesis.sty is the only one, 386 lines read in full; `memoir` and `tocloft` sources not read)

## Verdict
Every component is a published way with declarative parameters. thesis.sty is a `memoir` page-style and front-matter kit: `\renewcommand` of memoir hooks, `\gdef` storage of title-page strings, a hand-laid title page under `\newgeometry`, tocloft-style contents settings, and a fixed `\makefrontmatter` page sequence. All of it reduces by inline expansion to lib ways with the values written out, and no artwork, external tool or output-routine code is present. The one judgement call is memoir's built-in `\DoubleSpacing`/`\OnehalfSpacing`, mapped to `sp.setspace` (see the table row and "Lib changes").

## Blockers
none

## Class setting
- Class: `class.memoir` options: `12pt`, `oneside`, `letterpaper` (example.tex:1)
- Class-native vocabulary used: `\DoubleSpacing` `\OnehalfSpacing` (thesis.sty:32,131,133; example.tex:60); `\copypagestyle` `\makeoddhead` `\makeevenhead` `\makeoddfoot` `\makeevenfoot` (thesis.sty:67-71); marks `\chaptermark` `\sectionmark` `\bibmark` `\tocmark` `\lofmark` `\lotmark` (thesis.sty:58-63); contents-title hooks `\printtoctitle` `\tocheadstart` `\aftertoctitle` and the lof/lot twins (thesis.sty:206-208,229-231,240-242); the tocloft-named `\cft...` commands (thesis.sty:211-247); `\chapter`, `\chapter*`, `\bibliography` (example_contents.tex:1, thesis.sty:316,339)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | example.tex:1 | `class.memoir` | 12pt, oneside, letterpaper |
| paper and size | example.tex:1 | `page.class-options` | letterpaper, 12pt. No margin call for the body anywhere in the zip (grep for `setlrmargins`, `geometry` finds only the title-page use), so body margins are memoir's default |
| title-page geometry | thesis.sty:164,168,188 | `page.geometry` | `\newgeometry{left=1in,right=1in,bottom=1in,top=1in}` at the start of `\maketitle`, `\restoregeometry` at its end |
| body line spacing | thesis.sty:32; example.tex:60 | `sp.setspace` | memoir's built-in `\DoubleSpacing` for the main text; `\OnehalfSpacing` before the bibliography. thesis.sty:28 says memoir ignores the `setspace` package, so these are memoir's capitalised counterparts of `\doublespacing` and `\onehalfspacing` (same type of effect, class built-in as the parameter) |
| title-page spacing | thesis.sty:128-134 | `sp.setspace` | `\OnehalfSpacing` on entering the title page, `\DoubleSpacing` on leaving |
| text encoding | thesis.sty:46 | `font.fontenc-t1` | `\usepackage[LY1]{fontenc}` (comment at :45 says it avoids Type 3 fonts). The `microtype` line at :43 is commented out, so not used |
| fonts | example.tex:7-8 | `font.lmodern`, `font.palatino` | `lmodern` then `tgpagella` (the comment at example.tex:6 says any fonts may be used) |
| running heads and marks | thesis.sty:58-63 | `hf.memoir-pagestyle` | `\chaptermark`, `\sectionmark` become `\markboth{#1}{}`; `\bibmark` `\tocmark` `\lofmark` `\lotmark` become empty. No `\pagestyle` call exists in the zip, so memoir's default style applies for ordinary pages (not read) |
| page number position | thesis.sty:67-71 | `hf.memoir-pagestyle` | `\copypagestyle{chapter}{plain}`; both feet emptied; odd head `{}{}{\thepage}` (top right), even head `{\thepage}{}{}` (top left) |
| page numbering | thesis.sty:190,262,356,385 | `pgnum.pagenumbering` | `\setcounter{page}{1}` after the title page; `\pagenumbering{roman}` for the front matter; `\addtocounter{page}{-1}` on the copyright page; `\pagenumbering{arabic}` after it |
| page breaks | thesis.sty:129,260,268,289,295,366-382 | `pg.break` | `\newpage`, `\clearpage` between every front-matter part |
| no page number on title and copyright pages | thesis.sty:130,261 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| title page | thesis.sty:128-134,166-191 | `front.titlepage-env` | hand-laid `titlepage` + `center`: bold title, "by", author, doctype line, "the requirements for the degree of", degree, `(department)`, "at the", "UNIVERSITY OF WISCONSIN--MADISON", year, all with `\\[skip]` gaps; then the defence date and committee list left-aligned (:183-185) |
| title and author fields | example.tex:24-25; thesis.sty:172,174 | `front.maketitle` | kernel `\title`, `\author` read back as `\@title`, `\@author` inside the redefined `\maketitle` |
| title-page skips | thesis.sty:137-144,172-181 | `sp.lengths`, `sp.manual-space` | `\titlepagemedskip`=0.15in, `\titlepagebigskip`=0.55in, `\committeeindent`=2em, `\committeetop`=3\titlepagebigskip (=1.65in), used as `\\[len]` |
| title emphasis | thesis.sty:172 | `mark.kernel` | `\textbf` |
| committee list | thesis.sty:148,150-160; example.tex:31-34 | `list.enumitem` | `enumerate[noitemsep,topsep=0pt,leftmargin=2em]` with one `\item[] member` per `\committeemember` (empty labels) |
| copyright page | thesis.sty:259-269 | `front.dedication` | `\null\vfill`, centered "(c) Copyright by <author> <year>" and "All Rights Reserved", `\clearpage`; no page number (`\thispagestyle{empty}`, `pg.break`, `sp.manual-space`) |
| dedication page | thesis.sty:287-297; example.tex:37 | `front.dedication` | `\null\vfill`, centered `\textit{text}` (`mark.kernel`), `\null\vfill`, `\clearpage`; printed only if a dedication exists |
| acknowledgements | thesis.sty:314-319; example.tex:38 | `front.dedication`, `head.kernel` | `\chapter*{Acknowledgements}` then the text; printed only if given |
| abstract | thesis.sty:337-343; example.tex:39 | `head.kernel`, `toc.kernel` | `\chapter*{Abstract}` plus `\addcontentsline{toc}{chapter}{Abstract}`; no `abstract` environment is used (`\abstract` is redefined at :334 as a one-argument store) |
| contents lists | thesis.sty:369,373,377 | `toc.kernel` | `\tableofcontents`, `\listoftables`, `\listoffigures`, in that order, each followed by `\clearpage` |
| contents-list styling | thesis.sty:202,211-225,234-236,245-247 | `toc.tocloft` | chapter: font, page font and number font `\bfseries`, leader `\hfill`; section: `\normalfont`, dot leader `\cftdotfill{\cftfiguredotsep}`; subsection: `\normalfont`, leader `\hfill`; figure and table entries: `\normalfont` with the same dot leader; all `afterpnum` emptied |
| contents-list titles | thesis.sty:206-208,229-231,240-242 | `front.class-native` | memoir hooks: `\printtoctitle`, `\printloftitle`, `\printlottitle` = `\chapter*{#1}`; `\tocheadstart`, `\lofheadstart`, `\lotheadstart`, `\aftertoctitle`, `\afterloftitle`, `\afterlottitle` emptied |
| front-matter order | thesis.sty:354-386 | `front.dedication` | fixed sequence: copyright, dedication, acknowledgements, contents, tables, figures, abstract |
| numbering depth | example.tex:42,45 | `num.secnumdepth` | `secnumdepth`=2, `tocdepth`=1 |
| headings | example_contents.tex:1,29,59 | `head.kernel` | `\chapter`, `\section` with memoir's default look (no `\chapterstyle`, `\setsecheadstyle` or `\titleformat` in the zip) |
| tables | example_contents.tex:5-15,17-27 | `tbl.tabular`, `tbl.booktabs` | `table[h]`, `\centering`, `tabular{cl}`/`{ll}`, `\toprule` `\midrule` `\bottomrule` |
| captions | example_contents.tex:7,19,40,51 | `cap.kernel` | plain `\caption` (memoir's default caption look; no `\captionstyle`, no `caption` package) |
| figures | example_contents.tex:35-41,46-52 | `fig.graphicx` | `figure[b]`, two `\includegraphics[scale=0.5]` side by side with `\hspace{2em}` (`sp.manual-space`), `\centering` (`sp.ragged`) |
| equation | example_contents.tex:54-56 | `math.kernel` | kernel `equation`, default numbering (no `amsmath`) |
| citations | example.tex:14-15; example_contents.tex:23-24 | `bib.natbib` | `\setcitestyle{sort,compress,numbers,square,comma}`, `\cite`, `\citet` |
| bibliography | example.tex:63-64 | `bib.bibtex-bst` | `\bibliographystyle{abbrvnat}`, `\bibliography{example.bib}` (also memoir's `\bibliography` heading look) |
| links | example.tex:11 | `meta.hyperref` | `hidelinks` |
| inline code font | example_contents.tex:11 | `mark.kernel` | `\texttt{\textbackslash ...}` |
| filler text | example.tex:19,37-39; example_contents.tex:1 | `draft.todo` | `lipsum` (`\lipsum[n]`, `\lipsum[n][m]`); the text is filler content |
| sample structure | example.tex:57 | `struct.input` | `\input{example_contents.tex}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\department` `\doctype` `\degree` `\deposityear` `\defensedate` and their defaults | thesis.sty:84-88,115-116 | yes | `\gdef` stores of strings that the title page prints; the emitter writes the values into the title-page rows (`front.titlepage-env`) |
| `\@committee`, `\committeemember` (`\g@addto@macro`) | thesis.sty:89-92 | yes | accumulates `\item[] name`; the emitter writes one `\item[]` per member into `list.enumitem` `enumerate` |
| `\checkdefined` and the `\AtBeginDocument` calls | thesis.sty:96-112 | yes | only raise `\PackageError` when a field is missing; no printed effect, dropped (the emitter always supplies the fields) |
| `\printcommittee` | thesis.sty:150-160 | yes | `\if\relax\detokenize...` is an emptiness test with an error branch; otherwise one `enumerate[noitemsep,topsep=0pt,leftmargin=2em]` |
| new `titlepage` environment | thesis.sty:128-134 | yes | inline `\newpage\thispagestyle{empty}\OnehalfSpacing` ... `\DoubleSpacing` (`pg.break`, `hf.pagestyle-kernel`, `sp.setspace`). Whether `\newenvironment{titlepage}` collides with a `titlepage` already defined by memoir was not checked (memoir source not read); inlining avoids the name |
| redefined `\maketitle` | thesis.sty:166-191 | yes | `\newgeometry`, the lines of the table above, `\restoregeometry`, `\setcounter{page}{1}`; `\textbf{\expandafter\expandafter{\@title}}` (:172) only expands `\@title` once inside a brace group, so it is `\textbf{<title>}` |
| lengths `\titlepagemedskip` etc. | thesis.sty:137-144 | yes | inline expansion of the four values |
| `\copyrightpage` | thesis.sty:259-269 | yes | the page lines in the table above |
| `\dedication`, `\printdedication` (`\ifdef`) | thesis.sty:284-297 | yes | `\ifdef` tests whether the field was given; the emitter omits the page when absent |
| `\acknowledgements`, `\printacknowledgements` | thesis.sty:311-319 | yes | same: store and presence test, then `\chapter*` |
| `\abstract` (renewed as a store), `\printabstract` | thesis.sty:334-343 | yes | store and presence test, then `\chapter*{Abstract}` + `\addcontentsline` |
| `\makefrontmatter` | thesis.sty:354-386 | yes | one fixed ordered list of the page parts above |
| `\renewcommand` of memoir marks and contents hooks | thesis.sty:58-63,206-247 | yes | parameter settings of `hf.memoir-pagestyle`, `front.class-native` and `toc.tocloft` |
| counters `tocpage` `lofpage` `lotpage` | thesis.sty:205,228,239 | yes | declared and never used anywhere in the zip (grep finds only the three declarations); dropped |
| `\ifdef` used without loading `etoolbox`, and the `\RequirePackage` list | thesis.sty:97,288,315,338; 148,164,202 | yes | thesis.sty does not load `etoolbox` itself though it uses `\ifdef` (from `etoolbox`; whether memoir supplies it was not checked); the emitter does not need `\ifdef`. The packages it does load (`enumitem`, `geometry`, `tocloft`) are lib ways |

## Content-opaque
none (the `example-image-a/b/c` files at example_contents.tex:37,39,48,50 are not shipped in the zip; they are sample images of the `mwe` package in TeX Live, not checked, so they are a missing-asset note, not a blocker; `example.bib` holds five sample entries and is content)

## Lib changes
- New ways proposed: none
- Considered: memoir's built-in spacing family (`\setSpacing`, `\DoubleSpacing`, `\OnehalfSpacing`) as a line of its own. Not proposed, because it is the same type of effect as `sp.setspace` (a line-spacing factor chosen by a name or a number) with the class built-in as the parameter, as `font.helvet` takes any sans package and `tbl.nicematrix` takes `tabu`; the maintainer may widen `sp.setspace` to say so. If a reviewer rules that a class built-in cannot be the parameter, this is the one row that would need a way.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
