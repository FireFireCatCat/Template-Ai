yes

# 0913-ceur-ws: CEURART (CEUR Workshop Proceedings article class, v0.5.3 of 2024-12-18)

- Unverified: read from the source, not compiled.
- Source: Source/0913-ceur-ws/ (origin: https://ceur-ws.org/Vol-XXX/CEURART.zip; licence: not established in the manifest; the class header states LPPL 1.3 (ceurart.cls:4-10) and the bst the Elsarticle bundle LPPL (elsarticle-num-names.bst:9-14))
- Kind: conference
- Lib: v6
- Engine: pdfLaTeX-compatible (the class branches on `\ifpdftex` at ceurart.cls:101 and :2933; its Makefile builds with lualatex, Makefile:2)
- Look carried by: class (ceurart.cls carries the page, front matter, abstract, floats and fonts; the sample adds only `\sloppy`, `listings` and content, sample-1col.tex:13-20)
- Class origin: publisher-official (the zip is CEUR-WS.org's own template kit; ceurart.cls:2 names CEUR-WS.org as copyright holder; `https://ctan.org/pkg/ceurart` returned 404, so the class is not on CTAN)
- Main file: sample-1col.tex (other samples: none; Deprecated/sample-2col.tex~ is a backup file, not read)
- Read: main yes, zip-local classes and styles all (ceurart.cls lines 1-2997; no other .cls/.sty; elsarticle-num-names.bst header only, it is a parameter of `bib.bibtex-bst`)

## Verdict
yes. The look is carried by the publisher's own class `ceurart`, which is a published class by the rubric's ruling on official kits, so it is one way `class.ceurart`; the sample adds only content, `\sloppy` and `listings` (sample-1col.tex:13-20), and every component it uses maps to a lib way. No ART, no EXTERNAL (pdfx, doclicense and the `.abs`/`.xmpdata` files are TeX-only; no minted or shell escape is loaded). The yes depends on that ruling: the class internals are hand-written expl3 (aux-file round trips, a redefined `\maketitle`) and are listed under "Bespoke code" as scope `class` only for a re-read that would treat the class as zip-local, which would give no. The emitter must ship the unmodified class, since it is not on CTAN.

## Blockers
none

## Class setting
- Class: `class.ceurart` options: none used (`twocolumn` and `hf` are commented out, sample-1col.tex:7-8). The class declares `twocolumn`, `hf`, `singleblind`, `doubleblind`, `longmktitle`, `final`, `review` (ceurart.cls:64-72) and passes every other option to `scrartcl` (ceurart.cls:76), after `a4paper,twoside=false` (ceurart.cls:77). It loads `scrartcl` (ceurart.cls:79), then `\KOMAoptions{DIV=10}` and `fontsize=11pt` (9pt with twocolumn) (ceurart.cls:80-85).
- Class-native vocabulary used: `\copyrightyear`, `\copyrightclause` (sample-1col.tex:29-32), `\conference` (:36), `\title` (:41), `\tnotemark`, `\tnotetext` (:43-45), `\author[aff]{name}[orcid, email, url]` (:50-54), `\cormark`, `\fnmark` (:55-56), `\address[n]{}` (:57), `\cortext`, `\fntext` (:79-80), `abstract` (:85), `keywords` with `\sep` (:97-102), `\maketitle` (:107), `acknowledgments` (:565), `table*` and `figure` with the class's own float and caption look (:372, :465).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | sample-1col.tex:6-9; ceurart.cls:79 | `class.ceurart` | no options; underlying `scrartcl` (considered: `class.scrartcl`), a4paper, twoside=false, DIV=10, fontsize=11pt |
| paper and size | ceurart.cls:77, :81-85 | `page.class-options` | a4paper, fontsize=11pt (9pt under twocolumn) |
| text area | ceurart.cls:80 | `page.typearea` | DIV=10 (then overridden by geometry below) |
| page geometry | ceurart.cls:2975-2985 | `page.geometry` | a4paper, twoside=false, vmargin=1cm, hmargin=1in, centering, columnsep=2pc, heightrounded, includeheadfoot |
| header and footer | ceurart.cls:2297-2300 | `hf.scrlayer-scrpage` | `\clearpairofpagestyles`; `\setkomafont{pageheadfoot}{\sffamily\small}`; empty by default |
| header and footer option `hf` | ceurart.cls:2303-2311 | `hf.class-native` | headsepline; `\cfoot` page; `\ohead` first--last page; `\ihead` short authors + CEUR Workshop Proceedings; not used by the sample |
| page number total | ceurart.cls:2284-2289 | `pgnum.lastpage` | class writes `\lastpage` to the aux at end of document (only read under `hf`) |
| first-page style | ceurart.cls:304 | `hf.pagestyle-kernel` | `\thispagestyle{plain}` |
| main text face | ceurart.cls:2938-2941 | `font.libertine` | `libertinus` (message only if missing, :2942) |
| encoding | ceurart.cls:2933-2935 | `font.fontenc-t1` | `[T1]{fontenc}` under pdfTeX |
| PDF text map | ceurart.cls:101-103 | `meta.glyphtounicode` | `cmap` under pdfTeX |
| microtype | ceurart.cls:97 | `sp.microtype` | defaults |
| old font commands | ceurart.cls:2963-2969 | `mark.kernel` | `\rm \sf \tt \bf \it \sl \sc` via `\DeclareOldFontCommand` |
| icons | ceurart.cls:218-228, :765, :782, :813 | `font.icons` | `fontawesome5`; `\faIcon{envelope-open,globe,orcid}` in first-page notes; text fallback when absent |
| colour | ceurart.cls:95, :186-187 | `color.xcolor` | `[svgnames,dvipsnames]`; `\colorlet{scolor}{black}`, `\colorlet{hscolor}{DarkSlateGrey}` |
| PDF/A and XMP | ceurart.cls:167, :234-247, :370-383 | `meta.pdfx` | `[useBOM,pdf17,a-1a]{pdfx}`; class writes `\jobname.xmpdata` (Title, Author, Keywords, Subject, Copyright, Journaltitle, Journalnumber) |
| link setup | ceurart.cls:170-177, :389-403 | `meta.hyperref` | `[unicode]` fallback; `colorlinks, bookmarksnumbered, pdfencoding=unicode, allcolors=DarkSlateGrey` |
| URL style | ceurart.cls:185 | `meta.url` | `\urlstyle{rm}` |
| hyphenation | sample-1col.tex:13 | `sp.hyphenat` | `\sloppy` |
| title | ceurart.cls:425-439, :516-539 | `front.class-native` | `\title[mode=title]`: `\LARGE`, `\sffamily`, `\bfseries`, black, `\raggedright`; other modes `alt` `sub` `trans` `transsub` `ascii` (:440-489) |
| title note marks | ceurart.cls:500-514, :854-917 | `front.class-native` | `\tnotemark[n]` prints `$^\star$`; `\tnotetext` as a footnote |
| authors | ceurart.cls:1138-1148, :1298-1425 | `front.class-native` | `\large`, `\raggedright`, `\bigskipamount` above; first name `black!50`, surname black (:1328-1330); affiliation numbers `\textsuperscript{\itshape}` (:1339); keys auid, prefix, suffix, degree, role, orcid, email, url (:1084-1110) |
| affiliations | ceurart.cls:1528-1564, :1625-1632 | `front.class-native` | `\address[n]{}`; `\footnotesize`, `\itshape`, `\raggedright` |
| author notes | ceurart.cls:942-1017 | `front.class-native` | `\fntext` marks dagger, ddagger, section, pilcrow, parallel; `\cortext` asterisks |
| first-page footnotes | ceurart.cls:1963-1992, :752-818 | `front.class-native` | order: conference, title notes, corresponding, footnotes, address, emails, urls, ORCID, copyright; email, url, ORCID lines with icons |
| conference line | ceurart.cls:272-274, :287 | `front.class-native` | `\conference{}` printed `\itshape` as an unnumbered note |
| copyright note | ceurart.cls:1864-1870, :1900-1912, :288 | `front.class-native` | `\copyrightyear`, `\copyrightclause`; `\tiny` text beside a logo in two `minipage`s, logo width 3.5em (:1879) |
| licence logo and text | ceurart.cls:1875, :1901, :1908 | `front.doclicense` | `[type={CC},modifier={by},version={4.0},imageposition=left]`; `\doclicenseImage[imagewidth=...]`, `\doclicenseText` |
| quote package | ceurart.cls:1874 | `lang.csquotes` | loaded for doclicense; no call in sample |
| title block assembly | ceurart.cls:286-322, :2113-2140 | `front.class-native` | `\maketitle` redefined: title, authors `\normalsize`, affiliations `\footnotesize\itshape`, abstract box, two rules via `\dashrule` |
| abstract | ceurart.cls:1731-1763, :1776-1780 | `abs.class-native` | heading `\textbf{\sffamily Abstract}` (:1753), `\leftskip=.1\textwidth` (:1740), `\footnotesize`, `\parindent=0` then `\everypar{\parindent=1.5em}` (:1757); text captured to `\jobname.abs` |
| keywords | ceurart.cls:1834-1850, :1817 | `abs.keywords` | heading "Keywords" `\textbf{\sffamily}`, width `.9\textwidth`, `\footnotesize`, `\sep` prints ", " |
| headings | ceurart.cls:2224-2225, :2239-2272 | `head.class-native` | KOMA `scrartcl` section look kept (the `\renewcommand\section` blocks are commented out, :2241-2269); number then "." then `\hskip 0.5em` (:2225) |
| heading counters | ceurart.cls:2271-2272 | `num.counters` | `\thesubsection` = `\thesection.\arabic{subsection}`, same for subsubsection |
| first paragraph indent | ceurart.cls:2239 | `head.kernel` | `\AtBeginDocument{\global\@afterindentfalse}` |
| starred sections | sample-1col.tex:575; ceurart.cls:1857 | `head.kernel` | `\section*{Declaration on Generative AI}`; acknowledgments env opens `\section*{Acknowledgments}` |
| acknowledgments | ceurart.cls:1854-1859; sample-1col.tex:565-570 | `front.class-native` | `acknowledgments` environment |
| appendix | sample-1col.tex:589 | `num.appendix` | `\appendix` |
| lists | ceurart.cls:2771-2819; sample-1col.tex:127, :247 | `list.kernel` | `itemize`, `enumerate` called plain; the class redefines both (spacing and label code, see Bespoke code) |
| footnotes | ceurart.cls:94; sample-1col.tex:165 | `fn.footmisc` | `[hang,flushmargin]`; `\footnote` is `fn.kernel` |
| inline and display maths | ceurart.cls:88-89; sample-1col.tex:427, :444, :450 | `math.amsmath` | `amsmath`, `\allowdisplaybreaks`; `equation`, `displaymath`, `math` |
| maths symbols | ceurart.cls:88 | `math.amssymb` | `amsfonts`, `amssymb` |
| figures | ceurart.cls:87, :2524-2535; sample-1col.tex:465-469 | `fig.graphicx` | `figure` with `\centering`, `\includegraphics[width=\linewidth-80pt]` (a `calc` expression) |
| length expressions | ceurart.cls:1916; sample-1col.tex:467 | `sp.lengths` | `calc` loaded; `\linewidth-80pt` |
| float placement | ceurart.cls:2395-2406 | `fig.placement` | topfraction .9, bottomfraction .9, topnumber 4, bottomnumber 3, totalnumber 5, textfraction .1, floatpagefraction .9, dbltopnumber 2, dbltopfraction .9, dblfloatpagefraction .95 |
| figure captions | ceurart.cls:2491-2499; sample-1col.tex:468 | `cap.kernel` | `\caption` below; class `\@makecaption`: `\sffamily\small`, bold label then colon, `\parbox` of `\linewidth` |
| tables | sample-1col.tex:372-385, :396-408; ceurart.cls:2458-2486 | `tbl.tabular` | `table`, `table*`, `tabular{ccl}`; body `\sffamily\small`, centred; `\newcolumntype{L,R,C}` with `@{\extracolsep{\fill}}` (:2408-2410) |
| table rules | ceurart.cls:92; sample-1col.tex:376-383 | `tbl.booktabs` | `\toprule \midrule \bottomrule` |
| table packages loaded | ceurart.cls:92 | `tbl.multirow` | `makecell`, `multirow`; no call in sample |
| table colour | ceurart.cls:92 | `tbl.colortbl` | `colortbl`; no call in sample |
| decimal columns | ceurart.cls:92 | `tbl.siunitx` | `dcolumn`; no call in sample |
| table captions | ceurart.cls:2419-2433; sample-1col.tex:373, :397 | `cap.kernel` | caption above, `\sffamily\small`, bold label on its own line, then text, `\parbox` of table width |
| wide floats | ceurart.cls:92 | `cols.cuted` | `stfloats`; matters for `table*` under `twocolumn` |
| column balance | ceurart.cls:91 | `cols.balance` | `balance` loaded; load-only, only twocolumn matters |
| wrapped figures | ceurart.cls:2555 | `fig.wrapfig` | `wrapfig`; used only by `\bio`, not by the sample |
| theorem-like (class-defined) | ceurart.cls:2826-2912 | `thm.class-native` | `\newdefinition`, `\newproof`, `\qed`; not used by the sample |
| verbatim | sample-1col.tex:119, :140-142; ceurart.cls:1724 | `code.verbatim` | `\verb`, `verbatim`; `moreverb` loaded (same type) |
| listings | sample-1col.tex:18-20, :158-160 | `code.listings` | `\lstset{breaklines=true}`; `lstlisting` |
| line break | sample-1col.tex:576-580 | `sp.manual-space` | `\newline` |
| inline marks | sample-1col.tex:121, :357, :580 | `mark.kernel` | `\itshape`, `\em`, `\textit` |
| cross references | sample-1col.tex:368, :374 | `xref.kernel` | `\label`, `\ref` |
| links | sample-1col.tex:354, :596 | `meta.hyperref` | `\url`, `\href` (colour `DarkSlateGrey`) |
| citations | ceurart.cls:2923-2924; sample-1col.tex:424, :499 | `bib.natbib` | `[numbers]`, `\bibsep=0pt` at begin document; sample uses `\cite` |
| bibliography | ceurart.cls:2926; sample-1col.tex:585 | `bib.bibtex-bst` | `\bibliographystyle{elsarticle-num-names}` (Elsevier's published bst, unmodified header at elsarticle-num-names.bst:1-18); `\bibliography{sample-ceur}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| the class `ceurart` as a whole | ceurart.cls:1-2997 | published (official kit), so a way, not bespoke | `class.ceurart`, shipped unchanged |
| `\sloppy`, `listings`, `\lstset` | sample-1col.tex:13, :18, :20 | yes | `sp.hyphenat`; `code.listings` with breaklines=true |
| macros or environments defined in the sample | none | n/a | the sample defines none |
| Informational, scope class (inside the published class way; would count only if the class were zip-local): | | | |
| aux-file round trip of authors, affiliation marks, emails, ORCID, notes (`\wrAux`, `\NewLabel`, `\csxdef`) | ceurart.cls:547-610, :752-818, :1298-1425 | no (hand-rolled counters and aux macros drive what is printed) | none; carried by the class way |
| `\maketitle` redefinition and first-page note queue | ceurart.cls:286-322, :1963-1992, :2113-2140 | no (redefines the kernel title mechanism) | none |
| abstract written to `\jobname.abs` and read back (moreverb `\verbatimwrite`, `\file_input:n`) | ceurart.cls:1776-1780, :2133-2135 | no (two-pass file round trip) | none |
| `\title[mode=..]` key sequence | ceurart.cls:425-543 | partly | the six looks are fonts, colours, skips (`front.titling` type); the key and sequence mechanism is not |
| `table`/`figure` environments with key options and `\@makecaption` | ceurart.cls:2419-2550 | yes for the look | `cap.caption` (`\captionsetup[table]` newline label separator, `\captionsetup[figure]` colon, `font={sf,small}`, `labelfont=bf`) and `fig.placement`; the options pos, width, align, abovecap are class vocabulary, not used by the sample |
| custom `enumerate` template parser and `itemize` | ceurart.cls:2736-2819 | yes | `list.enumerate-pkg` (label template syntax) with `list.enumitem` (itemsep, parsep, topsep as set at :2764-2767, :2795-2796); the sample passes no label |
| `\newdefinition`, `\newproof` | ceurart.cls:2826-2912 | yes | `thm.amsthm` (`\newtheoremstyle`, bold head, upright body; proof with small-caps head); unused by the sample |
| `\bio`, `\WrapFigure` (wrapfig with line counts kept in the aux) | ceurart.cls:2632-2729 | no | none; unused by the sample |
| `longmktitle` box splitting | ceurart.cls:2147-2218 | no (box-height splitting) | none; option unused |
| `\lastpage` and `hf` headers | ceurart.cls:2284-2311 | yes | `pgnum.lastpage` with `hf.scrlayer-scrpage`; option unused |
| pdfx `\par` patch | ceurart.cls:108-163 | compatibility patch, no printed effect | none |

## Content-opaque
none. The included image `wikidata_stmnt` (sample-1col.tex:467) is figure artwork and the table cells are content. The sample's reference list comes from `sample-ceur.bib` (data). The Makefile (`lualatex -shell-escape`, `qpdf --linearize`, Makefile:2-3, :18) is a build convenience; the class loads no package that needs either (no minted, no shell escape in ceurart.cls), and README.md:3-8 compiles with `pdflatex` and `bibtex` only.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes: `class.ceurart` is the class way (vocabulary above). Considered and not proposed: `etoolbox`, `xspace`, `xstring`, `iftex`, `expl3`, `xparse`, `l3regex` (class code helpers with no printed effect, as the lib rejected `sys.compat-load`).
