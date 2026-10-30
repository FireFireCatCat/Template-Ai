yes

# 0004-lebhart: lebhart (a colourful article class, colorist series)

- Unverified: read from the source, not compiled.
- Source: Source/0004-lebhart/ (origin: https://mirrors.ctan.org/macros/unicodetex/latex/lebhart.zip; licence: lppl1.3c)
- Kind: misc (manifest hint: article; a general article class, no sample document)
- Lib: v1
- Engine: needs XeLaTeX or LuaLaTeX (unconditional `fontspec` and `ctex`, OpenType fonts, README.md:9; lebhart.cls:233-234, 318-319)
- Look carried by: class (lebhart.cls sets page, fonts, graphics and caption defaults; everything else is delegated to the published `colorist` style loaded at lebhart.cls:184, which is not in the zip and was not read)
- Class origin: ctan (ctan.org/pkg/lebhart read: LPPL 1.3c, version 2026-02-20, in TeX Live and MiKTeX; matches `\ProvidesExplClass` date at lebhart.cls:21)
- Main file: none (no .tex sample in the zip; the zip is the class itself: lebhart.cls, README.md, LICENSE, DEPENDS.txt) (other samples: none)
- Read: main no sample present; zip-local classes and styles all (lebhart.cls read in full, 867 lines; `colorist` is a separate CTAN package, not in the zip, not read)

## Verdict
yes, on the class dimension only. The zip is not a document template built on a class: it is the published CTAN class `lebhart` itself (W1 met: CTAN, LPPL, in TeX Live), already a lib way, `class.lebhart`, whose parameters are the class options. An emitter writes `\documentclass[<options>]{lebhart}` and needs no zip-local macro logic, so there is no bespoke code in the sense of the rubric (nothing here is unpublished). There is no sample, so no body component is exercised, and the part of the look that `colorist` defines is unobserved. This is evidence about the class dimension, not about component ways.

## Blockers
none

## Class setting
- Class: `class.lebhart` options: `a4paper` | `b5paper` (default is US Letter 8.5in x 11in), `11pt` | `12pt`, `oneside` | `twoside` (these last four are passed to article), `draft` | `fast` (one boolean: both keys set `\l__colorclass_fast_bool`, lebhart.cls:41-43), `print` (aliases `print mode`, `print-mode`, `print version`, lebhart.cls:45-52), `load custom font file[=file]` and its latin/cjk/math variants (lebhart.cls:55-99); any other option is forwarded to `colorist` (lebhart.cls:112-114). Base class: article (lebhart.cls:24, 118).
- Class-native vocabulary used: no sample, so none used. The class itself defines `\IfPrintModeTF`, `\IfPrintModeT`, `\IfPrintModeF` (lebhart.cls:120-131); the extensible-arrow commands `\xrightarrow` `\xleftarrow` `\xleftrightarrow` `\xhookrightarrow` `\xhookleftarrow` `\xmapsto` (renewed) and `\xlongequal` `\xtwoheadrightarrow` `\xtwoheadleftarrow` `\xrightrightarrows` `\xleftleftarrows` (new) with an optional first argument that is passed to `\tikz` (lebhart.cls:734-803); redefined `\twoheadrightarrow`, `\twoheadleftarrow` (lebhart.cls:805-819); `\limstrut`, `\loweredvdots` (lebhart.cls:671, 685); the active character U+00B7 as `\cdot` (lebhart.cls:825-826); `\graphicspath{{images/}}` (lebhart.cls:832). Headings, theorem-like environments, title block and so on come from `colorist` ("Ready-to-use theorem-type environments", README.md:22): not read, not listed.

## Component map
All rows are set inside the published class; the emitter gets them from `class.lebhart`, it does not write them. The ways named are the nearest lib homes for what the class source shows.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | lebhart.cls:19-24, 116-118 | `class.lebhart` | `\ProvidesExplClass{lebhart}`; `\LoadClass{article}`; keys in the `colorclass` module, `\ProcessKeyOptions` |
| paper, size, sides | lebhart.cls:101-110 | `page.class-options` | `a4paper` / `b5paper` booleans, `11pt` / `12pt` / `oneside` / `twoside` forwarded with `\PassOptionsToClass` |
| page geometry | lebhart.cls:139-173 | `page.geometry` | `heightrounded`; `papersize={8.5in,11in}`, `total={6.500in,9.130in}`, `centering`, `footnotesep=2em plus 2pt minus 2pt`, `footskip=.5in`; `b5paper`: `total={5.535in,8.160in}`; `a4paper`: `total={6.500in,9.685in}` |
| draft watermark (only under `draft`/`fast`) | lebhart.cls:175-180 | `bg.watermark` | `draftwatermark`, `text={\normalfont DRAFT}`, `color=paper!97!-paper` |
| watermark colour expression | lebhart.cls:179 | `color.xcolor` | xcolor mix `paper!97!-paper` (`paper` is defined by colorist, unread) |
| first-line indent | lebhart.cls:182 | `sp.indentfirst` | package loaded, no options |
| everything colorist defines (colours, headings, title block, theorems, headers/footers, lists, ToC, boxes, bibliography, language names) | lebhart.cls:177, 184; README.md:19-23 | `class.lebhart` | loaded unconditionally via `\RequirePackage{colorist}`; `fast` passed through when set; unknown options forwarded. Source not in the zip, not read. No `class-native` way is claimed without a sample. |
| Latin text fonts | lebhart.cls:233-306 | `font.fontspec` | `fontspec` with `no-math,quiet`; `\setmainfont{TeXGyrePagellaX}` (.otf, Regular/Bold/Italic/BoldItalic, `Numbers=OldStyle` when `\l__projlib_font_useosf_bool`); `\setsansfont{texgyreheros}` `Scale=MatchUppercase`; `\setmonofont{NewCMMono10}` `Scale=1.05` |
| fast-mode Latin maths font | lebhart.cls:228-231 | `font.palatino` | `mathpazo` loaded under `fast` |
| line spacing | lebhart.cls:308 | `sp.setspace` | `\setstretch{1.07}` through `\projlib_language_set_linespacing_latin:n` |
| language and font set via projlib | lebhart.cls:224-226, 588-608 | `lang.projlib` | `projlib-font`; `\AddLanguageSetting[schinese|tchinese|japanese]` choose CJK families |
| CJK fonts and scripts | lebhart.cls:318-580 | `lang.cjk` | `ctex` with `fontset=none, scheme=plain`; `\setCJKmainfont/sansfont/monofont` and `\setCJKfamilyfont` (SCmain/SCsans/SCmono, TCmain.., JPmain..) from Source Han with FandolSong/FandolHei/FandolFang fallback (`FakeBold=4`) |
| maths fonts | lebhart.cls:611-649 | `font.unicode-math` | `unicode-math` (`warnings-off={mathtools-colon,mathtools-overbracket}`); `\unimathsetup{math-style=TeX, partial=upright, nabla=upright}`; `\setmathfont` KpMath-Regular.otf, KpMath-Sans.otf (`\sum \check \hat`), latinmodern-math (`Scale=1.10`), texgyrepagella-math (`Scale=1.21`, Latin italics and digits), `RawFeature=+ss01` for cal; `\mathitalicsmode=1` on LuaTeX |
| maths symbols | lebhart.cls:615 | `math.amssymb` | `amssymb` |
| maths glyph tuning | lebhart.cls:658-708 | `font.unicode-math` | `\overline`=`\wideoverbar`, `\underline`=`\mathunderbar`, `\square`=`\mdwhtsquare`, `\varprojlim`/`\varinjlim`, `\setminus` with `\!`, lowered `\vdots`, raised `\dashv`/`\vdash` |
| extensible arrows | lebhart.cls:710-819 | `math.amsmath` (the commands `\xrightarrow` etc.) | rebuilt in `tikz-cd`/`\tikz` boxes (implementation `art.tikz`, internal; it re-renders maths arrows, it is not template-identity artwork, so not ART); `\tikzcdset{arrow style=tikz, diagrams={>={Stealth[round,length=3.4pt,width=6.15pt,inset=2.25pt]}}}` |
| figures and graphics path | lebhart.cls:831-832 | `fig.graphicx` | `graphicx`; `\graphicspath{{images/}}` |
| text-wrapped figures | lebhart.cls:833 | `fig.wrapfig` | `wrapfig2`, no options |
| float placement | lebhart.cls:834 | `fig.float` | `float` loaded (`[H]`) |
| captions | lebhart.cls:835-836 | `cap.caption` | `caption`; `\captionsetup{font=small}` |
| custom font config file hook | lebhart.cls:55-99, 202-213, 222, 236, 321, 611 | `class.lebhart` | option values name a user file input instead of the default font blocks; the default path is used when none is given |
| widow and orphan control (skipped under `fast`) | lebhart.cls:841-851 | `class.lebhart` | LuaTeX: `lua-widow-control`, `\lwcsetup{balanced}`; otherwise `nowidow` with option `all`. No lib way names these; internal to the class, never emitted |
| bracket emphasis | lebhart.cls:193-200, 310-314 | `class.lebhart` | `embrac` loaded at `begindocument/before` (option `biblatex` if biblatex is loaded); `\RenewEmph{[}{]}`, `\RenewEmph{(}{)}`. No lib way; internal, never emitted |
| print version flag | lebhart.cls:45-52, 120-131 | `class.lebhart` | boolean read by `\IfPrintModeTF/T/F` only; I found no other reader inside lebhart.cls (colorist may read it: unread) |
| warning filters | lebhart.cls:136-137, 190-191 | none | `silence` filters (geometry over-specification, font shape); no effect on the look |

## Bespoke code
Nothing here is unpublished: lebhart.cls is the CTAN release (see Class origin), so none of it is bespoke by W1. The items below are the class's own internals, listed so the result can be re-read if the class were ever decomposed instead of used as a way; under that reading they would be irreducible and tagged `BESPOKE/class`.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| expl3 option block, boolean switches, file-or-default font loader `\__colorclass_load_file_or_config:Nnn` | lebhart.cls:27-118, 202-213 | n/a (published class internals); irreducible if decomposed | none: class options are the parameters of `class.lebhart` |
| font fallback logic `\__colorclass_if_font_exist:nnn` and per-language CJK family switching (`\colorclass_cjk_sffamily:`, hooks on `\sffamily`, `\ttfamily`, `normalfont`) | lebhart.cls:215-220, 582-608 | n/a published; irreducible if decomposed | none |
| maths glyph redefinitions and TikZ-built extensible arrows (`\colorclass_xarrows_generic:nnnn`, `\colorclass_xarrows_double_generic:nnnnnn`, `\loweredvdots`, `\raisesymbol`) | lebhart.cls:658-819 | n/a published; irreducible if decomposed | none |
| `\xpatchcmd` of kernel `\@trivlist` and `\parfillskip` glue (XeTeX only) | lebhart.cls:853-863 | n/a published; irreducible if decomposed | none |
| active U+00B7 character | lebhart.cls:825-826 | n/a published | none |
| README suggestions for a patched local copy (Lua `fonts.handlers.otf.addfeature`, `mathkern@fix@for@lua`) | README.md:36-188 | not part of the class as shipped | not used; they require editing the .cls, outside the lib. They carry no instructions to an AI. |

## Content-opaque
none (no sample; the TikZ in the class draws maths arrows, covered above)

Missing assets, noted and not blocking: the Source Han Serif/Sans/Mono families (README.md:26-35) are not in the zip or TeX Live; the class falls back to Fandol fonts (lebhart.cls:323-380). `KpMath-*.otf` (kpfonts-otf), TeXGyre fonts and New Computer Modern come from TeX Live. Not read: `colorist.sty` and `projlib*` (separate CTAN packages), so headings, theorems, title block, colours, headers, ToC and bibliography are not described. Dependency note: DEPENDS.txt holds only `hard colorist`.

## Lib changes
- New ways proposed: none. `class.lebhart` is already in lib v1 and the options read here match its lib line (a4paper/b5paper, 11pt/12pt, oneside/twoside, draft/fast, print, other options to colorist; xe/lua). Not proposed because the emitter never writes them (they sit inside the published class): `embrac`, `nowidow`/`lua-widow-control`. If a future sample loads either itself, propose then.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
