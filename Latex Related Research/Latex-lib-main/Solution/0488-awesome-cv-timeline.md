no

# 0488-awesome-cv-timeline: Awesome CV Timeline

- Unverified: read from the source, not compiled.
- Source: Source/0488-awesome-cv-timeline/ (origin: https://latextemplates.com/downloads/awesome-cv-timeline.zip; licence: LPPL-1.3c, resume.cls:1-2, README.md:60-62)
- Kind: cv
- Lib: v4
- Engine: needs XeLaTeX (`fontspec` and `unicode-math` loaded unconditionally, resume.cls:62,66; opentype Source Sans Pro, :70; fonts loaded by file path, :342-356; main.tex:3 and README.md:15-17 name xelatex)
- Look carried by: zip-local (resume.cls defines every style macro, the entry and header macros and the timeline; main.tex only fills data slots, sets lengths and places two `textblock*` columns)
- Class origin: zip-local (`resume.cls` is a fork of Awesome-CV patched by latextemplates.com, resume.cls:4-6 and README.md:3,12,21-58; ctan.org/pkg/resume and ctan.org/pkg/awesome-cv both returned 404; README.md:12 says "not on CTAN"; the zip is not an official release)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (resume.cls, 1347 lines, read in full; README.md and the font file list also read; the ten Roboto .ttf files are binary assets and were not opened)

## Verdict
No. The template's identity is a TikZ timeline drawn between a sidebar and a body column, built from positions that `zref-savepos` writes to the aux file on one pass and TikZ reads on the next (resume.cls:1298-1343; main.tex:3-5 calls it the feature no other CV has). It is artwork with no declarative lib way (`cv.timeline` is the `moderntimeline` date-bar package for moderncv, a different thing), and the section and entry counters that feed it are hand-rolled logic that is also threaded into `\cvsection`, `\cventry` and `cventries`. Everything else (fonts, colours, geometry, footer, header, entry rows, bullet lists, skill badges, absolute two-column placement) reduces to lib ways, so the `no` rests on the timeline alone.

## Blockers
- `ART/class` timeline: a `tikzpicture` with `remember picture, overlay`, node styles `section` (filled circle, 7pt) and `entry` (open circle, 5pt) and `\foreach` loops that draw nodes and lines only where a saved position is non-zero; called from the body at main.tex:74 (resume.cls:1298-1343)
- `BESPOKE/class` position-saving logic feeding the timeline: counters `sections` and `entries`, `\startsection` `\startentry` `\stopsection` writing `\zsavepos{<Letter><n>}` labels, `\getposy`, `\tikzposxshift` (`\evensidemargin + 1in + ...`), `\tikzpossection` `\tikzposentry` `\tikzposend` with hand offsets +5pt, -7pt, 0pt (resume.cls:1179-1241); the labels exist only for the drawing, and `\cvsection`, `\cventry` and the end of `cventries` call them (resume.cls:979-983, 1030, 1108-1111)
- `ART/class` photo frame: a `tikzpicture` node (`circle` or `rectangle`, border, `fill overzoom image`) is the template's portrait slot (resume.cls:635-657); not exercised, `\photo` is commented out (main.tex:33)

## Class setting
- Class: zip-local `resume`, no `class.resume` claimed; its base is `class.article` (resume.cls:26); options `11pt, a4paper` (main.tex:14) go to article through `\DeclareOption*` (resume.cls:24); `draft` and `final` set `\overfullrule` to 5pt and 0pt (resume.cls:21-22)
- Class-native vocabulary used: `\name{}{}` `\address{}` `\mobile{}` `\email{}` `\github{}` `\linkedin{}` `\position{}` (main.tex:25-32), `\makecvfooter{l}{c}{r}` (35), `\makecvheader` (39), `cvsummary` (41-45), `\timeline{C}` (74), `\cvsection{}` (79, 93, 120, 150), `\skillcategory{}` + `skillstable` + `\skill{}` (94-102), `\hobbiesstyle{}` (110-111), `\caddressicon \caddress \cmobileicon \cmobile \cemailicon \cemail \cgiticon \cgituser \clinkedinicon \clinkedinuser` (84-88), `cventries` + `\cventry{position}{title}{location}{date}{description}` (121-174), `cvitems` (128-171). Defined, not used: `\photo`, `\firstname`, `\lastname`, `\homepage`, `\gitlab`, `\stackoverflow`, `\twitter`, `\instagram`, `\orcid`, `\extrainfo`, `\quote`, `\cgitproject`, `\cpaperlink`, `\corcid*`, `iconstable`, `\cvsubsection`, `\cvsubentry`, `cvparagraph`, `cvitemsnested`, `\keyword`, `\skilltikz`, `\vhrulefill`, `\setupdebug`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | resume.cls:26; main.tex:14 | `class.article` | base of the zip-local `resume`; options `11pt`, `a4paper` |
| paper and size | main.tex:14; resume.cls:21-24 | `page.class-options` | `11pt`, `a4paper`; `draft`/`final` only set `\overfullrule` (see `sp.lengths`) |
| page geometry | resume.cls:39,264; main.tex:16-17 | `page.geometry` | class default left=1.5cm, top=1.5cm, right=1.5cm, bottom=2cm, footskip=.5cm; main.tex repeats it with left=right=`\sidemargin` (1.5cm) |
| header/footer machinery | resume.cls:41,267-276 | `hf.fancyhdr` | `\fancyhfoffset{0em}`, `\headrulewidth` 0pt, `\fancyhf{}`, `\pagestyle{fancy}` |
| footer text | resume.cls:485-486,778-782; main.tex:35 | `hf.fancyhdr` | `\fancyfoot[L]{\today}`, `[C]{Jordan Ashworth~~~\textperiodcentered~~~Resume}`, `[R]{\thepage}`; each field 8pt, `\footerfont` (`\sourcesanspro`), `\scshape`, `lighttext` |
| colour palette | resume.cls:51,284-316; main.tex:19 | `color.xcolor` | `\definecolor{..}{HTML}{..}`: darkgray 333333, gray 5D5D5D, lightgray 999999, darktext 414141, awesome-emerald 00A388, awesome-concrete 95A5A6 (and 7 more awesome-*); `\colorlet{text}{darkgray}`, `graytext`, `lighttext`, `iconcolor`; the name `awesome` is used by the class (245, 324, 472, 535, 548) but defined only in main.tex:19 as `awesome-emerald` |
| body text face | resume.cls:70,373-375 | `font.helvet` | `sourcesanspro` options `default,opentype` (a sans text-face package is the parameter); `\bodyfont`=`\sourcesanspro`, `\bodyfontlight`=`\sourcesansprolight` (package source not read) |
| header face (Roboto) | resume.cls:62,64,342-356 | `font.fontspec` | `[quiet]`, `\defaultfontfeatures{Ligatures=TeX}`; `\newfontfamily\headerfont[Path=fonts/, UprightFont=*-Regular, ItalicFont=*-Italic, BoldFont=*-Bold, BoldItalicFont=*-BoldItalic]{Roboto}`; `\headerfontlight` the same with Thin, ThinItalic, Medium, MediumItalic; ten .ttf files shipped in fonts/ |
| math font | resume.cls:66 | `font.unicode-math` | load only; the sample has no maths |
| icon glyphs | resume.cls:69,848-882; main.tex:84-88 | `font.icons` | `fontawesome5`: `\faMapMarked*`, `\faMobile`, `\faEnvelope`, `\faGithubSquare`, `\faLinkedin`; `\icon{}` is `{\symbolsfont\color{iconcolor} #1}` with `\symbolsfont` empty (370,376) |
| font sizes | resume.cls:466-550 | `font.size-commands` | `\fontsize{<pt>}{1em}`: name 32pt, position 17pt, summary 10pt, footer 8pt, sidebar 8pt, skill type 10pt, skill badge 7.5pt, section 16pt, entry title 10pt, entry position and location 9pt, entry date and description 8pt |
| shapes and weights | resume.cls:466-550 | `mark.kernel` | `\bfseries`, `\scshape`, `\itshape`, `\slshape`, `\upshape` per element style (position and section small caps, date slanted) |
| paragraph skip | resume.cls:74,761,1028,1120 | `sp.parskip-pkg` | load only; `\parskip` then set to 0pt inside `cvsummary`, `\cventry`, `cvitems` |
| lengths | resume.cls:21-22,761,1025-1028,1120; main.tex:16,52-53,61-64 | `sp.lengths` | `\parskip` 0pt, `\tabcolsep` 0pt, `\extrarowheight` 0pt, `\overfullrule`; main.tex: `\sidemargin` 1.5cm, `\headersmargin` 3.6cm, `\leftcolumnwidth` 5cm, `\columnsmargin` 0.5`\sidemargin`, `\timelinemargin` 0.5cm |
| line-spacing package | resume.cls:60 | `sp.setspace` | `[nodisplayskipstretch]`, load only |
| alignment | resume.cls:37,692-718,1118 | `sp.ragged` | `ragged2e`; `flushleft`/`center`/`flushright` chosen by `\makecvheader[L\|C\|R]` (default C, used); `justify` env in `cvitems`; `\raggedright` in `cventries` |
| manual spacing | resume.cls:172-193,679,706,747,764,1105,1117,1126; main.tex:77,91,118,136,162 | `sp.manual-space` | `\vspace` header 4mm before, `\\[4mm]` between name and position, 4mm after; summary 3mm after; section-to-content 1.5mm; `cvitems` -4.0mm both sides; main.tex -2mm, 3mm, 4mm |
| section rule (not used) | resume.cls:610-611 | `sp.rule` | `\vhrulefill#1` = `\leavevmode\leaders\hrule\@depth-4pt\@height4.9pt\hfill\kern\z@`; defined, never called |
| links and metadata | resume.cls:76-82,848-882,981 | `meta.hyperref` | `[hidelinks,unicode]`, `\hypersetup` with empty `pdftitle` `pdfauthor` `pdfsubject` `pdfkeywords`; `\href` on each contact (maps.google.com, github.com, linkedin.com, mailto:); `\phantomsection` after each section title |
| CV header block | resume.cls:633-749; main.tex:25-39 | `box.minipage` | for the path the sample takes (no photo, align C): `\vspace{4mm}`, a 0cm photo minipage and a `[c]` minipage of `\textwidth` holding a `center` env with first name (32pt `\headerfontlight` `graytext`) and last name (32pt `\headerfont` bold `text`), `\\[4mm]`, position (17pt `\bodyfont` `\scshape` `awesome`), `\vspace{4mm}` |
| summary | resume.cls:760-765,480-481; main.tex:41-45 | `sp.lengths` | environment = group with `\parskip` 0pt, 10pt `\bodyfontlight` `\upshape` `text`, then `\vspace{3mm}`; text is content |
| two-column placement | resume.cls:93; main.tex:76,115-118 | `pg.textpos` | `textpos[overlay]`; `\begin{textblock*}{\leftcolumnwidth}(0pt,\headersmargin)` and `\begin{textblock*}{\paperwidth - 2\sidemargin - \leftcolumnwidth - \columnsmargin - 2\timelinemargin}(\leftcolumnwidth + \columnsmargin + 2\timelinemargin, \headersmargin)` with `calc` arithmetic (resume.cls:95); `\headersmargin` 3.6cm is tuned by hand to the rendered header height (main.tex:55-61) |
| section heading | resume.cls:519-520,979-983,323-325; main.tex:79,93,120,150 | `head.titlesec` | style only: 16pt `\bodyfont` `\bfseries` `\scshape` in `awesome` (`sectioncolorhighlight` true), unnumbered, no counter; reduces to `\titleformat` or inline styled text plus `\phantomsection`; the `\startsection` call inside `\cvsection` is the timeline blocker |
| contact table | main.tex:83-89 | `tbl.tabular` | `tabular*{\leftcolumnwidth}{@{}l@{\hspace{2mm}}l@{}}` rows `icon & text`, five rows; cell styles 8pt `\bodyfontlight` `text` (`\contactstyle`, 499-500) |
| skill badges | resume.cls:930-953,955-960; main.tex:94-102 | `box.tcolorbox` | `\newtcolorbox{skillbadge}{colframe=lighttext, colback=white, height=11pt, width=1.47cm, boxrule=0.4pt, top=-0.8pt, bottom=0pt, left=-1pt, right=-1pt, tcbox raise base, halign=center, nobeforeafter, on line}`; `[skins]` loaded (72,91); `skillstable` is `\vspace{-0.3mm}` before and `\vspace{-1.0mm}` after |
| spoken languages | main.tex:109-112 | `box.minipage` | `minipage{\leftcolumnwidth}` with two `\hobbiesstyle` lines (8pt light) separated by `\\` |
| entry rows | resume.cls:602-607,1023-1043; main.tex:122-173 | `tbl.tabular` | `tabular*{\textwidth}{l r}` with `\tabcolsep` 0pt; rows `title & location` (10pt bold `darktext`, 9pt slanted `awesome`), `position & date` (9pt `\scshape` `graytext`, 8pt slanted `graytext`), then `\multicolumn{2}{L{\textwidth}}{description}` (8pt light); two-field form when title and location are empty (`\ifempty`, 614); `L/C/R` = `m{#1}` with `\raggedright\let\newline\\\arraybackslash\hspace{0pt}` |
| entries container | resume.cls:1102-1112; main.tex:121,148,151,174 | `sp.ragged` | `\raggedright`, `\vspace{1.5mm}`, kernel `center` env around the entries; the closing `\stopsection` is the timeline hook |
| bullet lists | resume.cls:35,1116-1127; main.tex:128-131 | `list.enumitem` | `itemize[leftmargin=2ex, nosep, noitemsep]`, `\labelitemi`=`\bullet`, `\labelitemii`=`$\circ$`, inside `justify` |
| bullet list kind | resume.cls:1119 | `list.kernel` | `itemize` |
| timeline drawing | resume.cls:99-103,1298-1347; main.tex:74 | `art.tikz` | ART/class: `tikzpicture[remember picture, overlay, color=darktext]`, `\foreach`, `\ifnum \zposy{..}>0`, nodes and `\draw` between them; `calc` and `positioning` libraries |
| saved positions | resume.cls:97,1194-1241 | `xref.zref` | `zref-savepos` module (`\zsavepos`, `\zposy`, `\zposx`): the package is the same family as `xref.zref`, used here only as anchors for the drawing (BESPOKE/class) |
| photo frame (not used) | resume.cls:388-403,635-657 | `art.tikz` | ART/class: node `circle`/`rectangle`, `draw=darkgray|none`, `line width=0.3mm`, `inner sep` 1.3cm or 1.8cm, `fill overzoom image=\@photo`; `\photo[shape,edge,align]{file}` parsed with `\@for` |
| bibliography (loaded, not used) | resume.cls:106-124,554; README.md; main.tex:8-12 | `bib.biblatex-biber` | `biblatex[backend=biber, style=authortitle, maxbibnames=9, maxcitenames=4, sorting=ydnt, dashed=false]`, `\AtEveryBibitem` clears doi url isbn issn eprint note publisher location month language pages volume number; the sample has no `\addbibresource`, citation or `\printbibliography` |
| loaded, unused tables | resume.cls:85,89 | `tbl.multirow`, `tbl.tabularx` | load only, no use in main.tex or the class bodies read |
| figures, captions, maths, theorems, footnotes, index, cross-references | not defined, not used (main.tex:37-177) | none needed | the sample has none of these |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\timeline` and its node styles | resume.cls:1298-1347 | no | TikZ overlay driven by saved page positions; no lib way (`cv.timeline` is a different package); ART/class |
| `sections`/`entries` counters, `\startsection` `\startentry` `\stopsection`, `\getposy` `\getposx`, `\tikzposxshift`, `\tikzpossection` `\tikzposentry` `\tikzposend` | resume.cls:1179-1241 | no | counters and labels that exist only to place the timeline; two-pass aux-file logic with hand offsets |
| `\cvsection` | resume.cls:979-983 | yes without the hook | styled title as in the heading row; its `\startsection` call is part of the timeline blocker |
| `\cventry` and `cventries` | resume.cls:1023-1043,1102-1112 | yes without the hooks | unrolled to the `tbl.tabular` rows above; `\startentry` and `\stopsection` belong to the timeline blocker |
| `\makecvheader` | resume.cls:633-749 | yes for the no-photo path | unrolled as in the header row; `\newcommand`, `\newlength` run inside the macro on every call (635, 638, 663); the photo branch is ART |
| `\drawphoto`, `\photo` | resume.cls:388-403,635-657 | no | TikZ portrait slot; ART/class, not exercised |
| `skillbadge`, `\skill`, `skillstable`, `\skillcategory` | resume.cls:906,930-960 | yes | `\newtcolorbox` options as in the badge row (`box.tcolorbox`) |
| `\skilltikz` | resume.cls:911-927 | n/a | an unused TikZ badge (`art.tikz`); never called, `\skill` uses `skillbadge` |
| contact macros `\caddress` ... `\clinkedinicon` | resume.cls:848-882 | yes | `\href{url}{text}` (`meta.hyperref`) with `font.icons` and colour; URLs are strings the emitter writes |
| `cvsummary`, `cvitems`, `\makecvfooter` | resume.cls:760-765,1116-1127,778-782 | yes | as in the summary, list and footer rows |
| `\newcolumntype` L/C/R | resume.cls:602-607 | yes | `array` column types, `tbl.tabular` |
| debug machinery: `debugmode` bool, `\debug`, `debugframe`, `\setupdebug`, `iconstable` | resume.cls:224-253,815-829 | yes | the `false` branch is taken (225); inline expansion gives the same text without the frame |
| `\newlength{\headersmargin}`, `\newlength{\columnsmargin}` and their values | main.tex:52-53,61-64 | yes | inline lengths 3.6cm and 0.75cm in the `textblock*` arguments (`pg.textpos`, `sp.lengths`) |
| helper packages `ifxetex`, `xifthen`, `ifthen`, `etoolbox`, `calc` | resume.cls:53-58,95 | yes | macro-body helpers with no printed effect; removed by inline expansion |
| `\renewcommand*{\quote}[1]{\def\@quote{#1}}`, `\keyword` calling undefined `\keywordstyle` | resume.cls:448,1084 | yes | unused; `\quote` replaces the kernel `quote` environment by a one-argument setter, `\keywordstyle` is never defined; neither is reached by the sample |
| `\vhrulefill`, `\cvsubsection`, `\cvsubentry`, `cvparagraph`, `cvitemsnested` | resume.cls:610,987,1050,1089,1131 | yes | not called by the sample; unrolled, they are `sp.rule`, `tbl.tabular`, `list.kernel` and manual spacing |

Read-only remarks that do not change the verdict:
- `\timeline` runs `\foreach \s[count=\i from 0] in {#1}` (resume.cls:1313), which by reading iterates only over the letters given; `\timeline{C}` (main.tex:74) would then draw section C (Experience) and not D (Education), against the comment at resume.cls:1311-1312 and README.md:50-54. Not compiled, so this is a reading, not a measurement.
- The timeline's x position uses `\leftcolumnrightmargin` (resume.cls:1201), a length main.tex never sets, while the right text block is offset by `\columnsmargin` (main.tex:117); the two have to be kept consistent by hand.
- `\headersmargin` must clear the header and summary height, which depends on how many lines they wrap to (main.tex:55-61); placement is by `textblock*` overlay, so text does not flow to a second page.
- biblatex is loaded unconditionally with `backend=biber` (resume.cls:106), and biber is in the lib as `bib.biblatex-biber`; the sample cites nothing, so no biber run is needed for the sample. Not treated as `EXTERNAL`.

## Content-opaque
none (the sample draws no figure or table float; the timeline is template artwork, so it is a blocker, not content)

## Lib changes
- New ways proposed: none. Considered, not used: `cv.entries` (its commands are the zip-local fork's `\cventry` and not published, so each is unrolled to published ways), `cv.timeline` (`moderntimeline` date bars on moderncv entries, not a vertical node-and-line chart between columns), `bg.tikzpagenodes` (the class uses raw `remember picture, overlay` and `current page`, not that package).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
