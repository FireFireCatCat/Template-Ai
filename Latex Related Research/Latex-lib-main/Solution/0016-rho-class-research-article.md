no

# 0016-rho-class-research-article: Rho class research article (two-column journal-style paper)

- Unverified: read from the source, not compiled.
- Source: Source/0016-rho-class-research-article/ (origin: https://latextemplates.com/downloads/rho-class-article.zip; licence: CC-BY-4.0, ATTRIBUTION.txt:1-7; upstream https://github.com/MemoJimenez/Rho-class, author Guillermo Jimenez)
- Kind: journal
- Lib: v1
- Engine: pdfLaTeX-compatible (main.tex:30 says pdfLaTeX; stix2, FiraSans, FiraMono are pdfTeX packages; but see the `minted` blocker, which needs a tool outside TeX)
- Look carried by: zip-local (all layout is in rho-class/rho.cls, rhobabel.sty, rhoenvs.sty; main.tex adds only metadata and content)
- Class origin: zip-local
- Main file: main.tex (other samples: none; rho.bib is the bibliography data)
- Read: main yes, zip-local classes and styles all (rho.cls 570 lines, rhobabel.sty 140, rhoenvs.sty 90, rho.bib 9)

Note on origin: two reads of ctan.org (`/pkg/rho-class` and `/pkg/rho`) both returned HTTP 404, the zip is a latextemplates.com packaging of a GitHub community template (not a publisher's official kit), so `rho.cls` and its two `.sty` files are zip-local, not published (W1 fails). `\LoadClass{extarticle}` (rho.cls:42) is the published base.

## Verdict
No. Three blockers. (1) The class loads `minted` unconditionally (rho.cls:522), which by the pilot ruling is `EXTERNAL/package` even though the sample never calls `\begin{minted}`. (2) The title block is a hand-written `\renewcommand{\@maketitle}` with `\ifx...\undefined` branches (rho.cls:286-295), fed by a hand-rolled `\abstract` that swallows its body into `\theabstract` (rho.cls:250-260), plus an `\appto{\maketitle}` that queues a `figure[b!]` through `\afterpage` to fake a first-page note (rho.cls:314-352). That is kernel-internal redefinition plus conditional logic, so it is irreducible `BESPOKE/class`, and the class-native ways (`front.class-native`, `abs.class-native`) cannot stand in for it because the class is not published. (3) authblk internals are patched (rho.cls:363-364), which fails W2. Everything else (geometry, fonts, titlesec headings, fancyhdr, captions, listings style, mdframed boxes, biblatex, cleveref) maps to existing lib ways.

## Blockers
- `EXTERNAL/package` `\usepackage{minted}` loaded unconditionally by the class, with `\usemintedstyle{lovelace}` and `\setminted{...}` (rho.cls:522-532); needs shell escape and pygments, so the document does not compile without the tool (pilot ruling).
- `BESPOKE/class` `\renewcommand{\@maketitle}`: doctype line, title, authors, dates in hand-set `\vskip`s with `\ifx\@doctype\undefined` / `\ifx\@dates\undefined` branches, then `\rhoabstract` (rho.cls:286-295). Zip-local macro logic; no lib way expresses it as parameters.
- `BESPOKE/class` abstract capture: `\long\def\abstract#1\end#2{...\gdef\theabstract...}` (rho.cls:250-260), which is why main.tex can put `\begin{abstract}` and `\keywords` before `\begin{document}` (main.tex:42-48) and have them print inside `\maketitle`. Hand-rolled macro that changes when content is printed.
- `BESPOKE/class` first-page note: `\appto{\maketitle}{\afterpage{...\begin{figure}[b!] ...\footnoterule ...}}` with four-way `\ifx\@corres\empty` / `\ifx\@docinfo\empty` cases and `\g@addto@macro` accumulation in `\corres` (rho.cls:303-352); used at main.tex:28 and 30. A float abused as a footnote, driven by hand-rolled conditionals.
- `BESPOKE/class` `\renewcommand\AB@affilnote` / `\AB@authnote` edit authblk internals (rho.cls:363-364); no declarative parameter exists (cosmetic: sans superscript marker, but W2 fails).

## Class setting
- Class: `class.extarticle` (published base; `rho-class/rho` is zip-local and is not a way). Options: `9pt,a4paper,twocolumn,twoside` (main.tex:6), all forwarded by `\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}` (rho.cls:40-42).
- Class-native vocabulary used (all zip-local, defined in rho.cls): `\doctype` (rho.cls:283), `\dates` (282), `\corres` (308), `\docinfo` (303), `\journalname` `\journal` `\theday` `\vol` `\no` (191-195), `\keywords` (243), `abstract` env (250), `note` and `info` envs (rhoenvs.sty:82,87); authblk `\author[..]{}` `\affil[..]{}` (main.tex:20-24); `\maketitle`; `\cref`/`\Cref`; `lstlisting`; `\printbibliography`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:6; rho.cls:42 | `class.extarticle` | 9pt, a4paper, twocolumn, twoside via option forwarding |
| paper and size | main.tex:6 | `page.class-options` | a4paper, 9pt, twoside |
| two columns | main.tex:6 | `cols.twocolumn-option` | twocolumn |
| page geometry | rho.cls:119-126 | `page.geometry` | left=1.25cm, right=1.25cm, top=2cm, bottom=2cm, headsep=0.75cm |
| balance last page | rho.cls:58 | `cols.balance` | load-only |
| full-width floats in 2-col | rho.cls:102 | `cols.cuted` | `stfloats` loaded; not used by the sample |
| input and font encoding | rho.cls:49, 90 | `font.fontenc-t1` | inputenc utf8, fontenc T1 |
| serif text + math | rho.cls:91 | `font.mathptmx` | package=stix2, option notextcomp (nearest home: Times-like family package is the parameter, as `font.helvet` does for sans) |
| sans face | rho.cls:92 | `font.helvet` | package=FiraSans; `\sffamily` used for title, headings, captions, header/footer |
| mono face | rho.cls:93 | `font.mono` | package=FiraMono, scaled=0.80 |
| font size switches | rho.cls:113, 190, 244-247, 284, 291 | `font.size-commands` | `\fontsize{8}{9}`, `\fontsize{18}{22}`, `\small`, `\large`, `\fontsize{7}{8}` ... |
| icons (loaded, unused) | rho.cls:55 | `font.icons` | fontawesome5 |
| microtype | rho.cls:43 | `sp.microtype` | defaults, loaded `\AtEndOfClass` |
| ragged text | rho.cls:56, 288-291 | `sp.ragged` | `ragged2e` `\RaggedRight` in title block |
| manual spacing | rho.cls:288-294 | `sp.manual-space` | `\vskip-22pt`, `\vskip8pt`, `\vskip10pt`, `\vskip18pt` |
| display-math skips | rho.cls:132-139 | `sp.lengths` | abovedisplayskip, belowdisplayskip, abovedisplayshortskip, belowdisplayshortskip = `\eqskip` (9pt) minus `\baselineskip`; hooked into `\normalsize` (see Bespoke) |
| colour | rho.cls:145-146, 475-479 | `color.xcolor` | `rhocolor` rgb 0.12,0.3,0.17; `rhocodeback` `rhocodecomment` `rhocodekey` `rhocodestring` `rhogray` |
| hyperlinks | rho.cls:162 | `meta.hyperref` | colorlinks=true, allcolors=rhocolor |
| bookmarks | rho.cls:164 | `meta.bookmark` | defaults |
| url | rho.cls:154-156 | `meta.url` | url + xurl, `\UrlFont` set to `\selectfont` |
| language | main.tex:7 | `lang.babel` | english (rhobabel.sty labels switch on `\iflanguage{spanish}`) |
| quotes for biblatex | rho.cls:559 | `lang.csquotes` | defaults |
| cross-references | main.tex:79, 94; rho.cls:163 | `xref.cleveref` | `\cref`, `\Cref` |
| cross-ref helpers | rho.cls:167-171 | `xref.hyperref` | `\hyperref[..]{label~\ref*{..}}` aliases (unused by the sample) |
| labels and refs | main.tex:76, 101 | `xref.kernel` | `\label`, `\ref` |
| title block | rho.cls:286-295 | BESPOKE (no way) | irreducible `\@maketitle`; ingredients: `sp.manual-space`, `sp.ragged`, `font.size-commands`, `color.xcolor` |
| authors and affiliations | main.tex:20-24; rho.cls:358-368 | `front.authblk` | `\setlength{\affilsep}{10pt}`; `\Authfont` sf 9/11; `\Affilfont` sf italic 7.5/9; `\Authand` set to `\andlanguage` |
| title package (loaded) | rho.cls:278 | `front.titling` | loaded, no `\pretitle`/`\posttitle` use found |
| corresponding author and doc info | main.tex:28, 30; rho.cls:303-352 | BESPOKE (no way) | irreducible `\afterpage` + `figure[b!]` + `\footnoterule` |
| abstract box | rho.cls:263-272 | `box.tcolorbox` | colback=rhocolor!13, arc=3pt, boxrule=0pt, left=6pt, right=6pt, top=6pt, bottom=6pt, before skip=0pt, after skip=0pt; head `\absheadfont` (sf 9/11, rhocolor, bold), body `\absfont` (sf 8.5/11) |
| abstract capture | rho.cls:250-260 | BESPOKE (no way) | irreducible hand-rolled `\abstract`; kernel `abs.kernel` is replaced, not used |
| keyword line | main.tex:48; rho.cls:243, 246-247, 269; rhobabel.sty:50 | `abs.keywords` | label "Keywords:" bold sf 7.8/9, items italic sf 7.8/9; the command itself is a zip-local `\def` |
| headings | rho.cls:376-413 | `head.titlesec` | `explicit`; section: rhocolor sf `\large` bold, label `\thesection.`, sep 0.5em, `\MakeUppercase{#1}`; subsection block sf bold; subsubsection block sf bold italic `\small`; paragraph runin `\small\bfseries`; `\titlespacing*{\section}{0pc}{3ex plus4pt minus3pt}{5pt}` |
| numberless section marker | rho.cls:383-388 | `sp.rule` | filled 1.25ex square in rhocolor via TikZ; reduces to a coloured `\rule{1.25ex}{1.25ex}` (not used by the sample; see Bespoke) |
| heading depth | rho.cls:374 | `num.secnumdepth` | secnumdepth=5 |
| table of contents | rho.cls:419-445 | `toc.titletoc` | `\contentsmargin{0cm}`, `\titlecontents` for section, subsection, subsubsection (run-in with `\textbullet`), `\titlerule*[.5pc]{.}`; not used by the sample |
| lists | rho.cls:177-178 | `list.enumitem` | `\setlist{noitemsep}` |
| footnotes | rho.cls:184 | `fn.footmisc` | bottom, hang, flushmargin, ragged |
| header/footer | rho.cls:185-187, 216-228 | `hf.fancyhdr` | `\pagestyle{fancy}`; heads RO,LE = title, RE,LO = journal; foot C = page-LastPage; headrulewidth=0pt, footrulewidth=0pt; font `\footerfont` sf 8/9 |
| page X of Y | rho.cls:186, 211, 228 | `pgnum.lastpage` | `\thepage\textendash\pageref{LastPage}` |
| first-page style (dead) | rho.cls:198-213 | `hf.fancyhdr` | `\fancypagestyle{firststyle}` is defined but no `\thispagestyle{firststyle}` exists anywhere in the zip (grep), so `\journalname` `\theday` `\vol` `\no` (main.tex:32, 34-36) print nothing in this sample |
| drop capital (unused) | rho.cls:234-236 | `sp.lettrine` | lines=2, lraise=0, findent=2pt, nindent=0em, 27/24 bold rhocolor |
| notes and info boxes | main.tex:65-68, 83-90; rhoenvs.sty:49-87 | `box.mdframed` | `framemethod=tikz` (rho.cls:51); style: backgroundcolor=rhocolor!13, no side lines, frametitlerule=true, frametitlerulewidth=0.2pt, frametitlefont rhocolor bold sf, inner margins 6pt, font sf `\small`, fontcolor=rhocolor, frametitleaboveskip=4pt, frametitlebelowskip=4pt, skipabove=9pt, roundcorner=3pt; titles "Note"/"Information" |
| equation | main.tex:74-77 | `math.kernel` | `equation` + `\label`; no amsmath loaded by the class directly (not established whether tcolorbox `[most,many]` pulls it in) |
| theorem-like statements | none in sample or class | none | the class defines none |
| figure float | main.tex:97-102; rho.cls:99-101 | `fig.graphicx` | `figure[htbp]`, `\centering` |
| float placement | rho.cls:100-101 | `fig.float` | `here`, `float` loaded |
| subfigures (unused) | rho.cls:57, 452 | `fig.subcaption` | loaded |
| image box tools | rho.cls:108 | `fig.adjustbox` | loaded, unused |
| figure placeholder frame | main.tex:99 | `box.fancybox` | `\fbox` around `\rule`s (placeholder content) |
| tables | rho.cls:53, 108-113 | `tbl.tabular` | `array`; `\AtBeginEnvironment{tabular}{\small\sffamily}`; `\tabletext` 7/9 sf italic (unused) |
| table rules and colour | rho.cls:110-111 | `tbl.booktabs`, `tbl.colortbl` | loaded, unused by the sample |
| captions | rho.cls:451-461; main.tex:100 | `cap.caption` | figure: format=plain, labelsep=period, textfont small, justification=centering, labelfont small bf sf; table: labelfont small bf sf, textfont small, position=below, aboveskip=0pt, labelsep=period; lstlisting: font small, labelfont bf sf, aboveskip=0pt, belowskip=9pt, position=below, labelsep=period |
| caption command | main.tex:100 | `cap.kernel` | `\caption` |
| listings | main.tex:86-89; rho.cls:469-516 | `code.listings` | style `rhocoding`: backgroundcolor rhocodeback, comment/keyword/string colours, basicstyle `\small\ttfamily`, breaklines, frame=single, columns=fullflexible, tabsize=2, aboveskip=12pt, belowskip=7pt, xleftmargin=3.8pt, xrightmargin=3pt, postbreak hook arrow; `\lstlistingname` set to "Code" |
| listing caption type | rho.cls:470 | `cap.caption` | `\newenvironment{code}{\captionsetup{type=lstlisting}}{}` (unused) |
| minted | rho.cls:522-532 | `code.minted` | **EXTERNAL**: lovelace style, `\setminted{frame=single, breaklines, numbersep=5pt, fontsize=\small, bgcolor=codeback}` |
| inline code box | rho.cls:538-553 | `box.tcolorbox` | `\tcbox`: boxrule=0.4pt, arc=1pt, colback=gray!15, colframe=gray!30, coltext=rhocolor, left/right/top/bottom=1pt, boxsep=0pt, fontupper=`\ttfamily\small`, valign=center, nobeforeafter, box align=base (unused) |
| bibliography | main.tex:5, 57, 117; rho.cls:560-567; rho.bib | `bib.biblatex-biber` | class asks `backend=biber, style=ieee, sorting=ynt, citestyle=numeric-comp`, `\addbibresource{rho.bib}` |
| bibliography (starter override) | main.tex:1-5 | `bib.biblatex-bibtex` | `\PassOptionsToPackage{backend=bibtex}{biblatex}`; which backend wins (class option comes later in the list) was not established |
| appendix, index, glossary | none | none | not defined or used |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `rho.cls` (option forwarding, `\LoadClass{extarticle}`) | rho.cls:38-43 | Yes | `class.extarticle` with options as parameters |
| `rhobabel.sty` label macros (`\figlabel`, `\tablabel`, `\captionlabelcode`, `\eqlabel`, `\andlanguage`, `\infolanguage`, `\notelanguage`, `\keywordname`) | rhobabel.sty:50-137 | Yes | plain label strings per language under `lang.babel`; `\iflanguage` is a babel command |
| `rhoenvs.sty` mdframed style and `rhoenv`/`info`/`note` | rhoenvs.sty:49-87 | Yes | `box.mdframed` with the listed parameters per environment |
| `\normalsize` display-skip patch, `\eqskip` | rho.cls:132-139 | Yes (caveat) | `sp.lengths` display skips set once; the `\eqskip-\baselineskip` arithmetic needs calc-style `\setlength`, which this file does not load itself (not read) |
| `\tabletext`, `\AtBeginEnvironment{tabular}` | rho.cls:112-113 | Yes | `font.size-commands` inside each table wrapper |
| `\figref` `\tabref` `\coderef` `\equref` | rho.cls:167-171 | Yes | `xref.hyperref` aliases |
| `\journalname` `\journal` `\theday` `\vol` `\no` and `firststyle` | rho.cls:191-213 | Yes | storage macros and a `hf.fancyhdr` page style; the style is never applied here |
| `\rhostart`, `\dropcapfont` | rho.cls:235-236 | Yes | `sp.lettrine` parameters |
| `\keywords`, `\dates`, `\doctype`, font macros (`\absfont` etc., `\titlefont`) | rho.cls:243-247, 282-284 | Yes | `\def` stores and font aliases, text and `font.size-commands` |
| `\rhoabstract` | rho.cls:263-272 | Yes | `box.tcolorbox` parameters (both `\ifx` branches print the same heading and abstract; the keyword line is the only difference) |
| `\abstract` capture (`\theabstract`) | rho.cls:250-260 | No | hand-rolled body-swallowing macro that moves printing into `\maketitle`; `BESPOKE/class` |
| `\@maketitle` | rho.cls:286-295 | No | kernel-internal redefinition with `\ifx\undefined` branches; `BESPOKE/class` |
| `\appto{\maketitle}{\afterpage{figure[b!]...}}`, `\corres`, `\docinfo` | rho.cls:303-352 | No | float used as first-page note with four-case conditional; `BESPOKE/class` |
| authblk `\AB@affilnote` `\AB@authnote` renewal | rho.cls:363-364 | No | internal macros of a published package; W2 fails; cosmetic only; `BESPOKE/class` |
| numberless-section TikZ square | rho.cls:383-388 | Yes | `sp.rule` with `color.xcolor`; flagged as a possible `ART/class` if the drawing were more than a filled square; not used by the sample |
| `\titlecontents` set and `\tocsep` | rho.cls:419-445 | Yes | `toc.titletoc` parameters |
| `\inlinecode` (xparse `v` argument) | rho.cls:538-553 | Yes | `box.tcolorbox` `\tcbox` options; the verbatim argument is content |
| `code` environment, `\lstlistingname` renewal | rho.cls:462-463, 470 | Yes | `cap.caption` type and a label string |
| `minted` block | rho.cls:522-532 | No | needs pygments and shell escape; `EXTERNAL/package` |

## Content-opaque
- Placeholder figure frame `\fbox{\rule{0pt}{3cm}\rule{0.7\linewidth}{0pt}}` (main.tex:99).
- Python listing text (main.tex:86-89), the equation `E = mc^2` (main.tex:74-77), the bibliography entry (rho.bib:1-9).
- Nothing in the zip is artwork the lib cannot hold except the small TikZ square noted above.

## Lib changes
- New ways proposed: none. Judgement calls on existing ways: `stix2` placed under `font.mathptmx` and `FiraSans` under `font.helvet` (package as the parameter); `FiraMono` under `font.mono`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Class vocabulary for the consolidator: `class.extarticle` is the published base (extsizes bundle); the sample's class `rho-class/rho` is zip-local (two ctan.org reads, 404), so its native vocabulary is recorded above as zip-local and does not justify `front.class-native` or `abs.class-native`.
