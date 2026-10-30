yes

# 0717-csassignments: csassignments (assignment sheets for computer science courses)

- Unverified: read from the source, not compiled.
- Source: Source/0717-csassignments/ (origin: https://mirrors.ctan.org/macros/latex/contrib/csassignments.zip; licence: MIT)
- Kind: assignment
- Lib: v5
- Engine: pdfLaTeX-compatible
- Look carried by: class (the whole look is in the published class `csassignments`, generated from `csassignments.dtx`; the zip holds no sample document of its own)
- Class origin: ctan
- Main file: none as a plain `.tex` sample. The only `\documentclass` in the zip is the `ltxdoc` driver of the manual, `csassignments.dtx:36-52`. The usage skeleton is `csassignments.dtx:109-126` (other samples: `README.md:21-39`, the same skeleton)
- Read: main yes (driver and skeleton), zip-local classes and styles all (`csassignments.dtx` 687 lines read in full; `csassignments.ins` 49 lines and `README.md` read; `csassignments.pdf` is a binary manual and was not read)

## Verdict
`yes`. The zip is the CTAN release of the class `csassignments` (v1.0.2, 2022-07-28, MIT; ctan.org/pkg/csassignments lists it and says it is in TeX Live and MiKTeX), so the class is published and is one way, `class.csassignments`, which carries the look (the rubric's second ruling). The class itself is `article` plus published packages and `\newcommand` aliases, so its parts also map to lib ways. Nothing is drawn (`tikz` is loaded and never used), and nothing needs a tool outside TeX (the grading table needs two TeX runs through the `.aux` file). The grading-table bookkeeping (`csassignments.dtx:250-285`, `360-368`) would be irreducible hand-rolled counter code if the class were zip-local; it is not, it is the internals of a published class, so it is not a blocker.

## Blockers
none

## Class setting
- Class: `class.csassignments` options: none of its own; every option is forwarded to `article` (`csassignments.dtx:134-135`); the class loads `article` with `a4paper,11pt` (`csassignments.dtx:136`)
- Class-native vocabulary used (usage skeleton `csassignments.dtx:109-126`): preamble `\course{}` (`:462`), `\sheet{}` (`:464`), `\group{}` (`:465`), `\due{}` (`:466`), `\member[id]{name}` (`:467-472`), `\PrefixId` `\PrefixAuthor` `\PrefixDate` (`:487-489`); switches `\exerciseRules` `\subexerciseRules` (`:404-407`) and `\nopoints` (`:420-424`); body `\maketitle` (`:497`), `\gradingtable` (`:272`), `\exercise[points]{title}` and `\exercise*` (`:325`, `:344`), `\subexercise[title]` (`:380`); counters `exercisenumber`, `subexercisenumber`, `totalpoints` (`:250-252`); math helpers and `\QED` (`:568-674`); theorem style `it` (`:678-679`)

## Component map
Paths are relative to `Source/0717-csassignments/`; every row below is inside `csassignments.dtx` unless it says `README.md`. Rows 1 to 30 are the class (what `\documentclass{csassignments}` brings); rows 31 to 36 are the manual's own driver and text.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| 1 class | csassignments.dtx:33,134-136 | `class.csassignments` | `\ProvidesClass` v1.0.2 2022/07/28; options forwarded to `article` by `\DeclareOption*` + `\PassOptionsToClass`, then `\ProcessOptions\relax` |
| 2 base class | csassignments.dtx:136 | `class.article` | loaded by the class, not by the user: `\LoadClass[a4paper,11pt]{article}` |
| 3 paper and size | csassignments.dtx:136 | `page.class-options` | a4paper, 11pt |
| 4 page geometry | csassignments.dtx:180-181 | `page.geometry` | left=2.5cm, right=2.5cm, top=2cm, bottom=2cm, includeheadfoot |
| 5 paragraph shape | csassignments.dtx:138-139 | `sp.lengths` | `\parindent`=0pt, `\parskip`=0.6em |
| 6 micro-typography | csassignments.dtx:193,198 | `sp.microtype` | defaults; the package is loaded twice |
| 7 text font | csassignments.dtx:208 | `font.palatino` | `tgpagella`, no options |
| 8 input encoding | csassignments.dtx:182 | `font.fontenc-t1` | `inputenc` option utf8 only; the class has no `fontenc` line |
| 9 maths symbol fonts | csassignments.dtx:194,201 | `math.amssymb` | `stmaryrd` and `amssymb` loaded; no `stmaryrd` symbol is called in the class (considered `font.icons`: it names pictogram and currency glyphs, these are maths operators) |
| 10 language and keyword strings | csassignments.dtx:183,217-243 | `lang.babel`, `lang.translator` | `babel` [english]; `translations`: `\DeclareLanguage{english}` `{german}`, `\select@language{english}`, `\ProvideTranslation` + `\ProvideTranslationFallback` for keys prefixAuthor ("Handed in by"), prefixDate ("on"), exercise, exerciseAbbrev ("Ex."), subexercise, points, sheet, studentId |
| 11 quotation marks | csassignments.dtx:191 | `lang.csquotes` | loaded, no quote command is used in the class |
| 12 PDF links and metadata | csassignments.dtx:196,542-546 | `meta.hyperref` | `hidelinks`, `unicode`; `\hypersetup{pdftitle, pdfauthor, pdfsubject}` in `\AtBeginDocument`, filled from `\@sheet`, `\pdfmembers`, `\@course` |
| 13 running head | csassignments.dtx:192,514,516-531 | `hf.fancyhdr` | `\pagestyle{fancy}` issued inside `\maketitle`; `\headrulewidth`=1pt; `\headheight`=4\baselineskip; `\rhead`: tabular{r} of bold course, sheet, `\small` due date; `\lhead`: `\small` tabular{l} of the members; no foot set |
| 14 first-page style | csassignments.dtx:498 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` at the start of `\maketitle` |
| 15 title block | csassignments.dtx:442-451,496-515 | `front.class-native` | defaults `\@course`=Assignment; `\and` redefined as `\\` (496); `\maketitle` redefined: `\Huge\bfseries` course, `\LARGE` sheet line, `\footnotesize\bfseries` prefix then members, same for the due date, `\vskip\baselineskip` |
| 16 title fonts and member list | csassignments.dtx:499-512 | `font.size-commands`, `mark.kernel`, `tbl.tabular` | `\Huge` `\LARGE` `\large` `\footnotesize` with `\bfseries`; members in `tabular[t]{@{}l}` |
| 17 exercise headings | csassignments.dtx:319-359,380-391 | `head.class-native` | `\exercise[points]{title}`: `\penalty150`, `\vspace{1.5\baselineskip}`, `\Large\bfseries` "Exercise n" (counter `exercisenumber`), title as bold "(title)" after `\quad`, points as `\large\bfseries` "/N Points"; `\exercise*` skips the grading table; `\subexercise[title]`: `\vspace{0.5\baselineskip}`, bold "Subexercise (a)" (counter `subexercisenumber`, `\alph`) |
| 18 heading rules and spacing | csassignments.dtx:395-396,404-409 | `sp.rule`, `sp.manual-space` | `\Vhrulefill` = `\leaders\hrule height 0.7ex depth \dimexpr0.4pt-0.7ex\hfill`, preceded by `\hspace{1em}` (exercise) or `\hspace{0em}` (subexercise); off until `\exerciseRules` / `\subexerciseRules` |
| 19 grading table | csassignments.dtx:272-285,360-368 | `class.csassignments` (native `\gradingtable`), `tbl.tabular` | `{\Large\bfseries Grading Table}`, `table[h!]`, `\arraystretch` 2, `tabular{<saved head> c}`, `\hline`, a sigma column and "/ total"; the cells are collected per exercise and read back from the `.aux` on the second run; a "Compile again" warning appears before that |
| 20 maths packages | csassignments.dtx:199-202 | `math.amsmath`, `math.eqnumber`, `math.mathtools`, `math.amssymb` | `amsmath` option `fleqn`; `mathtools`; `amssymb` |
| 21 maths macros | csassignments.dtx:568-574,588,597,608-610,621-622,632-634,648,655,663 | `math.amssymb`, `math.mathtools`, `math.amsmath` | `\newcommand` aliases: `\N \Z \R \Q \C` = `\mathbf`, `\F \primefield` = `\mathbb`, `\modring`, `\derivative`, `\matadd \matmul \matswap` = `\xmapsto` with `\mathrm`, `\ceil \floor \abs` = `\left..\right`, `\rfrac`, `\mod`, `\rel` = `\mathrel`; `\forall` and `\exists` redefined with 2pt `\hskip` each side |
| 22 proof end mark | csassignments.dtx:674 | `sp.manual-space`, `math.amssymb` | `\QED` = `\hfill\(\square\)` |
| 23 theorem style | csassignments.dtx:200,678-679 | `thm.amsthm` | `\newtheoremstyle{it}{3pt}{3pt}{}{}{\itshape}{:}{.5em}{}` then `\theoremstyle{it}`; no `\newtheorem` is declared |
| 24 lists | csassignments.dtx:185 | `list.enumitem` | loaded, no `\setlist` in the class |
| 25 sectioning package | csassignments.dtx:184 | `head.titlesec` | loaded, no `\titleformat` in the class |
| 26 contents lists | csassignments.dtx:187 | `toc.tocloft` | loaded, no setting in the class |
| 27 floats, images, PDF pages | csassignments.dtx:186,188,195 | `fig.graphicx`, `fig.float`, `pg.include-pdf` | `graphicx`, `float`, `pdfpages` loaded for the user |
| 28 columns, indented blocks | csassignments.dtx:204,207 | `cols.multicol`, `page.adjustwidth` | `multicol`, `changepage` loaded for the user |
| 29 programming helpers | csassignments.dtx:189,203,205,206,209 | none needed | `ifthen`, `totcount`, `etoolbox`, `environ`, `suffix`: load-only helpers for the class's own macros, no printed effect |
| 30 TikZ | csassignments.dtx:197,210 | none needed | `tikz` with libraries arrows, calc is loaded; Grep finds no `tikzpicture`, `\draw`, `\node` or `\tikz` in the file, so no artwork |
| 31 manual class | csassignments.dtx:37 | `class.ltxdoc` | option a4paper |
| 32 manual doc commands | csassignments.dtx:38-40,50,56-58,74-78,86,685 | `dtx.doc` | `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges` `\DocInput`, `\CheckSum`, `\CharacterTable`, `\changes`, `\GetFileInfo`, `\StopEventually{}`, `\Finale`; `macrocode` and `macro` environments (e.g. 133-140, 266-370) |
| 33 manual fonts | csassignments.dtx:41-42,47-48 | `font.fontenc-t1`, `font.helvet`, `font.family-default` | `inputenc` utf8, `fontenc` T1; `helvet`; `\familydefault`=`\sfdefault` |
| 34 manual maths and links | csassignments.dtx:43-46 | `math.mathtools`, `math.amsmath`, `math.amssymb`, `meta.url` | packages loaded in the driver |
| 35 manual title and sections | csassignments.dtx:80-84,88,105 | `front.maketitle`, `toc.kernel`, `head.kernel` | `\title`, `\date{}`, `\author`, `\maketitle`, `\tableofcontents`, `\section` |
| 36 manual lists, code, marks | csassignments.dtx:109-126,147-177 | `list.kernel`, `code.verbatim`, `mark.kernel` | `verbatim` usage skeleton; `description` list of the 29 required packages; `\texttt` `\textbf` `\textsc` |

## Bespoke code
All of it sits in `csassignments.dtx`, a published CTAN class, so none of it is zip-local; the table says what each item reduces to anyway, so the file can be re-read under a rule that does not count published class internals.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| Maths `\newcommand` aliases (`\N \Z \R \Q \C \F \primefield \modring \derivative \matadd \matmul \matswap \ceil \floor \abs \rfrac \rel \QED`) | csassignments.dtx:568-574,588,597,608-610,632-634,648,663,674 | yes | aliases over `\mathbf`, `\mathbb` (`math.amssymb`), `\xmapsto` (`math.mathtools`), `\left\lceil` and friends (`math.amsmath`) |
| `\mod`, `\forall`, `\exists` redefinitions | csassignments.dtx:621-622,655 | yes | spacing aliases; note that `\oforall` and `\oexists` are never defined in the file (Grep finds them only at 621-622), so `\forall` and `\exists` look unusable unless another loaded package defines them (not checked) |
| Title fields and `\maketitle` | csassignments.dtx:442-515 | yes | `front.class-native` vocabulary; over kernel font switches, `tabular[t]`, `\thispagestyle`, `\pagestyle{fancy}` |
| `\rhead` and `\lhead` fields | csassignments.dtx:516-531 | yes | `hf.fancyhdr` calls |
| `\exercise`, `\exercise*`, `\subexercise`, `\nopoints` heading macros | csassignments.dtx:319-359,380-391,420-434 | yes as typesetting | `head.class-native`; a `\Large\bfseries` line, `\vspace`, `\penalty150`, `\quad`, rule leaders, counters stepped and printed with `\arabic` and `\alph` |
| `\Vhrulefill` | csassignments.dtx:395-396 | yes | `sp.rule`: a bare `\leaders\hrule` |
| Grading-table bookkeeping: `\newtotcounter`, `\edef`/`\xappto` accumulators, `\write` to `\@mainaux`, `\PTableASaved` read back | csassignments.dtx:250-285,360-368 | no, if it were zip-local (hand-rolled counters and aux read-back that decide what is printed) | not counted: it is the internals of the published class; the emitter writes `\gradingtable` and `\exercise[points]{title}` and the class does the rest (`BESPOKE/class` only under a rule that counts published class internals) |
| Translation tables | csassignments.dtx:217-243 | yes | `lang.translator` declarations |
| Theorem style `it` | csassignments.dtx:678-679 | yes | `thm.amsthm` `\newtheoremstyle` + `\theoremstyle` |
| PDF metadata hook | csassignments.dtx:542-546 | yes | `meta.hyperref` `\hypersetup` |

Other points seen, none a blocker: the manual names the switch `\noPoints` (csassignments.dtx:414,417) while the code defines `\nopoints` (csassignments.dtx:420); the German keys are declared for `ngerman` in some places and `german` in others (csassignments.dtx:218,220,226). No text addressed to an AI was found in any file.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
