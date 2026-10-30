yes

# 0242-hfut-graduate-thesis: HFUT Graduate Thesis (Hefei University of Technology)

- Unverified: read from the source, not compiled.
- Source: Source/0242-hfut-graduate-thesis/ (origin: https://latextemplates.com/downloads/hfut-graduate-thesis.zip; licence: LPPL-1.3c per manifest)
- Kind: thesis
- Lib: v3
- Engine: needs XeLaTeX (`% !TeX program = xelatex` at main.tex:2; `unicode-math` math fonts per hfutsetup.tex:17 and math.tex:49; Chinese text; `fontset` option at main.tex:9)
- Look carried by: mixed (the class `hfutthesis` carries cover, front matter, headings, page furniture, numbering and theorem look; the zip's preamble adds only published packages, a `.bst` choice and three alias macros; no `.cls`/`.sty` is in the zip)
- Class origin: tex-distribution-unbundled (`hfutthesis` is on CTAN, v1.0.4, LPPL 1.3c, in TeX Live and MiKTeX, one read of ctan.org/pkg/hfutthesis; the zip does not contain `hfutthesis.cls`)
- Main file: main.tex (other samples: none; it `\input`s hfutsetup.tex and chapters/*.tex)
- Read: main yes (main.tex, hfutsetup.tex and all ten chapters/*.tex in full), zip-local classes and styles partly (no `.cls` or `.sty` is present; `.bbx`/`.cbx` read in full; the two `.bst` files were read only as header, config block and a diff of each other, not their ~2400-line function bodies; the class source `hfutthesis.cls` was not read because it is not in the zip)

## Verdict
yes, on the rubric's ruling that a published class not bundled in the zip is one way (`class.hfutthesis`, source not read) and that a class-carried look reaches yes easily. Everything the zip adds on top is a `\hfutsetup` key list, published packages that already have lib ways (`amsthm`, `graphicx`, `booktabs`, `longtable`, `algorithm2e`, `siunitx`, `natbib`, `hyperref`), a `.bst` chosen by name, and `\newcommand` aliases that reduce to lib ways. The zip-local biblatex style files hold irreducible `\renewbibmacro*` overrides, but the sample never loads them (hfutsetup.tex:90-96 is commented out), so they are listed, not counted. A reviewer who counts unloaded alternatives would score them `BESPOKE/preamble`.

## Blockers
none (not counted, because the sample does not load them: `BESPOKE/preamble` biblatex overrides in hfutthesis-graduate.bbx:16-29,34-57, hfutthesis-numeric.bbx:17-30 and hfutthesis-inline.cbx:10-18; see Bespoke code)

## Class setting
- Class: `class.hfutthesis` options: `degree=bachelor` (main.tex:5). Options documented in comments: `degree` doctor|master|bachelor, `degree-type` academic|professional, `language` chinese|english, `fontset` windows|mac|ubuntu|fandol (main.tex:6-9).
- Class-native vocabulary used: `\hfutsetup{key=value,...}` with keys `title` `title*` `stuID` `author` `author*` `speciality` `supervisor` `math-font` (also `math-style`, `secret-level`, `secret-year`, `advisor`, `applydegree`, `school`, `phdchairman`, `phdmember` in comments) `clc` `research` `signchairman` `signmember` `signsupervisor` `ugtype` `hfuteryear` `department` `defensedate` (hfutsetup.tex:3-53), `keywords` `keywords*` (abstract.tex:3-11), `cite-style=super|inline` (citations.tex:12,27,39); `\hfutthesisversion` (hfutsetup.tex:4); `\maketitle`, `\signaturepage`, `\copyrightpage` (main.tex:32-35); `\frontmatter` `\mainmatter` `\backmatter` `\appendix` (main.tex:37,45,51,56); environments `abstract`, `abstract*` (abstract.tex:13,26), `acknowledgements` (acknowledgements.tex:3), `notation` with `notationlist{2em}` (notation.tex:3,5), `publications` (publications.tex:3); `\bicaption{zh}{en}` (floats.tex:33,70) and `\note{...}` (floats.tex:22,60); theorem environments `definition` `assumption` `example` `lemma` `remark` `corollary` `proposition` `theorem` (math.tex:83,94,98,116,124,129,138,154, with no `\newtheorem` for them in the zip); `\increment` (math.tex:16, text says the template provides it); `\bm` `\mathscr` `\upGamma` compatibility (math.tex:52-53, prose). All of this is defined in the class, whose source was not read.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:5 | `class.hfutthesis` | degree=bachelor |
| class metadata and cover data | hfutsetup.tex:3-53 | `class.hfutthesis` | title, title*, author, author*, stuID, speciality, supervisor, ugtype=论文, hfuteryear, department (bachelor keys, hfutsetup.tex:37-41); clc, research, sign* and defensedate are set too (hfutsetup.tex:23,30-33,49) |
| page geometry, spacing, colour | no setting in the zip | `class.hfutthesis` | set inside the class (source not read); nothing for the emitter to print beyond the class options |
| header/footer | no setting in the zip | `hf.class-native` | running heads set by the class (source not read) |
| Chinese text and text fonts | main.tex:2,9; expertspage.tex:12 | `lang.cjk` | XeLaTeX; `fontset` option; `\ccwd` is a ctex length (inferred from the name; class source not read) |
| math fonts | hfutsetup.tex:17,112-113; math.tex:45,49 | `font.unicode-math` | math-font=xits; `\symup`, `\symbf`, `\symbfsf`; math-style key left at its default (commented, hfutsetup.tex:16; math.tex:44 says the differential is upright, so GB-style behaviour) |
| title page (cover) | main.tex:32; hfutsetup.tex:4-10,39-41 | `front.class-native` | `\maketitle` fed by `\hfutsetup` keys |
| signature page, copyright page | main.tex:34-35; hfutsetup.tex:31-33 | `front.class-native` | `\signaturepage`, `\copyrightpage`; signchairman, signmember, signsupervisor |
| expert list page (optional, commented out) | main.tex:33; chapters/expertspage.tex:3-45 | `front.titlepage-env`, `tbl.tabular`, `font.size-commands`, `sp.manual-space`, `lang.cjk` | `titlepage`; `\fontsize{16bp}{32bp}\selectfont`; `\vskip 1.0cm`/`2.4cm`; `\renewcommand\arraystretch{1.5}`; `p{4\ccwd}`-style columns with `<{\centering}`; `\pdfbookmark` is `meta.hyperref` |
| matter switches | main.tex:37,45,51 | `front.class-native` | `\frontmatter` `\mainmatter` `\backmatter` |
| abstracts (zh and en) | abstract.tex:13-24,26-35 | `abs.class-native` | `abstract`, `abstract*`; `\noindent` at abstract.tex:27 |
| keywords | abstract.tex:3-11 | `abs.keywords` | `\hfutsetup{keywords=..., keywords*=...}` |
| acknowledgements | acknowledgements.tex:3-18; main.tex:55 | `front.class-native`, `sp.ragged` | `acknowledgements` env; `flushright` at acknowledgements.tex:12-16 |
| notation page | notation.tex:3-14 | `front.class-native` | `notation`, `notationlist{2em}`, `\item[$\displaystyle a$]`; the `nomencl` variant is commented out (notation.tex:18-27) |
| publications page | publications.tex:3-28; main.tex:54 | `front.class-native`, `list.kernel` | `publications` env with `\section` and `enumerate` |
| contents and lists | main.tex:40-42 | `toc.kernel` | `\tableofcontents` `\listoffigures` `\listoftables`; look set by the class |
| headings | intro.tex:3-13; citations.tex:3,8,10; complementary.tex:3,6 | `head.class-native` | `\chapter` to `\subparagraph`; look set by the class |
| appendix | main.tex:56-57 | `num.appendix` | `\appendix` then `\chapter` |
| lists | math.tex:11,37,62; publications.tex:7 | `list.kernel`, `num.counters` | `itemize`, `enumerate`; `\renewcommand{\theenumi}{\roman{enumi}}` (math.tex:141) |
| inline marks | math.tex:51,85 | `mark.kernel` | `\emph`, `\textbf` |
| footnotes | intro.tex:36; math.tex:7-8 | `fn.kernel` | `\footnote` |
| display maths | math.tex:13,86,102-106 | `math.amsmath` | `equation`, `equation*`, `cases`, `\text` (amsmath is presumably loaded by the class; not shown in the zip) |
| units and numbers | hfutsetup.tex:74; math.tex:63-72 | `mark.siunitx` | `\num`, `\si`, `\numlist`, `\SIlist`, `\numrange`, `\SIrange` |
| theorem-like environments | math.tex:83,94,98,116,124,129,138,154 | `thm.class-native` | eight environments defined by the class (the zip has no `\newtheorem` for them; math.tex:79 says amsthm configures them) |
| proof, extra theorems | hfutsetup.tex:59; math.tex:167,171,181,187 | `thm.amsthm`, `thm.kernel` | `proof`, `proof[A concise proof]`, `\newtheorem*{axiomofchoice}{Axiom of choice}`, `\newtheorem{observation}{Observation}` |
| tables | floats.tex:8-25,31-45; hfutsetup.tex:65 | `tbl.tabular`, `tbl.booktabs`, `cap.kernel` | `table[h]`, `\centering`, `tabular{cl}`, `\toprule \midrule \bottomrule`, `\caption` above the table |
| inline table with verbatim | citations.tex:16-22 | `tbl.tabular`, `code.verbatim` | `l@{\quad$\Rightarrow$\quad}l`, `\verb|...|` |
| table and figure notes | floats.tex:22,60 | `class.hfutthesis` | `\note{...}` class macro |
| bilingual captions | floats.tex:10,33,70 | `class.hfutthesis` | `\bicaption{zh}{en}` for master and doctor; `\caption` for bachelor (floats.tex:11,58) |
| figures | floats.tex:54-61,67-73; hfutsetup.tex:62,99 | `fig.graphicx` | `figure[!ht]`, `\includegraphics[width=0.3\textwidth]`, `[height=1.5cm]`, `\graphicspath{{hfut-figures/}}` |
| algorithms | floats.tex:79-96; hfutsetup.tex:71 | `alg.algorithm2e` | options `ruled,linesnumbered`; `\SetAlgoLined`, `\KwData`, `\KwResult`, `\While`, `\eIf` |
| long tables (loaded, unused in the body) | hfutsetup.tex:68 | `tbl.longtable` | load only |
| cross-references | floats.tex:7,12; math.tex:82,109 | `xref.kernel` | `\label`, `\ref` |
| hyperlinks and PDF links | hfutsetup.tex:121; abstract.tex:29; intro.tex:16 | `meta.hyperref` | loaded last; `\href` |
| bibliography | hfutsetup.tex:79-80; main.tex:52; citations.tex:44 | `bib.natbib`, `bib.bibtex-bst` | `natbib[sort]`; `\bibliographystyle{hfutthesis-numerical}`; `\bibliography{bib/hfut}`; `\cite`, `\citet`, `\cite[42]`, `\nocite{*}` |
| citation style switch | citations.tex:12-14,27-29,39-41 | `class.hfutthesis` | `\hfutsetup{cite-style=super}` / `inline` mid-document |
| doc-helper macros | hfutsetup.tex:116-118 | `mark.kernel`, `meta.hyperref` | `\cs`, `\pkg`, `\file` (see Bespoke code) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\dif` | hfutsetup.tex:102-111 | yes (`BESPOKE/preamble` alias) | `\newcommand\dif{\mathop{}\!\mathrm{d}}`, or `...\!d` when the class key `math-style=TeX`; the branch uses the class-internal flag `\ifhfut@math@style@TeX`, which the emitter resolves statically from the key it prints; ways `math.kernel`, `class.hfutthesis` |
| `\eu`, `\iu` | hfutsetup.tex:112-113 | yes | `\newcommand\eu{{\symup{e}}}`: alias over `font.unicode-math` |
| `\cs`, `\pkg`, `\file` | hfutsetup.tex:116-118 | yes | `\DeclareRobustCommand` aliases of `\texttt{\char`\\#1}`, `\textsf`, `\nolinkurl` (`mark.kernel`, `meta.hyperref`) |
| `\newtheorem*{axiomofchoice}`, `\newtheorem{observation}` | math.tex:171,181 | yes | `thm.amsthm`, `thm.kernel` declarations |
| expert list page | chapters/expertspage.tex:3-45 | yes (inactive, main.tex:33) | `front.titlepage-env` + `tbl.tabular` + `font.size-commands` + `sp.manual-space`, as in the map |
| `hfutthesis-numerical.bst` | hfutthesis-numerical.bst:2-11 | yes (parameter of `bib.bibtex-bst`) | docstrip output of the published `gbt7714` (CTAN, one read; LPPL 1.3c, in TeX Live) named in its header as `gbt7714-numerical.bst` v2.1.2, renamed; the emitter ships the file and prints the style name. Config integers at lines 57-90; the function body (to line 2438) was not read |
| `hfutthesis-graduate.bst` | hfutthesis-graduate.bst:2-11 | yes, inactive (hfutsetup.tex:86-88 is commented out) | same generator, variant `ustc` v2.1.3; a diff against the numerical style shows config values and a few `format.name$`/`\href` strings differ |
| `hfutthesis-numeric.bbx`/`.cbx`, `hfutthesis-graduate.bbx`/`.cbx`, `hfutthesis-inline.cbx` | hfutthesis-numeric.bbx:4-30; hfutthesis-graduate.bbx:4-58; hfutthesis-inline.cbx:4-18; hfutthesis-numeric.cbx:4; hfutthesis-graduate.cbx:3 | no, but inactive | `\RequireBibliographyStyle{gb7714-2015}` plus `\ExecuteBibliographyOptions` would be a `bib.biblatex-bibtex` parameter set; the `\renewbibmacro*{booktitle}`/`{patenttitle}` overrides and the `\DeclareCiteCommand{\cite}` extend biblatex's own code, so they fail W2 if selected. Not loaded by the sample (hfutsetup.tex:90-96, main.tex:53). Whether they are copies of files in the published bundle was not established (hfutsetup.tex:93-94 names `hfutthesis-authoryear` and `hfutthesis-bachelor`, which are not in the zip) |
| `hfutthesis.cls` and the `.sty` it loads | not in the zip | not assessed | published class (`tex-distribution-unbundled`), treated as `class.hfutthesis`; source not read, so every "class-native" row above is by the sample's own evidence only |

## Content-opaque
none (hfut-figures/hfut-badge.pdf and hfut-name.pdf are included images used as figure content at floats.tex:56,69; whether the class cover also uses them is not visible, class source not read)

## Lib changes
- New ways proposed: none. Considered and not proposed: a caption-package way for `\bicaption` (it is a class macro here, kept under `class.hfutthesis`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Assets and fonts: the Chinese font set (`fontset` option, main.tex:9) and the two PDF images in hfut-figures/ are needed; fonts are not shipped in the zip (note only, not a blocker).
