yes

# 0614-resumecls: resumecls (resume/CV class for English and Chinese, huxuan)

- Unverified: read from the source, not compiled.
- Source: Source/0614-resumecls/ (origin: https://mirrors.ctan.org/macros/xetex/latex/resumecls.zip; licence: lppl1.3, LPPL 1.3 stated at resumecls.dtx:6-8)
- Kind: cv
- Lib: v5
- Engine: needs XeLaTeX (the class loads hyperref with the `xetex` driver option, resumecls.dtx:210, on top of ctexart, resumecls.dtx:204; the author's Makefile builds with `xelatex`, example/Makefile:28; dtx:355 says "we use XeLaTeX and CTeX")
- Look carried by: class (the whole look is defined in the CTAN class source resumecls.dtx:196-348; the sample resume-en.tex adds only option `color`, field strings and body calls of the class's `\heading` and `\entry`)
- Class origin: ctan
- Main file: example/resume-en.tex (other samples: example/resume-zh.tex, same body with Chinese text and `today=small`; example/resume-common.tex is included by both)
- Read: main yes, zip-local classes and styles all (no .cls or .sty ships; the class source resumecls.dtx, 388 lines, and resumecls.ins, 62 lines, were read in full; resume-zh.tex, resume-common.tex, resume.bib, both Makefiles and both READMEs were also read; the three PDFs were not opened)

## Verdict
yes. The look is carried by `resumecls`, a published CTAN class (README.md:13 says it is on CTAN and installable with `tlmgr`; the zip is the CTAN release), so no bespoke code is defined in the zip in the rubric's sense. Even read as code, the class is only `\LoadClass` of `ctexart` plus `geometry`, `hyperref`, `tabularx`, `color`, `fancyhdr` and `natbib` settings and three short `\newcommand`s over `tabularx` and `\colorbox`, all of which reduce to lib ways. There is no artwork (the heading band is a `\colorbox`, not a drawing) and no tool outside TeX is needed (the Makefiles call only latex, xelatex, bibtex and makeindex). The engine is XeLaTeX, which is recorded and not a blocker.

## Blockers
none

## Class setting
- Class: `class.resumecls` options: `color` (example/resume-en.tex:14); every other option is passed to ctexart (resumecls.dtx:202-203). Base class: `class.ctexart` loaded as `\LoadClass[a4paper,12pt]{ctexart}` (resumecls.dtx:204; ctexart is in the CTAN `ctex` bundle, source not read).
- Class-native vocabulary used: `\name` `\organization` `\address` `\mobile` `\mail` `\homepage` `\leftfooter` `\rightfooter` (string fields, resumecls.dtx:244-294), `\maketitle` (redefined, dtx:326-332), `\heading{text}` (dtx:302-308), `\entry{indent}{colspec}{body}` (dtx:314-318); the bibliography title `\refname` is emptied (dtx:348).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | example/resume-en.tex:14 | `class.resumecls` | option `color` (switches hyperref to `colorlinks`, dtx:196-197, 225-229) |
| base class | resumecls.dtx:202-204 | `class.ctexart` | `a4paper`, `12pt`; unknown options forwarded with `\PassOptionsToClass` |
| paper and base size | resumecls.dtx:204 | `page.class-options` | `a4paper`, `12pt` |
| page geometry | resumecls.dtx:209 | `page.geometry` | top=.5in, bottom=.5in, left=.5in, right=.5in |
| CJK, fonts, date format | resumecls.dtx:204, 355-357; example/resume-en.tex:24; example/resume-zh.tex:24 | `lang.cjk` | ctexart with its default CJK and Latin fonts (no font command in the class); `\ctexset{today=old}` (en) and `today=small` (zh) set how `\today` prints |
| heading size command | resumecls.dtx:305, 328 | `lang.cjk` | ctex `\zihao{4}` (size no. 4) in headings and in the name line |
| colour definition | resumecls.dtx:212, 220 | `color.color` | `\RequirePackage{color}`, `\definecolor{heading}{gray}{0.85}` |
| link style | resumecls.dtx:210, 225-229 | `meta.hyperref` | `\RequirePackage[xetex,unicode]{hyperref}`; `\hypersetup{colorlinks}` when option `color` is set, else `\hypersetup{hidelinks}` |
| email and homepage links | resumecls.dtx:329-330 | `meta.hyperref` | `\href{mailto:..}{..}` and `\url{..}` in the title block; footer URL at example/resume-en.tex:22 |
| url command | resumecls.dtx:330; example/resume-en.tex:22 | `meta.url` | `\url{...}` (provided through hyperref) |
| contact fields | resumecls.dtx:244-294; example/resume-en.tex:18-22; example/resume-common.tex:13-15 | `front.class-native` | `\name` `\organization` `\address` `\mobile` `\mail` `\homepage` (strings) |
| title block | resumecls.dtx:326-332; example/resume-en.tex:28 | `front.class-native` | redefined `\maketitle` = one `\entry{0em}{Xr}{...}` of three rows: name and mobile, organization and mailto link, address and homepage URL; first row `\bfseries\zihao{4}` |
| section heading | resumecls.dtx:302-308; example/resume-en.tex:30 | `head.class-native` | command `\heading{text}`, unnumbered, no sectioning counter |
| heading band | resumecls.dtx:303 | `box.fancybox` | `\colorbox{heading}{...}`, grey 0.85 (reduction of `\heading`) |
| heading band width | resumecls.dtx:304 | `box.minipage` | `\parbox{.98\textwidth}{...}` |
| heading font | resumecls.dtx:305 | `mark.kernel` | `\bfseries` (with `\zihao{4}` under `lang.cjk`) |
| entry block | resumecls.dtx:314-318; example/resume-en.tex:31-83 | `cv.entries` | command `\entry{indent}{colspec}{body}`; the sample uses indents 0em, 2em, 4em and column specs Xlr, Xrr, lXX, Xr, X, lX |
| entry table | resumecls.dtx:211, 315 | `tbl.tabularx` | `\begin{tabularx}{\textwidth}{@{\hspace{<indent>}}<colspec>}` (reduction of `\entry`); cells are content |
| bold lead cell, quad gap | example/resume-en.tex:31, 38, 45 | `mark.kernel` | `{\bfseries Organization}` inside a cell |
| spacing inside cells | example/resume-en.tex:31, 46, 54 | `sp.manual-space` | `\quad` between two fields of one cell |
| page container | example/resume-en.tex:27, 91, 93, 100 | `tbl.tabular` | kernel `table` float without `\caption` wrapping each page; class documentation says each page is enclosed in a `table` (resumecls.dtx:361-377) |
| page break between pages | example/resume-en.tex:92 | `pg.break` | `\clearpage` |
| vertical adjustment | example/resume-en.tex:87 | `sp.manual-space` | `\vspace{-6em}` before the bibliography |
| page style | resumecls.dtx:213, 337-340 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\headrulewidth` 0pt, `\footrulewidth` 0pt (no header) |
| footer fields | resumecls.dtx:284-294, 341-342; example/resume-en.tex:21-22 | `hf.class-native` | `\leftfooter{..}` and `\rightfooter{..}` feed `\fancyfoot[L]` and `\fancyfoot[R]` (reduction: `hf.fancyhdr`) |
| footer font | resumecls.dtx:341-342 | `font.size-commands` | `\footnotesize` |
| bibliography | resumecls.dtx:236; example/resume-en.tex:86-88; example/resume.bib:1-12 | `bib.bibtex-bst` | `\bibliographystyle{unsrt}`, `\bibliography{resume}` (BibTeX run, see example/Makefile:33); the title `\refname` is emptied (dtx:348); `\heading{Publications}` stands in as the title |
| citations | resumecls.dtx:235-237; example/resume-en.tex:49 | `bib.natbib` | `\RequirePackage[sort&compress]{natbib}`, `\bibsep` set to 0pt (dtx:237), `\cite{label}` in a cell |
| file inclusion | example/resume-en.tex:16 | `struct.input` | `\include{resume-common}` (three field commands; an emitter can inline them) |
| verbatim in text | example/resume-en.tex:97 | `code.verbatim` | `\verb|\clearpage|` inside an `\entry` argument (not compiled, so not claimed to work) |
| doc driver class (not loaded by the sample) | resumecls.dtx:34 | `class.ltxdoc` | `\documentclass{ltxdoc}` for the manual |
| doc driver machinery (not loaded by the sample) | resumecls.dtx:74-79, 115, 117-127, 190, 387 | `dtx.doc` | `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput`, `\GetFileInfo`, `\DoNotIndex`, `\StopEventually{\PrintChanges\PrintIndex}`, `\Finale`; makeindex steps at Makefile:32-33 |
| doc driver listings (not loaded by the sample) | resumecls.dtx:43-73, 369-377 | `code.listings` | `\lstset{...}` with frame=single, numbers=left, `language={[LaTeX]TeX}`, colours; one `lstlisting` |
| doc driver colours and links | resumecls.dtx:36-41 | `color.color` | `\definecolor` dkgreen, gray, mauve; `meta.hyperref` with `[xetex,unicode,colorlinks]` at dtx:41 |
| doc title, abstract, sections (not loaded by the sample) | resumecls.dtx:131-142, 144, 158, 192 | `front.maketitle` | `\title` with `\thanks` (`front.thanks`), `\author`, `\date`, `\maketitle`, `abstract` (`abs.kernel`), `\section` (`head.kernel`) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| the whole class `resumecls.cls` (derived from the .dtx by `latex resumecls.ins`) | resumecls.dtx:29-348; resumecls.ins:47 | yes, and published | the class is on CTAN (README.md:13), so it is `class.resumecls`; written out it is `class.ctexart[a4paper,12pt]` + `page.geometry` + `meta.hyperref` + `tbl.tabularx` + `color.color` + `hf.fancyhdr` + `bib.natbib` + the macros below |
| `\newif\ifrclscolor`, `\DeclareOption{color}` | resumecls.dtx:196-197, 225-229 | yes | a boolean that picks `\hypersetup{colorlinks}` or `\hypersetup{hidelinks}` (`meta.hyperref`) |
| `\DeclareOption*` forwarding | resumecls.dtx:202-203 | yes | other options are options of `class.ctexart` |
| field macros `\rclsname` ... `\rclsrightfooter` and `\name` ... `\rightfooter` | resumecls.dtx:244-294 | yes | `\def` string stores; an emitter writes the strings into the title block and footer fields |
| `\heading` | resumecls.dtx:302-308 | yes | `\colorbox{heading}{\parbox{.98\textwidth}{\bfseries\zihao{4}text}} \\` = `box.fancybox` + `box.minipage` + `mark.kernel` + `lang.cjk` |
| `\entry` | resumecls.dtx:314-318 | yes | a `tabularx` of width `\textwidth` with `@{\hspace{indent}}` before the column spec (`tbl.tabularx`) |
| `\maketitle` redefinition | resumecls.dtx:326-332 | yes | one `tabularx` of three rows `Xr` with a `\href{mailto:..}` and a `\url` (not a kernel-internal `\@maketitle` rewrite) |
| fancy page style | resumecls.dtx:337-342 | yes | `hf.fancyhdr` calls only |
| `\renewcommand{\refname}{}` | resumecls.dtx:348 | yes | a string made empty so the bibliography prints no title |
| Makefile, example/Makefile | Makefile:21-35; example/Makefile:25-45 | not template code | build drivers for latex (docstrip), xelatex, bibtex and makeindex only; they generate no `.tex`, so no EXTERNAL blocker |

No text addressed to an AI was found in the zip.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
