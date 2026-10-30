no

# 0052-muthesis: muthesis and third-rep (University of Manchester CS thesis and project-report classes)

- Unverified: read from the source, not compiled.
- Source: Source/0052-muthesis/ (origin: https://mirrors.ctan.org/macros/latex/contrib/muthesis.zip; licence: lppl1, LPPL 1 per muthesis.cls:10-13 and ctan.org/pkg/muthesis)
- Kind: thesis (muthesis.cls); third-rep.cls is a third-year project report class
- Lib: v1
- Engine: pdfLaTeX-compatible (no fontspec, no Unicode-engine code; the `\write18` perl call at muthesis.cls:470 is engine-neutral)
- Look carried by: class (muthesis.cls defines the whole thesis look; third-rep.cls defines the report front matter but takes its page layout from `a4-mancs`, which is not in the zip)
- Class origin: ctan (muthesis bundle is on CTAN and in TeX Live per ctan.org/pkg/muthesis; the bundle covers both classes, so `third-rep` counts as published too)
- Main file: none (no `.tex` in the zip; README:7-9 says the `muthesis-example` starter kit is missing from this copy). Other samples: none. The class-native vocabulary below is taken from the usage comment inside muthesis.cls:147-251.
- Read: main none present, zip-local classes and styles all (README, muthesis.cls 538 lines, third-rep.cls 102 lines, each read in full). `a4-mancs.sty` is loaded by third-rep.cls:28 and is NOT present, so it was not read.

## Verdict
`no`. The zip is two classes of one published bundle with no sample document. `muthesis.cls` on its own would be a `yes`: it is a published class (CTAN, TeX Live), so it is the single way `class.muthesis`, and its front-matter commands, switches and options are class vocabulary. The `no` comes from `third-rep.cls`, which loads `a4-mancs` unconditionally (third-rep.cls:28). That style is not shipped, `ctan.org/pkg/a4-mancs` returns 404, and nothing shows it is in TeX Live, so the project-report page layout cannot be mapped to any way. Under "if you cannot show it, no", that blocks the zip. The outcome is separable: drop `third-rep` and the verdict is `yes`, carried by the class.

## Blockers
- `UNMAPPED/class` page layout of `third-rep` comes from the style `a4-mancs`, loaded unconditionally, neither shipped nor shown to be published; its margins, headers and sizes are unknown (third-rep.cls:28)

## Class setting
- Class: `class.muthesis` options: `PhD` (default, `\ExecuteOptions{PhD}` at :137), `MSc`, `MPhil`, `MRes` (:131-134, set `\degreetitle` and the word thesis/dissertation); `singlespace`, `doublespace` (:129-130, default is one-and-a-half spacing); every other option goes to `report` (:135), e.g. `12pt`, `twoside`. Loads `report` with `a4paper` (:142).
- Class: `class.third-rep` options: `draftgraphics` (passes `draft` to graphicx, third-rep.cls:21); every other option goes to `report` (:22); loads `report` (:27).
- Class-native vocabulary used (muthesis): `\title` `\author` (report's), `\school`/`\dept`, `\faculty`, `\principaladviser`/`\principaladvisor`, `\firstreader`, `\secondreader`, `\submitdate`, `\copyrightyear` (:280-300); switches `\copyrighttrue/false`, `\figurespagetrue/false`, `\tablespagetrue/false`, `\sigpagetrue/false` (:309-310); body commands `\beforeabstract`, `\prefacesection{...}`, `\abstracttitle`, `\afterabstract`, `\afterpreface` (:457-510, usage at :162-169); then `\chapter`, `\appendix`, `\bibliographystyle`, `\bibliography` (:171-179).
- Class-native vocabulary used (third-rep): `\supervisor`, `\reportyear`, `\abstractfile`, `\thanksfile`, `\dotitleandabstract` (third-rep.cls:35-45).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class (thesis) | muthesis.cls:120,142 | `class.muthesis` | options PhD/MSc/MPhil/MRes, singlespace/doublespace |
| class (report) | third-rep.cls:19,27 | `class.third-rep` | option draftgraphics |
| base class | muthesis.cls:142; third-rep.cls:27 | `class.report` | both classes load report, which supplies `\chapter`, `abstract`, `titlepage`; muthesis passes `a4paper` |
| paper size | muthesis.cls:142 | `page.class-options` | a4paper |
| page geometry (muthesis) | muthesis.cls:253-256 | `page.setlength` | oddsidemargin 15truemm, evensidemargin 0truemm, topmargin 0truemm, headsep 10truemm, textheight 224truemm, textwidth 145truemm, marginparwidth 40pt, marginparsep 10pt |
| page geometry (third-rep) | third-rep.cls:28 | UNMAPPED (`a4-mancs` not shipped) | unknown |
| line spacing | muthesis.cls:122,264-273,338 | `sp.setspace` | `\onehalfspacing` default, `\doublespacing`, `\singlespacing` chosen at `\AtBeginDocument` by class option; title block of abstract set `\singlespacing` |
| page-break control | muthesis.cls:261,532 | `sp.penalties` | brokenpenalty=10000; clubpenalty=4000, widowpenalty=4000 in bibliography |
| title page | muthesis.cls:312-335 | `front.class-native` | `\titlep`: `\thispagestyle{empty}`, `\null\vskip1in`, centred `\Huge\uppercase` title, `\vfill`, `\textsc` statement with degree and faculty, `\vfill` year, `\vfill` "By" author and school, `\vskip.5in`, `\newpage` |
| title page spacing | muthesis.cls:314,318,324,328,333 | `sp.manual-space` | `\vskip1in`, `\vfill` x3, `\vskip.5in` |
| title page type | muthesis.cls:316,320,330,338 | `font.size-commands` | `\Huge`, `\large`, `\normalfont` |
| title page marks | muthesis.cls:320,339 | `mark.kernel` | `\textsc` |
| front matter order | muthesis.cls:457-487 | `front.class-native` | `\beforeabstract`: title page, optional signature page, toc, then list of tables, then list of figures |
| contents and lists | muthesis.cls:462,480,485 | `toc.kernel` | `\tableofcontents`, `\listoftables`, `\listoffigures`, each guarded by the class switches, each followed by `\newpage`, `\addvspace{10pt}` before the lists |
| abstract | muthesis.cls:337-343,163-166 | `abs.class-native` | `\prefacesection{Abstract}` then `\abstracttitle` (centred `\singlespacing\large` block: small-caps title, author, "A thesis submitted ... for the degree of ...") |
| unnumbered preface sections | muthesis.cls:502-504 | `head.kernel` | `\chapter*{#1}` plus `\addcontentsline{toc}{chapter}{#1}` |
| declaration page | muthesis.cls:443-455 | `front.dedication` | `\prefacesection{Declaration}`, centred `minipage{4in}`, `\parindent=0pt`, `\vfill` |
| declaration box | muthesis.cls:446,453 | `box.minipage` | width 4in |
| copyright page | muthesis.cls:345-411 | `front.dedication` | `\prefacesection{Copyright}` then `enumerate` with `\item[i.]`..`[iv.]`, `\itemsep` -2pt, `\vfill\newpage`; on by default (`\copyrighttrue`) |
| copyright list | muthesis.cls:347-350 | `list.kernel` | `enumerate`, manual labels i. to iv. |
| list spacing | muthesis.cls:348 | `sp.lengths` | `\itemsep` = -2pt |
| signature page (off by default) | muthesis.cls:413-441 | `front.dedication` | `\signaturepage`: `minipage{4in}`, `\vspace{.5in}`, three reader lines and a dean line, `\sigpagefalse` default |
| signature rule | muthesis.cls:422,438 | `sp.rule` | `\vrule width 3in height 0.4pt` inside `\hbox to 4in{\hfil\shortstack{...}}` |
| URLs in copyright text | muthesis.cls:375,378 | `meta.url` | `\url{...}` is used but neither `url` nor `hyperref` is loaded by the class (no package load besides setspace, :122), so the sample preamble must load one |
| page numbering | muthesis.cls:458 | `pgnum.pagenumbering` | `\pagenumbering{arabic}`, title page is page 1 but shows no number (:313) |
| page style | muthesis.cls:313,459,510,512 | `hf.pagestyle-kernel` | `empty` on title page, `plain` through front matter, `headings` for the body |
| appendices | muthesis.cls:175 | `num.appendix` | `\appendix` (usage comment) |
| bibliography env | muthesis.cls:521-537 | `bib.thebibliography` | report's list redefined: `\chapter*{\bibname}` with `\@mkboth` uppercase heads, `\addcontentsline{toc}{chapter}{\bibname}`, `\newblock` glue, `\sloppy` |
| bibliography style | muthesis.cls:106,178-179 | `bib.bibtex-bst` | `\bibliographystyle{alpha}` plus `\bibliography{...}` (recommended in comments) |
| third-rep title and abstract | third-rep.cls:45-70 | `front.class-native` | `\dotitleandabstract`: `\thispagestyle{empty}`, `\vspace*{1.4in}`, centred `\large` lines (university, school, "Project Report <year>", bold title, author, supervisor) |
| third-rep abstract | third-rep.cls:57-70 | `abs.kernel` | `abstract` env containing a centred `\large` title block, `\parindent` 0pt, `\input \@abstractfile` |
| third-rep acknowledgements | third-rep.cls:71-81 | `front.dedication` | `\clearpage`, `\vspace*{1.4in}`, centred bold "Acknowledgements", `quotation` with `\input{\@thanksfile}` |
| third-rep quotation | third-rep.cls:77 | `quote.kernel` | `quotation` |
| third-rep spacing | third-rep.cls:47,65,73 | `sp.manual-space` | `\vspace*{1.4in}`, `\vspace*{0.2in}` |
| third-rep paragraph | third-rep.cls:65 | `sp.lengths` | `\setlength{\parindent}{0pt}` |
| third-rep type | third-rep.cls:49,59,64 | `font.size-commands` | `\large`, `\normalsize` |
| third-rep bibliography | third-rep.cls:84-102 | `bib.thebibliography` | `\renewenvironment{thebibliography}`: report's list plus `\addcontentsline` toc entry, clubpenalty and widowpenalty 4000 |
| third-rep penalties | third-rep.cls:98 | `sp.penalties` | clubpenalty=4000, widowpenalty=4000 |
| third-rep graphics | third-rep.cls:21,29 | `fig.graphicx` | `graphicx`, `draft` via option `draftgraphics` |
| third-rep verbatim | third-rep.cls:31 | `code.verbatim` | `verbatim` package |

## Bespoke code
Every item sits in a class of the published CTAN bundle, so by W1 none is zip-local bespoke code. The reducibility is still written down, so a re-reader under a stricter definition (class internals count) has it.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\titlep` title page | muthesis.cls:312-335 | yes | `front.titlepage-env` style page: `sp.manual-space` (`\vskip`, `\vfill`), `font.size-commands`, `mark.kernel` |
| `\abstracttitle`, `\copyrightpage`, `\declpage`, `\signaturepage` | muthesis.cls:337-455 | yes | `front.dedication` pages from `box.minipage`, `list.kernel`, `sp.rule`, `sp.manual-space` |
| `\prefacesection` | muthesis.cls:502-504 | yes | `head.kernel` `\chapter*` plus `\addcontentsline` |
| `\beforeabstract`, `\afterabstract`, `\afterpreface` | muthesis.cls:457-510 | yes | fixed order of `toc.kernel`, `pgnum.pagenumbering`, `hf.pagestyle-kernel` calls and `\newpage` |
| switches `\ifcopyright` `\iffigurespage` `\iftablespage` `\ifsigpage` | muthesis.cls:309-310 | yes | boolean parameters of the class: they only choose which front-matter pages are emitted |
| `\ifdoublesp@` `\ifsinglesp@` | muthesis.cls:123-125,264-273 | yes | choose among three `sp.setspace` commands |
| copyright year and submit date defaults | muthesis.cls:300-308 | yes | `\number\year` arithmetic, content defaults; any explicit `\submitdate` / `\copyrightyear` replaces them |
| `\thebibliography` redefinition | muthesis.cls:521-537; third-rep.cls:84-102 | yes | `bib.thebibliography` plus a toc entry for the unnumbered bibliography chapter (what `toc.etoc` / tocbibind does) |
| `\write18{perl ./texcount.pl ... > word.count}` in `\beforeabstract` | muthesis.cls:470 | not counted as a blocker | Live code, not a comment. Its result is never read (the `\input{word.count}` line is commented out, :472), and the page prints the fixed text `Word Count: 999,999` (:465). Without shell escape TeX only logs a refusal, so the document does not depend on the tool, which is why the pilot ruling for `minted` does not apply. A stricter reading would call it `EXTERNAL/class`. |
| `\dotitleandabstract`, `\thanksfile`, `\abstractfile` | third-rep.cls:33-82 | yes | `front.class-native` title, `abs.kernel`, `front.dedication`; `\ifthanks@` only chooses whether the acknowledgements page is emitted; `\abstractfile{null}` default needs the user to name an abstract file |
| style `a4-mancs` | third-rep.cls:28 | unknown | not shipped and not shown to be published; cannot be shown reducible |

## Content-opaque
none

## Lib changes
- New ways proposed: none. `class.muthesis` and `class.third-rep` are plain class ways (published, CTAN and TeX Live); the vocabulary recorded under "Class setting" is for the lib's class section.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
