yes

# 0173-uni-titlepage: uni-titlepage (KOMA title page project, package source with 13 title page styles)

- Unverified: read from the source, not compiled.
- Source: Source/0173-uni-titlepage/ (origin: https://mirrors.ctan.org/macros/latex/contrib/uni-titlepage.zip; licence: LPPL 1.3c, README.md:7 and LICENSE.md:3-7)
- Kind: thesis (title pages of theses and books: DHBW, TU-DD, TU-HH, KIT, WWUM, UKoLa are thesis covers, the Markus, KOMAScript and JT styles are book titles; the manifest hint "misc" is overridden)
- Lib: v3
- Engine: pdfLaTeX-compatible (the example preamble branches on `\iftutex`, uni-titlepage.dtx:3262-3274: fontspec with TeX Gyre faces under XeLaTeX/LuaLaTeX for TU-HH and TU-DD only, fontenc + lmodern otherwise; the manifest hint "xelualatex" is not required by the source)
- Look carried by: class (a published CTAN package, `uni-titlepage`, carries the look in its `title-<Style>.def` files, uni-titlepage.dtx:2093-3245; it is class-like, loaded under `scrbook`; the example preamble adds only fonts, colour and `\setkomafont` values)
- Class origin: ctan (the package is the author's own CTAN release, README.md:3-7 and 50-52; the example class `scrbook` is tex-distribution-unbundled and its source was not read; the manual class `ltxdoc` is LaTeX base)
- Main file: none. No `.tex` in the zip (ls: README.md, LICENSE.md, uni-titlepage.dtx, 14 PDFs). The sample is embedded in uni-titlepage.dtx: the example document at uni-titlepage.dtx:3260-3545 (docstrip generates `titlepage-*.tex` for 13 styles) and the manual driver at uni-titlepage.dtx:3556-3699 (other samples: none)
- Read: main no `.tex` sample exists; the embedded example (3260-3545) and the manual driver (3556-3699) read in full; zip-local classes and styles all (no `.cls` or `.sty` in the zip; the package and style code inside the `.dtx`, lines 870-3245, read in full; the documentation text 72-870 read in full, the `%` comment lines between code chunks at 1299-2090 only skimmed; the 14 PDFs are compiled output, not read)

## Verdict
The zip is the source of the published CTAN package `uni-titlepage`; its examples only load a published class (`scrbook`) and published packages, then call `\usepackage{uni-titlepage}`, `\TitlePageStyle[..]{Style}` and `\maketitle[key=value]` (uni-titlepage.dtx:3260-3545). That package passes W1 to W4 (CTAN release; behaviour chosen by style name and key=value options; any thesis or book title page; one preamble line plus a body call), so it is proposed as one new way and every other example and manual construct maps to a lib way. The only zip-defined macros are one defensive `\providecommand` in an example and four manual aliases, all reducible; the sample has no ART and no EXTERNAL tool. Caveat: the package code itself holds box/glue, counter and `picture` drawing code (see Bespoke code); it is the published way, not code an emitter reproduces, so the `yes` rests on the W1 ruling for a published package.

## Blockers
none

## Class setting
- Class: `class.scrbook` options: `a4paper,pagesize` (uni-titlepage.dtx:3260). Manual: `class.ltxdoc`, no options (uni-titlepage.dtx:3556).
- Class-native vocabulary used: `scrbook`: `\setkomafont{subject}{..}` and `\setkomafont{title}{..}` (uni-titlepage.dtx:3284, 3368, 3369), option `pagesize`, scrbase `\renewcaptionname` (uni-titlepage.dtx:3488); the package's keys `titlehead` `subject` `dedication` `extratitle` `uppertitleback` `lowertitleback` use `\providecommand` (uni-titlepage.dtx:1233-1235, 1360-1361, 1561-1563, 3024-3025, 3035-3036, 3138-3139), so under a KOMA class the class's own commands of those names win (scrbook source not read). `ltxdoc`: `\DocInput`, `\NewDocElement`, `\CodelineIndex`, `\RecordChanges`, `\EnableCrossrefs`, `\GetFileInfo`, `\MaybeStop`, `\PrintIndex`, `\PrintChanges`, `\DescribeInterfaceMacro`, `\DescribeEnv`, `\changes`, `\Finale` (uni-titlepage.dtx:3570-3592, 3698, 838, 101, 774, 75, 3708).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (examples) | uni-titlepage.dtx:3260 | `class.scrbook` | a4paper, pagesize |
| paper size | uni-titlepage.dtx:3260 | `page.class-options` | a4paper, pagesize |
| language | uni-titlepage.dtx:3261 | `lang.babel` | ngerman (examples); the package ships its terms for the English-family and German-family languages, uni-titlepage.dtx:1801-1919 |
| caption-name override | uni-titlepage.dtx:3488 | `lang.babel` | `\renewcaptionname{ngerman}{\examinationdatename}{Tag der Promotion}` (scrbase command, same job as `\addto\captionsngerman`) |
| font encoding (pdfTeX branch) | uni-titlepage.dtx:3270 | `font.fontenc-t1` | T1 |
| text font (pdfTeX branch) | uni-titlepage.dtx:3271 | `font.lmodern` | default |
| serif and math (TU-HH, TU-DD only) | uni-titlepage.dtx:3272 | `font.palatino` | mathpazo |
| sans (TU-HH, TU-DD only) | uni-titlepage.dtx:3273 | `font.helvet` | helvet, scaled |
| fonts (XeTeX/LuaTeX branch, TU-HH, TU-DD only) | uni-titlepage.dtx:3265-3267 | `font.fontspec` | `\setmainfont{TeX Gyre Termes}`, `\setsansfont{TeX Gyre Heros}`; the `\iftutex` test (iftex) only picks the branch, the emitter prints the branch of its own engine |
| microtype | uni-titlepage.dtx:3275 | `sp.microtype` | defaults (JT-Geschichte only) |
| logo images | uni-titlepage.dtx:3276, 3290-3291, 3395, 3422, 3512 | `fig.graphicx` | `[demo]` option, `\includegraphics[width=57mm,height=27mm]{..}`; logo files are not shipped (assets) |
| colour of variable text | uni-titlepage.dtx:3277-3278, 3287 | `color.xcolor` | `\textcolor{red}{..}` around values, `\colorlet{RED}{red}` |
| KOMA font elements | uni-titlepage.dtx:3284, 3368-3369 | `head.koma-fonts` | `\setkomafont{subject}` and `{title}` = `\sffamily\bfseries` / `\normalfont\sffamily` (title elements, not headings) |
| title block, 13 styles | uni-titlepage.dtx:3260-3545, 2664-3009 | `front.uni-titlepage` | `\usepackage{uni-titlepage}` (3279); `\TitlePageStyle[opts]{Style}` (3282, 3312, 3335, 3351, 3371, 3387-3388, 3419, 3442, 3456, 3470, 3487, 3508; `pagenumber=1` at 3335, 3351, 3371, 3387-3388), Style = DHBW, KOMAScript, Markus-1, Markus-2, Spacer, TU-DD, TU-HH, KIT, JT-Aufsaetze, JT-Geschichte, JT-Typography, WWUM, UKoLa; body `\maketitle[key=value,..]` |
| title string elements | uni-titlepage.dtx:1258-1563 | `front.uni-titlepage` | keys title, author (alias student, 1394), date, subtitle, titlehead, subject, publisher, dedication, university, faculty, chair, professor, advisor, referee, place, academicgrade, discipline, science, matriculationnumber, duration, course, company, homepage, mainlogo, secondlogo, oralexaminationdate; `\and` splits authors or referees |
| subject shortcuts | uni-titlepage.dtx:1360-1380 | `front.uni-titlepage` | subject=project, seminar, studentresearch, diploma, degree, master, bachelor, or a literal string (3356) |
| extra pages around the title | uni-titlepage.dtx:3137-3241 | `front.uni-titlepage` | extratitle, uppertitleback, lowertitleback, dedication (style options; twoside inserts the empty backs, 1109-1111) |
| title-page numbering and page style | uni-titlepage.dtx:990-1004, 1065-1103, 3331 | `front.uni-titlepage` | pagenumber=1, pagestyle (default `empty`); `\TitleOptions{pagenumber=1,blackborder}` between two `\maketitle` calls |
| style-only options | uni-titlepage.dtx:2152, 2158, 2171-2205, 3390 | `front.uni-titlepage` | blackborder (TU-DD), final (TU-HH), rulewidth=2pt, rulesep, rulecolor (Markus-2, Spacer, JT-Aufsaetze, JT-Geschichte) |
| title font hooks | uni-titlepage.dtx:1623-1667, 3373, 3449, 3462, 3510 | `front.uni-titlepage` | titlepagefont, subjectfont, titlefont, subtitlefont (e.g. titlefont=\itshape) |
| full-bleed title environments | uni-titlepage.dtx:1134-1189, 2666, 3184 | `front.uni-titlepage` | `titlepage[pagestyle,pagenumber]`, `fullsizetitle[..]` (DHBW, TU-DD, TU-HH, KIT, WWUM pre-title); respect typearea BCOR or geometry bindingoffset |
| class (manual) | uni-titlepage.dtx:3556 | `class.ltxdoc` | default |
| manual language | uni-titlepage.dtx:3561 | `lang.babel` | english |
| doc elements and commands | uni-titlepage.dtx:3570-3581, 3589-3592, 3698, 838, 3708 | `dtx.doc` | `\NewDocElement[macrolike,toplevel,idxtype,idxgroup,printtype]{InterfaceMacro}{imacro}` and `{Option}{option}`, `\CodelineIndex`, `\RecordChanges`, `\EnableCrossrefs`, `\GetFileInfo{uni-titlepage.drv}`, `\DocInput`, `\MaybeStop{\PrintIndex\PrintChanges}`, `\Finale` |
| manual title | uni-titlepage.dtx:3594-3597 | `front.maketitle` | `\title`, `\author` with `\href{mailto:..}`, `\date{\fileversion{} \filedate}`, `\maketitle` |
| manual abstract | uni-titlepage.dtx:3598-3697 | `abs.kernel` | `abstract` environment |
| manual contents | uni-titlepage.dtx:79 | `toc.kernel` | `\tableofcontents` |
| manual headings | uni-titlepage.dtx:81, 98, 318 | `head.kernel` | `\section`, `\subsection` (ltxdoc default numbering) |
| option table | uni-titlepage.dtx:149-288, 3562 | `tbl.longtable` | `xltabular{\linewidth}{>{\ttfamily}l>{\ttfamily\raggedright}p{.25\linewidth}>{\RaggedRight}X}`, `\endhead`, `\endfoot`, `\endlastfoot`, `\tabularnewline` |
| table rules | uni-titlepage.dtx:151-160, 3564 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| ragged cells | uni-titlepage.dtx:150, 3563 | `sp.ragged` | `\RaggedRight` (ragged2e) |
| example thumbnails | uni-titlepage.dtx:335, 405-413, 3565 | `fig.graphicx` | `\includegraphics[page=1..6,width=.5\linewidth]{titlepage-XX}` (the 13 PDFs are shipped) |
| thumbnail frame | uni-titlepage.dtx:335 | `box.fancybox` | kernel `\frame{..}` around the image |
| side-by-side blocks | uni-titlepage.dtx:325, 352, 394 | `box.minipage` | `\parbox[b][.707\linewidth][t]{.475\linewidth}{\footnotesize ..}` |
| logo macros | uni-titlepage.dtx:3566, 350 | `font.icons` | hvlogos (`\KOMAScript`) |
| lists | uni-titlepage.dtx:294-306, 327-333, 375 | `list.kernel` | `description`, `enumerate` with `\setcounter{enumi}{3}` |
| verbatim | uni-titlepage.dtx:85-87, 297-304, 847-862 | `code.verbatim` | `verbatim` |
| quotes | uni-titlepage.dtx:104-108 | `quote.kernel` | `quote` |
| footnotes | uni-titlepage.dtx:257, 289-292, 719 | `fn.kernel` | `\footnotemark`, `\footnotetext`, `\footref` |
| labels and references | uni-titlepage.dtx:82, 292, 312-313, 795 | `xref.kernel` | `\label`, `\footref` target |
| links | uni-titlepage.dtx:312, 338, 3595 | `xref.hyperref` | `\autoref`, `\autopageref`, `\url`, `\href`; the driver loads no `hyperref` (3561-3566), so it must come from an `ltxdoc.cfg` or build setup that is not in the zip (unverified) |
| margin notes | uni-titlepage.dtx:829, 3567-3569 | `note.marginpar` | `\marginpar{\footnotesize\hfill added in #1}` |
| page breaks | uni-titlepage.dtx:317, 346, 388 | `pg.break` | `\clearpage` |
| inline marks | uni-titlepage.dtx:152, 3588 | `mark.kernel` | `\emph`, `\texttt`, `\textsf` |
| size and spacing in aliases | uni-titlepage.dtx:3567-3569 | `font.size-commands`, `sp.manual-space` | `\footnotesize`, `\hfill` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\providecommand*{\@titlepagefont}{\normalfont\sffamily}` in the DHBW example | uni-titlepage.dtx:3283 | yes | gives the internal font macro the DHBW default value (the style sets the same value only when the macro is defined and empty, uni-titlepage.dtx:2556-2561); the same value is the option `titlepagefont={\normalfont\sffamily}` (1628-1631, used at 3373) of `front.uni-titlepage`. Whether KOMA's `\newkomafont{titlepage}` (1626) makes the macro exist was not checked. |
| `\NewIn`, `\ChangedIn` | uni-titlepage.dtx:3567-3569 | yes | `\leavevmode\marginpar{\footnotesize\hfill added in #1}`: `note.marginpar` + `font.size-commands` + `sp.manual-space`; only `\NewIn` is used (829) |
| `\pkg` (expl3 `tl_if_blank:nTF` via `\csname`) | uni-titlepage.dtx:3582-3587 | yes | inline at each call: `\pkg{x}` = `\href{https://www.ctan.org/pkg/x}{\textsf{x}}`, `\pkg*{x}` = `\textsf{x}`; the test only chooses between these two (`xref.hyperref`, `mark.kernel`) |
| `\File` | uni-titlepage.dtx:3588 | yes | `\texttt` (`mark.kernel`) |
| `doc` version guard `\IfPackageAtLeastTF{doc}{2022/01/01}{}{\errhelp..\errmessage..}` | uni-titlepage.dtx:3557-3560 | yes | prints nothing; a build-time guard, dropped by an emitter (or kept as a kernel call) |
| docstrip driver (`\batchfile`, `\input docstrip.tex`, `\generate`) | uni-titlepage.dtx:876-961 | yes | TeX-only unpacking with LaTeX base `docstrip`, not EXTERNAL; an emitter needs the installed package, not the unpacking; `l3build` (README.md:44-48) is a developer tool, not needed to use the package |
| package internals: title and `fullsizetitle` environments with page-parity and box/glue logic | uni-titlepage.dtx:1065-1103, 1135-1189 | published, not bespoke | inside the CTAN package; the emitter prints only style name and options. If an emitter had to reproduce it with lib ways it would be irreducible (counters, box/glue); this is why the verdict rests on W1 |
| package internals: `picture` page frame (KIT) and `picture` rules (JT-Aufsaetze, JT-Geschichte), `\fbox` black border (TU-DD), `\rule` vertical bar (Markus-2, Spacer) | uni-titlepage.dtx:2864-2880, 2921-2932, 2943-2954, 2737-2743, 2828-2835 | published, not bespoke | artwork inside the published way, chosen by `\TitlePageStyle{KIT}` and similar and tuned by `rulewidth` `rulesep` `rulecolor` `blackborder`; not artwork the sample draws, so not recorded as ART |
| package internals: referee ordinal counters with a redefined `\and`, Markus-2 page style `maintitle`, logo auto-detection with `\IfFileExists` | uni-titlepage.dtx:2897-2903, 2993-3000, 3108-3113, 2611-2618, 2573-2593 | published, not bespoke | same: inside the published way |

## Content-opaque
none. Missing assets: the logo images the examples name are not shipped (`DHBW_d_MOS_195x95_rgb_300.jpg`, 3291; `Logo`, 3395; `KITLogo_RGB`, 3422; `uni-koblenz-landau`, 3513); the examples load `graphicx[demo]` (3276), so black boxes stand in. Ship placeholders if an emitter reproduces the examples.

## Lib changes
- New ways proposed: `front.uni-titlepage` `uni-titlepage` (CTAN, LPPL 1.3c, Markus Kohm; builds on KOMA `scrbase`), pdfLaTeX-compatible. `\usepackage{uni-titlepage}`, `\TitlePageStyle[keys]{Style}` (Style is a closed list of 13 names, a parameter), `\maketitle[key=value]`, `\TitleOptions{..}`; string keys for the title elements, style options `rulewidth` `rulesep` `rulecolor` `blackborder` `final` `extratitle` `uppertitleback` `lowertitleback`, font keys, `pagenumber`, `pagestyle`; environments `titlepage[..]` and `fullsizetitle[..]`. W1: released on CTAN, author's own release, with a manual (README.md:50-57, 80-82; uni-titlepage.pdf is the manual). W2: behaviour is chosen by style name and option values; the `.def` extension API (uni-titlepage.dtx:1675-1693) is not used. W3: serves the title page of any thesis or book, not one document. W4: one preamble line plus a body call. It replaces the kernel `\title` `\author` `\date` `\maketitle` while loaded (uni-titlepage.dtx:1258-1276, 1105). A sibling of `front.hep-title` (a title-page package loaded under another class), not a class way. Considered: filing it as a class-like way (rejected: it is a package loaded under `scrbook`, not a class).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
