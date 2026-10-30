yes

# 0938-beamer-rl: beamer-rl (right-to-left beamer class, LuaLaTeX)

- Unverified: read from the source, not compiled.
- Source: Source/0938-beamer-rl/ (origin: https://mirrors.ctan.org/macros/luatex/latex/beamer-rl.zip; licence: LPPL 1.3c, README.txt:18-20; ctan.org/pkg/beamer-rl read: class, v2.1, Salim Bou)
- Kind: presentation
- Lib: v6
- Engine: needs LuaLaTeX (the class stops with a ClassError when `\ifluatex` is false, beamer-rl.cls:63-68; babel `bidi=basic`, beamer-rl.cls:72; `\textdir`, `\shapemode`, `\bbl@sreplace` patches)
- Look carried by: class (the CTAN class `beamer-rl` patches beamer templates for right-to-left; the two samples only pick a theme and define a documentation helper `codeblock`)
- Class origin: ctan
- Main file: Example-of-use-ar.tex (other samples: Example-of-use-en.tex; no other `\documentclass` file; `pgfpages-rl.sty` and `Arabic_dictionaries/*.dict` are support files)
- Read: main yes (both samples, whole), zip-local classes and styles all (`beamer-rl.cls` 529 lines and `pgfpages-rl.sty` 666 lines read in full; the five `.dict` files read, the numbers dictionary only lines 1-20)

## Verdict
The zip is the CTAN package of the class `beamer-rl`, so `class.beamer-rl` is a published way (W1) and carries the look: a beamer class that loads `beamer`, `babel` with `bidi=basic` and RTL-aware patches of beamer templates. Each sample adds only a theme choice, theme-level beamer commands, listings or verbatim wrappers and content, and every sample-local macro reduces to lib ways (below). The patch code inside the class (pgf-drawn rounded blocks, buttons, note page, zoom) is the published class's own implementation, not emitter-written code, so it is not an `ART` or `BESPOKE` blocker here. `pgfpages-rl.sty` is not loaded by either sample. LuaLaTeX is required (recorded, not a blocker). This is class-dimension evidence, not evidence about the component ways.

## Blockers
none (considered and rejected: `BESPOKE/class` and `ART/class` for the pgf drawing and `\bbl@sreplace` patches at beamer-rl.cls:108-308, 333-379, 441-497, 506-516, because the class is published on CTAN and is itself the way; `BESPOKE/package` for pgfpages-rl.sty:579-666, because no sample loads it)

## Class setting
- Class: `class.beamer-rl` options: `arabic,english` (Example-of-use-en.tex:1), `arabic-dz` (Example-of-use-ar.tex:1). It loads `class.beamer` with `hyperref={unicode}` (beamer-rl.cls:70); unknown options go to beamer (beamer-rl.cls:9); language keys `arabic`, `hebrew`, `arabic-ma|tn|dz|eg|sa|iq|sy|lb|ps|jo`, `syriac`, `persian`, `urdu`, `centralkurdish`, `kashmiri`, `mazanderani`, `northernkurdish-arab`, `malayalam`, `pashto`, `punjabi-arab`, `uyghur`, `uzbek-arab`, `yiddish` run `\babelprovide[import,<key>,main]{<lang>}` at `env/document/before` (beamer-rl.cls:12-57); `layout` is passed to babel as `layout=graphics.<value>` (beamer-rl.cls:7-8, 61).
- Class-native vocabulary used: beamer `frame` (options `fragile`, `allowframebreaks`, `plain`), `\frametitle`, `\framesubtitle`, `\framebreak`, `\titlepage`, `\institute`, `block`, `columns[t,onlytextwidth]`/`column{w}`, `\beamercolorbox[wd,sep,dp]{name}`, `\pause`, overlay specifications `<1->`, `\framezoom<1><2>[border=2](x,y)(w,d)`, `\beamergotobutton`, `\beamerreturnbutton`, `\hyperlink`/`\hypertarget<1>`, `theorem`/`proof`, `\setbeamercovered`, `\setbeamertemplate`, `\usetheme`, `\usecolortheme`; class-defined: language-name options, `layout`, `\redefbeamertemplate`, beameroption `show notes on second screen`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | Example-of-use-en.tex:1; Example-of-use-ar.tex:1; beamer-rl.cls:70 | `class.beamer-rl`, `class.beamer` | options as above; beamer loaded with `hyperref={unicode}` |
| page size | Example-of-use-en.tex:1 | `page.class-options` | none given; beamer's default frame size is used (not read) |
| language and direction | beamer-rl.cls:72, 5-58, 61; Example-of-use-en.tex:81, 294, 341; Example-of-use-ar.tex:66 | `lang.babel` | `\RequirePackage[nil,bidi=basic]{babel}`; `\babelprovide[import,main]{arabic}` per language key; `\selectlanguage{english|arabic|nil}`; `\babelsublr{}` (Example-of-use-ar.tex:61) |
| direction primitives | Example-of-use-en.tex:46, 48, 371; Example-of-use-ar.tex:142 | `lang.bidi` | LuaTeX primitives `\textdir TLT` (inline LTR span in title, author) and `\shapemode2` (mirrors paragraph shape in an RTL list); filed as direction switches, the `bidi` package itself is not loaded (judgement, no new way) |
| translated keywords | Arabic_dictionaries/translator-theorem-dictionary-Arabic.dict:3-76; translator-basic-dictionary-Arabic.dict:3-87; translator-environment-dictionary-Arabic.dict:3-10; translator-bibliography-dictionary-Arabic.dict:3-21; translator-numbers-dictionary-Arabic.dict:3 | `lang.translator` | `\providetranslation{key}{Arabic text}` per key (`Theorem`, `Proof`, `Contents`...); not loaded by the class (the `translator` lines are commented out, beamer-rl.cls:19, 30, 44) nor by a sample; user-installed dictionary data |
| language font | Example-of-use-ar.tex:6; beamer-rl.cls:520-526 | `lang.babel`, `font.fontspec` | `\babelfont{alm}[Script=Arabic,Scale=.88]{ALM Fixed}` (makes `\almfamily`, used Example-of-use-ar.tex:324); class default `\babelfont{sf}{Amiri}` when the font exists; fontspec is the backend of `\babelfont` (not read); fonts not shipped |
| beamer theme | Example-of-use-en.tex:12; Example-of-use-ar.tex:15, 46 | `slide.beamer-theme` | `\usetheme{Madrid}` (en); `\usetheme{CambridgeUS}`, `\usecolortheme{spruce}` (ar); the other themes are commented out, Example-of-use-en.tex:8-44 |
| mode and overlays | Example-of-use-en.tex:12, 372-373, 379, 403, 424; Example-of-use-ar.tex:385-386, 391, 411 | `slide.beamer-mode` | `\mode<presentation>{..}`; `\item<1->`; `\pause`; `enumerate[<+-\| alert@+>]`; `\hypertarget<1>` |
| covered material | Example-of-use-en.tex:57; Example-of-use-ar.tex:59 | `slide.beamer-mode` | `\setbeamercovered{transparent=10}` |
| block, list and frame-title templates | Example-of-use-en.tex:265, 278, 316, 418; Example-of-use-ar.tex:285, 297, 333 | `slide.beamer-template` | `\setbeamertemplate{blocks}[default]`, `{blocks}[rounded][shadow=true]`, `{itemize item}[triangle]`, `{frametitle}[default][right]`; the class redefines the RTL-aware `rounded` boxes and triangle items (beamer-rl.cls:108-308, 312-331) |
| title page | Example-of-use-en.tex:46-55, 85-87; Example-of-use-ar.tex:48-57, 81-83 | `front.class-native` | `\title \author \institute[]{..\par..} \date` and `\titlepage` in a frame |
| colour | Example-of-use-en.tex:51-52 | `color.xcolor` | `{\color{blue} Repository: }` inside `\institute` |
| contents | Example-of-use-en.tex:89-92; Example-of-use-ar.tex:85-88 | `toc.kernel` | `\frametitle{\contentsname}` and `\tableofcontents` in a frame (beamer's own definition) |
| sectioning | Example-of-use-en.tex:95, 108, 256, 289; Example-of-use-ar.tex:90, 276 | `head.kernel` | `\section{}`, `\subsection{}`; no printed heading, they feed toc and navigation |
| frames | Example-of-use-en.tex:97, 110, 250, 258; Example-of-use-ar.tex:92, 111, 269 | `class.beamer-rl` | `frame[fragile]`, `[fragile,allowframebreaks]`, `[plain]{}`, `\frametitle`, `\framesubtitle` (Example-of-use-en.tex:395), `\framebreak` (Example-of-use-en.tex:339) |
| columns | Example-of-use-en.tex:295-313, 343-360; Example-of-use-ar.tex:312-330 | `class.beamer-rl` | beamer `columns[t,onlytextwidth]`, `column{2cm}`, `column{8.8cm}`; beamer vocabulary, as `class.beamer` is used in other solutions |
| page columns in text | Example-of-use-en.tex:151-177; Example-of-use-ar.tex:158-184 | `cols.multicol` | `multicols{3}` of `\verb` names |
| blocks | Example-of-use-en.tex:267-272, 280-285; Example-of-use-ar.tex:287-291 | `class.beamer-rl`, `slide.beamer-template` | native `block{title}` |
| lists | Example-of-use-en.tex:187-220, 321-324, 371-374; Example-of-use-ar.tex:338-341, 384-387 | `list.kernel` | `itemize`, `enumerate`, with overlay specs |
| theorems | Example-of-use-en.tex:399-410; Example-of-use-ar.tex:407-418 | `thm.class-native` | beamer's `theorem` and `proof`, `\qedhere`; names come from the translator keys (`lang.translator`) |
| links and buttons | Example-of-use-en.tex:207, 376-377; Example-of-use-ar.tex:218, 388-389; beamer-rl.cls:333-379, 441-497 | `xref.hyperref`, `meta.hyperref`, `class.beamer-rl` | `\href`, `\hyperlink`, `\hypertarget<1>`; hyperref option `unicode` (beamer-rl.cls:70); `\beamergotobutton`, `\beamerreturnbutton`, whose button template and arrow symbols the class redefines for RTL |
| frame zoom | Example-of-use-en.tex:424; Example-of-use-ar.tex:428; beamer-rl.cls:506-510 | `class.beamer-rl` | `\framezoom<1><2>[border=2](1cm,1cm)(2cm,2cm)`; class patches `\beamer@framezoom` with `\bbl@sreplace` |
| code block (verbatim) | Example-of-use-en.tex:64-76 | `code.verbatim`, `slide.beamer-template`, `lang.babel`, `sp.manual-space` | `\verbatim..\endverbatim` inside `\beamercolorbox[wd=\linewidth,sep=.3ex,dp=1ex]{block body}`; `\selectlanguage{nil}`, `\smallskip\hfill` |
| code block (listings) | Example-of-use-ar.tex:63-74 | `code.listings`, `slide.beamer-template`, `lang.babel`, `sp.manual-space` | `\lstset{language=TeX,basicstyle=\small\ttfamily,escapeinside={(*@}{@*)},aboveskip=3pt,belowskip=3pt}`; `lstnewenvironment{codeblock}` in `\beamercolorbox[wd=\linewidth,sep=.2ex,dp=.5ex]{title}` |
| inline code | Example-of-use-en.tex:101, 152-176; Example-of-use-ar.tex:61 | `code.verbatim`, `mark.kernel` | `\verb\|..\|`; `\texttt{\textbackslash#1}` |
| verbatim spacing | Example-of-use-en.tex:60-62 | `sp.lengths` | `\topsep=0pt \partopsep=0pt` prepended to `\@verbatim` |
| paragraph spacing | Example-of-use-en.tex:83; Example-of-use-ar.tex:79 | `sp.lengths` | `\parskip=6pt` |
| manual spacing | Example-of-use-en.tex:66, 200, 210, 315 | `sp.manual-space` | `\smallskip`, `\medskip`, `\bigskip`, `\vfill`, `\hfill` |
| large title slide text | Example-of-use-en.tex:252; Example-of-use-ar.tex:271 | `font.size-commands`, `sp.ragged` | `\fontsize{70}{60}\selectfont`; `\centerline{..}` |
| inline marks | Example-of-use-en.tex:46, 101 | `mark.kernel` | `\bfseries`, `\textit` |
| TeX logos | Example-of-use-en.tex:2, 99, 104; Example-of-use-ar.tex:2, 95 | `font.icons` | `hologo`: `\hologo{pdfLaTeX}`, `\hologo{XeLaTeX}`, `\hologo{LuaLaTeX}` |
| helper packages | Example-of-use-en.tex:3-5 | `code.verbatim`, `code.listings`, `cols.multicol` | `verbatim`, `listings`, `multicol`, load-only |
| second-screen notes (not used in a sample) | beamer-rl.cls:90-102; Example-of-use-en.tex:236-238 (inside `codeblock` text only) | `slide.beamer-mode`, `pg.pgfpages` | beameroption `show notes on second screen=right`; loads `pgfpages-rl` and `\pgfpagesuselayout{two screens with optional second}[second right]`; `note page` template redefined (beamer-rl.cls:384-434) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `codeblock` env (verbatim) | Example-of-use-en.tex:64-76 | yes | per use: `\selectlanguage{nil}`, `\smallskip\hfill`, `\begin{beamercolorbox}[wd=\linewidth,sep=.3ex,dp=1ex]{block body}` around `\begin{verbatim}..\end{verbatim}` (`code.verbatim`, `slide.beamer-template`, `lang.babel`, `sp.manual-space`); frames using it are `[fragile]` |
| `codeblock` env (listings) | Example-of-use-ar.tex:65-74 | yes | `lstnewenvironment` over `code.listings` with the same `beamercolorbox` (name `title`) and `\selectlanguage{nil}`; `\lstset` at Example-of-use-ar.tex:63 |
| `\preto{\@verbatim}{\topsep=0pt \partopsep=0pt}` | Example-of-use-en.tex:60-62 | yes | etoolbox patch (the sample does not load etoolbox; beamer or the class supplies it, not checked); its only effect is on the verbatim in `codeblock`, so write `\topsep=0pt \partopsep=0pt` in the `codeblock` wrapper (`sp.lengths`) |
| `\def\cs#1{\babelsublr{\texttt{\textbackslash#1}}}` | Example-of-use-ar.tex:61 | yes | alias of `lang.babel` `\babelsublr` and `mark.kernel` `\texttt`; inline expansion |
| `\babelfont{alm}` and `\almfamily` | Example-of-use-ar.tex:6, 324 | yes | one `\babelfont` declaration (`lang.babel`, `font.fontspec`), the switch is generated by babel |
| `beamer-rl.cls` internals | beamer-rl.cls:76-529 | n/a, published | CTAN class (ctan.org/pkg/beamer-rl): `\redefbeamertemplate` (76-82), `\beamerboxesrounded` with pgf curves and shadow shadings (108-308), `bibliography item` (312-313), `subsection in toc` (317-318), `itemize item` and `subitem` (322-331), `button` (333-379), `note page` (384-434), goto/return/skip symbols with `\pgfdefobject` (441-497), `\bbl@sreplace` patches (506-516), Amiri probe (520-526). Irreducible as emitter code, but it is the class way, so an emitter writes `\documentclass[...]{beamer-rl}` |
| `pgfpages-rl.sty` | pgfpages-rl.sty:1-666 | n/a, published in the bundle, not loaded | redefines `\pgfpagesdeclarelayout` (26-31), adds RTL layouts (85-575) and rewrites `\pgfpages@buildshipoutbox` (579-666); loaded by the class only under `show notes on second screen` (beamer-rl.cls:97), which no sample calls; if a note-page deck were wanted it is `pg.pgfpages` with this package as the parameter, and its shipout code would then need review |

## Content-opaque
- `\pgfimage[height=4cm]{example-image}` inside a zoom frame (Example-of-use-en.tex:425; Example-of-use-ar.tex:429): an included image (the `example-image` file of the `mwe` bundle), content.
- Arabic and English prose, the `\verb` language list, the theorem text and the code shown in `codeblock`.
- Missing assets: fonts Amiri (beamer-rl.cls:522-526) and ALM Fixed (Example-of-use-ar.tex:6) are not shipped; the Arabic `.dict` files must be installed where `translator` finds them.

## Lib changes
- New ways proposed: none. Considered and kept inside existing ways: `\textdir` and `\shapemode` under `lang.bidi` (direction switches of the LuaTeX manual), `\beamercolorbox` under `slide.beamer-template`, `\setbeamercovered` under `slide.beamer-mode`, `columns`/`column` as beamer vocabulary under the class way.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
