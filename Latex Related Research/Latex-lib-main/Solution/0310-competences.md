yes

# 0310-competences: competences (skill tags and sum-up tables for a graded assessment)

- Unverified: read from the source, not compiled.
- Source: Source/0310-competences/ (origin: https://mirrors.ctan.org/macros/latex/contrib/competences.zip; licence: LPPL 1.3)
- Kind: exam
- Lib: v3
- Engine: pdfLaTeX-compatible (the package loads `todonotes` (TikZ), `datatool`, `etoolbox`, `longtable`: competences.dtx:134-141; nothing needs XeLaTeX, LuaLaTeX or a tool outside TeX)
- Look carried by: preamble (kernel `article` unchanged; the look is one published CTAN package loaded in the sample's preamble, example.tex:3-5, plus one `\renewcommand`, example.tex:7)
- Class origin: tex-distribution-unbundled (`article`, kernel class, not in the zip; its source was not read)
- Main file: example.tex (other samples: competences.dtx, the package's own documentation driver, competences.dtx:28-39)
- Read: main yes, zip-local classes and styles all (no .cls or .sty is shipped; the style source competences.dtx was read in full, 479 lines, and competences.ins, 56 lines)

## Verdict
The sample is plain `article` plus one published package, `competences` (ctan.org/pkg/competences read: macros/latex/contrib/competences, v1.0, LPPL 1.3, in TeX Live), and one `\renewcommand\thesection`. The package's whole interface is strings, a comma list and an integer (points), so it passes W1 to W4 and is proposed as `exam.competences`, in the line of `tbl.calctab` and `cal.kalender`. The `yes` rests on W1: the datatool accumulators and loops (competences.dtx:143-449) would be irreducible BESPOKE if they were a zip-local copy, but they are the published package itself. No ART, no EXTERNAL.

## Blockers
none

## Class setting
- Class: `class.article` options: none (example.tex:1). Page, fonts, headers, colours and spacing are all article defaults; the sample sets none of them.
- Class-native vocabulary used: `\section` `\subsection` `\subsubsection` (example.tex:34-69), `enumerate` (example.tex:53-66). No `\maketitle`, no abstract.
- Encoding: no `inputenc` or `fontenc` is loaded; the accented heading at example.tex:69 relies on the kernel's UTF-8 default (not a way, a note).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | example.tex:1 | `class.article` | no options |
| package load | example.tex:3-5; competences.dtx:22-25 | `exam.competences` | `\usepackage[]{competences}`, version 2016/10/27 v1.0; no options: `nomargin` appears only in a comment (example.tex:4) and competences.dtx has no `\DeclareOption` or `\ProcessOptions` (grep) |
| section numbering | example.tex:7 | `num.counters` | `\renewcommand\thesection{\Alph{section}}`; the letter is the "part" key that the package stores (competences.dtx:172-174, 214) and that `\tableaupartie{A}` selects (example.tex:70) |
| headings | example.tex:34, 38, 42, 46, 51, 52, 62, 63, 69 | `head.kernel` | `\section`, `\subsection`, `\subsubsection`, article defaults, only `\thesection` changed |
| lists | example.tex:53-60, 64-66 | `list.kernel` | `enumerate`, nested two deep, defaults |
| prefix declarations | example.tex:11-13; competences.dtx:446-449 | `exam.competences` | `\declareprefix{CA}`, `{CB}`, `{CC}`: one string each, fixes the columns of the prefix table |
| competence declarations | example.tex:18-26; competences.dtx:440-443 | `exam.competences` | `\declarecompetence{CA1}` ... `{FOO}`: nine strings, fix column order of the sum-up tables |
| global competences | example.tex:30-31; competences.dtx:239-272 | `exam.competences` | `\addGlobalCompetence[points]{tag}`, stored under part `Global`, question `-` (competences.dtx:247-248) |
| per-question tags | example.tex:36, 40, 44, 48, 54, 55, 57, 58, 65; competences.dtx:203-237 | `exam.competences` | `\addcompetence[points]{tag}`, points default 1 (`[2][1]`, competences.dtx:203); the question key is the current section or enumerate counter (competences.dtx:147-169) |
| margin tag for each tag (package-internal) | competences.dtx:134-136, 204 | `note.todonotes` | loaded by the package: `color=blue!20`; body `\todo[noline]{tag}` |
| margin side (package-internal) | competences.dtx:137 | `note.marginpar` | `\reversemarginpar` (tags go to the left margin) |
| per-part summary table | example.tex:70, 72, 73, 76; competences.dtx:321-365 | `exam.competences` (inside it, `tbl.longtable`) | `\tableaupartie{A}`: line "Bilan Partie A", then `longtable` `{l|c|*{n}{|c}||c}` (competences.dtx:326), one row per question, Total row, `Total %` row, tag header row repeated at the foot |
| prefix summary table | example.tex:79; competences.dtx:387-437 | `exam.competences` (inside it, `tbl.tabular`, `sp.ragged`) | `\tableauprefix{A,B,C,Global}`: `center` environment (competences.dtx:388, kernel, same family as `\centering`) around `tabular` `{|c|*{n}{|c}||c|}` with `\hline` (competences.dtx:389) |
| whole-list table (not called by the sample) | competences.dtx:275-307 | `exam.competences` (inside it, `tbl.longtable`) | `\tableaucompetences`, `longtable` (competences.dtx:280) |
| fixed strings | competences.dtx:276, 281, 325, 350 | inside `exam.competences` | French strings hard-coded ("Ce sujet aborde", "Question", "Partie", "points", "Bilan Partie", "Total"); not a parameter, as the German names in `cal.kalender` |
| doc driver (second sample) | competences.dtx:28-39 | `class.ltxdoc`, `dtx.doc` | `\documentclass{ltxdoc}`, `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput`, `\PrintChanges`, `\PrintIndex` |
| doc title block | competences.dtx:69-73 | `front.maketitle`, `front.thanks` | `\title{...\thanks{...}}`, `\author`, `\maketitle`; the date is the default |
| doc headings | competences.dtx:75, 79, 99 | `head.kernel` | `\section{Introduction}`, `{Usage}`, `{Implementation}` |
| doc markup | competences.dtx:42-66, 82-129, 478 | `dtx.doc` | `\CheckSum`, `\CharacterTable`, `\changes`, `\GetFileInfo`, `\DoNotIndex`, `\DescribeMacro`, `\index`, `\DescribeEnv`, `\StopEventually`, `macro`, `environment`, `macrocode`, `\Finale`; the index and change history need the standard makeindex passes, a TeX Live tool, not a blocker |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand \thesection{\Alph{section}}` | example.tex:7 | yes | `num.counters`: one counter-format redefinition |
| package macros and datatool databases: `\addcompetence`, `\addGlobalCompetence`, `\tableaupartie`, `\tableauprefix`, `\tableaucompetences`, `\declarecompetence`, `\declareprefix`, the `\DTL...` loops and the `\def` accumulators `\total` `\ptotal` `\cstotal` `\pftotal` | competences.dtx:143-449 | not bespoke: published | This is the CTAN package, the implementation of `exam.competences`, not a zip-local copy; the emitter writes `\usepackage{competences}` and the commands above and never copies this logic. As a zip-local file the datatool tallies would be irreducible (hand-rolled accumulators driving what is printed), so the verdict depends on the W1 reading |
| `\dummyMacro` and `dummyEnv` | competences.dtx:105, 115-127 | yes | template boilerplate with empty bodies, no printed effect; delete |
| `\listecompetences` with `pgfkeys`/`pgffor` | competences.dtx:454-475 | yes (dead code) | every line is a `%` comment inside `\iffalse`, so docstrip does not copy it into the .sty |
| DocStrip driver | competences.ins:15-39 | yes | `\input docstrip.tex`, `\generate{\file{competences.sty}{\from{competences.dtx}{package}}}`: a TeX-only step; the .sty is not shipped, it is generated or taken from TeX Live |

## Content-opaque
none

## Lib changes
- New ways proposed: `exam.competences` | package `competences` (CTAN, in TeX Live), pdfLaTeX; a skill and points tracker for a graded assessment: preamble `\usepackage{competences}`, declarations `\declareprefix{str}` `\declarecompetence{str}`, body `\addcompetence[points]{str}` after each question, `\addGlobalCompetence[points]{str}`, and sum-up tables `\tableaupartie{part}`, `\tableauprefix{list}`, `\tableaucompetences`; it loads `todonotes`, `datatool`, `etoolbox`, `longtable`; table strings are French and fixed. W1: CTAN macros/latex/contrib/competences v1.0, LPPL 1.3 (ctan.org/pkg/competences read). W2: only strings, a comma list and an integer; no options. W3: serves a kind of component (a skill matrix for any exam, test or assignment), not one document. W4: preamble line plus body commands an emitter can write. Considered, not proposed: `datatool` (an internal dependency, the sample calls no `\DTL` command).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
