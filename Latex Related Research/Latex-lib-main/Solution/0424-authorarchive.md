yes

# 0424-authorarchive: authorarchive (self-archiving notice, QR code and embedded bibliography files for a paper's first page)

- Unverified: read from the source, not compiled.
- Source: Source/0424-authorarchive/ (origin: https://mirrors.ctan.org/macros/latex/contrib/authorarchive.zip; licence: LPPL 1.3c or BSD-2-Clause, authorarchive.sty:3-11, LICENSE:1-23)
- Kind: conference (the main sample is an ACM `sigconf` proceedings paper; the manifest hint `journal` is not what the sample shows)
- Lib: v4
- Engine: pdfLaTeX-compatible (by reading: no fontspec, Lua or shell escape in the sample or the style; the page-attribute proxy has a pdfTeX branch `\pdfpagesattr`, authorarchive.sty:119, and a kernel pdfmanagement branch, :121; the CTAN pages for authorarchive, qrcode and intopdf state no engine)
- Look carried by: mixed (the page, title, headings and abstract come from the published class `acmart` with option `sigconf`; the one thing the zip adds is a first-page notice from the published package `authorarchive`, driven by one `\authorsetup{...}` call and a local `authorarchive.config`)
- Class origin: tex-distribution-unbundled (acmart is not in the zip; `authorarchive.sty` is a CTAN style file, not a class)
- Main file: examples/brucker-authorarchive-2016-acmart.tex (other samples: examples/brucker-authorarchive-2016.tex, examples/brucker-authorarchive-2016-IEEEtran.tex, examples/brucker-authorarchive-2016-IEEEtran-nourl.tex, examples/brucker-authorarchive-2016-entcs.tex, examples/brucker-authorarchive-2016-llncs.tex, examples/brucker-authorarchive-2016-llncs-a4.tex, examples/brucker-authorarchive-2016-lni.tex)
- Read: main yes, zip-local classes and styles all (authorarchive.sty, 347 lines, in full; examples/authorarchive.config in full; no `.cls` in the zip; acmart source not present and not read; the PDFs and `examples/bib/*` data files were not read, only their names and line counts)

## Verdict
yes. The class is the published `acmart` (not bundled), and the preamble sets class-native copyright and conference fields, one `\authorsetup{...}` call of strings and booleans, `lipsum` filler, a title, an author with `\href`, and an abstract. The only style file, `authorarchive.sty`, is on CTAN, TeX Live and MiKTeX (ctan.org/pkg/authorarchive read), so it passes W1 to W4 as one new way, `front.authorarchive`. The sample defines no macro, counter or artwork of its own. The verdict rests on accepting `authorarchive.sty` as a published way: if a reviewer counts its overlay logic (authorarchive.sty:239-347) as zip-local code, it would be `BESPOKE/class` and the answer would be `no`.

## Blockers
none

## Class setting
- Class: `class.acmart` options: `sigconf` (examples/brucker-authorarchive-2016-acmart.tex:1)
- Class-native vocabulary used: `\copyrightyear`, `\acmYear` (:2-3), `\setcopyright{acmlicensed}` (:4), `\acmConference[short]{name}{dates}{place}` (:5), `\acmBooktitle` (:6), `\acmPrice` (:7), `\acmDOI` (:8), `\acmISBN` (:9), `\title`, `\author` (:25-26), `abstract` environment placed before `\begin{document}` (:27-29), `\maketitle` (:32), `\section` (:34, 37, 40). Not used: `\affiliation`, `\email`, `\keywords`, `\ccsdesc`, `\bibliography`, `acks`.
- Other samples (outside the verdict; each loads the same `authorarchive` way with another class and a class-name boolean): `class.article` with `a4paper` (examples/brucker-authorarchive-2016.tex:1), `class.ieeetran` with `conference` and `\IEEEauthorblockN/A` (…-IEEEtran.tex:1, 20-21), `entcs` with `frontmatter` and `\lastname` (…-entcs.tex:1, 18, 21-29), `class.llncs` with `final, runningheads, USenglish`, `\institute`, `\orcidID` (…-llncs.tex:1, 25-26), `lni` with `\author{name}{email}{orcid}` and a `keywords` environment (…-lni.tex:3, 19, 27-29). `entcs` and `lni` are not yet in the lib's class list; their cls files are not in the zip and were not read.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | examples/brucker-authorarchive-2016-acmart.tex:1 | `class.acmart` | `sigconf` |
| page size, columns, fonts | examples/brucker-authorarchive-2016-acmart.tex:1 | `page.class-options` | set by the `sigconf` format inside acmart (source not read); the sample sets no geometry, font package or `\setlength` |
| running heads and footers | examples/brucker-authorarchive-2016-acmart.tex:5-9 | `hf.class-native` | acmart's own heads and foot block; the sample only feeds them through the `\acm...` fields |
| copyright and conference block | examples/brucker-authorarchive-2016-acmart.tex:2-9 | `front.class-native` | `\copyrightyear{2017}`, `\acmYear{2017}`, `\setcopyright{acmlicensed}`, `\acmConference[LHack '16]{...}{December 4--6, 2017}{Salzburg, Austria}`, `\acmBooktitle`, `\acmPrice{15.00}`, `\acmDOI`, `\acmISBN` |
| title and author | examples/brucker-authorarchive-2016-acmart.tex:25-26, 32 | `front.maketitle`, `front.class-native` | `\title{...}`, one `\author{...}` with no affiliation, `\maketitle{}` |
| title markup | examples/brucker-authorarchive-2016-acmart.tex:25 | `mark.kernel` | `\texttt{authorarchive}` |
| author link | examples/brucker-authorarchive-2016-acmart.tex:26 | `xref.hyperref` | `\protect\href{http://www.brucker.ch/}{Achim D. Brucker}` (hyperref's own command; the package is loaded by the class and by authorarchive.sty:25) |
| abstract | examples/brucker-authorarchive-2016-acmart.tex:27-29 | `abs.class-native` | `abstract` environment before `\begin{document}`, body `\lipsum[1-2]` |
| section headings | examples/brucker-authorarchive-2016-acmart.tex:34, 37, 40 | `head.class-native` | three `\section`, looks set by acmart |
| dummy text | examples/brucker-authorarchive-2016-acmart.tex:23, 28, 35, 38, 41 | `draft.todo` | `\usepackage{lipsum}`, `\lipsum[1-2]`, `[1-4]`, `[5-10]`, `[11-12]` (filler content) |
| self-archiving notice on page 1 | examples/brucker-authorarchive-2016-acmart.tex:11-21; authorarchive.sty:161-167, 239-347 | `front.authorarchive` | `\usepackage{authorarchive}` and `\authorsetup{acmart, key=brucker-authorarchive-2016, year=2016, publication={...}, startpage={42}, doi={00/0000}, nocopyright}`; with `acmart` the notice is placed at `0.4cm` above the page bottom, `\textwidth` wide (sty:165-166), publisher defaults to ACM (sty:162-164), `\authorcrfont` is `\footnotesize` (sty:131); only the first page (`\AddToShipoutPicture*`, sty:239) |
| QR code in the notice | authorarchive.sty:248-251 | `front.authorarchive` | `\qrcode[hyperlink,height=1.4cm,tight]{baseurl/key.pdf}` inside the package; `nourl` off in the sample, so the target is `\AA@baseurl/\AA@key\AA@suffix` |
| notice text | authorarchive.sty:282-310 | `front.authorarchive` | non-LNCS branch with `nocopyright`: "This is the author's version... posted at \url{...} for your personal use. Not for redistribution. The definitive version was published in \emph{publication}, pp. 42--N, 2016, doi: \href{https://doi.org/..}{..}" (the strings are fixed English in the package; `pp. 42--N` comes from `startpage` and `lastpage`, sty:141-142, 231-236) |
| first page number | examples/brucker-authorarchive-2016-acmart.tex:18; authorarchive.sty:139-143 | `pgnum.pagenumbering`, `front.authorarchive` | key `startpage={42}`; the package runs `\setcounter{page}{42}` at begin document (an emitter may write that counter line itself) |
| embedded bibliography files and links | authorarchive.sty:84-102, 311-339; examples/bib/ | `front.authorarchive` | keys `key`, `bibtexdir` (value `bib` from the config file); files `bib/brucker-authorarchive-2016.bib`, `.enw`, `.ris`, `.word.xml` shipped in the zip (ls); each is attached and linked with `\attachandlink` (sty:316, 325, 330, 335); `nobib` off; without any such file the package stops with an error (sty:341) |
| local configuration | examples/authorarchive.config:1-4; authorarchive.sty:114 | `front.authorarchive` | `\authorsetup{baseurl={https://git.logicalhacking.com/adbrucker/authorarchive/src/main/examples}, bibtexdir={bib}}`, read by `\InputIfFileExists` at load |
| effects the package sets on the document | authorarchive.sty:17, 225-229 | `front.authorarchive` | `\PassOptionsToPackage{hyphens}{url}`; `\hypersetup{draft=false, bookmarksopen=true, bookmarksnumbered=true}` (all inside the published package) |
| lists, tables, floats, math, theorems, code, bibliography, index, colour | whole main sample | not used | none of them appears in the main sample (grep of the sample: no `\begin{itemize}`, `tabular`, `figure`, `equation`, `\cite`, `\bibliography`) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `authorarchive.sty` as a whole (option declarations, `\AA@defIncludeFiles`, `\AA@defIncludeSwitches`, `\ifAA@...` branches, savebox and parbox overlay in `\AddToShipoutPicture*`) | authorarchive.sty:36-347 | not bespoke: it is the published way, not zip-local code | CTAN package v1.3.1 (README.md:26-27: "available on CTAN", TeX Live, MiKTeX; ctan.org/pkg/authorarchive read); the sample only calls `\authorsetup` with keys |
| `authorarchive.config` | examples/authorarchive.config:1-4 | yes | zip-local file of key values; the same keys go in `\authorsetup{baseurl=..., bibtexdir=bib}` |
| `\authorsetup` | authorarchive.sty:107-111 | yes (package API) | `\kvsetkeys` over the declared keys (sty:41-62); a preamble line in the way |
| `\authorat`, `\authorcrfont`, `\authorwidth` | authorarchive.sty:131-134 | yes here (not used by the sample) | package hooks for other layouts (README.md:81-90); the main sample never redefines them; a layout that did would need hand-written `\renewcommand` code outside the way |
| `\AA@pdfpagesattribute` | authorarchive.sty:117-123 | yes (package internal) | expl3 proxy that sets a PDF page attribute; called only for the LNCS and LNI options (sty:180-183, 197), not by the acmart option |

## Content-opaque
none. The `lipsum` text, title, author name, abstract, publication string, DOI and the four bibliographic data files are content. The QR code is drawn by the `qrcode` package from a URL string inside the way; it is not artwork the zip defines.

## Lib changes
- New ways proposed: `front.authorarchive`: package `authorarchive` (CTAN, TeX Live, MiKTeX; LPPL 1.3c or BSD-2-Clause; Achim D. Brucker; v1.3.1), engine pdf by reading. `\usepackage{authorarchive}` and `\authorsetup{key=value}` print a self-archiving notice with a QR code at the foot of the first page and attach the author's `.bib`, `.enw`, `.ris` and `.word.xml` entries to the PDF. W1: on CTAN, README.md:26-27 and the CTAN page. W2: string keys `bibtexdir` `baseurl` `suffix` `publisher` `year` `key` `doi` `doiText` `publisherurl` `startpage` `publication`, booleans `ACM` `acmart` `ENTCS` `IEEE` `LNCS` `LNI` `nocopyright` `nourl` `nobib` `orcidicon` (authorarchive.sty:41-62), no code edited. W3: README.md:154-155 says it needs no specific publisher or class; one notice for any paper. W4: preamble lines only. Not `front.doclicense` (licence text and icon for a copyright page), not `bg.eso-pic` (a free overlay whose content is code), not `meta.accsupp` or `meta.hyperref`. Considered: packages `qrcode` and `intopdf` as ways of their own; not proposed, because the sample never calls them and the package loads them itself (authorarchive.sty:23, 27).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
