yes

# 0229-lolatexcv: LoLaTeXcv

- Unverified: read from the source, not compiled.
- Source: Source/0229-lolatexcv/ (origin: https://latextemplates.com/downloads/lolatexcv.zip; upstream named at LoLaTeXcv.cls:3 and README.md:6 is github.com/kryzar/LoLaTeXcv; licence: GPL-3.0, README.md:26-29, LICENSE.md:1-2)
- Kind: cv
- Lib: v2
- Engine: pdfLaTeX-compatible (no fontspec, no Lua; the `px` length unit used at LoLaTeXcv.cls:13,48,80,129 is a pdfTeX unit)
- Look carried by: zip-local (LoLaTeXcv.cls defines the whole look: `\LoadClass{report}` plus eight packages plus a handful of small macros; main.tex has no preamble beyond fontenc, inputenc and babel)
- Class origin: zip-local (`LoLaTeXcv` is a GitHub class by Antoine Leudière; https://ctan.org/pkg/lolatexcv returned 404; the zip is not an official release of a publisher)
- Main file: main.tex (other samples: none)
- Read: main yes (all 79 lines), zip-local classes and styles all (LoLaTeXcv.cls, all 144 lines; no .sty/.def/.cfg/.clo present; README.md read; LICENSE.md is the GPL-3.0 text, only its head read)

## Verdict
Yes. The class is not published, but every macro in it is a composition of kernel commands (`center`, `minipage`, `\vspace`, `\hrulefill`, `\raisebox`, `\makebox`, `\textit`, size switches, dot leaders) and published packages (`geometry`, `enumitem`, `hyperref`, `lmodern`, `xcolor`, and `eqparbox` for one measured label column). The sample uses only that class vocabulary, with no artwork, no `\@startsection` or `\@maketitle` redefinition, no counters or output-routine code. One new way is proposed, `box.eqparbox` (equal-width boxes by tag). The most borderline items are the `\ifthenelse{\isempty{#1}}` test in `lltxJob` and the `\EnumitemId`-keyed `eqparbox` tag, both resolved at emit time (see Bespoke code).

## Blockers
none

## Class setting
- Class: `class.report` (reached through zip-local `LoLaTeXcv`; `\documentclass{LoLaTeXcv}` at main.tex:3, `\LoadClass[11pt, a4paper, oneside]{report}` at LoLaTeXcv.cls:10). Options: 11pt, a4paper, oneside. The zip-local class is not itself a lib way (not published); `report`'s own vocabulary (`\chapter`, `abstract`, `\maketitle`) is not used by the sample or the class macros.
- Class-native vocabulary used: zip-local, not report's: `\lltxPersonalInfo{name}{address}{position}{contact}`, `\lltxSection{}`, `\lltxSubSection{}`, `lltxDescription` (with `\item[label]`), `lltxJob[title]{company}{period}{location}`, `lltxItemize`, `\lltxdotfill`; `\NTS{}` is defined but not called (LoLaTeXcv.cls:144).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class and paper | LoLaTeXcv.cls:10; main.tex:3 | `class.report`, `page.class-options` | `11pt`, `a4paper`, `oneside` |
| page geometry | LoLaTeXcv.cls:13 | `page.geometry` | left=45px, top=70px, right=45px, bottom=70px |
| encodings | main.tex:4-5 | `font.fontenc-t1` | `[T1]{fontenc}`, `[utf8]{inputenc}` |
| language | main.tex:6 | `lang.babel` | `english` |
| text font | LoLaTeXcv.cls:18 | `font.lmodern` | package loaded, no options |
| hyperlinks | LoLaTeXcv.cls:17 | `meta.hyperref` | `hidelinks`; no `\hypersetup`, no link used in the sample |
| colour | LoLaTeXcv.cls:19,144 | `color.xcolor` | package loaded; only use is `\textcolor{red}` in the unused `\NTS` |
| page numbers | LoLaTeXcv.cls:32 | `pgnum.pagenumbering` | `\pagenumbering{gobble}` (kernel `\@gobble` as the numbering style); no `\pagestyle` call anywhere, so the kernel `plain` footer prints nothing |
| paragraph indent | LoLaTeXcv.cls:34 | `sp.lengths` | `\parindent`=0pt |
| list margins | LoLaTeXcv.cls:24-26 | `list.enumitem` | `\setlist[itemize]`, `[enumerate]`, `[description]` all `leftmargin=*` |
| personal-info block (front matter) | main.tex:10-17; LoLaTeXcv.cls:46-69 | `sp.ragged`, `sp.manual-space`, `font.size-commands`, `cols.minipage` | `center`; `\vspace{20px}` before and after the name; `\Huge` name, then `\normalsize`; three `minipage[t]` of 0.3, 0.35 and 0.3 `\textwidth`, each holding a `center` with the argument (address, position, contact lines broken with `\\`, main.tex:11-17). No `\maketitle`, so `front.maketitle` is not used |
| section heading | main.tex:19,52,65; LoLaTeXcv.cls:74-84 | `sp.ragged`, `sp.manual-space`, `font.size-commands`, `mark.kernel`, `sp.rule`, `box.fancybox` | `center`; `\vspace{15px}`; `\LARGE`, then `\normalsize`; `\vspace{-3em}` after; title in `\textit`; rule line = `\par\noindent\raisebox{.8ex}{\makebox[\linewidth]{\hrulefill\hspace{1ex}\raisebox{-0.5ex}{title}\hspace{1ex}\hrulefill}}` (`\makebox` filed with the kernel LR-box family of `\fbox`, here unframed). `\section` is never called, so no `head.*` way and no numbering |
| subsection heading | main.tex:21,27,44 etc.; LoLaTeXcv.cls:87-90 | `sp.manual-space`, `mark.kernel` | `\vspace{1.5em}`, `\noindent \textbf{title}` (a run-in bold line, not a sectioning command) |
| dot leader | main.tex:23-24; LoLaTeXcv.cls:28-30 | `sp.rule` | `\lltxdotfill` = `\leavevmode\cleaders\hb@xt@ 1em{\hss .\hss}\hfill\kern\z@`: dots-only leaders, the kernel `\dotfill` pattern at 1em pitch instead of .44em |
| dated description list | main.tex:22-25,55-63; LoLaTeXcv.cls:98-104 | `list.enumitem`, `box.eqparbox` | `\newlist{lltxDescription}{description}{1}`; `format=\normalfont\lltxDescriptionlabel`, `labelwidth=0.15cm+\eqboxwidth{listlabel@\EnumitemId}`, `leftmargin=!`; label = `\eqmakebox[listlabel@\EnumitemId][l]{label}` (left-aligned, all labels of one list take the widest label's width; needs the aux file, so two passes) |
| job entry | main.tex:28-50; LoLaTeXcv.cls:126-140 | `sp.manual-space`, `sp.rule`, `mark.kernel`, `list.enumitem` | `\vspace{4px}`; line `company \lltxdotfill period $\cdot$location`; when the optional title is non-empty, `\newline \textit{title}`; then `itemize[leftmargin=!, label=$\cdot$]` over the body |
| bullet list | main.tex:68-77; LoLaTeXcv.cls:111-115 | `list.kernel` | `itemize`, with the `leftmargin=*` set at :24 (`list.enumitem`) |
| note to self (unused) | LoLaTeXcv.cls:144 | `color.xcolor`, `mark.kernel` | `\textcolor{red}{\textbf{\MakeUppercase{#1}}}` (`\MakeUppercase` taken as a kernel inline text command of the `\textbf` family; an emitter could also upper-case the string itself) |
| not used by the sample | main.tex:1-79 | none needed | no abstract, `\chapter`, `\section`, footnote, float, table, theorem, equation, code, citation, bibliography, index or appendix in the sample or class macros |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `LoLaTeXcv.cls` as a whole | LoLaTeXcv.cls:8-144 | yes | `class.report` [11pt,a4paper,oneside] + `page.geometry` + `list.enumitem` + `meta.hyperref` + `font.lmodern` + `color.xcolor` + `box.eqparbox`, plus the macros below as body wrappers; the loads of `environ` and `xifthen` (:15,20) are macro-programming helpers, not a component (considered: environ, xifthen) |
| `\lltxdotfill` | LoLaTeXcv.cls:29 | yes | `sp.rule`: one dots-only `\cleaders` line, as the kernel `\dotfill` is built, pitch 1em; no logic |
| `\lltxPersonalInfo` | LoLaTeXcv.cls:46-69 | yes | `center` + `\vspace` + `\Huge` + three `minipage[t]`, see the component map; four arguments, no conditional |
| `\lltxRuleline`, `\lltxSection` | LoLaTeXcv.cls:74-84 | yes | `\hrulefill` between two `\hspace{1ex}` around the title inside `\raisebox`/`\makebox`; an emitter prints it directly, or as the `before` code of one `head.titlesec` `\titleformat` (not claimed, the source never uses `\section`) |
| `\lltxSubSection` | LoLaTeXcv.cls:87-90 | yes | `\vspace{1.5em}\noindent\textbf{...}` |
| `lltxDescription`, `\lltxDescriptionlabel` | LoLaTeXcv.cls:98-104 | yes | `list.enumitem` `\newlist` + `\setlist` keys; `\lltxDescriptionlabel` is a one-argument alias for `\eqmakebox[tag][l]{...}`; the tag `listlabel@\EnumitemId` is a per-list unique string, which an emitter supplies by numbering its lists (`\EnumitemId` is then not needed) |
| `lltxItemize` | LoLaTeXcv.cls:111-115 | yes | `\NewEnviron` whose whole body is `\begin{itemize}\BODY\end{itemize}`, an alias of `itemize` |
| `lltxJob` | LoLaTeXcv.cls:126-140 | yes | `\NewEnviron` over the lines in the component map; the one conditional, `\ifthenelse{\isempty{#1}}` (:131-136), tests whether the optional title was given: a presence test on an argument, which the emitter settles when it prints the entry (print `\newline \textit{...}` or not). No counter, no state shared between entries |
| `\NTS` | LoLaTeXcv.cls:144 | yes | alias of `\textcolor{red}{\textbf{...}}` with `\MakeUppercase`; not called |

## Content-opaque
none

## Lib changes
- New ways proposed: `box.eqparbox` (`eqparbox`, CTAN, Scott Pakin, LPPL 1.3c, page read at https://ctan.org/pkg/eqparbox; pdfLaTeX; `\eqmakebox[tag][align]{text}`, `\eqparbox[tag]{text}`, `\eqboxwidth{tag}`: every box with the same tag takes the width of the widest one). W1: on CTAN. W2: the tag string and the alignment letter (and a width expression read back with `\eqboxwidth`) are the parameters, no code is edited. W3: serves any equal-width alignment (list labels, table-like rows), not this document. W4: `\usepackage{eqparbox}` plus a wrapper `\eqmakebox[tag][l]{...}` around a node's content. Not `list.enumitem`: its label width is a given value (`labelwidth`, `widest`), it does not measure the labels that appear in the document; not `box.minipage`, whose width is given, not measured. Here it sets the label column of `lltxDescription` (LoLaTeXcv.cls:98-104).
