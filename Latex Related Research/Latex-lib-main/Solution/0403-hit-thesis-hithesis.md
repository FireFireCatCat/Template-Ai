yes

# 0403-hit-thesis-hithesis: HIT Thesis (hithesis)

- Unverified: read from the source, not compiled.
- Source: Source/0403-hit-thesis-hithesis/ (origin: https://latextemplates.com/downloads/hithesis-hit-thesis.zip; licence: LPPL-1.3a for the class (README.md:69-71); the manifest adds that the upstream README also offers CC-BY-NC-4.0; the zip's own starter text carries no extra restriction, README.md:76-77)
- Kind: thesis
- Lib: v4
- Engine: needs XeLaTeX (the class loads `ctexbook`, which loads `xeCJK`; pdflatex fails at the class: main.tex:10-12, README.md:30-32; build line `xelatex main` x3, README.md:22-24)
- Look carried by: class (the zip holds only `main.tex` and `README.md`; main.tex:36 loads the published class `hithesis`, which defines covers, abstract pages, contents, headings, page numbering and fonts; the sample adds class options, the `\hitsetup` field values, and plain chapters, one table, one equation)
- Class origin: tex-distribution-unbundled (`hithesis` is on CTAN, "Harbin Institute of Technology Thesis Template", LPPL 1.3a, version 3.2a, "included in TeX Live" and MiKTeX; read once at https://ctan.org/pkg/hithesis; the class is deliberately NOT in the zip: main.tex:3-5, README.md:12-18)
- Main file: main.tex (other samples: none; the zip's other file is README.md)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is a 151-line sample and a README. It defines no macro, environment, counter, package or class of its own: a grep of the non-comment lines of `main.tex` for `\newcommand`, `\renewcommand`, `\def`, `\let`, `\usepackage`, `\RequirePackage`, `\newenvironment`, `\newcounter`, `\setlength`, `\input`, `\include`, `\bibliography` returns nothing. Everything that decides the look sits inside the published class `hithesis`, which is one way, `class.hithesis`; its source was not available, so what it loads and sets internally (geometry, headers, heading formats, fonts, hyperref, caption, bibliography) is recorded as inherited and not analysed. The answer is `yes` because an emitter can write `\documentclass[type=master,fontset=fandol,newtxmath=false]{hithesis}`, one `\hitsetup{...}` of string keys, the class's own abstract, conclusions and acknowledgements environments, and kernel sectioning, table and equation code, with published ways only. Caveat for the reviewer: the class's unconditional package list was not read, so "no EXTERNAL package" rests on the README build line (README.md:22-28 names only `xelatex` and an optional `bibtex`), which is the zip's own claim. This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.hithesis` options: `type=master` (degree type; picks the master's cover sheets, single-sided layout and page-numbering rules; `bachelor` and `doctor` also exist, `doctor` is two-sided: main.tex:22-26, README.md:34-38), `fontset=fandol` (passed on to `ctex`; main.tex:14-20, 36), `newtxmath=false` (boolean that turns off the class's `newtxmath` load, to avoid the `\Bbbk` clash with `amssymb`: main.tex:28-35, README.md:55-59) (main.tex:36)
- Class-native vocabulary used: `\hitsetup{...}` with keys `ctitle` `etitle` `cauthor` `eauthor` `cstudentid` `cdate` `edate` `cxueke` `exueke` `csubject` `esubject` `caffil` `eaffil` `csupervisor` `esupervisor` `ckeywords` `ekeywords` (main.tex:43-65; keyword keys are comma-separated lists that the class re-joins, main.tex:59-62); environments `cabstract` and `eabstract` (main.tex:73-82), declared before `\makecover` (main.tex:69-72); `\makecover` (main.tex:89; not `\maketitle`, main.tex:84-88); `\frontmatter` `\mainmatter` (main.tex:91, 94; book vocabulary through `ctexbook`); `\tableofcontents` (main.tex:92); `\chapter` `\section` (main.tex:96-135); environments `conclusions` (main.tex:143-145) and `acknowledgements` (main.tex:147-149)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:36 | `class.hithesis` | type=master, fontset=fandol, newtxmath=false |
| page geometry, paper, margins | not set in the sample | `class.hithesis` | inherited from the class (not read); `type=master` selects single-sided (main.tex:22-26); no explicit setting to emit |
| running heads and feet | not set in the sample | `hf.class-native` | inherited from the class (not read); the sample sets no page style |
| page numbering | main.tex:22-26, 91, 94 | `pgnum.pagenumbering` | no explicit call; the class's numbering rules follow `type=` (main.tex:24-25) and `\frontmatter`/`\mainmatter` |
| CJK text and CJK fonts | main.tex:10-12, 14-20, 36 | `lang.cjk` | `ctex` through `ctexbook` and `xeCJK`, loaded by the class; `fontset=fandol` (Fandol ships with TeX Live, main.tex:18); the body is Chinese UTF-8 text (main.tex:74-149) |
| Latin text face and math face | main.tex:28-35 | `font.newtx` | `newtxtext` (and `newtxmath`, switched off by `newtxmath=false`), per the sample's comment; the class source was not read to confirm |
| symbol math fonts | main.tex:29-30 | `math.amssymb` | `amssymb` loaded by the class, per the sample's comment (the `\Bbbk` clash); not read |
| title block, covers (Chinese covers, English cover) | main.tex:43-65, 84-89 | `front.class-native` | `\hitsetup` string keys: ctitle=哈尔滨工业大学学位论文模板, etitle=A Thesis Template for Harbin Institute of Technology, cauthor=张三, eauthor=Zhang San, cstudentid=21S000000, cdate=2026年8月, edate=August, 2026, cxueke=工学, exueke=Engineering, csubject=计算机科学与技术, esubject=Computer Science and Technology, caffil=计算机科学与技术学院, eaffil=School of Computer Science and Technology, csupervisor=李四教授, esupervisor=Prof. Li Si; printed by `\makecover` |
| abstracts (Chinese and English) | main.tex:69-82, 87-89 | `abs.class-native` | environments `cabstract` and `eabstract`, stored before `\makecover`, which prints the abstract pages after the covers |
| keywords | main.tex:59-64 | `abs.keywords` | `ckeywords={学位论文, 模板, 排版}`, `ekeywords={thesis, template, typesetting}`; comma lists, separators supplied by the class (Chinese enumeration comma, "; ") |
| front/main matter split | main.tex:91, 94 | `front.class-native` | `\frontmatter`, `\mainmatter` (`ctexbook` book vocabulary) |
| table of contents | main.tex:92, 139-142 | `toc.kernel` | one `\tableofcontents`; the class also keeps a bilingual (Chinese and English) contents entry for `conclusions`, per main.tex:139-142; the English list is class behaviour, not read |
| chapter headings | main.tex:96, 106, 135 | `head.class-native` | `\chapter{绪论}`, `\chapter{相关理论与方法}`, `\chapter{实验与分析}`; look set by the class (not read) |
| section headings | main.tex:100, 103, 110, 127 | `head.class-native` | `\section{...}` x4; look set by the class (not read) |
| unnumbered conclusions heading | main.tex:139-145 | `head.class-native` | `conclusions` environment: the unnumbered "结论" heading with its contents entries (main.tex:139-142) |
| acknowledgements page | main.tex:147-149 | `front.dedication` | `acknowledgements` environment (class-native; prints the acknowledgements page) |
| table float | main.tex:113-125 | `tbl.tabular` | `table[htbp]`, `tabular{lrr}`, three `\hline` rules (main.tex:118, 120, 123; the sentence at 111 calls it a three-line table, but no `booktabs` is used); cells are content |
| table alignment | main.tex:114 | `sp.ragged` | `\centering` inside the float |
| table caption | main.tex:115 | `cap.kernel` | `\caption{实验结果对比}` above the tabular; caption look is the class's (a `caption` load by the class is not established) |
| equation | main.tex:128-131 | `math.amsmath` | `equation` with `\label{eq:example}`; numbering style inherited from the class; the equation text is content |
| cross-references | main.tex:97, 107, 111, 116, 129, 133, 136, 137 | `xref.kernel` | `\label` / `\ref` (`表~\ref{tab:example}`, `第~\ref{chap:method} 章`) |
| equation reference | main.tex:133 | `math.amsmath` | `\eqref{eq:example}` (an amsmath command; the sample loads no package, so the class must load `amsmath`; not read) |
| bibliography | not used in the sample | none | README.md:26 says the starter has no bibliography; nothing to emit |
| lists, theorems, code, boxes, floats other than the table, colour, hyperref options | not used in the sample | none | nothing to emit; whatever the class sets internally is inherited and was not read |

## Bespoke code
none. No zip-local macro, environment, counter, class or style. The non-kernel commands (`\hitsetup`, `\makecover`, `cabstract`, `eabstract`, `conclusions`, `acknowledgements`) belong to the published class `hithesis`. The README quotes class internals (`\let\title\@gobble`, main.tex:84-85) as facts about the published class; they are not zip code.

## Content-opaque
none (the one table has plain text and number cells, the one equation is plain maths, and there is no figure, code or TikZ).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The class source was NOT read (it is not in the zip and no network use beyond one ctan.org page was allowed). Everything the class does internally is recorded as inherited.
- Vocabulary for the lib's class section (`class.hithesis`): `\hitsetup` string keys (Chinese `c...` and English `e...` pairs), `cabstract` `eabstract` `conclusions` `acknowledgements`, `\makecover`, options `type=bachelor|master|doctor`, `fontset`, `newtxmath`.
- The CTAN page lists version 3.2a (2026-10-11) with licence LPPL 1.3a and copyright 2017-2026; the starter's comments cite 2017-2022 (main.tex:8). The licence (LPPL 1.3a) is the same in both.
- Text addressed to an AI: none found in `main.tex` or `README.md`.
