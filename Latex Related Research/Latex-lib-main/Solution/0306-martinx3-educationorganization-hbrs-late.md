no

# 0306-martinx3-educationorganization-hbrs-late: H-BRS LaTeX Vorlage (Bachelor/Seminar thesis, Fachbereich Informatik, Hochschule Bonn-Rhein-Sieg)

- Unverified: read from the source, not compiled.
- Source: Source/0306-martinx3-educationorganization-hbrs-late/ (origin: https://codeload.github.com/MartinX3-EducationOrganization/hbrs-latex-vorlage-arbeit/zip/refs/heads/master; licence: AGPL-3.0)
- Kind: thesis
- Lib: v4
- Engine: needs LuaLaTeX (`\setmainfont{Arial}` via fontspec, aussehen/hbrs-inf.sty:5-6; the build is `latexmk -lualatex --shell-escape`, Makefile:2-3; README.md:11 names LuaLaTeX; XeLaTeX would also run fontspec)
- Look carried by: mixed (class `scrreprt` with KOMA options and commands; the zip-local package aussehen/hbrs-inf.sty, a stack of `\RequirePackage` lines and KOMA settings; a hand-laid `titlepage` in abschnitte/Deckblatt.tex)
- Class origin: tex-distribution-unbundled (`scrreprt` from KOMA-Script, Arbeit.tex:23; source not read; the zip has no zip-local class, only the zip-local package hbrs-inf.sty, which is analysed below)
- Main file: Arbeit.tex (other samples: none; body chapters are abschnitte/*.tex, `\input` from Arbeit.tex:33-87)
- Read: main yes (Arbeit.tex, Meta.tex and every abschnitte/*.tex in full), zip-local classes and styles all (aussehen/hbrs-inf.sty and aussehen/hbrs-inf-diagrams.sty in full; no zip-local .cls); also latexmkrc, Makefile, README.md and .github/workflows/ci.yml; Literaturverzeichnis.bib skimmed (content)

## Verdict
The look itself is recoverable: `scrreprt`, geometry, `scrlayer-scrpage`, KOMA font and section settings, `tocloft`, `babel`, `csquotes`, `biblatex` and `glossaries-extra` are all published and set by parameters, and the zip-local macros reduce to them. The verdict is still `no`: hbrs-inf.sty loads `minted` unconditionally (aussehen/hbrs-inf.sty:44), and the Makefile builds with `--shell-escape` because of it (Makefile:2-3), so by the pilot ruling it is `EXTERNAL/package` even though two body listings also call it (abschnitte/Einleitung.tex:289, :301). Nothing else blocks: no irreducible bespoke code and no template-defining artwork.

## Blockers
- `EXTERNAL/package` `minted` loaded unconditionally by the zip's own style; needs shell escape and Python Pygments (aussehen/hbrs-inf.sty:44, Makefile:2-3; used at abschnitte/Einleitung.tex:289 `\begin{minted}{c}` and :301 `\inputminted{python}{anhang/example.py}`)
- Recorded, not relied on: `svg` package is also loaded unconditionally (aussehen/hbrs-inf.sty:12) and the CI installs Inkscape (.github/workflows/ci.yml:14), but no `\includesvg` or `\includeinkscape` appears anywhere in the zip (grep over all .tex and .sty returned nothing), so by the `fig.svg` line it is `EXTERNAL` only when used and does not decide the verdict.

## Class setting
- Class: `class.scrreprt` options: `a4paper`, `fontsize=11pt` (Arbeit.tex:23); `\KOMAoptions{parskip=half}` (aussehen/hbrs-inf.sty:83), `\KOMAoptions{bibliography=totocnumbered}` (:54), `\KOMAoptions{listof=totoc}` (:57)
- Class-native vocabulary used: `\chapter`, `\chapter*`, `\section`, `\subsection` (abschnitte/Einleitung.tex:1,5,198; abschnitte/Erklaerung.tex:1); `\KOMAoptions` (aussehen/hbrs-inf.sty:54,57,83); `\RedeclareSectionCommand[afterskip,beforeskip,runin]{chapter|section|subsection}` (:63-78); `\setkomafont{chapter|section|subsection|caption}` (:67,73,79,80); `\addtokomafont{pagehead}` (:89). The scrlayer-scrpage commands `\ihead*` `\ofoot*` `\clearpairofpagestyles` are the package's, listed under `hf.scrlayer-scrpage`. The source of `scrreprt` was not read.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | Arbeit.tex:23 | `class.scrreprt` | a4paper, fontsize=11pt |
| paper size | Arbeit.tex:23 | `page.class-options` | a4paper |
| page geometry (cover) | Arbeit.tex:31 | `page.geometry` | `\newgeometry{left=25.5mm, right=20mm, top=25.7mm, bottom=10mm}` after `\RequirePackage{geometry}` (aussehen/hbrs-inf.sty:32) |
| page geometry (rest of document) | Arbeit.tex:38 | `page.geometry` | `\newgeometry{left=40mm, right=20mm, top=25mm, bottom=10mm, includefoot}`; no `\restoregeometry`, so it stays for all later pages |
| landscape page | aussehen/hbrs-inf.sty:35; abschnitte/Auswertung.tex:43 | `pg.landscape` | `lscape`, `landscape` environment around one figure |
| page breaks | Arbeit.tex:59 | `pg.break` | `\clearpage` before the introduction |
| page numbering | Arbeit.tex:32,60-61 | `pgnum.pagenumbering` | `roman` for cover to acronyms; `\setcounter{page}{1}`, `arabic` from the introduction |
| paragraph spacing | aussehen/hbrs-inf.sty:83 | `class.scrreprt` | `\KOMAoptions{parskip=half}` (class option as parameter) |
| line spacing | aussehen/hbrs-inf.sty:60; abschnitte/Deckblatt.tex:5,18 | `sp.setspace` | `singlespacing`; `spacing` environment 0.90 and 1.25 on the cover |
| microtypography | aussehen/hbrs-inf.sty:38 | `sp.microtype` | defaults |
| alignment | abschnitte/Deckblatt.tex:4,17 | `sp.ragged` | `\raggedright` in the minipage, `center` environment |
| manual spacing and line breaks | abschnitte/Deckblatt.tex:2,8-9,15,30,47; abschnitte/Erklaerung.tex:9 | `sp.manual-space` | `\raisebox{\dimexpr\ht\strutbox-\height\relax}`, `\hfill`, `\linebreak`, `\vspace{4\baselineskip}`, `\vfill`, `\vspace{2\baselineskip}` |
| main text face | aussehen/hbrs-inf.sty:5-6 | `font.fontspec` | `\setmainfont{Arial}` (system font, not shipped) |
| font sizes | abschnitte/Deckblatt.tex:4,19,20,25; aussehen/hbrs-inf.sty:67,73,79 | `font.size-commands` | `\Large`, `\large`, `\fontsize{26}{26}`, `\fontsize{20}{20}`, `\normalsize` |
| heading skips and run-in | aussehen/hbrs-inf.sty:63-78 | `head.class-native` | `\RedeclareSectionCommand`: chapter afterskip=0pt beforeskip=0pt; section beforeskip=4pt afterskip=0pt runin=false; subsection beforeskip=3pt afterskip=0pt runin=false |
| heading fonts | aussehen/hbrs-inf.sty:67,73,79 | `head.koma-fonts` | chapter `\large`, section `\normalsize`, subsection `\normalsize` |
| heading commands in body | abschnitte/Einleitung.tex:1,5,198; abschnitte/Erklaerung.tex:1 | `head.kernel` | `\chapter`, `\section`, `\subsection`, `\chapter*{}` (empty starred chapter on the declaration page), `\label` |
| section numbering and toc depth | aussehen/hbrs-inf.sty:17-18 | `num.secnumdepth` | secnumdepth=3, tocdepth=3 |
| running head and foot | aussehen/hbrs-inf.sty:86-91 | `hf.scrlayer-scrpage` | `[headsepline, plainheadsepline]`, `\clearpairofpagestyles`, `\addtokomafont{pagehead}{\small\normalfont}`, `\ihead*{\ThesisTitle}`, `\ofoot*{\pagemark}` |
| page style switch | aussehen/hbrs-inf.sty:87 | `hf.pagestyle-kernel` | `\pagestyle{scrheadings}` |
| title page | abschnitte/Deckblatt.tex:1-48 | `front.titlepage-env` | hand-laid `titlepage`: logo + minipage header, centred thesis type, title and subject, `tabular{rl}` of examiners and author; no `\maketitle` |
| cover logo | abschnitte/Deckblatt.tex:2 | `fig.graphicx` | `\includegraphics[height=0.94cm]{bilder/fhlogo}` (fhlogo.pdf is shipped) |
| cover header box | abschnitte/Deckblatt.tex:3 | `box.minipage` | `minipage[t]{.825\linewidth}` |
| cover text marks | abschnitte/Deckblatt.tex:6-7,10-11 | `mark.kernel` | `\textbf`, `\textit` |
| cover and declaration tables | abschnitte/Deckblatt.tex:33-46; abschnitte/Erklaerung.tex:11-14 | `tbl.tabular` | `tabular{rl}`, `tabular{ll}`; `array` loaded at aussehen/hbrs-inf.sty:9 |
| declaration of authorship page | abschnitte/Erklaerung.tex:1-14 | `front.dedication` | centred bold `\large` heading, two paragraphs, signature line table |
| date format | aussehen/hbrs-inf.sty:10,29; Meta.tex:11 | `front.datetime` | `datetime` and `isodate[ngerman]`; `\ThesisPubDate` is `\today` |
| language | aussehen/hbrs-inf.sty:28 | `lang.babel` | `ngerman` |
| quotation marks | aussehen/hbrs-inf.sty:48; abschnitte/Einleitung.tex:185; abschnitte/Auswertung.tex:5 | `lang.csquotes` | `csquotes` defaults; `\enquote`, `\textelp{}` |
| contents list | Arbeit.tex:44 | `toc.kernel` | `\tableofcontents` |
| list of figures | Arbeit.tex:49 | `toc.kernel` | `\listoffigures` |
| toc layout | aussehen/hbrs-inf.sty:21,23,25 | `toc.tocloft` | `[titles]`, `\cftsetrmarg{4em}`, `\cftsetindents{figure}{0em}{4em}` |
| toc entries for lists and bibliography | aussehen/hbrs-inf.sty:54,57 | `toc.koma` | `bibliography=totocnumbered`, `listof=totoc` |
| lists | abschnitte/Stand_Forschung.tex:3-8; abschnitte/Anhang.tex:20-31; abschnitte/Einleitung.tex:241-252 | `list.kernel` | nested `description`; `itemize` (also inside `m{}` table cells) |
| figures with `[H]` | abschnitte/Anhang.tex:2; abschnitte/Auswertung.tex:11,44; abschnitte/Einleitung.tex:199-257 | `fig.float` | `figure[H]` with `center`; the zip loads no `float` itself (grep of all .tex and .sty found none); it must come in through another package (not traced) |
| included image | abschnitte/Einleitung.tex:201,208,215; aussehen/hbrs-inf.sty:11 | `fig.graphicx` | `\includegraphics[width=3cm]{bilder/fhlogo}` |
| svg package | aussehen/hbrs-inf.sty:12 | `fig.svg` | `[inkscapepath=out/svg-inkscape]`; loaded, never called (see Blockers) |
| captions | abschnitte/Anhang.tex:19; abschnitte/Einleitung.tex:202,230,295,302; abschnitte/Auswertung.tex:39,54 | `cap.kernel` | `\caption` below the content |
| caption font | aussehen/hbrs-inf.sty:80 | `cap.koma` | `\setkomafont{caption}{\small}` |
| tables | abschnitte/Einleitung.tex:222-229,236-255; abschnitte/Auswertung.tex:46-53 | `tbl.tabular` | `\hline` grid, `\hline\hline`, `m{4cm}` columns from `array`; no caption on the third table |
| table cell maths | abschnitte/Auswertung.tex:48-51 | `math.kernel` | inline `$\neg$ $\vee$ $\wedge$ $\equiv$ $\mathbf{1}$` (content) |
| margin to-dos | aussehen/hbrs-inf.sty:97,101; abschnitte/Einleitung.tex:259-260 | `draft.todo` | package `snaptodo` (CTAN, TeX Live, LPPL 1.3c; read at ctan.org/pkg/snaptodo); `\snaptodoset{chain bias=-99in}`, `\snaptodo{...}`; the package is the parameter |
| code listings | aussehen/hbrs-inf.sty:44; abschnitte/Einleitung.tex:289-294,301 | `code.minted` | `minted` unconditional, `\begin{minted}{c}`, `\inputminted{python}{...}`; EXTERNAL (see Blockers) |
| bibliography | aussehen/hbrs-inf.sty:52-53; Arbeit.tex:82 | `bib.biblatex-biber` | `biblatex[style=iso-authoryear]` (the `iso690` style package), `\addbibresource{datenbanken/Literaturverzeichnis.bib}`, `\printbibliography[title={Literaturverzeichnis}]`; no `backend=` given, so biber (CI installs biber, .github/workflows/ci.yml:14) |
| citation commands | abschnitte/Einleitung.tex:196,264-271 | `bib.biblatex-biber` | `\cite`, `\parencite`, `\textcite`, `\textcite*`, `\autocite[pre][post]` |
| acronym list | aussehen/hbrs-inf.sty:126-129; datenbanken/Abkuerzungsverzeichnis.tex:1-11; Arbeit.tex:54; abschnitte/Einleitung.tex:274-284 | `idx.glossaries` | `glossaries-extra[acronym,nomain]`, `\setabbreviationstyle[acronym]{long-short}`, `\makeglossaries`, `\loadglsentries`, `\newacronym`, `\printacronyms[title=...]`, `\gls`; needs a `makeglossaries` pass (latexmkrc:12-22), the same type of post-pass the lib already accepts for biber and makeindex |
| PDF metadata and link colours | aussehen/hbrs-inf.sty:105-123 | `meta.hyperref` | pdftitle, pdfsubject, pdfauthor, pdfcreator={LuaLaTeX}, pdfkeywords from `\Thesis...` macros; breaklinks, colorlinks, link/cite/url colour black; loaded last |
| labels | abschnitte/Einleitung.tex:1,5,202; abschnitte/Anhang.tex:17 | `xref.kernel` | `\label` only; no `\ref`, `\autoref` or `\cref` appears in the zip |
| file inclusion | Arbeit.tex:24,33,39,62,67,72,77,87 | `struct.input` | `\input{Meta}`, `\input{abschnitte/...}` |
| Gantt chart | aussehen/hbrs-inf.sty:94; abschnitte/Anhang.tex:3-18 | `art.tikz` | `pgfgantt` `ganttchart` in a figure (content; see Content-opaque) |
| flowchart | aussehen/hbrs-inf-diagrams.sty:7-55; abschnitte/Auswertung.tex:14-38 | `art.tikz` | `tikzpicture` in a figure with node styles from the sty (content; see Content-opaque) |
| UML package | aussehen/hbrs-inf-diagrams.sty:5 | `art.content-package` | `tikz-uml`, loaded and never called by the sample; not on CTAN (ctan.org/pkg/tikz-uml returned 404; the zip's own comment says so, aussehen/hbrs-inf-diagrams.sty:4); the CI fetches it from the author's page (.github/workflows/ci.yml:17); content package, does not decide the verdict |
| compat hack | aussehen/hbrs-inf.sty:132 | considered: `scrhack` | load-only KOMA compatibility fix with no printed effect, like the rejected `sys.compat-load` in the lib change log; not a component |
| build interaction mode | Arbeit.tex:18 | none | `\nonstopmode` changes error handling, not the page |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local package `aussehen/hbrs-inf` | aussehen/hbrs-inf.sty:1-137 | yes, except `minted` | `\RequirePackage` lines plus option settings: `fontspec`, `array`, `datetime`, `graphicx`, `svg`, `tocloft`, `babel`, `isodate`, `geometry`, `lscape`, `microtype`, `csquotes`, `biblatex`, `setspace`, `scrlayer-scrpage`, `pgfgantt`, `snaptodo`, `hyperref`, `glossaries-extra`, `scrhack`, with the KOMA calls mapped in the component map; the one non-reducible line is `\RequirePackage{minted}` (:44), an EXTERNAL package, not code |
| `\avoidpagebreak` | aussehen/hbrs-inf.sty:135-137 (used abschnitte/Stand_Forschung.tex:4) | yes | `\par\nobreak\@afterheading` composes kernel break control (`pg.break` family, `\nobreak`) with the kernel's own `\@afterheading`, which only keeps the next line on the same page; an emitter writes the same kernel call inline after the description label. No counter or output routine is added. Not relied on for the verdict |
| flowchart node styles `arrow` `decision` `io` `process` `startstop` `subprocess` | aussehen/hbrs-inf-diagrams.sty:7-55 | yes (as TikZ keys) | `\tikzstyle` and `\tikzset` with shapes, `draw`, `fill=green!30` etc., `text width=3cm`; `subprocess` adds a `path picture` that draws two vertical lines, with `\newcommand\ppbb{path picture bounding box}` as an alias (:42). All of it is drawing code inside `art.tikz`, used only for the figure at abschnitte/Auswertung.tex:14-38 (content, not page identity) |
| metadata macros `\Thesis...` (22 of them) | Meta.tex:1-22 | yes | `\newcommand` strings; `\ThesisAuthor` and `\ThesisAuthorEMail` are concatenations of other strings; `\ThesisPubDate` is `\today`; plain inline expansion |
| `\usetikzlibrary{arrows.meta, positioning, shapes.geometric}` | aussehen/hbrs-inf-diagrams.sty:8 | yes | `art.tikz` library loading |

## Content-opaque
- `pgfgantt` `ganttchart` inside a figure (abschnitte/Anhang.tex:3-18)
- `tikzpicture` flowchart inside a figure, with the node styles that hbrs-inf-diagrams.sty defines for it (abschnitte/Auswertung.tex:14-38; aussehen/hbrs-inf-diagrams.sty:7-55). These are figure artwork shown as an example, not the template's page frame or cover, so they are recorded here and not as `ART`.
- the two minted listings and the `.bib` entries (abschnitte/Einleitung.tex:289-304; datenbanken/Literaturverzeichnis.bib) are text content; `minted` itself is the blocker above.
- missing assets: Arial (system font, README.md:21-30), the `tikz-uml` package (not shipped), the `out/svg-inkscape` folder (generated).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes: `\RedeclareSectionCommand` is filed under `head.class-native` (the class's own heading look set by its commands); `snaptodo` under `draft.todo` (the package is the parameter); no widening of any lib line was needed.
