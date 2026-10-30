yes

# 0011-harnon-cv: harnon-cv (one-page CV with a "timeline")

- Unverified: read from the source, not compiled.
- Source: Source/0011-harnon-cv/ (origin: https://mirrors.ctan.org/macros/latex/contrib/harnon-cv.zip; licence: pd)
- Kind: cv
- Lib: v0 (the snapshot read: `_Lib.md`, "Lib v0, seeded before any zip was read")
- Engine: pdfLaTeX-compatible (graphicx is loaded with the `pdftex` driver option, harnon-cv.cls:59; cantarell, framed, hyperref are pdfLaTeX-fine as far as read; the cantarell package itself was not read, see Read)
- Main file: sample.tex (other samples: none; sample.pdf is a binary output, not read)
- Read: main yes (47 of 47 lines), zip-local classes and styles all (harnon-cv.cls, 178 of 178 lines; the only class/style file; README read too)

## Verdict
Yes, resting on one proposed way (`NEW:sp.rule`). The zip is one 178-line class, `\LoadClass{article}` plus published packages plus static `\newcommand`/`\newenvironment` aliases. Every look it defines (a4 / 0.75in margins, empty page style, Cantarell sans, grey section headers, a two-minipage title block between rules, and the timeline of year-cell + leader line + left bar) rewrites as inline body wrappers over lib ways. The `\@maketitle` redefinition (harnon-cv.cls:101-129) is reducible because it only places two minipages and rules, and its `\ifdefempty` tests are emit-time facts (a field is either in the document model or not). The decorative lines (timeline leader, left bar, title rules) are plain rules and a framed left border, not TikZ/picture artwork, so they are not `ART`. Weakest points: the timeline leader uses the TeX primitive `\leaders\vrule` (harnon-cv.cls:153), which `NEW:sp.rule` has to admit under W1; and mdframed reproduces the framed left bar by parameters, not by pixel.

Note on `class.harnon-cv`: the zip is itself a CTAN package, so a `class.harnon-cv` way would pass W1. It is not used here, because that would make every CTAN class zip a trivial `yes` and hide the question the project asks (can generic ways rebuild the look?). The class is decomposed instead.

## Blockers
none

## Class setting
- Class: `class.article` options: a4paper, 11pt (harnon-cv.cls:13, reached through the zip-local `harnon-cv` class, which is reduced away; sample.tex:1 loads `harnon-cv`).
- Class-native vocabulary used (of the zip-local harnon-cv class, all reducible, see Bespoke code): `\author` (redefined to set the name, cls:55; sample.tex:5), `\yournumber`, `\youraddress`, `\yourwebsite`, `\recenthistory` (sample.tex:6-12; `\youremail` and `\yourname` exist, cls:40-43, unused by the sample), `\maketitle` (sample.tex:16), `\addheadertext` (sample.tex:19,41), `\starttimeline`/`\stoptimeline`, `\timelineitem`, `\timelinespacer` (sample.tex:20-38), `\addsubheader` (sample.tex:22,29), `\addtimelinebullet` (sample.tex:23-36), `\addcallout` (sample.tex:45). Defined but not used by the sample: `\adddocumentheader` (cls:77, used inside the title), `\addtimelineheader` (cls:93, used inside `\timelineitem`), `\listitem` (cls:96). `\title` and `\date` are ignored by this class (the redefined `\@maketitle` never prints them).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | harnon-cv.cls:13 | `class.article` | a4paper, 11pt |
| paper and size | harnon-cv.cls:13 | `page.class-options` | a4paper, 11pt |
| page geometry | harnon-cv.cls:16 | `page.geometry` | top=0.75in, bottom=0.75in, left=0.75in, right=0.75in |
| header/footer, page numbers | harnon-cv.cls:19-20 | `hf.pagestyle-kernel` | `\pagestyle{plain}` is set first, then `nopageno` (published, CTAN, David Carlisle; per its CTAN page it gives the empty page style on all pages, page not source-read) wins: emit `\pagestyle{empty}`; single-page sample, no running head |
| fonts: Cantarell as default text | harnon-cv.cls:68 | `font.helvet` | package=cantarell, option=default (see Lib changes, wording note); not shipped in the zip, comes with the TeX distribution |
| fonts: default family | harnon-cv.cls:68 | `font.family-default` | `default` option of cantarell makes it the document default (read from the option name; cantarell source not read) |
| font encoding | harnon-cv.cls:69 | `font.fontenc-t1` | T1 |
| font sizes | harnon-cv.cls:77,80,84,88,92 | `font.size-commands` | `\huge` (document header), `\LARGE` (section header), `\large` (sub header, callout, timeline year) |
| colours | harnon-cv.cls:62-65 | `color.xcolor` | verylightgrey rgb 0.85,0.85,0.85; lightgrey 0.5,0.5,0.5; darkgrey 0.3,0.3,0.3 |
| paragraph indent | harnon-cv.cls:72 | `sp.lengths` | `\parindent`=18pt |
| title block, left cell | harnon-cv.cls:102-109 | `cols.minipage` | minipage 0.5\textwidth, `flushleft` (`sp.ragged`): name `\huge\textsc` (`mark.kernel`), email `\small`, website `\small\url` (`meta.url`), number `\small`; each only if the field exists |
| title block, right cell | harnon-cv.cls:110-114 | `cols.minipage` | minipage 0.5\textwidth, `flushright` (`sp.ragged`), `\hfill\small` address |
| title block rules and gaps | harnon-cv.cls:117-118,122,126,128 | `NEW:sp.rule` | `\rule{\textwidth}{0.2mm}` after the cells and after the statement; `\vspace{0.5cm}` / `{7mm}` / `{-1cm}` via `sp.lengths` |
| personal statement | harnon-cv.cls:121-127; sample.tex:12 | `sp.lengths` | `\noindent` paragraph between the two rules, `\vspace{7mm}` before; omitted when `\recenthistory` is empty |
| section header | harnon-cv.cls:80-81; sample.tex:19,41 | `head.titlesec` | `\titleformat{\section}{\color{darkgrey}\LARGE\noindent}{}{0pt}{}`, `\titlespacing*{\section}{0pt}{1.2cm}{3mm}`, used as `\section*` (unnumbered, not in the contents). Fallback, also reducible: inline `{\vspace{1.2cm}\color{darkgrey}\LARGE\noindent X\par\vspace{3mm}}` |
| sub header | harnon-cv.cls:84-85; sample.tex:22,29 | `head.titlesec` | `\titleformat{\subsection}{\color{darkgrey}\large}{}{0pt}{}` used as `\subsection*`, or inline `{\color{darkgrey}\large X\par}` |
| callout (inline emphasis) | harnon-cv.cls:88-89; sample.tex:45 | `color.xcolor` | inline `{\color{darkgrey}\large ...}` (not bold in the code, though the comment at cls:87 says bold); sizes via `font.size-commands` |
| timeline item, two cells | harnon-cv.cls:148-165 | `cols.minipage` | minipage[t] 0.2\textwidth + `\hspace{-2mm}` + minipage[t] 0.8\textwidth, `\noindent`; `\vspace{0.2cm}` top of the left cell; `\vspace{-1cm}` after each item |
| timeline year cell | harnon-cv.cls:92,152-154 | `sp.ragged` | `center` env: year `\color{lightgrey}\large`, `\quad`, then a verylightgrey fill-rule 1pt thick raised 4pt (`\leaders\vrule height 5pt depth -4pt \hfill`), `\color{black}\null` |
| timeline year leader line | harnon-cv.cls:153 | `NEW:sp.rule` | thickness 1pt, raise 4pt, fills the rest of the line, colour verylightgrey (`color.xcolor`) |
| timeline left bar | harnon-cv.cls:29-32,158-162 | `box.mdframed` | emit `mdframed`: leftline=true, topline=false, bottomline=false, rightline=false, linewidth=1pt, linecolor=verylightgrey, innerleftmargin=10pt, innerrightmargin=0pt, innertopmargin=0pt, innerbottommargin=0pt, skipabove=0pt, skipbelow=0pt (the original is framed with `\FrameCommand` = 1pt vrule + 10pt gap, width reduced by both; `framed`'s own `\FrameCommand` edit is not W2, so mdframed is the declarative form) |
| timeline item padding | harnon-cv.cls:159-161 | `sp.lengths` | `\vspace{2mm}` before and `\vspace{4mm}` after the item content, inside the bar |
| timeline spacer | harnon-cv.cls:168-175 | `cols.minipage` | empty 0.2\textwidth minipage + `\hspace{-2mm}` + 0.8\textwidth minipage with the same bar (`box.mdframed`) around `\vspace{1.5cm}\quad`, then `\vspace{-5mm}`; heights via `sp.lengths` |
| timeline start/stop | harnon-cv.cls:136,139 | `sp.lengths` | `\vspace{0.2cm}` before, `\vspace{0.5cm}` after |
| timeline bullet | harnon-cv.cls:142-143; sample.tex:23-36 | `sp.lengths` | group `{\leftskip=12mm \parindent=-6mm $\bullet$\hspace{2mm} text\par}` (hanging indent, raw lengths) |
| list inside timeline | sample.tex:31-34 | `list.kernel` | `enumerate`, followed by `\par` (sample.tex:34) |
| list in skills | sample.tex:42-46 | `list.kernel` | `itemize`, default settings |
| emphasis, bold | sample.tex:12,24,30,35,36 | `mark.kernel` | `\emph`, `\textbf` |
| links | harnon-cv.cls:179 | `meta.hyperref` | loaded last, no options |
| url command | harnon-cv.cls:106 | `meta.url` | `\url` in the title block (supplied by hyperref here) |
| images loaded, unused | harnon-cv.cls:59 | `fig.graphicx` | `pdftex` driver option; comment says headshot "if desired"; sample has no figure |
| tabular loaded, unused | harnon-cv.cls:35 | `tbl.tabularx` | no options; sample has no table |

Not in the sample and not defined by the class: abstract, contents, theorems, captions, code, bibliography, index, footnotes, cross-references (no entry rows needed).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| field setters `\yourname` `\yournumber` `\youraddress` `\youremail` `\yourwebsite` `\recenthistory`, defaults | harnon-cv.cls:40-52 | yes | `\newcommand`+`\def` data holders; the emitter writes the values straight into the title block |
| `\renewcommand{\author}` to set the name | harnon-cv.cls:55 | yes | alias; the name goes straight into the title block |
| `\@maketitle` redefinition | harnon-cv.cls:101-129 | yes | inline body: two `cols.minipage` (0.5\textwidth each, `sp.ragged`), `\rule` lines, `\vspace`s. The `\ifdefempty` tests (etoolbox) only choose whether a field line prints: the emitter knows which fields exist and prints only those; no counter or output routine. `\maketitle` is not called, so its `\newpage`/`\thispagestyle{plain}` behaviour is not needed. As read, cls:105 has a stray `l` before `\small\@youremail` that would print a literal l when an email is set (the sample sets none); a faithful emitter would print the same text, or drop it |
| `timelinebar` environment | harnon-cv.cls:29-32 | yes | `box.mdframed` left-border-only parameters (see table); it is `framed`'s `leftbar` pattern with a colour |
| `\adddocumentheader`, `sectionheader`/`\addheadertext`, `subheader`/`\addsubheader`, `callout`/`\addcallout`, `timelineheader`/`\addtimelineheader` | harnon-cv.cls:77-93 | yes | `\newcommand`/`\newenvironment` aliases for size + colour + spacing; `head.titlesec` or inline wrappers, `font.size-commands`, `color.xcolor` |
| `\listitem` | harnon-cv.cls:96 | yes | `\item` followed by a darkgrey `\large` run and `\enspace`; unused by the sample |
| `\starttimeline`, `\stoptimeline` | harnon-cv.cls:136,139 | yes | `\vspace` aliases (`sp.lengths`) |
| `timelinebullet`/`\addtimelinebullet` | harnon-cv.cls:142-143 | yes | group with `\leftskip`, `\parindent`, `$\bullet$`, `\hspace` (`sp.lengths`); the trailing `\parindent=18pt` is inside the group, so it has no effect after it |
| `\timelineitem` | harnon-cv.cls:148-165 | yes | static composition: `cols.minipage`, `sp.ragged`, `NEW:sp.rule`, `box.mdframed`, `sp.lengths`; no conditionals or counters |
| `\timelinespacer` | harnon-cv.cls:168-175 | yes | static composition of the same ways |
| `nopageno` after `\pagestyle{plain}` | harnon-cv.cls:19-20 | yes | published package; net effect `\pagestyle{empty}` (`hf.pagestyle-kernel`) |
| `etoolbox` | harnon-cv.cls:23 | yes | used only for `\ifdefempty` in the title; dropped after the emit-time decision |

Known quirks of the source (all reducible, noted for fidelity): `\timelineitem` content sits in a minipage, so page breaks never occur inside an item (sample.tex:36 says so); README documents `\timelineseparator` (README line "The \timelineseparator command") but the class defines `\timelinespacer` (harnon-cv.cls:168); sample.tex:8 gives a URL without a colon (content). README and class contain no text addressed to an AI.

## Content-opaque
none (no TikZ, pgfplots, image or chemistry content in the sample; the timeline lines are plain rules)

## Lib changes
- New ways proposed: `NEW:sp.rule`: kernel `\rule{w}{h}` / `\rule[raise]{w}{h}`, `\hrule`/`\vrule`, `\hrulefill`, and `\leaders` with a rule filling the rest of a line, coloured with xcolor. Engine pdf. W1: `\rule` and `\hrulefill` are LaTeX kernel commands, and the TeX `\leaders` primitive is what `\hrulefill`/`\dotfill` are built on (this is the one wrinkle: the zip writes the primitive directly at harnon-cv.cls:153; if the consolidator will not admit a primitive under W1, the leader line has no way and the verdict here turns `no`). W2: width, height, raise, colour are lengths and colour values, no code edit. W3: serves any divider or separator line (title rules, CV timelines, section dividers) in any template. W4: an emitter prints it inline, between or inside a node's body wrappers. Grep of the lib for rule/leaders/hrule found no home (`box.fancybox` is for framed boxes, `head.titlesec` rules are heading-bound).
- Wording notes, not new ways: (1) `font.helvet` lists `helvet`/`avant`/`tgheros`/`sfmath` only; Cantarell is another sans package and was mapped there (package name as the parameter) because the instruction is to propose only what has no home; if the lib keeps one way per typeface, `font.cantarell` would be its own way, and the consolidator should decide the granularity. (2) `sp.lengths` was used for inline kernel spacing commands (`\vspace`, `\hspace`, `\noindent`, `\quad`, `\leftskip`); its row names only `\parindent`, `\parskip`, `\itemsep`, `\topsep`, so the row may need widening.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
