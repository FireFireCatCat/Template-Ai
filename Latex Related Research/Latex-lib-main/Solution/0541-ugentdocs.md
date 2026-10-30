yes

# 0541-ugentdocs: ugentdocs (Ghent University house-style classes and beamer theme)

- Unverified: read from the source, not compiled.
- Source: Source/0541-ugentdocs/ (origin: https://mirrors.ctan.org/macros/unicodetex/latex/ugentdocs.zip; licence: LPPL 1.3c)
- Kind: thesis (the bundle holds eight classes: BSc/MSc and PhD dissertations, course text, report, exam, letter, article, book cover; plus a beamer theme)
- Lib: v4
- Engine: needs XeLaTeX or LuaLaTeX (`\iftutex` else `\PackageError`, ugentdocs.dtx:757-758, 911-913; unconditional `fontspec` and `unicode-math`, :862, :887-889)
- Look carried by: class (the zip is the DocStrip source of the CTAN package `ugentdocs`; the look is the generated `ugent*.cls`, `ugentcommon.clo`, `ugentcolor.sty` and `beamer*themeugent.sty`, all in the one `.dtx`; the documentation examples add only options and content)
- Class origin: ctan (ctan.org/pkg/ugentdocs read: v1.0.0, LPPL 1.3c, by Seppe Ongena; the zip is its own CTAN release, README.md:1-3 and the mirror URL in the manifest)
- Main file: ugentdocs.dtx (no `.tex` sample ships: the DocStrip-guarded examples `crs1|bama1|bama2|phd1|phd2|rp1|rp2|le1|ex1|ex2|art1` at dtx:8256-9926 stand in, with `bama1` (dtx:8257) as the main one; the beamer user guide is dtx:10014-10823) (other files: ugentdocs.ins, README.md, CHANGELOG.md, ugentdocs.pdf, Images/ugent-oehoe.jpg)
- Read: main partly (examples dtx:8236-9926 and beamer guide start read; lorem text skipped), zip-local classes and styles partly. Not read in full: people and affiliation macros (dtx:3964-4650: outline only), phd page flow and copyright variants (5739-5830, 8040-8180), bookcover class body (6077-6140), faculty icon path data (1079-1340: four of eleven read), dictionaries (1975-2236), beamer inner and outer themes (11224-11764: outline by grep), CHANGELOG.md after line 60, ugentdocs.pdf (binary, not opened)

## Verdict
yes, on the class dimension only. The zip is not a document built on a class: it is the published CTAN package `ugentdocs`, whose classes are each one way, `class.ugentbama`, `class.ugentphd`, `class.ugentcourse`, `class.ugentreport`, `class.ugentexam`, `class.ugentletter`, `class.ugentarticle`, `class.ugentbookcover`, and whose beamer theme is `slide.beamer-theme` (`\usetheme[bw]{ugent}`). An emitter writes `\documentclass[faculty,11pt,twoside,openright,...]{ugentbama}` plus the class's own front-matter commands, and no zip-local macro logic is copied. The class internals are very heavy (expl3 option and dictionary engines, hand-drawn TikZ logos, covers and chapter headings, an exam answer-space algorithm); under the rubric they sit inside published ways, so Blockers is none, but they are listed under "Bespoke code" and would be `ART/class` and `BESPOKE/class` if the classes were rebuilt from components. Caveat for a stricter re-reading: that list makes the answer `no`.

## Blockers
none (published class, see Verdict). Recorded, not counted:
- `EXTERNAL/class` (conditional) `\runwordcount` calls `texcount` through `\ShellEscape` and needs `--shell-escape` (dtx:3648-3660, :3629-3642); only when the author writes `\wordcount{\runwordcount}` (commented out in the examples, dtx:8673, 8682). No package the classes load unconditionally needs a tool outside TeX (dtx:2959-2985, 3017-3018).
- Missing asset that cannot be shipped: the fonts `UGent Panno Text` (Normal, Medium, SemiLight) come from the UGent intranet (dtx:307-312). Medium and SemiLight are required for the logos and raise `\PackageError` when absent (dtx:898-909); Arial is only the fallback for body text (dtx:871-881).

## Class setting
- Class: `class.ugentbama` (and the siblings above), options: `faculty` (`lw` `re` `we` `ge` `ea` `eb` `di` `pp` `bw` `fw` `ps`, dtx:1072-1095, 1014), `campus` (`ugent` `kortrijk` `gugc`, :1514-1519), `language` (`english` `dutch`, :1770-1774), `neutralcolors`, `colormodel` (`rgb` `cmyk`, :568-574), `localizedates` (:2256-2259), `nameformat` (`surnamefirst` `surnamelast`, :2445-2449), `affiliationformat` (`arabic` `alph`, :2463-2468), `cameraready` (:2594), `bare` (:2610), `thumbs` (:2629), `copyright` (:2647), `examiner` (:2665), `coverbg` (:2679), `foldline` (:2695), `secnums` (:2729); base-class options `a4paper` ... `executivepaper`, `10pt` `11pt` `12pt`, `oneside` `twoside`, `openright` `openany` are forwarded to `book`/`article`/`letter` (:2791-2795, 2806-2809, 2815-2818). Examples: `[pp,11pt,twoside,openright,coverbg]{ugentbama}` (:8257), `[bw,10pt,twoside,openright,cameraready]{ugentphd}` (:8260), `[bw]{ugentletter}` (:8263), `[we,10pt,dutch]{ugentexam}` (:8264), `[10pt]{ugentarticle}` (:8266).
- Class-native vocabulary used: `\title[short]{}`, `\subtitle`, `\titel` `\subtitel` (:3402, 3457, 3431, 3475), `\author{title}{Surname, First}{affiliation}` (:4321, 8813), `\supervisor` `\cosupervisor` `\extsupervisor` `\tutor` `\lecturer` `\jurychair` `\jurymember` `\dean` `\rector` (:4427-4614), `\degree` (:3573), `\doctype` (:3603), `\academicyear` (:2331), `\studentnr` (:4646), `\wordcount` (:3622), `\embargo[start=,end=]` (:3762), `\isbn` (:3713), `\doi` (:3694), `\grants` (:3675), `\coverimage` (:3506), `\frontcoverlogos` (:3527), `\backcoverlogos` (:3540), `\copyrightnotices` (:3837), `\extranotices` (:3856), `\maketitle` (:5663), `\generatebookcover` (:6165, 9263), `\makefinalpage` (:6052), `\insettext` `\insetquote` (:3283, 3363), letter `\sender` `\returnaddress` `\to` `\toorganization` `\toaddress` `\subject` `\reference` `\team` (:9213-9234, 8458), exam `\course` `\exampart` `\examseries` `\examduration` `\examstart` `\examend` `\room` `\extrainfo` `\question[weight=]` `\subquestion` `\pointoverview` `\answerspace` `\answerspacing` `\bilingual` `\mc` `\mcsymb` (:4826-5208, 5265, 5360), article `\affiliation` `\author[email=,orcid=,corresponding]` `\keywords` `\highlights` `\graphicalabstract` `\journal` `\abstract` `\date[submitted|accepted|published]` (:4059, 8887-8910, 8690-8702, 3871, 3883, 3940, 8472-8474), beamer `\title` `\subtitle` `\authorrole` `\department` `\team` `\titlelogos` `\closingpage`, environments `graphicframe` and `frame[title|section|logo=false]` (:10016, 10057-10066, 11107, 11127, 11460).

## Component map
Every row is set inside the published classes (the emitter reaches it with the one class line and its options); the ways named are the nearest lib homes for what the source shows. File is `ugentdocs.dtx`, cited as `:line`.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class, book family | :2790, 2836, 8256-8262 | `class.ugentcourse` `class.ugentbama` `class.ugentphd` `class.ugentreport`, base `class.book` | `\LoadClass{book}`; options above |
| document class, article family | :2814, 2879, 8264-8266 | `class.ugentexam` `class.ugentarticle`, base `class.article` | `\LoadClass{article}` |
| document class, letter | :2805, 2876, 8263 | `class.ugentletter`, base `class.letter` | `\LoadClass{letter}`; `ugentletter.cfg` at :9965-9992 |
| document class, cover | :2800, 2873, 6109 | `class.ugentbookcover`, base `class.bookcover` (CTAN, LPPL 1.2, read once) | `coverheight=24cm,coverwidth=16cm,bleedwidth,marklength` passed by phd (:2854-2859); 29.7cm x 21cm for course (:2862-2867) |
| slide class and theme | :10015-10016, 10856-10859 | `class.beamer`, `slide.beamer-theme` | `\usetheme[bw]{ugent}`; colour, font, inner and outer themes `ugent` |
| paper, size, sides | :2791-2795 | `page.class-options` | a4paper, 11pt, oneside, openright (book family); 10pt (letter, article) |
| page geometry | :3137, 3146-3150, 3153-3158, 3161-3165, 3168-3172, 3175-3179 | `page.geometry` | `heightrounded`; course, report, exam: top=2.54cm,bottom=2.54cm,left=2\gridunit,right=2.97cm; phd: 160mm x 240mm, inner=2cm,outer=2cm,twoside; bama: left=right=2\gridunit; letter: footskip=4\gridunit,top=5\gridunit,bottom=4\gridunit,right=4.07cm; article: all sides 2\gridunit; `\gridunit` = max(width,height)/7/4 (:3137) |
| slide size | :10843 | `poster.baposter` (package `beamerposter`) | orientation=landscape,size=custom,width=33.87cm,height=19.05cm,scale=1 (:10825-10826) |
| fonts | :862-882, 897-909, 894 | `font.fontspec`, `font.family-default` | `\setsansfont` via zip-local `\trysetsansfont`: UGent Panno Text, fallback Arial, `BoldFeatures={FakeBold=2.5}`, `ItalicFeatures={FakeSlant=0.15}`; Medium (`LetterSpace=-0.75`) and SemiLight (`LetterSpace=0.1`) faces for logos; `\familydefault`=`\sfdefault` |
| math font | :887-892 | `font.unicode-math` | `mathrm=sym,mathup=sym,mathbf=sym,mathit=sym,mathsf=sym`; Noto Sans Math `Scale=0.9`, fallback DejaVu Math TeX Gyre |
| symbols and font shapes | :2978, 2990-2994, 7895, 10849 | `font.icons`, `font.nfss` | `wasysym`, `fontawesome`; `\DeclareFontShape{U}{wasy}...`; `\usefont{OT1}{ocrb}{m}{n}` for the ISBN text |
| font sizes | :7312, 7318, 5934 | `font.size-commands` | `\fontsize{25}{30}`, `{15}{18}`, `{20}{28}` |
| colours | :494-534, 604-608 | `color.xcolor` | `\definecolor{ugent@main}{RGB}{30,100,200}`, `ugent@accent` {255,210,0}, eleven faculty colours (cmyk variants :498-513); `\colorlet{titlecolor}{ugent@main}`, `hypercolor`={ugent@main!50!black}, `insetboxcolor`={ugent@faculty} |
| page background colour | :3056 | `color.pagecolor` | `nopagecolor=white`, loaded only with `cameraready` |
| watermark | :3044, 5718 | `bg.background` | `contents={}`,`color=watermarkcolor`,`scale=3`; text "Copyright Ghent University, All Rights Reserved" (course, `copyright` option) |
| page overlay nodes | :2970, 5681-5691 | `bg.tikzpagenodes` | cover drawn in `shipout/foreground` on `current page` (inside the class, see Bespoke code) |
| spacing | :2900-2902, 2977, 7311 | `sp.lengths`, `sp.setspace`, `num.secnumdepth` | `\parindent`=0pt, `\parskip`+=0.75\baselineskip, `secnumdepth`=3; `\begin{spacing}{2.5}` on the bama cover title |
| headers and footers | :2982, 6417-6462, 6495-6576, 6592-6610, 6622-6643, 6655-6690 | `hf.fancyhdr`, `hf.pagestyle-kernel` | per class: `\fancyhead` `\fancyfoot` fields, `\headrulewidth`=1pt or 0.15pt or 0pt, `\headheight`=13.7pt or 21pt, `\footskip`=1.5cm; styles `frontmatter` `mainmatter` `plain` `titlepage` |
| page numbers | :2972, 6462, 6680, 5676, 5697 | `pgnum.pagenumbering`, `pgnum.lastpage` | `\pagenumbering{arabic}`, `gobble` on the cover; `zref-totpages`, `\ztotpages` in "page X/Y" |
| chapter and section headings | :6863, 6869-6899, 7120-7131 | `head.titlesec` | `\usepackage[explicit]{titlesec}`; chapter `plain`: `\fontsize{16}{19}\color{titlecolor}\bfseries`, `\MakeUppercase{\uline{#1}}`, `\titlespacing*{\chapter}{0pt}{-3em}{12pt}`; section: `\fontsize{14}{17}\bfseries` |
| heading marks and case | :2975, 6877 | `mark.ulem`, `mark.case` | `\usepackage[normalem]{ulem}`, `\ULthickness`=1pt (:2976); `\uline`, `\MakeUppercase` |
| chapter number box styles | :6901-6960, 6961-7019, 7092-7101 | `head.class-native` | styles `fancy` (phd), `fancycompact` (course), `uantwerpen`, `legacyplain`; set by the class through `\l_ugentdocs_chaptitlestyle_tl` (:6732-6792), not by a class option (inside class, `ART/class` if rebuilt) |
| appendix | :7083-7088, 9711 | `num.appendix` | `\def\appendix` resets chapter, `\Alph`, `\chaptername`=`\appendixname` |
| chapter thumbs | :3077-3091 | considered: `thumbs` (no lib home; loaded inside the class, the emitter writes only the `thumbs` class option) | `height=25.4mm,width=auto,distance=2mm,topthumbmargin=3in`; white number on `gray!50` |
| cut marks | :3055 | considered: `crop` (no lib home; class-internal, option `cameraready`) | `cam,center,width=21truecm,height=29.7truecm` |
| front matter, titles and covers | :5663-5700, 5841-5911, 5927-6040, 7724-7915 | `front.class-native`, `front.titlepage-env` | `\renewcommand\maketitle`; `titlepage` environment with cover in `shipout/foreground` (:5680-5691); letter: logos and address window in the foreground (:5844-5905); article: title, author list, hrule, two minipages 0.3/0.65 (:5988-6035) |
| title fields and sequences | :3402-3411, 3457-3462, 4321, 4427, 4545 | `front.class-native` | strings and "Surname, First" names parsed by expl3 (:2381-2394); `\author{}{}{}`, sequences `authors` `supervisors` `jury` ... |
| abstract and keywords | :3871, 3897-3905, 3919-3927, 6029-6035 | `abs.class-native`, `abs.keywords` | `\abstract{}` printed in the title page minipage; `\keywords{a, b}` joined with `;`; `\highlights` as itemize |
| copyright page, colophon, signatures | :5709-5712, 7934-8030 | `front.dedication`, `box.minipage`, `tbl.tabularx` | `\copyrightnotices`; signature rows `\rule{0.8\linewidth}{0.4pt}` in `tabularx{X@{\hspace{1.5cm}}X}` (:7961); embargo text keyed by language (:3736-3822) |
| licence notice | :8411 | `front.doclicense` | `type={CC},modifier={by-nc-nd},version={4.0}` (article example) |
| contents | :9324, 6341 | `toc.kernel`, `meta.hyperref` | `\tableofcontents`; link colour `toccolor` (black) inside it |
| hyperlinks and PDF metadata | :6360-6372 | `meta.hyperref` | `colorlinks=true,citecolor=hypercolor,linkcolor=hypercolor,urlcolor=hypercolor,pdfpagemode=UseOutlines,pdftitle,pdfsubject,pdfauthor`; example loads `hyperref[hyperindex=true]` (:8376) |
| cross-references | :9471, 9477, 9505 | `xref.kernel` | `\label{S:Tutorial}`, `\ref` |
| language and quotes | :3012-3018 | `lang.babel`, `lang.csquotes` | `main=dutch` or `main=english`, `babel[dutch,english]`, `csquotes` |
| dates | :3027-3029, 2283-2287 | `front.datetime` | `datetime2[useregional]`; ISO `YYYY-MM-DD` shown through `\DTMdate` |
| per-language template strings | :1783-1960, 1975-2236 | none (class-internal; `lang.translator` is a different mechanism) | `\translatekey[uppercase,expand]{key}` over `ugentdocs-english.dict` and `-dutch.dict` |
| lists | :9618-9631 | `list.kernel` | `description`, `itemize` with `\item[$\Box$]`, `enumerate` |
| inset boxes | :3283-3303, 3354-3376, 9474, 9644 | `class.ugentbama` native (nodes via `art.tikz`) | `\insettext{title}{body}`, `\insetquote{text}{author}`; fill `insetboxcolor!10`, title bar `insetboxcolor` white bold (inside class) |
| columns | :8382, 9410-9426 | `cols.multicol` | `multicols{2}` with a full-width optional argument for the summary |
| tables | :8385-8389, 9339-9340, 9516-9536 | `tbl.tabular`, `tbl.booktabs`, `tbl.multirow`, `tbl.threeparttable`, `tbl.tabularx` | `\toprule \cmidrule(lr){2-3} \midrule \bottomrule`, `\multirow`, `tablenotes`; `\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}` and `Y` |
| figures and captions | :2963, 2967, 8392, 9507-9512, 9543-9568 | `fig.graphicx`, `fig.float`, `fig.adjustbox`, `cap.kernel` | `figure[ht]`, `[H]`, `figure*[t]`, `\includegraphics[width=0.5\linewidth]`, `\caption[short]{long}`; `adjustbox[export]` |
| rotation | :6627, 8190 | `fig.rotating` | `\rotatebox{\@WMA}`, `\rotatebox[origin=c]{-90}` (graphicx) |
| maths | :9601-9614 | `math.amsmath` | `equation`, `align`; no `amsmath` load in the classes (grep), so how the example gets `align` was not established |
| units and chemistry | :8402-8406, 9634-9638 | `mark.siunitx`, `art.content-package` | `\sisetup{mode=text}`, `\qty` `\unit`; `mhchem[version=4]` `\ce{}` (content) |
| bibliography | :8395-8396, 9652 | `bib.biblatex-biber` | `backend=biber,style=authoryear`, `\addbibresource`, `\printbibliography` (the author's choice, not loaded by the classes) |
| hyphenation | :2962, 7588 | `sp.hyphenat`, `sp.penalties` | `hyphenat` `\nohyphens`; `\hyphenpenalty=100000` |
| exam questions | :4996-5001, 5040-5084, 5136-5151, 5169-5208 | `class.ugentexam` native | `question`, `subquestion` counters; `weight=` key and unit label `p`; `\pointoverview` table; `\bilingual{en}{nl}` two `minipage`s (`box.minipage`); `\mc{}` choice with `\@mcsymb` |
| exam answer space | :5264-5419, 5223-5245 | `class.ugentexam` native (`art.tikz` grids) | `\answerspace[style=grid\|lines,lines=n]`, `\answerspacing{len}`; dotted grid in shipout background (`ART/class`, `BESPOKE/class` if rebuilt) |
| book cover | :6109-6290, 8185-8230 | `class.ugentbookcover`, `class.bookcover` | `\newbookcovercomponenttype{title\|authoryear\|logo}`; `spinewidth` = pages/2 x 80 g/m2 x 1.25 cm3/g (:6166-6175); ISBN barcode `\EANBarcode` from `GS1` (considered, no lib home, :2985, 7887-7892) |
| beamer colours, fonts, templates | :10878-10931, 10944-11019, 11512-11731 | `slide.beamer-template`, `slide.beamer-theme` | `\setbeamercolor{block title}{fg=white,bg=ugent@main}`, `\setbeamerfont{frametitle}{size=...\LARGE\bfseries}`, `\defbeamertemplate*{background canvas}{title}` etc. (tikz, `ART/class`) |
| draft filler and demo helpers | :8370, 10027-10041 | considered: `kantlipsum` (filler content, as `draft.todo` admits `lipsum`) | demo only |

## Bespoke code
Everything below is defined by the published CTAN package, so it is `n/a: published class` under W1 and does not count. "If rebuilt" gives the scope it would carry if the classes were treated as zip-local (all tags `/class`).

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| expl3 key-value option engine and option-group forwarding to the base class | dtx:568-574, 2749-2786, 2825-2829 | n/a: published class (`BESPOKE/class` if rebuilt) | no: option values pick colours, logos, geometry and which pages print |
| language dictionary engine (`.dict` files read with `\ior`, `\translatekey`, `__NEWLINE__`) | dtx:1783-1960 | n/a: published class (`BESPOKE/class` if rebuilt) | no: closest lib way `lang.translator` stores per-language strings but does not read files or case them |
| font fallback loader `\trysetsansfont` `\trysetmathfont` `\tryoverridemathfont` (file probing, `\IfFontExistsTF`) | dtx:761-910 | n/a: published class (`BESPOKE/class` if rebuilt) | partly: the end effect is `font.fontspec` + `font.unicode-math` with the values listed above; the search logic is not a way |
| fake small caps `\fakesc`, `\textschelper` | dtx:917-926 | n/a: published class (`BESPOKE/class` if rebuilt) | no: character loop with scaled boxes (`\Hscale` .83, `\Vscale` .72) |
| UGent icon, faculty icons, ORCID icon, `\ugentlogo` `\faclogo` `\ficon` | dtx:1079-1340, 1375-1385, 1462-1493, 1541-1563, 1688-1703, 1713-1746 | n/a: published class (`ART/class` if rebuilt) | no: TikZ path data (`\path[nonzero rule] ... controls ...`) and text nodes in Panno Text, scaled by `\@logounit`=0.75cm |
| covers: `\@frontcover`, `\@backcover`, bodies for bama, report, exam, course, phd, blank image | dtx:7306-7385, 7401-7460, 7478-7560, 7573-7604, 7618+, 7724-7761, 7772-7826, 7838-7855, 7875-7915 | n/a: published class (`ART/class` if rebuilt) | no: full-page TikZ on a grid, clip, coloured areas, logos, ISBN barcode, exam name boxes (`\draw ... rectangle`, :7511-7535) |
| chapter heading styles (number box, rotated chapter name, `\@UAChapNum` outline loop, `\@makechapterhead` redefinition) | dtx:6901-7101 | n/a: published class (`ART/class`, `BESPOKE/class` if rebuilt) | no: `tikzpicture[overlay]` on `current page.north east`; `\def\@makechapterhead` (:7022-7051) |
| footer logo on every page | dtx:6540-6544, 6564-6568 | n/a: published class (`ART/class` if rebuilt) | no: `\ugentlogo` in an overlay picture inside a `\fancyfoot` field |
| letter head: logos, address window, fold mark, sender block in the shipout foreground | dtx:5841-5905 | n/a: published class (`ART/class` if rebuilt) | no |
| exam: counters, aux-file point overview (`.exq`), `\answerspace` (zref-savepos, page-break loop, shipout-background grid), `\gridpage` | dtx:4996-5151, 5223-5245, 5264-5419 | n/a: published class (`BESPOKE/class` and `ART/class` if rebuilt) | no: layout computed from saved positions and written to a file |
| name, affiliation and people sequences, ORCID and e-mail footnotes | dtx:2370-2548, 3964-4650 (outline read) | n/a: published class (`BESPOKE/class` if rebuilt) | no |
| `\generatebookcover` (writes `<jobname>-cover.tex` with `\iow`, computes spine width) | dtx:6165-6290 | n/a: published class (`BESPOKE/class` if rebuilt) | no: a second document is generated and compiled by TeX itself, no tool outside TeX |
| embargo logic and signature page | dtx:3736-3822, 7934-8030 | n/a: published class (`BESPOKE/class` if rebuilt) | no |
| `\runwordcount` through `\ShellEscape{texcount ...}` | dtx:3648-3660 | n/a: published class (`EXTERNAL/class` if rebuilt, conditional) | no |
| `thumbs` patch (`\@fixthumbposy`) | dtx:3099-3114 | n/a: published class (`BESPOKE/class` if rebuilt) | no: saves and restores `\th@mbposy` |
| beamer theme: `\place`, `\brightness`, `\textbox`, `graphicframe`, background canvas, title, section and footline templates, `\closingpage` | dtx:11037-11102, 11127-11175, 11460+, 11512-11731 | n/a: published class (`ART/class`, `BESPOKE/class` if rebuilt) | no |
| sample-level: `\newsavebox\cclogobox` with `\copyrightnotices{...}` (article example) | dtx:8760-8772 | yes | `front.doclicense` image box beside text in `box.minipage` |
| sample-level: `\cmd`, `codesnippet`, `\ind`, `\bframe`, `\eframe` (user guide helpers) | dtx:10027-10041 | yes | aliases and a framed minipage (`box.fancybox`, `box.minipage`, `font.family-default`) |
| sample-level: GAI table with `\newcolumntype` L and Y | dtx:9374-9400 | yes | `tbl.tabularx`, `tbl.tabular` column types, `font.icons` for `\Box` `\CheckedBox` |

## Content-opaque
- `\ce{H2O + e- -> 1/2H2 + OH-}` chemical equation (dtx:9638, `mhchem`); `\foreach` dummy chapters in the PhD examples (dtx:9699-9704) and kantlipsum filler (dtx:8370, 9242).
- Cover photo `Images/ugent-oehoe.jpg` (1385 x 1818 pixels, used at dtx:8577) and `example-image-a/b/c` logos (dtx:8588-8616) are assets, not template.

## Lib changes
- New ways proposed: none. Considered and not proposed (loaded inside the classes, never written by an emitter): `thumbs` (dtx:3077), `crop` (dtx:3055), `GS1` (dtx:2985, EAN barcodes through `rule-D`, ctan.org/pkg/gs1 read: LPPL 1.3c, no external tool), `kantlipsum` (filler).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
