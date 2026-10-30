yes

# 0139-readablecv: ReadableCV (CV and cover letter class)

- Unverified: read from the source, not compiled.
- Source: Source/0139-readablecv/ (origin: https://mirrors.ctan.org/macros/latex/contrib/readablecv.zip; licence: LPPL 1.3)
- Kind: cv
- Lib: v3
- Engine: pdfLaTeX-compatible (no fontspec, unicode-math or Lua code in the class; `roboto`, `marvosym`, `datetime` are ordinary packages)
- Look carried by: class (the CTAN class ReadableCV.cls defines the whole look; the sample adds `\color{black}` and the class's own setter commands)
- Class origin: ctan
- Main file: ReadableCV.tex (other samples: none; ReadableCV.pdf is a shipped rendering, not read)
- Read: main yes, zip-local classes and styles all (ReadableCV.cls, 626 lines, read in full; no .sty, .def, .cfg, .clo, .bst in the zip)

## Verdict
The look is carried by one published class, ReadableCV by Philip Stone (ctan.org/pkg/readablecv: "ReadableCV", LPPL 1.3, version 4.0, one read). The sample is a stock use of its native vocabulary (header setters, `\newHeading`, `\addSkills`, `\newRole`, `\roleAchievements`, `\newCourse`, letter commands) and defines nothing of its own: no `\newcommand`, `\def` or `\usepackage` in the body or preamble (ReadableCV.tex:1-190). Every component maps to `class.readablecv` and its class-native ways, or to a published package the class loads (memoir, xcolor, roboto, marvosym, multicol, hyperref, datetime, graphicx). There is no artwork, no external tool and no zip-local macro to copy, so `yes`, as evidence about the class dimension (the pilot ruling for a look carried by a published class), not about the component ways.

## Blockers
none

## Class setting
- Class: `class.readablecv` options: `a4paper` (sample, ReadableCV.tex:3; `letterpaper` named in the comment, ReadableCV.tex:1-2). The class defaults to `a4paper` (ReadableCV.cls:26), marks `twocolumn` and `twoside` as not used (ReadableCV.cls:23-24) and passes every other option to memoir (ReadableCV.cls:25). It loads `class.memoir` with `10pt, onecolumn, oneside` (ReadableCV.cls:28).
- Class-native vocabulary used (all defined in ReadableCV.cls, called in ReadableCV.tex):
  - page and colour: `\setPageColour{}` (cls:83, tex:11), `\setHeadingColours{}` (cls:103, tex:19)
  - header: `\setHeaderAlignment{left|right}` (cls:92, tex:16), `\setContactLocation{below|opposite}` (cls:387, tex:29), `\setImage{file}` (cls:374, commented out at tex:23), `\setYourName` `\setYourJobTitle` `\setYourMobileNo` `\setYourHomeNo` `\setYourEmailAddr` `\setYourWebAddr` (cls:394-399, tex:34-39), `\showHeader` (cls:402, tex:42 and tex:149)
  - sections: `\setSectionAlignment{left|right}` (cls:63, tex:45), `\newHeading{}` (cls:71, tex:48)
  - CV entries: `\addSkills` (cls:432, tex:56), `\setJobCompanyOrder{JobFirst|CompanyFirst}` (cls:462, tex:70), `\newRole{date}{job}{company}{summary}` (cls:469, tex:77), `\roleAchievements` (cls:544, tex:83), `\newCourse{date}{title}{body}{}` (cls:570, tex:124)
  - in the class, not in the sample: `\newQuickRole` (cls:496), `\roleResponsibilities` (cls:520)
  - letter: `\setRecpName` `\setRecpJobTitle` `\setRecpRoad` `\setRecpTown` `\setRecpCity` `\setRecpPostcode` (cls:600-605, tex:155-160), `\makeLetter` (cls:607, tex:162), `\recpname` (cls:593, tex:166), `\closeletter{signature image}` (cls:624, tex:189)

## Component map
Rows marked "(class-internal)" are what the class does inside its own commands; an emitter reaches them by calling the class, so they are listed to show every part has a way, not as separate preamble lines.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | ReadableCV.tex:3; ReadableCV.cls:18-28 | `class.readablecv` | option `a4paper` (or `letterpaper`, tex:1-2) |
| base class (loaded by the class, not by the sample) | ReadableCV.cls:28 | `class.memoir` | `10pt, onecolumn, oneside` |
| paper size | ReadableCV.tex:1-3; ReadableCV.cls:26 | `page.class-options` | `a4paper` / `letterpaper` |
| page geometry (class-internal) | ReadableCV.cls:30-32 | `page.memoir-layout` | `\setlrmarginsandblock{1.5cm}{1.5cm}{*}`, `\setulmarginsandblock{1.5cm}{*}{*}`, `\checkandfixthelayout` |
| page style | ReadableCV.cls:51 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| paragraph spacing (class-internal) | ReadableCV.cls:53; letter: ReadableCV.cls:608 | `sp.lengths` | `\addtolength{\parskip}{6pt}`; letter `\setlength{\parindent}{0em}` (the CV-wide `\parindent` line is commented out, cls:52) |
| manual spacing (class-internal and body) | ReadableCV.cls:73,75,474,491,522; ReadableCV.tex:169,180 | `sp.manual-space` | `\smallskip`, `\bigskip`, `\vspace{0.5em}`, `\vspace{-0.5em}`, `\vspace{\baselineskip}` |
| page breaks | ReadableCV.tex:119,144 | `pg.break` | `\newpage` (CV page 2), `\clearpage` (before the letter) |
| keep a role block together (class-internal) | ReadableCV.cls:475,493 | `pg.break` | kernel `samepage` environment around each `\newRole` (kernel page-break control, filed with the break commands; not a lib line of its own) |
| sans text face | ReadableCV.cls:48,74,118 | `font.helvet` | package `roboto`, option `thin`; switch `\robotoThin{...}` on name, headings and contact lines (sans text-face package is the parameter, as `font.helvet` was merged) |
| font encoding | ReadableCV.cls:49 | `font.fontenc-t1` | `fontenc` option `T1` |
| contact icons (class-internal) | ReadableCV.cls:45,132,140,164,168 | `font.icons` | package `marvosym`; glyphs `\Mobilefone`, `\Telefon`, `\Letter`, `\Mundus` |
| sizes and text marks (class-internal) | ReadableCV.cls:74,118,120,132; role labels cls:492,556 | `font.size-commands`, `mark.kernel` | `\Large` `\Huge` `\LARGE` `\normalsize`; `\textbf` `\textit` `\sffamily` `\rmfamily` |
| colour definitions | ReadableCV.cls:47,101; ReadableCV.tex:6,19 | `color.xcolor` | `xcolor` option `x11names`; heading colour name `SlateGray3` (default cls:101, set tex:19); body `\color{black}` (tex:6); `\textcolor{\HeadingColour}{...}` throughout |
| page colour | ReadableCV.cls:82-86; ReadableCV.tex:11 | `color.pagecolor` | `\pagecolor{white}` through `\setPageColour` |
| PDF metadata | ReadableCV.cls:36,404-411 | `meta.hyperref` | `hyperref` default load; `\hypersetup{pdftitle, pdfauthor, pdfsubject, pdfkeywords, pdfproducer}` filled from the name and job title strings, run inside `\showHeader` |
| date format (letter) | ReadableCV.cls:39,610 | `front.datetime` | `datetime` option `nodayofweek`; plain `\today` in a `flushright` |
| right/left ragged blocks (class-internal) | ReadableCV.cls:61,72,117,179,186,207,223 | `sp.ragged` | `flushleft` / `flushright` environments, chosen by `\setSectionAlignment` and `\setHeaderAlignment` |
| CV header block (name, job title, contact) | ReadableCV.tex:16-42; ReadableCV.cls:114-237,402-430 | `front.class-native` | sample branch: `HeaderAlignment=flushleft` (tex:16), `contactloc=opposite` (tex:29), no image (tex:23): `\showHeader` -> `\HeaderTextOppo` -> `\HeaderRightContact` (cls:232-235, 175-201): name and job title left, contact lines right; name `\Huge` bold `\robotoThin` in `\HeadingColour`, job title `\LARGE` |
| header layout boxes (class-internal) | ReadableCV.cls:116,178,185,206,222,240,245,305,362 | `box.minipage` | `minipage` of `1.0\linewidth` (below) or two of `0.5\linewidth` (opposite, image variants) |
| header image slot | ReadableCV.cls:242,364,374-383; ReadableCV.tex:23 | `fig.graphicx` | `\includegraphics[width=2.5cm,height=2.5cm,keepaspectratio]{<file>}` through `\setImage`; off in the sample (line commented); profilepic.jpg is shipped |
| section heading | ReadableCV.cls:63-78; ReadableCV.tex:45,48,52,66,122,137 | `head.class-native` | `\newHeading{text}`: `\Large` bold `\robotoThin` in `\HeadingColour`, then `\hrule`, in a `flushleft` or `flushright` set by `\setSectionAlignment{left}` (colour from `\setHeadingColours`) |
| heading rule (class-internal) | ReadableCV.cls:76 | `sp.rule` | bare `\hrule` under every heading |
| core skills (two columns) | ReadableCV.cls:432-456; ReadableCV.tex:56-64 | `cv.entries` | `\addSkills` of eight slots, each printed as an `\item` unless empty |
| skills columns (class-internal) | ReadableCV.cls:42,443,455 | `cols.multicol` | `multicols{2}` |
| bullet lists (class-internal) | ReadableCV.cls:444,533,559 | `list.kernel` | `itemize` (no enumitem options set) |
| role entry | ReadableCV.cls:469-494; ReadableCV.tex:77,90,102,114-116 | `cv.entries` | `\newRole{date}{job}{company}{summary}`; order set by `\setJobCompanyOrder{JobFirst}` (tex:70, toggle cls:459-467); label "Role outline" in `\sffamily` italic (cls:492) |
| role entry table (class-internal) | ReadableCV.cls:478,485,505,512 | `tbl.tabular` | `tabular{@{}p{3cm} l}`, bold date and title cells |
| achievements | ReadableCV.cls:544-568; ReadableCV.tex:83-88 | `cv.entries` | `\roleAchievements` of six slots under an "Achievements" label, `itemize` |
| education and training entry | ReadableCV.cls:570-590; ReadableCV.tex:124,139 | `cv.entries` | `\newCourse{date}{title}{body}{}`; 3 cm date column |
| letter: date, recipient block, sign-off | ReadableCV.cls:593-626; ReadableCV.tex:149-189 | `ltr.opening` | `\showHeader` as letterhead (tex:149); six `\setRecp*` strings (tex:155-160), `\makeLetter` (cls:607-621: flushright `\today`, address lines with `\\`), body text, `\closeletter{sig.png}` (cls:625: `\includegraphics`, then `\bigskip` and the name); class-native commands, no `letter` environment |
| signature image | ReadableCV.cls:625; ReadableCV.tex:189 | `fig.graphicx` | `\includegraphics{sig.png}`, natural size; sig.png shipped |

Components the sample does not use and the class does not define: title and abstract, contents, numbered sections, notes, math, theorems, floats and captions, code, bibliography, index, cross-references (no `\label`, no `\section`).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| sample preamble and body definitions | ReadableCV.tex:1-190 | none exist | the only preamble line is `\color{black}` (tex:6): `color.xcolor` |
| ReadableCV.cls as a whole | ReadableCV.cls:1-626 | not bespoke: published on CTAN (W1; zip origin and one ctan.org/pkg/readablecv read) | `class.readablecv` |
| class-internal logic: `\ifdefempty` contact combinations (cls:123-146, 252-275, 312-335), `\newtoggle{useImage}` (cls:370), `\newtoggle{jobfirst}` (cls:459), `\IfEqCase` setters (cls:63-68, 92-97, 387-392), eight- and six-slot `\def\sone...` lists (cls:433-452, 547-565) | ReadableCV.cls | not counted: it lives inside the published class; the emitter writes `\documentclass{ReadableCV}` and the setter calls, and copies none of it | `class.readablecv` setter and entry commands (strings, `left|right`, `below|opposite`, `JobFirst|CompanyFirst`) |

Re-read note, for a reader who counts class internals: the logic above (empty-field branching, toggles, fixed-slot lists) is hand-rolled conditional code that drives what is printed; under that stricter scope it would be `BESPOKE/class` and probably irreducible. The tag is class, and it does not apply under the rubric as written (W1 published class).

Observations on the shipped sample, not blockers (nothing compiled, so not evaluated):
- `\newHeading` is declared with two parameters (cls:71) and uses only `#1` (cls:71-78), but the sample passes one braced argument (tex:48, 52, 66, 122, 137), each followed by a blank line. A non-`\long` macro could stop at that paragraph end. Unverified.
- `\addSkills` is declared with eight parameters (cls:432); the ninth is commented out (cls:441, 453); the sample passes nine groups and the comment says up to nine (tex:54-64). Group nine would fall outside the macro's arguments. Unverified.
- README says v3 (README.md:1); the class says 4.0 (cls:20). Nothing in README.md or the class addresses an AI.

## Content-opaque
none (no figure or table float in the sample; profilepic.jpg and sig.png are shipped image assets, ReadableCV.tex:23, 189)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Class vocabulary for the lib's class line (recorded for the script): `class.readablecv` (CTAN `ReadableCV`, memoir-based CV and letter class): `\setHeaderAlignment` `\setContactLocation` `\setImage` `\setYour*` `\showHeader`, `\setSectionAlignment` `\newHeading`, `\addSkills` `\newRole` `\newQuickRole` `\roleAchievements` `\roleResponsibilities` `\newCourse` `\setJobCompanyOrder`, `\setPageColour` `\setHeadingColours`, `\setRecp*` `\makeLetter` `\closeletter`; options `a4paper` `letterpaper` (others go to memoir; `twocolumn` and `twoside` ignored)
- Considered: `box.minipage`, `sp.ragged` and `tbl.tabular` for class-internal parts, all existing ways; no way needed for `etoolbox` and `xstring` (they are class-internal programming support, not a template component).
