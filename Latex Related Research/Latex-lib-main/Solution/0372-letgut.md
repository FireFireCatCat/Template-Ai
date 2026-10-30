no

# 0372-letgut: letgut (class for the newsletter "La Lettre GUTenberg")

- Unverified: read from the source, not compiled.
- Source: Source/0372-letgut/ (origin: https://mirrors.ctan.org/macros/luatex/latex/letgut.zip; licence: LPPL 1.3c)
- Kind: newsletter
- Lib: v4
- Engine: needs LuaLaTeX (the class stops on any other engine, doc/letgut-code.tex:149-151; OpenType fonts through `fontspec`, doc/letgut.tex:5-8)
- Look carried by: mixed (class `letgut` carries page, banner, headings, contents, boxes, listings; the sample's `dbwarning`/`dbremark` boxes come from a file that is not shipped)
- Class origin: ctan (ctan.org/pkg/letgut read: LPPL 1.3c, v0.9.15 of 2026-02-28, in TeX Live and MiKTeX)
- Main file: doc/letgut.tex (the manifest names doc/letgut-code.tex, the literate source of the class; other samples: doc/letgut-code.tex, doc/letgut-banner-code.tex)
- Read: main yes (doc/letgut.tex 1-2086), zip-local classes and styles none present (the zip ships no `.cls`/`.sty`; their code was read partly through doc/letgut-code.tex and fully through doc/letgut-banner-code.tex)

## Verdict
No. The look is carried by the published CTAN class, which counts as one way (`class.letgut`), and nearly everything the usage sample shows is that class's own vocabulary or a published package it loads (tcolorbox, acro, etoc, listings, biblatex, floatrow). The sample still cannot be rebuilt completely: its 17 `dbwarning` and 4 `dbremark` boxes, 29 `\valinitdef` calls and the `dbwarninglist` list use names that no shipped file defines. The class reads an unshipped `localconf.tex` at the end of the preamble, so no reduction can be shown, and the rubric says `no` when it cannot be shown. The class internals (expl3 first-page, title, acronym and attachment logic; a banner drawn with `\put` and computed boxes) are irreducible, but the published-class ruling keeps them inside `class.letgut`; they are tagged `/class` below so another reading can count them. Not counted: Emacs org-babel tangling of `letgut.cls` (source/HOWTO.md:3-15) and the `xindex` index run, because an author installs the published class and an index processor is as ordinary as `makeindex` or biber. No text addressed to an AI was found in the zip.

## Blockers
- `BESPOKE/preamble` zip-local environments `dbwarning` (17 uses, first doc/letgut.tex:135-144) and `dbremark` (4 uses, first doc/letgut.tex:364), command `\valinitdef` (29 uses, first doc/letgut.tex:190) and list `dbwarninglist` (doc/letgut.tex:2051) are defined in no shipped file (grep over every `.tex`, `.org`, `.md`); the class inputs `localconf.tex` at the end of the preamble (doc/letgut-code.tex:4096-4107) and source/HOWTO.md:28-30 names it among files outside this zip; reducibility not shown
- `BESPOKE/preamble` `\input{listings-conf}` in the two code-documentation samples is a file the zip does not ship (doc/letgut-code.tex:8, doc/letgut-banner-code.tex:8; source/HOWTO.md:28-30); contents unknown
- `BESPOKE/class` first page, title and running-head logic: empty `\@title` test, own `\maketitle` emulation, `enlargethispage` arithmetic, ToC insertion (doc/letgut-code.tex:1527-1563, 1579-1810); inside published `class.letgut`, not counted
- `BESPOKE/class` extra heading levels `\title`/`\subtitle` with etoc level rewriting through a written file (doc/letgut-code.tex:1906-1980); inside the class, not counted
- `BESPOKE/class` acronym layer over `acro` (`\letgutacro`, template redefinition, `\footnote` redefinition, `\acro_locale:nnn` override) (doc/letgut-code.tex:2627-2839, 2705-2719); inside the class, not counted
- `BESPOKE/class` `\includegraphics` and `\inputarticle` redefinitions that attach files to the PDF (doc/letgut-code.tex:3112-3266); inside the class, not counted
- `BESPOKE/class` hand-built draft watermark (rotated box, `atand`) (doc/letgut-code.tex:1063-1105); inside the class, not counted
- `BESPOKE/class` biblatex `bookreview` driver and `letgut` data model and citation style (doc/letgut-code.tex:4134-4230); inside the class, not counted
- `ART/class` first-page banner: big "L" from `\rule`, letters placed by `\put`, sizes found by an `fp` loop (doc/letgut-banner-code.tex:340-650, 654-776); inside the published `letgut-banner.sty`, not counted
- `ART/class` announcement boxes with `\node` ornaments from `pgfornament` (doc/letgut-code.tex:1416-1421); inside the class, not counted

## Class setting
- Class: `class.letgut` options: none on `\documentclass`; the class forces `twoside,11pt` on `article` (doc/letgut-code.tex:652, doc/letgut.tex:156-158). Options go through `\letgutsetup{...}` (doc/letgut-code.tex:2040-2043; keys 1162-1228): `editorial=false`, `pagecolor={1,1,1}`, `detailedtoc=subsection`, `final` commented out (doc/letgut.tex:12-17).
- Class-native vocabulary used: `\letgutsetup`; `\title` (document title before `\begin{document}`, article level after it, doc/letgut.tex:61, 110, 129), `\author`, `\date`; `\letgutacro`; `\syntaxhl`; `\package` `\class` `\software` `\file` (starred forms); `\foreignloc` `\latinloc` `\Ucode`; `\person`; `\lettre` `\lettregut` `\lettrenumber` `\gutenberg` and the name shortcuts; `\schedule`; `\LKey` family; `ltx-code`, `ltx-code-result`, `ltx-code-external-result`; `\terminal`; `ctannews` with `\item*`; `\francophony`; `bookreview`; `announcement`; `rebus`, `\solution`, `\rebussolution`; `\alertbox`; `\separator`; `\vrefsection`; `\inputarticle`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | doc/letgut.tex:1; doc/letgut-code.tex:81, 652 | `class.letgut` | base article, twoside, 11pt fixed; keys via `\letgutsetup` |
| paper and size | doc/letgut-code.tex:652, 682 | `page.class-options` | twoside, 11pt (not overridable, doc/letgut.tex:156-158) |
| page geometry | doc/letgut-code.tex:212-220, 1335-1349 | `page.geometry` | a4paper, asymmetric, textheight=25cm, textwidth=14cm, lmargin=5cm, tmargin=2.92cm, head=0.6cm, headsep=0.82cm, marginparwidth=3.74cm |
| page colour | doc/letgut.tex:14; doc/letgut-code.tex:516-519, 1133, 1183-1198 | `color.pagecolor` | rgb list; default 1.0,0.98,0.94 (screen), 1,1,1 (paper); sample sets {1,1,1} |
| running head | doc/letgut-code.tex:1250-1276 | `hf.class-native` | `\headrulewidth`=0.03cm, `\headruleskip`=0.115cm, `\fancyhead[RO,LE]{\thepage}`, `[RE,LO]{\scshape mark}`, `\fancyheadoffset[L]`=3cm, `\pagestyle{fancy}` |
| running-head text | doc/letgut.tex:84-88; doc/letgut-code.tex:1553-1562 | `hf.class-native` | mark set to `\@title` by a begindocument hook (see Bespoke code) |
| paragraph spacing | doc/letgut-code.tex:674 | `sp.parskip-pkg` | no options |
| microtype | doc/letgut-code.tex:665-669 | `sp.microtype` | stretch=30, shrink=25, letterspace=150 |
| fonts | doc/letgut.tex:5-8; doc/letgut-code.tex:661 | `font.fontspec` | `\setmainfont{KpRoman}[Numbers=Lowercase]`, `\setsansfont{KpSans}`, `\setmonofont[Scale=MatchLowercase]{RobotoMono}` |
| pictogram and logo packages | doc/letgut-code.tex:690, 702, 718, 760, 798; doc/letgut.tex:115, 913-936, 1750 | `font.icons` | biolinum (`\LKey` keys), typicons, fourier-orns (`\aldineleft`), bxtexlogo/hologo (`\hologo`), eurosym[right], `\faCopy` (package not named in the sample) |
| colours | doc/letgut.tex:29, 308; doc/letgut-code.tex:714, 781, 3432-3441, 3511-3515 | `color.xcolor` | `[table]`, ninecolors, `\definecolor`, `\colorlet`, `\colorbox` |
| languages | doc/letgut-code.tex:790, 866, 926 | `lang.babel` | english, french; `\frenchsetup{CustomiseFigTabCaptions}`; `\frenchtablename`=Tableau |
| quotations | doc/letgut-code.tex:738; doc/letgut.tex:146, 604-608 | `lang.csquotes` | `\enquote`, `displayquote` |
| hyperlinks and PDF metadata | doc/letgut-code.tex:834, 1672-1701; doc/letgut.tex:1887-1894 | `meta.hyperref` | colorlinks, allcolors={letgut_allcolors_links} (draft with `paper`), pdftitle, pdfauthor |
| URLs | doc/letgut-code.tex:822; doc/letgut.tex:75 | `meta.url` | xurl, no options |
| non-selectable text | doc/letgut.tex:1746-1751; doc/letgut-code.tex:750 | `meta.accsupp` | `\BeginAccSupp{method=plain,ActualText={...}}` ... `\EndAccSupp{}` |
| PDF file attachments | doc/letgut.tex:384; doc/letgut-code.tex:772, 3208-3266 | `meta.attachfile` | `[icon=Paperclip]`, `\noattachfile[icon=Paperclip]`, class calls `\textattachfile[description,mimetype]{file}{icon}` |
| cross-references | doc/letgut.tex:111, 518-520 | `xref.kernel` | `\label`, `\ref` |
| smart page references | doc/letgut-code.tex:794; doc/letgut.tex:146, 442 | `xref.varioref` | nospace, french; `\vref`, `\vpageref` |
| named references | doc/letgut.tex:146; class use at doc/letgut-code.tex:2867 | `xref.hyperref` | `\nameref` |
| typed references | doc/letgut-code.tex:842, 1119-1120 | `xref.cleveref` | french; `\crefname{listing}` |
| float anchors | doc/letgut-code.tex:838 | `xref.hypcap` | all |
| title block | doc/letgut.tex:60-78; doc/letgut-code.tex:1527-1563, 1579-1810 | `front.class-native` | `\title`/`\author`/`\date` before the document give a title and a page break; without `\title`: "numéro N -- date"; `\texorpdfstring` in title |
| table of contents | doc/letgut.tex:12-17, 346-374; doc/letgut-code.tex:1287-1333, 1731-1740 | `toc.etoc` | etoc, `\etocsetstyle` per level (leftskip 2.5cm to 4.5cm, sizes `\small` to `\tiny`), `detailedtoc=subsection`, `\localtableofcontents` |
| section commands | doc/letgut-code.tex:1906-2030 | `head.titlesec` | `\titleclass{\title}{straight}[\part]`, `\titleformat`, `\titlespacing*` with left shifts from -3cm (`\title`) to 0 (`\subparagraph`), doc/letgut-code.tex:224-245 |
| article and sub-article levels | doc/letgut.tex:493-512; doc/letgut-code.tex:1906-1954 | `head.class-native` | `\title` (`\LARGE\bfseries`, upper case, ornament `\aldineleft`), `\subtitle` (`\Large\bfseries`, upper case) |
| heading numbers | doc/letgut-code.tex:1875 | `num.secnumdepth` | secnumdepth=-10 (unnumbered) |
| lists | doc/letgut.tex:137, 238, 424 | `list.kernel` | itemize, enumerate, description |
| custom list | doc/letgut-code.tex:706, 2055-2057; doc/letgut.tex:1261-1268 | `list.enumitem` | `\newlist{ctannews}{description}{1}`, `format`, `labelsep` |
| emphasis, weights | doc/letgut.tex:1525 | `mark.kernel` | `\textbf`, `\emph` |
| units and numbers | doc/letgut.tex:1722; doc/letgut-code.tex:755, 870-874 | `mark.siunitx` | locale=FR, mode=match, group-minimum-digits=4 |
| footnotes | doc/letgut.tex:116-117 | `fn.kernel` | `\footnote` (redefined by the class, doc/letgut-code.tex:2710) |
| margin notes | doc/letgut-code.tex:1285, 2075; doc/letgut.tex:1264 | `note.marginpar` | `\reversemarginpar`, `\marginpar` for the francophony logo |
| maths | doc/letgut-code.tex:742; doc/letgut.tex:294 | `math.mathtools` | fleqn; inline maths only in the sample |
| table | doc/letgut.tex:769-797 | `tbl.tabular` | `tabular{ll}` inside `table[htb]`, `\centering` |
| table rules | doc/letgut.tex:772-793; doc/letgut-code.tex:734 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| caption | doc/letgut.tex:795-796 | `cap.kernel` | `\caption`, `\label` |
| float layout | doc/letgut-code.tex:806, 883-919 | `fig.floatrow` | objectset=justified, margins=hangleft, capposition=beside, capbesideposition={top,left}, floatwidth=0.85\textwidth, `\FBaskip` `\FBbskip` |
| figures | doc/letgut-code.tex:686, 3208-3266 | `fig.graphicx` | `\includegraphics` redefined to attach the file |
| float barrier | doc/letgut-code.tex:726 | `fig.placement` | placeins `[section,above]` |
| standalone sub-files | doc/letgut-code.tex:768; doc/letgut.tex:1260 | `pg.standalone-pkg` | group=false, subpreambles, sort (result image `exemple-nouveautes-crop.pdf` not shipped) |
| alert box | doc/letgut.tex:1647-1670; doc/letgut-code.tex:484-486, 1354-1374, 786 | `tbl.nicematrix` | tabularray `tblr`: width=\linewidth, `Q[c,m,colour]`, vlines, hlines, rowsep=2.5mm, colsep=2.5mm, default colour gray9 |
| announcement | doc/letgut.tex:1495-1528; doc/letgut-code.tex:1379-1424 | `box.tcolorbox` | enhanced, sharp corners, boxrule=0mm, leftrule=1cm, skin=empty, `fonttitle=\scshape\bfseries\huge`, `toc title`, `color` (ornament nodes: ART/class) |
| rebus | doc/letgut.tex:1537-1642; doc/letgut-code.tex:1434-1518 | `box.tcolorbox` | float=bh, `rebus style`, `no solution`, `savelowerto`, `record`, `lowerbox=ignored`; `\tcbstartrecording` at doc/letgut.tex:1533 |
| code listing look | doc/letgut-code.tex:3373-3412; doc/letgut.tex:1186, 1205 | `code.listings` | basicstyle=\ttfamily, breaklines, escapechar=£, columns=fullflexible, keepspaces, upquote, `\lstMakeShortInline™`, aboveskip/belowskip 0pt plus 6pt |
| code example boxes | doc/letgut-code.tex:3522, 3712-3745, 3883; doc/letgut.tex:1042-1044, 1138-1171, 1765 | `code.tcblisting` | tcolorbox libs listings,breakable,skins,hooks,documentation; `DeclareTCBListing` envs; `tcblisting` with `listing only,breakable,listing options={style=tcblatex,language=bash}` |
| verbatim in notes | doc/letgut-code.tex:730; doc/letgut.tex:1805-1806 | `code.verbatim` | fancyvrb, no options |
| acronyms | doc/letgut.tex:51-58, 1873-1886, 2038-2045; doc/letgut-code.tex:818, 2836-2839 | `idx.glossaries` | acro: first-style=footnote, format/short=\scshape, foreign/display, locale/display; `\printacronyms[heading=title,display=all,exclude=thisdocument]` |
| index | doc/letgut.tex:569, 2055-2079; doc/letgut-code.tex:4350-4383 | `idx.makeidx` | `\index`, `\indexprologue`, `\printindex`; loading package not visible (`\makeindex[...]` with imakeidx-style keys is commented out, doc/letgut.tex:81-82); xindex Lua configuration shipped in the code document |
| bibliography | doc/letgut.tex:20, 113, 2047; doc/letgut-code.tex:810-814 | `bib.biblatex-biber` | sorting=none, datamodel=letgut, citestyle=letgut; `\addbibresource{letgut.bib}`, `\autocite`, `\printbibliography[heading=title]` |
| manual markup | doc/letgut.tex:178-216, 463-483, 959-988; doc/letgut-code.tex:3522 | `dtx.doc` | tcolorbox `documentation` library (`docCommand(s)`, `docKey(s)`, `docEnvironment(s)`, `\docAuxCommand`, `\refCom`); closest home, as `codedescribe` was merged |
| warning and remark boxes | doc/letgut.tex:135-144, 364, 515, 2051 | not mapped | `dbwarning`, `dbremark`, `\valinitdef`, `dbwarninglist`: definitions not shipped (blocker) |
| first-page banner | doc/letgut-banner-code.tex:654-776 | `class.letgut` | inside the class; ART/class |
| draft watermark | doc/letgut-code.tex:1063-1105 | `class.letgut` | inside the class; `draft` is the default |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\letgutdefaultpagecolor`, `\definecolor{letgutdefaultpagecolor}` | doc/letgut.tex:26-29 | yes | `color.xcolor` `\definecolor{...}{rgb}{1.0, 0.98, 0.94}`; the value is the class constant (doc/letgut-code.tex:516-517); the command only prints it in documentation text |
| `\letgutalertboxdefaultcolor`, `\letgutallcolorslinks` | doc/letgut.tex:31-37 | yes | print class constants `gray9` and `teal!60!black` (doc/letgut-code.tex:484-489); documentation text |
| `\docker` and `\pdfstringdefDisableCommands{\def\docker{Docker}}` | doc/letgut.tex:39-47 | yes | inline expansion to class-native `\software[https://docs.docker.com/]{Docker}`; bookmark string via `meta.hyperref` |
| running-head hook `\tl_gset:Nn \g__letgut_mark_tl {\@title}` | doc/letgut.tex:84-88 | yes, with a caveat | `hf.class-native` with the head text set to the title; one assignment to a class-private variable (used at doc/letgut-code.tex:1265, set at 1554-1562), no public key, so the emitter would print this line verbatim |
| `\int_gset:Nn \g__letgut_number_int {46}` | doc/letgut.tex:837-839 | yes | `\letgutsetup{number=46}` (key writes the same variable, doc/letgut-code.tex:1180) |
| `\file{\tl_use:N \c__letgut_local_config_file_tl.tex}` | doc/letgut.tex:1681-1685 | yes | `\file{localconf.tex}` (constant at doc/letgut-code.tex:445) |
| `dbwarning`, `dbremark`, `\valinitdef`, `dbwarninglist` | doc/letgut.tex:135, 190, 364, 2051 | no (not shown) | probably tcolorbox boxes in `localconf.tex` (the "db" prefix matches the author's initials), but the definitions are not in the zip |
| `\input{listings-conf}` | doc/letgut-code.tex:8; doc/letgut-banner-code.tex:8 | no (not shown) | file not shipped; likely `\lstset` lines |
| class internals (`letgut.cls`, `letgut-banner.sty`, `letgut.lbx/.dbx/.cbx`, `letgut-acronyms.tex`) | doc/letgut-code.tex:1-4383; doc/letgut-banner-code.tex:1-800 | no | published as `class.letgut`; irreducible expl3 and box algorithms (blockers tagged `/class`); read partly: doc/letgut-code.tex:330-537, 2100-2615, 2905-3004, 3266-3367, 3566-3722, 3745-4090, 4384-4560 not read |

## Content-opaque
- Documentation listings: `ltx-code` and `ltx-code-result` examples throughout doc/letgut.tex (e.g. 529-531, 1157-1163, 1407-1437), the `\lst@definelanguage` source at doc/letgut.tex:1989-2035, the shell aliases at doc/letgut.tex:1765-1775.
- Externally compiled example image `exemple-nouveautes-crop.pdf` (doc/letgut.tex:1260); the zip does not ship it.
- Keyword lists of the listings language driver (doc/letgut-code.tex:4858-11188, outlined only, content).
- Missing assets, to ship: Kp-Fonts (KpRoman, KpSans) and RobotoMono OpenType fonts; `localconf.tex`, `listings-conf.tex`; `informations-gut.tex` (its text is in doc/letgut-code.tex:4384-4560).

## Lib changes
- New ways proposed: `meta.attachfile` `attachfile2` (CTAN, LPPL 1.3c, in TeX Live, ctan.org/pkg/attachfile2 read; the page names pdfTeX and dvips, LuaTeX not confirmed) attaches files to the PDF. `\usepackage[icon=Paperclip]{attachfile2}`, `\attachfile[opts]{file}`, `\textattachfile[opts]{file}{text}`, `\noattachfile[opts]`; options `icon`, `color`, `description`, `mimetype`. W1: on CTAN and in TeX Live. W2: behaviour by option values. W3: serves any document that carries source files or data. W4: one preamble line plus a body wrapper. No home: `meta.hyperref` takes link options, `meta.pdfx` PDF/A, `meta.accsupp` text replacement.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
