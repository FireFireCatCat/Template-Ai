yes

# 0233-facture-belge-simple-sans-tva: Simple Belgian invoice without VAT (and expense note)

- Unverified: read from the source, not compiled.
- Source: Source/0233-facture-belge-simple-sans-tva/ (origin: https://mirrors.ctan.org/macros/xetex/latex/facture-belge-simple-sans-tva.zip; licence: LPPL 1.3c)
- Kind: invoice
- Lib: v2
- Engine: needs XeLaTeX (`fontspec` is loaded unconditionally, communs-facture-note.tex:8; CTAN topic XeTeX)
- Look carried by: zip-local (the package `facture-belge-simple-sans-tva.sty` and the three part files it `\input`s define the whole invoice face; the sample's preamble adds nothing; the class is plain `article`. The package is itself published, see Verdict)
- Class origin: tex-distribution-unbundled
- Main file: article-facture.tex (other samples: article-note-de-frais.tex, facture-belge-simple-sans-tva-doc.tex)
- Read: main yes, zip-local classes and styles all (the `.sty`, `communs-facture-note-about.tex`, `communs-facture-note.tex`, `facture-sans-tva.tex`, `note-de-frais.tex`; both other samples read; `calctab` source is not in the zip and was not read)

## Verdict
The sample is `article` plus one `\usepackage[french]{facture-belge-simple-sans-tva}` line and a run of string-argument commands, so it is the package that carries the look. That package is published: the zip comes from CTAN, the package page ctan.org/pkg/facture-belge-simple-sans-tva exists (v2.1, LPPL 1.3c, in TeX Live and MiKTeX), the file header names it (communs-facture-note-about.tex:15), and it ships documentation (facture-belge-simple-sans-tva-doc.tex). It passes W1 to W4 the same way `inv.simpleinvoice` does, so it is proposed as `inv.facture-belge`; its product table is `calctab` (CTAN, TeX Live, computed in TeX), proposed as `tbl.calctab`. Nothing else is bespoke, nothing is drawn with TikZ or PGF, and nothing needs a tool outside TeX. Sensitivity: if the package were judged zip-local instead, the cent arithmetic of the expense note (note-de-frais.tex:131-174) would be irreducible hand-rolled counters, and the answer would flip to `no`; the main invoice sample does not call that code.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `10pt` (article-facture.tex:1)
- Class-native vocabulary used: `\paragraph*`, `itemize`, `figure` with `[t]`/`[b]` placement, `center` (article-facture.tex:179,185,209-220). No `\maketitle`, no abstract, no sectioning in the invoice sample. The documentation sample uses `\maketitle`, `abstract`, `\tableofcontents`, `\section` (facture-belge-simple-sans-tva-doc.tex:59-69).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | article-facture.tex:1 | `class.article` | a4paper, 10pt |
| paper and size | article-facture.tex:1 | `page.class-options` | `a4paper`, `10pt` |
| invoice face as a whole (package load) | article-facture.tex:9; facture-belge-simple-sans-tva.sty:1-11 | `inv.facture-belge` | `\usepackage[french]{...}`; options are babel language names plus `latin1` |
| page geometry | communs-facture-note.tex:12 | `page.geometry` | top=2cm, bottom=2cm, left=2.5cm, right=2.5cm |
| fonts | communs-facture-note.tex:8,16 | `font.fontspec` | `fontspec` loaded with no `\setmainfont`; no family set |
| fonts | communs-facture-note.tex:16 | `font.lmodern` | `lmodern` |
| currency symbols | communs-facture-note.tex:15; article-facture.tex:24,31 | `font.icons` | `eurosym` (`\euro`); currency chosen by `\rsChoisirUniteMonetaire{\euro}` and `\ctcurrency{\euro}` |
| font sizes | facture-sans-tva.tex:16; communs-facture-note.tex:81; note-de-frais.tex:222 | `font.size-commands` | `\Huge` (number), `\large` (date), `\footnotesize` (footer credit) |
| encoding option | communs-facture-note.tex:36-47 | `font.fontenc-t1` | `inputenc` loaded only under the `latin1` option; the sample uses the utf8 default |
| colours | communs-facture-note.tex:17,64-65 | `color.color` | legacy `color`; `\definecolor{grisfonce}{gray}{0.3}`, `\definecolor{grisclair}{gray}{0.7}` |
| coloured table support | communs-facture-note.tex:18 | `tbl.colortbl` | `colortbl` loaded (its `\rowcolor` is used only in the doc sample, facture-belge-simple-sans-tva-doc.tex:101) |
| links | communs-facture-note.tex:19; article-facture.tex:81 | `meta.hyperref` | `colorlinks=true`, `urlcolor=magenta`; `\href{mailto:...}` in an address cell |
| language | communs-facture-note.tex:40-43; article-facture.tex:9,79 | `lang.babel` | class/package options forwarded to babel (`\PassOptionsToPackage{\CurrentOption}{babel}`); `french` in the sample; `\up{o}` and `\no` are babel-french |
| footer | communs-facture-note.tex:24,77-82; article-facture.tex:203 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\headrulewidth`=0pt, `\fancyfoot[EOC]{\footnotesize Extension ...}` set by `\rsCredit` |
| title block (number and date) | article-facture.tex:56; facture-sans-tva.tex:14-18 | `inv.facture-belge` | `\rsNoDate{no}{date}`; expands to `center`, `\textcolor{grisfonce}`, `\Huge Facture \no #1`, `\large du #2` |
| address table | article-facture.tex:69-98; facture-sans-tva.tex:29-49 | `inv.facture-belge` | `\rsEnteteTableauAdresses`, `\rsLigneTableauAdresses{ship}{bill}{deliver}` x7, `\rsPiedTableauAdresses`; expands to one `tabular{p{0.3\textwidth}p{0.3\textwidth}p{0.3\textwidth}}` with `\hline` and an italic grey header row (Expédition, Facturation, Livraison) |
| product and totals table | article-facture.tex:118-123,130-167 | `tbl.calctab` | `xcalctab`; `\amount[id=nisl]{label}{qty}{unit price}` x3; `\add[id=...,refs]{label}` x3; `\perc[id=rem10,nisl]{Remise 1:}{-10}` and `-5`; headers `\ctdescription{Nature}` `\ctontraslation{sur}` `\ctheaderone{Quantité}` `\ctheadertwo{Prix unit.}`; `\ctcurrency{\euro}`; `\nprounddigits{2}`; `\normalfont` resets calctab's sans face |
| product table (package side) | communs-facture-note.tex:28 | `tbl.calctab` | `calctab` loaded by the package, not by the sample |
| free text headings | article-facture.tex:179,184 | `head.kernel` | `\paragraph*{...}` (unnumbered run-in) |
| free text list | article-facture.tex:185-188 | `list.kernel` | `itemize`, two items |
| manual spacing | article-facture.tex:48,60,103,172; communs-facture-note.tex:105-106 | `sp.manual-space` | `\vspace{\rsespaceVertical}` between blocks; length set by `\rsAerationVerticale{0.5cm}` |
| bank and due-date line | article-facture.tex:198; facture-sans-tva.tex:57-61 | `inv.facture-belge` | `\rsCompteBancaireEtDateLimiteDePaiement{iban}{date}`; expands to `flushright` and `\emph{#1}` |
| alignment environments | facture-sans-tva.tex:15,58; note-de-frais.tex:79,103,146,209 | `sp.ragged` | `center`, `flushright`, `flushleft` wrappers |
| emphasis and small caps | facture-sans-tva.tex:33,59; article-facture.tex:76-81 | `mark.kernel` | `\emph`, `\textsc`, `\textbf` |
| decorative top and bottom images | article-facture.tex:209-220 | `fig.graphicx` | `figure[t]` and `figure[b]`, `center`, `\includegraphics[scale=0.3]{line_haut.png}` / `{line_bas.png}`; `graphicx` is not loaded explicitly by the sample or the `.sty` (communs-facture-note.tex:8-28); it may arrive through `calctab` (source not read), so an emitter should load it itself |
| tabular plumbing | communs-facture-note.tex:23,25 | `tbl.multirow` | `multirow` and `array` loaded; `\multicolumn{3}{\|r\|}` in the expense total row (note-de-frais.tex:192) is kernel `tabular` |
| symbol and text packages loaded, not used by the sample | communs-facture-note.tex:13-14,20-22 | `mark.ulem`, `math.mathtools`, `math.amssymb`, `math.bm` | `soul`, `ulem`, `mathtools`, `amssymb`, `mathrsfs` loaded with no options |
| expense note (second sample) | article-note-de-frais.tex:70-241; note-de-frais.tex:22-224 | `inv.facture-belge` | `\rsIdentificationCreancier`, `\rsAdresseCreancier`, `\rsIdentificationClient`, `\rsAdresseClient`, `\rsMoisAnneeNote`, `\rsCompteEnBanqueCreancier`, `\rsConstruit...`, `\rsEnteteTableauItemsARembourser`, `\rsLigneTableauItemsARembourser{no}{date}{nature}{cents}{means}`, `\rsPiedTableauItemsARembourser`, `\rsConstruitInjonctionAPayer{place}{date}{oui/non}` |
| documentation file (third sample, not the template) | facture-belge-simple-sans-tva-doc.tex:1-66 | `class.article`, `front.maketitle`, `abs.kernel`, `toc.kernel`, `code.listings`, `tbl.tabular`, `list.kernel` | `\lstset{basicstyle=\footnotesize, numbers=none, breaklines=true, backgroundcolor=\color{gristresclair}, frame=single}` (facture-belge-simple-sans-tva-doc.tex:45-54) |

Not present in the invoice sample: headers with running titles, front matter, abstract, contents, numbering, theorems, captions, bibliography, index, cross-references, equations.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `facture-belge-simple-sans-tva.sty` and its `\input` files | facture-belge-simple-sans-tva.sty:1-11 | not bespoke | published on CTAN and in TeX Live (ctan.org/pkg/facture-belge-simple-sans-tva); one way `inv.facture-belge` |
| `\rsNoDate`, `\rsCompteBancaireEtDateLimiteDePaiement`, address-table macros | facture-sans-tva.tex:14-61 | yes, and part of the published package | `center` / `flushright` / one `tabular` with `\textcolor`, `\emph`, `\hline`, as listed in the map |
| `\rsChoisirUniteMonetaire` | communs-facture-note.tex:91 | yes | a `\newcommand` alias for a currency symbol (`font.icons`) |
| `\rsAerationVerticale` and `\rsespaceVertical` | communs-facture-note.tex:105-106 | yes | `\newlength` plus `\setlength`; emitter writes `\vspace{0.5cm}` (`sp.manual-space`) |
| option plumbing (`\if@latinUn`, `\DeclareOption*` to babel) | communs-facture-note.tex:36-51 | yes | resolves to which of `lang.babel` languages and `font.fontenc-t1` (`inputenc`) is loaded; no layout effect |
| `\rsCredit` | communs-facture-note.tex:80-82 | yes | one `\fancyfoot` line (`hf.fancyhdr`) |
| expense-note variables and `\ifthenelse{\equal...}` empty-field tests | note-de-frais.tex:22-117 | yes, inside the published package | `\newcommand` storage and `tabular{l}` in `flushleft`/`flushright`; only the expense note uses them, not the invoice sample |
| expense-note cent arithmetic: counters `rstotalItemsARembourser*`, `\rsMajCompteursTotaux`, `\rsaffichageMontantItem` (`\ifnum` picks the printed decimals) | note-de-frais.tex:131-142,160-174 | internal to the published package (the sensitivity named in the Verdict) | not called by article-facture.tex; the emitter writes `\rsLigneTableauItemsARembourser` with cents as a string argument |
| `\rsConstruitInjonctionAPayer` with `\ifthenelse{\equal{#3}{oui}}` signature image | note-de-frais.tex:208-214 | yes, inside the published package | `flushright` plus `\includegraphics[scale=1]{signature.png}` when the third argument is `oui` |

## Content-opaque
- Decorative PNG flourishes `line_haut.png` and `line_bas.png` (279x73 px raster files, ornamental rules) included in two `figure` floats (article-facture.tex:211,218). Judged figure content (included images, not TeX-drawn), held by `fig.graphicx`; shipped in the zip.
- `signature.png` (note-de-frais.tex:212), an optional image in the expense note; shipped in the zip.
- Cell text of the address table and the product table (article-facture.tex:76-82,144-146); the IBAN and date strings (article-facture.tex:198).
- No TikZ, PGF, PSTricks or `picture` anywhere (grep of every `.tex`/`.sty`).

## Lib changes
- New ways proposed:
  - `inv.facture-belge`: package `facture-belge-simple-sans-tva` (CTAN, TeX Live), engine XeLaTeX/LuaLaTeX (loads `fontspec`). A whole invoice or expense note for a Belgian individual: `\usepackage[<babel languages>,latin1]{facture-belge-simple-sans-tva}`, body `\rsNoDate{no}{date}`, `\rsEnteteTableauAdresses`/`\rsLigneTableauAdresses{ship}{bill}{deliver}`/`\rsPiedTableauAdresses`, an `xcalctab` table, `\rsCompteBancaireEtDateLimiteDePaiement{iban}{date}`, `\rsCredit`, `\rsChoisirUniteMonetaire`, `\rsAerationVerticale`; expense note `\rsIdentificationCreancier` ... `\rsLigneTableauItemsARembourser{no}{date}{nature}{cents}{means}` ... `\rsConstruitInjonctionAPayer`. W1: on CTAN and in TeX Live with documentation. W2: every input is a string, a currency symbol, a length or a language list. W3: it serves a kind of document (invoice and expense claim), as `inv.simpleinvoice` does. W4: one `\usepackage` line plus body commands. A sibling of `inv.simpleinvoice`, a different package, so not folded into it.
  - `tbl.calctab`: package `calctab` (CTAN, TeX Live, depends on `fltpoint`), engine pdf (no engine requirement found). Environment `xcalctab` with `\amount[id=]{label}{qty}{price}`, `\add[id=,refs]{label}`, `\perc[id=,ref]{label}{percent}`, header and currency strings `\ctdescription` `\ctheaderone` `\ctheadertwo` `\ctontraslation` `\ctcurrency`, and the rounding command `\nprounddigits`. W1: CTAN page exists (v0.6.1, LPPL 1.3). W2: labels, numbers, ids and strings; sums and percentages are computed inside the package in TeX, no external tool. W3: any amount table (invoice, quote, expense note), not one document. W4: preamble line plus one environment wrapped around rows. Not `tbl.tabular` (no hand-set columns), `tbl.siunitx` (alignment only, no sums) or `tbl.nicematrix`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
