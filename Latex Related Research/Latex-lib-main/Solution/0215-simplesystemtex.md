no

# 0215-simplesystemtex: SimpleSystemTeX (package source and its manual)

- Unverified: read from the source, not compiled.
- Source: Source/0215-simplesystemtex/ (origin: https://mirrors.ctan.org/macros/latex/contrib/simplesystemtex.zip; licence: LPPL 1.3c, LICENSE:5 and README.md:94; ctan.org/pkg/simplesystemtex read once: package v1.0.0, 2026-03-24)
- Kind: misc (a software manual for a package aimed at books, theses and lecture notes; manifest hint `book`)
- Lib: v2
- Engine: needs XeLaTeX (the sample loads `fontspec` and sets `\setmonofont{Menlo}`, simplesystemtex.doc.tex:12,16-18; the header comment says XeLaTeX, simplesystemtex.doc.tex:5). The package alone loads only tikz, tocloft, amssymb, hyperref (sources/simplesystemtex.code.tex:7-8) and is pdfLaTeX-compatible; it needs a recent kernel for expl3 (`\iow_now:Ne`, block.code.tex:19).
- Look carried by: mixed (the CTAN package whose expl3 source is in sources/, plus the sample preamble's `\SetStyle` code at simplesystemtex.doc.tex:52-100 and its layout lines at :10-27)
- Class origin: tex-distribution-unbundled (`article`; the package `simplesystemtex` is published on CTAN, so it is not zip-local; the zip ships its docstrip sources, not the generated `.sty`)
- Main file: simplesystemtex.doc.tex (other samples: none; the manual's body is nine section files under sec/, imported at simplesystemtex.doc.tex:135-153; README.md:44-81 holds a short quick-start only)
- Read: main yes, zip-local classes and styles all (15 `sources/*.code.tex` and `simplesystemtex.ins` read in full; no `.cls` or `.sty` is shipped; all 9 `sec/*.tex` read in full)

## Verdict
The look is carried by one published CTAN package (a file-per-section import, auto table of contents, typed blocks, cross-links and block indexes engine) plus preamble style strings that are plain compositions of kernel and xcolor commands. The package engine has no home in the lib; it is proposed below as one doc-kind way. The answer is still `no`, because the manual's cover is a hard-wired TikZ polar-plot logo (`\SimpleSystem` inside `\SimpleSystemCover`) that is template-defining artwork with no declarative lib way and no parameters.

## Blockers
- `ART/package` TikZ logo `\SimpleSystem`: two `\draw ... plot (\x: {3.14159 -/+ 0.36788 * cos (5 * \x)})` curves with `ultra thick`, `samples = 100`, drawn by hard-coded code (sources/logo.code.tex:20-36), printed on the manual's cover by `\SimpleSystemCover` (sources/logo.code.tex:37-45), called at simplesystemtex.doc.tex:124-126. It draws the cover's identity, has no parameters, and brands one project (fails W3), so it is not a lib way.

## Class setting
- Class: `class.article` options: `10pt` (simplesystemtex.doc.tex:10)
- Class-native vocabulary used: none of `\maketitle`, `abstract`, `\section`. The sample uses only kernel `\pagestyle`, `\newpage` (simplesystemtex.doc.tex:123,127,128). All headings, the contents and the cover come from the package, not from the class.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | simplesystemtex.doc.tex:10 | `class.article` | 10pt |
| page size and margins | simplesystemtex.doc.tex:12,20-26 | `page.geometry` | b5paper, left=18.75mm, right=18.75mm, top=20mm, bottom=25mm |
| base size | simplesystemtex.doc.tex:10 | `page.class-options` | 10pt |
| line spread | simplesystemtex.doc.tex:19 | `sp.linespread` | `\baselinestretch`=1.375 |
| local spacing environment | simplesystemtex.doc.tex:12,64-66; sec/StyleCodePresetValues.tex:2,179 | `sp.setspace` | `spacing` env 1.25 (Example style), 1.125 (code pages) |
| mono font | simplesystemtex.doc.tex:12,16-18 | `font.fontspec` | `\setmonofont{Menlo}[Scale=0.875]` (Menlo is an Apple font, not shipped) |
| font switches | simplesystemtex.doc.tex:53,56,65,77,78; sources/preset.code.tex:11,16,35,96,170 | `mark.kernel`, `font.size-commands` | `\slshape \bfseries \ttfamily \sffamily \itshape`; `\small \large \Large \LARGE \huge \footnotesize \scriptsize` |
| colours | simplesystemtex.doc.tex:61,71,77,85,91; sources/preset.code.tex:109,150,156,162,168; sec/SimpleSystemTeXOverview.tex:23,43 | `color.xcolor` | named: gray, red, purple, olive, brown, teal, blue, black, orange (xcolor comes in through the package's `tikz`) |
| manual spacing | simplesystemtex.doc.tex:56,62,72,98; sources/preset.code.tex:13,17,60,106 | `sp.manual-space` | `\medskip \bigskip \smallskip \noindent \indent \quad \, \: \;` |
| dashed leader lines in Example and Usage styles | simplesystemtex.doc.tex:63,67,79,81 | `sp.rule` | `\cleaders\hbox{\rule[0.25em]{7.5pt}{0.1pt}}\hfill` (raise 0.25em top, 0.5em bottom; the box holds only a rule; borderline against the lib line "leaders over arbitrary boxes are bespoke", judged inside `sp.rule` because the box is one rule) |
| cover page | simplesystemtex.doc.tex:123-128 | `hf.pagestyle-kernel`, `pg.break`, ART | `\pagestyle{empty}`, cover, `\newpage`, `\pagestyle{plain}`; the cover itself is the ART blocker |
| cover logo | simplesystemtex.doc.tex:124-126; sources/logo.code.tex:20-45 | `art.tikz` (ART) | `\SimpleSystemCover{\huge ...}` centred, `\vspace*{\fill}` above and below |
| page numbers | simplesystemtex.doc.tex:128 | `hf.pagestyle-kernel` | `plain` |
| section import and order | simplesystemtex.doc.tex:135-153; sources/interface.code.tex:37-53; sources/section.code.tex:4-19,42-46 | `struct.simplesystemtex` | `\ImportSection{path}(display name)<parameter>`, default prefix `./sec/` (sources/simplesystemtex.code.tex:13), `\SetSectionPath` (sources/interface.code.tex:31-35) |
| parts | simplesystemtex.doc.tex:135,138,142,148,151; sources/interface.code.tex:24-29 | `struct.simplesystemtex` | `\AddPart{name}` |
| section headings (no `\section`) | sources/preset.code.tex:92-107; sources/section.code.tex:23-40 | `struct.simplesystemtex` | style slot `SectionHeading`: bold, `\huge` name, `\Large` group, `\bigskip` after |
| table of contents | simplesystemtex.doc.tex:132-133; sources/toc.code.tex:32-44; sources/preset.code.tex:10-52 | `struct.simplesystemtex` | slots `TOCTitle`, `TOCPartTitle`, `TOCSection`; `\TableofContents` queues a task printed at `\AtEndDocument` (sources/simplesystemtex.code.tex:26-32) |
| dotted TOC leader and page number | sources/preset.code.tex:28,37,46,87; sources/simplesystemtex.code.tex:7 | `toc.tocloft` | `\cftdotfill{\cftnodots}` (tocloft loaded unconditionally by the package) |
| content in main-file body | simplesystemtex.doc.tex:133; sources/interface.code.tex:12-22 | `struct.simplesystemtex` | `\TextCommand{code}` (page flow), `\TableCommand{code}` (inside the TOC) |
| typed blocks (theorem-like and manual blocks) | simplesystemtex.doc.tex:43-50; sources/preset.code.tex:3-6; sources/block.code.tex:54-97; sources/interface.code.tex:55-70 | `struct.simplesystemtex` | `\NewBlockType{Name}` regular, `\NewBlockType*{Name}` anonymous; call `\Name{label}(name)<param>{content}`; predefined Definition, Theorem, Corollary, Proof |
| block looks | simplesystemtex.doc.tex:52-100 | `struct.simplesystemtex` | `\SetStyle{Type}{code}` with `@blockname`, `@blockcontent` (the doc uses no conditionals); NewConcept slanted, List bold title, Example grey and mono, BadPractice red, Usage purple mono, MandatoryArguments olive, OptionalArguments brown, LocalUsage mono indented |
| style slots for headings, TOC, links, index | sources/style.code.tex:16-27,29-39; sources/preset.code.tex:10-147 | `struct.simplesystemtex` | `\SetStyle` strings with `@argument` display arguments and `#ifempty` `#ifis` `#ifequal` conditionals |
| auto list markup in block content | simplesystemtex.doc.tex:117; sec/Text/CreatingBlocks.tex:24,64; sources/expsyntax.code.tex:8-27; sources/block.code.tex:42-44 | `struct.simplesystemtex` | switch `\AutomaticListon` / `\AutomaticListoff`: ` + ` becomes a numbered paragraph, ` - ` a bullet paragraph, ` - - ` a circle paragraph |
| cross-links (section, block, index) | sec/Text/AddingLinks.tex:2-30; sources/link.code.tex:4-82; sources/interface.code.tex:91-125 | `struct.simplesystemtex` | `\seclink{path}(text)`, `\blclink{label}(text)`, `\indlink{scope}(text)`; slots `SectionLink` `BlockLink` `IndexLink` blue |
| link engine and anchors | sources/link.code.tex:24,51,74; sources/block.code.tex:12; sources/section.code.tex:24; sources/simplesystemtex.code.tex:8 | `meta.hyperref`, `xref.hyperref`, `xref.kernel` | `hyperref[hidelinks]`, `\hyperref[label]{...}`, `\phantomsection`, `\label`, `\pageref*` |
| block index | sec/SimpleSystemTeXCommandIndex.tex:2-4; sources/index.code.tex:81-122; sources/preset.code.tex:53-91 | `struct.simplesystemtex` | `\MakeBlockIndex{scope/}[Usage]`, `*` form for no anchor; slots `IndexGroup` `IndexSubgroup` `IndexSubsubgroup` `IndexBlock` |
| external links | sec/SimpleSystemTeXOverview.tex:52-53 | `meta.hyperref` | `\href{url}{text}` |
| verbatim code pages | sec/StyleCodePresetValues.tex:4-48,50-90,92-128,130-178 | `code.verbatim` | `verbatim` inside `spacing` and `\small` |
| centred title in TOCTitle | sources/preset.code.tex:12; sources/logo.code.tex:38 | `sp.ragged` | `center` environment |
| doc-local text helpers | simplesystemtex.doc.tex:29-32 | `mark.kernel`, `math.kernel`, `sp.manual-space` | `\texttt`, `\textbackslash`, `\langle \rangle`, `\textsuperscript{\P}` |
| math symbols | sources/simplesystemtex.code.tex:7 | `math.amssymb` | loaded unconditionally; not used by the sample |

Not defined by the zip (nothing to map): no header or footer beyond `plain`, no title block or abstract, no bibliography, no footnotes, no figures or tables, no language package, no theorem package (blocks replace it).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\SimpleSystem` logo and `\SimpleSystemCover` | sources/logo.code.tex:20-45 | No (ART) | hard-coded TikZ plot, no parameters, one project's brand; blocker above |
| package engine: task queue run at `\AtEndDocument`, `\file_input` of section files, aux-file block registry, recursive group index, `\SetStyle` regex rewriting of `@arg` and `#if...` | sources/simplesystemtex.code.tex:26-32; sources/utils.code.tex:8-41; sources/section.code.tex:23-49; sources/register.code.tex:13-50; sources/block.code.tex:7-27; sources/index.code.tex:57-122; sources/style.code.tex:29-39 | Published (CTAN), not bespoke; no lib way | one way, `struct.simplesystemtex`; the emitter prints the package's own commands and writes one file per section |
| `\AutomaticListon` token rewriting | sources/expsyntax.code.tex:15-27 | Part of the package way | boolean switch of the same way |
| `\UserCommand` | simplesystemtex.doc.tex:105-115 | Yes | at emit time expand to `\Usage{name-U}(name)<tag>{usage}`, then `\MandatoryArguments{name-MP}<tag>{...}` and `\OptionalArguments{name-OP}<tag>{...}` when present, then `\par\medskip`; the `\IfValueT` tests only decide which blocks exist |
| `\newconcept` | simplesystemtex.doc.tex:102-104 | Yes | alias for `\NewConcept{#1}{#1}` |
| `\SimpleSystemTeX` copy and wrapper | simplesystemtex.doc.tex:34-41; sources/logo.code.tex:3-16 | Yes | text macro `\,$\mathrm{S^{imple}\sb{ystem}}$\textrm{\TeX}\,` (`[bf]` uses `\mathbf` and `\textbf`): `math.kernel` plus `mark.kernel`, expanded in place; the wrapper only appends `\,` |
| `\cs`, `\meta`, `\longarg`, `\AnotherUsage` | simplesystemtex.doc.tex:29-32 | Yes | aliases of `\texttt{\textbackslash ..}`, `$\langle$..$\rangle$` with `\ttfamily\slshape`, `\textsuperscript{\P}`, `\par\noindent\ ` |
| `\SetStyle` bodies of the sample | simplesystemtex.doc.tex:52-100 | Yes | compositions of `mark.kernel`, `color.xcolor`, `sp.manual-space`, `sp.rule`, `sp.setspace`, `font.size-commands` inside `\SetStyle` |
| `\UseMathletter*` and `\UseMathLetter*` generators | sources/math.code.tex:5-22 | Not used by the sample | package feature, outside scope |

## Content-opaque
- `dirtree` directory trees (`art.content-package`, a CTAN package; sample loads it at simplesystemtex.doc.tex:12 and sets `\DTbaselineskip` at :27): sec/MainFile/ImportingSectionFiles.tex:6-15 and :71-88. They illustrate a file layout, not the template's identity.
- Block label with Chinese text `\Example{创建区块-示例}` at sec/Text/CreatingBlocks.tex:26: the Example style prints a literal "Example" and never `@blockname` (simplesystemtex.doc.tex:60-69), so the label is only written to the aux file; no CJK way is needed for printing.
- Verbatim listings and the escaped `\cs{...}` code examples inside Example blocks.

## Lib changes
- New ways proposed: `struct.simplesystemtex` (package `simplesystemtex`, CTAN, LPPL 1.3c, v1.0.0 read at ctan.org/pkg/simplesystemtex; engine pdf for the package alone, the sample adds `fontspec`). One way for the whole file-and-block engine: section files imported in order with a path-derived group tree, parts, a generated table of contents, regular and anonymous block types, cross-links, block indexes. Searched `_Lib.md` for struct, modular, subfile, block, simplesystem: no home (`pg.standalone-pkg` includes sub-files but has no TOC, blocks or indexes; `toc.*` and `thm.*` do not generate from a file tree). W1: on CTAN with a published manual. W2: chosen by strings, names, paths, lists and one boolean (`\NewBlockType` names, `\SetSectionPath`, `\ImportSection` path and name, `\MakeBlockIndex` scope and type list, `\AutomaticListon`); the `\SetStyle` code string is formatting code of kernel and xcolor commands with `@` display arguments, comparable to the format code of `\titleformat` that `head.titlesec` already admits (weak point: the preset styles also use the package's own `#ifempty` conditionals, and the sample uses none). W3: serves one kind of component (a large multi-file document), not one manual; the logo and cover commands are excluded from the way because they brand one project. W4: preamble lines (`\usepackage`, `\NewBlockType`, `\SetStyle`) and body wrappers (`\ImportSection`, block calls, links), with the emitter writing one `.tex` file per section.
- Considered and not proposed: `dirtree` as its own way (kept under `art.content-package` as content).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
