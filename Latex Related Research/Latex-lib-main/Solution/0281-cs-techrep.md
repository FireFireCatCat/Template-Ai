yes

# 0281-cs-techrep: cs-techrep (technical reports in computer science, IEEE style)

- Unverified: read from the source, not compiled.
- Source: Source/0281-cs-techrep/ (origin: https://mirrors.ctan.org/macros/latex/contrib/cs-techrep.zip; licence: lppl1.3c, COPYING:3-6)
- Kind: report
- Lib: v3
- Engine: pdfLaTeX-compatible (pdfTeX primitives `\pdfgentounicode` at dtx:738-739 and `\pdfoutput=1` at ex:3; `% !TeX program = pdflatex` at dtx:240; biblatex with the biber backend at dtx:545-570)
- Look carried by: class (the look is `cs-techrep.cls`, generated from the unprefixed lines of the `.dtx`, dtx:229-842, on top of IEEEtran; the sample adds data fields, four content packages and an acronym list)
- Class origin: ctan (ctan.org/pkg/cs-techrep: `/macros/latex/contrib/cs-techrep`, v0.9.1, LPPL 1.3c, in TeX Live; the zip is the class's own DocStrip source)
- Main file: template/cs-techrep-example-ctan.tex (other samples: none; `template/cpn_all_all.bib` is bibliography data, `template/cs-techrep-example-ctan.pdf` and `cs-techrep.pdf` were not read). Citation key: `ex:` = template/cs-techrep-example-ctan.tex, `dtx:` = cs-techrep.dtx.
- Read: main yes, zip-local classes and styles all (no `.cls` or `.sty` ships: the class code is the `.dtx` unprefixed lines 232-838, read in full, plus cs-techrep.ins, docstrip.cfg, README, COPYING; the IEEEtran source is published, not bundled and not read; the .bib file was only sampled: entry types counted, first 30 lines read)

## Verdict
yes. The zip is the DocStrip source of `cs-techrep`, a class on CTAN and in TeX Live, so it is one way, `class.cs-techrep`, which loads `class.ieeetran` (dtx:288). An emitter writes `\documentclass[conference,a4paper,flushend]{cs-techrep}`, the class's `\cstechrepSet<Field>` data commands, `\addbibresource` and `\printbibliography`, and copies no macro logic. This is evidence about the class dimension. Everything the sample adds itself (fontawesome icons, `\textsmaller`, `lipsum`, `acronym`, `\hyphenation`, one `forest` tree inside a figure, a `tabularx` table, `\cref`, `\cite`, a `filecontents` bibliography file) maps to lib ways or is figure content. The class's own internal hacks are listed under Bespoke code; they sit inside a published class, so by the pilot ruling they are not counted against the zip.

## Blockers
none

Recorded, not counted: `BESPOKE/class` (irreducible-as-written, inside the published class) `\patchcmd{\@makecaption}` on IEEEtran (dtx:624-628), `\let\blx@rerun@biber\relax` (dtx:577), `\filecontentsForceExpansion` catcode patch (dtx:775-783). See Bespoke code. A `biber` run is the standard biblatex backend, the lib way `bib.biblatex-biber`, not an EXTERNAL blocker. No `minted`, shell escape or Python anywhere (grep of dtx, README, sample found none).

## Class setting
- Class: `class.cs-techrep` options: `conference,a4paper,flushend` (ex:2). Declared options `subfig`, `subcaption`, `pbalance`, `flushend` set marker counters (dtx:249-275); `onecolumn` is refused (dtx:266); every other option goes to IEEEtran (dtx:279-281). Base class: `\LoadClass{IEEEtran}` (dtx:288), tested with the 2015 IEEEtran (dtx:290).
- Class-native vocabulary used: preamble `\cstechrepSetAuthorListTex` `\cstechrepSetAuthorListBib` `\cstechrepSetTitleTex` `\cstechrepSetDepartment` `\cstechrepSetInstitution` `\cstechrepSetAddress` `\cstechrepSetType` `\cstechrepSetYear` `\cstechrepSetMonth` `\cstechrepSetNumber` `\cstechrepSetLang` (ex:12-28, defined dtx:298-316; also `...SetTitleBib` ex:17 commented, dtx:308), getters `\cstechrepAuthorListBib` `\cstechrepTitleBib` `\cstechrepInstitution` `\cstechrepDepartment` `\cstechrepType` `\cstechrepNumber` `\cstechrepYear` `\cstechrepMonth` `\cstechrepLang` (ex:40-47); `\filecontentsForceExpansion|[]` (ex:37, dtx:775); a `filecontents*` file `selfref.bib` with key `selfref` (ex:38-49, read at dtx:581-583); `\addbibresource` (ex:6-7); body `\maketitle`, `abstract`, IEEEtran `IEEEkeywords` (ex:138-140), `\printbibliography[notcategory=selfref]` (ex:311, rule dtx:584). Also provided and unused by the sample: `\TODO` (dtx:619), `\eg` `\ie` (dtx:724-725), `\hydash` (dtx:730), `\powerset` (dtx:719), `\citemonth` (dtx:605), `\toprule` `\midrule` `\bottomrule` (dtx:531-533, used at ex:198-206), `\fnbelowfloat`, `\lstdefinelanguage{json}` (dtx:440).

## Component map
Rows marked "(in class)" are set by the class code and reached with the one `class.cs-techrep` line. IEEEtran internals are inferred from the commands the `.dtx` calls and from the sample.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | ex:2, dtx:245 | `class.cs-techrep` | `conference,a4paper,flushend`; options counters dtx:249-275 |
| loaded base class | dtx:288, :279-281 | `class.ieeetran` | `\LoadClass{IEEEtran}`; unknown options forwarded; `onecolumn` dropped |
| paper | ex:2, dtx:122 | `page.class-options` | `a4paper` passed to IEEEtran |
| columns | ex:2, dtx:121, :266 | `cols.twocolumn-option` | two columns come from IEEEtran `conference` mode (implicit; IEEEtran source not read) |
| balance last page | ex:2, dtx:272-275, :814-823 | `cols.balance` | `flushend` (loaded when the option is set) or `pbalance` |
| floats in two columns, footnotes under floats | dtx:644-645 | `cols.cuted` | `stfloats`, `\fnbelowfloat` (in class) |
| title-page footer | dtx:752-755 | `hf.class-native` | `\def\ps@IEEEtitlepagestyle`: `\@oddfoot` = `\mycopyrightnotice`, `\@evenfoot` empty (in class) |
| footer notice box | dtx:756-768 | `box.minipage` | `minipage` 0.8`\textwidth`, `\centering`, `\footnotesize` (also `font.size-commands`, `sp.ragged`) |
| licence text and icon | ex:1, dtx:747, :761-762 | `front.doclicense` | `\PassOptionsToPackage{type=CC,modifier=by,version=4.0}`; class loads `hyperxmp=false,lang=English`; prints icon, long name, name, link |
| licence icons | dtx:416 | `font.icons` | `ccicons` (in class) |
| title | ex:15, :127, dtx:786 | `front.maketitle` | `\title{\cstechrepTitleTex}`, `\maketitle` (IEEEtran's) |
| author blocks | ex:12, dtx:788-794 | `front.class-native` | `\IEEEauthorblockN{authors}` `\IEEEauthorblockA{department, institution, address}` |
| special paper notice | dtx:796-797 | `front.class-native` | `\IEEEspecialpapernotice{type: number, \citemonth{selfref} year}` |
| data fields | ex:12-28, dtx:298-329 | `front.class-native` | twelve string fields with defaults (dtx:319-329) |
| ORCID icon in author list | ex:12, dtx:667 | `font.icons` | `orcidlink`, `\orcidlink{id}` |
| abstract | ex:129-134 | `abs.class-native` | IEEEtran `abstract` |
| keywords | ex:138-140 | `abs.keywords` | IEEEtran `IEEEkeywords` environment |
| headings | ex:150, :184, :212, :214, :239 | `head.class-native` | IEEEtran `\section` `\subsection` look; manual `\\` break inside a heading (`sp.manual-space`, ex:239, :242) |
| lists | dtx:536 | `list.paralist` | `alwaysadjust` (in class; the sample has no list) |
| Latin Modern base | dtx:357 | `font.lmodern` | `lmodern`, loaded before `times` (comment dtx:358-360) |
| Times text | dtx:361 | `font.mathptmx` | `times` |
| monospace face | dtx:386 | `font.mono` | `newtxtt` `zerostyle=b,scaled=.75` |
| encodings | dtx:389, :393 | `font.fontenc-t1` | `inputenc` utf8, `fontenc` T1 (loaded after the fonts) |
| icons in the body | ex:98, :142, :154, :159 | `font.icons` | `fontawesome`, `\faWarning{}` |
| relative size | ex:99, :15, dtx:426 | `font.size-commands` | `relsize`, `\textsmaller{...}` |
| hand-declared math symbol font | dtx:708-719 | `font.nfss` | `\DeclareFontFamily{U}{MnSymbolC}`, `\DeclareFontShape` size map, `\DeclareSymbolFont`, `\DeclareMathSymbol{\powerset}` (MnSymbol font files not shipped) |
| protrusion and expansion | dtx:398-407, :411 | `sp.microtype` | `babel=true,expansion=alltext,protrusion=alltext-nott,nopatch=eqnum,final`; `\DisableLigatures{encoding=T1,family=tt*}` |
| hyphenation | ex:122, :18, dtx:833, :730 | `sp.hyphenat` | `\hyphenation{...}`, `extdash[shortcuts]` (`\-/`), `\hydash` |
| manual spacing | ex:244, :256, dtx:724-725 | `sp.manual-space` | `\vspace{\baselineskip}`, thin-space aliases `\eg` `\ie` |
| URLs | dtx:367, :375 | `meta.url` | `url[hyphens]`, `\UrlBreaks` extended by `\UrlOrds` |
| straight quotes in verbatim | dtx:338 | `code.upquote` | load-only |
| language | ex:28, :125, dtx:349, :352 | `lang.babel` | `[ngerman,main=english]`; `\selectlanguage{\cstechrepLang}`; `"=` shorthands via `\languageshorthands{ngerman}` |
| quotation marks | ex:157, :159, :251, dtx:672, :676-677 | `lang.csquotes` | `autostyle=true`; `\textquote` `\enquote`; shorthands `"`` `"'` |
| colours | dtx:424, :433-435 | `color.xcolor` | `cmyk,table`; `eclipseStrings` RGB 42,0,255, `eclipseKeywords` 127,0,85, `numb`=magenta!60!black |
| table colour support | dtx:424 | `tbl.colortbl` | option `table` of xcolor |
| links | dtx:653, :656-662 | `meta.hyperref` | `hidelinks,colorlinks=true,allcolors=black,pdfstartview=Fit,breaklinks=true` |
| float link anchors | dtx:665 | `xref.hypcap` | `hypcap[all]`, loaded after hyperref |
| cross-references | ex:161, :192, :179, :209, dtx:693-698 | `xref.cleveref` | `capitalise,nameinlink,noabbrev`; `\crefname{listing}`, `\crefname{lstlisting}` (and `\Crefname`) |
| labels | ex:179, :209 | `xref.kernel` | `\label{fig:...}` |
| maths | dtx:680 | `math.amsmath` | `amsmath` loaded before cleveref |
| maths symbols | dtx:680 | `math.amssymb` | `amssymb`, `amsfonts` |
| numbers and units | dtx:647-648 | `mark.siunitx` | `group-minimum-digits=4,per-mode=fraction`; `\sisetup{locale=DE}` added to `\extrasgerman` (hook is `lang.babel`) |
| inline marks | ex:130, :245 | `mark.kernel` | `\texttt`, `\textbf`, `>{\bfseries}l` column |
| figure float | ex:163-180 | `fig.graphicx` | `figure[htb!]`, `\centering` (`sp.ragged`); `graphicx` loaded dtx:413 |
| caption position | dtx:637-639 | `fig.floatrow` | `\floatsetup[table]{capposition=top,captionskip=5pt}`, `\floatsetup[figure]{capposition=bottom,captionskip=8pt}` |
| captions | ex:178, :208 | `cap.kernel` | `\caption` (IEEEtran's `\@makecaption` patched, dtx:624-628) |
| sub-figures | dtx:800-808 | `fig.subcaption` | option `subfig` (`caption=false,font=footnotesize`) or `subcaption` |
| sub-figure captions | dtx:807 | `cap.caption` | `\captionsetup[subfigure]{labelformat=parens,font=footnotesize}` |
| table | ex:196-210, dtx:527 | `tbl.tabularx` | `tabularx` `{\textwidth}` columns `>{\bfseries}l X` |
| table rules | ex:198-206, dtx:531-533 | `tbl.tabular` | `\toprule` = `\hline\noalign{\smallskip}`, `\midrule`, `\bottomrule` defined by the class, not booktabs |
| diagonal cell | dtx:422 | `tbl.multirow` | `diagbox` (in class) |
| code listings | dtx:431, :468-523 | `code.listings` | `\lstset` (basicstyle `\footnotesize\ttfamily`, `numbers=left`, `breaklines`, `captionpos=b`, ...), `\lstdefinelanguage{json}` |
| listing boxes | dtx:702-703 | `box.tcolorbox` | `tcolorbox` loaded unconditionally |
| listings library | dtx:703 | `code.tcblisting` | `\tcbuselibrary{listings}` (uses `listings`, not `minted`) |
| bibliography | ex:6-7, :311, dtx:545-570 | `bib.biblatex-biber` | `defernumbers,sorting=none,sortcites=false,citestyle=numeric-comp,bibstyle=numeric,backend=biber,bibencoding=utf8,hyperref,backref=false,isbn,url,doi,urldate=iso,seconds,maxnames=5,minnames=1,maxbibnames=99,minbibnames=1,maxcitenames=99,mincitenames=1,giveninits=false,uniquename=init,autolang=other` |
| bibliography parts | dtx:581-587, :594-595, :605-614 | `bib.biblatex-biber` | `\addbibresource{selfref.bib}`, `\DeclareBibliographyCategory{selfref}`, `\addtocategory`, `\bibfont` = `\normalfont\small`, `\DeclareRedundantLanguages{en}{...}`, `\DeclareCiteCommand{\citemonth}` |
| citations | ex:152-155, :267-305 | `bib.biblatex-biber` | `\cite{...}` keys from `cpn_all_all.bib` and `embedded.bib` |
| acronyms | ex:115-118, dtx:428 | `idx.glossaries` | `acronym[nolist,smaller]`, `acronym` environment with two `\acro` entries |
| to-do notes | dtx:618-620 | `note.todonotes` | `colorinlistoftodos,prependcaption,textsize=tiny`; `\TODO` = `\todo[linecolor=red,backgroundcolor=red!25,bordercolor=red]` |
| dummy text | ex:100, :185, :225, dtx:700 | `draft.todo` | `lipsum`, `\lipsum[12]` etc. |
| landscape pages | dtx:741-742 | `pg.landscape` | `lscape` and `pdflscape` |
| page flow | dtx:743 | `pg.afterpage` | `afterpage` |
| text copy from PDF | dtx:738-739 | `meta.glyphtounicode` | `\input glyphtounicode`, `\pdfgentounicode=1` |

Not a look component: `\pdfoutput=1` (ex:3) is an arXiv engine hint, with no printed effect; an emitter writes the one line. Considered and not mapped, load-only with no effect on the page: `xspace` (dtx:721; its `\xspace` appears only in comments, dtx:722-723), `etoolbox` (dtx:295, :599; programming helper behind the patches below).

## Bespoke code
All of it is inside the published class (scope `class`) except the sample's `filecontents*` block.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\DefcstechrepVar` and the twelve setters and getters | dtx:298-316 | yes | `\@namedef` string storage = `\newcommand`/`\gdef` data macros; class vocabulary (`front.class-native`) |
| `\toprule` `\midrule` `\bottomrule` | dtx:531-533 | yes | `\hline` and `\noalign{\smallskip}` (`tbl.tabular`, `sp.manual-space`) |
| `\TODO`, `\eg`, `\ie`, `\hydash` | dtx:619-620, :724-725, :730 | yes | aliases over `\todo[...]`, `\,` and kernel `\penalty`, `\hskip` |
| `\lstdefinelanguage{json}`, `\lstset` blocks | dtx:440-466, :468-523 | yes | `code.listings` declarations with `literate` colour rules |
| `\powerset` font declarations | dtx:708-719 | yes | kernel NFSS declarations (`font.nfss`); needs the MnSymbol font files |
| `\ps@IEEEtitlepagestyle` and `\mycopyrightnotice` | dtx:752-768 | yes | one page style with a footer minipage; could be `\fancypagestyle` with `\fancyfoot` (`hf.fancyhdr`), but IEEEtran's page-style system is not read |
| `\DeclareCiteCommand{\citemonth}` | dtx:605-614 | yes, with a caveat | biblatex's documented `\DeclareCiteCommand` and `\mkbibmonth{\thefield{month}}`; the lines that `\let` `\abx@bibmonth` and `\setkeys{blx@opt@pre}` touch biblatex internals and the author comments "nowork" (dtx:609); not checked further |
| `\patchcmd{\NAT@test}{...}` | dtx:601 | yes (dead code) | natbib is not loaded, so the patch has nothing to patch; `{}` failure branch |
| `\patchcmd{\@makecaption}{\\}{.\ }{}{}` | dtx:623-629 | not shown (counted as class) | makes "Table I" and the caption text one line separated by ". "; the lib way `cap.caption` has `labelsep=period`, but the class loads no `caption` package and the IEEEtran source is not read, so equivalence is not established |
| `\let\blx@rerun@biber\relax` | dtx:576-578 | no, but no printed effect | switches off biblatex's rerun flag (arXiv builds, comment dtx:572-575) |
| `\filecontentsForceExpansion` | dtx:771-784 (used ex:37) | no as a macro; reducible as data | rewrites `\dospecials` to make `|` an escape character inside `filecontents*`; the emitter can write `selfref.bib` with the values filled in, or keep the two class-vocabulary lines |
| `selfref.bib` via `filecontents*` | ex:38-49 | yes | kernel `filecontents*` writing one `@TECHREPORT` from the class fields; content is data (`bib.biblatex-biber`) |
| `_cpn_copyIntoExamplesFolder_cls.cmd` | dtx:204-226, cs-techrep.ins:10 | n/a | a Windows batch file for the author's own repository (copies the class into `..\examples\*`); no document needs it |

## Content-opaque
- `forest` tree (`art.tikz`: TikZ `fit` library, `forked edges`) inside a figure, ex:104-105, :165-177. It is figure artwork, not template identity.
- Bibliography data: `embedded.bib` text in a `filecontents` block (ex:54-96) and `template/cpn_all_all.bib` (79 entries, 1148 lines).
- The text of every paragraph, the `\{\,\faWarning{}...\}` guidance notes and the table cells.

## Lib changes
- New ways proposed: `xref.hypcap` `hypcap` (CTAN, Heiko Oberdiek), pdfLaTeX; load-only switch loaded after `hyperref`, options `all` `figure` `table`, moves hyperref link anchors of floats to the float top (dtx:665). W1: on CTAN. W2: chosen by an option list. W3: serves any hyperref document with captions. W4: one preamble line. No home: `xref.hyperref` is the `\autoref` `\nameref` `\hyperref` commands, `meta.hyperref` is hyperref options; a load-only add-on package got its own way before (`fn.footnotebackref`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
