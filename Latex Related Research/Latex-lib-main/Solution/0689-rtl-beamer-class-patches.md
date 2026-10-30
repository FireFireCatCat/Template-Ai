yes

# 0689-rtl-beamer-class-patches: RTL Beamer Class Patches (beamer-rl)

- Unverified: read from the source, not compiled.
- Source: Source/0689-rtl-beamer-class-patches/ (origin: https://latextemplates.com/downloads/beamer-rl.zip; licence: LPPL-1.3c-or-later)
- Kind: presentation
- Lib: v5
- Engine: needs LuaLaTeX (beamer-rl.cls:63-68 raises `\ClassError` when the engine is not LuaTeX; pgfpages-rl.sty:8-11 does the same)
- Look carried by: class (the published CTAN class `beamer-rl` loads `beamer`; the sample's preamble only names two beamer themes, main.tex:2-3, and sets no template, colour or font)
- Class origin: ctan
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
`beamer-rl` is on CTAN (ctan.org/pkg/beamer-rl: v2.1 of 2026-07-22, LPPL 1.3c, Salim Bou, in TeX Live and MiKTeX), and the bundled `beamer-rl.cls` carries that same version string (beamer-rl.cls:2-3) and README.md:9-13 calls it the upstream class. So it is a published class, one way `class.beamer-rl`, and its RTL patches are class internals, not bespoke code of this zip. The sample (32 lines) defines no macro, environment, counter or artwork; it names two beamer themes and uses frames, a block, a list and a plain `tabular`, all lib ways. An emitter writes `\documentclass{beamer-rl}`, `\usetheme`, `\usecolortheme` and the body wrappers, with no copied macro logic, so `yes`. Evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.beamer-rl` options: none in the sample (main.tex:1). Class-native key options, all declarative: `layout=` (passed to babel as `layout=graphics.<value>`, beamer-rl.cls:5-8, 61); language keys `arabic` and `hebrew` (cls:12-33), `arabic-ma` `arabic-tn` `arabic-dz` `arabic-eg` `arabic-sa` `arabic-iq` `arabic-sy` `arabic-lb` `arabic-ps` `arabic-jo` (cls:37-47), `syriac` `persian` `urdu` `centralkurdish` `kashmiri` `mazanderani` `northernkurdish-arab` `malayalam` `pashto` `punjabi-arab` `uyghur` `uzbek-arab` `yiddish` (cls:49-57), each running `\babelprovide` at `env/document/before`; any unknown option goes to `beamer` (cls:9). The class does `\LoadClass[hyperref={unicode}]{beamer}` (cls:70).
- Class-native vocabulary used: beamer's `frame` environment (with and without a title argument), `\titlepage`, `\subtitle`, `\institute`, `\usetheme`, `\usecolortheme`, `block` environment, `\tableofcontents` inside a frame, `\section`. The class adds `\redefbeamertemplate` (cls:76-82, used only inside the class). The sample selects no RTL language, so none of the RTL keys is exercised.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.beamer-rl` | no options; loads beamer with `hyperref={unicode}` (beamer-rl.cls:70) |
| beamer theme | main.tex:2 | `slide.beamer-theme` | `\usetheme{CambridgeUS}` (a published beamer theme; supplies head and foot lines and block shapes; its source is not in the zip and was not read) |
| beamer colour theme | main.tex:3 | `slide.beamer-theme` | `\usecolortheme{dove}` |
| title block | main.tex:4, 6, 8 | `front.maketitle` | `\title{A right-to-left presentation starter}`, `\author{Your Name}`, `\date{\today}` |
| title block (beamer fields) | main.tex:5, 7, 10 | `front.class-native` | `\subtitle{...}`, `\institute{...}`, `\begin{frame}\titlepage\end{frame}` |
| contents | main.tex:11 | `toc.kernel` | `\tableofcontents` in a frame titled "A compact agenda" |
| sectioning | main.tex:12, 23 | `head.kernel` | `\section{Question}`, `\section{Evidence}` (feed the contents list and navigation; no printed heading) |
| frame titles | main.tex:11, 13, 24, 31 | `head.class-native` | `\begin{frame}{title}` argument form |
| block | main.tex:14-16 | `slide.beamer-theme` | `block` environment with a title; the shape and colours come from the inner and colour themes, no `\setbeamertemplate` override in the sample |
| bullet list | main.tex:17-21 | `list.kernel` | `itemize`, three `\item`; the item symbol is beamer's template, which the class patches (cls:322-325) |
| table | main.tex:25-29 | `tbl.tabular` | `tabular{lrr}`, header row and two data rows, no rules, no float, no caption |
| centred closing slide | main.tex:31 | `sp.ragged` | `\centering` |
| closing slide size | main.tex:31 | `font.size-commands` | `\Large` |
| babel and RTL layer (class internal) | beamer-rl.cls:15, 27, 61, 72 | `lang.babel` | `\RequirePackage[nil,bidi=basic]{babel}`, `provide=*` and `layout=` passed with `\PassOptionsToPackage`; babel's own `bidi=basic`, not the `bidi` package (considered `lang.bidi`: the class does not load that package) |
| sans face (class internal) | beamer-rl.cls:518-527 | `lang.babel` | `\babelfont{sf}{Amiri}`, set only when a probe `\font\sffont@rl="Amiri"` finds the font (considered `font.fontspec`: `\babelfont` is babel's command) |
| link and PDF settings (class internal) | beamer-rl.cls:70 | `meta.hyperref` | hyperref option `unicode` handed to beamer |
| RTL patches of beamer templates (class internal) | beamer-rl.cls:312-318, 322-331, 333-379, 384-434, 441-497, 506-516 | `class.beamer-rl` | bibliography item, subsection in toc, itemize item and subitem, button, note page, goto/return/skip symbols, zoom and shrink boxes, each mirrored by `\bbl@thepardir` or `\textdir TLT`; part of the published class |
| rounded blocks for RTL (class internal) | beamer-rl.cls:106-308 | `class.beamer-rl` | `\renewcommand\beamerboxesrounded` and `\endbeamerboxesrounded`, a pgf-drawn block; part of the published class |
| second-screen notes helper (not loaded by the sample) | beamer-rl.cls:90-102; pgfpages-rl.sty:85-575 | `pg.pgfpages` | `\pgfpagesdeclarelayout` layouts `rounded corners`, `resize to`, `2 on 1`, `4 on 1`, `6 on 1`, `8 on 1`, `16 on 1`, and keys `second right` `second left` `second top` `second bottom` (pgfpages-rl.sty:33-83); reached only through the beamer option `show notes on second screen` (cls:97) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `beamer-rl.cls` as a whole | beamer-rl.cls:1-529 | not bespoke | published on CTAN (W1): it is the way `class.beamer-rl`, chosen by key options (W2) |
| RTL template patches and `\beamerboxesrounded` rewrite | beamer-rl.cls:106-308, 312-497 | n/a, published | box-and-glue and pgf code; irreducible if this class were zip-local, but it is the CTAN class's own code and the emitter only writes `\documentclass{beamer-rl}` |
| `\bbl@sreplace` patches of beamer internals | beamer-rl.cls:506-516 | n/a, published | same reasoning; internals of the published class |
| `pgfpages-rl.sty` | pgfpages-rl.sty:1-666 | n/a, published helper, not loaded by the sample | not a separate CTAN package (ctan.org/pkg/pgfpages-rl is a 404); the README calls the bundled helper part of the upstream (README.md:12-13) and the class loads it by name (cls:97), so it is inferred to ship in the CTAN beamer-rl bundle (file list not read). Its layouts reduce to `pg.pgfpages`; its `\pgfpages@buildshipoutbox` rewrite (pgfpages-rl.sty:579-666) and `\pgfpagespoint` (14-23) patch pgfpages internals and would be irreducible if it were zip-local |
| sample preamble and body | main.tex:1-32 | n/a | no `\newcommand`, `\def`, environment, counter or conditional defined |

## Content-opaque
none

## Lib changes
- New ways proposed: none (`class.beamer-rl` is a class way and is written plainly)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Origin check: one read of ctan.org/pkg/beamer-rl (exists, v2.1 2026-07-22, LPPL 1.3c, LuaTeX) and one of ctan.org/pkg/pgfpages-rl (404). The CTAN page names no file list.
- Missing asset: the Amiri font is not shipped (cls:518-527 tolerates its absence).
- No text addressed to an AI was found in README.md, the class or the style.
- Because the sample selects no RTL language, it shows only the left-to-right defaults; the RTL behaviour is reached by class key options, which are parameters of the same way.
