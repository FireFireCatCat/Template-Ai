no

# 0736-jellespijker-pidcircuittikz: PIDcircuitTikZ (P&ID symbol TikZ library, catalogue sample and draft-drawing class)

- Unverified: read from the source, not compiled.
- Source: Source/0736-jellespijker-pidcircuittikz/ (origin: https://codeload.github.com/jellespijker/PIDcircuitTikZ/zip/refs/heads/master; licence: MIT)
- Kind: misc
- Lib: v5
- Engine: pdfLaTeX-compatible (minted needs shell escape and pygments; see EXTERNAL)
- Look carried by: mixed (page, title and headings are kernel `article` defaults; the listing-box look is the sample preamble at example.tex:39-59; the diagram symbols are zip-local TikZ libraries; the drawing-sheet frame and title block are zip-local draftdrawing.cls)
- Class origin: tex-distribution-unbundled
- Main file: example.tex (other samples: example draft drawing.tex, PIDcircuitTikZ.tex)
- Read: main yes, zip-local classes and styles all (pgfmanual-en-macros.tex, 1760 lines, partly: lines 1-70 and a definition outline up to line 1067)

## Verdict
No. The zip is a TikZ symbol library for P&ID diagrams (ISO 14617) plus a drafting class. The main sample is a plain `article` whose only template look is a set of tcolorbox listing boxes, and that part maps to lib ways. Four things block a `yes`. The sample loads a zip-local TikZ library (`circuits.pid.ISO14617`) written with `\pgfdeclareshape`, `\pgfarrowsdeclare` and anchor arithmetic, which is irreducible bespoke code (ctan.org/pkg/pidcircuittikz is a 404, so W1 fails). The tcolorbox `minted` library, loaded unconditionally, needs pygments and shell escape. `draftdrawing.cls` draws the sheet frame and title block with TikZ nodes, which is template-defining artwork. The documentation sample also depends on the PGF manual macros and a `pgfmanual.sty` that is not in the zip.

## Blockers
- `BESPOKE/preamble` zip-local TikZ library `circuits.pid.ISO14617`, loaded by the main sample (example.tex:34): custom shapes with computed anchors (pgflibraryshapes.gates.pid.code.tex:28-62, :64-87, :93-141; pgflibraryshapes.gates.pid.ISO14617.code.tex:23-65, :68-99, :107-153, :156-278, :281-330, :333-547), a custom arrow (pgflibraryshapes.gates.pid.code.tex:148-164), `flow path` decorations (tikzlibrarycircuits.pid.code.tex:242-308), `\crossings` and `\currentcoordinate` (tikzlibrarycircuits.pid.code.tex:386-394), and the `flow system`, `control system` and `complex device` environments (tikzlibrarycircuits.pid.code.tex:397-468)
- `EXTERNAL/package` `\tcbuselibrary{minted, raster}` loaded unconditionally and used through `minted options` in the listing styles (example.tex:30, :40, :48): needs pygments and shell escape
- `ART/class` draftdrawing.cls draws the page border, a `\pic` title block of 12 TikZ nodes and the `tikzdraft` wrapper (draftdrawing.cls:100-124, :127-140); this is the sheet's identity, not figure content
- `BESPOKE/class` draftdrawing.cls turns paper-size options into lengths and then computes frame coordinates from them (draftdrawing.cls:29-38, :42-70, :80-83), and redefines `\title` (draftdrawing.cls:98); the output depends on that computation, not on a lib way
- `BESPOKE/preamble` documentation sample PIDcircuitTikZ.tex: `\input{pgfmanual-en-macros}` (a zip-local copy of the PGF manual's macro file, `\def` argument parsers, pgfmanual-en-macros.tex:22-62) and `\RequirePackage{pgfmanual}` (PIDcircuitTikZ.tex:55, :126; `pgfmanual.sty` is not in the zip, so `codeexample` at :204 is undefined without it)

## Class setting
- Class: `class.article` options: `a4paper` (example.tex:23). The class is not in the zip (tex-distribution-unbundled; source not read).
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (example.tex:62-65), `\section` `\subsection` (example.tex:67, :105). No `abstract` environment.
- Other samples: `class.ltxdoc` with option `a4paper` (PIDcircuitTikZ.tex:24); zip-local `draftdrawing` with options `a4paper, landscape, border=5mm, linewidth=0.25mm, linewidthborder=0.5mm` (example draft drawing.tex:23). `draftdrawing` is neither on CTAN nor an official release, so it is not a way; it only loads `class.standalone` with options `tikz,border=` (draftdrawing.cls:75) and the rest is bespoke (see Blockers). Its vocabulary: `\designedby` `\checkedby` `\approvedby` `\draftnumber` `\revision` `\remarks` `\logo` `\scale` `\unit` `\draftdate` and the `tikzdraft` environment (draftdrawing.cls:87-96, :127; used at example draft drawing.tex:29-41).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | example.tex:23 | `class.article` | a4paper |
| paper size | example.tex:23 | `page.class-options` | a4paper |
| title block | example.tex:62-65 | `front.maketitle` | `\title{Tikz P\&ID circuit extension}`, `\author{Jelle Spijker}`, `\date{\today}` |
| sectioning | example.tex:67, :103, :105, :108, :116 | `head.kernel` | `\section`, `\subsection`, default look, ISO 14617 part titles |
| page break | example.tex:102 | `pg.break` | `\newpage` before the second section |
| units and numbers | example.tex:24-27, :235 | `mark.siunitx` | per-mode=fraction, separate-uncertainty=true, bracket-unit-denominator=false, multi-part-units=single; `\SI{10}{\bar}` sits inside a TikZ label (content) |
| listing boxes (example) | example.tex:29, :40-44 | `box.tcolorbox` | `\usepackage[most]{tcolorbox}`, colframe=yellow!50!black, colback=white, coltitle=brown!50!yellow!3!white, fonttitle=\small\sffamily\bfseries, fontupper/fontlower=\small, title={Example \thetcbcounter: #1}, label={#2} |
| listing boxes (symbol) | example.tex:48-53 | `box.tcolorbox` | `tikz lower=circuit pid ISO14617`, `listing side text`, `righthand width=2cm`, colframe=gray!70!white, coltitle=green!50!blue!3!white; title={Symbol \thetcbcounter: #1} |
| info box | example.tex:56-59 | `box.tcolorbox` | `\newtcolorbox[use counter from=texexptitled]{extrainfo}[2][]`, same frame colours |
| box counters | example.tex:44-45, :52-53 | `box.tcolorbox` | `auto counter`, `number within=section` or `subsection`, `use counter from=` |
| listing display | example.tex:30, :43-44, :51-52 | `code.tcblisting` | `\newtcblisting` environments `texexp`, `texexptitled`, `texsymb`, `symboltitled` |
| listing engine | example.tex:30, :40, :48 | `code.minted` | `\tcbuselibrary{minted}`, minted options fontsize=\small or \scriptsize, breaklines, autogobble, linenos, numbersep=3mm (EXTERNAL) |
| letter-code tables | example.tex:157-204 | `tbl.nicematrix` | `tabu` with column spec `\|l \| c \| X \| X \| X \|`, `\hline`, `\tabulinesep=1mm` |
| colour | example.tex:40, :48 | `color.xcolor` | mixes such as `yellow!50!black` (xcolor loaded by tikz and tcolorbox) |
| font switches | example.tex:40, :48, :76 | `font.size-commands` | `\small`, `\scriptsize`, `\tiny`; `\sffamily\bfseries` for box titles are kernel switches (`mark.kernel`) |
| cross-reference labels | example.tex:41, :52 | `xref.kernel` | `label={#2}` on each box; the sample never `\ref`s them |
| diagrams (content) | example.tex:68-99, :109-381 | `art.tikz` | tikzpicture inside the listing boxes, libraries `circuits`, `circuits.pid.ISO14617`, `positioning`, `calc` (example.tex:32-35) |
| draft drawing class base | draftdrawing.cls:75 | `class.standalone` | options `tikz`, `border=\dd@border` |
| draft sheet frame and title block | draftdrawing.cls:100-140 | none (ART) | see Blockers |
| doc sample: class | PIDcircuitTikZ.tex:24 | `class.ltxdoc` | a4paper |
| doc sample: geometry | PIDcircuitTikZ.tex:45 | `page.geometry` | a4paper, left=2.25cm, right=2.25cm, top=2.5cm, bottom=2.5cm, nohead |
| doc sample: links | PIDcircuitTikZ.tex:26, :30-38 | `meta.hyperref` | pdfborder={0 0 0}, colorlinks=true, linkcolor, filecolor, urlcolor, citecolor=blue |
| doc sample: url | PIDcircuitTikZ.tex:25 | `meta.url` | option `hyphens` |
| doc sample: listings and pgf | PIDcircuitTikZ.tex:27-28 | `code.listings`, `art.tikz`, `mark.siunitx` | `listings`, `pgf[version=latest]`, `tikz`, `units` (units package is the parameter of the units way), `calc`; siunitx at :52 |
| doc sample: maths | PIDcircuitTikZ.tex:46 | `math.amsmath`, `math.amssymb` | load only |
| doc sample: encodings | PIDcircuitTikZ.tex:50-51 | `font.fontenc-t1` | `[T1]{fontenc}`, `[latin9]{inputenc}` |
| doc sample: lists | PIDcircuitTikZ.tex:49, :184-201 | `list.enumitem`, `list.kernel`, `sp.lengths` | `enumitem` loaded; `itemize` with `\setlength\itemsep{0pt}` |
| doc sample: index | PIDcircuitTikZ.tex:48, :152, :1072 | `idx.makeidx` | `\makeindex`, `\printindex`; prologue `\def\index@prologue` (:105) is a heading plus `\addcontentsline` |
| doc sample: contents entries | PIDcircuitTikZ.tex:107-123 | `toc.tocloft` | reduction of the `\l@section`, `\l@subsection`, `\@pnumwidth` redefinitions: bold section entries without leaders, indents 2.5em/3.3em, number width 2.2em; `\@dottedtocline{2}{2.5em}{3.3em}`; unverified, no `\tableofcontents` is printed |
| doc sample: hyphenation | PIDcircuitTikZ.tex:160 | `sp.hyphenat` | `\sloppy` |
| doc sample: spacing | PIDcircuitTikZ.tex:182-183 | `sp.manual-space` | `\bigskip`, `\noindent` |
| doc sample: tables | PIDcircuitTikZ.tex:53, :1028-1070 | `tbl.nicematrix` | `tabu` with `l l l X[r]`, `\tabulinesep=2pt` |
| doc sample: title, sections, break | PIDcircuitTikZ.tex:167-171, :173, :274 | `front.maketitle`, `head.kernel`, `pg.break` | `\title`, `\author`, `\date`, `\maketitle`; `\section`, `\subsection`; `\newpage` |

No headers, footers, fonts, theorems, floats, captions, bibliography or abstract are set by the main sample (default `plain` page style).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| TikZ library `circuits.pid` (symbol aliases, annotations, units, `measure`, `at`, `with`) | tikzlibrarycircuits.pid.code.tex:34-226, :312-384 | No | pgfkeys style tables that define a symbol vocabulary; no lib way holds them, and the package is not published |
| Shape and arrow code (`rectangle pid`, `circle pid`, `direction pid`, `generic circle/rectangle ISO14617`, `2531`, `2518`, `2521`, `heat exchanger long`) | pgflibraryshapes.gates.pid.code.tex:28-164; pgflibraryshapes.gates.pid.ISO14617.code.tex:23-547 | No | `\pgfdeclareshape` with `\pgf@process` anchor arithmetic and `\pgfarrowsdeclare`; typesetting behaviour beyond the lib |
| ISO 14617 symbol graphics | tikzlibrarycircuits.pid.ISO14617.code.tex:28-726 | No | 37 `\tikzset` `... graphic` styles (one, 2501, appears twice at :385 and :402) built on the shapes above |
| `\crossings`, `\currentcoordinate`, `flow system`, `control system`, `complex device` | tikzlibrarycircuits.pid.code.tex:386-468 | No | `\pgf@`/`\tikz@` internals, `name intersections`, `\NewDocumentEnvironment` scopes driving drawn output |
| tcolorbox style macros `texexp`, `example`, `texsymb`, `symbol`, `infosymb`, `symbolinfo` and the five `\newtcblisting`/`\newtcolorbox` environments | example.tex:39-59 | Yes (look), but the listing engine is EXTERNAL | `box.tcolorbox` + `code.tcblisting` keys listed in the map; the minted engine is not reducible |
| `draftdrawing` class | draftdrawing.cls:23-140 | No | `class.standalone` plus options (reducible part) and frame/title-block drawing code (ART) |
| PGF manual macros, `\unitexample`, `\pidlineexample`, `\pidsymbolexample`, `\pidsimplesymbolexample`, `\pidmeasurementsymbol`, `\def\empty{}` | PIDcircuitTikZ.tex:57-102; pgfmanual-en-macros.tex:22-62 | No | `\def` argument parsers and `\directlua` hook (pgfmanual-en-macros.tex:66-69, defined, not called by the sample); table rows of TikZ output are content |
| `\newif\ifgdccodebasic`, `\ifgdccodeogdf`, `\xpos`, `\ypos` counters | PIDcircuitTikZ.tex:42-43, :163-164 | Yes | unused by the sample's printed output; drop |
| toc entry redefinitions | PIDcircuitTikZ.tex:107-123 | Yes | `toc.tocloft` as in the map |

## Content-opaque
- TikZ P&ID drawings inside the listing boxes (example.tex:68-99, :109-381) and the full diagram in example draft drawing.tex:41-124 and PIDcircuitTikZ.tex:204-272. The drawings are content under the rubric, but they cannot be rebuilt without the zip-local library.
- Considered: `art.content-package` (circuits) for the symbols; rejected because the package is zip-local (ctan.org/pkg/pidcircuittikz is a 404), so W1 fails.
- Missing assets: `logo.png` is shipped and used by example draft drawing.tex:36; `pgfmanual.sty` is not shipped (PIDcircuitTikZ.tex:126).
- Considered, not mapped: `xxcolor` (PIDcircuitTikZ.tex:47) is a load-only helper for the PGF manual macros, with no printed effect in the sample; `tcolorbox` `raster` library (example.tex:30) is loaded but no `tcbraster` is used.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
