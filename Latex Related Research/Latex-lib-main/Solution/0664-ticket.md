no

# 0664-ticket: ticket (CTAN package for label, card and pin sheets: package, beamer manual, six examples, 15 sheet-definition files)

- Unverified: read from the source, not compiled.
- Source: Source/0664-ticket/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ticket.zip; licence: LPPL 1.3, README.txt:41-42 and ticket.sty:9-12; manifest `lppl1.3`)
- Kind: misc (the package imposes sheets of labels, cards and pins; the manifest main sample doc/manual.tex is a beamer deck about it; no listed kind names a card sheet)
- Lib: v5
- Engine: pdfLaTeX-compatible (ticket.sty loads only `ifthen` and `calc`, ticket.sty:72-73; the examples load `graphicx`, `color`, `rotating`, `fancybox`, `syntonly`; the manual is beamer; no fontspec or other xe/lua package anywhere)
- Look carried by: mixed (manual: published class `beamer` with theme Bergen, doc/manual.tex:1-3; examples: the sheet comes from the published package `ticket`, ticket.sty:52-276, and each example's own preamble draws the ticket face, e.g. doc/ex_pin.tex:16-28)
- Class origin: tex-distribution-unbundled (`beamer` and `letter` are not in the zip; `ticket.sty` is a package, not a class, and is the CTAN and TeX Live release)
- Main file: doc/manual.tex (other samples: doc/ex_file.tex, doc/ex_pin.tex, doc/ex_vcard.tex, doc/ex_marks.tex, doc/ex_flashcard.tex, doc/ex_flashcard_rm.tex; data file doc/words.tex)
- Read: main yes, zip-local classes and styles all (no `.cls`; `ticket.sty` 285 lines read in full, the 15 `tdf/*.tdf` of 11 to 15 lines read in full, all six `ex_*.tex` and `words.tex` read; the `.pdf` files and `doc/logo.png` not read)

## Verdict
no. `ticket.sty` is Thomas Emmel's CTAN package (ctan.org/pkg/ticket read once: v0.4d, LPPL 1.3, in TeX Live and MiKTeX), so it is the lib way `ticket.sheet` and its internals are not bespoke; the 15 `.tdf` files are only lengths and counts for that way; the manifest main sample (a beamer deck) maps to `class.beamer` and `slide.beamer-theme` with reducible aliases only. What blocks `yes` is the ticket faces of the six examples: pin, file-label, business-card and flash-card faces laid out as absolute `\put(x,y)` picture commands, some with `\line` rules and a placed logo (doc/ex_pin.tex:16-28, doc/ex_vcard.tex:22-49, doc/ex_file.tex:17-31). The lib's `ticket.sheet` line puts the face outside the way ("ART when it draws the template's identity"), `picture` sits only in the restricted `art.pstricks`, and the same construct was recorded `ART` for Solution/0009-event-ticket-cards.md and Solution/0386-bizcard.md. Close call: the package ships only a placeholder face (ticket.sty:208-211); read on the main sample alone the zip is `yes`.

## Blockers
- `ART/preamble` conference-pin face: `\renewcommand{\ticketdefault}` places a logo at `\put(50,  3)`, a rule `\put( 5, 13){\line(1,0){60}}` and three `\scriptsize` lines at `(7,10)`, `(7,7)`, `(7,4)` (doc/ex_pin.tex:16-22); `\confpin` centres two lines at `\put(35,36)` and `\put(35,28)` (doc/ex_pin.tex:25-28)
- `ART/preamble` business-card faces: `\vcardfront` has 13 absolute `\put` cells with a rotated logo `\put( 63, 5){\includegraphics[width=40mm,angle=90,origin=bl]{logo}}` and the coloured rule `\put( 5, 13){\color{uni}\line(1,0){56}}` (doc/ex_vcard.tex:26-40); `\vcardback` has a second rule and a placed `minipage` (doc/ex_vcard.tex:42-49)
- `ART/preamble` file-label face: rotated logo and rotated spaced text in `\ticketdefault` at `\put(155,5)` and `\put(150,50)` (doc/ex_file.tex:17-21), `\filelabel` at `\put(33,48)` and `\put(43,5)` (doc/ex_file.tex:24-31)
- `ART/preamble` text-only faces (positioned text, no rule): `\acard` (doc/ex_marks.tex:24-27); `\card` and `\raiz`, front and back (doc/ex_flashcard.tex:19-28 and 53-63; the same lines in doc/ex_flashcard_rm.tex)

## Class setting
- Class: `class.beamer` options: `aspectratio=1610`, `hyperref={pdfpagelabels=false}` (doc/manual.tex:1). The six examples use `class.letter` options `a4paper,10pt` (line 7 of each `doc/ex_*.tex`). Both are LaTeX distribution classes, not bundled; their source was not read.
- Class-native vocabulary used (beamer): `frame` and `frame[fragile]` (doc/manual.tex:36, 74), `\frametitle` (41), `block` (43), `exampleblock` (54-60, 122), `alertblock` (166-224), `\title` `\author` `\maketitle` inside a frame (26-38), `\usetheme{Bergen}` (3), `\hypertarget` (75, 117). The `letter` examples use none of letter's vocabulary (no `letter` environment, no `\opening`); the body is bare `\ticket` calls.

## Component map
Main sample, doc/manual.tex (beamer deck)
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | doc/manual.tex:1 | `class.beamer` | aspectratio=1610, hyperref={pdfpagelabels=false} |
| beamer look | doc/manual.tex:3 | `slide.beamer-theme` | `\usetheme{Bergen}`; `\nobuttons` is commented out (:5); no colour, font, inner or outer theme call |
| frames and blocks | doc/manual.tex:36-45, 54-60, 166-224 | `class.beamer` | native `frame`, `frame[fragile]`, `\frametitle`, `block`, `exampleblock`, `alertblock` at their defaults |
| PDF metadata | doc/manual.tex:12-14 | `meta.hyperref` | `\hypersetup` pdfauthor={Thomas Emmel}, pdftitle={ticket manual}, pdfsubject={ticket.sty} |
| title block | doc/manual.tex:26-33, 36-38 | `front.maketitle` | `\title`, `\author`, `\maketitle` inside a frame |
| title box and centring | doc/manual.tex:26-30 | `box.minipage`, `sp.ragged`, `sp.manual-space` | `minipage[t]{0.98\textwidth}` holding a `center` environment, `\\[1ex]` |
| author name scaling | doc/manual.tex:32 | `fig.graphicx` | `\scalebox{1}[1.1]{..}` (graphicx comes with beamer) |
| links and anchors | doc/manual.tex:32-33, 54-60, 75, 117 | `xref.hyperref` | `\href{mailto:..}{..}`, `\href{ex_file.pdf}{..}`, `\hypertarget{tdf}{}`, `\hypertarget{ticket}{}` |
| typewriter face | doc/manual.tex:16 | `font.mono` | `\IfFileExists{cmtt.sty}{\usepackage{cmtt}}{}` (`cmtt` is in CTAN `mdwtools`, GPL, TeX Live; the emitter loads it unconditionally); `\texttt` in `\code` (:8) |
| verbatim listings | doc/manual.tex:18, 80-92, 128-133, 146-151 and the later `[fragile]` frames (256-262, 281-287, 299-308, 317-323, 336-357, 368-387, 401-410, 419-423, 434-443, 452-457, 466-468) | `code.verbatim` | `verbatim` package and environment inside `frame[fragile]` |
| quote and side boxes | doc/manual.tex:77-95, 253-265 | `quote.kernel`, `box.minipage` | `quote`; `minipage[t]{0.5\textwidth}` and `{.5\textwidth}` |
| font sizes | doc/manual.tex:79, 134 | `font.size-commands` | `\scriptsize`, `\normalsize` |
| font switches | doc/manual.tex:24, 27, 68 | `mark.kernel` | `\sffamily` (whole deck, after `\begin{document}`), `\mdseries`, `\itshape` |
| symbols package | doc/manual.tex:19 | `math.amssymb` | `amssymb`, load only; the one `\rightarrowtail` is commented out (:50) |
| inline maths | doc/manual.tex:98, 100-101 | `math.kernel` | `n$_x$`, `n$_y$`, `dist$_x$` |
| colour | doc/manual.tex:120, 167-216 | `color.xcolor` | `\color{red}` (beamer loads xcolor) |
| manual spacing | doc/manual.tex:27-28, 47, 294, 329, 363 | `sp.manual-space` | `\\[1ex]`, `\\[2ex]`, `\vspace*{10mm}`, `\vspace*{-4mm}` |
| option illustrations | doc/manual.tex:158-220 | `art.pstricks` (content use) | `picture` of corner marks inside `alertblock` titles; see Content-opaque |

Package `ticket` and its use in the six examples
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| ticket sheet package | doc/ex_file.tex:10; doc/ex_pin.tex:10; doc/ex_vcard.tex:10; doc/ex_marks.tex:10; doc/ex_flashcard.tex:9; doc/ex_flashcard_rm.tex:9; ticket.sty:52-70 | `ticket.sheet` | options `lz1680,circlemark`; `freepin,crossmark`; `zw32010,crossmark`; `freepin3,emptycrossmark`; `flashCard,boxed`; `flashCard,boxed,rowmode`; six booleans `boxed` `crossmark` `circlemark` `emptycrossmark` `cutmark` `rowmode` (ticket.sty:61-66); any other option names a `.tdf` file (ticket.sty:68) |
| sheet grid and ticket size | tdf/zw32010.tdf:5, 11, 13, 14 (the same commands, with other values, in all 15 files) | `ticket.sheet` | `\unitlength=1mm`, `\ticketNumbers{2}{5}`, `\ticketSize{85}{54}`, `\ticketDistance{9.8}{0}` |
| printer offsets | tdf/zw32010.tdf:8-9; doc/ex_flashcard.tex:66 | `page.setlength` | `\hoffset=-14.3mm`, `\voffset=-9.2mm`; `\oddsidemargin=8pt` before the back side |
| sheet control | doc/ex_flashcard.tex:65; doc/ex_marks.tex:40, 45, 50, 55; ticket.sty:147-161 | `ticket.sheet` | `\backside`; `\ticketreset` (with `\clearpage`); `\ticketskip{n}` appears only in the manual text (doc/manual.tex:239, ticket.sty:198-203) |
| package page set-up | ticket.sty:83-94 | `ticket.sheet` | `\pagestyle{empty}`, zero margins and head and foot heights, set inside the package (not emitted) |
| class and paper (examples) | doc/ex_file.tex:7 | `class.letter`, `page.class-options` | `a4paper`, `10pt` |
| ticket faces | doc/ex_file.tex:17-31; doc/ex_pin.tex:16-28; doc/ex_vcard.tex:22-49; doc/ex_marks.tex:20-27; doc/ex_flashcard.tex:15-28, 53-63 | `art.pstricks` | `\renewcommand{\ticketdefault}{\put(x,y){..}}` and `\ticket{\put(x,y){..}}` with `\line` rules and `\makebox[0mm]`; the `ART/preamble` blockers |
| logo image | doc/ex_file.tex:13, 19; doc/ex_pin.tex:13, 17; doc/ex_vcard.tex:13, 27 | `fig.graphicx` | `\includegraphics[width=35mm]{logo}`, `[width=15mm]`, `[width=40mm,angle=90,origin=bl]`; asset doc/logo.png (shipped) |
| rotated text and logo | doc/ex_file.tex:14, 18-20, 25-30 | `fig.rotating` | `sideways`, `rotate{180}` |
| card colour | doc/ex_vcard.tex:14, 17, 29, 44 | `color.color` | `color` package, `\definecolor{uni}{rgb}{.3019,.7216,.7019}`, `\color{uni}` |
| face text boxes | doc/ex_file.tex:27-29; doc/ex_flashcard.tex:54-56; doc/ex_vcard.tex:46-48 | `box.minipage` | `minipage[t]{50mm}`, `\parbox{58mm}`, `\parbox[t]{50mm}` |
| framed synonym box | doc/ex_flashcard.tex:12, 36 | `box.fancybox` | `fancybox` loaded, `\fbox{\parbox[t]{50mm}{\centering ..}}` |
| face fonts and sizes | doc/ex_file.tex:25, 35; doc/ex_pin.tex:19, 26, 34; doc/ex_vcard.tex:35, 55; doc/ex_flashcard.tex:20, 27 | `mark.kernel`, `font.size-commands` | `\sffamily`, `\bfseries`, `\textbf`, `\textit`; `\Huge`, `\Large`, `\large`, `\LARGE`, `\small`, `\scriptsize`, `\huge` |
| face spacing and centring | doc/ex_file.tex:28, 37; doc/ex_vcard.tex:47; doc/ex_flashcard.tex:35-37, 44 | `sp.manual-space`, `sp.ragged` | `\\[2ex]`, `\hspace*{5mm}`, `\hss`, `\\[1.5mm]`; `center` environment, `\centering` |
| face maths | doc/ex_flashcard.tex:26, 31, 41, 58 | `math.kernel` | `$\sqrt{\enspace}$`, `$\bullet$`, `$\mathbf{\sim}$`, `$\|$` |
| data inclusion | doc/ex_flashcard.tex:51, 67; doc/ex_flashcard_rm.tex:51, 67 | `struct.input` | `\input{words}` once per side |
| counters | doc/ex_vcard.tex:52, 62; doc/ex_marks.tex:30, 40 | `num.counters` | `\newcounter{numcards}`, `\setcounter{numcards}{0}` |
| page breaks | doc/ex_marks.tex:40, 45, 50, 55 | `pg.break` | `\ticketreset\clearpage` between the five mark demos |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `ticket.sty` internals (`\ticket@counter`, `\ticketskip` loop, `\ticket` picture box, mark drawing) | ticket.sty:164-203, 215-281 | not bespoke, published | CTAN and TeX Live package (ctan.org/pkg/ticket: v0.4d, Thomas Emmel, LPPL 1.3; commands named there: `\ticketdefault`, `\ticket`); the emitter prints `\usepackage[opts]{ticket}` and never copies this code; options and lengths are `ticket.sheet` parameters |
| 15 ticket definition files | tdf/*.tdf (aj8414, dura5222, flashCard, freepin, freepin2, freepin3, he4432, invite, lz1680, lz1681, lz1685, rex23184237, zw32010, zw3424, zw4752) | yes, with a caveat | each holds only `\unitlength`, `\hoffset`, `\voffset`, `\ticketNumbers`, `\ticketSize`, `\ticketDistance` (tdf/zw32010.tdf:5-14); they ship with the CTAN release, so the emitter keeps the name option or writes a generated `.tdf` with those lines. Caveat: lines written after `\usepackage{ticket}` (the manual's way, doc/manual.tex:111-113) leave `\back@shift` computed from the defaults (ticket.sty:131-136, 144), so a `\backside` sheet needs the `.tdf` route |
| face macros `\filelabel` `\confpin` `\vcardfront` `\vcardback` `\acard` `\card` `\raiz` `\entryroot` `\blt` `\syn` `\relwords` `\example` | doc/ex_file.tex:24; doc/ex_pin.tex:25; doc/ex_vcard.tex:26, 42; doc/ex_marks.tex:24; doc/ex_flashcard.tex:19-44 | the macros yes, the faces no | `\newcommand` wrappers over `\ticket`, `\put`, `\parbox`, `\fbox` inline-expand to `ticket.sheet`, `box.minipage`, `box.fancybox`, `mark.kernel`; the `\put` layout inside them is the `ART/preamble` blocker |
| face macros redefined between the two passes | doc/ex_flashcard.tex:53-63 (same in doc/ex_flashcard_rm.tex:53-63); `\entryroot` empty at :23, renewed at :58 | yes | two fixed definitions of each body; write the front and back wrappers under two names |
| `\renewcommand{\ticketdefault}` | doc/ex_file.tex:17; doc/ex_pin.tex:16; doc/ex_vcard.tex:22; doc/ex_marks.tex:20; doc/ex_flashcard.tex:15 | the hook yes, a non-empty body no | documented hook of the published package (ticket.sty:206-211); empty in `ex_vcard`, `ex_marks`, `ex_flashcard`, drawn in `ex_file` and `ex_pin` (blockers) |
| `\whiledo` card loops | doc/ex_vcard.tex:58-60, 65-67; doc/ex_marks.tex:37, 42, 47, 52, 57 | yes | `ifthen` loop (loaded by ticket.sty:72) around `numcards`, which repeats the call 10 or 25 times and in `ex_marks` also prints the number (ex_marks.tex:26); the count is fixed, so the emitter unrolls it into literal calls |
| mid-document switch of mark options | doc/ex_marks.tex:41, 46, 51, 56 | yes, weakest reduction | `\makeatletter\@emptycrossmarkfalse\@cutmarktrue\makeatother` and the like set the package's private booleans (ticket.sty:52-59) after `\ticketreset\clearpage`; the package has no public command for it, so this reaches into package internals; the emitter writes the same lines or one sheet per option |
| `\code`, `\ticket`, `\bs` aliases | doc/manual.tex:8-10 | yes | `\texttt{..}`; `\texttt{ticket.sty}`; `\bs` is a typewriter backslash through `\mtt`, which the zip does not define and comes from `cmtt` only if that file is found (doc/manual.tex:16); the CTAN page of `cmtt` does not name `\mtt` and the source was not read, so this is unresolved; the emitter can print `\texttt{\textbackslash}` instead |
| `\IfFileExists{cmtt.sty}{..}{}` | doc/manual.tex:16 | yes | kernel conditional load, decided at emit time |
| `\def\cross` | doc/manual.tex:158-161 | yes | one picture macro used four times in block titles; inline-expand (content, see below) |

## Content-opaque
- Corner-mark illustrations drawn with `picture` (`\put`, `\line`, `\circle`) inside `alertblock` titles (doc/manual.tex:167-172, 176-181, 186-195, 200-207, 212-217) and the `\cross` macro (doc/manual.tex:158-161): they show what each package option prints and are not the deck's own look.
- Mock data on the faces: animal names (doc/ex_pin.tex:35-46), "Mr. X" and phone strings (doc/ex_vcard.tex:60, 67), file-label texts (doc/ex_file.tex:36-42).
- doc/words.tex: flash-card data, 110 lines of `\raiz`, `\card`, `\entryroot`, `\syn`, `\example` calls; line 69 holds a byte that is not valid UTF-8 (a legacy encoding), so the emitter recodes it.
- `syntonly` is loaded (doc/ex_flashcard.tex:11, doc/ex_flashcard_rm.tex:11) but `\syntaxonly` is never called in the zip: no printed effect, so no component.
- Prebuilt `doc/*.pdf` and `doc/logo.png` are outputs and an asset; the PDFs were not read.

## Lib changes
- New ways proposed: none. Considered and not proposed: a way for text and rules placed at coordinates in a ticket face; it would relabel the restricted `art.pstricks` (its parameters are free drawings, so W2 fails), as Solution/0009-event-ticket-cards.md decided. Considered: `pg.textpos` (page-absolute boxes; the face sits in a picture box inside `\ticket`, so it does not move there).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this). The consolidator may widen the `ticket.sheet` line: options `crossmark` `circlemark` `emptycrossmark` `rowmode`, the `.tdf` name option, `\unitlength` and the commands `\ticketdefault` `\ticketreset` `\backside` `\ticketskip` belong to the same package.

## Notes
- Judgment call, recorded so it can be re-read: the verdict is `no` only because of the `ART/preamble` faces of the examples. Read on the manifest main sample alone (doc/manual.tex, beamer), every row reduces to a lib way and the only drawing is the content illustration, so it is `yes`; `ticket.sty` with the `.tdf` files is `yes` too. If faces are ruled to be user content handed to a published package (the placeholder at ticket.sty:208-211 and the manual's advice to renew it, doc/manual.tex:123-137, point that way), the zip becomes `yes` with no new way.
- Not blockers: the manual says the duplex file was made with `psselect -p1,3,2,4` (doc/manual.tex:467; doc/ex_flashcard_dup.pdf has no `.tex` source) and suggests a perl or python script to produce data files (doc/manual.tex:247); no `.tex` in the zip needs either to build.
- The file `comment` is a three-line CTAN catalogue blurb about the package; README.txt:32 asks human users to send more `.tdf` files. No text addressed to an AI was found in the zip.
