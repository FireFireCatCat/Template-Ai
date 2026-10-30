yes

# 0146-extsizes: the extsizes classes (extarticle, extreport, extbook, extletter, extproc) and their manual

- Unverified: read from the source, not compiled.
- Source: Source/0146-extsizes/ (origin: https://mirrors.ctan.org/macros/latex/contrib/extsizes.zip; licence: LPPL)
- Kind: misc (the sample is a package manual; the manifest hint `book` comes from the CTAN category)
- Lib: v3
- Engine: pdfLaTeX-compatible (T1 + `lmodern`, `microtype`, `hyperref[unicode=true]`; `etex` is e-TeX register allocation, which pdfTeX has)
- Look carried by: mixed (the sample is the published KOMA class `scrartcl` plus a short preamble: font packages, `microtype`, `hyperref`, two `\addtokomafont` calls; the zip's own five classes are published CTAN classes the sample does not load)
- Class origin: ctan
- Main file: extsizes.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (extarticle.cls, extletter.cls, extproc.cls, extsizes.sty, autopagewidth.sty, size14.clo in full; extreport.cls, extbook.cls and size8/9/17/20.clo as complete diffs against a fully read sibling; the `scrartcl` source is not bundled and was not read)

## Verdict
yes. The one sample, `extsizes.tex`, is a `scrartcl` document: class options, seven preamble packages, two `\addtokomafont` calls, a title block, six numbered sections, two `verbatim` blocks and a `flushleft` address block, all of which map onto lib ways. Its six helper macros are text aliases and reduce to `\texttt`, `\textsf` and `\href` at each call site. The zip's own classes and `extsizes.sty` are the published CTAN package `extsizes` (ctan.org/pkg/extsizes lists the five classes and the package, in TeX Live), so they are class ways, not zip-local code; no `ART`, no `EXTERNAL`. The only unmapped items, `fixltx2e` and `etex`, are load-only packages with no printed effect and get one proposed way.

## Blockers
none

## Class setting
- Class: `class.scrartcl` options: `DIV=9`, `headings=normal`, `pagesize=auto` (extsizes.tex:1). KOMA-Script is not in the zip (tex-distribution-unbundled; source not read).
- Class-native vocabulary used: `\addtokomafont{title}` and `\addtokomafont{section}` (extsizes.tex:20-21); `\title`, `\author` with `\and`, `\date{}`, `\maketitle` (extsizes.tex:23-25,30); `\section` (extsizes.tex:45,58,70,94,101,110).
- Published classes the zip ships and the sample does not load (all five are class ways, source read): `class.extarticle`, `class.extreport`, `class.extbook`, `class.extletter`, `class.extproc`. Shared options: papers `a4paper a5paper b5paper letterpaper legalpaper executivepaper landscape` (extarticle.cls:29-50), sizes `8pt 9pt 10pt 11pt 12pt 14pt 17pt 20pt` (extarticle.cls:51-58), `oneside twoside draft final titlepage notitlepage onecolumn twocolumn leqno fleqn openbib` (extarticle.cls:60-79); `extreport`/`extbook` add `openright openany` (extreport.cls:66-67). Native vocabulary: extarticle `\maketitle` `abstract` `\section`..`\subparagraph` (extarticle.cls:230,402); extreport `\chapter` `\part` `\appendix` (extreport.cls:350,301,519); extbook `\frontmatter` `\mainmatter` `\backmatter` `\chapter` (extbook.cls:294,298,302,358); extletter `letter` environment, `\name` `\signature` `\address` `\location` `\telephone`, `\opening` `\closing` `\cc` `\encl` `\ps` `\makelabels` (extletter.cls:162-166,172,181,230,243,255,260,265); extproc `\maketitle` over `\twocolumn[...]`, `\copyrightspace`, `\pagename` (extproc.cls:51,75,80).

## Component map
Sample rows first, then the shipped bundle (not loaded by the sample).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | extsizes.tex:1 | `class.scrartcl` | DIV=9, headings=normal, pagesize=auto |
| page geometry | extsizes.tex:1 | `page.typearea` | `DIV=9`, `pagesize=auto` through the class; no `geometry` or length call in the sample |
| heading look | extsizes.tex:1 | `head.class-native` | `headings=normal` |
| heading and title fonts | extsizes.tex:20-21 | `head.koma-fonts` | `\addtokomafont{title}{\rmfamily}`, `\addtokomafont{section}{\rmfamily}` |
| title block | extsizes.tex:23-25,30 | `front.maketitle` | `\title`, `\author{A, \mail{..}\and B, \mail{..}}`, `\date{}` (empty), `\maketitle` |
| sections | extsizes.tex:45,58,70,94,101,110 | `head.kernel` | numbered `\section` only, no format change in the sample |
| text face | extsizes.tex:5 | `font.lmodern` | `lmodern` |
| encodings | extsizes.tex:6-7 | `font.fontenc-t1` | `[T1]{fontenc}`, `textcomp` |
| microtypography | extsizes.tex:8 | `sp.microtype` | no options |
| PDF links and metadata | extsizes.tex:9 | `meta.hyperref` | `unicode=true` |
| e-mail links | extsizes.tex:11,24,123,125 | `xref.hyperref` | `\href{mailto:addr}{\texttt{addr}}` (a hyperref link command) |
| compat loads | extsizes.tex:3-4 | `NEW:sys.compat-load` | `fixltx2e`, `etex`, both without options |
| inline markup | extsizes.tex:12-14,18,33,49,65-66 | `mark.kernel` | `\textsf`, `\texttt`, `\textbackslash`, kernel logos `\LaTeX` `\TeX`, `\,` `\@` |
| verbatim code | extsizes.tex:74-76,80-82,97 | `code.verbatim` | `verbatim` environment, `\verb+..+` |
| paragraph and spacing | extsizes.tex:32,119,123,125 | `sp.lengths` | `\noindent` (per-paragraph `\parindent`=0) |
| manual spacing | extsizes.tex:119,123,125 | `sp.manual-space` | `\bigskip`, `\quad` |
| ragged block | extsizes.tex:121-128 | `sp.ragged` | `flushleft` environment with `\\` breaks |
| header/footer, page numbers | extsizes.tex (no call) | `hf.class-native` | none set; scrartcl default page style applies |
| base type size and paper | extarticle.cls:29-58 | `page.class-options` | options `a4paper`..`executivepaper`, `landscape`, `8pt`..`20pt` (default `letterpaper,10pt`, extarticle.cls:80) |
| class: article-like | extarticle.cls:22 | `class.extarticle` | options above; defaults `oneside,onecolumn,final`; `titlepage` false (extarticle.cls:28) |
| class: report-like | extreport.cls:22 | `class.extreport` | adds `openright`/`openany` (extreport.cls:66-67); `titlepage` true (extreport.cls:28) |
| class: book-like | extbook.cls:6 | `class.extbook` | defaults `twoside,openright` (extbook.cls:67); 10-12pt load the stock `bk1x.clo` (extbook.cls:126-130) |
| class: letter-like | extletter.cls:6 | `class.extletter` | `\parskip` 0.7em, `\parindent` 0 (extletter.cls:110-111); page styles `headings` `firstpage` (extletter.cls:130-157) |
| class: proceedings | extproc.cls:6 | `class.extproc` | `\LoadClass{extarticle}` (extproc.cls:20); a5paper, b5paper, onecolumn, titlepage raise `\ClassError` (extproc.cls:9-16) |
| exscale in the classes | extarticle.cls:140 | `font.exscale` | `\RequirePackage{exscale}`; same at extreport.cls:142, extbook.cls:131, extletter.cls:106 |
| large-size font shapes | extarticle.cls:82-138 | `font.nfss` | `\DeclareFontShape` for T1/cmr and OT1/cmr to 51.59pt; same block in extreport, extbook, extletter.cls:48-104, extsizes.sty:23-79 |
| size tables | size14.clo:11-170 | `class.extarticle` (internal) | per-size `\normalsize`..`\Huge`, list and float lengths, text block (size14.clo:62-86); five files, size8/9/14/17/20, read |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\mail` | extsizes.tex:11 | yes | each call becomes `\href{mailto:addr}{\texttt{addr}}`: `xref.hyperref` + `mark.kernel` |
| `\pkg`, `\cls` | extsizes.tex:12-13 | yes | `\textsf{name}`: `mark.kernel` |
| `\cs` | extsizes.tex:14 | yes | `\texttt{\textbackslash name}`: `mark.kernel` |
| `\cmd` | extsizes.tex:15-17 | yes | strips the backslash with `\expandafter\@gobble\string` to print a control-sequence name; every argument is a literal control sequence (extsizes.tex:105,107,114), so each call becomes `\texttt{\textbackslash name}`; it changes no layout |
| `\opt` | extsizes.tex:18 | yes | `\texttt{value}`: `mark.kernel` |
| extarticle, extreport, extbook, extletter, extproc, size*.clo, extsizes.sty | zip root | not bespoke | published CTAN package `extsizes` (LPPL); class ways, not read as bespoke. Their internal `\@startsection`-style kernel redefinitions are the published class's own code |
| `autopagewidth.sty` | autopagewidth.sty:1-57 | not loaded | in the CTAN bundle but unloaded by the sample, every class and `extsizes.sty` (grep: no `\usepackage{autopagewidth}`); self-described "experimental ... for evaluation only" (autopagewidth.sty:2-7). It sets `\textwidth` from the width of a 70-character string and derives margins (autopagewidth.sty:13-57): a computed layout that needs font metrics, so it would not reduce to declarative lengths. Not a blocker here because nothing loads it; a template that did load it would need its own load-only way (considered: `autopagewidth`) |
| `extsizes.sty` `\newcommand` override | extsizes.sty:80-85 | not loaded | the published package temporarily makes `\newcommand` unconditional around `\input{size\@ptsize.clo}`; the sample only mentions the package in prose (extsizes.tex:87-91). Considered: `extsizes` as a package way for base size by package option 8pt to 20pt (extsizes.sty:14-21); not proposed because no sample loads it |

## Content-opaque
none

## Lib changes
- New ways proposed: `NEW:sys.compat-load` `fixltx2e` (LaTeX base kernel-fix package) and `etex` (CTAN `etex-pkg`, in TeX Live; moves register allocation to the extended e-TeX ranges), pdfLaTeX, load-only. W1: both are published (kernel distribution; ctan.org/pkg/etex-pkg). W2: no options, a load-only switch, as `font.exscale`. W3: serves any document, not this one. W4: one `\usepackage{...}` preamble line each. Neither prints anything, so the consolidator may instead rule them "not a component"; they are the only items the existing lib could not place. The `fixltx2e` remark (kernel shim since 2015) is general knowledge, not read from the zip.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
