yes

# 0477-simplecd: simplecd (printable CD, DVD and media cover cut-outs)

- Unverified: read from the source, not compiled.
- Source: Source/0477-simplecd/ (origin: https://mirrors.ctan.org/macros/latex/contrib/simplecd.zip; licence: LPPL 1.2, README:3-8; ctan.org/pkg/simplecd read once: v1.4, Daniel Majoros, in TeX Live and MiKTeX)
- Kind: misc (cut-out covers, inlays and labels for CD, DVD, Blu-ray, VHS, cassette, floppy and record holders)
- Lib: v4
- Engine: pdfLaTeX-compatible (kernel `picture` and `\qbezier`, `graphicx`, `fix-cm`, `calc`, `ifthen`: simplecd.dtx:1054-1069; no fontspec, no Lua)
- Look carried by: preamble (the published CTAN package `simplecd` loaded at examples.tex:8 draws every cover; the zip ships its source `simplecd.dtx` and `simplecd.ins`, not a generated `.sty`, and no zip-local class)
- Class origin: tex-distribution-unbundled (`article`, examples.tex:2; the doc driver uses `ltxdoc`, simplecd.dtx:24)
- Main file: examples.tex (other samples: the documentation driver inside simplecd.dtx:23-47, run through `ltxdoc`; examples.pdf and simplecd.pdf are compiled output, not read)
- Read: main yes (61 lines), zip-local classes and styles none present (no `.cls` or `.sty` in the zip; the package source simplecd.dtx read in full, 2675 lines, and simplecd.ins and README read in full)

## Verdict
yes. The sample is `article` + `geometry` + one published package, `simplecd` (CTAN, TeX Live), whose commands each print one cut-out from text arguments. The sample defines no macro, counter or picture of its own (examples.tex:1-61). The cut-out frames (`picture`, `\framebox`, `\qbezier` circles, simplecd.dtx:1308-2670) sit inside the published package, so they are the internals of one doc-kind way, `label.mceinleger`, in the same position as `label.mceinleger` and `card.gcard`; an emitter prints `\usepackage{simplecd}` and one call per cover and copies no zip-local macro logic. The one judgement call is whether in-package `picture` drawing counts as template `ART`; I read it as the way's internals because the package is published, its behaviour is chosen by four options and text arguments, and the sample draws nothing itself.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `10pt`, `oneside` (examples.tex:2)
- Class-native vocabulary used: none (no `\maketitle`, no `abstract`, no sectioning; the body is only simplecd calls, `\newpage`, `\vspace`, `\hspace`). Documentation driver: `class.ltxdoc` with no options (simplecd.dtx:24).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | examples.tex:2 | `class.article` | a4paper, 10pt, oneside |
| paper size and font size | examples.tex:2 | `page.class-options` | a4paper, 10pt, oneside |
| page geometry | examples.tex:6 | `page.geometry` | left=1cm, top=1cm, right=2cm, bottom=1cm (the manual advises small margins so a cover fits A4: simplecd.dtx:133-135, 1042-1043) |
| header/footer | examples.tex:3 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| media cut-outs (the whole look) | examples.tex:8; simplecd.dtx:1054-1273 | `label.mceinleger` | `\usepackage{simplecd}` with no options in the sample; options available `noalign` `nofold` `spiner` `nohcenter` (simplecd.dtx:1074-1110, documented 990-1003) |
| jewel case covers | examples.tex:12, 24, 27 | `label.mceinleger` | `\djewel{page1}{page2}` (dtx:1789); `\covers[back]{front}{spine}` (dtx:1308); `\jewelspine{text}` (dtx:1391) |
| lever-arch sleeve with a layout | examples.tex:29-30 | `label.mceinleger` | `\sleevela[back]{front}` (dtx:1565) holding `\jeweldriverl` with seven strings (dtx:2285; layout `\jeweldriverlempty` dtx:2257) |
| keepcases and inlay | examples.tex:14, 16, 18, 20 | `label.mceinleger` | `\dvd[back]{front}{spine}` (dtx:1636), `\bluray` (1648), `\slimdvd` (1624), `\dvdinlay{text}` (1767) |
| disk sleeves | examples.tex:22, 38 | `label.mceinleger` | `\sleeve{front}` (dtx:1524), `\sleeveLXXX[back]{front}` (1537) |
| disk images | examples.tex:32, 36, 49 | `label.mceinleger` | `\cddvddisk{content}` (dtx:1997), `\LXXXdisk{content}` (2031), `\disk{content}` (1868) |
| small media labels | examples.tex:39, 41, 45, 53, 57, 58, 60 | `label.mceinleger` | `\floppyIIIV{front}{back}` (dtx:1814), `\zipdisk{front}{back}` (1839), `\zipdiskII{c}` (1858), `\vhsspine{c}` (2075), `\vhsfront{c}` (2065), `\cassettecover{c}` (2105), `\cassetteinlay{front}{spine}{back}` (2138) |
| page flow between covers | examples.tex:13, 15, 17, 19, 21, 23, 28, 31, 37 | `pg.break` | `\newpage` |
| spacing and line breaks inside arguments | examples.tex:24, 26, 32, 34, 43, 57 | `sp.manual-space` | `\vspace{0.5cm}` `\vspace{3cm}` `\hspace{7cm}` `\hspace{1cm}` `\\` |
| font sizes inside arguments | examples.tex:12, 14, 36, 53 | `font.size-commands` | `\Large` `\Huge` `\large` `\huge` |
| package-internal loads (not printed by the emitter) | simplecd.dtx:1054, 1069 | `font.exscale` (`fix-cm`), `fig.graphicx` (`graphicx`: `\rotatebox` `\resizebox` `\scalebox` inside the macros) | load-only inside simplecd; `calc` (dtx:1059) and `ifthen` (dtx:1064) are arithmetic and conditional helpers inside macro bodies: considered, no way proposed (nothing to wrap, as the rejected `sp.xspace`) |
| doc driver: class | simplecd.dtx:24 | `class.ltxdoc` | no options |
| doc driver: DocStrip documentation | simplecd.dtx:36-38, 45, 50, 68-72, 74-78, 88, 1048 | `dtx.doc` | `\DocInput`, `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\CheckSum`, `\changes`, `\DoNotIndex`, `\GetFileInfo`, `\StopEventually{\PrintChanges\PrintIndex}`, `macrocode`/`macro` environments, `\DescribeMacro` |
| doc driver: PDF metadata | simplecd.dtx:31-35 | `meta.hyperref` | hyperindex=false, pdftitle={simplecd}, pdfauthor={Daniel Majoros}, pdfsubject, pdfkeywords |
| doc driver: code listings | simplecd.dtx:28, 41-44, 141-145 | `code.listings` | language=[LaTeX]Tex, numbers=left, numberstyle=\tiny, stepnumber=1, numbersep=5pt, gobble=1, float, frame=tb, tabsize=2 |
| doc driver: floats and graphics | simplecd.dtx:26-27, 172-176, 229 | `fig.float`, `fig.graphicx`, `fig.rotating` | `[H]` placement; `\resizebox{0.95\textwidth}{!}`; `\rotatebox{270}`; `\scalebox` |
| doc driver: side-by-side figures | simplecd.dtx:287-297 | `box.minipage`, `cap.kernel` | two `minipage[b]{0.45\textwidth}` each with a `\caption` |
| doc driver: title, abstract, contents | simplecd.dtx:90-105 | `front.maketitle`, `front.thanks`, `abs.kernel`, `toc.kernel` | `\title` with `\thanks`, `\author`, `\maketitle`, `abstract`, `\tableofcontents` |
| doc driver: spacing around the contents | simplecd.dtx:102-106 | `sp.lengths` | `\baselineskip` set to 0.9 of itself, then restored |
| doc driver: headings | simplecd.dtx:108, 119, 128, 151, 153, 1007 | `head.kernel` | `\section` `\subsection` `\subsubsection`, class defaults |
| doc driver: lists | simplecd.dtx:657-663, 992-1003, 1010-1021, 1037-1046 | `list.kernel` | `description`, `itemize` |
| doc driver: cross references | simplecd.dtx:994, 1045 | `xref.kernel` | `\label{opt:noalign}`, `\pageref` |
| doc driver: inline marks | simplecd.dtx:90, 121, 319 | `mark.kernel` | `\textsf`, `\texttt`, `\emph` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| simplecd internals: `\sc@cell`, `\sc@choicebox`, `\sc@doalign`, `\keepcase`, `\sc@sleeve`, layout macros, the `picture`/`\framebox`/`\qbezier` drawing, dimension counters, booleans `sc@fold` `sc@align` `sc@layout` | simplecd.dtx:1085-1289, 1293-1296, 1597-2670 | not bespoke: published package (CTAN, TeX Live) | The code is the implementation of `label.mceinleger`; the emitter never copies it. It prints `\usepackage[opts]{simplecd}` and the calls listed in the component map. |
| `\newlength{\orig}` and `\setlength{\baselineskip}` | simplecd.dtx:102-106 (documentation body, not the sample) | yes | `sp.lengths` |
| `.sty` generated from the `.dtx` | simplecd.ins:15-36 | yes | DocStrip is plain TeX (`\input docstrip.tex`), so the build is not EXTERNAL; a TeX distribution already ships `simplecd.sty` |
| Package defect, not reached by the sample: `\slimdvdimg` and `\dvdimg` use counters `sc@dvdkcheightdraw` and `sc@sdvdkccoverwidthdraw` that are never created | simplecd.dtx:1685-1686, 1697 | n/a | Recorded only. examples.tex calls none of the `*img` macros. |

## Content-opaque
- The text inside every cover argument (examples.tex:12-60).
- `picture` with `\framebox(116,116)` inside a documentation figure, simplecd.dtx:418.
- The `lstlisting` code samples and the cover figures of the manual (simplecd.dtx:141-145, 172-176, 229, and so on).

## Lib changes
- New ways proposed: `label.mceinleger` | `simplecd` (CTAN, TeX Live, MiKTeX, LPPL 1.2; Daniel Majoros, v1.4): printable cut-outs for CD, DVD, Blu-ray, VHS, cassette, floppy, zip and record holders; `\usepackage[noalign,nofold,spiner,nohcenter]{simplecd}` and body calls `\covers[back]{front}{spine}`, `\dvd[back]{front}{spine}`, `\sleeve[back]{front}`, `\cddvddisk{content}`, `\jeweldriverl{..7 strings..}`, with `\keepcase` and `\inlay` taking integer millimetre sizes; engine pdf. W1: on CTAN and in TeX Live (ctan.org/pkg/simplecd), and this zip is the CTAN release. W2: four boolean-style options and text, string or integer arguments; the case sizes are counters fixed inside the package (dtx:1197-1270). W3: it serves a kind of component, a media cut-out, across 25 or more holder types, not one document. W4: preamble `\usepackage` plus a body wrapper around each cover's text. Sibling of `label.flabels` and `label.mceinleger`, a different package; not `ticket.sheet` (many tickets per sheet) and not `card.gcard` (one folded card).
- Considered, not proposed: `calc` and `ifthen` (helpers inside simplecd's own macro bodies).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
