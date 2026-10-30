no

# 0761-tidyres: tidyres (tidy formal resume package, v3.0.0) and its manual

- Unverified: read from the source, not compiled.
- Source: Source/0761-tidyres/ (origin: https://mirrors.ctan.org/macros/latex/contrib/tidyres.zip; licence: cc-by-4)
- Kind: cv (the zip is a resume package; its only sample is the package manual, an article-based document)
- Lib: v6
- Engine: needs XeLaTeX or LuaLaTeX (the sample loads `fontspec` and `unicode-math`, tidyres-doc.tex:8; the manual says XeLaTeX or LuaLaTeX at tidyres-doc.tex:58-60; tidyres.sty itself loads no engine-specific package)
- Look carried by: mixed (tidyres.sty defines the resume interface and base layout; the manual's preamble sets fonts, margin and link colours; the manual's code boxes would come from a commented-out block in tidyres.sty)
- Class origin: tex-distribution-unbundled
- Main file: tidyres-doc.tex (other samples: none; README.md and tidyres-doc.pdf are documentation, the PDF was not readable here)
- Read: main yes, zip-local classes and styles all (tidyres.sty, 197 lines, in full)

## Verdict
`no`. Everything tidyres.sty actively does reduces to published packages with declarative parameters: `\restitle`, `ressection`, `\ressep`, `\hlbox` and the `expkv` key sets are macro wrappers over `paracol`, `tabularray`, `tcolorbox`, `enumitem`, `setspace`, `fontawesome` and `hyperref`, and the manual's own preamble and body map to existing ways. The blocker is the manual's `codebox` environment: it is used seven times, no active line of the zip defines it, and the only definition is commented out in tidyres.sty:158-196 as a `tcblisting` with `listing engine=minted` (Pygments and shell escape), which is EXTERNAL. Without `codebox` the other constructs would reach `yes`; I did not guess a `listings` look for an environment the zip does not define.

## Blockers
- `EXTERNAL/class` the `codebox` environment used by the sample (tidyres-doc.tex:103, 114, 124, 137, 171, 195, 274) has no active definition; its only definition is commented out (tidyres.sty:158-196) and selects `listing engine=minted` (tidyres.sty:161-163) after `\tcbuselibrary{minted}` (tidyres.sty:137), so it needs `minted` with Pygments if reactivated; it also fills a line-number gutter with a raw TikZ `\fill` in the tcolorbox `overlay` (tidyres.sty:188-190) and reads `\texthr` from the manual's preamble (tidyres-doc.tex:20)

## Class setting
- Class: `class.article` options: `a4paper`, `10pt` (tidyres-doc.tex:1); kernel class, source not in the zip and not read
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (tidyres-doc.tex:24-26, 31), `\tableofcontents` (tidyres-doc.tex:32), `\section` `\subsection` (tidyres-doc.tex:39, 41); no `abstract`

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | tidyres-doc.tex:1 | `class.article` | a4paper, 10pt |
| paper and size | tidyres-doc.tex:1 | `page.class-options` | a4paper, 10pt |
| page geometry | tidyres.sty:19; tidyres-doc.tex:11 | `page.geometry` | package default top=bottom=left=right=0.5in; the manual overrides with `\geometry{margin = 1in}` |
| two-column resume section | tidyres.sty:20, 38, 108, 110, 112 | `cols.paracol` | `\columnratio{0.12, 0.88}` (a paracol command, not defined by tidyres), `paracol` with 2 columns, `\switchcolumn` |
| paragraph and column lengths | tidyres.sty:36-37 | `sp.lengths` | `\parindent`=0pt, `\columnsep`=2em |
| line spread | tidyres.sty:40 | `sp.linespread` | `\linespread{1.15}` |
| title block spacing | tidyres.sty:27, 77, 93 | `sp.setspace` | `spacing` environment, factor 1.15 |
| title block table | tidyres.sty:21, 78-92 | `tbl.nicematrix` | `tblr` of tabularray: column{1}={l}, column{2}={r}, column{3}={l}, cell{1}{1}={r=4}{}, colspec={X[5]X[2.8]X[2.2]}, closing `\hline` |
| title icons and logos | tidyres.sty:26, 30, 86-89; tidyres-doc.tex:58-59 | `font.icons` | `fontawesome` `\faLocationArrow` `\faAt` `\faPhone` `\faLinkedinSquare`; `hologo` `\hologo{XeLaTeX}` |
| name and field fonts | tidyres.sty:85, 87, 90 | `font.size-commands`, `mark.kernel` | `\fontsize{22}{22}\selectfont`, `\scshape` on the name, `\itshape` on email and Linkedin id |
| title block link | tidyres.sty:28, 90 | `meta.hyperref` | `hidelinks`; `\href{<url>}{Linkedin - ...}` |
| manual spacing | tidyres.sty:85, 94, 113, 116 | `sp.manual-space` | `\hspace{6mm}`, `\vspace{1.15em}`, `\vspace{2.5ex}`, `\vspace*{0.5ex}` |
| resume section title | tidyres.sty:106-114 | `mark.kernel` | `\scshape` title in column 1; the body goes in column 2 |
| resume lists | tidyres.sty:22, 39 | `list.enumitem` | `\setlist{label=\textbullet, leftmargin=*, nolistsep}` |
| colour package | tidyres.sty:25, 124-125 | `color.xcolor` | option `dvipsnames`; `#1!10!white`, `#1!50!black` mixes |
| inline highlight box | tidyres.sty:29, 121-134 | `box.tcolorbox` | `[most]`; `\newtcbox{\hlbox}[1][gray]`: on line, arc=3pt, colback, colframe, before upper, fontupper, boxrule=0pt, boxsep=0pt, left=right=2pt, top=bottom=1pt |
| hlbox strut | tidyres.sty:126 | `sp.rule` | `\rule[-3pt]{0pt}{10pt}` |
| hlbox font | tidyres.sty:127 | `mark.kernel` | `\ttfamily` |
| loaded, not printed | tidyres.sty:23-24 | `math.amsmath`, `math.amssymb` | load-only; the manual has no maths |
| manual title | tidyres-doc.tex:24-26, 31 | `front.maketitle` | `{\tt tidyres} for Tidy Formal Resume`, `\itshape` author, version date |
| contents list | tidyres-doc.tex:10, 32 | `toc.kernel` | `\tableofcontents`; `\contentsname` redefined to `\centering Table of Contents` |
| centering | tidyres-doc.tex:10, 89-91 | `sp.ragged` | `\centering`, `flushright` |
| headings | tidyres-doc.tex:39, 41, 95, 97 | `head.kernel` | stock `\section`, `\subsection`, no customisation |
| page style and numbering | tidyres-doc.tex:33, 36-37 | `hf.pagestyle-kernel`, `pgnum.pagenumbering` | `\thispagestyle{empty}`, `\pagestyle{plain}`, `\setcounter{page}{1}` |
| page breaks | tidyres-doc.tex:35, 93, 128, 175 | `pg.break` | `\newpage` |
| manual lists | tidyres-doc.tex:46; 233-238, 246-250 | `list.enumitem`, `list.kernel` | `enumerate[label = \textbullet, leftmargin = 6ex, topsep = 4ex]`; plain `enumerate` inside the live `ressection` examples |
| licence block | tidyres-doc.tex:5, 90 | `front.doclicense` | type=CC, modifier=by, version=4.0; `\doclicenseImage` |
| widened block | tidyres-doc.tex:7, 255-259 | `page.adjustwidth` | `adjustwidth{-15pt}{-15pt}` |
| frame behind the live example | tidyres-doc.tex:253-259 | `sp.manual-space`, `box.tcolorbox` | `\vspace{-6cm}` pulls up, `\vspace{5cm}` inside `tcolorbox[standard jigsaw, opacityback = 0.1, colback = gray, boxrule = 0.5pt]` |
| title example box | tidyres-doc.tex:154-163 | `box.tcolorbox` | same keys as above around a live `\restitle` |
| text fonts | tidyres-doc.tex:8, 14-16, 18-20 | `font.fontspec` | `\setmainfont{TeX Gyre Termes}`, `\setsansfont{TeX Gyre Heros}`, `\setmonofont{NewComputerModernMono10}`, three `\newfontfamily` (`\textcm` and `\texttm` unused; `\texthr` only in the commented codebox) |
| maths font | tidyres-doc.tex:8, 17, 21 | `font.unicode-math` | `\setmathfont{NewComputerModernMath}`, `\unimathsetup{math-style = TeX, bold-style = TeX}` |
| link colours | tidyres-doc.tex:9, 81 | `meta.hyperref` | `colorlinks = True`, `allcolors = cyan`; `\href{url}{text}` |
| inline code | tidyres-doc.tex:47-51, 54, 68 | `code.verbatim` | `\verb+...+` |
| font and colour marks | tidyres-doc.tex:25, 75, 85, 197 | `mark.kernel`, `color.xcolor` | `\itshape`, `{\tt}`, `{\bf}`, `{\sl}`, `\textcolor{red}`, `\textcolor{Cyan}` |
| manual code display box | tidyres.sty:137-196 (commented); used tidyres-doc.tex:103 and six more | `code.tcblisting`, `code.minted` | `tcblisting` with `listing engine=minted`, `minted style=manni`, language `tex`, `linenos`; **EXTERNAL**, see Blockers |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\restitle` | tidyres.sty:75-95 | yes | inline expansion: `spacing{1.15}` around the `tblr` of the title block (rows: name with `\hspace{6mm}` and 22pt `\scshape`, then icon and value for location, email, phone, Linkedin), `\vspace{1.15em}` after; the six values are content |
| `tidyres` key set (expkv) | tidyres.sty:31, 49-61 | yes | `\ekvdefinekeys` `store`/`initial` only keep six strings with empty defaults; no printed effect, so the emitter writes the values straight into the expanded body |
| Linkedin URL conditional | tidyres.sty:64-70 | yes | an `\ifx` on an empty string choosing the explicit URL or `https://www.linkedin.com/in/<id>/`; the emitter picks the string and passes it to `\href` (`meta.hyperref`) |
| `ressection` environment and its key set | tidyres.sty:101-114 | yes | `paracol{2}`, `\scshape` title (default string `Section`), `\switchcolumn`, content, `\end{paracol}`, `\vspace{2.5ex}` |
| `\ressep` | tidyres.sty:116 | yes | alias of `\vspace*{0.5ex}` |
| `\hlbox` | tidyres.sty:121-134 | yes | one `\newtcbox` call (declarative keys, colour is the parameter) |
| `\texthr`, `\textcm`, `\texttm` | tidyres-doc.tex:18-20 | yes | `\newfontfamily` of installed fonts under `font.fontspec` |
| `codebox` (commented) | tidyres.sty:158-196 | no | not reducible to lib ways without the Pygments route; see Blockers |
| `cprotect` | tidyres-doc.tex:6 | n/a | loaded and never called (no `\cprotect` in the manual), no printed effect |

## Content-opaque
none (the manual has no figure, table float or drawing; the `\restitle` and `ressection` examples carry placeholder resume text, which is content)

## Lib changes
- New ways proposed: none. Considered and not proposed: `tidyres` itself (published on CTAN, but a thin wrapper that reduces to existing ways, so no new line is needed); `expkv` (macro-internal key storage, reduces by inline expansion as the rejected `sp.xspace` did); `cprotect` (load-only, never called); `cv.entries` was the closest existing line but names the moderncv/altacv family, so it is not used.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
