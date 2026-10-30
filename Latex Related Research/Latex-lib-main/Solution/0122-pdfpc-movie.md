yes

# 0122-pdfpc-movie: pdfpc-movie (movie hyperlinks for the PDF Presenter Console, with its ltxdoc manual)

- Unverified: read from the source, not compiled.
- Source: Source/0122-pdfpc-movie/ (origin: https://mirrors.ctan.org/macros/latex/contrib/pdfpc-movie.zip; licence: LPPL 1.3c, README.md:32, pdfpc-movie-doc.dtx:5)
- Kind: misc (the only document is an ltxdoc package manual; the package it documents is for presentations, README.md:2)
- Lib: v2
- Engine: needs LuaLaTeX (`\RequireLuaTeX` at pdfpc-movie-doc.dtx:32; `fontspec` with OpenType fonts at :34, :49-51; `polyglossia` at :35; `selnolig` at :37). The documented package itself has no engine-specific code (pdfpc-movie.dtx:49-234).
- Look carried by: mixed (the manual's look is the published class `ltxdoc` plus the driver preamble: fonts, geometry, hyperref, quotes, pdfpc-movie-doc.dtx:29-77; the documented package is the published CTAN release `pdfpc-movie`, whose source is the .dtx itself)
- Class origin: tex-distribution-unbundled (`ltxdoc` is LaTeX base and is not in the zip; `pdfpc-movie.sty` is derived from the CTAN release by `pdfpc-movie.ins`, so it is not zip-local)
- Main file: pdfpc-movie-doc.dtx (`\documentclass` at :29, `\begin{document}` at :79; other samples: none. `pdfpc-movie.dtx` is the documented package code that the driver `\DocInput`s at :260; `pdfpc-movie-doc.pdf` is the precompiled manual, a binary, not read)
- Read: main yes (all 265 lines), zip-local classes and styles all (there is no separate .cls or .sty: the package code is the unprefixed lines of pdfpc-movie.dtx, all 234 lines read, plus pdfpc-movie.ins 41 lines and README.md 36 lines)

## Verdict
Yes. The manual is an `ltxdoc` driver (published class) whose preamble and body use only published packages and kernel commands, each in the lib; its two zip-local macros are one-line aliases (`\sty`, `\param`). The documented package is the CTAN release `pdfpc-movie`, so its code is published (W1) and is one way, proposed here as `slide.pdfpc-movie`: eight options (three dimension keys, three flags, two integer-second keys) on one `\pdfpcmovie[opts]{poster}{file}` wrapper. There is no ART and no EXTERNAL. The LuaLaTeX requirement and the unshipped fonts are recorded, not blockers.

## Blockers
none

## Class setting
- Class: `class.ltxdoc` options: `11pt` (pdfpc-movie-doc.dtx:29); paper size and margins come from `geometry` (:53), not from the class
- Class-native vocabulary used: `\MakeShortVerb{"}` (59), `\CheckSum{0}` (60), `\RecordChanges` (68), `\DescribeMacro` (169), `\StopEventually` (250), `\PrintChanges` (252), `\CodelineNumbered` (259), `\DocInput` (260), `\Finale` (263); in pdfpc-movie.dtx the `macro` environment (119, 226) and `macrocode` blocks. The sample never calls `\changes`, `\PrintIndex`, `\EnableCrossrefs`, `\GetFileInfo`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (manual) | pdfpc-movie-doc.dtx:29 | `class.ltxdoc` | `11pt`; the doc/changes vocabulary above |
| paper and size option | pdfpc-movie-doc.dtx:29 | `page.class-options` | `11pt` only |
| engine guard | pdfpc-movie-doc.dtx:31-32 | none: it is the Engine tag (considered: `iftex`, no look of its own) | `\usepackage{iftex}` `\RequireLuaTeX` abort on any other engine |
| text fonts | pdfpc-movie-doc.dtx:34, 49-51 | `font.fontspec` | `\usepackage[no-math]{fontspec}`; `\setmainfont{erewhon}`; `\setsansfont[Scale=MatchLowercase]{Source Sans Pro}`; `\setmonofont[Scale=MatchLowercase]{Hack}` |
| math font | pdfpc-movie-doc.dtx:48 | `font.newtx` | `\usepackage[erewhon]{newtxmath}` (math only; `no-math` at :34 stops fontspec touching maths) |
| language | pdfpc-movie-doc.dtx:35-36 | `lang.polyglossia` | `\setdefaultlanguage{english}` |
| ligature suppression | pdfpc-movie-doc.dtx:37 | `sp.selnolig` | option `english` |
| quotation marks | pdfpc-movie-doc.dtx:40, 141, 175, 195 | `lang.csquotes` | package defaults; `\enquote{}` and `\enquote*{}` |
| array package | pdfpc-movie-doc.dtx:39 | `tbl.tabular` | `array` loaded, no table in the sample (loaded, unused) |
| TeX logos package | pdfpc-movie-doc.dtx:41 | `font.icons` | `hologo` loaded, `\hologo` never called; same placement as a logo-name pictogram package (considered: a new `font.icons`, not proposed) |
| hyperref | pdfpc-movie-doc.dtx:42, 77 | `meta.hyperref` | `unicode, pdfborder={0 0 0}, linktoc=all, hyperindex=false`; `\hypersetup{pdftitle={The pdfpc-movie package}, pdfauthor={Sebastian Friedl}}` |
| bookmarks | pdfpc-movie-doc.dtx:43 | `meta.bookmark` | no options |
| URLs and links | pdfpc-movie-doc.dtx:73, 74, 87, 138 | `meta.url` for `\url{}`; `xref.hyperref` for `\href{url}{text}` and `\href{mailto:...}` | `\url` is also supplied by hyperref |
| page geometry | pdfpc-movie-doc.dtx:53 | `page.geometry` | `a4paper,left=4.50cm,right=2.75cm,top=3.25cm,bottom=2.75cm,nohead` |
| paragraph and list lengths | pdfpc-movie-doc.dtx:46, 86, 146, 183, 220-243 | `sp.lengths` | `\parindent0pt`; `\itemsep 0pt`/`\itemsep0pt`; `\leftskip2.5em` inside a group closed by `\par`; `\noindent` |
| hyphenation | pdfpc-movie-doc.dtx:56 | `sp.hyphenat` | `\hyphenation{}` (empty list, no effect) |
| title block | pdfpc-movie-doc.dtx:73-80 | `front.maketitle` | `\title{... \\ {\large\url{...}}}`, `\author{... \\ \href{mailto:...}{\ttfamily ...}}`, `\date{2018/07/21 (v1.0)}`, `\maketitle` |
| title page style | pdfpc-movie-doc.dtx:81 | `hf.pagestyle-kernel` | `\thispagestyle{empty}`; running heads elsewhere are the class default (ltxdoc source not read); `nohead` in geometry |
| abstract | pdfpc-movie-doc.dtx:85-88 | `abs.kernel` | `abstract` environment, `\noindent` first line |
| footnote | pdfpc-movie-doc.dtx:87 | `fn.kernel` | one `\footnote{\url{...}}` |
| table of contents | pdfpc-movie-doc.dtx:91, 99, 109, 131, 161, 167 | `toc.kernel` | `\tableofcontents`; `\addcontentsline{toc}{subsection}{...}` after each starred heading |
| headings | pdfpc-movie-doc.dtx:98, 108, 130, 159-160, 166, 217, 258 | `head.kernel` | starred `\subsection*`, `\section*`, `\subsubsection*`; `\part{}`; no renewcommand |
| page breaks | pdfpc-movie-doc.dtx:97, 158, 251, 253 | `pg.break` | `\clearpage` |
| three-column block | pdfpc-movie-doc.dtx:102-104 | `cols.multicol` | `multicols{3}` with `\sffamily\centering`; the sample does not `\usepackage{multicol}`, the ltxdoc/doc stack is expected to load it (not read), an emitter writes the load itself |
| lists | pdfpc-movie-doc.dtx:111-114, 146-151, 183-212 | `list.kernel` | `enumerate`, `itemize`, `description` (item labels `\texttt{...}`), `\itemsep` lengths above |
| centred block | pdfpc-movie-doc.dtx:102, 169-171 | `sp.ragged` | `center` environment, `\centering` |
| manual spacing | pdfpc-movie-doc.dtx:84, 116, 123, 134, 177, 181, 226, 236 | `sp.manual-space` | `\medskip` `\bigskip` `\smallskip`, `\\[\smallskipamount]`, `8\,cm` thin space |
| font switches and logos | pdfpc-movie-doc.dtx:63, 65, 74, 102, 174, 184 | `mark.kernel` | `\textsf` `\textit` `\texttt` `\emph` `\sffamily` `\rmfamily` `\mdseries` `\ttfamily`; `\LaTeX` `\LaTeXe` `\TeX` |
| size command | pdfpc-movie-doc.dtx:73 | `font.size-commands` | `\large` |
| text symbol | pdfpc-movie-doc.dtx:132 | `font.fontenc-t1` | `\textcopyright` (textcomp family) |
| inline maths | pdfpc-movie-doc.dtx:65 | `math.kernel` | `\ensuremath{\langle}`, `\ensuremath{\rangle}` inside `\param` |
| short verbatim examples | pdfpc-movie-doc.dtx:112-113, 117-121, 162, 168-170, 218, 227, 237-238 | `code.verbatim` | `"..."` short verbatim (switched on by `\MakeShortVerb{"}` at :59) |
| doc, change and code-listing machinery | pdfpc-movie-doc.dtx:59-60, 68, 169, 250-252, 259-263; pdfpc-movie.dtx:119, 226 | `dtx.doc` | `\MakeShortVerb{"}`, `\CheckSum{0}`, `\RecordChanges`, `\DescribeMacro{\pdfpcmovie}`, `\StopEventually{\clearpage \PrintChanges}`, `\CodelineNumbered`, `\DocInput{pdfpc-movie.dtx}`, `\Finale`; `macro` and `macrocode` |
| documented package: movie hyperlink | pdfpc-movie.dtx:86-113, 122-224; pdfpc-movie-doc.dtx:160-243 | `slide.pdfpc-movie` | `\usepackage{pdfpc-movie}` (no package options, doc.dtx:163); body `\pdfpcmovie[<opts>]{<poster material>}{<movie path>}`; keys `width=`, `height=`, `depth=` (TeX dimensions), flags `autostart`, `loop`, `noprogress`, integer-second `start=`, `stop=` |
| hyperref load by that package | pdfpc-movie.dtx:57, 223 | `meta.hyperref` | `\AtEndPreamble{\RequirePackage{hyperref}}`, no options; the link is `\href{run:<path>?<params>}{<poster box>}` |
| helper packages of that package | pdfpc-movie.dtx:56, 58 | none needed: internals of the published package | `etoolbox`, `pgfkeys` serve its option parsing, no look of their own, no drawing |

No theorem, float, table, figure, bibliography, index page, box or colour component is defined or used by the sample. `\PrintIndex` is never called, so no index is typeset (the README's `makeindex` steps, README.md:20-21, are the standard post-pass for the `.idx` and `.glo` files).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand*{\sty}[1]{\textsf{#1}}` | pdfpc-movie-doc.dtx:63 | yes | alias of `\textsf`, `mark.kernel` |
| `\def\param#1{...}` | pdfpc-movie-doc.dtx:65 | yes | alias of `\textit` + `\rmfamily\mdseries` + `\ensuremath{\langle}...\ensuremath{\rangle}`: `mark.kernel` and `math.kernel` |
| `pdfpc-movie.sty` source (`\newif`, `\newcount`, `\newbox`, the pgfkeys keys, `\pdfpcmovie`) | pdfpc-movie.dtx:65-224 | not bespoke: published | the CTAN release of the package, loaded as `\usepackage{pdfpc-movie}`, way `slide.pdfpc-movie` |
| DocStrip guards, `\ProvidesPackage`, `.ins` generator | pdfpc-movie.dtx:2, 18, 49-51; pdfpc-movie.ins:28-37 | yes | stock DocStrip and the `ltxdoc` driver, `class.ltxdoc` and `dtx.doc`; the .ins is a TeX run, not an outside tool |

Stricter reading, for re-use of this analysis: if the package source were counted as zip-local code instead of the published package, it would be `BESPOKE/package` and probably irreducible, because it builds the URL parameter string from a hand-rolled counter of pending options and three booleans with `\edef` and `\advance` (pdfpc-movie.dtx:65-72, 149-208) and resizes the poster box with `\wd`/`\ht`/`\dp` (216-218). The zip is the CTAN release (manifest origin mirrors.ctan.org/macros/latex/contrib/pdfpc-movie.zip), so it is published and the verdict above stands.

## Content-opaque
- The `macrocode` listing of the package implementation (pdfpc-movie.dtx:49-234) and the `\pdfpcmovie` usage examples (pdfpc-movie-doc.dtx:218, 227, 237-238) are code text printed by the manual, so content.
- The movie files named in the examples (`foo.mp4`, `bar.avi`, `res/baz.mov`, pdfpc-movie-doc.dtx:218-238) and the poster images (`foo`, `res/baz`) do not exist in the zip and are not called; they would be user assets.
- The `\CharacterTable` and `\CheckSum` lines (pdfpc-movie.dtx:3-17; pdfpc-movie-doc.dtx:60) are DocStrip bookkeeping and print nothing.

## Lib changes
- New ways proposed: `slide.pdfpc-movie` (package `pdfpc-movie`, CTAN, LPPL 1.3c; engine pdf, since the code read has no engine-specific primitive; one `\pdfpcmovie[<keys>]{<poster material>}{<movie path>}` call that makes the poster material a link to a movie for the PDF Presenter Console viewer). W1: a CTAN release (origin URL above). W2: behaviour chosen by options only (keys and flags): `width` `height` `depth` `autostart` `loop` `noprogress` `start` `stop` (pdfpc-movie.dtx:86-113; doc.dtx:182-212). W3: serves a kind of component, a linked movie box, for any film and any poster. W4: printable as `\usepackage{pdfpc-movie}` plus a body wrapper around the poster node's content. Not EXTERNAL: TeX alone writes the PDF; the viewer (pdfpc) plays the movie and the movie file is a shipped asset, as an image would be.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Missing assets, not blockers: the fonts `erewhon`, `Source Sans Pro` and `Hack` are looked up by name and are not shipped in the zip (pdfpc-movie-doc.dtx:49-51).
- `makeindex` (README.md:20-21; pdfpc-movie-doc.dtx:118-119) produces the `.idx` and `.glo` result for the doc run. It is the TeX Live post-pass, not counted as EXTERNAL, as `bib.bibtex-bst` is accepted in the lib; the manual still builds without it, since the sample has no `\changes` entry (none in pdfpc-movie.dtx) and no `\PrintIndex`.
- The driver compiles the manual from the .dtx, so no movie link is ever typeset by it: the `\pdfpcmovie` calls appear only as short-verbatim text. This zip tests `slide.pdfpc-movie` as a documented package, not as drawn output.
- `ltxdoc` source (LaTeX base) was not read; the class is published and loaded unchanged.
- No text addressed to an AI was found in the zip.
