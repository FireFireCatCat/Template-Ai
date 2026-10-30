no

# 0154-hepthesis: hepthesis (PhD thesis class, with an example HEP thesis)

- Unverified: read from the source, not compiled.
- Source: Source/0154-hepthesis/ (origin: https://mirrors.ctan.org/macros/latex/contrib/hepthesis.zip; licence: LPPL)
- Kind: thesis
- Lib: v3
- Engine: pdfLaTeX-compatible (the example is built with pdflatex and bibtex, example/Makefile:9; the class tests `\pdfoutput`, hepthesis.cls:72, 117; microtype, T1, mathpazo)
- Look carried by: mixed (page, headers, headings, front matter and floats by the published `hepthesis.cls`; font and language by the example preamble; the physics notation layer `abmath`/`abhep`/`abhepexpt` is zip-local, shipped only inside example/extrastyles.zip)
- Class origin: ctan (ctan.org/pkg/hepthesis, v1.5.2, LPPL, `/macros/latex/contrib/hepthesis`; one read)
- Main file: example/example.tex with its `\input` files preamble.tex, frontmatter.tex, chap1.tex, chap2.tex, chap3.tex, appendices.tex, backmatter.tex (other samples: hepthesis.tex, the class manual, `\documentclass{article}`, which is the manifest's "main" but does not use the class; example/mwe.tex, 13 lines)
- Read: main yes, zip-local classes and styles partly (read in full: hepthesis.cls, and from extrastyles.zip with `unzip -p` to stdout: abmath.sty, abhep.sty, abhepexpt.sty; also example/mythesismath.sty. Not read: lineno.sty, SIunits.sty, varwidth.sty, which are bundled copies of CTAN packages (headers only); example/h-physrev.bst, 949 lines, header only)

Line numbers for members of the nested archive are those of the member as printed (`extrastyles.zip!abmath.sty:49`).

## Verdict
The class carries the look and is a published CTAN class, so the component map below is fully covered by lib ways and `class.hepthesis` needs no proposal. The zip is still `no`: the example loads `abmath`, `abhep` and `abhepexpt` (preamble.tex:19, 43), which are zip-local (ctan.org/pkg/abmath is a 404; the author calls them a personal, unreleased collection, chap1.tex:9-12). `abmath` globally redefines kernel math symbols and every lowercase Greek letter and contains a `\mathchoice`/`\setbox` glyph builder, which no lib way expresses. Sensitivity: if a project counts a personal math-notation package as content rather than template, this zip would be `yes`; it is the sample's notation layer that blocks, not the class.

## Blockers
- `BESPOKE/class` abmath.sty redefines kernel math symbols (`\pm \mp \vert \to \sim \times \bra \ket \braket`, thin spaces added) and all 29 lowercase Greek letter commands through `\let\@old..` and `\renewcommand` so they work in text mode and follow bold or sans context (extrastyles.zip!abmath.sty:49-69, 72-129; `\Re` `\Im` 176-179). Used by the sample: chap1.tex:20, 38-47; chap2.tex:67-69.
- `BESPOKE/class` abmath.sty `\Xint`/`\XXint`: `\mathchoice` over four styles plus `\setbox0=\hbox`, `\vcenter` and `\kern-.5\wd0` build a principal-value integral glyph (extrastyles.zip!abmath.sty:258-267). Defined in a loaded style; the sample never calls `\dashint` or `\ddashint`.

## Class setting
- Class: `class.hepthesis` options: `hyperpdf,bindnopdf` (example/example.tex:9). Under pdfTeX `hyperpdf` turns on hyperref and `bindnopdf` sets the extra binding margin to 0in (hepthesis.cls:71-77, 116-120, 350-358). Defaults the sample relies on: A4 (cls:36, 179-181), 12pt (cls:38, 197-199), two-sided (cls:39, 429-435), `amsmath` and `booktabs` on (cls:29-30). Base class `\LoadClass[chapterprefix]{scrbook}` (cls:218). Other options the class offers: `oneside twoside sftitles rmtitles bind nobind noams alphafoot draft hidefront hideback hidefrontback hyper index titling hep* a4narrow a5paper b5paper letterpaper 10pt 11pt` (cls:52-207); the draft build is commented out at example.tex:2-3.
- Class-native vocabulary used: environments `frontmatter`, `mainmatter`, `appendices`, `backmatter`, `abstract[heading]`, `declaration`, `acknowledgements`, `preface`, `colophon`, `sidewaysfigure`; commands `\title`, `\author` (store `\thetitle`, `\theauthor`), `\titlepage[of ..]{..}`, `\frontquote{}{}`, `\chapterquote{}{}`, `\ChapterRef \SectionRef \FigureRef \PageRef \Table`; length `\largefigwidth` (only in a comment, chap2.tex:15). Defined but unused by the sample: `\dedication`, `\verysubsection`, `\chapterintro`, `\setspacing` and the per-matter spacing and margin setters (cls:504-530, 741-754, 784-806).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | example.tex:9; cls:218 | `class.hepthesis` | base `scrbook[chapterprefix,a4paper,12pt]`; options hyperpdf, bindnopdf |
| paper and size | cls:36-38, 179-181, 197-199 | `page.class-options` | a4paper, 12pt passed to scrbook |
| page geometry | cls:221, 342-347, 349-358 | `page.setlength` | textwidth 6.2in, textheight 9in, topmargin 0in, footskip 0.5in, odd/even margin +/-0.2in only with `bind`; `a4wide` loaded (`page.vmargin`) |
| matter-wise margins | cls:233, 374-391, 540, 557, 568, 584 | `page.adjustwidth` | `adjustwidth` with per-part lengths (abstract 1.5cm, declaration 1cm, others 0cm) |
| line spacing | cls:46-49, 306, 541, 558 | `sp.setspace` | `onehalfspacing` per matter (front, main, appendix, back) |
| paragraph lengths, penalties | cls:124-125, 342-343 | `sp.lengths`, `sp.penalties` | parindent 0.6cm, parskip 0.3cm; clubpenalty and widowpenalty 10000 |
| microtype, encoding | cls:224, 230 | `sp.microtype`, `font.fontenc-t1` | `[T1]`; microtype defaults |
| body font | example.tex:15 | `font.palatino` | `mathpazo` |
| bold typewriter shape | cls:334 | `font.nfss` | `\DeclareFontShape{OT1}{cmtt}{bx}{n}` mapped to cmttb10 |
| language | preamble.tex:9-10; cls:471, 478-488 | `lang.babel`, `lang.csquotes` | `babel[english]`; class loads `csquotes[autostyle]` at end of preamble and sets contents, bibliography and list names (mixed case) |
| running heads and feet | cls:311, 425-450, 454-459 | `hf.class-native` | fancyhdr set by the class: page number and `\leftmark` in bold, 0.5pt head rule, plain style with centred bold folio, `\cleardoublepage` redefined |
| front page set empty | frontmatter.tex:55 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| page numbering | chap1.tex:5; cls:556 | `pgnum.pagenumbering` | `\pagenumbering{arabic}` (also `\afterpage`, `pg.afterpage`) |
| title page | frontmatter.tex:2-3; cls:685-706 | `front.class-native` | `\titlepage[of Churchill College]{A dissertation ...}`; uses `\thetitle`, `\theauthor` |
| abstract | frontmatter.tex:6-10; cls:658-672 | `abs.class-native` | `abstract` env, optional heading, 1.5cm extra margin |
| declaration, acknowledgements, preface | frontmatter.tex:14-24, 28-31, 35-43; cls:595-653 | `front.class-native` | class environments; centred `\LARGE\textbf` headings |
| full-page quote | frontmatter.tex:50-53; cls:712-737 | `class.hepthesis` | `\frontquote{text}{who}`: `varwidth` box and `\enquote` (no component way for it in the lib; class vocabulary) |
| colophon | backmatter.tex:1-3; cls:758-763 | `front.class-native` | `\chapter*{Colophon}` with `\@mkboth` |
| contents and lists | frontmatter.tex:46; backmatter.tex:13-14 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables`; `tocbibind[nottoc]` (cls:314, `toc.etoc`) |
| chapter and section headings | chap1.tex:1, 24; cls:218, 268-270 | `head.class-native` | scrbook `chapterprefix`; `\addtokomafont{sectioning}{\rmfamily\bfseries}` unless `sftitles` |
| heading depth and counters | cls:536-537, 567-571 | `num.secnumdepth`, `num.appendix` | tocdepth 2, secnumdepth 2 in the front matter; `\appendix` inside `appendices` |
| bold maths in titles | appendices.tex:20-25; cls:332 | `head.class-native` | `\g@addto@macro\bfseries{\boldmath}` |
| chapter quote | chap1.tex:14-15; appendices.tex:6-10; cls:767-780 | `class.hepthesis` | `\chapterquote{text}{who}`: `adjustwidth{}{3cm}`, emphasised `\enquote`, em dash, 1cm skip |
| cross references | frontmatter.tex:41-42; chap3.tex:34-38; cls:885-902 | `xref.kernel` | `\label \ref \pageref`; class macros `\ChapterRef` etc. print the word, a tie and `\ref` (`class.hepthesis`) |
| equations | chap1.tex:31-48; chap2.tex:64-73; cls:241-252 | `math.amsmath` | class redefines `equation` and `displaymath` as `align`; `subequations`, `\underbrace`, `pmatrix` |
| math notation macros | preamble.tex:19-20, 39-40; chap1.tex:20, 38-47 | blocked, see Blockers | `abmath` (zip-local); `\parenths \colvector \twomatrix \pdByd \boldmatrix \SUgroup \I \about` |
| bold or roman math wrapper | preamble.tex:20; extrastyles.zip!abmath.sty:2 | `math.bm` | `maybemath` (CTAN): `\maybebmsf`, `\mayberm`; the package is the parameter |
| script letters | preamble.tex:4 | `math.bm` | `mathrsfs` |
| Dirac notation, slashes | extrastyles.zip!abmath.sty:3; abhep.sty:3-4 | `math.physics` | `braket`, `cancel`, `amsmath` |
| particle names and units | preamble.tex:43-45; frontmatter.tex:9; chap1.tex:29; chap2.tex:11 | `art.content-package`, `mark.siunitx` | `hepnames` (CTAN, named in hepthesis.tex:885), `hepnicenames` (abhep.sty:6, CTAN status not checked); `\unit{14}{\TeV}` from `hepunits` over `SIunits` (a units package; the package is the parameter) |
| hyperlinks and PDF metadata | example.tex:32-40; cls:116-120, 492 | `meta.hyperref` | class loads `hyperref[colorlinks=true,bookmarks=true,plainpages=false]`; `\hypersetup{pdftitle,pdfsubject,pdfkeywords,pdfauthor}` |
| tables | chap2.tex:82-92; cls:278-294, 364, 809-819 | `tbl.tabular`, `tbl.booktabs` | class wraps `tabular` as `@{}..@{}` with `\toprule` and `\bottomrule`; `\midrule`; `\arraystretch` 1.25; `table` env centred, 0.4cm above |
| figures | chap2.tex:42-49; cls:320, 822-855 | `fig.graphicx`, `fig.rotating` | `sidewaysfigure` with `\includegraphics[width=0.8\textheight]`; class centres figure, figure*, sidewaysfigure |
| sub-figures, continued floats | chap3.tex:14-30; preamble.tex:3 | `fig.subcaption`, `cap.caption` | `subfig` `\subfloat[][label]`; `\ContinuedFloat` (from `caption`) |
| float capacity, post-page hook | preamble.tex:3; cls:327 | `fig.placement`, `pg.afterpage` | `morefloats` (load-only; the float-queue limit, nearest home is the float-flow line); `afterpage` |
| float parameters | cls:361-363 | `fig.placement` | topfraction .95, bottomfraction .95, textfraction .05 |
| captions | chap2.tex:90; cls:324 | `cap.caption` | `format=hang,labelfont=bf,labelsep=colon,font=small` |
| manual spacing, centring | chap2.tex:31-37 | `sp.manual-space` | `\vspace{1cm}`, `\hspace`, `center` with `\vdots` |
| verbatim package | preamble.tex:5 | `code.verbatim` | `verbatim` (load only; the class's `comment` package, cls:317, is the same kind) |
| bibliography | backmatter.tex:8-9; chap1.tex:22 | `bib.bibtex-bst`, `bib.cite-pkg` | `\bibliographystyle{h-physrev}` (shipped .bst, an arXiv-style eprint-aware style, backmatter.tex:5-6), `\bibliography{mythesis}`; `cite` package (preamble.tex:13) |
| index (optional) | cls:135, 256; backmatter.tex:19 | `idx.makeidx` | option `index`; `\printindex` commented out |
| draft mode (optional) | cls:91-97, 300-303 | `sp.draft-lineno`, `bg.watermark` | `lineno[pagewise,mathlines]`, `draftcopy`; not chosen in the example |
| manual hepthesis.tex: class and packages | hepthesis.tex:1-12 | `class.article`, `font.palatino`, `sp.setspace`, `meta.hyperref`, `meta.url` | `article[12pt]`, `mathpazo`, `\onehalfspacing`, `hyperref[colorlinks,bookmarks]`, `url`, `a4wide` (`page.vmargin`), `relsize`, `underscore` (`font.fontenc-t1`) |
| manual: code and boxes | hepthesis.tex:10, 33-38, 709-712 | `code.verbatim`, `box.fancybox`, `box.minipage` | `fancyvrb` `Verbatim`, `\DefineShortVerb`, `\VerbatimInput`; `fsnippet` = `Sbox` + `minipage` + `\fbox`, `\fboxsep` 12pt |
| manual: bibliography | hepthesis.tex:861-895 | `bib.thebibliography` | hand-written `thebibliography{99}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `hepthesis.cls` itself, including its redefinitions of `equation`, `tabular`, `figure`, `\cleardoublepage`, `\titlepage` | hepthesis.cls:244-251, 284-291, 454-459, 687-706, 824-831 | n/a (published class, W1) | `class.hepthesis` with options |
| preamble macros (`\LHCb`, `\BToKPi`, `\Rate`, `\epluseminus`...) | preamble.tex:20, 39-40, 46-70 | yes | `\DeclareRobustCommand` aliases over `hepnames` and `abmath` commands; inline expansion |
| `\X`, `\Xbar` call `\thesismath`, which only the unloaded mythesismath.sty defines | preamble.tex:65-66 | yes | aliases, never called by the sample; latent undefined macro |
| hyperref guard | example.tex:32-40 | yes | `meta.hyperref`: `\hypersetup{...}` inside `\@ifpackageloaded`; hyperref is loaded by the class option |
| `\circleimg` | chap3.tex:8-12 | yes | alias of a `art.tikz` circle, figure content |
| abmath aliases and operators (`\parenths`, `\colvector`, `\SUgroup`, `\diag`...) | extrastyles.zip!abmath.sty:8-47, 132-256 | yes | `\left..\right`, `pmatrix`, `\DeclareMathOperator` in `math.amsmath`, `math.bm` wrappers; inline per use |
| abmath kernel-symbol and Greek redefinitions | extrastyles.zip!abmath.sty:49-69, 72-129, 176-179 | no | global behaviour change of kernel commands (text-mode use, context-bold, added thin spaces); no lib way, would need the copied `\let`/`\renewcommand` code |
| abmath `\Xint`, `\XXint` | extrastyles.zip!abmath.sty:258-267 | no | box-and-glue algorithm (`\mathchoice`, `\setbox`, `\vcenter`, `\kern`) |
| abhep and abhepexpt aliases | extrastyles.zip!abhep.sty:13-184; abhepexpt.sty:6-64 | yes | text and math abbreviations, `\providecommand`, `\xspace`; inline |
| abhep `\Amplitude`, `\BR`, `\efficiency`; abhepexpt `\Geant` | extrastyles.zip!abhep.sty:27-34, 65-77; abhepexpt.sty:52 | yes | empty-argument test resolved at each call site; none is called by the sample |
| abhep `\CKMPairWidth` | extrastyles.zip!abhep.sty:156-159 | yes | kernel `\settowidth` and `\makebox`; not called by the sample |
| mythesismath.sty (`\ProvidesPackage{thesismath}`) | example/mythesismath.sty:1-69 | yes | same aliases as abmath; loaded by nothing (only the root Makefile:14 copies it) |
| h-physrev.bst | example/h-physrev.bst:1-30 (header), 68 `FUNCTION`s | yes | a BibTeX style file is the parameter of `bib.bibtex-bst`; provenance not verified, body not read |
| example/Makefile, getNewBibtex | example/Makefile:1-17; example/getNewBibtex:15 | yes | build only: `unzip` places the styles, then pdflatex, bibtex, pdflatex twice; `getNewBibtex` mails a SLAC service to fetch .bib data, not on the compile path (mythesis.bib is shipped), so not `EXTERNAL` |

## Content-opaque
- TikZ circles inside figure floats: chap3.tex:8-12, 15-18, 25-28.
- Included PDF figure in `sidewaysfigure`: chap2.tex:44 (lhcb-detector-cross-section.pdf is shipped); commented-out figure chap2.tex:14-20.
- Equations and particle-physics notation (`hepnames` macros): chap1.tex:31-48, chap2.tex:64-73.
- Bibliography entries: example/mythesis.bib.
- Note for the emitter: `extrastyles.zip` also bundles older copies of `lineno` (v4.41), `SIunits` and `varwidth` (v0.9a); the class requires `varwidth` 2003/03/10 or later (cls:236), so an emitter ships or relies on the CTAN versions.

## Lib changes
- New ways proposed: none. Considered and not proposed: `maybemath` kept under `math.bm`, `SIunits`/`hepunits` under `mark.siunitx`, `hepnames` under `art.content-package`, `morefloats` under `fig.placement` (each a package-is-the-parameter reading of an existing line; a reviewer who reads `morefloats` as having no home would propose a float-capacity way).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
