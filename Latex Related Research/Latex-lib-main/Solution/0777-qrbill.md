no

# 0777-qrbill: qrbill (Swiss QR-bill payment slip package, DocStrip source and manual)

- Unverified: read from the source, not compiled.
- Source: Source/0777-qrbill/ (origin: https://mirrors.ctan.org/macros/latex/contrib/qrbill.zip; licence: LPPL 1.3c for the package, 3-clause BSD for the bundled luaqrcode library, README.md:11-16; ctan.org/pkg/qrbill read: v2.01 of 2023-07-24, licences LPPL 1.3c and BSD-3, topics Swiss, QR Code, Invoice)
- Kind: invoice
- Lib: v6
- Engine: needs LuaLaTeX or XeLaTeX (the default font option loads fontspec with Liberation Sans, qrbill.dtx:567-570, :714-720, and the manual loads qrbill with defaults, qrbill.dtx:168; the demos name lualatex, qrbill.dtx:1498, :1545; `qrmode=lua` needs LuaLaTeX, qrbill.dtx:723); pdfLaTeX is possible with `font=custom` or `qrscheme=epc` (qrbill.dtx:571, :573) and `qrmode=package`
- Look carried by: mixed (the bill is carried by the package qrbill, whose source is qrbill.dtx:541-1360 and which is the CTAN release; the manual's look is its driver preamble qrbill.dtx:56-178 over scrartcl)
- Class origin: tex-distribution-unbundled (the zip ships no class; the driver uses scrartcl, the demos use standalone, scrletter and article)
- Main file: qrbill.dtx, documentation driver at qrbill.dtx:56-178 (no .tex in the zip; other samples: three demo documents embedded in the .dtx, qrbill.dtx:1495-1539 standalone, :1540-1610 letter, :1611-1634 EPC, extracted by qrbill.ins:50-58, not present as files)
- Read: main yes (all 1637 lines of qrbill.dtx), zip-local classes and styles partly (no .cls or .sty file exists; qrbill.sty, swiss.qrbill-cfg.tex and epc.qrbill-cfg.tex exist only inside qrbill.dtx and were read in full; qrbill-qrencode.lua, the 1351-line bundled luaqrcode file, only lines 1-50 and 1285-1351 plus a function outline; qrbill-latexluaqrcode.lua, qrbill-vocab.csv, qrbill.ins, README.md and DEPENDS.txt in full; qrbill.pdf and qrbill_swiss-cross.pdf not read)

## Verdict
No, on one blocker. The only document in the zip that carries `\documentclass` and compiles on its own is the manual driver inside qrbill.dtx, and its preamble loads `minted` with `cache` unconditionally (qrbill.dtx:64) and builds `doccode` and `\newminted` on it, which needs Pygments and shell escape: `EXTERNAL/package` by the pilot ruling, even though the body only uses it for listings. The package itself (qrbill.sty and the two scheme files) is the CTAN release and reduces to one new doc-kind way, `NEW:inv.qrbill`; read as "package plus the three demo documents" alone nothing would block, so the `no` rests on the manual driver. Every other zip-local macro of the driver is reducible (table below).

## Blockers
- `EXTERNAL/package` `minted[cache,langlinenos]` loaded unconditionally by the manual driver, with `\setminted`, `\newminted{latex}`, the `doccode` and `doccode*` environments (`\inputminted`) and `\newmintinline{latex}` (qrbill.dtx:64, :69-70, :72-84, :90; the manifest hints also list minted)

## Class setting
- Class: `class.scrartcl` options: `english`, `parskip=half-` (qrbill.dtx:58), for the manual. The demos use `class.standalone` (qrbill.dtx:1499), `class.scrletter` with `foldmarks=b` (qrbill.dtx:1546; written as the demo names it, source not read, whether it is a class or a package of KOMA-Script was not checked) and `class.article` (qrbill.dtx:1617).
- Class-native vocabulary used: scrartcl `\subtitle` and `\publishers` (qrbill.dtx:187, :189), `parskip=half-` (qrbill.dtx:58); scrletter `foldmarks` (qrbill.dtx:1546), `\setkomavar{fromaddress}`, `letter` environment, `\opening`, `\closing` (qrbill.dtx:1592-1600).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class, manual | qrbill.dtx:58 | `class.scrartcl` | english, parskip=half- |
| class, standalone demo | qrbill.dtx:1499 | `class.standalone` | no options |
| class, letter demo | qrbill.dtx:1546 | `class.scrletter` | foldmarks=b |
| class, EPC demo | qrbill.dtx:1617 | `class.article` | no options |
| QR-bill payment part and receipt (210 mm x 105 mm box) | qrbill.dtx:541-542, :566-693, :857-858, :898-1075, :1077-1100 | `NEW:inv.qrbill` | `\usepackage[icon=swiss-cross,separate=false,sep-iban=4,sep-reference=-5]{qrbill}` (:1503-1508); letter demo `frame=top,sep-iban=4,sep-reference=-5` (:1547-1551); defaults qrscheme=swiss, frame=true, vrule=true, separate=text, qrsize=46mm, iconwidth=7mm, qrmode=package, font=Liberation Sans (:566-693); the layout (52 mm receipt, 138 mm payment part, font sizes, placeholder corners) is fixed in the package (:860-896, :915, :973) |
| bill data in the body | qrbill.dtx:1512-1534, :1568-1590 | `NEW:inv.qrbill` | `\QRbill[creditor*={...},Account=,vat=,debtor*={...},Amount=,Message=,invoicenum=,vatdetails=,AV1=]` or `\qrbillsetdata{...}`; scheme presets by `\SetupQrBill` (:1435-1442, :1473-1478) |
| EPC QR code without visible bill | qrbill.dtx:1618, :1622-1628, :1458-1478 | `NEW:inv.qrbill` | `qrscheme=epc`, starred `\QRbill*[BIC=,Account=,Name=,Amount=,Message=]` |
| scheme definition (field lists, billing-info prefixes) | qrbill.dtx:1276-1319, :1360, :1376-1425 | `NEW:inv.qrbill` | the shipped `swiss` and `epc` scheme files chosen by the string `qrscheme`; a user-written scheme file would be outside the way (none in this zip) |
| packages the qrbill package loads itself | qrbill.dtx:717-719, :762, :848-850, :624, :649 | `NEW:inv.qrbill` | fontspec and anyfontsize unless `font=custom`; qrcode in `qrmode=package`; graphicx, scrbase, numprint always (`\npthousandsep{\,}`, `\npdecimalsign{.}`, :851-852); marvosym only for `vrule=symbol` and `separate=symbol`; headings in de, fr, it, en read from qrbill-vocab.csv:1-14 by babel's `\defcaptionname` (:1102-1119); not emitted as separate ways |
| demo language | qrbill.dtx:1500 | `lang.babel` | option `nswissgerman` |
| demo colour load | qrbill.dtx:1502 | `color.xcolor` | load only |
| letter fields and body | qrbill.dtx:1592-1600 | `ltr.opening` | `\setkomavar{fromaddress}{\insertcreditor}`, `letter{\insertdebtor}`, `\opening{opening}`, `\closing{closing}` |
| bill placed at the foot of every letter page | qrbill.dtx:1555-1562, :1604 | `hf.scrlayer-scrpage` | scrlayer commands of the KOMA layer family (the demo says scrlayer is already loaded, :1553-1554): `\DeclareNewLayer[align=bl,voffset=\paperheight,hoffset=0pt,contents={\QRbill},width=\paperwidth,height=105mm]{qrbill}`, `\AddLayersToPageStyle{@everystyle@}{qrbill}` |
| manual: T1 encoding under pdfTeX only | qrbill.dtx:59-62 | `font.fontenc-t1` | `\usepackage[T1]{fontenc}` inside `\ifPDFTeX` |
| manual: DocStrip typesetting | qrbill.dtx:63, :88-89, :103, :176, :181, :183, :185, :224, :1483, :1636 | `dtx.doc` | `doc[hyperref=false]`, `\PageIndex`, `\RecordChanges`, `\OnlyDescription`, `\DocInput{qrbill.dtx}`, `\changes`, `\GetFileInfo`, `\DoNotIndex`, `\DescribeMacro`, `\PrintChanges`, `\Finale` |
| manual: code listings | qrbill.dtx:64, :69-70, :72-84, :90, :225 | `code.minted` | `minted[cache,langlinenos]`, `\setminted{style=default,tabsize=4}`, `\newminted{latex}{gobble=4,escapeinside=<two bar characters>}`, `\inputminted`, `\newmintinline{latex}{}` (`\latexinline`); EXTERNAL |
| manual: language | qrbill.dtx:58, :85 | `lang.babel` | `babel` with english from the class option |
| manual: quotation marks | qrbill.dtx:86, :247 | `lang.csquotes` | `csquotes[babel]`, `\enquote` |
| manual: page geometry | qrbill.dtx:170-171 | `page.geometry` | left=4cm |
| manual: links | qrbill.dtx:173, :188, :402 | `meta.hyperref` | `hyperref[hidelinks]`, `\href`, `\url` |
| manual: cross-references | qrbill.dtx:226, :228, :264 | `xref.kernel` | `\ref`, `\pageref`, `\label` |
| manual: title block | qrbill.dtx:186-191 | `front.maketitle` | `\title{qrbill \fileversion}`, `\author`, `\date{\filedate}`, `\maketitle` |
| manual: subtitle and publisher line | qrbill.dtx:187, :189 | `front.koma-title` | `\subtitle`, `\publishers` |
| manual: contents | qrbill.dtx:192 | `toc.kernel` | `\tableofcontents` |
| manual: headings | qrbill.dtx:193, :200, :232, :380, :405 | `head.kernel` | `\section`, `\subsection`, class defaults |
| manual: appendix | qrbill.dtx:1490-1493 | `num.appendix` | `\appendix` |
| manual: lists | qrbill.dtx:236-245 | `list.kernel` | `itemize` |
| manual: quote | qrbill.dtx:399-401 | `quote.kernel` | `quote` environment |
| manual: data-field tables | qrbill.dtx:165-166, :408-417, :442-451 | `tbl.tabular` | `array` column types `>{\ttfamily}l`, `p{.25\linewidth}`, `\multicolumn` |
| manual: table rules | qrbill.dtx:166, :409-416 | `tbl.booktabs` | `\toprule`, `\cmidrule(r){1-1}`, `\bottomrule` |
| manual: side-by-side listings | qrbill.dtx:421-438 | `box.minipage` | `minipage` .4 and .5 `\linewidth` with `\hfill` |
| manual: option-line margin mark | qrbill.dtx:109 | `note.marginpar` | `\marginpar{\raggedleft\small\ttfamily NAME}` per option |
| manual: spacing and fill | qrbill.dtx:107-110, :488, :493 | `sp.manual-space` | `\vspace{0.1in}`, `\kern-\parindent`, `\hfill`, `\\`, `\par\medskip` |
| manual: ragged and centred text | qrbill.dtx:109, :407 | `sp.ragged` | `\raggedleft` in the margin mark, `center` around the address table |
| manual: font switches in option lines | qrbill.dtx:109-110, :114 | `mark.kernel` | `\ttfamily`, `\textsf{(TYPE)}`, `\texttt{(default: ...)}` |
| manual: option-line size | qrbill.dtx:109 | `font.size-commands` | `\small` |
| manual: option label colour box | qrbill.dtx:93 | `color.xcolor` | `\colorbox{black!20}`; the driver does not load xcolor, minted probably does (minted's source not read) |
| manual: inline size | qrbill.dtx:225 | `math.kernel` | `${}\times{}$` between two lengths |
| manual: bibliography | qrbill.dtx:225, :1484-1489 | `bib.thebibliography` | three `\bibitem`, `\cite` |
| manual: lists printed from package internals | qrbill.dtx:168, :319-325, :485-487, :495-497, :528-534 | `NEW:inv.qrbill` | the manual loads qrbill and prints `\g__qrbill_qrscheme_seq`, `\g__qrbill_billing_info_prop` and `\__qrbill_sep_tl:nn` results; the printed text is content |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| qrbill.sty, swiss and epc scheme files, Lua loader and luaqrcode encoder (the package code) | qrbill.dtx:541-1360, :1366-1447, :1458-1478; qrbill-latexluaqrcode.lua:1-24; qrbill-qrencode.lua:1-1351 | not bespoke | the CTAN release itself (ctan.org/pkg/qrbill), one way `NEW:inv.qrbill`; its patch of the `qrcode` internals (:765-840), the leaders and `\vbox_to_ht:nn` layout (:628-631, :651-661, :898-1075) and the pure-Lua QR encoder run inside TeX and are not copied by an emitter |
| `\qrbill@option`, `\qrbill@optionNoDefault` (`\def` with delimited arguments) | qrbill.dtx:106-115 | yes | inline expansion `\vspace{0.1in}\leavevmode\marginpar{\raggedleft\small\ttfamily NAME\ }\kern-\parindent\textsf{(TYPE)}\hfill(default: \texttt{VALUE})\\` (`sp.manual-space`, `note.marginpar`, `font.size-commands`, `mark.kernel`, `sp.ragged`); the delimiter parse is not needed once the emitter has the three values |
| `optionlist` environment: `\RenewDocumentCommand{\item}{sr[]}`, state macro `\qrbill@nextopt`, `\let\|\pipechar` | qrbill.dtx:119-134 | yes | the state only puts `\par` between consecutive option lines and the star picks the no-default form; both are known when the emitter writes the lines, so each item expands to the line above; `\|` is never used in the text (a search of the `%` lines finds a bar only at qrbill.dtx:51) |
| active vertical-bar short verbatim over fancyvrb internals (`\pipe@active@verbatim`, `\BUseVerbatim`) | qrbill.dtx:138-162 | yes, by omission | no bar-delimited text occurs in the manual body, so the definition has no printed effect and is dropped; used, it would be irreducible catcode code |
| `doccode`, `doccode*` (VerbatimOut file, then `\inputminted`) | qrbill.dtx:72-84 | no, EXTERNAL | the effect is Pygments-highlighted listings, which needs `code.minted`; `code.verbatim` (fancyvrb) would give the text without highlighting |
| `\newminted{latex}`, `\newmintinline{latex}`, `\setminted` | qrbill.dtx:69-70, :90 | no, EXTERNAL | `code.minted` |
| `\repl`, `\opt`, `\marg`, `\oarg`, `\sarg` | qrbill.dtx:92-99 | yes | aliases over `\meta` (doc), `\colorbox{black!20}`, `\ttfamily` and `\texttt{*}` |
| expl3 code in the manual body | qrbill.dtx:319-325, :485-487, :495-497, :528-537 | yes | print the resulting text (the Iban and Reference strings, the field names listed at :1376-1411, :1415-1425, :1458-1471); content, not layout |

## Content-opaque
none (the bill's QR matrix is produced by the package from the data string; qrbill_swiss-cross.pdf is a shipped image asset, README.md:26; no TikZ, PGF, picture or PSTricks anywhere in qrbill.dtx)

## Lib changes
- New ways proposed: `NEW:inv.qrbill` `qrbill` (CTAN, LPPL 1.3c, BSD-3 for the bundled luaqrcode; Marei Peischl and Alex Antener; v2.01): a Swiss QR-bill payment part and receipt, or an EPC QR code, from key=value data; `\usepackage[qrscheme,font,frame,vrule,separate,icon,iconwidth,qrsize,qrmode,sep-iban,sep-reference,ibanseparator,referenceseparator,replace-tilde,replace-umlauts,data-to-string,ignore-if-empty,billinginfo,creditorprefix,debtorprefix]{qrbill}`, `\qrbillsetup{}`, `\qrbillsetdata*{}`, `\SetupQrBill{}`, body `\QRbill*[data keys]`, `\insertcreditor` `\insertdebtor` `\insertcurrency`; headings in German, French, Italian and English follow the babel language (qrbill.dtx:566-693, :698-712, :1077-1100, :1216-1218). Engine `xe/lua` by default (fontspec, qrbill.dtx:714-720; pdfLaTeX with `font=custom` or `qrscheme=epc`). W1: the CTAN page names it, v2.01, README.md and a PDF manual. W2: options are strings, lengths, booleans, integers, choice lists and comma lists, and the layout is fixed in the package. W3: it serves any payment slip, standalone, under a letter layer or in an article, with two shipped schemes. W4: one preamble line and one body call. A sibling of `inv.simpleinvoice`, `inv.invoice2` and `inv.zugferd`; considered: `fig.qrcode` (the `qrcode` package, which qrbill loads itself at :762; that line is the QR graphic only, the emitter calls `\QRbill`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Judgement calls: `hf.scrlayer-scrpage` stands for the bare `scrlayer` commands of the letter demo (the lib has no line for layers; `bg.eso-pic` was considered, not proposed). `class.scrletter` is written as the demo names it. The tag `EXTERNAL/package` follows the pilot ruling for an unconditionally loaded `minted`.
- The driver needs qrbill.sty and the scheme files generated first by qrbill.ins (qrbill.ins:40-59, a plain TeX l3docstrip run, so not EXTERNAL) and reads `epc.qrbill-cfg.tex` at qrbill.dtx:530. Missing asset: the Liberation Sans font.
- No text addressed to an AI was found in the zip.
