yes

# 0516-dithesis: dithesis (University of Athens, DIT undergraduate thesis class)

- Unverified: read from the source, not compiled.
- Source: Source/0516-dithesis/ (origin: https://mirrors.ctan.org/macros/latex/contrib/dithesis.zip; licence: lppl1.3)
- Kind: thesis
- Lib: v5
- Engine: needs XeLaTeX (the sample loads `mathspec`, `xgreek`, `xunicode` and sets Arial with `\setallmainfonts`, sample.tex:47-53; the class alone is pdfLaTeX-compatible, README:21-22)
- Look carried by: class (dithesis.cls defines page, headers, headings, contents lists, title and acceptance pages and the thesis environments; the sample preamble only adds Greek, the Arial font and the string fields)
- Class origin: ctan
- Main file: sample.tex (other samples: sampleNoArial.tex)
- Read: main yes, zip-local classes and styles all

## Verdict
The look is carried by `dithesis.cls`, which is a published CTAN class (ctan.org/pkg/dithesis: "A LaTeX class for undergraduate theses at the University of Athens", v0.2, LPPL 1.3), so it is one way, `class.dithesis`, and not bespoke code. The sample adds only string fields, `xgreek` language support and an Arial font through `mathspec`, all published and declarative. As an extra check the class was also unfolded: every part it implements reduces to lib ways with parameters (titling hooks, titlesec, tocloft, fancyhdr, geometry, kernel wrappers), with no output routine, no `\halign` and no external tool, and no `ART` (the only picture is the shipped raster logo, `athena.jpg`). One XeLaTeX-only engine tag and one missing-asset note (the Arial font) are recorded, neither is a blocker.

## Blockers
none

## Class setting
- Class: `class.dithesis` options: none. The class passes fixed `a4paper,titlepage,oneside,12pt` to `article` (dithesis.cls:62) and declares no `\DeclareOption`; it is configured by string commands.
- Class-native vocabulary used (as written in the sample):
  - front matter: `\thesistitle{}` (sample.tex:67), `\thesisauthor{name}{id}` (sample.tex:68), `\supervisor{name}{profession}` (sample.tex:69), `\maketitle` (sample.tex:70; prints a title page and an acceptance page, then `\setcounter{page}{3}`, dithesis.cls:586-587)
  - string fields set with `\renewcommand`: `\university` `\school` `\department` `\thesisplace` `\thesisdate` `\thesislabel` `\supervisorlabel` `\idlabel` (sample.tex:55-64; defaults dithesis.cls:142-149)
  - environments: `thesisabstract[title]` (sample.tex:72, 89), `thesisdedication` (sample.tex:106), `thesisacknowledgments[title]` (sample.tex:110), `thesisprologue[title]` (sample.tex:124), `thesisterminology[title]` (sample.tex:447), `thesisabbreviations[title]` (sample.tex:462), `thesisbibliography[title]{widest label}` (sample.tex:473)
  - keyword command `\thesiskeywords{SAlabel}{SA}{KWlabel}{kw}x5` inside the abstract (sample.tex:81-86, 98-103; dithesis.cls:122-132)
  - sectioning `\thesissection` `\thesissubsection` `\thesissubsubsection` and starred forms (sample.tex:134, 163, 165; dithesis.cls:75-117)
  - wrapped contents lists `\tableofcontents` `\listoffigures` `\listoftables` (sample.tex:120-122; dithesis.cls:416-422, 448-454, 468-474); access commands `\thethesistitle` `\thethesisauthor` (dithesis.cls:70, 180)

## Component map
Rows marked "(inside class)" are what the class loads or sets itself; the sample never touches them, so they are evidence for the unfolding check and for the class dimension, not extra template code.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | sample.tex:45 | `class.dithesis` | no options; string fields (see Class setting) |
| base class (inside class) | dithesis.cls:62 | `class.article` | a4paper, titlepage, oneside, 12pt |
| paper and size (inside class) | dithesis.cls:62 | `page.class-options` | a4paper, 12pt, oneside |
| page geometry (inside class) | dithesis.cls:310-313 | `page.geometry` | a4paper, top/bottom/left/right=2cm, bindingoffset=0.5cm, head=14pt, headsep=0.50cm, foot=0.75cm |
| paragraph skip (inside class) | dithesis.cls:321, 326-327 | `sp.parskip-pkg`, `sp.lengths` | parskip package; \parindent=0pt, \parskip=6pt |
| line spacing (inside class) | dithesis.cls:322, 505-557 | `sp.setspace` | onehalfspacing; `singlespace` environment on the title page |
| running head and foot (inside class) | dithesis.cls:364-376 | `hf.fancyhdr` | head L = \thethesistitle 8pt/9.6pt; foot L = authors 8pt, foot R = \thepage 10pt/12pt; C and R head empty; \headrulewidth=0pt |
| page style switching (inside class) | dithesis.cls:233, 240, 255, 417-421, 568 | `hf.pagestyle-kernel` | `\pagestyle{empty}` on front-matter pages and `\pagestyle{fancy}` after `\clearpage`; `\thispagestyle{empty}` on the acceptance page |
| page counter after title pages | dithesis.cls:587 | `pgnum.pagenumbering` | `\setcounter{page}{3}` after `\maketitle` |
| page and column breaks | dithesis.cls:80, 86, 232, 269, 417-420 | `pg.break` | `\newpage` and `\clearpage` around front-matter pages and sections |
| title page and acceptance page | dithesis.cls:492-587 | `front.titling` | \droptitle=-204pt; \maketitlehooka..d hold the cover blocks; \pretitle 16pt/19.2pt bold; \preauthor, \postauthor 12pt bold; \predate bold uppercase |
| title and acceptance page filler (inside class) | dithesis.cls:503-584 | `sp.manual-space`, `font.size-commands`, `mark.kernel`, `mark.case`, `sp.ragged` | `\vspace*` 0.08in, 0.82in, 0.25in, 0.43in, 1.49in, 1.34in, 0.56in, 0.36in, 2.76in; 12pt/14.4pt and 14pt/16.8pt; `\bfseries`; `\MakeUppercase`; `center` environment |
| university logo | dithesis.cls:506 (guard 496-499) | `fig.graphicx` | `\includegraphics[height=2cm]{athena.jpg}`; the image ships in the zip |
| title and author fields | dithesis.cls:70, 158-195 | `front.class-native` | `\thesistitle`, `\thesisauthor{name}{id}`, `\supervisor{name}{profession}`; several authors and supervisors by repeating the command |
| supervisor block | dithesis.cls:198-214 | `tbl.tabular` | `table*[!h]`, `\centering`, `tabular{l l}`, bold label |
| abstract (two languages) | sample.tex:72-104; dithesis.cls:231-236 | `abs.class-native` | `thesisabstract[title]`: `\newpage`, empty page style, `\section*{title}`, `\vspace*{0.3in}`, `\clearpage` |
| keywords | sample.tex:81-86; dithesis.cls:122-132 | `abs.keywords`, `tbl.tabularx` | `\vfill`, two `tabularx{\textwidth}{l X}` rows, label bold uppercase, keywords lowercased |
| dedication | sample.tex:106-108; dithesis.cls:238-244 | `front.dedication` | `\vspace*{3.5in}`, `flushright`, 12pt/14.4pt italic |
| acknowledgements | sample.tex:110-118; dithesis.cls:246-251 | `front.dedication` | `\section*{title}`, empty page style, default title "Acknowledgements" |
| prologue | sample.tex:124-132; dithesis.cls:253-256 | `front.class-native` | `\thesissection*{title}` (toc entry, uppercase) then empty page style |
| terminology and abbreviations sections | sample.tex:447-471; dithesis.cls:258-264 | `front.class-native` | each is `\thesissection*{title}` |
| contents lists | sample.tex:120-122; dithesis.cls:415-422, 447-454, 467-474 | `toc.kernel` | `\tableofcontents` `\listoffigures` `\listoftables`, each wrapped in `\newpage`, empty style, `\clearpage`, fancy style |
| contents list look (inside class) | dithesis.cls:411-412, 425-444 | `toc.tocloft`, `toc.titletoc` | package options `subfigure,titles`; \cftsecleader and \cftsubsecleader = bold dot fill; \cftsecaftersnum="."; \cftsecfont 12pt bold; \cftsubsecfont 10pt bold; \cftsubsubsecfont 10pt; \cftsubsecindent=0pt; \cftsecnumwidth + width of "9" |
| list of figures and tables look (inside class) | dithesis.cls:457-464, 476-484 | `toc.tocloft` | \cftfigpresnum=\figurename\enspace, \cftfigaftersnum=":", \cftfignumwidth += width of label; same for tables; \cftfigfont and \cfttabfont 12pt/14.4pt; \cftbeforefigskip=\cftbeforesecskip (line 484 sets figures again, the table skip keeps its default) |
| section headings | dithesis.cls:384-391 | `head.titlesec` | \section: block, 14pt/16.8pt, centering, bold, label "\thesection . ", sep 0pt, title via \MakeUppercase, spacing 0pt 0pt 0pt |
| subsection and subsubsection headings | dithesis.cls:394-403 | `head.titlesec` | 12pt/14.4pt, \raggedright, bold, label "\thesubsection\quad", spacing before 12pt |
| section commands | sample.tex:134, 155, 163, 165; dithesis.cls:75-117 | `head.class-native`, `head.kernel`, `meta.hyperref` | `\thesissection` = `\newpage` + `\section[uppercase]{}`; starred = `\phantomsection`, `\addcontentsline`, `\section*{}` with `\texorpdfstring` |
| heading case | dithesis.cls:82, 87, 390, 125, 129 | `mark.case` | `\MakeUppercase`, `\MakeLowercase` |
| section numbering | dithesis.cls:62 (article default) | `num.secnumdepth` | article defaults (no change) |
| captions (inside class) | dithesis.cls:295-302 | `cap.caption` | justification=centering, labelsep=colon, figureposition=bottom, tableposition=top; \captionfont 10pt/12pt bold |
| figures and subfigures (inside class) | dithesis.cls:292-294 | `fig.graphicx`, `fig.float`, `fig.subcaption` | graphicx; float; `subfig[caption=false]`; the sample has no float, so the lists are empty |
| tables in sample | sample.tex:450-458, 465-469 | `tbl.tabularx` | `tabularx{\textwidth}{\|X\|X\|}` with `\hline` rows (cells are content) |
| bibliography environment | sample.tex:473-490; dithesis.cls:267-275 | `bib.thebibliography` | `thesisbibliography[title]{99}` wraps `thebibliography{99}`; toc entry; entries 10pt/12pt |
| bibliography list spacing (inside class) | dithesis.cls:337-354 | `bib.thebibliography`, `sp.lengths`, `sp.penalties`, `sp.hyphenat` | \itemsep=0, \parsep=0, \clubpenalty=4000, \widowpenalty=4000, `\sloppy`, \leftmargin from the widest label |
| citations | sample.tex:141, 423, 430 | `bib.thebibliography` | `\cite{key}` to `\bibitem` |
| links | dithesis.cls:283; sample.tex:478, 484, 488 | `meta.hyperref`, `meta.url` | `hyperref` with no options; `\url{}` |
| lists | sample.tex:169, 208, 246, 433 | `list.kernel` | `description` and `enumerate`, default look |
| inline marks | sample.tex:128, 210; dithesis.cls:125, 243 | `mark.kernel` | `\emph`, `\textit` in the sample; `\textbf`, `\bfseries`, `\itshape` in the class |
| language (Greek) | sample.tex:48 | `lang.polyglossia` | `xgreek` (CTAN, Greek for XeLaTeX and LuaLaTeX), monotonic default, no options |
| fonts | sample.tex:47, 51-53 | `font.fontspec` | `mathspec` (CTAN, fontspec backend) with `\setallmainfonts`, `\setallsansfonts`, `\setallmonofonts` `[Mapping=tex-text]{Arial}`; Arial is not shipped |
| text encoding | sample.tex:49 | `font.fontenc-t1` | `xunicode` load-only (the XeTeX counterpart of the text-symbol and accent handling) |
| second font set (sampleNoArial) | sampleNoArial.tex:47-52 | `font.fontspec`, `font.fontenc-t1`, `lang.polyglossia` | `fontspec[cm-default]`, `xunicode`, `xltxtra`, `xgreek`, `\setmainfont[Mapping=tex-text]{CMU Serif}` |
| unused in the sample | sample.tex (no matches for label, ref, footnote, figure, table float, equation, theorem, code, index) | none | footnotes, maths, theorems, code, index, floats are absent |

## Bespoke code
All items sit inside `dithesis.cls`, which is published on CTAN (W1), so none is zip-local bespoke. Each was also checked for reducibility by unfolding.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\thesisauthor` and `\supervisor` accumulators (`\g@addto@macro`, `\ifthenelse{\isundefined}`) | dithesis.cls:158-195 | yes (class) | string joining only; an emitter writes the author lines (separator `\\`) and supervisor rows straight into the `front.titling` hooks and the `tbl.tabular` block |
| `\preauthor{\author{..}}`, `\predate{\date{..}}` set the field at `\maketitle` time | dithesis.cls:539-544, 560-564 | yes (class) | `front.titling` `\preauthor` `\postauthor` `\predate` `\postdate` hooks with the known text inline |
| `\maketitle` wrapper `\let\oldmaketitle` plus `\setcounter{page}{3}` | dithesis.cls:586-587 | yes (class) | `\maketitle` then `\setcounter{page}{3}` (`pgnum.pagenumbering`) |
| contents list wrappers (`\let\old..`, `\DeclareRobustCommand`) | dithesis.cls:415-422, 447-454, 467-474 | yes (class) | body lines `\newpage \pagestyle{empty} \tableofcontents \clearpage \pagestyle{fancy}` |
| `\thesissection` family with `\@ifstar` dispatch | dithesis.cls:75-117 | yes (class) | emit `\newpage \section[..]{..}` or `\phantomsection \addcontentsline{..} \section*{..}` directly |
| `thebibliography` redefinition (copy of bibspacing.sty), includes `\sfcode`\.\@m` | dithesis.cls:334-355 | yes (class), one caveat | list parameters (`sp.lengths`, `sp.penalties`, `sp.hyphenat`); the raw `\sfcode` assignment has no lib way (`sp.frenchspacing` is a wider switch), considered, not proposed, since the class loads whole as `class.dithesis` |
| computed lengths (`\settowidth`, `\addtolength`) for contents numbers | dithesis.cls:442-444, 456-460, 476-480 | yes (class) | `sp.lengths` assignments with the measured text inline |
| `\IfFileExists{athena.jpg}` guard with `\ClassError` | dithesis.cls:496-499 | yes (class) | ship `athena.jpg`; the guard prints nothing |
| `thesiskeywords`, `thesis*` environments | dithesis.cls:122-132, 231-275 | yes (class) | rows above (`abs.keywords`, `front.dedication`, `abs.class-native`) |
| sample `\renewcommand` of eight string fields | sample.tex:55-64 | yes (preamble) | class-native string parameters of `class.dithesis` (names and values in the Class setting) |
| sample font and language lines | sample.tex:47-53 | yes (preamble) | `font.fontspec`, `font.fontenc-t1`, `lang.polyglossia` |

## Content-opaque
none (`athena.jpg` is an included raster logo, an asset to ship, not drawn artwork, dithesis.cls:506; Arial is a system font the zip does not ship)

## Lib changes
- New ways proposed: none. Considered and folded into existing ways: `mathspec` into `font.fontspec` (a fontspec-backed font-selection package, `\setallmainfonts` is the main-font setter with a font name and options), `xunicode` into `font.fontenc-t1` (a text-encoding package), `xgreek` into `lang.polyglossia` (language-specific XeLaTeX package, as `xepersian`); `xltxtra` (sampleNoArial.tex:49, load-only XeTeX extras) is left unmapped.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- CTAN pages read: `dithesis` (the class is published), `mathspec` (XeLaTeX, fontspec backend, LPPL 1.3c), `xgreek` (XeLaTeX and LuaLaTeX, LPPL 1.3c). `sampleNoArial.tex` was read only through its preamble (lines 38-77); its body follows `sample.tex`.
