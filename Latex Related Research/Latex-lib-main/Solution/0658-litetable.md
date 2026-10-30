yes

# 0658-litetable: LiteTable (colourful course timetable package, with its manuals)

- Unverified: read from the source, not compiled.
- Source: Source/0658-litetable/ (origin: https://mirrors.ctan.org/macros/latex/contrib/litetable.zip; licence: lppl1.3c)
- Kind: calendar (a one-page course timetable; the zh-cn and zh-hk files are the package's own manuals)
- Lib: v5
- Engine: needs XeLaTeX (the zh-cn and zh-hk manuals: `ctex` `fontset = lxgw`, built with `latexmk -xelatex`, build.lua:39-40; the demo sample and the litetable package itself read as pdfLaTeX-compatible, litetable.dtx:153-157, and twemojis states no engine on its CTAN page)
- Look carried by: mixed (demo: the published CTAN package `litetable`, shipped here as litetable.dtx with no .sty, draws the whole look and the sample only sets its keys, litetable-demo.tex:3-35; manuals: class `l3doc` plus a 20-line preamble of aliases, litetable-zh-cn.tex:1-26)
- Class origin: tex-distribution-unbundled (`article` for the demo, `l3doc` for the manuals; neither is in the zip; the CTAN l3kernel page lists "The l3doc class" documentation)
- Main file: litetable-demo.tex (the template's own sample, shown in the manual at litetable-zh-cn.tex:174; the manifest names litetable-zh-cn.tex, a manual; other samples: litetable-zh-cn.tex, litetable-zh-hk.tex, the English manual driver at litetable.dtx:100-130)
- Read: main yes, zip-local classes and styles none present (no .cls or .sty is in the zip; the package source litetable.dtx was read in full, lines 1-934, with litetable.ins and build.lua; the l3doc class source is not in the zip and was not read)

## Verdict
The look is a published CTAN package, `litetable` (title LiteTable 3.9A, LPPL 1.3c, in TeX Live and MiKTeX per ctan.org/pkg/litetable), which this zip is the official release of. Its TikZ and expl3 code (litetable.dtx:626-751, 763-920) is the package's implementation, not artwork in the sample: the sample reaches it through key=value options, lists and one environment, so it is one way, `cal.litetable`, and the TikZ is not `ART`. Everything else is published ways (`article`, `l3doc`, `libertine`, `twemojis`, `ctex`, `pdfpages`, `enumitem`) plus five small preamble macros in the manuals, each reducible by inline expansion. No irreducible code, no EXTERNAL tool for the emitted document, so `yes`. Dependence on the unread l3doc source (environments `function`, `syntax`, `texnote`) is the weakest part: it is class vocabulary, recorded as such.

## Blockers
none

## Class setting
- Class: `class.article` options: `svgnames`, `a4paper` (litetable-demo.tex:1). Class: `class.l3doc` options: `svgnames` (litetable-zh-cn.tex:1; litetable-zh-hk.tex:1; litetable.dtx:101). `svgnames` is forwarded to `xcolor` and is needed because the package itself uses `DarkBlue` (litetable.dtx:637-638) and the demo uses `DarkBlue`, `Purple`, `Crimson` (litetable-demo.tex:22, 30, 33).
- Class-native vocabulary used (`class.article`): none beyond the sample's `\begin{document}` (litetable-demo.tex:8-37).
- Class-native vocabulary used (`class.l3doc`, source not read): `documentation` (litetable-zh-cn.tex:43), `function` (:82), `syntax` (:83), `texnote` (:138), `\DescribeEnv` (:62), `\cs` `\pkg` `\cls` `\env` `\oarg` `\marg` `\meta` (:28, 47, 62-67), `\hologo` (:50), `\IndexPrologue` (:184), `\PrintIndex` (:193), the short verb `|...|` (:59), `\verbatiminput` (:174).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (demo) | litetable-demo.tex:1 | `class.article` | svgnames, a4paper |
| document class (manuals) | litetable-zh-cn.tex:1 | `class.l3doc` | svgnames |
| page size | litetable-demo.tex:1; litetable.dtx:391-398 | `page.class-options` | a4paper; the package reads `\paperwidth` and `\paperheight` and scales the table from them |
| timetable package load | litetable-demo.tex:3; litetable.dtx:357-362, 390 | `cal.litetable` | package option scale=.9 (fp, default 1.0); needs v3.9A (announcement.md:2) |
| timetable weekday header | litetable-demo.tex:10-15; litetable.dtx:405-419 | `cal.litetable` | `\weeklist` keys format=`\bfseries \scshape`, sep=`\textbar`; list `label -> width ratio` x5 (1.05, 1.05, 1.1, .9, .9) |
| timetable time column | litetable-demo.tex:16-21; litetable.dtx:426-448 | `cal.litetable` | `\timelist` keys numformat=`\ttfamily \bfseries`, timeformat=`\ttfamily`; list `start -> end` x12 (hidetime not used) |
| timetable page frame | litetable-demo.tex:22-23, 35; litetable.dtx:455-476 | `cal.litetable` | `litetable` environment: colour key `DarkBlue` (unnamed key = colour, dtx:474-475), sem=`SEM 7`, hline=`dashed`; mandatory title `Course Schedule`; the environment sets `\clearpage \thispagestyle{empty}` itself (dtx:457) |
| course boxes | litetable-demo.tex:24-25, 27, 29-30, 32-33; litetable.dtx:483-522 | `cal.litetable` | `\course[subject, comment, lecture, location, colour]{start}{end}`; ints {4}{5} {8}{8} {10}{11} {3}{5}; colours DarkBlue, Purple, Crimson; default colour teal per manual (litetable-zh-cn.tex:131-132) |
| day advance, footer note | litetable-demo.tex:26, 28, 31, 34; litetable.dtx:529-544 | `cal.litetable` | `\newday` (default 1); `\more{text}` |
| colour names | litetable-demo.tex:1, 22, 30, 33 | `color.xcolor` | class option svgnames; names DarkBlue, Purple, Crimson |
| text font | litetable-demo.tex:5; litetable-zh-cn.tex:3 | `font.libertine` | options osf, mono=false |
| font encoding | litetable-demo.tex:6 | `font.fontenc-t1` | T1 |
| emoji labels | litetable-demo.tex:4, 12-14; litetable-zh-cn.tex:2 | `font.icons` | package twemojis, `\texttwemoji{1f312}` etc. (hex codes are content) |
| font switches in labels | litetable-demo.tex:10, 16, 24, 29, 32; litetable-zh-cn.tex:96, 117 | `mark.kernel` | `\bfseries \scshape`, `\ttfamily`, `\textit`, `\textsc`, `\TeX`, `\LaTeX` |
| CJK and manual fonts | litetable-zh-cn.tex:4 | `lang.cjk` | `ctex` fontset=lxgw, linespread=1.0, autoindent=0pt (LXGW fonts are not shipped: missing asset) |
| title block | litetable-zh-cn.tex:27-37, 41; litetable.dtx:133-147 | `front.maketitle` | `\title` with `\bfseries`, `\author`, `\date`, `\maketitle` |
| title and author notes | litetable-zh-cn.tex:28-35, 36 | `front.thanks` | three `\thanks` with `\url`, `\href`, `\mail` |
| links | litetable-zh-cn.tex:29-33, 52-53 | `meta.hyperref` | `\href`, `\url` (hyperref supplied by the class, not read) |
| cross-reference | litetable-zh-cn.tex:150, 172 | `xref.kernel` | `\label{mwe}`, `\ref{mwe}` |
| headings | litetable-zh-cn.tex:45, 55, 172 | `head.class-native` | `\section{...}` with the `l3doc` look, no override |
| index heading | litetable-zh-cn.tex:184-191 | `head.kernel` | `\part*{索引}` inside `\IndexPrologue` |
| running head marks | litetable-zh-cn.tex:186 | `hf.pagestyle-kernel` | `\markboth{索引}{索引}` (page style comes from the class) |
| contents entry | litetable-zh-cn.tex:187 | `toc.kernel` | `\addcontentsline{toc}{part}{索引}` (no `\tableofcontents` is in the sample) |
| appendix and numerals | litetable-zh-cn.tex:180 | `num.appendix`, `pgnum.pagenumbering` | `\appendix`, `\pagenumbering{Roman}` |
| page break, spacing | litetable-zh-cn.tex:170 | `pg.break`, `sp.linespread` | `\clearpage`, `\linespread{1.25}` |
| included PDFs | litetable-zh-cn.tex:2, 176, 182 | `pg.include-pdf` | `\includepdf{litetable-demo.pdf}`; `\includepdf[pages = 5-13, link]{./litetable.pdf}` (both PDFs are shipped) |
| quote | litetable-zh-cn.tex:58-60, 65-69 | `quote.kernel` | `quote` around usage lines |
| keyval list | litetable-zh-cn.tex:24-25, 72-80, 89-94, 107-115, 130-137 | `list.enumitem` | `\newlist{keyval}{itemize}{10}`, `\setlist[keyval]{leftmargin = 0pt, labelsep = 0pt}` |
| note list | litetable-zh-cn.tex:139-151 | `list.enumitem` | `itemize[leftmargin = 2em]` inside `texnote` |
| verbatim | litetable-zh-cn.tex:59, 95-98, 116-119, 174 | `code.verbatim` | short verb `\|...\|`, `verbatim`, `\verbatiminput` |
| documentation environments | litetable-zh-cn.tex:43, 82-99, 138-152, 62 | `dtx.doc` | `documentation`, `function`, `syntax`, `texnote`, `\DescribeEnv` (the nearest lib way for package-manual machinery; the vocabulary is `class.l3doc`) |
| index | litetable-zh-cn.tex:26, 184-193 | `idx.makeidx` | `\makeindex`, `\IndexPrologue{...}`, `\PrintIndex`; makeindex run (build.lua:85) |
| manual colour | litetable-zh-cn.tex:9, 14, 73 | `color.xcolor` | `\textcolor{red}`, `\textcolor{gray}` |
| inline maths | litetable-zh-cn.tex:140 | `math.kernel` | `$1$` |
| English manual driver | litetable.dtx:100-130, 128 | `dtx.doc` | `\DocInput{\jobname.dtx}` under `class.l3doc`; `implementation` environment (:287), `macrocode` blocks |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `litetable` package (expl3 + TikZ) | litetable.dtx:300-929 | not bespoke: published | CTAN package, LPPL 1.3c (ctan.org/pkg/litetable); the emitter writes `\usepackage[scale=..]{litetable}`, `\weeklist`, `\timelist`, `litetable` env, `\course`, `\newday`, `\more`; it does not copy the code. Only `tikz` is required (litetable.dtx:305) |
| `\mail` | litetable-zh-cn.tex:6 | yes | inline `\href{mailto:addr}{\ttfamily addr}` (`meta.hyperref` + `mark.kernel`) |
| `\key` (expl3, star and comma-list branches) | litetable-zh-cn.tex:7-17 | yes | all calls pass one key, none a comma list (grep of `\key{`); starred: `\textcolor{red}{\ttfamily\bfseries k}`; plain: `{\ttfamily \textcolor{red}{\bfseries k}\:=\:}` in the `\item` label (`color.xcolor`, `mark.kernel`, `sp.manual-space`). The zh files have no group around `\ttfamily` (zh-cn:10-16), the dtx version has one (dtx:110, 115); either is contained by the item label box |
| `\val` | litetable-zh-cn.tex:18 | yes | alias of `\meta` (`\DeclareCommandCopy`), inline `\meta` |
| `\TFF` | litetable-zh-cn.tex:21-22, used at :113 | yes | one use: `\meta{...}` holding `\textup{\textbf{true}\makebox[0pt][r]{\underline{\phantom{\bfseries true}\kern-0.1em}}\textbar}false` (`mark.kernel`, `mark.ulem` for kernel `\underline`, `sp.manual-space`) |
| `\TTF` | litetable-zh-cn.tex:19-20 | yes | defined, never called in any file (grep) |
| `\ExplSyntaxOn` / `\makeatletter` | litetable-zh-cn.tex:5, 23 | yes | wrappers for the macros above; vanish with them |
| same preamble in zh-hk and driver | litetable-zh-hk.tex:5-26; litetable.dtx:104-126 | yes | identical reductions (dtx adds `\group_begin:` at :110) |
| docstrip step | litetable.ins:70-76 | n/a | derives `litetable.sty` and README from the dtx with TeX itself; the emitter uses the installed package instead |
| l3build config | build.lua:12-94 | n/a | build tooling (latexmk, makeindex), not template; the emitted document does not need it |

## Content-opaque
none (the shipped PDFs litetable-demo.pdf and litetable.pdf are included by `pdfpages` as assets; `\texttwemoji` codes and the timetable data lists are content)

## Lib changes
- New ways proposed: `cal.litetable` `litetable` (CTAN, TeX Live, MiKTeX, LPPL 1.3c; Mingyu Xia, Lijun Guo; v3.9A of 2026-02-07; needs `tikz`; pdf): a one-page weekly course timetable; `\usepackage[scale=..]{litetable}`, `\weeklist[format,sep]{label -> ratio, ...}`, `\timelist[numformat,timeformat,hidetime]{start -> end, ...}`, body `litetable[colour,sem,hline]{title}` with `\course[subject,location,lecture,comment,colour]{start}{end}`, `\newday[n]`, `\more{text}`. W1: on CTAN and in TeX Live. W2: scale (fp), colour names, strings, font-switch lists, booleans, integers, a closed line-style name (`solid`/`dashed`), and two data lists. W3: serves any course or lesson timetable, not this document. W4: preamble line plus one body environment with commands. Needs `svgnames` colours on the class when `sem` or `DarkBlue` is used, a two-pass build because of `remember picture` with `current page` (litetable.dtx:460), and takes the whole page (`\clearpage` before and after, dtx:457, 462). Considered `cal.semesterplannerlua` (a weekly timetable, but another package and xe/lua) and `cal.termcal` (term weeks, no timetable grid): kept apart, as the lib does for engine tags and sibling packages (`inv.invoice2`, `inv.simpleinvoice`); the TikZ in the package is produced by the package, as in `cal.chronology`, so not `art.tikz`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
