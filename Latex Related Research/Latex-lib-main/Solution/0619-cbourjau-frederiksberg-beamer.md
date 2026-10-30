no

# 0619-cbourjau-frederiksberg-beamer: Frederiksberg (KU/LIFE beamer theme for the University of Copenhagen)

- Unverified: read from the source, not compiled.
- Source: Source/0619-cbourjau-frederiksberg-beamer/ (origin: https://codeload.github.com/cbourjau/frederiksberg_beamer/zip/refs/heads/master; licence: not established)
- Kind: presentation
- Lib: v5
- Engine: pdfLaTeX-compatible (KUcommon.sty switches on `\pdfoutput`: T/subtheme/KUcommon.sty:71-98; a DVI + dvips route with PostScript headers also exists, see Bespoke code; optional header font family `ugm` is not shipped)
- Look carried by: zip-local (the whole look is in 22 zip-local beamer theme `.sty` files; only the inner themes `rounded` and `circles` and beamer itself are published)
- Class origin: zip-local
- Main file: none (no `.tex` in the zip; there is no sample deck, so the theme files themselves were analysed; the user guide `FrederiksbergUserGuide-2-2.pdf` could not be read: no PDF renderer here)
- Read: main no-sample, zip-local classes and styles all (22 `.sty`, every line; the 37 dvips `.pro` PostScript files only sampled: `Frederiksberg/dvips/Frederiksberg/KUcommon.pro:1-40`)

Path prefix used below: `T/` = `Frederiksberg/tex/latex/beamer/Frederiksberg/`.

## Verdict
No. The zip is a single-institution beamer theme whose look is carried by zip-local code, not by published packages with parameters. Its core is irreducible: a colour-luminance test that selects logo, line and watermark variants, a hand-built footline, a per-character header text routine, a pgf-drawn logo line, redrawn buttons and navigation symbols, and overrides of beamer internals. A smaller part (colour theme, font theme, margins, frame title, sidebar templates) reduces to `slide.beamer-template` calls. Origin: the theme files are zip-local, because ctan.org/pkg/frederiksberg is a 404 and the zip is a third-party GitHub preservation copy (README.md:3), not an official release; the class a deck loads is `beamer`, tex-distribution-unbundled, source not read.

## Blockers
- `ART/class` logo line drawn as pgf rectangles whose segments and colours depend on sidebar widths and background luminance (T/subtheme/KUcommon.sty:249-253, 254-302)
- `ART/class` scaled beamer button shape drawn with a pgf curve path (T/general/beamerinnerthemescaledbuttons.sty:159-183)
- `ART/class` redrawn navigation symbols, `\pgfdefobject` arrows and `pgfpicture` wrappers (T/general/beamerouterthemescalenavigationsymbols.sty:50-62, 71-147; loaded only with option `navsymbols`, T/beamerthemeFrederiksberg.sty:275, 342-344)
- `BESPOKE/class` colour-luminance test: sums the RGB parts as lengths against `1.5in` and drives logo variant, line colour, watermark colour and title-page images (T/subtheme/KUcommon.sty:147-160, used at 181-198, 259-299, 364-413; T/subtheme/beamerinnerthemeKUtitlepage.sty:163-170; T/general/beamerouterthemeframehandouts.sty:44-51)
- `BESPOKE/class` footline builder with box-and-glue, sidebar-dependent conditionals and global per-frame flags (T/subtheme/KUcommon.sty:434-721, esp. 481-542, 574-695)
- `BESPOKE/class` header text routine: token-level loops that upper- or lowercase and letter-space the name character by character, with hacks for Danish accents (T/subtheme/KUcommon.sty:750-825)
- `BESPOKE/class` title-page templates and image-slot macros with star and optional-argument parsing, fractions of `\paperwidth`, a `\KU@rawps` PostScript special and edits of `\beamer@frametopskip` (T/subtheme/beamerinnerthemeKUtitlepage.sty:78-142, 147-297, 299-361)
- `BESPOKE/class` overrides of beamer and LaTeX internals: `\beamer@calculateheadfoot` wrapper (T/subtheme/KUcommon.sty:60-65), plain-frame `\ps@empty` (T/general/beamerouterthemecleanplain.sty:14-29), `\beamer@sectionintoc` (T/general/beamerinnerthemecompacttoc.sty:13-46, opt-in), `\beamer@thc@prepcolor` use (T/general/beamerouterthemeframehandouts.sty:42-47), fixed-point scale arithmetic and `\insert*symbol` redefinitions (T/general/beamerinnerthemescaledbuttons.sty:63-82, 107-126)
- `BESPOKE/class` `\enumref` delimiter-driven label parser (T/ML/beamerinnerthemeMLHacks.sty:12-51; opt-in, not loaded by the main theme)
- `BESPOKE/class` free-code hook slots for unit and course packages, `\RequirePackage{FrederiksbergUnit#1}` and `\g@addto@macro` injection (T/beamerthemeFrederiksberg.sty:49-63, 280-285, 322, 356; T/units/template/FrederiksbergUnittemplate.sty:26-50); unit and course files are not in the zip

## Class setting
- Class: `class.beamer` (no sample, so no class options seen); the deck would load the theme as `\usetheme[options]{Frederiksberg}` (file name at T/beamerthemeFrederiksberg.sty:41; install note README.md:6-13).
- Class-native vocabulary used by the theme: `\mode<presentation>` and `\mode<handout>` (T/beamerthemeFrederiksberg.sty:287; T/general/beamerouterthemeframehandouts.sty:22-23), plain frames (`\ifbeamer@plainframe`, T/subtheme/beamerinnerthemeKUtitlepage.sty:153), `\title` `\subtitle` `\author` `\institute` `\date` `\titlegraphic` through `\inserttitle` `\insertsubtitle` `\insertauthor` `\insertinstitute` `\inserttitlegraphic` (T/subtheme/beamerinnerthemeKUtitlepage.sty:259-277), `\insertframenumber` `\inserttotalframenumber` (T/subtheme/KUcommon.sty:476-480), `\defbeamertemplate` `\setbeamertemplate` `\addtobeamertemplate`, `\setbeamercolor` `\setbeamerfont` `\setbeamersize`, `beamercolorbox`, `\usebeamercolor` `\usebeamerfont`, `\insertverticalnavigation` (T/subtheme/beamerouterthemeKUsidebar.sty:97), `\logo`.
- Theme options (all parameters of one theme): `style=standard|simple|clean|alternative`, `dk|uk`, `life|nat|sund|samf|ku`, `logostyle`, `logoline`, `logoplace`, `footstyle=high|low`, `totalframes`, `nologo`, `noline`, `footsep`, `fnolabel`, `headstyle`, `ugm`, `wmark` `wmarkvariant` `wmarkcolour`, `TPlrimage` `TPulimage` `TPrawlrimage` `TPomitframeno`, `FTbeamer` `FTalign`, `wide|narrow`, `sidebar=<width>`, `hideothersubsections`, `hideallsubsections`, `colourful`, `greytext` `greyfoot` `greyauthor` `greybg`, `seriftitles`, `navsymbols`, `noframes`, `unit`, `course`, `not@ku` (T/beamerthemeFrederiksberg.sty:57-277).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | README.md:6-13; T/beamerthemeFrederiksberg.sty:41, 287 | `class.beamer` | no sample; theme-only package |
| theme entry and options | T/beamerthemeFrederiksberg.sty:57-277, 290-319 | `slide.beamer-theme` | `\usetheme{Frederiksberg}` with the options listed above; the theme and its `KU*` subthemes are zip-local, so only the beamer mechanism is the way (W1 fails for the themes themselves, see Bespoke code) |
| published inner themes | T/beamerthemeFrederiksberg.sty:346-347 | `slide.beamer-theme` | `\useinnertheme{rounded}`, `\useinnertheme{circles}` |
| colour definitions | T/subtheme/KUcommon.sty:110-127 | `color.xcolor` | `\definecolor` HTML: KULIFEbrown 541800, KUNATgreen 325d3d, KUSUNDblue 2a216a, KUSAMForange e13218, KUFARMAblue 007c92, KUred 901a1e, KUbggrey eceeec; KUgrey gray 0.4; logo colours by `named`; not@ku: KU@logo 004000, KU@topbar 006000 (T/beamerthemeFrederiksberg.sty:241-242) |
| colour theme | T/subtheme/beamercolorthemeKUhorse.sty:36-108 | `slide.beamer-template` | `\setbeamercolor` structure fg=KU@<faculty>logo; background canvas bg=white or KUbggrey (option greybg); sidebar bg=KUbggrey or logo!20!white; normal text fg=black or KUgrey (greytext); footline, page number, title/author/institute/date in head/foot parents; block title fg=white bg=logo colour; block body bg=block title.bg!15!white; example text fg=KUgrey!25!green; option colourful switches to red/green/blue |
| font theme | T/subtheme/beamerfontthemeKU.sty:16-23 | `slide.beamer-template` | `\setbeamerfont{footline}{size=\Tiny}`, `{description item}{series=\bfseries}`; seriftitles: frametitle `family=\rmfamily,series=\bfseries,size=\LARGE`, framesubtitle `size=\large`, title and subtitle `parent` |
| margins | T/subtheme/beamerouterthemeKUmargins.sty:17-23; T/subtheme/beamerouterthemeKUsidebar.sty:107-108 | `slide.beamer-template` | `\setbeamersize{text margin left/right=.1138\paperwidth}` (`wide`: `.08\paperwidth`; sidebar mode: `5pt`); `\setbeamersize` is taken as the same `\setbeamer*` family |
| header text font | T/subtheme/KUcommon.sty:807, 816 | `font.nfss`, `font.size-commands`, `mark.kernel` | option `ugm`: `\fontencoding{T1}\fontfamily{ugm}\fontshape{n}\fontseries{bx}\fontsize{5.4}{5.4pt}\selectfont`; else `\rmfamily\scshape\mdseries\fontsize{7.2}{7.2pt}\selectfont`; the text routine itself is bespoke (row below) |
| headline (grey top bar) | T/subtheme/beamerouterthemeKUhead.sty:19-23; T/subtheme/KUcommon.sty:856-873 | `slide.beamer-template` | `\defbeamertemplate*{headline}{KU}` calls the bespoke `\KU@head`; bar `\vrule height.028\paperwidth width\paperwidth` in KU@topbar; university and faculty names as images `height=.012\paperwidth` (T/subtheme/KUcommon.sty:826-855) |
| footline and page number | T/subtheme/beamerouterthemeKUfoot.sty:15-33; T/subtheme/KUcommon.sty:434-721 | `hf.class-native` | footline set by theme options `footstyle=low|high`, `logoplace=left|right`, `totalframes`, `sep`, `fnolabel`, `noline`, `nologo`; the builder is bespoke (blockers) |
| empty right sidebar | T/subtheme/beamerouterthemeKUfoot.sty:35-40 | `slide.beamer-template` | `\defbeamertemplate*{sidebar right}{KU empty}{}` |
| frame title | T/subtheme/beamerouterthemeKUframetitle.sty:21, 24-45 | `slide.beamer-template` | `\defbeamertemplate{frametitle}{KU}[1][left]`: `beamercolorbox[sep=0.3cm,#1,wd=\textwidth+0.6cm]{frametitle}`, `\vskip-1ex`, `\strut`, subtitle in framesubtitle font; option FTbeamer: `\setbeamertemplate{frametitle}[default][align]` |
| sidebar navigation | T/subtheme/beamerouterthemeKUsidebar.sty:10-11, 22-109 | `slide.beamer-template` | width `0.2\paperwidth` default (`width=` option), `\setbeamersize{sidebar width left=...}`, section/subsection/subsubsection templates as `beamercolorbox[wd=\KU@sidebarwidth,leftskip=3pt|5pt|7pt,rightskip=1ex plus1fil,vmode]`, left sidebar template with short title, author, institute and `\insertverticalnavigation` |
| title page | T/subtheme/beamerinnerthemeKUtitlepage.sty:147-361 | `front.class-native`, `slide.beamer-template` | `\defbeamertemplate{title page}{KU standard|KU clean|KU simple}` printing title, subtitle, author, institute, titlegraphic in the title/subtitle/author/institute fonts and colours; corner images `height=.078\paperwidth`, `width=.375\paperwidth`, `width=.29\paperwidth`; layout code bespoke (blockers) |
| watermark | T/subtheme/beamerouterthemeKUwmark.sty:27-39; T/subtheme/KUcommon.sty:414-423 | `slide.beamer-template` | `background canvas` template `KU wmark`: full-page rule in the canvas colour, sigil image `height=\paperheight` at the right edge; colour `bg!96!black` or `bg!85!white` chosen by the luminance test (bespoke) |
| navigation symbols | T/subtheme/beamerouterthemeKUnavsymbols.sty:13-18 | `slide.beamer-template` | `\usebeamertemplate***{navigation symbols}` scaled by `.7`; scaling code is bespoke |
| handout frame | T/general/beamerouterthemeframehandouts.sty:22-59 | `slide.beamer-mode` | handout mode, `\addtobeamertemplate{background canvas}` adds a black frame, stroke `0.003\paperwidth`, `mode=smart|force`; internals bespoke |
| compact contents | T/general/beamerinnerthemecompacttoc.sty:49 | `slide.beamer-template` | `\setbeamerfont{subsection in toc}{size=\footnotesize}` (opt-in; the `\beamer@sectionintoc` override at 13-46 is bespoke) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option routing, `style=` resolution | T/beamerthemeFrederiksberg.sty:57-319 | partly | An emitter resolves the chosen options to the end state and writes the `\setbeamer*` and template calls; the end state still needs the irreducible items below |
| `\ProcessOptionsBeamer` and `\KV@errx` wrappers | T/subtheme/KUcommon.sty:10-16; T/beamerthemeFrederiksberg.sty:67-74 | yes | no printed effect (unknown options warn instead of error); drop |
| once-only image registry `\KU@declareimage` | T/subtheme/KUcommon.sty:33-55 | yes | declare each shipped image once with `\pgfdeclareimage`; no lib way needed beyond the image file |
| dvips mode `\KU@dvipsheader`, `\KU@rawps`, `\KU@pssetup` and `.pro` prologues | T/subtheme/KUcommon.sty:71-98; T/subtheme/beamerinnerthemeKUtitlepage.sty:219; Frederiksberg/dvips/Frederiksberg/KUcommon.pro:1-15; README.md:11 | not needed under pdfLaTeX | the pdf branch defines these as empty (T/subtheme/KUcommon.sty:93-98); the DVI route needs dvips and the `.pro` files, an outside-TeX route that is not counted as a blocker because pdfLaTeX does not use it |
| luminance test `\KU@colortest` | T/subtheme/KUcommon.sty:147-160 | no | computes a sum of RGB lengths and compares with `1.5in`; no lib way computes a variant from a colour |
| language and names tables | T/subtheme/KUcommon.sty:25-27, 133-142, 472; T/subtheme/beamerthemeKUsetup.sty:13-14, 38-47 | yes | strings (`Dias`/`Slide`, university and faculty names) resolved at emit time and written as text; no lib way needed |
| logo `\KUlogo`, `\KU@lineAndLogo` | T/subtheme/KUcommon.sty:163-209, 254-340 | no | pgf-drawn line of up to three coloured segments plus a logo image positioned from `\Gm@lmargin`, `\beamer@leftsidebar`; considered `sp.rule` for a fixed background only |
| watermark colour logic `\KUwmark@initcolor` | T/subtheme/KUcommon.sty:364-413 | no | luminance test and PostScript colour definitions; placement of the sigil alone would be a canvas template (considered `bg.background`) |
| footline builders `\KUfoot@text`, `\KUfoot@low`, `\KUfoot@high` | T/subtheme/KUcommon.sty:481-695 | no | conditional box-and-glue driven by sidebar widths, frame flags `\KUfootOnTitlepage` `\KUfootOmitFrameNo` `\KUfootOmitLogos` `\KUfootOmitLine` (T/subtheme/KUcommon.sty:696-719) and `\Gm@lmargin`; copying it would copy zip-local macro logic |
| header text `\KU@dotoptext` and loops | T/subtheme/KUcommon.sty:750-825 | no | per-character case change and `\hspace*{.6ex|.38ex}` spacing with accent hacks; considered `mark.case` plus `\textls` of `sp.microtype`, which is not the same effect |
| title-page image macros `\KUtitlepageLRimage` `\KUtitlepageULimage` `\KUtitlepageRawLRimage` | T/subtheme/beamerinnerthemeKUtitlepage.sty:78-142 | no | `\@ifnextchar *` and optional-argument parsing into image names plus `\pgfdeclareimage`; the `-` and empty-means-default protocol is hand-rolled |
| title-page templates | T/subtheme/beamerinnerthemeKUtitlepage.sty:147-361 | no | `\raisebox`/`\rlap` offsets, `\newif` inside a template (152), `\global\beamer@frametopskip` (150), PostScript special (219) |
| frame title, sidebar and head/foot template declarations | T/subtheme/beamerouterthemeKUframetitle.sty:24-45; T/subtheme/beamerouterthemeKUsidebar.sty:22-105 | yes, except one internal call | `slide.beamer-template` with free box code over `beamercolorbox`; `\beamer@nav@subsectionstyle` (T/subtheme/beamerouterthemeKUsidebar.sty:13-14) is a beamer internal, the published `sidebar` outer theme options set the same state |
| colour theme and font theme | T/subtheme/beamercolorthemeKUhorse.sty:36-108; T/subtheme/beamerfontthemeKU.sty:16-23 | yes | `\setbeamercolor` and `\setbeamerfont` with the values in the map |
| scaled buttons | T/general/beamerinnerthemescaledbuttons.sty:63-82, 101-141, 146-187 | no | fixed-point arithmetic in counts and dimens, redefined `\insertgotosymbol` etc., pgf button path |
| navigation symbol scaling | T/general/beamerouterthemescalenavigationsymbols.sty:32-147 | no | `\pgfdefobject` drawing and redefinition of beamer's `\insert*navigationsymbol` commands |
| clean plain frame | T/general/beamerouterthemecleanplain.sty:14-29 | no | redefines `\ps@empty` with `\@oddhead` boxes of beamer internals |
| compact toc | T/general/beamerinnerthemecompacttoc.sty:13-46 | no | redefines `\beamer@sectionintoc` (copy of beamer's with changed skips) |
| frame handouts | T/general/beamerouterthemeframehandouts.sty:27-59 | no | pgf stroke plus use of `\beamer@thc@prepcolor` and a colour compare |
| pgf compatibility shim | T/general/MLsupportoldpgf.sty:8-25 | yes | no printed effect on a current pgf; drop |
| `\multilinedate` | T/ML/beamerinnerthemeMLHacks.sty:68-70 | yes | `\raisebox{0pt}[\baselineskip][0pt]{\parbox[b]{\textwidth}{...}}`; no lib id given (opt-in file) |
| `\ghostframe` | T/ML/beamerinnerthemeMLHacks.sty:56-61 | partly | counter half is `\only<1>{\global\advance\c@framenumber by -1}`; the `\KUfootOmitFrameNo` half belongs to the bespoke footline |
| `\enumref` | T/ML/beamerinnerthemeMLHacks.sty:12-51 | no | delimited-argument parser `\getenumlabels##1.##2.##3.##4*` that picks a template level |
| unit and course hook slots | T/beamerthemeFrederiksberg.sty:49-63; T/units/template/FrederiksbergUnittemplate.sty:26-50 | no | arbitrary code injected through `\g@addto@macro`; the template file ships only comments |

## Content-opaque
- Logo, sigil, watermark and corner images shipped as EPS, PDF and JPG under `Frederiksberg/tex/latex/beamer/Frederiksberg/graphics/{KU,LIFE,NAT,SAMF,SUND}/` (used through `\pgfuseimage`, e.g. T/subtheme/KUcommon.sty:197, 421); assets, shipped with the zip.
- 37 dvips PostScript prologues `Frederiksberg/dvips/Frederiksberg/**/*.pro` (sigil and logo paths for the DVI route; not read beyond the first 40 lines of `KUcommon.pro`).
- No `.tex` body exists, so no figures, tables or equations to record.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
