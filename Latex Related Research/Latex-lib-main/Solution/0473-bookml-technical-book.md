yes

# 0473-bookml-technical-book: BookML Technical Book

- Unverified: read from the source, not compiled.
- Source: Source/0473-bookml-technical-book/ (origin: https://latextemplates.com/downloads/bookml.zip; licence: GPL-3.0, LICENSE:1 and README.md:3-4)
- Kind: misc (the zip calls itself a technical-book starter, README.md:1; the sample is an `amsart` document with `\section` only, no chapters or parts, main.tex:1,18-42)
- Lib: v4
- Engine: pdfLaTeX-compatible (README.md:16 says "Compile the PDF with LuaLaTeX", but nothing in main.tex, bookml/bookml.sty or latexml.sty needs Lua or `fontspec`; main.tex:2-4 use `fontenc` T1, `babel`, `lmodern`)
- Look carried by: mixed (class `amsart` sets title block, headings, contents and running heads, main.tex:1; the preamble sets T1, babel, lmodern and hyperref colour links, main.tex:2-5; the zip-local `bookml/bookml.sty` and `latexml.sty` print nothing under TeX)
- Class origin: tex-distribution-unbundled (`amsart` is not in the zip; its source was not read)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (bookml/bookml.sty, bookml/bookml-init.sty, latexml.sty; the zip has no `.cls`)

## Verdict
yes. The printed document is `amsart` (british, oneside, 11pt) plus T1, babel, lmodern, hyperref and a `\bigskip` / `center` / `\small` copyright line, all published ways. The zip-local BookML and LaTeXML styles (not on CTAN: ctan.org/pkg/bookml and ctan.org/pkg/latexml are both 404, so they are zip-local under W1) are no-op stubs under TeX, so they reduce by deletion plus constant-folding of `\iflatexml\else...\fi` (never true under TeX, latexml.sty:15); the HTML, EPUB and SCORM output needs LaTeXML and a makefile the zip does not ship (README.md:11-13,16-17), but the PDF compile needs no tool, so this is not `EXTERNAL`. Scope caveat: I read "recovery" as the PDF look and structure the sample prints, so the LaTeXML-side hooks (`\bmlAltFormat`, `\bmlDescription`, `h:` environments) are dropped, and the unreached `\LaTeXML` logo macro (latexml.sty:57-69) would be `BESPOKE/package` if a document called it.

## Blockers
none

## Class setting
- Class: `class.amsart` options: `british` (passed on to `babel`), `oneside`, `11pt` (main.tex:1)
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (main.tex:10-12,15), `\tableofcontents` (main.tex:16), `\section` `\subsection` (main.tex:18,28). Not used: `\address`, `\email`, `\subjclass`, `abstract`, theorem styles, `\keywords`. The class source was not read (published, ships with the TeX distribution), so its default page size, margins, heading looks and running heads are recorded as class defaults.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.amsart` | british, oneside, 11pt |
| page size and layout | main.tex:1 | `page.class-options` | oneside, 11pt; no `geometry` or `\setlength` call in the sample, text block is amsart's default |
| font encoding | main.tex:2 | `font.fontenc-t1` | T1; no `inputenc` line |
| language | main.tex:3 (with main.tex:1) | `lang.babel` | package without options; the language is `british` from the global class option |
| text font | main.tex:4 | `font.lmodern` | load only |
| PDF metadata and links | main.tex:5,8 | `meta.hyperref` | `pdfusetitle`, `colorlinks`; `\hypersetup{pdfsubject={A compact BookML technical-book starter.}}` |
| title block | main.tex:10-12,15 | `front.maketitle` | `\title{A Data-Driven Technical Book}`, `\author{A. Researcher}`, `\date{2026}`, `\maketitle`; amsart's own rendering |
| contents | main.tex:16 | `toc.kernel` | `\tableofcontents` under amsart's class-defined layout |
| headings | main.tex:18,23,28,33,42 | `head.class-native` | `\section` and one `\subsection`, amsart default look and numbering; no `titlesec`, no counter changes |
| running heads and page numbers | main.tex:1 (no `\pagestyle` call in main.tex) | `hf.class-native` | amsart default page style for `oneside` |
| display equation | main.tex:35-38 | `math.kernel` | `\[ ... \]` display with `\,` and `\mathrm`; the formula is content |
| spacing before the closing line | main.tex:47 | `sp.manual-space` | `\bigskip` |
| centred closing line | main.tex:48-50 | `sp.ragged` | `center` environment (same kernel flush family as `\centering`) |
| closing line size | main.tex:49 | `font.size-commands` | `\small` |

BookML hooks (main.tex:6-7) are not a component row: they print nothing under TeX (see Bespoke code). The closing copyright text and `\copyright` (main.tex:49) are content.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `bookml/bookml.sty` (package, zip-local; not on CTAN, not an official release: the zip is a latextemplates.com starter that copies upstream files, README.md:3-14) | main.tex:6; bookml/bookml.sty:17-79 | yes | Whole PDF effect is empty: `\newif`s (:20-22), no-op `\DeclareOption`s (:24-33), `\newcommand\BookMLversion` (:37), a `latexml` load (:40-44), then only empty macros. Delete the `\usepackage` line. |
| `\bmlAltFormat{main.pdf}{PDF (serif)}` | main.tex:7; bookml/bookml.sty:47 | yes | `\providecommand{\bmlAltFormat}[2]{}`: expands to nothing; delete the call. Its only effect is an alternative-format link in LaTeXML's HTML, outside TeX. |
| `\bmlHTMLEnvironment`, `\bmlHTMLInlineEnvironment` (generate empty `h:<name>` environments) | bookml/bookml.sty:50-51 | yes | Defined, never called by the sample; omit. |
| `\def\<#1>{}` (HTML syntax, on by default) | bookml/bookml.sty:21-22,54-56 | yes | Defined, never used in the body (a `\<...>` in text would be swallowed); omit. |
| `\bmlRawHTML`, `\bmlDescription`, `\bmlPlusClass`, `\bmlDisableMathJax`, `bmlimage` environment | bookml/bookml.sty:59,69,73,76,79 | yes | All empty or `\relax`; omit. Main.tex:39 calls `\bmlDescription` by accident (the closing backtick of "`\bmlDescription`" becomes its argument, so one backtick is swallowed): a content slip, not a template look. |
| `preview` load under option `_bmlimages` | bookml/bookml.sty:30,62-67 | yes | Option is not set in main.tex:6, so the branch is not taken; build-tool mode, omit. |
| `bookml/bookml-init.sty` | bookml/bookml-init.sty:18-20 | yes | Not loaded by main.tex (only `bookml/bookml`, main.tex:6); omit. |
| `latexml.sty` (LaTeXML support style; NIST public domain, latexml.sty:6-8; not on CTAN) | loaded at bookml/bookml.sty:40-44; latexml.sty:15-176 | yes | Under TeX it loads `url` (:47, already loaded by `hyperref`) and `comment` (:100-104, three `\excludecomment` environments the sample never uses; considered: `comment` package, no lib line, not needed by the sample), and defines `\iflatexml` and no-op or alias macros. Omit the file. |
| `\iflatexml\else ... \fi` around the closing line | main.tex:46-51; latexml.sty:15 | yes | `\newif\iflatexml\latexmlfalse` and nothing ever sets it true under TeX, so constant-fold to the else branch: `\bigskip`, `center` with `\small` text (main.tex:47-50). |
| `\XML` `\SGML` `\HTML` `\XHTML` `\XSLT` `\CSS` `\MathML` `\OpenMath` | latexml.sty:38-45 | yes | `\providecommand` aliases of `\textsc{...}` (`mark.kernel`) or plain text; never called. |
| `\URL`, `\@URL`, `\@@URL` | latexml.sty:50-54 | yes | Never called; would reduce to `\url` (`meta.url`) or `\footnote{\texttt{...}}` (`fn.kernel`). |
| `\LXMID`, `\LXMRef`, `\lxDefMath` family, `\lxDeclare`, `\lxRefDeclaration`, table-head markers, `\lx*` hooks | latexml.sty:77-79,84-87,91,94,98,114-124,135-161 | yes | Empty, identity or `\providecommand` aliases (`\lxDefMath` is `\providecommand` wrapped, :145-156); never called; omit. |
| `\LaTeXML` logo | latexml.sty:57-69 | not reached | Hand-built box and kern logo (`\sbox`, `\vbox to\ht\z@`, `\fontsize\sf@size`, kerns, small caps `xml`); no lib way gives it exactly. The sample never calls it (main.tex has no `\LaTeXML`), so it is not in the emit model. If a document called it, it would be `BESPOKE/package`. |

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
