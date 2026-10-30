no

# 0459-xduts: XDUTS (Xidian University TeX Suite)

- Unverified: read from the source, not compiled.
- Source: Source/0459-xduts/ (origin: https://mirrors.ctan.org/macros/xetex/latex/xduts.zip; licence: LPPL 1.3c)
- Kind: thesis (undergraduate and postgraduate thesis classes, plus an undergraduate thesis-proposal form)
- Lib: v4
- Engine: needs XeLaTeX (`xeCJK` is loaded by `xdufont` at xduts.dtx:1915 and used through ctex by the classes; `\setmainfont` and `\setCJKmainfont` calls at xduts.dtx:2246-2566; `unicode-math` for any non-CM maths font at xduts.dtx:2714; "XeLaTeX only" at xduts.dtx:176, 485)
- Look carried by: class (three CTAN classes `xduugthesis` `xdupgthesis` `xduugtp` and one CTAN package `xdufont`, all generated from xduts.dtx by xduts.ins:29-35; the only preamble in the zip is the manual's driver)
- Class origin: ctan (ctan.org/pkg/xduts read: "XDUTS", v6.2.7.2, LPPL 1.3c, maintainer note286)
- Main file: xduts.dtx (no standalone sample .tex exists; the .dtx holds a manual driver with `\documentclass{ctxdoc}` at xduts.dtx:22 and `\begin{document}` at xduts.dtx:157, and three minimal usage examples at xduts.dtx:331-342, 360-367, 399-406; other samples: none; xduts.pdf is the compiled manual, not read)
- Read: main yes (driver and all documentation text; the degree, department and major lists at xduts.dtx:1460-1720 are data and were only skimmed), zip-local classes and styles all (no .cls or .sty file is in the zip; their source is the code lines of xduts.dtx, read in full; the Chinese prose comments between the implementation code lines were not read)

## Verdict
The look is carried by three published CTAN classes (each loads `ctexbook` or `ctexart`) and the `xdufont` package, all set through one `\xdusetup{style/..., info/...}` key interface. Taken only as published class ways they would map with no proposals, and the body of the minimal examples is one `\chapter` (theses) or eight fixed `\section`s (proposal). The answer is `no` because the only complete document in the zip is the manual driver (xduts.dtx:17-165), analysed here as the documentation sample, and it patches `listings` internals (xduts.dtx:143-146), which no lib way expresses. The class code is heavy expl3 box, aux-parsing and package-internal patching; it is tagged `class` so a re-read that counts a published class as one opaque way can drop it, and the preamble-scope blocker then remains alone.

## Blockers
- `BESPOKE/preamble` manual driver adds `\lst@AddToHook{SelectCharTable}{...\lst@Literate...}` so `literate` takes effect for the `[LaTeX]TeX` language; it edits `listings` code instead of setting a parameter (xduts.dtx:143-146)
- `BESPOKE/class` cover, title page and statement pages are hand-laid expl3 `\vbox_to_ht:nn` and `\hbox_to_wd:nn` rows; widths are measured from the field values by `\@@_str_max_dim:Nn` and the block is centred with a computed skip (xduts.dtx:4369-4374, 6417-6484, 6545-6548, 6662-6717)
- `BESPOKE/class` list-of-figures and list-of-tables number widths are computed by reading `\jobname.lof` and `.lot` with `\file_get:nnN` and `\regex_extract_all:nnN` over `\contentsline` entries (xduts.dtx:7008-7043, 7063-7073, 7109-7112)
- `BESPOKE/class` a second, Chinese contents file `zh.toc` is fed by redefining `\chapter`, `\section`, `\subsection` and restoring them in the back matter (xduts.dtx:7336-7344, 7518-7544, 7684-7686)
- `BESPOKE/class` `\ref` and `\pageref` are redefined over hyperref's internal `\__hyp_get_anchor:n` with `xspace` (xduts.dtx:5762-5785)
- `BESPOKE/class` internals of other packages are patched when those are loaded: `\algocf@makecaption` of algorithm2e (xduts.dtx:5441-5491), `\fs@ruled` of algorithm (xduts.dtx:5401-5408), `\renewenvironment{algorithm}` with `\@float@setevery` (xduts.dtx:5244-5253)
- `BESPOKE/class` user command `\noauxwrite` switches `\if@filesw` off around its argument so citations are not written to the aux file (xduts.dtx:4386-4394)

## Class setting
- Class: `class.xduugthesis` (loads `ctexbook`; passes a4paper, zihao=-4, sub4section, linespread=1.625, fontset=none: xduts.dtx:1882-1893), `class.xdupgthesis` (same without `linespread`), `class.xduugtp` (loads `ctexart`). Class options are the `style/` keys (`\ProcessKeysOptions{xdu/style}`, xduts.dtx:4071). Base classes `class.ctexbook` and `class.ctexart` are tex-distribution-unbundled, source not read. The manual driver uses `class.ctxdoc` (not in the zip; ctan.org/pkg/ctxdoc is a 404 and ctan.org/pkg/ctex does not mention it, so its publication is not established here).
- Class-native vocabulary used: `\xdusetup{style/cjk-font, style/latin-font, style/math-font, style/language, style/bib-backend, style/remove-page, ...}` and `info/title, author, department, major, supervisor, student-id, abstract, abstract*, keywords, keywords*, bib-resource, appendix, acknowledgements` (xduts.dtx:517-538, 1979-2027, 2896-2955, 3241-3334, 3758-3864); ctex `\ctexset{chapter/format, name, number, beforeskip, afterskip, ...}`, `\zihao`, `\CJKfamily+`; `\anon[..]{..}` (xduts.dtx:3599-3603); `edubg` and `resresult` environments (xduts.dtx:7631-7662); English-thesis headings `\chapter{En}[Zh]` (xduts.dtx:1789-1794, 7521-7544).

## Component map
Evidence cells are xduts.dtx lines. Rows 1 to 31 are the template (classes and `xdufont`), read as the ways they are composed of; rows D1 to D16 are the manual driver.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class, undergraduate thesis | xduts.dtx:11, 1887-1893, 360-367 | `class.xduugthesis` | ctexbook, a4paper, zihao=-4, sub4section, linespread=1.625, fontset=none |
| class, postgraduate thesis | xduts.dtx:10, 1882-1893, 399-406 | `class.xdupgthesis` | ctexbook, same options without linespread; adds `info/degree`, `graduate-type`, `remove-page`, `anonymous` |
| class, thesis proposal form | xduts.dtx:9, 1891, 1893, 331-342 | `class.xduugtp` | ctexart; section titles fixed by the form (xduts.dtx:7923-7968) |
| base classes the xdu classes load | xduts.dtx:1890-1893 | `class.ctexbook`, `class.ctexart` | `\zihao`, `\ctexset`, `\CJKfamily+` are their vocabulary |
| paper size | xduts.dtx:1884, 1899 | `page.class-options` | a4paper |
| page geometry | xduts.dtx:4412-4434, 4444-4464, 4473-4496, 4507-4518 | `page.geometry` | ug main top=3cm bottom=2cm inner=3cm outer=2cm bindingoffset=1cm head=2cm foot=1cm; pg main top=3.14cm bottom=2.5cm inner=outer=2.5cm bindingoffset=0.5cm headheight=60pt headsep=10pt foot=0.75cm; named layouts main, main-sym, cover, nomargin; tp 3.17cm and 2.54cm, footskip=headsep=headheight=0 |
| Latin text fonts | xduts.dtx:2442-2566, 2573-2701 | `font.fontspec` | `\setmainfont` `\setsansfont` `\setmonofont` with BoldFont, SlantedFont, ItalicFont; Scale=MatchUppercase or MatchLowercase; Ligatures=CommonOff for mono; Path=fonts/; sets gyre tac tacn tcc thcs tll |
| CJK fonts | xduts.dtx:2246-2279, 2286-2376 | `lang.cjk` | `\setCJKmainfont` `\setCJKsansfont` `\setCJKmonofont`; FakeBold=3, FakeSlant=0.2; sets win adobe founder hanyi sinotype fandol |
| maths fonts | xduts.dtx:2711-2790 | `font.unicode-math` | `\setmathfont{file}`, `\setoperatorfont{\symup}`; `cm` loads nothing |
| headings | xduts.dtx:4680-4837, 4850-4988 | `head.class-native` | ug `\ctexset` chapter format sf zihao 3 centred, section rm zihao 4; pg chapter 3 centred, section -3 bold, before/after skips 24,18,12,12,12,12 and 18,12,6,6,6,6pt; name, number (`\chinese`, `\Roman`), aftername, indent keys |
| heading numbering depth | xduts.dtx:4673, 4850, 6191, 7450 | `num.secnumdepth` | secnumdepth=5; tocdepth 5 or 2 |
| counters | xduts.dtx:5186, 5886-5891, 5630-5631 | `num.counters` | `\theequation`=`\thechapter-\arabic{equation}`; figure, table, algorithm numbered with the appendix letter; `\thesubfigure`=(a) |
| appendix | xduts.dtx:5880-5903 | `num.appendix` | `\appendix`, `\appendixname` 附录 or Appendix, appendix files input from `info/appendix` |
| running head and foot | xduts.dtx:4603-4646 | `hf.fancyhdr` | `\fancyhf{}`; ug CE=title, CO=`\leftmark`, LE/RO=`\thepage`, headrule 0.75pt; pg CE=header string, CO=`\leftmark`, foot C=page, double head rule 0.5pt |
| page styles and numbering | xduts.dtx:6049, 6131, 7359, 7417-7418, 7485-7486, 7979 | `hf.pagestyle-kernel`, `pgnum.pagenumbering` | `\pagestyle{empty}` on covers; roman or Roman front matter, arabic body |
| page flow | xduts.dtx:4207, 4654-4659 | `pg.break`, `pg.flush` | `\cleardoublepage`; `\raggedbottom` or `\flushbottom` from `style/page-vertical-align` |
| paragraph and display spacing | xduts.dtx:4912, 6145, 7487-7488, 7548-7551 | `sp.lengths` | `\parindent`=2\ccwd, `\baselineskip`=20pt, display skips 12bp and 0bp |
| double head rule | xduts.dtx:4627-4635 | `sp.rule` | `\hrule` height 0pt, 2pt skip, two rules of `\headrulewidth` |
| underlines on cover | xduts.dtx:4174, 8016 | `mark.ulem` | `\CJKunderline` of `xeCJKfntef`, thickness 0.5pt (ug, pg) or 1pt (tp); the package is the parameter |
| cover, title page, statement pages | xduts.dtx:5924-6197, 6246-6779, 6829-6929, 7356-7412, 8141-8176 | `front.class-native` | field-driven pages: school code, logo `xdulogo.pdf` (xduts.dtx:5958-5962), title, author, supervisors, dates; scan page or signature images by `includegraphics`; zh and en title pages |
| abstracts and keywords | xduts.dtx:4337-4351, 6136-6185, 6940-7000 | `abs.class-native`, `abs.keywords` | zh and en abstract files from `info/abstract`, `abstract*`; keyword `list` environment with measured label width, separators 2em plus 1em, `，`, `,~` |
| acknowledgements and author biography | xduts.dtx:7571-7578, 7722-7782 | `front.dedication` | chapter-like unnumbered heads, files from `info/acknowledgements`, `info/bio` |
| contents | xduts.dtx:5001-5133, 6195, 7448-7466 | `toc.tocloft`, `toc.kernel` | `tocloft[titles]`, `\cftchapfont` and friends = rm or sf, `\zihao{-4}`; `\@starttoc{toc}` |
| lists of figures and tables | xduts.dtx:7052-7121 | `toc.kernel`, `toc.tocloft` | `\cftfignumwidth` and `\cfttabnumwidth` from computed widths (blocker) |
| symbol and abbreviation lists, biography table | xduts.dtx:7129-7329, 7631-7643 | `tbl.nicematrix` | tabularray `longtblr` and `tblr`, colspec `Q[l,h]X[l,h]` and `Q[l,h]X[l,h]X[l,h]`, rowhead, abovesep=0pt |
| biography results list | xduts.dtx:7650-7662 | `list.enumitem` | `\SetEnumitemKey{resresult}` label=[\arabic*], left, align=right, parsep=itemsep=topsep=0pt |
| keyword list | xduts.dtx:4343-4351 | `list.kernel` | kernel `list` with labelwidth, labelsep=0, leftmargin |
| figures and sub-figures | xduts.dtx:1908, 5578-5631 | `fig.graphicx`, `fig.subcaption` | graphicx; figure and table aligned by `\@floatboxreset` hooks (left, centering, right); subfig and subcaption adapted when loaded |
| captions | xduts.dtx:5313-5387 | `cap.caption` | strut=off, labelsep=customskip (0.75em), font=`\zihao{5}`; format=hang or plain; singlelinecheck, justification=centerlast or justified; algorithm ruled strut=off |
| table fonts and float defaults | xduts.dtx:5198-5199, 5669-5714 | `fig.placement`, `font.size-commands` | topfraction=floatpagefraction=.8; `\small` on table, longtable, tblr, longtblr |
| long tables | xduts.dtx:5683-5693 | `tbl.longtable` | `longtable` hook adds `\small` when loaded |
| algorithms | xduts.dtx:5227-5298, 5423-5493 | `alg.algorithmicx`, `alg.algorithm2e` | `algorithm[chapter]`, `algorithm2e[algochapter]`; `\SetAlFnt`, `\SetAlCapFnt`, `\zihao{5}`; hang and align options |
| PDF metadata and links | xduts.dtx:5730-5748 | `meta.hyperref` | bookmarksnumbered, hidelinks, pdftitle, pdfauthor, pdfsubject, pdfcreator |
| cross references | xduts.dtx:5762-5785 | `xref.kernel` | `\ref` and `\pageref` wrapped with `\xspace` (blocker) |
| bibliography | xduts.dtx:5810-5844, 7590-7599 | `bib.biblatex-biber`, `bib.natbib`, `bib.bibtex-bst` | default biblatex `style=gb7714-2015`, `\printbibliography`; or `gbt7714[sort&compress]` with `gbt7714-numerical`, `\bibliography`; `\bibfont` `\zihao{5}`, `\bibitemsep`=0pt |
| proposal boxes | xduts.dtx:7811-7895 | `box.tcolorbox` | `tcolorbox[breakable]`; standard jigsaw, sharp corners=all, colframe=black, boxrule=0.5pt, boxsep=0pt, top/bottom/left/right=5pt; styles tpboxi, tpboxii, tpboxiii (height=.5\textheight) |
| proposal headings | xduts.dtx:7985-8008 | `head.class-native` | section name `,、`, number `\chinese`, format `\zihao{-4}`, skips 0pt and 8pt |
| D1 manual class | xduts.dtx:22 | `class.ctxdoc` | no options |
| D2 documentation macros | xduts.dtx:23-28, 160, 193, 500-515 | `dtx.doc` | `\DocInput{\jobname.dtx}`, `\OnlyDescription`, `\changes`, `function` `syntax` `optdesc` environments |
| D3 manual page and contents | xduts.dtx:26-27, 31-36, 195-198 | `page.geometry`, `toc.tocloft`, `toc.kernel` | hmargin={0mm,10mm}; `\cftsecindent` 0 to 4em; `\@starttoc{toc}` |
| D4 manual headings | xduts.dtx:37-45 | `head.class-native`, `num.secnumdepth` | `\ctexset{secnumdepth=5, subparagraph={afterskip, runin=false}, punct=quanjiao}`, tocdepth 5 |
| D5 manual captions and tables | xduts.dtx:48-60, 559-583 | `cap.caption`, `fig.subcaption`, `tbl.nicematrix` | font=bf, labelsep=customskip .75em; `\SetTblrOuter`, `\SetTblrStyle`, `\DefTblrTemplate` |
| D6 manual fonts and symbols | xduts.dtx:46-47, 100-103, 149 | `font.fontspec`, `font.icons` | `\newfontfamily{\ffmfamily}[Scale=MatchUppercase]{ffmb10.otf}` (font not shipped); `pifont` `\ding{51}`, `fontawesome5`, `\hologo` |
| D7 manual lists and floats | xduts.dtx:105, 107-109, 147 | `list.enumitem`, `fig.placement` | `\setlist[arguments]`; table placement htbp, `\floatpagefraction`=.8 |
| D8 manual code listings | xduts.dtx:113-141 | `code.listings` | `\lstset{language=[LaTeX]TeX, gobble=1, basewidth=0.5em, breaklines, basicstyle=\small\ttfamily, backgroundcolor, texcsstyle, texcs, emph, literate}` plus the patch (blocker) |
| D9 manual watermark | xduts.dtx:152-156 | `bg.watermark` | `draftwatermark[firstpageonly=true]`, angle=45, fontsize=40pt, color gray9!25; text repeated by `\prg_replicate:nn` (reducible by expansion) |
| D10 manual title, abstract, footnotes | xduts.dtx:168-191, 96-97 | `front.maketitle`, `abs.kernel`, `fn.kernel`, `meta.url` | `\title` `\author` `\date` `\maketitle`; two `abstract` environments; `\footnote{\url{..}}` |
| D11 manual long-string breaks | xduts.dtx:83-94 | `sp.hyphenat` | `seqsplit` `\seqsplit{}` (a break-anywhere package of the same type; nearest home) |
| D12 manual alias commands | xduts.dtx:64-103 | `xref.kernel`, `mark.kernel` | `\NewDocumentCommand` aliases over `\ref`, `\texttt`, `\meta`, `\marg` |
| D13 manual QR figure | xduts.dtx:266-286 | `fig.subcaption`, `art.tikz` | `subcaptionbox` with a `qrcode` picture in `tikzpicture` (picture is content) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| font selection tables and `\@@_select_font:nn` | xduts.dtx:2058-2806 | yes | each choice resolves to fixed `font.fontspec`, `lang.cjk`, `font.unicode-math` calls with the names and files read above |
| `\@@_lang_switch:nn`, `\anon`, `style/remove-page` booleans | xduts.dtx:4118-4123, 3599-3603, 3523-3563 | yes | constant folding: emit the chosen branch or omit the page |
| `\@@_zh_today:`, `\@@_en_submit_date:` | xduts.dtx:6358-6409 | yes | print `\the\year`, `\the\month` (or the given date) in the Chinese or English pattern; `front.class-native` |
| `\input`, `\include`, `\includegraphics` rewrites and search path | xduts.dtx:5150-5178 | yes | write the paths with the `./` prefix in the emitted calls |
| figure and table alignment hooks | xduts.dtx:5578-5659 | yes | `\centering` or `\raggedright` inside each float (`sp.ragged`) |
| `\@@_str_max_dim:Nn` with cover, title page and statement rows | xduts.dtx:4369-4374, 5924-6197, 6417-6779, 6829-6929 | no | layout computed from measured field widths and field emptiness; no lib way |
| `\@@_loft_label_num_width:nN` | xduts.dtx:7008-7043 | no | parses the `.lof` and `.lot` files to size the number column |
| `zh.toc` feed (`\@@_add_zh_toc:nn`, redefined `\chapter` `\section` `\subsection`) | xduts.dtx:7336-7344, 7518-7544 | no | hand-rolled second contents list |
| `\ref` and `\pageref` redefinition | xduts.dtx:5762-5785 | no | reads a hyperref internal to decide spacing |
| algorithm and algorithm2e caption and float patches | xduts.dtx:5244-5253, 5401-5408, 5441-5491 | no | rewrites package internals |
| `\noauxwrite` | xduts.dtx:4386-4394 | no | switches `\if@filesw` around its argument |
| driver `\lst@AddToHook{SelectCharTable}{...}` | xduts.dtx:143-146 | no | edits listings internals; `literate` alone does not do it |
| driver alias commands `\secrefx` `\optx` `\csx` ... | xduts.dtx:64-103 | yes | inline expansion into `\ref`, `\texttt`, `\seqsplit` |
| driver watermark text, hex-decoded strings | xduts.dtx:154-156, 236-265 | yes | expand to the literal text (the strings are content) |
| driver `\renewcommand{\fps@table}{htbp}` | xduts.dtx:107-109 | yes | a float placement default, `fig.placement` |

## Content-opaque
- `qrcode` pictures inside `tikzpicture` in the sponsor figure (xduts.dtx:270-286); the hex-encoded contact and payment link strings behind them (xduts.dtx:236-265) are content and were not decoded.
- Student-supplied scans and signature images included by `\includegraphics` from `info/statement-scan`, `info/statement-sign`, `info/sign` (xduts.dtx:6801, 7404-7406, 7877).
- Missing assets: the Windows, Adobe and other CJK and Latin font files named at xduts.dtx:2286-2376, 2573-2701 are not shipped; `xdulogo.pdf` is shipped in the zip root but is Xidian University's copyright (xduts.ins:23), and the class looks for it beside the class file (README.md:73, xduts.dtx:5958); `ffmb10.otf` (xduts.dtx:100) is not shipped.
- No text addressed to an AI was found in the zip.

## Lib changes
- New ways proposed: none (the font package `xdufont` reduces to `font.fontspec`, `lang.cjk`, `font.unicode-math`; `xeCJKfntef` underlines go to `mark.ulem`; `seqsplit` goes to `sp.hyphenat`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
