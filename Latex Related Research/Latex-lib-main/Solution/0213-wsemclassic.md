yes

# 0213-wsemclassic: wsemclassic (Bavarian school W-Seminar paper class)

- Unverified: read from the source, not compiled.
- Source: Source/0213-wsemclassic/ (origin: https://mirrors.ctan.org/macros/latex/contrib/wsemclassic.zip; licence: BSD style, bsd in the manifest; LICENSE:1-15)
- Kind: thesis
- Lib: v2
- Engine: pdfLaTeX-compatible (the class branches on `\ifPDFTeX`, wsemclassic.dtx:415-433; XeTeX gets polyglossia + fontspec, LuaTeX gets babel + fontspec)
- Look carried by: class (wsemclassic.dtx defines the whole look; the sample only sets class options and the class's metadata commands)
- Class origin: ctan (ctan.org/pkg/wsemclassic read: "Wsemclassic", J. Rosenberger, v1.0.1, BSD style licence, /macros/latex/contrib/wsemclassic; the zip is the CTAN release)
- Main file: wsemclassic-test.tex (other samples: none; user-doc.tex is a manual chapter that `wsemclassic.dtx:118` `\input`s, wsemclassic.dtx:23-76 is the manual's driver, neither is a sample)
- Read: main yes, zip-local classes and styles all (the zip holds no .cls or .sty: the class source wsemclassic.dtx is read in full, lines 1-895, plus wsemclassic.ins, user-doc.tex, README, Makefile, test.bib)

## Verdict
yes. The look is carried entirely by a published CTAN class: the sample is `\documentclass[bibfile=test.bib]{wsemclassic}`, eight class-native metadata commands and kernel `\chapter`/`\section`/`\subsection` (wsemclassic-test.tex:1-10, 16-78), and it defines no macro of its own. Everything the class does maps to lib ways (below), and there is no artwork and no tool outside TeX (bibtex is `bib.bibtex-bst`). Class-internal constructs that would be a problem if the class were zip-local are listed under "Bespoke code" for transparency; under the rubric they belong to the published class way, so this is a class-dimension yes, not evidence for the component ways.

## Blockers
none (published-class ruling). For re-reading under a stricter definition that ignores the class way: `BESPOKE/class` the `wsfancy` header-mark logic (wsemclassic.dtx:513-539) would not reduce to `hf.fancyhdr` parameters.

## Class setting
- Class: `class.wsemclassic` options: `bibfile=<file>` is the only one the sample sets (wsemclassic-test.tex:1); declared with defaults `strict=false` `stricttitle=false` `frenchspacing=false` `fontsize=12` `paper=a4` `lang=german` `plxtex=true` `bib=true` `bibfile=\jobname` `bibstyle=natdin` `hyperref=true` `hyperrefargs=unicode` `natbib=true` `natbibargs=round` `microtypeargs=babel` `titlesecargs=small` `tocbibindargs=nottoc` `fontspecargs=quiet` `defaultfontfeatures=Ligatures={TeX, Common}, Fractions=On` (wsemclassic.dtx:156-319); every other option goes to the parent (wsemclassic.dtx:330). Parent: `\LoadClass{report}` with `12pt, german` and `a4paper` passed (wsemclassic.dtx:362-370).
- Class-native vocabulary used: `\title` `\author` `\date` `\subject` `\school` `\major` `\teacher` `\place` (one string each, wsemclassic.dtx:727-734; used at wsemclassic-test.tex:3-10); `\maketitle` and `\tableofcontents` run automatically at begin document (wsemclassic.dtx:886); `\makebib` and `\makeclosing` run automatically at end document (wsemclassic.dtx:887); `\placeholder`, `\setgeometry`, `\newcaption` exist but the sample calls none.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | wsemclassic-test.tex:1; wsemclassic.dtx:16-18 | `class.wsemclassic` | bibfile=test.bib; all else default |
| parent class | wsemclassic.dtx:128, 370 | `class.report` | loaded by the class; `\chapter`, `\section`, `\subsection`, `titlepage` env |
| class options to parent | wsemclassic.dtx:362-364 | `page.class-options` | `12pt`, `a4paper`, `german` (unless `paper=custom`) |
| page geometry | wsemclassic.dtx:496-500, 556, 793, 826 | `page.geometry` | non-strict: `a4paper, scale=0.75, centering`; strict: `top=2cm, bottom=2cm, left=2.5cm, right=2.5cm, a4paper`; title page non-strict: `\newgeometry{left=2.5cm, right=2.5cm}` then `\restoregeometry`; `\setgeometry` is an alias of `\geometry` (497) |
| line spacing | wsemclassic.dtx:489-490, 798, 812 | `sp.setspace` | `\onehalfspacing` for the body; `\singlespacing` at the top of the title page; `\doublespacing` before the data table |
| paragraph lengths | wsemclassic.dtx:795-796, 866-867 | `sp.lengths` | `\parindent=\z@`, `\parfillskip=\z@ plus 1fil` on the title page and closing page |
| manual spacing | wsemclassic.dtx:801-811, 874-875 | `sp.manual-space` | `\vskip 7em`, `.5em`, `10em` (title page), `\vskip 2em`, `\hfill` (closing line) |
| space after period | wsemclassic.dtx:579-581, 349 | `sp.frenchspacing` | `\frenchspacing` when `frenchspacing` or `strict` is true |
| microtypography | wsemclassic.dtx:455-457, 598 | `sp.microtype` | `[babel]` (microtypeargs); `\textls[250]` letter-spacing for the main title; only when `plxtex=true` |
| letter-spacing fallback | wsemclassic.dtx:601-609 | `mark.ulem` | soulutf8 `\so`, only when `plxtex=false` (off by default) |
| input and font encoding (pdfTeX) | wsemclassic.dtx:416-417 | `font.fontenc-t1` | `inputenx[utf8x]`, `fontenc[T1]` |
| fonts (XeTeX, LuaTeX) | wsemclassic.dtx:431-432 | `font.fontspec` | `[quiet]`, `\defaultfontfeatures{Ligatures={TeX, Common}, Fractions=On}`; options `mainfont` `sansfont` `monofont` (CMU Serif, CMU Sans Serif, CMU Typewriter Text) are declared (230-240) but no `\setmainfont` appears in the file |
| language (pdfTeX, LuaTeX) | wsemclassic.dtx:380-386, 419-420, 427-428 | `lang.babel` | `ngerman` (from `lang=german`); `babelbib[fixlanguage]` loaded beside it (considered: babelbib as a bib way, kept as the support package) |
| language (XeTeX) | wsemclassic.dtx:424-425 | `lang.polyglossia` | `\setdefaultlanguage[babelshorthands, spelling=new]{german}` |
| PDF links and metadata | wsemclassic.dtx:446-448, 638-643, 727-730 | `meta.hyperref` | `[unicode]`; `\hypersetup{pdfauthor, pdftitle, pdfsubject}` set from `\author` `\title` `\subject` |
| metadata commands | wsemclassic.dtx:727-734; wsemclassic-test.tex:3-10 | `front.class-native` | title, author, date (`Abiturjahrgang~2014`), subject, school, major, teacher, place |
| title page | wsemclassic.dtx:790-830 | `front.class-native` | redefined `\maketitle` |
| title page container | wsemclassic.dtx:791, 799-810 | `front.titlepage-env` | `titlepage` env, `center` block, school and date on one line with `\hfill`, then course name, main title, subtitle, subject, paper title |
| title page data table | wsemclassic.dtx:813-824 | `tbl.tabular` | `{rl}`, rows for author, major, teacher, hand-written grade lines |
| form-field lines | wsemclassic.dtx:783 | `sp.rule` | `\rule[-.5ex]{5cm}{.4pt}` |
| title page styles | wsemclassic.dtx:599, 618-620, 627-628 | `mark.kernel` | main `\Large\bfseries\textsc`; subject `\textit`; title `\large\textit`; strict: main `\large\bfseries\MakeUppercase`, title `\textit` |
| title page type sizes | wsemclassic.dtx:599, 620, 627 | `font.size-commands` | `\Large`, `\large` |
| title page strings | wsemclassic.dtx:755-773 | `front.class-native` | German strings only (Qualifikationsphase, Seminararbeit, Verfasser, Leitfach, Seminarleiter, Selbstst\"andigkeitserkl\"arung) via `\newcaption` |
| table of contents | wsemclassic.dtx:886, 545 | `toc.kernel` | `\tableofcontents` called at begin document |
| bibliography in toc | wsemclassic.dtx:545 | `toc.etoc` | `tocbibind[nottoc]` |
| title page counter | wsemclassic.dtx:829 | `num.counters` | `\stepcounter{page}` after the title page |
| headings | wsemclassic.dtx:475, 557; wsemclassic-test.tex:16, 19, 52, 65, 78 | `head.titlesec` | package loaded with `[small]`; strict only: `\titleformat{\chapter}{\normalfont\Large\bfseries}{\thechapter}{1em}{}{}`; sample uses `\chapter`, `\section`, `\subsection` with report numbering |
| running heads (class's own) | wsemclassic.dtx:513-539, 559-566, 571 | `hf.class-native` | `strict` chooses: non-strict page style `wsfancy` (chapter in right head, section in left head, subsection mark for the first subsection); strict: `plain` with `\chead{\thepage}`, head and foot rules 0pt |
| header engine | wsemclassic.dtx:506-508, 513, 559-565 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\renewcommand{\headwidth}{\textwidth}`, `\fancypagestyle{wsfancy}`, `\fancypagestyle{plain}`; `fancyhdrargs` is declared (312) but fancyhdr is loaded without it (506) |
| kernel page styles | wsemclassic.dtx:565-566 | `hf.pagestyle-kernel` | strict: `\pagestyle{plain}`; `\addtocontents{toc}{\protect\thispagestyle{empty}}` |
| maths packages | wsemclassic.dtx:466 | `math.amsmath` | `[\ws@amsmathargs]` (empty default); sample has no maths |
| maths symbols | wsemclassic.dtx:467 | `math.amssymb` | loaded, not exercised |
| theorem package | wsemclassic.dtx:467 | `thm.amsthm` | loaded, no `\newtheorem` anywhere |
| citations and bibliography | wsemclassic.dtx:481-483, 843-849 | `bib.natbib` | `[round]`; `\nocite{*}` prints every entry |
| bibliography file and style | wsemclassic.dtx:846-847, 887; test.bib | `bib.bibtex-bst` | `\bibliographystyle{natdin}`, `\bibliography{test.bib}`; `natdin` is the style named on the CTAN page of `din1505` (ctan.org/pkg/din1505, file name not shown there) |
| closing declaration page | wsemclassic.dtx:863-876 | `front.dedication` | `\chapter*{Selbstst\"andigkeitserkl\"arung}`, `\addcontentsline{toc}{chapter}`, fixed German declaration, place + `\today` + signature line; run at end document |
| closing page break | wsemclassic.dtx:864 | `pg.break` | `\newpage` |
| not exercised by the sample or class | wsemclassic-test.tex:1-136 | none | lists, quotes, notes, floats, captions, other tables, theorems, code, index, cross-references: none used |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| sample's own macros | wsemclassic-test.tex:1-136 | none exist | the sample defines nothing |
| `wsfancy` header marks (`\newif\iffirstsection`, `\setchaptermark`, `\setsectionmark`, `\setsubsectionmark`, `\lhead` and `\rhead` set from inside `\chaptermark` and `\sectionmark`) | wsemclassic.dtx:513-539 | published class, carried by `class.wsemclassic`; if the class were zip-local this would be irreducible | stand-alone it would map to `hf.fancyhdr` only approximately: it changes header fields at heading time instead of reading `\leftmark`/`\rightmark`, and line 532 prints the subsection title twice |
| `\newcaption`, `\setmeta`, `\sethypermeta`, `\onlyhypermeta` (csname stores) | wsemclassic.dtx:639-669, 755-762 | published class; reducible as `\newcommand` strings plus `\hypersetup` | German strings and `\hypersetup{pdfauthor, pdftitle, pdfsubject}` |
| `\maketitle` redefinition | wsemclassic.dtx:790-830 | published class; reducible | `front.titlepage-env` + `tbl.tabular` + `sp.setspace` + `sp.manual-space` + `sp.rule` + `page.geometry` as in the map |
| `\makebib`, `\makeclosing`, `\spaced`, `\mainstyle`, `\placeholder`, `\setgeometry` | wsemclassic.dtx:597-609, 783, 497, 843-876 | published class; reducible | aliases and wrappers of ways in the map |
| `plxtex=false` branch defines `\spaced` twice with `\newcommand` | wsemclassic.dtx:602-603 | off by default, not used by the sample | recorded as a defect on that branch, not read as compiled |

Other zip files that are not template: Makefile (builds the documentation with `makeindex`, `git`, `bibtex`: Makefile:13, 21, 55-56; wsemclassic.ins:55 generates the .cls with DocStrip, a TeX run), wsemclassic.dtx:23-76 documentation driver (`ltxdoc` with `dox`, `hypdoc`, `colordoc`, `hologo`). They are packaging and manual, not part of the emitted look, and not counted as EXTERNAL.

## Content-opaque
none (lorem-ipsum text only; test.bib has two entries, content)

## Lib changes
- New ways proposed: none. (`class.wsemclassic` is written plainly as a class way; its native vocabulary is under "Class setting".)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
