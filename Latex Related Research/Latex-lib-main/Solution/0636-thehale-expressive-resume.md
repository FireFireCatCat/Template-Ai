yes

# 0636-thehale-expressive-resume: Expressive Resume (resume and cover letter pair)

- Unverified: read from the source, not compiled.
- Source: Source/0636-thehale-expressive-resume/ (origin: https://codeload.github.com/thehale/expressive-resume/zip/refs/heads/main; licence: MIT)
- Kind: cv
- Lib: v5
- Engine: pdfLaTeX-compatible (fontawesome5, `pdfrender`, `px` unit are all pdfTeX-usable; the CTAN page of `pdfrender` does not list engines, and nothing here was compiled)
- Look carried by: zip-local (three zip-local classes: `ExpressiveResume.cls` and `ExpressiveCoverLetter.cls` each `\LoadClass{Expressive}`; `Expressive.cls` is `\LoadClass[letterpaper,10pt]{article}` plus packages and `\newcommand`s; the sample's own preamble is empty)
- Class origin: zip-local (author's GitHub repository, not an official kit of a publisher; `https://ctan.org/pkg/expressive-resume` is a 404; the base class `article` is kernel)
- Main file: src/resume.tex (other samples: src/coverletter.tex)
- Read: main yes, zip-local classes and styles partly (the three `.cls` files read in full; `src/Colors.sty` lines 1 and the colours used read, the other lines only pattern-checked: all 758 lines from 2 to 759 are `\definecolor{name}{rgb}{r, g, b}`)

## Verdict
`yes`. All of the look sits in three small zip-local classes that are `\LoadClass{article}` plus `\RequirePackage`/`\usepackage` of published packages, option settings and `\newcommand` aliases, and one `.sty` of 758 `\definecolor` lines; every macro expands inline to lib ways (reductions below). Two judgement calls: the `keycommand` patch (src/Expressive.cls:99-110) is dead code (no `\newkeycommand` anywhere in the zip), and the `\qrcode` TikZ overlay (src/ExpressiveResume.cls:30-38) draws nothing but places a user-supplied image, so it reduces to `pg.textpos` with `fig.graphicx` and is not ART; `\qrcode` is not called by either sample. One new way is proposed for `\tech` (`pdfrender`). Unverified: read, not compiled.

## Blockers
none

## Class setting
- Class: `class.article` options: `letterpaper`, `10pt` (src/Expressive.cls:13), reached through `\documentclass{ExpressiveResume}` (src/resume.tex:1) and `\LoadClass{Expressive}` (src/ExpressiveResume.cls:10)
- Class-native vocabulary used: `\section` (src/resume.tex:16, 34, 46, 53), `itemize`/`\item` (inside `\achievement`, src/Expressive.cls:134-139), `\today` (src/coverletter.tex:10); no `\maketitle`, no abstract, no `\subsection` in either sample

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | src/resume.tex:1; src/Expressive.cls:13; src/ExpressiveResume.cls:10 | `class.article` | `[letterpaper,10pt]`; the zip-local chain ExpressiveResume -> Expressive -> article reduces to article plus the preamble rows below |
| paper size | src/Expressive.cls:13 | `page.class-options` | `letterpaper` |
| page geometry | src/ExpressiveResume.cls:14 (cover letter: src/ExpressiveCoverLetter.cls:16) | `page.geometry` | `margin=0.5in` |
| text block lengths | src/ExpressiveResume.cls:59-60; src/Expressive.cls:170-171 | `page.setlength` | textwidth=7.5in, textheight=10in (the base class's 6.5in and 9in are overridden by the subclass; the pair equals the geometry result on letter paper) |
| page style | src/ExpressiveResume.cls:15 | `hf.pagestyle-kernel` | `empty`: no header, footer or page number printed |
| page numbering | src/Expressive.cls:172 | `pgnum.pagenumbering` | `arabic` (not printed under `empty`) |
| input encoding | src/Expressive.cls:17 | `font.fontenc-t1` | `inputenc` option `utf8`; no `fontenc` line |
| body text face | src/Expressive.cls:31 | `font.helvet` | package `sans` (Joerg Knappen, CTAN `jknapltx`/TeX Live: swaps the roman and sans faces, so Computer Modern Sans is the body face; a sans text-face package is the parameter; the same effect is `\renewcommand{\familydefault}{\sfdefault}` of `font.family-default`) |
| base type size | src/Expressive.cls:169; src/ExpressiveResume.cls:58 | `font.size-commands` | `\renewcommand{\normalsize}{\fontsize{12pt}{12pt}\selectfont}`; cover letter `\fontsize{12pt}{18pt}` (src/ExpressiveCoverLetter.cls:38) |
| colours | src/Expressive.cls:20, 21, 51; src/Colors.sty:2-759 (`gray` :294, `zaffre` :758, `black` :47) | `color.xcolor` | `xcolor` option `dvipsnames`; 758 `\definecolor{..}{rgb}{..}` lines; `linkcolour` = rgb 0,0,0; only `gray`, `zaffre`, `black` are used |
| link look | src/Expressive.cls:50-57 | `meta.hyperref` | `\hypersetup{colorlinks, breaklinks, urlcolor=zaffre, linkcolor=linkcolour}` |
| contact links | src/Expressive.cls:120-123; src/resume.tex:8-9 | `meta.hyperref`, `font.icons` | `\href{mailto:..}`, `\href{tel:+1-..}`, `\href{https://github.com/..}`, `\href{https://linkedin.com/in/..}`; `\faIcon{envelope}`, `phone-alt`, `github`, `linkedin` (fontawesome5, src/Expressive.cls:24); `\location` uses `map-marker-alt` (:124) |
| resume header block | src/ExpressiveResume.cls:19-28; src/Expressive.cls:114-116; src/resume.tex:7-9 | `sp.ragged`, `font.size-commands`, `mark.kernel`, `sp.manual-space`, `tbl.tabular` | `flushleft` holding `{\Huge \textbf{name}}`, `\hfill`, `tabular{ll}` of 2 rows by 2 contact fields |
| objective paragraph | src/ExpressiveResume.cls:50-54; src/resume.tex:11-13 | `sp.ragged` | `flushleft` around the text (`\summary` :45-49 and `\tagline` :40-44 the same, unused) |
| section headings | src/Expressive.cls:69-81; src/resume.tex:16 | `head.titlesec` | `\titleformat{\section}{\Large\bfseries\raggedright}{}{0em}{}[\titlerule]`; `\titlespacing{\section}{0pt}{0pt}{12pt}[0pt]`; empty label, so no number prints |
| heading text shape | src/Expressive.cls:72 | `font.size-commands`, `mark.kernel`, `sp.ragged` | `\Large`, `\bfseries`, `\raggedright` |
| subsection (defined, unused) | src/Expressive.cls:83-93 | `head.titlesec` | `\scshape\raggedright`, empty label, 6pt before and after |
| list defaults | src/Expressive.cls:60-61 | `list.enumitem` | `\setlist{nosep,topsep=0pt,leftmargin=22pt}` |
| achievement bullets | src/Expressive.cls:134-139; src/resume.tex:20, 26, 37, 49, 56 | `list.kernel`, `list.enumitem`, `sp.manual-space` | `itemize[leftmargin=15px]` with one `\item`, then `\vspace{6pt}` |
| experience entry | src/Expressive.cls:158-166; src/resume.tex:18-31 | `mark.kernel`, `sp.manual-space`, `sp.lengths` | `\noindent\emph{org}\hfill\emph{location}`, `\vspace{6pt}`, `\noindent` body, `\vspace{6pt}` |
| role line | src/Expressive.cls:153-157, 130, 133; src/resume.tex:19, 25 | `mark.kernel`, `color.xcolor`, `sp.manual-space` | `\noindent\textbf{title} \hfill {\color{gray}dates}\vspace{6pt}\par` body `\vspace{6pt}` |
| project, degree, award entries | src/Expressive.cls:148-152, 140-143, 144-147; src/resume.tex:36, 48, 55 | `mark.kernel`, `color.xcolor`, `sp.manual-space`, `math.kernel` | `\noindent\textbf{name}`, then `$|$` and the institution (degree and award only; `\project` has no institution), `\hfill`, grey year (`\tenure`), `\vspace{6pt}\par`, body |
| inline tags | src/Expressive.cls:127-129; src/resume.tex:25, 48 | `mark.kernel` | `\parttime` = `\textnormal{\textsc{part time}}`; `\honors` = `\textnormal{\emph{..}}`; `\equivalent` same shape (unused) |
| technology highlight | src/Expressive.cls:35, 131; src/resume.tex:21, 27, 38 | `mark.contour` | `\textpdfrender{TextRenderingMode=FillStroke,StrokeColor=black,LineWidth=0.25pt}{text}`; the comment at :33 calls it a way of making semibold |
| vertical spacing aliases | src/Expressive.cls:4-5 | `sp.lengths` | `\spacesmall`=6pt, `\spacenormal`=12pt: inline the values |
| table column types | src/Expressive.cls:39-45 | `tbl.tabular` | `array` `\newcolumntype{L,C,R}[1]` = `p{#1}` with `\raggedright`/`\centering`/`\raggedleft`; unused by the samples |
| multirow | src/Expressive.cls:46 | `tbl.multirow` | loaded, never called |
| image support | src/Expressive.cls:27 | `fig.graphicx` | `\usepackage{graphicx}`; used only by `\qrcode` |
| QR image overlay | src/ExpressiveResume.cls:30-38; src/images/qr.png | `pg.textpos`, `fig.graphicx`, `sp.manual-space` | image of width `.09\linewidth` with its top-right corner 0.5in from the right and 0.33in from the top of the page, then `\vspace{-20pt}`; `textblock*` with `[1,0]` anchor and `absolute` coordinates; not called by either sample (grep) |
| cover letter header | src/ExpressiveCoverLetter.cls:23-30; src/coverletter.tex:5-7 | `sp.ragged`, `font.size-commands`, `mark.kernel`, `sp.rule`, `sp.manual-space` | `ragged2e` `Center` environment, `{\Huge \textbf{name}}`, `\rule{\linewidth}{1pt}`, four contact fields joined by `\hspace{6pt}\textbar\hspace{6pt}` (src/Expressive.cls:117-119) |
| cover letter paragraphs | src/ExpressiveCoverLetter.cls:13, 18-19; src/coverletter.tex:14-44 | `sp.lengths` | `\parindent=0pt`, `\parskip=\baselineskip`; text is content |
| cover letter date and closing | src/coverletter.tex:9-11, 46-50; src/ExpressiveCoverLetter.cls:31-35 | `front.maketitle`, `sp.manual-space` | kernel `\today`; `\vspace{0.25in}`, `0.15in`, `.15in`; `\objective` (:31-35) prints `\textsc{Objective}:` and is unused |
| page-level items not defined | n/a | n/a | no columns, floats, tables of content, theorems, maths, code, boxes, bibliography, index or cross-references are defined or used by either sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `Expressive.cls` as a whole | src/Expressive.cls:1-172 | yes | `class.article[letterpaper,10pt]` plus `font.fontenc-t1`, `color.xcolor`, `font.icons`, `fig.graphicx`, `font.helvet` (`sans`), `mark.contour`, `tbl.tabular`, `tbl.multirow`, `meta.hyperref`, `list.enumitem`, `head.titlesec` as in the map; no `\@startsection`, output routine, counter or conditional of its own |
| `ExpressiveResume.cls` | src/ExpressiveResume.cls:1-61 | yes | `page.geometry` margin=0.5in, `hf.pagestyle-kernel` empty, `page.setlength`, `font.size-commands`, `pgnum.pagenumbering`, plus the commands below |
| `ExpressiveCoverLetter.cls` | src/ExpressiveCoverLetter.cls:1-41 | yes | `sp.ragged` (`ragged2e`), `page.geometry`, `hf.pagestyle-kernel`, `sp.lengths`, `font.size-commands`, plus the commands below |
| `Colors.sty` | src/Colors.sty:1-759 | yes | 758 `\definecolor{name}{rgb}{r,g,b}` calls of `color.xcolor`; line 1 is a comment (latexcolor.com); a few names repeat xcolor's own (`black` :47, `gray` :294, `white` :744) |
| `\spacesmall`, `\spacenormal` | src/Expressive.cls:4-5 | yes | length aliases: inline 6pt and 12pt in `sp.manual-space` and `head.titlesec` |
| `keycommand` load and `\ifcommandkey` patch | src/Expressive.cls:96-110 | yes, by omission | `keycommand` has no lib way (no printed effect); grep finds no `\newkeycommand` or `\ifcommandkey` use anywhere in the zip, so nothing in either sample depends on the patch; src/MIGRATION.md:13-15 says the old key-value `\coverletterheader` was replaced by positional arguments; an emitter loads neither the package nor the patch. Considered: `keycommand` (not proposed) |
| `\nametitle`, `\contactseparator`, `\email` `\phone` `\github` `\linkedin` `\location` | src/Expressive.cls:114-124 | yes | `\newcommand` aliases of `font.size-commands` + `mark.kernel`, `sp.manual-space`, `font.icons` + `meta.hyperref`; expand inline |
| `\roletitle`, `\tenure`, `\notable`, `\equivalent`, `\parttime`, `\honors` | src/Expressive.cls:127-133 | yes | aliases of `\textbf`, `{\color{gray}..}`, `\textnormal{\textsc{..}}`, `\textnormal{\emph{..}}` (`mark.kernel`, `color.xcolor`) |
| `\tech` | src/Expressive.cls:131 | yes | one `mark.contour` wrapper with fixed keys |
| `\achievement` | src/Expressive.cls:134-139 | yes | `itemize[leftmargin=15px]` + one `\item` + `\vspace{6pt}` |
| `\degree`, `\award`, `\project`, `\role`, `\experience` | src/Expressive.cls:140-166 | yes | text macros made of `\noindent`, `\textbf`, `\emph`, `\hfill`, `\vspace`, `\par`, `$|$`; no counters, no conditionals; expand inline per call |
| `\resumeheader` | src/ExpressiveResume.cls:19-28 | yes | `flushleft` + name + `\hfill` + `tabular{ll}` |
| `\objective`, `\summary`, `\tagline` | src/ExpressiveResume.cls:40-54 | yes | `flushleft` wrappers (`\textsc{label}: text` for `\tagline`) |
| `\qrcode` | src/ExpressiveResume.cls:30-38 | yes | `tikzpicture[remember picture,overlay]` with one `node[anchor=north east,yshift=-.33in,xshift=-.5in] at (current page.north east)` holding `\includegraphics[width=.09\linewidth]{file}`; it draws no path, shape or text, and the image is the caller's file (content), so it is not ART; reduction: `pg.textpos` `textblock*` anchored top-right at 0.5in/0.33in with `fig.graphicx`, then `sp.manual-space` `\vspace{-20pt}` (alternative: `bg.eso-pic`); `tikz` loaded at src/Expressive.cls:28 is used only here. Considered: `bg.tikzpagenodes`, `art.tikz` (not used) |
| `\coverletterheader`, cover letter `\objective` | src/ExpressiveCoverLetter.cls:23-35 | yes | `Center` + name + `\rule` + contact row; `\textsc{Objective}: text` in `flushleft` |
| `\newcolumntype{L,C,R}` | src/Expressive.cls:40-45 | yes | `tbl.tabular` (array); unused |
| `\renewcommand{\normalsize}`, `\setlength{\textwidth}`, `\setlength{\textheight}`, `\pagenumbering` | src/Expressive.cls:169-172; src/ExpressiveResume.cls:58-61; src/ExpressiveCoverLetter.cls:38-41 | yes | `font.size-commands`, `page.setlength`, `pgnum.pagenumbering` with the values in the map |

## Content-opaque
none (no figure or table float in either sample; `src/images/qr.png` is a shipped asset used only by the unused `\qrcode`)

## Lib changes
- New ways proposed: `mark.contour` (section `mark`; package `pdfrender`; engine pdf, engine support not stated on its CTAN page). One line: `pdfrender` (CTAN and TeX Live, LPPL 1.3c, maintainer Heiko Oberdiek, v1.8 of 2023-12-07, CTAN page read): `\usepackage{pdfrender}` and inline wrapper `\textpdfrender{TextRenderingMode=FillStroke,StrokeColor=black,LineWidth=0.25pt}{text}` (also `\pdfrender{..}`; the commands come from this sample, the CTAN page names none): sets the PDF text rendering mode, stroke colour and line width of a span. W1: CTAN and TeX Live. W2: key=value, a mode name, a colour, a length. W3: serves any text span (outline, faux bold). W4: one preamble line and a body wrapper. Nearest existing line is `mark.contour` (an outline around inline text drawn by `contour`'s offset copies); same type of effect with a different package, so the consolidator may fold it there as "the package is the parameter".
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
