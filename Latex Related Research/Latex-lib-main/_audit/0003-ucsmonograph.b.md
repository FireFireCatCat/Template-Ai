yes

# 0003-ucsmonograph: ucsmonograph (UCS/ABNT monograph class, source distribution)

- Unverified: read from the source, not compiled.
- Source: Source/0003-ucsmonograph/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ucsmonograph.zip; licence: LPPL 1.3c)
- Kind: thesis
- Lib: v2
- Engine: pdfLaTeX-compatible (LuaLaTeX is optional: with it the class loads `unicode-math` and Latin Modern, ucsmonograph.dtx:564-568; the documented example uses `inputenc`/`fontenc`, :264-265)
- Look carried by: class (the zip is the source of the published class: everything the look needs is in `ucsmonograph.cls`, generated from ucsmonograph.dtx:515-1528 by ucsmonograph.ins:50; a document only sets options and strings)
- Class origin: ctan (one read of https://ctan.org/pkg/ucsmonograph: CTAN package v1.3.0, LPPL 1.3c, in TeX Live and MiKTeX; README.md:57-60 says the same)
- Main file: none (no `.tex` sample; the only `\documentclass`/`\begin{document}` pair is the `ltxdoc` documentation driver at ucsmonograph.dtx:39-56; the template example is the verbatim block at ucsmonograph.dtx:262-290) (other samples: none)
- Read: main yes (no `.tex` sample exists; I read the whole `.dtx`, 1532 lines, driver and example included), zip-local classes and styles all (the class ships only as `.dtx`; its code, lines 515-1528, read in full; `ucsmonograph.cls` is not in the zip; `abntex2` source is not in the zip and was not read; `ucsmonograph.pdf` is the compiled documentation and was not read)

## Verdict
The look is one published CTAN class, `ucsmonograph` (W1 passes: CTAN, TeX Live and MiKTeX). It is already in the lib as `class.ucsmonograph` with the native vocabulary this file uses. A document needs only the `\documentclass` line, string-valued setters (`\titulo`, `\autor`, `\preambulo`, `\orientador`, `\palavraschave`...), the print commands (`\imprimircapa`, `\imprimirfolhaderosto`, `\imprimirfolhadeaprovacao`) and the environments (`resumo`, `dedicatoria`, `epigrafe`, `quadro`). No macro logic has to be copied from the zip, so there is no bespoke code in the rubric's sense. The `.dtx` holds many irreducible hacks (listed below); under W1 they are the published class's own internals, not zip-local code.
Conditional, not a blocker for the documented example: the class options `siglas` and `simbolos` load `glossaries-extra` with `record`, which needs the external tool `bib2gls` (ucsmonograph.dtx:244-246, 650). That is `EXTERNAL/package` only when either option is selected, like `mode=build*` for `pg.standalone-pkg`. The unconditional load of `glossaries-extra` at :653 has no `record` option and needs no outside tool, so the rubric's unconditional-load ruling does not apply.

## Blockers
none (conditional note on `siglas`/`simbolos` above; the documented example, :263, selects neither)

## Class setting
- Class: `class.ucsmonograph` options: `12pt`, `oneside`/`twoside`, language names with the main language last (`english,brazil`), `lmodern` (switch, :538), `cite=alf|num` (string, default `alf`, :533-534), `siglas` (:542) and `simbolos` (:546) (both EXTERNAL when selected); every other option is forwarded to `abntex2` (:553); fixed options passed to the base: `openright,a4paper,chapter=TITLE,section=TITLE` (:555).
- Class-native vocabulary used: setters `\titulo` `\autor` `\data` `\instituicao` `\local` `\preambulo` `\areadoconhecimento` `\orientador` `\avaliadori` `\avaliadorii` `\avaliadorext[inst]` `\palavraschave[lang]` (:267-282, 1133-1163, 1293-1376); print commands `\imprimircapa` `\imprimirfolhaderosto` `\imprimirfolhadeaprovacao[inst]{date}` `\imprimirpalavraschave` (:285-287, 921, 968, 1386, 1123); environments `resumo[lang]` `dedicatoria` `epigrafe` `quadro`, `\listofquadros[*]` (:342-380, 694-724); `\fonte[width]{text}` `\incluirimagem[scale]{path}{caption}{source}` and starred form (:1023, 1441, 1454); with the options: `\incluirsiglas` `\listofsiglas*` `\incluirsimbolos` `\listofsimbolos*` (:1468-1524).
- The base class is `class.abntex2` (:555, source not read); its hooks used here are `\ABNTEX*font`, `\cft*font`, `\afterchapskip`, `capa`, `folhaderosto`, `folhadeaprovacao`, `\imprimirpreambulo`, `\PRIVATEbookmarkthis`. Commands such as `\makepagestyle`, `\newlistof`, `\setaftersecskip` and `\SingleSpacing` are memoir's, inherited through abntex2 (inferred from the commands; ctan.org/pkg/abntex2 does not state the base class).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | ucsmonograph.dtx:34-36, 263 | `class.ucsmonograph` | `12pt,oneside,english,brazil,lmodern,cite=num` (documented example) |
| base class | ucsmonograph.dtx:555 | `class.abntex2` | `openright,a4paper,chapter=TITLE,section=TITLE` |
| paper and size | ucsmonograph.dtx:555, 263 | `page.class-options` | `a4paper`, `12pt`, `oneside`/`twoside` |
| page geometry | ucsmonograph.dtx:610 | `page.geometry` | top=3cm, left=3cm, bottom=2cm, right=2cm |
| flush | ucsmonograph.dtx:611 | `pg.flush` | `\raggedbottom` |
| line spacing | ucsmonograph.dtx:795 | `sp.linespread` | 1.4 (Word 1.5 equivalent at 12pt, :793); `\SingleSpacing` inside covers, abstract, notes (:998, 1051, 1072, 1095) |
| paragraph | ucsmonograph.dtx:614, 801, 809 | `sp.lengths`, `sp.indentfirst` | `\parskip`=0pt, `\parindent`=1.5cm, `indentfirst` loaded |
| vertical gaps | ucsmonograph.dtx:819-829, 838-840, 849-853 | `sp.lengths`, `head.memoir-style` | `\afterchapskip` and `\setaftersecskip` to `\setafterparaskip` = `\baselineskip`; `\textfloatsep` `\floatsep` `\intextsep` = 1.5`\baselineskip`; display skips 1`\baselineskip` plus 5pt minus 5pt; `\jot`=2ex |
| header and footer | ucsmonograph.dtx:737-739 | `hf.memoir-pagestyle` | `\makepagestyle{abntheadings}`; page number only, in `\ABNTEXfontereduzida`, right on odd pages, left on even pages |
| text font | ucsmonograph.dtx:538, 604-606 | `font.lmodern` | switch via class option `lmodern` |
| math font (LuaLaTeX only) | ucsmonograph.dtx:564-568 | `font.unicode-math` | `math-style=upright`; also forces `lmodern` |
| encoding in the example | ucsmonograph.dtx:264-265 | `font.fontenc-t1` | `inputenc` utf8, `fontenc` T1 |
| heading look | ucsmonograph.dtx:555, 759-772 | `head.class-native` | `chapter=TITLE`, `section=TITLE`; chapter `\bfseries`, section `\mdseries`, subsection `\bfseries`, subsubsection `\mdseries`, subsubsubsection `\itshape`; all sizes `\normalsize` |
| heading number gap | ucsmonograph.dtx:895-911 | `head.class-native` | `\printchapternum` and `\@seccntformat` redefined to `number` + one space |
| contents entries | ucsmonograph.dtx:781-785, 1252-1263 | `toc.tocloft` | `\cft{chapter,section,subsection,subsubsection,paragraph}font` copy the heading fonts; section entries upper-cased |
| lists of contents and bookmarks | ucsmonograph.dtx:1193-1220 | `toc.kernel` | `\tableofcontents` `\listoffigures` `\listoftables` each preceded by `\pdfbookmark[0]` |
| quadro float and list | ucsmonograph.dtx:691-724 | `fig.float`, `toc.tocloft` | `\newfloat{quadro}{Quadro}{loq}[chapter]`, `\restylefloat*`, `\setfloatlocations{quadro}{hbtp}`, `\newlistof`/`\newlistentry`, `\cftquadroname`, `\cftquadroaftersnum`=`\hfill\textendash\hfill`, `\counterwithout{quadro}{chapter}` |
| captions | ucsmonograph.dtx:608, 1022 | `cap.caption` | package loaded with no options; `\ABNTEXcaptionfontedelim`=": " |
| source line under floats | ucsmonograph.dtx:1023-1035 | `fig.class-native`, `box.minipage`, `sp.ragged` | `\fonte[width]{text}`: `\footnotesize`, `\raggedright`, minipage of the table or figure width |
| image with caption and source | ucsmonograph.dtx:1441-1458 | `fig.class-native`, `fig.adjustbox`, `fig.graphicx` | `\incluirimagem[scale]{path}{caption}{source}`; `adjustimage` with `scale`, `fbox=1.5pt {\fboxsep} 1pt`, `center` |
| tables | ucsmonograph.dtx:1175-1184 | `tbl.tabular`, `fig.adjustbox` | kernel `tabular` wrapped in `adjustbox{gstore width=\larguratabular}` |
| maths | ucsmonograph.dtx:618-619, 624, 632, 849-853 | `math.amsmath`, `math.icomma`, `num.counters` | `\allowdisplaybreaks`; `icomma`; `\counterwithout{equation}{chapter}` |
| lists | ucsmonograph.dtx:864-872 | `list.enumitem` | `\setlist[enumerate,1]{labelindent=\parindent, leftmargin=\parindent+0.6cm, nosep, label=\alph*)}`; `\setlist[itemize,1]{nosep, label=--}`; `enumitem` is not loaded in this file, so abntex2 must load it (not read) |
| bibliography | ucsmonograph.dtx:575-581, 881-886 | `bib.apacite`, `bib.cite-pkg`, `bib.bibtex-bst` | `abntex2cite` with `cite` value, `abnt-etal-list=3`, `abnt-etal-text=it`, `abnt-full-initials=no`; for `cite=num` also `\citebrackets[]` and `cite`; `\itemsep`=`\baselineskip`, `\parskip`=0pt; BibTeX with abntex2's `.bst` |
| cover | ucsmonograph.dtx:921-947 | `front.class-native`, `pg.textpos`, `sp.manual-space`, `mark.kernel` | `capa` env, `\bfseries\centering`, upper-case institution and area; author and title in `textblock*{160mm}` at (30mm, 297mm/4+15mm) and (30mm, 297mm/2); `textpos[absolute]` |
| title page | ucsmonograph.dtx:957-1009 | `front.class-native`, `pg.textpos`, `box.minipage` | `folhaderosto` env; bold, centred, title `textblock*` at 297mm/2; preamble minipage .5`\textwidth` at hspace .45`\textwidth`, `\mdseries`, `\SingleSpacing`, advisor line |
| approval page | ucsmonograph.dtx:1386-1433 | `front.class-native`, `box.minipage` | `folhadeaprovacao` env; author, title, preamble minipage, `\imprimirorientador`, evaluators printed only when set; `\ABNTEXsignskip` |
| dedication | ucsmonograph.dtx:1044-1056 | `front.dedication`, `box.minipage` | `\vspace*{\fill}`, `\hspace{.5\textwidth}`, minipage .45`\textwidth` bottom-aligned |
| epigraph | ucsmonograph.dtx:1065-1077 | `front.class-native`, `box.minipage` | same box; `\itshape\raggedleft`; author bolded by hand (:373-379) |
| abstract and keywords | ucsmonograph.dtx:1086-1114, 1123-1124, 1293-1304 | `abs.class-native`, `abs.keywords`, `lang.babel` | `resumo[lang]` = `otherlanguage` + `abstract`, `\abstractname` upper-cased, `\SingleSpacing`; `\imprimirpalavraschave` = bold `\palavraschavename` + keywords; per-language store through `\addto\captions<lang>` |
| language names | ucsmonograph.dtx:672-682, 748-751, 1271-1272 | `lang.babel` | `\palavraschavename` per language (brazil, english, german, spanish); `\listfigurename`, `\listadesimbolosname`; `\foreignlanguage` italic |
| PDF metadata | ucsmonograph.dtx:593-599, 1133-1163, 1296-1298 | `meta.hyperref` | `unicode=true`, `pdfcreator`, `colorlinks=true`, `linkcolor=black`, `citecolor=black`; `pdftitle` `pdfauthor` `pdfsubject` `pdfkeywords` set by the setters |
| acronyms and symbols (options) | ucsmonograph.dtx:641-662, 1229-1242, 1467-1525 | `idx.glossaries` | `glossaries-extra` with `acronyms`/`symbols`, `record,toc=false,nonumberlist,style=long`; `\setabbreviationstyle[acronym]{long-short}`; `\glsdescwidth`=`\linewidth`; EXTERNAL (`bib2gls`) when selected |
| documentation driver (not the template) | ucsmonograph.dtx:40-55 | `class.ltxdoc`, `dtx.doc`, `lang.babel`, `font.fontenc-t1`, `font.lmodern`, `meta.hyperref` | `babel[brazil]`, `inputenc[utf8]`, `fontenc[T1]`, `lmodern`, `hyperref` `colorlinks=true,linkcolor=black`; `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput` |

## Bespoke code
All rows sit inside the published class (W1), so none is counted for the verdict. The third column answers the stricter question: would it reduce if the class were treated as zip-local code?
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\imprimircapa` cover rewrite | ucsmonograph.dtx:921-947 | yes (BESPOKE/class if counted: no) | `capa` env + two `textblock*` boxes: `pg.textpos` with fixed lengths; the content is strings |
| `folhaderosto` env and `\folhaderostocontent` | ucsmonograph.dtx:957-1009 | yes | `pg.textpos` + `box.minipage`; the env redefinitions only fix a fragile-command error (:954) |
| `\imprimirfolhadeaprovacao` | ucsmonograph.dtx:1386-1433 | no | emptiness conditionals (`\ifthenelse{\not\equal{\@avaliadori}{}}`) decide which lines print (BESPOKE/class if counted) |
| `\contentsline` redefinition | ucsmonograph.dtx:1251-1263 | no | patches the kernel toc line, with a `\csname l@#1\endcsname\ifx\l@section` test, to upper-case section entries (BESPOKE/class if counted) |
| `\printchapternum`, `\@seccntformat` | ucsmonograph.dtx:895-911 | no | redefine abntex2 and kernel internals for the number-title gap (BESPOKE/class if counted) |
| `\tabular`/`\endtabular` wrapper | ucsmonograph.dtx:1175-1184 | no | redefines the kernel environment to store the table width in `\larguratabular` (BESPOKE/class if counted) |
| `\fonte` with width state | ucsmonograph.dtx:1023-1035 | no | the width of the previous table, read through `\strip@pt`, drives a minipage (BESPOKE/class if counted) |
| `resumo` env and `\palavraschave` store | ucsmonograph.dtx:1089-1114, 1293-1304 | no | `\@ifnextchar` options, `\abstractname` swap, text kept inside `\captions<lang>` hooks (BESPOKE/class if counted) |
| `dedicatoria`, `epigrafe` wrappers | ucsmonograph.dtx:1044-1077 | yes | old env + `\vspace*{\fill}` + minipage: `front.dedication`, `box.minipage` |
| `thebibliography` wrapper | ucsmonograph.dtx:881-886 | yes | `\parskip`=0pt, `\itemsep`=`\baselineskip`: `sp.lengths` |
| `quadro` float and list | ucsmonograph.dtx:691-724 | yes | `fig.float` `\newfloat` + `toc.tocloft` list entries + `num.counters` |
| list-of bookmark wrappers | ucsmonograph.dtx:720-724, 1193-1220 | yes | a `\pdfbookmark` line before each list: `meta.hyperref` |
| `\incluirimagem` and starred form | ucsmonograph.dtx:1441-1458 | yes | `\caption` + `\adjustimage` (`fig.adjustbox`) + `\fonte` |
| setters extended with `\hypersetup` | ucsmonograph.dtx:1132-1163 | yes | `meta.hyperref` keys `pdftitle` `pdfauthor` `pdfsubject` |
| `glossaries-extra` hooks | ucsmonograph.dtx:1229-1242, 1467-1525 | yes, but EXTERNAL when selected | `\glsxtruserparen`, `\glsuserdescription`, `\GlsXtrLoadResources` need `bib2gls` (EXTERNAL/package when `siglas`/`simbolos` is chosen) |
| `substr` conflict patch | ucsmonograph.dtx:586-588 | no | `\let\su@ExpandTwoArgs\relax` etc.; no visible effect; a package-conflict workaround (BESPOKE/class if counted) |
| `\foreignlanguage` italic wrapper | ucsmonograph.dtx:1271-1272 | yes | `lang.babel` command plus `\emph` |
| option switches | ucsmonograph.dtx:517-524, 538-548, 565-568, 604-606 | yes | booleans behind `lmodern`, `siglas`, `simbolos`, LuaLaTeX detection: class options |

## Content-opaque
none (the documented example holds only strings: title, author, institution, preamble text, keywords, dates, ucsmonograph.dtx:267-282)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Note for the consolidator: `class.ucsmonograph` already lists options `12pt`, `oneside`/`twoside`, `cite=alf|num`; the options `lmodern`, `siglas` and `simbolos` and the language-name options are also native to it (`siglas`/`simbolos` EXTERNAL when selected).
