yes

# 0686-notebeamer: NoteBeamer (slides printed on note pages)

- Unverified: read from the source, not compiled.
- Source: Source/0686-notebeamer/ (origin: https://mirrors.ctan.org/macros/latex/contrib/notebeamer.zip; licence: LPPL 1.3c, LICENSE:4, README.md:44-46)
- Kind: presentation (a slide handout: slide PDF pages on the left of ruled note-paper pages; the manifest hint says presentation, there is no better kind in the list)
- Lib: v5
- Engine: pdfLaTeX-compatible (the manual claims pdfLaTeX, XeLaTeX, ApLaTeX and LuaLaTeX, notebeamer.dtx:152-153; the CTAN page states no engine; the sample uses `libertine`, which runs under pdfLaTeX; nothing here needs a shell or a tool outside TeX)
- Look carried by: preamble (a published CTAN package, `notebeamer`, loaded unchanged in the preamble and driven by `\includebeamer[keys]` calls in the body, over plain `article`; the sample defines no macro of its own)
- Class origin: tex-distribution-unbundled (`article`, not in the zip; the `notebeamer` package is the CTAN release itself, its source is the .dtx)
- Main file: notebeamer-demo.tex (other samples: the documentation driver in notebeamer.dtx:100-130, class `l3doc`, a manual and not a template)
- Read: main yes (25 of 25 lines), zip-local classes and styles none present (no .cls or .sty in the zip; the package source notebeamer.dtx was read in full, 461 lines, with notebeamer.ins, build.lua, README.md and LICENSE up to the licence header)

## Verdict
yes. The sample is `article` plus `libertine`, `geometry` and the CTAN package `notebeamer`; its body is three `\includebeamer` calls, one `\newgeometry` and two `\pagecolor` calls (notebeamer-demo.tex:1-25). Every part maps to a lib way, and the one part with no lib home, the slide-on-note-paper handout, is proposed as `slide.notebeamer`, which passes W1 to W4 (CTAN and TeX Live; key=value options; any slide PDF; one preamble line plus one body command). The sample defines no macros, the package code is the published way and not zip-local, and the lines and header on the note pages are drawn by the package from option values, not by the template author, so there is no `ART`.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (notebeamer-demo.tex:1)
- Class-native vocabulary used: none (no `\maketitle`, `abstract`, sectioning or bibliography in the sample; the body holds only `\newgeometry`, `\pagecolor` and `\includebeamer`, notebeamer-demo.tex:7-23)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | notebeamer-demo.tex:1 | `class.article` | `a4paper` |
| paper size | notebeamer-demo.tex:1 | `page.class-options` | `a4paper` |
| page geometry (load) | notebeamer-demo.tex:3 | `page.geometry` | `\usepackage{geometry}` with no options |
| page margins | notebeamer-demo.tex:7 | `page.geometry` | `\newgeometry{margin = .75in}` right after `\begin{document}`; it sets the text block that `\includebeamer` reads (notebeamer.dtx:306-308) |
| text font | notebeamer-demo.tex:3 | `font.libertine` | `\usepackage{libertine}`, no options (the `osf, mono = false` options at notebeamer.dtx:103 belong to the manual) |
| page background colour | notebeamer-demo.tex:8, 14 | `color.pagecolor` | `\pagecolor{black!80}` for the first call, `\pagecolor{white}` for the next two |
| colour expressions | notebeamer-demo.tex:8, 11 | `color.xcolor` | `black!80` and `white!80` are xcolor mixes; the sample does not load xcolor itself, it arrives through `tikz`, which the package loads (notebeamer.dtx:224; that tikz brings xcolor is inferred, not read here); an emitter should write `\usepackage{xcolor}` |
| handout package (load) | notebeamer-demo.tex:3; notebeamer.dtx:218, 223-224 | `slide.notebeamer` | `\usepackage{notebeamer}`, no package options (the code read declares none); it loads `l3graphics` if missing, `tikz` and `tikzpagenodes`, unconditionally |
| slides per note page | notebeamer-demo.tex:10, 16, 21; notebeamer.dtx:177-178, 256-257 | `slide.notebeamer` | key `nup` (integer): 4, 5, 2 (default 3) |
| slide page selection | notebeamer-demo.tex:10, 16, 21; notebeamer.dtx:179-181, 254-255, 309-317, 436-451 | `slide.notebeamer` | key `pages` (comma list with ranges, `-` alone for all pages): `{2-4, 8-10}`, `1-5`, `-` (default `1`) |
| slide width and empty area | notebeamer-demo.tex:10, 16, 21; notebeamer.dtx:173-174, 262-263 | `slide.notebeamer` | key `ratio` (fp, share of `\textwidth`): .28, .48, .54 (default .5); key `sep` (dim, vertical gap, default `2ex`) is not set in the sample, notebeamer.dtx:175-176, 264-265 |
| ruled note lines | notebeamer-demo.tex:10, 16, 21; notebeamer.dtx:182, 258-259, 396-402 | `slide.notebeamer` | key `lines` (integer): 32 in all three calls; it has no default, so it must be set |
| line numbers | notebeamer-demo.tex:11, 17 (absent at 20-23); notebeamer.dtx:183-184, 259-261, 403-418 | `slide.notebeamer` | key `lineno` (boolean, bare key means true, initial false) |
| note-line colour | notebeamer-demo.tex:11; notebeamer.dtx:171-172, 252-253, 268-269 | `slide.notebeamer` | key `color` given as a bare key `white!80` (an unknown key becomes the colour); default `black` |
| note-page header text | notebeamer-demo.tex:11, 17, 22; notebeamer.dtx:185-186, 266-267, 389-392 | `slide.notebeamer` | keys `lhead = Chapter 1`, `rhead = Page~\thepage` (strings; `\thepage` is the kernel page number printed by the key text, no separate way) |
| slide input file | notebeamer-demo.tex:12, 18, 23; notebeamer.dtx:305, 346-352 | `slide.notebeamer` | mandatory argument of `\includebeamer`: `example-image-a4-numbered.pdf`, `example-image-duck.pdf`, `example-image-a4.pdf`; the keys may stand before or after it (notebeamer.dtx:232-235) |
| page flow and page style | notebeamer.dtx:337, 354, 375, 420 | inside `slide.notebeamer` | the package issues `\clearpage` and `\pagestyle{empty}` itself; the emitter writes neither |

Not in the sample: title block, abstract, contents, headings, lists, quotes, notes, maths, theorems, floats, tables, captions, code, boxes, bibliography, index, cross-references (notebeamer-demo.tex:5-25 holds only the calls above).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| macros defined by the sample | notebeamer-demo.tex:1-25 | n/a | none: the sample defines no `\newcommand`, `\def`, environment or counter |
| `\includebeamer`, key set, `\@@_include_aux:n`, `\@@_empty_note_aux:`, `\@@_range_to_list:nN` (expl3 + TikZ) | notebeamer.dtx:208-456 | n/a, published | this is the code of the CTAN and TeX Live package `notebeamer` (ctan.org/pkg/notebeamer read: v4.6A, 2026-02-07, LPPL 1.3c); the emitter prints `\usepackage{notebeamer}` and `\includebeamer[keys]{file}`, and copies none of it; not zip-local, so not bespoke by W1 |
| docstrip driver `notebeamer.ins` | notebeamer.ins:70-76 | n/a | builds `notebeamer.sty` and `README.md` by TeX itself (docstrip), no outside tool |
| l3build file | build.lua:12-91 | n/a | the author's release and test script (`latexmk -pdf`, build.lua:33); not loaded by any document, not part of the template |
| manual-only macros `\mail`, `\key` (expl3 sequence mapping), `\TTF`, `\TFF`, `\val`, list `keyval`, driver class `l3doc` | notebeamer.dtx:101-126 | out of scope | typeset the package's own manual (the `documentation` environment, notebeamer.dtx:146-201); the sample does not load them; had they been in scope, `\key` (notebeamer.dtx:106-117, expl3 sequence mapping) would be BESPOKE/preamble of the manual driver, but they carry no look of the template |

## Content-opaque
- The slide pages placed on the left of each note page are content: the three included PDFs at notebeamer-demo.tex:12, 18, 23 (named `example-image-*`, which I believe come from the `mwe` package of TeX Live; they are not in the zip, so ship or substitute them). The artwork inside those pages is not template.
- The ruled lines, rules and header nodes are drawn by the package's own TikZ code (notebeamer.dtx:385-419) from the keys above, so they are the way's output, not `art.tikz` written by the template author.

## Lib changes
- New ways proposed: `slide.notebeamer`: `notebeamer` (CTAN, TeX Live, MiKTeX, LPPL 1.3c; Mingyu Xia; v4.6A of 2026-02-07; expl3 over `tikz`, `tikzpagenodes`, `l3graphics`; pdfLaTeX works per the manual, the CTAN page names no engine, so engine `pdf`): prints a slide PDF on note pages, `n` slides on the left of each page and ruled note lines on the right; `\usepackage{notebeamer}` and body `\includebeamer[keys]{file.pdf}[keys]`; keys `color` (also a bare colour name or expression) `ratio` `sep` `nup` `pages` (comma list with ranges, `-` for all) `lines` `lineno` `lhead` `rhead` (`pos` is declared at notebeamer.dtx:250 and not used in the code read). W1: on CTAN and in TeX Live, the zip is the CTAN release (manifest origin, README.md:1). W2: behaviour is chosen by integers, lengths, fp numbers, colours, booleans, strings and page lists. W3: serves any deck of slides on note paper, not one document. W4: one preamble line and one body command per slide file. Not `pg.pgfpages` (n-up of logical pages, no note lines or header), not `pg.include-pdf` (includes pages, its `pagecommand` would need drawing code), not `slide.beamer-mode` (handout mode of the beamer class itself, which takes beamer source and not a slide PDF), not `art.tikz` (the author writes no picture).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
