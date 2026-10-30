yes

# 0034-moderntimeline: moderntimeline (timeline bars for moderncv CV entries)

- Unverified: read from the source, not compiled.
- Source: Source/0034-moderntimeline/ (origin: https://mirrors.ctan.org/macros/latex/contrib/moderntimeline.zip; licence: lppl1.3)
- Kind: cv
- Lib: v0
- Engine: pdfLaTeX-compatible (tikz, kvoptions, pgfmath; no fontspec, no Lua)
- Main file: moderntimeline.dtx (no CV sample document; the only `\documentclass`..`\begin{document}` is the ltxdoc manual driver at moderntimeline.dtx:33-42; usage examples at moderntimeline.dtx:105-343; package code at 354-801) (other samples: none)
- Read: main yes (all 810 lines of moderntimeline.dtx, plus moderntimeline.ins and README.md), zip-local classes and styles none present (the `.sty` is not shipped, it is generated from the `.dtx` by docstrip, so the `.dtx` package section is the style source). moderntimeline.pdf is a binary build of the `.dtx` manual; not read (no PDF renderer here).

## Verdict
`yes`, with one new way, and with a caveat the consolidator should weigh. This zip is the CTAN source of a package, not a template: there is no CV document to rebuild. The package's whole look (a coloured year-range bar with start and end labels, optional year and month tick marks, a shaded fading end for open-ended jobs, a bullet for single dates) is drawn by TikZ and pgfmath code inside the package, so it would be `ART` plus irreducible code if that code lived only in a zip. It does not: the package is published on CTAN (https://ctan.org/pkg/moderntimeline, LPPL 1.3, topics Diagrams and CV) and every setting is declarative (package options, dimension, colour and string setters, dates and labels as arguments). An emitter writes `\usepackage[...]{moderntimeline}`, setter lines and `\tlcventry` in place of `\cventry`, and copies none of the macro logic. That is a new way `NEW:cv.timeline` passing W1 to W4. The `yes` therefore rests on W1 and is partly tautological (the zip is the way); it says nothing about how far the lib reaches on real templates. Not verified: moderncv supplies `\cventry`, `\hintscolumnwidth` and the colour `color1` that this package uses (moderntimeline.dtx:614, 698, 703); moderncv is not in the zip and was not read.

## Blockers
none

## Class setting
- Class: `class.moderncv` options: none stated; the docs only say the package "is to be used together with the moderncv class" (moderntimeline.dtx:102, 255). The CV style, colour and font options are the author's choice and are not in this zip. moderncv source not read (published, ships with the TeX distribution).
- Class: `class.ltxdoc` for the package manual driver only (moderntimeline.dtx:33), options none. This is documentation machinery, not a template Flouest emits.
- Class-native vocabulary used: moderncv `\cventry` (wrapped by every entry command, moderntimeline.dtx:703, 723, 743, 778), `\hintscolumnwidth` (614-618 and throughout), theme colour `color1` (698, 718, 738, 772). ltxdoc/doc: `\DocInput` (39), `\EnableCrossrefs` (35), `\CodelineIndex` (36), `\RecordChanges` (37), `\PrintChanges` (40), `\PrintIndex` (41), `\changes` (65-75), `\DescribeMacro`, `\DoNotIndex` (77), `\GetFileInfo` (80), `\CheckSum` (46), `\CharacterTable` (48), `\StopEventually` (346), `\Finale` (809), `macro` and `macrocode` environments.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class of a timeline CV | moderntimeline.dtx:102, 255 | `class.moderncv` | no options in this zip; any moderncv style that defines `\hintscolumnwidth` (not verified) |
| CV entry line that carries the timeline | moderntimeline.dtx:703-711, 723-731, 743-765, 778-800 | `cv.entries` | `\cventry{<bar>}{#4..#8}` with five ordinary entry fields (title, employer, city, grade, description); the first field is replaced by the timeline picture |
| timeline package load | moderntimeline.dtx:34, 106-108, 356-366 | `NEW:cv.timeline` | package options `firstyear=1999`, `lastyear=2012`, `marksyr=0.4ex`, `marksmo=0.2ex` (kvoptions string options; option defaults marksmo=0.2ex, marksyr=0.4ex at 364-365) |
| timeline date range | moderntimeline.dtx:183-199, 560-564 | `NEW:cv.timeline` | `\tlmaxdates{1999}{2012}` (or the two options above); the range is mapped to the left column width |
| bar thickness, running line | moderntimeline.dtx:122-133, 373-393, 549-551 | `NEW:cv.timeline` | `\tlwidth{0.8ex}`, `\tlrunningwidth{0.05ex}`, `\tlrunningcolor{gray}` |
| start, end and single date labels | moderntimeline.dtx:135-180, 422-478, 548 | `NEW:cv.timeline` | `\tltextstart[base west]{\scriptsize}`, `\tltextend[north east]{\scriptsize}`, `\tltextsingle{\scriptsize}`, `\tltext{\scriptsize}` (anchor optional, font size macro required) |
| "Since" prefix for open-ended entries | moderntimeline.dtx:205-212, 414-416, 552 | `NEW:cv.timeline` | `\tlsince{Since~}` (default empty) |
| shading of open-ended bar | moderntimeline.dtx:214-221, 485-487, 553, 751-762 | `NEW:cv.timeline` | `\tlsetnotshadedfraction{0.4}` (default 0) |
| month precision | moderntimeline.dtx:224-234, 280-291, 492-505, 554 | `NEW:cv.timeline` | `\tlenablemonths` or `\tldisablemonths` (default); dates written `1999/2`, no leading zero |
| year and month tick marks | moderntimeline.dtx:236-250, 396-410, 510-543, 619-626 | `NEW:cv.timeline` | `\tlenablemarksyr`, `\tlenablemarksmo`, `\tldisablemarksyr`, `\tldisablemarksmo`, `\tlmarkheightyr{0.4ex}`, `\tlmarkheightmo{0.2ex}` |
| range entry with colour | moderntimeline.dtx:259-291, 738-766 | `NEW:cv.timeline` | `\tlcventry[blue]{1999}{2002}{...}` (end `0` means still held, gives the fading end); optional arg is a colour, default `color1` |
| range entry with free label | moderntimeline.dtx:294-320, 772-801 | `NEW:cv.timeline` | `\tllabelcventry[magenta]{2002}{2003}{July--November 2002}{...}`; `///` splits start and end label (dtx:315) |
| single-date entries | moderntimeline.dtx:323-343, 698-733 | `NEW:cv.timeline` | `\tldatecventry[brown]{2011}{...}`, `\tldatelabelcventry[brown]{2011}{Christmas 2011}{...}` |
| bar and tick colours | moderntimeline.dtx:268, 306, 330, 551, 698 | `color.xcolor` | names `blue`, `magenta`, `brown`, `gray`, theme colour `color1` (xcolor is loaded through tikz; tikz source not read, published) |
| manual: title block | moderntimeline.dtx:81-85 | `front.maketitle` | `\title{The \textsf{moderntimeline} package}`, `\author` with `\\` and `\url`, `\date{\fileversion~from \filedate}` |
| manual: sectioning | moderntimeline.dtx:87, 100, 117, 252, 348 | `head.kernel` | `\section`, `\subsection`, ltxdoc default look |
| manual: usage listings | moderntimeline.dtx:105, 145, 160, 173, 191, 210, 219, 265, 283, 305, 314, 329, 340 (13 blocks) | `code.verbatim` | `verbatim` environment, and the `\verb` short form `\|...\|` set by doc/ltxdoc for inline macro names (e.g. 113, 124) |
| manual: footnotes | moderntimeline.dtx:96-97 | `fn.kernel` | `\footnote{\url{...}}` |
| manual: code listing, index, change log | moderntimeline.dtx:36-41, 65-75, 354-801 | `class.ltxdoc` | `macrocode`, `\CodelineIndex`, `\RecordChanges`, `\PrintChanges`, `\PrintIndex`; the index and change log need a makeindex pass, as any `idx.makeidx` use does |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| package internals: `\tl@yearfraction`, `\tl@yearfraction@auxi`, `\tl@splitlabels`, `\tl@splitlabels@auxi`, `\tl@formatstartyear`, `\tl@formatendyear`, `\tl@tlcvbar`, the four entry commands, `\newif\ifstartyear`, `\newif\ifissince` | moderntimeline.dtx:367-368, 570-801 | yes, only because the package is published (W1) | load the published package unchanged and use its declarative commands; none of this logic is copied. If the same code existed only inside a zip it would be irreducible: delimited-argument parsers (570-605, 631-662), pgfmath position arithmetic (563-615, 671, 686), an `\ifissince` conditional that switches the printed bar between `\fill` and `\shade` (751-762, 786-797), `\foreach` tick drawing (619-626) |
| `\providecommand*{\url}{\texttt}` | moderntimeline.dtx:79 | yes | manual-only fallback; `\texttt` (`mark.kernel`) or the `url` package (`meta.url`) |
| docstrip guards and generator (`%<*package>`, `\iffalse`, moderntimeline.ins `\generate`) | moderntimeline.dtx:22-44, 350-352, 805-807; moderntimeline.ins:36 | yes | docstrip runs inside TeX (`docstrip.tex`, kernel distribution) and only produces `moderntimeline.sty`; Flouest loads the published `.sty` and never runs it, so there is no EXTERNAL tool |

## Content-opaque
none for the template. The timeline bars, ticks, bullets and shaded ends are TikZ drawn inside the published package (moderntimeline.dtx:703-710, 743-762), not TikZ the emitter writes. The entry texts in the examples (employers, dates, "Tried Scribus for a short while") are content.

## Lib changes
- New ways proposed: `NEW:cv.timeline` package `moderntimeline` (CTAN, LPPL 1.3, https://ctan.org/pkg/moderntimeline), pdf. Adds a date-range timeline bar to moderncv `\cventry` lines. W1: released on CTAN, documentation in moderntimeline.dtx. W2: package options `firstyear`, `lastyear`, `marksyr`, `marksmo` and setters taking dimensions (`\tlwidth`, `\tlrunningwidth`, `\tlmarkheightyr`), colours (`\tlrunningcolor`, entry optional arg), strings (`\tlsince`), a fraction (`\tlsetnotshadedfraction`), font-size macros and anchors (`\tltext*`), booleans as enable/disable pairs; no code is edited. W3: serves one kind of component, a CV timeline, in any moderncv CV, not one document. W4: preamble `\usepackage[...]{moderntimeline}` plus setter lines, body wrapper `\tlcventry`/`\tllabelcventry`/`\tldatecventry`/`\tldatelabelcventry` replacing `\cventry` with extra leading date, colour and label arguments. Scope note: it depends on `class.moderncv` (and `cv.entries`); not usable under other CV classes.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
