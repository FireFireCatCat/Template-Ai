yes

# 0079-modernposter: modernposter (A0 poster class, metropolis-inspired colours)

- Unverified: read from the source, not compiled.
- Source: Source/0079-modernposter/ (origin: https://mirrors.ctan.org/macros/latex/contrib/modernposter.zip; licence: cc-by-sa-4)
- Kind: poster
- Lib: v0 (the snapshot read)
- Engine: pdfLaTeX-compatible (no fontspec, unicode-math or Lua anywhere in the zip: modernposter.cls:15-132 load a0poster, xcolor, pgfopts, relsize, tikz, enumitem, fontawesome, sfmath, helvet or FiraSans, etoolbox, hyperref, environ)
- Main file: demo.tex (other samples: modernposter.tex, the package manual, class article)
- Read: main yes, zip-local classes and styles all (modernposter.cls read in full, 221 lines; no .sty, .def, .cfg, .clo, .bbx or .cbx present; demo.pdf and modernposter.pdf are binary outputs and were not read)

## Verdict
The zip is the CTAN release of the published class `modernposter` (CTAN page confirms v1.03.1, CC BY-SA 4.0, in TeX Live and MiKTeX; README.md:5-6 says the same), and `demo.tex` loads it unchanged (demo.tex:12). One published class is one way (`class.modernposter`, W1 to W4 below), so an emitter writes `\documentclass[<options>]{modernposter}` plus the class-native body commands and copies no zip-local macro logic. Everything else in both samples (lists, bold, description list; in the manual: article, listings, hyperref, footnotes) is lib ways with parameters. The `yes` rests entirely on accepting the published class as a way: its internals are TikZ overlay nodes and a hand-rolled column counter (modernposter.cls:109-170, 177-221), which would be `ART` plus `BESPOKE` if the class were not published.

W1 CTAN class. W2 options `hlcolor=<6-digit HTML hex>`, `logo=<path>`, `helvet`, plus the optional height argument of the box commands. W3 serves any two-column A0 poster. W4 one `\documentclass` line, one `postercolumn` wrapper, `\posterbox{title}{body}` wrappers around node content.

## Blockers
none

## Class setting
- Class: `class.modernposter` options: none in demo.tex:12; the available ones are shown at demo.tex:19 (`helvet`, `logo=logo.png`, `hlcolor=F70146`) and defined at modernposter.cls:32-46 (`hlcolor` default FF8000, `logo` stores a path and switches the logo node on, `helvet` switches Fira Sans to Helvetica). Options go to pgfopts, not to the base class, so paper size and orientation are fixed (base `\LoadClass[portrait]{a0poster}`, modernposter.cls:15).
- Class-native vocabulary used: `\title` `\author` `\email{}` `\maketitle` (demo.tex:21-26); environment `postercolumn` (demo.tex:28,53,55,85); `\posterbox[<height>]{title}{body}` (demo.tex:29,32,46,56,74); `\doubleposterbox[0.6]{t1}{b1}{t2}{b2}` (demo.tex:63-73); `\highlight{}` (demo.tex:30,71).
- Manual (modernposter.tex:12): `class.article`, no options. Vocabulary: `\maketitle` with `\thanks`, `abstract`, `\section` `\subsection`, `description`, `lstlisting`.

## Component map
Rows marked "internal" are inside the published class: the emitter does not print them, they are listed so nothing is hidden. Their way column is the class; the package inside is named in plain words.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (demo) | demo.tex:12 | `class.modernposter` | no options (defaults: Fira Sans light, highlight FF8000, no logo) |
| page size/orientation (internal) | modernposter.cls:15 | `class.modernposter` | base class a0poster with `portrait`; size left to a0poster's default (a0poster not in the zip, not read); not changeable through modernposter options |
| colours (internal) | modernposter.cls:20-23, 46, 48 | `class.modernposter` | xcolor: mDarkTeal=23373b, mDarkBrown=604c38 (defined, never used in the zip), hlcol from option (default FF8000); `\highlight` = `\textcolor{hlcol}` |
| fonts (internal) | modernposter.cls:90-95, 114-123 | `class.modernposter` | default FiraSans `[light,sfdefault]`; option `helvet` gives helvet + `\familydefault`=`\sfdefault`; sfmath plus `\SetSymbolFont` tweaks for sans math |
| title banner and page backdrop (internal) | modernposter.cls:137-170 | `class.modernposter` | TikZ nodes on `current page`: page fill black!10, header band mDarkTeal 15em high, 0.15em rule in hlcol, optional logo 13em square, title `\veryHuge` white bold, author and e-mail smaller, e-mail via `\href{mailto:}` |
| title block input | demo.tex:21-23, 26 | `front.class-native` | `\email{}` and the redefined `\maketitle` are class-native |
| title, author kernel commands | demo.tex:21-22 | `front.maketitle` | `\title{This is a Modernposter Demo}`, `\author{Firstname Lastname}` (read by the class through `\@title`, `\@author`, modernposter.cls:161,165) |
| columns | demo.tex:28-53, 55-85; modernposter.cls:177-192 | `class.modernposter` | `postercolumn` env; first column at `4em` right of the rule, later ones at `\colsep` after col1; a third column would be placed relative to col1 again (modernposter.cls:186-189), so the class supports two |
| column/box geometry (internal) | modernposter.cls:102-112 | `class.modernposter` | etoolbox `\AfterEndPreamble`: colheight 111.6em, colwidth 0.4525 linewidth, coltextwidth colwidth-2em, colsep 0.01 linewidth, boxheight 0.33 colheight, boxlinewidth 1mm; whole body wrapped in one `tikzpicture[remember picture, overlay]` (open at 109, close at 125-127) |
| titled box | demo.tex:29,32,46,56,74; modernposter.cls:194-216 | `class.modernposter` | `\posterbox[height=\boxheight]{title}{body}`: rounded frame draw mDarkTeal, fill black!2, line width 1mm; heading node fill mDarkTeal, `\Huge` white bold; body `\Large\parbox` |
| double box | demo.tex:63-73; modernposter.cls:218-221 | `class.modernposter` | `\doubleposterbox[0.6]`: two stacked boxes, first = 0.6 boxheight, second = the rest minus colsep; second title wrapped in `\highlight` (demo.tex:71) |
| highlighted text | demo.tex:30,71 | `class.modernposter` | `\highlight{...}` (also `{\highlight{\bf eros mauris}}`) |
| bullet lists | demo.tex:34-43, 66-69 | `list.kernel` | nested `itemize`; label 1 `$\bullet$`, label 2 fontawesome `angle-right` (class-set, modernposter.cls:87-88) |
| bullet list layout (internal) | modernposter.cls:71, 74-76 | `class.modernposter` | enumitem `\setlist[itemize]` and `[enumerate]` leftmargin=1in; `\itemindent`=10in; parskip 0.4em inside parboxes (cls:78-82) |
| description list | demo.tex:78-83 | `list.kernel` | `description` with bracket labels `XY18.` ... |
| bold text | demo.tex:30,33,61,77 | `mark.kernel` | `{\bf ...}` (emitter would print `\textbf`) |
| hyperlinks (internal) | modernposter.cls:132 | `class.modernposter` | hyperref `hidelinks` |
| icons (internal) | modernposter.cls:72, 84-88 | `class.modernposter` | fontawesome `\faicon`, wrapped in `\rmfamily`; used only for the level-2 bullet |
| manual: class | modernposter.tex:12 | `class.article` | no options |
| manual: colour | modernposter.tex:14, 25-28 | `color.xcolor` | `\color{lightgray}`, `black!4` |
| manual: hyperref | modernposter.tex:15 | `meta.hyperref` | `hidelinks=true`; `\href` at 94, 97 |
| manual: urls | modernposter.tex:32, 42, 94 | `meta.url` | `\url{}` (hyperref provides it) |
| manual: listings | modernposter.tex:16, 19-29, 65-91 | `code.listings` | `\lstset` basicstyle=`\footnotesize\ttfamily`, breaklines, language=TeX, numbers=left, numbersep=5pt, numberstyle=`\tiny\color{lightgray}`, stepnumber=2, tabsize=2, backgroundcolor=`\color{black!4}`; env `lstlisting` |
| manual: verbatim phrases | modernposter.tex:17, 48-50, 60-61 | `code.verbatim` | `\PVerb{...}`, presumably from `examplep` (not bundled, source not read; CTAN page names a `\verb` replacement, not the exact command) |
| manual: maths package | modernposter.tex:18, 39, 42 | `math.amsmath` | loaded; only `$\backslash$` and `$\sim$` are used |
| manual: title block | modernposter.tex:31-36 | `front.maketitle` | `\title` with `\LaTeX~`, `\author`, `\date`, `\maketitle` |
| manual: author note | modernposter.tex:32 | `front.thanks` | `\thanks{List of contributors: \url{...}}` |
| manual: abstract | modernposter.tex:38-40 | `abs.kernel` | `abstract` with leading `\noindent` |
| manual: headings | modernposter.tex:41,43,45,52,57,63,93,96,99 | `head.kernel` | `\section`, `\subsection`, default look |
| manual: footnotes | modernposter.tex:42 | `fn.kernel` | two `\footnote` |
| manual: lists | modernposter.tex:47-51, 54-56, 59-62, 100-105 | `list.kernel` | `description` |

## Bespoke code
demo.tex and modernposter.tex define no macros, environments or counters. `modernposter.cls` is the published class itself, so its internals are not zip-local bespoke code by the rubric. Listed for transparency; none was reduced to lib ways, because the reduction is the class way.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\maketitle` redefinition: TikZ banner and backdrop | modernposter.cls:137-170 | published, not reduced | `class.modernposter`; unpublished it would be `ART`, no declarative lib way |
| `postercolumn` + `numcols` counter placing nodes | modernposter.cls:177-192 | published, not reduced | `class.modernposter`; unpublished it would be `BESPOKE` (counter drives placement) |
| `\posterbox`, `\doubleposterbox` TikZ boxes | modernposter.cls:194-221 | published, not reduced | `class.modernposter`; unpublished it would be `ART` |
| overlay `tikzpicture` opened and closed by hooks | modernposter.cls:109-127 | published, not reduced | `class.modernposter` |
| `\@arrayparboxrestore`, `\faicon` patches | modernposter.cls:78-85 | published, not reduced | `class.modernposter` |
| options via pgfkeys, flags `\@logotrue`, `\@helvettrue` | modernposter.cls:32-44, 90, 115, 153 | published, not reduced | `class.modernposter` (options `hlcolor`, `logo`, `helvet`) |
| `\email`, `\highlight` | modernposter.cls:48, 134-135 | published, not reduced | class vocabulary |

## Content-opaque
none. The only external asset is the optional logo, which is not shipped (demo.tex:19 shows it in a comment only); fonts (FiraSans, fontawesome) are TeX Live packages. Notes for the emitter, not blockers: the class opens one TikZ overlay for the whole body (modernposter.cls:109), so the body must be `\maketitle` first (the columns anchor to its `sep` node, cls:183) and then only `postercolumn` environments, with all text inside box arguments; box bodies sit in a `\parbox` in a node, and the frame is a separate fixed-minimum-height node (cls:196-202), so body length is not checked against the frame; `remember picture, overlay` (cls:110) normally needs a second pass (not tested).

## Lib changes
- New ways proposed: none. `class.modernposter` is a class way and needs no proposal; vocabulary as recorded under "Class setting". Observation for the consolidator: its poster blocks (`\posterbox`) live inside the class, so no `poster.*` way was proposed; `poster.tikzposter` and `poster.baposter` are different packages.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
