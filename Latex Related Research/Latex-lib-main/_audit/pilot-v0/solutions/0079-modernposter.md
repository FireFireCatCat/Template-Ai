yes

# 0079-modernposter: modernposter (a modern LaTeX poster class)

- Unverified: read from the source, not compiled.
- Source: Source/0079-modernposter/ (origin: https://mirrors.ctan.org/macros/latex/contrib/modernposter.zip; licence: cc-by-sa-4)
- Kind: poster
- Lib: v0
- Engine: pdfLaTeX-compatible (no fontspec, unicode-math or Lua named in either sample or in the class; nothing was compiled, so this is read, not tested)
- Main file: demo.tex (other samples: modernposter.tex, the package manual on `class.article`; the manifest lists modernposter.tex as main, but only demo.tex exercises the template, so both are mapped below)
- Read: main yes, zip-local classes and styles all (modernposter.cls, 221 lines, whole). demo.pdf and modernposter.pdf are compiled outputs, binary, not read.

## Verdict
The zip is the CTAN class `modernposter` itself (README.md:5 says it is on CTAN, TeX Live and MiKTeX), so the zip-local `.cls` is published (W1). Its look is chosen by three class options (`hlcolor`, `logo`, `helvet`, modernposter.cls:32-44) plus the class's own `postercolumn`/`posterbox`/`doubleposterbox`/`\maketitle` vocabulary, which is what both samples use. Neither sample defines a macro, environment, counter or drawing of its own (grep: no `\newcommand`, `\def`, `\newenvironment`, `\newcounter` in demo.tex or modernposter.tex). The `yes` rests on treating the published class as one `class.<name>` way as the rubric says; the class source itself would be irreducible (see Bespoke code) and is not copied by an emitter.

## Blockers
none

## Class setting
- Class: `class.modernposter` options: none on the live line (demo.tex:12). The class takes `hlcolor=<6-digit HTML hex>` (default FF8000, modernposter.cls:35), `logo=<image path>` (cls:33-34, 40), `helvet` (boolean flag, cls:41, 90-95). The commented-out line shows all three: `[helvet,logo=logo.png,hlcolor=F70146]` (demo.tex:19). Paper size and orientation are fixed inside the class: `\LoadClass[portrait]{a0poster}` (cls:15).
- Class-native vocabulary used: `\title`, `\author`, `\email` (class-defined, cls:134-135), `\maketitle` (cls:137-170), `postercolumn` environment (cls:177-192), `\posterbox[height]{title}{content}` (cls:194-216), `\doubleposterbox[fraction]{t1}{c1}{t2}{c2}` (cls:218-221), `\highlight{text}` (cls:48). Not used by the sample directly: the `logo` option and `\faicon` (the nested list at demo.tex:37 reaches `\faicon` only through the class's `\labelitemii`, cls:88).
- Second class setting, documentation file only: `class.article`, no options (modernposter.tex:12).

## Component map
Rows 1-12 are demo.tex, the template sample. Rows 13-25 are modernposter.tex, the manual. A package the class loads internally is named in plain words in Parameters, not as a lib id, because the emitter does not emit it separately.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| 1 document class and poster look | demo.tex:12; modernposter.cls:13-15 | `class.modernposter` | no options in live line; documented options hlcolor, logo, helvet (demo.tex:14-19) |
| 2 page size, orientation, margins | modernposter.cls:15, 103-108 | `class.modernposter` | inherited from a0poster portrait, fixed; column geometry fixed in class (colwidth 0.4525 linewidth, colsep 0.01 linewidth, colheight 111.6em); no emitter parameter |
| 3 poster header banner (title, author, email, optional logo) | demo.tex:21-23, 26; modernposter.cls:137-170 | `front.class-native` | `\title{..}` `\author{..}` `\email{..}` then `\maketitle`; banner colours and sizes fixed by the class (teal 23373b band 15em, separator rule in hlcol, white bold \veryHuge title) |
| 4 highlight colour | demo.tex:30, 71; modernposter.cls:32-35, 46, 48 | `class.modernposter` | `hlcolor=<hex>` option; `\highlight{...}` wraps text in that colour; same colour feeds the separator rule under the banner (cls:148-152) |
| 5 poster columns | demo.tex:28, 53, 55, 85; modernposter.cls:177-192 | `class.modernposter` | `postercolumn` env, no parameters; first column placed below the banner, later columns anchored at `col1.north east` (cls:186-189), so the code is a two-column layout |
| 6 titled text box | demo.tex:29, 32, 46, 56, 74; modernposter.cls:194-216 | `class.modernposter` | `\posterbox[<height, default 0.33 colheight>]{title}{content}`; rounded teal-framed box, teal title bar (cls:196-214) |
| 7 stacked pair of boxes | demo.tex:63-73; modernposter.cls:218-221 | `class.modernposter` | `\doubleposterbox[0.6]{t1}{c1}{t2}{c2}`; fraction = share of one box height taken by the first |
| 8 body font | modernposter.cls:90-95 | `class.modernposter` | default Fira Sans (light, sfdefault) with sans math via sfmath (cls:73, 94, 114-123); option `helvet` switches to Helvetica as `\familydefault` (cls:91-92) |
| 9 bulleted list, two levels | demo.tex:34-43, 66-69; modernposter.cls:71-76, 87-88 | `list.kernel` | `itemize` nested once; markers (bullet, then fontawesome angle-right) and `leftmargin=1in` set inside the class via enumitem |
| 10 labelled list used as reference list | demo.tex:77-83 | `list.kernel` | `description` with hand-typed labels "XY18." etc; no `\cite`, no bibliography way (hand-typed content) |
| 11 bold text | demo.tex:30, 33, 61, 77 | `mark.kernel` | legacy `\bf` switch in braces (same family as `\textbf`) |
| 12 links and paragraph spacing (class-internal) | modernposter.cls:132, 78-82 | `class.modernposter` | hyperref with `hidelinks`; email shown as a `mailto:` link in the banner (cls:169); `\parskip` 0.4em inside parboxes |
| 13 document class (manual) | modernposter.tex:12 | `class.article` | no options |
| 14 colour | modernposter.tex:14, 25, 28 | `color.xcolor` | package xcolor; uses `lightgray`, `black!4` |
| 15 hyperlinks | modernposter.tex:15, 94, 97 | `meta.hyperref` | `hidelinks=true`; `\href{mailto:..}`, `\href{https://..}` |
| 16 URLs | modernposter.tex:32, 42 | `meta.url` | `\url{...}` (supplied by hyperref) |
| 17 title block | modernposter.tex:31-36 | `front.maketitle` | `\title` `\author` `\date` `\maketitle`, default article look |
| 18 author note | modernposter.tex:32 | `front.thanks` | `\thanks{...}` inside `\author` |
| 19 abstract | modernposter.tex:38-40 | `abs.kernel` | `abstract` env, body starts with `\noindent` |
| 20 sectioning | modernposter.tex:41, 43, 45, 52, 57, 63, 93, 96, 99 | `head.kernel` | `\section`, `\subsection`, article defaults |
| 21 footnotes | modernposter.tex:42 | `fn.kernel` | `\footnote{...}` (second use of a note besides the `\thanks`) |
| 22 description lists | modernposter.tex:47-51, 54-56, 59-62, 100-105 | `list.kernel` | `description` |
| 23 code listing | modernposter.tex:16, 19-29, 65-91 | `code.listings` | `\lstset{basicstyle=\footnotesize\ttfamily, breaklines=true, language=TeX, numbers=left, numbersep=5pt, numberstyle=\tiny\color{lightgray}, stepnumber=2, tabsize=2, backgroundcolor=\color{black!4}}`; `lstlisting` env |
| 24 inline verbatim phrases | modernposter.tex:17, 48-50, 60-61 | `code.verbatim` | package `examplep`, command `\PVerb{...}` (a robust `\verb` replacement, published; only `\PVerb` is used, no `examplep` example environment). Mapped to the verbatim family; examplep source not read, not in the zip. CTAN page checked: published, in TeX Live. |
| 25 font sizes, legacy font switch, maths package | modernposter.tex:20, 25, 18, 39, 42 | `font.size-commands`, `mark.kernel`, `math.amsmath` | `\footnotesize`, `\tiny`; `\tt`; `amsmath` is loaded (line 18) but no amsmath environment is used, only `$\backslash$`, `$\sim$` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| sample-level macros, environments, counters | demo.tex, modernposter.tex | none exist | no zip-local definitions in either sample |
| `modernposter.cls` as a whole | modernposter.cls:1-221 | n/a: published on CTAN (README.md:5), so one `class.modernposter` way, W1 to W4 argued under Lib changes | the emitter prints `\documentclass[hlcolor=..,logo=..,helvet]{modernposter}` and the body wrappers; the class code is not copied |
| class internals, for the record only: global TikZ overlay opened in `\AfterEndPreamble` and closed in `\AtEndDocument`; `postercolumn` placement driven by the `numcols` counter; `\@arrayparboxrestore` patch; `\SetSymbolFont` sfmath patch; banner and box drawn as TikZ nodes | modernposter.cls:78-82, 102-127, 137-170, 177-221 | Not reducible to lib ways if the class were not published | would be `BESPOKE` plus `ART` (header banner, box shapes) for a private copy; here it is published, as `tikzposter` is, so it counts as the class way |

## Content-opaque
none in the samples (no figure, table or picture). If the `logo` option is used the emitter must ship the image file; none is shipped (demo.tex:19 names `logo.png`, commented out). Missing asset, not a blocker.

## Lib changes
- New ways proposed: none. `class.modernposter` is a class way and needs no proposal (rubric, "Class setting"). Profile for the lib's class section: poster class on top of `a0poster` (portrait); options `hlcolor`, `logo`, `helvet`; vocabulary `postercolumn`, `\posterbox`, `\doubleposterbox`, `\highlight`, `\email`, `\maketitle`. W1 CTAN macros/latex/contrib/modernposter; W2 three options and two optional arguments (box height, split fraction); W3 serves poster documents generally; W4 one `\documentclass` line plus body wrappers.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Limit for Flouest: the class exposes only the three options and fixed geometry. A poster that needs a different paper size, three columns, other banner colours or other box shapes cannot be set by parameters; the class would have to be edited. That is outside what these two samples show.
- Not traced: option handling is two-pass pgfkeys (`\ProcessPgfOptions` at cls:37 and 44, `logo` key declared at cls:34 and again at cls:40). Not checked how pgfopts treats `helvet` on the first pass. This is class-internal and does not change the verdict.
- Not verified: the class never names `graphicx` (cls:15-132 `RequirePackage` list), yet `\includegraphics` is used in the logo branch (cls:156); presumably it comes through tikz/pgf. Not checked.
- `mDarkBrown` is defined (cls:23) and never used anywhere in the zip.
- No text addressed to an AI was found in the zip.
