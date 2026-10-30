no

# 0583-rescience-c-article: ReScience C Article

- Unverified: read from the source, not compiled.
- Source: Source/0583-rescience-c-article/ (origin: https://latextemplates.com/downloads/rescience.zip; licence: GPL-3.0-or-later per the manifest and README.md:8; fonts Apache / SIL OFL per README.md:9)
- Kind: journal
- Lib: v5
- Engine: needs XeLaTeX (or LuaLaTeX): `fontspec` is loaded unconditionally and the faces are loaded by file path from the zip (rescience.cls:61-101); the pdfLaTeX font stack is commented out (rescience.cls:52-58); bibliography backend is biber (rescience.cls:301)
- Look carried by: zip-local (the hand-written `rescience.cls` over `article` sets page, fonts, headings, title block, header/footer, bibliography; the page-corner banner and margin note are in `rescience-header.tex`, input from the body)
- Class origin: zip-local (`rescience.cls` is not on CTAN: https://ctan.org/pkg/rescience returned 404; the zip comes from latextemplates.com, not from the journal's own page, and ships its own starter text, README.md:3; rescience.cls:3 credits N.P. Rougier's upstream template)
- Main file: main.tex (other samples: none; `header.tex`, `rescience-header.tex` and `metadata.tex` are inputs of the same document)
- Read: main yes, zip-local classes and styles all (`rescience.cls` 418 lines, `header.tex`, `rescience-header.tex`, `metadata.tex`, `bibliography.bib`, README.md read in full; font files not read)

## Verdict
no. Most components map to lib ways (`class.article` under a zip-local wrapper, `page.geometry`, `font.fontspec`, `head.titlesec`, `hf.fancyhdr`, `front.authblk`, `bib.biblatex-biber`). Two things block a `yes`: the red "RESCIENCE C" tag drawn as a TikZ page-corner overlay is template-identity artwork with no declarative lib way (`ART`), and the title block is made by `\patchcmd` token surgery on the kernel `\@maketitle`, a local `tabular` redefinition around authblk's `\AB@maketitle`, and a redefinition of authblk's internal `\AB@affilsepx`, none of which any lib way expresses (`BESPOKE`). No `class.rescience` way is claimed because the class is not published.

## Blockers
- `ART/body` red "RESCIENCE C" page-corner tag: `tikzpicture[remember picture, overlay]` with a filled `\node` at `current page.north west`, `fill=darkred`, `minimum width=3.75cm`, `minimum height=10mm`, `yshift=-34mm`, text in `\SpaceRoboto` (rescience-header.tex:1-5; reached from main.tex:5 through header.tex:1)
- `BESPOKE/class` title block: `\patchcmd{\@maketitle}{center}{flushleft}{}{}` twice (rescience.cls:216-217), `\patchcmd{\@maketitle}{\LARGE}{\LARGE\sffamily\bfseries\vspace{-2.em}}{}{}` (rescience.cls:219), `\def\maketitle{{\renewenvironment{tabular}[2][]{\begin{flushleft}}{\end{flushleft}}\AB@maketitle}}` (rescience.cls:221-225), `\renewcommand\AB@affilsepx{ -- \protect\Affilfont}` (rescience.cls:232)
- `BESPOKE/body` `{\let\newpage\relax\maketitle}` switches off the kernel's `\newpage` inside `\maketitle` so the title follows the banner on page 1 (rescience-header.tex:6); no lib way does this; it belongs with the title block and banner above
- `ART/class` `\ExternalLink` icon drawn with `\tikz`, `\clip`, `\path[draw]` (rescience.cls:249-268); defined in the class but never called by the sample (the verdict does not rest on it)

## Class setting
- Class: `class.article` options: `a4paper, oneside, 10pt`, loaded by the zip-local wrapper (rescience.cls:20; main.tex:1 calls `\documentclass{rescience}` with no options). The wrapper is not a published class, so no `class.rescience` way is claimed.
- Class-native vocabulary used: `\title`, `\author`, `\affil` (authblk), `\date`, `\maketitle`, `\section`, `\marginnote`, `\parencite`, `\printbibliography`, `\eqref`; wrapper-defined names the sample reads: `\SpaceRoboto` (rescience.cls:95; used rescience-header.tex:4), the metadata macros `\dateRECEIVED` `\codeURL` `\contactEMAIL` (rescience-header.tex:8-10; defined metadata.tex:12, 2, 27); the class inputs the fixed file name `metadata.tex` (rescience.cls:272).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | rescience.cls:20 | `class.article` | a4paper, oneside, 10pt |
| paper and size | rescience.cls:20 | `page.class-options` | a4paper, 10pt |
| page geometry | rescience.cls:43-46 | `page.geometry` | a4paper, left=4.5cm, right=3cm, top=3cm, bottom=3.5cm, heightrounded, headheight=12.1pt, marginparwidth=3cm, marginparsep=0.75cm, footskip=2cm |
| margin-note side | rescience.cls:47 | `note.marginpar` | `\reversemarginpar` (kernel switch) |
| language | rescience.cls:27 | `lang.babel` | american |
| quotation package | rescience.cls:35 | `lang.csquotes` | loaded, no options; sample prints no quotation |
| fonts: main, sans, mono | rescience.cls:61-81 | `font.fontspec` | `\defaultfontfeatures{Ligatures=TeX}`; `\setmainfont` Source Serif Pro, Path=./source-serif-pro/SourceSerifPro-, Extension=.otf, UprightFont=Light, ItalicFont=LightIt, BoldFont=Regular, BoldItalicFont=It; `\setsansfont` Roboto Condensed (Light, bold=Regular, LightItalic); `\setmonofont` Source Code Pro (Light, bold=Regular) |
| extra font families | rescience.cls:83-101 | `font.fontspec` | `\newfontfamily` `\RobotoCon` (Regular, Bold), `\Roboto` (Regular, Black), `\SpaceRoboto` (Regular, Medium, LetterSpace=35) |
| font sizes | rescience.cls:125-128, 143-144 | `font.size-commands` | `\Large`, `\large`, `\small`, `\footnotesize`, `\scriptsize`, `\normalsize` (rescience.cls:207, 228-229, 405) |
| font switches | rescience.cls:125-131, 144 | `mark.kernel` | `\sffamily`, `\bfseries`, `\normalfont` |
| microtype | rescience.cls:104 | `sp.microtype` | defaults |
| colours | rescience.cls:108-115 | `color.xcolor` | `\definecolor` darkred CF232B, darkblue 2B23CF, darkgray 555555, lightgray cccccc (HTML); `\colorlet` citecolor=black, linkcolor=darkgray, urlcolor=darkgray |
| paragraph shape | rescience.cls:200 | `sp.lengths` | `\parindent`=0pt (no `\parskip` change) |
| section headings | rescience.cls:119, 125-126 | `head.titlesec` | `\titleformat{\section}` `\Large\sffamily\bfseries`, label `\llap{\textcolor{lightgray}{\normalfont\sffamily\thesection}\hskip 0.5em}`, sep 0em; sample uses `\section` (main.tex:7, 14, 25, 45, 51) |
| subsection heading | rescience.cls:127-128 | `head.titlesec` | same with `\large`; not used by the sample |
| sub-subsection heading | rescience.cls:130-135 | `head.titlesec` | `\titleformat{\subsubsection}[runin]` `\normalfont\sffamily\bfseries`, after-code `\mbox{ --- }`; `\titlespacing` 0pt, `3.25ex plus 1ex minus .2ex`, 0pt; not used by the sample |
| heading label offset | rescience.cls:126 | `sp.manual-space` | `\llap` and `\hskip 0.5em` inside the label |
| title kicker plus title | rescience.cls:404-415; metadata.tex:15-17 | `front.maketitle` | `\title{...}`: kicker `\articleTYPE~/~\articleDOMAIN` in darkred `\normalfont\sffamily\normalsize`, `\vspace{-.25em}`, then `\RobotoCon\articleTITLE`; `\date{}` (metadata.tex:38); `\maketitle` called at rescience-header.tex:6 |
| kicker spacing | rescience.cls:414 | `sp.manual-space` | `\vspace{-.25em}` |
| authors and affiliations | metadata.tex:39-42; rescience.cls:213, 227-229 | `front.authblk` | `\author{..}` `\affil{..}` twice, no labels; `\affilsep`=0.25em; `\Affilfont` `\normalfont\sffamily\footnotesize`; `\Authfont` `\sffamily\bfseries\small` |
| flush-left title block | rescience.cls:214-233 | none (blocker) | `BESPOKE/class`, see Blockers |
| header and footer | rescience.cls:274-296 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancypagestyle{plain}{}`, `\headrulewidth`=0pt, `\footrulewidth`=0pt; lhead `\scriptsize\sffamily\articleTITLE` except on page 1 (`\ifthenelse{\value{page}=1}`); chead empty; rhead `\scriptsize\sffamily\bfseries` with `\fbox{UNDER REVIEW}` while `\articleDOI` is empty; lfoot `\scriptsize\sffamily`, journal name, optional volume.issue (#number), then `\authorsSHORT~\articleYEAR`; cfoot empty; rfoot `\thepage` |
| header box | rescience.cls:286 | `box.fancybox` | `\fbox` |
| links in footer and margin note | rescience.cls:292; rescience-header.tex:9-10 | `meta.hyperref` | `\href{https://rescience.github.io/}`, `\href{\codeURL}`, `\href{mailto:\contactEMAIL}` |
| margin note | rescience-header.tex:7-10; rescience.cls:34, 207 | `note.marginnote` | `\marginnote{\footnotesize\sffamily \textbf{Received}.. \textbf{Code}.. \textbf{Contact}..}`; `\marginfont`=`\scriptsize\sffamily` |
| hyperref options | rescience.cls:151-165 | `meta.hyperref` | pdfusetitle, bookmarks=true, breaklinks=true, pdfborder={0 0 0}, citecolor/linkcolor/urlcolor, colorlinks=true, linktocpage=false, hyperindex=true, linkbordercolor=white; `\hypersetup{linkcolor=black,urlcolor=darkgray}` (also main.tex:57) |
| PDF metadata | rescience.cls:393-400 | `meta.hyperref` | pdfauthor, pdftitle, pdfkeywords, pdfsubject, pdfcreator |
| URL face | rescience.cls:165 | `meta.url` | `\urlstyle{sf}` |
| listings defaults | rescience.cls:169-195 | `code.listings` | `\lstset` basicstyle=\ttfamily\small, keywordstyle black, commentstyle gray, stringstyle black, numbers=none, frame=none, breaklines=true, captionpos=b, tabsize=2, aboveskip/belowskip=0.5em; sample has no listing |
| lists package | rescience.cls:203-205 | `list.enumitem` | loaded; both `\setlist` lines are commented out; sample has no list |
| icon box | rescience.cls:237-243 | `box.tcolorbox` | `[many]`; `\newtcbox{\iconbox}` enhanced, boxrule=0.4pt, arc=1pt, colframe=white, colback=black!10!white, fontupper=\tiny\sffamily; unused by the sample |
| extra float | rescience.cls:387-389 | `fig.float` | `\floatstyle{plain}`, `\newfloat{statement}{b!}{sst}`; unused by the sample |
| math packages | rescience.cls:39-40 | `math.amsmath`, `math.mathtools` | defaults |
| equation and reference | main.tex:17-20, 26 | `math.amsmath` | `equation`, `\eqref` |
| cross-reference | main.tex:19, 26 | `xref.kernel` | `\label{eq:logistic}` |
| table float | main.tex:31-43 | `tbl.tabular` | `table[ht]`, `tabular{lll}` |
| table rules | main.tex:2, 35, 37, 41 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| table centring | main.tex:32 | `sp.ragged` | `\centering` |
| table caption | main.tex:33 | `cap.kernel` | `\caption` above the table |
| caption style | rescience.cls:142-144 | `cap.caption` | `labelsep=period`; `\captionfont`=`\small`, `\captionlabelfont`=`\small\sffamily\bfseries` (old-style names of the `font` and `labelfont` keys; not checked against the caption source) |
| table package, unused | rescience.cls:32 | `tbl.tabularx` | loaded; sample does not use it |
| bibliography | rescience.cls:300-313, 317 | `bib.biblatex-biber` | backend=biber, style=numeric, sorting=none, giveninits=true, maxcitenames=3, mincitenames=1, maxbibnames=10, isbn=false, url=true, doi=true, autocite=superscript, natbib=true; `\addbibresource{\articleBIBLIOGRAPHY}` (metadata.tex:18) |
| bibliography declarations | rescience.cls:315-316, 350-354, 371-383 | `bib.biblatex-biber` | `\DeclareFieldFormat` for `labelnumberwidth`, `doi`, `eprint:arxiv`; `\DeclareFieldAlias`; `\bibfont`=`\small\sffamily` |
| cite commands | rescience.cls:318, 324-335; main.tex:12 | `bib.biblatex-biber` | `\renewcommand{\citet}`, `\DeclareCiteCommand{\supercite}` with brackets; the sample calls `\parencite{wilkinson2016}` only |
| bibliography calls | main.tex:59-60 | `bib.biblatex-biber` | `\setlength\bibitemsep{0pt}`, `\printbibliography` |
| bibentry package | rescience.cls:314 | `bib.natbib` | load-only (the package ships in the natbib bundle); `\bibentry` not called |
| bibliography line breaking | rescience.cls:357 | `sp.hyphenat` | `\appto{\bibsetup}{\sloppy}` |
| emphasis | main.tex:58 | `mark.kernel` | `\renewcommand\emph[1]{{\bfseries #1}}`, after the last section, so it reaches the bibliography only |
| file inclusion | main.tex:5; header.tex:1; rescience.cls:272 | `struct.input` | `\input{header.tex}`, `\input{rescience-header.tex}`, `\input{metadata.tex}` |
| page-corner tag | rescience-header.tex:1-5 | `art.tikz` | ART, see Blockers |
| abstract, keywords | metadata.tex:21, 28; rescience.cls:396 | none | `\articleABSTRACT` is defined but nothing prints it (grep of the class and sample); keywords go only into `pdfkeywords` |
| contents, index, theorems, footnotes, code, lists in body | main.tex:1-62 | none | the sample has none of these |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class wrapper `rescience` | rescience.cls:17-418 | partly | `\LoadClass[a4paper, oneside, 10pt]{article}` plus `\RequirePackage` of published packages with options reduces to the rows above, except the items marked "no" below |
| `\patchcmd` of `\@maketitle`, `\def\maketitle`, `\AB@affilsepx` | rescience.cls:214-233 | no | token replacement inside kernel and authblk internals (`center` to `flushleft`, `\LARGE` to `\LARGE\sffamily\bfseries\vspace{-2.em}`, a local `tabular` redefinition around `\AB@maketitle`). `front.titling` hooks are a different construction and are not shown to give the same block next to authblk |
| banner `tikzpicture` | rescience-header.tex:1-5 | no | page-corner TikZ overlay carrying the journal name; `ART`. A `pg.textpos` block with `\colorbox` would be a re-implementation with other geometry rules and is not shown equal |
| `\let\newpage\relax` in the title group | rescience-header.tex:6 | no | disables a kernel command inside `\maketitle`; `pg.break` only emits breaks |
| `\ExternalLink` | rescience.cls:249-268 | no | TikZ icon drawing; unused by the sample |
| metadata `\def` macros | metadata.tex:2-36 | yes | plain strings; the emitter writes the values inline into `\title`, `\author`, `\affil`, `\hypersetup`, header and footer fields |
| `\ifdefempty`, `\ifthenelse{\value{page}=1}` | rescience.cls:278-294, 407-412 | yes | the emitter knows at write time whether DOI, volume and domain are empty and prints the chosen branch in `hf.fancyhdr` fields; the page-1 blank head is a kernel counter test (or a first-page style) |
| `\iconbox`, `\orcid`, `\doi`, `\github` | rescience.cls:238-246 | yes | `box.tcolorbox` key list; `\newcommand` aliases of `\href`; unused by the sample |
| `\renewcommand\nolinkurl[1]{#1}` | rescience.cls:363 | yes | identity alias of a hyperref command |
| biblatex `\DeclareFieldFormat`, `\DeclareFieldAlias`, `\DeclareCiteCommand{\supercite}` | rescience.cls:315, 324-335, 350-354, 371-383 | yes (borderline) | documented biblatex customisation calls over biblatex's own macros, copied from its defaults with brackets added or a space removed; none runs in the sample |
| `\renewcommand\emph` | main.tex:58 | yes | alias of `\bfseries` |
| `\detokenize\expandafter{\codeURL}` | rescience-header.tex:9 | yes | inline the URL string as link text |
| `\newfloat{statement}` | rescience.cls:387-389 | yes | `fig.float` call; unused |

## Content-opaque
none (the equation at main.tex:17-20 and the table body at main.tex:34-42 are plain content; the banner is template artwork, not figure content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
