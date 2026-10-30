no

# 0236-hu-berlin-bundle: hu-berlin-bundle (unofficial Humboldt-Universität zu Berlin corporate-design letter class, with its .dtx manual)

- Unverified: read from the source, not compiled.
- Source: Source/0236-hu-berlin-bundle/ (origin: https://mirrors.ctan.org/macros/luatex/latex/hu-berlin-bundle.zip; licence: LPPL 1.3c, GPL 2, BSD 3-clause (manifest; the CTAN page agrees))
- Kind: letter
- Lib: v4
- Engine: needs LuaLaTeX (fontspec; the base style aborts with `\GenericError` when not LuaTeX, hu-berlin-bundle.dtx:782-795 and 1473-1481)
- Look carried by: mixed (the letter look is the CTAN class `hu-berlin-letter` over `scrlttr2`, dtx:843-1317; the manual look is a zip-local preamble package `hu-berlin-bundle-style`, dtx:1408-2097)
- Class origin: ctan
- Main file: hu-berlin-bundle.dtx (no `.tex`, `.cls` or `.sty` is present; everything is docstrip source in this one file. The only `\documentclass`/`\begin{document}` pairs are the manual driver at dtx:237-247 and the example letter at dtx:610-647. Other samples: the `.lco` data file at dtx:511-594 and the pandoc template at dtx:1328-1402)
- Read: main yes (all 2101 lines of the .dtx, plus README.md and makefile), zip-local classes and styles all (the code of `hu-berlin-letter.cls`, `hu-berlin-base.sty` and `hu-berlin-bundle-style.sty` is inside the .dtx, read in full; hu-berlin-bundle.pdf and img/texografie-logo.pdf not read)

## Verdict
The letter template proper reduces cleanly: it is the published CTAN class `hu-berlin-letter`, a thin layer over `scrlttr2` (CTAN page: in TeX Live and MiKTeX), and its code is `\setkomavar` fields, `\setplength` positions, `scrlayer` layers and `geometry`, all lib ways. The answer is still `no`, because the .dtx also carries its own manual driver, typeset through a zip-local preamble package that holds three kinds of blocker: a bibliography file produced by a Lua tool run from the makefile and PDFs and a template that need `pandoc` (EXTERNAL), a TikZ-drawn callout box (ART), and a patch of a KOMA internal macro (BESPOKE). Every blocker carries its scope, so a re-reader who scores only the letter class can drop them and would get `yes`.

## Blockers
- `EXTERNAL/preamble` `\addbibresource{\jobname-ctan.bib}`: that file is not shipped; the makefile builds it by running `ctanbib` (a Lua script that fetches CTAN data, ctan.org/pkg/ctanbib) once per package name, and the names come from `.pkglist`, which `\pkg` writes through `\newoutputstream` (dtx:1549, 1986-1995; makefile:6, 39-54, 74)
- `EXTERNAL/body` the "Example files" part includes `hu-berlin-letter-example-lualatex.pdf` and `hu-berlin-letter-example-markdown.pdf`, built by `latexmk` and `pandoc` from the makefile (dtx:451-473; makefile:33-37)
- `EXTERNAL/body` the markdown letter path: `hu-berlin-letter-template.latex` is a pandoc template full of `$if(..)$`/`$for(..)$` placeholders, and the documented command is `pandoc --pdf-engine=lualatex --template ...` (dtx:717, 1328-1402; makefile:33-34, 108-116)
- `ART/preamble` `warning` box: tcolorbox `underlay` holds raw TikZ `\path` code for a folded corner and a red square with a white "!" (dtx:1906-1928, TikZ at 1921-1925); `rounded corners=southeast`, `drop fuzzy shadow` and the colours alone do not draw them
- `BESPOKE/preamble` `\patchcmd{\scr@startchapter}{\if@openright\cleardoublepage\else\clearpage\fi}{}{}{}` edits a KOMA internal macro to delete the page-break conditional of `\chapter`, so chapters no longer start a page (effect inferred from the text, not compiled; dtx:2088-2091). No lib way removes a class's chapter page break (KOMA `open=any` only swaps `\cleardoublepage` for `\clearpage`)

## Class setting
- Class: `class.hu-berlin-letter` options: `english` | `ngerman` (default `ngerman`, dtx:855-859); any other option goes to `scrlttr2`; it loads `class.scrlttr2` with `fontsize=10pt,version=last` (dtx:863-872). The letter example loads it with no option (dtx:610)
- Class-native vocabulary used: `\LoadLetterOption` (dtx:614), `\setkomavar` and `\setkomavar*` for fromname, fromemail, fromphone, fromfax, fromurl, faculty, institute, institute.additional, institute.head, institute.head.mail, office, connections, accessibility, signature, myref, yourref, yourmail, customer, invoice, subject (dtx:517-640), the class-added komavars `faculty` `institute` `office` `connections` `officehours` `accessibility` `bank` `IBAN` `BIC` `nextlocation` (dtx:910, 974-1024), `\newkomavar` `\newkomafont` `\usekomafont` `\Ifkomavarempty`, `\setplength` `\addtoplength` `\useplength`, `\removereffields` (dtx:1216), body `letter` environment, `\opening` `\closing` `\ps` `\encl` `\cc` (dtx:651-695)
- Manual driver class: `\documentclass{ltxdoc}` (dtx:237, `class.ltxdoc`, TeX distribution, not read) with `\ReplaceClass{article}{scrbook}` and `\PassOptionsToClass{english,oneside}{scrbook}` from scrlfile (dtx:231-236), so the effective class is `class.scrbook`; its vocabulary used: `\KOMAoptions`, `\setkomafont` `\addtokomafont`, `\RedeclareSectionCommand(s)`, `\deffootnote`, `\setfootnoterule`, `\setcapindent`, `\partformat` `\partpagestyle`, `\sectionlinesformat`

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class (letter) | dtx:843-872 | `class.hu-berlin-letter` | options english/ngerman; loads `class.scrlttr2` fontsize=10pt, version=last |
| class (manual) | dtx:231-238 | `class.ltxdoc`, `class.scrbook` | english, oneside; `\ReplaceClass{article}{scrbook}` |
| letter fields, letterhead, location block | dtx:1029-1203, 1241-1292 | `ltr.opening` | `\setkomavar{location}` = `\raggedright`, `\fontsize{7}{8.5}`, `minipage[t][64mm]{\useplength{locwidth}}`, one bold label + value per non-empty field, `\vfill` before connections/officehours/accessibility/bank; firsthead = logo 145mm or fallback text; fromaddress, backaddress, date and label strings |
| letter option file | dtx:511-594 | `ltr.opening` | `.lco` of `\setkomavar` calls (name+position, mail, phone 1234, fax 5678, url, faculty, institute, head, office, connections, signature) |
| KOMA letter options and lengths | dtx:1207-1228 | `ltr.opening` | numericaldate=true, refline=nodate, backaddress=plain, parskip=half-; refvpos 110mm, refaftervskip 0pt, toaddrhpos 25mm, firstheadhpos=toaddrhpos, lochpos 15mm, locvpos=toaddrvpos+.75 baselineskip, locwidth 45mm, locheight 232mm |
| letter body | dtx:647-697 | `ltr.opening` | `letter{address}`, `\opening`, `\closing`, `\ps`, `\encl`, `\cc` |
| dummy text | dtx:643, 667-669 | `draft.todo` | `blindtext`, `\blindtext[2]` (filler content) |
| page geometry (letter) | dtx:919-930 | `page.geometry` | a4paper, left=25mm, bottom=16mm, foot=4mm, top=77mm, headheight=15pt, textwidth=117mm, marginparsep=0mm, marginparwidth=0mm |
| raggedness | dtx:934-935 | `sp.ragged` | `\raggedsignature`=`\raggedright`; body `\raggedright` |
| enclosure pushed down | dtx:939-941 | `sp.manual-space` | wrapper: `\vskip0ptplus1filll` before the class `\encl`; `\stopletter` set empty |
| page 2+ logo and location | dtx:885-915 | `hf.scrlayer-scrpage` | `\clearpairofpagestyles`; two foreground layers (`likefirstpage.head` mode=picture with `\putUL`; `likefirstpage.loc` align=r, hoffset=\paperwidth-lochpos); `\AddLayersToPageStyle{scrheadings}`; page mark at `\fontsize{7}{8.5}` |
| fonts (letter) | dtx:808-815, 824, 1015 | `font.fontspec`, `font.icons`, `fig.rotating` | `\setmainfont{TeX Gyre Heros}` (Verdana as a commented option at 819-821; ScalaSans as a commented option in the example at 619-621); `marvosym` `\Wheelchair` under `\reflectbox` |
| font sizes | dtx:975, 980, 1033-1034 | `font.size-commands` | faculty `\bfseries\fontsize{8.5}{10}`; institute `\fontsize{8.5}{10}`; location 7/8.5 |
| colours | dtx:828-833, 1602-1606 | `color.xcolor` | hu-berlin-blue 0,65,137; green 150,190,20; grey 169,169,169; brown 82,79,60; red 180,0,0 |
| language and caption names | dtx:800, 855-857, 946-970 | `lang.babel` | `babel[english,ngerman]`; `\providecaptionname` for 11 strings in english and ngerman (Kopie an, Anlage, Geschäftszeichen, ...) |
| graphics | dtx:804, 1241-1245 | `fig.graphicx` | `\includegraphics[width=145mm]{hu-berlin-logo.pdf}` inside `\IfFileExists` (logo not shipped) |
| page geometry (manual) | dtx:1437-1447 | `page.geometry` | a4paper, foot=2cm, inner/top/outer/bottom=3cm, marginparwidth=2cm, marginparsep=.5cm; earlier raw lengths at 1413-1416 are `page.setlength`; `\fullwidth` via calc at 1449-1450 |
| KOMA options (manual) | dtx:1452-1462, 1785 | `class.scrbook` | numbers=noenddot, footheight=20pt, headheight=29pt, captions=tableheading, toc=indentunnumbered |
| fonts (manual) | dtx:1486-1510 | `font.fontspec`, `font.libertine`, `sp.linespread`, `math.amssymb` | TeX Gyre Pagella (Numbers=OldStyle), Cursor mono, Adventor sans LetterSpace=.8; `libertine[mono=false]`; `\linespread{1.05}`; `amssymb` |
| micro-typography, ragged | dtx:1552-1553 | `sp.microtype`, `sp.ragged` | `ragged2e`, `microtype` (defaults) |
| widow and club control | dtx:1542-1544 | `sp.penalties` | `\clubpenalty`, `\widowpenalty`, `\displaywidowpenalty` = 10000 |
| lists | dtx:1527-1538 | `list.enumitem` | `\setlist{nosep,leftmargin=*}`; `\newlist{tabitemize}{itemize}{2}` with labels |
| margin notes | dtx:1516-1520, 1428 | `note.marginnote`, `note.marginpar` | `\marginfont` = rule + `\footnotesize` + hu-berlin-brown; `\normalmarginpar` |
| quotes | dtx:1522-1525, 1585 | `lang.csquotes` | german=guillemets, style=german; `\blockcquote` |
| headings and fonts | dtx:1686-1703 | `head.koma-fonts`, `cap.koma` | title sans+blue+bold flushleft; disposition brown sans bold `\large`; subtitle; pageheadfoot `\footnotesize` sans grey; caption `\scriptsize`, captionlabel bold sans; `\setcapindent{0pt}` |
| section numbers in margin | dtx:1678-1680 | `head.class-native` | `\sectionlinesformat`: `\makebox[0pt][r]{#3}#4` |
| contents list | dtx:250, 1773-1800 | `toc.kernel`, `toc.koma` | `\RedeclareSectionCommand` toc keys: tocraggedpagenumber, toclinefill, tocindent=0em, tocnumwidth=4em, part entry `\large\scshape`, chapter entry `\textbf` |
| header and footer (manual) | dtx:1619-1633 | `hf.scrlayer-scrpage`, `sp.rule` | markcase=noupper, footsepline=.5pt, autooneside=false, automark; rofoot `\thepage`, lofoot title + `\vrule` + subtitle, rohead, lohead; `\vrule` is bare |
| part page watermark | dtx:1637-1658 | `hf.scrlayer-scrpage` | `\DeclareNewLayer[background,textarea,addwidth,mode=picture]` with `\scalebox{50}` of `black!5`; `\DeclareNewPageStyleByLayers{part}`; `\addtokomafont{part}{\Huge\changedpartwidth}` |
| footnotes | dtx:1664-1672, 1975-1976 | `class.scrbook`, `fn.kernel` | `\deffootnote{0.0cm}{\normalparindent}{...}`, `\setfootnoterule{0pt}`; `\fnurl` = `\footnote` with a URL |
| page flow | dtx:1705, 2090 | `pg.flush` | `\raggedbottom` (the chapter patch is a blocker) |
| title page (manual) | dtx:1561-1598 | `front.titlepage-env`, `front.maketitle` | hand-laid `titlepage` in a `\newgeometry{left=3cm,right=3cm,top=1.5cm,bottom=2cm}`; 50pt blue name; `\vskip 10em`, `5em`; `\vfill`; logo 4cm |
| code listings | dtx:1707-1716, 1831-1870 | `code.listings` | `\lstset` basicstyle `\linespread{0.7}\ttfamily`, breaklines, breakatwhitespace; `\lstdefinestyle` with tabsize=4, `moredelim` pairs, `escapeinside`, showspaces, `upquote`, comment style; `\lstMakeShortInline` |
| boxes | dtx:1803-1822, 1877-1904 | `box.tcolorbox` | `example` box and `hu-berlinstyle`: colback blue!10, colframe blue, boxrule 0.7pt, sharp corners, enhanced jigsaw, fonttitle `\bfseries\sffamily\footnotesize` |
| listing boxes | dtx:1930-1971 | `code.tcblisting` | `\newtcblisting` `codetext` (auto counter, arc=6mm), `huberlincode`, `\DeclareTCBInputListing{\huberlinlisting}` |
| callout box | dtx:1906-1928 | `box.tcolorbox`, `art.tikz` | declarative part: left=5mm, colframe yellow!20!black, drop fuzzy shadow; the TikZ `underlay` is the ART blocker |
| manual hooks | dtx:1417-1418, 1429-1430, 1563-1564 | `dtx.doc` | `\PrintDescribeMacro`/`\PrintDescribeEnv`=`\@gobble`; `\MacrocodeTopsep`, `\MacroIndent=6mm`; `\MacroFont`, `\AltMacroFont`; `\DocInput` (dtx:446) |
| PDF metadata and links | dtx:1720-1747, 2069-2087 | `meta.hyperref`, `meta.hyperxmp`, `meta.bookmark`, `meta.url` | unicode, colorlinks, urlcolor hu-berlin-blue, linkcolor black, bookmarks* keys, pdfproducer; `\pdfstringdefDisableCommands` for 17 macros; `url` (dtx:1683) |
| cross-references | dtx:416, 1748-1755 | `xref.cleveref`, `xref.kernel` | `cleveref[sort,nameinlink,compress,ngerman,english]` inside `\AtBeginDocument`; `\label`, `\cref` |
| bibliography | dtx:1547-1549, 448 | `bib.biblatex-biber` | `biblatex`, two `\addbibresource` files, `\printbibliography`; the second file is the EXTERNAL blocker |
| included PDFs | dtx:455-461 | `pg.include-pdf` | `\includepdf[pagecommand,link,pages=-,nup=2x1,frame]` (the PDFs are EXTERNAL) |
| icons | dtx:1550 | `font.icons` | `ccicons` loaded (Creative Commons glyphs; no use seen) |
| inline marks | dtx:1990-1995, 2025-2050 | `mark.kernel`, `mark.case` | `\textbf`, `\texttt`, `\lowercase{\href..}`; `\marg` `\oarg` with `\textcolor` braces |
| figure with tree | dtx:418-438 | `fig.graphicx`, `cap.koma` | `figure[!htb]` + `\caption` + `\label`; content is a `\dirtree` (see Content-opaque) |
| page break | dtx:410, 668 | `pg.break` | `\clearpage` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\patchcmd{\scr@startchapter}` | dtx:2090 | no | BESPOKE/preamble; patches a KOMA internal, no declarative equivalent |
| `warning` underlay TikZ | dtx:1921-1925 | no | ART/preamble; free drawing |
| `\pkg` with `\newoutputstream` write | dtx:1986-1995, 248 | page effect yes, side effect no | page effect = `\href` + `\textbf` + `\cite`; the `.pkglist` write feeds the EXTERNAL `ctanbib` step |
| `\renewcommand*{\maketitle}` (copy of scrartcl code) | dtx:1569-1598 | yes | hand-laid `titlepage`; `\setparsizes{\z@}{\z@}{\z@\@plus 1fil}` maps to `sp.lengths` (`\parindent`, `\parskip` 0pt, `\parfillskip`); `\global\@topnum=\z@` needs no float here |
| `\lst@visiblespace` override | dtx:1827 | yes | `\lstset{literate={ }{{\textcolor{hu-berlin-grey}{$\cdot$}}}1}` (public `code.listings` key; glyph metrics may differ) |
| part watermark: `\partnumber`, `\partformat`, layer `partnumber` | dtx:1637-1649 | yes | one background layer printing `\thepart` on the `part` page style; the global macro hand-off is not needed |
| `\changedpartwidth` | dtx:1652-1658 | yes | `\makebox`/`\parbox{\dimexpr..}` wrapper (`box.minipage`, `sp.manual-space`) |
| `\normalparindent` + `\deffootnote` | dtx:1664-1671 | yes | `\setlength` at begin document (`sp.lengths`) and KOMA `\deffootnote` |
| `\encl` wrapper, `\stopletter` | dtx:939-941 | yes | `\renewcommand\encl[1]{\vspace{0pt plus 1filll}\enclold{#1}}`; empty hook |
| location field with `\Ifkomavarempty` | dtx:1029-1203 | yes | a fixed block of published KOMA commands and the published `\Ifkomavarempty` test; no counter, box algorithm or output routine; inside the published class it is not zip-local |
| `\IfFileExists` logo fallback | dtx:1241-1245 | yes | emit the `\includegraphics` branch and ship the logo (not shipped, note below) |
| class and package option plumbing | dtx:855-859, 231-236 | yes | class options; `\ReplaceClass{article}{scrbook}` = `class.scrbook` + `dtx.doc` |
| aliases `\huberlin`, `\huberlinFolder`, `\TeXografie`, `\tocpageseparator`, `\tocpagenumberbox`, `\tocgobble`, `\fnurl`, `\env`, `\param`, `\cmd`, `\meta`, `\marg`, `\oarg` | dtx:1758-1770, 1782-1784, 1975-1976, 2022-2066 | yes | inline expansion into fonts, colours, `\footnote`, `\url` |
| engine guard `\GenericError`, `\directlua` fix | dtx:786-795, 1474-1481 | n/a | prints nothing; recorded as Engine |

## Content-opaque
- `\dirtree` file-tree diagram in a figure (dtx:420-435), restyled by `\DTstyle`/`\DTstylecomment` (dtx:1609-1617); considered `art.content-package`
- the introduction chapter is Markdown text inside `markdown*{hybrid=true}` (dtx:253-409), loaded as `markdown[tightLists=false]` with a `link` renderer prototype (dtx:2093-2096); the text is content, the package has no look of its own, and no lib way is proposed (considered: `markdown`)
- filler text `\blindtext`, the Hoare bib entry (dtx:94-111), the `texografie-logo.pdf` image (dtx:1593)

## Lib changes
- New ways proposed: none (considered: `scrlayer` as its own way, kept inside `hf.scrlayer-scrpage` because `scrlayer-scrpage` loads it and its layer commands build the page styles; `markdown`, kept as content; `xspace` and `ifluatex`/`luatex85`/`luatexbase`, load-only helpers like the rejected `sys.compat-load`)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes
- Missing assets: `hu-berlin-logo.pdf` (the real logo, withheld for copyright, README.md:84-87; the class falls back to text), optional fonts Verdana and ScalaSans, `hu-berlin-bundle-ctan.bib` and `hu-berlin-bundle-bibliography.bib` (the latter is docstrip-extracted from dtx:94-111).
- `hu-berlin-bundle-style` is not named on the CTAN page and serves only this manual, so it is treated as zip-local (W3 fails); the class and base style are published.
- The `hyperref` block in the class is commented out (dtx:1295-1311) and not counted.
- Whether the `markdown` package needs `--shell-escape` here is not established by reading (the makefile passes it, makefile:70, 76).
