yes

# 0399-arabdoc: arabdoc, one-line Arabic RTL setup for XeLaTeX

- Unverified: read from the source, not compiled.
- Source: Source/0399-arabdoc/ (origin: https://mirrors.ctan.org/macros/xetex/latex/arabdoc.zip; licence: LPPL 1.3c)
- Kind: misc (a package manual for four Arabic classes; the `thesis` hint in the manifest comes from `arabdoc-thesis`, which the sample does not use)
- Lib: v4
- Engine: needs XeLaTeX (`fontspec` doc/arabdoc-doc.tex:13, `polyglossia` :14, `bidi` :12; tex/arabdoc-setup.sty:83,89,112; README.md:89)
- Look carried by: mixed (the sample's own preamble restates the setup stack by hand, doc/arabdoc-doc.tex:5-34; the look the package offers is in tex/arabdoc-setup.sty and the four tex/arabdoc-*.cls files, none of which the sample loads)
- Class origin: ctan (the zip is the CTAN bundle `arabdoc`, read at ctan.org/pkg/arabdoc: v1.0.0, LPPL 1.3c; the sample's own class `ltxdoc` is LaTeX base, tex-distribution-unbundled)
- Main file: doc/arabdoc-doc.tex (other samples: none; README.md:32-41, 45-51 and 55-69 show three short snippets, not full templates)
- Read: main yes, zip-local classes and styles all (arabdoc-setup.sty, -article.cls, -report.cls, -book.cls, -thesis.cls, -glossary.sty, -bib.sty: 7 files, each read in full)

## Verdict
Every file in the zip reduces to published packages and kernel commands: the sample is `ltxdoc` plus a preamble of CTAN packages, and each `tex/` file is `\LoadClass` or `\RequirePackage` of published packages with option values, a few string-setting `\newcommand`s and one hand-laid title page. The conditionals in `arabdoc-setup.sty` only pick between fixed option branches, so an emitter that knows the options writes the chosen branch directly; none computes layout. No artwork, no external tool beyond the usual biber and makeindex passes, no unmapped component. Not tested: the sty loads `hyperref` after `bidi` (arabdoc-setup.sty:83,136) while the README quotes the error that this order gives (README.md:22-24); I did not compile, so I cannot say which TeX Live versions accept it.

## Blockers
none

## Class setting
- Class: `class.ltxdoc` options: `11pt,a4paper` (doc/arabdoc-doc.tex:3). The zip's own classes are `class.arabdoc-article`, `class.arabdoc-report`, `class.arabdoc-book`, `class.arabdoc-thesis` (published on CTAN, so plain class ways); each loads `class.article`, `class.report`, `class.book`, `class.book` (tex/arabdoc-article.cls:46, tex/arabdoc-report.cls:31, tex/arabdoc-book.cls:44, tex/arabdoc-thesis.cls:38), options `12pt,a4paper,openright` fixed for the thesis.
- Class-native vocabulary used: the sample uses only kernel article vocabulary (`\maketitle`, `abstract`, `\tableofcontents`, `\section`, `quote`, `itemize`) and none of `ltxdoc`'s `doc` commands (`macrocode`, `\DescribeMacro`, `\DocInput` do not occur). The arabdoc classes' own vocabulary, recorded for the class lines: options `amiri` `scheherazade` `lateef` `custom` `maghrib` `arabicdigits` `gregorian` `islamic` `captions` `colorlinks` `legal-sections` `default-sections` forwarded to `arabdoc-setup` (tex/arabdoc-article.cls:27-38); anything else goes to the base class (:24); thesis only: `\university` `\college` `\department` `\supervisor` `\degree` `\subject` (tex/arabdoc-thesis.cls:55-60), redefined `\maketitle` `\frontmatter` `\mainmatter`, own `abstract` environment.

## Component map
Group A: the sample, doc/arabdoc-doc.tex.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | doc/arabdoc-doc.tex:3 | `class.ltxdoc` | 11pt, a4paper |
| page geometry | doc/arabdoc-doc.tex:5 | `page.geometry` | a4paper, margin=2.5cm, headheight=15pt |
| tables, rules, long tables | doc/arabdoc-doc.tex:6, 59-68, 108-127 | `tbl.tabular` `tbl.booktabs` `tbl.tabularx` `tbl.longtable` | `longtable` `lll` and `ll`, `\toprule` `\midrule` `\bottomrule`; `tabularx` loaded, unused |
| lists | doc/arabdoc-doc.tex:7, 244-249 | `list.kernel` `list.enumitem` | `itemize`; `enumitem` loaded with no `\setlist` in the sample |
| section headings | doc/arabdoc-doc.tex:8, 27 | `head.titlesec` | `\titleformat{\section}{\large\bfseries}{\thesection}{0.7em}{}` |
| running head and foot | doc/arabdoc-doc.tex:9, 28-32 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, head R `\small\itshape` + `\textenglish{arabdoc v1.0.0}`, foot C `\small\thepage`, `\headrulewidth`=0.3pt |
| line spacing | doc/arabdoc-doc.tex:10, 34 | `sp.setspace` | `\setstretch{1.4}` |
| colour, table colour | doc/arabdoc-doc.tex:11, 36 | `color.xcolor` `tbl.colortbl` | option `table`; `\textcolor{blue}{...}` |
| bidirectional text | doc/arabdoc-doc.tex:12, 118, 219 | `lang.bidi` | `\RL{}` and `\LR{}` spans |
| fonts | doc/arabdoc-doc.tex:13, 16-19 | `font.fontspec` | `no-math`; `\setmainfont[Scale=1]{Amiri-Regular.ttf}`; `\newfontfamily\arabicfont[Script=Arabic,Scale=0.95]`; `\newfontfamily\englishfont[Scale=0.95]{TeX Gyre Termes}`; `\setmonofont{Amiri-Regular.ttf}` |
| language | doc/arabdoc-doc.tex:14, 21-22, 30, 42, 80 | `lang.polyglossia` | `quiet`; `\setdefaultlanguage[calendar=gregorian,hijricorrection=1]{arabic}`; `\setotherlanguage[variant=british]{english}`; `\textenglish{}`, `english` environment |
| hyperlinks and metadata | doc/arabdoc-doc.tex:24-25 | `meta.hyperref` | breaklinks, colorlinks, linkcolor=blue, urlcolor=blue; pdftitle, pdfauthor |
| title block | doc/arabdoc-doc.tex:39-42, 46 | `front.maketitle` `sp.manual-space` `font.size-commands` | `\\[0.3em]`, `\large`, `\texttt`, `\quad` |
| abstract | doc/arabdoc-doc.tex:48-51 | `abs.kernel` | `abstract` environment, `\noindent` |
| contents | doc/arabdoc-doc.tex:53 | `toc.kernel` | `\tableofcontents` |
| quotes | doc/arabdoc-doc.tex:74-76, 102-104 | `quote.kernel` | `quote` |
| verbatim code | doc/arabdoc-doc.tex:80-94, 211-217, 227-232 | `code.verbatim` | `verbatim` inside `english` |
| inline marks | doc/arabdoc-doc.tex:36-37, 50 | `mark.kernel` | `\texttt`, `\textbf`, `\itshape`; `\cmd` and `\pkg` are aliases (see Bespoke code) |

Group B: the shared stack, tex/arabdoc-setup.sty (loaded by all four classes).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| table and float packages | tex/arabdoc-setup.sty:69-73, 77 | `tbl.tabular` `tbl.booktabs` `tbl.tabularx` `fig.float` `color.xcolor` `tbl.colortbl` | `array`, `booktabs`, `tabularx`, `float`, `xcolor[table]`; `float` has no use in any file here |
| bidi | tex/arabdoc-setup.sty:83 | `lang.bidi` | loaded before `fontspec` and `polyglossia` |
| fonts | tex/arabdoc-setup.sty:89-106 | `font.fontspec` | `no-math`; font file by option: `Amiri-Regular.ttf` (default), `ScheherazadeNew-Regular.ttf`, `Lateef-Regular.ttf`, or none (`custom`); `Script=Arabic,Scale=0.95` for `\arabicfont`; `TeX Gyre Termes` Scale=0.95 for `\englishfont`; `\setmonofont{Amiri-Regular.ttf}` |
| language, numerals, calendar | tex/arabdoc-setup.sty:112-129 | `lang.polyglossia` | `quiet`; `\setdefaultlanguage[calendar=gregorian or islamic,hijricorrection=1,numerals=maghrib or arabicdigits]{arabic}`; `\setotherlanguage[variant=british]{english}` |
| hyperlinks | tex/arabdoc-setup.sty:135-139 | `meta.hyperref` | `breaklinks,hidelinks`, or `breaklinks,colorlinks,linkcolor=blue,urlcolor=blue` with option `colorlinks` |
| Arabic caption names | tex/arabdoc-setup.sty:145-158 | `lang.polyglossia` | `\addto\captionsarabic{\renewcommand{\contentsname}{...}...}` for 11 names: contents, figure, table, ref, abstract, appendix, index, chapter, part, list of figures, list of tables |
| section headings | tex/arabdoc-setup.sty:165-173 | `head.titlesec` | `\titleformat` section `\Large\bfseries` (or `\large\bfseries` with label `المادة \thesection` under `legal-sections`) 0.7em; subsection `\large\bfseries` 0.6em; subsubsection `\normalsize\bfseries` 0.5em; `\titlespacing*` section `0pt`, `1.4ex plus 0.4ex`, `0.9ex plus 0.3ex`; subsection `0pt`, `1.0ex plus 0.3ex`, `0.7ex plus 0.2ex` |
| table column types | tex/arabdoc-setup.sty:179-181 | `tbl.tabular` | three column types L, C, R, each `\newcolumntype{X}[1]{>{\raggedright, \centering or \raggedleft, then \arraybackslash}p{#1}}` |
| line spacing | tex/arabdoc-setup.sty:187 | `sp.setspace` | `\setstretch{1.5}` |
| list spacing | tex/arabdoc-setup.sty:188-189 | `list.enumitem` | `\setlist[itemize]` and `[enumerate]`: topsep=0.3em, itemsep=0.15em, parsep=0pt |
| header and footer package | tex/arabdoc-setup.sty:75 | `hf.fancyhdr` | loaded here, set up in each class |

Group C: the classes.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| article, report, book: base class, page size | tex/arabdoc-article.cls:46, 58; tex/arabdoc-report.cls:31, 35; tex/arabdoc-book.cls:44, 56 | `class.article` `class.report` `class.book` `page.geometry` | class options passed through (`PassOptionsToClass`); geometry a4paper, margin=2.5cm, top=2.5cm, bottom=2.5cm, headheight=15pt |
| article, report: header and footer | tex/arabdoc-article.cls:64-70; tex/arabdoc-report.cls:37-43 | `hf.fancyhdr` | `\fancyhf{}`; head R `\small\itshape \@title`; head L `\small \@author`; foot C `\small\thepage`; headrule 0.3pt, footrule 0pt |
| book, thesis: header and footer | tex/arabdoc-book.cls:62-68; tex/arabdoc-thesis.cls:104-110 | `hf.fancyhdr` | head RE `\small\nouppercase{\leftmark}`; head LO `\small\nouppercase{\rightmark}`; foot C `\small\thepage`; headrule 0.3pt, footrule 0pt |
| thesis: base class, page | tex/arabdoc-thesis.cls:38, 42 | `class.book` `page.class-options` `page.geometry` | `12pt,a4paper,openright`; geometry a4paper, margin=3cm, top=3cm, bottom=3cm, headheight=15pt |
| thesis: title page | tex/arabdoc-thesis.cls:66-98 | `front.titlepage-env` `front.class-native` `font.size-commands` `sp.manual-space` `box.minipage` `sp.ragged` | `titlepage`, `\centering`, `\vspace*{2cm}`, `\\[2cm]`/`[0.5em]`/`[0.3em]`/`[1cm]`, two `minipage` of 0.45`\textwidth` with `flushleft` and `flushright`, sizes `\Large` `\large` `\LARGE\bfseries`; fixed Arabic wording; fields `\@university` `\@college` `\@department` `\@title` `\@degree` `\@subject` `\@author` `\@supervisor` `\@date` |
| thesis: matter switches | tex/arabdoc-thesis.cls:116-126 | `pg.break` `pgnum.pagenumbering` | `\cleardoublepage`, `\pagenumbering{roman}` then `{arabic}`; same text as the book class's own `\frontmatter` and `\mainmatter` (recalled, book.cls not opened) |
| thesis: abstract | tex/arabdoc-thesis.cls:132-143 | `abs.class-native` `abs.keywords` `hf.pagestyle-kernel` `pg.break` | own `abstract` environment: `\cleardoublepage`, `\thispagestyle{plain}`, centred `\Large\bfseries` heading `الملخص`, `\vspace{1em}`; at the end `\textbf{الكلمات المفتاحية:}` with no value, `\cleardoublepage` |

Group D: the two add-on styles (neither loaded by the sample; the README loads both beside the article class, README.md:55-69).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| glossary and acronyms | tex/arabdoc-glossary.sty:23, 29-30 | `idx.glossaries` | `glossaries[acronym,toc]`; `\acronymname`=الاختصارات, `\glossaryname`=المصطلحات |
| glossary entry wrappers | tex/arabdoc-glossary.sty:40-42, 52-57, 65-70 | `idx.glossaries` `lang.bidi` `lang.polyglossia` | `\newarabicacronym` is `\newacronym{k}{\LR{abbr}}{\textarabic{ar} - \LR{en}}`; `\newarabicterm` is `\newglossaryentry{k}{name=\LR{en},description={ar}}`; `\newbilingualterm` is `\newglossaryentry{k}{name={en \LR{(ar)}},description={..}}` |
| bibliography | tex/arabdoc-bib.sty:26 | `bib.biblatex-biber` | `biblatex[backend=biber,sorting=none,style=numeric]` |
| bibliography heading | tex/arabdoc-bib.sty:34-42 | `bib.biblatex-biber` | `\defbibheading{arabicbib}{\section*{المراجع}}`, title replaceable by `\arabdocbibtitle` |
| bibliography list | tex/arabdoc-bib.sty:48-62 | `bib.biblatex-biber` `list.kernel` `sp.lengths` | `\defbibenvironment{arabicbibliography}`: kernel `\list` with `\leftmargin` and `\rightmargin` both `\bibhang`, `\itemindent`=`-\leftmargin`, `\itemsep`=`\bibitemsep`, `\parsep`=`\bibparsep`; selected by `\AtBeginBibliography{\setbibenvironment{...}}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option parsing and `\pdfstrcmp` branches (font, numerals, calendar, sections, captions, colorlinks) | tex/arabdoc-setup.sty:27-56, 62-63, 92-103, 115-127, 135-139, 145-159, 165-169 | yes | each branch picks fixed option values known at emit time; the emitter writes the chosen branch as the rows of Group B; `pdftexcmds` only feeds the comparison and is not emitted |
| class option forwarding | tex/arabdoc-article.cls:24-40; tex/arabdoc-report.cls:14-29; tex/arabdoc-book.cls:23-38; tex/arabdoc-thesis.cls:21-36 | yes | `\documentclass[opts]{base}` with the setup options written in the preamble |
| `\@title` and `\@author` read in headers | tex/arabdoc-article.cls:66-67; tex/arabdoc-report.cls:39-40 | yes | the emitter writes the title and author strings into the `\fancyhead` fields |
| thesis field setters `\university` ... `\subject`, with Arabic placeholder defaults | tex/arabdoc-thesis.cls:48-60 | yes | string settings; the emitter inlines the values into the title page |
| thesis `\maketitle` | tex/arabdoc-thesis.cls:66-98 | yes | a `titlepage` block built from kernel constructs only (rows above); no algorithm |
| thesis `\frontmatter` and `\mainmatter` | tex/arabdoc-thesis.cls:116-126 | yes | no change from the base class as recalled; otherwise `\cleardoublepage` and `\pagenumbering` calls |
| thesis `abstract` environment | tex/arabdoc-thesis.cls:132-143 | yes | `\newenvironment` over `\cleardoublepage`, `\thispagestyle`, `center`, `\vspace`, `\textbf` |
| `\newcolumntype` L C R | tex/arabdoc-setup.sty:179-181 | yes | `array` declarative command |
| glossary wrappers `\newarabicacronym` `\newarabicterm` `\newbilingualterm` | tex/arabdoc-glossary.sty:40-42, 52-57, 65-70 | yes | expand inline into `\newacronym` and `\newglossaryentry` |
| bibliography heading and environment, `\arabdocbibtitle` | tex/arabdoc-bib.sty:34-42, 48-62 | yes | `\defbibheading`, `\defbibenvironment`, `\setbibenvironment` are biblatex's declarative commands; the title is a string |
| sample aliases `\cmd` and `\pkg` | doc/arabdoc-doc.tex:36-37 | yes | `\textcolor{blue}{\texttt{\char`\\...}}` and `\texttt{...}` written inline |

## Content-opaque
none. Cell content only: `\checkmark` in the option tables (doc/arabdoc-doc.tex:112, 117, 120); I found no loaded file that defines it, so I cannot say where it comes from. Missing assets, not blockers: `Amiri-Regular.ttf`, `ScheherazadeNew-Regular.ttf` and `Lateef-Regular.ttf` are not shipped (tex/arabdoc-setup.sty:93-100; doc/arabdoc-doc.tex:16-19) and the Arabic fonts must be installed; `TeX Gyre Termes` ships with TeX Live. The glossary and bibliography need the usual `makeglossaries` and `biber` passes (doc/arabdoc-doc.tex:234), which are the toolchains of `idx.glossaries` and `bib.biblatex-biber`.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
