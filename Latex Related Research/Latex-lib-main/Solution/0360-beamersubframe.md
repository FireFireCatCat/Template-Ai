no

# 0360-beamersubframe: beamersubframe (BeamerSubFrame package, v0.2)

- Unverified: read from the source, not compiled.
- Source: Source/0360-beamersubframe/ (origin: https://mirrors.ctan.org/macros/latex/contrib/beamer-contrib/beamersubframe.zip; licence: lppl1)
- Kind: presentation
- Lib: v3
- Engine: pdfLaTeX-compatible (only classic `\write`, `\openout`, `\input` file I/O; no `\pdf*`, Lua or fontspec: grep of beamersubframe.dtx)
- Look carried by: mixed (the example's look is the default beamer class; frame order comes from the published `beamersubframe` package, whose source is the code lines of beamersubframe.dtx; the manual's look is `ltxdoc` plus a bespoke preamble at beamersubframe.dtx:51-134)
- Class origin: tex-distribution-unbundled (example: `beamer`; manual: `ltxdoc`; neither is in the zip. The zip itself is the CTAN release of the package, ctan.org/pkg/beamersubframe, v0.2, LPPL 1)
- Main file: beamersubframe.dtx (no standalone .tex exists. The dtx holds the manual driver at :40-138 and the example sample at :2239-2354, which beamersubframe.ins:51 generates as bsf-example.tex) (other samples: the example, as said; no others)
- Read: main yes (all 2354 lines of the dtx, also README and beamersubframe.ins), zip-local classes and styles none present (the .sty exists only as the code lines of beamersubframe.dtx, read in full)

## Verdict
`no`. The package and its example map to the lib: the package is published (CTAN, beamer-contrib), is chosen by three options and wraps frames, so it is proposed as `slide.beamersubframe`, and the example's preamble and body reduce to lib ways. What blocks is the manual's driver preamble (beamersubframe.dtx:51-134), which extends doc.sty and hypdoc by redefining `\m@cro@` and adding an `\option` description environment with its own index commands: internals-level code that no lib way expresses. The unprefixed dtx lines include this driver, so it is in scope. If a reviewer rules the manual driver out of scope, everything left maps completely and the answer would turn to `yes`; the verdict is sensitive to that ruling.

## Blockers
- `BESPOKE/preamble` doc.sty extension in the manual driver: `\DescribeOpt` and `\Describe@Opt` (beamersubframe.dtx:55-59), `\SpecialOptIndex` built on hypdoc internals `\HD@target` and `\c@HD@hypercount` (:60-78), the `\option` environment (:88-90), a redefinition of doc.sty's `\m@cro@` with a third `\ifcase` branch (:92-123), `\SpecialMainOptIndex` (:126-133)

## Class setting
- Class: `class.beamer` options: none; no `\usetheme`, so the default beamer theme (beamersubframe.dtx:2240). Second document, the manual: `class.ltxdoc` options: none (beamersubframe.dtx:41).
- Class-native vocabulary used: beamer: `frame` with a default overlay spec and `[label=...]` (:2276), `{title}` argument and `\frametitle` (:2285, :2295), `\againframe<3->{lfoo}` (:2307), `\uncover<n>` `\visible<0>` (:2247, :2252), `\hyperlink` with `\beamergotobutton` `\beamerskipbutton` `\beamerreturnbutton` (:2247-2252), overlay-aware `\newcommand<>` (:2246), `\defbeamertemplate*` (:2259), `itemize[<+->]` (:2268), colours `fg` `bg` (:2262). ltxdoc: `\DocInput` (:136), `macrocode`/`macro`/`environment` (:1046, :1073, :1916), `\DescribeMacro` `\DescribeEnv` (:307, :332), `\StopEventually{\newpage\PrintIndex}` (:1038), `\Finale` (:2235), `\changes` (:193), `\CheckSum` (:29), `\DoNotIndex` (:143), `\EnableCrossrefs` `\CodelineIndex` (:47-48), counter `IndexColumns` (:46), short verb `|...|` (:288), `\meta` (:353), `\bslash` (:321).

## Component map
Paths are beamersubframe.dtx unless another file is named. Part A is the example sample, part B the manual driver and body, part C the package code.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| A. document class | beamersubframe.dtx:2240 | `class.beamer` | no options |
| A. fonts | beamersubframe.dtx:2241 | `font.lmodern` | `\usepackage{lmodern}` |
| A. encoding | beamersubframe.dtx:2242 | `font.fontenc-t1` | `\usepackage[T1]{fontenc}` |
| A. frame reordering, mode | beamersubframe.dtx:2244 (options declared :1177, :1183, :1189) | `slide.beamersubframe` | option `append` (others: `embed` default, `nominiframes`) |
| A. subframe wrappers | beamersubframe.dtx:2285-2292, :2294-2305, :2318-2329, :2331-2341 | `slide.beamersubframe` | environment `subframe` with `[label=ldfoob]`, `{title}` or inner `\frametitle`; same arguments as `frame` |
| A. append call | beamersubframe.dtx:2352 | `slide.beamersubframe` | `\appendsubframes` once, right before `\end{document}` |
| A. frames, overlays, frame reuse | beamersubframe.dtx:2267-2283, :2307, :2343-2350 | `slide.beamer-mode` | `frame`, `<1-2>`, `[label=lfoo]`, `\againframe<3->{lfoo}` |
| A. frame lists | beamersubframe.dtx:2268-2273 | `list.kernel` | `itemize[<+->]` (beamer overlay spec as option) |
| A. mode-dependent links | beamersubframe.dtx:2246-2257 (called :2279, :2304, :2314, :2328, :2340) | `slide.beamersubframe`, `slide.beamer-mode`, `xref.hyperref` | `\ifappend{A}{B}` choosing between `\uncover<n>{\hyperlink{target}{\beamergotobutton{text}}}` and `\beamerskipbutton`/`\beamerreturnbutton` forms; `\visible<0>` |
| A. sidebar template | beamersubframe.dtx:2259-2264 | `slide.beamer-template` | `\defbeamertemplate*{sidebar left}{bsf test}[1][50]` (the template-defining command, same beamer family as `\setbeamertemplate`) |
| A. sidebar template body | beamersubframe.dtx:2261-2263 | `sp.manual-space`, `color.xcolor`, `font.size-commands`, `slide.beamersubframe` | `\vfill`, `\hskip0.1cm`, `\vskip2pt`; `\color{fg!#1!bg}`; `\tiny`; `\ifsubframe{detail}{main part}`; `\rlap{\hbox{..}}` is a positioning box, counted with `\raisebox` in `sp.manual-space` (closest way, not an exact fit) |
| A. vertical gaps in frames | beamersubframe.dtx:2303, :2327, :2339 | `sp.manual-space` | `\vspace{2ex}` |
| B. manual class | beamersubframe.dtx:41 | `class.ltxdoc` | no options |
| B. hyperlinks for doc | beamersubframe.dtx:42 | `dtx.doc` | `\usepackage{hypdoc}`, no options |
| B. graphics | beamersubframe.dtx:43 | `fig.graphicx` | `\usepackage{graphicx}` |
| B. caption anchors | beamersubframe.dtx:45 | `xref.hypcap` | option `all` |
| B. doc switches | beamersubframe.dtx:46-48 (`\RecordChanges` :49 and `\OnlyDescription` :50 are commented out) | `dtx.doc` | `\setcounter{IndexColumns}{2}`, `\EnableCrossrefs`, `\CodelineIndex` |
| B. driver call | beamersubframe.dtx:135-137 | `dtx.doc` | `\DocInput{beamersubframe.dtx}` |
| B. option-description machinery | beamersubframe.dtx:51-134 | none (BESPOKE) | see Blockers |
| B. checksum, index exclusions, change log | beamersubframe.dtx:29, :143-191, :193-202 | `dtx.doc` | `\CheckSum{922}`, `\DoNotIndex{...}` lists, `\changes{0.2}{2011/08/07}{...}` |
| B. title block | beamersubframe.dtx:207-212 | `front.maketitle`, `xref.hyperref` | `\title{..\\[1ex]..}`, `\author{..\\\href{mailto:..}{..}}`, `\date{\filedate\ (v\fileversion)}`, `\maketitle` |
| B. abstract | beamersubframe.dtx:213-217 | `abs.kernel` | `abstract` environment |
| B. contents | beamersubframe.dtx:219 | `toc.kernel` | `\tableofcontents` |
| B. headings | beamersubframe.dtx:222, :253, :1416 | `head.kernel` | `\section` `\subsection` `\subsubsection` `\paragraph`, class defaults |
| B. lists | beamersubframe.dtx:482-491, :504-510, :988-997 | `list.kernel` | `description`, `enumerate`, `itemize` |
| B. footnotes | beamersubframe.dtx:321-322, :338, :428 | `fn.kernel` | `\footnote{..}` |
| B. figures | beamersubframe.dtx:522-530 | `fig.graphicx`, `cap.kernel`, `xref.kernel` | `figure[htb]`, `\includegraphics[width=\textwidth]{beamersubframe-embed.pdf}`, `\caption`, `\label` |
| B. cross-references | beamersubframe.dtx:256, :442, :516 | `xref.hyperref`, `xref.kernel` | `\autoref{sec:restrictions}`, `\label{sec:man-subse}` |
| B. side-by-side source listings | beamersubframe.dtx:550-588 | `box.minipage`, `font.size-commands`, `code.verbatim`, `sp.manual-space` | `minipage{0.49\textwidth}` twice, `\footnotesize`, `verbatim`, `\hfill` (:569) |
| B. inline markup | beamersubframe.dtx:205, :288, :401, :534 | `mark.kernel`, `dtx.doc` | `\textsf`, `\texttt`, `\emph`; `|..|` short verb and `\meta` from ltxdoc |
| B. macro, environment, option descriptions | beamersubframe.dtx:287, :307, :332 | `dtx.doc` (`\DescribeOpt` is the bespoke one) | `\DescribeMacro`, `\DescribeEnv` |
| B. code part and index | beamersubframe.dtx:1038, :1043-2235 | `dtx.doc` | `macrocode`, `macro`, `environment`, `\StopEventually{\newpage\PrintIndex}`; the index needs `makeindex -s gind.ist` (README:29) |
| B. page breaks and spacing | beamersubframe.dtx:1038, :1042, :352 | `pg.break`, `sp.manual-space` | `\newpage`; `\vspace{1ex}` |
| C. package id and class guard | beamersubframe.dtx:1047-1068 | `slide.beamersubframe` | `\ProvidesPackage` v0.2; errors out unless class `beamer` is loaded (:1058) |
| C. options and dependency | beamersubframe.dtx:1177-1199 | `slide.beamersubframe` | `embed` `append` `nominiframes`; `\ExecuteOptions{embed}`; `\RequirePackage{verbatim}` |
| C. subframe, lastframe, inserts | beamersubframe.dtx:1941-1979, :2075-2077, :2222, :2230 | `slide.beamersubframe` | append mode copies the body to `\jobname.sfr` and inputs it at `\appendsubframes` (:2126); embed mode wraps `frame`; `lastframe`, `\ifappend`, `\ifsubframe`, `\inserttotalframenumberwithsub` |
| C. two-pass files | beamersubframe.dtx:2162-2175, :2200-2201 | `slide.beamersubframe` | `\jobname.sfr`, `\jobname.sfp` written by TeX itself (no tool); a second run is needed for miniframe links |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\DescribeOpt`, `\Describe@Opt`, `\SpecialOptIndex` (two versions) | beamersubframe.dtx:53-78 | no | Index and margin-print code on doc.sty and hypdoc internals; BESPOKE/preamble |
| `\option`, `\endoption`, redefined `\macro`, `\environment`, `\m@cro@` | beamersubframe.dtx:80-125 | no | Copy of doc.sty `\m@cro@` with an added `\ifcase` branch; BESPOKE/preamble |
| `\SpecialMainOptIndex` | beamersubframe.dtx:126-133 | no | `\special@index` calls; BESPOKE/preamble |
| `\newcommand{\BSF}` | beamersubframe.dtx:205 | yes | alias of `\textsf{BeamerSubFrame}` (`mark.kernel`) |
| `\fileversion`, `\filedate` | beamersubframe.dtx:35-36 | yes | two strings (0.2, 2011/08/07) printed in the date line (:210) |
| `\linkdetail`, `\returndetail`, `\linkdifftext` | beamersubframe.dtx:2246-2257 | yes | overlay-aware aliases of `\ifappend`, `\uncover`, `\visible`, `\hyperlink`, beamer buttons; inline the body at each call (:2279, :2304, :2314, :2328, :2340) |
| `bsf test` sidebar template | beamersubframe.dtx:2259-2264 | yes | `\defbeamertemplate*` plus `sp.manual-space`, `color.xcolor`, `font.size-commands` and `\ifsubframe`, as in the map row |
| `\generateExample`, `\ifaskforexample`, `\ifgenerateexample` | beamersubframe.ins:21-35 | yes | install-time DocStrip driver (runs inside TeX, not EXTERNAL); no effect on any document, since the published package is installed as a .sty |
| package internals (`\bsf@*`, `\bsfrestore*`, redefined `\part` `\section` `\subsection` `\hyperlinkslidenext`) | beamersubframe.dtx:1047-2235 | not zip-local code | the package is published, so these are the inside of the way `slide.beamersubframe`; they are not copied into an emitter's output |

## Content-opaque
- Two Inkscape drawings of frame order, `beamersubframe-embed.pdf` and `beamersubframe-append.pdf`, included in floats at beamersubframe.dtx:523 and :528 (sources `.svg`, README:42); figure artwork, shipped assets.
- The `macrocode` listing text and the verbatim example source in the manual (beamersubframe.dtx:553-587, :728-977); code text.

## Lib changes
- New ways proposed:
  - `slide.beamersubframe` `beamersubframe` (CTAN `macros/latex/contrib/beamer-contrib/beamersubframe`, v0.2, LPPL 1; pdfLaTeX): moves flagged frames to the end of the PDF or keeps them in place. W1: on CTAN (ctan.org/pkg/beamersubframe, read). W2: options `embed` `append` `nominiframes`. W3: any beamer deck. W4: `\usepackage[append]{beamersubframe}`, body wrapper `\begin{subframe}[opts]{title}..\end{subframe}` (and `lastframe`), `\appendsubframes` before `\end{document}`, conditionals `\ifappend{}{}` and `\ifsubframe{}{}`. Needs `verbatim` and two runs, no external tool. Not `slide.beamer-mode` (overlays) and not `slide.colourchange` (colour). A sibling of the lib's other beamer add-ons.
  - `dtx.doc` `hypdoc` (CTAN, LPPL 1.3c: "adds hypertext features to the package doc"; pdfLaTeX): load line `\usepackage{hypdoc}` for a doc-based manual. W1: CTAN (read). W2: load switch, as `note.mparhack`. W3: any `.dtx` manual. W4: one preamble line. Considered folding into `dtx.doc`; kept apart because it is a separate package. Whether it loads hyperref itself I did not read (the explicit hyperref line at beamersubframe.dtx:44 is commented out and `\autoref` is used at :256).
  - `xref.hypcap` `hypcap` (CTAN, LPPL 1.3c: "Adjusting the anchors of captions"; pdfLaTeX): option `all` auto-inserts the anchor at the start of float environments (beamersubframe.dtx:45). W1: CTAN (read). W2: options. W3: any hyperref document with floats. W4: one preamble line. Not `cap.caption` (caption looks).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
