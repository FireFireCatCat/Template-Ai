no

# 0857-opteng: SPIE Optical Engineering and OE Letters manuscript template (`opteng`)

- Unverified: read from the source, not compiled.
- Source: Source/0857-opteng/ (origin: https://mirrors.ctan.org/macros/latex/contrib/opteng.zip; licence: lppl)
- Kind: journal
- Lib: v6
- Engine: needs latex + dvips + ps2pdf (PSTricks banner and the `ps2pdf` driver of hyperref, OptEngInstruct.tex:35, 56); not pdfLaTeX-compatible as written, pdfTeX does not draw PSTricks (not tested here)
- Look carried by: mixed (opteng.sty, a CTAN house-style package over `article`, sets page, columns, headings, abstract, captions, bibliography; the sample preamble adds `times`, hyperref and the PSTricks banner)
- Class origin: ctan
- Main file: OptEngInstruct.tex (other samples: none; README is a usage note; OptEngInstruct.pdf is shipped and was not read)
- Read: main yes, zip-local classes and styles all (opteng.sty lines 1 to 568, the one style file)

## Verdict
The look is a published CTAN style (`opteng.sty`, LPPL, ctan.org/pkg/opteng read) over kernel `article`, so most components map to lib ways and the style itself is one class-like way, `class.opteng`, as the lib treats other house-style add-ons. The verdict is `no` for two reasons that sit outside the style's plain text-setting: the style loads `pstricks` unconditionally and the sample draws its OE Letters banner with it, which needs a dvips and ps2pdf route outside pdfTeX, and that banner is template-identity artwork drawn in PSTricks primitives. No new way is needed.

## Blockers
- `EXTERNAL/package` pstricks is loaded unconditionally by the style (opteng.sty:33), the sample calls `\psframe` and `\rput` (OptEngInstruct.tex:56) and selects hyperref's `ps2pdf` driver (OptEngInstruct.tex:35): the output exists only through latex, dvips and Ghostscript `ps2pdf`; the EPS figure `fig_1.eps` (OptEngInstruct.tex:223, not shipped) fits the same route
- `ART/preamble` the grey "OE Letters" band with label text and the footer strings is drawn with `\fancyput` + `\psframe` + `\rput` at absolute centimetre coordinates (OptEngInstruct.tex:56; the Optical Engineering variant at :59 is the same kind); the lib has only the restricted `art.pstricks` for it

## Class setting
- Class: `class.article` options: `10pt`, `letterpaper`, `fleqn`, plus the package option `optenglett` read from the global options (OptEngInstruct.tex:28; alternatives `optengjnl` at :26 and `optengsubmit` at :30; opteng.sty:58, 84, 110, `\ProcessOptions` at :567; README:13-22)
- Class: `class.opteng` (CTAN `opteng.sty` v1.1, `\usepackage{opteng}` OptEngInstruct.tex:34; the CTAN page calls it a template with an associated style; a house-style add-on, class-like as `class.llncsconf` and `class.revquantum` in the lib's change log). It loads `overcite`, `geometry`, `amsmath`, `fancybox`, `pstricks`, `graphicx` (opteng.sty:29-34)
- Class-native vocabulary used: `\title{}` `\author{}` `\address{}` `\email{}` (printed at call time, `\maketitle` is emptied, opteng.sty:136), `\SPIEmember`, `\subjterm{}`, `\loginfo{}`, `\doi{}`, `abstract` (re-defined, appends copyright, DOI, subject terms, log line), `\acksect*{}` (unnumbered italic heading for acknowledgments and references), `biography` environment `[picture]{name}`, `\citeonline{}` (overcite); defined but not used by the sample: `eqnfloat`, `eqnfloat*`

## Component map
Rows marked (in style) are set inside `opteng.sty`; `class.opteng` carries them as a bundle and the way named is the equivalent published component way (the reduction).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | OptEngInstruct.tex:28 | `class.article` | 10pt, letterpaper, optenglett, fleqn |
| house-style package | OptEngInstruct.tex:34; opteng.sty:25-27, 58, 567 | `class.opteng` | option `optenglett` (others `optengjnl`, `optengsubmit`, a closed list of three) |
| paper and size | OptEngInstruct.tex:28 | `page.class-options` | letterpaper, 10pt |
| page geometry (in style) | opteng.sty:60 (jnl :86, submit :112) | `page.geometry` | letterpaper, hcentering, height=60pc, top=2cm, bottom=2cm, left=1.5cm, right=2.4cm (jnl height=55pc; submit height=60pc, top/bottom/left/right=2.5cm) |
| two columns (in style) | opteng.sty:59, 85 (submit: none) | `cols.twocolumn-cmd` | bare `\twocolumn` in option code; `\columnsep` 0.8cm (:61) |
| Optical Engineering title block over columns (commented variant) | OptEngInstruct.tex:64, 109-110 | `cols.twocolumn-cmd` | `\twocolumn[ ... ]` with a 1cm `\vskip` before the closing `]` |
| author and abstract side by side (commented variant) | OptEngInstruct.tex:69, 90-93, 108 | `cols.minipage` | minipage 7cm and 10cm, `\hfill` |
| line spacing (in style) | opteng.sty:59, 85, 111 | `sp.linespread` | 0.925 (lett, jnl), 1.2 (submit) |
| paragraph lengths (in style) | opteng.sty:61-63 | `sp.lengths` | `\columnsep`0.8cm, `\parindent`1em, `\parskip`0pc |
| bottom flush (in style) | opteng.sty:64 | `pg.flush` | `\flushbottom` |
| space after period (in style) | opteng.sty:472 | `sp.frenchspacing` | `\frenchspacing` |
| hyphenation exceptions (in style) | opteng.sty:474-564 | `sp.hyphenat` | about 90 `\hyphenation` patterns |
| manual spacing in front matter (in style) | opteng.sty:41, 68, 72-75, 118 | `sp.manual-space` | `\vskip1pc`, `\vskip0.5pc`, `\hskip6pt`, `\vskip-1pc` |
| text face | OptEngInstruct.tex:50 | `font.mathptmx` | `times` |
| title, author, label fonts (in style) | opteng.sty:67-70, 73, 99, 118, 140-144, 192 | `font.size-commands` | `\huge`, `\Large`, `\normalsize`, `\small`, `\footnotesize`, `\scriptsize` |
| sans, bold, italic switches (in style) | opteng.sty:67-70, 72, 140, 192 | `mark.kernel` | `\sf`, `\textsf`, `\bf`, `\textbf`, `\textit` |
| grey colour (in style) | opteng.sty:36 | `color.color` | `\definecolor{MyGray}{rgb}{0.9,0.9,0.9}`; the package that provides `\definecolor` is not named in the source (pstricks or hyperref pull one in, not verified) |
| link colours | OptEngInstruct.tex:41-44 | `meta.hyperref` | colorlinks=true, linkcolor=red, citecolor=green, breaklinks=true |
| PDF metadata and driver | OptEngInstruct.tex:35-45 | `meta.hyperref` | `ps2pdf` driver, pdftitle, pdfauthor, pdfsubject, pdfkeywords, `final` |
| `\href` in the reference | OptEngInstruct.tex:425 | `meta.hyperref` | `\href{url}{text}` |
| page overlay position | OptEngInstruct.tex:56, 59 | `bg.fancybox` | `\fancyput(17.5cm,2.5cm){...}`; the source attributes `\fancyput` to fancybox (OptEngInstruct.tex:130-131), the CTAN fancybox page does not name it |
| banner and running footer drawing | OptEngInstruct.tex:56 | `art.pstricks` | `\psframe[linestyle=none,fillstyle=solid,fillcolor=MyGray]`, `\rput` of "OE Letters" `\Large\bf\textsc`, "Optical Engineering" and `\today/Vol.~00(0)` `\footnotesize\textsf`: ART blocker |
| running head and foot | none set; banner above | none | article default page style, no `\pagestyle` call in either file |
| title block | opteng.sty:67-70 (jnl :93-96; submit :118-121); OptEngInstruct.tex:66-79 | `front.class-native` | `\title` `\huge\bf\textsf`, `\author` `\vskip1pc\bf\textsf`, `\address` `\textsf`, `\email` `\textsf{E-mail:~}`; submit option centres each in `center` |
| member mark | opteng.sty:49; OptEngInstruct.tex:77 | `front.class-native` | `\SPIEmember` = `, \sf\footnotesize{MEMBER SPIE}` |
| abstract | opteng.sty:72-75 (jnl :98-102; submit :123-126); OptEngInstruct.tex:95-104 | `abs.class-native` | lead-in "Abstract." bold sans, end part prints `\@spiecopyright` (`\copyright`, year, SPIE) and `\@doi` italic `\scriptsize`, then subject terms and log line |
| subject terms line | opteng.sty:46, 74; OptEngInstruct.tex:81-82 | `abs.keywords` | `\subjterm{...}` printed as "Subject terms:" |
| DOI and log info | opteng.sty:39-40, 47-48; OptEngInstruct.tex:84, 86 | `abs.class-native` | `\doi{}` (prefix "DOI:~"), `\loginfo{}` (default "Paper 000000R compiled \today.") |
| section headings (in style) | opteng.sty:194-205 | `head.kernel` | `\@startsection` levels 1 to 3: before -2.5ex plus -1ex minus -.2ex / -2.25ex..., after 1.3ex plus .2ex / 1ex plus .2ex, fonts `\sffamily\normalsize\bfseries`, `\sffamily\normalsize\itshape`, `\sffamily\small` |
| heading number format (in style) | opteng.sty:192 | `head.kernel` | `\@seccntformat` = `\sf\textbf{number\quad}` |
| unnumbered closing heading (in style) | opteng.sty:206-209; OptEngInstruct.tex:407 | `head.kernel` | `\acksect` = `\@startsection{acksection}{1}` with `\sffamily\normalsize\itshape`, used starred |
| lists | OptEngInstruct.tex:122-138, 154-168 | `list.kernel` | `itemize`, `enumerate` |
| footnote | OptEngInstruct.tex:314 | `fn.kernel` | `\footnote` |
| displayed maths | OptEngInstruct.tex:195-219; opteng.sty:31 | `math.amsmath` | `equation`, `split`, `align`, `\nonumber`, `\dfrac`, `\bigl` |
| equation alignment | OptEngInstruct.tex:28 | `math.eqnumber` | `fleqn` |
| figure | OptEngInstruct.tex:222-227; opteng.sty:34 | `fig.graphicx` | `\includegraphics[width=\linewidth]{fig_1.eps}`, `figure` and `figure*` (:232, :275) |
| centring | OptEngInstruct.tex:223, 239, 252 | `sp.ragged` | `\centerline`, `\centering` |
| float placement (in style) | opteng.sty:141 | `fig.placement` | `\def\fps@table{h}` |
| equation float (in style, unused) | opteng.sty:220-244 | `fig.newfloat` | `eqnfloat` and `eqnfloat*`, placement `!tp`, type 4; reduction `\DeclareFloatingEnvironment[placement=!tp]{eqnfloat}` |
| table | OptEngInstruct.tex:238-247, 251-260 | `tbl.tabular` | `tabular{ccccc}`, `\hline`, `table*` for the nine-column table |
| caption call | OptEngInstruct.tex:224, 240 | `cap.kernel` | `\caption{}` |
| caption layout (in style) | opteng.sty:140-156 | `cap.caption` | reduction: label font `\footnotesize\sf\textbf`, label text "Fig." and "Tab.", separator two `~`, centred when one line else paragraph (the `singlelinecheck` default); `\tablename` leaks `\footnotesize\sf` into the table caption text (:142) |
| reference list (in style) | opteng.sty:159-186; OptEngInstruct.tex:418-427 | `bib.thebibliography` | `thebibliography{99}` re-defined: `\acksect*{\refname}` head, label `\@arabic\c@enumiv .`, `\leftmargin` .2in + `\labelsep`0.5em, `\itemsep`0.05pc, `\footnotesize` |
| reference list penalties (in style) | opteng.sty:178-182 | `sp.penalties` | `\clubpenalty`4000, `\widowpenalty`4000, `\sloppy` |
| mark case (in style) | opteng.sty:161 | `mark.case` | `\MakeUppercase\refname` in `\@mkboth` (marks unused by the default page style) |
| citations (in style) | opteng.sty:29; OptEngInstruct.tex:296-298 | `bib.cite-pkg` | `overcite`: superscript numbers, `\cite`, `\citeonline` |
| BibTeX route (commented) | OptEngInstruct.tex:415-416 | `bib.bibtex-bst` | `\bibliographystyle{spie}`, `\bibliography{spiebib}`; the `.bst` and `.bib` are not shipped |
| cross-references | OptEngInstruct.tex:196, 226, 269-273 | `xref.kernel` | `\label`, `\ref` |
| code listing of the markup | OptEngInstruct.tex:157, 317-331 | `code.verbatim` | `\verb+...+`, `verbatim` under `\scriptsize` |
| author biography | opteng.sty:292-304; OptEngInstruct.tex:435-445 | `fig.class-native` | `\begin{biography}[picture]{name}` text `\end{biography}`: photo 25mm by 32mm at left, text wrapped on the right, `\sf\footnotesize`, name bold |
| figures and tables at the end (commented) | OptEngInstruct.tex:52 | `fig.endfloat` | `tablesfirst,notablist,nomarkers` |

## Bespoke code
All of it sits in `opteng.sty`, which is published on CTAN, so it is part of the `class.opteng` way and not counted as a blocker. Reducibility is recorded so the result can be re-read if the style were not counted as published.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `biography` environment, `\getpic`, `\main@bio`, `\endmain@bio`, `\prune`, `\createparshapespec`, `\computeilg`, 7 counts (2 more per `\getpic` call), 11 dimens, 5 token lists, 13 boxes | opteng.sty:256-446 | No | `\parshape` lists built per line, `\vsplit` loops, glyph-height scan of 128 characters, picture aspect-ratio test with `\typeout` warnings and `\frame` fallback; copied from ieee.cls (:253). `wrapfig` would give a photo with wrapped text but not this logic. Would be BESPOKE/class under a stricter reading |
| `\@makecaption` redefinition and `\fnum@figure`, `\figurename`, `\tablename` | opteng.sty:140-156 | Yes | `cap.caption`, see the map row |
| section commands and `\acksect` | opteng.sty:192-209 | Yes | `\@startsection` calls as in article.cls, or `head.titlesec`; parameters in the map |
| `thebibliography` re-definition | opteng.sty:159-186 | Yes | kernel `\list` use; `bib.thebibliography` with the lengths and penalties listed; `\settowidth\labelwidth{.25in}` measures the string ".25in" (a quirk, reproduce as written) |
| option bodies `optenglett`, `optengjnl`, `optengsubmit` | opteng.sty:58-128 | Yes | three parameter sets of the same ways (geometry, `\twocolumn`, `\linespread`, lengths, title commands, abstract); closed list of three names |
| metadata stores `\@subjterm`, `\@loginfo`, `\@doi`, `\@spiecopyright`, `\@issncopyright`, `\address`, `\email`, `\subjterm`, `\loginfo`, `\doi`, `\SPIEmember` | opteng.sty:38-49 | Yes | string macros expanded into the abstract end part; `\@issncopyright` is never printed |
| `eqnfloat`, `eqnfloat*` | opteng.sty:51-52, 214-244 | Yes | `fig.newfloat`; not used by the sample |
| `\glpinclude`, `\glpexclude` | opteng.sty:449-470 | Yes | dead code, never called in the zip (checked by grep) |
| `\newif\ifo@lett`, `\ifo@jnl` | opteng.sty:21-22 | Yes | dead, never set or tested (checked by grep) |

## Content-opaque
- `fig_1.eps` figure (OptEngInstruct.tex:223) and the biography photo `fig_1` (OptEngInstruct.tex:435): not shipped
- sample equations (OptEngInstruct.tex:195-219), table cells "TEST" (:240-260), the one reference entry (:420-425), dummy sections (:376-400)

## Lib changes
- New ways proposed: none. Considered: `overcite` as its own way, folded into `bib.cite-pkg` (a citation package, the package is the parameter); a one-journal style package as a component way, kept as `class.opteng`
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
