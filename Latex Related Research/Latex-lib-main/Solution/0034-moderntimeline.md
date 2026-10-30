yes

# 0034-moderntimeline: moderntimeline (timelines for moderncv CV entries, with its ltxdoc manual)

- Unverified: read from the source, not compiled.
- Source: Source/0034-moderntimeline/ (origin: https://mirrors.ctan.org/macros/latex/contrib/moderntimeline.zip; licence: LPPL 1.3, moderntimeline.dtx:7-11)
- Kind: misc (the only document is an ltxdoc package manual; the package it documents is for moderncv CVs, README.md:8-14)
- Lib: v1
- Engine: pdfLaTeX-compatible (ltxdoc, tikz, kvoptions; no fontspec, no Lua)
- Look carried by: mixed (the manual's look is the published class `ltxdoc`; the timeline bars are the published CTAN package `moderntimeline`, whose source is the .dtx itself; the driver preamble adds only `\usepackage` and index switches, moderntimeline.dtx:33-37)
- Class origin: tex-distribution-unbundled (`ltxdoc` is LaTeX base and is not in the zip; `moderntimeline.sty` is the CTAN release, not zip-local)
- Main file: moderntimeline.dtx (the DocStrip `driver` block, lines 32-43, holds `\documentclass` and `\begin{document}`); there is no .tex file (other samples: none; moderntimeline.ins is the DocStrip generator, moderntimeline.pdf is the built manual and was not read)
- Read: main yes (whole .dtx, lines 1-810, and .ins, README), zip-local classes and styles all (no separate .cls/.sty: the package code is the unprefixed lines of the .dtx, 354-801, read in full)

## Verdict
Yes. The zip is the CTAN release of the `moderntimeline` package, so its code is published (W1) and maps to the lib's `cv.timeline`; the manual is typeset by the published `ltxdoc` class with no zip-local macro in the driver or the prose. In the doc run the `macrocode` blocks are printed, not executed, so they are content (code text). The only definition made for the manual is a one-line alias (`\url` as `\texttt`), which reduces to `mark.kernel`. No artwork is drawn by the sample: the TikZ code is the package's own internals behind `cv.timeline`, whose parameters are lengths, colours, strings and booleans.

## Blockers
none

## Class setting
- Class: `class.ltxdoc` options: none (moderntimeline.dtx:33); page size and margins are the class defaults
- Class-native vocabulary used: `\DocInput` (39), `\EnableCrossrefs` (35), `\CodelineIndex` (36), `\RecordChanges` (37), `\PrintChanges` (40), `\PrintIndex` (41), `\CheckSum` (46), `\CharacterTable` (48-62), `\changes` (65-75), `\DoNotIndex` (77), `\GetFileInfo` with `\fileversion` and `\filedate` (80, 83), `\DescribeMacro` (20 uses, first at 122), `\StopEventually` (346), `macro` and `macrocode` environments (371 onward), `\Finale` (809), `|...|` short verbatim, DocStrip guards `%<*package>` `%<*driver>` (23-43, 351-806)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (manual) | moderntimeline.dtx:33 | `class.ltxdoc` | no options; the doc/index/change-history vocabulary above |
| page geometry | moderntimeline.dtx:33 | `class.ltxdoc` | nothing set by the sample (class default text area and margin notes for `\DescribeMacro`) |
| title block | moderntimeline.dtx:81-85 | `front.maketitle` | `\title{The \textsf{moderntimeline} package}`, `\author{Raphaël Pinson \\ \url{...}}`, `\date{\fileversion~from \filedate}`, `\maketitle`; file info read by `\GetFileInfo` from the `\ProvidesFile` line (24) |
| sectioning | moderntimeline.dtx:87, 100, 117, 252, 348 | `head.kernel` | `\section` x3, `\subsection` x2; no renewcommand, no numbering change |
| footnotes | moderntimeline.dtx:96-97 | `fn.kernel` | two `\footnote{\url{...}}` |
| emphasis marks | moderntimeline.dtx:81, 102 | `mark.kernel` | `\textsf`, `\texttt` |
| `\url` alias | moderntimeline.dtx:79 | `mark.kernel` | `\providecommand*{\url}{\texttt}` (alias to `\texttt`) |
| usage examples | moderntimeline.dtx:105-108, 145-147, 160-162, 173-175, 191-193, 210-212, 219-221, 265-270, 283-288, 305-318, 329-332, 340-343 | `code.verbatim` | `verbatim` environment; inline `\|\tlwidth\|` is the doc class's short verbatim |
| macro documentation, index, change history | moderntimeline.dtx:35-41, 65-77, 122-335, 346 | `class.ltxdoc` | class-native; the index and change list need the TeX Live `makeindex` pass (as `idx.makeidx` and `bib.bibtex-bst` do) |
| timeline bars on CV entries (the documented package) | moderntimeline.dtx:27, 355-801 | `cv.timeline` | options `firstyear`, `lastyear`, `marksmo`=0.2ex, `marksyr`=0.4ex (362-366; example 106-109); settings `\tlwidth{0.8ex}` (549), `\tlrunningwidth{0.05ex}` (550), `\tlrunningcolor{gray}` (551), `\tltext{\scriptsize}` (548), `\tlsince{}` (552), `\tlsetnotshadedfraction{0}` (553), `\tldisablemonths` (554), `\tlmaxdates{first}{last}` (560), mark heights `\tlmarkheightyr`/`\tlmarkheightmo` (396-410); entries `\tlcventry` (738), `\tllabelcventry` (772), `\tldatecventry` (718), `\tldatelabelcventry` (698), each with optional colour (default `color1`) |
| host class of the documented usage (not loaded by the driver) | moderntimeline.dtx:102, 703, 723, 743, 778; README.md:8-14 | `class.moderncv` | the package calls moderncv's `\cventry` and `\hintscolumnwidth` and its `color1` theme colour, only inside command bodies (611-801) |
| CV entry commands it wraps | moderntimeline.dtx:703, 723, 743, 778 | `cv.entries` | `\cventry{<bar>}{...}{...}{...}{...}{...}`: the bar is placed in the date column |
| timeline colours | moderntimeline.dtx:551, 268, 306, 330 | `color.xcolor` | named colours `gray` (running line), `color1`, `blue`, `magenta`, `brown` passed as the entry option; xcolor arrives through `tikz` (356) |
| label size | moderntimeline.dtx:422-475, 548 | `font.size-commands` | `\scriptsize` is the default argument of `\tltext`, `\tltextstart[base west]`, `\tltextend[north east]`, `\tltextsingle` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `moderntimeline.sty` source (`\tl@yearfraction`, `\tl@splitlabels`, `\tl@tlcvbar`, the four entry commands) | moderntimeline.dtx:354-801 | not bespoke: published | the CTAN release of the package; loaded as `\usepackage[...]{moderntimeline}`, way `cv.timeline` |
| `\providecommand*{\url}{\texttt}` | moderntimeline.dtx:79 | yes | alias of `\texttt`, `mark.kernel` |
| driver `\ProvidesFile` and DocStrip guards | moderntimeline.dtx:24, 32-43 | yes | the stock ltxdoc driver, `class.ltxdoc` |

Stricter reading, for re-use of this analysis: if the package source in the .dtx were counted as zip-local code instead of the published package, it would be `BESPOKE/package` and irreducible, because it parses `year/month` and `label///label` strings with `\def` delimited macros (570-605, 633-662) and computes bar positions with `\pgfmathsetmacro` and a TikZ `\foreach` (611-627, 738-801). The zip comes from CTAN (manifest url, README.md:5-6), so this analysis does not take that reading.

## Content-opaque
- The `macrocode` listings of the package implementation (moderntimeline.dtx:354-801) are code text printed by the manual, and the verbatim examples listed above are content.
- The TikZ drawing code inside `\tl@tlcvbar` and the entry commands (611-801) is the internals of `cv.timeline`. The driver draws no picture, so no ART arises.
- The `\CharacterTable` and `\CheckSum` lines (46-62) are DocStrip bookkeeping and print nothing.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The driver compiles the manual from the .dtx, so no timeline bar is typeset in it; the bars appear only in a moderncv CV that calls the entry commands. This zip therefore tests `cv.timeline` as a documented package, not as drawn output.
- `moderntimeline.ins` (19-40) only runs DocStrip, a TeX run, to write `moderntimeline.sty` from the `package` guard; it is not an external tool and is not needed when the package comes from TeX Live. The index and change list use `makeindex` from the TeX distribution, not counted as EXTERNAL, as `bib.bibtex-bst` is accepted in the lib.
- `ltxdoc` source (LaTeX base) was not read; the class is published and loaded unchanged.
- No text addressed to an AI was found in the zip.
