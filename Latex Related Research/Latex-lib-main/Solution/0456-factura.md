no

# 0456-factura: factura (invoice class for Venezuelan fiscal forms, CTAN)

- Unverified: read from the source, not compiled.
- Source: Source/0456-factura/ (origin: https://mirrors.ctan.org/macros/latex/contrib/factura.zip; licence: LPPL 1.3c, factura.dtx:6-18)
- Kind: invoice
- Lib: v4
- Engine: pdfLaTeX-compatible (class and invoice examples, factura.dtx:889; the manual driver prefers XeLaTeX/LuaLaTeX with fontspec, factura.dtx:232-234; the signature asset needs XeLaTeX/LuaLaTeX, README:34,52-54)
- Look carried by: class (factura.cls and factura.def, docstrip modules of factura.dtx, set the whole invoice look; the examples add options and class commands)
- Class origin: ctan (factura v4.32 2022/01/22, factura.dtx:183-186; the zip is the CTAN distribution, so the class is published, not zip-local)
- Main file: factura.dtx (no standalone .tex or .cls in the zip: manual driver 193-533; class and def modules interleaved at 2304-5238; example modules 5239-5885, main example `prefac` = factura-ejemplo-prefactura.tex, lines 5412-5709, the example the README names and that ships as a PDF, README:35) (other samples: the 18 other example modules generated at factura.dtx:95-140, e.g. factura01..10, reporte1..4, cotizacion, notadecredito, notadedebito, beispiel-rechnung; asset documents fondo, membrete, firma at 5711-5848)
- Read: main yes (whole factura.dtx, 5888 lines, plus README), zip-local classes and styles all (factura.cls and factura.def exist only as modules inside factura.dtx and were read in full; the two shipped PDFs were not read, they are compiled outputs)

## Verdict
The invoice look is carried by the published CTAN class `factura` (`class.factura`), and the main example (prefactura) uses only class options and class commands, so as a class it is recoverable. The answer is still no because the zip's samples load zip-local, irreducible documentation scaffolding: the helper `factura-ejemplo-aux.tex` (catcode switching, `\CatchFileBetweenDelims` over its own source, `\regexpatchcmd*`) that every example `\input`s and calls, the manual driver's redefinitions of doc internals, and two examples that overwrite class-internal style hooks with code. All three blockers are scope `preamble`; none sits in the class, so a reading that counts only the class and its native vocabulary would give yes.

## Blockers
- `BESPOKE/preamble` helper `\Ejemplo` of factura-ejemplo-aux.tex: catcodes, `\CatchFileBetweenDelims{\DescEjemplo}{\jobname.tex}`, `\regexpatchcmd*`, loaded by every example (factura.dtx:5849-5885, loaded 5473, called 5707)
- `BESPOKE/preamble` manual driver: its own `\Ejemplo` with catcode games and regex patches, redefined `\DescribeMacro`, `\DescribeOption`, `\changes@`, `\@wrglossary`, `\index@prologue`, patched `\todoitem` (factura.dtx:284-336, 341, 348-401)
- `BESPOKE/preamble` class style hooks overwritten by code in examples beispiel and factocho: `\@EstiloDenominacion` with an `\ifsinnumero` conditional, emptied `\@EstiloNumControl` and `\@EstiloFormalibre`, `\@EstiloFechas` (factura.dtx:5513-5515, 5547)

## Class setting
- Class: `class.factura` options: main example `prefactura,expandecuadro,linea` (factura.dtx:5414,5448,5449); the class has about 55 boolean options (declared 2530-2588, table 2030-2092; the same switches can be set as `\<option>true` conditionals, 1071-1075, used at 5471). It runs `\LoadClass[12pt]{article}` (2592) and loads `etoolbox xparse textpos[absolute] eso-pic atbegshi xstring calc fp-upn numprint tikz(shadows) tabularx environ fancyhdr datetime2[calc] anyfontsize ifxetex ifluatex zref-savepos geometry` (2595-2616, 2978) and, unless `nospanish`, `babel[spanish]` and `fontenc[T1]` (2840-2850). No package needs a tool outside TeX.
- Class-native vocabulary used: options `prefactura expandecuadro linea`; preamble commands `\Num \NumControl \NumSerieControl \RazonSocial \Nombre \RIF \CI \Contacto \Direccion \Telefono \Email \Emisor \Conforme \Fecha \Fecha* \FormatoFecha \Credito \Descuento[GRAE][*] \Moneda \Divisa \TasaCambio \FondoFactura \Resumen \NotaPrevia \NotaInterna \NotaExterna \NotaFinal (each with * and **) \Membrete \EncabezadoFactura \EncabezadoReporte \GeometriaFactura \GeometriaReverso \GeometriaReporte \Pos{Fecha,Denominacion,Control,Formalibre,NotaFinal,Firmas} \Linea{Encabezado,NotaPrevia,Descripcion,NotaFinal,Firmas} \Sep* \Letra* \FirmaFactura \FondoReporte \InicioReporte \TituloReporte \InfoPagina \EstiloPagina \NumNota \FechaNota \Cliente \BeforeEndPreamble`; environments `factura` (with `\Item \ItemR \ItemA \ItemE \ItemX`, `\label`), `reverso`, `reporte`; body `\Descripcion \FirmaReporte \itemref \cantref \descref \puref \subtref \dctoref \ivaref \ptref \ldescref`; totals `\BIG \BIR \BIA \BIE \AlicuotaG \AlicuotaR \AlicuotaA \SubtG.. \DescG.. \Total`; counter `NumItem` (docs 903-2021).

## Component map
Main example (prefactura) and the class files it loads:

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | factura.dtx:5413-5468, 2592 | `class.factura`, `class.article`, `page.class-options` | `prefactura,expandecuadro,linea`; base article with `12pt` |
| page geometry | factura.dtx:2993, 2996-2998, 4693 | `page.geometry` | invoice `letterpaper,vmargin={4.7cm,5.5cm},hmargin={1cm,1cm},footskip=0pt,headsep=0pt,headheight=0pt`; reverse `vmargin={1cm,1cm}`; report `vmargin={2.8cm,2.5cm},hmargin={3cm,2cm},footskip=1.2cm,headsep=0.777cm,headheight=1.5cm` |
| fixed-position texts (date, denomination, control number, FORMA LIBRE, final note, signature lines) | factura.dtx:2596, 3428-3433, 3435, 3445, 3455, 3466, 3476, 3486, 4892-4899 | `pg.textpos` | `textpos[absolute]` blocks; `\PosFecha*{-0cm}{4.5cm}`, `\PosDenominacion*{0cm}{4.5cm}`, `\PosControl*{0cm}{-2.4cm}`, `\PosFormalibre*{0cm}{-3.5cm}`, `\PosNotaFinal{0cm}{0cm}{-5.3cm}`, `\PosFirmas{5cm}{1cm}{-2.4cm}` |
| invoice page background image | factura.dtx:5566, 3727-3733, 4706-4707, 4823-4828 | `pg.textpos`, `fig.graphicx` | `\FondoFactura{factura-ejemplo-fondo}`, `\includegraphics` in a full-paper `textblock*` at the first shipout |
| report background (other examples) | factura.dtx:5567-5568, 3737-3744, 4831-4840 | `bg.eso-pic`, `fig.graphicx` | `\FondoReporte{..}` first page, `\FondoReporte*{..}` all pages via `\AddToShipoutPictureBG` |
| invoice page style and numbering | factura.dtx:4703-4704 | `hf.pagestyle-kernel`, `pgnum.pagenumbering` | `\thispagestyle{empty}`, `\pagenumbering{roman}` |
| client data header boxes | factura.dtx:4911-4918, 4922-4933, 5045-5060, 3511, 3533 | `front.class-native` | `\RazonSocial \RIF \Contacto \Direccion \Telefono \Email`; rounded tikz node with shadow set by `\LineaEncabezado{0.4pt}{10pt}{0pt}` (thickness, corner radius, shadow), `\SepEncabezado{6pt}`; optional `\Resumen` side box 4937-4982 (not in prefactura, line 5381) |
| document denomination and number | factura.dtx:3213, 3048, 5187-5192, 5519 | `front.class-native` | `\Num{1}`; text FACTURA from `\@@DenominacionFactura`; digits 6 (3016); `\Denominacion{..}` |
| control number and FORMA LIBRE (prefactura) | factura.dtx:4710, 5178-5185, 5521-5522 | `front.class-native` | `\NumControl{1001}`, `\NumSerieControl{09}`, `\LetraFormalibre{\fontsize{14}{14}\bfseries\color{blue}}` (3637) |
| issue date | factura.dtx:5194-5200, 3151-3155, 3164-3165, 3017-3019, 5539 | `front.datetime` | `\Fecha{02-07-2022}`; `datetime2[calc]` style `ddmmyyyy`, input `dd-mm-yyyy`, separator `-`; `\FormatoFecha[in]{out}{sep}` |
| item table | factura.dtx:4276, 4162-4199, 4349-4425, 4637-4655, 5652-5675 | `tbl.tabularx`, `class.factura` | `tabularx{\textwidth}` with a column spec built from booleans; rows `\Item{qty}{desc}{unit price}`, `\ItemR{..}`; cell font `\LetraItems{\fontsize{14}{18}}` (3560); column order cdu (default), dcu, duc |
| table rules | factura.dtx:4163-4199, 4463-4556 | `tbl.tabularx` | all rules on by default; switched off by the `sinlineas*` options (2705-2720) |
| totals computed and printed | factura.dtx:4137-4159, 4539-4550, 3925-3974, 3005-3007, 5554 | `class.factura`, `mark.siunitx` | TeX arithmetic with `fp-upn` (2601); `numprint` with `\npthousandsep{.}`, `\npdecimalsign{,}` (3012-3013), 2 decimals (3014); VAT 0.16 / 0.08 / 0.31; `\Descuento{18}` |
| money sign | factura.dtx:4041-4053, 3022-3028 | `class.factura` | `\Moneda{Bs.}`, 1.5pt gap; options `monedaceldas monedadespues sinmonedatotales` |
| blank-space cancelling diagonal | factura.dtx:5065-5108, 5449, 2832-2838 | `class.factura`, `xref.zref`, `art.tikz` | option `linea` (needs `expandecuadro`); positions saved with `zref-savepos` (2616); one `\draw` line inside the class; needs 3 to 4 runs (891) |
| long description box | factura.dtx:4727-4737, 4741-4771, 3545, 5677 | `class.factura` | `\Descripcion{..}`; `\LineaDescripcion{0.4pt}{0pt}{4pt}`, `\SepDescripcion{6pt}`, `\LetraDescripcion{\fontsize{14}{16.8}}` |
| note boxes (previa, interna, externa, final) | factura.dtx:3235-3253, 4987-5039, 5174-5176, 3539, 3551, 5646 | `class.factura` | `\NotaFinal{..}`; `\LineaNotaFinal{0pt}{0pt}{0pt}` (no box), `\SepNotaFinal{5pt}`; `*` appends, `**` prepends |
| signature lines | factura.dtx:5161-5172, 3495, 4843-4849, 2700, 3666-3678, 5588 | `sp.rule`, `pg.textpos` | `\LineaFirmas{5.5cm}{0.7pt}`; prefactura sets no signatures (counter 0, 2700); `\FirmaFactura{\includegraphics..}[0pt][17pt]` in the cotizacion example |
| fonts | factura.dtx:3560-3661, 2613 | `font.size-commands`, `font.exscale` | no font package: Computer Modern with one `\fontsize{a}{b}\selectfont` per element through `\Letra*` (these take any font command); `anyfontsize` is a load-only switch of the same type as `fix-cm`, considered: `anyfontsize` (no new way) |
| colour | factura.dtx:3637, 3641 | `color.xcolor` | `\color{blue}`, `\color{red}` through tikz's xcolor |
| language and encoding | factura.dtx:2840-2850, 2554, 5474 | `lang.babel`, `font.fontenc-t1` | `babel[spanish]`, `fontenc[T1]` (pdfLaTeX only), `inputenc[utf8]`; option `nospanish` |
| item labels and references | factura.dtx:4246-4270, 4458, 5656, 5694 | `class.factura`, `xref.kernel` | `\label` rebound inside `factura` (4458); `\itemref \cantref \descref \puref \subtref \dctoref \ivaref \ptref \ldescref` |
| report running heads (other examples) | factura.dtx:5203-5236, 3747-3750, 3228, 3131 | `hf.fancyhdr`, `hf.class-native` | `\fancypagestyle{plain,soloarriba,soloabajo,solonumpag}`; `\EstiloPagina[first]{rest}`; `\InfoPagina`; head rule 0.4pt |
| report body (other examples) | factura.dtx:4793-4817, 3754-3756, 5155-5158, 5689-5704 | `class.factura`, `sp.lengths` | `reporte` environment, `\TituloReporte[*]`, parindent 0.666cm, parskip `4pt plus 6pt minus 2pt` |
| reverse of the sheet (other examples) | factura.dtx:3812-3822, 5683-5687 | `class.factura`, `page.geometry` | `reverso` environment with `\GeometriaReverso{..}`; option `sinreverso` |
| CSV export (option csv) | factura.dtx:2873-2881, 4428-4455, 5111-5137 | `class.factura` | TeX-level `\openout`/`\write` of `\jobname.csv`; no tool outside TeX |
| PDF Subject metadata | factura.dtx:2650-2659 | `class.factura` | written by the class itself (`\pdfinfo`, `\pdfextension info`, `\special`); automatic, the emitter writes nothing |
| other-legislation variant (beispiel) | factura.dtx:5475-5512 | `class.factura`, `lang.babel`, `font.icons` | `nospanish`, `babel[ngerman]`, `\Moneda{\euro{}}` (`eurosym[official]`), label strings `\@@..`, rates `\@AlicuotaG` 0.19 and 0.07, symbols `\@SimboloAlicuota*` |

Manual driver and example helper (documentation scaffolding, counted because the samples load or are built from it):

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| manual class and doc machinery | factura.dtx:194, 261-264, 407-412, 2301, 5887 | `class.ltxdoc`, `dtx.doc` | `\EnableCrossrefs \CodelineIndex \OnlyDescription \RecordChanges \GetFileInfo \DoNotIndex{} \DocInput{\jobname.dtx} \StopEventually{\endorgo} \Finale`; `hypdoc` (218); index and change list by `makeindex` (shell escape in the .ins, 144-145), the standard dtx run |
| manual geometry | factura.dtx:195, 2244, 2296 | `page.geometry` | `a4paper,headheight=0.6cm,headsep=0.77cm,footskip=1.2cm,footnotesep=0.54cm,marginparsep=10pt,vmargin={3cm,2cm},hmargin={4cm,2cm}`; `\newgeometry` for the example pages |
| manual language, fonts, colours | factura.dtx:196-197, 226-238, 246-250, 276-280 | `lang.babel`, `font.fontspec`, `font.fontenc-t1`, `color.xcolor`, `meta.hyperref` | `babel[spanish]`; `\setmainfont[Ligatures=TeX,Mapping=TeX]{Linux Libertine O}` under XeTeX/LuaTeX, else `T1`+`utf8`; `xcolor[dvipsnames]`; `\hypersetup{plainpages=false,colorlinks=true,linkcolor=blue,unicode=true}` |
| manual spacing | factura.dtx:266, 269, 734, 2025 | `sp.lengths`, `sp.penalties`, `sp.setspace` | `\parskip7pt`, `\widowpenalty10000`, `\setstretch{1.4}` and `\setstretch{1}` |
| manual title, contents, lists, tables, verbatim, notes | factura.dtx:404-411, 726, 497, 812, 2030, 1589-1595, 203-208, 252-253, 213, 365 | `front.maketitle`, `front.thanks`, `toc.kernel`, `list.paralist`, `list.kernel`, `tbl.tabular`, `code.verbatim`, `fn.footmisc`, `draft.todo`, `note.marginpar`, `fn.kernel` | `\title/\author/\thanks`; `inparaenum`; `tabular` with `>{\ttfamily}ll`; `verbatim`; `footnote` package `\makesavenoteenv`; `todo` package (`\todos`); `\marginpar` for option names |
| example pages in the manual | factura.dtx:286-336, 303, 838 | `fig.graphicx`, `box.fancybox`, `box.minipage` | `\fbox{\includegraphics[page=..]}` of the compiled example PDFs (bespoke wrapper: see Bespoke code) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\Ejemplo` in factura-ejemplo-aux.tex | factura.dtx:5849-5885 (loaded 5473, called 5707) | no | catcode switching (5857-5858, 5864-5865, 5878-5880), `\CatchFileBetweenDelims` on the example's own source (5866), `\regexpatchcmd*` and `\xpatchcmd*` rewriting the captured text (5869-5872); prints a page from the source's own comment lines, which no lib way does; an emitter would drop the call (it is documentation, not the invoice), but then the sample is not reproduced as written |
| manual driver `\Ejemplo` and doc-internal redefinitions | factura.dtx:284-336, 341, 348-401 | no | same catcode and regex machinery (313-322), `\DescribeMacro` `\DescribeOption` `\changes@` `\@wrglossary` `\index@prologue` rewritten, `\todoitem` patched; typesetting behaviour beyond `dtx.doc` |
| class hooks overwritten in beispiel and factocho | factura.dtx:5481-5517, 5545-5551 | no | `\renewcommand{\@EstiloDenominacion}{..\ifsinnumero\else..\fi}` (5513), `\renewcommand{\@EstiloNumControl}{}` (5514), `\renewcommand{\@EstiloFormalibre}{}` (5515), `\renewcommand{\@EstiloFechas}{\@LetraFecha\bfseries\@@Fecha\space{\color{blue}\@Fecha}}` (5547); the docs name these as customisation hooks (1999-2009), but they are code edits, so W2 fails for them and no declarative `class.factura` parameter replaces them |
| strings, rates, symbols and lengths set by `\def` or `\renewcommand` on class defaults | factura.dtx:5483-5512, 5546, 5548, 5550, 5625 | yes | these are the class's own parameters (labels `\@@..` 3042-3089, rates 3005-3007, symbols 3036-3039, `\@EspacioSignoMonetario` 3028, `\tabcolsep` 3121); documented as the way to adapt the class (855-861); values passed to `class.factura` |
| option switches as conditionals | factura.dtx:5471 | yes | `\sinlineasvtrue \sinlineashtrue \filasfalse \csvfalse` equal the class options (1071-1075) |
| factura.cls and factura.def internals (booleans, boxes, `\prevgraf` loop 3858-3883, `\David@XPad` 4318-4337, `fp-upn` totals 4142-4159, `\cleardoublepage` redefinition 5140-5150, tikz boxes 4741-4771) | factura.dtx:2304-5238 | not counted | published CTAN class (W1), carried by `class.factura`; recorded for re-reading: if the class were counted as zip-local these would be `BESPOKE/class`, and the rounded shadow boxes and the diagonal line would be `ART/class`, although they are driven only by lengths and options (`\Linea*`, `\Sep*`, `linea`) |

## Content-opaque
- factura-ejemplo-fondo.tex and factura-ejemplo-membrete.tex: tikz-drawn replica of a printer's blank fiscal form and of a letterhead, compiled to PDF and included as images by `\FondoFactura` and `\FondoReporte` (factura.dtx:5796-5848, used 5566-5568); user-supplied background assets, not the class's own look; if a reviewer counts them as page-frame artwork they would add `ART/preamble` and the verdict stays no
- factura-ejemplo-firma.tex: PSTricks signature drawing (LaTeXDraw), needs XeLaTeX or LuaLaTeX, included by `\FirmaFactura` and `\FirmaReporte` (factura.dtx:5711-5795, used 5588, 5702-5703)
- `\flechaCR`: inline tikz arc glyph marking a wrapped item line, in the class (3114-3118) and in the manual (255-259)
- client names, addresses, item descriptions, prices, report text and the manual's prose: content

## Lib changes
- New ways proposed: none (considered: `anyfontsize` as a widening of `font.exscale`; `todo` under `draft.todo`; `footnote` under `fn.footmisc`; `numprint` under `mark.siunitx`; the class's own item table, totals and note boxes stay under `class.factura` vocabulary, as the lib does for other class-native components)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Class vocabulary for the lib's class section: `class.factura` (CTAN, LPPL 1.3c, Emilio Augusto Lazo Zaia): invoice, quotation, credit note, debit note and service report for Venezuelan fiscal forms; about 55 boolean options (`prefactura cotizacion notadecredito notadedebito conreporte soloreporte numitem descuentos subtotal iva dcu duc filas expandecuadro linea sinlineas* nospanish csv ...`), environments `factura` `reverso` `reporte`, rows `\Item \ItemR \ItemA \ItemE \ItemX`, `\Pos* \Linea* \Sep* \Letra*` layout commands; no AI-addressed text was found in the zip
