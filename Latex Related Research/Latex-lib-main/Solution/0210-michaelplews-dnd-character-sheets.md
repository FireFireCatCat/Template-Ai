yes

# 0210-michaelplews-dnd-character-sheets: hand-laid D&D character sheet (main.tex) with dungeonsheets data files

- Unverified: read from the source, not compiled.
- Source: Source/0210-michaelplews-dnd-character-sheets/ (origin: https://codeload.github.com/michaelplews/DnD-character-sheets/zip/refs/heads/master; licence: not established)
- Kind: misc (a one-bard D&D character sheet; manifest hint `misc`)
- Lib: v2
- Engine: pdfLaTeX-compatible (the file loads no fontspec, unicode-math, Lua or shell-escape package)
- Look carried by: preamble (main.tex lines 1 to 17 load packages; the whole page is hand-laid `tabular`s in the body; no zip-local class or style exists)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip)
- Main file: main.tex (other samples: none; the four `*.py` files are dungeonsheets data, not LaTeX)
- Read: main yes (180 of 180 lines), zip-local classes and styles none present

## Verdict
Yes, for the one LaTeX sample, `main.tex`. It is kernel `article` in two columns plus `geometry`, `array` and glyph packages. The body is eleven `tabular`s, `\rule` blanks, `\vspace` gaps and font-size and font-shape switches. There is no `\newcommand`, `\def`, environment, counter or zip-local file (grep of main.tex finds only `\usepackage` and `\documentclass` among definition-type commands, main.tex:1-17), no artwork, and no call to a tool outside TeX (no shell escape, no external-tool package). The other half of the repository (four dungeonsheets `.py` files and their four PDFs) is not LaTeX and is not loaded by the sample; it is recorded under Content-opaque, not as a blocker (judgement call, see Notes). Several loaded packages are never called in the body (inert loads); they are listed so nothing is hidden.

## Blockers
none

## Class setting
- Class: `class.article` options: `twocolumn` (main.tex:1)
- Class-native vocabulary used: none of article's front-matter or sectioning commands. The sample has no `\title`/`\maketitle`, no `\section`, no `abstract`; it uses only the old font switch `\sc` (main.tex:83, 132, 145, 153, 155, 166-167), which article defines in its compatibility font commands (class source not read, published class).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | option `twocolumn` |
| columns | main.tex:1 | `cols.twocolumn-option` | class option `twocolumn` (the sheet flows into a second column by overflow; `\vspace{40pt}` at main.tex:110 is a hand-tuned gap placed before the Weapons block, not a column break) |
| columns (inert load) | main.tex:2, 20 | `cols.multicol` | `\usepackage{multicol}` loaded; the only `multicols` use is commented out at main.tex:20 |
| page geometry | main.tex:4 | `page.geometry` | `letterpaper`, `margin=.75in` |
| page numbers off | main.tex:21 | `pgnum.pagenumbering` | `\pagenumbering{gobble}` (style name `gobble` resolves to kernel `\@gobble`, so no number prints); `hf.pagestyle-kernel` `\pagestyle{empty}` is the documented alternative, not asserted identical |
| header/footer | none set | none | no `\pagestyle`, no fancyhdr; article default only |
| fonts: body and math | main.tex:16 | none (kernel default) | `lmodern` is commented out, Computer Modern default stays |
| font sizes | main.tex:22, 38, 41, 52, 62, 71, 89, 101, 112, 126, 150, 160 | `font.size-commands` | `\huge` (sheet name, main.tex:22), `\Large` (block titles and the inspiration glyph, main.tex:38) |
| block titles and emphasis | main.tex:41, 52, 62, 71, 89, 101, 112, 126, 150, 160 | `mark.kernel` | `\textit` inside `\Large`; `\textbf` (main.tex:28, 31, 83, 115, 131 and others); old `\sc` small caps (main.tex:83, 132, 153, 166) |
| manual spacing | main.tex:24, 37, 39, 50, 60, 69, 86, 99, 110, 124, 126, 148, 158 | `sp.manual-space` | `\vspace{8pt,5pt,12pt,40pt}`, `\\[2pt]`, `\\[5pt]` (main.tex:44-46), `\hspace{5em}` (main.tex:126), `\noindent` throughout |
| blank fill-in lines and struts | main.tex:31, 38, 45, 47, 66, 74-83, 92-96, 104-106, 129, 142, 163, 169 | `sp.rule` | `\rule{<len>}{.2pt}` (underline blanks), `\rule{<len>}{0pt}` (invisible indent strut, e.g. main.tex:38, 129) |
| ability and stat tables | main.tex:26-37 | `tbl.tabular` | `tabular` `{\|c\|c\|c\|c\|c\|c\|\|\|\|c\|}`, `\hline`, `\hline\hline`, `\textbf` cells |
| skills table | main.tex:53-59 | `tbl.tabular` | `{\|llllll\|}` |
| text-block tables (Health, Proficiencies, Weapons, Spells, Cantrips, Special) | main.tex:42, 63, 113, 127, 151, 161 | `tbl.tabular` | `{\|m{3.1in}\|}` (the `m` column type comes from `array`, loaded at main.tex:17), `\hline` between rows, blank row from `\hline\\` (main.tex:141, 168) |
| two-column blank tables (Equipment, Treasure, Songs Learned) | main.tex:72, 90, 102 | `tbl.tabular` | `{\|ll\|}`, `\hline&\\` header gap |
| tabular support package | main.tex:17 | `tbl.tabular` | `array` |
| check boxes, dice and rule icons | main.tex:23, 38, 44, 46, 115, 117, 119, 126, 165 | `font.icons` | `pifont` `\ding{114}` (box glyph), `\ding{55}`, `\ding{62}`; load at main.tex:11 |
| music notes glyph | main.tex:23 | `font.icons` | `wasysym` `\twonotes`; load at main.tex:10 and 14 |
| check mark glyph | main.tex:46 | `font.icons` | `\checkmark` (provided by amssymb and MnSymbol; which one wins depends on load order, not compiled here) |
| inert symbol packages | main.tex:7, 12, 14, 15 | `font.icons` | `stmaryrd`, `marvosym`, `MnSymbol`, `fourier-orns`: no command of marvosym, stmaryrd or fourier-orns is in the body; the package is the parameter (lib line). MnSymbol also redefines standard math symbols, so it may change `\leq`/`\vert` glyphs (main.tex:23, 136) |
| math symbol fonts | main.tex:6, 22, 23 | `math.amssymb` | `amsfonts`, `amssymb`; `\mathfrak`, `\mathcal` in the sheet name |
| amsmath (inert load) | main.tex:6 | `math.amsmath` | `\usepackage{amsmath}`, no amsmath environment used |
| inline math | main.tex:22, 23, 126, 136, 139, 140, 153 | `math.kernel` | `$...$`, superscripts `$^1$`, `$^2$`, `$^3$`, `$\leq$`, `$>$`, `$\vert$` |
| hand-made bullets | main.tex:166-167 | `font.fontenc-t1` | `\textbullet` kernel text symbol in table cells (a text-symbol command, not a list environment; nearest lib home is the text-symbol family of `font.fontenc-t1`) |
| spacing package (inert load) | main.tex:8 | `sp.setspace` | `\usepackage{setspace}`, no `\setstretch`, `\onehalfspacing` or `spacing` in the body |
| list package (inert load) | main.tex:9 | `list.enumitem` | `\usepackage{enumitem}`, no list environment used at all in the body |
| linguistics packages (inert loads) | main.tex:3, 13 | `art.content-package` | `covington` (CTAN, linguistics: example numbering, glosses), `qtree` (CTAN, linguistics trees); nothing of either is called in the body, so no artwork and no template identity |
| page-layout package (inert load) | main.tex:5 | none; considered: pgfpages | `pgfpages` is loaded but no `\pgfpagesuselayout` or any pgfpages command appears in the file, so no layout is stated; no way proposed for a load that states nothing |
| front matter, abstract, headings, contents, floats, captions, theorems, code, boxes, bibliography, index, cross-references, notes | none | none | not present in the sample (no `\section`, `figure`, `\caption`, `\footnote`, `\label`, `thebibliography`) |
| language, metadata | none | none | no `babel`, no `hyperref` |

