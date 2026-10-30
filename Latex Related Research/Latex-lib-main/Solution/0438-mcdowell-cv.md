no

# 0438-mcdowell-cv: McDowell CV

- Unverified: read from the source, not compiled.
- Source: Source/0438-mcdowell-cv/ (origin: https://latextemplates.com/downloads/mcdowell-cv.zip, upstream named at main.tex:1 as github:dnl-blkv/mcdowell-cv; licence: MIT, mcdowellcv.cls:1-21)
- Kind: cv
- Lib: v5
- Engine: needs XeLaTeX (`fontspec` loaded unconditionally, mcdowellcv.cls:71; main.tex:3 says xelatex; LuaLaTeX also takes fontspec, not checked)
- Look carried by: zip-local (mcdowellcv.cls sets geometry, font, header block, section and entry looks; main.tex only gives name, address, contacts and entries)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (mcdowellcv.cls, 276 lines; main.tex, 71 lines; no other TeX files)

## Verdict
The look is a zip-local class that is `\LoadClass{article}` plus published packages, and every macro and environment in it reduces to lib ways (reductions below); there is no artwork and no unmapped component. The answer is `no` on one point: the class loads `ifplatform` unconditionally (mcdowellcv.cls:115), the CTAN page for `ifplatform` says it uses `-shell-escape` to find the platform, and its result `\platformname` picks which of two sets of spacing lengths the class uses (mcdowellcv.cls:129). The pilot ruling counts an unconditionally loaded shell-escape package as `EXTERNAL/package`. The `ifplatform` source was not read, and what it does without shell escape is not established. If a reviewer rules that a fallback value is enough, the blocker goes away: the emitter pins one length set and the zip is `yes`.

## Blockers
- `EXTERNAL/package` `ifplatform` needs shell escape to detect the platform, is loaded unconditionally (mcdowellcv.cls:115) and its `\platformname` selects the spacing constants (mcdowellcv.cls:129-169); the CTAN page (ctan.org/pkg/ifplatform) names `-shell-escape`, behaviour without it not read

## Class setting
- Class: `class.article` options: `letterpaper,11pt` (mcdowellcv.cls:32,40,56); `a4paper` selectable (mcdowellcv.cls:44-47), `letterpaper` (mcdowellcv.cls:49-52), `calibri` swaps the font name (mcdowellcv.cls:35-37); the sample passes no option (main.tex:9). The wrapper class `mcdowellcv` is not on CTAN (ctan.org/pkg/mcdowellcv returned 404), and this zip is a modified vendored copy (mcdowellcv.cls:27-31, 61-70), so it is zip-local.
- Class-native vocabulary used: `\name`, `\address`, `\contacts`, `\makeheader`, environments `cvsection{title}` and `cvsubsection[lines]{left}{centre}{right}` (all zip-local, mcdowellcv.cls:178-276; used at main.tex:13-15,19,21,22,54,63); article's `itemize` (main.tex:23).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | mcdowellcv.cls:56; main.tex:9 | `class.article` | letterpaper (default) or a4paper, 11pt; the zip-local wrapper reduces to `\documentclass[letterpaper,11pt]{article}` plus the rows below |
| paper and size options | mcdowellcv.cls:32,40,44-53 | `page.class-options` | `letterpaper` or `a4paper`, `11pt`; `\ifpapersize` only picks one constant (cls:138-142,158-162) |
| page geometry | mcdowellcv.cls:59 | `page.geometry` | left=0.75in, top=0.6in, right=0.75in, bottom=0.6in |
| main font | mcdowellcv.cls:71-87 | `font.fontspec` | `\setmainfont{NimbusRoman}[Path=/usr/share/fonts/opentype/urw-base35/, Extension=.otf, UprightFont=*-Regular, ItalicFont=*-Italic, BoldFont=*-Bold, BoldItalicFont=*-BoldItalic, SmallCapsFeatures={Renderer=Basic}, Ligatures={TeX,NoCommon,NoDiscretionary}]`; `calibri` branch: `\setmainfont[same features]{Calibri}` (cls:85-86); fonts are system files the zip does not ship |
| paragraph spacing | mcdowellcv.cls:90 | `sp.parskip-pkg` | option `parfill` |
| page style | mcdowellcv.cls:99 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no page numbers, no running heads) |
| lists | mcdowellcv.cls:108,111; main.tex:23 | `list.enumitem` | `\setlist{leftmargin=*, noitemsep, topsep=-1\parskip}` |
| list environment | main.tex:23-27,46-49 | `list.kernel` | `itemize` |
| letterspacing and spaced small caps | mcdowellcv.cls:118,120-123,197 | `sp.microtype` | `\usepackage{microtype}`; `\DeclareMicrotypeSet*{smallcapsi}{encoding={OT1,T1,T2A,LY1,OT4,QX,T5,TS1,EU1,EU2}, shape={sc*,si,scit}}` (the set name occurs nowhere else in the zip); `\textls[110]` |
| header block (address, name, contacts) | mcdowellcv.cls:215-222; main.tex:13-15,19 | `tbl.nicematrix` | `tabu`: `\begin{tabu} to 1\textwidth { X[l,m] X[2,c,m] X[r,m] }` holding `address & name & contacts \\`, inside `center` |
| header container | mcdowellcv.cls:216,220 | `sp.ragged` | kernel `center` environment (the `\centering` type) |
| header name styling | mcdowellcv.cls:193-198 | `mark.kernel` | `\textbf{\LARGE\textls[110]{\textsc{name}}}` |
| header name word space | mcdowellcv.cls:196 | `sp.lengths` | `\spaceskip=\namespaceskip` (0.575em or 0.4em, cls:130,150), raw glue parameter inside the table cell |
| header address and contacts size | mcdowellcv.cls:181-183,208-210 | `font.size-commands` | `\small` |
| header line breaks | main.tex:14,15 | `sp.manual-space` | `\linebreak` inside the field strings |
| space after header | mcdowellcv.cls:221 | `sp.manual-space` | `\vspace*{\afterheaderspace}` (1.1pt or 3pt) |
| section heading text | mcdowellcv.cls:231-236; main.tex:21,44,53,62 | `page.adjustwidth` | `adjustwidth{6pt}{6pt}` around the title |
| section heading font | mcdowellcv.cls:235 | `mark.kernel` | `\textsc{\textbf{#1}}` |
| section heading rule | mcdowellcv.cls:238 | `sp.rule` | `\hrule height 0.518pt` (or 0.5pt, cls:155) |
| section heading spacing | mcdowellcv.cls:232,237,239 | `sp.manual-space` | `\vspace*` of 5pt / 2.85pt / -5.8pt (or 4.75 / 3 / -4pt, cls:152,154,156) |
| entry heading row | mcdowellcv.cls:254-257; main.tex:22,30,37,45,54,63 | `tbl.nicematrix` | `tabu`: `\begin{tabu} to 1\textwidth { X[l,p] X[c,p] X[r,p] }`, `\textbf{left} & \textbf{centre} & \textbf{right} \\` |
| entry heading font | mcdowellcv.cls:256 | `mark.kernel` | `\textbf` on each of the three fields |
| entry heading spacing | mcdowellcv.cls:259-266,274 | `sp.manual-space` | after the row by `[lines]`: 1 gives -5.75pt (a4) or -20.25pt (letter), 2 gives -11.75pt, other gives -7.75pt (cls:139-146; second set 159-166); all three fields blank gives 1.25pt (or 3pt); after the entry 2.1pt (or 4pt) |
| entry body indent | mcdowellcv.cls:270,273 | `page.adjustwidth` | `adjustwidth{9pt}{9pt}` around the entry content |
| support: column spec | mcdowellcv.cls:93 | `tbl.tabular` | `array` (comment says needed for bold columns); loaded for the `tabu` tables |
| math | main.tex:11 | `math.amsmath` | `\usepackage{amsmath}` (loaded, no equation in the body) |
| body marks | main.tex:56,57 | `mark.kernel` | `\textbf{project name}` |
| not defined | both files | none | colour, language, hyperref, floats, captions, theorems, contents, bibliography, index, cross-references: no command or package found |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `mcdowellcv` | mcdowellcv.cls:23-276 | yes | `\LoadClass{article}` plus the ways in the component map; nothing redefines kernel internals |
| options `calibri`, `a4paper`, `letterpaper`, `\newif\ifpapersize`, `\def\mainfontface` | mcdowellcv.cls:32-53 | yes | the emitter picks one value of each: paper option for `page.class-options`, font name for `font.fontspec` |
| font branch `\ifx\mainfontface\@nimbusromanmarker` | mcdowellcv.cls:72-87 | yes | emit the branch chosen: the `NimbusRoman` key list or the plain `\setmainfont[..]{name}` |
| `\DeclareMicrotypeSet*{smallcapsi}` | mcdowellcv.cls:120-123 | yes | `sp.microtype` declaration, no later use |
| platform conditional and the `\def` length sets | mcdowellcv.cls:129-169 | yes, by pinning one set; its selector is the blocker | emit the chosen lengths as `\vspace*` and rule values in `sp.manual-space` and `sp.rule`; `\ifthen`, `ifplatform` are helpers with no printed effect |
| `\address` `\name` `\contacts` and `\printaddress` `\printname` `\printcontacts` | mcdowellcv.cls:178-212 | yes | store-and-print macros; expand inline into the header row; `\typeout` lines (cls:194-195) only write to the log and are dropped |
| `\makeheader` | mcdowellcv.cls:215-222 | yes | `center` + `tabu` row + `\vspace*`, as in the map |
| `cvsection` | mcdowellcv.cls:231-240 | yes | the end code is empty; the begin code is `\vspace*`, `adjustwidth`, `\hrule`, `\vspace*`; inline expansion, or one `head.titlesec` style if section nodes are used (not checked) |
| `cvsubsection` with `\newtoggle` x3, `\notblank`, `\ifboolexpr`, `\ifnumcomp` | mcdowellcv.cls:246-275 | yes (a judgement call) | the toggles only test whether three argument strings are blank and the integer `[lines]` is 1, 2 or other; the emitter decides this from the node's fields and writes either the single `\vspace*` or the `tabu` row plus one of three `\vspace*` values, then `\begin{adjustwidth}{9pt}{9pt}`; no layout is computed, the negative `\vspace*` values are fixed lengths the author selects by `[lines]` |

## Content-opaque
none

## Lib changes
- New ways proposed: none (considered: `ifplatform`, `etoolbox`, `ifthen`; helper packages used only by the zip-local conditionals above, with no printed effect, so no component way)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
