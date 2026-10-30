yes

# 0509-poetrytex-book: PoetryTeX Book

- Unverified: read from the source, not compiled.
- Source: Source/0509-poetrytex-book/ (origin: https://latextemplates.com/downloads/poetrytex.zip; licence: LPPL-1.3c-or-later per the manifest and README.md:5; CTAN page for poetrytex says LPPL 1.3)
- Kind: book (a small poetry anthology: title page, dedication, contents with a list of poems, poem groups, poems, annotation sections)
- Lib: v5
- Engine: pdfLaTeX-compatible (README.md:8 states pdfLaTeX; the sample loads `fontenc` T1, `inputenc` utf8, `lmodern`; the CTAN page does not name an engine and the package source was not read)
- Look carried by: preamble (the look is defined by the published package `poetrytex`, loaded and configured at main.tex:7 and main.tex:9-13; the zip holds no zip-local class, style or macro)
- Class origin: tex-distribution-unbundled (kernel `book`, main.tex:1; not in the zip)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex and README.md; `poetrytex.sty` is not bundled, README.md:5, so its source was not read)

## Verdict
The whole zip is a 68-line sample over the kernel `book` class, `geometry`, `lmodern` and the published package `poetrytex` (CTAN, v3.0.1, Sam Whited, LPPL 1.3, in TeX Live and MiKTeX; CTAN page read). It defines no macro, environment, counter or conditional of its own: the five `\renewcommand*` lines (main.tex:9-13) set string fields that belong to the package, and every body construct is a package command or environment. An emitter can print the preamble and the body wrappers from published code alone, so the answer is `yes`. The caveat is that `poetrytex.sty` is not in the zip and was not read, so the layout rules inside it (running heads, spacing, heading looks, the list of poems) are taken on trust as the package's own parameters; it is also a doc-kind way that this lib does not yet hold, proposed below as `poetry.poetrytex`.

## Blockers
none

## Class setting
- Class: `class.book` options: `11pt`, `oneside` (main.tex:1)
- Class-native vocabulary used: only `\maketitle` (main.tex:17), and its fields come from the `poetrytex` string macros, not from `\title`/`\author`/`\date`. The sample uses no `\chapter`, `\frontmatter`, `\mainmatter` or other `book` command.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.book` | 11pt, oneside |
| text size and sides | main.tex:1 | `page.class-options` | `11pt`, `oneside` as class options |
| page geometry | main.tex:6 | `page.geometry` | a5paper, margin=25mm |
| font encoding and input | main.tex:3-4 | `font.fontenc-t1` | fontenc `T1`; inputenc `utf8` |
| text font | main.tex:5 | `font.lmodern` | `lmodern`, no options |
| poetry anthology package | main.tex:7 | `poetry.poetrytex` | load options `poemsintoc`, `numberpoems`, `clearpageafterpoem` |
| title metadata strings | main.tex:9-13 | `poetry.poetrytex` | `\renewcommand*` of `\pttitle`="Small Weather", `\ptsubtitle`="An original field anthology", `\ptauthor`="A. Rowan", `\ptdate`="2026", `\ptdedication`="For the people who notice the sky" |
| title block | main.tex:17 | `poetry.poetrytex` | `\maketitle` reading the `\pt...` fields; the layout is inside the package (not read) |
| dedication page | main.tex:18 | `poetry.poetrytex` | `\makededication[center]`, optional argument `center`, text from `\ptdedication` |
| contents and list of poems | main.tex:19, main.tex:7 | `poetry.poetrytex` | `\maketoc`; `poemsintoc` puts the poems in the contents |
| start of the poem section | main.tex:20 | `poetry.poetrytex` | `\maketop` (no argument; what it prints was not read) |
| group headings | main.tex:22, main.tex:46 | `poetry.poetrytex` | `\poemgroup{First Light}`, `\poemgroup{After Rain}` |
| poems | main.tex:24-31, 33-40, 48-55, 57-62 | `poetry.poetrytex` | `poem` environment `{title}{author}`, optional `[center]` (main.tex:57); `numberpoems` and `clearpageafterpoem` from the package option |
| poem line breaks | main.tex:25-30 (and the other poems) | `sp.manual-space` | kernel `\\` between verse lines (the last line of a poem has none; content of the poem) |
| annotation sections | main.tex:42-44, 64-66 | `poetry.poetrytex` | `annotation` environment `{title}`, body is prose |
| running heads and page numbers | not set in main.tex | `poetry.poetrytex` | whatever the package sets (not read); no `\pagestyle` or `fancyhdr` call in the sample |
| bibliography, index, floats, tables, math, theorems, code | none | none | the sample uses none |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand*{\pttitle}`, `\ptsubtitle`, `\ptauthor`, `\ptdate`, `\ptdedication` | main.tex:9-13 | yes | These redefine string fields the package provides (the sample would not load otherwise); each is one text string, a parameter of `poetry.poetrytex`. |
| zip-local class, style, `\newcommand`, `\def`, counter, conditional | none in the zip | n/a | The zip has no such code. |

## Content-opaque
none (the poems and annotation paragraphs are text; there is no figure, table, picture or drawing)

## Lib changes
- New ways proposed: `poetry.poetrytex` `poetrytex` (CTAN, TeX Live and MiKTeX, LPPL 1.3, v3.0.1, Sam Whited; pdfLaTeX; CTAN page: "aid in the management and formatting of anthologies of poetry and other writings"). W1: on CTAN and in TeX Live, with public documentation. W2: behaviour is chosen by load options (`poemsintoc` `numberpoems` `clearpageafterpoem`), by the string fields `\pttitle` `\ptsubtitle` `\ptauthor` `\ptdate` `\ptdedication`, by the optional argument `center` and by text arguments; no code is edited. W3: it serves any poetry anthology or collection, not one book. W4: one `\usepackage[...]` line, `\renewcommand*` string lines, and body calls `\maketitle` `\makededication[..]` `\maketoc` `\maketop` `\poemgroup{}` and the `poem` and `annotation` environments. It is a doc-kind way beside `songbook.songs`, `play.thalie` and `menu.menucard`; not `quote.verse-pkg` (the `verse` package sets one stanza; this one manages groups, a list of poems, numbering and annotations) and not `quote.kernel`. The full option and command list is open: only what the sample uses is recorded, and `poetrytex.sty` was not read (README.md:5 says it is not bundled).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- README.md:10 says "Compile with `just package poetrytex` from the catalogue root". That is a build helper of the collection the zip came from, not a requirement of the template, and the sample is plain pdfLaTeX; it was not followed and is not recorded as an EXTERNAL blocker.
- No text addressed to an AI was found in the zip.
