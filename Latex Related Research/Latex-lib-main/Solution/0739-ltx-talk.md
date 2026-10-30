yes

# 0739-ltx-talk: ltx-talk (accessible presentation class, CTAN source bundle)

- Unverified: read from the source, not compiled.
- Source: Source/0739-ltx-talk/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ltx-talk.zip; licence: LPPL 1.3c)
- Kind: presentation
- Lib: v5
- Engine: needs LuaLaTeX (the manual loads `unicode-math` with `tagging = on`, ltx-talk.tex:29,36; the class itself runs under pdfLaTeX or LuaLaTeX and warns on other engines, ltx-talk.dtx:107-117; of the 13 class samples only math-fonts.tex needs a Unicode engine, math-fonts.tex:7-8)
- Look carried by: class
- Class origin: ctan
- Main file: ltx-talk.tex (the manual, class `l3doc`, as the manifest names it; other samples: ltx-talk-code.tex (implementation driver, `l3doc`) and the 13 `ltx-talk` class examples background-image.tex, float-centering.tex, footer-text.tex, header-footer-color.tex, list-actions.tex, list-overlays.tex, list-relative-overlays.tex, math-fonts.tex, overlay-opacity.tex, titlepage-styling.tex, totalframes.tex, verbatim-alt-env.tex, verbatim-content.tex)
- Read: main yes, zip-local classes and styles all (no .cls or .sty ships; `ltx-talk.ins` generates `ltx-talk.cls` from the ten .dtx files, ltx-talk.ins:70-85; the code of all ten .dtx was read, from line 56 on in the nine sub-files, whose licence and driver heads were not re-read)

## Verdict
Yes. The zip is the official CTAN release of the class `ltx-talk`, so the class is published (W1) and carries every example's look as `class.ltx-talk`; the 13 examples only set class templates with `\EditInstance`, use class frame and overlay vocabulary, load `fancyvrb`, set fonts, and add one `shipout/background` picture. The manual and the implementation driver are `class.l3doc` documents whose helper macros reduce by inline expansion. The one macro with logic, `\acro`, reduces only because its single call has a lowercase argument (ltx-talk.tex:111). Caveat: the class's own expl3 code (slide boxes, opacity whatsits, tagging, e.g. ltx-talk-frame.dtx:136-328, ltx-talk-overlay.dtx:149-152) would be irreducible BESPOKE/class if this class were zip-local; it is not counted because this is the CTAN release.

## Blockers
none

