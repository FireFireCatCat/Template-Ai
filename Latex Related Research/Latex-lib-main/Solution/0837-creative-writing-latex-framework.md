yes

# 0837-creative-writing-latex-framework: Creative Writing LaTeX Framework

- Unverified: read from the source, not compiled.
- Source: Source/0837-creative-writing-latex-framework/ (origin: https://latextemplates.com/downloads/creative-writing-latex-framework.zip; licence: "Free to use for creative projects" per the manifest and README.md:265, a non-standard permission, commercial terms not stated)
- Kind: book
- Lib: v6
- Engine: pdfLaTeX-compatible
- Look carried by: mixed (the published `memoir` class supplies chapter style, page style `ruled`, title, front/main matter; the preamble-loaded `Commands/*.tex` add the page-size presets, the drop-cap set-up and the narrative macros)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: Chapters/chapter1.tex, a `subfiles` sub-file; Chapters/Parts/Edited/ch01_part01.tex and Chapters/Parts/Original/ch01_part01.tex, scene bodies of the same shape)
- Read: main yes, zip-local classes and styles none present (no .cls or .sty in the zip; all 6 `Commands/*.tex`, 3 `Author/*.tex`, `Chapters/**` and README.md read in full; `Context/character-profile-template-details.md` is a writing-aid note, not LaTeX, read in part: first 40 of 194 lines, plus a search for text addressed to an AI, none found)

## Verdict
yes. The class is the published `memoir`, not bundled (its source was not read), and every zip-local construct is a `.tex` file loaded in the preamble that reduces to lib ways: page-size presets are `page.memoir-layout` calls, the drop cap is `sp.lettrine` with hooks, the dialogue, thought, scene-break and sound-effect macros are aliases of kernel spacing, centring and font commands. The two pieces of macro logic (first-letter split with `xstring`, the edited/original file chooser with `\IfFileExists`) act on content or on which file is read, so an emitter resolves them before writing LaTeX. There is no artwork, no external tool, and no way outside the lib.

## Blockers
none

