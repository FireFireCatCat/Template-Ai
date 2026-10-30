yes

# 0592-onepgnote: onepgnote (space-efficient one-page exam notes, an article-based class)

- Unverified: read from the source, not compiled.
- Source: Source/0592-onepgnote/ (origin: https://mirrors.ctan.org/macros/latex/contrib/onepgnote.zip; licence: GNU GPL v3, README.md:10 and the CTAN page ctan.org/pkg/onepgnote, v1.0.0 of 2025-05-27, also in TeX Live and MiKTeX)
- Kind: misc (a one-page study note for an exam; no title block, no abstract, no floats)
- Lib: v5 (the snapshot read)
- Engine: pdfLaTeX-compatible (the class loads `expl3`, `tikz` and `tcolorbox`; no `fontspec`, no Lua, no shell escape)
- Look carried by: mixed (the published class defines the headings, the numbered `enumerate`, the visible `\label`/`\ref` boxes, the note box and the display-math skips; the sample preamble adds the `geometry` margin, `\pagestyle{empty}` and the math packages)
- Class origin: ctan
- Main file: onepgnote-example.tex (other samples: onepgnote-manual.tex, the manual: plain `article` plus `hyperref`, `\maketitle`, `\tableofcontents`; documentation, not the template, so it is not in the component map)
- Read: main yes, zip-local classes and styles all (onepgnote.cls, 211 lines, read in full; onepgnote-manual.tex 103 lines and README.md read in full)

## Verdict
The look of the zip is carried by `onepgnote.cls`, which is a class published on CTAN (`macros/latex/contrib/onepgnote`, GPL v3) and this zip is the CTAN package archive (manifest url on mirrors.ctan.org), so it passes W1; its behaviour is chosen by 16 declarative keys (W2), it serves any one-page exam note (W3) and an emitter writes it as one `\documentclass[...]{onepgnote}` line (W4). The sample adds only `geometry`, `amsmath`, `amssymb` and `physics`, a `\pagestyle{empty}` and ordinary body constructs; it defines no macro, counter or environment of its own (Grep for `\newcommand`, `\def`, `\newenvironment`, `\renewcommand` over the sample finds none). The class internals (redefined `enumerate`, `\label`, `\ref`, TikZ counter node) are published class code and are not zip-local bespoke code; the `yes` rests on that ruling (see "Bespoke code" for how the same items would read if the class were zip-local).

## Blockers
none

## Class setting
- Class: `class.onepgnote` options: `a4paper`, `twocolumn`, `10pt` (all three fall to the `unknown` handler, which does `\PassOptionsToClass{#1}{article}`, onepgnote.cls:64) and the class key `enumboxcolor=cyan!50` (onepgnote.cls:54; the same as its default, onepgnote.cls:34). Base class `article` via `\LoadClass{article}` (onepgnote.cls:92); `article` is not emitted as a second way. The class keys, all read with `\DeclareKeys` and `\ProcessKeyOptions` (onepgnote.cls:46-68): `sectionvspace` `sectionleftmargin` `sectionrightmargin` `sectionbottommargin` `sectionborderwidth` `sectionbordercolor` `enumboxcolor` `enumboxrounding` `enumboxpadding` `labelboxcolor` `displayskipabove` `displayskipaboveshort` `displayskipbelow` `displayskipbelowshort` `noteboxcolor` `noteboxframecolor`.
- Class-native vocabulary used: `\section{}` `\subsection{}` `\subsubsection{}` (redefined as run-in boxed headings), `enumerate` with `\item` (redefined as inline boxed counters), `\label{}` and `\ref{}` (redefined to print visible boxes), `\mynote` (a yellow `NOTE` box followed by a space). Defined by the class and not used in the sample: `\notebox`, `\mylblbox`, `\coloredctr`, counters `coloredboxcounter` and `coloredlblctr` (onepgnote.cls:144-209). The class overrides only these three heading commands and `enumerate`; `itemize` and the other heading levels are untouched (onepgnote-manual.tex:71-74).
- Class internals (published, not emitted by the sample): tcolorbox with the `skins` library and `\tcbox` for the section box, the label box and the note box (onepgnote.cls:97-98, 119-131, 167-171, 202-208), `\fbox` for `\subsection` (onepgnote.cls:135), a `\tikz` node for the enumerate counter box (onepgnote.cls:149-155). `tikz` is loaded unconditionally (onepgnote.cls:95); it needs no tool outside TeX.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | onepgnote-example.tex:3; onepgnote.cls:92 | `class.onepgnote` | `[a4paper,twocolumn,enumboxcolor=cyan!50,10pt]`; vocabulary above |
| paper and type size | onepgnote-example.tex:3 | `page.class-options` | `a4paper`, `10pt` (passed to `article`, onepgnote.cls:64) |
| columns | onepgnote-example.tex:3 (reason in the comment, onepgnote-example.tex:1-2) | `cols.twocolumn-option` | `twocolumn` |
| page geometry | onepgnote-example.tex:8; the class sets none by design (onepgnote-manual.tex:56-62) | `page.geometry` | `margin=10pt` |
| header, footer, page number | onepgnote-example.tex:12 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| headings (3 levels) | onepgnote.cls:116-139; keys onepgnote.cls:29-33,48-53; used onepgnote-example.tex:13,14,127 | `head.class-native` | `\section`: `\par\noindent`, inline `\tcbox` (`blanker`, `left=3mm`, `right=1mm`, `bottom=1mm`, `borderline east` and `south` 2pt red), `\bfseries\large`, before-space `5pt plus 2pt minus 3pt`; `\subsection`: `\fbox{\bfseries #1}`; `\subsubsection`: `\textbf{#1}`; no heading numbers, no after-space; keys `sectionleftmargin` `sectionrightmargin` `sectionbottommargin` `sectionborderwidth` `sectionbordercolor` take effect; key `sectionvspace` is stored (onepgnote.cls:48,71) but `\section` uses the literal at onepgnote.cls:117 and never calls the accessor; the sample sets none of them |
| numbered inline lists | onepgnote.cls:144-163; used in 22 `enumerate` blocks of onepgnote-example.tex (first :15-26, last :516-525) | `class.onepgnote` | `enumerate` redefined: counter reset per environment (onepgnote.cls:159), `\item` = counter in a box (onepgnote.cls:160); keys `enumboxcolor=cyan!50` (sample, :3), `enumboxrounding=2pt`, `enumboxpadding=2pt` (defaults onepgnote.cls:35-36); box frame `draw=black` fixed (onepgnote.cls:150); items run on in the paragraph, no list indent. The sample emits the kernel names `\begin{enumerate}` and `\item`; the class renders them |
| cross-references | onepgnote.cls:167-191; labels onepgnote-example.tex:54,62,180,204,285; refs :71,208,283,298,316,347 | `class.onepgnote` | `\label{k}` prints box `L<n>` (onepgnote.cls:185) and stores `<n>` by `\xdef` at typeset time (onepgnote.cls:182-183); `\ref{k}` prints box `R<n>` (onepgnote.cls:190); box `colback` from key `labelboxcolor` (default `green!40!white`, onepgnote.cls:37,169), `sharp corners`, `size=tight`; no `.aux` lookup, so a reference before its label prints an empty number. The sample emits the kernel names `\label` and `\ref`; the class redefines them |
| note marker | onepgnote.cls:202-209; used onepgnote-example.tex:70,120,150,176,194,195,372,408 | `class.onepgnote` | `\mynote` = `\notebox{NOTE}\ `; keys `noteboxcolor=yellow`, `noteboxframecolor=yellow` (onepgnote.cls:42-43); `sharp corners`, `size=tight` |
| display-math skips | onepgnote.cls:194-199; defaults onepgnote.cls:38-41; keys onepgnote.cls:58-61 | `sp.lengths` | `\abovedisplayskip`, `\abovedisplayshortskip`, `\belowdisplayskip`, `\belowdisplayshortskip` all `1pt plus 2pt minus 1pt`, set at `\AtBeginDocument` by the four class keys; the sample sets none |
| math packages | onepgnote-example.tex:5 | `math.amsmath`, `math.amssymb` | `\usepackage{amsmath,amssymb}` |
| physics notation | onepgnote-example.tex:6 | `math.physics` | `\usepackage{physics}`; the sample uses its vector, derivative and trace macros (`\vb`, `\pdv`, `\dd`, `\trace`) in formulas |
| display and inline math | onepgnote-example.tex:28-32,146-149,251-255 and inline `$...$` throughout | `math.amsmath` | `\[ ... \]` and `$...$`; no equation number, no `align`; break hints `\allowbreak` (:43,:69,:372) and `\discretionary{}{}{}` (:391-395) and `\hbox{...}` (:29,:307,:320,:475) are kernel primitives inside the formula string, so they are equation content |
| emphasis | onepgnote-example.tex:19,21,35,37 | `mark.kernel` | `\emph{...}` |

Absent from class and sample (nothing to map): title block, abstract, contents, theorem-like statements, floats, tables, captions, code, bibliography, index, footnotes, fonts (Computer Modern default), colour package (the sample loads none; colours are class key strings), language, PDF metadata.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| macros, environments, counters of the sample | onepgnote-example.tex | none exist | the sample has only `\usepackage` lines (:5,:6,:8) and body text |
| `\renewcommand` of `\section` `\subsection` `\subsubsection` | onepgnote.cls:116-139 | published class code, not zip-local | would reduce to `\tcbox` options (`box.tcolorbox`) and `\fbox` (`box.fancybox`) if it had to be read as bespoke |
| `\renewenvironment{enumerate}`, `\coloredctr`, counter `coloredboxcounter` | onepgnote.cls:144-163 | published class code, not zip-local | a counter-driven redefinition of a list that prints the label by hand; if the class were zip-local this would be `BESPOKE/class` (hand-rolled counter driving printed text) |
| `\renewcommand{\label}`, `\renewcommand{\ref}`, counter `coloredlblctr`, `\csname mylabel#1\endcsname` store | onepgnote.cls:174-191 | published class code, not zip-local | replaces the kernel cross-reference mechanism with a typeset-time `\xdef` store; if the class were zip-local this would be `BESPOKE/class` |
| `\newtcbox{\mylblbox}`, `\newtcbox{\notebox}`, `\mynote` | onepgnote.cls:167-171,202-209 | published class code, reducible in any reading | `\newtcbox` calls plus an alias (`box.tcolorbox`) |
| `\AtBeginDocument` skip assignments | onepgnote.cls:194-199 | published class code, reducible in any reading | `sp.lengths` |
| expl3 token lists, `\DeclareKeys`, `\ProcessKeyOptions` | onepgnote.cls:7-88 | published class code | option plumbing only; it computes no layout |
| `\DeclareCurrentRelease{v1.0.0}{2025-05-27}` | onepgnote.cls:2 | kernel command | roll-back declaration, prints nothing |
| `\tikz` node for the counter box | onepgnote.cls:149-155 | published class code; not recorded as ART | its fill, corner radius and padding are class keys (`enumboxcolor`, `enumboxrounding`, `enumboxpadding`); it sits inside a published class, as the TikZ inside `tikzposter` or beamer themes does |

## Content-opaque
none (the sample has no figure and no table; formulas are content)

## Lib changes
- New ways proposed: none. `class.onepgnote` is a class way and needs no proposal; its vocabulary is recorded above. Considered and not proposed: a `list.class-native` line for the redefined `enumerate` and an `xref.class-native` line for the redefined `\label` and `\ref` (the lib folds a published class's own vocabulary into its class way, change-log v3).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