## Class setting
- Class: `class.ltx-talk` (examples) and `class.l3doc` (manual and implementation driver; published, documented with the `l3kernel` bundle on CTAN, whose page links "The l3doc class"; its source is not in the zip and was not read). `class.ltx-talk` options: none in any example; defined: `mode = handout|projector`, `handout`, `aspect-ratio = 16:9`, `font-size`, `10pt` `11pt` `12pt`, `frame-title-arg`, `supplementary-frames = appendix|in-place|omit` (ltx-talk.dtx:209-226,246-266; documented at ltx-talk.tex:210,423-433,1389-1399). It needs LaTeX 2026-06-01 or later and `\DocumentMetadata` (ltx-talk.dtx:92-102).
- Class-native vocabulary used: `\DocumentMetadata{tagging = on, pdfstandard = ua-2}` before the class; `frame` and `frame*` (keys `action-spec`, `auto-break`, `auto-break-coverage`, `name`, `label`, `supplementary-frame`, `tag-slides`, `vertical-alignment`); `\frametitle`, `\framesubtitle`; `\title[short-title=..]`, `\subtitle`, `\institute`, `\maketitle[frame-style, horizontal-alignment, vertical-alignment, element-order]`; overlay specs `<+->`, `<.->`, `<alert@+>`; `\pause`, `\only`, `\uncover`, `\visible`, `\alert`, `\onslide`, `\alt`, `\temporal`, `actionenv`, `onlyenv`, `overlayarea`, `overprint`; `block`, `columns`, `column`; `\reuseframe`, `\againframe`; `\mode`; `\appendix`; kernel templates `header`, `footer`, `floatenv`, `hidden`, `frametitle`, `titlepage` edited with `\EditInstance{type}{std}{keys}`; `\RefProperty{lastpage}{totalframes}`. `class.l3doc` vocabulary in the manual: `documentation`, `syntax`, `variable` environments, `\DescribeEnv`, `\DescribeMacro`, `\cs`, `\cls`, `\pkg`, `\env`, `\file`, `\meta`, `\oarg`, `\marg`, `\PrintIndex`, `\enquote` (origin not read: l3doc or `csquotes`).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class (examples) | list-overlays.tex:3, background-image.tex:3 (every example, line 3) | `class.ltx-talk` | `\documentclass{ltx-talk}`, no options in the examples |
| class (manual, driver) | ltx-talk.tex:31, ltx-talk-code.tex:29 | `class.l3doc` | no options |
| PDF metadata and tagging | list-overlays.tex:1, ltx-talk.tex:29, ltx-talk.dtx:102,426-431, ltx-talk.tex:1482 | `meta.documentmetadata` | `tagging = on`, `pdfstandard = ua-2`, manual `pdfversion = 2.0`, `lang = en`; class `\tagpdfsetup{role / new-tag = frame / Sect, role / new-tag = frametitle / H4}`; user example `role / new-tag = frametitle / H1` |
| slide page size and margins | ltx-talk.dtx:295-328 | `page.geometry` | `papersize` = (16/9 x 100mm) wide by 100mm high, tmargin=10mm, bmargin=8mm, lmargin=rmargin=10mm, headheight=10mm, headsep=2mm, footskip=6mm; user override documented `\geometry{lmargin = 15mm, rmargin = 15mm}` (ltx-talk.tex:440) |
| aspect ratio, base size | ltx-talk.dtx:211-214,259-266,277-283 | `page.class-options` | `aspect-ratio=16:9`, `font-size=11pt` (loads `size11.clo`; `relsize` fallback for other sizes) |
| ragged text | ltx-talk.dtx:334 | `sp.ragged` | `\raggedright` for the whole class |
| design lengths | ltx-talk-required.dtx:112-120,139-167 | `sp.lengths` | tabcolsep 6pt, arrayrulewidth 0.4pt, fboxsep 3pt, leftmargini 2em, labelsep 0.5em, `\@listi` topsep 3pt plus 2pt minus 2.5pt, itemsep 3pt plus 2pt minus 3pt |
| fonts, 8-bit engines | ltx-talk.dtx:378-380 | `font.helvet`, `font.lmodern`, `font.family-default` | `sansmathfonts`; `lmodern[nomath]`; `\rmdefault` = `\sfdefault` (all-sans text and maths; `sansmathfonts` filed under the sans package way) |
| fonts, OpenType engines | ltx-talk.dtx:359-375 | `font.fontspec`, `font.unicode-math`, `math.mathtools` | `\setmainfont{NewCMSans10-Regular.otf}`, `\setsansfont` same, `\setmathfont{NewCMSansMath-Regular.otf}`; LuaLaTeX uses `lua-unicode-math` and `\tagpdfsetup{math / mathml / luamml / load = true}` |
| user font override | math-fonts.tex:6-14 | `font.fontspec` | `\RequireTUTeX` (iftex), `\IfFontExistsTF{Pennstander-Regular.otf}{\setmainfont..\setmathfont{PennstanderMath-Regular.otf}}{}` (fonts not shipped, guarded) |
| size switch | math-fonts.tex:30,46,64 | `font.size-commands` | `\large` at the top of a frame |
| header band and frame title area | ltx-talk-frame.dtx:608-664, header-footer-color.tex:7-10 | `hf.class-native` | template `header`/`std`: `background-color = blue!50`, `color = white`; keys height, font, left-hspace, right-hspace, print-frame-title; copy `wallpaper` with `print-frame-title = false` (frame.dtx:664-670) |
| footer band and elements | ltx-talk-frame.dtx:689-753, footer-text.tex:5-11, titlepage-styling.tex:5-12, header-footer-color.tex:12-14 | `hf.class-native` | template `footer`/`std`: `color = black!50`, `separator = \hfill\|\hfill`, `element-order = {date, author, title, institute, framenumber}`, `left-hspace = right-hspace = 3mm`, `background-color = black!50`; font default `\tiny`; page styles `talk` `wallpaper` `plain` (frame.dtx:794-830) |
| frame title look | ltx-talk-structure.dtx:106-165, header-footer-color.tex:19 | `head.class-native` | template `frametitle`: font `\Large \bfseries`, after-vspace `\bigskipamount`, before-vspace, color |
| colours | ltx-talk-color.dtx:93,117-148,213-215; footer-text.tex:6 | `color.xcolor` | `alert` RGB 200,0,0; `example` green!50!black; `structure` rgb 0.2,0.2,0.7; overlay-aware `\color` `\textcolor` `\mathcolor`; `blue!50`, `black!25` |
| page colour | ltx-talk-color.dtx:156-173 | `color.pagecolor` | `\pagecolor<spec>[model]{colour}`, applied through a `shipout/background` rule |
| background picture | background-image.tex:13-16 | `bg.eso-pic` | `\AddToHook{shipout/background}{\put(0cm, -\paperheight){\includegraphics[artifact, width = \paperwidth, height = \paperheight]{example-image-a}}}`, placed between frames so it starts at the second frame; the kernel hook is the same page-overlay type as eso-pic (considered a separate hook way, not proposed) |
| title frame | ltx-talk-title.dtx:118-153,236-297, footer-text.tex:13-16,21, titlepage-styling.tex:14-16,21, math-fonts.tex:16-24 | `front.class-native` | `\title[short-title = {..}]{..}`, `\subtitle`, `\author`, `\institute`, `\date`; `\maketitle[frame-style = wallpaper, horizontal-alignment = left]`; templates `titlepage` (element-order, frame-style, horizontal-alignment, vertical-alignment) and `titlepage-element` (before-skip, after-skip, color, font), title.dtx:169-221 |
| frames and slides | ltx-talk-frame.dtx:482-514,1016-1058, list-overlays.tex:9-15 | `class.ltx-talk` | `frame`, `frame*`; keys listed above; each slide is one page of height 100mm (frame.dtx:306-328) |
| overlays, pauses, actions | list-actions.tex:10, list-relative-overlays.tex:10,14, totalframes.tex:11, ltx-talk-overlay.dtx:165-170,261-268,324-328,375-385,523-533 | `class.ltx-talk` | `<+->`, `<.->`, `<alert@+>`, `\pause`, `\only`, `\uncover`, `\alert`, `actionenv`; decoding in ltx-talk-decode.dtx:170-525 (not `slide.beamer-mode`: the commands are the class's own) |
| hidden-material opacity | overlay-opacity.tex:7, ltx-talk-overlay.dtx:248-254 | `class.ltx-talk` | `\EditInstance{hidden}{std}{opacity = 0.15}` (default 0) |
| modes | ltx-talk.tex:210, ltx-talk.dtx:217-222, ltx-talk-mode.dtx:91-92 | `class.ltx-talk` | `mode = handout`, `\mode<..>{..}`, overlay specs like `<3\|handout:2>` (documented, not in a sample) |
| lists | list-overlays.tex:10-14, math-fonts.tex:34, ltx-talk-structure.dtx:769-784,789-795 | `list.kernel` | `itemize`/`enumerate`/`description` with `[<+->]`, `[<alert@+>]`, `[action-spec = <+->, item-vspace = 20pt, begin-vspace = 20pt]` (the last two keys belong to kernel list templates not in the zip); item label `\color{structure}#1` |
| blocks | ltx-talk-structure.dtx:652-672 (documented ltx-talk.tex:1236) | `class.ltx-talk` | `block` with overlay and title; title `\normalfont \large \bfseries`, colour `structure` |
| columns | ltx-talk-frame-structure.dtx:107-126,204-234 (documented ltx-talk.tex:1304-1311) | `class.ltx-talk` | `columns` (width, vertical-alignment b/c/t), `column{width}` (not `cols.minipage`: the class's own environments) |
| float environments | float-centering.tex:7,13-15, ltx-talk-frame-structure.dtx:254-290,306-332 | `fig.graphicx`, `fig.class-native` | `figure`/`table` with overlay argument and no placement; `\EditInstance{floatenv}{std}{horizontal-alignment = center}` (left default) |
| captions | ltx-talk-frame-structure.dtx:340-361 (documented ltx-talk.tex:1252) | `cap.kernel` | abovecaptionskip = belowcaptionskip = 7pt; no list of floats |
| images | ltx-talk-overlay.dtx:757-770, background-image.tex:15 | `fig.graphicx` | overlay-aware `\includegraphics` |
| text marks | ltx-talk-overlay.dtx:711-735 | `mark.kernel` | `\textbf` `\emph` etc. with overlay argument |
| footnotes | ltx-talk-frame-structure.dtx:390-420 | `fn.kernel` | `\footnote<spec>`, collected at frame foot, `fntext/process` socket |
| labels, frame counters | ltx-talk-overlay.dtx:781-787, totalframes.tex:16, ltx-talk-frame.dtx:888-908,920-924 | `xref.kernel` | `\label<1>{..}`; `\RefProperty{lastpage}{totalframes}` (kernel property reference; also `frames`, `appendixframes`) |
| sectioning | ltx-talk-structure.dtx:229-260,308-363, ltx-talk.tex:1782 | `head.class-native` | `\section` `\subsection` `\subsubsection` set marks and contents entries only (not typeset); keys `shorttitle` `numbered` `toc` `bookmark` `nameref` `running` |
| contents in a frame | ltx-talk-structure.dtx:505-545,579,615 | `front.class-native`, `num.secnumdepth` | `\tableofcontents`, bold structure-colour sections, non-current entries at opacity 0.2, `tocdepth = 2` |
| appendix | ltx-talk-structure.dtx:889-895 (documented ltx-talk.tex:1770) | `num.appendix` | `\appendix<mode spec>` |
| quotes | ltx-talk-structure.dtx:625-645 | `quote.kernel` | `quote` `quotation` `verse` with overlay argument |
| theorems, bibliography | ltx-talk-structure.dtx:817-842,851-873 | `thm.kernel`, `bib.thebibliography` | `\newtheorem` extended with overlay; hand-written `thebibliography` (defined, no sample uses them) |
| verbatim in frames | verbatim-content.tex:7,11,14, verbatim-alt-env.tex:7-8,13, ltx-talk-frame.dtx:1027-1037 | `code.verbatim` | `frame*` with `fancyvrb` `Verbatim[gobble = 6]`; no external files |
| maths | ltx-talk.dtx:342, math-fonts.tex:34-76 | `math.amsmath` | `amsmath` always loaded; display `\[ \]`, `\bigl`, `\frac` |
| links | ltx-talk.dtx:418-419 | `meta.hyperref` | `hyperref`, `hidelinks` |
| manual title block | ltx-talk.tex:74-89 | `front.maketitle`, `front.thanks` | `\title`, `\author`, `\date`, `\maketitle`, `\thanks` x2 |
| manual contents, headings | ltx-talk.tex:91,95,304-306 | `toc.kernel`, `head.class-native` | `\tableofcontents`; `\section` to `\paragraph` as styled by `l3doc` |
| manual lists, quote, verbatim | ltx-talk.tex:101,117,176,638 | `quote.kernel`, `list.kernel`, `code.verbatim` | `quotation`, `enumerate`, `verbatim`, `alltt` |
| manual units | ltx-talk.tex:35,242 | `mark.siunitx` | `\qty{100}{\mm}` |
| manual maths font | ltx-talk.tex:36 | `font.unicode-math` | `\usepackage{unicode-math}` |
| manual footnote | ltx-talk.tex:1521 | `fn.kernel` | one `\footnote` |
| manual cross-refs, links | ltx-talk.tex:96,162,228 | `xref.kernel`, `meta.hyperref` | `\label` `\ref`, `\url`, `\href` |
| l3doc markup | ltx-talk.tex:93,308,319,1977,1985 | `class.l3doc` | environments and commands listed under Class setting; `\PrintIndex` needs a `makeindex` pass, as the lib's index ways do |
| implementation document | ltx-talk-code.tex:54-55,95-104 | `dtx.doc` | `\EnableDocumentation`, `\EnableImplementation`, `\DocInput{..}` for ten .dtx files; macrocode shown is content |
| pagination | ltx-talk-code.tex:74-79 | `pgnum.pagenumbering`, `pg.break` | `\pagenumbering{roman}` then `arabic`, `\clearpage` |
| parts for the .dtx titles | ltx-talk-code.tex:83-88 | `head.kernel` | `\part{\@title}`, `\partname` = Part |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\acro` (expl3: lowercases the text unless the series is bold, then `\textsc`) | ltx-talk.tex:41-50, one call at :111 | yes, at that call only | inline `\textsc{ctan}` (`mark.kernel`): the argument `ctan` is lowercase, so both branches print the same; any uppercase argument would not reduce |
| `\email`, `\foreign`, `\opt` | ltx-talk.tex:53-55 | yes | aliases of `\href{mailto:..}{\nolinkurl{..}}` (`meta.hyperref`), `\textit`, `\texttt` (`mark.kernel`) |
| `\sarg` | ltx-talk.tex:57 | yes | `\texttt{<}\meta{..}\texttt{>}`; it calls l3doc's private `\__codedoc_meta:n`, assumed to be what `\meta` uses (l3doc source not read) |
| bookmark tidy `\pdfstringdefDisableCommands` | ltx-talk.tex:61-65 | yes | hyperref string setup (`meta.hyperref`), unneeded once the three macros above are expanded |
| `\filedate`, `\fileversion` | ltx-talk.tex:69-70, ltx-talk-code.tex:32-33 | yes | literal strings in the `\thanks` text (`front.thanks`) |
| `\maketitle` redefinition, `\partname`, empty expandable `\thanks` | ltx-talk-code.tex:83-89 | yes | per .dtx `\part{<title>}` (`head.kernel`), `\thanks` dropped |
| `\PrintIndex` postponed | ltx-talk-code.tex:91-92,107 | yes | one `\PrintIndex` after the last `\DocInput` (`dtx.doc`) |
| `\NewEnvironmentCopy{Frame}{frame*}` | verbatim-alt-env.tex:7,11,18 | yes | write `frame*` directly (kernel alias) |
| `shipout/background` hook with `\put` | background-image.tex:13-16 | yes | `bg.eso-pic` row above (image file and size are the values) |
| ltx-talk class code (expl3 slide and overlay machinery) | ltx-talk-frame.dtx:136-328, ltx-talk-overlay.dtx:149-152 | not a blocker | published class (CTAN release): the way is `class.ltx-talk`, not copied code |

## Content-opaque
none (only text; the images `example-image-a` (TeX Live `mwe`), `first`, `second`, `third` in the manual are named, not shipped; the Pennstander fonts at math-fonts.tex:10-13 and the New Computer Modern OpenType fonts at ltx-talk.dtx:372-374 are not shipped)

## Lib changes
- New ways proposed: none. Considered and not proposed: the kernel template interface (`\DeclareInstance`/`\EditInstance`) as a generic way, recorded under `hf.class-native`, `front.class-native`, `fig.class-native` because the template types are the class's own; the kernel `shipout/background` hook, merged into `bg.eso-pic`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
