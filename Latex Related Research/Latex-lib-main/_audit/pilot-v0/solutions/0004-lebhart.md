yes

# 0004-lebhart: lebhart, a colourful article class (colorist class series)

- Unverified: read from the source, not compiled.
- Source: Source/0004-lebhart/ (origin: https://mirrors.ctan.org/macros/unicodetex/latex/lebhart.zip; licence: lppl1.3c)
- Kind: misc (a general-purpose article class; kind hint was "article")
- Lib: v0
- Engine: needs XeLaTeX or LuaLaTeX (`fontspec`, `unicode-math`, `ctex` at lebhart.cls:233-234, 318-319, 619; `\sys_if_engine_luatex:T` at 653, 843)
- Main file: none. The zip holds no sample .tex; the template is the class `lebhart.cls` itself (other samples: none). README.md has code fragments only, no example document.
- Read: main yes (there is none, so the class and README stand in for it), zip-local classes and styles all (lebhart.cls 867 of 867 lines; README.md, DEPENDS.txt, LICENSE read)

## Verdict
`yes`, and the reason is narrow. The zip is the CTAN release of one published class, `lebhart` (CTAN page: tagged Class, in TeX Live and MiKTeX). Under the rubric's "Class setting" every distinct published class is its own way, and `lebhart` passes W1 to W4 (published; options only; serves any article; printed as `\documentclass[...]{lebhart}`), so it is proposed as `NEW:class.lebhart`. The emitter writes one `\documentclass` line plus class options and never copies lebhart.cls's macros. The look itself (styles, colours, headings, theorem environments) is delivered by `colorist.sty` and `projlib`, which are published but are NOT in this zip and were not read, so no inventory of class-native vocabulary beyond what lebhart.cls and README.md show is claimed. Caveat for the consolidator: if lebhart.cls were instead treated as zip-local code to be rebuilt from other lib ways, the answer would be `no` (the math-arrow, glyph-patch and paragraph-patch code at lebhart.cls:660-819, 853-863 is irreducible); this file does not take that reading because the class is published.

## Blockers
none

## Class setting
- Class: `NEW:class.lebhart` options: `a4paper` | `b5paper` (neither: US letter), `11pt` | `12pt`, `oneside` | `twoside`, `draft` | `fast` (one switch, lebhart.cls:41-43), `print` (45-52), `load custom font file[=f]` and the latin / cjk / math variants (55-99); any other option is passed on to `colorist` (112-114). Base class `article` (24, 118).
- Class-native vocabulary used: no sample, so none is "used". Defined in the zip: `\IfPrintModeTF` `\IfPrintModeT` `\IfPrintModeF` (120-131); active `·` for `\cdot` (825-826); redefined `\xrightarrow` `\xleftarrow` `\xleftrightarrow` `\xhookrightarrow` `\xhookleftarrow` `\xmapsto`, new `\xlongequal` `\xtwoheadrightarrow` `\xtwoheadleftarrow` `\xrightrightarrows` `\xleftleftarrows` (734-803); redefined `\overline` `\underline` `\square` `\varprojlim` `\varinjlim` `\setminus` `\vdots` `\dashv` `\vdash` `\twoheadrightarrow` `\twoheadleftarrow` (660-708, 805-819); `\graphicspath{{images/}}` (832). Named in README.md:22 but defined outside the zip: "theorem-type environments".

## Component map
Rows marked (internal) are what the published class does inside itself. They are listed so the lib sees them; the emitter does not print them separately, it prints `class.lebhart`.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | lebhart.cls:18-24, 116-118; DEPENDS.txt:1 ("hard colorist") | `NEW:class.lebhart` | options as in "Class setting" |
| paper, point size, sides | lebhart.cls:101-110 | `page.class-options` | a4paper, b5paper, 11pt, 12pt, oneside, twoside (the last four are forwarded to the base class) |
| (internal) base class | lebhart.cls:24, 118 | `class.article` | `\LoadClass{article}` |
| (internal) page geometry | lebhart.cls:139-173 | `page.geometry` | heightrounded; papersize 8.5in x 11in; total 6.500in x 9.130in; centering; footnotesep 2em plus 2pt minus 2pt; footskip .5in. b5paper: total 5.535in x 8.160in. a4paper: total 6.500in x 9.685in |
| (internal) draft watermark | lebhart.cls:175-180 | `bg.watermark` | `draftwatermark`: text `\normalfont DRAFT`, color `paper!97!-paper`; `fast` is also passed to colorist |
| (internal) first-line indent | lebhart.cls:182 | `sp.indentfirst` | package loaded, no options |
| (internal) Latin fonts | lebhart.cls:233-306 | `font.fontspec` | `no-math,quiet`; main TeXGyrePagellaX (.otf, Regular/Bold/Italic/BoldItalic); sans texgyreheros (Scale MatchUppercase); mono NewCMMono10 (Scale 1.05); Numbers=OldStyle when ProjLib's osf switch is on |
| (internal) line spacing | lebhart.cls:308 | `sp.setspace` | `\setstretch{1.07}` through ProjLib's `\projlib_language_set_linespacing_latin:n` (that helper is not in the zip) |
| (internal) CJK fonts | lebhart.cls:318-609 | `lang.cjk` | `ctex` with `fontset=none, scheme=plain`; Source Han Serif/Sans/Mono SC, TC, JP with Fandol fallbacks; family switched per language by `\AddLanguageSetting` (588-608, ProjLib's command) |
| (internal) math fonts | lebhart.cls:618-649 | `font.unicode-math` | `math-style=TeX, partial=upright, nabla=upright`; KpMath-Regular, KpMath-Sans, latinmodern-math (Scale 1.10), texgyrepagella-math (Scale 1.21) by `range`; `cal` with `+ss01` |
| (internal) AMS symbols | lebhart.cls:615 | `math.amssymb` | no options |
| (internal) graphics | lebhart.cls:831-834 | `fig.graphicx`, `fig.wrapfig`, `fig.float` | graphicx with `\graphicspath{{images/}}`; `wrapfig2`; `float` |
| (internal) captions | lebhart.cls:835-836 | `cap.caption` | `\captionsetup{font=small}` |
| styles, colours, headings, title block | lebhart.cls:112-114, 184; README.md:7, 19 ("Several carefully designed styles") | `head.class-native`, `front.class-native` | chosen by passing options to `colorist`; definition not in the zip, not read |
| theorem environments | README.md:22 | `thm.class-native` | provided by ProjLib/colorist; definition not in the zip, not read |
| math arrows and glyph tweaks, print-mode switches, widow and orphan control (internal) | lebhart.cls:120-131, 660-819, 843-863 | `NEW:class.lebhart` | no lib way exists for these on their own, and none is proposed (see Lib changes) |
| headers/footers, section numbering, contents, abstract, lists, tables, code, boxes, bibliography, index | none in the zip | not inventoried | the zip sets none of these; whatever colorist/projlib set is behind `class.lebhart` and was not read |

## Bespoke code
All of it sits inside the published class file, so it is not bespoke in the rubric's sense (published, not zip-local). Listed for the record; none could be rebuilt from other lib ways.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| expl3 file-or-config loader (`\__colorclass_load_file_or_config:Nnn`, `\file_input:n`) | lebhart.cls:202-213, 222, 236, 321, 611 | no, as a standalone rebuild | covered by `NEW:class.lebhart` and its `load custom ... font file` options |
| xarrows built from TikZ boxes (`\colorclass_xarrows_generic:nnnn`, double variant) | lebhart.cls:710-819 | no, as a standalone rebuild | covered by `NEW:class.lebhart`; math notation, not template artwork |
| math glyph patches (`\loweredvdots`, `\raisesymbol`, `\limstrut`, `\overline`, `\underline`) | lebhart.cls:660-708 | no, as a standalone rebuild | covered by `NEW:class.lebhart` |
| `\parfillskip` patch of `\@trivlist` with `regexpatch` (XeTeX only) | lebhart.cls:853-863 | no, as a standalone rebuild | covered by `NEW:class.lebhart` |
| `\IfPrintMode*` conditionals, active `·` | lebhart.cls:120-131, 825-826 | no, as a standalone rebuild | covered by `NEW:class.lebhart` |
| `\directlua` font and math-kern snippets | README.md:44-187 | out of scope | README says they are experimental, need hand-editing the .cls, and "cannot be integrated into the published version" (README.md:38, 70); not part of the released template, not executed |

## Content-opaque
none (no sample, no figures or tables; the `tikz-cd` loaded at lebhart.cls:710 serves the redefined math arrows and draws no template artwork, so it is not `ART`)

## Lib changes
- New ways proposed: `NEW:class.lebhart`, the class `lebhart` (CTAN macros/unicodetex/latex/lebhart, LPPL 1.3c), engine xe/lua. W1: released on CTAN and in TeX Live. W2: behaviour chosen by class options (paper, point size, sides, draft/fast, print, custom font file, pass-through to colorist). W3: serves any article, not one document (the CTAN page names other packages built on it). W4: printed as `\documentclass[...]{lebhart}`. Note for the consolidator: this is one more `class.<name>` for a single class zip, so it counts toward growth of the class family. Zips that only distribute a class are decided by `class.<name>` alone, which makes `yes` easy to reach; whether to count them as evidence is the consolidator's call. Not proposed, with reasons: `nowidow`/`lua-widow-control` (lebhart.cls:845-850, internal here, so no emitter row; propose it only if a zip loads it directly), `silence`, `regexpatch` (patching tools, W2 fails), `embrac`, `colorist` and `projlib` (reached only through `class.lebhart`; their own sources are not in this zip).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes: missing assets, so ship them. Source Han Serif/Sans/Mono are not shipped and are listed as required (README.md:28-34); Fandol fonts are the fallback in the CJK block (lebhart.cls:334-343); the other fonts named (TeXGyrePagellaX, texgyreheros, NewCMMono10, KpMath, latinmodern-math) are in standard TeX distributions as far as I know but were not checked here. Flouest's engine is pdfTeX and this class compiles only with XeLaTeX or LuaLaTeX (README.md:9; CTAN page), so a Flouest emission of this class needs an engine switch. Nothing in the zip addresses an AI.
