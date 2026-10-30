no

# 0096-c-d-p-bundle: C.D.P. Bundle (letteracdp / articoletteracdp, version 0.36d)

- Unverified: read from the source, not compiled.
- Source: Source/0096-c-d-p-bundle/ (origin: https://mirrors.ctan.org/macros/latex/contrib/cdpbundl.zip; licence: LPPL 1.3 (00readme.txt:10-12))
- Kind: letter (the manifest hint `book` is wrong: the sample is a documentation file typeset as several letters, cdp-ver-0-36.tex:188-1104)
- Lib: v1
- Engine: pdfLaTeX-compatible (hyperref pdf keys and `\pdfbookmark`, no fontspec; the sample's `callig15` and `pplx` fonts are not shipped, see Verdict)
- Look carried by: mixed (page, margins, running heads, sectioning, captions, ToC and the letter blocks come from the published classes `articoletteracdp` on `letteracdp`; the sample's own letterhead, `listing` float and layout helper macros are preamble code in cdp-ver-0-36.tex:1-167)
- Class origin: ctan (cdpbundl is on CTAN and in TeX Live, ctan.org/pkg/cdpbundl; 00readme.txt:112-113 says it is installed in TeX Live and MiKTeX; the zip holds only the `.dtx`/`.ins` source, no generated `.cls`)
- Main file: cdp-ver-0-36.tex (other samples: cdpbundl.dtx driver at cdpbundl.dtx:1505-1558, `ltxdoc` + `hypdoc`; the shipped PDFs are output, not source)
- Read: main yes, zip-local classes and styles all (no `.cls`/`.sty` file is present; I read every code line of the `.dtx` modules `letter` 1580-6170, `artico` 6189-6686, `addon` 6706-7417, `babel` 7439-7549, `.def`/`.cfg`/`.ldf` 7585-7742, comments and prose of cdpbundl.dtx:1-1500 only skimmed by grep)

## Verdict
`no`. The look of the classes is a published CTAN class and would map to `class.articoletteracdp` on `class.letteracdp`, and most of the sample's preamble reduces to lib ways. Three constructs in the sample's own preamble do not reduce: the letterhead logo drawn with `picture` and `\framebox` (ART), the `\prevdepth` glue helpers `\cleantop`/`\cleanbot`/`\cleanbotp` (irreducible glue code), and `\listoflistings`, which is cloned from class-private conditionals and the class's per-letter `\@starttoc`. The verdict stays `no` on the first two even if the third were reduced.

## Blockers
- `ART/preamble` letterhead logo: `picture(0,0)` holding `\put(-2,0){\framebox(1.8,1.2){...My Logo}}` inside `customletterhead`; a positioned frame at a negative offset, no declarative lib way (cdp-ver-0-36.tex:27-31; the sample says `\includegraphics` could replace it, :602)
- `BESPOKE/preamble` `\cleantop`, `\cleanbot`, `\cleanbotp`: set and read `\prevdepth`, compute `\vskip` from `\baselineskip`, `\topskip` and `\prevdepth`; state-dependent glue arithmetic that drives where verbatim listings sit in their floats (cdp-ver-0-36.tex:152-167)
- `BESPOKE/preamble` `\listoflistings`: `\section*` plus `\sectionmark`, the class-private conditional `\if@loX@in@toc@`, and `\@starttoc{lol}` which this class redefines to read per-letter files (cdp-ver-0-36.tex:139-149; class side cdpbundl.dtx:6208-6209, 6376-6390). The float itself reduces (see Bespoke code), this list-of command is not shown to.

## Class setting
- Class: `class.articoletteracdp` (loads `class.letteracdp` at cdpbundl.dtx:6299). The sample loads it through a glue class `myarticletter` written by `filecontents` (cdp-ver-0-36.tex:1-8, 61-63). Options used: `twoside`, `boldsubject`, `italicsignature`, `shortindent`, `signaturerule`. Class defaults (cdpbundl.dtx:2956-2960, 6292): `a4paper,10pt,oneside,onecolumn,final,mediumsubject,uprightsignature,nosignaturerule,noPS,indent,105x37labels`, plus `plaintoc,openletterbookmarks`.
- Class-native vocabulary used: environments `letterhead[addressee name]{address}[subject]`, `foldedletterhead` (cdp-ver-0-36.tex:188, 318, 1011, 1035, 1074); `\opening`, `\closing`, `\closing*`, `\PS`, `\encl`, `\epilogue`, `\makepresentation`, `\maketopdate`, `\makesignature` (:197, 972, 974, 1102, 966, 1015-1020); sender data `\name`, `\signature`, `\address`, `\date`, `\place` (:69-77); page styles `headings` (:87); `\section`, `\paragraph`, `\tableofcontents`, `\caption`. Package `cdpaddon[customletterhead]`: environments `customletterhead{width}`, `customletterfoot{width}`, `\ruleacrossheadorfoot[inset]`, hooks `\foldingtagrule`, `\CDPFactoryFoldingTagRule`, length `\longindentation`, `\facesmile`. Package `cdpbabel[english]`: wraps `babel` and adds the bundle's caption names from `cdpnamesenglish.ldf` (cdpbundl.dtx:7461-7545, 7683-7703).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | cdp-ver-0-36.tex:61-63; cdpbundl.dtx:6190, 6299 | `class.articoletteracdp`, `class.letteracdp` | options twoside, boldsubject, italicsignature, shortindent, signaturerule |
| paper, margins | cdpbundl.dtx:2717-2720 (a4paper default), 3467-3627 | `page.class-options` | a4paper default, class computes margins from `\paperwidth`; twoside |
| running heads and page numbers | cdp-ver-0-36.tex:87; cdpbundl.dtx:3970-3976, 4010-4018 | `hf.class-native` | `\pagestyle{headings}`: slanted "To: addressee" mark and date, centred folio |
| letters, sender and addressee blocks, subject, opening, closing, signature, enclosures, P.S. | cdp-ver-0-36.tex:188-197, 972-974, 1011-1020, 1102; cdpbundl.dtx:4613-4633, 5359-5792 | `ltr.opening` | letter envs and commands above; signature rule via class option |
| folded-letter presentation and fold mark | cdp-ver-0-36.tex:1009, 1015; cdpbundl.dtx:4041-4093, 5043-5318 | `ltr.opening` | `foldedletterhead`; fold mark redefined with `\renewcommand*\foldingtagrule` (cdp-ver-0-36.tex:52-54) |
| custom letterhead and footer | cdp-ver-0-36.tex:15, 22-35, 42-50; cdpbundl.dtx:6792-6796, 7183-7300 | `ltr.opening` | package `cdpaddon[customletterhead]`, boxes of width `\textwidth` (content is free LaTeX, see rows below) |
| letterhead length alignment | cdp-ver-0-36.tex:37-40, 1008 | `sp.lengths` | `\settowidth{\longindentation}{...}`, `\setlength\longindentation{.5\textwidth}` |
| letterhead logo | cdp-ver-0-36.tex:27-31 | `art.pstricks` | `picture(0,0)`, `\unitlength=1cm`, `\put(-2,0){\framebox(1.8,1.2){...}}` (ART, blocker) |
| letterhead font and size | cdp-ver-0-36.tex:18-19, 24, 38 | `font.size-commands`, `font.nfss` | `\fontsize{17}{21}`; family `my@calli` declared with `\DeclareFontFamily{T1}`, `\DeclareFontShape{T1}...{<->s*[1.44]callig15}`, selected with `\usefont{T1}{my@calli}{m}{n}` |
| footer font and size | cdp-ver-0-36.tex:44 | `font.size-commands`, `font.nfss` | `\fontsize{5}{6}`, `\usefont{T1}{pplx}{m}{n}` |
| letterhead and footer colour | cdp-ver-0-36.tex:16, 20, 23, 43, 53 | `color.color` | `\definecolor{my@lh@color}{rgb}{0,.4,.4}`, `\color{...}` |
| letterhead rule and spacing | cdp-ver-0-36.tex:32-33, 46 | `sp.rule`, `sp.manual-space`, `sp.ragged` | `\hrulefill`, `\enspace`, `\hspace{-2cm}`, `\leftline`, `\raggedleft`, `\ruleacrossheadorfoot[-2cm]` |
| input encoding of fonts | cdp-ver-0-36.tex:64 | `font.fontenc-t1` | `[T1]` |
| language and caption names | cdp-ver-0-36.tex:65; cdpbundl.dtx:7440-7545 | `lang.babel` | `[english]` through `cdpbabel` (published wrapper, same bundle) |
| PDF links and metadata | cdp-ver-0-36.tex:66, 79-85, 73-75 | `meta.hyperref` | `bookmarksnumbered`, `hypertexnames=false`, `pdftitle` `pdfauthor` `pdfsubject` `pdfcreationdate` `pdfmoddate`; `\href`, `\nolinkurl` |
| bookmarks per letter | cdpbundl.dtx:6264-6292, 6399-6404 | `hf.class-native` | `openletterbookmarks` default |
| cross-references | cdp-ver-0-36.tex:234, 344, 392, 409 | `xref.kernel`, `xref.hyperref` | `\label`, `\ref`, `\hyperref[label]{text}` |
| sectioning | cdp-ver-0-36.tex:223, 272, 341, 405, 651, 685, 828, 881, 894; cdpbundl.dtx:6548-6584 | `head.class-native` | `\section` 12pt bold, `\paragraph` italic run-in |
| numbering depth | cdp-ver-0-36.tex:88, 221, 270 | `num.secnumdepth` | `tocdepth=2`; `secnumdepth` 0 then 2 |
| contents | cdp-ver-0-36.tex:216-217; cdpbundl.dtx:6622-6632 | `toc.kernel` | `\tableofcontents`, per-letter files via class `\@starttoc` |
| listing float | cdp-ver-0-36.tex:127-138, 280-336 | `fig.newfloat`, `num.counters` | name Listing, extension `lol`, placement `tbp`, counter reset by `letter` (reduction below) |
| float captions | cdp-ver-0-36.tex:333, 473, 525, 540; cdpbundl.dtx:6607-6617 | `cap.kernel` | `\caption` in `listing`, class `\@makecaption` (italic, centred) |
| verbatim code listings | cdp-ver-0-36.tex:282-332, 446-472, 517-570, 586-632, 764-798, 909-957 | `code.verbatim` | `verbatim`, `\verb` |
| margin note | cdp-ver-0-36.tex:246 | `note.marginpar` | `\marginpar{\hfill ...}` |
| text marks | cdp-ver-0-36.tex:93-105, 199-212 | `mark.kernel` | `\emph`, `\textsc`, `\textit`, `\textbf`, `\sffamily`, `\ttfamily`, `\normalfont` |
| maths | cdp-ver-0-36.tex:104, 246, 721-725 | `math.kernel` | `\(\langle ...\rangle\)`, `$...$` |
| raw spacing parameters | cdp-ver-0-36.tex:106-110, 171-172 | `sp.lengths` | `\parskip`, `\topsep`, `\partopsep`, `\hfuzz`, `\vfuzz` |
| flush-left blocks | cdp-ver-0-36.tex:358, 376, 760 | `sp.ragged` | `flushleft` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `myarticletter.cls` glue written by `filecontents` | cdp-ver-0-36.tex:1-8 | yes | `class.articoletteracdp` (`\LoadClassWithOptions`) plus the preamble lines of `mylogo.def`; kernel `filecontents` is TeX-only |
| `mylogo.def` letterhead and footer definition | cdp-ver-0-36.tex:12-57 | partly | every line maps to the ways in the component map except the `picture` (ART) |
| Letterhead logo `picture`/`\framebox` | cdp-ver-0-36.tex:27-31 | no | `art.pstricks` is Restricted and this draws the sample's letterhead identity |
| `\pdfbslash` catcode trick and `\command` (`\char\escapechar`) | cdp-ver-0-36.tex:90-91, 101-103 | yes | `\texorpdfstring{\texttt{\textbackslash}}{\textbackslash}` with `mark.kernel` and `meta.hyperref` |
| `\packlass \opz \env \sty \filedir \cntr \meta \strongemph` | cdp-ver-0-36.tex:93-100, 104-105 | yes | aliases of `\sffamily`, `\ttfamily`, `\textit`, `\textbf`, inline maths (`mark.kernel`, `math.kernel`) |
| `\zerolistvertspaces` | cdp-ver-0-36.tex:106-110 | yes | `sp.lengths` (`\parskip`, `\topsep`, `\partopsep` = 0pt) |
| Short names `\lcdp \acdp \hyre \cdpa \adic \adip \babel \cdpbabel \Bundle \oclh \eclh \eclf` | cdp-ver-0-36.tex:112-123 | yes | `\newcommand*` text aliases |
| `listing` float: counter, `\fps@`, `\ftype@`, `\ext@`, `\fnum@`, `\@float` environments | cdp-ver-0-36.tex:127-138, 146, 149 | yes | `\DeclareFloatingEnvironment[fileext=lol,placement=tbp,within=letter,name=Listing]{listing}` (`fig.newfloat`); `\l@listing` and `\toclevel@listing` are kernel float plumbing |
| `\listoflistings`, `\listlistingname`, `\listingname` | cdp-ver-0-36.tex:139-148 | no | heading and toc entry go through class-private `\if@loX@in@toc@`, `\sectionmark`, per-letter `\@starttoc`; no lib way expresses that |
| `\cleantop`, `\cleanbot`, `\cleanbotp` | cdp-ver-0-36.tex:152-167 | no | read `\prevdepth` to place `\vskip`; irreducible glue code |
| `\hfuzz = 0pt`, `\vfuzz = 0pt` | cdp-ver-0-36.tex:171-172 | yes | `sp.lengths` |
| `\renewcommand*{\foldingtagrule}{\color..\CDPFactoryFoldingTagRule}`, `\let\foldingtagrule=...` | cdp-ver-0-36.tex:52-54, 1009 | yes | documented class hook set with `color.color` |
| Published bundle code (classes, packages, ldf, def, cfg) | cdpbundl.dtx:1580-7742 | covered by class way | published on CTAN and in TeX Live, so Flouest emits `\documentclass{articoletteracdp}`; the hand-written `\@startsection`, `\@makecaption`, `\vsplit` folding and `\parshape` code stays inside the class |

## Content-opaque
- `\lipsum[1-2]` filler text in letters 2 to 4 (cdp-ver-0-36.tex:1018, 1055, 1098) and the verbatim source of the listings (content).
- `\facesmile` symbol macro from `cdpaddon` (cdpbundl.dtx:7397-7417, used at cdp-ver-0-36.tex:251, 371, 509, 978): a published symbol, content.
- Missing assets: the `callig15` font (cdp-ver-0-36.tex:19) and the Palatino family `pplx` (:44) are not shipped; the sample itself warns the fonts may be absent (:644-645). I could not confirm from ctan.org/pkg/calligra that `callig15` belongs to that package, so I did not map the declaration to `font.display`.

## Lib changes
- New ways proposed: `font.nfss` kernel NFSS commands `\DeclareFontFamily`, `\DeclareFontShape`, `\usefont`, `\fontfamily`, `\fontencoding` for declaring a family from font files and selecting it for a span; engine pdf. W1 kernel LaTeX; W2 family, encoding, series, shape and the size-function string are plain strings; W3 serves any font declaration; W4 preamble declaration plus a body switch. Nearest lib ways, `font.size-commands` (only `\fontsize`, sizes) and `font.family-default` (global defaults), do not declare or locally select an NFSS family; it could be folded into `font.family-default` instead if the consolidator prefers.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this).

## Notes
- Second sample: cdpbundl.dtx drives `ltxdoc` + `hypdoc` with `\RecordChanges`, `\CodelineIndex`, `\PrintChanges`, `\PrintIndex` (cdpbundl.dtx:1511-1548) and needs `makeindex` (Makefile), a tool outside TeX. It builds the bundle's own manual, not the template, and is not counted in the verdict. The Makefile is not used by the main sample.
- No text addressed to an AI was found in the zip.
