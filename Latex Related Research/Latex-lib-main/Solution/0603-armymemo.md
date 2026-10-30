yes

# 0603-armymemo: armymemo (U.S. Army memorandum class, AR 25-50)

- Unverified: read from the source, not compiled.
- Source: Source/0603-armymemo/ (origin: https://mirrors.ctan.org/macros/xetex/latex/armymemo.zip; licence: GPL version 2 or later, armymemo.dtx:6-9, README.md:29-36)
- Kind: letter (a memorandum; the manifest hint `letter` fits)
- Lib: v5
- Engine: needs XeLaTeX (`fontspec` with `\defaultfontfeatures{Mapping=tex-text}` and `\setmainfont{Arial}`, armymemo.dtx:245-247; README.md:6 states xelatex and the Arial font)
- Look carried by: class (the zip is the class source itself: armymemo.dtx:231-424 generates armymemo.cls; there is no sample document)
- Class origin: ctan (package `armymemo` 1.0.0, CTAN path /macros/xetex/latex/armymemo, one read of https://ctan.org/pkg/armymemo; GPL-2)
- Main file: none (no .tex holds `\begin{document}` for a memo; the only driver is the documentation driver armymemo.dtx:32-40 under `ltxdoc`, and the memo usage example is quoted text at armymemo.dtx:109-153) (other samples: none; armymemo.pdf is the compiled manual, not read)
- Read: main yes (no main .tex; armymemo.dtx read in full, lines 1-428, plus armymemo.ins and README.md), zip-local classes and styles all (armymemo.cls is not in the zip; it is generated from armymemo.dtx by armymemo.ins:48, and the class code, armymemo.dtx:231-424, was read in full)

## Verdict
yes. The zip is the CTAN package `armymemo`, a published class (W1), so it is one class way, `class.armymemo`, with the native vocabulary listed below. Read apart as a check, the class source adds no irreducible code: it is `\LoadClass{article}` plus `datetime`, `fancyhdr`, `geometry`, `fontspec`, `ragged2e`, kernel counters, boxes and spacing, and the one TikZ use holds a single included image and reduces to `\includegraphics` with a shift. There is no `ART`, `EXTERNAL`, `UNMAPPED` or `BESPOKE` blocker. Caveats that are not blockers: Arial is not shipped (a font name parameter), the logo is an EPS asset, and the zip has no compilable memo, so body use is known only from the quoted example.

## Blockers
none

## Class setting
- Class: `class.armymemo` options: none (Grep of armymemo.dtx finds no `\DeclareOption`, `\ProcessOptions` or `\PassOptionsToClass`); the class fixes its base as `\LoadClass[letterpaper,12pt,oneside]{article}` (armymemo.dtx:231)
- Class-native vocabulary used: header fields `\department` (default "DEPARTMENT OF THE ARMY", armymemo.dtx:275,279), `\unit` `\unitaddress` `\unitcity` (armymemo.dtx:276-278), `\officesymbol` `\memothru` `\memofor` `\subject` `\enclosures` (armymemo.dtx:299-303), kernel `\date` (printed at armymemo.dtx:343); body commands `\makeheader` (armymemo.dtx:340), paragraph prefixes `\ami` `\amii` `\amiii` (armymemo.dtx:327-329), `\makesigblock{name}{rank, branch}{title}` (armymemo.dtx:359); the memo example is at armymemo.dtx:109-153; `\unit`, `\unitaddress`, `\unitcity`, `\officesymbol`, `\memofor`, `\subject` are required, each defaults to a `\ClassError` (armymemo.dtx:280-282,304,306-307)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | armymemo.dtx:231 | `class.armymemo` | no options; native vocabulary above |
| base class | armymemo.dtx:231 | `class.article` | loaded by `\LoadClass[letterpaper,12pt,oneside]{article}` |
| paper, size, sides | armymemo.dtx:231 | `page.class-options` | letterpaper, 12pt, oneside |
| page geometry | armymemo.dtx:244 | `page.geometry` | letterpaper, margin=1in, includefoot (AR 25-50 1in margins, comment armymemo.dtx:239-241) |
| header height | armymemo.dtx:385, armymemo.dtx:414 | `page.setlength` | `\headheight` 56pt in the letterhead style, 30pt in the body style |
| main font | armymemo.dtx:245-247 | `font.fontspec` | `\defaultfontfeatures{Mapping=tex-text}`, `\setmainfont{Arial}`; no `\setsansfont` or `\setmonofont` |
| text shape | armymemo.dtx:255 | `sp.ragged` | `ragged2e` loaded, `\RaggedRight` |
| paragraph spacing | armymemo.dtx:256-257 | `sp.lengths` | `\parskip`=`\baselineskip`, `\parindent`=0pt |
| widow, club, broken penalties | armymemo.dtx:258-260 | `sp.penalties` | `\widowpenalty`, `\clubpenalty`, `\brokenpenalty` all 10000 |
| date format | armymemo.dtx:232, armymemo.dtx:265, armymemo.dtx:343 | `front.datetime` | `datetime`, `\newdateformat{armydate}{\THEDAY{} \monthname[\THEMONTH] \THEYEAR}`, printed as `\armydate\@date` |
| memo fields | armymemo.dtx:275-282, armymemo.dtx:299-308 | `front.class-native` | `\gdef` stores for department, unit, unitaddress, unitcity, officesymbol, memothru, memofor, subject, enclosures; memothru and enclosures start as `\relax` (optional) |
| first-page letterhead style | armymemo.dtx:383-406 | `hf.fancyhdr` | `\fancypagestyle{plain}`: `\fancyhf{}`, `\lhead` logo, `\chead` three centred lines, `\headrulewidth`=0pt, `\footrulewidth`=0pt |
| letterhead text look | armymemo.dtx:394-401 | `mark.kernel`, `font.size-commands`, `mark.case`, `sp.manual-space` | `sffamily` + `bfseries` environments; department `\footnotesize`, unit lines `\scriptsize`; `\MakeUppercase` on all four fields; `\\` line ends |
| letterhead logo | armymemo.dtx:388-390 | `fig.graphicx` (reduction also uses `sp.manual-space`, `box.minipage`) | `\includegraphics[height=1in]{dodlogo.eps}` in a zero-size overlay node, `[remember picture, overlay]`, `\node[yshift=20pt] at (0,0)`; reduction in Bespoke code |
| continuation-page style | armymemo.dtx:413-424 | `hf.fancyhdr` | `\fancypagestyle{body}`: `\lhead[]` office symbol, line break, "SUBJECT: " subject; `\fancyfoot[C]{\thepage}`; rules 0pt |
| page-style switching | armymemo.dtx:341-342 | `hf.pagestyle-kernel` | `\thispagestyle{plain}`, `\pagestyle{body}` |
| memo header block | armymemo.dtx:340-351 | `front.class-native` (reduces to `sp.manual-space`, `front.datetime`) | office symbol `\hfill` date, `\\~\\~\\`; "MEMORANDUM FOR" or "MEMORANDUM THRU ... FOR"; "SUBJECT:" line |
| numbered paragraphs | armymemo.dtx:323-329 | `num.counters`, `sp.manual-space`, `box.minipage` | counters `ami`, `amii`[ami], `amiii`[amii]; labels `\arabic{ami}. `, `\alph{amii}. `, `(\arabic{amiii}) `; indents 0in, 0.25in, 0.5in by `\hspace`; label in `\makebox[0.25in][l]` |
| signature block | armymemo.dtx:359-376 | `box.minipage`, `sp.manual-space`, `mark.case`, `sp.lengths` | `minipage[t]{\textwidth}`, `\vspace{3\baselineskip}`, `\hfill`, `\parbox[t]{0.5\textwidth}` with `\MakeUppercase` name and rank, title plain; `\parskip`=0pt |
| enclosure list | armymemo.dtx:363-369 | `box.minipage`, `sp.lengths` | `\parbox[t]{0.28\textwidth}`, "Encl:", `hangparas{0.25in}{1}` of the `hanging` package, which sets hang indent 0.25in after 1 line (`\hangindent`, `\hangafter`); only when `\enclosures` is set |
| doc class (manual) | armymemo.dtx:33 | `class.ltxdoc` | no options |
| doc machinery | armymemo.dtx:34-36, armymemo.dtx:38, armymemo.dtx:43, armymemo.dtx:45-59, armymemo.dtx:62, armymemo.dtx:64, armymemo.dtx:66-88, armymemo.dtx:164, armymemo.dtx:224, armymemo.dtx:268-287, armymemo.dtx:427 | `dtx.doc` | `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput`, `\CheckSum{0}`, `\CharacterTable`, `\changes`, `\GetFileInfo`, `\DoNotIndex`, `\DescribeMacro`, `\StopEventually{\PrintIndex}`, `macro` and `macrocode` environments, `\Finale` |
| manual title block | armymemo.dtx:90-95 | `front.maketitle`, `front.thanks`, `mark.kernel` | `\title{... \thanks{...}}` with `\textsf`, `\author`, `\maketitle` |
| manual abstract | armymemo.dtx:97-101 | `abs.kernel` | `abstract` environment |
| manual headings | armymemo.dtx:103, armymemo.dtx:158, armymemo.dtx:226 | `head.kernel` | `\section`, class default look |
| manual usage examples | armymemo.dtx:109-120, armymemo.dtx:127-130, armymemo.dtx:141-153 | `quote.kernel`, `code.verbatim`, `sp.manual-space` | `quote` environment, `\|...\|` short verbatim from `ltxdoc` (not read), `\\` line ends |
| manual spacing | armymemo.dtx:159, armymemo.dtx:200 | `sp.lengths`, `sp.manual-space` | `\setlength{\parindent}{0pt}`, `\vspace{\baselineskip}` |

No lists, tables, floats, theorems, bibliography, footnotes, maths, code listings or cross-references are defined or used besides the rows above.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| the class as a whole | armymemo.dtx:231-424 | not bespoke: published on CTAN | one way `class.armymemo` (W1); the rows below are an independent check that it also reduces |
| field macros (`\gdef` stores) and `\ClassError` defaults | armymemo.dtx:275-282, armymemo.dtx:299-308 | yes | the emitter writes the strings into the header lines directly; the defaults only raise an error when a required field is missing and print nothing |
| `\ifdefvoid` conditionals for THRU and enclosures | armymemo.dtx:344-349, armymemo.dtx:363-369 | yes | the document model knows at emit time whether a THRU line or enclosures exist: write the "THRU ... FOR" lines or "FOR" line, and the `Encl:` parbox only when present; no layout is computed. `\ifdefvoid` belongs to etoolbox, which the class never loads by name (Grep: only armymemo.dtx:74, 344, 363); it arrives through a dependency that was not read, and the reduction needs no etoolbox |
| counters `ami` `amii` `amiii` and `\@amitem`, `\ami` `\amii` `\amiii` | armymemo.dtx:323-329 | yes | `\newcounter{ami}`, `\newcounter{amii}[ami]`, `\newcounter{amiii}[amii]` and per item `\refstepcounter{c}\hspace{0in\|0.25in\|0.5in}\makebox[0.25in][l]{label}`; only kernel counters, `\arabic`, `\alph`, a space and a box, no conditional or arithmetic (considered: `enumitem`; not claimed, because the items are flat paragraphs whose continuation lines return to the margin, not list items) |
| `\makeheader` | armymemo.dtx:340-351 | yes | `\thispagestyle{plain}\pagestyle{body}` then fixed text lines with `\hfill`, `\\~` and `\armydate\@date` |
| `\makesigblock` | armymemo.dtx:359-376 | yes | the `minipage` and two `\parbox` calls in the table row above; `\setlength{\parskip}{0pt}` at armymemo.dtx:360 is not grouped, so it stays in force to the end of the document, which is harmless at the end of a memo |
| TikZ overlay node holding the logo | armymemo.dtx:388-390 | yes | not drawn artwork: the node's only content is one included image and the picture has zero size. Equivalent placement, from the arguments (not compiled): `\smash{\makebox[0pt]{\raisebox{-16.1pt}{\includegraphics[height=1in]{dodlogo.eps}}}}` inside `\lhead`, which centres the image on the left text edge with its centre 20pt above the baseline (36.1pt half-height minus 20pt gives the 16.1pt drop). Ways: `fig.graphicx`, `sp.manual-space`, `box.minipage`. Considered `art.tikz`: ruled out because nothing is drawn |
| `\fancypagestyle{plain}` redefinition and `{body}` style | armymemo.dtx:383-424 | yes | declarative `fancyhdr` fields and rule widths, as in the table |
| `armymemo.ins` docstrip driver | armymemo.ins:20-48 | yes | a TeX run that writes armymemo.cls from the dtx `package` guard; not part of any document |

## Content-opaque
- dodlogo.eps (armymemo.dtx:389): the logo is a shipped image, a cairo-made EPS (dodlogo.eps:2) with BoundingBox 70 232 526 688 (dodlogo.eps:7), so a 456 by 456 bp square scaled to 1in high. Under XeLaTeX the EPS is, to my knowledge, converted by xdvipdfmx through Ghostscript; that was not checked here. An emitter without Ghostscript can ship a PDF or PNG made once from the same logo (an asset step, not a build step). Not treated as `EXTERNAL`.
- Arial (armymemo.dtx:247, README.md:6-10) is not shipped; a metric-compatible name can be given as the `\setmainfont` value.
- the class source printed in `macrocode` environments (armymemo.dtx:230-425), the `\CharacterTable` (armymemo.dtx:45-59) and the example memo text (armymemo.dtx:109-153) are content.
- The manual's index and change history need a `makeindex` pass, a TeX Live tool run as BibTeX is; nothing in the memo class needs it.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
