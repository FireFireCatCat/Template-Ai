yes

# 0398-simple-article: Simple Article

- Unverified: read from the source, not compiled.
- Source: Source/0398-simple-article/ (origin: https://latextemplates.com/downloads/simple-article.zip; licence: CC-BY-SA-4.0, stated in ATTRIBUTION.txt:3 and README.md:25-31; the zip is based on an Overleaf gallery template by Duc A. Hoang, ATTRIBUTION.txt:4)
- Kind: misc (a generic research-article starter, no journal or venue style; the manifest hint is `article`)
- Lib: v4
- Engine: pdfLaTeX-compatible (README.md:14 builds with `pdflatex`; `inputenc` at main.tex:19; no `fontspec`)
- Look carried by: preamble (kernel `article` unchanged; the look is the preamble's package list, main.tex:8-46)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip holds one 156-line `main.tex` on the kernel `article` class, plus `references.bib`, a README and an attribution note; no zip-local `.cls`, `.sty`, `.def`, `\newcommand`, `\def` or environment exists (grep of main.tex found none). Every component maps to a published way with declarative parameters: `geometry`, `background` (a text-only notice, not artwork), `amsthm`, `natbib` with a BibTeX `.bst`, `hyperref` and kernel commands. Nothing needs a tool outside TeX and nothing is drawn by TikZ or PGF in the template's own code, so the answer is `yes`. The `background` package itself builds on TikZ and `everypage` (ctan.org/pkg/background), but the template passes it only keys and a line of text.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:1); 10pt, one column, `plain` page style and Computer Modern are the class defaults, not set in the file
- Class-native vocabulary used: `\title`, `\author`, `\and`, `\thanks`, `\date`, `\maketitle`, `abstract` environment, `\tableofcontents`, `\section`, `\subsection`, `\paragraph`, `\appendix`, `itemize`, `enumerate`, `table` and `figure` floats with `\caption`

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | a4paper |
| paper size | main.tex:1 | `page.class-options` | a4paper |
| page geometry | main.tex:13 | `page.geometry` | margin=1in |
| page-bottom licence stamp (every page) | main.tex:8 | `bg.background` | pages=all, color=black, position={current page.south}, placement=bottom, scale=1, opacity=1, vshift=5mm |
| stamp text, set via `\SetBgContents` | main.tex:9-11 | `bg.background` | contents = one line of text: typewriter text plus one link (content of the way; the line is plain text, so it is not `ART`) |
| stamp text font switch `\tt` | main.tex:10 | `mark.kernel` | `\tt` (kernel font switch) |
| stamp text link `\href{url}{text}` | main.tex:10 | `meta.hyperref` | `\href` is a hyperref command (external link); url = creativecommons.org/licenses/by-sa/4.0/ |
| input encoding | main.tex:19 | `font.fontenc-t1` | `inputenc` option utf8 (no `fontenc` and no text-font package loaded; default OT1 Computer Modern) |
| PDF metadata and link options | main.tex:20-29 | `meta.hyperref` | unicode, pdfauthor, pdftitle, pdfsubject, pdfkeywords, pdfproducer={LaTeX}, pdfcreator={pdflatex} |
| display maths | main.tex:15 | `math.amsmath` | no options (loaded, not used in the body) |
| math symbols | main.tex:17 | `math.amssymb` | no options (loaded, not used in the body) |
| script letters | main.tex:46 | `math.bm` | `mathrsfs`, no options (loaded, not used in the body) |
| theorem package | main.tex:16 | `thm.amsthm` | no options |
| theorem styles and declarations | main.tex:34-42 | `thm.amsthm` | `\theoremstyle{plain}`: theorem, corollary, lemma, proposition; `\theoremstyle{definition}`: definition, example, remark; all share the `theorem` counter via `[theorem]` |
| theorem and corollary in body | main.tex:91-94, 99-102 | `thm.amsthm` | `theorem` and `corollary` environments; labels at 92 and 100 |
| proof environment | main.tex:95-97 | `thm.amsthm` | `proof` (amsthm), default QED mark |
| title block | main.tex:48-57 | `front.maketitle` | `\title`, `\author` with `\and`, `\date` carrying two affiliation lines, `\maketitle` |
| author note | main.tex:49 | `front.thanks` | `\thanks{...}` |
| affiliation line breaks in `\date` | main.tex:52-53 | `sp.manual-space` | `\\`, `\\[2ex]` (the affiliation text and `$^1$` marks are content) |
| monospace e-mail text | main.tex:52-53 | `mark.kernel` | `\texttt` |
| abstract | main.tex:59-67 | `abs.kernel` | `abstract` environment |
| keyword line | main.tex:66 | `abs.keywords` | `\noindent\textbf{Keywords:}` followed by a list, inside the abstract |
| bold run-in text | main.tex:66, 118 | `mark.kernel` | `\textbf` |
| table of contents | main.tex:69 | `toc.kernel` | `\tableofcontents`, no options |
| sectioning | main.tex:71, 78, 84, 131 | `head.kernel` | `\section`, `\subsection`, default numbering and look |
| run-in paragraph heading (acknowledgements) | main.tex:143 | `head.kernel` | `\paragraph{Acknowledgements}` |
| appendix | main.tex:148-150 | `num.appendix` | `\appendix`, then `\section` |
| labels and references | main.tex:72, 79, 85, 92, 100, 126, 132, 140, 151 | `xref.kernel` | `\label` at those lines; `\ref` at main.tex:101, 135, 150 |
| starred reference | main.tex:129 | `xref.hyperref` | `\ref*{tbl:1}` (hyperref's no-link variant) |
| itemised list | main.tex:104-107 | `list.kernel` | `itemize`, default bullets |
| enumerated list | main.tex:109-112 | `list.kernel` | `enumerate`, default labels |
| table float | main.tex:114-127 | `tbl.tabular` | `table` float placement `[ht]`; `tabular` columns `{|c|c|}`; `\hline` and `\hline\hline` rules (kernel, no `array`, `booktabs` or `longtable`) |
| table centring | main.tex:115 | `sp.ragged` | `\centering` |
| table caption | main.tex:125 | `cap.kernel` | `\caption{An example table}`, default style |
| figure float | main.tex:136-141 | `fig.graphicx` | `figure` placement `[ht]`; `\includegraphics[width=0.3\textwidth]{example-image}` |
| figure centring | main.tex:137 | `sp.ragged` | `\centering` |
| figure caption | main.tex:139 | `cap.kernel` | `\caption{An example figure}`, default style |
| graphics and colour packages | main.tex:44 | `fig.graphicx`, `color.color` | `graphicx` (used), legacy `color` (loaded, no colour command in the body) |
| algorithm packages | main.tex:45 | `alg.algorithmicx` | `algorithm` and `algpseudocode`, no options (loaded, no algorithm in the body) |
| citation package | main.tex:31, 88-89 | `bib.natbib` | options `sort&compress`, `numbers`, `square`; body `\citep{HararyR74}` and `\citep{Berge57,Berge58}` |
| bibliography | main.tex:32, 146 | `bib.bibtex-bst` | `\bibliographystyle{plainnat}`, `\bibliography{references}`; database references.bib:1-23 (one `@book` x2, one `@article`; content) |

## Bespoke code
none. main.tex defines no macro, counter, conditional or environment; its only declarations are `\newtheorem` (main.tex:35-38, 40-42, reducible to `thm.amsthm`), `\theoremstyle` (main.tex:34, 39), `\hypersetup` (main.tex:21) and `\SetBgContents` (main.tex:9, a `background` package command). `\date` is used to hold the affiliation lines (main.tex:51-54); that is a content choice, not a redefinition.

## Content-opaque
none. (The figure uses `example-image`, main.tex:138, an image that ships with the TeX Live `mwe` package rather than in the zip: a missing asset, noted, not a blocker.)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes: the `background` package notice is the only unusual item. It is text positioned by a TikZ node name (`current page.south`), so it is a keyed way, not template artwork. In the file order `background` loads before `hyperref` (main.tex:8, 20) and `\href` sits in the stamp text (main.tex:10); an emitter only needs to keep that line order or move the stamp text after `hyperref`, since the argument is stored and expanded at shipout. Several loaded packages are unused by the body (`amsmath`, `amssymb`, `color`, `algorithm`, `algpseudocode`, `mathrsfs`); they are recorded because they are part of the preamble the emitter would have to print.
