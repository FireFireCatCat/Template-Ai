yes

# 0104-sjtutex: SJTUTeX (Shanghai Jiao Tong University document classes `sjtuthesis`, `sjtureport`, `sjtuarticle`)

- Unverified: read from the source, not compiled.
- Source: Source/0104-sjtutex/ (origin: https://mirrors.ctan.org/macros/latex/contrib/sjtutex.zip; licence: lppl1.3c; README.md:13 says the SJTU visual-identity images, the `sjtu-vi-*.pdf` files, stay SJTU copyright)
- Kind: thesis (the same package also ships a report class and an article class)
- Lib: v2
- Engine: pdfLaTeX-compatible for `lang` zh/en/de (engine check accepts pdfTeX, sjtutex.dtx:1720-1726; manual sjtutex.dtx:545), but XeLaTeX or LuaLaTeX is the recommended path and is required for `lang=ja` (:727-729), the `xits`/`newcm`/`cambria` font sets (:752, :2760-2762, :2813-2815) and direct PDF with most `cjk-font` sets (:696-698). Manifest hint: xelualatex.
- Look carried by: class (the zip is the DocStrip source of three published classes; the look is the derived `.cls` plus the preset, lang, scheme and font `.def` files, all generated from the unprefixed lines of sjtutex.dtx; the documentation examples add only options and `\sjtusetup` values)
- Class origin: ctan (ctan.org/pkg/sjtutex read once: SJTUTeX 2.3.1, 2026-02-26, LPPL 1.3c, in TeX Live and MiKTeX, classes `sjtuthesis` `sjtuarticle` `sjtureport`; matches sjtutex.dtx:182 and :261; the dtx itself says so at :404-409)
- Main file: sjtutex.dtx (no .tex sample exists; the documentation examples at sjtutex.dtx:492-509, :516-526, :533-540 stand in for one; the doc driver at :264-343 is a `ctxdoc` build file for the manual, not a template sample) (other: README.md, CHANGELOG.md; sjtutex.pdf and the ten `sjtu-vi-*.pdf` image files are binary and were not read)
- Read: main yes (sjtutex.dtx lines 1-6236 read in full, every guarded block), zip-local classes and styles all (no separate .cls, .sty or .def ships: they are generated from the dtx by DocStrip, install list at :50-90; the `ctexbook`/`ctexrep`/`ctexart` base classes and the loaded packages are not in the zip and their sources were not read)

## Verdict
The zip is the DocStrip source of `sjtutex`, a package published on CTAN, TeX Live and MiKTeX (sjtutex.dtx:404-409), so the three classes are published (W1) and are three class ways: `class.sjtuthesis`, `class.sjtureport`, `class.sjtuarticle`, each on top of the ctex class `class.ctexbook`, `class.ctexrep`, `class.ctexart` (sjtutex.dtx:2216-2221). An emitter writes `\documentclass[type=master,lang=zh]{sjtuthesis}`, a `\sjtusetup{info=..., style=..., name=...}` call and the class's own front-matter, abstract and back-matter commands, and copies no macro logic. Nothing in the zip is unpublished, so nothing is bespoke under the rubric and there is no artwork or external tool in the always-loaded path. This is evidence about the class dimension, not about the component ways; the class's internal code is still listed below, with the parts that would be irreducible if the class were decomposed instead of used as a way.

## Blockers
none

Recorded, not counted:
- Not EXTERNAL: no package that needs a tool outside TeX is loaded unconditionally (always-loaded list sjtutex.dtx:2227-2239 plus the ctex class, :2216-2221). The only outside tool is on the pdfTeX path: most `cjk-font` sets need a DVI run and DVIPDFMx there (:696-698); XeLaTeX and LuaLaTeX avoid it. `latexmk` is only a recommendation (:548-556).
- Missing assets: the system CJK and Latin fonts named in the font files (Windows, macOS, Adobe, Founder, Hanyi, Cambria, Times New Roman, Fandol, TeX Gyre; :2876-3161, :2622-2624, :2659-2666) are not shipped; the ten SJTU logo and badge PDFs are shipped (README.md:13).
- `pageslts` (:3384) and `pdfpages` (:5214, :5232) are not loaded by the class; the user loads them when page "X of Y" or an external copyright scan is wanted.

## Class setting
- Class: `class.sjtuthesis` options: `type=bachelor|master|doctor` (default master, :1976-1981), `lang=zh|en|de|ja` (:1991-2002), `review` (:2105-2106), `baselineskip` (default 20 bp, :2012-2022), `text-font` (default newtx, :2029-2030), `math-font`, `cjk-font` (:2031-2032), `math-style` (ISO default, :2048-2062), `uppercase-greek`, `integral`, `integral-limits` (:2069-2098), `preset` (default base, :2114-2115), `draft`/`final`, `oneside`/`twoside`, `openright`/`openany`, `zihao`, `linespread` (documented :599-633, :650-670); every other option goes to `ctexbook` (:2121-2122, :2198-2203). Sample: `\documentclass[type=master]{sjtuthesis}` (:492).
- Class: `class.sjtureport` (sample :516, base `ctexrep`, adds `titlepage`/`notitlepage`, default `linespread=1.3`, :1915-1922) and `class.sjtuarticle` (sample :533, base `ctexart`, no `\chapter`). Same package, same option keys minus the thesis-only ones (`type`, `review`).
- Class-native vocabulary used: preamble `\sjtusetup{info={zh/title, en/title, zh/author, en/author, ...}, style={float-num-sep=...}, name={achv=...}}` (:493-500, :855-868) and `\SetInfoEntry{lang}{key=label}` (:4496-4501); report/article `\title \author \date \subject \keywords` (:516-520, :4649-4652); body `\maketitle \copyrightpage[file,variant] \frontmatter \mainmatter \backmatter \tableofcontents[title,intoc,marking,lang] \listoffigures \listoftables \listofalgorithms \appendix \footnote \setbaselineskip` (:502-506, :5222, :5437, :5490); environments `abstract[lang=...]`, `abbreviation`, `nomenclature`, `acknowledgements`, `achievements`, `bibliolist`, `bibliolist*`, `resume`, `digest`, and the predefined theorem-like environments `assumption axiom conjecture corollary definition example exercise lemma problem proposition theorem` plus `remark` `solution` and `proof` (:5537-5720, :5974-5998); CJK switches `\songti \heiti \kaishu \fangsong \mincho \gothic \CJKrmfamily \CJKsffamily \CJKttfamily` (:2994-2995, :3162-3165, :3191-3193); ctex `\zihao{}`.

## Component map
Each row names the lib way that realises the part inside the class; an emitter reaches all of them with the one class line. The base-class and package internals (ctex, fancyhdr, titletoc, caption, enumitem, amsthm) are inferred from the commands the dtx calls, since their sources are not in the zip. Paths below are all sjtutex.dtx.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | sjtutex.dtx:184-188, :2216-2221 | `class.sjtuthesis` `class.sjtureport` `class.sjtuarticle` | each `\LoadClass` of its ctex base |
| base class | sjtutex.dtx:2198-2203, :1915-1922 | `class.ctexbook` `class.ctexrep` `class.ctexart` | `UTF8`, `zihao=-4` (thesis, report), `linespread=1.3` (report, article), `scheme=plain`, `fontset=none` |
| paper, language class options | sjtutex.dtx:2164-2166 | `page.class-options` | `a4paper` put first; `german,ngerman` appended for `lang=de` |
| page geometry | sjtutex.dtx:3298-3306 | `page.geometry` | vmargin={3.5cm,4cm}, hmargin=2.5cm, bindingoffset=0.5cm (thesis only), headheight=1.5cm, headsep=0.5cm, footskip=1cm |
| copyright-page geometry | sjtutex.dtx:5172-5176, :4791 | `page.geometry` | `\newgeometry{margin=3cm,bindingoffset=0.5cm}`, `\restoregeometry` |
| vertical alignment | sjtutex.dtx:3313 | `pg.flush` | `\raggedbottom` (thesis) |
| page breaks | sjtutex.dtx:3477-3485, :4778-4779 | `pg.break` | `\cleardoublepage` redefined so a forced blank even page is empty, `\clearpage` |
| external copyright scan | sjtutex.dtx:5232-5241 | `pg.include-pdf` | `\includepdf[options]{file}`, user loads `pdfpages` |
| running heads and foot | sjtutex.dtx:3322-3327, :3417-3426 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\fancyhead[LO,RE]`/`[LE]`/`[RO]`/`[L]`/`[R]`, `\fancyfoot[C]`, `\fancyheadinit`, `\fancyfootinit` |
| header text and logo | sjtutex.dtx:3400-3410 | `hf.fancyhdr` `fig.graphicx` | thesis: subject line in `\songti`; report/article: `\includegraphics[height=1.2cm]{sjtu-vi-logo-std-h-cor-red.pdf}` |
| head rule | sjtutex.dtx:3433-3439 | `hf.fancyhdr` `sp.rule` | thesis `\headrule`: `\hrule` 2.25 pt, gap 0.75 pt, `\hrule` 0.75 pt |
| plain page style | sjtutex.dtx:3448-3466 | `hf.fancyhdr` | `\fancypagestyle{plain}`: header only, `\headrulewidth` 0 pt (report, article) |
| title-page footer | sjtutex.dtx:4884-4897 | `hf.pagestyle-kernel` | custom `\ps@SJTU@fund` built on `\ps@empty`: fund list in `\@oddfoot`, `\zihao{-5}` |
| header and footer fonts | sjtutex.dtx:3333-3343 | `font.size-commands` | `header-font` `\zihao{-5}` (+`\sffamily` for report/article), `footer-font` `\zihao{-5}` |
| page numbers | sjtutex.dtx:3493, :3500-3505 | `pgnum.pagenumbering` | thesis starts `Alph`, `\frontmatter` switches to `Roman` |
| page X of Y | sjtutex.dtx:3377-3393, :5855-5861 | `pgnum.lastpage` | `pageslts`, key `style/page-number` with `#1`, `#2` |
| body size and leading | sjtutex.dtx:2249-2250, :2277-2335 | `font.size-commands` `sp.lengths` | `\setbaselineskip` = `\fontsize{\f@size}{#1}\selectfont`; `\normalsize` re-set to baselineskip 20 bp with the kernel display skips for 10/11/12 pt |
| line spread | sjtutex.dtx:1919, :3645 | `sp.linespread` | ctex `linespread=1.3` (report, article); `\linespread{}` in equations |
| paragraph indent | sjtutex.dtx:3614-3617 | `head.class-native` | ctex `autoindent=true` (zh), `1.5em` (en, de), `1` (ja) |
| first paragraph indent | sjtutex.dtx:3579-3596 | `head.class-native` | `style/indent-first` sets ctex `afterindent` on chapter..subparagraph |
| fonts, Latin text | sjtutex.dtx:2738-2756 | `font.newtx` `font.mathptmx` `font.libertine` `font.family-default` `font.fontenc-t1` | pdfTeX path: `newtxtext` (+ `\qhv@scale` 0.94, `\sfdefault` qhv, `\ttdefault` qcr), `ptm/phv/pcr`, `LibertinusSerif-TLF`, `lmr`, `stix2`; `\encodingdefault` T1 (:2732, :2743) |
| fonts, Latin text (Pagella) | sjtutex.dtx:2469, :2739, :2741 | `font.palatino` | `newpxtext`/`newpxmath` (same family as `mathpazo`), `\rmdefault` zplTLF |
| fonts, math (pdfTeX) | sjtutex.dtx:2463-2479, :2481-2515, :2766-2809 | `font.newtx` `font.mathptmx` `font.lmodern` `font.libertine` `font.nfss` `math.amssymb` | `newtxmath`/`newpxmath`; `mathptmx`+`upgreek`+`\DeclareMathAlphabet`; Latin Modern via `\SetSymbolFont`/`\SetMathAlphabet`; `libertinust1math`; `stix2[notext]`; `cmupint` for upright integrals |
| fonts (Unicode engines) | sjtutex.dtx:2584-2727 | `font.fontspec` | `\setmainfont`/`\setsansfont`/`\setmonofont` with `Extension`, `UprightFont`, `BoldFont`, `Scale=0.94`, `SizeFeatures`, `FakeSlant` for TeX Gyre, STIX Two, XITS, Libertinus, Cambria, New CM, Times New Roman |
| math fonts (Unicode engines) | sjtutex.dtx:2522-2582, :2824-2845 | `font.unicode-math` | `\setmathfont{...}` with `StylisticSet`, `range`; `math-style=ISO`/`TeX`; `\bm`, `\boldsymbol` set to `\symbf`; integral limits via `\addnolimits`/`\removenolimits` |
| CJK fonts | sjtutex.dtx:2870-3161 | `lang.cjk` `font.fontspec` | xeCJK/ctex `\setCJKmainfont`, `\setCJKsansfont`, `\setCJKmonofont`, `\setCJKfamilyfont` with `AutoFakeBold=3`, `BoldFont`, `ItalicFont`, for windows, mac, ubuntu, adobe, fandol, founder, hanyi; ja variants `jamin`, `jagoth` |
| CJK char class | sjtutex.dtx:3199-3209 | `lang.cjk` | xeCJK `\xeCJK_declare_char_class:nn`, LuaTeX-ja `\ltjdefcharrange` for circled digits |
| math packages | sjtutex.dtx:2229-2230, :2851-2861 | `math.mathtools` `math.amsmath` `math.bm` `math.amssymb` | `mathtools` always; `bm`, `upgreek`, `amsfonts` when `unicode-math` is absent; `amssymb`/`amsfonts`/`bm`/`upgreek` blocked when `unicode-math` loads (:2842-2844) |
| equation font and spacing | sjtutex.dtx:3642-3676 | `math.amsmath` `font.size-commands` | `style/equation-font` (thesis default `\linespread{}\SJTU@orig@normalsize`) injected into `array`, `matrix`, `cases`, `aligned`... and `\start@align` |
| numbering depth | sjtutex.dtx:3572 | `num.secnumdepth` | ctex `secnumdepth=3` |
| chapter headings | sjtutex.dtx:3515-3535, :3539-3541 | `head.class-native` | ctex `chapter`: thesis beforeskip/afterskip 27 bp, `\zihao{3}\setbaselineskip{20bp}\bfseries\CJKsffamily\centering`; report 30 pt/24 pt `\Large`; `aftername=\quad`; zh/ja name `第 ... 章` |
| section headings | sjtutex.dtx:3543-3571 | `head.class-native` | ctex `section` (24 bp/6 bp, `\zihao{4}`), `subsection` (12 bp/6 bp, `\zihao{-4}`), `subsubsection` (6 bp/6 bp); report/article `\large`/normal size with `\bfseries\CJKsffamily` |
| marks, font switches | sjtutex.dtx:3522, :3548 | `mark.kernel` | `\bfseries`, `\normalfont`, `\centering` inside the heading formats |
| caption and name strings | sjtutex.dtx:3249-3291, :4244-4314 | `lang.cjk` | ctex name keys `contentsname`, `figurename`, `bibname`... per `lang`; `part`, `chapter` names |
| language | sjtutex.dtx:2165-2166, :4057-4060 | `lang.babel` | class only appends `german,ngerman` and sets `\languagename`; babel itself is not loaded by the class |
| spacing of lists | sjtutex.dtx:3633 | `list.enumitem` | `\setlist{nosep}` |
| quotation and verse | sjtutex.dtx:3623-3625 | `quote.kernel` | `\quotation` indent set to `\parindent`; `\verse` indent `2\ccwd` (zh, ja) |
| list-of-achievements env | sjtutex.dtx:5580-5666 | `bib.thebibliography` `list.kernel` | `bibliolist`/`bibliolist*`: kernel `\list` with `\@biblabel{\arabic{SJTU@bib}}`, widest label argument, `resume` key |
| list penalties, sloppy | sjtutex.dtx:5633-5637 | `sp.penalties` `sp.hyphenat` | `\clubpenalty`/`\widowpenalty` 4000, `\sloppy`, `\sfcode` of period |
| title page (thesis) | sjtutex.dtx:4756-4792, :4902-5025 | `front.class-native` | `\maketitle` makes one page per language in `lang` list; style A (zh): badge 3 cm, subject `\zihao{-2}`, title `\zihao{2}\bfseries`, info table, date; style B (others) |
| title-page logo | sjtutex.dtx:4906-4910 | `fig.graphicx` | `\includegraphics[width=3cm]{sjtu-vi-badge-reg-red.pdf}` |
| title-page info table | sjtutex.dtx:4815-4853, :4870-4878 | `tbl.tabular` | `tabular` with `\newcolumntype` (`w{s}{5em}`, `r`, `>{\linespread{0.75}\normalfont}l`), rows from the ordered `info` keys |
| title block (report, article) | sjtutex.dtx:1020-1054, :4636-4652 | `front.maketitle` `front.class-native` | `\title \author \date` kernel; `\subject`, `\keywords` class-native; `titlepage`/`notitlepage` |
| dates | sjtutex.dtx:4659-4681 | `front.class-native` | `\today` re-set from an ISO `yyyy-mm-dd` string into zh/en/de/ja text |
| declaration pages | sjtutex.dtx:5035-5076, :5169-5183, :5222-5249 | `front.dedication` | `\copyrightpage[file=,variant=a|b]`: original-work statement and authorisation sheet, signature boxes, `\newgeometry` |
| acknowledgements, resume, abbreviation, nomenclature | sjtutex.dtx:5537-5571, :5673-5681 | `front.dedication` `head.class-native` | environments with heading keys `intoc`, `title`, `marking`, `lang` through `\SJTU@heading` (:5308-5338); `review` mode hides acknowledgements and resume |
| abstract | sjtutex.dtx:5367-5373 | `abs.class-native` | thesis `abstract[lang=...,title,intoc,marking]`; heading from `c_@@_name_abstract` |
| abstract (report, article) | sjtutex.dtx:5379-5380 | `abs.kernel` | ctex `abstract`, `\par` hook after it in `titlepage` mode |
| keywords line | sjtutex.dtx:5348-5356, :5388-5423 | `abs.keywords` | appended after `abstract`; `keywords-format=plain|hang` (`\noindent\bfseries` or `\@hangfrom`) |
| digest (big abstract) | sjtutex.dtx:5697-5720 | `abs.class-native` | bachelor `digest[lang=en]` at `\AtEndDocument`, own `roman` numbering |
| contents | sjtutex.dtx:5437-5443, :5452-5468 | `toc.kernel` `toc.titletoc` | `\contentsmargin[2.55em]{0pt}`, `\titlecontents{chapter}[0pt]{\addvspace{6bp}\bfseries}{\contentspush{\thecontentslabel\enskip}}{}{\titlerule*[4bp]{.}\thecontentspage}`, section `[2em]`, subsection `[4em]` |
| lists of figures, tables, algorithms | sjtutex.dtx:5478-5493, :5503-5526 | `toc.kernel` `toc.titletoc` | `\listoffigures` `\listoftables` through `\SJTU@listof`; `\titlecontents` with label prefix and common width |
| appendix, matter | sjtutex.dtx:1469-1474, :3496-3506 | `num.appendix` `class.ctexbook` | `\appendix`; `\frontmatter` redefined (`\@mainmatterfalse`, `Roman`) |
| counters, numbering | sjtutex.dtx:3790-3829 | `num.counters` | `\SJTU@counterwithin{figure|table|equation}{chapter}` with separator `.` (keys `num-sep`, `float-num-sep`, `equation-num-sep`, `theorem-num-sep`) |
| footnotes | sjtutex.dtx:3848-3924, :3940-3950 | `fn.kernel` `num.counters` | `fnmark-style=plain|circled` (circled default for zh, ja, from Unicode codepoints up to 50), `fnmark-font`, `\@makefntext` patched |
| float placement | sjtutex.dtx:3704-3707 | `fig.placement` | `\textfraction` 0.15, `\topfraction` 0.85, `\bottomfraction` 0.65, `\floatpagefraction` 0.60 |
| float font | sjtutex.dtx:3714-3730 | `font.size-commands` | `\@floatboxreset` patched: `\zihao{5}` and (thesis) `\setbaselineskip{14bp}` |
| captions | sjtutex.dtx:3738-3782, :2234-2236 | `cap.caption` `fig.subcaption` | `caption`+`bicaption`+`subcaption`: `labelsep=quad`, `skip=6bp` (thesis), `bi-slc`, sub `format=hang`; `\DeclareCaptionFont` for caption font `\zihao{5}\bfseries` and sub font |
| tables | sjtutex.dtx:2229, :5882-5890 | `tbl.tabular` `tbl.threeparttable` `tbl.longtable` | `array` always; `threeparttable` note size `\footnotesize`; `longtable` font hook (conditional on the user loading them) |
| theorem-like statements | sjtutex.dtx:5974-5998, :6004-6040 | `thm.amsthm` `thm.kernel` | `\newtheorem{...}{name}[chapter]`, `remark`/`solution` starred, `\newtheoremstyle{sjtu}` with header font `\bfseries\CJKsffamily`, body `\normalfont`, `\ccwd` space; `proof` redefined; created only if the user loads `amsthm` |
| theorem-like statements (alt) | sjtutex.dtx:6045-6061 | `thm.ntheorem` | `\theoremheaderfont`, `\theorembodyfont`, `\theoremseparator`, `\qedsymbol`; loaded with `amsmath,thmmarks` (:1941) |
| list of theorems | sjtutex.dtx:6069-6103 | `thm.thmtools` | `\listoftheorems` re-defined on `titlecontents` |
| algorithms | sjtutex.dtx:6125-6163 | `alg.algorithmicx` `alg.algorithm2e` | `\floatname`, `\SetAlgorithmName`, `\SetAlgoCaptionSeparator`, `\listofalgorithms` (conditional on the user loading the package) |
| nomenclature, units | sjtutex.dtx:6177-6179, :6193-6228 | `idx.glossaries` `mark.siunitx` | `\nomname`; `siunitx` list and range phrases per language |
| hyperlinks, bookmarks | sjtutex.dtx:5787-5828 | `meta.hyperref` | `\hypersetup{linktoc=all, bookmarksdepth=2, bookmarksnumbered, bookmarksopen, bookmarksopenlevel=1, unicode, psdextra, breaklinks, pdfdisplaydoctitle}`, `pdftitle`, `pdfauthor`, `pdfsubject`, `pdfkeywords`; `\pdfbookmark` per page |
| colour | sjtutex.dtx:2224 | none | the class loads no colour package (v2.2.1 removed `xcolor`); logos are red inside the PDF images |
| bibliography | sjtutex.dtx:3260 | none | only the name `bib` is set; the bibliography package and `.bst` are the user's choice |

## Bespoke code
Nothing in the zip is unpublished, because the class is the CTAN release, so nothing is bespoke under the rubric. For re-reading, the class's own internals, if the class were decomposed instead of used as a way, would be:

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| expl3 option and key-value engine (`sjtu/option`, `sjtu/style`, `sjtu/name`, `sjtu/info`, groups) | sjtutex.dtx:1966-2123, :3249-3291, :4496-4554, :5733-5746 | no | would be `BESPOKE/class` |
| blind-review mode (`sensitive` key group, forced fields, hidden pages) | sjtutex.dtx:2184-2189, :4518-4523, :5224, :5565, :5651-5660 | no | would be `BESPOKE/class` |
| lttemplates page and element builder, one title page per language | sjtutex.dtx:4716-4792, :4902-5025, :5169-5183 | partly | per language `front.titlepage-env` + `font.size-commands` + `sp.manual-space` (`plus 1 fill`) + `tbl.tabular`; the per-language dispatch and instance copying is class logic |
| title info rows from an ordered, user-extensible field list | sjtutex.dtx:4452-4501, :4815-4853 | partly | fixed field list: `tbl.tabular`; dynamic list is class logic |
| circled footnote numbers from computed codepoints | sjtutex.dtx:3850-3866, :3915-3924 | no | would be `BESPOKE/class` |
| ISO date parsing and localised date text (regex, ordinals) | sjtutex.dtx:4078-4227, :4659-4681 | no | would be `BESPOKE/class` |
| `digest` big abstract at `\AtEndDocument`, counters reset, own page numbering | sjtutex.dtx:5697-5720 | no | would be `BESPOKE/class` |
| unified heading command (`\SJTU@heading`, `\CTEX@chapter@break`) | sjtutex.dtx:5308-5338 | no | would be `BESPOKE/class` |
| patches into amsmath, thmtools, algorithm2e and footnote internals | sjtutex.dtx:3653-3676, :3940-3950, :6069-6103, :6149-6163 | no | would be `BESPOKE/class` |
| package-load policy (`\disable@package@load` of amsfonts, amssymb, bm, upgreek, ntheorem, amsthm) | sjtutex.dtx:1786-1790, :2842-2844, :6034, :6047 | no | would be `BESPOKE/class` |
| `\normalsize` re-set with a fixed baselineskip | sjtutex.dtx:2277-2335 | yes | `font.size-commands` `\fontsize{12}{20}\selectfont` + `sp.lengths` display skips |
| `\cleardoublepage`, double `\headrule` | sjtutex.dtx:3433-3439, :3477-3485 | yes | `pg.break` + `hf.fancyhdr` + `sp.rule` |
| `bibliolist` environment | sjtutex.dtx:5590-5666 | yes | `list.enumitem` with `widest=`, `resume`, `sp.penalties` 4000 |
| `\SJTU@counterwithin` | sjtutex.dtx:3808-3820 | yes | `num.counters` (`\numberwithin`-style) |
| doc driver macros `\TNA \OPT \ENV`, `shell` and `latex` listings environments | sjtutex.dtx:283-327 | yes (out of scope: documentation only) | `code.listings` with `lstdefinestyle`, `color.xcolor` `\definecolor` |

## Content-opaque
none (no floats with artwork; the SJTU logo and badge PDFs are template images the class includes, sjtutex.dtx:3404-3405 and :4908-4909, and they ship in the zip)

## Lib changes
- New ways proposed: none. Considered and not proposed: `lttemplates` (kernel template mechanism, class-internal), `translations` (class-internal glue for `siunitx` words, sjtutex.dtx:6184-6228, not a component an emitter writes), `bicaption` (taken as a `caption`-family package under `cap.caption`), `upgreek`/`cmupint` (taken as symbol packages under `math.amssymb`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
