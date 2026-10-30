no

# 0485-sddevelopment-be-dojicv: DojiCV (zip-local `developercv` class, "Developer CV - Doji edit")

- Unverified: read from the source, not compiled.
- Source: Source/0485-sddevelopment-be-dojicv/ (origin: https://codeload.github.com/sddevelopment-be/DojiCV/zip/refs/heads/master; licence: MIT, LICENSE.md:1 names Jan Vorisek)
- Kind: cv
- Lib: v4
- Engine: pdfLaTeX-compatible (nothing needs `fontspec`, Lua or XeTeX: `raleway`, `fontawesome`, `eurosym`, `ocgx2`, TikZ are all loaded in src/template/developercv.cls:47-68,95,101,144; not compiled)
- Look carried by: zip-local (the whole look is in `src/template/developercv.cls`; main.tex has no preamble beyond the class line)
- Class origin: zip-local (a GitHub fork, "Doji edit", of the latextemplates.com "Developer CV" template, src/template/developercv.cls:2,8-10; `https://ctan.org/pkg/developercv` returned 404, so not on CTAN; not an official release; it loads the published `extarticle`)
- Main file: src/main.tex (other samples: src/playful_example.tex, src/serious_example.tex with src/template/header.tex)
- Read: main yes, zip-local classes and styles all (developercv.cls 478 lines, header.tex 30 lines; both read in full; playful_example.tex read in full, serious_example.tex lines 1-110 only, which repeat main.tex)

## Verdict
No. Every ordinary piece of this CV (page geometry, Raleway sans, colours, FontAwesome icons, tag chips, rating dots, the entry table, minipage columns) reduces to lib ways by inline expansion. Two class macros do not: the section heading `\cvsect` places its dashed rule from the width left in TeX box register 0 by an earlier, unrelated `\setbox0`, and pulls it onto the label with a negative `\vspace`; the tag chips go through `\vcenteredhbox`, which measures a box in register 0 and re-boxes it. Both are hand-rolled box-and-glue code, used all over main.tex, and no lib way expresses them. The skills bar chart and bubble macros are counter-driven TikZ code too (unused by main.tex).

## Blockers
- `BESPOKE/class` `\cvsect` section heading: `\setlength{\@tempdima}{\dimexpr\wd0}` reads leftover box 0, then `\vspace{-2\baselineskip}` and `\hspace{1\@tempdima}` overlay a `\hdashrule` on a `tcolorbox` label (src/template/developercv.cls:310-318, wd0 at :312; used at src/main.tex:93,178,195,213,254,382)
- `BESPOKE/class` `\vcenteredhbox` measure-and-rebox (`\setbox0=\hbox{#1}\parbox{\wd0}{\box0}`), under every tag chip `\techit`/`\techlist`/`\skilllist` (src/template/developercv.cls:162-166,326-330,333-367; used at src/main.tex:113,131,149,219)
- `BESPOKE/class` `barchart`/`\baritem` skills bar chart: `\pgfmathparse` arithmetic, `\let`, counter `barcount`, nested `\newcommand` inside the environment (src/template/developercv.cls:236-266); not used by main.tex (commented out at src/main.tex:76-86), used at src/playful_example.tex:207-211; the drawn bars are content-like, listed here because the macro is class code
- `BESPOKE/class` `\bubbles`/`\bubble` counter-driven TikZ loop (counters `a` `b` `c`; `\theb` is never set) (src/template/developercv.cls:270-292); dead code, no sample calls it

## Class setting
- Class: `class.extarticle` (extsizes bundle, base of `\LoadClass` at src/template/developercv.cls:33), options: `9pt` (src/main.tex:20; reaches extarticle through `\DeclareOption*` at developercv.cls:30). `green` is not declared by developercv, so it is also passed to extarticle (developercv.cls:30); the default palette is green anyway (developercv.cls:117-125). The wrapper `developercv` is zip-local, so there is no `class.developercv`; extarticle source not in the zip, not read.
- Class-native vocabulary used: none from extarticle (no `\maketitle`, `abstract` or sectioning command in main.tex). The vocabulary the sample uses is the zip-local one: options `gdpr` `blue` `square` (developercv.cls:24-29), commands `\cvsect` `\entry` `entrylist` `\cvskill` `\skillsect` `\techlist` `\skilllist` `\techit` `\itemmarker` `\linkage` `\speciality` `\img` `\linkedin` `\github` `\email` `\callme` `\lorem` and the separators `\cpipe` `\fcpipe` `\bpipe` `\band` `\cand` `\amp` (developercv.cls:198-229,310-453).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | src/main.tex:20; src/template/developercv.cls:33 | `class.extarticle` | 9pt; options gdpr/blue/square are zip-local switches (developercv.cls:24-29) |
| page size and margins | developercv.cls:74-86 | `page.geometry` | paper=a4paper, top=1.75cm, bottom=1.75cm, left=2cm, right=2cm, headheight=0.75cm, footskip=1cm, headsep=0.5cm |
| header and footer | developercv.cls:45 | `hf.pagestyle-kernel` | pagestyle empty |
| paragraph and table lengths | developercv.cls:39,374-375,377 | `sp.lengths` | parindent=0mm, LTpre=0pt, LTpost=0pt, tabcolsep=0pt |
| font encoding | developercv.cls:92-93 | `font.fontenc-t1` | inputenc utf8, fontenc T1 |
| text face | developercv.cls:95 | `font.helvet` | `raleway` package, option default (a sans text-face package is the parameter) |
| default family | developercv.cls:139 | `font.family-default` | `\renewcommand*\familydefault{\sfdefault}` |
| extra size switches | developercv.cls:47; src/main.tex:52,61 (`\ssmall`), 42 (`\Huge`) | `font.size-commands` | `moresize` supplies `\HUGE` `\ssmall` (values come from the package's size table, not in the zip); `\fontsize{4}{5}\selectfont` at main.tex:219; `\fontsize{3}{4}` at developercv.cls:316; considered: moresize as its own way, rejected (same type of effect, package is the parameter) |
| icon glyphs | developercv.cls:101,144,170-179,407; src/main.tex:198,202,207 | `font.icons` | `fontawesome` (`\faAt` `\faPhone` `\faLinkedin` `\faGithub` `\faChain` `\faCircle` `\faGlobe` `\faHeart` `\faTrophy` `\faCheckSquare` `\faBriefcase` `\faRefresh`), `eurosym` option official |
| colour definitions | developercv.cls:60,103,105-125 | `color.xcolor` | `\definecolor{...}{HTML}{...}` x10 (calmBlue 2073ba, darkCalmBlue 1a5c95, blackishBlue 1d2933, highlightGray e7e7e7, vibrantGreen 64b613, calmGreen 63a026, darkGreen 356803, blackishGreen 202917, highlightGreen cdd5cc), `\colorlet` roles background, accentbackground, text, body, soft=`highlightGreen!75!body`, accent, heading, emphasis |
| blue palette switch | developercv.cls:127-137 | `color.xcolor` | the same `\colorlet` roles re-pointed at the blue colours; a static class option, resolved by the emitter |
| document text colour | developercv.cls:455-457 | `color.xcolor` | `\AtBeginDocument{\color{text}}`, printed as `\color{text}` at the start of the body |
| xcolor option | src/main.tex:21 | `color.xcolor` | `\PassOptionsToPackage{dvipsnames}{xcolor}` after `\documentclass`, when xcolor is already loaded (developercv.cls:60), so its effect is not established; no dvips colour name is used in main.tex |
| hyperlink options | developercv.cls:41,61 | `meta.hyperref` | `hidelinks` (second plain load at :61 keeps it) |
| links in text | src/main.tex:62,65,68,98,104; developercv.cls:204,228 | `xref.hyperref` | `\href{url}{text}`, `\href{mailto:..}`, `\href{tel:..}` |
| title block (no `\maketitle`) | src/main.tex:33-74 | `box.minipage` | three `minipage[t]` at 0.12, 0.63, 0.22 `\textwidth`, top-aligned by `\vspace{-\baselineskip}` and `\vspace{-.38cm}` |
| name boxes | src/main.tex:42-46 | `box.fancybox` | `\colorbox{accent}{{\Huge\textcolor{white}{\textbf{\MakeUppercase{..}}}}}` x3 with `\hspace{-2pt}` between; also `mark.kernel`, `mark.case`, `color.xcolor`, `sp.manual-space` |
| photo | src/main.tex:37; developercv.cls:198 | `fig.graphicx` | `\img` = `\colorbox{accent}{\includegraphics[width=0.8\linewidth]{..}}` (also `box.fancybox`) |
| job title line and specialities | src/main.tex:49,52; developercv.cls:219,229 | `font.size-commands` | `\LARGE`, `\ssmall`; `\speciality` = `\textcolor{accent}{\MakeUppercase{\textbf{..}}}` (`color.xcolor`, `mark.case`, `mark.kernel`); `\fcpipe`/`\bpipe` pipes (developercv.cls:216-220) |
| contact lines | src/main.tex:58-71; developercv.cls:181,202-211 | `font.icons` | `\printinfo` = `\mbox{\textcolor{accent}{icon}\hspace{0.5em}text\hspace{2em}}` (`color.xcolor`, `sp.manual-space`, `xref.hyperref`) |
| section headings | developercv.cls:310-318; src/main.tex:93,178,195,213,254,382 | `box.tcolorbox` | label from `\mybox` (tcolorbox: colback=accentbackground, colframe=accentbackground, boxrule=0.5pt, arc=4pt, left/right/top/bottom=5pt, boxsep=0pt, width = text width + 11pt = natural `\tcbox` width), then `sp.rule` `\hdashrule{0.95\textwidth minus 1.1\@tempdima}{0.8pt}{0.25ex}` coloured `accentbackground!85`, then `box.fancybox` end mark `\colorbox` with `\fontsize{3}{4}\faCircle`; the placement is the blocker (see Bespoke code) |
| entry list | developercv.cls:373-399; src/main.tex:95-169 | `tbl.longtable` | `longtable[H]{l l}` used as one column; `\entry{date}{sub}{qualifier}{text}{heading}` = two `\parbox[t]` of 0.175 and 0.825 `\textwidth` (`box.minipage`), date `\small` colour soft, heading bold colour accentbackground, `\hfill`, qualifier `\footnotesize\textbf` colour text, `\\`, `\vspace{2mm}`, `\small` colour text!85, `\vspace{0.1cm}`, description `\normalsize`, closed by `\\\\\\\\` (four row ends) |
| bullets in entries | developercv.cls:406; src/main.tex:104-109 | `sp.manual-space` | `\itemmarker` = `\textcolor{background}{\small\textbullet\space}`, lines ended by `\\` and `\vspace{-3mm}\\` inside `minipage[t]{0.75\textwidth}`; not a list environment |
| tag chips | developercv.cls:320-331,333-367; src/main.tex:113,131,149,219 | `box.fancybox` | `\colorbox{soft!52}{\textcolor{white}{\MakeUppercase{\textbf{..}}}}` at `\tiny`, `\hspace{-2.8mm}` between chips, label `\scriptsize` colour `soft!55!darkCalmBlue`, two minipages 0.10 and 0.85 `\textwidth`; the wrapper `\vcenteredhbox` is a blocker |
| three-column block | src/main.tex:176,193,211 | `cols.minipage` | `minipage[t]` of 0.28, 0.32, 0.32 `\textwidth` joined by `\hfill`; nested `minipage[t]{\linewidth}` at :216-243 (`box.minipage`) |
| language lines | src/main.tex:181-190 | `sp.manual-space` | `\small\textbf{..}\hfill{\ssmall ..}` per line (`mark.kernel`, `font.size-commands`) |
| skill rows | developercv.cls:444-453; src/main.tex:259-309 (50 `\cvskill`) | `font.icons` | `\skillsect` = `\large \textcolor{accent}{\faCheckSquare \hspace{2mm} \textbf{..}}`; `\cvskill{label}{n}` = bold label, `\hfill`, five `\faCircle` (`\foreach` + `\ifnumgreater`): colour `emphasis` up to n, `body!30` after; the emitter unrolls the five glyphs; then `\divider` |
| dividers | developercv.cls:404 | `sp.rule` | `\textcolor{body!25}{\hdashrule{\linewidth}{0.6pt}{0.5ex}}\medskip` (`dashrule` is the parameter) |
| two-column skills page | src/main.tex:254-376 | `box.minipage` | two `minipage[t]{0.45\textwidth}` joined by `\hfill`, groups spaced by `\vspace{8mm}`, `\hspace{7mm}` indents |
| page break | src/main.tex:249 | `pg.break` | `\clearpage` |
| manual spacing | src/main.tex:33,35,47,92,94,175 | `sp.manual-space` | `\hspace`, `\vspace` (positive and negative) and `\\` everywhere |
| elevator pitch | src/main.tex:381-389 | `font.size-commands` | `{\small ...}` with `\hspace{10pt}`; `\lorem` is filler text (content) |
| images | developercv.cls:49 | `fig.graphicx` | `graphicx`, used by `\img` and header.tex:5 (`\includegraphics[width=0.55\linewidth]{img/header}`) |
| math symbols | developercv.cls:59,64 | `math.amssymb` | `amssymb`, loaded twice, load-only |
| multirow, tabularx | developercv.cls:52 | `tbl.multirow` | load-only, no sample calls it; `tabularx` is `tbl.tabularx` (same line) |
| changepage | developercv.cls:53 | `page.adjustwidth` | load-only, never called |
| enumitem, tasks | developercv.cls:57,63 | `list.enumitem` | load-only, never called; `tasks` is `list.paralist` |
| mdframed | developercv.cls:65 | `box.mdframed` | `framemethod=TikZ`, load-only, never called |
| TikZ and its libraries | developercv.cls:54-55,157-159 | `art.tikz` | `arrows`, `shapes`, `backgrounds` libraries, `\tikzset{x=1cm, y=1cm}`; only the class's own `barchart`, `\bubbles`, `\cvtag` and the playful sample draw with it; nothing in main.tex draws |
| tcolorbox skins | developercv.cls:56 | `box.tcolorbox` | option `skins`, used by `\mybox` |

Packages with no printed effect of their own, so not components (cf. the lib v4 note on `sys.compat-load`): `etoolbox` (`\ifnumgreater` inside `\cvskill`), `calc`, `pgffor` (`\foreach` inside `\cvskill`, `\techlist`, `\bubbles`), `listofitems`, `ocgx2` (developercv.cls:50,62,66-68); no sample calls `ocgx2` or `listofitems`.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `developercv` (wrapper) | developercv.cls:21-479 | partly | `class.extarticle` 9pt + the preamble rows above; reducible except the two items below |
| `\cvsect` + `\mybox` | developercv.cls:300-318 | **no** | `\mybox` alone is a `box.tcolorbox` fit-to-content label (`\tcbox` has the same natural width). `\cvsect` is not: `\@tempdima` takes `\wd0` before `\mybox` runs, so the rule start is the width of whatever `\setbox0` last left in the current group (the previous heading's text, or a colour-box), the label is a display box pulled back by `\vspace{-2\baselineskip}`, and the dashed rule shrinks by `minus 1.1\@tempdima`. A heading built from `head.titlesec` + `box.tcolorbox` + `sp.rule` would rebuild the idea, not this placement |
| `\vcenteredhbox` | developercv.cls:162-166 | **no** | box-register measurement and re-boxing; `box.minipage` takes a given width, not a measured one; no lib way names it; the tag chips, `\icon` and `\techln` sit on it |
| `barchart`, `\baritem` | developercv.cls:236-266 | **no** | `\pgfmathparse` and `\let` arithmetic, counter `barcount`, `\newcommand` defined inside the environment, a TikZ `\filldraw` per bar; a pgfplots bar chart would be `art.tikz` content, not this macro |
| `\bubbles`, `\bubble`, counters a b c | developercv.cls:270-292 | **no** | counter-driven `\foreach` over `size/label` pairs, `1\p0` string trick, `\theb` unset; unused in all samples |
| `\cvskill`, `\techlist`, `\skilllist` loops | developercv.cls:333-367,446-453 | yes | `\foreach`/`\ifnumgreater` over a known list or rating: the emitter writes the unrolled boxes or five glyphs (inline expansion); `\techlist` and `\skilllist` still contain `\vcenteredhbox` through `\techit` |
| `gdpr`, `blue`, `square` options and `\if@gdpr` `\if@blue` `\if@square` | developercv.cls:24-29,127-137,184-197,313-317 | yes | each is set once by a class option and never changes; the emitter chooses the branch (colour roles, literal `[ redacted ]`, heading variant). The `square` variant of `\cvsect` (:314) has the same `\wd0` coupling |
| `\entry`, `entrylist`, `\cvref`, `\relation`, `\skillsect`, `\img`, `\gdprimg` | developercv.cls:373-399,417-435,198,191-197,444 | yes | compositions of `tbl.longtable`, `box.minipage`, `box.fancybox`, `fig.graphicx`, `color.xcolor`, `sp.manual-space`, `font.size-commands` with the parameters listed above (`\\\\\\\\` kept as four `\\`) |
| contact and info commands `\email` `\phone` `\linkedin` `\github` `\location` `\homepage` `\twitter` `\orcid` `\kbo` `\business` `\revision` `\callme` `\mailaddress`, `\printinfo`, `\printinfop` | developercv.cls:181-182,199-214 | yes | icon + `\textcolor{accent}` + `\href`; `\orcidsymbol` uses `\aiOrcid` from `academicons`, which is not loaded (not called in any sample); `\name` `\tagline` `\photo` only store values (:199-201) |
| separators and small aliases `\pipe` `\spipe` `\cpipe` `\fcpipe` `\bpipe` `\amp` `\cand` `\dand` `\band` `\tag` `\tagsep` `\slashsep` `\itemmarker` `\ratingmarker` `\linkage` `\speciality` `\lorem` `\tagbox` `\tagboxsquare` `\techit` `\techln` | developercv.cls:216-229,320-331,402-407,43 | yes | `\newcommand` aliases of `mark.kernel`, `color.xcolor`, `font.icons`, `xref.hyperref`, `mark.case` (`\tagbox` family inherits the `\vcenteredhbox` blocker) |
| `\cvtag` | developercv.cls:409-411 | yes (unused) | a single `\tikz` node; `art.tikz`, not called |
| `\icon` | developercv.cls:147-151 | no (unused) | uses `\vcenteredhbox` and `\makebox(#2,#2)`; not called in any sample |
| `\AtBeginDocument{\color{text}}` | developercv.cls:455-457 | yes | `color.xcolor`, `\color{text}` at the body start |
| `\smartdiagramset{...}` | developercv.cls:460-479 | yes | declarative keys of the published `smartdiagram` (`art.tikz`), colour list of `highlightGreen`, opacity 0.6; a diagram of content |

## Content-opaque
- `\smartdiagram[bubble diagram]` of six words at src/playful_example.tex:102-108 (`art.tikz`, a skills diagram; not in main.tex).
- TikZ circular photo crop `\tikz\path[fill overzoom image={img/george}]circle[radius=0.5\linewidth]` at src/playful_example.tex:36 (image content with a clip; not in main.tex).
- The bar-chart data lines (src/playful_example.tex:207-211) as content; the macro itself is listed under Blockers.
- Dummy text from `\lorem` (developercv.cls:43; main.tex:124,386-389).

## Lib changes
- New ways proposed: none. Considered: moresize as a way of its own (rejected; same type of effect as `font.size-commands`), a way for box-register measuring (rejected; it is TeX primitive programming, fails W2 to W4), `etoolbox`/`pgffor`/`listofitems` as a programming way (rejected; they only run inside zip-local macros, which reduce by unrolling).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
