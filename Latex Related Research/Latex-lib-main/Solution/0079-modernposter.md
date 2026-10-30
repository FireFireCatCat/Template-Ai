yes

# 0079-modernposter: modernposter (a0poster-based poster class with a metropolis-style banner and boxes)

- Unverified: read from the source, not compiled.
- Source: Source/0079-modernposter/ (origin: https://mirrors.ctan.org/macros/latex/contrib/modernposter.zip; licence: cc-by-sa-4, README.md:44-46, modernposter.cls:10-11)
- Kind: poster
- Lib: v1
- Engine: pdfLaTeX-compatible (the class loads no fontspec or unicode-math, modernposter.cls:15-132; needs two passes because every drawing uses `remember picture` and `current page` nodes, modernposter.cls:109-111, 138-151)
- Look carried by: class (modernposter.cls draws the banner, columns, boxes and sets colours, fonts and list marks; demo.tex only supplies title, author, email and box text)
- Class origin: ctan (ctan.org/pkg/modernposter read: version 1.03.1 2018-04-03, CC BY-SA 4.0, in TeX Live and MiKTeX; matches `\ProvidesClass` at modernposter.cls:13, README.md:3-5 and the manifest url on mirrors.ctan.org)
- Main file: demo.tex (other samples: modernposter.tex, the class manual typeset with `article`, which is the manifest's `main`; the README.md toy example, README.md:13-40)
- Read: main yes (demo.tex 87 lines and modernposter.tex 105 lines in full), zip-local classes and styles all (modernposter.cls read in full, 221 lines; the base class `a0poster` and the packages it loads are not in the zip and were not read; demo.pdf and modernposter.pdf are shipped and were not opened)

## Verdict
yes, on the class dimension. The look is carried entirely by `modernposter.cls`, which is the published CTAN class (W1 met, version and date match), so none of its code is bespoke in the rubric's sense; the emitter writes `\documentclass[<options>]{modernposter}` plus the class-native body wrappers `postercolumn`, `\posterbox` and `\doubleposterbox`, and copies no zip-local macro logic. The banner, page tint and box shapes are TikZ artwork, but they sit inside the published class and are driven only by declarative parameters (title, author, email, `hlcolor`, `logo`, `helvet`, a height fraction), which is the same reduction the rubric allows for "a poster block from tikzposter"; I propose `poster.modernposter` for that. Both samples map to lib ways. This is evidence about the class dimension, not about the component ways.

## Blockers
none (if the class were decomposed instead of used as a way, its TikZ banner and boxes would be `ART/class` and its whole-document overlay and column counter would be `BESPOKE/class`; see Bespoke code)

## Class setting
- Class: `class.modernposter` options: `hlcolor=<6-digit HTML hex>` (default `FF8000`, modernposter.cls:32-35), `logo=<image path>` (cls:33, 40), `helvet` (boolean, cls:41); none is set in demo.tex, the three are shown commented out at demo.tex:14-19. Parsed with `pgfopts` (cls:28-44). Base class: `\LoadClass[portrait]{a0poster}` (cls:15).
- Class-native vocabulary used: `\title` and `\author` (kernel, reused by `\maketitle`), `\email{...}` (cls:134-135; demo.tex:23), `\maketitle` redefined (cls:137-170; demo.tex:26), environment `postercolumn` (cls:178-192; demo.tex:28, 55), `\posterbox[height]{title}{content}` (cls:194-216; demo.tex:29, 32, 46, 56, 74), `\doubleposterbox[fraction]{t1}{c1}{t2}{c2}` (cls:218-221; demo.tex:63-73), `\highlight{...}` (cls:48; demo.tex:30, 71). Also defined and available: `\colheight`, `\colwidth`, `\coltextwidth`, `\colsep`, `\boxheight`, `\boxlinewidth` (cls:55-60), colours `mDarkTeal`, `mDarkBrown`, `hlcol` (cls:22-23, 46). From the base `a0poster`: `\veryHuge` (cls:161, 165, 169; a0poster not read).

## Component map
Rows marked "inside class" are set by the published class; the emitter gets them from `class.modernposter` and does not write them. The ways named are the nearest lib homes for what the class source shows. Rows for demo.tex are the body constructs the emitter does write.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | demo.tex:12; modernposter.cls:13 | `class.modernposter` | no options in the sample; keys `hlcolor`, `logo`, `helvet` (cls:32-44) |
| paper size and orientation (inside class) | modernposter.cls:15 | `page.a0poster` | `\LoadClass[portrait]{a0poster}`; portrait fixed by the class, paper is a0poster's default (A0, a0poster not read); the user cannot change it |
| page background tint (inside class) | modernposter.cls:138-142 | `class.modernposter` | full-page TikZ node, `fill=black!10`, `anchor=north west` at `current page.north west`, drawn first by `\maketitle` |
| title banner | demo.tex:21-26; modernposter.cls:134-170 | `front.class-native` | `\title`, `\author`, `\email`, `\maketitle`; header bar `fill=mDarkTeal`, `text height=15em`, `text width=\paperwidth-15em`; 0.15em separator `fill=hlcol` at `yshift=-15em`; optional logo `width=13em, height=13em, keepaspectratio` at `header.east` `xshift=7.5em`; title `\veryHuge \color{white} \bf`; authors `\veryHuge\smaller\smaller` white bold; email `\veryHuge\smaller\smaller` white `\bf\tt` as `\href{mailto:\@email}{\@email}` |
| two-column layout | demo.tex:28-53, 55-85; modernposter.cls:177-192 | `poster.modernposter` | `postercolumn` via `\NewEnviron` and counter `numcols`; first column `text width=\colwidth`, `xshift=4em`, `below=3em of sep.west`; later column `xshift=\colsep` at `col1.north east`; content prefixed with `~\\[\colsep]`; written by the emitter as two `\begin{postercolumn}` blocks |
| column and box dimensions (inside class) | modernposter.cls:102-108 | `poster.modernposter` | set at `\AfterEndPreamble`: `\colheight=111.6em`, `\colwidth=0.4525\linewidth`, `\coltextwidth=\colwidth-2em`, `\colsep=0.01\linewidth`, `\boxheight=0.33\colheight`, `\boxlinewidth=1mm` |
| text box with title | demo.tex:29-31, 32-45, 46-51, 56-62, 74-84; modernposter.cls:194-216 | `poster.modernposter` | `\posterbox[#1=\boxheight]{title}{content}`: body node `rounded corners, line width=\boxlinewidth, draw=mDarkTeal, fill=black!2, minimum height=#1`; heading node `fill=mDarkTeal, text height=4em, text depth=1.4em, rounded corners, align=center`, `\Huge` white `\bf`; content `\Large\parbox{\coltextwidth}{#3~}` at `yshift=-6.2em, xshift=1em`; followed by `\\[\colsep]` |
| two stacked boxes | demo.tex:63-73; modernposter.cls:218-221 | `poster.modernposter` | `\doubleposterbox[0.6]`: first box height `0.6\boxheight`, second `\boxheight-0.6\boxheight-\colsep-1.33\boxlinewidth`; the fraction is the one declarative parameter |
| inline highlight colour | demo.tex:30, 71; modernposter.cls:46-48 | `class.modernposter` | `\highlight{x}` = `\textcolor{hlcol}{x}`, `hlcol` from option `hlcolor`; used in running text and inside a box title (demo.tex:71) |
| colours (inside class) | modernposter.cls:20-23, 46 | `color.xcolor` | `\definecolor{mDarkTeal}{HTML}{23373b}`, `mDarkBrown` `604c38` (defined, no other use in the class), `hlcol` from `\modernposter@hlcolor` (default FF8000); tints `black!10`, `black!2` |
| text font (inside class) | modernposter.cls:90-95 | `font.helvet` | default `\RequirePackage[light,sfdefault]{FiraSans}`; with `helvet`: `helvet` plus `font.family-default` below |
| default family under `helvet` (inside class) | modernposter.cls:90-92 | `font.family-default` | `\renewcommand\familydefault{\sfdefault}` |
| maths font (inside class) | modernposter.cls:73, 114-123 | `font.helvet` | `sfmath`, and under FiraSans `\SetSymbolFont{operators}...`, `\DeclareSymbolFont{SFMath}` adjustments at `\AtBeginDocument`; demo.tex has no maths |
| size switches (inside class) | modernposter.cls:53, 161-169, 206, 214 | `font.size-commands` | `relsize` `\smaller`; `\veryHuge` (a0poster); `\Huge` for box titles, `\Large` for box text |
| icon in list mark (inside class) | modernposter.cls:72, 84-88 | `font.icons` | `fontawesome`; `\faicon` wrapped in `{\rmfamily ...}`; `\labelitemii` = `\faicon{angle-right}~~` |
| lists in the body | demo.tex:34-43 (two-level itemize), 66-69, 78-83 (description with `[XY18.]` style labels) | `list.kernel` | `itemize` nested one level; `description`; `\labelitemi` = `$\bullet$~~` (cls:87) |
| list geometry (inside class) | modernposter.cls:71, 74-76 | `list.enumitem` | `\setlist[itemize]{leftmargin=1in}`, `\setlist[enumerate]{leftmargin=1in}`; with `\setlength{\itemindent}{10in}` (cls:74, a plain length, `sp.lengths`) |
| paragraph spacing in boxes (inside class) | modernposter.cls:78-82 | `sp.lengths` | `\@arrayparboxrestore` extended with `\parskip0.4em`, so paragraphs inside the `\parbox` of a box are spaced 0.4em |
| bold marks in the body | demo.tex:30, 33, 61, 77 | `mark.kernel` | `{\bf ...}` switch form |
| hyperlinks (inside class) | modernposter.cls:132, 169 | `meta.hyperref` | `\RequirePackage[hidelinks]{hyperref}`; `\href{mailto:...}{...}` |
| TikZ plumbing (inside class) | modernposter.cls:65-66, 102-112, 125-127 | `poster.modernposter` | `tikz` libraries `positioning, backgrounds, shapes.misc`; one `tikzpicture[remember picture, overlay, every node/.style={inner sep=0,outer sep=0}]` opened at `\AfterEndPreamble` and closed at `\AtEndDocument`, so the whole body is inside it; not emitted separately, `art.tikz` is not used by the emitter |
| "References" block | demo.tex:77-83 | `list.kernel` | a hand-written `description` list inside the last box; there is no `thebibliography` and no citations |
| not defined or not used | n/a | none | no running heads, no `\section`, no abstract, no theorems, no floats, tables, captions, code, equations, index or cross-references in demo.tex; the class sets none of them (page style left to a0poster) |
| doc sample: class | modernposter.tex:12 | `class.article` | no options |
| doc sample: colour, links | modernposter.tex:14-15, 32, 42, 94, 97 | `color.xcolor`, `meta.hyperref`, `meta.url` | `xcolor`; `hyperref` with `hidelinks=true`; `\url`, `\href` |
| doc sample: listings | modernposter.tex:16, 19-29, 65-91 | `code.listings` | `\lstset{basicstyle=\footnotesize\ttfamily, breaklines=true, language=TeX, numbers=left, numbersep=5pt, numberstyle=\tiny\color{lightgray}, stepnumber=2, tabsize=2, backgroundcolor=\color{black!4}}`; one `lstlisting` |
| doc sample: short verbatim | modernposter.tex:17, 48-50, 60-61 | `code.verbatim` | `examplep` (CTAN, v0.04, GPL: a `\verb` replacement usable in moving arguments, per ctan.org/pkg/examplep). `\PVerb` is not defined in the file and the page does not name the command, so that examplep supplies it is inferred, not confirmed |
| doc sample: maths package | modernposter.tex:18 | `math.amsmath` | `amsmath` loaded, no display maths used (only `$\backslash$`, `$\sim$`) |
| doc sample: front matter | modernposter.tex:31-36, 38-40 | `front.maketitle`, `front.thanks`, `abs.kernel` | `\title`, `\author{...\thanks{...}}`, `\date`, `\maketitle`; `abstract` with `\noindent` |
| doc sample: headings, lists, notes | modernposter.tex:41-105 | `head.kernel`, `list.kernel`, `fn.kernel`, `mark.kernel` | `\section` and `\subsection`; `description` (lines 47-51, 54-56, 59-62, 100-105); `\footnote` at line 42; `{\tt ...}` |

## Bespoke code
Nothing here is unpublished: modernposter.cls is the CTAN release (see Class origin), so none of it is bespoke under W1. The items are the class's internals, listed so the result can be re-read if the class were ever decomposed instead of used as a way; under that reading the first four would be blockers (`BESPOKE` or `ART`).

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| whole-document overlay `tikzpicture` opened and closed through `\AfterEndPreamble` and `\AtEndDocument`, with the length setup | modernposter.cls:101-112, 125-127 | n/a published; irreducible if decomposed (`BESPOKE/class`) | none: no lib way draws a poster in one picture; the class is the way |
| `\maketitle` redefinition drawing page tint, header bar, separator, logo and three text nodes | modernposter.cls:137-170 | n/a published; `ART/class` if decomposed | none: parameters are title, author, email, `hlcolor`, `logo` |
| `postercolumn` (`\NewEnviron`, counter `numcols`, `\ifnum` choosing first or later column) | modernposter.cls:177-192 | n/a published; irreducible if decomposed (`BESPOKE/class`) | none |
| `\posterbox`, `\doubleposterbox` TikZ boxes with arithmetic heights | modernposter.cls:194-221 | n/a published; `ART/class` if decomposed | none: parameters are title, content, height fraction |
| `\@arrayparboxrestore` extension for `\parskip0.4em` | modernposter.cls:78-82 | n/a published; reducible in principle | a `\parskip` of 0.4em inside parboxes (`sp.lengths`) |
| `sfmath` symbol-font fix-ups under FiraSans | modernposter.cls:114-123 | n/a published; irreducible if decomposed | none: font plumbing, no lib way |
| `pgfopts` key handling and flag macros `\@logotrue`, `\@helvettrue` | modernposter.cls:28-46, 90, 115, 153 | n/a published; reducible | the three options of `class.modernposter` |
| `\faicon` wrapper, `\highlight`, `\email` | modernposter.cls:48, 84-85, 134-135 | n/a published; reducible | `font.icons` in `\rmfamily`; `\textcolor{hlcol}`; a stored string |

## Content-opaque
none (the only drawing is the class's own banner and boxes, covered above; demo.tex has no figures or tables)

Caveats for an emitter, noted and not blocking (the sample does not exercise them):
- The whole body is typeset inside one overlay `tikzpicture`, so anything outside `\maketitle` and `postercolumn` environments has no defined place; `\section`, abstracts and floats do not belong in this class.
- Box text is a macro argument inside `\parbox` (cls:206) and column text is captured by `\NewEnviron` (`\BODY`, cls:178-189), so verbatim, `lstlisting`, footnotes and `figure` floats would not work inside a box; `\includegraphics` and lists would.
- `postercolumn` places every later column at `col1.north east` (cls:188), so by reading the code only two columns are supported, which the manual also says (modernposter.tex:55). A poster is one page, with fixed 111.6em column height (cls:103).
- I did not check whether the `helvet` key is accepted by the first `\ProcessPgfOptions` call (cls:37) before it is declared at cls:41; not compiled.
- Missing assets, not shipped in the zip: `FiraSans` (and its fonts), `fontawesome`, `sfmath`, `relsize`, `environ`, `etoolbox`, `enumitem`, `pgfopts`, `a0poster`; all are published packages from the TeX distribution, none read.

## Lib changes
- New ways proposed: `poster.modernposter`: the published CTAN class `modernposter`, native body vocabulary `postercolumn`, `\posterbox[height]{title}{content}`, `\doubleposterbox[fraction]{t1}{c1}{t2}{c2}`, `\highlight`; pdfLaTeX. W1: on CTAN and in TeX Live (ctan.org/pkg/modernposter, version 1.03.1). W2: behaviour is set by a title, a content argument, a height fraction and class options `hlcolor`, `logo`, `helvet`; nothing is extended in code. W3: it serves a kind of component, a titled block placed in a poster column, as `poster.tikzposter` and `poster.baposter` do for their classes. W4: printed as `\documentclass[...]{modernposter}` plus body wrappers around the block's content. If the consolidator prefers one block way per poster family with the package as parameter, it can merge into `poster.tikzposter` and `poster.baposter`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
