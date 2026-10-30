yes

# 0365-mit-thesis: MIT Thesis (mitthesis class)

- Unverified: read from the source, not compiled.
- Source: Source/0365-mit-thesis/ (origin: https://latextemplates.com/downloads/mit-thesis.zip; licence: MIT)
- Kind: thesis
- Lib: v3 (the snapshot read)
- Engine: pdfLaTeX-compatible (default fontset, main.tex:48; `\ifpdftex` branches in chapter1.tex:10 and appendixa.tex:152). Four optional fontsets (stix2, termes, termes-stix2, heros-stix2) stop under pdfTeX and need LuaLaTeX (fontsets/mitthesis-stix2.tex:15); the sample does not select them.
- Look carried by: class (title page, committee page, abstract, nomenclature, running heads and chapter look live in the published class `mitthesis`, which is not in the zip; the zip adds content, option-selected design and font files, and a representative package preamble)
- Class origin: tex-distribution-unbundled (class `mitthesis` is on CTAN and in TeX Live per https://ctan.org/pkg/mitthesis, author John H. Lienhard, MIT licence; the zip holds no `.cls` or `.sty`)
- Main file: main.tex (other samples: none; chapter1.tex, appendixa.tex, appendixb.tex, abstract.tex, acknowledgments.tex, biography.tex are `\include`d or `\input` by it)
- Read: main yes, zip-local classes and styles all (no `.cls`/`.sty` present; the style-bearing `mydesign.tex` and all 11 `fontsets/*.tex` read in full; `mitthesis-style.css` read at outline only; the class `mitthesis` itself is not bundled and its source was NOT read)

## Verdict
yes. The look is carried by the published class `mitthesis`, which the rubric counts as one way even though its source is not in the zip. Everything the zip adds (the sample preamble, the option-selected `mydesign.tex` and fontset files, the chapters) is a composition of lib ways; its bespoke macros are aliases or calls into published package APIs, each with a reduction below. The weakest reduction is the dcolumn `T` column type (appendixa.tex:15). No artwork and no tool outside TeX is needed for the PDF. Everything about the class's internals (title-page layout, running heads, `nomenclature*`, `\hrefurl`) is taken on trust from its published status.

## Blockers
none

## Class setting
- Class: `class.mitthesis` options: `twoside` (main.tex:34). Documented but not used by the sample: `fontset=<name>`, `lineno`, `mydesign` / `mydesign=<file>` (main.tex:35-56).
- Class-native vocabulary used: `\title` `\Author{name}{dept}[prev degrees]` `\Degree{degree}{dept}` `\Supervisor{name}{title}[dept]` `\Acceptor{name}{title}{office}{}` `\DegreeDate{month}{year}` `\ThesisDate{date}` `\Reader{name}{title}{dept}` (main.tex:231-297), `\maketitle` (main.tex:355), `abstract` environment (main.tex:372-374), `nomenclature*[space][heading][level]` with `\EntryHeading` and `\entry` (chapter1.tex:239-248), `\hrefurl{url}{text}` (appendixa.tex:8, 123), `\doi{}` (abstract.tex:11). Commented-out, available: `\CClicense`, `\LGO`, `\TitlePageProgramNote`, `\Tighten`, `\SignatureBlockSize`, `\AuthorNameSize`, `\Squash`, `\CMPShortenTop` (main.tex:300-349). Fontset files call class helpers `\ClassNoteNoLine`, `\ClassName`, and `\ifpdftex` (fontsets/mitthesis-defaultfonts.tex:7-8).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:34 | `class.mitthesis` | twoside |
| PDF metadata and conformance | main.tex:16-21 | `meta.documentmetadata` | lang=en-US, pdfversion=1.7, pdfstandard=a-2b; tagging off (commented, :25) |
| table tagging hint | chapter1.tex:142, 178, 199 | `meta.documentmetadata` | `\tagpdfsetup{table/header-rows={1}}` (`{1,2}` at :199) |
| paper / sides | main.tex:34 | `page.class-options` | twoside |
| page geometry | mydesign.tex:15-20 (class defaults quoted in a comment; override commented) | `page.geometry` | top=1in, bottom=1in, left=1in, right=1in, marginparwidth=50pt, headsep=12pt, footskip=0.5in; `\newgeometry{twoside,bindingoffset=1cm,...}` optional |
| running heads and feet, abstract/committee page heads | main.tex:370-371 (class "creates all the required headings and footers"); source not read | `hf.class-native` | set by the class |
| title block | main.tex:231, 236, 249, 261, 271, 283, 288, 355 | `front.maketitle` | `\title`, `\maketitle` |
| title page fields and committee-members page | main.tex:236-297 | `front.class-native` | `\Author`, `\Degree`, `\Supervisor`, `\Acceptor`, `\DegreeDate`, `\ThesisDate`, `\Reader` (a page is generated when a `\Reader` is given, main.tex:291-297) |
| abstract | main.tex:372-374; abstract.tex:11 | `abs.class-native` | `abstract` env wrapping `\input{abstract.tex}`; a `\footnote` inside (`fn.kernel`) |
| acknowledgments, biographical sketch | acknowledgments.tex:7-8; biography.tex:8-9; main.tex:376-378 | `front.dedication` | `\chapter*{...}` + `\pdfbookmark[0]{..}{..}` (`meta.hyperref`) |
| contents and lists of floats | main.tex:382-384 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables`; entry look set in the class (not read) |
| bibliography entry in contents | main.tex:405 | `toc.kernel` | `\addcontentsline{toc}{backmatter}{\refname}` |
| headings | chapter1.tex:6, 12, 42, 45, 126; appendixa.tex:4, 6 | `head.kernel` | `\chapter` `\section[short]{long}` `\subsection` `\subsubsection` `\paragraph`; look from the class (not read), or `mydesign.tex:80-99`: section 3.5ex/2.3ex `\Large\bfseries\raggedright`, subsection `\large\bfseries\raggedright`, `\mathversion{bold}` |
| heading bold math | fontsets/mitthesis-defaultfonts.tex:16-20 | `head.kernel` | `\mathversion{bold}` added to the section..subparagraph formats |
| appendices | main.tex:398-400 | `num.appendix` | `\appendix` |
| cross references | chapter1.tex:21, 42, 84, 95 | `xref.kernel` | `\label` `\ref` `~\cite`; `\eqref` is `math.amsmath` |
| starred reference in a contents title | chapter1.tex:42 | `xref.hyperref` | `\ref*` |
| hyperlink and PDF fields | main.tex:204-223 | `meta.hyperref` | pdfsubject, pdfkeywords, pdfurl, pdfcontactemail, pdfauthortitle; colours linkcolor=Blue3, citecolor=Blue3, urlcolor=violet, filecolor=red (mydesign.tex:37-43) |
| colour | mydesign.tex:28; appendixb.tex:42-45 | `color.xcolor` | dvipsnames, svgnames, x11names; names CadetBlue, Red3, Blue3, gray used in appendixb |
| fonts, default | main.tex:48; fontsets/mitthesis-defaultfonts.tex:9-12 | `font.fontenc-t1`, `math.amssymb`, `math.bm` | pdfTeX: `[T1]{fontenc}`, `amssymb`, `bm`; Computer Modern |
| fonts, optional lmodern | fontsets/mitthesis-lmodern.tex:9-13 | `font.lmodern` | T1 + `lmodern` |
| fonts, optional libertinus | fontsets/mitthesis-libertinus.tex:16-17 | `font.libertine`, `font.newtx` | `libertinus[lf,t,semibold,ScaleTT=0.9]`, `newtxmath[libertinus,vvarbb,subscriptcorrection]` |
| fonts, optional newtx | fontsets/mitthesis-newtx.tex:9-10, 12 | `font.newtx`, `font.mono` | `newtx[subscriptcorrection,varvw,helvratio=0.91]`, `inconsolata[varl,varqu,hyphenate,mono]` |
| fonts, optional newtx-sans-text | fontsets/mitthesis-newtx-sans-text.tex:11-14 | `font.newtx`, `font.family-default` | `newtx[...,defaultsups]`, `\familydefault` = `\sfdefault` |
| fonts, optional fira-newtxsf | fontsets/mitthesis-fira-newtxsf.tex:12-18, 21-31 | `font.helvet`, `font.mono`, `font.family-default`, `font.nfss` | `FiraSans[sfdefault,tabular,lf]`, `zi4[varqu,varl]`, `newtxsf[scaled=1.1]`, `\rmdefault`, `\DeclareSymbolFont`/`\DeclareMathSymbol` for digits |
| fonts, optional lucida (pdfTeX) | fontsets/mitthesis-lucida.tex:11-12 | `font.serif-pkg` | `lucidabr[expert,vargreek,altbullet]`, `[LY1]{fontenc}` (fonts are non-free, from TUG) |
| fonts, optional LuaLaTeX sets | fontsets/mitthesis-stix2.tex:21-60; -termes.tex:17-56; -heros-stix2.tex:21-68; -termes-stix2.tex:21-67; -lucida.tex:16-151; -libertinus.tex:22-69 | `font.unicode-math`, `font.fontspec` | `\setmainfont` `\setsansfont` `\setmonofont` `\setmathfont` `\setmathfontface` `\newfontface` with Extension, Scale, RawFeature (engine xe/lua; not selected) |
| microtypography | main.tex:77 | `sp.microtype` | defaults |
| line spacing (off) | main.tex:174-181 | `sp.setspace` | `\onehalfspacing` etc. all commented out |
| line numbers | main.tex:42; mydesign.tex:46-48 | `sp.draft-lineno` | class option `lineno`; `\linenumberfont` = `\sffamily\mdseries\tiny\color{violet}` |
| display maths | chapter1.tex:15-18, 50-61, 117-122; appendixb.tex:22-32 | `math.amsmath` | `equation`, `align`, `gather`, `pmatrix`, `\dfrac`, `\cfrac`, `\underbrace`, `\jot`, `\eqref`, `\DeclareMathOperator{\Erf}{erf}` (main.tex:193-194) |
| paired-delimiter operators | main.tex:195-196 | `math.mathtools` | `\DeclarePairedDelimiterXPP\erf[1]{\Erf\mkern1mu}(){}{#1}` |
| bold math | chapter1.tex:10, 48, 237 | `math.bm` | `\bm{..}` (pdftex branch) |
| figures and subfigures | chapter1.tex:24-36, 86-90 | `fig.graphicx`, `fig.subcaption` | `figure[t]`, `subfigure[t]{0.495\textwidth}`, `\subcaption`, `\includegraphics[alt={..},width=..]` (the `alt` key is the kernel graphicx key for tagged PDF) |
| float captions | chapter1.tex:35, 89, 139, 175, 196 | `cap.kernel` | `\caption{..\label{..}}`; table captions above the tabular, `\addvspace{0.5em}` (`sp.manual-space`) |
| caption look (optional design file) | mydesign.tex:54-70 | `cap.caption` | labelfont=bf, labelsep=colon, whole caption `\small` (new-format branch, kernel sockets :57-60, same effect as the `caption` package branch :66-69) |
| simple and wide tables | chapter1.tex:138-167, 174-189, 195-214 | `tbl.tabular`, `tbl.booktabs` | `tabular*{0.8\textwidth}` with `\extracolsep{\fill}`, `!{\hspace*{..}}`, `>{$}c<{$}`, `p{5cm}`, `\toprule` `\midrule` `\cmidrule(l{0.5em}){4-7}` `\bottomrule`, `table*` |
| decimal-aligned columns | main.tex:88-89; chapter1.tex:179, 200 | `tbl.siunitx` | `dcolumn`, `\newcolumntype{d}[1]{D{.}{.}{#1}}`, `d{3.3}` |
| multipage table | main.tex:94-95; appendixa.tex:25-117 | `tbl.longtable` | `\LTcapwidth=\linewidth`; `\endfirsthead` `\endhead` `\endfoot` `\endlastfoot`, `\caption[]{(continued)}`, triple vertical rules, `\\*` |
| sideways table | main.tex:97; appendixa.tex:162-190 | `fig.rotating` | `rotating[figuresright]`, `sidewaystable*` |
| table cell micro-layout | chapter1.tex:145, 159; appendixa.tex:30-33, 168 | `sp.rule`, `sp.manual-space`, `box.fancybox` | `\rule{0pt}{8pt}`, `\raisebox{1.5ex}[0cm][0cm]{Bi}`, `\\[2pt]`, kernel `\makebox[0pt][l]{14}` (same kernel box family as `\fbox`) |
| rulers and sizes | appendixa.tex:19, 22, 163; appendixb.tex:39 | `font.size-commands`, `tbl.tabular`, `sp.manual-space` | `\footnotesize`, `\small`, `\doublerulesep`=0pt, `\bigskip` |
| ragged cells | chapter1.tex:179; appendixa.tex:166 | `sp.ragged`, `sp.lengths` | `>{\raggedright}p{3.2cm}`, `\hangindent=1em \hangafter=1` |
| text marks | appendixa.tex:30, 172 | `mark.kernel` | `\textsf`, `\textit`, `\textbf`, `\texttt` |
| footnotes | chapter1.tex:84; abstract.tex:11 | `fn.kernel` | `\footnote` (look from the class, not read) |
| code listing | main.tex:65; appendixb.tex:41-56, 58-97 | `code.listings` | `\lstdefinestyle{mystyle}` backgroundcolor=`CadetBlue!15!white`, commentstyle=`Red3`, stringstyle=`Blue3`, basicstyle=`\small\ttfamily`, breaklines, numbers=left, numbersep=5pt, tabsize=2; `\lstset{language=[5.3]Lua}` |
| nomenclature (list of symbols) | main.tex:79; chapter1.tex:239-248 | `front.class-native`, `cols.multicol` | `nomenclature*[2em][Nomenclature for Chapter 1][section]`, `\EntryHeading`, `\entry`; needs `multicol` for the starred form (precedent: the v3 change log filed a class-native toc entry under the front-matter class-native line) |
| bibliography | main.tex:2, 116, 155, 405-409 | `bib.biblatex-biber` | `style=ext-numeric-comp, giveninits=true, maxbibnames=10, sorting=none, language=american`; `\addbibresource`; `\defbibheading{bibintoc}`; `\printbibliography[title={\refname},heading=bibintoc]`; biber (main.tex:2) |
| bibliography format tweaks | main.tex:119-143 | `bib.biblatex-biber` | `\multicitedelim`=`\addcomma`; per-article `\renewbibmacro{in:}{}`, `\jourvoldelim`, `\volnumdatedelim`, `issue+date`, bold `volume+number+eid` |
| filler text and its setting | main.tex:71-72; chapter1.tex:8, 19 | `draft.todo` | `\lipsum[range]`, `\setlipsum{auto-lang=false}` |
| chemistry formulas | main.tex:68; appendixb.tex:22-32 | `art.content-package` | `mhchem[version=4]`, `\ce{..}` inside `gather` (content, see Content-opaque) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\Jpsi`, `\boldA`, `\boldomega`, `\FlexBold` | chapter1.tex:10, 48, 237; appendixa.tex:152-158 | yes (BESPOKE/body, reducible) | aliases of math content with an `\ifpdftex` branch; keep the pdfTeX branch (`\bm{..}`, `\mathbf`); `math.bm`, `math.amsmath` |
| `\newcolumntype{d}`, `{h}`, `{X}` | main.tex:89; appendixa.tex:160, 23 | yes | `\newcolumntype` aliases of dcolumn's `D{sep}{sepout}{decimals}` and of plain array specs; `tbl.siunitx`, `tbl.tabular` |
| `\newcolumntype{T}`, `{j}` | appendixa.tex:15-16 | yes, weakest | uses dcolumn's private `\DC@`, `\DC@end` and `\textfont0=\the\font`; the author says (appendixa.tex:11-13) it exists so dcolumn digits follow the text font when a fontset's text and math fonts differ. Reduce to a decimal-aligned column: `D{.}{.}{3.2}` or `S[table-format=3.2]` (`tbl.siunitx`); the effect is a column parameter, not a layout algorithm |
| `\newlength{\saveheight}` + `\setlength` | appendixa.tex:145-146 | yes | a kernel length storing `\textheight` before rotation, used as the `tabular*` width; `sp.lengths` |
| `\IfPackageAtLeastTF{lipsum}{2021/09/20}{\setlipsum{auto-lang=false}}{}` | main.tex:72 | yes | kernel date test around a lipsum setting; no printed effect; `draft.todo` |
| `\renewbibmacro`, `\AtEveryBibitem`, `\renewcommand*{\jourvoldelim}`, `\defbibheading` | main.tex:119-143, 405 | yes | biblatex's documented customisation commands (same package family as `bib.biblatex-biber`, per the rubric's family ruling), fixed strings and fields only; no zip-local macro logic |
| `\section`..`\subparagraph` redefined with kernel `\@startsection` | mydesign.tex:80-99 (optional design file; see note) | yes | `\@startsection` called with its six documented arguments; `head.kernel` (or `head.titlesec` `\titleformat`/`\titlespacing`); values in the component map |
| caption sockets and hook, caption package branch | mydesign.tex:54-70 | yes | `cap.caption` labelfont=bf, labelsep=colon, font=small |
| `\AtBeginDocument{\hypersetup{..}}`, `\ifmit@lineno`, `\renewcommand{\linenumberfont}` | mydesign.tex:35-49 | yes | `meta.hyperref` colours; `\ifmit@lineno` is the class's own switch for its `lineno` option; `sp.draft-lineno` |
| `\patchcmd{\section}{\normalfont}{\mathversion{bold}\normalfont}` (and 4 more) | fontsets/mitthesis-defaultfonts.tex:16-20 (same five lines in newtx.tex:16-20, newtx-sans-text.tex:23-27, fira-newtxsf.tex:36-40, lucida.tex:156-160) | yes | published `etoolbox` patch that adds `\mathversion{bold}` to heading formats; `head.kernel` |
| `\DeclareSymbolFont`/`\DeclareMathSymbol` digits, `\renewcommand\rmdefault{\fira@family}` | fontsets/mitthesis-fira-newtxsf.tex:17, 21-31 | yes | kernel NFSS math declarations (`font.nfss`) and a `\rmdefault` setting (`font.family-default`); optional, unused |
| `\let\textsuperscript\textsu`; `\AtEndPreamble{\renewcommand{\familydefault}{\sfdefault}}` | fontsets/mitthesis-newtx.tex:12; fontsets/mitthesis-newtx-sans-text.tex:12-15 | yes | aliases to a newtx command and a `\familydefault` setting (`font.newtx`, `font.family-default`) |
| `\newcommand*{\FRAC}` | fontsets/mitthesis-termes.tex:58 (and stix2, heros-stix2, termes-stix2, libertinus) | yes | `\addfontfeature{Fractions=On}` alias (`font.fontspec`, xe/lua) |
| class `mitthesis` (title page, `nomenclature*`, `\hrefurl`, `\doi`, running heads, `backmatter` toc entry) | not in the zip | not judged | published class, one way (`class.mitthesis`); source not read |

Note on `mydesign.tex`: main.tex:34 passes only `twoside`, so by main.tex:52-53 the file is not loaded; but appendixb.tex:42-45 uses x11 colour names that only mydesign.tex:28 loads among the files in the zip, so it is treated as in scope. Either way it reduces. Its two sibling design files (main.tex:55) are not in the zip.

## Content-opaque
- mhchem `\ce{..}` equations in a `gather` (appendixb.tex:22-32): content, `art.content-package`.
- Lua source printed in an `lstlisting` (appendixb.tex:58-97): code text, printed not run.
- Large data tables and the 6x6 `pmatrix` equation (chapter1.tex:50-61; appendixa.tex:25-117, 162-190): content.
- Images `example-image-b.jpg`, `example-image-c.jpg` (chapter1.tex:27, 32, 88): not shipped, they come from the `mwe` files in the TeX tree (comment at chapter1.tex:25); assets to supply.
- `mitthesis-style.css` (798 lines): styles an HTML rendering of tagged PDF (header, mitthesis-style.css:1-7); not loaded by any `.tex`, not needed for the PDF.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
