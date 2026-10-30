yes

# 0207-tandf-interact: Taylor & Francis Interact class with the APA reference-style sample

- Unverified: read from the source, not compiled.
- Source: Source/0207-tandf-interact/ (origin: https://files.taylorandfrancis.com/interactapalatex.zip; licence: not established)
- Kind: journal
- Lib: v2
- Engine: pdfLaTeX-compatible
- Look carried by: mixed (interact.cls carries page, title block, headings, lists, floats, captions, footnotes and theorem styles; the sample preamble adds natbib APA citation setup, subfig, hyperref, url, epstopdf and amsthm `\newtheorem` declarations)
- Class origin: publisher-official
- Main file: interactapasample.tex (other samples: none)
- Read: main yes, zip-local classes and styles partly (interact.cls in full; tfapastyle.sty only lines 1-190, 985-1040, 1195-1500, 1775-1830, 1925-1965; the five CTAN copies, tfapacite.bst, apacite.dtx and apacite.ins by header and provenance only)

## Verdict
Yes. The look comes from the publisher's own `interact.cls` (the zip is Taylor & Francis's author kit, so the class is published and is one way, `class.interact`), loaded as `\documentclass[]{interact}` with no options. The sample preamble adds only published packages (natbib, subfig, hyperref, url, epstopdf) and `\newtheorem` calls, all lib ways; its reference list is a hand-written `thebibliography`. There is no artwork, and the sample defines no macro of its own except one `\renewcommand\bibfont`.
Two judgement calls, so a reviewer can re-read them. (1) The yes relies on the rubric's ruling that a publisher's official kit is published: read as a zip-local class, `interact.cls` would be BESPOKE/class, because it redefines `\@startsection`, `\@sect`, `\@makecaption`, `\@maketitle` (interact.cls:349-407, 656-676, 292-308). (2) `\usepackage{epstopdf}` (interactapasample.tex:6) makes pdfLaTeX convert the two sample `.eps` figures through an outside converter. I treat that as preparing figure content (ship PDF copies and drop the line), not as an EXTERNAL dependency of the template; if a reviewer counts it, the verdict becomes no with `EXTERNAL/package`.

## Blockers
none

