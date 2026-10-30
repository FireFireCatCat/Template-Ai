yes

# 0197-unbtex-university-of-bras-lia-thesis: UnBTeX (University of Brasília Thesis)

- Unverified: read from the source, not compiled.
- Source: Source/0197-unbtex-university-of-bras-lia-thesis/ (origin: https://latextemplates.com/downloads/unbtex.zip; licence: LPPL-1.3)
- Kind: thesis
- Lib: v4
- Engine: pdfLaTeX-compatible (main.tex:8 gives the order pdflatex, bibtex, pdflatex, pdflatex; the CTAN page says "compatible with pdflatex and BibTeX"; the class source was not read)
- Look carried by: class (the sample sets only the class options and fills the class's own commands; page, fonts, spacing, headings and contents formatting live in the unread class)
- Class origin: tex-distribution-unbundled (`unbtex` is on CTAN, `ctan.org/pkg/unbtex`: v1.6.6, LPPL 1.3, "based on abnTeX", contained in TeX Live and MiKTeX; the zip ships no `unbtex.cls`)
- Main file: main.tex (other samples: none; chapter1.tex and chapter2.tex are `\include`d chapters)
- Read: main yes, zip-local classes and styles partly (the zip has no `.cls` or `.sty`; the one zip-local style file, `unbtexcite/unbtex-alf-en.bst`, was outlined and its header, output, label, entry-type and default parts read, not every line; the CTAN class `unbtex` is not in the zip and was not read)

## Verdict
The look is carried entirely by the published CTAN class `unbtex`, which the zip does not bundle, so its source was not read (rubric: a published class not bundled in the zip is one way, `class.unbtex`). The sample adds only class options, the class's own front-matter commands and environments, kernel sectioning, a list, `\cite`/`\ref`, two load-only packages (`lscape`, `afterpage`) and `\graphicspath`; it defines no macro, environment or counter. The one zip-local file is a BibTeX style, an English adaptation of abnTeX2's `abntex2-alf.bst`; by the lib line `bib.bibtex-bst` ("the style is a parameter") it is the parameter of that way and is shipped as an asset. `yes` rests on those two points; a reader who counts a zip-local `.bst` of about 2160 lines as bespoke would flip it to `no`.

## Blockers
none

## Class setting
- Class: `class.unbtex` options: `oneside`, `idioma=english`, `bib=alf`, `refback`, `num=tradicional` (main.tex:10-16; the meaning of the last four lives in the unread class)
- Class-native vocabulary used: title data `\titulo` `\tituloestrangeiro` `\autori` `\autorii` `\numerocutter` `\orientador[Advisor]` `\coorientador` `\tipotrabalho` `\tipocurso` `\preambulo` `\publicacao` `\instituicao[..]{..}{..}` `\local` `\dia` `\mes` `\ano` (main.tex:25-46); committee `\membrodabancai`..`v` and `\membrodabancai`..`vfuncao` (main.tex:48-57); environments `Resumo` `Abstract` (main.tex:59-78), `AgradecimentosAutorI/II` (main.tex:94-103), `DedicatoriaAutorI/II` (main.tex:105-110); keyword commands `\pchavei`..`v` and `\kwordi`..`v` (main.tex:80-90); `\idiomaagradecimentos{english}` (main.tex:92); matter switches `\pretextual` `\textual` `\postextual` (main.tex:112, 130, 135); printers `\imprimirfolhaderosto*` `\imprimirfolhadeaprovacao` `\imprimirdedicatoria` `\imprimiragradecimentos` `\imprimirresumos` `\imprimirlistadefiguras` `\imprimirlistadetabelas` `\imprimirsumario` (main.tex:114-128). Empty slots are given as `{}` (second author, co-advisor, committee members iv and v, Portuguese keyword v, English keyword v).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:10-16 | `class.unbtex` | oneside, idioma=english, bib=alf, refback, num=tradicional |
| page layout option | main.tex:11 | `page.class-options` | oneside (the margins themselves are set inside the class, not in the sample) |
| defaults not visible in the sample (page geometry, fonts, line spacing, running heads and page numbers, heading and contents formatting, language packages, hyperref use) | main.tex:10-16 | `class.unbtex` | set by the class source, which is not in the zip and was not read |
| language | main.tex:12, 92 | `class.unbtex` | `idioma=english`; `\idiomaagradecimentos{english}`; the English main language with Portuguese `Resumo` is stated at main.tex:3-6 |
| title page (cover data and sheet) | main.tex:25-46, 114 | `front.class-native` | `\titulo`, `\autori`, `\orientador[Advisor]`, `\tipotrabalho`, `\preambulo`, `\instituicao`, `\local` `\dia` `\mes` `\ano`; printed by `\imprimirfolhaderosto*` |
| approval page | main.tex:48-57, 116 | `front.class-native` | five committee slots with role strings, `\imprimirfolhadeaprovacao` |
| matter division | main.tex:112, 130, 135 | `front.class-native` | `\pretextual`, `\textual`, `\postextual` |
| contents and lists | main.tex:124, 126, 128 | `front.class-native` | `\imprimirlistadefiguras`, `\imprimirlistadetabelas`, `\imprimirsumario` (class printers; the lists print with no entries because the sample has no float) |
| dedication, acknowledgements | main.tex:92-110, 118-120 | `front.dedication` | environments `DedicatoriaAutorI/II`, `AgradecimentosAutorI/II`; printed by `\imprimirdedicatoria`, `\imprimiragradecimentos`; second-author environments left empty |
| abstracts | main.tex:59-78, 122 | `abs.class-native` | `Resumo` (Portuguese) and `Abstract` (English), printed together by `\imprimirresumos` |
| keywords | main.tex:80-90 | `abs.keywords` | `\pchavei`..`iv`, `\kwordi`..`iv` (class commands; slot v empty) |
| chapters and sections | chapter1.tex:1, 11, 17, 30; chapter2.tex:1, 4, 10, 16 | `head.class-native` | `\chapter`, `\section`; numbering look set by the class option `num=tradicional` (main.tex:15) |
| file inclusion | main.tex:132-133 | `struct.input` | `\include{chapter1}`, `\include{chapter2}` |
| lists | chapter1.tex:19-28 | `list.kernel` | `itemize`, three items |
| cross-references | chapter1.tex:2, 31; chapter2.tex:2 | `xref.kernel` | `\label{cap:intro}` `\label{cap:related}`, `\ref` via `Chapter~\ref{..}` |
| back-references in the bibliography | main.tex:14 | `class.unbtex` | class option `refback`, effect inside the unread class |
| citations | chapter1.tex:9, 15; chapter2.tex:8, 14 | `bib.apacite` | `\cite{Jensen2017}`, `\cite{Pelkonen2015}`; the citation package is inferred to be abntex2cite (a standard-specific citation package, which the lib's `bib.apacite` line covers, as in the lib v1 log) from the `.bst` output `\hiddenbibitem`, `\abntrefinfo` (unbtexcite/unbtex-alf-en.bst:1378, 1385); the class loading it was not read |
| bibliography | main.tex:137; references.bib:1-17; unbtexcite/unbtex-alf-en.bst:1-9, 2132-2161 | `bib.bibtex-bst` | `\bibliography{references}`; style `unbtex-alf-en` (author-year, English strings, zip-local adaptation of abntex2-alf.bst); the sample has no `\bibliographystyle`, so the class issues it (class option `bib=alf`; not read); entry types `inproceedings` and `article` |
| landscape pages | main.tex:18 | `pg.landscape` | `\usepackage{lscape}`, loaded and never used (no `landscape` environment in the body) |
| float flow | main.tex:19 | `pg.afterpage` | `\usepackage{afterpage}`, loaded and never used (no `\afterpage` in the body) |
| image search path | main.tex:21 | `fig.graphicx` | `\graphicspath{{figures}}`; the `figures` folder is not in the zip and no image is included (missing asset, noted) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `unbtex-alf-en.bst`, BibTeX style, English adaptation of abnTeX2's `abntex2-alf.bst` v1.9.7 (LPPL 1.3) | unbtexcite/unbtex-alf-en.bst:1-9, 11-15 | yes | A `.bst` is run by BibTeX, not typeset by TeX; it formats `\bibitem` entries (output.bibitem, :1369-1380), sets English strings (bbl.*, :241-293) and defaults for the abnTeX2 option variables (:2040-2076), and emits `\begin{thebibliography}` plus `\providecommand` lines for abntex2cite macros (:2132-2161). It is the parameter of `bib.bibtex-bst` (`\bibliographystyle{<path>/unbtex-alf-en}` and the file as an asset). One quirk to keep: the file name decides the alphabetic variant (`abnt.alf` is set by comparing the RCS file name with `unbtex-alf-en.bst,v`, :2044-2046), so the file must keep this name. Whether the CTAN `unbtex` bundle ships this same file was not established. |
| `\graphicspath{{figures}}` | main.tex:21 | yes | a graphicx command, not a definition; the directory is the parameter |

No `\newcommand`, `\def`, `\newenvironment`, counter or conditional is defined in main.tex, chapter1.tex or chapter2.tex. No text in the zip is addressed to an AI; the comment at main.tex:3-6 only explains why a Portuguese abstract sits beside the English one.

## Content-opaque
none (no figure, table, TikZ picture or equation in the sample; the bibliography entries are content)

## Lib changes
- New ways proposed: none (every component maps to an existing way; `class.unbtex` is written plainly, per the rubric)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
