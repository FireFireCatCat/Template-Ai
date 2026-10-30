no

# 0205-amcos-conference-booklet: AMCOS Conference Booklet

- Unverified: read from the source, not compiled.
- Source: Source/0205-amcos-conference-booklet/ (origin: https://latextemplates.com/downloads/amcos-conference-booklet.zip; licence: GPL-3.0, LICENSE:1-2, README.md:29-32)
- Kind: book
- Lib: v2
- Engine: pdfLaTeX-compatible (inputenc/T1, cmbright, tikz-based `background`; no fontspec or Lua)
- Look carried by: preamble (main.tex:15-37 and the zip-local input file preamble_booklet.tex; the zip has no .cls or .sty)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (preamble_booklet.tex read in full, 117 lines; README.md and LICENSE header read)

## Verdict
No. The class is the published KOMA `scrbook` and most of the preamble reduces to lib ways, but the template's identity includes three things that do not: the KL/IS/CT talk-type badges drawn as TikZ circle nodes (ART), an every-page hook that switches an edge colour bar left or right by page parity, and a chapter-heading bar that mirrors by page parity (both read strictly as conditionals that drive what is printed, with code branches that fail W2). The ART blocker alone keeps the answer `no`; the two parity blockers are a stricter reading of the rubric and are marked as such.

## Blockers
- `ART/preamble` talk-type tag circles: `\tikz ... \node[circle, inner sep=2pt, minimum size=0.5em, fill=\KLcolor]{\small \bfseries KL}` and the IS and CT copies, used in every talk abstract (preamble_booklet.tex:49-51; used main.tex:105, 118, 133, 144; README.md:26-27 names them as kept look)
- `BESPOKE/preamble` page-parity hook: `\AddEverypageHook` with `\ifthenelse{\isodd{\thepage} \AND \thepage>1}` choosing `position`, `nodeanchor` and calling `\BgMaterial` (preamble_booklet.tex:60-69). The bar itself is `bg.background`; the parity dispatch has no lib way (judgement: strict reading of "conditionals that drive what is printed")
- `BESPOKE/preamble` parity-mirrored chapter bar: `\renewcommand{\chapterlinesformat}[3]` with `\ifthispageodd{..}{..}` and two mirrored branches (preamble_booklet.tex:87-98; same judgement as above)

## Class setting
- Class: `class.scrbook` options: `openany`, `parskip=full`, `12pt`, `a4paper` (main.tex:15). Class not bundled in the zip (KOMA-Script, TeX distribution); its source was not read.
- Class-native vocabulary used: `\chapter`, `\section`, `\tableofcontents`, `titlepage` environment (main.tex:43, 56, 60); `\RedeclareSectionCommand[afterskip, beforeskip, level, toclevel]{chapter}` (preamble_booklet.tex:77-82); `\setkomafont{chapter}` (preamble_booklet.tex:84); `\chapterlinesformat` hook (preamble_booklet.tex:87); `\ifthispageodd` (preamble_booklet.tex:88). `scrbook` has no `abstract` environment, so the zip's `\newenvironment{abstract}` (preamble_booklet.tex:18) is a new environment, not an override (not verified against the class source).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:15 | `class.scrbook` | openany, parskip=full (paragraph spacing is a class option here, not the `parskip` package), 12pt, a4paper |
| paper and base size | main.tex:15 | `page.class-options` | a4paper, 12pt |
| page margins | none set | `class.scrbook` default | no geometry or `typearea` call; class default type area |
| encoding | main.tex:17-18 | `font.fontenc-t1` | inputenc utf8, fontenc T1 |
| typeface | main.tex:21 | `font.helvet` | package `cmbright` (CM Bright sans family; a sans text-face package is the parameter, as in lib v1 `font.helvet` merge) |
| microtype | main.tex:20 | `sp.microtype` | defaults |
| colour packages | main.tex:22-23 | `color.color`, `color.xcolor` | `xcolor` option `table` |
| colour definitions | preamble_booklet.tex:7-10, 12-13, 45-47, 104-106 | `color.xcolor` | myorange RGB 255,117,40; mygray 164,168,172; mywhite 235,238,231; myblue 52,115,116; expressions myorange!45, myblue!65, white, gray, gray!25 |
| language | main.tex:31 | `lang.babel` | english |
| hyperlinks | main.tex:32 | `meta.hyperref` | hidelinks |
| URL in title page | main.tex:53 | `meta.url` | `\url` (from hyperref) |
| page style | main.tex:34 | `hf.pagestyle-kernel` | plain |
| section numbering | main.tex:35 | `num.secnumdepth` | secnumdepth=-2 (chapters and sections unnumbered) |
| title page | main.tex:43-54 | `front.titlepage-env` | hand-laid `titlepage`; centred, `\vspace*{3cm}`, `\vfill`, no `\maketitle` |
| title page text | main.tex:46-53 | `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.ragged`, `sp.manual-space` | `\Huge \Large \large \small`, `\bfseries`, `\textcolor{myblue}`, `\centering`, `\\[1em]`, `\\[2em]`, `\\[3em]` |
| table of contents | main.tex:56 | `toc.kernel` | `\tableofcontents`; chapter `toclevel=0` set at preamble_booklet.tex:81 |
| chapter, section calls | main.tex:60-62, 79, 98, 100, 154, 164 | `head.kernel` | `\chapter`, `\section` with default KOMA look |
| chapter heading structure | preamble_booklet.tex:77-82 | `head.class-native` | `\RedeclareSectionCommand` afterskip=4em plus 1pt minus 1pt, beforeskip=-1pt, level=0, toclevel=0 |
| chapter heading font | preamble_booklet.tex:84 | `head.koma-fonts` | `\setkomafont{chapter}{\normalfont\normalsize\bfseries\Huge}` |
| chapter heading bar | preamble_booklet.tex:74-75, 87-98 | `head.class-native`, `sp.rule`, `sp.manual-space`, `color.xcolor`, `sp.lengths` | `\chapterlinesformat`: `\rule{\paperwidth}{1em}` in myblue, `\raisebox{-0.2em}`, `\makebox[0pt][r/l]`, `\hspace{\mybarpadding}` with `\mybarpadding=1.5em`; branch per `\ifthispageodd` is BESPOKE (see Blockers) |
| edge colour bar | preamble_booklet.tex:57-58, 60-69 | `bg.background` | scale=1, angle=0, opacity=1; color=mywhite; position=current page.south east / south west; nodeanchor=south east / south west; contents=`\rule{10pt}{0.66\paperheight}`; the parity switch is BESPOKE (see Blockers) |
| about: committee grid | main.tex:69-75 | `tbl.tabular`, `sp.ragged` | `tabular{lll}` inside `center` |
| timetable | main.tex:83-94 | `tbl.longtable`, `tbl.tabular` | `longtable` with column spec `\|C{0.15\linewidth}\| C{0.04\linewidth}\| C{0.3\linewidth} C{0.0\linewidth} C{0.4\linewidth}\|`, `\hline`, `\multicolumn`, `\arraystretch=1.3` (main.tex:84-85) |
| timetable column types | preamble_booklet.tex:111-113 | `tbl.tabular` | `\newcolumntype{L,C,R}[1]` over `m{#1}` with `\raggedright/\centering/\raggedleft`, `\arraybackslash`, `\hspace{0pt}` |
| timetable row colours | preamble_booklet.tex:104-109, 115-117 | `tbl.colortbl`, `color.xcolor` | `\rowcolor{gray!25}`, `\cellcolor{gray}`, `\cellcolor{\IScolor}` etc., `\color{white}` |
| timetable row macros | preamble_booklet.tex:108-109, 115-117; main.tex:87-92 | `tbl.longtable`, `tbl.colortbl`, `mark.kernel` | `\tablebreak \eventtype \IS \CT \KL` are row templates; reduction in Bespoke code |
| talk abstract record | preamble_booklet.tex:18-26; main.tex:102-150 | `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.manual-space`, `pg.break` | `\filbreak`, `\large\bfseries` title, `\bfseries\itshape` author, `\textcolor{mygray}` affiliation, `\hfill` tag; `\filbreak` is a plain-TeX page-break command, filed under `pg.break` as a kernel page-flow command |
| poster list entry | preamble_booklet.tex:31-39; main.tex:158-160 | `font.size-commands`, `mark.kernel`, `sp.manual-space`, `pg.break` | `\filbreak`, `\bfseries\large` title, `\\`, `\hspace*{1cm}`, `\textit` |
| spacing after chapter title | main.tex:156 | `sp.manual-space` | `\vspace{-1em}` |
| talk-type badges | preamble_booklet.tex:49-51 | `art.tikz` | ART, see Blockers |
| useful-info text | main.tex:166-171 | `mark.kernel` | `\textbf`, `\texttt` |
| loaded, unused in sample | main.tex:26-28 | `fig.graphicx`, `fig.float`, `cols.multicol` | no `\includegraphics`, `[H]`, `\newfloat` or `multicols` in the body |
| loaded, no effect found | main.tex:19, 24, 30; preamble_booklet.tex:56 | none (considered: `xspace`, `scrhack`, `etoolbox`, `ifthen`) | `\xspace` is never called; `scrhack` patches `float`/`listings`/`nomencl` interplay, none used (effect not read from source); `etoolbox` commands are never called; `ifthen` is used only inside the parity hook (preamble_booklet.tex:61, 65) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newenvironment{abstract}[4]` | preamble_booklet.tex:18-26 | yes | inline per talk: `\filbreak`, `{\large\bfseries title}`, `{\bfseries\itshape author,} \textcolor{mygray}{affiliation} \hfill tag` (`pg.break`, `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.manual-space`); the tag argument is an ART badge |
| `\poster` | preamble_booklet.tex:31-37 | yes | `\filbreak`, `{\bfseries\large title}\\`, `\hspace*{1cm} author, \textit{affiliation}` |
| `\tab` | preamble_booklet.tex:39 | yes | `\hspace*{1cm}` (`sp.manual-space`), optional argument default 1cm |
| `\primarycolor`, `\secondarycolor` | preamble_booklet.tex:12-13 | yes | aliases of myblue and mywhite (`color.xcolor`) |
| `\KLcolor`, `\IScolor`, `\CTcolor` | preamble_booklet.tex:45-47 | yes | xcolor expressions `myorange!45`, `myblue!65`, `white` |
| `\tbg`, `\tfg`, `\tbc` | preamble_booklet.tex:104-106 | yes | aliases `gray`, `white`, `gray!25` |
| `\KLtag`, `\IStag`, `\CTtag` | preamble_booklet.tex:49-51 | no | TikZ circle node badge with filled disc and bold two-letter label; no declarative lib way (`ART/preamble`) |
| every-page parity hook | preamble_booklet.tex:60-69 | no | two `\backgroundsetup` branches chosen by `\isodd{\thepage}`; the `bg.background` parameters are declarative but the dispatch is code (`BESPOKE/preamble`, strict reading) |
| `\mybarpadding` | preamble_booklet.tex:74-75 | yes | length alias for 1.5em (`sp.lengths`) |
| `\chapterlinesformat` redefinition | preamble_booklet.tex:87-98 | no | each branch is `sp.rule` + `sp.manual-space` + `color.xcolor` over KOMA's documented hook, but the odd/even branch is code (`BESPOKE/preamble`, strict reading) |
| `\tablebreak`, `\eventtype` | preamble_booklet.tex:108-109 | yes | expand inline: `\rowcolor{gray!25} time & \multicolumn{4}{c\|}{\bfseries text} \\ \hline`, and the `\cellcolor{gray}\color{white}` variant (`tbl.colortbl`) |
| `\newcolumntype` L, C, R | preamble_booklet.tex:111-113 | yes | array `\newcolumntype` over `m{#1}` with alignment prefix; the one hand-coded piece is `\let\newline\\` inside the prefix, used by the row macros for an in-cell line break |
| `\IS`, `\CT`, `\KL` | preamble_booklet.tex:115-117 | yes | row template `time & \cellcolor{..}TAG & {\bfseries name}\newline affiliation && title \\ \hline`; argument 3 is never used, all calls pass it empty (main.tex:88-92) |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered and not proposed (no printed effect found in the sample): `xspace`, `scrhack`, `etoolbox`, `everypage` (loaded by `background`; its `\AddEverypageHook` takes code, so it fails W2 as a way), `ifthen`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
