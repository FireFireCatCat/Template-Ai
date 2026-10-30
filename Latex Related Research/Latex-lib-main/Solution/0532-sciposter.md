yes

# 0532-sciposter: sciposter (scientific poster class, v1.18)

- Unverified: read from the source, not compiled.
- Source: Source/0532-sciposter/ (origin: https://mirrors.ctan.org/macros/latex/contrib/sciposter.zip; licence: LPPL per the manifest and ctan.org/pkg/sciposter; README and class header carry no licence text)
- Kind: poster
- Lib: v4
- Engine: pdfLaTeX-compatible (README:8-10 says it works for LaTeX and pdfLaTeX; the dvips `\special{papersize}` is issued only when `pdfoutput` is undefined, sciposter.cls:530-532; no fontspec or other xe/lua package)
- Look carried by: class (`sciposter.cls` defines page, sizes, title block, boxed headings, captions, figures, footer; the sample adds `amsmath`, `amssymb`, `multicol`, `epsfig`, one `\newtheorem` and content)
- Class origin: ctan (ctan.org/pkg/sciposter: v1.18, maintainer Michael Wilkinson, LPPL, in TeX Live and MiKTeX; the zip is the CTAN bundle, and the class in it is the CTAN file, loaded unchanged)
- Main file: sciposterexample/sciposter-example.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (`sciposter.cls` 982 lines and the eight `paper*.cfg`; `scipostermanual.pdf` not read, no PDF renderer here; `sciposterexample/auto/sciposter-example.el` is an AUCTeX cache, not LaTeX)

- Citations: `sample:N` is `sciposterexample/sciposter-example.tex:N`; `cls:N` is `sciposter.cls:N`; both relative to `Source/0532-sciposter/`.

## Verdict
yes. The look is carried by `sciposter.cls`, a class released on CTAN and used unchanged, so it is one published way, `class.sciposter` (W1). The sample's own additions are `\usepackage` lines for published packages, one kernel `\newtheorem`, one `\newcommand` length alias and hand-written `thebibliography` content, all reducible. There is no TikZ, PGF, PSTricks or `picture` code and no tool outside TeX: the boxed section titles are `\colorbox` and `shadow`'s `\shabox` (published), and every included image has a `.pdf` beside its `.eps`. Residual doubt, recorded not decided: the class loads `a0size.sty` unconditionally (cls:293); it is not in the zip and ctan.org/pkg/a0size is a 404, so that its source is published and shipped with TeX Live is not established here. Class internals that would be irreducible if the class were zip-local are listed under Bespoke code.

## Blockers
none

## Class setting
- Class: `class.sciposter` options: none given in the sample (sample:1); the class defaults are `portrait,a0,final` (cls:261) and `boxedsections` (`\secstyle`, cls:100). Options the class declares: sizes `a0` `a1` `a2` `a3` `ansiC` `ansiD` `ansiE` `tabloid` (cls:124-220), `landscape` `portrait` (221-226), `draft` `final` (227-232), point sizes `14pt` `17pt` `20pt` `25pt` `30pt` `36pt` (233-256), `largefonts` (102), `boxedsections` `ruledsections` `plainsections` `plainboxedsections` (106-121); any other name is read from `paper<name>.cfg` (cls:259: `b0`-`b3`, `ra0`-`ra2`, `custom`).
- Class-native vocabulary used by the sample: `\institute` (sample:34), `\email` (37), `\conference` (56), `\maketitle` (72), the `abstract` environment (78), `\section` (88), `\PARstart` (90), `figure` (102), `algorithm` (246), `\caption` (113).
- Class vocabulary the class defines, not called by the sample: `\leftlogo[scale]{file}` and `\rightlogo` (cls:902-930; sample:43-44 commented), `\noleftlogo` `\norightlogo` `\nologos` (940-958), `\LEFTSIDEfootlogo` (573; sample:59 commented), `\setmargins[len]` (301), `\subsection` (772-785), `\subfigure` (797-805), caption hooks `\mastercapstartstyle` `\mastercapbodystyle` `\figcapstartstyle` `\tablecapstartstyle` `\algcapstartstyle` and their body twins (808-817; sample:65-70 commented), `\algorithmname` (835), colours `mainCol` `BoxCol` `TextCol` `SectionCol` (521-524; sample:12-20 commented).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | sample:1; cls:69-71 | `class.sciposter` | `\LoadClass{article}` underneath; no options passed |
| paper, orientation, draft/final | cls:124-135, 261-270 | `page.class-options` | defaults `a0` (83.96cm x 118.82cm), `portrait`, `final`; `landscape` swaps width and height (265-270) |
| margins | cls:301-334 | `class.sciposter` | native `\setmargins[len]`, called once at class load: `\papermargin` = 0.06`\paperwidth`, text block = paper minus 2 margins, `\headheight` = `\headsep` = 0, `\footskip` = 0.65`\papermargin` (a `page.setlength` effect inside the class; the sample never calls it) |
| type size | cls:126, 273-288, 418-444 | `page.class-options`, `font.size-commands` | `a0` implies 25pt (options `14pt`..`36pt`, `largefonts` change it); the class re-defines `\tiny` .. `\Huge` with `\fontsize`, e.g. `\normalsize` 24.88/30, `\Huge` 61.92/77, new `\veryHuge` 74.3/93, `\VeryHuge` 89.16/212 (cls:430; the 212 reads like a typo for 112) |
| spacing parameters | cls:437-444, 512, 894 | `sp.lengths` | `\smallskipamount` 6pt, `\medskipamount` 12pt, `\bigskipamount` 24pt, `\abovecaptionskip` 25pt, display skips 25pt plus 6pt minus 15pt, `\belowdisplayskip`=`\abovedisplayskip`, `\parindent`=0cm |
| text faces | cls:294, 900 | `font.mathptmx`, `font.family-default` | package `times` (text faces only), then `\familydefault` = `\sfdefault`: running text in the sans face; no math font package |
| colours | cls:291, 521-524 | `color.color` | package `color`; `mainCol` 1,1,1; `BoxCol` 0.9,0.9,0.9; `TextCol` 0,0,0; `SectionCol` 0,0,0; overrides in the sample are commented out (sample:12-20) |
| page background | cls:535 | `color.pagecolor` | `\pagecolor{mainCol}` at `\AtBeginDocument` |
| running head and foot | cls:533, 581-594; sample:56-57 | `hf.pagestyle-kernel`, `hf.class-native` | `\pagestyle{empty}` then `\@oddfoot` = footlogo, `\hfill`, conference text (or swapped by `\LEFTSIDEfootlogo`); the sample's `\conference{...}` sets one string, set `\footnotesize` |
| text columns | sample:7, 75, 351; cls:887-893 | `cols.multicol` | `multicols{3}` around abstract to bibliography; the class sets `\columnsep` 0.0385`\textwidth` and `\columnseprule` 0.0025`\textwidth` |
| title block | sample:28, 31, 72; cls:596-626 | `front.maketitle` | `\title` `\author` `\maketitle`: `\titlesize` bold title at `\baselinestretch` 3.3, bold `\authorsize` author, `\instsize` institute, optional left and right logo minipages (width `\logowidth` = 0.12`\textwidth`), `\titleskip` below; `\date` unused (sample:39) |
| institute, e-mail | sample:34-37; cls:553, 932-938 | `front.class-native` | `\institute{...}` with `\\` line breaks; `\email{...}` printed in `\texttt` |
| logos | sample:43-44 (commented); cls:902-930 | `front.class-native` | `\leftlogo[0.9]{file}` and `\rightlogo` print `\resizebox{#1\textwidth}{!}{\includegraphics{#2}}`; not used in the sample, so the title block has empty logo slots (cls:558-567) |
| abstract | sample:78-85; cls:787-789 | `abs.kernel` | the class re-defines `abstract` as `\section*{\abstractname}` then `\it`; set inside `multicols` |
| section headings | sample:88, 125, 185, 230, 298; cls:630-647, 649-665, 758-770 | `head.class-native` | default `boxedsections`: centred bold title in a `\colorbox{BoxCol}` minipage of width `\columnwidth`-1cm, number `\arabic{section}.~` printed by hand after `\refstepcounter{section}`, `\secskip` = `\bigskipamount` above, 0.375 `\secskip` below; `\section*` drops the number (used by `abstract`); other options `ruledsections`, `plainsections`, `plainboxedsections` (cls:688-755) |
| heading box internals | cls:292, 636, 884-885 | `box.fancybox` | `\shabox{\colorbox{...}}` with `\sboxrule` 2pt, `\sboxsep` 0pt: package `shadow` (ctan.org/pkg/shadow, LPPL 1.2, TeX Live) is a drop-shadow `\fbox` analogue; written by the class, never by the emitter |
| subsection headings | cls:772-785 | `head.class-native` | bold `\subsectionsize`, number `section.subsection`; not used in the sample |
| drop capital | sample:90; cls:73, 964 | `sp.lettrine` | `\PARstart{G}{ranulometries}` is the class alias `\newcommand{\PARstart}[2]{\lettrine{#1}{#2}}`; package `lettrine`, default keys |
| inline marks | sample:56, 93, 98, 238 | `mark.kernel` | `\emph`, `{\bf ...}`, `{\tt S}`, `{\em ...}` (bibliography: 325-344) |
| list | sample:237-240 | `list.kernel` | `itemize` with two `\item`; the class changes no list parameter |
| definitions | sample:10, 129-141, 143-152, 190-197 | `thm.kernel` | `\newtheorem{Def}{Definition}`, used as `\begin{Def}` three times; `amsthm` is not loaded |
| display maths | sample:5, 134-139, 146, 155-158, 217-223 | `math.amsmath` | `align`, `equation`, `\intertext`, `\label` inside `align` rows |
| math symbols | sample:6, 128 | `math.amssymb` | `amssymb`; `\mathbb` in the text |
| figures | sample:102-120, 173-182, 260-275, 283-296; cls:820-833 | `fig.graphicx` | `figure` (the class makes it a non-floating `\columnwidth` minipage with `\figtopskip`/`\figbotskip` = `\secskip`; the `[h]` argument is ignored), `\resizebox{\imsize}{!}{\includegraphics{name}}`; `epsfig` loaded (sample:4) but `\epsfig` and `\psfig` are never called; extension-less names resolve to the shipped `.pdf` under pdfLaTeX |
| image grids | sample:104-111, 262-269 | `tbl.tabular` | `tabular{c c}` of images and typed `(a)` `(b)` labels; the class's own `\subfigure` (cls:797-805) is not used |
| captions | sample:113, 178, 252, 271, 292; cls:808-817, 867-880 | `cap.kernel` | class `\caption[frac]{text}`: bold "Figure n:" label, italic body, `\centerline` when it fits on one line, else a paragraph; label strings come from `\figurename` `\tablename` and `\algorithmname`; hooks unchanged in the sample |
| algorithm box | sample:246-254; cls:835-851, 295 | `class.sciposter` | native `algorithm` environment: counter `algorithm`, `boxedminipage` of `\columnwidth`, caption below, name "Algorithm"; no lib line for a class's own float, so it is held as class vocabulary (the `algorithm`/`algorithmic` packages are not loaded) |
| cross-references | sample:119, 135-138, 179, 224, 244 | `xref.kernel` | `\label` and `\ref`; `\refstepcounter` in the class makes section, figure and algorithm labels work |
| bibliography | sample:319-349 | `bib.thebibliography` | five `\bibitem` entries with `\newblock`; `\bibliographystyle{plain}` at 319 has no `\bibliography` call, so BibTeX is not run; `\cite` keys as cited |
| class dependencies | cls:72-73, 290-295 | `class.sciposter` | `ifthen`, `lettrine`, `graphics`, `color`, `shadow`, `a0size`, `times`, `boxedminipage`; all but `a0size` are standard published packages; `a0size.sty` is neither in the zip nor on ctan.org/pkg (404), see Verdict |

Absent from the sample and the class: language and metadata packages (no `babel`, no `hyperref`), footnotes, index, code listings, tables beyond the image grid, glossaries.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\imsize}{0.45\columnwidth}` and `\renewcommand{\imsize}{0.3\columnwidth}` | sample:101, 282 | yes | a length alias; inlined as the `\resizebox` width in `fig.graphicx` (0.45 then 0.3 of `\columnwidth`) |
| `\newtheorem{Def}{Definition}` | sample:10 | yes | `thm.kernel` |
| `\renewcommand{\maketitle}` (logo minipages, `\baselinestretch` 3.3) | cls:596-626 | n/a, published class | `class.sciposter`; would be BESPOKE/class if the class were zip-local |
| `\renewcommand{\caption}` with `\setbox0=\hbox` and `\ifdim\wd0>\hsize` | cls:867-880 | n/a, published class | the "centre it when it fits on one line" test is a box-measuring conditional that drives the output: BESPOKE/class under a zip-local reading |
| `\renewenvironment{figure}`, `table`, `\newenvironment{algorithm}`, `\newcounter{algorithm}` | cls:820-865, 835-851 | n/a, published class | class float vocabulary; non-floating minipages |
| `\renewcommand{\@oddfoot}` in `\setfooter`, `\conference` | cls:581-594 | n/a, published class | kernel-internal redefinition: BESPOKE/class under a zip-local reading |
| section commands `\Section` `\sSection` `\PlainSection` `\RuledSection` `\PlainBoxSection` and the `\secdef` choice by `\secstyle` | cls:630-770 | n/a, published class | option-driven heading looks; each is `\colorbox`, `\shabox`, `\fbox`, `\rule` and `\vspace` in a centred minipage |
| nested `\ifthenelse` chain that picks the size set from `\fontpointsize` | cls:273-288, 336-509 | n/a, published class | six fixed size tables; a conditional that drives the printed sizes |
| `\setmargins` raw `\setlength` of `\textwidth`, `\hoffset`, `\voffset`, `\topmargin` | cls:301-334 | n/a, published class | `page.setlength` type, inside the class |
| `\AtBeginDocument{... \pagestyle{empty} \setfooter \pagecolor{mainCol}}` | cls:527-536 | n/a, published class | `hf.pagestyle-kernel`, `color.pagecolor` |
| `paper*.cfg` files (b0-b3, ra0-ra2, custom) | paperb0.cfg:4-13 and siblings | n/a, published class | option files setting `\paperwidth`, `\paperheight`, `\fontpointsize`; `papercustom.cfg:4` asks the user to edit it, a W2 caveat for custom paper only; the sample does not use any cfg |
| `\endinput` at cls:967 | cls:967-969 | n/a | the trailing `\color{TextCol}` at cls:969 is never read |

These class rows are not blockers: W1 counts a CTAN-released class as published and the sample uses it unchanged, so an emitter writes `\documentclass{sciposter}` and the body wrappers, and copies none of this logic. A reader who counts the class as zip-local gets `BESPOKE/class` from the caption test, the footer redefinition and the size-table conditionals, and would reverse the verdict.

## Content-opaque
none. The 14 distinct images named by the 16 `\includegraphics` calls (`blocks1` .. `blocksopen3vy`, `sciposterexample/sciposter-example.tex:105-290`) are figure artwork, content; each has a `.pdf` (and an `.eps`) in `sciposterexample/`.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