## Class setting
- Class: `class.interact` options: none in the sample (interactapasample.tex:4). The class declares `largeformat` (A4 two-column journals: 1in margins) and `suppldata` (drops the ARTICLE HISTORY block), passes every other option to `article` (interact.cls:17-19), executes `a4paper,oneside,onecolumn,final` (:20) and loads `article` with `11pt,a4paper` (:23).
- Class-native vocabulary used: `\articletype`, `\title`, `\author{\name{..}\affil{..}}`, `\thanks`, `\maketitle`, `abstract`, `keywords` (interactapasample.tex:39-56); `\tbl{caption}{tabular}`, `\tabnote{..}` (:249-258); upright Greek `\umu` `\upi` `\upartial` and `\bm` (:391). Documented in the sample but not run: `abbreviations` (:143), `amscode`/`jelcode`/`pacscode` (:153), `suppldata` (:96, commented), `sidewaysfigure`/`sidewaystable` (:289-304, inside `verbatim`). Defined in the class, never used by the sample: `\received`/`\history` (interact.cls:267-270), `\jname` `\jvol` `\jnum` `\jmonth` `\jyear` `\doi` `\endpage` (:233-246), `\ArtPiece` `\figurebox` (:584-611).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | interactapasample.tex:4; interact.cls:12,17-23 | `class.interact` | no options; defaults `a4paper,oneside,onecolumn,final`; `\LoadClass[11pt,a4paper]{article}`; own options `largeformat`, `suppldata` |
| paper and base size | interact.cls:20,23,64-65 | `page.class-options` | a4paper, 11pt; `\normalsize` reset to 11/13pt |
| page geometry | interact.cls:27-32 | `page.geometry` | default `textwidth=34pc,textheight=650pt` (B5 single column); with `largeformat` `left=1in,right=1in,top=1in,bottom=1in`; the sample says not to add `geometry` (interactapasample.tex:94) |
| columns | interact.cls:20,723-724,729 | `cols.twocolumn-cmd` | `\onecolumn`; `\columnsep` 12pt, `\columnseprule` 0pt |
| page style | interact.cls:248-256,284,725 | `hf.pagestyle-kernel`, `hf.class-native` | `\pagestyle{plain}`; class page style `title` (empty head and foot, `\sectionmark` and `\subsectionmark` gobbled) set by `\thispagestyle{title}` inside `\maketitle` |
| page numbers | interact.cls:726 | `pgnum.pagenumbering` | arabic |
| spacing lengths | interact.cls:31,66-69,413-459,651-652,722 | `sp.lengths` | `\parskip` 0pt, `\parindent` 12pt, display skips 13pt plus 2pt minus .5pt, `\topsep` 6pt, `\itemsep` 0pt, `\abovecaptionskip` 12pt, `\belowcaptionskip` 0pt |
| line and glue switches | interact.cls:727-728 | `sp.frenchspacing`, `sp.hyphenat` | `\frenchspacing`, `\sloppy` |
| alignment | interact.cls:37,39,46; interactapasample.tex:213,224 | `sp.ragged` | `\raggedright` in author, affil, section fonts; `\centering` in figures; `\centerline` in `\tbl` (interact.cls:632) |
| font sizes | interact.cls:36-55,64-102 | `font.size-commands` | normalsize 11/13, small 10/11, footnotesize 8/10; title 13/16 bold, author 11/13, affil 10/12, abstract and keywords 9/10, caption 8/10, table 8/9 |
| default family and encoding | interact.cls:124-131 | `font.family-default`, `font.nfss` | `\rmdefault` = cmr; `\encodingdefault` OT1; family `Clearface` declared for OT1 (m/n, m/it) but never selected in the class or the sample |
| math fonts | interact.cls:133-138,151-166,168-227 | `font.nfss`, `class.interact` | Euler `eur` OML family; math versions `upright` and `boldupright` (`\DeclareMathVersion`, `\SetSymbolFont`); class-native `\umu` `\upi` `\upartial`, `\bm` through `\mathversion{bold}` (no separate lib way; carried by the class) |
| math packages | interact.cls:25; interactapasample.tex:337-381 | `math.amsmath`, `math.amssymb` | amsmath (`equation`, `subequations`, `\[ \]`), amssymb, amsfonts, amsbsy |
| equation numbering | interact.cls:562,567 | `num.counters` | main text `\theequation` arabic; after `\appendix` `\thesection\arabic{equation}`, reset per section |
| title block | interactapasample.tex:39-48; interact.cls:262-308 | `front.class-native` | `\articletype` 12/14 uppercase; `\title` 13/16 bold; `\author` 11/13 with `\name` (6pt after) and `\affil` 10/12; ARTICLE HISTORY and `Compiled \today` 9/12 (hidden by `suppldata`); skips 36pt, 13pt, 17pt |
| author notes | interactapasample.tex:44; interact.cls:276-278,281 | `front.thanks` | `\thanks` collects `\footnotetext` at 8/10; `\thefootnote` empty during `\maketitle` |
| abstract | interactapasample.tex:50-52; interact.cls:486-491,715 | `abs.class-native` | name ABSTRACT bold, 9/10, `\leftskip1pc` `\rightskip5pc`, skips 13pt plus 2pt minus 1pt |
| keywords | interactapasample.tex:54-56; interact.cls:500-505,717 | `abs.keywords` | `keywords` environment, name KEYWORDS |
| classification and abbreviations | interact.cls:493-498,507-526,716,718-720 | `abs.classification`, `abs.class-native` | `amscode` `jelcode` `pacscode`, `abbreviations` (documented, not run) |
| headings | interactapasample.tex:59,68,335,387; interact.cls:328-347 | `head.class-native` | section 11/13 bold ragged, skips -26pt/13pt; subsection bold italic, -24pt/7pt; subsubsection italic, 18pt/6pt; paragraph run-in bold, -6pt; subparagraph 3.25ex/-1em; `\@startsection` and `\@sect` replaced (:349-407); number then period and 0.5em (:368-370) |
| heading numbers | interact.cls:314,321-326 | `num.secnumdepth`, `num.counters` | `secnumdepth` 5; `\thesection` arabic, `\thesubsection` `\thesection.\arabic{subsection}` ... |
| unnumbered sections | interactapasample.tex:394-421 | `head.class-native` | `\section*{Acknowledgement(s)}`, Disclosure statement, Funding, Notes on contributor(s), Nomenclature/Notation, Notes |
| appendix | interactapasample.tex:792-794; interact.cls:560-570 | `num.appendix` | `\appendix` redefined: prefix "Appendix A." (`\@appseccntformat`), `\Alph{section}`, figure, table, equation numbers `\thesection\arabic{..}` reset per section |
| lists | interactapasample.tex:175-179,191-195,797-801; interact.cls:413-477 | `list.kernel` | `enumerate` `itemize`; `\leftmargini` 2.5em, `\labelsep` .5em; labels `(1)` `(a)` `(i)` `(A)`; bullets bullet, circle, en dash, asterisk; `\item[(i)]` labels typed by hand (sample :798) |
| quotes | interact.cls:535-554 | `quote.kernel` | `quote` and `quotation` at 10/12 with 12pt side skips; defined, not used in the sample body |
| footnotes | interactapasample.tex:162; interact.cls:682-689 | `fn.kernel` | rule: kern 2pt, `\hrule` full width 0.25pt, kern 4pt; `\@makefntext` indent .5em, mark in 1em box |
| figure float | interactapasample.tex:212-232; interact.cls:576-582 | `fig.graphicx` | `figure` sets `\figcaptionfont` 8/10; `\centering`, `\resizebox*{5cm}{!}{\includegraphics{graph1.eps}}`; `\hspace{5pt}` between the two panels |
| EPS under pdfLaTeX | interactapasample.tex:6,240 | `fig.graphicx` | `\usepackage{epstopdf}`, no options (graphics-inclusion helper for content figures; see Verdict, judgement 2) |
| subfigures | interactapasample.tex:7,214-217 | `fig.subcaption` | `subfig` with `caption=false` (no `caption` package), `\subfloat[text]{...}` |
| rotated floats | interact.cls:25; interactapasample.tex:289-304 | `fig.rotating` | `rotating` (`sidewaysfigure`, `sidewaystable`) loaded by the class; `epsfig` (`\epsfbox`) loaded too; examples only inside `verbatim` |
| table float | interactapasample.tex:248-261; interact.cls:617-633 | `tbl.tabular` | `table` then `\tbl{caption}{tabular}`: body in `\tablefont` 8/9, width measured into `\tabledim`, caption above, body centred, `\vskip5pt` at the end; `\multicolumn` kernel |
| table rules | interactapasample.tex:251-256; interact.cls:25,643-645 | `tbl.booktabs` | `\cmidrule` from booktabs; `\toprule` `\midrule` `\bottomrule` redefined as `\hline` with `\\[-5.5pt]`-style tweaks |
| table notes | interactapasample.tex:258; interact.cls:635-640 | `class.interact` | `\tabnote` environment 8/9, `\leftskip\rightskip` = `\tabledim` (class-native, no lib way of its own) |
| captions | interactapasample.tex:218-220,249-250; interact.cls:576,617,656-676 | `cap.kernel` | `\fnum@figure` "Figure~N."; figure caption 8/10 with bold number, centred when one line, else flush-left justified; table caption 8/10 with `\leftskip\rightskip\tabledim`, bold number |
| theorem declarations | interactapasample.tex:23-35 | `thm.amsthm` | `\theoremstyle{plain,definition,remark}`; `\newtheorem{theorem}{Theorem}[section]`; lemma, corollary, proposition, definition, example share the theorem counter; remark and notation own counters |
| theorem styles | interact.cls:704-711 | `thm.amsthm`, `thm.class-native` | `\newtheoremstyle` for plain, definition and remark: spacing 9pt/9pt, body `\itshape` for plain only, head `\bfseries`, punctuation ".", head gap 0.5em |
| proof | interactapasample.tex:319-321; interact.cls:695-702 | `thm.class-native` | `proof` redefined, head `\bfseries\itshape`, `\qed` through `\pushQED` |
| cross-references | interactapasample.tex:68,91,220,260 | `xref.kernel` | `\label`, `\ref` |
| hyperlinks | interactapasample.tex:20 | `meta.hyperref` | `\usepackage{hyperref}`, no options, no `\hypersetup` |
| urls | interactapasample.tex:21,436 | `meta.url` | `\usepackage{url}`, `\url{..}` |
| citations | interactapasample.tex:12-14,428-430 | `bib.natbib` | `[longnamesfirst,sort]`; `\bibpunct[, ]{(}{)}{;}{a}{,}{,}`; `\bibfont` = `\fontsize{10}{12}\selectfont`; `\citep` `\citet` `\citealp` `\citealt` `\citeyear` `\citeyearpar` `\citeauthor` `\cite` |
| reference list | interactapasample.tex:424,438-566 | `bib.thebibliography` | `thebibliography{}` with `\bibitem[Adams et~al.(2008)]{adams08}` natbib labels; APA 7 text typed by hand |
| optional BibTeX APA route (commented out) | interactapasample.tex:16-18,756-767; tfapastyle.sty:46,93-100 | `bib.apacite`, `bib.bibtex-bst` | `\usepackage[natbibapa]{tfapastyle}` (apacite 6.03 renamed, `\ProvidesPackage{apacite}`), `\setlength\bibhang{12pt}`, `\renewcommand\bibliographytypesize{\fontsize{10}{12}\selectfont}`, `\bibliographystyle{tfapacite}`, `\bibliography{interactapasample}` |
| code and verbatim | interactapasample.tex:109-130,181-187 | `code.verbatim` | `verbatim` environment and `\verb"..."` throughout |
| inline marks | interactapasample.tex:41,51,61; interact.cls:38 | `mark.kernel` | `\emph` `\textsf` `\texttt` `\textsc` `\textbf` `\textsuperscript`, `\MakeUppercase` |
| manual spacing | interactapasample.tex:215,567,780 | `sp.manual-space` | `\hspace{5pt}`, `\bigskip`, `\medskip` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `interact.cls` (whole class: fonts, title, headings, lists, floats, captions, appendix) | interact.cls:1-731 | not bespoke | publisher-official class, one way `class.interact`; internals are not decomposed (see Verdict, judgement 1) |
| `\renewcommand\bibfont` | interactapasample.tex:14 | yes | `bib.natbib` parameter: reference-list font 10/12 |
| `\newtheorem`, `\theoremstyle` calls | interactapasample.tex:23-35 | yes | `thm.amsthm` declarations |
| `tfapastyle.sty` (apacite 6.03 renamed; probably edited by T&F, e.g. the empty `APACrefURL` environment with a comment absent from apacite.dtx, tfapastyle.sty:1337; not diffed) | tfapastyle.sty:46 | yes, not loaded by the sample | publisher-released apacite derivative: `bib.apacite`; options `natbibapa` (:93-100) |
| `tfapacite.bst` (T&F derived work of apacite.bst, marked at tfapacite.bst:5-7) | tfapacite.bst:1-20 | yes, not loaded by the sample | `bib.bibtex-bst`, the style file is the parameter |
| bundled booktabs, epsfig, natbib, rotating, subfig | booktabs.sty:34; epsfig.sty:17; natbib.sty:29; rotating.sty:16; subfig.sty:65 | not bespoke | CTAN packages copied for convenience; no T&F marker found by grep; not diffed against CTAN |
| `apacite.dtx`, `apacite.ins` | apacite.dtx:59; apacite.ins:5 | not bespoke | CTAN apacite 6.03 source shipped because its licence requires it; not loaded |
| sample body and preamble macros | interactapasample.tex | none | no `\newcommand`, `\def` or environment outside verbatim text |

## Content-opaque
- `graph1.eps`, `graph2.eps` figure artwork inside the figure (interactapasample.tex:215-217, 226-228); EPS conversion by `epstopdf` is the judgement call in the Verdict.
- Table cell text, equations (:338-368), the 30 typed `\bibitem` entries (:440-564) and `interactapasample.bib` (60 entries, custom fields such as `arttype`, `podcasttitle`, `director`), used only by the commented-out BibTeX route.
- Optional lines left commented out and not loaded: `endfloat` (:8, considered: endfloat), `setspace` with `\setlength\parindent{24pt}` (:9-10), the `tfapastyle` block (:16-18).

## Lib changes
- New ways proposed: none (considered: epstopdf, kept under `fig.graphicx` as a graphics-inclusion helper; considered: endfloat, not loaded)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
