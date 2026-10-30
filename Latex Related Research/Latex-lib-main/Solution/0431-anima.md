yes

# 0431-anima: anima (slideshows with simple animations, TikZ)

- Unverified: read from the source, not compiled.
- Source: Source/0431-anima/ (origin: https://mirrors.ctan.org/macros/latex/contrib/anima.zip; licence: lppl1.3c)
- Kind: presentation
- Lib: v5
- Engine: pdfLaTeX-compatible (anima.dtx:2 `!TEX program = pdfLaTeX`; the class loads only `standalone`, `pgf` and `tikz`, anima.dtx:294-297)
- Look carried by: class (the zip is the package source of the published class `anima`; the sample sets three class commands and holds content, anima.dtx:741-743)
- Class origin: ctan (ctan.org/pkg/anima read: a class, LPPL 1.3c, v1.1 of 2024-12-14, in TeX Live and MiKTeX; the zip is the CTAN release)
- Main file: anima.dtx (no `.tex` in the zip; the `example` guard anima.dtx:738-899 is written out as `exemplo.tex` by anima.ins:40-42; documentation driver in the `driver` guard anima.dtx:88-103) (other samples: none; anima-doc.pdf is the compiled manual, not read)
- Read: main yes, zip-local classes and styles all (no `.cls` or `.sty` in the zip; the class source is the `class` guard anima.dtx:291-733, read in full, as are the example, the driver and the manual text)

## Verdict
yes, under the rubric's ruling for a look carried entirely by a published class: `anima` is on CTAN and in TeX Live (W1), is chosen by `\animaStyle`, `\animaColor`, `\animaTheme`, `\animaBoardDimension`, the frame count and block arguments (W2), serves any animated slide deck (W3) and prints as `\documentclass{anima}` plus preamble calls and body wrappers (W4). Its internal loop, `\uns` function and TikZ-drawn board and blocks are class code, not zip-local bespoke code. The frame bodies are TikZ drawings that only `art.tikz` can hold; they are content. This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.anima` options: none (`\documentclass{anima}`, anima.dtx:739). The class itself loads `standalone` with `multi=page` (anima.dtx:294) and `tikz` with the `positioning` library (anima.dtx:296-297). The documentation driver uses `class.ltxdoc` (anima.dtx:89).
- Class-native vocabulary used: `\animaStyle{anima}`, `\animaColor{graytext}`, `\animaTheme{plane}` (anima.dtx:741-743); `\animaFrameTitle{title}{name}{city}{date}` (747-750); `frame[n]` environment (752, 756, 796, 827, 836, 856, 874); `block`, `alertblock`, `exampleblock` environments with `[pos]{title}[halfwidth]` (758, 764, 773, 842, 857, 866, 875, 893); animation values `\um`, `\zero`, `\uns` and counter `\nFrame` (761, 684-685, 710); demo macro `\animaExemplo` (753); colour names `textColor`, `animaColor1` to `animaColor4` (697-701, 838). Defined but not used by the sample: `notitleblock`, `anotherblock`, `\animaBoardDimension`, `\animaColorTheme`, `\zeros`, `\animaTheme{LTbar}` (an undocumented theme, 558-580), hooks `\animaFormatText` and `\animaFormatTitle` (299-300).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | anima.dtx:739 | `class.anima` | no options |
| page model (one cropped page per animation step) | anima.dtx:294, 449, 467 | `class.standalone` | `multi=page`, loaded by the class not by the sample; each `page` environment is one output page |
| board size | anima.dtx:321-325 | `class.anima` | `\animaBoardDimension{16}{9}` default, stored as half sizes; the sample does not call it |
| colour palette | anima.dtx:742, 517-551 | `class.anima` | `\animaColor{graytext}` gives `\animaColorTheme{FFFFFF}{252B26}{2BA8D9}{F23030}{2EA662}{F28322}` (537-540); the name comes from a closed list of six |
| colour definitions | anima.dtx:328-341, 595 | `color.xcolor` | `\definecolor{boardColor}{HTML}{..}` and five more names, `\colorlet{BlockColor}{anima@Color1}`; xcolor comes in through `tikz` |
| colour switch in text | anima.dtx:697-701, 838, 847 | `color.xcolor` | `\color{textColor}`, `\color{animaColor1}` to `animaColor4` |
| block look | anima.dtx:741, 498-508 | `class.anima` | `\animaStyle{anima}` sets the block node style `draw=BlockColor`, `bottom color`, `top color=BlockColor!50!anima@BoardColor`, `rounded corners=1.4pt` |
| background theme | anima.dtx:743, 581-582, 363-367 | `class.anima` | `\animaTheme{plane}` empties `\animaBackgroud`; the default theme draws a dotted grid, `opacity=.2`, `line width=.3pt` |
| title slide | anima.dtx:747-750, 301-317 | `front.class-native` | `\animaFrameTitle` with four strings (title, author, city, `\today`) |
| frame and animation steps | anima.dtx:752, 445-485, 380-437 | `class.anima` | `frame[n]` makes n pages; `\um` = i/(n-1), `\zero` = 1-`\um`; `\uns` is a piecewise ramp from three integers, `\uns*` an eased one |
| slide blocks | anima.dtx:758, 764, 773, 592-667 | `class.anima` | `block`/`alertblock`/`exampleblock` fill with `anima@Color1/2/3` (595, 611, 627); arguments `[(x,y)]{title}[halfwidth]`, each block stacked under `animaPosBlock`; default width `0.9875*board half width` cm (489) |
| block font defaults | anima.dtx:299-300 | `font.size-commands`, `mark.kernel` | `\animaFormatText` = `\large`, `\animaFormatTitle` = `\large\bf` (redefinable switches) |
| hand-set code text in blocks | anima.dtx:774-792, 814-823, 843-852 | `mark.kernel`, `sp.manual-space`, `font.size-commands` | `\normalsize\tt{...}`, `\\`, `\qquad`, `\textbackslash`; `\vspace{.5cm}` (812, 858), `\textbf` (812, 838) |
| display maths in a block | anima.dtx:675 | `math.kernel` | `$$f(x)=2\sin(.57x)$$` |
| frame drawings | anima.dtx:761-762, 801-802, 832-833, 888-891 | `art.tikz` | content (see Content-opaque); coordinates use `\um` |
| TikZ library load | anima.dtx:297 | `art.tikz` | `\usetikzlibrary{positioning}`, loaded by the class |
| demo macro | anima.dtx:669-728, 753 | `class.anima` | `\animaExemplo`: blocks plus a rotating 3D scope and Riemann sums (drawings inside are content) |
| manual: class | anima.dtx:89 | `class.ltxdoc` | no options |
| manual: fonts | anima.dtx:90-91 | `font.fontenc-t1`, `font.lmodern` | `[T1]` |
| manual: doc packages | anima.dtx:92, 96 | `dtx.doc` | `hypdoc` with `numbered`; `readprov` (ctan.org/pkg/readprov read: provides `\GetFileInfo`; load-only, never called beyond the `doc` use at 107) |
| manual: bookmarks | anima.dtx:93 | `meta.bookmark` | no options |
| manual: maths | anima.dtx:94, 372-376 | `math.amsmath` | `amsmath` for the `cases` display |
| manual: pictures | anima.dtx:95, 158-162, 233-244 | `art.tikz` | `pgf,tikz`; content in the manual (inline `\tikz{}` and a `tikzpicture` in `center`) |
| manual: dtx machinery | anima.dtx:106-107, 122, 138-148, 152, 290-291, 901 | `dtx.doc` | `\ProvidesFile`, `\GetFileInfo`, `\changes`, `macro`, `macrocode`, `\DescribeMacro`, `\Finale \PrintChanges \PrintIndex`; `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges` are commented out (97-99) |
| manual: title block | anima.dtx:109-119 | `front.maketitle`, `front.thanks`, `mark.kernel` | `\title{\textsf{anima} --- ...\thanks{..}}`, `\author{..\thanks{..}}`, `\date{Released \filedate}`, `\maketitle` |
| manual: contents | anima.dtx:120 | `toc.kernel` | `\tableofcontents` |
| manual: abstract | anima.dtx:124-128 | `abs.kernel` | `abstract` environment |
| manual: headings | anima.dtx:130, 133, 229, 289 | `head.kernel` | `\section`, look from `ltxdoc` |
| manual: lists, quotes, centring | anima.dtx:165-169, 139-147, 232-245 | `list.kernel`, `quote.kernel`, `sp.ragged` | `itemize`, `quote`, `center` |
| manual: spacing and font switches | anima.dtx:144, 231, 268, 276 | `sp.manual-space`, `mark.kernel` | `\hspace*{24pt}`, `\hspace*{2cm}`, `\it`, `\\` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `anima` environment loop (`\newcount`, `\loop`, `\repeat`, `\def\um`) | anima.dtx:443-483 | n/a, inside the published class | `class.anima` frame vocabulary; read as zip-local this would be BESPOKE/class (a hand-rolled counter and loop decides how many pages print) |
| `\uns` expandable piecewise function | anima.dtx:380-436 | n/a, inside the published class | `class.anima` value `\uns`; read as zip-local this would be BESPOKE/class |
| `\animaStyle`, `\animaColor`, `\animaTheme` `\ifx` chains over a closed list of names | anima.dtx:498-590 | n/a, inside the published class | three declarative selectors of `class.anima` |
| board, dotted grid, block nodes drawn with TikZ | anima.dtx:363-367, 559-580, 592-667 | n/a, inside the published class | `class.anima` parameters (style, colour, theme); read as zip-local this would be ART/class |
| `\renewenvironment{frame}` alias of `anima` | anima.dtx:485 | n/a, inside the published class | alias, as `class.beamer` names its `frame` |
| zip-local macros in the sample body | anima.dtx:738-899 | none exist | the sample has no `\newcommand`, `\def` or counter; the `\def` strings at 782, 818, 847 are typeset text |

## Content-opaque
- TikZ frame drawings with `\um` coordinates: anima.dtx:761-762, 801-802, 832-833, 888-891; inside the class macro `\animaExemplo`: 681-727 (3D rotation, plot, `\foreach` Riemann sums using `\nFrame`).
- Pictures in the manual: anima.dtx:158-162, 184-187, 193-197, 206-225, 233-244.
- Verbatim-looking code listings typed as `\tt` text: anima.dtx:774-792, 814-823, 843-852.

## Lib changes
- New ways proposed: none. Considered: a `box` class-native way for the block environments (`box.class-native`), not proposed; a published class's own vocabulary is recorded under its class way (lib change log v3 and v4 merges), so the blocks are under `class.anima`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The `.cls` is not in the zip. `latex anima.ins` (docstrip, TeX only) writes `anima.cls` and `exemplo.tex` (anima.ins:35-42), so no tool outside TeX is needed; an emitter loads the installed class.
- The dtx identifies itself as v1.0 of 2024/11/18 (anima.dtx:106) but carries `\changes{v1.1.0}` entries of 2024-12-14 (129, 378, 441, 491); the CTAN page says v1.1.
- `\PrintIndex` (901) has no index data to read because `\EnableCrossrefs` is commented out (97), so the manual needs no `makeindex` run.
- No text addressed to an AI was found in README.txt, anima.ins or anima.dtx.
