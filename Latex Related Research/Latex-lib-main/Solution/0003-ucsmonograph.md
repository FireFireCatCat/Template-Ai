yes

# 0003-ucsmonograph: ucsmonograph (UCS / ABNT monograph class on abnTeX2)

- Unverified: read from the source, not compiled.
- Source: Source/0003-ucsmonograph/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ucsmonograph.zip; licence: lppl1.3c)
- Kind: thesis
- Lib: v1
- Engine: pdfLaTeX-compatible (the LuaLaTeX branch only loads `unicode-math` for an upright maths font, ucsmonograph.dtx:564-568; XeLaTeX is not special-cased)
- Look carried by: class (the zip is the class's own DocStrip source; the look is the derived `ucsmonograph.cls`, code at ucsmonograph.dtx:515-1526, on top of `abntex2`)
- Class origin: ctan
- Main file: ucsmonograph.dtx (no .tex sample exists; the documentation example at ucsmonograph.dtx:262-290 stands in for one; the doc driver at :39-56 is an `ltxdoc` build file, not a template sample) (other: ucsmonograph.ins, README.md, ucsmonograph.pdf)
- Read: main yes, zip-local classes and styles all (no separate .cls or .sty ships: the class code is the .dtx's unprefixed lines 515-1526, read in full; ucsmonograph.pdf not read; the `abntex2` source is not in the zip and was not read)

## Verdict
The zip is the DocStrip source of `ucsmonograph`, a class published on CTAN and in TeX Live and MiKTeX (ucsmonograph.dtx:205-206), so it is one way, `class.ucsmonograph`, which loads `class.abntex2` (dtx:555). An emitter writes `\documentclass[...]{ucsmonograph}` plus the class's native commands and copies no macro logic, so this is evidence about the class dimension, not about the component ways. Nothing in the zip is unpublished, so nothing counts as bespoke under the rubric; the class's internal patches are still listed below, with the ones that could not be rebuilt from component ways. The `siglas` and `simbolos` options need `bib2gls` (outside TeX) but are conditional and unused by the documentation example (see Blockers), so they are recorded, not counted.

## Blockers
none

Recorded, not counted (conditional, not exercised by the documentation example at dtx:262-290):
- `EXTERNAL/package` (conditional) options `siglas` and `simbolos` switch `glossaries-extra` to `record`, which needs the `bib2gls` script (dtx:244-246, :641-651, :1467-1525). `glossaries-extra` itself is loaded unconditionally (dtx:653) but without `record`, so nothing outside TeX is needed unless an option is given. The doc names the manual alternative, the abntex2 `siglas` / `simbolos` environments (dtx:248, :254).

## Class setting
- Class: `class.ucsmonograph` options: `12pt,oneside,english,brazil,lmodern,cite=num` (dtx:263; typical call :223). Also `twoside` (:228), `cite=alf` (default, :533, :240), `siglas`, `simbolos` (:542-548). The main language option goes last (:232). It forces onto the base class `class.abntex2`: `openright,a4paper,chapter=TITLE,section=TITLE`, and passes every other option to `abntex2` (dtx:553-555).
- Class-native vocabulary used: preamble `\titulo` `\autor` `\data` `\instituicao` `\local` `\preambulo` `\areadoconhecimento` `\orientador` `\avaliadori` `\avaliadorii` `\avaliadorext[inst]` `\palavraschave[lang]{}` (dtx:267-282); body `\imprimircapa` `\imprimirfolhaderosto` `\imprimirfolhadeaprovacao[inst]{date}` (:285-287), environments `resumo[lang]` `dedicatoria` `epigrafe` `quadro` (:342-379, :298), `\fonte[width]{}` `\incluirimagem[scale]{path}{desc}{source}` and its starred form (:389, :470-480), `\listofquadros(*)` (:301-306), `\foreignlanguage` (:401), conditional `\incluirsiglas` `\listofsiglas*` `\incluirsimbolos` `\listofsimbolos*` (:485-503). Base-class vocabulary reused inside the class: memoir-style `\makepagestyle` `\setaftersecskip` `\SingleSpacing`, abntex2 `\ABNTEX*font` hooks, `capa`, `folhadeaprovacao`, `\imprimirpreambulo`.

## Component map
Each row names the lib way that realises the part inside the class (the class sets it); an emitter reaches all of them with the one `class.ucsmonograph` line. Base-class internals (abntex2, memoir, tocloft, enumitem) are inferred from the commands the .dtx calls, since their sources are not in the zip.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | dtx:555 | `class.abntex2` | `\LoadClass[openright,a4paper,chapter=TITLE,section=TITLE]{abntex2}`; source not read (published, not bundled) |
| class options | dtx:533-534, :538-548, :553-554 | `class.ucsmonograph` | `kvoptions` string key `cite` (default `alf`), booleans `lmodern` `siglas` `simbolos`, rest forwarded |
| paper, binding | dtx:555, :223, :228 | `page.class-options` | `a4paper`, `openright`; user `12pt`, `oneside`/`twoside` |
| margins | dtx:610 | `page.geometry` | top=3cm, left=3cm, bottom=2cm, right=2cm |
| bottom alignment | dtx:611, :1406 | `pg.flush` | `\raggedbottom` globally; `\flushbottom` on the approval page |
| absolute positioning | dtx:615, :934, :940, :990 | `pg.textpos` | package option `absolute`; `textblock*` 160mm wide at (30mm, 297mm/4+15mm) author, (30mm, 297mm/2) title |
| page breaks | dtx:957-958 | `pg.break` | `folhaderosto`: `\clearpage` before, `\cleardoublepage` after (starred: `\newpage`) |
| header, footer | dtx:737-739 | `hf.memoir-pagestyle` | `\makepagestyle{abntheadings}`; even head `\ABNTEXfontereduzida\thepage` left, odd head right; no rule, no footer |
| line spacing | dtx:795 | `sp.linespread` | `\linespread{1.4}` (Word 1.5 equivalent at 12pt) |
| single-spaced blocks | dtx:998, :1051, :1072, :1095, :1399, :1408 | `sp.setspace` | `\SingleSpacing`, `SingleSpace` (memoir's setspace-style built-ins, abntex2 on memoir; a pdfLaTeX emitter writes the `setspace` form) |
| paragraph shape | dtx:801, :809 | `sp.lengths` | `\parskip` 0pt, `\parindent` 1.5cm |
| first-paragraph indent | dtx:614 | `sp.indentfirst` | package, no options |
| float and display skips | dtx:838-840, :848-853 | `sp.lengths` | `\textfloatsep` `\floatsep` `\intextsep` 1.5\baselineskip; four display skips 1\baselineskip plus 5pt minus 5pt; `\jot` 2ex (set `\AtBeginDocument`) |
| manual spacing | dtx:927, :943, :1048, :1069, :1401, :1409 | `sp.manual-space` | `\vfill`, `\vspace*{\fill}`, `\hspace{.5\textwidth}`, `\vspace{24pt}`, `\vspace*{\ABNTEXsignskip}` |
| ragged setting | dtx:1032, :1072 | `sp.ragged` | `\raggedright` (source line), `\raggedleft` (epigraph) |
| text font | dtx:538-540, :604-606, :567 | `font.lmodern` | via option `lmodern`; forced on under LuaLaTeX |
| maths font | dtx:565-568 | `font.unicode-math` | `math-style=upright`; LuaLaTeX only (xe/lua) |
| encodings | dtx:264-265 (user preamble) | `font.fontenc-t1` | `inputenc` utf8, `fontenc` T1 |
| size commands | dtx:760-772, :1032 | `font.size-commands` | `\normalsize` at every heading level; `\footnotesize` for `\fonte` |
| language | dtx:223, :673-682, :748-751, :1098 | `lang.babel` | class options `english,brazil` (main last); `\addto\captions<lang>`; `otherlanguage` in `resumo`; names Lista de figuras, Lista de símbolos, Quadro, Lista de quadros |
| PDF metadata | dtx:593-599, :1133-1162, :1296-1298 | `meta.hyperref` | `unicode=true`, `pdfcreator`, `colorlinks=true`, `linkcolor=black`, `citecolor=black`; `pdftitle` `pdfauthor` `pdfsubject` `pdfkeywords` filled from `\titulo` `\autor` `\preambulo` `\palavraschave`; `\pdfbookmark[0]` for Capa, lof, lot, toc, loq, loa, los |
| cover | dtx:921-947 | `front.class-native` | `\imprimircapa`: `capa` env, `\bfseries\centering`; uppercased institution and knowledge area, author and title in `textblock*`, place, year |
| title page | dtx:968-1009 | `front.class-native` | `\imprimirfolhaderosto`: uppercased author, title in `textblock*`, `\imprimirpreambulo` and advisor in a .5\textwidth minipage at `\hspace{.45\textwidth}`, place, year |
| approval page | dtx:1386-1433 | `front.class-native` | `\imprimirfolhadeaprovacao[inst]{date}`: `folhadeaprovacao` env, "Aprovado(a) em", "Banca Examinadora", up to four named examiners, each skipped when empty |
| metadata commands | dtx:267-278, :1312-1376 | `front.class-native` | `\areadoconhecimento` `\avaliadori` `\avaliadorii` `\avaliadorext` store text for the pages above |
| dedication | dtx:1044-1056 | `front.dedication` | `dedicatoria`: abntex2 env plus `\vspace*{\fill}\hspace{.5\textwidth}` and a `minipage[b]` .45\textwidth, single spacing |
| epigraph page | dtx:1065-1077 | `front.class-native` | `epigrafe`: same box, `\SingleSpacing\itshape\raggedleft` |
| abstract | dtx:1086-1114 | `abs.class-native` | `resumo[lang]`: wraps `abstract`, `\abstractnamefont` = `\chaptitlefont`, name `\MakeUppercase`, `\SingleSpacing`, `otherlanguage` for a second language, keywords appended |
| keywords | dtx:1123-1124, :1293-1304 | `abs.keywords` | `\palavraschave[lang]{}` stored per language; `\imprimirpalavraschave` = `\textbf{Palavras-chave:}` (Keywords:, Stichwörter:, Palabras-llave:) |
| contents and lists | dtx:1192-1220 | `toc.kernel` | `\tableofcontents` `\listoffigures` `\listoftables`, each preceded by `\pdfbookmark` |
| contents styling | dtx:710-711, :781-785, :705-706 | `toc.tocloft` | `\cft{chapter,section,subsection,subsubsection,paragraph}font` = the heading fonts; `\cftquadroname` `Quadro\space`; `\cftquadroaftersnum` `\hfill\textendash\hfill`; `\newlistof{listofquadros}{loq}`, `\newlistentry{quadro}{loq}{0}` |
| heading case | dtx:555 | `head.class-native` | options `chapter=TITLE`, `section=TITLE` (upper case) |
| heading fonts | dtx:759-772 | `head.class-native` | `\ABNTEX*font` hooks: chapter `\bfseries`; section `\bfseries\mdseries`; subsection adds `\bfseries`; subsubsection `\mdseries`; fourth level `\itshape`; all `\normalsize` |
| heading spacing | dtx:819, :826-829 | `head.memoir-style` | `\afterchapskip` = `\baselineskip`; `\setaftersecskip` `\setaftersubsecskip` `\setaftersubsubsecskip` `\setafterparaskip` = `\baselineskip` |
| heading numbers | dtx:895-904, :911 | `head.class-native` | `\printchapternum` and `\@seccntformat` reduce the gap after the number to one space |
| counters | dtx:631-632, :715 | `num.counters` | `chngcntr`: `\counterwithout{equation}{chapter}`, `\counterwithout{quadro}{chapter}` |
| enumerate | dtx:864-866 | `list.enumitem` | `\setlist[enumerate,1]{labelindent=\parindent,leftmargin=\parindent+0.6cm,nosep,label=\alph*)}`; `\setlist` is enumitem's but the .dtx never loads it, so abntex2 does (not read); `calc` loaded at :616 |
| itemize | dtx:872 | `list.enumitem` | `\setlist[itemize,1]{nosep,label=--}` |
| maths | dtx:618-619 | `math.amsmath` | `amsmath`, `\allowdisplaybreaks` |
| decimal comma | dtx:624 | `math.icomma` | package, no options |
| quadro float | dtx:691-715 | `fig.float` | `\newfloat{quadro}{\quadroname}{loq}[chapter]`, `\restylefloat*`, memoir `\setfloatadjustment{quadro}{\centering}`, `\setfloatlocations{quadro}{hbtp}`, `\fnum@quadro` = `Quadro <n>`; whether `\newfloat` is float's or memoir's is not established (sources not read) |
| captions | dtx:608, :1022, :1442 | `cap.caption` | `caption` package, no options; `\ABNTEXcaptionfontedelim` `: `; `\caption{description}` is `cap.kernel` |
| figure helper | dtx:1441-1458 | `fig.adjustbox` | `\incluirimagem`: `\caption`, `\adjustimage{scale=#1,fbox=1.5pt {\fboxsep} 1pt,gstore width=\larguraimagem,center}`, `\fonte[\larguraimagem-14pt]`; image via `fig.graphicx` (dtx:622), inside `figure` |
| source line | dtx:1023-1035 | `box.minipage` | `\fonte[width]{text}`: `minipage[h]` of that width, `\vspace{2pt}`, `\raggedright\footnotesize`, "Fonte: " |
| tabular | dtx:1175-1184 | `tbl.tabular` | kernel `tabular` wrapped in `adjustbox` with `gstore width=\larguratabular` (feeds `\fonte`) |
| bibliography list | dtx:881-886 | `bib.thebibliography` | `\parskip` 0pt, `\itemsep` `\baselineskip` after the abntex2 list opens |
| citations | dtx:575-581 | `bib.apacite` | `abntex2cite` options `cite=alf` or `num`, `abnt-etal-list=3`, `abnt-etal-text=it`, `abnt-full-initials=no`; `.bst` style not set in the .dtx |
| numeric citations | dtx:578-581 | `bib.cite-pkg` | only when `cite=num`: `\citebrackets[]` and `\RequirePackage{cite}` |
| acronym and symbol lists | dtx:641-662, :1229-1242, :1467-1525 | `idx.glossaries` | `glossaries-extra` with `acronyms` / `symbols`, `record,toc=false,nonumberlist,style=long` when an option is on; `\setabbreviationstyle[acronym]{long-short}`, `[foreignabbreviation]{long-short-user}`; `\GlsXtrLoadResources`, `\printunsrtglossary`; `bib2gls` when enabled (EXTERNAL, conditional) |

## Bespoke code
None counts as bespoke under the rubric: every definition below sits inside `ucsmonograph`, which is published on CTAN (W1), carried as `class.ucsmonograph`. The last column says what rebuilding from component ways alone would take, so the class dimension is not hidden.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| whole class code | dtx:515-1526 | not bespoke (published) | one `\documentclass` line with options |
| cover, title page, approval page layouts | dtx:921-947, :982-1009, :1386-1433 | yes | `pg.textpos` `textblock*`, `box.minipage`, `sp.manual-space`, `sp.setspace`; the `\expandafter\uppercase` is a content transform |
| `dedicatoria` and `epigrafe` wrappers | dtx:1044-1077 | yes | `sp.manual-space` + `box.minipage` (+ `sp.ragged`) around the body |
| `resumo` env, keywords kept in `\captions<lang>` | dtx:1086-1114, :1293-1304 | yes | `abs.kernel` + `lang.babel` `otherlanguage` + `abs.keywords` line written in the body |
| `\titulo` `\autor` `\preambulo` `\palavraschave` wrappers, `\pdfbookmark` wrappers | dtx:720-724, :1132-1163, :1192-1220, :1294-1299 | yes | `meta.hyperref` `\hypersetup{pdftitle,pdfauthor,pdfsubject,pdfkeywords}` and `\pdfbookmark` before each list |
| `thebibliography` wrapper | dtx:881-886 | yes | `bib.thebibliography` + `sp.lengths` |
| `\printchapternum`, `\@seccntformat` | dtx:895-911 | yes | `head.memoir-style` or `head.titlesec` number format |
| `\foreignlanguage` made italic | dtx:1272 | yes | `lang.babel` + `mark.kernel` `\emph` |
| `quadro` float, `\listofquadros` | dtx:691-724 | yes | `fig.float` + `toc.tocloft` + `num.counters` |
| `\incluirimagem` | dtx:1441-1458 | partly | `fig.graphicx` + `cap.kernel` + `fig.adjustbox` keys; its source line needs `\fonte` |
| `\fonte` width detection (`\larguratabular`, `\larguraimagem`, zero test with `\strip@pt`) | dtx:1023-1035, :1178, :1443 | no, by components | width read back from an earlier box and tested in hand-rolled logic; needs the class |
| `\tabular` patched with `adjustbox` | dtx:1177-1184 | no, by components | global patch of a kernel environment; needs the class |
| `\contentsline` patch (section entries upper case) | dtx:1252-1263 | no, by components | compares `\l@<type>` with `\l@section` inside a kernel macro; needs the class |
| glossary hooks `\glsxtruserparen`, `\glsuserdescription`, `\incluirsiglas` ... | dtx:1229-1242, :1467-1525 | no (EXTERNAL when enabled) | `idx.glossaries` + `bib2gls`; conditional |
| `substr` clash workaround | dtx:586-588 | no visible effect | clears `\su@ExpandTwoArgs` and kin; internal to the class |
| `ifluatex` gate | dtx:564-568 | yes | `font.unicode-math` under LuaLaTeX |

## Content-opaque
none (the zip has no figure or table artwork; the `\incluirimagem` image path is content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
