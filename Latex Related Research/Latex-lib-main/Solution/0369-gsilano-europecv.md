no

# 0369-gsilano-europecv: europecv, an unofficial LaTeX class for European curricula vitae (Europass CV)

- Unverified: read from the source, not compiled.
- Source: Source/0369-gsilano-europecv/ (origin: https://codeload.github.com/gsilano/EuropeCV/zip/refs/heads/master; licence: LPPL-1.3c)
- Kind: cv
- Lib: v3
- Engine: pdfLaTeX-compatible (europecv.tex:1 `TS-program = pdflatex`; the manual says pdfLaTeX, XeLaTeX and LuaLaTeX all work, europecv.tex:843; only examples/maltese-utf8.tex:1,7 is XeLaTeX; the biber template needs a biber run, templates/cv_template_en_biber.tex:3-7)
- Look carried by: class (the CV page is the `europecv` environment of europecv.cls; the main sample adds only content, option settings and manual-style headings; the one irreducible item is in a secondary template)
- Class origin: ctan (europecv.cls:24 names https://ctan.org/pkg/europecv; one ctan.org/pkg/europecv read confirmed a CTAN class, LPPL 1.3c, in TeX Live; the zip is also the maintainer's own repository, README.md:23-24 and :43-44)
- Main file: europecv.tex (the manual, typeset with the class; other samples: examples/europass-cv.tex, examples/minimal.tex, examples/greek-utf8.tex, examples/bulgarian-koi8-r.tex, examples/bulgarian-utf8.tex, examples/maltese-utf8.tex, examples/maltese-maltese.tex, templates/cv_template_en.tex, templates/cv_template_academic_en.tex, templates/cv_template_en_biber.tex)
- Read: main yes (all 1019 lines), zip-local classes and styles all (europecv.cls all 725 lines; ecven.def, ecvmt.def, ecvhu.def in full; the other 24 ecv*.def files by a grep of every line that is not a `\def\ecv@...key` translation string; all 10 other samples in full; templates/europecv_biber.tex and .conf in full)

## Verdict
The look is carried by the published CTAN class `europecv` (`class.europecv`), and the main sample europecv.tex reduces completely to that class plus kernel, babel, geometry, hyperref and booktabs ways; its own macros (`\setword`, `\ecv`, a body copy of the class's booktabs language-table code) are small and reducible. The answer is `no` because the shipped template templates/cv_template_en_biber.tex loads a zip-local helper, templates/europecv_biber.tex, that overrides biblatex internals (`\blx@bibitem`) and wraps `\printbibliography` to collect entries in a global token list for a `longtable` row; that is hand-rolled bibliography-driver logic with no lib way. Read with the main sample only, the zip would be `yes`; the blocker is tagged `preamble` so that reading can be redone.

## Blockers
- `BESPOKE/preamble` zip-local biblatex-internals override: `\def\blx@bibitem`, `\blx@getdata`, global `\gdef` list `\ecv@blx@table`, `\renewcommand\printbibliography` (templates/europecv_biber.tex:7-32), loaded by templates/cv_template_en_biber.tex:15; secondary sample only, the main sample has no typeset bibliography (europecv.tex:769-831 shows it as verbatim text).

## Class setting
- Class: `class.europecv` options: `english` (default), `noflag` (default), `logo` (default) (europecv.cls:255); language options `italian` `spanish` `french` `danish` `german` `finnish` `portuguese` `swedish` `norwegian` `dutch` `catalan` `polish` `hungarian` `estonian` `icelandic` `lithuanian` `czech` `slovak` `latvian` `slovenian` `romanian` `maltese` `bulgarian` `greek` `galician` `serbian` (each loads ecv<xx>.def, europecv.cls:63-127); input-encoding options `latin1` `koi8-r` `cp1251` ... (136-177); font options `helvetica` `arial` `narrow` (182-193); `notitle` `nobranding` `nologo` `flagWB` `flagBW` `flagCMYK` `flagBlueCMYK` (199-233); `totpages` `booktabs` (238-248); every other option goes to `article` (250-253, `\LoadClass{article}` at 259). Used: main sample none (europecv.tex:3); templates/cv_template_en.tex:1 `totpages,helvetica,openbib,english,nologo,nobranding,notitle`; templates/cv_template_en_biber.tex:12 `totpages,openbib,english,flagCMYK,notitle,nobranding,booktabs`; examples/europass-cv.tex:2 `logo,flagCMYK,totpages,a4paper`.
- Class-native vocabulary used: environment `europecv` (cls:658-686); `\section[vspace]{title}` (cls:691-694) and alias `\ecvsection`; `\ecvitem[vspace]{left}{right}` and `\ecvitem*` (cls:720-725); personal data setters `\ecvname` `\ecvfootername` `\ecvaddress` `\ecvtelephone` `\ecvfax` `\ecvemail` `\ecvprofessional` `\ecvpec` `\ecvhomepage` `\ecvskype` `\ecvmatrixriot` `\ecvyoutube` `\ecvnationality` `\ecvdateofbirth` `\ecvgender` `\ecvdate` `\ecvpicture` `\ecvbeforepicture` `\ecvafterpicture` `\ecvspace` and `\ecvpersonalinfo[vspace]` (cls:382-533); spoken-language table `\ecvmothertongue` `\ecvlanguageheader` `\ecvlanguage` `\ecvlastlanguage` `\ecvlanguagefooter` `\ecvCEF` `\ecvAOne`..`\ecvCTwo` (cls:536-608); footer `\ecvfootnote` `\ecvpage` (cls:333, 343); layout lengths `\ecvLeftColumnWidth` `\ecvColSep` `\ecvRuleWidth` `\ecvExtraRowHeight` `\ecvNoHorRule` `\ecvWithHorRule` `\ecvFlagWidth` `\ecvLogoWidth` `\ecvLogoOffset` `\ecvTitleKern` (cls:610-651); numbered cross-references `\ecvNewReferenceType{Name}{prefix}`, `\ecvdisplay<Name>[key]`, `\ecvref<Name>[key]` for ConferencePublications, BookChapterPublications, ReferredJournalsPublications, Workshops, Posters, ResearchProjects, Awards, FootNoteCounter (cls:263-323); hooks `\draweuropasslogo` `\draweuropeflag` `\ecvbranding` `\ecvtitle` (ecven.def:43-48).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | europecv.tex:3; europecv.cls:259 | `class.europecv` | options as above; loads `article` (cls:259) |
| paper size by option | examples/europass-cv.tex:2 | `page.class-options` | `a4paper` (passed to article, cls:250-253) |
| page geometry | europecv.tex:10; templates/cv_template_en.tex:4; examples/europass-cv.tex:5 | `page.geometry` | manual: a4paper,left=2cm,right=2cm,top=2cm,bottom=3cm; templates: a4paper,top=1.27cm,left=1cm,right=1cm,bottom=2cm; example: a4paper,height=24.2truecm,width=17.5truecm |
| font encoding | europecv.tex:4; templates/cv_template_en.tex:2 | `font.fontenc-t1` | `[T1]`; the class itself loads `inputenc` for the encoding options (cls:136-146) |
| font family (text) | europecv.tex:5; templates/cv_template_en_biber.tex:28 | `font.lmodern` | load-only |
| font family via class options | europecv.cls:182-193 | `font.family-default` | `helvetica`: rmdefault=phv, sfdefault=phv; `narrow`: seriesdefault=c, bfdefault=bc; `arial`: rmdefault=ma1, sfdefault=ma1 (font not installed by default, cls:187) |
| local font switches in the manual | europecv.tex:130-131, 387-388, 855-872 | `font.nfss` | `\fontfamily{phv}\fontseries{mc}\selectfont`, `\renewcommand{\bfdefault}{bc}` |
| typewriter default | templates/cv_template_en.tex:9; templates/cv_template_en_biber.tex:47 | `font.family-default` | `\ttdefault` = phv, or = `\familydefault` |
| comma-below accent | europecv.tex:8, 214 | `font.icons` | `combelow` (`\cb s`), nearest home: a package whose command prints a glyph (considered: `font.fontenc-t1`) |
| language | europecv.tex:13, 64; examples/greek-utf8.tex:8; examples/maltese-utf8.tex:7-9 | `lang.babel` | `[english]`; `[greek,english]`; `\babelprovide[import,main]{maltese}` (XeLaTeX); the class's own language options are class parameters, not babel (europecv.tex:179) |
| graphics loading | europecv.tex:18-22; cls:346-348 | `fig.graphicx` | `[pdftex]` under `\ifpdf` (a driver choice; `ifpdf` is load-only engine detection, not a component) |
| inline images (flags, logo, picture) | europecv.tex:246-253; cls:211-232, 436-440 | `fig.graphicx` | `\includegraphics[width=10mm]{...}`; the class draws logo/flag/picture with it; images EuropeFlag*.{eps,pdf}, europasslogo.{eps,pdf}, examples/Pythagoras.jpg, templates/europecv_photo.jpg are assets to ship |
| hyperlinks | europecv.tex:26-31; templates/cv_template_en_biber.tex:35-39 | `meta.hyperref`, `meta.url` | `[pdftex,colorlinks]`; `url`; the class loads `hyperref` unconditionally (cls:352) |
| bookmarks | templates/cv_template_en.tex:7, 47 | `meta.bookmark` | `\pdfbookmark{..}{..}`, `\subpdfbookmark` (academic template:124) |
| title block | europecv.tex:45-59, 66 | `front.maketitle` | `\title` with `\\`, `\author` (two authors, `\href` mailto), `\date`, `\maketitle` (article's; the class does not redefine it, grep of cls) |
| abstract | europecv.tex:73-83 | `abs.kernel` | `abstract` environment |
| page style, manual | europecv.tex:68 | `hf.pagestyle-kernel` | `\pagestyle{plain}` after `\maketitle` |
| CV footer | cls:330, 357-366 | `hf.fancyhdr` | inside the class: empty head, foot L = minipage of left column width with flushright name line, foot R = `\ecvfootnote` text, `\headrulewidth`=0pt |
| footer text and page label | cls:333-340, 343-344; ecven.def:25-26 | `hf.class-native` | `\ecvpage{..}`, `\ecvfootnote{..}`, `\ecvfootername{..}`; keys "Page", "Curriculum vitae of" |
| total page count | cls:238-243 | `pgnum.lastpage` | option `totpages` (package `totpages`, `~/~\ref{TotPages}`) |
| manual headings (hand-set, not `\section`) | europecv.tex:91-93, 144, 281, 766, 838, 850, 885, 913, 927, 941 | `sp.manual-space`, `mark.kernel`, `font.size-commands` | `\vspace{0.25cm}\textbf{\large{N\hspace{0.5cm}Title}}\vspace{0.25cm}`, numbers typed by hand (the class's `\section` is the CV rule row, so the manual cannot use it) |
| appendix and subsection headings | europecv.tex:938, 946-947 | `num.appendix`, `head.kernel` | `\appendix`, `\subsection*`, `\subsubsection*` (article's) |
| CV section heading | cls:691-694; europecv.tex:157 | `head.class-native` | `\section[vspace=10pt]{title}`: `\large\textbf` title in the left cell, empty right cell, `\nopagebreak` |
| CV entry row | cls:720-725; europecv.tex:158-161 | `cv.entries` | `\ecvitem[vspace=2pt]{left}{right}`; starred form prefixes `\ecvbullet` (cls:656) |
| two-column CV page | cls:658-686 | `tbl.longtable` | inside the class: `longtable` with columns `>{\raggedleft}p{leftcolwidth}` `|` `p{rightcolwidth}`, `\LTleft`=`\LTright`=0pt, loads `array` and `longtable` (cls:328-329); the emitter only needs the `europecv` environment |
| CV layout lengths | cls:610-638; europecv.tex:591, 645, 722-725, 742-745 | `cv.entries` | `\ecvLeftColumnWidth{3.3cm|5cm|6cm}` (default 50mm), `\ecvColSep{12pt|20pt}`, `\ecvRuleWidth{0.4pt|2pt}`, `\ecvExtraRowHeight{0pt|10pt}`, `\ecvNoHorRule` / `\ecvWithHorRule` |
| rules between rows | europecv.tex:749, 751 | `tbl.longtable` | `\hline`, `\cline{2-2}` inside the environment |
| personal information block | cls:382-533; europecv.tex:369-392, 430-453; templates/cv_template_en.tex:18-32, 43 | `front.class-native` | setters above, `\ecvpersonalinfo[20pt]`, `\ecvpicture[height=3cm]{file}`, `\ecvbeforepicture{\raggedleft}`, `\ecvafterpicture{\ecvspace{-3.5cm}}`, `\ecvdate{\today}` |
| title banner, logo, flag | cls:199-233, 671-684; ecven.def:43-48 | `class.europecv` | options `notitle` `nobranding` `nologo` `flag*`; `\ecvFlagWidth{10mm}`, `\ecvLogoWidth{2.30cm}`, `\ecvLogoOffset{1cm}`, `\ecvTitleKern`; in the manual `\renewcommand*{\ecvtitle}{}` and `\renewcommand*{\draweuropasslogo}{}` (europecv.tex:153-154) do what `notitle` and `nologo` do |
| spoken-language table | cls:536-608; europecv.tex:583-600, 635-641; examples/europass-cv.tex:44-50 | `cv.entries` | `\ecvmothertongue[10pt]{..}`, `\ecvlanguageheader{(*)}`, `\ecvlanguage{L}{\ecvCOne}{..}x5`, `\ecvlastlanguage`, `\ecvlanguagefooter[10pt]{(*)}`; EU-model ruled `tabular` with `m{}` columns by default (cls:541-563) |
| booktabs language table | cls:245-248, 564-591; europecv.tex:7 | `tbl.booktabs` | class option `booktabs` (rows by `\toprule` `\midrule` `\bottomrule`; use `\ecvlastlanguage` for the last row, cls:583) |
| language-table cells | cls:541-608 | `tbl.tabular` | inside the class: `array` `m{}` columns, `\extrarowheight`, `\firsthline` |
| numbered cross-references (publications, projects, awards, talks) | cls:263-323; europecv.tex:42, 656, 660, 816-818, 826-828; templates/cv_template_academic_en.tex:164, 175 | `cv.entries`, `xref.hyperref` | `\ecvNewReferenceType{Talks}{T}` (preamble), `\ecvdisplay<Name>[key]` prints `[T1]` as a `\hypertarget`, `\ecvref<Name>[key]` prints the `\hyperlink`; two passes (aux `\ecv@setref`) |
| bullet marks | cls:378-380, 656 | `list.kernel` | `\labelitemi` = bold en dash, `\labelitemii` = asterisk-centred, `\labelitemiii` = period-centred |
| lists in the manual | europecv.tex:237-241, 480-486, 948-1016 | `list.kernel` | `itemize`, `description` |
| quote and verbatim in the manual | europecv.tex:115-123, 148-151, 333-364 | `quote.kernel`, `code.verbatim` | `quote` around `verbatim` |
| footnotes | europecv.tex:96, 103, 126, 703, 853; templates/cv_template_en.tex:62 | `fn.kernel` | `\footnote` (also inside the `europecv` longtable, europecv.tex:703) |
| labels and page references | europecv.tex:72, 89, 242, 487; 33-38 | `xref.kernel`, `xref.hyperref` | `\label`, `\ref`, `\pageref`; `\setword` is a labelled heading text with `\phantomsection` (hyperref) |
| thebibliography override | cls:700-718 | `bib.thebibliography` | the class redefines article's `thebibliography` without the heading; sloppy, `\clubpenalty`=`\widowpenalty`=4000 (`sp.penalties`) |
| bibliography by biblatex | templates/cv_template_en_biber.tex:14-26, 293-297; templates/europecv_biber.conf:3-21 | `bib.biblatex-biber` | `backend=biber,style=alphabetic,natbib=false,doi=true,sorting=ydnt,labelnumber,defernumbers=true`; `\addbibresource` x2, `\nocite{*}`, `\printbibliography[notkeyword=thesis,title=Journal]`, `[keyword=thesis,title=Thesis,resetnumbers]`, `\defbibheading` (europecv_biber.tex:36), `\renewbibmacro*{cite}`; biber run with `--configfile europecv_biber.conf` (sourcemap: URL dropped when DOI exists, KEYWORDS `thesis`/`pub` by datasource); the rows reach the table only through the bespoke helper (blocker) |
| bibliography by bibentry (loaded only) | examples/europass-cv.tex:4 | `bib.natbib` | `bibentry` (natbib bundle) loaded; its use is commented out (examples/europass-cv.tex:54-56) |
| date format | templates/cv_template_en_biber.tex:41-42 | `front.datetime` | `isodate` `[UKenglish]`, `\cleanlookdateon` |
| signature line | templates/cv_template_en.tex:11-15, 97 | `sp.rule`, `sp.manual-space` | `\makebox[2.5in]{..}`, `\hrulefill`, `\hfill`, `\hspace{2cm}`, `\vspace{5.0cm}` / `\vspace{-2.5cm}` (95-96) |
| raw row spacing | templates/cv_template_en_biber.tex:81-84, 86 | `sp.manual-space` | `\tabularnewline[-5.5em]`, `\tabularnewline[-2em]`, trailing `[20pt]` is the optional length of the row end of `\ecvitem` |
| load-only utility packages | templates/cv_template_academic_en.tex:8-10 | `list.scrextend` | `scrextend` loaded, never used; `pgfkeys` and `etoolbox` are programming helpers, no component (considered: none) |
| manual spacing in body | europecv.tex:90, 111, 128, 457-458, 722-745 | `sp.manual-space` | `\vspace`, `\medskip`, `\bigskip` |
| list of contributors, licence text | europecv.tex:888-932 | content | plain paragraphs |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\setword{text}{label}` | europecv.tex:33-38 | yes | kernel `\label` plus hyperref `\phantomsection`; `\def\@currentlabel{\unexpanded{..}}` makes the reference print the heading text (`xref.kernel`, `xref.hyperref`); used at europecv.tex:838, 941 |
| `\ecv{name}` | europecv.tex:40 | yes | alias for `\texttt{\textbackslash ecv#1}` (`mark.kernel`) |
| body re-definition of `\ecvlanguageheader`, `\ecvlanguage`, `\ecvlastlanguage` | europecv.tex:604-631 | yes | verbatim copy of the class's booktabs branch (cls:564-591); equal to the class option `booktabs` (`tbl.booktabs`) |
| `\renewcommand*{\ecvtitle}{}`, `\draweuropasslogo`, `\draweuropeflag`, `\ecvbranding` set to empty | europecv.tex:153-154; examples/europass-cv.tex:39-42 | yes | class options `notitle`, `nologo`, `noflag`, `nobranding` (cls:199-217) |
| `\SignatureAndDate{..}` | templates/cv_template_en.tex:11-15 (same at templates/cv_template_academic_en.tex:14-18) | yes | `\newcommand` over kernel `\makebox`, `\hrulefill`, `\hfill`, `\hspace`, `\today` (`sp.rule`, `sp.manual-space`) |
| `\let\copyeuropeflag\draweuropeflag` and empty `\draweuropeflag` | templates/cv_template_en_biber.tex:44-45 | yes | alias of a class macro so the flag prints beside the title in a hand-set row (cv_template_en_biber.tex:82); the row is `class.europecv` hooks plus `sp.manual-space` |
| `\renewbibmacro*{cite}` printing alpha label or `T<number>` by keyword | templates/cv_template_en_biber.tex:20-26 | yes, as a parameter of `bib.biblatex-biber` | biblatex's documented bibmacro hook with `\ifkeyword`; it only serves the helper below |
| biblatex-internals helper: `\ecv@blx@additemto`, `\blx@bibitem` override, `\printbibliography` wrapper | templates/europecv_biber.tex:4-33 | **no** | collects every bibliography entry as a `label & citation` table row in a global `\gdef` list by overriding biblatex's private `\blx@bibitem` and `\blx@getdata`, then prints the list inside the `europecv` longtable; no lib way holds this (`BESPOKE/preamble`) |
| class internals (not counted: the class is published, so its code is one way) | europecv.cls:40-55 `\ecv@utf` encoding switch; 269-303 `\ecv@settarget`, `\ecvNewReferenceType` (aux write, counters, `\csname` generators); 387-417 `\@ifnextchar` optional-argument parsers; 669-685 longtable with `\vskip` logo hack; ecvmt.def:9-18 `\ooalign` h-with-stroke | n/a | would be irreducible (`BESPOKE/class`) if `class.europecv` were not accepted as a published way (W2 holds: behaviour is chosen by options and lengths; checked at ctan.org/pkg/europecv) |

## Content-opaque
none that matters: inline flag and logo images (europecv.tex:246-253), personal pictures (examples/europass-cv.tex:24, templates/cv_template_en_biber.tex:72) and the Europass logo/flag files are included images, not drawn artwork; no TikZ, PGF or PSTricks anywhere (`ART`: none). Missing asset: font `ma1` for the `arial` option (europecv.cls:187), and `type1ec`/Cyrillic fonts for the Greek and Bulgarian examples (examples/greek-utf8.tex:7, examples/bulgarian-koi8-r.tex:6).

## Lib changes
- New ways proposed: none. Considered and not proposed: `ifpdf`, `etoolbox`, `pgfkeys` (load-only helpers, no component); `combelow` filed under `font.icons` (nearest glyph-printing package way).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
