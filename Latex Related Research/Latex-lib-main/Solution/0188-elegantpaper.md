yes

# 0188-elegantpaper: ElegantPaper (working-paper template)

- Unverified: read from the source, not compiled.
- Source: Source/0188-elegantpaper/ (origin: https://mirrors.ctan.org/macros/latex/contrib/elegantpaper.zip; licence: LPPL 1.3c, License:4 and README.md:27)
- Kind: journal (an economics working paper on the kernel article class, README.md:17)
- Lib: v3
- Engine: pdfLaTeX-compatible (main sample, `lang=en`: the class forks on `\ifXeTeX`, elegantpaper.cls:110-130, and takes the `newtxtext` + `helvet` branch under pdfTeX; the `lang=cn` sample elegantpaper-cn.tex:33 says "must be compiled with XeLaTeX", so that mode is XeLaTeX-only)
- Look carried by: class (elegantpaper.cls sets geometry, line spread, fonts, title block, theorem set, caption, list and listings looks and loads biblatex; the sample adds only `\usepackage{array}` and one alias that is never called, elegantpaper-en.tex:11-12)
- Class origin: ctan (the zip is the CTAN release: `macros/latex/contrib/elegantpaper`; read once at https://ctan.org/pkg/elegantpaper: elegantpaper 0.12 dated 2026-02-27, LPPL 1.3c, included in TeX Live; the `.cls` header says v0.12, elegantpaper.cls:6)
- Main file: elegantpaper-en.tex (other samples: elegantpaper-cn.tex)
- Read: main yes, zip-local classes and styles all (elegantpaper.cls, 370 lines, read in full; elegantpaper-cn.tex read in full too)

## Verdict
The look is carried by the published CTAN and TeX Live class `elegantpaper`, so it is one class way (W1 holds), and its behaviour is chosen by option values (`lang`, `math`, `citestyle`, `bibstyle`, `bibend`, `chinesefont`, plus article options). The sample adds `\usepackage{array}` and one `\newcommand` alias that is defined but never called, and every body construct (title fields, abstract with keywords, sections, lists, footnote, equation, listings, biblatex citations, appendix) maps to a lib way. No `ART`, no `EXTERNAL` (`biber` is the accepted way `bib.biblatex-biber`), no `UNMAPPED`. This is evidence about the class dimension: the class source redefines `\maketitle`/`\@maketitle` and uses a hand-rolled `\IfEmpty` (elegantpaper.cls:272-340), which would be irreducible if the class were zip-local, but it is a published class, so it stays inside the one way.

## Blockers
none

## Class setting
- Class: `class.elegantpaper` options: `11pt` (passed on to `article`, elegantpaper.cls:40), `en` (void option that sets `lang=en`, elegantpaper.cls:19; elegantpaper-en.tex:1). The class loads `article` (elegantpaper.cls:42). Other keys the class declares: `lang` en|cn (17), `math` cm|newtx|mtpro2 (21, 36-38), `citestyle` default `numeric-comp` (23), `bibstyle` default `numeric` (24), `bibend` biber|bibtex (26-28), `chinesefont` ctexfont|founder|nofont (31-34).
- Class-native vocabulary used: `\institute{}` (elegantpaper.cls:277; elegantpaper-en.tex:5), `\version{}` (elegantpaper.cls:276; elegantpaper-en.tex:7), `\keywords{}` inside `abstract` (elegantpaper.cls:254; elegantpaper-en.tex:21), `\ebibname` (elegantpaper.cls:257; elegantpaper-en.tex:149). Defined by the class but only mentioned in prose by the sample: `\email` (elegantpaper.cls:101), `\figref`, `\tabref` (elegantpaper.cls:255-256), `\versiontext`, `\updatetext` (elegantpaper.cls:249-250), pre-declared theorem environments (elegantpaper.cls:236-247). Commands the class brings from published packages and the sample calls: `\hologo` (elegantpaper.cls:76; elegantpaper-en.tex:30), `\lstinline`, `lstlisting` (elegantpaper.cls:343; elegantpaper-en.tex:30, 38-40), `\addbibresource`, `\cite`, `\parencite`, `\printbibliography` (elegantpaper.cls:195; elegantpaper-en.tex:14, 77, 149), `\addappheadtotoc` (elegantpaper.cls:200; elegantpaper-en.tex:153).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | elegantpaper-en.tex:1; elegantpaper.cls:6, 42 | `class.elegantpaper` | options `11pt,en`; `\LoadClass{article}` inside |
| option parsing | elegantpaper.cls:10-41 | `class.elegantpaper` | `kvoptions` family ELEGANT; unknown options go to `article` (line 40); nothing to emit beyond the options |
| paper size, point size | elegantpaper-en.tex:1; elegantpaper.cls:40 | `page.class-options` | `11pt` (no paper option, so the article default); `a4paper` is allowed and shown in prose, elegantpaper-en.tex:39 |
| page geometry | elegantpaper.cls:55-62 | `page.geometry` | left=1in, right=1in, top=1in, bottom=1in, headheight=0pt, headsep=0pt |
| header-to-text gap | elegantpaper.cls:62 | `page.setlength` | `\setlength{\headsep}{5pt}` |
| header/footer, page numbers | elegantpaper.cls:297 | `hf.pagestyle-kernel` | article default `plain` style; `\thispagestyle{plain}` after the title block; no `fancyhdr` |
| line spacing | elegantpaper.cls:78 | `sp.linespread` | `\linespread{1.35}` |
| first-paragraph indent | elegantpaper.cls:67 | `sp.indentfirst` | package `indentfirst` loaded, no options |
| paragraph indent, display skips, footnote gap | elegantpaper.cls:251, 267-268, 270 | `sp.lengths` | `\parindent`=2em (en branch); `\abovedisplayskip`=3pt, `\belowdisplayskip`=3pt, `\footnotesep`=12pt (set in `\AtBeginDocument`) |
| text font (pdfTeX branch) | elegantpaper.cls:127-130 | `font.newtx` | `\RequirePackage{newtxtext}` |
| sans font (pdfTeX branch) | elegantpaper.cls:129 | `font.helvet` | `helvet` with `scaled=.90` |
| text fonts (XeTeX branch) | elegantpaper.cls:110-126 | `font.fontspec` | `\setmainfont{texgyretermes}` with `UprightFont=*-regular`, `BoldFont=*-bold`, `ItalicFont=*-italic`, `BoldItalicFont=*-bolditalic`, `Extension=.otf`, `Scale=1.0`; `\setsansfont{texgyreheros}` same keys, `Scale=0.9`; `fontspec` loaded with `no-math`, `quiet` (106-107, 111) |
| typewriter family default | elegantpaper.cls:344, 370 | `font.family-default` | `\ttdefault` set to `cmtt` at line 344, reset to `lmtt` at line 370 (the later one wins at the end of the class) |
| math font, `math=cm` (default) | elegantpaper.cls:21, 175 | `math.amsmath` | no math-font package loaded; Computer Modern; `amsmath` (65) and `amssymb` (66) loaded as `math.amssymb` |
| math symbols | elegantpaper.cls:66 | `math.amssymb` | `\RequirePackage{amssymb}` |
| math font, `math=newtx` (cn sample, option value) | elegantpaper-cn.tex:1; elegantpaper.cls:175-192 | `font.newtx` | `newtxmath` loaded; also `esint` (considered: esint, a published integral-symbol package, only inside this option branch), `\DeclareSymbolFont{CMlargesymbols}{OMX}{cmex}{m}{n}` and `\DeclareMathSymbol` of `\sumop` `\prodop` (class-internal patch, covered by the class way) |
| colours | elegantpaper.cls:72, 92-97 | `color.xcolor` | `winered`=rgb 0.5,0,0; `lightgrey`=rgb 0.95,0.95,0.95; `commentcolor`=RGB 0,100,0; `frenchplum`=RGB 190,20,83 |
| coloured text in body | elegantpaper-en.tex:24 | `color.xcolor` | `\textcolor{red}{\bfseries ...}` |
| bold text | elegantpaper-en.tex:24, 30, 32, 41 | `mark.kernel` | `\bfseries`, `\textbf`, `\textit` (en:130), `\emph` (en:107) |
| hyperlinks and PDF link colours | elegantpaper.cls:44-53; elegantpaper-en.tex:5 | `meta.hyperref` | `pdfborder={0 0 0}`, `colorlinks=true`, `linkcolor`=`urlcolor`=`filecolor`=`citecolor`=`winered`, `linktoc=all`; body `\href{url}{text}` |
| `\email` link | elegantpaper.cls:101 | `meta.hyperref` | `\href{mailto:#1}{\nolinkurl{#1}}` (class-native alias; not called in the main sample) |
| TeX-logo names | elegantpaper.cls:76; elegantpaper-en.tex:30, 36 | `font.icons` | package `hologo`; `\hologo{XeLaTeX}`, `\hologo{pdfLaTeX}` |
| title block | elegantpaper-en.tex:3-8, 17; elegantpaper.cls:279-340 | `front.class-native` | `\title`, `\author` (with `\\` and `\and`), `\institute`, `\version{0.12}`, `\date{Feb. 27, 2026}`, `\maketitle`; the class prints centred `\LARGE\bfseries` title, `\large` author tabular, institute, then version and date lines in `\small` italic (`\citshape` is `\itshape` without CJK, 158-162), labels `Version: ` and `Date: ` (249-250) |
| abstract | elegantpaper-en.tex:19-22; elegantpaper.cls:75, 252 | `abs.abstract-pkg` | package `abstract`; `\abstracttextfont` = `\sffamily\small\noindent\ignorespaces` (en branch) |
| keyword line | elegantpaper-en.tex:21; elegantpaper.cls:254 | `abs.keywords` | `\keywords{...}` prints `\vskip 2ex`, `\par`, bold `Keywords: ` then the list |
| section headings | elegantpaper-en.tex:26, 34, 43, 104, 117, 127, 143 | `head.kernel` | `\section*`, `\section`, `\subsection`, `\subsubsection` at the article defaults; the class restyles nothing |
| lists | elegantpaper-en.tex:58-62, 67-72, 129-141 | `list.kernel` | `enumerate` with `\item` |
| list spacing and labels | elegantpaper.cls:87-88; elegantpaper-en.tex:129 | `list.enumitem` | `enumitem` options `shortlabels,inline`; `\setlist{nolistsep}`; body key `label=\arabic*).` |
| footnotes | elegantpaper-en.tex:66; elegantpaper.cls:269 | `fn.kernel` | `\footnote{...}` |
| footnote layout | elegantpaper.cls:269 | `fn.footmisc` | `\RequirePackage[flushmargin]{footmisc}` inside `\AtBeginDocument` |
| display equation | elegantpaper-en.tex:106-108; elegantpaper.cls:65 | `math.amsmath` | `equation` environment, `\int`, `\kern0pt` |
| theorem-like environments (defined, not used in the main body) | elegantpaper.cls:64, 235-248 | `thm.amsthm` | `\theoremstyle{plain}`: `theorem` [section], `lemma` [theorem], `proposition` [theorem], `corollary*`; `\theoremstyle{definition}`: `definition` [section], `conjecture` [section], `example` [section]; `\theoremstyle{remark}`: `remark*`, `note*`, `case`; `\proofname` set bold `Proof` (line 248) |
| figure and table float machinery (loaded, not exercised by the main sample) | elegantpaper.cls:73, 79; elegantpaper-cn.tex:79-82 | `fig.graphicx` | `graphicx`; `\graphicspath{{image/}{figure/}{fig/}{img/}}`; the cn sample has one `figure` with `\includegraphics[width=0.9\textwidth]{founder.png}` |
| caption style | elegantpaper.cls:82-84 | `cap.caption` | `caption` with `labelfont={bf}`; `\captionsetup[table]{skip=3pt}`, `\captionsetup[figure]{skip=3pt}` |
| tables (loaded by the class, none in the main body) | elegantpaper.cls:68, 70; elegantpaper-en.tex:11 | `tbl.booktabs` | `booktabs` loaded (68); `multirow` loaded (70) as `tbl.multirow`; the sample's `\usepackage{array}` is `tbl.tabular` |
| table font size | elegantpaper.cls:263 | `font.size-commands` | `\BeforeBeginEnvironment{tabular}{\small}` (etoolbox hook) |
| multicolumn environment (loaded only) | elegantpaper.cls:69 | `cols.multicol` | package `multicol`, no options |
| verbatim support and hook | elegantpaper.cls:74, 262 | `code.verbatim` | `fancyvrb` loaded; `\AtBeginEnvironment{verbatim}{\microtypesetup{activate=false}}` calls `\microtypesetup` (`sp.microtype`), but the class never loads `microtype` (no `\RequirePackage{microtype}`; only the word at line 360); the sample has no `verbatim` environment (it uses `lstlisting`), so the hook does not fire there |
| code listings, display and inline | elegantpaper.cls:343-365; elegantpaper-en.tex:30, 38-40 | `code.listings` | `lstdefinestyle{estyle}` with `basicstyle=\ttfamily\lst@ifdisplaystyle\footnotesize\fi` (346-350); `\lstset`: `language=[LaTeX]TeX`, `texcsstyle=*\color{winered}`, `numbers=none`, `breaklines=true`, `keywordstyle=\color{winered}`, `frame=tlbr`, `framesep=4pt`, `framerule=0pt`, `commentstyle=\color{commentcolor}`, `emph={...}`, `emphstyle={\color{frenchplum}}`, `morekeywords={...}`, `tabsize=2`, `backgroundcolor=\color{lightgrey}` (351-364); `\lstinline{...}`, `lstlisting` in the body |
| bibliography engine | elegantpaper.cls:26, 195-198; elegantpaper-en.tex:14, 149 | `bib.biblatex-biber` | `biblatex` with `backend=\ELEGANT@bibend` (default `biber`), `citestyle=numeric-comp`, `bibstyle=numeric`; `\addbibresource[location=local]{reference.bib}`; `\printbibliography[heading=bibintoc, title=\ebibname]`; entries in reference.bib:1-71 |
| bibliography engine, other `bibend` value | elegantpaper.cls:28, 196 | `bib.biblatex-bibtex` | same `biblatex` call with `backend=bibtex` (`bibtex`/`bibend=bibtex` option; not used by the main sample) |
| citations in text | elegantpaper-en.tex:77 | `bib.biblatex-biber` | `\cite{en1}`, `\cite{en3}`, `\parencite{en2}` |
| bibliography font | elegantpaper.cls:260 | `font.size-commands` | `\def\bibfont{\footnotesize}` |
| bibliography heading name | elegantpaper.cls:257 | `front.class-native` | `\newcommand{\ebibname}{Bibliography}` (the sample passes it as the heading title) |
| appendix | elegantpaper.cls:200; elegantpaper-en.tex:151-153 | `num.appendix` | package `appendix`; body `\appendix`, `\addappheadtotoc`; `\appendixpage` is commented out (en:152) |
| language: Chinese mode (cn sample, conditional) | elegantpaper.cls:132-155, 202-232; elegantpaper-cn.tex:1 | `lang.cjk` | `ctex` with `UTF8,scheme=plain` (+`fontset=none` for `founder` and `nofont`); `\AfterEndPreamble{\setlength\parindent{2\ccwd}}`; Chinese theorem, caption and contents names set by `\renewcommand` strings; the `founder` branch needs FZ fonts not in the zip (`setCJKmainfont` etc., 135-141) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\ccr` alias | elegantpaper-en.tex:12 (same at elegantpaper-cn.tex:12) | yes | `\newcommand{\ccr}[1]{\makecell{{\color{#1}\rule{1cm}{1cm}}}}`: an alias over `\makecell` (`tbl.multirow`), `\color` (`color.xcolor`) and `\rule` (`sp.rule`). Never called in either sample (grep finds only the definition), and `\makecell` is not loaded by the sample or the class, so calling it would fail; nothing to emit |
| `elegantpaper.cls` internals: `\maketitle` and `\@maketitle` redefinition, `\IfEmpty`, `\newtoks\version`, `\newtoks\institute`, `\citshape`/`\cnormal`/`\cfs` fallbacks, `\AfterEndPreamble` indent, `math=newtx` symbol patch | elegantpaper.cls:272-340, 158-173, 153-154, 175-192 | not counted: published | The class is on CTAN and in TeX Live (W1), so these are inside `class.elegantpaper`, not bespoke by the rubric. An emitter writes `\documentclass[11pt,en]{elegantpaper}` and the title fields; it never copies this code |
| `\email`, `\figref`, `\tabref`, `\keywords`, `\ebibname`, `\versiontext`, `\updatetext` | elegantpaper.cls:101, 249-257 | not counted: published | class-native vocabulary; as aliases they would reduce to `meta.hyperref`, `xref.kernel` + `mark.kernel`, `abs.keywords` |

## Content-opaque
none in the main sample (no figure, table, TikZ or image). In the cn sample: `\includegraphics{founder.png}` in a figure (elegantpaper-cn.tex:79-82), an image shipped as image/founder.png (artwork inside a float, content).

## Lib changes
- New ways proposed: none. Considered: `esint` (integral-symbol package in the `math=newtx` branch, elegantpaper.cls:178; not exercised by the main sample, and inside the published class's option, so no way is proposed).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Unchecked class quirks (nothing compiled): `\microtypesetup` at elegantpaper.cls:262 with no `microtype` load; `math=mtpro2` is declared (elegantpaper.cls:37) but no branch loads `mtpro2` in the class; the sample text says the default citestyle is `numeric` (elegantpaper-en.tex:77) while the class default is `numeric-comp` (elegantpaper.cls:23).
- Missing assets, not blockers: TeX Gyre Terms/Heros OTF files for the XeTeX branch (system or TeX Live), FZ fonts for `chinesefont=founder`, `biber` binary for the default backend.
- Text in the files addressed to an AI: none found.
