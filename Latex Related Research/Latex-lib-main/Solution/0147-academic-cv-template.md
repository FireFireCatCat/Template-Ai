no

# 0147-academic-cv-template: Academic CV Template

- Unverified: read from the source, not compiled.
- Source: Source/0147-academic-cv-template/ (origin: https://latextemplates.com/downloads/academic-cv-template.zip; licence: MIT, README.md:36-38)
- Kind: cv
- Lib: v3
- Engine: needs XeLaTeX (README.md:30-32 says so; the `raleway` CTAN page names XeLaTeX/LuaLaTeX with OpenType fonts and does not confirm pdfLaTeX)
- Look carried by: zip-local (the whole look is in `my_cv.cls`; `main.tex` only calls its macros and repeats one package load)
- Class origin: zip-local (README.md:16 "vendored (not on CTAN)"; ctan.org/pkg/my_cv returns 404; the zip is a latextemplates.com repackaging of a GitHub fork, not an official release, README.md:8-11)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (my_cv.cls, 138 lines, read in full)

## Verdict
No, on one blocker. The section heading badge `\circled` (my_cv.cls:41-45) is a TikZ `\node[shape=circle, fill=black, minimum size=23pt]` carrying the section icon. It is the template's headline feature (README.md:3-5), and I cannot show a published declarative way that reproduces a fixed-diameter circle around glyphs of different widths. Considered: `tcolorbox` `\tcbox` with `arc` equal to the radius and forced width and height; it is not established from the source that `\tcbox` takes a forced height, so it is not claimed. Everything else reduces to lib ways (below). If a reviewer accepts the `\tcbox` reduction for the circle, no other blocker remains and the verdict flips to yes.

## Blockers
- `ART/class` circled section icon: TikZ circle node, fixed `minimum size=23pt`, black fill, white glyph (my_cv.cls:41-45; used by the `\section` wrapper at my_cv.cls:75)

## Class setting
- Class: `class.article` options: `a4paper` (loaded by the zip-local `my_cv` at my_cv.cls:4; main.tex:1 is `\documentclass{my_cv}`, no options). `my_cv` itself is not a way: it is zip-local (see Bespoke code).
- Class-native vocabulary used: article's `\section` and `\subsection`, `itemize`, `\textbf`, `\emph`. The sample does not use `\maketitle`, `abstract` or `thebibliography`. The zip-local macros `\titletext`, `\work`, `\school`, `\publication` and the two-argument `\section` are not class-native vocabulary of a published class.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | my_cv.cls:4 | `class.article` | `a4paper`; default 10pt, one-sided, one column |
| paper size | my_cv.cls:4 | `page.class-options` | `a4paper` |
| page geometry | my_cv.cls:19 | `page.geometry` | `margin=1cm`, `footskip=0.25in` |
| header/footer | my_cv.cls:28 | `hf.pagestyle-kernel` | `\pagestyle{empty}`: no running head, no page number |
| line spacing | my_cv.cls:138 | `sp.linespread` | `\renewcommand{\baselinestretch}{1.15}` |
| body font | my_cv.cls:16 | `font.helvet` | package `raleway`, option `default` (a sans text-face package is the parameter) |
| heading weight switch | my_cv.cls:58, 116-117, 129-131 | `font.helvet` | `\ralewayextra` is not defined in the zip (grep); it must come from `raleway`; the CTAN page does not list it, so the name is unconfirmed |
| icon glyphs | my_cv.cls:13; main.tex:13, 18, 40, 63, 85, 90 | `font.icons` | package `fontawesome5`, option `fixed`; `\faFile` `\faBook` `\faGraduationCap` `\faLaptop` `\faList` `\faStar` |
| font sizes | my_cv.cls:63, 116-117, 75 | `font.size-commands` | `\large` (subsection); `\fontsize{20}{20}\selectfont` (name); `\larger[2]` from `relsize` (my_cv.cls:17), a relative step up from the 10pt base; considered: `relsize` as its own way, not proposed (the same effect is an explicit `\fontsize` or `\Large`, same component type) |
| colours | my_cv.cls:15, 33-34, 43, 51, 58 | `color.xcolor` | `cvblue` rgb 0.32,0.68,0.89; `keywordcolor` rgb 0.80,0.90,1.0; `\color{cvblue}`, `\textcolor{white}`, `\textcolor{black}` |
| section headings | my_cv.cls:57-60, 69 | `head.titlesec` | `\titleformat{\section}`: format `\ralewayextra\bfseries\raggedright\color{cvblue}`, label empty, sep `0em`, before-code `\hspace{-0.8em}`; `\titlespacing*{\section}{0pt}{1\baselineskip}{0.4\baselineskip}` |
| subsection headings (job and degree titles) | my_cv.cls:62-65, 67 | `head.titlesec` | `\titleformat{\subsection}`: format `\large\bfseries`, label empty, sep `-0.8em`, no before-code; `\titlespacing*{\subsection}{0pt}{0.7\baselineskip}{0.4\baselineskip}` |
| heading ragged setting | my_cv.cls:58 | `sp.ragged` | `\raggedright` inside the section format |
| two-argument section wrapper | my_cv.cls:72-76; main.tex:13, 18, 40, 63, 85, 90 | `head.titlesec` | `\let\oldsection\section`, then `\renewcommand*{\section}[2]` calls `\oldsection[#2]{\circled{#1} {\larger[2] #2}}`; an alias, reducible (see Bespoke code) |
| heading icon badge | my_cv.cls:41-45 | `art.tikz` (ART) | `\tikz[baseline=(char.base)]`, node `shape=circle`, `fill=black`, `inner sep=1.5pt`, `minimum size=23pt`, white text; blocker |
| keyword tags (job skills) | my_cv.cls:48-53, 90-92 | `box.tcolorbox` | reduction: one `\tcbox` per item, `colback=keywordcolor`, `boxrule=0pt`, rounded corners via `arc`, on the text line; original is a TikZ node `rectangle, rounded corners, fill=keywordcolor` |
| title block (name, contact, links) | my_cv.cls:113-136; main.tex:5-11 | `cols.multicol` | `multicols{2}`, `\columnbreak` (my_cv.cls:125); gap `\setlength\columnsep{1cm}` (my_cv.cls:27); no `\maketitle`; the block is hand-laid in the body |
| title block, right column | my_cv.cls:127-133 | `sp.ragged` | `flushright` environment |
| title block offsets | my_cv.cls:116, 128, 135 | `sp.manual-space` | `\hspace{-15pt}`, `\vspace*{-12pt}`, `\vspace{-1cm}` |
| links | my_cv.cls:24, 103, 108, 122, 129-131; main.tex:18, 22 | `meta.hyperref` | `hyperref` with no options; body `\href{url}{text}`, `mailto:` and profile URLs built from arguments |
| lists in the body | main.tex:19-38, 50-53, 91-95; my_cv.cls:23, 29-30 | `list.kernel` | `itemize` |
| list settings | my_cv.cls:23, 29-30 | `list.enumitem` | `\setlist[itemize]{leftmargin=*}`, `\setlist{nolistsep}` |
| hand-typed bullet lines | main.tex:67-72, 78-81 | `sp.manual-space` | typed `•` characters, `\\ \vspace{2pt}` between lines; not a list environment |
| emphasis | my_cv.cls:84, 100-101, 108, 110; main.tex:49, 86-88 | `mark.kernel` | `\textbf`, `\emph` |
| CV entry commands | my_cv.cls:78-95, 97-104, 106-111 | none (reduced) | `\work`, `\school`, `\publication` are zip-local; they expand to `\subsection{..}` + `mark.kernel` + `meta.hyperref` lines + keyword tags. `cv.entries` is for published CV classes and is not used |
| tcolorbox load | my_cv.cls:21; main.tex:2 | `box.tcolorbox` | `[skins]` (loaded twice; no tcolorbox environment is used; it only brings TikZ in for the two nodes) |
| bibliography | none | none | no bibliography; publications are hand-set text (main.tex:21-37) |
| page numbers, ToC, floats, tables, theorems, code, notes, maths | none | none | not used by the template or the sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `my_cv` | my_cv.cls:1-138 | yes, except the badge | `\LoadClass[a4paper]{article}` plus `\RequirePackage` lines and settings, each in the map: preamble ways `font.icons`, `head.titlesec`, `color.xcolor`, `font.helvet`, `font.size-commands`, `page.geometry`, `cols.multicol`, `box.tcolorbox`, `list.enumitem`, `meta.hyperref`; settings `hf.pagestyle-kernel`, `sp.linespread` |
| `\circled` | my_cv.cls:41-45 | no (not shown) | `ART/class`; see Blockers. Candidate: `\tcbox` with `arc` = radius and forced size, not established |
| `\keyword` | my_cv.cls:48-53 | yes | `\tcbox[on line, colback=keywordcolor, boxrule=0pt, arc=..]{text}` (`box.tcolorbox`); inter-tag spaces come from the macro's line ends (no `%`), so an emitter writes explicit spacing (`sp.manual-space`) |
| two-argument `\section` | my_cv.cls:72-76 | yes | alias; emit `\section[TITLE]{badge {\larger[2] TITLE}}` with the `\titleformat` of my_cv.cls:57-60 |
| `\work` | my_cv.cls:78-95 | yes | `\subsection{#1}`; `\textbf{#2}\\` only when #2 is non-empty; `#3\\`; one `\keyword` per comma item of #4. The `\ifthenelse{\equal{..}{}}` tests (my_cv.cls:81, 87) only omit an empty field and are decided at emit time from the data |
| `\readlist` / `\foreachitem` / `\setsepchar` | my_cv.cls:22, 37, 90-92 | yes | `listofitems` (CTAN) only splits the keyword string at commas; the emitter already holds the items, so it writes one tag per item and no `listofitems` is needed (considered: `listofitems`, no lib way proposed because it vanishes on expansion) |
| `\school` | my_cv.cls:97-104 | yes | `\subsection{degree, level - year}`; `place - \textbf{GPA: } grade\\`; `\textbf{Thesis}` then title, wrapped in `\href` only when the URL is non-empty |
| `\publication` | my_cv.cls:106-111 | yes | `[year] \textbf{\href{doi}{title}}\\ venue\\ \emph{Main contributions:} text` |
| `\titletext` | my_cv.cls:113-136 | yes | two-column `multicols` block, see map; `\ifthenelse` at my_cv.cls:131 omits the website when empty (emit-time) |
| `ifthen` | my_cv.cls:18, 81, 87, 101, 131 | yes | LaTeX-base package; used only for the emptiness tests above |
| patch notes in the class | my_cv.cls:5-12, 118-121 | n/a | comments by the collection builder about fonts and the mail link; no text addressed to an AI and no instruction to follow |

## Content-opaque
none. (The `•` characters and `\\ \vspace{2pt}` line breaks at main.tex:67-81 are body text that sp.manual-space can hold; the FontAwesome glyphs are font characters, not artwork.)

## Lib changes
- New ways proposed: none. Considered: `relsize` (mapped to `font.size-commands`), `listofitems` (vanishes on expansion), `tcolorbox` `\tcbox` for the circle (existing way `box.tcolorbox`, but the circle reduction is not established).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
