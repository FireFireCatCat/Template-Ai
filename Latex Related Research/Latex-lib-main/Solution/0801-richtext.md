no

# 0801-richtext: richtext (rich text strings for PDF form fields, AcroTeX / D. P. Story)

- Unverified: read from the source, not compiled.
- Source: Source/0801-richtext/ (origin: https://mirrors.ctan.org/macros/latex/contrib/richtext.zip; licence: lppl1.2)
- Kind: misc (a package plus its manual; the manual is the sample)
- Lib: v6
- Engine: pdfLaTeX-compatible (the manual says the package works with dvips, pdflatex, xelatex and luatex, docs/richtextman.tex:194; the manual itself was built dvips->distiller, docs/richtextman.tex:1156-1157)
- Look carried by: mixed (kernel `article` plus layout commands of an AeB package that is not in the zip, plus preamble overrides; the package's own vocabulary is `richtext`)
- Class origin: tex-distribution-unbundled
- Main file: docs/richtextman.tex (other samples: examples/richtext_tst.tex, examples/caption-image.tex, driver of richtext.dtx at richtext.dtx:18-60)
- Read: main yes, zip-local classes and styles all (no .cls or .sty ships; richtext.dtx and richtext.ins read in full)

## Verdict
`no`. The package itself is clean: `richtext` is on CTAN (LPPL 1.2, read at ctan.org/pkg/richtext) and is key-value driven, so it is a new way `NEW:form.richtext` over `form.eforms`; the two small examples would reduce. The main sample (the manual) does not: it loads `aeb_pro`, `aeb_mlink`, `acroman` and `lucidbry`, none shipped and none shown to be published, and it uses about a dozen manual-writing macros that are defined nowhere in the zip. It also runs a JavaScript `docassembly` block that needs Acrobat Pro to add a watermark to the finished PDF.

## Blockers
- `EXTERNAL/preamble` `docassembly` environment: Acrobat JavaScript that opens a background PDF, saves a copy and calls `\addWatermarkFromFile` and `\executeSave`, so the printed look needs Acrobat Pro after TeX; the background PDFs are not shipped (docs/richtextman.tex:102-136; watermark call 130-135)
- `UNMAPPED/preamble` `aeb_pro` (options `web={...}`, `eforms`, `aebxmp`), `aeb_mlink`, `acroman`, `lucidbry`: absent from the zip, not read; W1 not established (ctan.org/pkg/aeb_pro answered HTTP 410; the CTAN acrotex page lists web, exerquiz, eforms, insdljs, dljslib and eq2db only). What the sample takes from them: `\DeclareDocInfo` and `\maketitle` content, the colour `\aeb@subsubsectioncolor`, `\mlurl`, `\backrefprint`, probably fancyvrb and xcolor (docs/richtextman.tex:4-10, 15, 21, 31, 63-76, 1189, 1196)
- `UNMAPPED/body` manual-writing macros used but defined in no file of the zip: `\cs`, `\darg`, `\env`, `\meta`, `\pkg`, `\newtopic`, `\bVerb`, `\eVerb`, `\takeMeasure`, `\bxSize`, the `dCmd` environment, `\mlurl` (docs/richtextman.tex:177, 238, 240-243, 1196; the only `\ameta` definition is richtext.dtx:32, for the dtx driver, not for this file). Their code cannot be read, so reducibility cannot be shown.

## Class setting
- Class: `class.article` options: `12pt` (docs/richtextman.tex:2)
- Class-native vocabulary used: `\maketitle` (140), `\tableofcontents` (143), `\section` `\subsection` `\subsubsection` `\paragraph` (171, 335, 341, 534), `figure` with `\caption` (231-236), `thebibliography` with `\bibitem` (1186-1214), `\footnote` (1157), `\cite` (183). No `abstract`, no `\appendix`.

## Component map
Main sample is docs/richtextman.tex; rows from other files name the path.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | docs/richtextman.tex:2 | `class.article` | 12pt |
| paper and size | docs/richtextman.tex:2 | `page.class-options` | 12pt only (no paper option) |
| screen-format page and layout commands | docs/richtextman.tex:4-9, 81-90, 142, 144 | `page.pdfscreen` | through `aeb_pro`: web options centertitlepage, designv, forcolorpaper, latextoc, pro, addtoHyOpts={pagebackref=false}; `\universityLayout{fontsize=Large}` `\titleLayout{fontsize=LARGE}` `\authorLayout{fontsize=Large}` `\tocLayout{fontsize=Large,color=aeb}` `\sectionLayout{indent=-62.5pt,fontsize=large,color=aeb}` `\subsectionLayout{indent=-31.25pt,color=aeb}` `\subsubsectionLayout{indent=0pt,color=aeb}` `\subsubDefaultDing{..}` `\widestNumber{0.00.}` `\selectColors{linkColor=black|webgreen}`; command names match the lib's `web` line, `web` source not read |
| title block | docs/richtextman.tex:63-76, 140 | `front.maketitle` | `\maketitle` after `\DeclareDocInfo{university,title,author,email,subject,talksite,version,keywords,copyright*}`; the `\DeclareDocInfo` fields are `aeb_pro` vocabulary (UNMAPPED) |
| contents list | docs/richtextman.tex:143, 151 | `toc.kernel` | `\tableofcontents`, then `\hypersetup{linktocpage}` |
| contents entry of `\paragraph` | docs/richtextman.tex:32 | `toc.tocloft` | reduction of `\@dottedtocline{4}{5.0em}{1em}`: `\cftparaindent`=5.0em, `\cftparanumwidth`=1em |
| heading depth | docs/richtextman.tex:24-25 | `num.secnumdepth` | secnumdepth=4, tocdepth=5 |
| headings, run-in paragraph level | docs/richtextman.tex:28-31, 171, 534 | `head.kernel` | `\renewcommand{\paragraph}` over `\@startsection{paragraph}{4}{0pt}{6pt}{-3pt}{\color{..}\bfseries}`; number printed as `\P` via `\renewcommand*{\theparagraph}` and `\@seccntformat` |
| hyperref settings | docs/richtextman.tex:5, 36, 151 | `meta.hyperref` | `linktocpage`, `pagebackref=false`, `\texorpdfstring` alias `\tops` |
| url face | docs/richtextman.tex:45 | `meta.url` | `\urlstyle{sf}` |
| colour | docs/richtextman.tex:51-57, 146-148 | `color.xcolor` | `\convertcolorspec{named}{red}{RGB}{..}` (red, blue, magenta; HTML for red, blue, magenta, webbrown); `\textcolor{blue}` |
| text face | docs/richtextman.tex:15 | UNMAPPED | `lucidbry[altbullet]` (Lucida Bright, commercial fonts, not shipped); would be `font.serif-pkg` only if W1 were shown, which it is not |
| symbol glyphs | docs/richtextman.tex:16, 283 | `font.icons` | `pifont`, `\ding{182}` |
| maths packages | docs/richtextman.tex:3, 78-79, 749-751 | `math.amsmath` | `fleqn`; `equation*`; `\mathfrak` and `\mathcal` in `\dps` (`math.amssymb` not visibly loaded) |
| equation flush left | docs/richtextman.tex:3 | `math.eqnumber` | `fleqn` |
| spacing and rules of text | docs/richtextman.tex:100 | `sp.frenchspacing` | `\frenchspacing` |
| lengths | docs/richtextman.tex:41, 49, 1190-1191 | `sp.lengths` | `\addtolength{\marginparwidth}{1in}`, `\amtIndent`=`\leftmargini`; calc-style `.5\linewidth-5pt-2\fboxrule` at 232-234 |
| manual spacing and boxes | docs/richtextman.tex:78-79, 283, 1177-1181 | `sp.manual-space` | `\kern`, `\rlap`, `\hskip3.5in`, `\makebox[\dpswebW]{\makebox[0pt][l]{..}..}` |
| flush and centre | docs/richtextman.tex:214, 327, 1176 | `sp.ragged` | `center`, `flushleft`, `\raggedleft` (in `\FmtMP`) |
| font switches | docs/richtextman.tex:46-48 | `mark.kernel` | `\let\uif\textsf`, `\let\app\textsf`, `\psf`=`\textbf{\textsf{..}}`, `\slshape` |
| lists | docs/richtextman.tex:59-60, 261-279, 537-570 | `list.kernel` | `description` with `\renewcommand*\descriptionlabel` (label in `\normalfont`), nested description, `itemize` |
| quotes | docs/richtextman.tex:495-499 | `quote.kernel` | `quote` |
| margin note | docs/richtextman.tex:40-41, 262 | `note.marginpar` | `\FmtMP[raise]{text}`: `\marginpar{\raisebox{..}{\parbox{\marginparwidth}{\slshape\raggedleft\small ..}}}` |
| minipage-like box | docs/richtextman.tex:40, 232-234 | `box.minipage` | `\parbox` |
| framed box | docs/richtextman.tex:231-234 | `box.fancybox` | `\fbox`, `\setlength{\fboxsep}{0pt}` |
| figure and caption | docs/richtextman.tex:231-236 | `fig.graphicx` | `figure[htb]`, `\includegraphics[width=\linewidth]` of 3 shipped-elsewhere images (not in the zip) |
| caption | docs/richtextman.tex:235 | `cap.kernel` | `\caption` |
| table packages | docs/richtextman.tex:12 | `tbl.tabular` | `array` loaded; no `tabular` is used in the body |
| footnote | docs/richtextman.tex:1157 | `fn.kernel` | `\footnote` |
| cross-references | docs/richtextman.tex:224, 245-246 | `xref.kernel` | `\label`, `\ref`, `\ref*` |
| hyperlinked references | docs/richtextman.tex:224, 229 | `xref.hyperref` | `\hyperref[fig:FPtabs]{Figure~\ref*{fig:FPtabs}}` |
| verbatim listings | docs/richtextman.tex:284-292, 276 | `code.verbatim` | `Verbatim[fontsize=\small,commandchars=!()]` (fancyvrb, loaded by an absent package), `\verb`, `\verb*` |
| bibliography | docs/richtextman.tex:1186-1214 | `bib.thebibliography` | 4 `\bibitem`; `\addcontentsline{toc}{section}{\protect\numberline{}References}` at 1187 |
| PDF form fields | docs/richtextman.tex:217-219, 1066-1068 | `form.eforms` | `\textField[\Ff{\FfRichText}\Ff{\FfMultiline}\DS{..}\RV{..}\V{..}]{name}{w}{h}`, e.g. `{rtFld\the\fldCnt}{4in}{10\baselineskip}`; `\Ff\FfDoNotSpellCheck` `\BC{}` `\BG{}` `\autoCenter{n}` at 1177-1178 |
| rich text strings | docs/richtextman.tex:202-212, 619-622, 954-956 | `NEW:form.richtext` | `\rtpara[indent=first,halign=right,valign=bottom,margleft=,margright=,margtop=,margbottom=,linespacing=,lineheight=,font=,size=]{name}{text with \span{style={bold,italic,strikeit},color=ff0000,ulstyle=2wul,url=..,raise=..,font=..,raw=..}{..} \it \bf \sub \sup \br \spc \cs}`; `\setDefaultStyle{myStyle}{font='Myriad Pro',size=10,color=..}`; `\setRVVContent{myContent}{{para1}{skipline}{para2}}`; `\DS{\useDS{..}}\RV{\useRVContent{..}}\V{\useVContent{..}}`; check env `displayRtPara` and `displayRtPara*` with `\displayRV` `\displayV` (321-326, 1146-1152) |
| dtx driver, class | richtext.dtx:19 | `class.ltxdoc` | no options; loads hyperref[colorlinks,hyperindex=false], calc, fancyvrb (richtext.dtx:20-22) |
| dtx driver, documentation | richtext.dtx:39, 52-58 | `dtx.doc` | `\EnableCrossrefs \CodelineIndex \RecordChanges`, `\DocInput{richtext.dtx}`, `\PrintIndex`, `\PrintChanges`; optional `aebdocfmt.def` via `\InputIfFileExists` (not shipped, fallback given at 40-42) |
| example preamble | examples/richtext_tst.tex:2-15 | `class.article` | `12pt`; xcolor; `\hypersetup{bookmarks=false,pdfpagemode=UseNone}` (`meta.hyperref`); `\parindent0pt \parskip6pt` (`sp.lengths`); same `form.eforms` and `NEW:form.richtext` calls at 21-59 |
| example, image caption | examples/caption-image.tex:4-30 | `page.pdfscreen` | `\usepackage[designv]{web}`, `\getDimsFromGraphic[width=\targetWd]{graphics/dpsweb}{\dpswebW}{\dpswebH}` (a `web` command), `\textField[\presets{\noEditing}\textSize{8}..]` overlay on `\includegraphics` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\paragraph` and `\theparagraph` redefinition | docs/richtextman.tex:28-31 | yes | `head.kernel` renewcommand as written, or `head.titlesec` `\titleformat{\paragraph}[runin]{\color{..}\bfseries}{\P\ }{0pt}{}` with `\titlespacing*`; the colour value `\aeb@subsubsectioncolor` comes from `aeb_pro` (unreadable) |
| `\l@paragraph` | docs/richtextman.tex:32 | yes | `toc.tocloft` `\cftparaindent`, `\cftparanumwidth` |
| `\chgCurrLblName`, `\echgCurrLblName` | docs/richtextman.tex:33-34, 534 | yes | each sets `\@currentlabelname`; no `\nameref` or `\autoref` call occurs in the file, so drop them, or inline the assignment |
| `\tops` | docs/richtextman.tex:36 | yes | alias of `\texorpdfstring` (`meta.hyperref`) |
| `\FmtMP` | docs/richtextman.tex:40-41 | yes | `note.marginpar` + `box.minipage` + `sp.manual-space` + `sp.ragged` as in the map |
| `\uif` `\app` `\psf` `\amtIndent` | docs/richtextman.tex:46-49 | yes | aliases of `mark.kernel` commands and a length |
| `\descriptionlabel` | docs/richtextman.tex:59-60 | yes | `list.kernel` label in `\normalfont`; `list.enumitem` `font=\normalfont` is the equivalent |
| `\dps` (defined twice, the second counts) | docs/richtextman.tex:78-79, 94-95 | yes | inline `\mathfrak` and `\mathcal` letters with `\kern` |
| `\fldCnt`, `\incFldCnt` | docs/richtextman.tex:97-98 | yes | counter that numbers field names (`rtFld\the\fldCnt`); the emitter writes unique names |
| `\AcroT` `\cAcroT` `\AcroEB` `\cAcroEB` `\AcroB` `\cAcroB` `\bUrl` | docs/richtextman.tex:146-149 | yes | text macros with `\textcolor{blue}` |
| `\1`, `\2` line markers in a verbatim demo | docs/richtextman.tex:283 | yes | `\rlap{\hskip3.5in ..\ding{182}}`, content of a demo |
| `\srtln`, `\lngln` | docs/richtextman.tex:1190-1191 | yes | `\vskip-\baselineskip\vskip-\parsep` and `\vskip-\parsep`, `sp.manual-space` |
| `docassembly` block | docs/richtextman.tex:103-136 | no | Acrobat JavaScript, see `EXTERNAL/preamble` |
| undefined manual macros (`\cs` `\darg` `\env` `\meta` `\pkg` `\newtopic` `\bVerb` `\eVerb` `\takeMeasure` `\bxSize` `dCmd` `\mlurl`) | docs/richtextman.tex:177, 238, 240-243, 1196 | undecided | defined in none of the files of the zip; see `UNMAPPED/body` |
| `richtext` package code (`\rt@span`, `\rtpara`, keys of `rtFont` and `rtPara`) | richtext.dtx:170-253, 402-471, 548-566 | not bespoke | the published CTAN package, the code of `NEW:form.richtext` |
| `\noEditing` | examples/caption-image.tex:13-14 | yes (JavaScript stays outside) | `\Ff\FfDoNotSpellCheck\Ff\FfDoNotScroll` are `form.eforms` flags; the two `\AA..{event.rc=false;}` strings are program code (Content-opaque) |
| driver aliases `\uif` `\app` `\pkg` `\env` `\opt` `\ameta` `\meta` `\SUB` `\CMD` `\psf` | richtext.dtx:23-36 | yes | aliases of `\textsf`, `\texttt`, `\textsl`, `\ensuremath` |
| DocStrip batch | richtext.ins:46-49 | yes | kernel `docstrip` `\generate{\file{richtext.sty}{\from{richtext.dtx}{copyright,package}}}`; no tool outside TeX |

## Content-opaque
- JavaScript in `\AAkeystroke{event.rc=false;}` and `\AAformat{event.rc=false;}` (docs/richtextman.tex:1178; examples/caption-image.tex:14): program code in `form.eforms` action keys; behaviour, not look.
- Three screenshots in the figure (docs/richtextman.tex:232-234) and the picture under the overlaid field (docs/richtextman.tex:38, 1181); `graphics/fontprops`, `paragraphprops`, `linkprops` are not in the zip, and only examples/graphics/dpsweb.eps and .pdf are.
- The lines after `\end{document}` (docs/richtextman.tex:1223-1229) are dead text from another manual (cards and hints); LaTeX never reads them.
- The rich text strings printed in the manual (`<p>`, `<span style=..>`) are the package's output, held as content.

## Missing assets
Manual_BG_Brown.pdf and Manual_BG_Print_richtext.pdf (docs/richtextman.tex:105-107, 118), the three screenshots, the Lucida Bright fonts behind `lucidbry`, Myriad Pro and Arial on the reader's machine.

## Lib changes
- New ways proposed: `NEW:form.richtext` `richtext` (CTAN, LPPL 1.2, D. P. Story, v1.1.1 of 2020-07-02; TeX Live contrib and MiKTeX), pdf. It builds the DS, RV and V values of a rich text field for `form.eforms`. W1: CTAN package (ctan.org/pkg/richtext read; richtext.dtx:15-17). W2: key lists `rtFont` (font, size, raise, ulstyle, color, url, style, raw, richtext.dtx:163-253) and `rtPara` (halign, valign, margleft, margright, indent, indentby, margtop, margbottom, linespacing, lineheight, richtext.dtx:402-471), `\setDefaultStyle{name}{keys}` (richtext.dtx:691). W3: serves any rich text field of any `eforms` form, not one document. W4: `\rtpara[keys]{name}{text}` and `\setRVVContent{name}{{p1}{skipline}{p2}}` as body lines before the field, `\DS` `\RV` `\V` keys in the `\textField` of `form.eforms` (richtext.dtx:548, 746). Not `form.eforms` (the widget and its action keys), not `mark.kernel` (PDF viewer text formatting, not typeset).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
