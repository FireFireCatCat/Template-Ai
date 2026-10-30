yes

# 0004-lebhart: lebhart (a colorful article class, colorist series)

- Unverified: read from the source, not compiled.
- Source: Source/0004-lebhart/ (origin: https://mirrors.ctan.org/macros/unicodetex/latex/lebhart.zip; licence: lppl1.3c)
- Kind: misc (general-purpose colourful article class; kind hint: article)
- Lib: v0
- Engine: needs XeLaTeX or LuaLaTeX (fontspec, unicode-math, ctex: lebhart.cls:233-234, 319, 619; README.md:9). Flouest's pdfTeX is not enough; recorded, not a blocker.
- Main file: none, the zip holds no .tex sample (analysed lebhart.cls, README.md, DEPENDS.txt, LICENSE) (other samples: none)
- Read: main yes (nothing to read, no .tex sample exists), zip-local classes and styles all (lebhart.cls 1-867, every line)

## Verdict
yes, and the yes rests on one reading of the rubric that a reviewer should check. `lebhart.cls` is the CTAN-published class itself (origin URL above; README.md:5 says its core code ships in TeX Live and MiKTeX), so it is the way `class.lebhart` (W1 published, W2 options are values and booleans, W3 serves any article, W4 printed as one `\documentclass[...]{lebhart}` line), not bespoke code. Its two heavy dependencies `colorist` (lebhart.cls:184) and `projlib` (lebhart.cls:224) are also CTAN packages (ctan.org/pkg/colorist, ctan.org/pkg/projlib, both LPPL 1.3c) but are not in the zip, so the look they define (headings, title block, colours, theorem-like environments) was NOT read. There is no sample, no unpublished style file, no artwork and no external tool. If a reviewer rules that a published class shipped inside the zip must still be decomposed into lib ways, this flips to `no`: the class holds irreducible expl3 font-selection and math-patching code (see Bespoke code).

## Blockers
none

## Class setting
- Class: `class.lebhart` options: `a4paper`, `b5paper` (default is US Letter), `oneside`, `twoside`, `11pt`, `12pt` (these four are passed to the base class), `draft` = `fast` (same boolean), `print` (aliases `print mode`, `print-mode`, `print version`), `load custom font file` with latin, cjk and math variants; every other option is forwarded to `colorist` (lebhart.cls:39-116). Base class `article`, loaded by `\LoadClass` (lebhart.cls:24, 118).
- Class-native vocabulary used: no sample, so this is what the class defines. `\IfPrintModeTF`, `\IfPrintModeT`, `\IfPrintModeF` (lebhart.cls:120-131); active `·` meaning `\cdot` (825-826); extensible arrows `\xrightarrow`, `\xleftarrow`, `\xleftrightarrow`, `\xhookrightarrow`, `\xhookleftarrow`, `\xmapsto`, `\xlongequal`, `\xtwoheadrightarrow`, `\xtwoheadleftarrow`, `\xrightrightarrows`, `\xleftleftarrows` (734-803); `\twoheadrightarrow`/`\twoheadleftarrow` redefined (805-819); `\varprojlim`, `\varinjlim`, `\limstrut`, `\loweredvdots`, `\vdash`, `\dashv`, `\mathunderbar` adjusted (665-708); `\AddLanguageSetting` (588-608, from projlib); `\graphicspath{{images/}}` (832). Theorem-like environments, headings, title and abstract come from `colorist` and `projlib` (README.md:22, 13), not read.

## Component map
All rows are realised by the one class way. "Inside the class" names the published package the class loads; the emitter does not print it.
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class and base | lebhart.cls:19-24, 116-118 | `class.lebhart` | `\documentclass[<options>]{lebhart}`; base article; options as listed above |
| page geometry | lebhart.cls:101-173 | `class.lebhart` | inside the class: `geometry` with `heightrounded`; default papersize 8.5in x 11in, total 6.500in x 9.130in, centering, footnotesep 2em plus 2pt minus 2pt, footskip .5in; `a4paper`: total 6.500in x 9.685in; `b5paper`: total 5.535in x 8.160in |
| draft watermark | lebhart.cls:175-180 | `class.lebhart` | inside the class, only with `draft`/`fast`: `draftwatermark`, text `\normalfont DRAFT`, color `paper!97!-paper`; also `fast` passed to colorist |
| first-line indent | lebhart.cls:182 | `class.lebhart` | inside the class: `indentfirst` |
| colour scheme, headings, title block, abstract, contents, lists, header/footer | lebhart.cls:184 (`\RequirePackage { colorist }`); DEPENDS.txt:1; README.md:3-7 | `class.lebhart` | defined by `colorist`, a CTAN package NOT in the zip and NOT read; the class does not set them itself (only `footskip` at line 148); unknown class options go to colorist (112-114) |
| theorem-like statements, cross-reference naming | README.md:22; lebhart.cls:224 | `class.lebhart` | defined by `projlib`/`colorist` ("ready-to-use theorem-type environments"), NOT in the zip and NOT read |
| Latin text fonts | lebhart.cls:222-306 | `class.lebhart` | inside the class: `fontspec` (`no-math,quiet`); main TeXGyrePagellaX (otf, Regular/Bold/Italic/BoldItalic), sans texgyreheros (`Scale=MatchUppercase`), mono NewCMMono10 (`Scale=1.05`); `Numbers=OldStyle` when projlib's old-style flag is set (238-258); `fast` loads `mathpazo` (230) |
| line spacing | lebhart.cls:308 | `class.lebhart` | inside the class: `\setstretch{1.07}` for Latin languages through `\projlib_language_set_linespacing_latin:n` |
| emphasis in brackets | lebhart.cls:193-200, 310-314 | `class.lebhart` | inside the class: `embrac`, `\RenewEmph{[}{]}`, `\RenewEmph{(}{)}` (`biblatex` option when biblatex is loaded) |
| CJK and language fonts | lebhart.cls:318-609 | `class.lebhart` | inside the class: `ctex` (`fontset=none`, `scheme=plain`); Source Han Serif/Sans/Mono for SC, TC and JP with FandolSong/FandolHei/FandolFang fallback; `fast` takes the Fandol branch without testing fonts (217-219); per-language switching with `\AddLanguageSetting` (588-608). Fonts not shipped (Source Han): note, not blocker |
| math fonts and math fixes | lebhart.cls:611-710 | `class.lebhart` | inside the class, not with `fast`: `amssymb`, `unicode-math` (`math-style=TeX`, `partial=upright`, `nabla=upright`), KpMath-Regular/Sans, latinmodern-math (`Scale=1.10`), texgyrepagella-math (`Scale=1.21` for delimiters); LuaTeX `\mathitalicsmode=1` (653-656) |
| extensible arrows | lebhart.cls:710-819 | `class.lebhart` | inside the class: `tikz-cd` arrow style plus TikZ-drawn `\x...arrow` macros (a math-symbol vocabulary, not a page decoration) |
| graphics, wrapped figures, float placement, captions | lebhart.cls:831-836 | `class.lebhart` | inside the class: `graphicx` with `\graphicspath{{images/}}`; `wrapfig2`; `float`; `caption` with `\captionsetup{font=small}` |
| widow and orphan control | lebhart.cls:843-851 | `class.lebhart` | inside the class, not with `fast`: LuaTeX `lua-widow-control` (`\lwcsetup{balanced}`), otherwise `nowidow` (option `all`) |
| last-line fill under XeTeX | lebhart.cls:853-863 | `class.lebhart` | inside the class: `regexpatch` patch of `\@trivlist`, `\parfillskip` = 0pt plus (`\linewidth` - 3em) |
| print mode switch | lebhart.cls:45-51, 120-131 | `class.lebhart` | class boolean `print`; what colorist does with it is not read |
| warning filters | lebhart.cls:136-137, 190-191 | `class.lebhart` | `silence` filters; no effect on the look |

## Bespoke code
By the rubric's definition nothing here is bespoke: it is bespoke only if "not published", and the only code in the zip is the published class. Items below are internals of that class, listed so the decision is auditable. "Would be" is the answer if the class were extracted and re-expressed from lib ways.
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option parsing, `\IfPrintMode*` | lebhart.cls:39-131 | not assessed (published); would be reducible | the options reduce to a class option list; the flag is read by colorist (not read) |
| geometry and paper handling | lebhart.cls:136-173 | not assessed (published); would be yes | geometry values in the Component map |
| custom font file loader, font-exists fallbacks | lebhart.cls:202-222, 321-450 | not assessed (published); would be NO | expl3 conditional file/font probing has no declarative lib way |
| CJK per-language family switching | lebhart.cls:582-609 | not assessed (published); would be NO | hook and `\CJKfamily` logic driven by projlib language flags |
| math-font patches, `\overline`/`\underline`/`\vdots`/`\vdash` redefinitions | lebhart.cls:653-708 | not assessed (published); would be NO | box-and-glue and `\mathpalette` code that redefines kernel and amsmath symbols |
| TikZ extensible arrows `\x...arrow` | lebhart.cls:713-819 | not assessed (published); would be NO | expl3 box and dimension code drawing arrows with `\tikz` |
| XeTeX `\@trivlist` patch, parfillskip | lebhart.cls:853-863 | not assessed (published); would be NO | patches a kernel internal |
| README "improvements" (`\directlua` kerning, mathkern, editing the .cls) | README.md:36-185 | out of scope | optional, experimental advice that README.md:38 says cannot go into the published version; not part of the class |

## Content-opaque
none. There is no sample. The TikZ arrows at lebhart.cls:716-803 are math-symbol definitions inside the class, not figures and not template artwork (no `ART`). `tikz-cd` (710) would be content (`art.tikz`) when a document draws diagrams.

## Lib changes
- New ways proposed: none. Candidates with no lib home exist (`nowidow`/`lua-widow-control` widow control, `embrac` bracket emphasis, the TikZ arrow macros) but they sit inside the class way, so no row needs them printed; propose them only if a later zip loads them directly.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
