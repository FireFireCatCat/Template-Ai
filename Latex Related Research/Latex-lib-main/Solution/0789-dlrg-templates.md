no

# 0789-dlrg-templates: DLRG corporate-design templates (package `dlrg`, types pub, letter, beamer, message)

- Unverified: read from the source, not compiled.
- Source: Source/0789-dlrg-templates/ (origin: https://mirrors.ctan.org/macros/latex/contrib/dlrg-templates.zip; licence: LPPL 1.3c, README:25-27)
- Kind: misc (the main sample is the package manual; the package serves a publication, a letter, a presentation and a press release of one organisation)
- Lib: v6
- Engine: pdfLaTeX-compatible (default branch loads `uarial`; the DLRG Univers branch under `\iftutex` needs XeLaTeX or LuaLaTeX with `fontspec`, latex/dlrg.mod.Schrift.code.tex:2-10, latex/dlrg.mod.Schrift.pakete.tex:1-8)
- Look carried by: zip-local (latex/dlrg.sty and the latex/dlrg.*.tex files it `\input`s, loaded over the unbundled KOMA classes; the package is on CTAN with this zip, so W1 holds, but its look is its own TikZ/pgf code, see Verdict)
- Class origin: tex-distribution-unbundled (scrartcl, scrlttr2 and beamer are not in the zip; ctan.org/pkg/dlrg-templates read: the package is on CTAN, LPPL 1.3c, v1.1.0 of 2025-03-15, in TeX Live and MiKTeX)
- Main file: doc/dlrg.tex (other samples: doc/Beispiele/dlrg_muster_publikation.tex, dlrg_muster_brief.tex, dlrg_muster_vortrag.tex, dlrg_muster_hausarbeit.tex, dlrg_muster_mitteilung.tex, dlrg_muster_mitteilung_serie.tex, dlrg_muster_dokument.tex; doc/typ*.tex and doc/modul*.tex are sub-documents pulled in by `\input` from the main file)
- Read: main yes, zip-local classes and styles all

## Verdict
no. The zip is the CTAN release of the `dlrg` package, so `dlrg.sty` itself passes W1, but it is not one way under W2 and W3: `typ=` and `module=` only choose which zip-local code files get `\input` (latex/dlrg.sty:85-107, 116-135), and it serves one organisation's corporate design. Read file by file, the look of every document type is hand-drawn TikZ: the Stoerer title banner on two custom `\pgfdeclareshape` shapes, the red Bauchbinde band with wordmark, and the half-eagle watermark. That is template-defining artwork with no declarative lib way, plus irreducible pgf shape code and a copied block of cnltx class macros. The rest (headers, tables, boxes, KOMA letter, beamer colours, bibliography, index) reduces to lib ways, listed below. Re-reading under another definition: if a CTAN house-style package were accepted whole as a class-like way, every blocker below is tagged `class` and would fall away, leaving only content.

## Blockers
- `ART/class` Stoerer title banner (red/yellow or white box with cut corners) at the top-left of the title page, drawn as a TikZ node of a custom shape (latex/dlrg.mod.Stoerer.code.tex:49-87, latex/dlrg.typ.pub.code.tex:69-86)
- `BESPOKE/class` two custom pgf shapes `stoererLinks` and `stoererRechts` with `\backgroundpath` code (latex/dlrg.mod.Stoerer.code.tex:4-45); no lib way declares a pgf shape
- `ART/class` Bauchbinde: full-width red band at the page foot with wordmark image and yellow link text, a `remember picture,overlay` TikZ drawing used on the title page and in the footer of three types (latex/dlrg.mod.Bauchbinde.code.tex:9-17; used latex/dlrg.typ.pub.code.tex:47,88, latex/dlrg.typ.message.code.tex:65, latex/dlrg.typ.doc.code.tex:4)
- `ART/class` half-eagle outline and watermark, a 13-point TikZ path with opacity and scale (latex/dlrg.mod.Adler.code.tex:10-24; used latex/dlrg.typ.pub.code.tex:71, latex/dlrg.typ.message.code.tex:32)
- `ART/class` Personenicon pictograms, five commands that draw people from above with ellipses, rectangles and conditionals on gender and equipment, loaded by the main sample (latex/dlrg.mod.Personenicon.code.tex:29-146; module chosen at doc/dlrg.tex:16; drawn inline at doc/modulPersonenicon.tex:34-46)
- `BESPOKE/class` Paketbeschreibung module: hand-written `\@ifnextchar` argument parsers, list wrappers and `\Default` printers copied from the cnltx class, defining the `commands`, `options`, `environments` environments the main sample uses (latex/dlrg.mod.Paketbeschreibung.code.tex:8-209; header comment at 1-4; used doc/dlrg.tex:87-89)
- `ART/class` beamer footline, headline and title page: TikZ overlay band, wordmark and rule on every frame (latex/beamerouterthemeDLRG.sty:28-74); other sample doc/Beispiele/dlrg_muster_vortrag.tex:1-21
- `ART/class` Hausarbeit title page Stoerer in white at the north-east corner (latex/dlrg.mod.Hausarbeit.code.tex:53-61); other sample doc/Beispiele/dlrg_muster_hausarbeit.tex:49

## Class setting
- Class: `class.scrartcl` options: a4paper, 12pt, parskip=half, bibliography=totoc (doc/dlrg.tex:1-6); the other types use `class.scrlttr2` (doc/Beispiele/dlrg_muster_brief.tex:1) and `class.beamer` (doc/Beispiele/dlrg_muster_vortrag.tex:1); the `dlrg` package is loaded over them, not instead of them
- Class-native vocabulary used: KOMA `\addtokomafont` `\setkomafont` `\KOMAoptions` `\automark` `\ihead` `\chead` `\ohead` `\ifoot` `\cfoot` `\ofoot` `\storeareas` `\activateareas` `\cleardoubleoddpage` (latex/dlrg.typ.pub.code.tex:8-62,110-128); scrlttr2 `\LoadLetterOption{DIN5008B}` `\newkomavar` `\setkomavar` `\usekomavar` `\Ifkomavarempty` `\setplength` `\opening` `\closing` `letter` env (latex/dlrg.typ.letter.code.tex:3-146, doc/Beispiele/dlrg_muster_brief.tex:43-66); beamer `frame` `\titlepage` `block` (doc/Beispiele/dlrg_muster_vortrag.tex:19-57)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | doc/dlrg.tex:1-6 | `class.scrartcl` | a4paper,12pt,parskip=half,bibliography=totoc |
| paper and size | doc/dlrg.tex:2-3 | `page.class-options` | a4paper, 12pt |
| encodings | doc/dlrg.tex:7; latex/dlrg.sty:189-190 | `font.fontenc-t1` | inputenc utf8; fontenc TS1,T1 |
| language | latex/dlrg.sty:188 | `lang.babel` | options `\dlrg@sprache` (empty default), ngerman |
| maths | latex/dlrg.sty:198 | `math.amsmath` | load-only |
| colours | latex/dlrg.sty:201-202; latex/dlrg.mod.Farben.code.tex:3-6 | `color.xcolor` | table,dvipsnames; dlrgRot 227,6,19; dlrgGelb 253,235,30; dlrgSchwarz 87,87,86; dlrgBlau 5,105,180 |
| default family | latex/dlrg.mod.Schrift.code.tex:1 | `font.family-default` | `\familydefault` = `\sfdefault` |
| sans face (pdfTeX branch) | latex/dlrg.mod.Schrift.pakete.tex:6-7 | `font.helvet` | `uarial` scaled (Arial substitute), fontenc T1; fonts not shipped |
| house font (XeTeX/LuaTeX branch) | latex/dlrg.mod.Schrift.code.tex:2-10; latex/dlrg.mod.Schrift.pakete.tex:2 | `font.fontspec` | `\setmainfont{DLRG Univers 55 Roman}`, BoldFont and ItalicFont same file, ItalicFeatures FakeSlant=.2; font not shipped |
| links | latex/dlrg.sty:207; latex/beamercolorthemeDLRG.sty:19 | `meta.hyperref` | load-only; beamer: colorlinks=true, urlcolor=red, linkcolor=black |
| page style, running head | latex/dlrg.typ.pub.code.tex:3,15-25,39 | `hf.scrlayer-scrpage` | pagestyle scrheadings; headsepline=0.7pt in dlrgRot; pagehead `\normalfont`; `\automark[section]{section}`; `\ihead{\headmark}`; `\chead{}`; `\ohead{\thetitle}` |
| footer, footline layout (default) | latex/dlrg.typ.pub.code.tex:51-63 | `hf.scrlayer-scrpage` | footsepline=0.7pt in dlrgRot; `\ifoot` wordmark image 0.7em; `\ofoot{\pagemark}`; `\cfoot{}` |
| head and foot, bauchbinde layout | latex/dlrg.typ.pub.code.tex:27-49 | `hf.scrlayer-scrpage` | pagenumber white; `\lehead` `\rohead` number boxes; `\ifoot{\bauchbinde*{}}` (the band itself is ART above) |
| red number box in head | latex/dlrg.typ.pub.code.tex:30-35 | `box.fancybox` | `\colorbox{dlrgRot}` around `\parbox{6em}` (`box.minipage`) |
| heading colour | latex/dlrg.typ.pub.code.tex:8-11 | `head.koma-fonts` | `\addtokomafont{section,subsection,subsubsection,paragraph}{\color{dlrgRot}}` |
| headings | doc/dlrg.tex:63,68 | `head.kernel` | `\section` `\subsection` |
| captions | latex/dlrg.typ.pub.pakete.tex:2; doc/dlrg.tex:165 | `cap.caption` | load-only; `\caption` is `cap.kernel` |
| title text | doc/dlrg.tex:32-33; latex/dlrg.typ.pub.code.tex:95-96 | `front.maketitle` | `\title` `\author` `\subtitle`, aliased to `\thetitle` `\thesubtitle` |
| title page | latex/dlrg.typ.pub.code.tex:67-92; doc/dlrg.tex:57 | `front.titlepage-env` | `titlepage` env hand-laid; banner, band and watermark are ART above |
| extra title-page slot | latex/dlrg.typ.pub.code.tex:99-103; doc/dlrg.tex:44-53 | `front.class-native` | `\titelExtra{...}` content argument |
| extra slot content | doc/dlrg.tex:45-52 | `sp.manual-space` | `\vfill`, `\begin{large}` (`font.size-commands`) |
| cover picture | latex/dlrg.typ.pub.code.tex:73-76 | `fig.graphicx` | `\includegraphics[width=\paperwidth,height=\paperheight]` at page centre (placement is ART); `\captionlistentry[figure]` (`cap.kernel`) |
| landscape pages | latex/dlrg.typ.pub.code.tex:110-129 | `page.typearea` | `\storeareas`, `\KOMAoptions{paper=a4,paper=landscape}`, `\activateareas`, `pg.break` `\cleardoubleoddpage`; `\addtolength{\textwidth}{.3\paperwidth}` `\addtolength{\textheight}{-.3\paperheight}` (`sp.lengths`) |
| red part box | latex/dlrg.typ.pub.code.tex:134-155 | `box.tcolorbox` | colframe=dlrgRot, colback=white, fonttitle=\bfseries, enhanced jigsaw, breakable, `\tcbsubtitle` |
| tcolorbox libraries | latex/dlrg.typ.pub.pakete.tex:6-10 | `box.tcolorbox` | breakable, skins |
| tables | latex/dlrg.mod.Tabellen.code.tex:29-67; latex/dlrg.mod.Tabellen.pakete.tex:1-6 | `tbl.nicematrix` | tabularray; `\SetTblrInner` vlines or hlines (grey/black, or `={dlrgRot}`), `row{1}={font=\bfseries,bg=gray!50}` or `bg=dlrgRot,fg=white`; `\SetTblrOuter{long}`; `\SetCell[c=#1]{font=\bfseries}`; `\UseTblrLibrary{babel}` |
| table lists | latex/dlrg.mod.Tabellen.code.tex:77-89 | `list.enumitem` | label=$\bullet$, topsep=0.2em, itemsep=-0.3em, leftmargin=1.3em; in `varwidth[t]` (`box.minipage`) |
| contents | doc/dlrg.tex:59 | `toc.kernel` | `\tableofcontents` |
| page breaks | doc/dlrg.tex:61 | `pg.break` | `\clearpage` |
| lists | doc/dlrg.tex:75-79 | `list.kernel` | `itemize` |
| appendix | doc/dlrg.tex:135 | `num.appendix` | `\appendix` |
| links in text | doc/dlrg.tex:66,69,68 | `xref.hyperref` | `\nameref{sec:..}`; `\url` is `meta.url`; `\label` is `xref.kernel` |
| index | doc/dlrg.tex:9-11,198 | `idx.makeidx` | imakeidx; `\indexsetup{othercode=\footnotesize,level=\section*,firstpagestyle=headings}`; `\makeindex[options=-s cnltx.ist,intoc]`; `\printindex` |
| bibliography | doc/dlrg.tex:18-26,35,64,196 | `bib.biblatex-biber` | language=ngerman, backend=biber, sortlocale=de_DE, style=authoryear, bibencoding=UTF8, block=space, autocite=inline; `\printbibliography[title=..]` |
| listings | doc/dlrg.tex:27,36-41 | `code.listings` | breaklines=true, language=[latex]tex, basicstyle=\ttfamily\small, breakatwhitespace=false |
| review aid | doc/dlrg.tex:28 | `draft.todo` | todonotes (no `\listoftodos`, line 200 is commented) |
| sub-documents | doc/dlrg.tex:29,98-133 | `pg.standalone-pkg` | `\usepackage{standalone}` and `\input{typBeamer.tex}` etc., preambles ignored |
| file inclusion | doc/dlrg.tex:98-133 | `struct.input` | `\input` of ten files |
| sub-figures | doc/dlrg.tex:30,141-194 | `fig.subcaption` | `subfigure[c]{0.5\linewidth}`, `\subcaption`; `figure[ht]`, `\includegraphics[width=35mm]` (`fig.graphicx`), `\scalebox{0.2}` |
| manual markup | doc/dlrg.tex:86-89,112-114; latex/dlrg.mod.Paketbeschreibung.pakete.tex:1 | `dtx.doc` | `\usepackage[example]{cnltx}` as the package parameter (considered: widen the `dtx.doc` text, no new way); the zip-local copy of class macros is BESPOKE above |
| letter class options | latex/dlrg.typ.letter.code.tex:3-11 | `ltr.opening` | `\LoadLetterOption{DIN5008B}`; fromlogo=true, fromalign=left, paper=a4, fontsize=11pt, foldmarks=blmTP |
| letter geometry | latex/dlrg.typ.letter.code.tex:62-76,86-88,118-119 | `ltr.opening` | `\setplength` backaddrheight 6mm, toaddrvpos 56mm, toaddrheight 35mm, toaddrwidth 80mm, subjectvpos 112mm, refvpos 112mm, foldmark and location lengths, firstfootvpos 273mm |
| letter fields | latex/dlrg.typ.letter.code.tex:15-58,80-114 | `ltr.opening` | ten `\newkomavar` plus `\setkomavar` of date, subject, backaddress, location, signature |
| letter dotted fold mark | latex/dlrg.typ.letter.code.tex:76 | `sp.rule` | `\cleaders\hbox to 2pt{.}\hfill` (dots only) |
| letter foot | latex/dlrg.typ.letter.code.tex:120-141,145-146 | `tbl.tabular` | three `tabular[t]{l@{}}` in `\tiny` black!80; `\cfoot{\thepage}` (`hf.scrlayer-scrpage`) |
| letter date and filler | latex/dlrg.typ.letter.code.tex:32; latex/dlrg.typ.letter.pakete.tex:1-3 | `front.datetime` | scrdate `\todaysname, \today`; blindtext is `draft.todo` |
| letter logo | latex/dlrg.typ.letter.code.tex:92-94 | `fig.graphicx` | `\includegraphics[width=35mm]{dlrg_adler.jpg}` or placeholder |
| beamer theme | latex/dlrg.typ.beamer.code.tex:1; latex/beamerthemeDLRG.sty:3-6 | `slide.beamer-theme` | `\usetheme{DLRG}`, `\useoutertheme{DLRG}`, `\usecolortheme{DLRG}`; `\beamertemplatenavigationsymbolsempty` |
| beamer colours and fonts | latex/beamercolorthemeDLRG.sty:3-17; latex/beamerouterthemeDLRG.sty:12-22,76 | `slide.beamer-template` | `\setbeamercolor` structure black, itemize items red, block title white on red; `\setbeamerfont{frametitle}` `\LARGE` bold; frametitle template; text margins 0.66cm (footline and title page are ART above) |
| press-release foot data | latex/dlrg.typ.message.code.tex:30-54 | `mark.kernel` | `flushright`, `\textbf`, `\footnotesize`, centred `\Huge` title; address lines printed only when set |
| Hausarbeit hint box | latex/dlrg.mod.Hausarbeit.code.tex:3-15 | `box.tcolorbox` | colback=white, colframe=dlrgRot, fonttitle=\bfseries, title text; shown only when `hinweise=true` |
| Hausarbeit acronyms | latex/dlrg.mod.Hausarbeit.code.tex:19-29; latex/dlrg.mod.Hausarbeit.pakete.tex:1-6 | `idx.glossaries` | glossaries nonumberlist, acronym, toc, section; `\newacronymstyle{short}` over long-short |
| Hausarbeit title data and foot | latex/dlrg.mod.Hausarbeit.code.tex:33-50,92-102 | `box.tcolorbox` | enhanced, colframe=dlrgRot, boxrule=.5mm around a `tblr` (`tbl.nicematrix`) colspec={lX[l]}, width=.95\textwidth; `\ihead` `\cfoot` fields |
| Hausarbeit quotes and sample | doc/Beispiele/dlrg_muster_hausarbeit.tex:15,36-45 | `lang.csquotes` | csquotes loaded; `\makeglossaries` `\newacronym` rows are content |
| record-driven letters | doc/Beispiele/dlrg_muster_mitteilung_serie.tex:8,21-33 | `struct.datatool` | `\DTLnewdb`, `\DTLforeach` over two rows |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| module and type loader | latex/dlrg.sty:85-147,164-232 | yes | emit only the selected files inline; no printed effect of its own |
| pgf option keys | latex/dlrg.sty:27-40; latex/dlrg.typ.pub.optionen.tex:14-23 | yes | values are strings and booleans, written directly into the emitted preamble |
| Stoerer shapes and styles | latex/dlrg.mod.Stoerer.code.tex:4-89 | no | `\pgfdeclareshape` with `\backgroundpath` is shape code; no lib way (BESPOKE/class, ART/class) |
| Bauchbinde | latex/dlrg.mod.Bauchbinde.code.tex:9-17 | no | page-overlay TikZ drawing of the template identity (ART/class) |
| Adler paths | latex/dlrg.mod.Adler.code.tex:1-24 | no | `\draw` path of a logo, with a file-exists switch for the real artwork (ART/class) |
| Personenicon commands | latex/dlrg.mod.Personenicon.code.tex:3-146 | no | hand-drawn pictograms with `\ifthenelse` on gender and equipment (ART/class) |
| Paketbeschreibung macros | latex/dlrg.mod.Paketbeschreibung.code.tex:8-209 | no | `\@ifnextchar` parsers and `\list` wrappers that decide what is printed (BESPOKE/class) |
| Rettungssport module | latex/dlrg.mod.Rettungssport.code.tex:12-79 | no | expl3 sequence loops printing cards; no sample loads it, so it is not counted as a blocker |
| `dlrgTblr` | latex/dlrg.mod.Tabellen.code.tex:29-67 | yes | one `tblr` with the inner and outer settings listed in the component map; the per-table `\NewTblrEnviron` and counter are an emit-time detail |
| `tabellenItemize`, `\tabellenZwischenueberschrift` | latex/dlrg.mod.Tabellen.code.tex:71,85-89 | yes | `list.enumitem` in `box.minipage`; `\SetCell[c=n]{font=\bfseries}` |
| `redPartBox` and `\partTitle` | latex/dlrg.typ.pub.code.tex:133-155 | yes | first part opens one `tcolorbox`, later parts are `\tcbsubtitle`; the boolean only tests position, known at emit time |
| `\querformatSeite` / `\hochformatSeite` | latex/dlrg.typ.pub.code.tex:105-129 | yes | `\storeareas` once, then `\KOMAoptions{paper=landscape}` and `\activateareas` per switch |
| title macro redefinitions | latex/dlrg.typ.pub.code.tex:95-103; latex/dlrg.mod.Hausarbeit.code.tex:65-88 | yes | data slots; the emitter writes the values where `\thetitle`, `\title@Autor` ... are used |
| `\footerLink` | latex/beamerouterthemeDLRG.sty:2-8 | yes | inline the link text with `\href` in the footline |
| `\HinweisZurVorlage` | latex/dlrg.mod.Hausarbeit.code.tex:3-15 | yes | emit the `tcolorbox` when `hinweise=true`, else nothing |
| letter field macros, foot, location block | latex/dlrg.typ.letter.code.tex:15-146 | yes | `\setkomavar` values and `tabular` rows written in place |
| `\startMitteilungsteil` | latex/dlrg.typ.message.code.tex:5-59 | yes | emit the address block at `\AtBeginDocument` for the set fields (its watermark call is ART above) |
| `\titelExtra` use in the sample | doc/dlrg.tex:43-53 | yes | `tblr` with `\@date` and `\@author` as text |

## Content-opaque
- TikZ pictures in figures: eagle outline with red frame (doc/dlrg.tex:144-149, 156-161)
- Inline person icons drawn by the package in the manual text (doc/modulPersonenicon.tex:34-46)
- Wordmark and eagle images that are not shipped (doc/dlrg.tex:176,190; latex/dlrg.mod.Bauchbinde.code.tex:3-5; latex/dlrg.typ.letter.code.tex:92-94) and the DLRG Univers font; the shipped placeholders are in data/
- Bibliography data doc/dlrg.bib (not read) and the sample texts

## Lib changes
- New ways proposed: none (considered: treating the whole `dlrg` package as a class-like way, not used because W2 and W3 fail for it and the blockers above are inside it; considered: `cnltx` as a parameter of `dtx.doc`)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
