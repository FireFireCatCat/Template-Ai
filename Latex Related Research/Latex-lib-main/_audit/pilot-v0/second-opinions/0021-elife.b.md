no

# 0021-elife: eLife article template (Overleaf/writeLaTeX `elife.cls` v1.11)

- Unverified: read from the source, not compiled.
- Source: Source/0021-elife/ (origin: https://cdn.elifesciences.org/author-guide/elife-latex-template.zip; licence: not established)
- Kind: journal
- Lib: v0 (the snapshot read)
- Engine: pdfLaTeX-compatible (`elife.cls:57-63` is the pdfTeX branch: T1, stix, opensans). A XeLaTeX/LuaLaTeX branch also exists (`elife.cls:49-56`: `unicode-math`, `opensans`, `\setmonofont`, `\setmathfont`). It also needs BibTeX and two runs (the `.suppinfo` stream file, `elife.cls:335-338,456-462`).
- Main file: elife-template.tex (other samples: none)
- Read: main yes, zip-local classes and styles partly (`elife.cls` all 526 lines; `vancouver-elife.bst` 1935 lines read by outline plus header, name formatting, `article`, `output.bibitem`, `begin.bib`; the many other entry-type functions were not read)

## Verdict
No. The page, fonts, headings, header/footer, abstract, boxes and most of the title block map to lib ways. Three zip-local mechanisms do not reduce. The first is the figure-supplement and source-data machinery, which writes captions to a `.suppinfo` file and re-inputs them at the end of the document with hand-rolled counters. The second is the `\xpatchcmd` surgery on natbib's `\NAT@citex`, which restyles author and year in citations. The third is the `\patchcmd` into authblk's `\@author`, which injects the margin metadata. A published natbib, authblk or caption option cannot express any of the three. A wrong yes costs more, so this is `no`.

Deciding judgement, stated so a reader can overturn it: `elife.cls` is not on CTAN (ctan.org/pkg/elife returned 404). It reaches the reader only as the hand-written Overleaf-made file in this zip (`elife.cls:1-3`; licence not established), and it redefines `\maketitle`, `abstract` and patches natbib, authblk and titlesec internals. I therefore treat it as zip-local (not published under W1) and decompose it. If the project instead accepts a publisher-released class with public documentation (the second branch of W1) as `class.elife`, then the sample's own preamble adds only `lipsum`, `mhchem` and `siunitx` (`elife-template.tex:11-14`), and the verdict would flip to `yes`. The rubric's "if you cannot show it, the answer is no" decides it here.

## Blockers
- `BESPOKE` figure-supplement, source-data, source-code and video machinery: counters `figsupp data srccode fsdata fssrccode video videosupp`, a `newfile` output stream `suppinfo`, `\figsupp`/`\figdata`/`\figsrccode`/`\videosupp`/`\video*`/`\tabledata`/`\tablesrccode`, `\AtBeginEnvironment{figure}`, `\AtEndDocument{...\input{\jobname.suppinfo}}`. It defers supplement figures to the end of the PDF and fakes `\refstepcounter{figure}` inside the stream (`elife.cls:316-462`; used at `elife-template.tex:86-87,147-151,209,247-262`)
- `BESPOKE` natbib internals patched five times with `\xpatchcmd{\NAT@citex}` plus `\renewcommand{\NAT@nmfmt}` so that author names and years print bold-italic grey in citations (`elife.cls:112-139`). This is not a natbib option, so it fails W2.
- `BESPOKE` `\patchcmd{\@author}{\AB@authlist\\[\affilsep]\AB@affillist}{...\marginpar{...\themetadata}...}` inserts a margin block inside authblk's author list (`elife.cls:248-249`). It is irreducible because it rewrites an authblk internal and places the marginpar at a point no option reaches. The text inside it (`\corr`, `\contrib`, `\presentadd`, `\deceased`) is reducible.
- `BESPOKE` (secondary, reduction not shown) `featurebox` helper commands: counters `featurefigure`/`featuretable` reset per box, `\newcommand{\featurefig}` and `\featuretable` defined inside `\AtBeginEnvironment{featurebox}` and printing hand-built "Box N---figure M." labels (`elife.cls:284-298`). It may reduce to caption's `\DeclareCaptionType` plus `\renewcommand\the...`, but I cannot show it, so I do not count it as reducible.

## Class setting
- Class: `class.extarticle`, the base class loaded by the zip-local `elife.cls` via `\LoadClass{extarticle}` (`elife.cls:21`). `elife.cls` itself is not written as a `class.elife` way (see Verdict); it is decomposed below. The sample's options are `9pt,lineno` (`elife-template.tex:5`). `lineno` is consumed by `\DeclareOption{lineno}` (`elife.cls:9-10`), `onehalfspacing` and `doublespacing` set linespread (`elife.cls:12-16,69-70`), and every other option is passed to `extarticle` (`elife.cls:18`). `extarticle` is the CTAN `extsizes` class, a published class not bundled here, so its source was not read. The source of `elife.cls` is in the zip, and I read it in full.
- Class-native vocabulary used: `\author[1*]{...}`, `\author[1,2\authfn{1}\authfn{3}]{...}`, `\affil[n]{...}` (authblk), `\corr{email}{initials}`, `\contrib[mark]{text}`, `\presentadd[mark]{text}`, `\authfn{n}`; `abstract` env; `featurebox` env with `\featurefig`; `fullwidth` env; `appendixbox` env; `\figsupp[short]{long}{graphic}`, `\figsuppdata`, `\figsuppsrccode`, `\figdata`, `\figsrccode`, `\videosupp`, `\video`, `\videodata`, `\videosrccode`, `\tabledata`, `\tablesrccode`; cross-reference shortcuts `\FIG \TABLE \EQ \BOX \VIDEO \FIGSUPP \FIGDATA \FIGSRCCODE \TABLEDATA \TABLESRCCODE \VIDEODATA \VIDEOSRCCODE \VIDEOSUPP`. Unnumbered headings (`secnumdepth=0`), so `\nameref` is used rather than `\ref` (`elife-template.tex:115`).

## Component map
Files: `T` = elife-template.tex, `C` = elife.cls, `B` = vancouver-elife.bst.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | T:5, C:21 | `class.extarticle` | 9pt; lineno and spacing options intercepted by `elife` |
| paper and size | T:5, C:90 | `page.class-options` | 9pt, letterpaper |
| page geometry | C:81-90 | `page.geometry` | left=6cm, marginparwidth=4cm, marginparsep=0.5cm, right=1.3cm, top=2cm, bottom=2.5cm, headheight=21pt, headsep=2\baselineskip, columnsep=2em, letterpaper |
| full-width block | C:91, 306-309; T:202-211 | `NEW:pg.adjustwidth` | `adjustwidth{-4.5cm}{}` (changepage) plus `\hsize=\linewidth` |
| margin notes | C:227, 248-249 | `note.marginpar` | `\reversemarginpar`; `\marginpar{\raggedright\footnotesize ...}` (the injection itself is a blocker) |
| line numbers | C:44-45, 301, 475; C:473 | `sp.draft-lineno` | lineno; `\linenumbers`; `\internallinenumbers` with `\linenumbersep` +1em (featurebox) or +2em (appendixbox); `\nolinenumbers` before appendixbox |
| line spacing | C:67-70 | `sp.linespread` | `\linespread{1.2}`; 1.5 or 2.0 by option |
| microtype | C:65 | `sp.microtype` | defaults |
| encodings | C:58-59 | `font.fontenc-t1` | fontenc T1; inputenc utf8 |
| text and maths font | C:60 | `font.mathptmx` | `stix` (Times-like text and maths; same family as txfonts in the lib line). Check whether the lib wants stix listed |
| default sans | C:61 | `font.helvet` | `opensans` with option `default`, a sans package made the document font. Check whether the lib wants a separate way |
| mono default | C:62 | `font.family-default` | `\renewcommand{\ttdefault}{lmtt}` |
| XeLaTeX branch | C:49-56 | `font.unicode-math`, `font.fontspec` | `\setmonofont[Scale=MatchUppercase]{Latin Modern Mono}`, `\setmathfont{XITSMath-Regular}` with BoldFont; not taken in pdf engine |
| colours | C:72-76 | `color.xcolor` | eLifeDarkBlue 273B81, eLifeLightBlue 0A9DD9, eLifeMediumGrey 6D6E70, eLifeLightGrey 929497 (HTML model) |
| language | C:23 | `lang.babel` | english |
| hyperlinks | C:480-481 | `meta.hyperref` | colorlinks=true, allcolors=black, citecolor=eLifeMediumGrey, linkcolor=eLifeMediumGrey, urlcolor=eLifeLightBlue, hypertexnames=false |
| url style | C:482; T:84 | `meta.url` | `\urlstyle{sf}`; `\url{...}` |
| cross-refs | C:485-492, 519-525; T:115, 192 | `xref.hyperref` | `\autoref`, `\nameref`; `\equationautorefname`=Eq.; `\autoref` wrapped in `\emph{\textbf{...}}` |
| header and footer | C:145-161 | `hf.fancyhdr` | `\fancyhf{}`; `\rfoot{\small\color{eLifeMediumGrey}\thepage\space of\space\pageref{LastPage}}`; headrulewidth 0pt; footrulewidth 0.4pt in grey; `\addtolength{\headwidth}{...}` |
| page X of Y | C:146, 158 | `pgnum.lastpage` | `\pageref{LastPage}` |
| title block | C:251-257; T:19, 44 | `front.titling` | reduction of the `\maketitle` redefinition (`\pretitle`/`\posttitle`/`\preauthor`/`\postauthor`, empty date): `\vskip36pt`, colour eLifeDarkBlue, raggedright, bold, `\fontsize{22}{27}`, `\vskip16pt`, author block, `\vskip8pt` |
| authors and affiliations | C:79, 232-236; T:21-26 | `front.authblk` | `\Authfont` bold large raggedright; `\Affilfont` mdseries large raggedright; `\Authands`=", "; `\affilsep`=16pt; `\AB@affilsepx` redefined (authblk internal, minor) |
| author marks and notes | C:188-223, 238-246; T:22-35 | `front.class-native` | `\authfn`, `\corr`, `\contrib`, `\presentadd`, `\deceased`; reducible to literal marks and text by the emitter (see Bespoke) |
| abstract | C:259-268; T:46-48 | `abs.class-native` | reduction as `\renewenvironment{abstract}`: parindent 0, raggedright, 2pt grey `\rule{\textwidth}{2pt}`, `\vskip16pt`, `\large\bfseries` eLifeLightBlue title, closing rule; uses `NEW:box.rule` |
| rules | C:261, 266, 271-272, 276 | `NEW:box.rule` | kernel `\rule{width}{height}` (1pt or 2pt) with `\vskip8pt`/`\vskip16pt`, `\textcolor` |
| float rules | C:271-272 | `fig.placement` | `\topfigrule` and `\botfigrule` (kernel float-separator hooks, as I recall them from the kernel; not checked against a source here) set to a 1pt rule |
| headings | C:166-183; T:51-100 | `head.titlesec` | `explicit`; `\titleformat` section {eLifeMediumGrey, \Large\bfseries}, subsection {\large\bfseries}, subsubsection {\large}, paragraph {eLifeMediumGrey, \large}, label empty, format `#1`; `\titlespacing*` 0pc, before 3ex/2.5ex/2ex/1.5ex plus-minus, after 0pt |
| heading numbering | C:166 | `num.secnumdepth` | secnumdepth=0 |
| lists | C:185-186; T:269-287 | `list.enumitem` | `\setlist{noitemsep}`; `enumerate`, `itemize`, `description` are `list.kernel` |
| table | T:61-89 | `tbl.tabular` | `table[bt]`, `tabular{S l l l r}`, `\medskip` |
| table rules | C:78; T:65-80 | `tbl.booktabs` | `\toprule \midrule \bottomrule` |
| decimal column | T:13, 64 | `tbl.siunitx` | `S` column |
| siunitx | T:13-14, 267 | `mark.siunitx` | `\SI`, `\DeclareSIUnit\Molar{M}` |
| captions | C:96-101 | `cap.caption` | labelfont={bf}, labelsep=period, justification=raggedright, singlelinecheck=false, tableposition=top, font=small |
| caption variants | C:281, 311-314; T:312 | `cap.caption` | `\captionsetup[featurebox]{font={Large,bf,color=eLifeDarkBlue}}`; per-appendix `name={Appendix N---figure }`, `font={color=eLifeDarkBlue,small}`, `skip=\smallskipamount`; `\captionof{figure}{...}` |
| figures | T:204-211, 241-263 | `fig.graphicx` | `\includegraphics[width=0.95\linewidth]` and `[width=\linewidth]` inside `figure` |
| wrapped figures | C:275-276; T:123-141, 194-198 | `fig.wrapfig` | `wrapfigure{l}{.45\textwidth}`, `wraptable{l}{.46\textwidth}`; a rule is appended after each (reducible, see Bespoke) |
| feature box float | C:274, 280 | `fig.float` | newfloat `\DeclareFloatingEnvironment[placement=btp,name=Box]{featurebox}`. newfloat is the same role as `\newfloat`, which `fig.float` names; flag if the lib wants it separate |
| feature box frame | C:299-303; T:217-227 | `box.mdframed` | `mdframed[linewidth=0pt,backgroundcolor=eLifeLightBlue!10,fontcolor=eLifeDarkBlue]` |
| appendix box | C:466-478; T:303-329 | `box.mdframed` | `mdframed[hidealllines=true,backgroundcolor=eLifeLightBlue!10,fontcolor=eLifeDarkBlue,leftline=true,linecolor=eLifeLightBlue,linewidth=1em]`, preceded by `\clearpage` and a literal "Appendix N" line |
| appendix | C:464-473; T:303 | `num.appendix` | kernel `\appendix`; `\setcounter{figure}{0}`, `\setcounter{table}{0}` per box (`num.counters`) |
| maths | C:41; T:231-237 | `math.amsmath` | amsmath; `equation`; `\mathcal`, `\text` |
| mhchem | T:12, 267 | `art.content-package` | `\usepackage[version=4]{mhchem}`, `\ce{...}`: content |
| verbatim | T:125-141, 115 | `code.verbatim` | `verbatim`, `\verb` |
| bibliography | C:106-107; T:215, 296-297 | `bib.natbib` | natbib; `\bibfont`=`\small`; `\cite`, `\citep`; `\nocite{*}` flagged for deletion in the sample |
| bib style | C:109-111; T:297; B:1-1935 | `bib.bibtex-bst` | style `vancouver-elife.bst` (zip-local, derived from a GitHub `vancouver_authoryear_bibstyle`); first author printed `\textbf{\color{eLifeMediumGrey} ...}` (B:672-674, 770); `\natexlab`, `\doiprefix` (B:1915-1918). The lib counts a `.bst` as a parameter, so I ship it. This is a judgement call, see Bespoke |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| supplement/data/video machinery and stream | C:316-462 | no | hand-rolled counters, file stream and end-of-document `\input`; see Blockers |
| natbib `\NAT@citex` patches and `\NAT@nmfmt` | C:112-139 | no | edits natbib's code, not options; see Blockers |
| `\patchcmd{\@author}` marginpar injection | C:248-249 | no | rewrites an authblk internal; see Blockers |
| `featurefig` / `featuretable` counters and commands | C:284-298 | not shown | possibly caption `\DeclareCaptionType` plus `\renewcommand\the...`, not demonstrated |
| `\corr \contrib \presentadd \deceased \themetadata \authfn` accumulators | C:188-246 | yes | the emitter inlines the strings: "*For correspondence:", emails, equal-contribution lines, present addresses; marks as literal `\fnsymbol`-style characters (`mark.kernel`) |
| `\maketitle` redefinition | C:251-257 | yes | `front.titling` hooks, as in the table |
| `abstract` redefinition | C:259-268 | yes | `\renewenvironment` over `NEW:box.rule`, `color.xcolor`, `font.size-commands` |
| `\topfigrule`, `\botfigrule`, `\AtEndEnvironment{wrapfigure}` rule | C:271-276 | yes | the emitter prints `\rule` after the wrapfigure and sets the kernel hooks; `NEW:box.rule`, `fig.placement` |
| `fullwidth` env | C:306-309 | yes | `NEW:pg.adjustwidth` |
| `appendixbox` env and `\patchcmd{\ttlf@section}` | C:466-478, 471 | yes | the patch recolours section titles (eLifeMediumGrey to eLifeDarkBlue) once; reducible to a re-issued `\titleformat{\section}` with eLifeDarkBlue (`head.titlesec`); box via `box.mdframed`; "Appendix N" printed literally |
| appendix caption renaming | C:311-314 | yes | `\captionsetup` per appendix with literal names (`cap.caption`) |
| `\FIG \TABLE \EQ \BOX \VIDEO ...` aliases, `\autoref` wrapper | C:493-525 | yes for `\FIG \TABLE \EQ \BOX`; no for the supplement ones | aliases for `\autoref{prefix:label}` and `\emph{\textbf{...}}`. The `\FIGSUPP \FIGDATA \FIGSRCCODE \TABLEDATA \TABLESRCCODE \VIDEO* ` aliases only make sense with the supplement machinery (`\figsuppautorefname` etc., C:488-492) |
| engine switch `\ifxetexorluatex` | C:30-63 | yes | choose the branch per engine |
| `\IfFileExists{vancouver-elife.bst}` fallback to apalike | C:109-111 | yes | always `\bibliographystyle{vancouver-elife}` |
| `silence` `\WarningFilter` | C:93-94 | yes | no printed effect; omit |
| `vancouver-elife.bst` | B:1-1935 | judgement | a BibTeX stack program, modified from a published style, with eLife colour markup. Treated as the `.bst` parameter of `bib.bibtex-bst` per the lib. If the project counts a modified zip-local `.bst` as bespoke, this is another `BESPOKE`; the verdict is `no` either way |

## Content-opaque
- `mhchem` `\ce{C32H64NO7S}` inline (elife-template.tex:267). Lorem text (`\lipsum`), the table body, the equation (T:232-236), the `.bib` entries (elife-sample.bib), the PDF and JPEG figures (elife-18156-fig2.pdf, elife-13214-fig7.pdf, frog.jpg; shipped assets, no fonts missing) are content. No TikZ or PSTricks is used, so no `ART`.

## Lib changes
- New ways proposed:
  - `NEW:pg.adjustwidth`: `changepage` `adjustwidth` environment (also `chngpage`; memoir has the same command). Engine pdf. W1: on CTAN. W2: the left and right indents are lengths. W3: generic, for any wide block. W4: a body wrapper around a node. Not in the lib (grepped `adjustwidth`, `changepage`).
  - `NEW:box.rule`: kernel `\rule{w}{h}` (also `\hrule`, `\hrulefill`). Engine pdf. W1: kernel. W2: width, height and colour are the parameters. W3: any divider. W4: printed between or around nodes. Not in the lib (grepped `rule`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes for the consolidator: `stix` and `opensans` were mapped to `font.mathptmx` and `font.helvet` as package families, and newfloat to `fig.float`. Say if you want them split into their own ways.
