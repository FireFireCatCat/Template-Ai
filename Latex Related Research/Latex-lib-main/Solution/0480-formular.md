yes

# 0480-formular: the formular package (fill-in form fields) and its documentation driver

- Unverified: read from the source, not compiled.
- Source: Source/0480-formular/ (origin: https://mirrors.ctan.org/macros/latex/contrib/formular.zip; licence: LPPL 1.2 or later, formular.sty:28-30, manifest `lppl1.2`)
- Kind: misc (a package manual; the package prints fields for handwritten entry on forms, so the manifest category is form-fillin, but the sample is a documentation page, not a form)
- Lib: v4
- Engine: pdfLaTeX-compatible (no fontspec, unicode-math or luacode; formular.sty uses `\usefont`, `\halign`, `\leaders` and box registers, sty:200-209, 250-275, 290-329; v1.0a was released to fix a pdfLaTeX clash with `graphicx`/`color`, dtx:743-747, README:19; the default fonts are `cmtt` and `cmss` in T1, sty:118-120, 129-131, which need the T1 Computer Modern fonts of a normal TeX distribution; not compiled here)
- Look carried by: mixed (the manual page is class `ltxdoc` with two `\setlength` lines, dtx:7, 17-18; the one distinctive element, the ruled fill-in fields, comes from the package `formular`, whose `formular.sty` is the CTAN release itself, shipped here as the DocStrip output of `formular.dtx`)
- Class origin: tex-distribution-unbundled (`ltxdoc` is LaTeX base and is not in the zip; the package `formular` is CTAN: ctan.org/pkg/formular read once, author Hans-Christoph Wirth, LPPL 1.2, v1.0a, "included in TeX Live and MiKTeX")
- Main file: formular.dtx (the `%<*driver>` block, lines 6-22; other samples: none; the live examples in the documentation body are lines 76-78, 94-99, 121-129, 148-154, 181-196)
- Read: main yes (all 903 lines of formular.dtx), zip-local classes and styles all (formular.sty 340 lines, formular.ins 37 lines, README 23 lines; formular.pdf is the shipped compiled manual, a binary, not read)

## Verdict
yes. There is no `.tex` sample, so the sample is the documentation driver inside `formular.dtx`: class `ltxdoc`, `\usepackage{formular}`, a kernel title block and the DocStrip `\DocInput`; everything it uses is a published way or the package `formular` itself. `formular` is a CTAN and TeX Live package, chosen by lengths, font names, a number, strings and two on/off style commands, and printed as one load line, `\setFRM...` lines, declarations and body wrappers, so it passes W1 to W4 as the new way `form.formular`. The only code defined outside the package is two string macros and the example container's layout code, and both reduce to lib ways. Two judgement calls are recorded for the consolidator: the package's own `\halign`/`\leaders` internals are treated as published (not diffed against the CTAN copy, no download), and `\newFRMcontainer` takes free layout code, which the sample fills with lib ways only.

## Blockers
none

## Class setting
- Class: `class.ltxdoc` options: none (formular.dtx:7)
- Class-native vocabulary used: `\CheckSum{639}` (dtx:8), `\CodelineIndex` (9), `\RecordChanges` (10), `\DocInput` (20), `\StopEventually` (411), `\Finale` `\PrintIndex` `\PrintChanges` (903), `\DescribeMacro` (24 uses, first at 207), `\changes` (747), `macrocode` (414-430) and `macro` (658) environments, `\meta` `\marg` `\oarg` (210, 209, 261), short-verb bars around code (66, 209), DocStrip guard lines `%<*driver>` `%</driver>` (6, 22)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | formular.dtx:7 | `class.ltxdoc` | no options; page, headings, fonts are the class defaults |
| documentation driver, index, change history | formular.dtx:8-10, 20, 411, 747, 903 | `dtx.doc` | `\CheckSum{639}`, `\CodelineIndex`, `\RecordChanges`, `\DocInput{formular.dtx}`, `\StopEventually{}`, `\changes{v1.0a}{2005/06/15}{...}`, `\Finale \PrintIndex \PrintChanges`; the index and history need the makeindex runs listed at formular.ins:25-26 (a documented build step, not a blocker: the lib already holds `idx.makeidx` and `bib.bibtex-bst` as tool-run ways) |
| package under documentation, loaded | formular.dtx:11 | `form.formular` | `\usepackage{formular}`, no options; it loads `xspace` itself (formular.sty:49) |
| title block | formular.dtx:12-15, 19 | `front.maketitle` | `\title{The \textsf{formular} Package.\thanks{...}}`, `\date{\filedate}`, `\author{Hans-Christoph Wirth\\hcw@gmx.de}`, `\maketitle` |
| title footnote | formular.dtx:12-13 | `front.thanks` | `\thanks{This file has version number \fileversion, dated \filedate.}` |
| paragraph shape | formular.dtx:17-18, 25 | `sp.lengths` | `\parindent`=0pt, `\parskip`=0.3\baselineskip (the 25 line is `\parindent 0pt`) |
| headings | formular.dtx:55, 63, 198, 413 | `head.kernel` | `\section`, `\subsection` as the class sets them; no `\renewcommand` of format or counters |
| summary quote | formular.dtx:26-30 | `quote.kernel` | `quote` environment with `\itshape` |
| code samples in the manual | formular.dtx:33-53, 67-72 | `code.verbatim` | `verbatim` inside `quote`; inline code in short-verb bars (66, 209) |
| lists | formular.dtx:270-279, 320-326, 390-398 | `list.kernel` | `enumerate` twice, `itemize` once, default labels |
| inline marks | formular.dtx:12, 105, 271, 744 | `mark.kernel` | `\textsf`, `\emph`, `\texttt`, `\itshape` |
| cross-reference | formular.dtx:157, 409 | `xref.kernel` | `\label{sec:example:container}`, `Section~\ref{...}` |
| manual spacing and breaks | formular.dtx:206, 245, 281; 170, 188, 261 | `sp.manual-space` | `\bigskip` (vertical), `\newline`, `\hfill` (171, 189) |
| one-line field, declared and used | formular.dtx:76-78, 94-99 (live); sty:211-249 (code) | `form.formular` | `\newFRMfield{namef}{15mm}`, then `[Name][nobody]` (description, default content); `\useFRMfield{namef}[John]`; `\renewFRMfield{namef}{15mm}[Name][nobody]` (95) |
| field style: font, rule style | formular.dtx:121-129 (live); sty:94-133 | `form.formular` | `\setFRMfontfamily{cmr}`, `\setFRMfontshape{it}`, `\setFRMfontsize{12}` (a bare number of pt, sty:262), `\setFRMruledstyle`; defaults rulewidth 0.1pt, rulesep 2pt, margin 5pt, baselineskip 18pt, content font T1 cmtt 10 m n, description font T1 cmss 6 m n (sty:97-133) |
| multi-line environment | formular.dtx:148-154 (live); sty:277-329 | `form.formular` | `\setFRMbreakstyle` or `\setFRMinlinestyle`, `\newFRMenvironment{env1}{Foobar}{2}`, body `\begin{env1} ... \end{env1}` with optional line count |
| container of fields | formular.dtx:181-196 (live); sty:331-336 | `form.formular` | `\newFRMcontainer{Grades}{init}{apply}`; init declares fields `Ma` `Ph` `En` with `[][////]` defaults (dtx:183-185); body `\setMa{excellent}` `\setPh{very good}` (194-195) |
| container layout (apply code) | formular.dtx:187-191 | `box.minipage` | two `\parbox[t]{0.45\linewidth}` columns |
| dotted leader in the container | formular.dtx:188-191 | `sp.rule` | `\dotfill` before each `\useFRMfield` |
| container line control | formular.dtx:187 | `sp.lengths` | `\baselineskip18pt` inside the left parbox |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `formular.sty` (field, environment and container macros, store and restore of settings, `\halign` and `\leaders` rule drawing) | formular.sty:49-336 | n/a: published | It is the CTAN package `formular` v1.0a, generated from the `.dtx` (sty:1-8, 46-47); README:19 gives the same version. The emitter prints the load line and the commands and never copies this code. Not diffed against the CTAN copy. |
| `formular.ins` (DocStrip driver) | formular.ins:4-32 | n/a: published build file | Generates `formular.sty` from `formular.dtx` (ins:9-12); pure TeX (`\input docstrip`), no outside tool. An emitter loads the installed package instead. |
| `\fileversion`, `\filedate` | formular.dtx:1-2; formular.sty:23-24 | yes | Two string macros used in the title note, the date and `\ProvidesPackage`; inline them as text: version "v1.0a -- (c) 2001 by Hans-Christoph Wirth", date "2005/06/15" (content of `front.thanks` and `front.maketitle`). |
| container `Grades` apply code | formular.dtx:186-192 | yes | `box.minipage` (two `\parbox[t]{0.45\linewidth}`), `sp.rule` (`\dotfill`), `sp.manual-space` (`\newline`, `\hfill`), `sp.lengths` (`\baselineskip18pt`), and the way's own `\useFRMfield`. No counters, conditionals or box code of the sample's own. |
| package-generated `\setMa` `\setPh` `\setEn` | formular.sty:236-238 | n/a: published | Created by the package when a container declares a field; they are calls of the way. |

## Content-opaque
none

## Lib changes
- New ways proposed: `form.formular` - `formular` (CTAN macros/latex/contrib/formular, LPPL 1.2, v1.0a, in TeX Live and MiKTeX, Hans-Christoph Wirth; pdfLaTeX): `\usepackage{formular}`; preamble `\setFRMrulewidth` `\setFRMrulesep` `\setFRMmargin` `\setFRMbaselineskip` (lengths), `\setFRMfont{encoding,size,family,series,shape}` and the `\setFRMdfont...` set for the description (NFSS names and one number), `\setFRMplainstyle` or `\setFRMruledstyle`, `\setFRMbreakstyle` or `\setFRMinlinestyle` (on/off styles), per-field retouching by an optional field argument; declarations `\newFRMfield{id}{width}[description][default]`, `\renewFRMfield`, `\newFRMenvironment{id}{description}{lines}`, `\newFRMcontainer{id}{init}{apply}`; body `\useFRMfield{id}[content]`, `\begin{id}[lines]...\end{id}`, `\begin{container}\set<field>{..}\end{container}`. Component: a fill-in form field, a ruled blank for handwriting or TeX entry whose rule grows with the content, with a description under it, or a block of n ruled lines. W1: on CTAN and in TeX Live and MiKTeX (ctan.org/pkg/formular read; public manual formular.pdf shipped). W2: lengths, font names, one size number, two boolean style commands, strings and an integer line count; no code is edited (the container's `apply` argument is free layout code, which the sample fills with `box.minipage`, `sp.rule` and `sp.manual-space`, so it is a composition of lib ways). W3: serves any form, certificate or questionnaire, not one document. W4: one load line, preamble `\setFRM...` and declaration lines, and body wrappers around a node's content. Not `sp.rule` (a bare rule or leader: a field whose rule follows the content width, hangs at a stored depth and carries a description is box and `\halign` code that would be bespoke without this package), not `mark.ulem` (underlines a span, no description or line count), not `exam.questions` (question-bank environments; `\fillin` and `\fillwithlines` belong to the `exam` class, a different package). Considered: the `eforms` package, which another solution file (Solution/0381-jj-game.md) names as a form way (interactive PDF form widgets with JavaScript, produced under Acrobat tooling); not the same type, since `formular` prints static ruled fields. If the consolidator reads both as "a form-field package is the parameter", one `form.*` line would hold them. Component prefix `form` is new in the lib.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Nothing in the zip addresses an AI or asks for an action; README, comments and macro names were read as data.
- The documentation example at formular.dtx:252 writes `\setFRMfontsize[foo]{20pt}` with a unit, but the implementation uses the value as a bare number of pt (`\dimen0=\frm@fontsize pt`, formular.sty:262); this is a documentation oddity in a verbatim block, with no effect on the verdict.
- `xspace` (sty:49, used at sty:248) is a dependency loaded by the published package, not a component of the sample: no node content is wrapped by it. It is not proposed as a way (compare the rejected `sp.xspace` in the v4 change log).
