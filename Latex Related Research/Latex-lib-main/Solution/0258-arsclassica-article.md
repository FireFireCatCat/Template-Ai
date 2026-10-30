yes

# 0258-arsclassica-article: Ars Classica Article

- Unverified: read from the source, not compiled.
- Source: Source/0258-arsclassica-article/ (origin: https://latextemplates.com/downloads/arsclassica-article.zip; licence: GPL-2.0-or-later)
- Kind: misc
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:21-24 builds with `pdflatex`; classicthesis.sty:205-236 is the pdfTeX font branch; the XeLaTeX/LuaLaTeX branch at classicthesis.sty:172-204 needs fontspec and OTF fonts and is not needed)
- Look carried by: class (the published style package `classicthesis` v4.8 with `style=arsclassica`, vendored from CTAN, on top of KOMA `scrartcl`; the sample adds only option settings and title text)
- Class origin: ctan
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (classicthesis.sty 740 lines and classicthesis-arsclassica.sty 98 lines read in full; `scrartcl` and the packages classicthesis loads were not read, they ship with TeX Live)

## Verdict
Yes. The zip has no zip-local macro, environment, counter or class: `main.tex` defines nothing (main.tex:9-76). The whole look is one published style package, `classicthesis` (CTAN v4.8, 2025-02-02, GPL-2.0-or-later, read on ctan.org/pkg/classicthesis), selected by `\usepackage[style=arsclassica,nochapters]{classicthesis}` (main.tex:15). Following the lib v3 convention that a thesis or house style package is class-like (`class.unamthesis`, `class.osda`), it is the way `class.classicthesis`. Its content also decomposes into existing component ways (map below). Two caveats, neither a blocker: the vendored `.sty` files were not diffed against CTAN (the ctan.org page does not list file names; the arsclassica file's own header, classicthesis-arsclassica.sty:1-7, says it ships with classicthesis), and `\deffootnote` (a KOMA command) has no lib line of its own, so it is recorded as `scrartcl` vocabulary.

## Blockers
none

## Class setting
- Class: `class.scrartcl` options: `11pt`, `a4paper` (main.tex:12). Loaded unchanged from TeX Live (not in the zip, source not read).
- Style package, class-like: `class.classicthesis` options: `style=arsclassica`, `nochapters` (main.tex:15). The option list is declared at classicthesis.sty:49-78 (`style` string at :70, `nochapters` at :57; with `nochapters` classicthesis also switches `parts`, `floatperchapter`, `manychapters`, `eulerchapternumbers` off at :112-121). The style file classicthesis-arsclassica.sty is loaded by classicthesis.sty:706-708.
- Class-native vocabulary used by the sample: `scrartcl`: `\title` `\author` `\date` `\maketitle`, `abstract`, `\tableofcontents`, `\section` `\subsection`. `classicthesis`: `\spacedallcaps{}` and `\spacedlowsmallcaps{}` (main.tex:17-18; defined classicthesis.sty:348-349), the `style` and `nochapters` options. Used by classicthesis inside `scrartcl` (not by the sample): `\deffootnote` (classicthesis.sty:635), `scrlayer-scrpage` fields `\lehead` `\rohead` `\rofoot` `\clearscrplain` `\headfont` `\pnumfont` `\headmark` `\pagemark` (arsclassica.sty:49-55), `typearea` `\areaset` (classicthesis.sty:273-280), `scrtime` (classicthesis.sty:648).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:12 | `class.scrartcl` | 11pt, a4paper |
| house style package | main.tex:15 | `class.classicthesis` | style=arsclassica, nochapters |
| paper and size | main.tex:12; classicthesis.sty:78,273 | `page.class-options` | 11pt, a4paper (classicthesis default `paper=a4`) |
| text block | classicthesis.sty:248-249, 273-279 | `page.typearea` | typearea options headinclude,footinclude; `\areaset[current]{336pt}{750pt}` (A4) |
| margin lengths | classicthesis.sty:278-279 | `page.setlength` | `\marginparwidth`=7em, `\marginparsep`=2em |
| encodings | main.tex:13-14 | `font.fontenc-t1` | fontenc T1, inputenc utf8 |
| body face | classicthesis.sty:209-210 | `font.palatino` | `mathpazo` options osf,sc (pdfTeX branch) |
| mono face | classicthesis.sty:214-216 | `font.mono` | `beramono` scaled=0.85 |
| sans family | classicthesis-arsclassica.sty:28-29 | `font.family-default` | `\sfdefault`=iwona (pdfTeX branch); `\ct@altfont`=`\sffamily` |
| chapter-number font (declared, unused with `nochapters`) | classicthesis-arsclassica.sty:31-33 | `font.nfss` | `\DeclareFixedFont{\chapterNumber}{T1}{pplj}{m}{n}{50}` |
| line spread | classicthesis.sty:211 | `sp.linespread` | 1.05 |
| widows and clubs | classicthesis.sty:295-298 | `sp.penalties` | `\clubpenalty`=`\widowpenalty`=`\displaywidowpenalty`=10000 |
| micro-typography, letter-spacing | classicthesis.sty:241, 347-349 | `sp.microtype` | `\microtypesetup{protrusion=true,expansion=true}`; `\textls[160]` (all caps), `\textls[80]` (low small caps) |
| small-caps marks | classicthesis.sty:338-339, 348-349 | `mark.kernel` | `\scshape`, `\textsc` behind `\spacedallcaps`, `\spacedlowsmallcaps`; `\MakeTextUppercase`/`\MakeTextLowercase` come from `textcase` (classicthesis.sty:335), considered, no separate way (internal to the package) |
| colours | classicthesis.sty:158-167 | `color.xcolor` | dvipsnames; CTsemi gray 0.55, CTcitation rgb(0,.5,0), CTurl and CTtitle Maroon, CTlink RoyalBlue |
| link colours, PDF outline | classicthesis.sty:729-732 | `meta.hyperref` | colorlinks=true, linktocpage=true, breaklinks=true, urlcolor=CTurl, linkcolor=CTlink, citecolor=CTcitation |
| running heads and feet | classicthesis.sty:373-386; classicthesis-arsclassica.sty:49-55 | `hf.scrlayer-scrpage` | automark; `\lehead`/`\rohead` with page number and CTsemi `\vline`; `\headfont`=normalfont sffamily; `\pnumfont`=small sffamily; `\clearscrplain`; `\rofoot[page number]{}`; `\sectionmark` redefined to `\markright` of lowered number plus `\spacedlowsmallcaps` title |
| header pieces | classicthesis-arsclassica.sty:50-51 | `sp.rule`, `sp.manual-space` | `\vline`; `\hspace`, `\hfil`, `\kern`, `\llap`, `\rlap` as header content |
| page style in use | main.tex:23 | `hf.pagestyle-kernel` | `\pagestyle{plain}` |
| title block | main.tex:17-19, 24 | `front.maketitle` | `\title{\rmfamily\normalfont\spacedallcaps{..}}`, `\author{\spacedlowsmallcaps{..}}`, `\date{\today}`, KOMA `\maketitle`; no `\thanks`; the abstract text mentions a rule under the title (main.tex:28) but no code for one was found (the only `\titlerule` is the chapter format, classicthesis.sty:420) |
| abstract | main.tex:26-32 | `abs.kernel` | `abstract` environment, first line `\noindent`; no KOMA `abstract` option set |
| contents | main.tex:34; classicthesis.sty:389-393 | `toc.kernel` | `\tableofcontents`; heading routed through `\section*{\contentsname}` under `nochapters` (classicthesis.sty:391) |
| contents layout | classicthesis.sty:447-453, 508-567 | `toc.tocloft` | option `titles`; `\cftsetpnumwidth`; `\cftsecpresnum`=`\scshape\MakeTextLowercase`; `\cftbeforesecskip`=.1em; leader `\hspace{1.5em}`, `\cftsecafterpnum`=`\cftparfillskip`; figure and table indents `\cftsetindents{..}{0em}{\figurelabelwidth}` |
| section head | classicthesis-arsclassica.sty:73-76, 95 | `head.titlesec` | `\titleformat{\section}`: `\normalfont\Large\sffamily`, label `\textsc{\MakeTextLowercase{\thesection}}`, sep 1em, text `\spacedlowsmallcaps`; `\titlespacing*{\section}{0pt}{2\baselineskip}{.8\baselineskip}[\marginparsep]` |
| subsection head | classicthesis-arsclassica.sty:78-80, 96 | `head.titlesec` | `\normalfont\sffamily\bfseries`, label small-caps number, sep 1em, `\normalsize`; spacing 1.5 and .8 `\baselineskip`, `[\marginparsep]` |
| subsubsection and paragraph heads | classicthesis-arsclassica.sty:82-90, 97 | `head.titlesec` | subsubsection `\normalfont\sffamily\bfseries\itshape`; paragraph `[runin]` with `\spacedlowsmallcaps`, spacing 1 and 1 `\baselineskip`; sample uses only section and subsection (main.tex:36,45,52,61,67) |
| heading font sizes | classicthesis-arsclassica.sty:74,80 | `font.size-commands` | `\Large`, `\normalsize` |
| equation numbering | classicthesis.sty:700 | `num.counters` | `\renewcommand{\theequation}{\arabic{equation}}` |
| list labels | classicthesis-arsclassica.sty:44, 92; classicthesis.sty:326-329 | `list.kernel` | `\labelitemi`=CTsemi bullet; `\descriptionlabel` bold `\spacedlowsmallcaps`; `aenumerate` sets `\theenumi` to `\textsc{\alph{enumi}}`; none used in the sample body |
| margin notes | classicthesis.sty:302-322 | `note.marginpar` | `\marginpar` wrapper with italic `\footnotesize` setup, `\parindent=0pt`, `\tolerance=2000`, `\hyphenpenalty=300`; also `sp.lengths`/`font.size-commands`/`sp.penalties` parameters; not used in the sample |
| marginpar placement | classicthesis.sty:313 | `note.mparhack` | `mparhack`, load only |
| footnote layout | classicthesis.sty:633-636 | `fn.kernel` | KOMA `\deffootnote{0em}{0em}{\thefootnotemark\hspace*{.5em}}` (class vocabulary of `scrartcl`; the `footmisc[marginal]` fallback at :638-642 is not taken because KOMA defines `\deffootnote`); no footnote in the sample |
| captions | classicthesis.sty:666-667; classicthesis-arsclassica.sty:38-39 | `cap.caption` | `\captionsetup{font=small,labelfont={sf,bf},format=hang}`, `[table]{skip=\medskipamount}`; no float in the sample |
| table rules | classicthesis.sty:334 | `tbl.booktabs` | load only; no table in the sample |
| code and inline literal | main.tex:27-28,41,43,48-49,56-57,59,64 | `code.verbatim`, `mark.kernel` | `\verb|\subsubsection|` (main.tex:64), `\texttt`, `\emph` |
| citations and bibliography | main.tex:42-43,58,73-74 | `bib.bibtex-bst` | `\cite`, `\bibliographystyle{plain}`, `\bibliography{references}`; entries in references.bib:1-21 (content) |
| labels | main.tex:37,46,53,68 | `xref.kernel` | `\label{sec:...}`; no `\ref` call in the sample |
| options not enabled by the sample | classicthesis.sty:102-108, 569-590, 651-660, 406-415, 418-420 | `code.listings`, `draft.todo`, `head.titlesec`, `toc.tocloft` | `listings` list of listings only if `listings` is loaded first; `drafting` loads `prelim2e` with a `\thistime` banner (`scrtime` is loaded always, classicthesis.sty:648, and prints nothing alone); `\part` and `\chapter` formats are skipped with `nochapters` (:117, :401) |
| log filter | main.tex:9-11 | none needed | `silence` `\WarningFilter` drops two log messages (scrartcl's titlesec notice, titlesec's non-standard-command notice, caused by `\titleformat{\chapter}` at classicthesis-arsclassica.sty:67 under a class without `\chapter`); no typeset effect, so not a component; considered: `silence`, not proposed |

No component is defined for: language (no `babel`, main.tex has none), index, glossary, theorems, algorithms, figures, tables (none in the sample), page background, columns.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local macros, environments, counters, classes | whole zip | none exist | `main.tex` defines nothing; both `.sty` files are the CTAN `classicthesis` v4.8 files (published, W1 via ctan.org/pkg/classicthesis, not diffed) |
| `\ttl@addcontentsline` patch of a titlesec internal | classicthesis.sty:402-404 | not zip-local (published package) | internal to `class.classicthesis`; the emitter prints the package line, not this code |
| `\toc@heading` hack | classicthesis.sty:389-393 | not zip-local | same; effect is `\section*{\contentsname}` plus `\@mkboth` |
| `\marginpar` redefinition, `\graffito@setup` | classicthesis.sty:302-322 | not zip-local | `note.marginpar` with italic footnotesize text and `sp.lengths`/`sp.penalties` settings |
| `aenumerate` | classicthesis.sty:326-329 | not zip-local | `list.kernel` with `\renewcommand\theenumi` (`num.counters`) |
| `\deactivateaddvspace` in lof/lot | classicthesis.sty:619-627 | not zip-local | spacing inside `toc.tocloft` lists; unused (the sample has no lof or lot) |
| `\formatchapter`, `\ctparttext` | classicthesis-arsclassica.sty:62-66; classicthesis.sty:408-410 | not zip-local, unreached with `nochapters` | `head.titlesec` |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered, not proposed: `silence` (log filter, no output), `textcase` (case conversion inside `\spacedallcaps`, internal to the style package), `scrtime` (load only), KOMA `\deffootnote` (kept as `scrartcl` vocabulary, no `class.scrbook` line exists).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