## Bespoke code
none. main.tex defines nothing: no `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, `\newcounter`, no `\if`, no `\makeatletter`, no `\input` or `\include` (grep, main.tex whole file). No `.cls`, `.sty`, `.def`, `.cfg`, `.clo`, `.bst` or `.dtx` file is in the zip. The one non-obvious kernel use is `\pagenumbering{gobble}` (main.tex:21), a string parameter of a kernel command, covered by `pgnum.pagenumbering`.

## Content-opaque
- The four dungeonsheets inputs `gunnloda.py`, `inara.py`, `io.py`, `ralvira.py` (each a list of Python assignments such as `name`, `level`, `strength`, `spells_prepared`, e.g. gunnloda.py:8-27, io.py:1-11, ralvira.py:11-22) and the four PDFs `gunnloda.pdf`, `inara.pdf`, `io.pdf`, `ralvira.pdf`. README.md:10-18 says they are built with the external `makesheets` tool of the `dungeonsheets` Python package. The PDFs' Creator metadata reads Adobe InDesign CS6 (bytes of each PDF, grep), so they are not TeX output. The tool's own templates are not in the zip. Nothing here is loaded by main.tex, and nothing in it can be written as LaTeX preamble or body wrappers; it is outside the sample.
- The sheet's text (character name, stats, spell and weapon descriptions, main.tex:22-174) is content.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Judgement calls a reviewer may want to check: (1) the `.py`/PDF half is treated as out of scope because the rubric scopes recovery to the sample and the files it loads (Rubric, "Scope"), and main.tex neither loads nor calls them; if it were counted, the zip would be `EXTERNAL/body` (a Python tool feeding values) and the verdict would flip to `no`. (2) Inert package loads are mapped to the nearest lib way, or to none when nothing is stated (`pgfpages`); none of them is a component the sample uses.
- `covington` was checked once on ctan.org/pkg/covington: it is on CTAN and in TeX Live (linguistics: example numbering, glosses, accents). Whether loading it alters layout was not established; the package source is not in the zip.
- Load order `\usepackage{MnSymbol,wasysym}` after `amssymb` and `wasysym` (main.tex:6, 10, 14) loads wasysym twice and combines several symbol-font packages; whether this raises warnings or clashes was not tested (nothing compiled). The README (README.md:6-8) says the sheet was copied from a Reddit post and "Looking to turn this into a class file": no class exists yet.
- No text addressed to an AI was found in any file.
