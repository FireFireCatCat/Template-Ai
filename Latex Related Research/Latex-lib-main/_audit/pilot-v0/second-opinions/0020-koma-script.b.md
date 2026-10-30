no

# 0020-koma-script: KOMA-Script bundle (sources, user guide class, example letters)

- Unverified: read from the source, not compiled.
- Source: Source/0020-koma-script/ (origin: https://mirrors.ctan.org/macros/latex/contrib/koma-script.zip; licence: lppl1.3c)
- Kind: book (the manual `scrguide`); kind hint was letter: the zip's letter content is the `scrlttr2` source plus 26 generated example letters, not a letter template
- Lib: v0
- Engine: pdfLaTeX-compatible for the guide and the examples (README.md:538 builds with `pdflatex scrguide-en.tex`); the `.dtx` implementation docs say `lualatex-dev` (README.md:540, MANIFEST.md:15)
- Main file: doc/scrguide-en.tex (other samples: doc/scrguide-body.tex, doc/book-remarkbox-{patch,nopatch}-{en,de}.tex, doc/scrlayer-notecolumn-example-{en,de}.tex, doc/scrlttr2-examples.dtx which docstrip-generates letter-example-00..23/label/nipponA/nipponB)
- Read: main yes (scrguide-en.tex 43 lines, scrguide-body.tex 108 lines), zip-local classes and styles partly. `doc/scrguide.cls` read except lines 1000-1204 (only outlined: the same `\Label*`/`\DeclareSpecialMarkup` pattern repeated). `koma-script-source-doc.dtx` read at lines 1-135 and 240-700 of 829. The 38 `.dtx` kernel files (59k lines, the implementation of the published `scr*` classes and packages) and `scrdocstrip.tex`, `scrstrip.inc`, `scrstrop.inc` were only outlined through `scrmain.ins`, not read. Plain-text chapters in `doc/*-en.tex` and `*-de.tex` are content and were sampled only (scrjura, scrlttr2, scrlayer-notecolumn heads).

## Verdict
No. The guide is built on a zip-local class, `scrguide`, of about 3000 lines of hand-written macro programming. It includes a box-and-glue page-breaking environment (`desclist`), an index stack that manipulates `\lastpenalty` and `\lastskip`, and hyperref-internal anchor surgery. It also draws page sketches with `picture`/`\qbezier` as part of its example display, and its multi-index needs an external perl script that is not shipped. The published `class.scrbook` base, the title block, the headings, the listings setup and the example letters all map to lib ways. The blockers above them cannot be reduced to lib ways.

## Blockers
- `BESPOKE` `desclist` environment: measures boxes, compares `\pagegoal`/`\pagetotal`, breaks tables by hand and toggles page parity (doc/scrguide.cls:1925-2037)
- `BESPOKE` `Declaration` environment: `lrbox` + `\penalty-\@medpenalty` look-ahead + `\aftergroup\@afterheading` + `\catcode` change (doc/scrguide.cls:1421-1513)
- `BESPOKE` index stack and range entries: `\push@IndexStack`, `\CloseIndex` saving `\lastpenalty`/`\lastskip`, `\DefineSingleIndex`/`DoubleIndex`/`TripleIndex` generating `\Index*` macros (doc/scrguide.cls:2684-2992)
- `BESPOKE` label/anchor/index markup layer built on hyperref internals (`\Hy@MakeCurrentHref`, `\hyper@anchorstart`), `\DeclareSpecialMarkup` (doc/scrguide.cls:701-1221, 2252-2259, 2287-2322)
- `BESPOKE` translator list collected through `\@auxout` and de-duplicated by counters (doc/scrguide.cls:565-639); newest-file-date tracking by redefining `\@providesfile` (doc/scrguide.cls:443-553)
- `BESPOKE` change log written to a glossary file and printed through a custom makeindex style (doc/scrguide.cls:1714-1779, doc/scrguide.gst:34-52)
- `BESPOKE` `koma-script-source-doc` class (expl3 keys, `\markboth` patch `\kssd@section@hack`, `\cs` redefined with catcode switches); it exists only after docstrip (koma-script-source-doc.dtx:247-446, 557-585)
- `BESPOKE` `\lalias` label aliasing by editing `r@...` macros (doc/linkalias.tex:30-61)
- `ART` `ShowOutput` environment: `picture` + `\qbezier` torn-page frame computed from box dimensions around every example output (doc/scrguide.cls:1559-1594)
- `ART` `XmpTopPage`/`XmpBotPage` and `\XmpRule`/`\XmpHeading` page-edge sketches in `picture` (doc/scrguide.cls:1619-1686)
- `ART` `letter-example-label` overlay: `eso-pic` + `\line`/`\multiput` grid drawn on every page (doc/scrlttr2-examples.dtx:207-228). This is an illustrative aid inside one generated example.
- `EXTERNAL` multi-index depends on "an external perl script" that splits one index into six (doc/scrguide.cls:2442-2458); the script is not in the zip. The branch is chosen by `\IfFileExists{\jobname-gen.ind}`. Also `makeindex -s scrguide.ist`, `makeindex -r -s scrguide.gst` (doc/scrguide.gst:34) and bibtex are needed.
- `EXTERNAL` the shipped classes/packages exist only after `tex scrmain.ins` (docstrip over `.dtx`, README.md:538) and the examples after `tex scrlttr2-examples.dtx` (scrlttr2-examples.dtx:25-153). docstrip is TeX, but it is a separate generate step. An emitter can write the published classes and the final example `.tex` directly, so this is recorded and not counted alone.
- `UNMAPPED` literate source documentation (`doc`/`ltxdoc`: `macrocode`, `\changes`, `\DescribeMacro`, code-line index) used by all 38 `.dtx` (e.g. scrlayer.dtx:76). It is a documentation-of-TeX-code component, not a Flouest document part, and the lib has no way for it.

## Class setting
- Class: `class.scrbook` options: none in the sample line; the zip-local `scrguide` passes `bibliography=totoc, index=totoc, captions=tableabove, headings=small, headings=optiontoheadandtoc, version=last` (doc/scrguide.cls:114-121) and `\LoadClassWithOptions{scrbook}` (doc/scrguide.cls:154). `scrguide` itself is `\documentclass[english]{scrguide}` (doc/scrguide-en.tex:23). It is not a way: it fails W2/W3 (one document, behaviour set by code) and is the bespoke item above.
- Also: `class.scrartcl` for the notecolumn example (doc/scrlayer-notecolumn-example-en.tex:26), `class.book` for the remarkbox examples (doc/book-remarkbox-patch-en.tex:1), `class.scrlttr2` for the letters (doc/scrlttr2-examples.dtx:230-246), `class.ltxdoc` for the `.dtx` documentation (koma-script-source-doc.dtx:299).
- Class-native vocabulary used: `\extratitle \subject \publishers \uppertitleback \lowertitleback \dedication \addchap \setchapterpreamble \setkomafont \KOMAoptions \RedeclareSectionCommand \DeclareTOCStyleEntries \chapterformat \chaptermarkformat \partheadstartvskip \labeling \marginline`; scrlttr2: `\setkomavar \setkomavar* \LoadLetterOption \opening \closing \ps \encl \cc \raggedsignature`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | doc/scrguide.cls:154 | `class.scrbook` | via zip-local scrguide; options above |
| page size/margins | doc/scrguide.cls:261-264 | `page.geometry` | papersize={180mm,210mm}, includehead, includemp, reversemp, marginparwidth=4em, vmargin={1.5mm,3mm}, hmargin=1.75mm |
| one-side, open any | doc/scrguide.cls:260 | `page.class-options` | internals `\@twosidefalse\@openrightfalse\@mparswitchfalse` reduce to `oneside`, `open=any` |
| page numbering/hf | doc/scrguide.cls:265-285 | `hf.scrlayer-scrpage` | `\clearpairofpagestyles`; `\ihead` = headmark; `\ohead*` = pagemark; `\DeclareNewLayer[head,background,hoffset=0pt,width=\paperwidth,addheight=...,addvoffset=2\dp\strutbox,contents={\color{headbackground}\rule{\layerwidth}{\layerheight}}]{headbackground}` (a DarkBlue band, declarative layer); `\AddLayersAtBeginOfPageStyle{scrheadings}`; `\KOMAoptions{headwidth=paper:-...}` |
| head/foot font | doc/scrguide.cls:275-276 | `head.koma-fonts` | pageheadfoot = `\small\sffamily\bfseries\color{headline}`; pagenumber = empty; caption = `\normalcolor\small` (cls:1259) |
| chapter heading looks | doc/scrguide.cls:286-296, 314, 2355-2357 | `head.koma-fonts` | `\renewcommand` of `\chaptermarkformat`, `\chapterformat`, `\chapterpagestyle`=scrheadings, `\chapterheadstartvskip`; part: `\partheadstartvskip`=`.1\textheight`, `\partpagestyle`=empty |
| ToC entry layout | doc/scrguide.cls:2331-2348 | `toc.koma` | `\RedeclareSectionCommand` tocindent=21pt/55pt, tocnumwidth=21pt/34pt/36pt, tocdynnumwidth, tocbreakafternumber; `\DeclareTOCStyleEntries[dynnumwidth]{default}{figure,table}`; `\@pnumwidth`, `\@tocrmarg`, `\@dotsep` set raw |
| title block | doc/scrguide-body.tex:32-45, 52 | `front.koma-title` | `\extratitle`, `\title`, `\subject`, `\author`, `\publishers`, `\uppertitleback`, `\lowertitleback`; text from zip-local `\Guide*` macros (terms-en.tex:33-60) |
| `\maketitle` wrapper | doc/scrguide.cls:303-314 | BESPOKE | `\orig@maketitle` inside a group that sets `\@twosidetrue`, shifts side margins; not a lib way |
| dedication | doc/scrguide-body.tex:45 | `front.dedication` | `\dedication{...}` |
| contents/lists | doc/scrguide-body.tex:58-62 | `toc.kernel` | `\tableofcontents \listoffigures \listoftables` after `\cleardoublepage\pdfbookmark` |
| page breaks | doc/scrguide-body.tex:54-64 | `pg.break` | `\cleardoublepage` |
| bookmarks | doc/scrguide-body.tex:47-50; cls:243 | `meta.bookmark` | `\pdfbookmark[-1]`, `\bookmarksetup{startatroot}`, `[open,openlevel=0]` |
| hyperref | doc/scrguide.cls:242, 300, 2265-2278 | `meta.hyperref` | colorlinks, citecolor=Green, linkcolor=Crimson, urlcolor=Blue; plainpages=false; pdftitle, pdfauthor, pdfsubject, pdfkeywords, pdfcreator |
| cross refs | doc/scrguide.cls:2287-2322 | `xref.hyperref` | `\autoref`, plus bespoke `\autopageref` (see Blockers) |
| colours | doc/scrguide.cls:237, 273-274, 650-653 | `color.xcolor` | svgnames; `\colorlet{headbackground}{DarkBlue}`, `{headline}{white}`, ImageRed/Blue/Green/Yellow, Declaration=PaleTurquoise (cls:1414) |
| fonts | doc/scrguide.cls:155, 259, 323 | `font.fontenc-t1` / `font.lmodern` | `[TS1,T1]{fontenc}`, `textcomp`, `lmodern` |
| language | doc/scrguide.cls:162-175 | `lang.babel` | `ngerman` and `english`, `main=` chosen by class option |
| listings | doc/scrguide.cls:2051-2226 | `code.listings` | `\lstset` basicstyle=\ttfamily, columns=fullflexible, keepspaces, aboveskip, belowskip, literate umlauts; `\lstdefinestyle` code/output/KOMA with `moretexcs` lists; `\lstnewenvironment` lstcode, lstoutput |
| bibliography | doc/scrguide.cls:188-190, 2409-2430 | `bib.bibtex-bst` + `NEW:bib.babelbib` | `[fixlanguage]{babelbib}`, `\bibliographystyle{babalpha-fl}`, `\setbibpreamble`; the `.bst` is not shipped. Dead branch: biblatex backend=bibtex (cls:192-203) |
| index | doc/scrguide.cls:2446-2554, 2576-2579 | `idx.makeidx` | `\makeindex`, `theindex` as `multicols{2}` (cls:2500-2510); `.ist` delim_0/1/2, headings (doc/scrguide.ist:34-50); the multi-index part is EXTERNAL |
| columns | doc/scrguide.cls:216, 2502 | `cols.multicol` | `\begin{multicols}{2}[...][.2\textheight]` |
| float placement | doc/scrguide.cls:429-435 | `fig.placement` | floatpagefraction=.75, textfraction=.2, topfraction=.75, bottomfraction=.33, topnumber=1, bottomnumber=1, totalnumber=3 |
| flush/ragged | doc/scrguide.cls:315-316 | `pg.flush` | `\raggedbottom`, `\sloppy` |
| tables | doc/scrguide.cls:212-218, 1811-1818 | `tbl.booktabs` / `tbl.longtable` / `tbl.tabularx` / `tbl.tabular` | packages loaded; `desctabular` = `tabular{lp{\descwidth}}` with `\toprule`/`\bottomrule` (reducible alone; `desctable`/`desclist` are not) |
| captions | doc/scrguide.cls:114-121 | `cap.koma` | `captions=tableabove` |
| margin notes | doc/scrguide.cls:217, 219, 1697-1699, 1716 | `note.marginnote` / `note.marginpar` | `\marginnote{\tiny\fbox{...}}`, `\marginline`; `mparhack` loaded as a companion (no option) |
| math | doc/scrguide.cls:214, 1292 | `math.amsmath` | `\allowdisplaybreaks[1]` |
| figures | doc/scrguide.cls:211 | `fig.graphicx` | `graphicx` |
| after-page flow | doc/scrguide.cls:206 | `pg.afterpage` | `afterpage` |
| boxes | doc/scrguide.cls:1419, 1716 | `box.fancybox` / `box.minipage` | `\colorbox`, `\fbox`, `minipage` (inside bespoke `Declaration`) |
| appendix | doc/scrguide.cls:2386 | `num.appendix` | `\g@addto@macro\appendix{\global\let\appendix\relax}` |
| TikZ in figures | doc/scrguide.cls:238-241; doc/plength-tikz.tex:34-222 | `art.tikz` | libs decorations, arrows, calc; used inside `figure` (scrlttr2-en.tex:705-711, 1320-1326) |
| page-edge sketches | doc/scrguide.cls:1559-1686 | `art.pstricks` | `picture`, `\qbezier`: ART, see Blockers |
| example letters | doc/scrlttr2-examples.dtx:230-380 | `class.scrlttr2` + `ltr.opening` | version=last, fontsize=14pt, foldmarks=true, foldmarks=blmtP, fromalign=false/center/right, fromrule=aftername/afteraddress, fromphone, fromemail, fromlogo, subject=titled, locfield=wide; `\setkomavar{fromname,signature,fromaddress,fromphone,fromemail,fromlogo,location,place,frombank,date,subject}`; `\opening \closing \ps \encl \cc`; `\LoadLetterOption{me}` |
| label overlay | doc/scrlttr2-examples.dtx:207-228 | `bg.eso-pic` | `\AddToShipoutPicture*` with picture lines: ART |
| language of letters | doc/scrlttr2-examples.dtx:253-254 | `lang.babel` | `[ngerman]` / `[british]` |
| remark float + list | doc/book-remarkbox-patch-en.tex:3-26 | `class.book` + `NEW:toc.tocbasic` | `[enablepatch={chapter,listoffigures}]{tocbasic}`; `\DeclareNewTOC[type=remarkbox,types=remarkboxes,float,counterwithin=chapter,floattype=4,name=Remark,tocentryindent=1.5em,tocentrynumwidth=2.3em,listname={List of Remarks}]{lor}`; `\setuptoc{lof}{totoc}`, `\setuptoc{lor}{totoc}` |
| note column | doc/scrlayer-notecolumn-example-en.tex:34-50, 70-96 | `NEW:note.scrlayer-notecolumn` | `\DeclareNewNoteColumn[position=\oddsidemargin+1in+.667\textwidth+\marginparsep, width=\paragraphscolwidth, font=\raggedright\footnotesize\color{blue}]{paragraphs}`; `\makenote[paragraphs]{...}`; `\syncwithnotecolumn[paragraphs]`; `addmargin`; `\AfterCalculatingTypearea` + `\recalctypearea` set a length |
| legal clauses | doc/scrlayer-notecolumn-example-en.tex:30-32, 72-89 | `NEW:legal.contract` | `\usepackage{contract}`; `\setkomafont{contract.Clause}{\bfseries}`; `\setkeys{contract}{preskip=-\dp\strutbox}`; `contract` env, `\Clause[title=...]` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class `scrguide` as a whole (365 definitions) | doc/scrguide.cls:41-3026 | no | see the rows below; only the package/option lines map to ways |
| `desclist`, `desctable`, `\start@desctab` | doc/scrguide.cls:1803-2037 | no | box measuring and manual page breaking; `desctabular` alone would be `tbl.tabular`+`tbl.booktabs` |
| `Declaration`, `Example`, `Explain`, `Body` | doc/scrguide.cls:1421-1537, 1602-1606 | no (`Example` is `labeling` + `\usekomafont{disposition}`: reducible) | `Declaration` is irreducible (penalty look-ahead, `\aftergroup`) |
| `ShowOutput`, `XmpTopPage`, `XmpBotPage` | doc/scrguide.cls:1559-1686 | no | ART |
| index stack, `\Define*Index`, `\IndexSeeAt`, `\printmultiindex` | doc/scrguide.cls:2454-2992 | no | needs the perl splitter too |
| `\Label*`, `\DescRef`, `\DeclareSpecialMarkup`, `\OptionValueRef...` | doc/scrguide.cls:701-1221 | no | hyperref-internal anchor construction |
| `\translator`, `\settranslator`, `\@CheckDate`, `\@notonlypreamble` | doc/scrguide.cls:443-639 | no | aux-file state and `\@ifl@t@r` patching |
| `\ChangedAt`, `thechangelog`, `\printchangelog` | doc/scrguide.cls:1714-1779 | no | glossary + makeindex style |
| `\LoadCommonFile`, `\IfThisCommonLabelBase*` | doc/scrguide.cls:130-191 | no | counter/conditional-driven file selection |
| `\iffree` / `scrnonfree.tex` switch | doc/scrguide.cls:236-319 | partly | not shipped, so the free branch always runs; its packages map as above, `\maketitle` wrapper does not |
| `\XeTeX \BibTeX \NTS \eTeX` logos | doc/scrguide.cls:1312-1322, 2366-2402 | yes | text logos, content |
| `me.lco`, `ich.lco` (docstrip output) | doc/scrlttr2-examples.dtx:159-204 | yes | `\KOMAoptions{foldmarks,fromphone,fromemail,fromlogo,subject=titled}` + `\setkomavar{...}` + `\raggedsignature` on `class.scrlttr2` |
| docstrip guards generating 26 letters | doc/scrlttr2-examples.dtx:25-153, 230-380 | yes if written out | each example is `class.scrlttr2` with the options in the map |
| `plength-tikz.tex`, `variables-tikz.tex` | doc/plength-tikz.tex:34-222; doc/variables-tikz.tex:34-158 | content | expl3 `\fp_eval` + TikZ page diagram inside `figure`: figure artwork |
| `\linclude`, `\KOMAProvidesFile` | doc/scrguide.cls:134-149, 176 | yes | `\include{<name>-<lang>}`, `\ProvidesFile` |
| `koma-script-source-doc` class | koma-script-source-doc.dtx:247-446, 557-585 | no | `\NewDocElement` calls (604-802) are doc v3's own interface; `\kssd@section@hack` and `\cs` catcode redefinition are not |

## Content-opaque
- TikZ page diagrams of letter pseudo-lengths and variables, in `figure` floats (doc/plength-tikz.tex:222-; doc/variables-tikz.tex:158-; included at doc/scrlttr2-en.tex:705-711, 1320-1326)
- Guide prose in the 24 `doc/*-en.tex` chapters, the German twins, `scrguide.bib` entries, and 48 prebuilt `letter-example-*.pdf` and `scrguide-*.pdf` files
- Missing assets: `doc/scrdate-en.tex` (`\linclude{scrdate}`, scrguide-body.tex:73) and `scrnonfree.tex` are not in the zip; `\ListTypeArea`/`\GeneralTypeArea` (scrguide-body.tex:30,54,57,64) are defined nowhere here, so they run as `\relax`; `musterlogo.eps` is generated; `babalpha-fl.bst` is not shipped and I did not confirm that babelbib ships it (the CTAN page does not say)
- `engord` is loaded for ordinal words in text (doc/terms-en.tex:32). It sets no look and is not proposed.
- AI-addressed text: none found.

## Lib changes
- New ways proposed:
  - `NEW:note.scrlayer-notecolumn`: package `scrlayer-notecolumn` (KOMA-Script), pdf. W1 shipped on CTAN with public manual (doc/scrlayer-notecolumn-en.tex); W2 position/width/font keys; W3 any document wanting a side note column; W4 preamble `\DeclareNewNoteColumn[...]{name}` and body `\makenote[name]{...}`. Lib has `note.marginnote`/`note.sidenotes` only; neither declares columns.
  - `NEW:legal.contract`: package `contract` (successor of `scrjura`; https://ctan.org/pkg/contract: "Typeset formalized legal documents such as contracts, statutes", LPPL 1.3c), pdf. W1 CTAN; W2 `\setkeys{contract}{...}` and font elements; W3 any legal text; W4 preamble load plus `contract` environment and `\Clause` wrappers. Section: doc-kind specific.
  - `NEW:toc.tocbasic`: package `tocbasic` (KOMA-Script), pdf. W1 CTAN with manual (doc/tocbasic-en.tex); W2 `\DeclareNewTOC` keys, `\setuptoc`; W3 any new list-of/float type; W4 preamble declaration and body float wrapper. Distinct from `toc.koma` (class options `toc=`) and `toc.tocloft`.
  - `NEW:bib.babelbib`: package `babelbib` (https://ctan.org/pkg/babelbib: multilingual bibliographies with babel), pdf. W1 CTAN; W2 `fixlanguage`, `\selectbiblanguage`, `.bst` name; W3 any multilingual BibTeX bibliography; W4 preamble load plus `\bibliographystyle`/`\bibliography`. `bib.bibtex-bst` has no package that tags each entry's language.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
