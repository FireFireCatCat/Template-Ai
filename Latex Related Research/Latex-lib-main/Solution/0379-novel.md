yes

# 0379-novel: novel (a LuaLaTeX class for print-ready fiction)

- Unverified: read from the source, not compiled.
- Source: Source/0379-novel/ (origin: https://latextemplates.com/downloads/novel.zip; licence: LPPL-1.3c, class code; the `NovelDeco.otf` font is OFL-1.1 per README.md:25-26, and is not in the zip)
- Kind: book
- Lib: v4
- Engine: needs LuaLaTeX (main.tex:1 `% !TeX TS-program = lualatex`; main.tex:4 "A LuaLaTeX class"; README.md:3 and README.md:34 `lualatex main && lualatex main`; ctan.org/pkg/novel says Engine: LuaLaTeX; the sample sets fonts by `fontspec`-style names and `\setmathfont`)
- Look carried by: class (the zip holds only `main.tex` and a README; the look comes from the published class `novel`, and the preamble only sets that class's parameters, plus three font commands and one `\microtypesetup`)
- Class origin: tex-distribution-unbundled (class `novel` v2.2, Robert Allgeyer, LPPL 1.3c; in TeX Live and MiKTeX per ctan.org/pkg/novel; not bundled in the zip, README.md:19-20)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip has no `.cls`, `.sty`, `.def`, `.cfg`, `.bst`; the source of `novel.cls` was not read, see Verdict)

## Verdict
yes. The whole look is the published class `novel`, loaded unchanged and not bundled (main.tex:11). The zip adds only class-native settings (`\Set...` commands), three font-selection commands, one microtype call, and body text built from the class's own `ChapterStart`, `\ChapterTitle`, `\ChapterSubtitle` and `\scenebreak` plus kernel constructs. There is no zip-local macro, environment, counter, conditional or drawing (grep for `\newcommand`, `\def`, `\usepackage`, `\newenvironment`, `\newcounter`, `tikz` finds nothing in main.tex). The class source was not read (it is not in the zip and no TeX distribution is installed here); the README gives a build of two plain `lualatex` runs with no shell escape (README.md:33-35), and the CTAN page lists no external tool, so no `EXTERNAL` blocker is shown. This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.novel` options: none (`\documentclass{novel}`, main.tex:11)
- Class-native vocabulary used (all unread in source; roles inferred from the call sites, the README and ctan.org/pkg/novel):
  - metadata: `\SetTitle` `\SetSubtitle` `\SetAuthor` `\SetApplication` `\SetProducer` `\SetPDFX[intent]{standard}` (main.tex:13-18)
  - page: `\SetTrimSize{w}{h}` `\SetMargins{4 lengths}` (main.tex:20-21)
  - fonts: `\SetParentFont[fontspec features]{family}` `\SetDecoFont{file.otf}` `\SetHeadFont[features]{name}` `\SetChapterFont[features]{name}` `\SetSubchFont[features]{name}` (main.tex:23-28, 38, 45-46); macros `\parentfontname` `\parentfontfeatures` (main.tex:38, 45, 46)
  - running heads: `\SetHeadFootStyle` `\SetHeadJump` `\SetFootJump` `\SetLooseHead` `\SetEmblems` `\SetPageNumberStyle` `\SetVersoHeadText` `\SetRectoHeadText`, macros `\theAuthor` `\theTitle` (main.tex:33-41)
  - chapters: `\SetChapterStartStyle` `\SetChapterStartHeight`, environment `ChapterStart[n]`, `\ChapterTitle` `\ChapterSubtitle`, length or macro `\nbs` (main.tex:43-44, 55-61, 96-99, 118-121)
  - scene breaks: `\SetScenebreakIndent`, `\scenebreak` (main.tex:47, 109)
  - book divisions: `\frontmatter` `\mainmatter` (main.tex:52, 93)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:11 | `class.novel` | no options; native vocabulary under Class setting |
| engine | main.tex:1 | `class.novel` | LuaLaTeX (class requirement) |
| PDF metadata and PDF/X | main.tex:13-18 | `meta.class-native` | Title "The Clockmaker's Daughter", Subtitle "A Novel", Author, Application and Producer strings, `\SetPDFX[CGATSTR001]{X-1a:2001}` (output intent name and standard). No `hyperref` or `pdfx` call in the sample; the Producer string only names them (main.tex:17) |
| trim size and margins | main.tex:20-21 | `page.class-options` | trim 5.5in x 8.5in; margins 0.5in, 0.5in, 0.5in, 0.75in. Class commands in place of class options: considered a `page.class-native` line, not proposed, because the v3 change log files a published class's own vocabulary under the class way |
| body font | main.tex:23-27 | `font.fontspec` | `\SetParentFont` family Libertinus Serif; features `SmallCapsFeatures={Renderer=Basic}`, `Kerning=On`, `Ligatures=TeX` |
| decorative font | main.tex:28 | `font.fontspec` | `\SetDecoFont{NovelDeco.otf}`, a font file that README.md:19 says ships with TeX Live (asset not in the zip) |
| sans, mono fonts | main.tex:29-30 | `font.fontspec` | `\setsansfont{Libertinus Sans}`, `\setmonofont{Libertinus Mono}` |
| math font | main.tex:31 | `font.unicode-math` | `\setmathfont{Libertinus Math}` (no math in the sample body) |
| microtype | main.tex:48 | `sp.microtype` | `\microtypesetup{config=novel-microtype,stretch=20,shrink=20,final}`. The config name `novel-microtype` is a file the zip does not hold; it is assumed to ship with the class (not verified) |
| running heads and feet | main.tex:33-41 | `hf.class-native` | style 1; head jump 1.5; foot jump 1.5; loose head 50; emblems empty `{}{}`; head font = parent font name with `\parentfontfeatures`, `Letters=SmallCaps`, `Scale=0.92`; page number `\thepage`; verso head `\theAuthor`; recto head `\theTitle` |
| blank-page style on front pages | main.tex:54, 64, 74, 86 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| chapter opening style | main.tex:43-46 | `head.class-native` | start style `footer`; start height 10; chapter font features `Numbers=Lining`, `Scale=1.6`; subchapter font `Numbers=Lining`, `Scale=1.2` |
| chapter opening pages | main.tex:96-99, 118-121 | `head.class-native` | `ChapterStart` environment with `\ChapterTitle{--- 1 ---}` and `{--- 2 ---}`; the title text is content, typed by hand (no `\chapter` call) |
| scene break | main.tex:47, 109 | `head.class-native` | `\scenebreak` with `\SetScenebreakIndent{false}`. A scene break is the class's own divider inside a chapter, a sectioning-level construct, so filed under heading looks; considered a `mark.class-native` line, not proposed |
| half-title page | main.tex:54-61 | `head.class-native` | `ChapterStart[8]` holding `\ChapterTitle`, `\ChapterSubtitle`, author line; optional argument 8 (meaning not read; likely the chapter-start height override) |
| vertical gaps | main.tex:56, 58, 97, 119 | `sp.manual-space` | `\vspace{\nbs}`, `\vspace*{2\nbs}` (`\nbs` is class-defined, not read) |
| centred lines | main.tex:60, 66-70, 76-82, 88-90 | `sp.ragged` | `\centering` group and `center` environment |
| book divisions | main.tex:52, 93 | `front.class-native` | `\frontmatter`, `\mainmatter`; whether they switch page numbering is not known (class unread) |
| also-by page | main.tex:63-71 | `front.dedication` | hand-laid: `\clearpage`, `\thispagestyle{empty}`, `\vspace*{\fill}` before and after a centred block, `\emph` titles |
| copyright page | main.tex:73-83 | `front.dedication` | same construction; `\textsc` title line, `\textcopyright` symbol (content) |
| dedication page | main.tex:85-91 | `front.dedication` | same construction |
| page breaks | main.tex:63, 73, 85, 95, 116, 130 | `pg.break` | `\clearpage` between pages and before each chapter |
| fill glue | main.tex:65, 71, 75, 83, 87, 91 | `sp.manual-space` | `\vspace*{\fill}` |
| emphasis, small caps | main.tex:68-69, 77 | `mark.kernel` | `\emph`, `\textsc` |

Components the sample does not use and the zip does not define: lists, tables, figures, captions, footnotes, theorems, code, bibliography, index, cross-references, table of contents, abstract. They are not in scope for this zip.

## Bespoke code
none. The zip defines no macro, environment, counter, conditional or `.sty`/`.cls`. Every `\Set...` command, `ChapterStart`, `\scenebreak`, `\nbs`, `\theAuthor`, `\theTitle`, `\parentfontname` and `\parentfontfeatures` belongs to the published class `novel` (main.tex:11), so it is class vocabulary, not zip-local code.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Considered and not proposed: `page.class-native` (trim size and margins are filed under `page.class-options`, with the class command names kept under Class setting) and `mark.class-native` (the scene break is filed under `head.class-native`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Unread, therefore assumed from outside sources: the source of `novel.cls`, the file `novel-microtype` config, `NovelDeco.otf`, the Libertinus fonts. The CTAN page (https://ctan.org/pkg/novel, one read) gives: LuaLaTeX class for original fiction for non-colour print-on-demand, built-in PDF/X support, v2.2 of 2024-04-26, LPPL 1.3c and OFL, in TeX Live, no dependencies listed.
- Missing assets: `NovelDeco.otf` and the Libertinus Serif, Sans, Mono and Math faces are not in the zip (README.md:19-20 says TeX Live ships them); ship them with the template.
- README.md:8-15 says the sample is adapted from the class's official Appendix A example; it is documentation of the class, not a modification of it. No text addressed to an AI was found in the zip.
