no

# 0584-mimosis-thesis: Mimosis Thesis (latex-mimosis)

- Unverified: read from the source, not compiled.
- Source: Source/0584-mimosis-thesis/ (origin: https://latextemplates.com/downloads/mimosis-thesis.zip, upstream github:Pseudomanifold/latex-mimosis per README.md:4; licence: MIT)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (README.md:14; the pdfTeX branch is main.tex:76-79; an XeLaTeX/LuaLaTeX branch with `fontspec` and `unicode-math` is main.tex:59-75, chosen by the class conditional mimosis.cls:19-25)
- Look carried by: mixed (zip-local class `mimosis.cls` on `scrbook` carries page, headings, spacing, glossary styles, maths helpers; the sample preamble carries fonts, hyperref, biblatex setup; `bibliography-mimosis.tex` and `english-mimosis.lbx` carry the bibliography look)
- Class origin: zip-local
- Main file: main.tex (other samples: none; body files Sources/Title.tex, Sources/Abstract.tex, Sources/Introduction.tex)
- Read: main yes (with the three included body files and both bibliography files), zip-local classes and styles all (mimosis.cls 220 lines; no .sty; `Thesis.bib` is content: three `@Book` entries)

## Verdict
The look is a zip-local class (`mimosis.cls`: `\LoadClass{scrbook}` plus published packages and KOMA settings) and most of it reduces to lib ways. It cannot be rebuilt from published packages and parameters alone, because the bibliography look is made by rewriting biblatex's own driver macros (`\renewbibmacro`, `\savebibmacro`/`\restorebibmacro` with state booleans) and by a hand-rolled ordinal-suffix counter loop in the zip-local `.lbx`. Those are irreducible bespoke code in the sample's preamble, so the answer is `no`. Nothing else blocks: there is no template artwork, no tool outside the usual TeX toolchain (biber, makeindex, makeglossaries as for the lib's biblatex and glossaries ways), and no unmapped component.

## Blockers
- `BESPOKE/preamble` biblatex `cite` and `textcite` are wrapped so the hyperlink also covers the author name: `\savebibmacro`/`\restorebibmacro`, `\ifboolexpr` with `\ifnumequal{\value{citecount}}...`, `\ifbool{cbx:parens}` and `\global\boolfalse{cbx:parens}` (bibliography-mimosis.tex:138-177)
- `BESPOKE/preamble` hand-rolled ordinal suffix algorithm: `\@tempcnta`, `\@whilenum` loops, `\ifcase` over the remainder, printed through `\mkbibsuperscript`, installed into `\mkbibordinal` and the gendered variants (english-mimosis.lbx:11-24)
- `BESPOKE/preamble` biblatex driver macros rewritten with conditionals: `in:` (`\ifentrytype`), `issue+date` and `volume+number+eid` (`\iffieldundef`, `\setunit`/`\newunit`), `publisher+location+date`, `organization+location+date`, and `\finalnamedelim` with `\ifthenelse{\value{listcount} > 2}` (bibliography-mimosis.tex:34-101); the effect is editing biblatex's code, not choosing option values (W2)

## Class setting
- Class: `class.scrbook` (reached through the zip-local wrapper class `mimosis`, mimosis.cls:9-16), options: `a4paper`, `twoside`, `11pt`, `cleardoublepage=empty`, `numbers=noenddot`, `titlepage`, `toc=bibliography`, `toc=index`; `typearea` options `DIV=10`, `BCOR=10mm` passed first (mimosis.cls:4-7). The sample line is `\documentclass{mimosis}` with no options (main.tex:1).
- Class-native vocabulary used: `\frontmatter` `\mainmatter` `\backmatter` (main.tex:129,135,163), `\chapter` (Sources/Introduction.tex:2), `\section` `\subsection`, `\part[short]{long}` (main.tex:137), `\subtitle` (main.tex:124), `\setkomafont` (mimosis.cls:209-215), `\usekomafont`, `\partformat`, `\raggedpart`, `\chapterformat`, `\autodot` (mimosis.cls:206-220), `\bookmarksetup{startatroot}` (main.tex:162).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | mimosis.cls:9-16; main.tex:1 | `class.scrbook` | a4paper, twoside, 11pt, cleardoublepage=empty, numbers=noenddot, titlepage, toc=bibliography, toc=index |
| paper, size, sides | mimosis.cls:9-12 | `page.class-options` | a4paper, 11pt, twoside |
| text block | mimosis.cls:4-7 | `page.typearea` | DIV=10, BCOR=10mm (passed to `typearea` before the class loads it) |
| blank pages before chapters | mimosis.cls:12 | `hf.class-native` | cleardoublepage=empty (KOMA option) |
| page style | mimosis.cls:199-200 | `hf.scrlayer-scrpage` | `\pagestyle{scrheadings}`, no `\ohead` or `\ifoot` fields set |
| empty page after title | Sources/Title.tex:28-31 | `pg.break` + `hf.pagestyle-kernel` | `\newpage\null\thispagestyle{empty}\newpage` |
| line spacing | mimosis.cls:146-147; main.tex:79 | `sp.setspace` | `\onehalfspacing` (class); `\singlespacing` in the pdfTeX font branch |
| spacing wrapper in part title | main.tex:147-153 | `sp.setspace` | `singlespace*` environment with `\onehalfspacing` |
| widow and club control | mimosis.cls:191-193 | `sp.penalties` | clubpenalty=10000, widowpenalty=10000, displaywidowpenalty=10000 |
| engine switch | mimosis.cls:18-25; main.tex:59 | (resolved by the emitter) | see Bespoke code |
| font setup, pdfTeX | mimosis.cls:30-31 | `font.fontenc-t1` | `fontenc` T1, `inputenc` utf8 |
| font setup, Xe/Lua | mimosis.cls:28 | `font.fontspec` | loaded unconditionally in that branch |
| main text face (pdfTeX branch) | main.tex:77 | `font.serif-pkg` | `ebgaramond`, option lf |
| mono face (pdfTeX branch) | main.tex:78 | `font.mono` | `sourcecodepro`, options oldstyle, scale=0.7 |
| main and math faces (Xe/Lua branch) | main.tex:60-62,65-74 | `font.unicode-math` | `\setmathfont{Garamond Math}`, second `\setmathfont{STIX Two Math}[range={\sharp,\natural,\flat,\clubsuit,\spadesuit,\checkmark}]` |
| text and mono faces (Xe/Lua branch) | main.tex:61,75 | `font.fontspec` | `\setmainfont{EB Garamond}`, `\setmonofont[Scale=MatchLowercase]{Source Code Pro}` |
| engine logos | main.tex:3; Sources/Introduction.tex:45 | `font.icons` | `metalogo` (`\XeLaTeX`, `\LuaLaTeX`; the logo-by-name type, as `hologo`) |
| colour | mimosis.cls:54; main.tex:23-25 | `color.xcolor` | option dvipsnames; named colour RoyalBlue |
| languages | mimosis.cls:38; Sources/Introduction.tex:194-204 | `lang.babel` | ngerman, french, english (english last); body `\selectlanguage{ngerman}` and back |
| quotation marks | mimosis.cls:40; Sources/Introduction.tex:201-204 | `lang.csquotes` | autostyle=true; body `\enquote{...}` |
| links and PDF metadata | main.tex:21-27 | `meta.hyperref` | colorlinks=true, citecolor=linkcolor=urlcolor=RoyalBlue, unicode |
| bookmarks | main.tex:29,162 | `meta.bookmark` | `\bookmarksetup{startatroot}` |
| title fields | main.tex:123-125 | `front.maketitle` | `\title`, `\author` |
| subtitle field | main.tex:124 | `front.koma-title` | KOMA `\subtitle` |
| title page body | Sources/Title.tex:1-26 | `front.titlepage-env` | `titlepage` env, `\vspace*{5cm}`, `center`, `\Huge` title, `\Large` subtitle, `\emph{by}`, author, `\vfill`, degree text, `\textsc{...}`; reads `\@title` `\@subtitle` `\@author`, test `\ifdefempty{\@subtitle}` |
| title page spacing and sizes | Sources/Title.tex:2,5-12 | `sp.manual-space` + `font.size-commands` | `\vspace*{5cm}`, `\\[0.1cm]`, `Huge`/`Large` environments |
| abstract page | Sources/Abstract.tex:1-9 | `sp.ragged` + `mark.kernel` | hand-laid: `center` with `\textsc{Abstract}`, then `\noindent` text (no `abstract` environment) |
| contents | main.tex:133; mimosis.cls:15-16 | `toc.kernel` + `toc.koma` | `\tableofcontents`; toc=bibliography, toc=index |
| file inclusion | main.tex:130,131,158 | `struct.input` | `\include{Sources/Title}`, `\include{Sources/Abstract}`, `\include{Sources/Introduction}` |
| part heading | main.tex:137-156; mimosis.cls:206-209 | `head.kernel` + `head.class-native` + `head.koma-fonts` | `\part[A good part]{...}` with a `minipage` inside; `\partformat` = `\huge\partname~\thepart\autodot`, `\raggedpart` = `\flushleft`, `\setkomafont{part}{\normalfont\huge\scshape}` |
| chapter heading | mimosis.cls:218-220 | `head.class-native` | `\chapterformat` = `\fontsize{50}{55}\selectfont\thechapter\autodot\enskip` |
| section heading font | mimosis.cls:211 | `head.koma-fonts` | `\setkomafont{sectioning}{\normalfont\scshape}` |
| heading numbers | mimosis.cls:13 | `head.class-native` | numbers=noenddot |
| description label font | mimosis.cls:212 | `head.koma-fonts` | `\setkomafont{descriptionlabel}{\normalfont\bfseries}` (the sample has no description list) |
| inline lists | mimosis.cls:137-140; Sources/Introduction.tex:178-182 | `list.paralist` | options olditem, oldenum; body `inparaenum` with label `[(i)]` |
| intro note block | Sources/Introduction.tex:5-13 | `box.minipage` + `font.size-commands` + `sp.ragged` | `center`, `minipage` 0.5\textwidth, `small`, `\vspace{0.5cm}` |
| inline marks | main.tex:105-117; Sources/Introduction.tex:189-192 | `mark.kernel` | `\textsuperscript{\textup{st}}` etc. aliases `\st \nd \rd \th`; `\emph`, `\textbf`, `\texttt`, `\textsc` |
| units | mimosis.cls:160; Sources/Introduction.tex:186 | `mark.siunitx` | `\SI{750}{\milli\gram}` |
| verbatim | Sources/Introduction.tex:40-42,58-62,69-73,93-95,195-197,216-218 | `code.verbatim` | `verbatim` environment, `\verb\|..\|` |
| display maths | mimosis.cls:166; Sources/Introduction.tex:148-151,159-161 | `math.amsmath` | `align`, `equation`, `\DeclareMathOperator*{\argmin}`, `\dist`, `\im` (mimosis.cls:177-179) |
| double-struck letters | mimosis.cls:168,181-182 | `math.bm` | `dsfont` `\mathds{D}`, `\mathds{R}` behind `\domain`, `\real` |
| delimiter spacing | mimosis.cls:172-175 | `math.mleftright` | `\left`/`\right` rebuilt as `\mathopen{}\mathclose\bgroup`; emitter prints `\mleft`/`\mright` |
| theorems | mimosis.cls:167 | `thm.amsthm` | package loaded only; no `\newtheorem` or `\theoremstyle` in class or sample |
| table | Sources/Introduction.tex:102-129 | `tbl.tabular` + `tbl.booktabs` | `table`, `\centering`, `tabular{ll}`, `\toprule \midrule \bottomrule` (mimosis.cls:153) |
| spanning cells (loaded) | mimosis.cls:154 | `tbl.multirow` | `multirow` loaded; sample does not call it |
| caption text | Sources/Introduction.tex:125-127 | `cap.kernel` | `\caption{...}` with `\label` |
| caption fonts | mimosis.cls:214-215 | `cap.koma` | `\setkomafont{caption}{\small}`, `\setkomafont{captionlabel}{\usekomafont{caption}}` |
| sub-caption references | mimosis.cls:75,79 | `fig.subcaption` + `cap.caption` | `subcaption` loaded; `\captionsetup{subrefformat=parens}` |
| images | mimosis.cls:60-64 | `fig.graphicx` | `\graphicspath{{Figures/}{./}}`; no figure in the sample |
| cross references | Sources/Introduction.tex:128,133 | `xref.kernel` + `xref.hyperref` | `\label{tab:Packages}`, `\autoref{tab:Packages}` |
| hyperlink in text | Sources/Introduction.tex:88 | `meta.hyperref` | `\href{https://ctan.org/pkg/garamond-math}{\texttt{..}}` |
| bibliography engine | main.tex:39-50,53,174 | `bib.biblatex-biber` | autocite=plain, backend=biber, doi, url, giveninits, hyperref, maxbibnames=99, maxcitenames=99, sortcites, style=numeric; `\addbibresource{Thesis.bib}`, `\printbibliography`, `\cite{Bringhurst12}` (Sources/Introduction.tex:26-27) |
| bibliography field formats | bibliography-mimosis.tex:25-26,107,110-116,120-123 | `bib.biblatex-biber` | `\AtEveryBibitem{\clearfield{month}}`, `\DeclareFieldFormat{labelnumberwidth}{#1\adddot}`, `\DeclareFieldFormat{doi}`, name delimiters `\addnbthinspace` |
| citation font size | bibliography-mimosis.tex:127-131 | `font.size-commands` | `relsize` `\relsize{-.5}` inside `\citesetup` (relative size switch, the type of `\fontsize`; considered: `relsize`, not proposed) |
| bibliography strings | english-mimosis.lbx:2-8; bibliography-mimosis.tex:133 | `bib.biblatex-biber` | `\DeclareLanguageMapping{english}{english-mimosis}`, `\DeclareBibliographyStrings{inherit={english}, techreport={...}}` |
| index | mimosis.cls:41; main.tex:98,173 | `idx.makeidx` | `makeidx`, `\makeindex`, `\printindex` |
| glossary and acronyms | mimosis.cls:85-91; main.tex:82-99,165-171 | `idx.glossaries` | options acronym, nogroupskip, nopostdot, nonumberlist, toc; `\newacronym` x3, `\newglossaryentry` x2, `\makeglossaries`, `\glsaddall`, `\printglossary[type=\acronymtype]` |
| acronym and glossary styles | mimosis.cls:96-131 | `idx.glossaries` | `\newacronymstyle{long-short-mimosis}`, `\newglossarystyle{long-mimosis}`, `\setlength{\glsdescwidth}{10cm}`, `\setacronymstyle`, `\setglossarystyle` |
| glossary page flow | main.tex:165-171 | `pg.break` | group with `\let\clearpage\relax`, then `\newpage` between the two glossaries |
| helper packages | mimosis.cls:41-42; main.tex:15 | none (no printed effect) | `xspace`, `etoolbox` (the latter used for `\ifdefempty`, Sources/Title.tex:9) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `mimosis.cls` as a whole | mimosis.cls:1-220 | yes | `class.scrbook` with the options above, plus `\RequirePackage` of published packages with the listed options, KOMA font and format settings; every remaining macro is in the rows below |
| `\newif\ifxetexorluatex` and the font `\ifxetexorluatex ... \else ... \fi` | mimosis.cls:19-25; main.tex:59-80; Sources/Introduction.tex:75-84 | yes | the emitter knows the engine and prints only the live branch: pdfTeX gives `font.fontenc-t1`, `font.serif-pkg`, `font.mono`; Xe/Lua gives `font.fontspec`, `font.unicode-math` |
| `\newcommand{\comment}[1]{}` | mimosis.cls:48 | yes | empty alias, unused in the sample; omitted |
| `\pdfsuppresswarningpagegroup=1` guarded by `\csname` test | mimosis.cls:69-73 | yes | warning suppression with no printed effect; omitted |
| acronym style with `\renewcommand*{\genacrfullformat}` etc. | mimosis.cls:96-114 | yes | only published glossaries commands (`\GlsUseAcrEntryDispStyle`, `\GlsUseAcrStyleDefs`, `\glsentrylong`, `\firstacronymfont`), no counters or conditionals: `idx.glossaries` style declaration (borderline: it extends glossaries through its documented style API) |
| glossary style `long-mimosis` with `\renewcommand{\glossentry}` | mimosis.cls:118-125 | yes | one row template made of glossaries commands, same API as above (borderline) |
| `\left`/`\right` redefinition | mimosis.cls:172-175 | yes | the `mleftright` idiom by hand; emit `\mleft`/`\mright` with `math.mleftright` |
| `\argmin` `\dist` `\im` `\domain` `\real` `\diff` | mimosis.cls:177-185 | yes | `\DeclareMathOperator` and `\newcommand` aliases over `\operatorname`, `\mathds`: `math.amsmath`, `math.bm` |
| `\st \rd \nd \th` aliases with `\@ifundefined` and `\xspace` | main.tex:105-117 | yes | inline `\textsuperscript{\textup{..}}` (`mark.kernel`); the `\xspace` is a macro-body helper that inlines away |
| `\ifdefempty{\@subtitle}` in the title page, direct `\@title` `\@author` | Sources/Title.tex:3-16 | yes | the emitter prints the title page from the model and omits the subtitle block when it is empty |
| `\let\clearpage\relax` in a group | main.tex:165-171 | yes | kernel `\let` inside a body group, no logic; printed as that wrapper |
| `\part` title holding a `minipage` and `singlespace*` | main.tex:137-156 | yes | `head.kernel` argument made of `box.minipage`, `sp.setspace`, `sp.manual-space` |
| biblatex `cite` and `textcite` hyperlink wrapper | bibliography-mimosis.tex:138-177 | no | state booleans and saved macros editing biblatex; BESPOKE/preamble |
| `\mkbibordinal` counter loop | english-mimosis.lbx:11-24 | no | hand-rolled arithmetic and `\ifcase` driving printed text; BESPOKE/preamble |
| `\renewbibmacro` rewrites and `\finalnamedelim` | bibliography-mimosis.tex:34-101 | no | rewrites biblatex driver macros with conditionals; BESPOKE/preamble |

## Content-opaque
none (the sample has no figure; the three `@Book` entries in Thesis.bib and the equations are content)

## Lib changes
- New ways proposed: none (considered: `relsize`, mapped to `font.size-commands`; `metalogo`, mapped to `font.icons`; `mleftright`, already `math.mleftright`)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
