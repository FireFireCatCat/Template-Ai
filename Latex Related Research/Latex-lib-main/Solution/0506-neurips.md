yes

# 0506-neurips: NeurIPS 2026 formatting kit (neurips_2026.sty over article)

- Unverified: read from the source, not compiled.
- Source: Source/0506-neurips/ (origin: https://media.neurips.cc/Conferences/NeurIPS2026/Formatting_Instructions_For_NeurIPS_2026.zip; licence: not established)
- Kind: conference
- Lib: v5 (the snapshot you read)
- Engine: pdfLaTeX-compatible (Times/Helvetica through `\rmdefault`/`\sfdefault` = ptm/phv, neurips_2026.sty:101-102; no fontspec; the sample itself says to use pdflatex, neurips_2026.tex:384)
- Look carried by: class (neurips_2026.sty, the publisher's own style package, loaded over `\documentclass{article}`; the lib treats a house style as class-like. The sample preamble adds only ordinary packages, neurips_2026.tex:53-61)
- Class origin: publisher-official
- Main file: neurips_2026.tex (other samples: checklist.tex, pulled in by `\input` at neurips_2026.tex:493)
- Read: main yes, zip-local classes and styles all (neurips_2026.sty, 443 lines, whole; there is no .cls)

## Verdict
The zip is NeurIPS's own formatting kit (manifest url is media.neurips.cc), so by the rubric's official-kit ruling `neurips_2026.sty` is a published way, `class.neurips_2026`, chosen by boolean/track options and a few strings. The sample adds only standard packages (inputenc, fontenc, hyperref, url, booktabs, amsfonts, nicefrac, microtype, xcolor) and kernel body constructs, all of which have lib ways. No external tool is needed and nothing template-defining is drawn (the title rules are plain `\hrule`). Sensitivity: read as if the style were zip-local, three items would be borderline (title author-separator macros, the `noticebox` float, the lineno/amsmath patch), listed in "Bespoke code"; the yes rests on the official-kit ruling, not on those reducing exactly.

## Blockers
none

## Class setting
- Class: `class.article` options: none (neurips_2026.tex:1). House style `class.neurips_2026` loaded at neurips_2026.tex:10 with no options (the default = anonymous submission with line numbers, sty:391-412). Options the style declares: `final` (sty:26), `preprint` (42), `nonatbib` (35), tracks `main` `position` `eandd` `creativeai` `education` `sglblindworkshop` `dblblindworkshop` (49-93), `nonanonymous` (94), command `\workshoptitle{}` (82); per-year strings `\@neuripsordinal` 40th and `\@neuripsyear` 2026 (105-106). The sample lists every option value only as commented lines (neurips_2026.tex:13-51).
- Class-native vocabulary used: `\title`, `\author` with `\\` and `\thanks` (neurips_2026.tex:64,76-105); `\And` and `\AND` (defined sty:344-351, shown only in comments at neurips_2026.tex:85-100); `\maketitle` (111); `abstract` environment as restyled (sty:369-381; used 114-116); `ack` environment (sty:112; used neurips_2026.tex:439-447); checklist macros `\answerYes` `\answerNo` `\answerNA` `\answerTODO` `\justificationTODO` (sty:384-388; used checklist.tex:9,34,35). Not used by the sample: `\workshoptitle`, `\acksection`.

## Component map
Rows marked (in style) are set inside `neurips_2026.sty`; an emitter gets them by loading the style, the ways named are what the style's lines are made of.
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | neurips_2026.tex:1 | `class.article` | no options (10pt, letterpaper by default) |
| house style | neurips_2026.tex:10; neurips_2026.sty:21-22,98 | `class.neurips_2026` | no options in sample; options and strings listed under Class setting |
| page geometry (in style) | neurips_2026.sty:128-141 | `page.geometry` | `[verbose=true,letterpaper]`, then `\newgeometry{textheight=9in,textwidth=5.5in,top=1in,headheight=12pt,headsep=25pt,footskip=30pt}` at `\AtBeginDocument` (left margin follows from 5.5in text width, centred) |
| columns | neurips_2026.sty:128-141 | `page.geometry` | one column (article default); no column way is set |
| header/footer | neurips_2026.sty:303 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` on the title page; later pages keep article's `plain` (no `\pagestyle` in sty or sample), numbers arabic |
| page flow (in style) | neurips_2026.sty:145 | `pg.flush` | `\flushbottom` |
| widow/club (in style) | neurips_2026.sty:143-144 | `sp.penalties` | `\widowpenalty=10000`, `\clubpenalty=10000` |
| hyphenation (in style) | neurips_2026.sty:146 | `sp.hyphenat` | `\sloppy` |
| text fonts (in style) | neurips_2026.sty:101-102 | `font.family-default` | `\rmdefault`=ptm, `\sfdefault`=phv; `\ttdefault` and math fonts left at default |
| encodings | neurips_2026.tex:53-54 | `font.fontenc-t1` | `[utf8]{inputenc}`, `[T1]{fontenc}` |
| font sizes (in style) | neurips_2026.sty:150-182 | `font.size-commands` | normalsize 10/11 (151), small 9/10 (159), footnotesize 8/9.5 (182), scriptsize 7/8 (179), tiny 6/7 (176), large 12/14 (168), Large 14/16 (169), LARGE 17/20 (170), huge 20/23 (171), Huge 25/28 (172) |
| display-math skips (in style) | neurips_2026.sty:152-155,160-163 | `sp.lengths` | abovedisplayskip 7pt plus 2pt minus 5pt (normal), 6pt plus 1.5pt minus 4pt (small); short skips 0pt plus 3pt / 4pt plus 3pt minus 3pt |
| paragraph shape (in style) | neurips_2026.sty:251-252 | `sp.lengths` | `\parindent`=0, `\parskip`=5.5pt |
| microtype | neurips_2026.tex:60 | `sp.microtype` | no options |
| colour | neurips_2026.tex:61; used neurips_2026.sty:384-388 | `color.xcolor` | no options; `\textcolor` names blue, orange, gray, red |
| headings | neurips_2026.sty:185-219; used neurips_2026.tex:120,126,219,225 | `head.kernel` | `\@startsection` redefinitions: section before -2.0ex plus -0.5ex minus -0.2ex, after 1.5ex plus 0.3ex minus 0.2ex, `\large\bf\raggedright` (186-191); subsection -1.8ex.../0.8ex plus 0.2ex, `\normalsize\bf\raggedright` (193-198); subsubsection -1.5ex.../0.5ex plus 0.2ex (200-205); paragraph run-in 1.5ex.../-1em, `\normalsize\bf` (207-212); subparagraph same (214-219); indent 0 throughout |
| flush-left heads | neurips_2026.sty:190,197,204 | `sp.ragged` | `\raggedright` in the section, subsection, subsubsection font arguments |
| unnumbered heads | neurips_2026.tex:449; checklist.tex:1 | `head.kernel` | `\section*{References}`, `\section*{NeurIPS Paper Checklist}`; `secnumdepth` not touched |
| title block (in style) | neurips_2026.sty:290-310,326-356; used neurips_2026.tex:64,76-105,111 | `front.maketitle` | restyled `\maketitle`: group with `\fnsymbol` footnote marks, `\thispagestyle{empty}`, `\@maketitle`, then `\@thanks` and `\@notice`; title `{\LARGE\bf \@title\par}` centred in a vbox of `\textwidth`; author in `tabular[t]{c}` with `\bf\rule{0pt}{24pt}`; anonymous mode prints the fixed block "Anonymous Author(s) / Affiliation / Address / email" (336-342); closing `\vskip 0.3in \@minus 0.1in` |
| author separators | neurips_2026.sty:344-351 | `front.class-native` | `\And` = close tabular, `\hfil\linebreak[0]\hfil`, open tabular; `\AND` same with `\linebreak[4]` |
| title rules (in style) | neurips_2026.sty:313-323 | `sp.rule` | `\hrule height 4\p@` then `\vskip 0.25in` minus `\parskip` (314-316); `\vskip 0.29in` minus `\parskip`, `\hrule height 1\p@`, `\vskip 0.09in` (319-322); with `sp.manual-space` for the skips |
| author notes | neurips_2026.sty:294-302; neurips_2026.tex:77 | `front.thanks` | `\thefootnote` = `\fnsymbol`; `\@makefnmark` = zero-width hbox of `$^{..}$`; `\@makefntext` `\parindent 1em`, hbox 1.8em; `\thanks` text is not printed in the default anonymous mode because `\@author` is not expanded (336-342) |
| conference notice (in style) | neurips_2026.sty:359-366,391-403 | `front.class-native` | float type `noticebox` placed `[b]` at the end of `\maketitle`, `\footnotesize` string: "Preprint." (preprint), the track string (final), "Submitted to ... Do not distribute." (default) |
| first-page room | neurips_2026.sty:362 | `pg.enlarge` | `\enlargethispage{2\baselineskip}` |
| abstract (in style) | neurips_2026.sty:369-381; used neurips_2026.tex:114-116 | `abs.class-native` | `\vskip 0.075in`, `\centerline{\large\bf Abstract}`, `\vspace{0.5ex}`, then a `quote` environment (indent from `\leftmargin`=3pc, sty:259), closing `\par`, `\vskip 1ex` |
| abstract body | neurips_2026.sty:375-379 | `quote.kernel` | the `quote` environment inside the abstract; plain quotes at neurips_2026.tex:259-261 |
| lists (in style) | neurips_2026.sty:255-287; used neurips_2026.tex:154-157,381; checklist.tex:8,20,30,37,85 | `list.kernel` | topsep 4pt plus 1pt minus 2pt, partopsep 1pt plus .5pt minus .5pt, itemsep and parsep 2pt plus 1pt minus .5pt, leftmargin 3pc, leftmarginii 2em, iii 1.5em, iv 1em, v .5em; `\@listi`..`\@listvi` redefined (265-287) with deeper-level topsep/parsep/itemsep (269-278); checklist uses `enumerate` with `\item[]` field lines and nested `itemize`/`enumerate` |
| marks | neurips_2026.tex:83,130,161,466; neurips_2026.sty:190 | `mark.kernel` | `\textbf`, `\emph`, `\texttt`, `{\bf }`, `{\it }` |
| footnotes (in style) | neurips_2026.sty:245-248; used neurips_2026.tex:289,295 | `fn.kernel` | `\footnotesep` 6.65pt, `\skip\footins` 9pt plus 4pt minus 2pt, `\footnoterule` = `\kern-3pt \hrule width 12pc \kern 2.6pt` (`sp.rule`), footnote counter reset |
| float placement (in style) | neurips_2026.sty:226-229 | `fig.placement` | topfraction .85, bottomfraction .4, textfraction .1, floatpagefraction .7 |
| captions (in style) | neurips_2026.sty:231-242 | `cap.kernel` | `\abovecaptionskip` 7pt, `\belowcaptionskip` 0pt (231-235); `table` renewed to swap the two (238-242), so figure captions sit below and table captions above |
| figure | neurips_2026.tex:301-305 | `fig.graphicx` | kernel `figure` float only (graphicx is not loaded in the sample), `\centering`, `\caption` below; the artwork is a placeholder `\fbox{\rule..}` (content) |
| table | neurips_2026.tex:341-356 | `tbl.tabular` | `\caption` then `\label`, `\centering`, `{lll}`, `\multicolumn{2}{c}{Part}` |
| table rules | neurips_2026.tex:57,346-354 | `tbl.booktabs` | `\toprule`, `\cmidrule(r){1-2}`, `\midrule`, `\bottomrule` |
| math | neurips_2026.tex:58-59,115,349-353,403 | `math.kernel` | inline maths only (`$\mu$`, `$\approx$`, `$10^6$`) |
| math symbols | neurips_2026.tex:58,403 | `math.amssymb` | `amsfonts` loaded, `\mathbb` shown |
| fractions | neurips_2026.tex:59,115,181,187 | `math.nicefrac` | `\nicefrac{1}{2}` |
| code | neurips_2026.tex:150,255-257,266-268 | `code.verbatim` | `\verb+..+` and `verbatim` environment |
| hyperlinks | neurips_2026.tex:55 | `meta.hyperref` | no options, no `\hypersetup` |
| url | neurips_2026.tex:56,145,251,336,443 | `meta.url` | `\usepackage{url}`, `\url{}` calls |
| cross-references | neurips_2026.tex:170,174,323,343 | `xref.kernel` | `\label`, `\ref`, `Table~\ref{..}` |
| centred blocks | neurips_2026.tex:144-146,250-252,335-337 | `sp.ragged` | `center` environment |
| citations | neurips_2026.sty:34-37,119-121 | `bib.natbib` | loaded unless `nonatbib`; no options passed; `\citet` appears only inside `verbatim` (neurips_2026.tex:253-257) |
| reference list | neurips_2026.tex:449-478 | `head.kernel` | `\section*{References}`, `\medskip` (`sp.manual-space`, 457), a `\small` group (`font.size-commands`, 461); the three entries are typed as plain `[n]` paragraphs (content), no `thebibliography` or `.bib` |
| acknowledgments (in style) | neurips_2026.sty:110-115,406-408; used neurips_2026.tex:439-447 | `front.class-native` | `ack` from `\NewEnviron` (package `environ`): `\section*{Acknowledgments and Disclosure of Funding}` plus body; in the default and other non-final modes `\let\ack\hide` discards the body |
| line numbers (in style) | neurips_2026.sty:411-412 | `sp.draft-lineno` | `\RequirePackage{lineno}` and `\linenumbers`, only in default submission mode (not `final`, not `preprint`) |
| appendix | neurips_2026.tex:483-485 | `num.appendix` | `\appendix`, `\section` |
| page break, inclusion | neurips_2026.tex:492-493 | `pg.break` | `\newpage`; the checklist is pulled in by `struct.input` (`\input{checklist.tex}`) |
| checklist answers (in style) | neurips_2026.sty:384-388; used checklist.tex:34 | `color.xcolor` | `\answerYes` = `\textcolor{blue}{[Yes]#1}`, `\answerNo` orange `[No]`, `\answerNA` gray `[N/A]`, `\answerTODO` and `\justificationTODO` red bold `[TODO]` (`mark.kernel`) |

## Bespoke code
All of it sits in the publisher's own `neurips_2026.sty` and is counted inside `class.neurips_2026`. The last column is the status if the style were read as zip-local.
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option booleans and track strings | neurips_2026.sty:25-98,391-403 | yes | the emitter picks option values; the notice text per mode is a string |
| size commands with display skips | neurips_2026.sty:150-182 | yes | `font.size-commands` plus `sp.lengths` |
| `\@startsection` sectioning | neurips_2026.sty:185-219 | yes | `head.kernel` (or `head.titlesec` `\titleformat`/`\titlespacing`) with the values in the table; the argument-less `\subsubsubsection` (221-223) is unused by the sample |
| list-level parameters | neurips_2026.sty:255-287 | yes | `list.kernel` with `sp.lengths`, or `list.enumitem` per level |
| `table` environment renewal | neurips_2026.sty:238-242 | yes | `cap.kernel` lengths set per float, or `cap.caption` above/below skips per float type |
| `ack` / `hide` via `environ` | neurips_2026.sty:110-115,406-408 | yes | inline expansion per mode: `head.kernel` `\section*{...}` plus text (final), nothing (default); `environ` has no lib way (considered: environ, a macro-definition helper, so not a component) |
| checklist answer macros | neurips_2026.sty:384-388 | yes | aliases of `\textcolor` and `\bf`, inlined |
| `abstract` environment | neurips_2026.sty:369-381 | yes | `quote.kernel` plus `\centerline`, `font.size-commands`, `sp.manual-space` |
| `\maketitle`, `\@maketitle`, rules | neurips_2026.sty:290-323,326-356 | partly | rules, skips, fonts and the tabular author block reduce to `sp.rule`, `sp.manual-space`, `tbl.tabular`, `front.titling`; the `\And`/`\AND` tabular-splitting macros (344-351) are macro logic. Strict reading: borderline BESPOKE/class |
| `noticebox` float | neurips_2026.sty:359-366 | partly | a kernel float type with a hard-coded `\ftype@noticebox` number, filled once at `\maketitle`; nearest lib forms `fig.float` `\newfloat` plus `pg.enlarge`, not an exact match. Strict reading: borderline BESPOKE/class |
| lineno and amsmath patch | neurips_2026.sty:417-438 | partly | a helper loop that let-copies and renews 12 amsmath environments with `\linenomath` (`sp.draft-lineno`, `math.amsmath`); inline expansion is possible but it patches amsmath internals. Dormant in the sample (amsmath is not loaded, neurips_2026.tex:53-61). Strict reading: borderline BESPOKE/class |
| `\@neuripslocation` | neurips_2026.sty:107 | yes | defined, never used (grep over sty) |

Observation, not a blocker: `\@trackname` is only defined by a track option (sty:51-92) and there is no `\ExecuteOptions`, so `final` without a track option would leave it undefined at neurips_2026.sty:398, although neurips_2026.tex:11 says the default equals `main`.

## Content-opaque
- figure artwork placeholder `\fbox{\rule[-.5cm]{0cm}{4cm} \rule[-.5cm]{4cm}{0cm}}` inside the figure float (neurips_2026.tex:303)
- the three reference entries typed as paragraphs (neurips_2026.tex:464-477)
- no images, fonts or other assets are shipped or needed.

## Lib changes
- New ways proposed: none (`class.neurips_2026` is a class way and is written plainly; considered: environ, no component way).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
