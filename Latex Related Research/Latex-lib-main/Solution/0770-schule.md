yes

# 0770-schule: schule (support for teachers at German schools), package manual doc/schule.tex

- Unverified: read from the source, not compiled.
- Source: Source/0770-schule/ (origin: https://mirrors.ctan.org/macros/latex/contrib/schule.zip; licence: LPPL 1.3, README:32-34)
- Kind: misc (the main sample is the package's own manual; the package makes assignment, exam and worksheet documents)
- Lib: v6
- Engine: pdfLaTeX-compatible (manual says it is tuned for pdflatex, doc/allgemeines.tex:292-293; `\iftutex` branch for Unicode engines, latex/schule.sty:247-250)
- Look carried by: mixed (page, headings, title, abstract, index and example boxes come from the published class `cnltx-doc`; the published CTAN package `schule` loaded in embedded mode `typ=ohne` adds packages and macros; the preamble adds refs and two aliases; doc/schule-dokumentation.sty adds the example box)
- Class origin: tex-distribution-unbundled (`cnltx-doc` is in the CTAN/TeX Live bundle `cnltx`, not in the zip; the zip's own `schule*.cls` compat classes are from the same CTAN release and are not loaded by the main sample)
- Main file: doc/schule.tex (other samples: doc/Beispiele/*.tex, 21 stand-alone examples with scrartcl/scrreprt/beamer and `typ=ab|kl|ueb|ib|ka|leit`; the manual shows only their first 10 lines, beispiele.tex:4-26; not analysed)
- Read: main yes (doc/schule.tex and all 38 files it `\include`s or `\input`s), zip-local classes and styles partly (everything the main sample loads was read: latex/schule.sty, modules Metadaten, Format, Kuerzel, Papiertypen, Symbole (TikZ path data only in outline), Texte, Formulare, fach Informatik, fach Physik, latex/relaycircuit.sty, doc/schule-dokumentation.sty; not read: modules Aufgaben, Aufgabenpool, Bewertung, Lizenzen, genord, Storycard, all `schule.typ.*` files, `data/xsim-style/*`, the legacy `schule*.cls/sty`, `schule.fach.Geschichte.*`, `source/Module/*`, because the main sample does not load them)

## Verdict
`yes`, and the verdict rests on one ruling: `schule` is on CTAN and in TeX Live (ctan.org/pkg/schule read: v0.11.0, 2026-01-30, LPPL 1.3, topics Teaching and Class; also README:44-65), so `latex/schule.sty`, its modules and `relaycircuit.sty` are published (W1), not zip-local. The sample is a `cnltx-doc` manual (published class) that loads that package with option settings and calls its macros by name; the only unpublished code is a 30-line `schule-dokumentation.sty` and three preamble aliases, all reducible. Several package-internal constructs (pgfmath TikZ grids, TikZ icons, an expl3 page counter, a Form wrapper, pgf shapes) do not reduce to existing lib ways; they are listed under "Bespoke code" with scope `package` so a stricter reader can count them, and they are not counted here because the emitter would call the published package, not copy its logic. If published package internals were counted, the verdict would be `no`.

## Blockers
none (see "Bespoke code" for the `package`-scope items that would block under a stricter definition)

## Class setting
- Class: `class.cnltx-doc` options: `a4paper`, `add-index` (doc/schule.tex:4)
- Class-native vocabulary used (none of it is defined in the zip, the class source was not read): `\setcnltx{name,title,version,date,subtitle,info,authors,email,url,abstract,index-setup,add-listings-options}` (schule.tex:52-75), `\newnote*` (schule.tex:76), environments `commands` `environments` `options` `example` `sidebyside` `sourcecode` (modulFormat.tex:9-144, faq.tex:6-8), macros `\command` `\environment` `\envidx` `\opt` `\keyval` `\keyval-` `\keychoice` `\keyis` `\Default` `\marg` `\oarg` `\sarg` `\darg` `\choices` `\cs` `\env` `\pkg` `\cls` `\option` `\code` `\verbcode` `\module` (used 14 times, defined nowhere in the zip, e.g. allgemeines.tex:296) `\sinceversion` `\changedversion` `\license` `\website` `\ctan` `\CTAN` `\cnltxat`, and the German short forms `\zB` `\vgl` `\usw` `\etc`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | schule.tex:4 | `class.cnltx-doc` | a4paper, add-index |
| paper size | schule.tex:4 | `page.class-options` | a4paper; no geometry package in the sample (faq.tex:13-20 shows geometry only as advice) |
| title block | schule.tex:52-61 | `front.class-native` | name, title, subtitle, info, authors, email, url, version=0.11.0, date=2026-01-30 |
| abstract | schule.tex:62-68 | `abs.class-native` | abstract key, two paragraphs |
| footnotes | schule.tex:67, lizenzen.tex:4 | `fn.kernel` | `\footnote{\CTAN}`, `\footnote{\materialsammlung}` |
| headings | allgemeines.tex:1,3,5,80; typLeitprogramm.tex:23 | `head.class-native` | `\part` `\section` `\subsection` `\subsubsection` `\paragraph`, look set by the class |
| index | schule.tex:4,69; modulAufgaben.tex:28 | `idx.makeidx` | add-index; index-setup othercode=\footnotesize, level=\section; `\envidx`; needs a makeindex pass (class source not read) |
| doc blocks | modulFormat.tex:9-71,127-144; modulPapiertypen.tex:11-33; faq.tex:6-8 | `class.cnltx-doc` | the environments above; gobble=4, gobble=12, outside=true |
| listing options | schule.tex:70-74; schule-dokumentation.sty:26 | `code.listings` | add-listings-options morekeywords={...}; `\lstinputlisting[style=cnltx,lastline=10]` |
| language | schule.sty:245 | `lang.babel` | `[\schule@sprache,ngerman]`, option sprache adds languages |
| encodings | schule.sty:246-250 | `font.fontenc-t1` | `[TS1,T1]` unless a Unicode engine |
| colour | schule.sty:262-263; Format.pakete:2-3; Format.optionen:27-28; Format.code:29-31 | `color.xcolor` | `table,dvipsnames`; option farbig (set at schule.tex:13) keeps colour, otherwise `\selectcolormodel{gray}` |
| links | schule.sty:289; schule.tex:23 | `meta.hyperref` | hyperref loaded by the package and again by the sample, no options |
| reference wording | schule.tex:32-40; allgemeines.tex:229 | `xref.prettyref` | `\newrefformat` for sec, paket, modul, klasse, fig, tab, ex, example; `\prettyref` |
| plain refs | modulSymbole.tex:3; modulAufgaben.tex:185 | `xref.kernel`, `xref.hyperref` | `\ref`, `\autoref`, `\label` |
| file inclusion | schule.tex:82-96; module.tex:16-26; dokumenttypen.tex:27-38 | `struct.input` | 8 `\include`, 30 `\input` |
| example box | schule-dokumentation.sty:1-12 | `box.tcolorbox` | libs skins, breakable; enhanced, enhanced jigsaw; boxrule=1pt, colback=cnltxbg, colframe=cnltx, arc=5pt, beforeafter skip=.5\baselineskip |
| example file entry | schule-dokumentation.sty:14-30; beispiele.tex:4-26 | `box.tcolorbox`, `code.listings`, `fig.graphicx`, `meta.hyperref` | step and label, sidebyside, righthand width=\linewidth/4, `\lstinputlisting[lastline=10]`, `\includegraphics[width=.8\linewidth]{PDF}`, `\href` to .tex and .pdf; 14 calls |
| pdf page thumbnails | schule.tex:46-50; modulAufgaben.tex:51; modulBewertung.tex:23,27,31 | `box.fancybox`, `fig.graphicx` | `\fbox{\includegraphics[page=,scale=,trim=,clip]{Beispiele/..}}` |
| lists | allgemeines.tex:47-78,210-251; changelog.tex:4-80 | `list.kernel` | itemize, description, nested itemize |
| tight lists | Format.code:49-54; allgemeines.tex:92-108 | `list.kernel`, `sp.lengths` | smallitemize/smallenumerate/smalldescription = the kernel list with `\itemsep -2pt` |
| columns | allgemeines.tex:91-109; modulKuerzel.tex:32-123; modulSymbole.tex:6-381; schule.tex:2 | `cols.multicol` | multicols{4}, {2}; `\PassOptionsToPackage{colaction}{multicol}` |
| tables | modulFormat.tex:98-108; modulKuerzel.tex:64-73 | `tbl.tabular`, `tbl.booktabs` | tabular{lcc}, `\toprule` `\midrule` `\bottomrule` |
| type size | modulSymbole.tex:11; modulKuerzel.tex:64 | `font.size-commands` | `\Huge`, `\tiny` |
| manual spacing | modulKuerzel.tex:13,30 | `sp.manual-space` | `\hfill`, `\hspace{1ex}` |
| text marks | Format.code:25,35; modulFormat.tex:26-69 | `mark.ulem`, `mark.kernel` | ulem[normalem]: `\uline` `\uuline` `\uwave` `\dashuline` `\dotuline` `\xout` `\sout`; `\person` = `\textsc` |
| hint and warning | Format.code:68-73; modulFormat.tex:16-39 | `mark.kernel`, `font.icons`, `sp.manual-space` | `\textbf{\llap{\usym{26A0}\space}Achtung:}`, `\usym{1F4A1}` |
| checkbox | Format.code:16-18 | `font.icons` | `\usym{2611}` or `\usym{2610}` |
| quotation marks | Format.code:80-84; modulFormat.tex:149-168 | `lang.csquotes` | `\ExecuteQuoteOptions{german=guillemets}`, option zitate=guillemets/quotes/swiss, `\enquote` |
| named symbols | Symbole.code:3-187; Symbole.pakete:1 | `font.icons` | 149 `\newcommand{\symX}{\usym{hex}}` aliases (utfsym) |
| Euro sign | Format.code:40-44; Format.pakete:39 | `font.icons`, `font.fontenc-t1` | eurosym, `\DeclareUnicodeCharacter{20AC}{\euro}` |
| script face | schule.tex:26; faq.tex:43 | `font.display` | `\usepackage{weva}` (bundle schulschriften, CTAN page read; it does not name weva, the manual's FAQ does, faq.tex:39), switch `\weva` |
| to-do notes | schule.tex:29 | `note.todonotes` | load only; `\todo` is not called in the body |
| filler text | schule.tex:25; modulTexte.tex:27,39,54 | `draft.todo` | blindtext, `\blindtext` inside examples |
| display maths | fachPhysik.tex:19-21 | `math.amsmath` | `\[ \]`, `\frac`, `\sqrt` (amsmath loaded at schule.sty:259) |
| units | Physik.code:4,9-21; Physik.pakete:4; fachPhysik.tex:20 | `mark.siunitx`, `math.nicefrac` | `\sisetup{exponent-product=\cdot, output-decimal-marker={,}}`; `\unit`, `\unitfrac` redefined over `\nicefrac` |
| decimal comma | Physik.pakete:7; fachPhysik.tex:5 | `math.icomma` | `ziffer` (same type: load-only decimal comma in maths; the lib line names icomma; the CTAN page of ziffer was not read) |
| school macro package | schule.tex:6-21; schule.sty:11-325 | `NEW:exam.schule` | typ=ohne, fach=ohne, weitereFaecher={Informatik,Physik}, farbig, module={Kuerzel,Papiertypen,Symbole,Texte,Formulare}; default modules Metadaten, Format (schule.sty:183-188); pgfkeys options schule.sty:31-41 |
| text abbreviations | Kuerzel.code:7-79; modulKuerzel.tex:34-121 | `NEW:exam.schule` | `\Lkr` `\EuE` `\GK` ...; `\SuS` `\LuL` `\KuK` by option gendering=split(default)/gap/star/binneni/fem/mas (Kuerzel.optionen:3,7-10) |
| metadata macros | Metadaten.code:9-25; Metadaten.optionen:7-14 | `NEW:exam.schule` | `\Titel` `\Autor` `\Datum` `\Fach` `\Lerngruppe` `\DokumentNummer`; options lerngruppe, nummer |
| writing grids | Papiertypen.code:13-50; modulPapiertypen.tex:14-32 | `NEW:exam.schule` | `\feldLin[1cm]{n}`, `\feldKar[0.5cm]{n}`, `\feldMil{n}`; colour farbeMillimeterpapier (orange or gray by farbig) |
| icon drawings | Symbole.code:202-425; modulSymbole.tex:385-402 | `NEW:exam.schule` | `\uebungBild` `\hinweisBild` `\wegweiserBild` `\zielBild` `\buchBild` `\krankenwagenBild` `\uebungPCBild` `\gluehlampeBild` `\lernkontrolleBild`, no arguments |
| numbered text | Texte.code:6-52; Texte.pakete:6-7; modulTexte.tex:22-71 | `NEW:exam.schule`, `sp.draft-lineno`, `cols.multicol` | `zeilenNr[5]`, `zeilenNrZweispaltig`, `zeilenNrMehrspaltig[5]{n}`, `mehrspaltig[2]`, `\resetZeilenNr` |
| form field | Formulare.code:3-16; modulFormulare.tex:13-15 | `NEW:exam.schule` | `\feldLinFormular[0.5cm]{3}`; whole document wrapped in hyperref `Form` |
| page counter and head macros | Format.code:92-240 | `NEW:exam.schule` | `\Seitenzahlen`, `\schule@kopf*`, `\hierkeineseitenzahl`; options seitenzahlen, datumAnzeigen, namensfeldAnzeigen; defined by the loaded module but not called by the main sample (typ=ohne) |
| subject Informatik | Informatik.code:7-166; Informatik.pakete:3-12; fachInformatik.tex:1-167 | `NEW:exam.schule`, `code.listings` | lstdefinestyle Basis/Python/Java, `\newthreadtwo`, `\nextlevel`, `\anchormark`, tikzset `pap`; loads struktex[pict2e], relaycircuit, pgf-umlcd[school], pgf-umlsd[underline=false,rounded corners=true], syntaxdi, tikz library er |
| subject Physik | Physik.code:4-33; Physik.pakete:4-7; fachPhysik.tex:1-45 | `NEW:exam.schule` | `\elementarladung` ... `\rydbergfrequenz` (7 constants over `\unit`), circuitikz[siunitx,nooldvoltagedirection], nicefrac, mhchem[version=3], ziffer |
| relay shapes | relaycircuit.sty:22-175; zusatzpaketRelaycircuit.tex:10-47 | `NEW:exam.schule` | two `\pgfdeclareshape` (ruhe relais, arbeits relais), loaded unconditionally by fach Informatik (Informatik.pakete:4) |
| load-only dependencies | Format.pakete:8-43; schule.sty:77-84,253-259 | `NEW:exam.schule` | enumitem[inline], multirow, multicol, longtable, ctable, colortbl, array, tasks, csquotes, setspace, ulem, xspace, amssymb, eurosym, zref-totpages, refcount, xparse, environ, amsmath, silence; none needs a tool outside TeX |

## Bespoke code
Unpublished code (the emitter must not copy it):

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `cnltxcode` box | schule-dokumentation.sty:5-12 | yes | `box.tcolorbox` newtcolorbox with boxrule=1pt, colback=cnltxbg, colframe=cnltx, arc=5pt, beforeafter skip=.5\baselineskip; colours come from the class |
| `\Beispieldatei{file}{title}` and counter `examplefile` | schule-dokumentation.sty:14-30 | yes | expand inline at each of the 14 calls (beispiele.tex:4-26): `box.tcolorbox` with `step and label`, sidebyside keys, title text with two `\href`, `code.listings` `\lstinputlisting[style=cnltx,lastline=10]`, `fig.graphicx` `\includegraphics` in `\fbox` (`box.fancybox`) |
| `\materialsammlung` | schule.tex:42-44 | yes | alias of the class macro `\website{URL}`; used at lizenzen.tex:4 |
| `\includepdfpage[opts]{file}` | schule.tex:46-50 | yes | `\fbox{\includegraphics[page=1,scale=0.3,<opts>]{Beispiele/file}}`; 4 uses (modulAufgaben.tex:51, modulBewertung.tex:23,27,31) |
| `\deprecatedversion` | schule.tex:76 | yes | class vocabulary `\newnote*` with text "Veraltet seit #1"; used at modulBewertung.tex:45 |

Published package internals (CTAN `schule`, called by name; tagged with the scope a stricter reader would use):

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\feldLin` `\feldKar` `\feldMil` | Papiertypen.code:13-50 | no (BESPOKE/package) | TikZ `\foreach` and `\pgfmathtruncatemacro` count how many lines or squares fit `\linewidth`; no lib way draws a writing grid |
| nine TikZ icon commands | Symbole.code:202-425 | no (ART/package) | hand-traced path data (170 lines with `\path`); not a lib icon way (`font.icons` needs a font glyph) |
| `\Seitenzahlen` | Format.code:94-173 | no (BESPOKE/package) | expl3 integer written to the aux file by `\iow_now:cx`, read back on the next run, mixed with `\ztotpages`; not called by the sample |
| `\feldLinFormular` and `Form` wrapper | Formulare.code:3-16 | no (BESPOKE/package) | `\AtBeginDocument{\begin{Form}}` plus a `\TextField` inside a TikZ node over drawn lines; no lib form way for hyperref forms |
| `zeilenNrZweispaltig` | Texte.code:14-28 | partly | `sp.draft-lineno` in `cols.multicol`; the alternating side is a redefinition of lineno's `\makeLineNumber` through multicol's `\docolaction` |
| `\newthreadtwo`, `\anchormark`, `\nextlevel` | Informatik.code:99-117 | no (BESPOKE/package) | extend `pgf-umlsd` internals (`\newinst`, counters `threadnum` `instnum` `seqlevel`) and an overlay TikZ node; content support for diagrams |
| `pap` TikZ styles | Informatik.code:127-166 | no (BESPOKE/package) | `\tikzset` node styles (startstop, verzweigung, aktion, einausgabe, unterprogramm, linie) with a blur shadow when farbig; used only inside diagram content |
| relay-circuit shapes | relaycircuit.sty:22-175 | no (BESPOKE/package) | `\pgfdeclareshape` with anchors and background paths; used only inside circuit content |
| `\Lkr` ... `\KuK`, `\Titel` ... | Kuerzel.code:7-79; Metadaten.code:9-25 | yes | text aliases; the gendering variant is fixed at emit time by `\IfEqCase` on a string option |
| `\unit`, `\unitfrac`, 7 constants | Physik.code:9-33 | yes | aliases over `mark.siunitx` and `math.nicefrac`; the maths-mode test inlines |
| `\achtung` `\hinweis` `\so` `\person` `\chb` `\diastring` `smallitemize` etc. | Format.code:16-87 | yes | aliases of `mark.kernel`, `font.icons`, `mark.ulem`, `list.kernel`, `sp.lengths` as in the map |
| `\symX` aliases | Symbole.code:3-187 | yes | `\usym{hex}` calls (`font.icons`) |
| module loader | schule.sty:115-206 | yes | file and option bookkeeping only; the emitter writes the option list |

No text addressed to an AI was found in the zip.

## Content-opaque
- TikZ object diagram with `pgf-umlcd` (fachInformatik.tex:38-72), sequence diagram with `pgf-umlsd` (fachInformatik.tex:87-107), Nassi-Shneiderman chart with `struktex` (fachInformatik.tex:116-133), flowchart with the `pap` style (fachInformatik.tex:150-167), `circuitikz` circuit (fachPhysik.tex:27-45), relay circuit (zusatzpaketRelaycircuit.tex:10-47): `art.tikz` and `art.content-package`, inside `example` blocks.
- Physics equations (fachPhysik.tex:19-21); `\weva` sample line (faq.tex:43); Unicode symbol tables (modulSymbole.tex:6-381).
- Shipped PDF screenshots of example documents (beispiele.tex:4-26; modulAufgaben.tex:51; modulBewertung.tex:23,27,31), assets in doc/Beispiele/.

## Lib changes
- New ways proposed: `NEW:exam.schule` `schule` package (CTAN `macros/latex/contrib/schule`, TeX Live, MiKTeX, LPPL 1.3, v0.11.0; pdfLaTeX): `\usepackage[typ=,fach=,weitereFaecher=,module=,farbig,gendering=,seitenzahlen=,zitate=,lerngruppe=,nummer=,sprache=]{schule}` and body macros and environments of its modules. W1: on CTAN (page read). W2: chosen by option keys and macro arguments (module list, subject list, document type, colour switch, gendering and quote variants). W3: serves one kind of document family, teaching material for German schools (worksheets, exams, information sheets, guided-learning programs) with subject modules, not one document; weaker than a single-purpose package, because this sample uses it only as an embedded macro bundle (`typ=ohne`). W4: one `\usepackage` line plus calls by name. Kept apart from `exam.questions` (question-bank packages) because this sample uses none of its question environments (the Aufgaben and Bewertung modules, the xsim-based part, were not loaded and not read); the consolidator may fold it into `exam.questions` with the package as the parameter. Its pgfmath grids, icon drawings, expl3 page counter and Form wrapper are inside the way and are not reducible to other lib ways.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