## Class setting
- Class: `class.memoir` options: `11pt` (main.tex:11)
- Class-native vocabulary used: `\setstocksize` `\settrimmedsize` `\setlrmarginsandblock` `\setulmarginsandblock` `\checkandfixthelayout` (Commands/format-presets.tex:15-18, 53), `\OnehalfSpacing` (main.tex:52), `\pagestyle{ruled}` (main.tex:55), `\chapterstyle{default}` (main.tex:58), `\frontmatter` (main.tex:81), `\maketitle` (main.tex:82), `\mainmatter` (main.tex:88), `\chapter` and `\chapter*` (Commands/chapter_styling.tex:37; Author/frontmatter.tex:19), `\tableofcontents` (Author/frontmatter.tex:34), `\addcontentsline` (Author/frontmatter.tex:20).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:11 | `class.memoir` | `11pt`; class not in the zip, ships with the TeX distribution |
| point size | main.tex:11 | `page.class-options` | `11pt` |
| page size, trim, margins | Commands/format-presets.tex:9-54; main.tex:49; Author/book-settings.tex:37 | `page.memoir-layout` | chosen preset `a5novel` (default, :11,14-19): `\setstocksize{210mm}{148mm}`, `\settrimmedsize{210mm}{148mm}{*}`, `\setlrmarginsandblock{20mm}{15mm}{*}`, `\setulmarginsandblock{20mm}{25mm}{*}`, then `\checkandfixthelayout` (:53). Other presets in the same file: `a4paper` 297mm x 210mm, margins 25mm (:22-27); `usletter` 11in x 8.5in, 1in (:30-35); `6x9book` 9in x 6in, lr 0.75in/0.5in, ul 0.75in/0.75in (:38-43); `5x8book` 8in x 5in, lr 0.65in/0.5in, ul 0.65in/0.75in (:46-51) |
| input encoding, font encoding | main.tex:17-18 | `font.fontenc-t1` | `inputenc` option `utf8`; `fontenc` option `T1` |
| text face | main.tex:19 | `font.lmodern` | load-only |
| line spacing | main.tex:52 | `sp.setspace` | memoir's built-in `\OnehalfSpacing` (memoir's counterpart of `\onehalfspacing`; same reading as in 0201 and 0420) |
| running heads and page style | main.tex:55 | `hf.class-native` | kernel command `\pagestyle` with memoir's predefined style name `ruled`; its look is memoir's and was not read (considered `hf.memoir-pagestyle`: no `\makepagestyle` is used) |
| chapter heading look | main.tex:58 | `head.memoir-style` | `\chapterstyle{default}` |
| chapter heading | Chapters/chapter1.tex:4; Commands/chapter_styling.tex:37 | `head.kernel` | `\chapter{Chapter name here}` inside `\baseChapter` |
| title block | main.tex:71-73, 82; Author/book-settings.tex:10, 13, 16 | `front.maketitle` | `\title{\textbf{<title>}}`, `\author`, `\date{}` (empty string, so no date), memoir's `\maketitle` in front matter; title and author values are in `\def` stores |
| front and main matter | main.tex:81, 88 | `class.memoir` | `\frontmatter` before the title, `\mainmatter` before the chapters (class vocabulary) |
| unnumbered front chapter | Author/frontmatter.tex:19-20 | `head.kernel`, `toc.kernel` | `\chapter*{Characters}` then `\addcontentsline{toc}{chapter}{Characters}` |
| contents | Author/frontmatter.tex:34 | `toc.kernel` | `\tableofcontents` |
| drop cap | Commands/chapter_styling.tex:2, 13-17, 36-41; Chapters/Parts/Edited/ch01_part01.tex:1 | `sp.lettrine` | `\lettrine{<first letter>}{}` followed by the rest of the sentence; counter `DefaultLines` set to 2 (chapter_styling.tex:38); hooks `\LettrineFontHook` and `\LettrineTextFont` redefined (:39-40) |
| drop-cap face | Commands/chapter_styling.tex:39-40 | `font.nfss`, `mark.kernel`, `color.xcolor` | `\fontfamily{pcr}` (Courier family), `\bfseries`, `\color{black}`; text after the cap `\normalfont` |
| dialogue line | Commands/system.tex:8-20 | `sp.lengths`, `mark.kernel`, `sp.manual-space` | `\par\noindent\hangindent=2em\hangafter=0`, speaker in `\textbf`, optional `\textsuperscript{\textit{[type]}}`, `:\space`, text, `\par` |
| inner-thought line | Commands/system.tex:27-31 | `sp.lengths`, `mark.kernel` | `\par\noindent\hangindent=2em\hangafter=0`, `\textit{(<name> thinks: <text>)}`, `\par` |
| scene break | Commands/additional_commands.tex:2-4 | `sp.manual-space`, `sp.ragged` | `\par\bigskip\centerline{* * *}\bigskip\par` |
| sound effect block | Commands/additional_commands.tex:7-9 | `sp.ragged`, `mark.kernel`, `font.size-commands` | `\par\centerline{\textbf{\large <text>}}\par` |
| inline sound effect | Commands/additional_commands.tex:23-27; Chapters/Parts/Edited/ch01_part01.tex:8 | `sp.manual-space`, `pg.break`, `mark.kernel`, `font.size-commands`, `meta.hyperref` | `\nobreak\hspace{0.15em}\mbox{\textbf{\normalsize <text>}}\nobreak\hspace{0.15em}` inside `\texorpdfstring{..}{<text>}` (`\nobreak` filed under `pg.break` as in 0046) |
| PDF page layout | main.tex:35-39 | `meta.hyperref` | `pdfpagelayout=TwoPageRight`, `pdfpagemode=UseNone` |
| colour package | main.tex:42 | `color.xcolor` | load-only; `\color{black}` used in the drop-cap hook |
| graphics package | main.tex:32 | `fig.graphicx` | load-only; the sample has no figure |
| PDF page inclusion | main.tex:33 | `pg.include-pdf` | load-only; no `\includepdf` call anywhere |
| epigraph package | main.tex:34 | `quote.epigraph` | load-only; no `\epigraph` call |
| box packages | main.tex:43-45 | `box.tcolorbox`, `box.mdframed` | `tcolorbox` with option `most` and `\tcbuselibrary{skins}`; `mdframed` load-only; no box in the sample |
| multi-file structure | main.tex:28; Author/chapters.tex:10; Chapters/chapter1.tex:1-2, 9 | `pg.standalone-pkg` | `subfiles` package (a sibling of `standalone`, folded into this way in the v2 log): `\subfile{Chapters/chapter1.tex}` and `\documentclass[../main.tex]{subfiles}` in the sub-file |
| file inclusion | main.tex:14, 29, 48, 61, 85, 91; Commands/preamble.tex:1-4; Commands/system.tex:44-52 | `struct.input` | `\input{path}`; `import` loaded (main.tex:29), `\import` never called |

