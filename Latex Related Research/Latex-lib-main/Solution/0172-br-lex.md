yes

# 0172-br-lex: br-lex (class for Brazilian legal texts, on mwbk)

- Unverified: read from the source, not compiled.
- Source: Source/0172-br-lex/ (origin: https://mirrors.ctan.org/macros/latex/contrib/br-lex.zip; licence: lppl1.3)
- Kind: misc (statute text: Lei Complementar 95/1998 set with the class's article, paragraph and inciso commands)
- Lib: v3
- Engine: needs XeLaTeX (the sample's `\setmainfont{Heuristica}` at leis-exemplo.tex:18; the class loads `fontspec` and `polyglossia` only under `\ifxetex`, br-lex.cls:51-54, so under LuaLaTeX `\setmainfont` is undefined; the class alone is pdfLaTeX-compatible through `inputenc`+`babel`, br-lex.cls:56-57)
- Look carried by: class (br-lex.cls sets every look; the sample adds only `\setmainfont`, `hyperref` and option names, leis-exemplo.tex:17-21)
- Class origin: ctan (ctan.org/pkg/br-lex: "Br-lex, a class for typesetting Brazilian legal texts", version 2017-08-01, LPPL 1.3, also in TeX Live and MiKTeX; the zip is the CTAN package itself; it builds on `mwbk`, which is not in the zip)
- Main file: leis-exemplo.tex (other samples: none; brlex-doc.pdf is only the compiled manual, its `brlex-doc.tex` named at br-lex.cls:16 is not in the zip)
- Read: main yes, zip-local classes and styles all (br-lex.cls, 198 lines, read in full; the base class `mwbk` of the mwcls bundle is not in the zip and was not read; README.md and the text of brlex-doc.pdf read as documentation)

## Verdict
The look sits in `br-lex.cls`, a class published on CTAN and in TeX Live (W1), so it is one way, `class.br-lex`, over the published base class `class.mwbk` (br-lex.cls:22). An emitter writes `\documentclass[a5paper,capitulo,titlepage=false]{br-lex}`, `\usepackage{hyperref}`, `\setmainfont{Heuristica}` and the class's own body commands; it copies no macro logic. Nothing in the zip is unpublished, so nothing is bespoke under the rubric. This is evidence about the class dimension, not about the component ways. The class's internal code (the `\ifnum` ordinal conditionals and `\hangindent` logic of `\artigo` and its siblings) would be irreducible if the class were read as zip-local; the CTAN read is what makes the answer `yes`, so a re-read under a stricter origin rule should flip it (see Bespoke code).

## Blockers
none

## Class setting
- Class: `class.br-lex` options: `a5paper,capitulo,titlepage=false` (leis-exemplo.tex:17). `capitulo` is br-lex's own option (br-lex.cls:86-103: chapters do not start a new page); `paragrafoespaco` (default, br-lex.cls:120-123, :129) and `paragrafonormal` (br-lex.cls:125-127) are the other two; `a5paper` and `titlepage=false` are not declared by br-lex.cls (`\ProcessOptions\relax`, br-lex.cls:131) and reach `mwbk` through `\LoadClassWithOptions` (br-lex.cls:22); `mwbk`'s handling of `titlepage=false` was not read.
- Base class: `class.mwbk` (mwcls bundle: CTAN, LPPL 1.2, TeX Live; source not read). Its native vocabulary that br-lex.cls calls: `\SetSectionFormatting[wholewidth|breakbefore]{name}{skip before}{format}{skip after}`, `\FormatRigidChapterHeading`, `\ifHeadingNumbered` `\HeadingNumber` `\HeadingText`, `\mw@tocline`, `\@chapapp` (br-lex.cls:31-44, :97-112).
- Class-native vocabulary used by the sample: `\titulo{}` (leis-exemplo.tex:31), `\descricao{}` (:34), `\artigo` (:43), `\paragrafo` (:50), `\inciso` (:54), `\alinea` (:56), `\cortado{}` (:103), plus `\chapter[short]{long}` and `\section[short]{long}` (:61, :110). Defined by the class and unused in the sample: `\paragrafounico` (br-lex.cls:169), `\itens` (:191-195).

## Component map
Each row names the lib way that realises the part inside the class; an emitter reaches all of them with the one `class.br-lex` line plus the sample-level rows. `mwbk` internals are inferred from the commands br-lex.cls calls, since its source is not in the zip.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | leis-exemplo.tex:17 | `class.br-lex` | options `a5paper,capitulo,titlepage=false` |
| base class | br-lex.cls:22 | `class.mwbk` | `\LoadClassWithOptions{mwbk}`; source not read |
| paper size | leis-exemplo.tex:17 | `page.class-options` | `a5paper`; text block and margins are `mwbk` defaults (not read) |
| running heads | brlex-doc.pdf p.1 (text "cabeçalho automático") | `hf.class-native` | `mwbk` automatic running heads; br-lex.cls sets no page style of its own |
| title-page footer cleared | br-lex.cls:69 | `hf.pagestyle-kernel` | `\thispagestyle{plain}` inside `\titulo` |
| paragraph shape | br-lex.cls:121-122, :129 | `sp.lengths` | default option `paragrafoespaco`: `\parskip` 8pt, `\parindent` 0pt; `paragrafonormal` would set `\parskip` 0pt (:126) |
| widow and club control | br-lex.cls:25-27 | `sp.penalties` | `\widowpenalty` 1000, `\clubpenalty` 1000, `\displaywidowpenalty` 1000 |
| text font | leis-exemplo.tex:18, br-lex.cls:52 | `font.fontspec` | `\setmainfont{Heuristica}`; `fontspec` loaded by the class under XeTeX; font not shipped |
| encoding (non-XeTeX branch) | br-lex.cls:56 | `font.fontenc-t1` | `inputenc` option `utf8`; inactive under XeLaTeX |
| language, XeLaTeX branch | br-lex.cls:53-54 | `lang.polyglossia` | `\setmainlanguage{brazil}` |
| language, pdfLaTeX branch | br-lex.cls:57 | `lang.babel` | `babel` option `brazil` |
| size and weight commands | br-lex.cls:33, :67, :100, :151 | `font.size-commands` | `\large` (section), `\huge` (title), `\large`/`\Large` (chapter) |
| bold marks | br-lex.cls:33, :67, :151 | `mark.kernel` | `\textbf` in the section heading, `\bfseries` in `\titulo` and the article label |
| struck-out text | br-lex.cls:23, :63; leis-exemplo.tex:103, :156, :179, :183, :187 | `mark.ulem` | `ulem` option `normalem`; `\cortado{}` = `\sout{}` |
| front block (agency lines) | leis-exemplo.tex:25-29 | `sp.ragged` | kernel `center` environment, three lines |
| law title | br-lex.cls:65-69; leis-exemplo.tex:31-32 | `front.class-native` | `\titulo{}`: `center`, `\centering\bfseries\huge`, `\thispagestyle{plain}` |
| law description | br-lex.cls:71-76; leis-exemplo.tex:34 | `front.class-native` | `\descricao{}`: `\hfill`, `minipage` 0.5\textwidth, `\vspace{\baselineskip}` |
| description box and spacing | br-lex.cls:71-75 | `box.minipage` | `minipage{0.5\textwidth}` |
| manual spacing | br-lex.cls:35, :71, :75 | `sp.manual-space` | `\\[8pt]` in the section heading, `\hfill`, `\vspace{\baselineskip}` |
| chapter heading | br-lex.cls:97-101 (option `capitulo`, runs at :131 after the default at :108-112), leis-exemplo.tex:39, :61 | `head.class-native` | `\SetSectionFormatting[wholewidth]{chapter}{12pt}{\FormatRigidChapterHeading{4\baselineskip}{0pt}{\centering\large\MakeUppercase\@chapapp\space}{\Large\MakeUppercase}}{\baselineskip}`; without `capitulo` the default adds `breakbefore` (:108-112); `\protect\\` is needed in titles because of the uppercasing (leis-exemplo.tex:61, brlex-doc.pdf p.2 footnote) |
| section heading | br-lex.cls:31-37; leis-exemplo.tex:63, :110, :172 | `head.class-native` | `\SetSectionFormatting{section}{12pt}{\centering\large\textbf{Seção <number> \\[8pt] <text>}}{6pt}`; the word "Seção" is literal (:34) and printed only when numbered |
| heading numbers | br-lex.cls:39, :41 | `num.counters` | `\renewcommand{\thesection}{\Roman{section}}`, `\renewcommand{\thechapter}{\Roman{chapter}}` |
| toc line for sections | br-lex.cls:44 | `front.class-native` | `\renewcommand*\l@section` via `\mw@tocline{1}{1.5em}{4em}{Seção~ #1}{#2}`; the sample has no `\tableofcontents` |
| legal numbered units | br-lex.cls:147-195; leis-exemplo.tex:43, :50, :54, :56 | `class.br-lex` | native commands `\artigo`, `\paragrafo`, `\paragrafounico`, `\inciso`, `\alinea`, `\itens`; see the next three rows |
| unit counters | br-lex.cls:147, :159, :172, :185, :191 | `num.counters` | `\newcounter{artigo}`, `{paragrafo}[artigo]`, `{inciso}[paragrafo]`, `{alinea}[inciso]`, `{itens}[alinea]`, `\refstepcounter`, `\setcounter{inciso}{0}` (:156) |
| unit labels | br-lex.cls:151-153, :163-165, :169, :180, :188, :194 | `class.br-lex` | "Art. Nº" with `º` below 10 (`\ifnum\theartigo<10`), "§ Nº", "Parágrafo único.", Roman " --- ", `\alph{alinea})`, `\arabic{itens}.` |
| unit hanging indents | br-lex.cls:163, :165, :169, :176, :178, :188, :194 | `class.br-lex` | `\hangafter=0`; `\hangindent` 2em (paragraph, sole paragraph, inciso under an article), 3.5em (inciso under a paragraph), 5em (alínea), 6.5em (item) |
| labels | leis-exemplo.tex:40, :62 | `xref.kernel` | `\label{chap:...}` |
| page break | leis-exemplo.tex:109 | `pg.break` | `\clearpage` |
| hyphenation hints | leis-exemplo.tex:125 | `sp.hyphenat` | kernel `\-` discretionary hyphens in running text |
| PDF links | leis-exemplo.tex:21 | `meta.hyperref` | `\usepackage{hyperref}` with no options |

Not used by the sample or the class: maths, theorems, floats, tables, captions, code, boxes beyond the one `minipage`, bibliography, index, notes, lists, colour, background, abstract, appendix.

## Bespoke code
Nothing in the zip is unpublished (the class is on CTAN), so nothing counts. The table shows what each item is and how it would read if `br-lex.cls` were taken as zip-local, so a re-read under a stricter origin rule needs no new analysis.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\cortado` | br-lex.cls:63 | yes | alias of `\sout`, `mark.ulem` |
| `\titulo` | br-lex.cls:65-69 | yes | `center`, `\bfseries\huge` (`font.size-commands`, `mark.kernel`), `\thispagestyle{plain}` (`hf.pagestyle-kernel`) |
| `\descricao` | br-lex.cls:71-76 | yes | `\hfill` + `minipage{0.5\textwidth}` + `\vspace{\baselineskip}` (`sp.manual-space`, `box.minipage`) |
| options `paragrafoespaco`, `paragrafonormal`, default `\ExecuteOptions` | br-lex.cls:120-129 | yes | `\setlength{\parskip}{8pt}` and `\setlength{\parindent}{0pt}` (`sp.lengths`) |
| `\ifxetex` branch | br-lex.cls:50-58 | yes | the XeLaTeX path is `fontspec` + `polyglossia` (`font.fontspec`, `lang.polyglossia`); the other path `inputenc` + `babel` (`font.fontenc-t1`, `lang.babel`) |
| section and chapter `\SetSectionFormatting` calls | br-lex.cls:31-37, :97-101, :108-112 | partly | declarative calls of the published `mwbk` API (`head.class-native`); a pdfLaTeX emitter could write `\titleformat`/`\titlespacing` (`head.titlesec`), but `\FormatRigidChapterHeading` has no `titlesec` twin |
| `\l@section` redefinition | br-lex.cls:44 | partly | an `\mw@tocline` call (class-internal); `toc.tocloft` or `toc.titletoc` could stand in |
| `\artigo`, `\paragrafo`, `\inciso` conditionals | br-lex.cls:150-154, :162-166, :175-179 | no (if zip-local) | `\ifnum` tests choose the ordinal sign and the indent that is printed, a hand-rolled conditional; no lib way expresses it |
| `\hangindent`/`\hangafter` paragraph shapes | br-lex.cls:163-194 | no (if zip-local) | TeX paragraph-shape parameters with fixed lengths; the nearest lib line, `sp.lengths`, names `\parindent`-type parameters, not these |
| counter chain `artigo` to `itens` | br-lex.cls:147-195 | yes | `num.counters` (`\newcounter` with a reset parent) |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered and not proposed: `textcase` (loaded at br-lex.cls:60, never called by the class or the sample, whose chapter format uses the kernel `\MakeUppercase`, br-lex.cls:100) and `ifxetex` (engine test only, br-lex.cls:50-51); neither shapes the look.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Class ways for the consolidator: `class.br-lex` (CTAN; commands `\titulo` `\descricao` `\cortado` `\artigo` `\paragrafo` `\paragrafounico` `\inciso` `\alinea` `\itens`; options `capitulo` `paragrafoespaco` `paragrafonormal`) and `class.mwbk` (mwcls bundle; `\SetSectionFormatting`, `\FormatRigidChapterHeading`, `\HeadingNumber`/`\HeadingText`, second optional argument of the sectioning commands).
