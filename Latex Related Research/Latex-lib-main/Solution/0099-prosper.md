no

# 0099-prosper: Prosper (slide class, PSTricks and seminar based)

- Unverified: read from the source, not compiled.
- Source: Source/0099-prosper/ (origin: https://mirrors.ctan.org/macros/latex/contrib/prosper.zip; licence: lppl1.2, LPPL 1.2 or later stated at prosper.cls:5-11)
- Kind: presentation
- Lib: v1
- Engine: needs latex + dvips + ps2pdf (DVI/PostScript pipeline, not pdfLaTeX-compatible; TODO:12 lists "pdflatex support" as a wanted fix, doc/prosper-doc.tex:376-416 documents the dvips and Ghostscript set-up)
- Look carried by: class (frames, fonts, bullets, footer and overlay machinery all sit in prosper.cls and its PPR*.sty styles, which ship in the CTAN package; the sample adds only option settings and, in the tour, bespoke colour macros)
- Class origin: ctan (the zip is the CTAN `prosper` package itself, so no extra ctan.org read was spent)
- Main file: doc/prosper-tour.tex, the demo deck that loads the class (other samples: doc/prosper-doc.tex, the manifest's pick, an `article` manual of the class; doc/doc-examples/Example.tex and its `Example<Style>.tex` copies; contrib/gyom.tex; contrib/rico.tex; doc/rotation.tex)
- Read: main yes, zip-local classes and styles all

## Verdict
Not recoverable from the lib. `class.prosper` is a published CTAN class, so the class itself is one way. Three things still block a `yes`. The class only produces its PDF through latex, dvips and ps2pdf or Distiller (`EXTERNAL`). Every style draws its page frame, bullets and gradients as PSTricks code or imported PostScript art, which is template-defining artwork (`ART`). The tour sample's preamble holds colour-mixing macros built on PSTricks internals (`BESPOKE`). The manual `doc/prosper-doc.tex` alone is a plain `article` document and would reduce to lib ways, but the zip is the class, not that manual.

## Blockers
- `EXTERNAL/class` Output needs latex -> dvips -> ps2pdf (or Distiller), not a TeX engine alone. hyperref is loaded with the `ps2pdf` driver by default (prosper.cls:59-61, 67, 77-87). Bookmarks and page rotation are raw PostScript `\pdfmark` (prosper.cls:106-127, 139-141). Overlay masking is PostScript through `\pst@Verb` (prosper.cls:507-508). The manual requires a `.dvipsrc` and `GS_OPTIONS` outside TeX (doc/prosper-doc.tex:398-416; FAQ:81-87).
- `ART/class` Each style's page frame is PSTricks drawing code (`\psframe`, `\pspolygon`, gradients) plus imported `.ps`/`.eps` bullet and rule art: PPRautumn.sty:67-85, PPRazure.sty:64-77, PPRalienglow.sty:45-55, PPRlignesbleues.sty:69-80, PPRnuancegris.sty:67-96, PPRtroispoints.sty:51-70, PPRdefault.sty:49-66. `art.pstricks` is a restricted way, and used for the template's own identity it is `ART`. Choosing a shipped style by name is declarative for the user, but each style is a separate hand-drawn program. Dropping this one blocker would not change the verdict.
- `BESPOKE/preamble` `\ColoredOverlappedSurfaces`, `\DecodeRGBFirstColor`, `\DecodeRGBSecondColor`, `\BuildMixedColor` compute a mixed colour with `\pst@getnumiii`, `\pst@dimz` and `\pst@dimtonum` under `\makeatletter` (doc/prosper-tour.tex:14-79). The code does arithmetic that drives what is printed, so it is irreducible. It sits only in the tour sample.

## Class setting
- Class: `class.prosper` options: `pdf`, a style name (`autumn`, which loads PPRautumn.sty via prosper.cls:63-65, 378-381), `slideColor`, `colorBG`. Other options: `ps`, `draft`/`final`, `slideBW`, `total`/`nototal`, `nocolorBG`, `accumulate`, `noFooter`, `distiller`, `YandY`, `ps2pdf`, `vtex` (prosper.cls:25-67). Defaults: `final,slideBW,total,nocolorBG,noaccumulate,ps,ps2pdf` (prosper.cls:67).
- Base class: prosper.cls:72 loads `seminar` with `portrait,semlayer,semcolor,leqno`. seminar is a published class outside the zip and was not read. The `\blue`, `\green`, `\black` colour macros and `\rput` also come from outside the zip (seminar's colour and layer chain and PSTricks); not read.
- Class-native vocabulary used: `\title` `\subtitle` `\author` `\institution` `\email` `\maketitle`; `slide[transition]{title}`; `\overlays{n}{..}`; `\onlySlide` `\onlySlide*` `\OnlySlide` `\fromSlide*` `\FromSlide`; `itemstep`; `\part`; `\slideCaption` `\Logo` `\LogoPosition` `\displayVersion`; `\FontTitle` `\FontText` `\FontSubtitle` `\ColorFoot` `\myitem` `\titleSpacing`; `\NewSlideStyle` `\PDFCroppingBox` `\PutLogo` `\slidetitle` (style authoring); `\PDForPS` `\onlyInPS` `\onlyInPDF`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | doc/prosper-tour.tex:1; prosper.cls:25-72 | `class.prosper` | pdf, autumn, slideColor, colorBG |
| page size and orientation | prosper.cls:72, 77-78, 89-92 | `page.class-options`, `page.setlength` | seminar `portrait`, hyperref `a4paper`; `\slidewidth=222mm`, `\slideheight=150mm`, `\slideleftmargin=0.01in` |
| crop box and page rotation | prosper.cls:131-147; PPRautumn.sty:88 | `meta.hyperref` (`pdfpagescrop`); EXTERNAL part is the `/Rotate 90` pdfmark | `\PDFCroppingBox{10 35 594 830}` |
| PDF viewer set-up | prosper.cls:77-87 | `meta.hyperref` | driver=ps2pdf, bookmarks, pdfhighlight=/I, pdffitwindow, pdfcenterwindow, pdfstartview=Fit |
| slide transitions | prosper.cls:155-167; doc/prosper-tour.tex:158, 212 | `meta.hyperref` via `class.prosper` | `pdfpagetransition` = Split, Blinds, Box, Wipe, Dissolve, Glitter or R; default `R` |
| slide structure | prosper.cls:242-260, 302-303; doc/prosper-tour.tex:95-233 | `class.prosper` | `slide[trans]{title}`: seminar slide, minipage of `\slideWidth`, `raggedright`, text font |
| slide text area and style hook | prosper.cls:305-311; PPRautumn.sty:87 | `class.prosper` | `\NewSlideStyle[11.6cm]{t}{5.4,3}{BSquareFrame}` (width, anchor, rput position, frame macro) |
| slide title heading | prosper.cls:209-210; PPRautumn.sty:61-62, 90 | `head.class-native` | `\rput[lb](-.7,3.8)` `\parbox{11.5cm}`, `\titleSpacing{\vspace*{20pt}}` |
| title slide | prosper.cls:433-484; doc/prosper-tour.tex:82-92 | `front.class-native` | `\maketitle` = slide with title, subtitle (16pt italic default), author, email (7pt `\texttt`), institution |
| overlays | prosper.cls:507-670, 710-739; doc/prosper-tour.tex:109, 128, 157, 185, 211 | `class.prosper` | `\overlays{n}`, `\fromSlide`/`\onlySlide`/`\untilSlide` (starred and capital forms); PostScript masking |
| step-wise list | prosper.cls:404-415; doc/prosper-tour.tex:113-121 | `class.prosper` | `itemstep[start]` |
| section divider slide | prosper.cls:770-776 | `class.prosper` | `\part[transition]{text}`, centred `\fontTitle` |
| footer and page number | prosper.cls:367-376, 418-431; PPRautumn.sty:58 | `hf.class-native` | caption = `\slideCaption` or title, `p.\thepage/last@page` with `total`, draft line, `noFooter`, `\ColorFoot{\colD}` |
| logo | prosper.cls:343-360; PPRautumn.sty:65 | `class.prosper` | `\LogoPosition{-1,-1.1}`, `\Logo(x,y){..}`, `\rput[lb]` |
| title and text fonts | PPRautumn.sty:27, 51-56; PPRdefault.sty:31-36, 62 | `font.mathptmx`, `font.helvet`, `font.family-default`, `font.size-commands` | `times`, `semhelv`; title `\usefont{T1}{ptm}{b}{n}` 20.74pt/20pt; text `\usefont{T1}{ptm}{m}{n}` 14.4pt/13pt; `\ptsize{14}` (prosper.cls:835) |
| text colours | PPRautumn.sty:29-48; doc/prosper-tour.tex:7-8, 12-13, 84 | `art.pstricks` | `\newrgbcolor{goldenrod}{.80392 .60784 .11373}`, `\newgray`; colour switches `\colC` chosen by `\ifinColor`, `\ifcolorBG`. PSTricks colours, not `xcolor`. |
| page frame, background gradient, rules | PPRautumn.sty:67-78 | `art.pstricks` (ART) | `\psframe[fillstyle=gradient,gradbegin=\colB,gradend=\colA,gradmidpoint=1](-2,-1.4)(12.5,9)`; `\psline[linewidth=3pt]` |
| list bullets | prosper.cls:314-341; PPRautumn.sty:80-85; PPRdefault.sty:64-66 | `list.kernel` with label set by `\myitem`; artwork is `art.pstricks` (ART) | level 1-3 labels as `\psframe` squares or `\includegraphics[width=.4cm]{red-bullet-on-white.ps}` |
| itemize and center override | prosper.cls:390-402 | `list.kernel` | `itemize` wrapped in `Itemize` + `raggedright` |
| graphics loading | prosper.cls:70; PPRdefault.sty:64-66 | `fig.graphicx` | `graphicx` before seminar; `.ps` and `.eps` files |
| PSTricks packages | doc/prosper-tour.tex:4 | `art.pstricks` | `pstricks`, `pst-node`, `pst-text`, `pst-3d` |
| input encoding | doc/prosper-tour.tex:3 | `font.fontenc-t1` | `\usepackage[latin1]{inputenc}` |
| mode switches | prosper.cls:781-803 | `class.prosper` | `\PDForPS`, `\onlyInPS`, `\onlyInPDF` (via `\ifDVItoPS`) |
| display maths | doc/doc-examples/Example.tex:19, 27-29; doc/prosper-tour.tex:5, 137, 191 | `math.amsmath`, `math.amssymb`, `math.eqnumber` | `amsmath`; each style loads `amssymb` (PPRautumn.sty:26); seminar `leqno` (prosper.cls:72) |
| labels and links | doc/prosper-tour.tex:84, 103, 191, 204, 231-232 | `xref.kernel`, `xref.hyperref` | `\label`/`\eqref`; `\href`, `\hyperlink`, `\hypertarget`. The class overrides `\label` to act only in overlay 1 (prosper.cls:684-705) |
| text marks and sizes | doc/prosper-tour.tex:111, 133, 136, 159, 190 | `mark.kernel`, `font.size-commands` | `\texttt`, `\emph`; `\small`, `\tiny`, `\scriptsize` |
| manual: class and packages | doc/prosper-doc.tex:2, 5-7, 13, 36-38 | `class.article`, `color.color`, `font.mathptmx`, `font.fontenc-t1`, `idx.makeidx`, `fig.graphicx`, `box.fancybox`, `math.amssymb`, `art.pstricks` | `color`, `times`, `textcomp`, `index`; `fancybox` and `pstricks` loaded, not drawn with in the body |
| manual: hyperref | doc/prosper-doc.tex:8-12 | `meta.hyperref` | ps2pdf, bookmarks, colorlinks, urlcolor=blue, citecolor=blue, linkcolor=blue, pagecolor=blue |
| manual: title, abstract, sections | doc/prosper-doc.tex:40-57, 95 | `front.maketitle`, `tbl.tabular`, `abs.kernel`, `head.kernel` | author block is a `tabular{cc}`; `\date{}` |
| manual: lists, code, floats | doc/prosper-doc.tex:61, 113, 267, 284, 103-110, 389-395 | `list.kernel`, `code.verbatim`, `fig.graphicx`, `cap.kernel` | `description`, `verbatim`, `\verb`, `figure[htbp]` with `\caption` and `\label` |
| manual: index | doc/prosper-doc.tex:15, 21-30, 639 | `idx.makeidx` | `\makeindex`, `\index{..@\texttt{..}}`, `\printindex` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| colour-mixing macros | doc/prosper-tour.tex:14-79 | no | irreducible (`\pst@` internals, dimension arithmetic); `BESPOKE/preamble` |
| `\Registered`, `\tm`, `\code`, `\codeM`, `\codeA`, `\cindex` | doc/prosper-doc.tex:18-34 | yes | `\newcommand` aliases: `mark.kernel` + `font.size-commands` (`\fontsize{5pt}{5pt}`, `\usefont{T1}{phv}{m}{n}`) + `idx.makeidx` `\index` |
| `\tX`, `\arraycolsep` | doc/prosper-tour.tex:138-139 | yes | alias and `\setlength` inside a content equation |
| prosper.cls internals (overlay copy of semlayer `\overlay`, `\label` and `\itemize` overrides, `\@newendminipage` patch, `\timenow`, `\lastpage@putlabel`, `\saveCtr`) | prosper.cls:212-233, 394-402, 422-431, 684-739, 746-765 | not counted | published CTAN class: they are the internals of `class.prosper`. They are why overlays, the footer and the title slide cannot be composed from other lib ways |
| seminar output-routine patch | seminar-bg2-lepennec.fix:1-69 | not counted | redefines `\output@slide`; loaded only if found (prosper.cls:75); part of the CTAN package |
| contrib styles with programmed logic | contrib/PPRthomasd.sty:40-57, 103-117 (`fp` progress bar, reads `\r@last@page`); contrib/PPRmancini.sty:54-96 (`\renewpagestyle`, `multido`, per-overlay hyperlinks); contrib/PPRcorners.sty:113-194 (redefines `\maketitle`, `\SlideOverlay`, page style); contrib/PPRwinter.sty:39-56, 118-121 (`\multips` snowflakes) | not counted | published contrib styles selected by option; their counters and drawings are further `ART`/class internals, not part of the sample's look |
| style authoring API | doc/prosper-doc.tex:424-576 | n/a | a new style is a `PPR<name>.sty` written in PSTricks: `art.pstricks` (ART); none is written by a sample |

## Content-opaque
- Inline PSTricks diagrams on slides: `\rnode`/`\ncline`/`\nccurve` diagram (doc/prosper-tour.tex:129-150), `psclip` with `\psellipse` and `\pstextpath` (:158-178), `\pscirclebox` nodes (:186-206), overlapped coloured sets (:211-225).
- EPS figures `prosper-structure.eps` and `compilation.eps` (doc/prosper-doc.tex:105, 391).
- The Ramanujan equation (doc/doc-examples/Example.tex:28) and the Householder formula (doc/prosper-tour.tex:191-197).

## Lib changes
- New ways proposed: `class.prosper`, the prosper class's slide model: `slide[transition]{title}`, `\overlays` with `\fromSlide`/`\onlySlide`/`\untilSlide`, `itemstep`, `\part`, `\PDForPS`, and the hooks `\FontTitle` `\FontText` `\FontSubtitle` `\ColorFoot` `\myitem` `\Logo` `\slideCaption` `\NewSlideStyle`. Package prosper (CTAN), engine latex + dvips + ps2pdf (the lib has no tag for this; `pdf` and `xe/lua` do not fit). W1: CTAN class with public documentation (doc/prosper-doc.tex). W2: numbers, strings, font and colour declarations. W3: serves any slide deck, not one document. W4: preamble hooks plus body wrappers. The proposal passes formally. The toolchain problem is recorded as `EXTERNAL/class`, and no other lib way (beamer ways are beamer-specific) holds this vocabulary.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Not read: seminar (outside the zip), the PDFs in doc/, the .fig/.ps/.eps/.gif art, designer/prosper.ui (0 bytes) and the images. Of the ten `doc/doc-examples/Example*.tex` files only `Example.tex` was read; `ExampleAutumn.tex` was diffed against it over lines 1-20 and differs only in the option line. The other eight are 38 lines each and were not opened.
- manifest.txt lists doc-examples such as ExampleBlends.tex that are not present in the unpacked folder.
- No text addressed to an AI was found in the README, FAQ, INSTALL, NEWS or TODO files (read in part and keyword-searched; ChangeLog was only keyword-searched).
