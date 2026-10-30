yes

# 0892-iptconf: iptconf, class for IPT conference proceedings (Igor Sikorsky Kyiv Polytechnic Institute)

- Unverified: read from the source, not compiled.
- Source: Source/0892-iptconf/ (origin: https://mirrors.ctan.org/macros/latex/contrib/iptconf.zip; licence: LPPL 1.3c, README.md:24-29, manifest lppl1.3c)
- Kind: conference
- Lib: v6
- Engine: needs XeLaTeX or LuaLaTeX (the class loads `fontspec` for Open Sans and CMU Serif, iptconf.dtx:395-402; a pdfLaTeX fallback branch with reduced fonts exists at iptconf.dtx:404-409; README.md:13-14 and the magic comment at iptconf.dtx:161 name LuaLaTeX; biber needed for the bibliography)
- Look carried by: class (the whole look is the CTAN class `iptconf`, whose source is the .dtx; the zip holds no separate sample or preamble)
- Class origin: ctan
- Main file: none. The zip has no `.tex` with `\documentclass` and `\begin{document}` except the documentation driver `iptconf.dtx:28-52` (class `l3doc`), and no `iptconf.cls`. The sample analysed is the documentation example `iptconf.dtx:159-203` (other samples: none; README.md:35-36 lists `iptconf.cls` and `iptconf-author.tex`, neither is in the zip)
- Read: main no sample present (documentation example and driver read in full); zip-local classes and styles all (`iptconf.dtx`, 1198 lines, read in full, the class code is lines 320-1194; `iptconf.ins`, `README.md` read; `iptconf.pdf` is the compiled manual, binary, not read: no PDF renderer here, its source is the .dtx)

## Verdict
The zip is the CTAN package `iptconf` (ctan.org/pkg/iptconf read once: class, v1.2 of 2026-05-28, LPPL 1.3c, in TeX Live), a published class, so it is one way `class.iptconf` and passes W1 to W4 through its options (`incollection`, `single=n`) and native commands that take strings. Every component the class sets maps to a lib way (table below) and no `ART`, `UNMAPPED` or `EXTERNAL` item remains: biber is the tool of the lib way `bib.biblatex-biber`, and the metadata files are written by TeX itself (`\iow_*`). The verdict rests on the published-class rule ("Look carried by: class", evidence about the class dimension): the class internals (expl3 title assembly, `.txt`/`.yaml`/`.dat` writers, a patch of `flushend` internals) are not zip-local code here, and the section "Bespoke code" lists them with reductions so a stricter re-read can start there.

## Blockers
none

## Class setting
- Class: `class.iptconf` options: `incollection` (default; `\pagestyle{empty}`, iptconf.dtx:347, 355) and `single[=n]` (`\pagestyle{plain}` and `\setcounter{page}{n}`, default 1; iptconf.dtx:348-353); declared with `\DeclareKeys` (iptconf.dtx:345-356). Built on `\LoadClass[twocolumn, oneside]{article}[2022-06-01]` (iptconf.dtx:335) under `\ProvidesExplClass` (iptconf.dtx:333).
- Class-native vocabulary used by the sample (iptconf.dtx:165-202): preamble `\title{}` (681), `\author[email]{name}{affil-indices}` (697), `\affiliation{institution}{number}` (723), token `\ipt` (516, language-aware institute name), `\udc{}` (748), `\pacs{}` (757), `\abstract{}` (775, a command that stores text, not an environment), `\keywords{}` (766), `\regform{key=value list}` with keys `fullname birthday position phone authoremail confsection copynum needliving needinvitanion` (620-639); body `\PaperLanguage{ukrainian|russian|english}` (532-538, selects the language, calls `\maketitle`, writes the two metadata files), `\section*` and `\section` (954-963), `\newlanguagecommand{\cmd}{lang=text,...}` (431-441), `\figcaption` and `\tabcaption` (1009-1010), language strings `\iptbibname` `\keyname` `\pacsnum` `\udcnum` (471-509).

## Component map
Template (the class), with the documentation example as the sample:

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | iptconf.dtx:333, 165 | `class.iptconf` | options incollection (default) or single=n |
| base class | iptconf.dtx:335 | `class.article` | loaded as `[twocolumn, oneside]`, kernel `\section`, `quotation`, `\footnote` inherited |
| columns | iptconf.dtx:335 | `cols.twocolumn-option` | twocolumn |
| page geometry | iptconf.dtx:365-373 | `page.geometry` | a4paper, footskip=1cm, headsep=0.3cm, top=2cm, bottom=2cm, left=2cm, right=2cm |
| page style | iptconf.dtx:347, 350 | `hf.pagestyle-kernel` | empty (incollection) or plain (single); no running heads are defined |
| first page number | iptconf.dtx:351 | `pgnum.pagenumbering` | `\setcounter{page}{n}`, default 1, `single` only |
| indent after headings | iptconf.dtx:379 | `sp.indentfirst` | reduces `\let\@afterindentfalse\@afterindenttrue`: first paragraph of every section is indented |
| last-page column balance | iptconf.dtx:602, 604-611 | `cols.balance` | `flushend` loaded (considered: flushend as its own way; same effect type as `balance`, the package is the parameter) |
| colour | iptconf.dtx:381 | `color.xcolor` | `xcolor` loaded, no options; names used in hyperref (red!60!black, green!50!black) |
| text fonts (Xe/Lua) | iptconf.dtx:399-402 | `font.fontspec` | `\setsansfont{Open Sans}`, `\setmainfont{CMU Serif}`, `\setmonofont{CMU Typewriter Text}` |
| text fonts (pdfTeX fallback) | iptconf.dtx:405-408 | `font.fontenc-t1` | `fontenc` options T2A,T1 |
| font map for copy and paste | iptconf.dtx:406 | `meta.glyphtounicode` | `cmap` package (the package is the parameter), pdfTeX branch only |
| family defaults (fallback) | iptconf.dtx:407-408 | `font.family-default` | `\sfdefault`=opensans-LF, `\bfdefault`=b |
| maths packages | iptconf.dtx:410-411 | `math.mathtools`, `math.amssymb` | load only, no options |
| micro-typography | iptconf.dtx:412 | `sp.microtype` | patch=footnote |
| languages | iptconf.dtx:394 | `lang.babel` | english, ukrainian (russian is not in the option list, see Notes) |
| quotation marks | iptconf.dtx:393 | `lang.csquotes` | load only |
| language-keyed strings | iptconf.dtx:431-441, 473-520 | `lang.translator` | reduction of `\newlanguagecommand` (an expl3 property list per command, lookup by `\languagename`): one `\DeclareTranslation{Language}{key}{text}` per string, e.g. bibliography heading Ukrainian/Russian/English, "Keywords", "PACS numbers", "UDC" |
| title block | iptconf.dtx:813-841 | `front.class-native` | `\maketitle` is replaced; order: PACS and UDC lines, `\vskip 1em`, centred title, `\vskip 1.5em`, centred authors, `\vskip 1ex`, affiliations |
| title text | iptconf.dtx:827-829 | `mark.case`, `mark.kernel`, `font.size-commands` | upper-cased (`\text_uppercase:n`, the expl3 form of `\MakeUppercase`), `\Large\bfseries\sffamily` |
| author list | iptconf.dtx:697-717, 802-805 | `front.class-native` | `\author[email]{name}{indices}`: name plus `\textsuperscript{indices}`, joined by comma and space, set in `\large` with `\lineskip .5em` |
| author e-mail note | iptconf.dtx:708, 826 | `front.thanks` | `\textsuperscript{,}\thanks{email}`; `\footnote` is made equal to `\thanks` inside the block |
| affiliations | iptconf.dtx:723-742, 839 | `front.class-native` | each `\textsuperscript{n}\ institution`, separated by `\\[2ex]` |
| title spacing | iptconf.dtx:824, 830, 838 | `sp.manual-space` | `\vskip 1em`, `\vskip 1.5em`, `\vskip 1ex` |
| full-width block over two columns | iptconf.dtx:877-889 | `cols.twocolumn-cmd` | `\twocolumn[title block, rule, abstract, keywords, rule]` (when `\col@number` is not 1; otherwise the block is set inline, 864-875) |
| rules around the abstract | iptconf.dtx:866, 875, 878, 888 | `sp.rule` | `\noindent\hrulefill` before and after |
| abstract | iptconf.dtx:775-787, 868-873 | `abs.class-native`, `quote.kernel` | heading `{\large\bfseries \abstractname}`, text inside `\quotation` |
| keywords | iptconf.dtx:766-769, 874 | `abs.keywords` | `\noindent{\bfseries \keyname}:~` list, label by language |
| classification codes | iptconf.dtx:748-760, 816-821 | `abs.classification` | `\udc{}` printed as `\udcnum` + code, `\pacs{}` as `\pacsnum` + codes, above the title |
| title footnote marks | iptconf.dtx:853-859 | `num.counters` | `\thefootnote` = `\itshape\asbuk{footnote}` for Ukrainian and Russian, `\itshape\alph{footnote}` for English; counter reset after the block (898) |
| section headings | iptconf.dtx:927-963, example 196-200 | `head.kernel` | `\@startsection{section}{1}{\z@}{-2ex \@plus -1ex \@minus -.2ex}{1.3ex \@plus .2ex}{\normalfont\large\bfseries\raggedright}`; number format `\thesection.\enskip` (930-935); the same values fit `head.titlesec` |
| subsection headings | iptconf.dtx:969-992 | `head.kernel` | `\@startsection{subsection}{2}{\z@}{-3.25ex \@plus -1ex \@minus -.2ex}{1.5ex \@plus .2ex}{\normalfont\bfseries\raggedright}` |
| starred sections in contents | iptconf.dtx:948-952, 977-981 | `toc.kernel` | `\addcontentsline{toc}{section}{title}` after every starred heading (kernel contents entry; no contents list is printed by the class) |
| lists | iptconf.dtx:592-593 | `list.enumitem` | `\setlist{nosep}` |
| subfigures | iptconf.dtx:1001, 1015 | `fig.subcaption`, `num.counters` | `labelformat=simple`; `\thesubfigure` = `(\alph{subfigure})` |
| captions | iptconf.dtx:1002, 1016 | `cap.caption` | `labelsep=period`; `\captionsetup[subfigure]{justification=centering, subrefformat=parens}` |
| caption outside a float | iptconf.dtx:1009-1010 | `cap.caption` | `\figcaption` and `\tabcaption`; reduction `\captionof{figure}{}` and `\captionof{table}{}` |
| hyperlinks and bookmarks | iptconf.dtx:1024-1035 | `meta.hyperref` | colorlinks=true, urlcolor=blue, linkcolor=red!60!black, citecolor=green!50!black, bookmarks, bookmarksnumbered=true, breaklinks=true, unicode, linktoc=all, hypertexnames=false |
| bibliography | iptconf.dtx:547-557 | `bib.biblatex-biber` | backend=biber, bibstyle=gost-numeric (biblatex-gost bundle), sorting=none, maxnames=10, autolang=other, isbn=true, url=true, doi=true, defernumbers=true |
| bibliography URL breaks | iptconf.dtx:559-561 | `bib.biblatex-biber` | `\setcounter{biburllcpenalty}{100}`, `biburlucpenalty` 200, `biburlnumpenalty` 100 |
| bibliography spacing | iptconf.dtx:566-567 | `sp.lengths` | `\bibitemsep`=0.5\itemsep, `\biblabelsep`=1ex |
| bibliography penalties | iptconf.dtx:568-572 | `sp.penalties` | `\clubpenalty`, `\widowpenalty`, `\interlinepenalty` all 0, appended to `\bibsetup` |
| bibliography print and heading | iptconf.dtx:578-584 | `bib.biblatex-biber` | `\printbibliography[title=...]` at end of document; reduction: one body call with the heading text of the language (References, Перелік використаних джерел, Перечень использованных источников) |
| registration form data | iptconf.dtx:620-639 | `front.class-native` | `\regform{key=value}`; stored only, no printed output (written to jobname-regform.txt and -info.yaml, see Bespoke code) |
| theorems, tables, code, boxes, headers/footers text | iptconf.dtx (grep: no `newtheorem`, `tabular`, `fancyhdr`, `tcolorbox`, `titlesec`, `tikz`) | none | the class defines none; article defaults apply for `\subsubsection`, `\paragraph`, equations, `tabular` |

Documentation driver (iptconf.dtx:28-52; builds the manual, not the template):

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| driver class | iptconf.dtx:31 | `class.l3doc` | `l3doc` of the expl3 bundle; not bundled in the zip, its source was not read |
| driver fonts | iptconf.dtx:33-36 | `font.fontspec` | `\setmainfont{CMU Serif}`, `\setmonofont{CMU Typewriter Text}`, `\setsansfont{CMU Sans Serif}` |
| driver languages | iptconf.dtx:37, 40 | `lang.babel`, `lang.csquotes` | ukrainian, russian, english; `csquotes` |
| driver typography and logos | iptconf.dtx:38, 39 | `sp.microtype`, `font.icons` | `microtype`; `hologo` (`\hologo{LuaLaTeX}`, line 97) |
| driver lists | iptconf.dtx:41-42 | `list.enumitem` | `\setlist{noitemsep}` |
| doc source typesetting | iptconf.dtx:43-50 | `dtx.doc` | `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput{iptconf.dtx}`, `\PrintChanges`, `\PrintIndex`; the `.ins` is plain DocStrip (iptconf.ins:1-9, `\generate{\file{\jobname.cls}{\from{\jobname.dtx}{package}}}`) |
| doc title, abstract, contents | iptconf.dtx:69-84, 86-100, 102 | `front.maketitle`, `abs.kernel`, `toc.kernel` | `\title`, `\author`, `\date`, `\maketitle`, `abstract` environment, `\tableofcontents` (line 69 carries a doubled `%`, so the title may be dead in the manual; read, not compiled) |
| doc footnote | iptconf.dtx:70-71 | `front.thanks` | `\thanks{...}` in the title |

## Bespoke code
Nothing in the zip is zip-local code: `iptconf.cls` is the published CTAN class (iptconf.dtx:333), and the `.ins` only runs DocStrip. The sample (iptconf.dtx:159-203) defines no macro, counter or environment of its own.

Class-internal items (published, so not counted; listed with a reduction so that a re-read that treats the class as zip-local can start here):

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newlanguagecommand` and five language-string tables | iptconf.dtx:431-520 | yes | `lang.translator`, one translation per language and string |
| `\author` `\affiliation` `\@affiliation` `\authors` (expl3 sequences, `\seq_use:Nnnn`) | iptconf.dtx:665-668, 697-742, 802-805 | yes in layout, class code in data handling | printed result is superscript indices, `,~` joins and `\\[2ex]` joins: `front.class-native` plus `sp.manual-space`; the sequences only store values |
| `\@maketitle` and `\maketitle` with `\if@twocolumn`, `\col@number` and `\iflanguage` branches | iptconf.dtx:813-910 | yes as layout | `cols.twocolumn-cmd`, `sp.rule`, `quote.kernel`, `mark.case`, `mark.kernel`, `font.size-commands`, `sp.manual-space`, `num.counters` (rows above); the branches only pick a variant the emitter already knows |
| `.dat`, `-regform.txt` and `-info.yaml` writers (`\iow_open:Nn`, `\iow_now:Nx`, `\text_purify:n`, regex clean-up) | iptconf.dtx:671-675, 681-691, 710-716, 916-920, 1042-1189 | not a typesetting item | no printed effect; written by TeX, no outside tool; no lib way holds file export; under a zip-local reading this would need a decision (a candidate `BESPOKE/class` that does not touch the look) |
| `\initialize@flushend` redefinition (`\@outputdblcol`, `\last@outputdblcol`, `\savingvdiscards`, `\footnoterule`) | iptconf.dtx:604-611 | no (output-routine internals of `flushend`) | `cols.balance` covers the package; the patch itself would be a candidate `BESPOKE/class` |
| `\g@addto@macro\bfseries{\boldmath}` | iptconf.dtx:418 | no lib way for a global `\boldmath` hook | candidate `BESPOKE/class`, one line |
| `\let\@afterindentfalse\@afterindenttrue` | iptconf.dtx:379 | yes | `sp.indentfirst` |
| `\@startsection` section and subsection, `\@seccntformat` | iptconf.dtx:927-992 | yes | `head.kernel` values above, or `head.titlesec` |
| `\figcaption` `\tabcaption` | iptconf.dtx:1009-1010 | yes | `\captionof` (`cap.caption`) |
| `\AddToHook{enddocument}` printing the bibliography | iptconf.dtx:578-584 | yes | one `\printbibliography[title=...]` in the body (`bib.biblatex-biber`) |

## Content-opaque
none (the example has no figure, table or equation; no drawing in the class)

## Notes (read, not compiled)
- Missing assets: Open Sans and the CMU fonts (Computer Modern Unicode) are not shipped (iptconf.dtx:399-402); `biblatex-gost` and biber are needed (iptconf.dtx:146-147, 549).
- Possible defects, not verified and not blockers: `russian` is documented (iptconf.dtx:299) and has strings (475) but is not in the babel option list (394); the pdfTeX branch sets `\sfdefault{opensans-LF}` without loading `opensans` (407). No text addressed to an AI was found in the zip.
- The class prints the bibliography at `\end{document}` and loads biblatex unconditionally, so a `.bib` file needs `\addbibresource` in the preamble (the command is not shown in the example).

## Lib changes
- New ways proposed: none (considered: `flushend` for the last-page column balance, filed under `cols.balance`, the package being the parameter; `class.iptconf` and `class.l3doc` are class ways, no proposal needed).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
