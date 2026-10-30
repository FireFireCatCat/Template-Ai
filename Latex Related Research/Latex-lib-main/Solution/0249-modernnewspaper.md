yes

# 0249-modernnewspaper: modernnewspaper (Unicode-first newspaper package)

- Unverified: read from the source, not compiled.
- Source: Source/0249-modernnewspaper/ (origin: https://mirrors.ctan.org/macros/unicodetex/latex/modernnewspaper.zip; licence: LPPL 1.3c, LICENSE:13 and modernnewspaper.sty:7-8)
- Kind: newsletter
- Lib: v3
- Engine: needs XeLaTeX (also LuaLaTeX per docs/modernnewspaper-doc.tex:81-86): `fontspec` (modernnewspaper.sty:29), `polyglossia` (:38) and `bidi` (:39) are loaded unconditionally, and a guard raises an error under pdfTeX (:19-24)
- Look carried by: class (the published style package `modernnewspaper.sty` carries the whole look under `\documentclass{article}`; the sample adds only metadata strings, article bodies, column counts and one hand-laid inner-page header made of kernel commands at example/modernnewspaper-example.tex:75-85)
- Class origin: ctan (the style layer `modernnewspaper.sty`, v0.2.1 dated 2026/01/07 at modernnewspaper.sty:14, is listed on ctan.org/pkg/modernnewspaper, directory /macros/unicodetex/latex/modernnewspaper, LPPL 1.3c; the base class `article` is the kernel class, not in the zip, source not read)
- Main file: example/modernnewspaper-example.tex (other samples: docs/modernnewspaper-doc.tex, the package manual, which the manifest lists as `main`; README.md:70-100 quick start)
- Read: main yes, zip-local classes and styles all (modernnewspaper.sty read in full, 490 lines; lines 214-490 are a second copy that TeX never reads, see Bespoke code)

## Verdict
Yes. The only style file is a CTAN package whose every macro is a composition of kernel commands and published packages (`geometry`, `multicol`, `fontspec`, `setspace`, `hyperref`, `bidi`) with string, length and font-switch parameters; each reduction is written down below. There is no TikZ or other artwork, no output routine, no counter arithmetic, and nothing that needs a tool outside TeX. Fonts (Amiri, Noto Serif Devanagari, Myanmar and CJK SC) are not shipped: missing assets, not a blocker.

## Blockers
none

## Class setting
- Class: `class.article` options: none in the example (example/modernnewspaper-example.tex:1); `a4paper,11pt` in the manual (docs/modernnewspaper-doc.tex:1)
- Style layer: `class.modernnewspaper` (a published CTAN package loaded under `article`, no package options: no `\DeclareOption` or `\ProcessOptions` in modernnewspaper.sty). Recorded as class-like, as the lib's v3 change log treats a house-style package's own vocabulary; every macro below is also reduced to existing component ways, so the verdict does not rest on this line.
- Class-native vocabulary used (of the style layer): preamble setters `\SetPaperName` `\SetPaperSlogan` `\SetPaperLocation` `\SetPaperWebsite` `\SetPaperVolume` `\SetPaperIssue` `\SetPaperDate` `\SetByWord` (modernnewspaper.sty:101-107, :141); body `\MakePaperHeader` (:112), `\BeginNewsColumns{n}` / `\EndNewsColumns` (:207-208), environment `article` (:195), `\headline{}` `\byline{}` `\DropCap{}` (:146, :152, :165), `\EnableRTL` / `\DisableRTL` (:189-190). Defined but not called by the example: `\dateline{}` (:157), `\ArticleImage{width}{file}{caption}` (:175, shown in docs/modernnewspaper-doc.tex:212), style hooks `\headlinestyle` `\bylinestyle` `\datelinestyle` (:133-135), font families `\ArabicFont` `\DevaFont` `\MyanmarFont` `\CJKFont` (:66-75, called as span wrappers at example/modernnewspaper-example.tex:29, 43, 57, 96).
- Article-class vocabulary used: the manual only: `\title` `\author` `\date` `\maketitle` (docs/modernnewspaper-doc.tex:56-63), `\section` `\subsection` (:66, :94). The example uses none.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | example/modernnewspaper-example.tex:1 | `class.article` | no options |
| class paper and size (manual) | docs/modernnewspaper-doc.tex:1 | `page.class-options` | a4paper, 11pt |
| style layer load | example/modernnewspaper-example.tex:2; modernnewspaper.sty:14 | `class.modernnewspaper` | `\usepackage{modernnewspaper}`, no options |
| engine guard | modernnewspaper.sty:19-24; docs/modernnewspaper-doc.tex:6-9 | none (engine tag, no printed output) | `\ifPDFTeX` then `\PackageError`; manual `\errmessage` |
| page geometry | modernnewspaper.sty:44-48 | `page.geometry` | a4paper, margin=20mm, headsep=10mm |
| page geometry (manual) | docs/modernnewspaper-doc.tex:24 | `page.geometry` | margin=25mm |
| line breaking tolerance | modernnewspaper.sty:53-55 | `sp.hyphenat` | `\pretolerance=10000`, `\tolerance=10000`, `\emergencystretch=2em` (the parameters `\sloppy` sets, `\tolerance` and `\emergencystretch`; raw assignments) |
| main font | modernnewspaper.sty:60, :63 | `font.fontspec` | `\defaultfontfeatures{Ligatures=TeX}`, `\setmainfont{TeX Gyre Termes}` |
| per-script font families | modernnewspaper.sty:66-75; example/modernnewspaper-example.tex:29, 43, 57, 96 | `font.fontspec` | `\newfontfamily` Amiri (`\ArabicFont`), Noto Serif Devanagari (`\DevaFont`), Noto Serif Myanmar (`\MyanmarFont`), Noto Serif CJK SC (`\CJKFont`); switched on by a `{\Family ...}` group around the article text; no Script= or Language= option |
| fonts (manual) | docs/modernnewspaper-doc.tex:14, :29-30 | `font.fontspec` | `\setmainfont{TeX Gyre Termes}`, `\setsansfont{TeX Gyre Heros}` |
| language packages | modernnewspaper.sty:38 | `lang.polyglossia` | load only; no `\setmainlanguage` or `\setdefaultlanguage` anywhere in the zip |
| RTL support package | modernnewspaper.sty:39 | `lang.bidi` | load only; direction switch used at :198, :200 |
| hyperlinks | modernnewspaper.sty:34, :80-85 | `meta.hyperref` | colorlinks=true, linkcolor=black, urlcolor=blue, pdfcreator={modernnewspaper} |
| hyperlinks (manual) | docs/modernnewspaper-doc.tex:16, :35-41 | `meta.hyperref` | same colours, plus pdftitle, pdfauthor |
| columns package | modernnewspaper.sty:31 | `cols.multicol` | `multicols` environment, loaded and used by `\BeginNewsColumns` |
| graphics, colour, spacing packages | modernnewspaper.sty:32, :33, :35 | `fig.graphicx`, `color.xcolor`, `sp.setspace` | load only (each is used by a macro below, except xcolor) |
| newspaper columns | modernnewspaper.sty:207-208; example/modernnewspaper-example.tex:22, 63, 89, 123 | `cols.multicol` | columns=3 on both pages; `\BeginNewsColumns{3}` is `\begin{multicols}{3}`, `\EndNewsColumns` is `\end{multicols}` |
| masthead (front-page title block) | modernnewspaper.sty:112-128; example/modernnewspaper-example.tex:7-13, 20 | `front.class-native` | reduces to: `center` environment (`sp.ragged`), name in `\Huge\bfseries` (`font.size-commands`, `mark.kernel`), `\vspace{4pt}`, slogan in `\itshape`, `\vspace{6pt}`, one `\small` line `location \quad\|\quad Vol.~V, No.~N \quad\|\quad date \quad\|\quad \href{url}{url}` (`meta.hyperref`), then `\vspace{1em}`, `\hrule`, `\vspace{1.5em}` (`sp.manual-space`, `sp.rule`); strings come from the setters, date default `\today` (:96) |
| masthead ways it reduces to | modernnewspaper.sty:114-127 | `sp.ragged`, `font.size-commands`, `mark.kernel`, `sp.manual-space`, `sp.rule`, `meta.hyperref` | as listed in the row above |
| headline | modernnewspaper.sty:133, :146-150; example/modernnewspaper-example.tex:26, 40, 54, 93, 104, 114 | `head.class-native` | `\par\bigskip`, `{\Large\bfseries #1\par}`, `\medskip` (`sp.manual-space`, `font.size-commands`, `mark.kernel`); look hook `\headlinestyle` |
| byline | modernnewspaper.sty:134, :140-141, :152-155; example/modernnewspaper-example.tex:27, 37, 50 | `front.class-native` | `{\itshape <By word>\ #1\par}`, `\smallskip`; By word is a string (`\SetByWord`, default By, Arabic بقلم at example/modernnewspaper-example.tex:37) |
| dateline (defined, unused in the sample) | modernnewspaper.sty:135, :157-160 | `front.class-native` | `{\small #1\par}`, `\medskip` |
| article body wrapper | modernnewspaper.sty:195-202; example/modernnewspaper-example.tex:25, 33, 39, 47, 53, 61, 92, 100, 103, 110, 113, 121 | `sp.setspace` | `\setstretch{1.03}` (stretch=1.03) inside the environment group, then `\par\medskip` at the end (`sp.manual-space`) |
| RTL article | modernnewspaper.sty:186-190, :198, :200; example/modernnewspaper-example.tex:36-37, 49-50 | `lang.bidi` | the article body is wrapped in `\beginR` ... `\endR` when the flag is set; otherwise no wrapper (switch family of `\RL`/`\LR`, engine behaviour of `\beginR` under LuaLaTeX not established here) |
| drop initial | modernnewspaper.sty:165-170; example/modernnewspaper-example.tex:30, 44, 58, 97, 107, 117 | `sp.lengths` | group with `\parindent0pt`, `\hangindent=2em`, `\hangafter=1`, then the letter in `\fontsize{36pt}{36pt}\selectfont\bfseries` (`font.size-commands`, `mark.kernel`). The hang assignments sit in the group that closes right after the letter (:166-169), so by TeX's scoping rules they are gone when the paragraph is broken: reading only, not measured. considered: `lettrine` (`sp.lettrine`), which appears only in the dead copy (:412-414) |
| column-safe image (defined, unused in the sample) | modernnewspaper.sty:175-181; docs/modernnewspaper-doc.tex:212 | `fig.graphicx` | `center` environment (`sp.ragged`) holding `\includegraphics[width=#1]{#2}`, `\par\smallskip`, unnumbered caption `{\small\itshape #3}`; not a float, not `\caption` |
| inner-page header (hand-laid in the body) | example/modernnewspaper-example.tex:75-85 | `sp.rule` | two `\hrule` (:76, :84) around a `center` block (`sp.ragged`) with `{\small ... \quad \| \quad \today}` (`font.size-commands`), and `\vspace{0.1em}` x4 (`sp.manual-space`, :75, 77, 83, 85) |
| page break | example/modernnewspaper-example.tex:68 | `pg.break` | `\newpage` |
| page style | no `\pagestyle` anywhere in the zip | `hf.pagestyle-kernel` | class default `plain` (page number in the foot), not set by the zip |
| date | modernnewspaper.sty:96; example/modernnewspaper-example.tex:13, 80 | none (content) | kernel `\today` as the printed value |
| title block (manual) | docs/modernnewspaper-doc.tex:56-63 | `front.maketitle` | `\title{\textbf{modernnewspaper}\\ ...}`, `\author{Laitei}`, `\date{Version 0.2.1 --- January 2026}`, `\maketitle` |
| headings (manual) | docs/modernnewspaper-doc.tex:66, :94 | `head.kernel` | `\section`, `\subsection` with the article defaults |
| titlesec (manual) | docs/modernnewspaper-doc.tex:19 | `head.titlesec` | load only; no `\titleformat` or `\titlespacing` anywhere in the zip |
| lists (manual) | docs/modernnewspaper-doc.tex:83-86, :268-272, :281-287 | `list.kernel` | `itemize` |
| code listings (manual) | docs/modernnewspaper-doc.tex:17, :46-51, :112-114 | `code.listings` | `\lstset{basicstyle=\ttfamily\small, frame=single, breaklines=true, keywordstyle=\color{blue}}` |
| verbatim (manual) | docs/modernnewspaper-doc.tex:103-105 | `code.verbatim` | `verbatim` environment |
| colour (manual) | docs/modernnewspaper-doc.tex:18, :50 | `color.xcolor` | `\color{blue}` in the listings style |
| quote (manual) | docs/modernnewspaper-doc.tex:245-247 | `quote.kernel` | `quote` environment |
| URLs (manual) | docs/modernnewspaper-doc.tex:297, :306 | `meta.url` | `\url{}` inside `center` (`sp.ragged`) |
| inline marks (manual) | docs/modernnewspaper-doc.tex:68, :71 | `mark.kernel` | `\textbf`, `\texttt` |

Components the zip does not define or use: sectioning in the example, theorems, maths, tables, floats with `\caption`, footnotes, bibliography, index, abstract, table of contents, running headers.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| engine guard | modernnewspaper.sty:19-24 | yes | prints nothing; the emitter selects XeLaTeX or LuaLaTeX (engine tag `xe/lua`) |
| metadata store and setters | modernnewspaper.sty:90-107 | yes | `\newcommand` / `\renewcommand` of string macros; the emitter prints the strings (name, slogan, location, website, volume, issue, date) straight into the masthead |
| `\MakePaperHeader` | modernnewspaper.sty:112-128 | yes | one fixed sequence of kernel commands, see the masthead row |
| style hooks `\headlinestyle` `\bylinestyle` `\datelinestyle` | modernnewspaper.sty:133-135 | yes | `\newcommand` aliases for font-switch lists (`\Large\bfseries`, `\itshape`, `\small`) |
| `\SetByWord` and `\MN@ByWord` | modernnewspaper.sty:140-141 | yes | a string printed before the author, a parameter |
| `\headline` `\byline` `\dateline` | modernnewspaper.sty:146-160 | yes | spacing, font switches, a paragraph; rows above |
| `\DropCap` | modernnewspaper.sty:165-170 | yes | `\parindent`, `\hangindent`, `\hangafter` assignments and a `\fontsize` switch; no box measuring, no `\lettrine` |
| `\ArticleImage` | modernnewspaper.sty:175-181 | yes | `center` + `\includegraphics` + small italic text |
| `\ifMN@RTL`, `\EnableRTL`, `\DisableRTL` | modernnewspaper.sty:186-190, :198, :200 | yes | a boolean the author flips at known places (example/modernnewspaper-example.tex:36, 49); it only chooses between two fixed wrappers (`\beginR ... \endR` or none), so the emitter writes the wrapper per article node. It is a switch, not a computation of layout |
| `article` environment | modernnewspaper.sty:195-202 | yes | group with `\par`, `\setstretch{1.03}`, optional bidi wrapper, `\par\medskip` |
| `\BeginNewsColumns` / `\EndNewsColumns` | modernnewspaper.sty:207-208 | yes | `\begin{multicols}{n}` and `\end{multicols}` split over two commands |
| dead second copy of the package with merge-conflict markers | modernnewspaper.sty:214-490 (markers at :227, :229, :231, :274, :276, :285, :372, :374, :376, :401, :409, :446) | not part of the look | the first copy ends with `\endinput` at :213, so TeX does not read what follows; it holds a `lettrine` / `wrapfig` variant (:253-254, :412-425) that is never loaded |
| `\SectionBanner` | named at docs/modernnewspaper-doc.tex:258 and README.md:122 only | not defined anywhere | grep finds no definition in the zip; the manual describes rules above and below centred text (docs/modernnewspaper-doc.tex:254-261), which would be `sp.rule` plus `sp.ragged`; unreachable from the example |

## Content-opaque
none (the example holds multilingual running text in Myanmar, Arabic, Hindi, Chinese and English, which is content; no figure, table or picture content).

## Lib changes
- New ways proposed: none. Considered and not needed: `lettrine` (`sp.lettrine` already exists and the live code does not call it); a package-level way for the newspaper vocabulary, since the style layer is recorded as `class.modernnewspaper` and each macro already reduces to existing ways.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
