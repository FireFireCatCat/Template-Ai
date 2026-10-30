no

# 0588-friggeri-resume-cv: Friggeri Resume/CV (A4)

- Unverified: read from the source, not compiled.
- Source: Source/0588-friggeri-resume-cv/ (origin: https://latextemplates.com/downloads/friggeri-resume-cv.zip; licence: MIT, README.md:41-54 and manifest)
- Kind: cv
- Lib: v5
- Engine: needs XeLaTeX (the class loads `fontspec` and `unicode-math` unconditionally and picks OpenType/TrueType files by file name with `Mapping=tex-text`, friggeri-cv-a4.cls:68-88; main.tex:5 and README.md:33 say XeLaTeX only)
- Look carried by: zip-local (the whole look is in `friggeri-cv-a4.cls`, an A4 fork of Friggeri's CV class; `main.tex` has no preamble of its own and only calls the class commands, main.tex:11)
- Class origin: zip-local (README.md:15 says the class is not on CTAN; my one CTAN read, `https://ctan.org/pkg/friggeri-cv-a4`, returned 404; the zip is a latextemplates.com starter vendoring a GitHub fork, README.md:52-54, not an official release; underneath it `\LoadClass`es the kernel `article`, friggeri-cv-a4.cls:10)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (`friggeri-cv-a4.cls` read in full, 362 lines; the font files `texgyreheros-*.otf` and `Lato-Light.ttf` are not in the zip and were not read; `hyperref` and `biblatex` internals were not read)

## Verdict
No. The look is carried by a zip-local class (not W1). Most of it reduces to lib ways (A4 paper, `geometry`, `parskip`, `fontspec`, `xcolor`, a `textpos` sidebar, a `tabular*` entry list), but two pieces do not. The name banner `\header` is a full-bleed TikZ overlay anchored at `current page.north` that draws the template's identity (ART). The `\section` heading is a hand-rolled counter plus `\ifcase` that colours the first three characters of each title in a cycling colour (BESPOKE). A third, borderline item is a set of hand-written biblatex drivers that the class loads unconditionally but the sample never calls.

## Blockers
- `ART/class` name banner `\header`: `tikzpicture[remember picture,overlay]` with a filled rectangle node at `current page.north` (minimum width `\paperwidth`, minimum height 4cm) and two text nodes placed relative to it (friggeri-cv-a4.cls:103-117; called at main.tex:15). A cover banner is the rubric's own ART example. It is not a watermark, a `tcolorbox` band or a `tikzposter` block with declarative parameters; `bg.tikzpagenodes` is listed as ART when it draws the template's identity.
- `BESPOKE/class` coloured section headings: `\newcounter{colorCounter}`, `\@sectioncolor#1#2#3` with `\ifcase\value{colorCounter}blue\or red\or orange\or green\or purple\or brown\else headercolor\fi`, then `\stepcounter{colorCounter}` (friggeri-cv-a4.cls:125-140). `\section` hands its whole title to the three-argument macro (cls:146), so the first three characters take the cycle colour and the rest stays in `headercolor`. A counter and conditional that drive what is printed, plus a split of the title by undelimited arguments, are not a parameter of `head.kernel` or `head.titlesec`. An emitter could pre-split and pre-colour each heading, but that would be new emitter logic, not a lib way.
- `BESPOKE/class` biblatex layer (borderline, unused by the sample): five `\DeclareBibliographyDriver` blocks, `\DeclareNameFormat{author}` with a `listcount`/`liststop` test, `\DeclareFieldFormat`, `\defbibheading`, `\DeclareSortingScheme{chronological}` and `\printbibsection` (friggeri-cv-a4.cls:214-341). The driver bodies are programs in biblatex's driver language (`\newunit`, `\setunit`, `\usebibmacro`), not option values (W2). `biblatex` is loaded unconditionally (cls:212), but `main.tex` has no `\addbibresource` or `\printbibliography` (README.md:34-39 says the publications block was removed). The verdict stays `no` through the first two blockers alone.

## Class setting
- Class: `class.article` (loaded by the zip-local wrapper at friggeri-cv-a4.cls:10). Options: any option not named below is passed to `article` (cls:6-8); the wrapper's own options are `nocolors` and `print` (cls:4-5); the sample passes none (main.tex:11, `\documentclass[]{friggeri-cv-a4}`).
- Class-native vocabulary used (zip-local, so not `cv.entries` and not `front.class-native`): `\header{first}{last}{role}` (main.tex:15), environment `aside` (main.tex:21-38), environment `entrylist` with `\entry{dates}{title}{place}{body}` (main.tex:46-66, 76-95, 99-110, 118-130, 138-150), and the redefined one-argument `\section` and `\subsection` (main.tex:22, 44, 74). Defined but not used by the sample: `\subsubsection` (two arguments), `\printbibsection`, `\rolefont`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | friggeri-cv-a4.cls:10 | `class.article` | default options; unknown options passed on with `\PassOptionsToClass` (cls:6-8) |
| paper size | friggeri-cv-a4.cls:13-14 | `page.setlength` | `\paperheight`=297mm, `\paperwidth`=210mm (same effect as `a4paper` under `page.class-options`) |
| page geometry | friggeri-cv-a4.cls:349 | `page.geometry` | left=6.1cm, top=2cm, right=2.5cm, bottom=2.5cm, nohead, nofoot |
| header/footer | friggeri-cv-a4.cls:163 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| paragraph spacing | friggeri-cv-a4.cls:123 | `sp.parskip-pkg` | package `parskip`, no options |
| table cell padding | friggeri-cv-a4.cls:170 | `sp.lengths` | `\tabcolsep`=0pt |
| manual spacing | friggeri-cv-a4.cls:115-116, 143, 148, 152, 154, 158, 160, 196 | `sp.manual-space` | `\vspace{2.5cm}`, `\vspace{-2\parskip}`, `\vspace{\parskip}`, `.5\parskip`, `.25\parskip`, `\vspace{\baselineskip}` |
| text fonts | friggeri-cv-a4.cls:68, 71-86 | `font.fontspec` | `[quiet]`; `\setmainfont{texgyreheros-regular.otf}` with BoldFont, ItalicFont, BoldItalicFont, `Mapping=tex-text`, `Color=textcolor`; `\newfontfamily` `\bodyfont`, `\thinfont` (Lato-Light.ttf), `\headingfont` (texgyreheros-bold.otf); `\defaultfontfeatures{Mapping=tex-text}` |
| math font | friggeri-cv-a4.cls:69, 88 | `font.unicode-math` | `\setmathfont{texgyreheros-regular.otf}` |
| heart symbol in sidebar | main.tex:36 | `font.unicode-math` | `$\varheartsuit$` (a symbol of the unicode-math setup; its table was not read) |
| font sizes | friggeri-cv-a4.cls:145, 153, 159, 181, 196 | `font.size-commands` | `\LARGE` (section), `\Large` (subsection, aside heading), `\footnotesize` (entry place) |
| colours | friggeri-cv-a4.cls:22-34, 49-50 | `color.xcolor` | `\definecolor` white RGB 255,255,255; darkgray 333333, gray 4D4D4D, lightgray 999999, green C2E15F, orange FDA333, purple D3A4F9, red FB4485, blue 6CE0F1; `\colorlet{textcolor}{gray}`, `\colorlet{headercolor}{gray}` |
| print and nocolors variants | friggeri-cv-a4.cls:36-48, 52-62 | `color.xcolor` | `\ifdefined` flag picks a `\colorlet` set (accents to gray; `fillheader` and `header` swapped); the sample uses neither flag (main.tex:11); resolved at emit time |
| inline colour | main.tex:36; friggeri-cv-a4.cls:128, 145, 153 | `color.xcolor` | `\color{red}`, `\color{headercolor}` |
| name banner (title block) | friggeri-cv-a4.cls:95, 103-117; main.tex:15 | `art.tikz` | ART blocker: filled rectangle node at `current page.north`, 4cm high, name at `\fontsize{40pt}{72pt}` (first name `\thinfont`, last name `\bodyfont`), role at `\fontsize{14pt}{24pt}` |
| section heading | friggeri-cv-a4.cls:142-149; main.tex:44, 72, 116, 136, 156 | `head.kernel` | `\renewcommand{\section}[1]`; `\LARGE\headingfont\color{headercolor}`; unnumbered; the colour cycling is BESPOKE (see Blockers) |
| subsection heading | friggeri-cv-a4.cls:151-155; main.tex:74, 97 | `head.kernel` | `\renewcommand{\subsection}[1]`; `\Large\headingfont\color{headercolor}`; `\vspace{.5\parskip}` before, `.25\parskip` after |
| bold switch | friggeri-cv-a4.cls:176; main.tex:158 | `mark.kernel` | `\renewcommand{\bfseries}{\headingfont\color{headercolor}}`, so `\textbf` prints Heros Bold in `headercolor` |
| emphasis and font reset | main.tex:52, 54, 60, 84, 105 | `mark.kernel` | `\emph`, `\normalfont` |
| entry list container | friggeri-cv-a4.cls:171-175; main.tex:46 | `tbl.tabular` | `tabular*` of width `\textwidth`, column spec `@{\extracolsep{\fill}}ll` |
| entry row | friggeri-cv-a4.cls:177-183; main.tex:50-54 | `box.minipage` | `\parbox[t]{2cm}{dates}` `&` `\parbox[t]{11.3cm}{...}`; inside: `\textbf{title}`, `\hfill`, `{\footnotesize\addfontfeature{Color=lightgray} place}`, `\\`, body, `\vspace{\parsep}` (composed with `sp.manual-space`, `font.fontspec`, `mark.kernel`, `color.xcolor`) |
| bullet list in entry | main.tex:87-91 | `list.kernel` | `itemize`, default labels and spacing |
| sidebar block | friggeri-cv-a4.cls:190-206; main.tex:21-38 | `pg.textpos` | `[absolute,overlay]`; `\TPHorizModule`=1cm, `\TPVertModule`=1cm; `textblock{3.6}(1.5, 4.33)` |
| sidebar alignment and line breaks | friggeri-cv-a4.cls:199-203 | `sp.ragged` | `flushright`; `\obeycr` makes each source line a line break (the emitter writes `\\`, see `sp.manual-space`) |
| sidebar headings | friggeri-cv-a4.cls:193-197; main.tex:22, 32, 35 | `head.kernel` | `\section` rebound inside `aside` to `\par\vspace{\baselineskip}{\Large\headingfont\color{headercolor} ##1}`; no colour cycle |
| external links | main.tex:29-31 | `xref.hyperref` | `\href{mailto:...}{text}`, `\href{http://...}{text}` (a hyperref command; no `\ref`-type command is used) |
| hyperref options | friggeri-cv-a4.cls:350-356 | `meta.hyperref` | `colorlinks=false`; linkcolor, citecolor, filecolor, urlcolor = red |
| bibliography package | friggeri-cv-a4.cls:212 | `bib.biblatex-biber` | `backend=biber`, `style=verbose`, `maxnames=99`, `sorting=ydnt`; no resource and no print call in the sample |
| bibliography section wrapper | friggeri-cv-a4.cls:330-336 | `bib.multi` | `refsection`, `\newrefcontext[sorting=chronological]`, `\nocite{*}`, `\printbibliography[type,title,heading=bibheading]` (unused by the sample) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\header` TikZ banner | friggeri-cv-a4.cls:95, 103-117 | no (ART) | none: free drawing of the template's identity |
| `colorCounter`, `\@sectioncolor`, `\section` | friggeri-cv-a4.cls:125-149 | no | none: counter and `\ifcase` choose the printed colour; the title is split by three undelimited arguments |
| biblatex drivers, name format, field formats, heading, sorting scheme | friggeri-cv-a4.cls:214-341 | no (borderline) | custom biblatex style code; it would reduce only if a custom biblatex style counted as a parameter of `bib.biblatex-biber` |
| `\subsection` | friggeri-cv-a4.cls:151-155 | yes | `head.kernel` with `\Large\headingfont\color{headercolor}` and the two `\vspace` values |
| `\subsubsection` (two arguments) | friggeri-cv-a4.cls:157-161 | yes | same as `\subsection`; the second argument exists to swallow the `*` of `\subsubsection*` in `bibheading` (cls:326); unused by the sample |
| `entrylist` and `\entry` | friggeri-cv-a4.cls:171-183 | yes | `tbl.tabular` + `box.minipage` + `sp.manual-space` + `font.fontspec` + `mark.kernel`, as in the map |
| `\bfseries` redefinition | friggeri-cv-a4.cls:176 | yes | one `\renewcommand` of a kernel font switch: `font.fontspec` family plus `color.xcolor` |
| `aside` environment | friggeri-cv-a4.cls:193-206 | yes | `textblock` + `flushright` + an emitted `\\` per line; the local `\section` rebind becomes the heading wrapper the emitter writes |
| `print` and `nocolors` flags | friggeri-cv-a4.cls:4-5, 36-62 | yes | choose the `\colorlet` branch at emit time; the sample selects neither |
| `\rolefont` | friggeri-cv-a4.cls:97-101 | yes | defined and never called in the class or the sample (grep); drop it |
| `\HyColor@@@@UseColor` patch | friggeri-cv-a4.cls:358-361 | probably yes | redefines a `hyperref` internal to colour links with `\addfontfeatures{Color=...}`; the class sets `colorlinks=false` (cls:352), so I expect no visible effect (hyperref source not read) and it can be dropped |
| second `\ProcessOptions` | friggeri-cv-a4.cls:16 | yes | repeats the call at cls:9; no printed effect |

## Content-opaque
none (no figures, data tables or code in the sample; `$\varheartsuit$` at main.tex:36 is an inline symbol, and the header drawing is ART, not content).

## Lib changes
- New ways proposed: none. Considered: `cv.entries` (its line names published CV classes; `\entry` here is zip-local, so it fails W1 and is reduced to a composition instead).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Missing assets: `texgyreheros-regular.otf`, `-bold.otf`, `-italic.otf`, `-bolditalic.otf` and `Lato-Light.ttf` are referenced by file name (friggeri-cv-a4.cls:72-77) and are not shipped in the zip; README.md:13-27 says both families are in the TeX Live install. Ship or install them.
- The entry boxes are 2cm + 11.3cm wide (friggeri-cv-a4.cls:178) inside a `tabular*` of `\textwidth`; with the geometry at cls:349 the text width is 21cm - 6.1cm - 2.5cm = 12.4cm. Read from the numbers only; not checked by compiling.
- No text addressed to an AI was found in `README.md`, `main.tex` or the class. README.md:43-48 is a licence note for humans (the upstream `.tex` header comment claims CC BY-NC-SA 3.0; the MIT `LICENSE` governs); `main.tex` carries no licence line.
