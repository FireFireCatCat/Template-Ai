no

# 0318-stem-assignment-template: STEM Assignment Template

- Unverified: read from the source, not compiled.
- Source: Source/0318-stem-assignment-template/ (origin: https://latextemplates.com/downloads/stem-assignment.zip; upstream per README.md:61 is github.com/TylerBignell/LaTeX-AssignmentTemplate; licence: MIT)
- Kind: assignment
- Lib: v3
- Engine: needs XeLaTeX (`fontspec` loaded unconditionally, assets/stemtemplate.sty:91; README.md:25-27 says `xelatex main`)
- Look carried by: mixed (the zip-local style `assets/stemtemplate.sty` carries colours, fonts, headings, floats, boxes and code; the three `assets/titlepage_*.tex` files hold the title pages; the header/footer is set in the sample's own preamble, main.tex:93-99)
- Class origin: zip-local (document class is the kernel `article`, main.tex:8; the look is in `assets/stemtemplate.sty`, which the README calls "not on CTAN" (README.md:14-15) and ctan.org/pkg/stemtemplate returned 404)
- Main file: main.tex (other samples: none; `assets/frontmatter.tex` is an optional `\input` fragment, commented out at main.tex:87)
- Read: main yes, zip-local classes and styles all (stemtemplate.sty 854 lines, four `.tex` fragments)
- Abbreviations below: `sty` = assets/stemtemplate.sty; `tp-std`, `tp-abs`, `tp-cmp` = assets/titlepage_standard.tex, titlepage_abstract.tex, titlepage_compact.tex; `fm` = assets/frontmatter.tex.

## Verdict
No. The document class is the kernel `article` and most of the style file is `\usepackage` plus declarative settings that map to lib ways. Two things in `stemtemplate.sty` are irreducible and the sample runs one of them: the header's left field is chosen at run time by measuring boxes and comparing widths, with an acronym built by a string loop (sty:726-762, called at main.tex:95), and the "reaction" equation environments patch cleveref and label internals (sty:206-274). A drafting mode that swallows `tikzpicture`, `circuitikz`, `problem` and `solution` bodies (sty:421-443, 607-620) is also bespoke, but it is off for the sample's settings.

## Blockers
- `BESPOKE/class` `\smartleftheader` measures four `\sbox` widths against `\headwidth` with `\ifdim` and falls back from full course name to an acronym to the bare code; `\makeAcronym` loops over words with `\foreach` and a stop-word list (sty:726-762); used by the sample's header (main.tex:95)
- `BESPOKE/class` the `reaction` counter and six environments `requation` `ralign` `rgather` `rmultline` `rflalign` `ralignat`: each steps a counter, redefines `\ltx@label` and writes cleveref internals `\cref@constructprefix` `\cref@currentlabel`, then appends `\tag` (sty:206-274); unused in the sample body, but defined by the style the sample loads
- `BESPOKE/class` draft mode (active only when `\metaShowFigures` is not `true`; the sample sets `true`, main.tex:60): `\RenewEnviron{tikzpicture}` and `\RenewEnviron{circuitikz}` swallow the body and draw a grey TikZ rectangle with a cross (sty:421-443); `\RenewEnviron{problem}` and `\RenewEnviron{solution}` swallow the body (sty:607-620). Dormant here; stated as a blocker because the code is in the loaded style

Not blockers, recorded: the `minted` branch (sty:698-713, `\newif\ifmetaUseMinted`, sample sets `false` at main.tex:62) is EXTERNAL/package only when selected; it is not loaded unconditionally, so the pilot ruling does not apply. The sample's own settings take the `listings` branch (sty:718).

## Class setting
- Class: `class.article` options: `12pt`, `letterpaper` (main.tex:8)
- Class-native vocabulary used: `\section` (main.tex:104-136), display maths `\[ \]` (main.tex:114, 122, 130), `\maketitle` blanked by `\renewcommand` (main.tex:77), `titlepage` environment and `abstract` environment inside the title-page fragments (tp-std:6, tp-abs:49), `\tableofcontents` `\listoffigures` `\listoftables` in the optional fragment (fm:11, 15, 19)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:8 | `class.article` | 12pt, letterpaper |
| paper and size | main.tex:8 | `page.class-options` | 12pt, letterpaper |
| page geometry | sty:80 | `page.geometry` | margin=2.54cm, headheight=14.9pt |
| line spacing | sty:81-84; main.tex:40 | `sp.setspace` | `\singlespacing` / `\onehalfspacing` / `\doublespacing` chosen by `\metaLineSpacing`; sample onehalf |
| landscape pages | sty:85 | `pg.landscape` | `pdflscape`, no options |
| include PDF pages | sty:384 | `pg.include-pdf` | `pdfpages`, no options |
| language | sty:90 | `lang.babel` | english |
| text fonts | sty:121-143, 147-158 | `font.fontspec` | `\setmainfont` / `\setsansfont` / `\newfontfamily` IBM Plex Serif and Sans by OTF file name (Extension=.otf, UprightFont=*-Regular, BoldFont=*-Bold, ItalicFont=*-Italic, BoldItalicFont=*-BoldItalic); or a user-named system font |
| default family | sty:161-165; main.tex:39 | `font.family-default` | `\familydefault` = `\sfdefault` (sample `sans`) or `\rmdefault` |
| font sizes | tp-std:10-20; tp-abs:9-19 | `font.size-commands` | `\Large` `\large` `\normalsize` `\small` `\LARGE` |
| theme colours | sty:18-23, 29-75 | `color.xcolor` | `dvipsnames,svgnames,x11names`; `\definecolor` DefaultBlue 1B4F8A, YorkRedDark 810001, ScienceSkyBlueDark 065C87, LassondeNavy 003366; `themecolour` `linkcolour` `citecolour` `urlcolour` by `\colorlet` or `\definecolor{HTML}` (value choice in Bespoke) |
| headings | sty:170-182 | `head.titlesec` | `\titlespacing*` (e.g. section 0pt/1em/0.5em); `\titleformat` section `\Large\bfseries\color{themecolour}`, number in themecolour, sep 1em; subsection `\large`, subsubsection `\normalsize`, paragraph and subparagraph runin; part `display` |
| sample sections | main.tex:104-136 | `head.kernel` | `\section{...}` x5 |
| abstract env | sty:184-189 | `abs.kernel` | `\renewenvironment{abstract}` as `\section*{Abstract}` + `\noindent`, `\par\vspace{1em}` after |
| title page (standard) | tp-std:5-82; main.tex:79-81 | `front.titlepage-env` | `titlepage`, `\Centering`, `\vspace*{2cm}`, themecolour rules `\rule{\linewidth}{0.5mm}`, two `minipage[t]{0.4\textwidth}`, `\vfill`, logo `\includegraphics[width=\linewidth,height=3cm,keepaspectratio]` and date |
| title page (abstract) | tp-abs:5-53 | `front.titlepage-env` | as standard with `\small` blocks and `abstract` env under `\justifying` |
| title page (compact) | tp-cmp:5-38 | `front.titlepage-env` | no `titlepage` env; `\thispagestyle{plain}`, rules, two `minipage[t]{0.45\textwidth}` |
| maketitle disabled | main.tex:77 | `front.maketitle` | `\renewcommand{\maketitle}{}` |
| title-page blocks | tp-std:22-44 | `box.minipage` | `minipage[t]` widths 0.4 / 0.45 `\textwidth` |
| rules, spacing | tp-std:14, 18; tp-cmp:12, 37 | `sp.rule` | `\rule{\linewidth}{0.5mm}` in themecolour |
| manual spacing | tp-std:8, 10, 15, 46 | `sp.manual-space` | `\vspace`, `\vspace*`, `\vfill`, `\hfill` |
| title-page lines | tp-std:7, 22-23, 39-40 | `sp.ragged` | `ragged2e` `\Centering`, `FlushLeft`, `FlushRight`, `\RaggedLeft`, `\justifying` |
| students table | tp-std:31-34 | `tbl.tabular` | `tabular{@{}l@{\quad}l@{}}` for partners |
| logo | tp-std:58, 72 | `fig.graphicx` | `\includegraphics[...keepaspectratio]`; `\graphicspath{{figures/}{assets/}}` (sty:365) |
| page numbering | tp-std:5; main.tex:82, 88 | `pgnum.pagenumbering` | roman for title page, `\setcounter{page}{2}`, then arabic |
| header and footer | main.tex:93-99; sty:80 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\lhead` (the `\smartleftheader` call is Bespoke), `\rhead` student name and number, `\cfoot{\thepage}`, `\headrulewidth` 0.4pt, `\headrule` coloured themecolour |
| emphasis | tp-std:25, 30, 41 | `mark.kernel` | `\emph`, `\textbf` |
| equations | main.tex:114-134; sty:194 | `math.amsmath` | `amsmath` `\text`, display `\[ \]` (the kernel form `math.kernel` is the display itself) |
| math packages | sty:194-197 | `math.amssymb`, `math.mathtools`, `math.bm` | `amssymb` `amsfonts`; `mathtools`; `bm` |
| units | sty:197-198 | `mark.siunitx` | `\sisetup{detect-all, per-mode=symbol}` |
| equation numbering | sty:200 | `num.counters` | `\numberwithin{equation}{section}` when `\metaNumberEquations` is `true` (sample `false`) |
| theorem styles | sty:279-309 | `thm.amsthm` | `\newtheoremstyle` plain / definition / remark: space 0.75em, body `\itshape` for plain, head `\bfseries\color{themecolour}` (remark `themecolour!70`), punct `:`, space after head 0.5em |
| theorem environments | sty:312-347 | `thm.amsthm` | 11 `\newtheorem`s (theorem lemma proposition corollary conjecture axiom; definition example criterion; remark note), `[section]` counter when `\metaNumberTheorems` is `true` |
| proof | sty:349-356 | `thm.amsthm` | `\qedsymbol` = themecolour `$\blacksquare$`; `\renewenvironment{proof}` with head `\bfseries\color{themecolour}`, `:` added (reducible, see Bespoke) |
| figures | sty:361-366 | `fig.graphicx`, `fig.float` | `graphicx`, `\setkeys{Gin}{draft=true}` when `\metaShowFigures` is not `true`; `float` |
| subfigures | sty:367 | `fig.subcaption` | `subcaption` |
| captions | sty:368-383, 403-409 | `cap.caption` | `\captionsetup` font small, labelfont bf + themecolour, textfont black, labelsep colon, singlelinecheck false, skip 8pt; figure below / table above (skip 4pt); `\DeclareCaptionJustification{ragged2e}` and `{centred}`; `longtable` hypcap=false |
| numbering by section | sty:386, 411, 465 | `num.counters` | `\numberwithin{figure|table|algorithm}{section}` |
| tables | sty:391-400 | `tbl.tabular`, `tbl.booktabs`, `tbl.tabularx`, `tbl.multirow` | `array`, `booktabs`, `tabularx`, `multirow`; `\newcolumntype` L C R P Q K |
| long tables | sty:401-402 | `tbl.longtable` | `ltablex` (tabularx with page breaks); `\keepXColumns` at begin document |
| algorithms | sty:448-465 | `alg.algorithmicx` | `algorithm` + `algpseudocode`; `\algrenewcommand` indent 1.5em, comment colour themecolour!60, Require/Ensure labels in themecolour; `\ALG@beginalgorithmic` = `\small`; caption set as above |
| boxes: problem | sty:558-589 | `box.tcolorbox` | `\tcbuselibrary{most}`; enhanced, breakable, colback white, colframe themecolour, colbacktitle themecolour, coltitle white, fonttitle bold, sharp corners, toptitle/bottomtitle 6pt, lefttitle 10pt, leftrule 3pt, other rules 1pt; title "Problem n: name" |
| boxes: solution | sty:591-606 | `box.tcolorbox` | as above, title "Solution" in themecolour, `attach title to upper` |
| problem counter | sty:560-567 | `num.counters` | `\newcounter{problem}[section]` or plain; `\theproblem` |
| lists | sty:553 | `list.enumitem` | `enumitem` loaded, no options |
| code | sty:625-642 | `code.listings` | `\lstset`: ttfamily small, breaklines, columns=fullflexible, tabsize 4, numbers left, numberstyle tiny themecolour!60, numbersep 8pt, background black!5, xleftmargin 14pt, xrightmargin 4pt, keyword blue, comment green!45!black, string red!60!black |
| code styles | sty:659-693 | `code.listings` | `\lstdefinestyle` matlab, java, python, cpp, latex with `morekeywords` |
| code env | sty:714-719 | `code.listings` | `\lstnewenvironment{codelisting}[1]{\lstset{style=#1}}{}` |
| code (switch) | sty:698-713 | `code.minted` | `minted[cache=false]` with `\setminted{...}` when `\metaUseMinted` is `true` (sample `false`): EXTERNAL when selected |
| listing caption, list of | sty:626, 643-658; fm:27 | `code.listings` | `\lstlistlistingname`, `\captionsetup[lstlisting]`, `\lstlistoflistings` |
| hyperlinks | sty:470-482 | `meta.hyperref` | `\hypersetup`: pdftitle pdfauthor pdfsubject pdfkeywords from metadata, colorlinks=true, linkcolor/citecolor/urlcolor = the three colours, pageanchor=true |
| toc link colour | sty:529-535 | `meta.hyperref` | `\addtocontents{toc|lof|lot|loa|lol}{\protect\hypersetup{linkcolor=black}}` at begin document |
| URLs | sty:545 | `meta.url` | `xurl` |
| cross references | sty:483-527 | `xref.cleveref` | `\crefname` / `\Crefname` for 20 types (equation eq., figure fig., section, theorem..., lstlisting, problem) |
| labels and refs | sty:483 | `xref.kernel` | `\label` `\ref` underlying cleveref |
| microtype | sty:540-544; main.tex:59 | `sp.microtype` | `microtype` when `\metaFinalDraft` is `true`, else `[draft]` (sample `false`) |
| emergency stretch | sty:546 | `sp.lengths` | `\emergencystretch` 3em |
| first-paragraph indent | sty:547 | `sp.indentfirst` | `indentfirst` |
| ragged | sty:548 | `sp.ragged` | `ragged2e` |
| bibliography | sty:771-787; main.tex:32-34, 61 | `bib.biblatex-biber` | `biblatex[backend=biber, style=\metaBibStyle, sorting=none, backref=\metaShowBackref]`; `\addbibresource`; sample sets `\metaShowBib` `false`, so this branch is not loaded |
| csquotes | sty:767 | `lang.csquotes` | `csquotes`, no options |
| appendix | sty:807-854 | `num.appendix` | `\appendix` extended: titleformat "Appendix A", `\crefalias`, `\renewcommand\the...` and `\counterwithin` for 20 counters (see Bespoke) |
| dummy text | sty:13 | `draft.todo` | `lipsum` |
| TOC and lists | fm:11, 15, 19, 23, 27 | `toc.kernel` | `\tableofcontents` `\listoffigures` `\listoftables`, `\phantomsection\addcontentsline{toc}{section}{...}`; optional, commented out in the sample (main.tex:87) |
| metadata layer | main.tex:13-67 | `front.maketitle` | strings `\metaAssignmentTitle` ... `\metaAbstract` consumed by the title-page fragments (content; mechanism in Bespoke) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\smartleftheader`, `\makeAcronym` | sty:726-762; main.tex:95 | No | `\sbox` width measurement, `\ifdim` against `\headwidth`, acronym built by `\foreach` and a stop-word `\IfSubStr` test: layout chosen at run time from measured widths. No lib way computes this. `BESPOKE/class` |
| reaction counter and six `r...` environments | sty:206-274 | No | `\refstepcounter`, `\let\ltx@label`, `\cref@constructprefix`, `\protected@edef\cref@currentlabel`, `\tag`: patches cleveref and label internals so `\cref` prints "rxn. R1". `BESPOKE/class` (unused by the sample body) |
| draft placeholders for `tikzpicture`, `circuitikz` | sty:421-443 | No | `environ` `\RenewEnviron` swallows the body and draws a grey rectangle with a cross via a saved `\tikzpicture`; dormant for `\metaShowFigures=true`. `BESPOKE/class` |
| draft suppression of `problem` and `solution` | sty:607-620 | No | `\RenewEnviron` replaces the box by a bar and a grey "content suppressed" note; dormant here. `BESPOKE/class` |
| draft bibliography stubs | sty:790-801 | Yes | `\newcommand`/`\renewcommand` aliases for `\autocite` `\cite` `\parencite` `\textcite` `\footcite` `\fullcite` `\citeauthor` `\citeyear` `\citetitle` print `\textcolor{red}{[key]}` (`color.xcolor` + `mark.kernel`); `\nocite` swallowed; `\printbibliography` prints a red italic note. Active in the sample (`\metaShowBib` false, main.tex:61). An emitter writes the final branch `bib.biblatex-biber` instead |
| `\renewbibmacro*{pageref}` | sty:779-787 | Yes (judgement) | biblatex's documented bibmacro override that wraps the back-reference text in `\hypersetup{linkcolor=urlcolour}`; a parameter of `bib.biblatex-biber`; not loaded in the sample |
| theme-colour and font switches | sty:29-75, 105-165 | Yes | `\StrLeft`/`\if#`/`\StrLen=6` pick `\definecolor{HTML}` or `\colorlet`; `\newif\ifkme@usedefaultserif` picks default or named font. The emitter resolves the value and writes `color.xcolor` and `font.fontspec` lines |
| `\seriftext`, `\sansseriftext` | sty:157-158 | Yes | aliases of `{\seriffont #1}`; `font.fontspec` `\newfontfamily` plus a group |
| `proof` environment | sty:350-356 | Yes (judgement) | amsthm's own `proof` body with head font `\bfseries\color{themecolour}`; `thm.amsthm` parameter; uses kernel internals `\@addpunct` `\@endpefalse` copied from amsthm |
| `problem` and `solution` environments | sty:569-606 | Yes | `\newenvironment` wrappers of one `tcolorbox` with a counter and a title string: `box.tcolorbox` (key list in the table) + `num.counters` |
| `codelisting` environment | sty:714-719 | Yes | `\lstnewenvironment` with a style argument: `code.listings` |
| `\appendix` redefinition | sty:807-854 | Yes | straight-line sequence of `\titleformat`, `\crefalias`, `\renewcommand{\the...}` and `\counterwithin` (no conditionals): `head.titlesec`, `xref.cleveref`, `num.counters`, `num.appendix` |
| `\AtBeginDocument` toc link colours; `\keepXColumns` | sty:529-535, 402 | Yes | kernel `\addtocontents` lines carrying `\hypersetup`; `ltablex` switch |
| `\newcolumntype` L C R P Q K | sty:394-399 | Yes | `array` column types, `tbl.tabularx` / `tbl.tabular` |
| `\DeclareCaptionJustification` x2 | sty:369, 381 | Yes | documented `caption` package extension: `cap.caption` |
| `\AddToHook{begindocument/end}` | sty:643-658 | Yes | kernel hook carrying `\captionsetup[lstlisting]` and a `\numberwithin`: `cap.caption`, `num.counters` |
| title-page fragments with `\ifthenelse{\equal{\metaPartners}{}}`, `\IfFileExists{\metaLogoPath}`, `\metaLogoLocation` branches | tp-std:12, 24-35, 47-81; tp-cmp:16-25, 31; tp-abs:11 | Yes | presence tests on known strings and a file; the emitter resolves each and writes one fixed `front.titlepage-env` |
| metadata `\newcommand` layer, `\IfFileExists{assets/titlepage_\metaTitlePage}` | main.tex:13-67, 79-81 | Yes | content strings and a file selector; the emitter substitutes the values |
| helper packages `xifthen`, `xstring`, `environ` | sty:11-12, 427 | Yes | programming utilities for the items above, not component ways (considered: they are not template looks); no emitter line needed once the conditionals are resolved |

## Content-opaque
None used in the sample body (main.tex:104-142 has only text and display equations). Content packages are loaded for authors: `mhchem` (sty:205), `tikz`, `pgfplots` (`compat=1.18`), `circuitikz`, `pgf-pie` (sty:416-420), i.e. `art.content-package` and `art.tikz` for figures an author adds; the `\ce{}` chemistry markup also falls here. Missing assets: IBM Plex OTF files (sty:123-153), `references.bib` (main.tex:32, only needed when `\metaShowBib` is `true`); the logo `assets/placeholder_logo.png` is shipped.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
