yes

# 0613-photobook: photobook (document class for photo books with bleeds, spreads, covers and foldouts)

- Unverified: read from the source, not compiled.
- Source: Source/0613-photobook/ (origin: https://mirrors.ctan.org/macros/latex/contrib/photobook.zip; licence: BSD 3-Clause, bsd3 in the manifest, LICENSE:1)
- Kind: book
- Lib: v5
- Engine: pdfLaTeX-compatible (the class branches on pdfTeX, XeTeX and LuaTeX at photobook.cls:5588-5594 and 5623-5636; README.md:89-90 says the author mostly uses LuaLaTeX and other engines are "mostly supported"; nothing was compiled)
- Look carried by: class (the zip is the class itself; no sample document ships, so the look is `\documentclass[<keyvals>]{photobook}` plus the class's own cell and template vocabulary)
- Class origin: ctan
- Main file: none, there is no .tex sample (the zip holds photobook.cls with its reference inline, photobook.pdf, README.md, DEPENDS.txt, Makefile, scripts/; README.md:47 points to ./examples/book/, which is not in this zip) (other samples: none)
- Read: main no sample in zip (the inline reference and usage snippets of the class read instead), zip-local classes and styles all (photobook.cls lines 1-5760); also read README.md, DEPENDS.txt, LICENSE:1-12, Makefile, scripts/README.md, scripts/cls2tex.sh, scripts/make-spreads.sh in full; photobook.pdf (binary, built from the .cls comments) not read

## Verdict
Yes. The zip is the CTAN package `photobook` (README.md:8 names its CTAN page; the manifest URL is the CTAN mirror), so its class passes W1; its settings are key=value class options (W2), it serves any photo book (W3), and an emitter writes `\documentclass[...]{photobook}` plus its environments and macros as body wrappers (W4), which the lib already files under `fig.class-native`. No sample, preamble or body code ships, and the helper scripts and Makefile only generate `.tex` or the manual, so an emitter that writes the class calls directly does not need them. The yes rests on treating a published class as one way without re-deriving its internals (cells built on `textpos`, `\AtBeginShipout` hooks, TikZ fold marks); a reading that counts those internals as bespoke would give `no`.

## Blockers
none

Considered and not made blockers:
- `scripts/make-spreads.sh:1-755` is a bash and sed generator that fills `${IMAGE}`, `${CAPTION}` and `${TEXT}` slots of template `.tex` files from a directory tree (scripts/README.md:266-293). It is an optional workflow aid, not loaded by the class; the `.tex` it prints is plain class calls such as `\ImageSpreadFill{${CAPTION}}{${IMAGE0}}` (scripts/README.md:292).
- `Makefile:145,148,179,192-193` and `scripts/cls2tex.sh:125-137` build the manual (grep and sed extract the `%%` reference lines, `latexmk -lualatex`, pandoc for markdown). They produce documentation, not the template output.
- The class loads no package that needs a tool outside TeX (loaded packages: photobook.cls:636-697); `minted`, `svg` and similar are absent. The image list it writes is plain TeX `\write` output (photobook.cls:2318-2334).

## Class setting
- Class: `class.photobook` (parent `book`, loaded as `\LoadClass[9pt, final, openany]{book}` at photobook.cls:620; options the class does not know go to `book`, photobook.cls:613). Options (kvoptions, photobook.cls:303-610): `layoutmode=block|spread|endpaper|cover|jacket` (484-500), `blockwidth` `blockheight` (303-304), `bleed` (default 5mm, 307), `bindingoffset` `gutteroffset` (305-306), `flatfold` (314), `pagefold` (323), `foldout` (331), `spinewidth` `spinefold` `coverboardgrow` `coverflap` `jacketwrap` `jacketflap` `jacketflapfront` `jacketflapback` (505-512), `clearimage` (526), `imageblockwidth` `imageblockheight` `imageblockoffsettop` (537-539), `pdfpagelayout` (560-566), `nofoldmarks` (577), `foldmarksize` (583), `geometrynodefaults` (599), `roundprintedlengthsto` (610).
- Class-native vocabulary (no sample, so this is the documented API read from the inline reference):
  - cell environments: `page` (1511), `leftpage` (1524), `inlinecell` `inlinecell*` (1706-1733), `minipagecell` (1752-1782), `zinlinecell` (1799-1813), `cell` `cell*` (1840-1871), `adjustcell` (1883-1897), `cliptocell` (2128), `topdown` `bottomup` (2009-2023), `papercell` `paperbleedcell` (3137-3152), `pagecell` `pagecell*` `pagebleedcell` (3194-3240), `textcell` (3288), `resizedpages` (1461), `shipoutbgcell` (3245), `leftside` `rightside` (4082-4108), `frontcover` `backcover` `spine` `vspine` `frontflap` `backflap` (4149-4234), `foldout` `foldoutcell` `foldoutcell*` (3710, 3888, 3902), `spreadtopages` `spreadtopages*` (3990, 4034).
  - image and caption macros: `\imagecell[fit|fill, center|left|right|inside|outside, top|bottom, clearance=, offsettop=, offsetleft=, scale=, captionalign=, captionclearparent=]{caption}{image}` (2360-2506), `\captioncell` (2798), `\vcaptioncell` (2890), `\rcaptioncell` (2917), `\captionblockcell` (3040), `\captionsize` `\captionformat` (4250-4266), `\savecell` `\gsavecell` `\usecell` (1926-1967), `\usespreadpage` (4011).
  - page and spread templates (each with a starred raw-caption form and a `<Name>Caption` hook, `\reset<Name>Caption`): `\ImagePage`, `\ImagePageClear[T|B|L|R]`, `\ImagePageFit[T|B|L|R]`, `\ImagePageFill`, `\ImageHalfPageL` `\ImageHalfPageR` (4645-5126), `\ImageSpread[T|B|L|R]`, `\ImageSpreadFit[T|B|L|R]`, `\ImageSpreadFill` (5167-5422); tweaks `\tweakimagescale` `\tweakimageoffsettop` `\tweakimageoffsetleft` `\resetimagetweaks` (4513-4533); meta API `\ImagePageTemplate` `\ResettableMacro` `\CellContentOptions` (4551, 1430, 1543).
  - book information pages: `\BookInfoPage` `\BookSoftwareInfoPage` `\BookFullInfoPage` over the text macros `\BookType` `\BookTitle` `\BookVersion` `\BookAuthors` `\BookYear` `\ByNotice` `\ThanksTo` `\ISBN` `\BookEdition` `\License` `\CopyrightNotice` `\OtherSoftware` `\BookFonts` `\SoftwareNotice` (4294-4459).
  - layout and PDF tools: `\ChangeLayout` `\ReInitPages` (1243-1255), `\emptypage` (1389), `\cleartoleftpage` (1402), `\keywords` `\subject` (1338, 1350), `\pdfboxesset` (5561), `\pdfpagecount` `\pdfspinewidth` `\pdfspreadstopages` `\pdfcover` `\pdfcoverfront` `\pdfcoverback` `\pdfweb` (5622-5697), `\pdfcommentcell` (5604), `\GenerateTemplate` `\PageInfo` (5483-5522, 5453), `\setcliptocellbleeds` (2080).

## Component map
Citations are lines of photobook.cls unless a path is given.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | 230, 613-614, 620 | `class.photobook` | key=value options listed above; `\ProcessKeyvalOptions*`; unknown options passed to `book` |
| parent class | 620 | `class.book` | `9pt, final, openany`; headings, contents, lists, tables, footnotes, bibliography and index are inherited from `book` and not restyled by the class |
| paper size with bleed, block size, binding and gutter offsets | 303-307, 1107-1228, 1216-1221 | `page.class-options` | `blockwidth`, `blockheight` (default paper minus 2 bleed), `bleed=5mm`, `bindingoffset=0pt`, `gutteroffset=0pt`; `\bleedblockwidth` = block + 2 bleed |
| layout modes (spread, endpaper, cover, jacket) | 484-512, 1056-1204 | `page.class-options` | `layoutmode=block|spread|endpaper|cover|jacket`; spread doubles the block width (1181), cover and jacket add `spinewidth`, `spinefold`, `coverboardgrow`, `coverflap`, `jacketwrap`, flaps (1118-1172); `pagefold` default `in`, `out` for cover and jacket (870-876, 1136, 1163) |
| fold marks | 577, 583, 885, 3507-3554, 3703-3705 | `page.class-options` | options `nofoldmarks`, `foldmarksize=6mm`; `\foldmarkoffset` 2mm; marks drawn by TikZ inside the class at shipout (3516-3553, 3703); no way for the emitter beyond the options |
| geometry call | 1268-1271, 1300-1315 | `page.geometry` | `paperwidth=\bleedblockwidth, paperheight=\bleedblockheight`, then `bindingoffset=\bindingoffset, twoside, includeall, nomarginpar, ignorehead=false, ignorefoot=false, ignoremp=false, vcentering, hcentering`; with `geometrynodefaults` only paper size and `bindingoffset` (1300-1304) |
| page style of special layouts | 1119, 1147, 1175, 1389-1393 | `hf.pagestyle-kernel` | `\pagestyle{empty}` for cover, jacket and spread; `\emptypage[style]` uses `\thispagestyle{style}` |
| page styles available to the author | 695, 475, 1387 | `hf.fancyhdr` | `fancyhdr` is loaded and its style names are accepted by `\emptypage`; the class defines no style of its own |
| page breaks and parity | 1402-1408, 1516, 3773, 3777 | `pg.break` | `\clearpage` ends `page`; `\cleardoublepage` around `foldout`; `\cleartoleftpage` |
| absolute placement of cells | 683, 1853, 1931, 1935, 3587, 5494 | `pg.textpos` | `\usepackage[absolute]{textpos}`; `textblock*`; `\TPoptions{absolute=false}` / `{absolute=true}`; `\TPoptions{showboxes=true}` in `\GenerateTemplate` |
| PDF metadata, page layout and page boxes | 560-566, 1287-1295, 1321, 1330-1351, 5561-5594 | `meta.class-native` | `\keywords{}`, `\subject{}`, title and author fed into `pdfinfo`; `pdfpagelayout` option (`TwoPageRight` for block, `SinglePage` otherwise, 1077-1083); `\pdfboxesset[bleed]{w}{h}` writes MediaBox, BleedBox, ArtBox, TrimBox, CropBox through `\pdfpageattr` or `\special{pdf:put @thispage ...}` |
| links and metadata package | 660, 1287-1295, 4339 | `meta.hyperref` | `\usepackage[unicode]{hyperref}`; `\hypersetup{pdfinfo={Title,Subject,Author,Keywords}, pdfpagelayout}`; `\href` in the software notice |
| colours | 671-675, 1276-1278 | `color.xcolor` | `xcolor` and `colorspace` loaded; `\color{black}` |
| page background colour | 673, 1276-1277 | `color.pagecolor` | `\pagecolor{white}` then `\pagecolor{none}` so the page colour is not drawn over cells |
| caption and label font | 4250-4251 | `font.size-commands` | `\captionsize` = `\fontsize{6.5pt}{8pt}\selectfont` (resettable macro) |
| logo font for `\TEX` and `\LATEX` | 5707-5710 | `font.nfss` | `\fontfamily{lmr}\selectfont` |
| paragraph spacing in info pages | 4373, 5496 | `sp.lengths` | `\setlength{\parskip}{0.5em}`, `\setlength{\parindent}{0em}` |
| manual spacing | 1978, 2571, 4375-4386, 5485-5489 | `sp.manual-space` | `\vspace`, `\vfill`, `\hspace{\fill}` |
| book information pages | 4294-4459 | `front.class-native` | `\BookInfoPage[extra]`, `\BookSoftwareInfoPage[extra]`, `\BookFullInfoPage[extra]` over the text macros listed above |
| image cell and caption cells | 2506-2670, 2798-3120, 4262-4266 | `fig.class-native` | `\imagecell` keys and the caption macros listed above; `\captionformat` = `adjustbox{margin=0.1em 0.2em, varwidth=\cellwidth}`; `\captioncellspacing` 5pt (961) |
| cells, page and paper cells, saved cells | 1706-1948, 3137-3291 | `fig.class-native` | `inlinecell`, `cell`, `pagecell` and the rest of the list above; lengths `\cellwidth` `\cellheight` `\celloffsetleft` `\celloffsettop` (995-1006) |
| foldouts and spreads | 3710-3926, 3990-4108 | `fig.class-native` | `\begin{foldout}[<fold-spec>]` with `in`/`out` folds and panel widths; `foldoutcell[<from>-<to>]`; `spreadtopages[<n>]`; `\clearfoldoutgutter` 8mm, `\clearfoldoutfold` 5mm, `\clearfoldoutedge` 1mm (1027-1031) |
| covers, spine, flaps | 4149-4234 | `fig.class-native` | `frontcover`, `backcover`, `spine`, `vspine[topdown|bottomup]`, `frontflap`, `backflap` placed in the `layoutmode=cover` or `jacket` page |
| page and spread templates | 4551-5422 | `fig.class-native` | `\ImagePage*`, `\ImagePageClear*`, `\ImagePageFit*`, `\ImagePageFill`, `\ImageHalfPage*`, `\ImageSpread*`, `\ImageSpreadFit*`, `\ImageSpreadFill`; `[<imagecell keys>]{caption}{image}`; defaults `clearimage` 10mm (1209), `imageblockwidth` and `imageblockheight` 0.85 (537-538), `imageblockoffsettop` -0.05 (539) |
| image placement inside cells | 2518-2527, 2531, 2543-2556 | `fig.graphicx` | `\includegraphics[keepaspectratio, width=, height=]{image}`; image list written to `\jobname.image-list` unless `\writeimagelistfalse` (2315-2334) |
| box clipping, margins, minipage and valign boxes | 1583-1584, 2132-2147, 2573-2575, 2663-2667, 4263 | `fig.adjustbox` | `adjustbox` keys `minipage=`, `valign=`, `margin=`, `varwidth=`; `trimclip` `trimbox` and `clipbox*` inside `cliptocell` (trimclip is the box-clipping sibling of adjustbox and is loaded at 669) |
| rotated cell content | 2011, 2020, 2919 | `fig.rotating` | `turn` environment with angles 270, 90 and 180 in `topdown`, `bottomup`, `\rcaptioncell` |
| page background overlay | 3245-3250 | `bg.eso-pic` | `\AddToShipoutPictureBG*` around a `pagecell` (`shipoutbgcell`, marked experimental) |
| include PDF spreads and covers | 5672-5697 | `pg.include-pdf` | `\includepdf[pages={{},1-}, nup=2x1, delta=#1 #1]{block.pdf}`; `\pdfcover` `\pdfcoverfront` `\pdfcoverback` `\pdfweb` |
| printed lengths | 1228, 5453-5459, 5487 | `mark.siunitx` | `numprint`: `\lenprint[mm]{len}`, `\nprounddigits{n}` set from `roundprintedlengthsto` |
| long caption workaround | README.md:79-87 | `box.minipage` | the README wraps a long caption in `minipage` of width `\cellwidth` inside `\imagecell` |

Not defined or restyled by the class (so no way is needed): sectioning, contents, lists, theorems, math, tables, footnotes, bibliography, index, abstract. The class has no title page of its own; `\title` and `\author` only feed the PDF metadata (1287-1295).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| photobook.cls internals (cell lengths and `\imagecell` arithmetic with `calc`, `listofitems` and `xint`; `\AtBeginShipout` fold marks; foldout panel lists) | photobook.cls:1840-1871, 2506-2670, 3507-3705, 3710-3779 | not applicable: this is the published class, not zip-local bespoke code | the emitter calls the class (`\documentclass[...]{photobook}` and its environments and macros) and does not copy its code |
| `scripts/make-spreads.sh` | scripts/make-spreads.sh:1-755 | yes, and optional | a template is a `.tex` file with `${IMAGE}`, `${CAPTION}`, `${TEXT}` slots (scripts/README.md:266-293); an emitter writes the filled class calls (`\ImageSpreadFill{caption}{image}`) directly, plus `\pdfcommentcell{Image: ...}` at scripts/make-spreads.sh:680 when annotations are on |
| `scripts/cls2tex.sh` and `Makefile` | scripts/cls2tex.sh:125-137; Makefile:145-148, 179, 192-193 | not part of the template | documentation build and install only |
| `\Edition` used but never defined (the documented macro is `\BookEdition`) | photobook.cls:4387-4388 versus 4311-4312 | yes | the info pages test and print `\Edition`; read-only analysis suggests `\BookInfoPage` and `\BookFullInfoPage` need a one-line kernel `\def\Edition{}` in the preamble (not compiled, so unconfirmed); no lib way is needed |

## Content-opaque
none. Photographs passed to `\imagecell` and the page templates are content and are not shipped (the zip has no examples directory, README.md:47). `\pdfcommentcell` needs `pdfcomment`, which the class does not load (photobook.cls:661 is commented out, 5612 calls `\pdfcomment`); DEPENDS.txt:16, 29, 30 still lists `pdfcomment`, `mdframed` and `flowfram` although photobook.cls:661, 688, 691 comment them out (the list is built by a grep that also matches comments, Makefile:252).

## Lib changes
- New ways proposed: none (every component maps to an existing way; `trimclip` is filed under `fig.adjustbox` as a sibling box package, considered as a separate way and not proposed)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
