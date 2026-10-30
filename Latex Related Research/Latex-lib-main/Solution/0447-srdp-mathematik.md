no

# 0447-srdp-mathematik: srdp-mathematik (Austrian sRDP mathematics exam formats; the sample is the package's own manual)

- Unverified: read from the source, not compiled.
- Source: Source/0447-srdp-mathematik/ (origin: https://mirrors.ctan.org/macros/latex/contrib/srdp-mathematik.zip; licence: LPPL 1.3c)
- Kind: exam
- Lib: v4
- Engine: pdfLaTeX-compatible except the PSTricks content, which needs the latex + dvips + Ghostscript route (srdp-mathematik.pdf metadata: Producer `dvips + MiKTeX GPL Ghostscript 9.25`); pdfTeX behaviour of `pstricks-add` not established
- Look carried by: mixed (the exam formats come from the CTAN package srdp-mathematik.sty, shipped in the zip; page, fonts, spacing, title page and contents come from the sample's own preamble and body)
- Class origin: tex-distribution-unbundled (the class is `article`, not in the zip; srdp-mathematik.sty and srdp-tables.sty are packages, published on CTAN, ctan.org/pkg/srdp-mathematik v1.14.1, also in TeX Live and MiKTeX)
- Main file: srdp-mathematik.tex (other samples: none)
- Read: main yes, zip-local classes and styles partly (srdp-mathematik.sty read in full to line 1049 and skimmed to 1807, the repeated checkbox-condition lines dropped; srdp-tables.sty, a tabu fork, read only as header, definition outline, options and tail, not its ~2500 lines of tabu internals)

## Verdict
no. Nearly everything reduces: the sample's own preamble is plain published packages, and the exam formats (`beispiel`, `multiplechoice`, `notenschluessel`...) are one published CTAN package, which maps to the existing `exam.questions` way with the package as the parameter. What blocks a yes is the PSTricks route: the package loads `pstricks-add` and `pst-coil` unconditionally, the sample draws with `pspicture` and calls the package command `\parallellines`, and the shipped PDF was made by dvips + Ghostscript, which is a tool outside TeX under the lib's own precedent (`color.color` colordvi, `fig.epstopdf`). Without that route the zip would reach yes.

## Blockers
- `EXTERNAL/package` PSTricks needs the PostScript route: `pstricks-add` (srdp-mathematik.sty:23) and `pst-coil` (srdp-mathematik.sty:43) are loaded unconditionally; the sample uses `pspicture` in six answer cells (srdp-mathematik.tex:794-893) and the package command `\parallellines`, whose body is `\psline` (srdp-mathematik.sty:352-364; called at srdp-mathematik.tex:572-581); the shipped PDF's Producer is `dvips + MiKTeX GPL Ghostscript 9.25`.
- Not counted, recorded so a reader can re-score under a stricter W2: the package's logic is heavy TeX: a pgfmath random-list permutation (`\prunelist`, `\declarenumlist`, srdp-mathematik.sty:652-673, seed at :676), `spreadtab` cells that compute column widths and grade limits (:431-437, :699-702), counter-driven answer ticking (:861-899), an expl3 string mapper (:130-135) and FP trigonometry (:352-364). It is published, so it is not bespoke here (W1 holds, parameters are strings, integers and counters, W2), but it is not something an emitter could rebuild from other lib ways.
- Sample defect, not a template blocker: `\textttt` is not defined anywhere in the zip (srdp-mathematik.tex:344; grep of srdp-mathematik.sty finds nothing), so the sample as shipped has an undefined control sequence.

## Class setting
- Class: `class.article` options: `a4paper`, `12pt` (srdp-mathematik.tex:1)
- Class-native vocabulary used: `\section` `\subsection` `\subsubsection` and starred forms (srdp-mathematik.tex:89,93,98,178), `titlepage` environment (srdp-mathematik.tex:51), `\tableofcontents` (redefined, :22-24). No `\maketitle`, no `abstract`, no `thebibliography`.
- Package vocabulary (`srdp-mathematik`, recorded under `exam.questions`): options `solution_on|off|minimal`, `info_on|off`, `random=0..9` (sty:86-100); environments `beispiel{pts}`, `langesbeispiel`, `aufgabenstellung`, `loesung`; commands `\notenschluessel` `\individualnotenschluessel` `\beurteilung` `\individualbeurteilung` `\antwort` `\antwortzeile` `\variation` `\multiplechoice` `\langmultiplechoice` `\lueckentext` `\englueckentext` `\zuordnen` `\Subitem` `\meinlr` `\meinlcr` `\stretchstring` `\dint` `\dx` `\degre` `\leer` `\parallellines`; counters `punkte` `Antworten` `Zufall` `info` `number` `subitemcounter`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | srdp-mathematik.tex:1 | `class.article` | a4paper, 12pt |
| paper and size | srdp-mathematik.tex:1 | `page.class-options` | a4paper, 12pt |
| page geometry | srdp-mathematik.tex:3-4 | `page.geometry` | a4paper, left=18mm, right=18mm, top=2.5cm, bottom=2cm |
| text font | srdp-mathematik.tex:7 | `font.lmodern` | `lmodern` |
| encodings | srdp-mathematik.tex:8,11 | `font.fontenc-t1` | `fontenc` T1, `inputenc` utf8 |
| euro glyph | srdp-mathematik.tex:9; srdp-mathematik.sty:53,55 | `font.icons` | `eurosym`; `\euro` redefined to `\officialeuro\xspace` |
| line spacing | srdp-mathematik.tex:10,36 | `sp.setspace` | `\onehalfspacing` |
| paragraph and head lengths | srdp-mathematik.sty:58-59 | `sp.lengths` | `\headheight`=0.4pt, `\parindent`=0pt (set by the package, applies to the whole document) |
| language | srdp-mathematik.tex:13 | `lang.babel` | ngerman |
| hyperlinks | srdp-mathematik.tex:16-21 | `meta.hyperref` | colorlinks, bookmarks=false, pagebackref=false, citecolor=blue, hidelinks |
| graphics loaded | srdp-mathematik.tex:12; sty:49 | `fig.graphicx` | loaded; only `\resizebox` is used (tex:792, answer-cell content) |
| filler-text package | srdp-mathematik.tex:15 | `draft.todo` | `blindtext` loaded, never called (no `\blindtext` in the body) |
| page style | srdp-mathematik.tex:35,52 | `hf.pagestyle-kernel` | `\pagestyle{plain}`; `\thispagestyle{empty}` on the title page |
| title page | srdp-mathematik.tex:51-86 | `front.titlepage-env` | `titlepage` + `center`, hand-laid, no `\maketitle`; text in `\Huge`, `\textsc{\large ...}` author and date lines |
| title page spacing, alignment, sizes | srdp-mathematik.tex:54-70 | `sp.manual-space`, `sp.ragged`, `font.size-commands`, `mark.kernel` | `\vfill`, `\\[1cm]`, `\\[-0.5cm]`, `\vspace{\baselineskip}`; `\flushright`, `\centering`; `\Huge`, `\large`, `\normalsize`; `\textit`, `\textsc` |
| month and year line | srdp-mathematik.tex:26-30,64 | `front.datetime` | `\Monat~\the\year`; reduction below |
| contents list | srdp-mathematik.tex:22-24,74-78 | `toc.kernel` | `\tableofcontents` redefined to `\@starttoc{toc}` (no heading), printed inside the title page |
| contents depth | srdp-mathematik.tex:1189,1213 | `toc.kernel`, `num.secnumdepth` | `\addtocontents{toc}{\setcounter{tocdepth}{-10}}` then `{1}` |
| headings | srdp-mathematik.tex:89,93,98,178 | `head.kernel` | article defaults, no restyling |
| heading numbering | srdp-mathematik.tex:1184 (off at :38) | `num.secnumdepth` | `\setcounter{secnumdepth}{-1}` before the Typ-2 example |
| inline marks | srdp-mathematik.tex:58,63,104 | `mark.kernel` | `\textit` `\textsc` `\texttt` `\textbf` `\textbackslash` |
| underline | srdp-mathematik.tex:328 | `mark.ulem` | kernel `\underline` (no package) |
| coloured text | srdp-mathematik.tex:323,410 | `color.xcolor` | `\textcolor[rgb]{1,0,0}` (red), `{0,0,1}` (blue); the package loads `color` and `xcolor` (sty:15-16) |
| verbatim code | srdp-mathematik.tex:105-114,137-148 | `code.verbatim` | `verbatim` blocks showing input |
| side-by-side blocks | srdp-mathematik.tex:618-663,972-990 | `box.minipage` | `minipage` 8cm twice; `1.0\textwidth` |
| table | srdp-mathematik.tex:540-546 | `tbl.tabular` | `tabular{r}` of `\stretchstring` rows with `\hline` |
| page breaks | srdp-mathematik.tex:301,906 | `pg.break` | `\newpage` |
| small block | srdp-mathematik.tex:1085-1130 | `font.size-commands` | `small` environment around the `\zuordnen` example |
| inline maths | srdp-mathematik.tex:111,124,490-508,517 | `math.kernel`, `math.amsmath` | `\frac` `\sqrt` `\alpha`; `\dint` and `\dx[t]` are package macros over `\displaystyle\int` and `\text{d}` (sty:390-391); `\degre` is `\ensuremath{^\circ}` (sty:56); the package loads `amsmath` `amssymb` `amsfonts` (sty:20) |
| example environment | srdp-mathematik.tex:120-125; srdp-mathematik.sty:255-269 | `exam.questions` | package srdp-mathematik: `beispiel{6}`; text in a 0.88\textwidth minipage with an `enumerate` `\item[\thenumber.]`, a 0.11\textwidth points column `___/6`; points added to counter `punkte`, half points to `counterhalfpoints` |
| long example | srdp-mathematik.tex:153-158; srdp-mathematik.sty:306-319 | `exam.questions` | package srdp-mathematik: `langesbeispiel` is a `list` with `\rightmargin.12\textwidth`, number label in `\llap`, points `\item[8]` in `\rlap`; page breaks allowed |
| grade key | srdp-mathematik.tex:167-213; srdp-mathematik.sty:410-451 | `exam.questions` | package srdp-mathematik: `\setcounter{punkte}{48}`, `\notenschluessel[1/2][prozent][ms]{0.91}{0.8}{0.64}{0.5}`; five-column `tabular{|C{3cm}...|}`, grade limits computed with `spreadtab[autoround=3]` |
| explicit grade key | srdp-mathematik.tex:221-245; srdp-mathematik.sty:454-470 | `exam.questions` | package srdp-mathematik: `\individualnotenschluessel[50]{42}{41}{38}{37}{31.5}{31}{24}` |
| assessment sheet | srdp-mathematik.tex:285-288; srdp-mathematik.sty:602-623 | `exam.questions` | package srdp-mathematik: `\beurteilung{0.875}{0.75}{0.625}{1/2}{T1={16},T2={8}}`; keys by `pgfkeys` (sty:547-582, defaults T1=24, T2=20, AP=4) |
| answer on/off | srdp-mathematik.tex:32,341-352; srdp-mathematik.sty:82-88,142,155-159 | `exam.questions` | package srdp-mathematik: counter `Antworten` 0 or 1, `\antwort[alt]{answer}` prints the answer in red only when 1, `\antwortzeile` for table rows |
| answer watermark | srdp-mathematik.sty:102-112 | `bg.eso-pic` | `\AddToShipoutPictureBG` red "Lösungen" header and footer rows and a rotated 35 degree `red!25` 60pt stamp, only under option `solution_on` (the sample does not pass it, so inactive) |
| group variants | srdp-mathematik.tex:37,396-403; srdp-mathematik.sty:91-100,117-127,676-680 | `exam.questions` | package srdp-mathematik: `random=0..9`, counter `Zufall`, `\pgfmathsetseed{\theZufall}`, `\variation{A}{B}` (up to nine variants), `\Gruppe` |
| multiple choice | srdp-mathematik.tex:622-661; srdp-mathematik.sty:861-899 | `exam.questions` | package srdp-mathematik: `\multiplechoice[5]{L1..L9, A1..A9}`, a `tabu{|T|c|}` with `\tabulinesep=3mm`, box glyph `\Square` or red `\XBox` (wasysym); `[3]`, `[7]` and default at tex:691,730,773 |
| two-block multiple choice | srdp-mathematik.tex:791-903; srdp-mathematik.sty:910-970 | `exam.questions` | package srdp-mathematik: `\langmultiplechoice[6]{...}`, two `tabu` tables inside `\meinlr` |
| gap text | srdp-mathematik.tex:931-944,976-988,1016-1027; srdp-mathematik.sty:524-531,745-793,803-851 | `exam.questions` | package srdp-mathematik: `\lueckentext[0.25]{text,L1..R3,A1,A2}`, `\gap` = two `\rule{1cm}{0.4pt}` around a circled counter; fixed German or English lead sentence; `\englueckentext` |
| matching | srdp-mathematik.tex:1061-1078,1112-1129; srdp-mathematik.sty:687-734 | `exam.questions` | package srdp-mathematik: `\zuordnen[0.25][4]{R1..R4, A..F, A1..A4}`, two `tabu` tables, `\cellcolor[gray]{0.9}` and `{0.92}`, `\hhline{--}` |
| open task and solution | srdp-mathematik.tex:1186-1212; srdp-mathematik.sty:324-342 | `exam.questions` | package srdp-mathematik: `aufgabenstellung`, `loesung` (`\NewEnviron`, `enumerate[a),leftmargin=0pt]`), `\Subitem`, counter `subitemcounter` |
| layout helpers | srdp-mathematik.tex:445-481,540-564; srdp-mathematik.sty:130-138,177-188,379 | `exam.questions`, `box.minipage`, `sp.manual-space` | package srdp-mathematik: `\meinlr[-0.15]` (FP `clip(0.48+(#1))` widths), `\meinlcr` (3 x 0.32), `\stretchstring[\,]` (expl3 map over characters), `\leer` = `\vspace{\baselineskip}` |
| PSTricks marks | srdp-mathematik.tex:572-581; srdp-mathematik.sty:352-364 | `art.pstricks` | `\parallellines[45]{1.5}{0.5}` prints two `\psline[linewidth=0.8pt]`; EXTERNAL route, see Blockers |
| package internal loads (emitted by the package, not by the sample) | srdp-mathematik.sty:15-54 | `fig.float`, `cols.multicol`, `tbl.multirow`, `tbl.colortbl`, `tbl.tabularx`, `tbl.longtable`, `tbl.tabular`, `box.mdframed`, `list.enumitem`, `math.physics`, `num.counters`, `art.tikz`, `art.pstricks` | `float` `multicol` `multirow` `colortbl` `tabularx` `longtable` `array` `hhline` `framed` `enumitem[inline,shortlabels]` `cancel` `esvect` (`\vec` -> `\vv`, :48) `chngcntr`; `pgfplots` `pgf-pie` `pgfplotstable` (:39-42, no use in the sample); `pstricks-add` `pst-coil`; utility loads with no printed effect (`varwidth` `trimspaces` `environ` `spreadtab` `pgfkeys` `forloop` `ifthen` `xparse` `fp` `ziffer` `phaistos`) are not mapped, the emitter never writes them |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\Monat` month name | srdp-mathematik.tex:26-30 | yes | `front.datetime`: a `datetime` date format `\newdateformat{...}{\monthname[\THEMONTH] \THEYEAR}` under `ngerman`, replacing the hard-coded `\ifcase\month` list; prints "month year" |
| `\tableofcontents` redefinition | srdp-mathematik.tex:22-24 | yes | `toc.kernel`: kernel-internal `\@starttoc{toc}` is the body of article's `\tableofcontents` minus its heading; printable as a preamble line under `\makeatletter` |
| `\let\cleardoublepage\relax`, `\let\clearpage\relax` in a group | srdp-mathematik.tex:74-78 | yes | inert: the redefined `\tableofcontents` calls neither, so the group can be dropped |
| toc depth changes | srdp-mathematik.tex:1189,1213 | yes | `toc.kernel` + `num.secnumdepth`: `\addtocontents` of a `\setcounter{tocdepth}` line |
| counter values fed to the package | srdp-mathematik.tex:32,37,167,341,349,619,643,673,1183-1185 | yes | `\setcounter` of `Antworten`, `Zufall`, `punkte`, `number`: integers, the package's declarative interface |
| `srdp-mathematik.sty` (1807 lines) | srdp-mathematik.sty:1-1807 | yes, by being published | one way `exam.questions` with the package as the parameter; CTAN, TeX Live, MiKTeX, LPPL 1.3c; no logic is copied. Stricter-W2 note under Blockers |
| `srdp-tables.sty` (tabu fork) | srdp-tables.sty:2-18,2520; loaded at srdp-mathematik.sty:30 | yes, by being published | part of the CTAN bundle; header says "Frozen fork of tabu" with `\global\let` state-save fixes (52 `global\let` lines); behaviour is tabu (`tbl.nicematrix`, package `tabu`); the sample never names it. Only header, outline, options and tail read |
| `@ifpackageloaded{chemie}` override block | srdp-mathematik.sty:1695-1799 | yes (inactive) | redefines `\gap`, `\lueckentext`, `\englueckentext` only when package `chemie` is loaded; the sample does not load it |
| obsolete commands | srdp-mathematik.sty:1598-1687 | yes | `\notenschluesselop`, `\beurteilungsraster`: inside the package, unused by the sample |

## Content-opaque
- PSTricks `pspicture*` triangles with `\psaxes`, `\pspolygon`, `\psdots` in six `\langmultiplechoice` answer cells (srdp-mathematik.tex:792-893).
- `\flagUK` TikZ flag (srdp-mathematik.sty:203-223): package command, never called by the sample.
- `pgfplots`, `pgf-pie`, `pgfplotstable` loaded (srdp-mathematik.sty:39-42) and empty stubs `\winkelfunktion` `\kreisdiagramm` (:290,299): nothing is drawn.
- Commented-out GeoGebra export example (srdp-mathematik.tex:1217-1284): inactive.

## Lib changes
- New ways proposed: none. Considered: a separate doc-kind way for `srdp-mathematik`; folded into `exam.questions`, whose line already takes other question-bank packages (`esami`, `mcexam`) with the package as the parameter. `exam.competences` considered for the grade tables and not used (that way is a skill tracker).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
