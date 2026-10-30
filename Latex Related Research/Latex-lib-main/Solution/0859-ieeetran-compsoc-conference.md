yes

# 0859-ieeetran-compsoc-conference: IEEE conference template (IEEEtran, `conference` option)

- Unverified: read from the source, not compiled.
- Source: Source/0859-ieeetran-compsoc-conference/ (origin: https://ieee-org.widen.net/content/ssylclqqfn/original/conference-latex-template.zip; licence: not established in the manifest, the class header states LPPL 1.3 at IEEEtran.cls:53-54)
- Kind: conference
- Lib: v6
- Engine: pdfLaTeX-compatible (Type 1 `ptm`/`phv`/`pcr` through NFSS, IEEEtran.cls:494-496; no fontspec, no Lua)
- Look carried by: class (IEEEtran.cls V1.8b, selected by the `conference` option; the preamble only loads content packages and one logo macro)
- Class origin: publisher-official (the zip is IEEE's own conference kit; the same V1.8b of 2015/08/26 is on CTAN, ctan.org/pkg/ieeetran read: IEEEtran 1.8b, LPPL 1.3)
- Main file: IEEE-conference-template-062824.tex (other samples: none; IEEEtran_HOWTO.pdf and IEEE-conference-template-062824.pdf are documentation, not read)
- Read: main yes, zip-local classes and styles partly (IEEEtran.cls is the published class, 6347 lines; read lines 1-570, 690-870, 1068-1100, 1660-2120, 2455-2870, 4225-4540, 4620-4910, 5225-5360, 5455-5530, 5590-5670, 6215-6347; not read: the IEEEeqnarray, IED list, theorem/proof, biography, appendix and compsoc-only code)

## Verdict
yes. The look is carried by the published, publisher-official class `IEEEtran` under its `conference` option; the sample adds only content packages (`cite`, `amsmath`, `graphicx`, `xcolor`...), one `\def\BibTeX` logo macro that reduces by inline expansion, and standard body constructs. No zip-local class or style, no artwork in the template, no external tool. Class internals (the `\halign` author block, `\@maketitle`, `\@makecaption`) would be irreducible if the class were zip-local, but under the rubric's W1 ruling an official publisher kit is a published way.

## Blockers
none

## Class setting
- Class: `class.ieeetran` options: `conference` (IEEE-conference-template-062824.tex:1). Defaults supplied by the class, not by the sample: letterpaper, 10pt, twocolumn, oneside, final (IEEEtran.cls:374). `compsoc` exists as an option (IEEEtran.cls:366) but is not selected.
- Class-native vocabulary used (all in IEEE-conference-template-062824.tex unless a .cls line is given): `\IEEEoverridecommandlockouts` (line 2), `\IEEEauthorblockN` and `\IEEEauthorblockA` (lines 22-56), `\and` redefined by the class in conference mode (IEEEtran.cls:4731), `abstract` (line 61), `IEEEkeywords` (line 67), `\thanks` (line 19, enabled by the lockout override), `thebibliography` with `\bibitem` (line 275), `\section*` for Acknowledgment and References (lines 247, 254).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | IEEE-conference-template-062824.tex:1; IEEEtran.cls:206 | `class.ieeetran` | option `conference`; class V1.8b |
| paper and page geometry | IEEEtran.cls:374, 1734-1735, 1742-1750, 1702, 1713-1714 | `page.class-options` | letterpaper (default), conference mode: textwidth 43pc, columnsep 1pc, textheight 9.25in, top margin 0.75in; set by the class, no sample line |
| columns | IEEEtran.cls:374, 5652-5655 | `cols.twocolumn-option` | twocolumn is the class default; `\twocolumn` is issued by the class itself; `\flushbottom` and `\sloppy` follow (IEEEtran.cls:5657-5658) |
| header/footer, page style | IEEEtran.cls:4244-4280, 4284-4319, 5632 | `hf.class-native` | `headings` page style; conference mode empties head and foot (IEEEtran.cls:4272-4275, 4316-4319), so no running head and no printed page number |
| main text face | IEEEtran.cls:494-496, 1074-1094 | `font.family-default` | `\rmdefault`=ptm, `\sfdefault`=phv, `\ttdefault`=pcr (the three lines of `times.sty`); interword tuning `\@IEEEtunefonts` unless `nofonttune` |
| font sizes | IEEEtran.cls:649-651; IEEE-conference-template-062824.tex:17 | `font.size-commands` | normalsize 10/12pt set by the class; sample uses `\footnotesize` in the title note |
| text encoding glyphs | IEEE-conference-template-062824.tex:10 | `font.fontenc-t1` | `textcomp`, no options |
| paragraph and spacing defaults | IEEEtran.cls:1668, 1676, 1683-1685, 1706, 1708 | `class.ieeetran` | `\hyphenpenalty` 750, `\frenchspacing`, club/widow penalty 1000, `\parskip` 0ex plus 0.2ex, `\parindent` 1em; all in the class, no emitter line |
| colour | IEEE-conference-template-062824.tex:11, 290 | `color.xcolor` | `\usepackage{xcolor}`; body switch `\color{red}` on the closing notice |
| title and author blocks | IEEE-conference-template-062824.tex:16-59 | `front.maketitle` | `\title{...\\ {\footnotesize ...}}`, `\author`, `\maketitle` (IEEEtran.cls:4753-4788, 4802-4814) |
| author name/affiliation blocks | IEEE-conference-template-062824.tex:22-56 | `front.class-native` | `\IEEEauthorblockN{}` and `\IEEEauthorblockA{}` x6 separated by `\and`; the class sets them in an `\halign` (IEEEtran.cls:4636-4705) |
| lockout override | IEEE-conference-template-062824.tex:2 | `front.class-native` | `\IEEEoverridecommandlockouts` restores `\thanks` (IEEEtran.cls:6239, 6278-6289) |
| author note footnote | IEEE-conference-template-062824.tex:19 | `front.thanks` | `\thanks{...}` inside `\title`; mark suppressed by the class (IEEEtran.cls:4756-4760, 4878-4881) |
| abstract | IEEE-conference-template-062824.tex:61-65 | `abs.class-native` | `abstract` environment; run-in italic bold "Abstract---" in `\small` (IEEEtran.cls:5275-5283) |
| index terms | IEEE-conference-template-062824.tex:67-69 | `abs.keywords` | `IEEEkeywords` environment; label "Index Terms" (IEEEtran.cls:2614, 5286-5294) |
| headings | IEEE-conference-template-062824.tex:71, 75, 207, 247, 254 | `head.class-native` | `\section`, `\subsection`, `\paragraph`, starred `\section*`; conference spacing and small-caps centred section, italic subsection (IEEEtran.cls:5465-5483), numbering I / I-A / I-A1 / a) (IEEEtran.cls:2553-2558, 2585-2588), secnumdepth 4 (IEEEtran.cls:2524) |
| itemize lists | IEEE-conference-template-062824.tex:102-107, 163-175 | `list.kernel` | `itemize`; labels, indents and spacing set by the class (IEEEtran.cls:1937-1964, 2010-2013) |
| display equation | IEEE-conference-template-062824.tex:116-118 | `math.amsmath` | `equation` with `\label`; `\eqref` (same file, line 122); `amsmath` loaded (same file, line 7); number printed by the class `\theequationdis` (IEEEtran.cls:2592-2597) |
| math symbol fonts | IEEE-conference-template-062824.tex:7 | `math.amssymb` | `amssymb`, `amsfonts` |
| cross-references | IEEE-conference-template-062824.tex:88, 95, 122, 212 | `xref.kernel` | `\label`, `\ref`, `\eqref` (the last from `amsmath`) |
| inline code | IEEE-conference-template-062824.tex:127, 132-133, 136 | `code.verbatim` | `\verb\|...\|` only; no verbatim environment |
| inline marks | IEEE-conference-template-062824.tex:23, 105, 179, 221 | `mark.kernel` | `\textit`, `\textbf`, `\textsuperscript`, `\mathrm` |
| manual space | IEEE-conference-template-062824.tex:289 | `sp.manual-space` | `\vspace{12pt}` before the closing notice |
| table float | IEEE-conference-template-062824.tex:214-229 | `tbl.tabular` | `table[htbp]`, `center`, `tabular{\|c\|c\|c\|c\|}`, `\hline`, `\cline{2-4}`, `\multicolumn`; `\table` switches to `\footnotesize` (IEEEtran.cls:2838), numbering "TABLE I" (IEEEtran.cls:2608, 2830) |
| table caption | IEEE-conference-template-062824.tex:215 | `cap.kernel` | `\caption` above the table; class `\@makecaption` sets small-caps centred title (IEEEtran.cls:2774-2779) |
| figure float | IEEE-conference-template-062824.tex:231-235 | `fig.graphicx` | `figure[htbp]`, `\includegraphics{fig1.png}`; `graphicx` (same file, line 9); class default placement `tbp` (IEEEtran.cls:2815) |
| figure caption | IEEE-conference-template-062824.tex:233 | `cap.kernel` | `\caption` below; "Fig. 1." plus two non-breaking spaces, centred when short (IEEEtran.cls:2607, 2784-2793) |
| centring | IEEE-conference-template-062824.tex:216, 232 | `sp.ragged` | `\begin{center}`, `\centerline` (kernel centring family) |
| bibliography | IEEE-conference-template-062824.tex:275-287 | `bib.thebibliography` | `thebibliography{00}`, `\bibitem`; class list with `[n]` labels, `\footnotesize` (IEEEtran.cls:4478, 4489-4515) |
| citations | IEEE-conference-template-062824.tex:6, 176, 256-273 | `bib.cite-pkg` | `\usepackage{cite}`; `\cite{b1}` ... `\cite{b7}` (sorted, compressed numeric runs) |
| algorithm package | IEEE-conference-template-062824.tex:8 | `alg.algorithmicx` | `\usepackage{algorithmic}`, loaded and never called |
| footnote layout | IEEEtran.cls:2466, 2490, 2498 | `class.ieeetran` | no footnote rule, 1em hanging mark, `\skip\footins` 0.9\baselineskip; class-fixed |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\BibTeX` logo macro | IEEE-conference-template-062824.tex:12-13 (used at :143-144) | yes | Inline expansion into published ways: `\rm` and `\sc` are `mark.kernel` font switches, `\kern-.05em` and the other kerns are horizontal manual space as `\hspace{-.05em}` (`sp.manual-space`), `\lower.7ex\hbox{E}` is `\raisebox{-.7ex}{E}` (`sp.manual-space`). The text is fixed and has no logic. Lower-fidelity alternative: `\hologo{BibTeX}` (`font.icons`). |
| IEEEtran.cls internals (`\halign` author block, `\@maketitle`, `\@makecaption`, `\@startsection` calls, IED lists) | IEEEtran.cls:4689-4705, 4802-4839, 2774-2794, 5467-5483 | not applicable | Published class V1.8b, publisher-official and on CTAN, so the whole class is the one way `class.ieeetran` and is not re-derived into other ways. Not zip-local code. |

No other `\newcommand`, `\def`, environment, counter or conditional is defined in the sample (checked: the preamble is IEEE-conference-template-062824.tex:1-13 and the body defines nothing).

## Content-opaque
- Included image fig1.png in the figure (IEEE-conference-template-062824.tex:232): content, no lib way needed.
- Table cell text and the hand-typed table footnote marks (IEEE-conference-template-062824.tex:217-226): content.
- No TikZ, PGF, PSTricks or `picture` anywhere in the sample or the class's conference path (the compsoc diamond line, IEEEtran.cls:4844-4854, is compsoc-only and not selected).
- Notes: the template text is addressed to authors, not to an AI (IEEE-conference-template-062824.tex:291); nothing to quote. `IEEEtran.cls` reads `newtxmath` only under `comsoc` (IEEEtran.cls:473-479), so it loads no tool-dependent package here. The zip name says compsoc but the sample uses plain `conference`.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
