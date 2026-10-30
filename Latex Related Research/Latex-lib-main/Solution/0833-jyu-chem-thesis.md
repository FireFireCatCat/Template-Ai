no

# 0833-jyu-chem-thesis: JYU Chemistry Department thesis template (Finnish bachelor and master theses)

- Unverified: read from the source, not compiled.
- Source: Source/0833-jyu-chem-thesis/ (origin: https://mirrors.ctan.org/macros/latex/contrib/jyu-chem-thesis.zip; licence: LPPL 1.3c, README:5)
- Kind: thesis
- Lib: v6
- Engine: pdfLaTeX-compatible (README:9 says it was tested with pdfLaTeX on Overleaf); `minted` additionally needs shell escape and Pygments, see Blockers
- Look carried by: mixed (kernel `article` with the look set in the sample preamble, jyu-chem-thesis-template.tex:14-96; the reference look sits in the biblatex style files jyu-chem-thesis.bbx and jyu-chem-thesis.cbx, which are published on CTAN as part of this package)
- Class origin: tex-distribution-unbundled
- Main file: jyu-chem-thesis-template.tex (other samples: none; jyu-chem-thesis-example.pdf is only the output of the template and was not read)
- Read: main yes, zip-local classes and styles all (no `.cls` or `.sty` in the zip; both `.bbx` and `.cbx` read in full)

## Verdict
The look itself is recoverable: kernel `article` plus published packages with parameters (geometry, fancyhdr, caption, `\linespread`, hyperref, biblatex), and the zip-local macros are small aliases or a counter wrapper that reduce by inline expansion. The answer is still `no` because the preamble loads `minted` unconditionally (jyu-chem-thesis-template.tex:62), sets a minted style (:63) and the body uses a `minted` block (:255-258); `minted` needs shell escape and Pygments outside TeX, so the rubric's ruling makes it `EXTERNAL/package`. Nothing else blocks: the cover background is an included PDF placed with a TikZ node, which reduces to a page-background way, and the chemistry markup is content.

## Blockers
- `EXTERNAL/package` `minted` loaded unconditionally and used (jyu-chem-thesis-template.tex:62, :63, :255-258); needs shell escape and Pygments, so the document does not compile without the tool.

## Class setting
- Class: `class.article` options: a4paper, 12pt, finnish (jyu-chem-thesis-template.tex:14; `twoside` is only in a comment, :13). The `finnish` option is global and reaches `babel`. The class is not bundled in the zip; its source was not read.
- Class-native vocabulary used: `\section` `\subsection` and the starred `\section*` (:126, :131, :136, :167, :172, :279), `titlepage` environment (:105), `table` and `figure` floats, `\tableofcontents` (:159), `itemize` (:282), `\footnote` (:263). No `\maketitle`, no `abstract` environment (the abstract is a starred section, :126).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | jyu-chem-thesis-template.tex:14 | `class.article` | a4paper, 12pt, finnish |
| paper and size | jyu-chem-thesis-template.tex:14 | `page.class-options` | a4paper, 12pt |
| encoding | jyu-chem-thesis-template.tex:15, :48 | `font.fontenc-t1` | fontenc T1; inputenc utf8 |
| language | jyu-chem-thesis-template.tex:16 | `lang.babel` | finnish |
| caption-name strings | jyu-chem-thesis-template.tex:74, :77 | `lang.babel` | `\renewcommand\refname{Viitteet}`, `\renewcommand{\contentsname}{Sisällysluettelo}` (string overrides; whether they survive babel's own caption hook was not checked) |
| quotation marks | jyu-chem-thesis-template.tex:66 | `lang.csquotes` | load-only (required by biblatex) |
| page geometry | jyu-chem-thesis-template.tex:27 | `page.geometry` | top=2.5cm, bottom=1.5cm, inner=2.5cm, outer=2.5cm |
| head height | jyu-chem-thesis-template.tex:28 | `page.setlength` | `\headheight` 14.5pt |
| line spacing | jyu-chem-thesis-template.tex:30 | `sp.linespread` | `\linespread{1.3}` |
| paragraph shape | jyu-chem-thesis-template.tex:31-32 | `sp.lengths` | `\parindent` 0pt, `\parskip` 1.5ex |
| header/footer | jyu-chem-thesis-template.tex:33-37 | `hf.fancyhdr` | `\fancyhf{}`, `\fancyhead[C]{\thepage}`, `\pagestyle{fancy}`, `\headrulewidth` 0pt |
| empty page style on one page | jyu-chem-thesis-template.tex:158 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` before the contents |
| page number format | jyu-chem-thesis-template.tex:96 | `num.counters` | `\renewcommand{\thepage}{\roman{page}}` |
| page numbering reset | jyu-chem-thesis-template.tex:122, :161 | `pgnum.pagenumbering` | `\setcounter{page}{2}`; `\pagenumbering{arabic}` |
| page breaks | jyu-chem-thesis-template.tex:122, :124, :130, :135, :157, :160, :165 | `pg.break` | `\newpage`, `\cleardoublepage` |
| cover page | jyu-chem-thesis-template.tex:105-120 | `front.titlepage-env` | `titlepage` with `center` and `flushleft`, hand-laid |
| cover spacing | jyu-chem-thesis-template.tex:107, :112, :116-118 | `sp.manual-space` | `\vspace{10cm}`, `\vskip 4cm`, `\hspace{9cm}` |
| cover centring | jyu-chem-thesis-template.tex:108-111, :113 | `sp.ragged` | `center`, `flushleft` environments |
| cover title font | jyu-chem-thesis-template.tex:79, :109 | `font.size-commands` | `\fontsize{18pt}{22pt}`, with `\bf` and `\fontfamily{phv}\selectfont` |
| cover author block font | jyu-chem-thesis-template.tex:116 | `font.nfss` | `\fontfamily{phv}\selectfont` (Helvetica) |
| cover background image | jyu-chem-thesis-template.tex:106 | `bg.eso-pic` | full-page `\includegraphics[width=\paperwidth,height=\paperheight]` of jyu-chem-thesis-background.pdf, centred on the page; reduction in Bespoke code |
| abstract and preface pages | jyu-chem-thesis-template.tex:126-133 | `head.kernel` | `\section*{Tiivistelmä}`, `\section*{Esipuhe}`; a starred section, not an `abstract` environment |
| contents entries | jyu-chem-thesis-template.tex:127, :132, :137, :275, :280 | `toc.kernel` | `\addcontentsline{toc}{section}{...}` |
| contents list | jyu-chem-thesis-template.tex:159 | `toc.kernel` | `\tableofcontents` |
| headings | jyu-chem-thesis-template.tex:167, :172, :261, :270 | `head.kernel` | stock `\section`, `\subsection`; no `titlesec`, no counter change |
| abbreviation table | jyu-chem-thesis-template.tex:138-156 | `tbl.tabular` | `table[h!]`, `tabular{lll}`, `\hline`, `\textbf` header (`mark.kernel`) |
| data table | jyu-chem-thesis-template.tex:194-205 | `tbl.tabular` | `table[!hbtp]`, `center`, `tabular{rccc}`, `\hline\hline` |
| booktabs | jyu-chem-thesis-template.tex:19, :54 | `tbl.booktabs` | load-only, twice; the body uses `\hline`, not `\toprule` |
| table and figure captions | jyu-chem-thesis-template.tex:195, :220, :247 | `cap.kernel` | `\caption` with `\label` |
| caption look | jyu-chem-thesis-template.tex:38 | `cap.caption` | margin=10pt, labelfont=rm, labelsep=period |
| figure float | jyu-chem-thesis-template.tex:245-249 | `fig.graphicx` | `figure[!ht]`, `\centering`, `\includegraphics[width=0.5\linewidth]{example-image-b}` |
| graphics loading | jyu-chem-thesis-template.tex:17, :49, :52 | `fig.graphicx` | loaded three times |
| EPS conversion | jyu-chem-thesis-template.tex:18 | `fig.epstopdf` | load-only; no EPS file is included, so not EXTERNAL here |
| equations | jyu-chem-thesis-template.tex:178-190 | `math.amsmath` | `equation`, `align`, `\label`, `\text`; numbers via `xref.kernel` `\ref` at :183, :191 |
| math packages | jyu-chem-thesis-template.tex:20, :50, :55 | `math.amsmath` | loaded three times |
| math symbols | jyu-chem-thesis-template.tex:20, :56 | `math.amssymb` | load-only |
| St Mary Road symbols | jyu-chem-thesis-template.tex:21, :57 | `math.amssymb` | `stmaryrd`, load-only twice, no command used; filed here as a math symbol-font package (considered: `font.icons`, rejected because the symbols are math-mode) |
| decimal comma | jyu-chem-thesis-template.tex:22, :58 | `math.icomma` | load-only, twice |
| physics notation | jyu-chem-thesis-template.tex:23; :230, :236-238 | `math.physics` | `\expval`, `\mel`, `\dd` |
| colour | jyu-chem-thesis-template.tex:59 | `color.xcolor` | dvipsnames |
| links | jyu-chem-thesis-template.tex:41-47 | `meta.hyperref` | colorlinks, linkcolor=black, citecolor=black, urlcolor=black |
| URLs | jyu-chem-thesis-template.tex:24; :192 | `meta.url` | `\usepackage{url}`, `\url{...}` |
| footnote marks | jyu-chem-thesis-template.tex:25 | `fn.footmisc` | option `symbol` |
| footnote | jyu-chem-thesis-template.tex:263 | `fn.kernel` | one `\footnote` |
| cross-references | jyu-chem-thesis-template.tex:183, :191, :215, :243 | `xref.kernel` | `\ref`, `\label` |
| list | jyu-chem-thesis-template.tex:282-286 | `list.kernel` | `itemize` with `\item[Liite 1:]` labels |
| list indent | jyu-chem-thesis-template.tex:283 | `sp.lengths` | `\itemindent=5mm` |
| appendix list page | jyu-chem-thesis-template.tex:279-286 | `head.kernel` | `\section*{Liitteet}` (no `\appendix`) |
| dummy text package | jyu-chem-thesis-template.tex:61 | `draft.todo` | `lipsum`, load-only, never called |
| source code | jyu-chem-thesis-template.tex:62-63, :255-258 | `code.minted` | `\usemintedstyle{vs}`, `minted` block with language python (**EXTERNAL**) |
| bibliography engine | jyu-chem-thesis-template.tex:67, :73, :276 | `bib.biblatex-biber` | `style=jyu-chem-thesis, doi=true, backend=biber`; `\addbibresource{jyu-chem-thesis.bib}`; `\printbibliography[title=Viitteet]` |
| citation commands | jyu-chem-thesis-template.tex:184, :263 | `bib.biblatex-biber` | `\cite` (superscript, set by the cbx), `\citeinline` (declared in the cbx) |
| bibliography style (reference look) | jyu-chem-thesis.bbx:4-291; jyu-chem-thesis.cbx:4-88 | `bib.biblatex-biber` | style name is the parameter; files published on CTAN with this package (see Bespoke code); content summarised below |
| chemistry markup | jyu-chem-thesis-template.tex:51, :60, :81, :53 | `art.content-package` | `chemfig`, `mhchem` `version=3` (twice), `tikzducks` (load-only placeholder duck pictures); content |
| TikZ package | jyu-chem-thesis-template.tex:29 | `art.tikz` | loaded for the one cover node at :106 and for `tikzducks`; no drawing of its own |

The bbx/cbx content, read from source: numeric base style (bbx:4), Finnish language map (bbx:7), options `sorting=none`, `giveninits=true`, `minnames=999`, `maxnames=999`, `isbn`, `eprint` off (bbx:10-18); family-given names with `;` between authors and ` ja ` before the last (bbx:23-30); initials with period and space (bbx:33-34); journal title italic, article volume italic, article year bold (bbx:46-53); pages without prefix, `ss.` for books (bbx:56-59); one driver per entry type for article, book, thesis, incollection, inproceedings, patent, online, misc and report (bbx:96-291); the cbx makes `\cite` and `\autocite` superscript with compressed numbers, `\parencite` bracketed, `\footcite` as footnote and adds `\citeinline` as plain numbers (cbx:4, :10-22, :24, :33, :66, :81).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\reaction`, `\reaction@`, `\reaction@nonumber`, counter `reaction`, `\thereaction`, `\reactiontag` | jyu-chem-thesis-template.tex:83-92; used at :212 | yes | Preamble: `\newcounter{reaction}` and `\renewcommand\thereaction{R\arabic{reaction}}` (`num.counters`). Each call becomes `\begin{equation}\ce{...}\label{key}\refstepcounter{reaction}\tag{\thereaction}\end{equation}` (`math.amsmath`, `xref.kernel`, `art.content-package` for `\ce`), or `equation*` without `\tag` for the starred form. The `\@ifstar` and `\ifx\@empty#1\@empty` tests only choose which form to print, so the emitter resolves them per call. Scope: preamble and body. |
| `\otsikko` | jyu-chem-thesis-template.tex:79; used at :109 | yes | alias of `font.size-commands` `\fontsize{18pt}{22pt}`, `mark.kernel` `\bf`, `font.nfss` `\fontfamily{phv}\selectfont`; expands inline inside the `center` environment |
| `\onlinecite` | jyu-chem-thesis-template.tex:95 | yes | alias of `\hspace{-1 ex}` (`sp.manual-space`) and `\nocite` plus `\citenum` (`bib.biblatex-biber`); never called in the sample (grep shows only the definition). `\citenum` is declared neither in the sample nor in the cbx, and it was not checked whether biblatex provides it; the macro has no printed effect as written. |
| `\renewcommand\@biblabel[1]{#1.}` | jyu-chem-thesis-template.tex:93 | yes | kernel `thebibliography` label hook; biblatex builds its own labels (bbx:20), so the line is dead under `bib.biblatex-biber` and can be dropped |
| cover background TikZ node | jyu-chem-thesis-template.tex:106 | yes | `\tikz[remember picture,overlay] \node[opacity=0.99,inner sep=0pt] at (current page.center){\includegraphics[...]{...}}` only places a shipped PDF at page centre; no TikZ drawing. Reduces to `bg.eso-pic` `\AddToShipoutPictureBG*{\includegraphics[width=\paperwidth,height=\paperheight]{jyu-chem-thesis-background.pdf}}` on the cover page (the 0.99 opacity is a rendering hack; `color.transparent` could repeat it). The artwork lives in the shipped PDF, an asset. Read as `ART` instead, it would not change the verdict. |
| `jyu-chem-thesis.bbx` and `jyu-chem-thesis.cbx` | jyu-chem-thesis.bbx:1-293; jyu-chem-thesis.cbx:1-90 | published, not bespoke by W1 | The zip is the CTAN package `jyu-chem-thesis` (ctan.org/pkg/jyu-chem-thesis read: LPPL 1.3c, v1.0 of 2026-02-11, maintainer Marko Melander), so the style files are released with public documentation and are a value of the `style=` parameter of `bib.biblatex-biber`. The emitter writes `style=jyu-chem-thesis` and ships the two files. Their drivers and field formats use only biblatex's own declaration commands (`\DeclareBibliographyDriver`, `\DeclareFieldFormat`, `\renewbibmacro`, `\DeclareCiteCommand`). The bbx names itself `jyu-chem.bbx` in `\ProvidesFile` (bbx:1), the cbx `jyu-chem.cbx` (cbx:1). If a reviewer treats them as zip-local, no lib way expresses driver code and they would be `BESPOKE/package`; the verdict `no` does not depend on this. |

## Content-opaque
- `\chemfig{...}` structure inside the figure float (jyu-chem-thesis-template.tex:219) and inline `\ce{C2H5OH}`, `\ce{Na+Cl-}` and the `\reaction` argument (:210, :212): chemistry, `art.content-package`.
- The shipped cover artwork jyu-chem-thesis-background.pdf (referenced at :106) and the bibliography database jyu-chem-thesis.bib (:73): assets and content.
- `example-image-b` (:246): placeholder image from the `mwe` package, an asset.
- Considered, not loaded: `wrapfig` (the text at :243 names it, but no `\usepackage{wrapfig}` exists and the figure at :245-249 is a plain float).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
