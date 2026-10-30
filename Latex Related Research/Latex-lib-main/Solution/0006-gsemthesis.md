yes

# 0006-gsemthesis: gsemthesis (Geneva School of Economics and Management PhD thesis class)

- Unverified: read from the source, not compiled.
- Source: Source/0006-gsemthesis/ (origin: https://mirrors.ctan.org/macros/latex/contrib/gsemthesis.zip; licence: lppl1.3)
- Kind: thesis
- Lib: v1
- Engine: pdfLaTeX-compatible (inputenc utf8, lmodern, babel, biblatex; no fontspec, no Lua; the bibliography needs the biber run (dtx:523, loaded unless `custombib`); not ruled EXTERNAL/package because the lib lists `bib.biblatex-biber` as an ordinary way and only `code.minted` as the external one, and a missing biber run leaves citations unresolved rather than stopping the compile, which is reasoned from how biblatex works, not tested)
- Look carried by: class (the zip is the class's own source: the thesis look is defined by gsemthesis.cls, generated from gsemthesis.dtx:338-965; the sample adds content only)
- Class origin: ctan (the zip is the CTAN release; README:14 says it is also in TeX Live and MiKTeX; no .cls is shipped, gsemthesis.ins:34 generates it from the .dtx)
- Main file: gsemthesis.dtx (documentation driver at 26-49; the template sample is the minimal working example in comments, 270-325) (other samples: none; README:25-26 mentions an example folder that is not in this zip)
- Read: main yes, zip-local classes and styles all (no .tex/.cls/.sty exists; the whole .dtx, 968 lines, and the .ins and README were read; gsemthesis.pdf is the generated manual and was not opened)

## Verdict
The zip holds no standalone .tex sample, only the class source `gsemthesis.dtx`. The class is a published CTAN class (already `class.gsemthesis` in the lib), so the template is one class way plus its own commands, and the minimal working example (dtx:270-325) uses nothing but that vocabulary and kernel book commands. Everything the class does internally also reduces to lib ways (`book`, `geometry`, `fancyhdr`, `biblatex`, a hand-laid cover of rules and vertical space), there is no drawing, and nothing needs a tool outside the normal TeX toolchain. Verdict `yes`, with the look carried by the class, so this is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.gsemthesis` options: `fr` (French labels, babel `francais`, T1), `draft` (hides committee, thesis number, front-matter pages, prints "Draft"), `custombib` (class loads no biblatex), `b5paper` (dtx:369-371; processed at 374, after `\LoadClass{book}` at 338, so `\PassOptionsToClass` reads as too late to reach `book`; unverified, not compiled). The sample uses none. The class loads `book` with `a4paper,12pt,twoside` (dtx:338).
- Class-native vocabulary used: `\title` `\date` (kernel), `\authorFirstname` `\authorLastname` `\thesisField` `\thesisCommitteeA` to `\thesisCommitteeF` (`{title}{firstname}{lastname}{role}`) `\thesisNumber` (dtx:164-172, 618-730); `\acknowledgements` `\abstractEN` `\abstractFR` `\dedication` (dtx:179-183, 823-853); `\printcoverpage` (734-817); `\printfrontmatter` (855-923); `\startintroduction` `\startconclusion` (929-949); `itemize*` (954-964). Inherited from `book` and loaded packages: `\chapter` `\label` `\listoftables` `\listoffigures` `\newpage` (dtx:307-323), biblatex `\addbibresource` `\printbibliography` (292-293, 323).

## Component map
Rows marked (sample) are what the minimal working example uses; (class) are what the class source itself realises, checked so that no class internal needs a way outside the lib; (driver) is the manual's own `.dtx` driver.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (sample) | dtx:270 | `class.gsemthesis` | no options in the example; options fr, draft, custombib, b5paper available (338-374) |
| cover page (sample) | dtx:272-282, 297 | `front.class-native` | `\title` `\date` `\authorFirstname` `\authorLastname` `\thesisField` `\thesisCommitteeA-D{Prof.}{first}{last}{role}` `\thesisNumber{480}`, printed by `\printcoverpage` |
| acknowledgements, abstracts, dedication (sample) | dtx:284-290, 299 | `front.class-native`, `abs.class-native`, `front.dedication` | `\acknowledgements` `\abstractEN` `\abstractFR` `\dedication` set in the preamble, printed by `\printfrontmatter` |
| table of contents (sample) | dtx:299 (inside `\printfrontmatter`, 907), 318-319 | `toc.kernel` | `\tableofcontents` (in front matter), `\listoftables`, `\listoffigures` in the back matter |
| headings and chapters (sample) | dtx:302, 307, 313 | `head.kernel`, `front.class-native`, `xref.kernel` | `\startintroduction` and `\startconclusion` (unnumbered chapters listed in the toc), `\chapter{...}`, `\label{ch:chapterone}` |
| bibliography (sample) | dtx:292-293, 323 | `bib.biblatex-biber` | `\addbibresource{...}` x2, `\printbibliography` after `\newpage` |
| page break (sample) | dtx:322 | `pg.break` | `\newpage` |
| base class (class) | dtx:338 | `class.book`, `page.class-options` | `a4paper,12pt,twoside` |
| page geometry (class) | dtx:378 | `page.geometry` | top=2.5cm, bottom=2.5cm, left=2.5cm, right=2.5cm |
| encoding and fonts (class) | dtx:342, 346, 504-505 | `font.fontenc-t1`, `font.lmodern` | `inputenc[utf8]`, `lmodern`; `fontenc[T1]` only when `fr` |
| language (class) | dtx:503-508, 512 | `lang.babel`, `lang.csquotes` | babel `francais` (fr) or `english`; `csquotes` |
| title spacing (class) | dtx:382, 746-748 | `sp.setspace` | `spacing` environment, factor 0.8, around the title |
| colour (class) | dtx:388-391 | `color.xcolor` | erblue 126199, erorange FF7F00, gsemblue 465F7F (HTML model) |
| graphics (class) | dtx:396-398 | `fig.graphicx`, `fig.float`, `fig.subcaption` | `graphicx[final]`, `float`, `subfigure` |
| links (class) | dtx:403-418, 422-423 | `meta.hyperref`, `meta.url` | colorlinks=true, linkcolor=black, filecolor/citecolor/urlcolor=erblue, final; `\urlstyle{sf}` |
| maths (class) | dtx:428 | `math.amsmath`, `math.amssymb` | `amssymb`, `amsmath`, `amsfonts` |
| running heads (class) | dtx:433-490 | `hf.fancyhdr`, `hf.pagestyle-kernel` | `\pagestyle{fancy}`; LE and RO `\thepage`, RE `\nouppercase{\leftmark}`, LO `\nouppercase{\rightmark}`, foot empty; styles `plain` `empty` (no rules), `cover` (0.5pt rules, unused), `unnumberedchapter` (defined, not used) |
| blank pages before chapters (class) | dtx:494-499 | `pg.emptypage`, `pg.break` | `\cleardoublepage` redefined to insert an empty-style blank page on twoside |
| cover date format (class) | dtx:516-517, 811 | `front.datetime` | `\newdateformat{monthyeardate}{\monthname[\THEMONTH] \THEYEAR}`, printed `\monthyeardate\today` (draft prints `\@date`) |
| bibliography setup (class) | dtx:523-567 | `bib.biblatex-biber` | `backend=biber, natbib=true, style=authoryear-comp, sorting=nymdt, maxbibnames=99, mincitenames=1, maxcitenames=2, uniquelist=false`; `\DeclareSortingScheme{nymdt}` (sort by presort, sortkey, name fields, year, month, day, title, volume) |
| cover page layout (class) | dtx:737-817 | `front.titlepage-env`, `sp.rule`, `sp.manual-space`, `font.size-commands`, `mark.kernel`, `sp.setspace`, `sp.ragged` | hand-laid in a `center` block (not the `titlepage` env): `\thispagestyle{empty}`, two `\rule{\linewidth}{0.4pt}`, `\vspace*` 1.2cm/0.4cm/0.8cm/0.2em/1.4cm/0.1cm, `\huge\scshape` title, `\large` author, `\vfill`, `\emph` for "Draft"; no drawing |
| front-matter pages (class) | dtx:858-923 | `front.dedication`, `head.kernel`, `toc.kernel`, `xref.kernel`, `hf.pagestyle-kernel`, `pg.break`, `sp.manual-space`, `sp.ragged`, `mark.kernel` | `\frontmatter`, `\chapter*` + `\addcontentsline{toc}{chapter}` for Acknowledgements, Abstract, Résumé (order swaps with `fr`), `\thispagestyle{plain}`, `\tableofcontents`, `\cleardoublepage`, dedication = `\vspace*{4cm}` + `\em\raggedleft`, `\mainmatter` |
| intro and conclusion starters (class) | dtx:932-949 | `head.kernel`, `toc.kernel`, `xref.kernel`, `hf.fancyhdr` | `\chapter*` + `\addcontentsline{toc}{chapter}` + `\label` + `\markboth{}{Introduction\|Conclusion}` |
| compact list (class) | dtx:958-964 | `list.kernel`, `sp.lengths`, `sp.manual-space` | `itemize*` = `\vspace{-2mm}`, `itemize` with `\itemsep=0pt`, `\parskip=0pt` |
| document class (driver) | dtx:27 | `class.ltxdoc` | documentation driver; `\DocInput{gsemthesis.dtx}` (47) |
| geometry (driver) | dtx:29 | `page.geometry` | top=2.5cm, bottom=2.5cm, left=4.5cm, right=3.5cm |
| colour, links, float (driver) | dtx:28, 30-35 | `font.fontenc-t1`, `color.xcolor`, `meta.hyperref`, `meta.url`, `fig.float` | `inputenc[utf8]`; erblue 126199; colorlinks, linkcolor=black, file/cite/urlcolor=erblue |
| manual vocabulary (driver) | dtx:43-45, 52-80 | `class.ltxdoc` | `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges` `\CheckSum` `\CharacterTable` `\changes` `\GetFileInfo` `\DoNotIndex`, `\DescribeMacro` `\DescribeEnv`, `macro`/`macrocode` |
| manual front and body (driver) | dtx:83-96, 100-265 | `front.maketitle`, `front.thanks`, `abs.kernel`, `toc.kernel`, `head.kernel`, `fn.kernel`, `code.verbatim`, `xref.kernel` | `\title` `\author` `\thanks` `\maketitle`, `abstract`, `\tableofcontents`, `\section`/`\subsection`, `\footnote`, `verbatim`, `\label`/`\ref` |
| compact list (driver) | dtx:36-42 | `list.kernel`, `sp.lengths`, `sp.manual-space` | same `itemize*` as the class |

## Bespoke code
The class is published, so its internals are not zip-local bespoke; items 2 to 9 are reduced anyway to show that none is irreducible. Only item 1 is code of the zip proper (the manual driver, not the thesis look).

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| 1 `itemize*` in the driver | dtx:36-42 (preamble of the manual) | yes | `\newenvironment` wrapper of `list.kernel` with `\vspace{-2mm}`, `\itemsep`, `\parskip` set to 0pt (`sp.lengths`, `sp.manual-space`) |
| 2 `\def\cleardoublepage` | dtx:494-499 (class) | yes | kernel `\cleardoublepage` plus `\thispagestyle{empty}` on the blank page = `pg.emptypage` with an `empty` page style from `hf.fancyhdr`; the stray `\clearpage{\pagestyle{empty}\cleardoublepage}` at 499 reads as a load-time no-op (page counter is 1, odd); not compiled |
| 3 toggles `fr` `draft` `custombib` | dtx:354-365, 503-508, 523-531, 767-811, 860-909 (class) | yes | etoolbox `\newtoggle`/`\iftoggle` only select between fixed strings or skip blocks; they are class options, so an emitter resolves them statically (language labels, draft hiding, whether biblatex is loaded) |
| 4 label macros | dtx:573-609 (class) | yes | `\def` of fixed English or French strings (faculty name, "PhD in", "Members of the thesis committee:", "Thesis No."); text, not logic |
| 5 data slots | dtx:621-730, 826-851 (class) | yes | `\def`/`\newcommand` storing text for the cover and front pages; `\thesisCommitteeA-F` formats `#1~#2~\textsc{#3},~#4` and prints nothing when the last name is empty (`\ifx&#3&`): a presence test on a content slot, resolvable at emit time |
| 6 `\printcoverpage` | dtx:737-817 (class) | yes | hand-laid cover, see the cover row of the map: rules, vertical space, size and small-caps switches; no TikZ, no box algorithm |
| 7 `\printfrontmatter` | dtx:858-923 (class) | yes | `\frontmatter`, `\chapter*`, `\addcontentsline`, `\label`, `\thispagestyle`, `\tableofcontents`, `\cleardoublepage`, `\mainmatter` in a fixed order |
| 8 `\startintroduction` `\startconclusion` | dtx:932-949 (class) | yes | `\chapter*` + `\addcontentsline` + `\label` + `\markboth` |
| 9 `\DeclareSortingScheme{nymdt}` | dtx:532-566 (class) | yes | a published biblatex declaration: ordered field lists with `padside`, `padwidth`, `padchar`; parameters of `bib.biblatex-biber`, no code |

## Content-opaque
none (no figure or table float is defined; the manual has no drawing)

## Lib changes
- New ways proposed: none. `class.gsemthesis` is already in Lib v1; its native vocabulary is recorded under "Class setting".
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
