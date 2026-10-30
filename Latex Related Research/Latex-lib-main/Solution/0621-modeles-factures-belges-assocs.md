yes

# 0621-modeles-factures-belges-assocs: Modèles de factures belges pour les associations

- Unverified: read from the source, not compiled.
- Source: Source/0621-modeles-factures-belges-assocs/ (origin: https://mirrors.ctan.org/macros/latex/contrib/modeles-factures-belges-assocs.zip; licence: lppl1.3c)
- Kind: invoice
- Lib: v5
- Engine: needs XeLaTeX (`\RequirePackage{fontspec}` unconditional, modeles-factures-belges-associations.sty:41; README.md:15 "extension XeLaTeX"; doc-modeles-factures-belges-assocs.tex:78 asks for the XeLaTeX compiler)
- Look carried by: mixed (a CTAN style shipped in the zip, modeles-factures-belges-associations.sty, defines the invoice look and the `\rsfb` commands; the sample only passes option and string values; `article` sets a4paper,10pt)
- Class origin: tex-distribution-unbundled
- Main file: facture-basique.tex (other samples: facture-banlieues.tex, doc-modeles-factures-belges-assocs.tex, which the manifest lists as `main`; the manual is an ordinary article that does not load the style)
- Read: main yes, zip-local classes and styles all

## Verdict
The zip is the CTAN release of one package, `modeles-factures-belges-associations`, whose style is a thin layer of published packages (`calctab`, `fancyhdr`, `geometry`, `babel`, `hyperref`, `colortbl`, `lmodern`, `fontspec`, `eurosym`) plus string-storing `\newcommand`s; the two invoice samples only call it and add `caption` and `\includegraphics` on PNG assets. Every `\rsfb` macro reduces to lib ways (`tbl.tabular`, `tbl.calctab`, `hf.fancyhdr`, `sp.manual-space`, `color.color`, `mark.kernel`, `sp.ragged`), there is no TikZ, no output routine, no external tool, so no blocker. The manual is `article` with `listings`, `colortbl`, `hyperref` and `calctab`, all in the lib. Engine is XeLaTeX only (a tag, not a blocker). W1 for the package rests on the CTAN origin of the zip; `ctan.org/pkg/modeles-factures-belges-associations` (named at sty:17) returned a 404, so the page name is probably the directory name `modeles-factures-belges-assocs` (not re-read, read budget spent).

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper,10pt` (facture-basique.tex:1; facture-banlieues.tex:1; doc-modeles-factures-belges-assocs.tex:1). Kernel class, source not read.
- Class-native vocabulary used: invoice samples `\paragraph*` (facture-basique.tex:192,197), `itemize` (facture-basique.tex:198), `figure` (facture-basique.tex:222); manual adds `\title` `\author` `\date` `\maketitle` `abstract` `\tableofcontents` `\section` `\subsection` `enumerate` (doc-modeles-factures-belges-assocs.tex:38-69).

## Component map
Paths: `S` = modeles-factures-belges-associations.sty, `B` = facture-basique.tex, `N` = facture-banlieues.tex, `D` = doc-modeles-factures-belges-assocs.tex.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | B:1, N:1, D:1 | `class.article` | a4paper, 10pt |
| paper and size | B:1 | `page.class-options` | a4paper, 10pt (manual has no geometry, D:8 is commented out) |
| page geometry | S:45 | `page.geometry` | top=2 cm, bottom=2 cm, left=2.5 cm, right=2.5 cm |
| header/footer | S:98-100 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}` (clears every field, so no page number), `\headrulewidth`=0pt |
| footer credit line | S:101-103; B:216; N:235 | `hf.fancyhdr` | `\fancyfoot[EOC]{\footnotesize Extension \og name \fg, V version, date, \copyright\ authors.}`, set by `\rsfbCredit`; the strings come from S:7-10 and are content |
| footer size and credit marks | S:102 | `font.size-commands`, `lang.babel` | `\footnotesize`; `\og` `\fg` (babel french guillemets) |
| fonts | S:41, S:49; D:3, D:16 | `font.fontspec`, `font.lmodern` | fontspec load-only (no `\setmainfont`), lmodern load-only |
| currency symbol | S:48; B:39, B:50; D:12 | `font.icons` | eurosym `\euro`, passed as a string to `\rsfbMonnaieTableauProduits` and `\rsfbChoisirUniteMonetaire` |
| text symbols | D:124-128 | `font.fontenc-t1` | `\pounds`, `\textyen` (textcomp), inside a manual table cell |
| TeX logo | D:35, D:78 | `font.icons` | `dtk-logos` `\XeLaTeX{}` (package is the parameter, as `hologo`); `ctan.org/pkg/dtk-logos` returned a 404 so W1 is not established by a read; one use, fallback is `\hologo{XeLaTeX}` or the plain word |
| encoding switch | S:67-68, S:76-82 | `font.fontenc-t1` | `\RequirePackage{inputenc}` only under option `latin1`; inputenc does nothing under XeLaTeX; prints nothing unless `\rsfbEncodage{}` is called (commented out, B:14) |
| colour | S:50, S:92-93; D:25, D:42-45 | `color.color` | `\definecolor{grisfonce}{gray}{0.3}`, `{grisclair}{gray}{0.7}`; manual adds `{gristresclair}{gray}{0.97}` |
| language | S:71-74; B:9; D:5 | `lang.babel` | every unknown option forwarded to babel (`\DeclareOption*`), sample `french`; French vocabulary `\og \fg` (S:102), `\up` (B:105; D:165), `\no` (N:226) |
| invoice package | S:26; B:9; N:13 | `inv.facture-belge` | `\usepackage[french]{modeles-factures-belges-associations}` with `\rsfb` string commands; same type as the lib line (which names `facture-belge-simple-sans-tva`, commands `\rs`...), the package is the parameter |
| invoice number and date block | S:172-178; B:80; N:102 | `inv.facture-belge` | `\rsfbNoDate{n\textsuperscript{o}X}{JJ mois AAAA}`; reduces to a `center` block, `\textcolor{grisfonce}`, `\Huge Facture #1`, `\\`, `\large du #2` (`sp.ragged`, `color.color`, `font.size-commands`, `sp.manual-space`); it also stores `\rsfbmentionObligatoire` and `\rsfbdateFacture`, reused in text at N:226 |
| vertical spacing | S:155-156; B:72, B:86, B:135, B:185; N:89 | `sp.lengths`, `sp.manual-space` | `\rsfbAerationVerticale{0.5cm}` is `\setlength` on a new length, then `\vspace{\rsfbespaceVertical}`; inlines to `\vspace{0.5cm}` (N: 0.3cm) |
| address table | S:107-109, S:189-207; B:20-22, B:95, B:102-109, B:125 | `tbl.tabular` | `\noindent\begin{tabular}{p{0.3\textwidth}p{0.3\textwidth}p{0.3\textwidth}}`, `\hline`, header row `\textcolor{grisfonce}{\emph{...}}`, one row per `\rsfbLigneTableauAdresses`, closing `\hline` (as written by `inv.facture-belge`); the `begin` and `end` sit in two macros, an emitter writes one environment |
| address-table cell marks | B:102-107; N:135-141 | `mark.kernel`, `meta.hyperref`, `lang.babel` | `\textsc`, `\href{mailto:...}{...}`, `N\up{o}` |
| creditor account | S:163; N:115, N:141, N:226 | `inv.facture-belge` | `\rsfbCompteBancaireCreancier{iban}` stores a string, printed by `\rsfbcompteBancaireCreancier{}`; inline expansion |
| product table | S:61, S:113-125; B:28-39, B:150-176; N:182-206 | `tbl.calctab` | `xcalctab` env, first line `\normalfont` (B:153); `\amount[id=un]{Produit Un}{5}{100,20}` (B:163-165), `\add[id=phtva,un,deux,trois]{Prix HTVA}` (B:166), `\perc[id=tva6,un]{TVA}{6}` and `tva21` (B:169-170), `\add[phtva,tva6,tva21]{Total}` (B:173); headers `\ctdescription` `\ctheaderone` `\ctheadertwo` (S:113-115), `\nprounddigits{2}` (S:121), `\ctcurrency{\euro}` (S:123), `\ctontraslation{sur}` (S:125); N uses `\perc[id=tva21,phtva]{TVA}{21}` (N:200); the manual calls the `\ct...` commands directly (D:436-457); calctab source not read |
| bank line | S:217-221; B:211 | `inv.facture-belge` | `\rsfbCompteBancaireEtDateLimiteDePaiement{iban}{date}`; reduces to a `flushright` block with `\emph` and a fixed French sentence (`sp.ragged`, `mark.kernel`) |
| free-text headings | B:192, B:197; N:222 | `head.kernel` | `\paragraph*{...}` |
| lists | B:198-201; D:74-79, D:82-87, D:189-216, D:489-492 | `list.kernel` | `itemize` (nested in D:192-195), `enumerate` |
| inline marks | B:153; D:120, D:145-151 | `mark.kernel` | `\normalfont`, `\textbf`, `\emph`, `\textsc` |
| figure floats | B:222-226, B:229-233; N:26-30, N:245-250 | `fig.graphicx` | `figure[t]` and `figure[b]` (B), `figure[!h]` with `flushleft` (N:26-28), `figure[b]` with `center`; `\includegraphics[scale=0.3]{line_haut.png}`, `scale=0.3` bottom, `scale=0.2` logo and sponsors; graphicx is loaded by no file in the zip (calctab's CTAN page names only fltpoint), so the emitter loads it |
| caption | N:16-17, N:247 | `cap.caption` | `\usepackage{caption}`, `\captionsetup[figure]{name={}}`, `\caption*{\small Avec le soutien des sponsors}` |
| links | S:52; D:19 | `meta.hyperref` | `colorlinks=true`, `urlcolor=magenta` |
| load-only packages | S:46-47, S:51, S:53-56, S:58-59 | `mark.ulem`, `tbl.colortbl`, `math.mathtools`, `math.amssymb`, `math.bm`, `tbl.multirow`, `tbl.tabular` | soul, ulem, colortbl, mathtools, amssymb, mathrsfs, multirow, array are loaded and no invoice sample calls their commands (grep for `\ul` `\st` `\multirow` `\mathscr` found none); `ifthen` (S:59) has no printed effect and no way (cf. rejected `sys.compat-load` in the lib log) |
| manual title block | D:38-40, D:61 | `front.maketitle` | `\title`, `\author{\textsc{Sebille} Robert}`, `\date{\today}`, `\maketitle` |
| manual abstract | D:63-65 | `abs.kernel` | `abstract` environment |
| manual contents and breaks | D:68-69 | `toc.kernel`, `pg.break` | `\tableofcontents`, `\newpage` |
| manual headings | D:71, D:73, D:81, D:460 | `head.kernel` | `\section`, `\subsection`, `\paragraph*` |
| manual tables | D:118-130, D:136-153, D:318-326, D:342-353 | `tbl.tabular`, `tbl.colortbl` | `|l|l|c|` with `\hline`; `\rowcolor{grisclair}` (D:120); `p{0.3\textwidth}` x3 inside `flushleft` |
| manual code listings | D:22, D:47-56, D:91-95, D:271-275 | `code.listings` | `\lstset{basicstyle=\footnotesize, numbers=none, breakatwhitespace=false, breaklines=true, backgroundcolor=\color{gristresclair}, frame=single}`, `lstlisting` environments; no minted |
| manual aligned blocks | D:117, D:317 | `sp.ragged` | `center`, `flushleft` around tabulars |
| manual cross-references | D:113, D:134, D:158, D:186 | `xref.kernel` | four `\label`s, no `\ref` anywhere |
| manual inline maths | D:83, D:213 | `math.kernel` | `$ \rightarrow $` |

## Bespoke code
All of it sits in the shipped style, which is the CTAN package itself (published, W1 by CTAN origin); each item is also shown reducible in case the style is read as zip-local. The samples define no macro of their own.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\rsfbvarname` `\rsfbvarversion` `\rsfbvardate` `\rsfbvarauthor` | S:7-10 | yes | string constants, used only in S:26 and the footer credit S:102; inline expansion |
| `\newif\if@latinUn`, `\DeclareOption{latin1}`, `\DeclareOption*`, `\ProcessOptions` | S:67-72 | yes | the conditional only picks `inputenc` and the string `\rsfbEncodage` (S:76-82), nothing laid out; emitter writes `\usepackage[french]{babel}` and drops `latin1` (Unicode engine) |
| `\rsfbExpedition` `\rsfbFacturation` `\rsfbLivraison` | S:107-109 | yes | `\newcommand` that stores a string for the table header row; inline expansion |
| `\rsfbNatureTableauProduits`, `\rsfbQuantiteTableauProduits`, `\rsfbPuTableauProduits`, `\rsfbNbDecimalesTableauProduits`, `\rsfbMonnaieTableauProduits`, `\rsfbSurTableauProduits` | S:113-125 | yes | aliases of calctab's `\ctdescription` `\ctheaderone` `\ctheadertwo` `\nprounddigits` `\ctcurrency` `\ctontraslation` (`tbl.calctab`) |
| `\rsfbChoisirUniteMonetaire` and `\rsfbchoisirUniteMonetaire` | S:141; B:50 | yes | stores `\euro`; printed only if called (commented out, B:54); inline expansion, no layout effect |
| `\rsfbAerationVerticale`, length `\rsfbespaceVertical` | S:155-156 | yes | `\newlength` + `\setlength`, then `\vspace`; `sp.lengths`, `sp.manual-space` |
| `\rsfbCompteBancaireCreancier` | S:163 | yes | stores an IBAN string used as text (N:141, N:226); inline expansion |
| `\rsfbNoDate` | S:172-178 | yes | stores two strings, then a `center` block with `\textcolor`, `\Huge`, `\large`; `sp.ragged`, `color.color`, `font.size-commands`; a second call would redefine via `\newcommand` and fail, the samples call it once (B:80, N:102) |
| `\rsfbEnteteTableauAdresses`, `\rsfbLigneTableauAdresses`, `\rsfbPiedTableauAdresses` | S:189-207 | yes | one `tabular` split over three macros (`begin` in S:191, `end` in S:206); written as one `tbl.tabular` with p-columns of 0.3\textwidth, `\hline`, `\emph` and `\textcolor` header |
| `\rsfbCompteBancaireEtDateLimiteDePaiement` | S:217-221 | yes | `flushright` block, `\emph{#1}`, fixed French words; `sp.ragged`, `mark.kernel` |
| `\rsfbCredit`, page style `fancy` | S:98-103 | yes | `hf.fancyhdr` calls, one `\fancyfoot[EOC]` |
| `\rsfbEncodage` | S:78, S:81 | yes | two string macros, unused in the samples |

## Content-opaque
- Four PNG images included in `figure` floats: `line_haut.png` and `line_bas.png` (decorative flourishes at the top and bottom of the page, B:224, B:231), `facture-banlieues-logo.png` (N:28), `facture-banlieues-sponsors.png` (N:248). They are included raster images, not TikZ or picture drawings, so they reduce to `fig.graphicx` with shipped assets and are not `ART`.
- Lorem ipsum filler and the sample address, amount and IBAN strings (B:102-109, B:163-165, B:193-195; N:135-141, N:195-196).
- The manual's explanatory French text and its sample tables (D:117-216).

## Lib changes
- New ways proposed: none. `inv.facture-belge` is used with `modeles-factures-belges-associations` as the package parameter: the commands repeat those of the lib line under the prefix `\rsfb` (address table, `xcalctab` product table, bank line, number and date block) and `fontspec` is loaded unconditionally in both. The consolidator may widen that line to name this package.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
