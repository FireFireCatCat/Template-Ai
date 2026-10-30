no

# 0250-ustc-thesis: USTC Thesis

- Unverified: read from the source, not compiled.
- Source: Source/0250-ustc-thesis/ (origin: https://latextemplates.com/downloads/ustc-thesis.zip; licence: LPPL-1.3c)
- Kind: thesis
- Lib: v3
- Engine: needs XeLaTeX or LuaLaTeX (the class aborts under pdfTeX, ustcthesis.cls:44-47; `fontspec`, `unicode-math`, ctex CJK fonts; main.tex:2 says xelatex)
- Look carried by: zip-local (the look is defined in ustcthesis.cls, a zip-local expl3 class over `ctexbook`; main.tex only sets class options, `\ustcsetup` strings and loads packages)
- Class origin: zip-local
- Main file: main.tex (other samples: none; chapters/*.tex are `\include`d content files)
- Read: main yes, zip-local classes and styles all (ustcthesis.cls read in full, 1-4518; ustcthesis-numeric.bst, a docstrip-generated BibTeX style, only its first 60 lines and an outline grep)

## Verdict
No. The whole look sits in the zip-local `ustcthesis.cls` (4518 lines of expl3 over `ctexbook`, ustcthesis.cls:24, 317). Most of it reduces to lib ways (`fancyhdr`, `titletoc`, `caption`, ctex keys, `fontspec`, `geometry`, `amsthm`), but it also holds irreducible code: a measure-and-shrink loop that sizes the cover title, patches of the kernel float output routine, a copy-edited reimplementation of natbib's cite internals that the sample's `\citep` goes through, a flag-driven `\cleardoublepage`, and CJK glue hacks. There is no `ART` and no `EXTERNAL`.
Class origin ruling (pivotal, flagged): ctan.org/pkg/ustcthesis and ctan.org/pkg/ustc-thesis both returned 404 (ctan.org/pkg/ctex returned 200, so the reads work), and the zip is a latextemplates.com repack (one `.cls`, one `.bst`, a sample), not the USTC TeX Users Group's own release. By the rubric's W1 rule the class is therefore zip-local, although its header names the USTC TeX Users Group (ustcthesis.cls:2, 12-13). Had it counted as an official release, the look would be class-carried and the sample would likely reach `yes`.

## Blockers
- `BESPOKE/class` cover-title fit loop: `\dim_while_do` measures a `vbox` (height + depth > 150 bp) and shrinks the font 1 bp at a time, then re-typesets (ustcthesis.cls:1862-1891); `\maketitle` for degree=doctor runs it (1739-1759)
- `BESPOKE/class` kernel float output-routine patches: `\@addtocurcol` twice, `\@getpen`, and `\@floatboxreset` replaced (ustcthesis.cls:3185-3213, 3117-3123)
- `BESPOKE/class` natbib internals reimplemented: `\NAT@citexnum`, `\NAT@citex` copied with edits, plus `\NAT@citesuper`, `\NAT@citenum`, `\NAT@cite`, `\NAT@bibsetnum` (ustcthesis.cls:4097-4177, 4202-4411); reached by `\citep` (chapters/1-introduction.tex:10)
- `BESPOKE/class` `\cleardoublepage` redefined around a global flag `\g__ustc_title_page_bool` set in four places (ustcthesis.cls:1459-1486, 2103, 2167, 2357, 2656): hand-rolled state that decides whether blank pages carry a number
- `BESPOKE/class` CJK glue hacks: `\CJKglue` redefined (XeTeX) or `kanjiskip` (LuaTeX) to spread characters across a width, plus engine-branching char-class code (ustcthesis.cls:378-423, 1928-1934, 2368-2376)
- `BESPOKE/class` kernel footnote hook `\@makefntext` redefined (ustcthesis.cls:2997-3002; no `footmisc` option gives this shape)
- `BESPOKE/class` `proof` environment rewritten on `\trivlist` with `\pushQED` (ustcthesis.cls:3668-3685); active because the sample loads `amsthm` (main.tex:16)
- `BESPOKE/class` internals of loaded or conditionally loaded packages patched: `\HyPL@StorePageLabel` (3906-3916), `\MT_extended_eqref:n` (3950-3965), `\algocf@captiontext` (3561-3569), `\thenomenclature` (4423-4440); only the `amsthm`, `natbib` and amsmath `\tagform@` (3237-3253) patches act in the sample

## Class setting
- Class: `class.ctexbook` is the published base (ustcthesis.cls:317-318: `\LoadClass[UTF8,a4paper,scheme=plain,zihao=-4,fontset=none]{ctexbook}`; `openany` and `twoside` passed at 282-283; unknown keys forwarded at 229). The layer above it, `ustcthesis` (options `degree=doctor, language=english, fontset=fandol`, main.tex:4), is zip-local and is not claimed as a way (fails W1).
- Class-native vocabulary used: `\ustcsetup{title, author, student-id, discipline, supervisor, department, research-direction}` (main.tex:6-14), `\maketitle`, `\declarationoforiginality`, `\declarationofaiusage[purpose=none]` (main.tex:33-36), `abstract` environment (chapters/abstract.tex:3), `\frontmatter` `\mainmatter` `\backmatter`, `\tableofcontents` `\listoffigures` `\listoftables`, `\addbibresource` `\printbibliography` (BibTeX wrappers defined by the class), `\bibliographystyle{ustcthesis-numeric}`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | ustcthesis.cls:317-318, 282-283 | `class.ctexbook` | UTF8, a4paper, scheme=plain, zihao=-4, fontset=none, openany, twoside |
| paper and sides | ustcthesis.cls:282-283, 318 | `page.class-options` | a4paper, twoside, openany |
| page geometry | ustcthesis.cls:1391-1399 | `page.geometry` | paper=a4paper, vmargin=2.54cm, hmargin=3.17cm, headheight=0.49cm, headsep=0.55cm, footskip=0.79cm |
| header/footer | ustcthesis.cls:1401-1456 | `hf.fancyhdr` | `\fancypagestyle{plain}`: head C = `\leftmark` at 10.5bp/13.65bp, foot C = page; `\headrulewidth` 0.75bp; styles `headings`, `blank` |
| chapter-first page style | ustcthesis.cls:1447-1448 | `hf.pagestyle-kernel` | empty `\ps@chapter`; `\pagestyle{empty}` in `\maketitle` (1742), `\thispagestyle{empty}` in `titlepage` (2095) |
| page numbers | ustcthesis.cls:1741, 1494, 1506 | `pgnum.pagenumbering` | Alph on cover, Roman in frontmatter, arabic in mainmatter |
| page breaks | ustcthesis.cls:1461-1486, 2626-2630 | `pg.break` | `\cleardoublepage`, `\clearpage` (the redefinition is irreducible, see Bespoke) |
| bottom flush | ustcthesis.cls:2881 | `pg.flush` | `\raggedbottom` |
| base size and leading | ustcthesis.cls:531-546 | `font.size-commands` | `\normalsize` = 12bp/20bp, display skips 6bp plus 3bp minus 3bp; `\linespread{1}` |
| line spread | ustcthesis.cls:546 | `sp.linespread` | 1 |
| paragraph shape | ustcthesis.cls:2884, 2887, 2890-2891 | `sp.lengths` | `\parskip` 0; ctex `autoindent=2` (two characters) |
| first-paragraph indent | ustcthesis.cls:2890-2891 | `sp.indentfirst` | `\@afterindentfalse` made equal to `\@afterindenttrue` |
| hyphenation looseness | ustcthesis.cls:2877 | `sp.hyphenat` | `\sloppy` |
| Latin fonts | ustcthesis.cls:584-592, 603-636, 297 | `font.fontspec` | fontset=fandol gives font=termes: `\setmainfont{texgyretermes}`, `\setsansfont{texgyreheros}`, `\setmonofont{texgyrecursor}[Scale=MatchLowercase,Ligatures=CommonOff]`, `.otf` with `*-regular/-bold/-italic/-bolditalic`; `no-math` to fontspec |
| CJK fonts | ustcthesis.cls:768-777, 873-917, 921-924 | `lang.cjk` | `\setCJKmainfont{FandolSong}`, `\setCJKsansfont{FandolHei}`, `\setCJKmonofont{FandolFang}`, family fonts zhsong/zhhei/zhfs/zhkai; `\songti` `\heiti` `\fangsong` `\kaishu` |
| math fonts | ustcthesis.cls:1126-1143, 1372-1378, 1057-1072 | `font.unicode-math` | math-font=xits (set when `siunitx` loads, main.tex:25): `\setmathfont{XITSMath-Regular}[Extension=.otf,Scale=MatchLowercase]`, STIX Two for `cal`; `\unimathsetup{math-style=TeX,bold-style=TeX,partial=italic}` |
| math base | ustcthesis.cls:323, 1376-1377 | `math.amsmath` | loaded unconditionally; `math.amssymb` only if `\square` is undefined |
| colour | ustcthesis.cls:325, 2124-2125, 1783 | `color.color` | `\definecolor{ustcblue}{cmyk}{1,0.8,0,0}`; `\color{ustcblue}` on the logo |
| language names | ustcthesis.cls:436-497 | `lang.babel` | direct `\cs_set:Npn` of `\contentsname`, `\listfigurename`, `\bibname`, `\appendixname`, `\figurename`, `\tablename` and `\ctexset{chapter/name=\chaptername\space}` for english; no babel loaded (filed here as the lib's `lang.translator` line files caption overrides) |
| metadata keys | ustcthesis.cls:1540-1559; main.tex:6-14 | `front.class-native` | key=value strings `title` `author` `student-id` `discipline` `supervisor` `department` `research-direction` |
| cover and title page | ustcthesis.cls:1739-1759, 1766-1812, 1815-1926, 2085-2104 | `front.titlepage-env` | `titlepage` env: `\includegraphics[width=296bp]` name logo, `[height=178bp]` badge, `\parbox`, `\fontsize` 54/70.2bp, `\skip_vertical:n`; always in Chinese (`\ustcsetup{language=chinese}` 1769, 1818). The title-fit loop is irreducible |
| cover logos | ustcthesis.cls:1773, 1784, 1844 | `fig.graphicx` | `figures/ustc-name.pdf`, `figures/ustc-logo.pdf` (assets shipped in the zip) |
| manual spacing and boxes on cover | ustcthesis.cls:1772-1780, 1787-1809 | `sp.manual-space` | `\vspace*`, `\skip_vertical:n`, `\skip_horizontal:n`, `\hfill`; `box.minipage` for `\parbox[t]{368bp}` |
| cover alignment | ustcthesis.cls:1771, 1820, 2258 | `sp.ragged` | `\centering`, `\raggedleft` |
| originality and AI declarations | ustcthesis.cls:2152-2186, 2189-2264, 2334-2360, 2428-2458 | `front.dedication` | graduate pages with fixed Chinese text; `\__ustc_underline:nn` = `\underline{\hbox to <w>{\hss#2\hss}}` (`sp.rule`); main.tex:35-36 |
| supplied declaration scans | ustcthesis.cls:2165, 2355 | `pg.include-pdf` | `\includepdf[pagecommand=...]` only when `file=` is given (not used by the sample) |
| abstract | ustcthesis.cls:2663-2678; chapters/abstract.tex:3-15 | `abs.class-native` | `abstract` env: language switched to chinese, heading from `\__ustc_chapter:w{摘要}`; `abstract*` for English (2681-2735) |
| keywords | ustcthesis.cls:1557-1558, 2670-2676 | `abs.keywords` | keys `keywords`, `keywords*`; `\textbf{关键词：}` with `\hangindent` 4em (empty in the sample) |
| contents commands | ustcthesis.cls:2753-2763, 2830-2840; main.tex:40-42 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables` through `\__ustc_chapter:w` and `\@starttoc` |
| toc entries | ustcthesis.cls:2767-2828, 2774 | `toc.titletoc` | `\titlecontents{chapter}[0pt]{\addvspace{6bp}\sffamily}{\contentspush{\thecontentslabel\quad}}{}{\rmfamily leaders\thecontentspage}`, section `[1em]`, subsection `[2em]`; leaders `\titlerule*[4bp]{.}`; `\contentsmargin{0pt}`; figure/table lists |
| chapter and section headings | ustcthesis.cls:2469-2525 | `head.class-native` | `\ctexset{chapter={format=\centering\sffamily 16bp/20.8bp, aftername=\quad, beforeskip=7bp, afterskip=19bp}, section={14bp/20bp, 24bp/6bp}, subsection={13bp/20bp, 12bp/6bp}, subsubsection={12bp/20bp}}` |
| heading kernel use | chapters/1-introduction.tex:3, 12, 20, 34 | `head.kernel` | `\chapter`, `\section` |
| numbering depth | ustcthesis.cls:2464-2466 | `num.secnumdepth` | secnumdepth=3 (degree is not bachelor) |
| footnote numbering | ustcthesis.cls:2978-2981 | `num.counters` | `\thefootnote` = circled digit `\symbol{n+"245F}` |
| unnumbered chapters | ustcthesis.cls:2624-2641, 3267-3271, 3357-3375; chapters/acknowledgments.tex:3-4 | `head.kernel` | `\chapter*`, `\@mainmatterfalse\chapter`, `\addcontentsline{toc}{chapter}{...}` |
| lists | chapters/1-introduction.tex:22-32; ustcthesis.cls:3009-3037 | `list.kernel` | `itemize`; `\@listi`..`\@listiii` zero separations `\parsep` `\topsep` `\itemsep` 0pt plus .2pt, `\partopsep` 0 (these lengths: `sp.lengths`) |
| achievement list | ustcthesis.cls:3440-3453 | `list.enumitem` | `\newlist{achievementlist}{enumerate}{1}`, `\setlist`: topsep=3bp, parsep=3bp, leftmargin=21bp, labelwidth=21bp, label=[\arabic*] |
| footnotes | ustcthesis.cls:329, 2989-3002 | `fn.footmisc` | `perpage`; rule `\kern-3\p@ \hrule\@width.25\textwidth\kern2.6\p@` (`sp.rule`); `\@makefntext` is irreducible |
| caption look | ustcthesis.cls:3051-3080 | `cap.caption` | `\DeclareCaptionFont`; `\captionsetup{justification=centerlast, font=caption-title, labelsep=quad, skip=6bp, figureposition=bottom, tableposition=top}`; sizes 11bp/12.65bp (english) |
| figure/table notes | ustcthesis.cls:3130-3143 | `cap.caption` | `\figurenote` = group + `\captionsetup{justification=justified, font=caption, margin={2em,0pt}, oneside}` + `\caption*` |
| bilingual captions | ustcthesis.cls:3736-3749; main.tex:18 | `cap.caption` | `bicaption`: `\captionsetup[bi-first]{lang=chinese}`, `[bi-second]{lang=english,list=off}` |
| float placement | ustcthesis.cls:3156-3178 | `fig.placement` | `\fps@figure`=htbp, topfraction .85, bottomfraction .7, textfraction .15, floatpagefraction .66, topnumber 9, `\floatsep` 20bp, `\textfloatsep` 10bp, `\intextsep` 10bp |
| graphics and subfigures | ustcthesis.cls:331; main.tex:17, 19 | `fig.graphicx` | `graphicx`; `subcaption` is `fig.subcaption` |
| subcaption package | main.tex:19 | `fig.subcaption` | loaded, no options, no figure in the sample |
| tables | main.tex:20-22; ustcthesis.cls:3089-3114, 3923-3930, 4514-4518 | `tbl.booktabs` | `booktabs`; `threeparttable` (`tbl.threeparttable`) with `tablenotes` font; `longtable` (`tbl.longtable`) with table font; default `\arraystretch` 1.47 (english, graduate) |
| bachelor cover table | ustcthesis.cls:1955-2021 | `tbl.tabular` | `tabular` with `\multirow`/`\cline` (`tbl.multirow`); only for `\makecover`, not the sample |
| algorithms | ustcthesis.cls:3507-3538; main.tex:23-24 | `alg.algorithmicx` | `algorithm` with option `chapter`, `\floatname`, `\captionsetup[algorithm]`, `\contentsuse`, `\titlecontents{algorithm}`; `algorithm2e` hook (3541-3588) is `alg.algorithm2e`, unused |
| theorems | ustcthesis.cls:3594-3687; main.tex:16 | `thm.amsthm` | `\newtheoremstyle{ustc}{}{}{}{2em}{\bfseries}{}{1em}{}`, `\newtheorem{theorem}...[chapter]`, assertion/axiom/corollary/lemma/proposition share `theorem`, definition/example/assumption per chapter, `remark*`; `proof` rewritten (irreducible) |
| equation tag and eqref | ustcthesis.cls:3220-3253 | `math.amsmath` | `\eqref`, `\tagform@`; english branch is amsmath's default text; `mathtools` hook 3942-3966 is `math.mathtools`, not loaded |
| units | ustcthesis.cls:4445-4508; main.tex:25 | `mark.siunitx` | `\sisetup{list-final-separator, list-pair-separator, range-phrase}` per language |
| citations | main.tex:27; ustcthesis.cls:3971, 3996-4031 | `bib.natbib` | `[sort]` plus class `compress`; `\bibpunct` styles super/inline/authoryear; default numbers+super (3987-3988); natbib internals patched (irreducible) |
| citation-order helper | ustcthesis.cls:332 | `bib.cite-pkg` | `notoccite` loaded unconditionally, no options (considered: a citation-order package of the `cite` kind, filed here) |
| bibliography | main.tex:28-29, 48; ustcthesis.cls:3281-3327 | `bib.bibtex-bst` | `\bibliographystyle{ustcthesis-numeric}` (bst from gbt7714, ustcthesis-numeric.bst:7-10); `\addbibresource`/`\printbibliography` are class wrappers that call `\bibliography{references}` |
| bibliography heading and font | ustcthesis.cls:3260-3271, 4092-4095, 4182-4195 | `bib.natbib` | `\bibfont` 10.5bp/20bp, `\bibsep` 0pt plus .2pt, `\@biblabel`=[n]\hfill, `\bibsection` = `\@mainmatterfalse\chapter{\bibname}` |
| per-chapter bibliographies | ustcthesis.cls:3752-3774 | `bib.multi` | `chapterbib` hook; not loaded by the sample |
| nomenclature | ustcthesis.cls:4416-4440 | `idx.glossaries` | `nomencl` hook; not loaded by the sample |
| URLs | ustcthesis.cls:335, 2894-2975 | `meta.url` | `\urlstyle{same}`, `\UrlBigBreakPenalty` 100, `\UrlBreakPenalty` 200, `\Urlmuskip`, `\UrlBreaks`, digit/letter `\UrlSpecials` penalties 250 |
| hyperref defaults | ustcthesis.cls:3779-3825 | `meta.hyperref` | `\hypersetup{bookmarksnumbered, bookmarksopen, bookmarksopenlevel=1, linktoc=all, unicode, psdextra, hidelinks}`; the sample does not load hyperref (comment at 322), so this is inactive |
| Chinese `\autoref` names | ustcthesis.cls:3830-3892 | `xref.hyperref` | `\*autorefname` per language; inactive without hyperref |
| labels and refs | chapters/1-introduction.tex:4, 35; chapters/2-related-work.tex:4 | `xref.kernel` | `\label`, `\ref` |
| matter switches | ustcthesis.cls:1490-1511; main.tex:38, 44, 50 | `pgnum.pagenumbering` | `\frontmatter` (Roman, `plain`), `\mainmatter` (cleardoublepage, arabic, `plain`) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| the class as a whole, key-value option parser and flags | ustcthesis.cls:24, 119-249 | no (as a unit) | zip-local class (fails W1); the parser has no layout effect, but the flags drive conditionals through the file |
| cover-title fit loop | ustcthesis.cls:1862-1891 | no | measure-and-shrink algorithm over a box; an emitter would have to copy it |
| cover and title pages without the loop | ustcthesis.cls:1766-1926 | yes | `front.titlepage-env` + `fig.graphicx` + `box.minipage` + `sp.manual-space` + `font.size-commands` + `color.color` |
| `\cleardoublepage` with title-page flag | ustcthesis.cls:1459-1486 | no | stateful output of blank-page style |
| `\frontmatter`, `\mainmatter`, `\appendix` hooks | ustcthesis.cls:1490-1513 | yes | `pgnum.pagenumbering` + `hf.pagestyle-kernel` + `pg.break` |
| `\@addtocurcol`, `\@getpen`, `\@floatboxreset` patches | ustcthesis.cls:3117-3123, 3185-3213 | no | kernel output-routine internals |
| float parameters, caption setup, list spacing | ustcthesis.cls:3009-3037, 3051-3080, 3156-3178 | yes | `fig.placement`, `cap.caption`, `sp.lengths` as in the map |
| natbib `\NAT@...` redefinitions and `\parencite` `\onlinecite` `\inlinecite` | ustcthesis.cls:4043-4177, 4202-4411 | no | copy-edited package internals; `bib.natbib` options cannot express superscript page notes or two-item ranges |
| `\bibpunct` styles and `\citestyle` hooks | ustcthesis.cls:3996-4040 | yes | `bib.natbib` (`\bibpunct`, `\citestyle`) |
| `\addbibresource`, `\printbibliography`, `\bibliographystyle` wrapper | ustcthesis.cls:3273-3327 | yes | `\bibliography{references}` and `\bibliographystyle{ustcthesis-numeric}` (`bib.bibtex-bst`) |
| `\CJKglue` spread text, char classes | ustcthesis.cls:378-423, 1928-1934, 2368-2376 | no | engine-specific glue redefinition |
| `\@makefntext` | ustcthesis.cls:2997-3002 | no | kernel footnote hook, no `footmisc` option for this shape |
| `\thefootnote`, `\footnoterule` | ustcthesis.cls:2978-2994 | yes | `num.counters`, `sp.rule`, `fn.footmisc[perpage]` |
| `proof` environment | ustcthesis.cls:3668-3685 | no | hand-rolled `\trivlist` with QED stack |
| amsthm theorem set | ustcthesis.cls:3604-3664 | yes | `thm.amsthm` `\newtheoremstyle`, `\newtheorem` |
| unicode-math symbol aliases (`\le`, `\ge`, `\Re`, `\Im`, `\bm`, `\square`) | ustcthesis.cls:988-1097 | yes | `font.unicode-math` `\unimathsetup` plus `\newcommand` aliases, for the fixed values math-style=TeX |
| platform probing (`Menlo.ttc`, SimSun) | ustcthesis.cls:550-579 | yes | only used for fontset=auto; the emitter writes fontset=fandol statically |
| package hooks (`__ustc_at_end_package`) | ustcthesis.cls:3462-3518 | yes | the same `\captionsetup`, `\floatname`, `\newtheoremstyle` calls emitted after the `\usepackage` lines |
| `\tagform@`, `\eqref`, mathtools `\MT_extended_eqref:n` | ustcthesis.cls:3220-3253, 3950-3965 | no (internals), yes for english | english branch equals amsmath's own text; the Chinese branch patches amsmath/mathtools internals |
| hyperref `\HyPL@StorePageLabel`, `\HyRef@autopageref` patches | ustcthesis.cls:3865-3916 | no | hyperref internals; not loaded by the sample |
| `\__ustc_chapter:w`, `acknowledgments`, `achievements`, `innovations`, `notation` environments | ustcthesis.cls:2624-2658, 2853-2871, 3357-3438 | yes | `\cleardoublepage`, `\markboth`, `\chapter*`, `\addcontentsline`, `list` via `head.kernel`, `hf.fancyhdr`, `list.enumitem` (the first-list vertical gap flag, 3426-3434, is a static position the emitter knows) |
| `\figurenote`, `\tablenote` | ustcthesis.cls:3130-3143 | yes | `cap.caption` `\caption*` in a group |
| url penalties loops | ustcthesis.cls:2893-2975 | yes | `meta.url` `\UrlSpecials` with fixed penalties |

## Content-opaque
none. The cover logos `figures/ustc-name.pdf`, `figures/ustc-logo.pdf`, `figures/ustc-title-page-heading.pdf` are included image assets (ustcthesis.cls:1773, 1784, 1949), shipped; they are not drawn in TeX, so no `ART`. `figures/ustc-name-stxingkai.pdf` (ustcthesis.cls:2034, bachelor title page only) is not in the zip: missing asset, not used by the doctor sample. The class contains no TikZ, PGF, `picture` or PSTricks (grep).

## Lib changes
- New ways proposed: none. Considered: `notoccite` (filed under `bib.cite-pkg`, a citation-order package); caption-name overrides by direct `\renewcommand` (filed under `lang.babel` as the lib's `lang.translator` line files them).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
