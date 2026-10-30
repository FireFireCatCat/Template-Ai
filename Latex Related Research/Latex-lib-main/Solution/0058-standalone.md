yes

# 0058-standalone: the `standalone` class and package (v1.5a, 2025/02/22), CTAN source bundle

- Unverified: read from the source, not compiled.
- Source: Source/0058-standalone/ (origin: https://mirrors.ctan.org/macros/latex/contrib/standalone.zip; licence: lppl1.3 per manifest; README.txt:3 and standalone.dtx:5-7 say LPPL 1.3 or later; ctan.org/pkg/standalone read once: CTAN class and package, LPPL 1.3, in TeX Live and MiKTeX)
- Kind: misc (a class and package source bundle with its manual; the manual is a documented-TeX file, not a journal, thesis or the like)
- Lib: v1
- Engine: pdfLaTeX-compatible (standalone.dtx:200 says the manual compiles with `pdflatex`; the class and package carry branches for pdfTeX, LuaTeX, XeTeX and DVI, standalone.dtx:1301-1357, 2561-2679). Only `metalogo` (standalone.dtx:49-51) is XeLaTeX-oriented per its CTAN page; it is loaded only if installed and has a text fallback, so it is not required.
- Look carried by: class (the bundle's own look is the published `standalone` class with its default `standalone.cfg`; the manual's look is the published `ydoc` class plus a short preamble, standalone.dtx:35-60)
- Class origin: ctan (the `standalone` class and package, shipped here as DocStrip source; the manual's class `ydoc` is tex-distribution-unbundled, not in the zip, ctan.org/pkg/ydoc read once: CTAN, LPPL 1.3c, in TeX Live, alpha release 0.7)
- Main file: standalone.dtx (documentation driver at standalone.dtx:25-61; other samples: none. `standalone.ins` is the DocStrip driver that unpacks standalone.cls, standalone.sty, standalone.tex, standalone.cfg from the dtx, standalone.ins:6-14. `standalone.pdf` is the compiled manual and was not opened.)
- Read: main yes (all 4896 lines of standalone.dtx, in chunks), zip-local classes and styles none present as files (the class, package, tex and cfg exist only as DocStrip targets inside the dtx; I read all of their code, standalone.dtx:1180-4893, plus README.txt, DEPENDS.txt, standalone.ins)

## Verdict
yes. There is no ordinary `.tex` sample: the zip is the CTAN source of the published `standalone` class and package, plus its manual. The manual is a `ydoc` document (published) with a few reducible preamble lines and ten `lstlisting` blocks, three booktabs tables and `\autoref` links as body; the class is already a lib way (`class.standalone`) and the package has no home in the lib, so one way is proposed (`pg.standalone-pkg`). No ART: the three `tikzpicture` blocks are listing text, not drawings. This verdict rests on counting the CTAN class and package as published (W1, as the pilot ruling on official kits says); if their internals had to be rebuilt from other ways they would be `no` (BESPOKE/package at standalone.dtx:2509-2625, 2761-2882, 3828-4149). Using the `convert` class option or `mode=build*` would be EXTERNAL/package (shell escape plus Ghostscript, ImageMagick or Inkscape), but nothing loads them unconditionally and the driver selects neither.

## Blockers
none

## Class setting
- Class (manual): `class.ydoc` options: `a4paper,11pt` (standalone.dtx:35). Source of `ydoc` not read (distribution class).
- Class (the bundle's subject): `class.standalone`, defaults `crop` and `border=0pt` set by the shipped `standalone.cfg` (standalone.dtx:4862, 4874; prose 352, 389); underlying class `class=article` by default (359-361, 1662, 2160-2163).
- Class-native vocabulary used (`ydoc`, by the manual): `\author` `\email` `\repository` `\maketitle` (126-129), `abstract` (132-137), `\DescribeKey` `\DescribeMacro` `\DescribeEnv` `\DescribeKeys` `DescribeEnv` (358, 485, 516, 907, 544), `\Key` `\opt` `\pkg` `\cls` `\env` `\lib` `\bundle` `\file` `\path` `\meta` `\cs` `\Macro` `\MacroArgs` `\AlsoMacro` `\codeline` (e.g. 133, 135, 205, 253, 291, 280, 246, 184, 883, 254, 136, 546, 799), `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges` `\OnlyDescription` `\DocInput` `\PrintChanges` `\PrintIndex` (42-59), `\changes` (18 entries, 82-100), `\CheckSum` `\CharacterTable` `\DoNotIndex` `\GetFileInfo` (64-116, 102), `\StopEventually` `\Finale` (1174, 4895), `macrocode` (231 blocks), `macro` (98) `key` (64) `environment` (8) environments from 1199.
- Class-native vocabulary (`standalone`, the bundle's subject): options `crop` `preview` `border` (alias `margin`) `multi` `multido` `ignorerest` `ignoreempty` `varwidth` `tikz` `pstricks` `beamer` `class` `float` `math` `convert` `png` `jpg` `gif` `svg` `emf` (keys at 1398-1990, prose 358-478); macros `\standaloneconfig` `\standaloneenv` `\standaloneignore` (485-514, 2079-2092, 4020-4023); environments `standalone` `standaloneframe` `multimath` `multidisplaymath` (516, 544, 1564-1580, 2697-2701); switches `\ifstandalone` `\IfStandalone` `\onlyifstandalone` `\ifstandalonebeamer` (1203-1227); `standalone.cfg`, `standalone.tex` (603-632, 4810-4886).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class (manual) | standalone.dtx:35 | `class.ydoc` | a4paper, 11pt |
| class (bundle) | standalone.dtx:1186-1193, 2160-2163 | `class.standalone` | crop (default), border=0pt (default from cfg 4862, 4874), class=article; other options per the vocabulary list above |
| page size | standalone.dtx:35 | `page.class-options` | a4paper, 11pt; the commented-out margin edit at 38-39 is not active |
| cropped page (class behaviour) | standalone.dtx:2381-2394, 2509-2625 | `class.standalone` | `crop` + `border`; internally zero `\hoffset` `\voffset` `\oddsidemargin` `\textheight=\maxdimen` and page size taken from the content box; done by the class, never emitted by the emitter |
| header/footer (manual) | standalone.dtx:35 (no pagestyle call in the driver) | `hf.class-native` | `ydoc` default running heads |
| header/footer (cropped page) | standalone.dtx:2381 | `hf.pagestyle-kernel` | `\pagestyle{empty}`, set inside the class under `crop` |
| float placement | standalone.dtx:36 | `fig.placement` | `flafter` (floats never before their reference) |
| title block | standalone.dtx:126-129 | `front.class-native` | `\author{Martin Scharrer}`, `\email`, `\repository` (ydoc), `\maketitle` |
| abstract | standalone.dtx:132-137 | `abs.kernel` | `abstract` environment, ydoc look |
| contents | standalone.dtx:140-143 | `toc.kernel` | `\tableofcontents` inside `multicols{2}`, `\setcounter{tocdepth}{2}` |
| two columns for the contents | standalone.dtx:140, 143 | `cols.multicol` | `multicols{2}` |
| toc depth | standalone.dtx:141 | `num.secnumdepth` | `tocdepth=2` |
| headings | standalone.dtx:145, 156, 228, 300, 342, 481, 690, 858, 1060, 1086, 1176; starred `\subsubsection*` at 638-683 | `head.class-native` | `\section` `\subsection` `\subsubsection` and `\subsubsection*` with ydoc's look; no titlesec |
| counters and names | standalone.dtx:1088-1089 | `num.counters` | `\setcounter{lstlisting}{0}` (the `\def\lstlistingname{Example}` is a listings parameter, row `code.listings`) |
| cross-references | standalone.dtx:39-42, 159, 203, 342, 556 | `xref.hyperref` | `\autoref` (24 uses), `\def\subsectionautorefname{section}`, `\def\subsubsectionautorefname{section}` (40-41) |
| labels and refs | standalone.dtx:203, 342, 556, 706, 749, 1034 | `xref.kernel` | `\label{sec:...}` `\label{tab:...}` `\label{lst:beamer}`, `\ref{lst:beamer}` |
| links and URLs | standalone.dtx:146, 149, 152, 181, 214, 218, 783, 793, 801 | `meta.url` | `\url`, `\path` |
| hyperlinks | standalone.dtx:214, 218, 783, 793, 801 | `meta.hyperref` | `\href{...}{...}` |
| PDF metadata | standalone.dtx:118-125 | `meta.hyperref` | `\hypersetup{pdfauthor, pdftitle, pdfsubject, pdfkeywords}` guarded by `\ifpdf` |
| colour | standalone.dtx:45 | `color.xcolor` | `\colorlet{keydesc}{opt}` (`opt` is a ydoc colour) |
| code listings (examples) | standalone.dtx:309, 328, 560, 578, 593, 626, 1093, 1119, 1139, 1162 | `code.listings` | `lstlisting[language={[latex]tex}, gobble=4, frame=lines, numbers=none, caption={...}, label=lst:beamer]`; global `\lstset{numbers=none, columns=fullflexible}` (47); `\def\lstlistingname{Example}` (1088) |
| listing wrappers | standalone.dtx:308, 327, 559, 577, 592, 625, 1092, 1118, 1138, 1161 | `box.minipage` | `minipage{\textwidth}` around each listing |
| inline code | standalone.dtx:199, 250, 347 (`\|...\|` throughout) | `code.verbatim` | ydoc/doc short-verbatim bars |
| implementation code | standalone.dtx:1184-4893 (231 `macrocode` blocks) | `code.listings` | `\lstset{numbers=left}` (1177), then ydoc `macrocode`; listings use is an inference from 1177, ydoc source not read; the code text is content |
| tables | standalone.dtx:703-744, 746-776, 1025-1055 | `tbl.tabular` | `tabular{>{\ttfamily}lp{\dimexpr.7\textwidth\relax}l}` (708) and `.6`, `.45` widths (751, 1036), `\multicolumn`, `\noalign{\smallskip}`, nested `\tabular[t]{@{}l@{}}` (770) |
| table rules | standalone.dtx:709-738, 752-773, 1037-1046 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` (loaded by ydoc, not in the driver) |
| captions | standalone.dtx:706, 749, 1034; listing `caption=` keys at 309 etc. | `cap.kernel` | `\caption[short]{long}` (706), `\caption{...}`, `\belowcaptionskip=\abovecaptionskip` (705, 748, 1033) |
| table cell centring and tightening | standalone.dtx:704, 707, 743, 747 | `sp.manual-space` | `\vspace*{-10ex}`, `\hbox to\textwidth{\hss ... \hss}`, `\newline\bigskip` (757, 762) |
| hand-set cell content | standalone.dtx:757-765 | `sp.rule` | `\hbox{\vtop{\hbox{\strut ...}}}` with `\vrule height 2\ht\strutbox width 0pt` as a strut; content of two cells, see Bespoke code |
| font sizes in cells | standalone.dtx:1041-1045 | `font.size-commands` | `\tiny` `\scriptsize` `\normalsize` |
| footnote | standalone.dtx:780 | `fn.kernel` | `\footnote{...}` |
| text marks | standalone.dtx:157, 162, 250 (`\emph`, `\texttt`) | `mark.kernel` | `\emph`, `\texttt` |
| manual spacing | standalone.dtx:139, 307, 558, 817-849 | `sp.manual-space` | `\smallskip` `\medskip` `\bigskip` `\par\noindent` |
| page breaks | standalone.dtx:59, 226, 299, 857, 1175 | `pg.break` | `\clearpage`, `\newpage` |
| index and change history | standalone.dtx:42-44, 58-59, 82-100 | `idx.makeidx` | closest way: ltxdoc/ydoc `\CodelineIndex` `\RecordChanges` `\PrintChanges` `\PrintIndex` with a makeindex pass (same status as bibtex in the lib) |
| logo macro | standalone.dtx:49-55 | `mark.kernel` | closest way only: `\XeLaTeX` is a content macro (`metalogo`, or text fallback), no look |
| sub-file inclusion (package, load only) | standalone.dtx:37 | `pg.standalone-pkg` | `\usepackage{standalone}` with no options in the manual driver |
| sub-file inclusion (documented) | standalone.dtx:859-998, 1093-1113, 3199-3334, 4645-4737 | `pg.standalone-pkg` | options `subpreambles` `sort` `print` `comments` `group` `mode=tex\|image\|image\|tex\|build\|buildmissing\|buildnew` `obeyclassoptions` `extension` `build={...}`; body `\input{subfile}` or `\includestandalone[<includegraphics keys>,<options>]{file}` |
| preview cropping (class option) | standalone.dtx:371-380, 2309-2361, 4866-4868 | `class.standalone` | `preview` option loads `preview` with `active,tightpage` (cfg 4867); a parameter of the class, not a separate way |
| beamer mode (class option) | standalone.dtx:457-459, 527-600, 2691-2729 | `class.standalone` | `beamer` option; `standaloneframe` wraps `frame`; the overlay text `\only<1>` at 569-570 is listing text |
| beamer navigation symbols | standalone.dtx:4882-4886 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` under `\AtEndOfClass{\ifstandalonebeamer ...}` in the shipped cfg, beamer mode only |
| picture options (class) | standalone.dtx:449-455, 2289-2301 | `class.standalone` | `tikz` and `pstricks` options load `tikz` and `pstricks` for sub-file pictures; content, see Content-opaque |
| image conversion (class) | standalone.dtx:472-478, 690-853, 1704-2008, 2736-2941 | `class.standalone` | `convert` and `png jpg gif svg emf` options, sub-keys per tables at 708-776; EXTERNAL/package only when selected (needs `-shell-escape`) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\Eurl` | standalone.dtx:48 | yes (moot: the only occurrence is its definition) | `\edef` pre-expansion then `\url`; an alias onto `meta.url` |
| `\subsectionautorefname`, `\subsubsectionautorefname` | standalone.dtx:40-41 | yes | hyperref name strings, `xref.hyperref` parameter |
| `\IfFileExists{metalogo.sty}{...}{\providecommand{\XeLaTeX}...}` | standalone.dtx:49-55 | yes | emit `\usepackage{metalogo}`; the fallback is a text alias (the second `\providecommand` at 54 is dead, the first at 53 wins) |
| `\showbuildvar` | standalone.dtx:1026-1032 (used 1041-1044) | yes | prints the sanitized default of the package's own `sa@build@*` macros into table cells; the printed text is plain strings, so emit the literal strings as cell content |
| `\hbox{\vtop{\hbox{\strut...}...}}` cell bodies | standalone.dtx:757-765 | yes (content) | literal command lines inside a `tabular` cell, `sp.manual-space` and `sp.rule`; cell contents are content |
| `standalone.cls` internals (crop box, PostScript bounding box in DVI mode, `\@float` swap, `convert` sub-process) | standalone.dtx:1186-2976 | not bespoke: published CTAN class (W1) | the way is `class.standalone` with its options; without W1 this is irreducible BESPOKE/package (2509-2625, 2761-2882) |
| `standalone.sty` internals (sub-preamble token scanner, `.sta`/`.stp` files, `\includestandalone`, build) | standalone.dtx:2997-4793 | not bespoke: published CTAN package (W1) | the way is `pg.standalone-pkg`; without W1 this is irreducible BESPOKE/package (3828-4149, 4686-4793) |
| shipped `standalone.cfg` and `standalone.tex` | standalone.dtx:4818-4824, 4844-4886 | yes | cfg is options only: `\standaloneconfig{crop}`, `\PassOptionsToPackage{active,tightpage}{preview}`, `\standaloneconfig{border=0pt}`, beamer navigation symbols off; `standalone.tex` only defines `\ifstandalone` |

## Content-opaque
- `tikzpicture` text in `lstlisting` at standalone.dtx:332-334, 1130-1132, 1152-1154: listing text, no picture is drawn by the manual.
- Hand-set `\vtop` cell content at standalone.dtx:757-765 and `\showbuildvar` output at 1041-1044: table cell content.
- Conversion command lines (`convert={ghostscript,gsdevice=tiffg4,...}`, 819-852) are example text.

## Lib changes
- New ways proposed: `pg.standalone-pkg` (package `standalone`, `\usepackage[options]{standalone}` and `\includestandalone[options]{file}`; engine pdf, `mode=buildnew` not on XeLaTeX per 943, 3302-3306). W1: CTAN and TeX Live (ctan.org/pkg/standalone). W2: behaviour chosen by option values (`subpreambles`, `sort`, `print`, `comments`, `group`, `mode`, `obeyclassoptions`, `extension`, `build`, standalone.dtx:881-973). W3: serves one kind of component, inclusion of sub-documents or pictures kept in their own compilable files, not one document. W4: a preamble line plus a body wrapper (`\input` or `\includestandalone`). Looked up first: `grep -n 'subfile\|standalone\|include' _Lib.md` finds only `class.standalone` (the class) and `pg.include-pdf` (pdfpages, a different job). The package is the main-document side of the same bundle; sibling packages `subfiles` and `docmute` are named at standalone.dtx:283-289 but are not read here, so they are not claimed. Values `mode=build*` are EXTERNAL when selected.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
