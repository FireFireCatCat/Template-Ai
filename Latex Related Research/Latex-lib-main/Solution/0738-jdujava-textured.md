no

# 0738-jdujava-textured: TeXtured (thesis template, "TeXtured Manual" 1.5.1)

- Unverified: read from the source, not compiled.
- Source: Source/0738-jdujava-textured/ (origin: https://codeload.github.com/jdujava/TeXtured/zip/refs/heads/master; licence: CC0-1.0, with the MFF logo and the capacitor figure excepted, README.md:125-127)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (pdfTeX chosen at .latexmkrc:4; LuaLaTeX branches through `iftex` at preamble/pdfA-compliance/glyphtounicode.tex:30-35); the sample needs `--shell-escape` for the Inkscape export (.latexmkrc:12) and TeX Live 2025 or newer (README.md:104)
- Look carried by: preamble (no zip-local .cls/.sty; `\documentclass{report}` at thesis.tex:13 plus about 50 `\input` preamble files listed at preamble/main.tex:4-56)
- Class origin: tex-distribution-unbundled
- Main file: thesis.tex (other samples: none; chapters/*.tex and frontmatter/*.tex are the `\include`d bodies)
- Read: main yes, zip-local classes and styles none present

## Verdict
`no`. The class is the kernel `report` and most components map to lib ways, but the template's identity sits in preamble code that is not declarative: a TikZ-drawn faded header rule, TikZ continuation marks in the remark boxes, and TikZ-drawn math symbols (ART); rewrites of kernel, amsthm, hyperref, floatrow and biblatex internals, a hook-driven math-version switch, a box-measuring helper layer and shared counters made with `\let` (BESPOKE); and an Inkscape export through shell escape, called by the sample (EXTERNAL). Several of the hacks carry the "look" the manual advertises (big letter behind chapter titles, boxed citations, back-reference links), so none can be dropped.

## Blockers
- `ART/preamble` header rule drawn with TikZ into saved boxes, path fading `west` and open Diamond arrow tips, installed as `\headrule` (preamble/layout/headers.tex:17-41,45,59)
- `ART/preamble` remark-box continuation marks drawn with `\draw` arcs and arrow tips in tcolorbox `overlay first/middle/last` (preamble/environments/remark-like.tex:17-26)
- `ART/preamble` TikZ-drawn notation symbols used by the sample: `\argument` dashed node in a saved box (preamble/math/macros.tex:232-245, used chapters/Notation.tex:31), `\longleadsto` with snake decoration (macros.tex:247-264, used chapters/Design.tex:10), `\correspondsto` (macros.tex:266-275), `\cancel` (macros.tex:290-302)
- `BESPOKE/preamble` chapter heading: `\@makechapterhead` and `\@makeschapterhead` replaced by `\chaphead`, a 95pt raised zero-width letter box, and expl3 `\ExtractLeadingChars` that takes the first token of an unnumbered title (preamble/layout/titles.tex:27-63)
- `BESPOKE/preamble` amsthm `\equation@qed` rewritten with `\ialign`, `\alt@tag`, `\iftagsleft@` (preamble/hacks/fix-qed.tex:5-23)
- `BESPOKE/preamble` hyperref `\__hyp_target_raise:n` undefined and redefined in expl3 when hyperref is older than 2025-05-20 (preamble/hacks/fix-hyperref.tex:6-32)
- `BESPOKE/preamble` `\@arrayparboxrestore` redefined (the `\everypar{}` line dropped) so floatrow captions keep paragraph spacing (preamble/hacks/floatrow-parskip.tex:10-37)
- `BESPOKE/preamble` hook-driven automatic switching of math versions with `\newif\ifInSansMode/\ifInBoldMode` on `cmd/sffamily/after`, `cmd/rmfamily/after`, `cmd/bfseries/after`, `cmd/mdseries/after` (preamble/math/fonts.tex:38-43)
- `BESPOKE/preamble` `\left`, `\right`, `\middle` re-implemented with `\bgroup` and `\aftergroup\egroup` (preamble/math/macros.tex:195-201)
- `BESPOKE/preamble` box-measuring helpers `\mathsettowidth` (`\mathpalette`, `\setbox`), `\halfhphantom`, `\lhphantom`, `\chphantom`, `\rhphantom` (preamble/math/spacing.tex:6-46; used preamble/math/macros.tex:121 and chapters/Tips.tex:75)
- `BESPOKE/preamble` biblatex bibmacro rewrites with new logic: `cite` and `postnote` (preamble/references/cite.tex:8-20,27-32), `pageref` (preamble/references/backref.tex:12-16), `doi+eprint+url` with `\ifboolexpr` and new `github`/`gitlab` fields (preamble/references/doi-eprint-url.tex:14-36), and a copy of biblatex's `pageref` list format using internals `\abx@pagerefstyle`, `pageref:init/comp/dump` (preamble/hacks/custom-reference-boxes.tex:76-91)
- `BESPOKE/preamble` figures, tables and equations made to share one counter by `\let\c@figure\c@table` and `\let\c@equation\c@table` (preamble/general/floats.tex:4-7); `num.counters` names no shared-counter command
- `EXTERNAL/preamble` `\exportInkscapeSVG` runs `\ShellEscape{...inkscape-export-to-latex}` when the SVG is newer than the PDF (preamble/misc/inkscape.tex:7-12); the script calls `inkscape`, `perl`, `sed`, `uconv` and a Ghostscript watermark (figures/Inkscape/inkscape-export-to-latex:7-28; README.md:109-116); the sample calls it (chapters/Appendix.tex:10,27)

## Class setting
- Class: `class.report` options: `12pt`, `a4paper` (alternative commented line adds `openright`, `twoside`, thesis.tex:13-14)
- Class-native vocabulary used: `\chapter`, `\chapter*`, `\section`, `\subsection`, `\paragraph`, `\part`, `\appendix`, `\tableofcontents`, `\cleardoublepage`, `\markboth`, `\leftmark`, `\rightmark`; `\frontmatter`, `\mainmatter`, `\backmatter` are not in `report`, the template defines them (preamble/layout/numbering.tex:3-18); `\@makechapterhead` is replaced (titles.tex:42-43, the comment says it modifies report.cls); the sample has no `abstract` environment and no `\maketitle`

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | thesis.tex:13 | `class.report` | 12pt, a4paper |
| PDF/A switch | thesis.tex:8-9 | `meta.documentmetadata` | `\RequirePackage{pdfmanagement}`, `\SetKeys[document/metadata]{pdfversion=1.7, pdfstandard=A-2u}` (the same keys as `\DocumentMetadata`) |
| glyph to Unicode | thesis.tex:10; preamble/pdfA-compliance/glyphtounicode.tex:38,42,50-70 | `meta.glyphtounicode` | `\input{glyphtounicode-cmr.tex}` (file of the `pdfx` distribution, not in the zip), 19 `\pdfglyphtounicode` maps; `\pdfinclusioncopyfonts=1` is another pdfTeX primitive of this type (a widening of the line is suggested, no new way) |
| engine switches | glyphtounicode.tex:30-35; preamble/general/typesetting.tex:3-5 | `font.fontenc-t1` | `\ifpdftex` loads `[T1]{fontenc}`; the LuaLaTeX branch (`luatex85`, `\pdfgentounicode=1`) is not taken under pdfTeX |
| page geometry | preamble/layout/geometry.tex:4,10-19 | `page.geometry` | width=145mm, height=250mm, hmarginratio=1:1, vmarginratio=3:4, includehead, headheight=2.5em, headsep=0mm |
| binding offset | geometry.tex:5-9 | `page.geometry` | `\Gm@bindingoffset`=15mm when `twoside` (same effect as `bindingoffset=15mm`) |
| WIP extra margin (off in sample, thesis.tex:21) | geometry.tex:20-34 | `page.geometry`, `art.pstricks` | paperwidth=260mm, layoutwidth=210mm; a pict2e `\line` in the `shipout/background` hook (a draft aid) |
| flush bottom | geometry.tex:37 | `pg.flush` | `\flushbottom` |
| running heads | preamble/layout/headers.tex:2,44-62 | `hf.fancyhdr` | `\fancypagestyle{header}`: `\fancyhead[LO]`, `[RE]` HeaderColor sans `\nouppercase{\leftmark}`/`\rightmark`, `[RO]`, `[LE]` bold page; `\fancyfoot{}`; `plain` based on `header`; `\pagestyle{header}`; `\headrulewidth`=0.9pt (:16) |
| WIP footer | headers.tex:52-54; thesis.tex:20 | `hf.fancyhdr` | `\fancyfoot[C]` "Draft - \today", black!15 `\ttfamily` (WIP on in the sample) |
| header rule | headers.tex:17-41,45,59 | `art.tikz` (ART) | see Blockers |
| page numbering and matter | preamble/layout/numbering.tex:3-18; thesis.tex:48,60,66,69; chapters/Notation.tex:1 | `pgnum.pagenumbering`, `num.counters`, `pg.break`, `num.appendix` | `\pagenumbering{roman}` then `{arabic}`, `\gdef\thechapter{\@Alph\c@chapter}` then `\@arabic`, `\cleardoublepage`, `\setcounter{chapter}{13}`, `\bookmarksetup{startatroot}` |
| line spread | typesetting.tex:10 | `sp.linespread` | 1.05 |
| paragraphs | typesetting.tex:26 | `sp.parskip-pkg` | no options |
| micro-typography | typesetting.tex:24-25 | `sp.microtype` | `\DisableLigatures[-]{family=tt*}` |
| text fonts | typesetting.tex:6 | `font.lmodern` | Latin Modern |
| extra LM faces, emphasis | typesetting.tex:16-19,22 | `font.nfss`, `mark.kernel` | `\fontseries{sbc}`, `\fontfamily{lmssq}`, `\DeclareTextFontCommand`, `\DeclareEmphSequence{\slshape,\itshape}` |
| roman numerals with bars | typesetting.tex:7; layout/titles.tex:21 | `mark.romanbar` | `\usepackage{romanbar}`, `\Romanbar{\thepart}` |
| quotation | typesetting.tex:27; chapters/Features.tex:236 | `lang.csquotes` | `\enquote`, `displayquote` |
| lists | typesetting.tex:30-33 | `list.paralist`, `list.kernel` | alwaysadjust, neverdecrease; `\setdefaultleftmargin{1.87em}{1.7em}{1.5em}{1em}{1em}{1em}`, `\setdefaultitem`, `\setdefaultenum{\bfseries (1)}{\bfseries (a)}{\bfseries (i)}{A.}` |
| colours | preamble/general/colors.tex:2-21 | `color.xcolor`, `tbl.colortbl` | `[rgb,table]`; 15 named colours (ChapterNumberColor gray 0.88, HeaderColor 0.35, UrlColor, CiteColor, Gray10 to Gray90, LightGrayFill) |
| headings (section to part) | preamble/layout/titles.tex:10,14-22 | `head.titlesec` | `[newparttoc, clearempty]`; `\titleformat` section `\Large\sffamily\bfseries`, subsection `\large`, paragraph `[runin]`, part `[display]` with 30pt/36pt title and `\Romanbar{\thepart}` |
| chapter heading | titles.tex:27-63 | BESPOKE (see Blockers) | `\@makechapterhead` replaced; letter in ChapterNumberColor, `\usefont{T1}{qzc}{m}{it}` 95pt |
| unnumbered chapter | titles.tex:2-6 | `head.kernel`, `toc.kernel` | `\chapter*` + `\markboth` + `\addcontentsline{toc}{chapter}` |
| numbering depth | preamble/layout/toc.tex:25-26 | `num.secnumdepth` | secnumdepth=1, tocdepth=2 |
| contents | toc.tex:3-19,22-23,27 | `toc.kernel`, `toc.titletoc`, `toc.etoc` | `\tableofcontents` under `\hypersetup{hidelinks}`; `titletoc`, `tocbibind`; `\contentsmargin[0.6em]{2em}` |
| contents entries | toc.tex:34-52 | `toc.titletoc` | `\titlecontents` chapter `[1.6em]`, section `[4.0em]` with `\titlerule*[9pt]{.}`, `\titlecontents*` subsection `[4.7em]` inline with `\textbullet` separators, part centred without page |
| title page | frontmatter/title.tex:1-61 | `front.titlepage-env`, `fig.adjustbox`, `fig.graphicx`, `tbl.tabular`, `mark.case`, `sp.manual-space`, `font.size-commands` | hand-laid `center`; `adjustbox{center,trim=0 0.2cm 4cm 0.2cm}` around MFF-logo.pdf at 1.4\textwidth; `\vfill`; 30pt/36pt title; supervisor `tabular{>{\sffamily\color{Gray40}}r @{\hspace{1.0em}} l}`; `\ifdef` rows for optional fields (:40,43,53) |
| declaration page (commented out, thesis.tex:50) | frontmatter/declaration.tex:4-23 | `front.dedication`, `tbl.booktabs`, `tbl.colortbl`, `head.kernel` | `\subsection*`, `\cmidrule`, `\arrayrulecolor{Gray70}`; column type `W{c}{0.32\linewidth}` (:16) is not defined in the zip (no `\newcolumntype`), its package was not identified |
| dedication (commented out, thesis.tex:51) | frontmatter/dedication.tex:1-13 | `front.dedication` | `\slshape`, `flushright`, `\vfill` |
| information and abstract page (commented out, thesis.tex:52) | frontmatter/information.tex:7-31 | `front.dedication`, `tbl.nicematrix`, `toc.kernel` | `tblr{colspec={r X}, column{1}={font=\small\sffamily\color{Gray40}}}`; abstract is a `\subsection*` with `\Abstract` (no `abstract` environment) |
| document data | preamble/data.tex:2-63 | content macros | `\ThesisType`, `\ThesisTitle`, `\ThesisAuthor`, `\Department`, `\Supervisor`, `\Abstract`, `\Keywords`, plaintext variants for metadata |
| graphics | preamble/general/floats.tex:10-15 | `fig.graphicx` | `\graphicspath{{./figures/}{./figures/Inkscape/}{./frontmatter/img/}}` |
| float containers | floats.tex:47-56; chapters/Appendix.tex:11,26,30; chapters/Usage.tex:6 | `fig.floatrow` | `\floatsetup{footnoterule=none, footposition=bottom}`, `[figure]{capbesideposition=right, capbesidesep=quad}`; `\fcapside[\FBwidth]`, `\ffigbox`, `\floatfoot` |
| captions | floats.tex:65-80,90-97,121 | `cap.caption`, `fig.subcaption`, `num.counters` | format=plain, indention=0.6em, font=small, labelfont={sf,bf}, labelsep=slash (`\hspace{0.25em}/\hspace{0.25em}`), tableposition=bottom, parskip=.3\baselineskip plus 1pt; floatfoot font `\scriptsize\color{Gray60}\sffamily\raggedleft`; `\theContinuedFloat` alph |
| float foot rule | floats.tex:82-88 | `fig.floatrow`, `sp.rule` | `\floatfootskip` = 2pt, Gray50 `\hrulefill` indented by `\caption@indent` (equals indention=0.6em) |
| shared float counters | floats.tex:4-7 | BESPOKE (see Blockers) | figure, table, equation share one counter |
| tables | floats.tex:25-30,40-42; chapters/Tips.tex:125-140 | `fig.adjustbox`, `tbl.tabular`, `tbl.booktabs`, `tbl.nicematrix` | `\arraystretch` 1.1; `tabularray` with `\UseTblrLibrary{amsmath, booktabs, siunitx}`; `booktabs` environment `stretch=1.1`; `ninecolors` loaded for tabularray under a version test (:32-38) |
| verbatim inside arguments | floats.tex:41; preamble/misc/packages-macros.tex:54,56 | `code.verbatim` | `codehigh` loaded for `\fakeverb` (source not read) |
| links and metadata | preamble/general/hyperref.tex:2-4,18-36 | `meta.url`, `meta.hyperref`, `meta.bookmark` | `url[allowmove]`; hyperref linktoc=all, colorlinks=true, urlcolor, pdfborder={0 0 0}, pdflinkmargin=1.0pt, pdfdisplaydoctitle, pdfauthor/title/subject/keywords/creator; `\bookmarksetup{numbered, open, openlevel=1}` |
| cross-references | hyperref.tex:6-11; preamble/hacks/custom-reference-boxes.tex:46-66 | `xref.zref`, `xref.hyperref`, `box.tcolorbox`, `mark.kernel` | `zref-clever` `\zcsetup{cap, noabbrev}`, `zref-titleref`; `\Cref` and `\Nref` = `\hyperref[..]{\refbox{\zcref*..\textsuperscript{\ttfamily\tiny\(\to\)p.\zpageref}}}` |
| link boxes | custom-reference-boxes.tex:6-41; preamble/misc/packages-macros.tex:5-26 | `box.tcolorbox` | `\tcbset{link/.style={nobeforeafter, box align=base, boxsep=0em, arc=0.1em, boxrule=0.3mm, ...}}`, `\NewTCBox{\refbox}{\pagebox}{\hrefbox}{\citebox}{\packagebox}{\filebox}{\dirbox}{\macrobox}`; `\href` and `\url` redefined to wrap `\hrefbox` (:40-41) |
| margin file tags | packages-macros.tex:34-51 | `note.marginpar`, `box.tcolorbox`, `sp.manual-space` | `\marginpar{\vspace{#1}\hspace{-\marginparsep}\llap{\filebox{#2}}}` |
| documentation macros | packages-macros.tex:28-33,53-56; preamble/misc/macros.tex:2-17 | `code.verbatim`, `box.tcolorbox`, `meta.hyperref`, `mark.kernel` | `\package`, `\macro` (`v` argument), `\custommacro`, `\grayenclose` (gray delimiters by mode) |
| theorem-like boxes | preamble/environments/init.tex:2,6,10-29; theorem-like.tex:4-20 | `thm.thmtools`, `thm.amsthm`, `box.tcolorbox` | `\newkeytheoremstyle{thmcommon}{headfont=\bfseries\sffamily, notefont=\mdseries\sffamily, bodyfont=\normalfont, headpunct={\strut.}}`; `\declarekeytheorem{..}[sibling=table, style=thmcommon, qed=\theoremqed, tcolorbox-no-titlebar={parbox=false, breakable}]` for definition, theorem, lemma, corollary, proposition; tcolorbox skins, breakable, theorems; `boxrule=0.4pt, arc=3pt, left/right=0.9em` |
| remark-like boxes | remark-like.tex:5-34 | `thm.thmtools`, `box.tcolorbox` | `blanker`, `breakable`, `parbox=false`; qed `\(\lrcorner\)` black!60; remark, example, derivation, calculation, idea, tip; continuation marks are ART (see Blockers) |
| proof | remark-like.tex:42-52; init.tex:34-42 | `thm.amsthm`, `thm.thmtools`, `art.content-package` | `\let\proof\relax` then remark-like `proof`, `proofidea` with `numbered=no`; end mark is a gray ytableau box (`\square` redefined to `\ydiagram`, macros.tex:206-216) that a framed square would replace; `\qedhere` wrapper sets `\qedshift` 0.6ex, 1.5ex starred, or the optional value |
| qed on tagged display | hacks/fix-qed.tex:5-23 | BESPOKE (see Blockers) | amsthm `\equation@qed` replaced |
| reference type names | init.tex:46-51; theorem-like.tex:23-26 | `xref.zref` | `\zcRefTypeSetup{..}{name-sg, Name-sg, name-pl, Name-pl}` |
| todo-like boxes | environments/todo-like.tex:4-31 | `box.tcolorbox` | `\NewTColorBox`: breakable, colframe=pink, `leftrule=4pt`, `boxrule=0pt`, colback pink!20, orange!10, cyan!10, cyan!50!green!10; inline `\todo` in red sans |
| math packages | preamble/math/packages.tex:2-14,25-36 | `math.amsmath`, `math.mathtools`, `math.amssymb`, `math.bm`, `math.physics`, `fig.adjustbox`, `mark.siunitx` | amsmath, mathtools, scalerel, amsfonts, amssymb, bm, physics; siunitx `\sisetup{range-phrase={--}, range-units=single, exponent-product={\cdot}, per-mode=symbol, uncertainty-mode=separate}` |
| math fixes and delimiter sets | packages.tex:17-19,39-42,56 | `math.mathfixs`, `math.mathtools`, `math.physics` | `\ProvideMathFix{greekcaps=it}`, `{frac,rfrac,vfrac,vfracskippre=4mu}`; `delimset[extdef]` (`\brk` used at chapters/Tips.tex:74); `tensind` `\tensordelimiter{@}`, `\tensorformat{c}` |
| math fonts | preamble/math/fonts.tex:4-35,50-65 | `font.nfss` | `\SetMathAlphabet{\mathsf}{bold}`, `\DeclareMathAlphabet{\mathsfit}`, `\DeclareMathVersion{sans}` and `{boldsans}` with `\SetSymbolFont` (cmbr, cmbrm, cmbrs, iwona), `\DeclareMathAlphabet{\mathpzc}`, `\DeclareMathDelimiter` for stmaryrd brackets; fonts are not in the zip |
| math version switch | fonts.tex:38-43 | BESPOKE (see Blockers) | hooks on font-family and series commands |
| math spacing | preamble/math/packages.tex:48-54; macros.tex:195-204 | `math.amsmath` | `\.` and `\'` as `\TextOrMath`, `\colon` hook `\mspace{-2mu}`, `\setminus` `\mathord`; `\left/\right/\middle` is BESPOKE |
| math notation macros | macros.tex:4-190,206-228,277-287 | `math.amsmath`, `math.bm`, `fig.adjustbox` | `\DeclareMathOperator`, `\NewDocumentCommand` aliases, `\scalerel`-based `\Ext`, `\Odot`, `\sbullet`; each is an alias or composition |
| math notation drawn with TikZ | macros.tex:232-275,290-302; preamble/misc/tikz.tex:30-59 | `art.tikz` (ART) | see Blockers |
| bibliography | preamble/references/biblatex.tex:2-8,14,16-37,42-48 | `bib.biblatex-biber` | `style=ext-numeric-verb` (biblatex-ext), sorting=none, date=year, articlein=false, isbn=false, maxnames=16, maxcitenames=4, backref=true, backrefstyle=none, datamodel file; `\defbibheading`, `\defbibnote`, `\printbibliography[heading, title=References, prenote=note]`, categories `todo`, `secondary`; `biber --validate-datamodel` (.latexmkrc:16) |
| bibliography formats | references/style.tex:4-5,9,14-17,23-24,27,30,41-43; references/fields.tex:6-26,29-43; biblatex-extra-fields.dbx:2-6 | `bib.biblatex-biber` | `\setlength\bibitemsep`, `\DeclareFieldFormat`, `\DeclareDelimFormat`, `\DeclareSourcemap` (drop url when doi, ignore fields), `\DefineBibliographyStrings`, `\DeclareDatamodelFields{github}`; all biblatex's declarative interface |
| bibliography macro rewrites | cite.tex:8-20,27-32; backref.tex:12-16; doi-eprint-url.tex:14-36; custom-reference-boxes.tex:76-91 | BESPOKE (see Blockers) | `\renewbibmacro*` bodies |
| censoring | preamble/debug/commands.tex:18-23; chapters/Features.tex:472 | `mark.censor` | `\usepackage{censor}`, `\StopCensoring` unless `\CENSORtrue` (on, thesis.tex:23) |
| draft aids | debug/line-numbers.tex:1,7-13; debug/commands.tex:10-12 | `sp.draft-lineno`, `sp.lengths` | `lineno[pagewise]` (off by default); `\overfullrule=1mm` under WIP |
| partial builds | debug/commands.tex:3-7; thesis.tex:30-44,49-70 | `struct.input` | `\includeonly` through `\includeonlysmart` (all entries commented out); `\input`, `\include` |
| Inkscape figures | misc/inkscape.tex:5-19; chapters/Appendix.tex:10,27 | `fig.svg` (EXTERNAL) | `\exportInkscapeSVG`, `\includeInkscapeSVG` (alias `\includesvg`), `\svgwidth`, `.pdf_tex` input |
| TeX logos | preamble/user/macros.tex:6 | `font.icons` | `hologo` |
| warning filters | debug/silence.tex:1-28; headers.tex:6-8; math/fonts.tex:70-78 | none (no printed effect) | `silence[debrief]` filters, `\f@nch@fancyhf@Echeck` and `\@font@info` rewrites silence log lines only, not a component |
| display math, equations | chapters/Appendix.tex:73-76,85-87; chapters/Tips.tex:87-102 | `math.amsmath`, `math.mathtools` | `equation`, `alignedat`, `dcases`, `\eqref`, `\qedhere` |
| front/main/back structure | thesis.tex:48-72 | `struct.input`, `pg.break` | `\frontmatter`, `\contentsandlists` (toc.tex:3-19), `\mainmatter`, `\backmatter`, `\appendix`, `\references` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| toggles `\ifFANCY \ifWIP \ifEXTRAMARGIN \ifLINKBOXES \ifCENSOR \ifDebugLineNumbers` | preamble/toggles.tex:3-10; thesis.tex:20,23; line-numbers.tex:3 | yes | each is a build-time constant; the emitter writes the chosen branch (sample: FANCY true, WIP true, EXTRAMARGIN false, LINKBOXES true, CENSOR true) |
| data and doc macros (`\ThesisTitle`..., `\package`, `\macro`, `\fileTeXtured`, `\grayenclose`, `\todo`) | preamble/data.tex:2-63; packages-macros.tex:28-56; macros.tex:2-17; todo-like.tex:4-9 | yes | content strings and compositions of `box.tcolorbox`, `code.verbatim`, `note.marginpar`, `sp.manual-space`, written inline at each use |
| `\NewTheoremLike(s)`, `\NewRemarkLike(s)`, `\NewTodoLike`, `\declareCleverTypeName` | theorem-like.tex:7-20; remark-like.tex:8-34; todo-like.tex:23-31; init.tex:46-51 | yes | unroll the lists into one `\declarekeytheorem[...]` / `\NewTColorBox` / `\zcRefTypeSetup` per environment |
| `\Cref`, `\Nref`, `\refbox`..., `\href`/`\url` wrappers, `\pagelink` | custom-reference-boxes.tex:23-26,36-41,46-66,74 | yes | `\hyperref[l]{\tcbox[..]{\zcref*..}}` expanded at each reference, tcolorbox styles in `\tcbset` |
| `\qedhere` wrapper, `\theoremqed`, `\remarkqed`, `\proofqed` | init.tex:34-42; theorem-like.tex:4; remark-like.tex:5,42-47 | yes, but it depends on the `\equation@qed` rewrite below | literal `\raisebox{-0.6ex}` per use, `\hspace{-1.195em}\strut` marks |
| `\frontmatter`, `\mainmatter`, `\backmatter`, `\chapternotnumbered`, `\contentsandlists` | numbering.tex:3-18; titles.tex:2-6; toc.tex:3-19 | yes | kernel commands in sequence (`\pagenumbering`, `\gdef\thechapter`, `\cleardoublepage`, `\chapter*`, `\markboth`, `\addcontentsline`) |
| `\appendtographicspath` (expl3, never called) | floats.tex:17-22 | yes | unused, drop |
| `\f@nch@fancyhf@Echeck`, `\@font@info` rewrites, `silence` filters | headers.tex:7; fonts.tex:70-78; silence.tex:1-28 | yes | log messages only, no printed effect |
| `\renewcommand\epsilon`, `\chi`, `\delta`, math alias commands, `\DeclareMathOperator` list | macros.tex:36-190 | yes | aliases and `math.amsmath` declarations |
| `\argument`, `\longleadsto`, `\correspondsto`, `\cancel`, header-rule boxes, remark overlays | macros.tex:232-302; headers.tex:17-41; remark-like.tex:17-26 | no | TikZ drawings, ART |
| `\chaphead`, `\ExtractLeadingChars`, `\@makechapterhead` | titles.tex:27-63 | no | kernel replacement plus expl3 first-token extraction that decides which letter is printed |
| `\equation@qed`, `\__hyp_target_raise:n`, `\@arrayparboxrestore` | fix-qed.tex:5-23; fix-hyperref.tex:6-32; floatrow-parskip.tex:10-37 | no | copies of package internals with edits |
| math version hooks | fonts.tex:38-43 | no | hand-rolled conditionals that decide which math version prints |
| `\left`, `\right`, `\middle` replacement | macros.tex:195-201 | no | group-matching trick on kernel internals |
| `\mathsettowidth`, `\halfhphantom`, `\chphantom` and kin | spacing.tex:6-46 | no | box measurement and halving of widths |
| biblatex `\renewbibmacro*` bodies, copied `pageref` list format | cite.tex:8-32; backref.tex:12-16; doi-eprint-url.tex:14-36; custom-reference-boxes.tex:76-91 | no | conditional logic and internals of biblatex; no lib way holds it |
| `\let\c@figure\c@table`, `\let\c@equation\c@table` | floats.tex:4-7 | no | no lib command shares a counter between environments |
| `\exportInkscapeSVG`, `\includeInkscapeSVG`, shell script, watermark | inkscape.tex:5-19; figures/Inkscape/inkscape-export-to-latex:1-31 | no | EXTERNAL toolchain; the `svg` package (`fig.svg`) is also EXTERNAL and does not do the PDF/A or watermark steps |

## Content-opaque
- TikZ `dirtree` file-tree pictures inside figures (chapters/Usage.tex:23-43; chapters/Features.tex:34-109; style at preamble/misc/tikz.tex:15-26)
- Included artwork: MFF-logo.pdf (frontmatter/title.tex:5), the Inkscape capacitor figure (chapters/Appendix.tex:20-22,27), `example-image-a`/`example-image-b` (chapters/Appendix.tex:33,44)
- The multi-line equation with `dcases` (chapters/Tips.tex:87-102)
- Bibliography data (preamble/bibliography.bib, 7 entries)

## Lib changes
- New ways proposed:
  - `thm.thmtools` `keytheorems` (CTAN page read: expl3 key-value interface to amsthm, LPPL 1.3c, in TeX Live; v0.4.2), engine pdf. W1 CTAN; W2 `\declarekeytheorem[sibling, style, qed, name, numbered, tcolorbox-no-titlebar]` and `\newkeytheoremstyle` take keys, strings, lengths; W3 any theorem-like statement; W4 preamble declarations plus the environment. Sibling of `thm.thmtools` (the CTAN text says it covers most of thmtools).
  - `math.mathfixs` `mathfixs` (CTAN page read: Niklas Beisert, LPPL 1.3, v1.2.1 of 2026-04-08, in TeX Live), engine pdf. W1 CTAN; W2 `\ProvideMathFix{greekcaps=it}` and `{frac,rfrac,vfrac,vfracskippre=4mu}` choose fixes by names and a muskip; W3 any maths document; W4 preamble lines.
  - `math.mathtools` `delimset` (CTAN page read: Niklas Beisert, LPPL 1.3, in TeX Live), engine pdf. W1 CTAN; W2 `[extdef]` option and declared delimiter sets with adjustable size; W3 any maths document; W4 preamble option and body commands (`\brk{..}`, `\fbraces`).
  - `math.physics` `tensind` (tensor index notation; `\tensordelimiter{@}`, `\tensorformat{c}`; ctan.org/pkg/tensind was NOT read because the three-read budget was used, so W1 rests on the package being published and in TeX Live from memory); engine pdf. W2 delimiter character and format letter; W3 any tensor-notation text; W4 preamble lines and `@..@` body markup. A consolidator should confirm W1 before accepting.
  - `mark.romanbar` `romanbar` (Roman numerals with bars, `\Romanbar{n}`; ctan.org/pkg/romanbar was NOT read, W1 from memory, to be confirmed); engine pdf. W2 the argument is a number or counter value; W3 any numbering; W4 inline wrapper (here around `\thepart`). Same type as `mark.nth` and `mark.numspell`.
- Considered, not proposed: `silence` (log filters with no printed effect, as the rejected `sys.compat-load`), `codehigh` (mapped to `code.verbatim` for `\fakeverb`, source not read), `ytableau` (mapped to `art.content-package`), `ninecolors`/`filemod`/`shellesc` (load-only helpers; `filemod` and `shellesc` belong to the EXTERNAL Inkscape route).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes: `.latexmkrc:34-36` builds the `.aux` directory tree with `find`, `sed`, `xargs` (a build convenience, not part of the template look; not listed as a blocker). `preamble/pdfA-compliance/LaTeX-find-glyph-name/LaTeX-find-glyph-name.tex:25-36` is a stand-alone `article` helper document, not part of the thesis build. figures/Inkscape/add-watermark and watermark-template.ps (Ghostscript PostScript) were not read.
