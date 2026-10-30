no

# 0547-dfgproposal: proposal / dfgproposal / euproposal (LaTeX classes for funding proposals)

- Unverified: read from the source, not compiled.
- Source: Source/0547-dfgproposal/ (origin: https://mirrors.ctan.org/macros/latex/contrib/proposal.zip; licence: LPPL)
- Kind: misc (grant proposal and project report, written to funding-body forms: DFG, EU FP7)
- Lib: v4
- Engine: pdfLaTeX-compatible (dfg/proposal/Makefile:18 runs pdflatex; no fontspec, no Lua)
- Look carried by: class (the CTAN `proposal` bundle: base `proposal`, `dfgproposal`, `euproposal`; the samples add class options, metadata keys and content)
- Class origin: ctan
- Main file: dfg/proposal/proposal.tex (other samples: dfg/proposal/submit.tex, dfg/proposal/public.tex, dfg/report/finalreport.tex, dfg/report/letter_submission.tex (the manifest's pick; class `dinbrief`), eu/strep/propB.tex)
- Read: main yes, zip-local classes and styles all (no .cls or .sty is shipped, only the three .dtx sources; base/proposal.dtx, dfg/dfgproposal.dtx and eu/euproposal.dtx were read, every code line; generated files are not in the zip)

## Verdict
No. The look is carried by published CTAN classes (`class.dfgproposal` on `class.proposal` on `class.article`), and every component the samples use maps to a lib way or to class-native vocabulary; the only zip-local macros (`\classoptions`, one empty shim) reduce by inline expansion. It still fails on `EXTERNAL/package`: the `gitinfo` option that the main sample selects loads `gitinfo2`, which the zip's own manual says needs git post-commit hooks, and the EU sample's `deliverables` option relies on Unix `sort` outside TeX to order its deliverables table. The class-internal machinery (the `.pdata` aux-file data store, the token-register table builder, the TikZ Gantt chart) is published CTAN code and is not counted here, but read on its own it would be irreducible.

## Blockers
- `EXTERNAL/package` option `gitinfo` loads `gitinfo2[mark]` unless `submit` is set (base/proposal.dtx:576, 639); the manual says "you will need to install the post-commit hooks ... for this to work" (base/proposal.dtx:165-167). Selected by dfg/proposal/proposal.tex:6, dfg/report/finalreport.tex:4, eu/strep/propB.tex:6. `gitinfo2` itself was not read (its CTAN page does not say what happens without hooks).
- `EXTERNAL/package` option `deliverables`: the due-date-ordered deliverables table needs the `.delivs` file to be sorted by Unix `sort` into `.deliverables` outside TeX (base/proposal.dtx:422-426; eu/strep/Makefile:57); selected by eu/strep/propB.tex:6 and printed through eu/strep/propB.tex:51 -> eu/strep/quality.tex:9 -> eu/strep/methodology.tex:30 -> eu/strep/deliverables.tex:28. Without the sort `\inputdelivs` falls back to the unsorted `.delivs` (base/proposal.dtx:1512-1514), so the order the EU template asks for (eu/strep/deliverables.tex:5) is lost.

## Class setting
- Class: `class.dfgproposal` options: `RAM`, `gitinfo`, `keys` (dfg/proposal/proposal.tex:6); `submit` and `public` through `\classoptions` in the variants (dfg/proposal/submit.tex:1, public.tex:1); own options `general`, `german` (dfg/dfgproposal.dtx:193-195); every other option is passed to `proposal` (dfg/dfgproposal.dtx:196) and on to the kernel class (base/proposal.dtx:584). Chain: `\LoadClass{proposal}` (dfg/dfgproposal.dtx:206) -> `\LoadClass[a4paper,twoside]{article}` (base/proposal.dtx:591); option `report` selects `report` instead (base/proposal.dtx:581).
- Other classes in the zip: `class.dfgreporting` (dfg/report/finalreport.tex:4, options `gitinfo`), `class.euproposal` (eu/strep/propB.tex:6, options `noworkareas,deliverables,gitinfo,propB`; `propB` loads `report`, eu/euproposal.dtx:230), `class.dinbrief` (dfg/report/letter_submission.tex:1; TeX Live class, not in the zip, source not read; ctan.org/pkg/dinbrief: LPPL 1.1).
- Class-native vocabulary used: `proposal` environment with keys `PI` `site` `thema` `acronym` `acrolong` `title` `totalduration` `since` `start` `months` `<site>RM` `<site>RAM` `discipline` `areas` (dfg/proposal/proposal.tex:21-32); `Zusammenfassung` and `Summary` (proposal.tex:34-56); `objective[id,title]` (workplan.tex:15); `workplan`, `workarea[id,title,short]`, `workpackage[id,lead,title,<site>RM,wphases]`, `tasklist`, `task[id,wphases,requires]` (workplan.tex:66-193); `\wpfig` (workplan.tex:64); `\ganttchart[draft,xscale=.45]` (workplan.tex:195); `\WAref` `\WPref` `\OBJref` `\OBJtref` `\taskref` `\taskin` `\pdatacount` `\pn` `\pnlong` (workplan.tex:55-70, 94); `sitedescription{id}` (preconditions.tex:40); `\dfgprojpapers{keys}` (state.tex:42); `report[importfrom,key,reportperiod,applareas,projpapers,...]` (finalreport.tex:20-32); EU: `milestones`/`\milestone`, `wpdelivs`/`wpdeliv`, `\inputdelivs`, `\milestonetable`, `risk`, `\keypubs`, `\jointpub`..`\coherencetable` (eu/strep/*.tex).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | dfg/proposal/proposal.tex:6 | `class.dfgproposal` | RAM, gitinfo, keys (+ submit, public per variant) |
| base class chain | base/proposal.dtx:572, 591 | `class.proposal`, `class.article` | a4paper, twoside; `report` option -> `class.report` |
| report and EU classes | dfg/report/finalreport.tex:4; eu/strep/propB.tex:6 | `class.dfgreporting`, `class.euproposal`, `class.report` | gitinfo / noworkareas, deliverables, gitinfo, propB |
| letter class | dfg/report/letter_submission.tex:1 | `class.dinbrief` | none |
| paper and sides | base/proposal.dtx:591 | `page.class-options` | a4paper, twoside |
| margins | base/proposal.dtx:606 | `page.geometry` | a4paper, margin=18mm |
| running head and foot | base/proposal.dtx:599, 658-675 | `hf.class-native` | head RE,LO acronym; LE,RO "page n of N" (N from .pdata); foot empty; fancyplain; `grantagreement` variant 659-671 (fancyhdr inside the class) |
| page number reset | dfg/dfgproposal.dtx:374; base/proposal.dtx:857 | `pgnum.pagenumbering` | `\setcounter{page}{0}` after title page |
| default font | base/proposal.dtx:610-611 | `font.family-default`, `font.helvet` | familydefault=sfdefault; helvet scaled=.90 |
| encoding | dfg/proposal/proposal.tex:8; base/proposal.dtx:612; eu/strep/propB.tex:7-8 | `font.fontenc-t1` | inputenc utf8; textcomp; EU adds fontenc T1 |
| symbols | base/proposal.dtx:593, 2312-2316; dfg/dfgproposal.dtx:209 | `font.icons` | wasysym (`\smiley` `\star`), eurosym (`\euro`) |
| sizes | dfg/dfgproposal.dtx:340-344; dfg/proposal/proposal.tex:14 | `font.size-commands` | `\LARGE` `\large` `\huge` `\footnotesize` |
| list spacing | base/proposal.dtx:2449 | `sp.linespread` | baselinestretch .9 inside the paper list |
| manual spacing | dfg/dfgproposal.dtx:340-344; dfg/proposal/funds.tex:61; letter_submission.tex:3 | `sp.manual-space` | `\\[.2cm]`, `\medskip`, `\hspace*{5cm}` |
| centred banner | dfg/proposal/proposal.tex:14-17 | `sp.ragged` | `center`; `\color{red}` via `color.xcolor` |
| colours | base/proposal.dtx:597, 620, 1769-1772 | `color.xcolor` | darkblue rgb 0,0,.7; set leadgray .90, wagray .70, ganttgray .60 |
| coloured cells | base/proposal.dtx:596, 1773-1776; eu/strep/issues.tex:19-21 | `tbl.colortbl` | `\cellcolor{wagray}`, `lightgray` |
| languages | dfg/dfgproposal.dtx:211-212, 486; letter_submission.tex:2 | `lang.babel` | ngerman,USenglish (ngerman alone with `german`); `otherlanguage{ngerman}`; letter loads `ngerman` |
| quotation marks | base/proposal.dtx:614 | `lang.csquotes` | load only (biblatex needs it) |
| PDF links | base/proposal.dtx:620-624 | `meta.hyperref` | bookmarks=true, colorlinks=true, link/cite/urlcolor darkblue (submit) or blue, breaklinks, bookmarksopen |
| URLs | base/proposal.dtx:594; dfg/proposal/proposal.tex:19-20 | `meta.url` | `\url`, `\urldef` |
| link targets | base/proposal.dtx:1668, 1713 | `xref.hyperref` | `\hypertarget` / `\hyperlink` named `cat@id@target` |
| labels | dfg/proposal/workplan.tex:57, 190; state.tex:22 | `xref.kernel` | `\label` `\ref` |
| project references | dfg/proposal/workplan.tex:55-70, 94 | `class.dfgproposal` | `\WAref{id}` `\WPref{id}` `\OBJref{id}` `\taskref{wp}{id}` `\pdatacount{all}{wp}` `\pn`, read from `<job>.pdata` (base/proposal.dtx:1648-1745) |
| title page and metadata | dfg/proposal/proposal.tex:21-32; dfg/dfgproposal.dtx:337-375 | `front.class-native` | instrument, title, acronym, `\today`, `\WAauthorblock[aff]`, tocdepth 2 table of contents, optional general-information section (`general`) |
| summary | dfg/proposal/proposal.tex:34-56; dfg/dfgproposal.dtx:485-493 | `abs.class-native` | `Zusammenfassung`, `Summary`; printed only with `general`, else `\excludecomment` |
| closing pages | base/proposal.dtx:827-833; dfg/dfgproposal.dtx:389-403, 478 | `front.class-native` | attachments list, `\printbibliography[heading=warnpubs]`, `\signatures` |
| contents | dfg/dfgproposal.dtx:346-348; base/proposal.dtx:1092, 1218 | `toc.kernel` | `\tableofcontents`, tocdepth 2 (reports 1), `\addcontentsline` for work packages |
| headings | dfg/proposal/state.tex:1, 22; funds.tex:5-30; base/proposal.dtx:654 | `head.kernel`, `num.secnumdepth` | `\section`..`\subsubsection`, `\paragraph*`; secnumdepth 3; article look unchanged |
| inline font switches | dfg/proposal/workplan.tex:202-203; funds.tex:60 | `mark.kernel` | `\sf`, `\textbf`, `\textsc`, `\texttt`, `\emph`, `\underline` |
| lists | dfg/proposal/workplan.tex:7; state.tex:28; base/proposal.dtx:605, 1274, 1524 | `list.kernel`, `list.paralist` | itemize; compactdesc, compactenum (`tasklist`), compactitem |
| maths | dfg/proposal/funds.tex:13; dfg/dfgproposal.dtx:538 | `math.kernel`, `math.amssymb` | inline `$100 \%$`, `$\widehat=$` |
| editorial notes | dfg/proposal/proposal.tex:35, 66; state.tex:44; funds.tex:11, 39 | `draft.todo` | package `ed` (CTAN, lib/proposal.bib:2-4): `[show]`, `[hide]` under `submit`; `todo{src}`, `oldpart{src}`, `\ednote`; `\ednoteshape`=`\sl\footnotesize` (base/proposal.dtx:633-641); source not read |
| public/private text | base/proposal.dtx:578, 602-603, 648; dfg/proposal/proposal.tex:74 | `draft.todo` | package `comment` (nearest way): `private` env, `\excludecomment` when `public`; the sample's `\begin{private}` is commented out |
| key debug margin notes | base/proposal.dtx:2490 | `note.marginpar` | option `keys`: `\@dmp` -> `\marginpar{key=value}` |
| footnotes and counters | base/proposal.dtx:609, 2264; eu/euproposal.dtx:240-242 | `fn.kernel`, `num.counters` | mpfootnote in roman; `\counterwithin{figure}{subsection}` (chngcntr) |
| work-package table | dfg/proposal/workplan.tex:64; base/proposal.dtx:1798-1823, 1862-2069 | `tbl.tabular`, `tbl.colortbl`, `cap.kernel`, `fig.rotating` | `table[ht]` + `center` + `tabular`; `\caption`, `\label{fig:wplist}`; rotated headers `sideways`; vocabulary `\wpfig[pages,type,start,length,end]` is `class.dfgproposal` |
| Gantt figure | dfg/proposal/workplan.tex:195; base/proposal.dtx:2178-2264 | `fig.graphicx`, `cap.kernel` | `figure[ht]`, `\caption{..}\label{fig:gantt}`, `\footnotetext`; the drawing is `art.tikz`, class-generated (see Content-opaque) |
| applicants and site tables | dfg/dfgproposal.dtx:317-329; base/proposal.dtx:1164-1169 | `tbl.tabular` | `\|l\|` columns, `\hline`, `\multicolumn`, `p{}` columns |
| coherence matrix | eu/strep/implementation.tex:53-58; base/proposal.dtx:2352-2387 | `class.euproposal` | `\jointorga{..}` `\jointpub` `\jointproj` `\jointsup` `\jointsoft`, `\coherencetable` (a `tabular` with `\cellcolor`) |
| deliverables table | eu/strep/deliverables.tex:28; base/proposal.dtx:1484-1493 | `tbl.longtable` | `\|l\|p{8cm}\|l\|l\|l\|l\|l\|`; order needs `sort` (blocker) |
| framed boxes | base/proposal.dtx:800; eu/euproposal.dtx:441-442, 480 | `box.mdframed` | `emphbox` settings=\large; `wpobjectives` frametitle=Objectives; `wpdescription`; `\surroundwithmdframed{wpdelivs}` |
| site box | eu/euproposal.dtx:390-398 | `fig.wrapfig` | `wrapfigure{r}{5cm}` with a `tabular` |
| bibliography | base/proposal.dtx:613; dfg/proposal/proposal.tex:7, 71 | `bib.biblatex-bibtex` | style=alphabetic, backend=bibtex, hyperref=auto, defernumbers, backref, firstinits, maxbibnames=6; `\addbibresource{../lib/dummy}`; `\printbibliography[heading=empty,notcategory=featured]` |
| project papers | dfg/proposal/state.tex:42; base/proposal.dtx:2437-2454 | `bib.biblatex-bibtex` | `\DeclareBibliographyCategory{featured}`, `\addtocategory`, `\printbibliography[type=,keyword=]`, `\defbibheading` |
| file inclusion | dfg/proposal/proposal.tex:9, 60-61, 75-76; dfg/report/finalreport.tex:34-35 | `struct.input` | `\input`, `\include` |
| letter | dfg/report/letter_submission.tex:7-12, 18-29 | `ltr.opening`, `tbl.tabular` | `letter` with address, `\subject`, `\opening`, `\closing`, `\signature`; centred `lp{8cm}` table |
| project acronym strings (letter) | dfg/report/letter_submission.tex:4, 14-15 | none needed (content) | `\pn` `\pnlong` read the acronym and long title from `proposal.pdata`; reduces by writing the two strings (dfg/proposal/proposal.tex:23-25) as text |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\classoptions` | dfg/proposal/proposal.tex:5; public.tex:1; submit.tex:1; eu/strep/submit.tex:1 | yes | inline into the `\documentclass` option list (`,keys`, `,submit`, `,submit,public`). As written, eu/strep/propB.tex:6 appends it with no comma, so eu/strep/submit.tex:1 reads as option `propBsubmit` (sample defect, not compiled) |
| `\providecommand\ifprefchar[2]{}` | dfg/report/finalreport.tex:13 | yes | no printed effect (a biblatex compatibility shim); omit |
| stale `Abriss` environment | dfg/proposal/zusammenfassung.tex:1-11 | yes | not input by proposal.tex and defined nowhere in the zip (only named at dfg/dfgproposal.dtx:171); content, drop |
| `.pdata` data store (`\pdata@def`, `\readpdata`, `\pdataref`) | base/proposal.dtx:1648-1745 | published (CTAN, not zip-local) | not counted; alone it would be BESPOKE/class: `\protected@write` to `<job>.pdata`, re-read on the next run to drive printed tables |
| work-package table builder `\wpfig` | base/proposal.dtx:1862-2069 | published | not counted; alone BESPOKE/class: `\xdef` token-register loops over ids with count registers, four sites/areas cases |
| Gantt chart `\ganttchart` | base/proposal.dtx:2109-2264 | published | not counted; alone BESPOKE/class: TikZ drawn from `.pdata`, `\@whilenum` effort sums |
| kernel redefinitions inside EU class | eu/euproposal.dtx:291, 404-407 | published | not counted: `\def\numberline`, `\renewcommand\paragraph{\@startsection...}` |
| `bin/generate-issues` (ruby), `bin/checksum`, `bin/filedate` (perl) | bin/README:1-8 | n/a | maintainer tooling (GitHub issues, DocStrip checksums), not part of the PDF; not counted |

## Content-opaque
- Gantt chart TikZ picture generated by `\ganttchart` (dfg/proposal/workplan.tex:195; eu/strep/workplan.tex:12; base/proposal.dtx:2121-2134), drawn from data, inside a `figure` float.
- Person and institution records for the title page, in `../lib/WApersons.tex` (dfg/proposal/proposal.tex:9; eu/strep/propB.tex:10; dfg/report/finalreport.tex:11): file is not in the zip, commands (from the stex `workaddress` package, lib/proposal.bib:23) unknown.
- Missing assets: `../lib/dummy.bib` (proposal.tex:7), `WApersons.tex`, the stex bundle files `workaddress.sty` `metakeys.sty` `sref.sty` (dfg/proposal/Makefile:27; the CTAN page says `proposal` requires `stex`), `CV_PubList_Kohlhase.tex` and `doc/` (dfg/report/README:6-13); the `.cls` and `.sty` files must be generated from the `.dtx` by DocStrip (dfg/dfgproposal.ins:25-27, base/proposal.ins:25-27).
- Mock text in `todo` notes quoting the DFG and EU forms (dfg/proposal/state.tex:2-21; eu/strep/issues.tex:2-15).

## Lib changes
- New ways proposed: none. Considered: `xref.xr` for `\readpdata{proposal}` (rejected: the letter only uses it for two strings, which are content); `comment` filed under `draft.todo` as the nearest way.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
