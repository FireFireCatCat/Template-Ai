yes

# 0021-elife: eLife article template (eLife's own LaTeX kit, built by Overleaf)

- Unverified: read from the source, not compiled.
- Source: Source/0021-elife/ (origin: https://cdn.elifesciences.org/author-guide/elife-latex-template.zip; licence: not established)
- Kind: journal
- Lib: v1
- Engine: pdfLaTeX-compatible (elife.cls:49-63 branches on `\ifxetexorluatex`; the pdfTeX branch at 57-63 loads T1, inputenc, stix, opensans, lmtt; the XeLaTeX/LuaLaTeX branch at 49-56 uses unicode-math, opensans, XITS and is not taken under pdfTeX)
- Look carried by: class (everything printed is defined in elife.cls; the sample adds option settings, three content packages and one `\DeclareSIUnit`)
- Class origin: publisher-official
- Main file: elife-template.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (elife.cls lines 1-526 and vancouver-elife.bst lines 1-1935; no .sty/.def/.cfg/.clo present)

## Verdict
The look is carried entirely by `elife.cls`, which came from eLife's own author-guide page, so under the rubric's W1 ruling ("eLife's kit is published") it is the single way `class.elife`. The sample adds only content, the class options `9pt,lineno` (elife-template.tex:5), packages for content (lipsum, mhchem, siunitx) and one `\DeclareSIUnit` (elife-template.tex:14); it defines no macro of its own. No `ART`, `EXTERNAL` or `UNMAPPED` item was found. The `yes` rests on that W1 ruling: the class holds code that would be irreducible if it were zip-local (natbib internals patched, an output stream replayed at `\AtEndDocument`, a titlesec internal patched), listed under "Bespoke code".

## Blockers
none

## Class setting
- Class: `class.elife` options: `9pt` (passed to the base class `extarticle`, elife.cls:18,21), `lineno` (elife.cls:9-10,45); `onehalfspacing`, `doublespacing` exist (elife.cls:13-16,69-70) but the sample does not use them. Version `2022/06/01, v1.11` (elife.cls:6). Base class `extarticle` (extsizes, CTAN) is an internal load, not a separate way here.
- Class-native vocabulary used: `\title`, `\author[labels]{}` and `\affil[label]{}` (authblk), `\corr{email}{initials}`, `\contrib[\authfn{n}]{}`, `\presentadd[\authfn{n}]{}`, `\authfn{n}`, redefined `\maketitle` and `abstract`, unnumbered `\section` to `\paragraph`, env `featurebox` with `\featurefig`, env `fullwidth`, `\figsupp[short]{full}{content}`, `\figsuppdata`, `\figsuppsrccode`, `\figdata`, `\figsrccode`, `\videosupp`, `\video`, `\videodata`, `\videosrccode`, `\tabledata`, `\tablesrccode`, label prefixes `fig: figsupp: figdata: figsrccode: video: viddata: vidsrccode: videosupp: tab: tabdata: tabsrccode: eq: box:` with the `\FIG \FIGSUPP \TABLE \EQ \BOX \FIGDATA \FIGSRCCODE \TABLEDATA \TABLESRCCODE \VIDEO \VIDEODATA \VIDEOSRCCODE \VIDEOSUPP` cross-reference macros, `\autoref` redefined to bold italic, `\appendix` plus env `appendixbox`, `\captionof`, `wrapfigure`, bibliography style fixed by the class to `vancouver-elife` (elife.cls:109-111).

## Component map
Rows marked [sample] are what an emitter writes; rows marked [class] are fixed inside `class.elife` and shown so the reduction is on record.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class [sample] | elife-template.tex:5 | `class.elife` | `\documentclass[9pt,lineno]{elife}` |
| text size [sample] | elife-template.tex:5; elife.cls:18,21 | `page.class-options` | `9pt` (to extarticle); paper `letterpaper` is set in geometry |
| line numbers [sample] | elife-template.tex:5; elife.cls:9-10,44-45,301,475 | `sp.draft-lineno` | package `lineno`, `\linenumbers`; `\linenumbersep` +1em in featurebox, +2em in appendixbox, `\nolinenumbers` before appendix box |
| extra packages [sample] | elife-template.tex:11-14 | `art.content-package`, `mark.siunitx` | `mhchem[version=4]` (inline `\ce`, content); `siunitx` with `\DeclareSIUnit\Molar{M}`; `lipsum` is dummy text (content, see Content-opaque) |
| title and authors [sample] | elife-template.tex:19-26,44; elife.cls:79,232-236 | `front.maketitle`, `front.authblk` | `\author[1*]{..}` `\affil[1]{..}`; `\Authfont`=`\bfseries\large\raggedright`, `\Affilfont`=`\mdseries\large\raggedright`, `\Authands` = comma and space, `\affilsep`=16pt |
| author notes in margin [sample] | elife-template.tex:28-35; elife.cls:197-225,238-249 | `front.class-native`, `note.marginpar` | `\corr` `\contrib` `\presentadd` `\authfn`; metadata set in `\marginpar{\raggedright\footnotesize..}`; `\reversemarginpar` (elife.cls:227) |
| title block [class] | elife.cls:251-257 | `front.class-native` | `\vskip36pt`, title `\color{eLifeDarkBlue}\raggedright\bfseries\fontsize{22}{27}`, `\vskip16pt`, author block, `\vskip8pt` |
| abstract [sample] | elife-template.tex:46-48; elife.cls:259-268 | `abs.class-native` | 2pt `\rule{\textwidth}` in eLifeMediumGrey above and below, `\parindent` 0pt, heading `\large\bfseries` eLifeLightBlue, `\vskip16pt`/`\vskip8pt` |
| page geometry [class] | elife.cls:81-90 | `page.geometry` | left=6cm, marginparwidth=4cm, marginparsep=0.5cm, right=1.3cm, top=2cm, bottom=2.5cm, headheight=21pt, headsep=2\baselineskip, columnsep=2em, letterpaper |
| header and footer [class] | elife.cls:145-161,456-462 | `hf.fancyhdr`, `pgnum.lastpage` | `\fancyhf{}`, `\rfoot{\small\color{eLifeMediumGrey}\thepage\space of\space\pageref{LastPage}}`, headrule 0pt, footrule 0.4pt in eLifeMediumGrey, `\headwidth` widened by marginparsep+marginparwidth; footer cleared on the supplement pages at end of document |
| headings [sample] | elife-template.tex:51-102; elife.cls:166-183 | `head.titlesec`, `num.secnumdepth` | `titlesec[explicit]`; section `\color{eLifeMediumGrey}\Large\bfseries`, subsection `\large\bfseries`, subsubsection `\large`, paragraph `\color{eLifeMediumGrey}\large`; `\titlespacing*` 0pc / 3ex+4-3pt, 2.5ex, 2ex, 1.5ex / 0pt; `secnumdepth`=0 (unnumbered) |
| line spacing and shape [class] | elife.cls:65,68-70 | `sp.linespread`, `sp.microtype` | `\linespread{1.2}` (1.5 or 2.0 by option); `microtype` defaults |
| manual spacing and rules [class] | elife.cls:261-272,276 | `sp.manual-space`, `sp.rule` | `\vskip`, `\rule{\linewidth}{1pt}` for `\topfigrule`/`\botfigrule` and after `wrapfigure` |
| text fonts [class] | elife.cls:58-62 | `font.fontenc-t1`, `font.helvet`, `font.mathptmx`, `font.family-default` | `fontenc[T1]`, `inputenc[utf8]`, `opensans[default]` (sans text face), `stix` (math, Times-like family), `\renewcommand{\ttdefault}{lmtt}` |
| sizes [class] | elife.cls:169-179,253 | `font.size-commands` | `\Large`, `\large`, `\fontsize{22}{27}\selectfont` |
| colours [class] | elife.cls:72-76 | `color.xcolor` | eLifeDarkBlue 273B81, eLifeLightBlue 0A9DD9, eLifeMediumGrey 6D6E70, eLifeLightGrey 929497 (HTML model) |
| language [class] | elife.cls:23 | `lang.babel` | `[english]` |
| lists [sample] | elife-template.tex:158-173,273-287; elife.cls:185-186 | `list.kernel`, `list.enumitem` | `enumerate` `itemize` `description`; `\setlist{noitemsep}` |
| marks [sample] | elife-template.tex:180,215; elife.cls:346 | `mark.kernel` | `\emph`, `\textbf`, `\texttt` |
| math [sample] | elife-template.tex:231-237; elife.cls:41 | `math.amsmath` | `equation` with `\label{eq:CLT}`, `\text`, `\frac`, `\sum`, `\mathcal`; amsmath loaded by the class; `\equationautorefname`=Eq. (elife.cls:485) |
| table [sample] | elife-template.tex:61-89; elife.cls:78 | `tbl.tabular`, `tbl.booktabs`, `tbl.siunitx` | `table[bt]`, `tabular{S l l l r}`, `\toprule \midrule \bottomrule`; S column from siunitx |
| captions [class] | elife.cls:96-101,281,312-313 | `cap.caption`, `cap.kernel` | `labelfont=bf`, `labelsep=period`, `justification=raggedright`, `singlelinecheck=false`, `tableposition=top`, `font=small`; featurebox caption `font={Large,bf,color=eLifeDarkBlue}`; appendix captions `name={Appendix N---figure }`, `font={color=eLifeDarkBlue,small}` |
| figures [sample] | elife-template.tex:194-211,241-263; elife.cls:72 | `fig.graphicx` | `figure`, `\includegraphics[width=\linewidth]` and `[width=\hsize]` |
| wrapped figure [sample] | elife-template.tex:194-198; elife.cls:275-276 | `fig.wrapfig` | `wrapfigure{l}{.45\textwidth}`; rule `\rule{\hsize}{1pt}` added after it with `\AtEndEnvironment` |
| full-width block [sample] | elife-template.tex:204-211; elife.cls:91,306-309 | `page.adjustwidth` | `fullwidth` = `adjustwidth{-4.5cm}{}` plus `\hsize=\linewidth` |
| feature box float [sample] | elife-template.tex:217-227; elife.cls:274,280-303 | `fig.newfloat`, `box.mdframed` | `\DeclareFloatingEnvironment[placement=btp,name=Box]{featurebox}`; `mdframed[linewidth=0pt,backgroundcolor=eLifeLightBlue!10,fontcolor=eLifeDarkBlue]`; `\featurefig` caption in `\small` bold eLifeDarkBlue |
| figure supplements, source data, videos [sample] | elife-template.tex:86-87,147-151,204-263; elife.cls:316-462 | `class.elife` | class-native macros and counters (`figsupp data srccode fsdata fssrccode video videosupp`); supplements are also written to `\jobname.suppinfo` and typeset at the end (elife.cls:335-338,456-462) in `minipage` (`box.minipage`) |
| appendix [sample] | elife-template.tex:303-329; elife.cls:311-314,464-478 | `num.appendix`, `box.mdframed`, `pg.break` | `\appendix`; `appendixbox` = `\clearpage`, heading `\bfseries\Large` eLifeMediumGrey, `mdframed[hidealllines=true,backgroundcolor=eLifeLightBlue!10,fontcolor=eLifeDarkBlue,leftline=true,linecolor=eLifeLightBlue,linewidth=1em]`; figure/table counters reset |
| counters [class] | elife.cls:188-195,316-332,464-465 | `num.counters` | `\newcounter`, `\setcounter`, `\refstepcounter` for supplement and appendix numbering; `\newalphalph` symbol marks for `\authfn` |
| cross-references [sample] | elife-template.tex:113-192; elife.cls:480-525 | `xref.kernel`, `xref.hyperref` | `\label`, `\autoref` (`\nameref` is only named in text, elife-template.tex:115); macros `\FIG` etc. are `\autoref{prefix:#1}` wrappers; `\autoref` set bold italic |
| links [class] | elife.cls:480-482 | `meta.hyperref`, `meta.url` | `colorlinks=true`, `allcolors=black`, `citecolor=eLifeMediumGrey`, `linkcolor=eLifeMediumGrey`, `urlcolor=eLifeLightBlue`, `hypertexnames=false`; `\urlstyle{sf}` |
| citations [sample] | elife-template.tex:215,296-297; elife.cls:106-139 | `bib.natbib`, `bib.bibtex-bst` | `natbib`, `\bibfont` `\small`; `\bibliography{elife-sample}`, `\nocite{*}`; style `vancouver-elife.bst` set by the class; citation name and year in `\bfseries\itshape\color{eLifeMediumGrey}` |
| verbatim [sample] | elife-template.tex:115,125-141 | `code.verbatim` | `\verb`, `verbatim` (documentation text) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\DeclareSIUnit\Molar{M}` | elife-template.tex:14 | yes | siunitx declarative unit declaration: `mark.siunitx`, name Molar, symbol M |
| elife.cls as a whole | elife.cls:1-526 | n/a, published (eLife's official kit, W1) | `class.elife`; emitter writes `\documentclass[9pt,lineno]{elife}` |
| `fullwidth` env | elife.cls:306-309 | yes | `page.adjustwidth` `adjustwidth{-4.5cm}{}`, `\hsize=\linewidth` |
| float rules `\topfigrule` `\botfigrule`, wrapfigure rule | elife.cls:271-278 | yes | `sp.rule` |
| `\FIG` `\TABLE` `\VIDEO` `\EQ` `\BOX` and the `\...DATA`/`\...SRCCODE`/`\...SUPP` macros | elife.cls:493-523 | yes | aliases of `\autoref{prefix:#1}` (`xref.hyperref`) with an `\ifstrequal` optional first argument |
| natbib patching: `\renewcommand{\NAT@nmfmt}`, 5 x `\xpatchcmd{\NAT@citex}` | elife.cls:113-139 | not counted: inside the published class; would be irreducible if zip-local | patches package internals; none other |
| author-block patch `\patchcmd{\@author}`, redefined `\maketitle`, `abstract` | elife.cls:248-268 | not counted: inside the published class; the `\patchcmd` on `\@author` would be irreducible if zip-local | none |
| metadata accumulators `\corr` `\contrib` `\presentadd` (`\def`, `\appto`) | elife.cls:197-225 | not counted: inside the published class | hand-rolled lists printed in the margin; would be bespoke if zip-local |
| `featurebox` with local `\featurefig` (`\AtBeginEnvironment`, `\apptocmd`, `\pretocmd`) | elife.cls:280-303 | not counted: inside the published class | float plus mdframed is reducible; the per-box counters are hand-rolled |
| supplement machinery: output stream `suppinfo`, `\figsupp` etc., `\AtEndDocument` replay | elife.cls:316-462 | not counted: inside the published class; irreducible if zip-local (output stream written during figures and replayed at the end) | none |
| `appendixbox` with `\patchcmd{\ttlf@section}` | elife.cls:464-478 | not counted: inside the published class; the titlesec-internal patch would be irreducible if zip-local | none |
| support packages with no printed effect: calc, etoolbox, regexpatch, ifxetex, ifluatex, silence (`\WarningFilter`), newfile, alphalph | elife.cls:25-28,93-94,188-189,335 | yes | published packages used by the class code only |
| `vancouver-elife.bst` (modified from github gbhutani vancouver_authoryear_bibstyle, bst:1-26) | vancouver-elife.bst:1-1935 | n/a, published (part of eLife's official kit); the style is the parameter of `bib.bibtex-bst` | emits `\textbf{\color{eLifeMediumGrey}..}` for the first author (bst:672-675,770), `\emph` journal names, `\urlprefix\url`, `\href`+`\doiprefix`, `\natexlab`; depends on the class colour and on hyperref |

## Content-opaque
- Filler text `\lipsum[n]` (elife-template.tex:11,55,59,93,97,100,104,110,200,226,239,289,307,317).
- Included artwork inside floats: frog.jpg (elife-template.tex:195,209,252,256,311,320,327), elife-18156-fig2.pdf (206), elife-13214-fig7.pdf (242), `example-image` (223).
- Inline chemistry `\ce{C32H64NO7S}` and `\SI{..}{..}` units (elife-template.tex:267), table data (66-79), equation (232-236), the five entries of elife-sample.bib.
- Missing asset: `example-image` is the `mwe` package's file (TeX Live), not in the zip; the other images and the .bst are shipped.

## Lib changes
- New ways proposed: none (`class.elife` is a class way and needs no proposal; the class-native vocabulary is recorded under "Class setting").
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
