no

# 0201-nova-thesis-starter: Nova Thesis Starter

- Unverified: read from the source, not compiled.
- Source: Source/0201-nova-thesis-starter/ (origin: https://latextemplates.com/downloads/novathesis.zip; licence: LPPL-1.3c)
- Kind: thesis
- Lib: v2
- Engine: pdfLaTeX-compatible (main.tex; the shipped novathesis path also branches for pdfTeX at nt-packages.sty:162-167, but ships LuaLaTeX as its default engine, latexmkrc:23, and several font styles need XeLaTeX/LuaLaTeX, FontStyles/arial.sty:15)
- Look carried by: mixed (main.tex: published `book` class plus its own 7-line preamble; the shipped template.tex path: zip-local novathesis.cls with its StyFiles/Config/Schools tree)
- Class origin: zip-local (novathesis.cls:81; ctan.org/pkg/novathesis and www.ctan.org/pkg/novathesis both returned 404; main.tex itself loads `book`, which is tex-distribution-unbundled)
- Main file: main.tex (other samples: template.tex, byte-identical to upstream-example.tex; README.md:246,257 names template.tex as the root document)
- Read: main yes (main.tex and template.tex whole), zip-local classes and styles partly (not read: see end of "Bespoke code")

## Verdict
Taken alone, `main.tex` is a plain `book` document whose preamble and body map one to one onto lib ways (a yes in isolation, zero blockers). But the archive is the novathesis 8.2.0 framework: main.tex:17-19 says the complete upstream class tree is shipped, and README.md:246,257 makes template.tex the root. That framework is a zip-local class (two CTAN reads gave 404) made of roughly 8,000 lines of hand-rolled expl3 engines (data store, option system, print-order dispatch, validators), covers and spines drawn as per-school TikZ overlays, `minted` loaded unconditionally by the shipped config, and glossaries that need bib2gls (Java) and `-shell-escape`. A wrong yes costs more, so the verdict follows the shipped template. Blockers carry their scope, so a main.tex-only reading can be taken straight from this file.

## Blockers
- `BESPOKE/class` hand-rolled expl3 engine: `memstore.sty` data store (memstore.sty:17,103,404), `nt-options.sty` option system (nt-options.sty:13-38), validators and file cascades (nt-core.sty:146,425,465), per-language/school default resolution (nt-setup.sty:191-307), print-order dispatch `\ntprint` (nt-setup.sty:623-671,706-725,832-886)
- `BESPOKE/class` `stocksize.sty` patches geometry's stack counter to sync physical and logical paper size (stocksize.sty:26-36), plus `fix-hyperref.sty` language-table and `\Autoref` patches (fix-hyperref.sty:24-60,128) and the `ntquoting` shrink-wrap box (nt-render-matter.sty:957-998)
- `ART/class` cover and spine engines draw the template's identity with TikZ overlays (nt-covers.sty:387-429,596-659; nt-spine.sty:451-747), filled per school (Schools/other/huberlin/other-huberlin-defaults.clo:200-251; Schools/nova/fct/nova-fct-defaults.clo:228-247,316-322; Schools/uminho/cover-final.tex:33-66)
- `EXTERNAL/package` `\usepackage{minted}` and `\newminted{latex|bash|python}` loaded unconditionally by the shipped config that the class inputs (0-Config/5_packages.tex:134,140,169,180; nt-setup.sty:1022); build runs latexmk with `-shell-escape` (Makefile:68)
- `EXTERNAL/package` `glossaries-extra` in `record` mode, unconditionally, needs bib2gls (Java) to produce any glossary (nt-packages.sty:299-312,347; latexmkrc:31)
- `EXTERNAL/class` (conditional, not default) font styles and SDG icons fetch files over the network through shell escape (nt-core.sty:1049-1081,1255-1268,1525; FontStyles/arial.sty:22)

## Class setting
- Class (main sample): `class.book` options: `11pt`, `oneside` (main.tex:1)
- Class-native vocabulary used (main.tex): `\frontmatter` (:12), `\mainmatter` (:21), `\chapter`, `\chapter*` (:14,22), `\appendix` (:42), `\tableofcontents` (:20), `\maketitle` (:13)
- Shipped path: template.tex:79 `\documentclass{novathesis}` (zip-local, not a way); it loads `class.memoir` (nt-packages.sty:92) with `11pt` and `a4paper` (0-Config/0_memoir.tex:16-17)
- memoir vocabulary the tree uses: `\chapterstyle` `\makechapterstyle` (ChapStyles/bluebox.sty:42-68), `\makepagestyle` `\makeoddhead` `\makeheadrule` (nt-setup.sty:954-963), `\OnehalfSpacing` (nt-packages.sty:94), `\maxsecnumdepth` (nt-render-matter.sty:1193), `\openright` `\openany` (nt-setup.sty:965-970), `\epigraph`, `\cftbeforechapterskip` (nt-render-matter.sty:1178-1186)
- novathesis-native vocabulary the sample uses: `\ntsetup` (1_novathesis.tex:53), `\nttitle` (3_cover.tex:34), `\ntauthorname` (3_cover.tex:145), `\ntaddperson` (3_cover.tex:242-248), `\ntaddfile` (4_files.tex:25-202), `\ntaddlistof` (6_list_of.tex:28-29,54), `\ntbibsetup` (2_biblatex.tex:16-25), `\ntprint{frontcover|frontmatter|mainmatter|backmatter|backcover}` (template.tex:84-96), `\ntaddtocover` `\SetMargin*` (huberlin clo:157-170,200-251), `\keywords` (abstract-en.tex:37-43), `ntquote` `ntdedication` `ntacknowledgements` (quote.tex:22, dedication.tex:11, acknowledgements.tex:11), `\gls` `\ntindex` `\Autoref` (chapter-introduction.tex:26,127)

## Component map
Part A: `main.tex` (the main sample).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.book` | 11pt, oneside |
| paper and size | main.tex:1 | `page.class-options` | 11pt, oneside (paper is set by geometry) |
| page geometry | main.tex:2 | `page.geometry` | a4paper, margin=30mm |
| encoding | main.tex:3 | `font.fontenc-t1` | T1 |
| text and math font | main.tex:4 | `font.palatino` | newpxtext + newpxmath (Palatino-like; package is the parameter) |
| microtypography | main.tex:5 | `sp.microtype` | defaults |
| table rules package | main.tex:6 | `tbl.booktabs` | loaded; the one table (:29-38) uses no rule commands |
| hyperref | main.tex:7 | `meta.hyperref` | hidelinks |
| title block | main.tex:8-10,13 | `front.maketitle` | `\title` `\author` `\date{2026}` `\maketitle` |
| front, main and back matter | main.tex:12,21 | `class.book` | `\frontmatter` `\mainmatter` |
| abstract (as unnumbered chapter) | main.tex:14-15 | `head.kernel` | `\chapter*{Abstract}` plus `\addcontentsline{toc}{chapter}{Abstract}` (`toc.kernel`) |
| contents | main.tex:20 | `toc.kernel` | `\tableofcontents` |
| headings | main.tex:22-26,39,43 | `head.kernel` | `\chapter`, `\section` |
| appendix | main.tex:42 | `num.appendix` | `\appendix` |
| inline maths | main.tex:27-28 | `math.kernel` | `$T(n)=T_0+rn$` |
| table float and caption | main.tex:29-38 | `tbl.tabular` | `[ht]`, `lr` columns, `\centering` (`sp.ragged`), `\caption` (`cap.kernel`) |
| list | main.tex:44-48 | `list.kernel` | `itemize` |

Part B: the shipped novathesis path (template.tex with the default config: doctype phd, school `other/huberlin` at 1_novathesis.tex:53, status working, lang en, media screen).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| base class | nt-packages.sty:91-92; 0_memoir.tex:16-17 | `class.memoir` | 11pt, a4paper, passed with `\PassOptionsToClass` |
| page geometry | nt-render-matter.sty:25-33; huberlin clo:157-170 | `page.geometry` | `\newgeometry` screen left/right 3.0cm, top 3.5cm, bottom 2.5cm; paper 2.5/3.5/3.5/2.5cm; cover 2.5/2.5/1.5/1.5cm; headheight +1pt |
| line spacing | nt-packages.sty:94 | `sp.setspace` | memoir `\OnehalfSpacing` (memoir's built-in setspace equivalent) |
| penalty | nt-render-matter.sty:27 | `sp.penalties` | `\brokenpenalty=10000` |
| microtype | nt-packages.sty:160 | `sp.microtype` | verbose=silent |
| header, footer | nt-setup.sty:954-963 | `hf.memoir-pagestyle` | `novathesis@mainmatter`: centred `\thepage` foot, head rule `\textwidth` `\normalrulethickness`, even head `\small\textsc{\leftmark}`, odd head `\small\rightorleftmark`; `novathesis@frontmatter`: foot only |
| page numbers | nt-render-matter.sty:266-269 | `pgnum.pagenumbering` | roman in front matter, page offset after covers |
| encoding, engine branch | nt-packages.sty:162-167 | `font.fontenc-t1` | T1 under pdfTeX; `font.fontspec` `no-math`, `Ligatures=TeX` under XeLaTeX/LuaLaTeX |
| main font (default style) | nt-core.sty:874; FontStyles/newpx.sty:15-18 | `font.palatino` | newpxtext + newpxmath |
| sans font | nt-packages.sty:174-185 | `font.helvet` | inter, else helvet, else gillius2, scaled=0.95 |
| optional font styles | FontStyles/times.sty:19-54; arial.sty:29-61 | `font.fontspec` | `\setmainfont` per face; pdfTeX branch `font.mathptmx` + `font.helvet` + `font.mono` (courier); math `font.newtx` |
| colour | nt-packages.sty:100; huberlin clo:34 | `color.xcolor` | `[table,svgnames]`; huberlinblue RGB 22,80,150; links DarkBlue (nt-setup.sty:24) |
| language | nt-packages.sty:191; nt-setup.sty:120-124 | `lang.babel` | english loaded, `\babelprovide[main,import]`, `autoload.bcp47=on`; strings in Strings/strings-*.ldf |
| quotation marks | nt-packages.sty:204 | `lang.csquotes` | loaded before biblatex |
| PDF metadata, links | nt-packages.sty:261-269,294 | `meta.hyperref` | bookmarksnumbered, bookmarksdepth=3, breaklinks, colorlinks, hypertexnames, pdfdisplaydoctitle, unicode |
| bookmarks, URLs | nt-packages.sty:296,213 | `meta.bookmark`, `meta.url` | `bookmark`; `xurl` |
| PDF/A | nt-packages.sty:279-291 | `meta.pdfx` | `[a-2b]`, only when docstatus=final and pdfa |
| cross references | chapter-introduction.tex:80,127; fix-hyperref.sty:128 | `xref.hyperref` | `\autoref`; `\Autoref` is zip-local |
| covers and spine | nt-covers.sty:387-429; nt-spine.sty:451-747 | `art.tikz` (ART) | page-overlay nodes: logo, bold title, examiner table, bottom-pinned date (huberlin clo:200-251) |
| front-matter order | nt-setup.sty:832-860 | none (BESPOKE) | statement, copyright, dedication, acknowledgements, quote, abstracts, aidisclose, list-of, glossaries |
| abstracts, keywords | nt-render-matter.sty:1058-1077,1095-1141 | none (BESPOKE) | one `\chapter` per language, `\pdfinfo` keywords, per-language separators |
| dedication, quote | nt-render-matter.sty:957-1005 | none (BESPOKE) | savebox width test, flushright minipage |
| acknowledgements | nt-render-matter.sty:1011-1013 | `head.kernel` | `\chapter*{<localised string>}` |
| AI disclosure | nt-packages.sty:358; nt-render-matter.sty:116-134; 7-aidisclose.tex:28-50 | `front.aidisclose` | `[autobib=false,nocite=false]`, `\AIDactivate{c:obj}`..., `\AIDrenderDeclaration[ncols=3]{<name>}` |
| contents | nt-render-matter.sty:1171,1178-1186,1205 | `toc.tocloft` | tocdepth 2, `\cftbeforechapterskip` 3pt front / `1.0em plus 1pt` main, `\@pnumwidth` 2.5em (memoir's cft names) |
| lists of | nt-setup.sty:558-613; 6_list_of.tex:28-29,46,54 | `toc.kernel` | figures, tables; `\ntaddlistof` dispatch is BESPOKE |
| headings | ChapStyles/bar.sty:15-41; nt-core.sty:873 | `head.memoir-style` | `\chapterstyle{ell}` plus `\printchaptertitle` small caps, ragged left |
| other chapter styles | bluebox.sty:42-68; compact.sty:15-32; vz34.sty:23-50 | `head.memoir-style` | `\makechapterstyle`, skips, fonts; `sp.rule` (`\leaders\hrule`), `box.fancybox` (`\colorbox`), `tbl.tabular` |
| numbering depth | nt-render-matter.sty:1193 | `num.secnumdepth` | `\maxsecnumdepth{subsubsection}` |
| appendices, annexes | nt-render-matter.sty:385-495 | `num.appendix` | `\thechapter` as Alph/Roman, `\thesection` `A.1`/`I.1` (`num.counters`) |
| lists | 5_packages.tex:118-119; paralist-compat.tex:23-37 | `list.enumitem` | `shortlabels, inline`, wide/noitemsep environments |
| epigraph | chapter-introduction.tex:19-21,28 | `quote.epigraph` | font `\small\itshape`, width 12.5cm, rule 0pt |
| boxes | 5_packages.tex:68-85; app-internals.tex:21-33 | `box.tcolorbox` | `colback=green!8` / `red!8`, `breakable`, `[most]` |
| tables | 5_packages.tex:36-65; nt-packages.sty:212 | `tbl.colortbl` | `\rowcolors{2}{rowgray}{white}`, `\rowcolor{headgray}`, `\arraystretch` 1.3 |
| more tables | 5_packages.tex:18,123-124; glossary-xltabular.sty:26 | `tbl.longtable` | `longtable`, `xltabular`; `makecell` (`tbl.multirow`) |
| figures | nt-packages.sty:211,224-225; chapter-introduction.tex:69-74 | `fig.graphicx` | `graphbox[nobeamer]`, graphicspath, `.pdf,.png,.tif,.jpg`; `\caption` (`cap.memoir`) |
| float options | 5_packages.tex:23-25 | `fig.float` | `\restylefloat{figure}`; `wrapfig` (`fig.wrapfig`) |
| code | 5_packages.tex:138-187 | `code.minted` (EXTERNAL) | `bgcolor=bgcolorlst`, `fontsize=\small`, `breaklines`, `tabsize=2`, `autogobble` |
| verbatim, listings | nt-render-matter.sty:1259-1320; abstract-en.tex:17-20 | `code.verbatim` | `verbatim`; `code.listings` counters unified with minted |
| algorithms | 5_packages.tex:131 | `alg.algorithm2e` | `[ruled,vlined]` |
| unicode arrow | 5_packages.tex:189-194 | `font.newunicodechar` | `→` to `\ensuremath{\rightarrow}` |
| notes | 5_packages.tex:121 | `draft.todo` | `todonotes[textsize=footnotesize]`; `\footnote` (`fn.kernel`) |
| bibliography | 2_biblatex.tex:16-25; nt-packages.sty:247-250 | `bib.biblatex-biber` | backend=biber, giveninits, maxbibnames=1000, backref, backrefstyle=three, urldate=iso, date=iso, seconds |
| index | nt-packages.sty:249; nt-setup.sty:987-990; nt-render-matter.sty:297-315 | `idx.makeidx` | `imakeidx`, `\makeindex[intoc,columns=2]` only if print/index; `\ntindex` wraps `\index` |
| glossaries | nt-packages.sty:299-347; glossary-xltabular.sty:48 | `idx.glossaries` (EXTERNAL) | `glossaries-extra[translate=babel,acronym,symbols,record,nolong,...]`, style `xltabular` |
| symbol packages | 5_packages.tex:28 | `math.amssymb` | `amsfonts` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| novathesis.cls | novathesis.cls:81-91 | loader only | five `\input`s; its content is the engine rows below |
| memstore data store | memstore.sty:17,103,404 | no | expl3 prop store with generated `\Set<Name>` `\Get<Name>` and `\IfMemVoidTF`; decides which string prints |
| option system | nt-options.sty:13-38; nt-core.sty:848-948 | no | l3keys keys mirrored into csnames (`\option{...}`); state, not a lib way |
| validators, file cascades, lists | nt-core.sty:146-390,425-600,1649-1830 | no | engine/degree rules in prop lists, `\IfFileExistsCase`, person and file lists |
| print engine | nt-setup.sty:623-671,706-725 | no | `\IfStrEqCase` dispatch over parts, hooks per part |
| per-school and per-language defaults | nt-setup.sty:191-307,897-924; Strings/strings-declare.tex | no | resolves strings by doctype/degree/language through MemStores |
| cover engine | nt-covers.sty:387-429,596-659 | no (ART) | expl3 minipage-in-TikZ overlay; schools register elements with `\ntaddtocover` |
| spine engine | nt-spine.sty:451-747; stocksize.sty:26-36 | no (ART) | TikZ spine with rotated boxes; geometry stack patch |
| fix-hyperref | fix-hyperref.sty:24-60,128 | no | patches hyperref's language tables and `\Autoref` |
| ntquoting | nt-render-matter.sty:957-998 | no | savebox `\wd` test chooses the minipage width |
| abstracts and keywords | nt-render-matter.sty:1058-1141 | no | per-language chapter, `\pdfinfo`/`\pdfextension` keywords |
| bibmacro override | nt-setup.sty:933-941 | no | `\renewbibmacro*{doi+eprint+url}` is biblatex internals, outside `bib.biblatex-biber` options |
| appendix and annex macros | nt-render-matter.sty:385-495 | yes | `num.appendix` + `num.counters` (renewed `\thechapter`, `\thesection`) + `toc.tocloft` hooks |
| chapter styles bar, bluebox | ChapStyles/bar.sty:15-41; bluebox.sty:42-68 | yes | `head.memoir-style` `\makechapterstyle` with `\printchaptertitle`; tabular, `\rule`, `\colorbox` |
| ShadedTabular, highlightbox, warningbox, macrodoc, ltx | 5_packages.tex:41-85,153-165; app-internals.tex:21-33 | yes | environment wrappers over `tbl.colortbl` / `box.tcolorbox` / `code.minted` with the keys listed above |
| paralist-compat, glossary-xltabular | paralist-compat.tex:23-37; glossary-xltabular.sty:48 | yes | `list.enumitem` keys; `\newglossarystyle` inside `idx.glossaries` |
| shipped config files | 0-Config/1_novathesis.tex to 4_files.tex | yes (data) | `\ntsetup` values and `\ntaddfile` lists are parameters of the zip-local engine, not of a lib way |

Not read, or read only in part (so "partly"): nt-options.sty (header only), memstore.sty (header, outline), nt-core.sty (1-140, 829-972, 1043-1100, 1255-1268, outline), nt-render-persons.sty (header), nt-version.sty, StyFiles/langdef, nt-covers.sty and nt-spine.sty (parts), stocksize.sty, fix-hyperref.sty (1-60), glossary-xltabular.sty and fix-babel.tex (headers), aidisclose.sty (header and outline), ChapStyles elegant/fmv/isel/ist/ist2/vz43/bar-compact, FontStyles other than newpx/times/arial, all Schools files other than other-defaults.clo and huberlin (grep only for nova-fct and uminho), Strings/*.ldf, 0-Config/7-aidisclose.tex (lines 1-57) and 9_*.tex, front-matter statement files, chapter-manual/latex and app-* bodies (grep and sampling).

## Content-opaque
- Images: 5-Figures/*.jpg, Images/*.svg and *.pdf, school logos (Huberlin-logo.svg), cover images `.af` (nova-fct, unusable as graphics and not compiled here)
- Bibliography and glossary data: 4-Bibliography/bibliography.bib, 1-FrontMatter/acronyms.bib, glossary.bib, symbols.bib, chemical.bib
- 150 `latexcode`, 28 `bashcode`, 4 `pythoncode` listings in the manual chapters (code text for minted), `lipsum` filler, translated strings in Strings/strings-*.ldf

## Lib changes
- New ways proposed: `front.aidisclose` `aidisclose` (CTAN, macros/latex/contrib/aidisclose, v1.12.0, LPPL; the zip bundles 1.13.0), pdf. W1: on CTAN (ctan.org/pkg/aidisclose read). W2: options `autobib` `nocite`, `\AIDactivate{key}` selections, `\AIDtoolsUsed`, colours and `ncols` (aidisclose.sty:23-30,427-502). W3: any thesis or paper needs an AI-use statement. W4: `\usepackage[...]{aidisclose}`, `\AIDactivate` lines in the preamble, `\AIDrenderDeclaration[ncols=3]{name}` in the body (nt-render-matter.sty:116-134). Loaded unconditionally by the class (nt-packages.sty:358).
- Considered: `newtx` for `newpxtext` (kept `font.palatino`: newpx is the Palatino sibling, `font.newtx` is Times-like).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
