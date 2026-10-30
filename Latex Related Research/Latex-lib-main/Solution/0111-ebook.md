yes

# 0111-ebook: ebook (page layout and chapter heads for PDF e-books, Steensgaard)

- Unverified: read from the source, not compiled.
- Source: Source/0111-ebook/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ebook.zip; licence: pd, "in the public domain", ebook.sty:24, README:25)
- Kind: book (manifest hint: book; an e-reader page-layout style for book-like documents, no sample document)
- Lib: v2
- Engine: pdfLaTeX-compatible (geometry, graphicx, hyperref, moreverb and kernel commands only, ebook.sty:26-34; PDF output intended, README:13-16)
- Look carried by: preamble (a published style, `\usepackage{ebook}` plus the body command `\ebook`, README:6,9; ebook.sty sets page, fonts, section numbering, page style and chapter heads; no class and no sample in the zip)
- Class origin: ctan (the zip is the CTAN package `ebook` itself, `ebook.sty`; ctan.org/pkg/ebook read: path macros/latex/contrib/ebook, Public Domain, in TeX Live and MiKTeX; it holds no class, and the host class is the user's choice, README:5)
- Main file: none (no .tex in the zip; it holds only ebook.sty and README) (other samples: none)
- Read: main no sample present; zip-local classes and styles all (ebook.sty 92 lines and README 28 lines read in full; no instructions addressed to an AI found in either)

## Verdict
The zip is one small published style, `ebook.sty`, with no sample. Every line of it is a composition of lib ways: `geometry` with a 12cm x 16cm paper and `scale=0.9`, three load-only packages, NFSS default changes, two counters, an empty page style, one short spacing macro (`\pagefill`) and a redefinition of the chapter-head hooks. The chapter-head redefinition is the only part that touches kernel internals; its look reduces to `titlesec` plus `titletoc` (below), so it is not a blocker. No artwork, no external tool. Verdict `yes`, with one caveat: the reduction of the chapter hooks is by reading, at the level of the printed look, and the host class's own `\@chapter` differs from ebook.sty:61-76 in the front-matter counter and two-column branches (invisible here).

## Blockers
none

## Class setting
- Class: `class.book` (assumed host, not fixed by the zip; README:5 leaves `\documentclass{...}` to the user). ebook.sty:61-91 does `\renewcommand` on `\@chapter`, `\@makechapterhead` and `\@makeschapterhead`, which the kernel chapter classes (`book`, `report`) define and `article` does not; a `\renewcommand` of an undefined command is a LaTeX error (stated from LaTeX knowledge, not tested). `class.report` is equally possible. Options: none are set by the package; paper size comes from `geometry` (ebook.sty:26-31), not from a class option.
- Class-native vocabulary used: `\chapter`, `\chapter*`, `\tableofcontents`, `\chaptermark` (ebook.sty:61-76); no sample, so nothing else is known.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | README:5; ebook.sty:61 | `class.book` | host chosen by the user; must define `\@chapter` (see Class setting) |
| page geometry | ebook.sty:26-31; README:21-22 | `page.geometry` | paperwidth=12cm, paperheight=16cm, scale=0.9 (text area 90% of the page, margins derived) |
| graphics | ebook.sty:32 | `fig.graphicx` | `\usepackage{graphicx}`, load-only, no options |
| PDF links and metadata | ebook.sty:33 | `meta.hyperref` | `\usepackage{hyperref}` with default options |
| verbatim extras | ebook.sty:34 | `code.verbatim` | `\usepackage{moreverb}`, load-only; nothing in ebook.sty calls it |
| default family and series | ebook.sty:36-37 | `font.family-default` | `\familydefault`=cmss, `\seriesdefault`=sbc |
| sans, medium weight switches | ebook.sty:38-39; 52-53 | `mark.kernel` | `\sffamily`, `\mdseries` (preamble and again in `\ebook`) |
| body size | ebook.sty:57 | `font.size-commands` | `\Large`, set by `\ebook` at the start of the body |
| section numbering and toc depth | ebook.sty:40-41; 54-55 | `num.secnumdepth` | secnumdepth=0, tocdepth=2 (preamble and in `\ebook`) |
| page style | ebook.sty:42; 56; README:22-23 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no running heads, no page numbers) |
| first ToC page empty | ebook.sty:25 | `toc.kernel`, `hf.pagestyle-kernel` | `\AtBeginDocument{\addtocontents{toc}{\protect\thispagestyle{empty}}}` |
| chapter opener page | ebook.sty:62 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` at each numbered `\chapter` (overrides the host's `plain`) |
| chapter heading look | ebook.sty:77-83 (numbered), 84-91 (starred) | `head.titlesec` | reduction: `\titleformat{\chapter}[block]{\normalfont\raggedright\Huge\bfseries}{}{0pt}{}`, `\titlespacing*{\chapter}{0pt}{0pt}{40pt}`; same look for `\chapter*`; no "Chapter N" line, no number, no top space (the `\vspace*{50\p@}` is commented out, ebook.sty:78, 85) |
| heading format pieces | ebook.sty:79,86-87 (`\parindent\z@`, `\raggedright`, `\normalfont`); 81,89 (`\Huge\bfseries`) | `sp.lengths`, `sp.ragged`, `mark.kernel`, `font.size-commands` | parindent=0pt, `\raggedright`, `\normalfont`, `\Huge`, `\bfseries` (the parameters of the `head.titlesec` row above) |
| no break inside a chapter title | ebook.sty:80,88 | `sp.penalties` | `\interlinepenalty` = `\@M` (10000) inside the heading format |
| space after chapter title | ebook.sty:82,90 | `sp.manual-space` | `\vskip 40pt` after `\par\nobreak` (the after-skip of `\titlespacing*` above) |
| ToC chapter entries without number | ebook.sty:63-70 | `toc.titletoc` | reduction: `\titlecontents{chapter}[0pt]{\addvspace{1em}\bfseries}{}{}{\hfill\contentspage}` (numbered-entry format that does not print `\thecontentslabel`; the host's `\l@chapter` look is the thing to copy) |
| toc entry and marks of a chapter | ebook.sty:66,69,71 | `toc.kernel`, `hf.pagestyle-kernel` | `\addcontentsline{toc}{chapter}{...}`, `\chaptermark{...}`; the same as the host's own `\@chapter` |
| lof/lot spacing at a chapter | ebook.sty:72-73 | `toc.kernel` | `\addtocontents{lof}{\protect\addvspace{10pt}}`, same for `lot`; the same as the host's own `\@chapter` |
| page fill (use instead of `\newpage`) | ebook.sty:45-49; README:14-16 | `sp.manual-space`, `sp.lengths`, `sp.rule`, `pg.break` | `\pagefill[len]` = `\vfill\noindent\rule{len}{len}\newpage\noindent`, default len=0.001mm; `\noindent` mapped to `sp.lengths` as the zero-`\parindent` form for one paragraph |
| body entry macro | ebook.sty:51-58; README:9 | `mark.kernel`, `font.size-commands`, `num.secnumdepth`, `hf.pagestyle-kernel` | `\ebook` = `\sffamily\mdseries`, secnumdepth=0, tocdepth=2, `\pagestyle{empty}`, `\Large` |

Not defined by the zip (no sample, so unused or unknown): title block, abstract, lists, quotes, notes, math, theorems, floats, tables, captions, code, boxes, bibliography, index, cross-references, language.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\pagefill[len]` | ebook.sty:45-49 | yes | `\vfill\noindent\rule{len}{len}\newpage\noindent`: `sp.manual-space` + `sp.lengths` + `sp.rule` + `pg.break`; a body wrapper with one length |
| `\ebook` | ebook.sty:51-58 | yes | five kernel switches and two counters, as in the map; no conditionals |
| `\@chapter` (renewed) | ebook.sty:61-76 | yes | effect: counter stepped but never printed, toc entry without `\numberline`, `\thispagestyle{empty}`, `\chaptermark`, lof/lot `\addvspace`, then the head. The visible parts are `head.titlesec` (heading), `toc.titletoc` (unnumbered entries) and `hf.pagestyle-kernel`; `\chaptermark`, lof/lot and the toc entry are what the host's own `\@chapter` already does. Differences kept out of the look: the host's `\if@mainmatter` test (counter not stepped in front matter) and its `\if@twocolumn` branch |
| `\@makechapterhead` (renewed) | ebook.sty:77-83 | yes | `\titleformat{\chapter}[block]` + `\titlespacing*` as in the map |
| `\@makeschapterhead` (renewed) | ebook.sty:84-91 | yes | the same format for the starred chapter |
| `\AtBeginDocument` toc hook | ebook.sty:25 | yes | one line of kernel commands, as in the map |
Judged by the rubric, none of these is irreducible: there is no output routine, no `\halign`, no expl3 or Lua, and no counter or conditional that drives what is printed (`\ifnum\c@secnumdepth>\m@ne` at ebook.sty:63 reads a counter the package itself sets to 0 at ebook.sty:40 and 54, so it holds unless the author changes secnumdepth later). The package is also published on CTAN, so under a strict W1 reading these macros are not zip-local at all. Residual risk: the reduction is by reading and at the level of the printed look, not byte-exact (not compiled); the page style of a starred chapter opener (host `plain`, ebook.sty:62 applies only to numbered chapters) is a detail that `\thispagestyle` placement can match.

## Content-opaque
none (no sample, no figures or tables)

## Lib changes
- New ways proposed: none (considered: `ebook` itself as a package-level way `\usepackage{ebook}` + `\ebook`; not proposed because every effect already has a home above, and the package has no options, so W2 would be thin)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
