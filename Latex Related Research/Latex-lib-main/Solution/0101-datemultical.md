no

# 0101-datemultical: datemultical (named dates and multi-calendar formatting; the package and its manual)

- Unverified: read from the source, not compiled.
- Source: Source/0101-datemultical/ (origin: https://mirrors.ctan.org/macros/latex/contrib/datemultical.zip; licence: LPPL 1.3c)
- Kind: misc (a CTAN package plus its own manual; the manifest hint `calendar` is wrong, the sample is a package manual and not a calendar)
- Lib: v2
- Engine: needs LuaLaTeX (`% !TeX program = lualatex` at doc/datemultical.tex:1; babel `bidi=basic` with `\babelprovide` and `\babelfont` at :19-27; the 54-calendar table at :730-783 needs the package's Lua backend; `minted` at :10)
- Look carried by: preamble (the manual is `article` plus packages and a few lengths and colours set in doc/datemultical.tex:3-73; the zip's `.sty` and `.def` files are the published datemultical package, not a look-setting class)
- Class origin: tex-distribution-unbundled (`article` is the kernel class, not in the zip)
- Main file: doc/datemultical.tex (other samples: none; doc/datemultical.pdf is the compiled manual, not read as source; README.md:47-54 has an 8-line usage snippet only)
- Read: main yes, zip-local classes and styles all (datemultical.sty, datemultical-engine.sty, datemultical-engine.lua, and the .def files base, captions, facap, format, engine-gr, engine-sh, engine-lh, engine-jdn; the 24-line licence headers of the .def files were checked for non-comment lines by grep only)

## Verdict
no. The sample loads `minted` unconditionally and uses it for four code listings, and `minted` needs shell escape and pygments, a tool outside TeX (`EXTERNAL/package`, pilot ruling). Everything else maps to lib ways. The datemultical package itself is published (CTAN and TeX Live, confirmed by one ctan.org/pkg/datemultical read) and its commands take only strings, integers, key=value lists and two options, so I propose it as one new way, `front.datetime`. Its internals (expl3 arithmetic and a Lua engine over `lua-calendrica`) are the package's implementation, not copied zip-local macro logic. With `minted` removed I found nothing else that would block a `yes`, but the new way and the `\calentry` judgement call below would still need a reviewer's confirmation.

## Blockers
- `EXTERNAL/package` `minted` is loaded in the sample preamble (doc/datemultical.tex:10), configured by `\setminted` (:41-48) and called by four `minted` environments (:265, :502, :514, :654); it needs shell escape and pygments.

No other blocker: no ART, no irreducible BESPOKE, no UNMAPPED.

## Class setting
- Class: `class.article` options: `10pt` (doc/datemultical.tex:3). Kernel class, source not read (not in the zip).
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (:60-73, :88), `abstract` environment (:91-103), `\section` `\subsection` (:111, :213, :215, :237, :259, :532, :534, :624, :658, :698, :802), `table` float, `itemize`, `center`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | doc/datemultical.tex:3 | `class.article` | 10pt |
| page size | doc/datemultical.tex:3 | `page.class-options` | 10pt only; no paper option, no geometry package: paper, margins and text block are the class defaults |
| microtype | doc/datemultical.tex:5 | `sp.microtype` | defaults |
| paragraph shape | doc/datemultical.tex:50-51 | `sp.lengths` | `\parindent`=0pt, `\parskip`=4pt |
| fonts | doc/datemultical.tex:25-27 | `lang.babel` | `\babelfont{rm}{Times New Roman}`, `\babelfont[persian]{rm}{Vazirmatn}`, `\babelfont{tt}{JetBrains Mono}`; `\babelfont` is a babel command that drives fontspec itself (considered: `font.fontspec`, not written by the sample); the three fonts are not shipped (missing assets, ship them) |
| language and direction | doc/datemultical.tex:19-24, :674-688 | `lang.babel` | option `bidi=basic`; `\babelprovide[main,import]{english}`; `\babelprovide[import,mapdigits]{persian}`; inline `\foreignlanguage{persian}{...}` (considered: the `bidi` package, not loaded) |
| colours | doc/datemultical.tex:7, :38-39 | `color.xcolor` | `codebg` gray 0.96, `codeframe` gray 0.82 (used only by `\setminted`) |
| hyperlinks | doc/datemultical.tex:18, :797 | `meta.hyperref` | option `hidelinks`; `\url{...}` in a `center` (`meta.url`) |
| URL | doc/datemultical.tex:797 | `meta.url` | one `\url` of hyperref's URL handling |
| title block | doc/datemultical.tex:60-64, :88 | `front.maketitle` | `\title{{\Huge\bfseries \texttt{datemultical} Package }\par \large ...}`, `\author{Amer Amikhteh}`, `\maketitle` |
| title fonts | doc/datemultical.tex:60-61 | `font.size-commands` | `\Huge`, `\large`; `\bfseries` and `\texttt` are `mark.kernel` |
| title-block date | doc/datemultical.tex:70-73 | `front.maketitle` + `front.datetime` | `\date{Version ...\\[2pt] \dmc{datemultical}{long}}`; the `\\[2pt]` break is `sp.manual-space` |
| version and date inputs | doc/datemultical.tex:66, :68, :71 | content (published `pkgmeta`, CTAN) | `\pkgmeta[year\|month\|day\|version]{datemultical}` returns the `\ProvidesPackage` date and version (datemultical.sty:29-30: 2026/10/18 v0.2.0); an emitter writes these as literals (considered: `pkgmeta` as its own way, rejected: its output is text) |
| named dates | doc/datemultical.tex:16, :67-68 | `front.datetime` | `\usepackage[persian]{datemultical}`; `\dmcset{datemultical}{y}{m}{d}`; calendar key is the optional argument (`gr` default, `sh`, `lh`) (datemultical-base.def:292-300) |
| first-page style | doc/datemultical.tex:89 | `hf.pagestyle-kernel` | `\thispagestyle{empty}`; no header or footer package; later pages keep the article default |
| abstract | doc/datemultical.tex:91-103 | `abs.kernel` | plain `abstract` environment |
| headings | doc/datemultical.tex:111, :215 | `head.kernel` | article defaults, default numbering, no `\titleformat` |
| heading spacing | doc/datemultical.tex:9, :35-36 | `head.titlesec` | `\titlespacing*{\section}{0pt}{8pt}{3pt}`; `\titlespacing*{\subsection}{0pt}{6pt}{2pt}`; only spacing, no format changes |
| lists | doc/datemultical.tex:152, :539, :805 | `list.kernel` | `itemize` |
| list spacing | doc/datemultical.tex:8, :54 | `list.enumitem` | `\setlist{nosep,leftmargin=*}` |
| tables, rules | doc/datemultical.tex:6, :121-144, :173-203, :216-235, :238-256, :627-650, :661-691 | `tbl.tabular` + `tbl.booktabs` | `tabular` with `\toprule` `\midrule` `\bottomrule`; `\textbf` header cells; `\centering\small` or `\centering\scriptsize` (`sp.ragged`, `font.size-commands`) |
| table lengths | doc/datemultical.tex:52-53, :243 | `tbl.tabular` | `\tabcolsep`=4pt (2pt in the command table), `\arraystretch`=1.1 |
| table, stretch column | doc/datemultical.tex:6, :56, :125 | `tbl.tabularx` | `tabularx{\textwidth}{@{}lYl@{}}`; `\newcolumntype{Y}{>{\raggedright\arraybackslash}X}` is an `array` command with `\raggedright` (`sp.ragged`) |
| long tables | doc/datemultical.tex:13, :272-495, :708-786 | `tbl.longtable` | `xltabular{\linewidth}{l l X l}` and `{0.7\linewidth}{c l Y}`; `\endfirsthead` `\endhead` `\endfoot` `\endlastfoot`; `\hline` rules; `\multicolumn` (kernel tabular) |
| float placement | doc/datemultical.tex:12, :238, :627, :661 | `fig.float` | `float` package for `[H]`; `[h!]` elsewhere (:121, :173, :216) |
| captions | doc/datemultical.tex:122, :174, :217, :239, :273, :628, :662, :709 | `cap.kernel` | kernel `\caption` above the table; no `caption` package |
| labels | doc/datemultical.tex:123, :175, :218 | `xref.kernel` | `\label{tab:...}`; the sample defines labels and never calls `\ref` (grep) |
| manual spacing | doc/datemultical.tex:176, :219, :241, :630, :664 | `sp.manual-space` | `\vspace{2pt}` after the caption |
| inline code | doc/datemultical.tex:231, :249-253, :261, :537, :636-647, :671-688, :693 | `code.verbatim` | `\verb|...|` and `\texttt` (`mark.kernel`) |
| code listings | doc/datemultical.tex:10, :41-48, :265, :502, :514, :654 | `code.minted` | `\setminted{bgcolor=codebg, frame=single, rulecolor=codeframe, fontsize=\small, breaklines=true, tabsize=2}`; `minted{latex}` four times; **EXTERNAL** |
| TeX engine logos | doc/datemultical.tex:11, :30-32 | `font.icons` | `\hologo{LuaLaTeX}`, `\hologo{XeLaTeX}`, `\hologo{pdfLaTeX}` (hologo, CTAN): a logo-name argument prints a pictogram; closest existing way, with the package as parameter (considered: a new `font.icons`, not proposed) |
| text aliases | doc/datemultical.tex:33, :57 | `mark.kernel` | `\textsf{XePersian}`, `\newcommand{\pkg}[1]{\textsf{#1}}` |
| calendar outputs in cells | doc/datemultical.tex:249-253, :636-647, :672-688, :730-783 | `front.datetime` | `\dmcset`, `\dmcget`, `\dmcformat`, `\dmcstyle`, `\dmc[c]{n}{s}`, `\Miladi` `\Shamsi` `\Ghamari` and the other wrappers (datemultical-format.def:522-662) |
| package options | datemultical.sty:39-50 | `front.datetime` | `native` (select the TeX backend under LuaLaTeX), `persian` (Persian names; also set automatically for `xepersian` or language `persian`/`farsi`, datemultical.sty:81-107) |
| backend choice | datemultical-engine.sty:44-48, :83-100 | `front.datetime` | LuaTeX: Lua backend (`require("datemultical-engine")`, calendars from `lua-calendrica`, in TeX Live); other engines or `native`: expl3 backend for `gr` `sh` `lh` only |
| date patterns and presets | datemultical-format.def:249-513, :546-552, :600-633 | `front.datetime` | pattern tokens `yyyy yy y MMMM MMM MM M dd d EEEE EEE u ww w U R ...`; presets `full long medium short ISO ISOext american british ...`; `\dmcstyle[c]{name}{pattern}` redefines a preset |
| appendix, bibliography, index, ToC, footnotes, theorems | none | none | the sample has none of these |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| datemultical package: `datemultical.sty`, `datemultical-engine.sty`, `datemultical-engine.lua`, `datemultical-{base,captions,facap,format,engine-gr,engine-sh,engine-lh,engine-jdn}.def` | datemultical.sty:29-30; datemultical-engine.lua:28 | Not bespoke: published (CTAN, TeX Live) | The emitter writes `\usepackage[persian]{datemultical}` and the `\dmc...` commands; none of this code is copied. The expl3 JDN arithmetic (engine-gr/sh/lh.def) and the Lua engine are the package's own implementation of its way. `datemultical-engine-jdn.def:30` declares itself `datemultical-engine-rd.def` (a name slip, no effect on the look) |
| `\calentry{id}` and counter `calentrycount` | doc/datemultical.tex:77-84 | Reducible (judgement call) | the counter only numbers 54 table rows (`\stepcounter`, `\thecalentrycount`), which are cell content; write each row literally as `n & \texttt{id} & \dmc[id]{birth}{short}\\` inside `xltabular` (`tbl.longtable`). If a reviewer counts a printed counter as irreducible, this is `BESPOKE/body` |
| `\LuaLaTeXLogo` `\XeLaTeXLogo` `\pdfLaTeXLogo` `\XePersianLogo` | doc/datemultical.tex:30-33 | Reducible | aliases of `\hologo{...}` (`font.icons`) and `\textsf` (`mark.kernel`) |
| `\pkg` | doc/datemultical.tex:57 | Reducible | alias of `\textsf` (`mark.kernel`) |
| `\newcolumntype{Y}` | doc/datemultical.tex:56 | Reducible | `array` declaration, `>{\raggedright\arraybackslash}X` (`tbl.tabularx` with `sp.ragged`) |
| fallback `\lr` and `\rl` | datemultical-facap.def:135-138 | Not bespoke (package internals) | `\ProvideDocumentCommand` identity fallbacks inside the published package |

## Content-opaque
- Four `minted` listings (doc/datemultical.tex:265-267, :502-505, :514-517, :654-656): code text is content, but the `minted` environment itself is the `EXTERNAL` blocker.
- Calendar output cells computed by the package at compile time (doc/datemultical.tex:249-253, :636-647, :672-688, :730-783): table cell contents.
- Persian-script month and weekday names (datemultical-facap.def:39-127): package data.

## Lib changes
- New ways proposed: `front.datetime`: `datemultical` (CTAN, LPPL 1.3c, in TeX Live), `\usepackage[native,persian]{datemultical}`; basic backend works under pdfLaTeX (calendars `gr` `sh` `lh`, expl3), Lua backend needs LuaLaTeX (54 calendars through `lua-calendrica`), so the engine tag is `pdf` for the basic backend and `xe/lua` for the sample's use. W1: published on CTAN and in TeX Live (ctan.org/pkg/datemultical). W2: two options plus string, integer and key=value arguments (calendar key, name, y/m/d, pattern string, style name, `\dmcnew` keys), no code editing. W3: serves any document that prints a named date in a chosen calendar, not one document. W4: preamble `\usepackage` line plus a `\dmcset` declaration and inline `\dmc[c]{n}{s}` calls inside a node's content. Nearest existing way is `front.datetime` (`datetime`/`datetime2` `\newdateformat` and `\today`); datemultical differs by naming dates, converting between calendars and printing without `\today`, so the consolidator may instead fold it into `front.datetime` with the package as the parameter, as was done for `tbl.nicematrix` into `tbl.nicematrix`.
- Considered, not proposed: `hologo` as `font.icons` (kept in `font.icons`), `pkgmeta` (content source), `bidi` package (not loaded; babel's own `bidi=basic` is used).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
