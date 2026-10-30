no

# 0021-elife: eLife article template (Overleaf/writeLaTeX, elife.cls v1.11)

- Unverified: read from the source, not compiled.
- Source: Source/0021-elife/ (origin: https://cdn.elifesciences.org/author-guide/elife-latex-template.zip; licence: not established)
- Kind: journal
- Lib: v0
- Engine: pdfLaTeX-compatible (elife.cls:49-63 branches on engine; the pdfLaTeX branch uses T1, stix, opensans, lmtt; the XeLaTeX/LuaLaTeX branch uses unicode-math, opensans, fontspec)
- Main file: elife-template.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (elife.cls, 526 lines, in full; the BibTeX style vancouver-elife.bst, 1935 lines, partly: outline, header, `output.bibitem`, `article`, `begin.bib`/`end.bib`, label code)

## Verdict
No. The page, font, heading, caption, footer and box looks all map to lib ways, but elife.cls also holds two pieces of irreducible bespoke code that the sample uses: a figure/table "supplement" system that writes to an output stream and re-inputs it at the end of the document, with seven hand-rolled counters; and `\xpatchcmd` patches inside natbib's `\NAT@citex` that restyle every in-text citation. A third item (authblk internals) is also not shown reducible. `elife.cls` is not on CTAN (ctan.org/pkg/elife returned 404, the one CTAN read used) and the zip does not show public documentation, so it was analysed as a zip-local class, not accepted as a `class.elife` way. If a reviewer accepts a publisher-released class as W1-published, the file would flip to yes, but only because the class is then an opaque way.

## Blockers
- `BESPOKE` figure/table/video supplement system: counters figsupp, data, srccode, fsdata, fssrccode, video, videosupp; `newfile` stream `\jobname.suppinfo` written during the run and `\input` at `\AtEndDocument`, which also blanks the footer (elife.cls:316-462). The sample uses it for `\figsupp`, `\figdata`, `\figsrccode`, `\videosupp`, `\video`, `\tabledata`, `\tablesrccode` (elife-template.tex:86-87, 145-151, 209, 247-262).
- `BESPOKE` feature-box captions `\featurefig`/`\featuretable`: `\newcommand` re-issued at every `\begin{featurebox}`, with counters featurefigure/featuretable printing "Box N---figure M." (elife.cls:284-298; used at elife-template.tex:224).
- `BESPOKE` natbib internals patched: `\renewcommand{\NAT@nmfmt}` plus five `\xpatchcmd{\NAT@citex}` so author and year in every in-text citation print bold italic grey (elife.cls:113-139; reached by `\cite`/`\citep` at elife-template.tex:215). natbib has no published option for the author-year font, and doing it per citation in the emitter would mean re-implementing natbib's grouping logic.
- `BESPOKE` (lower confidence) authblk internals: `\renewcommand{\AB@affilsepx}{; ...}` (elife.cls:236) and `\patchcmd{\@author}` inserting the margin metadata between author list and affiliations (elife.cls:248-249). authblk documents no parameter for either; a hand-laid `\author{}` might approximate it but equivalence is not shown.

## Class setting
- Class: `class.extarticle` options: `9pt` (passed through by `\DeclareOption*{\PassOptionsToClass...}`, elife.cls:18, 21; sample elife-template.tex:5). The wrapper class `elife` (zip-local) adds `lineno` (elife.cls:10, 44-45), `onehalfspacing`, `doublespacing` (elife.cls:13-16, 69-70). The wrapper is bespoke (see Blockers).
- Class-native vocabulary used (all defined in zip-local elife.cls, so bespoke, not a published class's vocabulary): `\author[1*]{}`/`\affil[1]{}` (authblk), `\authfn{n}`, `\corr{email}{initials}`, `\contrib[]{}`, `\presentadd[]{}`, `abstract`, `\figsupp[]{}{}`, `\figsuppdata`, `\figsuppsrccode`, `\figdata`, `\figsrccode`, `\videosupp`, `\video`/`\videodata`/`\videosrccode`, `\tabledata`, `\tablesrccode`, `featurebox`, `\featurefig`, `fullwidth`, `appendixbox`, `\FIG \TABLE \EQ \BOX \VIDEO \FIGSUPP \FIGDATA \FIGSRCCODE \TABLEDATA \TABLESRCCODE \VIDEODATA \VIDEOSRCCODE \VIDEOSUPP`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | elife.cls:21; elife-template.tex:5 | `class.extarticle` | 9pt |
| font size / paper | elife.cls:18, 90 | `page.class-options` | 9pt; letterpaper (given to geometry) |
| page geometry | elife.cls:81-90 | `page.geometry` | left=6cm, marginparwidth=4cm, marginparsep=0.5cm, right=1.3cm, top=2cm, bottom=2.5cm, headheight=21pt, headsep=2\baselineskip, columnsep=2em, letterpaper |
| margin notes | elife.cls:227, 249 | `note.marginpar` | `\reversemarginpar`; `\marginpar{\raggedright\footnotesize ...}` for the correspondence/contribution/present-address block |
| full-width float material | elife.cls:91, 306-309; elife-template.tex:204-210 | `NEW:page.adjustwidth` | `adjustwidth{-4.5cm}{}`, `\hsize=\linewidth` inside the `fullwidth` wrapper |
| line spacing | elife.cls:68-70 | `sp.linespread` | 1.2 (1.5 with onehalfspacing, 2.0 with doublespacing) |
| line numbers | elife.cls:10, 44-45; elife-template.tex:5 | `sp.draft-lineno` | `\linenumbers`; `\internallinenumbers` with `\linenumbersep` +1em / +2em inside boxes (elife.cls:301, 475) |
| microtype | elife.cls:65 | `sp.microtype` | defaults |
| ragged text | elife.cls:232-233, 253, 260 | `sp.ragged` | `\raggedright` in title, authors, affiliations, abstract |
| paragraph lengths | elife.cls:260 | `sp.lengths` | `\parindent=0pt` in abstract only |
| encoding | elife.cls:58-59 | `font.fontenc-t1` | `fontenc[T1]`, `inputenc[utf8]` |
| roman + math face | elife.cls:60 | `font.mathptmx` | `stix` (Times-like text and math; the text default is then overridden to sans) |
| sans body face | elife.cls:61 | `NEW:font.opensans` | `opensans[default]` |
| mono face | elife.cls:62 | `font.family-default` | `\renewcommand{\ttdefault}{lmtt}` |
| xe/lua branch fonts | elife.cls:50-56 | `font.unicode-math`, `font.fontspec` | `\setmonofont[Scale=MatchUppercase]{Latin Modern Mono}`, `\setmathfont{XITSMath-Regular}` (not the pdfLaTeX path) |
| font sizes | elife.cls:158, 169-179, 253 | `font.size-commands` | `\fontsize{22}{27}\selectfont` title; `\Large`, `\large`, `\small`, `\footnotesize` |
| colours | elife.cls:72-76 | `color.xcolor` | eLifeDarkBlue 273B81, eLifeLightBlue 0A9DD9, eLifeMediumGrey 6D6E70, eLifeLightGrey 929497 (HTML model) |
| header/footer | elife.cls:145-161 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\addtolength{\headwidth}` + marginparsep + marginparwidth, `\rfoot{\small\color{eLifeMediumGrey}...}`, `\headrulewidth=0pt`, `\footrulewidth=0.4pt`, `\preto{\footrule}{\color{...}}` |
| page X of Y | elife.cls:146, 158 | `pgnum.lastpage` | `\thepage\space of\space\pageref{LastPage}` |
| title block | elife.cls:251-257 | `front.maketitle` + `front.titling` | reduction: `\vskip36pt`, title in eLifeDarkBlue `\raggedright\bfseries` 22/27, `\vskip16pt`, author block, `\vskip8pt` (`\pretitle`/`\posttitle`/`\preauthor`/`\postauthor`) |
| authors and affiliations | elife.cls:79, 232-236; elife-template.tex:21-26 | `front.authblk` | `\Authfont=\bfseries\large\raggedright`, `\Affilfont=\mdseries\large\raggedright`, `\Authands={, }`, `\affilsep=16pt`; the `;` affiliation separator is an authblk internal (blocker) |
| author footnote symbols | elife.cls:188-195; elife-template.tex:22-24 | `front.authblk` | `\authfn{n}` = symbol number n+1 via `alphalph`; reduction: literal `*`, `\dagger`, `\ddagger`, `\S`, `\P` markers |
| abstract | elife.cls:259-268; elife-template.tex:46-48 | `abs.kernel` | `\renewenvironment{abstract}`: 2pt eLifeMediumGrey `\rule{\textwidth}` above and below, `\vskip16pt`, heading `\large\bfseries` eLifeLightBlue |
| headings | elife.cls:167-183 | `head.titlesec` | `explicit`; section `\color{eLifeMediumGrey}\Large\bfseries`; subsection `\large\bfseries`; subsubsection `\large`; paragraph `\color{eLifeMediumGrey}\large`; spacing before 3ex/2.5ex/2ex/1.5ex with plus/minus, after 0pt, left 0pc |
| heading numbering | elife.cls:166 | `num.secnumdepth` | `secnumdepth=0` (all headings unnumbered) |
| appendix | elife-template.tex:303-329; elife.cls:464-478 | `num.appendix` | `\appendix`, then `appendixbox` blocks |
| counters | elife.cls:467-469 | `num.counters` | `\setcounter{figure}{0}`, `\setcounter{table}{0}`, `\newcounter{appendix}` |
| page break | elife.cls:470 | `pg.break` | `\clearpage` per appendix box |
| lists | elife-template.tex:273-287; elife.cls:185-186 | `list.kernel`, `list.enumitem` | enumerate, itemize, description; `\setlist{noitemsep}` |
| inline marks | elife-template.tex:115, 215 | `mark.kernel` | `\emph`, `\textbf`, `\texttt` |
| units | elife-template.tex:13-14, 267 | `mark.siunitx` | `\DeclareSIUnit\Molar{M}`, `\SI{..}{..}` |
| chemistry markup | elife-template.tex:12, 267 | `art.content-package` | `mhchem[version=4]`, `\ce{...}` (inline content) |
| maths | elife.cls:41; elife-template.tex:231-237 | `math.amsmath` | `equation` with label; `\equationautorefname` set to "Eq." |
| figures | elife-template.tex:204-211, 241-263; elife.cls:72 | `fig.graphicx` | `\includegraphics[width=0.95\linewidth]`, `[width=\linewidth]`, `[width=6cm]` |
| wrapped figure | elife-template.tex:194-198; elife.cls:275-276 | `fig.wrapfig` | `wrapfigure{l}{.45\textwidth}`; a 1pt rule is appended after it (`\AtEndEnvironment`, reducible) |
| float rules | elife.cls:271-272 | `fig.placement` | kernel hooks `\topfigrule`, `\botfigrule` = 1pt rule with 8pt skip |
| new float type | elife.cls:274, 280 | `NEW:fig.newfloat` | `\DeclareFloatingEnvironment[placement=btp,name=Box]{featurebox}` |
| table | elife-template.tex:61-81 | `tbl.tabular` | `table[bt]`, tabular `{S l l l r}` |
| table rules | elife.cls:78; elife-template.tex:65-80 | `tbl.booktabs` | `\toprule \midrule \bottomrule` |
| decimal column | elife-template.tex:13, 64, 66 | `tbl.siunitx` | `S` column, header cell braced `{Speed (mph)}` |
| captions | elife.cls:96-101, 281, 312-313 | `cap.caption` | labelfont=bf, labelsep=period, justification=raggedright, singlelinecheck=false, tableposition=top, font=small; featurebox font={Large,bf,color=eLifeDarkBlue}; appendix figure/table name and colour |
| caption command | elife-template.tex:62, 196; elife.cls:312 | `cap.kernel` | `\caption`; `\captionof` (caption package) in appendix boxes |
| framed feature box and appendix box | elife.cls:42, 299-303, 474 | `box.mdframed` | feature box: linewidth=0pt, backgroundcolor=eLifeLightBlue!10, fontcolor=eLifeDarkBlue; appendix box: hidealllines=true, backgroundcolor=eLifeLightBlue!10, fontcolor=eLifeDarkBlue, leftline=true, linecolor=eLifeLightBlue, linewidth=1em |
| citations | elife.cls:106-107; elife-template.tex:215 | `bib.natbib` | `\bibfont=\small`; `\cite`, `\citep` (the font patch is a blocker) |
| bibliography style | elife.cls:109-111; elife-template.tex:296-297 | `bib.bibtex-bst` | `vancouver-elife.bst` (zip-local, modified from a public vancouver-authoryear style); fallback `apalike` if missing; `\nocite{*}`, `\bibliography{elife-sample}` |
| cross-references | elife-template.tex:62, 197, 208, 244; elife.cls:485-525 | `xref.kernel`, `xref.hyperref` | `\label` with prefixes fig: tab: eq: box:; `\autoref`; autorefnames "Eq.", "figure Supplement", "source data", "Video", "video", "source code"; `\autoref` wrapped as `\emph{\textbf{...}}` |
| hyperlinks | elife.cls:480-481 | `meta.hyperref` | colorlinks=true, allcolors=black, citecolor=eLifeMediumGrey, linkcolor=eLifeMediumGrey, urlcolor=eLifeLightBlue, hypertexnames=false |
| URL style | elife.cls:482; elife-template.tex:84 | `meta.url` | `\urlstyle{sf}`, `\url` |
| language | elife.cls:23 | `lang.babel` | english |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| options lineno, onehalfspacing, doublespacing, pass-through | elife.cls:9-20, 45, 69-70 | yes | `sp.draft-lineno`, `sp.linespread` 1.5 or 2.0, `page.class-options` 9pt |
| engine switch `\ifxetexorluatex` | elife.cls:28-63 | yes | pick the pdfLaTeX branch (T1, utf8, stix, opensans, lmtt) |
| helper packages: calc, etoolbox, regexpatch, ifxetex, ifluatex, silence (`\WarningFilter`, no visual effect) | elife.cls:25-28, 93-94 | yes | support code for the items below; nothing to emit |
| `\authfn` with `alphalph` | elife.cls:188-195 | yes | literal footnote symbols in `\author` markers |
| `\corr`, `\contrib`, `\presentadd`, `\deceased`, `\themetadata` | elife.cls:197-225, 238-246 | yes (text) | the strings are content; emitted as one `\marginpar` (`note.marginpar`, `\raggedright\footnotesize`, bold "*For correspondence:", `\bigskip` separators, "Present address:") |
| `\patchcmd{\@author}` margin insertion, `\AB@affilsepx` `;` | elife.cls:236, 248-249 | no (not shown) | patches authblk internals; see Blockers |
| `\renewcommand{\maketitle}` | elife.cls:251-257 | yes | `front.titling`, parameters in the component map |
| `\renewenvironment{abstract}` | elife.cls:259-268 | yes | kernel pieces only: `abs.kernel` wrapper with `\rule`, `\vskip`, `\textcolor` |
| `\topfigrule`, `\botfigrule`, wrapfigure end rule | elife.cls:271-272, 276 | yes | rule + skip parameters under `fig.placement` and `fig.wrapfig` |
| `featurebox` float, mdframed injected with `\apptocmd`/`\pretocmd` | elife.cls:280-281, 299-303 | yes (frame and float) | `NEW:fig.newfloat` + `box.mdframed` wrapper inside the float + `cap.caption` font |
| `\featurefig`, `\featuretable`, counters featurefigure/featuretable | elife.cls:284-298 | no | hand-rolled counters printing text; Blocker |
| `fullwidth` environment | elife.cls:306-309 | yes | `NEW:page.adjustwidth` `{-4.5cm}{}` plus `\hsize=\linewidth` |
| `appendixbox`, counter appendix, `\patchcmd{\ttlf@section}` colour swap | elife.cls:464-478 | yes, with caveat | emitter writes per box: `\clearpage`, counter resets, literal "Appendix N" heading, `mdframed` options in the map, a `\titleformat` section colour change. The caption names "Appendix N---figure" (elife.cls:311-314) must also be written literally; not shown to match |
| supplement system: `\figsupp`, `\figdata`, `\figsrccode`, `\videosupp`, `\video*`, `\tabledata`, `\tablesrccode`, `suppinfo` stream | elife.cls:316-462 | no | output stream and end-of-document `\input` with seven counters; Blocker |
| natbib patches | elife.cls:113-139 | no | patches natbib internals; Blocker |
| `\FIG \TABLE \EQ \BOX \VIDEO` and the `\FIGSUPP`-style aliases, renamed `\autoref`, `...autorefname` | elife.cls:485-525 | yes | `\autoref{prefix:label}` with `\emph{\textbf{...}}` wrapper (`xref.hyperref`); the supplement targets depend on the blocked counters |
| `vancouver-elife.bst` | elife-template.tex:296-297; elife.cls:109-111 | yes by lib definition | `bib.bibtex-bst`: the .bst is a parameter and ships with the zip; only partly read |

## Content-opaque
- mhchem `\ce{C32H64NO7S}` (elife-template.tex:267); `lipsum` filler text (elife-template.tex:11); placed figures frog.jpg, elife-13214-fig7.pdf, elife-18156-fig2.pdf and `example-image` (elife-template.tex:195, 206, 223, 242); automobile table data (elife-template.tex:66-79); elife-sample.bib (5 entries). `example-image` comes from the TeX distribution and is not shipped in the zip.

## Lib changes
- New ways proposed:
  - `NEW:fig.newfloat`: `newfloat` package, `\DeclareFloatingEnvironment[placement=,name=,within=,fileext=]`; pdf. W1 on CTAN; W2 options and strings only; W3 declares any new float type (box, scheme, listing); W4 one preamble line plus a body environment. `fig.float` is the `float` package, a different package.
  - `NEW:page.adjustwidth`: `changepage` `adjustwidth{left}{right}` (also `adjustwidth*`); pdf. W1 on CTAN; W2 two lengths; W3 widens or indents any block, used for full-width figures and tables; W4 body wrapper around a node's content. grep of `_Lib.md` for adjustwidth and changepage found nothing.
  - `NEW:font.opensans`: `opensans` package with options `default`, `scale`; pdf. W1 on CTAN; W2 options; W3 a typeface family, parallel to `font.libertine` and `font.charter`; W4 one preamble line. `font.helvet` lists helvet, avant, tgheros and sfmath, not Open Sans; a reviewer may prefer to fold this into a general sans group.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
