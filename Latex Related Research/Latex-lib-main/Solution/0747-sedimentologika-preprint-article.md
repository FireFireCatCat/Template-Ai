yes

# 0747-sedimentologika-preprint-article: Sedimentologika Preprint Article

- Unverified: read from the source, not compiled.
- Source: Source/0747-sedimentologika-preprint-article/ (origin: https://latextemplates.com/downloads/sedimentologika.zip; licence: LPPL-1.3c + OFL-1.1 (upstream font licence notice))
- Kind: journal
- Lib: v5
- Engine: needs LuaLaTeX (`fontspec` and `unicode-math` at sedimentologika.cls:592-593, `\babelfont` with babel `bidi=basic` at :92 and :596, `simpleicons` at :74, `citation-style-language` at :95; README.md:14 says "Compile with LuaLaTeX")
- Look carried by: zip-local (sedimentologika.cls, 1108 lines, is `\LoadClass{article}` plus `\RequirePackage` calls, titling/titleps/titlesec settings and `\newcommand`/`\newenvironment` wrappers; main.tex only fills fields)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
The look is carried by the zip-local `sedimentologika.cls`. ctan.org/pkg/sedimentologika is a 404 and the zip comes from latextemplates.com as a stripped redistribution (README.md:3-14), so it is not a published class. Every part of it reduces to published packages and kernel commands: `article` with `twocolumn`, `geometry`, `titleps` page styles, `titling` and `authblk` title hooks, `titlesec` headings, `textpos` blocks fed by `zref` savepos values, `datatool` for the CRediT list, and `citation-style-language` for the bibliography. The class option switches (`\if@preprint` and the others) are resolved at emit time to the `preprint` branch. I found no irreducible code and no template artwork. Two ways are proposed: `bib.csl` (the one the sample's bibliography needs) and `meta.pdf-params` (one line in the `anonymous` branch, which the sample does not use; it is the weakest point of this `yes`: if the consolidator rejects it, that line is UNMAPPED/class in an unexercised option). Missing assets are noted below.

## Blockers
none

## Class setting
- Class: `class.article` options: 10pt, a4paper, twocolumn (the zip-local class loads it at sedimentologika.cls:55, `onecolumn` when option `submission` is set at :53); the sample calls `\documentclass[preprint]{sedimentologika}` (main.tex:2). Class options of the zip-local class: `preprint` (cls:24-26), `submission` (:30), `proof` (:34), `publication` (:38), `anonymous` (:42), `longauthor` (:46), `onecolumn` (:22, declared, never read after); any other option goes to `article` (:48).
- Class-native vocabulary used (all zip-local, reduced below): `\englishvariety`, `\preprintdeclaration`, `\shorttitle`, `\authorshdr`, `\correspondingauthor`, `\CRediT`, `\keywords`, `\SedKtitle`, `\acknowledgements`, `\datacode`, `\supplementarymaterial`, `\conflictofinterest`, `\artificialintelligence`, `\funding`; `\author[n]`, `\affil[n]`, `\addbibresource`, `\printbibliography` come from `authblk` and `citation-style-language`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:2; sedimentologika.cls:51-57 | `class.article` | `\LoadClass[10pt, a4paper, twocolumn]{article}`; submission variant onecolumn (cls:53) |
| paper, size | sedimentologika.cls:55 | `page.class-options` | a4paper, 10pt |
| columns | sedimentologika.cls:55-56 | `cols.twocolumn-option` | twocolumn; `\columnsep` 8mm |
| title block above columns | sedimentologika.cls:1002-1022, 1026-1041 | `cols.twocolumn-cmd` | `\twocolumn[{\maketitle ...} \abstract{..} \vspace{\fill}]`, `\clearpage`, `\restoregeometry`, then `\twocolumn[\plainlanguagesummary{..} \vglue 2\baselineskip]` |
| page geometry | sedimentologika.cls:107-115, 991-1000, 1024 | `page.geometry` | hmargin=15mm, vmargin=20mm, headsep=2mm, footskip=5mm, marginparsep=1mm, marginparwidth=10mm; `\newgeometry` (tmargin=32mm, headheight=16mm) only when not `preprint`; `\restoregeometry` |
| abstract width | sedimentologika.cls:104, 1017 | `page.adjustwidth` | `changepage` `\changetext{}{100mm}{}{}{}` (the `\if@longauthor` else branch, so it runs for `preprint`) |
| absolute text blocks | sedimentologika.cls:103, 460-468, 959-969 | `pg.textpos` | `textpos` options absolute, quiet; `textblock*{40mm}[1,0](195mm, \dimexpr\pageheight-3mm-\zposy{loc:beg_abstract}sp\relax)` bold flushright; second block `{0.8\textwidth}[0,1](15mm,276mm)` `\footnotesize` SedK1 "This pre-print is provided by the authors" |
| position read-back | sedimentologika.cls:105, 324, 345, 911, 924 | `xref.zref` | `zref` options thepage, savepos; `\zsavepos{loc:beg_abstract}`, `{loc:endauthorblock}`, `{loc:beg_title}`; values read with `\zposy` (two passes) |
| page break | sedimentologika.cls:1023 | `pg.break` | `\clearpage` |
| bottom flush | sedimentologika.cls:588 | `pg.flush` | `\raggedbottom` |
| landscape pages (load only) | sedimentologika.cls:99 | `pg.landscape` | `pdflscape`, no call in the sample |
| flow control (load only) | sedimentologika.cls:117 | `pg.afterpage` | `afterpage`, no call in the sample |
| running heads and feet | sedimentologika.cls:90, 708-744 | `hf.titleps` | `\newpagestyle{ps_preprint}[\scriptsize]{..}` with `\sethead`/`\setfoot` (head: `\authors` and `\itshape\@shorttitle`; foot: "PRE-PRINT GENERATED: \today", `\itshape{\@preprintdeclaration}`, `\thepage`); first-page style `ps_preprint_first`; `\headrule`, `\footrule`; `\makeheadrule` `\rule[-0.35\baselineskip]{\linewidth}{0.25pt}`, `\makefootrule` `\rule[0.5\baselineskip]{\linewidth}{0.25pt}` |
| page style choice | sedimentologika.cls:1006, 1046-1048 | `hf.pagestyle-kernel` | `\pagestyle{ps_preprint}`, `\thispagestyle{ps_preprint_first}` |
| head and foot rules | sedimentologika.cls:723-724 | `sp.rule` | `\rule[..]{\linewidth}{0.25pt}` |
| date format | sedimentologika.cls:94, 717 | `front.datetime` | `datetime2` `style=iso`; `\today` in the foot |
| line spread | sedimentologika.cls:589, 1055 | `sp.linespread` | 1.2 (2.0 for `submission`) |
| widow and club control | sedimentologika.cls:574-580 | `sp.penalties` | `\clubpenalty`, `\widowpenalty`, `\brokenpenalty` 10000; `\hyphenpenalty` 8000 |
| space after period | sedimentologika.cls:587 | `sp.frenchspacing` | `\frenchspacing` |
| microtype | sedimentologika.cls:93 | `sp.microtype` | babel=true, nopatch=footnote |
| paragraph skip | sedimentologika.cls:116 | `sp.parskip-pkg` | parfill, skip={\baselinestretch} (as written) |
| ragged text | sedimentologika.cls:82, 885, 905, 312-313 | `sp.ragged` | `ragged2e`; `RaggedRight` environment around title and authors; `\RaggedLeft` and `\RaggedRight` in column types |
| line spacing package (load only) | sedimentologika.cls:101 | `sp.setspace` | `setspace`, no call |
| manual spacing | sedimentologika.cls:901, 916, 1021, 1031, 254 | `sp.manual-space` | `\vspace{1\baselineskip}`, `\vspace*{-1mm}`, `\vspace{\fill}`, `\vglue 2\baselineskip`, `\vskip 0.4em` |
| paragraph lengths | sedimentologika.cls:463-464 | `sp.lengths` | `\parskip` `\baselineskip`, `\parindent` `\z@` inside the declaration block |
| main and sans text face | sedimentologika.cls:592, 595-613 | `font.fontspec` | `\babelfont{rm}` and `{sf}` on the shipped `notosans-variablefont_wdth,wght.ttf`; BoldFont, ItalicFont, BoldItalicFont as the two shipped Noto Sans files; Numbers={Proportional,Lining}; UprightFeatures and ItalicFeatures Weight=350; BoldFeatures Weight=600 |
| mono face | sedimentologika.cls:616-622 | `font.fontspec` | `\babelfont{tt}` on `notosansmono-variablefont_wdth,wght.ttf`, same feature keys |
| fallback faces | sedimentologika.cls:614, 623, 629 | `font.helvet`, `font.mono`, `font.unicode-math` | `\RequirePackage[sfdefault]{noto}`, `noto-mono`, `firamath-otf`, taken only when the family test `\IfFontExistsTF` fails; the emitter takes the shipped-file branch |
| maths face | sedimentologika.cls:593, 625-628 | `font.unicode-math` | `math-style=ISO`, `bold-style=ISO`; `\setmathfont{notosansmath-regular}`, `\setmathrm{notosansmath-regular}` (file `notosansmath-regular.otf` shipped) |
| sizes | sedimentologika.cls:639-642, 886 | `font.size-commands` | title `\fontsize{18pt}{18pt}\selectfont`; headings 9pt/15pt, 11pt/17pt, 10pt/15pt; `\scriptsize`, `\footnotesize`, `\small`, `\normalsize` |
| font switches | sedimentologika.cls:245-246, 712 | `mark.kernel` | `\bfseries`, `\mdseries`, `\itshape`, `\textbf`, `\textit` |
| icon glyphs (load only here) | sedimentologika.cls:73-74, 96, 500 | `font.icons` | `ccicons[scale=2]` (`\ccby`, :935), `simpleicons` (`\simpleicon{openaccess}`, :500), `orcidlink`; none printed by `preprint` |
| text Greek (load only) | sedimentologika.cls:86 | `font.fontenc-t1` | `textgreek`, a text-symbol glyph package, no call in the sample |
| colours | sedimentologika.cls:70, 132-136 | `color.xcolor` | `\definecolor` HTML: SedK1 06595a, SedK2 086162, SedK3 0a696a, SedK4 0c7172, SedkGrey 5E5E5E |
| watermark | sedimentologika.cls:91, 1052, 1061 | `bg.watermark` | `draftwatermark` stamp=false, color={[gray]{0.9}}, fontsize=72pt; `\setkeys{draftwatermark}{text={FOR REVIEW ONLY}, stamp=true}` (submission), text PROOF (proof) |
| language | sedimentologika.cls:92, 332-340 | `lang.babel` | options english, bidi=basic, provide*=*; `otherlanguage` in the `translation` environment |
| links and PDF strings | sedimentologika.cls:97-98, 100, 138-162, 655-665, 679-688 | `meta.hyperref` | `hyperref`, `doi`; `\hypersetup` colorlinks=true, preprint: linkcolor, citecolor, urlcolor blue, rest black; other options SedK3/SedK2; `\pdfstringdefDisableCommands{..}` |
| URLs | sedimentologika.cls:97 | `meta.url` | `url` |
| PDF metadata (not `preprint`) | sedimentologika.cls:106, 1062-1079, 1085-1102 | `meta.hyperxmp` | `\AtEndPreamble{\hypersetup{pdfauthor, pdfkeywords, pdfcopyright, pdflicenseurl, pdfpublication, pdfeissn, pdfdoi, ...}}` for proof and publication |
| PDF info suppression (`anonymous` only) | sedimentologika.cls:1106-1108 | `meta.pdf-params` | `\pdfvariable suppressoptionalinfo \numexpr2+16+32+64+128 \relax` |
| title | sedimentologika.cls:883-902, 919-921; main.tex:6 | `front.titling` | preprint `\pretitle{\begin{RaggedRight}\fontsize{18pt}{18pt}\selectfont\bfseries}`, `\posttitle{\par\end{RaggedRight}\vspace{1\baselineskip}}`, `\predate{}`, `\postdate{}`, `\date{}`; other options add `\vspace*{-1\baselineskip}` and `\textcolor{SedK1}` (cls:890-895) |
| title hooks | sedimentologika.cls:959-969 | `front.titling` | `\maketitlehooka` = `\zsavepos{loc:beg_title}`; `\maketitlehookd` = preprint declaration block and footer text block (publication and proof variants :923-957) |
| authors, affiliations | sedimentologika.cls:88, 242-247, 904-917; main.tex:8-11 | `front.authblk` | `authblk[noblocks]`; `\Authsep` ", ", `\Authand` " \& ", `\Authands` ", and ", `\Authfont` `\bfseries`, `\Affilfont` `\mdseries\footnotesize`, `\affilsep` 2mm; `\preauthor{\begin{RaggedRight}}`, `\postauthor{CRediT block, corresponding author, \zsavepos, \end{RaggedRight}, \vspace*{-1mm}}`; sample `\author[1]{..}`, `\affil[1]{..}` |
| running-head strings | sedimentologika.cls:169, 295-298; main.tex:7, 10 | `hf.titleps` | `\shorttitle` and `\authorshdr` are strings placed in the page style fields (row above) |
| corresponding author | sedimentologika.cls:252-260; main.tex:12 | `meta.hyperref` | `\scriptsize*Corresponding authors: name, \href{mailto:addr}{addr}`, several joined with "; " |
| CRediT statement | sedimentologika.cls:302-307, 667-676; main.tex:13-20 | `struct.datatool` | database `CRediTs` built in the document (`\DTLgnewdb`, `\DTLnewrow`, `\DTLnewdbentry` keys credrole, credauthor), printed with `\DTLforeach*`; guard `\ifdim\DTLrowcount{CRediTs}pt=0pt`; `\footnotesize\RaggedRight`, `\textbf{CRediT statement: }`, `\textit{role}: initials.`, black for `preprint` |
| abstract | sedimentologika.cls:321-330, 1019; main.tex:25-33 | `abs.kernel` | `\renewenvironment{abstract}` = numberless `\section*{Abstract}` + `\zsavepos`; end `\par\normalsize`; called as `\abstract{#2}` |
| plain language summary | sedimentologika.cls:342-351, 1030; main.tex:25-28 | `abs.kernel` | same pattern, `\section*{Plain language summary}`; called as `\plainlanguagesummary{#1}` |
| keywords | sedimentologika.cls:217-226, 512, 562; main.tex:21 | `abs.keywords` | `\keywords{a\\b\\c}` stored; printed only by the metadata blocks (proof, publication), SedkGrey flushright; not printed for `preprint` |
| declarations | sedimentologika.cls:353-420; main.tex:80-85 | `front.dedication` | acknowledgements, conflictofinterest, artificialintelligence, datacode (`\small` then `\section*{..}`), funding, supplementarymaterial (`\section*{..}` then `\small`), specialsection; the sample calls them as commands with one brace group |
| citing box | sedimentologika.cls:422-449 | `front.dedication` | `\section*{Citing this \@articletype}`, `\RaggedRight\small`, `\textbf{\textcolor{SedK1}{..}}` labels, `\linebreak`, `\href` licence link; not used by the sample |
| metadata blocks (not `preprint`) | sedimentologika.cls:470-568 | `box.tcolorbox` | `tcolorbox[most]` keys center, width=0.9\linewidth, colframe=SedK1, boxrule=0.25pt, arc=1.2mm, left, right 3mm, top, bottom 2mm, colback=white (`\if@longauthor`); with `cols.multicol` `multicols{3}` and `\columnbreak` (:527-565), placed by `pg.textpos` (:473, 480) |
| headings | sedimentologika.cls:89, 639-647; main.tex:35-75 | `head.titlesec` | `\titleformat{name=\section, numberless}` `\RaggedRight\fontsize{9pt}{15pt}\bfseries`; section 11pt/17pt bold, label sep 0.5em; subsection and subsubsection 10pt/15pt bold; `\titlespacing` numberless `{0em}{*2}{0.5em}`, others `{0em}{*2}{*1}` |
| numbering depth | sedimentologika.cls:649 | `num.secnumdepth` | secnumdepth 3 |
| bullet label | sedimentologika.cls:1056 | `list.kernel` | `\def\labelitemi{\raisebox{0.35ex}{\tiny$\textbullet$}}` (submission only) |
| line numbers | sedimentologika.cls:980, 1053-1054 | `sp.draft-lineno` | `lineno`, `\linenumberfont` `\scriptsize` (submission only) |
| float placement | sedimentologika.cls:582-585, 634-636 | `fig.placement` | `\topfraction` and `\bottomfraction` 0.85, topnumber and bottomnumber 1, `\textfloatsep`, `\dbltextfloatsep`, `\intextsep` 6mm plus 1mm minus 1mm |
| graphics | sedimentologika.cls:83, 813, 859 | `fig.graphicx` | `graphics`; `\includegraphics[height=12mm]{logos/SedimentologikaLogo.pdf}` in the proof and publication first-page styles (file not shipped) |
| rotation | sedimentologika.cls:316 | `fig.rotating` | `\rotatebox[origin=c]{#1}` as `\rot` |
| table | main.tex:47-60; sedimentologika.cls:310-314 | `tbl.tabular` | `table[ht]`, `\centering`, `tabular{lccc}`; `\newcolumntype` C, R, L, M over `p{..}` and `m{..}` with `\PreserveBackslash` |
| table rules | sedimentologika.cls:78; main.tex:52, 54, 58 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| long tables (load only) | sedimentologika.cls:80 | `tbl.longtable` | `longtable`, no call |
| matrices (load only) | sedimentologika.cls:79 | `tbl.nicematrix` | `nicematrix`, no call |
| multirow (load only) | sedimentologika.cls:81 | `tbl.multirow` | `multirow` |
| captions | sedimentologika.cls:85, 632; main.tex:49 | `cap.caption` | font=small, labelfont=bf, justification=justified, labelsep=endash, skip=5pt, singlelinecheck=off |
| caption command | main.tex:49 | `cap.kernel` | `\caption{..}` |
| label | main.tex:50 | `xref.kernel` | `\label{tab:stations}` |
| units | sedimentologika.cls:62-69, 129-130 | `mark.siunitx` | mode=match, unit-mode=match, range-units=single, group-minimum-digits=3, separate-uncertainty=true, multi-part-units=single, list-units=single; `\DeclareSIUnit{\year}{yr}`, `{\annum}{a}` |
| maths packages | sedimentologika.cls:75-77 | `math.amsmath`, `math.amssymb`, `math.physics` | `amsmath`, `amssymb`, `commath` (notation macros, a physics-type package); no equation in the sample |
| chemistry (load only) | sedimentologika.cls:84 | `art.content-package` | `mhchem[version=4]`; `\ce` is content, none in the sample |
| bibliography | sedimentologika.cls:95, 121-127; main.tex:22, 86; references.bib | `bib.csl` | `\cslsetup{style=apa, bib-font=\linespread{1}\footnotesize, bib-item-sep=8pt plus 4pt minus 2pt}` (no bib-font under `submission`); `\addbibresource{references.bib}`, `\printbibliography` |
| review notes (proof only) | sedimentologika.cls:118, 913 | `draft.todo` | `fixme` `\fxnote[layout={inline}]` in orange |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option switches `\newif\if@preprint` etc. | sedimentologika.cls:20-46, 883-1108 | yes | the options are known at emit time; emit only the `preprint` branch (title hooks :959-969, `\pagestyle{ps_preprint}` :1047, hyperref colours :656-665); other branches map as in the table |
| `\SedKtitle` | sedimentologika.cls:972-986, 987-1044 | yes | inline expansion: `\twocolumn[{\maketitle\thispagestyle{ps_preprint_first}} \changetext{}{100mm}{}{}{} \abstract{..} \vspace{\fill}]\clearpage\restoregeometry\twocolumn[\plainlanguagesummary{..}\vglue 2\baselineskip]`; the `\ifx#3\@empty` test (:1025) gives the same output for an empty third argument |
| expl3 author list | sedimentologika.cls:264-280 | yes | `\g_authors_seq` is written by the new `\author` (:266-270) and read only by `\ABgetauthor` (:271-274), which nothing calls (its only other uses are commented out, :276-293); delete it, `\author[n]{..}` is the `authblk` command |
| `\printifnotempty` | sedimentologika.cls:490-497 | yes | prints label and value only when the value is non-empty; the field is known at emit time, so emit the label only when present; used only by the metadata blocks (not `preprint`) |
| metadata blocks | sedimentologika.cls:470-568 | yes | `pg.textpos` + `box.tcolorbox` + `cols.multicol` with the parameters in the table |
| `\suppmat`, `\correspondingauthor` accumulators | sedimentologika.cls:194-211, 252-260 | yes | `\g@addto@macro` joins strings with ", " or "; "; the emitter writes the joined string (and `\href{https://doi.org/X}{..}` links) directly |
| `\keywords` with `\StrSubstitute` | sedimentologika.cls:217-226 | yes | `xstring` only turns `\\` into ", " for `pdfkeywords`; precompute the string at emit time (as the lib rejected `sp.xspace`: a macro-body helper with nothing to wrap) |
| `\CRediT`, `\printCRediTifnotempty` | sedimentologika.cls:302-307, 667-676, 690-699 | yes | `struct.datatool` calls kept as written, or the list written as text at emit time; the empty-database guard is known at emit time |
| `\newcolumntype` C, R, L, M | sedimentologika.cls:310-314 | yes | `array` `\newcolumntype` with the standard `\PreserveBackslash` idiom over `ragged2e` commands |
| `\IfFontExistsTF` font fallback | sedimentologika.cls:595-630 | yes | choose the shipped-file branch (`font.fontspec`); fallbacks are `font.helvet`, `font.mono`, `font.unicode-math` |
| `\pdfstringdefDisableCommands` block | sedimentologika.cls:138-162 | yes | one hyperref command (`meta.hyperref`) with `\let` to `\@gobble` inside PDF strings; no typeset effect |
| environments `abstract`, `plainlanguagesummary`, declarations, `translation`, `citing`, `specialsection` | sedimentologika.cls:321-449 | yes | numberless `\section*{..}` plus `\small`, `\par\normalsize` (`head.titlesec`, `font.size-commands`); the sample calls them as commands, so only the begin code is emitted (main.tex:80-85, cls:1019) |
| `\pretitle` argument grab `\textcolor{SedK1}` | sedimentologika.cls:890-895 | yes | equals `\color{SedK1}` in the pre-title; not used for `preprint` |
| `\title` redefinition | sedimentologika.cls:170 | yes | same as the kernel `\gdef\@title{#1}`; no effect |
| `\englishvariety` | sedimentologika.cls:167; main.tex:3 | yes | `\gdef\@englishvariety` is never read (only occurrence); no output |
| `\email`, `\Sedimentologika`, `\promohref`, `\rot` | sedimentologika.cls:239, 456-458, 316 | yes | `\newcommand` aliases over `\texttt`, `\textcolor`, `\href`, `\rotatebox` |

## Content-opaque
none (the sample has no figure or picture; the station table at main.tex:47-60 is plain `tabular` content, and `mhchem` is load-only)

## Lib changes
- New ways proposed:
  - `bib.csl` `citation-style-language` (CTAN, v0.9.2 of 2026-03-24, licences CC BY-SA 3.0, MIT, CC0 per the CTAN page; engine xe/lua: the zip's README says compile with LuaLaTeX, the CTAN page names no engine and I did not read the package manual); `\usepackage{citation-style-language}`, `\cslsetup{style=apa, bib-font=.., bib-item-sep=..}`, `\addbibresource{file.bib}`, `\printbibliography`, citation commands. W1: on CTAN. W2: key-value `\cslsetup` options and a CSL style name as the parameter (as the `.bst` style is for `bib.bibtex-bst`). W3: any CSL style and any `.bib` file. W4: preamble lines plus `\printbibliography`. Not `bib.biblatex-biber` (another package, no biber), not `bib.natbib`. Open point: whether `apa.csl` ships with the package or must be supplied is not stated on the CTAN page (the zip does not contain it; treat as a missing asset, ship it); use under pdfLaTeX or XeLaTeX is not established (EXTERNAL then, if a separate processor is needed).
  - `meta.pdf-params` pdfTeX/LuaTeX PDF-backend integer parameters set in the preamble, here `\pdfvariable suppressoptionalinfo \numexpr2+16+32+64+128 \relax` (sedimentologika.cls:1107, `anonymous` option only); engine xe/lua (`\pdfvariable` is the LuaTeX form; pdfTeX's names for the same switches were not checked). W1: engine primitive documented in the LuaTeX manual, the kind the lib already admits (`meta.glyphtounicode`, `sp.penalties`). W2: one integer bit mask. W3: serves any document that needs to omit PDF info entries. W4: one preamble line. Not `meta.glyphtounicode` (a ToUnicode map), not `meta.hyperxmp` (XMP metadata), not `meta.pdfx` (PDF/A).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
