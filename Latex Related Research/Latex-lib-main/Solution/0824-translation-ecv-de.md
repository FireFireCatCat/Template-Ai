yes

# 0824-translation-ecv-de: ecv German manual (ltxdoc .dtx of the ecv CV class)

- Unverified: read from the source, not compiled.
- Source: Source/0824-translation-ecv-de/ (origin: https://mirrors.ctan.org/info/translations/ecv/de.zip; licence: lppl per manifest; the file's own notice at ecvde.dtx.tex:47-49 grants free copying)
- Kind: misc (a German class manual in DocStrip `.dtx` form; the manifest hint `cv` names the documented class, no CV is typeset)
- Lib: v6
- Engine: pdfLaTeX-compatible (T1, utf8 inputenc, babel; the shipped PDF carries the producer string pdfTeX-1.40.12, TeX Live 2011)
- Look carried by: class (the published `ltxdoc` manual look; the driver only adds fontenc/inputenc/babel, two lengths and doc switches at ecvde.dtx.tex:59-74)
- Class origin: tex-distribution-unbundled
- Main file: ecvde.dtx.tex (other samples: none; ecvde.dtx.pdf is the shipped compiled output, binary, not read beyond its producer string)
- Read: main yes, zip-local classes and styles none present (the ecv class and its three support files exist only as code text inside the .dtx, and that code was read in full, ecvde.dtx.tex:579-1306)

## Verdict
yes. The sample is a DocStrip driver: `\documentclass{ltxdoc}` with fontenc, inputenc, babel and the doc switches (ecvde.dtx.tex:58-77), two length assignments (73-74), then `\DocInput` of the file itself. The driver and the roughly 490 lines of documentation prose (82-574) use only kernel commands and ltxdoc/doc vocabulary, all of it in existing lib ways, and define no macro of their own. The ecv class, `ecvNLS.sty` and the two `.ldf` files appear only as `macrocode` text (582-1302), never loaded by the sample (no `ecv.ins` in the zip), and the class they document is published (ecv on CTAN and in TeX Live), so there is no zip-local bespoke code and no ART blocker. No new way was needed.

## Blockers
none

## Class setting
- Class: `class.ltxdoc` options: none (ecvde.dtx.tex:58). Source of ltxdoc not in the zip, not read.
- Class-native vocabulary used: `\DocInput` (77), `\CodelineNumbered` (64), `\EnableCrossrefs` (65), `\CodelineIndex` (67), `\RecordChanges` (69), `\GetFileInfo` (71), `\PrintChanges` (88), `\DescribeMacro` (229, 244, 303), `\DescribeEnv` (277, 283), `\marg` and `\oarg` (247, 309), the `|...|` short-verbatim shorthand (199, 247; no `\MakeShortVerb` appears in the file), `\StopEventually` (574), the `macrocode` environment (582), `\Finale` (1308). Commented out and unused: `\DisableCrossrefs` (66), `\PageIndex` (68), `\OnlyDescription` (70).
- Documented but not loaded (recorded for the lib's later use, no way claimed): the ecv CV class (CTAN macros/latex/contrib/ecv, TeX Live; read at ctan.org/pkg/ecv: "ECV – A fancy Curriculum Vitae class", v0.3, licence "Free license not otherwise listed"). Its vocabulary as the manual lists it: options `german` `english` `empty` (234-236); `\ecvName` `\ecvPortrait` before `\begin{document}` (244-255); environments `ecv` and `ecv*` (277-285); entry commands `\ecvEPR` `\ecvEPB` `\ecvEFR` `\ecvEFB` `\ecvENR` `\ecvENB` `\ecvOVR` `\ecvOVB` (340-389); tag and value commands `\ecvTP` `\ecvTF` `\ecvTN` `\ecvVR` `\ecvVB` (303-331); section commands `\ecvSec` `\ecvBSec` `\ecvSub` `\ecvBSub` `\ecvERSub` `\ecvEBSub` (398-447); layout commands `\ecvPageBreak` `\ecvNewPage` `\ecvBreakParagraphs` `\ecvNewLine` `\ecvNewPara` `\ecvBold` (465-486); links `\ecvHyperLink` `\ecvHyperEMail` `\ecvURL` `\ecvEMail` (490-507); `\ecvSig` (263-266); localised strings `\ecvPerson` ... `\ecvAttachements` (515-544). The sample shows them only inside `verbatim` (163-195, 214-217, 336-338).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | ecvde.dtx.tex:58 | `class.ltxdoc` | no options; paper size, margins, running heads and heading looks are ltxdoc defaults, nothing in the sample sets them |
| doc driver switches | ecvde.dtx.tex:64, 65, 67, 69, 71, 77 | `dtx.doc` | `\CodelineNumbered`, `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\GetFileInfo{ecv.cls}`, `\DocInput{ecvDE.dtx}` (the file name is a string) |
| encodings | ecvde.dtx.tex:59, 60 | `font.fontenc-t1` | fontenc `T1`, inputenc `utf8` |
| language | ecvde.dtx.tex:62, 271, 294, 449 | `lang.babel` | `ngerman`; shorthands `"`` and `"'` for quotation marks (294, 449); `\today` prints a German date (271) |
| paragraph shape | ecvde.dtx.tex:73, 74 | `sp.lengths` | `\parskip1.0ex`, `\parindent0.0ex` |
| title block | ecvde.dtx.tex:82-87 | `front.maketitle` | `\title{\textsf{ecv}\\ Eine originelle Lebenslauf-Klasse}`, `\author{... \\ ...}` with two e-mail lines, `\maketitle` |
| footnotes | ecvde.dtx.tex:85, 115 | `fn.kernel` | `\footnote{...}` in the author block (85) and in the body (115) |
| change history | ecvde.dtx.tex:88 | `dtx.doc` | `\PrintChanges`; the doc part holds no `\changes` call (the only one, at 603, is inside `macrocode`), so the list is empty |
| abstract | ecvde.dtx.tex:90-94 | `abs.kernel` | `abstract` environment |
| headings | ecvde.dtx.tex:96, 131, 136, 158, 203, 227, 239, 258, 275, 287, 391, 460, 488, 509, 547, 576 | `head.kernel` | 16 numbered `\section{...}`, no lower levels, default numbering |
| lists | ecvde.dtx.tex:144-147, 233-237, 246-256, 308-318, 352-365, 514-545, 552-569 | `list.kernel` | `itemize` with `\item`, no nesting |
| verbatim | ecvde.dtx.tex:103-105, 118-120, 151-153, 163-195, 214-217, 336-338 | `code.verbatim` | `verbatim` environments; `\ecv...` command names in `|...|` (199, 247) |
| quotes | ecvde.dtx.tex:369-376, 451-458 | `quote.kernel` | `quote` environment holding `|...|` names separated by `\\` |
| macro documentation | ecvde.dtx.tex:229, 244-245, 277, 283, 303-305, 321-322, 340-345 | `dtx.doc` | `\DescribeMacro{name}` and `\DescribeEnv{name}` before the item they describe; `\marg{}` `\oarg{}` argument markup (247, 309) |
| code listing | ecvde.dtx.tex:574, 576, 578-1306 | `dtx.doc` | `\StopEventually{}` (574), `macrocode` blocks 582-1093, 1104-1149, 1160-1206, 1217-1302, DocStrip guard lines such as `%<*ecv.cls>` (579) inside `\iffalse`, `\Finale` (1308); the code is text |
| font switches | ecvde.dtx.tex:82, 85-86, 133 | `mark.kernel` | `\textsf`, `\texttt`, `\textbf` |
| manual spacing | ecvde.dtx.tex:114, 270-273, 333 | `sp.manual-space` | `z.\,B.` (114), `\noindent` and `\\[18pt]` (270-271), `\bigskip` (333) |
| inline maths | ecvde.dtx.tex:84, 85 | `math.kernel` | `$<$` and `$>$` around the e-mail addresses |
| not set by the sample | whole file | none | no page geometry, headers or footers, colours, floats, tables, captions, bibliography, contents list, or `\PrintIndex`: ltxdoc defaults only (`\CodelineIndex` and `\EnableCrossrefs` record index data that nothing prints) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| driver preamble | ecvde.dtx.tex:58-78 | nothing to reduce | package loads, doc switches and two lengths only; no `\newcommand`, `\def`, environment, counter or conditional |
| documentation prose | ecvde.dtx.tex:82-574 | nothing to reduce | no definitions; a search for `\newcommand \def \let \newenvironment \newcounter \RequirePackage` finds its first hit at 605, inside `macrocode` |
| ecv.cls source as code text | ecvde.dtx.tex:582-1093 | not loaded, not template here | typeset by `macrocode` (code text, content). The class is published (CTAN v0.3; the text here is v0.1, line 605), so if it were extracted and used it is one published class, not zip-local code |
| ecvEnglish.ldf, ecvGerman.ldf | ecvde.dtx.tex:1104-1149, 1160-1206 | same | `\def\ecvNLS@...` string macros, text |
| ecvNLS.sty | ecvde.dtx.tex:1217-1302 | same | option handling, `babel` load (1268), string aliases (1285-1301), text |

Reading of the embedded class, informative only (the sample does not load it, so none of this enters the component map). It is `\LoadClass[a4paper,11pt]{article}` (639) over geometry (`left=30mm, right=20mm, top=20mm, bottom=15mm`, 720), longtable (the `ecv` environment is a two-column `longtable` `p{.32\linewidth}|p{.68\linewidth}`, 836-847), fancyhdr (footer name and `Seite~\thepage` in minipages, 739-760), xcolor (730-731), helvet and `\sffamily` (675, 740), url and hyperref (707-712, 817), selinput, fontenc T1 (686, 697), babel through ecvNLS (1268), `\pdfcompresslevel=9` (645), and macros that print an entry only when its `[lang]` argument equals the class language, `\ifthenelse{\equal{#1}{\ecv@lang}}` (909-913 and about 35 more). If a reviewer instead takes this code as in-scope zip-local code, two places would need a ruling: that language guard (an emitter would resolve it by writing only the entries of the document language) and the portrait frame drawn with `\pgfrect`, `\pgfdeclareimage`, `\pgfputat` (763-769). I rate both as internals of a published class, as moderncv's internals are, and not as template artwork of this zip.

Compile caveats, unverified and not blockers: the driver calls `\DocInput{ecvDE.dtx}` (77) while the zip's file is `ecvde.dtx.tex` (different case and suffix); `\GetFileInfo{ecv.cls}` (71) names a file that is never loaded here; `\PrintChanges` needs the usual makeindex pass on the `.glo` file to print anything, a tool of every TeX distribution as BibTeX is for a `.bst` bibliography, and the list is empty anyway.

## Content-opaque
none (no figure, table or picture exists in the sample; the portrait placeholder code at 763-769 is code text inside `macrocode`)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
