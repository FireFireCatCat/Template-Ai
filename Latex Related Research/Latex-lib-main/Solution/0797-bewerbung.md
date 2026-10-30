yes

# 0797-bewerbung: bewerbung (German job-application folder: cover page, cover letter, CV; plus an application-table class)

- Unverified: read from the source, not compiled.
- Source: Source/0797-bewerbung/ (origin: https://mirrors.ctan.org/macros/latex/contrib/bewerbung.zip; licence: LPPL 1.3, README:17-19)
- Kind: cv
- Lib: v6
- Engine: pdfLaTeX-compatible (the sample loads inputenc and T1 fontenc, bewerbung-example.tex:34-35; the class loads `fontspec` only when run under XeLaTeX or LuaLaTeX, bewerbung.dtx:1693-1695)
- Look carried by: class (the sample adds only class options, three colour definitions, encoding and language packages, and content; the look is in the CTAN class `bewerbung` and its `bewerbung-cv*.sty` and `bewerbung.sty` parts, all generated from bewerbung.dtx)
- Class origin: ctan (ctan.org/pkg/bewerbung read: "Typesetting job applications", André Hilbig, LPPL 1.3, v1.3 of 2022-01-17, in TeX Live and MiKTeX)
- Main file: bewerbung-example.tex (other samples: argetabelle-example.tex; the `ltxdoc` documentation driver in bewerbung.dtx:43-229 is the manual, not the template, and is not analysed as a sample)
- Read: main yes, zip-local classes and styles all (the generated .cls/.sty/.inc files are not in the zip, only bewerbung.dtx and bewerbung.ins; their whole code, bewerbung.dtx:1037-3893, was read, plus the documentation text 259-1036)

## Verdict
The look is carried by the published CTAN class `bewerbung` (this zip is the CTAN release itself, LPPL 1.3); the sample only sets class options (`lebenslaufColor=light-gray`, `idPlain`), three `\definecolor` lines, inputenc/fontenc/babel, and content in the class's own `anschreiben` and `lebenslauf` environments. By the pilot ruling for a class-carried look this is `class.bewerbung` with its native vocabulary, so it is `yes`; this is evidence about the class dimension, not about the component ways. No TikZ, PGF, picture or shell-escape code exists in the zip (grep over bewerbung.dtx), `datatool` reads `anschrift.csv` inside TeX, DocStrip generation is a TeX run, and `neueBewerbung.sh` (bewerbung.dtx:3750-3759) only copies files, so there is no `ART` and no `EXTERNAL` blocker. The class internals are hand-written box-and-glue and data-row code; they would be `BESPOKE/class` if the class were zip-local (see "Bespoke code"), which is why the `yes` rests on W1 for a CTAN class and not on a reduction.

## Blockers
none

## Class setting
- Class: `class.bewerbung` options: `lebenslaufColor=light-gray` (bewerbung-example.tex:22), `idPlain` (bewerbung-example.tex:32); `lebenslaufStyle=classic` is the default and is commented out in the sample (bewerbung-example.tex:27, bewerbung.dtx:3674); other options declared: `lebenslaufXcolor` (default `x11names`, bewerbung.dtx:3673), `anschrift` (CSV file name, default `anschrift.csv`, bewerbung.dtx:3675); every other option goes to `scrlttr2` (bewerbung.dtx:3678). The class loads `scrlttr2` as its base with `DIN, pagenumber=botright, backaddress=true, parskip=half, fromalign=right, fromemail/fromfax/fromphone=true, fromurl=false, fromlogo=false, fromrule=true, foldmarks=true, paper=a4, fontsize=10pt, enlargefirstpage=true, firstfoot=false` (bewerbung.dtx:3680-3686).
- Class-native vocabulary used by the sample: environments `anschreiben[Anrede][Enlarge]` (bewerbung-example.tex:58-60; defined bewerbung.dtx:3470-3497) and `lebenslauf[Listensymbol][Addendum]` called as `[none][]` (bewerbung-example.tex:62-75; defined bewerbung.dtx:3504-3527); commands `\maketitle` (bewerbung-example.tex:63, redefined bewerbung.dtx:2329-2330), `\makePerson` (:64, bewerbung.dtx:3533-3544), `\section` (:66,69,72, redefined as a coloured bar section bewerbung.dtx:1346, 2566-2590), `\cventry` (:67, bewerbung.dtx:2453-2468), `\cvlistitem` (:70, bewerbung.dtx:2418-2425), `\cvlanguage` (:73-74, bewerbung.dtx:2476-2478 over `\cvitemwithcomment` 2489-2504).
- Vocabulary the class defines for the data files, not written in the sample: `\Name` `\Vorname` `\Street` `\Plz` `\Stadt` `\MeinBeruf` `\EMail` `\Tel` `\Mobile` `\Sta` `\GebDatum` `\ID` `\Anhang` `\LebenslaufTitel` `\TodayOrt` `\TodayTime` (bewerbung.dtx:2869-3373; the manual names the setters `\todayOrt` and `\todayDatum`, bewerbung.dtx:472-477, but the code defines `\todayOrt`/`\todayTime` as getters and `\TodayOrt`/`\TodayTime` as setters, 3085-3110); `\photo` `\cvquote` `\firstname` `\familyname` `\acadtitle` `\cvitem` `\cvdoubleitem` `\cvlistdoubleitem` `\subsection` (bewerbung.dtx:2191-2309, 2385-2446, 1353, 1752). Data files: `config.inc` (bewerbung.dtx:3779-3813, loaded 3726), `titlepage.inc` (bewerbung.dtx:3826-3887, loaded 3732), `anschrift.csv` (anschrift.csv:1-3, loaded by `\getBewerbung` bewerbung.dtx:3385-3418).

## Component map
Rows 1 to 12 are what an emitter writes for the sample; rows 13 to 31a are inside `class.bewerbung` (read from bewerbung.dtx) and are listed so the class can be re-read under a stricter definition; rows 32 to 36 are the second sample.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| 1 class | bewerbung-example.tex:20-33 | `class.bewerbung` | `lebenslaufColor=light-gray`, `idPlain`; default `lebenslaufStyle=classic` |
| 2 encoding | bewerbung-example.tex:34-35 | `font.fontenc-t1` | `inputenc[utf8]`, `fontenc[T1]` |
| 3 language | bewerbung-example.tex:36 | `lang.babel` | `ngerman` |
| 4 colours | bewerbung-example.tex:38-40; read by class bewerbung.dtx:1651-1659 | `color.xcolor` | `\definecolor` `light-gray` gray 0.6, `titlecolor` gray 0.62, `addresscolor` gray 0.45 (the class turns these names into `@titlecolor`, `@addresscolor`) |
| 5 cover letter body | bewerbung-example.tex:58-60; bewerbung.dtx:3470-3497 | `ltr.opening` | KOMA `letter` environment: recipient block from the CSV row, `\opening{Sehr geehrte(r) ...}` chosen from `Frau`/`Herr`, `\closing{Mit freundlichen Grüßen}`, `\encl{\anhang}`; optional arguments `[Anrede][Enlarge]` |
| 6 letter data source | anschrift.csv:1-3; bewerbung.dtx:3385-3418 | `struct.datatool` | `\DTLloaddb{anschrift}{anschrift.csv}`, row by `\dtlgetrow` (line number) or, with `idPlain`, `\edtlgetrowforvalue{anschrift}{1}{\id}`; columns ID,KW,Datum,Firma,FirmaAnrede,FirmaName,Str,PLZ,Ort,Stelle,Rueckmeldung,Sonstiges |
| 7 CV page setup | bewerbung-example.tex:62; bewerbung.dtx:3505-3507 | `page.geometry` | `\newgeometry{top=2.5cm,left=3cm,right=2.5cm,bottom=3cm}`, `\restoregeometry` (3526); with `pg.break` `\clearpage` (3505) and `hf.pagestyle-kernel` `\pagestyle{empty}` (3507) |
| 8 CV title block | bewerbung-example.tex:63; bewerbung.dtx:2329-2330, 1246-1339 | `front.class-native` | `\maketitle` calls `\@cvtitleclassic`: first name, family name, `\LebenslaufTitel`, address block; fonts `firstnamefont` `titlefont` `addressfont` |
| 9 CV personal data section | bewerbung-example.tex:64; bewerbung.dtx:3533-3544 | `cv.entries` | `\makePerson`: section "Persönliche Angaben" with `\cvitem` rows Name, Anschrift, StA, Geburtsdatum, Beruf |
| 10 CV headings | bewerbung-example.tex:66,69,72; bewerbung.dtx:1346, 2566-2590 | `head.class-native` | `\section{..}` becomes `\@cvbarsection`: colour bar `\rule{\@hintscolwidth}{1ex}` in `secbarcolor`, then `\sectionstyle` text, `\vspace{0.75em}` before |
| 11 CV entries | bewerbung-example.tex:67,70,73-74; bewerbung.dtx:2453-2468, 2418-2425, 2476-2504 | `cv.entries` | `\cventry{date}{bold title}{italic}{place}{grade}{text}`, `\cvlistitem{item}`, `\cvlanguage{lang}{level}{comment}`; `lebenslauf[none]` removes the list symbol (3508) |
| 12 CV sign-off | bewerbung.dtx:3515-3525 | `tbl.tabular` | one `p{\textwidth}` cell with `\fullname` and `\todayOrt, \todayTime`, after `\vfill`; optional addendum after `\newpage` |
| 13 cover page (automatic) | bewerbung.dtx:3826-3887, loaded 3732 | `front.class-native` | `titlepage.inc`: two-column cover with own data, the word "Bewerbung", recipient, position, photo |
| 14 cover page setup | bewerbung.dtx:3460-3466 | `page.geometry` | `titlepage` environment: `\newgeometry{top=4cm,left=3cm,right=2.5cm,bottom=2cm}`; `hf.pagestyle-kernel` `\thispagestyle{empty}`; `pg.break` `\clearpage` |
| 15 cover columns | bewerbung.dtx:3843-3844, 3860 | `cols.multicol` | `multicols*{2}[][0cm]`, `\columnseprule` 1pt via `sp.lengths`, `\columnbreak` |
| 16 cover spacing and shape | bewerbung.dtx:3847-3880 | `sp.manual-space` | `\vspace*{1.8cm}` `\vspace*{2cm}` `\vspace*{1.5cm}` `\hspace*` `\vfill`; `sp.ragged` `flushleft`; `sp.lengths` `\parindent`, `\leftskip` (3865-3866) |
| 17 cover text marks | bewerbung.dtx:3862, 3846, 3867 | `mark.kernel` | `\textsc{\Huge{\textbf{Bewerbung}}}` (size from `font.size-commands`), `\textbf`, `\textit` |
| 18 cover photo | bewerbung.dtx:3882 | `fig.graphicx` | `\includegraphics[width=5cm]{Foto.pdf}` (Foto.pdf ships in the zip) |
| 19 cover contact icons | bewerbung.dtx:3850-3852, 3697, 3717 | `font.icons` | marvosym `\Letter` `\Telefon` `\Mobilefone`; `eurosym[right]` loaded |
| 20 cover contents list | bewerbung.dtx:3855-3859, 3050-3058 | `list.kernel` | `itemize` with `\labelitemi` emptied, items from `\anhang[title]` |
| 21 CV rows | bewerbung.dtx:2385-2392, 2399-2411 | `box.minipage` | `\cvitem` is a two-column `tabular` with computed widths; `\cvdoubleitem` uses `minipage[t]` boxes |
| 22 CV lists | bewerbung.dtx:2280-2298 | `list.enumitem` | `\newlist{compactitem}{itemize}{3}` (also enumerate, description), `\setlist` zero spacing, `leftmargin=*`, coloured labels |
| 23 CV fonts | bewerbung.dtx:1710-1740, 1227-1230 | `head.koma-fonts` | `\newkomafont{firstnamefont,titlefont,acadtitlefont,addressfont,quotefont,hintfont,section,subsection,...}`; classic adds `\sffamily` (`mark.kernel`) |
| 24 CV colour theme | bewerbung.dtx:1632-1692 | `color.xcolor` | `xcolor[x11names]`, `\colorlet{colortheme}{\ahbewerbung@lebenslaufColor}`, per-element `\colorlet` defaults (firstname, address, title, secbar, sec, subsec, hint, frame) |
| 25 CV hint rule | bewerbung.dtx:2580 | `sp.rule` | `\rule{\@hintscolwidth}{1ex}` |
| 26 links and PDF metadata | bewerbung.dtx:2606-2629, 2818-2830, 3725 | `meta.hyperref` | `hyperref`, `\hypersetup{colorlinks=true,pdfborder={0 0 .3},pdfstartview=FitH,pdfauthor,pdftitle,pdfkeywords,urlcolor}`; `meta.url` `\urlstyle{same}` |
| 27 letter fields and page | bewerbung.dtx:3426-3434, 3477 | `ltr.opening` | `\setkomavar{fromname,fromaddress,fromphone,fromfax,fromemail,signature,subject}`, `\raggedsignature` emptied; `pg.enlarge` `\enlargethispage{#2}` |
| 28 running head or foot | bewerbung.dtx:3698, 1115-1144 | `hf.scrlayer-scrpage` | package loaded; `\defpagestyle{footer}` only in style `casual` (address footer, `\pagemark/\totalpagemark`) |
| 29 page count | bewerbung.dtx:2334, 2341-2343 | `pgnum.lastpage` | `lastpage` loaded, `\totalpagemark` uses `\pageref{LastPage}` |
| 30 text shaping | bewerbung.dtx:3701, 2832-2834, 3714 | `sp.microtype` | `microtype` loaded; `pg.flush` `\raggedbottom`; `lang.csquotes` `csquotes[autostyle,german=guillemets]` |
| 31 attachments | bewerbung-example.tex:79-80 (commented out); bewerbung.dtx:3720 | `pg.include-pdf` | `pdfpages` loaded; `\includepdf[pages=-]` only in comments |
| 31a base class (inside the class) | bewerbung.dtx:3680-3686 | `class.scrlttr2` | the options listed under Class setting; every `anschreiben` page, the letter fields and the page number come from it |
| 32 other sample: class | argetabelle-example.tex:20; bewerbung.dtx:3612-3614 | `class.argetabelle` | options `11pt,a4paper` passed to `scrartcl`; base `class.scrartcl` (3614) |
| 33 other sample: geometry | bewerbung.dtx:3616-3621 | `page.geometry` | `left=1cm,top=2.5cm,bottom=1.5cm,right=1cm` |
| 34 other sample: table | argetabelle-example.tex:27; bewerbung.dtx:3552-3593 | `tbl.longtable` | `\argetabelle` prints a 5-column `longtable{rrL{6cm}L{3cm}L{4cm}}` with `endfirsthead`/`endhead`/`endfoot`/`endlastfoot`; `tbl.booktabs` `\toprule` `\midrule` `\bottomrule` |
| 35 other sample: columns | bewerbung.dtx:3633-3635, 3632 | `tbl.tabular` | `\newcolumntype{L,C,R}` over `p{#1}` with `\raggedright`/`\centering`/`\raggedleft` (`sp.ragged`, `ragged2e`) |
| 36 other sample: data rows | bewerbung.dtx:3557, 3582-3588 | `struct.datatool` | `\DTLforeach{anschrift}{\kw=KW,\datum=Datum,...}` over every CSV row |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| macros, environments, counters in the sample | bewerbung-example.tex:1-81 | none defined | the sample has no `\newcommand`, `\def`, `\let`, environment or counter (grep); only rows 2 to 4 |
| class and style code (7 files from the .dtx) | bewerbung.dtx:1037-3893 | not zip-local: published CTAN class | `class.bewerbung` plus the options of row 1; the emitter copies none of its macro logic |
| `config.inc` | bewerbung.dtx:3779-3813 | yes | preamble lines of class-defined string commands (`\Name{..}`, `\ID{..}`, `\Anhang{..}{..}`); the emitter writes this file |
| `titlepage.inc` | bewerbung.dtx:3826-3887 | yes (declarative layout of rows 14 to 20; part of the same CTAN package) | `multicols*`, `\vspace*`, `\includegraphics`; the dead `comment` block (3827-3842) prints nothing |
| `neueBewerbung.sh` | bewerbung.dtx:3750-3759 | not part of the output | a scaffold that copies and links files; the output is built from the files it copies |
| if the class were read as zip-local: title-block algorithms | bewerbung.dtx:1246-1339, 1149-1187, 1484-1533 | no (would be `BESPOKE/class`) | box-and-glue: `\settowidth` of the name capped at `.525\textwidth`, `\totalheightof` with negative `\vspace` to align the info box in `oldstyle` |
| if zip-local: length setup and CV rows | bewerbung.dtx:1832-1982, 2385-2504 | no (would be `BESPOKE/class`) | lengths set at `\AtEndPreamble` by zero-tests (`\ifdimequal{..}{0pt}`), feeding `tabular` and `minipage` widths |
| if zip-local: CSV row selection | bewerbung.dtx:3385-3418 | no (would be `BESPOKE/class`) | `\ifahbewerbung@idPlain` chooses between two datatool row fetches, then 11 `\dtlgetentryfromcurrentrow` assignments |
| if zip-local: addressee wording | bewerbung.dtx:3478-3487 | borderline | `\ifthenelse` on `Frau`/`Herr` picks `geehrte`/`geehrter`; the emitter could write the word directly |

## Content-opaque
none (the only picture is the photo `Foto.pdf` through `\includegraphics`, bewerbung.dtx:3882, a `fig.graphicx` call; there is no TikZ, PGF, picture or PSTricks anywhere in bewerbung.dtx)

## Lib changes
- New ways proposed: none. Considered and not proposed (no printed effect, as v4's rejected `sys.compat-load` and `sp.xspace`): `comment` (loaded bewerbung.dtx:3721, its only use is to drop a dead block in `titlepage.inc`, 3827-3842), `xspace` (macro-body helper, 3718), `kvoptions`/`etoolbox`/`ifthen`/`xparse` (class option and programming helpers, 3659, 3692-3704, 3722). `font.fontspec` is loaded by the class only under XeLaTeX/LuaLaTeX (1693-1695) and is not used in the pdfLaTeX path.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
