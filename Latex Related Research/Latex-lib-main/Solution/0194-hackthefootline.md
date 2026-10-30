yes

# 0194-hackthefootline: hackthefootline (beamer footline selection and configuration)

- Unverified: read from the source, not compiled.
- Source: Source/0194-hackthefootline/ (origin: https://mirrors.ctan.org/macros/latex/contrib/beamer-contrib/hackthefootline.zip; licence: LPPL 1.3c)
- Kind: presentation
- Lib: v3
- Engine: needs LuaLaTeX (the documentation sample: `% !TeX program=lualatex` at doc/hackthefootline-doc.tex:37, `fontspec` :44, `polyglossia` :45, `selnolig` :51; the package itself and the beamer demo sample are pdfLaTeX-compatible: hackthefootline.sty:36 `\mode<presentation>`, doc/hackthefootline-examples.tex:35)
- Look carried by: mixed (the footline look is carried by `hackthefootline.sty`, a package published on CTAN and the payload of this zip; the documentation's page look is carried by class `ltxdoc` plus its preamble)
- Class origin: tex-distribution-unbundled (`ltxdoc` and `beamer` ship with TeX Live and are not in the zip; the zip's only own file, `hackthefootline.sty`, is a published CTAN package, not a class)
- Main file: doc/hackthefootline-doc.tex (other samples: doc/hackthefootline-examples.tex, a beamer deck that exercises the package; the package file hackthefootline.sty)
- Read: main yes, zip-local classes and styles all (one `.sty`, read in full; no `.cls`)

## Verdict
`yes`, and it rests on one proposed way: `slide.hackthefootline`. The zip is the official release of a CTAN package (ctan.org/pkg/hackthefootline read: path `macros/latex/contrib/beamer-contrib/hackthefootline`, author Sebastian Friedl, LPPL 1.3c), so its macros are published, not bespoke; it is driven only by package options and `\htfconfig{key=value}`, serves any beamer deck, and prints as one `\usepackage` line plus `\htfconfig` calls. Every other component in the documentation sample and in the beamer demo maps to an existing lib way; the one zip-local macro (`\DescribeOption`) is a composition of lib ways. `tikz` is loaded but nothing is drawn, so no `ART`. If a reviewer rejects the new way, the verdict falls to `no` (`UNMAPPED`), because the footline boxes are `\defbeamertemplate` code that `slide.beamer-template` would only reproduce by copying the package's logic.

## Blockers
none

## Class setting
- Class: `class.ltxdoc` options: `11pt` (doc/hackthefootline-doc.tex:41). Source of `ltxdoc` not read (TeX distribution).
- Class-native vocabulary used (ltxdoc/doc): `\DescribeMacro` (doc/hackthefootline-doc.tex:118, 122, 235), `\MakeShortVerb{"}` (:75). No `macrocode`, `\DocInput`, `\changes` or index in this file.
- Class: `class.beamer` options: `12pt` (doc/hackthefootline-examples.tex:35). Source of `beamer` not read (TeX distribution).
- Class-native vocabulary used (beamer): `\frame{}` (doc/hackthefootline-examples.tex:59, 63, 67, ...), `\title[short]{}` `\author[short]{}` `\institute[short]{}` `\date[short]{}` (:53-56, 71-74), `\usecolortheme`, `\usefonttheme[onlysmall]` (:44-45), `\setbeamertemplate` (:46-47), counter `framenumber` (:60).

## Component map
Paths: D = doc/hackthefootline-doc.tex, E = doc/hackthefootline-examples.tex, S = hackthefootline.sty.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class (documentation) | D:41 | `class.ltxdoc` | 11pt |
| class (demo deck) | E:35 | `class.beamer` | 12pt |
| footline selection and configuration (the zip's payload) | E:41; S:57-65, 248-304 | `slide.hackthefootline` | package option `onecol`/`twocols`/`threecols` (none given: footline removed, D:193); `countappendixframes` (S:67-69); `nofun` (S:71-73); `\htfconfig{cols=one\|two\|three\|none, title=short\|long\|none, authinst=onlyauthor\|onlyinst\|instpths\|authpths\|both\|none, date=short\|long\|none, framenrs=counter\|fraction\|percent\|none, atsep=colon\|comma\|space}` (S:248-301, D:257-341) |
| footline switched between frames | E:58-99 | `slide.hackthefootline` | `\htfconfig{cols=one, title=short, authinst=both, date=none, framenrs=fraction, atsep=colon}` (E:58), `cols=two` (E:62), `cols=three` (E:66), then single-key changes (E:79-99) |
| footline package dependencies | S:38-39, 360-361, 376-377 | `slide.hackthefootline` | loads `ifthen`, `pgfkeys`; conditionally `appendixnumberbeamer`, `etoolbox`, `calc`, `numprint`; none needs a tool outside TeX |
| demo: page height | E:42 | `page.geometry` | `\geometry{paperheight=1cm}` (only the footline shows) |
| demo: colour and font theme | E:44-45 | `slide.beamer-theme` | `\usecolortheme{whale}`, `\usefonttheme[onlysmall]{structurebold}` |
| demo: headline and navigation removed | E:46-47 | `slide.beamer-template` | `\setbeamertemplate{headline}{}`, `\setbeamertemplate{navigation symbols}{}` |
| demo: title, author, institute, date with short forms | E:49-56, 71-74 | `front.class-native` | beamer `\title[..]{..}` `\author[..]{..}` `\institute[..]{..}` `\date[..]{..}` |
| demo: frame counter adjust | E:60 | `num.counters` | `\addtocounter{framenumber}{-1}` |
| demo: input encoding | E:37 | `font.fontenc-t1` | `inputenc` utf8 |
| demo: sans face | E:38 | `font.helvet` | package `sourcesanspro`, option `tabular` (a sans text-face package is the parameter) |
| demo: mono face | E:39 | `font.mono` | package `sourcecodepro` |
| doc: math font | D:43 | `font.newtx` | `newtxmath`, option `erewhon` (math only, no `newtxtext`) |
| doc: font selection | D:44, 68-70 | `font.fontspec` | `fontspec[no-math]`; `\setmainfont{erewhon}`, `\setsansfont[Scale=MatchLowercase]{Source Sans Pro}`, `\setmonofont[Scale=MatchLowercase]{Hack}` |
| doc: language | D:45-46 | `lang.polyglossia` | `\setdefaultlanguage{english}` |
| doc: quotation marks | D:48; use D:173, 205 | `lang.csquotes` | `\enquote`, `\enquote*` |
| doc: TeX logos | D:49; use D:139 | `font.icons` | `hologo`, `\hologo{eTeX}` |
| doc: PDF options | D:50, 82 | `meta.hyperref` | `pdfborder={0 0 0}`, `unicode`; `\hypersetup{pdftitle=..., pdfauthor=...}`; `\href{mailto:..}` (D:79) |
| doc: URLs | D:78, 170 | `meta.url` | `\url{..}` |
| doc: ligature suppression | D:51 | `sp.selnolig` | language `english` |
| doc: `tikz` load, nothing drawn | D:52 | `art.tikz` | load only; grep finds no `tikzpicture`, `\tikz`, `\draw`, `\node` in any `.tex` or the `.sty` (probably loaded for the graphics stack, see next rows); not ART |
| doc: page geometry | D:72 | `page.geometry` | left=4.50cm, right=2.75cm, top=3.25cm, bottom=2.75cm, `nohead` |
| doc: paragraph and list lengths | D:66, 100, 175, 247, 259 | `sp.lengths` | `\parindent 0pt`; `\itemsep 0pt` |
| doc: hyphenation | D:74 | `sp.hyphenat` | `\hyphenation{coun-ted}` |
| doc: documentation markup | D:75, 118-146, 235 | `dtx.doc` | `\MakeShortVerb{"}`, `\DescribeMacro{..}` |
| doc: title block | D:78-85 | `front.maketitle` | `\title{.. \\ {\large\url{..}}}`, `\author{.. \\ \href{mailto:..}{\ttfamily ..}}`, `\date{2018/01/29}`, `\maketitle` |
| doc: title page without number | D:86 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| doc: centred italic dedication | D:88-96 | `sp.ragged` (`center` environment), `mark.kernel` (`\itshape`), `sp.manual-space` (`\medskip`) | none |
| doc: abstract | D:99-106 | `abs.kernel` | `\parindent0pt\noindent`, `\textbf` lead line |
| doc: contents | D:109, 116, 163 | `toc.kernel` | `\tableofcontents`; manual `\addcontentsline{toc}{subsection}{..}` |
| doc: page breaks | D:111, 183 | `pg.break` | `\clearpage` |
| doc: headings | D:115, 189, 198, 199, 403 | `head.kernel` | `\section`, `\subsection`, `\subsection*`, `\paragraph` (ltxdoc defaults) |
| doc: lists | D:175-179, 247-254, 259-268 | `list.kernel` | `itemize`, `description` |
| doc: footnotes | D:135, 190 | `fn.kernel` | `\footnote` |
| doc: cross-references | D:150, 198 | `xref.kernel` | `\label{packageoptions}`, `\ref` |
| doc: example pictures | D:352, 358, 364, 373 ... 434 | `fig.graphicx` | `\includegraphics[page=N, width=\textwidth, trim=0 0 0 15, clip]{hackthefootline-examples}`; `graphicx` is not loaded directly in D (probably arrives through `tikz`); the emitter loads `graphicx` itself; the PDF `doc/hackthefootline-examples.pdf` is a shipped asset |
| doc: spacing | D:92-94, 351, 392 | `sp.manual-space` | `\medskip`, `\bigskip`, `\smallskip`, `\\[\smallskipamount]`, `\\[\medskipamount]` |
| doc: bibliography, index, theorems, tables, code floats, captions | none | none | the file has none (no `thebibliography`, `\printindex`, `tabular`, `\caption`) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\DescribeOption{#1}{#2}{#3}` | D:54-63 | yes | alias macro; whole effect is `\DescribeMacro{#1}` (`dtx.doc`), a `minipage[t]{\textwidth}` (`box.minipage`), `\textit{\textbf{#2}}\dotfill` (`mark.kernel`, `sp.rule`), `\vspace{0.5em}` and `\bigskip\medskip` (`sp.manual-space`); the emitter writes it inline at each of the six uses (D:243, 257, 276, 288, 307, 318, 332) |
| all internal macros of `hackthefootline.sty` (`\htfprintmessage`, `\htfcheck*`, `htf-*` beamer templates, footline templates, `\htfupdateprogress`, obsolete `\htf...` commands S:315-344) | S:41-390 | not bespoke | the file is the published CTAN package (W1); these are the implementation of `slide.hackthefootline`, not copied into the output; the emitter writes `\usepackage[..]{hackthefootline}` and `\htfconfig{..}` |

## Content-opaque
none (the `tikz` package is loaded at D:52 but no picture is drawn; the example images at D:352 ff. are included PDF pages of the shipped `doc/hackthefootline-examples.pdf`, figure content).

## Lib changes
- New ways proposed: `slide.hackthefootline` `hackthefootline` (CTAN, `macros/latex/contrib/beamer-contrib/hackthefootline`, LPPL 1.3c; engine pdf, beamer only via `\mode<presentation>`): beamer footline chosen and configured by `\usepackage[onecol|twocols|threecols,countappendixframes,nofun]{hackthefootline}` and `\htfconfig{cols,title,authinst,date,framenrs,atsep}`, callable in the preamble or between frames. W1: released on CTAN with public documentation (doc/hackthefootline-doc.tex). W2: behaviour set only by option values and key=value choices from closed lists. W3: serves any beamer deck's footline, not one document. W4: one preamble line plus `\htfconfig` lines at the preamble or between frames. Not `slide.beamer-template`, whose `\setbeamertemplate{footline}{..}` takes free box code rather than key values; not `slide.beamer-theme`, which selects a whole outer theme.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The zip is a package plus its documentation, not a deck template; the "template" analysed is the footline package and the two samples that show it.
- Missing assets: `Source Sans Pro` and `Hack` (D:69-70) are system fonts the zip does not ship; `erewhon`, `sourcesanspro`, `sourcecodepro` come from TeX Live.
- D:38 carries a TeXstudio magic comment that passes `--shell-escape`; no package in D, E or S calls an external tool, so I record it as an editor leftover, not `EXTERNAL`.
- Not read in source: `ltxdoc`, `beamer` and the loaded published packages (TeX distribution).
- Text addressed to an AI: none found.
