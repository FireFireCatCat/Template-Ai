yes

# 0234-chletter: chletter, a Swiss letter class (SN 010130 letterhead)

- Unverified: read from the source, not compiled.
- Source: Source/0234-chletter/ (origin: https://mirrors.ctan.org/macros/latex/contrib/chletter.zip; licence: lppl1.3c, LPPL 1.3c per README:25 and chletter.ins:2-8)
- Kind: letter
- Lib: v2
- Engine: pdfLaTeX-compatible (kernel macros and `size1x.clo` only, chletter.dtx:762; the documentation driver loads `hypdoc`, which loads hyperref; no fontspec, no Lua)
- Look carried by: class (the letterhead, letter commands, page styles and spacing are all inside the published class `chletter`, chletter.dtx:691-1600; the sample letters add only content and the class's own commands)
- Class origin: ctan (ctan.org/pkg/chletter: "a class for typesetting letters to Swiss rules", author Boris Oriet, LPPL 1.3c, in TeX Live; the zip is that CTAN release, a `.dtx` + `.ins` + PDF with no ready `.cls`)
- Main file: chletter.dtx (no standalone `.tex`. The documentation driver is chletter.dtx:21-36 under `ltxdoc`; the letter template `chlettmp.tex` is embedded at chletter.dtx:1618-1647; two usage letters are shown at chletter.dtx:108-123 and 168-193) (other samples: none)
- Read: main yes (all 1656 lines of chletter.dtx, README, chletter.ins), zip-local classes and styles all (the class source is the unprefixed code of chletter.dtx:690-1600; chletter.pdf is the compiled manual and was not read, pdftoppm is not installed; the dtx is its source)

## Verdict
The look of every letter is carried by the published CTAN class `chletter`, so the zip reduces to `class.chletter` with its four own options plus the class's letter commands, and the sample letters (chletter.dtx:1622-1644, 108-123, 168-193) use nothing else. The documentation driver is `ltxdoc` + `hypdoc` + kernel constructs, all lib ways; its only drawings are `picture` diagrams inside figure floats, which are content. There is no zip-local macro logic and no template-defining artwork. The class's own code redefines kernel internals (see Bespoke code), so this `yes` rests on W1: the class is published, not zip-local. A reader who treats a class shipped as its own `.dtx` as zip-local would get `no` with `BESPOKE/class` at chletter.dtx:1028-1061, 1082-1094.

## Blockers
none

## Class setting
- Class: `class.chletter` options: `a4paper`, `10pt` by default (chletter.dtx:755); inherited standard options `a4paper a5paper b5paper letterpaper legalpaper executivepaper landscape 10pt 11pt 12pt oneside twoside draft final leqno fleqn onecolumn twocolumn` (chletter.dtx:710-728); class-specific `leftwin leftsig foldmark footfill` (chletter.dtx:729-732; documented at 312-319). The sample at chletter.dtx:168 uses `[leftwin,leftsig,foldmark,footfill]`, the template at 1622 uses none.
- Class-native vocabulary used: markup `\author` `\address` `\date` `\telephone` `\name` `\location` `\return` `\signature` `\title` (chletter.dtx:985-990, 1626-1629, 174-180); environment `letter` with optional `[i]`/`[n]` and the recipient address `{Name\\Address\\City}` (1082-1094, 1632); `\opening` `\closing` `\encl` `\cc` `\ps` `\object` (1135-1191, 184-190, 1634-1641); `\makelabels` (1005-1009, 172); stored values `\toname` `\fromname` `\fromsig` `\fromlocation` `\salutation` `\valediction` (1365-1398, 185); lengths `\titlehead` `\titletopheight` `\titlemidheight` `\titlebotheight` `\titlemargin` `\titlewidth` `\addressmargin` `\addresswidth` `\longindentation` `\indentedwidth` (795-808, 892-928); page styles `plain` `firstpage` `headings` `myheadings` (938-963); hooks `\titletopmatter` `\titlemidmatter` `\titlebotmatter` `\closingmatter` `\foldmark` `\footfill` (1479-1498, 1529-1548, 1558-1571).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | chletter.dtx:694-695, 1622, 108, 168 | `class.chletter` | options `leftwin` (recipient left of letterhead, 1479-1488), `leftsig` (signature at body margin, 1529-1537), `foldmark` (thin fold rule `\hrule\@width6\fboxsep\@height\fboxrule`, 1558-1559), `footfill` (`\footfill` = `1fill`, 1570-1571) |
| paper and type size | chletter.dtx:710-720, 755, 762 | `page.class-options` | `a4paper` default, `10pt` default; `11pt` `12pt` through `size1x.clo` |
| text block (class defaults) | chletter.dtx:834-871 | `page.setlength` | `\headheight12pt \headsep24pt \footskip36pt \oddsidemargin36pt \evensidemargin0pt \topmargin0pt \marginparwidth48pt`; `\textwidth` = paper width minus 9536004sp minus 36pt, `\textheight` = paper height minus 14093310sp (847-855). Set inside the class; a user overrides with raw lengths (documented 326-339, not done in any sample) |
| letterhead (three strips) | chletter.dtx:795-808, 892-928, 1028-1061, 1479-1498, 1514-1516 | `front.class-native` | `\titlehead12pt`, `\titletopheight=\titlemidheight=\titlebotheight=72pt`, `\titlemargin0pt`, `\titlewidth` = text width + 36pt, `\addresswidth190pt` (`\addressmargin` computed); fields `\fromlocation \fromname \fromaddress \telephonenum \@date` top, `\returnaddress \toname \toaddress` mid |
| letterhead length override in sample | chletter.dtx:170 | `front.class-native` | `\addresswidth` set with kernel `\settowidth{\today}` (a length assignment, `sp.lengths`) |
| letter environment, opening, closing | chletter.dtx:1082-1094, 1105-1106, 1135-1140, 1152-1158, 1169-1174, 1522-1548 | `ltr.opening` | `letter[n or i]{address}`, `\opening{salutation}`, `\closing{valediction}` (4 bigskip above and 2 below the signature), `\object`, `\signature`, `[i]` keeps `\parindent` |
| letter foot | chletter.dtx:1189-1191, 1640-1641, 188-190 | `ltr.opening` | `\ps{label}{text}`, `\encl{}`, `\cc{}`: one-item `list`, label words `\enclname=encl`, `\ccname=cc` (1414-1415) |
| cover page | chletter.dtx:1005-1009, 1105-1106, 172 | `ltr.opening` | `\makelabels` sets `\startlabels`, a second `\maketitle` page at `\endletter` with return address and recipient |
| page-break control | chletter.dtx:1118-1119 | `sp.penalties` | `\interlinepenalty\@M` and `\nobreak` in `\stopbreaks`, `\interlinepenalty100` in `\startbreaks`; used by `\closing` (1157) |
| page styles | chletter.dtx:938-963, 1090, 1106, 1456 | `hf.class-native` | `plain`: foot `\footnotesize\hfil Page n`; `firstpage` for the letterhead page; `headings`: head `To <toname> ... Page n`; `myheadings` |
| page style switching | chletter.dtx:1456, 1090 | `hf.pagestyle-kernel` | `\pagestyle{plain}`, `\thispagestyle{firstpage}`, `\thispagestyle{empty}` |
| page numbers | chletter.dtx:1457, 1091 | `pgnum.pagenumbering` | `arabic`; the `letter` environment resets `page` to 1 (`\global\c@page\@ne`) and `footnote` to 0 |
| paragraph spacing | chletter.dtx:818-823, 1304-1307 | `sp.lengths` | `\parskip9pt \parindent18pt \normallineskip0pt \labelsep6pt \labelwidth12pt \leftmargin18pt \topsep0pt \partopsep3pt \itemsep0pt \parsep3pt` |
| footnotes | chletter.dtx:876-877, 1344 | `fn.kernel` | `\footnotesep12pt`, `\skip\footins12pt`, `\@makefntext` as a zero-width hanging mark |
| sectioning commands | chletter.dtx:1203-1207 | `head.class-native` | unnumbered bold lines, no counters, no toc; `\section`=medskip+bold, `\paragraph`/`\subparagraph` run-in. Defined by the class, not used by any sample |
| list environments | chletter.dtx:1217-1224, 1259-1287 | `list.kernel` | `description` bold label; `itemize` bullets `\textbullet \textendash \textasteriskcentered \textperiodcentered`; `enumerate` labels `1.` `(a)` `i.` `A.`; all `\@listI` empty |
| quote, quotation, verse | chletter.dtx:1227-1249 | `quote.kernel` | `\rightmargin\leftmargin`, `\listparindent\parindent` |
| date | chletter.dtx:1431-1435, 1629 | `ltr.opening` | `\date{My location, \today}`; `\today` is an English default redefinition, adjusted by a language package |
| language words | chletter.dtx:1414-1417, 1408-1411 | `lang.babel` | `\ccname \enclname \pagename \headtoname` English defaults, overridable by babel; the template loads none (`chextras` line is a comment, 1624) |
| two-column mode | chletter.dtx:727-728, 1040, 1446, 1581-1582 | `cols.twocolumn-option` | option `twocolumn` (sets `leftsig`, `\columnsep36pt`, `\sloppy`) |
| equation numbering | chletter.dtx:725-726, 1323 | `math.eqnumber` | options `leqno`, `fleqn`; `\theequation` arabic |
| legacy font switches | chletter.dtx:1590-1596 | `mark.kernel` | `\DeclareOldFontCommand` for `\rm \sf \tt \bf \it \sl \sc` |
| documentation class | chletter.dtx:23 | `class.ltxdoc` | `a4paper` |
| documentation driver | chletter.dtx:24, 32, 34, 39-59, 675, 1652-1653 | `dtx.doc` | `hypdoc` loaded, `\CodelineIndex`, `\DocInput{chletter.dtx}`, `\CheckSum{1057}`, `\CharacterTable`, `\changes`, `\StopEventually`, `\Finale`, `\PrintIndex` (index by the standard makeindex run) |
| documentation macro markup | chletter.dtx:312-315, 422, 690-692, 700-737 | `dtx.doc` | `macrocode`, `macro`, `environment`, `\DescribeMacro`, `\DescribeEnv`, docstrip guards `%<*chletter.cls>` |
| driver link and print hooks | chletter.dtx:25-29 | `meta.hyperref` | `\pdfstringdefDisableCommands{\def\url{}}`; the two `\let\PrintMacroName`/`\PrintDescribeMacro` lines restore hypdoc's saved originals (`dtx.doc` print hooks) |
| driver lengths | chletter.dtx:30-31 | `sp.lengths` | `\parindent0pt`, `\unitlength.59pt` (for the `picture` figures) |
| manual title block | chletter.dtx:61-64 | `front.maketitle` | `\title{... \thanks{...}}` (`front.thanks`), `\author{Boris \textsc{Oriet}\\\url{...}}` (`mark.kernel`, `meta.url`), `\maketitle` |
| manual toc, headings | chletter.dtx:66, 69, 86, 94 | `toc.kernel` | `\tableofcontents`; `\section`..`\subsubsection` from `ltxdoc` (`head.kernel`) |
| manual spacing and breaks | chletter.dtx:65, 67, 96, 242 | `sp.manual-space` | `\bigskip`, `\medskip`; `\pagebreak` is `pg.break` |
| manual code listings | chletter.dtx:107-123, 167-193 | `code.verbatim` | `verbatim` and the `\|...\|` short verb of `ltxdoc` |
| manual itemize | chletter.dtx:577-581 | `list.kernel` | `\item[---]` |
| manual figures | chletter.dtx:125-144, 195-228, 230-242, 368-412 | `fig.graphicx` | kernel `figure` float, no `\includegraphics`; caption by kernel `\caption` (`cap.kernel`) |
| manual figure artwork | chletter.dtx:126-142, 196-226, 231-240, 369-410 | `art.pstricks` | `picture` environment, `\put \multiput \line \vector \framebox \makebox`: content inside a float, not template look |
| manual counter | chletter.dtx:1607 | `num.counters` | `\setcounter{CodelineNo}{0}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| chletter.cls source (`\maketitle`, `\@maketitle`, `letter` environment via `\futurelet`, `\ps@*`, `\@makefntext`, `\splitfield`) | chletter.dtx:691-1600 | n/a, published | Not bespoke: the class is on CTAN and in TeX Live, W1 holds, so the whole look is `class.chletter` with its options. Would be irreducible if the class were zip-local (kernel-internal redefinitions at 1028-1061, 1082-1094, 1105-1106, 938-963, 1344) |
| `\let\PrintMacroName\HDorg@PrintMacroName`, `\let\PrintDescribeMacro\HDorg@PrintDescribeMacro` | chletter.dtx:26-29 | yes | Alias lines that restore the doc package's own macro-name print hooks after `hypdoc`; effect is a `dtx.doc` setting, no layout logic. Documentation driver only, not the letter look |
| `\pdfstringdefDisableCommands{\def\url{}}` | chletter.dtx:25 | yes | hyperref command with an empty definition (`meta.hyperref`) |
| compatibility aliases `\newcommand\conc`, `\let\letterindent\parindent`, ... | chletter.dtx:274-279 | yes | Shown inside a `verbatim` block, never executed; plain `\let`/`\newcommand` aliases of class-native names |
| DocStrip install script | chletter.ins:1-62 | yes | `\input docstrip`, `\generate` of `chletter.cls` and `chlettmp.tex` from the dtx; runs inside TeX, defines no look |

## Content-opaque
- `picture` diagrams inside figure floats: chletter.dtx:125-144, 195-228, 230-242, 368-412 (letter-layout drawings with arrows and dimensions)
- the `verbatim` example letters and macro listings: chletter.dtx:107-123, 167-193, 273-280, 334-339, 357-366 (code text)

## Lib changes
- New ways proposed: none (considered: `hypdoc`, folded into `dtx.doc` as a load-only add-on of the doc package family; considered: `chextras`, only named in a comment at chletter.dtx:1624, not loaded)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
