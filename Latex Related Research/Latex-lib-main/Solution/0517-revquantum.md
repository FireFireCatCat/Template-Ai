yes

# 0517-revquantum: revquantum (REVTeX 4.1 helper package for quantum-information papers)

- Unverified: read from the source, not compiled.
- Source: Source/0517-revquantum/ (origin: https://mirrors.ctan.org/macros/latex/contrib/revquantum.zip; licence: LPPL 1.3 (manifest `lppl1.3`; revquantum.dtx:5-8))
- Kind: journal (an add-on for a Physical Review A paper in REVTeX 4.1; the zip is a CTAN package source plus a sample, not a journal's own kit)
- Lib: v5
- Engine: pdfLaTeX-compatible (an optional XeTeX branch loads `fontspec` and TeX Gyre Pagella, revquantum.dtx:315-320, 533-541)
- Look carried by: mixed (the published class `revtex4-1` carries page, columns, title block, abstract, headings and references; the published package `revquantum`, whose source is the .dtx in the zip, sets fonts, links, listings, notation and affiliations; example.tex adds only option settings)
- Class origin: tex-distribution-unbundled (revtex4-1 v4.1s is its own CTAN package and in TeX Live, ctan.org/pkg/revtex4-1; it is not in the zip and its source was not read)
- Main file: example.tex (other samples: revquantum.dtx, the ltxdoc documentation driver at lines 33-43)
- Read: main yes, zip-local classes and styles all (no .cls or .sty ships; the whole revquantum.dtx and revquantum.ins were read; revtex4-1 itself was not)

## Verdict
`yes`, resting on one ruling that a reviewer should check: `revquantum` is a published package (CTAN, v0.11, LPPL 1.3, also in TeX Live; ctan.org/pkg/revquantum), so its code in the .dtx is not zip-local bespoke code. It passes W1 to W4 as a way: five boolean options, string declarators, and one preamble line plus body wrappers. The sample defines no macro of its own; everything it calls comes from `revtex4-1` or `revquantum`. Everything `revquantum` loads or configures also maps to an existing lib way (table below). The only part with no lib home is the package's own patch code for revtex4-1 internals. That code is reached by loading the package and is never copied by an emitter. If the new way were refused, three items would turn into `BESPOKE/package` blockers (the `\@bibdataout@aps` patch, the `\selectlanguage` alias patch, the `\equationautorefname` redefinition) and the answer would become `no`.

## Blockers
none

## Class setting
- Class: `class.revtex4-1` options: `pra`, `aps`, `twocolumn`, `superscriptaddress`, `10pt` (example.tex:1)
- Class-native vocabulary used: `\title` `\author` `\email` `\affiliation` (called through `\affilUSydPhys` and `\affilEQuSUSyd`, example.tex:10-15) `\date` `abstract` environment before `\maketitle` (example.tex:19-23), `\bibliography` (example.tex:35), `\appendix` `\section` `\label` (example.tex:41-45), `\cite` (example.tex:48). `\openone` is revtex4-1's, called by `\id` (revquantum.dtx:387; the doc note at 181-182 says so). The bibliography style is apsrev4-1 (the control record name `apsrev41Control`, revquantum.dtx:485). The class source was not read, so its own defaults are not described.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | example.tex:1 | `class.revtex4-1` | pra, aps, twocolumn, superscriptaddress, 10pt |
| point size | example.tex:1 | `page.class-options` | 10pt |
| columns | example.tex:1 | `cols.twocolumn-option` | twocolumn |
| page geometry, running heads, heading looks | example.tex:1 | `page.class-options`, `hf.class-native`, `head.class-native` | set by the class for journal `pra`, society `aps`; nothing in the zip sets them (class not read) |
| house-style package load | example.tex:2; revquantum.dtx:27,29,444-448 | `class.revquantum` | `pretty` and `uselistings` on; `final` off, `strict` off, `bibtexhacks` on (default; `nobibtexhacks` turns it off) |
| title | example.tex:10 | `front.maketitle`, `mark.kernel` | `\title{... \textsf{revquantum} ...}` |
| author, email, affiliations | example.tex:12-15 | `front.class-native` | `\author` `\email` `\affiliation`; `superscriptaddress` option |
| affiliation database | revquantum.dtx:814-820, 828-902 | `front.class-native`, `class.revquantum` | `\newaffil{short}{text}` defines `\affil<short>` as `\affiliation{text}`; 12 entries plus `\affilTODO` |
| date | example.tex:17 | `front.maketitle` | `\date{\today}` |
| abstract | example.tex:19-21 | `abs.class-native` | revtex4-1 `abstract` environment, placed before `\maketitle` |
| title block output | example.tex:23 | `front.maketitle` | `\maketitle` |
| TODO annotations | example.tex:20,32-33; revquantum.dtx:731-741,752-762,771-773,781,788-792 | `draft.todo` | `\todo{}` prints its argument in `magenta` (772) and warns; `final` makes it an error (731-735); `\TODO`, `\citeneed`, `\todolist{}` call it |
| todolist body | revquantum.dtx:788-792 | `list.kernel` | `itemize` inside `\todo` |
| operator notation | example.tex:29; revquantum.dtx:339-346 | `math.amsmath` | `\operatorname`: `\Tr` `\Cov` `\supp` `\diag` `\rank` |
| other notation | revquantum.dtx:352,359,365-367,373,380,387 | `math.kernel`, `math.amssymb` | `\ii`=`\mathrm{i}`, `\dd`=`\mathrm{d}`, `\e` `\TVD` `\T` in `\mathrm`, `\defeq`=`\mathrel{:=}`, `\expect`=`\mathbb{E}`, `\id`=`\openone` |
| AMS packages | revquantum.dtx:512-516 | `math.amsmath`, `math.amssymb`, `math.bm`, `thm.amsthm` | amsmath, amsfonts, amsthm, amssymb, amsbsy (bold math) |
| bra-ket | revquantum.dtx:529; README.md:72 | `math.physics` | `braket`: `\ket` `\bra` `\braket` |
| double brackets | revquantum.dtx:399-408 | `math.amssymb` | `stmaryrd` when installed (`\llbracket`); else two `\newcommand` fallbacks (406-407), dead code when the package exists |
| theorems | revquantum.dtx:561-562 | `thm.amsthm` | `\newtheorem{theorem}{Theorem}`, `\newtheorem{lemma}{Lemma}`; no `\theoremstyle`, so the default style |
| algorithms | revquantum.dtx:570-575 | `alg.algorithmicx`, `font.size-commands`, `mark.kernel` | `algorithm` + `algpseudocode`; `\algorithmicrequire`=`\textbf{Input:}`, `\algorithmicensure`=`\textbf{Output:}`; `\inlinecomment` and `\linecomment` wrap `\Comment` and `\State` in `\footnotesize` |
| graphics | revquantum.dtx:530 | `fig.graphicx` | load only |
| language | revquantum.dtx:531 | `lang.babel` | `english` |
| text and math face | revquantum.dtx:532-545 | `font.palatino` | `mathpazo` under pdfTeX (543); with XeTeX: `font.fontspec` with `\setmainfont` of texgyrepagella otf files (535-541) |
| listing mono face | revquantum.dtx:603-606 | `font.mono` | `sourcecodepro` and `\lstset{basicstyle=\footnotesize\sourcecodepro}`, XeTeX only |
| text symbols | revquantum.dtx:549 | `font.fontenc-t1` | `textcomp`, loaded for the backtick in Mathematica |
| colours | revquantum.dtx:517-528,547,588,800-807 | `color.xcolor`, `color.color` | `xcolor` with `uselistings` (547); `color[usenames,dvipsnames]` otherwise (520); `comment-color` gray 0.5; eight `cud-*` RGB colours (800-807) |
| code listings | revquantum.dtx:546-548,587-630; example.tex:48-50 | `code.listings` | `\lstset{basicstyle=\footnotesize, commentstyle, frame=lines, gobble=4, numbers=left, numberstyle=\tiny, stepnumber=5, numbersep=5pt, keywordstyle, keywordstyle=[2], emphstyle}` (590-601); styles `matlab`, `python`, `mathematica` (608-629: language, mathescape, showstringspaces=false, morekeywords, upquote, literate); the sample uses `style=python,gobble=4,caption={...}` |
| links | revquantum.dtx:916-923 | `meta.hyperref` | `breaklinks=true`; `colorlinks=true`, `urlcolor=blue`, `linkcolor=blue`, `citecolor=red` |
| autoref names | revquantum.dtx:934-936,943-945,953-955,962-964 | `xref.hyperref` | `\sectionautorefname`=Section, `\algorithmautorefname`=Algorithm, `\lemmaautorefname`=Lemma, `\equationautorefname` prints `(n)`; all set at `\AtBeginDocument` |
| label and reference | example.tex:45 | `xref.kernel` | `\label{apx:code}` |
| appendix | example.tex:41 | `num.appendix` | `\appendix` |
| section | example.tex:44 | `head.class-native` | `\section{Source Code}` (revtex4-1 sectioning) |
| listing caption with citation | example.tex:48 | `code.listings`, `bib.bibtex-bst` | `caption=` key of listings; `\cite{johansson_qutip_2013}` |
| bibliography | example.tex:35; revquantum.dtx:482-491,713-717 | `bib.bibtex-bst` | apsrev4-1 control record (`author="08",editor="1",pages="0",title="0",year="1",eprint="1"`); `\doibase` prefix `https://dx.doi.org/`; `example.bib` is not in the zip |
| support packages | revquantum.dtx:296,310,551-554 | `class.revquantum` | `ifthen`, `iftex` (optional), `letltxmacro`, `etoolbox`: macro-programming helpers with no printed effect |
| documentation driver (second sample) | revquantum.dtx:33-43 | `class.ltxdoc`, `dtx.doc` | `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges` `\DocInput` `\PrintChanges` `\PrintIndex`; `\usepackage[pretty]{revquantum}[2015/12/29]` |
| documentation macro | revquantum.dtx:78-82 | `dtx.doc`, `color.xcolor` | `\DescribeColor` = `\DescribeMacro` plus a coloured bullet |

## Bespoke code
All items below sit in revquantum.dtx (the source of the published package, scope `package`). By W1 they are published code, not zip-local. They are still listed with the reduction an emitter would need if it did not load the package.
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newnew`, `\newoperator`, `\newrm` generators | revquantum.dtx:330-346,365-367 | yes | static expansion: `\newcommand{\Tr}{\operatorname{Tr}}` and four more; `\e` `\TVD` `\T` as `\mathrm{..}` (`math.amsmath`, `math.kernel`) |
| `\ii` `\dd` `\defeq` `\expect` `\id` | revquantum.dtx:352-387 | yes | `\newcommand` aliases (`math.kernel`, `math.amssymb`, class `\openone`) |
| `\booloption`, `\ProcessOptions`, five booleans | revquantum.dtx:419-450 | yes | option plumbing; the emitter resolves it by writing the option list |
| engine switch `\ifXeTeX` and the branches it drives | revquantum.dtx:306-320,532-545,603-606 | yes | the emitter picks the branch for its engine (`font.palatino`, or `font.fontspec` and `font.mono`) |
| warning macros `\rq@quasiwarn`, `\rq@warnpackage`, `\PackageWarning` calls | revquantum.dtx:460-468,644-658 | yes | no printed effect, dropped |
| `\todo` family | revquantum.dtx:731-792 | yes | `{\color{magenta} #1}` (`draft.todo`, `color.xcolor`); `final` only changes a log message to an error |
| `\newaffil` database | revquantum.dtx:814-902 | yes | `\newcommand` aliases of `\affiliation{..}`, expanded as strings |
| `\inlinecomment` `\linecomment` | revquantum.dtx:574-575 | yes | `\newcommand` aliases over `alg.algorithmicx` commands |
| `\AtBeginDocument` name settings | revquantum.dtx:934-964 | yes | string assignments placed at the end of the preamble (`xref.hyperref`) |
| `\@bibdataout@aps` patch (writes the BibTeX control record into revtex4-1's notes file) | revquantum.dtx:482-491 | no, without the package | the six control values are a parameter of the apsrev4-1 `.bst` (`bib.bibtex-bst`), but injecting them into revtex4-1's output stream patches a class internal; reached by loading the package |
| `\selectlanguage` wrapper and `\definelanguagealias` (`en`, `EN`, `English` to `english`) | revquantum.dtx:674-701 | no, without the package | compatibility patch (`\LetLtxMacro`, `\edef` trick) so revtex4-1 bibliographies do not raise babel errors; no printed effect, reached by loading the package |
| `\doibase` redefinition | revquantum.dtx:713-717 | partly | link-target prefix `https://dx.doi.org/` (`meta.hyperref`); a one-line macro with `\ifdefempty`, reached by loading the package |
| `\equationautorefname~#1\null` delimited redefinition | revquantum.dtx:953-955 | no, without the package | makes `\autoref` of an equation print `(n)`; depends on hyperref's argument delimiter; reached by loading the package |

README.md:25 uses `\affilEQUS`, which revquantum.dtx does not define (it defines `\affilEQuSUSyd`, 836); the shipped example.tex:15 uses the right name. Install.ps1 (PoShTeX installer, pandoc template named at Install.ps1:17 but absent from the zip) is not part of the compiled document; the style itself is generated by DocStrip from revquantum.ins:38.

## Content-opaque
- code listing text `>>> import qutip as qt` (example.tex:49)
- `example.bib`, cited by `\bibliography{example}` (example.tex:35), is not in the zip (missing asset, content)
- prebuilt example.pdf and revquantum.pdf are outputs, not inputs

## Lib changes
- New ways proposed: `class.revquantum` - package `revquantum` (CTAN macros/latex/contrib, TeX Live, LPPL 1.3; C. Granade; v0.11 of 2017-03-15; engine pdf with an optional XeTeX branch): an add-on for REVTeX 4.1 quantum-information papers. `\usepackage[pretty,uselistings,final,nobibtexhacks,strict]{revquantum}` (five booleans), declarators `\newaffil{short}{text}` `\newoperator{name}` `\newrm{name}` `\definelanguagealias{a}{b}`, review commands `\todo{}` `\TODO` `\todolist{}` `\citeneed`, notation `\ii \dd \defeq \expect \id`, 12 affiliation shortcuts, `cud-*` colours; it loads amsmath, amsfonts, amsthm, amssymb, amsbsy, braket, graphicx, babel, algorithm, algpseudocode, hyperref, letltxmacro, etoolbox. W1: on CTAN and in TeX Live (read ctan.org/pkg/revquantum). W2: behaviour is chosen by the five booleans and by string arguments; nothing needs editing. W3: it serves any paper under revtex4-1, not this sample (the sample uses only options and commands). W4: one preamble line, plus body wrappers `\todo{..}` and affiliation commands. Filed as a doc-kind way beside `essay.essaykit` and `report.practicalreports`; it is not a class, so not `class.*`. Considered and rejected as homes: `draft.todo` (only the review commands), `front.class-native` (only the affiliation commands).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
