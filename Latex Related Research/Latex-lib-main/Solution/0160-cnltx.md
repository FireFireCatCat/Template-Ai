no

# 0160-cnltx: the cnltx bundle (class `cnltx-doc`, a package-manual class)

- Unverified: read from the source, not compiled.
- Source: Source/0160-cnltx/ (origin: https://mirrors.ctan.org/macros/latex/contrib/cnltx.zip; licence: lppl1.3)
- Kind: misc (documentation manual for a package bundle; the manifest hint is also misc)
- Lib: v3
- Engine: pdfLaTeX-compatible (the class branches on the engine: T1 + libertine + beramono under pdfTeX, fontspec + `\setmonofont` under XeLaTeX/LuaLaTeX, cnltx-doc.cls:117-119, 181-187; the sample header asks arara for pdflatex, cnltx_en.tex:1-5)
- Look carried by: class (published `cnltx-doc` over KOMA `scrartcl`, cnltx-doc.cls:79; the sample adds `\setcnltx` values, package loads and small aliases)
- Class origin: ctan (cnltx v0.15 is on CTAN and in TeX Live, read at ctan.org/pkg/cnltx; the zip is that release, README:25-27)
- Main file: cnltx_en.tex (other samples: none)
- Read: main yes, zip-local classes and styles partly (cnltx-listings.sty lines 60-220 and 300-1870 are keyword data lists, not read; every other .cls/.sty/.bbx/.cbx/.dbx/.ist read)

## Verdict
`no`. The look is carried by the published class `cnltx-doc` (a CTAN release, so published under W1), and almost every component maps to a lib way. The blocker is that the sample selects the class's `compile` option on three executed `example` environments (cnltx_en.tex:1057, 1142, 1174). That option runs `\immediate\write18{pdflatex ...}` twice per example through shell escape (cnltx-example.sty:653, 665-677, 880-897), and the file header asks arara for `shell: on` (cnltx_en.tex:1). The lib already treats the same pattern (`standalone` `mode=build*`) as EXTERNAL when selected. There is no ART and no irreducible sample-local code.

## Blockers
- `EXTERNAL/body` three `\begin{example}[compile...]` blocks need shell escape to run a nested pdflatex and include the resulting PDF pages (cnltx_en.tex:1057, 1142, 1174; cnltx-example.sty:653-677, 880-951; header cnltx_en.tex:1). The four indented `[compile]` lines at cnltx_en.tex:1005, 1042, 1127, 1159 sit inside `sourcecode` and are only displayed.

## Class setting
- Class: `class.cnltx-doc` options: `load-preamble+` (= `load-preamble` + `add-index` + `add-bib`, cnltx-doc.cls:65-70; cnltx_en.tex:34); unknown options are passed to `scrartcl` (cnltx-doc.cls:73-74, 79).
- Class-native vocabulary used: `\setcnltx{name,title,subtitle,version,date,info,authors,email,url,abstract,index-setup,add-cmds,add-silent-cmds,add-envs,add-frame-options}` (cnltx_en.tex:43-132); description environments `commands` `options` `environments` with `\command` `\opt` `\keyval` `\keychoice` `\keybool` `\environment` `\Default` `\Module` `\expandable`; code environments `example` `sourcecode` `sidebyside` and `\inputsourcecode`; inline `\code` `\verbcode` `\cs` `\env` `\pkg` `\cls` `\option` `\key` `\keyis` `\meta` `\marg` `\oarg` `\Marg` `\default` `\choices`; notes `\sinceversion` `\changedversion` `\newnote` `\bypackage`; `cnltxquote`; `\newname` `\name` `\newpackagename` `\newabbr` `\ie` `\eg` `\etc` `\cf`; `\license` `\lppl` `\ctan` `\CTANurl` `\needpackage`; list printers `\listsilentcmds` `\listsilentenvs` `\listbibfileentries` (cnltx_en.tex:2924, 2933, 2943). Underlying KOMA vocabulary: `\part`, `\minisec` (cnltx_en.tex:184, 1258).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | cnltx_en.tex:34; cnltx-doc.cls:79 | `class.cnltx-doc` | `load-preamble+`; `scrartcl` loaded underneath |
| title block and info keys | cnltx_en.tex:44-53; cnltx-doc.cls:751-801 | `front.class-native` | name=cnltx, title, subtitle, info, authors, email, url; version and date are written as literal strings (cnltx-base.sty:28-29, the sample reads them with `\csname`, cnltx_en.tex:46-47); `\thispagestyle{plain}` (`hf.pagestyle-kernel`), title in a `.6\linewidth` minipage scaled `\scalebox{1.5}` (`fig.graphicx`), `\Huge`/`\large`/`\Large` (`font.size-commands`), `\vskip.5cm` and `\qquad` (`sp.manual-space`), `\url` (`meta.url`) |
| abstract | cnltx_en.tex:54-62; cnltx-doc.cls:310-311, 417-424 | `abs.class-native` | key `abstract`; parbox `abstract-width`=.75\linewidth; `abstract-format`=`\setlength\parskip{.333\baselineskip}` |
| table of contents | cnltx-doc.cls:729-735, 796-800 | `front.class-native`, `toc.kernel`, `cols.multicol`, `sp.ragged` | `multicols{2}`, `\RaggedRight`, `\tableofcontents` with the list head gobbled, `\pdfbookmark[1]` |
| page geometry | cnltx-doc.cls:189-190 | `page.typearea` | `\KOMAoptions{DIV=last}` then `\recalctypearea`, only when fonts are loaded; paper size not set in the sample (scrartcl default, source not read) |
| running head | cnltx-doc.cls:214-217 | `hf.scrlayer-scrpage` | `\chead{\rightmark}`, `automark`, `\pagestyle{scrheadings}` (class option `adapt-layout`, default true) |
| heading looks | cnltx-doc.cls:198-212 | `head.class-native`, `head.koma-fonts` | `\sectionformat` etc. = `\textcolor{cnltx}{\thesection\autodot}\enskip`; `\setkomafont{subsubsection}{\normalfont\normalsize\itshape}`; `\partformat` = `\textcolor{cnltx}{\partname~\thepart\autodot}` |
| heading commands used | cnltx_en.tex:184, 186, 393, 987, 1258, 2587 | `head.kernel` | `\part` `\section` `\subsection` `\subsubsection` `\paragraph` and KOMA `\minisec` (unnumbered heading, same type) |
| appendix | cnltx_en.tex:2538-2539 | `num.appendix` | `\part{Appendix}` then `\appendix` |
| footnotes | cnltx_en.tex:188-189; cnltx-doc.cls:125-131, 193, 213 | `fn.kernel` | `\footnote` in the body; footnote layout `\deffootnote{2em}{1em}{\llap{\thefootnotemark. }}`, a libertine `\@makefnmark` patch and `fnpct` are class-internal, set by `load-preamble` and `adapt-layout` (considered: KOMA `\deffootnote`, `fnpct`; no separate way, they ride on `class.cnltx-doc`) |
| repeated fixed footnote | cnltx_en.tex:160-161 | `fn.fixfoot` | `\usepackage{fixfoot}`, `\DeclareFixedFootnote\oberdiekfn{\CTANurl{oberdiek}}` |
| input encoding, T1 | cnltx_en.tex:35; cnltx-doc.cls:118 | `font.fontenc-t1` | `[utf8]{inputenc}` (sample), `[T1]{fontenc}` (class, pdfTeX branch) |
| text face | cnltx-doc.cls:120-121 | `font.libertine` | `[oldstyle]{libertine}`, `libertinehologopatch` |
| mono face | cnltx-doc.cls:182 | `font.mono` | `[scaled=.81]{beramono}` |
| XeLaTeX/LuaLaTeX branch | cnltx-doc.cls:119, 184-187 | `font.fontspec` | `fontspec`, `\setmonofont[Scale=MatchLowercase, Ligatures={NoCommon,NoRequired,NoContextual}]{DejaVu Sans Mono}` |
| font switches | cnltx-example.sty:49, 153; cnltx-doc.cls:104-105 | `mark.kernel` | `\ttfamily` `\sffamily` `\itshape` `\scshape` `\normalfont` |
| microtype | cnltx-doc.cls:135, 145-149, 158-162, 171-176 | `sp.microtype` | sets `romansans` (rm*,sf*) and tracking `scshape`; protrusion and expansion on `romansans`; `\DisableLigatures{family=tt*}` |
| colours | cnltx-base.sty:750-757, 784-851; cnltx_en.tex:171 | `color.xcolor` | `\xdefinecolor` cnltxbrown, cnltxblue, cnltxred, cnltxgreen, cnltxgray, formal pair; named schemes `default`/`blue`/`formal` via `\colorlet`; `\textcolor` |
| language | cnltx_en.tex:33; cnltx-doc.cls:194 | `lang.babel` | `\PassOptionsToPackage{ngerman,english}{babel}`; class loads `babel` with `babel-options`=english |
| quotes | cnltx_en.tex:134, 1470-1471 | `lang.csquotes` | `\enquote` |
| string translations | cnltx_en.tex:2477-2533; cnltx-translations.sty:38-122; cnltx-tools.sty:202 | `lang.translator` | `\DeclareTranslation`, `\DeclareTranslationFallback`, `\GetTranslation`, `\GetTranslationFor` (English and German strings) |
| PDF metadata, links | cnltx-doc.cls:877-899; cnltx_en.tex:138 | `meta.hyperref` | colorlinks=true, allcolors=link, plainpages=false, bookmarksopen, bookmarksopenlevel=1, bookmarksnumbered, pdfauthor, pdftitle, pdfsubject, pdfstartview=FitH; `\texorpdfstring` |
| cross references | cnltx_en.tex:37, 254, 321 | `xref.varioref`, `xref.kernel` | `\usepackage{varioref}`; `\ref`, `\vref`, `\label` |
| margin notes | cnltx-doc.cls:813-824, 852-855; cnltx_en.tex:150-151 | `note.marginnote` | `\marginnote` after `\reversemarginpar`; `\footnotesize\sffamily\RaggedRight`, colour `versionnote` |
| description lists | cnltx-doc.cls:478-492, 496-501, 538-547, 582-587 | `list.kernel`, `sp.lengths` | kernel `\list` with `\leftmargin=0pt \labelwidth=2em \labelsep=0pt \itemindent=-1em`; `\item` items printed by class macros |
| bullet and numbered lists | cnltx_en.tex:251, 347, 2310 | `list.kernel` | `itemize`, `enumerate` |
| block quote | cnltx-doc.cls:707-724; cnltx_en.tex:1845-1851 | `quote.kernel` | `quote` + `\small\sffamily`; author flush right in `\itshape` |
| source blocks | cnltx-example.sty:220-294, 965-993, 1015-1017; cnltx_en.tex:586 | `code.listings` | `\lstnewenvironment` with style `cnltx`: language [AlLaTeX]TeX, numbers=left, numberstyle=\tiny, xleftmargin=1em, numbersep=.75em, gobble=2, columns=fullflexible, breaklines, keepspaces, upquote, keyword colours; styles `cnltx-bibtex`, `cnltx-makeindex`, `bash` (cnltx-example.sty:296-384); languages `BibTeX` and `makeindex` by `\lstdefinelanguage` (cnltx-listings.sty:40, 227) |
| inline code | cnltx-example.sty:47-48 | `code.listings` | `\lstinline[style=cnltx-inline]`, `\codefont` = `\ttfamily` |
| source frame | cnltx-example.sty:38-39, 484-494; cnltx_en.tex:129-131 | `box.mdframed` | `framemethod=tikz`; backgroundcolor=cnltxbg, linecolor=cnltx, roundcorner=5pt, skipabove/below=.5\baselineskip; sample adds innerleftmargin=2em |
| side-by-side example | cnltx-example.sty:843-872 | `cols.minipage`, `fig.adjustbox` | two minipages of .45\columnwidth; the source box is captured with `adjustbox` |
| example separator, underline | cnltx-example.sty:116-117, 520 | `sp.rule`, `mark.ulem` | `\hrulefill`; `\uline` for `\default` |
| compiled examples | cnltx_en.tex:1057, 1142, 1174; cnltx-example.sty:653-677, 880-951 | `fig.graphicx` | `\includegraphics[page=n]` of a nested run, `max-pages`, `max-height`, `graphics=` keys; the nested run itself is the EXTERNAL blocker |
| figure float | cnltx_en.tex:1803-1824 | `fig.graphicx`, `cap.kernel` | `figure[htb]`, `\centering`, `\caption`, `\label{fig:titlepage}`; the drawing is content |
| caption look | cnltx-doc.cls:104-111, 218-220 | `cap.koma` | `\setcapindent{1.5em}`; caption font `\normalfont\small\sffamily`; label font + `\scshape` |
| table | cnltx_en.tex:2464-2536 | `tbl.tabular`, `tbl.booktabs`, `sp.ragged`, `cap.kernel` | `table`, `\renewcommand\arraystretch{1.3}`, columns `l >{\ttfamily}l >{\RaggedRight}p{.25\linewidth}` twice, `\toprule \midrule \bottomrule` |
| three-column lists | cnltx_en.tex:2923-2925, 2932-2934, 2941-2944 | `cols.multicol`, `font.size-commands`, `sp.ragged` | `multicols{3}`, `\small`, `\RaggedRight` |
| maths | cnltx_en.tex:38, 1074 | `math.amsmath` | `\usepackage{amsmath}`; inline `\text` |
| bibliography | cnltx-doc.cls:223-231; cnltx_en.tex:135, 2086-2095, 2116-2126; cnltx.bbx:28-36; cnltx.cbx:31; cnltx.dbx:29-49 | `bib.biblatex-biber` | backend=biber, style=cnltx, sortlocale=en_US, indexing=cite, `\addbibresource{cnltx.bib}`, `\AtEndDocument{\printbibliography}`; `\defbibheading{bibliography}[\bibname]{\section{#1}}`; the style `cnltx` (a clone of `alphabetic` with entry types package/class/bundle) ships in the bundle |
| index | cnltx-doc.cls:233-248; cnltx.ist:1-10; cnltx_en.tex:63 | `idx.makeidx` | `imakeidx`; `\indexsetup{othercode=\footnotesize,level=\section}` (sample), `\makeindex[columns=2,columnsep=1em,options={-s cnltx.ist}]`, `\printindex` at end of document |
| index-aware commands | cnltx_en.tex:164; cnltx-example.sty:40, 58-61 | `idx.makeidx` | `\newidxcmd\prg{\code{#1}}[ (program)]`; class commands `\cs` `\env` `\pkg` `\cls` are made the same way |
| logo glyph | cnltx_en.tex:180 | `font.icons` | `\hologo{BibTeX}` (where `hologo` gets loaded is not shown in the zip, probably through `libertinehologopatch`, cnltx-doc.cls:121) |

## Bespoke code
Sample-local items (all reducible):
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\cnltxhyphen`, `\cnltx@hyphen` | cnltx_en.tex:137-139 | yes | alias for `\penalty\@M-\hskip\z@skip` inside `\texorpdfstring`: `sp.penalties` (penalty family) + `sp.manual-space` (`\hskip`) + `meta.hyperref`; an emitter writes the three primitives or `\nobreak-\hskip0pt` |
| `\newpackagename` x7, `\newname` x6, `\newnote*` x2 | cnltx_en.tex:142-148, 150-151, 153-158 | yes | calls of class-native declarations with strings (`class.cnltx-doc` vocabulary); `\bypackage` is `\csname cnltx#1\endcsname` lookup, expandable to the seven fixed names |
| `\file` `\latin` `\PDF` `\BibTeX` aliases | cnltx_en.tex:163, 165, 167, 180 | yes | `\newcommand` aliases of class commands `\code`, `\cnltxlatin`, `\cnltxacronym` and of `\hologo` |
| `\at` `\bang` `\equal` | cnltx_en.tex:176-178 | yes | `\def` aliases of `\cnltxat` `\cnltxbang` `\cnltxequal` |
| `colors` environment with `\colour` | cnltx_en.tex:169-174 | yes | the class's `cnltxlist` (kernel `\list`, `list.kernel`) plus per-item `\item[]\code{\textcolor{c}{c}}\hfill\newline` (`color.xcolor`, `sp.manual-space`); the macro can be expanded per colour |
| `\newidxcmd\prg`, `\DeclareFixedFootnote\oberdiekfn` | cnltx_en.tex:164, 161 | yes | declarations of the two proposed ways |

Class-internal programming (cnltx-doc.cls, cnltx-example.sty, cnltx-base.sty, cnltx-tools.sty, cnltx-names.sty, cnltx.bbx): published as part of the CTAN bundle, so W1 holds and it is not counted as bespoke here. If the class were treated as zip-local, these would be `BESPOKE/class` (irreducible): the expl3-style argument expander (cnltx-base.sty:354-363), catcode test for `\cnltx@ifisnum` (cnltx-base.sty:237-247), token-list replacers (cnltx-base.sty:395-426), the expandable optional-argument `\newexpandablecmd` (cnltx-base.sty:451-509), the patch of listings' `\lst@NewLine` (cnltx-example.sty:387-391), the write-source-to-file-and-`\input` mechanism with `\lst@BeginAlsoWriteFile` (cnltx-example.sty:628-651, 702-721), the `\write18` runner (cnltx-example.sty:653-686), `\scantokens` in `\visualizespaces` (cnltx-doc.cls:652-661), the name parser (cnltx-names.sty:20-174), and the bib-file scanner built on `catchfile` (cnltx-listings.sty:1879-1965).

## Content-opaque
- TikZ `chains` schematic inside the figure at cnltx_en.tex:1803-1824 (`art.tikz`, figure artwork); `\usetikzlibrary{chains}` at cnltx_en.tex:40-41.
- Bodies of the executed `example` environments are arbitrary LaTeX shown as code and run as output, for example the counter-representation demos with a TikZ node (cnltx_en.tex:1320-1354), the punctuation demos (cnltx_en.tex:1235-1255) and the abbreviation demos (cnltx_en.tex:1494-1613).
- The three compiled sub-documents (cnltx_en.tex:1057-1068, 1142-1153, 1174-1185) are content of the demo; running them is the EXTERNAL blocker above.
- Lists generated from files at build time: `\listsilentcmds`, `\listsilentenvs`, `\listbibfileentries{cnltx.bib}` (cnltx_en.tex:2924, 2933, 2943); the 139 entries of cnltx.bib are data.

## Lib changes
- New ways proposed:
  - `fn.fixfoot` `fixfoot` (CTAN, TeX Live; David Carlisle and Robin Fairbairns, ctan.org/pkg/fixfoot), pdfLaTeX. `\DeclareFixedFootnote{\cmd}[n]{text}` defines a command that prints one footnote text once per page. W1 CTAN/TeX Live; W2 command name and text string; W3 any repeated note; W4 preamble declaration and a body command. Considered `fn.kernel` and `fn.bigfoot`; their lines name other packages and commands, so kept apart (a consolidator may fold it as `draft.todo` went into `draft.todo`).
  - `idx.makeidx` `idxcmds` (CTAN, listed with a CTAN URL at cnltx.bib:471-477), pdfLaTeX. `\newidxcmd\name{format}[suffix]` defines a command that both prints text and writes an index entry. W1 CTAN; W2 name, format code, suffix text; W3 any index entry command; W4 preamble declaration plus body use. Considered `idx.makeidx` (`makeidx`/`imakeidx`/`index` provide the index machinery, not command declarations); may be folded there.
  - `lang.translator` `translations` (CTAN, listed at cnltx.bib:939-945; a different package from `translator`, which has its own entry at cnltx.bib:946), pdfLaTeX. `\DeclareTranslation{Language}{key}{text}`, `\DeclareTranslationFallback`, `\GetTranslation{key}`, `\GetTranslationFor{Language}{key}`. W1 CTAN; W2 language, key and text strings; W3 any package's keyword strings; W4 preamble declarations and a body getter. Considered `lang.translator` (names the `translator` package and `\newtranslation`); may be folded there with the package as parameter.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes: biber and makeindex are the usual toolchain steps of `bib.biblatex-biber` and `idx.makeidx`, not counted as EXTERNAL. Class-internal packages without a separate way (`fnpct`, `pgfopts`, `etoolbox`, `ltxcmds`, `pdftexcmds`, `trimspaces`, `accsupp`, `catchfile`, `ifxetex`) are programming helpers or class-internal behaviour (cnltx-doc.cls:193; cnltx-base.sty:32, 748; cnltx-tools.sty:105-106; cnltx-listings.sty:1879; cnltx-example.sty:43). Nothing addressed to an AI was found in the zip.
