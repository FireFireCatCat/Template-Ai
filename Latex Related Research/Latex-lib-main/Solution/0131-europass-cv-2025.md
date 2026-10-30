yes

# 0131-europass-cv-2025: Europass CV (2025)

- Unverified: read from the source, not compiled.
- Source: Source/0131-europass-cv-2025/ (origin: https://latextemplates.com/downloads/europasscv2025.zip; licence: LPPL-1.3c)
- Kind: cv
- Lib: v2
- Engine: pdfLaTeX-compatible (the class detects the engine: `helvet` under pdfTeX, europasscv2025.cls:102-106; `fontspec` with a system "Helvetica" only under XeLaTeX/LuaLaTeX, europasscv2025.cls:107-113; the class header says all three work, europasscv2025.cls:19-20)
- Look carried by: class (the sample defines nothing; the whole look is the CTAN class `europasscv2025`, picked by two class options)
- Class origin: ctan
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (europasscv2025.cls 740 of 740 lines, colors/*.def 7 files, locale/*.def 2 files)

## Verdict
The look is carried entirely by the class `europasscv2025`, which is a published CTAN package (ctan.org/pkg/europasscv2025: Lorenzo Calisti, version 0.1 dated 2026-05-20, LPPL-1.3c, package PDF and example PDF on CTAN; the copy in the zip carries the same date, europasscv2025.cls:23). The sample defines no macro, counter or environment of its own and uses only class options and class-native commands (main.tex:7-94), so an emitter writes `\documentclass[english,color-default]{europasscv2025}` plus the class commands and copies no zip-local logic. The class is not zip-local, so its internals (a TikZ header band and photo ring, a header-height measuring routine, a leader-line heading) are the class's own work and are not counted as blockers (second pilot ruling). Caveat: I read the zip copy but did not diff it against the CTAN release; if the copy differs from CTAN, those internals (europasscv2025.cls:355-374, 379-451, 455-500) would be `ART/class` and `BESPOKE/class` and the answer would be `no`.

## Blockers
none

## Class setting
- Class: `class.europasscv2025` options: `english` (language file, europasscv2025.cls:49), `color-default` (colour scheme, europasscv2025.cls:54); both given at main.tex:7. Other options the class declares and the sample does not use: `italian` (europasscv2025.cls:50), `color-darkblue` `color-blue` `color-darkgreen` `color-green` `color-darkviolet` `color-violet` (europasscv2025.cls:55-60), `nologo` (europasscv2025.cls:41), `nototpages` (europasscv2025.cls:45), `debug` (europasscv2025.cls:37, loads `showframe`, europasscv2025.cls:88); any other option is passed to `article` (europasscv2025.cls:63). Base class: `\LoadClass[a4paper]{article}` (europasscv2025.cls:66), written `class.article` below.
- Class-native vocabulary used: `\ecvphoto{file}` (main.tex:11); `ecvinfo` environment with `\ecvname`, `\ecvnationality`, `\ecvaddress[label]{}`, `\ecvphone`, `\ecvemail`, `\ecvwebsite`, `\ecvsocial{name}{url}` (main.tex:13-27); `\ecvsection{title}` (main.tex:29, 55, 72, 79); `\ecventry{title=,organization=,location=,date=,description=}` and its starred form `\ecventry*` (main.tex:31-70); `ecvlanguages` environment with `\ecvmothertongue{}`, `\ecvlanguage{name}{5 levels}`, `\ecvcefrlevels` (main.tex:73-77); `ecvskills[title]` environment with `\ecvskill{}` (main.tex:81-94). Declared by the class and not used by the sample: `\ecvdateofbirth`, `\ecvgender`, `\ecvim` (europasscv2025.cls:235, 236, 279), the `link=` entry key (europasscv2025.cls:554, 590-593), `ecvdrivinglicences` with `\ecvdrivinglicence` (europasscv2025.cls:726-741), colour setters `\ecvaccentcolor` ... `\ecvtablesepcolor` (europasscv2025.cls:154-164).

## Component map
Rows marked "inside class" are set by the published class, not written by the emitter; they are listed so the class's own look is accounted for.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:7; europasscv2025.cls:23 | `class.europasscv2025` | options `english`, `color-default` |
| base class (inside class) | europasscv2025.cls:66 | `class.article` | `a4paper`; unknown options forwarded (europasscv2025.cls:63) |
| paper size (inside class) | europasscv2025.cls:66, 137 | `page.class-options` | `a4paper` |
| page geometry (inside class) | europasscv2025.cls:126-143 | `page.geometry` | left=right=14mm, top=bottom=10mm, includefoot=true |
| footer (inside class) | europasscv2025.cls:169-188, 192 | `hf.fancyhdr` | style `ecv@footer`: `\fancyhf{}`, headrulewidth 0pt, `\fancyfoot[R]` = logo then page count; applied by `\AtBeginDocument{\pagestyle{ecv@footer}}` |
| footer options | europasscv2025.cls:40-45, 173-186 | `hf.class-native` | class options `nologo`, `nototpages` switch the footer parts |
| page X of Y (inside class) | europasscv2025.cls:75, 183 | `pgnum.lastpage` | `Page~\thepage/\pageref*{LastPage}` in `ecv@color@text` |
| footer logo (inside class) | europasscv2025.cls:175-177 | `fig.graphicx` | `\includegraphics[height=4mm]{europass_logo.pdf}` raised by `-0.20\height` (asset shipped in the zip) |
| paragraph spacing (inside class) | europasscv2025.cls:189-190 | `sp.lengths` | `\parindent`=0pt, `\parskip`=0pt |
| manual vertical and horizontal space (inside class) | europasscv2025.cls:175, 343, 445, 533, 535, 570, 587, 646 | `sp.manual-space` | `\vspace` 4 to 16pt, `\hspace{4pt}` and `\hspace{0.5em}` (europasscv2025.cls:178), `\raisebox` |
| line break in entry text | main.tex:38, 40, 50 | `sp.manual-space` | kernel `\newline` between description lines (content use) |
| ragged text (inside class) | europasscv2025.cls:77, 401, 496 | `sp.ragged` | `ragged2e` `\RaggedRight` in the header block |
| microtype (inside class) | europasscv2025.cls:83 | `sp.microtype` | `expansion=false` |
| fonts, pdfTeX path (inside class) | europasscv2025.cls:102-106 | `font.fontenc-t1` | `[T1]{fontenc}`, `[utf8]{inputenc}` |
| sans text face (inside class) | europasscv2025.cls:105 | `font.helvet` | `helvet` |
| default family (inside class) | europasscv2025.cls:106, 112 | `font.family-default` | `\familydefault` = `\sfdefault` |
| fonts, XeLaTeX/LuaLaTeX path (inside class) | europasscv2025.cls:109-111 | `font.fontspec` | `\setmainfont{Helvetica}`, `\setsansfont{Helvetica}`; chosen by `\ifPDFTeX` (europasscv2025.cls:28, 102) |
| type sizes (inside class) | europasscv2025.cls:343, 532, 581, 649 | `font.size-commands` | `\LARGE` name, `\footnotesize` section and details, `\small` mother tongue |
| text marks (inside class) | europasscv2025.cls:343, 532, 574, 621 | `mark.kernel` | `\textbf` on name, section title, entry title, language name |
| colour scheme | main.tex:7; europasscv2025.cls:53-60, 148-151; colors/ecv_default.def:20-30 | `color.xcolor` | 11 colours by HTML value (accent F5F5F5, text 5A5959, border 000000, title 505050, info 000000, infolink 005AA0, section 000000, highlight 505050, link 005AA0, tableitem 000000, tablesep 696969); selected by class option, 7 schemes in colors/ |
| colour setters, body text colour (inside class) | europasscv2025.cls:154-164, 191 | `color.xcolor` | `\definecolor{...}{HTML}{#1}` wrappers; `\normalcolor` = `ecv@color@text` |
| language labels | main.tex:7; europasscv2025.cls:49-50, 118-121; locale/ecv_english.def:20-38 | `class.europasscv2025` | class option `english` or `italian` picks a file of 19 label strings; no `babel` or `polyglossia` is loaded |
| hyperlinks (inside class) | europasscv2025.cls:91-96, 203-208 | `meta.hyperref` | `colorlinks=true`, `allcolors=ecv@color@link`; `\href` on each url |
| underlined url (inside class) | europasscv2025.cls:85, 206 | `mark.ulem` | `[normalem]{ulem}`, `\uline` |
| header block and personal info | main.tex:13-27; europasscv2025.cls:223-350, 504-520 | `front.class-native` | `ecvinfo` environment, name in `\LARGE` `ecv@color@title`, info items joined by ` | ` (europasscv2025.cls:198-200, 295) |
| header band behind the info (inside class) | europasscv2025.cls:455-500 | `front.class-native` | full-width band in `ecv@color@accent`, height computed from content; drawn by the class with TikZ, never by the emitter |
| photo | main.tex:11; europasscv2025.cls:213-218, 355-374 | `fig.class-native` | `\ecvphoto{photo.png}`; slot size 3.5cm, circular crop with an accent ring and a border ring (the image is content) |
| section heading | main.tex:29, 55, 72, 79; europasscv2025.cls:527-541 | `head.class-native` | `\ecvsection{title}`: `\footnotesize\textbf` in `ecv@color@section`, 12pt above, a leader rule to the margin |
| experience and education entries | main.tex:31-70; europasscv2025.cls:546-595 | `cv.entries` | `\ecventry{title,organization,location,date,description[,link]}`; starred form puts date and location in highlight colour and the description in `\footnotesize` |
| language grid | main.tex:73-77; europasscv2025.cls:600-678 | `cv.entries` | `ecvlanguages`: mother tongue line, then a 6-column grid (name, listening, reading, spoken production, spoken interaction, writing), accent row colour, `\arraystretch`=2, optional CEFR legend (inside the class it is `tabularx` plus `colortbl`) |
| skills lines | main.tex:81-94; europasscv2025.cls:684-711 | `cv.entries` | `ecvskills[title]` with `\ecvskill{}` items joined by ` | `, in `ecv@color@highlight` |
| driving licences (not used) | europasscv2025.cls:717-741 | `cv.entries` | `ecvdrivinglicences` and `\ecvdrivinglicence{}` |
| packages the class loads for itself | europasscv2025.cls:28-29, 71-91 | `class.europasscv2025` | `iftex` `etoolbox` `xcolor` `graphicx` `geometry` `fancyhdr` `lastpage` `tikz` `ragged2e` `array` `tabularx` `booktabs` `colortbl` `longtable` `microtype` `pgfkeys` `ulem` `tcolorbox` `xparse` `hyperref`; none needs a tool outside TeX (no `minted`, no shell escape) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| macros, counters, environments in the sample | main.tex:1-96 | none exist | the sample has only `\documentclass`, content and class commands |
| the class and its `\ecv@*` macros (pgfkeys entry parser, list accumulators, TikZ header band and photo ring, header height from a measured savebox, language-row arithmetic, leader-line heading) | europasscv2025.cls:198-741 | not zip-local: published CTAN class | counted as the one way `class.europasscv2025`; not decomposed; see the caveat in Verdict |
| locale files (string tables) | locale/ecv_english.def:20-38; locale/ecv_italian.def:20-38 | reducible | class option `english` or `italian` |
| colour scheme files (11 `\definecolor` lines each, 7 files) | colors/ecv_default.def:20-30 and colors/ecv_blue.def, ecv_darkblue.def, ecv_darkgreen.def, ecv_darkviolet.def, ecv_green.def, ecv_violet.def | reducible | class options `color-*`, or `color.xcolor` HTML values |

The CTAN page shows the package directory (macros/latex/contrib/europasscv2025) but not its file tree, so whether `colors/`, `locale/` and `europass_logo.pdf` sit in the CTAN package in this layout is not established; the class finds them by relative path (europasscv2025.cls:118, 148, 176), so they must ship beside `main.tex` (README.md:12-13 says they are vendored).

## Content-opaque
- `photo.png`, an 800x800 placeholder portrait included by `\ecvphoto` (main.tex:11), is figure artwork, content.
- No TikZ or other drawing appears in the sample; the TikZ drawing is inside the class (europasscv2025.cls:355-374, 455-500).
- Missing assets: the system font "Helvetica" for XeLaTeX/LuaLaTeX (europasscv2025.cls:110-111) is not shipped; the pdfTeX path needs none. The README says the class was absent from the pinned TeX Live image (README.md:17-21), so it is shipped in the zip.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
