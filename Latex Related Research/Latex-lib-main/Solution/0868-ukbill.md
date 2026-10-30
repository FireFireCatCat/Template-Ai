yes

# 0868-ukbill: ukbill, a class for typesetting UK parliamentary bills

- Unverified: read from the source, not compiled.
- Source: Source/0868-ukbill/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ukbill.zip; licence: LPPL 1.3c, ukbill.cls:6-8 and README:7-8; ctan.org/pkg/ukbill read: CTAN package, v1.2.1, E. Z. Granet)
- Kind: misc (a UK legislative bill; the manifest hint `exam` is wrong)
- Lib: v6
- Engine: needs LuaLaTeX (class loads `fontspec` at ukbill.cls:365 and carries the magic comment `% !TeX program = lualatex` at ukbill.cls:4; the manifest says xelualatex or lualatex; the documentation also loads `luaquotes`, a LuaTeX package, at ukbill-documentation.tex:4)
- Look carried by: class (the sample `immigration-bill.tex` adds only field strings and content; every look is in ukbill.cls)
- Class origin: ctan
- Main file: immigration-bill.tex (other samples: ukbill-documentation.tex, the manual, class `article`; the manifest's `main` column names the manual, see Verdict)
- Read: main yes, zip-local classes and styles all (ukbill.cls, 659 lines, the only class or style file; the manual embeds a copy of an older ukbill.cls, v1.2.0, as `minted` code text at ukbill-documentation.tex:175-835, read and treated as content)

## Verdict
The zip is the CTAN package `ukbill` (published class, LPPL 1.3c), so the class is one way, `class.ukbill`. The sample `immigration-bill.tex` defines no macro, loads no package and only sets the class's field commands and uses its list, heading and schedule vocabulary (immigration-bill.tex:1-254), so an emitter writes `\documentclass{ukbill}`, the field lines and the body environments. No `ART` (the margin line numbers are `textpos` text blocks, not drawings, ukbill.cls:149-179; the rules are `\rule`), no bespoke code in the sample, no EXTERNAL tool in the class or the sample. The class's internals (expl3 ordinals, counter-driven running heads, textpos line numbers) would be irreducible if the class were zip-local; they are not counted because the class is published on CTAN (rubric: a published class is one way, its vocabulary recorded under it).
Scope call to check: I took the template's own sample as main. The manual `ukbill-documentation.tex` is typeset with `class.article` (not with ukbill) and says the usage example is `immigration-bill.tex` (ukbill-documentation.tex:40). The manual loads `minted` unconditionally (ukbill-documentation.tex:27), which would be `EXTERNAL/package` if the manual were the main sample; the verdict would then be `no`. The class itself loads no `minted`.
Missing assets (not blockers): the libre font Palatine Parliamentary (README:5, not shipped) and Times New Roman (ukbill.cls:376). Without the Palatine font `\extfont` is never defined (it is created inside the true branch of `\IfFontExistsTF`, ukbill.cls:366-376) but is called at ukbill.cls:564 and :598, so the font must be shipped.

## Blockers
none

## Class setting
- Class: `class.ukbill` options: none in the sample (immigration-bill.tex:1); the class declares one option, `private` (ukbill.cls:526-547, `\ProcessOptions\relax` at :549); it loads memoir with `a4paper,12pt` (ukbill.cls:19)
- Class-native vocabulary used: field commands `\drafter` `\billcopyright` `\publishedby` `\billtitle` `\billday` `\billmonth` `\billyear` `\billto` `\humanrights` `\exptitle` `\exptext` `\billnum` `\whereas` (immigration-bill.tex:2-18, defined at ukbill.cls:76-118); print commands `\printdrafter` `\printbilltitle` (immigration-bill.tex:10,13); `\chapter` `\section`; list environments `numstat` `alphstat` `romstat` `nostat` (immigration-bill.tex:25,27,47,150); schedule commands `\startschedule` `\schedule` `\schdpart` (immigration-bill.tex:208-211). Vocabulary the class has and the sample does not use: option `private` with `\whereas` recitals, `twoalphstat`, `schumstat`, `statquote`, `instatquote`, `\stat`, `\stathead`, `\intl`, `\addordinal` (ukbill.cls:38,389,420,434,464,475,479,496).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | immigration-bill.tex:1; ukbill.cls:19 | `class.ukbill` | no options in the sample; inside the class memoir `a4paper,12pt` |
| page geometry, paper | ukbill.cls:19,212 | `class.ukbill` | carried by the class: `geometry` margin=3.25cm, headheight=100pt |
| front-matter fields | immigration-bill.tex:2-20 | `front.class-native` | 13 field commands: drafter, billcopyright, publishedby, billtitle, billday=5, billmonth, billyear=2024, billto (long title), humanrights (statement with `\printdrafter`, `\printbilltitle`, `\vspace{1ex}`, `\\`), exptitle, exptext, billnum=00/01, whereas (a `numstat` list) |
| cover page, explanatory notes, ECHR statement, bill opening | ukbill.cls:497-501,557-608 | `front.class-native` | `\AtBeginDocument` prints the title block (`\Huge\textbf` title and two `\rule` lines), the exptitle and exptext, the ECHR heading and humanrights, then the contents, then "A BILL TO" with the long title and the enacting formula; page style `front`, roman then arabic numbering (ukbill.cls:560-561,582-583) |
| back page | ukbill.cls:611-660 | `front.class-native` | `\AtEndDocument`: title block, "Presented by" drafter, "Ordered ... to be Printed" date with ordinal day (`\addordinal`), copyright, "Published By" in small caps; values come from the fields |
| enacting formula | ukbill.cls:518-519,526-547 | `front.class-native` | drop capital `\intl{B}{e it enacted}` through `lettrine`, `DefaultLines`=2 (ukbill.cls:487-488,496); option `private` swaps in the Whereas/May recital form |
| contents | ukbill.cls:262-290,302,575-578 | `front.class-native` | `\tableofcontents` in `KeepFromToc`; `\contentsname`=CONTENTS; memoir cft commands: page numbers off for part, chapter, section, subsection, subsubsection; indents 1.75cm and 10em; "Schedule" and "Part" number prefixes; `\settocdepth{subsubsection}` |
| running heads, feet, line numbers | ukbill.cls:149-179,182-232,244-257 | `hf.class-native` | memoir page styles `bill`, `billfirst`, `front`, `sched` (`\makepagestyle`, `\makeevenhead` `\makeoddhead`, `\makeheadrule` 1pt); head carries the bill title, schedule and part names; margin line numbers 5 to 35 are `textpos` blocks (`\TPGrid[15mm,1mm]{8}{9}`); foot of `front` shows `\printbillnum` |
| chapter headings (bill parts) | immigration-bill.tex:22,110,157; ukbill.cls:304-309,320-341 | `head.class-native` | `\chapter` redefined: centred italic, no number printed; skips 12pt before and after |
| section headings | immigration-bill.tex:23,33,43,...; ukbill.cls:346-347,358 | `head.class-native` | `\thesection` arabic with `\counterwithout{section}{chapter}` (ukbill.cls:144), `\setsecnumformat` 5ex, `\setsecheadstyle{\centering\bfseries}`, `\setbeforesecskip{-1em}` `\setaftersecskip{-1em}` |
| schedules and parts | immigration-bill.tex:208-211; ukbill.cls:24-33,352-356,502-512 | `head.class-native` | `\startschedule` resets `part`, sets `schedon`, prints centred SCHEDULES and a toc rule; `\schedule` = `\subsection` and `\schdpart` = `\subsubsection`, both `titlesec` `\titleformat ... [display]` centred small caps with "SCHEDULE n" and "Part n" |
| statutory lists | immigration-bill.tex:25,27,47,150; ukbill.cls:389-419,448-463 | `class.ukbill` | class-native list environments built on `enumitem` and `\item[]`: `numstat` label=(\arabic*) leftmargin=4em rightmargin=1.5em labelsep=3ex; `alphstat` label=({\alph*}) leftmargin=7.5ex; `romstat` label=(\roman*); `nostat` label empty, leftmargin=4em |
| fonts | ukbill.cls:365-376 | `class.ukbill` | carried by the class: `fontspec` `\setmainfont` PalatineP-Regular with Bold, Italic, BoldItalic files, Scale=.98, small-caps LetterSpace=10; `\newfontface\extfont` Times New Roman |
| language, spacing, hyphenation | ukbill.cls:127,377,557-559,331,486 | `class.ukbill` | carried by the class: `babel` english, `hyphenat` option none, `\OnehalfSpacing` (`setspace`), `\emergencystretch 3em`, `\sloppy`, `\parskip` 0pt, `\parindent` 0pt |
| copyright icon | immigration-bill.tex:3; ukbill.cls:181 | `font.icons` | package `ccicons`, `\ccbysa` |
| emphasis | immigration-bill.tex:88,171 | `mark.kernel` | `\emph{b}`, `\textit{b}` in cross-references |
| manual spacing in field text | immigration-bill.tex:11,13 | `sp.manual-space` | `\vspace{1ex}`, `\\` |
| paragraph without indent | immigration-bill.tex:231 | `sp.lengths` | `\noindent`, a paragraph-shape kernel command of the family of `\parindent` (borderline; the class sets `\parindent` 0pt anyway) |
| doc: class | ukbill-documentation.tex:1 | `class.article` | no options |
| doc: fonts | ukbill-documentation.tex:15-20,24 | `font.fontspec` | `\setromanfont` Palatine Parliamentary with fallback TeX Gyre PagellaX via `\IfFontExistsTF`, RawFeature +onum,+pnum; `\setmonofont[Scale=.9]{Source Code Pro}`; `\newfontface\boxy{DejaVu Sans}` |
| doc: language | ukbill-documentation.tex:10 | `lang.babel` | `babel` option british |
| doc: quotation marks | ukbill-documentation.tex:4 | `lang.csquotes` | package `luaquotes` (ctan.org/pkg/luaquotes read: v1.4.0, LPPL 1.3c, TeX Live; quotation marks by language; the page names no engine, its CTAN path is `macros/luatex`, so LuaLaTeX); a quotation-mark package is the parameter |
| doc: dates | ukbill-documentation.tex:11-12,28 | `front.datetime` | `datetime2` option useregional, `\DTMlangsetup[en-GB]{ord=omit}`, `\today` |
| doc: colour | ukbill-documentation.tex:3,6-7,13,43 | `color.xcolor` | `\definecolor` darkspringgreen and dsg (rgb 0.09 0.45 0.27), LightGray (gray 0.9); `\color{darkspringgreen}` |
| doc: links | ukbill-documentation.tex:8,29,38 | `meta.hyperref` | option `hidelinks`; `\href`, `\url` |
| doc: logo package | ukbill-documentation.tex:9 | `font.icons` | `hologo` loaded, no `\hologo` call |
| doc: title block | ukbill-documentation.tex:28-34 | `front.maketitle` | `\title` `\author` `\date{\today ...}` `\maketitle` |
| doc: author note | ukbill-documentation.tex:29 | `front.thanks` | `\thanks{e-mail: ...}` |
| doc: contents | ukbill-documentation.tex:35 | `toc.kernel` | `\tableofcontents` |
| doc: headings | ukbill-documentation.tex:37,42 | `head.kernel` | `\section`, `\subsection` (version-history titles use `\normalfont\texttt`, ukbill-documentation.tex:147) |
| doc: footnote | ukbill-documentation.tex:38 | `fn.kernel` | `\footnote{...\url{...}}` |
| doc: page break | ukbill-documentation.tex:36,162 | `pg.break` | `\clearpage` |
| doc: table | ukbill-documentation.tex:46-60 | `tbl.tabular` | `tabular{lp{2.5in}}` inside `center` |
| doc: long table package | ukbill-documentation.tex:5 | `tbl.longtable` | `longtable` loaded, no `longtable` environment in the manual |
| doc: inline code | ukbill-documentation.tex:2,43 | `code.verbatim` | `verbatim` package, `\verb|...|` |
| doc: code listings | ukbill-documentation.tex:27,69-83,164-174 | `code.minted` | `minted` env, language latex; keys frame=lines framesep=2mm baselinestretch=1.2 bgcolor=LightGray fontsize=\footnotesize breaklines firstnumber=last (linenos at :170); EXTERNAL (pygments) and outside the verdict scope, see Verdict |

## Bespoke code
The sample defines nothing: no `\newcommand`, `\def`, `\renewcommand`, `\newenvironment`, `\let`, counter or `\usepackage` occurs in immigration-bill.tex (a search for them found no match). Everything below is inside `ukbill.cls`, a published CTAN class, so it is not counted (rubric: a published class is one way). The "if zip-local" column is kept so the result can be re-read under another definition.
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| field setters and printers with warning defaults | ukbill.cls:75-121 | yes | string slots, `front.class-native` fields |
| expl3 ordinal suffix `\addordinal`, `\ORDINAL` | ukbill.cls:36-67 | if zip-local: yes, `mark.nth` | `nth` with `super`; italic suffix would need the package's script hook (not read) |
| counter-driven running heads (`\ifnum\value{schedon}=1`, `part`, `subsubsection` tests) and stored titles `\currentsubsection` `\currentsubsubsection` | ukbill.cls:220-231,245-256,506-512 | if zip-local: no (hand-rolled counters and conditionals decide what is printed) | none; class-internal, so not a blocker |
| `\part` and `\chapter` rewritten with `\stepcounter`, `\markright`, `\addcontentsline` | ukbill.cls:295-309,359-364 | if zip-local: no (replaces memoir's heading machinery) | none; class-internal |
| textpos line-number blocks, fixed positions | ukbill.cls:149-179 | if zip-local: yes | `pg.textpos` in `hf.memoir-pagestyle` head fields |
| list environments, schedule titles | ukbill.cls:389-471,352-356 | if zip-local: yes | `list.enumitem` wrappers and `head.titlesec` `\titleformat`, parameters as in the map |
| cover and back page in `\AtBeginDocument` / `\AtEndDocument` | ukbill.cls:557-660 | if zip-local: yes | fields printed with `center`, `\rule`, small caps and `\tableofcontents` |
| defects, none reached by the sample | ukbill.cls:361 (`\normalsidze`), :396 (`\setlength{\itemsep}{i}`), :153-161 (`\Leftblock` unused), :295 overridden by :359 | n/a | dead code |
| doc: `\newcommand{\primeback}{}`, `\thebox` | ukbill-documentation.tex:22,25 | yes | an empty alias and an unused font-face alias in the manual |

## Content-opaque
none (the bill text is content; the manual's `minted` bodies are code text)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
