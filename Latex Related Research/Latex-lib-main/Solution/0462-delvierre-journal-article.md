yes

# 0462-delvierre-journal-article: Delvierre Journal Article

- Unverified: read from the source, not compiled.
- Source: Source/0462-delvierre-journal-article/ (origin: https://latextemplates.com/downloads/delvierre.zip; licence: LPPL-1.3c)
- Kind: journal
- Lib: v4
- Engine: pdfLaTeX-compatible (`inputenc`/`fontenc`/`newtx`, no fontspec; delvierre.cls:39-42; the CTAN page calls the class pdfLaTeX-based)
- Look carried by: mixed (delvierre.cls defines the page, front matter, headings and bibliography; main.tex sets the class's `\set*` knobs and re-declares six private class hooks, main.tex:21-114)
- Class origin: ctan
- Main file: main.tex (other samples: none; the zip is main.tex + delvierre.cls only)
- Read: main yes, zip-local classes and styles all (delvierre.cls, 1512 lines, read in full; lines 1474-1512 sit after `\endinput` at delvierre.cls:1471 and never run)

## Verdict
The look is carried by the `delvierre` class, which is on CTAN (ctan.org/pkg/delvierre: LPPL 1.3c, listed as in TeX Live and MiKTeX), so it is a published class way, `class.delvierre`, and W1 to W4 hold for it; the zip's own `delvierre.cls` was not compared with the CTAN copy. The sample's only bespoke code is the `\makeatletter` block (main.tex:71-115), and each of its six redefinitions reduces to lib ways (emptied class hooks, an inline note, a copy of the class default, four `minipage` boxes). There is no external tool, no template-defining artwork, and no unmapped component. The verdict rests on the class being published: if the class were judged zip-local, its output-routine and geometry-register code (delvierre.cls:154-170, 394-464, 1386-1414) would be `BESPOKE/class` and the answer `no`.

## Blockers
none

## Class setting
- Class: `class.delvierre` options: none given (`\documentclass{delvierre}`, main.tex:17); the class offers `mono` and `color`, default `color` (delvierre.cls:27-32); base class `article` with `a4paper,10pt,twocolumn` (delvierre.cls:35)
- Class-native vocabulary used:
  - sizing setters: `\setfrontmattertitlesize` `\setfrontmattervshift` `\setaftertitlewidevshift` `\setarticletitlefontsize` `\setauthorfontstyle` `\setaffilfontstyle` `\setsectiontitlestyle` `\setsubsectiontitlestyle` `\setsubsubsectiontitlestyle` (main.tex:21-29)
  - page setters: `\setdelvierremargins` `\setheadheight` `\setheadsep` `\setfootskip` `\setbodyfootskipextra` `\setpagenumbervshift` `\setmanuscriptruleskip` (main.tex:30-37)
  - block setters: `\sethighlightslistopts` `\setfrontmatterwidths` `\setgraphabsmaxheight` and five `\setfirstpagefoot*` setters (main.tex:38-45)
  - metadata setters, all emptied: `\publisherlogo` ... `\license{}{}` (main.tex:48-66, 69); filled: `\correspondingauthor` `\correspondingemail` (main.tex:67-68)
  - front matter: `\title` `\author[n]{..\orcid{..}}` `\affil[n]` (authblk), `\keywords{a; b}`, environments `abstract` `graphicalabstract` `highlights` (main.tex:117-164); `\maketitle` (main.tex:167); `\DelvierreBibHref` (main.tex:212, 216)
  - private hooks re-declared: `\Delvierre@Masthead` `\Delvierre@ContentsBlock` `\Delvierre@TitleRightCrossmark` `\Delvierre@FirstPageNoteText` `\Delvierre@PlaceFirstPageFooterOverlay` `\Delvierre@FrontMatter` (main.tex:72-114)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:17; delvierre.cls:22, 35 | `class.delvierre` | no options; loads article with a4paper, 10pt, twocolumn |
| paper size and type size | delvierre.cls:35 | `page.class-options` | a4paper, 10pt |
| two columns | delvierre.cls:35 | `cols.twocolumn-option` | twocolumn |
| full-width title block over the columns | delvierre.cls:1386-1410 | `cols.twocolumn-cmd` | `\twocolumn[\thispagestyle{delvierreFirst}\noindent\hspace*{\DelvierreTitleXShift}\usebox{title box}]`, shift -12pt (delvierre.cls:237) |
| page geometry | delvierre.cls:50-85, 185-198; main.tex:30-33, 42 | `page.geometry` | top=1cm, bottom=1cm, left=1.2cm, right=1.2cm (main.tex:30), includehead, includefoot, heightrounded, headheight=18pt, headsep=8pt, columnsep=0.8cm, footskip=1.2cm (main.tex:31-33; delvierre.cls:62-75); `\newgeometry` with footskip=1.2cm on page 1, `\restoregeometry` after it (main.tex:42; delvierre.cls:446-455, 1389-1392) |
| page 2+ head and foot gaps | delvierre.cls:385-412, 446-464, 1394-1400; main.tex:34 | `hf.class-native` | `\setbodyheadsepextra` default 10pt (not set by the sample), `\setbodyfootskipextra{0pt}`; the class adds the head gap and shrinks `\textheight` after page 1 ships |
| bottom flush | delvierre.cls:36 | `pg.flush` | `\raggedbottom` |
| full-width strip (loaded, no strip used) | delvierre.cls:1252-1262; main.tex:36 | `cols.cuted` | `\stripsep`=15pt plus 1pt minus 1pt; `\Delvierre@WideBlock` (delvierre.cls:1264) is never called |
| running head and foot | main.tex:168-176; delvierre.cls:1317-1332 | `hf.fancyhdr` | `\fancyhf{}`, `\headrulewidth`=0pt, `\fancyfoot[C]{\sffamily\scriptsize\thepage}`, `\fancypagestyle{plain}` the same; first-page style `delvierreFirst` empty (delvierre.cls:1326-1332) |
| page 1 style override | main.tex:177 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| first-page footer note overlay | main.tex:85-94; delvierre.cls:1073-1094 | `bg.eso-pic` | `\AddToShipoutPictureFG*` + `\AtTextLowerLeft`, `\raisebox{-\footskip+raise}`; a 4.2cm rule (`sp.rule`) then the note text |
| first-page note text | main.tex:75-84, 67-68; delvierre.cls:1011-1053 | `front.class-native` | "Corresponding author" and "E-mail address" lines from `\correspondingauthor` and `\correspondingemail`; size `\tiny` (main.tex:41) |
| encodings | delvierre.cls:39-40 | `font.fontenc-t1` | `inputenc[utf8]`, `fontenc[T1]` |
| text and math font | delvierre.cls:41-42 | `font.newtx` | `newtxtext`, `newtxmath` |
| monospace font | delvierre.cls:43 | `font.mono` | `newtxtt` (package is the parameter) |
| microtypography | delvierre.cls:44 | `sp.microtype` | `tracking=true`; `\textls[120]` for front-matter headings (delvierre.cls:1118) |
| type sizes and font switches | main.tex:21, 24-29; delvierre.cls:1362, 1417-1419 | `font.size-commands`, `mark.kernel` | `\fontsize{15}{18}\selectfont\bfseries` title; `\sffamily\normalsize` authors; `\sffamily\small` affiliations; `\large`, `\normalsize`, `\small` with `\sffamily\bfseries` for the three heading levels |
| display maths | delvierre.cls:45 | `math.amsmath` | loaded; the sample has no equation |
| ragged and justified text | delvierre.cls:46, 1149, 1372 | `sp.ragged` | `ragged2e`; `\justifying` in the abstract, `\raggedright` for title and authors |
| first-line indent | delvierre.cls:47, 375 | `sp.indentfirst`, `sp.lengths` | `indentfirst`; `\parindent`=1.2em; abstract `\parindent`=0pt, `\parskip`=2pt (delvierre.cls:1152-1153) |
| line-breaking looseness | delvierre.cls:1150-1151, 1469 | `sp.hyphenat` | `\tolerance=1200`, `\emergencystretch=1.2em` in the abstract; `\sloppy` at the start of `thebibliography` |
| manual spacing | main.tex:96-113; delvierre.cls:1371-1380 | `sp.manual-space` | `\vspace` 0.75em, 0.55em, 0.85em; `\hspace{\DelvierreFMGap}`; `\vspace{0.35cm}` |
| rules | delvierre.cls:1119, 1230 | `sp.rule` | `\rule{\linewidth}{0.30pt}` under front-matter titles; `\rule{\linewidth}{0.4pt}` as the manuscript rule |
| colours | delvierre.cls:241, 264-265, 733 | `color.xcolor` | `delvierreBlue` RGB 0,51,102; `delvierreAccent` RGB 0,102,204; `orcidGreen` HTML A6CE39 |
| link set-up | delvierre.cls:268-284 | `meta.hyperref` | `pdfborder={0 0 0}`, `breaklinks=true`, `colorlinks=true`, `linkcolor=delvierreBlue`, `urlcolor=delvierreAccent`, `citecolor=delvierreBlue`; option `mono` gives `hidelinks`; `\href` and `\nolinkurl` in the note and bibliography wrappers |
| url style | delvierre.cls:285-286 | `meta.url` | `\urlstyle{same}`, `\Urlmuskip=0mu plus 1mu` |
| title, authors | main.tex:117-122, 167; delvierre.cls:1386-1414 | `front.maketitle`, `front.authblk` | `\title`, `\author[1]`, `\affil[1]`, `\maketitle`; `\affilsep`=4pt, `\Authands`=" and " (delvierre.cls:1343-1344); `authblk` loaded at delvierre.cls:256 |
| class title, ORCID, note, front-matter blocks | main.tex:119, 167; delvierre.cls:760-786, 1128-1184, 1204-1223 | `front.class-native` | `\maketitle` rebuilt as a saved box; `\orcid{id}` link; blocks "Article details", "Research highlights", "Graphical abstract" |
| front-matter layout | main.tex:95-114, 39; delvierre.cls:981-1000 | `box.minipage` | four `minipage[t]` boxes of `\DelvierreFMLeftWidth`=0.30\textwidth and `\DelvierreFMRightWidth`, gap 0.04\textwidth (main.tex:39); highlights and graphical abstract above, article details and abstract below |
| abstract | main.tex:127-137; delvierre.cls:835-838, 1146-1161 | `abs.class-native` | `abstract` environment captured into a macro and printed under an upper-case "Abstract" heading (delvierre.cls:1117-1120) |
| graphical abstract and highlights | main.tex:139-164; delvierre.cls:839-846, 1162-1184 | `abs.class-native` | `graphicalabstract` (graphic scaled to `\linewidth`, max height 7cm, main.tex:40; delvierre.cls:1166) and `highlights` environments |
| keywords | main.tex:124-125; delvierre.cls:797-815, 1136-1140 | `abs.keywords` | `\keywords{..;..}`; one line per `;`-separated item under "Keywords:" |
| section headings | delvierre.cls:1424-1430; main.tex:27-29 | `head.titlesec` | `\titleformat{\section}{style}{\thesection.}{0.55em}{\vspace*{0.6ex}}` and the same for subsection and subsubsection; `\titlespacing*` 0pt, 1.8ex, 1.1ex |
| lists | delvierre.cls:292-297; main.tex:38, 155-164 | `list.enumitem` | `\setlist[itemize]{leftmargin=*, topsep=2pt, itemsep=1.5pt, parsep=0pt, label=\textbullet}`; same for enumerate; `\newlist{delvierrehighlights}{itemize}{1}` with `leftmargin=1.2em`, `topsep=0pt`, `itemsep=0.4pt` (main.tex:38) |
| figure graphics | delvierre.cls:242, 246, 1166 | `fig.graphicx` | `graphicx`, `\graphicspath` of eight folders, `\setkeys{Gin}{width=\linewidth,height=..,keepaspectratio}` |
| table | main.tex:187-200 | `tbl.tabular` | `table[htbp]`, `\centering`, `tabular{lcc}`, `\hline` rules |
| table packages loaded, unused | delvierre.cls:248-250 | `tbl.booktabs`, `tbl.tabularx` | loaded by the class; the sample uses `\hline`; `tabularx` is used only by the masthead (delvierre.cls:972), emptied in main.tex:72 |
| captions | main.tex:189; delvierre.cls:251, 289 | `cap.kernel`, `cap.caption` | `\captionsetup{font=small, labelfont=bf}` |
| citations and list style | main.tex:181, 204; delvierre.cls:260-261, 1454-1468 | `bib.natbib` | `[square,numbers,sort&compress]`, `\setcitestyle{square,numbers,comma,sort&compress}`, `\bibsection` = `\section*{\refname}`, `\bibfont`=`\small`, `\bibsep`=1.2pt, `\bibhang`=1.2em |
| bibliography | main.tex:210-220 | `bib.thebibliography` | `thebibliography{99}`, `\bibitem`; whole entry wrapped in `\DelvierreBibHref{url}{text}` (an `\href` alias, delvierre.cls:1451) |
| labels and references | main.tex:179, 185, 190 | `xref.kernel` | `\label{sec:intro}`, `\ref{tab:results}` |
| graphical-abstract drawing | main.tex:18, 141-152 | `art.tikz` | content: TikZ nodes and arrows inside the `graphicalabstract` slot (see Content-opaque) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand{\Delvierre@Masthead}{}`, `\Delvierre@ContentsBlock`, `\Delvierre@TitleRightCrossmark` | main.tex:72-74 | yes | three class hooks set to empty, no logic; the class's own `\set*` and empty-string setters (main.tex:48-66) already remove the branding; `front.class-native` |
| `\Delvierre@FirstPageNoteText` | main.tex:75-84 | yes | one group with `\DelvierreFirstPageNoteSize`, `\setlength{\parindent}{0pt}`, `\setlength{\parskip}{1pt}`, `\raggedright`, `\hspace*{2em}`, `\textit`, `\href`, `\nolinkurl` on two class strings: `sp.lengths`, `sp.ragged`, `sp.manual-space`, `mark.kernel`, `meta.hyperref`, `meta.url`; text is content |
| `\Delvierre@PlaceFirstPageFooterOverlay` | main.tex:85-94 | yes | line for line the class default (delvierre.cls:1083-1094): `\AddToShipoutPictureFG*{\AtTextLowerLeft{\raisebox{..}{note}}}`; `bg.eso-pic`, `sp.manual-space` |
| `\Delvierre@FrontMatter` | main.tex:95-114 | yes | four `minipage[t]` boxes with class lengths, `\hspace`, `\par\vspace{0.35cm}`, then the class rule block: `box.minipage`, `sp.manual-space`, `sp.rule`; the same shape as the class default (delvierre.cls:1204-1223) |
| `\makeatletter` / `\makeatother` around the block | main.tex:71, 115 | yes | catcode switch needed to name the `@` hooks; no layout effect |
| delvierre.cls internals (output-routine registers, `\newgeometry`, `\RenewEnviron` capture, `;` keyword splitter, box-height clamp) | delvierre.cls:154-170, 394-464, 797-851, 1060-1072, 1386-1414 | not scored | the file is the published CTAN class `delvierre` (W1), so it is the way `class.delvierre`, not zip-local bespoke code; recorded as the pivot of the verdict |
| dead block after `\endinput` | delvierre.cls:1471-1512 | n/a | never executed; main.tex:72-114 repeats it by hand |

## Content-opaque
- TikZ picture of four boxes and three arrows in the `graphicalabstract` slot (main.tex:141-152), with `\usetikzlibrary{arrows.meta,positioning}` (main.tex:18); the author's diagram, not template identity.
- The class's own TikZ fallback for the ORCID icon (delvierre.cls:760-772) and for the Crossmark mark (delvierre.cls:868-872) sit inside the published class; the sample passes only an ORCID string (main.tex:119) and an empty DOI (main.tex:52), so only the ORCID fallback is drawn.
- Missing assets (not shipped, class falls back to text or drawing): `logo_journal.png`, `logo_delvierre.png`, `crossmark.pdf`, `orcid-id.pdf` (delvierre.cls:570-571, 576, 743); emptied by main.tex:48-51.

## Lib changes
- New ways proposed: none (considered: `environ`, `etoolbox`, `tikz` as loaded helpers of the class; none prints a component of its own, so no line)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
