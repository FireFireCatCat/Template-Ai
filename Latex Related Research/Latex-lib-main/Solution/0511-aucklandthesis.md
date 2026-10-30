yes

# 0511-aucklandthesis: University of Auckland thesis class (aucklandthesis)

- Unverified: read from the source, not compiled.
- Source: Source/0511-aucklandthesis/ (origin: https://mirrors.ctan.org/macros/latex/contrib/aucklandthesis.zip; licence: lppl1.3, README.txt:14-23)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (template.tex:21-22 load inputenc and fontenc; the class leaves the XeLaTeX/LuaTeX choice to the author, aucklandthesis.cls:17-20)
- Look carried by: class (template.tex only sets field values; the look is aucklandthesis.cls, a CTAN class that loads memoir, aucklandthesis.cls:65)
- Class origin: ctan
- Main file: template.tex (other samples: none; aucklandthesis_userguide.pdf is documentation and was not read)
- Read: main yes, zip-local classes and styles all (aucklandthesis.cls, 330 lines; memoir, loaded at aucklandthesis.cls:65, is not in the zip and its source was not read)

## Verdict
The look is carried by one published class, `class.aucklandthesis` (the zip is the CTAN download `macros/latex/contrib/aucklandthesis.zip`, so W1 holds), which loads the published `class.memoir`. The sample adds no macro, package option or environment of its own: it loads inputenc and fontenc, fills six title-page fields, calls `\maketitle`, sets the contents depth, and restarts the page counter before the (empty) end matter (template.tex:21-22, 101-109, 121, 153-154). Everything else in the template is commented out. No artwork, no external tool, no zip-local macro outside the class. This is evidence about the class dimension, not about component ways; the class internals are decomposed below anyway and none of them is irreducible (see Bespoke code).

## Blockers
none

## Class setting
- Class: `class.aucklandthesis` options: `11pt` (template.tex:1). Native options: `examcopy` `partial` `singlespace` `onehalfspace` `doublespace` (aucklandthesis.cls:52-56); any other option (`10pt` `12pt` `oneside` `draft`, listed at template.tex:9-14) is forwarded to memoir (aucklandthesis.cls:60). Base class: `class.memoir`, loaded unconditionally (aucklandthesis.cls:65), a published class that ships with the TeX distribution, source not read.
- Class-native vocabulary used: `\subtitle` `\degreesought` `\degreediscipline` `\degreecompletionyear` and the redefined `\maketitle` (template.tex:102, 104-106, 109; aucklandthesis.cls:87, 97-102, 104). `\title` and `\author` are kernel commands (template.tex:101, 103). Defined by the class but commented out in the sample: `\thesisdedication` (template.tex:115; aucklandthesis.cls:171). memoir command used by the sample: `\settocdepth` (template.tex:121).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | template.tex:1; aucklandthesis.cls:52-56, 60-63 | `class.aucklandthesis` | option 11pt; native switches examcopy, partial, singlespace, onehalfspace, doublespace; the rest forwarded to memoir |
| base class | aucklandthesis.cls:65 | `class.memoir` | `\LoadClass{memoir}`, no option of its own |
| input and font encoding | template.tex:21-22 | `font.fontenc-t1` | inputenc=utf8; fontenc=T1; the class sets no typeface (aucklandthesis.cls:76) |
| page geometry (in class) | aucklandthesis.cls:68-74 | `page.memoir-layout` | `\setlrmarginsandblock{4cm}{4cm}{*}`; `\setulmarginsandblock{3cm}{4cm}{*}`; `\setheadfoot{\baselineskip}{3\baselineskip}`; `\setheaderspaces{*}{2\baselineskip}{*}`; `\checkandfixthelayout`; `\fixpdflayout` |
| margin-note dimensions (in class) | aucklandthesis.cls:72 | `page.memoir-layout` | `\setmarginnotes{3mm}{3cm}{6pt}` (lengths only; the sample has no margin note) |
| line-breaking tolerance (in class) | aucklandthesis.cls:78-79 | `class.memoir` | `\midsloppy`, `\sloppybottom` (memoir built-ins; the author may override, line 78 comment) |
| line spacing (in class) | aucklandthesis.cls:52-54, 183-192 | `class.memoir` | option picks `\SingleSpacing`, `\OnehalfSpacing` (default) or `\DoubleSpacing`, applied when the redefined `\mainmatter` runs at the end of `\maketitle` (line 167) |
| space after full stop (in class) | aucklandthesis.cls:199 | `sp.frenchspacing` | `\frenchspacing` |
| title block fields and print | template.tex:101-109; aucklandthesis.cls:85-102, 104-168 | `front.class-native` | `\title` `\subtitle` `\author` `\degreesought` `\degreediscipline` `\degreecompletionyear`, then `\maketitle`; prints title, optional subtitle, author, and a fixed degree statement ending "The University of Auckland, <year>"; option `partial` inserts the word partial, option `examcopy` adds a bold confidentiality note (aucklandthesis.cls:141-143, 153-158) |
| title page flow | aucklandthesis.cls:105, 165 | `pg.break` | `\cleardoublepage` before, `\clearpage` after |
| title page style | aucklandthesis.cls:106 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| title page height | aucklandthesis.cls:107 | `pg.enlarge` | `\enlargethispage{1cm}` |
| title page numbering | aucklandthesis.cls:108; template.tex:95-96 | `pgnum.pagenumbering` | `\setcounter{page}{1}` (title page counted, not numbered) |
| title page rules | aucklandthesis.cls:109, 163 | `sp.rule` | `\hrulefill` at top and bottom |
| title page bands | aucklandthesis.cls:111, 125, 136 | `box.minipage` | three `minipage[t][0.3\textheight][t]{\textwidth}` |
| title page alignment | aucklandthesis.cls:113, 127, 138 | `sp.ragged` | `center` environment in each band |
| title page spacing | aucklandthesis.cls:112, 116, 123, 134, 154 | `sp.manual-space` | `\vspace*{\fill}`, `\vfill`, `\vspace{0.5\baselineskip}`, `\bigskip` |
| title page type sizes | aucklandthesis.cls:114, 116, 128, 139 | `font.size-commands` | `\Huge` title, `\huge` subtitle, `\large` author, `\normalfont` statement |
| title page bold note | aucklandthesis.cls:155, 157 | `mark.kernel` | `\textbf` (examcopy only) |
| dedication page | aucklandthesis.cls:171-180; template.tex:115 (commented) | `front.class-native` | `\thesisdedication{text}`: `\cleardoublepage`, `\thispagestyle{plain}`, centred text between `\vspace*{\fill}` |
| heading number depth (in class) | aucklandthesis.cls:82 | `num.secnumdepth` | `\setsecnumdepth{subsubsection}` |
| contents depth | template.tex:121 | `num.secnumdepth` | `\settocdepth{section}` |
| contents entry look (in class) | aucklandthesis.cls:312-314 | `class.memoir` | `\cftchapterfont{\scshape}`; `\cftsubsectionindent`=6em; `\cftsubsectionfont{\itshape}` (memoir's own tocloft-style names; tocloft itself is not loaded) |
| running-head marks (in class) | aucklandthesis.cls:203-205 | `hf.memoir-pagestyle` | `\nouppercaseheads`; `\createmark{chapter}{both}{nonumber}{}{}`; `\createmark{section}{right}{nonumber}{}{}` |
| page style Forder (defined, not selected) | aucklandthesis.cls:208-217 | `hf.memoir-pagestyle` | `\copypagestyle{Forder}{myheadings}`; `\makerunningwidth` 1.2\textwidth; `\makeheadposition` flushright/flushleft; `\makeoddhead` `\makeevenhead` with italic marks and page number; `\makepsmarks` |
| page style Sewell (defined, not selected) | aucklandthesis.cls:260-268 | `hf.memoir-pagestyle` | `\copypagestyle{Sewell}{myheadings}`; italic mark and page number heads; `\makeheadrule{Sewell}{\textwidth}{0.5pt}`; `\makepsmarks` |
| draft footers | aucklandthesis.cls:316-327 | `hf.memoir-pagestyle` | under `\ifdraftdoc`, `\makeevenfoot` and `\makeoddfoot` of `plain` and `myheadings` carry "Draft" and `\today`, set `\AtBeginDocument` |
| chapter style Forder (defined, not selected) | aucklandthesis.cls:220-257 | `head.memoir-style` | `\makechapterstyle{Forder}`: name and number `\Large\scshape`, title `\Huge\scshape\MakeLowercase`; `\beforechapskip` 50pt, `\midchapskip` 20pt, `\afterchapskip` 60pt; section `\raggedright\Large\scshape`, subsection `\raggedright\large\bfseries`, subsubsection `\raggedright\itshape`; skips in `\onelineskip` multiples; ends with `\pagestyle{Forder}` |
| chapter style Sewell (defined, not selected) | aucklandthesis.cls:271-303 | `head.memoir-style` | `\makechapterstyle{Sewell}`: right-aligned name, title `\Huge\itshape`, `\hrulefill` under the number, `\midchapskip` 12pt, centred section levels, `\setsecnumdepth{chapter}`; ends with `\pagestyle{Sewell}` |
| section number format in Forder | aucklandthesis.cls:239 | `num.counters` | `\renewcommand*\thesection{\arabic{section}}` (inside the Forder style, aucklandthesis.cls:238 sets the depth to section) |
| back matter (defined, not called) | aucklandthesis.cls:194-197 | `pgnum.pagenumbering` | `\backmatter` redefined to `\clearpage` and `\setcounter{page}{0}` |
| page restart before appendices | template.tex:153 | `pg.break` | `\cleardoublepage` |
| page counter reset | template.tex:154 | `pgnum.pagenumbering` | `\setcounter{page}{1}` |

Rows marked "(in class)" and the title-page internals are realised by `class.aucklandthesis` itself; the component way is the closest lib line, listed for decomposition and not emitted separately. "Defined, not selected": neither `template.tex` nor the class calls `\chapterstyle` or a top-level `\pagestyle` (grep over both files shows `\pagestyle` only inside the two chapter styles, aucklandthesis.cls:256, 302), so the sample shows memoir's own default chapter and page style; the user guide, which may tell authors to select them, was not read.

Commented out in the sample, so not counted: abstract input (template.tex:112), acknowledgements (118), `\tableofcontents` (the text after `%` on line 121 swallows `\cleardoublepage\tableofcontents`), `\listoffigures` `\listoftables` (122-123), glossary (126), chapter inputs (141-143), appendix (155-156), biblatex bibliography (81-87, 158), and optional packages graphicx, appendix, hyperref, booktabs, microtype, font families, cjk, tabularx, tocbibind (24-75). The body has no chapter, float, list, theorem or code construct.

## Bespoke code
No macro, environment, counter or conditional is defined in template.tex. The zip-local file is aucklandthesis.cls, a CTAN class, so by W1 it is a published way and not bespoke; the table lists its internal code anyway, with the reduction that would apply if it were counted as zip-local.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand{\maketitle}`: three bands, rules, conditional text | aucklandthesis.cls:104-168 | yes | kernel and memoir calls only (rows above); the booleans `partial`, `examcopy` and subtitle-present only select text, which an emitter resolves from the option and the field |
| `\subtitle` emptiness test with `\sbox0` and `\ifdim\wd0=0pt` | aucklandthesis.cls:87-95 | yes | the emitter knows whether the subtitle is empty, so it prints the subtitle line or not |
| missing-field error guards `\@degreesought` etc. | aucklandthesis.cls:97-102 | yes | no layout effect; emit the three fields |
| `\renewcommand\mainmatter` as a spacing switch | aucklandthesis.cls:183-192 | yes | one memoir spacing switch chosen by option; note memoir's own `\mainmatter` is replaced, not extended |
| `\renewcommand\backmatter` | aucklandthesis.cls:194-197 | yes | `\clearpage` plus `\setcounter{page}{0}` |
| `\thesisdedication` | aucklandthesis.cls:171-180 | yes | kernel page break, page style and `\vspace*{\fill}` |
| chapter-style `\def` of memoir hook macros (`\printchaptername` etc.) | aucklandthesis.cls:222-230, 273-280 | yes | memoir's documented hooks set inside `\makechapterstyle` (the class says it takes snippets from the memoir manual, line 22); `head.memoir-style`; dormant in the sample |
| `\AtBeginDocument` draft footers | aucklandthesis.cls:316-327 | yes | `hf.memoir-pagestyle` footers under the draft option |

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
