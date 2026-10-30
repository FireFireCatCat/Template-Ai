yes

# 0699-songproj: songproj (song lyrics slides for Beamer)

- Unverified: read from the source, not compiled.
- Source: Source/0699-songproj/ (origin: https://mirrors.ctan.org/macros/latex/contrib/songproj.zip; licence: bsd3, 3-clause BSD, README.md:8)
- Kind: presentation
- Lib: v5
- Engine: pdfLaTeX-compatible (the package and the README deck; the manual driver loads `fontspec` and needs XeLaTeX or LuaLaTeX, songproj.dtx:42, Makefile:8)
- Look carried by: mixed (a Beamer deck whose look is the Beamer default; the song structure comes from the published package `songproj`, whose source is songproj.dtx:389-1068; the sample preamble sets nothing, README.md:24-27)
- Class origin: tex-distribution-unbundled
- Main file: README.md:24-55 (the only deck sample, `\documentclass{beamer}`); songproj.dtx (package source, and the manual driver `\documentclass{l3doc}` at songproj.dtx:40-52) (other samples: songproj.dtx:199-226, 247-249, 301-310, 359-367 are verbatim examples in the manual; examples/clementine.txt is plain text for song2tex.py, not LaTeX)
- Read: main yes, zip-local classes and styles all (no `.cls` or `.sty` is shipped; `songproj.sty` is generated from songproj.dtx by songproj.ins:66, and songproj.dtx was read in full, 1071 lines; songproj.pdf is a built manual and was not read)

## Verdict
yes. The zip is the source of a published CTAN package (`songproj` v1.2.0 of 2023-03-29, BSD-3-Clause, in TeX Live, read at ctan.org/pkg/songproj), used under Beamer. Nothing in the deck is defined by the sample: it is `\documentclass{beamer}`, `\usepackage{songproj}` and a `frame` holding a `song` environment (README.md:25-53). The package passes W1 to W4 (below) and is proposed as one doc-kind way, `slide.songproj`; everything it builds on (the `verse` package, Beamer overlays, `em`, `\input`) is already a lib way. No `ART`, no `EXTERNAL`: `song2tex.py` is an optional author-side text-to-markup converter that no `.tex` file calls, so the deck compiles without it and an emitter replaces it. The `\longest` and couplet logic is the package's own implementation, not zip-local bespoke code.

## Blockers
none

## Class setting
- Class: `class.beamer` options: none (README.md:25). Beamer is not in the zip (tex-distribution-unbundled; its source was not read). The manual driver uses `class.l3doc` (songproj.dtx:41; `ctan.org/pkg/l3doc` is a 404, but the `l3kernel` CTAN page lists the l3doc class and l3kernel is in TeX Live; the l3doc source was not read).
- Class-native vocabulary used: `frame` environment (README.md:28), `\frame{...}` (songproj.dtx:248), overlay specifications `<+>` `<1>` `<.>` and `overprint`, `\onslide`, `\visible` (songproj.dtx:562-571, 634, 682), `structureenv` (songproj.dtx:452), `\usecolortheme` and `\setbeamertemplate{navigation symbols}{}` in the manual's advice (songproj.dtx:361-362). For l3doc: `function` `syntax` `arguments` `environment` `macro` environments, `\cs` `\env` `\pkg` `\cls` `\file` `\meta` `\marg` `\oarg` `\DescribeEnv` (songproj.dtx:119, 142-150, 442, 505, 529).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | README.md:25 | `class.beamer` | no options |
| page geometry, header/footer, fonts, colours | README.md:24-55; songproj.dtx:389-1068 (no `geometry`, `\setlength`, `\setbeamer*`, `\usetheme` in the package or the sample) | `class.beamer` | Beamer defaults, nothing set by the sample |
| song-lyrics package load | README.md:26; songproj.dtx:303, 363 | `slide.songproj` | `\usepackage{songproj}`, no options |
| one slide set per song | README.md:28, 53; songproj.dtx:248 | `class.beamer` | one `frame` (or `\frame{}`) around one `song` |
| song container | README.md:29, 52; songproj.dtx:901 | `slide.songproj` | `song{2}[1,2]`: stanzas per slide = 1 or 2 (songproj.dtx:426-427, 902), optional comma list of couplet indexes (songproj.dtx:201, 909); no list means all couplets |
| longest line | README.md:30; songproj.dtx:856 | `slide.songproj` | `\longest{text}`: a string whose width is measured to centre the stanzas, not printed (songproj.dtx:146-149) |
| couplet (verse) | README.md:31-36; songproj.dtx:745 | `slide.songproj` | body lines separated by `\\`; optional verse width as first body token (songproj.dtx:746-748) |
| refrain (chorus) | README.md:37-42; songproj.dtx:703 | `slide.songproj` | same body; stored once and repeated after each couplet by the package (songproj.dtx:174-176, 665-673) |
| intro and final | songproj.dtx:789, 824 (documented 162-187) | `slide.songproj` | optional `intro` (shown on slide 1, songproj.dtx:634, 961) and `final` (shown on the last slide, songproj.dtx:682, 1026) |
| couplet numbering | songproj.dtx:867-868 | `slide.songproj` | `\numbercouplets` (boolean switch inside a song; off by default, songproj.dtx:923) |
| song from a file | songproj.dtx:1048-1057 | `slide.songproj`, `struct.input` | `\inputsong*{file}{stanzas}[list]`; the star is a boolean, `\input{#2}` reads the file (songproj.dtx:1055) |
| stanza layout | songproj.dtx:397, 453, 471, 490, 516, 539 | `quote.verse-pkg` | `verse` environment with optional width `[\g__sp_linewidth_dim]`; `\flagverse{#1.}` prints the couplet number (songproj.dtx:541); `\stanzaskip` is the `verse` package's stanza glue, used but never set by songproj (songproj.dtx:572) |
| overlays across slides | songproj.dtx:562, 571, 634, 646, 682 | `slide.beamer-mode` | `overprint`, `\onslide<+>`, `\visible<1>`, `\visible<.>` |
| refrain emphasis | songproj.dtx:452 | `class.beamer` | `structureenv` around the refrain verse |
| intro and final emphasis | songproj.dtx:489 | `mark.kernel` | `em` environment around the verse |
| stanza spacing | songproj.dtx:572, 637, 973, 1023 | `sp.manual-space` | `\vskip` of `\stanzaskip`, `-\stanzaskip`, `\parsep` (internal to the package) |
| lyric line breaks | README.md:32-35 | `sp.manual-space` | `\\` ends each lyric line |
| suggested colour theme (manual advice only) | songproj.dtx:361 | `slide.beamer-theme` | `\usecolortheme{owl}`; `owl` is a third-party GitHub theme (link songproj.dtx:353), not shipped, W1 not checked; not in the README deck, not counted as a blocker |
| navigation symbols off (manual advice only) | songproj.dtx:362 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` |
| manual driver class | songproj.dtx:41 | `class.l3doc` | no options |
| manual driver font load | songproj.dtx:42 | `font.fontspec` | load only, no `\setmainfont`; makes the manual XeLaTeX/LuaLaTeX only |
| manual driver bookmarks | songproj.dtx:43 | `meta.bookmark` | no options |
| manual doc machinery | songproj.dtx:44-50, 55-92, 379, 1070 | `dtx.doc` | `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges` `\DocInput` `\PrintChanges` `\PrintIndex` `\CheckSum` `\CharacterTable` `\changes` `\GetFileInfo` `\DoNotIndex` `\StopEventually` `\Finale` |
| manual title block | songproj.dtx:95-99 | `front.maketitle`, `front.thanks` | `\title{..\thanks{..}}` `\author` `\maketitle` |
| manual headings | songproj.dtx:100, 111, 113, 118, 290, 312 | `head.kernel` | `\section` `\subsection` `\subsubsection` `\paragraph` |
| manual footnotes | songproj.dtx:105, 123, 129 | `fn.kernel` | `\footnote` |
| manual lists | songproj.dtx:695-700, 876-891 | `list.kernel` | `itemize`, `enumerate` |
| manual code displays | songproj.dtx:199-226, 301-310, 359-367 | `code.verbatim` | `verbatim` environment, `\|..\|` short verb (songproj.dtx:194) |
| manual cross-references | songproj.dtx:154, 189, 245, 253 | `xref.kernel` | `\label` `\pageref` `\ref` |
| manual links | songproj.dtx:353, 375 | `meta.hyperref` | `\href{url}{text}`; the load of `hyperref` is by the class or `bookmark`, not visible in the driver (l3doc not read) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `songproj.sty`: expl3 state (booleans, token lists, sequences) behind `song`, `couplet`, `refrain`, `intro`, `final`, `\longest`, `\numbercouplets`, `\inputsong` | songproj.dtx:405-1067 | not zip-local: published CTAN package (W1), so it is the implementation of the way, written once by the package | the emitter writes `\usepackage{songproj}` and the environments; no code is copied. Fallback if the package were refused: expand per song into `quote.verse-pkg` stanzas inside one `slide.beamer-mode` `overprint` with `\onslide<+>` between stanzas, what songproj.dtx:628-684 does |
| internal environments `__sp_refrain`, `__sp_couplet`, `__sp_special` | songproj.dtx:447-495 | yes | `structureenv`+`verse`; `verse`; `em`+`verse` |
| `song2tex.py` (regex converter from a plain-text song to the markup) | song2tex.py:9-11, 31-104 | outside the template | optional author-side helper, called by no `.tex` file (README.md:60-65); the emitter produces the markup from the document model |
| Makefile and songproj.ins (build the manual and `songproj.sty`) | Makefile:8, 14, 17, 20; songproj.ins:29, 66 | outside the template | docstrip and `xelatex`/`makeindex` for the manual only; not part of a deck |

## Content-opaque
none (the song text is content: README.md:32-48)

## Lib changes
- New ways proposed: `slide.songproj`: `songproj` (CTAN, TeX Live, MiKTeX, BSD-3-Clause; Tanguy Ortolo; v1.2.0 of 2023-03-29; needs the Beamer class and loads `verse`, `expl3`, `xparse`), a Beamer add-on for song-lyric decks; `\usepackage{songproj}` (no options), body `song{n}[list]` holding `intro` `refrain` `couplet` `final` environments, `\longest{line}`, `\numbercouplets`, and `\inputsong[*]{file}{n}[list]`; engine pdf. W1: on CTAN and in TeX Live (ctan.org/pkg/songproj). W2: behaviour is chosen by an integer (stanzas per slide), a comma list of indexes, a string, and a star or switch, never by editing code. W3: it serves any lyric deck, not one document (README.md:13-17). W4: one preamble line plus body wrappers around the lyric lines. Not `songbook.songs` (a different package: a printed chorded songbook with `\beginsong`, no Beamer); not `slide.beamer-mode` (hand-written overlays) nor `quote.verse-pkg` (it is built on both); a sibling of the Beamer add-ons `slide.colourchange` and `slide.hackthefootline`. Content inside the couplets is stored as an argument (xparse `+b`, songproj.dtx:703), so verbatim material cannot sit inside.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
