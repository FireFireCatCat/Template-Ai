yes

# 0223-ieee-ieeeconf: IEEE conference paper kit (`ieeeconf` class, IEEE RAS / PaperPlaza)

- Unverified: read from the source, not compiled.
- Source: Source/0223-ieee-ieeeconf/ (origin: https://ras.papercept.net/conferences/support/files/ieeeconf.zip; licence: not established; the class header itself says Perl Artistic License, ieeeconf.cls:59)
- Kind: conference
- Lib: v2
- Engine: pdfLaTeX-compatible (Times through psnfss `ptm`/`phv`/`pcr`, ieeeconf.cls:790-792; the class sets the pdfTeX page size when `\pdfpageheight` exists, ieeeconf.cls:831-838; the `\pdfobjcompresslevel`/`\pdfminorversion` lines are commented, root.tex:19-20)
- Look carried by: class (root.tex adds only the options `letterpaper, 10 pt, conference`, two class commands and content; every look parameter is inside ieeeconf.cls)
- Class origin: publisher-official
- Main file: root.tex (other samples: none; root.pdf is a rendered reference, not source)
- Read: main yes, zip-local classes and styles partly (ieeeconf.cls read except the `IEEEeqnarray` block ieeeconf.cls:2075-3125, which was outlined by grep and read only at its entry macros 2594-2665; the sample never uses it)

## Verdict
yes. The look is carried entirely by the class `ieeeconf`, shipped in the zip from the IEEE RAS conference-support site (manifest source `pub`; root.tex:34 and root.tex:133 present it as the conference kit and tell authors to use "the cls file that came with this distribution"). The sample loads no package (every `\usepackage` is a comment, root.tex:26-31), defines no macro, and uses only the class's options and native commands plus kernel title/author/abstract/section/itemize/table/figure/thebibliography, all of which have lib ways. This is evidence about the class dimension, not about component ways. The class's own internals (halign author blocks, dynamic title spacer, `IEEEeqnarray`, drop-cap font computation) would be irreducible `BESPOKE/class` if the class were ruled zip-local; they are not counted here because W1 admits an organisation's official kit (see Bespoke code). Note the name collision: CTAN's `ieeeconf` page (read once, summarised by a fetch tool, file list not seen) names a different package by Scott Pakin, so CTAN does not settle W1 here; the official-kit rule does.

## Blockers
none

## Class setting
- Class: `class.ieeeconf` options: `letterpaper`, `10 pt` (written with a space, root.tex:5; the class declares `10pt`, ieeeconf.cls:709), `conference` (ieeeconf.cls:773). Defaults not overridden: `twocolumn`, `oneside`, `final` (ieeeconf.cls:798). A different class from `class.ieeetran`: other name, other kit; the code is a fork of IEEEtran V1.6b (ieeeconf.cls:1-2, 664-665) revised by Pradeep Misra. No `\LoadClass`: it does not load `article`, it defines sizes, sectioning, floats, lists itself.
- Class-native vocabulary used: `\IEEEoverridecommandlockouts` (root.tex:9), `\overrideIEEEmargins` (root.tex:12), `\maketitle` with `\thanks` and `$^{n}$` marks (root.tex:33-53), `abstract` environment (root.tex:59), `\section` `\subsection` `\section*` (root.tex:67, 73, 193), `table` / `figure` floats with `\caption`, `thebibliography` with `\bibitem`.
- Defined by the class, not exercised by the sample: `\authorblockN` `\authorblockA` `\and` (ieeeconf.cls:3484-3577), `\specialpapernotice` (4404), `\IEEEaftertitletext` (3792), `\pubid` (4447), `keywords` (locked out in conference mode, 4542), `\PARstart` (4172; locked out in conference mode, 4539), `biography` (4292), `\appendix`/`\appendices` (4064, 4103), `IEEEeqnarray` (2594), `\proof`/`\QED` and theorem hooks (3947-3972), `\tableofcontents` (1925), `\IEEEtriggeratref` (3340), `\bstctlcite` (3322), `\centerfigcaptionstrue` (1986), class option `nofonttune` (785).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | root.tex:5; ieeeconf.cls:664,708-711,773,798-800 | `class.ieeeconf` | letterpaper, 10pt, conference; default twocolumn, oneside, final |
| paper size and page geometry | root.tex:5; ieeeconf.cls:732-737,1146-1166 | `page.class-options` | letterpaper = 11in x 8.5in, topmargin -22pt, side margin 0.75in; class fixes textwidth 7.0in, columnsep 0.2in, textheight 684pt at 10pt conference (1153), headsep/headheight 0 in conference mode (1220-1221) |
| margin override | root.tex:12; ieeeconf.cls:1191-1212 | `page.class-options` | `\overrideIEEEmargins` sets both side margins to `\@IEEEmarginW` (0.75in = `\@IEEEmarginE` for letterpaper, 736-737, so no visible change there; shifts for a4paper, 740-745) |
| last-page balancing | root.tex:177 | `page.setlength` | `\addtolength{\textheight}{-12cm}` placed in the body on the page before the last (manual, comment root.tex:177-182) |
| columns | ieeeconf.cls:798,3997-4003 | `cols.twocolumn-option` | `\twocolumn` called at class load; title spans both columns through `\twocolumn[...]` inside `\maketitle` (3589-3626, class-internal) |
| bottom flush | ieeeconf.cls:3994,4003 | `pg.flush` | `\flushbottom` in two-column mode |
| running heads and feet | ieeeconf.cls:3177-3181,3201-3207 | `hf.class-native` | conference mode: empty `\@oddhead`/`\@evenhead` and empty feet; no page numbers printed |
| page style in sample | root.tex:54-55 | `hf.pagestyle-kernel` | `\thispagestyle{empty}`, `\pagestyle{empty}` |
| font families | ieeeconf.cls:790-792 | `font.family-default` | `\rmdefault`=ptm, `\sfdefault`=phv, `\ttdefault`=pcr; math stays Computer Modern (no math font package, root.tex:26-31 commented) |
| font sizes | ieeeconf.cls:881-971 (10pt block 905-922); root.tex:33,42 | `font.size-commands` | `\normalsize` 10/12pt, `\small` 9/10, `\footnotesize` 8/9, `\large` 12/14, `\LARGE` 16/20, `\sublargesize` 11/13.4; sample uses `\LARGE` and `\small` |
| interword glue tuning | ieeeconf.cls:1024-1113 | `class.ieeeconf` (internal) | `\fontdimen2-4` rewritten per size, weight, shape to 35%/23%/50% (bold 37.5/23/55); off with option `nofonttune` (785); no separate lib way, part of the class |
| penalties | ieeeconf.cls:1128,1867,1872,3374 | `sp.penalties` | `\hyphenpenalty` 750, `\interdisplaylinepenalty` 2500, `\interfootnotelinepenalty` 10000, bibliography `\clubpenalty`/`\widowpenalty` 4000, `\interlinepenalty` 500 |
| space after period | ieeeconf.cls:1133 | `sp.frenchspacing` | `\frenchspacing` |
| paragraph and list lengths | ieeeconf.cls:1215,1236,1240,1354 | `sp.lengths` | `\parindent` 1em, `\parskip` 0ex plus 0.2ex minus 0.1ex, `\footskip` 0.4in, `\topsep` 2pt plus 1pt minus 1pt |
| title data | root.tex:33-35,38-46,53 | `front.maketitle` | `\title{\LARGE \bf ...}`, `\author{... $^{1}$ ...}`, `\maketitle` |
| title layout | ieeeconf.cls:3628-3640,3676-3690,3705-3783 | `front.class-native` | conference mode: `\vskip0.25in`, `\LARGE` title, `\vskip1em`, authors centred in a halign block (`\sublargesize` names), rigid spacer after (nominal 1 baselineskip, min 0.75, 3720-3721) computed from the measured title height |
| author notes | root.tex:38-46; ieeeconf.cls:3592,4538,4572 | `front.thanks` | three `\thanks`; footnote mark emptied during `\maketitle` (3592); `\thanks` is swallowed in conference mode unless restored |
| lockout override | root.tex:9; ieeeconf.cls:4572 | `front.class-native` | `\IEEEoverridecommandlockouts` restores `\thanks` and other locked commands |
| footnote layout | ieeeconf.cls:1838,1862,1864 | `fn.kernel` | `\footins` 0.9 baselineskip plus 0.4 minus 0.2, empty `\footnoterule`, `\@makefntext` 1em indent |
| abstract | root.tex:59-63; ieeeconf.cls:3797-3806 | `abs.class-native` | two-column: run-in bold italic "Abstract---" in `\small` (1017), nothing added after in conference mode (3805) |
| headings | root.tex:67,71,73,193,197; ieeeconf.cls:3862-3936 | `head.class-native` | conference: section = `\normalsize\centering\scshape`, above 1.5ex plus 1.5ex minus 0.5ex, below 0.7ex plus 1ex (3922-3923); subsection italic (3924-3925); `\subsubsection`/`\paragraph` run-in italic with indents `\parindent`/`2\parindent` (3933-3936); `\section*` through `\@ssect` (3893) |
| heading numbering | root.tex:67,73; ieeeconf.cls:1892-1905 | `num.counters` | `\thesection` Roman, `\thesubsection` I-A, displayed "I." "A." "1)" "a)" |
| numbering depth | ieeeconf.cls:1876-1880,1919 | `num.secnumdepth` | `secnumdepth` 4 (3 for technote), `tocdepth` 3 |
| itemize | root.tex:92-99,113-128; ieeeconf.cls:1615,1646-1700,1386,1476 | `list.kernel` | class replaces `itemize` with its own list: label `$\scriptstyle\bullet$`, label indent `\parindent`, `\labelsep` 0.6em, zero item/par sep, `\topsep` 2pt plus 1pt minus 1pt |
| font-switch commands | root.tex:34,42,133; ieeeconf.cls:4386-4392 | `mark.kernel` | `\bf`, `\tt`, `\it` via `\DeclareOldFontCommand`, plus `{\tt\small ...}` e-mail lines |
| display equation | root.tex:106-108; ieeeconf.cls:1896,1906-1912 | `math.kernel` | `$$ ... \eqno{(1)}$$`, hand-numbered; `\theequation` arabic, `\@eqnnum` prints "(1)" |
| float placement | ieeeconf.cls:1947-1981,2037,2047 | `fig.placement` | `\floatsep` 1 baselineskip, `\textfloatsep` 1.7, `\topfraction` 1.0, `\floatpagefraction` 0.8, topnumber 2, totalnumber 4, default placement `tbp` |
| figure float | root.tex:160-168; ieeeconf.cls:2035-2043 | `fig.graphicx` | `figure[thpb]`, `\centering`, label "Fig.~\thefigure"; no `\includegraphics` active (root.tex:164) |
| centred block | root.tex:148,161 | `sp.ragged` | `center` environment, `\centering` |
| figure placeholder box | root.tex:162 | `box.fancybox`, `box.minipage` | `\framebox{\parbox{3in}{...}}` standing in for artwork (content) |
| table | root.tex:145-157; ieeeconf.cls:2045-2056 | `tbl.tabular` | `table[h]`, `tabular{\|c\|\|c\|}` with `\hline`; class puts the body in `\footnotesize` via `\@floatboxreset` (2053), label "TABLE~\thetable" with Roman number (2046, 2050) |
| captions | root.tex:146,165; ieeeconf.cls:2012-2033,2000,1990 | `cap.kernel` | `\caption` above the table, below the figure; look from the class `\@makecaption`: table = centred `\footnotesize` number line plus small-caps title, figure = `\footnotesize` "Fig. 1.", wraps left, centred when under one line (`\centerfigcaptionstrue` is the conference default, 1990), `\abovecaptionskip` 0.5 baselineskip |
| labels | root.tex:147,167 | `xref.kernel` | `\label` only, no `\ref` in the sample |
| bibliography | root.tex:209-237; ieeeconf.cls:3348-3376 | `bib.thebibliography` | `thebibliography{99}` and `\bibitem`; class: `\section*{References}`, labels `[n]`, `\footnotesize`, `\itemsep` 0pt plus .5pt; `\cite` redefined (3277) but no `\cite` in the sample |

## Bespoke code
The sample has none: no `\newcommand`, `\def`, environment or counter in root.tex, and no package loaded. Everything below sits inside the published class and is carried by `class.ieeeconf`; it is listed so the result can be re-read if the class origin ruling changes.
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| interword `\fontdimen` tuning per size/weight/shape | ieeeconf.cls:1064-1113 | n/a (published class); irreducible if zip-local | none; no lib way for raw `\fontdimen` |
| dynamic title spacer (box measurement, integer line arithmetic) | ieeeconf.cls:3705-3783 | n/a; irreducible if zip-local | none |
| author block halign and `\and` | ieeeconf.cls:3532-3577 | n/a; irreducible if zip-local | none |
| `IEEEeqnarray` family (halign preamble builder, struts) | ieeeconf.cls:2075-3125 | n/a; irreducible if zip-local (outlined only) | none |
| `\PARstart` font-size solver, biography hanging indent | ieeeconf.cls:4172-4235, 4292-4381 | n/a; irreducible if zip-local | `sp.lettrine` could replace the drop cap only approximately |
| redefined `\@sect`, `\@ssect`, `\@makecaption`, IED lists | ieeeconf.cls:3862-3910, 2012-2033, 1646-1800 | n/a; partly reducible to `head.titlesec`, `cap.caption`, `list.enumitem` if zip-local | would need parameter sets copied from the class |

## Content-opaque
none. (The figure body is a text-box placeholder, root.tex:162. root.tex is Windows-1252: the quote and dash bytes at root.tex:61,94,96-97,110,116-126,139,171,199 and the bibliography entries 211-230 are not valid UTF-8; this is content encoding, not a template component.)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
