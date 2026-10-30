no

# 0166-retosmatematicos: RetosMatematicos (Telegram group "Retos Matemáticos" solution sheets)

- Unverified: read from the source, not compiled.
- Source: Source/0166-retosmatematicos/ (origin: https://mirrors.ctan.org/macros/latex/contrib/retosmatematicos.zip; licence: cc-by-sa-4, CC BY-SA 4.0 per README:3)
- Kind: assignment (a problem statement plus worked solutions, with an ISSN and the group link in the margins; the manifest hint was `misc`)
- Lib: v3
- Engine: pdfLaTeX-compatible (the sample selects `minted`, which needs `-shell-escape` and `latexminted`, RetoMatematico.cls:173; the secondary class RetoPSTricks needs `auto-pst-pdf`, a shell-escape toolchain, RetoPSTricks.cls:26)
- Look carried by: class (RetoMatematico.cls plus its companion RetoExtra.sty from the same CTAN release; the sample preamble is one `\usepackage{RetoExtra}`, retomatematico-ejemplo.tex:7)
- Class origin: ctan
- Main file: retomatematico-ejemplo.tex (other samples: retopstricks-ejemplo.tex)
- Read: main yes, zip-local classes and styles all (RetoMatematico.cls, RetoExtra.sty, RetoPSTricks.cls, RetoTikZ.cls; the three PDFs were not read: the documentation PDF could not be rendered here)

## Verdict
`no`. RetoMatematico is a published CTAN class (the zip is its CTAN release), so on its own it would be one class way, `class.RetoMatematico`, and the sample adds only options and content. But the sample selects `codigo=minted` (retomatematico-ejemplo.tex:4), which makes the class load `minted` (RetoMatematico.cls:172-182) and use it in two code blocks (retomatematico-ejemplo.tex:21, 123): `EXTERNAL/package`, decisive. The secondary class RetoPSTricks loads `auto-pst-pdf` unconditionally (RetoPSTricks.cls:26), a second `EXTERNAL/package`. Inside the class, the TikZ page-margin artwork, heading banners, a kernel `\@makefntext` rewrite and box-and-glue integral macros in RetoExtra.sty are tagged `class` so the result can be re-read if class internals are or are not counted; they are not what decides this `no`.

## Blockers
- `EXTERNAL/package` `minted` selected by the sample through `codigo=minted`, needs shell escape and pygments/latexminted (retomatematico-ejemplo.tex:4; RetoMatematico.cls:172-182, comment at :173). The `verbatim` branch (RetoMatematico.cls:183-188) would avoid it, but the shipped sample does not use it.
- `EXTERNAL/package` `auto-pst-pdf` loaded unconditionally by the secondary class (RetoPSTricks.cls:26); the class is a standalone figure maker, the main sample does not load it.
- `ART/class` page-margin decoration on every page: TikZ `remember picture,overlay` nodes in a `shipout/background` hook, page 1 versus other pages, hard-coded shifts, rotated ISSN text, CC icons, a QR code (RetoMatematico.cls:77-99). README:10-12 names this as the template's identity.
- `ART/class` heading banners: each of `\forma`, `\nseccion`, `\seccion` draws `\section*{\tikz\node[left color=verdeodi!20,inner sep=3pt]{... \phantom{xxxxxxxxxxxxxxx}}}` (RetoMatematico.cls:129, 136, 139). A `\tcbox` with an `interior style` was considered; not shown equivalent (the shading, anchor and `\phantom` padding).
- `ART/class` emphasis box `\cajaenfasis`: `\tikz[overlay]\node[fill=verdeodi!10,...,anchor=text]` painted behind a `\phantom` copy, used as the `empheq` `box=` (RetoMatematico.cls:67, 143-147).
- `BESPOKE/class` `\@makefntext` redefinition: a right-aligned 0.7em mark box plus `\noindent` and `\parindent=1em` (RetoMatematico.cls:109-113). `fn.footmisc` options (`hang`, `flushmargin`) approximate it; the box width is not a footmisc parameter.
- `BESPOKE/class` RetoExtra.sty integral and inline-equation macros: `\inlineequation` (`\refstepcounter{equation}` plus `\@eqnnum`, `\hfill`, penalties; RetoExtra.sty:10-24), `\newint` and `\otraint` (`\lower`/`\raise` hboxes, `\settowidth` into `\longexp`, `\hspace{-0.75\longexp}`; RetoExtra.sty:44-53), `\stretchint` (a `\vcenter\hbox` around scalerel `\stretchto`; RetoExtra.sty:55). None is used in the sample body, but RetoExtra.sty is loaded by it (retomatematico-ejemplo.tex:7).

## Class setting
- Class: `class.RetoMatematico` options: `fecha={5 de agosto de 2025}`, `palabrasclave={RetoSecundaria, ago2025, álgebra, dif1}`, `codigo=minted` (retomatematico-ejemplo.tex:1-5); further key `autor` (default "José Manuel Sánchez Muñoz", RetoMatematico.cls:22, 27). It loads `class.article` with `letter,11pt,reqno` (RetoMatematico.cls:5). Options are parsed by `xkeyval` (`\define@key`, `\ProcessOptionsX`; RetoMatematico.cls:20-32).
- Class-native vocabulary used: `\ejercicio{statement}{credit}` (retomatematico-ejemplo.tex:13-18), `\forma` (:33, :102, :117), `\nseccion{title}` (:121, :133), `\enfasis{math}` (:82, :100), `\resolutores{names}` (:148), environment `codigo{language}` (:21-31, :123-131), `\l` `\r` as `\left` `\right` (:86), `\mathematica` (:122), `\maketitle` fed by the class `\title`/`\date` (:10). Defined but not used in the sample body: `\seccion`, `cajaejercicio`, `\cajaenfasis`, `Figura`, `\N` `\Z` `\Q` `\R` `\C` and doubled forms, the theorem environments, `\ihat` `\jhat` `\khat`, `\diff`, `\abs`, `\sset`.
- Secondary classes (one sample for RetoPSTricks, none for RetoTikZ): `class.RetoPSTricks` options `tamfuente` `estilopunto` `tampunto` `tamlinea` `tamflecha` `unidad`, other options passed to `standalone` (RetoPSTricks.cls:11-22; retopstricks-ejemplo.tex:1); `class.RetoTikZ` (RetoTikZ.cls:5). Both load `class.standalone` (RetoPSTricks.cls:24; RetoTikZ.cls:5).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | retomatematico-ejemplo.tex:1-5; RetoMatematico.cls:5 | `class.RetoMatematico`, base `class.article` | options above; base `letter,11pt,reqno` |
| paper, size, equation-number side | RetoMatematico.cls:5 | `page.class-options` | letter, 11pt |
| equation numbers right | RetoMatematico.cls:5 | `math.eqnumber` | `reqno` |
| page geometry | RetoMatematico.cls:12-17 | `page.setlength` | marginparwidth 0.5in, oddsidemargin 0.25in, evensidemargin 0.25in, marginparsep 0.25in, topmargin -0.1in, textwidth 6in, textheight 8.1in |
| input and font encoding | RetoMatematico.cls:7-8 | `font.fontenc-t1` | inputenc utf8, fontenc T1 |
| language | RetoMatematico.cls:9 | `lang.babel` | spanish |
| table caption name | RetoMatematico.cls:164 | `lang.babel` | `\tablename` = Tabla |
| text and maths font | RetoMatematico.cls:53 | `font.palatino` | `mathpazo` (README:10-11 says Palatino) |
| sans for banners, credit, resolutores | RetoMatematico.cls:122, 151 | `mark.kernel` | `\sf` |
| colours | RetoMatematico.cls:57-59 | `color.xcolor` | verdeodi RGB 53,113,105; azulico RGB 121,205,244 (azulico is not used in the class files read) |
| PDF metadata and links | RetoMatematico.cls:35-45 | `meta.hyperref` | pdftitle, pdfsubject, pdfkeywords, pdfauthor from option macros; colorlinks; allcolors=black; breaklinks |
| title block | RetoMatematico.cls:48-50; sample:10 | `front.maketitle` | title `\vspace{-10mm} Retos Matemáticos`, empty author, date from `fecha` |
| title restyle | RetoMatematico.cls:104-106 | `front.titling` | `\preauthor{}` `\postauthor{}` |
| first-page style | sample:11 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` (no `\pagestyle` or running head set by the class) |
| page-margin decoration | RetoMatematico.cls:70-99 | `art.tikz` (**ART**) | tikz and `calc`/`arrows` libraries; `shipout/background` hook; see Blockers |
| licence icons in the margin | RetoMatematico.cls:74, 83, 94 | `font.icons` | `ccicons` `\ccLogo` `\ccAttribution` `\ccNonCommercial` `\ccShareAlike` |
| QR code in the margin | RetoMatematico.cls:75, 86 | `art.content-package` | `qrcode` `\qrcode[hyperlink, height=10mm]{url}` (considered as a lib home; used only inside the ART block) |
| problem box | RetoMatematico.cls:61-66, 118-123; sample:13-18 | `box.tcolorbox` | `[most]`; `enhanced`, `breakable`, boxrule=1pt, arc=8pt, boxsep=0pt, left=right=0.8em, top=bottom=1ex, colback=verdeodi!20, colframe=verdeodi |
| list with letter labels | sample:14-17; RetoExtra.sty:31 | `list.enumitem` | `label={\textit{\alph*}}\hspace{0.5pt})` |
| section spacing | RetoMatematico.cls:103 | `head.titlesec` | `\titlespacing{\section}{0pt}{12pt}{8pt}` |
| class headings | RetoMatematico.cls:125-140; sample:33, 121 | `head.kernel` (`\section*`) with `art.tikz` banner (**ART**) | gradient node, `\large\bfseries\sf`, colour verdeodi |
| heading counters | RetoMatematico.cls:125-126, 132-133 | `num.counters` | `forma` and `seccion`, `\addtocounter`, printed `\theforma\textsuperscript{a} Forma` and `\theseccion.` |
| paragraph skip | RetoMatematico.cls:115 | `sp.lengths` | `\parskip=1.5mm` |
| footnote text | RetoMatematico.cls:109-113 | `fn.kernel` with bespoke `\@makefntext` | see Blockers |
| emphasised result | RetoMatematico.cls:142-147; sample:82, 100 | `math.physics` (`empheq` `box=`) with `art.tikz` overlay (**ART**) | `align*`, `\color{verdeodi}` |
| captions | RetoMatematico.cls:155-161 | `cap.caption` | format=plain, labelformat=simple, labelsep=period, font={color=verdeodi,sf}, labelfont=bf, centerlast |
| float number format | RetoMatematico.cls:162-163 | `num.counters` | `\thefigure` and `\thetable` as `\arabic` |
| figure wrapper | RetoMatematico.cls:165-166 | `box.minipage` | `\medskip`, `\noindent`, `minipage{\linewidth}` |
| figure beside text | sample:37-43, 138-143; RetoExtra.sty:42 | `fig.wrapfig` | `wrapfigure{r}{37mm}` and `{40mm}`, `\centering`, `\vspace{-4.5mm}`, `\caption{}` (empty) |
| included image | sample:40, 141 | `fig.graphicx` | `\includegraphics[scale=1]`, `[width=42mm]`; no `\usepackage{graphicx}` appears in the class or style read, so it arrives through a package loaded indirectly (not established which) |
| code blocks | RetoMatematico.cls:172-182; sample:21-31, 123-131 | `code.minted` (**EXTERNAL**) | `\begin{minted}[escapeinside=\|\|, mathescape, xleftmargin=\parindent, linenos=true]{lang}` |
| code, alternative branch | RetoMatematico.cls:183-188 | `code.verbatim` | `fancyvrb` `\DefineVerbatimEnvironment{codigo}{Verbatim}{numbers=left}`; not taken by the sample |
| theorem-like statements | RetoMatematico.cls:193-205 | `thm.amsthm` | `\newtheorem` plain for Teorema, Lema, Proposición, Corolario; `\theoremstyle{definition}` for Definición; starred copies; not used in the sample body |
| qed symbol | sample:91; RetoMatematico.cls:193 | `thm.amsthm` | `\tag*{\qedsymbol}` |
| math packages | RetoMatematico.cls:191-192; RetoExtra.sty:5 | `math.amsmath`, `math.amssymb`, `math.mathtools` | `dcases` used at sample:47 |
| math operators and macros | RetoMatematico.cls:207-260 | `math.amsmath` | `\DeclareMathOperator` (Im, Re, mcd, mcm, proy, grado, Ch, Sh, Res, Vol, `arc\,sen` family), blackboard-bold aliases, `\abs`, `\diff`, `\ihat` (`\boldsymbol`) |
| math helpers (loaded) | RetoExtra.sty:28-30, 32, 38-41 | `math.physics` (`cancel`, `polynom`, `systeme`), `math.nicefrac` (`xfrac`), `math.amssymb` (`upgreek`, `esvect`, `yhmath`) | load only; `polynom`, `systeme`, `upgreek`, `esvect`, `yhmath` filed under the existing families as judged in Lib changes |
| numbers and units | RetoExtra.sty:35; sample:99, 100, 115, 122 | `mark.siunitx` | `\num{10099}` |
| currency glyph | RetoExtra.sty:40 | `font.icons` | `eurosym`, load only |
| cross references | sample:15-16, 41, 45, 84; RetoExtra.sty:26-27 | `xref.kernel`, `xref.cleveref` | `\label` `\ref`; cleveref `capitalize`, `\crefname{equation}{Ec.}{Ecs.}` |
| links in text | sample:148 | `xref.hyperref` | `\href{mailto:...}`, `\hypersetup{urlcolor=verdeodi}` |
| citations | sample:146; RetoExtra.sty:33 | `bib.natbib` | `\cite[véase][p. 25]`, `\citet`, `\citeauthor`, `\citeyear` |
| bibliography | sample:150-154 | `bib.thebibliography` | `\bibitem[Pérez-Beato Olivier(1944)]{beato1944}`, width `{A}` |
| spacing, columns, dummy text (loaded) | RetoExtra.sty:6-7, 34; sample:35, 136, 144 | `sp.setspace`, `cols.multicol`, `draft.todo` | load only, and `\lipsum[1-2]`, `[1]`, `[2-3]` |
| coloured tables (loaded) | RetoExtra.sty:59 | `tbl.colortbl` | load only; the sample has no table |
| plots (loaded) | RetoExtra.sty:58 | `art.tikz` | `pgfplots`, load only |
| secondary: PSTricks figure class | RetoPSTricks.cls:24-28, 46-59; retopstricks-ejemplo.tex:1 | `class.RetoPSTricks` / `class.standalone`, `art.pstricks`, `font.palatino`, `color.xcolor` | standalone `border=0mm,class=scrartcl,fontsize=10pt`; `auto-pst-pdf[crop=off]` (**EXTERNAL**); `pst-eucl`, `pstricks-add`; `\psset{unit=3cm, algebraic=true, dimen=middle, dotstyle=o, dotsize=4pt 0, linewidth=0.6pt, arrowsize=3pt 2, arrowinset=0.25, linejoin=1}` |
| secondary: TikZ figure class | RetoTikZ.cls:5-35 | `class.RetoTikZ` / `class.standalone`, `art.tikz`, `math.amsmath`, `math.bm`, `font.palatino`, `font.helvet`, `font.fontenc-t1` | standalone `tikz,border=1mm`; `mathrsfs`, `avant`; `\tikzset` line widths and style `punto` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class options `autor` `fecha` `palabrasclave` `codigo`, `\ProblemaAutor` etc. | RetoMatematico.cls:22-32 | yes | `xkeyval` option parsing into strings; the emitter writes the values into `front.maketitle` `\date` and `meta.hyperref` `pdfauthor`/`pdfkeywords`/`pdftitle`; `codigo` selects the code branch |
| `cajaejercicio`, `\ejercicio` | RetoMatematico.cls:62-66, 118-123 | yes | `box.tcolorbox` keys listed above plus a `\noindent{\sf\textcolor{verdeodi}{...}}` line (`mark.kernel`, `color.xcolor`) |
| `\cajaenfasis`, `\enfasis` | RetoMatematico.cls:67, 143-147 | no | TikZ overlay node painted behind a `\phantom` copy; a `\tcbox` reduction not shown; `ART/class` |
| `\forma`, `\nseccion`, `\seccion` | RetoMatematico.cls:125-140 | counters yes, banner no | counters reduce to `num.counters`; the gradient banner is `ART/class` |
| `\resolutores` | RetoMatematico.cls:149-152 | yes | `\vspace{3mm}` (`sp.manual-space`), `\noindent`, `\sf`, colour verdeodi |
| `Figura` | RetoMatematico.cls:165-166 | yes | `box.minipage` plus `\medskip` |
| `codigo` and the two-branch conditional | RetoMatematico.cls:169-188 | yes in form | the emitter picks one branch: `code.minted` (**EXTERNAL**) or `code.verbatim` |
| shipout background hook | RetoMatematico.cls:77-99 | no | TikZ overlay at fixed coordinates, `\ifnum\value{page}=1`; `ART/class` |
| `\@makefntext` | RetoMatematico.cls:109-113 | no | kernel internal rewritten; `fn.footmisc` approximates; `BESPOKE/class` |
| theorem environments | RetoMatematico.cls:195-205 | yes | `thm.amsthm` declarations |
| math macros, operators, `\renewcommand{\sin}{\sen}`, `\renewcommand{\l}{\left}`, `\renewcommand{\r}{\right}` | RetoMatematico.cls:207-260 | yes | aliases and `\DeclareMathOperator` (`math.amsmath`); `\sen` is expected from babel spanish, `\l` and `\r` shadow the kernel `\l` and `\r` accents |
| empty `\RequirePackage{}` | RetoMatematico.cls:54 | yes | loads nothing; drop it |
| `\inlineequation` | RetoExtra.sty:10-24 | no | counter-driven inline numbered equation with `\@eqnnum`; `BESPOKE/class` |
| `\newint`, `\otraint`, length `\longexp` | RetoExtra.sty:44-53 | no | hbox raise/lower and measured kern; `BESPOKE/class` |
| `\stretchint` | RetoExtra.sty:55 | no | scalerel `\stretchto` inside `\vcenter\hbox`; scalerel considered, no lib home; `BESPOKE/class` |
| `\pstBarycenter`, `\pstcenter` | RetoPSTricks.cls:30-44 | yes | compositions of `\pstMiddleAB` and `\pstInterLL` (`art.pstricks`), used only inside figures |
| PSTricks options and `\psset` | RetoPSTricks.cls:5-22, 49-59 | yes | `kvoptions` strings fed into `\psset`; `standalone` options |
| `\tikzset` styles | RetoTikZ.cls:24-35 | yes | `art.tikz` style declarations, figure configuration |

## Content-opaque
- `pspicture*` figure of the PSTricks sample (retopstricks-ejemplo.tex:5-21), the whole content of that standalone class's sample; the main sample includes its PDF as `imagenes/ejemplo-pstricks.pdf` (retomatematico-ejemplo.tex:25, 40), which is not shipped.
- Included image `imagenes/autor` (retomatematico-ejemplo.tex:141), not shipped (missing asset; ship it).
- Code text inside `codigo` (retomatematico-ejemplo.tex:21-31, 123-131); equations, text and the bibliography entry are content.

## Lib changes
- New ways proposed: none.
- Judgements the consolidator may want to see (no `NEW:` lines): `polynom` and `systeme` filed under `math.physics` (a family of math-notation helper packages with `cancel` named in it); `upgreek`, `esvect`, `yhmath` under `math.amssymb` (extra math symbol packages); `ccicons` under `font.icons` (pictogram packages); `qrcode` under `art.content-package`; considered and not mapped: `scalerel`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
