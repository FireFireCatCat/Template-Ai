yes

# 0180-simple-thesis-dissertation: simple-thesis-dissertation (Ph.D. thesis template, XeLaTeX)

- Unverified: read from the source, not compiled.
- Source: Source/0180-simple-thesis-dissertation/ (origin: https://mirrors.ctan.org/macros/xetex/latex/simple-thesis-dissertation.zip; licence: public domain, Unlicense, LICENSE:1; bundled fonts keep their own licence files in Fonts/)
- Kind: thesis
- Lib: v3
- Engine: needs XeLaTeX (`fontspec` loads TTF files by path, cls:72-110; `xunicode` and `xltxtra`, cls:74-75; Thesis.tex:1 and README.md:3)
- Look carried by: mixed (the class defines headings, fonts, captions, theorem styles, page styles, lists, colour: simplethesisdissertation.cls; the sample's Thesis-FrontMatter.tex hand-lays the title, copyright, dedication and abstract pages)
- Class origin: ctan (ctan.org/pkg/simple-thesis-dissertation exists, path /macros/xetex/latex/simple-thesis-dissertation, in TeX Live; the zip is the CTAN archive itself)
- Main file: Thesis.tex (other samples: none; it `\input`s Thesis-FrontMatter.tex, Thesis-Chapter-Intro.tex, Thesis-Chapter-ChapAbbr.tex, Thesis-Chapter-Summary.tex, Thesis-BackMatter.tex)
- Read: main yes (all six .tex files, whole), zip-local classes and styles all (simplethesisdissertation.cls, 633 lines, whole). Not read: Thesis.pdf (compiled sample), Thesis.bib entries (content), the font files.

## Verdict
yes. The class is a CTAN-published class (W1), so `class.simplethesisdissertation` is a way, and the sample's own preamble adds only PDF metadata, one colour (same value as the class) and maths macros. Independently of that, every piece the class defines was decomposed below and each reduces to lib ways with parameters (headings to `titlesec`, captions to `caption`, page styles to `fancyhdr`, lists to `enumitem`, theorem heads to `amsthm`); the one unhomed package, `arydshln`, is proposed as `tbl.arydshln`. No artwork is drawn by the template (the title-page logo slot is an included PDF, which is content), no external tool is needed (BibTeX with `IEEEtran.bst` only), and no irreducible code was found. Nothing was compiled, so this is a reading of the source, not a check of the output.

## Blockers
none

Recorded, not blockers:
- Engine: XeLaTeX only (Thesis.tex:1; simplethesisdissertation.cls:72-75). Flouest's engine is pdfTeX.
- Assets the zip does not ship: `IEEEfull.bib` named at Thesis-BackMatter.tex:11 (presumably from the IEEEtran bundle, not checked), the `bbold` math font and its `ubbold.fd` named at simplethesisdissertation.cls:458 (the class comment at cls:457 says to install `bbold-type1`). The text fonts are shipped (Fonts/tinos, Fonts/carlito, Fonts/mplus).
- Class option `draftmode` (Thesis.tex:15) switches on a red `DRAFT` plus compile-time timestamp footer on every page (cls:279-283, 446), so the sample's PDF carries the build date. The emitter resolves the option statically.

## Class setting
- Class: `class.simplethesisdissertation` options: `letterpaper` (passes to `report`, cls:18), `nonstopmode` (`\nonstopmode`, a compile-time switch with no printed effect, cls:21), `draftmode` (sets `\TypesetInDraftMode` to 1, cls:25); `a4paper` also exists (cls:17). The class loads `class.report` with `12pt,oneside` (cls:30).
- Class-native vocabulary used: `\BlankFootnote` (ChapAbbr.tex:4), `\DisableTOCUpdates` / `\EnableTOCUpdates` (ChapAbbr.tex:352, 405), `\qedmarker` (ChapAbbr.tex:359, 401), coloured reference aliases `\Section` `\sref`, `\Figure` `\Figures` `\fref`, `\Table` `\tref`, `\Theorem` `\Lemma` `\mref` (ChapAbbr.tex:24, 54, 73, 102, 301, 314), `\CaptionFontSize` (ChapAbbr.tex:45), theorem environments `Thm:Definition` `Thm:Proposition` `Thm:Conjecture` `Thm:Lemma` `Thm:Theorem` `Thm:Corollary` (ChapAbbr.tex:262-319), `\one[...]` indicator (ChapAbbr.tex:253), `\lipsum` (kept only under `draftmode`, cls:628-630), `\XeLaTeX` (from `xltxtra`, Intro.tex:5). Defined by the sample, not the class: `\DocumentTitle`, `\AuthorName` (Thesis.tex:24-25).

## Component map
Rows give the way an emitter could print for each piece. Where the class implements a piece by redefining kernel internals, the way is the lib way it reduces to, and Parameters says "reduces from cls:N".

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | Thesis.tex:15; cls:30 | `class.simplethesisdissertation`, base `class.report` | options letterpaper, nonstopmode, draftmode; base 12pt, oneside |
| paper size | Thesis.tex:15; cls:17-18 | `page.class-options` | letterpaper |
| page geometry | cls:34-41 | `page.geometry` | left=25.4mm, right=25.4mm, top=20mm, bottom=16mm, headsep=6mm, footskip=6mm |
| language | cls:48 | `lang.babel` | english |
| text fonts | cls:72-73, 79-110 | `font.fontspec` | `\defaultfontfeatures{Mapping=tex-text}`; main and roman Tinos (Path=./Fonts/tinos/, Italic/Bold/BoldItalic files, Scale=1.00), sans Carlito (Scale=0.95), mono M+ 1m (BoldFont=mplus-1m-bold, Scale=0.95) |
| XeTeX companion packages | cls:74-76, 113-114; Intro.tex:5 | `font.fontenc-t1` (`xunicode`, `textcomp`, `underscore`: text-glyph and encoding layer), `font.icons` (`xltxtra`, prints `\XeLaTeX`), `font.lmodern` | load-only, no options; `underscore` makes `_` print in text |
| math blackboard-bold alphabet | cls:458-460; ChapAbbr.tex:253 | `font.nfss` | `\DeclareSymbolFont{bbold}{U}{bbold}{m}{n}`, `\DeclareSymbolFontAlphabet{\mathbbold}{bbold}`; `\one[#1]` = `\mathbbold{1}\left[#1\right]` |
| colour | cls:65-66; Thesis.tex:46 | `color.color` | `usenames`; `\definecolor{AccentOne}{RGB}{0,68,186}` (repeated in the sample) |
| red placeholder text | Intro.tex:3; FrontMatter.tex:97, 112 | `color.color` | `\color{red}` |
| PDF metadata and links | cls:59; Thesis.tex:28-43 | `meta.hyperref` | pdftitle, pdfauthor, pdfsubject, pdfcreator, unicode, bookmarks, bookmarksopen, bookmarksnumbered, pdfstartview=FitH, pdfpagelayout=OneColumn, pdfpagemode=UseOutlines, hidelinks, breaklinks |
| url and href | Intro.tex:9-10 | `meta.url` | `\href{..}{\url{..}}` (`\url` from hyperref) |
| PDF anchor | BackMatter.tex:6 | `meta.hyperref` | `\phantomsection` |
| line spacing | cls:256-258; FrontMatter.tex:13, 62, 81 | `sp.setspace` | `\onehalfspacing` default; `\setstretch{1.0}` inside front-matter groups |
| first paragraph indent | cls:265 | `sp.indentfirst` | reduces from `\let\@afterindentfalse\@afterindenttrue`, which is the package's own code |
| unbreakable and hanging blocks | cls:268-269, 386-388 (not used in the sample) | `sp.lengths` | `\hangindent`, `\hangafter` set per paragraph, wrapped in `\newcommand` (`\IndentBlock`, `\IndentHanging`, `\DefineItem`) |
| math line-break control | cls:466, 469-471 | `math.amsmath`, `sp.penalties`, `sp.hyphenat` | `\allowdisplaybreaks`; `\relpenalty=10000`, `\binoppenalty=10000`; `\sloppy` |
| part and chapter headings | cls:121-165 | `head.titlesec` | `[explicit]`; part: spacing {0em}{8em}{4em}[0em], display, `\sffamily\bfseries\filcenter`, label 16/19.2 `AccentOne` `PART~\thepart`, title 32/38.4; chapter: spacing {0em}{5em}{2em}[0em], display, `\sffamily\bfseries\raggedright`, label 17.5/21 `AccentOne` `CHAPTER~\thechapter`, title 30/36; numberless variants with an empty label (cls:137-143, 159-165) |
| section to subparagraph headings | cls:167-217 | `head.titlesec` | section hang 17/20.4, subsection hang 14.5/17.4, subsubsection hang 13/15.6, all `\sffamily\bfseries\raggedright`, number in `AccentOne`, label gap 0.5em; paragraph runin `\sffamily\bfseries`, text `#1.`, spacing {\parindent}{\parskip}{0.5em}; subparagraph runin `\sffamily\bfseries\itshape`, spacing {2\parindent}{\parskip}{0.5em} |
| numbering depth | cls:220, 599 | `num.secnumdepth` | secnumdepth=10, tocdepth=10 |
| page styles | cls:276-299; FrontMatter.tex:9, 57 | `hf.fancyhdr` | reduces from cls:286-299 (`\def\ps@empty`, `\def\ps@plain` over `\@oddhead` `\@oddfoot`); header = centred `\thepage` in `\footnotesize\sffamily`, no rule; footer empty, or in draft mode `\null\hfill\color{red}DRAFT~\Timestamp\hfill\null`; `empty` style (title page) has no head and the same footer; sample then uses `hf.pagestyle-kernel` `\thispagestyle{empty}` and `\pagestyle{plain}` |
| draft timestamp | cls:443, 446, 282 | `front.datetime` | `datetime2`, `\DTMnow` |
| page numbering | FrontMatter.tex:2, 58, 136 | `pgnum.pagenumbering` | roman for front matter, `\setcounter{page}{2}`, then arabic |
| page breaks | FrontMatter.tex:51, 73, 88, 103, 121, 133; BackMatter.tex:5 | `pg.break` | `\clearpage` |
| title page | FrontMatter.tex:9-49 | `front.titlepage-env`, with `sp.ragged`, `sp.manual-space`, `font.size-commands`, `fig.graphicx` | `\begingroup\centering` .. `\endgroup`, `\\[1em]`, `\\[0.4in]`, `\vfill`; title `\sffamily\bfseries\fontsize{26}{31.2}`; `\includegraphics[height=1.8in]` of a PDF logo slot (content) |
| copyright and dedication pages | FrontMatter.tex:60-71, 79-86 | `front.dedication` | centred group, `\vfill`, `\textcopyright` (textcomp), `\textit` |
| acknowledgments and abstract | FrontMatter.tex:94-101, 109-119 | `head.titlesec` (numberless chapter), `toc.kernel`, `front.dedication` | `\chapter*{...}` plus `\addcontentsline{toc}{chapter}{...}`; there is no `abstract` environment |
| contents and lists | FrontMatter.tex:127-131; BackMatter.tex:7 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables`, `\addcontentsline{toc}{chapter}{Bibliography}` |
| ToC entry suppression | cls:602-609; ChapAbbr.tex:352, 405 | `toc.kernel` | reduces from `\let\addcontentsline` swap; for the entries the sample hides (subsections) `\addtocontents{toc}{\protect\setcounter{tocdepth}{1}}` and back to 10, with `num.secnumdepth` |
| chapter footnote without mark | cls:335-341; ChapAbbr.tex:4 | `fn.kernel`, `num.counters` | `\renewcommand{\thefootnote}{}`, `\footnotetext`, `\addtocounter{footnote}{-1}`, `\addtocounter{Hfootnote}{-1}` |
| enumerate labels | cls:352-365; ChapAbbr.tex:162-191 | `list.kernel`, `num.counters` | `1)` `a)` `i)` `A)` by `\theenumN` and `\labelenumN`, `\p@enumii..iv` emptied |
| list spacing | cls:368-383 | `list.enumitem` | reduces from `\renewcommand{\enumerate}` / `\itemize` wrappers: `\setlist{itemsep=0pt,parsep=0pt,parskip=0pt}` (the same values by `sp.lengths`) |
| itemize | ChapAbbr.tex:198-225 | `list.kernel` | four levels |
| figures | ChapAbbr.tex:44-51 | `fig.graphicx` | `figure`, `\centering\CaptionFontSize`, `\includegraphics[height=15em]`, `\caption[short]{long}`, `\label` |
| rotated figure | cls:51; ChapAbbr.tex:59-70 | `fig.rotating` | `sidewaysfigure*` |
| tables | cls:394-398, 401; ChapAbbr.tex:79-99, 107-147 | `tbl.tabular`, `tbl.booktabs` | `\arraystretch` 1.25; `c@{\hspace{1em}}l`, `\toprule` `\midrule` `\bottomrule`; caption above the body |
| packages loaded, not used by the sample | cls:395-396 | `tbl.longtable`, `tbl.multirow` | load-only |
| dashed table rules | cls:404-406 | `tbl.arydshln` | `arydshln`; `\dashvertical` = `;{2pt/3pt}`, `\dashhorizontal` = `\hdashline[2pt/3pt]`; not used by the sample |
| captions | cls:409-427 | `cap.caption`, `font.size-commands` | reduces from the `\@makecaption` redefinition: font=small; label = `AccentOne` sans bold, uppercased by a label format; label gap `\hspace{0.5em}`; text on one line is centred, otherwise a justified paragraph (singlelinecheck on); `skip=1em` between caption and body (figure caption below its image, table caption above its table) |
| theorem styles and names | cls:474-492, 496-509; ChapAbbr.tex:262-319 | `thm.amsthm` | `\newtheoremstyle{MyPlain}` {0.4em}{0.4em}{\itshape}{}{}{}{0.5em} with head spec `\sffamily\bfseries\color{AccentOne}\MakeUppercase{\thmname{#1}\thmnumber{ #2}}\thmnote{ (#3)}`; `MyDefinition` the same with upright body; `Thm:Theorem` numbered within chapter, Lemma, Corollary, Claim, Proposition, Conjecture share its counter (plain), Problem, Definition, Example share it (definition) |
| proof environment | cls:537-544; ChapAbbr.tex:378-381, 359 | `thm.amsthm` | reduces from `\renewenvironment{proof}`: header `\sffamily\bfseries\itshape{#1:}`, 0.4em above, end marker a black `\rule{1.3ex}{1.3ex}` set flush right (`sp.rule`, `sp.manual-space`, `pg.break` for `\nopagebreak`); `\qedmarker` is the same marker as a command |
| display maths | ChapAbbr.tex:246-248, 251-257, 308-310, 388-398 | `math.kernel`, `math.amsmath`, `math.amssymb`, `math.bm` | `\[ \]`, `align`, `align*`, `\notag`, `\eqref`, `\text`, `\mathbb`; class loads `amsmath amsfonts amsbsy amssymb amsthm` (cls:452) |
| maths macros | Thesis.tex:49-57 | `math.amsmath` | `\DeclareMathOperator*` (argmax, argmin), `\DeclareMathOperator` (lcm), `\renewcommand{\binom}` with `\genfrac`, `\ceil` `\floor` by `\left\lceil` `\left\lfloor`, `\ZZ` |
| coloured cross-reference aliases | cls:237-249, 430-437, 512-530 | `xref.kernel`, `color.color` | `\newcommand{\sref}[1]{{\color{AccentOne}\ref{#1}}}` and the word aliases (`\Figure`, `\Table`, `\Lemma`...) |
| citations | cls:49; ChapAbbr.tex:18, 158, 235, 301 | `bib.cite-pkg` | `cite` sorts and ranges numbers; `\cite[Theorem~2.5]{..}` |
| bibliography | BackMatter.tex:9-11 | `bib.bibtex-bst` | `IEEEtran.bst`; databases `IEEEfull` (not shipped) and `Thesis.bib` |
| framed text and algorithms | cls:52, 568-592 (not used by the sample) | `box.mdframed`, `alg.algorithmicx`, `box.minipage`, `sp.rule`, `mark.kernel` | `framed`; `algpseudocode` with `\algnewcommand`; see Bespoke code |
| TODO marker and hidden text | cls:616-623 (not used by the sample) | `draft.todo`, `box.fancybox`, `color.color` | `\fbox{\texttt{\textbf{TODO}}}` in red under draftmode, empty otherwise |
| filler text | cls:626-630; FrontMatter.tex:101, 119 | `draft.todo` | `lipsum`; `\lipsum[1-2]`; emptied unless draftmode |
| inline boxes and verbatim | ChapAbbr.tex:17, 340-348 | `box.minipage`, `code.verbatim`, `mark.kernel` | `\mbox{\textit{...}}`; `\verb|\DisableTOCUpdates|` |
| appendix, index, glossary | none in the sample | none | not used |

## Bespoke code
The class is published (CTAN), so its macros are class-native vocabulary, not zip-local. They are listed anyway because the scope includes everything the class loads; each is reducible.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\ps@empty`, `\ps@plain` (kernel page-style hooks) | cls:286-299 | yes (BESPOKE/class, published) | `hf.fancyhdr` `\fancyhf{}`, centred `\thepage` in the head, footer text, `\headrulewidth=0pt`, for styles `plain` and `empty` |
| `\TypesetInDraftMode` switch and `\ifnum` branches | cls:24-25, 279-283, 619-630 | yes | one boolean class option, resolved at emit time: the sample's `draftmode` picks the red footer, live `\TODO`, kept `\lipsum` |
| `\@makecaption` | cls:411-427 | yes | `cap.caption` options as in the component map |
| `\let\@afterindentfalse\@afterindenttrue` | cls:265 | yes | `sp.indentfirst` |
| `\renewcommand{\enumerate}`, `{\itemize}` | cls:368-383 | yes | `list.enumitem` `\setlist` zero item and paragraph separation |
| `\BlankFootnote` | cls:335-341 | yes | `fn.kernel` + counter commands |
| `\DisableTOCUpdates`, `\EnableTOCUpdates`, `\DummyThree` | cls:602-609 | yes for the sample's use | `\addtocontents{toc}{\protect\setcounter{tocdepth}{N}}`; the general form (hide every entry type) is class vocabulary |
| `\renewenvironment{proof}`, `\qedmarker` | cls:537-544 | yes | composition of `mark.kernel`, `sp.manual-space`, `sp.rule`, `pg.break` |
| `\NewEnviron{ResizedAlign}`, `{ResizedAlign*}` | cls:547-562 | yes (not used) | body wrapper `\resizebox{w}{!}{\parbox{p}{\begin{align}..\end{align}}}`: `fig.graphicx`, `box.minipage`, `math.amsmath`; `\NewEnviron` only packages it |
| `\NewEnviron{CodeBlock}` | cls:580-592 | yes (not used) | `box.mdframed` (`oframed`) around a title, `\hrule` (`sp.rule`) and `algorithmic`; `\NewEnviron` only packages it |
| `\algnewcommand` keywords `\CommentLeft` `\CommentRight` `\Goto` `\Break` `\Stateu` | cls:570-574 | yes (not used) | `alg.algorithmicx` extension commands over `\State`, `\Statex`, `\textbf`, `\textit`; `\Stateu` reads the internal `\ALG@thistlm` indent |
| `\code` | cls:577 | yes (not used) | `\mbox{\color{..}\texttt{#1}}`; colour `DarkBlue` is never defined in the class or sample, so a call would fail |
| `\TODO`, `\Hide` | cls:616-623 | yes (not used) | aliases over `\fbox`, `\color`, `\texttt` and a no-op; `\PackageWarning` writes the log only |
| section-name capture `\Chaptername` ... `\Subsubsectionname` | cls:222-234 | yes | read only inside an `\iffalse` block (cls:301-328): no printed effect |
| coloured word and reference aliases | cls:237-249, 430-437, 512-530 | yes | `\newcommand` aliases of `\ref` and coloured words |
| `\newtheoremstyle` and `\newtheorem` set | cls:474-509 | yes | `thm.amsthm`; `\@ifundefined{chapter}` is resolved statically (the base is `report`, so `[chapter]`) |
| `\DeclareSymbolFont` / `\DeclareSymbolFontAlphabet` for `bbold`, `\one` | cls:458-460 | yes | `font.nfss` math symbol font declaration, alias over `\mathbbold` |
| `\DocumentTitle`, `\AuthorName` | Thesis.tex:24-25 | yes | text macros used by the title page and `pdftitle`/`pdfauthor` |
| `\DeclareMathOperator`, `\binom`, `\ceil`, `\floor`, `\ZZ` | Thesis.tex:49-57 | yes | `math.amsmath` and `\newcommand` aliases (commented lines 53-54 are inactive) |

## Content-opaque
- Included PDF `Figures/Figure-SampleVectorGraphic` on the title page and in both figures (FrontMatter.tex:38-39; ChapAbbr.tex:46-47, 61-62); its `.odg` source is shipped beside it.
- Equations, table cells, lorem ipsum, red placeholder text, `Thesis.bib` entries (Thesis.bib:1-134).

## Lib changes
- New ways proposed: `tbl.arydshln` `arydshln` (CTAN), engine pdf: dashed rules in `array`/`tabular`, loaded unconditionally by the class (cls:404-406). W1 published on CTAN; W2 dash and gap lengths (`\hdashline[2pt/3pt]`, column separator `;{2pt/3pt}`, `\cdashline{a-b}`) and no code edits; W3 serves any table; W4 one package line plus rule wrappers and a column-spec token. Not folded into `tbl.tabular` because rule packages have their own lines (`tbl.booktabs`, `tbl.colortbl`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- considered: `underscore`, `xunicode`, `xltxtra` (not proposed; placed in `font.fontenc-t1` and `font.icons`, whose lines already cover encoding, glyph-access packages and TeX-system logos), `environ` (a definition mechanism for the unused `ResizedAlign` and `CodeBlock`, whose bodies reduce as written above).
