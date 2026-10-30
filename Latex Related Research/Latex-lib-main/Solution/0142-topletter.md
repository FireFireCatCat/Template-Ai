yes

# 0142-topletter: TOPletter (Politecnico di Torino corporate letter)

- Unverified: read from the source, not compiled.
- Source: Source/0142-topletter/ (origin: https://mirrors.ctan.org/macros/latex/contrib/topletter.zip; licence: Apache 2.0, LICENSE:1-2, TOPletter.dtx:6-11)
- Kind: letter
- Lib: v3 (the snapshot read)
- Engine: pdfLaTeX-compatible (the class loads `inputenc`, `babel`, `helvet`, `fancyhdr`, `geometry`; no `fontspec` or `unicode-math`, TOPletter.dtx:282-292)
- Look carried by: class (the whole letterhead, page frame, opening and closing are inside the published `TOPletter` class, TOPletter.dtx:262-472; the two samples only set the class's own data commands, TOPletter.dtx:478-501 and 506-532)
- Class origin: ctan (the zip is the CTAN package `topletter`, manifest URL under macros/latex/contrib; the class file `TOPletter.cls` is not stored, it is generated from the `class` guard of the `.dtx` by TOPletter.ins:33)
- Main file: TOPletter.dtx (no `.tex` sample is shipped; the samples are guarded blocks inside the `.dtx`: `sampleIt` 478-501 and `sampleEn` 506-532, generated as `EsempioLettera.tex` and `ExampleLetter.tex` by TOPletter.ins:34-35; the documentation example is TOPletter.dtx:228-254)
- Read: main yes (all 535 lines of TOPletter.dtx), zip-local classes and styles all (there is no `.cls`/`.sty` file; the class source is TOPletter.dtx:262-472, read in full; TOPletter.ins and README.md read; the five shipped PDFs, three rendered documents and two image assets, were not opened)

## Verdict
yes. The look is carried by one published CTAN class, `TOPletter`, which is a thin layer on the kernel `article` class: `geometry`, `fancyhdr`, `helvet`, `color`, `changepage` and `babel` settings, a letterhead built from `\includegraphics`, `\rule`, `\parbox` and `\raisebox`, and a few `\newcommand` string setters. Nothing in it is a custom output routine, box-and-glue algorithm, expl3/Lua code or counter machinery; the `\ifdefined` tests only ask whether an optional field was set, so an emitter resolves them when it writes the document. There is no TikZ, `picture` or PSTricks drawing, and no tool outside TeX is needed. No new way is needed.

## Blockers
none

## Class setting
- Class: `class.topletter` options: `italian` (default) or `english` only (TOPletter.dtx:274-277); samples use none (TOPletter.dtx:478) and `english` (TOPletter.dtx:506)
- Base: the class does `\LoadClass[a4paper,11pt]{article}` (TOPletter.dtx:269), so `class.article` with a4paper and 11pt sits inside it
- Class-native vocabulary used: `\dipartimentoDi{}` (TOPletter.dtx:483, 511), `\ruolo{}` (486, 512), `\nome{}` (487, 519), `\telefono{}` (488, 520), `\email{}` (489, 521), `\homepage{}` (490, 522), `\firma{image}` (491), `\soggetto{}` (493, 525), `\protocollo{}` (494, empty value, so only the label "Prot." prints, doc at 188-190, code at 436-439). Offered but unused by the samples: `\struttura{}` (380), `\destinatario{}` (389), `\luogo{}` (392), `\data{}` (393), `\esoggetto{}` (388), `\fax{}` (384), `\logo{image}` (391); also the class colour commands `\orange{}` `\blue{}` `\red{}` and the font commands `\cond{}` `\condb{}` (307-311). `\IfLanguageName{italian}{..}{..}` from `iflang` is used in the English sample (510-516). No `\maketitle`, abstract, sectioning, floats or bibliography are used.

## Component map
Rows 1 to 6 are the class vocabulary a document uses; rows 7 to 22 are what the class source does inside, written to show that each part reduces to lib ways.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| 1 document class | TOPletter.dtx:20, 478, 506 | `class.topletter` | option `english` or `italian` (`\topl@language` = `main=italian,english` or `main=english,italian`, 274-276) |
| 2 base class | TOPletter.dtx:269 | `class.article` | a4paper, 11pt |
| 3 paper and size | TOPletter.dtx:269 | `page.class-options` | a4paper, 11pt, passed to `article` |
| 4 letter data (name, role, department, phone, e-mail, home page, fax, signature, subject, recipient, place, date, protocol, logo) | TOPletter.dtx:379-397 | `front.class-native` | string setters `\def\toplX{#1}`; defaults logo `LogoPolitoBlu.pdf`, place `Torino`, date `\today` (395-397) |
| 5 letterhead and page foot (the class's own running head and foot) | TOPletter.dtx:321-359 | `hf.class-native` | set by the data in row 4 and the class option, no option of its own |
| 6 letter opening and closing blocks (the class's own front matter) | TOPletter.dtx:436-451, 458-469 | `front.class-native` | opening: protocol, recipient, subject; closing: place and date, name, signature |
| 7 page geometry | TOPletter.dtx:282 | `page.geometry` | a4paper, top=2cm, bottom=8cm, left=2cm, right=2cm |
| 8 head height and foot skip | TOPletter.dtx:316-317 | `page.setlength` | `\headheight`=4.1cm, `\footskip`=2cm |
| 9 header and footer package | TOPletter.dtx:288, 321-358 | `hf.fancyhdr` | `\fancypagestyle{plain}` redefined; `\fancyhf{}`; `\fancyhead[LE,LO]` and `\fancyfoot[LE,LO]` only; `\headrulewidth`=0pt, `\footrulewidth`=0pt |
| 10 page style switch | TOPletter.dtx:359 | `hf.pagestyle-kernel` | `\pagestyle{plain}` |
| 11 header logo | TOPletter.dtx:329, 283 | `fig.graphicx` | `\includegraphics[width=2cm,height=2cm]{\toplLogo}` inside `\makebox[2.15cm]` |
| 12 header and closing boxes | TOPletter.dtx:329, 332-338, 461-468 | `box.minipage` | `\makebox[2.15cm]` (329; the kernel width-setting box, same family as `\parbox`); `\parbox[b]{5cm}` (332); `\parbox{5cm}` with `\centering` (461-462) |
| 13 header rule and spacing | TOPletter.dtx:330-331, 335, 337, 343-345, 352-355, 438, 443, 459-460 | `sp.rule`, `sp.manual-space` | `\rule{0.4pt}{2cm}` in blue (330, `sp.rule`); `\hspace{1pt}`, `\raisebox{3pt}`, `\raisebox{-14pt}`, `\linebreak`, `\\`, `\vspace{0.8cm}`, `\hspace{2.5cm}`, `\vspace{1cm}`, `\vspace{2cm}`, `\hspace{.6\textwidth}`, `\hspace{4pt}` (`sp.manual-space`) |
| 14 centring | TOPletter.dtx:448-450, 462 | `sp.ragged` | `center` environment around the subject; `\centering` in the closing `\parbox` |
| 15 recipient block | TOPletter.dtx:286, 440-442 | `page.adjustwidth` | `\begin{adjustwidth}{10cm}{}` (left indent 10cm, right 0) |
| 16 closing signature image | TOPletter.dtx:465-467 | `fig.graphicx` | `\includegraphics[width=4cm]{\toplSignature}`, only if `\firma` was set |
| 17 body font | TOPletter.dtx:285, 306 | `font.helvet`, `font.family-default` | `helvet` package; `\renewcommand*\familydefault{\sfdefault}` |
| 18 condensed series | TOPletter.dtx:307-308, 333, 336 | `font.nfss` | `\fontseries{mc}\selectfont` (`\cond`) and `\fontseries{bc}\selectfont` (`\condb`) |
| 19 sizes and font switches | TOPletter.dtx:333, 336, 342, 350, 449 | `font.size-commands`, `mark.kernel` | `\fontsize{10.5pt}{10pt}`, `\fontsize{7.5pt}{6pt}`, `\small`, `\Large` (`font.size-commands`); `\sffamily`, `\bf` (`mark.kernel`) |
| 20 colours | TOPletter.dtx:284, 299-300, 309-311 | `color.color` | `\definecolor{orange}{cmyk}{0,.70,1.00,0}`, `\definecolor{blue}{cmyk}{1.00,.80,0,.30}`; `\color{orange}`, `\color{blue}`, `\color{red}` as switches (not grouped, 309-311) |
| 21 language and encoding | TOPletter.dtx:274-277, 289, 291, 366-374 | `lang.babel`, `font.fontenc-t1` | `\RequirePackage[\topl@language]{babel}`; `inputenc` option `utf8`; per-language default strings: Dipartimento di / Department of, A chi di competenza / To whom it may concern, Oggetto / Subject (367-373) |
| 22 links | TOPletter.dtx:290, 353-355 | `meta.hyperref` | `hyperref` with no options; `\href{mailto:\toplEmail}{..}`, `\href{\toplHome}{..}`, `\href{http://www.polito.it}{..}` |
| 23 line spacing package | TOPletter.dtx:287 | `sp.setspace` | loaded, no `\setstretch`, `\onehalfspacing` or `\doublespacing` appears anywhere in the file (grep) |
| 24 filler text in the samples | TOPletter.dtx:480, 499, 508, 531 | `draft.todo` | `\usepackage{lipsum}`, `\lipsum` (filler content) |
| 25 documentation driver (documents the package, not the letter template) | TOPletter.dtx:26-36, 259 | `class.ltxdoc`, `dtx.doc` | `\documentclass{ltxdoc}`, `\EnableCrossrefs`, `\PageIndex`, `\RecordChanges`, `\OnlyDescription`, `\DocInput`, `\StopEventually{\PrintChanges\PrintIndex}`; the index pass is `makeindex`, used only for this documentation |
| 26 documentation boxes, links, text | TOPletter.dtx:27-28, 82-93, 101-110, 226-256 | `box.mdframed`, `code.verbatim`, `meta.hyperref`, `front.maketitle`, `front.thanks`, `fn.kernel`, `list.kernel`, `meta.url` | `\usepackage{hyperref}`, `\usepackage{mdframed}`; `mdframed` around a `verbatim` example (226-256); `\title` `\author` `\thanks` `\maketitle` (82-86); `\footnote{\url{..}}` (92-93); `itemize` (101-110) |

Not defined by the class or the samples (so no row): headings and numbering, abstract, contents, lists in the letter, quotes, notes, maths, theorems, floats, tables, captions, code, bibliography, index in the letter, cross-references.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| string setters `\dipartimentoDi` `\struttura` `\ruolo` `\nome` `\telefono` `\fax` `\email` `\homepage` `\soggetto` `\esoggetto` `\destinatario` `\firma` `\logo` `\luogo` `\data` `\protocollo` and defaults | TOPletter.dtx:379-397 | yes | `\newcommand`s that store a string with `\def`; the published class's own vocabulary (`front.class-native`). The emitter writes the setter calls; without the class the strings are written where they print |
| alias macros `\cond` `\condb` `\orange` `\blue` `\red` | TOPletter.dtx:307-311 | yes | aliases for `\fontseries{mc}\selectfont`, `\fontseries{bc}\selectfont` (`font.nfss`) and `\color{..}` (`color.color`); they switch, not wrap, so the emitter writes the same switches at the same places inside the same groups |
| redefined `plain` page style, letterhead and foot | TOPletter.dtx:321-359 | yes | `hf.fancyhdr` with the fields of rows 9 to 13 (`fig.graphicx`, `box.minipage`, `sp.rule`, `sp.manual-space`, `font.nfss`, `font.size-commands`, `color.color`, `meta.hyperref`); only lengths, colours, strings and `\raisebox` offsets |
| language-dependent defaults with `\IfLanguageName` (from `iflang`) | TOPletter.dtx:292, 366-374; sample 510-516 | yes | each branch is a plain string or a data command; the emitter picks the branch of the document language when it writes the file (considered: `iflang`, not proposed, since its branch arguments are code, not option values, and the choice is static for one document) |
| `\ifdefined` presence tests for optional fields | TOPletter.dtx:352, 354, 436, 447, 465 | yes | they test whether `\fax`, `\homepage`, `\protocollo`, `\soggetto`, `\firma` was called; the emitter includes or omits the field when it writes the document |
| `\AtBeginDocument` block: completeness checks, then opening | TOPletter.dtx:402-452 | yes | the checks (`\ClassError`, `\IfFileExists`, 403-431) only raise errors and print nothing, so they drop out; the opening (protocol line 436-439, recipient 440-443, subject 447-451) is one body block at the start of the body: `sp.manual-space`, `page.adjustwidth`, `sp.ragged`, `font.size-commands`, `mark.kernel` |
| `\AtEndDocument` block: closing | TOPletter.dtx:458-469 | yes | one body block after the last paragraph: `sp.manual-space`, `box.minipage`, `sp.ragged`, `fig.graphicx` (signature); place, date (default `\today`, a value) and name are content |
| docstrip/ltxdoc machinery (`%<*class>` guards, `\CheckSum`, `\DoNotIndex`, `\changes`) | TOPletter.dtx:15-81, 259-263, 471-473; TOPletter.ins:33-35 | yes | not part of the letter's look; it extracts `TOPletter.cls` and two samples with plain TeX (docstrip), and typesets the manual with `class.ltxdoc` and `dtx.doc` |

## Content-opaque
none (`LogoPolitoBlu.pdf` and `Walt_Disney_1942_signature.pdf` are shipped image assets used through `\includegraphics`, TOPletter.dtx:329, 395, 466, 491; `\lipsum` is filler text)

## Lib changes
- New ways proposed: none. Every row maps to a way already in lib v3 or to `class.topletter` and `class.article` (class ways, written plainly).
- Considered, not proposed: `iflang` (`\IfLanguageName`; fails W2, its arguments are code branches, and is reducible by a static choice); `ltr.opening` (names the kernel, KOMA and `newlfm` letter commands; TOPletter's `\soggetto`, `\destinatario`, `\firma` are the class's own vocabulary, so they are recorded under `front.class-native`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- This is a class-dimension result: a published class carries the look and the samples add only data strings (rubric ruling 2). The class source is also in the zip (as `.dtx`), so its inside was decomposed into lib ways above to show that the class itself reduces.
- `\makebox` (TOPletter.dtx:329) is filed under `box.minipage` as the kernel width-setting box next to `\parbox`; a reviewer who prefers `box.fancybox` for the `\makebox`/`\fbox` family changes one row, not the verdict.
- `\href` is filed under `meta.hyperref` (the package and its link commands); `xref.hyperref` names `\autoref`, `\nameref` and `\hyperref`, which are cross-reference commands.
- Documentation disagrees with the code in three places (not template-look issues): the manual says the Italian subject label is "Soggetto:" (TOPletter.dtx:166) while the code sets "Oggetto" (369); it names the class `TOPletterA` (103); and the logo error text mentions `PoliLogoBlu.png` (426) while the default is `LogoPolitoBlu.pdf` (395). The missing-department error text refers to `\struttura` (421) while the test is for the value set by `\dipartimentoDi` (419, 379).
- The shipped PDFs (`EsempioLettera.pdf`, `ExampleLetter.pdf`, `TOPletter.pdf`) were not opened (no PDF renderer was available); nothing here claims the output matches them.
- The sample logo is a PDF `\includegraphics` file; the class error text asks for a square image of at least 400x400 pixels (TOPletter.dtx:428-429, doc 197).
- No text addressed to an AI was found in `TOPletter.dtx`, `TOPletter.ins`, `README.md` or `LICENSE`.
