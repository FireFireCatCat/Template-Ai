no

# 0849-webquiz: WebQuiz (online-quiz document class and its manual)

- Unverified: read from the source, not compiled.
- Source: Source/0849-webquiz/ (origin: https://mirrors.ctan.org/macros/latex/contrib/webquiz.zip; licence: gpl3+ per the manifest, GPL v3 stated in latex/webquiz.cls:7-8)
- Kind: exam (an online-quiz class; the manifest hint `cv` is wrong, and the main sample is the package's user manual)
- Lib: v6
- Engine: pdfLaTeX-compatible (the manual, and the class's plain PDF proofreading view). The web build is `make4ht` over latex, xelatex or lualatex (scripts/webquiz_makequiz.py:196); the online-manual sample and the PSTricks examples are latex+dvips only (doc/webquiz-online-manual.tex:26-29, :23)
- Look carried by: mixed (the quizzes' PDF look is `webquiz.cls`; their real product is an HTML page made by `webquiz.cfg` plus Python, CSS and JS outside TeX; the manual's PDF look is its preamble and the zip-local `webquiz-doc.code.tex`)
- Class origin: ctan
- Main file: doc/webquiz.tex (other samples: doc/webquiz-online-manual.tex, byte-identical copy doc/www/doc/webquiz-online-manual.tex (same SHA-256), 38 quiz files doc/examples/*.tex)
- Read: main yes (all 2339 lines), zip-local classes and styles all (webquiz.cls, webquiz.cfg, webquiz-ini.code.tex, webquiz-doc.code.tex, pgfsys-dvisvgm4ht.def); of the other samples I read the whole online manual, the example quizzes simple, quiz-page, theme-blue, display-as-image and answer-complex, and the first lines of choice-multiple, ctanLion and tikz-ex; the other examples only by a Grep of their preamble lines; Python scripts only at the lines cited (Grep outline of the make4ht and pst2pdf calls); JS, CSS and `.lang` files were not read in full (not LaTeX)

## Verdict
No. The package's purpose is a web page: `webquiz.cfg` only configures tex4ht to write XML tags, and a Python 3 program run after `make4ht` builds the HTML, JS and CSS pages (scripts/webquiz_makequiz.py:183-200; doc/webquiz.tex:402-407). That pipeline is `EXTERNAL`, and the tex4ht tag machinery and PostScript driver are irreducible code. The manual (main sample) also draws a TikZ banner as its cover identity (`ART`). The rest of the manual's preamble and body reduce to lib ways, and the quiz class's plain PDF proofreading view, taken alone, would reduce to `class.webquiz` (a published CTAN class); the `no` rests on the blockers above (the ART banner alone is enough for the main sample).

## Blockers
- `EXTERNAL/package` web output of the published `webquiz` bundle needs make4ht (tex4ht) plus a Python 3 program that turns the XML into HTML, JS and CSS pages; the `pst2pdf` option adds Perl, Ghostscript, pdf2svg, poppler (scripts/webquiz_makequiz.py:196; scripts/webquiz.py:73; doc/webquiz.tex:402-407, :1427-1429; latex/webquiz.cfg:24). Scope is `package` because the class origin is ctan (published), not a zip-local file
- `EXTERNAL/body` the online-manual sample stops under pdfLaTeX and its PSTricks diagrams need latex plus dvips and Ghostscript (doc/webquiz-online-manual.tex:23, :26-29); the main manual ships the finished PDF and includes it (doc/webquiz.tex:2305), so this is a secondary sample only
- `BESPOKE/class` tex4ht configuration: tag-opening and tag-closing state machine with `\WQ@closeTag`, `\HCode`/`\Tg` XML writers, `\DisplayAsImage` via `\Picture`, and a modified PGF PostScript driver (latex/webquiz.cfg:76-90, :184-199, :273-278; latex/pgfsys-dvisvgm4ht.def:35-72); irreducible even though the bundle is on CTAN, because no lib way writes tex4ht XML or PostScript driver code; runs only under tex4ht (read as published code it is not BESPOKE, and `EXTERNAL/package` above still stands)
- `ART/preamble` manual cover banner `\WebQuizTitle`: nested `tikzpicture` with blur shadow, shaded gradient node and corner boxes placed at `current page.north west` (doc/webquiz.tex:140-174, used at :197)

## Class setting
- Class: `class.webquiz` options: `theme=<name>`, `language=<name>`, `onepage`|`separatepages`, `showsidemenu`|`hidesidemenu`, `randomorder`|`fixedorder`, `tikz`, `pst2pdf`, `debugging`; every other option goes to `article` (latex/webquiz.cls:32-59, :83). Samples use `[theme=vibrant]` (doc/examples/choice-multiple.tex:1), `[onepage]` (doc/examples/onepage.tex:1), `[hidesidemenu]` (doc/examples/index-en.tex:1), `[language=french]` (doc/examples/french.tex:1), `[randomorder, showsidemenu]` (doc/examples/random.tex:1), `[tikz]`, `[pst2pdf]`, `[svgnames]` (doc/webquiz-online-manual.tex:14)
- Class-native vocabulary used: environments `question`, `choice[single|multiple, columns=n]`, `discussion[short][heading]`, `quizindex`; commands `\correct` `\incorrect` `\feedback`, `\answer[complex|integer|lowercase|number|string]{..}` and `\answer*`, `\whenRight` `\whenWrong`, `\quiz[url]{..}` and `\quiz*`, `\dref` `\qref` `\Qref` (star forms), `\BreadCrumbs` `\BreadCrumb`, `\UnitCode` `\UnitName` `\UnitURL` `\QuizzesURL`, `\Department(URL)` `\Institution(URL)` `\University(URL)`, `\DisplayAsImage`, counters `question` `choice` `quiz` `discussion` and the redefinable `\thechoice` (latex/webquiz.cls:127-146, :204-252, :285-388)
- Second class used by the main sample: `class.article` with option `svgnames` (doc/webquiz.tex:15). The header's `Class origin: ctan` refers to `webquiz.cls`, which ships in this CTAN bundle; the manual itself loads kernel `article` (not in the zip)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (manual) | doc/webquiz.tex:14-15 | `class.article` | `svgnames` (global option reaches xcolor); `\PassOptionsToClass{tikz,svgnames}{xcolor}` |
| document class (quizzes) | latex/webquiz.cls:21, :83; doc/examples/simple.tex:1 | `class.webquiz` | options above; loads `article` underneath |
| page geometry (manual) | doc/webquiz.tex:16 | `page.geometry` | a4paper, margin=30mm |
| paragraph and fuzz lengths (manual) | doc/webquiz.tex:17-19 | `sp.lengths` | `\parindent=4mm`, `\parskip=1mm`, `\hfuzz 5pt` |
| paragraph lengths (quiz class) | latex/webquiz.cls:102-103 | `sp.lengths` | `\parindent` 0pt, `\parskip` 10pt |
| source-sync switch | doc/webquiz.tex:12, :20 | none | `\synctex=1` has no printed effect, so it is no component (considered `meta.pdf-params`, a PDF-backend primitive, and not claimed) |
| file inclusion of zip-local code and data | doc/webquiz.tex:23-24, :105, :126 | `struct.input` | `webquiz-ini.code`, `webquiz-doc.code`, `webquiz.themes`, `webquiz.languages` |
| encodings | latex/webquiz-doc.code.tex:15-16; doc/webquiz.tex:30 | `font.fontenc-t1` | inputenc utf8, fontenc T1, textcomp |
| ToUnicode map | latex/webquiz-doc.code.tex:13 | `meta.glyphtounicode` | `cmap`, load-only |
| colour | latex/webquiz-doc.code.tex:28; doc/webquiz.tex:143 | `color.xcolor` | `svgnames`; `\definecolor{stone}{HTML}{E9E0D8}` |
| symbol and logo glyphs | latex/webquiz-doc.code.tex:30; doc/webquiz.tex:32, :34-35, :1249-1250 | `font.icons` | `hologo`, `manfnt` (`\textdbend`), `bbding`, `pifont` (`\ding{118}`); quiz class `bbding` `\CheckmarkBold` `\XSolidBrush` (latex/webquiz.cls:101, :338-339) |
| size commands | doc/webquiz.tex:183 | `font.size-commands` | `\tiny` in the footer; `\Huge` `\small` in the banner |
| lists, setup | latex/webquiz-doc.code.tex:18-23; doc/webquiz.tex:1551, :1959 | `list.enumitem` | `\setlist[itemize]{nosep}`, `\setlist[description]{font=\sffamily\bfseries\color{DodgerBlue}, labelwidth=\textwidth}`, `[nosep, labelwidth=18ex]` |
| lists, body | doc/webquiz.tex:240, :528, :1582 | `list.kernel` | `itemize`, `description`, `enumerate` |
| custom `heading` and `dangerous` environments | doc/webquiz.tex:49-53 | `list.kernel` | `\trivlist\item[\hskip\labelsep\textbf{#1}]`; `dangerous` label is `\textcolor{red}{\textdbend}` |
| sectioning (manual) | doc/webquiz.tex:217, :301, :543 | `head.kernel` | default article `\section` to `\subsubsection` |
| section depth | doc/webquiz.tex:55-56 | `num.secnumdepth` | `secnumdepth` 3, `tocdepth` 3 |
| heading numbering | doc/webquiz.tex:57, :2251-2252 | `num.counters` | `\thesubsubsection`=`\thesubsection\alph{subsubsection}`; appendix `\thesection` empty, `\thesubsection`=`\Alph{subsection}` |
| appendix | doc/webquiz.tex:39, :2248 | `num.appendix` | `appendix` package, `\appendix` |
| contents | doc/webquiz.tex:85, :209-211, :2249-2250 | `toc.kernel` | `\contentsname` set to `\relax`, `\tableofcontents` in a minipage, `\addcontentsline{toc}{section}{Appendices}` |
| contents entry spacing | doc/webquiz.tex:191 | `toc.tocloft` | reduction of `\patchcmd\l@section{1.0em}{0.5em}`: `\cftbeforesecskip` 0.5em (see Bespoke code) |
| minipage around contents | doc/webquiz.tex:209 | `box.minipage` | width 0.75\textwidth |
| centring | doc/webquiz.tex:207-208 | `sp.ragged` | `center` environment and `\hfil` around the contents minipage |
| header and footer (manual) | doc/webquiz.tex:181-190, :2305 | `hf.fancyhdr` | reduction of hand-written `\ps@webquiz`: empty head, foot L `\tiny` name and version, C `\textsc` (odd page: manual name, even page: last section or subsection title), R `\thepage` (see Bespoke code) |
| page style selection | doc/webquiz.tex:190, :2305 | `hf.pagestyle-kernel` | `\pagestyle{webquiz}`, `pagecommand={\pagestyle{webquiz}}` |
| running head (quiz class) | latex/webquiz.cls:150-156, :168 | `hf.class-native` | `\ps@quiz`: head with unit code, `\textsc{title}`, `Page \thepage`; `\ps@firstpage`=`\ps@empty`; `\thispagestyle{firstpage}` |
| title block (quiz class) | latex/webquiz.cls:159-173 | `front.class-native` | `\maketitle` rewritten: `\vspace*{10mm}`, centred `\large\textsc{title}`, called from `\AtBeginDocument` |
| institution and breadcrumb strings | latex/webquiz.cls:127-146 | `front.class-native` | `\UnitCode` `\UnitName` `\UnitURL` `\QuizzesURL` `\Department` `\Institution` `\BreadCrumbs`, strings; printed only in the web page and the head |
| question, choice, answer, feedback (PDF view) | latex/webquiz.cls:285-286, :319-325, :337-350, :370-388 | `class.webquiz` | `question` prints bold `Question N.`; `\correct`/`\incorrect` print a bbding glyph and `Option <q><choice>:`; `\feedback` and `\whenRight` print italic labels; `\answer` is an `\fbox` |
| answer box and cross-reference buttons | latex/webquiz.cls:247-252, :370-375 | `box.fancybox` | `\fbox{...}` around `button to question \ref{..}` and `Answer (<type> comparison):` |
| label references | latex/webquiz.cls:247-252; doc/webquiz.tex:430 | `xref.kernel` | `\label`, `\ref` |
| choice label counter | latex/webquiz.cls:293-294; doc/examples/choice-multiple.tex:3 | `num.counters` | `\thechoice` = `(\alph{choice})`, redefined to `\roman{choice})` |
| quiz class maths packages | latex/webquiz.cls:100 | `math.amsmath` | `amsmath`; `amsfonts` is `math.amssymb` |
| hyperlinks and PDF info | latex/webquiz-doc.code.tex:178-193; doc/webquiz.tex:195 | `meta.hyperref` | colorlinks, linkcolor SaddleBrown, urlcolor Brown, pdfauthor/pdfkeywords/pdfsubject from `\webquiz{..}`, `pdfinfo`, `pdftitle` |
| autoref names and links | doc/webquiz.tex:40-43, :92, :347 | `xref.hyperref` | `\sectionautorefname`=Chapter, `\subsectionautorefname`=Section, `\appendixautorefname`; `\autoref`, `\href`, `\hyperref` |
| code listings | latex/webquiz-doc.code.tex:44-153 | `code.listings` | `\lstset` (background `LightYellow!50!White`, frame=l, rulecolor Peru, breaklines, linewidth=14cm, xleftmargin=10mm, `literate` UTF-8 map), styles `latexcode` `bashcode` `pythoncode` `htmlcode`, `\lstnewenvironment`, `\lstinline`, `\lstinputlisting` |
| screenshot box | latex/webquiz-doc.code.tex:156-173 | `box.tcolorbox` | `\tcbuselibrary{skins}`; width, `arc=3mm`, `colframe=Peru`, `boxrule=0.2mm`, `colback=white`, `enhanced`, `attach boxed title to bottom right`, `fonttitle=\footnotesize`, `boxed title style`, `coltitle=Peru` |
| images | latex/webquiz-doc.code.tex:25, :170; doc/examples/ctanLion.tex:2-3 | `fig.graphicx` | `\includegraphics[width=\textwidth]`; `[dvipdfmx]`, `\DeclareGraphicsExtensions{.jpg}` |
| tables | doc/webquiz.tex:1636-1643, :2326-2334 | `tbl.tabular` | `{ll}`, `{@{}ll}` |
| table rules | doc/webquiz.tex:33, :1637-1642 | `tbl.booktabs` | `\toprule \midrule \bottomrule` |
| index | doc/webquiz.tex:45-47, :100-102, :2337 | `idx.makeidx` | `imakeidx`, `\indexsetup{level=\section*,toclevel=section,noclearpage}`, `\makeindex[intoc,columns=3]`, `\indexprologue`, `\printindex` |
| footnotes | doc/webquiz.tex:220, :439, :1285 | `fn.kernel` | `\footnote` |
| quotation blocks | doc/webquiz.tex:199, :527, :1660 | `quote.kernel` | `quote` |
| inline marks | doc/webquiz.tex:28, :1249 | `mark.kernel` | `\textcolor`, `\textit`, `\textsf`, `\texttt`, `\textsc`, `\textbf` |
| page break, spacing | doc/webquiz.tex:215, :2325, :2335 | `pg.break` | `\newpage`, `\eject`; `\vfil` is `sp.manual-space` |
| included PDF pages | doc/webquiz.tex:31, :2305 | `pg.include-pdf` | `\includepdf[pages=-,pagecommand=..]{webquiz-online-manual}` |
| manual cover banner | doc/webquiz.tex:140-174, :197 | `art.tikz` | **ART**: `shadows.blur`, `tikzset{shadowed, boxes}`, `current page.north west` |
| web page look (themes, side menu, breadcrumbs, one-page, random order, answer checking) | latex/webquiz.cfg:36-59; doc/www/css/webquiz-blue.css; doc/www/js/webquiz.js | `class.webquiz` | options only select values passed as XML attributes to the Python builder; no TeX effect; blocked by `EXTERNAL/package` |
| PSTricks diagram inside a question | doc/examples/quiz-page.tex:6, :220-228 | `art.pstricks` | content inside a question (dvips-based, see Content-opaque) |
| babel in a sample | doc/examples/french.tex:2 | `lang.babel` | `french` |
| filler text in a sample | doc/examples/discussion.tex:2 | `draft.todo` | `lipsum` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `webquiz-ini.code` (reads `webquiz.ini` into pgfkeys, `\webquiz{key}`) | latex/webquiz-ini.code.tex:19-50 | yes | emitter writes the value text (version, authors, release date) straight into the manual; content strings only |
| `webquiz-doc.code` helper macros `\TeXfht` `\ctan` `\HTML` `\CSS` `\XML` `\Javascript` `\python` `\Ghostscript` `\DefaultValue` | latex/webquiz-doc.code.tex:31-40, :154 | yes | `\newcommand` aliases of `\href`, `\texttt`, `\textcolor`: `meta.hyperref`, `mark.kernel`, `color.xcolor`; `\xspace` only trims a space in the alias body (inline expansion; a standalone `sp.xspace` was rejected in lib v4) |
| `\ScreenShot`, `\LatexCode`, `\BashCode`, `\InputLatexCode` | latex/webquiz-doc.code.tex:119-120, :131, :158-173 | yes | `box.tcolorbox` with the listed keys around `fig.graphicx`; `\lstinline[style=..]`, `\lstinputlisting[style=..]` of `code.listings` |
| `latexcode`, `bashcode`, `pythoncode`, `htmlcode` environments | latex/webquiz-doc.code.tex:118, :130, :140, :151 | yes | `\lstnewenvironment` plus `\lstdefinestyle`: `code.listings` |
| `heading`, `dangerous` environments | doc/webquiz.tex:49-53 | yes | kernel `\trivlist` with `\item[label]`: `list.kernel`, `mark.kernel`, `font.icons` |
| index helpers `\lowerCaseIndex` `\CrossIndex` `\macroIndex` `\SeeIndex` `\See` `\gobbleone` `\Item` | doc/webquiz.tex:58-81, :1067 | yes | each expands to `\index{sortkey@display!sub}` and `\index{..|See{..}}`: `idx.makeidx` |
| `\ListWebQuizThemes`, `\ListWebQuizLanguages`, `\ShowcaseThemes` (pgffor loops, `\gdef\sep`, `\ifx\theme\empty`) | doc/webquiz.tex:106-136; doc/webquiz.themes:2 | yes | the lists are data in the zip; the emitter expands them into a comma-joined text with `\index{theme!<name>}` and one `\ScreenShot` per theme |
| `\ps@webquiz`, `\webquizheader`, `\sectionmark` and `\subsectionmark` redefinition | doc/webquiz.tex:181-190 | yes (approximate) | `hf.fancyhdr` footer fields L, C, R with `\fancyfoot[LO]`/`[LE]` picking the odd and even text and `\markright` in the two mark commands; `\def` timing versus marks is not identical, unverified |
| `\patchcmd\l@section{1.0em}{0.5em}` | doc/webquiz.tex:38, :191 | yes | the patched `\addvspace{1.0em \@plus\p@}` in article's `\l@section`; `toc.tocloft` `\setlength{\cftbeforesecskip}{0.5em plus 1pt}` |
| `\AtEndPreamble{\RequirePackage{hyperref} \hypersetup{..}}` | latex/webquiz-doc.code.tex:178-194 | yes | an etoolbox hook that only delays loading `hyperref`; the emitter writes `\usepackage{hyperref}` and `\hypersetup{..}` last in the preamble: `meta.hyperref` |
| `\ifCtan` | doc/webquiz.tex:83 | yes | defined and never used; dropped |
| `\ifpdf` guard that raises `\PackageError` under pdfLaTeX | doc/webquiz-online-manual.tex:26-29 | yes | a build-mode check with no printed effect; dropped (the emitter picks the engine; the sample still needs latex+dvips for `pst-plot`) |
| `\WebQuizTitle`, `shadowed` and `boxes` styles | doc/webquiz.tex:143-174 | no | template-defining TikZ artwork, no declarative lib way: `ART/preamble` |
| `webquiz.cfg` tag-closing machine, `\WQ@openText`, `\WQ@closeTag`, `\Configure{HtmlPar}`, `\Configure{Picture}{.svg}` | latex/webquiz.cfg:21-24, :76-90, :184-199, :218-224, :267-271 | no | writes XML and HTML through `\HCode` and `\Tg`; no lib way; `BESPOKE/class` |
| `\DisplayAsImage` (real definition) | latex/webquiz.cfg:273-278; latex/webquiz.cls:108 | no | a `\NewConfigure`/`\Picture` redefinition of any command; the LaTeX class makes it a no-op; `BESPOKE/class` |
| `pgfsys-dvisvgm4ht.def` | latex/pgfsys-dvisvgm4ht.def:35-72 | no | modified copy of the PGF dvips driver with a PostScript header, tex4ht only; `BESPOKE/class` |
| syntax-check flags `\ifWQ@In...` and error messages | latex/webquiz.cls:182-190, :199-221, :261-283 | yes | inside the published class; no printed effect, so nothing to emit |
| `\WQ@Item`, `\WQ@When`, `\ps@quiz`, `\maketitle` | latex/webquiz.cls:150-164, :337, :386 | yes | published class code (CTAN); recorded as `class.webquiz` vocabulary |

## Content-opaque
- PSTricks `pspicture` diagram inside a question (doc/examples/quiz-page.tex:220-228); more in doc/examples/pstricks-ex.tex:9, doc/examples/pst2pdf.tex:2 (`pst-3dplot`) and the online manual's `pst-plot` (doc/webquiz-online-manual.tex:23); these need dvips, not pdfTeX
- TikZ picture inside a question (doc/examples/tikz-ex.tex:8)
- mhchem `\ce` (doc/examples/display-as-image.tex:2, :7)
- equations in quiz bodies (doc/examples/quiz-page.tex:14, :41), screenshot PNG and JPG assets shipped under doc/examples/ (assets to ship)

## Lib changes
- New ways proposed: none (`class.webquiz` and `class.article` are class ways and need no proposal; the web page, tex4ht and Python are outside every lib way)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
