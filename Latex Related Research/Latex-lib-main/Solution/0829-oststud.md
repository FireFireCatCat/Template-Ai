yes

# 0829-oststud: oststud (OST student organisation package) with the older hsrstud package and the hsrzf / hsrbericht classes

- Unverified: read from the source, not compiled.
- Source: Source/0829-oststud/ (origin: https://mirrors.ctan.org/macros/latex/contrib/oststud.zip; licence: cc-by-sa-4, CC BY-SA 4.0, README.md:45-53)
- Kind: misc (a house-style maths-notation and colour package, plus a summary class `hsrzf` and a report class `hsrbericht`)
- Lib: v6
- Engine: pdfLaTeX-compatible (README.md:19-24 and Makefile:1 build with xelatex, but no `.dtx` loads a XeTeX-only package or tests `\ifXeTeX`; the fonts are cmbright, roboto, concmath, lmodern)
- Look carried by: class (the published oststud and hsrstud packages and the hsrzf and hsrbericht classes, all shipped in this CTAN bundle as `.dtx`, define everything; the zip has no sample preamble)
- Class origin: ctan
- Main file: none (no `.tex` sample; the main unit is `oststud.dtx` with its ltxdoc driver at oststud.dtx:25-48) (other samples: `hsrstud.dtx` driver at hsrstud.dtx:13-338, `hsrstud-classes.dtx` driver at hsrstud-classes.dtx:4-34 and its minimal example at hsrstud-classes.dtx:142-170)
- Read: main yes (`oststud.dtx`, `hsrstud.dtx`, `hsrstud-classes.dtx`, both `.ins`, README, Makefile all read in full; the three `.pdf` are build outputs and were not read), zip-local classes and styles all (no `.cls` or `.sty` is present: they are generated from the `.dtx` by `xelatex oststud.ins` and `xelatex hsrstud.ins`, README.md:19-20, README.md:33)

## Verdict
yes. The zip is a CTAN bundle of house-style code, not a sample document: the package `oststud` and the older `hsrstud` set colours, `hyperref` and `listings` defaults and a family of maths macros, and the classes `hsrzf` and `hsrbericht` are `\LoadClass{article}` plus `geometry`, `fancyhdr`, `titling`, `totpages` and a hand-laid title page. Every piece of that code reduces to lib ways with parameters (tables below), no expl3, output-routine or Lua code is present, and no template-defining artwork is present. Two soft spots are recorded, not hidden: the `picture`-drawn symbols `\corresponds` and `\rcorresponds` (oststud.dtx:618-631) are judged a maths glyph, not template identity, so not `ART`; and the `bfemph` option redefines the kernel `\em ` internals (oststud.dtx:391-400), judged a boolean parameter of a published package. If a reviewer reads either as a blocker the verdict becomes `no` (`ART/package` or `BESPOKE/package`).

## Blockers
none

## Class setting
- Class: `class.hsrzf` and `class.hsrbericht` (both `\LoadClass[a4paper]{article}`, hsrstud-classes.dtx:349, so `class.article` is the base); options (kvoptions family `hsr`, hsrstud-classes.dtx:207-255): `header` / `noheader`, `sans`, `slab`, `concrete`, `margin=<huge|large|big|normal|small|tiny|minimal>` (default value `huge`), every other option goes to `article` (hsrstud-classes.dtx:238-253).
- Class-like packages: `class.oststud` (house style of one organisation, class-like per the v6 log; options `dontrenew` `textvecdiff` `bfemph` `bbprobability`, oststud.dtx:378-381) and `class.hsrstud` (older package; options `dontrenew`, `arrowvec` / `boldvec`, `textvecdiff` / `delvecdiff`, hsrstud.dtx:378-386). The three documentation drivers use `class.ltxdoc` (oststud.dtx:26, hsrstud.dtx:14, hsrstud-classes.dtx:5).
- Class-native vocabulary used: hsrzf and hsrbericht: `\course` `\module` `\semester` `\institute` `\authoremail` `\maintainer` `\contributors` with accessors `\thecourse` ... (hsrstud-classes.dtx:261-288); hsrbericht adds `\subtitle` `\category` `\project` `\topic` `\version` `\instructor` `\startdate` `\finishdate` `\address` `\matriculationnr` `\logo` `\clientlogo` (hsrstud-classes.dtx:294-343) and the `abstract` sub-commands `\problem` `\goal` `\method` `\results` `\suggestions` `\keywords` (hsrstud-classes.dtx:546-551); page styles `hsrzf`, `hsrzf-norulers`, `hsrbericht`. oststud: `\vec` `\uvec` `\dotp` `\crossp` `\grad` `\div` `\curl` `\laplacian` `\vlaplacian` `\mx` `\mt` `\mh` `\minv` `\tr` `\argmin` `\argmax` `\Re` `\Im` `\E` `\Var` `\Pr` `\fourier` `\laplace` `\ztransf` `\hilbert` `\corresponds` `\skriptum` `\sref` `\textbook` `\bref`. hsrstud: `\vc` `\v` `\uv` `\heq` `\dd` `\di` `\deriv` `\pderiv` `\bookref` `\notesref` `\lectureref` besides the shared names.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| base class of hsrzf, hsrbericht | hsrstud-classes.dtx:349 | `class.article` | `a4paper` |
| paper (classes, drivers) | hsrstud-classes.dtx:349; hsrstud-classes.dtx:5; hsrstud.dtx:14 | `page.class-options` | a4paper |
| class option plumbing | hsrstud-classes.dtx:207-255 | `class.hsrzf` `class.hsrbericht` | bool `header` `sans` `slab` `concrete`, string `margin` (default value `huge`) |
| page geometry (classes) | hsrstud-classes.dtx:423-462; :470-475; :558-563 | `page.geometry` | `\newgeometry{hmargin=H,vmargin=V,marginparsep=0pt,marginpar=0pt}`; (H,V) mm by name: huge 45/40, large 35/35, big 30/30, normal 25/30, small 20/20, tiny 10/20, minimal 5/20; margin option absent gives 30/30 (:426-428) |
| page geometry (drivers) | hsrstud.dtx:21; hsrstud-classes.dtx:13-16 | `page.geometry` | `left=4cm,right=4cm,top=3cm,bottom=3cm`; `margin=3.5cm,left=4cm` |
| hsrzf running head and foot | hsrstud-classes.dtx:477-489 | `hf.fancyhdr` | `\fancyhf{}`; head L `\leftmark`, C `\themodule`, R `\@date`; foot L `\href{https://github.com/HSR-Stud/}{\texttt{HSR-Stud}}`, C `\texttt{CC BY-NC-SA}`, R `\thepage ~/ \pageref{TotPages}`; `\headrulewidth` `\footrulewidth` .5pt |
| hsrzf style without rules | hsrstud-classes.dtx:491-503 | `hf.fancyhdr` | same fields, both rule widths 0pt |
| hsrzf style switch | hsrstud-classes.dtx:505-507 | `hf.pagestyle-kernel` | `\pagestyle{hsrzf}` when option `header` |
| hsrbericht running head and foot | hsrstud-classes.dtx:566-575 | `hf.fancyhdr` | head C `\@title`, R `\hsr@clientlogo`, L `\hsr@logo`; foot R `\thepage / \pageref{TotPages}`, L `Dockument: \jobname \\ Druck: \finishdate`; rules .5pt |
| hsrbericht plain page style | hsrstud-classes.dtx:577-588 | `hf.fancyhdr` `hf.pagestyle-kernel` | `plain` redefined with the same fields; `\pagestyle{hsrbericht}`; `\thispagestyle{hsrbericht}` on the title page (:517) |
| page X of Y | hsrstud-classes.dtx:355; :485; :571 | `pgnum.lastpage` | `totpages`, `\pageref{TotPages}` |
| footer link | hsrstud-classes.dtx:483 | `meta.hyperref` | `\href{url}{text}` |
| hyperref setup (classes) | hsrstud-classes.dtx:359-360 | `meta.hyperref` | `plainpages=false`, `pdfpagelabels`, `pdfusetitle` |
| default text font | hsrstud-classes.dtx:204 | `font.lmodern` | `\RequirePackage{lmodern}` |
| sans option | hsrstud-classes.dtx:379-382 | `font.fontenc-t1` `font.helvet` | `fontenc` T1; `cmbright` (sans text face), `sfmath` |
| slab option | hsrstud-classes.dtx:397-400 | `font.fontenc-t1` `font.helvet` | `fontenc` T1; `roboto` with `rm,light` (the manual names bitter and eulervm at hsrstud-classes.dtx:56, the code does not load them) |
| concrete option | hsrstud-classes.dtx:415-418 | `font.math-face` `font.fontenc-t1` | `concmath` with `boldsans,amssymb`; `fontenc` T1 (concmath page not read) |
| title page sizes | hsrstud-classes.dtx:520-524 | `font.size-commands` | `\fontsize{48}{60}`, `{24}{48}`, `{22}{48}` with `\selectfont` |
| metadata fields | hsrstud-classes.dtx:261-343 | `front.class-native` | `\gdef` store plus `\the<field>` accessor, required fields error and optional fields warn when unset |
| title support package | hsrstud-classes.dtx:354 | `front.titling` | `\RequirePackage{titling}` (load-only here; `\@title` `\@author` `\@date` are read directly) |
| hsrbericht title page | hsrstud-classes.dtx:515-542 | `front.titlepage-env` `sp.manual-space` `tbl.tabular` `mark.kernel` | `\renewcommand\maketitle` over `titlepage` + `center`; `\vspace*{6cm}`, `\vspace{1.5cm}`, `1cm`, `0.5cm`, `4cm`, `2cm`; tabulars `{rl}`, `{rl p{1.5cm} rl}`, `{rl}`; bold labels; German labels |
| hsrbericht abstract | hsrstud-classes.dtx:544-552 | `abs.class-native` `head.kernel` `abs.keywords` | `\renewenvironment{abstract}` opening `\section*{Abstract}`; `\problem` `\goal` `\method` `\results` `\suggestions` `\keywords` are `\paragraph{...}` |
| OST colour palette | oststud.dtx:663-692 | `color.xcolor` | 19 `\definecolor{OST...}{RGB}{r,g,b}`: Black 25,25,25; Gray 198,198,198; Blackberry 140,25,95; Raspberry 215,40,100; Purple, Green, Red, Blue, Orange each with Dark and Light |
| HSR colour palette | hsrstud.dtx:564-610 | `color.xcolor` | 40 `\definecolor{hsr-...}{HTML}{...}`: eight families, each a base and four tints (80, 60, 40, 20) |
| link colours | oststud.dtx:699-705; hsrstud.dtx:405-411 | `meta.hyperref` | `\hypersetup{colorlinks=true,linkcolor,citecolor,filecolor,urlcolor}` with palette colours |
| code listing style | oststud.dtx:709-738; hsrstud.dtx:414-447 | `code.listings` | `\lstdefinestyle` keys `numbers=left` `numbersep=5pt` `numberstyle` `breaklines` `postbreak` `basicstyle=\ttfamily\small` `keywordstyle` `commentstyle` `stringstyle` `frame=none` `xleftmargin=\parindent` `showstringspaces=false`; `language=TeX` (oststud) or `[LaTeX]TeX` (hsrstud, plus `\lstdefinelanguage{LaTeX}` at hsrstud.dtx:442-444); `\lstset{style=..., escapechar=`}` |
| bold vectors, unit vectors, products | oststud.dtx:409-415; :422; :429-430 | `math.physics` `math.bm` `math.amsmath` | `\mathbf{\bm{#1}}`; `\uvec`; `\DeclareMathOperator{\dotp}{\boldsymbol\cdot}`; option `dontrenew` picks `\bvec` or `\renewcommand{\vec}` |
| vector calculus operators | oststud.dtx:437-483 | `math.physics` `math.amsmath` | `\DeclareMathOperator` for `\grad` `\curl` `\laplacian` `\vlaplacian`; `\div` renamed to `\divsymb`; option `textvecdiff` picks words (grad, div, curl) or nabla |
| matrices, trace, argmin | oststud.dtx:492-522 | `math.physics` `math.bm` `math.amsmath` | `\mx` bold upright; `\mt` `\mh` superscript `\mathsf{T}` `\mathsf{H}`; `\minv`; `\tr`; starred operators `\argmax` `\argmin` |
| complex and probability operators | oststud.dtx:532-536; :545-578 | `math.physics` `math.amsmath` `math.amssymb` | `\Re` `\Im` renewed as `\mathrm{Re}\left\{#1\right\}`; `\E` `\Var` `\Pr` with optional subscript; option `bbprobability` picks `\mathbb` |
| transform operators | oststud.dtx:587-611 | `math.physics` `math.amsmath` | `\DeclareMathOperator` over `\mathcal{F}` `\mathcal{L}` `\mathcal{Z}` `\mathcal{H}` and inverses with `^{-1}` |
| correspondence symbols | oststud.dtx:618-631 | `math.physics` | `\mbox{\setlength{\unitlength}{0.1em}\begin{picture}(20,10)...` two circles (open, filled) and a line, in both orders |
| bold emphasis option | oststud.dtx:391-400 | `mark.kernel` | boolean `bfemph`: `\emph` gives `\bfseries`, or `\itshape` inside bold |
| course reference helpers | oststud.dtx:640-653; hsrstud.dtx:397-399 | `mark.kernel` `color.xcolor` `bib.thebibliography` | `\sref` `\bref`: `\texttt{\textcolor{...}{#1}}` plus `\nocite` of a stored key; `\bookref` `\notesref` `\lectureref` set `P.` `S.` `L.` labels in palette colours |
| hsrstud maths macros | hsrstud.dtx:455-559 | `math.physics` `math.bm` `math.amsmath` | `\vc` `\v` `\vec` bold or `\vv` arrows (option `arrowvec`, package `esvect` option `b`, :358-359); `\heq` `\stackrel{\hat{\texttt{H}}}{=}`; `\dd` `\di` `\deriv` `\pderiv`; `\grad` `\div` `\curl` `\laplacian` |
| integral and vector-arrow symbols | hsrstud.dtx:357-359; oststud.dtx:30 | `math.physics` | `esint` (used in the manual for `\ointctrclockwise`, oststud.dtx:293), `esvect` option `b` |
| other loaded math packages | oststud.dtx:363-365; hsrstud.dtx:353-355 | `math.amsmath` `math.amssymb` `math.bm` | load-only |
| doc driver: title block | oststud.dtx:60-71; hsrstud.dtx:85-93; hsrstud-classes.dtx:26-28 | `front.maketitle` `front.thanks` `toc.kernel` `color.xcolor` | `\title` with `\textcolor{OSTBlackberry}` or `hsr-blue`, `\thanks`, `\author`, `\date`, `\maketitle`, `\tableofcontents` |
| doc driver: licence | oststud.dtx:33-37; :73-74; hsrstud-classes.dtx:8-12 | `front.doclicense` | `type={CC},modifier={by-sa},version={4.0}`; body `\doclicenseThis` |
| doc driver: dtx machinery | oststud.dtx:40-47; :354-356; hsrstud.dtx:16; :39-41; hsrstud.dtx:331-334 | `dtx.doc` | `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges` `\DocInput` `\PrintChanges` `\PrintIndex`; `macro` `macrocode` `\DescribeMacro` `\changes` `\StopEventually` `\Finale`; `hypdoc` |
| doc: sections | oststud.dtx:73; :76-83 | `head.kernel` | `\section`, `\section*`, `\subsection` |
| doc: description list | oststud.dtx:84; hsrstud-classes.dtx:47 | `list.enumitem` | `description[align=right]` |
| doc: framed example | oststud.dtx:127-129; hsrstud.dtx:46 | `box.mdframed` | `framed` environment `leftbar` |
| doc: display maths | oststud.dtx:118-119; :281-296 | `math.amsmath` | `\[ \]`, `align*` |
| doc: table | hsrstud-classes.dtx:61-73 | `tbl.booktabs` `tbl.tabular` `cap.kernel` | `table` float, `\centering`, `tabular{l r r l r r}`, `\toprule` `\midrule` `\bottomrule`, `\caption` |
| doc: listings and verbatim | hsrstud.dtx:134-140; hsrstud-classes.dtx:142-170; hsrstud.dtx:25 | `code.listings` `code.verbatim` | `lstlisting[language=C++]`; `fancyvrb` |
| doc: references and links | hsrstud.dtx:106; :148; :324-329; :129 | `xref.kernel` `bib.thebibliography` `meta.hyperref` | `\label` `\ref`; `thebibliography{3}`; `\url` |
| doc: PDF bookmarks | hsrstud.dtx:31 | `meta.bookmark` | load-only |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| oststud option plumbing | oststud.dtx:374-383 | yes | four booleans (kvoptions family `ost`; the package is not required explicitly, it arrives through `hyperref`, which is not read); the emitter writes `\usepackage[opts]{oststud}` or inlines the selected branch |
| `bfemph` redefinition of `\em ` | oststud.dtx:391-400 | yes, as a parameter | boolean option of the published package. Stand-alone fallback `\renewcommand{\emph}[1]{\textbf{#1}}` (`mark.kernel`) differs only inside bold text, where the original switches to italic |
| `\vec` `\div` `\Re` `\Im` `\P` renewals and `\let\old...` saves | oststud.dtx:413-414; :457-458; :533-535; :577 | yes | `\renewcommand` and `\let` aliases over `math.amsmath` and `math.bm`; branch chosen by `dontrenew` |
| `\corresponds` `\rcorresponds` | oststud.dtx:618-631 | yes (judgement) | a 2 mm maths glyph (kernel `picture`, `art.pstricks` family), not a page or title identity; stand-alone equivalent `\mathrel{\circ\!\!\text{---}\!\!\bullet}` style composition of kernel math symbols (not the same drawing) |
| `\skriptum` `\textbook` key stores | oststud.dtx:640-653 | yes | `\gdef` string then `\nocite{key}`; inline the key; the stored default `\PackageWarning` has the wrong argument count (oststud.dtx:640, :650) |
| apparent defect: `\ost@probabiliy` | oststud.dtx:575; :577 | n/a | name is not the defined `\ost@probability` (oststud.dtx:570-572), so `\P` would fail if used; no layout effect |
| hsrstud `\vaccent` `\oldvec` | hsrstud.dtx:466-467 | yes | `\newcommand` aliases (a `\let` was probably meant); alias only |
| hsrstud vector style switch | hsrstud.dtx:458-461; :477-480 | yes | pick `\hsrvecbold` or `\hsrvecarrow` by `arrowvec` |
| class metadata field family | hsrstud-classes.dtx:261-343 | yes | each field is `\gdef` plus accessor plus a guard message; the emitter writes `\course{..}` style calls with the document model's strings |
| margin preset ladder | hsrstud-classes.dtx:426-462 | yes | closed lookup of seven (H,V) pairs from `\ifstrequal`; emit the chosen `\newgeometry` |
| `\renewcommand\maketitle` | hsrstud-classes.dtx:515-542 | yes | `front.titlepage-env` body of `\vspace`, `\fontsize` and three `tabular`; apparent defect `\end{tabular}{}` (:535) |
| `abstract` environment | hsrstud-classes.dtx:544-552 | yes | `\section*{Abstract}` plus `\newcommand` aliases of `\paragraph{...}` |
| fancyhdr page styles | hsrstud-classes.dtx:477-503; :566-586 | yes | declarative `\fancypagestyle` field lists; apparent defect: `\finishdate` takes an argument (:323) but is used bare in the footer (:572, :583), `\thefinishdate` was probably meant |
| font-option conflict guards | hsrstud-classes.dtx:368-419 | yes | validity checks only, no printed effect; `\ifhsr@concrete{hsrzf}{...}\fi` is malformed (:374-377, :392-395, :405-408) and nothing is emitted for it |
| doc `example` and `hexample` environments | hsrstud.dtx:44-78 | yes | `fancyvrb` `VerbatimOut` (`code.verbatim`) inside a `leftbar` (`box.mdframed`), two `minipage` (`box.minipage`) of `\input` and `\lstinputlisting` (`code.listings`), width `.5\linewidth` (`sp.lengths`) |
| DocStrip batch files and Makefile | oststud.ins:1-52; hsrstud.ins:1-56; Makefile:1-64 | yes | `docstrip` generates `oststud.sty`, `hsrstud.sty`, `hsrzf.cls`, `hsrbericht.cls`; `makeindex` is the TeX index tool of `dtx.doc`; `--shell-escape` (Makefile:3) is passed but no loaded package needs it (no `minted`, no `\write18`); `tar` and `mkdir` only pack the CTAN archive; the Makefile references `test/*.tex` (Makefile:60-64) which is not in the zip |
| `xargs` load | hsrstud.dtx:30 | yes | load-only helper for macro definitions, no printed effect, so not a component |

## Content-opaque
- tikz colour-swatch charts in the manuals: oststud.dtx:318-346 and hsrstud.dtx:302-318 (`art.tikz`, documentation illustrations of the palettes defined with `color.xcolor`; they appear only in the `.dtx` documentation, not in documents that load the packages, so judged content, not template identity).
- logo code passed to `\logo` and `\clientlogo` (hsrstud-classes.dtx:337-343), the maths examples in the manuals, and the `lstlisting` code text (hsrstud.dtx:135-138).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
