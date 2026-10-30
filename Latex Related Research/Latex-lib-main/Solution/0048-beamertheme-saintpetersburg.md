yes

# 0048-beamertheme-saintpetersburg: Saint Petersburg (SPbU) Beamer theme

- Unverified: read from the source, not compiled.
- Source: Source/0048-beamertheme-saintpetersburg/ (origin: https://mirrors.ctan.org/macros/latex/contrib/beamer-contrib/themes/beamertheme-saintpetersburg.zip; licence: lppl1.3c)
- Kind: presentation
- Lib: v1
- Engine: needs XeLaTeX (the sample loads `polyglossia`, example.tex:2; the theme's `fontspec` branch runs only under XeTeX, beamerfontthemeSaintPetersburg.dtx:37; the theme alone also runs under pdfLaTeX with babel, README.md:17-31)
- Look carried by: class (a published CTAN beamer theme, `\usetheme{SaintPetersburg}`, on `beamer`; its style sources ship here as .dtx and are on CTAN and in TeX Live as `beamertheme-saintpetersburg`, so not zip-local; the sample preamble adds no look)
- Class origin: tex-distribution-unbundled
- Main file: example.tex (other samples: SaintPetersburg.dtx, an `ltxdoc` documentation driver)
- Read: main yes, zip-local classes and styles all

Abbreviations below: E = example.tex, T = beamerthemeSaintPetersburg.dtx, C = beamercolorthemeSaintPetersburg.dtx, F = beamerfontthemeSaintPetersburg.dtx, D = SaintPetersburg.dtx. The class source (`beamer`) was not read; it is not in the zip.

## Verdict
Yes. The look comes from the published CTAN theme `SaintPetersburg` (checked once: ctan.org/pkg/beamertheme-saintpetersburg, in TeX Live and MiKTeX), loaded by one `\usetheme`, which is `slide.beamer-theme` with the name as parameter. Read as source, the theme is only `\setbeamertemplate`, `\setbeamercolor`, `\setbeamerfont`, `\definecolor`, `fontspec` calls and short template bodies built from spacing, centring and beamer inserts, so every piece reduces to lib ways. The weakest point is the faded coat-of-arms on page 1 (a TikZ node, placement only, image not shipped), which reduces to a watermark-type background (`bg.background`). One new way is proposed, `lang.translator`. This is evidence about the beamer-theme dimension as much as about component ways.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `14pt`, `aspectratio=169` (E:1)
- Class-native vocabulary used: `\frame{...}`, `frame` env with `\frametitle`/`\framesubtitle`, `\title` `\subtitle` `\author` `\date`, `\maketitle` inside a frame, `\sectionpage`, `\AtBeginSection[]`, overlays `\only<n>`, built-in `example` block, `\alert`, `columns`/`column` envs.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | E:1 | `class.beamer` | 14pt, aspectratio=169 |
| paper and base size | E:1 | `page.class-options` | aspectratio=169, 14pt |
| language | E:2-3 | `lang.polyglossia` | `\setdefaultlanguage{english}` (README.md:24-31 shows babel as the pdfLaTeX alternative) |
| theme loading | E:4, T:44, T:349, F:160 | `slide.beamer-theme` | `\usetheme{SaintPetersburg}` no options; it loads `\usefonttheme{SaintPetersburg}`, `\usecolortheme{SaintPetersburg}`, `\usefonttheme{professionalfonts}`; options `poster`, `nologo` (T:35-36), poster adds `\usefonttheme{serif}` (F:171) |
| colour palette | C:31-40 | `color.xcolor` | `\definecolor` spbuTerracotta cmyk .08,.91,.92,.33; spbuGray cmyk .21,.11,.09,.22; spbuWhite1 RGB 245,246,245; spbuWhite2 230,231,230; spbuWhite3 217,218,217; spbuWhiteRed2 255,231,230; spbuWhiteRed3 255,160,160; spbuRed 200,40,40; spbuDarkGray HTML 404040; spbuDarkGray2 HTML 5F7177 |
| beamer colour roles | C:45-108 | `slide.beamer-template` | `\setbeamercolor`: normal text fg=spbuDarkGray bg=spbuWhite1; frametitle and title fg=spbuTerracotta bg=spbuWhite1; block title fg=spbuDarkGray bg=spbuWhite3; block body bg=spbuWhite2; alerted blocks red; example blocks; section/part/subsection page parent=frametitle; item parent=normal text; caption and head/foot parents |
| solid slide background | C:76, C:112-116 | `slide.beamer-template` | `\beamertemplatesolidbackgroundcolor{spbuWhite1}`, white under `poster` |
| faded logo on title page | T:49-69 | `bg.background` | page 1 only (`\ifnum\thepage=1`); contents `\includegraphics[width=0.7\paperwidth,trim=0 55 10 0,clip]{CoA_Medium.eps}`; opacity=0.1; anchor south east at the page's south east; guarded by `\IfFileExists`; the EPS is not in the zip (README.md:11-13); other pages get a solid canvas-colour rule (T:66) |
| fonts, XeTeX branch | F:37-141 | `font.fontspec` | `\setmainfont` OpenSans (Extension=.ttf, UprightFont=*-Regular, BoldFont=*-Bold, ItalicFont=*-Italic, BoldItalicFont=*-BoldItalic, Mapping=tex-text); `\setromanfont` OldStandard (.otf); `\setsansfont` OpenSans; `\setmonofont` FiraMono (.otf); `\newfontfamily` `\cyrillicfont`, `\cyrillicfontrm/sf/tt`, `\rmfamily`, `\sffamily`, `\ttfamily`; under `poster` main font OldStandard (F:45-58) |
| mono face package | F:31 | `font.mono` | `\RequirePackage{FiraMono}` (unconditional) |
| sans face package | F:32 | `font.helvet` | `\RequirePackage{opensans}` (sans text-face package is the parameter; unconditional) |
| beamer font roles | F:146-159, 176-187 | `slide.beamer-template` | `\setbeamerfont`: note page size=\small; structure, tiny structure, toc entries family=\sffamily; block title/body series=\mdseries, block title alerted \bfseries; abstract size=\normalsize; title, subtitle size=\Large; author size=\large; poster: frametitle series=\bfseries size=\Large, caption size=\normalsize, bibliography size=\small |
| title data | E:34-37 | `front.maketitle` | `\title`, `\author`, `\date` (kernel names) |
| title block | E:35, E:41, T:84-94 | `front.class-native` | `\subtitle`, `\frame{\maketitle}`; template `title page`: `\centering`, `\vspace{0.2\textheight}`, title, `\vskip0.5\baselineskip` subtitle if set, `\vskip\baselineskip` author, `\vfill` institute, `\vfill\inserttitlegraphic`, `\vfill` date |
| title page body wrappers | T:84-94, T:74-79 | `sp.manual-space` | `\vspace`, `\vskip`, `\vfill` in the template (with `sp.ragged` `\centering`) |
| frame title | E:46, T:99-104 | `slide.beamer-template` | `\setbeamertemplate{frametitle}`: frametitle field, then framesubtitle if set; no background bar |
| navigation symbols | T:109-110 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` (empty) |
| sectioning | E:43, E:113, E:253 | `head.class-native` | `\section{...}` of beamer: navigation entry and section page, no inline heading in non-poster mode |
| section divider frame | E:21-32, C:68-70 | `slide.beamer-section-hook` | `\AtBeginSection[]{\frame{\sectionpage}}`; commented-out ToC lines E:22-30 are not active |
| overlays | E:47, E:54, E:72, E:89 | `slide.beamer-mode` | `\only<1>` to `\only<4>` |
| example block | E:55, E:73, T:162-175, C:60-61 | `thm.class-native` | beamer built-in `example`; template `block example begin/end`: `\vspace{-\baselineskip}`, `flushright`, `beamercolorbox[colsep*=.75ex]` for title and body |
| block and alert templates | T:126-157 | `slide.beamer-template` | same shape for `block` and `block alerted`; not used by the sample body |
| theorem, proof, QED templates | T:180-200 | `slide.beamer-template` | `qed symbol` = `$\blacksquare$`; theorem/proof templates reuse the block env; not used by the sample body |
| amsthm loaded | E:6 | `thm.amsthm` | loaded only, no `\newtheorem` in the sample |
| emphasis | E:97, E:234 | `slide.beamer-template` | `\alert{...}`; the theme sets no `alerted text` colour (only block alerted colours, C:58-59), so beamer's default applies |
| math | E:7-9, E:49-224 | `math.amsmath` | `equation*`, `array`, `\sum\limits`, `\left\right`, `\qquad`, `\displaystyle` |
| math add-ons | E:8-9, E:151 | `math.mathtools` | package loaded; `\vdotswithin` used (E:151-192) |
| math symbols | E:7 | `math.amssymb` | loaded |
| labels | E:51, E:58 | `xref.kernel` | `\label` inside `equation*`, never referenced |
| lists | E:91, E:104, E:244, E:257 | `list.kernel` | `itemize`, `enumerate`; bullet colour from `\setbeamercolor{item}{parent=normal text}` (C:55) |
| table | E:268-279, E:312-318 | `tbl.tabular` | `tabular{ll}`, no float, no caption |
| table rules | E:11, E:269-278, E:315 | `tbl.booktabs` | `\toprule \midrule \bottomrule \addlinespace` |
| images | E:12, E:15, E:313-328 | `fig.graphicx` | `\graphicspath{{figures/}}`; `\includegraphics[scale=0.5]` inside `tabular`, no float, no caption |
| beamer columns | E:308-331 | `class.beamer` | native `columns`/`column` envs, each `0.5\textwidth` (a pdf-neutral alternative is `cols.minipage`) |
| text alignment | E:96, E:233, E:266, E:307, E:310, E:321 | `sp.ragged` | `\centering`, `center` env |
| vertical fill and breaks | E:96, E:109, E:134, E:232, E:242, E:265 | `sp.manual-space` | `\vfill`, `\newline` |
| size switches | E:132, E:143, E:201, E:267, E:306 | `font.size-commands` | `\small` |
| listings, tikz loaded | E:10, E:13 | `code.listings` | loaded only, no listing in the sample |
| tikz loaded | E:13, T:50 | `art.tikz` | `\usepackage{tikz}` only; the sample draws nothing; the theme uses a TikZ node as a placement vehicle for the logo (reduced above) |
| speaker note page | T:115-120 | `slide.beamer-template` | `note page` = `minipage` 0.85\paperwidth around the note field; not used by the sample (`box.minipage`) |
| bibliography item marker | T:205, T:338, C:81-86 | `slide.beamer-template` | marker removed; `[text]` under `poster`; colours parent=normal text, location and journal fg=spbuDarkGray2; sample has no bibliography |
| abstract | T:210-214, T:226-232, C:91-92 | `slide.beamer-template` | `abstract title` = font, colour, `\abstractname.`; under `poster` `minipage` with `\justifying` (`sp.ragged`); not used by the sample |
| poster headline | T:267-289 | `slide.beamer-template` | three beamer `columns` (left/middle/right widths .2/.6/.2 `\linewidth`), `\vskip2cm`, title `\huge`, author `\Large`, institute `\large`; `poster` only |
| poster footline rule | T:294-310 | `sp.rule` | TikZ `\fill [spbuTerracotta] (0,0) rectangle (\textwidth,0.1cm)` = a `\textwidth` x 0.1cm rule in spbuTerracotta; `poster` only |
| poster section commands | T:315-333 | `head.kernel` | `\renewcommand{\section}`/`\subsection`: centred, spbuTerracotta, bold `\Large` (sub: bold slanted `\large`), `\justifying`, `\setlength{\parindent}{1.5cm}`; uses `color.xcolor`, `mark.kernel`, `sp.lengths`; `poster` only |
| Russian keyword names | T:354-365 | `lang.translator` | `\newtranslation[to=russian]{Part}{Часть}` and 11 more (Section, Subsection, Theorem, Proof, Corollary, Definition(s), Fact, Lemma, Example(s)); inactive for the English sample |
| documentation driver | D:15-80 | `class.ltxdoc` | `\DocInput` of the three .dtx (D:205-207); not part of the look |
| doc driver links | D:22-26 | `meta.hyperref` | colorlinks, link/menu/page/url colour spbuTerracotta |
| doc driver listings | D:27-45 | `code.listings` | language=[LaTeX]{TeX}, basicstyle=\ttfamily, keyword/comment/string colours, breaklines |
| doc driver fonts | D:47-74 | `font.fontspec` | OldStandard main/roman, OpenSans sans, FiraMono mono (same `fontspec` options as F) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\spbuInsertField` helper | T:74-79 | yes | `\usebeamerfont`, `\usebeamercolor[fg]`, the beamer insert macro, `\par`: inlined in each template body (`slide.beamer-template`) |
| `\newif` flags, `\DeclareOption{poster,nologo}`, `\ProcessOptions` | T:31-37 | yes | the emitter writes the theme option or not (`slide.beamer-theme`); `nologo` is a no-op in code: `\if@spbuLogo` is never tested (grep over all files) |
| title page and frame title bodies with `\ifx\insertsubtitle\empty` | T:84-94, T:99-104 | yes | spacing and centring plus beamer inserts; the conditional is "subtitle given or not", known at emit time |
| block, alert, example templates | T:126-175 | yes | `flushright` + `beamercolorbox[colsep*=.75ex]` title and body: `slide.beamer-template`, `sp.manual-space`, `sp.ragged` |
| page-1 background template | T:52-68 | yes | `bg.background`: contents = the logo image with width/trim/clip, opacity=0.1, position south east, first page only; `\beamer@leftmargin` and `\ifnum\thepage=1` are internals the way replaces; TikZ is placement only (no paths drawn) |
| poster abstract, headline, footline | T:226-232, T:267-310 | yes | see poster rows above; `columns` env + spacing + `sp.rule`; not exercised by the sample |
| poster `\section`, `\subsection` redefinition | T:315-333 | yes | `head.kernel` `\renewcommand` of format only (no counter, no ToC entry), as in the row above |
| `\othergraphic`, `\leftcolumnwidth`, `\middlecolumnwidth`, `\rightcolumnwidth` | T:237-261 | yes | `\gdef` stores of a graphic and three lengths (defaults .2/.6/.2 `\linewidth`); the emitter writes those values straight into the headline columns |
| `\justifying` in poster templates | T:228, T:321, T:331 | yes | `sp.ragged` (`ragged2e`); the zip never loads `ragged2e`, so it relies on beamer or the user loading it (not verified) |
| `\ifxetex` engine switch, `ifxetex` package | F:33, F:37-141 | yes | the emitter picks the XeTeX branch (`font.fontspec`) or the Type1 packages (`font.mono`, `font.helvet`) by engine |
| `\newfontfamily\rmfamily`, `\sffamily`, `\ttfamily` | F:121-140 | yes | `font.fontspec` families with the same OldStandard/OpenSans/FiraMono options; `\setmainfont` etc. above already cover the roles |
| `\newcommand{\Fourier}`, `\InverseFourier`, `\Var` | E:17-19 | yes | `\newcommand` aliases of math notation (`math.amsmath`), content-level |
| docstrip driver | SaintPetersburg.ins:15-59 | yes | runs in TeX (`docstrip`), not an outside tool; the README's `make` (README.md:8-13) is only an install wrapper not shipped here; the published package installs the generated `.sty` |
| font theme source ends without `\Finale`/`\endinput` | F:194 | yes | file read to its last line (194); no effect on the look |

## Content-opaque
- Eight QQ-plot EPS files in figures/ (E:313-328): figure artwork, content.
- The SPbU coat-of-arms `CoA_Medium.eps` is not in the zip (README.md:11-13): a missing asset to ship, not content; the theme guards it with `\IfFileExists` (T:59).
- Fonts OldStandard, OpenSans, FiraMono are not shipped in the zip; assumed supplied by the TeX distribution or the system (not verified).
- Equation bodies and table cell data (E:49-224, E:268-279): content.

## Lib changes
- New ways proposed: `lang.translator` the CTAN `translator` package (in TeX Live; checked once at ctan.org/pkg/translator; beamer's own keyword dictionary mechanism), command `\newtranslation[to=<lang>]{<key>}{<text>}`, engine pdf (the Cyrillic strings need a Cyrillic-capable setup, here polyglossia under XeLaTeX). W1: package on CTAN. W2: only language, key and string values. W3: a generic keyword-translation dictionary, not tied to one document. W4: printable as preamble lines. It has no home in `lang.babel` (caption-name overrides use `\addto\captions<lang>`, a different mechanism) or `lang.projlib`; a consolidator may fold it into a babel/polyglossia caption-names way if it prefers.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