Not defined or used by the sample, so no row: abstract, lists, quotes, footnotes, margin notes, maths, theorems, floats, tables, captions, code, bibliography, index, cross-references, language, backgrounds.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\applyPageFormat` with `\pageFormat` and the `\ifthenelse{\equal{..}}` chain | Commands/format-presets.tex:9-54; main.tex:49; Author/book-settings.tex:37 | yes | five branches, each only memoir layout calls (`page.memoir-layout`); the emitter writes the selected branch (`a5novel` here) and `\checkandfixthelayout`; the default test at :11 only supplies `a5novel` |
| `\bookTitle` `\bookAuthor` `\bookDate` `\chapterVersion` `\pageFormat` | Author/book-settings.tex:10, 13, 16, 24, 37 | yes | `\def` data stores; the emitter prints the values into `\title` `\author` `\date` and the layout choice |
| `\say` | Commands/system.tex:8-20 | yes | alias with an optional argument; the `\IfValueT` and `\if\relax\detokenize` test only decides whether the bracket text is printed, known at emit time; expansion in the Component map |
| `\thought` | Commands/system.tex:27-31 | yes | alias of kernel paragraph, hanging-indent and font commands |
| `\lineBreak` (unused) | Commands/system.tex:37 | yes | `\par\medskip` (`sp.manual-space`) |
| `\ifuseedited`, `\useEditedVersions`, `\useOriginalVersions`, `\inputscene`, the version `\ifthenelse` | main.tex:64-68; Commands/system.tex:40-61 | yes | chooses which content file is read (`\IfFileExists`, edited then original); no typesetting behaviour; the emitter resolves the choice and writes `\input{Chapters/Parts/Edited/ch01_part01.tex}` (`struct.input`). Weak point: this is a conditional, kept reducible only because it selects content |
| `\chapterSentence` | Commands/chapter_styling.tex:13-17 | yes | `xstring` `\StrLeft` and `\StrGobbleLeft` split off the first character, then `\lettrine{<c>}{}<rest>`; the emitter splits the sentence itself and writes `\lettrine{T}{}he first ...` (`sp.lettrine`). Weak point: a string-splitting macro, accepted as reducible because its input is content known at emit time |
| `\chapterWord` (unused) | Commands/chapter_styling.tex:6-10 | yes | the same split, `\lettrine{<c>}{<rest of word>}` |
| `\chapterOpeningDeluxe` (unused) | Commands/chapter_styling.tex:20-32 | yes | split at the first space with `\IfSubStr`, `\StrBefore`, `\StrBehind`; the emitter splits the text; whether the nested `xstring` call works was not checked, the macro is never called |
| `\chapterOpening` (unused) | Commands/additional_commands.tex:31-33 | yes | `\lettrine{#1}{}` |
| `\baseChapter` | Commands/chapter_styling.tex:36-41 | yes | `\chapter{#1}` then `\setcounter{DefaultLines}{2}` and two `\renewcommand` of lettrine's hooks; the emitter writes those lines after each chapter heading or once |
| `\sceneBreak` `\sfx` `\inlinesfx` | Commands/additional_commands.tex:2-4, 7-9, 23-27 | yes | aliases; expansions in the Component map; commented-out variants at :11-22 are inactive |
| `\mc` | Commands/characters.tex:4 | yes | text alias for the name "Alice" (content) |
| `xparse`, `xifthen`, `xstring` | main.tex:22, 25; Commands/chapter_styling.tex:3 | yes | helper packages for the macros above, no printed effect; no way needed (the v4 log rejected load-only helpers on the same grounds) |

## Content-opaque
none (the sample has no figure, table, picture or equation)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Assumptions: `memoir`, `lettrine`, `tcolorbox` and `hyperref` sources were not read. The `[most]` option of `tcolorbox` is taken not to load the `minted` library, which would otherwise be `EXTERNAL/package`; that is my recollection of the tcolorbox manual, not checked here. `subfiles` is on CTAN (ctan.org/pkg/subfiles: LPPL 1.3, v2.2, Federico Garcia-De Castro and Gernot Salzer).
