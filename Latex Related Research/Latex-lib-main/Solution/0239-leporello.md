no

# 0239-leporello: the `leporello` class (folded leaflets) and its manual

- Unverified: read from the source, not compiled.
- Source: Source/0239-leporello/ (origin: https://mirrors.ctan.org/macros/latex/contrib/leporello.zip; licence: lppl1.3c)
- Kind: misc (the sample is a package manual; the class itself sets folded leaflets)
- Lib: v3 (the snapshot you read)
- Engine: pdfLaTeX-compatible by reading (no `fontspec`, `luacode` or shell escape anywhere; only the optional right-to-left and vertical typesetting branch at leporello.cls:470-509 is LuaTeX-only; the manifest hint says xelualatex, not confirmed by the source)
- Look carried by: mixed (the main file `leporello-doc.tex` is kernel `article` whose look sits in its own preamble; the two other samples `doc/layout.tex` and `doc/flow.tex` take their whole look from the published class `leporello.cls`)
- Class origin: ctan (`leporello.cls` is the CTAN package itself, shipped in its own CTAN zip; the main file loads kernel `article`)
- Main file: leporello-doc.tex (other samples: doc/layout.tex, doc/flow.tex)
- Read: main yes, zip-local classes and styles all (leporello.cls lines 1-2245, the only class file; doc/layout.tex and doc/flow.tex read in full)

## Verdict
No. The main file is an `article` manual whose preamble is mostly reducible to lib ways (fonts, geometry, `fancyhdr`, `tcolorbox` listings, `listings` styles, `siunitx`), but it also draws template-identity artwork with TikZ (a callout badge used twice in the body, a corner star and a notch overlay) that no lib way holds, and it redefines the kernel footnote-text hook with a hand-set box that no `fn.*` way is shown to express. The published `leporello` class is a single class way (`class.leporello`) with its own column, box and flow vocabulary; on its own, `doc/layout.tex` and `doc/flow.tex` are a published class plus option settings, class-native environments and `lipsum` filler, which is evidence about the class dimension, not about component ways. No text addressed to an AI was found in the zip.

## Blockers
- `ART/preamble` TikZ callout badge `\warning` (a filled circle node with "!" and a filled tail, overlay at -3em) drawn into the page; used in body at leporello-doc.tex:300 and 474 (defined 141-148)
- `ART/preamble` TikZ five-point star `\expandablestarcode` placed by a tcolorbox `overlay` at the corner of starred `macrodef` boxes (leporello-doc.tex:129-135, 169-173; `\expandablestar` 137-139); the starred form is defined but never invoked in the body
- `ART/preamble` TikZ notch overlay on `macrodeprecated*` boxes (leporello-doc.tex:199-206); defined, never invoked in the body
- `BESPOKE/preamble` `\@makefntext` redefined as a 1em hand-set box holding the mark, then a space, then the text (leporello-doc.tex:42-44); a kernel hook body that no `fn.footmisc` option is shown to give (not reduced; see Bespoke code)

## Class setting
- Class: `class.article` options: `a4paper` (leporello-doc.tex:13). Class-native vocabulary used: `\section`, `\subsection`, `itemize`, `description`, `\footnote` (inside `\makedoctitle`, :116), `\label` `\ref` (:560, :524)
- Class: `class.leporello` (doc/layout.tex:13-17, doc/flow.tex:13-17; leporello.cls:513-516 loads kernel `article`, `graphicx`, `l3draw`) options: `prepress`, `show frames`, `show ids` (key-value options processed by `\ProcessKeyOptions`, leporello.cls:513; groups `global`, `box`, `typeset`, `image`, `notes` at 86-99, 2213-2225). Class-native vocabulary used in the samples: `leporellocolumn{name}` (leporello.cls:2020), `leporellobox[keys]` (2034), `\leporellosetstyle` (2129), `\leporellotypesetcolumns{list}` (2141), `\leporelloboxbreak` (2161). Documented but not used in the samples: `\leporelloset` (2121), `\leporelloimage` (2188), `\leporellonote` and `\leporelloprintnotes` (2227, 2237), `\leporellocolordefine` and `\leporellocolorselect` (2180, 2184), `\leporellobleed` `\leporellolayoutheight` `\leporelloboxwidth` (2168-2178). Keys: global `columns` (list of widths; presets `two columns` .. `six columns`, 102-149), `layout height`, `auto typeset`, `show frames`, `show ids`, `prepress`, `bleed`, `info area`; box `name` `parent` `align parent` `align self` `offset` `width` `height` `stretch` `padding` `no padding` `pre` `background color` `background code` `bleed` `store width` `store height` `flow into` (264-340); typeset `reverse layout` `reverse order` `reverse pagination` `alternate layout` `continuous pagination` (361-380); image keys (401-432); notes `mark cmd` `list style` (2219-2225).

## Component map
Rows 1-30 are the main file `leporello-doc.tex`; rows 31-41 are the class samples and `leporello.cls`.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| 1 class | leporello-doc.tex:13 | `class.article` | a4paper |
| 2 encoding | leporello-doc.tex:17 | `font.fontenc-t1` | T1 |
| 3 serif face | leporello-doc.tex:18 | `font.serif-pkg` | package Alegreya |
| 4 sans face | leporello-doc.tex:19 | `font.helvet` | package AlegreyaSans (a sans text-face package is the parameter) |
| 5 mono face | leporello-doc.tex:20 | `font.mono` | package FiraMono |
| 6 page geometry | leporello-doc.tex:22-23 | `page.geometry` | margin=25mm, left=45mm |
| 7 header/footer | leporello-doc.tex:26-30 | `hf.fancyhdr` | pagestyle fancy, `\fancyhf{}`, headrulewidth=0pt, `\fancyfoot[R]{\thepage}` |
| 8 line spacing | leporello-doc.tex:38 | `sp.linespread` | 1.1 then `\selectfont` |
| 9 footnote spacing | leporello-doc.tex:39 | `sp.lengths` | `\skip\footins` plus 1em plus 5pt |
| 10 footnote mark counter | leporello-doc.tex:32-36, 41 | `num.counters` | `\renewcommand*{\thefootnote}` set to a stars macro (see Bespoke code) |
| 11 footnote text layout | leporello-doc.tex:42-44 | `fn.kernel` | `\@makefntext` redefined (BESPOKE/preamble, not reduced) |
| 12 footnote use | leporello-doc.tex:115-117 | `fn.kernel` | one `\footnote` inside the title block |
| 13 title block | leporello-doc.tex:97-126, 258-263, 282 | `font.size-commands`, `mark.kernel`, `sp.manual-space`, `sp.rule`, `sp.lengths`, `meta.hyperref` | hand-laid group: `\parindent`=0pt, `\sffamily`, `\Huge{\bfseries}`, `\Large`, `\large`, `\bigskip`, `\rule{\textwidth}{.08em}`; not `\maketitle` |
| 14 title image | leporello-doc.tex:277-280 | `fig.graphicx`, `sp.manual-space` | `\includegraphics[width=80mm]` inline (not a float), `\vspace*{-2.5em}`, `\hspace{-10pt}` |
| 15 PDF metadata | leporello-doc.tex:98-102 | `meta.hyperref` | pdfauthor, pdftitle, pdfsubject set per document |
| 16 links | leporello-doc.tex:24, 62, 262, 300 | `meta.hyperref`, `meta.url` | `colorlinks`; `\urlstyle{same}`; `\href`, `\url` |
| 17 headings | leporello-doc.tex:285, 302, 573 | `head.kernel` | article `\section`, `\subsection` unchanged |
| 18 change log | leporello-doc.tex:77-94, 265-274, 1024 | `head.kernel`, `list.kernel`, `sp.lengths` | `\section{Changes}`, `description`, `\itemsep`=0pt, label = version then date in `\normalfont` |
| 19 lists | leporello-doc.tex:289-294 | `list.kernel` | `itemize` |
| 20 tables | leporello-doc.tex:326-342, 429-445, 711-729 | `tbl.longtable`, `tbl.booktabs`, `tbl.tabular` | `longtable` with `@{}` and `p{...}` widths from `\dimexpr`, `\toprule` `\midrule` `\bottomrule`, `\\*` |
| 21 units | leporello-doc.tex:253-256 | `mark.siunitx` | `\sisetup{detect-all}`, `\qty{#1}{\milli\metre}` |
| 22 inline name chips | leporello-doc.tex:220-251 | `box.tcolorbox`, `code.listings` | `\NewTotalTCBox` with verbatim, size=tight, arc=1pt, outer arc=1pt, top/bottom=0.5pt, left/right=2pt, boxrule=0pt, colframe and colback black!10, fontupper `\small\ttfamily`, `\lstinline` |
| 23 definition blocks | leporello-doc.tex:159-174 | `code.tcblisting` | `\NewTCBListing` listing only, listing style, grow to left by=2cm, boxrule=0pt, enhanced; overlay is ART (blockers) |
| 24 code example blocks | leporello-doc.tex:176-187 | `code.tcblisting` | listing only; `text side listing`, lefthand width=4.5cm; `after={\par\smallskip\noindent}` |
| 25 deprecated and replacement blocks | leporello-doc.tex:189-218 | `code.tcblisting`, `color.xcolor` | width 0.5`\linewidth`-2.5pt, box align=top, colours black!25!red!10 and black!25!green!10; notch overlay is ART; neither block is used in the body |
| 26 listing styles | leporello-doc.tex:48-60 (library load at 47) | `code.listings` | `\lstdefinestyle` basicstyle `\small\ttfamily`, keywords empty, `literate` guillemets, three `moredelim` rules |
| 27 box defaults | leporello-doc.tex:150-157 | `box.tcolorbox` | size=small, arc=2.5pt, outer arc=2.5pt, colframe and colback black!10 |
| 28 framed example images | leporello-doc.tex:735-738, 796-799 | `box.tcolorbox`, `box.fancybox`, `fig.graphicx` | `tcolorbox`, `\fboxsep`=0pt, `\colorbox{white}`, `\includegraphics[width=\linewidth]` |
| 29 cross-references | leporello-doc.tex:524, 560 | `xref.kernel` | `\label{sec:flow}`, `\ref` |
| 30 callout badge and star glyph | leporello-doc.tex:129-148 | `art.tikz` (restricted) | ART, see Blockers |
| 31 leaflet class | doc/layout.tex:13-17; leporello.cls:513-516 | `class.leporello` | `prepress`, `show frames`, `show ids` |
| 32 page size and margins | leporello.cls:101-150, 1941-2007 | `page.class-options` | class keys `columns` (default 97mm, 100mm, 100mm), `layout height` (210mm), `info area` (10mm), `bleed` (3mm), `prepress`; margins and offsets forced to 0 |
| 33 leaflet columns and boxes | leporello.cls:264-340, 1211-1432, 1730-1837, 2020-2119; doc/layout.tex:26-55 | `class.leporello` | class-native `leporellocolumn` and `leporellobox`; keys background color black!10, height, offset, stretch, bleed, align parent/self |
| 34 box styles | doc/layout.tex:19-24; leporello.cls:2129-2139 | `class.leporello` | `\leporellosetstyle{box/align bottom}{box={align parent={l,b}, align self={l,b}}}` |
| 35 text flow across boxes | doc/flow.tex:21-57; leporello.cls:915-1098, 2161-2166 | `class.leporello` | `flow into`, `name`, `\leporelloboxbreak`; flow built on the `shipout/before` hook (:1003) |
| 36 crop marks, frames, box ids | leporello.cls:566-625, 1976-2003 | `class.leporello` | options `prepress`, `show frames`, `show ids` |
| 37 running head and foot | leporello.cls:1942 | `hf.pagestyle-kernel` | `\pagestyle{empty}`; page number computed per column at 826-868 (class-native) |
| 38 notes | leporello.cls:188-206, 2205-2244 | `class.leporello` | footnotes and `\marginpar` raise errors (188-214); own `\leporellonote` list, `mark cmd`, `list style` (not used in the samples) |
| 39 colours | leporello.cls:2180-2186 | `class.leporello` | `\leporellocolordefine` and `\leporellocolorselect` through `l3color`; `xcolor` is not supported (leporello-doc.tex:635) |
| 40 right-to-left and vertical text | leporello.cls:446-509 | `class.leporello` | LuaTeX only (`\sys_if_engine_luatex:T`); not exercised by the samples |
| 41 dummy text | doc/flow.tex:19, 28 | `draft.todo` | `lipsum` package, `\lipsum[1-3]` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\fnstars` and `\thefootnote` | leporello-doc.tex:32-36, 41 | Yes, for this sample only | expl3 loop printing n stars; the sample prints one footnote (n = 1), so `fn.footmisc` `\DefineFNsymbols` with a short star list plus `\setfnsymbol` would give the same marks (by reading, not tried); the general n-star loop is not a lib way |
| `\@makefntext` redefinition | leporello-doc.tex:42-44 | No (not shown) | `\noindent\hbox to 1em{\normalfont\@thefnmark\hss}~#1`: a normal-size mark in a 1em left-aligned box, no hang; no `fn.kernel` or `fn.footmisc` option is shown to produce it, and it is a kernel-internal redefinition as in the rubric's examples |
| `\changes` and `\printchanges` | leporello-doc.tex:64-94, 265-274, 1024 | Yes | expl3 property lists indexed by a roman-numeral counter; the whole effect is `\section{Changes}` plus a `description` of ten items, writable inline with `head.kernel`, `list.kernel`, `sp.lengths` |
| `\makedoctitle` and `\printdoctitle` | leporello-doc.tex:96-126, 258-263 | Yes | stores a title group then prints it; inline as `meta.hyperref` (pdfauthor, pdftitle, pdfsubject), `font.size-commands`, `mark.kernel`, `sp.manual-space`, `sp.rule`, `fn.kernel`; the title-style hook (105-110) is a `tcolorbox` pgfkeys style (boxrule=2pt, fontupper `\huge\ttfamily`) |
| `\expandablestarcode`, `\expandablestar`, `\warning`, overlays | leporello-doc.tex:129-148, 169-173, 199-206 | No | TikZ drawings, `art.tikz`; ART (Blockers) |
| `macrodef`, `codeexample`, `codeexamplecolumns`, `macrodeprecated`, `macroreplacement` | leporello-doc.tex:159-218 | Yes, apart from the ART overlays | `\NewTCBListing` declarations: `code.tcblisting` plus `box.tcolorbox` keys; `IfValueT` and `IfBooleanT` are kernel argument tests inside the key list (:166-170, :199) |
| `\macro`, `\titlemacro` | leporello-doc.tex:220-251 | Yes | `\NewTotalTCBox` declarations (`box.tcolorbox`) around `\lstinline` (`code.listings`) |
| `\mmdim` | leporello-doc.tex:254-256 | Yes | alias of `\qty{#1}{\milli\metre}` (`mark.siunitx`) |
| `\leporellofileversion`, `\leporellofiledate` | leporello-doc.tex:14-15 | Yes | text constants, content |
| `leporello.cls` itself | leporello.cls:1-2245 | Not applicable: a published CTAN class, one way `class.leporello` | its internals (`l3coffin` placement 1211-1432 and 1636-1714, pagination arithmetic 826-868, shipout-hook flow 987-1098) are inside the published way and are not copied by an emitter; if a reader counted this class as zip-local, those parts would be `BESPOKE/class` (coffin layout engine and flow by `\shipout_discard:`, no lib composition) |

## Content-opaque
- Shipped images: `doc/leporello.pdf` title image (leporello-doc.tex:279), `doc/layout.pdf` (737), `doc/flow.pdf` (798); `doc/leporello.svg` is not loaded by any `.tex` (presumably the source of the title image, not confirmed)
- Code text inside `codeexample` environments (leporello-doc.tex:581-584, 654-664, 687-692, 740-790, 801-855, 975-979) and `macrodef` blocks: listing content
- Body text of the manual, the change-log entries (265-274) and the dimension tables (326-342) are content

## Lib changes
- New ways proposed: none (every component above has a home in `_Lib.md`; the leaflet vocabulary is recorded under `class.leporello`, as the rubric asks for a published class's own vocabulary)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
