yes

# 0336-elteiktdk: elteiktdk (ELTE FI TDK thesis class, Hungarian and English)

- Unverified: read from the source, not compiled.
- Source: Source/0336-elteiktdk/ (origin: https://mirrors.ctan.org/macros/latex/contrib/elteiktdk.zip; licence: MIT, elteiktdk.cls:1-22, LICENSE)
- Kind: thesis
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:21-28 builds with `pdflatex` and `biber`; no fontspec, no Lua)
- Look carried by: class (`elteiktdk.cls` is a thin 209-line layer: metadata commands, language labels, `mathptmx`, cover and title page; it loads the published `elteikthesis` class, which carries the typography and is not in the zip)
- Class origin: ctan
- Main file: elteiktdk_hu.tex (other samples: elteiktdk_en.tex, same file with English strings; chapter files samples_hu/*.tex and samples_en/*.tex)
- Read: main yes, zip-local classes and styles all (elteiktdk.cls whole; the base class `elteikthesis` is a published class not bundled in the zip and was not read; the README PDFs and sample PDFs were not read)

## Verdict
The zip is the CTAN package `elteiktdk` (ctan.org/pkg/elteiktdk: class, MIT, in TeX Live and MiKTeX), so it is one way, `class.elteiktdk`, which loads the published `class.elteikthesis` (elteiktdk.cls:28; ctan.org/pkg/elteikthesis v2.4, MIT, in TeX Live, source not read). The sample's preamble adds only metadata set through class commands and every body construct is a published-package construct (lists, figures, tables, amsthm-style environments, algorithm, listings, biblatex). Nothing is defined in the sample itself. The one uncertainty is that the typography inside `elteikthesis` (page, running heads, heading looks, caption look, biblatex options) was not read, so those rows name the class-native way without parameter values.

## Blockers
none

Recorded, not counted: `minted` is offered but commented out (elteiktdk_hu.tex:10-11, README.md:35-36), so no shell escape is needed as shipped. The nomenclature pass (`makeindex`) is optional (README.md:24-26) and `\printnomenclature` is commented out (elteiktdk_hu.tex:115). The README says biber is run (README.md:23), which the lib already carries as `bib.biblatex-biber`.

## Class setting
- Class: `class.elteiktdk` options: none active. The sample lists `parspace`, `noindent`, `nohyp`, `twoside`, `draft`, `final`, all commented out (elteiktdk_hu.tex:2-7); version argument `[2024/04/26]` (elteiktdk_hu.tex:8). Base class `class.elteikthesis` is loaded with the same options (elteiktdk.cls:28; `\LoadClassWithOptions{elteikthesis}[2024/04/26]`).
- Class-native vocabulary used: preamble `\title` `\date` `\author` `\degree` `\period` `\coauthor` `\codegree` `\coperiod` `\supervisor` `\affiliation` `\cosupervisor` `\coaffiliation` `\university` `\faculty` `\department` `\city` `\logo` `\addbibresource` (elteiktdk_hu.tex:14-39; `\period`, `\coauthor`, `\codegree`, `\coperiod`, `\cosupervisor`, `\coaffiliation` are defined at elteiktdk.cls:33-40, the rest come from `elteikthesis`); body `\documentlang{hungarian|english}` (elteiktdk_hu.tex:45; elteiktdk_en.tex:46), `\makecover` `\maketitle` (elteiktdk_hu.tex:53-55), label macros `\acklabel` `\biblabel` `\lstfigurelabel` `\lsttablelabel` `\lstalgorithmlabel` `\lstcodelabel` (elteiktdk_hu.tex:75-110; defined elteiktdk.cls:68-75), `\listofalgorithms` `\lstlistoflistings` (elteiktdk_hu.tex:105,111), environments `definition` `theorem` `remark` `note` (README.md:74-79; samples_hu/impl.tex:9-32), `compactenum` `compactitem` `compactdesc` (samples_hu/spec.tex:36-58).

## Component map
Rows marked "inside elteikthesis" are set by the unread base class: the way is named from the commands the sample calls and from README.md:43-72, and no parameter values are claimed.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | elteiktdk_hu.tex:1-8 | `class.elteiktdk` | all options commented out (:2-7), `[2024/04/26]` |
| base class | elteiktdk.cls:28 | `class.elteikthesis` | `\LoadClassWithOptions{elteikthesis}[2024/04/26]`; source not read |
| paper, margins, sidedness | README.md:13; elteiktdk_hu.tex:5 | `page.class-options` | single side by default, `twoside` option available; margin and paper values inside elteikthesis, not read |
| running head and foot, page numbers | not in sample (inside elteikthesis) | `hf.class-native` | not read |
| cover page empty page style | elteiktdk.cls:114 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| body font | elteiktdk.cls:107 | `font.mathptmx` | `\RequirePackage{mathptmx}`, no options |
| language switch | elteiktdk.cls:48; elteiktdk_hu.tex:45 | `lang.babel` | `\selectlanguage{hungarian}` or `{english}`; babel itself loaded by the base class, not read |
| title, author, date | elteiktdk_hu.tex:14-18 | `front.maketitle` | `\title{...}` `\date{2024}` `\author{...}` |
| cover page | elteiktdk.cls:112-139; elteiktdk_hu.tex:53 | `front.class-native` | `\makecover`: centred title `\Large\bf\covertitle`, author name(s) in two 0.45\textwidth minipages when `\coauthor` is set |
| title page | elteiktdk.cls:144-208; elteiktdk_hu.tex:55 | `front.class-native` | redefined `\maketitle` from the metadata commands |
| title page environment | elteiktdk.cls:145 | `front.titlepage-env` | `titlepage` with `center`, `\vfill`, logo at 0.3\textwidth (:154), city and year line (:203) |
| title page spacing, fills | elteiktdk.cls:116,120,137,149-153,179 | `sp.manual-space` | `\vspace*{\fill}`, `\vfill`, `\\[0.7cm]`, `\\[1.0cm]`, `\vspace{1.5cm}` |
| title page boxes | elteiktdk.cls:123,128,158,165,183,189 | `box.minipage` | pairs of `minipage` of 0.45\textwidth for the two authors and the two supervisors |
| title page alignment | elteiktdk.cls:124,129,159,166,184,190 | `sp.ragged` | `flushleft` and `flushright` inside the minipages, `center` around |
| title page fonts | elteiktdk.cls:148,151-153,157 | `font.size-commands`, `mark.kernel` | `\huge` `\LARGE` `\Large` `\large`; `\bf` `\sc` `\it` |
| title page logo | elteiktdk.cls:154; elteiktdk_hu.tex:36 | `fig.graphicx` | `\includegraphics[width=0.3\textwidth]{\logofilename}`, logo `elte_cimer_szines` (images/ ships an EPS and its converted PDF) |
| acknowledgements | elteiktdk_hu.tex:75-77 | `front.dedication`, `head.kernel`, `toc.kernel` | `\chapter*{\acklabel}` plus `\addcontentsline{toc}{chapter}{\acklabel}` |
| table of contents | elteiktdk_hu.tex:58 | `toc.kernel` | `\tableofcontents`; look inside elteikthesis |
| lists of figures, tables | elteiktdk_hu.tex:91-100 | `toc.kernel` | `\phantomsection`, `\addcontentsline{toc}{chapter}{...}`, `\listoffigures`, `\listoftables` |
| list of algorithms, of codes | elteiktdk_hu.tex:103-112 | `alg.algorithmicx`, `code.listings` | `\listofalgorithms` (algorithm float), `\lstlistoflistings` |
| link anchors, hyperlink | elteiktdk_hu.tex:85; samples_hu/impl.tex:105 | `meta.hyperref`, `xref.hyperref` | `\phantomsection` before the bibliography and each list-of entry (:85, :91, :97, :103, :109) and in `\makecover` (elteiktdk.cls:113); `\href{url}{text}`; options inside elteikthesis |
| chapter, section headings | samples_hu/spec.tex:1,7,33; elteiktdk_hu.tex:75 | `head.class-native` | `\chapter` `\section` `\subsection`, starred `\chapter*`; look inside elteikthesis |
| page breaks between chapters | elteiktdk_hu.tex:54,59,63,66 | `pg.break` | `\cleardoublepage` |
| appendix | elteiktdk_hu.tex:80-82 | `num.appendix` | `\appendix` then `\input{samples_hu/sim.tex}` |
| cross-references | samples_hu/spec.tex:20-22,69; impl.tex:45 | `xref.kernel` | `\label` `\ref` |
| lists | samples_hu/spec.tex:11-31 | `list.kernel` | `itemize`, `enumerate`, `description` |
| compact lists | samples_hu/spec.tex:36-58; README.md:60 | `list.paralist` | `compactenum`, `compactitem`, `compactdesc` |
| footnote | samples_hu/spec.tex:25 | `fn.kernel` | `\footnote{...}` |
| manual spacing in body | samples_hu/spec.tex:42,51,90 | `sp.manual-space` | `\bigskip`, `\hspace{5pt}` |
| figure float | samples_hu/spec.tex:65-70,76-80 | `fig.graphicx`, `fig.float` | `figure[H]`, `\centering`, `\includegraphics[width=0.6\textwidth,height=100px]` and key `frame` (:78) |
| subfigures | samples_hu/spec.tex:86-95 | `fig.subcaption` | `\subcaptionbox{...}{\includegraphics[width=0.45\linewidth]}` twice, one outer `\caption` |
| captions | samples_hu/spec.tex:68,117,140,201 | `cap.kernel` | `\caption{...}`, short form `\caption[short]{long}` (:140); caption look inside elteikthesis |
| tables | samples_hu/spec.tex:104-119,125-142 | `tbl.tabular` | `table[H]`/`[htb]`, `tabular` with `m{0.25\textwidth}` and `c r` columns, `\hline` `\cline{2-7}` |
| merged cells | samples_hu/spec.tex:129 | `tbl.multirow` | `\multirow{2}{*}{...}`, `\multicolumn{2}{c|}{...}` |
| long table | samples_hu/spec.tex:148-204 | `tbl.longtable` | `longtable` with `\endfirsthead` `\endhead` `\endfoot` `\endlastfoot` |
| table text marks | samples_hu/spec.tex:108,110 | `mark.kernel` | `\textbf`, `\emph` |
| display maths | samples_hu/impl.tex:40,45-62 | `math.amsmath`, `math.kernel` | `equation`, `align` with `\nonumber` (:59-60); `$$...$$` (:40) |
| maths symbols | samples_hu/spec.tex:4; README.md:66 | `math.amssymb` | `\mathbb{N}`, `\mathbb{Z}` |
| theorem-like statements | samples_hu/impl.tex:9-32; README.md:74-79; elteiktdk.cls:60-63 | `thm.class-native` | `definition` `theorem` `remark` `note`; names from `\deflabel` `\theolabel` `\remlabel` `\notelabel`; style inside elteikthesis |
| proof | samples_hu/impl.tex:18-20; README.md:65 | `thm.amsthm` | `proof` environment |
| algorithm | samples_hu/impl.tex:107-129; README.md:67 | `alg.algorithmicx` | `algorithm[H]` with `\caption`, `\label`; `algorithmic[1]` with `\State` `\While` `\If` `\For` `\Comment` |
| source code | samples_hu/impl.tex:68-100; README.md:68 | `code.listings` | `\lstset{caption=,label=}`, `lstlisting[language={C++}]`, `[language={[Sharp]C}]`; `listingsutf8` |
| bibliography | elteiktdk_hu.tex:39,85-88; samples_hu/intro.tex:4 | `bib.biblatex-biber` | `\addbibresource{elteiktdk.bib}`, `\printbibliography[title=\biblabel]`, `\cite`; biblatex options inside elteikthesis |
| nomenclature | samples_hu/spec.tex:4; elteiktdk_hu.tex:115 | `idx.glossaries` | `\nomenclature{sym}{text}` entries; `\printnomenclature` commented out |
| todo notes | elteiktdk_hu.tex:7,49; README.md:72; elteiktdk.cls:74 | `note.todonotes` | `\listoftodos[\todolabel]` commented out; `final` hides todos; not used in the sample body |
| other packages named by the README | README.md:47,49,56 | `fig.adjustbox`, `fig.rotating` | `adjustbox`, `rotating` (README claim only; not called by the sample; makecell falls under `tbl.multirow`) |

## Bespoke code
All items sit in `elteiktdk.cls`, which is a published class (CTAN, TeX Live), so by the rubric they are the class's own vocabulary behind `class.elteiktdk`, not zip-local bespoke code. The reductions are written down in case the class were treated as zip-local.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| metadata macros `\period` `\coauthor` `\codegree` `\coperiod` `\cosupervisor` `\coaffiliation` and the `\extsupervisor` `\extaffiliation` renames | elteiktdk.cls:33-42 | yes | `\newcommand` strings, aliases; the emitter writes the strings in the title page |
| `\documentlang` label tables | elteiktdk.cls:47-102 | yes | `lang.babel` `\selectlanguage` plus fixed label strings (`\covertitle`, `\acklabel`, ...); the `\ifthenelse{\equal{\detokenize{..}}}` (:51) only picks one of two string sets, which an emitter fixes per document |
| `\makecover` | elteiktdk.cls:112-139 | yes | `front.titlepage-env`-style centred block: `sp.manual-space` fills, two `box.minipage` of 0.45\textwidth with `sp.ragged` `flushleft`/`flushright`; the `\ifdefined\coauthorname` branch (:122) is decided by whether the data has a co-author |
| `\maketitle` | elteiktdk.cls:144-208 | yes | `front.titlepage-env` + `font.size-commands` + `mark.kernel` + `fig.graphicx` logo + `box.minipage`; the two `\ifdefined` branches (:156, :181) are decided by co-author and co-supervisor data |

## Content-opaque
none (the logo image, the `algorithmic` body at samples_hu/impl.tex:111-128 and the `lstlisting` bodies at impl.tex:69-82, 85-100 are content that a lib way holds)

## Lib changes
- New ways proposed: none. Considered and not needed: `epstopdf` for the EPS logo (an image asset, shipped with its converted PDF in images/; not a template look).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Class ways: `class.elteiktdk` (vocabulary under "Class setting") and `class.elteikthesis` (base class, source not read) are written plainly, as the rubric allows.
