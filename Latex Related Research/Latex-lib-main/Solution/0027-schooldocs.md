yes

# 0027-schooldocs: schooldocs (layout styles for school documents)

- Unverified: read from the source, not compiled.
- Source: Source/0027-schooldocs/ (origin: https://mirrors.ctan.org/macros/latex/contrib/schooldocs.zip; licence: LPPL 1.3)
- Kind: exam (exercise sheets, exams and course material; the sample is the package's own showcase of its title formats and page styles)
- Lib: v1
- Engine: pdfLaTeX-compatible (sample loads inputenc, fontenc, times, lmodern, charter, babel; schooldocs.dtx:657-660 discusses pdfLaTeX metadata; `totpages` needs a second pass, no external tool)
- Look carried by: zip-local (schooldocs.sty is generated from schooldocs.dtx by schooldocs.ins; it carries geometry, title block and all page styles; the sample preamble only sets its parameters. The package is itself published on CTAN, see Class origin note)
- Class origin: tex-distribution-unbundled (class `article`, kernel, not bundled; the zip adds a CTAN package, not a class. ctan.org/pkg/schooldocs read: CTAN package by Antoine Missier, LPPL 1.3, v1.6 2025-01-15)
- Main file: schooldocs-examples.tex (other samples: schooldocs.dtx documentation driver, lines 19-80, class `ltxdoc`)
- Read: main yes, zip-local classes and styles all (schooldocs.dtx lines 1-1072 and schooldocs.ins read in full; schooldocs.sty itself is not shipped, only generated; the two PDFs are compiled output and were not opened)

## Verdict
Yes. The whole look (page geometry, title block, seven named page styles) lives in one package, `schooldocs`, which is published on CTAN (W1) and is driven only by a style name, lengths, colours, font-switch lists and strings (W2), for a kind of component (W3), printable as preamble lines plus `\maketitle`-family body calls (W4). The sample defines no macro of its own beyond one `\definecolor`. Independently of accepting the package as a way, every definition inside schooldocs.dtx reduces to existing lib ways (fancyhdr page styles, geometry, rules, spacing, xcolor, fancybox), with no TikZ, no output routine, no external tool.

## Blockers
none

## Class setting
- Class: `class.article` options: a4paper, 11pt (schooldocs-examples.tex:2)
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (all four overridden or extended by schooldocs), `\section*`, `center`, `\newpage`, `\addcontentsline{toc}{section}{..}` (:92, :116). No `abstract`, no `\tableofcontents`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | schooldocs-examples.tex:2 | `class.article` | a4paper, 11pt |
| paper and size | schooldocs-examples.tex:2 | `page.class-options` | a4paper, 11pt |
| page geometry | schooldocs.dtx:601, 610 | `page.geometry` | scale=0.75, vmarginratio=3:4, heightrounded; loaded only if geometry is not already loaded (:601); override by `\newgeometry`; `includehead`/`includefoot` optional (documented :833) |
| header height | schooldocs.dtx:753, 838; schooldocs-examples.tex:184 | `page.setlength` | `\headheight`=`\baselineskip`; classic adds one `\baselineskip`; sample subtracts one |
| named page styles (classic, elegant, modern, soft, exam, collection, identity) | schooldocs.dtx:836-865, 867-877, 879-917, 919-955, 957-961, 968-1018, 1020-1058; sample :17, :170, :185, :200, :213, :227, :255, :269 | `hf.fancyhdr`, `exam.schooldocs` | `\fancypagestyle{name}` with `\lhead` `\chead` `\rhead` `\lfoot` `\cfoot` `\rfoot`; selected by `\pagestyle{name}` / `\thispagestyle{identity}`; first-page vs other-page content chosen with `\ifthenelse{\thepage=1}` |
| kernel page style | schooldocs-examples.tex:95, :320 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| header/footer parameters | schooldocs.dtx:744-757; sample :96-98, :199, :276-278, :287 | `hf.fancyhdr`, `exam.schooldocs` | colour headingcolor=black; `\headstyle`=`\small\color{headingcolor}`, `\footstyle` same; `\headtitlestyle`, `\headsubjectstyle`, `\schoolstyle`=`\scshape`; `\headdatestyle`, `\authorstyle`, `\pagenamestyle`=`\textnormal`; `\headrulewidth` 0.4pt/0pt; sample empties `\lfoot` `\cfoot` `\rfoot` or sets `\cfoot{\thepage}` |
| header rule never on page 1 | schooldocs.dtx:754-757 | `hf.fancyhdr`, `sp.rule` | `\headrule` redefined: rule of width `\headrulewidth` unless `\thepage=1` |
| running head from section | schooldocs.dtx:1021-1027 | `hf.fancyhdr` | collection style: `\sectionmark` -> `\markboth{#1}{}`, right head `\leftmark` |
| page X of Y | schooldocs.dtx:605, 843, 873, 886, 982 | `pgnum.lastpage` | `totpages`, `\thepage/\pageref{TotPages}`; sample :326 sets page=2 "for the lastpage field" |
| page counter resets | schooldocs-examples.tex:169, 182, 224, 252 | `pgnum.pagenumbering` | `\setcounter{page}{1}` |
| section counter reset | schooldocs-examples.tex:183, 197, 225 | `num.counters` | `\setcounter{section}{0}` |
| page break | schooldocs-examples.tex:90, 114 and each example; dtx:777 | `pg.break` | `\newpage` |
| title information fields | schooldocs.dtx:675-704, 970; sample :18-22, :108 | `exam.schooldocs`, `front.maketitle` | `\title[head]{title}`, `\subject[head]{subject}`, `\school{..}` (alias `\institute`), `\author`, `\date`, `\subtitle{..}` (exam style only); empty fields shrink the title |
| title block (standard, also classic/elegant/modern/soft variants) | schooldocs.dtx:775-791, 845-853, 892-905, 935-943; sample :111, :120 | `exam.schooldocs` | `\maketitle[rulelength]` default `\seprulelength`=2.5cm; `\titletopskip` -1.32cm (-0.67cm classic/soft); `\titlesep`=2\medskipamount; `\titlebottomskip`=\medskipamount; `\seprulewidth`=0.3pt; colour titlecolor=black; `\titlestyle`=`\LARGE\bfseries`; `\subjectstyle`=`\large`; `\datestyle`=`\large` |
| title block (exam, collection) | schooldocs.dtx:983-1017, 1031-1057; sample :231, :259 | `exam.schooldocs` | `\titletopskip`=0.67cm; `\titlesep`=2\bigskipamount; `\titlestyle`=`\LARGE\MakeUppercase`; `\subjectstyle`=`\Large\bfseries`; exam adds `\subtitlestyle`=`\large\slshape`, `\titlecorrectstyle`=`\color{red}\large\scshape`; collection `\authorstyle`=`\datestyle`=`\Large`, authors in `tabular[t]{c}`, `\thispagestyle{empty}` on title page |
| title alignment | schooldocs.dtx:722, 778; sample :118, :126, :134 | `exam.schooldocs` | `\titleflush` = center, flushleft or flushright (names the environment) |
| small one-line title | schooldocs.dtx:794-806; sample :162, :294, :305 | `exam.schooldocs` | `\makesmalltitle`; `\smalltitletopskip`=-1.32cm; `\smalltitledatestyle`=`\large\slshape`; full-width rule |
| boxed title | schooldocs.dtx:730-735; sample :142 | `box.fancybox`, `exam.schooldocs` | `\boxedshape` = `\shadowbox` with `\fboxsep`=4.5pt, `\shadowsize`=3pt, used inside `\titlestyle` |
| correct-version marker | schooldocs.dtx:808-818, 991-1000; sample :152, :242 | `exam.schooldocs` | `\correct` appends " -- Correct version" to title and head title (exam style: sets the subtitle instead) |
| separator rule | schooldocs.dtx:822-823; sample :52, :154 | `sp.rule`, `exam.schooldocs` | `\seprule[length]`: centred `\rule{len}{\seprulewidth}` raised 0.25\baselineskip |
| keyword translations (page, Correct version, Name:) | schooldocs.dtx:608, 622-652 | `lang.babel`, `exam.schooldocs` | `translations` package; `\DeclareTranslation` for english, french, german, spanish, italian, portuges; `\pagename` `\correctname` `\identityname`; reduction: `\addto\captions<lang>` strings |
| language | schooldocs-examples.tex:6 | `lang.babel` | english |
| PDF metadata | schooldocs.dtx:677-701; sample :24 | `meta.hyperref` | `\hypersetup{pdftitle,pdfsubject,pdfauthor={author (school)}}` written by the package in the preamble; sample `colorlinks, linkcolor=blue` |
| link targets and links | schooldocs-examples.tex:62-86, 91, 115 | `xref.hyperref` | `\hypertarget{..}{}`, `\hyperlink{..}{..}` |
| toc entries by hand | schooldocs-examples.tex:92, 116 | `toc.kernel` | `\addcontentsline{toc}{section}{..}` |
| input and font encoding | schooldocs-examples.tex:4-5 | `font.fontenc-t1` | inputenc utf8, fontenc T1 |
| text fonts | schooldocs-examples.tex:7 | `font.mathptmx`, `font.lmodern`, `font.charter` | `times`, `lmodern`, `charter` (charter loaded last) |
| per-example family switch | schooldocs-examples.tex:94, 159, 168, 226, 254 | `font.family-default` | `\fontfamily{lmr}`, `{bch}`, `{ptm}` then `\selectfont` (nearest home: NFSS family selection) |
| sizes and shapes in styles | schooldocs.dtx:718-720, 745-752; sample :23, :102-103, :285-286 | `font.size-commands`, `mark.kernel` | `\Huge` `\LARGE` `\Large` `\large` `\small`; `\bfseries` `\sffamily` `\scshape` `\slshape` `\MakeUppercase` |
| colours | schooldocs.dtx:607, 717, 744; sample :15, :54 | `color.xcolor` | `\definecolor{darkbrown}{rgb}{0.5,0.1,0.1}`; titlecolor and headingcolor named black; `\color{red}` |
| manual spacing | schooldocs.dtx:777, 786, 790; sample :38, :42, :58 | `sp.manual-space` | `\vspace`, `\mbox{}`, `\raisebox`, `\medskip` `\smallskip` `\bigskip` |
| section heads in demos | schooldocs-examples.tex:174, 176 | `head.kernel` | `\section*{..}` article default look |
| contents list by hand | schooldocs-examples.tex:54-56, 60-88 | `list.enumerate-pkg`, `cols.multicol`, `sp.ragged` | `enumerate` with label `[\bfseries 1.]`; `multicols{2}`; `center` with `\Large\color{darkbrown}\bfseries` heading |
| centred code line | schooldocs-examples.tex:11, 43 | `sp.ragged` | `centeredline` package (CTAN, TeX Live per ctan.org/pkg/centeredline): `\centeredline{\verb|..|}` (nearest home: centring) |
| inline code | schooldocs-examples.tex:35, 43 | `code.verbatim`, `mark.kernel` | `\verb`, `\texttt`, `\textbackslash`, `\textbf`, `\textsf` |
| doc driver: class | schooldocs.dtx:29 | `class.ltxdoc` | `\DocInput`, `\PrintChanges`, `\PrintIndex` |
| doc driver: section colour | schooldocs.dtx:36, 51 | `head.sectsty` | `\allsectionsfont{\color{darkbrown}}` |
| doc driver: preview boxes | schooldocs.dtx:35, 46-49 | `box.minipage`, `box.fancybox` | `boxedminipage` (boxedminipage2e) in `stylex`: width `\mpwd`=5.25cm, height 1.3\mpwd, `\tiny`, `\fboxsep`=13pt |
| doc driver: geometry | schooldocs.dtx:42 | `page.geometry` | textwidth=355pt, textheight=600pt, vmarginratio=1:1, hmarginratio=3:2 |
| doc driver: links and metadata | schooldocs.dtx:39, 66-73 | `meta.hyperref` | `hypdoc`, `colorlinks`, `linkcolor=red`, `filecolor=blue`, pdftitle/pdfsubject/pdfauthor |

## Bespoke code
The package is published, so its code is not bespoke by W1; each item is still listed with its reduction, so the verdict does not rest on accepting `exam.schooldocs`.
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| info macros `\title[..]`, `\subject[..]`, `\school`, `\institute`, `\@onlypreamble` test | schooldocs.dtx:675-704 | yes | strings plus `\hypersetup{pdftitle,pdfsubject,pdfauthor}` (`meta.hyperref`); short head title is a string in `\lhead` |
| per-style `\maketitle` redefinitions, `\schooldocstitles` | schooldocs.dtx:775-791, 845-853, 892-905, 935-943, 1001-1017, 1037-1057 | yes | `center`/`flushleft` environment, `sp.manual-space`, `sp.rule`, `font.size-commands`, `color.xcolor`; the "field is empty" tests are resolved by the emitter, which knows which fields it prints |
| `\makesmalltitle` | schooldocs.dtx:794-806 | yes | `\hfill` between title and subject, then full-width `\rule` (`sp.manual-space`, `sp.rule`) |
| `\correct`, exam `\subtitle` | schooldocs.dtx:808-818, 969-971, 991-1000 | yes | the emitter writes the title string with the translated word appended |
| page styles with `\ifthenelse{\thepage=1}` | schooldocs.dtx:839-843, 869-876, 880-891, 920-933, 972-982 | yes | `hf.fancyhdr` content; the page-1 test only selects which header text prints (kernel `\ifnum\value{page}=1`, or a separate style via `\thispagestyle`); no layout algorithm |
| `\headrule` redefinition | schooldocs.dtx:754-757 | yes | documented fancyhdr hook, `sp.rule` |
| `\sectionmark` redefinition via `\AtBeginDocument` | schooldocs.dtx:1022-1027 | yes | kernel `\markboth` feeding fancyhdr `\leftmark` |
| translations and `\pagename` `\correctname` `\identityname` | schooldocs.dtx:608, 622-652 | yes | `lang.babel` caption strings per language, or one fixed string |
| `\boxedshape` | schooldocs.dtx:730-735 | yes | `box.fancybox` `\shadowbox`, `\fboxsep`, `\shadowsize` |
| `\seprule` | schooldocs.dtx:822-823 | yes | `sp.rule` inside `center` with `\raisebox` (`sp.manual-space`) |
| `\@ifpackageloaded{geometry}` guard, `\let\footruleskip\relax` | schooldocs.dtx:601-602 | yes | load-order and memoir-compatibility guards, no look; emitter loads geometry once |
| `stylex` environment, `\mpwd`, `\bs` (documentation only) | schooldocs.dtx:45-49 | yes | `box.minipage` with `\tiny` and a length; manual only, not template look |
| sample's own definitions | schooldocs-examples.tex:15 | yes | one `\definecolor` (`color.xcolor`) |

## Content-opaque
- `\lipsum` filler text throughout schooldocs-examples.tex (:112, :121, :174-177 and others): content.
- Documentation-only helpers in the dtx driver: `metalogo` logo macros, `spacingtricks` `\centered` inside the miniature page previews (schooldocs.dtx:37, 40, 303-418): the previews are a diagram of the styles, not template look.
- No TikZ, PGF, PSTricks or `picture` drawing anywhere in the zip; the previews are boxes, rules and text.

## Lib changes
- New ways proposed: `exam.schooldocs` (section: doc-kind specific). Package `schooldocs` (CTAN, LPPL 1.3, v1.6), pdfLaTeX; named header/footer page styles `classic` `elegant` `modern` `soft` `exam` `collection` `identity` over `fancyhdr`, a redefined `\maketitle` (plus `\makesmalltitle`, `\seprule`, `\correct`, `\subtitle`) and a default page geometry. W1: on CTAN (ctan.org/pkg/schooldocs read; origin URL is a CTAN contrib path). W2: the style is a name given to `\pagestyle`; the look is tuned by lengths (`\titletopskip` `\smalltitletopskip` `\titlesep` `\titlebottomskip` `\seprulewidth` `\seprulelength`), colours (`titlecolor`, `headingcolor`), font-switch lists in the style macros (`\titlestyle` `\subjectstyle` `\datestyle` `\headstyle` `\footstyle` and the rest) and the string `\titleflush`; the manual calls these parameters (schooldocs.dtx:462-464). The one edge: style macros are changed with `\renewcommand`, but their value is only a list of font switches, as with KOMA `\setkomafont`. W3: serves a kind of component (title block plus header/footer set for exercise sheets, exams and course notes), not one document. W4: preamble `\usepackage{schooldocs}`, `\pagestyle`, info fields, parameter lines; body `\maketitle[len]`, `\makesmalltitle`, `\seprule[len]`, `\correct`, `\subtitle`, `\thispagestyle{identity}`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Nearest-home mappings, chosen to avoid new ways: `\fontfamily{..}\selectfont` -> `font.family-default` (same NFSS family mechanism); `\centeredline` -> `sp.ragged`; `\hyperlink`/`\hypertarget` -> `xref.hyperref`; `\headheight` -> `page.setlength`.
- schooldocs.sty is absent from the zip (docstrip output); the code analysed is the unprefixed part of schooldocs.dtx (lines 600-1072), which is what the .ins generates (schooldocs.ins:38).
- No text addressed to an AI was found in the zip.
